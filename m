Return-Path: <linux-kernel+bounces-782401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90041B31FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A71CE86AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B223D7C5;
	Fri, 22 Aug 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCwRfI/j"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEDF246779
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878223; cv=none; b=Be6N/LvtIetVmYHHSXMsaNzPNwD7mt1bp9w1EsjlDsNDVWIdf8R3UgFzZKSFPwNGQIF8HrWeiQftfjvgtGaQ6ZqYe8tk7Eh+sRFg0BzieqlLTDlqkOh0lmEvZ2cffWhInBWDjljBvRhJpfp6b582NUVPGb082yk3Nzsu0TLOmp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878223; c=relaxed/simple;
	bh=KHFC3oSUyARY/aVGviSmjbC0ZO4Tvpg1AZ1CxPkbSaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ei9Dz0gu+s27JGBHphrDil9ohIbDh0ztKksd/rUuFSJdAZCcduPlO/7rhsn47EJdl1feV19HpZBaUnCKA2SlJa6IpI7wYPlzzS6GlmJIWjtkOLmRQLOPRzipBL8gQ8KST82WGnKAHtg7WsrJrIWOhGSOum4cKbMydT9eWOg4Nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lCwRfI/j; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e415a68fso1880717f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755878220; x=1756483020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gIJqXZNoT2iaKOQogoMlUwIgT2STqgUO0YTvgh3yWg=;
        b=lCwRfI/jCW/18NRDrP26oC+IbAzppqG4sOnKCqZ3ZiGUdaLCp0+JtL95I5pVfEfUoz
         2vRCljQNc0IzqbKFOYpP5/qZ8OcCGJZBMwuWqxZbQaJkVNa0H0bGJ79giUf551nffDnv
         +8THLpidGCdHgxV3LBKs1o2KlmfyPJtvEIrNDM2dqotQVaPsJbKsLZyVxXidjisOEJ7y
         n6UmsXNFLTa3k72qy67fs1RZ9cN8zhDkj42ecWguufC+xNZU7KPGIIbVg3bjbq2sJ/wy
         sE3RO2uk5rAkWMFLRCbNkj+oungkdLnsQ8IHWcbxNLqc4oAoMro/CugoAgeNHCfkjYcV
         boOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878220; x=1756483020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gIJqXZNoT2iaKOQogoMlUwIgT2STqgUO0YTvgh3yWg=;
        b=Vj24iq8ynHI7DURf5Xc6vGwjINkSqiOFUNmeK8Ide+HBU0uA2iq8Zks+59r59VFsmd
         MCfxxnbI0bzAqLbmRAwhWvlKYvdObFjNf9/8WimsdpBf731UTHLfWtYLNpS5bWuigpq4
         btDA42nF6l5nDUOWF/jv8gbrKesomXt/RXaaknRQIeJY6DlIYTjTHuaI7eEsdTlvmD6d
         0UF1zik9z31GBBxb3vtS/gA/kTFyoTLP0NZIvK7DV3kNc4sbnl3Yd/CFPrKU91OQUpk5
         iCjeNcUTgKVwDVVY4YNaFwLVIlYf0IwVzFS4RMQXK5RWMNTLMrueBFRqgqN6ZCmoZtIE
         yjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWijBaxOklnZKNLKT1giqqEWUoEURcueXm0iMF5f9FhW1OJOy7KsxCGChSPxs9V8E/1mQ8A3W4KZ6pJ2Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcr/+EoHECtl5VSajJMrp+7mnZ4pdyshErKZz168Wgsk+Qrz6O
	ZfYB7Q8UV/RnbECq9zbzpx2VxGu4TqtkrXtmqDCEIl/GcFStAfPEnoJFSRX7UIfUQZU=
X-Gm-Gg: ASbGncsPv0qzNUIllQhhqvRr9MIJiw96OHPYMzGXU5WTgV1UxpMiN5/W2DnSIeaavB2
	eEjLrlwX3NrpLbN1PArAqeitDPqWSDSaTWuHbZMy7LvaHWcyC4uA5SoXwVTPuWyM8tL8tKTr/n0
	dENO7Vjt2iSJdB+cRk2KqR8N5lNP0Os1DXGoasdqxx6z9b7KO3Qmej4rtiUt7vR8ec9LhdEDQhR
	Alxi3ci0A+hOPyDmCZcXpoVDDO4zIfKEh/B0ddDhUbnwGjF8hgDPpQh/S8uAtX6PtVltHBFCBUq
	ROIh0E4KyogfCPYzvOzdJLoc6kt+cLHLW2Yvi0kqJTUVjdsfJDIyDYze/g9Eu1ZlYIqYbW3+KBU
	0eW24yWftt+eTC2akCKFdnVba58rRiYFBiu4vw6vvS9qcVvnEUt2DVA==
