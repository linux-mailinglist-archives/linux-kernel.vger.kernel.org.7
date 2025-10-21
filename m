Return-Path: <linux-kernel+bounces-862536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0183EBF58D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EC718C7649
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C322F8BD3;
	Tue, 21 Oct 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FTQVZqgm"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BB2E1F0A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039561; cv=none; b=qu9F7ZmqVX3DCrX3/LfjePCyMRV+0VjuyYAzmVZLiurUsWJSMBuHLgm6RA4fY5n1yToZA8bNTU6zJwsteYGDRn2MtoXXuYW/Y9y9ku4FUCZJDK9Cd4G5Qe6gL8tqLBycvEOehLlx1H5x2/2+h7DqtcJWSIgFRifknRqNMzM2yis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039561; c=relaxed/simple;
	bh=RwJrZm4ImxoMY5MWnAswZc4Mpt8DbLeQA/Zdmn9RbOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFh+Bz4kbKE+cCj0MY0JhiNI7FfdXsgrD2kF31kxsH/PQMnHqdbAP/C34xze+0vC+/A+mtQO5T1cDObXHx9glymLiQzmzNCFBmTuPRtOYoFjWLmn+eqv7iIkO2FJvXyW53Q4/7t7ZXNaRt6A61XSHler90TU/3W7xHPNxKalkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FTQVZqgm; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59L9cR3Q3218634;
	Tue, 21 Oct 2025 04:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761039507;
	bh=T/Z5aqXuapEF8K+ZvhVTCTkDzzcjm2w/DNSnQ9609Rc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FTQVZqgmo8ziL8jaeW4zvs4gxF3yZW8lOtI2Qq4Ff+Q0zQ5qOrCMI9b4M/Ij/3Hr9
	 YHKu/CKOxZdsoDKr/rm4FFSV3oSoIQyWCickHGWeUgdaloB7QlJ3pe4aIqQOvv+h1T
	 jdaznaOaF4vsN+sczcK7cdHto08odPjaUhMP/qvg=
Received: from DLEE213.ent.ti.com (dlee213.ent.ti.com [157.170.170.116])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59L9cRo71056720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Oct 2025 04:38:27 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Oct
 2025 04:38:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Oct 2025 04:38:26 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.35])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59L9cKKZ3547512;
	Tue, 21 Oct 2025 04:38:24 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-firmware@kernel.org>
CC: <zigo@debian.org>, <baojun.xu@ti.com>, <13564923607@139.com>,
        <linux-kernel@vger.kernel.org>, <soyer@irl.hu>,
        <stuart.a.hayhurst@gmail.com>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1 1/1] ASoc: TAS2781: Create audio folder in ti folder, and move all the audio firmwares into it
Date: Tue, 21 Oct 2025 17:38:16 +0800
Message-ID: <20251021093816.735-2-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20251021093816.735-1-shenghao-ding@ti.com>
References: <20251021093816.735-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - Create the audio folder in ti in order to only store auido firmware.
 - Move all the audio firmware into the newly-created audio folder.
 - Update the year to 2025.
---
 WHENCE                                  | 302 ++++++++++++------------
 ti/{ => audio}/tas2563/INT8866RCA2.bin  | Bin
 ti/{ => audio}/tas2563/TAS2XXX3870.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX0C94.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX0C95.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX0C96.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX0C97.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX10A40.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX10A41.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX11540.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX11541.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX12040.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX12041.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX12140.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX12141.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX1EB30.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX1EB31.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX2234.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX2326.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX387D.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX387E.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX387F.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX3880.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX3881.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX3882.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX3884.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX3886.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38A5.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38A7.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38A8.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38B8.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38B9.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38BA.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38BB.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38BE.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38BF.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38C3.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38CB.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38CD.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38D3.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38D4.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38D5.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38D6.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38DF.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38E0.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX38FD.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX391F.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX3920.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX3E300.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3E301.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3EE00.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3EE01.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3EF00.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3EF01.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3F000.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3F001.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3F100.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3F101.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3F200.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3F201.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3F300.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX3F301.bin | Bin
 ti/{ => audio}/tas2781/TAS2XXX8DE8.bin  | Bin
 ti/{ => audio}/tas2781/TAS2XXX8DE9.bin  | Bin
 ti/{ => audio}/tas2781/TIAS2781RCA2.bin | Bin
 ti/{ => audio}/tas2781/TIAS2781RCA4.bin | Bin
 ti/{ => audio}/tas2781/TXNW2781RCA0.bin | Bin
 ti/{ => audio}/tas2781/TXNW2781RCA1.bin | Bin
 68 files changed, 151 insertions(+), 151 deletions(-)
 rename ti/{ => audio}/tas2563/INT8866RCA2.bin (100%)
 rename ti/{ => audio}/tas2563/TAS2XXX3870.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX0C94.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX0C95.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX0C96.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX0C97.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX10A40.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX10A41.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX11540.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX11541.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX12040.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX12041.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX12140.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX12141.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX1EB30.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX1EB31.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX2234.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX2326.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX387D.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX387E.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX387F.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3880.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3881.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3882.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3884.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3886.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38A5.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38A7.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38A8.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38B8.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38B9.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38BA.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38BB.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38BE.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38BF.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38C3.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38CB.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38CD.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38D3.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38D4.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38D5.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38D6.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38DF.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38E0.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX38FD.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX391F.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3920.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3E300.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3E301.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3EE00.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3EE01.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3EF00.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3EF01.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3F000.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3F001.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3F100.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3F101.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3F200.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3F201.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3F300.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX3F301.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX8DE8.bin (100%)
 rename ti/{ => audio}/tas2781/TAS2XXX8DE9.bin (100%)
 rename ti/{ => audio}/tas2781/TIAS2781RCA2.bin (100%)
 rename ti/{ => audio}/tas2781/TIAS2781RCA4.bin (100%)
 rename ti/{ => audio}/tas2781/TXNW2781RCA0.bin (100%)
 rename ti/{ => audio}/tas2781/TXNW2781RCA1.bin (100%)

