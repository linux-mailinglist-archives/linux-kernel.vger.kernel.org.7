Return-Path: <linux-kernel+bounces-833240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7809BBA17D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710AD741ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129632341D;
	Thu, 25 Sep 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LZKgKeHw"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC2323F4C;
	Thu, 25 Sep 2025 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834887; cv=fail; b=DL5lYlz/+/i9W9EBcqAz6J2WgbMXAjezI5+0HOG1WGZTdJdtNCJuZUOXyUmXutu8HZhdVkrNPeMKNcT9oa3EyTzLBak1GbQYsX72pBsRVuCwiANbXmNmeoiaOQoq/xwr593tY+/V9sbuM9xAj/Yic7hyNsjq4iX+9uajH+ORBR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834887; c=relaxed/simple;
	bh=8iUChnDAGpyRnCKC3p1a/l2BH4aQI/W8Jnom8LWPUxs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VrrWTp3+Vz15p7e8rPLMX3QU6YO8Xo2xkNvepqHZ5tDlotovdgQFUUD237zxvvEq3M4UzLuDTvBEo9w/AY37jYzkI8mK6EL+OaH5Wy5DOoKbjW4WwFEwWM4VzifHL8+St1H/T2sYA47fbE9qSCQMqQ3vFSqlbDON9ur7XbG6vFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LZKgKeHw; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUbphml6eQyAsoXfrx7MB67Z9zwBh6IHyBfstjLXNoPxkpjlEfkAy1C1c8QKuGm2ufgBec4fC7WWywZXulxciEfv308HG1iOYhFCIfCVNdckcKtUiWeLUJc4AtWo9k9O0ENp8NDpRJfhDgvG3zSnaebsk02rTItKOqJbbTodi9xLNXJoqG+9+DUtmQITcefgl2xiIHQiCVT0eNRCy0UeSWy1gSrQ7uzTLefmOSvWBAitt8e7VaqQj3d7HrwxpvNgF5ltKopmiEAs30oy14pqJHMSGlOdK8CHmEaFkgrI4Qn+KEB7mkdTaF+Ec16+XEWXhYI8hUG7/uuFSkxJv6Qq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10eIN9B5ATbGfjwqCdpK0oVg9mZ+w9ks5BHSBlyTF9s=;
 b=Ufhvp/aMEzf5rJUp6lJQ/Y6LzH/Wy90lvd4qJcnZZoE4dMwtb7Cu3udgKRQVvIc2Z/+y1dHZ88J4Wk9ibzx1j5gd6/9Eue76+L+jcttm8JxS/cNc/mBT0MBiVqx7MtbgdhOGhso5VIaA9vPkCn0w2PsFxoqIzBpDfzh7SamGKhFyKTQGYEiMoCTo52kyeeVQmbcj+LW3Rf5P5ojq7bh6tkDtlfy043LCUBGO3X6WfC4YuQ/CjsDZepxpluTSNB5z2zlnatpZJdgpk263czMMnJTOJSN34lAYElbuaZCJxQBuR/bbhIyvTb40d7MKV2WwUtu4qoLqkOrBqhcrrkBruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10eIN9B5ATbGfjwqCdpK0oVg9mZ+w9ks5BHSBlyTF9s=;
 b=LZKgKeHw4agkyI2Z2iC2wEb66X3yWttml1byQlFUk362DybbUgSe8BlHIdLVfge87cRMgVwunbVujqQG4PEMXjXhFX1u8W4smxbAT0L73M1J4YAzOPEzeMC3apxRulTrCj6iTXmsWUQOWZrE7+aiGu2r3UfTt1Ay+IxwWamlCt4M0h9yw5w2WAQNn2algiV4+7MMXhOkGdQFkg4Vadd6YgDxuwd3fDf8/sxQT9HJ17X0pI9+OVkmYdQKfBQT1QWlkFieQcJuDwlEbHkI/oMvkGpmPwTmELXFWvd+sBmjI4VdhyTdN580v2H996Br2TTSScjQthIbVRqJ19SeeJiYlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10070.eurprd04.prod.outlook.com (2603:10a6:150:11d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:55 -0400
Subject: [PATCH 11/11] ARM: dts: imx6qdl-nitrogen6_max: rename i2c<n>mux to
 i2c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-11-748380dd0d22@nxp.com>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=1176;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8iUChnDAGpyRnCKC3p1a/l2BH4aQI/W8Jnom8LWPUxs=;
 b=WK91RixZSP1s2McxNbPDF5N2TK61uM8iNw4YDRO+uh37HJnE82wBuNed5gmMzc5zaCnks1ph3
 UabRu9aKl9MDyA0afNlzlvOKZKTQxPD+zHnNhQf7gcHLOhsnjrVrV9x
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10070:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c31a097-355a-439d-6c13-08ddfc788a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG9IbVZBWDdRTlpsTXBWK0psNXN5OGJnazZZUFc5V1daU0g5SW1RTEdwR2pM?=
 =?utf-8?B?cFZJMmJncklmdGdaanA1WlR0d2N0NDRvMFBhTHZzaFpPbG1tNDk0dVh3OG5m?=
 =?utf-8?B?OE1Qb0Vkc2E1WmdnZGw1MUo1TzU3T3VaMWdsQnFhVUVVY0FEbGZXWnZON3Bp?=
 =?utf-8?B?Q3JjLzAzSjBZMkEvcHVKYW1mem1mSWtXMmxOQURReklEVjlGMnBTWFFtUyty?=
 =?utf-8?B?M1N2VUVSVVlDZjN6eVdEYUdZZ1hRemFCUGV3UUxkZ3dvVFowTHpQMWRoNDVm?=
 =?utf-8?B?MEdUYjMxSHdrME5HaFMvTW9GdUJ3QndCQnpJUFUwZktZRElIWURXNjVKK2N3?=
 =?utf-8?B?M2d1a25pQXlYSU03S0NMNEorMVhMNGZkRFhJY2xpQ0hLUlA2SVdFTHMwbVk0?=
 =?utf-8?B?SzJEeFUvTGtQQUxmb0NKM05nQTN1aFZZMXk1Y1llUU56c0drak9Eek16V1dw?=
 =?utf-8?B?WDhWNWsrbkc2VXUrdGdqL1AyOUM1aU9vUG1DWHJza1dQeHFhU3NqSGJSZmE4?=
 =?utf-8?B?YUNiMjRhVzVKYkx5a2tRSDVSMXlQY0hBUGU4R3pXNy82MlRUS1JpL00rYVNx?=
 =?utf-8?B?SHFTUkh5SGJDcCtmSmlMRzh1STFwOE51RGs4dGhHWW5LNTFDa2RJM0lNK1RF?=
 =?utf-8?B?OWY5Z0JpcVV6TTBSYU5oYng2WnZJT21KQUFhTU1weHJlL2lTVGhCcGZndTRY?=
 =?utf-8?B?REJBNXBGMXJKeEpPN2piSzBYSFBGM1RNQjdwNS9aWmx6OUZTMnNobk84OVpt?=
 =?utf-8?B?VkJUNThKM2hZeCtKZ1lmRjZqaHphR2U1dUZRZGt5d0xCT2g3WWpKVHVSWEMx?=
 =?utf-8?B?UE4wTnAyT2dvU1QzUC83RjFBRTVhVWhNVGZsdFdjWkZTbGwzZ3J3REx2NElp?=
 =?utf-8?B?aEh1Sm4zOUkyVkJBTUpwVVF3bHdrYkJKdExYYVFOdGNaeld5WG9lM2dicDR5?=
 =?utf-8?B?bXhVOWYwVXJNc0pCTkVsTklmcmtOQjVyS1A0T0VWNlRubjVHWVlzWkZGQkZL?=
 =?utf-8?B?ZUZRbFFXb09KbFd4M3R6OHhybjVLOGwzN2Y0VHhaQUxvVTU5RVg4YmdWV0Ra?=
 =?utf-8?B?NE5GSnJqYVozL2ZQWmxjT1NLdHlMc0dWSG53cFJ5dnE3UDVZL2V0bE81UER0?=
 =?utf-8?B?cTI4T2tvOUdheFBlbWZveU92VkRrSDVITlRkL1kvdkdmYWNWenpoUVFQQjEy?=
 =?utf-8?B?M3ZKdzJVVG1zSVY5d2VWZFV5eXkyZ3dLSTI2ZnAzalo2TjEwanNFckxQS0No?=
 =?utf-8?B?TmVOZWZGSGNzWmttVlFYenVyQStkaTkxd0ozazdvWDB6bFhvVXc4TzMwSFhM?=
 =?utf-8?B?RXArR3V3L1FnVXpGbWloME90d0pXdzJkcXVOODRGSFU0NmhDdll4QUpNZ1Rs?=
 =?utf-8?B?aS8rSDVFZUw0WUxBK1l5MGFiWFErcjBlWVVjL3V1ZDJMNkNUb29SZWdEbHhZ?=
 =?utf-8?B?b2VuYXhUN2xBWUIzaE0vRkx3QkV4K0tuZjVpWGM2eXJrQUM2WWVPVmRTQ2dC?=
 =?utf-8?B?a241aDJRZmREdjZwengvT2JKbDdUdUZENmNVbEVDeUN6SGtvL29qcmxkUGZz?=
 =?utf-8?B?R0JMN1FqUzhPM3JZQjQxWlV2STJ6U2J0ckNQekZpV2EwQ3RwMUl0Q2duYitB?=
 =?utf-8?B?WFRRbkNZeG8ySmNUTjN1WkFHWUE3STEvQzJVOE1ZVFYxelhxZnQ5UEV2L09T?=
 =?utf-8?B?WVJQLzBidmN4cW1RaG1TZEhIa0pRR0p1ZGxVb1RFeVBwZ2UxUjFvQU50aGxN?=
 =?utf-8?B?V2VQNkV0U3RyZmppVDJ5QUtGSXZqbE4xbE9zUmJ5a051V3pWS0VxVmlEdlB2?=
 =?utf-8?B?ME5nNXF0UjNBM2Vka2h5RCt2TDFDaWVxUTlPQW04MngvODI0c0lsZmJNQVF6?=
 =?utf-8?B?cUdWeHpGbHZ1bFB2QjkzRHRjMEVOcldNTnBxT1ppc044bThzZEk4TmRaNTdi?=
 =?utf-8?B?ZWxXUTc4UGN5NTlRSTRNRFRuMExwV29pOWhnd1pqRjJWa1FoYkp2T0ttVENC?=
 =?utf-8?B?M0NtSVdublVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEJhUmZOUzBnV0t1Kzl6VnV0N2JlOENLT2I0c0NZTVF6S2Y1V09SS3lnTkhM?=
 =?utf-8?B?UlV5QzZkUlhUaE11RFNNYVpROWw5QU80Yko1ZGdXQ080eU83M0V1b29aTTJz?=
 =?utf-8?B?cE1acGM3SXY4VmFBNnJ5Z1dOYm5qaHVxUGI5RmNPWE12Z2p0V2l6c05VL29i?=
 =?utf-8?B?QlpXN3ZRVVliOEd0bGw0bUZkNGw0WTE1ZGI1bUFqWWN2c3ZpWUkzSW54T0tH?=
 =?utf-8?B?QURDZ3BCSXhqN0RjZHF5Ync3RmJCRmNqTTZxZkc5V1JQeDZqbVFHd1YyRlls?=
 =?utf-8?B?UmFmMS82YmFEN09TaFB6VTVKcUJseEdTRmRkVkdWU0N1dFZOdFF3RmRiS3BH?=
 =?utf-8?B?dHBDa0NVclFhSi9nSCtYOWpOVkV3UnZ4bFFRQVlWS2h0WFQ0YzE1MDAwRDQw?=
 =?utf-8?B?cU5HYlI5d3hiNmRFdjlnUmFZcjFyUzhGcjBKRStSQStBTkE0Y216KzJibHNm?=
 =?utf-8?B?aVMxWjU2N2ZpejErcmtlS0VlL0lQS3A3cml0K01USUlaNDBCem45VDFKRVps?=
 =?utf-8?B?Q1Fkd1RZMmNtOStFQXAvdFhXYVlqZmJwcFAyTjlmVWI4Z0VhempvQ0JHS25h?=
 =?utf-8?B?VEdmQXFvWXM2VmRVb3FpbWJrejBCdDBhNW00ZnZhMG9vbjZkeFU4QTVMbWZM?=
 =?utf-8?B?WUxZdm9HTVhCay8vVFdwa2pzOXRraCtWN1FxcFVuQkdjcDZpOVEwR1diQjF2?=
 =?utf-8?B?Y0tlQ1lkVzA0ZnpjMFBGMXRMVkRIV3BmMDR2NlRxd0FBUXpBQWswTnRLenFP?=
 =?utf-8?B?ZGloa29Ua3VEajBvdjhBeVhrK1RJUDhKTFlMWjlwODNsVGcwVFN4bEVKLzlh?=
 =?utf-8?B?TlREby9CaitOSlJTWU5MQ01KWk5zOGsrRnVlbzFYbWl4ZWtJc0R4T1ZZUk9U?=
 =?utf-8?B?aHJtRUZ6WkM5TCs3angveGMra1FESHhZT2U5Q3NTcWJ5T1lIeXF5V0RHc3R5?=
 =?utf-8?B?Qm5jYjBjc2Y3T1dqaUVJa0lkVnROVXdGMGV0QTFkVTZpZ3V6cnJWVVNNWG9N?=
 =?utf-8?B?ci85dG5HTFUwNCs5QmNFaTQ3WE40eE4vVEdtWmsvMWFFOS9abTN4OXVMMzZD?=
 =?utf-8?B?Y1RBRnRUUFZXQ1FNa2dSc1BjQ1NmTXJwS3VmNTlmZUEvVWk1aUxZRGp0ZjNi?=
 =?utf-8?B?VDBYZlJydlNoK2NWZEZ0NTlhRi90Z3VLUW5CL2JITnRhalFpbzBGVVMwYzV0?=
 =?utf-8?B?K2RZbDRObWoycUlvNndWU2Z3TmdrN1N3d1EwZzJaOUdzcUpmWnVQZ2tEWGZ6?=
 =?utf-8?B?R1NmNGU3UlJtTGY1VmZsSklwM0hOLzRBSHRrQnc0QUwwdUI2WTJjb1lzeTRX?=
 =?utf-8?B?alRzalAyanhZcEV3cjdSK1JLWGp5em10TTNmcU1nNGEzQVpBWjJTam9RekZM?=
 =?utf-8?B?WHFQS05YN2VwYXdHdUI0dnpQSSthUGgzQnUycUFrdlNaWjVFSnNsa0N1Qy85?=
 =?utf-8?B?UVVCOStrQWtIeExkMzY2TjZLUXBVK21COUc0TUUvZGlUQWZINGo4VS9UVFVV?=
 =?utf-8?B?RXVCWFIwcmNLN1NpbnRyWWwxWGlNZ1FBUnVTeUxIY0ZPSjJ5Z3VlSW94NGla?=
 =?utf-8?B?NjVqRlhzK1JPTFZzQnREOGQrTkcyMmdua0p2eDFiY0VhUUFGcXBGUXpMS1pk?=
 =?utf-8?B?S3hEZG5DZHg5VGpvbmdsa3VTZ0I3TTZjc04vQVF0V2JKNGsyMlQ5WWI2RFFD?=
 =?utf-8?B?UVpDNWNaZ3RGTUVzOSs5NldiSTVnNUVTSlRXSlg4T0NaL24xMEpBZW1ONnJJ?=
 =?utf-8?B?YUFkMWNObGlpT3VRRlhiRFlyL0F4T3RiTXY3VEUxampBQmtYaW82REgrNTEw?=
 =?utf-8?B?cXB0UnhtNE1aRVJqTEhUSmNKTWFSRW5CWGx0R2h5UmpxNTdicDM1V2NKQXg2?=
 =?utf-8?B?M0Z5elgwWWdJSHJySVRRQVJjWTMzK09qNzd1dG5YbWF6TG0yZk44TjFKUFFY?=
 =?utf-8?B?THl4NXgwcjJpeDh3bzRrRDcxbExjeDhzaFUrN3pJNDNvblZvam1SUU1JOGh3?=
 =?utf-8?B?YmJkdmxXVXdVS3puR1hKdkE4b3dFaDVaVzhWcEVDZUczNU85T2ZmNHU3eFoz?=
 =?utf-8?B?QmVWWEErU3c3REk1R0VsdkRMZXp5UjdueWpxOGlweFJJUUxrWmxKNGpYYXlv?=
 =?utf-8?Q?y66ZwEDlyeFOxxg5LJLN5ZeJS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c31a097-355a-439d-6c13-08ddfc788a89
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:40.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aCjOudbsH9dHl+/8f9O4mIiVFn252RCOOr+hsZh63IYuOQgpUEDvwkROlF1muH/qGeLY5DHNTnaMSIUbZiKjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10070

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


