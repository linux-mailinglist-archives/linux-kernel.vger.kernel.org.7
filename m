Return-Path: <linux-kernel+bounces-834280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF0DBA453B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BF9188A074
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3513957E;
	Fri, 26 Sep 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgnjqYvx"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A5F16132F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898935; cv=none; b=LE6IOmcBobnXT5ZxQb9ZsQefG8ZSRX5oouHFY0EK+0qWUO+DRCxgFAXx6e3rM5GG+pml968Kc44YgEtchi6YLZev+WNfdFUY0BzVbraJRiQ9XrhEWqRB1LO3nC9VCDK0dULagDNTPvA30ZtayrZGYW7djJjiNDXClx3SmaiiXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898935; c=relaxed/simple;
	bh=8WJ3zSomR6PmkDmz7wRLvgLPROUSg6bOSPYWkUZH4zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL4rLRQBRA24jxEF+QzDk5rwuJWx+fqHw6uva2MDlXbUAotcP+X3LH7DP1XCR6EvqVK1lYAvR5DWEqqc8TwmKIJL/mkAShXfbeSvkLvEQTL44HkHnWGAEqxZn92ea5c/x3EkzYNXvVLdspIXVbYXkqogd6NEwuNUibvHGhswwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgnjqYvx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso73195e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758898932; x=1759503732; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s7Baoif17kvHRJvWC6HYyOG9IuJ9PffDdtqs0FozkFg=;
        b=GgnjqYvxycweAZLhBm3E4lVHSY/Y6ZYUX64/syiO8J5FCcMTs8w95bhLDuIdeX6wlL
         9/nGiDoVXMP5uPEIZQkG53VDzSmrEr7pJPibdi5yg17wiwALea2nUe3QIgwLb6bBLvdB
         +f33anEu1ipbswAevamAfdJfFEP8hKXPyp6z/IhlB3sxmPb9KIsPXQ6OXYggh/GDJOMr
         eO/HXRbKm26zkG0lO+NmmShOr94uBDjvJKBv2acBhSotdwJtkOSOZdxjeQcWZjvywSGU
         rIgdzoZmdbcvG4yIWFZAwg006nhkJqXeAwT5SpoaNfuvMJkGoRmdypBbvOiJrafBmqOE
         VPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898932; x=1759503732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7Baoif17kvHRJvWC6HYyOG9IuJ9PffDdtqs0FozkFg=;
        b=iNANPbbmnq2gZqp9gtVfZFzXVQ/npR2FZ8GnlZ0qTbXdzJEv8j6+V7/9ao2ZiVXwQV
         9mex0AUuX554o0WhFa59qETL3kteu3NkfIcs7qAMM3wHQONsvHZ4Z8642Ysqq+U0s93P
         hrkr8p4CMvlNt3uvqBEGKwMQPX7qYHGioFkOlu7Vjm1AFTpsmCxHC2Sqi4KqFleisXbU
         +Av4va9W1DeWnxKdkMv1OnbPG6pzHwbYEZclfxiRQYpbgvUU4Dbc1yaRHfNBJguLDLO+
         UHfnWDhzs5hlE35gzpK5KwDePPhUS74+q0UsmTplWME9g78od1EVFLIqtI3WP0MiOTrb
         qhIw==
X-Forwarded-Encrypted: i=1; AJvYcCXzv6FDYzWJKLD1UYRKr0kFG/B5yF4r82iPpNLAl6yWywxvINWcK6jm86aPdOdNK3QrbUEm6ayKTj0e3Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfmn4BhQpJjUQLiL5pf7GPkrP+iu/6YMGkNZlSWPfQv0+B17pV
	+VYwH++CXJWoKlc5zz7hQLk93db26E4PQ7mrZ/B+mg/X9vKkHmusSG1JzNyaEhdLQekvUAX7cCU
	VtWBIpg==
