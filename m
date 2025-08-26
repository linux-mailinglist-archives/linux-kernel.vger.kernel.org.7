Return-Path: <linux-kernel+bounces-786427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7FAB359AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98EF7C2ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC4321437;
	Tue, 26 Aug 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xUaOVQju"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F273009EC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202352; cv=none; b=CPIETXPfAFDRWGBlCYLEIGv3i+CjsbciIfR2uKwil2OYuDkVs9SlAg4nlFfQosWImax22R1xRh2DQuhpOQ/EuOg03a+SwMKYey2FbBrbWtfZTQFbEQ1I231ZcDiNMZYKEzdZFqxJIotztEkGsP8OZFYnCSJw3KDbIzXTt6oOpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202352; c=relaxed/simple;
	bh=TLQe8HKqVprzOWSS+QrcEEJ6qsTop6HAIBHPmWLduOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=He1Q1Lv7xLLdriDHelxn3nv9Fry+o8St4riMb1pqDEg1vehVbjmNYXTfzWDrkMqT09V5IhmoCeiZEfnoenmA95aOzKY/+6hz0bCC/wy+QnVP7ICTLr3pgVRjpN1sde7VZwx9yXnGfNn4BfPwNH6CEuxhz19lDZ2SHqK4CgcVFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xUaOVQju; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b5d49ae47so11937135e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756202348; x=1756807148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+Y0JVb+zyxoD2ZTloOvpkOul6QpmpNVbYqGaduRqGk=;
        b=xUaOVQjuS0XGQY+NggXHewaAIjKOx14olU/RNXG73mRF4WSM03fmRopl4J2XuYuOh3
         +mEgXvZUSMz50uVGVAfB35hfs1tzJdZYdN4aPGPacB+r4D79aNjpJTxxB1U6nRNurJ1t
         7e+fXNu1B/NR4T8X+I0wXChKM4Ztm1LwqSURefHJnnzAkS2uPeg+jh7xdYRuLOArv/l1
         S8CNeGEy5I5Jvhf3m4bFomHwnQzYZj4L538SZ0j35MSnnOj1AKKXpNv6Y38b61aW30PG
         2nVcsrjNdKxb8Vf/u43oj0UhnYc+49tgAx087kOPn817ho/77+5Di5i2wvORoYfPimQ3
         CzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202348; x=1756807148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+Y0JVb+zyxoD2ZTloOvpkOul6QpmpNVbYqGaduRqGk=;
        b=Y4VvejWhG4AlHNpbiqKZrB3Xl/26LAwKAfJ01t+9Pmnyi1tl6SqaTkDbyj4mSmG+cj
         JID9E0xOjS44SGquLRzugsvgeflIZB33pUT1q66tUs/B8oVJkEbUPcFAXPViKfQJMS33
         Rl8N7kJWjQfStkV2+6u7ev2oOWWhqTEmjjXJ53hbBrWTKId5MPvy+TcTK5QSTxjo7gUC
         LA0SAPf2+F/Hx1qLcMCcNhas8HV4jVR4W3Bc/UZNLTaTucuNfLP6O42+c0ARGw+MLXUg
         MjaNPjL5b8VHGHoF21KmCs0FIWOTyPBrShNUmOt7HiShA6ZauS3XPa5b9DUarpGGCDG7
         QVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNh1nn82IY1FvELvbLA0IHhz05yIyMlGe9OIAkVYfUxZ/tYGh04ze4oNGeubrMtZh6MMixXMKkELE/vQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2nzmUVBWlk05au9xpmQ/VKvP/pAIX2doxJKrXMGFxmJvUGBqU
	A7D4EhI7W73Sz/EaVPv8i1U94+I3VSlmPttc/vgD08yKzXmHIgHLVNX0KCTKJY3eRps=
X-Gm-Gg: ASbGnctmEPQAG1Jmpa6A85ddpKXAoPrmNlFtyP+PUc0ai9FX2tiFfqL7j8ddasJINxA
	vTR12s+Q2MxXNeeydVrCNOjQac8jtKF4xzxZvvn5beppfuiLlZT1T5XF4wbKfmcJgS/QtTdlJBW
	jorb/r/t+1RgcyfKF7u96dCNPke5jGyIRwe30tTfHp+rleaaehBKLAljEpr6s/pO5+E15Bmvdie
	ayWUF0zuNTlCVzyn6f7g1eIOt/2FgFQZEhqyU1JS447pIIkLfdqSuvk5+wRl+/v1eLbci4mUPgI
	jjmg9hQQfkdaaj/bbyLaV54cmyyYob8lwnvuo4y1P8zzUOnQ7AoYMU1AjkT2p+pj2ja5hmbfl+O
	KLMvfByj/MJQECzzD/dVR06XyVSH6yWtJtcRvlSurtHcKig==
X-Google-Smtp-Source: AGHT+IHBhKg7IjKrhhcVMyL/r57y1ugEvw4mEz2iVwUNncB45EjnSI4PTdqiXHRrUmtm1gPJ4N/MCQ==
X-Received: by 2002:a05:600c:1548:b0:459:d709:e5b0 with SMTP id 5b1f17b1804b1-45b5178e893mr140193745e9.5.1756202348058;
        Tue, 26 Aug 2025 02:59:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6300da81sm60418635e9.23.2025.08.26.02.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:59:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: gpio: Move fsl,mxs-pinctrl.txt into gpio-mxs.yaml
Date: Tue, 26 Aug 2025 11:59:05 +0200
Message-ID: <175620234226.21143.1718612785479357856.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250820164946.3782702-1-Frank.Li@nxp.com>
References: <20250820164946.3782702-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 20 Aug 2025 12:49:45 -0400, Frank Li wrote:
> Move mxs-pinctrl part into gpio-mxs.yaml and add pinctrl examples to fix
> below CHECK_DTB warning:
> 
> arch/arm/boot/dts/nxp/mxs/imx28-xea.dtb: pinctrl@80018000 (fsl,imx28-pinctrl):
>    'auart0-2pins@0', 'auart0@0',  ... 'usb1@1' do not match any of the regexes: 'gpio@[0-9]+$', 'pinctrl-[0-9]+'
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: gpio: Move fsl,mxs-pinctrl.txt into gpio-mxs.yaml
      https://git.kernel.org/brgl/linux/c/66edbb1e32eede16b261a90014451d67119fc875

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

