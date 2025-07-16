Return-Path: <linux-kernel+bounces-733162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F70B07108
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899421895ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7004B2EF9D0;
	Wed, 16 Jul 2025 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNIbr+GN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697162BEFE2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656392; cv=none; b=cKaZYSu/3VsZSR33OVLnKdnGOxig6yn3X9JoF8l5cNaF/r8+DXYKgeZmwC/CAxFLFbELdLqtzD37ixZU0lz1jswmKnojCkwiriJHqsXdw2C06O1e+2k3AePQr666YG61D2Qm80SaKTqWHVDBwxpvfcKQ41C+UwZjqjJx8Ut7SEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656392; c=relaxed/simple;
	bh=rYiazEuw3scjsu8vgivyrSqTbYtX4ZfFIDqZ6D7u1m8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2j66WlDS6THehmmJPtwgfRsZUjiX8e/92QUgZK6u9CYJhefD9gesI2+Wb5bsvWtx1BYd5ukvfLbjAXyBd9ocO5tRzNK41qZVsZKlW+0X1FvXZHX4Xm66Ee8OyIhcXSwjGg0EdFoUWtZdJxlHIrbQMIBvB/MXllbYEKPhkTIqgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNIbr+GN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752656390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rYiazEuw3scjsu8vgivyrSqTbYtX4ZfFIDqZ6D7u1m8=;
	b=KNIbr+GNaaOWfNToA6UArZBpkqayNpewOefffu/jkHUszEJFOMn49KlnncLffaYmTYfibm
	OokT+NukEr/0Do08TyXMtOJp2rKx/LmFttVyKOUvwHCsWwAitZB7vUGjZ88AOMR8O8U6eY
	FwU98VfynXqDDtFb2b5iFlcuFxpToBc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-VCXKO99oO0e-iX3RDuFt7Q-1; Wed, 16 Jul 2025 04:59:48 -0400
X-MC-Unique: VCXKO99oO0e-iX3RDuFt7Q-1
X-Mimecast-MFC-AGG-ID: VCXKO99oO0e-iX3RDuFt7Q_1752656387
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-454dee17a91so49546855e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656387; x=1753261187;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYiazEuw3scjsu8vgivyrSqTbYtX4ZfFIDqZ6D7u1m8=;
        b=s/XdVbMEIuGh/yilt4ifzxCzE4KnxxSCLKE3eZNyGAE89o9aYsChBBrfh0lcLPLmui
         nSuc36z40laMQw4wvcGtjPft70309sdZ7vW6dX/WOfAYYs9k1viuFFpJV8650tc49nua
         X9edcpztlDH7C6p4IMXPT3q78f+liNUAwisbj2Ljo1tzqif64hB9qUJWUmvLIHvY4Ro8
         gYdd9fHVUZGvNB+ZPdFdDKWQe3IevQRvDuTjEeAdjhvlBZeOBAqgAJ/6CjspS7bDfuIg
         wDTc/KWyIhhOQk3wd5i09iRuMesZ1SBZCMFwhf4hj2i/o5Wr3s9K5gOg8RW+fT12Eqct
         p67g==
X-Gm-Message-State: AOJu0YyvOUyVJVkp0AWUYz7yesUsyT6f4ZJkJfpyMh7zzLMRz8vS5aPa
	Jg+D+TevjBrk45723jMQcbxDjBAd1/4elshqyIuFdxRrmS+AFV7JXD0lgHmnJF3+8XcifIlb+Ym
	IuW5LmFRpqv+Kic4NJewtxhLH+COi4yiQAkd1N6c3TcGK7dSg0+BVgJkWq/h59LlQWg==
X-Gm-Gg: ASbGncu78v4lRH0/YZIzi7iQP3q7q4EHrx4p8E1hsqwQDfxxQZhaWB/9Rea87yLqYFO
	ctiDQaKFyFnD3kEQ2ISBlV9/zh7+28sDIXg0oZiurxXWg0NDVrrXTT+12BwQu5OEFlh/66ew0RR
	/v+0qwz9ay5s8/owBs/eYj98GFACHmdFYPwGQi+xPBsKsZbG1YgM2W9S9RF7Fvcw1PQV1aNbrSQ
	jBTfmGpMIohN426UNKGP1e1l9lCUm/NSrOctvqzTajuUCFT5CviVyfhKfpJgeq0Q4bzmrg18uWl
	tmR5b7/h14fBoAC1IBCNeYENO8aAklmiRteDI9Bs/OOjP/JHUld7ZI+W5lvTEqspfA==
X-Received: by 2002:a05:600c:5486:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-4562e39b9a1mr20121785e9.16.1752656387495;
        Wed, 16 Jul 2025 01:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvh4XGqgjiXRNpbWt+0e4yPX9fyRdtuorAJBNJIz/t3WeV48Yv6FM74WTtdQhrUxK0tGt86A==
X-Received: by 2002:a05:600c:5486:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-4562e39b9a1mr20121435e9.16.1752656387029;
        Wed, 16 Jul 2025 01:59:47 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0dbddsm17513367f8f.63.2025.07.16.01.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:59:46 -0700 (PDT)
Message-ID: <37bc7ab78b03f4e794a5466d9cc0a1e187e1ae72.camel@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Retry when da monitor detects race
 conditions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>,  Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 10:59:44 +0200
In-Reply-To: <20250716084520._QLbd5AY@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-12-gmonaco@redhat.com>
	 <20250715152322.Os4lDq_B@linutronix.de>
	 <e2f4f8d372612cd61689b91562e73677599d08de.camel@redhat.com>
	 <20250716082712.L9z_ptHK@linutronix.de>
	 <f7028488e9d820848955de87ead3ec619fe5dbec.camel@redhat.com>
	 <20250716084520._QLbd5AY@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Wed, 2025-07-16 at 10:45 +0200, Nam Cao wrote:
> On Wed, Jul 16, 2025 at 10:38:11AM +0200, Gabriele Monaco wrote:
> > Yes you can, but I wouldn't do so silently.
>=20
> Why not? The absolute worst that we get, is the rare case where a bug
> appears at the exact same time. In that case, we would get a false
> negative.
>=20
> And I think that is really really rare.

Well, we wouldn't even know how rare it is because we don't track it!

It may be a harmless note but might also be a design flaw in the
monitor, so it should be possible to understand when it happens.

> Yes, if you really want to emit some sort of warning here, it should
> be
> absolutely clear that the monitor itself is having a hiccup, not the
> monitored kernel.

Yeah totally, not saying that other errors reported in the wild are
going to be necessarily the kernel's fault though ;)
But let's keep these cases separate going forward nonetheless.

Thanks,
Gabriele


