Return-Path: <linux-kernel+bounces-856548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E490BE4703
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613B31A67406
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D532AAC3;
	Thu, 16 Oct 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZQ6zCYWA"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D1F393DD0;
	Thu, 16 Oct 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630461; cv=fail; b=RaAxOdKZkUMEhmJei++/1HhoQahJZBsqMiA6XJua+kvYhT2RYJuK0C0XLOLndTUo1TVlu4HXvwpUrVpxxHjGapjcbUDgsbEpOUVVS5xj/Z4j96hwLgwHyVFfeN50L83SX6aHIsbCa7Ice1CVzlEMwpKrivLzkZYvvLtc5DsQ7tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630461; c=relaxed/simple;
	bh=8iUChnDAGpyRnCKC3p1a/l2BH4aQI/W8Jnom8LWPUxs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aN5MIFVzfUBu8415ZP9NShhQ4A3KW6iB8D1vRHwP5yHb6HV+goAGcngJK2b9+W98w/wlgHHB49MmmPootqAjns4iHz9aVpTNRMc847wJ6fGJd9VRZibusvGHXhOCwNfS8qqYLEKhn3rBoaDExVVwuzy9sz3wlyG0qHnG58VJzjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZQ6zCYWA; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MidXvqu+Akc0dHclSetmRKjCu0WjbO0BHZbhS76mQM9h8VyJPfHU9qAra1k9i83QYW4w26sd4jysmsBFObxnl8Ma20ntB04wPD0QEmzwQc9po8/p/TGQFBZjJ2tOshLULWTSc1ZtN2eTuj/uqLyuhUj+0ZO7TrbcErYqtfR+vRANtLH9EKkAaEtfnJHIY1XsAJ97J9XJ/zgEAVh+rAU8kkj9y+xtE2+4/Z7bxKTEM8UxgQK3/2J7/FFQLJ/+jG0ZvYdi7x657RXJs4Dgmdt5BvgT2QNMQv07x0uSFOpLyqD7ErLhFNlW2zzCqIK097RAEWVcwLwGeLuOxaFnauqmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10eIN9B5ATbGfjwqCdpK0oVg9mZ+w9ks5BHSBlyTF9s=;
 b=R93qo1ElMB3LFOp6HyOpuaK04pX6WOMAvI/uILEhumr8jqloGYsdtqhBRVY1QYP0eO0FEuCOp5m9XNJVVPmaPv5q09D63uGjPvTvWw1FNCQmm9zB4nIVFgQQc2WUNNP2sQmXTmzLlMqI1+voT7KLVVQ5lTcjIWrczjJNc3jZIeHhOdAiye+VPRrZRx86qkdAUREXitV46PLB4VxUNiSGtyZHs0/CWXY/dDZismGmD+7EBf0KQMoD5hvs3BtQQ+HchaRFD4r9+7F2Tt+FxJKRvSAV2k03Z9CK5j2+PwaUhSFyQHiOHfQplRTa2QtwRAwI7JJcrtAKNYexU3oxQ2MQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10eIN9B5ATbGfjwqCdpK0oVg9mZ+w9ks5BHSBlyTF9s=;
 b=ZQ6zCYWAIf3CqP6GYNy2BDggWwUEZ3YSD+rvgVXo4EKiO5uaK0GFcDT354J3K5vjE7CCFrQejvsyOzthj7mZcrovj/Ygh2KSYp6l4MFdBGMI4awKzOx3SM3SPZ957vXyX5a6TQDvpTyvGIl7sifK/fqRygqZFUnQYrW48UTt5VhX/LTRr0Wyfq38hBCE6pGqSxqtLken6tjYmMeupfRPAd3EWKDR4KSaEHYag6uCvU6ZiIt1fMa/ghDRWChxsyOUVRa0bumxrXlrMcRJvFIwIudQgM3p3ABEPLo3IjGhrh06bo7gqRulQwh4G2cib1eQjwkRhc/Bh2GL789I1OVpUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:00:56 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:00:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 16 Oct 2025 12:00:15 -0400
Subject: [PATCH v3 11/11] ARM: dts: imx6qdl-nitrogen6_max: rename i2c<n>mux
 to i2c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-imx6_dts_cleanup-v3-11-baf2814f8a15@nxp.com>
References: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
In-Reply-To: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760630414; l=1176;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8iUChnDAGpyRnCKC3p1a/l2BH4aQI/W8Jnom8LWPUxs=;
 b=Fxq7t0XXExuDYjLxBVqbeSYue0SPG4PZ4CJksHleEfDQb1vRm8dKLonXYnYZigHs/5VQuA1U8
 nQPg/0FNr3CDKPFmXtSJayYw2lNmEBhxwQIwmJ0/47fMHq5UWszCrzh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10069:EE_
