Return-Path: <linux-kernel+bounces-885530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E18C333A4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 961B44E221D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832893469ED;
	Tue,  4 Nov 2025 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ll4g0Fxw"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF638346773;
	Tue,  4 Nov 2025 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295266; cv=fail; b=KyCsoxtDG356f4tFTh5DRYIQirtTxNu2tWuw7um6Mub8vX38jwqT7LPKCba3lf8eEZHbtg607nUy4WY9GudVeWYzXfBEaZ/FM1LAEaFcbIz/ZsoL7EL5Anf0imjmUIJP/ew7eMjumE72HgdRH6Sy6GPVYoi3CM8xoKf42E2aEc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295266; c=relaxed/simple;
	bh=X5cK/1j7XCePCWSKy4elWwFlV0DoKueFj5t9TGrkxrA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GfYVatcZ+JsiXUNRMBFlkyX2B7vDb2KM/ASd0fZ1FVWzBxQGdgOeMtYqlg0mV+sN/tHattTDE0SuqA8T5j91DhewTUsp1IqP2k3uun0rCCVh7uNpsHcGkleNcfrDUhB/EOWUdFzXivK9kI/Bo0NQVwrqRZIQskywHFWgPAMSOXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ll4g0Fxw; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7jxERCFhbOFnbNn15JQEKqUI/y/FzFvvMUwckaOHnmnIcKcHNj7MNWmsbPvSGdkC1b0/tDDit0pMkg2kohnR/Ka8X+my1cC4ByvgUehw8BjN97G6ue1pR3yn+uYZtU6Vu/dDIqAF6aBeGWjAxLKzOUQNnj6nTw1mjm9rVQocsS1NQmiswa7h4HHiauwSj1pwFC/qz9hPrK8Zr/MMhnYo2+Hpy8hkVVtir9yaQxfy8xj5jAKN/JSEbyMqdvusPXrRuw4ra0lT0dafjqFo3FASHgyKiAfng3kWJWuEGHLfzctQpQt4Gdso5eQahY/XqFPzdwYKT6BYH0Af1BGk7I6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7yzZVR7NTkkVuh/bAqCROs+bhOn009DDjs9VO7bHds=;
 b=btFRKUNBVxIi3Ba38hTw0KXoKQ8YTZtMwdozAbAull/e5EFRNNiaU2fvdZNIsPfq4Rxzp6FgEKDwixrBysGwWjrIZ0gENGeBMZ3zPtYpysSGuGTB67ae4rd65eFc/MbCsKbVW7GWJgnhjsGyMpl+x/bUtUU3sRfW81iNFkoUiau2H4K3yqv5CuJUIcgH+arJc7pSNdbPxNplCWQhIaXF4SsmAKa7+RpaIJuuisTKp/Bu2DrbUnDtbAnWZKsNQUpXe493DKxxvPe1BzsNNkIYwMAvph6XXtmd2yC135663LhuYrZqEkZx0RPYRnslR3FZF7LiJeKK/wXazbZBrEjzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7yzZVR7NTkkVuh/bAqCROs+bhOn009DDjs9VO7bHds=;
 b=ll4g0Fxw3Xt1iPzLov//AejYl13VzNvMWnwvh3unAubfCfSoMs4t2KSS2qmb4LM1IGvcl40zXdcB+MXm1bnU2NpsamD/xgBvrlpc4ECLpzdbNy7zXMTJdf7ZtYLV8M0g6Z4trecZQZCKmO8S54ZBto8OL3+2tfsIXV2bwVOhFI2SpMee0bFByjyNranQXwJRYgvMuxDW8mSgf1im9dV/MzYvqe8okXABOC8ZB2unzBiqdyB5QD1O4YzDIV7LobAzHvBZ5HdUDDKSRP8umD5ti8qXJ2/N8Yqh2jXjbwcxjJmjWALem+SOikdsKM1Q4LefY7VoNwTzX6iWNemF75pVJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DBAPR04MB7286.eurprd04.prod.outlook.com (2603:10a6:10:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 22:27:40 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 22:27:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Nov 2025 17:27:14 -0500
