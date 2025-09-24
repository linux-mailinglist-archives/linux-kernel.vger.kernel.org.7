Return-Path: <linux-kernel+bounces-831078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55D7B9B7B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7687C3A3C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D69302CBF;
	Wed, 24 Sep 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvtOKgXl"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52F28F4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738318; cv=none; b=eI7T7/19fe6iSTiqKc76H5YGMVloXoZvxqc2Zj9V44RvsKkzkWxA6HgFSEl2esVJHUH77+uWMs6E9bq2mpEPHTTbiuUHsETQFVC2c7lwjFfcTlsg3f2cbQHn/sw7GT8Gfs2uoGPWN+NcSvcBt7zjI8DhcgVc6V6oe2M0Re0NsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738318; c=relaxed/simple;
	bh=g97455aHztfid/mxTIWRxfLc4DSmVKssfpZqo3D8+SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvlrmoe6wUvwji7Rw0ptLFHgo0VmjgqFCGLUsgo6FNOkV5n+L9Q+RxahWBZrcbC/5VajXv62vM11XbwtnnuOVgSW3dnVZhP0bXuNput87mM7PDm2xaoou9mhaZ3aeOA+vPiFA0BVOJNrTQWiyGyAubN9uoCbTIpEiw46V7EVO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvtOKgXl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f605f22easo132237b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758738316; x=1759343116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YgjPyD/CCV5XJY8PLF8Hf+Jbbmg9hnJHEyTuJhhjQc=;
        b=bvtOKgXl3shv4YjcgA06OXdHR968qVWEkukCgTBFU5ZT3pYPZrVx9FeOFVpQn7GZK8
         Y/v6S4dn/MCA5Zq9aM7uLLa4jv36KPZkUfuyfW6W1WY/wO6yS9JHlA+RUyO4s5hzbTQ2
         0h951+EoGtpYK3+oadW+a0AlkpDcCaoGTvITkxkfxCSi4ChmmG3ecwIiLzfWcBVNBE4h
         2KUz5spEy7Nj2SmogiXX3zbKvIYLFeQa+x5RwqGd6YWgyM0Xdc9eRlpvdPy4g4hcfnND
         r30Xv0QUFePiTmrt0bQCksav4PkWHuFj+9U9WNac3sEl6Q/zZD6QJl7EYb4ly6gi0I2/
         mE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738316; x=1759343116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YgjPyD/CCV5XJY8PLF8Hf+Jbbmg9hnJHEyTuJhhjQc=;
        b=LvXZHbFNu+KZBmuqrCNh3iv20wpuwrAQ2DNsJBfEQpDtxnLg575IVRmq3OodcgaRpB
         jfIPWVLNPLpUIo/96MLTiWLf0KtCG0kzo6JAYsxyHJmZPn/fhRRTbqNIr5MoLg13dHm0
         VkjUBQChmWy5uKYD+uAC6TV1EwIJr3cedkAYViZHL+kXlwjc8BOlYh20uhY6aOO/O3ZX
         Ok3SPszpvjsist7l8Vb7ajbFMlmNc+Y2QHw0ZErESm0/QdBGpT2PGp1aF6xR+5u1Z1JE
         tfffvPjSClPxDe8g9Q3Oh1ahKP6k7DYcwX2mikL5H3rwR18M27zrXJ1mLroHY4OhtzmT
         jRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpDtxETeSibFieatE3EwmVBliEbcE0tMNgLodHwYhtKF2q4OIX1o1pISbZBZyjkDvNq5L6/lOCeA80tYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWR8Qyn/oA8QvQO65obOOPMcXGx9fEj09VUPVPzjVzyUgxDV4
	5bWfDf9hIHrAjlLFiX3V8MBr1nzdT+YIHdC7l0sZreHKh2Ju7+dHVJHI
X-Gm-Gg: ASbGnctnDsd+M0bJW2EpLDTwQs3mKRo2jmTbibZy0D/jKUDveGpsdN5pIST1/Fm3I3x
	gNX5opl4uS7atnQqKcqRBKRsjOWfRECbTx7aUp3uqM4COdmLZ3JMGdki976AoU98xesBZahXC8i
	5Xgui5oKpvx4H1/ryJTlDjYDVDBlMsA6+BBjDziYLQ1j3mLCaQWhOGnC+g/o+ZyGPru2CY94+OT
	17TlZNu+BOz0PK9QoeZgEiS7QlDNjohsVRlCggFPxhVFxpoETFjeRDtSPzlgRbwtr7eG4T0i95h
	zTMhFhgikwAf9whwRd6MPUpkSw5OFS9UVNFhsrpF1zlVc8bQq1Gu3dcQWkEr6+dMZr5xJDQoNzx
	2xDcFqof49ReLqZoQLJUISYtl9YjNRjPlNw==
X-Google-Smtp-Source: AGHT+IEpqtHdu0dI46MtGn1c8K5pz/tU5t+99UVSknOsKwdK2FcxqnWLxMvVRgkYkwlIxwrVnQBnnA==
X-Received: by 2002:a05:6a20:918e:b0:24c:f8f:2b95 with SMTP id adf61e73a8af0-2e7d0ad11ddmr748774637.40.1758738315675;
        Wed, 24 Sep 2025 11:25:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f4c4:bad6:f33e:ddc9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5510fd4872sm16344912a12.32.2025.09.24.11.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:25:15 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:25:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
Message-ID: <hyzzrjn7jzo3tt3oyg7azijouawe3zopfjzq6zfhoo6e6z2m4t@ssl5vl4g557e>
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>

Hi Bartosz,

On Wed, Sep 24, 2025 at 04:51:28PM +0200, Bartosz Golaszewski wrote:
> Here's a functional RFC for improving the handling of shared GPIOs in
> linux.
> 
> Problem statement: GPIOs are implemented as a strictly exclusive
> resource in the kernel but there are lots of platforms on which single
> pin is shared by multiple devices which don't communicate so need some
> way of properly sharing access to a GPIO. What we have now is the
> GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which was introduced as a hack and
> doesn't do any locking or arbitration of access - it literally just hand
> the same GPIO descriptor to all interested users.
> 
> The proposed solution is composed of three major parts: the high-level,
> shared GPIO proxy driver that arbitrates access to the shared pin and
> exposes a regular GPIO chip interface to consumers, a low-level shared
> GPIOLIB module that scans firmware nodes and creates auxiliary devices
> that attach to the proxy driver and finally a set of core GPIOLIB
> changes that plug the former into the GPIO lookup path.
> 
> The changes are implemented in a way that allows to seamlessly compile
> out any code related to sharing GPIOs for systems that don't need it.
> 
> The practical use-case for this are the powerdown GPIOs shared by
> speakers on Qualcomm db845c platform, however I have also extensively
> tested it using gpio-virtuser on arm64 qemu with various DT
> configurations.

How is this different from the existing gpio-backed regulator/supply?
IMO GPIOs are naturally exclusive-use resources (in cases when you need
to control them, not simply read their state), and when there is a need
to share them there are more appropriate abstractions that are built on
top of GPIOs...

Thanks.

-- 
Dmitry

