Return-Path: <linux-kernel+bounces-786876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E05B36D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91FC8E8548
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0321225788;
	Tue, 26 Aug 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kvgbG/f2"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847920E6E3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220603; cv=fail; b=e/ehv/sxTHtEpRqV0IGxouZPE0pAhFvGVF5008RlrHmFtGEGDuIfUBgI3Zeg1Swgor1/CfDxWEwP1+0PiTzhm692xQl4lcfj7SVdJMCGNteXY6IMRpOPAyjk8CSJlvWTG9LGv8GSTyFfABksYW91cZYauw4b7ru+OqCmg0DFxkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220603; c=relaxed/simple;
	bh=XIzPq5TwSM16Ihny6iLmUblZWE0FEs0lgEk9eT9rf8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VnC3rSdDCv0wCpRrGhgnC/rVmGNhl4Kq00AqnFMs/e4eKcbCOCs7B55SE9HK3tMtxLV2Q5akEsjGBsB3eK/O87ZyiKSiplqhN6QNAa49IaqnNe7htzcHi7LSLvV6Rkv9cCv1xlcPEvO6rbfaoOG2PkjC2IYFvnMLjA3u9gzjGTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kvgbG/f2; arc=fail smtp.client-ip=40.107.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjxEtNVqTw17pU47dmKbiN7g3tfKVeUFXmedezvpuS4+ZcL1p6wdjYju8Up9wEEO6pgxgAW0WCnPtHiN0e5B0FSoSBOpwU20kGsJjRC0U5UZBMVEuNIPGCC4ZmNrQCK/nN51Mj5PK+ctKN97+GwrvbFGljh7n5GjOz7MB8H6IzuTeEwDBkLb6VKs3WxfYblrUQ9T/UbfzP3MQfUkyPmxfA2ERD1beGdoQN/wM6gag8Y+mDhFJyh6v/8qo6NoGMa7XfMa6bvhT1treTyFI6JKkMDI3sOHE5yI905yg9cxn1AmjeO4/ZvThzUl0/Rh1I8EHmwqapmERrBc/ePN+qD0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydX4oJBliobBALOoMAF/ClAPXYhPK9SrhaA7+tJNJp8=;
 b=koxOt6999WYSsOLbQPGueRaN6ua/QoK013VIEdNYYr84PsyJnyvXkHU5hSS7NLqY3LOzMDYrWVrBCsRUFDFtpi4AVCXeKnC/PAAwt7+C8SsUO+E6IXGEtL5uXDANP3UJ2C5STEByEq8PsNkLKSXkalF50B0T0ZzoH3TLPI6Vpz1OsULPHS/uHvh881306A0NPf730l1smKDGgS/nDYMYf7sX30fyAV3kikFpO8dqNQ9zEeG4Up580yZY4wzRipfabUyYTB501GrnaQ6H0Ss3SNEkYZMT1SBpBpOUARkmHpBxtJWd+FIy0mt6bCH/1Gs6wDhnBhip/xFUDQRHrxElyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydX4oJBliobBALOoMAF/ClAPXYhPK9SrhaA7+tJNJp8=;
 b=kvgbG/f2X1e3671hUvae1UuM3re7G0dsAue43rvz7qb639gxlBZG09H4HqagR/L2q9zQ7iUiu/ZFY98gxqdgd+xAIYqkh/7Foa/SQ3WQNSx/zOgxJVkf9q7SOZCWfzEnK4FlfTbn2wBZyQ0vOVvWMZQ+dq1Fz0c6ML+iJTU4qPA=
