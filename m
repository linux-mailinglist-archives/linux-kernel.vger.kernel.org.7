Return-Path: <linux-kernel+bounces-877059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D6C1D13B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF39189C8DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E393644A4;
	Wed, 29 Oct 2025 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EOIfkWGj"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA9E36448C;
	Wed, 29 Oct 2025 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767733; cv=fail; b=jkVl8X8OvRLm3ocjYo9QeLONmv+QMBkJOi16y3jmetQwT3Vxfi9RVLJn1KHem47rz13ndhKC/A4HHbXWplWJMHk20gXmET08q/8Zwj/ZY6/xZJeLibiwlZTb4C1hqKJ7nh6E7vwygSzz8Sp3NEavqaWyMS95oAhE8kSzKUTkKXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767733; c=relaxed/simple;
	bh=Tr6GA/YS/LrM+qcSi15nrZ75JmORttFmMy2RUGmwhTs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HXGw1dUS5NI/SHJY9NbRaF6PpMYGOKi7GFl933yOs794q5HkvbRzWgtvwiMwbU2VwgfnKRMvd+r6rCYh/BarHPzXRRmoNgctaDYRYKxmqiw6zI1bQ4p+/snqMh3QWYk5jos7qJry8FT9WTCeKbFofEi+2d6IbIV4hVIXXOjigHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EOIfkWGj; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5Sa2C4jnBbdfZFLJp/MGRd2aY++KcO3S5kRI5UsrwUyuTn/YQR3efAgI+nieUTcua28czT+CAt3DwQhkNoKY1CvRC3w1Oz2KiuMlV39CFKTTAFBHmPQMLUc/cV/nj1TO6VQUL4kSoDvAHpGVKKJPxdMgjf4mREV3nDRhoVGtklED55rWA2+dlNPxU60vze4NOgUwIB6MnEOT0qtIZLdxmg94SjpkQRcbHzY9iarumTONHvISlDU+OI+YSf0Lc82GYeMxdr7RmXqzFHPAGTxyIqtSUk72PM+ci5cWtwgRFQW/BLzDS5EnQKCJwUpbGRCgmtmkFVIe2y72PsLR75kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YEgxZY4UJZS+W3f9za5gzeWr9pMSUjlHh/csajZ05s=;
 b=M3nTPX4llTXfWfOgvDKf3i9gnT/9l13hVo+xE+tdFj/OGFTcEEOahD505pU0FI83jj+a3UpBoL6nFtd7LQp3+/D2/g2y1p3q4zjkAz4Epd7F2cFzwU7XgZuiael+/s9c3E4D2UYLGnL2Xnkife1xCkTuVLhwv2cGJvDzG2AxjtEYGlEhs92kh5Ywbxf8a3GyBOaBcVygT/p4Br6T6QBEh1kpsFhLTCmXncIgZa87EQbxfVSE2l5gzZTPmHdZwgJMvqA8Zl3Aiva14fYsnKJyA/7qttn5nM1q3Gx0bJXvTWaSfUG9LSMaUldLYsJm9bc2QojzKXO/9+DvWCRxHbHoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YEgxZY4UJZS+W3f9za5gzeWr9pMSUjlHh/csajZ05s=;
 b=EOIfkWGjPN4fD4xI7GxJRnJLjMJMwE9Fc48pR7996wWiujAgzYRbc38fNWvCfi96lWG2LNmrbK+NmKBUfmbPVCZc04NM9egoXwSNUapF5Mb3rSMc7KUKUE8lW0yx5lvJVOip3diqVxi4QlAI6uQ9EwyK2xJ2wa2TFqR2j3QuCfR9Fz67dDfWoVBvNsQ50TO0rHmRkRhWt+lJEqGsTSTS7lyYSAcmA14gg1ZpioL3/UsCoB31kkHDb4h4Pan30QzTpiAGYfxw9SOxAMkzYNYY2yIuhexlvtRzo/QCIQkXyqOXp4MLsnYa+oeJr3zEnohgX8Ib0pWndnoMXsh8GOUO3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS1PR04MB9682.eurprd04.prod.outlook.com (2603:10a6:20b:472::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 19:55:23 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:55:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:46 -0400
Subject: [PATCH 10/12] arm64: dts: imx8qxp-mek: Add supports-clkreq
 property to PCIe M.2 port
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-10-cf61b7e5fc78@nxp.com>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=1140;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5zQcx8+FRNBwOSM5nzlEhw4OhJJBvBLd+2m5btJbRH4=;
 b=Yw8mI7Ip9LdJJmpyqVHZqWq8c7hI5Y8CSzLCohymnfcnwThSxEaNJzCgPc+CU7bh0YJG2l/5B
 PD42dRPIQBSB71ViptepkBYbwfZIYdQOuL9SYx8qiPns4MsJxILTrst
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS1PR04MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bc1671-743b-40a4-6e4c-08de172518f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmJIaWRFeTRndC82TmZ2Q282eDZRb3VuS2xlQnljL1VRZUdpcGlPTGpuZmdU?=
 =?utf-8?B?RHhoVkV6cU1hKzVhNjR4bm5lS1cyd2JtemRVTE5EaWp0SGNHUEJQOS9KQk5m?=
 =?utf-8?B?NHVJWUdSL1VqZWNyc25qaWpaYzFWKzYxY2xYNHRHZmhoNWJDY0xmQ2FhYzRX?=
 =?utf-8?B?NW1uZlRxblVodklQdXRrdHZkb0F5THQrb0NiNlc2TURpYnBrODN3NkpnVksy?=
 =?utf-8?B?akFxZmJwamx3N0k3dG5MSVYxaHNvVXR5clpYc2F3L0dJci9TVTJmaDJUaStW?=
 =?utf-8?B?Z0FIdDZjT0hmZloyMnpVbXVJb1czb0VpMDBZMUJwRzFuOEZuc3lDL2ljeFZ1?=
 =?utf-8?B?UmxISTFobngxZ0hyRVE4SXRXWXJHV2RRbGNpZy9rVGI4Nk5WWUhkTWJwYkNL?=
 =?utf-8?B?UVcrWm5oK05mN2JMR1F3THF6TXZLdHVUNjFoZ3dnTHU4OVkzZVZHTnprUVBN?=
 =?utf-8?B?Z29iSmo2YmhzQ01OOWFVK0VIdnpCN1NuL3g2SW5uN3dJcXlkU01GQmNCbGZN?=
 =?utf-8?B?UmtjUkVWcXEwQXJRaUxmOG5CaCtmd0hIc2ZjK3FNYzcxUWxhclpZSm5COG9O?=
 =?utf-8?B?dXZ5ZEpNaVU5WW9FVEJTVzRUYXhjRUFoR3ZwSVBvaC9RV0pmT0RNeUJnQ2pQ?=
 =?utf-8?B?R2ZDdjBVbUJHTWZ0QnA4MDMxSWZTZi8weDgzck5HTktNMUJOdjdGekhoSlM4?=
 =?utf-8?B?QzlBVHFHdW0zSUVCZXhCdEVSTE9ERi82R0hDaUdtVVluTG4vTS9WRnk5NUY3?=
 =?utf-8?B?d0wzb0VTSC9QS1ZDLzllSnNZc0V3RC96R2laRlFvampvcHdBNHJmVTNtZTg1?=
 =?utf-8?B?c2l2Rk9DSGttd3R2SUxSS0tTK3kyTkxuWU15UG1RdFZzR0tyZG8zazlRYkla?=
 =?utf-8?B?VVBTZ1J6aDhHOFZwZmdiRFl3eDNSN3paSEZoUnZ6YzMxUmcwVFhadXpxSHJT?=
 =?utf-8?B?cWNNOExwSlFUblhWbmVZVzFBUFZvZ1daQWNUdUcyNWhiL21RdGZ6WkVlSUpY?=
 =?utf-8?B?blRlc3RaS0EwR05vZnFMMDB1N3pISzFJSHNhczdCZVQwdkIwZzFpUUI3aEFR?=
 =?utf-8?B?TTVRMTVSN0o2RzZsYUN2VkhueXl1dHZrUUw4ZUtOTHEybzRUemc4dXRrc2gr?=
 =?utf-8?B?OTR3djZjTjROZHM0eHJVOXF1Vkx4RDlRT0dZOGxobElESk8vS2o0d3V6VTJZ?=
 =?utf-8?B?MlpEbEJrSG9NK1pBamRuZE9NWHBDbjNsTWZxNTFYSWFTNUhNRFQvRGlkeWJK?=
 =?utf-8?B?OThVeFFkaEhNRC9MSTBXckx1czJvOFVtOEQ3c0dEVitXOUI2azhUSSsrOGdU?=
 =?utf-8?B?RS9WQXJCbCtreCsvenNxUFBVSC9EVHZzZHMrbElyUHNiVTQwbVRqOTZzWnlz?=
 =?utf-8?B?WUFBbkNXZ24yTzBMWW9BdUhZRW03VTNkMDNJZ0J3VnYzYW5CWHRFc1BXV0Vq?=
 =?utf-8?B?WnBuN3QxUWZ0cGF6QVBtUXNpYVNHaWZnUlBnYlNsWTRyQ3RNTnhzZDJlMGRk?=
 =?utf-8?B?Z0g1SWhMZitMME9OMjBUMVJQZDl1RDJZWXBiMCtINTdhbFpYb0tvS1diWXZV?=
 =?utf-8?B?UHNEYmtudnA4Mnl1cWpSZHlnNU1ZVmd1bU1YNTZTUzFJNk1iY1AxVmttaXZC?=
 =?utf-8?B?Rk1KdEJnUmpsdGZuZ0tSWGJqekdpSEtFNVoyMSs2a1QxZEF1VVVHR0Foc2dp?=
 =?utf-8?B?Tkl6MktlUHZiMTlYSE8wSzRCY3B1M00vK0ZNRHhsMHd5RDRGemRGODd3WmR6?=
 =?utf-8?B?TEw4d01CTDRUcnJycE1FQXU2Z1BSbU1iVDZ3RGVwUmZxcVgyc1pYTHFQZU5w?=
 =?utf-8?B?NXZmMm9sU2JZdHd0VVhYakNEejFSTVI4RlhxZkJzV3ZFR2krY3BXQkpFbTBP?=
 =?utf-8?B?WEFwMGc0NFlRdWp0bGNBZk45TTMvTU4rWTN0MENFT3pQbm1BaGZTYjM3QTR5?=
 =?utf-8?B?aVVUQXNwWkdQLzBKYytKS2xGYmo4cjBwcSsvUkY1YjlsU1VDbW93RnZmNGlr?=
 =?utf-8?B?SzF2bFhvcE1xYXl1dit4SUxMeDVESzFzNmlqZHB6Vi9aNGQwVGdCVWJWSmxu?=
 =?utf-8?Q?bfNcuQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjNuV01HU1lqbGhCcTNQeklyR29yMTZ0UkZlZi9nbG1pYXR4OXlsRHRTQ1Ir?=
 =?utf-8?B?ZUxXdlR0Y21HNktRcnBkR2VYeFAwY0VJQXFTeWpaUE9aUm9FR2tsb3RZcFc5?=
 =?utf-8?B?MzdCM3k2Y0V5OGJhR0J4bjc3djVYZVBUeTduc2lEU2hnTWpyUFIvZWdWblYx?=
 =?utf-8?B?elRqY1lRUExtL09qUkFEYUo4aHBLbmg1RXhLb1ZZc25hbU1wbytFaElKbUpT?=
 =?utf-8?B?OHRWLzloM01DWk9XVlF1M3Nsc3lCdTFzZHNtNWhTbUw1cThCUis5QVJQRHRT?=
 =?utf-8?B?dkRwOXZkMjNDTXIzQm9oNXkvMGY1czFBV2t4V3Q1UDgzNWcxdVN0WEtOZERi?=
 =?utf-8?B?WThDaXd1UUtNSkF2U211WHZQdWtIZEZXMHRTRUV0S09mYjRCUWNZZmg2SDNJ?=
 =?utf-8?B?S0NCV2V6ajdpSXgxc1hZTXljekViYndsQlF5aUk5Ym0yS3hRcVlRVmF2NWh6?=
 =?utf-8?B?WWVvSGpNdytKSlp3SUVBNDA5QmFyMk4va1B4T3U1am1NSlVWejRYdHY5Tlph?=
 =?utf-8?B?UWFIWWZEdC9Fb3cvUDd3SWIwc0pYUXFxNitHVDVoU2hCWTZNdjNmSkkrbG9E?=
 =?utf-8?B?WWJqUnR0UkUxZjl0QjhZUEhta09wRVA1VTRqUFU1M0JhdDQ2S0xoSDdhald2?=
 =?utf-8?B?MHJRWDVoQ1hSSlVTbXV3WjNFNlVHcUY0S2VxT1kzL3k0cnpvR002eTZsUkMw?=
 =?utf-8?B?aUp5NHN2WFJnRC9iRWVFVnlIbERkS2MxMmxIYVJMZkJseFRSelVvcGY1Z3VH?=
 =?utf-8?B?aThCWFBJRDFDSXJ1V2tkbzZ3MVJSZmVBT2hwcTN2c2E5SWVrN2hTejkrUkVX?=
 =?utf-8?B?L1BBM0VkVEE2MHkzekp0Z2l1OCtETGs1OCtpNGo0ZkdMdFVLOC9rN3NPVzRZ?=
 =?utf-8?B?NThSOWRtYUVMSHNyaE9RV0cvMjM0WFVrb3lWbjlSRGprV0JnY0pCUjl0RE42?=
 =?utf-8?B?Zmc2OGw3cjlGWXRObVRlMDJYQ2djTTBkcFBSOE00TmtlUGV6MDV5U0pia1VP?=
 =?utf-8?B?ZkJzdXJPNnJlYWRZSDhBeXFjZWlTdmxLQnVzRjZNTThjMWQvZE5YbVdaRVYw?=
 =?utf-8?B?Q1JIb2dadG4xYk9FUzkvK3Ewd3BWK2kvbnVkSzIwaXlNUzdRR3l3M2RYVS84?=
 =?utf-8?B?aU9UdEZCM3FpdUFmRWNDUW9jdkdSbURYNCsvQjN4VFBrY1IxdVoxUXpqNDBK?=
 =?utf-8?B?TzJ1ckNoenVYWll3dExMYWZWUDloZHZMbXpJWDN3MjNNVy9LbHNlNWR5d1Y4?=
 =?utf-8?B?T3VLbXREanJwYzh3c3VqZFFnaDU1eEVxang0YW9aamtOR1Q1T3B1Njg5R1Nq?=
 =?utf-8?B?NEx4ZHpyazgzSUZHdkIwc1daRUZhRjVadlBXNWpNVDE1cjkxVytDbG9oSDVw?=
 =?utf-8?B?eUdXck52NWxxTktTcHJqa0lFNnJuenk4a3ZNZ1pqVkRPWDFhblJIMFJPS05H?=
 =?utf-8?B?MFVaWlcvdVh4WENmYmJHT0FRVjZUYm5TbGF3U0J5TG9MNmRRSzI1dXg3L2lK?=
 =?utf-8?B?OEZPdjZrRHZVSllxR1NCWWpkazFYMjFVamxwbGhGaWh5aVpSSHdnSjFtcE55?=
 =?utf-8?B?Mnl1cWNrVDAyK05lZDFnNUx6M2ZlbUtPQzlCNmY3WkhKd0t4dmlJNEI2TnI0?=
 =?utf-8?B?K3l4Y2FxMlhKcGhlbDhzeFhtdlRZNHMvMU1EVDZVMmRpR2M3dGduVm05TFIz?=
 =?utf-8?B?aUxKYkpjaTAyUHVlSW5HYU5oMVpMMGRuN3ZZOGpQU1p2bGwwVkNhSW10Y29C?=
 =?utf-8?B?emgwMGtXeW53NmlSYXVuTjhGU0ZxenlRUFhub21SWkVjcG9uUXFod1hDbDYr?=
 =?utf-8?B?RHdWSmhzcXY1anp1dTNYVExkUXoxN2gzbGYzMW85OFJHQjZaRU5QY1JmNHUy?=
 =?utf-8?B?VDg4eVpWOVp6WHBCUjQ2VktSemhNL3Q0QUY1MHJEa1FTaVZZSHBrNytPdHdM?=
 =?utf-8?B?RVl1dTIwL3BSdTRZTVNwcHFNZHljZythRUFVQUt3b2o1TURnTThpaWZ1MTNM?=
 =?utf-8?B?Y1JleVZJdHFSMGJHMUN3bWduVFcxMkNqNWVWUFFqd3l3bEx3TmlyN2JIZHly?=
 =?utf-8?B?emNodzAvZURBMXQ5UlQvSi9DbklyK3NBZzVzaEk5VitYeEN5UFFTa29GNitJ?=
 =?utf-8?Q?xfQONL+IkADEe9Fo3gXAZsxpO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bc1671-743b-40a4-6e4c-08de172518f1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:55:23.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/vqaGMFrYEQxMcj7uNameUXF7CvHK5S4ae8PWCSWH841cGiYN5N6S4Q3Aip9nwQfPB1JaFVutJJOTinuIzcUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9682

From: Richard Zhu <hongxing.zhu@nxp.com>

According to PCIe r6.1, sec 5.5.1.

The following rules define how the L1.1 and L1.2 substates are entered:
Both the Upstream and Downstream Ports must monitor the logical state of
the CLKREQ# signal.

Typical implement is using open drain, which connect RC's clkreq# to
EP's clkreq# together and pull up clkreq#.

imx8qxp-mek matches this requirement, so add supports-clkreq to allow
PCIe device enter ASPM L1 Sub-State.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 13c308d007fc0f991a5714d13a9162bdb499db2c..fc10710e4ca3e8472f32ba0beaadd27382ba756c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -673,6 +673,7 @@ &pcie0 {
 	pinctrl-names = "default";
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
+	supports-clkreq;
 	status = "okay";
 };
 

-- 
2.34.1


