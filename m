Return-Path: <linux-kernel+bounces-626755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F3DAA46F7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 11:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A38C3A679C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C43023183A;
	Wed, 30 Apr 2025 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVPwqDSm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E52231833
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005169; cv=none; b=KWmSpiQvIWBCLIVq8c3K/5udlW/tXM5+GX2dHJCIcl58I2Bdxd7ZgpS8gU3p3e3JfYpcQp04iyupH0uUvk2Xs8h3fg8n2v0uHl2/DGQ/SnOBzVESAl2C9FPZfz4T+U0v378O3Pb19Tx8w/5AZrCv9/Un7tmTEiCAeCKiZPDK+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005169; c=relaxed/simple;
	bh=emeN+xQPR0w2hK/gMUA9tohvwWpJtFpuJ68pOjXXpCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahezodVzJ/NMI00Nzg9Nn0tt5Blm7U2ioN/0iWPyvaSGYhSV3VZ2Yl2wq9M2Rn3xR9z0iF8QcE7aiYUd1c+0o4sh8fNJMnx6XNbGO/D+jf91tB9dGGs+XDYKbN4UlBlGWzkTNWQQHZbjSSdKK4C/zFos40cBgWG9lMxFO9/62IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zVPwqDSm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so63152495e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746005165; x=1746609965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gg8+U7uhajg2zvUCUMrdqQmupPgIClRDIQQD6o+TZVs=;
        b=zVPwqDSmRuMi3bR106aQWcNmF/9pT7OmWcCLzdrkapWRU4aynK1otwdxRjzNkqxGYr
         hcBx/kNIVNzbS7JBKIsSMeURyceN339+/oSHfPbQwsO87OjCR+ONI83jIEMUiuXiYzwX
         apUITFwzP1X/HRkS5pOfzJsB7rzFvlswetd4ruCcoghk952CXfVRKNfZlIBr+jrFBZDG
         KB8U9t1gNfiFd1uUz8wYKa+37VWaa7IfLg3eIL9kK08Q7cK/XsIIdi7ujRzW3oQrwpx/
         +5fgcecZnYSDIRVhBVbE8Ble0aaMu7He/nBqExI8bKbcz4SsS7LJRWwCIvBLuBwcfdsa
         bgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005165; x=1746609965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gg8+U7uhajg2zvUCUMrdqQmupPgIClRDIQQD6o+TZVs=;
        b=h/dmdU+pFumdOQNIZdjYoakaV1UOtwv173fr4Q3NWPHCsYBFQO3EwfAeEtlomala50
         Mz8qehn+WhHie5mPs+Dbzk+C/6raA9wYpfvt4qs7ZMGKLZAAMkUF+ooHNA17LdPoUmRo
         1K6c19bfHY19lcWznX9eoLFqgS6/0DjTpal3ZVyv5bSzvMhzVqQyHY3Zu5yEc+f8pXFW
         F7/bdhkfVaPqxVPDdyZlsgnoSyJEJL4kriFFxQj+awzA//EFokRvAnoWYC0sFWXnNA4a
         UuKunCsTDF5Q3ErGQ2ouFEQIrGlv+rvUfl83faUDffUf3lqeMeEcNUNKomhKiiIhbMf7
         8CDg==
X-Forwarded-Encrypted: i=1; AJvYcCWdcCtO4BLvelnqed8mKXQB0tTPDGht9+hsBfO6fRIsOYMFW/VQGjR6AsTRnHXRegSoxBXh3rO+NbZXQMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwukkErjbfslinhc1IHmfhbm58paNVV8k3KBfdYcOvdZ1PG+XA1
	SUcER69Lvbv8creMRGT5rEV/yeS/P/4pT8K2WM7WeCq7IUG4Heh7upZsiwGk1R0=
X-Gm-Gg: ASbGncsyrPXwoSwPLwDyDfePNFjxDrgCl6iwXc18Uu6fLZD+ykG7O2lLzhHvJC9Iaik
	Ok41QtxbrF0Nw6nLRQoW669YO9xXSAVU0+a3Py/XTK40mo7vDO5NgJhf5URVL5+bBJ6Jvp4YISf
	TfFeKkmD/mnaVl5Z0WkOa27AyasLXZhYLMiq1COPRSuYjtlo+8im5gXCpNhtJno4eaNZpXKTujg
	J3qXEf4gsJ7/5jNDh/Wy0xgunJMKcl706NnG0y9zhY66foLR57qFUReLwxGpP010NUs124jz6JN
	S81a08Om+Sn4kz5NH1RZJmCOdDSa32Q+RGgCeA2ruiQU8Z7L4B+im9+5DEC+yA6gTLXZw6lC5ph
	UEvjq
X-Google-Smtp-Source: AGHT+IGeU+1g/ZzusMepn3Swj4cy0n4ZXYGf5XGELdjXdxHsUaERxZxPSUk0zKSfnUqF6M2pw81X1A==
X-Received: by 2002:a05:6000:4287:b0:3a0:6b91:fefc with SMTP id ffacd0b85a97d-3a08f7d22d8mr1934468f8f.50.1746005164916;
        Wed, 30 Apr 2025 02:26:04 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a073c8da58sm16614490f8f.15.2025.04.30.02.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 02:26:04 -0700 (PDT)
Message-ID: <542d80c4-edba-4b5a-a47e-8cb1d76e4c89@linaro.org>
Date: Wed, 30 Apr 2025 11:26:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: amlogic: Rename Uptat to uptat to follow kernel
 coding style
To: Enrique <kike.correo99.f@gmail.com>
Cc: glaroque@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <Z-MEZNMLUmj75uxN@debian.debian> <aAImJGYXFDx_q8D_@mai.linaro.org>
 <CANfmkGDVks5tqgDw0ZvNMxT_vfD8rUKyZZJ4LUK6k637wt7=-A@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CANfmkGDVks5tqgDw0ZvNMxT_vfD8rUKyZZJ4LUK6k637wt7=-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/04/2025 20:47, Enrique wrote:
> Hi Daniel,
> 
> Thank you for applying my patch! I’m trying to verify where it was merged.
> Could you confirm if it’s in the `staging-testing` branch or another tree?
> 
> Commit hash: 84fe0cc6fddb6afcdca838d80756080f84cf9ecd

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/linux-next&id=b8e05d5de934c037594f4ad3550b8228da1b9c2d

> Best regards,
> Enrique Vazquez
> 
> 
> El vie, 18 abr 2025 a la(s) 4:15 a.m., Daniel Lezcano 
> (daniel.lezcano@linaro.org <mailto:daniel.lezcano@linaro.org>) escribió:
> 
>     On Tue, Mar 25, 2025 at 01:30:44PM -0600, Enrique Isidoro Vazquez
>     Ramos wrote:
>      > The variable Uptat uses CamelCase, which violates the kernel's coding
>      > style that mandates snake_case for variable names. This is a purely
>      > cosmetic change with no functional impact.
>      >
>      > Compilation tested with:
>      > - checkpatch.pl <http://checkpatch.pl> --strict passed (no new
>     warnings/errors).
>      >
>      > Signed-off-by: Enrique Isidoro Vazquez Ramos
>     <kike.correo99.f@gmail.com <mailto:kike.correo99.f@gmail.com>>
>      > ---
> 
>     Applied, thanks
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

