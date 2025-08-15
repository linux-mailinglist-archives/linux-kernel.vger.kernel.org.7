Return-Path: <linux-kernel+bounces-770557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93ECB27C52
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68D41737BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACF5261581;
	Fri, 15 Aug 2025 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AVlmCUMK"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40F2620F5;
	Fri, 15 Aug 2025 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248695; cv=fail; b=RGjAgBlsE2FZrA82xprMPsmwSMl0LPYjRsGIW0Hdf/N8GHy1wVy+ecNoYTWwY9op/bphYvE8mKz0W0J2kK1oshkkwxhjro3FMh8i4TQ3tF/inaqXCs9Ntbo00Xx5mjZFU8oPvape0ZTZLlC+YLrQQFLgqiHgM1bsEQIMJ48C4Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248695; c=relaxed/simple;
	bh=U61bdwoPcZWxpq/4DUSPXB/ybLIc3TZkW14VXjI5GVk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cNRnTHr1mTBLCVRxUCwmSrLUrAMMwLXSv/1g4kYT6hM4Z1uqTiB5+n2gZ1HYKJ77YhnclazZR0yd96tZUfbZQX58MipBoZC9XGsHES/6BVAEJu+ybvQOgTbIPbISinLDlbxhW9POS0DjzsfMCwOplcXselHQLFJMSpvI/JgLisI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AVlmCUMK; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJsNgEMSNoIX9A7BaG6aj7On27Y0iRGxmVwkJMJEQ+4d7rf26M4dSastRS3/hPQdxQyldrGhwGsO4pafemuTinRFl37GxnMVUhNJgwWS3ichpOtSBPOmYSTpgCvDrAnCeNQmtLdCbgpPvVNp4xVorfzh3VCmXNFXF0lFhnbDtssOy13Bmi6LE/fZaNaU7GS5m6i7G/U7uk+4sDuPMfhB6TL9JFZdW//NcPp/aJ5TbMb/5jW39SUJXvx+bCl9QbxQnSUG9nnVrQDZ2kA96mWC/8Bv8MWmkMkur6ujhhD8qTt6zPjPYVnrGNIkFBSEmpyka/BrcI0jibfBQd7/8B2bYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEYnv5PBI0+8a3YqhpEkzGfcIJXMnROXG6hrrjUYaEY=;
 b=BnDcHpE/wg1M0e0m4SNScpmFpOqclNpJt/S2xPpHneHyyMCeRzL5UemR1quVT/sOI3NMXO61pYRGKQ5cXNnebTZPkupXiqy7UdEUr/FO6I3isG5NNKQbko+51hm1lzenhnxGLfGr+tJdL4PDkRdOXRaDXN63k7Ap8MuZ17eZ3fCBl77oRZX2BCqTlHPtBH5klLGnYdPFOXX8XONAJPjkJ77iGri9ZpGh1aiHtrlnidBFYqHEuLRA6MSYZp/st+1TGMbCkIPGWfH2/dq8+h6KCRFXiDhvpAoVXm4mSYCO8v3RQT3EpAuoGfKqczKeal2ixViCiUbJT4mtx3VP4CpSow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEYnv5PBI0+8a3YqhpEkzGfcIJXMnROXG6hrrjUYaEY=;
 b=AVlmCUMKqk6CPi35qAzQU323dpBNU/uCrhzk//URJQ4RuigfA+wVgxZrLfVgZjtXcaBSCXlaYa3T+q1oKgF4i38NVi58vYvYF0zBv3eiHyT4kSDmpmn1++lKutHNKeOfaCbFUi7ONMvdMd1LxhKqOQHE16vYZNKwUaJfp5hXCiGc67FaR/57dDCgeEJplaEwJ+UPPvXyN47p/GG7EbMeTZ+k2w5kzwFuC8xDEU5SzEa7BrHuqlYXjQZ8n8lLCNBWi9hdzPGosyxX1px6O5ZiFmhLkH/0Od11hAt1l26t1dbBfroHK9ep4mvJIWcMGXhMcgjPQaAKDSaTYwq70mWwSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 09:04:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:04:51 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:53 +0800
