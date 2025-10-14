Return-Path: <linux-kernel+bounces-851815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689DABD7574
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DBB408FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2704A30DEA3;
	Tue, 14 Oct 2025 04:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MRfsWgqm"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F530DD34
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417728; cv=fail; b=FJgHm6BKRVCsahC3hFELsvXMsZFxqcRevvgaeJZ2/wsAU5TXuQmfomM3dt+qR/w6qG9yKbcJcS7tJtxZLmwpTS3OmJAc5z6iJO26R/zXxgbm4Zz0DBxbjokN+0uq61IzIdzQTLVC5U7DkTrjgc8FZFgCjj4eNRcHaduz2gEP4Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417728; c=relaxed/simple;
	bh=oHsfvnKmLj1CEiwgu+6iB1wi6z3K1FVkWhGPPN9Hnew=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d87UQLuR3gIl+MxFOa8Y+0csqol15KJ9DfssP14xnos5WCXvOk38mE0LEOcxo99Hexck7dWOxsy8PX7jr7PKu5Dlza/XCsW0EWFQiXldmbsX91mXPsVoISYL2FKFKarAtIgeS3D6w9Izbthd7NPilOhe3KXAXew/pDU6EKY2Ddc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MRfsWgqm; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2UqLq5E9qLUoHE8gJ9RoHjEL9j43Z4yk0WI8PNvBNHxr0r5A0TQNwc8uSA3zUtjbv33OdT5fQJcR/wq7IHkcl7n+JBZUDs12NlokpaOC5xrP+kpZIv4EiR9IkUvtHUZ9G0HIQjNoDwu2poGI3O1zP6V88HUeYSh9nRgoixxERFjQgw8lkPZosVu/Iv+z7KRSxGBktcIi4S0qhoVFl1rSjGrE6HyCghmYBqvQXsnjSgPX65h65thiCC9tnM8ztB3xvbohILGmGhILNTKcLQtOS8nTUQDrChmZc3eF4UyxlmkBcuZuZYRZl7c4x7QqHpv8I+dlrcMcNKlXvpqSU0XuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCaHzuktPgDE1alRmcbh+S0xiAEPY7Y4g3kXtlET4TA=;
 b=MhEn+2EYZPhqwjipbGA7FX34OPXXwNEONioooEDJkGo+jWaIsMfogpzBEF/ElU0NEQqespmMh/7CjjNI9fWsQ0r4nEW7G2Ls2jLmc2rs6pSxPAuyWy1SMR4aIpnb5YiLiwPIFH6hqnKxemDmZoIkzeG9u5tYT+6DsVMhkDbmKIvze0aWMRnCC+AWefxb+4lWhzu6GNwX1aYBgPhiQFn9QkxXawdsckLuosJFEtySlj931y/dFFuCTbCa/RbVoJ90Xmw4MwLVx4g1nVUMYoaC7HiL7oQi6N9dGpjOuyQXdb8tyjkYAqqUmLG8hr/d/G+tsPCaEsvr8WonNQL4a1clsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCaHzuktPgDE1alRmcbh+S0xiAEPY7Y4g3kXtlET4TA=;
 b=MRfsWgqmn+494FNLqels/xX/jk8a3VRMmxJqV1NkmMz85l0lNwkklYvuW329qgJYG6Wa8axHyqbod5VSVGqfjY7dFswZvLyoJaHmcG1VESkkvObHCdWkuNZJjaj3VdqlValhQS4/IkJYymql9Vmwy4prVTYdvdvNVym8H97PhuekvigEMvfcdk2DSZYzkmtS5mWhc4dMY3uub+nCCDnAtb6HL3vBLwgwmLnLXrwC+B1IyR/bLvhbEPXrLPjtghSEoOuCmuhTxSli4ZjFYiYKZo093apQEVtbPC6EirRSV0JBxaeZe2tsZDlReMfB/EhY9olDWAuchbfHQnMR2Eo9Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 04:55:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 04:55:23 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 14 Oct 2025 12:54:45 +0800
