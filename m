Return-Path: <linux-kernel+bounces-868093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB878C04581
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81BE44E2191
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAD822259F;
	Fri, 24 Oct 2025 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dFh+8gJs"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF64125A9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761280615; cv=fail; b=Kk68fhB26hXj+rSjwMjbUXAIx6Ej1LT/Gu990juSTDy06PuLd14QY8Afe73ZLz7h1CBI37KjGM0u0Ev34dXk1HxjYOUuEt8mFzfz2K65D5MEu/vXOZzuF+ZqkhR7cAZ6vaD7t4Yv7XcBGcoLoB4Zc23mmHDxMRXPmFQBOpqzAy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761280615; c=relaxed/simple;
	bh=uibD2kwIQgGzWQ7qQgN8RpItGfp8ulT4Uvp8mgs7tBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J6Sn5VlKrUAHjj1YMepYd2CNZ3bzg94AZh5Iq4Az3Z0SAYKfiVAuI5EKcys1alxV/4w9Cu13WmVXc9JkwhG03VzyhdzJuK/XRQy6a6vr+s4+XCtC+0F0Sv7yqVOqY+jFoE1hskf6OLRXtLyDE3NyNkJzFg5NouVY1qe4NG0PgEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dFh+8gJs; arc=fail smtp.client-ip=40.93.195.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJnsAZtZfRUwcztyikC5GWwrCaqOFZWqSmAHW7V8m7dIR9Jf32L060TqbyxJsKfNymoIXEuTsFc+6NKUvDHuReWfdjl2+AlWcvh43SVPy1eArB6yqWB2VEKnVV5UY5eBDmnMLnyEzyvkAD8p0m43gBaWsbm+AQ+rzoCUTSsKRvCUmjFEsyaqGe4dq4uA550ajcmdObjavOnafV3lq8sZ+TFv7eT0F/3QnjWwAMc+MDAc7oqOlIhAx7XVBKgdaZOxOX2bV1jO7wcgsPIQ9UaQa+2UHg6SGFo86qAkMJDBx2HFnw/QMAIw9VwGZT3vl2Fxma9X7e1kD4lMi4PdsJrILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FIMOpSPxTT34CC7nyZMvyviDUzAtUnFZ2RDZhDXHWY=;
 b=SnMjppxAAU0pAUo6FQh050R8O97BZsiJgwhfU3NROEtTtXZiB9PZy29ZUnnyTIllYbe+ttCZzaiW3NbjS/7UtfjRcjlj2tqxFq3akHACDwOgilRb6rEuRWvJQ28fuGs1Hd8ltGjdtkrtC/EmvVJXUnlmVH6RUKmJ5Jn7gxRGp6Q7O5o6bcmbx7du7W4r0fxLls8sSXyNYBCQsm0TNL7CvqaCWeSEO+tjlNzXyGnpxcLF46hM//v3nlIFOonEbcjugZ8PQJbEflqWquA5b/a/THUDyYB2yZZf1kE1TzXX0VUgCJufCwQ1LVRR27c6b8pKBkj914NEQySfb1jUdG97sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FIMOpSPxTT34CC7nyZMvyviDUzAtUnFZ2RDZhDXHWY=;
 b=dFh+8gJsohcM8BugmN04HV/NFCA0Ue/H2vkjLc+RFP/KhTE1JKh3G0kxRkkOhos1B/HKMjFr7zsDRxwHIiuA331CdAfNIaIw22DB67UwIuAMnhlFtwDP2R0H8+IJkwVpuf6DBrluzcpKFma4FAKBqxw9het4nkCpEXsypDwp/ro=
