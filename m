Return-Path: <linux-kernel+bounces-736465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1502B09D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5851A1C285FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7174293C40;
	Fri, 18 Jul 2025 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LF+KcaSa"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B429C33A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825395; cv=none; b=b3hfGcGBMcr1c+9pqaijtaOoWmCTngJUVnF6tIy8Nim732C9jc+h1LCgzazIAvRYqRZoH0GmC24TXQVaEBoD3HkzU1s4zNfzoEoDmMoQp8YVXf+khgY+Bivn2s8reKM4s+v38IBtUomlQB2hrWCz5iF8nLIjMNIRy0LirSooCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825395; c=relaxed/simple;
	bh=9ojAwmVyzkyjw/JHV/oncADnzoHfQo87GI9xPiP44Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+gSJMsSR6THJgU9ooXKQEzbakJjiM2yN9IN2aDDKVJhVr/aBergH4u//M3CgmlM36ShVdzeKJYnNMX1ErLbIzF37GX2MRxco5wio6g/GdR+LNQjh/W9K8qdMhwp+avQJRNBPoKaWcKBdPIA07xlSk5ObRAzW6vJDrPUAdqrrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LF+KcaSa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso1607435f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825391; x=1753430191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckV+jtDuK4a1URfzEn0Dotj11VNsvgXwo2gZXZRoU4Y=;
        b=LF+KcaSaky8plZ9KXwProCpxRm0KFClyIE+rAaT6EzT8VnnLRnhBFu52Jza2oxZOzf
         oH4S2uSbC1HGRygvc7VYgRpkT/JNumOBpxsp6R5fdH1gmN+MlcfJaf93K9nI9ijRvucg
         Y580faLAgpUfaJoM6KIZKyWQ7wRvdL70QQTbHU58rsmsIlIUbwr5oyZTpUN9L/xIDpHS
         dComYsGF0qH4Knz5RtkGH/z3H8EbqdHDIffm52sxxjjrR/niY2+iruY1T2JSb48mSFf4
         WXsahzJVuIl5uKRZ7/qkH6g8gYm3xopbweGGWzLcASdOUYTUYjhfLZcmStYue72rxBiL
         h1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825391; x=1753430191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckV+jtDuK4a1URfzEn0Dotj11VNsvgXwo2gZXZRoU4Y=;
        b=rHmulN4xnEjgZ15QwShhPdkvwnNvSurxx5LDuqyfV5XeCSorX5gJtYtZM5jqaLzuoO
         072x0RNOXEEtIy/8VapV+ny8tFOk0ddVaR3knlrjEF3FSFq+TZ+ZdIe4i/rV9JHOKsdt
         GEqzNsarsG0AvzwYCM1sWfyiiytI2AiLHOffyizdkpPNb0/xkymEjkJuNE3bKitD8g80
         QAwMGB3FDhucF5ehuKcOr6FtlPx7ikILwRaMrJPCo2cxvmDTEiSBchyjLiD0rlAU4Ns1
         X1kcYC5gKUXmWKUf0u04N5q+b3j7uhPr943vf/eKwqrlZ2BIgOwLFDJllsu4LEmQ/RjN
         APYA==
X-Forwarded-Encrypted: i=1; AJvYcCVQtZ4ZuZb40zH3H745Whx6S6Uii4oLxQvWk7JuSwym5yHQWADOP2cZHR38goiSMD3qZGO95JJPFaI7Doo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwznTJ5Rkk0QNYwtpmGAYx6n/gEpoO1H+Am7pytf1cU0npHiUBy
	yVC6YJ1qI26hxR025tdHPgqNyHnMe1CMX3NhTJR0dfaCH9amvoAXRWlByDD9SwP41uA=
X-Gm-Gg: ASbGncsQtiJj3wIHXw5E4zDjH5K83l6HWeKto3ynK57TQoPHYgEIaYjzbhGz4BoKlp2
	9OvXo1qM0WWn7xlyrm/ShZ8DRpxADQ1d/Yj+/9BSDOFq8oRzWT62KwJ6MlpG2MxR5s4O6du6wU5
	SfA+JMcFDcnmu9TwK3NMgbxUV7aw0IIn3xblrqLRz4sEKkK9P0VmM8e2yyCw0AlcozQoDQgXuHz
	O6n2ZI3fHm6oFNVvW4GmjUwrXWr4CuN76EhBQXDRaq3I2E+xPGLPPOMAoECHCUcF7uMPmeOKstt
	WmZRP0roYA4LeNIBgce+7TLGFyWuyTrnpfPJ7WbSoTno0Uuy6tg6rHBGz5Hhf371clOOOQQz4PL
	CT8EBh4hbb8FCjOHluIuD
X-Google-Smtp-Source: AGHT+IHHfzVdB75isJbxOE4IprChk5aDxsZwB9rMG28675J8E1GR5pJQu+Z+X8Cs4aMgYfRSrfTMdw==
X-Received: by 2002:a05:6000:2484:b0:3b5:f8d5:5dba with SMTP id ffacd0b85a97d-3b60e51c90emr6903564f8f.30.1752825391521;
        Fri, 18 Jul 2025 00:56:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: fsl,qoriq-gpio: Add missing mpc8xxx compatibles
Date: Fri, 18 Jul 2025 09:56:00 +0200
Message-ID: <175282531517.45055.4508674496903135144.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202941.3013390-1-robh@kernel.org>
References: <20250714202941.3013390-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:29:40 -0500, Rob Herring (Arm) wrote:
> The fsl,mpc8349-gpio, fsl,mpc8572-gpio, and fsl,mpc8610-gpio compatibles
> are already documented in fsl,qoriq-gpio.yaml. Add the additional
> compatibles that use fsl,mpc8349-gpio as a fallback. With that,
> the 8xxx_gpio.txt binding document is redundant and can be removed.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: fsl,qoriq-gpio: Add missing mpc8xxx compatibles
      https://git.kernel.org/brgl/linux/c/1a17da5b6bcab1d46aeb83a3e6f3904b1b1940a2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

