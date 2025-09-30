Return-Path: <linux-kernel+bounces-837931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8350EBAE164
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964A34A773F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F1253F05;
	Tue, 30 Sep 2025 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p0JRLO/l"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531F23BF9C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250855; cv=fail; b=nnL5I3g7h0ojaSTF3OCcWtIJE5/Cfdly4TXeF5LQBxcGsG9+zL15K0KGS9zndSqJbK9iWQMAMWrtSj06LLzd6mN7cqLdL0HTpWCT4/TOMhoGgoJNC5ClxZ/MKFDmSsY7w6qNTKlbfNzqOIjBfXMuy31vtex2nyzGGbNSEwaMpPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250855; c=relaxed/simple;
	bh=NxN9gtWA0zgDztaGwKSqeTCbkGGQ6b4Ucpqm64icpZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rjK1u3vhqXDQBJCAjimKNyGYweJuasF4mjsjbohBBk5zlTn2caVCb+anwko+L51Oc6Tc2zyYvYSVT6DyKPkpknEIn8TmqahZrf/oDDsmyQeTXA4WJCMIUWjNwTMQzJgAxghzbGOzkFp6e9oIfLgGFahG7rKWNH1SnPwgq4qlfiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p0JRLO/l; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbYapdb/k5HsNhc5EIFbpDFP0f0aF9X/y86OvAr6jTQlq+mdQZW/qYxtvdqDcOluXWtc5VJGr1p0B9AISfszUT+y9Z+YcgpI9QbzaApqVjeb8T+QbxWBtujW9mwjSziK8pouRNGKO6+Hq6imCxO7qyjDuZq2Hg1JlgzW34dbgZUK56KSW3d0KDarhrYkJ5lObvSBPy73bPOZ/DSx/NwaixeMsEW/0VGaHoUJNFqa5fWm3F4Nw/fhGPo/GuQf4zY4I3owywFN9PmUauxwyD0p6zT0w+1w7ZuqToN0GxbwzOcYhyspPG5mzPfXRptqaSoZNKgfbtM/ETt3Ib1Gs2lELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDyEWeDuVewZ+K+KlCKClIdLCNIuK7oGm0cq4v+OU7c=;
 b=YHtX48og4PE+WQSMGbOYcloK39QEZLH0tD13IY844e5UGdK1oe1cINJtg5Z523GR90BfdDSOzuEQVyDryOVZN14jCaj7CEcSYXferia1cGw0BeeXWiGjY5izEq31lO0h9TgiBlB9H+bzKwZeQyJePTNJBNiV2IyRJZ8/gdZ1Oxqvc9R/eYD8C08y9aJxYu6XpUB163sl7xaesceGphKu8MlYj8OyblYMMX67fX46T27P14AR2v8zrMja5rlI9UapvlMoyHKjo4Om7BG71wxaiKLUktkReSV8eqkPiczsZmkaAJFhU6Gka94gAexClJ5roHDpH37AhoQaR27zVby7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDyEWeDuVewZ+K+KlCKClIdLCNIuK7oGm0cq4v+OU7c=;
 b=p0JRLO/lwTodz8ZB0IHD7+3H5lrTejFlh7LLIqIbIOg2HEaj8qmxcehEkuy60nQa3AD03UWkM5n75307069ARzV18zMHJUK7FD7cQf3E9qtLqFmppYgBsHA7uin6woGBO3sOfF0K4x0oFSbal/Ta47kHrd0MWjfnke1H6Qb9uxY=
