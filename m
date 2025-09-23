Return-Path: <linux-kernel+bounces-829621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBCFB977AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB232A6E65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508ED30C103;
	Tue, 23 Sep 2025 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TFX2Z3ic"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D4309EF0;
	Tue, 23 Sep 2025 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658992; cv=fail; b=hx3n/d/A/0mlHzobOFRwq34+EZOug14iQ54JOk04VAsFK+meI4yqSerbwn+wPLFqittE+5qW2e9FAC5rJZDI0VLM6nf73eIrztoUbM5EErocqxsz28vjAHAbmfmKVKuwiOqdhq5d5GqGffd5cJtySNCfvSS4MbRUGf0FvjqJwNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658992; c=relaxed/simple;
	bh=URRSlCVb9ReBRc9OzF3Yn/Jqw0I2Ui/6WdqQ+/P2aJg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mVetWUZZzONp76ujoFln3VZfZXt5ngX3TU74e1DeCgRa+cMnlmvSYFAxjWPe96Ze/pJBogAWaj0jTRqwNTw2N0Lm1JaMCCmNt6ZnM74Ij46/oxIILb/YJEgozrJr2ia74WPRauI8rMKXqdHGfdOMcS5YxCOKiwRvdJBN5eWt6F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TFX2Z3ic; arc=fail smtp.client-ip=52.101.84.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vpb34Ikw2zJT6RKSAADRUELfT0g3SEQdO2lmB05Z7m3TUIuQgzfh52uzhOuv4x158Jm7Ohk55sHWUXH+BqM1wE38WkJgV+vcwfe4bWCV4ni1VgPruzcgF0CwgUqmft4PgBPkoTjLG2KGCGwWY0o+8v7WoytBcuhBsDdPtOInWFuDBd5RGur2ed6Za/MICQ/fg6YoHia/HckkGqS6MKc5qy6zgetdPE/kIP+ExaGkCaGvFgpmHUfG94dHzho+Vm6jbbDB5B6xlTnzdjQScMU+ZlmCJA9s3mXe1PJyI/+lm2UNn+MI9ipVQajDfnpYM5gKDHr85uEuFjNdMIphZ1+9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBerYbOctpmNpJxrdAF8ys6otlyrkfF7Fef/6aFpFyI=;
 b=Jz7Uuvb2z5WoeH0H2/kOqewpZRC4nUUw0T1966PWunFMIBtRmUodsRURjCbovtg26X7ISGqGuMiMnYY1DhF77PxjWAgY836sE2sTOynW1itEApbBcP3jnkhtz2Me374pO4JZi14vRcT7gtydJ9qD/Kj/5l+d4Ejnr0fHYRk1bukF99jEVHQemuQ7DL7FkI5X2PPahDNRk2UIoPISrYqVA+fCYkLRoz+9ReOUA/xth+hvwc10nNzWbP6AVI9P1Y1yl2xC3t8VBQz/IvQMyHMpOheH+KAQFtIZqAlfUmB9cgd4JI5bJCPbvEtgnxPusyOECtre2ylnDzrz8iB7gDvtjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBerYbOctpmNpJxrdAF8ys6otlyrkfF7Fef/6aFpFyI=;
 b=TFX2Z3icTK9OQQH71Rv/8TOZ0GZoEb36LAmTZMBeXLDOXcNjyewJJXLtyudXSZka/5UbSdrzxXEFh+/bRuStlHcp5y/9JDUKOPtCA++dyBO/P2/G7733mY279BtDl9ob8/dJln3LW0EUn8yKH+FT228pwxdkCZtcum94oN3nBfRyyAa6f1gp/0EafmJfjrokwZUIEcjSWxtwZvTVUbC78qLEbMqBYG7oodQ2ggEykYfayn+RPuq/QXahxG3AUg8MyhLIJOEgk2632+EYxk+MyjkWPu/L1YIZWD4+s6Jc4pgk6mC4ADtNaLlAeY6Z5D/NtHUF2IPdFVIudSRoE6RCcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 20:23:06 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 20:23:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 23 Sep 2025 16:22:48 -0400
