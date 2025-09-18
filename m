Return-Path: <linux-kernel+bounces-818754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EC3B5960E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549F11B2872A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94F3191B6;
	Tue, 16 Sep 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SYlsqZG4"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D6313E3C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025349; cv=fail; b=XvKX+AG7IGztCmrXSWCirD/oOzEw7oZu0tIB8zhs4CX1qGPcQSDdpoebC2hYZrcOVl6sCZKh8MrKKqtMvJeOwTyZ/7d/QpbDresWktlGv3evAVS9nRZQA9XtsGkE4juUJbveeOeFSJEznmig2B6Osy8E988YlGp+PIIrjcNSZpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025349; c=relaxed/simple;
	bh=wutG/mkHBhffsrprm8eV4qd83bZwDHeC7cJraYMi53E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acpshnuNFJ0BPwdzAzOWpU6Nf+fqtl+Gg0Nke+CS+EesefJ/HO40wL9RnmhUc2Z6MXNcfQiYKCePoirpv7Gi3UY1ucN4mKGJUvTe6CKXTPNuqGYHcaOmbGgZysPMd8S57wC6LHgRCCJGtWNLASzeWMzp6RsJWeByLyR8SRDiCPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SYlsqZG4; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe73V/toIq+dlCigXv0PLBTuwixOoBN9sgH6DiVF6Fiy3FpAJCRmiCXbwr60KlPLoH7WfuBzdkUpeiBtjgl0AbyxYhQQ2hg/rsj+EIQ1y/GF8zFb9whAGDBPsUcYMh5xnKTssnkB9GOic6osq4bwC2V1p2b7E0CfJdendvAvFOx7xClRhB/WIgbEvTo7z1KxbcozWDRmN7hLrqPgvpcN+nlgABp3sMhXIoWteVhYwFfAH4eiMVzxeux/EDemzOxAwhKyG+Ih2/WJBifD0uy49T0M0JmeKBxqJkoDyWB2rxqKHLsyFkAnYaE7wf3ccoz1nyQQ6rVzUeybB2PWa86oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNs4qXlKokoHweZ5M3XkPDDF1g4skarfVVeDV1+gXvI=;
 b=LySPJdGdG7GPqdyNUUsXteMtG7YojlpZgR63PLBI0ZyHxSzI9N9DZFJapFHT46oV9MJAYQYHCMoPTM9ikG98e0P/7rkiI33i6Y3CZ9KsEBOxU3j1v9ZQXE2URHZRltWgh/BJdd/Uf1k6/il3IasRJZmZRRunWZVjqCBdi1B3u0a2QAGhH6+zECEewamvBrqOpP9V4SPcESLJBUWtT0irXYRJHD4iG2/qkJaZOr4lmseERntqIWXE/KBMgXcngFmDrTwpueozX6NIvG1Y4lYAlXoaqxVmzKcW5VNHjB7UFRQciK1XiMSWDx7NWQ6mmS6bRd8i64n8OVAoXtET5A4YJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNs4qXlKokoHweZ5M3XkPDDF1g4skarfVVeDV1+gXvI=;
 b=SYlsqZG4afGqN7vcAAWVl4Ip/1PwAClMPdB0mrK4FCassxWnr8CyoS12xgcc7UuU1uZCjA5BN5JfWmrHp2MH8kFWM7usFA2mDwOxquDM/kH+j6Y8ojZ5Mb36bUreElk+zEHNDnokujaW4mUt/hrcqGskC1hICQE1xom16o5JGU7pCbjxgAEW2qaFR2ihiCxBO9qSnic8R8EAx+6fVOckeFsbRtkRTMAdhmWDRA1R9wtQ0vpDM2mrNv0CnlD/MVmsKbdgisGjnyd3l4vFB2TpX4VLQkV82Fe5kHimJitvX9k1worqHu+MPCR1YHLt3qx+XVRT0ajT3V89lmSL2DrcRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 12:22:22 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 12:22:22 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Balbir Singh <balbirs@nvidia.com>
