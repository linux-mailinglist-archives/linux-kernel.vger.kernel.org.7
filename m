Return-Path: <linux-kernel+bounces-850561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39054BD32EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C56E3C6A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE262FDC3C;
	Mon, 13 Oct 2025 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="pi7OzHtW"
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242862EC568
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361654; cv=none; b=KOIQCdvhTVkX4QLEJ9wuUM2/JFxK116WhIH5hMNhnnPZuOOCPed5h8G7XrhpZsLN4lChrlrPBwP9VDGsp98al36/nJcF/hyXP+rMkLMiISdIp6qeupmNac+JSDKp6HUf26I9+4JK5pIzX4X65IDVFPNLj1ZGZDugK9lmhGx0fwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361654; c=relaxed/simple;
	bh=TbzYZZ1HCYFgSXQCe6OEhHip5E+AXjykF95JWPhySJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mqyb97vnWSxROs03KuAKrKz+V5HuFAPjCq6RYc9qnpjorVj1wIfkN/wBOf+pb1KFEvu5vWbsL6BxvF/KVDrWAOmWZRYCHasyDxt1r9uJL2ncaEnKtyZqiKB+jJBKknvGFTPN1V0dnavCQU8X7GqdWWbrI4Bb/zvmcN2azEnUo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=pi7OzHtW; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Go6dZDillkE7ZYEa8i+61rrCqPsVJA3sA1UCW5TWE8w=; b=pi7OzHtWaoPTtUbxjGhS4RJQSb
	mf20QGptUwt7hzhoRvxnW9/CRC5cnAMX4etuBKdCVgsr2Vw1Hz/Q9U79r6p2TxLH9TDge88Wewe+m
	hx0k4cZbdBi+GuHdnrHSl4bjVeTO4l1uXuAg+iXGngnb7JZKfGAGIoipKBoWMW3a1Hl4deuwu/VX+
	pTMgydDbFtqZxfR/jYxlUPmcVthGt9XTH5GgrlIEoq/aTUSdWTCyH3FoujIYxC54uSE+XtVXBNeKG
	Kn0KSJeeq80896B21Zp/6/QkoSdfeV8CUbQtyrnKwzelg1yT1MVOqAlVUwgoaSB38osjzssrKX7NC
	hn5s1Qfg==;
Received: from [122.175.9.182] (port=32887 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v8ITn-00000004Tvv-2UOs;
	Mon, 13 Oct 2025 09:20:48 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: linux@armlinux.org.uk,
	ardb@kernel.org,
	ebiggers@kernel.org,
	krzysztof.kozlowski@linaro.org,
	claudiu.beznea@tuxon.dev,
	arnd@arndb.de,
	geert+renesas@glider.be,
	tiwai@suse.de,
	lumag@kernel.org,
	kory.maincent@bootlin.com,
	parvathi@couthit.com,
	kuninori.morimoto.gx@renesas.com,
	Ryan.Wanner@microchip.com,
	andre.draszik@linaro.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	twoerner@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	danishanwar@ti.com,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com,
	pmohan@couthit.com,
	basharath@couthit.com
Subject: [PATCH] arm: multi_v7_defconfig: Enable TI_PRUSS and TI_PRUETH kernel modules
Date: Mon, 13 Oct 2025 18:50:25 +0530
Message-ID: <20251013132025.1436138-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

The Programmable Real-time Unit and Industrial Communication Subsystem
Megabit (ICSSM) is a microcontroller subsystem in TI SoCs such as
AM57x, AM437x, and AM335x. It provides real-time processing
capabilities for industrial communication and custom peripheral interfaces.

Currently, IDKs based on AM57x, AM437x, and AM335x use the ICSSM driver
for PRU Ethernet functionality.

This patch enables TI_PRUSS and TI_PRUETH as kernel modules for AM57x,
AM437x and AM335x SoCs.

Reviewed-by: Mohan Reddy Putluru <pmohan@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 12f706e2ded5..7f1fa9dd88c9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -281,6 +281,8 @@ CONFIG_TI_CPSW_SWITCHDEV=y
 CONFIG_TI_CPTS=y
 CONFIG_TI_KEYSTONE_NETCP=y
 CONFIG_TI_KEYSTONE_NETCP_ETHSS=y
+CONFIG_TI_PRUSS=m
+CONFIG_TI_PRUETH=m
 CONFIG_XILINX_EMACLITE=y
 CONFIG_SFP=m
 CONFIG_BROADCOM_PHY=y
-- 
2.43.0