Subject: [PATCH v2 1/3] dt-bindings: usb: add missed compatible string for
 arm64 layerscape
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-ls_dma_coherence-v2-1-ce3176396bdb@nxp.com>
References: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
In-Reply-To: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, Frank Li <Frank.Li@nxp.com>, 
 Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758658981; l=2339;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=URRSlCVb9ReBRc9OzF3Yn/Jqw0I2Ui/6WdqQ+/P2aJg=;
 b=vrI/pdsdg7oZh3a+HwJiVyIUDzbtYj32zrT0tickb/DRqU2FaXAzSQuntXbogK7hqr/57fH7D
 dVcl7ru9tBUD+Xkvp6itYQk5laSgIAxdgsTSyz7ABOZajn1HG8qIeoO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM0PR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::39) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: d906caa0-9e42-4a7c-284c-08ddfadf013d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3dnWEpBUUhBcXFzMUR5TFRtNU1nbGp3dFdaTDRUaWpYZjVDTGVxMWwyZGhn?=
 =?utf-8?B?bG9LU2dnU0lRSStFaEN6ZEpVV0dzT1dyQXYzSmpTb0JGTWJOK0UyS2ZDbVFq?=
 =?utf-8?B?NHZKa0FUTjV3RlNiZ2pTdTJxZW9hUUJSVkhXUk1qVFNWT2xWWjNFVk1lQ0Rr?=
 =?utf-8?B?eXhKNXRNNzkxVDd5Zis5aVVoa2VCVkNtaVpxclFJdnVlakVVaVdOc3FDWXpK?=
 =?utf-8?B?UVlodS9haXdQQUFEeUZDamRqNjFnNVgyUWpLelpxSVdUTkM3QXNoNHdrMkto?=
 =?utf-8?B?ai9oMERETTlPREtCRVdVbW1sbkFWYkIvYTcwOU52R0VrZU5rU3BZSWFUMGxy?=
 =?utf-8?B?dkdhL3J6MnpncVRvR0ZsL3oyalpMdG5PWEVYWFNJTE5uZjRsaHNlL3dGbWNi?=
 =?utf-8?B?VXNXMVFiUFFMVjNBSmhQSnZHem1nR05TSXYrbXZpR1lZTlE1RjhLV0VFd293?=
 =?utf-8?B?dnRWNXlWaUw4N2JzQ2ZEdlBkeEhDZEpGYmVJeEExVzk1dTRTUUpQejZvcUdP?=
 =?utf-8?B?YXJXdlVNSWZmSkI4ZCtpdVZ6NDBMU3B5MFBCQTI4UG5Vc21zREpJekMxU3dC?=
 =?utf-8?B?b2oxaHBVVldJWmxmUWF6Q1FvTkRsZGs2NmJKdGs5RCt6QUthR2REK1daU0Zu?=
 =?utf-8?B?N3Nzb00vNXFuNWFuZCtNNTlJREd4enlDdHQxeE0wM0JQOGlPUUxjdkowM1pE?=
 =?utf-8?B?TndoZnhZOGdxN3paY1RXeFQyRUc5M1dydjZETnVsWWZVc2FuZHlsQ051MVcr?=
 =?utf-8?B?WmdzRGVTWWMvVTR5SGRTS1M2TnNIK2dKS3lJbzJlRitQYVZ3NU1OQnc4UGxl?=
 =?utf-8?B?eHZRQkRwUjRab3BjODkrTFJxYWlGWGRWS2VtbklmMGVhOWtzNXpwQjUrZVJ1?=
 =?utf-8?B?ZHF6QkIwZHpYZzFCaTltY01Bd2lRQUp1eGEyVThPc2paaWwyOUtSa3MxbmNB?=
 =?utf-8?B?THpWRmpyL3BqcGg2SHNGenRCQk14SE55d1Fid1dxdkNYd2NXTGw2RjlmT29Q?=
 =?utf-8?B?MFFaZFZMRDluYVU5UjVTODM0aVF3ZDNmTERFUlRReW1oemNwUEZQaVBvNFZz?=
 =?utf-8?B?aEgxZ0JwNXpudHJZa2JENkhVdDRRdUJwclU1UHg3WGpCM2cwQlBvdkFxTHRu?=
 =?utf-8?B?U0IzRmJ3aTVXNjVQL29xQnpTdklzV2kwSFhEVHBTb2VrNnVudnh2bkttTmRN?=
 =?utf-8?B?WlVlbVdhTXJjMUROWkN4VENhaTNTd3VpTXdWTDEwL0RyM2NhQTkxRTBOZG1q?=
 =?utf-8?B?ejJtb0lTM3RENFE3SVJQclFBYVZBY013TTBIblJTSUVBYXFGUlFKN1BJTmJ1?=
 =?utf-8?B?SDdQNE9pV2dqZ2NOK2h0cmRWcDlOZzl4N1NmQkpDVnFFcXlRMlpDM0ZGNzhF?=
 =?utf-8?B?L2hndzVFcHFjRTlaREMvRWN6V2VBSFhSb3pESWtUUnUwdjl1RnR0OXR4Ny9C?=
 =?utf-8?B?eUVvWldSdS9uTndWZlRSeDhWVzBJdml4ZXcrZkR2S2hzMFgvNzZZem5aZ3Yr?=
 =?utf-8?B?Sk5Hd1dzZFdJOGU3dDFScmY2VnVtQTArQkc2S0R4SnViMDZzdmdWcHhoY3Nk?=
 =?utf-8?B?TjVHMTl3Q1BOaUlMc1ZtKytRSGRSYTFCd3NocnJlaFVlV1RrRHRGeXF6OUVz?=
 =?utf-8?B?UHl0L0psOFgrVXNyV21wSjkzYUdnZFJRUTNpMzFaOFh4UmdyYmJucy9DUm1Y?=
 =?utf-8?B?azN0c1p4cHFzSDVBYlVHYURkNHQrOXN6by95Q1lKeEpnQWZYT2VTMDVXUGMv?=
 =?utf-8?B?OFRqblpCZmwwZXhJS21tWnFMTThKcENjZmxWV1NEd0ovSHpPUWVpdEhsaGNi?=
 =?utf-8?B?ODcyQXhRbHdvWVZoTXJiNmJvemxRV1U4RW5EYW1ZbXR4dmUySEVMdisrWFlP?=
 =?utf-8?B?aTkwK1puL1NmV2c5bmpmNHhJaVRoL2s2dVg4NmFkNUhyR3V1QXppdWVTTlRm?=
 =?utf-8?B?UHVYK1ZMOHJkY1VsaGJKcjVFZWZ5dEZZVVJmQTlzYURMaks5cUcwemQxdEpO?=
 =?utf-8?B?akJmNHpreXRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkErWW9ya1pQaE5lSFFoZndNeklrRU51ZlFMZmRvYjJHd1hwVTVsd1pDRk1O?=
 =?utf-8?B?RzFPR0lsVzU0aTZRN3VneWFxcDdVMVZQQVMza2lxTW0ybTFRbFhxWGRBZ21u?=
 =?utf-8?B?VWJrWlpwYzZVcWZneUtXRGZMSVVXdVltUEhpVm5aRkwwd25ObUR4YUZPMW1F?=
 =?utf-8?B?VURoamFTMHkzNE9DYlBSMkVVSEZrUFU5Z0g4cm4zSEp4bXJVanJQVUJ6K2J5?=
 =?utf-8?B?Z3FYNnhBUzh0azUyNkRCbDJtczZhL3d5ZlcxdkZlZWpXSUVJemM2WEZLRWs4?=
 =?utf-8?B?QzZZeTFkdGJnbUVoaWpKTll5Smw1eG40NXJZcUhHeW5zamVqK0FUd2VBenpv?=
 =?utf-8?B?N244OWJtUG5jeDg2ZjRIeVVUNGMwSktYT3NHNmplWmFLdDNoeStoUVlnbDBk?=
 =?utf-8?B?MWRyeExPQ3ZZV1NVSWg3RVBJOTBjRjN4bTRERDVXcUJPWDUyRzEwWStBTlpu?=
 =?utf-8?B?Wlh4Z013dDBzUWZiNmdhK01MbFlrM1p3aWxEQ2pKc0IxZ1pRQnVSY29BdXho?=
 =?utf-8?B?Y2VpWTNTQnNDdEhtaWZDbzlyM1dycDVFNHNWR1JPa3hYTk5NZzBjTUVOQ2do?=
 =?utf-8?B?cFpNYnNwV2xPOStmV3d2UkdFcW5IaVlsU21RSzBqQUtsS1hGS1Z4SEJ1QTY0?=
 =?utf-8?B?cldTeGJVZGF5QnlienBua0I2eW9NN3RVN3puZ1kwcFdOR3lBYVlOdVBpNktF?=
 =?utf-8?B?MTB1S0pKVFArZ0JuckRIeUlScDF5dGRxRlk1d1VKQ1lCZkptSTg1UWQwVVNu?=
 =?utf-8?B?YjZhSEE5MDMwR0MwR3lxOEhWN2k1dTJqWXhrbmQvQnpjU2JveEJRem9VTllB?=
 =?utf-8?B?UGthRDd2dUMvZk5GWEJVUGhxQlEzUGxNdmhDOVlEbkNNU2kyNU9EMjZmMVlu?=
 =?utf-8?B?UCtvbkE5NVdEMlV6aWtXbDJrQktZeG1BcGd3MDBTNHJIZUFzNEJSalZUNE94?=
 =?utf-8?B?dkttMngrbEpoMjRtT0I3bDhhNlc3ODJKTlEycnF0c2c5MmtHWkRyeWk5aXRz?=
 =?utf-8?B?Y0VwWldTTlBCc2ZxWEptYWRmM3pQYkllOGM4NlFJRWJYK1RpdWlHN0hVWENp?=
 =?utf-8?B?YXBoTExvUWpFQnkwODdwMGdnZEw0VFhJVERETHAzWTZpb3NFVVFIK1dkRmh1?=
 =?utf-8?B?U1Raa2w1bE12VWpqQTdxcnVzUXRITzZJcHJEcW9lRGhhcWkyYXdsNnNyU2N3?=
 =?utf-8?B?dkl1TGhmZDBNdENwTkNTSVpHUkkwWS9UeWZmRTVDN2RPeVlPWnpoNGlKd3cx?=
 =?utf-8?B?Tm5oaWw0bktEY0ppVmRiRDlUWmJzZXFrdnBuazRWWmRKbitOS0h5dWtuWW1H?=
 =?utf-8?B?QlFKZDM3YmVqNDYyOG5BZFh6TEk0Zm9hY3F2VnlYZWlRdW9NYWxyNmQzTmJ0?=
 =?utf-8?B?RmhERGFFMks4QVpuZytXTzIxa3NTR2c5bEg1RzVzcHlJbWdXWFh3VFlLUi9a?=
 =?utf-8?B?dFNpUUxETlVpNVp0blh3cGZBaHJOaUdVdFB4TkpJSWFMMnlsVXJKK3o5WHFF?=
 =?utf-8?B?MTZ5TS9nMERHNTJ2cnJTbFIzREc1ZDNoemVNQTYrUmRINVM4ajJ5aW5BU2Vi?=
 =?utf-8?B?c2JLV05sRUF0eCtITitoQ2JYUVRSZjUzSjNGbVRIcTJnVHpWa0krWnNZVHdX?=
 =?utf-8?B?cGhEL3lwZG5uOEs0UGJxaDRaVWJDWG9hdUlZbEdZejJwNVNtSlp5dkRqeXkw?=
 =?utf-8?B?TFZoNndtRWdVRUFmQW5uTlVSb2VQaDgrSjJlZzhSVzdpM1pidXNKQ05GNEdx?=
 =?utf-8?B?Y1FCOHVyd2ZiQnZYZUVVQTlONktWTlUrdDdOSWlONDcvVDlIVUNRL1JqRGdj?=
 =?utf-8?B?ajQ4NVNFNzJmTUpOWnRvVkJkREZOaE1ZZWVUbWFRdTNiN2lYU2k0V3JOTTRl?=
 =?utf-8?B?T09BQ2FWeUtsblVQbU9LbW11dnROSDMxVXFZVmJPWFZZYzlENlNpeG93WjlG?=
 =?utf-8?B?R2pENG8rSUl0aFBURExTWUlZUEFFbWUxUUNyMHNwR3F2Zncxb2NrWWNMWHFm?=
 =?utf-8?B?WHJKWFRuVjVOSjJEcTdId1B5VUR5WXRtR24wcTRVaE5DSVVQZVk3WFhXRmY4?=
 =?utf-8?B?SlgxWjU1d0hwd0Q4OTEzYnhDS0s0NHZtUC8vZXlRRERWU1RHOTNKbTZLQmhN?=
 =?utf-8?Q?C9i01Eu/WtHt7+jN/bwcaEdPq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d906caa0-9e42-4a7c-284c-08ddfadf013d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 20:23:06.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAKfcQdfyM2wUmMgr37+8UlHa/z2QUJWGMt+UdOXRy0SQgFsKhwaddMscsz97r/IoLrxf7Tp9dEiCZ1g030Ehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953

Add missed compatible string for arm64 layerscape platform. Allow these
fallback to fsl,ls1028a-dwc3.

Remove fallback snps,dwc3 because layerscape dwc3 is not full compatible
with common snps,dwc3 device, a special value gsburstcfg0 need be set when
dma coherence enabled.

Allow iommus property.

Change ref to snps,dwc3-common.yaml to use dwc3 flatten library.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/usb/fsl,ls1028a.yaml       | 33 ++++++++++++----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml b/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
index a44bdf391887f9c7d565c01d2c3aede99c4a9fc3..4784f057264ac7b18cbc8b41a405f9c9268605bb 100644
--- a/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
@@ -9,21 +9,19 @@ title: Freescale layerscape SuperSpeed DWC3 USB SoC controller
 maintainers:
   - Frank Li <Frank.Li@nxp.com>
 
-select:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - fsl,ls1028a-dwc3
-  required:
-    - compatible
-
 properties:
   compatible:
-    items:
-      - enum:
-          - fsl,ls1028a-dwc3
-      - const: snps,dwc3
+    oneOf:
+      - items:
+          - enum:
+              - fsl,ls1012a-dwc3
+              - fsl,ls1043a-dwc3
+              - fsl,ls1046a-dwc3
+              - fsl,ls1088a-dwc3
+              - fsl,ls208xa-dwc3
+              - fsl,lx2160a-dwc3
+          - const: fsl,ls1028a-dwc3
+      - const: fsl,ls1028a-dwc3
 
   reg:
     maxItems: 1
@@ -31,6 +29,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
 unevaluatedProperties: false
 
 required:
@@ -39,14 +42,14 @@ required:
   - interrupts
 
 allOf:
-  - $ref: snps,dwc3.yaml#
+  - $ref: snps,dwc3-common.yaml#
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     usb@fe800000 {
-        compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+        compatible = "fsl,ls1028a-dwc3";
         reg = <0xfe800000 0x100000>;
         interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
     };

-- 
2.34.1


