Return-Path: <linux-kernel+bounces-761567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D691FB1FBF0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E63F3B2588
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B01F03F3;
	Sun, 10 Aug 2025 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5Zm/9JS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A12629D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754854658; cv=none; b=My4qF3P3R2pioVJYFeIuAlaRMJMQRvd1yPJlD2YPR1bDecOzsyR1u/99stHe4zZzrnsULQoah3+LiMZQWa1ldVtFXcQM+BFh8ZB0eOGBskjBX2SU5RLuKQ9UvTFiJ/X5sI3LS99qkfwHGZE+x2c12GWBlBvMq9CXvi/EyUPsunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754854658; c=relaxed/simple;
	bh=0gBA51ZDI2DMi1nYIAievfqaLnqNnNxSKE6eNGSbwX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCzlArESpZiotHyezGlAdPqpjZZYstBWi19yOc9D1En6yGDlcsHBVOt/VRue88CHexmhLhAvdQgrZCgNf+qSrKgKE1Ypv0I+F1IXi2xm2Oz72N3k37S1SoiBUGouoqjFioYgia2IJnoQHwLyEP+LC0C1kSg9tCR1u2WrVXd8lug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5Zm/9JS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24049d1643aso26791265ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754854654; x=1755459454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/yuIuATEiwOQKzzgSiV+HLx9fQ/EaTIPMYX7EZmAgQ=;
        b=h5Zm/9JSr9QzKQrnnwJ4/QGJMfsFj6FhesP8HNLa66CoxQ5Dd8slU0HQheOZQanhSc
         Lcs0yeLR0bglaZuCsjOdlUlWigmNK/ULf9rmp1ZLVbn8Vf4avmOFADkrkHmo2sbTNQ29
         Fn1tCXuOm4CNve8HFGk5BQ25NUPZb3SVKqj+ao7yIYsDpM5rePbrGijw1nPMUBOLxSZT
         mfpzh/5VUsKPL4Pzy73z9gYMKFu4Tbg3jzopluljk25ptlr9LGCQXasedfZbfZXzKTMR
         74ifg37DiCjUvYwAZnURFsjJCu76voCMIboDK/mjtHDncQc7rBD9G5Z1nE1kRmo7V/OB
         ZwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754854654; x=1755459454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/yuIuATEiwOQKzzgSiV+HLx9fQ/EaTIPMYX7EZmAgQ=;
        b=mesjRRV2dKulG92mnKuA22mEOblfZKDp2aKuhMTT3GQnZLeh0srriU4uboLTpc6edK
         WSs8TmcuSGq1I5Yudoi+Ppe5fTlLZpf1YdAxc2NB/gE6SMjBNCLZfxyy1yJ1vMX89zIt
         KokxyBNNIYDO0oO/kIHF8Za33NGNo9M9EPjnToVmX+3YlKaWPzGLa57i0PzVwKoLs4/N
         iViiJvJD2SkDA5xJgnFFgnFqvNN9dA51UBjYF8DsoxWSNUqfaJ8PdhVA8ekSOx/ss4ng
         xhTVZ/DPDolqBLtFMsksQbwUuH0euDMDPa0/EUj8QtHB8Pb/1D05prknZAbMEEIYx8oY
         MtIA==
X-Forwarded-Encrypted: i=1; AJvYcCXpYyhKgdl3959uGjT2zVbzJIop6ooIMojXuF2z67zWh4a3jj96QtaP87jNFuV7gkN16We/9NXEBGkot8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdrNDMIYFYdwuHrH8Jmxnxij2ymBErFceuDKlyuSymltlO/9S
	ilvzRbUVqlb0+2pLbbjIx1B9PifIfOpjRqZ/nVhmVn3ebJTokSPdqXQU
