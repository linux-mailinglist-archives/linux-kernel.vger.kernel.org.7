Return-Path: <linux-kernel+bounces-800267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B3AB43592
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A605C4E1CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A62C17B4;
	Thu,  4 Sep 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mDH9tCP1"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87862C0F8E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974145; cv=none; b=fVDdu6qEdZJy+gKANMV677lJADnii/8wKFhYYtW0LYgJBiKXaALIAP8N0rq+22fzMCnVFeRFywQaGIJLev/7NlbYgJgxijnPFG4WHb47bsSPSaxTWbF+p9LUw4QsGn54F5TyKdej5mpGCweYjSKaBDe/MzvCttkg4V/vowEbfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974145; c=relaxed/simple;
	bh=j52eytz6DDCr237AMHJnxt2rdA8Mje4M9BnX5BtLcMY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GcezDR4IyMrdjL5V/EuKySipj3YuVLSJmg0Y6aK78rFrD5kjgVuBIu4RNhHhCAdxeU74gsbqYimCCGDOXG/ieKCQwH/7xS+afqlUteEG+DnXMoLwA1jh7dh0xGDnGdr2LOqSvh9H7eoADRJXYuahPuVvDel0vLp+YjIkgjmiy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mDH9tCP1; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5848Lvbx3427807;
	Thu, 4 Sep 2025 03:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756974117;
	bh=TChUC5Tq/D6zfPNycygW1QaBaGRjl+5qqzikrlhBGFk=;
	h=From:To:Subject:Date;
	b=mDH9tCP1CNvjDK4XrckMN3CUz1wb0xpoVeI0NyX5GqpN0Ji2C+iAwe4ebGNZkwC2g
	 fKrEsNdz8I7MGI52jlNq28PQrCOKsqNKoFKo0RgEUw1KKqG3V4OXZMc4vPvPQLFrWg
	 +xIOS5EQZEDYXmkiLZmuxh0f07RztUqD2z52BpIc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5848LuxY730615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 03:21:56 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 03:21:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 03:21:56 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5848LpgE2963848;
	Thu, 4 Sep 2025 03:21:52 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <devarsht@ti.com>,
        <tomi.valkeinen@ideasonboard.com>, <aradhya.bhatia@linux.dev>,
        <u.kleine-koenig@baylibre.com>, <mripard@kernel.org>,
        <sakari.ailus@linux.intel.com>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <s-jain1@ti.com>
Subject: [PATCH RESEND 0/3] Fix and optimize cadence DPHY driver
Date: Thu, 4 Sep 2025 13:51:48 +0530
Message-ID: <20250904082151.2929189-1-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series optimizes the cadence dphy driver by below improvements:
- Fixes PLL lockup and O_CMN_READY timeout by moving the polling
function after common state machine gets enabled. Also fix the
calibration wait time to optimize the polling time.
- Enable support for data lane rates between 80-160 Mbps,
enables lower resolutions like 640x480 at 60Hz.

Series is a combination of below 2 series, rebased on top of next-20250901:
- https://lore.kernel.org/all/20250704125915.1224738-1-devarsht@ti.com/
- https://lore.kernel.org/all/20250807052002.717807-1-h-shenoy@ti.com/

Devarsh Thakkar (2):
  phy: cadence: cdns-dphy: Fix PLL lock and O_CMN_READY polling
  phy: cadence: cdns-dphy: Update calibration wait time for startup
    state machine

Harikrishna Shenoy (1):
  drivers: phy: cadence: cdns-dphy: Enable lower resolutions in dphy

 drivers/phy/cadence/cdns-dphy.c | 130 ++++++++++++++++++++++++--------
 1 file changed, 97 insertions(+), 33 deletions(-)

-- 
2.34.1