Received: from SJ0PR13CA0077.namprd13.prod.outlook.com (2603:10b6:a03:2c4::22)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 16:47:29 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::42) by SJ0PR13CA0077.outlook.office365.com
 (2603:10b6:a03:2c4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Tue,
 30 Sep 2025 16:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 16:47:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 09:47:23 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 30 Sep 2025 16:45:45 +0000
Subject: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
In-Reply-To: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
To: <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Filip Barczyk <filip.barczyk@pico.net>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4f50b2-d4a3-4af5-885c-08de00410abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2pYYnBySmJnVXRGR0c5aUdEcXEyTzY1Wm53aHdpRE5xSmgxZnhBYklIMlhm?=
 =?utf-8?B?WldFMmgxYmpTTjU1d0dDOHAyREdkYUhLeU5QS2k5R0lTQVVaSmU0cTFucHVv?=
 =?utf-8?B?KzB4M3lnS1JwSm5PdWdkWkpmSUlRZGd2SjFNVWRYdEZoeVVEUkdRdEZ6azFV?=
 =?utf-8?B?RTZYUFE2L29VemE0VnNpdnFpOFlrQzUvcTZQL1dqRktyRkxFUEEzZWJxT3Jp?=
 =?utf-8?B?b1ZRMVZxcWFiUjFINGVPa3U0RndWN3p5Vk1UVUtCSVJ4azVYMHBkVUlrU1JD?=
 =?utf-8?B?N0VNY3N6cnJQaDYwZkNRaGI4V2lKRG1JaUhONjd0cDJSV2tpeEFuNk1iaC8w?=
 =?utf-8?B?eTd0cWcvL1dJQkhoNTNCckVybG1RRFp2ajhpSE9TYzJ4RUVMQjBJbDJFY1dP?=
 =?utf-8?B?eWpEa1c5VDBBMEpSTmlHb044aWRSQ0M2T05nVWtjcnhZbEJMSERucXBmY1Vw?=
 =?utf-8?B?Rng5TS81SlFscXVlaHNlR1c1cjJUNGNSaG5BV2kreXExbFFIT25nNktFQ2tQ?=
 =?utf-8?B?ZDVMYzMrd1R5M2RmbXlDekVJQjdLa1BrQ0RvOXJ0RExLdTlsR0NCQlh0Wm80?=
 =?utf-8?B?dklRNXhUaVA2MTRFNTNMczBFWWxXVzBRLy9PbEFBZC8wdHBydDlKT3lFZXZR?=
 =?utf-8?B?WTNmSnl0dTlYdHlZUkxXSXRVMjYzb3MyZmtiQi9MODRCVEZUYUxtRUZWQzh5?=
 =?utf-8?B?c29ZOVVuRXBnT0d6MHI3cjJ1TWswZkpqUS9xZGFlaTJNbExiYkd6TnJTQXJV?=
 =?utf-8?B?MkpsT0N3eTNsSHpHZllwU0ZsZW41MW9raW5pejhVbysrdVgrMndtSmVRQ3c0?=
 =?utf-8?B?UmJBMTdBeFhqSHB4QzVBKzZTZW4vMmxTc3Y3VDlHWVZuNTVGTDJickttQ3BI?=
 =?utf-8?B?SlRIWndpWk5XbXpJVVRucmVWSTZTUjVuMTlXc1RZMzAvNGJlWTk0NFM2ZGQ4?=
 =?utf-8?B?cXorZUZyUk04MDlTRk9zVkF5SmU3a0RLYWNpOFRreFR2aU11UmY2YTRCTXdu?=
 =?utf-8?B?Wnl0cXM4UmJaNFd2UFZBeGYvNDE4RnFkY1podjdGWGJQdWtaL0tKZ1R2d2NI?=
 =?utf-8?B?ZENqT0ZrVU9jSHFYN0pDcnpZWVJnUnIycnNaRWVLTXlBeUlCL1cxaDRvdjdJ?=
 =?utf-8?B?OE9TKytDYzdnbHhJeUpndGU5SERscGRtWGJZY3gxYjNoSWVVbWI1WFJUOGdE?=
 =?utf-8?B?U2Z6WjBLTmFMZjdQZkcwTUpYdVk3NnZreXIzcEpZem5EbmQ5dDZidktNQWZj?=
 =?utf-8?B?aHo0WHgwZnp5WVZXWHU4QktDN3ErR3MzZkpiZVh6YkF6cXp3NVAzM0VzL0E2?=
 =?utf-8?B?Y2lZeXFmdlF2cyt6SkcyeTR2Rk1NYnR2UmpjekxRNFp5a05KRkQ2bjFiK21Q?=
 =?utf-8?B?ZlFLdGFUT1dLTU9MQkExRDRVNkpMbDZwSlhqeDNwVktYbjd0c05IU2ZLQ0Qz?=
 =?utf-8?B?QlVMMEg1T2E0RFk0d1NqRjV3MytxdjhRcGZyY0tsZTR2bEJRMFcxNXgwaHFC?=
 =?utf-8?B?c0gzdVZZNStLbUg4TE5KRFRnRGR3bytDNUVTeHBJSGxvVmhCTVdCem9zUDkx?=
 =?utf-8?B?Tk42VHlsbHJXZzJwVUtzQSs1NzlSMUZIUVBYSXY3S3FVQ1NmbmVXV2txNTV5?=
 =?utf-8?B?Und2Q0RZbFJOK0NTMlZGNk5td0xkclppYlY4WjJ2bS9ENkIvdE5wUDVQRWJ0?=
 =?utf-8?B?ckJocnJrTUNTZEhFaWpzOEVFZTB6T1JkQWkxd2ZSL01FTWxCeFA5MDBGb1hX?=
 =?utf-8?B?Q21Sbk9FaFlwNVo1enV0bXNlV3NRTWovK2JiOFUzSnk3Y1FTUVRyekZmdFJ4?=
 =?utf-8?B?RkczT09GSjNjaFo3Sm9UdE14NUwxQ3RxSTYzdnJKeWdnSERaR29mSElERUVi?=
 =?utf-8?B?cmYzWnhrdGZZck5YOXNhaGd5cURIZGo3eTlkd1lWUUhja1duTi9JNlVkTEZL?=
 =?utf-8?B?M0JYQ1ZkV3NqaGE2L2NzQmJxYXhYOUdrM2VoaGVGcU1zNlljeUZLMi9NYkJ4?=
 =?utf-8?B?QXBDdXJPWkFRMkJ5Ti9nMzBRRGEwR2VKeFFXRkE3WEVnS3k2VzNTSXFUcCtU?=
 =?utf-8?B?S3RzK1RlZjg2VlF1WDJuemcyZk5YY1Q0Z1VVYXZkUU5yRGtwUUs1SUV2RjNE?=
 =?utf-8?Q?YhoE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 16:47:28.4993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4f50b2-d4a3-4af5-885c-08de00410abe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808

Recent AMD node rework removed the "search and count" method of caching
AMD root devices. This depended on the value from a Data Fabric register
that was expected to hold the PCI bus of one of the root devices
attached to that fabric.

However, this expectation is incorrect. The register, when read from PCI
config space, returns the bitwise-OR of the buses of all attached root
devices.

This behavior is benign on AMD reference design boards, since the bus
numbers are aligned. This results in a bitwise-OR value matching one of
the buses. For example, 0x00 | 0x40 | 0xA0 | 0xE0 = 0xE0.

This behavior breaks on boards where the bus numbers are not exactly
aligned. For example, 0x00 | 0x07 | 0xE0 | 0x15 = 0x1F.

The bus numbering style in the reference boards is not a requirement.
The numbering found in other boards is not incorrect. Therefore, the
root device caching method needs to be adjusted.

Go back to the "search and count" method used before the recent rework.
Search for root devices using PCI class code rather than fixed PCI IDs.

This keeps the goal of the rework (remove dependency on PCI IDs) while
being able to support various board designs.

Fixes: 40a5f6ffdfc8 ("x86/amd_nb: Simplify root device search")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/amd/node.h |  1 -
 arch/x86/kernel/amd_node.c      | 95 ++++++++++++++++-------------------------
 2 files changed, 36 insertions(+), 60 deletions(-)

diff --git a/arch/x86/include/asm/amd/node.h b/arch/x86/include/asm/amd/node.h
index 23fe617898a8..a672b8765fa8 100644
--- a/arch/x86/include/asm/amd/node.h
+++ b/arch/x86/include/asm/amd/node.h
@@ -23,7 +23,6 @@
 #define AMD_NODE0_PCI_SLOT	0x18
 
 struct pci_dev *amd_node_get_func(u16 node, u8 func);
-struct pci_dev *amd_node_get_root(u16 node);
 
 static inline u16 amd_num_nodes(void)
 {
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index a40176b62eb5..4a3d9ca6e225 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -34,62 +34,6 @@ struct pci_dev *amd_node_get_func(u16 node, u8 func)
 	return pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(AMD_NODE0_PCI_SLOT + node, func));
 }
 
