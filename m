Return-Path: <linux-kernel+bounces-897043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A853FC51D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14703189C3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015DC3090FB;
	Wed, 12 Nov 2025 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KZMpj9DV"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFB30DD1C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945522; cv=fail; b=oLP/Wlk8OQ0YqN1sh7pRUhj0BPjMxtpX8pKV7BbzOTccCPjhRO4caPt04i8JW/2WIYDxVYdReayFLTAXH7SlUJXVwOiMo9kZvwpPd7ckrTdTqDKciRkXwk3PqtWexOeVjgkpHaKgz5rA0MRDKiWyE89mkcX6ATQIgj7D/sclPiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945522; c=relaxed/simple;
	bh=OFqV0TqxcYIE3X/wJNlDhLHukVl2lPzZdRJK/oZHDf0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ND4bOiJx/97czG8UxNs9tupMXWGIOAaS/Ludm6YtbchWYOU4G5yrxJKPtb7g4ObTzrPoQpV6z5+81Z8khYOd43fEd04cEZT/jNnRESrBl+3Ap+qwH9JORInFZeXbCHcNWyu9lS686elV6hFRMB67UyFW1FYNO0nmqKtfDlYKFTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KZMpj9DV; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN7yM/R+ksFOCicVuMSuUE31fm791msJtryYRCmJNH1tvyVN3mbAUxm8bOAoo1QmOpYlhia0vuBUPns3gbix1cLbgeLZp7SO3LWGJh05GKSPgMYoK5aauoZTlzwOWaolEWS7RuNeVlMi/UB5QjOdAikApfZpsmESTfzOr6VL7jJxWqBOEI0Gs4mC0stEitQM6SyeNBSZD0ctr95e8FHnSrezvdqmtrm/M2MUo1L7DidMJLmKuUizfgHWcZ5y1F8vrOucWwZ7Wp8vaEkWKm5JSxLBQe9YBnIoDamcXj4pO5OIwcLoBlLTYZ0Y4GPjRmXTkEaMIAC60R5tioiD8s5hlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFH6jEzycT/wRljL+3450uBkBw3oGHxEofpxV3ZP1Cw=;
 b=ajghRXMHdDdBJOFMirMIyHEsyzbAE29rY9CVYMELKrw1tBEMkG+twhgEQo8EhDTkN0s5ck9hBmZlo83lr+N83iZKO4tddo8TAmnmSYI2feyJTt9wSC+G0CMr7AgJLlePymp546RAMOXomksc1UfGCrGWFSF3Yw552T9P7HnsH4AOpMVypQ4pzHK4qlaLvQJwPPgjr3XDnYKQDRlWicxW/VBB2F9so+7bA8uHoHakT6EilXKE1GiWHVC/wiBagBut1EnbXNGdIOY1Xuj9e7O8gm5XnqfNWgX2EQltNSSgdDLbZZQn4ggba/2b/RXrf2lUAtCU5z1ZA1Ycxriqf+dRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFH6jEzycT/wRljL+3450uBkBw3oGHxEofpxV3ZP1Cw=;
 b=KZMpj9DVLwJ9RTh770/nuaiA1WIt0H0Nmg/vOEl2ltdyAfCjQfBx2cDHtvOC+EiaxZPKdA4nc1iqCKGoOUX3UBb2W+EE2MgGKKO6Ia09mhjBaVwP3+CfrkuFsc+Ajw2V5aRtTKu2D45DYqev1yC8Cxxv5ATl4AaG0QDul9H3eYfsZ/0tBuuT5iDMLr110LLUbKbSCiTvP+yIZQS+uOxgczQTEy8/P4qxfLAqBM2ESLVGklgRE87tzzeoiQRhR+6A/0m9wThPSA6vUbYXU6aT1Hl0U9AILajczoXFn2xDNrpj5ScM7p0+rIsr9ZGevo66Gvf1OQznQ2eP4Rt6u6G0bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 11:05:17 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 11:05:17 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 19:05:13 +0800
