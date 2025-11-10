Return-Path: <linux-kernel+bounces-892923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7543DC4622D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5331894AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AEE306B11;
	Mon, 10 Nov 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v5NT8ZbH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BAD3093D8;
	Mon, 10 Nov 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772877; cv=none; b=S6dCTNb5SfDjhyKPUQc44hIDW81iIlcdt+768/UNuPziModdHrO78dz15kfr1yZH8pnUHdRdYjMgXjDL4jhNt73go5iakcG5BBdeSsdACcLEwNSm463gdku7Ap2Cgf7ctr/tTL9AB89Nju9+wWnQrTgo3okw9LPNEIAyFIJWr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772877; c=relaxed/simple;
	bh=nY54tNQZRNsA3ET/r8aV0I4+8hBiMJ/ai9gOGg/UTzU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AEbQumPxyz+GvQ2EotDjsLsutUGR0swsV5bePej5sEfo/8E8+HH72i8/ZZWJ3Y5Bny5in3tNQdpB+R6Xfczb3gPnCOFRe/W218IV/wx1M3sL7snaXm3unS/q+bW10TH/kHatDRDWbEf9NJlJzfxTESO/yCe5MqHH8X1jPuH69jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=v5NT8ZbH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762772876; x=1794308876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nY54tNQZRNsA3ET/r8aV0I4+8hBiMJ/ai9gOGg/UTzU=;
  b=v5NT8ZbHiTwkADXnbBIsVY9EXUeZwCuByMtbpf1urXMKfnWLqNoiC7+U
   jMwUoLiLyKPA/cIn18CswYHgEoYT4WBfhQhcQ/z9styjrbOHQjanxM48v
   jMBMebT4qM6hhPWjdAYs49gbxD6ZG25AIlJgRuIh9Huj/tUbGXTGWV3jS
   0X+zfG1FT/HhK1A23gQS6wHcVQ1Pzr4/jEMQe2Ng4bHxVOoRza0OvTzWz
   h9pl+EEmJbxMXtM1lBDzWAEd3ov7kFc1wfEYIjJ5LBDUuG0qACIOPeMuh
   XuMGPRdR9aGY3uxU/NFleye9C59vQiACcGtIrBvjnp6jndnL8cjNOBGMR
   w==;
X-CSE-ConnectionGUID: KW7TDCp/S/GQVmM2i4LhMg==
X-CSE-MsgGUID: Y0myGoTVSLqXvgm5ru5XdA==
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="55314299"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:07:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 10 Nov 2025 04:07:24 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 10 Nov 2025 04:07:22 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 0/2] phy: microchip: lan966x: Allow to invert N and P signals
Date: Mon, 10 Nov 2025 12:05:34 +0100
Message-ID: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Allow to invert the N and P signals of the Serdes for both RX and TX. This
is used to allow the board designer to trace more easily the signals.

Horatiu Vultur (2):
  phy: microchip: lan966x: Add support for inverting the rx/tx lanes
  dt-bindings: phy: lan966x: Add optional microchip,sx-tx/rx-inverted

 .../phy/microchip,lan966x-serdes.yaml         | 24 +++++++++++++++++++
 drivers/phy/microchip/lan966x_serdes.c        | 23 ++++++++++++++++++
 2 files changed, 47 insertions(+)

-- 
2.34.1


