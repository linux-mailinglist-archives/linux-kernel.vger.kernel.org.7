Return-Path: <linux-kernel+bounces-856538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC47BE46DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B921C5E288A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C8D350D52;
	Thu, 16 Oct 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AbvpyiA5"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997734DCE6;
	Thu, 16 Oct 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630426; cv=fail; b=qx70us/CIEMOYDtJsJhbCX6hAJGdgGD8b/+iwAaB+sI5GBh+g7fBL12mPU4rhG+RR4TfxqZKfYM2nZHSICODRsmaOXWfTIXG+zGhl87cp3F4KfKK2Q1bbvQ25ScQFyjUxHQjqQrZzwpqE6F7IMSRsaQDJoqRR+Dc7Nxj78g3tME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630426; c=relaxed/simple;
	bh=Ox4kTpcXXfxrAeNDt839yNnEHBpdgO9iOa3pbjknOL0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l9mPxmbQz9iOnoz0e4lC5ocuy/20jXMeY1YSOrxpRXpnVm5j0nLTne/a/YeAtHWinjfSM9h1JQ8hzNSELia+18cDPQOboKNtPOn/NIknkGO/VOpIxcETvW69WjG8+tyiDxMspQt4jfbgUYqH0Tcvmu/bZQ9njPs7Uk0+fKUg9S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AbvpyiA5; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRVMhA3opZDkZVPWtSShpgYf7+JAmlM0loyjjnKRqyyHONwULkF4rpBWvB9w79EJBCa26VI96LYN8pQCF6Zpr4u2AEtqe8CWWEpg3FIQLc+RwFpekDh1DIQCKmGfU9Hw2d6BszM3o7UJS9KlhLVBefowYn1yYGZILqZrpLU1Y/r1OYztc5m6IMIlGzr5z8eiNbZE/yIpubt/Y/BteEz1I/k0ovMdGWPiMy/u8yda4wzxLI3fuWhKg0xwujtiyUxBKAp1YHd/pw447tRAJHrLzig1aZoCXOlBdGK/xkVRRBYvif1q933qJS1mGFtqcERi0J0FWSmC2INLIvu70UFAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOw67SIDS2bc6pmEmHnvZKVC9X08iOO+XmH05QSw0y4=;
 b=EAP7ql3MAzYk/xL5E1X30qSF5426EGqFQh69xUpiuRjeRv061XqW05K8kkxGyJUfcA6JZfWcFFc5stKGfAppjbNoMJVz0gMZEkcnwZKePrzi/0kEMpiAEjeizhp+0O8d30TyfbAZV96a/i3tUNKEgXW4GusRlHLUEYV23NLZkuN+FVEW/dYmrgcTCLCAgRmwKxlBEFtO9rK5U7w4tWyUQErPOfYKh80jEP46SZDV0Bp0vcBIlc4hLRMy0S2DHMk9XgzT87lYZJlQajZYFlPM7aG5Wq+NK0IeRaIeVvXbkrXY0juyvv+mAgLgZ/CvmZNfHOcWCpVhvjFOKGjWpxC4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOw67SIDS2bc6pmEmHnvZKVC9X08iOO+XmH05QSw0y4=;
 b=AbvpyiA5wZ7QJRXqzNPCQ2OsnfWofEoR11n0FynyUqOSBpz7La29vRNTwEJrIYoWfS4SkmhOfFh5sJoUBCbOu4qfwfbHekTH4M0QGjtzVCbT/CEE5YBE80/aI+6ni6s7Vu7WZpDcKyHIRvKbyFe2a6+e8E07eUr/tVMB1SobGhC0CMXsc4FrCDSL2wkJGHhrsRqMWv/3xip6rETGABpJgljbsFolOJCfHtenvP5vPVY4DnUBpfvrNHPU7Qt+SlPuIaSE+RnUH4TQiARznvP3GQDr0PEm/GfI66JEIlWEzCh2f1C7GxQq4GiYpsKobbTYLO/FAv+IFCdsD1nUkNyZ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA3PR04MB11203.eurprd04.prod.outlook.com (2603:10a6:102:4ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:00:20 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:00:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 16 Oct 2025 12:00:05 -0400
Subject: [PATCH v3 01/11] ARM: dts: imx6: rename stmpgpio to gpio
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-imx6_dts_cleanup-v3-1-baf2814f8a15@nxp.com>
References: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
In-Reply-To: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760630413; l=3867;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ox4kTpcXXfxrAeNDt839yNnEHBpdgO9iOa3pbjknOL0=;
 b=+j7fHFY1fAB5d03kxFMYiUtkOpXABO6BLYxOZb1OkrAizC4rCGZMWPTgcHPbL+lCCJ50tEs3U
 QqGoqaZS6NRDzKAnzvfiZHgXlsQok8iOSh+g3rFUdloUJnLi5Ra+z8g
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA3PR04MB11203:EE_
X-MS-Office365-Filtering-Correlation-Id: 682d5494-107b-4d25-2b62-08de0ccd1b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFprRDExQmRMZzl3ckgzY0dOalp6b0drb3hnaTRRdCtyZDRNVmRNa0ZPemxz?=
 =?utf-8?B?U2NtS0xsNFFrdXljaGtkS2haT1FrVzdEbUtzV0FzQ1JIbXBVaTVKcFZ2U3pE?=
 =?utf-8?B?b3ZQaHI0ZzgybVczNjhQd3o5Szd3dVg3RmxIMERuSE9lamtQUzdYRGYzQVVi?=
 =?utf-8?B?TUM3c2NKajlKRjdxVENpWGcwVWpWTUc1UHVheE13QlZjcjNjRyt4b20zTmJk?=
 =?utf-8?B?U0NNakhZVlNpYUtxekZsUmRjQU9UaU1RMVgwRUtJRGhZcWgzNmZBKzNiWDJL?=
 =?utf-8?B?SVdTQ01IUUFsT241dUphR3Y4dDIwWkJUc25sVGtkTSt1QWJ4UjZ2cW9UZzZn?=
 =?utf-8?B?czd2azF4Nm5pMDdVbnAvdUNSMmxISUkva2ZjMTI2QWZRbzNZa1pmQ2pST3RG?=
 =?utf-8?B?Rm9HOW92N1FaM3NwRUZYTytId2dhUUNLV1I2SE1jRmgvUGVPQmhqdkVZaEp2?=
 =?utf-8?B?dWJIcUloVnd6YzRWdDFuN0FtNzJpOVhvRGRvVWc0VXlJYk5wNis0T0Z0UHlR?=
 =?utf-8?B?WDcrT0hUT0Q1eUlnYnA3UW1qUUlRL3kvZ2lyR0xSeE1KQVJ2elpleEVoeVlt?=
 =?utf-8?B?bTBRWTRKRDdFb1kvTm1rOTdjU1lZdnRnU3N5QzR6M1F1WGtkL0xrRlBub0Jr?=
 =?utf-8?B?L2pDUUdMNXZKdHQrNTJQY0hkM25tcmNVSmI1dU9PTHh6RlNaWUhHMlluMDNX?=
 =?utf-8?B?R0hTQkJOUm9jWXE5RTh3MFJqVlluYXA3ZGNwOUdmUlJhMURTb3FoVjJVRVFS?=
 =?utf-8?B?ZVBIWEFjSmlFR0JIOFRiNi9wRkFiUHJtd3VITmNUSkFCbnhEQ25HNmF5RWI2?=
 =?utf-8?B?R3V1aXdtS3VkNTE5ajkwVktLZ01KcUJyTGFBMDBRUU5KSUtOTE9nVTlSVUUr?=
 =?utf-8?B?MGpOcFdyUnVFS3B5ckkreEhGRTZ1SURQQ3F3aE83bkFNMU1zQ3RvVWNOZmZa?=
 =?utf-8?B?WUdRcWJjN0k0MDZaTXR6WVBtNXA2dEd1aGVsYVFsVXlJaUZCUXY4MFhrM2tK?=
 =?utf-8?B?NTRPbW1PbHRITzFwUXRRNE9pVG1RdE9PSk85UTJkM3Fwb3gxV0Z5VTFOMXJG?=
 =?utf-8?B?alBoVk43ZzdGOHVsU0VmWElXQVIzdkVwMGQwZzFzVXJNYkdBVWpwdHM4eU5p?=
 =?utf-8?B?akJWaXdBL3hYVWxrRjR0UExWYWtCa3dHbmFldmhaTGxlcko2dkJicC9Ldkpm?=
 =?utf-8?B?WC94aExWem42OGFmUWZYT1pkN2Y1a0RYVEp2bVFIQ1U1eSt0a3lKR0lpeTdJ?=
 =?utf-8?B?ZjFqSTRsR0w5TnVwRDJXVVNiYjhzTTY0MjcrbHR0Y3BXcVRNRlJ6WHEwU25X?=
 =?utf-8?B?eEY1TTgzM1NydURFMGpGaEVsRFA0RitsYVV3S1QzVkVrMDJXZjFTZkFUek8y?=
 =?utf-8?B?ZjBDRXk2ZFdNOXRGUTdGU1luWXZZeXJvUTJxaGtQdnhZL2pvTHVxY0FCMW05?=
 =?utf-8?B?M3hwa1J3MVhiODQzTXFyaFQ0bFJoSmtJbElvYnVFdkZ4bFVRNlQ1T2hzc2xZ?=
 =?utf-8?B?OWIwWDlHU3dlZlFlaUp6bDN4Y3BoVGYzNFF5T2Z4dmQ1SDZkL0NjcVExMVl3?=
 =?utf-8?B?dWxzekdiczBKR3IvUzBaODhXc3MzSm01dkFlVVoyQWJjT3dOZitobVppRjBW?=
 =?utf-8?B?enJ6L0FiendOWEZDN25lK0dJaDFCUTUxS05hWHNtWk9LQjhaalFNRHh0Yk4z?=
 =?utf-8?B?MEh5OUszVUNjaGZwZTE4QklhODNoN2twTGswRVJnK0w1dDBnR2Z4OFFLcnlo?=
 =?utf-8?B?dS95dEpQRmNPUFBjTnJLb1NoYm9mUDUraGRCV2pPTVR4VmZFUzg0Y1hDZUJs?=
 =?utf-8?B?NkwwQ0xsamk0Y0NCNDJ6ZjdxL254cm1sckdrZ1NsVVJFajJ5UDhwdFhucGNX?=
 =?utf-8?B?R2RUemRtQjFmeDJ6ZnBPY2Z4cUpDbnJNZERKWFBEaFl1Uk15cnRLeFRGWGpE?=
 =?utf-8?B?ZEFqTmUyOFVwbXV2K1NZTXlGT2c0ckFzQmJQL21Cczh4SGw3NDRmSHBxbjgv?=
 =?utf-8?B?aEJyLzlGcDdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0lZK2VlRDI2aitBU2dNcDN3Yks1ZjcrNlVncFhKRitma3BVUW5tWTJZS3hn?=
 =?utf-8?B?UG5IRUhvNG9MNGtCY3hPMkVyUEUxUUtYRnlBVEhXdEltM2c2SkdTSXBTckJ0?=
 =?utf-8?B?bEM0SjByalBvVElnYk96Q0k4R0VBTFVxTk1oNHBGNHluWS92UHVkWktIa0VX?=
 =?utf-8?B?OEhzMno1NWJBL2dPY2RZZm0ydHpjUW1haHNiNlp3S29NYnpEY3NDN2Uxc1FH?=
 =?utf-8?B?T0hvaXZFRXlCcmp2blpJMFY5bHRNRFdCRlpacEhZY2c0c1ZkN2wzOXMrV25I?=
 =?utf-8?B?bnN3QXgzQUtEelZCSEhlTG5DdlVEUThZdlROVzRvS1VFTnphak1WRVAwYTBR?=
 =?utf-8?B?SE1KbFl6emtUUHl4NXdVVmxKcURkTnNKRWVnam5HMURIVzBlL3hxMm5EcHpo?=
 =?utf-8?B?Z0RxQ3V0OGlYVHh3SVVyTUIvU0d5N0d5SHd1enQwNTdZM1ppYVZDenJLcTdB?=
 =?utf-8?B?Q3E2LzZqNEtSMUIrbzdra0RsUjZHbXE2Qy9IRTFkektqcFBCRTdYWjlmRnBD?=
 =?utf-8?B?UHFPS3k0SXlXb2R6UzF6dlhJQnFyV0NIQWI4L0plMDlMS21GdXpMY3Z0Q1pV?=
 =?utf-8?B?UkdaL3lSOUsyM3ZKZnNQYWJ2b1RKL2xrWGZ0Z3BvTkN6d2tjc2liLzJGZm9J?=
 =?utf-8?B?RWxQaDJPS0lBRW9rNG5UUERsMTR0WHNsUHFmZUJJM1JocGs2Q21oS080YzND?=
 =?utf-8?B?d29kL3JEVkkzc0k4OGhsMDJ0US9IZFIweFhJMTdENUQ1UjZuamRxQUY1MHhK?=
 =?utf-8?B?d3lvYXhxTHJzVXpBS0xsSitkQTdFWjk0VkVEcEZ3NTM4M1JPYWFSSGs1WkJl?=
 =?utf-8?B?VCtiZ3NadUNMaGFBOWFNVzRVeHh3eGt4VlNxbjgrRWlpTFJCMzlUMUNyWEJL?=
 =?utf-8?B?dWVmMUlRZnQrL243YzN5QzdrUlJDaUxXOGhWelVjbGpoRDg3SnRCd1JtaFYw?=
 =?utf-8?B?eXpDcUxHeDdGcU1jYU9lQ0FOckFYUnVpS0hCNUYzZ3lwejhENVkybVUyN1E5?=
 =?utf-8?B?SklUNVpIWExadmIwUnZObmRaeEdNck9SSTBIcTZkQmNFK09zT1BOWjBxUENT?=
 =?utf-8?B?SlA0M1Q3WFpxZTNrWlh0T2pWM0hQUHcrUkxKdFI2dE1xN1dOZS8rcXNiczJN?=
 =?utf-8?B?WmZTVW1Mbjk1Mk5pUU81Rm84Q0RITTJtZUo5dEx6Vm1OeVM1SmxPbnlXb05l?=
 =?utf-8?B?d1pwaXZ6eGtFaDV6cWtQcHpQMGJVQkgzaTJjNHRmYmdhU1M2U0llNzBLTjN3?=
 =?utf-8?B?L0lTOUM0REMrY0hIN2Z0Rkp6aG5BVUpuelhUakRtMGZzQnRlc2Y1N1RSeE55?=
 =?utf-8?B?LzM5QWZrelYrdnd1ZzJFcVY2a3RQQzRsdzRpVWxCSDlabVBVSzBwa1BJMjJz?=
 =?utf-8?B?SEQrTkp4VEtjUHlzdksvT1FpU2hWNlk3UWpNVVJybGVlcTVZRWNuczNkUlQy?=
 =?utf-8?B?T25vWC9wZlo1S0xkb1NEN0JDVnZDMnJuZUZ0M3NsS2RlelF0QW5mcHRDV3JV?=
 =?utf-8?B?MzM0Tm1MYkkwaFhhbkpKREVBRklIZkM0a0g1TURLSXNNMk85VXZxVTI1TFUx?=
 =?utf-8?B?eW0rQlcweld0T2JGTWpoZFF6V2dZOVJVS2w4YTJDOU1EUzhJRG0xSDlRVyti?=
 =?utf-8?B?MzEreXg2THcrV0x4a05xelVrUkx6WXRBVmxwZnRTN3oxVUl3Sld3OWNBcnFO?=
 =?utf-8?B?V0tEejlZZHFSeEhBcGxrejBOSGcybnlOaDZ3VkdWTmtkdytzbUtCTzNoYlBW?=
 =?utf-8?B?RHVhTVp6UFpPUjZ1R0ZTamNRSi9HMkhiZEtaV2dGSjlEVFdqekdwVUFVODdh?=
 =?utf-8?B?aU56emRXek53U1ByOTVwRW1wcTNrdU9Yb29MVmxPTDQwNXdDSDdPSGhNTURL?=
 =?utf-8?B?d2NxZGFMUkwxU3YxcUJjb1N3d2hyU2p3ZFF3S1lZUTZaMXFkQ3JlNUhPQWFV?=
 =?utf-8?B?TmRRMTlmMktOaHBSUkh6S3F2RzFzdFpoVGNXRExTL1V4SDl5UFBWS3FLVG5a?=
 =?utf-8?B?UEVXZzNWNzlsQ1BBZ29GeGQyY1YrRVNRTFVibG9IbG5weXBJeUJqTFgrL1NF?=
 =?utf-8?B?VndUQUpoZ0ZEU2cyVEVGWW53MlRlcHpzbGtubFZvQmJ5dm5lRjZLaHFqR3RE?=
 =?utf-8?Q?6pqASB82WU0aoDhanxAyghxZY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682d5494-107b-4d25-2b62-08de0ccd1b97
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:00:20.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNEOQO9h3yIcutmPrQvROpLs4X4RJXtnitpSizE3Wa0ddCTb5fwzY0h2+c7T6kI/q6Xsv6DRj9DGKIOJVOgcVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11203

Rename stmpgpio to gpio and add gpio-controller and interrupt-controller.
Rename stmpe_adc to adc. Move interrupt-controller and gpio-controller
under gpio node.

to fix below CHECK_DTBS warnings:

/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: stmpe1601@40 (st,stmpe1601): gpio: 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: gpio (st,stmpe-gpio): 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml#
/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: stmpe1601@44 (st,stmpe1601): gpio: 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: gpio (st,stmpe-gpio): 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts | 10 ++++++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi  |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi     | 12 +++++++++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
index 17fabff80e903f621814492a8f8b837c5721adbe..cbe580dec182e1428d39477fa800a6e5ae1fe20c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
@@ -236,9 +236,12 @@ stmpe1: stmpe1601@40 {
 		vcc-supply = <&sw2_reg>;
 		vio-supply = <&sw2_reg>;
 
-		stmpe_gpio1: stmpe_gpio {
+		stmpe_gpio1: gpio {
 			#gpio-cells = <2>;
 			compatible = "st,stmpe-gpio";
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 		};
 	};
 
@@ -250,9 +253,12 @@ stmpe2: stmpe1601@44 {
 		vcc-supply = <&sw2_reg>;
 		vio-supply = <&sw2_reg>;
 
-		stmpe_gpio2: stmpe_gpio {
+		stmpe_gpio2: gpio {
 			#gpio-cells = <2>;
 			compatible = "st,stmpe-gpio";
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
index 419d85b5a66061d4389df5d42de626183c27a9e6..8a0ce250e57607ef157fe34859cf77f45f54935b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
@@ -589,7 +589,7 @@ stmpe_ts: touchscreen {
 			st,touch-det-delay = <5>;
 		};
 
-		stmpe_adc: stmpe_adc {
+		stmpe_adc: adc {
 			compatible = "st,stmpe-adc";
 			/* forbid to use ADC channels 3-0 (touch) */
 			st,norequest-mask = <0x0F>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
index 4c09bb31269662adeb0b06991f45765935bef01e..e34c8cbe36aec682f46ffa128247bc47f3a6cab9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
@@ -122,15 +122,21 @@ sgtl5000: codec@a {
 		VDDD-supply = <&reg_1p8v>;
 	};
 
-	stmpe811: gpio-expander@44 {
+	gpio-expander@44 {
 		compatible = "st,stmpe811";
 		reg = <0x44>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_stmpe>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
+
+		gpio {
+			compatible = "st,stmpe-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 
 		stmpe: touchscreen {
 			compatible = "st,stmpe-ts";

-- 
2.34.1


