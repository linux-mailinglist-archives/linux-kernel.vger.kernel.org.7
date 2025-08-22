Return-Path: <linux-kernel+bounces-782405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9500FB32005
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64AC1D250E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC7A28466E;
	Fri, 22 Aug 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzIN0LCh"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77F261393
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878227; cv=none; b=FOVGarNZdAVX1PSl9EWVVYUJgo8y9GWHR1nHqHV2P1pkyNEBSEqblIkzWPqekF1X1bWlaTUkz2IRgHA2dYZRLJOwwCa2+f5DlKTAcjUrZrKbN7IKeVpxqbV+g3PtZw4zyIJoVcbYzSLbwXe4AJ+y8YQMBi+piY0GhKiWWjsOuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878227; c=relaxed/simple;
	bh=hVkVM4AhUQ76BelgULXHqEHZqxcC5v30V1ABBMTLk9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRNCIC2lyj0ASAr7To8lJ8OZ9nc8+L68HXigB2zlo9jLT9QXoZlpAehME1g7K0sVdsC5GhfhEJOIsjr7HruKuSJoNyxw4M8qU7epcVez2RMEV6qNaSpNfKVZOB1haqMPgnOQB/JCccy+oifADJZA3q4qTCyxHJ/Cy7aWR7ijjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AzIN0LCh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so1021131f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755878223; x=1756483023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKtFLD9Oi8zxbtsoE1t5Bq21eqK4N95VpuE/7I9o9UQ=;
        b=AzIN0LChD7JFkvTu9IFlDmS2MAxoX09VeBAgVoAQr5pgKCfSunKbGFjfA1S0R40Slb
         9jvpKY+5L9dwdicp/SjyBG4YBITeks1vVFYOY/4IO1lVQcKNe/3noVLjhqAUEFAsUpkE
         5TFje3J9/99UC06CVTwLt6ru7vcdix8PRLIGmR7VSn4DyvIrgwsyFlQ0K/9zkfmRqpw7
         1SwhtTJ3eVSuR0Y673p8vKGV1UE3aFh5zBbPiWHEt6B+iXtzRF/ey1Ig8+6K0sasj3ju
         oL7er3VFWRxxNh5c/Wmz2TN50QDJAcoALCnBqwLCw3VCL5OfWlbZxflcNwuKIJhxS+5L
         r/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878223; x=1756483023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKtFLD9Oi8zxbtsoE1t5Bq21eqK4N95VpuE/7I9o9UQ=;
        b=XRZG/hiJT0ydrznZg2O1czXQwGAm9ZXLKvY+qx4zoNuJBB9meYj1Fm5pDPvpRoNuFk
         aZnb1d5MfE7oPZoYovRMmrFpeOIrz32zOXTseIzXIOkNf7vGRutAmfpaFgRelUJ4T1yk
         9NuYPRPesm+RQosnPm4e5O8xCq9GrYIPKzSPmu2rttiNgTV9G3SxPbCPUSJwvp7NX16a
         Bj0kdB8+2QHrTK2jUH9dURIzw61Clrt5RwS34MacUa7vMoidsVitogwjwBtov4bSTFYz
         qEoE70Bl6L+K8NKbgEZ7H0plFa6wl34BCERZz7xo6frWRtaRP152RGo+Hwrs4E1+lI9O
         lUlA==
X-Forwarded-Encrypted: i=1; AJvYcCVSnOkHCiq9Jt8rav5b1wr+59w9FH7z6Z3Ftshk3Y02j+FRR+9HCoZNQ5Di2NFHy+tPKQfDFDQFK8e5DbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mgSbe95jWaYfR8tlmCJtLGSYnRQwyW+Vi7nyZU9s2CGuPJW4
	59v3LWqw3KLQgm2fsKar9yM6F7e9y3zd9y+HW/Lc4sG1d0UdKEWdESQxkEkHQAQlX+k=
