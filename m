Return-Path: <linux-kernel+bounces-866100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92045BFEE08
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29BC04E3C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EA81F91C8;
	Thu, 23 Oct 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ktqiNRd3"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476E1E990E;
	Thu, 23 Oct 2025 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761184200; cv=fail; b=piQB7J8dg4+fd2edaa2niUjqZzyU3TwFrKO5n0A8fGuvkift0DCySm6T72g6h5ow68sFlRE8Qz49V9jNjPC+qu0gGiF9uLdCgntNAfAR2XV36O8YPBVDp7pYio74d05dtwTO6B+/R93fNZRVisYyCDXcEMRYIV1S/rnGNDhn/xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761184200; c=relaxed/simple;
	bh=sj78KOKS0ejisfL2A7GIJpQC8xpquR1cpyr1RRrQXFY=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=rmVgqbOZPVwyi+1byJr/SzXnUduVdVBiPOi05SZ6PduBnMXTxsBqkBv/XVMRIj0nNwXbWKQ8YcKIb49IWVoxVtRlrmwooowKdhxV5ZhxB1xlD+NdUcCEK5yWcyerDoitFJpDacsZ5hEY5EryFNXMuWCQyTOJ07cWOej2lTK0bOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ktqiNRd3; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTGk+EV51KeR/weySWumoW8jg+8//azywlgM1K9yg9nnmgbSwyigUTNN7BiBBZeUtpwTNZ5HyyU3XVXomCFC26N7OM3saeEX+R1MTea7eF39usfiCfSwyMqF1W+QOd5Rb6OJ09DRfKGMvOP3rzo6QNnNL05K2tTUQegsrYWyP+yo+f0ZJJQAFKcQwVvIS9fFKS3dwoIZ/cP5YTflv5P6psweDmqYWEJ4YMI9Xi6AfEqS4m3VZaepUmAIYBGMthv5AEU686tXNGdevCnWWsJTJytlyz0t6RxCX+J7XO9juBeH9/Z0GtsZ5HtJnq8LVI1AIvToAaGCKarcKGdHOVCmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0KljOmRK6K2PycMFUO6CaAaiM1MeBWfkyRl7jkmn3U=;
 b=ApA35weoaqgi0AfH6nUh1TfD31G7w2MyLJct3WXGXpi++J3eJQuqKfWexqWO5lnrVDU3G5e/ZUihIgA0ADZ8rJnZhTxfdVaT4hRfZLwyS7XJ/K6nhpx5fq29w2fPBgatPlZObhopl3HE5ZhUClKavJaICF4Sz9EUDwOrYZrlqruEwEx5J2hP4y9AiHoDGNlCYZbbUn6+pKwizMddv0daViPM8Jr6mpU1O0+wmnTnd4Zud2rUmRBuImuO0T/pZ4U4DCUIS7MvH9MFsV+frqo6+lx3VpUGnwc/SVgKvu9+kgpYNKEPqA92dDBVXVP/4jXtOxVbWI6qJ1BFH60A9Ot99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0KljOmRK6K2PycMFUO6CaAaiM1MeBWfkyRl7jkmn3U=;
 b=ktqiNRd3wnAQtvzfEDOfEsXNH03Nw1FoKS97t58a7gD65T+Snprb4rB3XyFnpoVs0mTueehflyl6uI/jlT2v7TKgdCCX+VCdkzw9Ap3M1BoJaJyONWXnpgRcNDPWuC1TxFMKF/8Q2rSTYsLVmQcw3NNvor8s8UqVwN9+Q7AFG862xLyQ7sHiMrUr2Psn1fWS5N+K9DVO7Gq+59uYzpRxw245dGgv4TpCUZgZtdxtzfIdqvj52Ct1+2LaEPEjTwpyVsUOeVqInP/B/uKY/o12VGLt/rEqb0FMREhGYWhMqfXc8PeRd5LjD4hfR/ZLaxLFnhFfGb9nJlovP+VZDhfo1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7473.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 01:49:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 01:49:54 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 23 Oct 2025 09:49:32 +0800