X-Gm-Gg: ASbGncsi93WrLFW5/cJdRZrc89A0L8svAApz0BYBeLGXj6irz+S81SBhmec6HZZmXX6
	hmE3MXt0XgPQf6Sh8y5vx1bAUWW37aW/atinVH16UrmCS1nToy7B9meF+YCzo6dKXt8Ue/cczaS
	N4wMFws96tGcVs079W9QrL1FAZy3ol6HyzW/MbiVnMKq+RBnkEtVGH8v5TdVI8LHMtyHuK4f0tS
	vjAJtwyEp/0qRd0Kd/KIz0hafz9cJQzHUhdBoycjURKVeXU81zTI31CaCk/cE5UonIo9a4ByMaO
	bucUz8DQ7bXDweRtWxRKPZ2rKeAEIe+3b7o+lypBfdWKGQFK/aQoLMsa/ff5Iu22YycHDbRdDXW
	MiuWlNmkbAZbX6epyaX+TsdC2Dx7SjTbOvPA=
X-Google-Smtp-Source: AGHT+IE0kyDzCdEqPhO3JgPEeauAQaFHFFgOQDKCcVTJcHOUVlG7/jFe9k68nz6mqV5L7PQ64uS47w==
X-Received: by 2002:a17:903:4b43:b0:240:25f3:2115 with SMTP id d9443c01a7336-242c1ff406cmr151660785ad.12.1754854653927;
        Sun, 10 Aug 2025 12:37:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaaa75sm256038235ad.154.2025.08.10.12.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 12:37:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 10 Aug 2025 12:37:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Tsai Sung-Fu <danielsftsai@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] genirq: Add kunit tests for depth counts
Message-ID: <ded44edf-eeb7-420c-b8a8-d6543b955e6e@roeck-us.net>
References: <20250522210837.4135244-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522210837.4135244-1-briannorris@chromium.org>

Hi Brian,

On Thu, May 22, 2025 at 02:08:01PM -0700, Brian Norris wrote:
> There have been a few bugs and/or misunderstandings about the reference
> counting, and startup/shutdown behaviors in the IRQ core and related CPU
> hotplug code. These 4 test cases try to capture a few interesting cases.
> 
> * irq_disable_depth_test: basic request/disable/enable sequence
> 
> * irq_free_disabled_test: request/disable/free/re-request sequence -
>   this catches errors on previous revisions of my work
> 
> * irq_cpuhotplug_test: exercises managed-affinity IRQ + CPU hotplug.
>   This captures a problematic test case that I've fixed.
>   This test requires CONFIG_SMP and a hotpluggable CPU#1.
> 
> * irq_shutdown_depth_test: exercises similar behavior from
>   irq_cpuhotplug_test, but directly using irq_*() APIs instead of going
>   through CPU hotplug. This still requires CONFIG_SMP, because
>   managed-affinity is stubbed out (and not all APIs are even present)
>   without it.
> 
> Note the use of 'imply SMP': ARCH=um doesn't support SMP, and kunit is
> often exercised there. Thus, 'imply' will force SMP on where possible
> (such as ARCH=x86_64), but leave it off where it's not.
> 
...
>  
> +config IRQ_KUNIT_TEST
> +	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
> +	depends on KUNIT=y
> +	default KUNIT_ALL_TESTS
> +	imply SMP
> +	help
> +	  This option enables KUnit tests for the IRQ subsystem API. These are
> +	  only for development and testing, not for regular kernel use cases.
> +
> +	  If unsure, say N.
> +

The new code calls irq_domain_alloc_descs(), making it dependent
on IRQ_DOMAIN. However, specifying that dependency directly is not
possible:

 config IRQ_KUNIT_TEST
        bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
        depends on KUNIT=y
+       depends on IRQ_DOMAIN
        default KUNIT_ALL_TESTS
        imply SMP
        help

results in:

*** Default configuration is based on 'defconfig'
error: recursive dependency detected!
	symbol SMP is implied by IRQ_KUNIT_TEST
	symbol IRQ_KUNIT_TEST depends on IRQ_DOMAIN
	symbol IRQ_DOMAIN is selected by IRQ_DOMAIN_HIERARCHY
	symbol IRQ_DOMAIN_HIERARCHY is selected by GENERIC_IRQ_IPI
	symbol GENERIC_IRQ_IPI depends on SMP

This is seen with alpha configurations such as alpha:defconfig after
adding the IRQ_DOMAIN dependency.

I have no idea how to resolve this. For now I disabled IRQ_KUNIT_TEST
for my alpha test builds.

Guenter

