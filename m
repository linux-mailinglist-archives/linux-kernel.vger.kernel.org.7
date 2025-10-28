Return-Path: <linux-kernel+bounces-873090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0361AC130DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAF21AA49D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E530281370;
	Tue, 28 Oct 2025 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ga5TUO6C"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCA1F09A5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631422; cv=fail; b=nGg8JD8lI6zqjaiJpaxijPxZEuUO865/aH+baGOK6kyb/amxQ7O+W5xYerxOmShnJJM2gxLuDhH4kBwLMLFrnZ+Tyf2hkjBFzeMgiZ1iTxMWqMrCPiqR2nDG9ZAQkbu5GpcUjLNIGG+0Of7jfBGwFVGKkr+u68tgw5eZkDzvSgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631422; c=relaxed/simple;
	bh=SMpwYAhy2TfcKhA+FtpuZkB0yfGk9Zn6K7HOqlonrr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=POR8MbHIrkVX//uqSJBBfWNUkd2QW5Dn81K8DrOcWU/Aqnlcv65Yw3OGQRbOG8AJqjcbwEWp1D0Sc4/2BClcf2Tgh5VP7KlFgbaewitdiAGM7vno18kqh2JU8jaimufCebph48T7maYvhY8INmKgJQbQj3+2ITlXXZ9rJzSqPY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ga5TUO6C; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rr6QovdQolcT2Lvr6S3tj4MeR/GrMagJ5XK9ltE0Ouh/UVIq9z/CNd2gYJMLcGyoQcnxGJVO8uo2V/krSQke/YtPRhFgyk5TCRbKiGTt7eJnEjIXT6Qy0LhjYUrbtOREYNN2+NNKMh4QAf7Ot6ztUwLpp/G4Dr/w81z2n1JTK3IbJHe8LwFMCiZRnwXB+qIoLQhhJ/4zgC0MgolimM9kCIEx10H53Wzwa2tNEvr6e78oL/PCf5JFYDrZ7RLSILnxQzCBzYUgygIg6/j7W7t/y+sQT7WC7Pv6D1uOVSu/vRTrE+Rys3H0jOQd2mL0g6Lc1WPAk+UNK3VP3fd+NXNGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daZZGSi2dVVkV6Nlp92n3f5/xVhB6yKtRt/vd4a8BRI=;
 b=ChHuBXgxCHPfifCmBKd375uUFmQR5ams8C7pVoCGZeMuGlouJ1WyXgWgOyH32hLDVotxPCcpHg48hu02jAjmBYu+V0wOWzhh557YWBaQFxT28CK6zPnLCrGcvta922EZYX1mPNuKsCb6iJXzO0G28C35dyoLISWc7PDHkjn+3iJo9AljiHTzihAQl8AVfIIB4U3Xva3YEIw2wbNQfG/sPPhGYXdGdMDVv/xvTtQaF5G0lssUEv1NcwKKdfds6lLMWZUuwh7U2zan3Ua5WF8lGzlDBz1rbB7qw++7+wobjV3JTiw7kxelhzZkjH6IihS1nFo4EO/NyadbSK1EKhURJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daZZGSi2dVVkV6Nlp92n3f5/xVhB6yKtRt/vd4a8BRI=;
 b=ga5TUO6CKiDociB6xaCxmyIlcCM8QkMwaQS9k6JO/wFRH+k3G49R5sNN37BMoby3JmsTkQ6E5pxe0m3Je/dTDHBzpr35Fk5Wo78Zhvw14HK8405veA08fbVOXQFF4yhwpXpvqvlh8rSz/ntzC33KpKsjU0no2r7ktZw7Gb+r1rI=