Subject: [PATCH] clk: imx: imx8mp-audiomix: Use the auxiliary device
 creation helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-auxiliary-v1-1-0a16fa4c3cdd@nxp.com>
X-B4-Tracking: v=1; b=H4sIAKuJ+WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNj3cTSisyczMSiSl1jS0uLpOTUFMvkJEsloPqCotS0zAqwWdGxtbU
 A1rdgTlsAAAA=
X-Change-ID: 20251023-auxiliary-3998bced9cb9
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>, 
 linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761184184; l=2096;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=sj78KOKS0ejisfL2A7GIJpQC8xpquR1cpyr1RRrQXFY=;
 b=1h2tWRLdWgGJiz7eSgh1jYYKowfLTX3UEl/6/taRmGc7jMIhKrJ+9V1K0gK76xKrNUQpE9BdL
 eK4ouHyaafQA+8v/0FRUYF9GUFjQfRBrqs4AJlXs37wDv8doYZc7iX+
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ef6727-abb0-4884-bfda-08de11d6765b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVR3ZEd3dHlXTWp3Rm9zV0lFMktSYXBsaktKRGtPUHRGcWtzZ0t5Q2RvYW9B?=
 =?utf-8?B?dUNYbk42YlM4VjVYajFoTkZnR2ttd09qOXE0RDBMNUM3bTU1VGIzR1FNSUdu?=
 =?utf-8?B?eXV0WWtDbCtmYUEwUHQxVjJWNk1JbEZaQys4Mm9yZ2FNd0llZkNCcThEeTgz?=
 =?utf-8?B?TG1lRlJjdyszRDFRYUxEMjNpRVNCTTNLZXZROVZQbEFQelpXaWpaYmR0M3dB?=
 =?utf-8?B?NUF1MlJ0YllPb0xaRG5ySlJ3OENPV1VHZ1dDbnBjcTR3QjVGVXAvSDhCdnZZ?=
 =?utf-8?B?Z3czUEYzbGZUb3hWdXErRUpJNjcvVHE1YWJ2QzlqS2tWVmFMRjJuY3I5S0ts?=
 =?utf-8?B?eDNmaVpHbCtZTmlMckFiZysveEZ6YU11dldhN2hiTnFUU1cxZE5CZ1YvT2lk?=
 =?utf-8?B?MjFFOUtUWkxPZWxZbmoyVzcvWWM0dzJXL05ZeUlTYXBHTGZ5RHBaWktIZy9M?=
 =?utf-8?B?UXArSkpVNUJocDFpN1BMTm0rVE1wbWkyY0Z3YkwzQ29FTEZ4bGZKWVI1ZjFk?=
 =?utf-8?B?UzFWRko4V2U0d0M2Z0JxMytjQ3VxTGdpSWo1aUd1QmRCa2hDcXBJZnQ4Ry9E?=
 =?utf-8?B?SzU5aVF4VkVON0RJK1lUYTB6UTB3ZXcrNG8zenZzY2hjR2xKWjBOMXQ3OTln?=
 =?utf-8?B?bHlpTWVaVTJ5OGsxOUM4MmNJVjliaUM5ZUdtT1dhOHRBVWdIellvRkRTVmM1?=
 =?utf-8?B?R2F2T0MvN3c3RndOSU1LbDJPdk4rS3BTOTBsakhzNnhsNzIyTVRpQ2h4V1Bt?=
 =?utf-8?B?azVDd09HdnkzWmx6U0U5RUhrc0FTS05Udm1xZ2FOL0RHWWpueUhtYXF6SEVX?=
 =?utf-8?B?SmdIRHRDTFhNa0E3dXZMV3d0Z2sxMFh5cUtIVmR4WVN2NkdvaExJaGVFUE43?=
 =?utf-8?B?R3gwa3JWY29xWGNSOXZOdE1pQVB3VXBvTW9Sb0hxcDBVVzNKblhlRzB3UE14?=
 =?utf-8?B?TTZVT1FSSEc3NnpYVElYWCttWTA2OTFKQXFaN1dIdWtEa2sxYVV2OXc3SDZZ?=
 =?utf-8?B?Um5qM1MvazlObWRtY05rUkV5dm5NOTdPeFd2MlkyK3d5Y3NaanlyY0RVQUVQ?=
 =?utf-8?B?OFIwcWRGT2N6UWh5Tm5CUVQvYmxva2p6T2RFZmlhQ1VJSE0vbFB1VEVEYWxi?=
 =?utf-8?B?d25CcjNDNmdnV1FnaFRBNUdOM2RXVlR6SmVTTVF5eWk3RDVzeCszeWpnSW1H?=
 =?utf-8?B?ak1oVTZGZWRnb0RPeHFnbWMxTkNhK2IzNkpvV0lBUUZrdWJBVFlwU01hcC94?=
 =?utf-8?B?RWd0U3VwcEZ1d1VIRUU5eFhWZnF5VGs5QllLSiszdUk4MW5XWmpPcjhuWEFQ?=
 =?utf-8?B?V1J1YVpJYk4yNzNlcjR3amZ5Q0pOMG5yZk5kSjc2RzJtTmZSQ2VqOVFneWpv?=
 =?utf-8?B?QUFwRkFodTlHWDh4ajU0TWNtVE84eXoyaWxvYmpnVGxVTmpDZGFRa1U3NGtt?=
 =?utf-8?B?L3c0UFBIb0d6bWVBbURYSmFOKzFKRCtFL0h0ZHhDa0d0WUtOSzgrU3l0cUNw?=
 =?utf-8?B?b2R3bjN6WFlGQUJ1czl2OFRFZTlYT2VjSFVtQU1EZk1uOEN1MlozK3hsT0Zo?=
 =?utf-8?B?eWdKbEhYNEJ3Ty9JRVFTSnhnNStpSWVlR1FTMlhYMVBacHU1UFRRSnhZSlZS?=
 =?utf-8?B?TVl1SlpKUm1CdXFBVGdHYXlpYUFpdUd5ZS9kQkxDaHhvb1hJWXIxa1VSc0U5?=
 =?utf-8?B?Y3BmR2hkZzFqVmt6V2xGTDVkeWM5QkJNSVByUWR6WmEyaWNrbEE5aTdVcTRy?=
 =?utf-8?B?bkJmMXJRQ0JxWDVRTGFKZy8yblhONURrcXM4eWJhN0hUNkF4cE8xZkVTTE5a?=
 =?utf-8?B?WFUxeEZGeXIxTHRQWld1eWtYNTJYVGcxQnhkSWp0cmpSV0NQUEM5ZzRtV1kw?=
 =?utf-8?B?bENVVmRQTG9TbHpHWnUrOUp1emwzSGFCdnlNN0o4UGNySjR1RzUvWVpSd29y?=
 =?utf-8?B?dXJFTG0xKzF6SEZyR1hrcVVPNkx4VE9ONDBrUE9BMExSK2NLQzhUREY2a3Q4?=
 =?utf-8?B?QnU5cjBDaDM2KzFRNjVQTkorR1p1amN6aXhQcDRVZWlQN2kxcmVGLzdNU0tT?=
 =?utf-8?Q?yINDgm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1VrYXlJUldaRjhUN2ZGVWtlaEZvY2hrcENRTWpqSC9ZekdmWUNveFcxMUFN?=
 =?utf-8?B?dVdsUHRkcWVUMU9SaVRjTHZ1YnJLMW5lQXhBbUF3VTlBcTVTNjdMOUcyYmFi?=
 =?utf-8?B?QTVjSmhHdndpbW5BK043YUhiU3Nuc2FhejM1ZExETlRoRXdVMHdRZmxOb1hS?=
 =?utf-8?B?ZTZQaW1MK3ozZGlVMWFXajJBWFNOSUdWazVROTA1ZEh2OEVjYlBGelF3ZWJj?=
 =?utf-8?B?M3J6bHZQY3c0dStJenE5NDZVQXlBK2RIdFlUUTF2MHN4RHRsR2pXK01jRDR1?=
 =?utf-8?B?eURCaWNTL2pNQlltaGZDTncyMXRBYlQ0WWRWRFlxNUpvRnI1MkkyR3Y1QUFq?=
 =?utf-8?B?Y2pMditvT05qdElmcGdrdXQvY1NkUjRLOC9meEs0UFhjNUJ6Z0dmV2UrZDl2?=
 =?utf-8?B?SkF1QkxQSEJJekw2d3hEN2w0QnF4VW9mYmZxOVVzdmx3Tk5RMlllaEpPMUpB?=
 =?utf-8?B?TmQ1QnlIRWZvNVV4UjM0Y1VhNHlYLzR0eGR3TVNKdjErempTb2Myem54RWVD?=
 =?utf-8?B?R3dDWks2OGp5U1p6aDkxQUdZek96Y004M0xnd3paa2d1NDBNRTdRKzcxY3Ix?=
 =?utf-8?B?YzhLUEUralBOY1lpQmVpS3pkaHN6OTJ1RnlYUHRmRWI4cFhyQ1BnZEFDeFBi?=
 =?utf-8?B?Z2Q2aWRpVTgwS3dEVGRyR2FGS0RLTWpZcXBVb2hWUWlCdHd3VFhDbzlTdytn?=
 =?utf-8?B?ZW96QkxuenhkTWVSMHlzN0tXd0JIUU5PVnQ2b3plcHBGNmZhRStaR2RYYUZV?=
 =?utf-8?B?bFRtRWw1NWNLcmttclVxRm8xM1MyS0hMTjlSYk03VkxmR28zbWVyZEdReExH?=
 =?utf-8?B?TnYzeU83QTgrQkVLcTBZbHpMZjdzaFlVeXQ1L2ZLU3BHcWdES09salJwckcz?=
 =?utf-8?B?eXh5S2lWT1pZVGZnOWJGZkp0a1NzN1VXMnFhMi9MelhVSzYzWFdzNmhFbGhM?=
 =?utf-8?B?TlhQRWJVaHJTeTl4RFQyaTZWYzR3Y3QxWWhVUGZ5TTdhUGNBMTlpZXVRcmJq?=
 =?utf-8?B?NTNMWlgzZWg4V1JPMThBd1ZzMVhqc1Z5djZyMlpORmNqM1ZsTzZEdlV2eEVV?=
 =?utf-8?B?VnBWdmw1dFB5dHloT3I5cVhudnBiSWVIL3R4bmpMTHp4QURkZ2JDdUdHZlBV?=
 =?utf-8?B?VXN4M0VzczVFTmtPR1lXK1hIa3FoZkIyeWhhcmc3UDZHQjhCZUhBRUhlTG5D?=
 =?utf-8?B?M0lqNFEvYVBsTFVUV1JqRG1GOW1zS0gvWkZZK2RXblVsSHpmSHNmN2o2UWVY?=
 =?utf-8?B?Y0RBVnYvVkJLV29PZXlOVFNsY3RVSUIxSjAvdkRhMmlhMnRtZXA2VkxDa0t0?=
 =?utf-8?B?V1lXdWRDUHlLVUdaTGxoMktJbnlYWHhtZVY1eXB5c3ZkKzRJR0svWUVjZ29h?=
 =?utf-8?B?WDZ1M1RueEZMTzZxOHBjOGdJbVpTM0ZRcXhWa0pGc2srclg4SkNnOHZEM1hq?=
 =?utf-8?B?OUdITnhlVithWndUYXhqUzdQNi8waGpOYU1nQVBDVlpPSUl6MjRmejRYWVV4?=
 =?utf-8?B?eFJXaHFtcVY2SXlLb2YwaS9RRllHRlhxYUxrZ1NWNmdzSTVCT0QrSTZpWDRK?=
 =?utf-8?B?V0Z2YzVjRFQrTDJTb243TmoyM3Jyd0lQcGk5ZkNBaEtiUm5DemNIQWt1NXU0?=
 =?utf-8?B?dlN1RGp2OXVpWHV2ZVZxcmVCZzlNNUFkRnVjSUc2RkgzVTR3akIzZzd5d2Vv?=
 =?utf-8?B?bzBOZTlCczVCc1Z2QUpFRy9qWW0zT0lBZVg5TFpuTW9HaldvRTJKZ1ljWktl?=
 =?utf-8?B?dXhrd2YzZU10aFJFbEh2UGY3aFMybm5RMXdKbWVqVng4cXVXYmw3YnAvMWpi?=
 =?utf-8?B?MEJ6bHRDT2xMbm9taWNBTUpxWkdGYTZnQS9wZHYrSjkzQTV2RFpocE1VNXBG?=
 =?utf-8?B?dTZrNlQ5clkvYWlUOW9hNTBqNXZ4M2VXdXJYQzd1RW5SS242eENjdkRoVXRo?=
 =?utf-8?B?Yldhckc0ajlBYUY0bkhHcVQ1OWJCVFZkb0RhTWpNcU01Z0llYjlobzFESWN0?=
 =?utf-8?B?YWEwaDdJcnhxdVhNN3NRMTlqOUFhVDZqc0ZsQkxieE00RzMyZ2g0b1o0RHM1?=
 =?utf-8?B?d2o2OVBWTUV2OTZYSWltcmtmODk2MnhjRXhnU1NPTDQza1RLTHNEUysrbmh1?=
 =?utf-8?Q?z+H+vppHTV7wGkt9PhG08daKp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ef6727-abb0-4884-bfda-08de11d6765b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 01:49:54.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Khpmxxt2jtGFN7xBHtz9kwuiL6vG7fx4iQ2MbRgXZEcl977fKxu2tmx8Xo0ZYZGSzgFohXU5Yg65ZbrXLsFa0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7473

