Return-Path: <linux-kernel+bounces-857165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E229BE6121
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C803483F29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC623D289;
	Fri, 17 Oct 2025 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mQPmpdtV"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B222D23BD13
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666219; cv=fail; b=S/O5RvVmykXhuFOT3ouwmxRXb5DfWGq9mfjhRAptKlXEePS3i9EjlvYJvn1AZBMKlaKtde9vGGiFw8qr/I1NAeAoGriszixQAVO/QruW6th2Au6vq/hMsEY+W5flerZQOwTJE1hAwfRM9rZv0iAiTcw6YLUV0wazx26WKuCM20o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666219; c=relaxed/simple;
	bh=Bw2lgLby5j8hoag0WHeo1GH8bTzU6YteGGcBbp+WW9I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=czWLT1UMxidvcxb8djreb9VRpxsYqKs9sl81qNTflqkRZrTagl6wTTPkXgyMvNzUiexX3YfrxmlW36vabimVpbE/Olk6LZaAh9PTdAMef411v1iyhLwuN3lNiXdRHa44kB/IgvT0x7Zlpep6Pfvuo6FBQXQb7DMG+8shKEw8k3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mQPmpdtV; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wpx7scvQR1Zov9vei2/Ku9qZUxYE7+QeFfuK19Lw6aewNjkUAhd2lGs92oF98OXrbAWMsvj3IXeHkssigABT9Kop/LQHeXqRq3R67NzZR++74SLEofN/c8CemOqKG9Lj5QiqwUTAWpttlfeo4+1od89FXyJVpMQ8uG0AIL8MAONFk2ICN3A47dE8+iNmr/PwAltiGIgLHSVpzmcQgF+MrM0YDSkr4pPbR03/UGffu+kWizTolIb4gRgpMWQ52ZjERQILJYAscblEldH3HNI76+6gBl/JNGh7em3yNrOwPYbM83oMDzhXlF1g+pus34fDAFlo1utza/jfBwj47HGTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Jl2bb/w82zn/TwEH/xfCKKIQwN1lkDwFeupSq4YJZo=;
 b=AM0MTKwHNNLHZqkeMIHqwcdTuORaCNp3nTgqjB7vA9vZv/ToaHkllfmaX6ylcLrTTUXHlForN2nNsDvo0GEPSLYV7W7GmvAD2rCNi6zYnLkJ5yXsK6CL7dpA/W2N6vzsFJfaVTL6Q4DEC3S5ULqLHWCvLjqYjjusKM0XmxwB84Dcgl5dEXGXMg5koZq0dPA8X9uVbw+6nvwCtf/Fzcl7iw0beLJgek23jZBhevwYWh0n5jJRDlJmzFYnLobUYKFpUlbBlog5IN06q912TXZPg3WItXkRr0HkbiV569qecsLhcBz+eGQVG3Oowa2CI+o/x1GC4UcbJycFveKVnzminA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Jl2bb/w82zn/TwEH/xfCKKIQwN1lkDwFeupSq4YJZo=;
 b=mQPmpdtVIB/KwH1ClKy+95n4HpjHxVowbf8cL4OV+nJIl9yU/qLPomeGyQKqWCgYhnX1ww5W8Rm624izuh0+Xs3EQWXMg9e/yU+sQq54wbBNrtCcjJr6KU7qMZfvjsCuNciaQiggn9y/vS0kUfYmyQHgKn809kTmD0n8qMGJabBxlBBC/21VdIEwJxhOjXKfG8P81eBgXUoNJ7M1byH063iIk1YUPRuZtHPOFFaGG4PfShE3wePDlbHW+NGD2t4RfYVqBHvF3nQ5iEWZPzQELOVSczQxtOHMUPlVzyxmbRBCyfTuD9fHvMFTNwnpNDWUdLzC95S0ef4ria1/grOr4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 01:56:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 01:56:54 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 17 Oct 2025 09:56:26 +0800
