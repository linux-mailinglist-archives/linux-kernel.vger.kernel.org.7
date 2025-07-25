Return-Path: <linux-kernel+bounces-745310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF05B1183D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5197AE15AC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEF0283FDD;
	Fri, 25 Jul 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jm5GxMFx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="s+onBUaC"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15601285C9A;
	Fri, 25 Jul 2025 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424040; cv=none; b=bL1FBeq3Px52HY+GswDuI+65yYyfJG1HihcQN8jDW51ufU3fE1WgfXKpo9mL5RbE3sb4NZ41FJEjgZYApChOfGzPJHfMyEsH5hRUcu4HUZoUlPOpGr/OW0bw3NYiqRIP5Wt4mr6ghVDy4KlMIBFGOTqnjEcY6FQ+kcugC1W7Bf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424040; c=relaxed/simple;
	bh=m+POR/CCLHfrFzceE/6jtLx7qiVB4DDvvs/jKjxM5Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdqWO40R8N/jcFHejEi2fx/kuFeupHVOgCZZYJoK1+UzP3zs0ZHUouuCIx5yIFM1czgJNQN249/8UcOJ9J+eptFkuSFAhVzqs8kaYj/FwYcfIjhF7Y1gwUsF8Wa30bFcCaPd0OL0X/fXdom89PCncurWgmNXQlE/vfcM7UGOLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jm5GxMFx; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=s+onBUaC reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424038; x=1784960038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2dourJm0SDZjHfoLji84guhHFN2WHfzi10bttqrIUWw=;
  b=jm5GxMFxm8hDYkonK+Q0jlvMaKoSpbmiiwoZ+jEL26mG+Igi9jq8lBQA
   o19Ey1/CwbHkygBFonCdg4DeCK7CLYd8TUTaTmsdFgFkiTQiriuex5bBk
   3oMP6uPbnWq34tEYMkgrFoZgZ7BU7dgp7+wWuLM3HN1Zu5BVK1pbmVfe0
   9RaMMEEljgTZHYzZk2qbPcjOctkdX0yhtRUZ7n7brMGX+KISv2IKNBCI9
   xc2UT3z2AoeiQXUhXMVGnUq8nwHrAUDlZDccgml6EEiufIo9ItLRiC1DD
   C50Rtpj2yQIH9ndQKwSUIg9MYqCWHCY8Cjfl9pLeSM8lvTMv3f5NVVoMc
   g==;
X-CSE-ConnectionGUID: niInC5YdTJSXO2exHXj9Nw==
X-CSE-MsgGUID: V3W8PETgRYGK+aPO+qcvpg==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413016"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:13:56 +0200
X-CheckPoint: {688320A4-2F-8CC3CD70-C1DBF452}
X-MAIL-CPID: 99CAF7C9F1E8294BD57271360C0A0B97_1
X-Control-Analysis: str=0001.0A00211A.688320CB.005E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2243D1735FC;
	Fri, 25 Jul 2025 08:13:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dourJm0SDZjHfoLji84guhHFN2WHfzi10bttqrIUWw=;
	b=s+onBUaCIAiV+fa8r+WH8r6MLg2ZglZ2NZRT4xxC6D8YbQBFclIYNRGYPypmEWIKhauTzW
	Co7NHGpyE7wx0gPoSkKWWLsAyuAx90lFpcZqQH5hGJ7DRRSFqfpsFL0PO6GVjnOqMH8Djo
	eFKk+cysuw2Bcl79hDZOb8MGO6/bqeZ3l81ZjtrJKoAVo8xivuLzVw3JFtqBHnQ608YCGI
	hyCuAV95gMxRmpA193B6tuuPOkIg6ZflVowZeGXxaliLPFAJIoR4MbgchXvHnQ14N45wwQ
	IpWWTRUnp/QwRmGFm2jpnCCaj8ifPtdJAFGZPLWi0A5Ms74zCALYQYOWX6VMsw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] ARM: dts: ls1021a: Fix qspi node unit address
Date: Fri, 25 Jul 2025 08:13:27 +0200
Message-ID: <20250725061339.266125-3-alexander.stein@ew.tq-group.com>
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

0x8390000 is reserved memory, but 0x8380000 is the QSPI base address
in RM. But register have offset of 0x8000, so first 'reg' entry address
is used for node unit address.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index fb44c76bf1d17..74c5698e0b314 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -917,7 +917,7 @@ ocram2: sram@10010000 {
 			ranges = <0x0 0x0 0x10010000 0x10000>;
 		};
 
-		qdma: dma-controller@8390000 {
+		qdma: dma-controller@8388000 {
 			compatible = "fsl,ls1021a-qdma";
 			reg = <0x0 0x8388000 0x0 0x1000>, /* Controller regs */
 			      <0x0 0x8389000 0x0 0x1000>, /* Status regs */
-- 
2.43.0