X-MS-Office365-Filtering-Correlation-Id: b922173a-7ce5-4839-d730-08de0ccd30c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGNZbUN2MTlWaUlYQjdEOVNWcjlsaTdiZDlDakkvK1pJdkFUaS9CYmhGcWl5?=
 =?utf-8?B?MndCK3BRSG04U2hWbTh0SVZ6Y3d1SW8rcFlxQzN0SW56RVg1QXJneXJDNHlm?=
 =?utf-8?B?Z2lLalZlaVYvT0VZay9aQzYyWDBOSC80RVhNdFJXRURvMUsyV0tkL3NFREw3?=
 =?utf-8?B?V29yUXA0MHVvNy9QTG9HcStyMWVFWC9laG1MS25HSmw1Q3RSejlOL2VGeUNh?=
 =?utf-8?B?a0VoYXJVRWc1VXFGaDRoYVlHbGs4L1FiS1VJUWNyWStxemZ4WGdBY3lGL2JE?=
 =?utf-8?B?VlJvV0I1bUpzU0ZEdTNEdlBSVFRlUVB2c3dYMHBsaUJiRUttVzZGNTlja2pI?=
 =?utf-8?B?V0JCNllnaVdsczdCOFpSakpjcWZFN3Y5ZWFjTWpsS1ZmMFlacGpuWlE5WVNC?=
 =?utf-8?B?NitLb2FJSGZOcHpIV2xwNlBpdXY0Z2t3RGJRN3RxSUJRbCtkOFFRcU1xU1I3?=
 =?utf-8?B?TG12RG1JVWRhWXJXRWRsbkFVOEh5R3k4eGFoRzROYmNEblVEa0hNQW0xMTd3?=
 =?utf-8?B?TWZuak5mcGE5MDR3d0VWdCthN0FEdmtEbzdXRDA2VElsREYrd2pSZHp3NWN6?=
 =?utf-8?B?RSsxbUxqcFlUMytwY0lFVmVQN25tL2pGbk5RRWNKZVhicURVV3VISzBMTktz?=
 =?utf-8?B?eklDa1psTWtXL2hGL1A1NUdPbVNoUlBPaTRSZG9aa0toaFBwZkRRSkhsZ1Jy?=
 =?utf-8?B?NE9CQWsvT0lzTU94U0RuQ1prWlB6SklvcWNnT21SdWNKcEczTlVpMGVKS1Jz?=
 =?utf-8?B?NlIwakdYWEpsRkd6MGd0RjczWWpvNUEvb0xVSkZ4Tm5wN2NQSUdid1FaQVpM?=
 =?utf-8?B?bHlTVUlWVFNwT0pDalBBMTRmck5sOVl1enFFNEZsSlFDV0o2TWRvTHVpMHpm?=
 =?utf-8?B?clpaU08xbXlrM0tYNWdMU2dxMG42NTZVNXdHOGxYTjF1S0xUakdQSUIvS0RH?=
 =?utf-8?B?Y0hsZzV1THhXaXVNcG1HcXJ1b3JhK0QxTzdIcFdQcmNRN2VDSVA5M3pJbDBl?=
 =?utf-8?B?cVJWTXg0NTlndHExamhEdTdDbkFJZDIrNS9EZVBEeHp0UGV3VkwwOWhVZC9O?=
 =?utf-8?B?eEFhWjU3K3lldzcvZUlQYnlyMUc4aGgxZ3dWcDl3VEsrck1uSlZSbldMdHhW?=
 =?utf-8?B?OUkzTlZrTlBic0pPaCswYkdNT1JWQjBHamRYcWNscGVQNEJoUTVycHl3MHdQ?=
 =?utf-8?B?OWxYZEJrcDBrWmFYSklZVnZqM3NNOWZIUTQ1NkhrUUxLSWloQW8zUjhtanhh?=
 =?utf-8?B?ck9ZK2t0Y1RTSG9YN1lYSnRjS3Y0OFVhOURENHVhNFhxVTB1bWhhR1RmdG9V?=
 =?utf-8?B?TTdiYklIMEdEVG1jUTZOa3FhQWthTVdhZXFUQmZPRkVsYWN6Yjc3aXFLSmpT?=
 =?utf-8?B?MDgxZGgwWm9BeEovWE9MM25sOWtxOHY0NlpNY3UxZmlwcllEOVN2cUV3elZT?=
 =?utf-8?B?VnJaOU5CZ3JZWlF0Z0ZXeG1ZSVh1d2ttYUs5NG1UbGZPTWNDMS9zMXIyS0Fr?=
 =?utf-8?B?QnNQMElNb2RvWDd6SUZDTjlPMUdtZ1NaMFY3WE1mdllwSlN5T0Zwb1FURm9l?=
 =?utf-8?B?YmU2THVDRzA4NDJ5L2xQMWtZUkpKQXZnYW0waDJ5em9VRzA5SEJKczA5N3RC?=
 =?utf-8?B?S0NyV0syelJaMHJHOHdTcWlIZVordVlCUG16cGxtWURwY0REa1U1S2syT0Vw?=
 =?utf-8?B?YnloblNnTWc2aE1taWIvSXg2NVVHdXEzak0vZTExRkZmNEloTzdRZXVWZWY1?=
 =?utf-8?B?Q2JXTGQwc0tXVEptYXVyY2dWdlRPWkdFRG9SM0lUR3MvWEcvUjhCeUhRVTRE?=
 =?utf-8?B?WjhZcU9TTDVFRUl2NUlnbXhIcFNBa00vUldpWVo0K1Y4WWF0U290dXgxb21B?=
 =?utf-8?B?NUdiNytldUxFbHl3Qlo5NitpQThMdEVQc0g1RzZ1cHR4Z1JZM0k2ZW43Rmp4?=
 =?utf-8?B?SWNxbXZjNUpqN2lSQXlyeWZRYzhadDhDTU9LdEwzSzN4QnQxRWl3Ri9Hdis2?=
 =?utf-8?B?elVMY0NFVmM3elpZbFdkOHpqejEyV1pNRURlNkNHc3pPTDl5bGNQbzBoSnk5?=
 =?utf-8?Q?gAqjcs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlIrd2RWUXlLTk93T2tPdGpSRitoWUVMVU1RWWZTU1oyMFFPUnoxNWhTL1NM?=
 =?utf-8?B?NlVZa0loQWtldUxpd2N2aUxqZ21Scm43bys2NkJSZTNUNlNta21XY1RrNkdY?=
 =?utf-8?B?NUZkeGZzQkZuSUw5S0FnZCtmWjhHME9qbVlLSkJYTXg2c1BpQkxBVmRueXJK?=
 =?utf-8?B?RGdNeVFXeHE5clh6dStOMjlnS1pIYm1mTzYxbGI1aXF1RWFRcHNwWjZzeDR1?=
 =?utf-8?B?aDk5aHdCMlYxN29SMnN6bEhJOTlvclN2eDc2SytoeThZazNMdkFKRVV0QWkz?=
 =?utf-8?B?NVJHUU9KcGMwRTVra3NyaXlQRTNPZ2RuS1VDd3hzSlR1dHo0STlDaXNwMksw?=
 =?utf-8?B?QlJ0bHJUc1FLcjNYcG9WVTNMOE1Hc04vMmFRU0doT1c4Nzl4akI3MzhaQXdL?=
 =?utf-8?B?OUtZdW4vaVI2NjJCenJNdXhpU2d4TXVueTBMZTJrK0pycXlDODZrYy9jTGJQ?=
 =?utf-8?B?L2VIMnhHUEd4eEtHclhmN0w2SHVpbnVNanJsRjlacDh2WFZrL3VONGl6YzQ1?=
 =?utf-8?B?YkUzUy9Tb3Rhck9XZFREMzVRaUNDSk5JbnhkNWxMZ1pRNkNubDI0WENiSDhD?=
 =?utf-8?B?VzdIOHRNUHlGSEVrSWNCQ01IWlFCbnZwV2lrT0NabEhkWGIyaHpIbFF5Qk83?=
 =?utf-8?B?RjFGU2p0WHBTeGlrRVhpYitBaDZlNFg5WXVhVXZiVzVjWHRKWHpOcmZzd3pH?=
 =?utf-8?B?R1ErM0x4bWZwUllIRloyVnFLTWlwUDc5MDVpZzkyMVQ5VWh3ZzJ4WWpUbjF5?=
 =?utf-8?B?NkdaMjhVRk1TVUMvV3pFMkM3L1FYcVFJQ2lUQVVtNXdKUlNSckYwcU4zb0FK?=
 =?utf-8?B?TUxqbUh3N1hQeUtMRmhTVHdSejA0Rk1keGJiRm1oUm8yTDJWRVJtVzJnQVRE?=
 =?utf-8?B?ZTRpcnU0clQ0R2pscXBUY1Jna29xQkdNOHRzcnpZU1Q0TFB4UEVKakFwbW50?=
 =?utf-8?B?UFRhQTcxYXNyY2VYMkY5R0crYlMzbzYxU0Jkc2xhZUcyTTQ5VjVHOUZEYWQy?=
 =?utf-8?B?ZmN4bWptZVZiMjZiNlU1RlVsZHZBQWRFaWMxbWd2U1VQbitXUHQzSDAvTnhP?=
 =?utf-8?B?UDB2K1JRTFhJNXVxMXRKYXJTYitrMTRoR21icDA3a0RTejdVM3BEUWVJYlVP?=
 =?utf-8?B?MGZSaGJaWWxCNGhleFlGZnBOK0diVU10VC9WNWpOR1ZGYVNjY3c5S21HdzNB?=
 =?utf-8?B?R2EzYko4eDBQSXhIRzdtVlJmZmx3bHNnVHZ0L2JGTTB3QnhXTmgyN1FoNENU?=
 =?utf-8?B?M0JtNjBVa213SmthNVVGcG9MTlh0eGdiR29rUm84MGNzcjNUbzJrQ0poalhv?=
 =?utf-8?B?d2xXU0FidytTdnhPYUs4YzRMblZXOEVicndtbFh0L3NyRnZFRGI3NFg1bzFq?=
 =?utf-8?B?b3JEa2NUZnpIdGh4ZXBPdWFuVnFIZmpSLzJIVjc3ZWdBMDRkOTM3ODFGditT?=
 =?utf-8?B?Q2drVzhYNVZnVHZ1bjlTVnZGcGNQTXY2bDZOMEs4ODZtSzhpZEpZYnJtSjl4?=
 =?utf-8?B?OXhubzJFbWtXSG5hQUJnelY1MFFQR0Q2a3JudHR1Nm1VZWRzUzQvRWJYbWJa?=
 =?utf-8?B?aEVHbGtxdHJ6YkVjbmNQN3pDUktCQWIreHF0S2pLYVA2b09TdjN2UGdmU3M5?=
 =?utf-8?B?ZGJ1RTFtaklUUnJEb2Ezamw5ZzdKTDY1NWNvd2kzK1NWb2RQanNrRFBYV25m?=
 =?utf-8?B?TGJ1V0Z4VnhiaXppOXJEUVU5MklNVkxNV3phM2tzL2NJOGVoTnczK0pxenRH?=
 =?utf-8?B?Z2U1Yk5lYndRU1Q2Z0x1M3VYSkhWbEpTVmZzWVNBanhQT2FpNHNKajJkcEFl?=
 =?utf-8?B?eTB4SU5Kd2FzeDFOeDBBQ0l5dVM1WlVqR1N0Nnd0dm0xYWpKRVhZMCttdnZJ?=
 =?utf-8?B?VFkyaXhXTDhVYkNSaURYMkhaR1VsTEwzdHhDeDZYUU5uNWh4WFJmdUdrNXRF?=
 =?utf-8?B?ZHNBdE5paXdmaFo4cTVETWFjU3J1UEZ0QkJ4ZWMwajZFQ0lmZUU3SWt6NHJj?=
 =?utf-8?B?S2FsVHQrd001NlBPSXVkRmpFczE1a2FKS3h4VnJpMUtJeXc1Nml5Z3JWajNT?=
 =?utf-8?B?OUVrY29zWnp6N2E3UDFwQ1cxZXBzYS9yYUV3KzczamxBbnJaajg0bkFieGhv?=
 =?utf-8?Q?mU7HY9/Bdh/tWBE3MsZfNmHpN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b922173a-7ce5-4839-d730-08de0ccd30c9
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:00:56.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdXymNeEtp+Jn+i2l0vh+rycHlkyNVTZJumpl3etFdUzcQxYb2FeuNBbg1y3yJFoCnfXP4EXgi//npD0+/4mhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069

Rename i2c<n>mux to i2c to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6_max.dtb: i2c2mux (i2c-mux-gpio): $nodename:0: 'i2c2mux' does not match '^(i2c-?)?mux'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
index c727aac257f9c3a1f16dc357fce355ad46a3f699..531110d405d0de9bc2dc926d550c00030d3aaa30 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
@@ -135,13 +135,13 @@ i2c-mux-2 {
 		i2c-parent = <&i2c2>;
 		idle-state = <0>;
 
-		i2c2mux@1 {
+		i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
 
-		i2c2mux@2 {
+		i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -158,7 +158,7 @@ i2c-mux-3 {
 		i2c-parent = <&i2c3>;
 		idle-state = <0>;
 
-		i2c3mux@1 {
+		i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;

-- 
2.34.1