Subject: [v6 13/15] selftests/mm/hmm-tests: partial unmap, mremap and anon_write tests
Date: Tue, 16 Sep 2025 22:21:26 +1000
Message-ID: <20250916122128.2098535-14-balbirs@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250916122128.2098535-1-balbirs@nvidia.com>
References: <20250916122128.2098535-1-balbirs@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::18) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS4PR12MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 569ed9c5-5cad-4026-0857-08ddf51bb02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mO/MJ4vHSC+hh/eRbA7SZx1gXNKJvbP2sUeIGhR84HXiAGGlRuyhidldCb7m?=
 =?us-ascii?Q?9M28TmrbbSfP2dzwfvn4KWxIlywaFASiUa9Mfm6xRJbIuxnJXCKCQ94Rkbrk?=
 =?us-ascii?Q?tvJAZnFvUXJz3gJdcyTFkdK1hCp7Qokha95XTIywWVmxTJSnmKxy5F1JAjUQ?=
 =?us-ascii?Q?csvTEzw97SlX12fDS+VHMvlhuf+ImeWdaNhUBYk+5pzKOoh6ZOVeCv5M8S6S?=
 =?us-ascii?Q?5vjDm8pRQ7pAoktKtxlrDtdeFsc6fD7SZycNdjoXtk2L8FRFRGvdpynAZ/wn?=
 =?us-ascii?Q?1vtVodLw7BVDv4lw4y+FXUyw6VKGjFU7IRWw4wrSO7mTlq01pkZSXuqj+yQ/?=
 =?us-ascii?Q?b4kb0SAFjtRKR2OyZs/7tplCGzpcM8nIZ1OUc3LIJN0VcB7QDTN3qjoWACjv?=
 =?us-ascii?Q?Lo+8oIc9QUzl1voOkoahnSvDcclyIHXYPALWnU+iD9dwmBfdecwkrBbYbZvt?=
 =?us-ascii?Q?lxpP54oLa3gbJ+cgMav3+wTl0VhVvh4M25Z/spfzsaOXZz4ERntkdvq9GOJs?=
 =?us-ascii?Q?h+l07myPESsREue7Z9BOKbCNQ8lfXJBnNDa1Ne5Z31oN07y1NG3ZHKcdmZnT?=
 =?us-ascii?Q?gHqPxvSXriorHcmMxkWaECRVLLwKuOkuK6R9oHOg6nJnkl6/i0Wox4uv3VxO?=
 =?us-ascii?Q?BcDX9GL3BQVfWy4TWVLctcrwpW87d6mKC/ZrNyuxzzjGW/VPZR0FLWHG3KKq?=
 =?us-ascii?Q?jP0dbtVaDB0ma/eu/BEG6sdTgNuQaBMJ61EYlTwJfyq3UV5sU/dXG/iLKqBa?=
 =?us-ascii?Q?6H14GpYz5eeGOtm28brLOGI+rE81fg2jGLeAT2iYctjD+Ti8KwPE7bkHmLxG?=
 =?us-ascii?Q?IH3kyaOHpsnCJHZffq9HAnEUtG9OE87cxIJDkwekJKN061dAFvAp0hTxshQg?=
 =?us-ascii?Q?0uFOZGqZCv+k/WOV8ow+2CwJ2MVOVs+bG0EEOwlg4rC/pzR4n5ZryjENqRL9?=
 =?us-ascii?Q?cVBIQmVgCKIc7I3PF2Vw9jZLw3G20KTvvydeTA1IJBOxFfB5cBPyvukFHJRO?=
 =?us-ascii?Q?5xjRgQcPhfgc9HxuhNc8a0mnWGxnQ7afEaQOF5CsCZ5kGv73G/ufpZ9YD4+o?=
 =?us-ascii?Q?MVLHr4bFvvcQqJvDrQdAGh95jLwNP6w7eRfcA/rTcwn5MSFkyrP3OMRgEZvY?=
 =?us-ascii?Q?irD+K3rK+/qfgVZ/0DTdHDuB//vHP1ow4QBBp4/IO0+kJc9bL2CnYYcshqjZ?=
 =?us-ascii?Q?gRVzRRxuLEdN8ZH86kPrLwMd3QV0cR0Pvpm1Kv3a1Yn6BB9CVkQJlnRQhf9k?=
 =?us-ascii?Q?dZJiFCzR+wjYDnzgbVmMwnPPMIt9ngxipcwypTnFGXbAYqKRKp/+vF4YMliR?=
 =?us-ascii?Q?44jgGtAqs4HlOzOARjMAJYuPFdLBAwcoi0DO3YOT6/ghHB+cfrq+lmh5fzxj?=
 =?us-ascii?Q?fzXMQmJmtuQaQjdGetfZQTtcxgvTlNShlHBBiftUEULBhAnKWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MCUp27qNla3EsTjfe0feKse0tbEJ8gxeJ3TSUbr05+22Z/3bhJ5fnKB8JLZp?=
 =?us-ascii?Q?tULpcx/1H1rqa1HidnHKAN7AOLRojnFeOQTtUglUnpP5vm2H23ZWrv9yvOa2?=
 =?us-ascii?Q?4h5u3/frR8aG/7J+gviWEoxX+I+9Bn3N2kaTFRCsKbnz3cF9gnxGEuo7Qovc?=
 =?us-ascii?Q?fcKZ91FH6eFdaswkPYErvOcZZCeoi5WQwvDtbM0SSyhYAFggSIFGH2CmSjAE?=
 =?us-ascii?Q?FHEEF+iwksLUIFghpGC6UMSyb5LEoMP6mpK3P5euR7yfEJvv5r6oi3ACWwOK?=
 =?us-ascii?Q?2DX8nVVu0FZHJ5V98UsCtnCg7D+zcF84BWQiV63ur7Tc4Zv/VOv/ZMjTjXN7?=
 =?us-ascii?Q?T5cGNs/nWH+lt0RZydr+uj+/3WfvD3FXnvbr5vlTjpXD9XajDvE8RqhwWxGM?=
 =?us-ascii?Q?xDrbPoKgn84ofz6q5rF9zmonfd/qSaDnk311bhPvDE8bIB40nvWA1tbsYXaj?=
 =?us-ascii?Q?TW8vm0u9xnOhZAyQI3YKfIKfOcBGxMJb2SMx0xr/7liSRfu4RRoUg4VkoxVb?=
 =?us-ascii?Q?3LoN1W3R1/CfkfmO8WYIqdMz1Hj3TJsuzh/nhbs6H7WDBDRUCmxvZ0LYXIFi?=
 =?us-ascii?Q?wIj2EyMmUFU12g5QEscxXMryVDI5cmq8zeeY6IWKfrsUq8kvQzqT0cV+smQb?=
 =?us-ascii?Q?VVGv0gDRVU+oTErPAFTcgwvvifuYDfHGuAPTPKBqJsFrOJsnONUv6WFTWBeP?=
 =?us-ascii?Q?6fRYs7XyDJJ48UHCxb0vDbBZlTI062z0vNcAdEfcG752SO22HtmdwpxHlq9Y?=
 =?us-ascii?Q?YJfhXdGyglW4f+GmnjSNv8RmYDPD/rCEevavLVBgdhA572Af9taRjuVoEadX?=
 =?us-ascii?Q?oRft8LHmV8kt18FPA1Y4N2FtkGFIe/irFPDa5srSMtU1A9wNN+um5WuCRwTM?=
 =?us-ascii?Q?fTq0fH0zcZqG9h9BSIw7TNUNtom5OcmTd1/7V41ih8L73Mp2Zj535BLCVMAn?=
 =?us-ascii?Q?w3sX1c/zUG+P4WKhSb4TzAuniFFf0ALzApNPGFdI5pUx2Uvw9zUU2KiGWAuM?=
 =?us-ascii?Q?Q36RFcRTKAL8AO6HklaydrrrAeknOz9Dh5xwgXNW52pB+xZ2pC87Eq6Ttudt?=
 =?us-ascii?Q?NBTkNUuq6iN47urM2dEFA6+vwzZTxcClcF+77jF5RioRhxdvbdt0tYx6GcoQ?=
 =?us-ascii?Q?4uIJWg4NiV8fsm56m7rTmGIOt//PD0HQMlgqto22DYzGzrTs7YmUEsjPEThN?=
 =?us-ascii?Q?JT2VLK3SPJ8SS+IvbVIe6vBXEaOtyA2E8r3QC7kcm2Ia3aox5bDlyNdVR+VK?=
 =?us-ascii?Q?LX/k7TPi+X5nxVDPwLWo8Ok1MgsjmW599cDGrvqGYqP2MwS/OAOfoOWvrdLx?=
 =?us-ascii?Q?f5ddCXvhIIp+RqyOEkpv8WW6MfLUYZvgo5sv+w7qhz/yOgWss4+pn/H6UXZV?=
 =?us-ascii?Q?x5ehayliq4twcj/pKst5L/NZOdzjxb9UmWKj+URho8FD+mnobFpkAfbaPygh?=
 =?us-ascii?Q?XziUcgmd44m2DUqvpdioBHlkInwwGxTCiWvcfNqz2zH8M67xJ/Hs1C1Y1NdG?=
 =?us-ascii?Q?/fi6R8leOaO6bLvMo2mE+lG7osJAbOIC+Bo2EWJH0lX+7DpxoNnp0NZd5P9E?=
 =?us-ascii?Q?AD2eqPjuBqYAOVyP1zJMiWbTlqwn9cP62A+D/hg+Vi6pyBvbZswCuoWP/QDi?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569ed9c5-5cad-4026-0857-08ddf51bb02b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 12:22:22.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNJEV52SQlfzhLvhDxOwWLnshIET6I6R2YEKjuNc5VYbs7S5428Tn6SaXWWXqJJlvH1oXjLoQiSPv8oiD5LElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684

