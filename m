Return-Path: <linux-kernel+bounces-745313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC328B11845
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6D6AA3B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F385328642F;
	Fri, 25 Jul 2025 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LsB8DfbZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YJxAjlOc"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290E12882D3;
	Fri, 25 Jul 2025 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424054; cv=none; b=UlG7zGXkiZIuIifKTr2IyyC5ymFJqrqhJIth8DKQX3UXnWdKbVjqBp1nX5uLnnBQIOMqcp5h+VazTffe6w4o28d6nIvp8j0a5pNnJ62EV47ylxeJjHUC4PmU5LVo5dzGp4h1T2WvWhh0aBPhRArv4jlng+5ewyCPwPyswe9hOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424054; c=relaxed/simple;
	bh=KtN5ZoOcJ6fSs3Qs+mXIR+tv0nQmfYqevwFtYxJrk5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn1jxu5aOUwhS5dyZs2M6EsfF2/cneaN6xWtmQy3dRLb/STbd0RvDlT4l0VFBC5gVAUPOPOh+baQK+E458Ji6fo0+pxdDsicsHW0JeaFxAmcpxt2GuxoAXQ3Juw9H+TVWOMn2rHhQBnfMlCThVpe+M3qe+9hBHZaBLnyyHSrxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LsB8DfbZ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=YJxAjlOc reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424052; x=1784960052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ECtHhyfFH38qadk/ISzZNL2Uf2YjTYogt8LaYtsMj5U=;
  b=LsB8DfbZZ9P5AfHSg2rdf9vuU/gDye+1FlhbhWPmNnF/aBkgIz3R3C/o
   nqPLYEZw3fk3YU2ibZp1GL/Fx3PLKsRkaL2PHOizWvTxrqLQnFKq1ZPPl
   u4IZljOBKNzIoi/N5wKTTUTrpeVioeCYC0OoKtMrQo5wnws+CddlzzLQC
   FFANf8gHHj0OTSGbWRn+5RFqdOs+TgRE4yptKeK5NyjEbYKsnuBFB4ANh
   Pb5MruZEpsP0bumLug4ygqdMn2ZBlg1tQ0bCpl7FSMH/jck56t8CkbpIu
   DnZrh37C1qv/QuQimpZQyiCUGxvw+RXkRpZrocXEPZ3gltxl82kje5ift
   g==;
X-CSE-ConnectionGUID: qMI5EVDpRGa/OG+Yv6VssQ==
X-CSE-MsgGUID: jJs88hQRQPiPS4/rlM/jNw==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413025"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:14:11 +0200
X-CheckPoint: {688320B3-D-8CC3CD70-C1DBF452}
X-MAIL-CPID: 12D093B559C5BFF32E5EC7CAF067975C_1
X-Control-Analysis: str=0001.0A00211B.6883205D.0085,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7D6C173650;
	Fri, 25 Jul 2025 08:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECtHhyfFH38qadk/ISzZNL2Uf2YjTYogt8LaYtsMj5U=;
	b=YJxAjlOcigYq6HBSUfNW7fIqzJ81IdrkUUlopPbe7AXfIx8J8M4SD0Eu00bs8xBA1MOKUA
	Cfl1mmGrVrqIWhwZKWtV40AEUYR8hpdrTs6jOsjtcigCaJFBbkrGSe4D+tr/KneG/IZBpn
	YSUUrIo5PbAco+sieXIlwDPR7bbhZOPHaHtKZS4vhIjIz5hJyrkvF4EgNVAVDweChtbbD/
	LkTJviEhuztY3NFTQ4/Wwtgv87ssk4m64s8jxy2s9NzDFD9P7scxGhrv0XhQlLYOo+L6iO
	alJdSwUBl7mAtYhsmJ/7Zb0VliIB/cfEh64zt84s5az61Va4zMpxh5zXMcwQ9A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] ARM: dts: ls1021a: Add reg property to enet nodes
Date: Fri, 25 Jul 2025 08:13:30 +0200
Message-ID: <20250725061339.266125-6-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
References: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add missing reg property to enet nodes. This fixes the dtbs_check warning:
  Warning (unit_address_vs_reg): /soc/ethernet@2d10000:  node has a unit name, but no reg or ranges property

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 2c39981bb94ed..2f4c0e468952c 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -707,6 +707,7 @@ ptp_clock@2d10e00 {
 
 		enet0: ethernet@2d10000 {
 			compatible = "fsl,etsec2";
+			reg = <0x0 0x2d10000 0x0 0x5000>;
 			device_type = "network";
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -737,6 +738,7 @@ queue-group@2d14000  {
 
 		enet1: ethernet@2d50000 {
 			compatible = "fsl,etsec2";
+			reg = <0x0 0x2d50000 0x0 0x5000>;
 			device_type = "network";
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -766,6 +768,7 @@ queue-group@2d54000  {
 
 		enet2: ethernet@2d90000 {
 			compatible = "fsl,etsec2";
+			reg = <0x0 0x2d90000 0x0 0x5000>;
 			device_type = "network";
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.43.0


