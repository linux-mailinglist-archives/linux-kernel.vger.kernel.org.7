Return-Path: <linux-kernel+bounces-870830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A68C0BC78
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05A824E23E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0423D7C3;
	Mon, 27 Oct 2025 04:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kny7KMOF"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A41C1F0C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761540468; cv=fail; b=YrU4btKgWTOo81uL0Z2PNsrHv/J4F69hIi79Jn4gZyA0O2J9zwX3greC5HM7+zBhFLsIe/sZa723wrMcaOC/P22oAYTxT5OfHwvCnIms7G6xKES9Xn7eLPSn9tHX+onyGxAUsMfhzymCLfE/VEtNbqVeE7nl21ftbzscFIfaCBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761540468; c=relaxed/simple;
	bh=P68RYb9P3P/RgTqKPAodPlZ/ZvBFZDetsi0IJG+tWGQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=BEWpZcI16R0Vkq/7WBSvbWsHYia934jYnCTxrJPMrqnD+CnyHpcXZ96POc6UBBxSLMci+AGwL0pd9XArdBQvoD52y46Dff5UpdKV+l1zaclPwW4TbyDqPSpYIOkzqmOevd7UrITK7QLFxlTMn753nQ97GSRIgg58G0WxuBv8wvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kny7KMOF; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBMzEzPmtKi0gBjxl3FwzzWs8y8Cq263/mc2gAtmFaAkG4fomEJoLjp7e+oCzLt3KLtUz5yTj04E8l0qRlbQGVSl3X47uKAcdawxCg7TSDfJwPsHd8mlXRY+fZAiXdk+aG/kwlavc3LElxg0EzTqrLOHcRxhUgTn6lluYvg6XGHQzRNHvYVbzvYT8RGPg9JcdVLYp29+ub3zHzzSoBfVw8B9SxZVcV3qbLSDbYH0yh3IJP/M5/zj2lcvMzyuN+x5Zq02WjJKWEzVqqf8sIwTwAVP8A5i5EF0f8nT7qXCLqzIUYSR5lvh28MbuptfsFy8EtI+7bV1yfT7W8JqugfUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFUdxllGL2rzZacBX90Dwe/XSjWhoVy3IXpRWId3CH0=;
 b=JGIVG3LwD7VM5BML+khf2Zn8PXeuAmyZfLGByi+KEGEzqgvqzlQrSEDKtv65HBo2VaQcsJNNe7zl2ElTGBsHLjnzJbpJLWq/U4KnmRifbMw7AHC6TEgi150RINsBNkZiCbnqxe/ACw6tR/TovdnynJUvyNuFfcKrEZhb+cyeHYcshNYMCYjm9K+jt9XUgDKQOWvA5xfgQLflQ/LoR77dtBFGbYim7MgJeycplzQYrTEZUSZnXpOApGP4OQqQKbmqP2ZTOrD8rSrsVkJeeRHyvCmqtcWgG/fagth6VcOBQ0lUDd3JYxK6t/MYHOzKKfCYnnC/FrTUUMr3yE31s3MsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFUdxllGL2rzZacBX90Dwe/XSjWhoVy3IXpRWId3CH0=;
 b=kny7KMOFlbUjuiQMPGeT3eOFl2WWZ8ltgTd6noCOAP3ItUDfPKsvSp6+m+5Esq/zsTXhUURqqD3L0mY0TcH4V7EmjZC2c4XGBNpIJzeTIYVzwJjt3tt36rAzT6i5Q4/Cke7ji3XqdKGSz4bRwQJI4mkqJvnTxBLj6Sow35j2siA=