Received: from BL1PR13CA0087.namprd13.prod.outlook.com (2603:10b6:208:2b8::32)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 15:03:18 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ee) by BL1PR13CA0087.outlook.office365.com
 (2603:10b6:208:2b8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Tue,
 26 Aug 2025 15:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 15:03:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 10:03:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 26 Aug
 2025 08:03:16 -0700
Received: from [172.31.63.243] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Aug 2025 10:03:15 -0500
Message-ID: <cdbd3849-c366-4d25-bf72-23587d79ab6e@amd.com>
Date: Tue, 26 Aug 2025 11:03:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] xen/events: Cleanup find_virq() return codes
To: Jan Beulich <jbeulich@suse.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>, "Juergen
 Gross" <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20250826005517.41547-1-jason.andryuk@amd.com>
 <20250826005517.41547-2-jason.andryuk@amd.com>
 <de9005bf-c858-4e7e-bea8-33e5ea2424fc@suse.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <de9005bf-c858-4e7e-bea8-33e5ea2424fc@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 05456d1a-5624-4f90-169e-08dde4b1b082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHU2RER6eDU2cnNLN0V0V2VxODFycmdwOXRWSmZuaTFGWVhYdUU5akpQd3pk?=
 =?utf-8?B?RlJjNFRTaDc2Zy9PSDRUVW44LzJ0OTV0ZzZwc21KY1d2MEZsUmwyb3pYRVVI?=
 =?utf-8?B?c3VYdlpTVm1jaFduSFh1RldEMDBRdVdLKzZqM05rVFRjWjlQSDBES3B0ZU02?=
 =?utf-8?B?M2hGcTdRQnF6OU8vOFRtTVRVc0NURG1admQ1RXB4cll4Qkl4bG9FVWZCWTI4?=
 =?utf-8?B?aW9ub1VudmVJZmVBMmtGL1NWbGViWUtDQ2FWMWkyVE8wVUZyRS9ldlFSVVND?=
 =?utf-8?B?UDJnckVKeDZyN2VxVCtETnpzT2NXamRFRFI3dHhyWGswR09taDNDQmE5SHZT?=
 =?utf-8?B?djFHYndzM2dnanF1R040MUtqRVpBWVV5OU5QYk9Ha05KeTZqVEZKbnJFY1U4?=
 =?utf-8?B?OS9SQW0yeEdFR3VZeEFPOEdwTkVGcXNwZ3diY3hQalU0dDhEcEN5cktmUEdB?=
 =?utf-8?B?cUFvdGFTeS9SZjJaVXhOek10RjhYaHlZSmhtNXYvV1N2bmI0bmRUbkoxTktm?=
 =?utf-8?B?QVE1Y053czVFa203OExMWVRvODB6aTRlYm9NbzFBTkovSTZXd0w2UlNQaUR1?=
 =?utf-8?B?UnFvbGxYVGZKcUtxM2RyNlNjV3BZenR3aXpPeTVDL2k2Z0dYdnVuWFRYTTVk?=
 =?utf-8?B?ZEZRamFNb293S0NYb3VscFQ4OEtOOUVDQTZTeGpsWHlydXpFMjA1VDJ5cjlp?=
 =?utf-8?B?bjM1VVJLNWV1K2N3dlk0cmFmKzgyZExjMndBUXVmMzhVTzRHY0tUYWR2VUVK?=
 =?utf-8?B?aHdPdUNjM0JUUWtQRTY4WG42bE9YVWcxelRrTmV0amhxaDZKUXBTT1h4UnVG?=
 =?utf-8?B?SWhlODFVQnJLTU9FOXMvcHpiSG1lOXZyeHpLTzlCeFVoZjVrK3dzeERjYUdW?=
 =?utf-8?B?cldGRnQ1L3Jzb0UrTFFpWlZ2dG1wNHpNMTVrM1RvMm40Z3RzTFlDZkkyUk1I?=
 =?utf-8?B?ZzFHQS9mTHVUR1M3MExOOXRka3hNOTVJTzJmTlpiT2ZkQVhLL01WZ0FtRjk4?=
 =?utf-8?B?cU5SR2RoQTJlT2s3QmVDQktxQnNycVZTV0VNNU83OUZ2d1UvaTN2TjMveEp2?=
 =?utf-8?B?SXFlSVFXVGxOaW1FZ2M0VWd0azZyZmJSUlZhMnB1d292TzliOTBSVk1Edm0z?=
 =?utf-8?B?alJXaWNxUjB3bnlocmYvRnJpSzNXZU95KzcySDI4YzVsOTVQdUJIVW1FMDRH?=
 =?utf-8?B?bkt2R1JiM2F3K0o2QUovV0JHbHhHeHlYUTlRdUNQNDdaN0J1Y3hmZ0xYc0ZO?=
 =?utf-8?B?eFRON0k1WjU5Tzl2ZkNFcDViMDMyQmFkQVBJUHhyUi9IRmRjRUdtdm5obXBw?=
 =?utf-8?B?WnRPSk9UaXRhazJ5b2s3SThXdENCOHdTMVZ5UHp2T3VNL2NqV281TmNVajNn?=
 =?utf-8?B?ZDN2Wnp5RytFb2tpY3phMXdWZDVVWUFvQjhEbHBaSVRxcXZEZDQvZDQ0bElI?=
 =?utf-8?B?dE9mblVIcHRiV0YxME1WVFBqTTRPa2dLeG5CcGhuaHZMMURkZFZnbC9EbEYw?=
 =?utf-8?B?aFNzb2dpS2xqNTJkdkhtWXdIRWpQZnRlSE43RTcxQ1VHeWNPQWpad251bkNp?=
 =?utf-8?B?WFRBcDByK1RpTHc0Skh4VDloWEZvMjRKN0ExUnpEcll2ZUs5ZmpOTFh6K2ht?=
 =?utf-8?B?eVZ4bUNHWDRhSmZyaWtHaytuNTJudTg4Z3h3NFFDTkN5b01Jbkdzamd4ekxX?=
 =?utf-8?B?RmswSWxFVlhrbUhOZ3g5WVV2bzU1bUJjNTJqaXlHM1lVVTd3VDhObnZzWWxh?=
 =?utf-8?B?S0Mxb295ZC9XRHlJam1MTDA4ZkFNbGEvR2pUK25oRXI0OGp0WWRGbDdxcGxt?=
 =?utf-8?B?UDlBbTVqQ256OW15SkhLSCthc3RGWFZxZzY0a21DTXltQmxaU29FUjdidHRC?=
 =?utf-8?B?SU5IQTRSRk9zTmJEd0NRQ2NiVUZvL2ZiT3FDVDYwM25GNFQ4UW5Da3R2S1I0?=
 =?utf-8?B?d0ltQlBrblhscWttRWJoSlJlSEtQWS9hNytsTnExR0NQWjRXUGlCUnFMVHlr?=
 =?utf-8?B?RXU3Q3lpbWowUk15MnNEd1oxZ0FRU1kxUTFGSGl6QXU5dmpZeWVNZVhHWjV6?=
 =?utf-8?Q?fIo/VI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:03:17.7695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05456d1a-5624-4f90-169e-08dde4b1b082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408

