Return-Path: <linux-kernel+bounces-725565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA6BB000D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055B31C832F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257C4248F78;
	Thu, 10 Jul 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z18bjKY7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC9220F4B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148338; cv=fail; b=KFsUfm57coiKB2GLjyH8TeP2FEWjh6oQGYkTt+W0Qi3xDEnHvmUH1XcHgtG1sulOt4SYTDvPPzf9f6cXXYJRkgUi02HGBzOXguZtj9Z6ExXOU7ArlLunn1kj9UdGnY/43/yhRgFFWpRDWg43DXOXa0zkM2PdOhhie8k7wpwY5dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148338; c=relaxed/simple;
	bh=qxq70w0jvXjZPWevSmsjqk+7fnyz9N01Gvu4GxF18hg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rNTgyMHVkQvOq29Qg6KUkOcDpH53J27Gam0LXbWnMm5ksMz9ysLSJBoFX48KsaSaQM9xcgAczA8QebnY5uBvXBYbR8yZCYH42FN4qTsv59b/zlgwoGjYDKkrpR9M+nGKAnX/mugXy2NdbIAXDPEI8NgV5tVCTmfj0BTBHu+dWiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z18bjKY7; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebGn6gMQzP7VD/ZcL0cDbyPs0nAP+sv9/i9/EaWuNpg3ZHh5PYh4yREtJ5VK+Dc456hFgjGs2vuasw+Mxyc7A4YW4yVJ2GoJ3hLGJZfhdqanOc/vo/1s2I5eSeLzt2CAPk2k9fd/dsUz3AKuqkoWA3x1ngcJWCFZaQrasSavcZdwJ2VmZEDWmxsyXIqwDVEtugXwvDFZxpcNuBfWex9XHOUWxUUZQEH42Dok9GvFX/dZ5TLrxziuVPWGfadBC+Cqx7NW7Sfvl7afn9nGf18k6uNTuDO7P6UsGwKSkAKMwePk19Yv19qHzVLvhGenMFJJGhtcdgilbsV5KSsQIs+vFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX5jmr9UleQ5lNKR+oMbW0ejQLXPbIbYF47R1UsotME=;
 b=TgnbMpOboIL8TcCA9cKs+GKxht/ZRby7mSZIwt8lZ7omcMZJS2fNYgUH72AdkN2Va54+CieCx5+7tzKwV6/Da7miJRmiIrl8iR6YjTTOSgGR+eVkXIs9nIQNW6pjSv7/hKHl+4J+ds4qNqCJG/8ZximNC+ZzquJxx8+G+ZEkEF6Gd2ZnEPBmGySSCWW3IL7A3MttQSFbHuwjkXdMGvs33d4/iqvqHw4xrqpJJ+Ex+KZjPyIm6ZtrzOo/LMxr+7AAaBKg4recYLkS5fVu3zyHWlfAhRYUEcuNoE68tnrURMbXrksr9mNu+60Ew6mHy+GS4zLmPnhQmM7N5PkDSKDiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX5jmr9UleQ5lNKR+oMbW0ejQLXPbIbYF47R1UsotME=;
 b=z18bjKY7VaE5+zDy0r7ynLGzKxN4vb3xBxA4RVUp3JLg1GRMPmS5OJ4G9okieZsYiOru0vqZU0MakHfx387x9NjiSUQ4IW0a/11r+ErdVxZy6SbbzVrLIfvjIxgQlX/adc4kqoANWNK7uhq0whAqdrmK+NAZBeNtwJ9iwQ64MPA=
