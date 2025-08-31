Return-Path: <linux-kernel+bounces-793363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E111B3D268
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C972F7A35DD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBFC257444;
	Sun, 31 Aug 2025 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gstl4kKN"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8122571B3
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637934; cv=none; b=s5nbNizMGtArdUKmeF+R/tB3esn/FfnDrcRQfC6rTUTt2C5TXgHw06Ct5t5uSsq9Oggc9WqwN6bdz4ddoCpSPwY/819/ZEIXDrYQG0f7lz5oHkf1fGQBEBYwwSorb0iYVL59igxDXjEbue/92INueG+RYeSuq/Nwo5utizhpyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637934; c=relaxed/simple;
	bh=WVIesh8/RBO7fqb/F+aCLBcMtMA9LcfeCRq+222xUIc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tc+LqB7YK3H4yW8zXw8u37K0LTFvfL3dN1CrXK40dW4RedR/MiUZA4+Z9/dGUpujL24jWspOZsJqjOsTjF2ntR54NRNXE7unWxL76wdDM3UOpPUXnLkj9WjB0kSZrjw+os0HCXxc15McZa85OA5T8+NWpD87Xntwvs5nG6Ci0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gstl4kKN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b041b155a6dso1417066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 03:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756637931; x=1757242731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3zy+4FxM6e/ZYJU6tdKRgGniGSW0dORiZkBYaBYdq4=;
        b=Gstl4kKNr1k2/CoNvVwMBDUgJaKJI7OdDt5JO+aBfCazoJEHMvMwgH6eh0DuAWW73n
         WirdSYdOIcCmUyzuxB2h0ZQ8ljC70jiyUZo5fG5Y1cDoTfrytPhmP7BUQ3EoeYw25XsQ
         xWSBw6RxxMbCGwsYMraFUnQIWxrGLcMBTUXl5j/2+JBDYkkftD2QJAURIsHa6NYtmFZs
         qlkAsbZrC/HvrnGPscZYCsa7/r1pD396RTKhoulstVuUobdQQMAQ0YM6a4z7M24bcU71
         85LA+8kNv3xADoDUSf37bc2dqzqLkMxqa0fDT8yixNXm9mde5YuzyocbpS67bnxpUhME
         gOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756637931; x=1757242731;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3zy+4FxM6e/ZYJU6tdKRgGniGSW0dORiZkBYaBYdq4=;
        b=nymtXmKOC2OY6zccaF79gm7ncBy0UNyQ/CHLiGu+SCs8d5IE32cfL7VmHAr9QpnbjN
         R1r6tFH9OAW/UsCTyu2Hl4bT9zE/+LicdYt1b6b6W5M5MI8+SQiDzaiPu3QD3fZHEau2
         4ueGnrHvZ+wO1CyO8HwzMm8kDF1pPuAr/s2Kgqphm4zvILD9jWgEYm4FWr9RSNcUs6aD
         jGst5knJ7M4fD6y/GwOKUgPxc1ryPHUUvevvvrWr7BYMZs0GsEPrLxmO2/Vkd8+tOlpJ
         no2VetW9OoaiARj/R5sky7a0ZBHcwk4CFLDJe9PKeMsOhOhS912AqagW9zsb3l8AT4uX
         DztQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHpVx/bMU/s4EwaM8/yqpZN7TS2oGOoB72IcmMWLYtq/IZ+hJTpKQ2yk7fOfN29Q/BvDEt+HeTp6A3+GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVPBt2h2b2GjcCyL0ORZ1ddyTlYiS6yO4o9quAX64vERTlYtP
	LWbS86EOEjYWh9Pv3qQ71OHXbqOt1C+fstgjn/OOYN7txAso9/2F0wp2o+kBlfMghpE=
X-Gm-Gg: ASbGncu4IBD61NjkDEPHM1mqGK+sPz60112KgbIMb9Ipoce+QVB/gtJz2DsUFu+nHnO
	39VtgB0jlghHbS4+sR9cICIRRlKaur1OiXxwg5OpctNFzNfDGL476v+q1Xcre7H7BilfswvH50W
	BYBduH5xOLEzxBP87z2kf8VbpNkFUJHqyfl33s+rkQH/k2SYx7yt+8/rt4lL8HOktdGr75Zij23
	CcC8kC/shn9Lvq729kTw1AEGF26/itcu1gzRzsFXeyZ+rfgrAs/mq3Zcq6Hc5JGYccw21pLuU24
	fJ17GybR0IYb26Drz/gQMdU7Y47R4RbDVuT8md/5qO9j3q9ew4Cox/0P9jbmcsVziKPP6qe4yP5
	R1CoXY72i9QusnI+7J6CzMrKlWpQcXL66UcjZniTeETTWCMnY/g==
X-Google-Smtp-Source: AGHT+IHTBJiyshvnvgCsLBk30RyM3YNR2Y8KXQJ7s2S5taB2fYhC2gtwsyGjCqiwFtwHqMDToZZ4hw==
X-Received: by 2002:a17:906:c152:b0:afe:c2e7:3707 with SMTP id a640c23a62f3a-aff0ee1afcemr349633566b.4.1756637930739;
        Sun, 31 Aug 2025 03:58:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b017e4b9ed7sm349176466b.90.2025.08.31.03.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:58:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250830093918.24619-2-krzysztof.kozlowski@linaro.org>
References: <20250830093918.24619-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: exynos2200: Add default GIC address
 cells
Message-Id: <175663792937.36292.10292837875011385286.b4-ty@linaro.org>
Date: Sun, 31 Aug 2025 12:58:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 30 Aug 2025 11:39:19 +0200, Krzysztof Kozlowski wrote:
> Add missing address-cells 0 to GIC interrupt node.  Value '0' is correct
> because GIC interrupt controller does not have children.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos2200: Add default GIC address cells
      https://git.kernel.org/krzk/linux/c/59abe5c87267f1f3bd627af20355b490b59f9901

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


