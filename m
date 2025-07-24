Return-Path: <linux-kernel+bounces-745005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1511BB113A5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548417B95EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677D23DEB6;
	Thu, 24 Jul 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="L3irG6b+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2108.outbound.protection.outlook.com [40.107.236.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491823BD04
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395181; cv=fail; b=RhnmYiRwVsXYXX3LLmEzCcIUA5uYl3U+Bh1TXeA7o57kVgqL1WViwK4/DTuJXQ4w/9VK0tqXQNnY6FwgBH91DdLMw6con5FKWlqhgue1LT39C6W1Br56+FigPu9zIzKFb5mWno29h28rM3P6TI6qKxGywlV/ON6BH4LTxRIFEcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395181; c=relaxed/simple;
	bh=V515ThAale+V+52t/xGRn3kr7J65eDC4xSUY5KoVNAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZZ90P5le1SI8P7Nt4CNHNgEz5RzgzkpofIsCoJVJPuW81JHsyfMChSCWWhG/5sAEFAyxsqbk4UVtyO+DmWvbrCh4Fm2qlpdu7W+kHmrEE2+H4ksdSwHX7IpEzUjp/P4v1lD4lTB9pODvZ+KuiVLvt/J1lPM1yVUfB8gQBTT28I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=L3irG6b+; arc=fail smtp.client-ip=40.107.236.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4Fex9+vO2p/wgnjIbWbDKrLn5MBwOIlDVtP7KIGMNhcppL6uPV5P3TKzJEEAuEy9/XcepLDkoQZ+xjoO/yWRTUnm+5U5lGaYMyPTEnXztEIFYnLGYhxp14gT8NGE7t8EZE91wUgPNPMLYfDNdTHHjKW3DobEgGGtmEfCSsDo4/FjURWUG9jpT2mIlJrOlIQPvF3Mn7+Tehi2y5vh3kCEtS5G6QRtEGEjd38cK0jlTtSozvJsqI1XeYi/bunmglNX0C57pYSmrGrf9tJzeq8iF7vtzlUpGepxV2Ou8CYZESNVjVO2drx7TO3EW9Vei/7jZbLBS4W5JlMLWJ1PixAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oTVAal//IBUPIN6FW4+hjl5AAxBKJJvciNxVJuQ0+4=;
 b=TKpujrn9MH16eyvK16yOaSQ4B0QSGx/C/EVayGlESMrb0sPhqQMgBDtQ+mPMvYgOfDn+juFj70qmvmP1BUMuHJ1Jp4vh7Vk1hCjA6FiyaimAKQ0Aqoug4mPxmCBhADzoTpySC0/cNM/1mzA9q34pl7pMNgvpb5F+c47RDwwJvttiw+gwH+bmhUOeJkrP1am+f3gcgRw0Nn5oEZONQgoSSa+f94Mj+dDFEU9sSXmdFfCO465hHZACzqJaIt4x079u8CU1pVbNUcJkAftqXpaDndtYAnAa0+QVwnGZD0eD+ag9WpQPov7Q2zJyxZ8sl6SexllICOIJe0TfQmYm5+rvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oTVAal//IBUPIN6FW4+hjl5AAxBKJJvciNxVJuQ0+4=;
 b=L3irG6b+OjlMMKKD7YQydRH7pGWoPhT393XLvpkVo1Z+1ZnUTc8Y5qHAB59oXQyYv9pO6sYgo0MLBK0spCbY9YQRVO/SnkSWSeZVPRyuOZZNAEk9tnN54Jrk0zScfW5uEaGNmtvNiOCD135mTzlBrVmqDXgpiFZCPGEvTrg2Qjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SN7PR01MB8089.prod.exchangelabs.com (2603:10b6:806:32f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Thu, 24 Jul 2025 22:12:53 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 22:12:53 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	Miko.Lenczewski@arm.com,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: mm: support large block mapping when rodata=full
Date: Thu, 24 Jul 2025 15:11:05 -0700
Message-ID: <20250724221216.1998696-4-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724221216.1998696-1-yang@os.amperecomputing.com>
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0236.namprd15.prod.outlook.com
 (2603:10b6:930:66::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SN7PR01MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: b743ba8a-893b-4f0f-7ee8-08ddcaff3bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wym0LDrNwNPPX8KhKj7eNNa91arJpaNMQgTFdl0vQQPVvUhrYEC5Vz9c5Tge?=
 =?us-ascii?Q?Knxl+ku7TNla22e3C/o4x6yNHL4TetyXzgrWpmjjxRBVTOBeTCvXXcXRw2/U?=
 =?us-ascii?Q?RIrU84BmSpxn+LF0n7nGwptkuJBddLXcMDMB9ywb9Ckba2mJWYgYtj48Igrp?=
 =?us-ascii?Q?QdR20PQpjykb5MVyIS37neC8kzhxhz1S6JZqJYOQ87Onf5sXIlooZnIt9Zoj?=
 =?us-ascii?Q?wFrsAufCawE4yUz0ZMYORebYlP3diPPsMYbi+ktnIrCLRwBS4HGE4JKeuMoF?=
 =?us-ascii?Q?gbvwZBCsR39dQbcVNTqfX9i70qcM4KDxyuOiWeMyBcbUuHNDAHUWtISbjnbL?=
 =?us-ascii?Q?uaH2T3zQuGC3CHnZEoBmdJ9tOuo8N6QXKNnw/oYxSh8jL6R9UXNbjl5XWvKK?=
 =?us-ascii?Q?/XuRS+z1tGpcnb32WBrhfF0lMJlbRDSJixzp1b9CpoRG4IhlbsBcB29S7ivQ?=
 =?us-ascii?Q?bsRKQsbofzmBmoDKnrzgnMghLWD5MlMTpho9kJ6RdHH2c7F1LRSWiLSpt74X?=
 =?us-ascii?Q?HupD1jE0fFygjTEmjz8Qh5IvERUWCDrKYU0G8or8vMBM3cb4xma37hlXWYxo?=
 =?us-ascii?Q?BIFSoFky7tdPIpiEc4tGZ8RGu5DuxGDpWkLIWiBXZqUkB6mCqES4fVGVeUpo?=
 =?us-ascii?Q?kLCKFmZ06s61Dqpxvkm/1lmZ18DazMyZDQsas+6NXcKrrkbAzpj58HCoV4LM?=
 =?us-ascii?Q?HtFj5nK8i0HpeR4+4SYPdqbgvtOd0iKho8is3EDGto3yi5V14vJ4UStcId9J?=
 =?us-ascii?Q?cZfG5F1AJeZH13EjQuTgYizQXTwKTskabhi1H017gMhXQJZDj1JMLE6SicvE?=
 =?us-ascii?Q?9hAxYAJZsaiZMvPfCp+s2Cm4UfDcrRIooXiPhJzorzBmLPiITRM65JyqHmWR?=
 =?us-ascii?Q?mbdCvfRz2+rDzXT64N+o8lSXrSXCqNyrlNHLagGRaEYHH5rDMKL60YFqaO0k?=
 =?us-ascii?Q?UQ+/i/ZuG7SkwaUZqFjgurH62YLliel4c7kJdLbIUSulU22fGM+igcCbBHOX?=
 =?us-ascii?Q?H4PvozxFleM+u9a5zRbkFhh+jL7HT4S6k1PofAVeubJey4LqG3qtt2jDn9IU?=
 =?us-ascii?Q?LfCclsd3mFYzgVqIOQD8Skp7tNUs30xLm1cwYZNtLG3PtozAeuzjAM1GKCSk?=
 =?us-ascii?Q?/s6VTAg9h0HiO/fh7EDk7YPtL4EeAiMD+Z0hSXbVdFUO+6XkHQ3cTXOCkqIV?=
 =?us-ascii?Q?fgrr9Ml0+FUeBaesc0AriLVysay8YgiW85Ge2q3EYk7il0fciSReEb2UjtmT?=
 =?us-ascii?Q?ygZPUgSIYQK49dc4JZHdgz18b09G7n2LALP3KqNjetUs7d/D9tFbYbu7Merc?=
 =?us-ascii?Q?Ivluu5XKdHhAEDglRHU6EKMYabkTLjiM6KBdhZ1V0eX5jVyOGWvT15hH8sff?=
 =?us-ascii?Q?eGSesUTEm96V0btWjnTn8kPRN7TUWWA/vEsHdU0aWnyAE9Ii2gZKZmgtg48R?=
 =?us-ascii?Q?AvCI1nhzQ9H446SdnTLe+/svLhg1Cpd/Tm2Mcz0cDgOU3S9eEhulsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7TR3zxDmr6I4O7HTRdkFT2Ndaqaxk6ZDEuo22NCPsaH+FA2wvxn5BYEm6/+2?=
 =?us-ascii?Q?4xgZ1o5Bpi9CVGXWwrcy9iGMEjeHv6QXVwUrra0ImjXPCGG4IdHvzNPjARtj?=
 =?us-ascii?Q?wsK9WDmCdmJ+peB41nRVfZ1FtzITfVBDvliB0XdlW7fZsJDwPKgwWVwCQ3Fr?=
 =?us-ascii?Q?rGO9nvOj7J/jjVDafiCBQdxDaqJXqRLIuu01i58UqZ2PJTHnqkXIjXIMYJsO?=
 =?us-ascii?Q?koJdy5R2fSAbXw+QTaCMBLWykGcN5x2Mx3By/PYgnXTtdl8g/5J6XAVKiRVs?=
 =?us-ascii?Q?BopGKJFXfCQumkyLx/ZPEZSEIdn16yQ7T5Wheub9tjIsEUjtSJwozKpTpgg0?=
 =?us-ascii?Q?T4iPZAJ7Fy380paWT7dqgUNX5Iold7knnHCb1eEJ62jVRQuoR6kVaDTbiXMO?=
 =?us-ascii?Q?bprKiMfO7guctwZrForXFJ1MigIHfZFjYTVVaBneMWYiI6JW/IgvjB5xSSTh?=
 =?us-ascii?Q?9ee5x6PLToc+47RabyrYVdk9yliaviA904Fm6SDI2YrZvpyJhh0sD7rd1RGf?=
 =?us-ascii?Q?qKKjOV8VNOmpBBRdpC9ZIH2mHsU+6YPYocxigus5C0zUzQNsuoWlRP25TRsL?=
 =?us-ascii?Q?nobvSGiePewUm9ATFQM01254gM95DRACp10GkQoHhYniHON9q86x7gdsXEIu?=
 =?us-ascii?Q?r8PJ5ipe4RZWBvKtPE8s6V6Copzz0GKoQy81WXRNfmV7ANRmr0qELuugF6G+?=
 =?us-ascii?Q?xcV/OLK8AB3pXUCyIAuP79zz3QS9ksl9NHq5E1UhbXWNhHu6L13VSu6k4Epm?=
 =?us-ascii?Q?Y04Y1mVpj1qxQPS/sUk0BkCud0XC0xaL6oBb5caEl/9vethiKGKarRU8QJjr?=
 =?us-ascii?Q?tg7ppBiXYKxAWRt8G5kbcDAcw0BtGrp5FoRFsNhMWJTZXE6OQi/P8Vvc7mhf?=
 =?us-ascii?Q?ka0owInxAtdCeyxMiLLPY/4pWlr1MGOtbq4f2B1ZdnwXxrFs81FTNf/bUGzf?=
 =?us-ascii?Q?6u29nVPXECYlbiI5PZrKupVNw2AANxKw+WwkYj847vZbKFkpK16jX6VlRJbX?=
 =?us-ascii?Q?1yuIarvsYps2bJk68ovzO2g1Bwq9DHkLTMcZW+N3kE6X8ID1gA1kaUpd9udd?=
 =?us-ascii?Q?YBRiZwdAu7ba1hAM7mq+YC7SyBsscyNAFqbk4TZi/vsJvuAkY3DMPg0g6K4M?=
 =?us-ascii?Q?EP4HnXq4KPlz4yywpDlG3b7SbXIgsKBCrtv1dVKCdlA5qYcs20RaqXwXVp2Q?=
 =?us-ascii?Q?d5RKRnGUQqsELVnTKS3Ib4LzrMb4S74kZtYuDgrMA428ItkqNitiKq5kHD09?=
 =?us-ascii?Q?EyJicFU6QqfB4d13KsEg1ZvcghySdet6dvgb/5yijy9bpq68VNUhcbqDsgjE?=
 =?us-ascii?Q?1b8GCCUj5G8qrCSWUhhcN5W1en8NFdetg6YSpQUpKCMqVQpn7KPTtBW4/1M4?=
 =?us-ascii?Q?WRCyi3BOlCj/nN47ind5qXrxhQCSM6M092Wo/ijGmYofboq8iA8LthsNCxsM?=
 =?us-ascii?Q?PmAS1KrJJ7y4BBO/iJKl6U60YqHc0nv7s1mDpXVnimb3xN1A5aqy71zXQ/eT?=
 =?us-ascii?Q?NbIU14DW64F9yHjpFG/LTrDz4i7uhfoNlMjGH0whrQ0hSA8BFMeYmVI4g8We?=
 =?us-ascii?Q?JdWMtGk69TFIKVPDMb6/l6O5BGVZGI51k1GEVQX2yBxI2pFF3v4Y21cSfNJe?=
 =?us-ascii?Q?oA5Nn6pmSEQV3j5cqOGRPhI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b743ba8a-893b-4f0f-7ee8-08ddcaff3bf0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 22:12:52.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hc1pD/fThjQhkU2LesG/a+Jxs7VqfOyCIEGCpPMYco7SmTEsKrsSKuTMH7W/hio7AkGhwFSOA6G0QaWdQJUFQIckn1p/29xldvFT1fdhTe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8089

When rodata=full is specified, kernel linear mapping has to be mapped at
PTE level since large page table can't be split due to break-before-make
rule on ARM64.

This resulted in a couple of problems:
  - performance degradation
  - more TLB pressure
  - memory waste for kernel page table

With FEAT_BBM level 2 support, splitting large block page table to
smaller ones doesn't need to make the page table entry invalid anymore.
This allows kernel split large block mapping on the fly.

Add kernel page table split support and use large block mapping by
default when FEAT_BBM level 2 is supported for rodata=full.  When
changing permissions for kernel linear mapping, the page table will be
split to smaller size.

The machine without FEAT_BBM level 2 will fallback to have kernel linear
mapping PTE-mapped when rodata=full.

With this we saw significant performance boost with some benchmarks and
much less memory consumption on my AmpereOne machine (192 cores, 1P) with
256GB memory.

* Memory use after boot
Before:
MemTotal:       258988984 kB
MemFree:        254821700 kB

After:
MemTotal:       259505132 kB
MemFree:        255410264 kB

Around 500MB more memory are free to use.  The larger the machine, the
more memory saved.

* Memcached
We saw performance degradation when running Memcached benchmark with
rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
With this patchset we saw ops/sec is increased by around 3.5%, P99
latency is reduced by around 9.6%.
The gain mainly came from reduced kernel TLB misses.  The kernel TLB
MPKI is reduced by 28.5%.

The benchmark data is now on par with rodata=on too.

* Disk encryption (dm-crypt) benchmark
Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
encryption (by dm-crypt).
fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
    --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
    --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
    --name=iops-test-job --eta-newline=1 --size 100G

The IOPS is increased by 90% - 150% (the variance is high, but the worst
number of good case is around 90% more than the best number of bad case).
The bandwidth is increased and the avg clat is reduced proportionally.

* Sequential file read
Read 100G file sequentially on XFS (xfs_io read with page cache populated).
The bandwidth is increased by 150%.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/cpufeature.h |  34 ++++
 arch/arm64/include/asm/mmu.h        |   1 +
 arch/arm64/include/asm/pgtable.h    |   5 +
 arch/arm64/kernel/cpufeature.c      |  31 +--
 arch/arm64/mm/mmu.c                 | 293 +++++++++++++++++++++++++++-
 arch/arm64/mm/pageattr.c            |   4 +
 6 files changed, 333 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index bf13d676aae2..d0d394cc837d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -871,6 +871,40 @@ static inline bool system_supports_pmuv3(void)
 	return cpus_have_final_cap(ARM64_HAS_PMUV3);
 }
 
+static inline bool bbml2_noabort_available(void)
+{
+	/*
+	 * We want to allow usage of BBML2 in as wide a range of kernel contexts
+	 * as possible. This list is therefore an allow-list of known-good
+	 * implementations that both support BBML2 and additionally, fulfill the
+	 * extra constraint of never generating TLB conflict aborts when using
+	 * the relaxed BBML2 semantics (such aborts make use of BBML2 in certain
+	 * kernel contexts difficult to prove safe against recursive aborts).
+	 *
+	 * Note that implementations can only be considered "known-good" if their
+	 * implementors attest to the fact that the implementation never raises
+	 * TLB conflict aborts for BBML2 mapping granularity changes.
+	 */
+	static const struct midr_range supports_bbml2_noabort_list[] = {
+		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
+		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
+		{}
+	};
+
+	/* Does our cpu guarantee to never raise TLB conflict aborts? */
+	if (!is_midr_in_range_list(supports_bbml2_noabort_list))
+		return false;
+
+	/*
+	 * We currently ignore the ID_AA64MMFR2_EL1 register, and only care
+	 * about whether the MIDR check passes.
+	 */
+
+	return true;
+}
+
 static inline bool system_supports_bbml2_noabort(void)
 {
 	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 6e8aa8e72601..57f4b25e6f33 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -71,6 +71,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       pgprot_t prot, bool page_mappings_only);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
+extern int split_kernel_pgtable_mapping(unsigned long start, unsigned long end);
 
 /*
  * This check is triggered during the early boot before the cpufeature
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ba63c8736666..ad2a6a7e86b0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -371,6 +371,11 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
 	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
 }
 
+static inline pmd_t pmd_mknoncont(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) & ~PMD_SECT_CONT);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d2a8a509a58e..1c96016a7a41 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2215,36 +2215,7 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
 
 static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
 {
-	/*
-	 * We want to allow usage of BBML2 in as wide a range of kernel contexts
-	 * as possible. This list is therefore an allow-list of known-good
-	 * implementations that both support BBML2 and additionally, fulfill the
-	 * extra constraint of never generating TLB conflict aborts when using
-	 * the relaxed BBML2 semantics (such aborts make use of BBML2 in certain
-	 * kernel contexts difficult to prove safe against recursive aborts).
-	 *
-	 * Note that implementations can only be considered "known-good" if their
-	 * implementors attest to the fact that the implementation never raises
-	 * TLB conflict aborts for BBML2 mapping granularity changes.
-	 */
-	static const struct midr_range supports_bbml2_noabort_list[] = {
-		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
-		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
-		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
-		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
-		{}
-	};
-
-	/* Does our cpu guarantee to never raise TLB conflict aborts? */
-	if (!is_midr_in_range_list(supports_bbml2_noabort_list))
-		return false;
-
-	/*
-	 * We currently ignore the ID_AA64MMFR2_EL1 register, and only care
-	 * about whether the MIDR check passes.
-	 */
-
-	return true;
+	return bbml2_noabort_available();
 }
 
 #ifdef CONFIG_ARM64_PAN
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3d5fb37424ab..f63b39613571 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -480,6 +480,8 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
 			     int flags);
 #endif
 