X-Gm-Gg: ASbGncsPJS4Z09Lr9m5KIs0lF93urDb/x1j4lBGeY7OtMDQsoJwljgHyaoGo50yRNai
	p1mFKXpavtsw1qWqmzbejS3y8G1c3J1HyoT6Wus2Jpi0XpraBUgK058qgCKqtdPaA0gJp4xOssj
	btnvP/5Hu2AagNv1iYmzL88qK63okCLIfvrScYdJnFNJZcQOPuSLWiskFnp2bKZcH72619ZWfQd
	3xw0Oy3jf4Pky9vT24/nZidPYuJwQYSE9LG3C1urYr2Y+4MV2LoUxWJL6Qnq+4sMFFuUdoHIaIZ
	wuIwh+ms5C0mM6D3rWzNeD8M744L53MzJuSPc5pIBUUvIHR9SBysCpYr4qS63YpGuPAKUiIZ4Z5
	0OLkwLjyXPHbxuqwHJsT0AT/fB28KfpEwrNAteT7AN31fs9dF6O4RQ35wtKha8eD+mov1mTEg0v
	owTA==
X-Google-Smtp-Source: AGHT+IGGXmNBTu4UEfqjidL+GDIizhadTfvXaAwFgVVLBzv8UsZYzurqe8WWNcR71jr76VBG7flshQ==
X-Received: by 2002:a05:600c:40c4:b0:45f:2e6d:ca01 with SMTP id 5b1f17b1804b1-46e3b009830mr1290175e9.4.1758898931549;
        Fri, 26 Sep 2025 08:02:11 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac5basm141572865e9.7.2025.09.26.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:02:10 -0700 (PDT)
Date: Fri, 26 Sep 2025 15:02:07 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: devicetree@vger.kernel.org,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	linux-rockchip@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>, krzk+dt@kernel.org,
	conor+dt@kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: Re: Support for Rock PI-4b
Message-ID: <aNaq72xKS4QaNjwx@google.com>
References: <CAFgf54oYjUEg9KkQUzneYTZH1Z8cX56va5M0853eWPFaYT+Z2A@mail.gmail.com>
 <638b9565b90714f56caa9535b7b9b96cd86100d6.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <638b9565b90714f56caa9535b7b9b96cd86100d6.camel@collabora.com>

On Fri, Sep 26, 2025 at 04:28:48PM +0200, Sjoerd Simons wrote:
> On Fri, 2025-09-26 at 15:07 +0100, Mostafa Saleh wrote:
> > Hi,
> > 
> > I am trying to run Linux[1] on my Rock PI-4b, which I see is supported in
> > the kernel in “rk3399-rock-pi-4b.dts”.
> > 
> > However, compiling “defconfig” (ARM64) and flashing my Image doesn’t
> > work,
> > It just hangs before any console (even with earlycon), I tried to also use
> > some of the vendor configs with no luck.
> > I did some research and found that [2], which indicates that the upstream
> > support has been broken for some years?
> 
> We've got the Rock 4b in our automated testing lab as part of kernelci and other
> efforts. Upstream works just fine on those boards, so it's likely an issue in
> your setup.
> 
> See e.g https://lava.collabora.dev/scheduler/job/19978558#L525 for a recent
> upstream kernel boot.

Thanks a lot for the quick response!

I can see some differences between this log and my setup.

1- My uboot seems ancient
   U-Boot 2017.09-00026-g2431fa34678 Compared to U-Boot 2024.07-rc4

2- The board model in this log is not 4b as mine
   Model: Radxa ROCK Pi 4A while mine shows Model: Radxa ROCK Pi 4B

3- I am using LLVM not GCC (I don't think that matters though)

4- I am using MMC to boot and not TFTP

I will try to look more into the differences, and update this thread in
case I was successful.

Thanks,
Mostafa

> 
> Regards,
>   Sjoerd
> 
> 
> > 
> > Has anyone tried to flash a recent kernel successfully on it? or any
> > tips are greatly appreciated.
> > Otherwise, maybe it can be removed to avoid misleading other developers
> > (I got this board to do some upstream kernel development on)
> > 
> > [1] base: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
> > [2] https://wiki.radxa.com/Rockpi4/dev/kernel-mainline
> > 
> > Thanks,
> > Mostafa
> > 
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip

