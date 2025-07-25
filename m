Return-Path: <linux-kernel+bounces-745374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7DBB11909
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DFF171C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CA626CE08;
	Fri, 25 Jul 2025 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WpJz5qPN"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555031D8E10
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427685; cv=fail; b=YE8S+1qFvX/orwqlySZiCsOmkT7EHAcOrUyJi5AbiqLQblRBoM4O8PC+ibDdNy+DQAWy8XdVu3T6u8ZbmYlr9/Gw1dWkYIz8q8OEBs3PVoDbWNQEg6WvvtpcZ+Xs2DYeMfITBshJzW58TYeBxkGrnNRBbHSJDQvPX9zzI3YamBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427685; c=relaxed/simple;
	bh=dz8HGZFP5m0CXVAIci085N5jVW7HvDNp7keXI2XG95w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WE/zGHLuYE2ia7q3ueYZBsTSHROcE7LBJbbyWaQM3wDKMbeM0DuvCy6L9fx+egakxVeekmmPZn9/bIV4D9I2PuLKTC/NeerOQtTOhvV1WxXu5JXAA8BKyJXHGxeuJt+o5fpwHh+ELsyv/wN6ZkOLChGiy5PKwDWeq8N4A7OOKog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WpJz5qPN; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKNY/M7POkdW3JOWG5gcfACwDaHP3h9R5/F81XvhgxwFiyurl7Jx7n6z0Eqpt4ZydcEeg2FboZAmDLjRF6PFLX+vuSHFkqgZJXBib6KmMr+O6OPH9mHHneHEJcNUS0ulunBIZRc7P68ab5siLsX4qsAJntGIVDBROSi3JC2x3KegGFc6hG9qw8U9LZAksVR51Aj4R/ZbcDK0xnxdcWJN2lvGyfg56Ft6H1OBe+mPzqHOPP5J388MSuM3MCkD6vgvPO8qsgeDl61ubT0EjdS42HFA/rurgGlCEVfHb9fhACuiFNBRTT31fHZ7ecMfnE2Y0TwT+8D9o2RuIree3+00/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SikMl42TOuwJgXUgma05OfiPtAg2oX/vSPFbfPr2eNI=;
 b=cJfumBn4n2LDOVPa7jqV+ypcyMa6TAP1XR+U/fIF/Xz9nNIC4Fv4rJEOkqalnkM3v61iU9jYahedITqz10bNFNPHfw8G/7KUw+Umes9oaiKq9qg3xBg4QhFyiHjwMom+61XflXs8G3TBWiA1vYV6AqaIwAwrU0RWtBYvB+cZkiUsjWuHbSDFIHNLuXJPCScgJwhA3E8rE4uNnhITPVSHzUlCNuMg4z1cIROzihXa4UPyVFYtV3dj2/rm1zhDEoF4uFPuISa6U+XcO5rGMVnZ34x3vTgUSy8pElIjMA6dAf1g+2iOd1vgneRhDF+dkT0CPl55XVONIkI8LGmrrhIV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SikMl42TOuwJgXUgma05OfiPtAg2oX/vSPFbfPr2eNI=;
 b=WpJz5qPNJOqguE24SoB2HcsFK3n4T6LNXqFEjveNWcXVJ5cY5yO4i7hok1RssIQ1/HSiH9/DCmSiJYeM+wwXWuOrSt9lOqFZ8BJMWBCBtO7JUr3FNagcPReV14c+0b5hvGm76mFeo9FsIBKwEEHS2oye5PncnLptoEdbExb41po=
