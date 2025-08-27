Return-Path: <linux-kernel+bounces-788432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE4FB38446
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F54D1BA3B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74673126A2;
	Wed, 27 Aug 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IDoWxh58"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB81C6BE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303256; cv=fail; b=u8NEr+jv+u5px7hOvxeTajElYyaXj9j+GfA83Q52WT5Lh2NFL+XdXm+Ef8c1/QX/R1XhvIrqMNdYRlV04zxRnE9uzuRqN4QUnTJvcg4NxvCbrMNV3ov7NeeiuK4ykkDhu+B9jiCr8EBzUCGlDgbYFCSAgIovpsSQjcPd6rbfFco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303256; c=relaxed/simple;
	bh=hQCYj8yymIq/gG55oYm1iqp4sVZTt0FegwZX3WGVFaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A0U+Z6QqmVnMXY3nPencvsJM0MLf+W3YgQbbCLKdofmsbEv/GkDbkbJ073+RpCSaMhW6pE6aqB+35JzBEqJB+7KxnncPdbnOK4tZvO8kXpxKdATbQoVl/PpwTwvwTM1row891OIcsdORdFVm/5i2pVF6Xk6HLjjpz65Py8d8vR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IDoWxh58; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLisXCE+zng0Wt5yHrwoiDfIY2WKk1wiLG1wUEvGYQYZLj6pS7/d+RG+CFvapWt0OoH31KFt5eHWryMttdZi7oPQ4fmKaq8Qu1D7tftmDHljx6oiddolTPpogJjEKRxmYAriTB9XsErxvbTqSvV6M+Ns4fY4Z68GPa0EFBrWu5BH95FteF1ehOUPejYEZtwoMyetNGtdJyzY1zwgOKlnQFOnPY29Na00Qwp24C+V1ItmSSgg1mBB4XGNC7DvngE+6c4usjym4robT4kS+YDUcMBDmlN1mBkDRDWL0v8rjUNTrMjZJSuRz9R8RWPdKXIHpJXU/+2/5w36uPbEgdZiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFy7EjDhskpnyyqz5KdYr5/BiPtvpffxStEk5hiTMCM=;
 b=cbq8nDkRTFe5OHRjor0sXrJb/4mvve4By7Jf2jLWCBqTuY1vS/48+VQLQWKMElKfe2ivm1HDibVo2PjtqEmfRiIcmTdGED8RflzWZKIUJ46uNZ3VI5L8HOaolzibs5pOGC6arbrsQVq6lq2PMli9id+am02Oge6mUKHBz4gn1fwfP0U7uoEirnE830NngD0qdgNadLAikgmMa7MBsli19e/UNlv5ry9xNkbTxXnuc4+Bv6bUEmSaPpNmnUfgNGSsymOOE1MuTC7Naav+o8GQJdVgJn05/quYA4vgH2GZ1BldOW+cvHjzCrLPUzU2sQR3BFPx1f78XTFwlr7sEadLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFy7EjDhskpnyyqz5KdYr5/BiPtvpffxStEk5hiTMCM=;
 b=IDoWxh58fHK2Dn/sGzaes+iPT8xyvMdnqxwVxS0DAQY/G6OPwvdKwgdn/RcnjMkRJSKkHAf0Lb7SdX7cC8Ej0AzxblGgmzlD1bAcTBXZzL5Q4eOaPwm2jxYm7uN48K59wSPyZkE68Zs4G9ZuSE1lJ7Z14zx1OCfatZeTlthGL4U=
