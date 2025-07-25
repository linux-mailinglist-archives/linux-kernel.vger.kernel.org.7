Return-Path: <linux-kernel+bounces-745319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D410B1185E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C28189FAE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8CA283FE5;
	Fri, 25 Jul 2025 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Gr5S8W2f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EXcgreaC"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078FDDA9;
	Fri, 25 Jul 2025 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424205; cv=none; b=ZTHVGoh4aQiPiQyGN/PCZuEXldO1ubOv7DAffvtCW94NjrTdX1SSZbbaHL1YdqTlc1ImveZ7tgglkK0SXOyzlAYa8o27x3TkIK1lyQA1u6GfN/l4H5GxXJP4McDNtQtzGZJtGzNbEJsYKV+GdXgPhZ9iW6T62wTb08s/KDCIWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424205; c=relaxed/simple;
	bh=B4wdDdOknFYIOahXNKei7CLoCcpWfH2LGYMPjvzMNYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDIzmoVJ2HtegZGIGpgw3KROVZBeYnOLfoJNnni3q5Jz89xGsQHhcu53+Pmn/fsiVOI8Lefgcjw+jaHHL/JY7rmp+sXruWLdXGj1nAdvUUP6DXd5IvD0XuFZJeNuEOxO+PbJz9PPRx26R5IgWuq0zHgNGM52YIfDDmo1h+jQQjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Gr5S8W2f; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EXcgreaC reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424203; x=1784960203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XM9iXBp8IqXzGuZRucgzJovFOCvW94kDLWRDrJTUflo=;
  b=Gr5S8W2flZl1HJqCj+ojKTalnPQLJY8UZHj8oixmYZfyEwd4Yz+zEG6K
   K+d6w50MbaOCTI/vdsDiANbyE1KeD/T1XKZMenK6pYVLN9zz6fRxStPuX
   x7TiY/NSHa3q+iq8itUK6GwMEBwP5jQ7UkkpRVqBzdBarH3PHDUk965/7
   N2kLyCpq9oOZiO9f12WcuGLoOsW76aUOnQkQ6cf/x+k1JAV3nTnKP+ABy
   4hmwXlbPgypdBTn0lPoeNomlHWOFzFVU4hmSBtfbxYNPihlWR68IFmwTq
   FlhLGnVjmx76Hrvo1IMn2kyndN1pHtBuMXEWAvR0jjZcZxqpMxkOb+mjM
   g==;
X-CSE-ConnectionGUID: W9UZgxk6Tm6SRkqx9pYAOQ==
X-CSE-MsgGUID: FVqbObs7Sc2VCHCIJs/FcA==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413149"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:16:40 +0200
X-CheckPoint: {68832148-19-943DFC15-D71A48EE}
X-MAIL-CPID: 2331C9402F859EDB0778B4294738099F_5
X-Control-Analysis: str=0001.0A002111.68832144.00B0,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1201173655;
	Fri, 25 Jul 2025 08:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XM9iXBp8IqXzGuZRucgzJovFOCvW94kDLWRDrJTUflo=;
	b=EXcgreaCubRwd2R3HaVwbNxUdzvj8RJM5l+/rjZ9LKz2tE5RwO6R4V2ZQn+d7oYt+i0FPb
	a5+7HXQBpGthjRgVkvcvmxiHQlSOD/4FhXsgtJTA6KUo6Ug5+oLtWEGQC/JC9XCY4AkIBt
	BegzVl38hWRXJGM4LVp7QfveDtRnk28fohwY3174c4oK9IXakTuyiXn8gQFyP2eTFpqpdo
	Fbd7o4IBIRSbPJmda3B743sRiav+VkDagGUuffrH8LefE/zsZVGEMZKP42upXi7pANIeho
	4QeQuqoGme4WvM2spv/Snbnxyn7cCwGpYZOdWowJPIqa/fuLQu6uUcMuBsaz2Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: ls1021a-tqmals1021a: Remove superfluous address and size cells for qflash
Date: Fri, 25 Jul 2025 08:16:31 +0200
Message-ID: <20250725061633.267174-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The jedec SPI-NOR flash node itself has no partitions, but the partitions
subnode.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi
index 271001eb5ad7f..167559521ae10 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi
@@ -66,8 +66,6 @@ &qspi {
 
 	qflash0: flash@0 {
 		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <4>;
-- 
2.43.0


