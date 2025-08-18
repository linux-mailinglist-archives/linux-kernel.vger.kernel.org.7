Return-Path: <linux-kernel+bounces-774479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69116B2B2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A9917D630
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD86276045;
	Mon, 18 Aug 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gCKUFPhT"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B5C274FFE;
	Mon, 18 Aug 2025 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550125; cv=fail; b=SrMgfDs+zDTGKbKxgSk+/LNzwqTYRVitZb68NGgk1ySn9L+HKS2HeyN2d67bTI5d16V9Ahh20qAjjaSUQbCvsXeTZq99RAuY/Pxaw4YonVicoF/GoEOuLPGK4kxgDm1jspppIjfQL3psjZDbloNXO/eUtQpWghQUhWG0iB0tubE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550125; c=relaxed/simple;
	bh=A8krjfkRDvvQqFV3VrEJ4cHrPO3IFEpJh+WXRK9VUV4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p/rSYYtBgEr/C6AfrDzuRnm5duXX4ndLTSeO8h2QhCgHp2+5V31YXMoWlSaY4BwikiZ+3yY67QnoxgEsqk+lnXr9CdFuX3ub2BKjB+NstrGCGY2VSnjZMZG6ykT96D6wbkFlfGc9bAOHv5Tust2SA9j+SlQe2tTUp8Tg7EhdkME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gCKUFPhT; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yes+VaKgR+I6FH/qmCcP87DZNCFRqDWZdhfILxIgOxgca3Yqu8nEvtdK9e7THaHAPH3oLlb1Np5+I0zguN+gRCdkOTjc6becYOxf7k5piRaOlixcGjJEHANBMJmsqbt5DL2vLHY0aw3fPaKWp2kBvFMQIPcBF/4fsVg3XlxysgMtzKnKbk8sM/jJd8qW2f0SfpfbtmYuc0+IVERez7kj/Ccc1CRXED98qVV9okKFhWmb75YdV1Pz7gS8aqSNsAAewcYQV2GW5BJZCe6ArL0riQ4+DTu+npj9NkChwVX6dg1zf7XJcyRrG+rVP7ZTliizerJ0OIkS1E/7/diHzr8+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80FQscyifUiyxoEFdxRgwYcp+5Noi74ds6jELDrSNAY=;
 b=cUralP1dxC2z1sLxDKr1v6UegoJDFTw46iq3FJ5rElOD4GIWTP97AovjgVu7x2HDtRs2nAu5beo4h36GmdRLfj4V7YHFltC+lhBmkaD8J5EkViIYYHk0bTKPy4XgSk0H+61aWxILHkR7p0MDdy8VkyjRcFc33CRwsFWj89DbOxVeY3sM/i+ua7zGYLg0Dz+RoygTvZdmb5PsT4hNFcPddRJHvw23XoqXWM2vGge9iGZ0H9i8y2SIThi6Sai+sr7441avt22c+ZkMpUOlSPFn3eg+nFJtNNRMN9uImrBanPaS/MSJa0ZmTOPWEYpmDdnrJeqXeCSTTdqWr7XLo1jdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80FQscyifUiyxoEFdxRgwYcp+5Noi74ds6jELDrSNAY=;
 b=gCKUFPhT8H3RoHU4Plui12Y0Mv12PwK04ShD6+mU2yapzTw3gXU8H70EaT8tXAm6naEg68RR49ZEXT4Tj1jxh/1w2UpJe2dYyZkw0xoAGvlbDUYYU0po+3chJST7O8WISvwEp7I0WMe+KNq17xpmfQ4F4OvFrnzgaxR3zZCfGiit/te15fROmAOdqxSf44wk4vAA6yBamDZDA6DoJ7VtZNtCOSDI/rIh2/kXgybNgT4G/J2R7oQR1OQMlK0ZbBKdSloidMdFW+GU8myUgfWPmqICeOKZwWLO7xP/q5r7MVwM0BlAD6mdIuOuvincwE+EFSvDU1c9Q5NxqbGhHPciuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9009.eurprd04.prod.outlook.com (2603:10a6:20b:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:17 -0400
Subject: [PATCH 06/15] ARM: dts: ls1021a: Remove redundant #address-cells
 for queue-group@* of fsl,etsec2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-6-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=2412;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=A8krjfkRDvvQqFV3VrEJ4cHrPO3IFEpJh+WXRK9VUV4=;
 b=zVr4UT+26h1HVJMOTT+mox3gDF1jAmdxu/6cZ2iO/ck40JgMun0AoOP6tJBz+qZ4UCrcHDlxB
 4rHBul/kI0MAQ8kBvcyvNzSwNBHwrkY/GtUXWWr0M4Y23Jg7NuwqpXy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c9abc0-178e-4a8d-7aca-08ddde989c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGtyZEVLRERnQnY1L09DckZia1lScG5qSTNvTHp2Y1cyYnV5Vkp0NlJyQlQ4?=
 =?utf-8?B?VExwOTdnQVJHaHR1TitHZldCQ05NRVZMNGx2azN5WmVzNVJhSVdFNEpyMnBN?=
 =?utf-8?B?Vi9Yb3ZoeXYxUlhDTkxaL1VxS25aM2E1WWlrVFFhMm9aWFM0Sk8xL2VsSlZi?=
 =?utf-8?B?NzFTcDR0TkNmeGpFR24vM1lvZkFOWjIvbVNLL3VvSGFpc3kzWkdDMVg0RWRV?=
 =?utf-8?B?ZnFkc1cwTklOWnJWUVYzUW0vNDdoVzI2TjZvbERzZ01HV3VYL2pvalFFNW12?=
 =?utf-8?B?dEsrbWdFMFdneXJ6eW42N2k5cWxxN291ek1YTXZUeURTcVNmZ2wyTXVuRUxp?=
 =?utf-8?B?akFEcXpaM3U4TE9LOVN2bktYWXhMaVZnN0FFYTQ3OEJUWWQ2Q1JlNGRhOFdo?=
 =?utf-8?B?OUJmSkMzdEN4dGRXcENCRlVYRW9HUEwzdUE1VFdFdTA2eU9wVkp2N3FvT21Q?=
 =?utf-8?B?Zk1yTzhJRG03WFhFU2lPY3VXdlRUWnU4YzRYZFlqVFBGcVJkdm4xeEtuZFRZ?=
 =?utf-8?B?aU1HNFZPWGdlKzNNeDdDMklSK2UrMUlqcEh5ajVYWHNkbWdGVTJVd0RjR1Vs?=
 =?utf-8?B?Rm5DY3dLSStxRjI2ZnlXdWFVQW5RUXFzbmxxY3ZqS0lTMVNSRXE0ak9HYktn?=
 =?utf-8?B?dlpCeERqb3dEYmJEYjllTHROb3lkcTkzYnFlM2FKaGNrdllrcFNVcTVWc2Ro?=
 =?utf-8?B?aE1JMnhOZGQrL3VVaDJNalo5enNZZVR5WTlYYTB3eWZ0UUdWSCs4N2JDTTlN?=
 =?utf-8?B?M2JISUd4TWg1bC9vWDYxRVIzaTN5d3QwTWl0UWtseEpma3VxV3BzQmwrV0ZO?=
 =?utf-8?B?V3RnOExpUEhrekY1cStENE5LaXlwWkk3TmpPcnRqK2pTaVoyNGxqVVF1V3Yw?=
 =?utf-8?B?SVBFRm52ZllPZm1BWmlWOGJybWtzTXVSTGZ1K25KUGltdEZnQ2ZnNDFVR0hL?=
 =?utf-8?B?MHFpMEp1eEpoK25XNlFkRTdSbjZpZi9ZUklpL3ZyNTRXV2tLZFFpNXY5Y2V4?=
 =?utf-8?B?M2ErcUh4Mit0Nko4cWZoT2o3QVNwUFY5WVdoZHZ3aEcxSzlYejFLbjYrL3l3?=
 =?utf-8?B?RzFYME5pZ3VFTjZjRmNPRVNuVUM2bkI0QTRaZXJQcGFDN1lKOWNRT1ZpTDZX?=
 =?utf-8?B?QjQyK3I5R2ovSTdsU1Q1SWlySmhNdko5bWU1UWhlMFdLcDZPL2luU1dONC9H?=
 =?utf-8?B?dkZldVczcytZQXRPaEErZUdnYnVZRTZKSTVkRThvUzhsU2Qzam9EQ3lIQWpN?=
 =?utf-8?B?bXNDQXhmZTdSRVM3MmhIbUtuSE1LVVdoSUp6a2t2THBodkh2SEREQklTOHNX?=
 =?utf-8?B?OU5YRTRodkpjaGtURFFBamIrVjU2YnZMaHY3aHk1OVZaR2JmZEc3anA2Zkp5?=
 =?utf-8?B?SDg2Q2NSbTBkTHFILzJJZWR1L2tpenlRS1pPZElKZVVmSWMwb2tUb1J1TW8z?=
 =?utf-8?B?b084cFh4TnY3bjlLam94T3lmcmVVSUUxV2hwQUR6OFoxVU4xeWFmUUZsNS94?=
 =?utf-8?B?cmJLY0hTQXJvemlwZndKRmtxUGxVVldPeXFaNldLWEdYM0doWXE0QnFzd1A5?=
 =?utf-8?B?NzV1c2NGNzBlVVF1cWdWU0ZYa3pBYzg2cjZmM3U0b2VwQk1aM1YzQ0VYMnpM?=
 =?utf-8?B?cGNySkNQeFdJMVNZODFFUUlkOWRGODkzcVpNQlcyNDAvYnRVcVlwME9LcU82?=
 =?utf-8?B?VWhiQkUvUGVnbEwxcFZZUzdPUm5HVm5zNGFCVzF1NkZUQ3dhaHIvdFZ2d3dY?=
 =?utf-8?B?Z1oyTSswbzViQVpNQjlqMnJlYm5yMU1KYW5NZHd5OUxibm04S0hXSXFTb2dK?=
 =?utf-8?B?MUk3cEU2UUhpeDl3d2hIMzlXcHNmZER2ek84U0tyY3FaMFM2eSt5OG5aK3Zs?=
 =?utf-8?B?bHZVeE45YUl0OGx2SHd6Rk0rN0c4dG1OaHFOUVdUOEhMcENPOHc2YmpwRjgx?=
 =?utf-8?B?WGVBVnl2Mlo2QmtmWE5UcG9PdjRQL1NCTXVLYlhoQUlZUjdEalM5MVhUblZl?=
 =?utf-8?B?ODZ0aVg0cWZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekVWdzg3VFdhVTFVSjR0djZHa2JuWXpQS1NCMmJuOWFPb2Z0aXNKb2JpT0sx?=
 =?utf-8?B?MVhsQTJaU1dvRDkvUm91SUZqQzZzaW9WdUVaUVFFSmVtalZURmFHL01pOFRz?=
 =?utf-8?B?Nk1JbVJ1amdITW5UQXRiMWpOL0lTaENGZVVqZGRydjBmNkRkTmwyc2cxeGlC?=
 =?utf-8?B?dzVRRmF6cVgvSmtleGRFOU1ETEdmR0xRVVpyb3NSd0FLTE03OU4vc3ZuS21X?=
 =?utf-8?B?OHd3cTBQVVpmcnJiRk5FVmJST1B0YzJiZFZuU1pkaGpBWTNyanBwVUJRTW1h?=
 =?utf-8?B?SVczTHVHK3RFc3E3V2lyWlNHRWJxQzFoZE5UcEVNRlE1aU9VcWdvM0dUWnc0?=
 =?utf-8?B?QUppdFJ6YXB0TWoyY1o5Z3daZjR0WmpzUm5CbVlobmV1YmZHMjI5L1lLYXEy?=
 =?utf-8?B?Q1J0ekFGM0FHMUFQeko1eFZKRzVjQ2w3aUMyUjV0RFE0NUx5VjJGV3R5Unlt?=
 =?utf-8?B?Zk9xeVp6OWlBTTdFUlYybzVhMWtIWllIblNlZXp5WTk5M0UxM3FGMXUwaWx6?=
 =?utf-8?B?dWl4NUVJRmVHOWc0bHhhcWtSczJ5eTJJS3hudXZIYmZDQ2xuWmdkTmhMMEFk?=
 =?utf-8?B?ckNQTU5QdE1jSUlydWJSN2Z2eEF1b3FpY0tVQzc4SkoyV1lad1JYdkRuQ3ps?=
 =?utf-8?B?aXpHQ01EUVRRM2p5am5aTFpIOHg3aWxSQUZlSmpMZlN4MmZPbk1mc3I3QlhN?=
 =?utf-8?B?WnVTUFZ5cHJoZk56azR1NmR5WXhjVSsvbldCZ3dpR2FjTDRCTEM1dGx1RjNL?=
 =?utf-8?B?VnloU0NPcHlONWNVckN6Rjg2NnRwR2VPVlZxbmsyenYxa294N0NnZTdSUEc3?=
 =?utf-8?B?cmZjZVZ2M0E5eXFlWEdKMTV4Qzg5YUdYQUhXemJ5TitCNEhEVUNoTWdZYUhH?=
 =?utf-8?B?cDNCWVVqaE15b0krUGZsU0RxZ09ZVWJ6dzhlbDZQOHQ2WVAvK3ptL1lWaG1a?=
 =?utf-8?B?Q0dqM0JJaTlobDJhMGNWRFJQOUdpV2tMeWdLdkhnejNBNXd0eFhwS1ZSQngy?=
 =?utf-8?B?c1MxSURLdkF3S01uWlRtNSs2OFptekdCbVJPRU91eElHa0c4NGxpV2xlSDNW?=
 =?utf-8?B?cjZOS0pvQ1lYWldFMHlyRFNFNTRBOFpCeE52Nm14RGQyKzBHaFZNT3BkeE5Q?=
 =?utf-8?B?WWxkMy9LNWQrK0pMaXN5NmpiY3Z4cHdiTjJmSFF3N1hrV0c3Qm84R2hhY2FH?=
 =?utf-8?B?QTdoQWk2Mkp1SnRpUm5UYmpWNWR0UTQycG5yWWNsNUxWUlR0VHk2UG42NDZP?=
 =?utf-8?B?Y2VWSkZwOEp6M2lvdHhTd3ZEZXJSNktWNWV1Z2Q0UXNyQUV0UWlRbEtFM0w3?=
 =?utf-8?B?QXNnZ2QvRnVNeVZnMTUrUkVvdG9lQklDY0Z2Ymt6a295L1VFZXpad3A0U25j?=
 =?utf-8?B?Uk4ybk5wZmltNXczSVFTK1luMG5ZQWlMY2pybTFaeVNydEhRRnlQMlpMWmRi?=
 =?utf-8?B?L2orWkdnSWVicWJCaWtOSkpMaFVBN0QrYkJOT1lacFltQmltMkJpQnN4cjNC?=
 =?utf-8?B?NWJReUFnT2JIVWdSeFI1aTFiRXBnSUJVcGY1aXdyZXpxRjRnd1YvVUVRT2h0?=
 =?utf-8?B?a1dXL01XWXFVSlNYN3B6Rlk4c3FBWis3eUZnQytTM2puY0h2L3p1bDZJajJ5?=
 =?utf-8?B?M2MzRXVYKzRnNlpyZHp5YTZCWWVNMFI2TlB6TitlNU45MHhxYVpsYlQwcVBV?=
 =?utf-8?B?Q01KY0MzN1hKZlRsQVBCOXRaUG9zVjd5QkpHQUwycndIMGp2SnR0YW1MYWJk?=
 =?utf-8?B?Y3A5dWFROWMvY3RUZml5KzdTb2NsWUd6ZnBNNjcvSW1jaUFYVlkwcEt2VXhX?=
 =?utf-8?B?TThCTmJlMUtjUmVET3draEZEN3ZWK202TTRjNUg5L3dnNTJVKy9DU2ZSUVdT?=
 =?utf-8?B?a2Z6UUttT3JoOHNsU2tYT0xENFNoU1VDOVI1TUhEY284d1hjaTRLQUdYc2l3?=
 =?utf-8?B?UlBLeUI3MFlub0EwQUJ3QWhWOW8zdnBja3lRZ0M0ZEc4TUxWN2dIWWlqN1FM?=
 =?utf-8?B?eEs3cjEzWnYxQ2MvVEZBdkgvcEtpZGtITGt5R1ZDUklxSlcwa2JyWTdkMXFo?=
 =?utf-8?B?WmhJQlFCV3o2cFl6RHZTbjJFM1UrOG93eFZyTzB4S1dFK056dzNHZ2ozZHJj?=
 =?utf-8?Q?nmy/W0ld1kYkPyXQM8d4Ixwlz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c9abc0-178e-4a8d-7aca-08ddde989c33
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:39.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZrsoeWCh4o3NWf+I20iiIlqJI1ADZpruCX2a0ll8ihIk2xrajgnOsuj0C8d59rZooSk4XXPRIfQLJM33UKlvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9009

Remove redundant #address-cells and @size-cells for queue-group@* of
fsl,etsec2 nodes. Fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: ethernet@2d50000 (fsl,etsec2): queue-group@2d50000: '#address-cells', '#size-cells' do not match any of the regexes: '^pinctrl-[0-9]+$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index a4c16833dff0f33d0093a7d1575a9c67c94aa1af..d095c6107745d75b108a430a5eb15e4f2511e81f 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -716,8 +716,6 @@ enet0: ethernet@2d10000 {
 			dma-coherent;
 
 			queue-group@2d10000 {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d10000 0x0 0x1000>;
 				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
@@ -725,8 +723,6 @@ queue-group@2d10000 {
 			};
 
 			queue-group@2d14000  {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d14000 0x0 0x1000>;
 				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
@@ -745,8 +741,6 @@ enet1: ethernet@2d50000 {
 			dma-coherent;
 
 			queue-group@2d50000  {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d50000 0x0 0x1000>;
 				interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
@@ -754,8 +748,6 @@ queue-group@2d50000  {
 			};
 
 			queue-group@2d54000  {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d54000 0x0 0x1000>;
 				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
@@ -774,8 +766,6 @@ enet2: ethernet@2d90000 {
 			dma-coherent;
 
 			queue-group@2d90000  {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d90000 0x0 0x1000>;
 				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
@@ -783,8 +773,6 @@ queue-group@2d90000  {
 			};
 
 			queue-group@2d94000  {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d94000 0x0 0x1000>;
 				interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.34.1


