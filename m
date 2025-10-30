Return-Path: <linux-kernel+bounces-878878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A7CC21A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7507C1892BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB9E374ADD;
	Thu, 30 Oct 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rHB+V5in"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D9374AC6;
	Thu, 30 Oct 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847296; cv=fail; b=MPCj6yNXl9PzSmdhGUhv/aarNy4L5DUd/21I0VUGPXFjL2lHoa3t/oOnXSWy8dkbM1tWqsAMImWihy2xA+uh+ACWr+rvkeDJCJNDTaFF/VgQQHNgxzujLE5l8Ohebbgx4nfShR4h9UuOGYqL7TWcKc3PaODh765ePpq6qmTQr+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847296; c=relaxed/simple;
	bh=wEIEkWBRUDEn57YO4gCps+gRIaKivJKXU4qSrnaa3Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=otpkKeP/GW6xhHMVU8Bv4IkGDEY/UQEglcJEY1BJecMpOaB2e0g79s0u5EvjFNIC0iawWPlau99ffySk9nw/6aGcgYbqdeu2WLgc6TYWFoiQzSSKf61WdPBRNWqHzcGAiQbqCqe0zIV9Ksf9TbVDZnLx4ImRlyTjhEK7iRwUw7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rHB+V5in; arc=fail smtp.client-ip=52.101.85.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6C8wmikJY0RYk9yffOjBCIxUF1VHQPK3CqPChO+CQY8siYy1kT4Vj76fAwnq8vmX3dTQnfcbR1/7aT/g/1IU9O++9LHueFYsfDot5XLF8xilpJFs6swk4ippADoDyK3fpTkQCFnzmX/P6EpUjrA4vsaqhqdzjf9PWBw/CC5bRASyBkmQhmEpFgV19o2Wndl5HAyERf8BPZOe7Yl81YGX8pfq6MwGV0uvKslzUyuo6udvU2VTSSjNgcq7Rv8oEDTvHn5HEk4fFGp41sg7q9TSgIaQtxm8MqdmmKrB40kEQgXza0x3yGUH693PzfHptIsXK6oDWMxOopuPjWJX10pIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oTlmY6l2L5sHFfJb80tZU+ZlmPQMG0isnZD2jGkU/k=;
 b=ygCWCpXUfJwV+UzsXTrpQNQXhoZczM9lAW7VNzeIhgQPoWu6Rjc+rvJjZX3zUEDUUc99aoo/d0VM6DrTChKzUFSA1otdQdUaafc/WEbWho2r1pcnD5XLzwOYnj4BdrNx17EMS//cx/04pzHi2u6cWUGeErUWhJZimGcNj/xyPjkiaQART3OPJx+gSteFzxJKez5O+xpsop0vAyWgfactXwI8WNy46ad1c1NIticuAOXxhb/rYPjbyYeFs1KKaxDmzfu09UqZD3uuHkkDpB4BUhMUujmrICWeyaCrYMDSrNy9WsCru3noLsYWoFUpqhHdD5XACQxdTNXZb2gXK685CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oTlmY6l2L5sHFfJb80tZU+ZlmPQMG0isnZD2jGkU/k=;
 b=rHB+V5inJBBFY4buH5W7YmCd2Lg9yngAZbkxXBB+HIq4BbyukpxT1OFKqtqjHgfDQLWUNbvo74lhgnbhZuo7bQDe1peylrXIdxL7lyBQBmatJQAfHEwb9ADKgw96+0MfIlPpZ2H0ADuoCZ5MRJunXLVCIzgxvl44TmC++PeGvQQ=
