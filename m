Return-Path: <linux-kernel+bounces-804577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF1B47A05
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC422025F0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C5822258C;
	Sun,  7 Sep 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVJ+pxA8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C74222172D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757236451; cv=none; b=q3szMtakt16xVIcbM+QdXRVPcMvlNmsHQlKRKFrBziOwV2fz7ZtpEoaq531Y4L/ggKXa9L2kDsV+vGNA1SOfucSl1buPJbnLweB68OeYFboaqwYK73bh2eblNpN1xBuH+35hlNtEKZET+cn0cWCA8A1cuAWQVK0JzxcZ+t2jzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757236451; c=relaxed/simple;
	bh=nTtz/T80B1LFaBzGfFaobq1k9YIb/4LmaRP6eS9C8A8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CdpyrzWB1QFqXk7EcerOzEDHTHNEHPlrqJ0px7Ay+UKywe5eXyltzD42SMi/6tkJYmAxe+e6qLh3Z4LrYslpO31q9d8dJ6l9X6/dfi5nDw3j8OXybLVTLMrxlLxrYktS+LDmMqoWYY1g0xpD9PNRHBSGQPuztiwR4sgo+f9Se4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVJ+pxA8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45ddfe0b66dso1583445e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 02:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757236448; x=1757841248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCLQAsYpR6U6YXx5WXyyNz/et5qkwEIQ90qwDmcTRHU=;
        b=lVJ+pxA8WdsapeRIjC97ax0YT6KggfLwHY9NlqpaSJbTiyPfFs2m/jbADXLXjiDza/
         iNQD25YkPwErRPW0iQJxrSaHY24CBMNxhMzYeocADPNS/Qjk/P7ifWLB2U2KDALEMyUc
         zzq0e7b5pdPgByPMjE/fqcp/sAjpqRv0BrO3uzJWjSdzCES1V38iCPGC/+6t5ZNLtE0z
         tSw6cP8rEOmAlg5k2173Mn7jHJEAVCqjHQEp6UJKjcBn7fp4gkMreE2D2ThMR9lGGRVW
         ro8IMP9Akul404Zo06eyOgBea8vYFrwAY4Zw2ZN0pPQ7KNmEBUrKcWrZCJuqeT3AU0d7
         HgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757236448; x=1757841248;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCLQAsYpR6U6YXx5WXyyNz/et5qkwEIQ90qwDmcTRHU=;
        b=BVxjqaZGE1kKO9KxvIHymN+E1yb2mA3MsdIxoBcYJw/rgGTr27H6jtwv7ys8IVgoae
         i87cD/43RLIck2OI5LbV93t1rhXozMVi0aoBpvQGeBqjuZ48HdvWaQpjn+ZLthR1JbpX
         WH/ueKLW4QCrWM5BI9K3okEPMlek3DvNuW3L5ffSDNOJUdA+NHyFOSu0tCEbks2ws2iR
         aR887sm5im4s69jy4GuArgLxFbb4KlRtB2ABxq5Utguvqv5/669UdX0rYDFP3Kx4+HkE
         zatyANV2Xbq67sPdszW81lnjOFCillDJrpP7DiK6T7ME3NoGpWH4CZzX0gw1Zno9z1Tp
         T7nw==
X-Forwarded-Encrypted: i=1; AJvYcCXfwEJZWV6KCfKKgITjQ/B5HtO+QSeWqS/4MZh5AsXpFs9Ge//3SQO+k3pP0kBC9HFqUNyJXbSkaj4Xzak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FMcTCrZZQdgJ0ZDd827WfeMaQqt8vTIpolVSAfOTaxKQ2gSC
	hRNNDXoryIQz3if30bwYeIjphGTFijiCQF1Mvbe/MWcidoMem9FJIJSIDLG6jp722jI=
X-Gm-Gg: ASbGncsJFYap/wJ3qi3DK/8bVA4uWrLSxVnOcV7wjcP2PIrXIo8wQE1XfXoDYQpXokn
	/Q9j7JmtgxT0rx/uhYCG6/y0aN+zbQh+xgXNqibSaUHLSRA0wP7rOI591c57QQzQAKMO+wcLlMl
	oa/5qih8T5z9qBU8OvD66oMmeECj9uQGi4TFSiybRzhW8Hpg1nuf64fncrJT1/64mdpHp99P4fI
	SdQKWjS7qa7lgle2Y8TgjiKKl6uNsFzCDRJCE41L+1bz/xYjptxD+H48MKVbswT6Li+320PdQl2
	W1Lcu0RIAuMvYf56WtCK5F1l+6gNAybNUnLtoglyG9SQAvRG1lhEyDqu/DLO1DwQxIBCiS0IkjP
	4ZXYK01IfwVF5DoD7afRuGlFMWjyHCVmDSbyh4w4=
X-Google-Smtp-Source: AGHT+IG78HXO5H3PNHPON4QM2B7kxOdyJOW/vdjAFNFZeNRnZqCYRuJ044SQo+Ov8yokKCplK6e9pw==
X-Received: by 2002:a05:600c:6388:b0:45c:b565:11f4 with SMTP id 5b1f17b1804b1-45ddde84ff1mr18221295e9.1.1757236447894;
        Sun, 07 Sep 2025 02:14:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e21e4c0e6fsm10918962f8f.17.2025.09.07.02.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 02:14:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
In-Reply-To: <20250904-perics-usi-v3-4-3ea109705cb6@gmail.com>
References: <20250904-perics-usi-v3-0-3ea109705cb6@gmail.com>
 <20250904-perics-usi-v3-4-3ea109705cb6@gmail.com>
Subject: Re: (subset) [PATCH v3 4/4] arm64: dts: exynos990: Enable PERIC0
 and PERIC1 clock controllers
Message-Id: <175723644648.30719.8043699953915235210.b4-ty@linaro.org>
Date: Sun, 07 Sep 2025 11:14:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 04 Sep 2025 14:07:14 +0000, Denzeel Oliva wrote:
> Add clock controller nodes for PERIC0 and PERIC1 blocks for USI nodes.
> 
> 

Applied, thanks!

[4/4] arm64: dts: exynos990: Enable PERIC0 and PERIC1 clock controllers
      https://git.kernel.org/krzk/linux/c/44b0a8e433aaad8aac51593a052f043aeb9a18d1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


