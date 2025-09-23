Return-Path: <linux-kernel+bounces-828629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AD1B950B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58573A44F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C79331BCA3;
	Tue, 23 Sep 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="itSTFxka"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C581DFF7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616948; cv=fail; b=DGPbIYMqp0/FOpipXMI7Fc3eAG16s4WDpMvz7dAXtKGjbV3riCHths/dc+5iiZ0jyKcWznvD6aQpgs/k4u+NgF1kNFVFDzO7U5KmSmOduOO9Txwe9xtM5gFsU1aJN7LgbE4CVKShsrIueLwZrVzz238ZTffRWxrCtjct0M7t/i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616948; c=relaxed/simple;
	bh=ZE1umAg3VVu3BbGwU1+ytkaLWckxMFH39sI0eumNA3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RsJfvJwUAG4PJSTdahT9u3Q5htmG3DOjWB5HAmQr1AugfeIWCYH7TK1UKboTZrpVsFKuyqezgTCJLxK7udiMlqlI0x5Ej7TeFoCE9DQcLIuEY1bbNreOE84Tt5Yvxg5d07SCYXg1H4BPf1AvfiHdWx+nwV5M3JAcaojnVOMowB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=itSTFxka; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROKua2xITuV8lvF7MIaUkuLB1qFeOEE9TPakGP/8QQc4yYf4u+dcf/VmKGwMIiSrMo/BPdZE3cwXGe/+9am299APb3Y7evpODjSwFPUVeBngylqMrK01rNElu5S6xiazdI6wvCScKQbCXEV8Bl6H1PJy80JQRzl8i5uivZNul1phA49lN0zvju61xYHO5gM7w40ofTSpYu6l9+pY8bGC3HykmEbFxjWINSEEpcl+JaSQWTpbGm+zXZgWwluX36ZisIjJwO1nOhLyl+m6sY5dvTq5dcH4OScjgWfPMq3tumqlvv+tGivhB7Yc1kNqlyGs8dFftvTVHW8S7MqR4Yx6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Rqw2iCLx1FOKbQshxZOYW4UOyNAYai+tqDieu4vNKw=;
 b=Kd8FfE6qtzTjA87uo6PlXjoe5l7MItS7XKm0vA5uAtZi0Ap2003/EnWUAk8mzJP51evEeF/Ag3w+OW4qkZS+5g61L/evWj7Dk1WhYqwRuAMX007WEH6SJYjpfe4T1d8EJqppB1N2d4HknSjjM7tXFaPe7zOOdiAUWPjRSzdabDTbuQZ/nUWjhoE5spzl/eQnGSGvCrvnK3NC+mP2QfTZTkHl6ZWUbJe97ZXXeK9NXDxotkPehYqiLocNdjoTSplIDDBLpvSJ9GZ2kj2JWoPVmUl97vdf9y1Lb/u2t6mv2bmNxTk3wfe+w6zVNVeJFWyTO201ubKSsOBvuKRu9/7waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Rqw2iCLx1FOKbQshxZOYW4UOyNAYai+tqDieu4vNKw=;
 b=itSTFxkaeUbecTFWVFevPSWIxmmjc+oovxOWlwoNCbKd6cJd1qQlY6gtTi1kpeHhmSkicsmm9C3yXZM7X2kolup1S1D3ok6GGe/Am9nbKzGQ9fOkz9P5qVXVtWZsdyOAWz1NKFwiSK0djsQfZ90J+jUvfIwbP2jqBXs6e9ZQFAU=
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:42:23 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::98) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 08:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 08:42:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 01:42:22 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 01:42:22 -0700
Received: from [10.136.47.65] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 23 Sep 2025 01:42:18 -0700
Message-ID: <f341531d-d65d-4063-9b0c-8d47b49864db@amd.com>
Date: Tue, 23 Sep 2025 14:12:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Fix cookie check on __select_idle_cpu()
To: Fernand Sieber <sieberf@amazon.com>, <mingo@redhat.com>,
	<peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