+#define INVALID_PHYS_ADDR	-1
+
 static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
 				       enum pgtable_type pgtable_type)
 {
@@ -487,7 +489,9 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
 	phys_addr_t pa;
 
-	BUG_ON(!ptdesc);
+	if (!ptdesc)
+		return INVALID_PHYS_ADDR;
+
 	pa = page_to_phys(ptdesc_page(ptdesc));
 
 	switch (pgtable_type) {
@@ -509,15 +513,29 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
 }
 
 static phys_addr_t __maybe_unused
-pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
+split_pgtable_alloc(enum pgtable_type pgtable_type)
 {
 	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
 }
 
+static phys_addr_t __maybe_unused
+pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
+{
+	phys_addr_t pa;
+
+	pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
+	BUG_ON(pa == INVALID_PHYS_ADDR);
+	return pa;
+}
+
 static phys_addr_t
 pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
 {
-	return __pgd_pgtable_alloc(NULL, pgtable_type);
+	phys_addr_t pa;
+
+	pa = __pgd_pgtable_alloc(NULL, pgtable_type);
+	BUG_ON(pa == INVALID_PHYS_ADDR);
+	return pa;
 }
 
 /*
@@ -552,6 +570,254 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			     pgd_pgtable_alloc_special_mm, flags);
 }
 
+static DEFINE_MUTEX(pgtable_split_lock);
+
+static int split_cont_pte(pmd_t *pmdp, unsigned long addr, unsigned long end)
+{
+	pte_t *ptep;
+	unsigned long next;
+	unsigned int nr;
+	unsigned long span;
+
+	ptep = pte_offset_kernel(pmdp, addr);
+
+	do {
+		pte_t *_ptep;
+
+		nr = 0;
+		next = pte_cont_addr_end(addr, end);
+		if (next < end)
+			nr = max(nr, ((end - next) / CONT_PTE_SIZE));
+		span = nr * CONT_PTE_SIZE;
+
+		_ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
+		ptep += pte_index(next) - pte_index(addr) + nr * CONT_PTES;
+
+		if (((addr | next) & ~CONT_PTE_MASK) == 0)
+			continue;
+
+		if (!pte_cont(__ptep_get(_ptep)))
+			continue;
+
+		for (int i = 0; i < CONT_PTES; i++, _ptep++)
+			__set_pte(_ptep, pte_mknoncont(__ptep_get(_ptep)));
+	} while (addr = next + span, addr != end);
+
+	return 0;
+}
+
+static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	unsigned int nr;
+	unsigned long span;
+	int ret = 0;
+
+	do {
+		pmd_t pmd;
+
+		nr = 1;
+		next = pmd_addr_end(addr, end);
+		if (next < end)
+			nr = max(nr, ((end - next) / PMD_SIZE));
+		span = (nr - 1) * PMD_SIZE;
+
+		if (((addr | next) & ~PMD_MASK) == 0)
+			continue;
+
+		pmd = pmdp_get(pmdp);
+		if (pmd_leaf(pmd)) {
+			phys_addr_t pte_phys;
+			pte_t *ptep;
+			pmdval_t pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN |
+					  PMD_TABLE_AF;
+			unsigned long pfn = pmd_pfn(pmd);
+			pgprot_t prot = pmd_pgprot(pmd);
+
+			pte_phys = split_pgtable_alloc(TABLE_PTE);
+			if (pte_phys == INVALID_PHYS_ADDR)
+				return -ENOMEM;
+
+			if (pgprot_val(prot) & PMD_SECT_PXN)
+				pmdval |= PMD_TABLE_PXN;
+
+			prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) |
+					PTE_TYPE_PAGE);
+			prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+			ptep = (pte_t *)phys_to_virt(pte_phys);
+			for (int i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
+				__set_pte(ptep, pfn_pte(pfn, prot));
+
+			dsb(ishst);
+
+			__pmd_populate(pmdp, pte_phys, pmdval);
+		}
+
+		ret = split_cont_pte(pmdp, addr, next);
+		if (ret)
+			break;
+	} while (pmdp += nr, addr = next + span, addr != end);
+
+	return ret;
+}
+
+static int split_cont_pmd(pud_t *pudp, unsigned long addr, unsigned long end)
+{
+	pmd_t *pmdp;
+	unsigned long next;
+	unsigned int nr;
+	unsigned long span;
+	int ret = 0;
+
+	pmdp = pmd_offset(pudp, addr);
+
+	do {
+		pmd_t *_pmdp;
+
+		nr = 0;
+		next = pmd_cont_addr_end(addr, end);
+		if (next < end)
+			nr = max(nr, ((end - next) / CONT_PMD_SIZE));
+		span = nr * CONT_PMD_SIZE;
+
+		if (((addr | next) & ~CONT_PMD_MASK) == 0) {
+			pmdp += pmd_index(next) - pmd_index(addr) +
+				nr * CONT_PMDS;
+			continue;
+		}
+
+		_pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
+		if (!pmd_cont(pmdp_get(_pmdp)))
+			goto split;
+
+		for (int i = 0; i < CONT_PMDS; i++, _pmdp++)
+			set_pmd(_pmdp, pmd_mknoncont(pmdp_get(_pmdp)));
+
+split:
+		ret = split_pmd(pmdp, addr, next);
+		if (ret)
+			break;
+
+		pmdp += pmd_index(next) - pmd_index(addr) + nr * CONT_PMDS;
+	} while (addr = next + span, addr != end);
+
+	return ret;
+}
+
+static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end)
+{
+	pud_t *pudp;
+	unsigned long next;
+	unsigned int nr;
+	unsigned long span;
+	int ret = 0;
+
+	pudp = pud_offset(p4dp, addr);
+
+	do {
+		pud_t pud;
+
+		nr = 1;
+		next = pud_addr_end(addr, end);
+		if (next < end)
+			nr = max(nr, ((end - next) / PUD_SIZE));
+		span = (nr - 1) * PUD_SIZE;
+
+		if (((addr | next) & ~PUD_MASK) == 0)
+			continue;
+
+		pud = pudp_get(pudp);
+		if (pud_leaf(pud)) {
+			phys_addr_t pmd_phys;
+			pmd_t *pmdp;
+			pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN |
+					  PUD_TABLE_AF;
+			unsigned long pfn = pud_pfn(pud);
+			pgprot_t prot = pud_pgprot(pud);
+			unsigned int step = PMD_SIZE >> PAGE_SHIFT;
+
+			pmd_phys = split_pgtable_alloc(TABLE_PMD);
+			if (pmd_phys == INVALID_PHYS_ADDR)
+				return -ENOMEM;
+
+			if (pgprot_val(prot) & PMD_SECT_PXN)
+				pudval |= PUD_TABLE_PXN;
+
+			prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) |
+					PMD_TYPE_SECT);
+			prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+			pmdp = (pmd_t *)phys_to_virt(pmd_phys);
+			for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
+				set_pmd(pmdp, pfn_pmd(pfn, prot));
+				pfn += step;
+			}
+
+			dsb(ishst);
+
+			__pud_populate(pudp, pmd_phys, pudval);
+		}
+
+		ret = split_cont_pmd(pudp, addr, next);
+		if (ret)
+			break;
+	} while (pudp += nr, addr = next + span, addr != end);
+
+	return ret;
+}
+
+static int split_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end)
+{
+	p4d_t *p4dp;
+	unsigned long next;
+	int ret = 0;
+
+	p4dp = p4d_offset(pgdp, addr);
+
+	do {
+		next = p4d_addr_end(addr, end);
+
+		ret = split_pud(p4dp, addr, next);
+		if (ret)
+			break;
+	} while (p4dp++, addr = next, addr != end);
+
+	return ret;
+}
+
+static int split_pgd(pgd_t *pgdp, unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	int ret = 0;
+
+	do {
+		next = pgd_addr_end(addr, end);
+		ret = split_p4d(pgdp, addr, next);
+		if (ret)
+			break;
+	} while (pgdp++, addr = next, addr != end);
+
+	return ret;
+}
+
+int split_kernel_pgtable_mapping(unsigned long start, unsigned long end)
+{
+	int ret;
+
+	if (!system_supports_bbml2_noabort())
+		return 0;
+
+	if (start != PAGE_ALIGN(start) || end != PAGE_ALIGN(end))
+		return -EINVAL;
+
+	mutex_lock(&pgtable_split_lock);
+	arch_enter_lazy_mmu_mode();
+	ret = split_pgd(pgd_offset_k(start), start, end);
+	arch_leave_lazy_mmu_mode();
+	mutex_unlock(&pgtable_split_lock);
+
+	return ret;
+}
+
 static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 				phys_addr_t size, pgprot_t prot)
 {
@@ -639,6 +905,20 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
 
 #endif /* CONFIG_KFENCE */
 
+bool linear_map_requires_bbml2;
+
+static inline bool force_pte_mapping(void)
+{
+	/*
+	 * Can't use cpufeature API to determine whether BBM level 2
+	 * is supported or not since cpufeature have not been
+	 * finalized yet.
+	 */
+	return (!bbml2_noabort_available() && (rodata_full ||
+		arm64_kfence_can_set_direct_map() || is_realm_world())) ||
+		debug_pagealloc_enabled();
+}
+
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
@@ -664,7 +944,9 @@ static void __init map_mem(pgd_t *pgdp)
 
 	early_kfence_pool = arm64_kfence_alloc_pool();
 
-	if (can_set_direct_map())
+	linear_map_requires_bbml2 = !force_pte_mapping() && rodata_full;
+
+	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
@@ -1366,7 +1648,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 	VM_BUG_ON(!mhp_range_allowed(start, size, true));
 
-	if (can_set_direct_map())
+	if (force_pte_mapping() ||
+	    (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()))
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index c6a85000fa0e..6566aa9d8abb 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -140,6 +140,10 @@ static int update_range_prot(unsigned long start, unsigned long size,
 	data.set_mask = set_mask;
 	data.clear_mask = clear_mask;
 
+	ret = split_kernel_pgtable_mapping(start, start + size);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
 	arch_enter_lazy_mmu_mode();
 
 	/*
-- 
2.50.0


