Return-Path: <linux-kernel+bounces-783329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147CDB32BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 21:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9E2A06B2C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5172EA46D;
	Sat, 23 Aug 2025 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lXrTgQr6"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22661FDE09
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977914; cv=none; b=pRF6YoN8pBYzrsPWbo20S4It2L+/WPb5ok27iyzm0WIXaOwkv8rlmMX+ACMKUG9VyUk4BEpcq5yhv/OAgcVnoANdxefZBtPLUF9DTwkXhAOVGY0teHplKqsAIxzY+6Esm/LSpDsUahi07fd8b4ydPPsnbaFN1OiRzeJO9kEH7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977914; c=relaxed/simple;
	bh=9H5EWBk4yVKoWb98oK8R5kJWtyTvHlhBWPggxu4SXn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSa8seei9d/Z2ClHwTVQp4czdnGfXcqTGASmHLJmSIIdh+gyhK+7ti1LUb4E5asQdm/IiKrGFijs0slVjfbLP3WPOM6ladc3+jWGNd6osMRq//jnbfg1kYrUjVI8URcl9/r5Ur4Xa1SJ1vwC2U++I1lgFBBH2iAnlmvgPP+t+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lXrTgQr6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so2737080b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755977911; x=1756582711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFoZeto/FDI3HbNA3+yLmKkVSsUZjUZFotfhVBL12vM=;
        b=lXrTgQr6JhIISSPI/TtVrVlmguy8BHG8uXDzcqkFX6zsY7Al1UgdklHiI/03eLuwGn
         3i2EvUT5VPG/86ibT1WOjbVGpfzQa1NLHc9hRxz6+sd85PFNF6FU0QMi9Ibzkb4Lqj4O
         8etasAsGJzw5sinGD11CFVSH+HfTD8L3/N7jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755977911; x=1756582711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFoZeto/FDI3HbNA3+yLmKkVSsUZjUZFotfhVBL12vM=;
        b=CmSXoirM6mtup4V94A+dbPVBqTxuWm7VHHsCrS4vlfgDTnTsQExZC+hltU8T/5cMzY
         dAORkLIJzaWejYvp/JGEKGn3GgPMbAGFR2ADzYjggOw2K/uWq4FvtM+8CvldwOG+VUhw
         WDiAP6oYJUtFBcdAhXpVONjSjiB+rGdtDfJy02tECNfZWT1yRfrjK8NP4uBZNuqB/8XI
         K2asYndg4LRXdCh0WFLTWiRAUTsmpCedY0GNuEmVvGr32io+tq5QSlnRyJ0aFjGfAW5S
         hzlpibmtjXML3xTSyq9zan57SnwYXIrmbXuR59Rcnh6PXc6cRzllggClpLsax95q2Tv1
         7T0A==
X-Forwarded-Encrypted: i=1; AJvYcCU7slBQtVG6pqSrKJmqAygxn7f2ZQu7YkjpmT+fUl4AjyAO226pZMsBkkOlEeHTJyezIH3f4Ww0+9palNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZNXkOwcQ7zFEzeQKROSYvfJAyAtObjn8+OVq1yAtOnnRhDI4
	Sq9jhXCPlzPqVtCEfHiW1ke7GF1r1rwfYQI4UtiXtbm/RxFs+5CBLZPWOgIogRqW5A==
X-Gm-Gg: ASbGncvnRgALAOKmhz976AxKcKqwjjaWwbBP6Q1LmXe6uYHQYZ73zTFkz9XA0jUF9hC
	48MslkL41LZLD/h77gLcopUIgHD6AibTMqOSF3R6IxIfu0r9idx17TnHkTFUjRWQPqJ8KIeFIAh
	gpNOBIQwl8kHv/znl5RJvZdBXEncjWv4vtjRX817mVnMDewZ5cicgW1v3XuCC8wufq3QLmEy89p
	5sac0ufwK2IzzEj9FBsHza2Y3sLWc450wd/7H4HejAcFNEh9htkOwvNdXdNpK6EcCD8rPMak60D
	Ra4Z3VCJgSbj6LmjOg6bqcXSzLKQNLgKXK+k31QChh+VMhWarlqe2lBmwxVv73QPWYMAH8wZWcY
	OIc6UMIoYCjoE0V/2kEEQd9JtcBaDU/Gt85h5Hpj+PBKKZb6V/fLgmBl7Pht3
