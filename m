Return-Path: <linux-kernel+bounces-874651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F15C16CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014C81A61325
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F135029F;
	Tue, 28 Oct 2025 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZnVjmFAB"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1C34DCD9;
	Tue, 28 Oct 2025 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683470; cv=fail; b=d2ZPsKz+35kHOouTFfIbKJ4xXaXouOs/Jeiopz6s85VU7HTiGOVLY73Y7qgLqqI+fnR0IVFTY6+0AF4jxAovnhdz/UgiPY5epA4jeNkKto2zwuJHD5yj9LaElwYhcHov3H7EDUIMRXowUoqipQbtnalHJzf/EV+JQDg80s2My74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683470; c=relaxed/simple;
	bh=5jNhmEK6dGjiFsgJlS/TJQDgBrbYqiMg3pm4S7hhJ6Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hvpNWAi4uqLDgOqZ31Jpe5ddMEm+xtQTybBjlvFtOM1LRV5yfGbKG2T72LLbcEqZ+TL+kPn1HZTeDUn8jIBTwi9/d5Kp0Dcnum2j0AWd3AiKDueNtmjiITZar8ZdTMGwcRGNXkfZEPHWSSIby3NHKAdQgs0koUt3sbANUO8GDBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZnVjmFAB; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fphIT6fd+gt5zhc+Gwti5e8BdKT3ZlSL8+IyY0jluYyPzprggT3esVHGbLc8UU7Mt3Q5ANLMlhPXuIY63lgTbas/yV4gcviu0ZXUFrLWUWR3lr2jKGsUExUPn+xIXVl076tzqMTryslCdL45+v76/uBtYMhLnJFtFsbyUYuCtAHD++IOQYiUMLetsREnhe446XX71cj1jsq9J7WIn6sZCsBR2KF1IJgKzCIz2evAnzhMPGFY9Fi8knABSJnkGISpH0QILYAmffBwMTcNeXK3tiN2lFjte7I2Q/x9K2wwV8FFcLTbuz2VmC1xyXUkRLMEYdMe/3Tp5k5TmDbtPJgTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeCCiezoPOsRsE4ZnpktWCpq/UgctbxL/aJ2Spr/NgQ=;
 b=OCKV4BfRZmc9RNptoVLWFBXtc9JCtdnqvIzXjxW+mcfYxLnqJM93Z/ReyjOf0jGxp/t23DWc2ckbX2a5qxOCTdXUO8N1DD0wkUjAZQGMW7aVDoCQb64YowqSWAQb+tBW13/Rcj44LvpCXkgpiTY22J9yPJaYl1oElTdRdY6iPgeCQ/qIJTKS3Th9GGRD5oCrr/8JMD6C+7noh/aNQm2vz/qL5bUudgXkmuZkEEdJ/SmuDpiAxN7kD37WhuL/oMmIbt/5526YALhJYKufI2z53Vis/1y51DM30usdDKlot5mQNWhEO3ETa9agGvqS70TKCNWU7XMP5NkFaq/lFbTZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeCCiezoPOsRsE4ZnpktWCpq/UgctbxL/aJ2Spr/NgQ=;
 b=ZnVjmFAB/h3waYOeFdUW3PHrFFvKJwTF/m0OErfnF/nLPEsCRjr29OXL/cLyvOaK+sG4pt+Uod6ahPatoPaPzaz+2uHwuAA0Xp9ta6l52gmX9kcLB9++r7mcFRuwm0ykHMAle4FUCnhHIn8yDDu/oGBAaCPHQutDzDWGiUbvdtG3mVvDQhDkDiEjyTtWJWwqAJZorLtRu+v/3DwKxKfhfbM7oKEubWwvNAXDHGSDd8KYur8gyREaZGrBhxoAuTqEkkxqaGw/fakBCIv96UAMWUgbitUPYcIV5hJ5QeTE8OP5N0kGzlWc4eL4Jxq4g0/LG7s2WjhNHK9GE0Ln+0Sm3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 20:31:05 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 20:31:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 16:30:44 -0400