X-Gm-Gg: ASbGncsbVPa97FMZabSpp4NUBAHIC+bpcMBbsc7V988MA8KBF5TkWVUoVLrDJ/EVbG5
	9yu4MRADhHrMv38+N0ynhlZhCIhLz9wlDnwvxcjuXzS85OjZawwfOTMsAcscm1/ER6zGttDLoiD
	8spZSrOz0fyWBGI2OHIR40fl++rlZxVpTpKvQFxUGtOdspBBKQCNUsrWf0jchB80i80Ms+kDlBB
	2j+Nc5Pj6owY4dqb24xgqCiOg3e9hSeFeHN/nElm2wWoBc5Gz+LPfzTbdhjBULPzYXEW0h28RXx
	VQOh7ofbnn92uJy42XFHjbLioMAs1lLK8g42TbjThyfHH4hBmdvMd38lppKaMBzb4kVMmBDEHsa
	4dnlpourRBhSj+llFDs2XasaeEo5LQRKQcYOO8REkExg=
X-Google-Smtp-Source: AGHT+IFvQ8K4Z1WD6AshAjNuS8H32J6k1G9KYR+6f0oMmqC/CFDtUf+PbiLW38iJ+NF73DApaYL4xw==
X-Received: by 2002:a05:6000:2288:b0:3b7:95dd:e535 with SMTP id ffacd0b85a97d-3c5dcdf9d4fmr3120643f8f.42.1755878222849;
        Fri, 22 Aug 2025 08:57:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3c89cd4d4sm10095765f8f.42.2025.08.22.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 08:57:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 17:56:56 +0200
Subject: [PATCH v3 8/9] arm64: dts: qcom: sm8650: Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v3-8-5363acad9e32@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hVkVM4AhUQ76BelgULXHqEHZqxcC5v30V1ABBMTLk9s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqJNH/Ma2k6av0/gRe5Id7Y+YZw5tIMkhmzRYtwc8
 SQY6loCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKiTRwAKCRB33NvayMhJ0VN4EA
 DPM/mVsdYBKsLp1go71rlbClxnqNOz3q8ezPCekgafYtqBjEcb3A5PnGGosC031rrFgmgjs/gVY0jX
 HL13rFwvpOezpktgDQqtJA/ixuORI+gFnsbriqUQVUbV+hK1ddPR5UURlrPeyZn/5/FoLBn7+agsIU
 ujjtrimMV/CWT19ou0c94aFAqZBqKTAhR2pvvqjng5VGb3wHF7RnXAYGm2NMcfrIaqk2yrLu05oOJo
 eYfST+9s3GhI7cjhwbeydNj7SMVAfvqpnyoYLFA7PeCPjBRDQW+KkA/KcNLooj8xVxM3yeCwIfA9ep
 fWxFTN3lpgnvYjgC14M09/VtHxFJBB+Ds1nAw7rcg0Xkofa+J0mJku3lqRssJ7pv3CypWjBi/BKgRM
 d1m/w/l5olwLXaOPN/H40mlobix2g+N0JPkLA9F2Keri08JnUGPtk9k71XG5zjuZtjF0/Zw0w2g0TG
 k5yEYKjRRk/8nBaXw8UlGtc1CZLagYyh9smqIRkK0TevB9cQlDgnnBD/92JrTtDnLBUz1Hm+yrwAVP
 56YKlVQkS61cK29dd7uSL6fP1YH3HM79Ot/MynICiEhEBGoj6YL4NYy1UJh9Q2lAFtKlwd9Q6YaEDC
 895IVBpLSBz4zB/aoxQmNuto5SnQkd/lYrJ9RLrvjXhSwxFdn+cFVa/nRNTQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHY to the
controller now the mode-switch events can reach the QMP Combo PHY.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 289ab35210c1b429d2337cbe4a5a479eb36d8b7d..29a65bfc0bcfa0e2dec9e5d16ef8ddcb8c879526 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5721,7 +5721,7 @@ port@1 {
 						reg = <1>;
 
 						mdss_dp0_out: endpoint {
-							data-lanes = <0 1>;
+							data-lanes = <0 1 2 3>;
 							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 						};
 					};

-- 
2.34.1


