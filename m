Return-Path: <linux-kernel+bounces-834794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A4BA58A1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D370F327039
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA481EF363;
	Sat, 27 Sep 2025 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="mmhgJzqy"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7731C5D44
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758943432; cv=none; b=cz6P3pom8dJTMaD34kRdz4aEuSpckxfFyhREIdhtoPXRlq0O20GDmTH1Pjlu38psGE22kJw+l/GeZhK8qov3qONsPz05ooPc0kTaaoPl/DuCsPzFovtqTO+V1PHFxKi1BECDlmFvls9p+rCJHWtyIaP+0ZUryqwapJMlncjcHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758943432; c=relaxed/simple;
	bh=v5Of1WnnlV7oFnYN2QV8iTQcbKA+d52aP+wpVbpWsY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEkzBlFu7L9KFdm3IHAzDLfM3XD1MBx2m88wTVoRBiT6K+9o/MV4WZrfrCBoYJUbTqeyOerLVugnU9lDq1ZEKyUQ5czE1q1kEYE0fk5UqSBkuhQST7uSkbawQ88OIgejVRznWlnKpUEPrf8mqMj9QWEVjZh508SRqBJ60K8lmKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=mmhgJzqy; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1758943428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f+8LlnH0TKHHjBCrQtgQIF074phimjZRaWIoKgEy4zk=;
	b=mmhgJzqy1w/x9ty6O2QcRX3a92odsrS4BFe3tmmj4k8epPsMLOHQkHQP9+vd7qKUFg1LYf
	moPyd+AlSrt1rt585f9NHEK5l+ebxhsd+iujnWbzQw9RZmaSb/Ih5VaEX1tuZ0gZkRgQcl
	4gNLHzf0DtF4+dKqz18sTDnwSPG90HLvTelHsQYNMfftgaXPBWJnBIOgfoqITbaOXBkew4
	CJQ+z9kvx+tWGsqQLvce4V/2cz7YA7loIm9qN/4ZgpHtZiO7N9zOjBci27/hbEtDmb/ZMd
	sLePnuPm9m8vRFvr9eds7ljW9Prt2ZtZKjJISf6gh2uyLleAGezDQWWgsnwakw==
From: Val Packett <val@packett.cool>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Val Packett <val@packett.cool>,
	Laurentiu Tudor <laurentiu.tudor1@dell.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: x1-dell-thena: Add missing pinctrl for eDP HPD
Date: Sat, 27 Sep 2025 00:23:19 -0300
Message-ID: <20250927032330.21091-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Match the change for the XPS 13 (a41d2314) as the board is identical
between the XPS and the Latitude/Inspiron.

This allows us not to rely on the boot firmware to set up the pinctrl
for the eDP HPD line of the internal display.

Fixes: e7733b42111c ("arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455")
Signed-off-by: Val Packett <val@packett.cool>
---
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
index ef83e87e1b7a..0aad80a1159c 100644
--- a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
@@ -1104,6 +1104,9 @@ &mdss_dp1_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp0_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {
-- 
2.51.0


