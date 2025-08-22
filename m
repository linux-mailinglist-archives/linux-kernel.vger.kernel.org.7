Return-Path: <linux-kernel+bounces-781287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A32EB31089
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DF07BADC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250262EA47D;
	Fri, 22 Aug 2025 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b="HeEfUaj4"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023078.outbound.protection.outlook.com [52.101.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD612E8E17;
	Fri, 22 Aug 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848002; cv=fail; b=sgx2BWJtY6Q00FewUDn3dSPsx7KP8ZqSE/whx9WgSCQwB6YMeVc2TPySCMLMSghoa+9Llg9jPRF9/9lj260zD7G0Ry12R6LYmjwP/7B8Xumwe1Tj7EM41VODCWkZff6gJXQh6LQV9YQUd81A0NxN00JQFOhVPfCPzTfhZy8zt0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848002; c=relaxed/simple;
	bh=B8RuyJOlUbI1ft/vOdpGt16CiEs3BndiqD5qMU5jJ4g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Aw2XnWX9BH77/xDzO8/LkVdd5c1dQZUIAzMxqhQAyIMk1UaS4COqSPnlJvn/5Jn54AN9A2R5HdomxUUKg9yuyb8hsWu3KI4T28Z6uag8FcW1ALZffjAy461x3cLq3LtxmAzn/GSAYQQUvTjot9aMAeuTxRopvadqRMakkesmFiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com; spf=pass smtp.mailfrom=technexion.com; dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b=HeEfUaj4; arc=fail smtp.client-ip=52.101.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technexion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jbp386V+PzVLypUK7Y5EvVGOfIqLNJNHnnNiY+PPCEkUI3KVF0OVD/syHqU4fG6Z5f0+MsoYVZQtwp6UH+unTkH33Jjx3XWc44yFi8yHHpwe2Uudvw74tZyYUvUt/dv/ZSN7cOfs1qyKRaq/ogqLU+3Aew40YoHdjse4ryh04ddk9sbHrC7fLUmSBya9ZsM/PaKs+e5qbvtQNl9yLm/qJtFaSoVgU02g4kYPNUF3Mp/JHHD6qnD9gm8iwpeuoIw01ZZkBZVGKvUWcnvX1cUqSGTJ8hCddgMOc6U1Jv1+TopcnAOXkxu01FN+U5wH3xhLllE90ACYpsx4e+OHoS3G8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsFHPyT/KQ1uWwzd5cyUjsinUG/S1Avw2vrKEJtaPXw=;
 b=ab54s90BxMxC31yxjVAirWPuIlCLwsc14W1+YbVov/y9t0HQ8ed+9qGyVbZ0AsDxO+y6Hwkffc7Kr3Id4bSpCf69HOprfBoDvDaDtTUIamSaRNrcPEtHV773K2+FCSii7ZtaB98vNN6+O9xb8FDUx1thrtcQ+H+t0XzsYGymyQUcNM/toMMntr99hBhm0MGdKgkTLCdIc0kASjmlBMishs+/MNOkkoStsdfvEKbA+Kzo3/jku1Zq7z40avWQqdtHyfINx+ZYKp4IU14jOCCidBdkADuXDLCWPRt5H6ZvG/zIrgY/hNS9fW3GsUMK9ubWrUkHVLvRQ77IRHseLo2zeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technexion.com; dmarc=pass action=none
 header.from=technexion.com; dkim=pass header.d=technexion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technexion.onmicrosoft.com; s=selector2-technexion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsFHPyT/KQ1uWwzd5cyUjsinUG/S1Avw2vrKEJtaPXw=;
 b=HeEfUaj4XlELxwX53amxRRzDeadMXpCi4JhnZvnNuQ+/tFNFPdhggKKqsqU401Qlr5aSrAJvIWSCfgH9pnLHbcX80YSkN8KQdx+TJ+reZv1T+3g3SCQFSykSyvh/d/Ev1LjcwFMWKOdXoRLtm6FU7le1qxZVuOeTN24Tu0s7m8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technexion.com;
Received: from SEYPR03MB7464.apcprd03.prod.outlook.com (2603:1096:101:146::7)
 by JH0PR03MB7493.apcprd03.prod.outlook.com (2603:1096:990:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 07:33:13 +0000
Received: from SEYPR03MB7464.apcprd03.prod.outlook.com
 ([fe80::7de8:115:8b5f:b071]) by SEYPR03MB7464.apcprd03.prod.outlook.com
 ([fe80::7de8:115:8b5f:b071%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 07:33:13 +0000
From: Richard Hu <richard.hu@technexion.com>
Date: Fri, 22 Aug 2025 15:33:09 +0800
Subject: [PATCH v5 2/2] arm64: dts: imx8mp: Add TechNexion EDM-G-IMX8M-PLUS
 SOM on WB-EDM-G carrier board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-add-technexion-edm-g-imx8m-plus-som-v5-2-bf745447345a@technexion.com>
References: <20250822-add-technexion-edm-g-imx8m-plus-som-v5-0-bf745447345a@technexion.com>
In-Reply-To: <20250822-add-technexion-edm-g-imx8m-plus-som-v5-0-bf745447345a@technexion.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755847989; l=29252;
 i=richard.hu@technexion.com; s=20250604; h=from:subject:message-id;
 bh=B8RuyJOlUbI1ft/vOdpGt16CiEs3BndiqD5qMU5jJ4g=;
 b=lHMSZAq4YMEfbbye4Wz/vd8Ut3NI1zuM26Xti28IFWyf6mLmckGJ+UromXJkhJOpk0Rbgacb1
 Bn6OvTTbn6zCPcjwVkFOvglOQ0PoNQLoYNobQJBmdViHifORn6JVs9t
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
X-MS-Office365-Filtering-Correlation-Id: 7d6ea029-51e1-4783-3989-08dde14e26e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TllJbzZBcmRGeW1ROURZVEZleHptemMrZFFYazNGcG13RzZTUzNQWEs1QWM5?=
 =?utf-8?B?MTRBVEMvR0plMFY4TC8yeUwvNnFXSHFidmlYYms2K3dNMEdCYi9iY3lROFdO?=
 =?utf-8?B?blNkSm9kZnhoajJEVnRIVkIwbmNUSWdiMVMzVjN2b2Ezc3NyYVlFYXZWUXl2?=
 =?utf-8?B?RFVwUG9nTnlZZDlsbEpZVWl0QkZEYWVNM29NWTZyY3RlWHNJTVdsNWJGZnZw?=
 =?utf-8?B?aXl6aDJaZEwzNitXUkpkaVBYbWQzNG41OXFmeStLYWhvei9aV2g3MDBlSXlK?=
 =?utf-8?B?VzZBa1FoUno4bUFxUytnTGI3VEdIR1JqUHY2ZWVKR25ZZWtuNENQdjhLcld6?=
 =?utf-8?B?dkVsZ0xWUm1BZFQweUc5SENKVDJ5ZEVRdVlQV2ZaVmJRRXNXUi9sQjVXL2ZX?=
 =?utf-8?B?MUVqN3UwR0NwaEZnVElkY0M5UnduckJmTTU2WFRDSk9wVTNETEViSDlGcTBI?=
 =?utf-8?B?VkdsZGJPbEc4NmhQNU9OMlpSYUJsVjRJdHB0RmdtRk04c2Npc1N2L2ZXcXR1?=
 =?utf-8?B?Sk1ac3ZQUjM1czhVVlFOK1Z0WG0xUzdKNTFSVzFKQlhxc2RHRFpZeXNza0Jo?=
 =?utf-8?B?V09DWFBsZSsyYkdvRk5zYlBvQjFBVmpWYTZiSW5uc1lQRk5BUnNnc2hYV0x0?=
 =?utf-8?B?Vlg1Ry9VUDM5bk80UitRWnp4RHczcEt4NUMrajZ5NCs1d21nT1htbElBMGxk?=
 =?utf-8?B?ZW0xMnl6cDFYVnVoYjByM214MFpudDU0eHVIVjNZZlk3T3lPYVhUVTFwMVo5?=
 =?utf-8?B?dU5pVGtpSXFlVzV2UUtzVUhFZXl2OXFvbkNPZXc4S0xaVnN1RGFkWTZhUURE?=
 =?utf-8?B?TkVYd2hTbmthQmRKdFIrYnpsN3hGUStSK09NZ3VrWVFydVRkWmFKVlRhcW1r?=
 =?utf-8?B?ZlU5cFRDMFovZlFiandiaFpOVUE5bUQrYXZRV0gxc1B0ZzJDYTNXWWVLUU1v?=
 =?utf-8?B?d0tIelk4OFJJOGhBRzNYWVZhSTQ1WU1PT291bmtJcVVrQUhFVFcxUXl4Rjc3?=
 =?utf-8?B?eVgvTkpqWHVzMzIwaGwyaHI2OTNHOENCY0VyUnhnS2Y5ZWFGQ1dyZnhTL2Fn?=
 =?utf-8?B?R2pnRTRiYXpkUmNrL293OWZtKzF1RUdIbExoMlYzOUEwYVRxZzhMZFA0TzlS?=
 =?utf-8?B?SkRDNlZ6Y1prWXBBRzU0SEFHdzhIbW05VTA2R2owSFlwby8wUjRmeDc1M2VO?=
 =?utf-8?B?Sm1DYXY4WnNCdFpiOXFQNEJJOS9vMDN5clpkVFhRMmdwT2JOSGkxOG5UV0lN?=
 =?utf-8?B?YllPcW84Rm0zY2s5MHIzMEZMYjMyMzNJMFBDNWNNRVd5QmJtRGI4YllTQjg3?=
 =?utf-8?B?TlVlYWZqVGZNelJoSENqM3BlcnhMSUhMWWtWczlqcXk4Rm5ETktMNWZjb3dO?=
 =?utf-8?B?Wk1TMGhoRS9FYUJ4VDFINnBrV3d5OGVHWFZYY1ZkZ3UxaFZUbTFOV1EwR2Nx?=
 =?utf-8?B?TjlMUmx6elFqdTJiZGxyUjhmSDMrOURJUXpjaEQ5ekd3aWlDY2NTVDIwN1I4?=
 =?utf-8?B?N0pqZzB5Q29CU3BRaHdFanoxblFpbHlUV2thRlY5eDVwQjFkNVNJSnJCbHFt?=
 =?utf-8?B?VVc5dExLK2lmcElJVWxNRUxEVTlSTXlqMkNvZkxEMUxzcTYvQ3FqbEw0STBl?=
 =?utf-8?B?RlMxbCs5a2VDb2NnTUZzWXdvYmRUc3FyaS83ODgyVnVoaG1idmRzeVIySEFJ?=
 =?utf-8?B?ajhONzY3NHVaODdoYytaRDMwMUo3a0lTRElwdHdIR0lBaGlubTArTU0yM05Z?=
 =?utf-8?B?enlGZlY0MExMdFVOQnhSMllPaEtVWVRmVDlSZ3JpMXI5ellqS1g4SGxXK2Nz?=
 =?utf-8?B?bjJlYW9KTjMvN2hzVm1wcUM5M3pYZGwyNVlxNGJwVXNqRWIxQ1YvTHZTQ0Nn?=
 =?utf-8?B?eGgwbUJwc0QvUW5jdnRQaGw0aitjWUJpZWNKejY4SUhKaGlRZjl6M2Yrcys1?=
 =?utf-8?B?dTAvWUgxWVlOR0hNcVExODBYTHdZakxpSXhqbCt2QVYzR1FVZ3p4Z3JOMlRk?=
 =?utf-8?B?OXh1bE5JcmZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7464.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzFpVGNXZTFIUFZKN0pXcW9XQjc1WmkxM2Y5a1g4NTdDRzZVcHI5YWE2Q0FK?=
 =?utf-8?B?V3ZnQWlEbVkxemltYjRSamxWcjVvU2IyZFJwRWt2bVkxSnNHanMwVXIzYW95?=
 =?utf-8?B?Zk11ejVGN2JxQ3F4TEZZanhMSUs4Q2Y3NGRTVWxuOFF1TXViR3cvb1I1d0pF?=
 =?utf-8?B?TkJQaWd0V0hKQUhhNGVwa3hPM3BVaGJ3YTFRZXkyVTFSNmR2SXhUS2R1WUNh?=
 =?utf-8?B?dityUnpvSll5ZUNZVTBvaFU1Rks1aWZqa1l1MGJPS1JxVDlUUnR6OXhlNEUx?=
 =?utf-8?B?QWlncVJqdzExdXJyVHJ5bWhJb2piT3pUYjg0eFNKWVh5a3hGRkhFVExlMm0z?=
 =?utf-8?B?dEI4NXhzek9tNVpCSnlJeXVvVjVvWVZsZkZqSjY2dkw3MFBqTENrUDRpWTQz?=
 =?utf-8?B?d1E4d1NCV2tWdTlPTW5pajdralBtb0l5djAxUitxbU00WTJGUDdwM00wSWpG?=
 =?utf-8?B?M01VN0NoeUpPUWlFenV6cnZCNHZhM2RxREZKRm9iVjlpeXU5QnhSUUlDb0J5?=
 =?utf-8?B?b3FURWRNNm83Z3NKYm9za015V0lhdW5QaXdVTUZMN1ordmRhOWZOenNzNnpC?=
 =?utf-8?B?YmlNc1NLOHZtRW9nYXNKNy80TXR0NitVckJPZlpRVTg3blFHWTNzemFTL2sw?=
 =?utf-8?B?aG1rRDJsV0lPT01KZWVIbVcwdENCZFdGWlQrbWFkSEdyYlJDa0dQRElFS0tv?=
 =?utf-8?B?bHFHL3djMVRBUDFISWx0d05aWW51cjhYbFhQTE03bUl4ZHRMWlQ0NUQ1bmkx?=
 =?utf-8?B?U2I1SHhqTFNJaGowbUpEdk1VZ1AzOFZiN01zL09KTXRMZjBVRnFmM0QvQWg5?=
 =?utf-8?B?a2gxRFM1Rnk5MDdiamgvbWdhS2N4N0JDN3VTVmp4WEYrbHZibURzMWQ0cUxv?=
 =?utf-8?B?RW03V0tCNUV4Ym1CK0lsWDl2ZmpMdDV6K05ZTzN6WGdZbWNjb2liU0gwaEpI?=
 =?utf-8?B?cE5RalA3dXNtNmhpZVpML2xkWUdqekVMNFB0Q21BMlg0SFFEQ3AwTnUyUGlo?=
 =?utf-8?B?TDNrMWRGR3NsTms1aEFOdU9QdWRMclFjMmthWG52UU1HMnlvT1h4UmNWZll5?=
 =?utf-8?B?RUY5UG91d2pNMkdyeWk5Yy9aZmZmVXdPc2JKYTF2NmhZdkFCdGxUaS9sc0Rv?=
 =?utf-8?B?VjZxaTVjd09KT1Fldi8wU0o4V215cE0wMTRLWlExclZ4b0h6OFVlL2NTenVV?=
 =?utf-8?B?RklhaURSellwRm1ncWtzWlNjSmh0NWtVYzgyNVR4NThPRWFnektCQzBJL2Yx?=
 =?utf-8?B?Yk1zbjJEdGdRQ2J3ZVhTUDFnaHJHNzg0UXNzV1hxNWtYRWM1b2NZZk9XS0xu?=
 =?utf-8?B?WGZDQVJjYmxjTXpsa2c2Rzl3c2loYXlaYjlqQUNoUitOTGZTN0tMc3J4MGhv?=
 =?utf-8?B?a1paQUhLNFYyZnRyZ28rbU1VWW1abnBHNjl0cEtOTjZzN1VYZDFxUTlOOW85?=
 =?utf-8?B?K0M5d3lUb0NFOE5adk9xZzY3OVpwN2tSVUZiYy9kelRkUXU0VE5uaEhGKy9u?=
 =?utf-8?B?S0dFblpLeGVQenNuZjE0WWI2all1RzJyWnhHOHNqK2pDQ01pRkpZdEhEakFs?=
 =?utf-8?B?Z2ZQNGtiekhXOGZEdS8rQzlxb1BrbE5acTNGSnBPRkJmSjZyVmkyZkhJUVJn?=
 =?utf-8?B?ZDJBcEJBYnpoc0xhSHlmYXB3YlNIdm94eVA1MGJINWlDeG9RdUZHSWNuQ05C?=
 =?utf-8?B?V0lqTStib1BnUDJiVnpscnRCVnNpazQ2ZE9WVzZ1K2wyRDFaRzVlQXVWR2h6?=
 =?utf-8?B?RnRuM3JLaUJhdnZYS0s1L25xa3g2QjFVUVRXbmU5RlJIRTA3Wjc0dGo4R05k?=
 =?utf-8?B?T0VpNnZCYmh1MllSeU5pTVQvRDROckp0SmdIdi9pMXM1RU0xcnZxczFId0Vv?=
 =?utf-8?B?V0xTUkU0WlY0QWdKcmZ2SFovY2xXbzZBaitGaUh6MGY0WWRkQ0tGaWRPRTBQ?=
 =?utf-8?B?b0hGY0FXQWtXamFUdWgxMVZHcDdIWkpxMXBlQ0Z3NGNVaHM1K2pZYk93czFV?=
 =?utf-8?B?R2FxVCtEVjRKWm04WXIrZVJkUmJMUWh5ZXJRZDJKMFl5YkdYakpiaFRNU2Vi?=
 =?utf-8?B?ZzM3ZmRyZDZ5Rmt6Q2NwQzRPZnYyNkNIMWRpTmZlMXlKYTI2aWkrejdWaFRn?=
 =?utf-8?B?ZlByeGxRSUEveTMyamhiNnhCY0x2K3JZZHNEcXJ1ckltR1M0NWJtSmpldU9O?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: technexion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6ea029-51e1-4783-3989-08dde14e26e3
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7464.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 07:33:13.5066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ee19679-b9a6-4497-8ed2-1eda849e753b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZ+gfdxYRy1Ohi+9X5DXl5O48LXqzzgkiuJOCeaRfis50c22Zb/bEq1rHbEkm6aBgcKt9Nlh7CmeAvxn0nIEk+G3/ds7BmHlkUm/P6K5Egw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7493

Add support for TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G carrier board.
Key interfaces include:
- Gigabit Ethernet
- USB 3.0
- I2S, UART, SPI, I2C, PWM, GPIO

Signed-off-by: Richard Hu <richard.hu@technexion.com>
Signed-off-by: Ray Chang <ray.chang@technexion.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts | 359 ++++++++++
 arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi   | 786 ++++++++++++++++++++++
 3 files changed, 1146 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 23535ed47631..c1fca6573bc6 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-drc02.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-picoitx.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-edm-g-wb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts b/arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts
new file mode 100644
index 000000000000..138f21e257aa
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 TechNexion Ltd.
+ *
+ * Author: Ray Chang <ray.chang@technexion.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include "imx8mp-edm-g.dtsi"
+
+/ {
+	compatible = "technexion,edm-g-imx8mp-wb", "technexion,edm-g-imx8mp", "fsl,imx8mp";
+	model = "TechNexion EDM-G-IMX8MP SOM on WB-EDM-G";
+
+	connector {
+		compatible = "usb-c-connector";
+		data-role = "dual";
+		label = "USB-C";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hs_ep: endpoint {
+					remote-endpoint = <&usb3_hs_ep>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				ss_ep: endpoint {
+					remote-endpoint = <&hd3ss3220_in_ep>;
+				};
+			};
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "HDMI OUT";
+		type = "a";
+
+		port {
+			hdmi_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led {
+			default-state = "on";
+			gpios = <&expander2 1 GPIO_ACTIVE_HIGH>;
+			label = "gpio-led";
+		};
+	};
+
+	pcie0_refclk: clock-pcie-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	reg_pwr_3v3: regulator-pwr-3v3 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "pwr-3v3";
+	};
+
+	reg_pwr_5v: regulator-pwr-5v {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "pwr-5v";
+	};
+
+	sound-hdmi {
+		compatible = "fsl,imx-audio-hdmi";
+		audio-cpu = <&aud2htx>;
+		hdmi-out;
+		model = "audio-hdmi";
+	};
+
+	sound-wm8960 {
+		compatible = "fsl,imx-audio-wm8960";
+		audio-asrc = <&easrc>;
+		audio-codec = <&wm8960>;
+		audio-cpu = <&sai3>;
+		audio-routing = "Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+		model = "wm8960-audio";
+	};
+};
+
+&aud2htx {
+	status = "okay";
+};
+
+&easrc {
+	fsl,asrc-rate  = <48000>;
+	status = "okay";
+};
+
+&flexcan1 {
+	status = "okay";
+};
+
+&gpio1 {
+	gpio-line-names =
+		"", "", "", "", "", "", "DSI_RST", "",
+		"", "", "", "", "", "PCIE_CLKREQ_N", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+	pinctrl-0 = <&pinctrl_gpio1>;
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", "", "", "", "", "", "GPIO_P249", "GPIO_P251",
+		"", "GPIO_P255", "", "", "", "", "", "",
+		"DSI_BL_EN", "DSI_VDDEN", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+	pinctrl-0 = <&pinctrl_gpio4>;
+};
+
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	pinctrl-0 = <&pinctrl_hdmi>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&hdmi_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	wm8960: audio-codec@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+		AVDD-supply = <&reg_pwr_3v3>;
+		DBVDD-supply = <&reg_pwr_3v3>;
+		DCVDD-supply = <&reg_pwr_3v3>;
+		SPKVDD1-supply = <&reg_pwr_5v>;
+		SPKVDD2-supply = <&reg_pwr_5v>;
+		wlf,gpio-cfg = <1 2>;
+		wlf,hp-cfg = <2 2 3>;
+		wlf,shared-lrclk;
+	};
+
+	expander1: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names = "EXPOSURE_TRIG_IN1", "FLASH_OUT1",
+				  "INFO_TRIG_IN1", "CAM_SHUTTER1", "XVS1",
+				  "PWR1_TIME0", "PWR1_TIME1", "PWR1_TIME2",
+				  "EXPOSURE_TRIG_IN2", "FLASH_OUT2",
+				  "INFO_TRIG_IN2", "CAM_SHUTTER2", "XVS2",
+				  "PWR2_TIME0", "PWR2_TIME1", "PWR2_TIME2";
+	};
+
+	expander2: gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio4>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names = "M2_DISABLE_N", "LED_EN", "", "",
+				  "", "", "", "USB_OTG_OC",
+				  "EXT_GPIO8", "EXT_GPIO9", "", "",
+				  "", "CSI1_PDB", "CSI2_PDB", "PD_FAULT";
+		pinctrl-0 = <&pinctrl_expander2_irq>;
+		pinctrl-names = "default";
+	};
+
+	usb_typec: usb-typec@67 {
+		compatible = "ti,hd3ss3220";
+		reg = <0x67>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_hd3ss3220_irq>;
+		pinctrl-names = "default";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hd3ss3220_in_ep: endpoint {
+					remote-endpoint = <&ss_ep>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hd3ss3220_out_ep: endpoint {
+					remote-endpoint = <&usb3_role_switch>;
+				};
+			};
+		};
+	};
+};
+
+&i2c_0 {
+	eeprom2: eeprom@51 {
+		compatible = "atmel,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+	};
+};
+
+&lcdif3 {
+	status = "okay";
+};
+
+&pcie {
+	status = "okay";
+};
+
+&pcie_phy {
+	clocks = <&pcie0_refclk>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	/* dual role is implemented but not a full featured OTG */
+	adp-disable;
+	dr_mode = "otg";
+	hnp-disable;
+	role-switch-default-mode = "peripheral";
+	srp-disable;
+	usb-role-switch;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			usb3_hs_ep: endpoint {
+				remote-endpoint = <&hs_ep>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			usb3_role_switch: endpoint {
+				remote-endpoint = <&hd3ss3220_out_ep>;
+			};
+		};
+	};
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+};
+
+&iomuxc {
+	pinctrl_expander2_irq: expander2-irqgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXC__GPIO4_IO11		0x140 /* GPIO_P247 */
+		>;
+	};
+
+	pinctrl_gpio1: gpio1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x16 /* DSI_RST */
+		>;
+	};
+
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD4__GPIO4_IO06		0x16 /* GPIO_P249 */
+			MX8MP_IOMUXC_SAI1_RXD5__GPIO4_IO07		0x16 /* GPIO_P251 */
+			MX8MP_IOMUXC_SAI1_RXD7__GPIO4_IO09		0x16 /* GPIO_P255 */
+			MX8MP_IOMUXC_SAI1_TXD4__GPIO4_IO16		0x16 /* DSI_BL_EN */
+			MX8MP_IOMUXC_SAI1_TXD5__GPIO4_IO17		0x16 /* DSI_VDDEN */
+		>;
+	};
+
+	pinctrl_hd3ss3220_irq: hd3ss3220-irqgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD6__GPIO4_IO08		0x41 /* GPIO_P253 */
+		>;
+	};
+
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c2
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c2
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x10
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi
new file mode 100644
index 000000000000..3f1e0837f349
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi
@@ -0,0 +1,786 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 TechNexion Ltd.
+ *
+ * Author: Ray Chang <ray.chang@technexion.com>
+ */
+
+#include "imx8mp.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	i2c_0: i2c {
+		compatible = "i2c-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <100000>;
+		pinctrl-0 = <&pinctrl_i2c_brd_conf>;
+		pinctrl-names = "default";
+		scl-gpios = <&gpio4 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		sda-gpios = <&gpio4 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+		eeprom: eeprom@53 {
+			compatible = "atmel,24c02";
+			reg = <0x53>;
+			pagesize = <16>;
+		};
+	};
+
+	memory@40000000 {
+		reg = <0x0 0x40000000 0 0xc0000000>,
+		      <0x1 0x00000000 0 0xc0000000>;
+		device_type = "memory";
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		off-on-delay-us = <12000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VSD_3V3";
+		startup-delay-us = <100>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	rfkill {
+		compatible = "rfkill-gpio";
+		name = "rfkill";
+		pinctrl-0 = <&pinctrl_bt_ctrl>;
+		pinctrl-names = "default";
+		radio-type = "bluetooth";
+		shutdown-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+	};
+
+	wl_reg_on: regulator-wl-reg-on {
+		compatible = "regulator-fixed";
+		off-on-delay-us = <20000>;
+		pinctrl-0 = <&pinctrl_wifi_ctrl>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "WL_REG_ON";
+		startup-delay-us = <100>;
+		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&reg_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_arm>;
+};
+
+&ecspi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	num-cs = <1>;
+	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
+	pinctrl-names = "default";
+};
+
+&eqos {
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-names = "default";
+	snps,force_thresh_dma_mode;
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			eee-broken-1000t;
+			reset-assert-us = <35000>;
+			reset-deassert-us = <75000>;
+			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+			realtek,clkout-disable;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <5>;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0>;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <1>;
+			snps,priority = <0x2>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <2>;
+			snps,priority = <0x4>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <3>;
+			snps,priority = <0x8>;
+		};
+
+		queue4 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <4>;
+			snps,priority = <0xf0>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <5>;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+		};
+
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+		};
+	};
+};
+
+&flexcan1 {
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	pinctrl-names = "default";
+};
+
+&flexcan2 {
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	pinctrl-names = "default";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pmic: pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+
+		regulators {
+			BUCK1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <720000>;
+				regulator-name = "BUCK1";
+				regulator-ramp-delay = <3125>;
+			};
+
+			reg_arm: BUCK2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1025000>;
+				regulator-min-microvolt = <720000>;
+				regulator-name = "BUCK2";
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			BUCK4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3600000>;
+				regulator-min-microvolt = <3000000>;
+				regulator-name = "BUCK4";
+			};
+
+			reg_buck5: BUCK5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1950000>;
+				regulator-min-microvolt = <1650000>;
+				regulator-name = "BUCK5";
+			};
+
+			BUCK6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1155000>;
+				regulator-min-microvolt = <1045000>;
+				regulator-name = "BUCK6";
+			};
+
+			LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1950000>;
+				regulator-min-microvolt = <1650000>;
+				regulator-name = "LDO1";
+			};
+
+			LDO3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1890000>;
+				regulator-min-microvolt = <1710000>;
+				regulator-name = "LDO3";
+			};
+
+			LDO5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "LDO5";
+			};
+		};
+	};
+};
+
+&i2c2 {
+	/* I2C_B on EDMG */
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-names = "default";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-names = "default";
+};
+
+&i2c4 {
+	/* I2C_A on EDMG */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-names = "default";
+};
+
+&i2c5 {
+	/* I2C_C on EDMG */
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c5>;
+	pinctrl-names = "default";
+};
+
+&pcie {
+	pinctrl-0 = <&pinctrl_pcie>;
+	pinctrl-names = "default";
+	reset-gpio = <&gpio1 1 GPIO_ACTIVE_LOW>;
+};
+
+&pwm1 {
+	pinctrl-0 = <&pinctrl_pwm1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-0 = <&pinctrl_pwm2>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-0 = <&pinctrl_pwm3>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-0 = <&pinctrl_pwm4>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&sai2 {
+	/* AUD_B on EDMG */
+	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
+	assigned-clock-rates = <12288000>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	pinctrl-0 = <&pinctrl_sai2>;
+	pinctrl-names = "default";
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&sai3 {
+	/* AUD_A on EDMG */
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
+	assigned-clock-rates = <12288000>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	pinctrl-0 = <&pinctrl_sai3>;
+	pinctrl-names = "default";
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&uart1 {
+	/* BT */
+	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	/* UART_A on EDMG, console */
+	pinctrl-0 = <&pinctrl_uart2>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart3 {
+	/* UART_C on EDMG */
+	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	pinctrl-0 = <&pinctrl_uart3>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart4 {
+	/* UART_B on EDMG */
+	assigned-clocks = <&clk IMX8MP_CLK_UART4>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	pinctrl-0 = <&pinctrl_uart4>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usdhc1 {
+	/* WIFI SDIO */
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC1>;
+	assigned-clock-rates = <200000000>;
+	bus-width = <4>;
+	keep-power-in-suspend;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	vmmc-supply = <&wl_reg_on>;
+	status = "okay";
+};
+
+&usdhc2 {
+	/* SD card on baseboard */
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&usdhc3 {
+	/* eMMC on SOM */
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-0 = <&pinctrl_wdog>;
+	pinctrl-names = "default";
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_hog>;
+	pinctrl-names = "default";
+
+	pinctrl_bt_ctrl: bt-ctrlgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05	0x41 /* BT_REG_ON */
+			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19	0x41 /* BT_WAKE_HOST */
+		>;
+	};
+
+	pinctrl_ecspi1_cs: ecspi1csgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09	0x40000
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK	0x82
+			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI	0x82
+			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO	0x82
+		>;
+	};
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC			0x3
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO			0x23
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0		0x91
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1		0x91
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2		0x91
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3		0x91
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x91
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0		0x1f
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1		0x1f
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2		0x1f
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3		0x1f
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x1f
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
+			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09			0x19
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12			0x19
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD2__CAN1_RX		0x154
+			MX8MP_IOMUXC_SAI5_RXD1__CAN1_TX		0x154
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX		0x154
+			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX		0x154
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD	0x40000019
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001a3
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001a3
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001a3
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001a3
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c3
+			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c5: i2c5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL		0x400001a3
+			MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA		0x400001a3
+		>;
+	};
+
+	pinctrl_i2c_brd_conf: i2cbrdconfgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x1c3 /* BRD_CONF_SCL, bitbang */
+			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x1c3 /* BRD_CONF_SDA, bitbang */
+		>;
+	};
+
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13	0x41 /* PCIE CLKREQ */
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21	0x41 /* PCIE WAKE */
+			MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01	0x41 /* PCIE RST */
+		>;
+	};
+
+	pinctrl_pmic: pmicirqgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x41
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__PWM1_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD0__PWM2_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXC__PWM3_OUT		0x116
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXFS__PWM4_OUT	0x116
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK	0xd6
+			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
+			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
+			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS	0x140
+			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS	0x140
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
+			MX8MP_IOMUXC_UART4_RXD__UART2_DCE_CTS	0x140
+			MX8MP_IOMUXC_UART4_TXD__UART2_DCE_RTS	0x140
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_DATA7__UART3_DCE_RX	0x140
+			MX8MP_IOMUXC_SD1_DATA6__UART3_DCE_TX	0x140
+			MX8MP_IOMUXC_SD1_STROBE__UART3_DCE_CTS	0x140
+			MX8MP_IOMUXC_SD1_RESET_B__UART3_DCE_RTS	0x140
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SCLK__UART4_DCE_RX	0x140
+			MX8MP_IOMUXC_ECSPI2_MOSI__UART4_DCE_TX	0x140
+			MX8MP_IOMUXC_ECSPI2_MISO__UART4_DCE_CTS	0x140
+			MX8MP_IOMUXC_ECSPI2_SS0__UART4_DCE_RTS	0x140
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x194
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d4
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d4
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d4
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d4
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x196
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d6
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d6
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d6
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d6
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d6
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0xc6
+		>;
+	};
+
+	pinctrl_wifi_ctrl: wifi-ctrlgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO00__GPIO1_IO00	0x41 /* WL_REG_ON */
+			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x41 /* WL_WAKE_HOST */
+		>;
+	};
+};

-- 
2.43.0


