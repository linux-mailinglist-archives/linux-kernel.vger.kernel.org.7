Return-Path: <linux-kernel+bounces-838977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A30BB08DC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33858176921
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB262F2D;
	Wed,  1 Oct 2025 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="agqMDJUa"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57022EBBBC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326387; cv=fail; b=iZ/EhMmv/yd/I1C1wTUKenpygPJ8uAKWOzvkIY2asxFq2aSvaKCLAP9jjlP62szvQrVyMe6MsgOfFEAiN74LgwcXBOx/CPfb90ahAS+JFV/YbHdB2V1tE+/EzRALBggmGut94BZ7oJDh1BRA1M9rPEtg35JX4ND7novdTlB+qsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326387; c=relaxed/simple;
	bh=Knj/qh21kaV9yD/5q2BFgr2EdnrQeg1FoFbtKDyggno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QWYw7ObIbPqOFDo69V8aK0/pHr2R0P+U8gEUfiLX8oQGksrVe/ypa5FipdBQK86i2PsFXzF0rjYniADucuqaRHIC51f+ufnDIRHxqMSISNN7t65iLs7vu7VbGwFgWgnwRGwarJoOMQZz882iUsO7jWACerjMGEE/1Q4hCTQv04U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=agqMDJUa; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcK9EbPfWfwfZZRx/u/T1F0px3R+9rKN7juGKDN7znlTwVr6xprnyowvFsm1ZUnADHPUcbDip6n5BAACL20jYql64Gp7x8Kmwp/+WGu3LiG+0UCBIbkYozAY5ANDbujydC3EfaGbRX1EFV3ZwS/oKVkkiDdt7SPN4oxezqme1mii8r4hy8jkFlxu6maO/02Ly6+iAiQpA8IDqBGvH3BekAkZYAS0gBnZfJ2/DN7BVzQvgPF3PyJYtumIsUfFwhp2mnIbVEXH/wABMgOBYs5Lcn/1THilkPzLYwcovwz6LliR34/Y2uWx1LQlVkmJuoDX+J0k6au0fX4oIlWXzlgVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+bpABuKEqMWRW3gynMQMVQnePgv4FZgnneBNTyo/Oc=;
 b=HBvnPNXEy33NxZbMG+juzC1vFWo+5YHeAYfXH4qyIJ7oHg2HjCF6RDQtLHSTdkIQOPVZz7gKfb/uQD5ikwH8ytQ4tHgSWmyFZIFJLKqK7EOEm6kI1jeo460BlsvzoKZUWBRaj7NK53+2cFIBxaLN8pAJbT1Uf7IimS3EOO67qxNOFsSwkiT6rRPR8Q6Fw4u8G5a146CJAiSK52UBq1kz4Gtvf3i1hXwtiUQPmbBQg300uhdiZN1ZP2GoqVzZKM+SSKJ1gHxHg+zBDRaVPm2OzDQM0RNDkxCq0LugjpypDj+77Xkzh4QnhwLTJt3h0vg9EoGO4tHtMiahtekKuop1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+bpABuKEqMWRW3gynMQMVQnePgv4FZgnneBNTyo/Oc=;
 b=agqMDJUa0QSyKdCG6VCW8NVG7nEiE2ZIM4xg89XgFa/lLqb/h7qufG8Z+Ks68YKWD691nUptSYU3MvV4BWbYO9aUmxJ+3iOmV1ZBa0vV2PsDeOvO8VehfHsi6mNOaGNnPIb6ejeldczJEJZbb6dkKO20o3+Z/pKMvqVdvSv/wFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 13:46:16 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 13:46:16 +0000
