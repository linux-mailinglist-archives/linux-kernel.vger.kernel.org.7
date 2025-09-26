Return-Path: <linux-kernel+bounces-834526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2025BA4DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729517402BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2873090FB;
	Fri, 26 Sep 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NyEiCtCc"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30781494A8;
	Fri, 26 Sep 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910736; cv=fail; b=ENMj/gJhs+m9bl9eXvllVXGFVfrjVSpYrcYAxsEfhnaKIV12kDk33KK14EDFvjl1QO8BMJFtNEHH5zrNWnZbe877vg2+dqZQbmKhkIsMd9fWGYWZ7mPyp1pKNCdGBXwThVzMgBDEfuYKxMcmdu/I7TxN2Rn26ifKZeDvY4IedLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910736; c=relaxed/simple;
	bh=0CgND4WO16EtwUc3Nse3AAY8I+x8THVa8IhQIsivJLs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=aK5LAwz8wgmVf8W+bXfG1DOZCkkVOIHJSUJgiFSc1wtBXr2+bFo4pePybpZgurq02i4svHCziFOw3gDzLCBZLwrnToiDU8aaMBKxNQXDA8Mm6ooDh15Yb3ucS2cfnhnrFLZU/qIMqdHJeZHLU+Uq47/7GHLQJgI3uDCqX7gInuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NyEiCtCc; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CccOkAFp0ua8hJTJFSos7+sBL3qSjXbcWTJoe6UD9H+9OBsdRPNFUWjleEHpBv6B8ZfqQDlvtQRgbzmyToGq3qvJVcjSDnASJIBKirWbsy/Tmv1QR+fTINzUtvV4CpdjmV22AZmZm3dBbD9p0Q26+SqmVx+GQzv798AM/U5LOI0z8RSUGjx2Nj4lVSpnuxSYP1954debDs3EQiNPjggsofP7iHQP2JyWMob7TUXIIM9UJOR0goueO+v8Czr7UU/iRk0iPfiABWzS0fKgd6kdMUzI+4G49AN0637OSztjlgPKTQZ/ACEc6QwqL709W3nYQWrvyX9vdy+FSJ5ESsd03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYZfr//Bfqxv9oWEwbXnSHi/jHGgfXUjP7T38Ql0LCY=;
 b=dl864UGWsBjI4yBVfKxP30UmF8PPSOuqcW9m4TFcgKWkCRy8tE27fW7MMwwznfwXpnngigTdxEaWZ1Gh4mrENUMXRSehKhTq+WbPDWGZ1NvmnkIl2wPQFFtD+5ae0yHjC/s2WXrNLM7bwr4YRbnWDNhgZyfGpYxqMnvbP8r57K4iKI0eoxKjb9Cw1qhI71D99FQiO6ISgWRxCod54jh0/KopanbHTV8+elSO/vwkZIY8qHvHUDEmWNZ+2hj7nz9SB+6UlYQL55j3NdMHQdH5Ueh0nSR7rhF2d+7DrgL3hPPLQ90X54o0ylTc7/KVCxAMrp1GmTxpOcB2eYHjAm25QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYZfr//Bfqxv9oWEwbXnSHi/jHGgfXUjP7T38Ql0LCY=;
 b=NyEiCtCcbrxVFe333iyfDjPviK3QDYFeCf6MlEGjmEJHU/7rwabbYWDDMqQ/Cufcqy1isvZWrsIwz7AUfv0pZ3i0pzv8fvx40VX33IIG9G6BCNAkEtemHma/vcfbxxUpkZI1bY/mvg1rMKYLR0DwV6L4sljRT3Vq0s5hTAVfhAQ7YczyCyGr+l8mzWrD2pxwESt5CuXGRws7YOYmVpwH/3banytEKY1igwun6kjXVZzZjekmZVSPKfUYRty/U/KKc3gR/9TsbbpXa1cX1JZFCJ3u2hJDE9ggopyKdJrehjaFnvp3GSj4tHrKEsh5XvcYY0F2g36g1LO7Z4rxxL91ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB11686.eurprd04.prod.outlook.com (2603:10a6:150:2c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 18:18:49 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 18:18:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/4] usb: dwc3: add layerscape platform driver use
 flatten dwc3 core
