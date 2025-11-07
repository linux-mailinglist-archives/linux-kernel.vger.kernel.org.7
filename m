Return-Path: <linux-kernel+bounces-889710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA0C3E4A8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C80A2345987
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343222DEA80;
	Fri,  7 Nov 2025 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e6tdkOda"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878F1D5CC7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484243; cv=fail; b=J1Gj1rr6sHl9sW7rsCeM0OLz85HfIETJFK59BZvJTJDYTIUQHhiz9OW6+69t4vRgGKcWVeDM64puxAYK7dECRmlSMYNh30QK9pe8aNbzJYvj8gOGyzhuFz/LKlvH0SNyR7TwGWUrlmzJexaHiFYg7FrU/sz8HHK0m0x7r96wuUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484243; c=relaxed/simple;
	bh=BAKOaZyQTOwiKGhFJ9vBQhb8yNm8g/SUDSRobsleBu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=omO2JVo/YFDEcYSBSF8vy5RZvmMqyRhLCmZxkRx6CP63s1DT90mdPW/E9iaqZWawpiAg7XyTaZ7LQqKllJzZGQTVNFpg8WFaiejbJXOWDK/qvt3Co2dNvsPcB9NIGrrgpHFzeYh9otKJi7LmBaBSaoQVeC/bHbb/i/45PMRCtMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e6tdkOda; arc=fail smtp.client-ip=52.101.46.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQEcCqwqjwvEzd7J9nA/YlR57xDXzlfyxp8fjOc9rMi2bgUudYuU1sApxtA+fO2ljVsdSDbmngKFwtspHmvn7IeklmkotUlryUGbxwOXmEVQfiZ+mFyJyf4h6DLTrkL0Z1yVXJl7xf90aobv2l04MndfPfVY5WEaRUuMKkflVrQ7181SoEsjSendVTIyHtnM2E+sZbVd03v2XQrfYGm5tKnqtWvQKqYmaUbvMklfttBxbVc8ggrkyl6Hz6rute812DmKF9VIT/2IuHJFW7O7ekgLySyu5563TUKSL0o4moPj9UVT4wq5I4ZJRwgnmejFGW9OcH3hF03XEBfHf/03Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X6wLt3Zo3gTiTTCEdccdMLwcQvscvr8BsrgAEf9NNY=;
 b=nsDs2dvevmT6/dpF8MfsQa6SidE9Q2ZGh9cP7JUxqyZyyMS22Wov/o47zY1WFLaRAjTk+UMvRWTjNBm+YfwIwzQlcrGsY1o5sBtj8CuLuZTybooJ0Yjzzhl8lpSihBe7EStzQT6olSvYO/vNoSZ7Np+Fn/XjXMn1dr2SmuEuFPKojT2evUZ6bzSpf3yiePgF//AYRIuII+zWfcJ/wgKYFPtVceMupIYJjjlvZINcseoxRGZq5Bh/3HiE9s683UxpZkcu4dN8OE2hLSQgvc3oxl13IbKP+wVIl38Wz5Y4Fxly9JdqVLLe2E0SEyWhnclomrsxjyrqviHFPoORF7OLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X6wLt3Zo3gTiTTCEdccdMLwcQvscvr8BsrgAEf9NNY=;
 b=e6tdkOdaF6guFDxU4GROr7J6iIntTcHDN0QyeEcdsgwaKDbM0qzEl0EA8rEc2c3r1hUxbySIIiMcjdoSqOPI/FzScSlAqEvHKjjnh+3BtKBhG3HnrCs1mycfSqWbp+WRUx333SP1jpxxyhp1SJbZ2I/YTtjiuOhcuD84Z2tF4Hk=
