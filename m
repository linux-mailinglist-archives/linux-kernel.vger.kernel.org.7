Return-Path: <linux-kernel+bounces-843229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90424BBEB20
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FBC34E62DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719862DCF46;
	Mon,  6 Oct 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJQfDCv+"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD072DCF51
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769013; cv=none; b=V/WNeq9Zvd86eTfZ3e0te8i6ETR85MIi8qaPToBNLt/YmFQoSBJ99Sp0N3QFBJhp4fArmo8nh8qz2J6rqIqseIzD4jpI41oq0lZwPqANwAguVEfJJE07TLCO1Dm3xp93wWbIgCCH8lFpTgYTUWRsWPNa288qOX5fsGNPuq3P7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769013; c=relaxed/simple;
	bh=2BU3Or20eOW+8/DchoNoBhvg8meChDG58BOoaEtXI6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m1ZvpR0rJ+CIv98Wa76Gp0yJOB8jWNsRu0tSC3HJVCwFGfu/g6PtGa5l0LKIT0SvucjeEQxUsyq7ebZPT6UIxFfIK0ALl1OX1S/kzuKObKJrm5z2bdmHBxre5zzCsgicuHkczJ3F2cKZGyT32j5R71IgxGhU8hfj+3VGc53l09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJQfDCv+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso960434066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769009; x=1760373809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZygAzCt4BgJHIzlNAdvVKPmowO3lR1rw3aDJhpq+oRQ=;
        b=QJQfDCv+zXuT7IVL9dr3s2AkwfHatRt23ZMYisoiNIvHAiXkPO+WkMHAk4M7VJW2Xy
         mjcrX7iLoQQZE6C9pLdFl9S9d/ZPCd+t6qEkWVE/KQIuWIfFvX2Jv0Gsctl8uinvyjp/
         QXBCvyqIBXglir0NtOyROSO+uz+4cjy0PwYxc86cHuIVAMsBWbpeRJj+cDXyJjF4YjJx
         Vg/c0dtwwNuzZsQobqqPrKwaWXzm/fybtpzhOJXvgDoJ8p6DErC4YHkK3g/hyXzpc1WD
         G+TQ6lYVhkGE5yyMfVWrCN8fNtQps+8kF3hW5V76FO0aGOlz/wnSyu7rqYZ/9r2xvg8J
         F+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769009; x=1760373809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZygAzCt4BgJHIzlNAdvVKPmowO3lR1rw3aDJhpq+oRQ=;
        b=sz2hkUkZHFhasyfqReE4Jk1ZVohbvZ72E5Ii6Xm1oAhw1hXtC0UERK3mm2ovje7vl9
         IThff6NP9ng15wNYcS17DQMeEKaPDeaL5WL0V4tv7fQtznXg1LsXSlmTdXF9dNgfwuEH
         oRpXhJJh8pQOLekjksOTxvMed5MxOmgx/0tCafpmwwGZtSq/PTh6bhL2voC191v0sbhe
         tnRYlBCXfUa1FHTh2H4PAQBYVTedmja8UgcL4s+ww34IhY7vFsuTLwCfvqdJyGUybfnX
         sUc1NUn+N2sFvff8qT2bGAIL2xUlrRpEZM/QCYxb/vLwkRkR51/TvV7/SDr+JuYII/Q4
         eRZg==
X-Forwarded-Encrypted: i=1; AJvYcCXEkRacpFyAGWJTQjTIqYPacHCNf6ESNoP3sbdnJlMX7lJR7N7W/N0I2A7zu+RCaofP65newMZXi06zil0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNpmfsiUf7CLFJ3eVX1u8pAvjyoMABPfdyw65pr5odTORZBjmn
	ka2ROBvPJu++5qY1E8ZwYVYMh2+gX8rjisOE8GJJ0IzSJ/0duve1ulIxzweuvqc5sWQ=
X-Gm-Gg: ASbGnct1e3MlJXq4QnQxTs461sOJE5t3HWME8lLaqecOIjmOFHikEZ2zlSvcpsj424h
	HofwPUBDdzHCpil5dwN/ph1TukEdMbNNXJUaaB2DKzNFWOWpqPlZyPPEJFT3pT2Sc8tYboDMTrJ
	KC1uRpa4USiMPRqBd7jU8r5q1V/xCasL7M9bEX/EuxHBox7yr+wqOl7RJByA5p8SEiRGQvKBdUe
	oZzUWh4+5GJNU1kV+8tCpIIGbJ2oFfZr2wDkRTlIp9MrpZU8Cec3HpB4QCPxUOXduR9ixzNFIVk
	FL/sRVhNudTg3B4YrIWvyFx4E0gwOY9CtJwqeKD9CYGfUlHpicwJ/hgQJaLu35jiZXq/uHUpp62
	iANfu84Tcd2LblXWX83FK5D8g1+ts5Ef2AsXW+OsDKi24DGIGYwY3QDA6XA+FbiYxvGazOB1T9F
	I67y+pEJERZPwjVrOWI0gvFeaoXEcxXpLTFI2rm0+DWYKRvixihhY=
X-Google-Smtp-Source: AGHT+IFKZW5wiQTkUSviOMSQIOsmLTTkBC5m6wYT7o0NG+U9VIzLggcGukVJvrDeFkRocqCcAImACQ==
X-Received: by 2002:a17:907:1b26:b0:b45:1063:fb62 with SMTP id a640c23a62f3a-b49c1d60b06mr1448559466b.24.1759769008797;
        Mon, 06 Oct 2025 09:43:28 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:27 +0100
Subject: [PATCH 01/10] dt-bindings: power: samsung: add google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-1-f0cb0c01ea7b@linaro.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Add support for the Google gs101 version of the Exynos power domains. A
new compatible is needed because register fields have changed.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/power/pd-samsung.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
index 9c2c51133457112ca0098c043e123f0a02fa1291..c35c9cb0115d79e5c36142da2c2a5dd30cd2ad47 100644
--- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
+++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
@@ -19,6 +19,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - google,gs101-pd
       - samsung,exynos4210-pd
       - samsung,exynos5433-pd
 

-- 
2.51.0.618.g983fd99d29-goog


