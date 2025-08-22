Return-Path: <linux-kernel+bounces-781285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A66B31084
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F164C1CE312D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6A2E764D;
	Fri, 22 Aug 2025 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b="tfT2hSty"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023078.outbound.protection.outlook.com [52.101.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984B393DE4;
	Fri, 22 Aug 2025 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847997; cv=fail; b=lOn2mlBbctGhKO+8UM7bCNG/iRuePC5zxZ6NPmYsyGWK9Gvd7pi7Q4UQViLOCJfA5YZZb5g9babXdzqL9yJ6WI6JY6+Qn+aHcY4pBAHfoEnPLEg/pK7tNY+ZntkLhxHci/Nced9XGSQ7HvzeTcuJ5sTN/pxTvlPa2sDtq3TWrB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847997; c=relaxed/simple;
	bh=E8tbcirx+xj1hC/GOxtriVw6He7agO59iFWxEZJkRzI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=tZkCEqZ0FHH7pV/b7qv7/a2qAbYaGcmky0OuWveNDlkNOQPbaE1NWVpAVJG4HihI2UcvDxlSP1rJvL23kQy6igrlTHID9EaTkEIvBw2A8Ba40a42fDm4eVXxx3AOJ04rUBD+GrCzqRfz98Xp/P5XN4qQ3Gyo+3mIauelhStsIgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com; spf=pass smtp.mailfrom=technexion.com; dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b=tfT2hSty; arc=fail smtp.client-ip=52.101.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technexion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DH90AGlYOcRPJzeqStFLZscTA+jR4+dwjkUVPfFurLOygSe1dCC7pQw29CAKX4sdRBRFjfRvDPFnsm/yFyVPZvQBuk5qNeNJ+G8cDEGPfm4LM4hnDVie7dtn8P7KgntMksSSHLV0/g7/xa4i+I1K5WnfIdn5pfzMJgWD4jeGKj29HIOnlZ1nTbxh1aI6MiR0sDpZDEh0PmY6wMXjp/XJ1luU46eTMc0QJmPg57UQntpHrXHrDBgjC2lHGH0afHKrSRhNLXgiQrkb/riTmj0ZL0vHhUB1q/OU66B3lrZHI9Iw3toaGIyajNfKzcgL6CBiQA8mtNbPayfQC6IdPFE0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK2rpx2/MgP0xYg1oquRCVSwjELamQjKBbWlfVvpC0E=;
 b=Q7hMkcswBiuEPpRHWae4SaNRW3n5nLpcokixTZfpM2YcpZQrFKhlwADL+JcjuRu+MMP+BLTyUtwY4qU6o2f8k4FBFwGmMBRkKKKUWj0oauiD6iGmdlPohVbNy3NZYxzLXpfLY9VkRZ9tDTcOASg0zj120/ov8APPAgl8bh5k9jsijCLkG7neiDu4djweC9XROn/bOMddYSX/NfmKZQMVDsNN7Z2rMkonZFGL3gJBZHDGnQsXW0ZGUuax2Zmo9mtrstF45nKpPebu1IKd6NuPCcexgxcgi7Uyg8cJI0H4xJ+UUjKwMdU6h2ph+0SHwkGWXRlldGRzsKffNuDQF8XRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technexion.com; dmarc=pass action=none
 header.from=technexion.com; dkim=pass header.d=technexion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technexion.onmicrosoft.com; s=selector2-technexion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK2rpx2/MgP0xYg1oquRCVSwjELamQjKBbWlfVvpC0E=;
 b=tfT2hStyxx8XxDnkBg/iCVAVGHRhOncLN+wyMX5iIqaRWvlqd3suc9h3XyZ0B+jZCV9ZdtFtMCkXJwrnNmS3LDtGc5QySZfD/1+sRLUOjsaY0xpz9TWb37eWG2xiO8wAFOwDR6VJOXUNiSO+M3xZdFYscFFUY2m4FNkl5zhyjXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technexion.com;
Received: from SEYPR03MB7464.apcprd03.prod.outlook.com (2603:1096:101:146::7)
 by JH0PR03MB7493.apcprd03.prod.outlook.com (2603:1096:990:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 07:33:11 +0000
Received: from SEYPR03MB7464.apcprd03.prod.outlook.com
 ([fe80::7de8:115:8b5f:b071]) by SEYPR03MB7464.apcprd03.prod.outlook.com
 ([fe80::7de8:115:8b5f:b071%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 07:33:10 +0000
From: Richard Hu <richard.hu@technexion.com>
Subject: [PATCH v5 0/2] Add TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G
 carrier board support
Date: Fri, 22 Aug 2025 15:33:07 +0800
Message-Id: <20250822-add-technexion-edm-g-imx8m-plus-som-v5-0-bf745447345a@technexion.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADMdqGgC/43Q0Q6CIBQG4FdpXHcaogR21Xu0LgSOyRbixJjN+
 e6hW6utLrz82eH7z85EAvYWAzntJtJjtMH6NgW+3xHdVO0NwZqUCaOM0yMtoDIGBtRNi2MaBTQ
 ObmDdKB1090eA4B2IsjI1VXkpUJEkdT3WdlxbLteUGxsG3z/X0siW17fPN/mRAQWjeCWUwlzL4
 vz5cdDekaUk5h9Y0HIbnCdYsMxkpdTIqPoLF18w23aRWCwbZ1rKjHNzrH83nuf5BTrrfOiNAQA
 A
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Richard Hu <richard.hu@technexion.com>, 
 Ray Chang <ray.chang@technexion.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755847989; l=3309;
 i=richard.hu@technexion.com; s=20250604; h=from:subject:message-id;
 bh=E8tbcirx+xj1hC/GOxtriVw6He7agO59iFWxEZJkRzI=;
 b=u03f6AZWTK0rUFaTO427UK6mlWlW+SBu0EiO3ruZ1+Tp5kCBTBUUxXDaHVvV5qRWiLEcZHrRO
 1+6VDSyKZMCBJskqd+tejT9VnXeB28raAIs/QfgK2hHhGtlo3qwwcN3
X-Developer-Key: i=richard.hu@technexion.com; a=ed25519;
 pk=MKoW0/U0r4MjJdRNaq37Tb25KE1fzJUdMN0pa8XBJSA=
X-ClientProxiedBy: TPYP295CA0050.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::12) To SEYPR03MB7464.apcprd03.prod.outlook.com
 (2603:1096:101:146::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR03MB7464:EE_|JH0PR03MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 780fecef-a0be-4d38-b2b8-08dde14e2548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3ZBUm1pT0lqSktGTjRkOHVWeHc2eWo5dU5aUFZ5TThMMnh1S0h0L1Bjd0pL?=
 =?utf-8?B?ZldHTE1URDBXUDhvL0s4N1lSZTJoUHcyUVZWSk9KcWo2MHNNTzM2eExtc3hy?=
 =?utf-8?B?bDdDWm9LQmJUTlNNMVlXc1NJRFpNQWFub2ZGM2Qvc24vQkd5UW1xVmFNN0dj?=
 =?utf-8?B?ODNkR05uOUtrWnBJa3NuNUZxN21TT0U2Q1M5SUQrUlp5OUVoelFSZEtsVFRU?=
 =?utf-8?B?UWhyWC9SS1F1dUwxU09oOENKaVdBTTFYaEZRSTdic09qMllnbG9mQXpVSkZq?=
 =?utf-8?B?SkQ1TmNjUE1Vd3BqM2xxY2h3bjFEbGpIajNTQlB1LzMxOUM0WXBYS0duQ3lP?=
 =?utf-8?B?SGFuWTA5V3RsRzM1QS9sSVlybnhHSFB6eGVYRHRKNnJQbE84SlRITDFVSVlj?=
 =?utf-8?B?NzhSeHhKOTNSeEVScnB4cmRTaCtPTkp1MXBENWdHRFRzdDRUSHF0TmFFc0VB?=
 =?utf-8?B?MVJPdVhkWDhVTm05M3FYVllBbE90b0c2SUlmUjFmcXJRbzByVzMxR3lSaHlP?=
 =?utf-8?B?ZnRUK1h4RXhvZUhNSlA3bUx0U3ZsSU1nRGtJUFpHV1lvaUpzL2NZVFRpUldo?=
 =?utf-8?B?UUkvbWZwRHZSZlFpelowV090SGk1b2lXYjg0NFJobU1sYWF5bk9QdXFIYStF?=
 =?utf-8?B?OGg0QnVia0hqTkRXd2JpdDk4NFN3MmhBbWtGcjhXU2lYWkRGODNvTjgxTlBN?=
 =?utf-8?B?dHprQmRPMitkNUdqdE9qS2RKRDBxLytON3lBbno2UmRxUGkzTUhTZHZvMy9s?=
 =?utf-8?B?QVdKdmo3Z1hrS1Zsdk5vNmEyS3NLcnZpVUV1Z1Vta3lUeWl5L1dWV2Uwbm8z?=
 =?utf-8?B?WlY5eHovZThFcnVuTzdXTUpacTR2R2w1Zk1uR1RSNGFLc3h5dW5LTzdSLzVU?=
 =?utf-8?B?czJZYi9SSjBGNzIyYmpuYlhLU3JvMDlzRE95VUYvam1ETkxySnRQV0pSUTNw?=
 =?utf-8?B?b2RZd0NCV3RlbmJ2S1F2ak8zTk42N3RuZXVKZlpuSkNCQk92Z1phMUNySC9Q?=
 =?utf-8?B?bElKK1dZcGpvQ05ZQ1lwb01oc3J1UTRSSGl1NDZuTzBaQys3NTk3OHNPSzUy?=
 =?utf-8?B?Z2dudnBNbVNXWlFNOEJ2MEJPN1pEU0gxaEtvQUR2RVBLRWQwTXVQTE15cHBO?=
 =?utf-8?B?UGxlLzZQb2FYekYzZlRFUS81WUtBZXdDR2tyVUluVi9rOXJaUXNoL1RacVFr?=
 =?utf-8?B?WFdVTndaN3paV2RjK3M2S1UxMFFzNDI1cytOT2dTVzR1NUxTYTIvK1R4S0dv?=
 =?utf-8?B?c1NMS0pVOVI0c0Z0am9FdG5HZGliSDU2bTdva1VTT3VDckRSemdsbmkyVEUz?=
 =?utf-8?B?Y3FLV3lmem85Q2huVzVKU3JWdWR6bEF6eHE3K2FSc2lmWXdZbCtQMFNUYXBH?=
 =?utf-8?B?dEF1N0dCdUluc2Z2Z0pxc3FNNk0za2wwOXFBczQvTjU4MUwxaTEyL3VRNTZl?=
 =?utf-8?B?RjVYOWo3eGxxTkZlSVA4UmZLZis5WE5Db2w1NlJRbUk3eFljb0RTWDVBdFRM?=
 =?utf-8?B?UTBqU1Q3aCtVaUoyU2JBZElMWGFoc21oMWZNSlZhdG82MGJBYzBVSHNqV3hs?=
 =?utf-8?B?eHhneHBIVUwydnJnN0tSOC9heXNOWkxUQlZiaGVzeWhZd2oxS3h3b0FqdzJO?=
 =?utf-8?B?SFZKd2xIeGpiaWV6WmNjeTI1SDg1QjhvUGNDMmtCNHQwNjl1MisvSnRMZzR6?=
 =?utf-8?B?djRYeXVRdmhudGZlVWQwNVZJdW9RYWU4bjN3WkpoQXFaTTdwQkdlYnIxV2tu?=
 =?utf-8?B?ZmR6dko4RWduNlUrZXVEMGlQL2ErZXMrUVhCeWl2RUh5WTEwYVZ6djF3azl1?=
 =?utf-8?B?eFh3OWZYcUF1b1pZWlZLcVQ2UTM0d3BKSit5dmM5cnpxY0ZPR0RQZHNlY251?=
 =?utf-8?B?UU96b0YrTE9UTk5qRTlhaGlhMFFxRndjSk5KTTQvbENwem51dE5aMVd6UFJw?=
 =?utf-8?B?TTd2bE52R1hNYWgzWFh6MXk5SDJocHZhMUhuRFlNc2l0Ry9XczJEeml6eWln?=
 =?utf-8?B?QU85c0N6MG93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7464.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3FWZC9pb1ZkRWx3ZVRJV3M3c3pueHNMV0ZZZkd5MlcreVBCbTZHSEV1U1Bw?=
 =?utf-8?B?MTdkei9NUGVYQmNuRnlWT20wSGRDUUZwWHZVUDd3Wm9IaUtOM0p6WG9PSVRL?=
 =?utf-8?B?QVBUQ1BocmNuVlc3aUFJbmJjejZvSFNaNUFoZXZ6QllvM29JMGJKUnlncFNE?=
 =?utf-8?B?NnFvYXZlVnV3MkNmcDFrT2tCYnhRcm1PUlJIS3FJOC9ieEFUNk1qRVU2ZFho?=
 =?utf-8?B?d2Z4ZEFHVVJ1RUQzSU83SHBqcE1BaURnVzNyQWxQMkVIOXAxYzhSQkloM1BZ?=
 =?utf-8?B?NHp1QjFpODZ1bnNxSWhSYmFsUWwzbXpZT0I3dFJXYXRJVlZmZXZ1azFsNXo2?=
 =?utf-8?B?MW10R3FKQlE0WmVPRmg1eDd3ZjRDV1VwZDJZZEdkQXlOcWRDbVZ2anBkL0Vp?=
 =?utf-8?B?RHFJODJlNE84SGlQd1EwQnl0NVNsRnhrOVpFNktXcFg0TmV2c3RKOFZjZHdz?=
 =?utf-8?B?TW1hN3kzY0ZQV2NTeVF2dUZ0d3ZtQ2l0bTBVTFRHRUwrenZTbGxLUytmcng0?=
 =?utf-8?B?Rm44WDc3RzcrQkQwYkFORitBdVpUMFZVd2ZUVXExNnkxbGxQVGpLSjVmei9T?=
 =?utf-8?B?ZFRaSEtsYmoycUM4N3phNTNoUXAyZVpPTmkyYkQ1d0oyYjg5TFROVUc4N0tp?=
 =?utf-8?B?dlR1a1BaZ3BXbmpFWGg0bnZFQlR2V01qTkE5enZIMytrNGpVcWprNHU3Mmtp?=
 =?utf-8?B?TTdRa2J3c25MQWNXeUMvMUdCRGhOYkNPU1lLYjdURnltY3VBRnNYYjhrQSsz?=
 =?utf-8?B?cXNxaXVwMVpKS1p3WURXakdPUTg3cUp2YUljTTJER0pHRmRoaC8yZm9nVVVq?=
 =?utf-8?B?ZmNMa25meThuQ2VFSFhrNmR2VFhTcGF6VkdtdjI2cFowVW5LVG5wZEZxM2gy?=
 =?utf-8?B?ck93V3JCVmlyWm42S3Z4ems1b2FKOWIzOGdKeWxjWWJHZWFJck54VjM2eTJt?=
 =?utf-8?B?LzRRQ3BZbmNNdTM1Q3Zwa2syS0R5L2RURFVWNWh0WVFqYWJmKzIxeTM0UHRR?=
 =?utf-8?B?ZnlZOThVSU4wRytlVXczSzBadXorcTNSU0REcm5ZVjZ4MGE5bkRaV04wZFl2?=
 =?utf-8?B?WHplNUl6SzYxR3dyVWo2bFlNSkpaUWwrRnBNRWQrTWhkNDRVWllTZ0dqN2Ji?=
 =?utf-8?B?WGZ3cVU3SzdOZ0JuOW9mTm40dFFxYkd1Q1pid256K2t6U29nNDhaNC9RTDZ2?=
 =?utf-8?B?aUpkeEVhQ0dLUFJmMDBVUUllc3cxRmpFZDNqRVI5R3VDYXB6emN1NXRCQmlj?=
 =?utf-8?B?aXVGbkphNkQ2YnQzU3ZvMm1jNSt0Q3ZsNks4YVpYdVExeE1ENDJabUNXR2tl?=
 =?utf-8?B?eVV1TVZEaW9zTzh6MjBZdWhlazJYMGxwWTdUNW5pR3JDWG1lMEcwckpmdm1R?=
 =?utf-8?B?TWtUMWRsZHBlaE9INlUybUZQSFF0UmdVU2h1L1c0ajBWYzc3OHI4QnFRVnVK?=
 =?utf-8?B?dTFUSWpkbDgwT3J6WEJINlJiRTdyR3FYYjdYSnU0aDhEb2x4YzZQeXpZUVll?=
 =?utf-8?B?dXl2QWloODRlTWd4SEJqK29qeHNRUU8vZ1Z6U0pQOTY2NDJGMlU0S0hRZlhw?=
 =?utf-8?B?SXpRN1M5WEhZSkpRQWV2eW83Ykk3ZXNkdTlOeGh1aExWaldnenpFWUFmbWlN?=
 =?utf-8?B?NHZaQTExMlBPU0hZck9jT1c2Unp3emxBd0tONDkxNDZBaVJrQjFOVTVhbTdV?=
 =?utf-8?B?d0poU0JvMmpjQ0tQaWVUL3EvU0FpWlVEQk9MZnBEd1FsT0U1QjhtQUpvMnBn?=
 =?utf-8?B?Q3AzUDhPejhQTmJ5alEvZHM1a1d2YzF0eFVpL2tvM09sMS9KdFFtN3g2a1dz?=
 =?utf-8?B?VG1QM2I2emNTRVowcWRtTUw1MDFmaXFMYVVmNjVXZk8rd3paVVB3VVdNNEsz?=
 =?utf-8?B?VDlYMitXNk10c1pQVXFQM2tDNzJSaUZMbnYxUCtUQW5hU3JDODJEdzhXK0la?=
 =?utf-8?B?UE0wb2tvcDBleHcySWdJN0VIbEtpc3ZzYk1wMXNYM2lrY1BBRUVCSWZucEdO?=
 =?utf-8?B?T1VjUXpOV3Nsc3I4UDNaZGRkbnhQMFJYdEkrbG1tRFphSzQ3dmJmQkppYWZv?=
 =?utf-8?B?S0xzLzlVakhSdmR6VmlxaTlBNkdHcjBrQkpia2EvVXJJSnd0VWdYcTRVVjZJ?=
 =?utf-8?B?cS91SWh0cWVpdGxubkcvV0xXSUZvaVRodTd5cjh3SGtzTGxWemdCRG80MVlT?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: technexion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780fecef-a0be-4d38-b2b8-08dde14e2548
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7464.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 07:33:10.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ee19679-b9a6-4497-8ed2-1eda849e753b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJoviE3yzyzzDmAomgKLtjR8/aGVfBLAkNfz02bS2TdpgZWex5VvwSa3IEkLugVC5eINKAj+u7Y9ZnTbxe2GdoJ+lM31G5CG8cVkF/oYhWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7493

Add initial support for TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G
carrier board.

Changes in v5:
- Address feedback from Krzysztof (thanks!)

in patch 2/2:
       - Rename 'native-hdmi-connector' to the standard 'hdmi-connector'.

       - Correct the PMIC interrupt flag to use the proper DT binding
         (IRQ_TYPE_LEVEL_LOW) instead of legacy macro.

       - Update the SPDX license identifier. 

Changes in v4:
- Incorporate review feedback from Shawn (thanks!) and apply further 
  cleanups to DTS style and node naming.

in patch 2/2:
       - Addressed formatting issues by adding newlines and removing
         unnecessary backslashes.

       - Removed the lvds-backlight node for the optional display panel,
         which will be handled by a device tree overlay.

       - Aligned several node names with DT conventions. For example:
         - `codec@1a` -> `audio-codec@1a`
         - `gpio-leds` -> `leds`
         - `pcie0-refclk` -> `clock-pcie-ref`
         - `wlreg-on` -> `regulator-wl-reg-on`

Changes in v3:
- The changes address DT schema warnings, remove unused regulators, and
  improve the overall structure.

in patch 2/2:
       - Fixed DT Schema Warnings: Renamed the i2c-gpio node to i2c-0 to
         resolve a naming convention warning reported by Rob's checker.

       - Removed Unused Regulators: Removed several unused regulator-fixed
         nodes for LVDS, backlight, ethernet power, and the OTG VBUS, as
         pointed out by Peng Fan (thanks!).

       - Added EEPROM Nodes: Added device tree nodes for the EEPROMs
         present on both the SOM and the baseboard.

       - Node Reorganization: Relocated the iomuxc node to the end of the
         device tree files for better readability.

Change in V2:
- Ensured accurate `To:` and `Cc:` addresses by utilizing
  `b4 prep --auto-to-cc`. (Thanks to Krzysztof Kozlowski for the
  tip on this command and helpful suggestion from Rob Herring).

in patch 1/2:
        - Add Acked-by tag.

in patch 2/2:
        - Generic Node Naming: Refactored device tree node names for I2C
          GPIO expanders, the USB Type-C controller, and the PMIC to adhere
          to generic naming conventions (e.g., `gpio@21`, `usb-typec@67`,
          `pmic@25`).

        - Removed Unused SPI Node: Eliminated the `spidev1` node due to an
          incorrect and non-existent compatible string (`rohm,dh2228fv`).

        - Minor formatting improvements (e.g., whitespace, indentation).

Signed-off-by: Richard Hu <richard.hu@technexion.com>
---
Ray Chang (1):
      dt-bindings: arm: fsl: Add EDM-G-IMX8M-PLUS SOM and WB-EDM-G carrier board

Richard Hu (1):
      arm64: dts: imx8mp: Add TechNexion EDM-G-IMX8M-PLUS SOM on WB-EDM-G carrier board

 Documentation/devicetree/bindings/arm/fsl.yaml    |   7 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts | 359 ++++++++++
 arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi   | 786 ++++++++++++++++++++++
 4 files changed, 1153 insertions(+)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250604-add-technexion-edm-g-imx8m-plus-som-79adf0b397eb

Best regards,
-- 
Richard Hu <richard.hu@technexion.com>


