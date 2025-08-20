Return-Path: <linux-kernel+bounces-778202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEDEB2E284
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F3D5C5792
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473A33375AC;
	Wed, 20 Aug 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8RfIlal"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600633472F;
	Wed, 20 Aug 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707854; cv=fail; b=JOf5pJY4hyrR34Zm1RYG5yl8BcAzEGnk1MCmQgr8g+mngC3l3IEObTS3GdvET+dTW/ByKXhFT6SnLkhvNeNc2h7ccmrhjpwsTubT8gskeEjSI9lJ6mJXof2q5Efbzm6MW4RlYFcCC/T3luSQmzHMP8H6MnlZ+xeU9aAW2yMEkV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707854; c=relaxed/simple;
	bh=D2nUf+uLctE/BOlS+efj3qWmbOD/DtvoLL39ye/W1Fg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tOP8Jr/nKf1Guy6jUgPHReqCq8Hq9SGRYO7TLZjeJdibeHzmExNhNq/CKGoaKFXfcu6lkZzauI6kQF+LzyeAM7f9NXz2mrDp6pCEmKtBLQnkVWKoXbYYhiV4P967w9ZAuSZT+EPVFeIPB8HDEEY3Dtu6vOzqsWY+DpnFa6UzBEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z8RfIlal; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDJRCDlgklQKDc5HXdkqGFNiof/JY+okPv6lZTWhEOu9xeYWUJf8bsptO9GFqzZA6Pm9z8qALoxGl2VaSBvR3+J/b+My0o3KIqID22ssFgZ5CMwDQz3WfhzqgSo9uc+kfcO/pYwJ2kzQhV2335saXI4ujc2rC+Vr6+UPbbCy2fUpMc0rjxz+hIrDqSMHcnjS2C1OC5WLDXdakakj9EFiNLc3ISG8DFHAGfjc5CsIgX0HgBNd0I/vIBV9I0/oyAxt6Z9QiOwwAuYON3yzOEeIQ8300SrGDjzkWCDvQLal0Rtf2sTdzy5E91y3nFBJCdYzW5sLw5KxDzk8Dw7lTixjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC/YeAWx3g2jgrKpvYBoKTs5oa/soYflpRw4ewa0bv0=;
 b=JPLoUOowflmD0sfyc9P57UMqaVMqD8KyFELtwTtXsUpy3ADtTwHekqeqwL0+etoByt7T+ga71vCyNHonrNNhnD9gtZoOgVErRIAjKttfnbbmjZQgWHZ2z9p9L8P+u2NWLxsYoctMfz4K+dOyz8Y903MmM0DlUmiUe58R3spOGIJBbZ9prVjzTIZ6Ju9Cyjx632SNvfN9e3jvwcHno9TUJoCo50vruihfEhM4+iMJ8MfO6aasbPd9ri9yUMGIe+XJp/b0Q4WSQvuRlna4y1mHgNquWSBH9Ej4h7L0wVzb4zC0Fm8NpGxyYanP08NXELqVFZG4QX74j58SDrjSCFSeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC/YeAWx3g2jgrKpvYBoKTs5oa/soYflpRw4ewa0bv0=;
 b=Z8RfIlalz7QLXGk3+3vPzLSUlWl8uyBnQRgpd5PGigWpSz4nyaywokJ3Zb7sEdv2iYnnB5m1IzxYW+dlmKNZdUWB7cah+fJ7G64G955G1nWi2El7Yr8F2auJLAaNOzFzrG9RSfqI7S13FKxkQIBxpOEgmNnP3aEJ0s5Ffy4PvftBBlcCIJwZP3azLsVnuJJvNhMxUNmhbsXpdi6vA/M0FtFWftTZlnwctoJT8VjoMIdBIPkmNmKpMWhJ2v8szUDQsM6czodirRLz/3Y8R4rn4f9Cd0CKL7irB1ar5oWmdf9LFYnDcOuFydHuqNb0l0ztmg2IgtELOLigiYBWQO8Nbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10338.eurprd04.prod.outlook.com (2603:10a6:10:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:37:27 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 16:37:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Aug 2025 12:36:55 -0400
Subject: [PATCH v2 5/7] ARM: dts: ls1021a: remove big-endian for mmc modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-ls1021a_dts_warning-v2-5-2e39648a32b7@nxp.com>
References: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
In-Reply-To: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755707830; l=931;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=D2nUf+uLctE/BOlS+efj3qWmbOD/DtvoLL39ye/W1Fg=;
 b=dXH2/Dr/PV+W/jt+oBLnXlY2IBpwegA3a0aHwOGx/eQjHOwRMMEoaWnu2QABRuaBCX9Yb4MUa
 P+kKXaX6YVfCOywTRWun1c1siXZGmqPrLRPxxbLtAzZiAAeG/86nvSN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: 3100c718-061b-46c2-8c37-08dde007d8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWUzcWRMc1RNVkplSzRxcFZVaE5sWEVoTi9kdkxRSEF4V2lPSUVEbFVtU0kw?=
 =?utf-8?B?TVJsMkpIOU9jZjdVYk5aVDJKRE4rQk5RaHcxdEUxbkJvMGtORWRpSithazBB?=
 =?utf-8?B?dFg1MHJBL0h0SHF6QVV3YlN6cWwzUklaUTcwMWYrcVlJSkdIeGRCU1FyUHhN?=
 =?utf-8?B?QldJSVVSTENRTGQveGpwbFlseWh0Ym1Mdlo2V2ZYRWFFVzdJd05KOWQzRE92?=
 =?utf-8?B?anFJaW1WSGJqaWVycVc5dFZJaFY5WnA2ZXczaExYejVWNGJpcHUxVWViVyt5?=
 =?utf-8?B?a2hMZ0tHMzJISVUyNjNWMW9aY09qUjNVc0ZPVTFnMVN0Z1NYUUxCc0twS1pn?=
 =?utf-8?B?Sk1SNlVTMWtvMjdlTGVnc3BEb2pJU1p5SXNseWhtRHc1MGdyUk9wNmczVURP?=
 =?utf-8?B?NWwzUWkyRXdHVlBQVjFXWlhPY3luV2U0V1pVa1dvVWxGSVlib3JRd0tyTUpx?=
 =?utf-8?B?eDNQdkRQVk40OVFBVGdXa0dYYmRZTTQ5ZHZLNlNxTG41ck9ZTE5paGNrd3NI?=
 =?utf-8?B?MWg2SzdzSjZlNkUra3pIcXV4TjVxc1NIbEZUVGFZVXAxYWVyL0NoOFhEQzBM?=
 =?utf-8?B?YnNHZ0huS2VQYTl2WWdvSjFKK3YyTyszWjRlSDErVEQrWFgxUTlDbGJKa0s3?=
 =?utf-8?B?U2xlRkErekJTQTNIdGJuRzlvdUY1MjE4dml4cklhbDJVb044NGxCL2daclQ3?=
 =?utf-8?B?dWRFTGZMNHcrN3FOMjVCQ295d1VLWkY0SXNFWVNWSDVWd2FhZXdYYkhKOFRs?=
 =?utf-8?B?aTE1dHBRNUZ6SHJQSzg3QjFWOGYyUFh1aFZtWDZBODB3ODEzV2o5ek1ySkFr?=
 =?utf-8?B?YWZFeTA3RldGamhYcVRGRHYxYnlCNEtWdFZVZlZPNllTem9OZ28yQ0hoMDEz?=
 =?utf-8?B?NkE4NXVRQ1ZwQUN0ZVViSnBmMUVBY055bnJKM3VQeUFKcnE1djlHaWJyL2dw?=
 =?utf-8?B?c3JYZFZHVzhmZ29XL3dXNStaQWN5NzNRbDZVNWM0dnRrNGNNTGxCcTVvK01o?=
 =?utf-8?B?eWVlT2k3cFdEM241WnVFVUE2cmhUeWsycVNmTU85cG9QcVJWY0J6cmx0MjVx?=
 =?utf-8?B?ZVBsUzlKb2owWW03ZkpmRWxkTU9hekFpem9ESlFpQ2VpNGUycTV2cW95Kysw?=
 =?utf-8?B?NmROVGprNEgvNGp3aFNpcjltYm9MbFdTN1hYdGMwNDFSamJQWkpXTEJZK3pn?=
 =?utf-8?B?VCtyN0lmVVNLalZjZUNHUmx2NXpWU0k4eitSeE1Fay9DLzRaRkRNQVJCc0R6?=
 =?utf-8?B?MEZlQkQ5cXV3clF5R2FaYWJ0ZHp4QmRLWWMramZQWnZ0ZXhxcXNVTlBpZ1pG?=
 =?utf-8?B?VVJsTW00UzdJUTNYbVBNYjFrQXdHNmJpZ29zMmptek43emxaV2lKajB3Mk5B?=
 =?utf-8?B?dHhqUm56R3JzcjdYMTRuY2ZaM2djcVZxWk9Jc2xuTEk2U3d0NDJmME05T3da?=
 =?utf-8?B?YTByc1NqZTdURnBNdk5FV2dYd2NyYVZlellCTXJwTnJKWmJ6M3IrcFIxZ3Fj?=
 =?utf-8?B?dVlaL2hBSThhWHpIQzR3WTJDbFF6OHFQUUhOaDF2THRycS9jMFA2RXdsREVj?=
 =?utf-8?B?V0NacVNPb0dKdUxyR2hiUTk1aUtYcHN1ckxYVjhYRXJlRVF1NFZraGptZXRG?=
 =?utf-8?B?VHdKbkhDem9oRGE0S25qUTVQRWxqVzZiRlNLdFh3a2V5cGtyM0lJSU1SM2tP?=
 =?utf-8?B?eEdSYk5XaGRZcDZsUTl1NjRFVmJZZUlPUnVhSTl1N1AzMThyQS9VMFlqN0NS?=
 =?utf-8?B?TFZ0MFQyYTNTQmR0UFRTeWp0eURnTlFPcFdkdVRBcXk3YkxFSm1VQUNQUGxB?=
 =?utf-8?B?N0h6eWZRVTZQRkJ6RFpkK3UxR3FsSzZQS2RvZDBoSjhkeXlqNUlzL2tKSjVP?=
 =?utf-8?B?ZytYRkt4UTB0c0xzS3VjZVBDeVM1WFN1R2x6c3dXeU5pbW5CQW5uWEdtSnZl?=
 =?utf-8?B?ekVWTUFrTjdRL2pKcTFWVzU3b0sxNHdkN0h1V0xCSFE1Z3R5cEd1VDl4R2Qy?=
 =?utf-8?B?aUluNDVpNlBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3NOWjJjVHF2bWFBS0Jnc09WUXY2c0gyTHNMVXlCQU40dGEwa3FiTmRFNllo?=
 =?utf-8?B?cDRiNHR6blRESDJuV011ZXpxdi8xMXQyTmdnV3RuNFkxR25YUEdqRzRsNWha?=
 =?utf-8?B?ZHY0TW5QWk5PLzhEMXNSMk1uVU1DZ3hkakt5Sngra3RsMW8zaTR3MzdBL0dK?=
 =?utf-8?B?K3hIYWd6Z20wbGhaK1NydjNhTU16RkZUQ0FDdVF2WkMrUzNVeGptNFJzejhi?=
 =?utf-8?B?dVljeG5CMTQwMzhlNlZPeVhraEJwRWc3TzBSUVlSKytLR0RkSnQ5Y0V2WVo1?=
 =?utf-8?B?WWZ4R1FQNzdPQWFJcmI4eUdPTm81TTlKTFg3WE5uTFNxU2VSRkpTUFlEK3Ix?=
 =?utf-8?B?Q2Vrc0JpVWg5NVlZYW1LT09ZdHRsU0xnc1NvSXdmdThINlJUc2twaWJtQjN3?=
 =?utf-8?B?czExQ2J2YTJoSlZ6aFpoKzcyOXVLREc5dFZ1bkQxeUErZGFzUElXaUZmNVlp?=
 =?utf-8?B?cytkRmQrS3BVWXJuSkpIOWZnM3p4S0Z0bVcwbW9hSXFzS1oyM1NpcXBHNEd4?=
 =?utf-8?B?QWQ1aGpvSHY4dVg2eitPUjYxb05sTlBKWnJnNW9BbHNvaVZSelNyMVJPQlpO?=
 =?utf-8?B?TEIxcHZpSjBzTTlLSGNCV0dIL3IwM2JRNytkcTQ2Wm5NcjA1Q0ZxMllSZ1Mr?=
 =?utf-8?B?ZWJlSVdPcHQ1MUl6a1hqWitXclY1Nlp2QlJxWUdZNWs2NVdhVm9pQlFvbjBL?=
 =?utf-8?B?M1RXZ0pCaEdheFcvZzVRUjFVYk5uZmpoR3RMZW9XZ3NVZFhoTFZkQ1BKNmow?=
 =?utf-8?B?ZFpHRFdmUzdBbzhZbUdxcUZMQVE2d3RTdEI0cnhVU2dIN2xCL1MwNlQ3WDdt?=
 =?utf-8?B?ZjRaNGJpUHdXclJqdFpTaFlvMUVpTUt2UVBXZFV4TDJON0Z3VHU2NHU3MEpn?=
 =?utf-8?B?VFhCblhYdVp1RjE0L0JBVUxRZWlwMDJ6bFdTWTNzblFKQmFMbUt3bjdGM2d4?=
 =?utf-8?B?RHB5dmV5cDg4bFY3d1B4dTA2N1kzTDdBMm5wWElEd1N5SVRkTmdUNzR4V3JL?=
 =?utf-8?B?VXN3SC9wUU1jakd3M1BYS09CWnZ3TnNRSE9YN1UvY0JvY2dlVlAwK01kYXht?=
 =?utf-8?B?N0t2Wm5XY1Q1bHpPSXpjWEZScnVVWmhCMnBYcVJKMWU5aldHM2hjSmdPbHRI?=
 =?utf-8?B?QXBOUWtiUndLVGVKc2kyV0xPLzN3VDdHTVUvVXIycnZBNUd2bSt0MlBBY3Yr?=
 =?utf-8?B?RmRKdUdvbWlFY21GZDZSZllIU0FQbCtMeStBQ3A2OVFCZzVXVGt0Qi9rL2pU?=
 =?utf-8?B?L3p6R0pjSEFxWUhPa3ZmcDczWFZOVlR2ajNzV1Nob0QvaXF0Q3hqZ1ROdzg5?=
 =?utf-8?B?SkhIMTVscmsvbURod21tUE8yMC90S3pLTk9peXNnMzhBSXB6QnF6MWJkS0xr?=
 =?utf-8?B?cXBZZjVjaDAva2Q3aE5ITTRGOGJmeEVuYlVKMUt2cFdmU0h0SEFxdW9pUnZi?=
 =?utf-8?B?ZjJWRXZDbU9yVmFUTnVTL0wrcjdvcW94YWRrRDJYdnpOWTMwTzJjalR2UXhx?=
 =?utf-8?B?dWd0eFk5aE4zQzRpNEhhQUp4dkZLR1pwdzA2U3RtbmpvT0h4bEcya3FUMFV2?=
 =?utf-8?B?R2QxWVViYVpOaUNvNHpUYVVoY0sxSDdDYzVNZ2pqNmFzWnk5MVI5TW42ekdG?=
 =?utf-8?B?VFBSYkQ1dzhpa2xHWElOQzRCTXNoYmdZREE4RGNGSERGS2JUaG55SDA0NEtS?=
 =?utf-8?B?SlRFT1lSOWdaaGllVGhCQlowdHRTNE1CTzh4Sm1RYi9uODRJaUZXUEt1eFRx?=
 =?utf-8?B?bEp5UUdlYjZ3NHRObUlCKzhPOE1TeWl5S0lvUkg0MjhPbTZNQm1rbnJVWVhh?=
 =?utf-8?B?bXdPOGRPcW5LbGFvcHRTUVBSNFRSVHlHdis3aDJ1SXd0dFVXUG93UmlJcW1D?=
 =?utf-8?B?RVpsM3UzazdEM2RBb05GcldGcHRPTlNKU3F5MUVQclVTNVNnd001OHVPNEhs?=
 =?utf-8?B?TFU2WXFUU3VVOHlSNWdlQ0hUVVFXdFNQUTgxR3p2QU9Zd2dKRUp0WHVrdW01?=
 =?utf-8?B?N3pkWFVYaXVPZTVSNnlGRjYvdU1UeWhNV3RCN1g0SjA1QlU1RXc3WnQ2ZThY?=
 =?utf-8?B?MGM4bVB6NCs5NXJzYlp5blI2MGM3YzZSWVJ6RFladDVFMEVIa2E0VmhMdTU5?=
 =?utf-8?Q?CnEaTuh9VzAiLaLdccSizhYf5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3100c718-061b-46c2-8c37-08dde007d8ad
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:37:26.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDTUcepqmQYWLdc0yQRhrF185wJwVSZBAw3L/fswSXAJ6q6muWEdtz3rXregf4S4Reh/DhPBFIfn7IqjBDLiTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10338

Remove undocumented big-endian, there are already define little-endian at
binding doc.

Fix below CHECK_DTB warning:
arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: esdhc@1560000 (fsl,ls1021a-esdhc): Unevaluated properties are not allowed ('big-endian', 'bus-width', 'compatible' were unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index c3aab7694074d714671ac6c827c87a8491c75585..ce9bb85a72e625c3740e04b12dbe8dab82d4cbf4 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -162,7 +162,6 @@ esdhc: mmc@1560000 {
 			clock-frequency = <0>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			bus-width = <4>;
 			status = "disabled";
 		};

-- 
2.34.1


