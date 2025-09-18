Return-Path: <linux-kernel+bounces-781553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F6BB313F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B798B02F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844DD2F3C10;
	Fri, 22 Aug 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4qAIruQ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68742EB5A6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855569; cv=none; b=mBcmtt9/5UTLRVtFm9wWgawNicyU3tDNy0J1MkgWk+kfcmfMBEKL40iN+Tta2LvIGhcHySkhKFCJ9sgKo80nMbkaDIm8xmT8tB0oDuYH2mfpKsAj+GrwDLGI55ZbskpWXBA2Yh3tpQSiugGwD+7OrJ2yRPZJG/udYe8wTsH7S9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855569; c=relaxed/simple;
	bh=rr71+BBtnhxoI0vp1gh26EB5RHubOusDekfjzEuTCME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DBZK5KpMY6mmih9n9d83CbztJ5rV4ZUEVG55UTQ8uOMS/fE5H3aPfVjUWvr/zjCLEQjATu0oMP6XZVuGJrrBxk8QIrU0t7xQw8pdGln46AojeUTTatXhJyZUmWqWUKs6EFlQtdxqp6pLapbNYkp1d6FxZs/aXN617KyHsI/q9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y4qAIruQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a286135c8so14854535e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855563; x=1756460363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8BLkvgVSbp7ucpmwzFe6L0udmC1CeuwZxTZJh2EA+8=;
        b=Y4qAIruQbMmhbukL6LrBBPHd/w995fgwx/HerE8RfnC6OjoyIMq56/vgPLXnkMD15z
         8IzewdAROipWBXRf1uuSIarJBF+ZwiyQdyVflZxghWEC8oKOxHQjirEeFt351Y/AeBUv
         cXMuU7M9wEcv3TqZZrBEDSWUq+68OkEc0QhcRPiUmojYbKUIaoFsHMIGxYDS2+kFfVGq
         /CjcvFo7mH7D/+zeMfPrQLfgV2s4Q+K6Rcr5LC/1wly8/FQ4oDDOfu2RS8Ro5Fic5UXY
         K9JPkXO0DPXhROaydwTYlkb2iIkVGYWSd0pgN/fhQtBKtb+thANHOpJAuRAYoaeLiuXY
         L+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855563; x=1756460363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8BLkvgVSbp7ucpmwzFe6L0udmC1CeuwZxTZJh2EA+8=;
        b=mWweqaYf35elS9A719ZFdXNry6VzRG3G2WQpDsfhFad7Tb7Sg+3Kwhq6pTn6VMLz4m
         5sHP12t+VzQK92mHgEcwb6B4aq6pU6nmjhNz++u/MSaLYdZEQgLgHX2+K18varyJaKak
         yIG56zsRNt62DRfBz8iwabwX+zf8W+5uArNoBbkV6LrzfVcBPxl6xivfbl9wQRNEjRAa
         sdRuRuy+3mz2liVxXFyEK8TCwIg4NmJEmVkZOPUphaf6ziBQa4hDRGXpQ+njykDG/NDP
         alO96n/7GvuSc/z/XmLZbxpdWaUQ8Z+n36m0M4HYHdZwpCP4t8EZw3K+sZRpV/1LZKtb
         KS4A==
X-Forwarded-Encrypted: i=1; AJvYcCU/Bk3f2YP4/XmPq9F2OPSr6qTobXQV5fW6YOD6TQjE8MoD6gHgJAMZvDFGV3dl+AlYvcZa1pHIqShaGjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCwCrowZXcsCAflmHsYGxIO6TGc3wce/Xy/YPbmX3aVYvQ5PK
	Sx3IWJu7UHgBMP4S/8DNg2GuRIks3ICLLWEWg7Xa7Ga5YcQyl1q6nuLm9YN7Z5dwzn8kHUZrUo/
	velH0+yU=
X-Gm-Gg: ASbGncsF/xsMX1KPcf+n+OP/QRAaSyU6bm8Kto0v4mr4EcNkqXBXdg4KrBtijpL+Dki
	zksMUjHPweX23HKBZH1oPBMZNdEfBpACL9UwPh9M0FUNQFpy+poSBC0xbzI65LV2YRFCCXsE4fx
	aHG4q0A9GJCim92wD0pkcXua7thSNEuq0Wi7WBOaHivEnGFND0eawWLnG+tRb+vRVGKICrn60vi
	CRjaKyNL15a2uKxELKoPG1kBHNfFvfc1yYMGb/EELIdc02qsKEaEwYGDIFHN1iWxQyQWLTy6Nls
	nQtdWOvjGoP4NGKMI4hhaqhpkwHF06p4oDZZEg5VI1AviSWfFiz/CMXwfDePNbjbriOQUsy2Uv5
	PXlSQvexLXE4xgQe6V6JUfo5SZc/zgY77Qeq6VbDaqNOEaVupLI6l6g==
X-Google-Smtp-Source: AGHT+IHkEjGLOPZDQQAJJfc331wMAfAko0s4sN43VgTmDN2Np39z0BKpArqORRG5gXz0P4/jO0SJdw==
X-Received: by 2002:a05:600c:a101:b0:456:1146:5c01 with SMTP id 5b1f17b1804b1-45b4e1dffaemr39935825e9.12.1755855563553;
        Fri, 22 Aug 2025 02:39:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:15 +0200
Subject: [PATCH v2 03/16] arm64: dts: qcom: x1e80100: allow mode-switch
 events to reach the QMP Combo PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-3-4b21372b1901@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrCMu4SEvkcLpCWvdlZ5vi82Q+kL6aYpxHptRDW
 haDR6/KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6wgAKCRB33NvayMhJ0fCXD/
 4si6TUAj6Un0+uq5oPDOHKa12lndEe+g7jZFhZcD5A36zgd6lckNc6eJ/0SHl0UlJy5GGrpQo555Gj
 zqru6l2taATvXH2a6p55DaxcrZqRFCe2kFlgopWIZxjTtu4dB/FxnDcQ1XWtFVHeZzWiSLhJm3dIC/
 KHY6JW+NOhl1Cbq/Upj5SfxjHCKovOdsLmisC+QF1W1vORKcpCabYic5yPWhI/8xgwsey9gEPb7fCo
 KV2AECcGzGWcTKkLos2JNL3NNFv+j0Un9cp/dKrWWmUNwl7tL5ypQ7BnO7YscHqtBcrEhuKqAyU/4n
 HAs1Nt9KLZnmopRFU8rFdqC+MMUx/nlyPQgSaojqJvVASJEHkjCIyd8ZjprRsdCAX3MpuwvRarUAbc
 BqZQ946+Ovw/k4sMiALIS9UuAM9m2VeYgfpJZr1uZrfMEA9QGMfQmMK8dA0RSEvDlmTsB5Cay9I9b2
 U+LMrKWmt3TeJ9PKN1HsedMcWyPs2cbm8TYQ/OgjVOWg3E3ErqVH/g0qPOfcBznpTMjlDgwahBYS9D
 QEnpgWL8Ok2OJPFDRayR82xp3hIzHX6cUsHubF186X+ahUF/ClXUbWR8dLWfP+KaaTzBBlNg5Ra5QF
 0vxKAN5DipqKR+IvB0DUtx8Yq2X1FYlWsT2CPDiILk4LqQsK+ZrhHp7J42DA==
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


