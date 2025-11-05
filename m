Return-Path: <linux-kernel+bounces-887380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E796BC38157
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FFD3BA140
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47302DF71C;
	Wed,  5 Nov 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sMelR8lD"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D22DBF48;
	Wed,  5 Nov 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378710; cv=fail; b=ldb4cYFRCTruqD/tzrs8lgrKPV73fb4ahui87YevEiuz4MLZOlQmtjI9ptHydJYj3V6xpQTpzUP4VzIl+emMRZvPuBTtHYs7S/005evSJonnHk/jUPb9GRJoEg1VC9qoM0uoc/NpDPC0dCF1cEegP6JAwCWyg4pVBZTXnZhdETQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378710; c=relaxed/simple;
	bh=QdPiiXC8ZVtBWCo3y11i0o09t1rnMG5LZ46/cS0HKlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=axd1saPcb1PebSArWFITMuS1fINg4/1hPHZjsDIuESnGw3Th3LQS26lWm14prRPok9glQLWg8JOCT2dL3u6SjVWewRhX49ZM2WbqUuTwDLrIEScX848nqrWrhJVlygFZf3QrmH8ZpkZFOoO9KE9DT+Y2pEnBwiDDMo0s1OLxtJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sMelR8lD; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1nQ0rM1K94SYFCRfqan1OPigwdIosLyjFHhg3li66aqyUS3iz46X2c+NeGDbs5szG8PrmV5mqgN6YcrefrFtzpLMxy4jgnRK4Mx8LbHksvSz8VhH50ZjiH6m6j6HGarQqhgxaELRmdWvaWtwJjSu1noFwWqX8cbPFiyjjFRrnCy35afiSr2xN0CDnn46AVdU+mV3UznEp3d3tx86plN3cjyCxZ+vwJVd8mkJs7JMq7WHfXFEiYjVzTig6ZSpkqx/WvLLwDEcEX1eTPvFmt69Fl4ZdRSdtj30pOsbDV7LOo/dABYPvyONRjTyDewl8C3suSfrp7XVX7CNlup3OxvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+lFpVFHnIePRAJJWoHLt+6NXaG0JmRPa0/r1Zued/8=;
 b=PVns34FtepKd/f7hfxvSatF0IYKwu6BfN9OJvyMrU2O7LZT2w4UUn/mXot9GPsK46ctPzpL0aKwqhj5ITBfgNQ1zER+1ARkTdh+tp1ntI99kqGnav6lt2/QyrUzf3+rWXV6P94iHA9DUSUP0EjN1vReBptrqc21WmdoApeanndx8Rrh0ePu+wAkFbnT+dPHO/wllRUHrALWT0OfVNlzU2fQN+NOhNPb053zXa7qreL11L/1HbbPs10OohMzRaWEPNKOWNm8r+qMNjAsizSL/4PyB/7I8YzpOwsK0Vj+xi6+Byvbe8+UXLYXBUyuefZyc87jIa8OE6QgDokx18q/C3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=chipsnmedia.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+lFpVFHnIePRAJJWoHLt+6NXaG0JmRPa0/r1Zued/8=;
 b=sMelR8lD9ytZP4QthXgxFpsM7MwxANBcjgsMByXzrTY6Ae3evPYV6e0JAC7ADECjC0n9NtfzQ3Tq/1IFMXThBglDg33HREsEzDhUuMxIzKA6qTO7if7KvU2Z/WlY41JIF5iwhGogoDlU2C4z5OmGKIDUoVQUYU0/S2aTdQ/qarM=
Received: from SJ0PR13CA0193.namprd13.prod.outlook.com (2603:10b6:a03:2c3::18)
 by SA1PR10MB5888.namprd10.prod.outlook.com (2603:10b6:806:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 21:38:19 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::ec) by SJ0PR13CA0193.outlook.office365.com
 (2603:10b6:a03:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.6 via Frontend Transport; Wed, 5
 Nov 2025 21:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 21:38:17 +0000
Received: from DFLE104.ent.ti.com (10.64.6.25) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Wed, 5 Nov
 2025 15:38:11 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 5
 Nov 2025 15:38:11 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 15:38:11 -0600
Received: from [10.247.30.62] (lt5cg2132ltw.dhcp.ti.com [10.247.30.62])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5LcBVN181524;
	Wed, 5 Nov 2025 15:38:11 -0600
Message-ID: <0a3dba2c-e3d1-4499-9db3-55ba26013877@ti.com>
Date: Wed, 5 Nov 2025 15:38:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] media: chips-media: wave5: Fix SError of kernel
 panic when closed