Subject: [PATCH v2 3/8] firmware: imx: scu-irq: Init workqueue before
 request mbox channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-imx-firmware-v2-3-b58f68ec2ea9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760666195; l=1302;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Bw2lgLby5j8hoag0WHeo1GH8bTzU6YteGGcBbp+WW9I=;
 b=ikg4Whx8SzgyQTJPnE5BXEVfvMKmQgISIet3pdfX7P3PDA/kgwJMz/uKgTuwgXmNadJhQ78YE
 d2BkoppnzPrCfjiX4nZB8f686GuOBRCJ2E0kRjiNzo0v2jMi0RqikNE
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
X-MS-Office365-Filtering-Correlation-Id: be4a2adf-e5ec-4646-6f86-08de0d20726b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHcySzREM0ZmNGgxdkxKSWs4NW5BRTI0aUZtK2RyRVVhWU11NDFLQUZ5djU3?=
 =?utf-8?B?NWphb2VwaXZ2aDZDUTZ3S2NzQWlhUXpnSm9lZXlIbWNkZ1lWc3ZGK2NCaGk3?=
 =?utf-8?B?THVmTzR1Q3hHRVg4cktaY2VVZ0JHakdqQk9zZHhjMVdFK1hIK0RLUWdodzR1?=
 =?utf-8?B?bWxCc3ZuSHNsQnp6L3FWeFhNcHFlK25yRUM0U045SGVVTlkwTUNmMnpCVklX?=
 =?utf-8?B?MW1kSUxwVUgydER5aE9DVHJjeWRDdDlqY254eDkwcXdJclBWL1VYL2VRSUd1?=
 =?utf-8?B?MGsyV0YvU2h0Tmk3dEE4c3Iyc05IMll3Ynd5d1dIUzhyNlBxL3NMWnFaWFM2?=
 =?utf-8?B?OVRTbnFiOHJtWE9YbStBZUtxbGUxRVArSWhZekNBTHN6RVFrdStzSDhiL2Ri?=
 =?utf-8?B?NDlyb09rK2o4Y0tkVm1hdmVoYXpIckZEQjY1ZkNVRzJIZGFPUk1QTDVYcVJW?=
 =?utf-8?B?SnNXeWRnQzhNRnhzU1ZDdm1DQ05pT0QweTI1QVU2azZyL2JGRW1jeVBEZTd0?=
 =?utf-8?B?Lyt0S0lmODVxVGdJZ3hjYWVhaGVGQ0oxR0RnZjBYdjhNMWhzbDBBUE5qb3Vk?=
 =?utf-8?B?ZHZSQllkbitHMXo0c2NJbnlPMGJxWHhYSUJIZXdSNkR0dDVNRDNxM21GdnVX?=
 =?utf-8?B?emtsZmU4REg0V1o0MlhaVmxBZ3V3dWo5b0NEY1Mzbkp6NGIxaVozVWlLOUI2?=
 =?utf-8?B?SDZGeG8zbllFRnA4NE5WT21STllCL09HamlWVEtTWEJ4aXcvWGdGeDl5eVJl?=
 =?utf-8?B?TVdiTHFVU2hPQ2p1NG5zUklPVnRaTEc0RjY4Rzk0bGQ3WDJCU1pyYnJyNTRp?=
 =?utf-8?B?NVhOZnBweFNCNDNsUnJxL2ZCRmo2cmJmVmtmalBKeXpPR1ZoZUJNSjVCdHgv?=
 =?utf-8?B?aThYQVZYckw1SFdqWHpNTUwzYlFua2N1ZG9KS1JocVhZUXIxbng3RjJXbmtS?=
 =?utf-8?B?RldlNmpuWnd0dHBBMWJWNk1YcGRMUDltczNvVjg5QkNpaVg4clowKzRWSDdL?=
 =?utf-8?B?SC9jU0RtcUJkZlF6NE5FV2UwL1kwemwrdlZSNnVPUW1QeW9sbXdUeHFUL3Bo?=
 =?utf-8?B?d2R4YS8zTytKUE03ZU9hTnh2c3Fyc1Zrb0RMZkJXUTE2eUNLTW1EL21nSmNw?=
 =?utf-8?B?VXY4ZGpmeXV2OGJqSERJYVFOZnVMcC95djg4Vm5DdW0ybU8zZytSejNIMy9t?=
 =?utf-8?B?MWo0RzhWc2J5SVUrWSt0R2dJbzJYUmdVaU1QbnR3WXJKdy85RmdHZWc3QXIr?=
 =?utf-8?B?TXB1dTRZNXpnMVMrcllPVWhtYTg1Qmh6T3hRaEZ1QzE5dzJXQzhrNkIvQUF4?=
 =?utf-8?B?NE5oWDJwa0pjYUF6QlBPN0cxYXl4MkVaV2JFUlQ4ejMzTkVtKyt3cDJBK1BI?=
 =?utf-8?B?a1hXNDFFZGpBclZOZEdYQUlPYmRBWUlmTTZlVWZET05SV2NQaGxpMkQrOUhx?=
 =?utf-8?B?bUsxNHNjK21aNGpDZHRjRHFvTjZ6TTBNWTU4TDNES01KZlZQY2l3Tk84Z2FY?=
 =?utf-8?B?QS9XL1h2YVVMSnlmVkxPazg1TkY3STJ5OHhOUUlkTU9YanVCNXRmc0Yxa2ww?=
 =?utf-8?B?UzJXRjRVUkRYSTNpWTBCZWJmUXJwMFhUM0hXMmZEcmZVU3pkbFNCQk0vbDQv?=
 =?utf-8?B?cTFtRUR0d3FBZ0R0UHpOODVnWlFZZFZ4TmMzWi9BSlE0QnZtS2NubGRzMW0v?=
 =?utf-8?B?Q0Y5bXowTm5nVlNsbEsvdVMyeDAyVUxWbnVTRGszYVlYS3hvVEtGNkZXZmtk?=
 =?utf-8?B?cWNIN1EzR29hczg1b2M0KzF1TkVuT1dCaEZEc0VHWlpKby9GUEFjMUM5SnJM?=
 =?utf-8?B?YmllbkxIR1ZvTkhYbWEra3RlcHR3eDRqcFlCTjVIY1JQRTVSWFFMak8vWnJU?=
 =?utf-8?B?ZGE5SmVMTTlEbjlucXo4SjdDZk50Rk5rYjBUNnY1dDA5ZzM3SCtHL0tOaFJD?=
 =?utf-8?B?NGhocWZTYVR6clZSNHc4TkMvWmNEek5BUDdabllpelNUTlRYME9oU3g5N2xv?=
 =?utf-8?B?YWNwUDh3SzBITzRUNnVVNW5tQzlrVE9DWHhBbllpVUV1TWtyWTJxdnlWTThJ?=
 =?utf-8?Q?CaK/bE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTVJYWJRU1k4VjMvUzVBUXowQnA3a2FyYWNMTXRSd3BSb0JxOUxZUlZMSzdG?=
 =?utf-8?B?WmpGYW1qTkFwQS9nNHcvR1BnN3VzVTlmQ2NvMVdnbDNwUzU5aWpUSndWcnFI?=
 =?utf-8?B?VEdwWjhPelJ5MDRZRzdvc1N6NTV4VU5VSWMvT21CMytQd2FNSUV1TUxJZDFU?=
 =?utf-8?B?SXkvL203RHkvRDAwVlA1a3lOMW1lazZPYlBQS0RWSmUrMTNISEMvcDgrY0Fm?=
 =?utf-8?B?WE1vcXFTakNLYWtPVitOWGZ1SmxCb1dXdnBNY1U2U1V3Z2ljYjhiM0hPeUl2?=
 =?utf-8?B?QWNFK1BjS0V5WjFTQ25WRWhFcVc1QXhxdVVGbFN5QnVzcWsrL05OTFhrL2Rt?=
 =?utf-8?B?S2FGcWt4NWZScC9qcUtWTTFZcE1zMHBOYXc2SkpjN2FZVDFZL2xlNkM5Q0hN?=
 =?utf-8?B?V1MxQWlUcnNYL2pISGplTy9hZzlHZTR1akVnMjkxK2UvSWdnQVZ2REI4Q2Fj?=
 =?utf-8?B?L1N3aXZoeS9BS3RPUFpXbTFnczVsZGp1NXYrMzdzaXVPcEd6a2FHZlhsMjZS?=
 =?utf-8?B?ekJLY1E1MlhNOENtR1B3RURyRnZsemxMb0JBcWNKMnNTeGdtTVlIangrTDhi?=
 =?utf-8?B?OWlKemd3eHpZbHNIZkVHRlpRclg0dkpxRmhKMTAxQ1ZQRTVRSFM1RXJrSmhV?=
 =?utf-8?B?MlgvUlV5dHI2K1dCUmZuaGdEdTYyUEVVNDg4SUpsQTlWbk1hVklsaGpZNDRt?=
 =?utf-8?B?VjhhWG1jM3lheEp6aDAybUpLdzdBdDdaK2hiVm02QVFHUGgwdWptNFRnNnJN?=
 =?utf-8?B?OHlmNUxmMEczMlZidkhVcTlqeThQQVRuYzcvdFJCR1pFeWtobUVwOHpBWnZ0?=
 =?utf-8?B?eXFkdXBiMEFXdmVtWWxHSVNMT3JCMkQ3WGQ3b3poc214enlPNDU2RmZmWnJ1?=
 =?utf-8?B?d01pb3lRTFRLQ3dKTU5BUFdPK1dXcm9TNjRGc3lKdkx5Z0JpWm5rbkR4WHB3?=
 =?utf-8?B?YlFER0czUFFmOVZtUWhaa0J2Y0pKVC9Jb203Y0JpNng5MXhqUlVuWUxLUWts?=
 =?utf-8?B?ZUtxbHFNa3ZlZUNNRS9YNkI1YUVuWXZwYy9SR25jNlp4RXc2aHdqU2NKbWxh?=
 =?utf-8?B?SEFiSUE3eTZlUlNoSUIrcHE0ZFJ6ZFZNMG9tRGlod05VZFBvaFNzaWZPNW93?=
 =?utf-8?B?RWlIVXhXR29IZ214YWNEQWRLNC9EMXozU21JM2lWb3gyMUs5cUNQK0hURUhY?=
 =?utf-8?B?L0pGUWpkV2s1YUYvL3g0M1VvTk5tVnd5aFNabDZwWVR6TXM0V3NPRFBEcUZU?=
 =?utf-8?B?MWNtVm4zMnlQMGFaNHZwRkcyRDYraGdPRjZoczlZUEFnSlVzamRhUkNtMERQ?=
 =?utf-8?B?ZjI5M3VIbUdVOGxxN0VVMm00b0laa29adzQvZFZXOHcwYzZMalZmb2hzeGdJ?=
 =?utf-8?B?VkJ6bmJSZFMrbU1VeStvdHV2RnNEeTUzSUpEdVBaMmhCek9ZaGNNSVNRVmgv?=
 =?utf-8?B?eWtvcUlVSzJKcFlORnJZWnRhbUprZWs4TmZJdTloRk9IS2Y5Ynkrb1FCYmQz?=
 =?utf-8?B?YzRRVERrQklaQW9vMUNaemw2WDJDb3pmbTNxRkZPcTJ4UFBuZTJ4cHh2RWZ1?=
 =?utf-8?B?NjRTMXNWRnBVWnNoT1lJODkyZ1JHcG53ZVVmZ3pDWDZONVFKOHZYTXVvZDBM?=
 =?utf-8?B?WTlmdWxhTTc2M0ZtNWk4dm9IYTAxYmcrUm84NVBsUGQrOEZTbmE1bzdUVEJI?=
 =?utf-8?B?emYyMnJHRDVTS21YSVJNUVNYRlJSK1RaKzNnOWlCa0d5WWhFOWNyL2NNVTZV?=
 =?utf-8?B?Zk95SmxmeHoxeUVTSEQ3anlySjNBZXU3eEZXNkNzd2dWdlcwTHpsMzB0ak9y?=
 =?utf-8?B?MSt2Y2JaUFgxeTFlbUI3SkJMMjJtSGxrSHpya2xRNVcydWpVa2JFOEFxTFFj?=
 =?utf-8?B?Ui9zZGJLY2lybFRDdFFnbTJDdlV6MlVXbWZRYUFTY3RLTE5ZU3dqQitHTFBz?=
 =?utf-8?B?YzZtcitDTlRJS1YrR2x0N2p6VlJDMWw2OXlneElNeVpzK2kySE45ZFpuSWNQ?=
 =?utf-8?B?cE9lRmdMVE1ROWltRlJIbklabVprb2hnc0JEdEM2VHFINGk5NU5aSjBUM0Jy?=
 =?utf-8?B?bXhwcFgyYW9TY21DMVliNjhGUU44anhDQnVIc0VaWWs3V0FiSyttenFQSlBB?=
 =?utf-8?Q?G4vRxgLFUvTaHH/WhkUkKMwMd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4a2adf-e5ec-4646-6f86-08de0d20726b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 01:56:54.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjBflXZqAXvRLcibl1UrvjP0fjUMFi2gV6MEin3ojf1kwR2z1BcGqaGRizndiGNZFrKVTTHLKAIM2GjPon42hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

With mailbox channel requested, there is possibility that interrupts may
come in, so need to make sure the workqueue is initialized before
the queue is scheduled by mailbox rx callback.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index d6fd04404e2a3113a6d22b1a580e6c0ac48f5975..2d7237188932632ffd4960796c7e73b69ceac7d5 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -214,6 +214,8 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 	cl->dev = dev;
 	cl->rx_callback = imx_scu_irq_callback;
 
+	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
+
 	/* SCU general IRQ uses general interrupt channel 3 */
 	ch = mbox_request_channel_byname(cl, "gip3");
 	if (IS_ERR(ch)) {
@@ -222,8 +224,6 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 		goto free_cl;
 	}
 
-	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
-
 	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
 				       "#mbox-cells", 0, &spec)) {
 		i = of_alias_get_id(spec.np, "mu");

-- 
2.37.1


