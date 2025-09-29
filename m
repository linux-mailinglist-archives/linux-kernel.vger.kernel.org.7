Return-Path: <linux-kernel+bounces-835884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2DCBA8432
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6487E3A47CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD892C0266;
	Mon, 29 Sep 2025 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5o8bfgsw"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE32110E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131487; cv=fail; b=qnd7D9iZCCjm1t+FKXE72XH4iWOUmhfmJCCLfewY2aR+13GJUyV0nZNI9Ui2DbYxYFgoR4x8HjhVf872J8C1lbIS+qBfB5dQzWV+8i0/dheCL+zDqxCwOA5J0xE/zKGV4+8HLuCWRKgDBPEswEhbGf9wztrd8tMUbQLtYL8LzgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131487; c=relaxed/simple;
	bh=j8FbFWah58YYfeKebuiRq1Jhzz3FIWfiJr2aHBcXzF0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=slwc0Zt0tYkLJ+Qp4Rfc/IYUVMOqOPhGpqRnjV8M6lkWWcPadJx74oQPGofNWP/YS65RO6CW4Zf3IloQbJ8f/9OFi9B24UxPedbtYoXyeZA+FYDsDJCGidnCVC1992M38hUDzI+D3dSzASjEbvi3TV/xbDPPUY3nF5GDzveLQaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5o8bfgsw; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYu7H3Fb/yJR6g5zr8xptiPjqhvqmL9tSJHT2zk9JNycitZrQghS8uKjIC29vZRAmmXGDfOMN/EIX5ejCRtLrIdetLVw3jNfOCjHkhpJuQ5+m1g0et+1L0RW2PTBEB4yWm7MkTktmJHiVKnmSgosXahVloSce4FdSkeM6AiWXYXNbrnY5JuVuwGfRGTB4Pxu348yQtVwLz4ZGX9cj98Ux7rRpnKan3qcLPPUsI+S+AS98sHjOplzWnyS4paZ/7ULVQt7tU3tL5E1VKs83fdLQyU+n6c845Azia3n2PxgQ8AnxFOxUpGg32Bnsky2RxpeMltUsVe/H3Xq3Puspctgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MghdMgfTD1sb0lWNUBf7e7nF1/2OnEk41WHelh7XTsY=;
 b=Otbwt+cAHbMtvXswBPB0GaYua33y7+KpEiQ7Qks08GISETDNIfd7dDIwSTom6Dx1I2xxZdy3i9pe7tiCfNDiWk1F5QTSVLrx274S4iVNJ2EHnSkuzys0URdKEEohWwVKCiTwqricvA5OEx+ILgP5gT71+ptyHuFc222dIsvCDLKCEot4oP9D9bjE0CFzXOszTLPPG5qfKtTtWt4lDSoOFaP+hPgOfwZ//h1uOdoyEaDnJhtN0IYbNr/v5zzavmnOdOmuQ1zmXnImN0DFGp5zrhUnZ+B7eanD6rGZG2IdWk7w8cAjPPzExnJ5yhr8HbSxfIEOMjXYBSGjkIcIEPIdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MghdMgfTD1sb0lWNUBf7e7nF1/2OnEk41WHelh7XTsY=;
 b=5o8bfgswx0P71m/pxV7j1U+RnEuJNuXrEfAIjXSmKpnhMZQahBWbQ2WIytQGEnlN8ADCZaF5s+RBRy2x/sBS2O6I1MdmfspBqlIY/VLhuPiyJxfYs3NFjRydyEbKDaiQFNtLIpxnYLuqhfADxyRjFhabgsLwFfh+Xl1C6zIFkwU=
