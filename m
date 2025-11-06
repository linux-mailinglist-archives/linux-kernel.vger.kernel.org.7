Return-Path: <linux-kernel+bounces-887612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F608C38B60
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD63434E6BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05E1F4174;
	Thu,  6 Nov 2025 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BJ0kRpaG"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAC1465B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392798; cv=none; b=PdsTs+gI2ay3s/cRy/d+ST2AmhRFYfcS5gCKxyLaQe0N7qZGYKPN3hYLYFWyVovyR5ZmhMa4VV5IaxaLMR+HkHHDq4j0F5ulz98FOT3LF8VgBo62R16KhnrLAqgG4OP64yjtVy5uAUo5k6d5TDQkjTqDq/WsenxDTN+fqzlXxSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392798; c=relaxed/simple;
	bh=2QuG6z1/rX6cN1Zwg4rkkpz8v7h9o+cglIUTpxNjK8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=OmGRNVczFyScSrTPkAMg0c6S319dcsym/iFdHzXKNFxujUZtU1NgU5R2UUDhjkKv5hodnWUE04blkZraF+lgkziLJMA+3nW+WMUHSHiIsVKRyqJXfM8rV3d7ZuUksRxGTYCfHNney501GKqHybsIRj8XcRKyvq2JI6h0F8BLgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BJ0kRpaG; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251106012703epoutp047def70fa3f264a718d1b98ca0cf894ba~1RpJorsX21563715637epoutp04M
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:27:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251106012703epoutp047def70fa3f264a718d1b98ca0cf894ba~1RpJorsX21563715637epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762392423;
	bh=FUmPilvOX+860M4bzKodyhpSFYaspyR5h6f6riBEbMg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=BJ0kRpaGDgG7Lhoz7ehFqfFAMowIADGeausXXzM6EszgTvY+S/sRM2EDJ0rj67D32
	 ZlkXA+T22IkBJDq/Jb3nbiItuxtgI/MxViohp+a1gxL1aBn0vXx8+NkMYE3v24y7n2
	 AmRNn4w8mBP7I+4UPn9cD9nndllyZjnIQyMDdn2g=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20251106012703epcas1p38bb48af303ebac1b9f1f0cd404085bb3~1RpJGzaUA1524715247epcas1p3J;
	Thu,  6 Nov 2025 01:27:03 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.120]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4d24Ky6qBGz6B9m8; Thu,  6 Nov
	2025 01:27:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251106012702epcas1p28fdeed020ea44f18dcc751c283fbbcc2~1RpIXZe5L2455324553epcas1p2S;
	Thu,  6 Nov 2025 01:27:02 +0000 (GMT)
Received: from sh043lee-960XFH.. (unknown [10.253.98.183]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251106012702epsmtip23c64dda0ebc1fbc067d751b212d778ba~1RpIS1VKq1062010620epsmtip2G;
	Thu,  6 Nov 2025 01:27:02 +0000 (GMT)
From: Seunghui Lee <sh043.lee@samsung.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	martin.petersen@oracle.com, peter.wang@mediatek.com, beanhuo@micron.com,
	adrian.hunter@intel.com, storage.sec@samsung.com
Cc: Seunghui Lee <sh043.lee@samsung.com>
Subject: [PATCH] UFS: Make TM command timeout configurable from host side
Date: Thu,  6 Nov 2025 10:26:54 +0900
Message-ID: <20251106012654.4094-1-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251106012702epcas1p28fdeed020ea44f18dcc751c283fbbcc2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251106012702epcas1p28fdeed020ea44f18dcc751c283fbbcc2
References: <CGME20251106012702epcas1p28fdeed020ea44f18dcc751c283fbbcc2@epcas1p2.samsung.com>

Currently, UFS driver uses hardcoded TM_CMD_TIMEOUT (100ms) for all
Task Management commands, which may not be optimal for different UFS
devices and use cases.

This patch adds a configurable tm_cmd_timeout field to ufs_hba structure
and uses it instead of the hardcoded constant. The default value remains
TM_CMD_TIMEOUT to maintain backward compatibility.

[   90.372004] [1:  kworker/u16:1:   10] ufshcd-qcom 1d84000.ufshc: ufshcd_abort: Device abort task at tag 9
[   90.372025] [1:  kworker/u16:1:   10] ufshcd-qcom 1d84000.ufshc: UPIU[9] - issue time 80324520 us
[   90.372037] [1:  kworker/u16:1:   10] ufshcd-qcom 1d84000.ufshc: UPIU[9] - complete time 0 us
[   90.372049] [1:  kworker/u16:1:   10] ufshcd-qcom 1d84000.ufshc: UPIU[9] - Transfer Request Descriptor phys@0x28120
[   90.372085] [1:  kworker/u16:1:   10] ufshcd-qcom 1d84000.ufshc: UPIU[9] - Request UPIU phys@0xb400
[   90.372121] [1:  kworker/u16:1:   10] ufshcd-qcom 1d84000.ufshc: UPIU[9] - Response UPIU phys@0xb600
[   90.372180] [1:  kworker/u16:1:   10] ufshcd-qcom 1d84000.ufshc: UPIU[9] - PRDT - 2 entries  phys@0xb800
[   90.372193] [1:  kworker/u16:1:   10] ufshcd-qcom 1d84000.ufshc: ufshcd_abort: skipping abort
[   90.514494] [0:      scsi_eh_0:  209] ufshcd-qcom 1d84000.ufshc: __ufshcd_issue_tm_cmd: task management cmd 0x08 timed-out

Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 include/ufs/ufshcd.h      | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9ca27de4767a..6099504ffc35 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7252,7 +7252,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 
 	/* wait until the task management command is completed */
 	err = wait_for_completion_io_timeout(&wait,
-			msecs_to_jiffies(TM_CMD_TIMEOUT));
+			msecs_to_jiffies(hba->tm_cmd_timeout));
 	if (!err) {
 		ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_ERR);
 		dev_err(hba->dev, "%s: task management cmd 0x%.2x timed-out\n",
@@ -10565,6 +10565,7 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 	hba->dev = dev;
 	hba->dev_ref_clk_freq = REF_CLK_FREQ_INVAL;
 	hba->nop_out_timeout = NOP_OUT_TIMEOUT;
+	hba->tm_cmd_timeout = TM_CMD_TIMEOUT;
 	ufshcd_set_sg_entry_size(hba, sizeof(struct ufshcd_sg_entry));
 	INIT_LIST_HEAD(&hba->clk_list_head);
 	spin_lock_init(&hba->outstanding_lock);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 9425cfd9d00e..aed792eb9e16 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -884,6 +884,7 @@ enum ufshcd_mcq_opr {
  * @dev_cmd: ufs device management command information
  * @last_dme_cmd_tstamp: time stamp of the last completed DME command
  * @nop_out_timeout: NOP OUT timeout value
+ * @tm_cmd_timeout: TM CMD timeout value
  * @dev_info: information about the UFS device
  * @auto_bkops_enabled: to track whether bkops is enabled in device
  * @vreg_info: UFS device voltage regulator information
@@ -1042,6 +1043,7 @@ struct ufs_hba {
 	struct ufs_dev_cmd dev_cmd;
 	ktime_t last_dme_cmd_tstamp;
 	int nop_out_timeout;
+	int tm_cmd_timeout;
 
 	/* Keeps information of the UFS device connected to this host */
 	struct ufs_dev_info dev_info;
-- 
2.43.0