Subject: [PATCH 3/3] ARM: dts: imx: move nand related property under nand@0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-gpmi_dts-v1-3-886865393d0f@nxp.com>
References: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
In-Reply-To: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762295246; l=10912;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=X5cK/1j7XCePCWSKy4elWwFlV0DoKueFj5t9TGrkxrA=;
 b=YT3C9t5fAC9uh4B+PC7eVObxQZb7SrkpT7164B8oEh7yTA6Pfsnsp5d217dwKLw69mJ8Gs17B
 m/KHHdWP2LXBnYtkZI086PSsULfXciFIsiY4KTc68KFQBWIIZdPPBNq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::46) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DBAPR04MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b9e80a-228d-4f64-bc46-08de1bf15d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC83NWZRcnhVSVk5TU9WZFFIdlZRZVNIcnlBZkIvWnVnQzFtWXBqb29BYmJD?=
 =?utf-8?B?Rkl6cEZCa2N4ZjFiRjV4TTJyM3dFUnhTVzhWNXVnR0I0VjBFYkgzcXRZVnBn?=
 =?utf-8?B?MVJwR0N5VjJkSG9uVXRqZElUVnVQQ2kzSXNQM2krYVBXbmk5Z2tsNEJ3SHNH?=
 =?utf-8?B?cFBBWFNpdDBiaVdCOUx1MEsxZ0Y2cTNsa2tGRHdsdGg5YnZCUkZ3MlZReEs0?=
 =?utf-8?B?TTh1b3Q0WU1kTDE5eDZ4S2locHcrME9FdFhNc3hPSkdxK3g4Vkg1aXRLaXZi?=
 =?utf-8?B?elJvNyszSk1IQ0IyT3oyU0tQUXVQRWJKT2xTOFEzZnVFcDhacE5iQ0FvaExm?=
 =?utf-8?B?cmNJK2IrVnM0c3ByelpBS2pqMmoxZTVzUHlEejdDWTU1ZDA4QkdvY00wcFJC?=
 =?utf-8?B?MWtJWmpDeXZNSUJvcVh1WDFGa0JyZXc5bFJLaTA1UVZHUG9yRGg1OUtEYjVs?=
 =?utf-8?B?WEd5UVNNd1FHTWJJZmdkKzlvWkdIeWdwN21NRGk5R09mRHpGS0krYk5uOExJ?=
 =?utf-8?B?NWJLTm9RNmtLZzJZTEVGL3pGc0JSOStIekNyOVFyaCsrNjA4TE5FR0IxaHNH?=
 =?utf-8?B?KzlYMEtBWGZCOHNUNmMzZFdmMGVLbHE1MitsS0IzR2ZjN3RnQ2tMWHp3a2xQ?=
 =?utf-8?B?VFgvbzRvUTY0TlhrVytIdk9CM3VseVdEN0NNUVJYVUdsMEhxWVY2SjQ3Vnk0?=
 =?utf-8?B?Z1V5TW9YNGN4Yk9yZ041YndpaFlhcmtWbjcycGlFazl4Z2w4MWZmQ0R1a3hL?=
 =?utf-8?B?c1dBKzYvWVJ1ZDV4L25USGRhMzNxZXB5aW5iejdaNFVRRlFndHl4dFFiYWVP?=
 =?utf-8?B?Y3B0M09yUHpUdWhOOEIyRFk0MTR3ZmJzNEI1dVhXaEVqYXBsMmRCMHpreFN6?=
 =?utf-8?B?U2R0ZW05aVd2VjdYa0Z5am1KRkw0TERhWk1XcWIvcDFHall1TldNaWZGNm9V?=
 =?utf-8?B?ZDhxdUYxMmxQZFlnRmZFN2VWTXpTVTZTcnBoK09VV2tGNmFEYzJKQVl1OGJY?=
 =?utf-8?B?ZlJZVEpPaHFHT0cyckttK1RaQWhXQlFrTTh0Ui9ZSTdLaXQ1QzB4UjNpSUMr?=
 =?utf-8?B?QTA1OHNYUkNnS3E1NWFFS0RLSFUrMlY3bFFQaXRpRnR3M1JKd05vVk9xN3B0?=
 =?utf-8?B?bWl6N0J5ZW5qaDBsV2h6S1J4K2tBUUdaSUxJdDdUTUpOeVFFS2txdldlSmJV?=
 =?utf-8?B?ZzVodGY5ZFlDNnhZMFIvamF1dUZKY3FjVUwrTGQyeHlpbm11RnBRWFd4WTht?=
 =?utf-8?B?WTZIUGQ5Wk9Ma1U1MHBzVFpPNjNwMlhGOHc1WGI4ZDIyc0ZONENsSXFud0Ux?=
 =?utf-8?B?RktlUk51aHFyOTlsaDFQNFZDQWh6UWtINEhMeFM2UXZ0TzVCSEdqUFBOeVA4?=
 =?utf-8?B?cXpGVVNteEFCbHhuNlQxbVhqS0tsWGNNbHNwdEExeWdIVVY1TW9sWnhpYTBU?=
 =?utf-8?B?M05zSjR6NG42ZXNFYlpGL3ZIMEJVTXVrSm9ZMG40NTJvdkFNVzB6WURIN2hy?=
 =?utf-8?B?KzFHUnJaaXZwV1ZXYVlSU244anJZM09VK3JheTVnRkpmMmZaV3BSWkZXUHh0?=
 =?utf-8?B?TVQreE9kT1lyOFd1U0FOaEs1bFkwWG5JejVWWmd1K2F4Y3E3cXh4eVdUczIx?=
 =?utf-8?B?UFdldUZZNGpSN3FaN0JPbGpuSGhFYWkwUmdidEkzZ0lacDJCNnRkaTJPQWth?=
 =?utf-8?B?YjUwQmd6R3IyMUxpb2tHMWQ4c1F3Z1NBR1RXUVZhN0hYMFYrUDJiWi9TT05u?=
 =?utf-8?B?UUhuWGMwRXRabzlCdk81TGE1Vkppc3JLc3ZVOFE0U1pkNmtIU0lMSTNlYWVN?=
 =?utf-8?B?Y3BnbFE2NHdmSkliRXlVb0M3czEwaTh0Q3oySzNIbUxuS3NvVWpqWTZGckJp?=
 =?utf-8?B?ZjVFUlFPcTlCbzRJZ1NkczZFYXByOGdTN2xvUW5NN2ttUjFMT2lSRVMwZnpv?=
 =?utf-8?B?VmgvbmtIbkpGbUdnd2Jzbk1vdlpWOStwTVJveXRVaDBOTU5FOUZhUUk5bzJk?=
 =?utf-8?B?TlBacm45SGxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzAvTnFLRzkxVW5kTEZlaENpWXg0V0pUNFh4cjNWY28vSlpIbC9UeVdIblBo?=
 =?utf-8?B?SFhEVXlRaUNsdjNGNC9jWVFMQmp2Sy92NksxMG5iZXN1TnNpOVdJb0g5aWMw?=
 =?utf-8?B?VUE5YUt0bU9KTUdTUjN1SndWTXovWFc2MVlxclNBUU1FUzJEN291NXY4WVNK?=
 =?utf-8?B?QVdkaDlCMDJVRXNqSVZCZVNDNXd2OHJDbi9seDJnQWU1Q0kvbzNaM1pMUDBt?=
 =?utf-8?B?THFaSGRub3BCRnY0SHN4UVRqOThkMThzekhvN0JVUEY3NGVKb0h5M2dIeFdG?=
 =?utf-8?B?dVN3UFFJYUdRdmYwK0czUy9zSlBHOUlHcUhhUk15WUhnbDNIeGR3WWM4Yjdk?=
 =?utf-8?B?OVVMZ2lvLy8wZGdNanJMK1UwRzNjVUd5dE1qU002dkRpNExnNitWY1QyMWgz?=
 =?utf-8?B?Q09Ua01zb2U2dVU4V1dSQkRycXVsamVSVXlzbThMMDc5dEd5OUlGU3BFUW1a?=
 =?utf-8?B?cXo4Q09VT1YxblpIWTlSME5LTFpFMDdzb2V0UlBFWHZuYnY0dnlqOHlUTGZt?=
 =?utf-8?B?d0VFbDB4WGVyN2U4VThuNjAvUWlMb2xZRXRqVklNcHRBY0JEbUFyaFZPVURY?=
 =?utf-8?B?ZnIrS0VFYjFaS2VJaHdFa2wxQ01OYzZxTGFteVJCUTVVT09DM2oyZFYvNWZj?=
 =?utf-8?B?YThFUWJTSkZXNVdvOWU5RUZPT0M3azZjdkJiUjF3V3B0Y0oyZnkwU3gyRHRa?=
 =?utf-8?B?OUlYV3QrK0lMaVdNUFVLb2JqOC82VnJKM3Q5WUROSUZnei9pNTlDbWdtY1gv?=
 =?utf-8?B?TjRXc2d6RU55VjhBZ2lrN0hxV045VHZOQUJNMDZTd1kyTFBOWDRPT0ZWTnNs?=
 =?utf-8?B?QTQzK3pHR1Z1UDhNYjRCS0VFd0EzRjJZRHlGTmkxcmNXZWdGMDAvNUlvYzBa?=
 =?utf-8?B?djdQYytNUVVMaE9EUE04M3VwWi96ZTN2OUxOQmF0cjl3STFqUW9nSUVJZGxh?=
 =?utf-8?B?eW56ZWxPbEdhakR0cG9kUW9OSDZ1ZTFHb0VDb3pxY1k2UGdqTlFlSGxMMlBQ?=
 =?utf-8?B?RmF0T3VQNisxY3lmbmtXT2I3Ylc2OGpDMWFCNXZVUTNqQTZ1VFprQ00zd2NX?=
 =?utf-8?B?SGx3cHVyQk1sVjlkZkZWKzlNNUdKQkQ5M1JNbC9kYjFUN2kzbjFkaFltb0pG?=
 =?utf-8?B?U3NRRUVsS054K0toRVJQV2NHanNWR25MUnJVRW9jQVNVbUpZTGthWHdqRUsz?=
 =?utf-8?B?UnRvS3FhMEEySGk1MEtxcnF2M2I4N0tQRzNkS1oyOWdKRjBGQW0reWdGcDNZ?=
 =?utf-8?B?Q1NJRVZlME5MTkMzbUthNVVNN2VPT2ZIUDJwRWgyUWh5bjJzQTRneU1ueDNF?=
 =?utf-8?B?T0FzbjM1QXlISGpyS0JvN2tZMkRpdHFqY0UycXhENTYvenp0YXZHOTlRbXZu?=
 =?utf-8?B?UVFtdU1nRDlpVDlWOXhqYS9ZNno0N3h4THFDdklYVXY4MVVQYm9DVXFNZ3hM?=
 =?utf-8?B?WFR5eGNqeEJ1LzZ6amxuZXdMeWJscHR1VkZlTmRzeFk4Vm9VWmI3SllzNG8v?=
 =?utf-8?B?bGowREc1Y2JmdGtZZDlCTmErUHBVNXpiQ3YxaFJpcEVkQyt3VGg3U016UUpW?=
 =?utf-8?B?eDNReWNEUHN6MnlyNmNqRVJlSjVvYTdZakU2WG1oUEdLSVhKMy9qMWczNmhm?=
 =?utf-8?B?cWlYQkx3OUhYQm9tTER0RCtEQUhZUUVmZ0VyVVNnR1F0UHNqanZDZ0dobkRU?=
 =?utf-8?B?ZWxKUEkyRW5xYlFUcjJhdXRKT3dITGVxNTM0ZTNjRHNxajU5eGY0cXBCTU14?=
 =?utf-8?B?b0E0eW1LbHlOeTVMY2czcERVNUI4R0NJc3QxSUtxQ1U5dklsTDg2dkVneHpj?=
 =?utf-8?B?Y2xKT05DUmUzUTUyaG5FeWFhYldjZmRmRTh6R1E0Mi9HOG5NQ20ydUxVUTNl?=
 =?utf-8?B?TzJreGZ2UEFrYUJSeFJLakNmN2tzUEZnbHhYc0Qxa3Z3a3I3YTJXWnRscDFw?=
 =?utf-8?B?V0FSSTB4c3dSUEduMWU2TXpodjh5ODVFK295Q25QYkF6Ni9oTzI2SUlQNVJh?=
 =?utf-8?B?clJTaXlGKzZTTStSZU4zOGg4LzRES3d6ajFNK2UzazFGZjI1T0l5UEl3dkJL?=
 =?utf-8?B?T0FaSFdrdHVpcm9TdmJWN3psZGFqMnZHVktISGxJSlJWSVVTb1A5Ukd2ZTJz?=
 =?utf-8?Q?ZiwCmL7Pl8Uo8TZM4iAL/1xt4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b9e80a-228d-4f64-bc46-08de1bf15d71
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 22:27:40.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miCiSCg7i4rpWfCUwm+lH5x8aLSQI3+elwmaQsvJkSJkbcnH6fUdhyMztXiJUwbCF8FD8tGSnNx53juPeBGa4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7286

