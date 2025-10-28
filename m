Return-Path: <linux-kernel+bounces-872963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16B9C12B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F5D1AA26FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3959D23DEB6;
	Tue, 28 Oct 2025 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dSDy0/f9"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D11F583D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620615; cv=fail; b=Mj24u88VGOdKP12trW8HL4rXdDVnT0PK0/XsUIQDKllL8c+/0pjBHYvrqfjwQVagqwUuhZwa+xpKyrC1qrBbLBkXxr7ros7TBgBCBe1wmkGZsf91ufqNEnFO45e5VGJNLquaxxtNkPOyj/kWqEGFIkY5hdE1tHljN2RpieXkBfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620615; c=relaxed/simple;
	bh=o1Q5asRH8eI4Z14VDLro0wrCenGLWjh1cCtCemSi3UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PmWzRJOqcd3wUVLdWnmUDyI479+CUny0ih08t7tqHdi+qS0TuSOzS/vm8LyOSTiDWLMRGedekVfLsMgmUs+AYnWAZ+t2G/kCffn9nTbHJWwK+RSjsSm4/mFOYD/qDm72wgayh+FeiLdp5ZEJyUHEx+iisViyVDnRX53zhYfLq0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dSDy0/f9; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCWcM431gO8WYANaK9IDkVHhQ82lWONPG6MPvFjvZ2+ieFUoO9cTnudJWzD/9WYh3lVPUo/s7VDvpooZoSrW0DJqM9TcVLBtr6gL65kkbfn35rorobVfsjHCP1E2wLQgVO03OLLoY/aXeEO62TTLGlGgsWtUNlL15aXtHwWMxAT4+IcL3Nt2suuvAbiAps0zih3kbiry6XteynfhcwsuqoZk5a1WRsU4YeopxlvwBZIkfURUCkHiBwun65CX0T6k8VsEguz9MaMZwANVCbd616Z/0fc270B41BKMjkTfLekkpWWI3wjm+tXtmsi43YVDu1Lz9BLvhAYxJfZeicO4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZ7VjY+/G/86Gcy1TWuESR71QsB3wtMmKiQR5D+4OFU=;
 b=XLEFmOEGeJI3OWbanWLitA9OXZx653DdFGVzpF5qC0mJZBge6xd99o5CDEZgSEcphSSFSX8nuDokcuxjUoIRJtqPE300LdbCKj0zomkIsF3Hlrnkx29kKbxeQgyJ3wxDSZvzRggTNWn1dj3JgCS+xDmXfnjacQdfnL1U3xBQhqrDtVCOKJ4k6AdJn7rjDOMjztHmKuvo+2VZcp8e/tg1lphyD120RNSjswyrk9+7sxkIjaWeFZwDG3jUcgZ2/6B/omXshCTi9ATHamKxvFPXvtzBH21qW8azYLQy0qnSCPUSlrGERlYO+tpoeVC0oO68qCuaZ8SbscBnQlrfEsUNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZ7VjY+/G/86Gcy1TWuESR71QsB3wtMmKiQR5D+4OFU=;
 b=dSDy0/f9zdFEm8vMrLrSXe24i0rpr9Tw3HEYSroQf392vzeO+W5Hbyz7oYF+T+sB+xR0ik+kMEq+lRxrkrLxyWHMERdWzJmnsdVK4XrJaAXQ2BPyB9h/un0gd61SR5ubW9k6S2U/eQw/ofXHlYVQKFg3X6BLr+KbE3yAwEbRo/U=
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 03:03:26 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::30) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.17 via Frontend Transport; Tue,
 28 Oct 2025 03:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 03:03:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 27 Oct
 2025 20:03:24 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Oct
 2025 22:03:24 -0500
Received: from [10.136.37.11] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Oct 2025 20:03:21 -0700
Message-ID: <b2adb9ec-b4e3-4744-afee-8b93f2185837@amd.com>
Date: Tue, 28 Oct 2025 08:33:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Fix non-empty throttled_limbo_list warning
 in tg_throttle_down()