Subject: [PATCH 8/8] firmware: imx: scu: Use devm_mutex_init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx-firmware-v1-8-ba00220613ca@nxp.com>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
In-Reply-To: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760417688; l=833;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=oHsfvnKmLj1CEiwgu+6iB1wi6z3K1FVkWhGPPN9Hnew=;
 b=R+7MquQtjJXnNPoVFJ1WhqFfmWxHqrIamHTZ8rDhHLOO8M43eMYBDmkv6Fj6LVWBTmxjX0Qse
 GyLfMHwUvJdBlUY7mwVigxw2RsJS4E5c+bSmqWg03tZnACIDZYCR1yQ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e71193-53db-404b-f318-08de0adde218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWtnSm4vRmlJb1VuZFRHYzF1UDk1MGZCZG92YnJGTHhSTi8wNDl6aG9pRHVJ?=
 =?utf-8?B?ZXlLcUtJM0J1Z2pCS05hSWVQNEJqTVRrYzU2S0IwT3lYWUZOMDIwOW92dG1Y?=
 =?utf-8?B?VFpZczUxVDEvVlpoN1hwaFFEZExqOXl2dythNmZjaDdEZFVtdmFHeWF2elpt?=
 =?utf-8?B?UUpBMTM0cjlPOWx2YVNRTFJxMUlRYlNqeE9lSzdscmdlSWdNL3pDRUEwdG1B?=
 =?utf-8?B?OS9QQ0hKVWcxWm4vbFh2QVpKMU1Hd0FlOEVNb3YxUksyQmplcUxpd0Z3VnhM?=
 =?utf-8?B?ejZMTzB5NnpRcUt3WEM4TktsZDV0bSt5WWZQV2hhWjlFdDhJMkRCZmF1OHps?=
 =?utf-8?B?dlNWK2k2bkJrYXdkWVBBQi9STlhFOXRsdTk5YVlGQmtzbzBENHY0U1RPRlAy?=
 =?utf-8?B?SnlsNHZGWW5XK3JPa2FhTGF4TEcyY2VFOWZvK3dsR2NuSmszbkxPQlQ0cUFy?=
 =?utf-8?B?Q1BvTXRneUtPaEY0RlJTZktzVktMclI2YUZWSVlLM2JEeHVmaklWNVptamty?=
 =?utf-8?B?V3ZMYnFwQzJsVTRvOEE4bXE5c3c0MlJYWXE5dlpvVENvTVE5Q3FyaVBTNGxW?=
 =?utf-8?B?K2hDcnlJTE8ydFpFb1pXQWFQV1FmVTFOSmIwOThlZE9tUjJVeGQrMERmbTNs?=
 =?utf-8?B?SGZHeERIcDMrcU9jcVlHRlB5anJ3cTZPODkyeTc0Vi9IdngxUHp0WHMxd2lz?=
 =?utf-8?B?aStvUlhTUUFCaGRXWEFoNXJXQlNIWDVDc0pJMWR6aHZzdzc0d3haMXZjV3h4?=
 =?utf-8?B?cVFEK2l6Q1ozNm56cDVlOXk2Sk1lODY0NjNlOVpqbHF3bTQ5MkZzalpNNGxv?=
 =?utf-8?B?QTdLV1QvTzlUWlRESE5WcVdIRGwybmIzSUhmQk4ycW1IL01xSDNMemtlSksx?=
 =?utf-8?B?bEN4YmlkbnNyUFM5Wi82ZkJJWFVVaC9OOVZ2K2NzVmlOWDQ2NituVUJyZVky?=
 =?utf-8?B?cTJsRDFVM2ZCYzNicEVBVHp1QzhJc1VkV25FSW9VVmxaazk1TGxRcnJpclcx?=
 =?utf-8?B?NUUzY0VhZHpFTEdiaTU3M0VNSERQdEtqcFkzRENRUzQrYkZYMi9ueFFJMVNy?=
 =?utf-8?B?TkVUNDVtM3NZUlJ3Szh2b25xbm1WdUlHblFRVk8yendjcFR1K0d2b3JQVWJP?=
 =?utf-8?B?QjFtY3hiWTZoUFUwOHl4NEZWbndBSFg0ak5LdWtQTXRYbEhCeDRaRytLaVBs?=
 =?utf-8?B?VStabWFIR1R2MUV2RTBJWjUvNUpoRTdWSWI3YktEYW5rcUVDeEFabmVPMDF1?=
 =?utf-8?B?dzV4OCtRQUw2Z0UrOHlQTVZiS2ZsTjd2WnQ2NG8venFuUW9OazVla2ZzTnJq?=
 =?utf-8?B?UGVqYko3MngzWWUvYkdmQmZUVW54ZHQ3aGVyOVlxbVNQS1NyYUhQVjZ3Tll2?=
 =?utf-8?B?SW9zSlVQZzhnMERFUXBCNjFod2dsZ2ZuYUFkWWZwbDFDMHkzbXduY0hHMUFR?=
 =?utf-8?B?YzVTZU9iQ3d5VzFUMG50OXBxTzYvT21JRUl0TFJlTEkxaFJSbnIvS1JuN0JP?=
 =?utf-8?B?WWRJSDQ5M2lDQVJGdERIZS9qMFNpampVNWNkRUh4WEJMLys2MHZkYUc0bjVN?=
 =?utf-8?B?MXVQazJhYk1GWWltU3NCQmk2TmlSMVAvb1dtTVNDSmxKb1EwaGJMZm5QcjRq?=
 =?utf-8?B?MUQ0SWh4bUlRaElrWmcwZjY2WmJMd3BMVTdYeXR4RGg0YUkvZWhJODJ5V3U4?=
 =?utf-8?B?aXkrV2tEWmVSTjNnY0J5OXB2R29ZaGNaTzhxbGxXc25JUmViakQ4WXNZemh2?=
 =?utf-8?B?QjUyT2R1TmRaUWVzTUNIdTdzblg1QnF1bzJaYnpQOEZRM2c2RVpNVjIwaU9M?=
 =?utf-8?B?ZkNtUXRFRWhmbTJ0NWNOT1ZTenE1TlJ3aW9DazRDVDhZRHRxQ2RKNWVwR2hq?=
 =?utf-8?B?UDZDM2xoRHRyZTA2dHpCUjVmTThqZERvbnJvUzdFVnc2S2I2R2VyeldhTlV2?=
 =?utf-8?B?RHNkemhLMmN0YW5hTVJadTlWQ0ExSkszVkFiWHQ2RkhhOGRrSWtBU2dQdDMz?=
 =?utf-8?B?ZENZcUxTY20rSkxZb1YrMXU0ck5QTGVvV28yRTFTRjFDZGhwREl6NkRDOHcx?=
 =?utf-8?Q?wxcGFf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3ljYmtZTzYvR0E0b25vazB0RkQ1VTVMQ2ExdU5ZcW50dVVzUzNyOGY0ZVRQ?=
 =?utf-8?B?NGtBdEhRNDJWeGFoYUVOZ0pNWkRoYkZ1eDdVakQ4RmdJYjRrS1ZxZnU4aENt?=
 =?utf-8?B?VW5HV2V4VnNkMmxxbnNKa3JRa3VKYktzSXp3dEdSaE8zSkdHYzZEVWtEOUc0?=
 =?utf-8?B?bXM3Rkl3STFSQ2NoNXVLNDE4Mm1KWlU2SjNLN2dLTGw3bEtqWUFOU24rWURq?=
 =?utf-8?B?Q3ZxYmlmU0VLT2FCNXVMN21kSTJMNnJ4NWdZdk5yYTVoZ2NKZnE1SDdYMEJQ?=
 =?utf-8?B?dmN4YXovZ1VKWHZneUF3NFpCelVtcVZpeWkxWUEzazVyRjErM0Z6R3FqbXJo?=
 =?utf-8?B?WFVKRXlYOWpPbWprbXpYTWdKWVM3RC9JMHB2OFlyamw4YTNsVC9QVUNXYXha?=
 =?utf-8?B?SnhqWFJNWkhsT3AxYnhqaFFBenJ0TEhOWEF0cEM3MmUvbldLOVFvb0pLTE1h?=
 =?utf-8?B?RjQzb0ZrNmxyUUNQZ0NNZW1hNTNVcng5RzVGc1g2UTNuWUVFbmdScVc1dGhH?=
 =?utf-8?B?TUxMOUlrS2lQTlpGWmExNExCNGc0Tit1bUZMRzViM2dLeTVqL2tLOHhiaVBL?=
 =?utf-8?B?WG85RnNaUVNvWUpJWEJRVzdNVTNXaGxqRzdIcllJbkZSSE93MWlQeUhPYTRL?=
 =?utf-8?B?TXJUZm1Yd09EQkxsK3d6bjFtYVpEUTR3U2Y4TmxtQldtcjBoYlRUaHFtNUhB?=
 =?utf-8?B?UjNNdkgvZ2RjZEZPZFM2d3U1MFBXNkNwVzVoazlWcUxGNlNqbUVXaUZEa3JB?=
 =?utf-8?B?YitPVFV4cnl4Q1N1aVFJNmhRekVONFk3V01wOExFQjQrYmROaXJOTVJuaVcv?=
 =?utf-8?B?dVRnVzZoald2UU5TaWJOU200ZnRKaU5hSkZ1aFZSaEJVenlsTDdpZ2crcmxG?=
 =?utf-8?B?YnBvWDRrS0o1V0pSaU9SMDhTU2tmWFZOU0JpWlVOdjRWY2NudnBVbnFOM295?=
 =?utf-8?B?SXp2ak1ROFpxUjdYQ0EwZ2cxZ0thNXQxS1AzcC9NbGx2Z0NRUm1lZ0pNUkRF?=
 =?utf-8?B?TUV2Vk5Qa0kzMy9hY244aTQ1NzdwMVlkZnB6YUZ3YkE5OFc1U2pCeTVRUjVF?=
 =?utf-8?B?VW1nRkl0L0Zqell5aDNlS01yRXNpbzNsVEFyVWYzZDhXT3FvR3hSL0VaZjlH?=
 =?utf-8?B?Y0s3VWIyeDQwOVZCQlYrcWJVdVFhb0lCSDI2T2J1ME9wb202NFQ0OENsNnNj?=
 =?utf-8?B?ODF4U3RBdHNyRnY0WjVSM1ZrUXE1Vm1obEY3RUhWbHVaVVpValVmamFxUkNC?=
 =?utf-8?B?UUNkTFZhVkphNWZRSWZKQUJQQkR2K2lpbGVwUHRYWGtkQm9JRnYra2NycUU3?=
 =?utf-8?B?TllZSGN3eFFMUmNSQkpBRnZMeW1qZG1MTTB5VVdod2FYQnFrbEh5VlllbHhO?=
 =?utf-8?B?YndGMXQzUzA4SGFtTHZ0enhTeHVzZmZoaElZN29IRnVuQTI3TVVscUdhK0pw?=
 =?utf-8?B?N21YNHhsNzhhaVpiM3RIOG52eDRsNVF2N2lhZFIrMGZBd21XWElwSEJqcTha?=
 =?utf-8?B?QlA5S2dQT1dXTXphZ1RUd0NVbkZiajkyZTBnK1k4M2NSeHUrZ1hMWGZPMUdE?=
 =?utf-8?B?YzdoeUxya005MXhxd3V2a1l6d25KcnFYNmVWaUdVMHR6MHdIaytYNXFOTG5J?=
 =?utf-8?B?Nzg1ejdXTnY1U09acFF1dnRsRStIR0lMTGF3L04vbk5TdXBvZTUvMFdLWDMy?=
 =?utf-8?B?d1JQNzM3ZXZFNnBsc2hqQ0tML1ZLcjRDQ0EyYmc3bys2MGhGa1pMd0ZVZG5a?=
 =?utf-8?B?UzB6ODgxbnF3eEozTVFBVW5UQ2lGdlRiMVhVVDU5NHhuNUNMYlBPKzlGZU5S?=
 =?utf-8?B?dnBMMXB0TG9vekNqSnRBcWdhTW5UVjFKYzBublA1UTRLUmZlYlBRK1B2dFAw?=
 =?utf-8?B?cFpQaWJwOHMrZzE1Nnhxa0piMU1JNXYvdFFjTWRCb0pteGZjdWhjMG96ejQ0?=
 =?utf-8?B?RWFkQUNHZEtITFh3bDEvSDJqVmQ3R1lRZjFqV3Y1cEFBL1dYL1E0dzc4b0RJ?=
 =?utf-8?B?NDh5eHViaHhONFZkM2Q2U0hoWWhVYzI1UnUwVlhlMnhmZ2QvTzNKOTZkMnQr?=
 =?utf-8?B?TlRZaFFDVm13NjhqL01BRDJ3Mk9IQlEwWk00dWlVem5TTG8xcXdDekNyeHhN?=
 =?utf-8?Q?reUfxMmGDlM3jO07mrblzH5yP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e71193-53db-404b-f318-08de0adde218
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 04:55:23.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUQhaNXY8c+yNMalAJeEw4NTW9+4W3DlS6B5f/nZpnMHpcbpiPARy8qlf3+Wo8BcRHVXIot7X2W+OmB+TSSzpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838

In normal case, there is no need to invoke mutex_destroy in error path,
but it is useful when CONFIG_DEBUG_MUTEXES, so use devm_mutex_init().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 630e3dba4db15961ae4d77273af6248be614145e..67b267a7408a12deed77d2c8f52d5f64b239a408 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -324,7 +324,9 @@ static int imx_scu_probe(struct platform_device *pdev)
 	}
 
 	sc_ipc->dev = dev;
-	mutex_init(&sc_ipc->lock);
+	ret = devm_mutex_init(dev, &sc_ipc->lock);
+	if (ret)
+		return ret;
 	init_completion(&sc_ipc->done);
 
 	imx_sc_ipc_handle = sc_ipc;

-- 
2.37.1


