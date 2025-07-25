Return-Path: <linux-kernel+bounces-745280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E915AB117D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD18E1C86E80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130C242D92;
	Fri, 25 Jul 2025 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nLSMhwgo"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB81F61C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420396; cv=fail; b=KBmJpY9BM88h0LM4iXSyzLYpxBGlndM2jFP38Reuuj1rH+SUUsVZVQdHCJXYuznyV67BShn/hUmK3cFXW8NSqSx8lE3Le5ly0Ujnp4B/1lISGHkcTQ4v0KnC06938ORVmacPcWRwtg/M7L3tWOqHOUJ/RI2qpfWEivYY6oY6iGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420396; c=relaxed/simple;
	bh=ren6t0XXPo2enro6zBo9+45vtgcZAcxmC/S61yn0lLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HFWbDvZorxlxDO1sbF+dcqeGhtXVtqSrnWKwQ0tz7v+yV3q4sM2tNBTH+j6yuy3YN5duehUhcO33SDwNn3EwO/6dxNCL947P5B6ImOqtPknye8mjt9V/d9+hFrxg7uChbEenIJvwtBRb/DHke1vTq2/F5GwXwax9CtCPX5zrJVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nLSMhwgo; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dML+5afsh6h6E3H/aDoPbTeCknRxBg2s8jFztXzgXgodT5ArjOstFKy+e1u+P1o/Ay6XmEdgy1IChm3Ib2LZwSrVAApBATcebCp4C+AdsrfQdn5SwmpJ3BgbsrJ9NWgmKAnqyOCGcVuSiABUUHeJhaXdF2tLz31ievnZ8NMaLsmV7Dvfdv7rxgnXpvSzNNVVYmV35hEkmli77Md+cisive5yq3Jo0gDT2BvqFJ+VVHosZ/7+C+wAfWd48K6DnWPewfY7r56eG6v4iI43gU/MMyUZYZNcstS4bIU1CJJer0JIt3uhNRKsfhYKUVfhFcUonNZjvPznG7YiwNTwqnrSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9J3gCd3YIqHCeKo/0pD3x15gyhGctc4XjpcEfMGnhU=;
 b=WIWbVREQyu02yLrirnO6QrJ3p6pDtjsVFaAl44Hgq+hxzXmfJJp8DVnSu5e4vXt0oF9dkfRZI7AI7SfziQqwzEAcLkq74BxA8y3+YwCRkNdno+Qjqdox4HJYeDTfyLyIRJY4rcKPQH3HJvtLN+FcdFktu4k2psuUKk8bogSzdd6Q1gy0Os2YRLOVnj4RX69A6RS72CFJnnZa5eAHcROIZuvlvGEe8DCkk5gMdPrOfnZtUZmpWv9txlYJpE/Vj4f+Mdgvwhgc8IbVnd6g0n69PmL1uYiECMsJFktk7FQ6igpIdx9yx9F7PNbfSwbXNDd7Wmx1wapHtBT4MCJDATmycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9J3gCd3YIqHCeKo/0pD3x15gyhGctc4XjpcEfMGnhU=;
 b=nLSMhwgozgv5a2f+NULdeTIeOcXriBnyfd4CAYQPEOTmWkJMxp4oqoklJ00WwBPB7ziiOanr/zpsleHcA72os97JwSn//8MM6z1t5nKR8X6Hx+sH0Nbxz5okESVRWgEV6MQde5rUqQztSmChhPlXvlHAtUHjCny9JWX9wGykCYQ=
Received: from SJ0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:2c0::10)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 25 Jul
 2025 05:13:10 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::d0) by SJ0PR13CA0005.outlook.office365.com
 (2603:10b6:a03:2c0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.7 via Frontend Transport; Fri,
 25 Jul 2025 05:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 05:13:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 00:13:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 00:13:07 -0500
Received: from [10.136.35.26] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Jul 2025 00:13:04 -0500
Message-ID: <72b7f683-0497-4fab-a05d-333ec5d2c309@amd.com>
Date: Fri, 25 Jul 2025 10:43:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] sched/psi: Optimize psi_group_change()
 cpu_clock() usage