Received: from DM6PR02CA0104.namprd02.prod.outlook.com (2603:10b6:5:1f4::45)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 06:03:36 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::e) by DM6PR02CA0104.outlook.office365.com
 (2603:10b6:5:1f4::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 06:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 06:03:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Oct
 2025 23:02:43 -0700
Received: from [10.136.37.11] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Oct 2025 23:02:37 -0700
Message-ID: <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
Date: Tue, 28 Oct 2025 11:32:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] sched/fair: Respect LLC preference in task
 migration and detach
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>,
	"Yangyu Chen" <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern
 Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>, Libo Chen
	<libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc8a976-9485-4f29-1f33-08de15e7bb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|32650700017|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZThJVDNLL0JTMGtEYTdxVVhPajdwYWRDZlgxSFVWZGFKZUY5c2MzRGJ1WFZO?=
 =?utf-8?B?NmJHdHg5WU9URWllbmJzeFl3enFnbUVOQjdnbVpweE8yUXZ4L0plaG5PSFZ5?=
 =?utf-8?B?YjBNUnVKTjlWNEtLTlltQURrRks1VFBqN1U2aGlXd1F4VXdSTG01MU16U3lW?=
 =?utf-8?B?TDlaS2g0TlpRQm5YY0p2NWp5QUF0K1BuMjNLRXNlbE80bHdKL3VFb2dlNWhI?=
 =?utf-8?B?c2JMRXEzZ2JTb0VQVmxnV2k5ZkFjbURoOElvU1VIdno0c09OdGFZNTJpa2tN?=
 =?utf-8?B?UWZTOTZNblJ5SEltNW5xOFR3U0k1d1R6UDdhUm5WSXZLeFZsVXpTV05VV0hB?=
 =?utf-8?B?OS9pNGxzaHJwa3F6b01PZU1ueS84bldCMTB6d1RoVlQzTVM3UStZQmRoOTJS?=
 =?utf-8?B?eGxpSU5pK2xnY0dNZHNzTERUOEY5UWJCRlRrMkZTbkE5M0Q2RVBhRnprZ01x?=
 =?utf-8?B?a2hwR1JnYWFQbUJHVDN6OFVMUmZDekExb3ZIZ0xCVGloYVNRUjMwbmhMeFRu?=
 =?utf-8?B?VjVtaXZac0c2aTFxNFRBU3NpL2toeHhFMHRkMG1PT0VkL0NlcHQ4eTZYeGto?=
 =?utf-8?B?K3RFTkx0Y3g3V0hyVHpEdXp0aTEzVzlzczVOTkpKRGhDYjBCeHVEeVAvak1N?=
 =?utf-8?B?dkZ3SkQrbjI1L29laXp4TExFMHNtaGFERDhsSHFhSnozSSs5cHRWTUdMMXhI?=
 =?utf-8?B?T09tbG9vSjJKNWpJekVoOC9WM015dXA1OS83aC9HaCtKUG9LR2hvTDBDWExy?=
 =?utf-8?B?T04xUCtZbEZyZDBTekY5Y0w1N2ZDQjdFUXBVZytnbHY1SVVKOVFWWXV1REtT?=
 =?utf-8?B?akF0VlRLQmxNbmJNRUtmRHV4MzZvbUw0bzM1aWp4c1lRU1JWRC9LSkVrY0hz?=
 =?utf-8?B?Nk56ZUh6N0dWNkRrZmlRUFFwR0oxaER3a20wNVI1Y2lwUTNISE50UW9TL0E4?=
 =?utf-8?B?L1A3ak1adUg5RmxvTmRsOXhvTFlTTGNiOVVYdHkzK0owU1VNK1JQSWx4UGd3?=
 =?utf-8?B?NDU5WnVtWWRIOTZDa0x0WHJEZ2hyWmhjN2JoaEhKOHB6YTYzaWZ0RCtPQmMz?=
 =?utf-8?B?dFRDWkZrK2pKaTRXMU9QUmxpRXJFbzdhYU00U05qeGNMYTNiSEdKOXVTaXI1?=
 =?utf-8?B?TEVEajVjQXI5TDlnbElPWFFlc2RVSWRHMTVEbHRaZlB1VUV6Wk5Qb2x1UHdt?=
 =?utf-8?B?alBpdjhJTFV6R2dxVUVDd3NZRTZvamw4OU41akdmM2xPNVdJcUJDSG8ra29I?=
 =?utf-8?B?Y3NEakF6SGxHY3k1M2wrTW01dHJ3U1NFZDZONXhPVFNqcnNscmdVbnIrczJl?=
 =?utf-8?B?NVRsTzB2ZEc0emhMWkRWZldiNlBVZ3FUdG9tUSsrZERyZWV2N1dZalNJUTZ0?=
 =?utf-8?B?MS92UDRpYVVFekdYRDhNUDBWNTVtN2QrYkNjVE02UWlnNGJZRFVZazdMTlhz?=
 =?utf-8?B?R0NTMmpJdnJBVFFzTjdmelY4UkQzZk9mZTIwQ2c1OTRWQVZkeWE5VVZZREla?=
 =?utf-8?B?bFBFUjZOZlgvKzhMSTIvNUdtZk1BOG5qa1ZaMnl3M2ZTWmpxRUk3clZjMTNZ?=
 =?utf-8?B?TE03ajVMZnR6V25OSGtLZjV2RHhMSXljVHV2NzJVWTN3amdHODlSZEdtSzlp?=
 =?utf-8?B?dGtyZU85Z3ZjUS9hYWdOYUpkNWxjSjVUOHdFdk1SSkFHWWswOVE5elA2aHdE?=
 =?utf-8?B?bDR4dHpMRVZDdStNZnN3bkFQcWJrNXdpZnhNcGVnMm9LMkNHMjcrRkFGT1R1?=
 =?utf-8?B?OVpmNkxndHRUR1p0ZHR5N3JBb1VtRG9TdkNQdHhaU3J0VFZiTFl3QzYxUkZL?=
 =?utf-8?B?ZjVsaTlvT1hvRi82K3Q4YVlFbW5kb3pzemt0V3NZWnlxRkZETVhLY2Z0eExX?=
 =?utf-8?B?eGwyNVFrQ2E0dFVVUkVGTUpqWFFOZ0dFR1ZTRCtqb0Z4Z0o3SUNVV21VemtO?=
 =?utf-8?B?MEtDRGp3MTBva2FmcnF4bHlJaVB6T0g5TkVtYW44VFMyUm4zcVdGTTN1ZTRh?=
 =?utf-8?B?bDB5TFlpQUtTNHFPVnRaUTVKZ3JiZGt3YndXd0hrbFlabUc1VEhvY3RYMWdj?=
 =?utf-8?B?alI4cnVNakViSW0zZGVQd083VTNwaHlGRkczV0J2Q1UrdDNwOW1GeElqOHYv?=
 =?utf-8?Q?BukA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(32650700017)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 06:03:35.4650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc8a976-9485-4f29-1f33-08de15e7bb2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319