Date: Wed, 1 Oct 2025 09:46:12 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Filip Barczyk <filip.barczyk@pico.net>
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Message-ID: <20251001134612.GA738751@yaz-khff2.amd.com>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
 <94cd8a1f-1f2a-4cd6-8ab8-49b9d1e9fa2d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94cd8a1f-1f2a-4cd6-8ab8-49b9d1e9fa2d@kernel.org>
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: da72c9ec-cef3-438d-b61d-08de00f0e4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WClhLTjI0UsgDFA19COtkKdP5rvlf7Zh+LbqN4WmmpBPfLhjCMaTpyBy7w/A?=
 =?us-ascii?Q?6TPCqdwqkamjEJOYUZLa4FaR2QY5zmN7aFsb+P3pgIDFMXcorD0DgCN4N05r?=
 =?us-ascii?Q?O9LSiYAgAFcycgvEbT2lYtkLed+2keBOjD8CEtjzOe2vPwzep9EbkGv2fDTt?=
 =?us-ascii?Q?0Kttsrym6UxTevqYkkFmMUgdPi9zZEIHp69KB1Dhj1DRwzQKeYAu9ru0Hqce?=
 =?us-ascii?Q?pXkFYoD89cp9QIm2nBHkRZ3gMLUf5YvbwVW0dH+C7WvOvzpbdbnhcZ7LF38A?=
 =?us-ascii?Q?fkVj2/2yeXgCLifw/4E77hGd4Ji4VWmAKQkGwk3vKv6Q2yHmVd6cJpwUXeFc?=
 =?us-ascii?Q?SeyCMMp+rYe8d+UksGOFiSXkCbyPkwl9on/c7nsgpPZNyYarYir0mVbTs3Rq?=
 =?us-ascii?Q?qI/5SBmLqDWt0mHdJXVPhvJFzM/webyGnV2mUdQc5tXsmP6ZswYqgNShHyNN?=
 =?us-ascii?Q?zRBnlVX6HJ1K6wVNQ/C/PpUIR81KN2K817k4SoNaSzWlmkbi5+kqduS5disI?=
 =?us-ascii?Q?a0VJo/BpYd/ndwFq0Aj0Agw7Csd0TiMbwCoMsyxJdbBFWv8kSGH7wdT2qsOn?=
 =?us-ascii?Q?0TrGMKsKm3xzVHsED4f/jl/4/iNnitb0dO5PexebUe/CsCHseIBiac4HmfJF?=
 =?us-ascii?Q?qY2ucNHW/czmecyM+pHHx4C9ORomEM7X4iCBZtPksCskoXGhDmy1g0P9eBDJ?=
 =?us-ascii?Q?/zlR3RK8eO0i5FgRxB2o1n8tXCppVEEBmoFdnuJSmxDsInjregxceGmcr4Bj?=
 =?us-ascii?Q?Jwyu33kre4XddXGNCpTpJzOHYshlRonlKwaOG9BA4s7myYkyN5waLRh5+WDW?=
 =?us-ascii?Q?+/h/CUZ+c/fWnPFQfOEnESsJqnw0E36oh71Nqors+jwObhuRbMB064mAyU0b?=
 =?us-ascii?Q?n3pLx9C45rUMATd6FcQUHGhSZS4nRM4SGoVuVq3njJTq0XZw2jC9iuFe3AaM?=
 =?us-ascii?Q?NdVHJR/K2g4BaFwYJyVpKqO7PNuh23a3dU844uf/4+99NcM7WSXw4iF1k8DM?=
 =?us-ascii?Q?GpMMq7YvP/lU9NxqWCuXOCFxi5e681mUv3ysn0woSCNXfoFOmtJdiE7CEFRn?=
 =?us-ascii?Q?QrDp5v4p2HskgGRd03A1ivDX2FYQhAzbIZX0f8uPhOT+ed71D2dk1ybAvWpm?=
 =?us-ascii?Q?Ifd0RIS5nDm23VNQkrPPNvdMP3SyuOWYaxeodYlN2QNVlfhyRpzU9oxgl4Hp?=
 =?us-ascii?Q?iA34BjpkdZQ2AkZzGZci3ugFawuxONVykDYMF2rH6bJRVzZGGYvcSuxhfzj6?=
 =?us-ascii?Q?IWtI+GdssURnAts77Za+bNK0EKaf4remg+KtYcoQRMCZVoNrEsHwCSHahxYh?=
 =?us-ascii?Q?EmJeE7vKKiThcpNBQyEctwKVWqwC1TA/L1iz/LhdAvmJYlomb4CyS693Be2e?=
 =?us-ascii?Q?P5WlT9H+ItA2hWkX92oVjzBUqsEI2PK+M8bplgxt9c5OUbJxbtEW9sN6eZaS?=
 =?us-ascii?Q?DdP2GjthYapw/ThHPib4Mg5uETmidgal?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CiWDqfkPrdReS9DMQ9UOTFnmIvPWn1MavuCcfw1F3z1MQc5sk2vRA/d3o/x4?=
 =?us-ascii?Q?8dfeW11OQvm0WrI0D5SI3BNdCb4X/5/ph+c1VzXd7AJ25SsqiSeYITBL3S8i?=
 =?us-ascii?Q?pyaIyun62/uqLNyOpt79eUymyAU26eg5XW9MxloIFAg17TWg4LEJRNg3V0I0?=
 =?us-ascii?Q?Xc+nS3Hw0lX9rPlWIPuc5WtPm/VwTgXoogj2IuOaKbBGA4pR7Ymb6tRgUkTG?=
 =?us-ascii?Q?s6rDE5zzpG8xmnzVmbfTo+Ryk6pPGGokrmodX44e3IWzzBFoouIKhANWIRfb?=
 =?us-ascii?Q?Jyf7AtsGIMH3wCPMzJqlWSss4xWsRnez5qo+dbZRuGEM624gWAFZoDgt3vMm?=
 =?us-ascii?Q?KRkABn6o6qzhzwBVpUdYvQKduz5dR6/+COjKZLiDuerZCoWnNMcsRms4pCl5?=
 =?us-ascii?Q?BG/Gji6o9smpmtiduQDnKA4IG+bhBoMc4jRfWNMhoC0Otm0xVJ7k3Z2cDklT?=
 =?us-ascii?Q?01vtx9FShPERjseATQAEp/wS+24ngkk7/zGHxllfwcf88igl74AbV8o9hfB1?=
 =?us-ascii?Q?w3g5JRu6sBLsv2fraHeBiSUBefKXhfwVympepRg8+EX4ax/j3Bz3/XQguXxT?=
 =?us-ascii?Q?CEJzJjuf6DlwFy95Z8xsutTBSnwp4C7BGs7BL8DUG6eg64BuPmBvcq+JQymH?=
 =?us-ascii?Q?eo/iyi6Bi2g5QWtR2x2ADCxhMRiLeQtVXixdTEdJoeQ/WIt43JUW8TAbqI8C?=
 =?us-ascii?Q?y9ofih5eeIemD/ujPa3CEdQ6byg2NNmtPesvvSQc6aoBmH8b/yTfxuPUMXBN?=
 =?us-ascii?Q?i4kwZaYa42y1EvVf7OwY4eDM5ezcanPnwSg7AlFsX6SrstB/SlMnX/plxZ8J?=
 =?us-ascii?Q?7FVeMQ7Uzw5SRmM9UkMD835h7B0Qdq5dNKkJmuNB6hkMNwcGYZPC0vpp64C5?=
 =?us-ascii?Q?rslW9mG++255QxJ77bsqOABqqDUvnENzAybo0yNna6smmZtXtwJjRG5Z/cAg?=
 =?us-ascii?Q?lZOirUI49e1DYUcRJx1JwvC8rb7p10W6sAcjD5RysZ+M3s+FPtr2qxCSUS2E?=
 =?us-ascii?Q?z6nsy76ezijyVw/J7WTat+UWquHy196ESovfPrKFqRPA0c/vXxQ/ng8jBOGd?=
 =?us-ascii?Q?xKhhbMKspLleDl6+bD0z9ZQcSmfsajFM6oiaxAWsc3wHmA6F46H60CzU1qGB?=
 =?us-ascii?Q?DyQKFxsJIjtsZEoadXKrqrK+F+ob9y7Nb2nVX/M5ICF3g3WqYcfK/ExZNeB2?=
 =?us-ascii?Q?oidRyDWSr5Id5NEnYn7l9dx5MUfFU+rT6CiFUiRwG5vpYcD8kST16IvZlHMS?=
 =?us-ascii?Q?W1NHw3BHAQyBy30fEQ/pri3SD9f6QbVD6dmEGIRo8vYIobPF9l8VEU8QKWBO?=
 =?us-ascii?Q?ig4n3jijQe6KHas2QkB7Plz5/LejPBHvAcIzg9eBAjt/msumx8BBrSsQeB4Y?=
 =?us-ascii?Q?oepu5+NpNRUnYpp73Y+zsz36ftUIBh0qaR2WIbf2wbBV7UpUqE7dGccW+uoz?=
 =?us-ascii?Q?BZSRGULXuiVDHidIxxOllGDgNLlYYAlx/JYEqGtOtmRBRFwhr7X92edZOz3Y?=
 =?us-ascii?Q?TgQkEVnMgMAS+ef7uFcLBEo2Oovx6Tu1oVLVNJNvpolIo8bVr7J0iHpkgvb9?=
 =?us-ascii?Q?uizoSnSKwbUDN3gKnmKoUYC1wBQp0tHSYF0PKJy6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da72c9ec-cef3-438d-b61d-08de00f0e4a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:46:16.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cc+o2XOwOncvXrdcozCEe7nXOLwBIjt6o5tf1LuSI+hGXMTXRlrR+zaH8D/bJ8WwpW2rJHdnYlCynreMyWiaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006

