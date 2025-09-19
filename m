Return-Path: <linux-kernel+bounces-824856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA2B8A503
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C333B73B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578BA314A68;
	Fri, 19 Sep 2025 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QSMqGBbl"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB172628
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296059; cv=fail; b=iLTSE5JS2yV5l39Eeahn4GfF5USIsPqC+ebwcNrwyK9zeUtb9OVpao2EVqXS+8Pgg8ys8PrtZdmIH0hUyZJzGUNBbkI7kzYDneBZGxGHrXtFBGlu4UcNAs+98H1xOlde6+zT8MA69xHP/nv0v+L7xVs0VX3+fpti3mWZW/VIrPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296059; c=relaxed/simple;
	bh=gaGLdInZnIPuGmPiZF21Y/KblgvIfntoJLE7cREwd/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=An3opp5LkDoALYN3sr1muPXSqa0x88Oj86QYaXY/GUbYGtiqXPTlxrAIcM5h+gY7SGz6rinwQrHbwz5J+MHnKbMLRXiGKKWr4lH0CCSWKuXZ2m8UMO4GaX+CYugDLLL6NVr0f8ib0PZy/9hONlojhFiq8sImym8U69DAykfgQHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QSMqGBbl; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saAtzmp7ik/wVL4IP4YOHG3eCQAELaF2KDrRh1PZu1gJE4bzKeDbh4r17RuUYVTFyVezO7mRNdNv9JDHd6/+CNQeG+MJMGI2H9cU+n57pOdZxrYHKb0ZkmNj1RzHCaEEXy4Pdyf37IlO9yiXKleRnYs+/YI+K6AVJM2ddYHU+T06xm/zpmEMTIuQk+BOWaN8SI4qRdsP9rScD2eH5i64PIsxzn9obsPAKYYw2oLYOki+um5oxJl9NQ0He0PAyvCAHXtuFwWiKCWd7KbI3vLVygnO5j0GO+IPwEbaRWPKPFkmnJpd7Ew9xvmSfFdgakB1YsmOF5hFO2PAI7d36JCZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U3gR/yzK6Qh4wcQKrqPsWHjPMUUYejQIG3umTLoyrM=;
 b=e+Dpn289sVuTutJCOf1LlezQU8R8Y/iSZm9bKQS/IpaQE/75f/QkJMLb+jesrCq3qMqr+5zvqhB5Fmg4UCMq5GiSSZKdfLFo7CvvooGzyw8WetttkcgFmDULb8XGhPOKgXfZiv9f7fCKRAWm65MUEZoUpgJ4IlH2dsE0ijlfHOeu3Cc+zsUuwYRJkiEYEZU45kstwIpliYTMLDhUFa2EmHhvLFKcLXl3Cbw45ocAlZixPkYEY7X35Y9MB+gLO1Ydls5u31TVfTFY/tPiMt3fuhOooLzzwSr+Gva98sbhJyBc6M0maxFkonlrpwa35cLpdU2qVXqZZjN/UU/GpuOcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U3gR/yzK6Qh4wcQKrqPsWHjPMUUYejQIG3umTLoyrM=;
 b=QSMqGBbls6qEAygr6KhhvEJmxRUhJoRjUaa738e0FyAA5YXOPg9TdvMRMqGj1NuxwoyopXt4H5C+PpeFmqMdLpayZvuMY1ZQWykL3BPL1pCgrhfiRxCoAdbIWWfforgEYSQ3kVALVNlpYF3varIN89mhRxNknb9P41PDDvnvAkk=
Received: from SN4PR0501CA0007.namprd05.prod.outlook.com
 (2603:10b6:803:40::20) by PH0PR12MB8797.namprd12.prod.outlook.com
 (2603:10b6:510:28d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 15:34:09 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:803:40:cafe::a3) by SN4PR0501CA0007.outlook.office365.com
 (2603:10b6:803:40::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 15:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 15:34:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 08:34:07 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 19 Sep 2025 08:34:03 -0700
Message-ID: <a29f9f4f-d86a-47ce-840e-6ed2cd6f14b7@amd.com>
Date: Fri, 19 Sep 2025 21:04:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] sched/eevdf: Fix HRTICK duration
To: Peter Zijlstra <peterz@infradead.org>, <tglx@linutronix.de>
CC: <arnd@arndb.de>, <anna-maria@linutronix.de>, <frederic@kernel.org>,
	<luto@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
