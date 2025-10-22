Return-Path: <linux-kernel+bounces-865866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D65A0BFE34F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9A114FAD78
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117642FC014;
	Wed, 22 Oct 2025 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kL6sl+JM"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BEE2FC887;
	Wed, 22 Oct 2025 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165823; cv=fail; b=TYDt+P57a+nvnMBVr2FN69ttdyaZZiS3vqplnBCF7et+70311kmPTgmaZpP5Wv3PaP4jsUydzUaD8hdJwGMLQkJIXHB+ogvQ5rZrN4MjMcaW4+h5RD3Yrp6pxyyOM3DZHMJfM062bSxPfiPISA2DUtFdk7xTZSukYjjkQL1EN1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165823; c=relaxed/simple;
	bh=79g1wZXSjTCPtOPtzMQNPERppyAE/n7VS+3d0quNEQg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=qvFdLWhcl+AD5YZRheEMPqaFfrlJFuHRCxOxy+E8xG02nnQHX+mm93rjz5IyEsSiR8l/I6A6T1WijNhnfmSK8WyF23KpeTSS6ar2nHshtcD5eagpas3sfEqiivraABl77NHvG73etn5EAqB/6lvtVsSCm0QeqVc76HOFediBd3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kL6sl+JM; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WynwQwEVIE7V2355qH8wmaE6ZS10Xio3ta///90CdiV/Xi3c3bkvzP3gGtOaqzKjAiCcMubWWCR9liIyVErdaXwzTi6Hj3rRZo1CePtPE9rIFsLhg6UfCOY3lMPG5QHJuLZih6ymvLzl91fEr1flc5z700cRaB8N2GQ6+xKHOWs3ckg6Dx7SN1aR880RpHl59BRUBifFVb+HhygCgf+IQFCqaduAqiNg/wxlnypKgVxMF6rWmepnnPCyqRIlqw/vCaKsK/1ONLZ30yWAiKYJx7Kg7qKPfvfVMvjppjFZPA/8I2vSBKTnCc0o8YrZ/QAWvB6o8/ufh6CVTPFxA0G26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix8Cq+pVCroPQNuqz9ZI4/khCUYB8CgVs2GqocpsuIc=;
 b=mXwiEARIyMAlZjb42oBsoEDZizoenDzAliuM4jekIDPAHAcaVYeZxC3fKkAEYyLnKq5GT4WkUIR30bNoHU8iSLrRUF9YBr3qa36Yj3m52Ipb043M+FQBu7fM80D/gfDd7w2xvLCxOkqqUb+TRbfGybUbKPNAHutmC/9ho5CzVOc5daPd5c0G+aMVhL2UBFUGMtHIYObdPFnMAT4hbdGIXz5IKn85JHj3rTdnHq/VKM1wud50heQfQV/5+9n0VFHVcmfOHYX/V6nJ21vk6LHdPv3wm8BEYjahxxCfpflwTpAsXPkD4ioCf6iCZ3xqTtptONaPheSV4/5swGcsUnrsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix8Cq+pVCroPQNuqz9ZI4/khCUYB8CgVs2GqocpsuIc=;
 b=kL6sl+JMBHRW9VzItQUst+rd3OLjZj+0epowr1XpXmI3UlFdkFBaUmYd5fFqQPhQIbe8X0qMKWVQ+GRBl/FmLnzu5TgWe6ePdHtAZtxQDtoKLI7DYwT5C91BNozikWCc+vdbc+u4Zv0mfNNpZ0VxhNLwKfrQilkITqcCHelvVgfv8B+SADo5HWgFEMA1PrrNsOySuC5aLcwccoI0sRzlb5xBLjzEh8HlMub0y51I1jczxBBaLefnkOW6G7Qmd8ttbFkAsR8RRcGVACaPBzbjgpSIz81By5Oj2M2Qe2E2AnAXl0D+fZYHPEFiQODGJUqREfkJiPkX/kO0ZGMXeOiORQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7482.eurprd04.prod.outlook.com (2603:10a6:102:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 20:43:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:43:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] dts: imx: cleanup warning cause by fsl,mpl3115
Date: Wed, 22 Oct 2025 16:43:20 -0400
Message-Id: <20251022-fsl-mpl3115-v1-0-93187d095efc@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOhB+WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMj3bTiHN3cghxjQ0NTXeOkJFMTw0RTM0MjIyWgjoKi1LTMCrBp0bG
 1tQAJQBCdXQAAAA==
