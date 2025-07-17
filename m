Return-Path: <linux-kernel+bounces-735178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2975B08BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A7D189074D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8129ACCC;
	Thu, 17 Jul 2025 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="A7Sg+Iqj"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE91F9F73;
	Thu, 17 Jul 2025 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752195; cv=fail; b=t9hmPRbknhmiR6qQ97O1r6AcJzbwFKPxQJz4qDrU9vtN4ov1UfqHB5VDIN4ySWZhHprtuf4zVWBmUaLpyaUyhubrwMzVckbaN4gX/7pbKKmqGy/x3yNoMlCHug+vt/K3W7X+ZpCM6PwQ/dKq+0Yl/gJv0/7hWmuSsjBB0OZbFbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752195; c=relaxed/simple;
	bh=xZSNSrPfi2EunylHF7GgQRDlTB2FPqwIXNFkg/Hc+ro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QBYLj74YHgBTTmB47TvWccD7qPFK31M0T+kFcUlfz+iMCr3bt45zRT16EnsS6tsTwEbfNb53sgp1N2Igs6Y+36sdTB8hKX12SJvpl43sw2kZC5BHTxZEzBAgx624ETu/SZYfK1ye28H89ruqnm6QupwpS2SxsZOFI3J3rX+zuhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=A7Sg+Iqj; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHCtu7LlAhn8uDXclIfj95IZnoo3NArC2KyRyZtFGHffPawe1CfcSQzvaped9WSbKZ9FesSGyOmQI9v5u0d5ypi1SSEH6cGu1idhbsDwY9xofjDht2a19CVK4qXiqswuhOSNdQvPR9nj0w+1lh1Y4JypIcufZO1Bo7Thg9vwxXUtzDLyERTGU28eU73QCGCCqlutT/S8pm3pn5KgI4UvnizMjkYC0fYSz0A4DD0tb6XuPanNwF1nM0YMcISbAu8gH0dCUyoIkzBn25sHZpY8+VM1hH/QGfYNWvmcZRkgiyZiUZDLvUVPMzJ9fyqwzOp31WekQoP9Po8zPO667YhHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JIDSbMVStISet5+Md43taIQmwUg+xH4c5TrMMZ+tB0=;
 b=nAY/FthWMHVlV5cfbBTow3ls+DzuaCUpQRR/nZSjciM6lyjDcnQia8zItrag6D/IRiBWzSsO25UBunwb/aIaV515jilAPb2KdtoQfRiMBiFpolAzC4u/r9jOms/Dp0CWlxd7c64o49/N7PU3bptRatb/ljMf7vvoLGJPCHNV4UH9gxJv+vd3Jc9kqxPT8ZngwX4VAO/+Z5gx3lRTfLvutO5pCf3I3IPAXpt5l/Pu4/Mgot5NshNBRqrnvHHSvEtYt5TEAaXJhV+NHpw9BZ0BUBGmDVrGSOULjLvUfh0fOZ9NY+lUfHCACgFJye7bcuRHGY2sb5qtRl/8OS2KipNyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JIDSbMVStISet5+Md43taIQmwUg+xH4c5TrMMZ+tB0=;
 b=A7Sg+IqjDjyAvC8noXIE2Lswa1j+GEXiH4363vqFkFL87wqAcXlzi94JeVLPuEMd8CKQEoEoLzodCQlYhS+6kEjDMAPXJ4QqQaga1ip+b3Fq9ejZ8b+4CPfHA65Lvw/4mzFYWHA8vJk0Wc9PmnKfmlmnbAIfIIlbBy83/+/ivVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB7050.eurprd04.prod.outlook.com (2603:10a6:10:129::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 11:36:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 11:36:28 +0000
Message-ID: <516652b3-efb3-4ff8-aee8-7e7afdf9648e@cherry.de>
Date: Thu, 17 Jul 2025 13:36:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: add RK3588 DP carrier
 from Theobroma Systems
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, damon.ding@rock-chips.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250716185027.2762175-1-heiko@sntech.de>
 <20250716185027.2762175-2-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250716185027.2762175-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0232.eurprd08.prod.outlook.com
 (2603:10a6:802:15::41) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c5b341-8952-4424-548d-08ddc5262aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW5jcWIzRk03SG51NDYraDc0WE9PTFlZUGJDa3dITjJUcEZvRVcrODJXb1pz?=
 =?utf-8?B?N09tU0JhWERmdE5ua1hwKzhOSVVqQVc0d1pkVUcraUt6WnJwQVdmdjFUaHB3?=
 =?utf-8?B?dDczYmh5VDdGdXBEU2kwNFc5SFQ4VFFWdzk1dkJ4bWFIUnZPcW5XejFndTVP?=
 =?utf-8?B?VUI2TkhvZCtvbHQya2dGazhvbGxTZ29QYWdzYytCdVRoN21DVURIMTE3ZFdN?=
 =?utf-8?B?ckFNcnh1THBRYnJlZStQVXBkVzVWcFRiRFNENlRFM0I3Sjc5eUk2a3VsVjFS?=
 =?utf-8?B?OElBYXBwamNuand5OTMzN0lvREIvb3NNc0V0QjVhK29iOVJMRkNFYVg1SVpa?=
 =?utf-8?B?OG5JTzI1YVV6QlJWbzhGR045bjFDRXhiSEZqdmxxcEhmbG9ScUpDQXpCc2h6?=
 =?utf-8?B?cjFNcG1ERGxVemhqelBmMFQ5dWN2NUZmWWswRmxRZTBpSjNwT2FKTkdOQ0VB?=
 =?utf-8?B?bXIzTGEvT2VLNVB2d3ZiQ3hiZENieDdCNkRCZXAzWHFlQXpVMGV2RnNSdHcz?=
 =?utf-8?B?eFVwVzZQYnJkVnYwcVNwdGpPR3ZNZVFreFhFUHU3N1k1ZVZpOUlmRnVPRjMy?=
 =?utf-8?B?MFNPYTNyeFppb3ZFM3dWLzRma3NuelJiRzl5cElWWm1oVUtqdEU4dUFUM2Nt?=
 =?utf-8?B?M3RBN1lObE1IYlM5VlpDRHdsTTFjNnQ2TXRnVkpNVlhSN1B3UDVYWUNRQldP?=
 =?utf-8?B?ODJrUVgwMERSL3JueTgwVUtoaHRzQmVjWXZPNWdlYlFHMDg4NTU3MndMajdO?=
 =?utf-8?B?dUYwdjFuSG1vTWNmYWZKZXUyb1YzVExIbkMxb24rOCt4TFd5djA1Y0Vlb2Z1?=
 =?utf-8?B?Q1dWWjU2NUZ2Q1NjR3FWMlhTNGNlZWJpMWV2ZXZJOGpYVzZtYXdGd3BXMTR3?=
 =?utf-8?B?Z2ppTE1nd1hoNUZIN0QySEg5R1FyVENGQ3gzckJ5YnZwRmhKMU51TlZhcTdX?=
 =?utf-8?B?d1B2TkNZWkgzem1HR1ZwQ0ZXUU96TWp6L2hkekQwQVdaTGNkTzNubDVTVUtK?=
 =?utf-8?B?UEZxWEZwMi9WU3liVXErN0NHWUN4YjlYMmdpSFRXdDJPWllETVhlL3BiTmRr?=
 =?utf-8?B?QUNVbGtGQ2l2RjM3R09BU00zL3VWZmxvSHFVSU1BWXZ1dkRnTG4wUm5uNW4v?=
 =?utf-8?B?eUJXc3pPaXdESU4yc2Vnd2daekYzZGpsNUlIQ0o0aXZLa2VaY0NEdmdERHdq?=
 =?utf-8?B?Qnc2aFIrOVFVMmRYdzNaWkdzY1ZVZnN2RXVPaEFxNVpiQ2FtSUdVeG9lN3hV?=
 =?utf-8?B?ZmhBSkJXVS9NaEg4NWtFenJUd20weThtQlVBOG1ITUtQbzU5YU9CZENPeXhn?=
 =?utf-8?B?SnNVa2d6Mk5RemJxRU5HODZQR3BWS2JiZTlNaXVSUGRZN21Wc2JQa0lrRUE2?=
 =?utf-8?B?ZVl6a0MrN24xTktXRnM2VGRVMlhXL0hDSk5ua0R2OUZ6SlI2MW9hb0tvRzdZ?=
 =?utf-8?B?WE9VQXJnanFTSCs3c2hoeFZKUDMydWpmc3VETG8xRm4rMFlTRzkzQk9Xb0Fy?=
 =?utf-8?B?RjB6eGJpc2tMcW1yZ3h5TE4zeElLSUw3ODlBcFg1THFUS3RtdlNidGR2YU5R?=
 =?utf-8?B?UDdOQUdySTZYMWd5ZVNmZDVNcHlLY1czTjRuQy9WVTVFNlFRSkEwZWZ3VEda?=
 =?utf-8?B?ZU03d0lnQTA1Tk5DZktiN1hQZTVYTlRiZjdhekdqWWJHcnZBNDFOVk9FK1Zx?=
 =?utf-8?B?VEV0MmxEVGFza0E2Y1ZIOVJ0N29NblVEdkVESHFrZS9TVVJ6bGlwMmEyajNI?=
 =?utf-8?B?MFRsNk9DSk43YTdZaEg0YjZMM1lrTlNmclB1bXduSS9rVENNMnArL3NHOFo1?=
 =?utf-8?B?eGc3V0gzdHdqeDV5Q3hPbVY2cWsyUjhWWU5mZkxOb080WW5aQTBzS25TV0V2?=
 =?utf-8?B?U0RIb0pvOVRKMnU3elRjeXpSUU00clJKRDZQRWM1ZGF1d2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R01CWkxIMGk1cVdwS25YRG1INklZUDlETzBBWmliWHJRMWUxTW1oOFNnMyt2?=
 =?utf-8?B?dEFGMzQreHY5NmFVM04ybG5EQlpSQ1NSL2JIcHlLSmZnZklSYytZd1hJTXVh?=
 =?utf-8?B?a3FnRmcwZjZEYk9Bb1l1Ny96aUNwbDR0R1lFM2VZak1TT3ZHM0dGekhYOEpv?=
 =?utf-8?B?ZUpMNzRrV1BYQzY3ZEtKMEpSeFAyTkE0cHdCYjlsWWg5RitIVXovR0J1ZzMr?=
 =?utf-8?B?eHJ3RTVBL3V6MXo3RUNpdm1NTzhqTnliZ3FNL2FzdUxhVEhUczhrNHhCTWNZ?=
 =?utf-8?B?V0YzbDQvaXpGKzUxNnhDeUJ1cm5ZZmFNZEIrMEhkYjFUbWhyUHJsRGJxbWVU?=
 =?utf-8?B?YTkwUm9taGhkRksrdWxkRUhnbENCcGRHdUJQb3B5ZUpVU0VjaTlkQXlHNFRO?=
 =?utf-8?B?U2VvWGhoN2sxNlJTdVdLbVgvWWRzekdQbDBxOWdsMmpuRFMzbHFqUHdQRTVZ?=
 =?utf-8?B?WXNaQnRTWXljTHpZQTVCenFwSERIMkwxbnU1L0swak1FMzRUUjNzcEN4VHY2?=
 =?utf-8?B?WnBtOWVEcnVnR1hXRW1zaU5vSUpETFZSbDMwenM1bWZFdEZlbHk0VzI3d2pN?=
 =?utf-8?B?QndBekNtVGp6MHlGRnNGdWxPQ1hBKzl2U2NUeHZGbmRFNVBJQjUxemtUVVlV?=
 =?utf-8?B?S0VTL1J6M2tNTFBOdGNEY3l5MG1EcjMybWNMNnZ0ZC9JRU5jSkZCR1BaN1E1?=
 =?utf-8?B?OVczMVJMZHVRNEZmZmxxM0VFSlMyeGlxc2VHQ09SbmlhdUtwanFtRXovODRG?=
 =?utf-8?B?MmpvYnZnMVpnT3pOSzdsb3k4Sm9zU2haUW54UzVLZmMvM3FVdnlySjhYOGd1?=
 =?utf-8?B?ckRGemQrVU1CMXJieGRDVXhVQWNOWGRQdHVOcFgrd1JXWHFHSWpBUi9tcVNC?=
 =?utf-8?B?Z01JVFZiNWJndysycTRBeEp2bFBHVy92cXdZYnJ5WXJSRzRBR1N1SUN0c0xZ?=
 =?utf-8?B?eTkwMkIzRUdwSERPT3c3MnBDenh3NE9nZy9Da0NpUFJvR0prSllFSDlaeVV3?=
 =?utf-8?B?Nmt1b2dCdnVTc3dXS2NBNUUvOHhxYjVPbHpYMFVqR0VKU3lTdU9IR2Q5bzNQ?=
 =?utf-8?B?WEFGbVg5d214RFA4U090NHlycFk1TW1kTk41YUdLR0xPQlp5MmtqMnIwMUVW?=
 =?utf-8?B?d2tTZTd0emVqREpBdE1pRjJGeVE3cFZpaHkyR3RxYkFvUVNINU1qK2Y2eWw1?=
 =?utf-8?B?MzFzMWszbjVCcDNSOFYxYmFMMFJjNmxqdmt6aEUya0FaM3NaVkxWKzJQcTBx?=
 =?utf-8?B?YUpOeDAwN2NCYk5TRWFhVE5PSjlPYW5na1kvNVoxcHZSbk8wSlZ6VmRWY3lN?=
 =?utf-8?B?WWdaemlzZXRvSnN2YVowU1RXMlFRY09VV0FCU1MrU3pPbnduYzZFUnlJY0Uv?=
 =?utf-8?B?Q05DR0ZGQmVSbVoxdkl4L25HYjBWYUo2bFExQjNucUxHQ1gzaUFTdXRZcDBx?=
 =?utf-8?B?TGV4R2VKV0R0RFFkVXVwVytDUCtYUzJZYjFQWkt4NVVidU1Qdis3elhueTBx?=
 =?utf-8?B?WjJsd1MyTnhDSlRia0o4YXF1NTVWbWo2LzB5cDVnaEI1djJuQ2pMc1ZLbGhq?=
 =?utf-8?B?WHBPemxMTW1ZSk9jTURoajh0aUY5OW5pb2xabkM2a2hlaHhYRjNTdjVDUFdO?=
 =?utf-8?B?RWVvcjRQRW1UL05JWm9ESDZUa0x6alc5YUQwS1FsQlRoMlV3SVE3eUM5UkpK?=
 =?utf-8?B?MEhGNHlGSmFWSnFidHErcHJOK0hkTVF0V3JhM2d3YU9nR1VKT3hMb3lYMURI?=
 =?utf-8?B?V2NBNXY2blpCbkZWQTZubWFJWnU1cHNXemh6Wndvd1FnSGg2VVNZR0pEYnoy?=
 =?utf-8?B?dDh5RGwzakZNa3BzSTEwTXo1YU9mRUVOdmdFU3RVVFd2Qlc4UDBDMmZPWWJL?=
 =?utf-8?B?QmtYREN4R25uSHgwcE5oNzU2NGZXR1BDamJXaGlRKzFPeGJZdlBzdGozMzhK?=
 =?utf-8?B?Wm1JeGZOMjRMNWpISU1jeDJCS3FnQ1JTWTNXYU04a243WFJFbmRCUGJRQUJB?=
 =?utf-8?B?VWk5VjM5U3FzTnpXMEZyK1FHT0tCVWJqRytpZTJYcXZncU1UU0xPVnNxRDdV?=
 =?utf-8?B?eEhqakxuV1ovNVJhN1lxK0Y5WGxRMmhqV09IbWpnVjBPTjZjN1gxZWtsSi9W?=
 =?utf-8?B?ZzlXV1ZudEdOelUzY0t6ZXlqUndxMXJUVmNVbUZsY01QNWswZnNLZjd4bkp1?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c5b341-8952-4424-548d-08ddc5262aeb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 11:36:28.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNvnWJT89mt9GGTnXTQBm+Oowaskp+CpKo0Fe/KLoi88lqf9Nx+B4TMUgmyQ4pyx3zXJiIByYfW9C1FbpoMD4hyxg5Mn7vium9NSIs7M55o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7050

Hi Heiko,

On 7/16/25 8:50 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The DisplayPort carrier is a very simple baseboard only providing serial,
> ethernet and a displayport output.
> 
> But its main functionality is that it routes the Analogix eDP controller
> to this DisplayPort output, which allows to test that controller simply
> by hooking it up to a suitable monitor.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