-#define DF_BLK_INST_CNT		0x040
-#define	DF_CFG_ADDR_CNTL_LEGACY	0x084
-#define	DF_CFG_ADDR_CNTL_DF4	0xC04
-
-#define DF_MAJOR_REVISION	GENMASK(27, 24)
-
-static u16 get_cfg_addr_cntl_offset(struct pci_dev *df_f0)
-{
-	u32 reg;
-
-	/*
-	 * Revision fields added for DF4 and later.
-	 *
-	 * Major revision of '0' is found pre-DF4. Field is Read-as-Zero.
-	 */
-	if (pci_read_config_dword(df_f0, DF_BLK_INST_CNT, &reg))
-		return 0;
-
-	if (reg & DF_MAJOR_REVISION)
-		return DF_CFG_ADDR_CNTL_DF4;
-
-	return DF_CFG_ADDR_CNTL_LEGACY;
-}
-
-struct pci_dev *amd_node_get_root(u16 node)
-{
-	struct pci_dev *root;
-	u16 cntl_off;
-	u8 bus;
-
-	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
-		return NULL;
-
-	/*
-	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
-	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
-	 * this Data Fabric instance. The segment, device, and function will be 0.
-	 */
-	struct pci_dev *df_f0 __free(pci_dev_put) = amd_node_get_func(node, 0);
-	if (!df_f0)
-		return NULL;
-
-	cntl_off = get_cfg_addr_cntl_offset(df_f0);
-	if (!cntl_off)
-		return NULL;
-
-	if (pci_read_config_byte(df_f0, cntl_off, &bus))
-		return NULL;
-
-	/* Grab the pointer for the actual root device instance. */
-	root = pci_get_domain_bus_and_slot(0, bus, 0);
-
-	pci_dbg(root, "is root for AMD node %u\n", node);
-	return root;
-}
-
 static struct pci_dev **amd_roots;
 
 /* Protect the PCI config register pairs used for SMN. */