From: Matthew Brost <matthew.brost@intel.com>

Add partial unmap test case which munmaps memory while in the device.

Add tests exercising mremap on faulted-in memory (CPU and GPU) at
various offsets and verify correctness.

Update anon_write_child to read device memory after fork verifying
this flow works in the kernel.

Both THP and non-THP cases are updated.

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 tools/testing/selftests/mm/hmm-tests.c | 312 ++++++++++++++++++++-----
 1 file changed, 252 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 339a90183930..dedc1049bd4d 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -50,6 +50,8 @@ enum {
 	HMM_COHERENCE_DEVICE_TWO,
 };
 
+#define ONEKB		(1 << 10)
+#define ONEMEG		(1 << 20)
 #define TWOMEG		(1 << 21)
 #define HMM_BUFFER_SIZE (1024 << 12)
 #define HMM_PATH_MAX    64
@@ -525,6 +527,8 @@ TEST_F(hmm, anon_write_prot)
 /*
  * Check that a device writing an anonymous private mapping
  * will copy-on-write if a child process inherits the mapping.
+ *
+ * Also verifies after fork() memory the device can be read by child.
  */
 TEST_F(hmm, anon_write_child)
 {
@@ -532,72 +536,101 @@ TEST_F(hmm, anon_write_child)
 	unsigned long npages;
 	unsigned long size;
 	unsigned long i;
+	void *old_ptr;
+	void *map;
 	int *ptr;
 	pid_t pid;
 	int child_fd;
-	int ret;
-
-	npages = ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
-	ASSERT_NE(npages, 0);
-	size = npages << self->page_shift;
-
-	buffer = malloc(sizeof(*buffer));
-	ASSERT_NE(buffer, NULL);
-
-	buffer->fd = -1;
-	buffer->size = size;
-	buffer->mirror = malloc(size);
-	ASSERT_NE(buffer->mirror, NULL);
-
-	buffer->ptr = mmap(NULL, size,
-			   PROT_READ | PROT_WRITE,
-			   MAP_PRIVATE | MAP_ANONYMOUS,
-			   buffer->fd, 0);
-	ASSERT_NE(buffer->ptr, MAP_FAILED);
-
-	/* Initialize buffer->ptr so we can tell if it is written. */
-	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
-		ptr[i] = i;
+	int ret, use_thp, migrate;
+
+	for (migrate = 0; migrate < 2; ++migrate) {
+		for (use_thp = 0; use_thp < 2; ++use_thp) {
+			npages = ALIGN(use_thp ? TWOMEG : HMM_BUFFER_SIZE,
+				       self->page_size) >> self->page_shift;
+			ASSERT_NE(npages, 0);
+			size = npages << self->page_shift;
+
+			buffer = malloc(sizeof(*buffer));
+			ASSERT_NE(buffer, NULL);
+
+			buffer->fd = -1;
+			buffer->size = size * 2;
+			buffer->mirror = malloc(size);
+			ASSERT_NE(buffer->mirror, NULL);
+
+			buffer->ptr = mmap(NULL, size * 2,
+					   PROT_READ | PROT_WRITE,
+					   MAP_PRIVATE | MAP_ANONYMOUS,
+					   buffer->fd, 0);
+			ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+			old_ptr = buffer->ptr;
+			if (use_thp) {
+				map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
+				ret = madvise(map, size, MADV_HUGEPAGE);
+				ASSERT_EQ(ret, 0);
+				buffer->ptr = map;
+			}
+
+			/* Initialize buffer->ptr so we can tell if it is written. */
+			for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+				ptr[i] = i;
+
+			/* Initialize data that the device will write to buffer->ptr. */
+			for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+				ptr[i] = -i;
+
+			if (migrate) {
+				ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+				ASSERT_EQ(ret, 0);
+				ASSERT_EQ(buffer->cpages, npages);
+
+			}
+
+			pid = fork();
+			if (pid == -1)
+				ASSERT_EQ(pid, 0);
+			if (pid != 0) {
+				waitpid(pid, &ret, 0);
+				ASSERT_EQ(WIFEXITED(ret), 1);
+
+				/* Check that the parent's buffer did not change. */
+				for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+					ASSERT_EQ(ptr[i], i);
+
+				buffer->ptr = old_ptr;
+				hmm_buffer_free(buffer);
+				continue;
+			}
+
+			/* Check that we see the parent's values. */
+			for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+				ASSERT_EQ(ptr[i], i);
+			if (!migrate) {
+				for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+					ASSERT_EQ(ptr[i], -i);
+			}
+
+			/* The child process needs its own mirror to its own mm. */
+			child_fd = hmm_open(0);
+			ASSERT_GE(child_fd, 0);
+
+			/* Simulate a device writing system memory. */
+			ret = hmm_dmirror_cmd(child_fd, HMM_DMIRROR_WRITE, buffer, npages);
+			ASSERT_EQ(ret, 0);
+			ASSERT_EQ(buffer->cpages, npages);
+			ASSERT_EQ(buffer->faults, 1);
 
-	/* Initialize data that the device will write to buffer->ptr. */
-	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
-		ptr[i] = -i;
+			/* Check what the device wrote. */
+			if (!migrate) {
+				for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+					ASSERT_EQ(ptr[i], -i);
+			}
 
-	pid = fork();
-	if (pid == -1)
-		ASSERT_EQ(pid, 0);
-	if (pid != 0) {
-		waitpid(pid, &ret, 0);
-		ASSERT_EQ(WIFEXITED(ret), 1);
-
-		/* Check that the parent's buffer did not change. */
-		for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
-			ASSERT_EQ(ptr[i], i);
-		return;
+			close(child_fd);
+			exit(0);
+		}
 	}
-
-	/* Check that we see the parent's values. */
-	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
-		ASSERT_EQ(ptr[i], i);
-	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
-		ASSERT_EQ(ptr[i], -i);
-
-	/* The child process needs its own mirror to its own mm. */
-	child_fd = hmm_open(0);
-	ASSERT_GE(child_fd, 0);
-
-	/* Simulate a device writing system memory. */
-	ret = hmm_dmirror_cmd(child_fd, HMM_DMIRROR_WRITE, buffer, npages);
-	ASSERT_EQ(ret, 0);
-	ASSERT_EQ(buffer->cpages, npages);
-	ASSERT_EQ(buffer->faults, 1);
-
-	/* Check what the device wrote. */
-	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
-		ASSERT_EQ(ptr[i], -i);
-
-	close(child_fd);
-	exit(0);
 }
 
 /*
@@ -2289,6 +2322,165 @@ TEST_F(hmm, migrate_anon_huge_fault)
 	hmm_buffer_free(buffer);
 }
 
+/*
+ * Migrate memory and fault back to sysmem after partially unmapping.
+ */
+TEST_F(hmm, migrate_partial_unmap_fault)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size = TWOMEG;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret, j, use_thp;
+	int offsets[] = { 0, 512 * ONEKB, ONEMEG };
+
+	for (use_thp = 0; use_thp < 2; ++use_thp) {
+		for (j = 0; j < ARRAY_SIZE(offsets); ++j) {
+			buffer = malloc(sizeof(*buffer));
+			ASSERT_NE(buffer, NULL);
+
+			buffer->fd = -1;
+			buffer->size = 2 * size;
+			buffer->mirror = malloc(size);
+			ASSERT_NE(buffer->mirror, NULL);
+			memset(buffer->mirror, 0xFF, size);
+
+			buffer->ptr = mmap(NULL, 2 * size,
+					   PROT_READ | PROT_WRITE,
+					   MAP_PRIVATE | MAP_ANONYMOUS,
+					   buffer->fd, 0);
+			ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+			npages = size >> self->page_shift;
+			map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
+			if (use_thp)
+				ret = madvise(map, size, MADV_HUGEPAGE);
+			else
+				ret = madvise(map, size, MADV_NOHUGEPAGE);
+			ASSERT_EQ(ret, 0);
+			old_ptr = buffer->ptr;
+			buffer->ptr = map;
+
+			/* Initialize buffer in system memory. */
+			for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+				ptr[i] = i;
+
+			/* Migrate memory to device. */
+			ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+			ASSERT_EQ(ret, 0);
+			ASSERT_EQ(buffer->cpages, npages);
+
+			/* Check what the device read. */
+			for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+				ASSERT_EQ(ptr[i], i);
+
+			munmap(buffer->ptr + offsets[j], ONEMEG);
+
+			/* Fault pages back to system memory and check them. */
+			for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+				if (i * sizeof(int) < offsets[j] ||
+				    i * sizeof(int) >= offsets[j] + ONEMEG)
+					ASSERT_EQ(ptr[i], i);
+
+			buffer->ptr = old_ptr;
+			hmm_buffer_free(buffer);
+		}
+	}
+}
+
+TEST_F(hmm, migrate_remap_fault)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size = TWOMEG;
+	unsigned long i;
+	void *old_ptr, *new_ptr = NULL;
+	void *map;
+	int *ptr;
+	int ret, j, use_thp, dont_unmap, before;
+	int offsets[] = { 0, 512 * ONEKB, ONEMEG };
+
+	for (before = 0; before < 2; ++before) {
+		for (dont_unmap = 0; dont_unmap < 2; ++dont_unmap) {
+			for (use_thp = 0; use_thp < 2; ++use_thp) {
+				for (j = 0; j < ARRAY_SIZE(offsets); ++j) {
+					int flags = MREMAP_MAYMOVE | MREMAP_FIXED;
+
+					if (dont_unmap)
+						flags |= MREMAP_DONTUNMAP;
+
+					buffer = malloc(sizeof(*buffer));
+					ASSERT_NE(buffer, NULL);
+
+					buffer->fd = -1;
+					buffer->size = 8 * size;
+					buffer->mirror = malloc(size);
+					ASSERT_NE(buffer->mirror, NULL);
+					memset(buffer->mirror, 0xFF, size);
+
+					buffer->ptr = mmap(NULL, buffer->size,
+							   PROT_READ | PROT_WRITE,
+							   MAP_PRIVATE | MAP_ANONYMOUS,
+							   buffer->fd, 0);
+					ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+					npages = size >> self->page_shift;
+					map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
+					if (use_thp)
+						ret = madvise(map, size, MADV_HUGEPAGE);
+					else
+						ret = madvise(map, size, MADV_NOHUGEPAGE);
+					ASSERT_EQ(ret, 0);
+					old_ptr = buffer->ptr;
+					munmap(map + size, size * 2);
+					buffer->ptr = map;
+
+					/* Initialize buffer in system memory. */
+					for (i = 0, ptr = buffer->ptr;
+					     i < size / sizeof(*ptr); ++i)
+						ptr[i] = i;
+
+					if (before) {
+						new_ptr = mremap((void *)map, size, size, flags,
+								 map + size + offsets[j]);
+						ASSERT_NE(new_ptr, MAP_FAILED);
+						buffer->ptr = new_ptr;
+					}
+
+					/* Migrate memory to device. */
+					ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+					ASSERT_EQ(ret, 0);
+					ASSERT_EQ(buffer->cpages, npages);
+
+					/* Check what the device read. */
+					for (i = 0, ptr = buffer->mirror;
+					     i < size / sizeof(*ptr); ++i)
+						ASSERT_EQ(ptr[i], i);
+
+					if (!before) {
+						new_ptr = mremap((void *)map, size, size, flags,
+								 map + size + offsets[j]);
+						ASSERT_NE(new_ptr, MAP_FAILED);
+						buffer->ptr = new_ptr;
+					}
+
+					/* Fault pages back to system memory and check them. */
+					for (i = 0, ptr = buffer->ptr;
+					     i < size / sizeof(*ptr); ++i)
+						ASSERT_EQ(ptr[i], i);
+
+					munmap(new_ptr, size);
+					buffer->ptr = old_ptr;
+					hmm_buffer_free(buffer);
+				}
+			}
+		}
+	}
+}
+
 /*
  * Migrate private anonymous huge page with allocation errors.
  */
-- 
2.50.1


