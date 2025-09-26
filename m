Return-Path: <linux-kernel+bounces-834339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E90CBA47C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8186416BE92
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16E922B8B0;
	Fri, 26 Sep 2025 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JYMEFBbE"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6DA22689C;
	Fri, 26 Sep 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901687; cv=fail; b=VZg31rdt96tkYSdc1btH1cMvJM7bFNl5Wk5rEoAu+DXzGiQN9/3A7ac6l/se89lNK8U7Px/REAwaEGOZ62rLbk9x3oM4Zm99PS2MQCQmrvj+jpef4M/XSDhrd5QEQZTZSSub8hxdUIrlclqXPWR4PqnaadRJwo3y2BpM3GGa/eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901687; c=relaxed/simple;
	bh=/+Na/VtkKoGis2676qMC/CSieNGo9JVLJyQ2ePElND8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OWykpjC8GlUexCwQeWORVBrz1GpnLUA5+OByGNgV3epqWBfpjU9TZMTtYw4/s1jv+nlCTSZDu/5uGyaaGxRauWizX/SZHJr5wnyYiDnl7h7faCwn8EttHFEiC2cATRCtMNctVXrJKWdzESSDgeOlHvsSk1XZ9zvxYLsvIEzGQxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JYMEFBbE; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j99S4k/inuRrsiM35Hnq9L1v4Zv9AJI2/KNNR0dvnIBl9L5E2rG8fH0UAQy/O9HewXqabaOgYbo+rdBXyhiWr1448/oNRhsL/bAkUqj9NpZM6AerNNhXoGyWgkgT2bYb6OOGd6YAHtRikLtelfE0hMcspejuugMHZUAlKQt4JwK0KJT+2LaG12LW164GyyvxegpBaGtsRxpRRdzcN54ZpdyHKPenE8gEHbyreYuZEOFI1cv4Y77CKc2zVG19oBd76rs4GYttUr1DT6DyKHWKuxWyuKQd3E9lotFnvhZ5b+1Z3cKCbgyr4t7va/y8sEFhfD4UL19RbEAE0UohPFMvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n402lp1vzOwk3tc1HbldI6zEqYolF/YdTGfT4NbAHno=;
 b=Au5hwYgAz4RibDzbjjdZ0q9R8hvyledcGO2AJw4MkduwI/8+q7svEzICSaTILzMvgxSiZkrh32VqkLyk+eixdpGtASVeNjALDWwxhd/3Dah3yFuxyXhg97xUtXM9hr7NxFS0WFEPbj6w85XUywkBKDceSCaSTth0KHQF0J05Ovd+NtRvwuxRTjFDnxcGr/MRN7JhaQm4SFh4Af1Uk4GyOzVahlG726Fbiv1cBP2tvu7SUnI2gNRsNI1LnEQtvOunp4NK2A6a26sEPsTOBEEwkg3t/sNAct8j66qLOO8FMINxuc4TTTM2rZeuP7IADPS7/k50TUGE7lWslP4PasIr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n402lp1vzOwk3tc1HbldI6zEqYolF/YdTGfT4NbAHno=;
 b=JYMEFBbE+HvjO90e37xuCvWnSFJ4Cs7NzFMZ9oSsO1cyj5jeUsNZwM1DLWO61488/T9ObPdqMJmKYH6ExWN8xvBbtPkr8xEbQ4jt/Rw8hFGMCPo0BufYZ5DwaejD/g6jyO4815znPi+nQ2KJs2Qyhu5h2N7eRcVgKotnwU0tykIuAX7Gy17xzL3rrmHwHGDo3GRK9jTYszu/Z+tVeSMN9eKvinbXrKw6il2Ac+IExeE4pQYrKFVWFEtm6/vqF9Q1RXwRBLAxFGUtJ0wqoG2WhPvz+mswdkz47d/YZq0wR4LHnLlotwkMg8AcPlD/FWGIMn4yQQCGd96I6m7ewM5aZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PR3PR04MB7276.eurprd04.prod.outlook.com (2603:10a6:102:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 15:48:02 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 15:48:02 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Sat, 27 Sep 2025 02:39:31 +0530
Subject: [PATCH v19 1/7] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-imx-se-if-v19-1-d1e7e960c118@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758920996; l=7443;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=/+Na/VtkKoGis2676qMC/CSieNGo9JVLJyQ2ePElND8=;
 b=ysKcKkv0NYRCMymsPMf2NvNhvk8Vl/19vbw9Gh6wIaWjOejIsAps0xW0IqQJWJ5LjB//lynQL
 O24/NUvMK1VBGrDZOllGBaWE1x7xiOLOy6Psxp9NXWMs11SrX+GMqE+
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PR3PR04MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: a1eab378-b278-44cc-85f6-08ddfd14133b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFBYb1h6cFAxQkxoN2diODVtSFRRTlFPRUtmRXIzYkpZVW90YmoxTmdRaWlW?=
 =?utf-8?B?TG80bTBJcjdvT2JaMVRtd2xlcnBySFJDSHhwdEZuSDFjZEY2WTRnK0JTMVVa?=
 =?utf-8?B?VTRYSnZmN2RMNWwxTHUvLzFDZ2swakgvdVh6dmU1aXkxNTR1WTEzVWZzeTlP?=
 =?utf-8?B?cExMQ0pleFRIQXdHTG52dzk5UXY1Z2lDbThUTVhnaE1TOHB3cDE0ZFNYY3l5?=
 =?utf-8?B?MHVjZWN3dnZpZ0JNazNFZVlkVmwwWkNqZXJMWjZDZEZlOTZJWnMwNHJReDla?=
 =?utf-8?B?OGtnOE92YzlMcS9FbENsYW5SUTlhMHBRN3lESHZVMmNST1J0anlKZS9tZzNU?=
 =?utf-8?B?TUtEcXZaSjExMVBKSW9GVWRWNDVnZ1l1eVlVWFNYNVJWMzhWeDZxWjNjNDdG?=
 =?utf-8?B?T0xaR1Y0Ny9tNkEyTUdhcnVkeDJyL0EyelBQUldYMXdTK0c5T1NQQkNVTTZO?=
 =?utf-8?B?c1hlejNGaFdtN2NTTWlIMzhBOGVWV3MvU2lVSi9CNUo1MEJBQ3JZUjZoOWpS?=
 =?utf-8?B?VkM3QTE4aE1PQ2ZIQkJzeFhNL1lSbnVrUEkvMWVUeG1zd2NRMVZ1MlBJOWlp?=
 =?utf-8?B?VDdpTk1DQTJ2eldZRVFWRDBPdlg2MW1wTmdsdUpyakhGUTlINU9uSlVTU1pK?=
 =?utf-8?B?dFpkaVQ5VVJXVm9FZ0xSeTBzMkVVVld5aTJWeGZySmliWXFBQkttZ1FKT2tk?=
 =?utf-8?B?RkQ4MFBlNkdvR1pYVHZjTTNhNXlaU1hNTTVMdmJDNjJZUUcxYWJKQ2k0YVpY?=
 =?utf-8?B?emZpUHdRZ2xzUGdueThIRTd4RFBWKzZIRGZxVFEzVHpNdm83SEJubmp1bkdM?=
 =?utf-8?B?SEZoZnZHS2EzOHYvaWF0NWYzSEdlclM4bkFwblY0Y2NHTU1FcVNWTXVYQlIr?=
 =?utf-8?B?SHV0NDhoeUlzdmtFZW13bzNOUU9rZzQvQW9DeWF1SlZabUtZVUxzYnViWmlI?=
 =?utf-8?B?NzQ0bWxjNXd4N2hwdFNoVDAvenZLUWt5VS9RVWdEbW1CQ1pQQ2UyNE9nYTF6?=
 =?utf-8?B?bzJ5RmtEbzl5TkpGR0dpRVcySEVvVFJ4UlpiNzZuUWNBV2RzZTNmcFhXeXpB?=
 =?utf-8?B?SmJLQzBFSDBxMEllTWhTcE1JdEpJZmg2RjRNWHVibGZPL1VhVVNTSjZYSEJT?=
 =?utf-8?B?N1MweFRsYm9DeENPc0JST29MNzBmRHZ5WGVGa25IMWY5aVhjc2QzYjVtMUxV?=
 =?utf-8?B?d3FDWkJkTlcyM0JSWDhWTXFGWGROUFhqZXVBdXIyM2lZdkNINmQ0NUUxbmtW?=
 =?utf-8?B?NHpncE9IUkdNSHRxNHVqMS9rQitneGpOKzl4ajAxQVRGWkdRaHlyVEI4ZnRR?=
 =?utf-8?B?dnZKUW4reFN4UTBURnpaejNnNU5PME5jYko0ZmFjM3FGL28wK2pzazVsMGtE?=
 =?utf-8?B?RFF4LzIzQjc5ZkRzdjU4di9RT1NrcHlzL28zcE1FU2cvZ1RkNVBCYjhqNEZo?=
 =?utf-8?B?NFBlaGVFOFpzOUQwc0hGcHBnNkJ0YUtrQzRZRk1rSWFuNXQrazlaeGFLTmZV?=
 =?utf-8?B?YnEyTU8zSmRnS1pvYXJIeVhpdHZmNE5yaG5xUXBhRTRhQStRalkvRGUwUjB3?=
 =?utf-8?B?Z2ZIMEdaOWtoNW1QbWN5TWVaamhGRFJXRlJ0UWE2cFJpVXdNaXRKUU4vSHdt?=
 =?utf-8?B?cWEyOCs3ZHBJd1IzS0RFeURHaG5UazRZd2N5dXduMjBSSjVqc0w1RXRkMFBv?=
 =?utf-8?B?TVM4WmthZHQrVkFBWSsvV0FWeEkyM2JFQnRhcWx3QzZxdDd6KzhNelNqci9P?=
 =?utf-8?B?ZThWWjVtbnZMbDBNZDZienk0eitrQ0FvL1p0U2toWlhwUk9MZmEyZW9WQXhi?=
 =?utf-8?B?RG4zSXY3T0tvcldzWU5sK2tqWUZBWFFhS05Za3A3UTl2MnZNNytBYkt6VVVq?=
 =?utf-8?B?dXgyalRlN2JkYUkxS0FaS1NydUNQRDJqdHdrUFh6MW1tNUVZL0ZHWXVwdDJr?=
 =?utf-8?B?L3l3ZVIyOEcwWmRuTDBUMjFGQWg5RXFZbE1qNlVyZ2pkVHZxdGRRTFRmbE9O?=
 =?utf-8?B?ZHNFZkJWN1JnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkthK2lnd1l3UEx3RlhXMk00R3BEdTArZlpCUnBzeGZGYjh6UDNTTHk1QnVw?=
 =?utf-8?B?S3Fxa2pEK3QyRlF1MWxyT284NUJpWDRXMnhraGtPdnJrUzNWSktMMC9Wdi9B?=
 =?utf-8?B?OTRUaGI3WXhDMnR1OG5zZUxOaEcrYXVTMHo3L1h5TWx3VGcxNDZmT2hVUHN1?=
 =?utf-8?B?VVN3a0FaVnIwbzFTa2p4RS9rbFMxbjBCcGhtci9naXNwQzBIeXAxYTlCWmRq?=
 =?utf-8?B?Zm9JbU13NkxycVlMVkJxbDBHUHc0UGJrUk1lNjJSQVpLYkJHT3NNQlBZYVBP?=
 =?utf-8?B?NWFmeU92eS9UejRxRVZ5RDQ5VHllcC91VW5pdmlXeFZjS3lqYmtLRmRGSVBR?=
 =?utf-8?B?Uk5IUlMwL2NmUWwyTElHKy9WM2FlSThadWNRYmkwTnB1K2VQbTBiUEhKRXZC?=
 =?utf-8?B?c3JrZHRhTEZXR1F3WEZiQXRaUVJVajZ3NFRQSHYwUThSMG5aelEzUEE1ZUFC?=
 =?utf-8?B?dmtua0IzRzl6dVQvbVpSN2N3ajltb3R4RXZpY2RuMEM1b2RzYU8wQ1JvRzNJ?=
 =?utf-8?B?b3ovVVQyenFvRW5YN2JPenlENWp5OGVRL205MlU5b1VVRTZuWnpaZnlweE9w?=
 =?utf-8?B?cExsU00rMG40V05iVFFmeFRWSGFuNWdicy8yTGo3UmwwZXZrY1FpWmlRYzB5?=
 =?utf-8?B?RWE1LzREZEVkN2FzRE5YQXNSOW9tMEpXU2hwaXhleWxPV25sZ1pPUm9BZ21S?=
 =?utf-8?B?TERQQmpUTUhJamUwV21tMFVMRGpOVTNRVndOQktGYlNQd25RSXFCQU40Y0FN?=
 =?utf-8?B?VHV3ZExhTFpSMFVmL2FUK1ZzZnZLeW1pRkJoQVNOTlUwcXF1SksyWmhNSElv?=
 =?utf-8?B?dmtBWWg0OGpWR0JsS0JCMXpPbHZiUUs5SWZGK3NkWGtadVdKYjVwbTBXaks0?=
 =?utf-8?B?NWxXdkVZUlBrdHhOeDlWVXRLa0VSNEs2aDcwcFM1bm5lUWV6NXpOa3dpbE5w?=
 =?utf-8?B?V2lJY0t6aUk4anNHYXlPWGZxK3dCL3lzRFE0V2wrUzNYa3FXZ291aGp3aGRk?=
 =?utf-8?B?MmVrYnpqWlVZck1CK3Naa2ZCd0x6c0JnemFDaTkwWkxjVEU3WlBlZ2gvQ1RQ?=
 =?utf-8?B?ekl0MHNwTDlGQmRQdm93MjJCeE9ES3pqK1NEQWlPMnBQQWpldFVERjZjRis0?=
 =?utf-8?B?a1dBdGErMEYyWGN3dkI0d3V5Umg1azVNenNGcVVGRk1keWdMdjYwSjhVSFhX?=
 =?utf-8?B?SkUxNStlbUE4TUd4UHh1Z0o0WVVkSVM0UEtGY3BobFR5RTFaTlB1cFZRVDF5?=
 =?utf-8?B?d1hFMWY3Q2FtTWJVMkZJQUlYQ1hzaUlwU1hKeGd1cUl1SDNJV1c0U3ArakFJ?=
 =?utf-8?B?MDgrS2NDRjMrSy92QXQyYkkxT2ZDVVNBSW14R1k0WlB6Wi8vMUtmQTZZamtj?=
 =?utf-8?B?eDZHODFYMlRoL04wb29yL3VEbmtIZENWM1dld2hYcjJZWVVnRExHOEI4SG1R?=
 =?utf-8?B?THRYKzI3S3FyYVIrR1hIVFR4aytBc3QvZDdNZnhEZ0N2c042MUNseXZoUGxP?=
 =?utf-8?B?bWZEWm9od09wUE45UUZVbG1CcmFFVTN4bzdoZEpYUldwd25NaGJETHFQbVBU?=
 =?utf-8?B?MkxGVDZTaUdOdnhwL24rRUNqWnlqTCt2blJkSHZoRGx2S05SUXl0NWNDNXYy?=
 =?utf-8?B?V0RxdVAxSWx3NTE4eTQ0V3ZpWnlDS004MGxMZkducWNjRmVWMVZZZWNKNThO?=
 =?utf-8?B?QVpVb2I3UEs1bjcwNERGRFVlMmxHa09IWnpFemxBZ0JTU21wdm8ydXQ5TmdX?=
 =?utf-8?B?OGt4bVAzL2FMR2FaVHR0UEtMWTZIYUZ5dFM5YUdsRDJTVWlScUt1SHRFK0RV?=
 =?utf-8?B?OHVjbjMzSU0xZGpsTGZWV0JRZzZ3Q0d4cXBYL0RyVC9yUzBTd2xkYXpmc0pt?=
 =?utf-8?B?R2I2U0Jzc0d0SjlmWExRT3NIYUY1S0gzYWVLR2JWTlplVFFiREczOEtiWTVT?=
 =?utf-8?B?dndGUmd5T0F6cndCems1TWJNb2NmZVdCTE9RUXlQbUJFZDRTdXJXSmt5aE00?=
 =?utf-8?B?L0NUekdHWHBFKzdHOFRKRm1QNkVyNlp2dUdXUWhhWm9qbXpseVUwamJkZ0Vj?=
 =?utf-8?B?bUFGVlZRUWwrVlRxN1dQd0tZVTM0eWMzcU55OFVFZFhSMU5QcHR3UkM5WlEy?=
 =?utf-8?Q?ddv+ZWYN6xdmY0k12icxwUMWE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1eab378-b278-44cc-85f6-08ddfd14133b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:48:02.1690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGHGTMl2sLboFyNDTtBq/NIqzU/MPNTKQH/Kb5WGklDHDpaz4b0tNloc7A+mwqn9ir8fETM6deoTDMpHFh1y+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7276

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for Secure Enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

---
changes from v18 to 19
- Added 9 lines to the Introduction from line 73-82.
---
 .../driver-api/firmware/other_interfaces.rst       | 131 +++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..2a7d7100fdd4 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,134 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock Enclave, V2X etc., creates an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exist.
+
+NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs. Communication
+of the MU is realized using the mailbox driver. Each secure enclave can cater to
+multiple clients by virtue of these exclusive MUs. Also, they can distinguish
+transactions originating from these clients based on the MU used and core security
+state. The communication between the clients and secure enclaves is in form of
+command/response mechanism. Each client could expose specific set of secure enclave
+features to the higher layers, based on the commands supported by that client. For
+example, the secure enclave could simultaneously support an OPTEE TA and Linux
+middleware as clients. Each of these clients can expose specific set of secure
+enclave features based on the command set supported by them.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
+
+Each 'se-if' comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+::
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the messages to be sent over an MU.
+
+  - FW can handle one command message at a time.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+::
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over Linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.43.0


