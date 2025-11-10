Return-Path: <linux-kernel+bounces-893196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1F2C46C56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F9348E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FD31FE451;
	Mon, 10 Nov 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVI/2DZb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mc3RADKx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73630C609
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779976; cv=none; b=uraov9OW8GZxo1mBqOjFGwFOvS/ftDDg2K5p+XKmpfKauu5FK5WFjWj/Z+RMUODfqrKgOqQEggoRwFxQIgI/7F3iFKI1WkXRoBS3CSJ38EEJfH6Zl0lxKKvEF4Y50Qn3DtiyDNFWKPevKoiniOCq2H5HoThz51GRqJAfrRmqdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779976; c=relaxed/simple;
	bh=HRY4a37l2JxHAPzxhzYm7gZlhdN8iEBcuGE3GfxMbBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ryvWSGa+VwZfOJ6mTwoHXwKLLKndlBZb1f6GlS37FQq/ZQnUiCXWBdsAHvI2UjF9C4ndsVNSrYX70xQb2pXuW60SAYggON8zQiSfop+dIrDA5B05LEVvi0WAfB0JasPG6ytx0cjZRugklDI0Ae9oOLcqOHLk02QUFlBdiNc8xso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVI/2DZb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mc3RADKx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762779973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HRY4a37l2JxHAPzxhzYm7gZlhdN8iEBcuGE3GfxMbBI=;
	b=gVI/2DZb8FUOinbVZF7lPXkxX4n/RR8kWQ5Gyup27kvmvNLdwtDAg5JZggUBqm7HHETf9G
	rLvrsuDnwDlEiavuRv2YGqFc9LTKy2mlkwx6qkbMQkdJuGDOZ9YjTiuTKo/E+LJZK5nCd4
	4myycy5hF3kxiZYMVGOoY0xeb3cHTS4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-TXFenKGQMPueKwQSnRKNSA-1; Mon, 10 Nov 2025 08:06:12 -0500
X-MC-Unique: TXFenKGQMPueKwQSnRKNSA-1
X-Mimecast-MFC-AGG-ID: TXFenKGQMPueKwQSnRKNSA_1762779970
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47754e6bddbso22869855e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762779970; x=1763384770; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HRY4a37l2JxHAPzxhzYm7gZlhdN8iEBcuGE3GfxMbBI=;
        b=Mc3RADKxm6TnYLktuhs1b1AE7mYqJUP8t9FbEar0F4ydYRCkBByfo/Cv/7M/pQ6LUl
         E24OXXOC+l4rvuALPJJL9d1R61jHlRCZItSW9S4sMXvxWHuATb9lnKQls8cHBkcQUIge
         IXOPe5gjm5z0AzBJ466UP1MqgqttlgNGtJy4iIPKIcI9PAhDjChWACzTuTzx55P9fhY9
         S0IHbe8UrPw3s974BnBJf9eXc0cipMzRWyWNSErhGgpcyij1iN3T8hj6nhWK3vNaA4O3
         STCozOElArlzuO1uyYXlxwG1e6Hw6jjCaHfhr/mSwvFp7B5TNItX4gjK2IgeZ3njVSm8
         gfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779970; x=1763384770;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRY4a37l2JxHAPzxhzYm7gZlhdN8iEBcuGE3GfxMbBI=;
        b=kvV0tfxw0C6Ju0RFRDKPEP/0nNjYy8cdO5b9tUBju5MFamymudXApj+/jIK+nmN2hg
         O5FXN0d8/jJ7pyyRElhsjvEjEheJTD04NBSUSOqsQw3WekESVX8OUgCmxsAoxztGzUM0
         lBRuKadzMUqZCUwOgydkfZQBKY7IzN5k7Z7g1rjhGTgSPBMQpt5RSCMnP/TgWtWWtkEy
         5vtKZAZN1PB1bldMW8LY2TXk8g8ZI2wvnPMB6YHX9+2H85+/BsNvIyYLxCo117ko41pY
         BPwLay0VY7M5AHP71KJt5vx+5Tl3h/Sglr6zhzwDRBDUkAij+L1KpuF1B7X69b43AMQU
         YcxQ==
