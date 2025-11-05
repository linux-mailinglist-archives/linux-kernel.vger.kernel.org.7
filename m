Return-Path: <linux-kernel+bounces-885901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87881C3435C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A7C4244E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A932D0C8F;
	Wed,  5 Nov 2025 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okarLFN+"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3B2D061B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327527; cv=none; b=YTVEf7JI0JdagPf9SkqkjUUpgxNTTCUOzrepMGHTxEx76lN9mrb+zSqFyTh8X8k9BtsH7oDy06q9DBWhvdcq7DVHUB/dP9cRGA2sfqzouOyxtAsgo8MQCqFZ05azbBwUzpMoyxTMRq4WKuGn2DRHaXg8NBi4d1UllhVdBr/JsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327527; c=relaxed/simple;
	bh=9STBCQOILyz749lFbNAuvnKVBlSgF+Sd3nrxQOUQ2Ss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iRq8oOokkaRYEspeqyOUZ5LJ1AFPhKJtYCXtBUEeyhbFdDkw+McAm/FMlLdlEctgpE3KTD6f7AJUUIvwAkE01TJZ51236YQaz6gPpkhXGqgreArRsqJbauwgzMUjE9Rx4dYLleZw/WWXtmsTRwxLKIOVBF8IeJJtoBApWJ1kj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=okarLFN+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b725c6be585so17139466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762327524; x=1762932324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBCEYpPk6nDrVD/DXvDSlhdXPOYf8NnBeJJnqXSBeoA=;
        b=okarLFN+Y6fU58s/f/fVLwHP45+cEZ1LVB6busXSzC57prwLbSDD4a/lPnhz5RQOkP
         FmvAfjveikEU2IL4ENqUGlhYZKhnP51CChBC7E841eefz2Xnp8AL1M8uvqaYJ6iZkRhR
         ZBFt2L4cKWCGeNj7DGwCmi7jx6PpMFT+DmNtYEPiCMsgLYk0y0Zu/yef6pzO71aTscRc
         R+Aj0ph3eQg+CnocvQIXoyMuiao71HJ84byFh+LEYPrlIivifca16aHtkaoEm6FOJSO6
         QyCqcaAH3hwuThglJO6MoNpmcpF5FclzcRUYOanK7Rh62O8ZeAe5L0lQx84RGtgpFpSY
         +vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327524; x=1762932324;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBCEYpPk6nDrVD/DXvDSlhdXPOYf8NnBeJJnqXSBeoA=;
        b=Xd051f/puXhlaGTE6OAtJ4CZbcD4lyW6c6dxM2CO0g4tSaue9KT0XC1JAtW+GWXMWc
         +mhiDIzxYuR9nEzps1XsFPdhUlq8n9I9Xb7jbLPj7A0pskSWZVsZFGWJjyLut0A5jmDX
         TvV5ZxYOWHlm9CCxMzOmWi5vUqmyn27JSKZDK93XDTAiDFDOBonvce56mJIiOXLkx1W2
         5oROXQTiWIyZWMUZDiE6yJShgzMTNnCeKxsSYtQNbYtOBTjYVldhlPlrpxV+ZLzzAwJn
         Ognootb6I9YU7m0RXHDMMK5loUgyeZ/pN9dIGzMPb1bGlvxvmR2uvGca2CwoCMEh6rDR
         nrUg==
X-Forwarded-Encrypted: i=1; AJvYcCUnG/2XW/d/EykSqHr3cJ6g6xz8GrZ+oXKlmAXAZ1O+vRLGptICcAskpf5whSHaj8b4+xM1nEWpQBXPtbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmGmndNIaWScXgjoByf1K01TYdxOKI15xDesx3EWiL8Gpk9SQ
	FbNQ6ee7yGFqUiilbH6EOqyZ+G4fvR8sjdN9BTJ9UDq8UcCrS/m7wu8fhoaUGivKjvw=
X-Gm-Gg: ASbGncvC8GGtAXkmfCbshLWbY24Ol/9ugmeM6plCfqCbYz2sxji9QB+TMmA4Ia/Uzfq
	Cs5/5lW/Hem0xcRZJMtnw5yYYx4DGPEqyh54kC+9pY4xIU864PQuvLccVhus7ex4CQDuTZ4vqU6
	ffrxtVze/no7U83aid7bMzhhueaf9gFKF4P/pD4fEQxokLJPikLsBNv4VZdrznWp4hYNAlVOsty
	rNyjFw2oX9QST5YuCJRSYKbtxOfyhWFItqd78N3dL9035YZHOCW40mM3pb2Sa0TKkskkhVVOJ8L
	0mbD5f+O3KVmiJhpwH1QLaUzc5bqJ3dlMmzw/mrr+FXB1hAIe3LitXpO/eg+bDlBJ7MX+dfNy9a
	z79iv5sPvcx0eVUR3jin/yy3RM3ts3gRvxsuV+YsBFRzOcIzG/TtdEFagNO7ApKaFmX1ZlHNiHp
	Ccvtf/xGQeBZ1Hl3BE
X-Google-Smtp-Source: AGHT+IEnjtguPuZ2sKAErgkJCvf8b73YR4c88V8qvFIT7wye40P43wR9p106dk24VUSPEEUbZI5zSQ==
X-Received: by 2002:a17:907:60cf:b0:b71:a627:3da5 with SMTP id a640c23a62f3a-b7264e1235cmr109681666b.0.1762327523668;
        Tue, 04 Nov 2025 23:25:23 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f8c5bsm411534866b.20.2025.11.04.23.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:25:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251031-exynos7870-drm-dts-v4-2-c1f77fb16b87@disroot.org>
References: <20251031-exynos7870-drm-dts-v4-0-c1f77fb16b87@disroot.org>
 <20251031-exynos7870-drm-dts-v4-2-c1f77fb16b87@disroot.org>
Subject: Re: (subset) [PATCH v4 2/5] arm64: dts: exynos7870: add DSI
 support
Message-Id: <176232752223.13426.17010346252705230831.b4-ty@linaro.org>
Date: Wed, 05 Nov 2025 08:25:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 00:50:16 +0530, Kaustabh Chakraborty wrote:
> Add devicetree nodes for MIPI PHYs, Samsung's DECON and DSIM blocks, and
> DECON IOMMU devicetree nodes. Enables SoC support for hardware to be
> able to drive a MIPI DSI display.
> 
> 

Applied, thanks!

[2/5] arm64: dts: exynos7870: add DSI support
      https://git.kernel.org/krzk/linux/c/fe02894a1930c85e542e5dd2044e6a3afcf717a7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