To: Aaron Lu <ziqianlu@bytedance.com>, Hao Jia <jiahao.kernel@gmail.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <mingo@kernel.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	"Hao Jia" <jiahao1@lixiang.com>
References: <20251027090534.94429-1-jiahao.kernel@gmail.com>
 <20251027120211.GB33@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251027120211.GB33@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b739a8-aab9-44ac-aa4f-08de15ce8fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFpJZVNHMlRGMEZPV0htemlzYXRDbTU2L2FnZFVOc204dm0yUGF1bGt5TEln?=
 =?utf-8?B?Q05MTVg4dzBWdVhoWTFxa2tvMDFjbktYeTJSKzF2M0trbEhzYWdmckMrZERF?=
 =?utf-8?B?ZkQ0TDdTdFlxZFhjdkFsSTBTcHgwaTZNWUlqejJ3QUFaYWJIc1YxUlV4N3pT?=
 =?utf-8?B?czBWc0ZtRDJIWURsZnJUb2IxWHl1ZjVWaWx3M0ZERkxBS3Q1cHlVbzl0ODN6?=
 =?utf-8?B?bWZMYmJHTTVhaEhET0RTSzE1NXplV0tuTkw3UHVOR1JvZG9MdTd1WHhMWG85?=
 =?utf-8?B?bDB6djgwQitUUVdXRTdYdDFkQTJ2OU01RjRSSzlTY0xJaGFkMlZZV0lLanRv?=
 =?utf-8?B?a0xLRmJET0tLZlZiUk92OHA5SzkyTUNya215SXhlYnlmOEhPaEpCR2tJdHNG?=
 =?utf-8?B?RGY1ZVNSZGVPTGMzZ0ZsaEtCczdvbUtKcjBJd3dYNWFUd04xOWJ6c3YxNFRO?=
 =?utf-8?B?d3U0YlpXdlRmZG9rOW9xQklXeUUwemlQQnhsRlljM3hOVDZrUVA4bGo0ZHpr?=
 =?utf-8?B?QXVGVWpBMUZmZThiVkRlMS8yS1A3K09WMW83QzV6bnJUSWJWMEV5SXFKam5P?=
 =?utf-8?B?b0FNdDlkWnptSUVrV1N1anI5aHN6MTRoeUV6T1R5ZW1kL2xCRWdOZjh3OXlp?=
 =?utf-8?B?L0xpeVl3NCtmdnkxd0VEb3diSzVGTkNBVE9PYkZxVzRBVjliSzQrcUJ1aURr?=
 =?utf-8?B?NTVOMUJqeHplYXorazdtSmZ5dDk3RkIxajNPMFA4akNENmJWdmNxZk12d0R5?=
 =?utf-8?B?RHJoOWxXK1d1ZDM4Zng1Y2gxM2QzR2VISWpPaXRJSmpiL0g4VFlQT2lIQTBS?=
 =?utf-8?B?S2NnYjhPVDM5REFVTnY5VkRHd1B4eVU4RmtUUENxVDZtajF5QkMzanNYUVEy?=
 =?utf-8?B?Zlc3QXdobFBJV05lSkhVR3lqQjZIb2gwR0JmZHYweW5IZEc0UUVJTER0b2s0?=
 =?utf-8?B?djZBalNpd2xLeGJXWVNXVW5ZN25uaS8rdmJ1ME9DRms5OXRlU1RZaWtPRkRY?=
 =?utf-8?B?NVJxam5mWlUxYy9OVGhGYnRXUU9aSTFmYTEwdUNRVStBRkQ3UUQxTlhUb1ox?=
 =?utf-8?B?YVBDcmZYdXVXWmtUQVhGVnhoWlF3V2pMMzl1VCt1UkRBVm5SV2pCQ2t2QXJP?=
 =?utf-8?B?R1lxNzFTek9DVlpxbUNpOUFueWxZb0pQOWRpWVBqU25tdU43WGlHek5VTTRX?=
 =?utf-8?B?aXZsU05FMmdFaklYNGpQcmFyVTVZblJFQkpLRjVkd3JhV2dLWnVMa3NqQXdF?=
 =?utf-8?B?RFlPZDdJdG9nYmdsL2ZOTTdINTVNdkp0QjFaNGZ6eVlIOTZnMU1jcVRzb3Iw?=
 =?utf-8?B?SUx3by9pOFJETjBIMTYrZkVRWlhtaVY4dXhMSTBNSnRNdU9qczlaQmxxa1NB?=
 =?utf-8?B?elFFMWc4cVRlRm8rTkNjZG5yU01rLytnbGVnRWwyZ2NGbXB0cWEwcjdIR3NU?=
 =?utf-8?B?T0M4MWNQSFEwbVlmL3RiUTZoT1F3NTJEblI3NUhDWUEyVEk4dnRzZWFRSTZk?=
 =?utf-8?B?dEZIL2RWYU5QWWtSWVFLVHA5SXhMc1JLMlpJYWxNMjZ3czdkVGNURm5WaDF0?=
 =?utf-8?B?RndSOUcwc1licGY1SmZHd1NScHZkOCtxNVJvQjBVeTk3bGoxY2ZPL1NHRVF0?=
 =?utf-8?B?U2ZtanNrR25XOFgzRzF5Z3I0ZVNKUGMrazBYUkxwcTVPVm5CWVFPUlVXdDAv?=
 =?utf-8?B?aEdPdTh5c0xCRHVBckRRT2w0NmlNRHl2TkZFYTdJckU3U3Fra0RzcmFKTXJP?=
 =?utf-8?B?QkpValNmZE1oLyt3ZWs5L1hQeVo2THVCK0M4TTQ1UWxTd1htb1kxSGF5Q3Av?=
 =?utf-8?B?UDI2N2p0NTZRaG5ralJwUjFUVHZDSTVyaUR6eloyekR0c05pOGFWSG5NZUZU?=
 =?utf-8?B?UVB4RnUzOTdWdGU3MVN0WUtUNzZtcGY2WGduVzFhNmZqUDhDM3BIaXNmQ1FO?=
 =?utf-8?B?ckUza2tyNU1lWVlsUER6cFhHUWtoMjB3RW9GVWt2c0NrdGI0TGFCaWdWVXlT?=
 =?utf-8?B?U1dKZjJtQm5FMU00eGVNc0dLNmlQSzFOa0Z2R2htZUUvTER6Z3J2RXd3akc2?=
 =?utf-8?B?UVdyVmh3S09xQk5iMU8zaldYV1VLR0NGNlhJc0FWRndsVUJ6c2QzeVdQbmFa?=
 =?utf-8?Q?B6qA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 03:03:25.0667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b739a8-aab9-44ac-aa4f-08de15ce8fac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217