Received: from MN2PR20CA0061.namprd20.prod.outlook.com (2603:10b6:208:235::30)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 18:01:29 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::24) by MN2PR20CA0061.outlook.office365.com
 (2603:10b6:208:235::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 18:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 30 Oct 2025 18:01:28 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 13:01:15 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 13:01:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 13:01:15 -0500
Received: from [10.250.149.46] ([10.250.149.46])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UI17qI2566598;
	Thu, 30 Oct 2025 13:01:08 -0500
Message-ID: <9bc6f796-6ac4-44ff-a23e-d23d30f431b6@ti.com>
Date: Thu, 30 Oct 2025 23:31:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-{j7/am6}*-ti-ipc-firmware: Limit FIFOs
 to Linux use
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
	<hiago.franco@toradex.com>, <francesco.dolcini@toradex.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20251030160635.1388401-1-b-padhi@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20251030160635.1388401-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5b7295-e4e3-4fa5-b813-08de17de5941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0M1ZDI4aWhEbHdyTC9yVjRuNmRlRW5MdklUeWlDMFJUazdiTVhHSHBjYmN5?=
 =?utf-8?B?eFh5azh0QVBIMXBPSzlXNWhNVkNMNjdWRUFZdWRQVzlWWm9JaHNxZWN2c0RV?=
 =?utf-8?B?YVFWUnlsVnJ3YW5PTWpyNjhmQ0wvWlpqTHpOdEpHTUs3K1cyWHVmdnZpQW5N?=
 =?utf-8?B?QzErY0FCQ0lCSzhjMllXTWsxTU5Qd1ZGUTluVjgzcFZaSlNUTWluckhqVW5v?=
 =?utf-8?B?L1N2WHBHQytGMzUvSXJzckMwb0FpZTFXRFkzL2FCeGJKSmVZOGhmem1Dc3M1?=
 =?utf-8?B?SDdJY3lTSUY5aldEbGt2cnY2dlZwVDVrOUN1L3E1akpiQUNJMmI1bEpyQmNp?=
 =?utf-8?B?TkZER0FENjBYWXNWaTVQLzc0bUc4azcxM3dZL083UkoybUFva1BQVnlyRlFL?=
 =?utf-8?B?aGx5ZG5nTng0WFhKRGFQTjU5N2xNN2hQS0xvdjJjZmZpTHJXUWVzZnFWOEY2?=
 =?utf-8?B?emE3c2pUUmptK2JDMkNJaEdPcG1ZZVBEUzdnU01ldXZEWElBeUJNMFZhQnoy?=
 =?utf-8?B?S0oxWW5IOTYxa1ZGYU5RS081RXg1S0FOck5pWnU0MUNkUk1penI3QkxsbjZ5?=
 =?utf-8?B?TG00eWFnbWV2VVRveE5id0l3WlBlK2hXN3BMbTVjM0JBQ1FhbFZMWmJiSGVx?=
 =?utf-8?B?SWpJanRhRjZqNDNEdDgybGZzZlNCK3VQa21qRTVzRmg5V1JEeGVPQmJJOSt5?=
 =?utf-8?B?amRGWnJqZFAvb2NldkplMGxHdUM1SXZTRTFVdnZBNkxaWnRqRHQ3N0Jabks2?=
 =?utf-8?B?VUd3NzQyTEFhejE0L1hSbjdjRGl0cFdCZGNlN0g0YmU0N2txZWdSOGRDSnl3?=
 =?utf-8?B?TS81M0hmUEVXUFE1Q2prNHpZbmE4SlJ3eFcvNmpiQVB1OXRrQnc4TU41NmM1?=
 =?utf-8?B?WmxlTnNDaCttZHo2RUFnQ3lTdEZwc20ybXpoblN5UkVzSURZWjRFYWF4cEVU?=
 =?utf-8?B?QnFHK0tPNklLeGVXTUZCUmpZYVJVRGlKa0M3VGx6NzF4MXdZU3c4N0o3dHNE?=
 =?utf-8?B?NVAvNGV1WGE4TVBkV0x0MXk1a1BVNGtsYWFhNWpjL1dRTHdEMXh4cmZnM0Ur?=
 =?utf-8?B?QUtnWS9zWGZLOUdBTmtwMjMrRWlYbHNzNHJSbHdnalQyQytCNW0yVmh5aGp2?=
 =?utf-8?B?bE5iWURFbUFiWS9JQmpuSGR0MjBybTRNNlAzWXBka0U2Z0phU05tQVlTTVR0?=
 =?utf-8?B?YjlHNGlUSWdORGlIaWpZYkYxM1NjUG9zM1NqaW16SHFyWktaSTlZMjBDTmxw?=
 =?utf-8?B?V2t6V0lXWFVhOHFEM2MvWkc5YzRVL2FaYmwwTFdGa29CRVRpSUxtN3EzV2xT?=
 =?utf-8?B?SDgzR1RoRUhURmJaSkU0ZjhueWV4a0taTHFLVWRZMzV0QTRIV2x0RXdHUU5w?=
 =?utf-8?B?R1kzUTFQOGZaZlBDNHhVb3dmaDVmK0kxbFpVdHEwT01NSDZ5dXlWdGpsYTdU?=
 =?utf-8?B?eUttY3Y0OHBndlh0SjFMV3FBcG1oUmo2cnRwRmxKb1pmNnIwOEZ2Nkw3K29B?=
 =?utf-8?B?QVRkRUpqUGtPa2hJSzB0L1hlUEVlV0t3aWtJYUpNdkVIbmFCNlZCQUgzdHJT?=
 =?utf-8?B?ZjVRakE2WmtKQzhydUZZdElXR0JWT1M1dTVxS01NNDBBNUw1Qys5OEcvUzdu?=
 =?utf-8?B?aW9IYzhDb0JJeFJNTW40T01ManBwQUltVkdkSTluQmZsNnc0RkYrTDJZeXF3?=
 =?utf-8?B?MHdaeE5DNDBoZkplWHMzVW5WRUhHMFNqWmE4R2hEbzdXVjFVc2tUYk96YWsz?=
 =?utf-8?B?T1l4dUZKYk9TZTVFcW85NEVIWi9JK0NGemJoQjh2ZWJoSUc4bEZhUzZXNnZl?=
 =?utf-8?B?ZnVSQmRGRC9kcG1kTFBVMndkSDc3dGVCMWRrZWVpOXBvc2VDd0tIbUI4bERq?=
 =?utf-8?B?aHU5OFpMQnY4clRTQUpyTTdDSUQrNFBDanpSVUp4LzFCWlB2SXZxeDNMbWlq?=
 =?utf-8?B?Zy9xU1VPOUdXQWhjSm9QSERjWHgxWDdHN3JvNEt4MkpIYXQ4RkRrS3ZxMlZ5?=
 =?utf-8?B?Z2ltOVhiOWRnbTRwelJraUo0ZVFsNGQ5ZE1tMm40SHdYYTJoYnNOaWhKMEJ3?=
 =?utf-8?B?QnZ6ZVZ2a0c3dEQvMy9iL0VTdHRoQ1grMUQ1Zk5jMFlmb0EzMWJnT2dZbWRQ?=
 =?utf-8?Q?aFL8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(34020700016)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 18:01:28.0130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5b7295-e4e3-4fa5-b813-08de17de5941
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651

Hi All,

On 10/30/2025 9:36 PM, Beleswar Padhi wrote:
> Each mailbox cluster has 16 hardware FIFOs shared among 4 users (CPUs).
> Each FIFO supports one-way communication between two users and is
> configured by the firmware.
>
> For TI IPC firmware, the FIFOs starting from 0 are assigned for
> communication between the Cortex A-core (running Linux) and remote
> processors (running RTOS). The remaining FIFOs are used for
> RTOS-to-RTOS communication.
>
> In some cases, pending messages may remain in the RTOS-to-RTOS FIFOs if
> a remote processor is powered off or in a bad state. To avoid issues
> such as suspend failures, restrict the 'ti,mbox-num-fifos' property in
> the device tree to only include the FIFOs used for Linux-to-RTOS
> communication. This ensures the Linux mailbox driver checks only its
> own FIFOs and does not interfere with those used by other remote
> processors.
>
> Fixes: a49f991e740f ("arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware")
> Closes: https://lore.kernel.org/all/sid7gtg5vay5qgicsl6smnzwg5mnneoa35cempt5ddwjvedaio@hzsgcx6oo74l/
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Please help in testing the patch on Toradex platforms.


Please ignore the below patch. We had a discussion internally
and want to take a different route for this problem. I will post
the new patch tomorrow.

Thanks,
Beleswar

>
> Testing Done:
> 1. Tested Boot across all TI K3 EVM/SK boards.
> 2. Tested IPC on all TI K3 J7* EVM/SK boards (& AM62x SK).
> 3. Tested that the patch generates no new warnings/errors.
>
>   arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi         | 1 +
>   arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi        | 3 +++
>   arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi        | 2 ++
>   arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi         | 3 +++
>   arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi         | 2 ++
>   arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi        | 2 ++
>   arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi        | 5 +++++
>   arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi       | 4 ++++
>   arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi        | 4 ++++
>   .../dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi     | 6 ++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi       | 1 +
>   11 files changed, 33 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
> index ea69fab9b52b..913bd5ff49f7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
> @@ -21,6 +21,7 @@ mcu_m4fss_memory_region: memory@9cc00000 {
>   
>   &mailbox0_cluster0 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_m4_0: mbox-m4-0 {
>   		ti,mbox-rx = <0 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
> index 950f4f37d477..b377edb52bc9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
> @@ -33,6 +33,7 @@ mcu_r5fss0_core0_memory_region: memory@9b900000 {
>   
>   &mailbox0_cluster0 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_r5_0: mbox-r5-0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -42,6 +43,7 @@ mbox_r5_0: mbox-r5-0 {
>   
>   &mailbox0_cluster1 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_c7x_0: mbox-c7x-0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -51,6 +53,7 @@ mbox_c7x_0: mbox-c7x-0 {
>   
>   &mailbox0_cluster2 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_mcu_r5_0: mbox-mcu-r5-0 {
>   		ti,mbox-rx = <0 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
> index d29a5dbe13ef..82512e7a44ea 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
> @@ -21,6 +21,7 @@ mcu_r5fss0_core0_memory_region: memory@9b900000 {
>   
>   &mailbox0_cluster0 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_r5_0: mbox-r5-0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -30,6 +31,7 @@ mbox_r5_0: mbox-r5-0 {
>   
>   &mailbox0_cluster1 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_mcu_r5_0: mbox-mcu-r5-0 {
>   		ti,mbox-rx = <0 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
> index 6b10646ae64a..793e965c5a4b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
> @@ -63,6 +63,7 @@ rtos_ipc_memory_region: memory@a5000000 {
>   
>   &mailbox0_cluster2 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
>   		ti,mbox-rx = <0 0 2>;
> @@ -77,6 +78,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
>   
>   &mailbox0_cluster4 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
>   		ti,mbox-rx = <0 0 2>;
> @@ -91,6 +93,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
>   
>   &mailbox0_cluster6 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_m4_0: mbox-m4-0 {
>   		ti,mbox-rx = <0 0 2>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
> index 61ab0357fc0d..579533df6bd4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
> @@ -28,6 +28,7 @@ rtos_ipc_memory_region: memory@a2000000 {
>   &mailbox0_cluster0 {
>   	status = "okay";
>   	interrupts = <436>;
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
>   		ti,mbox-tx = <1 0 0>;
> @@ -38,6 +39,7 @@ mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
>   &mailbox0_cluster1 {
>   	status = "okay";
>   	interrupts = <432>;
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
>   		ti,mbox-tx = <1 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
> index 9477f1efbbc6..4245a5319085 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
> @@ -52,6 +52,7 @@ rtos_ipc_memory_region: memory@a4000000 {
>   &mailbox0_cluster0 {
>   	status = "okay";
>   	interrupts = <436>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -67,6 +68,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
>   &mailbox0_cluster1 {
>   	status = "okay";
>   	interrupts = <432>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
>   		ti,mbox-rx = <0 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
> index 40c6cc99c405..4003f125dbe7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
> @@ -114,6 +114,7 @@ rtos_ipc_memory_region: memory@aa000000 {
>   &mailbox0_cluster0 {
>   	status = "okay";
>   	interrupts = <436>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -129,6 +130,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
>   &mailbox0_cluster1 {
>   	status = "okay";
>   	interrupts = <432>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -144,6 +146,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
>   &mailbox0_cluster2 {
>   	status = "okay";
>   	interrupts = <428>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -159,6 +162,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
>   &mailbox0_cluster3 {
>   	status = "okay";
>   	interrupts = <424>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_c66_0: mbox-c66-0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -174,6 +178,7 @@ mbox_c66_1: mbox-c66-1 {
>   &mailbox0_cluster4 {
>   	status = "okay";
>   	interrupts = <420>;
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_c71_0: mbox-c71-0 {
>   		ti,mbox-rx = <0 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
> index ebab0cc580bb..2ef5c95f6e93 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
> @@ -100,6 +100,7 @@ rtos_ipc_memory_region: memory@a8000000 {
>   &mailbox0_cluster0 {
>   	status = "okay";
>   	interrupts = <436>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -115,6 +116,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
>   &mailbox0_cluster1 {
>   	status = "okay";
>   	interrupts = <432>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -130,6 +132,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
>   &mailbox0_cluster2 {
>   	status = "okay";
>   	interrupts = <428>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -145,6 +148,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
>   &mailbox0_cluster4 {
>   	status = "okay";
>   	interrupts = <420>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_c71_0: mbox-c71-0 {
>   		ti,mbox-rx = <0 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
> index cb7cd385a165..c25dec00cc2a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
> @@ -63,6 +63,7 @@ rtos_ipc_memory_region: memory@a5000000 {
>   
>   &mailbox0_cluster0 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_wkup_r5_0: mbox-wkup-r5-0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -72,6 +73,7 @@ mbox_wkup_r5_0: mbox-wkup-r5-0 {
>   
>   &mailbox0_cluster1 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_mcu_r5_0: mbox-mcu-r5-0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -81,6 +83,7 @@ mbox_mcu_r5_0: mbox-mcu-r5-0 {
>   
>   &mailbox0_cluster2 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_c7x_0: mbox-c7x-0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -90,6 +93,7 @@ mbox_c7x_0: mbox-c7x-0 {
>   
>   &mailbox0_cluster3 {
>   	status = "okay";
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5_0: mbox-main-r5-0 {
>   		ti,mbox-rx = <0 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
> index 455397227d4a..809ecf26ddd1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
> @@ -130,6 +130,7 @@ c71_2_memory_region: memory@aa100000 {
>   &mailbox0_cluster0 {
>   	status = "okay";
>   	interrupts = <436>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -145,6 +146,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
>   &mailbox0_cluster1 {
>   	status = "okay";
>   	interrupts = <432>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -160,6 +162,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
>   &mailbox0_cluster2 {
>   	status = "okay";
>   	interrupts = <428>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -175,6 +178,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
>   &mailbox0_cluster3 {
>   	status = "okay";
>   	interrupts = <424>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_main_r5fss2_core0: mbox-main-r5fss2-core0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -190,6 +194,7 @@ mbox_main_r5fss2_core1: mbox-main-r5fss2-core1 {
>   &mailbox0_cluster4 {
>   	status = "okay";
>   	interrupts = <420>;
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_c71_0: mbox-c71-0 {
>   		ti,mbox-rx = <0 0 0>;
> @@ -205,6 +210,7 @@ mbox_c71_1: mbox-c71-1 {
>   &mailbox0_cluster5 {
>   	status = "okay";
>   	interrupts = <416>;
> +	ti,mbox-num-fifos = <2>;
>   
>   	mbox_c71_2: mbox-c71-2 {
>   		ti,mbox-rx = <0 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
> index 81b508b9b05e..67af04b25fd0 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
> @@ -20,6 +20,7 @@ c71_3_memory_region: memory@ab100000 {
>   };
>   
>   &mailbox0_cluster5 {
> +	ti,mbox-num-fifos = <4>;
>   
>   	mbox_c71_3: mbox-c71-3 {
>   		ti,mbox-rx = <2 0 0>;

