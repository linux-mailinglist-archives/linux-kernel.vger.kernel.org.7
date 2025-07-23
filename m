Return-Path: <linux-kernel+bounces-743094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5D8B0FA71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0723C7AD90F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21A12222BF;
	Wed, 23 Jul 2025 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semtech.com header.i=@semtech.com header.b="VU/oSwRF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=SemtechCorp.onmicrosoft.com header.i=@SemtechCorp.onmicrosoft.com header.b="gGpbSPoD"
Received: from mail1.bemta44.messagelabs.com (mail1.bemta44.messagelabs.com [67.219.246.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08B2033A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.219.246.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296387; cv=fail; b=hrXw9R5nL5GCTRUCVMI7wuGOPzxG5scFKcX78s+sYaJTyXDaWMOzA3+mSIMBYJ5/+Cto6dOZQmyadXIGJoT1xyibYfI4BhBxJGb/hYiUanhTIma0RN9TcneRYM8ho7sJ81KVbD26USAWK73+gfqAl9trqJBiVK2G6fYf2Q7dLA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296387; c=relaxed/simple;
	bh=UrzNuERjNIN4VPLLFJ1Sb7BMYWKze3yX1DMxfL7E1oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HZ3G+f4/0pNTnmxZ/YidI5BeiH3xBqveIFUHzpp1N3o8DL8+CBj1lnpLJ7ebdGVrcrHaLLzlTKnMMUMLHDC2jTirwVM8mY57JXsVW69FamXsUSzQ1w9imESFu5AENOMu0VdGmsE3ZAyS9Fu0i17AjC2NJCuE1tWyX41iCmUA0iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=semtech.com; spf=pass smtp.mailfrom=semtech.com; dkim=pass (2048-bit key) header.d=semtech.com header.i=@semtech.com header.b=VU/oSwRF; dkim=fail (1024-bit key) header.d=SemtechCorp.onmicrosoft.com header.i=@SemtechCorp.onmicrosoft.com header.b=gGpbSPoD reason="signature verification failed"; arc=fail smtp.client-ip=67.219.246.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=semtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semtech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=semtech.com; s=k1;
	t=1753296384; i=@semtech.com;
	bh=L1QUH3q5oKS00cIH4fmjxCiSFjCCQX/LfLnYyvCrInw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=VU/oSwRFLrx7iZPAZXe9jl4gZgqHDS+sRtgjqlrL1fRu2A/mWFD8JL1S/AFIbOydK
	 EU91ZFW3XCF4lyoMHybDEP8vozQZP7/9yfcp2IK/P1ordGfsi5n7hKrv6K5b7mP5pG
	 6oAORvHYv+2guHm28uxa3JGa6yMt/SdaLUM9VV5qmj7/eKQtHv+SYdcj4ZGix85Guj
	 vGAnKShvQ55WffEV622U1JifI8DCrwfg7jwjWySjY5ekVJc60OLet/TytftRIwzaiz
	 /QCDlDoPOwy0H+4ov2sZXVs63kcRJffmA52DN5SV8Rol4tCpxukhSsTbnN5PNuXiVq
	 Z2LMnO8VKAn2A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRWlGSWpSXmKPExsWikZ3arftftzH
  D4PdzDYvLu+awOTB6fN4kF8AYxZqZl5RfkcCasWHTUdaCzzwV/zedZWlg/MLVxcjFwSiwjFni
  5eQGVghnMavE4UMPmSCcaUwSj5vOgjksAtuZJfasmwFWJiQwj0lie+9CJghnJZPElscPWEAcC
  YGjjBKXPk9kgcicZZS41fyfHcK5zSjxY+5rqMxkRomlvWvYuhg5OdgEFCVav5wGGyYiMIdRYv
  P2Z8wgCWYBLYmfj28ygtjCAoESnX83gDWwCKhKvJnWA1bDK2Am8f3vIrAaCQF5icU7lkPFBSV
  OznzCAjFHXqJ562ywuJCArMSKCb1sEPXBEifnfWCBsCUlrt28wA5hy0ocPTsHKu4ocX3jUag5
  EhIHX7xghoj7Sqxon8sKYctJnOo9xwRzw86Nt6F6QyTOn5/HBgmYO/wS/1Z8YoRwnjFKdM66C
  zVJRqL98gLWCYwas5AcPgvJ4bOQLF/AyLyK0aI4tagstUjX0FAvqSgzPaMkNzEzRy+xSjdRr7
  RYNzk1r6QoMcdQLz25QC+1uFivuDI3OSdFLy+1ZBMjMKlwfago3MH47USz/iFGSQ4mJVFeQ+e
  GDCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvEHajRlCgkWp6akVaZk5wAQHk5bg4FES4bW7BdTK
  W1yQmFucmQ6ROsWoy/H94Mm9zEIsefl5qVLivNw6QDMEQIoySvPgRsCS7SVGWSlhXkYGBgYhn
  oLUotzMElT5V4ziHIxKwrwFIFN4MvNK4Da9AjqCCegI3iawI0oSEVJSDUzsryJYgjxTq0rdzB
  sDtkxUZzV5I7PX4YXUnuSZqskFofX63VYNmlrzd86Kk0+Zqnf5Rzevt9iHEPsb5bfP7VH0uyU
  6fSrH6/rqDT73d/zS+Ln4cbHyjqfi8c98+a9PP/uFJ1hbzO3p5UmfjOtdM4O/imZfkd60Z6O4
  42L+/3NVTr//Vr1EunSilOEn178HlDftfHH6o2TAPY6O+le5oikGmtc6O7pNtRVd/LrjV6iq1
  dnMXJfzlTfkGFuw9cLuYyf4nko/2VWStveA5IKtixb5WNRYrX1rIPfg38mJ+buebN8hf3KuCu
  +HhKOBIo2JXJvX93364y16UcEqadLlm7kTq1v8V33nvNNwWM70wWElluKMREMt5qLiRACLBZY
  zMQQAAA==
X-Env-Sender: zxue@semtech.com
X-Msg-Ref: server-10.tower-904.messagelabs.com!1753296383!40049!1
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received:
X-StarScan-Version: 9.118.1; banners=semtech.com,-,-
X-VirusChecked: Checked
Received: (qmail 24644 invoked from network); 23 Jul 2025 18:46:23 -0000
Received: from mail-mw2nam04on2139.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) (40.107.101.139)
  by server-10.tower-904.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 23 Jul 2025 18:46:23 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg0jnqV+riYx9sGVOXvN+hh8NiBzGGNG6Z4bvpshT2YbIxeaw+Jgo7AXhvX5cUMHgjuMxL2OrNwP/czaq43O4jvknPR4/NXtK/lD1FTvrBqFUUvUUeZhUVyyivDE/Upqk5Izi7Kyw/YcIeIQrbh8tiUhqrx7/83VG7uiYq6gw0wzymgiR+JGEhkfsS3MVeYy4I5ihgixoLm6Bg29u8oT49pR5Ivj+8FhWnuz8lOtEH+HwQEX0myTl5DUcP+w+pHCQ0H7+o/G9RqnNPyNa8xn8Kdt/UNKjBTPWt5ndmxNdzThTE5HLlOh/qnO3rbj775lVIjIY5qF/fkQGSXYcX95jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAIwUHMkEY4dp7YAVO/829FOMZlx+2CU9KcYXh2MonM=;
 b=SSXe/8qJosjIEDCHkdzfBsLmfIM0pk6YO3y+fY90rAEblkVK1FEpijMEs8M5Dy9++vmQMGAmFl5JzQlzco4RIH934lTwGv5cA0aUs7g6K5TRig8rbtcSgU+6N5zJXzoxH59fMOtB7D6ubTzbk3TjprijTRLK+V0K08LOBqcmBnBYSCOdenrscv8960TFP67+45Lk6wExFSRkWxpjUIrbzg9VHxkaidYmysbMDAPzGEaZydr20hS4lHrIl2O8PGJJcOsc3AyMcGlcZIMGRU0OUPTA0DVMPhRjF8ozvdVwFb87KsB/pOD02zOtW2SrEN7sOb+RBCdjMqk8gQvF09Npmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 38.104.251.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=semtech.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=semtech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SemtechCorp.onmicrosoft.com; s=selector1-SemtechCorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAIwUHMkEY4dp7YAVO/829FOMZlx+2CU9KcYXh2MonM=;
 b=gGpbSPoD15TVBQSBy/epgn6VBcQFUJ3qlwTBxs66Z1Rlj9JYUAeUjDH5x4kHtKPuUjYPlQO+tHvVj4jzI9i2NDu+FIghv/m0vvimjSvzE0NQOtlVCHJ3lZ90i/COSzWCRHfntx++VtKHqA+c7GI7cRbt78psm+7zXDYmq3zO0nI=
Received: from MW3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:303:2b::28)
 by CY8PR20MB5737.namprd20.prod.outlook.com (2603:10b6:930:84::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 18:46:19 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::4c) by MW3PR05CA0023.outlook.office365.com
 (2603:10b6:303:2b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.5 via Frontend Transport; Wed,
 23 Jul 2025 18:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 38.104.251.66)
 smtp.mailfrom=semtech.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=semtech.com;
