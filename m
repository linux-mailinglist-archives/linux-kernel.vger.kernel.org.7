Return-Path: <linux-kernel+bounces-885903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C20C34366
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8382318C2A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F812D3ED2;
	Wed,  5 Nov 2025 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJeAXZSE"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055B2D3EF2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327530; cv=none; b=SQugpXI7KNRbbBiBYO/xGn7Sf0d+1OjTP2DAHCsF83V4zK9Pddu5gZpNgnZxIf7u7c0/ONoX9lxpIdgiFD5LdUc5lMyKYaWgbFr5bypFwKCnz0qiwSlk6GWbHdyL50oZyrO5WY8PXRgVYvaSoIYGELNqFrwjPIs87f04Q4S1GCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327530; c=relaxed/simple;
	bh=9rhD4dmDekp23csqlrhuysA0+MtGz+uIxOlCxPQhmZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V81IJKIO4EHZ+x/K5p2fCvQslDTZtbQgFmZ6khXkXj/yP2sEcRMkPjAXWgDZ/RIjApoVm6FVBle0J593R7xEvUrgl7mzfzw4OjSOeakrK+L1FQdCycr04Fv3olSCuXL2qaYu0ngq6qR2AoIG9RBU7m7rE7TbtEowx29Ag1RP1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJeAXZSE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b70b338426fso37206466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762327527; x=1762932327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtTea7R3YJBuOC6RfV8X0XMfpykeCTOh6GwDCkF3AOw=;
        b=pJeAXZSE+a52azyJCdhLFC1UqOfLMnGAFb+bI+cgWgwcNdXeJt9k7PvotwSLC5eJOl
         rV/UOZUPNW1lAJh9CrLw743+entQL07yKfjzjLAoqOfaGERyHPPrX8nSpu15xoyv8Fo6
         BRPyS7qibTi5J/zRkwm/ZSx745ocPb3tCe2cciW3dWMDoPmfZV/jpk250HXK1S9x1ey/
         VsLhvn0i/+A1P2Ck8k1c6RowrUIbrY/CFOoGcjSTgD1wBgPFYjgTaTqajUF4G44ayliB
         iDH+GgbwPRWTmll2LbFhfEUv1GZAfF+YbkzjG4+lNwN50lcljL0B2qFxfxujkcIMF/Gs
         sAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327527; x=1762932327;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtTea7R3YJBuOC6RfV8X0XMfpykeCTOh6GwDCkF3AOw=;
        b=CpNKmv2QzNYwwHXkJ02or3h2dfrNVfjxzYpHpiY9mRnP3i5tBEwdHHy2sTP69QhSYl
         cgpQe8RKZmppvDT5EE02J6pJYKSjHvrv28QfXAuIiIJP6+/o1XaxlSg7c51dOfmzqko7
         prRr3NCD9k5f0RWsFxGt4PHOFWZHakDqw3o8jVUbBr/oN5rVHow8pP1mc4QGCoocv/xA
         F6diEPlfYlyFwKH26vQ9ssIAQlYyR3Z9OENImtDNznUkQ3sCMyOg0VoplaOVHXnYow7w
         qFsnXwYKPDfiBwWMEr4bjHmuHo66/07zWdbqW+tBDuZdQnZVKXs6Ov4L4Nj5SiNZ1Xjj
         8sKA==
X-Forwarded-Encrypted: i=1; AJvYcCVoum3Qik0bs+5DJ7GncTUa2lA9PLtSB2Q6l3xTmbDXGatokDE8GkLa71ohoCiWD0e6i9WGyNw1JLYY5j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCu9R6S/ECkOJ0G9bWti1wP7NGX2T0OEip6itkgjru3rvz4tMH
	iDt3a2H1ihv9qYyzPjtHaZc4KwrFciYuWinp1b8pqC9T928xCefa/kp1lVO004ryRy8=
X-Gm-Gg: ASbGncv45PNLyJUtACrbkGMatSxw7JWEvnktr0enPOesNt0kjiArEt666rCETteQtxe
	2LA7WdIFrFP809kGp2Ox1GZsSPDogoVCEFbGD5tY4Lnsxq94Z+M+igVx68/4gyJkuCYBcUuGMAM
	70Jh9LhutnHAqjcjg7qcCAujWA/gCBt0L485UnlBL68xAOMmBnRg5aNPR1FWlQ5u9qKnTPFIWU6
	CejET0CCEw9QIQ9CEjQoIB6hmx0bEHXw5s+QsPClTUVIRNKST2ihTr4EYr9SlvAXq66JSh4K7n9
	slseULgOg8yhjaGiZbWxSUWBPhAAtl1uiKKjEu2+bejmjtsJS9o9upUHMatx9BwgCj1B26vg85i
	YUWhj24xJX7bJn00U5Kky32aXB5vmj0FAk5peoh1NSmxtVwkX08X2EnbY7ofta/w3xn9X78kc0T
	+FO+1EQTWTRxm3TEr1
X-Google-Smtp-Source: AGHT+IH5piUBnmYvJgxB5GNOkBUWa7uI3f0Itj2oI/p6wHP7zi/ZySBa/bWL+wMjtsFvIeyWMU8PkQ==
X-Received: by 2002:a17:907:7248:b0:b71:a627:3d9a with SMTP id a640c23a62f3a-b7264e1fb60mr110002166b.0.1762327526646;
        Tue, 04 Nov 2025 23:25:26 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f8c5bsm411534866b.20.2025.11.04.23.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:25:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251031-exynos7870-drm-dts-v4-4-c1f77fb16b87@disroot.org>
References: <20251031-exynos7870-drm-dts-v4-0-c1f77fb16b87@disroot.org>
 <20251031-exynos7870-drm-dts-v4-4-c1f77fb16b87@disroot.org>
Subject: Re: (subset) [PATCH v4 4/5] arm64: dts: exynos7870-a2corelte:
 enable display panel support
Message-Id: <176232752532.13426.618023682429747371.b4-ty@linaro.org>
Date: Wed, 05 Nov 2025 08:25:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 00:50:18 +0530, Kaustabh Chakraborty wrote:
> Enable DECON and DSI nodes, and add the compatible display panel and
> appropriate panel timings for this device. Also, remove the
> simple-framebuffer node in favor of the panel.
> 
> This device has a 540x960 Synaptics TD4101 display panel.
> 
> 
> [...]

Applied, thanks!

[4/5] arm64: dts: exynos7870-a2corelte: enable display panel support
      https://git.kernel.org/krzk/linux/c/ba2cd209cf8dc6e826f3ede80212911c23ed2076

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


