Return-Path: <linux-kernel+bounces-865867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6DCBFE355
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B38F4FD240
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63D02FF150;
	Wed, 22 Oct 2025 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GpYH2dCI"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642422FD671;
	Wed, 22 Oct 2025 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165825; cv=fail; b=i+giV8raLsODV8+vQvX1xZW9PNF6OsJ+UW5BqXGFnynUemME8usQLkNclS7Tc26IwIwD57ZSxOdd/52paF2umlAqB/xoNFCMsRqYNYALruWttII1nfTr9FkAHDEJ8XROChqTWBnAbv+78SPr9JKubUuuq7VzhM1A+6l7HfPsa7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165825; c=relaxed/simple;
	bh=BNGjdCnLRJz68xw9ZRO2bXEBvhKZ8+gxhb0scPIHnwA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FqbuSjptEDTdZ6V5Kww/l5P8sW0NBIXhp+Xe1RQzAqj0n1SUyEeXcK+jfo067IwIPNUG3Lns6wODTisD4HCM5ayBpkgBGWjWuO/2f3zM6cR8/ManVdMEWDQzs4NqF9AwujxdM10C6j3vppBcYk0e+uNsEr3v+YOhzluR9TvDhoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GpYH2dCI; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOVBoL8t0XzH3Ny1RE3VyoHfv9xyN53wDQ9Jc3niNjPcjlsaGBGvxv4nBEW/3yzyUmnXbM6Dm+5PYvCU+4nBHEJGv/JgX1pGqQe2IXnQHtkmVzNm2S+13rYwFiHtzrAJ4+NKnDnsGTCo0WhW0JtOysMsm55eQuQ18UrAQlHV3S0me0ec7XKqiMXJrzOySVtiG3m+f0BlREjGvnUW/f13/p5hNddl7OdELt9clrXtUfteN8DfqXBBhYnYDtiXjTryGu7LX35wWdNbtEKj3Ayr9okb2atjEeLW8gqGeogG5ykIQLpAq0rgJmt7YOmHdY35TdBZBFGa2j9sVrDtu7KRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqAjTUL+jdPl3bqD78ArxV60T7VMk0dbjFU6F2jBKcI=;
 b=fifjGnrvYIPNDImGWSr2RhWqJ48OvKQBtmxTwgiQkbyZ91P4378N3UMmVgLQ2EsQ8X1Hf1Q2X4qmBVQQqxqADIV/EncvtzkkpDmno1PAumOdwywWOkK6yIaUDzSqSDbHrXR8NaJscYz8wydaKMy//hY9wpNEg2dNzsaLaPHn5VWC//29skLTCEFP5Hzy2/Tw1bMYgCUKgSBC/YHP7v02PsAR5bdruW/4MhtSevOX35UrlkIH7VDKJRhjx3gV5aANyeS9s3E5G7DKSZ7fm+K+KBXnZ6/kDDo/nyZdXyJDOJ3WoMxum/wuvpCp0BJPwy9Qm7vYegeA5fFsnynvLbQsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqAjTUL+jdPl3bqD78ArxV60T7VMk0dbjFU6F2jBKcI=;
 b=GpYH2dCIzMG6VeyrlZOxOTxBZ3ZNbufVxaVYdrLnJBwaFyO0PxVyQPAfW6u12wyv+6csppCmVJO1ASmllotmQfqBzpQug3WmDCQV1sLQ3tdImaEHdVrUQA3gMk9UPPBx8+AIk5QsUSPXW2EFdxVaLeIokZ1I9MR+vQGVvlEdbADRz1Zx8GB409l49LkLE1JNcXTy1GBQ3vz/2flkj5R00V5ZzoCksur5Ps1j3a+6C7Lx93u1D4S6spFU/CD0wZ8dt5v7II6ME2VeVsRVYrBGqOtkBxAgtO1TUe7MKVIM7tEC4yIth89N0R/ECJz24T5sAH/PYfMlU0jIUhHe4RxPaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7482.eurprd04.prod.outlook.com (2603:10a6:102:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 20:43:40 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:43:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 22 Oct 2025 16:43:21 -0400
Subject: [PATCH 1/2] arm64: dts: imx8: add vdd-supply and vddio-supply for
 fsl,mpl3115
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-fsl-mpl3115-v1-1-93187d095efc@nxp.com>
References: <20251022-fsl-mpl3115-v1-0-93187d095efc@nxp.com>
In-Reply-To: <20251022-fsl-mpl3115-v1-0-93187d095efc@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761165814; l=2410;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BNGjdCnLRJz68xw9ZRO2bXEBvhKZ8+gxhb0scPIHnwA=;
 b=Ow4u8eVl3t4s+G12z+WGX0X1NgzWqy1Jq5+W/BErPOGtKVcd7cDYpS6KICyRkvOrXnZR/j9Yl
 YH7uk5CsXfJDGeOOEUjt15gMMgSWpGHNv6+ozBrC2yUYqhaDXfW/kV6
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
X-MS-Office365-Filtering-Correlation-Id: debbd52a-20a6-488b-c03c-08de11abaee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aThId0VSaGd6alBMRmVaNWgrRk8wc0lqaGljcXBvV1ZvVE5jaTVlRDViMmh5?=
 =?utf-8?B?UVN5cXBhaG5hYm1QdnlqY2V2NFVWbXZYTkx2VDBGUnV6QXZZVUVDdUM5T3Fh?=
 =?utf-8?B?bUpzUHEwWHFVdXpvSHNGM05HWVZINm12dUJ4a3ZuZU1sOHg4N203TEM1OVdT?=
 =?utf-8?B?cUkyNlhPTmhCUVNwUHpSVUFRaXppMlJUajlVSjlucUFUTVo1MlhnczNkcHJs?=
 =?utf-8?B?bGhxdTdacjlqbGdiYXVXWkx2U2l2ZFF6WFlBTU5INURZbW1UNnNQcUwrY3Vj?=
 =?utf-8?B?WXFnSkhocXNsQ21WZHMweXZCT0hFNlJkanRSaWlhL3ZQU3BGcXJVTFhTSXFF?=
 =?utf-8?B?THdjdjJlOE8raEhIL3dNTG1sankzSm5yN1hPMzVnK0E4MG1mSCt4eldBRVhk?=
 =?utf-8?B?ZCsyZWdLZCtUUllZeWJyR2QrbUZWNkplM2VxTndZOGd4b1hNaExjRnA4Z3g3?=
 =?utf-8?B?SFp1K09ZTG94QldMYzRiMzU0cWl3QzZ2aHdqMGlUZEY5bHVVTWJaVUIxaGFx?=
 =?utf-8?B?aXZTdXhGZi9nUVZwNWVNbk9ON2ZlaVY0Y3dneUgyalNoNVM3djFYYUI4Y0U3?=
 =?utf-8?B?TVBRWm8yNHA4Y1luYkl6UlorYmQ5Wi9pZGV5MEtJMlpuMFUyK2ExbDBra25m?=
 =?utf-8?B?V0JLd2cvQzdIY2RndlBxK1c4N01xZTU2UmdWazRsOU9xYTlJN2lZdHJiSkUy?=
 =?utf-8?B?M0tmeGlnUTdZeGVqMlMrOGlaSjFUVCszL091YVZIcWJRSlhWWFY4clhSQUtI?=
 =?utf-8?B?MGkrRVJDV3J5S200NnhaWXVUY0VpMmtnY1RVYmliVU1INXBSNFFsUkg4V09q?=
 =?utf-8?B?eVU3OTVRZGdOQ1hnUXhXanFWZ3NsM1ZwZEZRQm1keWEwRGdrRUtlakk3eXJm?=
 =?utf-8?B?d09VQWFoVUF6VWNxSFMwVlp1bUovT2RpZzhWcy9USk9SWGM1K1FSZzFoTzAz?=
 =?utf-8?B?Z2RYa1pYa3poZlc1WU9ZVmJWdGV0NnVZNVRWeXZ3RFp5MERCSmI5QnQwRlFS?=
 =?utf-8?B?aDVNQmpvMXJUMmZwTEpUTXJWWVNBSXE2TXBjV0dmUW9Bd05vMEV3ZG1aamNU?=
 =?utf-8?B?UUhjdnVrRVlZMTlMVHpFZWJLZmZXRjJUV21nS1FxcGpORmNPTE1EWmZCY1ly?=
 =?utf-8?B?SmVEeWg1UmVrd2lwOU1OVm5tWi85SFlvSHRNN25NWTNvV3BhS0cwSFdtakFY?=
 =?utf-8?B?Y2hCWUFxYWFWMGlTRXN0c0lzOTRSQmpET1A0TmNpa2tXclM0UmZDaE1mU2hR?=
 =?utf-8?B?dzlCbmV1b2hPNnd0aW14eFh6QmRTUUNkMmdlOTlMc2ExU21ZenRVZTYweFV3?=
 =?utf-8?B?Q3hlQXhxR1lQNWQ4eTYzOTJOMXY4YVc5TGhKcWYvZk4xTkxodjk2a3ZqaFRP?=
 =?utf-8?B?dlNlOHROTnRTbWNReWgvcVFiWW5IZWdUSnZsSXpsYlFic1IvUlNSOWRtbjVw?=
 =?utf-8?B?TERmWXUzVFhjR0twb2JObVVzRzRsMUkrTFRPTHluR1pXQTFnTHFQSURjMHRL?=
 =?utf-8?B?NFdvLzhIUUxQa0x0dE80aE1qWmNUbmtPdC9ZdlZGNXJoREdmUTdQa2M3aEVF?=
 =?utf-8?B?eEE5ZmIxdnYxc2FZeENDL2t4UTVlSzR0U0t5cU9rMTlFRHN5TVZkUUxLU2Qx?=
 =?utf-8?B?aFowR3I5TDl5WFVUVnZFM3JWN0U4V1loZ3R0SVBiYURNZGxnSDNlSDlhMW81?=
 =?utf-8?B?dWU0NUFTYWx1dXR6RFBFdW51azVlYThzUUtOZkR1QzNzdEVMTzB1emJjUnhR?=
 =?utf-8?B?dVN0QkZwcktKSXNwYWluMEtWKy92TUlzVmVBZzAzeUFONVkzTHNsanVtU2xC?=
 =?utf-8?B?U1R5U1ZOY2tya0VBTm5QYWt5SkxFRVI2UnhtVlZKZTJmKzVMS2d1VkN1c0Y0?=
 =?utf-8?B?RmFFdUJWc0xBY0kyT1pLWm9OUkZqaHZocEpBeU9VNEVvcG9RSDBhSmZVV255?=
 =?utf-8?B?ZVBjUmJZTEZjUEo4M2R2WGU0dWoyc2JhU0haSnJya0tvUmc1cUt2dFVOdWxU?=
 =?utf-8?B?UVdsYXdqOFN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUJlTjhtQ1g1Mi9pZW9xb3RkemhyTUV2dmoxeGdHdm1kcGxnaW1xRFppSnVu?=
 =?utf-8?B?dnpVNXNPQ3drMW1Wb3RiVEJZN2MyaVBTYmpYNkNuZVU4VEw4bFg0ZmZGVC9q?=
 =?utf-8?B?RmN4QWU0OTRaYkVYdVc0Z0FWUmxxRU0xQUZ2UC8wL2RzcTNXdmpqS3h1bjVr?=
 =?utf-8?B?aEJuRHVmSit1eFZKU0xnUWlGM1FOcWpTaCtHUWlncEVmNmFoTEFsa29ueWll?=
 =?utf-8?B?cnQzdFBBck1hR0VaYjFVOENhbnFndlpCVTJrVmpkRUhKZGdKT1Q3UDZ1cUZB?=
 =?utf-8?B?b25zMkJSdWN5WmsyT3BTcVpPRklFM3ZEdXpLanFvYnYraUZQVnZCRUJJRnAw?=
 =?utf-8?B?MHoyYVd6UERBS0VjMGpUMkxRZExZMkVwN1pKSlVvMk1ITXZiNklwdTk3Vm9x?=
 =?utf-8?B?TjlqRW4xY1pqZjluekpmU2h6SDJ2TmxUQklXYkN1MitYMzhOOU9GRU5wK0Nq?=
 =?utf-8?B?VVNwUU8xTFlpOTY1SWU2T09SMkRscDdvTTJPRCt3bkE1dFJJNld6ekFWT1No?=
 =?utf-8?B?WVFISlU4Y2dneDNBQ2lwS3RXNDhTVW5oeHJwcDkwd1orU3JNajB3blMyTHFT?=
 =?utf-8?B?NnhIMlh6OUFsMG1uWFVDakJiWkFsNEtqNzZlMUNxb3ZPQXRDVXdDbldXMDVM?=
 =?utf-8?B?dmdtTDhqYUNrbEplaURVSVRiOWxRSnlpdVcwU3VUTlU4TmZmTjlhUXliS3hw?=
 =?utf-8?B?VjhPQkk3SG9yV3JDV0JZaFdkblgvMCtwQmEvT0tVOG92eFhtaHpjbGc5d1Rk?=
 =?utf-8?B?TXdiNnRDOWRJUWptNHFCNnBlZnQ3T2lUMmhuWE5IR2dTRzFpb1BSMlZxOWx6?=
 =?utf-8?B?YmxpbGk4VEdKVDhBelg3YzBtS0lsbXZLY3A5ZUlXQjRpcGZTN201SitURjZJ?=
 =?utf-8?B?cE8rZklaT2R4cy9HU01nQXk1YlgwZitEd1pURXlNR1oyK2VKcFlwd01iNFli?=
 =?utf-8?B?ZmNpR2kwRjd6Tm53aGZWTFhkNWdiUmxOZ3c1TWpBLzVrWkc5N3FZbWJVdlA0?=
 =?utf-8?B?Y1dpV08wZjcvbzlVUU5DalhiSkJzMlQ2bk5McVVBQ0VYNk9kRWREekxmRFZl?=
 =?utf-8?B?cWhlenFobXhzSmhmSjg2Wi9hdGlaU2NiWE51ZE95M0w1NVY5OUV1ZWtBbXBF?=
 =?utf-8?B?NkFoRHZGSXZSelVtRUx1MnBxcUpjRk1ZaWpLT0N5RENJK2Y3M3A3Y1lGeFNF?=
 =?utf-8?B?aTk5bStnRmZZd0NCY0VkeU5sTjgyZjJvWk0xOW1ZdHd4ZDVOYUdLSWgxQjhU?=
 =?utf-8?B?OURlWG9zbml3Y1dUd2s5WGJWRHRsc05CYnp0ZHBIdXNWczhoM0RpRGNobDhh?=
 =?utf-8?B?c3dwWVU5eDNZMlJNOXdCNzhkNWJKeVo0MXZNT3BueFVYK0lnRHQ1VkluOVBM?=
 =?utf-8?B?Zm5EZHh5OUJ1NHd1aDN4N1ppK1hZMkRtVWwraVNneVlJSFJtcnhMMHlweCtI?=
 =?utf-8?B?ZW9aczZsbE5EMmcyVHhLV3JXcVdyZnpmc244Q3d1YndhaTFmTjJycGZDSUZE?=
 =?utf-8?B?VjFPN0VJaUpDVWYwSG9zeWdyL3BabDcxYWFnbVFzeFpuQVlmVHpVQkljOEdu?=
 =?utf-8?B?UGVyc0N1TDE3dzVWWG10NkUxbUMrOElpUGU1STlnTk1lM3R4VlltRUFVa2RR?=
 =?utf-8?B?aWhYaVNnWWRBWUNuSUhmQ2YrMk1IS1pBQmp4MExFMTNLL2l2V3d5dlJQaVRV?=
 =?utf-8?B?NjNla0dIWWcrOXdMMlFWYVdJMStEUkcrQkkzZXpxL2Q4RjQrTVJEVU9adWlJ?=
 =?utf-8?B?RHNvRmdtSXBSNDZKWVVvZjd3bHhOT3NsY2lqVXdzMWo2S05EQzNHbGdhT1Aw?=
 =?utf-8?B?MldTR2srV0RJSkpaYkNZTStSVzVPbi9CdFZlYW1rK1IwWWRiMGlxVHczelNr?=
 =?utf-8?B?b3E1Y2prbjFIY1JlMHIxcWlxcDBtdFJMMnUvSW1rd2Q3MkhiNm9DZFdjM2NB?=
 =?utf-8?B?RWZ2VUZ5d1FEWGhOd20ybVpkZkRrL29VVy93Y2NJbm84THJ5L3NNVzFNYjdK?=
 =?utf-8?B?M2I2cmRFMTdqQTZPMmpHVXdGR2w5bWhSQ3BpSERlcmxsUVNVSk5KWFR3MjQv?=
 =?utf-8?B?YjJoajJuRVdoa0h1YU1GRHZGYVF5NUthbmRNRFJyYVpLSGNQL01mZll0SVNn?=
 =?utf-8?Q?046ddyqGSA7Tju8oCJf36GAcG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debbd52a-20a6-488b-c03c-08de11abaee0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:43:40.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlLbt+/+TW4m+e5oL6yW5uqs0oiW96DbJpoXtI70swccl3r3aKOTWVoshpgcxUMJ/go26Ox9UViMYqW/T16kFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7482

Add vdd-supply and vddio-supply for fsl,mpl3115 to fix CHECK_DTBS warning:
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply' is a required property
  from schema $id: http://devicetree.org/schemas/iio/pressure/fsl,mpl3115.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change dt-binding is not prefered
https://lore.kernel.org/imx/0e00bb14-19c7-493a-9629-354bac3a273e@baylibre.com/T/#t
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 202d5c67ac40b844ee38e8fb0f9caf2e186cfa9f..6a75ec612684e1e8e36346cdfdcc3d8ef490ace3 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -249,6 +249,13 @@ reg_2v8: regulator-2v8 {
 		regulator-max-microvolt = <2800000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -566,6 +573,8 @@ light-sensor@44 {
 	pressure-sensor@60 {
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
+		vdd-supply = <&reg_3v3>;
+		vddio-supply = <&reg_3v3>;
 	};
 
 	max7322: gpio@68 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 7b033744554105de6dbc4366f21e3c90f1768deb..f19350536bc919e31b539e0d63fbb8514040dfad 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -150,6 +150,13 @@ reg_2v8: regulator-2v8 {
 		regulator-max-microvolt = <2800000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_pcieb: regulator-pcie {
 		compatible = "regulator-fixed";
 		regulator-max-microvolt = <3300000>;
@@ -453,6 +460,8 @@ i2c@2 {
 			pressure-sensor@60 {
 				compatible = "fsl,mpl3115";
 				reg = <0x60>;
+				vdd-supply = <&reg_3v3>;
+				vddio-supply = <&reg_3v3>;
 			};
 		};
 

-- 
2.34.1