Received-SPF: Pass (protection.outlook.com: domain of semtech.com designates
 38.104.251.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=38.104.251.66; helo=CA07RELAY1.semtech.com; pr=C
Received: from CA07RELAY1.semtech.com (38.104.251.66) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server id 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025
 18:46:18 +0000
Received: from ca08gitmail.local ([10.23.50.249]) by CA07RELAY1.semtech.com with Microsoft SMTPSVC(10.0.20348.1);
	 Wed, 23 Jul 2025 14:46:17 -0400
From: Adam Xue <zxue@semtech.com>
To: mani@kernel.org,
	jeff.hugo@oss.qualcomm.com,
	quic_yabdulra@quicinc.com,
	chentao@kylinos.cn,
	quic_mattleun@quicinc.com,
	linux-kernel@vger.kernel.org
Cc: zxue@semtech.com,
	imocanu@semtech.com
Subject: [PATCH v1] bus: mhi: host: Fix potential kernel panic by calling dev_err
Date: Wed, 23 Jul 2025 11:46:05 -0700
Message-ID: <20250723184605.128652-1-zxue@semtech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jul 2025 18:46:18.0071 (UTC) FILETIME=[1340CE70:01DBFC02]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CY8PR20MB5737:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7761024e-5174-47a9-95de-08ddca193600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?se9ARO89lmZiG7TyDmalm/SQ3h+jbo0LakCLW6M9C6+N6ggrgjkaWgJqej4E?=
 =?us-ascii?Q?jrj4Ql94iHRrdblvvOvFB5m2wIBsN/+4e2c+9TGU7OO3b/IxRgtmCtTzKGI2?=
 =?us-ascii?Q?99ewwL6q6uZC4CURhve0lsTo5R0lkqX88ilyRt2+v6jG1T92ox4Reh7kF/fw?=
 =?us-ascii?Q?nLiWSPgIEJ/8ig9KMWa/WFsmtLxu1lZHune+A0f3O/oQO76grjO0pAj+xHuz?=
 =?us-ascii?Q?sQhzyen1j/dKjymhgyBQNGi5NAagt+KBdsECi5AjfKsFpItOSpfPnVl+GJ4/?=
 =?us-ascii?Q?Q5GMaeqmYReBNnQgpHdXOo80K1iM2C2gh1k4UfE8CM8kNKzJSkp/c/hezoFj?=
 =?us-ascii?Q?nitlEvIAD5ZpreNNBVfc4TwBJV5jczsluqohM/FgPHVwvClaULuaE5JXzIBS?=
 =?us-ascii?Q?IojdjQ2XzUce1LtxdLfAxVHWyJlyoxSJaDH9hJDn5iI64huMImzaHYd/mCtm?=
 =?us-ascii?Q?2OKgzXG96ZYtB046+tAIObtrI2GduG6jNCo5uKTLZABn7yR2PPoAsi/grG2j?=
 =?us-ascii?Q?vh2X+RFsZ7wwyWSzVLDLXmCWCicyKZUNyPH0O7QTumrl5/J2zA/WLbRDxL+i?=
 =?us-ascii?Q?G280Lp1I4b9Wy130XbgojvMx62XWsusn/NejMO25VL2otDt2YGCRbcKPUbBw?=
 =?us-ascii?Q?kUfxPHzvBngONE74i49vSlzUO6U3UJDIyYWlQ159Sk7MLlSw7Swnt6/cTUvn?=
 =?us-ascii?Q?KF7CLVNECjBo+cvc8U4amrtUjfHFgCQjjKpjFCJ9uAUR6Hk/lIJyJX+h/PEP?=
 =?us-ascii?Q?5VA2i6JcyJpeUwoSGbqFZcXg24ByfpAlUPOmBFWQNvTMsXwdHu6jI7sSJ7ax?=
 =?us-ascii?Q?5YX2BSs9+CR3rZY/WLkCBhKrmZB/i+a9dTHcLTj+Lp9SjqeENMUfeHX8P94d?=
 =?us-ascii?Q?e/t3QZp21s3dNvp34DXZc3zIzfIJUZ26iq1MN4AbIJ6q+LqNl5/AHjTdTn0I?=
 =?us-ascii?Q?d7FLVkV9+MiSDPuCYxxgvKGqlkyWWalKCoOAUNcdn8p3phPx3h7pNmLPCbZX?=
 =?us-ascii?Q?WzeUiHBQnhRMbo/p+LP+iqY1nJlN/YV9RfayaQzXQLjKdhSXp3+Q8nkm2Fzv?=
 =?us-ascii?Q?Ed9z6YvD6L7TuHisHCduBZHf2RzQNX+3uYgiliOr7klqC3Tsz6VbbfLcaXwq?=
 =?us-ascii?Q?FsSwvZfVpmAbjPa2N2HnfHyesYvHakLVMkVGRcvPSilMtZwmp7soAzZeB7zq?=
 =?us-ascii?Q?wC4Gt9J2c9nGU42sN7AAHmC/LZq8W8aXBAjAZgiY/LKZu+DpsyXArBng6j5K?=
 =?us-ascii?Q?ecvL0eCRa1N1use6mxi4kptOTHMV94lqOT254uPvvjEwdu0ceTd+CWVOPEA6?=
 =?us-ascii?Q?4MraOd7yNyderhe/c815pWvp2xUnqGtTplAZdQDk27SRue1zBZAFFCyJIy89?=
 =?us-ascii?Q?CQp3O5Rrw0jh59Ro3MGk6dKaieL03xvKM+R4FZmIeh9WpWv1qihvzC/VXR/C?=
 =?us-ascii?Q?L2fjsk5E2L+8C1II4Ya82lZLddZZUWOwMYVVikGe+NC492WuhW/to4a5oRZJ?=
 =?us-ascii?Q?qtZGRgvGGyA1ETtpYol4Pbf60IY4jBu/R0TK?=
X-Forefront-Antispam-Report:
	CIP:38.104.251.66;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CA07RELAY1.semtech.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: semtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:46:18.4144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7761024e-5174-47a9-95de-08ddca193600
X-MS-Exchange-CrossTenant-Id: b105310d-dc1a-4d6e-bf0d-b11c10c47b0f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=b105310d-dc1a-4d6e-bf0d-b11c10c47b0f;Ip=[38.104.251.66];Helo=[CA07RELAY1.semtech.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5737

In mhi_init_irq_setup, the device pointer used for dev_err
was not initialized. Use the pointer from pci_dev instead.

Signed-off-by: Adam Xue <zxue@semtech.com>
---
 drivers/bus/mhi/host/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 13e7a55f54ff..93eddf302a49 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/wait.h>
+#include <linux/pci.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -194,7 +195,7 @@ void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
 int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 {
 	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
 	unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
 	int i, ret;
 
@@ -221,7 +222,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 			continue;
 
 		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
-			dev_err(dev, "irq %d not available for event ring\n",
+			dev_err(&pdev->dev, "irq %d not available for event ring\n",
 				mhi_event->irq);
 			ret = -EINVAL;
 			goto error_request;
@@ -232,7 +233,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 				  irq_flags,
 				  "mhi", mhi_event);
 		if (ret) {
-			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
+			dev_err(&pdev->dev, "Error requesting irq:%d for ev:%d\n",
 				mhi_cntrl->irq[mhi_event->irq], i);
 			goto error_request;
 		}
-- 
2.43.0


To view our privacy policy, including the types of personal information we collect, process and share, and the rights and options you have in this respect, see www.semtech.com/legal.