X-Gm-Message-State: AOJu0YysQPH+O5m869OcursFj2VH7HYccO+51+0i2L+5J6KuIf8eA5FH
	ffEw74xuuUztK1d2tKdc1sb25k7KbfBieXhiP8aZokJkxqyaqTmKmTTCUCJWa6gvNvDTlTWw142
	sH+ZsFSqK3JRjg2Ghel9x8bsvMF2OZpCItaWMhXdDv6mmKX+VCKZ6xycvNh6NU300qovrGiJSQr
	AmjCWgHzuJ8U1fU8iGlvNdBknIjMS/UFJHwFA1Z/Ez565ylFR91OE=
X-Gm-Gg: ASbGncti6T4c7hFpN/KBhaZ+YWo5qBCK7AbPogNl5TqMzoSgNHpGMOQyl0bJmVm5c5E
	W80DHaO0uVbq27shnT5fp1jytPmABpdwbCbFNNw4+qXVIBe+HtKlk7Vtc/0uSDDj1h9GQjQ4W4q
	13cTxy4/YqN2auSxdbDr44/4DLBNiJliadKZi+fRTPS9khEJUPWf6Z5LrgSIdWvyUVHDWiXapEE
	6Ya0+nHKtDABUMEII5Cm2kZYpY+6RdqF8tSfJqcPkCpuHxF/HZqYGuGXhBm8L/wtItOLqHm7QUJ
	tdPJf5M1DKPfT5ZUhGE346I1lkrzAIzTDc8Rv3TUVAu64unN6yVTZ3AXmQOMKEeiUJS83puvt3u
	/ricMn0yYRsNmZjv2qCpJPWRP
X-Received: by 2002:a05:600c:1f88:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-4777327e861mr50552095e9.26.1762779970292;
        Mon, 10 Nov 2025 05:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa1bZhWZYpIRiHXf08xUrmaK6WFN6PjAsFMQbeMPuCsS2qh4FZGf8Bcb7s0JX7DPe5Zs3MLQ==
X-Received: by 2002:a05:600c:1f88:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-4777327e861mr50551785e9.26.1762779969827;
        Mon, 10 Nov 2025 05:06:09 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bccd35asm198789785e9.1.2025.11.10.05.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:06:09 -0800 (PST)
Message-ID: <f47a6827fa07db12581d2a6b8c1cfe1ce467aa21.camel@redhat.com>
Subject: Re: [PATCH v14 7/7] timers: Exclude isolated cpus from timer
 migration
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker	 <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long	 <llong@redhat.com>
Cc: "John B . Wyatt IV" <jwyatt@redhat.com>, "John B . Wyatt IV"
	 <sageofredondo@gmail.com>
Date: Mon, 10 Nov 2025 14:06:08 +0100
In-Reply-To: <20251104104740.70512-8-gmonaco@redhat.com>
References: <20251104104740.70512-1-gmonaco@redhat.com>
		 <20251104104740.70512-8-gmonaco@redhat.com>
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

On Tue, 2025-11-04 at 11:47 +0100, Gabriele Monaco wrote:
> The timer migration mechanism allows active CPUs to pull timers from
> idle ones to improve the overall idle time. This is however undesired
> when CPU intensive workloads run on isolated cores, as the algorithm
> would move the timers from housekeeping to isolated cores, negatively
> affecting the isolation.
>=20
> Exclude isolated cores from the timer migration algorithm, extend the
> concept of unavailable cores, currently used for offline ones, to
> isolated ones:
> * A core is unavailable if isolated or offline;
> * A core is available if non isolated and online;
>=20
> ...
>=20
> +/* Enabled during late initcall */
> +DEFINE_STATIC_KEY_FALSE(tmigr_exclude_isolated);
> +

I forgot to mark this as static:

+static DEFINE_STATIC_KEY_FALSE(tmigr_exclude_isolated);

will send a new version after getting a review/comments.

Frederic, Thomas, besides that, does this series look ready to you?

Thanks,
Gabriele


