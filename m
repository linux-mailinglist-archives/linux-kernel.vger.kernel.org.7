Return-Path: <linux-kernel+bounces-793770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107EBB3D7FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A787ADDC7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 03:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3641D22332E;
	Mon,  1 Sep 2025 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oB5W/JJe"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D0221F1F;
	Mon,  1 Sep 2025 03:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698736; cv=fail; b=mea7CL2xrK9GRT49UoxsbgUJczSzdhMxKeXESGmR4K50LxBu9SBb4E54YoCr2OeKcmMlftHPN065rH4IbAAWcCAS356sh1p3Kgxq1MWdGgGj0peojhM3yBJXZNiL1DPwOFb/sYZl47NOen765D2cfXKY5UVZRwLgWSVB9yDn+uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698736; c=relaxed/simple;
	bh=xdAZRFXjDhckzNChJzCsHlA5d0hkoE+T/h/5KNZVjdw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=E86jtArthu2BXybseUlo2ofuUtPXXREFb2nehiB/ACK5Rxs7ExWiOCMrb4CO82pLB2Bdu3J3hVxtbhAOzeLN2abz8Ed8LuV2k2vuaYGniObfPP9Y0QyrRw73UtMULrBOU7BnwH3xKGG0Mx5uOOW61V2uFORXCRFUqUPL6go1EGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oB5W/JJe; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pE5LZtAjwDYiXIVJq7UwqXheimucrqCKskxAh6aFVH5kdxcXlhhVGSPiKX+C8NFECJdRZo9odECbzMsbBD6qYUcOILv2/FW+po0miHbvPYelVOdoi15z+MuxGAp3UfavFENPObOVLyP3j2bn5ovzvHWIAkrGVysT0ELKxPKMCpD5u1KUUVxsCj8FutnQHniVdKOgjuaRfxu5pJXOtaWYOGIbhcO3VlMK2cUPoVmp12iUXEerkL4EVBN3OkoyAV6qZG0WNypjo2KCwqWWy2u7/RtGS9ddfYCMVBsXmqqDAmOkBnU9FRutxGN3JWddzS5RYQuMp1SoR0Icen/NRXIfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnzIUpiffHlLh5wE2jNETZBlConDUb7Ua8eBP8keixU=;
 b=CGtsJgxeIbIMRj5V3Ap3M646TQYG3tZmx85s0V3vDTxf3DFcUb88TvYWkKRC5ujrb3OO9hAsaO1xz9d/uxjbL1rmH1ogVd8RCqKuS5aC5dDInDNBfWvEgNn0pun/g7+fXtKAd1BThB08+TfW5By2EHeUdbecFVDIUyLpx0k3ZIBnjWiIptfWGfxf8RQvSwxXTSrHIuczHxq4om9TpAWqXms0sqQvyhhJ2FZUEV9WFRwHSfzV8FlPimf7egcwdPCHuq7Q33Q2lDCM9P3yUSHdqq1EUD/i3iNuzSML6zXF+m19Fgo1NaviZIj8E25PxzLRaiRjD0Qd8X/EdUqCxP/j1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnzIUpiffHlLh5wE2jNETZBlConDUb7Ua8eBP8keixU=;
 b=oB5W/JJesQWuxbkP6I3KKzKgY+Xffnafc3iWfheLymOXU0tOHejWtQT+DhImdswL+4LT00PyxMz2Vco5j2elsMDs7UtPiaMMdUo7Lky/SSLS57y8vU+Ta1WrbjZrtyX5Gn0p8n0mVZpBNreUbp+Vr6mZ4U2p30N0NURYVwTehFNVfZwSpPzJhc3quPGdUySaoa8yj81BzIVmgOgI1Mt4vgugpRDORkXxNcpvHfDgBciJVJv4c3XLaBT8MuCln8f1wkt7XxvwHvKvx0m8huEneBxv12AkoR3t/x9HoewiFMW1aWMTEVrsPIRN4kU+dozjh0yRGQgs5jV7myVTEZkLgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11358.eurprd04.prod.outlook.com (2603:10a6:102:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:52:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:52:11 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 01 Sep 2025 11:51:46 +0800
Subject: [PATCH v2 2/3] clk: conf: Support assigned-clock-sscs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-clk-ssc-version1-v2-2-1d0a486dffe6@nxp.com>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
In-Reply-To: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: Brian Masney <bmasney@redhat.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756698713; l=2948;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xdAZRFXjDhckzNChJzCsHlA5d0hkoE+T/h/5KNZVjdw=;
 b=iqWq/EiFDf9eWMdnixcNt7HAM2GevQcrdaGObeADYkhO24VoVwwvBmNtEMf7WzT9DcHHho+My
 rb539/jDbBSBwSFuLjHg5TZPB0VH4ZMybUmOK/TuQNPj3FJLP7+zEuD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11358:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bc1202-6ee8-4970-626f-08dde90aed92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWllaGxpbFpzTm0yZm00Ui9VSE5Ia3JTejJWY2kwQk8yQTVzRFhNNnh4Z3FB?=
 =?utf-8?B?UTg2SlJRQ1Z1TmgxajA3Ny9PaWFsck5KZzNmTEVTSHBUZ0ZVaUQzTjRiNDhl?=
 =?utf-8?B?WTk0dGlwVTJXYm00RnpVNzkwd3RaelFkQ29Zb0ZiUHlmd1hPamNJMWRBalYr?=
 =?utf-8?B?c2ZiZTJSU1FzbXJrck8rQWFybkhQbE1LMXJlV2p2TVBwTTNFakxJY3hQMzVR?=
 =?utf-8?B?VitvcTFGV2Zvdjd2OHB0a0V2TUorUWZCRUJCOE9HV1RLU2lGMWFGQXo4eXA2?=
 =?utf-8?B?TmhFMk9QU2ZBVnFjS1A2cFdBL2VTbEtnN3cwemFDeWhubW51VzEzOXpOa3Vk?=
 =?utf-8?B?enZ1bDRDd21OUG1pcUpSWFI5RjY2WTBSVFEwR01FTklyUHNqNWFrOWgyMDQr?=
 =?utf-8?B?QzdYN2U5NnkvNkwyMW1hMDlYaGNjUldMSEh5bnpvM0hkYXpGbk8xTk9sdHVh?=
 =?utf-8?B?bGh2dzlsWlVTVkRoYzZiTFFvR01ETzJadlFpa3BBWWExaFhEcGI5cXQ0Sk1l?=
 =?utf-8?B?a0pvMkt5bDNEMEk4eXowZXJEZGI3ZTdsb1QwVHQ5K2hiZGNBSEkzTmNPRmp1?=
 =?utf-8?B?c3JHRG9HTDBoNkZ3UHNIcXkrNDBzYmMyd2tIdmYvcmVqbG8yY2NDQ0JrQVJx?=
 =?utf-8?B?dmtRM0JBaWdMZmRETzdhdDBKL01CM0Z0UlJQT0MrZW5rOEpzRGhIRUFKMXo0?=
 =?utf-8?B?dUVqS2MveTl2UnpXV0xxeC9ueVdzd2RabEl4MGNRSWkyQmh2Zmc5eXovMTYw?=
 =?utf-8?B?K2ZVMlczdGFiYnpXZS9IOUJ2Zy9UcEpkYWlreE9iSExpbnp5MmNKakZDZUIr?=
 =?utf-8?B?SlVSY2xFSUt6VjVjNFJFd1QyaUtEQlNEQjk3ajFqS09HbXp5SE9EUHRIRjNo?=
 =?utf-8?B?akZGQW5YbHlVdytUVzFPM05oV2Y1aTIvNTAyVVUwSzJoK3Q4aEpidE1WOGdy?=
 =?utf-8?B?a3lVZ2d3bEpxWUZ3MEZDL3ByVVVCWTZpSHdNaWhLeXNPRDJRL3l6WUpLdyt6?=
 =?utf-8?B?YzA2ajhUSURiQStzUWM5OGcyd1ViNlF2S0VRRFlPN0NpZU1HcTU2b3VnSlF6?=
 =?utf-8?B?Qk1nWm1RSzQxYy8yVjREd1YzNjNBWWl2dTVCYUNZZ3NZT0FYSzdpMVpzUU5H?=
 =?utf-8?B?ZGJRWE91ekZzaHRqMTR5QTlDblZXbHNBTTBZOXFxZ1E3N0s3OEkxazg3U2l3?=
 =?utf-8?B?Z09SZnRGZ0RRT0loblNWMDg5M045a3NuQ3JTSGhuRzJTcUswMFRZaVR6eDJt?=
 =?utf-8?B?Mk9KZS9CYkgxV3JxM3ZHMFRmYmRMZ2lvc0hnbmlmb2IxWXNYYnJXYXVOT0xS?=
 =?utf-8?B?UXFSM1A0QmM2di9wOXpCQzY0VjZtRWZWcXZCd0FnT3BBa3kvOE8zNEptazkx?=
 =?utf-8?B?T0Z0RDVzQTBzQWk3RklEei9TU3FGYjg1VnpEcG9Fc0dXQlJWcTRLbER6YlVK?=
 =?utf-8?B?UDZWakxRalYrRDB0WjljUDlhWk55K09GS0ErQ2M0T2xTdEFDUWY2M0dxUWk1?=
 =?utf-8?B?aGZrcG9vUWE5SjF4ZTBDUkdVSkhibWppN1IzWEo2QjlvalozZytuNG9UKzJO?=
 =?utf-8?B?T0VqWFl3dEJjQTBMemZIUEtESWE5dnc4QWd3KzNRYThHcS9iaFcyd0NJR1R0?=
 =?utf-8?B?bUZMRmFIZEZhdWZ0NzBLN1Z5cncxZ0Y5NEpsekN5aUR2Q3J4Wk4vOEYzL2Z2?=
 =?utf-8?B?R3VnY2d0QWkwUjJsM29taVpWc3NyOGUzbVlWUnFIVDNTNDcxTXdDbGZjMGRS?=
 =?utf-8?B?c3hINnY4bmRqVCs3OFc2S0FJQmV2cUM3SzhSdU1EcEFTc204VThmVTd3TDN6?=
 =?utf-8?B?RzZHT0hiQTFsSWpsWG5IR0RHbHpPbmVZZkoxTjl3a3RFai9OQm0zSHpPS0NK?=
 =?utf-8?B?TnB4eG1kR1o4ZjJHaTc2NE02RkNUM09qMmlxODNFYTZZa0NrclJEdU9rRnA5?=
 =?utf-8?B?WkJrc1EvWnNlLzd0NytidUwxTGZQOE1nK2dWY1pxczF5OWVzeXAxTDUyaVdz?=
 =?utf-8?B?Mm43SGdkbkhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3VOY2hPQmM3OWhvckd3MVYzVkROTDM4NllDVUs3WUhaYWwraUZiS0xJdWlG?=
 =?utf-8?B?ME9qekNNUlVqaVkvSXFET0RTNXVFNnI2M3ZpVHVkTmRtcUpucGFLSWxjRFNp?=
 =?utf-8?B?QTFaeVEveWR5TkVJSUtwaXNGUC9jRFZ0emQ5cy9KUXBzM2s5VlVEZWQ5Mk1O?=
 =?utf-8?B?aUJTNjVSWSs3MTZrbS9XV2drbUZ6enQvZzFSdU51cExqaHdUTG9nMzdQd2RX?=
 =?utf-8?B?TmtIUTZmUUt0NDJ5bG8yZkkrKy9RYUVqMWY3WUxNU2FIMzBocDNsUXZiWncz?=
 =?utf-8?B?aERKZEdBbTlWRy85VUUyRmFUQWs3M1NpTlllQ2h4S3Y3bG9qcm5qTmxXTEpN?=
 =?utf-8?B?NCtoUzkyR3pQM05NUTJxckFuL2xIUTU2a1RsQ2FQQkVLQ3YwOEJ5ejdUYisx?=
 =?utf-8?B?b3R0Q2NKdGV3YUZqVllpTDdxRld5VnBTekJGeU5hTUNiTGExTVlpbU15NWtX?=
 =?utf-8?B?YlA3NVRpRGtOUTUvREhIVnR1UWREQzhQQU5JaFhBSlNhYVovSnFsMldKeFRw?=
 =?utf-8?B?dWhoRVlQaFNyaXZwdFpzMVVTaUd4U1JZNXJNeGRBTEFWTERrcTUxbTY2VEYw?=
 =?utf-8?B?YXY1QVdTOEt5WC82ZklBTTVkWmpTczl0UkdBRkdHSzY4YnVQR3FjaWpmK05o?=
 =?utf-8?B?V2FHL2NVTGxtWU9xNnkreWdXcm5rTy9BeThpdk9IdGVqVnFmdnhmc3ViSEdy?=
 =?utf-8?B?SVZ6WCs5bjJyNVBmeHNxbnRtNVhjMU5wVVMwM1dMQWdqRWtBR3RKa0lCZzZ4?=
 =?utf-8?B?UVpWbHlNUklncmJVd3IvcVRIRWE5U1lkOGFjYzlWck5HWWNlTktkcXBOWm5u?=
 =?utf-8?B?MWpRNWppVjZDeVZaR3YyVTlKZjkreGlXSzlCb09JZkJFYjZUamZPYVFOOGVR?=
 =?utf-8?B?VGFhUFZpWlB3cXFRajI1SjNyUXhKMDJpczZkd1ZXam1oT3g4M2g2UGdhdnBj?=
 =?utf-8?B?Qlk4R1JhK200Nm5CQ2JoVDJsL0FJMUg0SXNQOS9wUklJMFNlS2dUQy9IMHdC?=
 =?utf-8?B?bVVrVFQwQ0d5M1dkV2JlVFl3Tk1rMGpsbTQ5Vmd5cFdta1lQSDRRaHNqaXVU?=
 =?utf-8?B?TzBYTlJiQ3FzQzNmRHhmNktmd200NFdDT0Y2R21kcjVUVFdzV2JYS3hUWUhB?=
 =?utf-8?B?Ry85c2Eyc0RNRDFqckdkUGdZQ1BjaWp0V2hNbk1qeGErVElpZU4rcS8wQmll?=
 =?utf-8?B?ejZScVZveElpQjArM1ZOMkl4TzdNT3pTVFlDMWRma01FVU5nSjlTbW1UZTRa?=
 =?utf-8?B?NlliVkFBSEtRVWs0djk0YVFSZ01jR1BBQTVuSGxZRHlTcllHUlB5WDN2S3Fl?=
 =?utf-8?B?Ym55WG5nTGcwbWpra2RHUFlzVnFDdGdYSTZuSUlBbHp2M1UremxhK1VxWkl0?=
 =?utf-8?B?YllXQklkUWlFMEtxNkg3QmNrdXFoNHZQV0s0TFVnaVFpMUFDY3I3ckVaQmt2?=
 =?utf-8?B?MFRJQSs5VWo2WEdzTVVNcGtBK0swZkxJa1l6ZVIyL2E2NXI2YU1TaG9rK1VS?=
 =?utf-8?B?Nm9XeldhY1JrRFJtSVNHN25sVkZOOTdiZVVFVGlmckNLWitMVWo2MXptRjl6?=
 =?utf-8?B?OW1ndUI1eit6VFVFd2ZCWDVqbVBpMC9lS0l5WW9NdGh5MzhjNWxoZWNRVDVx?=
 =?utf-8?B?ckRza0sveUVWLzVFd0laekZaVmdYMUFXZU13K3kxT2RNWDdMeUtoYW1Yb0VZ?=
 =?utf-8?B?RUtwc29Rc3BUTGdkdnE5ci9FYlpLRUlxWHNTbTNsN0c2UGNOQjlmYVU3MkRF?=
 =?utf-8?B?ZXVTT0Z6S2tvanA4SitHN2p1VWU2bWVmY3R0RVpwRUlzMTZyZERuSXZuWmlN?=
 =?utf-8?B?M0JwWnI2UFRaWnlHK0lpOVdlZkNVbGJjSC9UMkxzbjBrQm5KcHRIV2h6cG1y?=
 =?utf-8?B?QnU0NURkMHNXSFpqSTFIQzgxSEZzSTFpZ3Z2MHY3Qzh6anQ3UkFCbEUxay9H?=
 =?utf-8?B?UGZBK1F4ZGJXOStEV2IwcThRbzZwY3pDVzI2TlZoMFd1VVZNdHN5TjIxNlBI?=
 =?utf-8?B?Q0Q3MCtlVlFoZisyNFViRUgxM2NSdW9wbWVhdys0YjFvRlNGVEw1cEplTWFz?=
 =?utf-8?B?a0UreWc3Wm1MOUptaG9lcnlyaEkvLzZPdmF5dURKNXVIaXlhc2tNZmI3bUxr?=
 =?utf-8?Q?VlQQ+Ne/u8MP+eIzR0EbuIEZ6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bc1202-6ee8-4970-626f-08dde90aed92
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:52:11.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 211wstBp10TZCfLbvnykzW43TV7xozLfiRgfN/Mrv3Z7rYIX0iXcrZomM8aHASS6irNDv9V1Bip+FPvQczxYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11358

Parse the Spread Spectrum Configuration(SSC) from device tree and configure
them before using the clock.

Each SSC is three u32 elements which means '<modfreq spreaddepth
modmethod>', so assigned-clock-sscs is an array of multiple three u32
elements.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-conf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 303a0bb26e54a95655ce094a35b989c97ebc6fd8..dd6083597db3f8f27d86abf5640dfc3fb39a9b88 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -155,6 +155,71 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 	return 0;
 }
 
