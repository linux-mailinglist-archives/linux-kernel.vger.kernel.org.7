Return-Path: <linux-kernel+bounces-876312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9CC1B2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA5E1C25A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5CA1CF5C6;
	Wed, 29 Oct 2025 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LMv4+Qhr"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E42B9B9;
	Wed, 29 Oct 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746797; cv=fail; b=GrdlzHsUeEw2RbUMhnt//7Y/RlOhS+hx6HbsgIkx3kTK9TmusxLDHEOIv70r/q1r+O1gdWTBaqpBp9e3DIv/CgkRQHJHQ36+h2pm9sQwouFmoGdfD+R8L4bdOjMCrcjo7ACnAwGnmfQGUY9KxFJdYS+dukMVHWn1yURT440ffOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746797; c=relaxed/simple;
	bh=8oVRTJYlUR4ddKErxLuqt9c3Rz+GjSssOreb3AEXew0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E6mejRn6XYL+xaBhtLe6t6k4lMDdx1z+ExpMr+rqkBJzNjSfIuwn5wM1RTkI9drtbK7BmUHenQU58vHKkYULA1R0ij2BXzQA1hAPEFqsjtpzzglf3/xnhEjkC1V0eBjo6ateShfLLSm6GidlaE01b70a/sHSRPGqQ2y4HFR1umE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LMv4+Qhr; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G41lUaWDmzB1VDyqeWi6AudITH3YUUJFn1UUDpdTdAXI7pM54xdlQjS77Q7yDN4JY4bX+EyBQI/FicXxgnvGQVX8qcsqlbEh8V5zm8ocDtKNvN8Niggp/vEmZe3f0kg9SQ80S+ES3ifUIUgBVPTYwnkTq1e9wjKKLEYf3OuqReex4cz0kqJ+eZTnlxVWHd2sBGw/2Wd+THgHu1dIDQoLy1qqlwQxvOmh+zzTbyJg+bOD3cKWciXAzc+TWXEJiOdzRC7cBkJjdChlXETobDlJWecqS6SB71FYoIXZgBPH6HfXi38xo/vK6t8rJxItoODSM2rOC5dRKxiO1JScs1WBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffvMx9Xrnyzj6RAmTrfM1i/MRLo2nSL9gwAfvf/qa2U=;
 b=We6W2jBc48MiQ5sn/A8iu0LX4fc4lq32S/9aTRr7IOHdfkTwhskDFUt76xFDwSjBmjwSDn3abYY+/E3nzRxEw5PTXhLIeunjseVN4dCqrTs5fQBAehkdZdy0cFDnFy8SR6uucm7qEqa4Wm5ZGY9ggri7vVy4bZSSCybhIK69Vhg19YwYleNWt8ZzhglraqPLiWO/5JSmadFV3PuPveGsmoMzQdwiRzyVROybuDWJp5cjuKKvVJOGZiIMYv+sao9lSZlcIJj0sOUsWILSpdOuLNMln7ok2nMKXHfCL4Bs5Fe01ptGxtnupE3KNgZNr8frXnX7KdpMMVl/0w7rIIGOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffvMx9Xrnyzj6RAmTrfM1i/MRLo2nSL9gwAfvf/qa2U=;
 b=LMv4+Qhr6V3CZ5p950N/rdR5uU0cToZJk3uAhMzoTQ8MRriLosuXZHjpNRjc0DKVhexDnxdYk+9BrRDVSL366yVlRVBu3PQqRsD1Z3C99NyWsYFOS4vtwXDKdYXibkRBtTzwEK9jI0EqMfuc/lLKyAn5C83zsQsJh+qsTid8MRk=
