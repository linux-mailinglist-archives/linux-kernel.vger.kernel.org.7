Return-Path: <linux-kernel+bounces-824084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CB7B88151
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63A91C84A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B429D29B;
	Fri, 19 Sep 2025 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PDgarf8I"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B140034BA58;
	Fri, 19 Sep 2025 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265390; cv=fail; b=MS6UYTyGRVjC02BS2HcqhmVj/69J8hKKTKXKPTcOlDTiIiWrckpzGV72UbyCchUdenWhOAqrEIErQq5L2/FiRufvZ5o35lcXc4uwxHKB9fTLrm/9957dfV1HcaFCZXc6eLJ7K1G97gGpazvQZF9h+Z1TL6s1Jv1G+EvXuHPeLQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265390; c=relaxed/simple;
	bh=OC5TpbqS8R/fanVZbK6gsEfielgBkWAXIHp8LpAT+Pc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uctJexFq3ublXdE+41gDcijS4B0oV5/uOFSn0htyRuX3ZExkLS+Dd7ZLoIMzCWEok56bE3zN2vZnciW3cbQfWAYy2QbBxDas4oBVGQwaWYLGzpe5D2nKNS6STMa7KhnquErYo8KgUlvzEDMw2cG2Fuuo1u8v69Stz9I8nQwO7UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PDgarf8I; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYyfQkHzEJIxgHuvZm/WuD7dBa+qCc/vqPZ9cioa7UH+VYAk3hPF3qbwaYRXPrzE4td4OcS84VZAFePfBxZNTPqRpbK3ZFWZqOm1b1SSFzCKRVj8wyQ4GRC5gSAImdXMTmmJPOGpkGMAC4NR3pOFXfVGIlZJ9ZT3nJC3AjwdCCM1PppBH8JAcWLhTSPPMAPYtMVcNH6iMdPeSFlSyFLO32LL+bVwh9s/XXijkdeNsZA+SiWDuAOFICQVFY26/IdYI5lt8ogoR3WpdMQADrUAfVVSyEW3c1t/x220Wy2yGR/LsItvooxvdcAz+aiYGgUCp+IWXWWUbjdCUG3AxiJDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEKrARIzOqaiupXmTVbonY8hBMO7nM2/sBsLwOsbQ2A=;
 b=KCM63nsLt8Vkwzwv1d8qZHRx3uDh/jD4ffWnD6aF3iC9SNxn3Zx/rKgdKoLkExNN/+xNfvpriWwifBqzXNncbPs5FUYEaQYFUL47AfxUlw672Q6iYyzk9RDufkb4HDLjmaHGoUwYdwzm6u1+NIlbNKiS+i4J83hdNM6WfSGdYOqYA/+AIWkoXTM+UYC/5BUDja4mLTrdCG4e+HJ6IsPwiVBwcGdH9sHZo1B1IkMdrJXIcxFYIJDL7fVgQd1AkuibLKZuRhaedUU35DxXfH4R6lxCiufNWi/cC4aOXXxm4GTii+rw7fjDAXB/9cVPUhGJseyaPm/2thJ5wcZ9VH7tsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEKrARIzOqaiupXmTVbonY8hBMO7nM2/sBsLwOsbQ2A=;
 b=PDgarf8IdcrGGexn9LKTznJL9nyH1XXbygH86ajjbm58SJqbQ6ReHhdtNrGyjRJWsL15Wn9u4B32jHmdB0wAuGcJAhna6KbJXlAcV1gZlMBl0UrAEThBU6mglKUhiYdduy0CrdeKef0jRa/cTDcXAR1Jf+6G6UUOugj+ggyTkIMDdAQuA7E/7cA0XRcGi2/X2dlO4zC7vWG4mMrt7AKce1APtGBKEnX4lvlB0GqsY2/Xq95P98gd5ZUtH515ozQygXIWVOysiCL26vWi33hlychFijN/ugs04aPM5MQIUMjhDxac93Zn+NFwsBXWicI2Dz/YCxMEE9UiWYikdcDLvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8554.eurprd04.prod.outlook.com (2603:10a6:20b:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:03:03 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 07:03:03 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 0/4] Add i.MX95 USB3.0 PHY alternate clock support
Date: Fri, 19 Sep 2025 15:02:56 +0800
Message-Id: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAAzWgC/x3MTQ5AMBBA4avIrE1S4q+uIhZVgwmh6SBE3F1j+
 S3ee0DIMwnU0QOeThbe1oAkjsBOZh0JuQ+GVKW50onGQzp0041m2dEuM8rh3OZ3pDyjQhurykp
 BqJ2nga//3LTv+wEm4Ii1aQAAAA==
