Return-Path: <linux-kernel+bounces-895043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBB5C4CC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 462E84F8733
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C699A2F49FC;
	Tue, 11 Nov 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DhTVPyUX"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873DA21C9E5;
	Tue, 11 Nov 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854400; cv=fail; b=dJR8FMJCQgk4JG+MTMIp4/+W0kWz9tqHM0en+PXeIaOmEKZZEtrWFm4IL5T7BHI4Cq/+n6SSgZlS8qT3qpz7TGPjWka4fpBGvp0tTSH0McxXnml1EOTEAKusEZexo3/hI1u6keDYVILbsifm4aLetG20UE6EZ4ZG7tGSneFsvGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854400; c=relaxed/simple;
	bh=ys5SCvJW1ZVbW8ny+rFbVgqxWYeWOdLBa3UD87BCdwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pJtN8+7OWDNbHddqVw9F9dMlHoPbh+fxRFmFlhQ19hpLtnoQ8Z9e8+sjLUR+OXoCHEu5LcSHorKaBZr8c9KO23Y6sYWeBQGm31dvamEZrw+NDjH97Q7RpZrn2UuCBk5VUTjl+4hRfq8a8jcXSIyarM+WYfq4wAYCK5DHIv6EgwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DhTVPyUX; arc=fail smtp.client-ip=40.93.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOTZwkHVAP5OVHExcqaHcMaAG+zCrBz05Zcf2V1p+jg0G5/TWJ/xPzmAPZHVD+Bn3oLQ0hHWMR+trIGjdMASdNQjoQ+CBIPaiQ/p3GzWShUkQQy2t3ttYfKe7FDGehBtwl1lGIoQF+Hb2AMxxBPW7ASDML8ZWoP994ybDDMQ+lb+LtTTpp9F5l2bmjrgUureWyia0M3sFiI8erINFjRsHt3WGjyPFeQRgAohzuvcEP1mfECp/Wj71uSJlNENmyhB96gDKcLD42YdByloRSwc5QFEqrRw55QSidLeihLM84RhR2Ftx3G4v75RwDXbliy+55nDRGJtID0GonjR30Kpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXez4h61wsgwlcPmWXSRgrtHt/eIxpgTlgFDly5oIOI=;
 b=Lt5COOS85iN/lzlEjTGLB4fDBL/FsTTtPlzLUnB5adNoLsedoJaqW7fwU9xARJBT8vzTLz+40t9WAcpFfSLEHKL6K5GVgQ9bfEhI4AIslTmwbyrQCCP6SQOozrQfjQTWr+ziK0xMt5p/yww0Q+GSwAM6NkYQ9HxExwhun7A8vz5vU2xI9z5qdMXXdoTuQ87ES43N8VUeh8qnROC8AhWeDRy7gExlpWl34wEXgUQt7nDenBWr1PjTF9AJLLMweOSQDUqDYRmn8GQBaosoodoSzlRK6I5qNCVEtQJdgB3wO9ZS3ErOuTQbJIeSlw2wA79t1N/x8A7DvVRdlH1xzWoCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXez4h61wsgwlcPmWXSRgrtHt/eIxpgTlgFDly5oIOI=;
 b=DhTVPyUXi7sbbm53JgJFt6ZgSzQp5UEJkKYxNH7Qj2/J3EBMPdUftlHzIW9g/Pg7iGIdg0dXRNs0NmQZkAamXYC5HALFVXCdmg++GVtqP/v0w0ZG7Qgamvho3Bls97c42ZvOycGWFLs7w4CSURtvxFzs5dytAA1rxNSsOr5q8b0=