To: Jackson.lee <jackson.lee@chipsnmedia.com>, <mchehab@kernel.org>,
	<hverkuil-cisco@xs4all.nl>, <nicolas.dufresne@collabora.com>,
	<bob.beckett@collabora.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lafley.kim@chipsnmedia.com>, <hverkuil@xs4all.nl>,
	<nas.chung@chipsnmedia.com>
References: <20250922055255.116-1-jackson.lee@chipsnmedia.com>
 <20250922055255.116-2-jackson.lee@chipsnmedia.com>
Content-Language: en-US
From: Brandon Brnich <b-brnich@ti.com>
In-Reply-To: <20250922055255.116-2-jackson.lee@chipsnmedia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SA1PR10MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: a29c2d9a-3a29-43ec-1478-08de1cb3a21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cStwY2sySkR2RURxY3F6N1FEYXlsUk9OKy9ITG83bjlCdmxoMElKdlpqRzlm?=
 =?utf-8?B?SzlYNDhBZnpnZHRXS1Q1Nk01UGg2S25Md0ZCMnNLRmc5UUtjZVhTM1VqNERp?=
 =?utf-8?B?Z29pUFFsWDdsczkzeFhaMFlUSXA2dW1CelB5TkhObjdqS1k3c1RneEEraXph?=
 =?utf-8?B?aTdxaG5YcTJjUEFLQUFtOHp3VnEvMzFiTFVoajhqL0xXc3hveFU5dEJjemhp?=
 =?utf-8?B?Q09LUDhvcmNPNklKRDZlc2tQMUkwcFkwR21nZDkrWEhYNEhYbGQ4d3BtZEh6?=
 =?utf-8?B?bitzUlV1Y0NrcFdwUXZWZWFXcG41KzJuZjdPMTFqbEVCNDJjdTJ6NXZqUG1S?=
 =?utf-8?B?QjZzeUQwVmVySjZ5aGpDaTZhNFJoU2hKejE1R1VsbjVNSVZmYS94dS8yb2Ix?=
 =?utf-8?B?VkMyUXAydFFrM09lRGV5TVJ5bDhTU2JWVnYrMnhncTExTjN5K0Q4bUFEU0RK?=
 =?utf-8?B?RzdlaWhkWkFTTVNQd0NjK2R3SC8xWWlqekZrVFZMM3h6SEhCalFwdVlVMk5E?=
 =?utf-8?B?cEx1TTFwbkJUc1c4cytkZ3k0WXdLeHVVbmlIZkZsOXUzODhMODd0UmtsWHly?=
 =?utf-8?B?SFR1NkJEeGs4ZFJwS0I5c3YxT0d6R1NUNjNwNUJKcGUrazNlN2t3enBGQW1w?=
 =?utf-8?B?c01oQ2g1WGd1VW1nc2hFOWIwQVJqWndVR04zWDV1RXhqd21qdzN3UHBGREQ2?=
 =?utf-8?B?dkhwd3M0THBDUjNOSFBxTmZ2OW0rejdISFlhZGFQamtsVE1ZK0JnczlkdURp?=
 =?utf-8?B?SHNyWjVkVWlkcWkzdlR6OUJ1eTZ2NUpJenJFQzhmMEFzTDU4NXdqQWRFZTRy?=
 =?utf-8?B?NTFpKzdMVjJDR20rN2lPaFNJa09FenZFVlpGQ1dEWTQ2SzNSd0Y3ZHpCeHVr?=
 =?utf-8?B?L3FIMitGT0Rjbk5WK0JpMzFsS2RPL1hIQVdDaUc4cElkR01NOXdMajQ3MVBn?=
 =?utf-8?B?cWR0c0Rid1dMUFlLcjYxcGhHUFgzMFdEZWVodXBQVzQvaG5tUXg5OGlmc2dP?=
 =?utf-8?B?ejd2NVF1Q0RPRmluVWp5cVN0dTlxSENoODRTUkNnT2ZIbG5COEFPRURSQkhm?=
 =?utf-8?B?WGpQZ1NYdzBqVEEwWGxFdkJuaDZoWmVKamRwcW9Fa1ZqdkhoZTd0RTZXLzZB?=
 =?utf-8?B?ekNzb1h5RnJhTW1VajhnYVp1anBwckovUkxsSmx2b1gzMHo2Vm1iZThMK0cw?=
 =?utf-8?B?eFpZSGd0K29sTkwvVDRMR0lHdDg4NG5Gc051YjNCc0FycWZvR0NFd0lBVUt1?=
 =?utf-8?B?cm1MYWo0N1lubGlQVmdJUHJlaDRrVGdRK3lJTE1QRTZxM2U3ZUl3a3R6SnRP?=
 =?utf-8?B?a3I5TDgrZUZ6UllQdlYrM1pNNnFoVUtvTk5BbUdFWWMxMlM4aDN4SkZ6UVJF?=
 =?utf-8?B?Q1oxdVhQRStqMllQMlVaZmkvSTk1RmpSOElVSU1sNldwenVJdkZBaGEyRG9Z?=
 =?utf-8?B?WlVycVhsMXQ4cWszS3NRenZHWisrbklTUkxNN05YakZIU3I4anlUUDgxdldP?=
 =?utf-8?B?M3BGTUF2d2pwOFhxYUFNSkk3NFRLNjRFV0lyNG1MY1pqdVR4clR3RlBTSEp4?=
 =?utf-8?B?S0FWRTllbEQ2ajlYVWp4b1BDOGZFUFQxdWJmM3cyWmh6RWVzT1JHRkJwT1dk?=
 =?utf-8?B?MVk0TUpwU0hHSStKM3ZkL2pIOGFTZmROMGhGQURzdlNrbWFRWjFSS1ZZWDR0?=
 =?utf-8?B?TWo2V3BOb3M3b3J4S1h6S2pteFhBdmlUclFOdmRXVzRWZ2tuZnRJbUhJcUpX?=
 =?utf-8?B?RU1SeVNUMjZ0SGg3UkQ3UFdYenZBenc3aWxuYW85QVZIdzZuN2tUVXJPOFlH?=
 =?utf-8?B?VWoyZDdkQmlJbmwzbElXbEtPMTREUUUvT3Ftb3VNQXVWYTJXTUlxQjNFMktP?=
 =?utf-8?B?RXZFU0l4LzhIWTNkeFh2em10OGhSUDkyZ3h3SjhwUC9TQVA5TkZuWGhZSHFK?=
 =?utf-8?B?c2JOMFVyRTFwbHQ2N29IR3hndXZpeWZHMmJGSnNiWk1sSGNTbGpYbTJTQkRH?=
 =?utf-8?B?bDBBcjlsT2N5Z2h6M1RjVlBtT0FuaVkwQUhDL1l3bEQzNGoxR3A4T2pTeGdh?=
 =?utf-8?B?RHlhU3BYLzVnbkNpZmE4ZWl2WWt4M2lwbDdhTm9DZ2tUOUU3TDVFV1VuOUY0?=
 =?utf-8?Q?+gOg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:38:17.6644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a29c2d9a-3a29-43ec-1478-08de1cb3a21a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5888

