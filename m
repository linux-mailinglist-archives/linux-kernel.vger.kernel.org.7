Return-Path: <linux-kernel+bounces-851799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44B4BD74B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319093E8B43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A69B30BF54;
	Tue, 14 Oct 2025 04:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9iH2FVz"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24030DD21
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416966; cv=none; b=oVvojL9gvn1PPl1RnQjtkro2GuJn2MkKmmTB+adjpRwf5MO9HP6YjAyVdtEacPrfBh3e7QBlOsPvlbqWiq7lBxBObb7SWOOMIwF2gAhiMjilBb8pkv+jUwi7OZnM+Dc09F586OxXsw2/Ewy4021t3eAgJtTx/oXk5xF5wSSGWp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416966; c=relaxed/simple;
	bh=EIlDG9uZbx4t+BVau/hnM39jO/kAdgreuvfIbFSsmHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Snt+5JkCgTjXUNulTltN6IRX9XnrUJuOmlbX1O7N/lYE4E4c/QUGAtu4MTtMR/eL4Z2Ezysj1J6NuPv4teoH9GokSrJQf3tg82W5jaQtpBPv22/SZD9dezHc99rtMVNfz8+6piIJLS53VAXh4eD+HCv9mbVOs5cmD4r+FKNJv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9iH2FVz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso4671653b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760416963; x=1761021763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KQfsBMFSGfoXUyfXP7e35VKlrSpIH4j7QZbI3mzBmA=;
        b=m9iH2FVzg8CtLUzuq/x9y+i/YUZsG1Qz38nL/YicS3guXrUhm/pYoEyzx6bNSN7BBp
         dhlqud8fBNpDzO0kPEmjFJpu6Kr9ILmAIZC1CcDWmAzdG5J/iU1Lfya6jg9klwatT9za
         ADawmjYr3D8Bc5e+BmCcQWwsNEtNx+J9kj0wULUt2iBv8koKGmKvXshR2h2KteQAokwq
         O9vhEcSbcTBCyn/amQdINDN+7Td3hJytZLmdz5JL5Iy1miUurmbfKPDVArRK6FS/Tpu2
         n1qyp69pmGpcO91FibKPOtiGbpO7UMhwJz/AxxIV/mXetCgC/7zoEDtDcJ5T42Cz3EUi
         Zhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760416963; x=1761021763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KQfsBMFSGfoXUyfXP7e35VKlrSpIH4j7QZbI3mzBmA=;
        b=A6OTE3u/y/X9RhN3K/7NzJJ2/rfJsmSBKF0N0U8W5pa2rHPsEquYU5hjmZahOxhJZQ
         Zg1GXyTSAlDMt3BDJBIqJpNu5afBnKTCsUrdawPjPx94alY5LWOHnujm397L3Sef+QFj
         AI6Uh9lWFKpZDhOdZ+4z63jt5IuMTzpIYTk2iprDrtQenzP/SkWtfoGW7Tu82idOre9q
         S7RkqAabA3UdwLE7jv+FOMXQuTY7Jjw0mpZnoY2PVUROHa3mvey8hM99qQOKw/n4Pylu
         0akfuIV99DIjCEu9Dkq8sEDepbmhkLZmloD+TmIANqmuGNQ8DdM+P6FqB6P+lfiikANV
         W+EA==
X-Forwarded-Encrypted: i=1; AJvYcCWtC1RgcKpwm28+xdgyehBYLwdjAtN+HdZF/P4P7ilZp8qw7vbnNHHpMZHTeS140JBrA40OC4ucxwWyR1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2GYIV73VLK/j6ZYzqLsMCdQbQZviJHPb2mZDuUaAXB9Ak/Xn
	nDKPqIodwQg05F+AOoyTARNSI8rC8lkUNNr8EHBYVb4/09gD9rkMU7Oh
X-Gm-Gg: ASbGncvw0rveJ+7jgXVQGqKT6ceNk4LBiyqAwODG7liboEC+XlDBefNbz/HPBxAzsSZ
	TaHkzLG2bIw0OtOe2FpMfQgQ3qL25xdrt4jOk85k9MeZReCLKrB5Rws2QY+ifp0uLxRp6dhCHWc
	o0WLZxUFwk/sHpIfQJjKAVREstp1rDz5SoOmRsKW0OXezMCIsroDTTo6zYT3TKj2dLDUt6/LkcF
	vHM8sbUEOcMDTIB95ZyZkyvw6qYTJB9i9WTrTq3lRsXpl/vrrejDTYa0W1T8rF/OyrdNXSB/SOb
	MgqdvXTv2juoEBYRTG3eUOMM+tSzYN/UkwA20e3sm4L0wRkGFhtiWJYF1UYkFujg2DcJhvQ1A6h
	kbCFtCRdLEVLOJoxIpPLsvqH36ZIANMObwQfMt/UKB4s9UeI=
X-Google-Smtp-Source: AGHT+IE7bkRAk8ugk735/7nQSzoaqtGZLAqU0QGh/8o+Ft0Bhm7O+ywlZ+lPoOEl8NUhH2Op/ri2Mw==
X-Received: by 2002:a05:6a00:1706:b0:77f:50df:df31 with SMTP id d2e1a72fcca58-793870523b6mr23769529b3a.20.1760416962739;
        Mon, 13 Oct 2025 21:42:42 -0700 (PDT)
Received: from archlinux ([177.9.216.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-79b65528a51sm8440684b3a.85.2025.10.13.21.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 21:42:42 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: qcom: r0q: enable ufs storage
Date: Tue, 14 Oct 2025 00:41:34 -0400
Message-ID: <20251014044135.177210-6-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014044135.177210-1-ghatto404@gmail.com>
References: <20251014044135.177210-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable UFS internal storage of the Samsung Galaxy S22.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
index 244fed27a4cc..a3b81403d180 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
@@ -155,6 +155,27 @@ vreg_l5b_0p88: ldo5 {
 			regulator-max-microvolt = <888000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
+
+		vreg_l6b_1p2: ldo6 {
+			regulator-name = "vreg_l6b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b_2p5: ldo7 {
+			regulator-name = "vreg_l7b_2p5";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_1p2: ldo9 {
+			regulator-name = "vreg_l9b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
 	};
 
 	regulators-1 {
@@ -330,6 +351,27 @@ tsp_int_sleep: tsp-int-sleep-state {
 	};
 };
 
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l7b_2p5>;
+	vcc-max-microamp = <1100000>;
+	vccq-supply = <&vreg_l9b_1p2>;
+	vccq-max-microamp = <1200000>;
+	vccq2-supply = <&vreg_l9b_1p2>;
+	vccq2-max-microamp = <1200000>;
+	vdd-hba-supply = <&vreg_l9b_1p2>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l5b_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
 &usb_1 {
 	/* Keep USB 2.0 only for now */
 	qcom,select-utmi-as-pipe-clk;
-- 
2.51.0


