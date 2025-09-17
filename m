Return-Path: <linux-kernel+bounces-820265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22562B7D48B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A3216FE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E7430CDB4;
	Wed, 17 Sep 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cRjHG23P"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188E30C60F;
	Wed, 17 Sep 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098568; cv=fail; b=mCBitKwGOCTFMm0FnITtjyfXd4EBHRUrI0KPjs611x/pxI79aAK9wK/h0tQ9zkJIBAyap2OXtTc8cLyCoUfr+F5vwgJn3bWxQyw97r3Frnn9npsUcf/8tgcDgg1UZLboPZtnkxGRTVYEjJQkigjpvUCFj1Q96oXt8+bMZqwpWvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098568; c=relaxed/simple;
	bh=Wq50Fe7PvB6rZsbTp0Lx8RS4BwgmS+zd69s8GD1zm24=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XA/fMudfziFRzs9sexQ0rtiZZV1uROjqnbXxv6/vS1aCPINUTeu9qBzqPVTDpQGfL+3/ediCvz9uPyoPyTRfm4Fwf7v4CxY4wr/QIT98SMVLOeYil7iSMu/xL0IkMD3JhC1NR3AqCLbn3Z8rp2KClOWl+0HZmm6EU0/fQwPTHWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cRjHG23P; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGOegSW2R7qzbkwc2XuR2+jD2JuE6lsFJNbazw1+P1tqI19UrvkGaJTBHy951YYQlGjvdEYEJP38zz7ndD0PzJF6AvfVPrdFk90nhfcajyd3gg2ZV9q5IF3rhaObg1mhZlncmEjYdjaNsZaiUo5Km3OADNauAIVicOdAz+kzQ9p2DoFfoXUKpP7NOtXSzMnbsYvdXoZ6yxzVDA3KnXWBdFxccPYs1tY3xck7n2mwYgaBTHQY/FnnZm7+sW++2QcJwj8i0WLz/aQUZVXLB8dicKV6Ocz4L22ThZ4MPW4/HFtNwQ2kF4w6XNcrmwvXi4K46yb80vYs79PuJ8qwoEYh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI5U0oo8e6vx4BBnrYF7HnO+POuwCa6HeGIUU1OQw7Q=;
 b=lHkkqouGwp6u+QrFtWjv9QXQ5MBRJe3GP/46ORcMUeWOhiW1SL9dtCH7fA2CoiXaxbuJmMdlLofov4JEhZfRTmUFB6YVujDFfyyL5WuObO7C5UvIakKhTAhHp974pcYR5lZ7X1rBNtmInIJ5sjvjTcGQQKsc19A4MdqB/8U0BE43XjDZf/LNu3S1kU/2VLYHnPlX+Yt31gA7ogRqLOsRpwYb/DriUWPUO0PH2xoGc/pNPw1HoevqQM4+qzJ8l7nMUnjp6GP7NKddz7/HGn2jxPmKpTn48RQ76B12OkSzdmslcOX5s904KNAAzty/zBFd/SzIsbijeNX5Ka0EsBpyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI5U0oo8e6vx4BBnrYF7HnO+POuwCa6HeGIUU1OQw7Q=;
 b=cRjHG23Per1m6bX8Zne8NT58GVOSSHQLqYFgCrTT4MsK3CQaj7s7QGgO99f+bVZnm5O6SAAR7Tw7G0RD7qU1LGZGqEYbG+g+8OxuSJe07zU0SRqHoYA/9hvYaJJgJpu7Tusd+YshtI7iLpNm3BJgUf4kK1E5vuCRzbmcsYoo09+acR97NgGMGnc3B/HRBsOzFE2T9DVqbOtiDYzA51+41Gr8472o0APdvH3FIBv4DOlu3v9NInXHrdsFQ43X22Ae+G4BOMT0BUVKuAUJwMI1NT29oM/LxWKnx2FkzcSDLgdndwopFVQ+/kTvz++jHOuTAYErgNvHeWKzWmhgrQoSBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 08:42:44 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 08:42:44 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 17 Sep 2025 16:42:29 +0800
