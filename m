Return-Path: <linux-kernel+bounces-770554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C04B27C58
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3BD1D0266D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8DC260580;
	Fri, 15 Aug 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BqntvBjE"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BEC2BE7C8;
	Fri, 15 Aug 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248687; cv=fail; b=Z3Ji7RvzpFJCfjKCANiN1IFhVTm1BGG7TloQYZxwOjHb5P80GYela3RNEET9SyNENQGhUTfdyEHP+lEsaDpX3Wi3HE/hcvdV0S8ipfZ+A03r7DMel4i7pPO7d+Sn4QfAKxF9W4w5XZBhJaOAqVOin8K/5X+9Lx2Z+7OcJ5DOmtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248687; c=relaxed/simple;
	bh=xqFXSpUkuvHRHp9xDnbWoMWjOVOeKefo3jWg6TG/tNw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KKqZgYY9hv3D464HOp40YAW/JpweIwKPC+4QWdsFx8a+1gGG/ZF/wVUglyOfEIN8iZuDy+/LqoMXARSeyBNZ40+0NELLXJpsYokuSFjrUMhG2KZAJwhk/HkpqhfQHFdGCfQ5Zs9rWgv9PNEfkdMIVNAoXuo4Cu4lQvngFJt96/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BqntvBjE; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3hQ8q900mMNHV4wJaTQwQEgvH9aCcdlzFcb2zm5ylRpFMCCD6iU7CKW4eTOu3/YjihHrIv18920TJBtMnYAPyA/nLJcW07OLBGgePAfKF3Y7TZUreoaTBIavfP/1rSc965IRbMNLDuxABr5YD3byiJ9xfknXT0Ox04x3pyykOhIhmUUHpwa8hUjU6QC7uU2wdJX9BMNG7t8tH0pOHHF/LCLtqXlKM1wKKuMpaccgHJ1raJ7Kb7IsJjGOZh+/t3BD64tMrXA6e//yms6Pt6wc3B4DVTDPCr778/xqt6ADPVPW/oFTjR85s8SVjY7kVn0Hr7Afv4gDUfPr1sR/fmppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vS1nE2HauI7qvp3pqN3bMMvq4Q/sWQlUTQuU7umkjvI=;
 b=RfbSDULGbk6uQwGNKZTxRggO1X8e+Yx7rZ6oprurF45h6erW24LzJKaRXttFBYyxim1UPmHkPII1p4UNyO3Zz2lebJS77waf2RqRBERqx0gckQKHVfZmblb662TKDaymSDvPNF8dWODrO/6kA6i1CP0gDAqEpIte7upy4/korf4oZYqCM4+nXWOFee7L3xjLBJcj0BMPQ6gl9+Ak37f7OS+sdSynYlZzgLrKubwwVRGzQEsbz/LSl4ZXchoJH5pKw5F9Pr3qIFjo7uiejlX8dRDZiGMPgCTGGKts8yUfJJJGzwrJqHZOE9KbxnUdrHHGfQxellp0eu6DW1WRnpfVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS1nE2HauI7qvp3pqN3bMMvq4Q/sWQlUTQuU7umkjvI=;
 b=BqntvBjErGN4qOkLVQCgiFEdfIrRNUmWGUhdw7qP9JekFMWN42Gai0NVIzLM78i6Iy0cYDBZSFvmc1pF4ldXpGSG48bvmpdXX4w1HG6g2CwXd7YGDVhYdB70vSyuy+0SsB1OMF9XcgsiG/kg1zBxCixuyFCMnqt+GoS02pZTaqRNettQirq52B4v7YopPPOdhXklBeXdkvp2NmhvP0lhsBOEbDQzthECMoJUi2bMpWY5cG3utQ4pskXc3HWm94xMoCAh5kwce3OxVeCI4EWAoqF/NN9hlLFzzXkI021yxw7PJ9F+9vgxqXWQFixwzioBdfruKBSmmczohyYRHsvcOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 09:04:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:04:43 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:51 +0800
