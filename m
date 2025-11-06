Return-Path: <linux-kernel+bounces-889144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6708C3CCFF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 319AA4F63F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE334EEFB;
	Thu,  6 Nov 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lHhZCGPx"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BC534EEE5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449605; cv=none; b=s3cfvNufpL/flC77AuIts8MlSmJN7zyVji1FXWHQelPeIONKf1nE3qYsrpUSRcpEWmkwLos6iDjwJXcyJ+rD2v8F5yDuoE1BqsAyB76+sHZaE995vtH0f203akWXdrDHj2RCIJcCeN1sk/8qZKlZPLJnLyxuoTDLhNieWALJhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449605; c=relaxed/simple;
	bh=cnm45OLWp3G3n5UF1avPywYBvZ4MfBRDI/6SWNbJ4qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6iffCrWKI6+z7GkVZUclRUVcMCKQHq/NcxfO5B9RjdVN2B+0yX1WH25cyDT3c8xvxxQmwJxY231jdWZautHxNR+8vsVq3qbWsmR7i0kU/jYkJmbzfZUNN4DLfqWKhuKGBsVLQNO20/4I5Ft0XXqdLpcijCK0zH8+j2ds60Q4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lHhZCGPx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-421851bca51so998174f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762449601; x=1763054401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF4ODf2wTRFML1B4tRmpvs9bZoB7DEQ9x1Ify504Ygo=;
        b=lHhZCGPx5wJ0XJ9EpWUNr54pzPGSjLpvkH2FM8mRxnD2olfcj0RsGyQE8JsjA6GXlT
         64pK2Rnw1u+rKx/+xiiiV/JPwZyjXdc7CikphsPHLDGCL+kbCsJnukDy0DShG+75y4iM
         FOdlhk1lYMa8/UnKQQK9vJ1OJc7gTR4qSHB3WKycy/XUzjOaLl7jACADsd5y8XsrE3ss
         7SkUzRfw/j2t1sk2YexhmLOdEEvTbDJslSguknZKHvpmHagKWy7TYnDv0FC0Uaca8MWX
         8QzzsuHPU8C16bh8I4VcymUxdx0yWP6lHDPdU375Vyp+CqhgIw5InT2VYR+7lPfV4k/S
         Xknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449601; x=1763054401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CF4ODf2wTRFML1B4tRmpvs9bZoB7DEQ9x1Ify504Ygo=;
        b=vK7JRNPHxNedfU7LOfIF/BcEPlmVzndlYYpDqQLtfViUmSKOt4Gf4Rb3k/k8t7pzGo
         PN2UiDBHYNsdwAAC1LVmr9gaRplEYmsNwmy8KysAwmzzfmojL9G5HMQat/kgYjxTtkdN
         zbkOpy8v+FQ1H8R6zFjKiZsrkFEnrx41H+mQ5JV8Ba7J1Fx91CPJIKuUON9uoBQVvIDE
         ASU+IcrrpD7j3U+4pLBRyMOGWgLIKyRdn8bVIXC9DyVQ7hSAQr7mWzNY60J22OT97Xnz
         kWtYNbKYP1G0R27xP+6+glxvetrUAuVOVo7Ai/SkH6wfpgs7Rzg42m4hwVgLvZ/6gDd5
         Q7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG22QAZzZgtfcT6qmwssQ+7MhIGd5MxowhuiLSw0fpA6jVN31SO2XfHxuOAhg/M0LYgMu9Hiza3s3V9Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLitvG3B/Zt21u9IQYe+xUmJpNuhiG/X1trw7NtfQzuFlloMG
	UO9oA+pT2nNDTaJo7tiHAxEalQvLBgrylOfhJaLdwQoU3X5fuHMIK4d5rDZkG8maMmg=
X-Gm-Gg: ASbGnctBERYgSsGbwSoFCawDew2lOb6buVqilYhDJ9IjPBY8ToeoK8XfIZ+t/jjciOY
	LH2q+JBYb6uxvxRII0K8faZ+MEl+fPxHZWj4poK9BjNxI7+E9XcLKrxpJJtNHCmkd0Ksh1yg3hA
	VZXxgeYOUWCW54ilfakuVTMhX2nIUB9kJV19DFv5P/IK/ap0Iw2vaQ1tBJXagZc8IddveHuJUaU
	WcDU0o4Yui/yIIGSPW8Tw+eqzOd9j9INcCwQz0aCJKIJbZATKhldrM+QuJOpDwiOXRKN/7qj6w5
	CcxkGWSySaTZXxczO/DGS2GiCcp+ZdUVKOhGSqAfqvJDcQ5G8j/EBJ/KP1yvcdZ+3z1jsn5ZoLq
	JuhAFdAXBRpo9DgbC4PxL4ka1hKxR/e6GoLtvQ+dckxYSt/Vt9osyc2gdudBaIWi/GqDd9A==
X-Google-Smtp-Source: AGHT+IGv3ddFv7Ixmi0z+24Qd5qosIPKUTQKcEJpg9ieaTfBELOhzQHfNLOSGn3SU4H3SmjfT+TvKA==
X-Received: by 2002:a05:6000:22ca:b0:429:cd3f:f43b with SMTP id ffacd0b85a97d-42adc68940bmr1528f8f.4.1762449600670;
        Thu, 06 Nov 2025 09:20:00 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677b41csm215368f8f.34.2025.11.06.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:20:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: Re: (subset) [PATCH 0/4] gpio: Simplify with of_device_get_match_data()
Date: Thu,  6 Nov 2025 18:19:58 +0100
Message-ID: <176244959622.43499.14570364732284486996.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 06 Nov 2025 17:16:24 +0100, Krzysztof Kozlowski wrote:
> Few simple cleanups, not tested on the hardware.
> 
> Care has to be taken when converting of_match_data() into
> of_device_get_match_data(), because first can check arbitrary
> device_node and the latter checks device's node.  Cases here should be
> safe because of_match_data() uses 'pdev->dev.of_node'.
> 
> [...]

Applied, thanks!

[1/4] gpio: tb10x: Drop unused tb10x_set_bits() function
      https://git.kernel.org/brgl/linux/c/4436f484cb437ba28dc58b7f787a6f80a65aa5c3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