Received: from SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::12)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:57:16 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::4f) by SA1P222CA0063.outlook.office365.com
 (2603:10b6:806:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 02:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 02:57:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 6 Nov
 2025 18:57:15 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Nov
 2025 20:57:14 -0600
Received: from [10.136.36.70] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 6 Nov 2025 18:57:12 -0800
Message-ID: <1d6c22aa-c882-4833-b0be-a3999d684885@amd.com>
Date: Fri, 7 Nov 2025 08:27:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Doug Nelson
	<doug.nelson@intel.com>, Mohini Narkhede <mohini.narkhede@intel.com>,
	<linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
References: <52fcd1e8582a6b014a70f0ce7795ce0d88cd63a8.1762470554.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <52fcd1e8582a6b014a70f0ce7795ce0d88cd63a8.1762470554.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: ec67ba08-b1aa-4473-0859-08de1da95b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWlCQkM4cldRWkZob2htSDlMbXdHTmxRVXlPSk56OXFMbVBEMjZYS2U1RkJQ?=
 =?utf-8?B?TlJZMWVROXRMbFJWbnlBUFJrYUFqaE9XbGdTTmxUZmlQejJmbFl3OUdUUTJH?=
 =?utf-8?B?clVyWHFhd29EMVhoOEpiZVBmZ01CRFpMWGVCSHZpa0F1dzBScG1JSU5GVlZn?=
 =?utf-8?B?ckEwdDdEazdnWS96YmVHSlNXWHpWNHMrWVRVTDZwN3pOREJ4NlFLUWswZmly?=
 =?utf-8?B?bUloMzB4VmUydFAzeFlzNzNqWTFpeEtlcUwxZi9JckpaVGEvRG9udFc5VTla?=
 =?utf-8?B?cjhvdldKRExuOVBvRHppUjhCNk5HSVo0eE1xNVltc1dWTnpVVjRqYm54UDYy?=
 =?utf-8?B?RWU4TjFTN25EMHVQWlFIc3NFRkNzN2o4KzE2STlYT09oUTJTOGpaM2l1MGhE?=
 =?utf-8?B?U2FVWkNyWFpRT3RNNm9Dc3cxNEtxYWZ2bXJUVWVtWFdISlRkQmdqQnBObWJ4?=
 =?utf-8?B?MmJzaEg1cEFwTW1iemswSzI0M2ZaSitPY21COTlObVhrenpyRGUyMWVwYlpS?=
 =?utf-8?B?ZVBOMGlPbzM2OTJhSFNDQkhEbVJsamhxWEtkVFBqSkNnalN4SHcrdFk3L2dD?=
 =?utf-8?B?aUNpcng3M0VhVjZPZnlQRHBXZUUxL2ZicXZrV1plNitpUTh0UjVYTlkzNGRC?=
 =?utf-8?B?T2pDZGdlbnRqc2c1eFZCKzJ5dzQ3UER2RkRiaTJGWHNNbFRxZ21WRzdCdWtW?=
 =?utf-8?B?ZHEzWlg0eHNUT09qSGJlWTlyQ3pKNUxmVWt4MmJSS3VhY1BZWDVWSUNjRW5D?=
 =?utf-8?B?eFZaaWNaQVEyTC90NzBYRGt1c08vNUc5UjU2UHJ5Nm83STdBYUVtcTcrM0My?=
 =?utf-8?B?TUxNN0UzTXNLMXdEMHlINklCak5MSGM1YTZSVVFKS0I5ZTZ3b3dQeFZzTWwr?=
 =?utf-8?B?UmVnbDFVK0psNTU4TnRDb3B4dGtJcFZoL2hGejhscCtDemowS2o3cllnakJY?=
 =?utf-8?B?L0xvMkRjSXZibjA3MHNLRUdjV1lLUWZMYURxdU4zZGtjWHU1TkRJUCtoZ052?=
 =?utf-8?B?NFhzS0IwMzk4ZGhNRXVZOWZkK3o3V2k0T1Z3SUJONHFWUGFiRjIrQzNYa1ZE?=
 =?utf-8?B?UVgrTjA3NzFCYXJ2aHdMbmFXTi9NbjNhUW56aTRld1JpR0c4ZTdkSGMvMjdO?=
 =?utf-8?B?bU1tc1c0UTlWV1lhK3g2YXIyd09OaTBaV0toWjhmUWtndC9SajJhS1loUXRa?=
 =?utf-8?B?eXB3QTlibjY3bzlhSFpsbzhRMVVuRUFCSnRhL0ZiNlBmTGhNMUgraHJzY3dG?=
 =?utf-8?B?ejhGV2Q2cmZJMkFteDh3ZmVhT3VTaVA1YklRQnpSdkVvSTdRRzF5cUliaDhl?=
 =?utf-8?B?TmdBUld5cmhBUVVZOEtOZkxYTjdVTEtzb09pSUlFdHNBUTNRdzg1Rnk1SmhY?=
 =?utf-8?B?RFBUbVhtVnlHbHVmb2dSMEtoUUxVWjZGcWE0TVhDSlNnTHZOZDJqWFFYTFBw?=
 =?utf-8?B?dWlBc1IveDIxSWlDMTErQVhTS1VTK3hjVDZnM2R0SW5jcTZjNXhGVnVXQTY5?=
 =?utf-8?B?elk2aGR5aEl1VDc1R2hvMS9zSmNqeTIzZXZESSt6V05ZZXNqT0dTYjJYT1ow?=
 =?utf-8?B?OGpYZDBCRHgyT0VUbjEwUmpaSTRGYTh0b3hONWlLLzFlL2RrYmQzQWpTRXRR?=
 =?utf-8?B?L0M4d3hsUzdPcnFVajdTb3ZPV3lxVFpmelEwSHVCWmR2ZU9WZmtiek5JVmZN?=
 =?utf-8?B?UWpBR2xnTTZyek5KTlZrSW5HRjlOREhsMUVSdFErVWVzSnArUFhFV0IyeUpF?=
 =?utf-8?B?bXhYUXlnQ0Nqak0yUWJYcnFmYWgxa2JWVnA1T2UwK2ZKemZsa1VjM0RmVURP?=
 =?utf-8?B?SVZwcW0zQVdJMStZVGhveHFKek9hR2lHc3FJakxqUm51NU9iVHFybmNWM1lz?=
 =?utf-8?B?a1lKUTJVVHAvQ3ZkZzJjdDk5cVE3SGFDOFR4OHpoZ1hOb1A0RkZwL3hadzIy?=
 =?utf-8?B?WWNmZlpjbWJmWHI0ZGdLYmlacXdib25ROGpoV0tKWnFnYmxTejV4NzJmRVJ6?=
 =?utf-8?B?dm1pK3dMbkJ1bnk2OWxwQjBpNzFhZjZ0a0tkVGNSZlEyMHpXM3pyWmIvR2k0?=
 =?utf-8?B?cTkzNXVoUW5UV3l5MFkyQ1dPRjVpVGVEVjlIbjJGSTVRWURDWDQ0ZEovdGZ6?=
 =?utf-8?Q?XZ88=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 02:57:15.4997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec67ba08-b1aa-4473-0859-08de1da95b8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056

Hello Tim,

On 11/7/2025 4:57 AM, Tim Chen wrote:
> @@ -11757,6 +11772,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>  		.fbq_type	= all,
>  		.tasks		= LIST_HEAD_INIT(env.tasks),
>  	};
> +	int need_unlock = false;
>  
>  	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>  
> @@ -11768,6 +11784,13 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>  		goto out_balanced;
>  	}
>  
> +	if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
> +		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
> +			goto out_balanced;
> +		}
> +		need_unlock = true;
> +	}
> +
>  	group = sched_balance_find_src_group(&env);
>  	if (!group) {
>  		schedstat_inc(sd->lb_nobusyg[idle]);
> @@ -11892,6 +11915,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>  			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>  				env.loop = 0;
>  				env.loop_break = SCHED_NR_MIGRATE_BREAK;
> +				if (need_unlock)
> +					atomic_set_release(&sched_balance_running, 0);

I believe we should reset "need_unlock" to false here since "redo" can
fail the atomic_cmpxchg_acquire() while still having "need_unlock" set
to "true" and the "out_balanced" path will then perform the
atomic_set_release() when another CPU is in middle of a busy / idle
balance on a SD_SERIALIZE domain.

We can also initialize the "need_unlock" to false just after
the redo label too - whichever you prefer.

nit. "need_unlock" can just be a bool instead of an int.

Apart from that, feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

> +
>  				goto redo;
>  			}
>  			goto out_all_pinned;
> @@ -12008,6 +12034,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>  	    sd->balance_interval < sd->max_interval)
>  		sd->balance_interval *= 2;
>  out:
> +	if (need_unlock)
> +		atomic_set_release(&sched_balance_running, 0);
> +
>  	return ld_moved;
>  }
>  

-- 
Thanks and Regards,
Prateek