Received: from SA9PR13CA0103.namprd13.prod.outlook.com (2603:10b6:806:24::18)
 by IA1PR10MB7487.namprd10.prod.outlook.com (2603:10b6:208:450::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 09:46:36 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::c3) by SA9PR13CA0103.outlook.office365.com
 (2603:10b6:806:24::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 09:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 09:46:35 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 03:46:32 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 03:46:32 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 03:46:32 -0600
Received: from [172.24.233.149] (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB9kQdl714888;
	Tue, 11 Nov 2025 03:46:27 -0600
Message-ID: <7b4351bb-92ca-4cb7-b0d6-cc69feda7baa@ti.com>
Date: Tue, 11 Nov 2025 15:16:26 +0530
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|IA1PR10MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c6e41e-2efd-4bf8-d617-08de21073447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlV5MkRQbEhuL3I0STByRlFVZ092Zkl0bmRTQkI4ekJsdS9BbUlkY2NDNnZK?=
 =?utf-8?B?Qi9PSkNHZVBOUmM1Wm13cnArVm5wd2liTi8wQjl3V04vMEtHSElXMm4xMTU4?=
 =?utf-8?B?Z3ZHRHJOVVN1Z2xZeTkrcFNJSnRSNzFOVi9CYXk5eG9oZHhVR0ZScjcvSFVW?=
 =?utf-8?B?UC9LUmgvK1BzRTdMVGRnSUV5QTYrdVNMVjJNUXcxZko3Yk9sVWRIa1ZIQllO?=
 =?utf-8?B?K04zRlZBcEQwcHg5S2dtUTJGV2duVWNpMXpyMlhtTG5xcG1aemdmV0N1NUl6?=
 =?utf-8?B?Mk5nVjJSNVVKV0czcTI3c0MrZm0yNmdqejA1U0dkVFhRS0lkZkQyd25PTVJh?=
 =?utf-8?B?WDZrbzM4ZjhjRHUwbGJyT0xmdE1rbllvQjhSbEJWWTE4bzVmcmFKMWk2alRN?=
 =?utf-8?B?Sy9iaHpveEZjZDFGK2gwR2R3NllFY0dITzJudGJ2dDFpa0xhd0ZTdmtlSmZQ?=
 =?utf-8?B?RXJxeVE2SW85Njg4R0hYSkhyOGFtZ3YzMlRqQUVhbHhXcWlQdmkyS2JQRE85?=
 =?utf-8?B?UnFZOGNJK2ltNXp6L0I1VGI2bDZPUGtLQitsUlRnYXExNDVxTnBCVWI4Z1hr?=
 =?utf-8?B?QmkrcDBjajBOMXBTRFdiNHE4d2Z4Q0RUb1ZhTEZTODJxNXNZWkcrb2xQYk9C?=
 =?utf-8?B?Ni9HcS9VaDQxVFBBYSs2bXY5Q2NlTVhTekY5NzNrbVZYTGZRZlNDV0VtWDdZ?=
 =?utf-8?B?RkgrdjBxbFQvK3gwS3ppajhxRm1udS9NNzM5ZGhaSVJUd1NSdHBLU08rdDVQ?=
 =?utf-8?B?T1lXcHBHak9lVHlOVEg0ZHRDMXh4WVZwdkNVb1Q1YVBxYVNRZTNjb0oxSml2?=
 =?utf-8?B?bDVTUVZ4MFFrQXE5eGdxZFF2NFdwL1VXWk5ZTFdZUW91VHc4V0JNRUxtQ1Rh?=
 =?utf-8?B?UHFpOTBiaFJqRFNwaEl6OXA5RWJubjRrYUhlRlVteWc2YU1aMXlEcUJiUlhm?=
 =?utf-8?B?R214V0xGOXhpRjBhbHM0bUczZjZPbTlBY0NBa3Zqbm9LbEp3d3pSa0RFSXp2?=
 =?utf-8?B?YmlQbExFaGo2dXNYMkhvZFlrZG8rQy9QcVhhQ0VBWlpnRURWTDFFSitnUW5r?=
 =?utf-8?B?Z3lzK3dEZ2ZSOWMvTXgzQnU3d0ZzWlpicjVhaDdwU203cDl5czFZY2lOK0tS?=
 =?utf-8?B?YkNFTW9lSEN3ZCs1ZzdjSkJKYk9uTGVIWm9MQ0xTNFVGdmMyZGUvNy80UThz?=
 =?utf-8?B?dlJLMitkeVV5MHJ6cHF1d3lSa29LdlVmc3E0NURhOW5FU2F1Z1RPeE1hRWF3?=
 =?utf-8?B?WVo5eVpheGtBNUZ1MEFldjZWS1BtYnZVa05XOXNZR0RRVVE1cElmaUpGL2NP?=
 =?utf-8?B?bFJlYkt3UVlSZkRXMXRYdnhMbFRYWm1HakRjempnaXdsNTlLRXRxdlJWem1x?=
 =?utf-8?B?UnE0RVJEQUUyR1N3M3VnckI3VGdaZEtVNmJ6YkVBVlF5Nm1KOTdHckk5aXNF?=
 =?utf-8?B?cGNIcFp4aGlVVWhTT3UyNE9DbkNHZ0RHS3V2dWZUeXh1ZUdIV3haNHpVVE1u?=
 =?utf-8?B?bCtBamIvZFBrY2l3YzlLUEZLKzlqTXZsalVuU01XdVNCRDJUWXNYYzV1MXhz?=
 =?utf-8?B?UlRlOTlwOUFWb1MwNTJDeldSRFFNWlVtRXBCWnR4KzNidnUzU3lzaFlic3Z4?=
 =?utf-8?B?dGIxOStLL0g3ZVRGQ1BnNkwwam9IaFpTSzR5THlPOUxKOENzSlVrSVFRcUhL?=
 =?utf-8?B?WGRSMEFxQmpGNXNHb3p1K2hTcmw2cFZSVVhPYnRzNDBnbW1WbE1YNGlwRnNz?=
 =?utf-8?B?bkNPKytyNFA5MDMrUVMwSHhjcXQ3YndiWEF6dFU0RGhta05vQXBTSVJGZjMr?=
 =?utf-8?B?dktrMkthNitkNDM1NWY3VE14NzlLY3FlaXhFbVpSZ2YxLzVVWmpZNWdOS2Nm?=
 =?utf-8?B?cE1JR3hhOGs0WlNSZTBlYjluYTFrVGhzQTl5WTIzUzJlR0o2ODZvWTk4Ny9k?=
 =?utf-8?B?MktLVFlYSWhJMUN6Yk1XUFRGNW9rTDRBc0VrenRJS1RDZkgwT3BVcnhBZGxY?=
 =?utf-8?B?ZUc4RXFjeG9kZTlmT0NyZ0NMMm1kVXdKSkx4OFlVSmxTMksvcG4yS0FyVEYx?=
 =?utf-8?B?S0RRam5OU2xLcFc3OG1zQ3lpd25nUVMrVERmQnozdHNFMDhJZlhkTGR0WDRx?=
 =?utf-8?Q?5Tb8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:46:35.8343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c6e41e-2efd-4bf8-d617-08de21073447
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7487


On 25/09/25 18:14, Tomi Valkeinen wrote:
> Hi,
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
>
> j721e-csi2rx also has mutexes, and it's very unclear what they protect.
> This should be described in the code.
>
> I think in csi2rx the whole mutex can be just dropped.
>
> j721e-csi2rx is a bit more complex, but there also I would consider if
> and when the state lock protects the relevant parts already, and when
> another lock is needed, what is the sequence to lock/unlock (e.g. always
> csi->mutex first, then csi->subdev state lock), and make sure the code
> follows that.


Thanks for pointing out, Since enable/disable_streams() are protected by 
the v4l2-core by taking the state lock, all the mutex protection inside 
these functions in the j721e-csi2rx driver can also be removed.

I will make sure that this order (csi->mutex followed by the 
state->lock) is followed through out this driver.


Regards,

Rishikesh

>
>   Tomi
>

