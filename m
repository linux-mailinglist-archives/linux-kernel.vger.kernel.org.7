Return-Path: <linux-kernel+bounces-818196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1948B58E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0331B24757
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972DC2DE714;
	Tue, 16 Sep 2025 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="VVj2sbGN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AG+nWoDZ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF882DCF62;
	Tue, 16 Sep 2025 05:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001906; cv=none; b=AR8becQnYkKoJzcOiEHUOKZGP6NSaLz03cuM5tXcYzr3y2POK0kXKN+BkevlILl5CBMDox5uEuB5dybSW8LkUo8BMvFeNzdNAptidHoQozwO1yy7AkSy5rmJRpT6MIwFrnmlVbWkCCqNnETpydmBxDH0ieffDQ9BAQ4IyU7qbVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001906; c=relaxed/simple;
	bh=WUGAi70PXBeJRCBddUZ0SRPuJjxG5ZxaG5bUha55cnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eH3r1ILqtTbLkihruXZRFsaLe+IS2LKFUn8O2CBzxSzC7wnwtKizMfVhIF3vv45XQXkZjnHGY+9iF6adsZlTfuGq4uoB1C/XSuW7ASqWONUpVxDyFQPJbjstFT3h5FP2VbkLn52K7oEMV3hrkAoEKo2aGmyqYnhyPlu8J7iGC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=VVj2sbGN; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AG+nWoDZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1758001904; x=1789537904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zf0rlUPIS9TkW6EtEY94PGkcqdgP6qxZVUo3leDvhyo=;
  b=VVj2sbGNazim4jDJDR2637cVTKfCoCraMAHg6DDRVajLuURlOexdb2s9
   vilmtYjugIkE5iSgCmuBlqchEtwUhp3nYNeFhhqdiQ03rEN/5Zi4EOB4j
   4rKiDh6yNvarc+H460anVx26Iy4ENxhUUWbu+lSAPTTpHdYtQyHOw1EqM
   0a5LsMYNSfAuRWH4YWJPV/cKpQmINLihit9WTaBdPrNYuBHtS3bca2Soq
   hz55ayNwaarkYc+vlmopolipmKgTJMcXL/M3uF0TbErHIQNJeTNWimyDV
   GDp6MAJsjCHaRrLxA2II94eSgOl2QsxtP19Wct4Mm7/lwZXKO/ymW8JLr
   A==;
X-CSE-ConnectionGUID: GqKwsJ/FSj2dNT/lNi7LJw==
X-CSE-MsgGUID: j/DEDTUjTNW4Hmviq9tODw==
X-IronPort-AV: E=Sophos;i="6.18,268,1751234400"; 
   d="scan'208";a="46161273"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Sep 2025 07:51:35 +0200
X-CheckPoint: {68C8FAE6-59-C678C473-E36DAEF9}
X-MAIL-CPID: DCEDB426389384B9BB85DC10A71F1436_5
X-Control-Analysis: str=0001.0A2D035C.68C8FAE7.0083,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB3F4166CD5;
	Tue, 16 Sep 2025 07:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1758001890; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Zf0rlUPIS9TkW6EtEY94PGkcqdgP6qxZVUo3leDvhyo=;
	b=AG+nWoDZtUHcldDs2EaC7re+Y5WymxigPUzfof2xilIK7b7VtyoBCTJM6vzrLJTFuGmG1j
	f3TvgG0BZABcRmP6vRphn9u3knvBmifL1FIVJkqBfbEHKQysW8uxagI7E9GqDCj9pYWzs8
	AecoUa+/QjoM/apFDbQbxZUVUhgnI98ZxvTgXuUJXLp+S6L3mlxA5ZM1mRVD49BHFI78VJ
	vYoMfVKYLanruLB7s3m2OeQGhCpDqTqPvZ1xeP8OmuTn/ToIT8mpxJdYvix8gqRdxxIgOP
	Qcqv0PVJYhSbYOODS1di7CG4OO6ndVtXhsiI9XgD0tLi39lqrI3RignDAu16Ww==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] arm64: dts: tqma8mpql-mba8mpxl: Add MicIn routing
Date: Tue, 16 Sep 2025 07:51:18 +0200
Message-ID: <20250916055119.135637-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

MicIn is connected to IN3_L. Add routing including the Mic Bias.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Rebased to next-20250912
* Removed dependency from local patches

 .../arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
index 4eedd00d83b9f..59642a8a2c445 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
@@ -238,6 +238,13 @@ sound {
 		audio-asrc = <&easrc>;
 		audio-cpu = <&sai3>;
 		audio-codec = <&tlv320aic3x04>;
+		audio-routing =
+			"IN3_L", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"IN1_L", "Line In Jack",
+			"IN1_R", "Line In Jack",
+			"Line Out Jack", "LOL",
+			"Line Out Jack", "LOR";
 	};
 
 	thermal-zones {
-- 
2.43.0


