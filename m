Return-Path: <linux-kernel+bounces-849764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E9BD0D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 00:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879B43B7E44
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ACC23956E;
	Sun, 12 Oct 2025 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="O+Uv3TnQ"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026D1547E7
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760309261; cv=none; b=MF3n6sDwEG6dwdABHLdt31RLSjZiUEAID2zNGkVFkujCexILSqtoxPS5TW7n5RuvfngBlteaRJF7faeQJbuLD+YImEID6EkjSFBjG5W21xYmlcc5oyMkvXpeNlAppL8z0usGN5hU5Ds+I/UlzzHeYgUdq3XEiwoSVqXrdiARbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760309261; c=relaxed/simple;
	bh=EyPG3Fi950uiyAJD5Mohk3oQRg/ePz+PGzh3DjGatOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYmzNXmxZMMMSqCwlWwOoHroKVKPZ6D+5N+gjGJU2LKyyFX/FI84DXpYNm6ByYpuZwxKjr28XVkNcu6rX8ZWSGbihHNjDl455g1YHz3xcLHBwYoa/GmK0JSBtUxMn+24g3jMgjtW6fw+OtnfHHmMsBGUIcY2ZZQFyjauTD+VQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=O+Uv3TnQ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1760309256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bcjVnsy37RIrdVgMtxg7YSO76T0MhxQKRy53qIOEJRA=;
	b=O+Uv3TnQt7MwbJw+HsFtOncgRcYm6qsFe0yqil7KNbWr9PGWi75Rv0zeAspofP8jhunsPn
	UftV6XtJ1pWqgCl5uybdT5CXQEo14ua4rD2TWUie2DD9x3Z1VNQZKvOfaxjDMdgKf1Tdxq
	v/jYRdNO/AOV/UvP0Z8KtZe3VxZjINEVfHvg5KRNX8n0RZyFP3YmLcI6xDisZ9iuR3HHPj
	jp9sAqs7OVp0EqXbA+/ThVVjtgYzFBfnbdEX7meYjmTTXFASaFIy8Ps3IX8j/GcglX/Lcs
	Ypd5wt1IPfgm3i3dhSVx6eImdSSPORjI9UP0y9kHHnTCnZp+od9QZGHIvZ6GSw==
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
Subject: [PATCH v2] arm64: dts: qcom: x1-dell-thena: Add missing pinctrl for eDP HPD
Date: Sun, 12 Oct 2025 19:40:08 -0300
Message-ID: <20251012224706.14311-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit a41d23142d87 ("arm64: dts: qcom: x1e80100-dell-xps13-9345:
Add missing pinctrl for eDP HPD") has applied this change to a very
similar machine, so apply it here too.

This allows us not to rely on the boot firmware to set up the pinctrl
for the eDP HPD line of the internal display.

Fixes: e7733b42111c ("arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Val Packett <val@packett.cool>
---
v2: fixed commit msg style, pulled R-b
v1: https://lore.kernel.org/all/20250927032330.21091-1-val@packett.cool/
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