Hi Jackson,

On 9/22/2025 12:52 AM, Jackson.lee wrote:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
> 
> SError of kernel panic rarely happened while testing fluster.
> The root cause was to enter suspend mode because timeout of autosuspend
> delay happened.
> 
> [   48.834439] SError Interrupt on CPU0, code 0x00000000bf000000 -- SError
> [   48.834455] CPU: 0 UID: 0 PID: 1067 Comm: v4l2h265dec0:sr Not tainted 6.12.9-gc9e21a1ebd75-dirty #7
> [   48.834461] Hardware name: ti Texas Instruments J721S2 EVM/Texas Instruments J721S2 EVM, BIOS 2025.01-00345-gbaf3aaa8ecfa 01/01/2025
> [   48.834464] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   48.834468] pc : wave5_dec_clr_disp_flag+0x40/0x80 [wave5]
> [   48.834488] lr : wave5_dec_clr_disp_flag+0x40/0x80 [wave5]
> [   48.834495] sp : ffff8000856e3a30
> [   48.834497] x29: ffff8000856e3a30 x28: ffff0008093f6010 x27: ffff000809158130
> [   48.834504] x26: 0000000000000000 x25: ffff00080b625000 x24: ffff000804a9ba80
> [   48.834509] x23: ffff000802343028 x22: ffff000809158150 x21: ffff000802218000
> [   48.834513] x20: ffff0008093f6000 x19: ffff0008093f6000 x18: 0000000000000000
> [   48.834518] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffff74009618
> [   48.834523] x14: 000000010000000c x13: 0000000000000000 x12: 0000000000000000
> [   48.834527] x11: ffffffffffffffff x10: ffffffffffffffff x9 : ffff000802343028
> [   48.834532] x8 : ffff00080b6252a0 x7 : 0000000000000038 x6 : 0000000000000000
> [   48.834536] x5 : ffff00080b625060 x4 : 0000000000000000 x3 : 0000000000000000
> [   48.834541] x2 : 0000000000000000 x1 : ffff800084bf0118 x0 : ffff800084bf0000
> [   48.834547] Kernel panic - not syncing: Asynchronous SError Interrupt
> [   48.834549] CPU: 0 UID: 0 PID: 1067 Comm: v4l2h265dec0:sr Not tainted 6.12.9-gc9e21a1ebd75-dirty #7
> [   48.834554] Hardware name: ti Texas Instruments J721S2 EVM/Texas Instruments J721S2 EVM, BIOS 2025.01-00345-gbaf3aaa8ecfa 01/01/2025
> [   48.834556] Call trace:
> [   48.834559]  dump_backtrace+0x94/0xec
> [   48.834574]  show_stack+0x18/0x24
> [   48.834579]  dump_stack_lvl+0x38/0x90
> [   48.834585]  dump_stack+0x18/0x24
> [   48.834588]  panic+0x35c/0x3e0
> [   48.834592]  nmi_panic+0x40/0x8c
> [   48.834595]  arm64_serror_panic+0x64/0x70
> [   48.834598]  do_serror+0x3c/0x78
> [   48.834601]  el1h_64_error_handler+0x34/0x4c
> [   48.834605]  el1h_64_error+0x64/0x68
> [   48.834608]  wave5_dec_clr_disp_flag+0x40/0x80 [wave5]
> [   48.834615]  wave5_vpu_dec_clr_disp_flag+0x54/0x80 [wave5]
> [   48.834622]  wave5_vpu_dec_buf_queue+0x19c/0x1a0 [wave5]
> [   48.834628]  __enqueue_in_driver+0x3c/0x74 [videobuf2_common]
> [   48.834639]  vb2_core_qbuf+0x508/0x61c [videobuf2_common]
> [   48.834646]  vb2_qbuf+0xa4/0x168 [videobuf2_v4l2]
> [   48.834656]  v4l2_m2m_qbuf+0x80/0x238 [v4l2_mem2mem]
> [   48.834666]  v4l2_m2m_ioctl_qbuf+0x18/0x24 [v4l2_mem2mem]
> [   48.834673]  v4l_qbuf+0x48/0x5c [videodev]
> [   48.834704]  __video_do_ioctl+0x180/0x3f0 [videodev]
> [   48.834725]  video_usercopy+0x2ec/0x68c [videodev]
> [   48.834745]  video_ioctl2+0x18/0x24 [videodev]
> [   48.834766]  v4l2_ioctl+0x40/0x60 [videodev]
> [   48.834786]  __arm64_sys_ioctl+0xa8/0xec
> [   48.834793]  invoke_syscall+0x44/0x100
> [   48.834800]  el0_svc_common.constprop.0+0xc0/0xe0
> [   48.834804]  do_el0_svc+0x1c/0x28
> [   48.834809]  el0_svc+0x30/0xd0
> [   48.834813]  el0t_64_sync_handler+0xc0/0xc4
> [   48.834816]  el0t_64_sync+0x190/0x194
> [   48.834820] SMP: stopping secondary CPUs
> [   48.834831] Kernel Offset: disabled
> [   48.834833] CPU features: 0x08,00002002,80200000,4200421b
> [   48.834837] Memory Limit: none
> [   49.161404] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
> 

