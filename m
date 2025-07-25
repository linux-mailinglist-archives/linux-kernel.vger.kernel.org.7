Return-Path: <linux-kernel+bounces-745415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D0B11992
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF76AC61AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03117253F12;
	Fri, 25 Jul 2025 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nWuaZICG"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958928A41E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431050; cv=none; b=c1VJzDMbFxvFLnTreWrgpsn7IZ61nLcWW6re8tfnerluoasiWYHj+UybYFH272XTYGv8U0PCY6KpRIZCjbiSverAdkKZ/loVspUrmESjHUALZEVleOsqMiBTprnWtBspqooMmAbCBczOSALwaGjgvhZ/teoSs4g3EgIwxX/Y9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431050; c=relaxed/simple;
	bh=/8Jy2q7BUbMRemNSy/ayI7mRAKf+o02bPXV7CnXtXQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAzhPQHitHSgVxG0JPwFrztROkkbrhM3CIX6lLbXrwf82XvdtmwYYAHxu2ySBDUTcfIkVy4di2ptFuyVUg0Z/MSDCmlDrFCXeadMgsXsg/E96JD5SqpQyJdEPbwPjhGauABgynX87PJYb5HbhGoLJL/tQhfzEe4427APCVVvRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nWuaZICG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b77673fd78so215484f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753431047; x=1754035847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjnADGgMIxD9Mwt4aQx2cVoKFVB9u557YmwsL2pYhHc=;
        b=nWuaZICGp1RprfKTIAnRT8GXAntIodnigFZgHAgo38xzs0lc8jlmJIoYb80sV0wOQj
         s0snfm1v0otVMYj2rWIYqW5sTnBt6l8nr1XiwC1A6LzVtGVGSvuhbXLODv1cV5yt+MQM
         tsyByYDkm0h3dzUg8NV2SYNSxxwuo0qz2J3XBVZALc19lxSU3AC9tQn4O7ZZrzD+881R
         2rgGhih/Bc/6fLDd0iYzSj6a2Vp75ghEfZHSEjOeBa0OT6ZzaGbx2vlpSrlJ8/7ILX6V
         AHx8jDtEAWshRDJfOVRNaza0lCoOdzddHs5jrik+cIexago/XwSZhn/+xjYM9WM4jpZC
         ONXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431047; x=1754035847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjnADGgMIxD9Mwt4aQx2cVoKFVB9u557YmwsL2pYhHc=;
        b=Gqlvkfd8I85o1nAh1XpgK7tb0LiIqJILPgiKO8HhHgTuEFr7afvke+sXF5s260tHyF
         yUkfnGWE2z+ksOj8DZz+6HKJ5MGL+NHHSVo3HsrAhFxWMMM3KirKvjJzaF9YeqsR+RhT
         AIqmKsK0+vT3iG4GMMRiFAcy4lAXc6GUVzLiGRdj+EGpP+nX5k0FrZTaplJSBAYrXXiZ
         a7n7p3HtrBvXXZEMIpsm6Ve8oyU9OCXT5SKM+gBhSJ5mXO1Pvj30KGDDMGoLkoS73VwR
         Vkfm5lrIKF0ioUyf5KUfSpagxG7ZtUhqDgdLTirdIhIxh3l4czzF10HyJxkrpTZetZZQ
         hSeg==
X-Forwarded-Encrypted: i=1; AJvYcCWN7/HKlusnJRXZeT+XIsRhKU3QV79QO6zFpDvjBMCovXBGHoZZB14hgFPhRxGTCtxgDf7mgK9tpJ1A9GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4fqVfY1V4rc1xkFHdWG1j1Y9oZ0zyUi6XPprmE+DxahtGFLd
	VuOXRi5JwbMYYQ7lxu9tdsjRw6d4n/Z61Y52xFcAtFhBl9wAbU1OL/exoXp7br8hJ70=
X-Gm-Gg: ASbGnctR639JKyE9XMXXgA9ra6lv+l0m2S4gWmQEyGm0ErKa6cPDKOII0fuefSlzsIP
	Q0GpMCfyQsiX6hCbE+L8mhV6YG1Yl6AXP55JrtUGW6IyUE4twLybaIV74v99VFjAu4BYvd4Dp3g
	PzajlSUg00unhiLj1eGNuNKo3Jqom4xkwfIKSsjvMBO/N16viE7H4mTHrWLJi6UHNrSQpHTuNxs
	3lK7Ov0mC/fZIKnIhKJCPjSY8OK5h8CGJ7tL05d2ULfBhZr6kXfkEnxmnZ1TsVXhRe1cUPv3V02
	RXWfCOHaIrP2AML3k2zQb0bQUMDo7mnsPGsGGCE3TyFNxg/0KXXJ0RU1PYFRsPKh08KQq5vS6pS
	DqEcy/5uA4xsIaikx0DuvBZA=
X-Google-Smtp-Source: AGHT+IFtrN6VUv3AxAAmMB1p8Cksy5ht9aBXYvpOBIp9CQazid75UckioUfrsNhXmPCAYyDnC0fv7Q==
X-Received: by 2002:a05:6000:2407:b0:3b7:6d94:a032 with SMTP id ffacd0b85a97d-3b7765e6ba2mr811266f8f.3.1753431047252;
        Fri, 25 Jul 2025 01:10:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3c3c:6b37:9b23:6049])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad22asm4402723f8f.53.2025.07.25.01.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:10:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Enrico Weigelt <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] gpio: virtio: Fix config space reading.
Date: Fri, 25 Jul 2025 10:10:45 +0200
Message-ID: <175343097349.17150.917277696050409769.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
References: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 24 Jul 2025 16:36:52 +0200, Harald Mommer wrote:
> Fix for Virtio GPIO Linux driver
> 
> The Virtio GPIO Linux driver reads the configuration space in a way not
> conformant with the virtio specification. The hypervisor we are using is
> strict in what it accepts so the current behavior causes a problem.
> 
> Builds on top of gpio/for-next, tested on Linux v6.5.7.
> 
> [...]

It's already Friday and I won't be able to run it through the autobuilders so
I won't be sending it for v6.16. I queued it for v6.17 and it will be part of
my PR early next week.

Thanks!

[1/1] gpio: virtio: Fix config space reading.
      https://git.kernel.org/brgl/linux/c/4740e1e2f320061c2f0dbadc0dd3dfb58df986d5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