Received: from CH2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:610:4c::29)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 10 Jul
 2025 11:52:13 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::93) by CH2PR10CA0019.outlook.office365.com
 (2603:10b6:610:4c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 11:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 11:52:12 +0000
Received: from [10.85.33.20] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 06:52:07 -0500
Message-ID: <639f17bf-8d4c-47a3-aebc-8d71597aba3c@amd.com>
Date: Thu, 10 Jul 2025 17:21:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From: "D, Suneeth" <Suneeth.D@amd.com>
Subject: will-it-scale.per_process_ops -15% regression on v6.16-rc1
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: f189f92a-3216-4d32-f515-08ddbfa83567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXZ0MkMxd2Z0Z3FVRm82UzFLM3NvMTFJSC9aaVQ4OGFmU1VWTW5aMjF5RDBT?=
 =?utf-8?B?UjU1QjlidDBCaTJ3ZU1UYVdSVWMrbU50dG9zMEQrOVZyb3lQV1E4Zmk5MnJB?=
 =?utf-8?B?SUVNTjh3dHBqUDlkMkMzT3dRSnVCSGFlTU1jTmRqTk9PR2hUb3FUQ0U0NDEr?=
 =?utf-8?B?RERsT0FiNjhTT1RJSk96ZC9jQXFPT3JacEhMSmNFeUE5RmtXN3RUVWRVM3N0?=
 =?utf-8?B?ZDQxMnNWOTl0WmFGNytxWFh6SS8wZjBtajdJQVJCeC82SFJrRHA2N3V5Nk1R?=
 =?utf-8?B?blNrNUhHTzB2NkVWMFQ1TmYzZWpia24xbGJHbUdLQUVEcG9NaGM3b29Cd3Nr?=
 =?utf-8?B?WG9RMTFPY3RPVzlFWFJDNUcrUmt5dVRMcWFUZ0trdHhjS2luMDFhcG1rR1Bm?=
 =?utf-8?B?SE5XOUZESlhGN3g0RnM2T2lpZDdLWlE3a0lwSkMwanA5NW9UeXpyNlJNN3M5?=
 =?utf-8?B?Nng3bWc5RUtOVXhEa1VYcnBKNGh5clF6b3JjeG5oS1V6YW93amZSKzB5a3dx?=
 =?utf-8?B?aWpDVU5SQ0VlM0l5TkF0Y0hmZ3ptSjdsK3VFOEduNmt2ZXovb0VldGRCc0ZH?=
 =?utf-8?B?clNkWis1Ly95cmlzVTM3TGdBUWhIU25NTE1tb0dQT1BoZnV1Ymg0aEVIcXFH?=
 =?utf-8?B?RXF5d0JtcWZPc01WWEl4Tml2cUhMRW1MWHVZc3JQOVl2MlQyUGJqb1o3U1Np?=
 =?utf-8?B?ZVhmQytLQzNUVCtIQlJrenU3YXJLbWNsK0szbUtPSVBZdjZvcjlHeGt6ZFBP?=
 =?utf-8?B?M0MrQkFnR3RDdmtydE1NVlU5WjMvdmJmakRneE9vbDFoYlZyUXJuVGplcmlS?=
 =?utf-8?B?dnErK3NFRGZVK3F0NkJKTnBSSXpLQll4OHJQY0pLWGNuYjhzbk0veFNwVEpk?=
 =?utf-8?B?QTBxa2diVmlCYlR6RWZUM3YrTHFEZytLd0FhVEQzOW9MOU5pRS9hb0NJRmdJ?=
 =?utf-8?B?WlAxSTdKcC9YbFQ4TXRnem5TbUtnbDluZS85ZE1pSWZCUk9hcWtML25WV2xD?=
 =?utf-8?B?cVBXbW5BTCsyM3dqWmt1eUoxSUhydDZNOGpJeE9pMndLbEZOOXFXUmlDQ1NT?=
 =?utf-8?B?OHlVRTdwSnZuaG1XM0kxTEVVVWdqWGpzVHVtU2U2REl0YU9XS0Z2OWwwbjl6?=
 =?utf-8?B?TnA1SE8wUXZ5dytuekdGOXZVcG5NS2U0ZHVmaFVpQjNnN1BIY05VeEtSdXM3?=
 =?utf-8?B?Qm9MVkhLTmtKTE5zY0lkSWFpTlI0M3o4aCtmVll3MnIrU202SzhuU3o0VURn?=
 =?utf-8?B?TjVNMDVZQVl5TG9QMEVNNXJPbCtZTC9SdUs4WmxwSWRyTWRSU01MMGlBL0VY?=
 =?utf-8?B?RVV2OVBhUUdqYlQxSm1YUElHRHp3UkxUWHVxUXBlVzNQdDcvY1FVNzZIVnY3?=
 =?utf-8?B?NDBOUFBnbEpJSGNEV1pFUnhiOXNLV0VYd1lFOHdKaFFOYjE0ckNoUHpELzN4?=
 =?utf-8?B?UVI0em5pQTVHdEIwdzRMd09LQVJ0M2pBYk9KSHdQY0k1aVQraVlrdVB0VmE1?=
 =?utf-8?B?VFI2MFFXMHlteVAxcnYzRUh1RDB4QWdJS0FEcmxObkxEbk1zZE96Q09tT1Zs?=
 =?utf-8?B?bmkwOW04MDVWU2c3THNpM3BjLy9Jb2k0Z3pUS29vNzZDNS91c3NpdXRBQzRP?=
 =?utf-8?B?YXRFZ3ZGbWwzeHFhU3paWDhXelI0UXFhTmVvZGJML0hQUkhVUHltaUZRU3hG?=
 =?utf-8?B?RnJsKzBRRGczeVR2elJOdU9ia0pmRE0wV3pncU9SVU9ISFIrL1FFQThkMFg2?=
 =?utf-8?B?SWJQcDJ1ekVUWjc5T3dBYXZTNUxhcHVJKzF6QkRiMm1tNFM0R01zZm1jK1BC?=
 =?utf-8?B?NUhNVElGSkJoa1oybUM4SG9SQUZQZ20xQ3Zab0h2bC8veTBoTHVTbDY5ODA3?=
 =?utf-8?B?K2IyTWNOWUJkSXJGSStMdlFaRllFNzhWUlpiUkMxVzlSZHRwUFRuZlhwV2lM?=
 =?utf-8?B?K2R2c1hvM2hrWjBGNjZnM2EzNDZlR3J6Tm96d2R1L2JFbmlIamRqNWlNUi9N?=
 =?utf-8?B?NnZYa2lOcDJHdDk5SWJkVUx0SG9yTW1xbzdhT1N4RVpiQkZZem9aczU0T3k4?=
 =?utf-8?B?TVRFV3NqZFZMcHNtc2ovVkJ3Z2hLMUhRSGg3UT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 11:52:12.7359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f189f92a-3216-4d32-f515-08ddbfa83567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

Greetings,

We have observed ~(15-16)% regression on the will-it-scale-page_fault3 
variant when the testcase was run in process mode on the kernel 
v6.16-rc5. Further investigation showed that the regression was sparked 
in v6.16-rc1 and has propagated all its way through v6.16-rc5.

Below are the test parameters and Machine configuration that have been 
tested with:-

testcase: will-it-scale
compiler: gcc-13
test machine: 256 threads 1 sockets AMD EPYC 9754 128-Core Processor @ 
2.2GHz [Bergamo] with 258G memory
Test params:

         nr_task: [1 8 128 192 256]
	mode: process
	test: page_fault3
	cpufreq_governor: performance

stable version (v6.15)	%diff 	per_process_ops	kernel_rc_ver
----------------------  -----   --------------- -------------
492057			-15%	416927		v6.16-rc1
492057			-16%	414140		v6.16-rc2
492057			-15%	419158		v6.16-rc3
492057			-15%	420476		v6.16-rc4
492057			-15%	416334		v6.16-rc5

Also had a run with latest stable

v6.15	%diff 	v6.15.5
-----   -----   -------
492057	 1%	494990


Recreation steps:

1) git clone https://github.com/antonblanchard/will-it-scale.git
2) git clone https://github.com/intel/lkp-tests.git
3) cd will-it-scale && git apply 
lkp-tests/programs/will-it-scale/pkg/will-it-scale.patch
4) make
5) python3 ./runtest.py page_fault3 32 process 0 0 1 8 128 192 256

NOTE: [5] is specific to machine's architecture. starting from 1 is the 
array of no.of tasks that you'd wish to run the testcase which here is 
no.cores per CCX, per NUMA node/ per Socket, nr_threads.

Currently bisection is under progress b/w v6.15 and v6.16-rc1 to spot 
the culprit commit.

Thanks & Regards,
Suneeth D