To: <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
CC: Chris Mason <clm@meta.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Beata Michalska <beata.michalska@arm.com>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.350561696@infradead.org>
 <0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com> <aHdMTdPeQ1F6f-x9@arm.com>
 <20250716104050.GR1613200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250716104050.GR1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c2cfa8-85d9-4db0-3e19-08ddcb39f303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDJPckYyV0w2UjNRdUNVbVlUdTBrWUtJWDhFSDhuV3Z5elpWaUNKbytoS3dV?=
 =?utf-8?B?T3RFQ3Z1Q3ZyNHordEgwSWJCZUtkSGQ0KzdJRS94MVJzbXZYK2Rxc1VlN1VJ?=
 =?utf-8?B?dE1Vbk1MMnk5d2FsSlpqU1pMemFObmxXTWtZWUZOTTlwTnlzMlF5UzUxVTh4?=
 =?utf-8?B?VHh0OUJtV0k3c1AyUWtVU0VSKzdIaUJXbXgrdXV2ZHFJZU4zTEhFeWlZTFJQ?=
 =?utf-8?B?TTBxeEZQOGxSWjFoUHVpdktRY3R3U2Y0QUNzK2VyVktPa0hadmhtd0dZTXAr?=
 =?utf-8?B?czZZRjBCUHRTMTRlZGREeGttOHRzY082Z0VYYXpxSlg1NGM4RjFwZXJadzFG?=
 =?utf-8?B?OUltOFd0ZUlTOUJYS0JsR1Vad3BubTdYZmxsRFNLanlWVHh4bklOc2N0aFIr?=
 =?utf-8?B?ZUVBSDVnUWcxNkt3QVRrZVB5TDhiZ0cvUHBsVW5NZUFQYjh4UW12MngrSzdR?=
 =?utf-8?B?QnlFQXFNYmJiUUxTTFROVFlhaUtvYmdKTWZrdnBUQTI5dEpWL3ViRjVpa2dy?=
 =?utf-8?B?Tk5mUFlqaHlSSFNPTk5hak56RHcxSEJqZ2UxeXFvNFJyTFU4NFNIVHdtSUk0?=
 =?utf-8?B?R2hNd2lZNUFFUlVQb2ZyU05jSVBJOWJDU3BGRm5IblFlYW9DUk9ZQWZHTzRw?=
 =?utf-8?B?VTNrWUNLbGhHSjVVazdVdHNDUDZWQzlJOTlVdnU0VVVjYVpKK1lvTmFUNkh4?=
 =?utf-8?B?c0JNdlNUNEJGWkVxRzI5akR1cmU4cDRRc0J0eWZGZU93L2lMUmdCUlRIRVlU?=
 =?utf-8?B?bjZwZDNSaG0rUHJjMnVzWHZIUGFYL2pxZHgxaGF2UHJ0aHJzOTF5djduVlBu?=
 =?utf-8?B?ZHlzQk9nZXNwazQvV2NTU1JhcEVGOGlaOUZ6NFhaWFhacHR0cUYydWxjME1R?=
 =?utf-8?B?eHdUb000SXJrSE41YnBBYkpLNmlYMnNjUFZxT3BiaDhZZ090MituWWpYNXJi?=
 =?utf-8?B?ZmxQWllIR2M4aTRHWlBieklBWS82bjd6TU5BN1d2Q3BGRE11TnZVK0RFR1dO?=
 =?utf-8?B?U2szdDZXR0wzVzhZcnlxOHV4ZUtwcU5QQmduUjhiMnBabDkxN0RBSEhVYzNF?=
 =?utf-8?B?Y0RoeEgwNTRxRjdZRmduT1grZmpOWllwRXdaMEZIc1NzTlVwUENXbURrYlRK?=
 =?utf-8?B?UUtpeFBSVS9PUE1vdSttYmpETHZDcDhJV0U3L3p1Rjc4NmZuVDFocnVmaTBY?=
 =?utf-8?B?YVdSSzd5MEQ0c0xXbmpvTEhPS2VTazJQSlBKeU9FbTZYOTAyZU1QWXJpQTNs?=
 =?utf-8?B?SVVrWjRKR0ZOZDBYcmVyRWpiSmJxQWdIdTJlbm9qbnpNWGhjUGVOTFZpVjI1?=
 =?utf-8?B?U3Z2Zk53MDM4R1lFZ0F2aXRKdzBDSUxLcFlXUERwNmtrTWErQnlGMk04UHQ3?=
 =?utf-8?B?cTlhWFFVYmlGMmV4UnNlekVqemUvSGlWd3hzTHlBQ0k0OTFVRjM5bVp3OUVB?=
 =?utf-8?B?OFdqK0hsQ2FTc3RqQ1kxNEpBWWdSQ0tRSFB2dXJlMTZYQUdISVVyNUN6S0Rj?=
 =?utf-8?B?cVlCdXI1TTZJck85NHN4cEZSM2l5ZjAyUFBJRmUrSDRPdnlMbnQyZWN4V1Uy?=
 =?utf-8?B?OTgxL0Y0TWFrOUVTK1YvTW9QRnZuUFEvdW9Cblo3OUhhMzJFOGZBQVdiVjNW?=
 =?utf-8?B?ZitaaytZZjhnMkw1YkFvSmFvZEwvSWNVTEhLSCtOTlA1YjJCK0J6bHlXVXlI?=
 =?utf-8?B?QU1lTmtROHlNNkVkTlJuWGYxT25ZbSttSldDUjlCTG02b2dmZzJpY2RvZWZ3?=
 =?utf-8?B?VHBkY2g5aHliMS8rQi8xN2J2djg4eXNzcFBpVkJmdWFYdmNsbUVWSWxuek4v?=
 =?utf-8?B?aERQN3dZSGQ1U1BWVy9GZnFjdzRIS0xUaUNhWGllNHZPWXRhWEE0RlhGVmlF?=
 =?utf-8?B?UEhhTGN4U3pyalliT0J1K3drY0loM3NPc3Z0THgzMEpCK0V2QUZyK1RrQ2l4?=
 =?utf-8?B?KzBHTmJURE9HTWk0NjhVbTNNV0c1cmxLWHJ5bUtuby9nTGYzNStlWmpoWjlS?=
 =?utf-8?B?aFMwRUU3VDQ0VVRaUkJMOWViUXBaUWM3Zi9JMWROcFUrNFdUMWZBUGgwQ2ty?=
 =?utf-8?Q?GOEoWh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 05:13:10.5789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c2cfa8-85d9-4db0-3e19-08ddcb39f303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656

Hello Ingo, Peter,

On 7/16/2025 4:10 PM, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 08:53:01AM +0200, Beata Michalska wrote:
>> Wouldn't it be enough to use SEQCNT_ZERO? Those are static per-cpu ones.
> 
> Yeah, I suppose that should work. The below builds, but I've not yet
> observed the issue myself.
> 
> ---
> Subject: sched/psi: Fix psi_seq initialization
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 15 Jul 2025 15:11:14 -0400
> 
> With the seqcount moved out of the group into a global psi_seq,
> re-initializing the seqcount on group creation is causing seqcount
> corruption.
> 
> Fixes: 570c8efd5eb7 ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
> Reported-by: Chris Mason <clm@meta.com>
> Suggested-by: Beata Michalska <beata.michalska@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I've been running with this fix for a bunch of my testing and when I forget
about it (as was the case when testing John's Proxy Exec branch), I usually
run into the softlockup in psi_avgs_work().

Is it too late to include this in tip:sched/core for v6.17?

Also feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek


