Return-Path: <linux-kernel+bounces-886982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 272D2C36F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FF81A268A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D64D33F8A0;
	Wed,  5 Nov 2025 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OM7EH1mD"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C1337BB2;
	Wed,  5 Nov 2025 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361756; cv=fail; b=ddwAsM/E+lJjakApUeaOj5EeA324q5WekMS02PiSygRH7faZfnQiuLWPDZj+qb8cW6WNGsfjR+l44AD6Ly2SDZNYeRlEtYsALSg4fQJg7G3qdLBhkk7eiBTmW7I5D57vw96K0FuZr2AcuhHMk4nmfLJG7XqJPxirg3JyZoFzwyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361756; c=relaxed/simple;
	bh=hgefSQIgct6arm8fr0glNS6dS0RhUNZ1ekirJ2T5TIg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QhOGi6AAnZBdKb/y4PZsTMCOUnbZBEL7UP2k2FCB3Bk/JvyYBC3BtA7LC7aW4hQmL3TRqOgeshf/GcT9/Z+aURMypWQVtDHfUHYNYxCF8fCHpNP4VCGM4RcK9dajXkgDBcDJlyAEtwppm89mcTfyxLZUs1clETc1OpG3LKVP0iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OM7EH1mD; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOlY5YtoO5Ai7fcR4Ztdx/COhHSauvGUAKqWKut5Sbm8gUfnqbyg1aCqSPNuIxLrFWDO2IsV+vWaRRRALzROZEtuz/CMjaZjjUXyIlNGBwrcbyhC7e8pKTa6ihFnbVppnQr6XonxMrBYLhBBH8kmnJuCsavRrgXqhn4aRIm8iTgPV5FEk9ysqAdUblmTtfd4dSRxiZ04iWMhB3idFmrHzUf3x1y+VOh33uf7ZbOceGLSZVhXTuytB+IAQu40/E4SpeMccPvpOd1U/sm2znVpbbW/FmopZV+i8L4WgE/7qybrXHRf8KDEwqg37K2RkyYPbTVtEC6XH1rrigtqBZbpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHjYbV23FwpM/8l3CGIomYpGTYtXUdAH5v3YNR0USoY=;
 b=g6geu5Z5ccVo56GllY7n8+0FRzmdtXwXguEuF07UBFE/0dLvzO5lGS+lmms650Sqoitb/vluP448bYhYGpf2DMm0VZhsHUjLpIQN7OxxpTPxlRcP+w8DA+O70VusQFGpHKaPf11KwEzKWaMmQmbKqK/nKScUyCuZohaMvlXJSVgwAjJxNnsx2k7moVv0rORSfNaI8XfNGpJ19lSrWZKQwLacCOJXhZIXUBbadYtrvkAQZX6r/BvoZlONV/4FOML/5ryCtEP2UY0DLO7sDn+SYrIEG+m7m5fjoCJY2ive0HOCos3ax6+aVVoZc3DxE7tELO4mDdIRJjH9B5OTGoPaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHjYbV23FwpM/8l3CGIomYpGTYtXUdAH5v3YNR0USoY=;
 b=OM7EH1mDFwrO7DFQEou2FcXkAnKU+lJbYbYNTYBVXBpVIVryvg7XBUIY8BxwP+MIOa43IqS6ft8YvKxd01XBqTQSE0Uj+8x6QuR0ow/MXl9WyS1JYvGGvkSz6wi+4aXpa6eH73sYiois2Xagnc+mNcJCFXDer4TtukCVKn4hmwf9LuUk+gCfLh10Pyl+Hl5N+jM11CM1I7Pts2/4IBkP0Wtw7T19N6PtKlAG1uGulphHZ0aAc2SoEe6I8kqM0ZCELPHfXYiMfe4Gtt8VcqkRdYWmO/RHZNdKm2tOr276Hz17LLScOQ/v1KAZgQDlLZhnnkLnoMAUwDSPlzrV9wRZJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8877.eurprd04.prod.outlook.com (2603:10a6:102:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 16:55:51 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 16:55:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 05 Nov 2025 11:55:28 -0500
Subject: [PATCH 1/3] dt-bindings: clock: imx6ul-clock: add optional clock
 enet1_ref_pad
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-ccm_dts-v1-1-6aadcdf97cb8@nxp.com>
References: <20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com>
In-Reply-To: <20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762361743; l=2147;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hgefSQIgct6arm8fr0glNS6dS0RhUNZ1ekirJ2T5TIg=;
 b=weCLGcSROz7aXCotMgmPC0zPIyic6KG+RZVO13LNsM9RMeP1qoFWz3S6FZaoNz5XhqVG1QYLB
 GaGS4OAxo1IArBhgLyEvFv3rutRZU1nuuV+4fH5UgEF+soOc6Fg8pNr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:180::20) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: a7236451-3ae2-4e2f-66c4-08de1c8c2d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2pvc3BmZ20rNkFjd1M2aGRLRTZScmMzSVA3blY0NXRWUHI0cmsyTi85Sk1i?=
 =?utf-8?B?SEYyKzBBeVRSbzU1NUtIUGdxWEt2S3dYSWszVE9FK1RVOFljbThKdi9KZ01G?=
 =?utf-8?B?aXZzTFRBWWV6VzVvekFkL2NXbWZtTWVGd1JDWGxOM2JCZW01QlpDOXFWQzVJ?=
 =?utf-8?B?cGc4WmFtTDg4bW9kdEZCK2pOazlaOVZqR0x2K051TEFXaEYvajlwNTJINm52?=
 =?utf-8?B?Mjh5TlNQQSt5ejAvQVRCOFVSeU01MTBtMjJqaHR1a0pkYllkNm8xV0dEWXNY?=
 =?utf-8?B?Z2RmcVkzWFM1cUpwQ1hGZCtnUitRZUhPY2VvWjQvOXhqc0dqS1JaV3dLZ2V1?=
 =?utf-8?B?NHdNb3BUNk5sY0Q5ZjhCUVZiRnRNcFdsb2NNYnQ2ZXdtT3ZWMFAvQ21VdG5C?=
 =?utf-8?B?NnVrRHlUc2wzeHh1T25Iei9McWdGS2MzaytuSkZvMmJHVTFURzBqQkZrcGdN?=
 =?utf-8?B?YnVWWXdEZldYTTFHL09uUU1tMGxjWU1sVktFMXZFR2FvNjBjbkJmRDhaUTZn?=
 =?utf-8?B?UnJqL3pIZmJiZk5GYWJmRGNwK2VkNFZORFUrT293UTRyNTQ2UzVEa2orSjk3?=
 =?utf-8?B?NXFLZEJwK0dEemNuNTlRekREVDBxdFlvUmxJTm9zcHNYMm1JZ0lqeFZrVksy?=
 =?utf-8?B?VnptRVVFTmlKNHRQNFFacENVQU8zemh1ZkVKU2hZRk1RdmpIeHcrZTZXbWE1?=
 =?utf-8?B?ZUdjMldzTXo0UWgzOWpMY2xSQ2o5WmNrNXF1bXVlWWtkdkt5WkN5TjRhUWxy?=
 =?utf-8?B?YnlGcFpvcFI1cm1FbzlzYnN4cXJBNXMvWThLcUJBN0llQUkvckcxbDBKT25k?=
 =?utf-8?B?Yk0yWllLNEFrMlJwM2lndlJvdXVhRGN2K3JtZUFQK08wSWxMc1NHN3dZTzFa?=
 =?utf-8?B?bUQ4UFRWeUNYSXBMNXRkNDRSd2tnVUtZS0UxR2JFVElkZWowNjA2M1ZHYzc2?=
 =?utf-8?B?UzRjdlhYZVJPc21XSHI3UHRKWloxbDgyZnNRRWZQUHJNb1dNODRvcERtT0tU?=
 =?utf-8?B?cjZLSDNaSWNkU1MxSUlPM1lrWk9jei8vMlMwNjBCRk1IaTFqcTZzUXdTWHgz?=
 =?utf-8?B?UTQzMGhFZGlGbGNvbzJjS2ZKdmQ1SUZvQldmWS9sVGlPM0Flbmg4SG1FTE5B?=
 =?utf-8?B?L3JUS0o1MnkrUDFTV2NabUZWVTF2U1pDb3JyOUczZzBBVS96NklGbktBQURo?=
 =?utf-8?B?c0ZFdXZGcVIwT1VuQjZyeDZBdXNJVGt6ZHdxa2Y4Yy9lYjkvdFVhc2VlVkRv?=
 =?utf-8?B?V1Nlcng0WTFBTTJZQjRvUVN4RWw2VXBncjhjVXU5UjBPYjV6WnF1U1BzWGYw?=
 =?utf-8?B?L1N6TGtDNzdLMGJNNDJGangxdGxLTER2K2xVUmpML3Q4V0FsM2kzVE50enY2?=
 =?utf-8?B?S1FTZ2xhaTBFcXF6bEVZYzhLVUZmSnhKTEF4NGNOazkwRHNMZGtCVWhwRFZE?=
 =?utf-8?B?cjFCYWRWRGJzdXZWa21DZTBYcTBFSVRjRFFDRWYvTHAyK0EvdUdZOEsxRGdV?=
 =?utf-8?B?clQ1OXU0UFkzNlF2WHBWcm92SGg5My9nQzAwS2wxbzNhcWV2TVdwKy9mNk83?=
 =?utf-8?B?ZEF1NXJXN05DODA3NENFdWUyWnhFZWJ5ZkpYVE9Ramp3TnZTYUFLUTdYV05x?=
 =?utf-8?B?Ym42VjF5U004T2pZM0d2YWI4d1dxUGR3WGhsQk5ISndxczNneDlTNVkzTDdK?=
 =?utf-8?B?eTZyT1dudmNTTTVLcG8yRURLdHorb1RZa21neHNvZ0RrL2JmcjFldTc1dngw?=
 =?utf-8?B?dks3MXpORi83VGd1dEFhck5WdzhxLytQRlhxd0dqSlVIajVrckJsS3RWSHl0?=
 =?utf-8?B?aWxhOUhYemtOSjFQUGRxUW9DTGFiTkVFaFpuTmJTRU96Yk1LcjhtQ21IcFUr?=
 =?utf-8?B?ODRlZHlROUE2djhYWXRaUGdPSDNxOHhPOG1NSnF4eWlaZVplR1pka2NaVUVn?=
 =?utf-8?B?SXNIS1JtNTVZR2FRZEo3aGVWdnJ1dGdNZDlsS3pJd3daK29KZUNGcGEwNVpl?=
 =?utf-8?B?QUtVNFB2SkxFUStLUE8wbkhoSzRaRXZuSTJSUnlicm5ZK1FDenU4ZWx1a3BZ?=
 =?utf-8?B?SGV5d1E2dXprVXc2bUI3WlVmZUNOdk96NzJRdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VndnczBrVTJNUUVTODk3eS9XQ1c4Z2J1REsrSGR3OGtSSVlCU0FGd09RRzBk?=
 =?utf-8?B?eHIySlkvSUhNSy9FK0hLRzhxSVhqUFIvbzFJNDdxbWN1OUt2Rmw5MS8yTVcv?=
 =?utf-8?B?dXFMRUNHRVN4U3RrSTRiYmhzZUkxRDNBcFlJUzRlMExjZFhZZzFncWpuZ3FB?=
 =?utf-8?B?Vm4yc05YSG82SGk3T0ZDZ0ZncmtzUmlMQVpQeE9la0ZMNjVOR2EzS3FrbVFa?=
 =?utf-8?B?YXhTZnduaFJxaE9aK0tSMGFUKzZ2Z2FUbjJUdUM0S3cxSTJISTVZdWQxaGNy?=
 =?utf-8?B?aXdzRjBVSGJISlVzY001elRjeWpFM3N1L1Q1U0YySFhTSGRtczg0R0NtOS9G?=
 =?utf-8?B?NU50NzVhN3MvVU9oM29rcFdYWlVQRG1xS0lEeGplMjdGNENMbmRKQzZ2eGpH?=
 =?utf-8?B?QjVpWUdGYXNpNzE4UHJUTURXdFB5WTlMSUZsT05sY3BXUHNPa3l0R0R6amRt?=
 =?utf-8?B?TUp4UFZvT1RJc2UyYVprVzQweHAxcWxoRGcrY1pmSE5ZQ3h6M01IMHlNajVs?=
 =?utf-8?B?YWZxelNyYllROGxjYUN3ZnFnTkcwOWhEM3l5OUtJK3d0cGU4cC9NL0lVUVA0?=
 =?utf-8?B?MHlseXAyUVQ2Vi9iMncxWWM3SG1QWE5EODZKOWxpa2lmRHJudHQ5T3hpWUdW?=
 =?utf-8?B?dXBMUDBHdzEzdjZYRmpDbXZNWWhlSWc2UnYvdHh0eC9RZnoxM2EvRlNMOURX?=
 =?utf-8?B?YmVVaFBSZGZpaVZ4a3pVY1IzSElxdUhpaWpaVitONU1iTjJhWGEzeHlRWENT?=
 =?utf-8?B?T2w0bVgrSkxXNHhqSWVzV0hnMTlvN1N4MXpqYUw1R3draTR2bnoxU3pQYUZ5?=
 =?utf-8?B?dFU1VmJUbk1JWXBaakM3UzBkV2dreUU4eG4yZWxYeW80b0FuT3ZCWG1BRUky?=
 =?utf-8?B?cVJtREgwTnRESkxleDJleVJXZTBrbUFFQ0grN2pyRnhZRFlsM1c5OWxpQXlv?=
 =?utf-8?B?dkVqUjNHSEQzRHJlWkkzaUJTNWNUT3llNDlvWkJTeUdZeDhaUVlYRVlzY3lJ?=
 =?utf-8?B?eTc0UEJuN1puTzVjMXhnL1I2dTZyM2RGaTkxNFNjM1NFcWw3dDR1enpuS2RF?=
 =?utf-8?B?ZEJHaEo2MVdlTlBUOUxqandkeXNEVVlDeTA1UHFaVUE4RHF1cEZGTEI1cWdF?=
 =?utf-8?B?dFhPLzZWYXUrdjlMYkNHVWh2am45dzYzem9OL0dPRXYxS29SU0N4cVRTd1VK?=
 =?utf-8?B?eFB3VVlHWXcvRE9ZemNueUdJM211dTNaMzZCNnhwSEsvR01LMForMzFDa0hG?=
 =?utf-8?B?S3pXU0hmZDF1NjRkM1VDM3ZHcTVDaXFIbG1IbVFPbENQSDZtSTZUTy8rL1Q0?=
 =?utf-8?B?dHZrWHFyZjVvSmRXRDcyUWVsN2VZdmZ2VnhLQlBUdXROWmxBVGJFc012ZEpQ?=
 =?utf-8?B?ckRGeExTL3YvS1pvVDhLL2tGMzNqSUtqaVl4V2JrYmdjcDluMVlCUkh3Slky?=
 =?utf-8?B?ckhXVmFURE1Ea3p4K3NnTXBWdWF0WlJOWlBXc3IyV00rZHlNbm9ETHZ1UFJ1?=
 =?utf-8?B?cGtyek4xaFhxZlVyRmM3dldTSmhMbTJROUR1eFFWWFdYQndRMU5aaWxucnN5?=
 =?utf-8?B?TGJzSWpCM0NxTkgxSnZiZTFFZjBSaEFiaHlXTzBySElFbWQyalExVXVhZlB1?=
 =?utf-8?B?YWhKM0xQVTk4Wno1cmFQNThkbTRJbFl1VU4wM0FoQ0swSFRPNkZjL2cxMzRO?=
 =?utf-8?B?U1dobFdsUDJHSHBuSkFvK1VCMndyUmdiWVBhY1lmMWVydTdSREtXaWhQR1F0?=
 =?utf-8?B?ZWIrSDRyaEk3amtiMDY0QWQ0L0w2M3B0dUZ3Y3Y0WU1GRkYvR3ZtM1VaRUJV?=
 =?utf-8?B?MUIzTmJvTmkvQ25ucGdOcWNiVTBicjZ6OW12Sk4rK21wUWNRMDljeFZUeUps?=
 =?utf-8?B?K2kwcllnNDF6V3gwWFlsckdBc1VRd1I0RnhDbVNkeS9YWVRZQWthVHZpMzdE?=
 =?utf-8?B?RlA1N29MZERMaHRhbmNXbVhHSDJMQ0RRTlVadUNLUVNvL3JTMzd6Y0p4WXNU?=
 =?utf-8?B?djBpUUJJV1JHMUdBWmpVVUw1ck5qRkJreUlacUZUZDB0bVN6TEM4Y1dUSnR5?=
 =?utf-8?B?YXBEVC9qOENlcVJZTnQyZFIyMlF6ZCsvSlM2NWVZQ3hOZHhhK1dVSGdpTXJs?=
 =?utf-8?Q?WXvdPB/15mi/g792YdeicsNuW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7236451-3ae2-4e2f-66c4-08de1c8c2d6a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:55:51.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16UPMBAqZIL8b0I8XLLFc7j0mu8LqdZEVcUvg31r0vytG5m3vcf8A63Cg4UEbx1YV1cDLOBt42Rf70IDg2de4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8877

Add optional clock source enet1_ref_pad, which input from ENET ref pad.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx6q-clock.yaml  | 4 ++++
 Documentation/devicetree/bindings/clock/imx6ul-clock.yaml | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
index cd3c04c883df4ab02af29582369757df36269cb6..49475aec22a81ba87048eef588368261cbb38465 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
@@ -29,20 +29,24 @@ properties:
     const: 1
 
   clocks:
+    minItems: 4
     items:
       - description: 24m osc
       - description: 32k osc
       - description: ckih1 clock input
       - description: anaclk1 clock input
       - description: anaclk2 clock input
+      - description: clock input from enet1 ref pad
 
   clock-names:
+    minItems: 4
     items:
       - const: osc
       - const: ckil
       - const: ckih1
       - const: anaclk1
       - const: anaclk2
+      - const: enet1_ref_pad
 
   fsl,pmic-stby-poweroff:
     $ref: /schemas/types.yaml#/definitions/flag
diff --git a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
index d57e18a210cc1d8a836b50058613dfb0308fbf11..035002721a3b3b65fe67734e13b686b91539f328 100644
--- a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
@@ -29,18 +29,22 @@ properties:
     const: 1
 
   clocks:
+    minItems: 4
     items:
       - description: 32k osc
       - description: 24m osc
       - description: ipp_di0 clock input
       - description: ipp_di1 clock input
+      - description: clock input from enet1 ref pad
 
   clock-names:
+    minItems: 4
     items:
       - const: ckil
       - const: osc
       - const: ipp_di0
       - const: ipp_di1
+      - const: enet1_ref_pad
 
 required:
   - compatible

-- 
2.34.1


