Return-Path: <linux-kernel+bounces-745318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC705B1185C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B841C20AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E472853E3;
	Fri, 25 Jul 2025 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aPPZdLTK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VxiPD51T"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3522874F6;
	Fri, 25 Jul 2025 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424095; cv=none; b=U9o58wxPl6deQ8ENRwzYcgFbC8lfRwAhNz20KEZlZ60xWyJOdPbbbIHNTqOCRSPIQ0T6v3hnOsBUXBSJUrDzDjsYqoGWeOpDHfaVjusW2kHc1Z2/hyTjAMV4RxDcxovcH703oLnZkL8RNpEk9+j/6/QNFj4xJvnm221QmikJ0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424095; c=relaxed/simple;
	bh=IBEHMlmvNvS2HelLPRea91hJuq0QkQseCc7mrW4Psug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p92jUpi7RZSgo1cS5FjEevHwFmnF/Y7/KU8/agoTTjGDFMgK6NNUtwZq33FJFQ6R0QAMsZlqC303szjXghep5lmiDbbjTnlutp5BCev617MJ3XKBzcPs02KcGh0ZkX8lUt0mbSbIRXz+L1Fw+rvg2R4PYGUgeUlNPhL9srWMKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=aPPZdLTK; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=VxiPD51T reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424093; x=1784960093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2M5zCaIWhbk8FXF6KTQw3rrtOvrfwFLiMBbwugEplvA=;
  b=aPPZdLTK5oskHGudMZNaPkhRPiOCztR9FShVJI35LfN4a0YrcYskXN5Z
   hPSW2ybsR5QGH+BuYfG2pUcxtkGSD/TXvawSdwPjK+MjdaYagV5pbOBLY
   YzxalHVHbFmKtjLQ8TiN4uRP+GVjHnK49nHcytY3/jL6aKoyogASiF7VB
   WOeVe/f7AR0v6O0D0VkO/ChIbjUjnqSI1zhR/mEJOpYyqoT1ZJujDnBQ9
   SOUw81p4sFhiIcqzI7o66ZN/vnVBNccAGAaqvMI710YXxwJONdJ2nKeyJ
   jY2sY8Vju8LH8bHKheQQYRG3lnDlps+PEd+G6xfLe2fNAMheb8jWlJIPe
   w==;
X-CSE-ConnectionGUID: vj0Xval+TU6L4E+KkYFKHQ==
X-CSE-MsgGUID: e0UYQv07Rr2IU+5AcuTbHg==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413070"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:14:35 +0200
X-CheckPoint: {688320CB-15-4FC15ADB-CD71293B}
X-MAIL-CPID: 7817297EFDE73460672EC898B02D0DEB_0
X-Control-Analysis: str=0001.0A002105.688320CC.000F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6552173655;
	Fri, 25 Jul 2025 08:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2M5zCaIWhbk8FXF6KTQw3rrtOvrfwFLiMBbwugEplvA=;
	b=VxiPD51TJoIhGqddFUk3rSN6Lk88z/vA/Zzm+qLUqzE3qOn9qqrX6NOJN2OMiatew+LAFm
	647oOsbU+HkUpShphEQkrc+/ib5sx6io/ufZvlpP3tMD4HtpJpTK4xJXhtXdaCwfrKsPrX
	iPLcYu3LUj8bWlyPAv6o2MJIUr5YaJ8EYS2z9lNb9xbqZJKNdgDGjjToQp6bL7+KGI5Bab
	h2ffTe8COXw0x5fSFMro3QDrvLgFW3jNOlyHO7SKzXXLb8blfAazY+BqKWp1XhXjHBeO1e
	TacC3iu5Qjm2TTvGB8+Ij0Z0/uf2Wi8x2n18+Kz9LG8zJ6PyNnM8f2qy/dYrJQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] ARM: dts: ls1021a: remove undocumented 'big-endian' for memory-controller node
Date: Fri, 25 Jul 2025 08:13:35 +0200
Message-ID: <20250725061339.266125-11-alexander.stein@ew.tq-group.com>
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

According to binding doc mmc/fsl,esdhc.yaml and driver
drivers/mmc/host/sdhci-of-esdhc.c, default is big-endian, should
use little-endian for little-endian system. Remove 'big-endian' to fix
below warning:

esdhc@1560000 (fsl,ls1021a-esdhc): Unevaluated properties are not allowed ('big-endian', 'bus-width' were unexpected)

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index d8a43c5aac80b..abb3e5ed7e027 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -161,7 +161,6 @@ esdhc: esdhc@1560000 {
 			clock-frequency = <0>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			bus-width = <4>;
 			status = "disabled";
 		};
-- 
2.43.0