On 2025-08-26 03:22, Jan Beulich wrote:
> On 26.08.2025 02:55, Jason Andryuk wrote:
>> rc is overwritten by the evtchn_status hypercall in each iteration, so
>> the return value will be whatever the last iteration is.
> 
> Which may even be a false "success". Especially for that it feels like ...

I'll state that here...

> 
>>   Change to an
>> explicit -ENOENT for an un-found virq and return 0 on a successful
>> match.
>>
>> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> 
> ... this also wants a Fixes: tag and perhaps a Cc: to stable@.

and add these.

> 
>> --- a/drivers/xen/events/events_base.c
>> +++ b/drivers/xen/events/events_base.c
>> @@ -1318,7 +1318,7 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
>>   {
>>   	struct evtchn_status status;
>>   	evtchn_port_t port;
>> -	int rc = -ENOENT;
>> +	int rc;
> 
> Maybe best to also move this into the more narrow scope (loop body)?

Sounds good.

> Either way:
> Reviewed-by: Jan Beulich <jbeulich@suse.com>

Thanks.

> 
>>   	memset(&status, 0, sizeof(status));
> 
> Having this outside of the loop is a little odd, too: It makes assumptions
> on the behavior of the hypervisor (like not altering the structure upon
> error). Yet likely not something to deal with right here.

Agreed.

Thanks,
Jason

