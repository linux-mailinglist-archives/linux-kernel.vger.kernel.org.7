Return-Path: <linux-kernel+bounces-825665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79637B8C742
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D042E5681FC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE7A2FF650;
	Sat, 20 Sep 2025 11:57:13 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE062FF666;
	Sat, 20 Sep 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758369433; cv=none; b=eMScbM+l4SZ47W/DvFPGXE/VACURIjMiCGUhdZh/kjZRvuBSsGvaRVFFLTeoJmf0vFkr+ezY/K8cFGxjcIyGx6f+fp+okZxCw540FFP3WHZMQ9A80N35m0MQkyO6CJj3HOZIH5piBD8dzba2tTsD/aEYtpVOACov2U2EQbJJk/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758369433; c=relaxed/simple;
	bh=2KnCjXC3CVIsTvTz/hDj3/Y5zzZ1+k8keBuZoFyLON4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAXUSGk4W9zF+2r80cQIzgUb4g1hJoH1km5K93nN1o47Ss4oNdU/C/EMNLYyLuSB4gMxWAllIzn0SiOznXRy7L1yNmr2YyTT/WXQTT96vamk1bIPpYgIPSz3vIGvUsxNZCVjY+L8iFyu3SHxX1KpC3EuRJInUMcqeNl1Vru7Q3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uzwDF-000000000XJ-3xao;
	Sat, 20 Sep 2025 11:57:10 +0000
Date: Sat, 20 Sep 2025 12:57:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 4/4] arm64: dts: mediatek: mt7988a: add 'soc-uuid' cell to
 efuse
Message-ID: <2c205246baddde49c66fd918c46e5125b395d083.1758369130.git.daniel@makrotopia.org>
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

The efuse of the MediaTek MT7988 contains a 16-byte unique identifier.
Add a 'soc-uuid' cell covering those 16 bytes to the nvmem defininition
of the efuse to allow easy access from userspace, eg. to generate a
persistent random MAC address on boards like the BananaPi R4 which
doesn't have any factory-assigned addresses.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 366203a72d6d..93c9f8c3f223 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -714,6 +714,10 @@ efuse@11f50000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			soc-uuid@140 {
+				reg = <0x140 0x10>;
+			};
+
 			lvts_calibration: calib@918 {
 				reg = <0x918 0x28>;
 			};
-- 
2.51.0