Date: Fri, 26 Sep 2025 14:17:43 -0400
Message-Id: <20250926-ls_dma_coherence-v4-0-fa2b92781e5e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjY1mgC/33OQQqDMBAF0KtI1k2JiR1rV71HKWImYw3UKEkRi
 3j3Rje1IF3+gff/TCyQtxTYJZmYp8EG27kYskPCsKncg7g1MTMp5EmAkPwZStNWJXYNeXJIHBV
 KDXVeGC1ZZL2n2o5r5e0ec2PDq/PvdWFIl+ufsiHlgiPk2TkzUGnIrm7sj9i1bKka5JcXUu1wu
 XBSaQ6qAG30L1dbDjtcRR7/0ikKJNCb9XmeP6x5Tm0sAQAA
X-Change-ID: 20250602-ls_dma_coherence-c3c2b6f79db2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758910702; l=3727;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0CgND4WO16EtwUc3Nse3AAY8I+x8THVa8IhQIsivJLs=;
 b=5fIJqbdy8/HD9pDm9zi6cN2XL2eFZ/UpVVJVWPM2FqLB5WHTtAAkQFw5xCrlx1YN7EgsyTYx5
 EVvhc0nx3vOCKVcUZOQpoz1HudaQODACqD+5uEqu+Vi68nMI/OB+VdL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB11686:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fc3511-b7e1-41ee-6588-08ddfd291664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1J6dG1BenFwVERYYXZFbDJOQ3d5WnlkckhKUkZIT2lvRzZvdXdEVDVyL3VE?=
 =?utf-8?B?UFcvckRMY2FmWUkyTnQ2cGxSdFBqYnlUS1JJTVdycFNDUmJ3ZS9wMG1LRUFZ?=
 =?utf-8?B?QXZBWHZQRGo5LzFxQnN6QnV4Q0doZC8rZlBKTHJUQk1tR05aSlhsWHV0REpk?=
 =?utf-8?B?RHZheitEMW9haGt2OVlvWndxY1lwbWNoK093bDJoT2pETG14QzE1S3dBNUJF?=
 =?utf-8?B?SkxwejZnMjFtV2poelowQ21ZdUV1eS8zVHNSZWUrZFdKL0Z3L0poYVozaFRi?=
 =?utf-8?B?c3dMRDFKdHR4eEFkaWFsTmxpeXNsS0N1cWt6L0dwT3Y3c05mVHFoZkpxckpM?=
 =?utf-8?B?UEVpVWxuWFN2OHF2WXBSS05CcFRkRXVqZ2d3ajRNRWlhbVczdHptYTlZZWFK?=
 =?utf-8?B?N0JSRTh3Q3dnNXFHTGF0RWt1OHUxQ1VYWExGQTFhU3dEM2ZEaU9tZTR4QUJC?=
 =?utf-8?B?a0NnM25Dc3N1cFc2OUt4UnJPRWdmYTZzekRsMXh0d2FxNGVNeHJ1bkpXUTV2?=
 =?utf-8?B?VlFNYlQwaUxIRnB3bEdYS3B6Vm8rSzVqZndFdFZMVUdIS2I0Wkd3dGgxNEVW?=
 =?utf-8?B?akovcjFPUzdrZzFlb1hpaWNnd3p4MXNONXVTVXlZbUVzclpnbUl5MFluaEJq?=
 =?utf-8?B?Zm41c2N6Z2ZQemNtalRZQkFNcUdubHNZc3hodWlZOEs5anBjc05NN3V6TTJS?=
 =?utf-8?B?Z3dzQ0JVWkd5N2FiQ0pnRUNtbS9rQU8yaUhBNzZDNTdmb3RnZGNEd1BPVksx?=
 =?utf-8?B?QUxYc1N4N3A1c2dWMGVIZlhwUzBxZ0h0VzlyYkNRcFgyUTJDYW5HakRuVVhQ?=
 =?utf-8?B?WU84Y2VCTENhMDBLbW5WMTFLZSs4SGswU3RPQktsbGJnOS9rN2hZOTVqR3lG?=
 =?utf-8?B?eDMzT0Jsa1l0Ymlqa1VlekFmNU01UGJEVnlDdXlsTXF0eFZaZHFZMzBKakxW?=
 =?utf-8?B?eW9OS0diN2hPTzVXYzZvWHpEdmV1bFB5S1NRTDNLSkplRExIV2pMMWxzZkc5?=
 =?utf-8?B?YVZaQ3M1Y01tWVJiZXlJVmx1RWpHZEcxaDc5OWJaYm9yQ0V2cWR3TzVIUXRu?=
 =?utf-8?B?L09IZEhqempwUnMyUk1od1ZpTUhKYmd0N256U3dSczF2VVkzMFc0STB1a3oz?=
 =?utf-8?B?ak1LcGRnc1IrcXZGTi9qdTF6VTdUNEdFK0F5TmswYXUxMzBmajVtcGhtSW53?=
 =?utf-8?B?OWI5ck1VZ2lNSzRVbFRNWG93YWtiVll6STJDT20xRlM0RncySEc3R2N4OXh4?=
 =?utf-8?B?Sk1IZDJBVE5USzlKaldmaDVSL1ZtUzVOTVlYVXJtMHdxeG9lVERSQ0lsdFZK?=
 =?utf-8?B?YUdwZTlpVDlSK0FiV0lZeWg4V3VYTVhNcW93QVE3SStSNElRR0RZOG95c2c5?=
 =?utf-8?B?OHJWanJXUGFGdlkvdFZpY3JlblFlRHBsa1YwTVlLc2FNczEvQXR4aFUvekZq?=
 =?utf-8?B?OTllaVdVYlNoSU9SN004K3dGZFdTbTFabUI0bjVJa2F1c1NQZDA5N1FyVWVo?=
 =?utf-8?B?ZHQwWEovUklMZW1BOW9oRXEwRzV6bVRiNi9ONVYxOEQxUUF4c1REcFJUZmQv?=
 =?utf-8?B?aHR3cmJFdmFFeHhRUVM3L2VXUHdiVEtOYTFWUlNCUGFmc1Q3WlhIOTJvZmhw?=
 =?utf-8?B?MDNnZUFxdDJLcEtwTXN2R3lHeW9uaHpnWWlwK3lPcWRZN1packZmQWlYcFVB?=
 =?utf-8?B?d2dxc2FkS29STHZFbGQ5dXdtdDFwSElIU0VWQTA1bC9YemNaMzgxUHVtN21u?=
 =?utf-8?B?dEtLUFQ0S1pDcnF5aWFjUFFUOHRGdzV2b3lZSE92RTBKNVg0djloTklYRTBK?=
 =?utf-8?B?SnhQS0J4elFycm1ZUHBKeVNmOXZxWTFxbElFMlJRNUhQakkwdjRxa2NPSWpo?=
 =?utf-8?B?OCttWUIrRVRTVmRzNHlMeHlJRW11UmhKcFJaOVFJN040RXlUT1hnUmkzNVla?=
 =?utf-8?B?STR2UVg4UnhRZ20wdm5HYVowcmJQZDJpUG9GMlNGRWM4bWtkaitFVkhKNFRL?=
 =?utf-8?B?d0NzS2JsNVJKdUsrOE83WTI5TGZRNXVxUmsxUk5VQmdsTmhjVENyY0lJRXE5?=
 =?utf-8?Q?EXFgqk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0tRaGwvVmhGbzJ0MmVsWHhRRFdoaU1jMGpucjZzWXJpRnJlNCtHNUhkMTAv?=
 =?utf-8?B?Y2Rvc1BHc1VrbzMxb1kzSzBzUWpaZTZVaUtNNm5HbHRFTTV3OEJNYXF0RTZ1?=
 =?utf-8?B?QVFhZnA0RmhXeHFPUlVmZkNRakNqK1h2MnJ5QVVhbTk1QjQxWklyMmoyWEJW?=
 =?utf-8?B?SlBHbFBhMnc2UHBydGMzNnNBYjRLTjBjN3RGNkk1TVE2YzM5UEg1L3habU42?=
 =?utf-8?B?NjByRVQ1NEV3OWxWS2pFT1lHSUFLcFVIYlJzV0xpQTlnK2tXeVZ3elpVUzZP?=
 =?utf-8?B?N2xaUUwyZVQ0RVl4TFdtN3Z0RDd2NTZUZUN5N3JObVV4ZjRKeFJkRmlPWEpS?=
 =?utf-8?B?Wnp2b0M2ZUpTU2lxTzRwdllwV2NKdFZPL3FNRTZGMkx5K0QrdkFha3UvR1NH?=
 =?utf-8?B?Tk8zUi93TnhWZFRDbXB2SFo1cDNNUzRuOU1EMmFJMTh6cWxBbHRJVHloL0s0?=
 =?utf-8?B?WXBiV1hKMnU0alJJbFZqS2MzVVlRTEd1bGpWWkZob1RHaHp1ejJHNnorS0tv?=
 =?utf-8?B?bHNlRURCVTRZT3hLUnFjM3BUOWFYWHA2MjVocHpzSXZkOUx4MjVXOUpYc1NF?=
 =?utf-8?B?cDhVRHR5SG1hZFFoVTk2UmRDdFN1bE0vKzU4UmZaQjZsU2RBZk5hUHVaYXR4?=
 =?utf-8?B?L3JYZ2pMY3RvR29UNkZaOXkwa2c1NXpwYi9uSU5YWE5LclhTUlpGLythZVZk?=
 =?utf-8?B?VWtWRldycnhxbE1HeG9ZMW9aUGVvd0xsQnF5QnhVMUc4SnR4dE1NOVBMczRx?=
 =?utf-8?B?bStNek9GampLemV2TWhZeFFZLzFpVnZTY0VoYzRvamh5cFF1Qk10dFY5YWlZ?=
 =?utf-8?B?YzVFdjZWelBzWnNqODQ2d3lFaEg2KzFvZlJSOUs4cEZFYjd5MzlFZ0UzTVEv?=
 =?utf-8?B?TXJ4akNndHdObFpYU3JPWXBXRjk3VldNMHlHVmY4SllOZEJhcmw1UytZT1Vi?=
 =?utf-8?B?akNxTG5KTG1VbmYzd2xKVDFITTUzcEYzZ0NhbVhLMm1FUmxvb1pRUHlmVlc3?=
 =?utf-8?B?REJTdTFFQ1J4bDE1b1dpY1lsQ1BIRVBiMWx2Wm9DUU4yNDJzeHpOcXo3em5x?=
 =?utf-8?B?cGZLVzgwSXA1ckZHWXhDeWYwMUZvR0FIN1JJeGs4UmFNN045UDlKL3dZeHBF?=
 =?utf-8?B?U0N4d0VXZUR6Q2grc0xwM0ZpL2VsZWp6dEMzZ2g1b1EvMWZsMUlEdmpUOHdx?=
 =?utf-8?B?OVVBNjBwaUxjVkdDWW4rbUsrRGxxTU9teCs3eFAxdCtDV1QxRlg2RXZHVSsw?=
 =?utf-8?B?Q1pJenFZK3NiKzY1WEVXV3ZadjZMdC9TSmdLNERmaVI3SFUzdms1ZzJzZGJN?=
 =?utf-8?B?WG1kS2hVcUhsRWZuSlRLK2c1dnBjOE5hUTBDL2JpbFpYNEVxTDFhMG5MUWJQ?=
 =?utf-8?B?UlB6ZXFFajAwcDViaG1KNEFyK1E3N3BMMFJBT1VBVmVINTI2RWJURk5PdDBR?=
 =?utf-8?B?M3Z2czIwU3daR3hFanBtUmg3RGNNbWErODllWEl5cGhLYzF1YUpycUtQVHpC?=
 =?utf-8?B?S0tkTGRIZm5MVEZMME9pSk13NnV0dzV4N2xTZm9yTXdNTTlUelFrNmFlRnJ4?=
 =?utf-8?B?RS85czB2aTNYaVJkUVNVVmdPSVJucmxWdlB0bnJmVTdoeDlKdjVCWUZCZ2NC?=
 =?utf-8?B?ZjVTOWd6WmpCMXQxMDY3aDVCMHBEV0lYMFVjeVJMSXBIOVJLNEJTVUlGMFUz?=
 =?utf-8?B?d3hjcWdnbDFwenBvRVY0cTVvdVppSnJnTmdZYnVmd05ydHFKT2hKa2RiZzhl?=
 =?utf-8?B?M2I5Y3F1aUtYZ2g4NUZUWm5tWVlWZlRyMG5ySUUxOTRnZmJybUZWTHVlSzRs?=
 =?utf-8?B?KzFLYlVNaDdRT20vMHRKdXphYzUyNXMzTU1OZjdxZS9LSUY2dWNTMjliNklJ?=
 =?utf-8?B?cXoySUx6dFdWSmc2SnhjdCtjVnFQQ1VSSjBPdjlNT011VDFQOW9hdWJRR2RI?=
 =?utf-8?B?OVpvNzdXNHh0cWpiQzNyTTZoaG52bDVBbUtaakhrVjRPRzBTa2kwVmlHUk1h?=
 =?utf-8?B?NjkvZ2VCaDUvQ25YQnBKbUNLcVpMOVFKM2E0YUdsWXR4VkJuS2RwTC9nVlpN?=
 =?utf-8?B?N2FiWTRIMWRMbUNLK2hUN2FzMkt1d0o1OXN1REIzbDBqRnNLMXIra01iaC9s?=
 =?utf-8?Q?JF8ahPGif7s4nIzMAoLDI+LWe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fc3511-b7e1-41ee-6588-08ddfd291664
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:18:49.1485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SusCnIS0/G4QmRHQGrzoeTh1vm+JLdE7lOMPXwuoacwcqB/kXGMXuOIQnhqYHUWklrPch/a44CN3+T6MHJxsJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11686