diff --git a/WHENCE b/WHENCE
index a03f4dc8..3f05cda9 100644
--- a/WHENCE
+++ b/WHENCE
@@ -8556,165 +8556,165 @@ Originates from https://github.com/linux-msm/audioreach-topology.git
 
 --------------------------------------------------------------------------
 Driver: ti-tas2781 - tas2781 firmware
-File: ti/tas2781/TAS2XXX0C94.bin
-File: ti/tas2781/TAS2XXX0C95.bin
-File: ti/tas2781/TAS2XXX0C96.bin
-File: ti/tas2781/TAS2XXX0C97.bin
-File: ti/tas2781/TAS2XXX10A40.bin
-File: ti/tas2781/TAS2XXX10A41.bin
-File: ti/tas2781/TAS2XXX11540.bin
-File: ti/tas2781/TAS2XXX11541.bin
-File: ti/tas2781/TAS2XXX12040.bin
-File: ti/tas2781/TAS2XXX12041.bin
-File: ti/tas2781/TAS2XXX12140.bin
-File: ti/tas2781/TAS2XXX12141.bin
-File: ti/tas2781/TAS2XXX1EB30.bin
-File: ti/tas2781/TAS2XXX1EB31.bin
-File: ti/tas2781/TAS2XXX2234.bin
-File: ti/tas2781/TAS2XXX2326.bin
-File: ti/tas2781/TAS2XXX387D.bin
-File: ti/tas2781/TAS2XXX387E.bin
-File: ti/tas2781/TAS2XXX387F.bin
-File: ti/tas2781/TAS2XXX3880.bin
-File: ti/tas2781/TAS2XXX3881.bin
-File: ti/tas2781/TAS2XXX3882.bin
-File: ti/tas2781/TAS2XXX3884.bin
-File: ti/tas2781/TAS2XXX3886.bin
-File: ti/tas2781/TAS2XXX38A5.bin
-File: ti/tas2781/TAS2XXX38A7.bin
-File: ti/tas2781/TAS2XXX38A8.bin
-File: ti/tas2781/TAS2XXX38B8.bin
-File: ti/tas2781/TAS2XXX38B9.bin
-File: ti/tas2781/TAS2XXX38BA.bin
-File: ti/tas2781/TAS2XXX38BB.bin
-File: ti/tas2781/TAS2XXX38BE.bin
-File: ti/tas2781/TAS2XXX38BF.bin
-File: ti/tas2781/TAS2XXX38C3.bin
-File: ti/tas2781/TAS2XXX38CB.bin
-File: ti/tas2781/TAS2XXX38CD.bin
-File: ti/tas2781/TAS2XXX38D3.bin
-File: ti/tas2781/TAS2XXX38D4.bin
-File: ti/tas2781/TAS2XXX38D5.bin
-File: ti/tas2781/TAS2XXX38D6.bin
-File: ti/tas2781/TAS2XXX38DF.bin
-File: ti/tas2781/TAS2XXX38E0.bin
-File: ti/tas2781/TAS2XXX38FD.bin
-File: ti/tas2781/TAS2XXX391F.bin
-File: ti/tas2781/TAS2XXX3920.bin
-File: ti/tas2781/TAS2XXX3E300.bin
-File: ti/tas2781/TAS2XXX3E301.bin
-File: ti/tas2781/TAS2XXX3EE00.bin
-File: ti/tas2781/TAS2XXX3EE01.bin
-File: ti/tas2781/TAS2XXX3EF00.bin
-File: ti/tas2781/TAS2XXX3EF01.bin
-File: ti/tas2781/TAS2XXX3F000.bin
-File: ti/tas2781/TAS2XXX3F001.bin
-File: ti/tas2781/TAS2XXX3F100.bin
-File: ti/tas2781/TAS2XXX3F101.bin
-File: ti/tas2781/TAS2XXX3F200.bin
-File: ti/tas2781/TAS2XXX3F201.bin
-File: ti/tas2781/TAS2XXX3F300.bin
-File: ti/tas2781/TAS2XXX3F301.bin
-File: ti/tas2781/TAS2XXX8DE8.bin
-File: ti/tas2781/TAS2XXX8DE9.bin
-File: ti/tas2781/TXNW2781RCA0.bin
-File: ti/tas2781/TXNW2781RCA1.bin
-File: ti/tas2781/TIAS2781RCA2.bin
-File: ti/tas2781/TIAS2781RCA4.bin
-Link: TAS2XXX0C94.bin -> ti/tas2781/TAS2XXX0C94.bin
-Link: TAS2XXX0C95.bin -> ti/tas2781/TAS2XXX0C95.bin
-Link: TAS2XXX0C96.bin -> ti/tas2781/TAS2XXX0C96.bin
-Link: TAS2XXX0C97.bin -> ti/tas2781/TAS2XXX0C97.bin
-Link: TAS2XXX103C8DE80.bin -> ti/tas2781/TAS2XXX8DE8.bin
-Link: TAS2XXX103C8DE81.bin -> ti/tas2781/TAS2XXX8DE8.bin
-Link: TAS2XXX103C8DE90.bin -> ti/tas2781/TAS2XXX8DE9.bin
-Link: TAS2XXX103C8DE91.bin -> ti/tas2781/TAS2XXX8DE9.bin
-Link: TAS2XXX103C8DE8-0.bin -> ti/tas2781/TAS2XXX8DE8.bin
-Link: TAS2XXX103C8DE8-1.bin -> ti/tas2781/TAS2XXX8DE8.bin
-Link: TAS2XXX103C8DE9-0.bin -> ti/tas2781/TAS2XXX8DE9.bin
-Link: TAS2XXX103C8DE9-1.bin -> ti/tas2781/TAS2XXX8DE9.bin
-Link: TAS2XXX10A40.bin -> ti/tas2781/TAS2XXX10A40.bin
-Link: TAS2XXX10A41.bin -> ti/tas2781/TAS2XXX10A41.bin
-Link: TAS2XXX11540.bin -> ti/tas2781/TAS2XXX11540.bin
-Link: TAS2XXX11541.bin -> ti/tas2781/TAS2XXX11541.bin
-Link: TAS2XXX12040.bin -> ti/tas2781/TAS2XXX12040.bin
-Link: TAS2XXX12041.bin -> ti/tas2781/TAS2XXX12041.bin
-Link: TAS2XXX12140.bin -> ti/tas2781/TAS2XXX12140.bin
-Link: TAS2XXX12141.bin -> ti/tas2781/TAS2XXX12141.bin
-Link: TAS2XXX1EB3.bin -> ti/tas2781/TAS2XXX1EB30.bin
-Link: TAS2XXX1EB30.bin -> ti/tas2781/TAS2XXX1EB30.bin
-Link: TAS2XXX1EB31.bin -> ti/tas2781/TAS2XXX1EB31.bin
-Link: TAS2XXX2234.bin -> ti/tas2781/TAS2XXX2234.bin
-Link: TAS2XXX2326.bin -> ti/tas2781/TAS2XXX2326.bin
-Link: TAS2XXX387D.bin -> ti/tas2781/TAS2XXX387D.bin
-Link: TAS2XXX387E.bin -> ti/tas2781/TAS2XXX387E.bin
-Link: TAS2XXX387F.bin -> ti/tas2781/TAS2XXX387F.bin
-Link: TAS2XXX3880.bin -> ti/tas2781/TAS2XXX3880.bin
-Link: TAS2XXX3881.bin -> ti/tas2781/TAS2XXX3881.bin
-Link: TAS2XXX3882.bin -> ti/tas2781/TAS2XXX3882.bin
-Link: TAS2XXX3884.bin -> ti/tas2781/TAS2XXX3884.bin
-Link: TAS2XXX3886.bin -> ti/tas2781/TAS2XXX3886.bin
-Link: TAS2XXX38A5.bin -> ti/tas2781/TAS2XXX38A5.bin
-Link: TAS2XXX38A7.bin -> ti/tas2781/TAS2XXX38A7.bin
-Link: TAS2XXX38A8.bin -> ti/tas2781/TAS2XXX38A8.bin
-Link: TAS2XXX38B8.bin -> ti/tas2781/TAS2XXX38B8.bin
-Link: TAS2XXX38B9.bin -> ti/tas2781/TAS2XXX38B9.bin
-Link: TAS2XXX38BA.bin -> ti/tas2781/TAS2XXX38BA.bin
-Link: TAS2XXX38BB.bin -> ti/tas2781/TAS2XXX38BB.bin
-Link: TAS2XXX38BE.bin -> ti/tas2781/TAS2XXX38BE.bin
-Link: TAS2XXX38BF.bin -> ti/tas2781/TAS2XXX38BF.bin
-Link: TAS2XXX38C3.bin -> ti/tas2781/TAS2XXX38C3.bin
-Link: TAS2XXX38CB.bin -> ti/tas2781/TAS2XXX38CB.bin
-Link: TAS2XXX38CD.bin -> ti/tas2781/TAS2XXX38CD.bin
-Link: TAS2XXX38D3.bin -> ti/tas2781/TAS2XXX38D3.bin
-Link: TAS2XXX38D4.bin -> ti/tas2781/TAS2XXX38D4.bin
-Link: TAS2XXX38D5.bin -> ti/tas2781/TAS2XXX38D5.bin
-Link: TAS2XXX38D6.bin -> ti/tas2781/TAS2XXX38D6.bin
-Link: TAS2XXX38DF.bin -> ti/tas2781/TAS2XXX38DF.bin
-Link: TAS2XXX38E0.bin -> ti/tas2781/TAS2XXX38E0.bin
-Link: TAS2XXX38FD.bin -> ti/tas2781/TAS2XXX38FD.bin
-Link: TAS2XXX391F.bin -> ti/tas2781/TAS2XXX391F.bin
-Link: TAS2XXX3920.bin -> ti/tas2781/TAS2XXX3920.bin
-Link: TAS2XXX3E300.bin -> ti/tas2781/TAS2XXX3E300.bin
-Link: TAS2XXX3E301.bin -> ti/tas2781/TAS2XXX3E301.bin
-Link: TAS2XXX3EE00.bin -> ti/tas2781/TAS2XXX3EE00.bin
-Link: TAS2XXX3EE01.bin -> ti/tas2781/TAS2XXX3EE01.bin
-Link: TAS2XXX3EF00.bin -> ti/tas2781/TAS2XXX3EF00.bin
-Link: TAS2XXX3EF01.bin -> ti/tas2781/TAS2XXX3EF01.bin
-Link: TAS2XXX3F000.bin -> ti/tas2781/TAS2XXX3F000.bin
-Link: TAS2XXX3F001.bin -> ti/tas2781/TAS2XXX3F001.bin
-Link: TAS2XXX3F100.bin -> ti/tas2781/TAS2XXX3F100.bin
-Link: TAS2XXX3F101.bin -> ti/tas2781/TAS2XXX3F101.bin
-Link: TAS2XXX3F200.bin -> ti/tas2781/TAS2XXX3F200.bin
-Link: TAS2XXX3F201.bin -> ti/tas2781/TAS2XXX3F201.bin
-Link: TAS2XXX3F300.bin -> ti/tas2781/TAS2XXX3F300.bin
-Link: TAS2XXX3F301.bin -> ti/tas2781/TAS2XXX3F301.bin
-Link: TAS2XXX8DE8.bin -> ti/tas2781/TAS2XXX8DE8.bin
-Link: TAS2XXX8DE9.bin -> ti/tas2781/TAS2XXX8DE9.bin
-Link: TAS2XXX8DE80.bin -> ti/tas2781/TAS2XXX8DE8.bin
-Link: TAS2XXX8DE81.bin -> ti/tas2781/TAS2XXX8DE8.bin
-Link: TAS2XXX8DE90.bin -> ti/tas2781/TAS2XXX8DE9.bin
-Link: TAS2XXX8DE91.bin -> ti/tas2781/TAS2XXX8DE9.bin
-Link: TIAS2781RCA2.bin -> ti/tas2781/TIAS2781RCA2.bin
-Link: TIAS2781RCA4.bin -> ti/tas2781/TIAS2781RCA4.bin
-Link: TXNW2781RCA1.bin -> ti/tas2781/TXNW2781RCA0.bin
-Link: TXNW2781RCA0.bin -> ti/tas2781/TXNW2781RCA1.bin
-Link: TXNW2781RCA2.bin -> ti/tas2781/TIAS2781RCA2.bin
-Link: TXNW2781RCA4.bin -> ti/tas2781/TIAS2781RCA4.bin
+File: ti/audio/tas2781/TAS2XXX0C94.bin
+File: ti/audio/tas2781/TAS2XXX0C95.bin
+File: ti/audio/tas2781/TAS2XXX0C96.bin
+File: ti/audio/tas2781/TAS2XXX0C97.bin
+File: ti/audio/tas2781/TAS2XXX10A40.bin
+File: ti/audio/tas2781/TAS2XXX10A41.bin
+File: ti/audio/tas2781/TAS2XXX11540.bin
+File: ti/audio/tas2781/TAS2XXX11541.bin
+File: ti/audio/tas2781/TAS2XXX12040.bin
+File: ti/audio/tas2781/TAS2XXX12041.bin
+File: ti/audio/tas2781/TAS2XXX12140.bin
+File: ti/audio/tas2781/TAS2XXX12141.bin
+File: ti/audio/tas2781/TAS2XXX1EB30.bin
+File: ti/audio/tas2781/TAS2XXX1EB31.bin
+File: ti/audio/tas2781/TAS2XXX2234.bin
+File: ti/audio/tas2781/TAS2XXX2326.bin
+File: ti/audio/tas2781/TAS2XXX387D.bin
+File: ti/audio/tas2781/TAS2XXX387E.bin
+File: ti/audio/tas2781/TAS2XXX387F.bin
+File: ti/audio/tas2781/TAS2XXX3880.bin
+File: ti/audio/tas2781/TAS2XXX3881.bin
+File: ti/audio/tas2781/TAS2XXX3882.bin
+File: ti/audio/tas2781/TAS2XXX3884.bin
+File: ti/audio/tas2781/TAS2XXX3886.bin
+File: ti/audio/tas2781/TAS2XXX38A5.bin
+File: ti/audio/tas2781/TAS2XXX38A7.bin
+File: ti/audio/tas2781/TAS2XXX38A8.bin
+File: ti/audio/tas2781/TAS2XXX38B8.bin
+File: ti/audio/tas2781/TAS2XXX38B9.bin
+File: ti/audio/tas2781/TAS2XXX38BA.bin
+File: ti/audio/tas2781/TAS2XXX38BB.bin
+File: ti/audio/tas2781/TAS2XXX38BE.bin
+File: ti/audio/tas2781/TAS2XXX38BF.bin
+File: ti/audio/tas2781/TAS2XXX38C3.bin
+File: ti/audio/tas2781/TAS2XXX38CB.bin
+File: ti/audio/tas2781/TAS2XXX38CD.bin
+File: ti/audio/tas2781/TAS2XXX38D3.bin
+File: ti/audio/tas2781/TAS2XXX38D4.bin
+File: ti/audio/tas2781/TAS2XXX38D5.bin
+File: ti/audio/tas2781/TAS2XXX38D6.bin
+File: ti/audio/tas2781/TAS2XXX38DF.bin
+File: ti/audio/tas2781/TAS2XXX38E0.bin
+File: ti/audio/tas2781/TAS2XXX38FD.bin
+File: ti/audio/tas2781/TAS2XXX391F.bin
+File: ti/audio/tas2781/TAS2XXX3920.bin
+File: ti/audio/tas2781/TAS2XXX3E300.bin
+File: ti/audio/tas2781/TAS2XXX3E301.bin
+File: ti/audio/tas2781/TAS2XXX3EE00.bin
+File: ti/audio/tas2781/TAS2XXX3EE01.bin
+File: ti/audio/tas2781/TAS2XXX3EF00.bin
+File: ti/audio/tas2781/TAS2XXX3EF01.bin
+File: ti/audio/tas2781/TAS2XXX3F000.bin
+File: ti/audio/tas2781/TAS2XXX3F001.bin
+File: ti/audio/tas2781/TAS2XXX3F100.bin
+File: ti/audio/tas2781/TAS2XXX3F101.bin
+File: ti/audio/tas2781/TAS2XXX3F200.bin
+File: ti/audio/tas2781/TAS2XXX3F201.bin
+File: ti/audio/tas2781/TAS2XXX3F300.bin
+File: ti/audio/tas2781/TAS2XXX3F301.bin
+File: ti/audio/tas2781/TAS2XXX8DE8.bin
+File: ti/audio/tas2781/TAS2XXX8DE9.bin
+File: ti/audio/tas2781/TXNW2781RCA0.bin
+File: ti/audio/tas2781/TXNW2781RCA1.bin
+File: ti/audio/tas2781/TIAS2781RCA2.bin
+File: ti/audio/tas2781/TIAS2781RCA4.bin
+Link: TAS2XXX0C94.bin -> ti/audio/tas2781/TAS2XXX0C94.bin
+Link: TAS2XXX0C95.bin -> ti/audio/tas2781/TAS2XXX0C95.bin
+Link: TAS2XXX0C96.bin -> ti/audio/tas2781/TAS2XXX0C96.bin
+Link: TAS2XXX0C97.bin -> ti/audio/tas2781/TAS2XXX0C97.bin
+Link: TAS2XXX103C8DE80.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
+Link: TAS2XXX103C8DE81.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
+Link: TAS2XXX103C8DE90.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
+Link: TAS2XXX103C8DE91.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
+Link: TAS2XXX103C8DE8-0.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
+Link: TAS2XXX103C8DE8-1.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
+Link: TAS2XXX103C8DE9-0.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
+Link: TAS2XXX103C8DE9-1.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
+Link: TAS2XXX10A40.bin -> ti/audio/tas2781/TAS2XXX10A40.bin
+Link: TAS2XXX10A41.bin -> ti/audio/tas2781/TAS2XXX10A41.bin
+Link: TAS2XXX11540.bin -> ti/audio/tas2781/TAS2XXX11540.bin
+Link: TAS2XXX11541.bin -> ti/audio/tas2781/TAS2XXX11541.bin
+Link: TAS2XXX12040.bin -> ti/audio/tas2781/TAS2XXX12040.bin
+Link: TAS2XXX12041.bin -> ti/audio/tas2781/TAS2XXX12041.bin
+Link: TAS2XXX12140.bin -> ti/audio/tas2781/TAS2XXX12140.bin
+Link: TAS2XXX12141.bin -> ti/audio/tas2781/TAS2XXX12141.bin
+Link: TAS2XXX1EB3.bin -> ti/audio/tas2781/TAS2XXX1EB30.bin
+Link: TAS2XXX1EB30.bin -> ti/audio/tas2781/TAS2XXX1EB30.bin
+Link: TAS2XXX1EB31.bin -> ti/audio/tas2781/TAS2XXX1EB31.bin
+Link: TAS2XXX2234.bin -> ti/audio/tas2781/TAS2XXX2234.bin
+Link: TAS2XXX2326.bin -> ti/audio/tas2781/TAS2XXX2326.bin
+Link: TAS2XXX387D.bin -> ti/audio/tas2781/TAS2XXX387D.bin
+Link: TAS2XXX387E.bin -> ti/audio/tas2781/TAS2XXX387E.bin
+Link: TAS2XXX387F.bin -> ti/audio/tas2781/TAS2XXX387F.bin
+Link: TAS2XXX3880.bin -> ti/audio/tas2781/TAS2XXX3880.bin
+Link: TAS2XXX3881.bin -> ti/audio/tas2781/TAS2XXX3881.bin
+Link: TAS2XXX3882.bin -> ti/audio/tas2781/TAS2XXX3882.bin
+Link: TAS2XXX3884.bin -> ti/audio/tas2781/TAS2XXX3884.bin
+Link: TAS2XXX3886.bin -> ti/audio/tas2781/TAS2XXX3886.bin
+Link: TAS2XXX38A5.bin -> ti/audio/tas2781/TAS2XXX38A5.bin
+Link: TAS2XXX38A7.bin -> ti/audio/tas2781/TAS2XXX38A7.bin
+Link: TAS2XXX38A8.bin -> ti/audio/tas2781/TAS2XXX38A8.bin
+Link: TAS2XXX38B8.bin -> ti/audio/tas2781/TAS2XXX38B8.bin
+Link: TAS2XXX38B9.bin -> ti/audio/tas2781/TAS2XXX38B9.bin
+Link: TAS2XXX38BA.bin -> ti/audio/tas2781/TAS2XXX38BA.bin
+Link: TAS2XXX38BB.bin -> ti/audio/tas2781/TAS2XXX38BB.bin
+Link: TAS2XXX38BE.bin -> ti/audio/tas2781/TAS2XXX38BE.bin
+Link: TAS2XXX38BF.bin -> ti/audio/tas2781/TAS2XXX38BF.bin
+Link: TAS2XXX38C3.bin -> ti/audio/tas2781/TAS2XXX38C3.bin
+Link: TAS2XXX38CB.bin -> ti/audio/tas2781/TAS2XXX38CB.bin
+Link: TAS2XXX38CD.bin -> ti/audio/tas2781/TAS2XXX38CD.bin
+Link: TAS2XXX38D3.bin -> ti/audio/tas2781/TAS2XXX38D3.bin
+Link: TAS2XXX38D4.bin -> ti/audio/tas2781/TAS2XXX38D4.bin
+Link: TAS2XXX38D5.bin -> ti/audio/tas2781/TAS2XXX38D5.bin
+Link: TAS2XXX38D6.bin -> ti/audio/tas2781/TAS2XXX38D6.bin
+Link: TAS2XXX38DF.bin -> ti/audio/tas2781/TAS2XXX38DF.bin
+Link: TAS2XXX38E0.bin -> ti/audio/tas2781/TAS2XXX38E0.bin
+Link: TAS2XXX38FD.bin -> ti/audio/tas2781/TAS2XXX38FD.bin
+Link: TAS2XXX391F.bin -> ti/audio/tas2781/TAS2XXX391F.bin
+Link: TAS2XXX3920.bin -> ti/audio/tas2781/TAS2XXX3920.bin
+Link: TAS2XXX3E300.bin -> ti/audio/tas2781/TAS2XXX3E300.bin
+Link: TAS2XXX3E301.bin -> ti/audio/tas2781/TAS2XXX3E301.bin
+Link: TAS2XXX3EE00.bin -> ti/audio/tas2781/TAS2XXX3EE00.bin
+Link: TAS2XXX3EE01.bin -> ti/audio/tas2781/TAS2XXX3EE01.bin
+Link: TAS2XXX3EF00.bin -> ti/audio/tas2781/TAS2XXX3EF00.bin
+Link: TAS2XXX3EF01.bin -> ti/audio/tas2781/TAS2XXX3EF01.bin
+Link: TAS2XXX3F000.bin -> ti/audio/tas2781/TAS2XXX3F000.bin
+Link: TAS2XXX3F001.bin -> ti/audio/tas2781/TAS2XXX3F001.bin
+Link: TAS2XXX3F100.bin -> ti/audio/tas2781/TAS2XXX3F100.bin
+Link: TAS2XXX3F101.bin -> ti/audio/tas2781/TAS2XXX3F101.bin
+Link: TAS2XXX3F200.bin -> ti/audio/tas2781/TAS2XXX3F200.bin
+Link: TAS2XXX3F201.bin -> ti/audio/tas2781/TAS2XXX3F201.bin
+Link: TAS2XXX3F300.bin -> ti/audio/tas2781/TAS2XXX3F300.bin
+Link: TAS2XXX3F301.bin -> ti/audio/tas2781/TAS2XXX3F301.bin
+Link: TAS2XXX8DE8.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
+Link: TAS2XXX8DE9.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
+Link: TAS2XXX8DE80.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
+Link: TAS2XXX8DE81.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
+Link: TAS2XXX8DE90.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
+Link: TAS2XXX8DE91.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
+Link: TIAS2781RCA2.bin -> ti/audio/tas2781/TIAS2781RCA2.bin
+Link: TIAS2781RCA4.bin -> ti/audio/tas2781/TIAS2781RCA4.bin
+Link: TXNW2781RCA1.bin -> ti/audio/tas2781/TXNW2781RCA0.bin
+Link: TXNW2781RCA0.bin -> ti/audio/tas2781/TXNW2781RCA1.bin
+Link: TXNW2781RCA2.bin -> ti/audio/tas2781/TIAS2781RCA2.bin
+Link: TXNW2781RCA4.bin -> ti/audio/tas2781/TIAS2781RCA4.bin
 
 Licence: Redistributable. See LICENCE.ti-tspa for details. Marked:
-	 Copyright (C) 2023 - 2024 Texas Instruments
+	 Copyright (C) 2023 - 2025 Texas Instruments
 
 --------------------------------------------------------------------------
 
 Driver: ti-tas2563 - tas2563 firmware
-File: ti/tas2563/TAS2XXX3870.bin
-File: ti/tas2563/INT8866RCA2.bin
-Link: TAS2XXX3870.bin -> ti/tas2563/TAS2XXX3870.bin
-Link: INT8866RCA2.bin -> ti/tas2563/INT8866RCA2.bin
+File: ti/audio/tas2563/TAS2XXX3870.bin
+File: ti/audio/tas2563/INT8866RCA2.bin
+Link: TAS2XXX3870.bin -> ti/audio/tas2563/TAS2XXX3870.bin
+Link: INT8866RCA2.bin -> ti/audio/tas2563/INT8866RCA2.bin
 
 Licence: Redistributable. LICENCE.ti-tspa for details. Marked:
-	 Copyright (C) 2023 - 2024 Texas Instruments
+	 Copyright (C) 2023 - 2025 Texas Instruments
 
 --------------------------------------------------------------------------
 
diff --git a/ti/tas2563/INT8866RCA2.bin b/ti/audio/tas2563/INT8866RCA2.bin
similarity index 100%
rename from ti/tas2563/INT8866RCA2.bin
rename to ti/audio/tas2563/INT8866RCA2.bin
diff --git a/ti/tas2563/TAS2XXX3870.bin b/ti/audio/tas2563/TAS2XXX3870.bin
similarity index 100%
rename from ti/tas2563/TAS2XXX3870.bin
rename to ti/audio/tas2563/TAS2XXX3870.bin
diff --git a/ti/tas2781/TAS2XXX0C94.bin b/ti/audio/tas2781/TAS2XXX0C94.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX0C94.bin
rename to ti/audio/tas2781/TAS2XXX0C94.bin
diff --git a/ti/tas2781/TAS2XXX0C95.bin b/ti/audio/tas2781/TAS2XXX0C95.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX0C95.bin
rename to ti/audio/tas2781/TAS2XXX0C95.bin
diff --git a/ti/tas2781/TAS2XXX0C96.bin b/ti/audio/tas2781/TAS2XXX0C96.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX0C96.bin
rename to ti/audio/tas2781/TAS2XXX0C96.bin
diff --git a/ti/tas2781/TAS2XXX0C97.bin b/ti/audio/tas2781/TAS2XXX0C97.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX0C97.bin
rename to ti/audio/tas2781/TAS2XXX0C97.bin
diff --git a/ti/tas2781/TAS2XXX10A40.bin b/ti/audio/tas2781/TAS2XXX10A40.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX10A40.bin
rename to ti/audio/tas2781/TAS2XXX10A40.bin
diff --git a/ti/tas2781/TAS2XXX10A41.bin b/ti/audio/tas2781/TAS2XXX10A41.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX10A41.bin
rename to ti/audio/tas2781/TAS2XXX10A41.bin
diff --git a/ti/tas2781/TAS2XXX11540.bin b/ti/audio/tas2781/TAS2XXX11540.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX11540.bin
rename to ti/audio/tas2781/TAS2XXX11540.bin
diff --git a/ti/tas2781/TAS2XXX11541.bin b/ti/audio/tas2781/TAS2XXX11541.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX11541.bin
rename to ti/audio/tas2781/TAS2XXX11541.bin
diff --git a/ti/tas2781/TAS2XXX12040.bin b/ti/audio/tas2781/TAS2XXX12040.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX12040.bin
rename to ti/audio/tas2781/TAS2XXX12040.bin
diff --git a/ti/tas2781/TAS2XXX12041.bin b/ti/audio/tas2781/TAS2XXX12041.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX12041.bin
rename to ti/audio/tas2781/TAS2XXX12041.bin
diff --git a/ti/tas2781/TAS2XXX12140.bin b/ti/audio/tas2781/TAS2XXX12140.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX12140.bin
rename to ti/audio/tas2781/TAS2XXX12140.bin
diff --git a/ti/tas2781/TAS2XXX12141.bin b/ti/audio/tas2781/TAS2XXX12141.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX12141.bin
rename to ti/audio/tas2781/TAS2XXX12141.bin
diff --git a/ti/tas2781/TAS2XXX1EB30.bin b/ti/audio/tas2781/TAS2XXX1EB30.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX1EB30.bin
rename to ti/audio/tas2781/TAS2XXX1EB30.bin
diff --git a/ti/tas2781/TAS2XXX1EB31.bin b/ti/audio/tas2781/TAS2XXX1EB31.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX1EB31.bin
rename to ti/audio/tas2781/TAS2XXX1EB31.bin
diff --git a/ti/tas2781/TAS2XXX2234.bin b/ti/audio/tas2781/TAS2XXX2234.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX2234.bin
rename to ti/audio/tas2781/TAS2XXX2234.bin
diff --git a/ti/tas2781/TAS2XXX2326.bin b/ti/audio/tas2781/TAS2XXX2326.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX2326.bin
rename to ti/audio/tas2781/TAS2XXX2326.bin
diff --git a/ti/tas2781/TAS2XXX387D.bin b/ti/audio/tas2781/TAS2XXX387D.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX387D.bin
rename to ti/audio/tas2781/TAS2XXX387D.bin
diff --git a/ti/tas2781/TAS2XXX387E.bin b/ti/audio/tas2781/TAS2XXX387E.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX387E.bin
rename to ti/audio/tas2781/TAS2XXX387E.bin
diff --git a/ti/tas2781/TAS2XXX387F.bin b/ti/audio/tas2781/TAS2XXX387F.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX387F.bin
rename to ti/audio/tas2781/TAS2XXX387F.bin
diff --git a/ti/tas2781/TAS2XXX3880.bin b/ti/audio/tas2781/TAS2XXX3880.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3880.bin
rename to ti/audio/tas2781/TAS2XXX3880.bin
diff --git a/ti/tas2781/TAS2XXX3881.bin b/ti/audio/tas2781/TAS2XXX3881.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3881.bin
rename to ti/audio/tas2781/TAS2XXX3881.bin
diff --git a/ti/tas2781/TAS2XXX3882.bin b/ti/audio/tas2781/TAS2XXX3882.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3882.bin
rename to ti/audio/tas2781/TAS2XXX3882.bin
diff --git a/ti/tas2781/TAS2XXX3884.bin b/ti/audio/tas2781/TAS2XXX3884.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3884.bin
rename to ti/audio/tas2781/TAS2XXX3884.bin
diff --git a/ti/tas2781/TAS2XXX3886.bin b/ti/audio/tas2781/TAS2XXX3886.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3886.bin
rename to ti/audio/tas2781/TAS2XXX3886.bin
diff --git a/ti/tas2781/TAS2XXX38A5.bin b/ti/audio/tas2781/TAS2XXX38A5.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38A5.bin
rename to ti/audio/tas2781/TAS2XXX38A5.bin
diff --git a/ti/tas2781/TAS2XXX38A7.bin b/ti/audio/tas2781/TAS2XXX38A7.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38A7.bin
rename to ti/audio/tas2781/TAS2XXX38A7.bin
diff --git a/ti/tas2781/TAS2XXX38A8.bin b/ti/audio/tas2781/TAS2XXX38A8.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38A8.bin
rename to ti/audio/tas2781/TAS2XXX38A8.bin
diff --git a/ti/tas2781/TAS2XXX38B8.bin b/ti/audio/tas2781/TAS2XXX38B8.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38B8.bin
rename to ti/audio/tas2781/TAS2XXX38B8.bin
diff --git a/ti/tas2781/TAS2XXX38B9.bin b/ti/audio/tas2781/TAS2XXX38B9.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38B9.bin
rename to ti/audio/tas2781/TAS2XXX38B9.bin
diff --git a/ti/tas2781/TAS2XXX38BA.bin b/ti/audio/tas2781/TAS2XXX38BA.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38BA.bin
rename to ti/audio/tas2781/TAS2XXX38BA.bin
diff --git a/ti/tas2781/TAS2XXX38BB.bin b/ti/audio/tas2781/TAS2XXX38BB.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38BB.bin
rename to ti/audio/tas2781/TAS2XXX38BB.bin
diff --git a/ti/tas2781/TAS2XXX38BE.bin b/ti/audio/tas2781/TAS2XXX38BE.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38BE.bin
rename to ti/audio/tas2781/TAS2XXX38BE.bin
diff --git a/ti/tas2781/TAS2XXX38BF.bin b/ti/audio/tas2781/TAS2XXX38BF.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38BF.bin
rename to ti/audio/tas2781/TAS2XXX38BF.bin
diff --git a/ti/tas2781/TAS2XXX38C3.bin b/ti/audio/tas2781/TAS2XXX38C3.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38C3.bin
rename to ti/audio/tas2781/TAS2XXX38C3.bin
diff --git a/ti/tas2781/TAS2XXX38CB.bin b/ti/audio/tas2781/TAS2XXX38CB.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38CB.bin
rename to ti/audio/tas2781/TAS2XXX38CB.bin
diff --git a/ti/tas2781/TAS2XXX38CD.bin b/ti/audio/tas2781/TAS2XXX38CD.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38CD.bin
rename to ti/audio/tas2781/TAS2XXX38CD.bin
diff --git a/ti/tas2781/TAS2XXX38D3.bin b/ti/audio/tas2781/TAS2XXX38D3.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38D3.bin
rename to ti/audio/tas2781/TAS2XXX38D3.bin
diff --git a/ti/tas2781/TAS2XXX38D4.bin b/ti/audio/tas2781/TAS2XXX38D4.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38D4.bin
rename to ti/audio/tas2781/TAS2XXX38D4.bin
diff --git a/ti/tas2781/TAS2XXX38D5.bin b/ti/audio/tas2781/TAS2XXX38D5.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38D5.bin
rename to ti/audio/tas2781/TAS2XXX38D5.bin
diff --git a/ti/tas2781/TAS2XXX38D6.bin b/ti/audio/tas2781/TAS2XXX38D6.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38D6.bin
rename to ti/audio/tas2781/TAS2XXX38D6.bin
diff --git a/ti/tas2781/TAS2XXX38DF.bin b/ti/audio/tas2781/TAS2XXX38DF.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38DF.bin
rename to ti/audio/tas2781/TAS2XXX38DF.bin
diff --git a/ti/tas2781/TAS2XXX38E0.bin b/ti/audio/tas2781/TAS2XXX38E0.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38E0.bin
rename to ti/audio/tas2781/TAS2XXX38E0.bin
diff --git a/ti/tas2781/TAS2XXX38FD.bin b/ti/audio/tas2781/TAS2XXX38FD.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX38FD.bin
rename to ti/audio/tas2781/TAS2XXX38FD.bin
diff --git a/ti/tas2781/TAS2XXX391F.bin b/ti/audio/tas2781/TAS2XXX391F.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX391F.bin
rename to ti/audio/tas2781/TAS2XXX391F.bin
diff --git a/ti/tas2781/TAS2XXX3920.bin b/ti/audio/tas2781/TAS2XXX3920.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3920.bin
rename to ti/audio/tas2781/TAS2XXX3920.bin
diff --git a/ti/tas2781/TAS2XXX3E300.bin b/ti/audio/tas2781/TAS2XXX3E300.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3E300.bin
rename to ti/audio/tas2781/TAS2XXX3E300.bin
diff --git a/ti/tas2781/TAS2XXX3E301.bin b/ti/audio/tas2781/TAS2XXX3E301.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3E301.bin
rename to ti/audio/tas2781/TAS2XXX3E301.bin
diff --git a/ti/tas2781/TAS2XXX3EE00.bin b/ti/audio/tas2781/TAS2XXX3EE00.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3EE00.bin
rename to ti/audio/tas2781/TAS2XXX3EE00.bin
diff --git a/ti/tas2781/TAS2XXX3EE01.bin b/ti/audio/tas2781/TAS2XXX3EE01.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3EE01.bin
rename to ti/audio/tas2781/TAS2XXX3EE01.bin
diff --git a/ti/tas2781/TAS2XXX3EF00.bin b/ti/audio/tas2781/TAS2XXX3EF00.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3EF00.bin
rename to ti/audio/tas2781/TAS2XXX3EF00.bin
diff --git a/ti/tas2781/TAS2XXX3EF01.bin b/ti/audio/tas2781/TAS2XXX3EF01.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3EF01.bin
rename to ti/audio/tas2781/TAS2XXX3EF01.bin
diff --git a/ti/tas2781/TAS2XXX3F000.bin b/ti/audio/tas2781/TAS2XXX3F000.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3F000.bin
rename to ti/audio/tas2781/TAS2XXX3F000.bin
diff --git a/ti/tas2781/TAS2XXX3F001.bin b/ti/audio/tas2781/TAS2XXX3F001.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3F001.bin
rename to ti/audio/tas2781/TAS2XXX3F001.bin
diff --git a/ti/tas2781/TAS2XXX3F100.bin b/ti/audio/tas2781/TAS2XXX3F100.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3F100.bin
rename to ti/audio/tas2781/TAS2XXX3F100.bin
diff --git a/ti/tas2781/TAS2XXX3F101.bin b/ti/audio/tas2781/TAS2XXX3F101.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3F101.bin
rename to ti/audio/tas2781/TAS2XXX3F101.bin
diff --git a/ti/tas2781/TAS2XXX3F200.bin b/ti/audio/tas2781/TAS2XXX3F200.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3F200.bin
rename to ti/audio/tas2781/TAS2XXX3F200.bin
diff --git a/ti/tas2781/TAS2XXX3F201.bin b/ti/audio/tas2781/TAS2XXX3F201.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3F201.bin
rename to ti/audio/tas2781/TAS2XXX3F201.bin
diff --git a/ti/tas2781/TAS2XXX3F300.bin b/ti/audio/tas2781/TAS2XXX3F300.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3F300.bin
rename to ti/audio/tas2781/TAS2XXX3F300.bin
diff --git a/ti/tas2781/TAS2XXX3F301.bin b/ti/audio/tas2781/TAS2XXX3F301.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX3F301.bin
rename to ti/audio/tas2781/TAS2XXX3F301.bin
diff --git a/ti/tas2781/TAS2XXX8DE8.bin b/ti/audio/tas2781/TAS2XXX8DE8.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX8DE8.bin
rename to ti/audio/tas2781/TAS2XXX8DE8.bin
diff --git a/ti/tas2781/TAS2XXX8DE9.bin b/ti/audio/tas2781/TAS2XXX8DE9.bin
similarity index 100%
rename from ti/tas2781/TAS2XXX8DE9.bin
rename to ti/audio/tas2781/TAS2XXX8DE9.bin
diff --git a/ti/tas2781/TIAS2781RCA2.bin b/ti/audio/tas2781/TIAS2781RCA2.bin
similarity index 100%
rename from ti/tas2781/TIAS2781RCA2.bin
rename to ti/audio/tas2781/TIAS2781RCA2.bin
diff --git a/ti/tas2781/TIAS2781RCA4.bin b/ti/audio/tas2781/TIAS2781RCA4.bin
similarity index 100%
rename from ti/tas2781/TIAS2781RCA4.bin
rename to ti/audio/tas2781/TIAS2781RCA4.bin
diff --git a/ti/tas2781/TXNW2781RCA0.bin b/ti/audio/tas2781/TXNW2781RCA0.bin
similarity index 100%
rename from ti/tas2781/TXNW2781RCA0.bin
rename to ti/audio/tas2781/TXNW2781RCA0.bin
diff --git a/ti/tas2781/TXNW2781RCA1.bin b/ti/audio/tas2781/TXNW2781RCA1.bin
similarity index 100%
rename from ti/tas2781/TXNW2781RCA1.bin
rename to ti/audio/tas2781/TXNW2781RCA1.bin
-- 
2.43.0