Add child node nand@0 and move NAND related property under it to align
modern nand-controller.yaml.

Fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtb: nand-controller@1806000 (fsl,imx6q-gpmi-nand): Unevaluated properties are not allowed ('nand-ecc-mode', 'nand-ecc-step-size', 'nand-ecc-strength', 'nand-on-flash-bbt' were unexpected)
        from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#

Since 2019 year, commit
(212e496935929 dt-bindings: mtd: Add YAML schemas for the generic NAND options)
NAND related property is preferred located under nand@<n> even though only
one NAND chip supported.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi           |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi              |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi      |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi           |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi                |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts                 |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi               |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi  |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi               |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi            | 12 ++++++++----
 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi   | 12 ++++++++----
 arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi      |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts          |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi               |  8 ++++++--
 15 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi
index 547fb141ec0c9f4f2aace5f2095bfbd2d921d2dd..f452764fae00ef801ab0d69879457f9a404bef2e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi
@@ -36,8 +36,12 @@ &clks {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &i2c3 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi
index 9975b6ee433d1daf4ed24bf2b91f167fbaa398ff..58ecdb87c6d404ee3e06501f3bddd029eb9670af 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi
@@ -172,8 +172,12 @@ eth_phy: ethernet-phy@0 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi
index aa9a442852f41b76782c570d28d277e7eb586636..6f3becd33a5b5f83dcc5df3286244fb601eaa537 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi
@@ -102,8 +102,12 @@ ethphy: ethernet-phy@0 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
index 85e278eb201610a1c851c4093025bb205e02a3b3..f2140dd8525f81c9b242cef1e4970baa6462b9b8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
@@ -73,8 +73,12 @@ ethphy: ethernet-phy@3 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "disabled";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &i2c3 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
index c93dbc595ef6eceda5fdf7b90dac57bfed59e489..131a3428ddb86796ed843b46cbae12f5d095b2f4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
@@ -260,10 +260,14 @@ fixed-link {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &i2c3 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
index 57297d6521cf09f1fd629ae375c9994ebb683375..d29adfef5fdba321606eb68614cc82393fea9052 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
@@ -252,9 +252,13 @@ etnphy: ethernet-phy@0 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	fsl,no-blockmark-swap;
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
index 2a6bb5ff808add0d3648480061e136e1050a1ccf..40d530c1dc29f2a679804992b8b41fd05ee7ead3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
@@ -133,8 +133,12 @@ ethphy1: ethernet-phy@1 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
index e34c8cbe36aec682f46ffa128247bc47f3a6cab9..776f6f78ee4631fc154bf261299f687285137413 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
@@ -101,8 +101,12 @@ ethphy0: ethernet-phy@0 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "disabled";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi
index a3ea1b20846253b8c4a5dc3a0ff0d505c24be3ff..27e4d2aec137fc35016428d8b3605ebaed65f490 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi
@@ -63,8 +63,12 @@ ethphy1: ethernet-phy@1 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "disabled";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
index 1992dfb53b45cd308522c3e922d5758f5b8fe527..dc53f9286ffe27c718b8b8bd01169d1ff4ad13af 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
@@ -296,9 +296,13 @@ &fec2 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	fsl,no-blockmark-swap;
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &i2c2 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
index ec3c1e7301f48f6fbf0190a8286d5110ef61c35d..eaed2cbf0c82aa55bb436a03e0eb45be7cf94c5b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
@@ -160,11 +160,15 @@ &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
 	fsl,use-minimum-ecc;
-	nand-on-flash-bbt;
-	nand-ecc-mode = "hw";
-	nand-ecc-strength = <8>;
-	nand-ecc-step-size = <512>;
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <8>;
+		nand-ecc-step-size = <512>;
+	};
 };
 
 /* I2C3_SDA/SCL on SODIMM 194/196 (e.g. RTC on carrier board) */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi
