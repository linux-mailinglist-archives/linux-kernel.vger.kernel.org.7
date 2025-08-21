Return-Path: <linux-kernel+bounces-779919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C6CB2FB18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909B01D01F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4597C35334D;
	Thu, 21 Aug 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwDa86Vt"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F35B34DCE4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783463; cv=none; b=o0fmuWSI/zoNddGjx1ZqzcEjTWcEIGZ3J7D0mSq03RN+1gz3gSPFlkI9Xu1/5Muqv5aLYHcadc1JeswYoIdZgEV2AnwHIATcF3+1mHmen5HDIfS90qnbfv/Z3l4Kvt8wGrZ5sV4RKmKAfw0dvNHs0Kd/nd555tK2Sy8SPjpC9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783463; c=relaxed/simple;
	bh=DbsExdoRyp3kdjCk0epdoDIR0B1+3ES9cdqkRoNTHi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r439m3TJ4+fVapAIU5ujIFrifVhRepkx3qIGdMUMZWCDltpP5Wr2cAbio34e1oWxdBfSkwhET4mab3R7QCkuE31em86XVNs2ypKfbABinAzSQ5bGTh+AVSWuZ+ITcuAdcvMRQbF2qqFoqkreASL6UDuDrJtoMN5FULkaWjZx7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AwDa86Vt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso7654115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783459; x=1756388259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5otisq1c/9/dwhaTo3HsCPZ/30o0nEKHZQeBlO8KVEI=;
        b=AwDa86VtvaSxHS3ppCzDF66mhlLKgsp7de37euMR7eShj6DWFE1GWfuft6eo513720
         wgVI51R0deL0rPxzyx/GdsseBVDgokNC3lGquAfCj9XTmCoRIT4el93O0aK2yj8FhmSN
         a6PprRhR7j5OgXDk2QGvyrPrTx79n43CAVZLQV83yFsE5lRfuYMzlayKLq/zgQmFvZdw
         AFZXu4AaqG1ms9B0BeLUwivbjCc61yu/P7t+DO1WZ437jVxB1+sejfZrmfaUSijoDasQ
         iUepdoECf6onRTjz3r/nNAQKn01RowEANrmwtHEKZe0/Y1rH9zQsjR8pIsD7pTXb0k7x
         LthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783459; x=1756388259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5otisq1c/9/dwhaTo3HsCPZ/30o0nEKHZQeBlO8KVEI=;
        b=bXxjl5X3SAeSFe55EWewydAW+G7WgEU9KSx4dshhoUQErenfDAojQGPCMCP3R4WaSh
         PXVvMY4x/mxH2+fhjbYcgVlzcDKsRBuUp94GhuE3IZuaVnip9wUxJX5Zl6bb4yB3Gjuz
         nJkG+6asU+bySZazsnHlvXFapQvSTmXY/SgZTOUwc66tRSebz0II16xCTJWJEcgfvbOG
         TeYzQJCSoCH/+Mdz/GTHqUQHNVmcD2xo7kxq3/KwzGR6bnquMEhVtkBNZa9QWfW+ixnk
         wP2YDDWMvExhBYU92BkGztNW29Zd2C7/XxiVx3lenuWzgA6tB4+ypn9RfndB66N24cWH
         PvYw==
X-Forwarded-Encrypted: i=1; AJvYcCUIdefej+w2ZlxJCOIfCefjx3CehhH2iFzzXsw4ycc/vujgw/eHc6HUU3fHESwCxAHJX1hDb+uo4rw+v4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUW3hRL8Dwb5/uDq45th8OZf+YiEG1ebYKBhfYFBtp5aWd8m98
	29/dQAcF3kX5GYAfXcsLr57nf29Wq2bWueHNMGYcfK5k/BEab5cjjD12ae2LYR4/O94=
X-Gm-Gg: ASbGncveSujUoB9xuIIi8tGdAhT5wjZkq92h7HjQSGS5OIjKWtvmP8lUwWKFQG7UBsD
	9ktXi6WY208MGhpEhux5yxHkgTGjxTiOOfzd+XyaDS3XEY5Jom5M8K84XimlEJnCHmJHXMOeuxu
	Qplbjtv1Vt84KDSIvAxpz3tvAwx5UjphqDTHXTaYWHsKq6vQafQhwKZR0BDcuXAKpE/FIlWo1sb
	3ClolBaXMjx7Y7MJfeTGrA1lNMQbh4yS7YZlA4U5pGeReaJrm7ahBxAgRqwMpMNe7g5R6ajsa44
	bcf0rLooRus1Cyke04hCScmdGVyuEGnqqI+2jpU8iSmqh8eshUdpE9n+YqkbUI2q5MVrUdU98xR
	Ofx4JAIVPlJt8rLsmoLgcFNQ1QYTkwUsfua59xGYV2eQ=
X-Google-Smtp-Source: AGHT+IHEs+R1LKsR9RVEL5YYkxKqu6VpP01t3/djpZn+0eRzKazkU80lVkXlPQRhE7sU8srwi0gBgg==
X-Received: by 2002:a05:600c:4da3:b0:45b:47e1:ef74 with SMTP id 5b1f17b1804b1-45b4e8f8e38mr10664155e9.35.1755783459514;
        Thu, 21 Aug 2025 06:37:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm28937605e9.8.2025.08.21.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:37:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 15:37:29 +0200
Subject: [PATCH 10/14] arm64: dts: qcom: x1e80100-dell-xps13-9345: Set up
 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-x1e80100-4lanes-v1-10-0b1a0d093cd5@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DbsExdoRyp3kdjCk0epdoDIR0B1+3ES9cdqkRoNTHi8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopyEZ5bn6oS1bR4zPjt8iIEQweKLkClCLGnRt7W1C
 1cPXKJOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKchGQAKCRB33NvayMhJ0YczEA
 CrvCBjX0iDeoT0nlZ7oER3u7O+Ltxo+Nv7nP4Lk9T71+ST0I8+LDMTWDuzMw1LsiKxlA97GmyUAxTs
 xhYaU9VyTYEn+UNdUs4qG8Afy086wcS9ANcCUxFKcD+1elSPxb3VdEHiaG01EnGYMBpknliuX3tnXw
 brFP3r2Au74Uqk0YJUl5aJaiVt940OIuUVZoV6GV+rFAJY9uNCjoGFFUTwQZDUuDDsvEvb4TZXqzl7
 u1a1hviq69zK3pM+JwjnKELdJ+jHNcKsD9dkpgCMEueDXgsQNprIncc5QRbeyqt/4GYXr9NyTTUUUD
 my/kdFGG8+NkOTGrUtbl+obqfmCB0y4AAAyxT5PUYEOw4QUPXBRuaRBCckEL5c8hf+bXWsguiBia4C
 tzki3sRoQw42ifFk3akW/urDstvwGrxw9sKQRxi8OtCBZKWFRxgaz+X7sx8k9UTKf50Wq4Np3VgJxk
 6PzaMKw1miZn0TcuAt/P2a85t/Ur7LaffzXHVICVzTRTiSPpp2ptlolbZD6aN35dzVse50zS40TVVB
 lOa6Efw9ALi41a1m1F5uSQud+/8FA+Vqc4SE+5W6Q6iFm9f0MqkD9tuGByrNjw6lzbDSKcweYgW6LT
 QdghTIE41oMQQ6bh/BagF39pJWiPVKn53zhkpgVssBlI776e6AtVCC74Fa+g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 6b27067f0be66b5c41fa681ff3b4f535100bdf59..293e557ee07e0e622984d6f869a5f79a5766ed18 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -884,7 +884,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -893,7 +893,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


