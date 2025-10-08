Return-Path: <linux-kernel+bounces-845213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3160DBC3E73
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B4019E17E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE782F3C23;
	Wed,  8 Oct 2025 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwZTc/4z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A52F1FC1
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913218; cv=none; b=a3y96vx4snury7WUGEkjoQuIQ+LvSwcOPO34TAYoLybP6JMtH9LZWr0Lz+2dlE+9RI5ZW6Tti9stE465C1X8TFbKzvIjh3Dfgd7HnxLi29GZIfNZWpTvHGTpaUMChUw+GR5sIeOPTrjuCGw6lyLmApXfWe+I82WGgsqUdFwpdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913218; c=relaxed/simple;
	bh=ULMfWMU0T85agFvyEZ1h2u0irkQ15gdqE/R52DoIKuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DhZ2mzqr8kdj+slb5Mhrsg6vy/DqxS8QJlJHoIon76Nq5JYxR6+TJxtVFnaLf9yYlRPk7zYk9mLtg4mEfV/JX2+yPD+pAA3X8WOLVccNex71LZpjq7CGU3WkXU2/GkOE+UUKuHDZ4BvbgbJKvHB1sc8CFWcalA/nPG0ShP4sgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwZTc/4z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759913215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULMfWMU0T85agFvyEZ1h2u0irkQ15gdqE/R52DoIKuc=;
	b=dwZTc/4zKppmmNg2E6gkkgLfzGydLx1qaeZGh+W4OmkeZhdKRwm72+9hdpNFEJ1krB4VbH
	63nENzusCtV+SgfqZQm+yFqTQBtWiw3OIpgd1c1RJEuaKWR46IGMs7/Z8GY3heXqrlwfhT
	wRzQebIE2uu1BWwMMuCg5PPm9yF7xW4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-OYV5nOhDMNGszhg_UgIvFg-1; Wed, 08 Oct 2025 04:46:53 -0400
X-MC-Unique: OYV5nOhDMNGszhg_UgIvFg-1
X-Mimecast-MFC-AGG-ID: OYV5nOhDMNGszhg_UgIvFg_1759913212
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b2d1072a9c4so537463766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913212; x=1760518012;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULMfWMU0T85agFvyEZ1h2u0irkQ15gdqE/R52DoIKuc=;
        b=veG5/9H1vJ0zKknkKaUGfkt9hFpjp61AqaIZSH7Oco1NWap/YPoSdBDeAAXRmKAFq1
         Nluio4rWiQ2S4WNnA2I5BAJi9nDp3ME1QJl+aG8yH/JzmMeFnHriKsYC/P6594W0gmtL
         FQaDe1XqQGguxuUtwdH6nHWtNyx4chebolAAsMnBlSYl7Hh3ymwb7FSNx3CbQfYIO46Y
         ao2yE652K4oAp1f5JaE0ieTET4Rtyt+zvy2y+8xJ+WWnZownr6Xt3eV2Ewhp5J6f+Nyu
         SQEG3peV4+GLzAkL099W3hryf3u2r6a/yq5LAMFHOlVX6Os/g4JaqMz8T4l3VdxX2YFy
         W75A==
X-Forwarded-Encrypted: i=1; AJvYcCVZpA0++R5NfS8g4k36taZzspv6PFbAIjihjQsaipdj+a87NEWKJA91OslU6Pml6oxX9j8Pkc6BTY/P6YU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+a8mXR9btY2f/csZysfjdklrQPBk0TCIGOhLrqNKadf08+SxX
	LCiENsXhfDdZmToslkzu1dTn0jKkVjT8M28s1HKTLAvmDyko30b6egrOD/2aBGzascVWljwnBvp
	kClvgJwX3iFtHTxSSMfGpyYhwZGBjMNsAYmNalweR4E2og0oKm8FI09vHySsH2OgTToTJXSz82H
	AcnYvg7E4PsV6Cjd1dwQLeeU7akOxljTNDZcX7d5UZ
X-Gm-Gg: ASbGncvjUy+3bTmKhzGviTfmszvVFN6LFCxIJjutVj1NjMFo3GfchfvVhBmpdVRVNsB
	OJbuF+8s2NtsLqA9tAJnm7p0RqaQ2wG9ScAkqkBkoEfa04kCKLe7rH9rIVC6OtMcYMckSLsF+zp
	D4OvjyUut4whgAFBXgSfOppybB4V1nboSBFCnlQpAE5yIObhTGzNdrwmyRSr9a
X-Received: by 2002:a17:907:948f:b0:b07:c90a:8ade with SMTP id a640c23a62f3a-b50aa08f896mr295154466b.20.1759913212224;
        Wed, 08 Oct 2025 01:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVcZ1mjgGaelpWwtZ6gpgMjo65EHWgM1o6rqW0IbqucKIMYpE+E3ROn5CCMNi7oOFALlDBWH4ivEgsnq/G8cU=
X-Received: by 2002:a17:907:948f:b0:b07:c90a:8ade with SMTP id
 a640c23a62f3a-b50aa08f896mr295152466b.20.1759913211873; Wed, 08 Oct 2025
 01:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008064500.245926-1-costa.shul@redhat.com>
In-Reply-To: <20251008064500.245926-1-costa.shul@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Wed, 8 Oct 2025 11:46:15 +0300
X-Gm-Features: AS18NWBeVVYLlbrC5IqWDYSODiNJT5qTfejGMybMGTCpJ65ymvSl8i5kXXz0c3c
Message-ID: <CADDUTFyVOzhjiqAzDHKKCprWLvq6Ww_V4rcyjDyzs5FCwXTvRA@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Add missing --quiet option to timerlat hist
To: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 09:45, Costa Shulyupin <costa.shul@redhat.com> wrote:
>
> The --quiet option is available in all other rtla tools and documented
> in the usage string, but was accidentally omitted from timerlat hist.
>
> Add the missing --quiet option to timerlat hist for consistency and to
> avoid confusion when silencing its output.

Actually, osnoise hist also lacks the --quiet option, and this appears
to be intentional.


