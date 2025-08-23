Return-Path: <linux-kernel+bounces-783295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57948B32B6E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 20:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBF21C201BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228F23ABB6;
	Sat, 23 Aug 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="kgyTGKO8"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BE15530C;
	Sat, 23 Aug 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755972324; cv=pass; b=rQReJJIIjavwgIB8ucqj7H+qPnehgJEnEy/qYM0DMkil3p+/KKoLE8U+tgCyjLitPosaBFCJKxCXhQLWLtRSE2kfmo6wKib+45cAFo6cPPt3vMnkmQt5JuvGzb+xqapDyP8zKnxhf3hKTwocxsW5KCcJjatUc3hxR8vVmVN4Fqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755972324; c=relaxed/simple;
	bh=sP8xzC8rQXb6SvLfDNNMbxhKw9axuAu8AKk21SjR00U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7z+mzcNQgo87byUw7mC6bdHKB0/GHmLXwa45FZRH0gX/QrA8oca1nuGEkIZW4jA91BIMAK0IOn3IofDP5AmoC3GxmQHPnIMcW6ZKiIQWdPWTpmkAYL2shSdkkz3yYTBYNzhHAb+j7EL1B5w85UoaLD6IrbIRGR2j4r6DySS9X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=kgyTGKO8; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1755972294; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PoRuvPo09ilARmjJXxo6tq05ANZkn73Ovl4x9E3/F4gFpEq0yjajvbFd004NK4eapVUbs94kD+9Zl3V4h+FdSoNDuyVHe2iejFxOUC2spKHV71cB1RDkbWmRK3Wc1XijGZgPWVbtEUscYVc5Ax6XcIj9JqPelD6cqA1UGLXmxWE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755972294; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qYTSImav2ndxDPekAShgWRsWABmiDWd58aRKAcxdzIY=; 
	b=FJbuIWlUVUAqND6LVsrJPWHAT6dXeLhT08aQ4BLRA2evgA5R7Fw+4NavDHc0rJg0VCQzezsgSJwZbQRXv4qjWI5FWX+CAHVuFIZ58j84wmLx0puKJ36sCcglrMhp9yBo/kCwvdNhQHbezmYtMZbb8DzsEPEVj1Z3aAS05E4Sg00=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755972294;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qYTSImav2ndxDPekAShgWRsWABmiDWd58aRKAcxdzIY=;
	b=kgyTGKO8aSerzPiphVksilZkzmZ5w59cKK/x+r5WPtWDabgzkqr1yOkaCHP3kGpn
	0XKFc41QlPMLTMvpwuMx3/6CxIdsOq4mu61LJaI3FYp1Nab8v38HtZXl2vRnw/ow4wc
	/IUlsPZZBYx2hNMmvXcXaUn7WKRMSH+jezhbKr34=
Received: by mx.zohomail.com with SMTPS id 175597229108325.21947672736735;
	Sat, 23 Aug 2025 11:04:51 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Clemens Ladisch <clemens@ladisch.de>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Rong Zhang <i@rong.moe>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (k10temp) Add device ID for Strix Halo
Date: Sun, 24 Aug 2025 02:04:41 +0800
Message-ID: <20250823180443.85512-1-i@rong.moe>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The device ID of Strix Halo Data Fabric Function 3 has been in the tree
since commit 0e640f0a47d8 ("x86/amd_nb: Add new PCI IDs for AMD family
0x1a"), but is somehow missing from k10temp_id_table.

Add it so that it works out of the box.

Tested on Beelink GTR9 Pro Mini PC.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 2f90a2e9ad49..b98d5ec72c4f 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -565,6 +565,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}

base-commit: 9703c672af8dd3573c76ce509dfff26bf6c4768d
-- 
2.50.1


