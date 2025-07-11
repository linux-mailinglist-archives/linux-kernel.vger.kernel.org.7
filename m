Return-Path: <linux-kernel+bounces-726909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93277B012AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612717B99D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCF91C5F2C;
	Fri, 11 Jul 2025 05:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JoTjFU3O"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742E1B0F19
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211636; cv=fail; b=uAIXTKxtDVJPxb1l4FT6ICwu+DhdY17V16XSA9Eh9Eckn3NYAhPuJ0lyrOCeU0l/zJAa/JHYkMkB8vNZmNJrcf8oFktBoOeAkMGcvJctTJiSTHE37EiLRylrj1MVQ9XYu9pO5r4Iy/iqTHFsFCkJ9FBGYhTAxVXxGiTamb3BPMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211636; c=relaxed/simple;
	bh=x8dJOCuli3k779tyO87+qv6NHkxefUoTKxOgJ/yn0KQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=FUEphZTnbyTPEmH53lFdxr7Vx1LtUeBZHuNZYxQuzYkww6zJwF5bUJGM3yFEdjYCA+jiC12s4k8Lw+VEPdtr7uoLsQzFtCNIB1dudQ5GY/OnSbeix29Gj6l/U0rNxuTm6SL5NRO2zniEoHvazZiOrPq8tPSNtoWdbFaFHlncsjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JoTjFU3O; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jF8GRNdfGFiS144aWVlQtWysEid1ugrZOEib/DkK058e7cnJUY/nXwAxnJFaui++HGS/6N53sJFhOpYLOnmpkcofLaHsHECgxZ++cdTu/VvpSd9MSJY4msNUhJx4lKXaj7isauobPyJMWePtScBfkiZP5z6DRbCYPxwCRjNABpm5oSD2Onk9IlSYqz+lUl6DWaO1QK4xy8PBxWRDdKW55Hqxv2gX/4st4hQymqnSInG9i449ucfxNbRvgdYeWBK44nI2fiwLmim5tV/W6RPgerwiKdrxhl2EGOal46RizPUcDFSAx3h7D96549zoHivervaoFn1P++CrvKG3YFNblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7wMKOfGFyC4U+3kqZJoyXEe6TgSbbC2REmLnhcmBN4=;
 b=B1x9JLL653OriEThJ+qJjEVx+vmGnIc/+tee4vbsExwUYAjzVMaUCJO3hxDnO/r9Mc6pqyv4nLiEMbNs6k6IHip0CDb5MCS5qpssdp1/BdMlf3cWxpgzjWlR0ULcH9rRB2kAhLDpBaOMAepd5G9IimrmMsXPs64PPdvT9mAT1BjDAhRxkQ18WMFAhHKyOuyPnzbabE9idgrp7f3KEOOxWTmXkww35Au+5fe6WaLR+IMI7UpU/jZ4EJLVa2fbO2g8I+1NW+60n2wpc7A0NoPX77voSFdPRzC44dhHzogGDlAfziAFw13Yn3uAjW9FjFl8G5W4ih82U6hTVOq6FBIlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7wMKOfGFyC4U+3kqZJoyXEe6TgSbbC2REmLnhcmBN4=;
 b=JoTjFU3OUL7XTRYyP6hkHAIgEYXCbKpKMuW+4uBJ5aPIaK2jR9MI0jbG9G3jOA55H3NOai9H+/8Jkzeyq5nYj9XcD1wL3MJ0CHxTCNpeA89XJ1qzGkMuaeZvChyoeWhiffQ9nq3C134yi2DeUkeZeK7X93LdDcHNCGii6341QIA=