Received: from CY5PR17CA0046.namprd17.prod.outlook.com (2603:10b6:930:12::11)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 04:36:48 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::e2) by CY5PR17CA0046.outlook.office365.com
 (2603:10b6:930:12::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 04:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 04:36:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 23 Oct
 2025 21:36:48 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Oct
 2025 23:36:47 -0500
Received: from [10.85.36.188] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Oct 2025 21:36:44 -0700
Message-ID: <98c1968e-8629-43d1-a4b8-600d263bd5a1@amd.com>
Date: Fri, 24 Oct 2025 10:06:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix non-empty throttled_limbo_list warning in
 tg_throttle_down()
To: Hao Jia <jiahao.kernel@gmail.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <mingo@kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, Hao Jia <jiahao1@lixiang.com>, Aaron Lu
	<ziqianlu@bytedance.com>
References: <20251023121213.38282-1-jiahao.kernel@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251023121213.38282-1-jiahao.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a776a89-5ef5-424d-abd2-08de12b6f1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGlSTGpRVVVjYzFmdk93VUk2a09NL3FBUHB6eUtweTZDcVFsSnVpNUpETVJG?=
 =?utf-8?B?QnpMY2V5c3I0T1V2UmZZZUtZOGpCNGxFengvZHQxaHppTHhnbURoaFp5YTh0?=
 =?utf-8?B?d2Z0TUJGa1FSNFg3UGpaS2l1ekhVN2l0eVRTY3FMU284TlZKZjdsVVdlUnND?=
 =?utf-8?B?dDhoT0JMZEozRDQwbW45dllUbnJaakRWOVVGNWpaSkJvek8rNUJreU9zc0V0?=
 =?utf-8?B?RWJkU0d2S1BxODJaWm5ma3BTZ3VDbDJMQUhqRWJXanJ2R3RJUFpjOGJQbFBt?=
 =?utf-8?B?aUxnNW5HaTV1N2dpL0oya0h2TXBaVTdFZldSejNSc2daR0hnNlhVcm44U1ZR?=
 =?utf-8?B?NDg2L3psMUp3b2Z3djZ3aUorODkwaUQ5b0grTnlJSXdCd1MzOENIbE9vbFl2?=
 =?utf-8?B?aE92YmNCaUs1VktPZTFqOC9GTHlEMXFqZnJSaUczR1FTOWVTUk1Ebm5vTWVK?=
 =?utf-8?B?OEdPWXE0MENNYU1sVWI2bnUxTkZ1Zy9RTFZvS0VNejRaRTF2LzlUNFdQNktZ?=
 =?utf-8?B?cHg3RzRPeEhJM1RwZURVOWJJcHRMZm9WajNlSzdsNWgwRjZZQkQvMzQvQng4?=
 =?utf-8?B?Ykw5R1RwSmVqVloweFoxZXFwcnRuUnZwRG9XU1k2Yks0eldLVmlnazRZRHFW?=
 =?utf-8?B?d2JOOHV0K1hlb0prNFZrTG1XUnNxdEhaNFlaL2ZUdzFhaXFDdFg3azZlL0Mx?=
 =?utf-8?B?UjZ3WVNjcm9FU0JzTEFQZVdqNzNQaVdzU015M0hUSDlCL2puSmU4SFQ0Qy9p?=
 =?utf-8?B?bFFtcGpNZVJCVnJ1ZzQ1czZ3Qk1SelZtaXZYRVhUUGhPcjlRdmJ6RmN4emtZ?=
 =?utf-8?B?ci8vQVNsdk42Y3pNTHo0TzVKUS8rVEw5V2Rib0cyTUJsOTNXTk04RU5DTmpa?=
 =?utf-8?B?NkVsNnhYd1JqbjN2WG14S25qUUFGT3ZKVWYwODZYYUlOOFl5U0cyT0tiVzF5?=
 =?utf-8?B?cEE5aEZZWCtmd0U5VXR4Q1lKZG96U2VIWWFZd3FNaFpmOXM0U1Q3enE3ZjBB?=
 =?utf-8?B?eHA4Q1BudmV2dXlQcTZRMDFkRDhJM1ZHeGpieXVQMGpaRllpTFRiOW4vcUE1?=
 =?utf-8?B?MVM0WHZEeDVGUEo3TGh1bTZSa0FQQTB2NGszZU5uN3JXZU9TMHdZWDZSUzEz?=
 =?utf-8?B?Z3pqYUlZSmsvOEI0dEh0L1FmQ2h6Y2lYUjMwdDF0ZXFCZHRZMURZQStsRkN3?=
 =?utf-8?B?OGVRZURLODBqbndVUjlES2RGOEtDb3JYRHJibnRXVzEvUUlsT1ZRdWZIUGZz?=
 =?utf-8?B?TXVKZnNraFRVYUMzYkhVMFlTWitMYkF6TjErVEFjbEJSZEFKUHRpSDFlWGJL?=
 =?utf-8?B?ekpYTVdMUWFROXlNd2hYUmo1OGdZUlpnbGlrV2ZRdnFpU0xGckJWV1lJVjUz?=
 =?utf-8?B?NlM2VTNkZVhCWnhsVytrbm85MGJPcVlmTXhxT0hPTGM2d3h5OG5ya2RYSEtn?=
 =?utf-8?B?RDRseGhtc3l5VEZ4ajMydFh1VGZ2aitoT28vRDR1NnBRUDBWbGdoQlVsRE14?=
 =?utf-8?B?MWZSRjJSWVJYR2hNWGEySWpxQ2x0a29kVTJ0cXdDbU5MWDE1MUtBMmRGUVRl?=
 =?utf-8?B?K0o5T2hlWUp0OUlXd2JrcEN4MGpqRGdMSG9kaWx2Y1lEZEJNWWY2Tk5Bejht?=
 =?utf-8?B?MDZBaU9aSVp6TU05cHg4bDJjb1VBbHk4WU9ETkFOUFQyWW12L1RtM0I1eEZp?=
 =?utf-8?B?dmQzWnZUSk5nMXdGTTlXQXZtMHBWeVRzRnBucTNuNnh3dWtTVDM0OUhmbW9W?=
 =?utf-8?B?TXVWdDUxUzNBZXJLVEdDYnpWSzBOV2c1UkZjTllJVWhQQ0hoSGc0bjVxWlM3?=
 =?utf-8?B?QkVyQ2swdVRnQ3JDT2ZSRERUWUhja2NDTUpIMXN6WUNyZCtWOFlqbGVhM1Vx?=
 =?utf-8?B?M3p6VHErM3loUVY4WHpxVFVVTjFQN0VIcFQrSUIzWE40ajdqSDl6R2RqMDVy?=
 =?utf-8?B?bUoreXFzeTFLNWtRT09kVVZwdHZyUlBWVjZJQzBYM21FRmZzbld5MGZNMSt4?=
 =?utf-8?B?VnAvWk1RbGdZZlRXdDRualduQ0VzUS9oY245N3MwYXlEVkRwbTNHN2pQaTQ3?=
 =?utf-8?B?OW5lZnBqV0J2MUtHekRXdUJYa3M4VnZEV0ovR2VZU0xYSW11clczSVBiWnBj?=
 =?utf-8?Q?AEpc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 04:36:48.3768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a776a89-5ef5-424d-abd2-08de12b6f1e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411

Hello Hao,

On 10/23/2025 5:42 PM, Hao Jia wrote:
> @@ -5287,7 +5287,9 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	se->on_rq = 1;
>  
>  	if (cfs_rq->nr_queued == 1) {
> -		check_enqueue_throttle(cfs_rq);
> +		if (!(flags & ENQUEUE_THROTTLE))
> +			check_enqueue_throttle(cfs_rq);
> +

So my only concern here is:

check_enqueue_throttle()
  account_cfs_rq_runtime()
    __account_cfs_rq_runtime()
      assign_cfs_rq_runtime()
        __assign_cfs_rq_runtime()
          start_cfs_bandwidth() /* Starts the BW timer. */

If we skip it, we wouldn't know we've run out of bandwidth until the
hierarchy is picked which would cause additional delay until the
bandwidth is replenished.

At the very least, we should pass the enqueue flags to
check_enqueue_throttle() and only skip the throttle_cfs_rq() part if
we spot ENQUEUE_THROTTLE.

Thoughts?

-- 
Thanks and Regards,
Prateek


