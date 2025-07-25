Return-Path: <linux-kernel+bounces-745781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E2B11E82
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCD9543514
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2A2EA143;
	Fri, 25 Jul 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="elK6DmuE"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4886248F7E;
	Fri, 25 Jul 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446561; cv=fail; b=XybY2eU+CXLRjG95fhpFTfRXODEdnhwo/Ca4mrojII02zekLPm6Ey9OamySrAKMzQqCN7Y1uxoSC9Ca2xy+yXu3R8J4h3SOiS0UAoNLr4aOYI76xUmOIi96Tsb2cJS/GfYvffm8G6UwMWUgGkNf2NmXlVx0MiFMnLXe52MD9aNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446561; c=relaxed/simple;
	bh=W27QUXkDk6VG0tVvKtESVIHjjQoLJ/GTArcSlPjtk28=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tKpn5SESbRdpwALgfxqLMwNakGgvzhd5c645FOfHLRoIiXNKadwBG9nd0WKVWfu/nsPvko2UqxpKAWSxMgQ8Wot9JKhk3HYjZGnTliaKj4YeisT6ZaINB/ij6u8lG9RYIVcKCSR37HsiK5pBoikO32DK7Hek8oqfrKp4vAJIIro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=elK6DmuE; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZyQkYOOTfn8BpNW784jBWx0Zl96BJzyjwgE8Zea03CifiFrM1zE9TLlAYOVLcIgDyovBmx7e2rXcZxKU/mtnJEnQoazWgdBjT/1c85QbJJbWKW5v72apz8+WmOFAvu3n9wdqiolzgxilXLcphfvFhzEU25PUBLp+/QUaUIW+lxvNU1RpxGhwAPOG+StrGXmoc6+0ZycqJBqGrlw3fuyIvMH/S/IcfqdsYL0rd4EqC4NUtow83Hmgm/MOd65JdP+24R+WJSGlwgXetNLzgb5rL0iWD8lXE4/v9TO2hcsFI17U4Un1VO5pXhherUfBHqsn7WVbrOZj8Ra+UdC9PH/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO1UNy8vi1mO9ds9anWXtvrzcU7wpwwaqlPc84srTFs=;
 b=qY29Lgpmen3fUdHZzbt5GNDFXDCZue5PTHvgELt+BeuMGUa9EdAMob4ksf7XFGMEM5+Oa0JzG1/A1+j5m4DhJPxlN2nK4F7zbSWaLHLtaI9Cf/xAVSJKsq/SPE8WO2/yvi3YWEuaX3/XhO/RGPrB/2nLsHXRCA1cb9o/dNSo9RH+2Ujp/osp0/ZLrSCTqBt/eQdVhTgvgcJWKtHMRfaJfdoeOX8Lm/GQOuMy+QGfeBpKtS+TpNtF4S6FWYOUd5w4e9Ux7c3ZtuHbae3RP//dzEd9lcP10ojwOIy5J8JLn/d445AmUI6Rs4rqCQzVKOzgV9+bhRWjuI20lohzJWs8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO1UNy8vi1mO9ds9anWXtvrzcU7wpwwaqlPc84srTFs=;
 b=elK6DmuER9Hhk4lkgv0SMgrNpSNBFEE3y478PUdqFlmJNwxHnt1T8aAWU2zbD7kc4AxsvWUhtvUXIqdVjMv1JqGTbyA+SmYze43K/yGyT4POYXLp/3rUHM29TI0+lIJpjPPU+VcXyZf9su8mHsThVYyESsXVSwpTrr5vHVfWkK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10147.eurprd04.prod.outlook.com (2603:10a6:800:21e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 12:29:14 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 12:29:14 +0000
Message-ID: <0582b7bc-e5b2-4b5e-821e-8d2c4301579f@cherry.de>
Date: Fri, 25 Jul 2025 14:29:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: add RK3588 DP carrier from
 Theobroma Systems
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 damon.ding@rock-chips.com, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250723190904.37792-1-heiko@sntech.de>
 <20250723190904.37792-3-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250723190904.37792-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10147:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aaefa72-38cc-4928-3794-08ddcb76dd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STl2QXFtbnNxOFliVnNBU0MvdXB1UG9DSDlWRldMTlZrVU5zUitkU3RvajIv?=
 =?utf-8?B?UkhiYm0wRWtPT0toUmwxakpzVnVWRDQ2N1RraldtWmdEU2RHY1lLUVU4TlBG?=
 =?utf-8?B?eU1CQm96ZlJjNUNUVFNVOSt2OHNYR0d1UkhCSHQyMzRHcElXMlBRTkc5dllM?=
 =?utf-8?B?ZFB4djViTFZoSEZqYnYzY0ZvMVdRZXlZM1g4MHNVZ3l2LzFaeXdUeFVKalZW?=
 =?utf-8?B?S3l6RDNXRDFBVjVtcWYrdHN6OUJhNHppOTdBS3hGOThqQkwzdVl0bDJlV3Jx?=
 =?utf-8?B?OUVoa0RjUzRmcHR2VlNUVXFQbVNLeVJLeWV1cGw5RitqQ0NNdzB6emVwalpF?=
 =?utf-8?B?RGNrMTZoTi8wa2xkaTMrVDZzUzdrSHloZlhWT3hoS2NzN1BndmdORW44aHZa?=
 =?utf-8?B?NUg3eVQvTHVoZVhHczA1NDhLQlNBOXBVMW9sTDhabkVJWFZRM1B1M01tTS9Y?=
 =?utf-8?B?ZUdPajNCRS9aUTZ2Y3MrNVJUaVo5V0E5cExEWTM0N3ZIbW40dFpDSzI0UHkw?=
 =?utf-8?B?MnQvOE1wWE8rRTU2ZURhUEIzUTBEbTJvL3hJRGtxbWkyOS9aL0FRQ0tMU1Vm?=
 =?utf-8?B?Mm91RExlVzJwdi9Fd1RKYXIyS0ZGN09DTGpDQlNpL0ljNitSNExhRnpEcm0x?=
 =?utf-8?B?SVBOWi94MFB5YmNUYmxYdnB2VGtzMmRiNkFROHhOeEdjRVBWVmFiU21zeFoz?=
 =?utf-8?B?cHpIbEMwNktBay9EWjBYeUhpSUVnczlSeGw5c2RJcHYrV21NNVk2UjFBbmFh?=
 =?utf-8?B?dlZ6Sjc2VS80OGVnZitwaVJzY0dQZklUMkwrTTlpSWZtNjhQL3h3M2QyUUpO?=
 =?utf-8?B?UkdDSklsUW9lMVZHenp6VjhLYXBUNFZvbFIrTGxTb3VXdjdVZWxBQm1mWVd0?=
 =?utf-8?B?dVJkeXBZKytwdTA0VnRjZUl5di9IbkNsYmk0U1R4RnNMRjBOdHZUZ0FMNytz?=
 =?utf-8?B?ZC8rVXlBNEllUm9zTk4xa0dEUHd5alJXcmVmSnA5eE9UelhRUEVJVGpxS2dq?=
 =?utf-8?B?L1crOWE3akJFMFJkTDhVMERSMklMd2pIRDB6R0VtSVpMQ1p3cWhmT0dTaXNK?=
 =?utf-8?B?dEYwWmlIdVN2MFdRTTlvNjNrL3lJU3BwOTN0Z0dGS2UzZGlyWTdZUW1PV1My?=
 =?utf-8?B?RWdaM2puQVA1WDRkUUxvRHREWTRkQTBSTTZpamNhTElhc3pLOG5yRi9ieXN4?=
 =?utf-8?B?WXZvZ3VyYndPYW5kT2Rhb3g1cWpyVmd1WFp1LzVEWllSUmxkQ2hlbDVJSE1N?=
 =?utf-8?B?aXoyQzlxcEZqSWVLMGZZSFNmUlJhaW0yZFZKVTRnNWEvaTFxbW5EcWcyVnJu?=
 =?utf-8?B?U0hOaUFPU2ZsYW9BK2VhWm0yVkFIUE5zSDZjT1JySnNZZFQ0UXBCWk5WeDRY?=
 =?utf-8?B?T2RPOE1PQmNTY01vUHh5VEc4YnAwaW1SK3hUZnl0aS8xUTRBN3BqWnhCN2dl?=
 =?utf-8?B?bEhmVVVnVTFJTUN0emIzSENMUncyWFY0SFp6dWhUNmdYcjgvamxWUCtxSEFm?=
 =?utf-8?B?VHduV3lKRUZja3dwcmtTZkJFVExkZlVVakcyWFpjakFiWStLWFNSbEw5cURT?=
 =?utf-8?B?QldDemMwS2t5bTd4cmxvaEZvdmh3TmgyNm5zamdtREZvcTI5bnZlREFZVG13?=
 =?utf-8?B?WG94R1RzQW0rUTJabm5jSUVYWFZuUHk0MHFlTzYvbkdTblVSVFJXNS80VUJt?=
 =?utf-8?B?M2d3bkNLcHMwMEYwMnlCZXlsUXdlaUtqaS94ZG1xUk9yOWVKVXB5aWZsQWtZ?=
 =?utf-8?B?cVR5S1FhNVRtMnlsUWg3b0p1NVVGTkdtaDVLUmEycC9YT3NOTWJocWUwRkI1?=
 =?utf-8?Q?5hEHQxFNQRXZj7XO+f4bsB3UBNWzOtIYELnCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlBNZCtPdWtBQURVNWtEbkhVRVdENStkdEM4ZWw3eEtQTWQzZm9Tc0VpelB6?=
 =?utf-8?B?WWtabzJMM0l1cHp1UmJhQVBRMjBBbHBGbGoyQWV4Y0Z2ZlIyQ1ZaMzVudS9F?=
 =?utf-8?B?ays0eVRKc0hLWkltRFNORUlzeHQraCtkOWJrWGQwRjlpRnRTemowd25nclVY?=
 =?utf-8?B?OThxUnVyMFI3bTBqS0o0TFZ4UUFxcmpUOFVaY1lVejhVai9qdDBlN2thUHhn?=
 =?utf-8?B?VUdDSkJEL1MzNmRSQWdtT2xad0o4TTlUVWc3SHF5ZytIdE5Kb3FkVkcvUGpM?=
 =?utf-8?B?bXpkb1BnOTltb2ppMGdaZ21rL3cySnY3Nit3S29zVWNwakJMOVdpMGdTblZp?=
 =?utf-8?B?SXVoeGZUVHY1UDQxSXA3UmF0cjEybHFSaHc3TmFlMXBNdTYwSzlCempsUCt1?=
 =?utf-8?B?czl6MnZQcmtKdmhzWHY5T3BtalJKRW1wZFFLUmYxdnpmZTczWnhnZHI0dWlr?=
 =?utf-8?B?YThHRjMzYUd4anFxWUM1NFBmbVYvbnduVXFpeGg1WUt3WE9FZ1hvWXc3ZlVy?=
 =?utf-8?B?d09GOVNSNzdLS3JSVzhNd1FOcGJZbWZwVGdZWFdsM20wZnVkVWtnUkdIcTY2?=
 =?utf-8?B?c2trZjc1YmpjZE9vc0pMYW5GWFZHUFhVNFV4OHhkSUc0ZmtwVUcxTmJqRlhm?=
 =?utf-8?B?bXluc09qNzJvNm80R1NtWEU2YWRmMWpPUWhUdXQ0VUtWRFltSEZzY1hLZWVw?=
 =?utf-8?B?ZmlWR0pMNHNUWm45ZzdpOVlDRDE5NEltcFBacy9vRzNQUFlJdUN0K2UwYWNw?=
 =?utf-8?B?azFscm9PZkZYVG9aRjFaOWNrcldNRVdycDU1MzBtQTFpaFVKSGhHZjdoYmtP?=
 =?utf-8?B?d1BHTzJaRzlkaEFxY2VYNmFNam8zSExObEJZZXNvYWJhcisvVFV1ZHJtbUNp?=
 =?utf-8?B?K01LY2svZWhVSEVwNUZKQ2JZUkZWMnduOUNpSHd6VHlqYUpIOXR3WEpUVzBQ?=
 =?utf-8?B?ekplcmxsVVVJS1hCb0c0bUNzaUxxSDkyNW1CMHdlQVRONjNCU2k1dnhDUmli?=
 =?utf-8?B?SDJnUXVKSmFaYWFWUDYrL2R3SVlrUWF1VUgyWnZBeWJkbitxdzIzeEZUVlAr?=
 =?utf-8?B?WVN5UlpMN2JMY21TMndoOE1DVjVqcXZNZXoydGdOaHBZTnpYZnp0a3htRWls?=
 =?utf-8?B?VWtvWTBONkI3ejdPWVgxWCt5Tk0zT21iQmVXYWhGZHhuanlCbHE4Z0UvQ2Jt?=
 =?utf-8?B?U0ZnMlU4cmpsT0t4bENidlBxRDhaUzd2MXBzV2ZDSUp2UGdmMDl5VGdIbkRl?=
 =?utf-8?B?VXVBRCtxc2FwK0tDdTgwdURQQnozTnVESG1zZHJZOVdTbVNOMHZuZEhUUmhm?=
 =?utf-8?B?Q1U3SC9pK3pONDNlVURJa0cxWEEyTEtrUGIxVGQvV3U0d3hEM2hTRXl5K0FD?=
 =?utf-8?B?aXBMdkk3Rk03SXFDU0JEWGg1MlZmS3h4eThSVG5JUWgyVHYwYXJUVzJCcVd2?=
 =?utf-8?B?MS9jK2ZRbEtGQm5RS05LdnNiTkJIdURXeENlMjJBdkpPYStpb0hmR2F5eTVv?=
 =?utf-8?B?VFFWWnlWYlptMFBwWWN6SlhJQzB1MXVycDdDY2wrbVljSmNyQTJSenNXNGZ6?=
 =?utf-8?B?d2U2VlAxOEZEdjVUcGdJK2lMZjFUaWhjZkpzNE1nLzFsZ2RzYkdOR3dFdWVu?=
 =?utf-8?B?b2VOa2VpNnBVdzdIY1JxaVczOWZuTHJycG9MWk5odDM3bkhsMFc5UXVybWJB?=
 =?utf-8?B?ZXZ4aGhGRjRXTHFUT2EwcUJUM3NWaXVnQ2Nra1h0dXpoRzV3UnRSOVN0TWRa?=
 =?utf-8?B?YmZlVThINk44VW5FUVFDWTAyOTIrOU9VYkdINUNiREgzQXhjUzl4dFYwUkZ5?=
 =?utf-8?B?ZkRxWitVVDVxVW9Za295Mk9WNzhSbmxja2ZnVUI2YWtHYUE1ZUUzZWJzQmhC?=
 =?utf-8?B?QlZhd3NuWExYclkrQTAzMGhsakR4V1BNTkdkSVgrNUVZZVgxaE5wK1Rzd3pw?=
 =?utf-8?B?ZjBUdDlmcDRNcTJsOFdlcEhBcVZYM2w0TG5rWXNxbS95eDh3ZGl3aDNoNUJN?=
 =?utf-8?B?VmR5N3hOUjY3eG9OaS9ncmFRaE5lc3NTTXdOSkxLaHJzRHZ1QUtQc2k0ZUw3?=
 =?utf-8?B?NC9BQ1FCeGRWS2xpYlUxOW1tUUhMZXRHVVNXRDlYeHVBMDVEbkhYY1k0cEZh?=
 =?utf-8?B?K2t4ZitjajNlVURXTTg4enlUdmF1WlpTUWt1a05hY202K2VnaFRHZUdBWlpP?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaefa72-38cc-4928-3794-08ddcb76dd88
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:29:14.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld6K8U/f4AIhNYAqA+DH8dWnoNwe6LFk9rV8/VY9b/rQc7qyR0VcW6Vgqu6nKVRtsug84ViKCSiU+rkaHVCoqKkHCSDo3hbXxgjffWogBLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10147

Hi Heiko,

On 7/23/25 9:09 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The DisplayPort carrier is a very simple baseboard only providing serial,
> ethernet and a displayport output.
> 
> But its main functionality is that it routes the Analogix eDP controller
> to this DisplayPort output, which allows to test that controller simply
> by hooking it up to a suitable monitor.
> 
> The Analogix-DP controller supports eDP 1.3 and DP 1.2, so can drive
> both eDP displays as well as full DP monitors. It does not support DP+
> so passive DP-to-HDMI adapters won't work.
> 

I tested this on master (2942242dde896) + v2 of the eDP driver as listed 
in the cover letter, or with v3 of the eDP driver + 
48f05c3b4b701ae7687fd44d462c88b7ac67e952 and in both cases I have weird 
behaviors.

First, `reboot` is stuck for a very long time before actually rebooting. 
I think you have a stacktrace when you tried yourself, I don't so cannot 
send one.

Also, I tested on two different DP displays, one has a green tint, the 
other one purple. When trying out other resolutions with modetest, the 
kernel would often crash (no trace, just nothing on console, SSH dead). 
Note that the same HW setup with downstream kernel from 
https://git.theobroma-systems.com/tiger-linux.git/log/?h=linux-6.1-stan-rkr3.2-tiger 
works just fine. I would assume this has nothing to do with this Device 
Tree patch here but rather the eDP patches missing some bits maybe?

@Damon do you have some idea?

The display with green tint is a Iiyama ProLite XU2294HSU and the one 
with the purple tint is a Dell P2319H if that helps.

modetest output: https://paste.debian.net/1387797/.
modetest output with downstream kernel: https://paste.debian.net/1387798/

The Device Tree looks good to me otherwise.

Cheers,
Quentin