Hello Aaron,

On 10/27/2025 5:32 PM, Aaron Lu wrote:
> On Mon, Oct 27, 2025 at 05:05:34PM +0800, Hao Jia wrote:
>> @@ -6403,7 +6407,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>>   * expired/exceeded, otherwise it may be allowed to steal additional ticks of
>>   * runtime as update_curr() throttling can not trigger until it's on-rq.
>>   */
>> -static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
>> +static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags)
>>  {
>>  	if (!cfs_bandwidth_used())
>>  		return;
>> @@ -6418,6 +6422,13 @@ static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
>>  
>>  	/* update runtime allocation */
>>  	account_cfs_rq_runtime(cfs_rq, 0);
>> +	/*
>> +	 * Do not attempt to throttle on the cfs_rq unthrottle path.
>> +	 * and it must be placed after account_cfs_rq_runtime() to
>> +	 * prevent a possible missed start of the bandwidth timer.
> 
> Hi Prateek and Hao,
> 
> Does it matter to start the bw timer? If no cfs_rq gets throttled, the
> timer doesn't look that useful.

Ack! But if we've reached here with ENQUEUE_THROTTLE set, we are in fact
trying to enqueue a task during unthrottling and we only start the timer
if we don't have any bandwidth since __account_cfs_rq_runtime() would bail
out if "cfs_rq->runtime_remaining > 0"
> Also, account_cfs_rq_runtime() calls
> assign_cfs_rq_runtime() and if assign failed, it will do resched_curr()
> but since we do not throttle cfs_rq here, that resched would be useless.

resched only happens if "cfs_rq->curr" is set andcheck_enqueue_throttle() already bails out if "cfs_rq->curr" is set so
the resched is avoided.

-- 
Thanks and Regards,
Prateek