Received: from CY8PR19CA0031.namprd19.prod.outlook.com (2603:10b6:930:6::16)
 by IA0PPFF4B476A86.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 04:47:43 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::39) by CY8PR19CA0031.outlook.office365.com
 (2603:10b6:930:6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 04:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 04:47:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 26 Oct
 2025 21:47:41 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 26 Oct
 2025 21:47:41 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 26 Oct 2025 21:47:34 -0700
Message-ID: <78c81f74-7b27-4f28-9ca2-0d1e27ed9c56@amd.com>
Date: Mon, 27 Oct 2025 10:17:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware load
 balancing
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu
 Chen <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, "Vern Hao"
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>, Libo Chen
	<libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
In-Reply-To: <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA0PPFF4B476A86:EE_
X-MS-Office365-Filtering-Correlation-Id: 372e3f81-76b3-4f5b-2977-08de1513f681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|32650700017|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFh2TG1lYlJDTHZJVXp4WFFHMis3YXYxWCtScmdQMUlhMDNEOVd6alY2ZEkx?=
 =?utf-8?B?ODUzU2MyZCs3MCtXWmRnbHZDc3F0Y1JvMnozekdFMytVbERIUnpUYVgvallW?=
 =?utf-8?B?bi9qMkFtMUdVNHpRSVhSN0RQdjhDTnhHNG9Kc1d0bldFOGJwaVFqN2N4QUNK?=
 =?utf-8?B?VVVFRXBVM2o4TnpyS1EyaTAyZUFrZ3UxM0hLOEhIOC9ob2N5QmdlamgrS1hR?=
 =?utf-8?B?azhXdkUvWHpsODZXVDA2QUtsVXpjVjVvNmFvcXpleStLeUg4SGdIbVRnMUE5?=
 =?utf-8?B?SFpQZTlvb0E0Tk5jcjZhMzg5VjA2ejVacHZlZXlrQmtlR2lPVDVQSzFqcW9h?=
 =?utf-8?B?elFhdzB5b0cxVFh1SmlNVlpnVzNYdTVyeHA3ZS9kajVkbUxzR28vNFlvOGtT?=
 =?utf-8?B?TGlLZFhTYXdNMEFkd1RCbnRQY21WbXRWTnZSTWxLOVBoWnlzVkljcG9OYXoy?=
 =?utf-8?B?WVI0R0ZLSzQ3aXU2Y0lQb3NPRG5ibmRnaDdRYzNhdTNqMGxXdE9wVHpWejVM?=
 =?utf-8?B?U2hzZy8rMlpSQnA2Sjc3aG1RZmdEbUVYbmVZTXA2RWs0SXdjUmcrWk1Nc3NS?=
 =?utf-8?B?VVd2S1VNOC8zY2FwTTRIU3hjMnVyd1NLWEdieEVKaS91cGRKQ3dSTzdvZk8v?=
 =?utf-8?B?VlRkeEpTcnlIYkFib2dqcjhteWZVRmd3OXlvVFJxRnFxOFB1WUZJOGtDN2ZK?=
 =?utf-8?B?QWFJbGpsb1QxclZab3A0YW41dW5WTlRuOHljdUtISUxGZXdobWNnMi9yN2V2?=
 =?utf-8?B?YVZ4S2hKTDF1Q3lYS0s2MTlRTEpzTXpKNkVFdUxjbmtiRGJ5K0FaVFYyMEhT?=
 =?utf-8?B?ekV2eC9oZ0RIbmplei82OENaWE9VL2IvUnBTYXZRMUg3Q3BuL2J5Z0ZWOVNM?=
 =?utf-8?B?UDl0enlKRldsVGlrbFFlYzJZcXBLODVZMkFuWlg4WW05OGJ4TFk2ZUc2REJN?=
 =?utf-8?B?eVd5d0pOYmFER0ZwaWp2YmZpY01NNkpMU2hFNE1Ka0d0L09LcnhYWndyeVVz?=
 =?utf-8?B?QUxmb0t2aEtoV0xqcUVBSXQ4TFR4UUJtUldLdkZwVDU2dlhoM1l6NTA2WVFT?=
 =?utf-8?B?YmhjL2hHamlBMzR4NE41MGxST0ZzbVNNNnlDMnREb1Rtd2FaWFRvcCtiYWx0?=
 =?utf-8?B?KzNpSUwreVl1SlBJdHNsOFAraVBpQTlYZjhxbHdHbFZ3d2J5bTVPU28rL3gx?=
 =?utf-8?B?L1dCZWd0clE2Z2RsT3c0Y1h4QVVZdmRGTDYzVlFQWHZMcFNUNEZLKzFVL3Z3?=
 =?utf-8?B?dWdocllsYjFVcUxlRnVDN2ZJVjdoaW5ZWGxVcjRNVVZTYWZoMWVUOGkwS1dl?=
 =?utf-8?B?ZWkxY3M2ZWEySlZoVEFhZVJPK1BJN1FnZFVxQ3QzTGtPdVh4OFUyc3hWaDho?=
 =?utf-8?B?QjB1SFp4UlhSUHRKY2pxTnB2NDRDWmNRa1UxRDhPMUo5Wjh1dWtwZ1ZQNkVo?=
 =?utf-8?B?cVVmbGNEdlBtZXEyaFpJZmVlNE9XdU03em50bzREaHdabmdoVVk5NTdSVG9l?=
 =?utf-8?B?MmZxQ0ZCZUZ2cEtSQ2EwZHg2V1lUNzBSeXJBU21SZTl0N3JBUFB5a1ViVFJF?=
 =?utf-8?B?alZ1NHl6YUtLN1pMRFZtWlV2RmlUR043d0R3OGlydDJWZWErNWZ1RG8yeDlr?=
 =?utf-8?B?OTNUQkEvQWhRNjhyQVBuc3FSMVEwL09TSXNQTzJKRGp2Sm9kS1BnbFFwK293?=
 =?utf-8?B?UTFPQXROOWU4UldJNzBFcG0wSFNnak15ZlVBdy9idU5KMmgxSlEvREtrd3Fa?=
 =?utf-8?B?bHNqK1NPekhBQWhraUZFS2dFM2x3TVFXTXBPY3VhU1BqMXc4K2hTK0hjd1hh?=
 =?utf-8?B?a3lWazcvcStxd1QrNGFyc05FSnRDT3JtdHBncFlmWEJBR25wVDAvMFN1RFdS?=
 =?utf-8?B?MksySkNyRWtzMDJWRG9SN3BzSVlqRGFRWEZXeVduWjVVUlZJcWwrZURPbTNQ?=
 =?utf-8?B?S0pxNHZ4L0RidFpmZThHbWVRaWg0L3RVb1BCS0IzSTVvZ09yNFhQd1VkYlVC?=
 =?utf-8?B?ZmQvS1BKdUFrdGhwWlc5QjdXUHM4eHgyQTRxK1VMRXJkdVBxTDBhWW1PcVBz?=
 =?utf-8?B?SUpOSFNLVjE3L2R4ekFLTWxIdVU4QWdwTHdGL0xkWlljbnRPbDdsUEF2YUU1?=
 =?utf-8?Q?ioYM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(32650700017)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 04:47:41.6919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372e3f81-76b3-4f5b-2977-08de1513f681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF4B476A86

Hello Tim,

On 10/11/2025 11:54 PM, Tim Chen wrote:

[..snip..]

>  static s64 update_se(struct rq *rq, struct sched_entity *se)
>  {
>  	u64 now = rq_clock_task(rq);
> @@ -1174,6 +1176,7 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
>  
>  		trace_sched_stat_runtime(running, delta_exec);
>  		account_group_exec_runtime(running, delta_exec);
> +		account_mm_sched(rq, donor, delta_exec);

Shouldn't we attribute this to "rq->curr"/"running" since that is the
task which is actually running on the CPU (with "rq->curr->mm" being the
one that is being used on CPU) as opposed to the "donor" which is just
providing the vruntime context?

>  
>  		/* cgroup time is always accounted against the donor */
>  		cgroup_account_cputime(donor, delta_exec);

-- 
Thanks and Regards,
Prateek


