Return-Path: <linux-kernel+bounces-891015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8C8C419DA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCD11896F26
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F2329C6A;
	Fri,  7 Nov 2025 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dir7cBtj"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4931A07F;
	Fri,  7 Nov 2025 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548300; cv=fail; b=Ik+P+E9iXphj3pX3cbxO4baKOIQkSBVSq2oJulz9g8QHLtaUpWBorAL3uYF4VHFxh5mBDoZ4SxsrhMjcHrMaMvHKabMD+dSpt5NQezy+2IZbTN35tMrtYDIhkClVainQoqGeF+5unuEOlJzqt+8TBE6owPkkkm4c+AihO92yZ6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548300; c=relaxed/simple;
	bh=JykNP3Wr8V27V/V5mRXR63Vo77tMC6HLDGjlTMTwCO0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GdGAarw/JUSJUQIGppQHpPqRkrHkPiqJpqwhGVvL6d0TrYZS6B4VQQ3DLWnDTpKiU9bV6gqt+hLhmij+yTwEfNI38W4lOHWxCjkD4x0X+IolTHywPO/aWMqAnWphLH1ug+sQRiE/RoNTr+q8iekFF7VnZPuPkVC3/O0bwbXwoI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dir7cBtj; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w58uSFWElDmA65eMEUtzy4kLA7/iiR58BsuLQkjEVKNkX6VKBmNG3zzIpqhcsGo1/tlLT2qEw7wmTkSfrBuHJFy0P/1hQhYsVnPmEaht+o79VAxrfGuhUt2zMrB2Sco1lrDbJYfAwS8gj+8h5DiMe8OXvftIlXDngXCSnVpOI9uyaspPJSLsd3Gxk/I29NS38R5qIyIoZmYgGmh1p8BpEcTgR9T6FAej+m3KRBJkqpMUOr798lRlhSM1/h9oPjgJ7HF6p3sdCOr43IF3iJErlj2s/jX6EfweKl0smfXK3X+QYWD+i9FO0ueQS2Bk/u6VC8jDPGb/tQG+cW2c5k8vEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16r7ZGQxZ/iSnep82FApZjOgA5LJ98oPP+SxebBXSDM=;
 b=f5XgqEYDO3hM698dZf26AsH3+mjIcCQbXPo/7w4OpE8xEbXXcJ6KK29oGiEMfMoffto1iRYiQFMH5usIPcVAMdz5ohur9MdyKYwup2+VXtk43HGtrRLwK+zRdby9dhGSLiF7gT5bsITzop2UXNU3GTi5eMLJY2UCYeGHXabk4Aw572S2eU1K53f2aunevEvmHzoh8brHGjIoyaR9/kez7n9D+Y1EVFHBwL20Ucsdf53JyjgzGCMtmnxAcrSyq7Gtmv4joFMgJAuQsjmrIVwCT/y+WiHoH8aTbw+I94j/Nz34oBdbvyW4KIBR6Nyv4aTEFMqGO62mivVTIV8/J6Ct+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16r7ZGQxZ/iSnep82FApZjOgA5LJ98oPP+SxebBXSDM=;
 b=dir7cBtjACvJw5l3Mk36DeqDkwilND6nJeIzZt/Jm+YEePSzsA5U3DCo6MWJ2N0RtO36v5u4ICbv19T8x5BDEaq1ZbVuKNjCq/cgOLz+tfbY8NYZ1tFPKpa+9IUHa13nTDh6mYUrezZPUnOWCrfVpmSrRLQecoSrehOlO1rKiaAeB+1OhkM5p1ek1XmsRp4/T3MH7fs4bVcrBWpmRggXGJ2WxAy8v2GYCZzlwsNCjGQPhruG9RYJwGAE01bjOb4hjTuPrrOyhFhpjC5OIn22H18GRox43lZlP5Bd/rAag0d4JjoQfI6yigAoJT/r40EkgTJwoPd496DCW0+xZA9uAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB12021.eurprd04.prod.outlook.com (2603:10a6:150:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 20:44:56 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 20:44:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Nov 2025 15:44:33 -0500
Subject: [PATCH 2/6] media: staging: media: imx6-mipi-csi2: use
 devm_add_action_or_reset() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-stage-csi2-cleanup-v1-2-5d42535243ac@nxp.com>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
In-Reply-To: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762548279; l=1965;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JykNP3Wr8V27V/V5mRXR63Vo77tMC6HLDGjlTMTwCO0=;
 b=oNLlP0Y+VAg8r81OdXpXfX3//eabnPnnkEJwul/uYcCW8VZrnVzDyp7MblrDG4GL3NQi0rTWl
 7T0npOTMTcaAJjbSYEYN7zrztwAALwd21AEraQVeg0QfMHmQw5Wmbcw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB12021:EE_
X-MS-Office365-Filtering-Correlation-Id: 87890862-c151-481a-ade9-08de1e3e8228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M29WaCtZcERjNXhoelNHUVBEZlRXZmI0dGJaYlJkSFVianlPek9aVHFqZHVn?=
 =?utf-8?B?dFAyeHlOaENmMlIwTFA2cnNuQkRrUHBjdVcwM1lMSVU1Ym5sNHRaNExobHg4?=
 =?utf-8?B?YlVPeTBETFpHeVBObDhDd3ZaaHpSbTE5WlJSVnlZYTdLeFowcnNHNlBlU21U?=
 =?utf-8?B?dU12TXB6b1FwQ2l0T3laS0hiRllLZzVHU2ZiZEtmZXczRk1VM1RwOGdNQ3Ns?=
 =?utf-8?B?WmxXNjVMU0RlMzVNRzhrU0I0UmtRZE9YTjUxRUZ4WEJvd25FU0RBMGJ2TlBR?=
 =?utf-8?B?dDZXWUdCakZEcnhmeWkyZDh2RUNDMERBRllNYWFHdkJLWWI2QkZJTDhkd1Fl?=
 =?utf-8?B?Z09Ed3lXVlY4SmVFZklPTUt2ekg5bm9mbnpSZy91N1VwcGNWd2dPSDlMUHFu?=
 =?utf-8?B?SDZ0RmpuZnFiUkxBbWNIM2FQNVNSWTR2NTJFSnpBSlBna0p1b2dna25CU3V2?=
 =?utf-8?B?VjVlcCtKZlhIT1cyK2l0c01Ya1dqT2JPT1NkMEUvNStUZ3I0b2VOUlp2c0pa?=
 =?utf-8?B?QXZjelQvdkFjTVYrbXRXOVNrZnQ2ckhFMHRlMXNTWHRLcmFINnhpSnZNbzN5?=
 =?utf-8?B?QjU2V3RKanpqVGlKSGVwU0RhZWpZOVNydDBpdjZuUFpQVmM2VEFvVU5aQUpO?=
 =?utf-8?B?aFFDT08rcTd4d0wyVFg4ZmtHb2dISlJWUzRHQnVVbGs3bEtmM2xYRWx3d0wz?=
 =?utf-8?B?YWgyZlNiMGlTUW1KamJZZUpVb2hLY2hPMTBwa1pXMHJnbXFramNobEswQUtS?=
 =?utf-8?B?TkNJQ3A3Si9oVGZkVTVTWm9aeGhyOFBnaFZmR1FCR2VjUDdwWm9GTGJhejhV?=
 =?utf-8?B?Mjd5QzJoSWdYVmlLWXhySG5pQzk5NEpPYjRrZENETTRhT04yTWt4dVJFU0ta?=
 =?utf-8?B?Q3JOY1dkVHR3bm12U1ZST2tpSXlmMnUrUW55RXQ0YnIrY2RxWGNSQ2h3ZDMx?=
 =?utf-8?B?VDlTQWp6aDZvOXNKeEpzc25SaGxMM2ZkN091a1N6SG5tYmdRYlhDMVJ4V2Zp?=
 =?utf-8?B?Y2FiRDN4WEFjTkdiSlgzelJienNDN2ZqTW53ZjVuUk1DNVhwMG5SVUxSZTJa?=
 =?utf-8?B?T0JpYUVFUkJINHZNRm03SUlIdjJOZFBnZnJ0eGlJcGFoMjJuNGlSdEMrbDB5?=
 =?utf-8?B?eFdNUUpEZ3QyNkg1Tmk1d2dRekRsV2x3Tk14VFBMQlZqRVlVWWFDRnI2ZlFT?=
 =?utf-8?B?Z004Rk5xS1ZnV2Ixekxrc3pPY3d0MlpyZzFZa3MrRnVEUHJzcDZ5ejVjNU1i?=
 =?utf-8?B?aTRSNHFkMkUxenJSS2tlTXc3cFdpUVpCYUZWL3pYNk5UOGlJc1E2N1c2SWQx?=
 =?utf-8?B?ZXdXRzlPMjFaRFJzN0NMMUQyUWR4dTQyNUUyejU2TFVveU9yRjIyNnpQUW51?=
 =?utf-8?B?bmJqRkxHY3NjSFRBOVk3REE1T1J4dWZudWtWdE4zeGNPZXpRWnQ5bE8wSFk1?=
 =?utf-8?B?dkJudGhBUVpDVzBoNlFJRHFYN2l0QUFibTI4QW1paDkxZ0I0akhOKzM3RFV3?=
 =?utf-8?B?eGUraHp6SndNam9VR3Vsc0hwemRDSTdTdjdJTUxCeTZidVFNTk8va0ZtdC9M?=
 =?utf-8?B?WGM3N1YxNWFiMGV4ZWN3S1MrK1VaV3IxVVVTd0dzeTVDMVBqN1BPLzdmMUlH?=
 =?utf-8?B?M2pQaFlUVnZBc0ZaVDJjY0xwZ1FmTnlHNzMxRFRRWjlnMlhuU2FvM3NUeU1l?=
 =?utf-8?B?UTM2SG9mdW5ZdVVTM0N0VlhPcFo3Sk5vdnFLamJYR0NHZS9rZzhzT2UwSkVU?=
 =?utf-8?B?NHNyWVB1MkhlSlREeENORzViTzAwaVQwY3VSYTFJL2Nra1hKOTAxakVmUDBI?=
 =?utf-8?B?dGxURVdoK0dUTEI1YzV1L1N6MVVSa2UzVkpzUytxckJzcHFoSVlMY2ZjdzdT?=
 =?utf-8?B?VWxCaE0xZU5rYmlPZjZ1bkxGYzlTa21SOHhUNHlqZTBRbjBSY1A0S2hjYUtE?=
 =?utf-8?B?aHU4YWxjYWdlaDBXaG96N05qUlZ0S3kwa3U3RHJkc3Iwa2FPM2FYd0VvSkIx?=
 =?utf-8?B?ZkVHT1dvVTcyTW5zZ2dpMzdmS0Rjc21WcG03SGRETWVWaytNVk9jZi95dWNU?=
 =?utf-8?Q?wkAnhZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGlhNGxLVit5Q3U3cGRSc3BVWmpWZ044K1Ywek1FeFV5SVc0eUU5MUpOUkdV?=
 =?utf-8?B?WGhYd1Y5ZnJlRWlLajRPVU1zU0tIb0JjZm9oTlZydVdwY0pTdDAxeldWbkRJ?=
 =?utf-8?B?OEVoODk5czFCUjNxayt5U3A2QytBNXFTa1BrZzM5dnYyMnpaRzVybkNiWUFn?=
 =?utf-8?B?cVFqQUdnWW1qdjhod0hjckxhbkpEOUl0OTRGeHBzUno0OU1CR0ZUY0o2R3g3?=
 =?utf-8?B?Z1dIOGsyYjBNTzYvWFhBQVEyYWRGQTF4RTFVN1J2Y1BMY1BhdUY0VjI4Y1Az?=
 =?utf-8?B?L2xsTlhKWkFVbWUxczdIQjdYaHZrOVJoSmNkU0hWL1NtWmFqaWxUcGMyZUpK?=
 =?utf-8?B?c2dFZTRLdStUSzRjVThlUXpWL3FKaHJIWE5hRzlFcUJKd1RUcDZYbTdZT3Bj?=
 =?utf-8?B?Zk5Fa01LMEsydGF4WUR3dVM5d01McEQ2NHhjUzBGYlhxYS82TjRRVDRIWDcr?=
 =?utf-8?B?RDJOSllKREY0b3ZOM1RHRWsvVkVmUzI4SlNDZy85M08vUUxrMkVmUUlaem1M?=
 =?utf-8?B?N2pZR1AvdHYxMEJlSnRhMmxiR2Z6M2F5N0liU01ranZGYll5bk9JOHMvT1lS?=
 =?utf-8?B?Wll1ZlkwNmVUeGRnOEkzUzRzVXR0SlpBZnRNU3lEUGZSRjNiS1BPRVlLbUlm?=
 =?utf-8?B?MkRYc0JHV3RrMEtQS0l2UFV0L3BmaERac2RKMnU2L0hoMk1QZEFGWE8rbjZ6?=
 =?utf-8?B?Nk1Mc09kYk1WSlNDU3hMQmdlekl6c3FjNDBidndnZll2cmUvaDFFUGhkbk9t?=
 =?utf-8?B?elpzL3FxS1dwcGVtamhjbmpHMGo0TTJBd2FaRUI5TS83ZUIrcVN2Z0pnU1li?=
 =?utf-8?B?NmNlMW5aVlZYM1F6ZmFmV3BYZmpzQmoweEdUR2lUL3J2VTNkSDNSR1dZUHZ4?=
 =?utf-8?B?UlVBWVVpVXN5UDZpd0dzWXh1MWdUSmI4N0ljTFRxTEZvU29aaWMxNWlrdm9S?=
 =?utf-8?B?bUdySldnRUdkNS9VcmpkL1FKZ0VsVWpISitwZGNBYkJUWUl4dStWK2EvOE95?=
 =?utf-8?B?bUNmOWl5eXdmVUtrbVF0MVdwc0E5NHBXMnd6OU12NWYvQ3VvR2JENmRHbnlw?=
 =?utf-8?B?bDJvZnYwZkxqQm5vdWZMTDZKemUvRVk3aFI3NCs0R3F2WEJOVUNuSzYzcXVu?=
 =?utf-8?B?R1ErTEIrVjM3NVdHWlF4QjdpazAveC9hYW85Y1pNc01HSzFZUTY5UXJNL0VR?=
 =?utf-8?B?bHBXSTR5ZlFKUU5taG00NE94ME1Hc1hwTnRRWWdmWU9MQ2l4bm1zMW8xcTZx?=
 =?utf-8?B?ZVd1U2hLWWFVRUpCU3puVWViL1RoSmZaRTV5ZHRELzhFTmVHbW1MZE9vWDBy?=
 =?utf-8?B?amVPeGxWZGpQYkV4RXNGanNmT3JvUkZ0QktzL0hYN1lNQzZXWFhCVFJzb3RE?=
 =?utf-8?B?Wis0YjFnOWVQY1o4bEM3WkpSajV2YjRvUC9KYURUb1R2cXdURkw5N3pQR1kw?=
 =?utf-8?B?SnVMNXZkNlh5QlpQN1JNc0lGOUtIMUxDbXdwUTFsN1gwZkxsVVN2UWtjMGdS?=
 =?utf-8?B?MTRKSUFmM0hZRWdQa3Q2bW41Q05Yek4yUnFFc25DbjlmR1V1MXpjN012VWta?=
 =?utf-8?B?TXpoNXU5eSt0VDJURmd2UER6bmRXY1F1TTNBemNENU1zWmhoVGp4RzRWYWdN?=
 =?utf-8?B?aDQ2K1h1R1daNUU1dUxSdG1xaXNPRFpCWHJkcFdzd0hKaHIzelhzV0VMWlFE?=
 =?utf-8?B?NG5VY1NVODZNUVNTTVBWSUFJQzcyUFBlc3lGby9Ua3V4VHo4alIvWGh4TDA4?=
 =?utf-8?B?QUVxZTRjaW0zN2t2UzBIUXVIc1IxYXNxTmdnNUkvUTlVMUNGWjl3NmQ1SVhR?=
 =?utf-8?B?VURBSXNyNjhTam5YUmdkcFBydTZ2NDBXcS8xeWFmZ0ZzelEyOXVNbEFFNFVN?=
 =?utf-8?B?NTB0ejljeW5UcGtrTHZ0cjNNWERtd3hwOXlScjlycjNpUjd3SFVQLzNYRkE1?=
 =?utf-8?B?eS96V0F5ajJUMTFJeUgwL3hYZDBYR3VwWTczRDUzUW9JVTZ6eWYxdnpMVFI2?=
 =?utf-8?B?amYrY2FSSWhieVdjeVhGNmhvSHRNZWVJd1pOa2R6bytnTm5kQnJRQ3BwZE5S?=
 =?utf-8?B?aTNpNm1yYzRET1FnbysvWFd3a2tncDFWY1I5M2U3NCs1cDFWelBta1FWT2lh?=
 =?utf-8?Q?tFnA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87890862-c151-481a-ade9-08de1e3e8228
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:44:56.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V97qOTKLDcwI3QDwzRy0/59QuvpIZLlfGWUEcKp5NKLjolmZgBDajU0D+N+tc2ggbPTmVQHoIZW8wfUzNMmH1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12021

Use devm_add_action_or_reset() to simplify the code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index 42256441b881d9f132ad7ff899d6f1e35643b4ac..eba9a650030f5e380aa900b94728ad375171c6a5 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -716,6 +716,14 @@ static int csi2_async_register(struct csi2_dev *csi2)
 	return ret;
 }
 