I am still seeing a variation of this crash log during execution as we 
have discussed. If there is a lot of logging turned on using gstreamers 
debugging mechanism, a delay could occur between frames leading the 
device to be shut off and a kernel panic occurring when next part of 
bitstream is loaded.

Best,
Brandon

> Fixes: 2092b3833487 ("media: chips-media: wave5: Support runtime suspend/resume")
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>   .../platform/chips-media/wave5/wave5-vpu-dec.c    |  3 ---
>   .../platform/chips-media/wave5/wave5-vpu-enc.c    |  3 ---
>   .../media/platform/chips-media/wave5/wave5-vpu.c  |  2 +-
>   .../platform/chips-media/wave5/wave5-vpuapi.c     | 15 ---------------
>   4 files changed, 1 insertion(+), 22 deletions(-)
> 
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index 72af0faa3ef2..1df78e427c6a 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -1829,9 +1829,6 @@ static int wave5_vpu_open_dec(struct file *filp)
>   	if (ret)
>   		goto cleanup_inst;
>   
> -	if (list_empty(&dev->instances))
> -		pm_runtime_use_autosuspend(inst->dev->dev);
> -
>   	list_add_tail(&inst->list, &dev->instances);
>   
>   	mutex_unlock(&dev->dev_lock);
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index 506d6c6166a6..d2b047706626 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -1773,9 +1773,6 @@ static int wave5_vpu_open_enc(struct file *filp)
>   	if (ret)
>   		goto cleanup_inst;
>   
> -	if (list_empty(&dev->instances))
> -		pm_runtime_use_autosuspend(inst->dev->dev);
> -
>   	list_add_tail(&inst->list, &dev->instances);
>   
>   	mutex_unlock(&dev->dev_lock);
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> index e1715d3f43b0..b3c633dd3df1 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> @@ -322,7 +322,7 @@ static int wave5_vpu_probe(struct platform_device *pdev)
>   	dev_info(&pdev->dev, "Product Code:      0x%x\n", dev->product_code);
>   	dev_info(&pdev->dev, "Firmware Revision: %u\n", fw_revision);
>   
> -	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
>   	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
>   	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> index e5e879a13e8b..e94d6ebc9f81 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> @@ -207,8 +207,6 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
>   	int retry = 0;
>   	struct vpu_device *vpu_dev = inst->dev;
>   	int i;
> -	int inst_count = 0;
> -	struct vpu_instance *inst_elm;
>   
>   	*fail_res = 0;
>   	if (!inst->codec_info)
> @@ -250,11 +248,6 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
>   
>   	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
>   
> -	list_for_each_entry(inst_elm, &vpu_dev->instances, list)
> -		inst_count++;
> -	if (inst_count == 1)
> -		pm_runtime_dont_use_autosuspend(vpu_dev->dev);
> -
>   unlock_and_return:
>   	mutex_unlock(&vpu_dev->hw_lock);
>   	pm_runtime_put_sync(inst->dev->dev);
> @@ -720,8 +713,6 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
>   	int ret;
>   	int retry = 0;
>   	struct vpu_device *vpu_dev = inst->dev;
> -	int inst_count = 0;
> -	struct vpu_instance *inst_elm;
>   
>   	*fail_res = 0;
>   	if (!inst->codec_info)
> @@ -764,12 +755,6 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
>   	}
>   
>   	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
> -
> -	list_for_each_entry(inst_elm, &vpu_dev->instances, list)
> -		inst_count++;
> -	if (inst_count == 1)
> -		pm_runtime_dont_use_autosuspend(vpu_dev->dev);
> -
>   	mutex_unlock(&vpu_dev->hw_lock);
>   	pm_runtime_put_sync(inst->dev->dev);
>   