Subject: [PATCH v4 5/5] mtd: spi-nor: micron-st: add comment for
 mt35xu02gcba
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v4-5-e4637be82a0a@nxp.com>
References: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
In-Reply-To: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762945552; l=1527;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=OFqV0TqxcYIE3X/wJNlDhLHukVl2lPzZdRJK/oZHDf0=;
 b=nLecf6TNEz452esqFUxhrKCnIBfuyJKy7bj3xEk+qE1RDXL7E3w+82eLXn0jANvPMlQbJqVAN
 NtheiNiw2rhDn6JuP1cHIKbS6Aba30p+c537P0UghTKXIqttWfcDcHB
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS4PR04MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1996f3-3548-446f-6ee0-08de21db5cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWkxNEpTMXR2bDZmSkZYTW1mRVV6TmM0NmpCRVl6YTVYRVJ6NThqd1VoNDBU?=
 =?utf-8?B?Q0UzVDlPYytrTzhNNGFBaUFTYmg0MStCb2h2WXpsYnk4NlBGTEMwZTdKN21U?=
 =?utf-8?B?emtmRERYYlFhREI5cnhTK2ZIL01hYktWdDY4L1NyeDNyWlBIdFBpalBVUTds?=
 =?utf-8?B?NDR3RUg5ejB3SWhXSlJnNDRScmc2Zm5DbitRN0Q5RTZiWDl5NlhMNVlVNkd0?=
 =?utf-8?B?LzBZUnZaYldXbVZqUmgzUjh3ZVpqQllPcU1maGxHenExR0QyaFovR0thTGR4?=
 =?utf-8?B?TWJacVNQU0YvK3dWL2FtRGZGcVQ5MGg3Z2p5cEhjTEtTSHIvMFo5V3Z2cFBW?=
 =?utf-8?B?Mk9Ma05WbW1sWjJ5NURrSmFGQitpS01lUmRaN2RHS0FkSnRSSFlDUHRsdHRW?=
 =?utf-8?B?VkY4LzFCTDJqck9lWUhCTS9Ec21wdWozbmkrN3prUmxMZkN0TFU3VEs4OXJs?=
 =?utf-8?B?ZFNUZGFZazFON3BXOWlPZlhLM21xM3BRNmNNZFFzNnJVTEFONFM5NTkyTjh2?=
 =?utf-8?B?OWt5R1NHSWsxV3FPKzJhd0R1MGdCZENsTTlLV1lBKyt0QkRBcHN6Z2FXTE15?=
 =?utf-8?B?ZzhqYy94TnhWRzdMTXYyY2tyZkovSk5GM2Zzbi9ncEwreSt1SFFPSTA0bFJw?=
 =?utf-8?B?SDNTaktGZWZnM0RCckZCaUUzYzhiU1dvT0srSE01TnArWW1qYTU2VEROb09y?=
 =?utf-8?B?TTcxSWhteng4TlZxRzFVK3IyUUo5UStQM3RMSk1UMTRHRHd1aVpvSWpJYklm?=
 =?utf-8?B?ZlNqdmk4RzVaWFh5dGU3VCtUTlcvcExRSVozenFpQ0FzUDUvaFFjVkZiNzh2?=
 =?utf-8?B?QTJkNEpqa0hmQ3l0Z2x3Q2dnQy91aEV3bldXM20vN3dxWWRLandhc2ZqbkRi?=
 =?utf-8?B?Y3QzdHQ5VUNkcFJjVzJkbExHdTM1R29zNUJEQnA3OFFDbkwzbEljMFo0aGQx?=
 =?utf-8?B?TTVSQjd0a3B5MzZPSVltQnJvc2ROV3pBdU01YmEvdUEyQzdNSDRCY3lmUE5C?=
 =?utf-8?B?SHJhUVZSQ3h5QW5wd0Zaa3VNU1FDNElXa3FNWGRSUkw4OEhsNkt4VVcwTjRD?=
 =?utf-8?B?aHY4UmdQUkZ5a1BUZzUxdGUxQ1dXUWZ6Sm9lNUl3SWxvZVYxbUg4TzJ3UHlE?=
 =?utf-8?B?UzgwRzV3UWZmKzRUKzhUOTlPa2V3ODh4VXo0aGlpaUxvM0FLMm9ULzVtSGpT?=
 =?utf-8?B?eWpNQkRyVFp0QTArSStZMVJyc0Q1amE0RUdDbWZwRUROOWlJZnEvR3E0dUxR?=
 =?utf-8?B?OXR3SStNZHRhMGNuekFnL2lzREMvSjhUMy9qcDlxRjZWY1RqVHozUEdtTEJS?=
 =?utf-8?B?UHJja2dpUXh2L2NrQ1lXTmtrM0lub1ltMlBvQkwxUHVBdjcwZDUvWnhpM3d3?=
 =?utf-8?B?MHl1ek56bXc2bUF6MFJTbWVPbURsS2wvQ0FmQllVOWZCOUNGaE9HU3Z3NUZw?=
 =?utf-8?B?dkc1c3V1d1RCU3RBdjFOQnM2TEc3RG13U2w0Qm9GMGsrdk96ZnBRWHRsaVAr?=
 =?utf-8?B?ckQ4djRTWVNtaGFpTUF3ZVFIQWFuWGR6aEJlNFcrUlBCNzd6L0I2QnhBSUUw?=
 =?utf-8?B?emhYaStkcGpXZ0NtZGdoMkhJZC83S2FFalNWUnpVT0xjRjRsbUljRzNaTFBm?=
 =?utf-8?B?RFpnbndtb1pzVEgvcmJ5TEluKyt3VmtvUWVWemZlektjWlVrVTd5WHZZNDRa?=
 =?utf-8?B?NFlmUUFHTVM3U2pFak4wclBsQmZkbVhtSEdjS24vTjBkMWo0THNhSUR5U2FO?=
 =?utf-8?B?dkpEZzJLTi9UWC8xbnlMSzZLUWZSc2I2dEZVWHdMZjdUY3NSKytYeWsvbkpY?=
 =?utf-8?B?cUgzdkVHZEgzRkxPRzhJTlMxa040Z0FvenFFQkpQcVhsczZqOFo4NDZGd0Z2?=
 =?utf-8?B?RjUwcmFyUlpJRlExSEJiV0dnUmt4NHBORTZiakZzamRTNWxtOEdRUEY0Z3NO?=
 =?utf-8?B?QTJPTnlkRFRjVXNEcFZjMDI2YTZMaExCK0dlQmZOQkJwTTljaUZmQk14cGtU?=
 =?utf-8?B?QWRiVnBJL0JnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1p4NExMRmYxY25yRW40bmhNUWo3MG5RZVAzSWtpczJrK3FsMjhUaFVaNUxO?=
 =?utf-8?B?bDV2bHJ6RFpUb3JYb2VkNjdIVXVqQjdMRStUL0pIVUJkUWtzNll3VG5BY3Jl?=
 =?utf-8?B?VUxPdTVsSEdvTUMrOWtxSzhCK21KQ2w0THZZS2c2L1pmeHErZXcrS21mUUJi?=
 =?utf-8?B?bTZXeGZrOExwYTEzWmhlWHJDekg0dVZVMHZxellxc09vNCtOUGlVcWJJZ3Zv?=
 =?utf-8?B?WEF3NkZmM1hxQ0FTNmJmSEJrdDVkTy96ZTNBWjdGNFdmREM3VGJxRWtOT2NC?=
 =?utf-8?B?a1k4Y25BOStrRzNtTHNoZVpNNVdCU2dDRk5pOGNSaDNMUGpYWHhJQ0xqQ1hL?=
 =?utf-8?B?cWJOTUZVVCthTGMzNC9WWTkxZGVPd1Y4N0ZpYVgwNXBYei96dEZOdkYvOG9Q?=
 =?utf-8?B?QTQzSDdWUE9NRTdacTFYWEFVdWpxZTFsWGxaSEVjWlhnREQySlRwZ0UvM0NU?=
 =?utf-8?B?bWdjOTRoeGRzTG1vejgyWVQzdDlEaHZUdHh3YU9GVmV3ZTUxd0hUUFdrN2tE?=
 =?utf-8?B?TjIxV0gwc3h3T0IwU2FyeFNWMTQvNzZ0Ujg0cDhnRGY5SE1UOUFUUmpCZXU4?=
 =?utf-8?B?KzFnaFNJblVhYlptbzRndi9GQW85VG9VR0NiSzRxK2xlMG1TMXJiMmpJY2Qz?=
 =?utf-8?B?enJpUVptUGFKRGZLb0RkK3ZCaVA5NWUzb1hEZVZ6VkpNd3hvNWQxTWZFaWFx?=
 =?utf-8?B?Vmo2ZFZwM0gyMmt5Q0hhYkxQS0pyVkIyRmIzR05XZzNMQlZndXJaRG5xbm5q?=
 =?utf-8?B?Nm5XUHMrOUhyU0dQNktkUjVUb0RERXlPYzgrZndsbW1HYURDMU5GZG9EWURH?=
 =?utf-8?B?MnN5NUQvMzNjdmdVT1RpUGNqclRyY0hVaFBFcGt5QktacnFFOGFEaFYrK1NG?=
 =?utf-8?B?SjhrdVUwMExiZmNvNlZUbFRZbWJFcWZpeEZkUzE2bmVDVExTVDFmcFlTaGhQ?=
 =?utf-8?B?NHZTMDZYWGUwV3I4M0VMSmNScnpmL0d3OGpMcEJkcjQ3aXZkakxiMGQrYkdH?=
 =?utf-8?B?NkJzNW8wRkJucW5ZYnJhUERLdGhBMDRGZ0FnQ1M1ZDI3L0lxOVhPMHhndSsv?=
 =?utf-8?B?UmllczdpeUVzZUR5UWZSaXFCWnM2bXpTSEVTOVltektPSjhLc3lxejdVOWVh?=
 =?utf-8?B?K0gydnBtY29uUXd4QTZPd3pwc3VxelBiMXBjdDNJU0MvZGMvWjlRYkVmWEo1?=
 =?utf-8?B?b2NXaWZrZ1FBclZZNTJlNVVtbFBRaGV2L1pRSE5LRnFYUzF6b2E5R0JEdjh0?=
 =?utf-8?B?bFBiY0xWWmFIWFN1YmRwVmM0anNZbkVtdTdHZmsxS01OWTVFZGE3SENsVG50?=
 =?utf-8?B?Z0dRQzhNQnQvR3FPWHFLZEkxVGVSNlI4ZUNVQS9CLzF5c3EvdjhRTkR6d0ho?=
 =?utf-8?B?UWpQVkZucTJZbUlCd0xobEJlc2VGTnZ2SEE1blZOTEROcU1xdGphQStlSUg4?=
 =?utf-8?B?VHNrblJrdEhydlFIc25KVTFZQ1dmWUYvOWp6UGdYM0Qxa0RPSm5WZXN2cDRt?=
 =?utf-8?B?dUk2RVJMTXFyNzlORkJwRjAwa3BQZnlZWGRBVEVEOEgySU1nVUQydTlkTHFu?=
 =?utf-8?B?STIvOTJYRE9PQzIvdmdoMVBNY3NwSzI2SVVVNzNJb0oyOWV6K1dJOEo2ZWRC?=
 =?utf-8?B?bm13dzhMSmV1ZmR2TUlMditHQ2ZoUTVLaHpCclBiWVE1c2hJYTVpdlNITCt0?=
 =?utf-8?B?U3VueDZzeUxzYXBqUWV1bGp6QlN0cHJQek80MXpqdjFKeTBWei85b0R6QzJC?=
 =?utf-8?B?bXh4RG5Xd0FHc0R1TTdZTy9lZ1hYQVFjWlhhZ1VnMGtrK2dzSVMxbHFtVkpZ?=
 =?utf-8?B?U2RrL1h0b0g5WWRialBBRGI5Uk03YTR0aG1ONk1yTHVPYm1VLzM3ZC95bkV3?=
 =?utf-8?B?Y2NSVHVZRW5ZT21nN0haelJFcWdJcENTNnBEYzhPYTd1TUFveEVvNEE5c2Uz?=
 =?utf-8?B?bUJMM3owU0xtcWZUNTd0Qk12OGU4ZDVxaHRCUDdDclg0MmlzcnB5QS9Kb1lV?=
 =?utf-8?B?VTNyUDRmRWVzeTdLaFF0ZllwMC9CSFlHK3VFWDM5andQZGNmRmdEdjNOMEJR?=
 =?utf-8?B?c25tVC9MSWJlVVlrZVJHY25ITUN1YlFuWXBhL3MzVjU5cmNodmFleFVFSmJB?=
 =?utf-8?Q?/hUjFXQrxRhWhQZ+TFNn6YS4F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1996f3-3548-446f-6ee0-08de21db5cb5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:05:17.2211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpTbISvbYP3K8qCrp6uoGxrWTa2kb3hqV1a8/D65I/q72lQz+kOvMAYWU39WP+Ag5Bj1iV+YcjjqRCqTjqczTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364

The MT35XU02GCBA flash device does not support chip erase,
according to its datasheet. It supports die erase, which
means the current driver implementation will likely need
to be converted to use die erase.

Furthermore, similar to the MT35XU01GBBA, the
SPI_NOR_IO_MODE_EN_VOLATILE flag probably needs to be enabled.

Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/micron-st.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index c89c06b1fc61a581fea2e18732be2501a15715f9..f94e9d2d17bf4aa7c36ba3aa37d34f767a9f93ac 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -204,6 +204,16 @@ static const struct flash_info micron_nor_parts[] = {
 		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
 		.fixups = &mt35xu01gbba_fixups,
 	}, {
+		/*
+		 * The MT35XU02GCBA flash device does not support
+		 * chip erase, according to its datasheet.
+		 * It supports die erase, which means the current
+		 * driver implementation will likely need to be
+		 * converted to use die erase.
+		 * Furthermore, similar to the MT35XU01GBBA, the
+		 * SPI_NOR_IO_MODE_EN_VOLATILE flag probably needs
+		 * to be enabled.
+		 */
 		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
 		.name = "mt35xu02g",
 		.sector_size = SZ_128K,

-- 
2.34.1