Received: from SA1P222CA0149.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::26)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 05:27:11 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::21) by SA1P222CA0149.outlook.office365.com
 (2603:10b6:806:3c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.24 via Frontend Transport; Fri,
 11 Jul 2025 05:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 05:27:10 +0000
Received: from [10.85.33.20] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 00:27:03 -0500
Message-ID: <e8691827-ae60-4ebe-80f0-9536079c5789@amd.com>
Date: Fri, 11 Jul 2025 10:57:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: will-it-scale.per_process_ops -15% regression on v6.16-rc1
From: "D, Suneeth" <Suneeth.D@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <639f17bf-8d4c-47a3-aebc-8d71597aba3c@amd.com>
Content-Language: en-US
In-Reply-To: <639f17bf-8d4c-47a3-aebc-8d71597aba3c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: a03d8b89-befb-4bfc-5a35-08ddc03b960e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHcvWXI1Zzc1M2FRQ2lweTgzQ3RBTHBjU3BiRFJhSkQrOEkwWXBEdDl4VWZ0?=
 =?utf-8?B?MTNLbmhlVTZZc09JdjBsbFY3Z1hiSThoTlhRbTFzRkY3MFVFNUE1S1FtWTIy?=
 =?utf-8?B?QTBGZUpsL2E4c2wzWmxxa1QzSW1mOXd4cVZERHFpLzNSUHJZd25iMTYrRmxU?=
 =?utf-8?B?V0tLcm5ZQ211OUx6Y2lMTjBteURDZFB3Uzd3ZU0yaThCK1hvTXF2TU9uQndN?=
 =?utf-8?B?Ukl1d24rRWNFcFNpcXpNZWJOdVZxYnNySjB2bEVEdlhGRFZZSCt2TzRsbGdh?=
 =?utf-8?B?bHlWbTZicDNlcG5OWFFlQ1ZPejEvY0l3aW05ekFvbGJoQ0lTUXlYczAwK0ls?=
 =?utf-8?B?T1VNNHVuZGpBNm1URUFmWDZGQWxsMVc3RkNpT0h6eWZGbVhwZFV3ZUIvVjV2?=
 =?utf-8?B?Y3lJK1lZa3NMNVBNK25TZTJDQW1kZFpSOHB6cWVPcjVtTmlpd3NDSFFaWFQx?=
 =?utf-8?B?enVVT0FxU0JIb2JWQ0hHTmN0Tzg2QzBNVGszcmpYTTBSMzdjNXZtMzNsTE8v?=
 =?utf-8?B?L2hOZkRxY1cxRjRXWDM1Z0RvQlpxNFZKWndqbHF4akZ6TWpQUHppOFM1RXdt?=
 =?utf-8?B?YklKMG9tUy92bHhyWHY5MTFZL3ppZWVsQ1RuZ3YyYis4SkhDMnE1aFgwek04?=
 =?utf-8?B?cjRXZEFjV0VQS2hrTzVJWTFuVzR3QUxqb1RCQURSSDdNMkY1SEcxajFycnFK?=
 =?utf-8?B?S0loeVB2TkZqbThjdGJuZ1pjQlZaakE2WStuRFZlTkszOVZ3N2FLK21YNmZq?=
 =?utf-8?B?Vy82UExQWWxpeVBDTE9pSnZyOXNKdW52dEg3cHRIRjVkWExuWnA4NjErdWpu?=
 =?utf-8?B?aFNZMzMwbUpxbzlGbHhQZ1F5cWtGN2p1Sy8vYUcwSXVxTy9yWnNHZGtoQ0xX?=
 =?utf-8?B?Z2ErU2JzeGROWjg1OUIrNmhtWWJGYkRPdko2ZDVvYmRPdWNrUzZ6SzZObVVJ?=
 =?utf-8?B?YU9wbnBJN0l5MjlHRCtGdWVuNGd2dE5lWnlqN014Sk81U2dWWS9uQW9mUG9Q?=
 =?utf-8?B?VXRSL2tqMTkweHd3SFV6VElFWlpsUTA2djVBZk1YL2RPSjNUUUkxNFU0aWpF?=
 =?utf-8?B?RURGWlZ6bi9mdmw2eVo4TjNLS2dMNGFReEpVRUIyL3RKNjJUbDc4ZHRhTjV2?=
 =?utf-8?B?d2swN1dkZklVUERVWHVQTGdRdDdwUldtb2czRUtSVmsxY3VHRnJwWkw1b1dZ?=
 =?utf-8?B?bW9tZU1nUlBVd1pqV3JSWmxQelc4T3hOM1RKUGhMTnVMQTRRa29Zeno4c0Zh?=
 =?utf-8?B?V3JJTWp0eTRvZXpzdGVaMmcybHdKcWI4ZUZycmNNWllXcWEzSlpJcWRCZGN6?=
 =?utf-8?B?cDJ2a0MrQzE3eERiM3plaG1CTG1MeXF6VGU2cGxadE55Z2s2WEQ1MXRGVmpo?=
 =?utf-8?B?NmtZZjFYczFBU2lEMEpkS2sxQUpxSFpYUVVubThtWlVCbmRuRU82ZGI1YWMy?=
 =?utf-8?B?b0VlZE42aE1rREhZS2JnakNFVUI0T251aFJGOWRmS3dVa1IrYTFDcXhMT0l3?=
 =?utf-8?B?bmpYUVJuTFFLZXR1dStVcW1ORHJGb1BBcFFXa0pwVnl3SmhIekhuQTlhVDE3?=
 =?utf-8?B?M21kZUErTk1XQXFmdDVZNjJ3MXM0U0xxTVlJRXNqeXJWbUpjdjlyWldRT0hv?=
 =?utf-8?B?Q1lxSDZsbkQ5aWQzM01uaFFkaWk0MFJsdXhKTmtvdS9xdndCV0pmSVNWdkVq?=
 =?utf-8?B?Y0FncmRSK1N0SHl3STNhNkdqbGhDNzB6c2xDcFI5RnFjbi9iQWk3WXhNblk4?=
 =?utf-8?B?dWh0UkFYWVpDWkZuMkR2aWZlVDdXUUR0SGN3cFlPdVFsbEtzMk1iQ2tqQm04?=
 =?utf-8?B?V2tLeFZjRDBFRmR2L2xzYXdtakNZd2hlakxPVUhmaS9sUzZxZ1F5ZEZ4Vnlv?=
 =?utf-8?B?QllEdXdHUklTbS9jS1MrdE1QTXp4WFQrUGRVSWg1Q3dsWFJaTnBDN0s5blVT?=
 =?utf-8?B?aVEwZHc1a2lkcnIvYUJuckpGUnRDa1NoYzdkNmpRa2doTFVUcmVpcXNKOWlY?=
 =?utf-8?B?N2dkN3hpeENpbWFEVnJ5ajVrVWIyZnd6ZHJsVXZvUEozVmR4dnh4N0V0T1BY?=
 =?utf-8?B?K3haUkZPRXA3K3ZIOTRwQ3E0WUFwU2RqSnFuQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 05:27:10.8954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03d8b89-befb-4bfc-5a35-08ddc03b960e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

Hello,

On 7/10/2025 5:21 PM, D, Suneeth wrote:
> Greetings,
> 
> We have observed ~(15-16)% regression on the will-it-scale-page_fault3 
> variant when the testcase was run in process mode on the kernel 
> v6.16-rc5. Further investigation showed that the regression was sparked 
> in v6.16-rc1 and has propagated all its way through v6.16-rc5.
> 
> Below are the test parameters and Machine configuration that have been 
> tested with:-
> 
> testcase: will-it-scale
> compiler: gcc-13
> test machine: 256 threads 1 sockets AMD EPYC 9754 128-Core Processor @ 
> 2.2GHz [Bergamo] with 258G memory
> Test params:
> 
>          nr_task: [1 8 128 192 256]
>      mode: process
>      test: page_fault3
>      cpufreq_governor: performance
> 
> stable version (v6.15)    %diff     per_process_ops    kernel_rc_ver
> ----------------------  -----   --------------- -------------
> 492057            -15%    416927        v6.16-rc1
> 492057            -16%    414140        v6.16-rc2
> 492057            -15%    419158        v6.16-rc3
> 492057            -15%    420476        v6.16-rc4
> 492057            -15%    416334        v6.16-rc5
> 
> Also had a run with latest stable
> 
> v6.15    %diff     v6.15.5
> -----   -----   -------
> 492057     1%    494990
> 
> 
> Recreation steps:
> 
> 1) git clone https://github.com/antonblanchard/will-it-scale.git
> 2) git clone https://github.com/intel/lkp-tests.git
> 3) cd will-it-scale && git apply 
> lkp-tests/programs/will-it-scale/pkg/will-it-scale.patch
> 4) make
> 5) python3 ./runtest.py page_fault3 32 process 0 0 1 8 128 192 256
> 
> NOTE: [5] is specific to machine's architecture. starting from 1 is the 
> array of no.of tasks that you'd wish to run the testcase which here is 
> no.cores per CCX, per NUMA node/ per Socket, nr_threads.
> 
> Currently bisection is under progress b/w v6.15 and v6.16-rc1 to spot 
> the culprit commit.
> 

The bisection got me landed onto 
7ac67301e82f02b77a5c8e7377a1f414ef108b84 as the culprit commit. This was 
the same commit that was causing a regression in lmbench3 
micro-benchmark as well earlier for which the detailed discussion can be 
found in [1].

[1] 
https://lore.kernel.org/lkml/f59ef632-0d11-4ae7-bdad-d552fe1f1d78@amd.com/

> Thanks & Regards,
> Suneeth D
> 

