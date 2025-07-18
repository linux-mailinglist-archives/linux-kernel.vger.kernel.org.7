Return-Path: <linux-kernel+bounces-736492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92735B09D90
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F4C1895582
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B631721C179;
	Fri, 18 Jul 2025 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pgrt/Mfi"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87C1D7E42
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826546; cv=none; b=LpQT/x+vxZ+03e+EpDVhfYsMBluxk1itklxg+i2Bwnv2/Z+SJkZooKjoJIsL7zvo6aHIS+UiaoR1DQ0z/dGXJaWwJITLHRt/I/a/VffYA5sdOTg6zk69fGzMoEgEnXFll6i8wmb/Tyu4ip0BQUyPi0ZXlYVqGxkMG9V6aBVj1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826546; c=relaxed/simple;
	bh=LYG6dBi27owiZdJNQoV91+OmRsH3MroMWQm8w7WQq0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSygJXmThKzzBmCySC3lMIleQm2LGao+hJyn9GF3PY+nXF+wl5eLf7ZT2oACFCaNGlJeFsIBZF62r2dFuMV7AfCVyvTbdx4ZGgsovxpC53lmAosuTp65SmbxUTHOlbHn483lr5EII+bpok/dEBQLRqcxckE1WDPPS+5aW4iGkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pgrt/Mfi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23e210ebd5dso21355965ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752826544; x=1753431344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRoi/KdssEcNygdK/MFmLI3EXaQwQgEFjNwDzaC/Nps=;
        b=Pgrt/MfiqRGN68PUAHXT5q7cMHfSF7zTjtbN8ovzvYd1Bol/g7bRsHQwI8id39jS3a
         j1Z06zNMRtFLK9Rwrn4p6i3XzagyDuDFBoE2xemdsrR+PX4EyhPM/bhbQX7WJZ+ALLns
         RYZcs14+PZQMMqxc6hzybqTX5Y1XrdDNNXZmH2rRoX2M9zarGAy1hZrwZbMsStpFoVNE
         ZWpOSI91QF0vbywt593u3oI20uVbaYCsna8IyDabjb2FaASBxi8v29VsIufyUoyD1rpD
         z69E5C6Fj8Q8hswk9CD0bhUNVMLUVnjFnrKCpL2pwXoGSsUkBrNfN8XZm7jrKGxjhBCY
         yVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826544; x=1753431344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRoi/KdssEcNygdK/MFmLI3EXaQwQgEFjNwDzaC/Nps=;
        b=OiyKiGz/Wc4HifeXLO5TpAQNS+191nbwI+JxasEWAv1shCM+smUgH4ArAVlmctD/Ot
         P8b/s3uyOqRT4mLAschMYmIq1kgKbFGrR81FEhtNiVHxGuU53lfBhgcfG/QQes4o+cfy
         zXS6ggnx4V8AGPTukIDg9PqDJnuHgvTlSDY1JmDOIiSZtp7IndGZoYpCcLtWcioy1iuG
         Sn681TI32haesE999LPL0jErJd7cacE7l557VKJFY72mFbVEplBzJg8reRbDpf6ygL5m
         ppL7RUFrGelgBJXPAY+Ay0fttJriuA9HyATdt28LyStu3u4rIQK6JthbwWKypP/QacgK
         iHEg==
X-Forwarded-Encrypted: i=1; AJvYcCXi8lnukqRehRY57ElWzqnfXaUzKQI4XvcSqhRgzvabjKm41c34H1z3vQ/XpA4Wci+3i6Z7X4c47TGJ2dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIo7KjzO+5Bawxp/9Nt60Ju/w+VdVWVmBldXwa6Q8LqmrpD6Z
	QGyjdXUMhdaH/2Og2dCRIe9ASoC6NpJSDZF7KBcX5AWtH3w4aUTbC0fRCuCb0wWcW9c=
X-Gm-Gg: ASbGncuKEMG0fM7YWHNjv4ets++tQkplYyMQtI4kxNQvs+JZ113JpyexSYkClmsc9Zf
	alb6rOUbSO+hC65gzlUAkeH9m2hteZlMrQnyMYNjPw61LscQjmM+PrOn6B6ekcbtPphf/MX+j5N
	MAaUJuh+XYmXmTT9cTTCaC9t5WnyfMqidQyE6+HHr1fO5YWHWUEUdyw6brQi2NY/axSNsON1wJt
	puSWbxry6WvzeSIHWPSOJ9RALv5a5rrd0m4nd5WTZvmsXFam6R5u/jWF4XyoyWe5npy+GsGuDdj
	d92iI5SfZQP3pZ6m3brg2K33FAh3wvYAmDOBgtKQd5nD1ILSfRStGwcEObjUZm/X23Lthm83vD6
	QNhuy1i1vp/ZuYU6OaP8j74A=
X-Google-Smtp-Source: AGHT+IEqHN85qJhRQ1PINudkBYmazt3d1yDiVwXAcZxkuOjtrSEpN31hW0gEWbObrF16B/ALKaw6eQ==
X-Received: by 2002:a17:903:94e:b0:234:2d80:36 with SMTP id d9443c01a7336-23e38f7f902mr45233195ad.14.1752826543694;
        Fri, 18 Jul 2025 01:15:43 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9153803esm3465900a91.0.2025.07.18.01.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:15:42 -0700 (PDT)
Date: Fri, 18 Jul 2025 13:45:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpio: virtio: Fix config space reading.
Message-ID: <20250718081540.7n7wtl2sas4o7jz7@vireshk-i7>
References: <20250717141000.41740-1-harald.mommer@oss.qualcomm.com>
 <20250717141000.41740-2-harald.mommer@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717141000.41740-2-harald.mommer@oss.qualcomm.com>

On 17-07-25, 16:09, Harald Mommer wrote:
> Quote from the virtio specification chapter 4.2.2.2:
> 
> "For the device-specific configuration space, the driver MUST use 8 bit
> wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses
> for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and
> 64 bit wide fields."
> 
> Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
> ---
>  drivers/gpio/gpio-virtio.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

