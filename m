Return-Path: <linux-kernel+bounces-736460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9A7B09D20
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053905849BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDC292B58;
	Fri, 18 Jul 2025 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2w5yPR0U"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440429993E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825389; cv=none; b=fQZ7QOhWl1//0/oSNBDECUa4b0soL/mvVL1LVrcg32H0MEKtELVpt9GW6P7hVOJ+rnyFJkqZoUyeW4rMspdoozFAGu4g6pDI/4num/vNJqJX4cX1dSXP/+f7zW+T9V44slKW+ZELH+jPb6JiVoXLoLXBM49pwTeZiCtYANMMQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825389; c=relaxed/simple;
	bh=1fgqSf5aAC9jRJPk5Bk29Dz6jUVTr0soJ6WtJ+UinRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePkvTlaN+I3b73ecYbZOyYnrOeKJlCG8kfO92gWQnJ/5aYqWlEyvMfok7FMMXYYHe4V9AjiShzcXM7Y7oTrSr22DnLz+8g1Fx+gLRh8Mq+eHPU/49m//YUdZiyq3+O9fdE286ZQFukwN0Q+uvbpJVu7QjpJgctEyrgxAN52RUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2w5yPR0U; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a582e09144so973116f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825386; x=1753430186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KwhM/lf9Nerwdb0SADC6wgBP7Bye9fmYsylLUyZDbk=;
        b=2w5yPR0UMI8mfGGYgNQRl26/E2neRmbP/IKDoGmd0rCvqnZjJetcKi7HIz7PJjOOrF
         8HTSOoJ1c1VN2Yg2CXzkMK78LOlnjsFnvzwycn25Rlrl5UgU3SAnwAMcWceypOZkZkTk
         I1b8jyczUAiJSIH0jxEm/nGffj9Jx0JEdkaJXmjgK9RT4ISBB1XFN1rpp5aSze95Iypu
         WSDuaFzNarVcR2gvPbGz5GqoB/K1v+SmRNSGvgt6Xp0UmMB5FnCC2dFjxITOIFUTXxAA
         IN5xa21bd9kgFKrtHUpcM1IaiHihFckLiGIrs/A28gPkdBN1B4CvvcyamBtbFFgd6nDb
         NGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825386; x=1753430186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KwhM/lf9Nerwdb0SADC6wgBP7Bye9fmYsylLUyZDbk=;
        b=W6D3yVVAkzi15pf0S+vdf8JUtgsBoKNigY+vfur/aaemS0hglhXPT+eE08CYra34RR
         vUHcgN9voZepP2Yj8azC9BTDA6cpVlr9iYST2B0Q72Kev1coW01rFQrcba/rBBBI8k6A
         WXjl9m151M96dExfIDkbJb373xLq2HuvH7tfnROoSW/ldzQlZs9oxTnBy0yDwjoZFMWe
         1c296NpeKGXnFtbr1Tbq6urnB9djMphOotaf9Fcrh/ZhJf8BgiyQI5dl3bsyQOVKPWfB
         19e73ojHZxSowjAavq8sRqf0rkIzInkQ2CPZ9yGpV7cKC0yJyJB6qvHyjgJ8bG2Qplyg
         rmJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk8glGHSNTq3WKG4LaGHWulMvippAeUmraBVg2E62KCmuOIzmnICcugtQCHwP6HrD2yfG/Ta+x5+uSeV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4KHjp7Rv1HRYngYrND8WTi1SdBtrYvnrvIonno8zbdYzuA3I
	YJNMXarti1zZdtIUicdz+xUzLkSu4UfVgZOxm8ydwj3f/GhI7nl8PC6mU9wIeyhSzH8=
X-Gm-Gg: ASbGncuMRcJnrR4LfkYZ1PZdlHR7ekMsx/PrJkCBAT97QuDswwmNxgB8PqxW1k2XdCs
	+tGVmHqqAL/kw8gEsh38hmnoaaPSgOreR7cEJBJHIjVVUrVfxL2dCSLWt+NVVI3itfYMUzY95Nk
	59Q/2w3xwWsH3QIA8mi1EDt472EC5w8rhUh19I4cAeq6eBVMZiajXJYhPrP0eThSps+6KkLUf5M
	5SIGCwzACI1r8WCM4o1sVHoq1yMrIK5rR7yBEwa/YcdKpxL7TTnKyhre6VsD5TIi3hbb8Ok1OFz
	uQpOuLwYYklJBXqlac4ceION/9vly4AyxFYr2qjr+mOY1wBPOePOs5Pr+5L14jCgplt6A0YsIiN
	zJGPHQ0hIJBzV1S6ntfZbtzMmSBILK3g=
X-Google-Smtp-Source: AGHT+IEfvTTvP20bsmaiA9C+HGIRVnrx6tPmoJoYFi4Nc3WaHVBeqyUGFFLd1Kw4CHeO3KYUvaQJfQ==
X-Received: by 2002:a5d:5c06:0:b0:3a4:ec23:dba7 with SMTP id ffacd0b85a97d-3b60e523dd1mr7539382f8f.31.1752825385991;
        Fri, 18 Jul 2025 00:56:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:24 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert maxim,max3191x to DT schema
Date: Fri, 18 Jul 2025 09:55:55 +0200
Message-ID: <175282531517.45055.2981352382275082151.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202843.3011698-1-robh@kernel.org>
References: <20250714202843.3011698-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:28:41 -0500, Rob Herring (Arm) wrote:
> Convert the Maxim MAX3191x and similar GPIO binding to DT schema format.
> It's a straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert maxim,max3191x to DT schema
      https://git.kernel.org/brgl/linux/c/696d8332e591b11e438c4bc17528fc79255f4266

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

