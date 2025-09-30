Return-Path: <linux-kernel+bounces-837497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BE1BAC71E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21C03A4E81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025772F659A;
	Tue, 30 Sep 2025 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jt3Q9+GP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1939220687
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227505; cv=none; b=Wk+zY+z0JS/sOcMQVNVRMIlgl0A/nIIZXt2c16pfyqXPvSqfUYfIyLmPrFBUyxPqAsj43Kgc7ub0tKsYNnLMmETkbaGFMeihpgCvbEoYFa6HgYkZvM8e3tnDdQ6Lez1lIfVbtB3z1UGZ6l4DipYRPhOHjiavNusXNwTVosXQyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227505; c=relaxed/simple;
	bh=T4JncsrSUksxopSuhv4R2nt13jY1i1IQ+gZtPzGKiNQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWxXuH2J531OllRWscneKZrhSRN3yvG3a6T187oUIBAL1dIJHaxLb+reyq9ZT2XZiwH+fgvgLRAc1VqBvt7m9UEVudrkgi6WUefY546ipEdGaraqCtGDS6UeMnQc5iR+XhJKPyD+OhfpTD2FCinLwUxbA3VUuie9hVGq5Gy20qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jt3Q9+GP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759227503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T4JncsrSUksxopSuhv4R2nt13jY1i1IQ+gZtPzGKiNQ=;
	b=Jt3Q9+GPiSOjcvHgTjehE7DyAYKYaNpVodha9ehIT/EvsW3smr3KHUTMKYDE8YMtYzwKZ4
	BRMaoeae1Oj9NCdlc8xxRnHg1aWkzX+Jc4vHihyqwFZpGYPJWUvhjxfC8KkgWzi1LPfceU
	sGQZPQ+hr9cEHeVWHp1XjtXmz6zZJFk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-E6y4YN_9NHu3yGUUiom8-g-1; Tue, 30 Sep 2025 06:18:21 -0400
X-MC-Unique: E6y4YN_9NHu3yGUUiom8-g-1
X-Mimecast-MFC-AGG-ID: E6y4YN_9NHu3yGUUiom8-g_1759227500
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3efe4fcc9ccso3573029f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759227500; x=1759832300;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4JncsrSUksxopSuhv4R2nt13jY1i1IQ+gZtPzGKiNQ=;
        b=B28UVnCWfhs/QMo1/agFh8kIN3NV+2vJzRMHmphUtKEozywtz+TZs5SjEZ04fG5wzF
         ThO3lM9TtWjUacIm9lXDnXoef3QIhpPhmzc6bSI1c2ds6u6dD4/FQm6XweahIxU+DJLl
         jzioe5PXAcTV8UaKJQyYUmAAWf2y21LtOzIYRQ09t4AC+BcxPnpK+cGwRpBNLJItBIUW
         6xWYdwmZveLXLHy0T7uKiKB4Af1x87PpsBlxNSteAP2rPxyDP2XXan3s4yGd8M4Km6qI
         YW5Shznbmgt2kZMF34VO+hzxUX86jt9XmUxibLIIs9fvZkKbAP6l6WKS1uY+BFKd1cS1
         UBYQ==
X-Gm-Message-State: AOJu0Yw1dgEGHhzRTNiihGUx2jVvuiajNxtlfa+HmMBAoTmvQ5pOV4K+
	hPNnAlHLlCMsjSP7/QAxFO48gZLniY1xulWdVI4QtJA37lyAsjHdFU5jkat5FcUXRL6f3vvhh5Z
	L6gkD5JsZOzGKx3wSbvfZjiuz8gSTzO4/o9QawCLmHeEN84H8jON3OOwAarwZ2BEEHg==
X-Gm-Gg: ASbGncs8RYau/DOB9fLfmGkcBGPvuQ4wtfxmyQBEevSMs6vaej2wVY4oQmrQeBOqXdt
	i0UCClkElThVRYvw8dVJUCnuPB4NvR6q7hIITrl1KgUvT+HBUnGv8ONbsqZ3mxBaZs+lETJIdCk
	5bJX5n0H7bmXoGxDNfuBzoQusoEqUj24WlHYmOyRIOR5ZpxVJKW5qR15U9xybywG6zVdKRXxv28
	4rqla7Wbja0qRrk1e4JP1jgIiZyErUJK0m5/WXucvIR3k6lt1bluPvCeX9A+pEOG34uzYxR55i8
	GedjWLjO/NqSkOTWAoT72UeZ7hByi01Z7R/4anicZPE5vsw9X6uZ1DOa2vWS2VyG9vUATrg=
X-Received: by 2002:adf:8b47:0:b0:424:21ff:5151 with SMTP id ffacd0b85a97d-42421ff535fmr1705059f8f.5.1759227500476;
        Tue, 30 Sep 2025 03:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3ZyM9t5bViNq/9tSXepHz486aMuBktyiQyddVglqgRvUr8MS3voy5nEWgaNyrtI+mrjb6Ig==
X-Received: by 2002:adf:8b47:0:b0:424:21ff:5151 with SMTP id ffacd0b85a97d-42421ff535fmr1705043f8f.5.1759227500105;
        Tue, 30 Sep 2025 03:18:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9e1b665sm22006951f8f.27.2025.09.30.03.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:18:19 -0700 (PDT)
Message-ID: <2bf22dc5213ada5339d85744c348da9558f25e3d.camel@redhat.com>
Subject: Re: [PATCH v2 2/4] rseq: Run the mm_cid_compaction from
 rseq_handle_notify_resume()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
  David Hildenbrand	 <david@redhat.com>, linux-mm@kvack.org, "Paul E.
 McKenney" <paulmck@kernel.org>
Date: Tue, 30 Sep 2025 12:18:18 +0200
In-Reply-To: <87tt0k3oks.ffs@tglx>
References: <87tt0k3oks.ffs@tglx>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 00:01 +0200, Thomas Gleixner wrote:
>=20
> The current overhead of RSEQ is way too high. People have reported 3%
> regressions just because glibc uses RSEQ now. So that needs to be
> addressed. Moving the RSEQ fastpath to the last point before going back
> to user space is the correct thing to do.
>=20
> mm cid compaction is a related but orthogonal problem. I just skimmed
> your patches and I'm really not convinced that this is the right
> approach to solve the problem.
>=20
> The main issue with task_mm_cid_work() is that it iterates over all
> possible CPUs twice. Your batching just makes the impact smaller, but it
> does not really try to change the overall approach to this.

Thanks for the thorough explanation and sketch implementation.=C2=A0As I'm =
not really
confident with rseq I didn't dare changing the compaction logic too much, b=
ut
clearly your approach of getting compact cid by construction seems the way =
to
go.

I confirm your patch passes the selftest in 4/4 of this series and, obvious=
ly,
removes the latency I was observing.

Thanks,
Gabriele


