Return-Path: <linux-kernel+bounces-779913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A356EB2FB23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EB7AA296A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC60B34AAEF;
	Thu, 21 Aug 2025 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwXaQzZE"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88043451D2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783458; cv=none; b=V64Regfc3aSGZPD/efsiY427b69mt/BgbUb5AuF52DFIRix5j96nUumvFfdzbcUW/Rr1HKkT7jxiTVujpGMVXsD66Cg0zOr9Tq8B2S79SvlD4Z4cRQqYZiJkRlpA9x45h2DmLEXu95CWtvhpOU/BSj6fnBwUyBYAd1+jrmEQUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783458; c=relaxed/simple;
	bh=rr71+BBtnhxoI0vp1gh26EB5RHubOusDekfjzEuTCME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9LVgU9DDZfiXaDkD+nGHJ2acZ9o8UXY1tRwp/K4byNdFrlxpR2R4jZkOSZ8sXUC7etMmpaZ76v6FQHzw7EcMVPUjKc+8lE5bqvHCnc5yStsK6nwqgBHKoMkaMdoeJxm3SSq5YgCak5Sow9678gg5Ct5AoGw9nc9qDS5w8dncVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JwXaQzZE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so5511075e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783455; x=1756388255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8BLkvgVSbp7ucpmwzFe6L0udmC1CeuwZxTZJh2EA+8=;
        b=JwXaQzZEtaSe60PqM5wIlGjY8PkDnGW2Yc+eR/rM+YC7iS6kbkFDfI2xPTkepO8Hyg
         sQj8YPvXxglQXSFVLSYU0swbxn9M7virRk9z+NSx+/AS/ZWEKNccT8wauV60b+YAE2Y6
         XOu5AUfHyBe4dIJdIwNspfGmadFFLTP/GdBC/wah9ig+1sC7rc3rlWwjiyPDIcQpMIOC
         q3n5lXvqkFUBsF5i3vrS6a8lNeK+U3KKTWWTCtkM7ibYxXK1rOL0ZwTx0Pp44QXtHIeK
         tT5lBBlSjJGXnYwZrZKv4FEP1Lu24eGxaNmPCPrCswU1NjECoutYH1qNfWDQCt2St7wn
         DgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783455; x=1756388255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8BLkvgVSbp7ucpmwzFe6L0udmC1CeuwZxTZJh2EA+8=;
        b=jbeSex9M/OFC236OCVPez3q47LSuBX/nd7AJz5vdjS2q/CdE1he6y5l9o4gxZyArNC
         0WoI3L8+my+dfFhu0Ya7HlYgDrWuPdBT6xzZqQErWUIlz73aNH08K3AE+Jnpg/K1qopr
         6u7lmYj4BXHAe45ZxYyq3qBjMX5kNWC7mCea2QGC7wUiPR6INZElIQvSX/OkDrgE02MO
         oRhodo5Ucx5n+NQmvmd7o8rCkJwFM5oj36XrnU5/Mnon6FLQxCl2YDO8EU0QTdO5JhIw
         TLVVhb65pRxvjKZ9KiE5xcbHIzeOpCo4ixEkF79yXEkhyoKe80qJeTYCJKjxfsOGMkr6
         HfAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKn9Y7Wh6FtG3AZeiTFyEXUQoqe16gb68fK7OjOrcPjA3GtC5rfqIj6FgdFqR3/rHcoGvMJz+oSdQ4st0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+hgP6ARXqctnhqZF5XNgAmqq/c5TSC2HBuAoGr9fG8EX4/ZfL
	w4zMdxfLkJFVSpLVMXiSGMm8NA2Ed0CNsbZoJ/5n4uqUBQX8d/rZO9if6GHfC1px1Ik=
X-Gm-Gg: ASbGncu2c29QSypo06aoKqiKTJgqmvc6BrjcOepDXS27rbK+8+zO/+kkQTktktAAw01
	PVmlVU24YIAwnaMQiZ6du4dR0y0zNBPCTf27pNzfwInt7nEXD9LoDvSUH8Vi3QVdg/fTODTC7Q7
	WlIISZXpWwlP3+HhCQv9fGb7jSeQE/EUSAdxLefregpeFf0unSIhvxh6ypDuW4ci84rlKhrYS2u
	lklXyRqe54Gw2mRLqPCEG1M2rFJTw+kLM4GjB3k45zZRfbeBp9keJmMzM38rTU6hco906NqyJ0j
	ExwY+Mer59yhsotccIezlKwGw27xgrGFgeE3LMf+2jcCR3t1p+yLQtFjEeGoyH+UzLYRjBnJpxn
	VsdjXe6KdmbP8p6UdQgsSmjE8NDLlfg9BWqH2gtX37lM=
