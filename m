Return-Path: <linux-kernel+bounces-745315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7F4B11848
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8190AC2909
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34C285404;
	Fri, 25 Jul 2025 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="q8IICe2G";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="m7w2JHxq"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBBE283FE5;
	Fri, 25 Jul 2025 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424089; cv=none; b=GjYNsKPWxqQ/VdCgIgJFyebwPLJxhFVpIGygsr2LvvNhKrY3DohVnhJl5VyohKz4Gk7O/SXMggbIy01D0rJEesh9OU1WdaLxEtzqY1wLxJlar2zMMnTbdCwgc7ExPkeD1EmNcapgJ19QzSPk5K+lK5uwFOWb0WJiOi2pB6VCaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424089; c=relaxed/simple;
	bh=Hs4YII2CATc6P5Vu2xmwBT0OXDnVtLSVbF9shGnIUD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yar9d7CHE8f7WRbJnPUbhaN/sWUQpL1yr43a2YVkw4XXuBG7VOG2dXk+E8LPi8/ECvJSzIqCj+cbogzXRAKICQAbk8OvxD5jvVArdRBGjWBGTgj5X9KVza9Fud1D0N0sLf0nHh7Xd/ePkrs5pV2XBLk0qs+PD6PEOpAvCtbKnWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=q8IICe2G; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=m7w2JHxq reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424087; x=1784960087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OFGBAdS+mixe9vk7NaiCL/hL2zPXjl2DzAJ2n+tbizI=;
  b=q8IICe2GC5KekDbURtOI7Xmous52YSAddHUZdG0XSnQt6oXWNITk5GrG
   0ZR0w94a2brKJy9PTJiMHGZx9Z+8Kc6Hs131+rpdlITOeR9UX6PfahsU2
   uo0Gp3vl0wVjdYJLxLjKVeE4sDI8Y6D6rDXN1ASNjCaHBuOcmsssGFr9O
   P+DOuxOW2jyzqa8XPpj49MvrXBOHTeH+0Hld003DmMSS65qjzZ1qKGyIU
   7eU31/Ge56nSJZbBR+cc3ccB5Gj64tbEqg0/XgxiJQ53PBUEm4jzzk2Pc
   bKUklwamoQkP79umeju1L5QOSDuCHEkor0wGrMQ+9HEetpSDhn97B6XZq
   w==;
X-CSE-ConnectionGUID: bzj7nb9TQAKxnKlZqZLnuA==
X-CSE-MsgGUID: exDXFFPNQHi60rSerMCF6Q==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413061"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:14:20 +0200
X-CheckPoint: {688320BC-3B-8CC3CD70-C1DBF452}
X-MAIL-CPID: A3594A0549AB77DAE7113CA3E525A7BE_1
X-Control-Analysis: str=0001.0A002116.688320EB.0034,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 661C2173652;
	Fri, 25 Jul 2025 08:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFGBAdS+mixe9vk7NaiCL/hL2zPXjl2DzAJ2n+tbizI=;
	b=m7w2JHxqYxn/oykfXDu4chZ4yORMelf6Aynzt+QVB98vD2uz5Y3puvLIs9g5nlCqZ4pMTX
	Ou+ivFdcYzh3uJVRRaPwg3tX4s5TfwvyqfV/xQibZ5XWz7Pa4N97KSm659MeRFa8oQW3rz
	GC8PinSNp99/R795NTVoKW74iGJ/E565dbNrIpGwF1WGdO3zSUkgmMJGGaScp3Ad7eN2Q2
	KrsjZ7vvs7AdhYX52mNLc2kEvXDooDUBzXspNvUGY4PfrpCLRIV0Xs9QuVO5lFeoEAuvcR
	ZAnH+tZD9Ro42gHMI8y9K/GFodKOcNBXIYxs5+hCz6wsMEbBAlBAAWcZezBkyA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] ARM: dts: ls1021a: remove undocumented 'big-endian' for memory-controller node
Date: Fri, 25 Jul 2025 08:13:32 +0200
Message-ID: <20250725061339.266125-8-alexander.stein@ew.tq-group.com>
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

According to binding doc memory-controllers/fsl/fsl,ddr.yaml
and driver drivers/edac/fsl_ddr_edac.c, default is big-endian, should
use little-endian for little-endian system. Remove 'big-endian' to fix
below warning:

arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dtb: memory-controller@1080000 (fsl,qoriq-memory-controller): 'big-endian' does not match any of the regexes: '^pinctrl-[0-9]+$'

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 3fbc3254d06a3..9c9044ce7bc65 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -93,7 +93,6 @@ ddr: memory-controller@1080000 {
 			compatible = "fsl,qoriq-memory-controller";
 			reg = <0x0 0x1080000 0x0 0x1000>;
 			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-			big-endian;
 		};
 
 		gic: interrupt-controller@1401000 {
-- 
2.43.0


