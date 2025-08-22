Return-Path: <linux-kernel+bounces-781567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B4B3141C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50665175BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F1A2FE59E;
	Fri, 22 Aug 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCJkmWcp"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156E2F1FF6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855577; cv=none; b=ADacouDsiukJxHa4i15RKGNrQA2k80AmBsFFj2Ee9uUnsqFH8sMSIoyMKD0HujrqyF40oBfoGxsqLfY/GgLhjS0YHenQ1tUZbwLhV2l8u8MzORkzA+Gziz+G/9GmF91ctAKGXcOHX2gOxnige9BjUM0M++mvXhvRcJAC7Tqy/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855577; c=relaxed/simple;
	bh=sucDWngkcc57lEpuqUyMvN5D5nggCib4i3lqmpo2kAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oz/ZJVwpmSKYMMC6CRRNYgTMVdIoncTsENjXyAVIopMbmBASWIpEp/ZepwYkd/7Vs69N2wQX3TQcBuKXLuljyGI5PMH7FjANgioBQgiJcasgi+R+CD22uy5KVZQLf76WGA2LK/GBxMozDwtthmIiW/EuOmRG6gO667P3B/PUh1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OCJkmWcp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c43399ea42so1289304f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855570; x=1756460370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CdhuTg7uI5AhWYYHaCMZroPXcVIf1dIpA0xTfE6eKw=;
        b=OCJkmWcpWNt8xqqaxLonlH7LmAGXgJeBISG+md8EF/T2aZo6/DHtYljd1DVXJwlSaS
         cb/afgfzhxGsn36t5TRqvvKAvxhgbjkICdq3jycTHq5XVm2t0ado8mn5NmpWJwzZ8Zh4
         n2oU/120KzoYOONulTpDa7ONU6ill9sR2s4ZacZQPU1/tjieEVpqOBYm9svciE36H3x/
         zInAmXKt+jzY6qK99XkEfmpnUD3MIGpIU2IxvxR6msEO4vJKfRnPSesFHfx1jSNOdgrm
         O6AFKvhHxf1h6gYTXqUPU8CzQElYhlI1smQJMPTdXAyTz8rtdXz5xtYjGrSVAI1p5JyZ
         ZGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855570; x=1756460370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CdhuTg7uI5AhWYYHaCMZroPXcVIf1dIpA0xTfE6eKw=;
        b=fEVlZt5PqaaTwOESuOqEGCiDjv0q44qHP8K9YAALfJneNMjptIhHc/XCakRNnqb4tH
         ujNNT2IzNcuB3PoTZrjR5xXKsp3c64yEWMt2ERy+Sjyd6hPQWzixFGBCGMGdPX+K42rQ
         vdInVAExT8rUQmkSe2ZzuuktoShpaZ+6AtWtyQto6bdDSR9EJAYDWayJadhP7iqYNieh
         LSQS3lML88SBVvnPxttmjZka5Rocnm6hqIovV+VRT0rXXS5bztL0KwIMC6oQENnWfgzA
         tDnasFZOhHWgQcRK41EaYn8LcieA5DJ5TQDzfXiymJ9gV2zr8g+iWPfUdzb0FXmWL71R
         ddaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvi9bCUQN1JFx211In8vgXESWP5xupUF7nxcHkdevzPdR04Y0a6hFIMkF8tMtBUlTaj0MOlegy+0IEeuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJKD7WhokC+p8RED3fhtuPLxRfMHS1CXBc8r7x/vYDTwK2J/x
	CJPHfd+KhtzKKNz03QOx6wI8N6SF2hhlMf1PqarCNJfykh/1N+6S7xd5cW0bA5aQ/1c=
X-Gm-Gg: ASbGnctYvP8Eikiu/kD3FZGXLXBf6gh+OVCLFKPfIv01oJTJ2RFoUJOK+4bDQ6r0glF
	bXZ8fqDB3Jr3JFbOJ0maLTP0lJMM2VGI4AH1hdtM6emjIk5+HxVKpiPGNXsyQYVmMjrVuLzhS+w
	notEHUL2LQ6oEBFGBg4GRf7UBw5hIq6sCASC8mPQTJ+7uJrrOk8BYEWNAG9lKMa2PczkYiLF7uH
	oETwcq2lcaHLxWKJnu3U/29aZKueVBQpKidAs1Vf4klakB2l1n23kmFYyXw1WlRXB/Fe04+5pGS
	l21Lr9TYw8iqu9whs6TbO4/Oazskb0+ZCN39S8iG5lMINTogNJY/r1ImKWtZz8MurAJutt3K4SC
	4ylVNnwRjzVkwwopweSWAxTKtBXrxQZg1NArGTvypcV8=
X-Google-Smtp-Source: AGHT+IHJ2VaBIzdyibne8vxxSkxVrugdClFsD/VrfwDeBGxeuV5iToOjgPr1P4JAkzlzCNYIwQygzA==
X-Received: by 2002:a05:6000:4013:b0:3b8:ffd2:22ca with SMTP id ffacd0b85a97d-3c5dc540642mr1647058f8f.40.1755855569686;
        Fri, 22 Aug 2025 02:39:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:24 +0200
Subject: [PATCH v2 12/16] arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x:
 Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-12-4b21372b1901@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sucDWngkcc57lEpuqUyMvN5D5nggCib4i3lqmpo2kAM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrG+LVpddQuq2YhHvZzDua+lPbbR8J/KlSnmNdp
 f8WAwXmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6xgAKCRB33NvayMhJ0XxiD/
 9OT8KqBJwiJswl8/KojhEJI+iUqv9U5AXZam0Op9nryRSrD+So4nduIolU9yWkd55RcpdRbbwcPYL7
 /dVkL/4D4b8gzWha1RZ1vAUX96OgRgnw9zJ+dntWpRmlNJ9PryrxglpRbWVJpL2q+CL+Y2TcqqrOH5
 qYccihWrQf2kYeMRrmVGiEhbGA6suED1r5KbZVeaLjplQq626RYNvasK2hcVGIPdgoGc5isbZP7y82
 qnSi2CbyoNKPJRKbX1q1/xhavwRdiqOt2g1g75B1ozFgBkolwYdnTSMP8OqpARu2EKwxpsXprFXdW9
 DV3lqz8XbwvY5j0oGMS4Nc/YU/1lwnEjvoxrd8O2zYV4fwQZFkGXi2bE7j5gFd5WSaf+/6JYL3VXsK
 RxdB/iZd3su3nH5Ono0oXuUNdpfSl4HzNVZDKxP1/Dj89QXpQ9afvaTDy6dVqyeEbL7dt6IVbDY8Pc
 7Ao/yw1WEPJsMEWq6xX4bNzz6Se9pfiBGlz3hyofp/LebUoHQVDSh1SkCXpBRclwttlAia0fw8Fk9y
 RAfXCHtY6iDe+m2kswg4s4VJyP04lPLNtl5TGg3FlGvQsxEj4pzchQz1HNrXRdwKzOPBVMHCdlL7/x
 M43ZqohfHe4ecgzvIry85jEcLAHDZSacP1kCjiu1EkM+Na5CAeHsbjtl2Cpg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index 71becfc5e6f649299b05b0b93cf74b81dea9fa57..4374692d6da9030462a577279263dceeacb3ce7a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -1061,7 +1061,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1070,7 +1070,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1079,7 +1079,7 @@ &mdss_dp2 {
 };
 
 &mdss_dp2_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