X-Google-Smtp-Source: AGHT+IFsmuXhpP3qU7Pp8siYjJS+F/j/1DLLMaPcgZZjqJf1FETfNBTyfpNHQJYQLuCJGkqIzy5oHQ==
X-Received: by 2002:a05:600c:1c8b:b0:456:24aa:9586 with SMTP id 5b1f17b1804b1-45b4f3a1b01mr14542815e9.21.1755783454882;
        Thu, 21 Aug 2025 06:37:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm28937605e9.8.2025.08.21.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:37:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 15:37:22 +0200
Subject: [PATCH 03/14] arm64: dts: qcom: x1e80100: allow mode-switch events
 to reach the QMP Combo PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-x1e80100-4lanes-v1-3-0b1a0d093cd5@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=rr71+BBtnhxoI0vp1gh26EB5RHubOusDekfjzEuTCME=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopyEW3g2CbUL+RLNxsws+7z6NchoNFMgLQwFljega
 noiClACJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKchFgAKCRB33NvayMhJ0SkND/
 4p12oCB/5iy6eN8gCJ69QUw4NXp26R0vwregC73IhggBFUyrrrAPiFT4fUZpUnO3EhIET/q3LR9Z4f
 Wv5SwV49Kkbae2cJ4+woAwFtrj/y8IG9tZKZaVNEKDAFK4DEarjL7zRERVzBI6R7VNYD8LzvDtillr
 cyhcmMMcz2r4qnE5K1RxoTBRy8++j4gKokLvMZx6APwMYm/O1dDcui4wjz3eJWfJns+i3NDE92ayfF
 FpQf0qaQJKX+6Zw31K/e4ou1/FC4p9zerFbt+yCUhyzEFcnmh7tIWVT5F50oK2N00m5BarJOWtkrgP
 xm/ncuNkxOn+jfuUOQSk+sZU/hXnBjvyYtEfJAxi4BFS9mobxkAxVLIOn/94YmNWODbpxo11j3wEiw
 U7UDlIwukF5sRKGQedloC2YT/JmOJEQPeo9MnlwhJoTXbWvXfYHhJvEh26W9hiXUwQH4huWEsrIChL
 sSc1H9vYm13nUeUkmz4b5c+keByTYgtfztxMgiUmgA7XPQmyKr8m83tNpbyUWVc0oVyRb06XcElHMz
 I4+POMFGxwEMaenTJCyHOOtypwemjPxrE1dBA9MdT4lIFgGHgSQkFBKVDqVdF7G3DjL2KQK9X0IdUa
 athoIHrVCl0Ftr7ENLW4SdCNRI1eUmKr2Oz6Ex0pfPfzKCqJEGhihhfZUngg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow mode-switch events to reach the QMP Combo PHYs to support
setting the QMP Combo PHY in DP 4Lanes Altmode.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index f293b13ecc0ce426661187ac793f147d12434fcb..48c715e9ada33d4909049bca28c68a6b24ca0b0a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2857,6 +2857,7 @@ usb_1_ss0_qmpphy: phy@fd5000 {
 			#clock-cells = <1>;
 			#phy-cells = <1>;
 
+			mode-switch;
 			orientation-switch;
 
 			status = "disabled";
@@ -2927,6 +2928,7 @@ usb_1_ss1_qmpphy: phy@fda000 {
 			#clock-cells = <1>;
 			#phy-cells = <1>;
 
+			mode-switch;
 			orientation-switch;
 
 			status = "disabled";
@@ -2997,6 +2999,7 @@ usb_1_ss2_qmpphy: phy@fdf000 {
 			#clock-cells = <1>;
 			#phy-cells = <1>;
 
+			mode-switch;
 			orientation-switch;
 
 			status = "disabled";

-- 
2.34.1


