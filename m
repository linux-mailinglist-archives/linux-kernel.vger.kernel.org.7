Return-Path: <linux-kernel+bounces-840940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD834BB5C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 263704E4C1F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1E298CAB;
	Fri,  3 Oct 2025 01:59:09 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6E298CBE;
	Fri,  3 Oct 2025 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759456749; cv=none; b=fPEcC/rUb97lL04iqrWY1n1HTekPTkKNh6J4cUbhP66wtPg6B59s2gQjL6+u9NCOjNaVbTcJVehGP7wAN4EaPVNavn8YIsAX1VoUgGfkkOVRrlp7aC3BAHgPCP+lPsJBlm/gOOAw0jVof14Bd/YOZeNC6m16OxyV0CNPHrMjyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759456749; c=relaxed/simple;
	bh=l2HsWw6v1wU1PvEqjgPwF2DzOya8BJHGrccHk686C1I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2cTZ7tnGPS2r9n0YNohoQ6WDoz+S9jwmirSqj69i7jsOyw7MT6ImB28UkF2Tzc0ELFfa4kcWaRutG+PcHX7SA0+1Ux/ZKnf3EwuLUSMBtHOdSo/qfNplfrqua3nxRZ9xNGp78pVo1g9yMpn95bkYL4fUETd48eY1oZeAeis9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 3 Oct
 2025 09:58:45 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 3 Oct 2025 09:58:45 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] clk: aspeed: Add reset for HACE/VIDEO
Date: Fri, 3 Oct 2025 09:58:45 +0800
Message-ID: <20251003015845.2715538-3-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003015845.2715538-1-jammy_huang@aspeedtech.com>
References: <20251003015845.2715538-1-jammy_huang@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add mappings of reset per hw's definition.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/clk/clk-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index ff84191d0fe8..74c8c1377b70 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -278,6 +278,8 @@ static const u8 aspeed_resets[] = {
 	[ASPEED_RESET_PECI]	= 10,
 	[ASPEED_RESET_I2C]	=  2,
 	[ASPEED_RESET_AHB]	=  1,
+	[ASPEED_RESET_HACE]	=  4,
+	[ASPEED_RESET_VIDEO]	=  6,
 
 	/*
 	 * SCUD4 resets start at an offset to separate them from
-- 
2.25.1


