Return-Path: <linux-kernel+bounces-749520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE40B14F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6351E18A2750
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C894F1E5B6A;
	Tue, 29 Jul 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmqdD9v6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20071E3DCD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800059; cv=none; b=d/NostuJHWLWj3BOTXI7yApzy0N2xG3LLkUGV4A/bVLRc3f9nG+wn9dXYdD1mm9fWYSO45GS+YMGUc0fUJOvClEWyDDvGHE4puAzlWtXisaUr6ygsglvD8CH+roWAYuLWOaBS/c42j5Cpqz7dexpD1ld/PGjNIW26UJCk2lDIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800059; c=relaxed/simple;
	bh=/wEWbb465ExKV+T7bJ0HBejuyU/5tcn2W1sfrgwD5RE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H2dRCKAbw/47pAeApj369NaTNeYGCciBuqCQdKN4pPd1S9G0DPsl6xaOR/vBfJ3WgfI3ceNLJ0Axy7ul4eaxQcKSMeK9cHy4wWQY1CXFCo7//S4PFe+AliK0Y9BJ78KLjNnu2rPkLD1i6vxP3b6XM8LiStefBkn3KsRxmKv/2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PmqdD9v6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d7b50815so36903975e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753800055; x=1754404855; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLh+h6RKVeRF9vn5UFm3NrD6UnKkA16N3AUlT26ZJdY=;
        b=PmqdD9v6An1+tISU9C1NIgBip2fT9E54Lgv0eUWJ4lILBOT+Tdvc7sWJdgxoiExvx8
         GMwS9eb0iR6IjYTvPhOKsPPuaY1yBFgncu30dXKiCkbSdjwu4U6j5jcNsXNhi8gxVzOQ
         NoQo6DwQmV9rvQBUxA7JnQ9L4WCkAsJ5/dUet9MJCTmVI/iM4Vm38sSeTszuQ8FIW9Es
         /NHUVrQAxmMpGKX43zQjLHzp9l2PbnopK1aDDF98nHp7rJmm5He6W7xEKh6NOGkkO74d
         BnL1iKZPRgleRutMq6aoldn3gppn0n2+UwjW/IVXNgf2U4sBDDgM14V71ppbwCczeLCj
         ge+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753800055; x=1754404855;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLh+h6RKVeRF9vn5UFm3NrD6UnKkA16N3AUlT26ZJdY=;
        b=mp/WboXk69kXRWpm8bXbBWB5x1HgXDSQ+vTrAntQnCTuHSUGAoQWH1eB5nZOcrh0Sz
         c07HtvP5SRE4G/Oy4lIaoyoNFtENkvVkP4Ely2pmA523sEQIROr3NFOnCUzqNDBoMqdv
         5gl2sruoxZr9/u/vooRMk5jJILEO50uhyQQvqG7or3kzP1hy/rYu2IVmki/SOgp1/sIx
         uigIG+PXcgo0YbeLTR5kRwwWWiN0G4wxL0ufEi3zQsM/3JpI42X7kU7tybuaeai5yeH2
         lrljnnmDUYVz6kqjLVO3bE7UG+WINiC78AxZFlJd1lj6v2thtTGBPlLOkbcwy7vRK2sE
         RHlw==
X-Forwarded-Encrypted: i=1; AJvYcCWlEsnZhZj8WmvuNk2FP9nFZ6NIWBed+vAxMHxyM1JPqKHNKioqCR9vBKvf5MTQQ+xMoQohuiIS1UeMdzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS3YIA+gWd2c2bYCUz7xigZQPXy3oyB8910OD/bE2hMJcso2EP
	hHYW2v2/oHf305HrF2EXOu1pkGXWenR1dSKI0e4+o8n0bP62nDZ4QvNRiFN3/pz61rM=
X-Gm-Gg: ASbGncs9bX4GgUOKkyeuB1WxugFqgPIm8Qu+0gYAOnvylJmJLVXt33xI6a1Py90OuQc
	tRQpiUMpNEaR7oCKY6D+6quiEFLxyFpJkbmln4juwXjW7kemxZ4N095qil/KsIV0Fddtb2ebxAo
	2PrZnveSpWndCC7VPH0+HjbY/mZ/qFQZVlxLqtX88a9Dk+sXPEpB+ZdgJM2XeJgRae6qN4ih+PQ
	zzDg7VpxVRRHr9pan1Sg9m6zpx0ZpPDzHot6xuq8R0gn+HLPAiYjlEkaIhk7BlFMrWMnQhDu5NU
	db2Jx7PHed1bnTi6Wu9PNQVeME5joKCD528AbmRw4ZytdXD+uwDiJRVgZpaWCAHXwOph+P1qjc8
	zCcHAdXlkzerQXj6upMZLWI5m8dCt22DkgCKLgMeBq8k=
X-Google-Smtp-Source: AGHT+IHBsI8akUAB8ZaPm/sK/iMj3dMqBC+QObDZFmQGFYf3egxcWft/ROffrFyyMewtCfDIUC3npQ==
X-Received: by 2002:a05:600c:c168:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-45892bbf6b9mr363055e9.22.1753800054669;
        Tue, 29 Jul 2025 07:40:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705c4fa5sm209048415e9.26.2025.07.29.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:40:54 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 29 Jul 2025 16:40:53 +0200