Received: from SN7PR04CA0103.namprd04.prod.outlook.com (2603:10b6:806:122::18)
 by DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 29 Sep
 2025 07:38:01 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::1c) by SN7PR04CA0103.outlook.office365.com
 (2603:10b6:806:122::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 07:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 07:38:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 29 Sep
 2025 00:37:39 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Sep
 2025 02:37:38 -0500
Received: from xhdharinit40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Sep 2025 00:37:36 -0700
From: Harini T <harini.t@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>, <peng.fan@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH V2 0/4] mailbox: zynqmp-ipi: Improve resource cleanup on driver unbind
Date: Mon, 29 Sep 2025 13:07:19 +0530
Message-ID: <20250929073723.139130-1-harini.t@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harini.t@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS4PR12MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0a28aa-e67d-4997-fd7c-08ddff2b1db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JVSATqRo3Pqy95u8Si4CZ09KINOcda8GEd3K9BM1VKwn10OdSgxMT2Fhc1T8?=
 =?us-ascii?Q?x16FeOXq/ehFnNPsvMgqXdV2UMY11FHA4ihWxptIa8s3927WlrpjOYzUUay0?=
 =?us-ascii?Q?nfjTKRLaVNLxM9gmlrYuaPPqxSuqPcF9YawV3hThETZ9WUfEx0SGHrzd2ivz?=
 =?us-ascii?Q?PuCv6kBPe0XnYCb1CYoDpkrdyMAjwxEbvVV65Te3x8vN59o2dnu12e1oZaOB?=
 =?us-ascii?Q?Xy+fbcOe8GwncI2KYVBy/eNc30tMECR8qkKS5W6DnXMvYmyYEbHFMfbdH5fP?=
 =?us-ascii?Q?tbN3Ql+Kj81UCx8NxrVUTIKBHjSdWQFkTuKkg0EpykR2jagWKNoUPglANlMl?=
 =?us-ascii?Q?Q7dS2KAECysY5OE1hpjMtYkm6RNezBZ9r4BcDwg/fM/YxC4XI4QG6imqvZCY?=
 =?us-ascii?Q?xytSk28lWIDliCq/nG2wqzzsPOZZDo1Up0E9UEuTOSobegikYcBNygtYmMSU?=
 =?us-ascii?Q?7r1tn9xCXB8m8Zgt2KqPLCBJXH7NCSizUPlV0Tb+O9kFI4JVxznBAR+4URAD?=
 =?us-ascii?Q?BJCMQZP5toOzM/zxWxrFCt55Vrq9i9t9LdAHwnekF4jkQSV+Y3xfhSZwvSKw?=
 =?us-ascii?Q?zPVRk8VFophfqsSbotmaDh/VErkvOvd/uHIjHCETGf+JYH+9izGlLC4/hLuM?=
 =?us-ascii?Q?QWZTA5jJk0LW3izpuAVarfBMoO85qG4fhF0AC/P4594QJqGXzaSJbCfabVYo?=
 =?us-ascii?Q?ZBDsxZ/7w8NfOMTLFVCvN3odmKRDsK6UGd4kvrU21TeXvuxint3009mrWlzx?=
 =?us-ascii?Q?jDCgcmQH+hf9/WB5fPXyJEP4B/jDFG9RipQH703p2Z5DPkgeS5iGq2sg5n0S?=
 =?us-ascii?Q?K9SiV+ePA48RKZNRR4iIxC4cF1gOHfVMVdo6Jy96HQBt/0X7dqc2HAhb1WMy?=
 =?us-ascii?Q?d+DmzcVGOskmvqL5UGWTG48HX2LzOBfA1ZSwPaxFK/gvZGNzCrM8IzCofaQ+?=
 =?us-ascii?Q?0rYg8XKlVDkT7l7HQQ9mqV2apdTOxBQ2Ww5bBZCMFXk5tVSBVhVZNGIA9Cdh?=
 =?us-ascii?Q?oKlkoVDTXX0Qp4gh4ZRlc5XjSfIjPDucv5wH776LZ132lW8qwA69kvEw50+X?=
 =?us-ascii?Q?UWeGEoflfbtZ22tq+qSIQo4qxt4nfvYbhPRKomXsgWmVoEnVangH4/8qG4Vp?=
 =?us-ascii?Q?JjUD8xaQ2p7wL9cMWj/dkTYUBvY59w9tsS5HfXYqAQ8g6t3wZJidEaCrNjMl?=
 =?us-ascii?Q?eYL301mW9EuOz1opWEy2nuXBXHhoC/9hjKqbX+0VkanwCVGCm80eAzSiyoZt?=
 =?us-ascii?Q?lkRiEThtwEgQPRSWKqRb7qTv0B8+ViO/0oev7W9ZY3UPzPcsz7+L9f4xbOTV?=
 =?us-ascii?Q?Y8TopbC4IEI8FMfkNADkKu+LySlvB9tdXSSyPomeCJV3kwN/C8kY4R2RoxAS?=
 =?us-ascii?Q?fehWVtkVK/y0EBXPKB+pWwQ4da878mUIbr39ObD/2wzKgKuJ6TcKFFXncrxK?=
 =?us-ascii?Q?FVe2qHdCJHNEJW8CTqa4/iQ4WxdtzVMuV+EtYV9eiJRVa9fM54VDgTYqH1Ds?=
 =?us-ascii?Q?b/adsY5l2cZoiCLTNpVAWSuXJJWEGcpWaqCCgt3DC3m+nXMhL05FjC7Q3Vz4?=
 =?us-ascii?Q?V9e2ovhhadUukBiW4Tc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 07:38:00.2718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0a28aa-e67d-4997-fd7c-08ddff2b1db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9587

1. Remove redundant mbox_controller_unregister() call, as
device_unregister() already handles controller cleanup.
2. Remove ipi_mbox->dev.parent check in zynqmp_ipi_free_mboxes() as
device_is_registered() is the canonical and robust method to verify the
device registration status.
3. Fix the mailbox cleanup loop to prevent out-of-bounds array access.
4. Fix SGI resource cleanup by using an explicit irq_type field for
reliable SGI detection, replacing the unreliable IRQ number check.

---
Changes in V2:
- Address review comments from V1.
- Patch 1/3 from V1 has been split into two patches in which the first
  focuses on removing the redundant mbox_controller_unregister() call
  and the second focuses on removing ipi_mbox->dev.parent check.
- Avoid using i-- as the 1st param in for loop.
- Avoid using variable name in the commit message for patch 3/4.
- Add Fixes tag for all the patches in the series.

V1 link: https://lore.kernel.org/all/20250822045732.1068103-1-harini.t@amd.com/
---

Harini T (4):
  mailbox: zynqmp-ipi: Remove redundant mbox_controller_unregister()
    call
  mailbox: zynqmp-ipi: Remove dev.parent check in zynqmp_ipi_free_mboxes
  mailbox: zynqmp-ipi: Fix out-of-bounds access in mailbox cleanup loop
  mailbox: zynqmp-ipi: Fix SGI cleanup on unbind

 drivers/mailbox/zynqmp-ipi-mailbox.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
2.43.0


