Return-Path: <linux-kernel+bounces-792852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF1B3C9BF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA9E177D16
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C7825D209;
	Sat, 30 Aug 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5RNrbR/"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FD25A33E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756545599; cv=none; b=eEl/0QMEzJf1cQRRGloz9u8+rtj0fbWhxE6NFO+P6uPQXc9UX7aRMvlySDViB3a00xDdjGh+f/1I4yFmyb2myVEVd7vMstQmQ/9+aug3vxJBiwlZ3tkfYfEjLt/9xzotRa750rUYaZBV8BCCm+T+AQxmu4EmvRMIivDAbn7dNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756545599; c=relaxed/simple;
	bh=va4dxn6FAG/rkvLkOTSt+fhm2FMOlsveamQ4+F7Pdck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sjVvuoB5pwz6U1x4BD28TPMAOnrasZiVFXfsMSxICtYviJGLtlRfOOrvuqhrOEOrXkjSmCDLY5oRlV5UTGOs1tUZlZgG0LSvjiBJffTAKziKzRxd9XeaEnVjeN5/GiR3l9+sAYIEOxY+1fAaue4cGgc7zey2psiJTmqCO6K79nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S5RNrbR/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3cef2c300afso296293f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756545596; x=1757150396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwyiQhik7suc6gbVzjEP6jIHrXVEYERHfJGEwviQmSk=;
        b=S5RNrbR/CfjqlOJgyGUQ67MZepqHnH2xk46SBgU4gjvfMslf5v9XiwhTH7wVqzui7Z
         58HMYAuORzJeTYHDJjRPXDZ/AYmuw2kAJwds7+H4nAgGIwS8ibBx9TTR2H4GCBBOYCkF
         0R1McOE8MGIfVGz44G8YYc24EVELSZYNLOrRQ6eITXRVrnEnD/agjO+vjbKuFC5m5ILg
         txQ/7z4KRuyjbaO/HEsLM/G4vHHQiAJDAUvoMezihmg5O0IikJ50sOGE1seh81j/Kys6
         PCXDeijkoY1pZaxUGu4PL2IzywXWhjke8hjqDcXdzSdJzuTHbEI3JKCXGtfjGeE37HPm
         Mx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756545596; x=1757150396;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwyiQhik7suc6gbVzjEP6jIHrXVEYERHfJGEwviQmSk=;
        b=vog9rmO6qoTdK8/H7IX4gAClW4OwCUGg27HlT+sgIOV71Xsfh16CY0Ei31T0Er12Ru
         TZQ3KljE9jU4MI/w5nIMj9+eNma3VLKnudMNvHb0VUabO4US9AkuKTb779fNUipGqNQ7
         XlUpEQb3NwJBRI1ULLrBVdZJmyQ1QNNL6PqCY4QAzIZv5CSg/j3DMj1oRjeEXK79+4HO
         PWfEP2orQXqkIbQRgBrJyXjY4UPBz5FiCE29KC0uFXt5UcIh88DXolcjnXVp+hxhB0o+
         +tV+H4FcVsFecLx9uYzpyOeI18ugmuxoDPF8De19Q+EJMyotQO7EZcOOrOZ6Zwt3Eo+Y
         zQeA==
X-Forwarded-Encrypted: i=1; AJvYcCVmLqWiuGieI5Eqdd+jwRkVcElnbDSCQuRaQ657YIgLXYnRQVpVPTbwAFeRVzWrpKNV70EaqyAIS57/wk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1FRmVDpbPp31xk+TwNWGA6jof3TMUXmOcMD+xwdQHi7QbBTWK
	kae8Swe499KhDgFwWVWUiuC1DLNDx7zXtmFrbnn8+SjjKs+C3FtsoWP71ivGSQwBgII=
X-Gm-Gg: ASbGncs8olkZiA1b0yyr6J8LkZp1LIIVuga61eqtqD67CTL5lidIHwmVrcFe64vjWvL
	y0qtkWwXsCrXAgqpIrWGMPiyTHlQf+pasr+xXBBN0ePgI0a1DbXz6vZ/SaoadbWtAvic/MtsyGi
	ZfAtSmmZP8gNH5XxIVbMuMKmbTj3/E33a4anEz0jvGQFUPIPjiaIV6BSjUKWeNq8JZXW/tDBGMQ
	h/OTaCXPWLs6HLRS4N1aX3h4TKA7bIhTYZVG7LBNwGjiCd//ExEuogo9IbpAzJT6UJYpFyj2A89
	uW7vy49HcAsijN8QkEmbgBmAV0k8U/fRdaEUGBGQYQrI1QwEC6S2UxN7EY+R//naCU4wXC8YWCH
	0ubdFs1AcwwihfrT7ZkJ4izw46NtJV86+KdE8Iu6DqdgW9hf45A==
X-Google-Smtp-Source: AGHT+IEqjNRxfqqCNOguFU7c3K/j2n3eHHM7h5HhcZ/u9DnUpSaUb/8k8UWDRGTaDD9Zj2mt2IJwjw==
X-Received: by 2002:a05:6000:4310:b0:3ca:4e3:6e82 with SMTP id ffacd0b85a97d-3d0fcaaaef7mr1613229f8f.11.1756545595916;
        Sat, 30 Aug 2025 02:19:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8525a94bsm21186815e9.15.2025.08.30.02.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 02:19:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250815070500.3275491-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250815070500.3275491-1-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: [PATCH v3 0/4] arm64: dts: exynos2200: introduce serial
 busses, except spi
Message-Id: <175654559458.10738.12093256253809127560.b4-ty@linaro.org>
Date: Sat, 30 Aug 2025 11:19:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 15 Aug 2025 10:04:56 +0300, Ivaylo Ivanov wrote:
> Hey, folks!
> 
> This patchset adds serial busses, implemented in usi, for exynos2200.
> It's missing spi, due to me having troubles with reads when testing.
> Serial_0/1 have not been included in the patchset, as it seems like
> they're encapsulated in usi blocks, but are the only implemented
> protocol and/or do not have a dedicated register for setting other
> protocols in a sysreg. That'd at least require patches in the usi
> driver and bindings to add support for.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: exynos2200: fix typo in hsi2c23 bus pins label
      https://git.kernel.org/krzk/linux/c/1219992e16689f4937a333c98d90cf80ba91860a
[2/4] arm64: dts: exynos2200: use 32-bit address space for /soc
      https://git.kernel.org/krzk/linux/c/ad8ea30db80f825215d071370989b8ac45298a1a
[3/4] arm64: dts: exynos2200: increase the size of all syscons
      https://git.kernel.org/krzk/linux/c/0dff00633bbc8566fed6483daddddfa0dfdcf83a
[4/4] arm64: dts: exynos2200: define all usi nodes
      https://git.kernel.org/krzk/linux/c/1bc8f09ce98ca8a56f2059c9a8fe26cc351318f0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