On Tue, Sep 30, 2025 at 01:07:47PM -0500, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 9/30/2025 11:45 AM, Yazen Ghannam wrote:
> > Recent AMD node rework removed the "search and count" method of caching
> > AMD root devices. This depended on the value from a Data Fabric register
> > that was expected to hold the PCI bus of one of the root devices
> > attached to that fabric.
> > 
> > However, this expectation is incorrect. The register, when read from PCI
> > config space, returns the bitwise-OR of the buses of all attached root
> > devices.
> > 
> > This behavior is benign on AMD reference design boards, since the bus
> > numbers are aligned. This results in a bitwise-OR value matching one of
> > the buses. For example, 0x00 | 0x40 | 0xA0 | 0xE0 = 0xE0.
> > 
> > This behavior breaks on boards where the bus numbers are not exactly
> > aligned. For example, 0x00 | 0x07 | 0xE0 | 0x15 = 0x1F.
> > 
> > The bus numbering style in the reference boards is not a requirement.
> > The numbering found in other boards is not incorrect. Therefore, the
> > root device caching method needs to be adjusted.
> > 
> > Go back to the "search and count" method used before the recent rework.
> > Search for root devices using PCI class code rather than fixed PCI IDs.
> > 
> > This keeps the goal of the rework (remove dependency on PCI IDs) while
> > being able to support various board designs.
> > 
> > Fixes: 40a5f6ffdfc8 ("x86/amd_nb: Simplify root device search")
> 
> Was this a publicly reported failure?
> 
> If so is there a link to LKML or a Bugzilla with the details of the failure
> you can include here?
> 

No, it was reported off-list.

Thanks,
Yazen

