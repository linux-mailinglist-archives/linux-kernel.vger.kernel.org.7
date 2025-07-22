Return-Path: <linux-kernel+bounces-740481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2A7B0D4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93AA1AA7E62
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EF72D46A3;
	Tue, 22 Jul 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U78DIJjx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U78DIJjx"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C762D3EFA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173311; cv=fail; b=d9gcOPyQhrHp1pLRdNabqWg35zh8XEtMHctuU44Tfg3JdFNOLNze9r1ip/1n8JGoykjFI4zQOKn/GsC4CnSRZFHNromZzjOVhxxRatZCl7DaT/meSMCn/JkHo00xYXwop9SHMShwvCZTzmGzqeiXn0+6vvOgW4E1k49eYP2hnUo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173311; c=relaxed/simple;
	bh=UsgQM+hfeRB0jhnn8XbrAunEzZ7QfOLQJfKpSpx2CE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QmQ6fNqqlVi7t377NBL/1tYMcHc4A7EWY0a7j7zimDmiUJo+xRzyWJJjSDH7BHLtb4AvJ5+frEvYycOB9YJ+inXEshVtrk1oyRuOIygWzjJOBDULCCSogGlbP0WVB4gFOwiWYDDTRvu9OBvL/KINxIlFJElRytQz4QwrncuOfpc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U78DIJjx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U78DIJjx; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=y12+eiYTyQs/h/9Pz6d3ORuTkA77Shr1gW29si49I1Gd5BgxaCftGVGGJO7A+mSad1pwf0T/7tMjNnsW/8Jws+Gd4uA6R0PcwAR/wSgtwkWPdPES2EGqFZJzlxRuzjym9J6WSVK4fz4N/+dTY39by+YhA4vqKMOe/oKVoH4nx0fGm72clV1GtgbR7j2IMLMQbEuII1tNvFc4rm8gsj6Q1qsEBpKG4torfdv/zGkaTtOTSbMhr5SQn36ICqh9CS6M+jIVUXDm/lI1aRUc2v/ewP1GaF4E00ROlZ5plJKBl6RLXA+SPy+ZsBXthR5fDtgKjuyeykTOIgAWqVk2172QYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb2rz5QJ47XLkDswmZ2roLxQWYa8PzzoYdPk/RCoy+g=;
 b=t+H7TG2IvO8GTzvAkYLSezddnZ8D2OU272MCE/cT5t6AYkb/XOJQ+0ryI7H98kgJegzkwFd82OVI3Vw3HniRY6N3ZYq7tHwKcpJsn1rEPljEhLKv+mVVa9sYvLpxUU49rYIHJgPo7iLb906dH65z8MaAtBHD6gGAJ5pFMlav8rwdSvctlrd5CgY7blf6gwfUX1VS7773MKBXdThIdC9eU8kxqkqSNxWvh+6iaaiDaj7WaaJSOtsSYQ5/QlSjRqqHgogaEIlOGBH66Notlt7mih5RF0cna3N7d7342CcIKzQfFV+JiSvd1gFtbV9oW4sk2G+1hUWZFHgmUbbswQqCYg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb2rz5QJ47XLkDswmZ2roLxQWYa8PzzoYdPk/RCoy+g=;
 b=U78DIJjxVwk/6L8ig5xLxpmcnNQUYpLp6gdhuz0p9D4fuN4IX0k6iBIrCeJtNqlf0ox7JTdUk+omu7AYRgfVmgUwHg197DMfY8X+36tj3BvrWni9AReED/7aCbWS+Bu7NkTbvm7DYBf6bn2BjtQFY6AIEMf89GHTJtEJnwIFinY=