+static int __set_clk_spread_spectrum(struct device_node *node, bool clk_supplier)
+{
+	struct clk_spread_spectrum *sscs __free(kfree) = NULL;
+	u32 elem_size = sizeof(struct clk_spread_spectrum);
+	struct of_phandle_args clkspec;
+	int rc, count, index;
+	struct clk *clk;
+
+	/* modfreq, spreadPercent, modmethod */
+	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
+	if (count <= 0)
+		return 0;
+
+	sscs = kcalloc(count, elem_size, GFP_KERNEL);
+	if (!sscs)
+		return -ENOMEM;
+
+	rc = of_property_read_u32_array(node, "assigned-clock-sscs", (u32 *)sscs,
+					count * 3);
+	if (rc)
+		return rc;
+
+	for (index = 0; index < count; index++) {
+		struct clk_spread_spectrum *conf = &sscs[index];
+		struct clk_hw *hw;
+
+		if (!conf->modfreq_hz && !conf->spread_bp && !conf->method)
+			continue;
+
+		rc = of_parse_phandle_with_args(node, "assigned-clocks", "#clock-cells",
+						index, &clkspec);
+		if (rc < 0) {
+			/* skip empty (null) phandles */
+			if (rc == -ENOENT)
+				continue;
+			else
+				return rc;
+		}
+
+		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
+			return 0;
+		}
+
+		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) != -EPROBE_DEFER)
+				pr_warn("clk: couldn't get clock %d for %pOF\n",
+					index, node);
+			return PTR_ERR(clk);
+		}
+
+		hw = __clk_get_hw(clk);
+		rc = clk_hw_set_spread_spectrum(hw, conf);
+		if (rc < 0)
+			pr_err("clk: couldn't set %s clk spread spectrum %u %u %u: %d\n",
+			       __clk_get_name(clk), conf->modfreq_hz, conf->spread_bp,
+			       conf->method, rc);
+		clk_put(clk);
+	}
+
+	return 0;
+}
+
 /**
  * of_clk_set_defaults() - parse and set assigned clocks configuration
  * @node: device node to apply clock settings for
@@ -174,6 +239,10 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
 	if (!node)
 		return 0;
 
+	rc = __set_clk_spread_spectrum(node, clk_supplier);
+	if (rc < 0)
+		return rc;
+
 	rc = __set_clk_parents(node, clk_supplier);
 	if (rc < 0)
 		return rc;

-- 
2.37.1


