Return-Path: <linux-kernel+bounces-745316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12362B11850
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0211CE258D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8143283FE5;
	Fri, 25 Jul 2025 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="fhKdUTw0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PPZLW9WC"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C612853E3;
	Fri, 25 Jul 2025 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424092; cv=none; b=le+y3+XSK4RMEe70JV4iOLM3CHeOZp4pLPejJZMuQ60Wzk5F7Qbbf+P1SWSvvWiFbKS+IJHaa5XBnyoGInAmhTvrS7fVZhKxONex9YXysA0xoYq2Ii7SvFEYULT3QmkLzFNjZF7qnHrNIkUDQKnwfm90TsX6vmVNug1X6dZBipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424092; c=relaxed/simple;
	bh=iFu0SpSEfkP/CuvokU3tS4w31XIXGBm04xCECoCDi8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUe/Gx+Cb52nWn3pVRXXG64bKC4iZsPPHVIi0tMtv5ibkG4GgurCyPjMTvOKDEYFXs+wR5J0E90UwAg/FAUv7fxZQhw1/FTVMU/vwPjKt0Ux192M6gPKUF0LO5skciuimqI7fVfa4ZV8xEqCWc1GKzkDkHhxqzcV9k4aQQow+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=fhKdUTw0; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=PPZLW9WC reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424090; x=1784960090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CxJ8svvO++lwqiGfnRQsUVlvsvUpsD2cA8gkdWdUYHk=;
  b=fhKdUTw0wyIqxg7Vj0opGomyko8IVtzqvZGnyOMDGFmOoSATQdDJut1w
   pv5ak+6KVMbmkHlcmi03MjNj5/Hzavg7hM8ykN2ri65ItQVmcnIpGrpEe
   r24Z5G75r1oN5G+FYNpA49KvIjW4LscjQrxesEOT/VDEg3mkuIROqr+Fh
   TBcc1MioKORDg7i1TbbQA8TI52av5qHUDmsZ7YayHIO1WBZQyqcCVKfd1
   2aSK9FMDRvpIivu+luc+8P5iPKGNdiLycoGaEcfCpDyNcaQIsSf8lN9ED
   lHVRW0v8gEGJlMYJRsiaykN5S62GjyTXdlX8irnIEn1G5gmv3zBtxCb+w
   w==;
X-CSE-ConnectionGUID: c6Zya/w8RyanKZQEpvl8XA==
X-CSE-MsgGUID: lobUtPqRQXyh2mmX6V+53A==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413066"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:14:25 +0200
X-CheckPoint: {688320C1-23-BB1FFBB0-EB2CC75E}
X-MAIL-CPID: 532422985F7306734FDA00AB5C8892EC_2
X-Control-Analysis: str=0001.0A002110.6883207C.0030,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 377ED173653;
	Fri, 25 Jul 2025 08:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxJ8svvO++lwqiGfnRQsUVlvsvUpsD2cA8gkdWdUYHk=;
	b=PPZLW9WCqXyqd5/239u4YWQcP1hQ5877JtkflTQbZFl+QTi+5Rj01qhejTCaTU31S+E5AY
	JQ8q2dj9GsgsiwDimq1Eo+g6Q7tDF43BNHYD17NwTjCIRfxCg0v6+QEhR0DH4fS8/9HcIp
	+mHwUpeorS2L8oZppTeAPZcPS/KkIsu25hKvDkI+mjAa2cvy+VKN7DGoASRAazpd7funLa
	Y6QQl+I7Sn4QWQ4yrIEKG0rrx3MhPIHU1C6pKaYbt5WwKKzrnuAwlza13Ur0+86tJcvWNI
	Vyoy+KKuluoivZrVKtfvCmygOtuD9uhVwJNKQ1IdUEg0LGL1qVAtO3pwC3CCKA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] ARM: dts: ls1021a: Fix watchdog node
Date: Fri, 25 Jul 2025 08:13:33 +0200
Message-ID: <20250725061339.266125-9-alexander.stein@ew.tq-group.com>
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

There is a dedicated compatible for ls1021a. Using it also fixes the
warning regarding big-endian:

arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dtb: watchdog@2ad0000 (fsl,imx21-wdt): big-endian: False schema does not allow True

Also remove clock-names which is neither used nor specified.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 9c9044ce7bc65..3879cfc3efc99 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -610,11 +610,10 @@ pwm7: pwm@2a40000 {
 		};
 
 		wdog0: watchdog@2ad0000 {
-			compatible = "fsl,imx21-wdt";
+			compatible = "fsl,ls1021a-wdt", "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
-			clock-names = "wdog-en";
 			big-endian;
 		};
 
-- 
2.43.0


