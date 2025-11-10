Return-Path: <linux-kernel+bounces-894293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A036C49B36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A203A32A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707C2FF672;
	Mon, 10 Nov 2025 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lXDR4EPO"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021080.outbound.protection.outlook.com [40.93.194.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6B23B607
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815979; cv=fail; b=X3Msp0c3+n1WKkUP8ATqy97NG9RD3PWqHkNK0hgkccNPtvJXYvwIHN7a8e6ojO41xvse6VsL9uPgbpKrDz4QayV0uvITMOg/ZSjQMtdQXpptkilthVx0OKfovn5UGtBNllO2+oWUAddqvF6cN85Xv6nQxp5OD29zszk0nNi4Q1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815979; c=relaxed/simple;
	bh=eIdszL9xRj/gjwXRsJfONKHPgHL+jsn2lXYYBpn3y2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RC2WRfyYBGQuIp7UtjznvYhf3Dhyy3yHOtGM4XATyjl09PApCWlwXXKsJOxBVV22WXxifkgWOrB/M9hi88QT25t1xpR+eLNURLjHVv22ghPron8rNaxRvtTLZc39ulqBDT9M5r+CxQpGfLeCmGTJrFddOiitjKMrbfvR1zN8UCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lXDR4EPO; arc=fail smtp.client-ip=40.93.194.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6OaItHHLGuOoyWnyWAohZPk1Gvf1MV9xoSz7a0uWmu4Ce0IQOUMWZ5D6c+R04Ec4HErRnLQ2nZFBNiU0yRg7Um8coxgwh9qnsOdc7gs6TeHcL8ZgoCIvg3zutuf5Q0mu/tyUS8zv+odDfIsvxN/2A08GfuA0aPAfvAOYAgSvH33Qz8UK8SJf6x2/p/7CTwyu5e5g/6WCWIbis6dLnF6PeyfJ0xMOr5qeVQCYOwsrcpAc+jqKC9vtRfPeFRlAi0cFzgWv6UfpLkUP/KFcuDHMR5RzhEuACU5NJD81QhMuW9ZixQ6e5+8CPDQU7wpfPUzXtBaTmYSO8AMCe6ywHbtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS7jtE375RNEWL1lpOzpW2mSiZ/3n1N66IcApdVElKA=;
 b=jLI1KvESkR466Kx6SYfe3IcjTuCJyierQfLlFxEjFxO2LOcaJCkiwLUqpsP3CeGCT1hPM4Go4nrqunoAUVRwq4A+MQJd4G6+zBtejqMog8KsV11pfu12G0yn8dqbXoShn0n9jZXq6brN3MHim8kWylPK8hdRsUe7Ig/VERr75rf0WUNPGJNhjqfY8qzCsSb3SCq46UCmG8eVqce6vrx7EMllpWVhB/yEx6Lq0gp+hrouDWR2v5fUddYSTQ3eD0sehftHTOo5sua/HREHBqxBUrJE9UTvfcbn3S83NUzNwVXJSbTFiiO19g3OZ6OOZfAQJbwbUkgEUjaT066Wb/+ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS7jtE375RNEWL1lpOzpW2mSiZ/3n1N66IcApdVElKA=;
 b=lXDR4EPOHM0UR1a7Y+CqqNJEFWC61NOWxeZz/DiHJg9xM8A8ONySR0S5Bf6vNPx6xewzLHC5qcQeDhWcKLhai3gxSLaJg6qDLdHdSDtZo8WUcu3sQ4e81TtW8o1m1N55i5ZYySxxQLzOmAwuo+lo6PhmNYpLRyv0CD94I/yEvAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BL3PR01MB7073.prod.exchangelabs.com (2603:10b6:208:35c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Mon, 10 Nov 2025 23:06:13 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 23:06:12 +0000
Message-ID: <7010301b-5258-4972-ac7d-6451debcb5d5@os.amperecomputing.com>
Date: Mon, 10 Nov 2025 15:06:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arm64: mm: show direct mapping use in /proc/meminfo
To: ryan.roberts@arm.com, cl@gentwo.org, catalin.marinas@arm.com,
 will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251023215210.501168-1-yang@os.amperecomputing.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20251023215210.501168-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR10CA0033.namprd10.prod.outlook.com
 (2603:10b6:930:4b::28) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BL3PR01MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: f3af1c56-645b-482c-af91-08de20adbe3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejVOcE50NWlrOEpia09ZUktzM3ZXTDVQL2ZhVzQ4VVhHanp4UFk2bkRsSHZo?=
 =?utf-8?B?R3NyVlNWMzNhaS9oVit2UUhjd1l6OTlIK0dCMDRNdGRBOURJLzZmWGYzbHo2?=
 =?utf-8?B?ZDQ0LzRHeEFKOUpZU0dLR3JDcDhKQllObkN2VXpvTS9RVkNIaFN3cVJEVWJC?=
 =?utf-8?B?c0QrMFRlWTYyeFA4MDlXRmwzTnpWY21nR0FVdlEyekQzTGFOQkJKcC85VDkw?=
 =?utf-8?B?aFdYT3Q3ZGxUM0RGclVBZ0hRZFUxbStreHdJTlQxb2ZwNkpReXVGcUdJeWt5?=
 =?utf-8?B?L0pWL0ZQWjVBaVRIM2VFd2FKTDk4M2M1QUYxNGFlZ2ZqMzVFNmU4QzRHQXlu?=
 =?utf-8?B?cEpZeTRHMDVleUFnRWlUNEo2VXAzUWM2ZnU3ZDVseXhWSS8wUi96dFI5R2sv?=
 =?utf-8?B?YUFNT2VNRXdvVVJXN05GdWRxRUZUSWlYWXQxTUhPTkVLa2ZWTTlmNUp6OTE0?=
 =?utf-8?B?QklhQ1ZaRzFrWDZCU0FLZjR5cTkxK1Nnd1pwNnhuWFlabTBkdlJhRDdKck9y?=
 =?utf-8?B?Y2d4LzJkNzcrTGF6dmhQZmc5RithSDFDUGt4Q0hNM1RTYi9GSFpWTHdjMnBo?=
 =?utf-8?B?N3Yra2pJNE1peTRNZmdZNmp5ZUlyTXVzMklrZUlDeXErNFJxNldYUHZjMmg4?=
 =?utf-8?B?Z2YxNGFITm5xcjVVV2VObDdGYXAzVWxUNE0xcEg5cVo0MTZQRFJxWlNaUTZT?=
 =?utf-8?B?d1RBQ241V0xraTAxc3VuUmUvMXdjdmxnbytYdTgrU25ubGVhQ0xTOVVNZXNi?=
 =?utf-8?B?RTFsNnFHVjdFVVh5S3VQWmI1RVdZcmJmSGJQVnlaa1dHaFpJRzkxWXdyNlZa?=
 =?utf-8?B?MVA1RTdUMDJMZHMxMDRTdGUvaHNlMFhmMkFwNWZuK0hMRU9NMStOeWREZ3p2?=
 =?utf-8?B?NWVqUVErcEZudTNhSFdEM3lyVEpsQ2lmSkp3UFk4Z1pwei84WDgvM2tpbnBY?=
 =?utf-8?B?VVZOdzZHdDVaVHowcXJpTWtDMDNKUUt6YVROaXo3MHNqKzFPQjlrelcxWDdq?=
 =?utf-8?B?QmJxbVgvNkpUZWtrZjVzbUJZWUM0SU13aHBndnZDaDFqYjRmY2psNmR2anBI?=
 =?utf-8?B?QTJEUEZDUmk4c3h0TWl5Wkw3VWhmdDErb3M2dEorMHlDTDZVZjF3T1RTZ0t6?=
 =?utf-8?B?dEkzL0EzeVl3WUJ6bjN6VXhnVzJ4elVrZENmRmdKM3ZxT1ltSHkzVENjVW95?=
 =?utf-8?B?cStkNjZBc0VmVkdya1lRcnV6K3VhWUdhRUxuanFLNGpWREcwRE5YSWNBVFFh?=
 =?utf-8?B?L3hPRmlDUXo3VjNLL0JmQ2lDR3ZFaklqdGFZemFaam0wYXdFK3llbUJlTHdZ?=
 =?utf-8?B?L25wWlREZ1Z4c2d3YUhPVkpybG1qNGd6dWR6NzBvNGRuMWFXeWVHbUxxWEhZ?=
 =?utf-8?B?VEF1endnOTdZdTl6bCs4em5WZHlSREoycUN5RWZJMXNzZnhLcFpOV3drU3JO?=
 =?utf-8?B?bTdrTlNCVEREUE5sSjd0cWg2cHpaaENIZEVNTW53NjlaRUVDNlY1cUlTaXZU?=
 =?utf-8?B?ZmxCUmVWMzBYTVpOMGRjeGt0c1h2V3NHUXRUR2lETGNRL2VCNVRZbHUwdTR3?=
 =?utf-8?B?aGdNejdjdjlJVFZNcGsrdHN3YVI3MUR3Q0w4MEhOMW5tYmhHb3BOcXJPVWs4?=
 =?utf-8?B?eFd3Qll6NTZUd3JzaHpkSWFUMzIraFRGcUNWMStiQTZYTXAzcHZHaEtRd25U?=
 =?utf-8?B?MnUxK05pSkUvMC84RGV3ZUJ6eW5UdUlmTGFqK1FBOGVXaXljZm1JM2VjQUlq?=
 =?utf-8?B?bTNaNDgyMTduZ2JaL0d1TUFMS09vK0NUS2dBbDF5ZkRPd21RcjJwZ05aZlUz?=
 =?utf-8?B?RXp6UGxwdUd6dlFHWlJ3cHFxQXR2OHFGd2JXV2lRQmllNjhRdXN3dGRiK1Ur?=
 =?utf-8?B?blg1Q2dlWVZRS0svS3h1S1NkL04zdDZrSDh2Sy9RTy9VejVSUzFFMCtjR2t4?=
 =?utf-8?Q?Lk2HGUD8mjQMkmCmfaADsE8Oy7fMr9e2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHlPMzJNbnQ3MWFFb2dUL1gwTEw2cXVBT3c3UWF1WmhSY0VlMG5HNVVVbUlR?=
 =?utf-8?B?Smpxalh3bkF3Y1RtSEhtK0hKdFBsclRmdW9SRERVcy8rRDNTakRqS0RoWjlK?=
 =?utf-8?B?RkQxeExRSC95U3pQYnpIWlYyeHBKL0VyWkhKMDA4NEFuRlBiTlcydmFPWVV3?=
 =?utf-8?B?RUpjRm1MRTBQeWZhYU8zQXF0ZzlST2FzSFNNQ2Z1bFR2WmdpeFZMNTF4MW5m?=
 =?utf-8?B?bitwdHlSWFlSSk91aWxVQ2pxZGZlZmFIelNmcnJMMFg4cjF2eHc0T1pYOURu?=
 =?utf-8?B?bkNJZGhFTmdVTkhQWVJxbm9LVC9qMlVicHorVm45d0FyM3ltaGd0alp4TTBu?=
 =?utf-8?B?Nmd6RVI0em15RjVYRHRJNjhISC9SNERYTTN4WmlIbXZMMU5PMnZaZXNiR2Vn?=
 =?utf-8?B?V2pSQy9oSk1OUDEzTmdBTWl2aG9FUVlHbWhLRHA2UkhJWTJjTXdnc21aUEY0?=
 =?utf-8?B?RnJDa3duaUY2UFlkWkhTZ2s5eWg0TTJSM1NtbUxkMnhMZ1h6UGkzaS94UVph?=
 =?utf-8?B?Y2lNZkk3ZkxQcUdMUkRVQWY0anpIZ3pWSEtkSjBhdHVZd0lkWW1Xb3g1QVd0?=
 =?utf-8?B?ZUlZN1BmTWtSNzlMUDNMMGFiaStSZlpBMm1ZZm85MmdyNXQ5L3RBbGx5QXd1?=
 =?utf-8?B?blNwQzVEaGlkYXlBcTVrVDRiSXRlak9XMzM1eFYxbG13azBkNXlyNHl6R05K?=
 =?utf-8?B?dE52d2VDQWtVcmtiMnFDNXZ2bXVncWdRV1JwYmNWdjVQN1Y1ZXl4T2d4UXpT?=
 =?utf-8?B?aFpTRStNVXQweElWdjlEd084VitNL1FSNzlnVTdtbUsrYkVPQlZYaGxNYmt4?=
 =?utf-8?B?dmREVFpTYXhKeXhITDZJaW1wUzB2Y0FWdXBTT0ZLeGRIVGswUU1WQVJ4M1JW?=
 =?utf-8?B?MkFtbTA2MmF5YnZGY0dUc0NZelJXcDltYUlvNWpzYk1jZm5pMVgyeVN3ZWh2?=
 =?utf-8?B?eklTWi9oSlVmdURDWWx0N01MUERYZFpJc3dLZEg5SEY0OFhPYStIL2RRSVN4?=
 =?utf-8?B?NlJ3QU9pQ2c5L3J1V252U0VLUGtKdFQ0Y3BrWGxWSUNjR3o3Q1RpVWZVNFdv?=
 =?utf-8?B?L01jRE81eDhnR3V5L2Z2SzQ3UTNYZTczZkpvVzl1cFo0L0RwY3E0dy95ZSsy?=
 =?utf-8?B?czNjMGFHYkp4THlRYjVlbk9nY0JTNithelZhK1ZnZFo2Uk5DT2tiLzNEVE04?=
 =?utf-8?B?dGduc1BQcUYvSUYxcElVWUZhOFR5eHBTU25MVkVhQm9VZUVwTEJWY0tibEds?=
 =?utf-8?B?WEJxcXpNNExmVzZYaWQySURiK21XcG5BeU02U1RPYmx6dEJyTkdvSHlpdTlD?=
 =?utf-8?B?Vk1QZHFEa1RuTFhyU0tyQ0UraTdvZXpCVEltWG96UkwxUS8yM2FoSUhGTGtJ?=
 =?utf-8?B?M2hQZDZ4V1IxTVpnR0o0K2hIeEpLbGlraUdiZ2owOEwrMC9hRk80WTRBdHZp?=
 =?utf-8?B?STJ1UWVGRHVXQmh0NnFSb25kNDkwajNKVnVOYTZhZXlnc2hlUUtsMVUySkIx?=
 =?utf-8?B?MmtKQzZaSTZxYy9LK1R4VVBvc2x0SlR3TDZWelVZZDgzaTN4UlNyb0I4ZnY3?=
 =?utf-8?B?L0VUNy8yRldPQndVMnpOYmpDdFBFcktjRzlxd2UvaGZYNHc0N0JHeTE3N3VO?=
 =?utf-8?B?MkIvQzhpUVBnclVHV1ZqYkYvZERFbjlmdEVuNXoyNndvd0VPZVUybC94T0Nh?=
 =?utf-8?B?ME9yMWh1TE5UeUlvcDZ5NTdkcFhKbUJyTFVMWnUxWjgxZ25FWjdBTnpYcnhE?=
 =?utf-8?B?ek1JeHJyNDJOd0ZadEc4SFVqT1N6UlFVSGJoOGZ1dG8rT0lwaGFUdWJxdnhX?=
 =?utf-8?B?THlvbjdOR3JmemllOXlNOWdCVTlaMzQ2RE00T2pXdnJYeVEyaVRLYS9tQkdO?=
 =?utf-8?B?ZDkrTmhaU0N1cUptN0t0MW5aOFBOaE9hZFhGSTNGOVQ5VG9TN3d5S1NPVmtt?=
 =?utf-8?B?SzdBTXFxVDNkaUdMQkJ6bDVwc0NmQlRhRG54eXhZVnQ2bVVncHVSK1Qva1Q4?=
 =?utf-8?B?SElmWVk2akdpbVMyUm1hdlRETEliWnU4TEVjR2hlVCswTEg5YWVJZ1ZDNXhW?=
 =?utf-8?B?Q1doNTFMMHdvWm1YL2czR2EzdG9sV0tWZkk5N3lpS3pZa1lGMjlINnVxcFdQ?=
 =?utf-8?B?SWNvN3BWdDRwWWtIY3BBazFlclRLeGZyb0o4THVDek1oZjV6TENzTk1sRmdW?=
 =?utf-8?Q?VIsKw20xk01xGMa3XJAIFog=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3af1c56-645b-482c-af91-08de20adbe3f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 23:06:12.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUGeP11NcGvkVRj/l0+A8uxVFSUx0WWWjEOgJdZ090tlChyxBrVbBlae0auoE84nhD8XOpeuD07WKj8yrfTVT6DYilQslj8sdNwF2RiOny4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7073

Hi Ryan,

Gently ping. Thanks for reviewing the v1 patch. Any comment for this 
version?

Yang


On 10/23/25 2:52 PM, Yang Shi wrote:
> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
> rodata=full"), the direct mapping may be split on some machines instead
> keeping static since boot. It makes more sense to show the direct mapping
> use in /proc/meminfo than before.
> This patch will make /proc/meminfo show the direct mapping use like the
> below (4K base page size):
> DirectMap4K:	   94792 kB
> DirectMap64K:	  134208 kB
> DirectMap2M:	 1173504 kB
> DirectMap32M:	 5636096 kB
> DirectMap1G:	529530880 kB
>
> Although just the machines which support BBML2_NOABORT can split the
> direct mapping, show it on all machines regardless of BBML2_NOABORT so
> that the users have consistent view in order to avoid confusion.
>
> Although ptdump also can tell the direct map use, but it needs to dump
> the whole kernel page table. It is costly and overkilling. It is also
> in debugfs which may not be enabled by all distros. So showing direct
> map use in /proc/meminfo seems more convenient and has less overhead.
>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   arch/arm64/mm/mmu.c | 86 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)
>
> v2: * Counted in size instead of the number of entries per Ryan
>      * Removed shift array per Ryan
>      * Use lower case "k" per Ryan
>      * Fixed a couple of build warnings reported by kernel test robot
>      * Fixed a couple of poential miscounts
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b8d37eb037fc..7207b55d0046 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -29,6 +29,7 @@
>   #include <linux/mm_inline.h>
>   #include <linux/pagewalk.h>
>   #include <linux/stop_machine.h>
> +#include <linux/proc_fs.h>
>   
>   #include <asm/barrier.h>
>   #include <asm/cputype.h>
> @@ -51,6 +52,17 @@
>   
>   DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
>   
> +enum direct_map_type {
> +	PTE,
> +	CONT_PTE,
> +	PMD,
> +	CONT_PMD,
> +	PUD,
> +	NR_DIRECT_MAP_TYPE,
> +};
> +
> +static unsigned long direct_map_size[NR_DIRECT_MAP_TYPE];
> +
>   u64 kimage_voffset __ro_after_init;
>   EXPORT_SYMBOL(kimage_voffset);
>   
> @@ -171,6 +183,45 @@ static void init_clear_pgtable(void *table)
>   	dsb(ishst);
>   }
>   
> +#ifdef CONFIG_PROC_FS
> +void arch_report_meminfo(struct seq_file *m)
> +{
> +	char *size[NR_DIRECT_MAP_TYPE];
> +
> +#if defined(CONFIG_ARM64_4K_PAGES)
> +	size[PTE] = "4k";
> +	size[CONT_PTE] = "64k";
> +	size[PMD] = "2M";
> +	size[CONT_PMD] = "32M";
> +	size[PUD] = "1G";
> +#elif defined(CONFIG_ARM64_16K_PAGES)
> +	size[PTE] = "16k";
> +	size[CONT_PTE] = "2M";
> +	size[PMD] = "32M";
> +	size[CONT_PMD] = "1G";
> +#elif defined(CONFIG_ARM64_64K_PAGES)
> +	size[PTE] = "64k";
> +	size[CONT_PTE] = "2M";
> +	size[PMD] = "512M";
> +	size[CONT_PMD] = "16G";
> +#endif
> +
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[PTE], direct_map_size[PTE] >> 10);
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[CONT_PTE],
> +			direct_map_size[CONT_PTE] >> 10);
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[PMD], direct_map_size[PMD] >> 10);
> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[CONT_PMD],
> +			direct_map_size[CONT_PMD] >> 10);
> +	if (pud_sect_supported())
> +		seq_printf(m, "DirectMap%s:	%8lu kB\n",
> +			size[PUD], direct_map_size[PUD] >> 10);
> +}
> +#endif
> +
>   static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>   		     phys_addr_t phys, pgprot_t prot)
>   {
> @@ -234,6 +285,11 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>   
>   		init_pte(ptep, addr, next, phys, __prot);
>   
> +		if (pgprot_val(__prot) & PTE_CONT)
> +			direct_map_size[CONT_PTE] += next - addr;
> +		else
> +			direct_map_size[PTE] += next - addr;
> +
>   		ptep += pte_index(next) - pte_index(addr);
>   		phys += next - addr;
>   	} while (addr = next, addr != end);
> @@ -262,6 +318,17 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>   			pmd_set_huge(pmdp, phys, prot);
>   
> +			/*
> +			 * It is possible to have mappings allow cont mapping
> +			 * but disallow block mapping. For example,
> +			 * map_entry_trampoline().
> +			 * So we have to increase CONT_PMD and PMD size here
> +			 * to avoid double counting.
> +			 */
> +			if (pgprot_val(prot) & PTE_CONT)
> +				direct_map_size[CONT_PMD] += next - addr;
> +			else
> +				direct_map_size[PMD] += next - addr;
>   			/*
>   			 * After the PMD entry has been populated once, we
>   			 * only allow updates to the permission attributes.
> @@ -368,6 +435,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>   		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>   			pud_set_huge(pudp, phys, prot);
>   
> +			direct_map_size[PUD] += next - addr;
>   			/*
>   			 * After the PUD entry has been populated once, we
>   			 * only allow updates to the permission attributes.
> @@ -532,9 +600,13 @@ static void split_contpte(pte_t *ptep)
>   {
>   	int i;
>   
> +	direct_map_size[CONT_PTE] -= CONT_PTE_SIZE;
> +
>   	ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
>   	for (i = 0; i < CONT_PTES; i++, ptep++)
>   		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
> +
> +	direct_map_size[PTE] += CONT_PTE_SIZE;
>   }
>   
>   static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> @@ -559,8 +631,13 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>   	if (to_cont)
>   		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>   
> +	direct_map_size[PMD] -= PMD_SIZE;
>   	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>   		__set_pte(ptep, pfn_pte(pfn, prot));
> +	if (to_cont)
> +		direct_map_size[CONT_PTE] += PMD_SIZE;
> +	else
> +		direct_map_size[PTE] += PMD_SIZE;
>   
>   	/*
>   	 * Ensure the pte entries are visible to the table walker by the time
> @@ -576,9 +653,13 @@ static void split_contpmd(pmd_t *pmdp)
>   {
>   	int i;
>   
> +	direct_map_size[CONT_PMD] -= CONT_PMD_SIZE;
> +
>   	pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
>   	for (i = 0; i < CONT_PMDS; i++, pmdp++)
>   		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
> +
> +	direct_map_size[PMD] += CONT_PMD_SIZE;
>   }
>   
>   static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> @@ -604,8 +685,13 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>   	if (to_cont)
>   		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>   
> +	direct_map_size[PUD] -= PUD_SIZE;
>   	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
>   		set_pmd(pmdp, pfn_pmd(pfn, prot));
> +	if (to_cont)
> +		direct_map_size[CONT_PMD] += PUD_SIZE;
> +	else
> +		direct_map_size[PMD] += PUD_SIZE;
>   
>   	/*
>   	 * Ensure the pmd entries are visible to the table walker by the time


