Return-Path: <linux-kernel+bounces-896606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC000C50C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E05D34C013
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E482E718B;
	Wed, 12 Nov 2025 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JxLFDslJ"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722A2E62D9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930090; cv=fail; b=aMPOW5UiiXnApyWoIz570eKws0S2GWdDScv2XPpAbFTv3w2So2ufS1rfO041jBy+8Hdo5eKeASlk19o0pUJ2yaNwWE/hw60tz9DUzXF5JfPJ6PBcjMUi+pJZ3B1y32fWXB1IuIJ18whr1na7gWMcuS3hK/esd00ePC55CtGj8mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930090; c=relaxed/simple;
	bh=cKir5GY9MDPVxXpDKgg0UgEtFcz2CrFU9GyO/yNUjDE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ajv2FSijEXm5Tr/LGEcOa/pPjECn/xDt0kymkzBRsLaQoytTvhy21qd3jHetQ6FyhxweAompmsMgP8baSQUZS4Vm02u3S6HmfzPgxKRCe0sV0AuejcBMCpV4KVFyTCXYn66jbvxGT7kESR/Avp4ZSKE0o0pMkqhmi/pxJulhpLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JxLFDslJ; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBDTVeiwz65kh8T316BDh9jFdJp+IDWmGya8TIe6F0Q1dwJQNlC5AWZkX6Tzs7W5MsoJuJSpysTEfPFZI3kAjqCTkmZnGB/isMJXUsRkKhXXe4ll/ZlsQJj+PIeQ6bwyxlmwQfVFWOEmtkXJkRt4b2iUu/ZcPqf+hdhRMKxGDVpkdpnpi7BJjaGSjaIwJ5GUUXvuf4f35o4PGWRCjybQBG9pOITawiW+4RItPsE8gKjjoMfn/hCmVPQwGSpYmN/lxKbtC4pcnnwDj+8QShJNDcIwrHsZIo1+x1clD5OLuKMZL2UapTuv1Tx+vMOicvpQTsVLXFJLqj5jWK7q/DRO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2wHNjMJIeExzSbRi+BrgexIPrcHFzYxr7myJ9CjTyU=;
 b=OFwdDNU93IjHTyT02PF5KPy81ZH7LKTPuKKI+X2yVvLpBEinWcYl18+JT/IPQMfOtIrALTlSOVd+o33F4EQNoAckZvTYt3HxLEx4e/NFzLVJJGMixoiUMnl9MZ/cujJaIAgl6joPeQPkhfcab5G3w1L9XDgOy7AqiVoqFWpdn+L0DzuIeLCcbyON7wFUX9NtuDPspMzMysjUfXJYrf/DHDB4NnRQXuhSP9iBfdnUnhZqYSdTihfPGYSm0aIH4A4ahioUL+jHMkkrgiOzkzikL1u0fnyDUxbfCYXq4N4bLiMh5Na7RRnDAJ7J6UU0aunTdzEh++Yg/lFSROzYQQiF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2wHNjMJIeExzSbRi+BrgexIPrcHFzYxr7myJ9CjTyU=;
 b=JxLFDslJcRox1amICn1BiqkNGLpzTPQXONLYsddYmjSkhIXxfPBi2HkG1vbQEbePHym++4h/7vkfpe8eeBpt7zK2DM73uoChSLugQ0rnsO7mOk1KaBSObj+cpixvQsI+gconYnJSxzsg7k64cHhkxXMKQKzNkBjM4kdt+kP19j1r8XWA13qyAAQYk0pQUX58vhtutg0nhQnDbKNDrMgMqYyV/XBd1dS8hBKiG0V32KiUOEesk9AhJJi/T97k8tUiIcli6Kt79K2zlyDAGwKj4FkO37+OOKuCFcd3G8TUje44NtPaFE+TJsTI2l56Utv7KadzcX/wu3/ttEH2P/30zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV2PR04MB11301.eurprd04.prod.outlook.com (2603:10a6:150:2b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:48:05 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:48:05 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 14:48:08 +0800
Subject: [PATCH v3 5/5] mtd: spi-nor: micron-st: add comment for
 mt35xu02gcba
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v3-5-20aaff727c7d@nxp.com>
References: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
In-Reply-To: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762930121; l=1213;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=cKir5GY9MDPVxXpDKgg0UgEtFcz2CrFU9GyO/yNUjDE=;
 b=Ofw/5v7HFoKXWQo185j2dUEmHMwoeBZ1Als/+lQEJqg8JSuTf80oFyy6Vy3rEokcCLUlrhWjx
 Am1ng0sS3WSCDhoPelG02+Mn/X+zWNnIe0XFz8Cc2iY9Js/uu7A2YiC
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV2PR04MB11301:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b1e6ca-1214-4bcb-ccf4-08de21b76e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU9QYkd2Unp5aXVzVVFUcGl0ZFBkOVJTOE5GOHBTRGdXNG9xY1FiZVJ0L1px?=
 =?utf-8?B?L0p5WVZ0c1RtWXpJRUtTUVNKOEoxNnVZWGZSR0hiQlVxRC92aHZCTVg0clVH?=
 =?utf-8?B?bG8yRC9QYUNldTdUdUZFbWc4SEdyUTh3WEZTYmF4YUV1Mmo1ZUtjMHM0UTA1?=
 =?utf-8?B?UGwrQjVaRUlnWlZlUXZjcDV2OEczekNvTmRlMDBmK3RqQlpHSlFYVUdXWUov?=
 =?utf-8?B?U3B2REU4b2hKWmYxRlF3bnp4cER2TDV3aTBHbERoc04yNmtjeHZESW5QWmcz?=
 =?utf-8?B?MjN0aXFuTXBoOHhVdDVFc3RqUTFyaFZEd3R2ZU43bHQwalNITXlxM1dOK3hZ?=
 =?utf-8?B?RjVUM1l4Zk1XZ3RSRnJUMFQ4RFVRaGcvdUdHTFlLc0hKTDlram1WWHJGREta?=
 =?utf-8?B?b3RPN3pWU2tUK2pWb1FGaXZoYlV2UE5oQWJmTVhLKy8yZCtlYXIwWVpEMWxQ?=
 =?utf-8?B?NE5rU0F6aWU1RFVKK251NnQvRloyaGtUNUpDTUZxUEtXZHlPcUJuVy9aZ204?=
 =?utf-8?B?L1pLRStINmJzNlhBbmZhaTIzUmJSN0RmSzU5VlNBZ01SaXdEN0ZKZERRNjZs?=
 =?utf-8?B?dUFiRmVXMlZOazJ3TFRCSllKN0NmVUtZMWREN01aenowbGdZRWI3aUROamJE?=
 =?utf-8?B?T1lIcXVHWlY0S0NSVDZidnA0VVNoV01qRzV4VG8rZlZ5cFVBTXVYSTFMajcx?=
 =?utf-8?B?bS9oQmVmeU0ycVVyekhxcjhYQ0dacTgwd2hya0JkUm4xTjdoTG5UZ0tJQ0lX?=
 =?utf-8?B?QU12eDlpTHRwZHd2RVBEWjlnMlY5M0g2NWEwSWx5N0ZiM2FVdFBXMXRuZ1U5?=
 =?utf-8?B?UHBzUWMzdWt1aFU5MU85RGRrbUt1TGpCZmVlZGNtYml6OWZwTVlxbDd6MmZ4?=
 =?utf-8?B?UWhsMFVuNTVLdlZZZENaaFAxSGlxZUVIck1HMU16SnN1cHV3MWNGcWVZcHgr?=
 =?utf-8?B?R2tseXE3U09vOWx5U1RDdloyaXFwNmFGZVNYUzRpMFcxVkg5a3NEMkZGalll?=
 =?utf-8?B?aWpPeExCZ0xxaGt6dVVwWVBjZk9HRUtWdFRISTUrajBORlVUS0xMMUZ2SWpH?=
 =?utf-8?B?a29VMDhWV0VGQkJJS2xjbFBjOTIrRHJ4cVdKWithWnJkcWdYellaTzVjVERR?=
 =?utf-8?B?TTY2T2dMYzNKMWhYVEpWOVFURE8weHA0VHVKeE1vS2NiTCtUNnMrMmwwZXll?=
 =?utf-8?B?MElwQmdkTkNkVzdNRmltWTN3elNjWngwcFcrR1ZrL082aTNYMkkxVkcyQ2V5?=
 =?utf-8?B?OU5jYkZVY3lKKzdCRTUybHB0TG0wZFZBVWZnVFNOZkNCVFEyd1A4MXZFajZJ?=
 =?utf-8?B?R0JaakJmSU5hL1JFYTd4VzFSM3Q5VUxUUk0yWjBHWVBrOGQxRXFUcU9rM29i?=
 =?utf-8?B?eWpkS3FuMnNCUmR5UjU5MWJ4Tlp4cHdDamIyL1BFT2l4QkxkQ1NOcjA2Nk9U?=
 =?utf-8?B?ckl6aFdCWW1teXduanFuWC9ST3hKamJodGxaRzloRms2UU5IbE93RngvLzFI?=
 =?utf-8?B?VE8yV2pocXQrMks2MEh0Y2xTYXZiN2tVZ25ZQk9uY3BOZTZSVmFnTjFwbkhI?=
 =?utf-8?B?bHkwSmRLeTRhbEk1cTcvbTRPMTNlb1d1RHlTZzJMemJOQ1lpaGNtYW1aZU9r?=
 =?utf-8?B?aXVFZFhDa2kwMTVlT0YzRlBna3pXME85Z3NITFNpRENHL3h2azZEdUR4dVVm?=
 =?utf-8?B?RHF3V2N6S1BxRjVneTRrM3Q0S0dhbTIrdTRuZ2t4eDZ2RFFDdHVqT2pKL2ti?=
 =?utf-8?B?TWtQVEpuYythZkkvbXJqbkdkU2Rjem1XTzdTVzdaNjMxNkJEZEx5ekd2V2JY?=
 =?utf-8?B?RGtKcWtTbTJidmNQN1dsK0NhMEVhOWxqeXhEYnM1clBoR2lUNFBoc2NOVCtW?=
 =?utf-8?B?Y09aVk5RanhQU1Z4SlEyZzZPSHdXWWR4NmY2Q0QyM2NaNWN5eXZ0blNyaENM?=
 =?utf-8?B?NVAxOC9DUEU5L0F1ZXIzNDg0R0piVGxIZmw0ekVFS0lqT3U3QzZReVhyRnl2?=
 =?utf-8?B?V1p4dnhMNXR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2ZFd1lnQmtkWjcxMk40RzlKYkI5QTducERFSFRpRlNtakU5MHFqcG9rSWJY?=
 =?utf-8?B?Y29UNGRuT09IVERxSkdZUjJaV0ZiQ3YvcGdiSkZZRFllSFV0SnZwOENncEMv?=
 =?utf-8?B?dGxqQ0YzbXcrVlhCYU15UXQzOUxFbFZadmtJTFZmUUtTTjFwR3k1ejVwV2Qy?=
 =?utf-8?B?Q2FsM21pOWlQWWZQNFRobUZvNDlBTFhWV0ZCOHdVRko3Z1gxY29NclFlWi9X?=
 =?utf-8?B?Q0dLakdsSlNaOTlHREVJYlV6Y3ZwMmNDeU5tVjRRckxoaVNFbVZwRlRMSEhU?=
 =?utf-8?B?M0JYZWdOL3VWUEg2L1BzcTR6d1NMcHpIZkVRNTEzVUp4RjdkeGVOeHJ2b0JT?=
 =?utf-8?B?WS9KYkk4b3p4VHRMUjJ1Z0VvbG9WeDREaFQ3ZXJtYXNNVWhmUzVEbkFrdXdC?=
 =?utf-8?B?Zlp5TVhiYUYvV2hYNnJDeVByaDgwUEwyUVhUS1c3MkJFMVBYNE9jOVRmU0xX?=
 =?utf-8?B?Z0pkTjVEZWg3NFQyV0FaZkdLcFBhTWxIdXFKaC9IQUVFU3JZMXFBNjA1L29Q?=
 =?utf-8?B?QUsreFhYZkJFOHpTclNPZkI5NTdISHd4YWpSZDFKYTZzYnJFUFdkaFZFWHU5?=
 =?utf-8?B?MTNRSFVBSGdOdjhEa25TTHlaM21ibG5hNzV6ZlUrWml4ZnRlK2lBdkNKQUR3?=
 =?utf-8?B?bTVyRU5rV1NTTTVTWVRFWnBYNFdibGp6SmZJL2JlT0I5dzlwRE1VQlA1emxk?=
 =?utf-8?B?STdZbXRVY1F4U00vMGVPa2diNnd5UnZQWWozdENPbmkxb1RQUExjbVBqSnBt?=
 =?utf-8?B?Ny9hcU05K2wrM2VZSWFwYVUvbW1KMjEweEtqMlBrRDV2d1IxU2xVeXRFM2JD?=
 =?utf-8?B?TWVIR1NBMURGOVdtZUNUTktDbmtGUG5KU2pXcDlwekZJN09URWF2QlhubjFD?=
 =?utf-8?B?ME1CdWF2bkdOdWFaaGx0T1pJRUpzUlBVSEdVODB6NWNZOEhpenNabmx5T1pW?=
 =?utf-8?B?c3E1NkpXdkZvR2RUTXZLeE5Fc2hMd2o2eFVZY3JJa3RtK3ZZWjgwbEU1TWY4?=
 =?utf-8?B?Wk82djVUNjJtMHpyanBkQ3J2VFZYN2gvU2Q0MkJ1bjFaZm5PMWxKcDltVjRv?=
 =?utf-8?B?RE9HWVNLNS84dmJMMzBNZHpQMlErT2E5SkoxYU5BeG0rLzNMTC9QQ0ZyYUpo?=
 =?utf-8?B?QTNDdHZnMXBZYWx2ZVpLTittWmpEbVJvWkh0QUR4YVU2MHN6SHN6ZE9jaGJP?=
 =?utf-8?B?cHltT1h1UUNoZVowejAxb0ZVazBRSW1BNzNCMVJLSWFZeW40NEJKMGs3TElr?=
 =?utf-8?B?Qk4yUW5jdFBlYnhRNi9jdjhLaFVFNHpkZDloWGRiT2xtRldxalFoMHNPRG9T?=
 =?utf-8?B?YllRaVNDWWFoTEVaTnpNYmRXR1BVbjRsNDA1OWFmOXRiVW9NWnJ5ZVRkY0Jz?=
 =?utf-8?B?ejZxSHNmZjkzL0w3R21nUzhTWUM5Q2FPK3hNSjFsWmpXUXN3RDRRVnk4bnZ4?=
 =?utf-8?B?SEtvRGIvTENhRXVQK0VBYVloRXY5Q2ZZb0RHbVlOZGN4bGRYOGIrSXhFUGpY?=
 =?utf-8?B?bEFlb3NtZ3kzZU02UERDSDJtQ2NOU3duMDFqMnJveFk1SDJMUU1BZWU0ZWtZ?=
 =?utf-8?B?MExhMDhsM2RhNTNSL0l4OHpyU0JvemdZM3RoTGhmelFrRjF2dmVoNU1yZ2V1?=
 =?utf-8?B?a0tud2phZHMvY25PTHJ5QTliY1EzaS9mMHhFbnJCc2lMbTRDV0xUMGRDY3Yz?=
 =?utf-8?B?SjVQSGZkbEg1Q2tIUWNUNENqQllNM0h0OWNTdVF6UGtoL2l0UXBWY2FQSlJ5?=
 =?utf-8?B?YmRGV3F2K0YyUWYxNXVBTlRzKzlDQTc4SEFldTNMTzN6YVl4Z0YzeDJyaHZ1?=
 =?utf-8?B?cU1iZndIcXhIZGJ5Q1RNclFkamNUdk42bTIrT2F0Q0RWbFE2L01aeURTSXpF?=
 =?utf-8?B?OHJmRDBZVmdNWFJDSllEaGZETXhUWVU4TkFzcVpnVzNLVzlVTjZSSEQ3eHA0?=
 =?utf-8?B?a3ZGbVZCODU0WGlWVlpEU1FJNTFXeXNVQmdWajlmWmV6WXNqSWZZRWQ4NGI4?=
 =?utf-8?B?dVJ2TjlvZFk0QmpjS0hQY2JOSVhScWFlYWs4M3dFV0thMlBBc1RhcjNHZEdN?=
 =?utf-8?B?SEZTOTRUcGlNVVdhQnpqUlp3SDNtb0NnSGhWR1lkSk02cks0RGtINDhhUUs3?=
 =?utf-8?Q?iQJh1XP7XS6JYXe2jqezq43Oq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b1e6ca-1214-4bcb-ccf4-08de21b76e94
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:48:05.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqv9e27pxAQyt2aAPUv1oBzL7HBv8dVtOz0jhFjFdj26ZnPbHy/BvQQtUiY4P/U28ys/KJ+rh/HISHXu3d6A7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11301

mt35xu02gcba is similar with mt35xu01gbba, but with four
dies inside. According to datasheet, it contain SFDP and
support 8D-8D-8D mode. Add comments here, remider to change
the code in future if has a chance to test on this chip.

Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/micron-st.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 6d081ec176c37249e5ddb724b61bd70f68088163..cc053b4d615ade3f12068618f8355779561dce55 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -206,6 +206,12 @@ static const struct flash_info micron_nor_parts[] = {
 		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
 		.fixups = &mt35xu01gbba_fixups,
 	}, {
+		/*
+		 * MT35XU02GCBA contain SFDP, so no need the size
+		 * and no_sfdp_flags here, should similar with
+		 * MT35XU01GBBA, but with 4 dies. If someone can
+		 * test on this chip, can change accordingly.
+		 */
 		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
 		.name = "mt35xu02g",
 		.sector_size = SZ_128K,

-- 
2.34.1