Subject: [PATCH 07/13] arm64: dts: imx95-evk: Update alias
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx9-dts-v1-7-e609eb4e3105@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=1655;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=U61bdwoPcZWxpq/4DUSPXB/ybLIc3TZkW14VXjI5GVk=;
 b=Gn0pwMLA19M65q2nj7pIgjxqdfrUYv/rzLFYyKh+/UyvIlAQe85YRyQDu1VbZvuuYcFxco1W1
 atUT1rcbOznBpv895jfMr9db1QO8/ZW+d9cQgiglbWWZfmkPKTN7eA+
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
X-MS-Office365-Filtering-Correlation-Id: b1a0a429-8941-407a-5ed4-08dddbdacad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akQyMldYSHJUVHhIRDRxMTUxNjhNWjhWam03dXF4M2NjOHNQeHF5b2hxYnJv?=
 =?utf-8?B?Rk1CRE5CczU4OUFEZFZTLzJQdjdMY1lTMmJqbWFKeXd2Rlp0c2dFY015cW8x?=
 =?utf-8?B?VHdENUNYTEhaNHprMXd6cXdWSndQa25NcmEra0xKUTJBUCtNMWtBUFczanIw?=
 =?utf-8?B?VVNFUDBoNGZMKzZYZy9lZDdrNVNsK25kMzhrMDU0blFsWXFuclBVUzBTdWpH?=
 =?utf-8?B?dHB1cHlubjJlZkpEZnNKdVh3dE5hZkxNUXMzVkd2WVpiNngvMHp3SEFRVFFM?=
 =?utf-8?B?ekc2cFFNYVhDbXM1eGl1b2ptd1dyajBCUlJYSnYwMmEvYXQ2dThUaFg2NlU2?=
 =?utf-8?B?cUZJYzRKZ3g0MlRpWVNKYXoycDZrSlNYNjhDMllmalhRZjFheHhaYWRxWHVS?=
 =?utf-8?B?aVU4K1ZDeFZoM0RkYXpGZkJERVkxVTBRcWFXZGROUkl5MXVOQWMxaDczUWtn?=
 =?utf-8?B?UEZ0RkRsc1B4NXlkZDZ0VWNRRG1JelFGUnc1WHEzUitrQ0JFaEt2UFR0QnB0?=
 =?utf-8?B?blorRmphbGxCL1JIaDRHUWpDbHpCM005ZVUyYXN1SE53TWJQK0xhMXBvNXZP?=
 =?utf-8?B?RHpXQmJHTWJzZjgrY2xqaG1hbUc3bjJ3NHp0cHVSRERGQS9BRHIzc1A3VExr?=
 =?utf-8?B?RFp2Z2RFQTVreFcrRGgwMnNsRnZiemhOeVF6bU5HTUpaRUEzSW83L0pJS2ZB?=
 =?utf-8?B?ZFBydnRvYkc2SnI1cFZQY3p1OGdJdU81WC9ueHJqcFVXSytYT3FYcDlXQldW?=
 =?utf-8?B?RVBLWGNTamsvMDB6V05nV2RON3FON3MrNm5HRWVYTGlNQXJlcm40Z0U0VEJO?=
 =?utf-8?B?cEZuYXdUeXpnNzlNek9DRlU1VUtjZDlzREUxSFJoSWUxY2RCYm1YZkdMdlFs?=
 =?utf-8?B?SmVrS3VOQ2VZODJ1MG9xVGwwS1lWVFdDZ084dG9pdWFZSVFOdm1mKzNubmZH?=
 =?utf-8?B?amR0cFdmaGhQQzJEaHQ4R3gvU085YXVXZklGcVpZTkRnRWZuanVvZnJaS2pI?=
 =?utf-8?B?OTFseDZpb1YwSmlGZUs0dWhVdDhnRmVqNDdScTFSVkkzZE9ydnZmdFJQNDJa?=
 =?utf-8?B?MjhlVTVvb2JVL2ZQTG9mRzZIWVVYMUNRNDNtbTFnNUwycEJma3c4aWpvT0hY?=
 =?utf-8?B?em9BKzJnTkFhRUVnTFlKUjZ3NlpEZURQTUl2L0tTRmdPSFpSYnpDVTQ2RkJF?=
 =?utf-8?B?VUY1T0xrQ1NDeWdpc3VnS2E2YzU0c1FrdU1nN1JxOTMwZWdHUVlWRjdIZmpE?=
 =?utf-8?B?WE5DWVRGQ20xUFdLNVVrRjR4SGZvWitQdkJ0cTJpanpRUWxEemxYU1ZORFJS?=
 =?utf-8?B?UnlBbFRFQWNTVml2Zi9UNFcvZVppbEhvUEVVZUdYb1NCMWUxWjBBQWZkb09E?=
 =?utf-8?B?RDBOT1Q3ZEorZlRpdzg1T0NDQ2lZMW1IbXY4YjFXblBieXVmWjJNMStaNkwr?=
 =?utf-8?B?eDgzSkdRUUFUVHhaSlFwNGJZSVlNRFExMjNvM2Z5MHRZR01MdHZSQ0VFOFBS?=
 =?utf-8?B?KytMeXNENmJVVjIvbEV2aWEwK3FmZmhDV1JaZWVTZWtpcHlObm9INjdzcE5v?=
 =?utf-8?B?OUhjMGw5czQ4M3hNOEFiaEZQV3NMdmUwWVhUN05IZGoyM3FxMm44TG13TjNw?=
 =?utf-8?B?bmZIK2RPc1JLRGxZL3RmazJXNFROK3BuVUNqcSs5U1hiUXA2NUlLRVpFdUFa?=
 =?utf-8?B?RmJMWkdLWnhGTVAvczU1ZTRjZE04dndCQit6RG1Hdmp5dzVJb2wzQ2c0bjBt?=
 =?utf-8?B?NXA1cUxXc2kwdG9aR3FYUk5qWHJGVHlFbUZUWkFJOVJHSmI2d2d3bEk4ODdu?=
 =?utf-8?B?b0lvRVBzWi9xak5GWWN4TEw2SlhVSW90ZWt2Y0JYRnFNcG9BRVAwSjBOY29U?=
 =?utf-8?B?VCs2UkJxdDRQY29GL3Flb1pONC9jOU9xMkVVOXB1ZGJrV3NmS1hKZjFEZzNY?=
 =?utf-8?B?bGlWcVRVWi9LS3d6Q0VjYjR4a3F4WHFoNUVzYWdoaVNZS2pSOXJrN3ZIcWlU?=
 =?utf-8?B?dGNGU3RlbVJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M25FNDFpZTA2MEExLzF1N0g3Mnh6a0pid2srYnBqUXpBTTc0Y3VEZkk0aXRM?=
 =?utf-8?B?cG8vZ3BkRzdJTFRhNmtZNEZhejE5ZHFRWEtjSkh0ejlQY1RvQzFEWHU0Yi9a?=
 =?utf-8?B?TkUyRUNpUmF0U0tzSXpLRkZQMmd6WkxHejMzTTJqM0dheU9uSjdvNzRZaTdy?=
 =?utf-8?B?THJYSTFTMnhkZWtiVUlqR2pIekk4U3dRc1F5S1I0cnVFRzhsZkpIM2k5SGQ1?=
 =?utf-8?B?eTJvdEl0ajVXMnhtNFNjTFkxMGl1VmlTV0hYZ3pFSWg1Vm9hOGkvT3pKRHZJ?=
 =?utf-8?B?cjBkdjMySnJ0V0FDSFJCOVFBM2graVlwZzdqWGcrSEEyYlNRaU1nTWdHQ2s0?=
 =?utf-8?B?YWFIMUs1ejVGWGV6VkdwckZlNDIxMTM5RlplcUxmYXFQL2h4NCtTd1lUbGxo?=
 =?utf-8?B?UlBQdGpoUnZpZkFnN2ZOWUhqemtpaGwwSFAySk55aXVpVUphQlJzeVdKK0d6?=
 =?utf-8?B?TFUybnI0YUFsK1ZyU1laNkVPcFlKUVlCQnlGWnZGWkxZNnQvTjBKTyt5QlI2?=
 =?utf-8?B?OWZ6ZW9OcldVMHVpOHFqOTVkTENmaDYxZ3BURVE4c3ZhM08vcTRhaVZNd09Q?=
 =?utf-8?B?QWVnVENSSGpXWkhNSGhUZU9KWVhFZlNieTB1U21UY09vKzcveFFVTExOT2pq?=
 =?utf-8?B?Znord0tBazdNUlYvUFFRSDAvMTBkRWpxZlN0eklCNmZ4TUlRc09vNS93ZEgz?=
 =?utf-8?B?S2JjeVNIandmUE9kcU16QU1lYVlQaVBIRmlSdFZWQmQrdUREWFM5WmthS2xa?=
 =?utf-8?B?emlQaDZvaXNkbVNCWGdwb1pra0JZOVlHcGNTT2NWQnNoaVJaMlQvdHo0RGxT?=
 =?utf-8?B?Wm0wUllEU1hBOWp3ZXdqcWNUNjIyZVRlbnI1TGRZUjVCU3Q0MURHR3NpSTVr?=
 =?utf-8?B?TENHcnZxMHZWQVBOK1NvaDRTV3l0K2M1b0lXYjNWMC8wdW9YcVA5Z1h2THN2?=
 =?utf-8?B?Nnp4RkhBL3NpL1VtK0lMRi9PZW1OenhiblcwUTFFcGNLSjg3cHNzS3A3UDdp?=
 =?utf-8?B?c3dHeWZpNER4YWJLUnFlbVlZZG9qTVZDVmRBUXRUMDYyQlQvY2NYcjZRamJ1?=
 =?utf-8?B?bzhVTFNRRFVoWWh6WDQvM1RhQmtkYVF1MXVHZDR6VklvRktZVlNFRi9sREwz?=
 =?utf-8?B?OXNaMW1Kdmtsc0NaQkRFeDZJTWlFRkZWclJrY2lwcjdZR2FYRkFJb3JoZ0k0?=
 =?utf-8?B?NXpKWXRZdnBTSGdQYzk0ZU5QNkZ2ZTV1NGVWZFZUWUZ2djFuenE4dy96Rzgy?=
 =?utf-8?B?OVYrSEJtbDNkbW9ZQlFueWIvWkVSblo4ZTFkYlhWZEZFaHpVRGx1cmMxWlpa?=
 =?utf-8?B?UGlGZ1FxN1dWUGVBYWN5bGhpR0xjdG9nTE1POWxVSloyeWppdmlsN1BEeG1X?=
 =?utf-8?B?TWovR2VkNDRjNjQyVCtOVXVIOXFXaXhtcmhabGtJVlpVVmp5clhrdUZnR3dh?=
 =?utf-8?B?NnBFbXRtWTRxTHpGdzJCUW9ZcS9Zc2Zvano2dG9RZEQzVHZtbnV4dnBQbExX?=
 =?utf-8?B?aXVPeWp4dC9ZV2owQVhUZEpyWnNJck83SWxKdWZvdjJYYkFsaTB5M0lBWGgz?=
 =?utf-8?B?L1RBaVdXSjA2QVk3WmJQZXd2SzBLT3krQi9QbEkxenpRd0VrUjFRN0x3Mkxy?=
 =?utf-8?B?RXQ3cGtpS3I1WHBmV0tOU25zVHJqM3FlRjB0ME02eFlZTzhCU2pIVmFBc3lD?=
 =?utf-8?B?Z043REk4UGkzNjFHbytLVDBVSk92YWdKQm5sL2dCWmRFVXBsSUhxcUlIVkJP?=
 =?utf-8?B?TEY2c1VsZUd4NmhySUdtWjJ3Z1hmUXJVeEZjL2xzYzlheHM4TnIyQktvaGZN?=
 =?utf-8?B?MXZyNGNsb0lLc2MrdTFwQlh6TnlLK05wWXMzbjJxVm1NL2JNY3NaVklCVXFS?=
 =?utf-8?B?WWVJRnk2bTZZVVpmc2kwcktUMTFmSjE1Z0I2Rno5M3lZVUJqYnN6OHhDVEVY?=
 =?utf-8?B?M3pMMFBBWHRwVjAyMW5paVI2UDNwQmVUNnBMSVh1emFhVXdlQnhOS0RvZlNM?=
 =?utf-8?B?T0dGVW5vRjZiam5Ya1RCVWFYSXhyUExyeDBGY0pzQ0tPb1VLVnB3T1Z3SkVh?=
 =?utf-8?B?V00xUFZpK2YxcFNPZzcwTXUrRytjRTVic1VGRG13TzBoNWIwSFIrQnQvMTJ6?=
 =?utf-8?Q?xrbCNWAhwG35oBSmOvvDOlX5m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a0a429-8941-407a-5ed4-08dddbdacad8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:04:51.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9BJ6NXD/+kgi6Xdl8GNfwAXx8h4MEhNQ8cYN25eePCS0OJGSgqJSjU5SX50Iktn4p4RSy0OupsGm/RqGyQeJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

Add i2c, gpio, mmc, serial alias for 15x15 EVK and add lpuart5 serial
alias for 19x19 EVK.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  1 +
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 46f6e0fbf2b09106e6e726ff8b61522d1359cfa4..de7f4321e5f9d7d6a6c46741d3710756dd2b69cf 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -28,7 +28,24 @@ / {
 	aliases {
 		ethernet0 = &enetc_port0;
 		ethernet1 = &enetc_port1;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
 		serial0 = &lpuart1;
+		serial4 = &lpuart5;
 	};
 
 	bt_sco_codec: bt-sco-codec {
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 2f949a0d48d2d8066388884703c3b3cd678f16e1..39815b21d235d2f8cfa49720d3be49d056ea039a 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -40,6 +40,7 @@ aliases {
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		serial0 = &lpuart1;
+		serial4 = &lpuart5;
 	};
 
 	bt_sco_codec: audio-codec-bt-sco {

-- 
2.37.1


