Return-Path: <linux-kernel+bounces-862535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE09BF58D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75F624FF3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D3028F948;
	Tue, 21 Oct 2025 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HnrBHdFf"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640272E6CAD
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039559; cv=none; b=YwjLhNMWvwDMq/Ldvgo8zykyOt1F/HvMNi/0z5DZrQm+fUo0jwjCNDyJEw116DJRMkVQqYFk9QebpyY/P05rkWUxm0i/cWiGYUkid+Hb8L2+ELjauYkP6uaewf/l7Im8SRKA+X/OQcMvyoxG7FEY59qeSQ6aidVJy3NS/8TkJdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039559; c=relaxed/simple;
	bh=l+ndRp/1htPPahV7kR6irRM15W+1sDi5ZHhj1RXZ7wA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZhlDWJ0mXnOWN1yJldtpoM3sZMY9kXNM72jc8ZEA9VX6f8lvL20L8CKd7siDu1vJX02HPQr7dukE4Bw425aqfh/NlvJ83N9c64zFitbUPZ4xGRPCqtk8KUV9YsRVbIcdIvX0P9XFJJfPTbHFEI/00UjA9bEvhsIyRqWRoFQEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HnrBHdFf; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59L9cOJ23218594;
	Tue, 21 Oct 2025 04:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761039504;
	bh=YjrjZMi2FcOrITV2TEi7u4dwTybFJpBB0zKVd9p20zQ=;
	h=From:To:CC:Subject:Date;
	b=HnrBHdFfrLXniXtVxOBsiN0SvDEmZSYZkPb/EMhoU+sYJFk0pOUYy0gfpIKEDBQMZ
	 CFA6LKcF2Qi7rZI1E/JTqW2ls4WFghyxs5Mjbjg/v9n42bArYHcTthpls3lQpjqwXc
	 S+H8GtZebN2Aiu6WU/tzFgFiF8XqLPi9ALRW3StU=
Received: from DLEE210.ent.ti.com (dlee210.ent.ti.com [157.170.170.112])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59L9cO0J1478068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Oct 2025 04:38:24 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Oct
 2025 04:38:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Oct 2025 04:38:23 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.35])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59L9cKKY3547512;
	Tue, 21 Oct 2025 04:38:21 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-firmware@kernel.org>
CC: <zigo@debian.org>, <baojun.xu@ti.com>, <13564923607@139.com>,
        <linux-kernel@vger.kernel.org>, <soyer@irl.hu>,
        <stuart.a.hayhurst@gmail.com>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1 0/1] ASoc: TAS2781: firmware patch check report
Date: Tue, 21 Oct 2025 17:38:15 +0800
Message-ID: <20251021093816.735-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

 root@LAPTOP-4VMBP1QN:/usr/local/src/fw_new# make check
 Check that executables have shebangs.....................................Passed
 Forbid new submodules....................................................Passed
 Check Yaml...............................................................Passed
 Check for broken symlinks............................(no files to check)Skipped
 Detect Destroyed Symlinks................................................Passed
 shellcheck...............................................................Passed
 black....................................................................Passed
 markdownlint............................................................Skipped
 Check whence.............................................................Passed
 root@LAPTOP-4VMBP1QN:/usr/local/src/fw_new#

Shenghao Ding (1):
  ASoc: TAS2781: Create audio folder in ti folder, and move all the
    audio firmwares into it

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

-- 
2.43.0


