Return-Path: <linux-kernel+bounces-722835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A837AAFDF96
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED51E16F693
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD526B085;
	Wed,  9 Jul 2025 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b="WJLcPR0C"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022124.outbound.protection.outlook.com [52.101.126.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437D229B02;
	Wed,  9 Jul 2025 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752040183; cv=fail; b=SXN+o2zpcxpsrAc7lYnpe8GC5oAvDAzsKeoX6mZfD2TBUswpbBRA2/d3j+4cJhVbWdlA2PTZEobAOgIOApz+0GiHUFxUNbV+eZboEYEvAUPhIDjOpI1fdY5Wk9Ymo7E0/9h+4Kl3WfmUZifBkzsNdM5p41yv3VT6OI2Jdd/5Y1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752040183; c=relaxed/simple;
	bh=CrJRmf/Mx852ARjkGylqHkQ4NKjhcl3Pn5e9F1EluJk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WGBil9b16hQQhrCJdrcnxxraqLHoRsPIZSl30Xjx0tYgDR2kPInoJVxtsAuXBIXQVxRsl/9xNzA0RilLhkPLg4o6maqg2THfZ+XpZu1fH+GlU8n36XXianDfBs0UvOSQwi/1jlZU7Br9s20axv/AWFeXyJ4JdhLmBQxhn+e7C4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com; spf=pass smtp.mailfrom=technexion.com; dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b=WJLcPR0C; arc=fail smtp.client-ip=52.101.126.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technexion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYeDQhoK0Zl9NS2xknLWYQeco/WmCE926Pq/MrpSgeF/nJ2/8z5BYkTj77LsgQ1NHuv2kxVKNlzhixEMmpgmenWxQPLeRAodyz/qPCWR5Wtr9Kg749FnZhDuq86crJZcNrC1+AJgEQmKJCDYVvMxFWqtF2P7cC2OHj2e+QBR+WzFCIJswdhXA7gA3jt9Wl/QHmhuADPOyvhRrs3ITwhQRbWDX17gaWxMFhIctpi249H4FUW+wN889KCSPIofseiNi34fNDJHtaJJm0bXgBXXeWNHw0rgNWamqqQF71HTZcH8EwusMBSzkXCYK5dD/Jm2XI9SDlLIgGrV5VlxKnABQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e/OFVkQPSTMrmVxOUTsoLjkFxgmeHQnLR0Nat2U/5c=;
 b=kOJIMESQ9ufmH08gOpiCD2MdxNEY+MLyyRXKOGABLxq4+sQyop21pX0+0iy/3st11qtNghnhz6G/vCrNQTXVCLnLaLvEhopcH8rVJDTenDbH0kyx/jIzCDP93M9h13DjI2V1GqWaUnxluDZsLCIRJ+dFXAnbUOqnBXrIJ0YoFr02GhiD15ph1QdOfptV6ezQQiijzJ3orJBD2thoX9QFslNXOOcEdsMf696AERlGmOtEQi0bcIu7PI+6fmcZu7nqklmrKXUxTX191HjJfrxF8FMT+PSuyHRefJcz00eYT494rw3FTadoi+zkSu6NhfB1NitpW/MD8HfdkoMMODyiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technexion.com; dmarc=pass action=none
 header.from=technexion.com; dkim=pass header.d=technexion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technexion.onmicrosoft.com; s=selector2-technexion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e/OFVkQPSTMrmVxOUTsoLjkFxgmeHQnLR0Nat2U/5c=;
 b=WJLcPR0C5Mn4O1yvDf3hvIVvOHzPbceGxXbH7fh5/laU4qyxXkmehpaCV651ZEj5ETLf+jgHZr+gC1vv36CsmUGH7oEaH76tsxIY1NHgFoK8hbylMLZUdc1ogVuP+7pc8OFfp+0fntCFRhHO4zfe82kIIlaRx5WQEdGzUuqxJyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technexion.com;
Received: from KL1PR03MB7454.apcprd03.prod.outlook.com (2603:1096:820:ed::7)
 by JH0PR03MB7493.apcprd03.prod.outlook.com (2603:1096:990:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 05:49:36 +0000
Received: from KL1PR03MB7454.apcprd03.prod.outlook.com
 ([fe80::5ac3:4497:4694:db94]) by KL1PR03MB7454.apcprd03.prod.outlook.com
 ([fe80::5ac3:4497:4694:db94%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:49:36 +0000
From: Richard Hu <richard.hu@technexion.com>
Date: Wed, 09 Jul 2025 13:47:44 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: Add EDM-G-IMX8M-PLUS SOM and
 WB-EDM-G carrier board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-add-technexion-edm-g-imx8m-plus-som-v3-1-721d198ce20b@technexion.com>
References: <20250709-add-technexion-edm-g-imx8m-plus-som-v3-0-721d198ce20b@technexion.com>
In-Reply-To: <20250709-add-technexion-edm-g-imx8m-plus-som-v3-0-721d198ce20b@technexion.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752040173; l=1270;
 i=richard.hu@technexion.com; s=20250604; h=from:subject:message-id;
 bh=I4DH8XrezDOYWsPjNdFTXTbU/1yxQzjQNMCct5koVK4=;
 b=GyJXqHohdBoEVFysGtDLch7XCoFJNDJDAkl6ZOC0QSW3nM43WieVPNJUXGmxmoyliOnu6KYCB
 7Ku/VMG1giGBRv2CUiHMFubjyzHJmwOnxY8OdRk4QIBNDamLj+gT/xQ
X-Developer-Key: i=richard.hu@technexion.com; a=ed25519;
 pk=MKoW0/U0r4MjJdRNaq37Tb25KE1fzJUdMN0pa8XBJSA=
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To KL1PR03MB7454.apcprd03.prod.outlook.com (2603:1096:820:ed::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7454:EE_|JH0PR03MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: f472b8ac-578c-43da-cfb0-08ddbeac62cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVJJNnhCdzlUTlpUdmR4blRnWitJNTFhdjhaYmFxZHdaL0lkMlJZeTFldG01?=
 =?utf-8?B?aDZiODFiODFScVRaNStNYXNyNXk3RzZTdXFQZ2Q1dE5KRjU4SE13eDhBdzll?=
 =?utf-8?B?dEYydURFcjVhVWFJQ3RrN21YK3A3RUJNWUtiS2t3YlNhWng1NGtRSkRNT1dp?=
 =?utf-8?B?RXNRaUxBK1c4M0FoVnFLbW5HNTRsRkhPb0kxT296RnN1eXBTS1F0Yi9jRnNB?=
 =?utf-8?B?elpkcHJQTEVWTDFpWW9MOGV1Q1FHMldLMXFweVhqQ2swTDdUck5aOC92YzBD?=
 =?utf-8?B?NC9qRkcyLzkvbTl0R2ppM1pTd2xTTm9SWEN1aUpvVjVxaWdKTk9BNHc5MXZj?=
 =?utf-8?B?aXBNa0wyaVYxZ1Zqamc0YmRpM1JOT3FZU3VhYm9MUXBQakF0WVNTM2xiMEZ1?=
 =?utf-8?B?dzVmcXpCN3hrajBlYWl0aHRmYk1lSU5UZjkyTXJ3UmhYNnZJeklqRDlxWDRM?=
 =?utf-8?B?TGxEcHRJUU9ObWVUbGdaYXhaN1EzMSt0aXE4WFZFWG9wYkpCRUY1OURxOUZL?=
 =?utf-8?B?Z2RXV2lYTDU0SmM4dkMxQ1NZSXJQdDFjZmZpakNsWDZvMlpzUEhZSUZLdzRT?=
 =?utf-8?B?NzVFUVFrQ0NTQ25iSTNvRDV2QW9pVVRUbVRkaUZ0UHR0RlFaQjk0TVhlUjV6?=
 =?utf-8?B?UFVCZWhmU2JUd3ZjUmZOMEJodUlVQ3plTWZkZHR5cksvUGFyWkxDZzNpMXM4?=
 =?utf-8?B?VmNNbFlxNzRDRFBJdDRwQXIwM1hhZittZXowVW1wODUvdEQxSEZHaDJ3alQ5?=
 =?utf-8?B?cmFyNFJPOUJxZ0JQVzZVOGI4WjUrT1VYME9kOWdzUzI5L25uMjI1cno2aE5m?=
 =?utf-8?B?cUdBSmFSMDZJaFltbVFnbEtVc21GZjFLQTZucHVhRU5OWENrWjliKzVadnBE?=
 =?utf-8?B?TEJVOWlISHJaUW5rZHdLZk1hZWpRN0d1N1RCSGR2dTdtS0wwYnVZME40aU40?=
 =?utf-8?B?NUJINkhPWi9FMVBhV0lKdFFxVUJZRW43NitwU2dReFBvQ2J1dHBMaGtoOEg4?=
 =?utf-8?B?U1ZtMUNQYld0b0NuMURNZ2ZKdmtZOHFtOE9oZGhhSEdKQ2lZR3Vaclh4Zkli?=
 =?utf-8?B?cm9VMmRWWk1iTEhUdS9FNEtobkxxOStObDQ3L25HbCs0dnRwRjN4eTFJT0V5?=
 =?utf-8?B?WUpOaGZSK0xPcEZEOE5GdzU4WHB1Z3hRVUQ5V0pQclJKaFVRUGF4L2gySW5w?=
 =?utf-8?B?Sm91MjJ5NWRTcjBzUUQycm1Ed0w4YTBWTWhBaC85K0dBemVpRlJFaG1ReGx0?=
 =?utf-8?B?RmRlcTc3RzJWM1ErRmJFek9pYTJtMXVpT0pOUDZlLzVxR0Jla1lwQUZaTnp0?=
 =?utf-8?B?SWU0WVkzNWk4dWsvaDV4MDVhSGFWUld2MSthUCs2dVRxaGU0WW5pTTBXbkJr?=
 =?utf-8?B?WVBrUmswMGcwVllZK3ZNbGRjWVBjZ0JUU3JONnQvRDVCa3g3b1ZRcHBDd2tS?=
 =?utf-8?B?Zk1id3QxSzJZNWFwditFYnVQSFB6SUs2RjM2YWRWc1lrdVd6SzYycjZkNnZ3?=
 =?utf-8?B?S2c2Zk85M3lWYThOVjdrUEErVEw1ZmZJTHZ6Nm1iWmFCL1lNNHUwOUd6elh0?=
 =?utf-8?B?cWZXRDBTL3FXZURWR3AvcHNMWnJZa2UwTjY4cFY1VnN2cGN5TEhubFhaenRU?=
 =?utf-8?B?Q1B2dDExMWdYald3clFBbk0yT2kzNjFtTGZsTzMvejVUN3VmeXpOOVd6QXUy?=
 =?utf-8?B?cXZGY1p2dURPQ3NITlN2SEZhRXNWbTNWcHNwY0VWUlhpalVOMEUyNmw3SHNV?=
 =?utf-8?B?enVTYjdFYmJRMHAwdlphdUpHSDVEYS9DNm9CUlB1UUs3UTY1SFVFUVpLZUxH?=
 =?utf-8?B?MTJNdzJJTFBRa2s1YVdvVFB2c01IVmdVSDZZWENOQzBGdXlPaW9Ha3YwTEJi?=
 =?utf-8?B?YzIwSTB2alZ3UG5QdnRoREdoV29CWmlNQkJId290RVRVL1BENFdxUTYxdUdj?=
 =?utf-8?B?ZjRNSzJ6Sm1IR3QvUjJkc0swRG11RE1UcnF5M0tPVWlCNXFhQ284bU5wZmFQ?=
 =?utf-8?B?R04rVGkvUXZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7454.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVlQU1o5YkVxSlBBdUZLUDNRSEQzTWtOMUpWc0JZbEx1Y1RROXJwTG1sdEpp?=
 =?utf-8?B?WW56OVRhUnpveHNESlNjYSsyaGdTL3M5N3YxenYxd3NTT29DVytBWDRuRWs3?=
 =?utf-8?B?RE9WQW5YSjNtc3RPNlFRamJMUURmeG1PcUpQZys0YlBaYmR0R1A4OEhtRWN6?=
 =?utf-8?B?ZkdxZG56R3c1MDkrZ0toZTBOcjBHT3BwckZsUjQ3WnpFWlNhcHlWYWFmQ0FG?=
 =?utf-8?B?Z1NOTDluTUFYQlF4QWxrOTZyMVpMTWhhd3lvTnQxNnZ4a1FkVEtGOU1IZk1M?=
 =?utf-8?B?SkhMK09jWDhYMGVITnNiQVZjY0FKK1dDU1BDWXQ2ZWJ2eFRpWEthRlJhd3JB?=
 =?utf-8?B?ajQ2N1BURHRnS2RBTnpSait0S3NtVkJ5VHZDcFYxUENJN3JPeEZRRkpjelJa?=
 =?utf-8?B?ZXk5YmNBTkdEOWVKUGFXZXhGY29iT09KMGo1L3oyVHZsWVI5cVV0TGRSUk54?=
 =?utf-8?B?TlQ0M2w2SVpSVFJVSHFsQkwvSmxvdU0xVnJnb2M2MndCdjdSTXF4czVVR2dH?=
 =?utf-8?B?UEFEd2Z3U05uQzNXYjFtUGlBNDZ3T0FZTFlUSmE0MGlJMlRRajdPazM3TkZG?=
 =?utf-8?B?OHA4OFBaYWdsWEtjVUtpbWhzcktBS2g2U3BOWWFmcTZMRkV5UWJ6dnh5WnRG?=
 =?utf-8?B?a0dCOUhlOFdCM2VkR0tPcGR1ZVhScXlERTRvK0FERWMxRnNqeHJmYnpseC9D?=
 =?utf-8?B?TlAwcUx0dFZTV1RCUjFScHZpNjZ5TjRMSWw3OHBTQUtIdm1EUGZBRDBvVE1Q?=
 =?utf-8?B?OFJSeXU3MTJKdWJ0RW5YeEF1WmU2SWRXeVA5cXU3OXY1MXJvZTRJUVU3S0hk?=
 =?utf-8?B?WFZ1NEdtYm9CVDAzQTVuaWkwVTlBY094clRPWEtrZm40US95TzVMeFFWZHkr?=
 =?utf-8?B?YUh1YjlJVlo5azFCMlhreGhsdlJPeFp4NjJyMFNUMjVSS3FjSVVKUnljQm1X?=
 =?utf-8?B?a29NSHJJSFNUVE16Y2kyZFg3NFhhaW1PRVFsM2FvUkYzckV4ejZwenl2OHRB?=
 =?utf-8?B?VU5xNnNhaXhKL00rTnh2R3pGRmtSOFlkVjl1SVc0K0pSQUY5bDkxbVRWVmln?=
 =?utf-8?B?STRnYlFIelVqTzAyNWF4dU9oOThaZDQrR0Q2Y0h0NitBYWhyYWJsbGtyRTF1?=
 =?utf-8?B?cDBEMHJuaTlPeGxDakRNVW54SmlERjBUK3FXZFBUT0NldEJLUFNtVGNROGZk?=
 =?utf-8?B?TXMvbi9vdUxNNTNmYTArTjNTUHMyRE16SjdmQUN2U0pyZ000aE1kL0NIdlVN?=
 =?utf-8?B?TGlYRDdDam5sdjlkMmhXWjlRdkoydmJaKzJlKzlEcWFacnIxNlRwazZsd0xa?=
 =?utf-8?B?Zlc1cmxPTlAzWDYxUmJwMEhkNXZ1cTlLVkc4UFhLS0hIU2QvY3VmVzNPTklp?=
 =?utf-8?B?c1R0VXlvVHVLU0xqa1JVRHkwMCt4eWorM1c3SW40d2pGVHo2RDN0UVMxYXZa?=
 =?utf-8?B?UjNlb3lHdHpHOUJ3bVVDakFaa0FsNHVvME5TSjhVaUNxZmtvMW9ob1dtNUVy?=
 =?utf-8?B?dHp0Q1dLNlBZd3FDbVlXcTZHRE5CNDNlS1V2eXJiL1Y0OGlaajBpQWR6V2Y2?=
 =?utf-8?B?Q3YydVBCUFdrUHhjQWFxa2FyVG92c1A4MllxeVY0clloSzZYOHBiU29MWU5K?=
 =?utf-8?B?R0d4RFFZbG03Q1dyYmNxRk8xaCs2SU9zQUFLaU1VNUh6ekZxeStGQTErWU1M?=
 =?utf-8?B?VS9NQ3BRUjNBVURjMENidWF1b2NzZnpmVmtLS3FKT25LVlBnNjI0WVMrRm9w?=
 =?utf-8?B?TGVtUndCb3Fpa1k1ZGxmYjFFYXFZNTR3RzhxcW5KdXF0SWluSzBFM0ZPMmli?=
 =?utf-8?B?OHI2aFpPRmRreWdnSU0xUUl1WUlYM1FyYWV2aC91c09Qd3ZSSnIrUm1sb2lT?=
 =?utf-8?B?M1hkWkNTbWwwNnpSN2VWTXFMWWV6Q0Z3cytOZDhvU21uejR0K282Q0I1bDBT?=
 =?utf-8?B?eHlpUTE3L2ZqRkdSL1BrQVVselRXd3BsNDg5WTRkaHlZUTU1ODRPTG5CVnNu?=
 =?utf-8?B?WVdXTlN0cGFBYmtBTE9ZRk9tQXRVZW5rOXE0N1krMHMxVGloYmIyclR5M1du?=
 =?utf-8?B?ZjVzUkRKWGt2cUthdnlmWTFRSGJZRG9qOWthakNYVWlhektIcUNOL1JjSzc1?=
 =?utf-8?B?OHFNOU5uc2w5WllBM1MvVFU5bGlDT3g0WURkMXkyRDgrMHJmR1dyaEhwbVFG?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: technexion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f472b8ac-578c-43da-cfb0-08ddbeac62cd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7454.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 05:49:35.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ee19679-b9a6-4497-8ed2-1eda849e753b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZiZ9zjsjonaldwMPpHsivrs4yDikDP/hpBVtZcuQKo3A5g5hvZFEznxbUaiTTE4t+06RfSVyLLvMblBTWk+X7eGZcbXZML3kyG/4xP/Re0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7493

From: Ray Chang <ray.chang@technexion.com>

Add support for TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G carrier board.

Signed-off-by: Ray Chang <ray.chang@technexion.com>
Signed-off-by: Richard Hu <richard.hu@technexion.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d3b5e6923e41..a14f7f7dbe0e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1189,6 +1189,13 @@ properties:
           - const: polyhex,imx8mp-debix-som-a       # Polyhex Debix SOM A
           - const: fsl,imx8mp
 
+      - description: TechNexion EDM-G-IMX8M-PLUS SoM based boards
+        items:
+          - enum:
+              - technexion,edm-g-imx8mp-wb          # TechNexion EDM-G-IMX8MP SOM on WB-EDM-G
+          - const: technexion,edm-g-imx8mp          # TechNexion EDM-G-IMX8MP SOM
+          - const: fsl,imx8mp
+
       - description: Toradex Boards with SMARC iMX8M Plus Modules
         items:
           - const: toradex,smarc-imx8mp-dev # Toradex SMARC iMX8M Plus on Toradex SMARC Development Board

-- 
2.43.0


