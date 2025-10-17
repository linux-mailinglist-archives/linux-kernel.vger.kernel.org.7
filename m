Return-Path: <linux-kernel+bounces-857167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29886BE6127
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 527694F6A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D21723EAB9;
	Fri, 17 Oct 2025 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b7o/4Rz3"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F8238C08
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666231; cv=fail; b=qrkc0wwg+ASim3t5694bL1SwAl3XTYZZnyhcWa1pK+zR2oexxj2OkfdGKHRLRnklp5AIit8N9vNtFgZj+baz0wvjX68zjtaIcbPmvvGdH7N3mZ9kC3gE4FTk4SU/7gPXOcWdsB12E5o64P6+OPWB4XWb3v5EiDXaP0qSNYWoTto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666231; c=relaxed/simple;
	bh=LgVLGmpBhZ5qgahlVYd7BPYI6KUuqQZs8Vvk/XBLS+4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ewf7DkGeY+OKRBgKes0EBZWg8V2avlW9fCDDYOhmEClBYgIVQRQtx/oPKN+e6pqdFulifRBgGg7JF/zaVtQ3t2pO6MGeT+/9WovdLbhXSVyBnVl1A7LLanGlUCs5pTneVlo307mJAN3WrtRI7AZLUDh2ILn+M9HrQLvUGYZNrNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b7o/4Rz3; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8x+CN739Yuxzx6+TRGKlBtCRDYvQ5wQeb6bZD2HVfQi0MiNpFR3ply+psYwJc0c8PZpBoeiHURdy/a+Xn60cOm/z81i+RX4isil8AbIzJA8Rv2RheWhW+/jp3k80VltuUgXLHTEvXbR8w3j3HSY7tsYcS6l8Q9aLlMzMomGfswU44vUn5e/Bkb3TODgbSl9vztGmsak9kcqPWctHWfrG6KmLshZ2qbX7IHrNiby99u8qbswseKSo6dTc92Pjz/nEd0tbD8FmBrUoXeh0Xu0yeAdWAQN+1bRkt0jr2bovSZstbq9VmfBYHE9MakoOXxXGrexonm6db2HC8MNwT3Cug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NneCWIPQAVbEhgmJkUQK8BVBrwWhl1LF7m48NdRN/zY=;
 b=tRHC9UidtozduaPiLXrSJxypDuwuDvyEkZvzPl4vIzKXaLp3/JFwr9L9wn0AIlgXeFmzHaIRMc/ONkhUXe5p7Yf5SoHdTObUIZuCw9seRGPPvXQYXa4LreQrduMOgjyMVY3bwpS4vFRTPXH4CeokwZRknvwFWWjBsTnGLjsOcgCl/k1ZG0fxdTHy6Aobpr38zmf5Yj2FPDad1/KQeAJf3+Vu9UbgFgYtUMAuM6KJKLV0ByJfofCt5dD35wPYNzSaceIU/v7FW+b5m2AL+lEzeFMg3dmWiDtg30cqS5jotybK57XHPZlQArePtyOBzQUtNYBQfo8NHOW9pp/0AsLStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NneCWIPQAVbEhgmJkUQK8BVBrwWhl1LF7m48NdRN/zY=;
 b=b7o/4Rz3b59ysKd9Hp9beNiTprHjpAQfm0MqVZnRtDhIXxVn6jbDyLuTwOeNrmTRKTirInFBO/TBmi//cKc3j4pLJM6Mv6lt7zbjESzpvYj3lWMwI1u7zAQPFyHSBcsMkqX+yJ4qNtb8VnewtH5F+0aFcB0VSCbxSkQ0ji+EUK/EW2yDnN/OBsY4vco0WTPM9o/AuarnLxc6ekGK3wG5SdD1cg4hfYh/BykeWLZujh5OoLgsavUdmQXfTTxKkG0Z9yXdFsMfQmbU/e5gTxmHuFbZ26G+dRfKIivecYP+p/t3pXZYl/f5zayr3pbalaLGTiQsn5wQ+ijiOZPTjYJXZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 01:57:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 01:57:02 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 17 Oct 2025 09:56:28 +0800
Subject: [PATCH v2 5/8] firmware: imx: scu-irq: Remove unused export of
 imx_scu_enable_general_irq_channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-imx-firmware-v2-5-b58f68ec2ea9@nxp.com>