@@ -274,16 +218,49 @@ DEFINE_SHOW_STORE_ATTRIBUTE(smn_node);
 DEFINE_SHOW_STORE_ATTRIBUTE(smn_address);
 DEFINE_SHOW_STORE_ATTRIBUTE(smn_value);
 
+static struct pci_dev *get_next_root(struct pci_dev *root)
+{
+	while ((root = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, root))) {
+		/* Root device is Device 0 Function 0. */
+		if (root->devfn)
+			continue;
+
+		if (root->vendor != PCI_VENDOR_ID_AMD &&
+		    root->vendor != PCI_VENDOR_ID_HYGON)
+			continue;
+
+		break;
+	}
+
+	return root;
+}
+
 static int amd_cache_roots(void)
 {
-	u16 node, num_nodes = amd_num_nodes();
+	u16 count = 0, num_roots = 0, roots_per_node, node = 0, num_nodes = amd_num_nodes();
+	struct pci_dev *root = NULL;
 
 	amd_roots = kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
 	if (!amd_roots)
 		return -ENOMEM;
 
-	for (node = 0; node < num_nodes; node++)
-		amd_roots[node] = amd_node_get_root(node);
+	while ((root = get_next_root(root))) {
+		pci_dbg(root, "is an AMD root device\n");
+		num_roots++;
+	}
+
+	pr_debug("Found %d AMD root devices\n", num_roots);
+
+	roots_per_node = num_roots / num_nodes;
+
+	while ((root = get_next_root(root)) && node < num_nodes) {
+		/* Use one root for each node and skip the rest. */
+		if (count++ % roots_per_node)
+			continue;
+
+		pci_dbg(root, "is root for AMD node %u\n", node);
+		amd_roots[node++] = root;
+	}
 
 	return 0;
 }

-- 
2.51.0