index 43518bf0760249831781dc5220fa640eabf16d14..3dfd43b320553c45e22e4862cb1299c11eee1dfd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi
@@ -43,11 +43,15 @@ ethphy0: ethernet-phy@0 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-ecc-mode = "hw";
-	nand-ecc-strength = <0>;
-	nand-ecc-step-size = <0>;
-	nand-on-flash-bbt;
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <0>;
+		nand-ecc-step-size = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi
index 83b9de17cee2de37c15a461ddbdc74f0aee2e34c..fc298f57bfff349fe51983baae19c58d7e99f1aa 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi
@@ -60,8 +60,12 @@ ethphy0: ethernet-phy@0 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "disabled";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &uart1 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
index 2d9f495660c9a329dcfb15d04864690efbd1cb7f..8ec18eae98a46abbf3d0a81cca2c5bd24765fcb6 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
@@ -25,8 +25,12 @@ usdhc2_pwrseq: usdhc2-pwrseq {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-on-flash-bbt;
+	};
 };
 
 &snvs_poweroff {
diff --git a/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
index 8666dcd7fe974699354beba7a04844fd0a2cd27f..a41dc4edfc0ddc34ff235d6ba9964120fe56fe27 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
@@ -375,10 +375,14 @@ &gpio7 {
 /* NAND on such SKUs */
 &gpmi {
 	fsl,use-minimum-ecc;
-	nand-ecc-mode = "hw";
-	nand-on-flash-bbt;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
+
+	nand@0 {
+		reg = <0>;
+		nand-ecc-mode = "hw";
+		nand-on-flash-bbt;
+	};
 };
 
 /* On-module Power I2C */

-- 
2.34.1


