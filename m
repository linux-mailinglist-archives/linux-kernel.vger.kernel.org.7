Return-Path: <linux-kernel+bounces-897724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB9CC53717
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C85B935C212
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B68345CBA;
	Wed, 12 Nov 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvMocAPu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6Psaz5q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06833E36E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964314; cv=none; b=bML7a/VQVfFIWk0FwP8UnKqa1GTgHWlVZ0dky6f22XZ2pOk9JpSAjjo8/Nma956BjbPKl2EEeHD3FacC61Ga9aHPHK1csiGR7aZJH4qsINeB2Pqo3LIkyQRHgAjn9b1HnMoI21YXaA4alD6G7TrEiD/JXxB3FHqXZS9Dg0DWqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964314; c=relaxed/simple;
	bh=4DTPp9xImYaWpVbYbO/UlQWCFIM56jUjoOqDyjrfU8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZU3Glo7IN/CthFD6EEpsZqU1Sq7DlWHXs+Axtx2/w+I7n/XTWTWVwfzbqFcTR9MaJjON5UskpTs/1+t9Fz2fNVqvtwMuodzIF/sUkK9uuRPIjII/gGz+vsMgcZ0L58stECqByV4dMCY8ZByW8DkNWK9e6rl5OqoAGwjAus0mPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvMocAPu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6Psaz5q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762964311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xr6BRrCge/FRgFM5LetWjmUe/vp2V464CIRJSWJuOQI=;
	b=UvMocAPu4/He1uOJ8pJG1al0n1nj/RW31YVhnVbu2zenVuszBrwU8TlSopgiYEP1GVHSoI
	1ZSOsMitOKQwf3tJXK2MVuq1DSTuma1kepkSnX+MX2N4DmD7rtyXieaxzNKE/eHPWXAePG
	Qne7Cf/QZKJ0R6d+YGPxD0sfx/zTsMc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-IzqWcL_jP-qhUlg5otFGKQ-1; Wed, 12 Nov 2025 11:18:30 -0500
X-MC-Unique: IzqWcL_jP-qhUlg5otFGKQ-1
X-Mimecast-MFC-AGG-ID: IzqWcL_jP-qhUlg5otFGKQ_1762964309
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so12493445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762964309; x=1763569109; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xr6BRrCge/FRgFM5LetWjmUe/vp2V464CIRJSWJuOQI=;
        b=c6Psaz5qbSOpBsL4usiT/Bv1kJQ/mdWdiaouzQXxXHICxc8vZ3QGfm7ivqkS+dmL90
         fVrWeS38JC1DRuZL1wrP7iqh0+XW6jO/cpLsikeA2MiKv5RGiwqvYK8SIw85AKWFW4/w
         LcW8Z+W77J14JDYvRfx+xM+agW9t2OM7Md1XDj0TCABtG9f8lzRvjgQNUqnjNjqKOkLp
         OUQGE84AVrbb3UG7GevBbWEOHlq7aDk6YiInRBB678IgQobVV2EKL7pv6DtwtiFI+o46
         WZR9OLVdUED4djlO4znTvq6Kzmz7TE9vn023MNVEBmnyGJXjoFg2xWSDYIw64DO4dpJg
         b27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964309; x=1763569109;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xr6BRrCge/FRgFM5LetWjmUe/vp2V464CIRJSWJuOQI=;
        b=ERwbfUoyoKpTfQTeVpQTMdOArbMBVVpcL5cCkvayUiRFR0j6rc3Lyb/rwdIhiplEoS
         gxoiP6cdOwh1Ys5NhHMvD/NQ0dlAGO+Brq+11upvVStP1F/946dUBUn+7FTZSAudgv+W
         g51tE1p9hwyb8gltHfwnzc7I3tU25TDIg3DCaCKgZeJnH9HPYzNnBnXsWuy0BNxZc1f1
         CI/vU4PmOA3sqOC+0nTPnlAWOmhB8qbLIryyrRsexC1wQJ/ez4QiiUt+iSK2zXTsKnOL
         h2RgFcDPLcxeRqd88K7+FT8/E2Uz6f9QJeYLS9BjJ7w/RcSObfnOqtmImHjeQi8eMF2+
         +9tg==