Subject: [PATCH v2 3/4] arm64: dts: imx8mm-evk: limit the max frequency of
 spi nor chip
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-flexspi-dts-v2-3-7e2a95e3cf4d@nxp.com>
References: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
In-Reply-To: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Michael Walle <michael@walle.cc>, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Han Xu <han.xu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758098561; l=1183;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=Wq50Fe7PvB6rZsbTp0Lx8RS4BwgmS+zd69s8GD1zm24=;
 b=KMi29epER3Zl5m9MB4JMPKj4Skv6O0pfwW++Ptl9Nn0TM4yn0ucS5OW1QW5ZuMVValEMtDQAl
 UN430NNPTD/Ct5FYU4MNM8BxB6ov4yZOsNF/v7Sgs5kxJlS3XnyLwIt
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA1PR04MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: 83afc25b-94ea-4791-206c-08ddf5c62b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDFGUU1JSnZhdksrMmo3dHQ4ZVZ4WWVxcExoQWFvbnI2Ukg5MDRxOENYMVEw?=
 =?utf-8?B?bDliTEhlc1VPOFNCYi95Q2x3cHJZejgrUlk5ajBlMjBxdWVwQjV1Vyt1YlZ2?=
 =?utf-8?B?eENFek16clVacEpvbVBHMHJrOUZ6ZjNSS2VyUHRyVWpiWXErNkczWUtKbnFp?=
 =?utf-8?B?L3pWNjR1S2VmbU9DMHA0TmZwQkFpVk5OYmJ6aWFNNEhPSTBMOXMxRkNOSzhT?=
 =?utf-8?B?Mm1oZnZrc3U1Vzg2NlEvQzF3c3pxQTZUQmsrS0g2MGdQNFVxSkZLb2lFUWhr?=
 =?utf-8?B?dStrT0g0SDFpY1dsNnFaOUU3K2YxVXJST0gvZHhpUWlQUkpjMW93VjhlZmxw?=
 =?utf-8?B?YkYvZ3FuUDk1NXNlTG51aDBBNW1EaDk2L3lqRFNvaHltMWRURzV4MUlTL245?=
 =?utf-8?B?UlFiZUdYT0N2SWVJWVBBSXdNaENXRzJ3OUpWNDBLU09UUkFPaG9ia0NZdTZt?=
 =?utf-8?B?MFJXS0ZKcmtmdmpZRHh0bDhJOUpob1UzMWtWSjA5czBQM1RlR0gzY200MnJY?=
 =?utf-8?B?RitNeEJ1NVpnNGpkT1lPbFl5a1hHTDJjcHhDaWp6TGw3MmZmY09CMXFXN3lo?=
 =?utf-8?B?dzZZRmtkeDhkc2IveFpOQXN2WFJrV3NHOGVWZ2kxYVFhWDEzQ25OUUVJQnlG?=
 =?utf-8?B?VDNucTcxdFFVdjRUYXZ4ZUZXMGxBRWFUbFV1WnVTaTAyUnRTb0lVSDlLWGdC?=
 =?utf-8?B?bjRQdE9EQy9QTmgrZGVReDI3c3VVUHlwdHJaZ2hlV2NkazZreWh1R2NLOUNp?=
 =?utf-8?B?NzNvSGczVXd1RTdYNlphZTdIV1NIb3o4YklMZ3pVb1pTWFdibVNTRUI5My81?=
 =?utf-8?B?NVNlMnVvYjZxeVRzWlA1OEFRakZ2ZXBMRE9CYTVWUVV6cUZ2UEE0NVdJTmpx?=
 =?utf-8?B?aVZjOTZBRXBuZW9CYlZrSkRmaVlYbm5SMHYvR2czWXRZV29zSVN2NHRZWnNn?=
 =?utf-8?B?Y0tybis1WnlSZXVwSkpJVDltY1dUWTNBUStLdzUyNys5MWh6dWRoSFFpdkxn?=
 =?utf-8?B?bmxuRVFrQzV1Z2p6cUxBVGp1VGhST0V4Q0ZWaW1TMFJzelEyeHVBQzRldzZY?=
 =?utf-8?B?bnpFTjk3ZzZuYURxQ2xFZEhOMFVXbHphZUplRXdRTzh0SGI0cEE2bmo0Q3Bu?=
 =?utf-8?B?dDJSaUVPZGFJbE9YOC9vVVRLRkNyaGdVWldOVTZlSi9pUFlqS2tySUl4NGZS?=
 =?utf-8?B?ck91d1VzWTBCRGRrdG03RS81eGVjb0k2Tm9XWWhqUm4zMDFlblpabk1TNHgy?=
 =?utf-8?B?YlNlZ05qMHA0WUVUeE9nVk10aTVBdGM2OWJ0L0szMmgzY3FVWXh4WFJqQ3d1?=
 =?utf-8?B?WnpsUWFYb3RvMWNFZDhKcklzQTlnbVYzQjJXWXloNVdMR0xReHhpZGQwVzNE?=
 =?utf-8?B?enQzQUovWHRmcklkb3pkaVlTZ1FLc2l5OGFRdlkzN2lZazBqbTZSNlpkOW1u?=
 =?utf-8?B?VmM3SktwWkRoUWo3eHVaVy91NDliTkEzVDUvMXFpQXl2UE5Ra0FMYzhMVy9o?=
 =?utf-8?B?dlM4MFNUU2tVK3FBakdtc25seU41blFHcWxMTjdOMTh1UnlNSzR3VHllRlBC?=
 =?utf-8?B?aGlkUFV6S2hOcXNlZzIrdkJtRUFmNVhWaDJBczYzNHBKKzViOW81anloRjdn?=
 =?utf-8?B?R2VLKzN2OXBvQ1Nta2RvTVlNaHBwRnVvRStxMWF4NHhhS1h2bEt3bzhLT0FC?=
 =?utf-8?B?TEUwbDNiRnRXMUtsRjFmdXM4MURKTWJFdUR6NUhQaklUNVpqaktwQWE1VWZo?=
 =?utf-8?B?TVM1VmcxWlZqdlRtTWRLQ0dWWEFFaitxOXM0NUZSZCtVTUNJZzdsTU51alM4?=
 =?utf-8?B?WXVwTTVXSzVWQUZpUFlESGI5a0lnUGtKaXhLSUdaZkVyQ3BQZDAvZDVQalAy?=
 =?utf-8?B?dGhtZkUvRm5xT21UV3hIQVJ3ekRzZGVDVlBnQzJ4ZHQwVFJrK3lLZWV2ZDh2?=
 =?utf-8?Q?8Ww3TCtxS/CZq9Tlvys8sMp97+yYUMqu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlIwVVR1RTRGL1MzSmwwNUljVTlNVHJrVUVONitUbThuM1pwNU9EdnhPenlR?=
 =?utf-8?B?aXJqWW5TUU9CaTl0djlqYklncmEwbHh3eG95WDRENG9uWWwyMDN1bldOb1NK?=
 =?utf-8?B?cTRmcjU5NHp6K0JDRmdReUJUeWlWeFp4cE4zaEpVTGtjdWlvaEE5L2dKSEdT?=
 =?utf-8?B?SHJrb0duRk5tZEpDaFMzYVpMSXI1V2xVdHdLc0JvNjRBQ1ZPN3JlcTZKdFZq?=
 =?utf-8?B?ZThobWU4cWlXaXRsc3NRWngyTEJKMm52bHhqaFQwRkdkd3NDMFplWWxjelVT?=
 =?utf-8?B?WEwxbTJNTXpLNnVmZTZqMkxHd01obHZsK3hYbXpKMERnRTdhUHRGMTc5RUlD?=
 =?utf-8?B?WUZPWGhQeWNJWUI0R1htbFZNWXU4YUltbmlRMTQ4cUN5eEcreHNqRGdHUUpk?=
 =?utf-8?B?bDR0VmlkVHBUVU52ZE1lcHJMbzZoY2VCamJQQnkxZ0dna3NWVEgrR3ZIdmI1?=
 =?utf-8?B?a29SS0xHTlFmcWVPa0lZQWtQZHZ5MDV6SVhaNmxiazhTL1Zjd0RXTEo4MlB0?=
 =?utf-8?B?VjZMU1QvRU9TeG42WWU5NHd2R1hQRS9KVFhub0h4cEtUZ0liV0d2cTN4V1lX?=
 =?utf-8?B?dTNiVFRhM2xEUG9nQTNFREtRSEZZb2JEYSthblBOdTQzeVBha2hDZ2ZKMWx5?=
 =?utf-8?B?dVA3d2JwN0l4c3RBMU1OamlkS2Y4enUvc0thaHV1RzF2ZlM0R0N1U0lrSWpZ?=
 =?utf-8?B?cXI2NnNHSWlZVzZFRnllSUJlRGRxZTVLYzB6TkpDbVdxMGdWQlhZOGhVUlhs?=
 =?utf-8?B?MEIzTzY5Y3NQVVpraTJMSnBJbndPa3A4aDVXOTNGdWMwakZYbWloVnhyTW5P?=
 =?utf-8?B?a3pWakExa1Q2RnVwdjh0dzkwRm82U0xSWUdZemNNMjdLQmp0Z28wbVkzeEZi?=
 =?utf-8?B?VERTMml0UzdMc1d4cVViR3F0eDBwaXUzb1hOQlRZVmVXYXJZZHhCRE50T3FG?=
 =?utf-8?B?RmVkUEk2eDlCb0xwUFh1ZkgvTm05OUpPNDFTN2EwaFlMK1FaNWJNdkpZM2ZT?=
 =?utf-8?B?c2I2UGdiR1NoTUMzaUFpWTU5U21WRXNwRFI2VFp6RTFJM1dZSVdBOTRyQjBv?=
 =?utf-8?B?VHhYNEtxNnhPL0o1YUNCYzJxTmI2RkZtd1hveHIrSUJpYkNIaG5BRndtNWRs?=
 =?utf-8?B?cnFIZ25SRzI5Tmg4bXFlNk5jWU1BMFFRYVZ3bjZiYjFjNTRUclJlSlluWlpT?=
 =?utf-8?B?U2VJR1RjMVBBNkhPR2tLUmEwdHZSY3pFWDdua2J4a0lMbFY3WmxCNUVGTVlO?=
 =?utf-8?B?aW00VXh0K3c5aHU3Z2dQcndyVW9NbTM3UmVqS0VjUE5JZTJsV2JnaU9iejZ3?=
 =?utf-8?B?T3ZJTVk0WkJ6dFpKMnk4ZTA2YlhCQ2V2NHVSYTRxMmd2SUMyMm5BUXc2OXFI?=
 =?utf-8?B?NmRNdUl2OGk0Y2REVWhCNUxRN044L1Jad2FoeUVLS0EreERHN2grekJtckxw?=
 =?utf-8?B?ekpzK1ZWcVBFaStYQjBybnk3WXNjZnQvRDk1OC9UWURPMzlSM1RTYVpTQnlx?=
 =?utf-8?B?Z3k5Q1N4cG1FR0lYQkxDWVM4ZHRDcXkxN0I0djMrdURpa0lzL1pjeThMczd2?=
 =?utf-8?B?a2drK2R2SVpQTGNDVWxyZ3p6OWJQa25TbE00ZVRldlF0OTlWTVJlZ2RtRmk0?=
 =?utf-8?B?UEFzMlRCaE52b2RMWFJQeFdpWUlxQWZ3V1RjcXNsamgyeVFBRjlRWU1ieTR3?=
 =?utf-8?B?S0xZaTRjQ0szM3JhaXpVRTlPbnBNcm4vaDU4eTZoNGZHSkNid01wZ0h3cVh5?=
 =?utf-8?B?UGFSTlBxdGhtd285dXdYNXdkRHRxMnpCNVBNVTVLYTZSdzNUTHNlaEdWZ2U5?=
 =?utf-8?B?ckJhU1g0K1lndi9TQ0ZYSFRUb3NtejVsY05HUGY2NWFtL2xkT0MxZE5iVmww?=
 =?utf-8?B?R0VsLzE0YU9mL0hYTHhSdUxBRmNKdDRQMkYyTVkzZUptR29CbDZlUnlkTHQ5?=
 =?utf-8?B?WGY5Y2pwY0M5ZFR4c2ZwOFFSRWFQS1FkS25zOSsxRVdLMEVRN0ROOUpGVGhV?=
 =?utf-8?B?dmM3N0Z0enVXODBvNEduU0FESUFOaEhhY0pGdE54c3pieitKYkJyTU9ydDBv?=
 =?utf-8?B?dmlUYXpOSUZGM2swQ0VDeEpGY0ZZQXhiSlJrWWYxbit4enNvOHRGZWlyQ1p6?=
 =?utf-8?Q?xpiblsUPwf0LLmi+w/ZZbnZyX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83afc25b-94ea-4791-206c-08ddf5c62b48
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:42:43.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTpu7c+K9PubA54GnDfWdo5xEzgxUxTJ2T2R7GVkCM2akYez66EmRKObxOVw4/6GVj7vIHsw+b3esxmyo8jO/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

The spi nor on imx8mm evk board works under SDR mode, and
driver use FlexSPIn_MCR0[RXCLKSRC] = 0x0 for SDR mode.
According to the datasheet, there is IO limitation on this chip,
the max frequency of such case is 66MHz, so add the limitation
here to align with datasheet.

Refer to 3.9.10 FlexSPI timing parameters on page 59.
https://www.nxp.com/docs/en/data-sheet/IMX8MMIEC.pdf

Fixes: fa1652340af8 ("arm64: dts: imx8mm-evk: Add flexspi support")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index b68954bcc383cfc799877ff64c5d9a59dd863907..bb57c1db7c64adb20c996bbc2e3996e1fde5b98a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -47,7 +47,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
-		spi-max-frequency = <80000000>;
+		spi-max-frequency = <66000000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 	};

-- 
2.34.1


