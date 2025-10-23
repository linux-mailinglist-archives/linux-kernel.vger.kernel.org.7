Return-Path: <linux-kernel+bounces-867742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA980C0369E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCC31359058
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7B257827;
	Thu, 23 Oct 2025 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="m0toxKCe"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021125.outbound.protection.outlook.com [52.101.62.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9F1DE3C7
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252289; cv=fail; b=aXhm7gjfz2Z0xi5p27l8lRrIYlHM3YpPynqwCcMBFJsKfPbHq9y1u6mlo7hW+vPwDMysyFhmcGbzJVvajccL8tOMqdNUyBG/s2eN5HwZkS0mzo/lg7w7eM3SqpYywat+h5chZTC+ulBWN/gw7KHamGxvPdaAMR87FU+gSt12nlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252289; c=relaxed/simple;
	bh=0iKtkThaa5m3OBKRVwMo7ecO0m2qghpW+jg3qsdZrrY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rMtagneG48vLHHPalGgepc5G14HreGVHy0EvI/a0gRg6vv1qlggQJ7zMo1CMU5aF9fyuFkT/gxMMYWMJyy5jnxuVbL6tdIxMF6+SGvTd3AWseICHrx3QzoFBTm+Ae2iuDwF87+eglvC+waBaG9Xr9SOSbfHUvCJ5zGh/lKe3pu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=m0toxKCe; arc=fail smtp.client-ip=52.101.62.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYnYCfxHvdXCVN+zdY65sZv62Y3VR9uQxB8GtLzLRyvi3xo8jUiS7cSWZkY8P3I5Ru+tlLY40B9sFZpR2KJnlBqmtdrViAsVGtzNe3kmQPJNKja3Q6x3v3zczesl2BKif8CCWt2IuH+bFDn1b792HSX2qd9ItLXbXzqtA7f3wfOfrnZUNeFzUU8nISUIxF5lSALOdyMxLsqYfkJIa57owOS66ZSoZ3FLosi7B7rZ0vqJyaZZSPWVx1DVWmOKkVvn+0mY0mXqqOzAjTJ8jxVhb/K9UjPgyzTfs18mWbzVaMlzfFSs31XnwKViUWpwS3rnSePgUxgi8G3gbM/ZPJ/pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scKTK7HmfSqvk+yCxz/18MERl7LT5+xEquhhRKcaSSw=;
 b=PcACM70tX+HT52xz5tH7j6PoNSrk1re8qWAROIQTf/pGNoEQrZ0RzsHLaWARBdtdv8cJ2J9yyxqNYc6RC4v71gfm+cecVq+GY9HtpTnnRCZLkuScxRcvOI+8wHpCi/v62qaV5TV9uAnyL6q9+hnK/Ttl68KsUkId1XjQWYaRU3d8wa8aD/vPtxRVcwncNTA7ZSUYdYUS9hzFOUdoHZ/V7SFwedME9IweM1pzeEhvyPcFI7okJmav4ha7utl18XfHSplbSHqUoOTu3bTTDFN98fUhr7679mFrGzPdllHnAvXobUJoMgU9JU9kP2c6Bv/KUbRkhTj4FokkQ3/NM0CtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scKTK7HmfSqvk+yCxz/18MERl7LT5+xEquhhRKcaSSw=;
 b=m0toxKCec4zziHog68HAQudc0faEeUA8tDIaPJ7tb3kWsU0Xq9kIY0SLu6KJGPRxRixApUmfwILE25UiVwQTW+y7o9BC7x0hFglgM+rRr87fBWWONrAIxzr2pnzunbo317yfT+ODXEKCn/uofyR3FP2T4FfciCqsJX3jduflOAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB6733.prod.exchangelabs.com (2603:10b6:806:1a0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Thu, 23 Oct 2025 20:44:43 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 20:44:43 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	dev.jain@arm.com,
	cl@gentwo.org,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH] arm64: mm: make linear mapping permission update more robust for patial range
Date: Thu, 23 Oct 2025 13:44:28 -0700
Message-ID: <20251023204428.477531-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:930:89::9) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 7216001b-944c-4129-aaba-08de1274feab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5sqpSyYwWrXH83BCjUU78H7UYdUh1tuSXz6KKJp5yZLVuMa7rlIVLRW2zeev?=
 =?us-ascii?Q?2nV7dHC+ud92CMsyPdBRgR4YLje1prCkvXjpx/vslhu+HJhxxI0Wfh8bt+qf?=
 =?us-ascii?Q?uQoDr4xrirDLDT1PWm29gYFCkyFZRBSAhXxfP4lDDA8QM6z7S1/bpvyukx8x?=
 =?us-ascii?Q?Pu4+cqgO5QixcuIjnsd+NGJjykqSs9KhX3PL/3xS9itY/DCBhr8ZglJKdfp5?=
 =?us-ascii?Q?D2JHEdi9ZSUJpZyBws0N3y+a1fdrk4C+T+FaaZw6Uy3BPLG0edcDtWoTS6Nm?=
 =?us-ascii?Q?c6JXNCZbIIw8j+MaXGYhGAH0n5iV6jeuLUTMoorojCRZMiXBz83w5O4h0qai?=
 =?us-ascii?Q?GdyORe4nl9cpJQtUhqqrjHuPl6rYyb9BHhC4HKIQDhTy1Jfi3juqhoYF5Axv?=
 =?us-ascii?Q?Y17ESPwY5NpCDt6rDQdHGOWfsLK3MA3fV6sp+NVu8uft9oLWr51MsLB2qTGZ?=
 =?us-ascii?Q?HuyIHTJZXY/x18ZBvfE8tzdcZomUg9v6lgOPVJSK/Zul84bPXdBAY6TT7ASs?=
 =?us-ascii?Q?2eixLgy/sOvG2rQNL8xSUAsFDE7SQ3CC0TW7HLv287xhOUvuvfpOzmcENERU?=
 =?us-ascii?Q?/vRbj2KPd55rWN7T8BDJn5Mp46IQnMnec0oZXNfGoIdW8OWpR/wTmQOQdY4l?=
 =?us-ascii?Q?6tVe7K/1cx11y6FaBRU5SfBSGHm9uOnUz8gE8uKbzL5PU/uda7Dh9o/jS74A?=
 =?us-ascii?Q?pOlsYLRN1+Du9V0WLwQsFUlcNZ1nXFOtVVuSC1pwNNpOP7quNmvFLh54OzEz?=
 =?us-ascii?Q?EwzlQMDcXE3yobZOp4xlttpItG54yCqvJX1lSzJNe7kkBkuvzByC7RqmsqAx?=
 =?us-ascii?Q?b27mGIDnk/CwimBAdSZLEYATiJz78OJW0L565Wf0MKqc1ahEkRMiXGYNz34t?=
 =?us-ascii?Q?81SZceDZCLnLZGL/cZ++9C2OR22YyJgTYtC99uCNLX1611V6gKzVAzHSTWod?=
 =?us-ascii?Q?Qm3/xaAOzVXBIMeazmaN6vR7pJxskjkR8mcBqWpdSL5fGuOPwH8WRtn/AduF?=
 =?us-ascii?Q?bSB9/Y44dw2d09kmYd3uQ1f4xnLueSeo2wxIj/emMxznx3928q44YBEs6HLw?=
 =?us-ascii?Q?d+0qmrlAP3m7+yIPfUbTPX7T4aDacJ2megrRH/NPlZxhowxkKbpvVChQQktP?=
 =?us-ascii?Q?RSy0F2xcMOCELe5NK1R/0HFTkxB7gTc9tKnFZpHuoGERoSeIguyLeJLABykP?=
 =?us-ascii?Q?fB5GuwCKWNkAhSawpfiBtIGIQePbKa8qd4hVfL3W4q/sGYvddZyLFtwXDeqs?=
 =?us-ascii?Q?kV4FBMt4NB7Cf06HF5kFx7p5gqQQmoIp1tbvEXU5CTLw1CSBgy0fM9IF1yoT?=
 =?us-ascii?Q?21jicOlxzAOs6bNe9L6Rm3nwb+ijhAbCZ+WbvzYnym40rlctUoHrXB+txGT9?=
 =?us-ascii?Q?kVR9g3PETcLXmZ7AMN9ms5IXSYNiw/v/u4iiGZIH3zYqvymksmDTL+t7NSBm?=
 =?us-ascii?Q?A3PVscRqk2C3kIBtnSywQg4odGnvnLXn794y+Q2PkSQ/UONJ3IG85v3WX0rQ?=
 =?us-ascii?Q?BMuOkaOHy16pCMtZkKeGptfaM691Lw1UKhbd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkjRjpINZKKlCkm+2VbxjTf+a/XJml81Fq7KXFRuGFIN8WFa+rRewqHf7PUV?=
 =?us-ascii?Q?KcG1uMB4gAAtHUxyCQ7TJZNTsspOGjCqWrOijfY0LoPQmyx+smH3YSwxHoOF?=
 =?us-ascii?Q?jlTPbuuBkY3vd1a2WxQWYQOvgsomNdCLewBOPKnly1c+kf7E9jiGiu/6dSXQ?=
 =?us-ascii?Q?LCdPmqdP6p9aw4BtCDBGFQVqsNtceUnFmngIRzM7/poxM+j2PpLIzA2T5Xcw?=
 =?us-ascii?Q?P+d+FWMZgF4xQva2em3gDZ1hvGYDs+rnGb7rg301K0n91Y+C51+FVJIJvSOU?=
 =?us-ascii?Q?hZKj1XL9R55sY/xmpWsfddbxgWRwyE//WdVRedZJM5SoI85TysLIHPqMxQp/?=
 =?us-ascii?Q?hUaKHCPiVafFOHLL4r/Jzfhkn+Drsr0FHEddpP9sXe83V8s57pX8cMajc9rq?=
 =?us-ascii?Q?tYi3yKeK7usc8SLYmGlpmHhFMPPuWODnRxTDvCBXlsAqcScIlQs38Q/WOpWW?=
 =?us-ascii?Q?qwVJYx77TH0y3S87puUl9809pKtzRU0a3RfZgse4CMliCR4HiIiSS6080FHX?=
 =?us-ascii?Q?Z80KYIB7nrekvuVFvOK7Qq4UtFReGM50vxX1YHb/Oprxww00/+xr83SMpNy9?=
 =?us-ascii?Q?QuTuADZfXgik7jXuj/5QoSFR5o7o/5NONA07/5VMMeWUvI1dPwwrHG0AGZif?=
 =?us-ascii?Q?daxJIEOR4K5FcLwaJLOMKV/1Vb4K/q7sq/iICtOgziATOeZbcYDwcL9D22mT?=
 =?us-ascii?Q?9SrNbQezekcbIHLqTvVyHl9U9u09+YxG8nVkE4uM5z7a0ZdeV+5AF97tGSU+?=
 =?us-ascii?Q?cEMl9tJ8kR+cd1FIDoV+41VttQOnam6iO10NWvQWoPqt9BPuv8VQnrxB4AdI?=
 =?us-ascii?Q?3yA7DF1V5576q7eICrwrsYCPNJXlmkYZauLQyTWQpmvPYmXVQ0bYZf5jaKXF?=
 =?us-ascii?Q?teA9+NzfKjklHK9aPTT104o0hptbjGyUvjrx+Qlo50iC5DI1axz3dpgIv83p?=
 =?us-ascii?Q?ySgYjlDREBDdLRd4fjwQwK8e/wl3E0m7eA+U+s4KXp6dFNIZmERM1UCa2HWl?=
 =?us-ascii?Q?Ym1q76Cjdlie8AAPlpMmEWm5dzlm2P0euzAxoNd70SJJrE2fyy7mrG9JsxBZ?=
 =?us-ascii?Q?I7Qv5kJnaiEZYNDPjcruf97EMVwy4zfo/lfZ+B8P5scfQCVBf8e154vj7MLF?=
 =?us-ascii?Q?sBfpDCVbkie54tBg26QfHIFOsSMhZIPSfS2QRd+GlIV18BgkOAQr0Nj9b7mO?=
 =?us-ascii?Q?vNBP3RylO8G0TYJP6qf2TgHn9/ycr1BZGOnoIvO/qs6QLzFibGo3nzOOZgv+?=
 =?us-ascii?Q?fnTc3URoJQ8wXn/LqrQSSz89OPWhh4VcUWlvcJhAf8elKe3/BvKVeq20rEd2?=
 =?us-ascii?Q?kef6flT7CkCfR+SSc8YejjGdI/MBgXWj7YduDrB8X2XBHg0NGktYB7nu7yMQ?=
 =?us-ascii?Q?lO80nY9L7o55Kn2mjnNMXNTFuIkvwpNmMTnSSJvRAzg+vTFFjXCEdAaDg6pi?=
 =?us-ascii?Q?F0giat5iGxUjyqwTrm6gSfRgy1iU1cdecIMjhZD86BCttB6J9ONwIkIYQUVt?=
 =?us-ascii?Q?yDl5N2EIzI0aConC8tq1gzKFTM+wMmyBJi7/qb82sUNnpFrWDxQO6bxr8p/4?=
 =?us-ascii?Q?+DtDRcDP4rrqpY4VujmtxMnObL1bYvnJGmzygyv3J/+A/3Rb4Qtid2dzZOxm?=
 =?us-ascii?Q?99LCEdQitI6K6+Fy60vkvMo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7216001b-944c-4129-aaba-08de1274feab
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 20:44:43.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyt1M+Jz1gsTDzPghtbjHErv3Qi9SrVpVwXjMbLn8nzwj7SpbpAqoUW7XpnTeZeEGng21+6lssSawUq+k76bZSkmhffL7dIEdx5cu1QkMEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6733

