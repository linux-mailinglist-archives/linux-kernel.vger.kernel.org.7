Return-Path: <linux-kernel+bounces-872949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDD2C12B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EB81896007
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8261B245021;
	Tue, 28 Oct 2025 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d+l4HJ8N"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13111FBF6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619599; cv=fail; b=XhQni06YO8+sj82SsWDit2uI77RGeEX4B7vUYoH5Zo1UAtPtoXMCnuxghUDAtl5y47T7OCgLBuj3c7dSyUalqZj51gIlV0h+xY0bvUizk+MHYKcrrraZAtIGXqIN2A5Dz99QgkmKVlJyw57cI6SjVGz4EMlHKqWLHqdCtw+9Oh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619599; c=relaxed/simple;
	bh=/VID3Fd5mu0ugxVIOJE/kSTU4Yh9yVPRY9YnsWNn81Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RBxuZCM+fFlSo/+6o9uixLKgddpszVjzvBIZSU/+csB84uElLacQlQwf0QEitMwumeCjyG25OpnbKtLbYGks2EPCkmkw2TMMh/YImPZVSiaoofW4GTkDyPEkCfA+rYSAzux8146ToFSiwGQi4sWM3YAUASxsE3zPXyxnqmT2JVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d+l4HJ8N; arc=fail smtp.client-ip=52.101.52.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8NBZ6QMzEeaVSpGNqI9mrFhtpH6TdNELhFqlWwmIjtxf1of/fIVnDlcv+4TaaHrvp3vP1ILqx7rC5QQGwZU70eRQPtJyUdkGQK+3vKej/2AtEeFDjGAes8PTBUmpGP/Vg9XBBBzdrKADFdKF6B05jPwEhRU+2jXmhxxEiC8PR5dw87A5g7gHhEd5V3Z/XItmmHC45NL1AfL6gOJ5lDTFk1h/mahXKt7w9mzvR20/a/WKtftEmZaglTB8RR7CPkrERWY9jBfwZzT/DmDbqLrMq/BLhxkPzHSteILv/Ow7NrL7m7+9UWyDz4aZeyx1vFZiQp4oPkcY1y7ULPx5ENJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/8yA3HxgcWNFoppK0jMrK2/qQt6uobJ0I8m4KmHgK8=;
 b=Q+29tQGRDavaRzft2lxiwBy5eg8xLLkwrH6Zok1C9EfWQK7soqw52GlsyFRZsN4icWtICAnG33hd9MbCs6CfBtQ7GsbZPgZJvMoSQZm9EbCZiqQr718aLsIY/op+6wcO+97QISV2qcwlwDRaYd/aZ4TU9IRrxLEhu+FT/iwmyHqS6IlOXDhBdSHUEb0i2+IW87cQ3KgQK+fue9DMQhk9M+rn1mJ+0iPW5zsW/802MWAF9Ty3SHlujrYEavO36zzOWJDtCIuwoLXr6SXAQ8zFbgto4jdXtkPZYYZSVQv2xRD/IpZLj3vOd9F9mtvHSe84LGWZntkiYYLXVz+D2BXXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/8yA3HxgcWNFoppK0jMrK2/qQt6uobJ0I8m4KmHgK8=;
 b=d+l4HJ8NP7L8OAsZFpCnQQofs2behXHCW20BlcVqUFre6YHs9mjaKn7rQS+heo3lGcKJP56ESNDeq2NKTKQrPN9r81Ar+bt4OLGHKhWrhQRscfJxxuDcWD1JiIa4XAhhi2XHfMbtwlI15X/Jv/zbtg+iDkwNXWTgdQkAn6OVwL4=
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by CH1PPFA0A5C3BCA.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 02:46:31 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e9) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 02:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 02:46:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 27 Oct
 2025 19:46:30 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Oct
 2025 21:46:30 -0500
Received: from [10.136.37.11] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Oct 2025 19:46:23 -0700
Message-ID: <0a6fce4b-d96f-492e-ad7c-d1fde723cc33@amd.com>
Date: Tue, 28 Oct 2025 08:16:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
To: "Chen, Yu C" <yu.c.chen@intel.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu
 Chen <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, "Vern Hao"
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Tim Chen
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Gautham
 R . Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
 <7ff17661-05fe-4137-b7e1-c799fe318c9f@amd.com>
 <ebc82974-7fe5-4e9a-8dae-7964cfdff471@intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ebc82974-7fe5-4e9a-8dae-7964cfdff471@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CH1PPFA0A5C3BCA:EE_