Received: from DUZPR01CA0193.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::14) by DB9PR08MB6347.eurprd08.prod.outlook.com
 (2603:10a6:10:253::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:35:04 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::10) by DUZPR01CA0193.outlook.office365.com
 (2603:10a6:10:4b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 08:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 08:35:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq6nCr+sJW6IBXtlFSMNfRs1Bq3w/W+55m197CYqoRc17wLF3qTYyPYJ/46MTYVmuHuftxORxagw2gNCOr304sOr1ob3V35H5lECoYz1HBcqLFlFkb2yGyeOxxSrTzZo8hTr/yVKg+Nqt2DcJ/SXQ0/vy8jjUEn+BPXZOfVqacAHw4qv2QzmZ0tC5HyBNE/jdRKxIKWSd36hFa4ACKSvKbSSNoNpFRknBicJHhS37z4+/m9MzKM4AmMwMrH4P/JXDEoyVfRu/kPlY6QDVKhXr98WkgsyiWV+iofp+yLSqmd3WQglbVb13MnwduHGdTL3V4bLzlOeQIOnTmz/tesYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb2rz5QJ47XLkDswmZ2roLxQWYa8PzzoYdPk/RCoy+g=;
 b=jzCU3YvHRKTVa6kQLbhLsm0FV/zSeL1gW7pD+wxUwM6Tz//soRdP/7h4Iif8os75m93tkwFnwq9aMUJ2DR2tS7j2y+WqYHmziOh5yq7SOLHMS7TC4FfbW1IjnUIV/fk08JRTYk/MqDJmCliZkVnjY2T265QyMXc6rJ2FTtg7m4zX8wiNjE+mtmO0VL/PuQohjdxxm3y81yCWKWDw1oKxVc7kmOZyqpUKbfvTZIprR/djcEeBhAhM+WvWFBomk6qGPZB2U1pZhvJttwjfwsa7TSBO3T0bLS+dFkoEf9SGTVjSI5kMjxYwds8bq+YtuJpcjgad8gx5X/G4LXSw94GKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb2rz5QJ47XLkDswmZ2roLxQWYa8PzzoYdPk/RCoy+g=;
 b=U78DIJjxVwk/6L8ig5xLxpmcnNQUYpLp6gdhuz0p9D4fuN4IX0k6iBIrCeJtNqlf0ox7JTdUk+omu7AYRgfVmgUwHg197DMfY8X+36tj3BvrWni9AReED/7aCbWS+Bu7NkTbvm7DYBf6bn2BjtQFY6AIEMf89GHTJtEJnwIFinY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB6406.eurprd08.prod.outlook.com
 (2603:10a6:20b:33c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:34:32 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:34:32 +0000
Date: Tue, 22 Jul 2025 09:34:29 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, ardb@kernel.org, frederic@kernel.org,
	james.morse@arm.com, joey.gouly@arm.com,
	scott@os.amperecomputing.com, maz@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] arm64/futex: add futex atomic operation with
 FEAT_LSUI
Message-ID: <aH9NFffW6L2TpDVW@e129823.arm.com>
References: <20250721083618.2743569-1-yeoreum.yun@arm.com>
 <20250721083618.2743569-6-yeoreum.yun@arm.com>
 <aH4egvxnbQPu1XzE@J2N7QTR9R3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH4egvxnbQPu1XzE@J2N7QTR9R3>
X-ClientProxiedBy: LO4P265CA0314.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB6406:EE_|DU6PEPF0000B61D:EE_|DB9PR08MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d4496f-4250-4fba-6e98-08ddc8faa7f7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?a3RoZFdwa1BySHVHSmcrRWM5MGlid3dvVUQ4YU8vWGdUeUJuREVPT0Zkc3Vy?=
 =?utf-8?B?YitrVFBaZ0J5SkxReGo4RTNoOUR4QlVqSXJYcXdrQ0hIb2hvSFRackZFVGtv?=
 =?utf-8?B?S3R2VG9qN1NQa0NHS25Zc1ozNmZTS2pKYllFNHNUK2lUOEFmY3RjZW9VaCtV?=
 =?utf-8?B?OVE2RStvV0xmbkZkcTlnalVjWEtLcHdSME1zNWt0cTBwZUwzSTdYL2tscHU3?=
 =?utf-8?B?c1NQQXdMai80NnNYekQwdnBWeXhSdloyS0hRcC9sckNBMHlnRy9SRHd2SkRY?=
 =?utf-8?B?Ry9GYUcwMUkwa0xuUU9tSjd3cFZudXBkQmxJRUZmUGdVUndHb3Bld0RyaXNp?=
 =?utf-8?B?ejQ0ZjNNYW9GR2hJaTRFZUVyZnlBa1hWdlBobkxoWW16RlRIaHp1UDNvVk1I?=
 =?utf-8?B?UzhVbWZNcGVwb0thZTlSWkYrU2ZwL29WL3dkRFphdGdWek9oMzN3NUFTOVl3?=
 =?utf-8?B?QWt2QmR6QWk2TWdXZUh5ZTk3QnA1R2lnYjJCYVBXODlrdWlZNXRsRTlsSVhL?=
 =?utf-8?B?QmM0ZVB6cDcrcHlSTDVJVyszOFVQQlF3VHlrK0FzTDM4THRJckpLMy95S1B0?=
 =?utf-8?B?YUs0UUErb2pLcTVoTGQ2Y2tCSXBCL09MMFpsdWxvYnc5WDZqTFhUSU84bjlt?=
 =?utf-8?B?aDVWYVBDSWFCRm5tV1ByS3I2eGZBcUo1czAvWU05STh4SnBoZnNnRnUvZGth?=
 =?utf-8?B?TTgrMEd4UXZJRzBITnIrSXZWUlhZT0IybGluMDZLRjBkbWFjdGJndlpqMXlX?=
 =?utf-8?B?QUEwdnFMb0gzSU5Na2FVQ2tXcG5VbklXcTdnOE5OVDd5dEwrdjJaQVJrRVI4?=
 =?utf-8?B?bU9IeUlKVFhraXlQZy90MzduaVFMd0RraEJvdkVZNlJIWXpPVTBtcWZxTWZ2?=
 =?utf-8?B?SDlXZW9OOVc2QUExY3ptR21GYVhMZVU1K0oxMU0zRlo1WTVVL2tYZHBJRkxX?=
 =?utf-8?B?ck1GeWNrangrT09IZTVmb3duMjNYU05XM2Nlc2t0L0xrZGdKWElGcFA0Q2Nj?=
 =?utf-8?B?UFZ6cVNKKzhiWVF3V09BeVFTSkIvK2o0QnltOFJ4akNxbDMvRENQR0hUTkNk?=
 =?utf-8?B?QkNoR1R5bjFqdGk3V3V1aEMzc09URkNCbmxTZ29wNkhPZDNSOU82YnpxTEtP?=
 =?utf-8?B?UG10czJxaVRHMStTNU5tWWpCRG5nUHBVL0JYakxEVFVHS2xYSmxaVTFYMDZs?=
 =?utf-8?B?cXRhL1dZZUNtT1dxVWVrK2NaTDBzQUFQN2VHN01QZ0x6bnhrbTNBVTZNcDQr?=
 =?utf-8?B?Q2dXNURMQXhDSXE4QkdUSWVmRHVTN2V5ZGtZeHN1M254NGNnZ2M1WklFNUxE?=
 =?utf-8?B?ME5iNVhZVklHdXBUM2JxU2VYOHZJaEFKL0dkRzRLMElBNFUxWVB2em9CbXZt?=
 =?utf-8?B?bzc4SXByaDhTbzMzN3ZkdUVDeEMxdm1wQ0tGQTlWYnEzOFdtOVNVNlY1STlL?=
 =?utf-8?B?Und2azdCUzFneGJTMnhsZW1DVGZOMmZmQ0taNXdiNnFqa2pyeHJYR1VHcis5?=
 =?utf-8?B?d0dvbmw1T1QvNmlmaDl3Z1ZjemxSMGZWTmJVUlQxc1NOVjVWWmcyYTJCWita?=
 =?utf-8?B?ZUhmaEE3UUZDSnBTRnpNdjN2ZkorR0dPbFUxMmJqbWgyRVlzeVFHL3V1d1V5?=
 =?utf-8?B?VGdkZEVSb052d0lrU2s0KzVCNm5PZzZWODltZzNFKzBXYVlHQ0RUMUZNTnBo?=
 =?utf-8?B?TzNlRUdWUk5wd3hSSG16Y3Iwcm52MHZQdG5DU3pMMXUwcVV4SU1ETzBmUXdP?=
 =?utf-8?B?RlNYWm4wT1BHY2p4Vm1ZdnYrQzZmclpJbS9COGNqdFl0ejk1U2t1b1VXUHBY?=
 =?utf-8?B?NzZCUnAxMUNUT2NnZHo2WU9UYS82VGtFU0M2OWtaYmN1NngwR1hFd3ZZcUps?=
 =?utf-8?B?OFhJTXJqV2JuUFUxWHBWUHhReTA5ZFM3bFh2ck5IdWFxTGFDdEFSU1FQbjhE?=
 =?utf-8?Q?pPRnA6Nhxbo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6406
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	87481569-25ae-49ef-bd8e-08ddc8fa94ad
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|35042699022|14060799003|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVBNL3AxK3VnQjNOVGtOYzRLY08xUXF3SDQzQmh6RU1Qc2duT3lDVmJJV3pv?=
 =?utf-8?B?WXh5N3I0d0FJVlRSVys4YUpuTjFKR1BxRjJyZHNoMkVsY1I5VjlMTTZpSVBp?=
 =?utf-8?B?R3NCYnZ1clpkbG5rRzlRcVIvNmFmQTArSDc1eE5QN3R2L0ZtTVVTWFZ6TFdZ?=
 =?utf-8?B?elJyRWdxSCtVYU8zVWlpbjFtN2g4VTNnRTVZWHV4SFc2dGpIWFlzY0h6dWtS?=
 =?utf-8?B?V1ZWSEFyUkxqY2FER0s4Q3F4SXRUYjVTL3ZLekVPRkdqdVpXcm5tRVFKTlhD?=
 =?utf-8?B?RkNsZmltT3NTVU91Sy9KY1p4QVVDT0dzWjYvU3lYeWU3QnFsK0kvZ3RpTnBV?=
 =?utf-8?B?R0xRanZUOEdsYlVKU2VLQ21zZXArcGJkc25yU05HVFU4YVNMaE9TMW92b2pF?=
 =?utf-8?B?TjNqRFZsbG5wN2JnSWIxZG1Oa2dWSnBESjJtMlpiSWlzbjkvcUNJUWVacEdR?=
 =?utf-8?B?QVNOWmFtbmNWemtrR0NPaFRCUERwaUNDWCtIc2VpNG5RaUdMU1RaRVFYaWNv?=
 =?utf-8?B?dE8vVWtTWDZRMnU3aGM4aUVhbGU3b3pOMmNCRWJ6VUF4V2FJVElweUxSbkRC?=
 =?utf-8?B?OTVOZW1LSWErTmxCLy9vcVlyYkRmYTBEK01ydi9QaGwvOEJ5RXh5MHpsUmhR?=
 =?utf-8?B?SFpNd042VFFWTVRoQzVINVRWZXUwbHhXbnZLeEg4NmFtZHBPN29pWDhjU0JU?=
 =?utf-8?B?U3hRR3YzM29xbkU0aU9SZUFTZ3VjcnM5Z1lQN3hkUWE4TWYrd3ZyRnduQmty?=
 =?utf-8?B?Y1MwNUFZeUR0RDhmb1E0Y1RHVE1qUW1XaEZ4YlNuYVdNWTlsRmJuZGJyc25a?=
 =?utf-8?B?TnlkTXVYSmJOTkxxVXdjL2dKOUZpWHhEUVZHTkswMENNS2FBMXBDMlE2Y2Fj?=
 =?utf-8?B?eC9GVU9Wam0rT250VGNSZUcwcDgzL1dmYzlObzRvRnRVM1ZaSkcvNURpUnU5?=
 =?utf-8?B?TkVJRmZ6Y3RDaFlzMGNKRWNadXJHOVBNVmNpWGRaYmtnWnozV0lNcTRDRURV?=
 =?utf-8?B?Vnl0MUNuN1JvcmtZK3c0eU56N3MvaUo1eUNlWDkwdGNIRU5rTXYyMzFVMGg4?=
 =?utf-8?B?Qi93V2ZqcGVqVjR4SnFjWmpmTUhHWjFGbDYwZ0FYY2pVZkFxNU03OGp6NFQ5?=
 =?utf-8?B?ZGJLL3pWdXJiOUhndEVIanlHa0tKeCtVWGVSUUxQekNVOC9rOWVFdC9NV0tF?=
 =?utf-8?B?Z1lKRW9FMER5c2VpS0txQ1BqV044R0x6NTNVQTBLZXdJMm5oMlBldmtxQURE?=
 =?utf-8?B?ZXd2Z0pRRUQ0SFpHUmJCdjcvSHI1K0w4TnV4bk43T3pKUnIyVGI3RDZrRVJy?=
 =?utf-8?B?N0d0VnkxSEQrQmhmKzZ6WXUxa25HemUxMDlrYTIxL3A3cUM2aVF0VElnVEsr?=
 =?utf-8?B?LzdGVS9LNWx6aXF0NmM1ZlA4MlJNM0F1TXoxRU80MW1LYWVyaG1kanM0TUE4?=
 =?utf-8?B?ZnFyS09MdEVZd3kvVk9YcXBka2xqVXMrYU5lZTArMUVnT1BiYjNEdlJGU2VB?=
 =?utf-8?B?Q2RyZG5La09EN1dQWVBMQlZkT0NQbWNKVlZpaktzWHhrL29pM045ZjAzSDVl?=
 =?utf-8?B?WTJJNG5ZTmpCR3h6OW1BWVJIYzFaTGp5aFBRemh0bFlIMFp6MTg3N2VTdWNS?=
 =?utf-8?B?QTU3bmZWbUcrdHBoZWd1VkwyTWRaTTFGTmIxUWNZcWN3akVkK1I4cktLa3BQ?=
 =?utf-8?B?aW42NHlJdnE0QnhKZ3ZLekJrV1pSbjdaYUphdW5UWW5LZlAyM2ZLN0hQNXI2?=
 =?utf-8?B?WTRySm9hYTlKSHZocTQvUzJpUkhucW9TaHBjaXl3bjlyWmJHNEFjaVc4Uzcr?=
 =?utf-8?B?eVFWVnNwUVNxTjBGeTl5OWY4eVBIMHA0Z0haUUVJdGx4SEZOclZldW1KZmxC?=
 =?utf-8?B?MTBoUzljMGYxbDduME9BcFFkUVJEeXhNck5ad3Btbnl0bUpsRmxwakF2SHVp?=
 =?utf-8?B?aHFkTHFpOW9vM3FkYnNPdExTdlYyLzlpMkp6bmRmSm5xeUMra3VFWEYyWk9U?=
 =?utf-8?B?Z0RWQ0h0S08vL3N4ZmJiWUFJNzgweVFSVUZIV3JYVWV5VDNWNFFYdlFMZ2dF?=
 =?utf-8?Q?gaXyan?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(35042699022)(14060799003)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 08:35:04.0777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d4496f-4250-4fba-6e98-08ddc8faa7f7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6347

Hi Mark,

> > Current futex atomic operations are implemented with ll/sc instructions and
> > clearing PSTATE.PAN.
> >
> > Since Armv9.6, FEAT_LSUI supplies not only load/store instructions but
> > also atomic operation for user memory access in kernel it doesn't need
> > to clear PSTATE.PAN bit anymore.
> >
> > With theses instructions some of futex atomic operations don't need to
> > be implmented with ldxr/stlxr pair instead can be implmented with
> > one atomic operation supplied by FEAT_LSUI.
> >
> > However, some of futex atomic operations still need to use ll/sc way
> > via ldtxr/stltxr supplied by FEAT_LSUI since there is no correspondant
> > atomic instruction or doesn't support word size operation
> > (i.e) eor, cas{mb}t But It's good to work without clearing PSTATE.PAN bit.
>
> That's unfortunate; have we fed back to Arm's architecture folks that we
> care about those cases?

I haven’t done so yet. If you don’t mind,
could you let me know the appropriate person to give the feedback to?

>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/include/asm/futex_lsui.h | 132 ++++++++++++++++++++++++++++
> >  1 file changed, 132 insertions(+)
> >  create mode 100644 arch/arm64/include/asm/futex_lsui.h
>
> This logic is introduced unused, and TBH I don't think this needs to be
> in a separate header.
>
> I reckon it's be better to keep all of this in <asm/futex.h> and rework
> the series to:
>
> (1) Factor out the existing LL/SC logic into separate LL/SC helpers in
>     <asm/futex.h>, with an __llsc_ prefix, called by the existing
>     functions.
>
> (2) Add the new __lsui_ futex operations to <asm/futex.h>, along with
>     code to select between the __llsc_ and __lsui_ versions.
>
> We split the regular atomics different becuase there are *many* generic
> atomic operations, but I don't think it's worthwhile to split the futex
> logic over several headers.
>
> Maybe it's worth having <asm/lsui.h>, but for now I reckon it's best to
> also fold that into <asm/futex.h>, and we can split it out later if we
> need it for something else.

Thanks for your suggestion.
I’ll rework it while keeping this implementation.

Thanks!

--
Sincerely,
Yeoreum Yun

