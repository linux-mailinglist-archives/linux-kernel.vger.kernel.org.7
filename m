Return-Path: <linux-kernel+bounces-819829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43936B7FA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A411C0477D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C93D27F000;
	Wed, 17 Sep 2025 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="kqJEeHY8"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE427380A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071463; cv=none; b=T7ZFMofIowcwlqSSu5hV2Tq4RV5DNS+hEDPWtuns7xpoiT/PRbTsWig6VYUIN5jLrMwEyMO2MhglUg9N75FqQdvnyPO8qlHyE1VJ6Ae/FpGXOor5558neUa61rHVEayQyJ1/BmGUXShr0e5ouP0O8648lm59KywCzoRsij1iVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071463; c=relaxed/simple;
	bh=OFsQLAzvDH+YgX2aC8uYRsCBuZ/GAGaUNDIa2FQpXXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/vB8s+/IR9s5ODoRcjWToz/XVv1pa3pVDXKbjsd1XoihygdHksNvogHk6+6Rz7ET3mf5o1gtdB/MbVdoN0U8IXjx7/Gz9bGMFKy00JU6IQvGTaxkCKBb5jkkRK877i7ELNfgA6FoABvbJ3jjZYnhbwm8EOeBQpBypWyNN+KRv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=kqJEeHY8; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1758071460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hf4siRsM7TZ48o2oJStRJGK+Gn25EiSe6vFdh5a6xk=;
	b=kqJEeHY8172iqigbQ+GlW8n+obQksZM3o5p5Je+tdGsR7yt2iPjTzUQ4APHejV1zFTl+18
	LXUcN0OmNfvQqFND4M4gsREPCYmvbbLU2uxMNDxm+sUJT5pll940Yz5ulxLatwsJ/Nqxys
	G6RjZ9o9zPFBL/kyNJzcMe40No4p9bYwV+QQeCSidqgCoEf5W6wF9i7+G8GtXyiZfMUVLS
	x0zihs32p2+MxFY6a8Vcq7Esiap7JrbdPwgFHUTduNXd0q1zwiXef4V90IQVayJlFbfQJA
	5Xmcqgt6oDU5akUKqZYSLYBdzPyKMbYFejoF36hUaYIFtdqQrK+h1t4EmDtZ0g==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Tue, 16 Sep 2025 18:09:53 -0700
Subject: [PATCH v2 07/13] arm64: dts: qcom: sdm845-lg-{common, judyln}: Add
 wifi node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-judyln-dts-v2-7-5e16e60263af@postmarketos.org>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
In-Reply-To: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Amir Dahan <system64fumo@protonmail.com>, 
 Christopher Brown <crispybrown@gmail.com>, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758071415; l=1441;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=OFsQLAzvDH+YgX2aC8uYRsCBuZ/GAGaUNDIa2FQpXXY=;
 b=PmOM4AfppYlJ9OZJlsvQSTkqxlH4KSCqu2miLz2s2yZ0/LXQsgGSuIR7K+8K/Yr9VLJvLMOnD
 xYn9YdraByGCAk1Hio1yFfch2lqfNeWdghtSjXcWDIoY1EiktWPMTXf
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT

Wi-Fi now works with this patch and relevant firmware

Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts  |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 44a76e047c8faf71959ebf9a5b278e1f66000087..01ac32ae8728558741d5d47fdd00219b349f225c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -678,3 +678,15 @@ &uart9 {
 &venus {
 	status = "okay";
 };
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
+
+	qcom,snoc-host-cap-skip-quirk;
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
index 7d05698f1225d951804752b6fc062c1b4f583516..e84b45ed82fd13850ea7ec1f34ddac5b59fc1434 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
@@ -164,3 +164,7 @@ bluetooth {
 &venus {
 	firmware-name = "qcom/sdm845/LG/judyln/venus.mbn";
 };
+
+&wifi {
+	qcom,calibration-variant = "lg_judyln";
+};

-- 
2.51.0


