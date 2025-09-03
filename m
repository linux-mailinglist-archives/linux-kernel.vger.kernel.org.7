Return-Path: <linux-kernel+bounces-799378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16029B42ABB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB83683C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271A337059E;
	Wed,  3 Sep 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OQBHdAjy"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB736CE18;
	Wed,  3 Sep 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930838; cv=fail; b=T0N77yaXfPWpEeHQtIHTs2TZGhqPAshcC/SYIDvsHW1LEIjEC0lUvnUJPxX2fXnwcoI/73XBmTE6M6e7eE0wRBP/FxqvjjuItuwqOKGhcnJF187xqJ6ZAiTULIrkylqyJs9s+feBnv5JOMX95q4NP5a7A7uTNiIbbeAvFaSt+tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930838; c=relaxed/simple;
	bh=HizQVuImqrqGkzS0xCypUOF3jNSZn2CWpi/gIGp2NMA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QJZ2j5X4LFL80vA6MFZsLVnitf3uvQEJeQu15DMRExCBTtuTHALncARjB9TnHdEGHagvPO4zTCgRvX5ISaqGMpixgQIVL9BbqF9MAbif0D18sJBZXxnzFyFlTCZJd5wKYrnoOFPGh/jODe1OrqMrtdTSLyw7i34cDxRvbWQ2eMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OQBHdAjy; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Va4mP5KyU9T2ksAv1z2DyaTKjgcDwCVQddMLE4QfsckKSqyZu5HA0oPVeleFiFB2BM0N3GzPs6GyPie6Y4vsh/MdPK/tB1LGu6HRoj8Dpdxa8jyjILS6Y1ROaaCB+SUytPJiBizwsLUq5k+Js16E7uiWNmXswOFCs70zsgdUEyy0LVESL5lxGwoWOSrg77QNDzAJLE/YhTcNgjLzEF8OOYTJKB3YF6L6wjkX++ERtrXOqGsgdGQIasVfEBhrBuPBGG8BlS7ZG4FlBpYzfBExc+pkjUZRP9idGdur/VScEqu5F6UB/qXZOA9MMCBieMvcW4/JjgQVJbrXt96m3/9Jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTOMtZ2YjOZXzp5jTRRO1HLeJBKYz3CoZ5Lsta4Sv0g=;
 b=O9ochDhQNgEAC3MsjcstSYt/yv+oPskZpLKraTMA1QabXPIClw6oMf7seAxknH6LQzOo10YaoAH3RdjIFzJHvNeZfPm/yeemd7uzeM2CpsmBQuoD6u24aWMx89hR8pV8ox1qPKsSqI/5gxplcWEO21bg30iGpxodXFSNUfOhg32CTvjZdzfuUoCDCpGEH+yl9GREXHh4lPn14/xy+40JNIWQbC56WgiRQJmCG6DkOfuMr2rYLbvyHSXSKhHJTii7hbadR1eSJURgC7d+ekUb0DKwnBrj/l5C2KlhJ8jdSSaLRvBRlpSKmvyZYl2V+WRFBoApdQ7l3W3DRUpWzoT+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTOMtZ2YjOZXzp5jTRRO1HLeJBKYz3CoZ5Lsta4Sv0g=;
 b=OQBHdAjyrk7eZdLaNnmYiR8NmOvAJk8GmCBBTxCRUA88vY8uj4YJ+sn0JIpfsCp5b2qoKKkC31nN/yH+KKWuGoa30vHET7z9gCxWORb/emH3eP93ENcwzkyPDrWIeaZ5w3znuSqxnEvvvmanAsEGfDzhVUs2VwI4Y9yJNfq/VziW/KfKt/i1TQzAcdaonhbMX1HfwF22Yt6CAijxr4LxwurCAoEVTbpbcVG1V+quEefUOMkbvUxOrgLJ5I7/NsyKHtkxU8nS+Pgv8J4nmtZiqN7YMLIssVm8m/NuSCfoAyjVhlnZXNbrm/go3iYFaaf13Es8HrYhEebtvF9FfhcMgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:31 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:20:02 -0400