Hello Tim,

On 10/11/2025 11:54 PM, Tim Chen wrote:
> @@ -9969,6 +9969,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if (env->flags & LBF_ACTIVE_LB)
>  		return 1;
>  
> +#ifdef CONFIG_SCHED_CACHE
> +	if (sched_cache_enabled() &&
> +	    can_migrate_llc_task(env->src_cpu, env->dst_cpu, p) == mig_forbid)
> +		return 0;
> +#endif
> +
>  	degrades = migrate_degrades_locality(p, env);
>  	if (!degrades)
>  		hot = task_hot(p, env);

Should we care for task_hot() w.r.t. migration cost if a task is being
moved to a preferred LLC?

Also, should we leave out tasks under core scheduling from the llc
aware lb? Even discount them when calculating "mm->nr_running_avg"?

> @@ -10227,6 +10233,20 @@ static int detach_tasks(struct lb_env *env)
>  		if (env->imbalance <= 0)
>  			break;
>  
> +#ifdef CONFIG_SCHED_CACHE
> +		/*
> +		 * Don't detach more tasks if the remaining tasks want
> +		 * to stay. We know the remaining tasks all prefer the
> +		 * current LLC, because after order_tasks_by_llc(), the
> +		 * tasks that prefer the current LLC are at the tail of
> +		 * the list. The inhibition of detachment is to avoid too
> +		 * many tasks being migrated out of the preferred LLC.
> +		 */
> +		if (sched_cache_enabled() && detached && p->preferred_llc != -1 &&
> +		    llc_id(env->src_cpu) == p->preferred_llc)
> +			break;

In all cases? Should we check can_migrate_llc() wrt to util migrated and
then make a call if we should move the preferred LLC tasks or not?

Perhaps disallow it the first time if "nr_balance_failed" is 0 but
subsequent failed attempts should perhaps explore breaking the preferred
llc restriction if there is an imbalance and we are under
"mig_unrestricted" conditions.

> +#endif
> +
>  		continue;
>  next:
>  		if (p->sched_task_hot)

-- 
Thanks and Regards,
Prateek


