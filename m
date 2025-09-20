Return-Path: <linux-kernel+bounces-825664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3DB8C73F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFBD7C34C2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9500B3002D2;
	Sat, 20 Sep 2025 11:57:05 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24C2FE561;
	Sat, 20 Sep 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758369425; cv=none; b=ToCQO0ShxQFy2UzI7SZkw5f0LPPO8yxJIdvnmXhKLza00emV294K9DKE+5aLo1x2u0DbQZ1sjyCr97fyTQNq05c+AP68RHZ3xRhfJvEXZ5B9XpreihwMphrsOBOZ5gs7/zwcTCfGWl1aIYN1Ziory3MwrT/ekD+wgPiFHWT6UKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758369425; c=relaxed/simple;
	bh=fSwN0JvpQGBXo6LtCSKmbftyrmZ3mGOA/obvjR85jFg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u04yYKgk73JUHk2Qm9yKpCO+0Z9FrG0zuWgSRVhggxaAN/lHEH6hMn0s/YTQMD5EMVyuiGwOlINQ2bwGmXv2tvJJAjIKTZ2qHLPnxEbfpFhFbIMaNxy47rgyPNbi/j7JjPs0Drpjcd+9J2dEOFJ9fl6CD+4dMeUomFc3+Qvff9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uzwD8-000000000X1-06us;
	Sat, 20 Sep 2025 11:57:02 +0000
Date: Sat, 20 Sep 2025 12:56:59 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/4] arm64: dts: mediatek: mt7981b: add 'soc-uuid' cell to
 efuse
Message-ID: <36886630b6f5eac7e9ecd3d9f59db0ed076342d0.1758369130.git.daniel@makrotopia.org>
References: <40004650c99c09ff540d8e2028a1393f4a70a6b4.1758369130.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40004650c99c09ff540d8e2028a1393f4a70a6b4.1758369130.git.daniel@makrotopia.org>

The efuse of the MediaTek MT7981 contains a 16-byte unique identifier.
Add a 'soc-uuid' cell covering those 16 bytes to the nvmem defininition
of the efuse to allow easy access from userspace, eg. to generate a
persistent random MAC address on boards which don't have any
factory-assigned addresses.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 277c11247c13..25c164114213 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -237,6 +237,10 @@ efuse@11f20000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			soc-uuid@140 {
+				reg = <0x140 0x10>;
+			};
+
 			thermal_calibration: thermal-calib@274 {
 				reg = <0x274 0xc>;
 			};
-- 
2.51.0

