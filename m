Return-Path: <linux-kernel+bounces-857993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EDDBE879F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9123919A7A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8636C2DE713;
	Fri, 17 Oct 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vAIba2Mx"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2962D9EDF;
	Fri, 17 Oct 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702068; cv=none; b=cN5L1lGLuU+2d6JKptIdjb9s8xnIELbnhe17ifY6PA12FSwYPwcbNJakzK9Evf6S7x58e+/a4NuO9ROfpXSuPFSgfSxpBwE8vxoI3eYSWb212/fQLdp8Bq2h/k0W8eKaWRGG2ogJAv5KDRF8alXTtOHqf2ByrljKB0KSZMMOydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702068; c=relaxed/simple;
	bh=pKkvE0lTyouIBYb6MvO2iIGZkpnvNriQd6pmUEwXrwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDPRgKOeDMj3ZQImKO6jbKlor4lzbLD9OORW+UH3yX674LXr/ZIWaR295aKo80i05tOExsqUhc6V83gqfCtRQcs8T0dP2Zh3Ypejy4aGUlnJHZlA+NKt8CXlGMgx/ogWb75diyQBtuoQhh8FCKr88LT2nEO6iw5F6zdDDtTkLKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.helo=fllvem-ot03.ext.ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vAIba2Mx; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=fllvem-ot03.ext.ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59HBriZG261157;
	Fri, 17 Oct 2025 06:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760702024;
	bh=pKkvE0lTyouIBYb6MvO2iIGZkpnvNriQd6pmUEwXrwg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vAIba2MxY6mudbrJ2TycPRcm5AIukIhEkh22CaUfrMmbE0Cg+N1T1+qGu8qnGIhbM
	 L45M0Hb9Rlq2wj4sExUcpaK4+esD3hyExsFywzjgC0ENXarCbv4rpGm8rA/ld08+Vu
	 uuvqbThRxDfcUceo6qv66i0kZ9V3vrdobSkpQDp4=
Received: from DFLE209.ent.ti.com (dfle209.ent.ti.com [10.64.6.67])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59HBritK1974019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Oct 2025 06:53:44 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 06:53:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 06:53:44 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59HBrPeA1246573;
	Fri, 17 Oct 2025 06:53:38 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <nm@ti.com>, <tomi.valkeinen@ideasonboard.com>, <robh@kernel.org>,
        <jyri.sarha@iki.fi>, <aradhya.bhatia@linux.dev>, <airlied@gmail.com>,
        <conor+dt@kernel.org>, <h-shenoy@ti.com>, <kristo@kernel.org>,
        <krzk+dt@kernel.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <simona@ffwll.ch>, <tzimmermann@suse.de>
CC: <devarsht@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <s-jain1@ti.com>
Subject: [PATCH 2/2] arm64: defconfig: Enable ILITEK ILI21X & ILI25X family of touch sensors
Date: Fri, 17 Oct 2025 17:23:25 +0530
Message-ID: <20251017115325.1942591-3-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017115325.1942591-1-s-jain1@ti.com>
References: <20251017115325.1942591-1-s-jain1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Microtips Technology USA's LVDS Panel MF-101HIEBCAF0[1] uses
ILITEK 2511 capacitative touch sensor to provide touch features on the
display. This panel is used with TI's AM62-SK EVMs.

Enable ILITEK ILI21X touch sensors.

[1]: https://www.ti.com/tool/SK-LCD1

Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9379cb230f6d..dea15cd20828 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -472,6 +472,7 @@ CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_GOODIX=m
 CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI=m
+CONFIG_TOUCHSCREEN_ILI210X=m
 CONFIG_TOUCHSCREEN_ELAN=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y

