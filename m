Return-Path: <linux-kernel+bounces-877051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3278C1D120
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DFE562181
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0E35A153;
	Wed, 29 Oct 2025 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V4DGFHzf"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABBB35A954;
	Wed, 29 Oct 2025 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767707; cv=fail; b=L4pVrtGjdk959PpuOGxMIXQUMdX6lm8DG7VmX14/76gYiCxyW1bMFYByJSV4tt25T0C10+/M8ODlJboaPXqSdJtMttRRJTniOGQeXqYrKtC3qEoXGwzGBmPoy+OTL4CCF+SBnQQDmI/iItfO9gA4MyKkz4eayY6Frf1PH+kP4jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767707; c=relaxed/simple;
	bh=iAtTHlXXZL5FCGt3LrlB6M+tZU6B6Zd38Cdkc7bWx3E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rQCM5lHPkRnuNS3wE9FPWoGyoKsWZ0m6A5FlyTH3YIj/aHZuYgoCnJayJrAQksN9b7fT1cLVQp8Qb+6yOt9peEq2NyzVvxd8d17shymShcQNcNImiXaJKC5b8pCvuojgDZdmehAF7f++WzcSUBCRBvhdmq3yoqo9ZwP6b1UmM3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V4DGFHzf; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAJPJ38qdN4hfY72EzgNqPVJDhFy79Fba2DY/lIuU0nBGwOpril6LQkME/Tox0LN+OeECyw2YufZljX9aLtewimCHfsZiua7eQLOAT2GI3s2BsafYBZnNCYb+BMkl6u9E5gXP8Wfj+QoWBWf/Gs6IDIn0tWADbShlYvTsks8Gr2VYhA+D4ZdA25qbtCNVut9K4RoFXsNKpHIBrOldYvVYHsPRP2h0cKxFbVNjwh0Ia/F4e5jiDnnlXQXeqF8HUJscBMn06gInsDH3mE6eGLmYyoNZpHHGHMRXVNXbe/QmOVIfaVs4+fXGB9arQMwZP+Y/kHihjNW9LcpPp3eGLRAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ovq7iceKkBLLrRKuQ6PG0ApzpSXZp+VV1NR64jJ8iNc=;
 b=UQMg74587oZctQDP0jKRqQwfq3mzBQ+SJQls/iiRH7BemVKI2hGfHWQ6/ohkg+dk+2d1itAs54c1sTAGXpC2alkg6GjIFFA3TFS68Gkvr9nEHFCDIfD6VTi2JYmcx2RxkQYWrPa63RwvwxZj5mOUhPm/02F70z1V+KqwsB4r6IHgSkkxiJrODLFeVuBA+uhjNqnudMTwiAZ3cGdLxsJz26Fo6N47mueREPr72ebsI87MiRLXSTTi8Q9EcZTn3ZmBJN6bUDjG+BXSMkwk0/xJku/VxQEKKgJ72zNp4V3MTtVrAFQUC93+8l85JZoal2DsLi7kQYRC2gv9J4crW/UiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ovq7iceKkBLLrRKuQ6PG0ApzpSXZp+VV1NR64jJ8iNc=;
 b=V4DGFHzfXEsN6mfkLIdcK4MiFgzS+/AejcAiw7xIPyRJDp6JEYgYTCY0FdjIGDoiSolUU7L+pZ107ZCrJ57BsHzw4i9laaNN6gK4xjCkELWmh0ZEGZeEV1JTnMDwIKh3s2I8NF6HlY/0Ephn77efZcj9unsd39I0RsmucspvQFoRj4dF+rbc97LHEoy/sg22ajdW1pvsDhNKcufLMWaKUxZ3SOSE8P7V4HcMtkzA0IBV8uREvigfVxs8Bpga7fNWbu/Uybq4bdr1zI5ZKXkqH9ku2PXEytUN94XZXVaeLG6hBC3hRsEJAmG++JsUp/Zrf44/AP9ks4CeyP768J2LYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11377.eurprd04.prod.outlook.com (2603:10a6:150:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:55:02 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:55:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:39 -0400
Subject: [PATCH 03/12] arm64: dts: imx8qxp: add wakeup source for power-key
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-3-cf61b7e5fc78@nxp.com>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=704;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iAtTHlXXZL5FCGt3LrlB6M+tZU6B6Zd38Cdkc7bWx3E=;
 b=Gv+l8wI0kLd9cv2G6H/pITwSyzIODNRErTpqxpD+A5nA2Gb0nqX+NLZCEaNss2AWwo3/TIsko
 kKssz4FNt5hCLkysd+I8WK35nan3fGDaVAHiOCpfqEkZmRl27OXKyXO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11377:EE_
X-MS-Office365-Filtering-Correlation-Id: 175ec77e-3046-4919-391c-08de17250c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlJZcGYwN3RsVnpYUnVpSVJBYzVXV3c5N2g2TC9CUFQxSEo4eUhmTjFndmlI?=
 =?utf-8?B?VFd3SDZ0cXdOdW1oaDVhOEF6NXJXZCt3OUJ3WWJRUWh2YWlaUWlodkhzT0ln?=
 =?utf-8?B?dFRxL3B4RS9xS0pCSkVQbTJ0SHVrY2hYTXI1NElXYldWUXlId3hWdXdCelZ4?=
 =?utf-8?B?ZGl0T0p6Z2hhNjdlaVB2SlcwVzRsdlNKWksyYXZmb0d5SlRmTUxKOW52dktR?=
 =?utf-8?B?OEg3Y0t5M2Nvc0ZrM05jU2txdnNPbC9wdEIvV2p0MFQzck9EaS9FbXVRWVQx?=
 =?utf-8?B?SE85QWx4dkorSXlLcFpCUjB3Q1VhYlpmZHlJa3o1YXR5VjNlUEtORUY0VVMv?=
 =?utf-8?B?VU5Mcis5cXMxUXc3OUpnSzd3cWFIcHEwT0daSDAzZ2NuZnl6QlFzQVFnblhz?=
 =?utf-8?B?djRhMExEaWlNT2RHWEs3eEgvbXFLS2RPNVBkWS96aHBVQU1rVUw4UmxseUJ6?=
 =?utf-8?B?SFFrV1Z6a1NYY1lPMzdsOVhsUzUvMm9ZK002dk9KQlFEckVETC9xTVlNMHlT?=
 =?utf-8?B?NW1YZnhUV01NS2pTR2xuOVdISDhYWnBqWkFlNlAwVFlNSk8wMXRtT2g3b3RW?=
 =?utf-8?B?SnFZaFN4eGxqWm1EenNvNzBOZDg5dmplWXpQUFpXVDZWU0JMU0pJZi8yNVVi?=
 =?utf-8?B?dmtvVkdDaWhSb1p1K2FLcDFETXBoMG9jMkYvaG1uY083QzUrcHZOV1Z0RHpK?=
 =?utf-8?B?T0VhRFdSRGFtRFpQYStqTURialpNelVHcGEyWWFieWNRUGhpU3JUOHJqK3I4?=
 =?utf-8?B?NUovNnZCUXhOdWtCR2pjSEFqOWlCUURzTDFDbmNuSHVCYTZNV2RxaXUvVTFo?=
 =?utf-8?B?eURUeC9NdW5nZTdsSVZxOTRNOHhucVdjbDBjcFlRSVBHbURhUkRBUEpqbXZY?=
 =?utf-8?B?ZHBOcnpsQnJqK2xHQjA0aTc0VmlZM1J3VmZNc2NqZGF4TWdRbkZubVk2SzV0?=
 =?utf-8?B?UkR5eE5iWXRPYnIvOThuOHdCenN0SXhLNXY5NXJFbVNYNm9EN0Y5SkxFcm1a?=
 =?utf-8?B?YXNoWFlPYWJCajhrWW8wbnEzMGJMUFc0SXdENGZoQnQ4UjQrcmRseC91T0RQ?=
 =?utf-8?B?bm1oR0NZVVMxUUR0d2ZKV1RBdUpTQ0VCTTFzTFFwYU5IRndOZGUyMXo4QXpB?=
 =?utf-8?B?WWZ4WXdXZ3pOMWpkM25xbEhqV0w4Vy9FNlJSUlB5U0Y4cHJqMWF4SHppSlNs?=
 =?utf-8?B?VWdibzQyYkU0SmlRWitmYW1ibmxjaURYNnhvMmNiZUJIM3hqaFMwUWJCaTE0?=
 =?utf-8?B?Z3ZTRUo0dDRuZ3VuUmZ0MmtxUkYrTEdBSEFxS3hWc1F0dm9mUVRqbGFaS0FK?=
 =?utf-8?B?K3R1cVcyajFuVkJBbFpidWNkRzEreThkamJiczZXa045WFlmOVkwYkpnVWth?=
 =?utf-8?B?VUdtU0dobmUrYWwzQmFIRWdqZUFJYVltaDV1NXRJd1BuclAxMWpXM2U3aThE?=
 =?utf-8?B?R2lRS1IwNHYyaWhEWlkvd3grWDV2bUUvcGpxSmpJWkpCeUNsUW1yUkkyN3hv?=
 =?utf-8?B?WlM5WUtVSjRVYnpDaVRsZHd4VmZ1ZlltWU9zVTZwVGNiZjlEa296bndDK0VN?=
 =?utf-8?B?QkFBTjh1NVd1c1ByYnJ3bi9ua0NnU3liZWdNekR2c2xFVnkxam83d2hJR0FP?=
 =?utf-8?B?SnFQaTBYcENZM1ZGMUkvTTlTNWlmUEkzUDRpMCtJcDdHM0hONkp1dzJrY2pS?=
 =?utf-8?B?REZSaHduVUFzMnNaMkFKK1J4bFY4NFd0R1RiL0QxSktzaXN0T1ZHc0drVzls?=
 =?utf-8?B?c3JIN1dHem83SEJqaHExK2d2dzB4WFhvaE83Mnk3SVNvTDhYZ1hZWm1MUUp4?=
 =?utf-8?B?SlE3NysveEtzZlVqcWJxQkJSamFSYjQyZjdMUDFBRVZnbzY2Ykc5K0FSR1Mz?=
 =?utf-8?B?a0xMeU52eFJJM2NUQm1VUVVPcG51eDZreEExeUhqMzduU0tHVys5bTVCak5r?=
 =?utf-8?B?QnlhVHRYLytkT2I2ck9ZaXUxZEw0d00zRFhhRTAvbDByTWRTQ2QrOVI0eHBl?=
 =?utf-8?B?Sm5odVVLMHdrRkdiVEEyRlBzczYrSTN5RHhaT0N5VjNJcGtpYnVJSWVlNHhB?=
 =?utf-8?Q?z2W9d0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlZ4czBmbnVFTm51aVIraTZJWXlrTXdvQUgxbnREOWR1ZlYyTUcxTDVxODZH?=
 =?utf-8?B?VGhZVitMdVBTelFBeEFja242YVRwYUdFRlZsd3M2SCtsakRVRlNMQzBZLzE4?=
 =?utf-8?B?b090ZkJodm5XZEJZSjlGY0JBMWM5ZE5rbFdxL2lJbTJwVXN3VytMMWVSZFBw?=
 =?utf-8?B?YnpVak5NQWlwTW0wazcxM25RcnZ0RTFQUkxCa1F3K0gyYkhGdjQ2azZHNnVP?=
 =?utf-8?B?YzZOaDR0K1hVN0xkU3cxL1ptdUdXVmlmUVplNWlFWWIxWURrN1ZTbm5hWFk3?=
 =?utf-8?B?UTg5WEZ6ZU1zUVBybGtTOTdiOXBFZllYNWM0ak5FaWJDRUxuUm9UZ041bThy?=
 =?utf-8?B?SHFiVFdvYnFmaXF2S2U4aklzVG5aUVlNc2hwVW9qUnZzTFMxWmljM2hqN2I4?=
 =?utf-8?B?bjJsTXBlUFFWTVVVN0F0WitqbWtNc29yS1luTnhaNHdoQ1lqQVFvUFdaQVdV?=
 =?utf-8?B?cGhOaG1qV2JWbGgrWG5sbHUvWGFKQ3hwZFRKMnRsSGQ1bll2eEx0NzBRbDdl?=
 =?utf-8?B?dVJkcVlzclJwek5xTlpIU0Jyc1owVWRBTlVxcVN4YnJmTWU0L3doOEZrQzY0?=
 =?utf-8?B?OGlpajAva0dFMFFpdUF2UnluZ0czeUM2bmFXWEdraEtFOGgveWZ6UUtxdXQw?=
 =?utf-8?B?VU85T2JqVUV4UmduWk44OUNpczcxMm1Xak8ydWxkWjVMNVB0bHhQZjNydEhQ?=
 =?utf-8?B?MFpQT3hGKzNKNEhoenRETzkvY1Q4YjZRMFVxdWdrMXVLYTFrNUE0U1YrWmpL?=
 =?utf-8?B?KytNbVRsUmNtWlZabGwzcFFQanNDVDRqQkJTbkJkSjJpaENrRGJOeEpNMnVW?=
 =?utf-8?B?TDRsdUNEUU5OZTE2dE5PcDdiMERhOEZVYzBnOHkzdGZ5L0pscklpaGtLa2hI?=
 =?utf-8?B?dlBiK3k3Zy9DTitLK2lZSEhmeVQzeVduRHMyeWJja3o3dGI1bjNYU24rYWI4?=
 =?utf-8?B?UjZWSzNRY3JrN3ZFWExUMW5GWlFIUWE4dUVzU2NOMzI1REVkNW9La0w4L1g4?=
 =?utf-8?B?a1JqeHRGaW55amFzUEhMV1ptQXQ5OFM2REFTcy9GZkkybWVLVWlSakU1TUQ1?=
 =?utf-8?B?alZ2bzl1MDh2N2F3MnBTaHd0UEcyb0ViUU1hRmM2MGtKWGZOOCtnSVpSQmt6?=
 =?utf-8?B?ZENXWVBuT25qb1BsZ2hLYVpGa1FCb1RubFk3a29JT0diWGxGd0tJamZnVm9X?=
 =?utf-8?B?ZkVwK1hDM3hQUElrbHB0UVhQc2VBUnNTci9WK1VhSjlGdS9jaHBlNlM3S2Iy?=
 =?utf-8?B?QktscFV0VEtGWDFJK0FxQjlEenRDNEpmZVVpNTYzcDVyUUZQanpBWE9ndXVj?=
 =?utf-8?B?Z0JDZ0Y0U3dzaGszWFBEWk9KcmZnVFFXVGlNcWxGOEJzVVhzTC81WU1LSVZF?=
 =?utf-8?B?WkN2Y2l3bjZtWVpPenpHZEcwSU95MFVaaE5zSll5OEpyWkJhRzFBbzVLUHcw?=
 =?utf-8?B?NFhNWDFwd2V3N2VRM1AwaVJHL1ZiekJZbjY2TmoxenFsRFRsSzRMcXFTNFVa?=
 =?utf-8?B?T0Y0RHJsTW1QZkhXQWZ3YXkvbmhNbnlQYkNZUTk0cS9XZmQ3SHptWGZOb21w?=
 =?utf-8?B?dEJiUFdHYWxvYjJXQVdnOXVnTjBBTTZsTVMvYlA2ZmVuOCt4Vk9nWElzQmNQ?=
 =?utf-8?B?TDgvZ0tHcE41cExWRVQxby8yNE1XUFRRN1BZclI2UC9KNVpWR1FhQ2VjaHdE?=
 =?utf-8?B?dVFCOGp6Q1dQTjFvaSs2bisrOTR5dnhMUjAxUkgzelFWMmM0L0lJaTVEK24w?=
 =?utf-8?B?MUM0NmxRQUxuR0lMdkVnUDdTZ2RGZU80dTNYVHFrNE5FbGRyWVdtWGlLRzAx?=
 =?utf-8?B?Z1NKS2hpMHBBQjg1SXIwRjRuNllvWUtFYnlMK3BuUVU3ZWkxYWpLWldUa2lK?=
 =?utf-8?B?Q1BvWEFnMmN6QnBiL09qYzQ0Sk5jQUFjMmt5RTVZWExDbERIVVRGTVZGTzA5?=
 =?utf-8?B?ckhqOFAxZ1NwS3BOK3ZaYjJMOE5QM2tGVmxqRGN5aFl2MTE0ZnpOVEQzbUhM?=
 =?utf-8?B?ckJFSVNDTDBxeWJWcGwvQzNjU3RMWEtLM3EvdlRpQkY5SmpVQ0RCakhtY3Q5?=
 =?utf-8?B?WlBYd3hYcEJxVlNqQWVkV2dBRlRtK2tWdzBIV1E5VjRkU3BRNUpXWHRXN1Nx?=
 =?utf-8?Q?SC5zDKt70niS+SCK4Ef4YBKgX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175ec77e-3046-4919-391c-08de17250c80
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:55:02.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oI1G8z+Qf6g9lUgDmcQB07qqDrsl5zXpUC9Fce4DZSY/TZTpDzRhLEjKoZjPBFq+DIjHIQQKx7Sopp+7yt88JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11377

Add wakeup source property for power-key.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index cc82cc319159c2558400fa641570cddd3ad3083d..8c9174c8b3a1ca1468345f27693220823a5a115e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -248,6 +248,7 @@ fec_mac1: mac@2c6 {
 		scu_key: keys {
 			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
 			linux,keycodes = <KEY_POWER>;
+			wakeup-source;
 			status = "disabled";
 		};
 

-- 
2.34.1