Add layerscape platform driver use flatten dwc3 core to enable dma-coherence.
It needs set gsburstcfg0 to 0x2222.

There are some several try before:
[1] https://lore.kernel.org/imx/20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com/
[2] https://lore.kernel.org/imx/20240123170206.3702413-1-Frank.Li@nxp.com/

[2]: add new property, which was reject because there are no varience in
the soc. Fortunately the below commit resolve this problem by use software
managed property.

d504bfa6cfd1a usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller

[1] was reject because there are not actually dwc wrap at layerscape
platform. Fortunately Bjorn Andersson's below patch to make it possible
by use correct dts dwc3 node layer out.

613a2e655d4dc usb: dwc3: core: Expose core driver as library

This resolve problem [1] and [2] by use flatten dwc3 core library.

1. add soc specific compatible string at dt-binding.
2. create platform driver for layerscape chips and pass down gsbuscfg0 if
dma-coherence enabled.
3. update layerscape dts files.

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: bjorn.andersson@oss.qualcomm.com
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Use flatten properties, instead of use dt pass down information to core.
- Link to v3: https://lore.kernel.org/r/20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com

Changes in v3:
- skipped, accident sendout
- Link to v2: https://lore.kernel.org/r/20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com

Changes in v2:
- base on drivers/usb/dwc3/dwc3-generic-plat.c