Use the auxiliary device creation helper to remove some boilerplate code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 39 ++++-------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index 775f62dddb11d8cfd17a4ebf7a677ef399c5e617..131702f2c9ecfd693af47094fe61b486ae6e8f6d 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -230,50 +230,19 @@ struct clk_imx8mp_audiomix_priv {
 
 #if IS_ENABLED(CONFIG_RESET_CONTROLLER)
 
-static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
-{
-	struct auxiliary_device *adev = _adev;
-
-	auxiliary_device_delete(adev);
-	auxiliary_device_uninit(adev);
-}
-
-static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
-{
-	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-
-	kfree(adev);
-}
-
 static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
 							 struct clk_imx8mp_audiomix_priv *priv)
 {
-	struct auxiliary_device *adev __free(kfree) = NULL;
-	int ret;
+	struct auxiliary_device *adev;
 
 	if (!of_property_present(dev->of_node, "#reset-cells"))
 		return 0;
 
-	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	adev = devm_auxiliary_device_create(dev, "reset", NULL);
 	if (!adev)
-		return -ENOMEM;
-
-	adev->name = "reset";
-	adev->dev.parent = dev;
-	adev->dev.release = clk_imx8mp_audiomix_reset_adev_release;
-
-	ret = auxiliary_device_init(adev);
-	if (ret)
-		return ret;
+		return -ENODEV;
 
-	ret = auxiliary_device_add(adev);
-	if (ret) {
-		auxiliary_device_uninit(adev);
-		return ret;
-	}
-
-	return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_unregister_adev,
-					no_free_ptr(adev));
+	return 0;
 }
 
 #else /* !CONFIG_RESET_CONTROLLER */

---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251023-auxiliary-3998bced9cb9

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