X-Google-Smtp-Source: AGHT+IGYiaXPZHucCBBnXOmPN94jkOGupuLilAQ60PnrJmKs4Sddy87Oi7De3a+mFMhr2Nf8CMUnEA==
X-Received: by 2002:a05:6000:2882:b0:3b8:d16a:a4a5 with SMTP id ffacd0b85a97d-3c5d7ac658emr2574678f8f.0.1755878219623;
        Fri, 22 Aug 2025 08:56:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3c89cd4d4sm10095765f8f.42.2025.08.22.08.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 08:56:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 17:56:52 +0200
Subject: [PATCH v3 4/9] arm64: dts: qcom: sm8550: move dp0 data-lanes to
 SoC dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v3-4-5363acad9e32@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2466;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KHFC3oSUyARY/aVGviSmjbC0ZO4Tvpg1AZ1CxPkbSaM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqJNFQZ2ShNYj/h2qkN4MVwhpIPMscAkPaeb65RYi
 yf7auyqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKiTRQAKCRB33NvayMhJ0ftwEA
 CLY6UebsW3HmJbSGVZXeccwwSko4oJMr8RKVDijUKSMnkuvboRvxTtlDXB7zVf6Ihq2nfoyHc2xX89
 FNfpHHADMJUWwQgU0a89v533uoI1l2xCmKUpOLvFlTG1NiagdHM0REfr6paOj/qwWN7Ki/c/xFPTdV
 +Hrtl20McTJTVe07cdES2gQtB9/zJphznR5J5kmY+viHpjvVRpcwtuKBWS1l1ZQZUA7JZcIKKzCvJ0
 yCgSkfybCJ8tCqWhHQaJlnFTju9o/1iKO1L7h+ffNVSwBhAl4+HGaivC/3D/r977+7wY2ScXiDapKm
 uc7Y2FHe+x6OKiMXqNeGQLc56ibT7tykUORj19xt5oh8W1L2ycb1MAVwz3zc8vYHL+OBB9lJs95bTj
 hNV+BYp0gd/CU336e0U3jAKDIc8W3Z6TU1UxZ4VN1M+beN9i34oB3E8IzZ5GbKa0937qY6De+GAD0d
 otffPFEFRS1sf7LXZEwWyvXnCC4R4DX9HupNcpkm9dJv6lrQMAIuICBOJZVN45uICjC5PC+Ltiweiu
 eCGNEPIfUaqgcPyfMaZbsQymASC0/zH/09bSClEdP4rmO1fhOUs2eiGCKh4r32I1L49zPsPvJZBksC
 jANdPRVoAXqUbwVvnXz0ACKakCL9cynE8l9fG4vag2dBKOrdi5EHdijFA1pg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The connection between the QMP Combo PHY and the DisplayPort
controller is fixed in SoC, so move the data-lanes property
in the SoC dtsi.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 4 ----
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 4 ----
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 4 ----
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 1 +
 4 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 9dfb248f9ab52b354453cf42c09d93bbee99214f..3322f2afd3d6b92d00cab5f03338fd1a474d6e62 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -1002,10 +1002,6 @@ &mdss_dp0 {
 	status = "okay";
 };
 
-&mdss_dp0_out {
-	data-lanes = <0 1>;
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index fdcecd41297d6ebc81c5088472e4731ca0782fcb..635c96f929f4ec034db824faad6a2ba30110394c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -738,10 +738,6 @@ &mdss_dp0 {
 	status = "okay";
 };
 
-&mdss_dp0_out {
-	data-lanes = <0 1>;
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 49438a7e77ceaab9506158855b6262206bca94ec..4efc30fb34c0ba856d196de8be38ff2d2755c302 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -857,10 +857,6 @@ &mdss_dp0 {
 	status = "okay";
 };
 
-&mdss_dp0_out {
-	data-lanes = <0 1>;
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 0409ae7517f239171a89bc0ba7bb47bc9e7fedaf..277820491e8e96ce282579daef5287f6327ecbbf 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3791,6 +3791,7 @@ mdss_dp0_in: endpoint {
 					port@1 {
 						reg = <1>;
 						mdss_dp0_out: endpoint {
+							data-lanes = <0 1>;
 							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 						};
 					};

-- 
2.34.1