Subject: [PATCH] arm64: dts: qcom: sm8650: Add ACD levels for GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-topic-sm8650-upstream-gpu-acd-level-v1-1-258090038a41@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHTdiGgC/x3NywrCMBBG4Vcps3YgicZWX0VchPRPHeglZNoil
 L67weW3OecgRREoPZuDCnZRWeYKe2kofsI8gKWvJmecN6178LpkiaxTd/eGt6xrQZh4yBuH2PO
 IHSPbeLsatMn6LlEt5YIk3//l9T7PHz5K+WB1AAAA
X-Change-ID: 20250729-topic-sm8650-upstream-gpu-acd-level-1c430e7f158f
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3183;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/wEWbb465ExKV+T7bJ0HBejuyU/5tcn2W1sfrgwD5RE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoiN11jWR6tgvBZ0xh3A6BhjSIlYsio74lH6G8TOZ4
 kBvyJ82JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaIjddQAKCRB33NvayMhJ0QbYD/
 wL4UncnQOs+FnvzT53/6Y5not95Syq6kTxwIxmPL8b8x9aOjuZUx+KNT0LefKRcSl0aSEJdIgp3TwE
 ZslycokuiS8LHSMz/X9qw+NyCLrdgLbJ0x2QCjMZaOXGJg/TOXYX2A0/fDUa6YRudSMyUQq/qnP1FJ
 GWmbJV6bVup1RZTnqqS8rh55AgRM5s5qs4kmQvB8xg4AN/7FQdPp5u1JeFLNo82LcAL9aT1tDbLJE/
 OEsAxW+HdJNetrz128L5STcTMis2JqXqUs4xTbkEz8RB/oKHqePF3lakj8vwjuEOskjH6F0uUg2+2S
 oTYwQDiZv9PzQh5Jq1r/lArSPB4vAGfBgvfgKPHR/QRLjNc3OIBYMLTredvnxdIxXmBHXNwz54836U
 EAAro9oia5APz3mYPjWdcKoyUd4Z8iZHJ1R3KJNUhOB3GbCsBaMDWyK3+e/ViT3JppX2XY6uWgFf9i
 fJcm2tYdA2G2VeO+0MvdVaV5ve1Tn0XKYZ3vSVi6FODOxiWeGTMn3YZR6IQhaCqlBUxAJDWaoYWCqZ
 yxzzvy+sFanq2qr+9nGOoEG7kjTEhvKO8FQOm+LQaCk9uE7mZV0yis8Rr4BT/vcffAVZ03RijRnig9
 n2UpynQrCEt6ytkRulI40u6BLdGeYrqE6+lvXQ3DHIO62D2gEc4N4E7WzSGQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Update GPU node to include acd level values.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 495ea9bfd008500dd2c9f46ceca94cf5f972beca..4cd933219ce008bd1c603c87778e210b6332e29c 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4127,72 +4127,84 @@ zap-shader {
 
 			/* Speedbin needs more work on A740+, keep only lower freqs */
 			gpu_opp_table: opp-table {
-				compatible = "operating-points-v2";
+				compatible = "operating-points-v2-adreno",
+					     "operating-points-v2";
 
 				opp-231000000 {
 					opp-hz = /bits/ 64 <231000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
 					opp-peak-kBps = <2136718>;
+					qcom,opp-acd-level = <0xc82f5ffd>;
 				};
 
 				opp-310000000 {
 					opp-hz = /bits/ 64 <310000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
 					opp-peak-kBps = <2136718>;
+					qcom,opp-acd-level = <0xc82c5ffd>;
 				};
 
 				opp-366000000 {
 					opp-hz = /bits/ 64 <366000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
 					opp-peak-kBps = <6074218>;
+					qcom,opp-acd-level = <0xc02e5ffd>;
 				};
 
 				opp-422000000 {
 					opp-hz = /bits/ 64 <422000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 					opp-peak-kBps = <8171875>;
+					qcom,opp-acd-level = <0xc02d5ffd>;
 				};
 
 				opp-500000000 {
 					opp-hz = /bits/ 64 <500000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
 					opp-peak-kBps = <8171875>;
+					qcom,opp-acd-level = <0xc02a5ffd>;
 				};
 
 				opp-578000000 {
 					opp-hz = /bits/ 64 <578000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
 					opp-peak-kBps = <8171875>;
+					qcom,opp-acd-level = <0x882c5ffd>;
 				};
 
 				opp-629000000 {
 					opp-hz = /bits/ 64 <629000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
 					opp-peak-kBps = <10687500>;
+					qcom,opp-acd-level = <0x882a5ffd>;
 				};
 
 				opp-680000000 {
 					opp-hz = /bits/ 64 <680000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
 					opp-peak-kBps = <12449218>;
+					qcom,opp-acd-level = <0x882a5ffd>;
 				};
 
 				opp-720000000 {
 					opp-hz = /bits/ 64 <720000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
 					opp-peak-kBps = <12449218>;
+					qcom,opp-acd-level = <0x882a5ffd>;
 				};
 
 				opp-770000000 {
 					opp-hz = /bits/ 64 <770000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
 					opp-peak-kBps = <12449218>;
+					qcom,opp-acd-level = <0x882a5ffd>;
 				};
 
 				opp-834000000 {
 					opp-hz = /bits/ 64 <834000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
 					opp-peak-kBps = <14398437>;
+					qcom,opp-acd-level = <0x882a5ffd>;
 				};
 			};
 		};

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250729-topic-sm8650-upstream-gpu-acd-level-1c430e7f158f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