References: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
In-Reply-To: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760666195; l=880;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=LgVLGmpBhZ5qgahlVYd7BPYI6KUuqQZs8Vvk/XBLS+4=;
 b=+cb4HSVrKN+lmwzOD5NZvFrCRNcoK+Z8iFQntYg/MhLyLk5V2APWXi30yFyYcEJ2fbrrbyZLx
 hNM0bwdtkURDjsFK3PLYz0/wUtcN+wRVQOzhmhFtYOGwW2Q930bRaGL
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a85dcb0-ef7e-4bb7-dd08-08de0d2076f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFZyS1dGeWczTVZtZ3UrVmJKeExTUmFKeVRtUkw0Z2JldE05eVBHVDkrSjha?=
 =?utf-8?B?cUl4UjFYQUk4THc0eFAvSUdLRGdLeUQ0Vk9vYmNiWUZjK0tKRzlMSjRpbE1R?=
 =?utf-8?B?eElUYTg5NzZsU2xKMldNWVZQenNETEY2N2xQTDRucVV6T2YvQk8rUzM1Umk1?=
 =?utf-8?B?VVZZelMvTnUrSmNpY3Zac2Z2ckkrWUY5YjhzdGFtS3RkRGNYL29rNTZQdHE5?=
 =?utf-8?B?NzErVTJDSE1DNG5Zdit0UUo3S2ExQWo4cVJBN0VtdUw5c2xhV00weGVoU1d4?=
 =?utf-8?B?MUx0WmdqZ0c2OTdVYzlWSDJGaTVCSm03dVBad0RhbVF0ckthblYyWkZqUXRJ?=
 =?utf-8?B?bDBxMVVKSVFoa2w2TjhHNTZSMEF0K2lCUmhpaFZ3czg2ODNzQ0VNMUFOTHZn?=
 =?utf-8?B?NHlwMVp3Q1gyZWYrZHBXR05PTlEwTWJFemdNanpOb2tJT2lXakhuUDJzTnIr?=
 =?utf-8?B?bVlaWVpjUmsraXNwQ2xOTjMwRWdRUTFJODd6RHJ0c3JIdFdXVkhjS1RUQXlK?=
 =?utf-8?B?S0J4NjBkdWZQV2V3bWhMajQ1NzBvOFk4ZTU3VTh2cXUzRzJ6QVljaUhwRkZS?=
 =?utf-8?B?RWRRUVBZVFBuWm4wQ3U3L0xCaHROcmlMYzU2VnpuM1hRbFRQcHZXWk1MN292?=
 =?utf-8?B?NGQxOGRxWDhVMU1wMDFzYS9HUktyTnMvK05jUnJVeWltbjNNWEZYUjVtczBh?=
 =?utf-8?B?MDBuTEdyWkF4eC96aWIvNHczUXNlRERaUldna0NxdDU2Vk5XSE1GNjNHZVB2?=
 =?utf-8?B?eWVnZnVtOFpNVHJvMi9ocFFaMnBjdnIzQVo1NTljYTlqNFcySTZ4THBCV1ZW?=
 =?utf-8?B?L2N1S0w0V1N5TEV2S0tRby9ySlluazFKSlhmbTFaRFU4UmtqTWd3YTF3R1hC?=
 =?utf-8?B?ejhvcUNtWHlIV3paZ1N0WmIzbGkxejNnRkd3aDIzOGJkQnI1eGZvNjJtUG9n?=
 =?utf-8?B?VmYxaHZrZnZTbkVaMGtBK3RMZXlLVHJFcEFQb1YxMUR4T245UzBhR3ExY0xC?=
 =?utf-8?B?RDFZVFVrdElPQjQ4eXM0SXBmNFNBVjRUNUFMOW5UQVBuVlRLT0FsMG1wRnRj?=
 =?utf-8?B?WUFwZ2F0VTNZTnJxQURLSlJTeWtvTkc5N3grMkxSNk45ejhJNnNaM2pCLy9V?=
 =?utf-8?B?K28zN3J6RDE0MHFMY3JQazU1RWw0cTdWUnUrWGFxb0xmYnhMRkRkNWpMUzhC?=
 =?utf-8?B?SEwwM2tNWjN3K1pUcWZpdGo4UkNYdUZZNkhlS3hLUUtRWXJhQmI1cmNWVVBx?=
 =?utf-8?B?VS9IV0kzL0o0c3VEaGdKeFNXbndMVmVDVG1KMUtEZmkzbzVYNkJMV3ZBejdM?=
 =?utf-8?B?UGJ2cS9OSTljNVc0dzNBb1pFWlVVaG54NXNvRUY3czVLazdXMG4vcTMrRit2?=
 =?utf-8?B?L2tYM2J3ZXJWYTFadXFiU1NLNmtjMzBuYTBtU2ZTa0ZoalJuZ2hSRnVFdnFM?=
 =?utf-8?B?U3NjMEJobjEwTmp5eGdLN0cyTWprcS9oamg0Y2tBVEhQeHpjbXQwMU1aaVpB?=
 =?utf-8?B?UEdFbTFPeGhIeS8yYlNyWStBcVo2bkk2eGFURFVoYkV2VFhTNUZ1RndOT0lp?=
 =?utf-8?B?TE9DU2pUOXlsQWpIRytDdVp5MmxTRWFraG5vSnlRb1dJdVBtVHBKZlZkdE41?=
 =?utf-8?B?QnZTSWlwYzdFNFkwbTAwTDRFRU5YK1BPUFBJeHBwMThvOWFiZVFnSVdDcXpF?=
 =?utf-8?B?S1gxYzNZTXdJUDlFMHF1dFVPOTF5WG1RZmFIdXVIYkxzdVNSQkExWGljZ0g5?=
 =?utf-8?B?N0huSlpEcllhZ2JZL2c2bnRDOEJYWXhXOUo0MDRYcVlQblpidldZaWl1T2Fl?=
 =?utf-8?B?VFdjN1hwb2g3R1B4N2lzSkw2TXcrV3BScTJhQlBxSjd4M1UzdVZONEVXRXlH?=
 =?utf-8?B?VjBkRjhSZEkzdnhqU1BreDZseG1OYzVCZDNFOVlDTmlNcHcyZTB5V1IzbEtE?=
 =?utf-8?B?VHVIcWRhNnJHWVBLVXdkZ2xtQ29KZ0JEb3hTY1c5dm92c05tc0V3clVkY0VF?=
 =?utf-8?B?R2pKY21XaVFzMHNuV3RLcmM5OEM5WkFVMjAzY3pqdUh1L1FVbFJ2RFQ1T2dZ?=
 =?utf-8?Q?Wh2s4t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDg4R3E3UFVxSnQ4Y1dFOGM5SHpoanMyelJhTDA5VVNnRDhqTDIrM2gySWk1?=
 =?utf-8?B?MUNvd2NHVlZxSklSTUJZUDR6bjR3RktNNUpvRC9meVNuNHIzNXlkb3JsK0Y4?=
 =?utf-8?B?V0JhekViQVdDZ0RZdURzMUY3YThjMkQrdGpPVnMxU1QrQW5kZENneFNkWHk2?=
 =?utf-8?B?V1lTWEc3SXJsRGx6MFVtMjF1TmpZaXlCanZ4UWs3Y2ljVVFSWXpoMHpHOTBE?=
 =?utf-8?B?TFFPSDJSZ2hCVVRrNy9velA1RTZEdnprMzR4OFhVL1JuaWtrcE5TVUNkTVVy?=
 =?utf-8?B?Z3I4VFlzeFRqcXE2QkNDMTUvZzVydWhZbnNzSVlRQ0tpWnNNUm9aY3lqVWk1?=
 =?utf-8?B?bDJWV09wUFBsVm9FR1NFbjdBeDV6YVlJOG1FZ3hETXJQNEtkcnlENCtUa1lE?=
 =?utf-8?B?QWlGRDdzTW1oTGtKNmYydW8xclRNVmloS1lWL25GM2dhSWlXNVh0OCtxQVd5?=
 =?utf-8?B?MlJYRklqaUJJaHU3bEJCbzJaSWNYM29LMnBEclFqTjQvNHEzeHlmTTFTME5Y?=
 =?utf-8?B?Vk9zNHlIa3pwbklORzU1c3hIMlZaTmpXRjdlYjduZmtualVKalNVWWhTZTVs?=
 =?utf-8?B?UFBmdzJnOTc5UFhPd01MZEorMmN0aEFYSlhOWnNJYTFlNDJ0VFcvTy9sS0pT?=
 =?utf-8?B?dHFWUW5YZk1Ta3lNOUNsbThjZVliREptNkYveVd1cU1SZmhDY3V2WUM2dEJV?=
 =?utf-8?B?VTR0M3lHNDdLcHF3YTkwSVQ2U25uamV3S1l6YUZOcGNyMUdpSUV3Q05lS3hE?=
 =?utf-8?B?QVBXbnJzajU5dXdLL2YxWDEwVFJBSUc1KzV1NXk0QUVIU3M4RnVUdjlTNjdM?=
 =?utf-8?B?RjQ4TWo5bkZyd0I1eitvaTMyQnN6VlQrTmNERkVhT3JLdEo4ZHhDYitPemUw?=
 =?utf-8?B?UkJiOGQrRmUvMituSmptcjJSMjV6SmZTYUxKZjloYmRNVlV2TkM0WHJlWjhy?=
 =?utf-8?B?dVFjSTUrZWVqTEZNa2xzdm9rcHBEVEJhRGRkQ0NZZFI4OEFCd3BiV1VPU3lU?=
 =?utf-8?B?WTBJbmJKQnEvNTRORS93SVY1K1hsTmZHbG5UamhqQ0lXZVBtY0UwZGluSWRv?=
 =?utf-8?B?T2lqVElvcTBtemNzSTJqUmNGQ3JWM1VJUGpjaWVWSjd6N3JwRGdRdXIxZGZ2?=
 =?utf-8?B?dE8xNUxrZC9VQ05BbVJDeENTcnBsN3B6eEdkcmZZc1VzcHUrb2NMdnVVZ3lk?=
 =?utf-8?B?NlJRR0VkdVlyekJBK2N4Y0xQYUZ5ejlYb3lHVG1oeUh0ZFpGenpyYkF1MmFI?=
 =?utf-8?B?STBSNmcxK0U3aDhYNU1MTkRrbWdaTmlYT3U0NTBmZmgybWhUbGluUk8xZ3py?=
 =?utf-8?B?c0RINFZsU0dkdU9STDhjN2VITmk4RStXYVg3dllUamNSMzlsb3AyRmoxUWZo?=
 =?utf-8?B?MlNRK0w0WUUzYUFvbFZPWHhjRXd5cVltUy9jVlVMUS9CbEFUbnl3NkNsNlR4?=
 =?utf-8?B?MmhaWWtZR1ZweVRxcUsvMTBSUkc0NllUSEcxRTVzNllFVU82VDQ4MnZlemtF?=
 =?utf-8?B?QjVRZnU1S1ZDVUZ1QzAvdVpkek1XcTg2b3ptVldJencvdUdIUmFEc2xMaEl5?=
 =?utf-8?B?dDZsV3d5Wlp6WXhvRU9mSmlRSGRlL29PMk9YNmtxNmZOdVhsZXVvQmIwRTgr?=
 =?utf-8?B?Y1VCdTFlZXRUcnZXakZ2Ylh5RHQxdnF3TmJ6aTVwTGZJaUhrVWlqK3NxNUdi?=
 =?utf-8?B?aTNVMGZheXVJM2tWWjBCYUlUTkk1UnhKOXlpN0FpRGxTWkdiUWNodkpJaVRV?=
 =?utf-8?B?L2x5RDFETHkzZ3lhOEVqOEVVQVNjdGQrUVNod2hZdVZjK2xwKy9QeUFZYXlC?=
 =?utf-8?B?Y21aeis0bHRNTFMvejhpY0Y2QU9qd0NoOEJXMXdXWGo2N1BLSUJIVmovSVE2?=
 =?utf-8?B?MzlRMlBGdUhKRnd2d2NJN3lqT3dWT3pveWU5dXl2WEhtY1V2UXUrNnJmWEtz?=
 =?utf-8?B?V2Y2N0NZYmk0MThYMmcvdmptajR0Ty8zRGVNUWh2MFhnQmF5TklJNUNMMXVv?=
 =?utf-8?B?RTNtQzZJaVZYdDBPVW0xWGJsYUxaajBVZGFaNXR4dkd1WVZGZUdzV3VhVVFo?=
 =?utf-8?B?NCtoVXNQb1gvRDVXRUVlSmJJOUZmM3c5VUpIaEdkdjBYSHdjdldicSt1MXpw?=
 =?utf-8?Q?5GQeUDe9j7bkC7nA5/S3zbmaR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a85dcb0-ef7e-4bb7-dd08-08de0d2076f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 01:57:02.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1zQownyq+uOeZHQlIgDK73gq0j9MeM3JGfY9XO74Jz8TblCUHE9NWsKk/8VKY/E2ejNK3JSj3mb/lCCpo0lYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

Since its introduction, this symbol has not been used by any loadable
modules. It remains only referenced within imx-scu.c, which is always built
together with imx-scu-irq.c

As such, exporting imx_scu_enable_general_irq_channel is unnecessary, so
remove the export.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 3dda42be4e6b9a0df0b2b1ddcfb64dd112007e02..a68d38f89254438c33588c3e17ce2f811eff0840 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -259,4 +259,3 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 
 	return ret;
 }
-EXPORT_SYMBOL(imx_scu_enable_general_irq_channel);

-- 
2.37.1