References: <cover.1758543008.git.sieberf@amazon.com>
 <64ca6d7f73625cc63fa0bc1800c9b199462a5ef3.1758543008.git.sieberf@amazon.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <64ca6d7f73625cc63fa0bc1800c9b199462a5ef3.1758543008.git.sieberf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae5ce72-4af9-4fea-d13c-08ddfa7d1dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnF6SEk4aFJmT2hHczA3Rm9EaGlieDlwVldPTmUwcm9veXBIZWtwdDFVL3ly?=
 =?utf-8?B?REdYYmlRQXZiREo5cSs5M3hNSkw4L3QwTmxHVS9XSHY2ZDQvdEhXaWhaYWRF?=
 =?utf-8?B?bHBRMTA3SkhFbGNDQ0MzUFdOeTRoRXZGM0xEREZzTTN1YnRXNlRXZEtFTFcz?=
 =?utf-8?B?ZWJJZ2tNSDB6a1JKT0dwamp0ZkRLOVpvbjJCMDJscGh2QlZTN2MxUmtJOTBZ?=
 =?utf-8?B?TVhyRllsWUxWVnRmM1pFdnR2cVNwQVZ2Q29kSjZSanhhMitBQ1FWbm1WOVR0?=
 =?utf-8?B?aTJaMlB5SldwZFJ4K2ZoZ3J3ZEFUZGVaTWNaMVBFOElyaHZvNE8xL1I1VnZT?=
 =?utf-8?B?TlJyaVZlNWFOWGVnWDJLTHdKT3VhOTI4dUFjSW9Yd3Q3OHpHSDdGUHUwY3ZD?=
 =?utf-8?B?cTlsZHZaSUE3SEpPL3pHN3A0ZjFVeTV6dmFZMjJOVHRtS001bmNlL3JrVFhs?=
 =?utf-8?B?WWw5eCtQV2l2eGdwY3VaSEdRL1JwWU9DaEt2M2hkdHBqOTJkSUdiWVBKeEJU?=
 =?utf-8?B?bWpQQWJSY25qNzFMdDVudHlOcFhUSGs4V2RnUHl6SFhVV0RZc2RRQWFaWW0r?=
 =?utf-8?B?V3pYR0lTTGlUSmZuQzVSbVg0Sk0zejNYem54TnZHL20ySk8xNWxTSkNFMUNp?=
 =?utf-8?B?aXZSV1o2a3dhVjdyd3RPalFKcmFSTW5EaE51OWw4RU9UZWhraVhBTGZaYWhs?=
 =?utf-8?B?cnJ2Uml4QlBOVWFOU2ppcXh3VGhpd0F2MkUyMnlObzBQdWFkaW1CUVYvdkNU?=
 =?utf-8?B?Z2ZlU3hZVWhKNDhZTWVzVjhnWldXdzQ2SUtOOGhRNnlsM2RDRUtSRXJuTXUv?=
 =?utf-8?B?c005ZnRiajdxRWpzNXliWWxQL0RIOS81QTgxU1UzMm5QYWRsYUpNWHZFbHlw?=
 =?utf-8?B?TFRoQzQ0L1VRbzl3Z21FQjVGcVpwZ3EzNmVkbkwxU2NOcXpxWGhTZmh0R29T?=
 =?utf-8?B?SkltbTkvK1RRRFBvVE91UmhOMm1rRnVrSGxuYXY5bDRYQzNWTGpSMFh4c1E4?=
 =?utf-8?B?UlErZXdOOWpaQ1ZaRzV6MUZNaU93N05pZFAvNmR3OFBPVlhKRC8wcDhvcTZQ?=
 =?utf-8?B?b2ViVWFvaHJ5K24yMjlQM0hLdDArSmt3bDRhczJRMnRDVE85UlJ2UVF2Rkts?=
 =?utf-8?B?MVg4dkpoLzU4aUtZNjNoRG1hMmo3RWZLdDNIQmRJTkZNT21peW9SU3Q3blBC?=
 =?utf-8?B?TWpEL1MxQmJoK00wQkJrNlNTNDV0dTFoWFBwczlncW5RNHkvMk5leG00QUtz?=
 =?utf-8?B?bFh4UGdUdTBkTjdEQlFHTmR5YmQ2cDZEKzY2bTVxdnVrR1hmcFJQVWh2MmZy?=
 =?utf-8?B?QTllbXpCa2FKdC9LTXZGb0VWK3VORXFJdHZtUDl2UjZoNE9IWVAyVERKUlBO?=
 =?utf-8?B?RHUwem9nZG95MFJDdklhVFRLejVRVXZNTVp3eTA3WUdkRHZjK2Flcno1Z2p1?=
 =?utf-8?B?YXpMOU55b3JLRERMMWtZejF1UmptTTZLcm84YlN4S0NSTkdYc3FyeTNnejl5?=
 =?utf-8?B?WTNiN3p6K2ZIUmFEb2srZUVOZXpKYjhaaXNvdjBRNWJCNzZqaEMrRVJrdlQ5?=
 =?utf-8?B?ZnFId2dRUjkxc21uaXJ5SGllRjJ4QUJMOG9nejc1Wmx2dzkycmNIYkE3NUdt?=
 =?utf-8?B?SUR5YkgydjhPTWc4SmhsZGpwSzB1Ulh1d25hMHVPSjNTYXNhRllkdmZtZ29O?=
 =?utf-8?B?ZHMvcGtNc01YdHBiQ002YVFMdWxGTXdlTFhXMWsweFZzTG1mVzVzVUVtOEox?=
 =?utf-8?B?VDRuNDR5SUh3RTR0cDhpZWhERGJDL05nWTI0VTJjcS9uZUZZVGRQL0N1ZTlH?=
 =?utf-8?B?TDZ3OWxjSEtNNHdreHpWVXNzem5VU3l4Y2ZmVGNrKzNiQlZKQnpOcFdYTWtE?=
 =?utf-8?B?RzE5R29aWkpSbzE3TkpsNUJzTE1kY3U2ZllUOHZaUm1xQWFqQmRjNzVSeC9N?=
 =?utf-8?B?QWUrMWpQK255M0RvTXBnN3Nzb216djhpcnZlVXJNejFVcjRmWkJWbnFYRXNG?=
 =?utf-8?B?SnNmMC8xTk5IWU1aWkF1S3lVbkdMNVo5SkFETG1hOWNKTHBxYWpkZFRhMC9K?=
 =?utf-8?Q?Y88/rD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:42:23.3561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae5ce72-4af9-4fea-d13c-08ddfa7d1dd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598

Hello Fernand,

On 9/22/2025 6:09 PM, Fernand Sieber wrote:
> @@ -7447,7 +7447,7 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
>  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>  {
>  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
> +	    sched_core_cookie_match(cpu_rq(cpu), p))

__select_idle_cpu() is only called when "has_idle_core" is false which
means it is highly unlikely we'll find an idle core. In such cases, just
matching the cookie should be sufficient right?

Do you have any benchmark numbers which shows a large difference with
these changes?

>  		return cpu;
>  
>  	return -1;
> @@ -7546,6 +7546,9 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>  {
>  	int cpu;
>  
> +	if (!sched_core_cookie_match(cpu_rq(target), p))
> +		return -1;
> +

select_idle_smt() is again called when "has_idle_core" is false and
sched_cpu_cookie_match() should be sufficient for most part here too.

>  	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
>  		if (cpu == target)
>  			continue;

-- 
Thanks and Regards,
Prateek


