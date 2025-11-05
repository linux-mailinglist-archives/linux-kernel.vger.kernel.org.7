Return-Path: <linux-kernel+bounces-886933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16ABC36BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386711A236CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7C331C56F;
	Wed,  5 Nov 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MauNVSVW"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2862F363B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360457; cv=fail; b=oZk/ND2Lvim9qnL8BS1uqZkeZK3PO4n6lwVLzs6xCmis8dDf2BfYCSOWr1JcxjcmzLOKfgb/zYcvplkzWXtU0G9gcXmwb5hfWmYbuTCxLjnzDuX8o2+r86Ri5JFfYjHFnbcXbXh9bJOIBsS9bZutXlZhW5Rd3OcPx47ZSUqRCdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360457; c=relaxed/simple;
	bh=2XQ5k5EWJgZ0MxvVn1ZIKLIGeCFn3TBH0A9XE0cp2RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g2Yd+4ca6qvLxCVyzaOl3J6jz0TeuMQYdCbPDuGW6CItisxH5GVqUmd8C2zqwyzPKQUdzSy6yukbqcTX1jZUWW/iXUwheJU2uA06uhD1PK/V4pbkNpuR3SFNI2oiwvpMhRehoAI5bb8O3TU7jqEWxA9j3GOZAIlAXko/9TxJ9eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MauNVSVW; arc=fail smtp.client-ip=52.101.61.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFfHTW2ryASMY871zYLRSM4UhkrchVNN/WDJyAs8yzkHCTdLZCnSlQlJLvrK5+yXLnPepP/y3PKoaplGl14TUZNiJAyt61QUOMz+NLkRXkwTZJgrUVBfF9f9f0kP5C/Zl7+JSExXS/c9TMUDFSoNgDl8RumyhHneF8CTTkxzJHwlx4pKrkUKPh07Acc3LW60oDSkujvb6wUM3JQv9DBi4x1qVNaxJ1rt42O4BQ8WdwTqcoUipbxbff4j0QfGmHWklxAtlfGOzYJEKx4hsXLMrEBUGd1YqA3hiR6c6IT3TuZl5+L1Y16Tlo/33LkXcZh598W5R4EcK3FIt5ZBUKsbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ersvksrSg8fOHAOeCDuIVcwk2Bft/da/7GgKC4WUPME=;
 b=u7Kbd9WvRJZRefiOHMTOhEGs0tM65MTKldf3ZgGwenKp74bj1L5rBkyKB2NMs12mtb+8vSbkyO300MU46CwQjke7OWsFqH+f5XiVz5LLXpr0beFuuJwbEUvkmqg6aen8ZO6qiDDL5f3A4otbApDHQuddiuwwxoZ1CNzMYDRgdT9ceV3/RLul8ZmrOkUmj/7deBubi0vfzOEuvAt0wyfdp5MMlaH93OdkFohLKRks7ignVLak1EzaKX8MF8cPEh602QuilkfdHPWYncHLYKFXW2GbrvamcZfP2bPh29Bobr9gAZrp4uxFmK6pinZ+04aXqBlyz+yDNfhvhfYHcs8cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ersvksrSg8fOHAOeCDuIVcwk2Bft/da/7GgKC4WUPME=;
 b=MauNVSVWMOWIYvmAMAjGJrsiiKyfXIRSwLfLJ//t+s85jO2rvjjTQDDVBf6pRjlMcSKKLpdVOT6V8Zi9FbObAbSxnIYZk66rY20L21FGVtfDlWGYpcQdJ2TQpOCDuK+5XjozLnyHEt04vYHj5sXH+W272sPPftjPDf51VlMYfAs=
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 16:34:09 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::f6) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Wed,
 5 Nov 2025 16:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:34:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 5 Nov
 2025 08:34:07 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Nov
 2025 10:34:07 -0600
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 08:34:02 -0800
Message-ID: <f7169de1-76f4-4bde-8d9a-cc62b7e3157a@amd.com>
Date: Wed, 5 Nov 2025 22:04:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Optimize core cookie matching check
To: Fernand Sieber <sieberf@amazon.com>, <peterz@infradead.org>
CC: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<dwmw@amazon.co.uk>, <jschoenh@amazon.de>, <liuyuxua@amazon.com>
References: <20251105152538.470586-1-sieberf@amazon.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251105152538.470586-1-sieberf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: eacadc56-2e61-476b-5d35-08de1c89253f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUJnd2lsakZqRGEycS9udC8yOWhMZUdFcDNqYUV0MERFRE8zK2JKUXJHbDBQ?=
 =?utf-8?B?WnlMYUpScys1TjhzdFRHRlJvNXNIT1dSTDZLQjFoTktrQlVYS0l1ZTFlN2Uv?=
 =?utf-8?B?MElVOFVtZ2pLQnZpb0c0Yk9NQXpxUE1GeGk5VEJHTVl3bFBrcEU0dklHRnlJ?=
 =?utf-8?B?Y1VCTklkbnNxWHZYRm1PWXo3Y1BNSEluaDA3WnkzNlR1eTVCQXN0U28vV2My?=
 =?utf-8?B?NUJ4Zk8wb1o5NXdrNWUxQUptbG9FWkN2Ym1LeDhuajdYditadkFhZ2d6OEcv?=
 =?utf-8?B?b2MxZmNMU3JwcVN4UkF2M3pRdU5vWEdSUjV4TDBocTNXQWFPbXhSMDk0MmhM?=
 =?utf-8?B?b09pdXc2RnZwN2pxWXZKMUwxcGZ4Y0s5THJsVG0rUkgwUHhwTGI5ci92OE1P?=
 =?utf-8?B?UHYzSGd2cWpwVlZzTlgvRG0wVkZMUnJUd0FiT3cxM0ZOR3F2SFUybXN0Qzhp?=
 =?utf-8?B?d01PdGFXd3NDUEtTVm1VMjN3N2lUcXNLRmdCaFVIZzRBYWFLMG1EVVorYTdZ?=
 =?utf-8?B?OG8rRWlrVlVVekM1SmloaXhKaG01Um9wajh2ME9lVHEyQW8vdkU4M21UVFlE?=
 =?utf-8?B?VjFiWHRacjIwRVV2aXUxUWJRMnBKb0RINW11S2N4L1Y4eFFGbG9aMmVmVTJo?=
 =?utf-8?B?aTMzME1BMXlzZGZ0UFJFRU5Ib0FrOWpUc3FjM3BwRUVsd0E0d2ExMXF3eHdj?=
 =?utf-8?B?VWRaelBnLzQ2by9VNUlKanlpUzF3ZWU5WXh6MVU5ZzIvbWNTMWYvUjZ5TjQ4?=
 =?utf-8?B?TEtLODU3RDlVSXdvOHZHbFhINzVtbmFkRVQ5UlN5dWE5MzMyeFdqTXVUVmtI?=
 =?utf-8?B?THlrZ0tQOTZEaWpqSERwMTdzOTc4QStoYVZqck1ZOXJFZVJjS1J0V1FvaEI1?=
 =?utf-8?B?S25nbW9aSUliRnhUcTJwRkxkYVcyMjdreUJIZVNFc3lZRmt5U3Fid3Z3bXhq?=
 =?utf-8?B?ZGpKZHhIdEoxMW02djdtY2ZXVVNQRFA4OXZVRExzcS9iVEhjUlh5dzYvaW5h?=
 =?utf-8?B?VGtiU05kdzZFMDdOMkladjZlZFQ1VWEyejNydUU2VHBsWFBXUHdCT09XNCtL?=
 =?utf-8?B?VUZXdlJtNWU0SkxWam1waVk5dHd4bkV0MllIZjBYNUFwV0NrZUM5QXF5MUpB?=
 =?utf-8?B?bklObVBQZGJpTkMyblJGOHVsU0tjNkVmZ0Zwc2dXY2FWL2UxeWVDTzJWTTQ5?=
 =?utf-8?B?dFhjRmlZZFp2b0c5ZmR3aWtyVTVTSksyVVZBQjUxVys4dGVyVU5qcGJiUGJP?=
 =?utf-8?B?NkRuS0xQaVB2S25CZGltT29CK3I5SU9Bak5xRTRIRm41NWFjRi9KMEJpeFF1?=
 =?utf-8?B?WUhMVXpjMGNxakl2TUdHanpteUQwclVYNGRCY3ZhVGJSbzVUWFRmelNqQmhU?=
 =?utf-8?B?RUNuUUxlSjBkRTRmbDF6cW5XVUZ6U3dWbFM4TWwveDU4dy9DNGxuWWZtZ0VX?=
 =?utf-8?B?cTlHN040TEdXa3V6VnBySERWUHRka1FEcERWWUlTQUFQUWZQMTFxc2dKQVJj?=
 =?utf-8?B?OHBDbm1qbENnQzY4NkRNeDI4QXZDa05XSUxNc2FGdG43QVBuMVBjaHhLQmRC?=
 =?utf-8?B?dHhTTjk1WXZMdVVaZjVHNUd2S2ZsZTdlbzhNSElXSmdWK1FxdUFkMFdub3pt?=
 =?utf-8?B?UTA4V01TZ2RmTUtBdy93SC94QjNFelkvbUFmSjNSMGt5TS9lZHhvRXJmTzhP?=
 =?utf-8?B?R1NKTUVGUVBnMUE4ZTJtMytxMGpSOGI1ZzZsMHNqNkpaTlE0K1dENG9zMTVS?=
 =?utf-8?B?ZWRjREFlVUZOd0lLS1lNZHBHRW1xTkNnNUQzb3dON01DZmppL3ZCUjc2SXh6?=
 =?utf-8?B?QlN2U09lWU5yeklvNEs0UzJzcTE4aStNZk1uMWR1SFB4REtXVE9sUE82d3F0?=
 =?utf-8?B?cFBQQnEwSWVMSXdXdFBJR0N5WHRYeXdHOXR1MktUNVVTM1Z5akFIa2p2blhk?=
 =?utf-8?B?cjFMbVpKTkJaVUlxYWdBK2svK1NpS0drbERMWE1QQ1lWQnpkckp3N1p6Z0RI?=
 =?utf-8?B?ZmNMVThUNXpLcFUyNHhpdWdiYjdYNTE1RjdmWlFnckNRNzNRUE5qaCt6NWlC?=
 =?utf-8?B?c3U0WFNyeDBLWTk0MktCYlhnV3p4VFJaMVJQUXI4THp1OFRMd25rSVF2Q3J4?=
 =?utf-8?Q?xKZY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:34:09.2858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eacadc56-2e61-476b-5d35-08de1c89253f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