X-Change-ID: 20250919-usb-phy-alt-clk-support-e54e69ac0780
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758265397; l=1253;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=OC5TpbqS8R/fanVZbK6gsEfielgBkWAXIHp8LpAT+Pc=;
 b=yE/LcAF9bLG7bMdcJAba5YcofoqaRBY3zyQxvmTM7sn4vZh1yDylot1D2i3aEwn1rX4K+ri9B
 UI+xeauEAWdBBFg8AohJVCusmYW+99grESwouNmnlqOwnUN+OlzvR6A
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM9PR04MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 998c19b6-83db-487f-2f97-08ddf74a939e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjlwZHZOTVFDdXloL1VIM2dHbzk4c0RManVBQ25lUlIvWCszTysrY1QvWm9p?=
 =?utf-8?B?UVljeVg3WDlZcm83THNrMUJvckVwNW1nTnZJZzhqT1JEZVlmaVBRTFZjZ2lL?=
 =?utf-8?B?VE9EaUlXdzNQOXU1YXp4blZPUDdDS3lMNXYyNVp5R09XQlp1Z1JYN3l1VWtF?=
 =?utf-8?B?b3dMZjk4K2VEcFQzdUxxRDBYYjcxSU8ybkx2U0lmM3NkOEM2eFRNbHQ4bG9m?=
 =?utf-8?B?SUZmNHFJUUZuSVlNRHlNL0V0d0tkOExMNTJka3dsSUsvc1d2Rm9yYVlpeHp3?=
 =?utf-8?B?S0pZNlRTWHJZc1QxYVMyL2dRdm9rcnFqdUZqODZnLzI1em1FaHFmRk1wM1Nn?=
 =?utf-8?B?M3g1YVdYLy9ZWjNXME5VZXhmNTVodTd0cjcyME5lSDBHYThMaHBUS1BNU2xC?=
 =?utf-8?B?c3ZEN1UzbUNwV3lSalAvVENKRzIzMUhCd1NNSUs0RVNwRURZemJ5d0NmYnp4?=
 =?utf-8?B?RFlJNTdaZng3bndHQW9WcEI3Y2ptTFh2eGUra212L3plVUp1SnJjR2Vla0lE?=
 =?utf-8?B?TUptS2ZVd2RsMFdjZHBJN2pPU3RNbEZ0bXBwbnM1aWd0cDl1L1Q2aTAxdG5R?=
 =?utf-8?B?RlpKSVJVZmExRm00dlQzYWxuTDUzRlg4ekxoZE5oWlRVSEdBaHpwQWVVSnQr?=
 =?utf-8?B?VkpYcEt3R0RZWWl2U28yLzBIMlU1WCs5allWMkw5THQ5TnhDUmJkeVY2WW43?=
 =?utf-8?B?MGtSSTc0cmQ1N2MxaXVyUm1tNmVSZjhFMFN1N0JLUFVpczQ5QWE4cFBpeXhS?=
 =?utf-8?B?RkNyVnZOaHRQTzRHbGlTd2UrY21WMFF1TWlMV3V4T2ZickFybFdhZG1ubkp0?=
 =?utf-8?B?N1NhcHpPYzFRUXZJMW1iMCtiK1ZrK3FYQ3p5c0FJWkFXVk01L2tFWlRhMlpI?=
 =?utf-8?B?OVZjTDArY2t2eHlxanJablJ1M1M1TWE1UnROVTZlY1B6R2JCUUFMdmo4blBx?=
 =?utf-8?B?NlJYcWhxYjF1Ym1WeDFrNWJzM3RhbGdVeXNtbUlBeG9qRXh4eFVzTjVUODdw?=
 =?utf-8?B?S3k5bXJaS3RVSXkvWW1lalJXV1AyQUQxdVgzclE1aE5EM2NySjc4eVB6K2x3?=
 =?utf-8?B?ejhxMWlvN2dmNjR1UUNodzhTRkREb1NINTVnZ2dncjVtbXNZWWJOaTNDM3Ez?=
 =?utf-8?B?R05jL3p1b0drTjNDalJ0R1huZUFJWFgxZ0ZqR213OEluQWZBM0EreWdFUExD?=
 =?utf-8?B?bks5bnNGWGlVKzI1VS9SVFF4UzRpV0lqYkNTK2pzUjZuNE9pNXNYVHgwQnd6?=
 =?utf-8?B?WFByWXk1a3E2VHE0SjlwMjBuc2QvYVoxL09CMjJrTUdmemZXRlVyNmQ4WWV3?=
 =?utf-8?B?K0VYOGptNUpSNW1nQisyR1dlbklZZ2F2VWQ0bFU0bHhveDdTdTlHK3M0UTNa?=
 =?utf-8?B?bmUwYzRQMzVmQjErWWVJRU0xWVRjWlVZUnh0cVpheDIvNUtma09JVDE2SFdL?=
 =?utf-8?B?U0VEcEJDZXlJYW9QSG1ZR2xQVWNtc1hCQytOS1FINGZIdERJTEYrRjRNOEdK?=
 =?utf-8?B?YlBsTWUza2NZVE81UUFScDhyNTViWXJlZzV0Nzh1MG1ZU2pXSGwrb3Qwbzh6?=
 =?utf-8?B?S0d4dUxnaGJhVlEvc01HWjFmZFQxYVVtNEtSSHpNQVFBUHZhVExMajg1NEhW?=
 =?utf-8?B?Z09KQzMyWmtsb01OeWJWa1hMbVRyYjJtMWhNcFpZMkdyVUp3VnovcjVxdys3?=
 =?utf-8?B?QlY0dytLMGNsT3BJSEp5MUdXcGp0d0VUWko1b1h1MzFzb2xTMEY0ZmlvendR?=
 =?utf-8?B?RWVkczdnRVdqRWdhNFN5R25yVDdER0pBVDBRNFVlSzNRSmtoeXlaeW9sV2lG?=
 =?utf-8?B?NUxBUU5ycHU5aDhQSitsWEVWdEpDY2pIbEhleHFkZk5sTStiU0Fybzl2dm5Q?=
 =?utf-8?B?K2REcWtTNmU0RkpWdFBWRXljZDRib2RWaFdsdnpYOUtqZ1JNMzdWR081TXht?=
 =?utf-8?B?UGxDNzRtc09CT0p5UzBWS3dCdWxtU05hNlNPc25rWDN2QlE3MElDMzZZalJS?=
 =?utf-8?Q?FWVzIoroFXiJZ5auigT2VoKJnWkfoE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG5sUGRNbzE1UlhZMmtNb3VESFQ3bUovNEtOUXh6c0hvMGNONmtVQ0VibXZv?=
 =?utf-8?B?WGhnR3lQQktObEI3UEU1MjI5T01LVDA5YWZQcjBvODVtbHlDOWovdFRUS3c2?=
 =?utf-8?B?UzkxckdCS1U0UFFxM1gra2xqTnI4dmgxU1ZMUERDNUJBSTdha2VXOW1xN0RC?=
 =?utf-8?B?NDhzblJrbkdyZzkxc1haRWJjaEh6d3UxY29MVnFlcE04UlpLdDQ2NjFScW1Q?=
 =?utf-8?B?cEplV0taSzZoVXF2MzBJdG9Qa2VlT1ZLWE03a2lrUjBHekFyUTUzcG56QXhu?=
 =?utf-8?B?T3JuWHZVTEEyTzZBb21IRFpVVGh5cTcrQnBJUElzYUYvS2daVmdhbnoyVDR5?=
 =?utf-8?B?dnJOMkNMdElJRWtLSE5scE1rWDVCWFc4TVRXWTNLdzlnYmhuZnZWNUp2RzNP?=
 =?utf-8?B?TXl1SElZcjlCSzJaZkh6R3ZiR3ZpN0FwOXNFcVhWSGRLQTlhRTN3TVpBclU0?=
 =?utf-8?B?NHNjNTU3Q2s5dzM5SmkzVXFGVy9TWTd5WTZqQmg4UVRDV1lBbTZrK1I2NDhW?=
 =?utf-8?B?QllYUzJ2SWFDZk5hTU9pV29sQjdNc0p2WWZLbHhLNGphZFU3R1p2WitiMHRk?=
 =?utf-8?B?cUE1MS9RbWM2RTVXQnJoekVMUEJNQ0d1R3pFZXFzWjhYRUdWYXlDZEtKNGJs?=
 =?utf-8?B?a3I2RkFIQ2RRUitidFpsdzNIR082Y0tDU3pMdE9oK1VzTExyS3F3UG16cGU2?=
 =?utf-8?B?WjArWng1d2pZTko3NzJvU0pnTVNWQ1JFNkt6amZjamp5MCtOYzF4alhDcG9h?=
 =?utf-8?B?a3BZVHNnZGk4SzZCMUY0TWFHL3VqV0RVL2NiTVo0UHFwNTRIUHRESW9GSW5K?=
 =?utf-8?B?SU1RN2pNdzhBSnFKTWhPZkZzR0pMSzNiWldlQzRhcURaYlYwanVSVTlpVzFO?=
 =?utf-8?B?eElIOERxSmhCS3hteTNFNUJHeXJCSXFOTjZVaUpNWE0wRzlrbm93ODh2cVlY?=
 =?utf-8?B?ZlRBdUtFcEdJNHpwd0hQaVRwaUt5bVRRY0VNN2MxYmVzQUJrUXB6OUJxMkdG?=
 =?utf-8?B?UkwyL0h2eFlDamtPeGkvdzRRU1FoZlNNTEwyNG1xQ0xaRytmNUlhRU9OQ3dm?=
 =?utf-8?B?N0daL3o2cUZ0UEtjUk93NXJxNThUTVh3aDdDdFdvYyt0emJiZklkVHF2THJW?=
 =?utf-8?B?N1BRVzhBY2N1MThKQWx1NFMxN0t5bnpmTzJhNDlzbnVCYW8xaTBjeHpHZVlp?=
 =?utf-8?B?N2pnM2wvSEZhOTdmeUk1NTl0ZDBmR3FpL2puUEhVYjMwODEwRTlINHVuRGlU?=
 =?utf-8?B?M1M4M1RFdzVSVWhLL3lZU2lPT2cyVDNhUWYyRSs2VkRQVkwzMVhBTXlEaTZu?=
 =?utf-8?B?S1cvK28vU3M5Q1NkTUEzSGErOWVVSHQvekFMWFZzS3FKYzhNVGxEWmJwVXVR?=
 =?utf-8?B?Q051ZnFSWXdISHRBaGdGOFA5SFhjRUZBZEhBeVBNYmY0TkY0Y2p6a3ZKQmxK?=
 =?utf-8?B?Z0RDM2Z3cFFqS0tmdkpEUG8zY0RrdTVRWHR2U0FNZENqSWZRbDkva0J5RDF4?=
 =?utf-8?B?WWtHQ1FNSVRQeFBQd3VOTFoxaGVWbUdmYUJ6Yzg5cGVUU3NMdDJJMGNBSHpC?=
 =?utf-8?B?RjlGOHJ2VElXOUJSK1gxZHN0Ti82TDN2NFVQaTdKVCtXaXR6aG02VktjMEhx?=
 =?utf-8?B?dkExZEZXY3g1bW5OQy93Rk1ZRDRxYS9YRGxwTjV4WGg0Qkp2VElJUmR4MFQx?=
 =?utf-8?B?ODRjU3h2ZlZLK3JyUmk3ZndhdU9nM1Y4c25pbFdSYmtaa2QzeDFSUmNURWJX?=
 =?utf-8?B?UkpiRXN6YzIvaVd3QjRlOXgzKytsU3dEajdRU0J2M2hWU29QMmo2dXMyUHNV?=
 =?utf-8?B?VENkVEVMZVBEcHVrUjN2bDg5VFJMaG96UW5nS01WcXJEV1dTZ1VENE93K212?=
 =?utf-8?B?eWgzS011QTQ5UWZmT2k0SFdmWGc4T0tUS0VXZUlZSHcxTFJGbjF5SWRMcnI1?=
 =?utf-8?B?eVhQVzRaWVdpblhjcU9GbWVLTCt3aU55eHZscHVmVFNIQ3oyZ3g3Uk15M3I3?=
 =?utf-8?B?aEhLNEI4SWFyQi92K3hnckZTSEVBa3E3L2pQZ256U0QyNkVVOS9JSmZ4VXRl?=
 =?utf-8?B?YnBFRDhTbG85Q3RXM21kY0xxSGVTR0ROdWM4WDZ2U2xTcnVveXZpNlhnd3FY?=
 =?utf-8?Q?6kdMDPTpBt+76ABXibqcaDiXo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998c19b6-83db-487f-2f97-08ddf74a939e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:03:03.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFKkx6Lpv6jFWTfzEO3Mt4TcAvQa+aNvKpQUpmcOazzPpLk8xT4h7AjQp9oU+D6n5Kq4NKMk9EPSPwgVArGGfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8554

The i.MX95 USB3.0 PHY supports XTAL 24MHz clock by default as reference
clock and 100MHz clock as alternate reference clock. If the default
reference clock brings USB performance degradation in bad condition, such
as the working temperature is too low or too high, switch to alternate
clock may overcome the degradation. This will add alternate clock support
to enhance the function of USB3.0 PHY.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
Xu Yang (4):
      dt-bindings: phy: imx8mq-usb: add alternate reference clock
      dt-bindings: clock: nxp,imx95-blk-ctl: add support for USB in HSIO Block Control
      phy: fsl-imx8mq-usb: support alternate reference clock
      clk: imx95-blk-ctl: Add one clock mux for HSIO block

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  1 +
 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |  7 ++++++-
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 19 ++++++++++++++++++
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         | 23 ++++++++++++++++++++--
 4 files changed, 47 insertions(+), 3 deletions(-)
---
base-commit: a4e143636d5def935dd461539b67b61287a8dfef
change-id: 20250919-usb-phy-alt-clk-support-e54e69ac0780

Best regards,
-- 
Xu Yang <xu.yang_2@nxp.com>


