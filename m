Return-Path: <linux-kernel+bounces-780266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD8B2FF9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5401CE4C14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAC1271479;
	Thu, 21 Aug 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RF3mvXwt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AEB1C7012
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791934; cv=none; b=K9yE3WmBk9AvWI1MESY4o5h2Ovqw4Vlxz+eDQqMu5dIfikJ+RtR4ovaWnj6yDmMxqG7lXxNJY9GQfL/GckAVMrMse6CYPvdrxdYLSokQeM74uoNiSv7RsnRgGqFRJZXyJn27b1mIa5oitZcXxY2BEh8Zmt/vCmgXpuGxZgaam1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791934; c=relaxed/simple;
	bh=5/SnjsgkA/UaUZ3JC4oigWQ1yxAHzclLIHuSLceWJP4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lzY6rSMtqKRLjV0h89AZuUMgDl+4AIwlRMBCRFw67G/HpzfYKur6iYf41NFbFJOKIKe0ywo7UtUn3XGIbhSPxZGhhQV5rV3KBVYo2fhda4OUIiicO/X+UOx69iNXRQ1XATxXhevFis3AFMr1gsc95rrqJ8/++1AiRNy6woB69jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RF3mvXwt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755791932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/SnjsgkA/UaUZ3JC4oigWQ1yxAHzclLIHuSLceWJP4=;
	b=RF3mvXwtEtrQNdCZOW6kWmIiTsJKWli6ci/l7mVHCtYym5jfvmd3FEfSEaMHFrh2s8s8Bm
	bIkA92hXyj4zi8ag7ipTVeoMeBbb7Oz08H07p83cKgLsdwCWspPm3raAkkIIK6aVAC1cQO
	rGJkVMLNZGJ2YKgLh28/qL/+pkcDsk8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-ceKtSw_-P3uwM7BDbZBf-A-1; Thu, 21 Aug 2025 11:58:50 -0400
X-MC-Unique: ceKtSw_-P3uwM7BDbZBf-A-1
X-Mimecast-MFC-AGG-ID: ceKtSw_-P3uwM7BDbZBf-A_1755791929
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-618ba563d06so1162822a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791929; x=1756396729;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/SnjsgkA/UaUZ3JC4oigWQ1yxAHzclLIHuSLceWJP4=;
        b=fNTw1kKh6UKz4PLx8CMAVuq/T6WvvbCLyqAtDQr8ial54mSU67iuvTlcVkj6IaKHZc
         DL03uernpzM+8nBXPzSCLODKuyLLFf7pfsGPgoF0xX0KLKOUS3jze6C7rRc/I/vQmJgp
         PpePFt5s2sXngC6CkC3ysZv39fYAT3IxZbf9qzW4yUNTRDc4y3zdlp9uO8j53wXcouFx
         NO2kmWOs91yoTW+Vu1o1bOr5bVbFBo7CROxaVP64msIGwKYwTR6ZNC6I/q652WZH05x7
         uIZ00F7p5usFu7oj4G6i6TGjPT/cd4lCmOKZLgWFT1B/RErKHdNpLsih7Qrw+6V0oP53
         4Rwg==
X-Gm-Message-State: AOJu0YzmcrB8hFs3iittKG3eQ+lGEsnFkqqtEAtFTkUqZ1rrObNHKodE
	Eyhk+t2UybHLfAb7R4yxQSd4Wzc8gIOzb79X8j7hgjA7Hp9ZUPpoWuFfe1R9euoz9u/gKTOsgAC
	LI6Vs/AMASQ6U3mZS5pmtzbZap+ygSveepcub9X0C1AamjrZyvO9XMv5btDFJ0AODKQ==
X-Gm-Gg: ASbGncsRvjtoKBAbkoQyD8POkfGNR2+jbWpcwUNh95KDGiXojL33z3jY+pt/A/A5bj3
	l/Q6mL1iDGAIG3HAvXlX7XjQvFsZ24nTwGUWQ8l/8C2TO7zp82b0QC6crO8jKuQOzWl63ieDTP5
	9oXCNkq+ZNzFhB6JASnj4OfLw9rWSpJ5ClxxcJickEpwYNJbYzdpzNAvAyWoPObqQ86SZeST+Ea
	Bs41MThKGq7r8gh2Bh4pVYcdas/0PVjIlwvV5cC8e4FRRQ7RdV+hTWpcviI7QpjRz+XmcMtpWt5
	uGQOdTQ442TmBLYp9bII7StOAlyhEDgM7rpv5g==
X-Received: by 2002:a05:6402:27c7:b0:617:eb8d:283b with SMTP id 4fb4d7f45d1cf-61bf87358b6mr2481418a12.26.1755791929360;
        Thu, 21 Aug 2025 08:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp+TbWBjRz/vgVIUh4CpqYS7mcK0j2z1ICJqJZjorEFJDVQ4M9TuP25ILrNA9TDvFL68e5cQ==
X-Received: by 2002:a05:6402:27c7:b0:617:eb8d:283b with SMTP id 4fb4d7f45d1cf-61bf87358b6mr2481403a12.26.1755791928945;
        Thu, 21 Aug 2025 08:58:48 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.134.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c1851ee65sm1045a12.13.2025.08.21.08.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:58:48 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:58:45 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Message-ID: <a3a7da4d-abec-4318-b326-39d55eb9bc30@redhat.com>
In-Reply-To: <20250821151520.nc0hALIW@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com> <20250814150809.140739-10-gmonaco@redhat.com> <20250821122210.B9iAsUFG@linutronix.de> <a87d09f61a873778fe9f737ea4ab7c62dc43e950.camel@redhat.com> <20250821151520.nc0hALIW@linutronix.de>
Subject: Re: [RFC PATCH 09/17] verification/rvgen: Allow spaces in and
 events strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <a3a7da4d-abec-4318-b326-39d55eb9bc30@redhat.com>

2025-08-21T15:15:36Z Nam Cao <namcao@linutronix.de>:
> We could also rewrite the parser using ply with a well-defined grammar an=
d
> tokenizer, like how the LTL parser is implemented. Doing it this way woul=
d
> be easier to validate as well, because the grammar would be mostly
> copy-pasted from the specification.

Good idea, I can look into that and see how hard it's going to be (I'm not =
familiar with ply, but I see it's well documented).

>> Do you have specific examples of what doesn't work?
>
> Two things that I can remember:
>
> =C2=A0 - breaking long lines
>
> =C2=A0 - C-style and C++-style comments
>

Yeah those could break some assumptions (and they shouldn't), especially th=
e line breaks.. And supporting it in the current parser may make it just ug=
lier..

Thanks,
Gabriele