X-MS-Office365-Filtering-Correlation-Id: 887936bb-a501-4d96-8e94-08de15cc3344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|32650700017|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEF1SXRIeXduN1pEdmZhVTVSWjhUSkRYZWh4bXZpc0pDOE45bWZQT3BkVHFI?=
 =?utf-8?B?c2xBTDFWS3VFQk1aOVBoU29DNUJVaEZYOVVZWkxCMTVuTDNGNFE4cmFXNFl0?=
 =?utf-8?B?ZjlGY2lUb3l2VUo0bUJhNy9pUVJUcm84T0JkWCtGSDM0akxkTktNN1lwN2E3?=
 =?utf-8?B?TGx1NkdlV004ZnpRRUlqQ01iS011MkQ3M1NFaHJSbjdBTDZwaVFHaGNkOTFN?=
 =?utf-8?B?RnlLd1FLNU8xWk45ckVTMldOWGFUSWlMZ0N4cHZmdUR2bGlQZHJUZXF4LzVE?=
 =?utf-8?B?QkJVc1E0aDExbXd5eUgyQ25NajlhL2FNc2FIcUtNYkxjcGJDRHJ5VGhpNDRY?=
 =?utf-8?B?REVBNjlUYWpYaWI0b3JBOVZHdkVEeVduU3ZXNTM5ZDJ5NWZrTWRzRWRDRDVm?=
 =?utf-8?B?MktUUktYRVhHZmIrMVFkUFpEOFA3dVZtbEw1RUZZV1pZVVFlMXJtOGk1Zndt?=
 =?utf-8?B?ZCtwY0x6ZjNWdUZFR21EV25QMUhWbXhmTytoZnVBeGRxSGZsT2dGQzU4dEVK?=
 =?utf-8?B?TzE2dUYxcjUzUkMvVUxXc0JCZzA3VUlUZTh5OUlrMmFMaFQyRkRnYi9pRm9F?=
 =?utf-8?B?dG91K3EzY0phZG03YVJNMGc5SzR0NU5Hc1k3R2QxUXhNZ1BPeW4zdEFOMEVo?=
 =?utf-8?B?TWkwTXZueXpMZy94OGxwOWJPS0JzTTZFV2phQzlld1JkSlpYZVNaNmRacDNS?=
 =?utf-8?B?Q0VTNnVMdC8xQ1V4dlZZQUp6anpqeGZ3azN4eWZZamdoQjM4V1dtWkJhZDZ3?=
 =?utf-8?B?aG9Eb1loSHY3NXpVL1BtL1dhMzIvV0dZYytUNngwYmpBaFJiM3pQOHFFUkxw?=
 =?utf-8?B?OGU2enUvMjFnS21PaEROcXVkYmltN3I2dHN4dEU0M3lDR0tnQWo0cEFCbUNF?=
 =?utf-8?B?ajlJZ2ZLR0M1TGZ5VlJJRCtqeEwwb3pJSHBSQ1A4L2lwM0xiQmFyY1pjeFc2?=
 =?utf-8?B?MXFLV1Q0ZDEyamRnOGJXVit3VVIvWkNhOGcyOWNQNG1DV1ZsV2JjNDRZUlk5?=
 =?utf-8?B?NGprUHM3ZS8yeXYrK3FURXNzazdNRTBkSEhpUS9ReUVQZXNLNGVXMTQwRXpq?=
 =?utf-8?B?K3k3aTJIMDhQVzl2MEU2a1E2UzZNemNNRkFNcXFRNGM0bkNFdWFDMzN3Wi9m?=
 =?utf-8?B?aklrWjg2c1FSWkpwSWFzbTNoRVYvWWVPaU5FVnFFM3FuNFRjYXo5a3VvbDRa?=
 =?utf-8?B?OTBVQW0yUDlBeVovdE1rSW1QTGdNdytzS2pta1QwSldrdHRTVVNXbjZRanNu?=
 =?utf-8?B?c0NjSlZMMndZOWxsaUh5NzJXSm02N1ZrcmdYcTV3eUxpUTBGTmpuaDZvN1FT?=
 =?utf-8?B?ZmhYVmtoVXZQOE9teEt1R3o3Y2FyTmNSRGlmYlh5V1I5d1Y0YlhPelhjTE9Z?=
 =?utf-8?B?citWNCt4ZnR6Q256TTNOUmxjKzJHTTdIRXQwQzZtbk1kWGdobzVjZXFMU0Fv?=
 =?utf-8?B?YTUwVVJsYzFsMERrRFdLc29CSDNOa2Jka3F3T2VPREZvTE9FbXpjSExxVS9M?=
 =?utf-8?B?Ty9NZ1crOVdoVlVNUGpyZTZhWkRBQlFRWlNiVUdUd0d3NTRuKzZJaXhNQ1Ez?=
 =?utf-8?B?cnM2R1FhWmNkaFh4d3pXdEY1UHNFM1FhUWs3a3hyUGZycjRSYnpiUXZRVmJl?=
 =?utf-8?B?UlEzbXp4SHM5ZHVMQTdHM3Z3K1BQRzNVcHNQYTZSYjNGSnVFdE1IVW1RMkZT?=
 =?utf-8?B?NEZzcDRpVlllWlJIQW9TeWdiK2lQb2JDUWJJSUZ2MXhjYlJDWFJvU1ZRRlFM?=
 =?utf-8?B?RldoZlhwRVljTGs2VTVmK3NKcHhxZDJZMnhpdVQ1MjBPamZ1ZW5lcnpPTWtI?=
 =?utf-8?B?WksvU2NPb0N0WVViV1VJRWkzRVRaZTZJMjBJTkRTdG5SMUxGSjllZ1EzRlE2?=
 =?utf-8?B?NUsrSTk2NDVWZlBVVERQRjMxZVRtSnBmbHdJZFBUTU5RNHhPQjVyYmc3eWlJ?=
 =?utf-8?B?UGpCM2xNS0tVS1craUNWUy8yMEFTbEl3aFdnNkViakpBbExkWlI0ajU2eU14?=
 =?utf-8?B?dG1NUjc0bEgvdDJXRlRFdDJJYVJCVXRHYjFaKzJnV0l2blFLWWtzN2k5NURQ?=
 =?utf-8?B?SnNLN0d3cWVucUQ3cFovSlIwYWcyMjMrWVVldz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(32650700017)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:46:30.9493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887936bb-a501-4d96-8e94-08de15cc3344
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFA0A5C3BCA

Hello Chenyu,

On 10/27/2025 6:26 PM, Chen, Yu C wrote:
> build_sched_domains() might get invoked to rebuild the corresponding sched
> domains during CPU hotplug via cpuset subsystem. So if the CPU gets online
> after bootup, we still have the chance to detect multiple LLCs I suppose?

Ah yes! Thank you for confirming.

-- 
Thanks and Regards,
Prateek


