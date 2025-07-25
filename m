Return-Path: <linux-kernel+bounces-745364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD426B118F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838967BB3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D3293468;
	Fri, 25 Jul 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="nkcWA0Z/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AcJJ5dDK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1319228FFC6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427530; cv=none; b=WK1u2Hq21ZiTg2Cf1WHas9K2+whcGhrTYsEQ7+8tSnATEdN0dAtuzEdPjO+/3JTg6WnbZFNSe2okj4/MC/l4rq0wrhtjsepxN09KaHsqfgmXczuKBdmwXVtng8gwsOTxfgqCsQxXN7UuA3aPBnm39JsSsYyK4X345b4sTTCRwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427530; c=relaxed/simple;
	bh=nLv0NrN13eHTUekWqBUy1R8AkGgnV/tXRLJ2V6lkWbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmXqCMimTXqinZzAvWf8+nlOOUej2IXxEUm03AFb5OB5Ovbuqsrst23UtMoRvxEDZ2sZTlZdqhnJbrLwapUqX8v34Z4DWJa2Mn7dP56pnQf03dHBxYzBwpQqTicTUxvIcgqLBVQ6N+wTrLIgpnaH/42r5pqoy+pOMHrI6GuyP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=nkcWA0Z/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AcJJ5dDK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753427528; x=1784963528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GrXdUoo3RbvjWrVbpwGB5q/E3xwWtlH9v1ztr3x3IzI=;
  b=nkcWA0Z/9Z1OSEbfIftsGVW/xKFXi3CNL+5b7Vtxximlid7DoMZ/twp/
   BqMF0EB/RTcxOAnrxikaHWQatu7cNq48gCIMvYnK1KnYPfN6ddkUnK3Oy
   F+eCKxIcX26A2j/Oa5iDjpeLkUw6fumkdUInXpsOao5R1eqkinxfHrrZ8
   dC7/3VCmHiLBpn8EqQCptI+IBSuNBtHNCXY7BbSuypnrMOF6NMp6DWyGu
   /v3f86M3D4FZLm61FyMkP0fHTJdLmIPuRpai1KameWepPOMr/+CFKggTG
   gEYSfD8N5Dv38Kuvq/JNX5AJDMhp7F+Mr3Peqx6vWixvf55J+Ls3sbIWb
   g==;
X-CSE-ConnectionGUID: PUeZ/PeBTLKcFpfSm1NfZg==
X-CSE-MsgGUID: n1srBmqRTDaoZdnB3XGiiQ==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45414804"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 09:12:05 +0200
X-CheckPoint: {68832E45-29-BB1FFBB0-EB2CC75E}
X-MAIL-CPID: E56E1AE4A9F556D2E0DAF917D46174D4_2
X-Control-Analysis: str=0001.0A002116.68832E74.0030,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF7E01736DC;
	Fri, 25 Jul 2025 09:12:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753427521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GrXdUoo3RbvjWrVbpwGB5q/E3xwWtlH9v1ztr3x3IzI=;
	b=AcJJ5dDK/MkVv8P4tMR3e1nS725P5GBzgXIrHgCdiTw+JAgSTtWW/c27rcx0kH6wScZxG+
	7yCuo/fU6l/3ZhX909b/fozd722BPEAj2yOSKqEfEb8f0JGx2pqW31HLoKiCMnYncWN4lM
	Gv1tT1FO6r7W1RIBsJioNpaQQurVGfeKhndbch2isc8YKCp/pv0/F/H00Id7hmvlPpw5Qa
	yXy9vg7kUchDgiBZVaSx/G5ZfE73v0T77hUL8J44FsMoWonj8Z7l90c+WdrN+eFzZA78dW
	l3GHTtRPyId0s5xWQ4MFERa+zVKHlhz3xsMjz8fsj5rQwpoODINZe6WgHGy5jw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] mfd: stmpe-spi: Add missing MODULE_LICENSE
Date: Fri, 25 Jul 2025 09:11:49 +0200
Message-ID: <20250725071153.338912-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725071153.338912-1-alexander.stein@ew.tq-group.com>
References: <20250725071153.338912-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This driver is licensed GPL-2.0-only, so add the corresponding module flag.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mfd/stmpe-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index 7fee64102cae7..dea31efface6e 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -145,3 +145,4 @@ module_spi_driver(stmpe_spi_driver);
 
 MODULE_DESCRIPTION("STMPE MFD SPI Interface Driver");
 MODULE_AUTHOR("Viresh Kumar <vireshk@kernel.org>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


