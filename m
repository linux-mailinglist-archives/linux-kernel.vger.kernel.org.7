Return-Path: <linux-kernel+bounces-825662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604CFB8C736
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9CAA7B0636
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41782FFDF4;
	Sat, 20 Sep 2025 11:56:57 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACEE2FFDC6;
	Sat, 20 Sep 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758369417; cv=none; b=sC7Xx0kebRITUFV8IFlYZVHMhXHuNdNhukfskHxScaH+U7/6ctvsIPqy1YtIzyN51k7E5zpvbappTKqFuI9zJHgWrNuZyUpUyEiFIEi9PASrN7lssh0/S+o6RrBinZ/tdrYcGJknpu2QIvwDqClQy1MikuuaeNlJQmYdNTsrFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758369417; c=relaxed/simple;
	bh=lc4fHPX+tkSU3GyokhPfKx/frzAYQgakGom8aHZ1Dfo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLbs9ynm3FNcOc1sX+13egZ+A5IogeBjIH1+8sNp1FbBsSWbR6sw3ncSDeq57yNBKYlMrQsAynbn++fEC1SiWdxo5RPuUu3bWL4UrRLLjO7DxkY1K5XpOu0zA5EPxmsV0fgRu+K4wkCkfY6Tn054v+8dBH52rc5PH92oH2XzEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uzwD0-000000000Wh-0qqz;
	Sat, 20 Sep 2025 11:56:54 +0000
Date: Sat, 20 Sep 2025 12:56:51 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/4] arm64: dts: mediatek: mt7986a: add 'soc-uuid' cell to
 efuse
Message-ID: <fe0b2ea1f0d8081c703459f5e42392ac9f45cd80.1758369130.git.daniel@makrotopia.org>
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

The efuse of the MediaTek MT7986 contains an 8-byte unique identifier.
Add a 'soc-uuid' cell covering those 8 bytes to the nvmem defininition
of the efuse to allow easy access from userspace, eg. to generate a
persistent random MAC address on boards like the BananaPi R3 which
doesn't have any factory-assigned addresses.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index a8972330a7b8..7790601586cc 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -450,6 +450,10 @@ efuse: efuse@11d00000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			soc-uuid@140 {
+				reg = <0x140 0x8>;
+			};
+
 			thermal_calibration: calib@274 {
 				reg = <0x274 0xc>;
 			};
-- 
2.51.0