Received: from SA9PR13CA0021.namprd13.prod.outlook.com (2603:10b6:806:21::26)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Fri, 25 Jul
 2025 07:14:37 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::40) by SA9PR13CA0021.outlook.office365.com
 (2603:10b6:806:21::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.6 via Frontend Transport; Fri,
 25 Jul 2025 07:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 07:14:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 02:14:36 -0500
Received: from [10.136.35.26] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Jul 2025 02:14:33 -0500
Message-ID: <c7f2c6cd-e8d9-4dcc-9d1a-0a8b73769942@amd.com>
Date: Fri, 25 Jul 2025 12:44:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Combine ENQUEUE_MIGRATED check in activate_task()
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>
References: <20250724121258.1826487-1-quic_zhonhan@quicinc.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250724121258.1826487-1-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddf82b4-2ede-474d-5976-08ddcb4ae9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTNnaFIxZmZ4ZTZMUFB6SEpUOFJBQmNNN3hFcHA1ZUZ3VkF6WVhFMnFOYW5o?=
 =?utf-8?B?Z2ZxU3M5YkI3OVIrV2o2Y2diekwyTkluSXo5b0RGWGI5eXloYnNpSElaS0Nq?=
 =?utf-8?B?Q2p2RnJCRTZWWHdxdno4d0pObXVJWlFvZUZCazRZbExqK25PMHR0eXpyTHF6?=
 =?utf-8?B?TlpOcm11alFxend6ems3a2xvTWZkbmRFam1hUld5ZHdFR2hNa2hZVDlGbjAr?=
 =?utf-8?B?bjEyeTRabmdpU01TWmtQYzF1SlVFWWM1QUNWajg4K0hyZmNRcE90Wnh1VjZH?=
 =?utf-8?B?b1dmUXFYSnduK3VmWndhZFZLYkJwTXZUOFhNNER5SDBIMEEwdVcrdDlNRDls?=
 =?utf-8?B?dGVZbVlsSHNXUlcvOE8wKzJjbkhoRzJkd2V0VTdSSG9Nd0N0bllaV3Q2NFVT?=
 =?utf-8?B?OUZLUGtRL0NQbXlTMWdVTGtJT3JFZDRRdmR6OFlJQ3phZ0xKUGlTdmlJOGdW?=
 =?utf-8?B?WFpibjUvR1dyb2dkMHBWSE50WVgrdHVxSnRhMjF1Q1duK2xKRlZiNUFsVGlh?=
 =?utf-8?B?cTJLOS83L0owckFlbVlReU1LZjkxaHdnbDhacVhGNXVQaWhybTdJd091bnhC?=
 =?utf-8?B?NDdxM2s0ZmUxSVhBYldlbFFNNDZzL2dDaDI0RXZBY2VHK0srTnZZc0hjSTU3?=
 =?utf-8?B?V2IrVUFMQXlFaElMYWZwb2laUHN0VmFPMWx6ZnNrOE5WOEhlS2Z2aStwNHNF?=
 =?utf-8?B?d1VONXZnbitVYjV4VkxrUG1XVGg3RnVPSlRSa3I3bzdYcGdnQVRZL3dGZWls?=
 =?utf-8?B?cjFqOXB6U1RkeWJ6eUtQVjdvV3R1NHFKMnM5UTBRMTJyUjFzQVpKSWNzOG9R?=
 =?utf-8?B?WCtNUjBRZ0dELzFVeXFFOUppN0RpU2pSS0VIVWpPNFVuaVhvbTlSZ0M2SXRk?=
 =?utf-8?B?U2dWbFdZc2NOckVXZjhNdWdtNE1sRExXYzBCSFJZb3NUQlM0MWZkY09SWDZH?=
 =?utf-8?B?YkJkVnZzQ1MwNnVqWDN3VTRSb2VjbCtDNEVCRG93VUxZRWtOZGdVQVUyOEwz?=
 =?utf-8?B?RStaUEMwaUUyL0h4YlBEQldYazVQT1hwN2hZbmg4TUNpSjJrTWhld3M3SU5Z?=
 =?utf-8?B?dUUwck43Wnp4UkhqSHRFMTVZQzhWN3pBMVgwbXNqVEpjcWYzNmFRb0VNRjEr?=
 =?utf-8?B?dWtmbXdEUHcwcGZTc05vU1I2VitMM2ZRSjlwVnBWN2NYaFlkRVNsMFZiZW5E?=
 =?utf-8?B?eUVEdjRhd0dBSitDVTZKVHlaQjdvY0MvcFNMRVlNTGZBVkszZTd2VTNhNlJt?=
 =?utf-8?B?ZFJiS2NNWWYvOE5YOWtMSkRmcFlkZEtIZFFVKzBVeEt1SjFxZm9KMTdrQXhi?=
 =?utf-8?B?K2dobjF2eStYNnRaUEU1VlRYMUkyaFVOZUlNMDlVRzJIMzJ2VmxCbS9jdUN3?=
 =?utf-8?B?LzNWN3p3bjZWNHJnWkZsNEFJV1gwMktqYzBwbW9PcUE3RWVzRnB1Y1pFU09J?=
 =?utf-8?B?UzZ5QzAzUThHWFg1M2lkc0s1T2FpS3BGWHp5MEVBUU5YUlp5SDdLeTMvM1Aw?=
 =?utf-8?B?NnBpQjEzbXd6djByY2lxUEZwMmJmSGIxZ21LczhtS0VDOGJ5OGVHRndEVXNT?=
 =?utf-8?B?REtHNWJRcHo1SDRTaGg3Q1hFL1JLV3BOVFk2alpxdFI4bmU5T253ZjN0MzFr?=
 =?utf-8?B?dmhuY2Z5aE45ekIxSmdkVy9xdmZTL3BjREplaWJWQ0xTS2dEL2NhbVZDanVZ?=
 =?utf-8?B?VnhQWDlZSWU4R2Z0R1VLSlhwUGh5SHlOYWtVSGVPWWx0R0Z5RlY3TE1qU1BU?=
 =?utf-8?B?Tis3bDFLVzFWZGxhbjNnNmloVUlCaGRHam9YTHltWEV5MXdCT2ZzSkZoaS9y?=
 =?utf-8?B?ME9MeEhZaStWc2xUV3dHRVRpVE9YNUJ2NGtXa2lDY1plYjcyYW82eTRVaG04?=
 =?utf-8?B?OGtKUEY3U0h1akxGQ2NtblZ3K1VqTHE0Z2lWSnNTYzRIOENDaWRTeHhpc09G?=
 =?utf-8?B?VFp0ejVSUTVES293dGlNMHIzbG5vWVlLTjk2TG1EOW1GbXd3TTA1NmRvUnBs?=
 =?utf-8?B?aExJS2xuWnFKVFVLeHh1aTlNMHp3VFNGWlhqeGowYk0yelRJYXp6akxyN2VV?=
 =?utf-8?B?MmMrWWNQcEN0ZS9lS3dxa01VVk5LbnI0NTAzUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 07:14:36.7450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddf82b4-2ede-474d-5976-08ddcb4ae9dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216

Hello Zhongqiu,

On 7/24/2025 5:42 PM, Zhongqiu Han wrote:
> Combine the task_on_rq_migrating() check and the sched_mm_cid_migrate_to()
> invocation into a single conditional block. This removes a redundant flag
> check and slightly reduces the instruction count in a hot path.
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
> - This is a slight optimization and code cleanup, please let me know if you'd prefer to keep the current structure.
> - Thanks
> 
>  kernel/sched/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2343f5691c54..d6063cf503ee 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2118,10 +2118,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  void activate_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> -	if (task_on_rq_migrating(p))
> +	if (task_on_rq_migrating(p)) {
>  		flags |= ENQUEUE_MIGRATED;
> -	if (flags & ENQUEUE_MIGRATED)

I think "ENQUEUE_MIGRATED" can be individually set without
task_on_rq_migrating() in the wakeup path via ttwu_do_activate().

In that case "p->on_rq", goes from "0" to "TASK_ON_RQ_QUEUED" directly
without going through an intermediate "TASK_ON_RQ_MIGRATING" but
"ENQUEUE_MIGRATED" will be set if "p->task_cpu" was changed during
wakeup.

-- 
Thanks and Regards,
Prateek

>  		sched_mm_cid_migrate_to(rq, p);
> +	}
>  
>  	enqueue_task(rq, p, flags);
>  


