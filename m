Return-Path: <linux-kernel+bounces-825446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3FB8BD1B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5145C1C05AAA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C6D221714;
	Sat, 20 Sep 2025 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWreJdvk"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491C22069E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332844; cv=none; b=Nhky/LEB/vIYjihSRpbpM065+c8F2Eolb57Jscvr7i5yeWMzvwV8CmACzLfpSBuyN+bLkVmi/Lca2paXpSz7EFbmoPUS3uQCHsV/MeyU+QGS63fVI+8aPO7BwPny0bAWG3LTBrIZx6x0rCn6TpFGQKqbfwVBQP4bGQ6I8BPe3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332844; c=relaxed/simple;
	bh=q7Xfm32bQVivWAKM4yd8tFW9E2pSlnxh8P7wsqP1uaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFtjWBHL1vZdJOkLvEqqJfFtyxH3BmWRvv96V3oztu53LtL1dnNTy/FtzvUpk4xyuLE0AyM2HStmEfR2ok3TnI7riRS3fby56H4B8yg2pBnSlaLpDNaWq2I0M42ByUD4gI8Ga8auoNg2EV3nIdHHYq/MMWELu4pn8MayVVvOUDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWreJdvk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445824dc27so29218375ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758332842; x=1758937642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K4nVmfnY5pKLRLdVHuNKFKe2bl1ttzHe8ukP+rPnfM=;
        b=GWreJdvk9R+m7b+Wk8nriEP4+W/lgVd3qBU+tKvtEIFTOypNh1COn8D8EvPrrBnQ2u
         SIig0FH6PtUAYEN1qh3uf0s+xqVfa6fKng217ts075BqKYohfsnHvt3QqCCI7YKU16iv
         vIpjmNiXGlAIGwzmR709g/cTY6bgF7bjGR1QSAf7PmPBI38guYryS3BFi9Hy8qDA9AsA
         PG9mD9Yq+0ybN18NVyhZNVeULLPje38ZOP7YSEuIWqV8l1rzsoFme9GhsKoU12q+bb2c
         unsA1QWWGeZH32NeXHCGrh0elXkTOTaVi7s0LFnn8Wou3SpXFj/RvQwYIu2NL+gGr+K4
         6/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758332842; x=1758937642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K4nVmfnY5pKLRLdVHuNKFKe2bl1ttzHe8ukP+rPnfM=;
        b=KQVWtUmp78PfIQ9AO0IDoOIqt/1mxjznGzXahEadE1vo8R8LU/NKkDarsXrEjs2pE1
         tppKesBRHgBJ8aKUJaAoTpmEBpkeMuN3qsZOjtKjj72P/mp4waqT2wDs5N7mPBkT/lYx
         5hfUNVCjd7n08daGyNY8r0kFlnWEdqjjWxX1h7+ccbPqzyEY+OYkh7JVfcxv6hBJzbvF
         WWOiYXi/KeP2GJ/iHI3S5zcAnOn2Xk6OM6DP5aea9bhcn97ZK9SV8jjwzyEpDm7RlnXH
         2tuNRVRlGLvzRueic/lqz1YDDBcHsui2zJkgxsK4f/Dcl1Ys8a6CFK2fGJhDS6/ikLZG
         es0w==
X-Forwarded-Encrypted: i=1; AJvYcCXuIJXqjpTPkbolokqvDNRtr+T9ARm/vfwzQVB++4F82TBp3GgwmtHo1bHNey6qr82oC80X/6UzM02wHBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjHAhjgWSo2PSHq/mB+yZ2ysmHels6ddNclUYYO3RecRBVRUX
	WNcBBHa+ZNcNF8oQBVstyAYMtqDnGyTkawwaa1nqbYVXIQQFPk1DVZM/
X-Gm-Gg: ASbGncuj3lb8tgU7k4quFSRU/6ijyOUO/n0kmrm9D9h1gxuTMba51XZ1+exp3L9qCH4
	tOwbm0r+tD3aUVB6McXnHv9sm0CBZIxcSnSnRv5FD0mJKiBnn7tV8dDr4j7mHWrZO4drAY8LTbY
	FnUVjqas8rnCBSIBjdA1hDNUzawYkvejRsDuoyEK/h/rEsjE6i1dT139VI3i+BbYSvJASSGQQ9I
	hxjAotnmwMYPdfC5wobE0aH0fKbAGKaNBqMB+yJaSGHvaucdT1no3ovw5IkoTRFFHoHgHTRa7xF
	UIOr7xseSlE4TtJe9hLIvs+KgT3fgtZPmny56xlvKx0WCwyFL/EBwpN/LO74KEpzfjxKCEXFvfy
	JMT5NAdwHVOqOyUCvOa3PUPNuR/A0B4Y=
X-Google-Smtp-Source: AGHT+IFeOVs15dznIpdCf/M/7Af5SWFGR9Jd7+90ee4NmadJFomFWtlVJj00c3XSdaHZLu1bl73iYg==
X-Received: by 2002:a17:902:ecd1:b0:267:af07:6528 with SMTP id d9443c01a7336-269ba50848bmr68817665ad.35.1758332842235;
        Fri, 19 Sep 2025 18:47:22 -0700 (PDT)
Received: from archlinux ([191.193.70.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033c922sm65709455ad.131.2025.09.19.18.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 18:47:21 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: qcom: r0q: enable ufs storage
Date: Sat, 20 Sep 2025 01:46:37 +0000
Message-ID: <20250920014637.38175-6-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920014637.38175-1-ghatto404@gmail.com>
References: <20250920014637.38175-1-ghatto404@gmail.com>
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
 .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
index c088f1acf6ea..0a55ce952f93 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
@@ -146,6 +146,24 @@ vreg_l5b_0p88: ldo5 {
 			regulator-max-microvolt = <888000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
+
+		vreg_l6b_1p2: ldo6 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b_2p5: ldo7 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_1p2: ldo9 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
 	};
 
 	regulators-1 {
@@ -370,6 +388,27 @@ tsp_int_sleep: tsp_int_sleep_state {
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