Subject: [PATCH 09/16] ARM: dts: imx6: rename node name flash to eeprom
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-9-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=1616;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HizQVuImqrqGkzS0xCypUOF3jNSZn2CWpi/gIGp2NMA=;
 b=atFLE8OBrbupRFI6Ol14Xh0G/swPOWPPAYa4oIv9p+LgiGb85xRTgBt3PUSb3mLaKbfsYbdIb
 /HTn5o1HSAlDxA6ySjuvO4Un4r29zWwUDU4K//BdVFxHyLbuC+BWhYj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 57550250-a93a-4e5f-dec8-08ddeb2754b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFViRk5qcDJwY0FMbEg0dDQ3eSsvd296anZFTHdBUEd2NjVBam1TY0ZXaWQw?=
 =?utf-8?B?NFlrMk9lTGVFU0RIM21HVE10MjVyZVVaRURObWNxVlBWYVhKempJMFMxMWZo?=
 =?utf-8?B?UCs1Q1FxNFZzeTZOSHFHOG1iTnYzKzhzOWhIeHpoNEVsc2xjaHV0SXVRcXJR?=
 =?utf-8?B?ZytSOVhlOHM5YmQ4SnplMWgwU00yaXpPbGRPRTJUU1o0Wk5TY1ViM1lwbXVj?=
 =?utf-8?B?V002Yjc4MGs2bytxd3RpU3duQzQ0a1FNR1JYbkZReU1UWnptc3NwMHl0azJk?=
 =?utf-8?B?c1RJVysxSkQ4U2oyT0lWVTZVTUxYSmFCOEg1ZmRyVU0yeGpNdmJya2hlU2RQ?=
 =?utf-8?B?aCt2b0c5RUlodGt6Mm0xdXYxanNacmRVcG93cmVsSm1VNURmR0JOWWcvaEw0?=
 =?utf-8?B?UDA2U0Mxd3FVVHAvZTk2eWxPak4yVjZRNUFaK0Y0b2p4SFdWK0VKWmRaZys3?=
 =?utf-8?B?YitpeGFVWkx6eHRzNHJaM1NNajdkRHRZWkV2NERGcjdQR0JYaWRXcUJPN1VN?=
 =?utf-8?B?WG9JdmtjY0piWmtYdGNKL284RGE0RlRja1VwWGVwYjIvRmZLd2l3aFA4MWd0?=
 =?utf-8?B?SzQ5YjBUMXpwVmloYk1lU3g1YUw4bDI3MFR6T0JlQ2R4SXd5aUxlNEg2L1pW?=
 =?utf-8?B?eG1JK1JHLzZLTDNTTWhBQ3QxTXVzOVVyTTM5Z2F5cjFueUw3OFpoQ1ZPOHZM?=
 =?utf-8?B?TjFKd0RQUUlpeE9vVGxGRzA2bDJ1aVUvV3dBWnFsNmdVVUovQ1NxQVpSd1Zo?=
 =?utf-8?B?L0pWVlF0VXRWWFQ3dHN3WUlTMC9Ta0JWVXIreU5tSUY2a2hpS0pMaXViTkV6?=
 =?utf-8?B?Mmp0eUVUTTNYNXhGaThDZm56bUpwcERzZzEvRm56aGJUQlNLNGRHS2NYRE15?=
 =?utf-8?B?Y1hVb2lBNnd3djE2bWwwWE1HbUVzYVNzd0xnUUxpRlIwcFFMeVVxRm9VZTcv?=
 =?utf-8?B?R1NQY2pTRjRuamM5dlczVi9FY3NCZ1ZCUXNHV04yemxtSk1xbmVYYVd1UTd3?=
 =?utf-8?B?V2tiWUkzRk81bGtKb0dLaEsyQTVDbFQ4MjhMOWpnUDJuNWZ0T3JYdnlxUlFl?=
 =?utf-8?B?ZXNYMC93UVRLTi9vb2UzY3JBYVhFc3F4WThvUzlZdytZWjM4eENuNFFxZTlR?=
 =?utf-8?B?SHR6V2E5UVNWbWNUSWxFVDhudTFDMU5QZ21wdWU2S0FsL2g5aUR1UkxpN3o5?=
 =?utf-8?B?UzMxbUVNQ3RhaURTRkdINTRXdEtleHZXUk1oek9pbVlBT3dMaVl0YXhNRk5F?=
 =?utf-8?B?QTNtTlJsWG1vUDVWcWM0dUJKaHovQi9LSVBudEJtZjQ1andrWFM2S2hYakZ4?=
 =?utf-8?B?eWlva3c0WWxvVDk2ZmNIYXo0R2U4anU2VjFDT050bU5iMThuSGIxMzRVL0M2?=
 =?utf-8?B?RW1TYkw1M3NaUmsvRVVCTWk2a2lWMnZiZG9IR1hQZ3lVMmw1OFAzd2dqTWNS?=
 =?utf-8?B?c1U3Q21FZ2EwdkhPQXdGYWptdHV6VUV4Mm9ad3RiYWRrUGF6OWpDWFlSOWE1?=
 =?utf-8?B?Q05ZaVd5TGt3NlZDRUVpcDUwOFR2WDRWMmVNbnlWQnd5Wll1N2ZrZmRidWRr?=
 =?utf-8?B?Nm9VRm9CcENkT2EvK0ZRZzZmc0tUSEd6Yml5K0tJMnhWZEcra2VwZXFGMFoy?=
 =?utf-8?B?VWkzRFhkekJiOGJKcnNtT0Njam8wUnFreUNYa3lHUjc3RHFRWTAwQVFQbWhv?=
 =?utf-8?B?OVlDbEFkc1N5MDhLYVBxWUErcVRzb2VJeWlSRkZRc3ZTTWVlOXZVOXczU21Z?=
 =?utf-8?B?VHpOWUd2dzRreEsxK2FQV3dmaVVmNGNpb3ZEQWpMUUdOV25lWHJFdVUrcWZu?=
 =?utf-8?B?cWNIeXFGWDRJSWhFaUw1L09jTVJGQ3hxMExWOHQxYnVwS1VvUEpLQ00yT0p2?=
 =?utf-8?B?YXBQcFAxbW5XSzhVUzJ6emxwenVTNDFrNlVZell4NVBsaDdxVkZacUpsOURC?=
 =?utf-8?B?UFMvUkdIV2JMcnl3N2pEQjgyWGxYYjUzWkJJM2RoN3NaWHlva3MzcGJMT2x5?=
 =?utf-8?B?UUxTZlMzSm9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnhrUVd0SXJqckpwVGJDTTdkZlRnTzNoR3VVQTYyb1A3YlRzdWsweUNhckpP?=
 =?utf-8?B?SmUrTnRLSU1UQXg2Y1Q1Y1BJeVNUWi83RHR0ZWd2bGRyZUJyOUdSeGJsVzlP?=
 =?utf-8?B?T3o0VG81eEVxYllpMjRTRGNWLzlmUnFIWHVmQTUrY0N1ZEw3dDhBYkt2bEMr?=
 =?utf-8?B?TGM0K3NXY3JnbCtwSEdzYmxNVGVlMUl3VmpBQk83bzQyK095R2RPR0Npc1FB?=
 =?utf-8?B?ZVFlOEFMSSswY0k3SzFSREgxNFN3S0t2SWJNSHR5cjlzeDcvaEJLMksxVHJr?=
 =?utf-8?B?OTFpQXlKME0rUW9mODhGSFh1dGFjdWw0K2RoeVRjUWVHRTJySkFlTzMxRXcv?=
 =?utf-8?B?Vzc5NVVSb0pmMG9pZEYrbTFUVjdBNVlQTGFweHBxZHZYR3pDV1NjUFMyVC9u?=
 =?utf-8?B?VXhlNUo0TmlKWWV1UDRNcDZ5RWd1QmhIRE1ScklQd2RKdms3OVF1S3FTZE5V?=
 =?utf-8?B?cUhqY1RLSXVxVWRiYmhoQ09rd1B1SWxacG5SdGoyNU0ybXZWbWJwV2YyelJu?=
 =?utf-8?B?NFJEelZ5aFJwdnJYSzFFYTFtS1JoMUFwNlFLc3B1U0oxYUpFMmlsMTJSN0tz?=
 =?utf-8?B?c1dQQW5EWUdLK21sYlIzRnk0T0Juc3lkcHJwK2tZUERLMy9RTURBa1dWSHdE?=
 =?utf-8?B?dk9QQmhUK2Y1d0RJNmZ4RXZkeGduLzVXOU1UZmppMFVWdHp0WkMxUHpQQUdO?=
 =?utf-8?B?RzA1ckczSTVNZTk4ODBGbWdqSW9JUkNlSGUxV3RzS1lmRzhEUXQ5UVo5bmRK?=
 =?utf-8?B?bmhmRERVZUFFNUp5bzVYY3Z2MytvU3hIZTltdHpFKzJxWjJpNmZNcXNwa2Yr?=
 =?utf-8?B?ODc5QTU3L2dqdG12NVNhQUFTZVVNNVlLL2wwUk9GaVoxeFJIQWF4OUw2b0V5?=
 =?utf-8?B?UmJ0ZjBMK2JCWEpUbE9lcU9zNmN0OE5TcUV1S0UzNFhKTlBFU3ppUWhUZTl1?=
 =?utf-8?B?YWtqU2htSWJYcktzQjVJOTNkVnMxYUw5ZjF6c2dPN05sNHIzdHQ0Z3NSUVhz?=
 =?utf-8?B?NitPU2FoWWROeTNXaHZDZzlWSnZlcDNlNTVGVGR6VkVkYlJIak92WTNFVWoy?=
 =?utf-8?B?UXVPMzczM0NzVmw4RVNkblQ5SU00RlJTL1A0MnpmZDlzM0FPd0IzaVQ5dTVo?=
 =?utf-8?B?bWRyelAydzJkMXVQNVM1VlNvQUR3NW0wU01OUmZyYnRMWGV2R0l6UVNTOC9O?=
 =?utf-8?B?STh5b01MZHc3N1pTRWpGSWFOaHo0OTBDL3VtNGZlT2FaTzZOQ1NhYUU4NzFs?=
 =?utf-8?B?S21yOHFjZStzTm16bzBrdmZtZ1pyS1FNSnlHMnAvdkdWWTZ3WE9Hc3FRbXpG?=
 =?utf-8?B?a3hVNTNmTkJGTzNFNlp2Y0Urc1RpSTRzMjVHZE5mZjd1THNsNlpPZWdWcE8v?=
 =?utf-8?B?R3dhbWRUN0RLZVJPdVhCSlZidk93eGl5ZmdzUjdjd2pVOC9WZFdJbzJDcG9m?=
 =?utf-8?B?NHNhREZaeDVGc2ZQWW1HbFA2Y2MwRkRpWjR6cXYvRHkrelcvZHBLRnkwQWV5?=
 =?utf-8?B?UmEyTXI0ZjZZUWZSQktxTlpicXhhNEhuL0tNcGF6WE5vTml0YldYVHhMRFNx?=
 =?utf-8?B?YS81c1JwR0VLSUI5QTF3Sk11YmFmQ3BuVVc0STlEZ2MwQSttcUxYeUM5dy9H?=
 =?utf-8?B?V3pCcmV3Y2RoWjRjUnF2b0h1ZWhGYjl0VjlxSk5RNE5CSGg4UWNBK2hzTlFX?=
 =?utf-8?B?WlRYRkljQUc5RmduS2N3UlRNREhwZkVUdTF4UGRoTnhqRElTZ0JqVXRYSUla?=
 =?utf-8?B?MmtRZy92Mm9oR3BSR3lwdWZnclVaa25LTHNXWTdHcUtUUmpnQnhSWHE1Ni9o?=
 =?utf-8?B?aStkbUprb09IRHcwSStxY0NuNWxjTzBrOW1oS2NKbU1yMHZXc0w0UWs5TE5k?=
 =?utf-8?B?SXZKTlNta1puSnZiM0Nlc0l0YmJacTRuYWJQWWc0WHlEU3ZDUDVwZDQ1MlR3?=
 =?utf-8?B?WlRhc2h5QUFKeTRlNCttWldhUTByMlRpaTI4dDU1UkRwcHpKdEUrNFA4cTQy?=
 =?utf-8?B?UFVCbFFEZW1OdzFkY3p3Zkd1MmNOYk52TnhRclBkbG1kUDFaeTk5Q1NhdjJN?=
 =?utf-8?B?UHVscmppRTQ2aitOeVlTeDd0cDVvTVZvVDc4VmtzaUM5REhwaW9XNk9EL2tz?=
 =?utf-8?Q?3jtvITf0eu4quBZL4hBnqqTho?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57550250-a93a-4e5f-dec8-08ddeb2754b7
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:31.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aju4RGfPFi2YIeEjTZXdYdza3+QsAG7QKxY7seCLGsx0dC7QUE8G/P40lrt8CLF/NOLSIazvN9bqD3bUN/wr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Rename node name flash to eeprom to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6q-b450v3.dtb: flash@0 (atmel,at25): $nodename: 'anyOf' conditional failed, one must be fixed:
        'flash@0' does not match '^eeprom@[0-9a-f]{1,2}$'
        'flash@0' does not match '^fram@[0-9a-f]{1,2}$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dms-ba16.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi
index aa1adcc740195172f1c387c1edfbf829af68464d..e1d0c6e123fd728f7bf6a6aa19c22b75ce3e5817 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi
@@ -160,7 +160,7 @@ &ecspi5 {
 	pinctrl-0 = <&pinctrl_ecspi5>;
 	status = "okay";
 
-	m25_eeprom: flash@0 {
+	m25_eeprom: eeprom@0 {
 		compatible = "atmel,at25";
 		spi-max-frequency = <10000000>;
 		size = <0x8000>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-dms-ba16.dts b/arch/arm/boot/dts/nxp/imx/imx6q-dms-ba16.dts
index d2d0a82ea1782ddb233731f6ac8cce725139893e..484a60892229d869748f3256250b1dbaf0684937 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-dms-ba16.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-dms-ba16.dts
@@ -47,7 +47,7 @@ &ecspi5 {
 	pinctrl-0 = <&pinctrl_ecspi5>;
 	status = "okay";
 
-	m25_eeprom: flash@0 {
+	m25_eeprom: eeprom@0 {
 		compatible = "atmel,at25256B", "atmel,at25";
 		spi-max-frequency = <20000000>;
 		size = <0x8000>;

-- 
2.34.1


