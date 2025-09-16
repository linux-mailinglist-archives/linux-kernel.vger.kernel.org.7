Return-Path: <linux-kernel+bounces-819721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A38B7C8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCFE3BB5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C192ECD28;
	Tue, 16 Sep 2025 23:05:31 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7B222566;
	Tue, 16 Sep 2025 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063931; cv=none; b=AjUYn0jBLm2vktQRPuehOnIQFE1AxpYTvfc02Hs5KW0mkK0elFOiOMDnaOjP6lMcOLTMMX4wdnUe4P+6rgrXgHtdoc5Ge64uh6sIytga9wPifsehfEMANLCyoSf5Kh/uGr2/3kYAPhqVBZJH75myDchPZqYAOJQhm8sX4mPHq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063931; c=relaxed/simple;
	bh=E11vRVanrbPZOHDYHCLqP+pfjAfhhZu+rg2iHmEWg/M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNkQ0Z51gvYWC4BOljfme027N2sMLHap3lMrDouXZLsXUlgn9JpCDOhz/VLSJ4Gx4GPDElz8adG0meZBB3HhXH8kv/WT1bfqTxpH3p37IPgpW8lgt8pZUZBvsPdZoMTkwMQ+Zn9GerXsdej0E4nHegJTt9teV8WxhOiIrYBRupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uyejn-000000005va-3sor;
	Tue, 16 Sep 2025 23:05:28 +0000
Date: Wed, 17 Sep 2025 00:05:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/4] arm64: dts: mediatek: mt7986a: add 'serial' cell to efuse
Message-ID: <689dad6ea05479b520100bd6ec92dfa7a541ec4d.1758063737.git.daniel@makrotopia.org>
References: <18af6977cc34de75e64279141dee69dcbc81c420.1758063737.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18af6977cc34de75e64279141dee69dcbc81c420.1758063737.git.daniel@makrotopia.org>

The efuse of the MediaTek MT7986 contains an 8-byte unique identifier.
Add a 'serial' cell covering those 8 bytes to the nvmem defininition of
the efuse to allow easy access from userspace, eg. to generate a
persistent random MAC address on boards like the BananaPi R3 which
doesn't have any factory-assigned addresses.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index a8972330a7b8..0823eb586ec6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -450,6 +450,10 @@ efuse: efuse@11d00000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			serial@140 {
+				reg = <0x140 0x8>;
+			};
+
 			thermal_calibration: calib@274 {
 				reg = <0x274 0xc>;
 			};
-- 
2.51.0