+static void csi2_nf_cleanup(void *data)
+{
+	struct csi2_dev *csi2 = data;
+
+	v4l2_async_nf_unregister(&csi2->notifier);
+	v4l2_async_nf_cleanup(&csi2->notifier);
+}
+
 static int csi2_probe(struct platform_device *pdev)
 {
 	struct csi2_dev *csi2;
@@ -749,6 +757,10 @@ static int csi2_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&pdev->dev, csi2_nf_cleanup, csi2);
+	if (ret)
+		return ret;
+
 	csi2->pllref_clk = devm_clk_get(&pdev->dev, "ref");
 	if (IS_ERR(csi2->pllref_clk)) {
 		v4l2_err(&csi2->sd, "failed to get pll reference clock\n");
@@ -800,8 +812,6 @@ static int csi2_probe(struct platform_device *pdev)
 	return 0;
 
 clean_notifier:
-	v4l2_async_nf_unregister(&csi2->notifier);
-	v4l2_async_nf_cleanup(&csi2->notifier);
 	clk_disable_unprepare(csi2->dphy_clk);
 pllref_off:
 	clk_disable_unprepare(csi2->pllref_clk);
@@ -815,8 +825,6 @@ static void csi2_remove(struct platform_device *pdev)
 	struct v4l2_subdev *sd = platform_get_drvdata(pdev);
 	struct csi2_dev *csi2 = sd_to_dev(sd);
 
-	v4l2_async_nf_unregister(&csi2->notifier);
-	v4l2_async_nf_cleanup(&csi2->notifier);
 	v4l2_async_unregister_subdev(sd);
 	clk_disable_unprepare(csi2->dphy_clk);
 	clk_disable_unprepare(csi2->pllref_clk);

-- 
2.34.1


