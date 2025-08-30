Return-Path: <linux-kernel+bounces-792855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D7B3C9C8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01061BA649A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B4265CCD;
	Sat, 30 Aug 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c85Jnuhg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EE2638BA
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756545604; cv=none; b=P4ZFNekT7SKKXXA8lvoD7i06gHO7UFEWLuk/4Y7LNjMIsW90pdtx1CBd0YqBeS0RcExfH0X9BlzwVAhTVNRtw4bO63tBFzPegEEsaU04ipI7RwjB8YlY2bcjWwPfd1b0TaBFZ+78Uw8VKb2Uw5ENKs/iWTLvxpdAP9ZeyWPWs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756545604; c=relaxed/simple;
	bh=vKZxK3WqSG869YK1ejnNRrbE9AJOdCdAIjU5uTihOao=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bK6/6xehEZnACsjTCW+te4di/OGWyFdrlm1klKyOZxEyufBTHTi4Kw+bNI1yaLCFSYE7sa8KsvqUo3kGpybdJUIuKzvkhj33MK49s4fMlKJf83bjOtqdn89GtuUkSP4477bP5mFPuDNqA2bgub4e+7FumetAMumWMixc+DY/hcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c85Jnuhg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d12c5224abso163845f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756545601; x=1757150401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18xNVcTt+Ut2Li1HIkvZ7r0gYk2tthQkOl8QvQYyxWY=;
        b=c85JnuhgFQUT+JCfsBEPePhJ7BRwIpFnWifWiLtlAEQNVHK1OTjQ28z7e0PNFDEQul
         ZWsv6tD7u/t2dSbKSBfQNxV/rzQOvWZmE3dn9zJ1BLBVUP3pVPQhnZWykqhMwEPYovmd
         93D+c5w9rx3vhTsh32MNa/XpTlM0atuMbZOhH2/1St/6DmXI36jOpfUtxMzPGzIHrjqr
         CySNcsaPyPr0wCtc8RTfWMnh13Bx2PwEVapXdo9l8M6OQWCyMaNvYeET2k/A64gszMnS
         qknlMJTr35Szsnuv3z7YC5x+DcG+xLJ5jnbkja78wXVNnw1fhtzFMqm85jbfGr+zxEzz
         TyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756545601; x=1757150401;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18xNVcTt+Ut2Li1HIkvZ7r0gYk2tthQkOl8QvQYyxWY=;
        b=RQehUiPEzbgFOXw3HO3HZL974UXXlHyJOAuF2/plcv/ypEplds0ik3iNf4tcRX4KnH
         TLCaJBoc/nNvkFHAPtLkTh6OFdcputiit++9trKWf1zAe5fpzkIcAPg1KmA4pwEOrwov
         E7Do2jaOYF7kA8ZUPkuZbfzl17p14Vu82ESfsclAIyX9amhmxQQ04yCSgw96e21tKRAX
         dZ95S+e19a6cnX8Md/tt9us+Z/P3vWHLLNdDuVF5c4x/hS6dlS6qhfyP3IQOsAm0XBnu
         jaT+/4V3QGYkf0Of5Ck/E6ZG/GqYnJJvGdYan6qunkF4NA40YQOx1QUJofE/2SsxVcy9
         /isw==
X-Forwarded-Encrypted: i=1; AJvYcCXbS8z7+Oo4qZ4iMuHM/KR+YY+aCjwikjpsu8tOEFEHmKZjbsOu3SczsdxzEECj7bQOQ1LPIeSeDLfqcIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFXTcGrjBPQUc/vRBIp4o8VNFHKfwYdds1KnU0XzNUJRUYi2v
	TUqo5Y/xYMPNcrWWQ4QMOeKYtAhiFhZSuGvxda9QwV+ba0MTUmQH1BQkF8uckWPD0Gg=
X-Gm-Gg: ASbGncuwzxv3nApkAOBJqiWR4cjyfOhYU2FpNhmyLKS3uJpOIHl2U/LFF5xNJLHd1yf
	gIDocE59IsTNYJmvvppCbzlmkEAgpjaZ5us43vP9e5VX7mgRO6YYGMEJgA/P5p7S4jmo5iEt1aa
	MQxNxWlS11nm8R8dttrViiOhAj5UTW9diveWBhhkG+N7BBbo+8JP/EuSmyO1W44DO3OiNGzKkTH
	wP4u3U+4vqU1TmRQqLtYyFzD0kUIjJRj1KOPGktsYb8WxrUld2Bs+Ns8LjRZBy6VV7z7JF/7R1t
	ZDOI93Mlt2EfqXU+j0ZsxNKltI7LI0OQrpL1ooIvpBzszv74mT6yituQOEfMLfhxImt4+tmRQCc
	MMnJ2931nqMJlULyCtgkuHh2Ao6FQiwJQolVs9oV3xyKoZXE2cQ==
X-Google-Smtp-Source: AGHT+IHwLu3eO3G/g09J4U6BQtf6Smm47bmXXP9dfIdI1vYcv6TcxL9zbzWeDgmZ0/d3DtuvTitzvQ==
X-Received: by 2002:a05:600c:1c9d:b0:45b:75d9:2363 with SMTP id 5b1f17b1804b1-45b8016df84mr21110275e9.1.1756545600887;
        Sat, 30 Aug 2025 02:20:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8525a94bsm21186815e9.15.2025.08.30.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 02:20:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, linux-fsd@tesla.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250822121423.228500-7-krzysztof.kozlowski@linaro.org>
References: <20250822121423.228500-5-krzysztof.kozlowski@linaro.org>
 <20250822121423.228500-7-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 3/4] arm64: dts: fsd: Add default GIC address
 cells
Message-Id: <175654559953.10738.12020984387702262826.b4-ty@linaro.org>
Date: Sat, 30 Aug 2025 11:19:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 22 Aug 2025 14:14:26 +0200, Krzysztof Kozlowski wrote:
> Add missing address-cells 0 to GIC interrupt node.  Value '0' is correct
> because GIC interrupt controller does not have children.
> 
> 

Applied, thanks!

[3/4] arm64: dts: fsd: Add default GIC address cells
      https://git.kernel.org/krzk/linux/c/a874b387213bd80b1288884aeb427cb7599eb5ea

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