X-Gm-Message-State: AOJu0YxSNIK0Z/izjC4yT+74+U/duI5fzjUvSkT52CYehIdtiDyFDbKm
	EDd9JA9hoiASXwSBjhxqdP0LgHoe9KdcGiVBpQs+s2ulbMQcU+XMnwaFHEGGIYT4eUjmt0KEoNs
	hxnjmFRJMLFInAApIH5bwQc5lmt0GGkTyy4Dni4aB+7/4VRoed676tJAk5uSMfkZ73Q==
X-Gm-Gg: ASbGncvJBG8ZMLTUkNk+26ajiGVoOwZbjVJIDLDvNV9yVejWEmDelhLfMU6drCdwulv
	q5swI4H1zmZGyDycSUajWNci6RyO+pTfuZQIlMHWymMXcII4KSEA+vqq9PuDmTTTKYLFvjMzmow
	mh7UhoYdb9/NjMWNvAtEYZ7biUMDCcopnUrvvjZEqY67TOUg6BPWKTzz2HBbdUwsu7jSRAJFvDU
	gp96D1YdPPw0XG0+8PCzOOJ5pxrVAhn3mzfr5w98QHYsv5fh1E3qzNrvYXbyScSFiLORdkEFRzB
	LkaPaANY/iswiBUC65jHaoux7BuexevRz/6DOtIXs2Nktfo0A/7BiT5DOIa776hHhcbV8E7iXEF
	BlpaNoTLYA0/KRbezqw0CrZPQ
X-Received: by 2002:a05:600c:1c2a:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-4778704da9dmr34412725e9.15.1762964309165;
        Wed, 12 Nov 2025 08:18:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMW+EukiVm6iXR4uufSLudxwVy58ZpPfr7lhld1V2UmYylFNmDUJdZqJ3kdrY3F/ZMecdzng==
X-Received: by 2002:a05:600c:1c2a:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-4778704da9dmr34412485e9.15.1762964308758;
        Wed, 12 Nov 2025 08:18:28 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47788aacb59sm17393155e9.5.2025.11.12.08.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:18:28 -0800 (PST)
Message-ID: <446f97f9663c1bda011d4171d17f1470d21fb7df.camel@redhat.com>
Subject: Re: [PATCH v14 7/7] timers: Exclude isolated cpus from timer
 migration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Thomas Gleixner <tglx@linutronix.de>, Waiman
 Long <llong@redhat.com>, "John B . Wyatt IV" <jwyatt@redhat.com>,  "John B
 . Wyatt IV" <sageofredondo@gmail.com>
Date: Wed, 12 Nov 2025 17:18:26 +0100
In-Reply-To: <aRSv-kcSj5kc6CJ9@localhost.localdomain>
References: <20251104104740.70512-1-gmonaco@redhat.com>
	 <20251104104740.70512-8-gmonaco@redhat.com>
	 <aRSv-kcSj5kc6CJ9@localhost.localdomain>
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



On Wed, 2025-11-12 at 17:04 +0100, Frederic Weisbecker wrote:
> Le Tue, Nov 04, 2025 at 11:47:39AM +0100, Gabriele Monaco a =C3=A9crit :
>=20
>=20
> This duplicates a lot tmigr_isolated_exclude_cpumask().
> Would this work?
>=20
> static int __init tmigr_init_isolation(void)
> {
> 	cpumask_var_t cpumask __free(free_cpumask_var) =3D CPUMASK_VAR_NULL;
>=20
> 	static_branch_enable(&tmigr_exclude_isolated);
>=20
> 	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
> 		return 0;
> 	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> 		return -ENOMEM;
>=20
> 	cpumask_andnot(cpumask, cpu_possible_mask,
> housekeeping_cpumask(HK_TYPE_DOMAIN));
>=20
> 	return tmigr_isolated_exclude_cpumask(cpumask);
> }
>=20
> If so please add my Reviewed-by to the next version.

Good point, it should work, I'm going to test it tomorrow.

What comes to my mind is that tmigr_isolated_exclude_cpumask expects the ho=
tplug
lock to be held, so I should probably just hold it before calling it:

static int __init tmigr_init_isolation(void)
{
	cpumask_var_t cpumask __free(free_cpumask_var) =3D CPUMASK_VAR_NULL;

	static_branch_enable(&tmigr_exclude_isolated);

	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
		return 0;
	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
		return -ENOMEM;

	cpumask_andnot(cpumask, cpu_possible_mask,
housekeeping_cpumask(HK_TYPE_DOMAIN));
+	guard(cpus_read_lock)();
	return tmigr_isolated_exclude_cpumask(cpumask);
}

Thanks,
Gabriele


