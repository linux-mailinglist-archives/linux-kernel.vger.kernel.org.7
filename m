Return-Path: <linux-kernel+bounces-859329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 720CBBED4F0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D78EA4F02BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067F25E451;
	Sat, 18 Oct 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z5XGF59D"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C425784E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808013; cv=none; b=nX/cj6yJ4v2leExUFp8xHExdEZ3hvNe7ij0NwhqxTv7ATqfAgewZrcQiLEt4kxt4CRUAV+XXJEp3Gvr9RL1Vwp5TdwNhps0dp4vfScQBeAn0isXy+4aL6BffRfdaeO5VpK6pkHLxGFMwo9y4S5BAaKtsutc06m0CjbhVZyFWHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808013; c=relaxed/simple;
	bh=Nr2KfNngiIlvNlLFYS/VgNPZ1obDnQoBFlUmS5D3U7I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UOYq8A9YQi/b7u+NyzYSY/Rjg6CYSqpsdlLPmMtkya7BPIE0ClSzQd+IiHY/spT5Rma3Zn1tHT+ETiZbOzhPxE0UShsn1t4m/Z9iDXjdY4YZgyNhoMu8oG0s9Fp6CK4MSRndPuweToMt0v8E8n2D9FM5dzxibBvzLT0I0JPzxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z5XGF59D; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3f8d2180feso47541566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760808010; x=1761412810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTMTmXdQcRic/7O3wI4ilcIkNahM7H+SFceh2d7cSug=;
        b=z5XGF59D5KNdezqryeaGxo27kG7jlhBasO41io17nGj1VyvZRmrFBhD38NQ/4wN2oD
         GPHcb3avJGo5ZR9ynGj02NaMjvpGrWO/GOM+foWKZ5TqYpspg8b/b2DwQPKWhaDFI3QF
         l3YFCzThuclcRgyhSHOaYenBmUl9rnQh/nwRonnY3QuVfP1MgQEDoFEhi/fDEtTTx0Eo
         mEY0c9unpD/pSyVEEQXN/GikG+Z5vH9e9tqeUUcuiLlQCFn8zsm1UFo7tjV2pLahb1o+
         Oo292yG8fFc/yL7ksoNkGMBI8IU7y2Tr+rpGZeOxb4IWe4K8D/fERjzQfxTlnH7ZkEY+
         hovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760808010; x=1761412810;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTMTmXdQcRic/7O3wI4ilcIkNahM7H+SFceh2d7cSug=;
        b=VclKtJrmnkPnHCuzSegkaJeZRGLKoUK8YiHvikilOO4AteZgQ6ywDytwQkrJBIWrbJ
         +t/c0pJW3h3lUrgQoqagMajZTN5NHjHsRGDcZTfJRATDTNnuzcgMzPw4S5dGTZdbR7hC
         nl0LIvqoj2oWOWhfjhELwwCcUHAR61halyMjL/t4/KeSC7ATYuY0TT5iI2ydFUJuBnjT
         xVet3C7/Om+W+QhI2aarSwifTJcQ94pyQL0XHNCGLey+0VBf4V3GLxrUxrf1WS4EZ2RM
         Q2W1OlPpH5/RpGzZQRF5iwAB05wId/xzfX7OaoS5PWAoDhC811gnTf0BjQVzB+/xdKGb
         Ijyg==
X-Forwarded-Encrypted: i=1; AJvYcCXRBIMFwJfhrqTitCEVyQoKj+gCWbwgpD5PMofjjbTNdd/Cqa51NS/4d3uDbIrMELMp6xM3+YHzi3I1L9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqOEpoe9ft2vmLPOBISTDAaYMOsdDdI9RVTyfyaxuJGt3qlvYT
	EYVM4y4i+NtN1gIt86WQRmA18V0wdyY4kFukHev9AFd+ulxLuj/UFLpW0FdqVGbe8YzztxQOmvT
	xMWhC
X-Gm-Gg: ASbGncuYi9mkcpVkyUr1az7D/KyEA6CTye13Rby2XnE68pC65Zo1xC5xZwD+FyiiH0Y
	4v49zgvVV4VHcWOfyxXySKFzS7OOn+lRu71RF+BBT7MRsN1EevMx5+SRtBx4famOJl4GGd8Od2/
	mHIkbhaVnclGV4WZqIznavXV3KqdmXinU9tnnTkDVMJ+Y76ZWq5Kngv3PzBuBAKJX1XWTwV0K8a
	WErlcCBLLKeYPX8gye0La51L8bcYoIjC/zLcZeLihk1mFfNxP+TZmDGlStGQm3PEDaimCYHlng2
	3aApR8ukLvIxjSP2YNzcbNqJLbbNVfjYA1QLiXkhckE/CPzv22B1CokYFuAjJiyZjQ9kkiU3uuC
	yo58UxiBDtlGvyn8jUtopmFXWnssrXRo+86K2sIqvya1JDHNHSUeWhs7NxcAaeOUY8RHW4Ky2mZ
	PFP/nCHkhzIntBUXJ6oE4lzUU2Ivc=
X-Google-Smtp-Source: AGHT+IFbTirHyIN+XM2fk1IJ2nHqbjUwUwjp9X1pcQvNQEQRFLlqsHZZnLK9IZT+t3DpLgig2ZlJ/Q==
X-Received: by 2002:a17:907:3da9:b0:b2b:c145:ab8a with SMTP id a640c23a62f3a-b6472352847mr489805466b.3.1760808010183;
        Sat, 18 Oct 2025 10:20:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da2bc7sm280666466b.16.2025.10.18.10.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:20:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250928-exynos7870-drm-dts-v3-1-bb7d8e570860@disroot.org>
References: <20250928-exynos7870-drm-dts-v3-0-bb7d8e570860@disroot.org>
 <20250928-exynos7870-drm-dts-v3-1-bb7d8e570860@disroot.org>
Subject: Re: (subset) [PATCH v3 1/6] dt-bindings: samsung: exynos-sysreg:
 add exynos7870 sysregs
Message-Id: <176080800894.47136.16568266339840675495.b4-ty@linaro.org>
Date: Sat, 18 Oct 2025 19:20:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 28 Sep 2025 23:26:35 +0530, Kaustabh Chakraborty wrote:
> Add sysreg compatible strings for the Exynos7870 SoC. Two sysregs are
> added, used for the SoC MIPI PHY's CSIS and DSIM blocks.
> 
> 

Applied, thanks!

[1/6] dt-bindings: samsung: exynos-sysreg: add exynos7870 sysregs
      https://git.kernel.org/krzk/linux/c/3abd9b087a4cd7430cec2080c67e7a94fd7a44b4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


