Return-Path: <linux-kernel+bounces-834340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C21BA47D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A455317B846
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB6C23184A;
	Fri, 26 Sep 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FcxiKnFG"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD7230D1E;
	Fri, 26 Sep 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901695; cv=fail; b=nTPMhDIXKUs0uSMoFZk6+zB/zIdKoRWoFPQ8muG+SlKS5GAV1/58PW7OvMzrXW3j4m0kU378cN8OuugHOrcaR3j0RL3+7TL27xdPFxOCTJ0tRynaj6QMWTJXM67Q95kVni6PJsJHkEmHmtI6HzeNMLKDRiW8RmMML4qx4wiQ+ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901695; c=relaxed/simple;
	bh=tOtSXomq2KH+8clEacb9RWYs1iYcwyaRAGNdBtHVSY4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZEMh6ENvyqxjBe/Ws6vMuIOR1OU+WbUZwAK/f/lWe3bmEbqhUY10Yr8VyWaqQ37LT4yTSK1YrxGg/tPaztgxZXzsANSuC1sGN1+i121HqKoO52jrLwFO3k47j3fa3e2pEur+TAxs+Kolv9tbieulz9GgSSOc6QVRKMb33SFi058=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FcxiKnFG; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpvLrsdHSY3Cg2AgCZw40RUk9MRXjWoY35SufFcBe8hGZBVOEznGLLM7gWYyVWtRtkAKXwDMUJ7FfWChrIWH3UD0RUnzz/YSI3olWk3VrJ1l69pldU76MSUpvBpxfRz9JrEUGU8iuWifqfmv9AmBT6ghhQRFaRNYyNRPUYTGNicF4gyPAmbD9Bm/GfxdaruCNeMorYARRSgHdD9hQl1B9nVoVRhasRzo5epHtqbSS8mUWPX4ObDYfiF2f+/SltyUyfxVoOC69iTV92k89C94jqxXJBGmtHHMXwn2l3zmf49QaAd3GKTWXdOo+bhNREbmGYr6vH1IQfaVdClzgbGyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9LQ6U97DJmOvAnP/Hm3/sLsl0YOZft52i2nAtpwopw=;
 b=s5sTiuIeV9IAWz0cXP6c+j3jSSRE2/4tbvx1JIuD5vih18ILfY8F9ls8j0lKWev1MAdyHHsspdNU3hLM/AlsX77jII6TNanm5HMzwSWIN9jroGV2tU6afGBTxLlETjxmWLtGm4Qndswhqo2Dx6Z8qHp+hGGdPwO6i1wgNpFX+Jie9zZVJiuoqRx06KvOPcnJaiUMEgnsFfxyI75lPmw028UHlTMpiejQGRsmpRKDSp3S+Ua2srR6SJ+kz46ewoYonewXsaK31OLeq3jQ4prB3YdCihdabFBIk0idGUfqsjanAEUIWHzqFzAfKGWcg2al+hIH6XiPAqmzGTNu9cEIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9LQ6U97DJmOvAnP/Hm3/sLsl0YOZft52i2nAtpwopw=;
 b=FcxiKnFGFQwPT3ryJUux4ewqufJ4nP/c3wqNKm6Yt5kG7unJneeP0PLd3A74mPs69TjJcw4wkb4TfkdaJ/u/uKmsUJUokF8d4zD2PPBFCp8GpmXgfZwdQ3kIbf1BcvY7p0s7zOTJ4ayPS7clyuVxQfFk840IiN8qYh9l4jM96Q648kxq5mEc+eSPo3Cb9s8bBLkzG95ef7xgTaU+kWq6mpVN1g/QAiyJOoM+oRBoS22zNah/NZE9EC6qY/YBMKRZ4WrxBLfa2MgMvMEiw2CzwMwi6KBIh1dea+Sg+wy7vLuImWfQbFOfNi6+rNDzTKfsf2lBK/KZhzqC17YyPOTZ7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by GV2PR04MB11826.eurprd04.prod.outlook.com (2603:10a6:150:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:48:06 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 15:48:06 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Sat, 27 Sep 2025 02:39:32 +0530
Subject: [PATCH v19 2/7] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-imx-se-if-v19-2-d1e7e960c118@nxp.com>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
In-Reply-To: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758920996; l=3201;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=tOtSXomq2KH+8clEacb9RWYs1iYcwyaRAGNdBtHVSY4=;
 b=SXt24HZsFO4T5It4WWE78ooH5HmFrqmCKjyXST5MXKZaNz5DhMPIhM1hPzbhjloGgjD0JOBPS
 vZUeNabBZvFBmaYoHqpF4t09MY+vbP9GwBZcMimUk05l8i4YCKHz0eW
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|GV2PR04MB11826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3644cf75-2035-49ad-b4e4-08ddfd1415ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEJvWUVHWGUvTkdjMWd1SVEvRitGb0JBWnJIajk1cVg2cHVnVnlpUFRLR25H?=
 =?utf-8?B?bTRuclFpaTJxaWJ3NVRpbkFZNFYrVFM1UWFnMmRHQkUrYXRQSVMzTmpWMjRV?=
 =?utf-8?B?TnN2eUVQRG43aFdRRW9EM2JFTzJTZnlQb3ZCUzI1MUo1aElTM3B4akYzMm55?=
 =?utf-8?B?V3NFemhXTGxycm9WUDdlNGE4U1J6aDFESjkzd2JQMlRyYzRlRmR3Y3NiWDc1?=
 =?utf-8?B?QzNwSkI5bmxMWWFYS25nVUhHeTREdnU0aDdYZ25RR1BobWVoVHI0bGlSREtX?=
 =?utf-8?B?MkxMTUFRTFpiZEU3REEzWmEyWHRFZTVyY3RLNjFlZGZ6blF4KzdWMjhuV1B2?=
 =?utf-8?B?Qm1vdjZwdkl5U2YxMXNCRkJIc2NVQ1NMZktQNVowajBQV2JLTXJTd3FNSU51?=
 =?utf-8?B?QnpWaGtMOWxnSmFWckh3WmhjeHJyS1gzSW9UL2FpTXZNenQzUm1Ta1ZDcXp5?=
 =?utf-8?B?RGwzNDZsdngzOC9DQnNmTmZnaEcxcG4xbm0zRGtKKzJlUXNNa1RsZWg0Rm8x?=
 =?utf-8?B?bVhZTmc2U3RCaTZVWk82S1l6NkprcWVOSEFGamk3V3c0bEQrb3hEWW9tdko5?=
 =?utf-8?B?VWlSdkI3WkxrL3REcXN3SStGbnprMTkzR0ZNVDlONVh6emk1Y0JFY1JrSVRY?=
 =?utf-8?B?TXF2OC9tc29ZaG1YVFhlSXc2SFVKcUJrWDRNVFhuZXE4ak8zdkJIWHhSKzZE?=
 =?utf-8?B?VmszdXEzaFd5MnpYUGtWQnRTUWEyZC8vbEJ2VEpNQnV0bWJ3SmJ5UjR1WkVE?=
 =?utf-8?B?QjdtQ2FZTW9uQTR1YW5NZDRXK1F0UVVuejJEYkptamxCSTNVTTFsem53M20x?=
 =?utf-8?B?WVgrVTVpckR5Q0hZNGl6VzdvTXFKNHJacGZtL1JMWjJqQ2NBVVZpd0gyeDJw?=
 =?utf-8?B?cUFINnM5enlyb3VFYlVlWFhDMUR5OFNMRjhLMk9BZURZU0VMWlVFaWovZjlD?=
 =?utf-8?B?em5OdXNPYTBRMnk5ZHlLM3VCa3ZFNzJmQzRGRW1Sak1mY00vZmJ3bWtyK0JS?=
 =?utf-8?B?S0lodmhjYmx1ajRxRmtvbjRRc3VGUW03TlkxUTJmTTJlcDVDTGxaK091UGRU?=
 =?utf-8?B?aVJEVmJ2NmVvYlNIT3B5cVJabEt3eTNValYrbE1oNmFZOHhFeXdHVlhXTHRZ?=
 =?utf-8?B?WXh1eW9xc2k2RXpTeEhkVDRZc0FhcDI1VW5wY0dRVlVYdStpN0x4NjY5bUZL?=
 =?utf-8?B?ZEt6S0J0UkFFTjR4aFNrSUUzWC9XRFczU2Z6aTJVek4yd3ZiV1UwZDlSZ3di?=
 =?utf-8?B?WTlkamN6WXdyRWFmakE3VFdNNTVsaytaRDQwMDg1QTAwNHBPT3pHRUhnd3B3?=
 =?utf-8?B?M2RyMGJTWlRiaW9yTXJDeTVIdGt0VnR2d2dzUnNISUs5YzBCUmhpMDNYZUow?=
 =?utf-8?B?d3VuZmgxTGs3a2ZoazhaNDBpUmlaUURhNFFablhESTlzdGNOZFF4NW9EejFJ?=
 =?utf-8?B?Q1NCZzlHK21IbGRZOUZTeU5WNHJtRHRaZjFOTnJ1eEErcVlzcFE2Qlp3NU9r?=
 =?utf-8?B?bmx3MjJ6eE9rL1dpOEhTcVZ5VWJXbXVYR3pIRHZuM2NESG40cm9naWMzdzRx?=
 =?utf-8?B?SkpLQlU2WjdCZzBOd04wZE5OSXZLQ0UxVG4yblEvUkFwNk44TTQzR05RLzZ3?=
 =?utf-8?B?d2lLSFo3Z1hVdG9hb2JDT1NRRG9FYjZOOUFZMHFZL0pFWnhmUmZpOW5ab1dR?=
 =?utf-8?B?S3VESGhvUHpZQm9RelZ6d1ovdnc4QmVBK0MweHFsTnpjbVdQUUh2R0RFNElp?=
 =?utf-8?B?VUgrMXBBa21hU3lIR3ZKbXJNbXNJeWJFYUxrK1d6b2lBd2sxbkhGMnlPKzNJ?=
 =?utf-8?B?Ym1PK08xWEFvZVdhMmN6NktMdFFVWmdJZGw3UEErbXh3cDVkUEppYmxCVStN?=
 =?utf-8?B?N0d5VXdONVhiR1pZbjB3S0FHVWppRUIwSnU4cU9jU0JLNmd5M1RvdHZSVStw?=
 =?utf-8?Q?CV0CfGe9JNM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THcrMjBCVjdoaHBmWDhCS2RlQTdnQnEwUkpTV2JCbXFYZ09ndTIvNWcvTzlZ?=
 =?utf-8?B?WjNuYzRSdzk2TEJwK2VRWit5S2JVdjFkOGVQMWUxSzZyWXJ3djRZWUxrSjJt?=
 =?utf-8?B?Rzh6QVcrem1kWnZHN1Y3OU1rakJjbnRSYURnanFuZjFFY2xIVFRJRzAwRSs0?=
 =?utf-8?B?ODlLQys0aWNtM1pLRjUwWm94OGt0SVBwenppbXlwb2VkUmZSeGgwQmVrbzA3?=
 =?utf-8?B?eSthaHFYQ3BwUjhlQzcxSTIxZWE1NnZoUi9taW5GNjFoN0J0WldHTHJvL1VF?=
 =?utf-8?B?bWZOeFh0Z1JmOW03eHNpdkgzU0xsRk5sTVZJc1lwOUUvMkxMMVdUcHAyTHh0?=
 =?utf-8?B?cGsyZ2ZNb2FCRmMrcFM2TUdUL1M0MDQyVzhGM2RjUy9RSDB0OFVjaFZXL0cy?=
 =?utf-8?B?WmNiZ1NBZHBNK2NISVFielE5T3lHNWVpUGRXa0g2TVBubXJGRzBWczNubTRx?=
 =?utf-8?B?dTZnRDZhWmxic3lmTkVtUFFnbkVEUktZVE10c0dxSEo0WlBwaGNud2s3c1Ar?=
 =?utf-8?B?SEpnaldFRHFkT1Jobi83MXd1dm1tckhzMk9kSFRpRHI1bE9VWDlVNTNOV2NV?=
 =?utf-8?B?VEJtQ0Z0U0xNOEVzZURhUElhYkFCdVc3ZGV0RTFNRTdrMWp2aU9LVVJPYlBs?=
 =?utf-8?B?L2gxQkF2RUNzbGZKMzV3dU1VNUxycHN0b1hPNGNNcHBoRVdSdGJXZ05LMnhw?=
 =?utf-8?B?c2J2cytjbCsvWlZHc083WU9qd3dad3dLbG9XU0VpRGNuRFVrbTNVQXpUekFo?=
 =?utf-8?B?WHVlcVVOdlBQbVN2bUlwcmdGanMwTm5XelVUUjRFTndyYllDc0RWcmJwdGVS?=
 =?utf-8?B?dHl5emEzU253VllTb3N5WE40aEQyV2t1bVBlTG4yYmF0dWFCbElOR0tqVXZS?=
 =?utf-8?B?bk1qT1Q0TndpenZWKzR5SytxbUNVSHVnVENLTGN1djUreGF1RDFzRnU2cmYv?=
 =?utf-8?B?Z1g4OWt2bVZZcUJtaFo3US9CcUQxeitjZFF4aDAzV0xkVVVpcGJzUnhOY3dL?=
 =?utf-8?B?TGNITUUxNzlwWm5zU25DTWRndmZMWGdzUzN3OW1UUm5jN0htV0l4MmlSUHZr?=
 =?utf-8?B?c3BIa3FBWDlWd20yWlR3ZnZqQ05IdnNsbS9xYU9XK3RGL1hMTkhacmtrR21Q?=
 =?utf-8?B?dU5Ya2x3TVhvY1VBUmZ2b3VCcWlHNGI5NFFVSXo4b1hzaGQ1ckh3NVhWQ2ts?=
 =?utf-8?B?S0hkeExhU1k2WmZmYlQ4MndMWjZ5VTAyVXI5VjJONGpUZzIvQ0JhN3ZvRDFU?=
 =?utf-8?B?YmpsanhVODNuSDFWMTNTOEFUSHJJY3NveFBLSEdkbW1nMGdZeE00L3dUZFFj?=
 =?utf-8?B?QTVPeTBsVCtFaWdMV1hXVlNodlZvV1BhMVdScGU4MWNkNEtKSmtqaUVYazU0?=
 =?utf-8?B?T1pocVVtZ213MUhTVnRPcm0ydWZHcndDV204cjcyRG1qZWZlU2x1U21LdEZZ?=
 =?utf-8?B?cG9aZGszeWFGOXZTbHJlMEluWm1GaWJyZmw5SEhNclFsdFJvbU53ODVjZ2Jr?=
 =?utf-8?B?S2JqWWRyQ3pIU0kxQjErcUZYbEF2NnNEdElRU3FBRFpjdHIvTzhyMk45b0x1?=
 =?utf-8?B?Q2ZURG5VOWQzRlV6TlYrUFNwT3ZlMnFMVGlKczdRYlVVdTUwT0ZodW9MYkZo?=
 =?utf-8?B?OGJYYW9FNXFCRDhUdnlSR2I4VDhMTHFLUUFtS1BJZkJ3TUU1S0tzY1lZNFll?=
 =?utf-8?B?TGh2WWxpaUJFTCthbGx6RzZoSVYrQklyNU8xT3BnSFRnR0tZcHhnMjlmWm95?=
 =?utf-8?B?dVJtdklwQVo3bFBweTBCTUxHWStENzJxQjB0RnE3Y0J0SVJtOGw3Tzg0TnhV?=
 =?utf-8?B?b0V0NmdIdkw5S1dCWFcvRU1UdG5pQ0xjZkhZWDJsS0Jxd0NCZWJnT0I1SkNq?=
 =?utf-8?B?alQvcTRWL3Y1RVFVVkY1bUNkTTZOQkp6azBUVE1sU1VTaFVoU1VMZ09CV0tM?=
 =?utf-8?B?b3k4S1JtNDQ1dGVkbjRKSTNGODkwY3ArZkc3Vng5L2tRTGZNRDF3QkFKcSsx?=
 =?utf-8?B?bFJWWXdvNmFSL0g3aEhSNFhET2RzV0NyQ3RoL2VMdWduRGcyNlhxS2tqclYy?=
 =?utf-8?B?ZExvWWE4eHF3cmxuMmtuUVY4cmZNa0k2WDVaUGhTdmV4dEVqTEFBK2xZa2lB?=
 =?utf-8?Q?Rfu+poaCJ14sjPbIOo6TWhgjV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3644cf75-2035-49ad-b4e4-08ddfd1415ce
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:48:06.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psz1kozzxn0aWI1xUNDSX5HNOu6V0kmmeTX1Y7ipPdGz+X4WE+YXjWxRK1M8pouqL8+zq0C5Oi9zcA+MN4M7dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11826

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..fa81adbf9b80
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves(se) is based on the
+  messaging unit(s).
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-se-ele-hsm
+      - fsl,imx93-se-ele-hsm
+      - fsl,imx95-se-ele-hsm
+
+  mboxes:
+    items:
+      - description: mailbox phandle to send message to se firmware
+      - description: mailbox phandle to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    maxItems: 1
+
+  sram:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se-ele-hsm
+              - fsl,imx93-se-ele-hsm
+    then:
+      required:
+        - memory-region
+    else:
+      properties:
+        memory-region: false
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se-ele-hsm
+    then:
+      required:
+        - sram
+
+    else:
+      properties:
+        sram: false
+
+additionalProperties: false
+
+examples:
+  - |
+    secure-enclave {
+      compatible = "fsl,imx95-se-ele-hsm";
+      mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+      mbox-names = "tx", "rx";
+    };
+...

-- 
2.43.0