Received: from CH5PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610:1f0::17)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 14:00:52 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::48) by CH5PR05CA0008.outlook.office365.com
 (2603:10b6:610:1f0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.6 via Frontend Transport; Wed,
 27 Aug 2025 14:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 14:00:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 09:00:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 09:00:51 -0500
Received: from [172.31.63.243] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 27 Aug 2025 09:00:51 -0500
Message-ID: <9194431b-2178-40df-bcc1-da0faeb9778e@amd.com>
Date: Wed, 27 Aug 2025 10:01:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drivers/xen/gntdev: use xen_pv_domain() instead of
 cached value
To: Juergen Gross <jgross@suse.com>, <linux-kernel@vger.kernel.org>
CC: Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, <xen-devel@lists.xenproject.org>
References: <20250826145608.10352-1-jgross@suse.com>
 <20250826145608.10352-4-jgross@suse.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20250826145608.10352-4-jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: cc817e4c-dad0-46c1-8c5c-08dde5722281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blFPMW56ZFEzWHk2WmpRM2tURlBnVlluNjZxZ1JkTGRHNlIvc1pKNWFuTUp1?=
 =?utf-8?B?bnhSdi9MYkgydm9jT2xNamZSVnltZzZuR0RHNFREQmkrRXVTL3U5MG4rT2w3?=
 =?utf-8?B?RGxnQ1hkbEJwU1FGSzRvc0FVaVJPY3AyWVhyY25PS2o1V2NSR0ozMzJlSkx1?=
 =?utf-8?B?TjFKWEV3aWVhVVA5YUk0K3hWOUtWV1g1d3BxZ1NyVFRaZDlUMnJPcWlOcG94?=
 =?utf-8?B?WW83Z3I5K25sY3MvSXV1VlN2YXZ3VXpBZjFyU2NzOGxmbi9EL0VpbS9uT1NQ?=
 =?utf-8?B?Wm5GUVlGcmJwMGlQVG5QUy9Ec2lYTXFhUVhJUVEvZ09RZk5aT1o3MXY4UlRR?=
 =?utf-8?B?azF5U2J0VE5URHd4azZWNjR6WUt6TmNLWWJ2UnJvMU5kWlFhM1BvQS93VFdW?=
 =?utf-8?B?Y3ZMNkYxcEVlWjRNYytydUtSeWd2SmNuREtsZUhFdWcvQzVxZGRtaTNzUVpN?=
 =?utf-8?B?MHJBd3pzRkRjNW1kTTFQaUdZVGREWVVUdDhSRzAydEJtcU9rTnFLaEVTTUR5?=
 =?utf-8?B?NXVRZFhLN2g3QlJBbnJHcVJFK2x6SXNKN3FFRDhRc1BvdTFSdzM5QjVjNG41?=
 =?utf-8?B?a1ovd29CRDNLRDBkM1BSQlFHZmZWNG9LeEk3ZGFEcFgydzRXcHRaM09Rd3Aw?=
 =?utf-8?B?YldqaTNmSkJwbkpQS21QZzZOUnhtdDNwZHRCOGIxbHRQWm9ZeW9WekE2WWdh?=
 =?utf-8?B?ZktWOEpicnlVOEZqTFphV0tPakR6NjBJOTFjcDQxWFUwOERBTW9mZy8remlm?=
 =?utf-8?B?bDJXUEVqTFExKzdxalBUSitqSXF6WUFuZEJDZ1RaVnF2MlhlZHkwb0pVenVR?=
 =?utf-8?B?RnAzUlNnSkdMOWsyWjdsbURNaHpRYU1LaWxvTzc2QjNBTkRtck9SczZ5MnVh?=
 =?utf-8?B?bU1DVFFtTzVtYUM2aUR2eFdtcWNjZ2RKM3dWM2FqRXQ1RnI2aWwwRmtULytD?=
 =?utf-8?B?WkVHKzJQOUI2RVEwZ2l3eENwaXBneXVONmt4dVFsbHNRLzNvbDNSdm5CRXYz?=
 =?utf-8?B?aXFNUFA0RjhYNTk2aUJRSTQ1NTcwdGZFdUU0Sm81dmxaYmVFV0ZkTVBoeTRY?=
 =?utf-8?B?bnBGMGNDZDZPQU11RGJ2MzRmYng0VDh6Yy8wTVROS3NSSUJiOGNITjlkSkFz?=
 =?utf-8?B?Y1pJZE9BaW1pbHVUZElkZTlaWlJuaGJSeSsrdnRxeGIvUmZad2hvcHJ2RHNG?=
 =?utf-8?B?ZzlGWk1yZk1UeTBmOGhWRVFoR0NRalNyMXBnQXd3MS80QWIyMWFESG9uRk5a?=
 =?utf-8?B?SVBKSUoxZU9CNVUyS1N0bnUxbjI5MGRZS0oxQXg4cFdsRTU2WkxXcDZTdldm?=
 =?utf-8?B?MXZ3V3cvTnZWczFONXVZMjBBYnpJUVIrWG1BbVU2Z2JzcE03RmsyM3pKdXk3?=
 =?utf-8?B?RTAxaEpZMWMvajgwbWFDTGYyUDU0NjRRcDF3Ni9CN043QWpsMHVLMXdJV3Rk?=
 =?utf-8?B?bVByVy9nd1ZROEpCSWlTVDkxT2NFZnhDRE1IMkZmdmdDcmVSSU9jR04rdnY5?=
 =?utf-8?B?RG90WDFDNEdHRFhjMncwSW1mekhRRkhhZGFseEpnSnhvQWVMRXRwRkdjVSta?=
 =?utf-8?B?Si9YVzRLdjBxSEJ6ejJXOFlHTFJSYU9ZZmRvY2RaS3BibUNlRXNIazVYZExy?=
 =?utf-8?B?UEhuMjg3U2FlTk56Q01SM2syL1dGYnVtNFU0ZlFNc0RjVHNGZkNpM1pkSlBJ?=
 =?utf-8?B?ZmxPN2VXcFVucGNMeHBMRlNMM3FYeWlFd1dkZ0RKMnZic3FGREV4UXlCdm5O?=
 =?utf-8?B?alFncWdxbnBaSFpKNUtnT0RDOTA3dUtBVmowNVdsZzhobU5TTjROcndqYUZB?=
 =?utf-8?B?MENSWlhPbUxiVENtQko1WHpHWk1KQ2MzMFlaT0VGKzlvV3JMLzZxMzFjVitU?=
 =?utf-8?B?RXNTV1hxc25rdmxmVGVmR0c2TjRrck81b2crdUlMV1EybVQ1RjNBSFk4aWV0?=
 =?utf-8?B?NldzN2owNXA1bXhuVEk2MjFBSGdqVmkrTlczV2haWG43WkFOQ1BqVVMrZmwz?=
 =?utf-8?B?Qm0rWENac0cxVEREZEhIcHFmcitMcDJkMkhkTHEyZld3R1JNM3hTYVRBa2FQ?=
 =?utf-8?Q?07neBR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:00:52.2611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc817e4c-dad0-46c1-8c5c-08dde5722281
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238

On 2025-08-26 10:56, Juergen Gross wrote:
> Eliminate the use_ptemod variable by replacing its use cases with
> xen_pv_domain().
> 
> Instead of passing the xen_pv_domain() return value to
> gntdev_ioctl_dmabuf_exp_from_refs(), use xen_pv_domain() in that
> function.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>

