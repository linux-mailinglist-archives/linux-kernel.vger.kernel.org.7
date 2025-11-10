Return-Path: <linux-kernel+bounces-893125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1CC46931
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9CAF4EABCE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B66730C635;
	Mon, 10 Nov 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WKQEILQX"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4A1E492D;
	Mon, 10 Nov 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777449; cv=fail; b=uWjnaBxcI3K/BX7JNLLii63P3NNKM37Ir3QjjPG5MTNh1fJD5g4gfh8A52EsCEqKyU7s9xDljmFugllisjTt+k71HeBIGrlfPghAMnBWzFintTztB1Q64tQzu3EcPXTCz16XYLavWHk8PfKM1KrMkg1DB8zZZaF5TfdyE1HdkPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777449; c=relaxed/simple;
	bh=qD5MDswvq7X/2dmmTQon4dInJPWoFd1+ImxrKj4Y4vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a/J+aU4xC1rIAL2crNjmzfyT4vZmmzsYRSO2TNGQV7Bwyw7YXLZ4PATYCLdxoHC3oiiRipnJIvnWuKHRRb8v9E2zX93xx7quh3yIa51jnxo0ZgmM0+YabGO+OMQCzICYWWbW3mmXawv+pThcmKDJjSI6Uc4Z/aHlU9Al3VvjqEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WKQEILQX; arc=fail smtp.client-ip=40.93.194.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHY3+daKmYoDu+vEqNu5kUILH6Noc6YoeDI4yGpmbV10GuFkJRlclPDqMeFVwxAllupSgPLKC5LwinCLDzXu6KCTSaXvPfGj4kVAfZhqLkljQ0JBJpvnbrq4/5NRzJsKHY9A5BV31O1lwfmmEoK3TuCgAaO2AGDL9MooCFzKB9cQaKBaYvnZVevVBiKrzN3RvT/lvjOgWWwHvWqBHuOnuT/AsnTOJH/94DUMSXvpEIwUCJt/eKIzq4ei6nsRkUGwUzYZybYziZQ2z/spmZbw1x7c+GwVB+c0xD4jNC9tID7ipX7yT2cz+CWbCIVKGY8XOuHqHtgxMwIuqAs1BwUqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3+LhULDCFvqyUWh++pNK3HaGC8GxDeRN2mbwYgSIng=;
 b=GDe3gxp05nLdX5VhZJw6+nJlBBrKpnMUtwb+ORKFTDNfplmU636a9tGnv2dhZ83yXAwrH755w3ENckoY20SRp045u7b8CzOIulHjxaZo3vJV5YwOD6hlgzD0wL+U3geLnkjdAbd/J09dvaZ3pp9zEU+LBiMRl2FgyLS1o7L9JKh0yf0i0a9IBon3sx/VG/wAEb8e7CZbBr7YyZmu9KjLtkDR4mOM98YX4LPiTmbU5HQCH8zW2Gqw7jWwbIHSc+LPa8/xmH8s8QobDWPdWsfeaNDeiuM7nge2+BWJ3a9/Q7MSIEGNP85WJzfwnI0oNee7+cYt/Jk0aHwDb+AmN5oJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3+LhULDCFvqyUWh++pNK3HaGC8GxDeRN2mbwYgSIng=;
 b=WKQEILQXE336AN8ZeI84gWGdYIDVN5ykbYJVo2k3MzIN7TAsH/uu/LSNKzR8V51v4zqDiAPtlxyFt3OfQMtX7H/xoimkv7mnACQjzkipBY7hgWLDOc9nOZG2nfKo3UW4+7PjMi7+0LQvgqo+cHFJ0R51vybMoXx2Y1u/WQXQvqM=