Subject: [PATCH 3/8] arm64: dts: imx8qm-mek: add lpuart1 and bluetooth node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4_qm_dts-v1-3-51ba94389c1f@nxp.com>
References: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
In-Reply-To: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761683454; l=1274;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5jNhmEK6dGjiFsgJlS/TJQDgBrbYqiMg3pm4S7hhJ6Y=;
 b=oLvbAydFWdPnBN8TKa8UB9iJU4OyqG6GJCAlonAOei9/U2qhXaHgx23slqdCmynYcmdfAC6C4
 965Hpsc1cBgDMrZFeM46oDXb6pMb2skLBwEUM1nAPpPoYCZH0np3/67
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:e::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c8a249-14c7-4c1c-11ec-08de1660eb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVE2RzFqdUlXMXV2b1htVi9sWEdBWS9JT3d5c3NUbk9ZSWVrSWx5dzdTTE1M?=
 =?utf-8?B?aHhiT3Y4d2lNZVcrWVFaS0paMXRjMStjWG84YUlxRUJDTVpHNllCeVlhc2pu?=
 =?utf-8?B?ZFM1OVZvSVhGYVZkUWxSZHE1UllIYzFObGkzN3pSYWh5c01RdGlJTzBJelBz?=
 =?utf-8?B?QXB6MFZOSVlaTmYvWUYxQ25ORGZmR05oRmpmdElNMXp6YTNtQ25GUWtNaWp5?=
 =?utf-8?B?dkkrQjZZaTVPcmhsUHRYM2JmcENPREJGZG1tSFhubXRzNnlkcFdRaHhINGlX?=
 =?utf-8?B?ajZLNVVITE5jU0dubEFkcGF4aHhXc1RBczBNZlZrNzlXZVBDbm1ZTWtKcTc0?=
 =?utf-8?B?Sm5kaHFVSEEva3VkMWgyN0VVbjV1ckV6bXl2Ung3blNZMjdodG4xOTY4Ykp1?=
 =?utf-8?B?YjFUWHlMTnM4eExyYVU3dmN2THBOZ0ZPNHIvTEFMdFlPRlZLM3hFdU9ISmtL?=
 =?utf-8?B?UzRaVWZWWCttZGtKOFBrZ1UxcjlFa2t6ZHhXNnRuRkFWNFZiNnNFcFlaY0JH?=
 =?utf-8?B?cXlVcm51OE54UnV4UUhGb1lkSUhoRVNzcUlrZXVSWXhvL3o3MDIwNVNBaXZS?=
 =?utf-8?B?Ny9aY05xeWJ5eWhUQ0xndGgwUU9GRm5hQnJiUzQxdFRLRXg3ZUJaV0lVb0dq?=
 =?utf-8?B?WjZrcVc5NTh5V1g3VVA2UG1Hbi9nN2dMWlRHejh4N0p2TGI5Wm14dDVJVFRw?=
 =?utf-8?B?cmozTlB2Ymo0aG5BdnF2TjhKZnhmY2VHS2l2dVNkcmxjN2hVaU1qUDQxQk0r?=
 =?utf-8?B?bG9GS2YvUW1XQWwwV1NWMmZ3aTJJdzVWakdYMjRISzdaeEJ6c3BOU1greTh0?=
 =?utf-8?B?SGs0aXNwOU9kaDZRZUVrekFnYjdZdmVpZ3BTd3VQMCttM2NTSHlVSWJreUlT?=
 =?utf-8?B?OEFobU1xZnpaNEtDdEhQcUZIYnY0bUpVWmwxaWZOZnYyNkNkbXlYaExoS3pr?=
 =?utf-8?B?U0VoWXFUV1prRHBsSGVaTXU0Q3g0aE41YkdldzNLamVMcjhjbkFmNlBsaTJW?=
 =?utf-8?B?cllZcDJlY1Z2cmpCRC9UNlVLRndFMk9jL0xZSTR1ODZxK0g0RWpRVHBJZjJt?=
 =?utf-8?B?T2JTT2dCMFN4NUdFdk82YVI5Z1h5Ty9Fdy9PV3lXN3JHZTYvdHNsaE5Ic04y?=
 =?utf-8?B?SU5ONVNOa2F2MStaUEp1OGE4NjlhNkxaNXVLOSt3dTFKSS94L28yNENmRFFn?=
 =?utf-8?B?SFFKVEZ3QU9oNWJDMzJ4MlpUUjd5YmdBWUxVOUsyME9YODQ4TVFJa1Z3M2pU?=
 =?utf-8?B?MlV0WXBBYjlzY1lWbkJUQys5dUFaNUtuVEl3eSt1Uk9lZGRDMVQxQXlZK3BC?=
 =?utf-8?B?TjJVUXNiTVIyNTZyZGFHOUJxL2prNVM4cFpyb3QzWlVLOE1OaHB5ZzlLTENB?=
 =?utf-8?B?cnFvZFExVDFPYmZVcmpnUlYrWHlyd1A1Vy9TV1E0Nit0MG1sTGR1YzB4YVBQ?=
 =?utf-8?B?cmkyTGFFSEh4UVlUSS9PazIwc3pGVHhVTzJMQWRPd25CS2UzSmNhT2djQm9W?=
 =?utf-8?B?YjNyUEZaSzdSL1B0VEJBWXo2RVRlVUhUMTNJTCtBSktybHNHVExRMVF0cGhh?=
 =?utf-8?B?azZyNUJRQkh4VThWYlBFZmttclIvT2ZaMWszajMraG94OVg5SlhTT0kvUHBt?=
 =?utf-8?B?a2pRL0ZRV0tEcUNOSVVVSmJSMGJoUlE0L2U3em9FajVheXVZenQ3Tis4SWtU?=
 =?utf-8?B?Nis0TUxvWTQreGJZaVVGRzdYMlVWV0xpUEJOZkhtSGkzd1VRZFRRVmR5UTQ4?=
 =?utf-8?B?aWJZZEpkZXo5dHY0Y211UlJBK1lvMGN5SFVlWjN6cjYxcGpGWUtiVU5nT1Yv?=
 =?utf-8?B?WWQwVkxoOXBJd0o5UlFvdWtYaFU2M0tLTHVjTW1Pa09WM1hrekdxaWR1K1Fp?=
 =?utf-8?B?cjZjZ2J4cm5HK0o2MTJCOGdTZFJVMkdXK1E4Yy9mOGdONDFQdnhLNlBDQms4?=
 =?utf-8?B?YTNwc0tkUDY0WWFpVzNOb1Z6UVg5ZnB0cUJrNS81ODFvS2RzMC9HL1lZVFNV?=
 =?utf-8?B?ekpvM3hFUVBFeWhUYUEzNUo0ek9XQmM4c3pUWEhlZ0pVN2FvRkROQzhTZ0d1?=
 =?utf-8?Q?H+6ABm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0RVYUpMZ2E0M0xJb0w4bWNKNGRCRSs0RElOWVlEb0MxbDNvSmNuZS82QUd6?=
 =?utf-8?B?NnhPQmQ5LzNsUGh4Y1dWQVNMYlIrTmJMUEpmVzFnYSttUVkxTXQ4VmNxRjVK?=
 =?utf-8?B?VWhNeHlnc2w4b1lOcTd6dHB0anYzNnRackF2eVdWN2luMTI2bUhCMXowV3ZH?=
 =?utf-8?B?TENLb2xhT204aGZGZkt6V3JaUmJEd01ieTcyekpWU3ZYY2FXRFU5bk9BazlJ?=
 =?utf-8?B?bUV5ekVVWW5VSHJRVUMzcmsvbmFMOG9aWE5uOTNUNldYSXg1SVVPbFRLTTRQ?=
 =?utf-8?B?RVhmWnJQaWJxNlVMS3JuZ3BRYlZpL05pS1V6SXU2aFZqWXlNalljcFhEcE5y?=
 =?utf-8?B?bXdDS0tPejNGa0NCdWJ6Z0V5MC9SWHFOclpYbUtyV2VDb1c4RTU3SldFRUY3?=
 =?utf-8?B?ZHI1UXAzTlZvSjZZNDhxRTJqR3FOeXU0QTlVSCtFNEJrV3NvUWhQOHd5ekND?=
 =?utf-8?B?OHMza28vTWJGYjRuZHl5NFNJMVRrTUJ5bFNUUk01ckp5c0VzV2dPaTFhY0Fn?=
 =?utf-8?B?bmRIakE2aVorQ2c1eW1PUnFvMFNHSG9Sdzg0L0lkbHlxUTlab0FheWY0VUlN?=
 =?utf-8?B?ZHFLRU04V2p3bkJGRlVXbCtkbnBCdDdWMUFvbXZFMkR4ZDZHQVpEaW5SRXdF?=
 =?utf-8?B?ekpLeWwxOVhxNzV2SDRTUWkxd3NPMFpRU21CNVR5aGNwUDByZUl3d24yNjZX?=
 =?utf-8?B?YjFKSGN1VjhoaDZ5cmkvalhYTjFUS2dGYUVsWThEU2EydVZUVjk2M2JiN3lX?=
 =?utf-8?B?ZTlsNFZyOUVYUXA0WTdLQlFnRXNIdXNKWGU4WjZrOTFucnlVTjczb2dPM2xG?=
 =?utf-8?B?Y21JNXhHdnVHb1lNZ0pnYW9oTXRXN1ZrVGdQWXdDZGdqcDF6OHB5MTIwZG5W?=
 =?utf-8?B?YmxZOTgwbG1JRk1FUHV2U1pIdnFyYmVaMnlrb056VUxFUFg4dm51ditLUG9x?=
 =?utf-8?B?WUJ4aG12eFZMd0pKS0RUTFB6MVdrTHRhMEtZdEJjRVk3azRtaVUvQVZRRFgw?=
 =?utf-8?B?eGFBd0t2cWZpM3FpN3RpM0NuRGNGWXVFU0NnVDR4a3JUZWtFMUl5N2VPTHNn?=
 =?utf-8?B?dWZ2dEd0UkJwY0ZlOUFyYktXWFpZU1hKTlRiRWpGTlFRcmdWVDNUYWNXT1BL?=
 =?utf-8?B?bWJ1d0JybzdtRjZBWlRGUWNXOGFrZy85Y1luR1JsY09OZHAzUC9WdVl0ZzJm?=
 =?utf-8?B?aTlzT2F5VGE2c0FueHoxVDJHNUdaNDU2L2V3d2gvRjNJeGlueVk2RFp4V1J2?=
 =?utf-8?B?dnNvc2NTalBTSWpTRjZMN0dYZ24yaktzM3pVenZyM0tCaEFzZ3Rad1QxSVhq?=
 =?utf-8?B?clBWdjJIY05pT0ZyYzV2bVE3Q01vMVMrcSs1SFRXbDZ3Q2ZPV0hURk10V1oy?=
 =?utf-8?B?c0NQQ2dGQmUrUnJxVytoSldnRXlsOEwyd3RWcXdMOWo4WjQxZ1hyaWRTdzBH?=
 =?utf-8?B?Unl2WUU4dlM2WENIWU9TTTZKSGdMd1Y2VytjUFV5aEV2a05mRTRYeVcxMmpu?=
 =?utf-8?B?MzNQaDN0QkhucDBOVVdvaDhEKzlTQ3lvV25OYThjMmo0UlZRZElQMzl2WFZW?=
 =?utf-8?B?dWtBTmtwNDNxWlhCdi9OSWQwanppdjdyWHFZYVIzeVBVWTFoQ3lJdWh3N0Nl?=
 =?utf-8?B?WnRMM1p4MjBFL2lTaU5qN0tTaGFBdU1ETHdhNjNhelhKNWZybjM2VXRESEVa?=
 =?utf-8?B?ZFhyeWVaTTM3QUx2WE9QbGNyb0tIRGN4RWVBTmdMbGxkUFZoS25EbUJWMlVa?=
 =?utf-8?B?QlhmSEZIZ0QvWDlRNmdSU3h0aXVneVB1ZGNkY05WV3Z1OXhRYUZrTVBIcWJF?=
 =?utf-8?B?UVEwRmYrc2IyM25GZW9ER3A5TklQMFpxa09kWUh3cDF3b2lUa01rLzdzbzJi?=
 =?utf-8?B?OFBIWmwzMVF2Skw0R1Jzem1uVk8za3dPZkNnV0ozcjNWcURBMXRxbnVRLzZ5?=
 =?utf-8?B?WFhaUm8rLzFsN3MyNjZXcStaeG5nYmFnK2M1TngxMlhLVGp5bjEzazd5QVhs?=
 =?utf-8?B?SjI4eXJXQUl0Yk15cURHNWwreTV0T1NVcjB0VFlMb0VJd1VZQ1czdGJ5bjZE?=
 =?utf-8?B?SE1JbEk3ZG53dDlSQ3JQTHA1NENQRUUvd3dmMitZQnVJMk8vWkpjZjRWWldI?=
 =?utf-8?Q?vAkA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c8a249-14c7-4c1c-11ec-08de1660eb2f
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:31:05.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfV1jHJ6kbrVkDvmmlSv7Cfw1XsAcfHyzX6dSw0YlfcH7t7DQMSiYpB474RICQo0CVKIfFjVTngMtAjyqzqxFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

Add lpuart1 and bluetooth support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 44b8e9c75c59aa31cf9dd04c3d03be047ef82ff9..a88e8600999adf53e66785e608c6231bee53b162 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -686,6 +686,16 @@ &lpuart0 {
 	status = "okay";
 };
 
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart1>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
 &lpuart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart2>;
@@ -1098,6 +1108,15 @@ IMX8QM_UART0_TX_DMA_UART0_TX				0x06000020
 		>;
 	};
 
+	pinctrl_lpuart1: lpuart1grp {
+		fsl,pins = <
+			IMX8QM_UART1_RX_DMA_UART1_RX				0x06000020
+			IMX8QM_UART1_TX_DMA_UART1_TX				0x06000020
+			IMX8QM_UART1_CTS_B_DMA_UART1_CTS_B			0x06000020
+			IMX8QM_UART1_RTS_B_DMA_UART1_RTS_B			0x06000020
+		>;
+	};
+
 	pinctrl_lpuart2: lpuart2grp {
 		fsl,pins = <
 			IMX8QM_UART0_RTS_B_DMA_UART2_RX				0x06000020

-- 
2.34.1