Subject: [PATCH 05/13] arm64: dts: imx95: Add OCOTP node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx9-dts-v1-5-e609eb4e3105@nxp.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=1090;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xqFXSpUkuvHRHp9xDnbWoMWjOVOeKefo3jWg6TG/tNw=;
 b=BlzXeRGpcu5N3htEXeXmrXrOSVVthWqyt+KnLw2vI51kZNFZwiZg8Q1pAz3Dlt3mzPVfMxYHB
 AeqTx6T/6QpCktzrmV84cyLuOfsEbDEnO73vcQGN+wBYIziIWU6NKQZ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d002e07-f4f4-4d91-ed13-08dddbdac5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFBhRHZGaTZaMWZNREEzK2xiOHU3NlB6NitQWEEvTzBrN3YwSXFyQmN5bTFN?=
 =?utf-8?B?UEhieGkrcDRMTDZYemNzc3VTblFuQk1SRWI1Tlp6VjduZGJpd1VRdU12bWZp?=
 =?utf-8?B?K2tuNndkd2xxM3B0Vlp4U2FIc3FHM0FBUWsvRXJWVzg4UXlrczBIeGZsVkNQ?=
 =?utf-8?B?aGZTblJPS280TWVoeTdWVjJUZ21FejlGVjlKL01TTGE4eGFDSnFYeFp2UzBa?=
 =?utf-8?B?RFVDRURCVlhMV0NDWU5EVDgycHovMUFPR2kzQWRYbGFJeXdGbUxTV3prWStD?=
 =?utf-8?B?MkM2SmVQd2JjbzJBWXg1Yzc1Znk0aW5TdjRVeTRwZDRJWGJLalpIcFBrMmJW?=
 =?utf-8?B?TGFOa0RoWVliTFdzOTZ1MFNHTitwdkZaZWVXVU1kQTZhcVVLckpSRHJDVjBH?=
 =?utf-8?B?KzcyNDVUZXg5SXJ6OTFjY1h3aTJjellEa2FuRFcyZTV4TmVHU25uNGhqbG5W?=
 =?utf-8?B?T2RPRFNIa1hHSVQ4SDErM201bWZyS2xJMm1aK0o2VXVrbkFWa0JDQnZuSHhx?=
 =?utf-8?B?RU9sYkV4N2JKWXhVRzQzR3hUazNZby9MN1JZYTV6MGF5UGowSStuc2dKREJh?=
 =?utf-8?B?V0kzOVJqQ21vV2E5Kzh6SkxUSTMyRUtpNjhGYlhKY0FNTEVNbVNHS0VlTS82?=
 =?utf-8?B?TjlCY2JHc2grSklMemloNUwwblZzdHczQjhMOTZSSU9SNWFETStwamtkMTR2?=
 =?utf-8?B?RjRpOGJFZUVZVTV0TVkrSitacXFCYi95WTYzQ0JsaDRrVU8yWE5adkNDeHp5?=
 =?utf-8?B?c2xmU2RmS2tEY01paDY1dnJ2RS9Ga1A4MndQY3dmbzY0K3RGcDRLMGZZcWpE?=
 =?utf-8?B?cGxWZGxDUVNFdEw2VGJsVkNEbnFXL3U5NTFRdjlJemRxd1RTRVJqWmdZbVZs?=
 =?utf-8?B?RjFXaXROdWJzK3hEK0x1LzAxMkZ4eHVsczNsKzhJVHYxQjV1bk9zc2ZhdGI3?=
 =?utf-8?B?UDBQOXBvZkcrR1JCcFFUU3pJZHRka1hkQ21lZXlJeE54Y2hBTlNLMUc2cEcw?=
 =?utf-8?B?WVZjWEs2Y3dFM2YyU2RwM1ZvTWRERm1KL2hQOHpiNHd4Y0tmb0piUVNnNFpa?=
 =?utf-8?B?VWNjcksvUUNzaWxNcUpFWlArZ3djVnlIMHRubUJHSnNjVFlUZnlHU1dCdVRW?=
 =?utf-8?B?dVhDNVZKcVQ2UFNsR0lvZzBnR01FTTB1K0VMcnFpdzJveFBzeXRkMzJsMyta?=
 =?utf-8?B?dHJLM1RXbjdOaXJzMlZETlhwdTZmdTQyYmthSFUwYXo3RVhaS3JQS2s3MU5F?=
 =?utf-8?B?d3h2azBVMkFMTXFDOHp2UlRVL0JPd0dnVUk5Y09lL3RpZ0NPUWF5eDg4ay9t?=
 =?utf-8?B?bHh6dVBUUG5UTG1yMCsveGdiMlc3VDZ5dHlmTXg5eVdBeURZRGNwU0xhcGEw?=
 =?utf-8?B?VXRLTmVXcmZZM0tib0k5Wlh6Wm9PNGdLNENjdlJWTVVaL2RNUiszMHZ4TVBY?=
 =?utf-8?B?RVpWSE5nQmxucllXNFVwc1RkLy9kcVlzNUxpMHlvSERTbjdodDlnNVZ0c2l0?=
 =?utf-8?B?RzNCWGl0bllmWGhHR05NNVYzY0wyQWhJVmM4cXlqY1JaSkF5S1VpMFg5Tzda?=
 =?utf-8?B?bzNXdS9ocVMxWTFBbDM2UGtHMDVPTnQwNVpZVUpjWjlsVW9kZ045d2MzK0o4?=
 =?utf-8?B?RlhOSWFMdUJFeXYzV08rREpmZkVxU1BwdmVFSXVDK3E4ZnlnT3N0VC9NNEt5?=
 =?utf-8?B?Yjh6MkRJcUladmtXRlFFdWIvUHg1c0ZtbUV3U24wcmVHbDBZNWcrNjZXUUNR?=
 =?utf-8?B?WmpkNENNdi9JaHR0VVV4QzNzcGlITTJxYzRqYmVzMU9rVm1sRFVKNk5YRWZN?=
 =?utf-8?B?TzQyVHg2NkhxR2pCS04zTFg2L05ibStBa0hTbXpSNkRIRUNORU9nRkZtZllj?=
 =?utf-8?B?ZVJVMGsvNUlZMFJOYUNtUDhmR2FCNjNDMjAvcXdBR0JBOG1TazBGb2s0S216?=
 =?utf-8?B?MzJ1UGw3UU1vbkhsbkc0Q0g2RWFEMEpoVk1RenFEZFJrbG9VWmZXakxWdEZI?=
 =?utf-8?B?QktZN0NIdWV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE9YUWZmcC9DMWtSb2ZUUS9PbXBIQUVoc245WWQwamkwbllBSkVRMzM3YUJ3?=
 =?utf-8?B?TThha1VKUi9sbWRFWEFoaHVxS2JXWTZUOXhidldyeFlHdzdZcHNNZlBHNW0w?=
 =?utf-8?B?R2NrT01jejlSWGVxR0pINDBGOXpnTVF1TlpSWkFsL0pyWVVzYXlCY0EraUlT?=
 =?utf-8?B?WnBrSEQvN2NjRTArL01qNVBoaXN6U0NBRXBpQXlScUI0ZmMybFhhVXh6OUJk?=
 =?utf-8?B?VEFaL25rWjBIcjNEVUZmVEk2Wkd6VEdsekdudFFETzZybm1HVC9XTk52bVF3?=
 =?utf-8?B?WEVQRFRyZUU2amUrSURiQW42WUQrZ3ZLL2pIK1lGaFNRckZQaXQ5R1RWMDhZ?=
 =?utf-8?B?TkRvdmxBRUF6VmFybTFYZXRuWWdEU1RKSC9Sa2xEUzFMOTNFY1BuaEVZaW1q?=
 =?utf-8?B?dmRWSzlDellnOGxycTc2SXBweVpLVFBGYlRzSjNUMnBSUFM3WnJ3VXg4cmll?=
 =?utf-8?B?ZnpmVlVLdXpkZDBCd05yaVY3eVZFVGFkcDNkSDFQdFFqdTVwWWM1c2dyakNy?=
 =?utf-8?B?dlU1OGY5VlIzUVNnZ1VYekhUTjBPSW5BLzNka21mUGpQLzNiV1FLRm9sVzJM?=
 =?utf-8?B?bWRTRGlGdWlPMldEalRUdEdLaGt4QTVleWxnWlJvMnZRcWoyNG5COERiS3FX?=
 =?utf-8?B?cGl2QXBTVWRDcmFWVTNaTlYwM002WGNhVER3eWFFaUtBdmVnOXprd1hrM1ZH?=
 =?utf-8?B?dVNWbWJmTzFvTlJHWWNXenFTekQ4V3R2MGRmV1I0V0ZTdWE1N3YwRnlWc2Vw?=
 =?utf-8?B?VDFGeFlrRHpiL1Zhem1VWS9VS1dvUFY2bzVpU0VqbmZGRHhhaHJvdENKc3lY?=
 =?utf-8?B?VFJ6dkJra2ZhZjU0UzRXMHpqc1JaSURoUm1JSHRFZHpBc3kxQndLRGNYWHhM?=
 =?utf-8?B?UkxpbmRSc3ZjQnBaVlZ5NDZGNVZ1b2pEQklNeC9RWXBtSEFBRHZwclZuRE1W?=
 =?utf-8?B?Y2VWSkJsNllVSDhZc1ZMRjE4SUxvbkpLTThKUEwvRDlNekxDK3o1NEVYL0FQ?=
 =?utf-8?B?bnBvT1p0Zk1wcDFKdjBaVmZuZTB1ZXR3UXREbXVRV1AyaFVhcnJ5VzdZY1Rn?=
 =?utf-8?B?VThSUTZpRTlTWnIzaTlCWHBuYTFUekZ6bjFQS3NNenF4dDNUY1lpVFQ3ZjRq?=
 =?utf-8?B?UC9MK0FlVDN6bWxYQVRMNGJCYlVzTVNISXBEOHpXWnlSUFBwajJQT0lDb3Nm?=
 =?utf-8?B?bFljSzNsYUZOUGNjTkJxNm1TWlgyRjU4czU1RSs3Y1VhODdMcGZkS0xvQTl6?=
 =?utf-8?B?S0hTeU5UNHk4eGFHNXljV0Q2ZldSTXlsMytiY1NPbmh1UGY0eEpSS3hBSG92?=
 =?utf-8?B?T3FUS2FweEkyeGtvV0ROY2RoTmtRS3hUeWErS25JMlRmaHQ5bXRlZzNtTEVr?=
 =?utf-8?B?Z0xvRE5ubnZLMWVZVFd2czlWN0pzSm1TeWgyTHRDNll0Wk9GNE1pTnhyaWtC?=
 =?utf-8?B?L3JaSitCSmFFVEVHK0YxQWxNVDRCWit3T2FDRVZzSkV4OENNUkhoUE1XQWh4?=
 =?utf-8?B?NjJmK2hidlNwZFlaRk1KRlVzcE1va21OTjJDY1REdi9sTVh1Z1dNSXlEdWYz?=
 =?utf-8?B?eXk5VWVlT1J4Q0F2SjMvaDExOUNHMHZJU3R1dHhvYVhJNUd3bGZLc1FNcTdZ?=
 =?utf-8?B?VVZtMVFRK0dqVmF1cGd3elR1RHFHZ2lWTnJNQWF5emhUOE1ocjlXd0ljL3BH?=
 =?utf-8?B?ZHpidzR6T2xlNXRLdkFjNk5KTktqdGZjZE5zRDFlbFBoK2FkZE4vOU9Bazhy?=
 =?utf-8?B?R2hDZjUrZjE1NkU0M1NTUG16M0hoZ2lhemFDL2I2SVcyOXJUOTVaenRSb3hK?=
 =?utf-8?B?SDg0SGJPaVk2TFd2TExZNFE4MVNwYVRhM1hWQU5BcVI5eXlqbEtTbG1zNUNz?=
 =?utf-8?B?aGo0bU11MlBwSjVpOTEvVVVLZ1JXSkZnMDRiR2Z0WnQ2N1U0SkJGRjZOTlNi?=
 =?utf-8?B?SUc0a1I2YXBTSVlQUkxGdnQ5ZERFYzdKZHRHY1pZRm80UWMycmtJdklSaERQ?=
 =?utf-8?B?c05yVlV1UGg5ZVpFRW5WaTRyYUt1N0xiOER4Zm1iTWQ2cHNkdENsazZseTM0?=
 =?utf-8?B?N3UrK2tndXVuVHZxdzFDcy9pN28yd09LQ1FlcGhZUW91aEhaeTk1YVRkNjhW?=
 =?utf-8?Q?j/KarsZ+pQ7VuiDsVxfVJEpjF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d002e07-f4f4-4d91-ed13-08dddbdac5f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:04:42.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEOA6o+JX5rtrravz9dWKo+rA1l1MxjhJd17Up75dhsDzhpJgMYv15vwps+zcGKr3a+eXQlRVAvKsM7rAS2eOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

Add OCOTP node to allow reading fuse using nvmem API

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 02c0422a7aa3877c8431c9b050d85f43f5ed7bde..adc63448aa15b148ca0eb8499ff5bc217fe8208e 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1553,6 +1553,25 @@ gpio1: gpio@47400000 {
 			status = "disabled";
 		};
 
+		ocotp: efuse@47510000 {
+			compatible = "fsl,imx95-ocotp", "syscon";
+			reg = <0x0 0x47510000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			eth_mac0: mac-address@0 {
+				reg = <0x0514 0x6>;
+			};
+
+			eth_mac1: mac-address@1 {
+				reg = <0x1514 0x6>;
+			};
+
+			eth_mac2: mac-address@2 {
+				reg = <0x2514 0x6>;
+			};
+		};
+
 		elemu0: mailbox@47520000 {
 			compatible = "fsl,imx95-mu-ele";
 			reg = <0x0 0x47520000 0x0 0x10000>;

-- 
2.37.1