X-Change-ID: 20251022-fsl-mpl3115-3bb541a56122
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761165814; l=1292;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=79g1wZXSjTCPtOPtzMQNPERppyAE/n7VS+3d0quNEQg=;
 b=CbSXMQ1g7JkgR4n53LhzD5tJreDL+si1/53HMu+f1vfK45y5f8p2v6KHZIfVEzxsqH/ayq5tF
 aH0UwmXxWknCVZQZqNByKCtRTVBMmgTp27v6MoNVFzp3wIe7Ouo7lG7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:40::35) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 850c4ec7-6eee-4ff6-9b1f-08de11abace7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWlLUjZCNFhGaS9XTjhCQVlmZjROOVk4VlpKemlDL3NWYmpHMGJDVnU5WUEr?=
 =?utf-8?B?NEhsTVVTOXBrczJLdE1oZUhtS2s1VTJ1OVYyV0lVbHJwOFl3Q0tlQnNycnV3?=
 =?utf-8?B?M0lUamdHTXZmOFVLSGFVT0hpS1pieThKZnJtSUx5SlBGTld5SkJ1Q3gvcngy?=
 =?utf-8?B?MFJJWXlENXMvMzJvYnh5TTFCUlA2djlKYlQvakhXRU9JekhrUjdmeFo0NERx?=
 =?utf-8?B?WjlydUdHY29ob3FYaWRjcStvVmt4bnUrM3pPZThyRHpEeCtkMnZRTE9uNGlB?=
 =?utf-8?B?bzVRTkJZeXlQMVJ3U0JSMHE4TDlBQnFLQ3c5MXE0UHkrSzlKZjEydFIzV2N6?=
 =?utf-8?B?MUlqUFFLWFFlVlllR2pPN2ZVeVBFZXJ2Z0NjeHRnUEoyQnVrUS91bUF0OVNs?=
 =?utf-8?B?eDJ4V2JDanI3c1dPZTlqUGRYMU51aHJOam9HeXZDcnh0NENKZkM2ZWYrZ1VO?=
 =?utf-8?B?cW1wc2FwUVZDeWVTN01KYlY1YWw3ek9heFMvcXozbk5zSFBTZ1RYTmtuNTVv?=
 =?utf-8?B?SFFsanllaVNDTFZzc2NuME5rKzFoZjF4UDlHbkwremowRE5HeVNPZEZ1dHlu?=
 =?utf-8?B?NUxMNWhRejJXckx4VWtiQ0I2NHBYUlpTSnEzY3lDS1YwZHdpcm5NbnUyYkpK?=
 =?utf-8?B?V0NQWU55K1YzRUQxeUIrSHJ3bExXQ095Y1c5S0kwVWN0ZFFZa2J1Q0pGcnZV?=
 =?utf-8?B?K1JtUy8ycXRpUGFnZWUwdVZBMytma2dlUkNrWVFlNTNsU09qM3ovb1VIYW9U?=
 =?utf-8?B?U0xoODNZZEJkUGNQc2NJTDJqQlFRbEdrMlpka0Qyb1UyTVVueVorNHdoOGh3?=
 =?utf-8?B?SForS081TjhDbWgwTytqVlZxTCtzWFZzc3dETzRRdG45SUx2aldZYUpPR0RU?=
 =?utf-8?B?WmlRekRvTlBYd29pMzM5Mm5PcWhNWW1GUVRWQ2xaMFRxUFo4WDh3U0VqNlZU?=
 =?utf-8?B?RERQTXBMWk9NNjhFZW5lUWxZUUdHUjJJTHg4RGRWdHZTT1pwaFlxemJnQVNl?=
 =?utf-8?B?NWpQZ1NRRnVBLzFYTTYwZHZoVTJlUW1nN2o2TmU2SjhqRHhnU3cwR1NiaW00?=
 =?utf-8?B?QU1CWnhPTzlvejlJQVJzNVg4d3RkL0w1RktBQzJPT0VDSHNoRTVmajF1QndB?=
 =?utf-8?B?WW56SHhXL2xDKzRvQzRDRWhjUE9YOXE3b1VrSUZKeGV0UWhUTFZnTnJLM0sz?=
 =?utf-8?B?Q2VtZCtnaE9kUndmeE1OMFhVc1dOdnlTM05xR1FYcmpNWEZFeUhUTDdmV1A2?=
 =?utf-8?B?NHZwTU9BSVBjb0pvdVZRYk1RcTMwa1I2cS9Ba2M0UVordVl0WmNpN1hjOHFo?=
 =?utf-8?B?amI1Qks4cGZRejZUcFhEWHhPR1o1YU1zeHNMdUVvanNoNGtkL1o2aGxWLzRm?=
 =?utf-8?B?R0hCRUx5VmdIbmtpSUxXcG9XTG1pWFBLZEVkUlpPMk8vUVdKVFdyb1hSYVE4?=
 =?utf-8?B?QmZxTWF0Vkoyd0czMno3dCszUDFRVUlvRk0vejdOVnQ2bVVBRzJLUXVyWXhD?=
 =?utf-8?B?Z0RiVzFRSjdJanlRMkFOM2NPWXlsRmpqZUV3Rzlxd0hKNVFQdnZUaFl5NGpZ?=
 =?utf-8?B?U1VCd0lsaU1pTXNnc1BVb2tUd2dOdm5uc09KZm5uZm14Wmd1dU5DMWpsYlRv?=
 =?utf-8?B?KzBXN3c5YnpJRmRQZEp5U3FjQTlLTVV5MGtvYkJNQ1VQTEViUTR4TjJkc0pt?=
 =?utf-8?B?Wlg5WHY0eUtRVTQzQ05YU3dMRGF6MWF6SFZBWU4vNm5nOXFwYk83ZUZTM3Yy?=
 =?utf-8?B?WUtzc2hldnlVeGprcFhlVThkakwyOHNkc0FEcGxZMEtUM2lLUUxpRm1ZRUlY?=
 =?utf-8?B?Z3JHcVdZMmlLL0JVYUxGOVA3VmM4Z05kQXZ0ckNIRzBIRTNxZmUyOU1ia0Z5?=
 =?utf-8?B?SFUvTHNJZXpIQXg3Q2dLSER1enJXSHE1NkpvcTJTVmdPM3hxak1jeFlnNWo5?=
 =?utf-8?B?WmtRVDZwRlZ0REJlMmFNVTl5anI1d2J2ZFVqOHdhdFU0UWxORkhMcWdOcy9m?=
 =?utf-8?B?eVJmTXVHYjhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTdmM0k5blh2N3RGWVpDNGc1aVNjejZqalhBbE5KUGxsTGpRaUdBMDd1RUQy?=
 =?utf-8?B?dGU5Y3pYMU1Ub2R4akZVSWRWN0l2aHdGQkxWRWxtbTlydHR4NkpIdTIzbmVm?=
 =?utf-8?B?YThjQmREK29uQmI5a242cm5LcE5rOGFMcEQzTzl6dkUwUWtkWHdFcURIVDlr?=
 =?utf-8?B?YUV1a1BzaUFSY3I0aU1rMjI4TGhyWnpnZ2RXV0xFZVNBWVRrTjB4T2tURjE4?=
 =?utf-8?B?bVJSN1g2d2hma2E4bWJ5MERaWWNRU3V2alVON1d1alJQY2RDVUtJMGJtUG1Z?=
 =?utf-8?B?ZE1yM2lyTzNDM0FXc0JsOHhIMTRDZ3I2YjlxNGVCdHZRUzVlc0ttQnlMVHl0?=
 =?utf-8?B?UlZkWGg1LzNXNjNGaGpxMkxZcS80VU9udElnUjFXcmRPOGxyU1M1RUlIUi8y?=
 =?utf-8?B?MkJwaEp5cmo5T3V3SnkvTWdXckNYOG5tZ3U0eVRJR1JoY3hSZnZLcmEzRU1a?=
 =?utf-8?B?amhQeDByeGRPREx2bnRTbmJONjVDZFJMaWJMNjZZREhGdHFJZjluTy8xUnlK?=
 =?utf-8?B?dTRQa1NyRmYwb1RmRThtQmh6Z1Q3cjJUeHNWb0QzYVp3MS9FWHp0RXQwZ1dj?=
 =?utf-8?B?a2ZPSXBNZ0pmRWN5U2d2RXd3WTMyN0diMTdtaDhRYU5TeFMrZjlIeXhLU2xS?=
 =?utf-8?B?dkdkM2pUeUFXZmJST1R0b3RjZFVwdWp5R2JURllnQTVhNHpEZHM3eGFIOHJW?=
 =?utf-8?B?YTVESkpyL1ljbkdzQ1ozNENSUHNoSGRHYTJYSzB4R21FeW5yb2dWbXduVVIw?=
 =?utf-8?B?UjVNckhFV2xXbzJQQlhjb2p2U0gzVnh3azdTdDFoZWREd0VZQ3YycXdTYTdK?=
 =?utf-8?B?RzNpc0ozMHJDTVZRN1pta3VqZ3BpUlhIQTNIa2tJUTRTd3E0UzJONUZZeVdU?=
 =?utf-8?B?M2FkNDB6RHRlVm1WOFJ1SldiTlBWRUxSRHIvTEU2ZlFXV1lKYVJtWWlFcVBQ?=
 =?utf-8?B?OXg5cHBnallGdkw0aFRQN3ZOWURjZ1EwSnMwNi9mNVlPYnMyVnpESEU0ZUR3?=
 =?utf-8?B?MW0wT2h4ZlduODlJcyswQVVGcGthdlVMK05GOWFWa0lVY1pmakxmUXp2UHVU?=
 =?utf-8?B?bFZRZ3BWWTE0bzg2NXdtUVNZbnVhUGNIRnhmTWxSWGJ4NHNneS9MdE9LeUlt?=
 =?utf-8?B?UC9kajlpUFdHVjk0VFFLT2g2S2hiazhOU0NhUGFtUEFoK1orTE01OGU1Mmlx?=
 =?utf-8?B?N2VBL3hSN1VWcUpscksvK2J4UVplekhuT1ZqaVY4OGNFeFg4WFR6dXpQazgy?=
 =?utf-8?B?U2RlZXpBZHZMQTdXQmVBdUt1QVk0REdGcW4wdGppaFVTMENJamZKSzNVempa?=
 =?utf-8?B?ejZocUhYWnQ2R3dSTFhSaUNCVHFqb05KNjlLZFE0MlEzbmxFRGJnMVhXNzF5?=
 =?utf-8?B?djMxUk13Q05QNTNJUS9xc2YvR0NJSm9oUDJsejVESGlocnRlemhxUGprUzlD?=
 =?utf-8?B?bHVjQ2taS0kxTlUwRkZkL3lTd1gxVW1kcTVlSUZYaGF1S0d3SlBTZnpzbnJY?=
 =?utf-8?B?Q0hSck5ETzlNWFlzNzNJbmhMeVlhVHR4OFZCR3h5d05BejNCSzk3OGVoNzdS?=
 =?utf-8?B?bkFYcW5oNk5aQlVsaFA4bndlYVQ1clBFSHRVQjlhT296c2Fmc0ptUk5WYU1F?=
 =?utf-8?B?ZVJSaUVvR29VQzlKWGxTZm1LUnNYakhyZlM1SzFyZFM3eWVqMlpMSWdsOE4x?=
 =?utf-8?B?K3NJWndNWEdJVk5KYmhxajVpTmp5UUhWOFQ3RUpPcE5GTzN6NGhFSDY4QS9D?=
 =?utf-8?B?aGVOVERnbmVMM1dKYUhFMXo0cjh3eUxZNThQbTc0VFZNOGdVeWU0bDdlWmRS?=
 =?utf-8?B?bXk5cUYxUXR2WFh4bldTb3RrVTNSODRsQkhRVXBhM2s5dEZiMy80T0VZTW1t?=
 =?utf-8?B?aGs5TEM2L2g1SXNlZ0JHZmJQQXJtRVgzRDJ6WjNwYlhPSjFtV1lYT3FqNDdk?=
 =?utf-8?B?c3RUSU9uWG9TNDRLQlVHbzhRdllGa1VqRUJld3ZRNkZONGM0a3A2OW55R0R1?=
 =?utf-8?B?QlhTUndHY2pEN0pCVUNReXMvMjlhTHNYTUk1bUhxWFNseE1tSXZCeWxZMUdM?=
 =?utf-8?B?Si8wV1hma0FDQzJJT2d3TDFCRzVHdENpQUpYUUJkWDdoSnRubmtTanRWdFdR?=
 =?utf-8?Q?PjnQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850c4ec7-6eee-4ff6-9b1f-08de11abace7
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:43:37.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7eHkjEuO2izclmlY6LLqJSLD5WOfeQ24ajnglLziMrgjMJF+hfYj9AuQGv278tXwFOVXQ9Nypr9wQM9jfZZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7482

After commit f11e4374b(dt-bindings: iio: pressure: add binding for mpl3115 )
vdd-supply and vddio-supply is required properties.

thread:
https://lore.kernel.org/imx/0e00bb14-19c7-493a-9629-354bac3a273e@baylibre.com/T/#t
not prefer change both to optional. So update dts to fix CHECK_DTB
warnings for both ARM and ARM64 platform.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      arm64: dts: imx8: add vdd-supply and vddio-supply for fsl,mpl3115
      ARM: dts: imx: add vdd-supply and vddio-supply for fsl,mpl3115

 arch/arm/boot/dts/nxp/imx/imx53-ppd.dts         | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi    | 3 ++-
 arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi     | 4 ++++
 arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dts | 2 ++
 arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts  | 2 ++
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts         | 2 ++
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts        | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts    | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts   | 9 +++++++++
 9 files changed, 41 insertions(+), 1 deletion(-)
---
base-commit: c31b21db1c04ba719c3889a57873f0f7eff54670
change-id: 20251022-fsl-mpl3115-3bb541a56122

Best regards,
--
Frank Li <Frank.Li@nxp.com>