Received: from BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::6)
 by IA1PR10MB6735.namprd10.prod.outlook.com (2603:10b6:208:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:24:02 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::2a) by BL1P223CA0031.outlook.office365.com
 (2603:10b6:208:5b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 12:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 12:24:01 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 06:23:57 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 06:23:56 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 06:23:56 -0600
Received: from [172.24.233.149] (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AACNogT3396535;
	Mon, 10 Nov 2025 06:23:51 -0600
Message-ID: <e5ea0f98-b78c-4714-8713-f98521720a4b@ti.com>
Date: Mon, 10 Nov 2025 17:53:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/16] media: cadence: csi2rx: add multistream support
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, <jai.luthra@linux.dev>,
	<laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>
CC: <y-abhilashchandra@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
	<vigneshr@ti.com>, <mchehab@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <p.zabel@pengutronix.de>, <conor+dt@kernel.org>,
	<sakari.ailus@linux.intel.com>, <hverkuil-cisco@xs4all.nl>,
	<jai.luthra@ideasonboard.com>, <changhuang.liang@starfivetech.com>,
	<jack.zhu@starfivetech.com>, <sjoerd@collabora.com>,
	<hverkuil+cisco@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20250911102832.1583440-1-r-donadkar@ti.com>
 <20250911102832.1583440-11-r-donadkar@ti.com>
 <364c3b35-81a0-4e93-ad3b-a0fff3a29365@ideasonboard.com>
Content-Language: en-US
From: Rishikesh Donadkar <r-donadkar@ti.com>
In-Reply-To: <364c3b35-81a0-4e93-ad3b-a0fff3a29365@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|IA1PR10MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfe5fb9-9840-4435-5282-08de205407f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkpQaWZKSEdvb0hnRUNndVNCQURxZ2E4cUxCbkczV2xyLzc5YUswL211Y0J3?=
 =?utf-8?B?dWpsVTdadTlLNUJhdldNa2w0blNKSnBYbGNOZnR1MEVzSkpiS1dmV2RFK2hn?=
 =?utf-8?B?RW4xUkE4em5DVVZXdzM2emJ6WXR5bTFuQW1mdHBZWU80ZkVnUDdCZDZYeDJP?=
 =?utf-8?B?SjFQbnJ1Yi9JdXZmTHFPaHh3VTRFLzBabElWV1ZWWGVZZ2RTaTdvWVV2dEg1?=
 =?utf-8?B?VlFvWWVPSFIvV0FIV21nUTZINEE3djBiTEIySlU1MW5LSUQ4Z2JSeldkWHRt?=
 =?utf-8?B?cE9aNlBhdloyc3plN1ZpNTBPenBlbW9TTDVDSDBNcUZUV0dHRngySnp5Nzlu?=
 =?utf-8?B?MFc2c1JaYzhMajdZWU1oa2oxRDA5dGFOK1QvRTV1K3p3VkpISWlBc25VZUhG?=
 =?utf-8?B?MU5kbnRBY1d4cVVTUVNSbUh2TUtSTDBIaUVCUGo4SW9jY1o0djlVK2FTY3pH?=
 =?utf-8?B?M0FmOGRXa2lvUHlsOHdtdkozd2QyMFVBRTUzaFpZWmlKL2QxTFRvRVNEWFA5?=
 =?utf-8?B?VlpoS1MvdlBVNWVJMlZYaWltaXZxZFZ2cEFqNjF2UzNLbVVWcFJvSEg3WUtC?=
 =?utf-8?B?MmUwQ2RMTEpUeFNLSDExRzdsNUpmQ0UwOVU2SWx5MHZrdThpL3c0bCtxNjFR?=
 =?utf-8?B?Y3lNZCtlM0FGU1VnVlpkTW5Rd1V3eDhWVUZ1aUF2MllnV1R0eUhlSnhRaWZp?=
 =?utf-8?B?UFltQmpHYVBndFREcVN0bmV0TDZicWxEeU40NjUrekh3WER1TmZsRVFyOG5M?=
 =?utf-8?B?Nk41UzZncmJONS81VXA2MU9PTURxZmowVlZGTmVtTHZ4b3dwN2hMSWwyUE9Q?=
 =?utf-8?B?OVhVemxrdlVXRVBUVXZib21xc2NHWHpCbndDS2ZZd0tyT29pZTlYdGtpVkhO?=
 =?utf-8?B?cU5PeVk5a0tGWjZkUGZpYlRzWUxCSWZYd21lMDVuck5PRStZTkhMT0VjQTBt?=
 =?utf-8?B?NGdoRVB1ZGVtZUxQWGxYdlpYUUFpbVRCbUZKdkYwZWJHY3NDV1laT1lHcE93?=
 =?utf-8?B?TEI4UjFtb2U5eWdzWFRQQzRhZEJvcDlCN1BvaUFHYVcxb1FuOCtWeXIyaEE0?=
 =?utf-8?B?dUJSUGg0MzVrMnlWaVRpSWdITzQ4QzZjSTZDWDdBTE5jckNjQVQvWVNEWjF5?=
 =?utf-8?B?dFVRSjV5SXhTL0FJN0ZUdlB2M3FkL1hCNGpiU2E0SlJsMGJLU2Eybi9rVEd2?=
 =?utf-8?B?dU1pbVI3TXpvOFFpbGpJeE9zaHp3ZGdLUENBOHliaXBraWI2TXdLVzI0NDZR?=
 =?utf-8?B?eEtLOFV0TXFjNWg4Z0ttQ2NXV2ZwZ21wMGswVkgxc1NCTTduYXpNMHc1Yis5?=
 =?utf-8?B?ZjV1TEh1eEF2M1AyTHh6aHJ1Y1hkSzVQeFdXbkFaKzY5cVhydWV0dGdhbitB?=
 =?utf-8?B?N1BhZFdobjROL3h4K0FNU29zeHQ1VElpQmk4NDZZV09LalZQQjdNY1hFNEJ4?=
 =?utf-8?B?cFZSSWRDZDZUSnhEV1phanAzT0VWM1lBYVlyR1hMemlmdkpiKzFpSSttdDJh?=
 =?utf-8?B?NHlLYnJHL3pzMUxIaFZqQUxLRllTR2dXZmJXV3FrenhUOWFuTU9wcWlKNVdC?=
 =?utf-8?B?NEI1cDJxcGc3TTBYMlc5L3lQOThCWHNEWEFaanZBWVZYcktVN0JGSHV3b0Yr?=
 =?utf-8?B?V2ZRdGZ5UThsaitUVjlJUDFhMEtEWlZqQ1FiWlkwZWhCZUtmTm1jcEtYN2pF?=
 =?utf-8?B?VWpET2k2ZXRXWnRSR2dIMjBWZnZwaWYrNWpUSzVWT0Qwb2RkQ3R1NnJRS1Jn?=
 =?utf-8?B?Y1ErT21Ka2dqSldxaU5NeXp0ZnZobzZvdHhPR2FRUVBXVENST1Z6UEd5SGk4?=
 =?utf-8?B?SG5PanpUWDJCN2xYdHVSd3krWnc0T2tVcXJiU1A2bzJXeXBaRDJUY1VLK0J4?=
 =?utf-8?B?M2NWZUhnYlRWWE9kUWYxODVmaGVnbTV2VHFTcjJQSDVmc25sR3YwTmxYZ0ZZ?=
 =?utf-8?B?M3REcW95WXpFRHpmc2FOcldwUTQ5Ly84ZlFoeURJaWxoK0lMazA1Vm5QRFB5?=
 =?utf-8?B?bVg5M0JpV2Z4Tk44ZjhYaTlkUkpMb0ZEUVVORjRVY0V1SkJySnorTFRreFo1?=
 =?utf-8?B?NDFyZTdCNTZyMUwvTnQ5YUxwM1I2Z3Y2SlhzUHhpak9UYXhrWWpvM3JNK0JO?=
 =?utf-8?Q?+5bA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:24:01.4893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfe5fb9-9840-4435-5282-08de205407f6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6735


On 25/09/25 18:14, Tomi Valkeinen wrote:
> Hi,


Hi Tomi,

Thank you for the review.


>
> On 11/09/2025 13:28, Rishikesh Donadkar wrote:
>> From: Jai Luthra <j-luthra@ti.com>
>>
>> Cadence CSI-2 bridge IP supports capturing multiple virtual "streams"
>> of data over the same physical interface using MIPI Virtual Channels.
>>
>> While the hardware IP supports usecases where streams coming in the sink
>> pad can be broadcasted to multiple source pads, the driver will need
>> significant re-architecture to make that possible. The two users of this
>> IP in mainline linux are TI Shim and StarFive JH7110 CAMSS, and both
>> have only integrated the first source pad i.e stream0 of this IP. So for
>> now keep it simple and only allow 1-to-1 mapping of streams from sink to
>> source, without any broadcasting.
>>
>> The enable_streams() API in v4l2 supports passing a bitmask to enable
>> each pad/stream combination individually on any media subdev. Use this
>> API instead of  s_stream() API.
>>
>> Implement the enable_stream and disable_stream hooks in place of the
>> stream-unaware s_stream hook.
>>
>> Implement a fallback s_stream hook that internally calls enable_stream
>> on each source pad, for consumer drivers that don't use multi-stream
>> APIs to still work. The helper function v4l2_subdev_s_stream_helper()
>> form the v4l2 framework is not used here as it is meant only for the
>> subedvs that have a single source pad and this hardware IP supports
>> having multiple source pads.
> <snip>
>
>> +static int csi2rx_enable_streams(struct v4l2_subdev *subdev,
>> +				 struct v4l2_subdev_state *state, u32 pad,
>> +				 u64 streams_mask)
>> +{
>> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
>> +	u64 sink_streams;
>> +	int ret;
>> +
>> +	sink_streams = v4l2_subdev_state_xlate_streams(state, pad,
>> +						       CSI2RX_PAD_SINK,
>> +						       &streams_mask);
>> +
>> +	guard(mutex)(&csi2rx->lock);
> This looks a bit odd too. With enable/disable_streams, the state is
> already locked. What is the mutex protecting?

We call the csi2rx_start() function in this function, which is 
responsible for configuring and starting the streams, and operates on 
shared resources like the HW IP registers. This function is supposed to 
be called only once (done on the first enable_stream() call), for the 
rest enable/disable_stream() calls, we just increment/decrement a common 
variable(csi2rx->count).


>
> j721e-csi2rx also has mutexes, and it's very unclear what they protect.
> This should be described in the code.
>
> I think in csi2rx the whole mutex can be just dropped.


Sure, If the core itself serializes the enable/disable_streams() calls 
than this mutex can be dropped. I will make this change in the patch 
adding .enable/disable_stream().


Regards,

Rishikesh


>
> j721e-csi2rx is a bit more complex, but there also I would consider if
> and when the state lock protects the relevant parts already, and when
> another lock is needed, what is the sequence to lock/unlock (e.g. always
> csi->mutex first, then csi->subdev state lock), and make sure the code
> follows that.
>
>   Tomi
>