X-Google-Smtp-Source: AGHT+IHZgEfPSgrzNcfJP0y8VFbZ/mI9XmL1DW5PZYFaB2PJIzNbSTWb31bEH3e4F4au31IY+qw7iw==
X-Received: by 2002:a05:6a20:258a:b0:23f:f729:2e72 with SMTP id adf61e73a8af0-24340b5832dmr8588883637.1.1755977911137;
        Sat, 23 Aug 2025 12:38:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:dde2:2ecc:d200:6390])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7704025ef80sm3093608b3a.108.2025.08.23.12.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 12:38:30 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH] arm64: dts: qcom: sc7280: Drop aggre{1,2}_noc QOS clocks on Herobrine
Date: Sat, 23 Aug 2025 12:37:18 -0700
Message-ID: <20250823123718.RFC.1.Idebf1d8bd8ff507462fef9dc1ff47e84c01e9b60@changeid>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since these two commits

  fbd908bb8bc0 ("interconnect: qcom: sc7280: enable QoS configuration")
  2b5004956aff ("arm64: dts: qcom: sc7280: Add clocks for QOS configuration")

Herobrine systems fail to boot due to crashes like the following:

[    0.243171] Kernel panic - not syncing: Asynchronous SError Interrupt
[    0.243173] CPU: 7 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0 #1 c5464041cff584ced692726af2c4400fa2bde1db
[    0.243178] Hardware name: Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+) (DT)
[    0.243180] Call trace:
[    0.243182]  dump_backtrace+0x104/0x128
[    0.243194]  show_stack+0x24/0x38
[    0.243202]  __dump_stack+0x28/0x38
[    0.243208]  dump_stack_lvl+0x28/0xb8
[    0.243211]  dump_stack+0x18/0x30
[    0.243215]  panic+0x134/0x340
[    0.243219]  nmi_panic+0x48/0x98
[    0.243227]  arm64_serror_panic+0x6c/0x80
[    0.243245]  arm64_is_fatal_ras_serror+0xd8/0xe0
[    0.243261]  do_serror+0x5c/0xa8
[    0.243265]  el1h_64_error_handler+0x34/0x48
[    0.243272]  el1h_64_error+0x7c/0x80
[    0.243285]  regmap_mmio_read+0x5c/0xc0
[    0.243289]  _regmap_bus_reg_read+0x78/0xf8
[    0.243296]  regmap_update_bits_base+0xec/0x3a8
[    0.243300]  qcom_icc_rpmh_probe+0x2d4/0x490
[    0.243308]  platform_probe+0xb4/0xe0
[...]

Specifically, they fail in qcom_icc_set_qos() when trying to write the
QoS settings for qhm_qup1. Several of the previous nodes (qhm_qspi,
qhm_qup0, ...) seem to configure without crashing.

I don't really know what's unique about Herobrine systems vs other
sc7280 systems that presumably work fine. I'd guess there's some
conflict with something configured by the boot firmware.

I'm submitting as an RFC just to get thoughts from people who hopefully
know better than me what might be going wrong here.

Fixes: fbd908bb8bc0 ("interconnect: qcom: sc7280: enable QoS configuration")
Fixes: 2b5004956aff ("arm64: dts: qcom: sc7280: Add clocks for QOS configuration")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 2ba4ea60cb14..59203ce58c61 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -394,6 +394,16 @@ &vreg_l2c_1p8 {
 
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
 
+/* QoS seems to have conflicts with boot firmware on these devices. */
+&aggre1_noc {
+	/delete-property/ clocks;
+};
+
+/* QoS seems to have conflicts with boot firmware on these devices. */
+&aggre2_noc {
+	/delete-property/ clocks;
+};
+
 &edp_panel {
 	/* Our board provides power to the qcard for the eDP panel. */
 	power-supply = <&vreg_edp_3p3>;
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