Hello Fernand,

On 11/5/2025 8:55 PM, Fernand Sieber wrote:
> Early return true if the core cookie matches. This avoids the SMT mask
> loop to check for an idle core, which might be more expensive on wide
> platforms.
> 
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> ---
>  kernel/sched/sched.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index adfb6e3409d7..381cd561e99b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1432,6 +1432,9 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
>  	if (!sched_core_enabled(rq))
>  		return true;
>  
> +	if (rq->core->core_cookie == p->core_cookie)
> +		return true;

nit. We can use sched_cpu_cookie_match(rq, p) to check for the
above two conditions. but even this is good.

Apart from that, I think this optimization makes sense.

> +
>  	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
>  		if (!available_idle_cpu(cpu)) {
>  			idle_core = false;
> @@ -1443,7 +1446,7 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
>  	 * A CPU in an idle core is always the best choice for tasks with
>  	 * cookies.
>  	 */
> -	return idle_core || rq->core->core_cookie == p->core_cookie;
> +	return idle_core;

Peter, do we care about checking the core_cookie again before
returning just in case the task cookie was selected between the
check above an here?

If not, then this looks good to me. Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

>  }
>  
>  static inline bool sched_group_cookie_match(struct rq *rq,

-- 
Thanks and Regards,
Prateek