References: <20250918075219.091828500@infradead.org>
 <20250918080205.716937764@infradead.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250918080205.716937764@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: c193ca0d-db8b-40be-3788-08ddf791fa0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|30052699003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDV5WGl0TEFhS1h6d2dVbDNoc3kyUkk3bE9TSGRNbVo4eUN6ZENaN21OUFlS?=
 =?utf-8?B?MG5LL2RTY2F5Z04rN3dUQ0oxNUNSU05hQ0FKWUxWSDhkUUVkNGNDMlFKSG5S?=
 =?utf-8?B?ZHlUUFpkdmczUXBER1JnUkxiZ2l2NzJlc3hHNXh3WHBvUGFsUUthNHhkVEts?=
 =?utf-8?B?a2dKZXNyUUdudGR0TG1mMm42ek5SNVBXZ1YvYnhlYWIzV0VjS3g1c2NNWUpn?=
 =?utf-8?B?SURqM0ozeDc2WXd3Wit1S0tKVjBqcUZpVkYvcnM0am5taDNPMVg0aXpPNHpr?=
 =?utf-8?B?bmw1a2pRalAyRENMTWxnTFo4Um1EWURocngzdWxGNFFpOXZ4dWZnYzlRYStC?=
 =?utf-8?B?TlU0YW04MWNncG04eGRnMWRQTG5VT1kyVzQxZmpjL1BueWNBUmczUHJzYmUx?=
 =?utf-8?B?VC9NV01PNklnQnlmaWNaTGh4TXBnRElXWXhrMDhwczRYVm9aK0taWVhiR1B0?=
 =?utf-8?B?TmxwWExWK2FtL1JMRG5hS010OFFtZ1IzZnNrbTZ4TEp6L0hZME13VTR4SXdV?=
 =?utf-8?B?ZWZsSVp2ckd3bGJqUkYraG4wQTlGUEFjMUNEOU1BWkd0bC82ano4V3lWMFpI?=
 =?utf-8?B?M1B0M0FqMTB3ZVJScFFZRE5OQ0wvMnRBZ0tkZzhPcU1vazFZSGpqUnN4OTYw?=
 =?utf-8?B?c1lERUtTVHluR1RONThYWVJPQ004dnBtYzFWWUxldGRmRkVCUGE3RWs1QnE3?=
 =?utf-8?B?RDhpcXBXS2VLSG5ITnpjNlBLSWQ1NGlZSXY5YnZ1cjFQM0VKR1NMWjljcnRN?=
 =?utf-8?B?R0xRbWNrVjQ0WGszYnRrSHVXMElZMDZlZFUyM1E2SnYzOTl0Tm43RE5GeTJP?=
 =?utf-8?B?WXpJZ3FFeklrNzFOUSs5WHQ4bGVRbG5uTmkwaVA1eWlRY2NibThobGNENkpY?=
 =?utf-8?B?TmhYdnNja1JRSDNobmtObWZMTGxFcmFxeDJOYmxXVExNcGVoNVBrTGp0ZEk3?=
 =?utf-8?B?N1JYcHBEdHhWTVBURDZ6K3hyUHIvdHVQRVZaaU1CajI2ZHNicTA2VFdsalNY?=
 =?utf-8?B?RC9OV3pJYWlVVnBJdW0rMHlZRUNJSWdXOStsRWcwNWhZWksySXF5dnRUdXlR?=
 =?utf-8?B?VUZ2SUNDQkRtWUpZVzNLU000UnpocEZ6SmNLZVhDbWgrQW9wNHYxMUtoMUh3?=
 =?utf-8?B?UUw1RUdLNVVxbXhuMzY5VllpYnZWOGFNMDlXY1FCUGUyTndJdW9MbkgyUzZV?=
 =?utf-8?B?akdZWGhreDEzbUpjVmZEbUlkRUlQbk1seUI0bm1hbkRTRjlhbXZhUUsrZjVi?=
 =?utf-8?B?cFpOT0pDWTh4dGVVc3o3YmlPR2JvRFcrdHc3S0NMWDNDMFhSOWtIMmhwVHdm?=
 =?utf-8?B?VUUyVVo5QVNYMkFjTDZja0hRMFRvN09oT3FUUk0zelFwR2M4V2Z6eUFSSmJY?=
 =?utf-8?B?WnpUZzdlQ2RSRWlBa1dEOXZXRWpqV1p6VEczNlV0ZTBZTURPZCtVbHJZdzl2?=
 =?utf-8?B?anAwTjdoM2JWOVA1NGlWVzZDdWpLYVkvclNodVdlS0ZPUmVteWNKcCszcWVy?=
 =?utf-8?B?MVpWREhKZVRJRHl6V0N5R3hOWkMwYkUrN2RUclA1YWF3a2s3RkNzNkpQbGt6?=
 =?utf-8?B?V2ZZcDFOUlMzTVNIRndWOGJEUDV0Q1N2ckYvMllrcFRzNW03TnNkMXpOdDVZ?=
 =?utf-8?B?YXdYU2NhSUc4SzcrNkpkRmk5NVUxMi8xNXRaNGZmRlRWYUtsZzZhazYvWkRO?=
 =?utf-8?B?Z1o1WW1pSFVySC9NZUJINnMwZEJrMGZZdTdtM2REZVN5bFFVR1FWaWdhc0xQ?=
 =?utf-8?B?QS93U25FT0JHSTJZVkltcDdwcW9lZ0xWOTJzTC9JZ0FsWkNtR3YvUTJuc3Z2?=
 =?utf-8?B?MXVUajhMK3dYakxCRlFmRjlrVm1rZkJaRjBXbmpyN205R3NzcU51eXJ3K1NZ?=
 =?utf-8?B?MUJlbUdxbjdjUEdYY3lDWkdlakIzSmZ5SS9tMkN6WHlPMm90L1poSUpPQTJn?=
 =?utf-8?B?dmtkcmRlbFd2aTQ0ZExPQmQweDF4RmNYMTJCNFQyTE9Wa2haVjlRVVRHdkFO?=
 =?utf-8?B?MVBmWUpVRkptaitkWGNiL1QyaFVQMlhNYXZubW9oN2dQN2tSck9FVnFBL2Jo?=
 =?utf-8?Q?HEi9u6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(30052699003)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:34:09.3446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c193ca0d-db8b-40be-3788-08ddf791fa0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797

Hello Peter,

On 9/18/2025 1:22 PM, Peter Zijlstra wrote:
> +	/*
> +	 * Compute time until virtual deadline
> +	 */
> +	vdelta = se->deadline - se->vruntime;
> +	if ((s64)vdelta < 0) {
> +		if (task_current_donor(rq, p))
> +			resched_curr(rq);

Why the task_current_donor() check? If the scheduling context has run
out of gas, shouldn't we reschedule curr even if we were proxied?

> +		return;
> +	}
> +	delta = (se->load.weight * vdelta) / NICE_0_LOAD;
> +
> +	/*
> +	 * Correct for instantaneous load of other classes.
> +	 */
> +	util += cpu_util_dl(rq);
> +	util += cpu_util_rt(rq);
> +	util += cpu_util_irq(rq);
> +	if (util && util < 1024) {
> +		scale *= 1024;
> +		scale /= (1024 - util);
>  	}

Could it be possible that we arrive here from the dl_server's pick and
end up inflating the HRTICK duration despite having an uninterrupted
period for fair tasks ahead?

> +
> +	hrtick_start(rq, (scale * delta) / 1024);
>  }
>  
>  /*
-- 
Thanks and Regards,
Prateek