The commit fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when changing
permissions for vmalloc_huge mappings") made permission update for
partial range more robust. But the linear mapping permission update
still assumes update the whole range by iterating from the first page
all the way to the last page of the area.

Make it more robust by updating the linear mapping permission from the
page mapped by start address, and update the number of numpages.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
v2: * Dropped the fixes tag per Ryan and Dev
    * Simplified the loop per Dev
    * Collected R-bs

 arch/arm64/mm/pageattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 5135f2d66958..08ac96b9f846 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -148,7 +148,6 @@ static int change_memory_common(unsigned long addr, int numpages,
 	unsigned long size = PAGE_SIZE * numpages;
 	unsigned long end = start + size;
 	struct vm_struct *area;
-	int i;
 
 	if (!PAGE_ALIGNED(addr)) {
 		start &= PAGE_MASK;
@@ -184,8 +183,9 @@ static int change_memory_common(unsigned long addr, int numpages,
 	 */
 	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
 			    pgprot_val(clear_mask) == PTE_RDONLY)) {
-		for (i = 0; i < area->nr_pages; i++) {
-			__change_memory_common((u64)page_address(area->pages[i]),
+		unsigned long idx = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
+		for (; numpages; idx++, numpages--) {
+			__change_memory_common((u64)page_address(area->pages[idx]),
 					       PAGE_SIZE, set_mask, clear_mask);
 		}
 	}
-- 
2.47.0


