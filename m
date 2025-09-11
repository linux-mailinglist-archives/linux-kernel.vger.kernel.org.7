Return-Path: <linux-kernel+bounces-812706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C8B53BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966BC1882F85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10E2DC77D;
	Thu, 11 Sep 2025 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlWFOPvr"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251E2DC77F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615930; cv=none; b=I7L97Dp06h4HZIXHILRpymo3u/k6n1ZK9XHF1bRNOAmj9BQF2LpTUKtIhZRgWcgXD1lOgPo+nlW5Nn1E1WyUdCIU3wKhq9OL91QwbQa6bzs5dx1g6FtX5h3d2OCn8Mlcq3oEb2tGDt/NU/T9QBXYBIe5dD2miJEo89qAPiMsBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615930; c=relaxed/simple;
	bh=CivzybVT6femLa3DyANzOoNr5Zw6tJRLE5//4WZ20nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4BrRN1bl5A/PKLJwAgJCp4oi8U1I0smTIf5liVTZBfj3psyMTCg/6rg2TZo2UD3F3VscBlSL0t1zVDIsKBZMJhA2DvqC5+pOUGAs1CRF6YIkpwUGyjQ688yuqO/xCrDrIVpEtZe+hL2vyJ0JDD5xEKnonfkZASciJmrLmDo/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NlWFOPvr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b0785be64f5so376719966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757615927; x=1758220727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFBNEsy8Ttzp7cjciSXICukNb+BZxKqaUl/2TE24rqU=;
        b=NlWFOPvrKIoC3T4X5bM2X87OEqr8V+WnrrMlNDUTv3sJmRhU1Xbwixo4mwfjDzdlDJ
         3F+J4P59MEch/LkMSZn3rF8OtBq9VXhVz61ZcynZJ4uoR4mhCbS56Fhf85damWcO14Mb
         V8yuWcrp3A1heDS/7lHNwGINBuyc0+63bR4+uByOIY08+aYuiTBbqVPLvH+Sw0M6gzJf
         Sxabw/MgQNFJhL10DN42plaYeprmjnaOZxZLxsfKMPIfDcaJ7htyyOx6fiplt5b4enkf
         +LJkIi715PGjccXb9h7irMBQ1GXZJnHtb3+zvpd0A3j8ddku657epv0ju/HFEDRs/t6U
         7Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757615927; x=1758220727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFBNEsy8Ttzp7cjciSXICukNb+BZxKqaUl/2TE24rqU=;
        b=mvPBzaL7t5u7C27L7NYJqSM51dR1kjvYGjYhiH36EDmHWAB6VqQVg3ED5Rzj/kJINa
         dZPRzZsmx4YnTaR4zwIK6iJGYmgQx6mxCE2ENYWVi6thfnBa/vBYkGqsMvsow9L7Uzih
         /tFw/+g3LCHkkmZ1cj+anZRpjxUI80NZ+cJl6ziYhQhon9Vl5jNCuR7r9Z4d38N7Dm+r
         Y9ORak2Ny5AFnt59KkmlACF1GWjE3Gjgdgn2E5xos/cWC/rKv36oNrE+OC3QfAmjR4UB
         lSNHTTrvv0+cFLkZQy+0oYZzdwY3XVIvnD2Lrk6YmXOdg/MZSdCNqV8DbDgGtGsraojn
         H83g==
X-Forwarded-Encrypted: i=1; AJvYcCV75NWcxWwcrcTmsITOWz4nQxMlLTTKfBPratQbpjXC25ML8kav6LSlANEKtKbRfkm2W8x0v0aSRBglVcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5HiSvD/pujew/uWQ10Vf83F6HBcIBMx6EARR9dWKSnixjP59
	FnQHfDeUVRr/+ykWT0Ikt9yzK7AlxbSwCq9H5mW2FO2k75eS2lM+zWU9Ly46kP5Pt0A=
X-Gm-Gg: ASbGncvBpcsQmezHqs7fUFh4i3+tRdxIjcFKQcTDAKU86YU99f4cedsYp89ThntNnkr
	hR1hjJoQgCIVSQ42mmewn0J/ted1nVfoIb7ag6ir7WA500L7hvMi+5EBwGYdzTx4OrUbF7gCLpx
	xRp5CilQ0xMs0Q2T1wb/e/kjnat4VMfOU8fJSgU+vvi/iaqNhfx87aubwhci2ba3oCCJGuGmuau
	rE3SKf9hQB9E6AipKiY5HvvjcgheOLHYxh+cz+iaWrz87VclhCkqXyZXkoF/FOhc5P+23FFhbwi
	vxlpxRqheNNAOIjWH/WWXlpE1ns0o/+W/kdU5XRzXoROC+c3eRgrvx7Rur25r74HKM5mTl4eYMI
	EbMZpdm7DTRu8msitXJ4UsaUq1ZkuGyOXd2zPsYvJRXB5HXxwnSoJRV8=
X-Google-Smtp-Source: AGHT+IEIEJ/a6KzzrDZCaJ+KLuB4J/84EJLHbvJ08OMC1rr6H2HpSczkvwGDXTGRT+cJBZWD51EhQQ==
X-Received: by 2002:a17:907:96a4:b0:b04:25e6:2dc2 with SMTP id a640c23a62f3a-b07c254393cmr35772866b.22.1757615926925;
        Thu, 11 Sep 2025 11:38:46 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:725:1e09:bed1:27ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31715fdsm183999166b.49.2025.09.11.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:38:46 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 11 Sep 2025 20:38:26 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: x1e80100-crd: Enable IRIS video
 codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-x1e-iris-dt-v1-3-63caf0fd202c@linaro.org>
References: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
In-Reply-To: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2

IRIS firmware for x1e80100-crd is already upstream in linux-firmware in the
default path, so enable IRIS for the CRD to accelerate video decoding.

It looks like the X1P CRD might need a different IRIS firmware (possibly
even changes in the Linux kernel driver), so keep it local to the X1E CRD
for now.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 976b8e44b5763b2d6c0f4786bf5809fee29dcecc..dfc378e1a056a8af27ef4b646f7589e7198dbaf8 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -16,3 +16,7 @@ / {
 &gpu_zap_shader {
 	firmware-name = "qcom/x1e80100/gen70500_zap.mbn";
 };
+
+&iris {
+	status = "okay";
+};

-- 
2.50.1