commit e0b6dc00c701e600e655417aab1e100b73de821a
Author: Ze Huang <huang.ze@linux.dev>
Date:   Sat Sep 13 00:53:48 2025 +0800

    usb: dwc3: add generic driver to support flattened

    To support flattened dwc3 dt model and drop the glue layer, introduce the
    `dwc3-generic` driver. This enables direct binding of the DWC3 core driver
    and offers an alternative to the existing glue driver `dwc3-of-simple`.

- Link to v1: https://lore.kernel.org/r/20250602-ls_dma_coherence-v1-0-c67484d6ab64@nxp.com

---
Frank Li (4):
      dt-bindings: usb: add missed compatible string for arm64 layerscape
      usb: dwc3: Add software-managed properties for flattened model
      usb: dwc3: dwc3-generic-plat: Add layerscape dwc3 support
      arm64: dts: layerscape: add dma-coherent for usb node

 .../devicetree/bindings/usb/fsl,ls1028a.yaml       | 33 ++++++++++++----------
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  8 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  9 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  9 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  8 ++++--
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  8 ++++--
 drivers/usb/dwc3/core.c                            | 12 ++++++--
 drivers/usb/dwc3/dwc3-generic-plat.c               | 14 +++++++++
 drivers/usb/dwc3/dwc3-qcom.c                       |  1 +
 drivers/usb/dwc3/glue.h                            | 14 +++++++++
 11 files changed, 89 insertions(+), 30 deletions(-)
---
base-commit: c45d2c21b3889c520bf141d576eaecb25666895c
change-id: 20250602-ls_dma_coherence-c3c2b6f79db2

Best regards,
--
Frank Li <Frank.Li@nxp.com>