Received: from DS7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::30) by
 IA1PR10MB6712.namprd10.prod.outlook.com (2603:10b6:208:42f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Wed, 29 Oct 2025 14:06:32 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::c1) by DS7P222CA0002.outlook.office365.com
 (2603:10b6:8:2e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Wed,
 29 Oct 2025 14:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 14:06:32 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 09:06:27 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 09:06:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 09:06:26 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59TE6Q174110028;
	Wed, 29 Oct 2025 09:06:26 -0500
Message-ID: <19b8774a-86a3-4948-98f2-093df99a2a77@ti.com>
Date: Wed, 29 Oct 2025 09:06:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62d2-evm: Remove unused ospi0 chip
 select pins
To: Paresh Bhagat <p-bhagat@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<khasim@ti.com>, <v-singh1@ti.com>, <bb@ti.com>, <s-k6@ti.com>
References: <20251029032144.502603-1-p-bhagat@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251029032144.502603-1-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|IA1PR10MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5ccbc3-2e41-4a69-74ab-08de16f45d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVp4YkJmOHJEM0VnSEg0Z0JQTnl4T1Z5dEtad3BBWFF6VU1jU3dHRXNqTEFM?=
 =?utf-8?B?di8yZGl2ZDJmTVNvSU43Vjl1RGF4UmdONVVmS2FZdWJFWmpjVXh1TmR5MXpP?=
 =?utf-8?B?YlNLOUtpcWRaRGlSUG9mVG1QWk04TUtiMnMydGpKUFVRZHBWTm5MTzNRNEZp?=
 =?utf-8?B?dzgxUWNTQWlIRnNWeUN6cUE0TmQ4MkY0TUNpNWNMTjJZUndYa0U5d0FpdzRS?=
 =?utf-8?B?MnZDaWN4bldibGdISlh6V2htTWd4OEJKSUtrTWhZVGpreXdoNGo3N3NjN0xS?=
 =?utf-8?B?LzRuQWxEcjcwK1RSMWM3N3pQVUN2cU1rWi9xYm5OZ3YwOEdNR2ZiaWNRL3Nr?=
 =?utf-8?B?MXh6RFpBMitFd3lEclBkMTZ2RXVJaHJkN2pZcTVjNGtKd1ZwNGF1R0IveUNS?=
 =?utf-8?B?TW5pZno4cncvNy92TFMrakZOSnBvZC9LbW1tdk5Bc3UrNTJXRHlUQVBuSW9M?=
 =?utf-8?B?aVZQVCtrSENaU3RJU2Y2eEJxL04zeHZ3MFY2N2lxck81UTZKWHZsZWNNeGJy?=
 =?utf-8?B?RWIvNGk1cDI4K0IzRS9nc3h0Z2xiU0szNG02dGpXcEdkYzBuUjBXL3hLOW9H?=
 =?utf-8?B?VU9MT1FKckFrZHh6dmszdzVmSkRQTHoveENXOCszNitBNzlpVS9pUjFQMTcy?=
 =?utf-8?B?K0VTZ1ZvNy9DY2NVd1BMNGxlbDdBK0VhWitwcmVmN2E2d0cwNHlDK2cvTHln?=
 =?utf-8?B?YzZ4MkUzK0lYREZRQ2RkeTVBaFk3WG4vVzNJT1JyYVN3NDlITzJ6QytOU3NZ?=
 =?utf-8?B?NmpteGdYMXNxVGZJOG90SWlFaWN1UTJteHV6TVdCRHhpclpEUHV3MGNZT3Ny?=
 =?utf-8?B?V3VYdEhLR3RTSjEzQkdnNGhXNzJjQkM2L3c0REJ6Y3Z6R0FUV0dQZzZubGhW?=
 =?utf-8?B?Nkd4M3VtYzZQM01mNmIvWEozZFBoSERIalJrbEIrMFNNUDhDNjkvQ25oczly?=
 =?utf-8?B?RDNkNFlSN1ZXSGlIRnhTOGphKzUrUzl4a0hxWjBNU0dJY2ZwcVdqb2RmRkdE?=
 =?utf-8?B?ZXZ2bHFnbUVqUGU3dEE1NUtMK0I5Z09VUy9Qc3pMTzZKdkNMWlpNeFpPWFBR?=
 =?utf-8?B?SnhHMEtqRGI1NEJGaWJaQ0tMTEYxd0xPYjVtVW1RQy9XczJQeFJ5MDRNVHBu?=
 =?utf-8?B?V3FzMHpHcWtvZHNKZWxZR0NsNkhwUDVzS2RFZHoyMVFqRldRV2dGYjlNRjZX?=
 =?utf-8?B?ME9MUmF4a3ZWTE1rQlhHYlFKUVo0WGhUcDJyUlE4NzNGaUpxRjVmWVZKYW91?=
 =?utf-8?B?d0htTi9LMGZ2VWhJTGwydldUUGNxa2Njcmw4MkhNYWlYZTBFVktQM0x0QU04?=
 =?utf-8?B?b1NyZG9QS0l0OGNSUVVNdy9kaUxvRVRWS01kam92TXJFQ3VKd0NobC92RUpJ?=
 =?utf-8?B?S1B0alVHajBoOFpaYTViTm4vcUV6VS9NMlJSTWlsU0FQc1Frdm9ORWlTdmJ0?=
 =?utf-8?B?MmVEN1VYQkErblphcFdTTXJ1N2lTczlITjJXMjNTaEY1TEJ1QlF0MU93NXFa?=
 =?utf-8?B?SGtzOTZxdjg0REc3Skw3QWZXOWUxc2NRclJWbXhXTHpQWWg0dU1aRTNXY05M?=
 =?utf-8?B?ZVQrS0dSRE84Z3R5Mno0NFVtcjJuR3BVc1VGWU1zSGdqWU85MVRqbU9qbEVK?=
 =?utf-8?B?MUpqN1RoKy9OMmhTTFJBaUlpeHR5VlNCdzA1Y1ZTSW82bFNiZFNabEdPd1Ry?=
 =?utf-8?B?dkFSdGRnOTR0Nm1wZys4bmRPU2t3c3RSdFp5bEI0aEFCb2I0Z1htdnR1VE9M?=
 =?utf-8?B?SThEdnRJWGo0cVRzeWdmUjRUQlI0UE5oM1lidC83UUNHSTVGeHZRcHJxeGZL?=
 =?utf-8?B?UlVueEFmUlAza0piaC9zOHdNcjZqYUJ2SUp4N1ptcTdxVzFRcXl0NFdZd3NS?=
 =?utf-8?B?RlpoMFVaNmFwVG00TklFUlZiTmZwY0o4aUZOUktjZnJLaGRwZFd0NWxBRk9r?=
 =?utf-8?B?UDZqbFZSd2NqdlBKcHJQYjFZRXpObldEQzIzd1RzdFozL3NjcEhNNFZhN29Y?=
 =?utf-8?Q?5+GLu/V4BDvLlbgaQJQQyeC/yh8cpg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 14:06:32.1485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5ccbc3-2e41-4a69-74ab-08de16f45d0e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6712

On 10/28/25 10:21 PM, Paresh Bhagat wrote:
> Since only a single flash device is connected to ospi0 retain only the
> OSPI0_CSn0 pin configuration and remove the unused CSn1-CSn3 pins from
> the default pinctrl. This simplifies the ospi0 pin configuration without
> affecting functionality.
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

> Boot logs
> https://gist.github.com/paresh-bhagat12/ac3b7e8a39f6f35004d9c51c6384f0c4
> 
> Datasheet - https://www.ti.com/lit/ug/sprujd4/sprujd4.pdf
> Schematics - https://www.ti.com/lit/zip/sprcal5
> 
>   arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> index 83af889e790a..bb5af52ae8b7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> @@ -355,9 +355,6 @@ ospi0_pins_default: ospi0-default-pins {
>   		pinctrl-single,pins = <
>   			AM62DX_IOPAD(0x0000, PIN_OUTPUT, 0) /* (L22) OSPI0_CLK */
>   			AM62DX_IOPAD(0x002c, PIN_OUTPUT, 0) /* (H21) OSPI0_CSn0 */
> -			AM62DX_IOPAD(0x0030, PIN_OUTPUT, 0) /* (G19) OSPI0_CSn1 */
> -			AM62DX_IOPAD(0x0034, PIN_OUTPUT, 0) /* (K20) OSPI0_CSn2 */
> -			AM62DX_IOPAD(0x0038, PIN_OUTPUT, 0) /* (G20) OSPI0_CSn3 */
>   			AM62DX_IOPAD(0x000c, PIN_INPUT, 0) /* (J21) OSPI0_D0 */
>   			AM62DX_IOPAD(0x0010, PIN_INPUT, 0) /* (J18) OSPI0_D1 */
>   			AM62DX_IOPAD(0x0014, PIN_INPUT, 0) /* (J19) OSPI0_D2 */


