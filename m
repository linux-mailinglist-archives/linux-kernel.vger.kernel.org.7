Return-Path: <linux-kernel+bounces-815400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FC0B563D0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 01:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC65317BF6F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917512C325F;
	Sat, 13 Sep 2025 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="rOlazBxW"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207052C21C3
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807856; cv=none; b=Ujq9vltCoFqFKZ5WZ0pdnFRdld7R2GFuwx/HjjN9/QnxZ95ZxYyizj5DnKpyd9ati9GrRGltlf4Y7Q0vo9lze3iXzwJtW45a5E0ojUpVQxkf2AP4jRVzRrs87JiMpoPrVlY4d/5G7bxxXSkF/AGBOtZBd7MJI7HnDpgRn1D+DYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807856; c=relaxed/simple;
	bh=zmma5ZyznCoFv1BGo3vCpkPTLSA/o6N66qSei64L5J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FCD/qOjNL0U37XQADs065UymCI+1kb0UKFjrLcoJd445BxfaRt+JjiFWJdSMrNPkSu1CBwTsO2YGfeatQ5KL62CnctAD64xtuEwrJLPXvvMlm4h8Um7CoGYb3ZQKAO8B36vamlDgpv50Jaht4eSTgsLIVwFhxJ4DhyyZiWrUbd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=rOlazBxW; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757807853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJqw6SDjbDy3X9NSIUDPeCA61OwgLB3XFxUHhOnFRTc=;
	b=rOlazBxWr3ohQ2y9aBI9Y1ULg2ET7P0Fish31SpkmDAjTfaODsh4hUCsTOfM41w7uZlYWn
	7hhy1PstaIRPnjDtsPh5cu36ltvUpSJL9K0XWIfh6OGRY/1WC2z2I5OV3x6BUXbl0yeeN6
	uFhAdROKtaGCuiGqcXOIPhGoatSZwDjJhmLeRjUQBfNHXgOGxBt28dV0/DGuVpJVvA47A9
	qHAJ+y1w+AU95FIkPAOAnbeKr48clnl+MbgA3Ucg7KDgY+lXL8FjUDxzuqmpA+/8RgkVhi
	l9KqNzjDU0yjP55hAysME6bRfJ7Rsh0VEpzTcDkeCg+V9EUwjqAZ5wKe8TI/zg==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Sat, 13 Sep 2025 16:56:37 -0700
Subject: [PATCH 04/11] arm64: dts: qcom: sdm845-lg-common: Add camera flash
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-judyln-dts-v1-4-23b4b7790dce@postmarketos.org>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
In-Reply-To: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>, 
 Christopher Brown <crispybrown@gmail.com>, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757807839; l=1067;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=zmma5ZyznCoFv1BGo3vCpkPTLSA/o6N66qSei64L5J0=;
 b=o4hpI3YyhR/dcAmfgOOi/wIjWgFJr3NzwWs/rNlwdfaGleURem70jKNHySLv9HoYVsWwl5sC8
 Cnjdkqs1RJdBTGNsHD8K9ujeTcdhzGnVqRiojtuaqmcKK04NBFTKe2J
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT

Add the camera flash so it can be used as a flashlight

Co-authored-by: Amir Dahan <system64fumo@protonmail.com>
Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index d6129ce03f537f0c8c78c2ae5f39be6146cab7dc..df826bca2bef5e3f85cf49708020a47b8d6bd8bb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -604,6 +604,20 @@ vol_up_pin_a: vol-up-active-state {
 	};
 };
 
+&pmi8998_flash {
+	status = "okay";
+
+	led-0 {
+		label = "flash";
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
+		led-sources = <1>;
+		led-max-microamp = <850000>;
+		flash-max-microamp = <850000>;
+		flash-max-timeout-us = <500000>;
+	};
+};
+
 &pmi8998_lpg {
 	status = "okay";
 

-- 
2.51.0


