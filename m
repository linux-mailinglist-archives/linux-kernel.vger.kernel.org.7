Return-Path: <linux-kernel+bounces-745312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD530B11842
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18365AA479C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FD22882A9;
	Fri, 25 Jul 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="qL0ByG41";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DC1LDDxK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F2287512;
	Fri, 25 Jul 2025 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424049; cv=none; b=TvvMsYKEzxKzWt0Sf02Y1HW+RTjElOmcl417OBQhCBhYYSE5RYre18AsFmK2DiaYsMVyfM5ceZ17lITuAI/15qC5pHO1adICHiOPZ/wU2w/qZHNCBZf5H+grMNOke8AAWcSZzzuGh5N+cJRhQayCARXb1TAGYedGdeoDMtvTPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424049; c=relaxed/simple;
	bh=yi4eUCH50hqGP19WAiFcgkqWN0McvvDP1KRyGe0yel8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALwDt+z/gdPGwlDJI59t5a+aILmnBr9b8IY5Yn5aUrXi5spb5fabtqpJmu4SIeNShMg/1KOdGqLl2TluIAuqKJsi+RgT1raGa6hnj1Zn/nuIOUmVP5VnPUco4dK2yBzoQ1IheN00n/GCinI+kV1W0v9BGQBP/1+qNP2wYE/VO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=qL0ByG41; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=DC1LDDxK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424047; x=1784960047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8XSyraYs35D0+y1/ijk+T4yWpudMHNIOuixWwtG9nEw=;
  b=qL0ByG41LGe19qAjA50kHtMiN/+dA/WlJfwaVneIn6SLaoEqz4L0hgGu
   bxvG4Q2rmiLHC0ZsithT0qB3fFngb/KeJy70JMv1ViCbRJPAFpmZUp0/7
   jBX7OwsTgN01dAKPeMB4IkWFzrg3Re01u3vQ6JHjoLwqNp5W7E+ntxFoy
   rGx1NXrALUoaFo+MC1OjSWmue9GBikwHbNJIubIUZJ5C5fQXc2LLf8sFG
   quUG6vdCN7MqeibuurQ5hqIyzG/xdQOQxzn274IhnEfZPWaP0sDYk8+YZ
   sSrekexM/8o6TNw/YOTbUCGsf/qLogGaTzvf+zBH5VDtMF6PXjLxvvCXL
   Q==;
X-CSE-ConnectionGUID: diKDlX/GR3S/6+w76OVNzw==
X-CSE-MsgGUID: R5bMwt1tQmmOYMZADQgPoQ==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413021"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:14:06 +0200
X-CheckPoint: {688320AE-B-943DFC15-D71A48EE}
X-MAIL-CPID: 122BD96570BF616A4CFE28D8AE1AE920_5
X-Control-Analysis: str=0001.0A002103.688320CE.001E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9120173644;
	Fri, 25 Jul 2025 08:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XSyraYs35D0+y1/ijk+T4yWpudMHNIOuixWwtG9nEw=;
	b=DC1LDDxKENfFn5Dg4IpPxIDJFAmt/NQuaZcaMJIvj+t14Hty0lcvD5lbh+vBEqwDZbq6wT
	KFyVqI3qBf5/ARLs6q6xUM5KpZFX9MKOApF2DWdB0NLYFL0apq7k0h9821QWePZf5hFwHr
	BOeOa4O44W11Uwi0BFntZCaoXLhMwIcohSFooE8tjSIP3C/idIpTjAAsREl1iWNGFzPw7e
	WB28+HH7oqO4ZzzQ760DWG192x6piViH7CWVjMzYHXD/OhP7LlaNyK7cDJ22V8hNcckQfc
	orFwiK8hf3mA+tpQL+1bNtw4nufmuInCcuZ5UrNe7L8NsAK/N5FYmTW9TjRu1A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] ARM: dts: ls1021a: Fix FTM node
Date: Fri, 25 Jul 2025 08:13:29 +0200
Message-ID: <20250725061339.266125-5-alexander.stein@ew.tq-group.com>
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

RTC nodes are supposed to be named rtc@. Also remove reg-names which is
neither used nor specified.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 2351374c2e107..2c39981bb94ed 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -944,10 +944,9 @@ rcpm: power-controller@1ee2140 {
 			#power-domain-cells = <0>;
 		};
 
-		ftm_alarm0: timer0@29d0000 {
+		ftm_alarm0: rtc@29d0000 {
 			compatible = "fsl,ls1021a-ftm-alarm";
 			reg = <0x0 0x29d0000 0x0 0x10000>;
-			reg-names = "ftm";
 			fsl,rcpm-wakeup = <&rcpm 0x0 0x20000000>;
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			big-endian;
-- 
2.43.0


