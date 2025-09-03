Return-Path: <linux-kernel+bounces-799385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D33B42AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721AF582BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60E136935A;
	Wed,  3 Sep 2025 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lrsQ/w3z"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E337426F;
	Wed,  3 Sep 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930855; cv=fail; b=ulxisWMePBCRmGM8YPZO11qa7c4cf32yeTHFzSzsrSOaJqwQA/anz2vm7NbIT9eud3qdHVNviG3Cwf4muBZoY7RVyTuiitVjjOJCNRMxJd6i4O3n22J4I4eNjI1+SwWzrJXJnoD9OD9OvctZoj83s0RukkKmvTOAQsghFFkqKyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930855; c=relaxed/simple;
	bh=zhojdG2N8zF71tQqHZPxamhl+5m5/SdswMsqcVWwOkQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nh3WNqZ9t2vBoYHEvBcLFCy+YYSIBnuLIgoCWKej/qf/cV9f7GLrjLlipQJcYBcJheH2rOSRdgYdKISYmgq/NRZmHZfLNd/Qp7U0oukCnlO4RY8Ar8iQwtCTsVq2ZfqOeChxw75cFuRiPH4Onf5BTqKdmRjsRST67xn4ZvJovtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lrsQ/w3z; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsQ/dsoNnkIAHgY19ljkvG7jsNVkIETmnTuooF1wwotbbmFBvHuDlOFjwE9tXXLh3XLNR4Pl85ZoNdGN08l+z2Mlb0pi6s5BEU/iZdLSQXo/3w6y/F/DKaHhSt8qnUzqJ8iFArJjfUNHPPwhwQGkCdAwvUI9lKsHPJD/wA096U5oPSBLwMte0gaxkcJGkOzOzftv50yKX6LJ9OCdCZcmdVauiGqkg79VRIIEnwEidSBaemy1xM6h3YUpn7FMjOm5IDMTtp4lQnIFVNNXDfrhcXQkO3fssgbH/Fx3RwTUTL5TXfNjdruY944omHLovrtH0wju1dFo73Ffp4hHVsUiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcEw6Jp0AA3cE304a8Mp+CntP9nFzF85ffWaOzlPwuE=;
 b=S5mQ/koNJl9Qmy1mAuCOBXRZp3wUZbjcFhHzqX0L5hBA3aVijJtMNdnlXoNGJnsPYb+3BrKJftbk+iKIbAM3/8FI4P/2oD445wRhWVsjIdHqsJkpouf5f9/anWVa7eeqI4hb3GqBZNxnsXYujhyhll+PjPaVTVfzZGrAgU4TEfxFuusukaqv9+eK16xbTeF2aIf3tXIeVKM8WvSZzEju+ogafR0Hiyw6OmMiIa/C1iDBPKotLDaqz6KNfXwOc0lWEMAuPiJVZiekWVu4GDQNonz9Ljcze+jJLMXoZpjfgxSc7gLkDAj4byOiU4KikKYBrKadlWgKO8Mn7ApvT9gLZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcEw6Jp0AA3cE304a8Mp+CntP9nFzF85ffWaOzlPwuE=;
 b=lrsQ/w3z+etyE3TgGkPT/UuoIB7WUoHM3ckiOG2nmYXrNHU7FmV5xp3pIj2FVL4Y9asPoAnaNwOme1LqzaU662RgYW2tUlFIWk6TJWpuvaPrT9n7QBiCK7bk9LLDkH+Pxe6m1JNRhxzXHlPohhAAaXz9XPGzPVFhN2l7m3qjPLE88/fagQyGd+hGBdi0SZRTFyuT8CsnSm0xmJM8rTBYRbPHpZVsNMo6g8XTm1QFnZ26u7a+EOI3qy6NM51PZJn63uA1fwB8j5d9hYs0zfH7fvbrc0RowdnjzivawluM0gZtCBAT3CSe7pD59YbRWILvaS+SDr64xkxrd8uTFWo8pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:49 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:20:09 -0400
Subject: [PATCH 16/16] ARM: dts: imx6: change rtc compatible string to
 st,m41t00 from m41t00
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-16-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=871;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zhojdG2N8zF71tQqHZPxamhl+5m5/SdswMsqcVWwOkQ=;
 b=9ngSL95ehf3qKLKdtI1T5d0bLstjaY0GF011rZ4IC/dN/Pol1SnwDVZtUWTAsQ7xBZT5/D+0a
 XrUvuoEoRaECNfD78NEZoIJ0X8b7XIXuYmS6VsHzpo7xuHNhnJgwu7/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 6822a27b-ae17-4aa7-387e-08ddeb275f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlErT1FWd1ZnUUgvNFIvaXNhL0hHRnEyakZ1SWZBTWZGSjVxdm0xRGppVWdT?=
 =?utf-8?B?R3dIdzB3UEFuSjYrVi9HeVlRdnQwZHhTMnk2dEUvc2tCdzllanpmdHB4WEIv?=
 =?utf-8?B?MmpoeXpRN2xyT3YvVjd2V3MxUFVTTWxZYm00ZHhZVFUxQlozUmcxSFpOYUFJ?=
 =?utf-8?B?NjgyTkpoT3NPelV0L2xvQXFTMHNiVDdwN3JIYyswdnF4Z0NkVldDM0JZRm5y?=
 =?utf-8?B?OXpLOURsTmRMc0ZnOTFNZ2c0NG5xdmpvT3puZHBVeHJUaUI3bkhEem9hUGYy?=
 =?utf-8?B?a0VldlpBRjliaWMrWTUxdVBLb0lnRlVXKzAwNldUai93U3VmaWJ6WE1xQzdp?=
 =?utf-8?B?Zy9sYm5rOTdock9XeVN0d1dBNG1kRnptNko5OFFxNmFBYXV0V1h3WFU2MU9T?=
 =?utf-8?B?SnRnZlg2UW1QbXoweDc1YWo2bEt1OUhmT1hBa1ZOblRacDZwejAxS2hpOW1v?=
 =?utf-8?B?b2krNlFGV3RkaHFjK21WVUQvMjJvTGNHYjM2SVVxcUs0N0RwWjVZRklMWVhS?=
 =?utf-8?B?cTNkZkRFTmpIQUFYNVpjRjFVaWtlYlVvKzBxeHVFVnRlWTB2VmtBcmpXY3VO?=
 =?utf-8?B?VjNDa2V6bnRyUHlQREhrL2ZIQUtOR2g2RFIvbHNvSmMyb0dXMnNJczJwakJF?=
 =?utf-8?B?T01nTnEwRjVyMXQzODl5U2tmOHVaSXBDZEZ4M1Z5Skw4d1BuN3VNV2RRUVd5?=
 =?utf-8?B?SUlUL3BYL2tzSWFIZWp5N2lwSUFwdnNzZWI1WitiOGE2dzlHR3ZtSlJjV0sy?=
 =?utf-8?B?UVg4K0Z5aE01N2V4QVRrTmdIYlhXWGRoM1l2UmZXL1k1VnhiM2ZhRHg4VjRM?=
 =?utf-8?B?amhhYThMNGh5eWpBUEorM2x3MVpRTi9rdUwvdHFEUzdWTGpTbXJZbGZBRlM0?=
 =?utf-8?B?ckVNV2pnTUFpMXNPRTZXSk1zcW1yOE1rbytIeitOVFliN2lhTkU3NFdUZFc2?=
 =?utf-8?B?VjhKZm9BTWw1cFdPd2xROVdhTW4reDM1cDVycUJMWC9KMmNWYTFneGVrQ0ZQ?=
 =?utf-8?B?cUN3NlFGL1V2eXVqY2NDeG1RZTRsenFPcGgvNlBvV1hEZXRVWDhuQjE5aWNT?=
 =?utf-8?B?SW5JQU1UUUtrOTZpRnA2ZFczZzF4YjQyNElGdlc0UUdnOTJBdmo0ek5NZWxi?=
 =?utf-8?B?VEFIVE5yWjJHbDJvSTdtQi9kT2puN1BKR1VIUm5Uek5vTHUwR0J6YVRvdUJv?=
 =?utf-8?B?aFZqM0FLZjVrd25NejBlWk5XVzhPWk1QK3I0aE4yTDAvZEVqdTgxaHZVQW5w?=
 =?utf-8?B?WnB6aW9LS05TK0xYa3ozY0Rab2JhcWdyRVYxZXlXdXdzOFpmMnp3U0J3ZlBr?=
 =?utf-8?B?M2ZvZ2pxVml4WHNkWVZNcE9TWTZhNitjb2QzdWxlcExmVXIvM3J5enJlcFFt?=
 =?utf-8?B?ZzFRQWY3RFA0YUxXcGJzK1Y1SVA5RnBLcXpZVDJGbi9YbnplSitqcU9kM3FC?=
 =?utf-8?B?cE1KaVVvRHVrU0JQUW9LTGlZYjRseWdNSFhMTWNmeGw4NWZHUG1HT0JoS1p2?=
 =?utf-8?B?ZlMyYnhpSWxsWDlFNzZOWDdCMWp6NWo2UDFadm03WGJ4aVUyVWF2aXBkemkz?=
 =?utf-8?B?aXlQVHBURm1GRXN0cU1lejQwc3BXNnpnOWhDbGdjelpnQmwvWnlYbzlreC9q?=
 =?utf-8?B?c2xJdUovYzllRXF1dEVReW1NZXk0ZW1NbXRBVDN3YXBMUU01MG01RVZ6c2F6?=
 =?utf-8?B?VEF1VkJOOVZOZTkrWlRjQ3dnc1pnU3M2Q1cwYUpDbS9qODU5SGNDSE5JRDFy?=
 =?utf-8?B?VWozVHI4TVYza0hNZGs5bzhJeE9DM1pzb0ZncW80ZUo4cGozbkdoODFlaUdI?=
 =?utf-8?B?bFhmN0p1TEkyVEhmaFU5OEpBOGN4QS95N0JLK083RDhxcG1OZE5BdUJ3QVF0?=
 =?utf-8?B?aUFGUkVNWG1XYko4Z05QTW4rUU5CbGVpcWczOTR2MnBRc1pndVlpWk9TVm5X?=
 =?utf-8?B?K2RVYmlMMTM0bDJVRTkwU05LbktrbElEc1VZOHJ2bVFNRHEvZ2c4QTlmSHU2?=
 =?utf-8?B?TjU0OHhLY2Z3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWFzTm52bzBsUFMySTlaaEFvY3IwVE9zdnR6eGllaGxubWJVbjg0bTZlR1Vu?=
 =?utf-8?B?ZjNDMnRHTzNiNlpUK29ZNWJQOWFkbzVaUXJqQ3RRY1YyaU5rbVdjUk5UaGx0?=
 =?utf-8?B?TG1DRXNkVFo4WG5Yb1p3WEpBN1Rvd2ZjQjBHYlYvTkZOY1I0MmJINXVnMUIx?=
 =?utf-8?B?ZldJUjBRZTZUQlFVN2Yrc001aHdsVHQzWjNnMDh6UW9OMjlYSkJiNVptLzJ3?=
 =?utf-8?B?bHhFaHVhQU00eTRiTjMwWWtzYkUxaHdxdStBc0FESzBvV0M4L2I3dGZxZGdO?=
 =?utf-8?B?cHZVRmd2KytYVjk2MkVuT1B2N0VId2pwVjZjRjlKM3ZEYW9nUTRSRk1XL0VL?=
 =?utf-8?B?SU5Ka0hwU21TcVZyd0ZzS1JtemN6KytIM2tldGs3VU9jQ005QnJ2RnhwZ0pY?=
 =?utf-8?B?cjEyMTdpVC80d3J0QU9MNXlLMHRVc3FCaXBteDVPUlovaDFnZGRwL2duelFk?=
 =?utf-8?B?alEwcFFRZE8vZzhUUXR2c2o2dUJxOFJhc3pxK2tEVVd3NzhtMEQzMG0rS1gv?=
 =?utf-8?B?d2NnODdoMEFqSG01MHZOUE0xaTdOSFI3dHpZaXRnWURUcFhDRGhBT1VyTGRx?=
 =?utf-8?B?RG5ZL3R2SERxQStHcEE5RHZnWldITlZpeG81ZXQzeU53SjlqT2xsTFVlWkdT?=
 =?utf-8?B?RkF4V0dFcnFtcXdJRDNWRWVRUHI4dUU4M2pPcCttVGhuTk9CbWhQdGFOU0RC?=
 =?utf-8?B?bTFXZnBRZEFSSmc2RmkyOXp0ME9hZSt2aWM0bDRwRk8yTmVVQ1VzNWx4NFFo?=
 =?utf-8?B?TjBEaWJPUjc1U08xdjlaaklmNHgzMUZsUm9CUVJobmxxSDM5WlZ2Mk9JcDNr?=
 =?utf-8?B?MTBKZWxYdnlTMG9iMzBtZTlrZTVkZGpqamJZUG9ab3BIdC95RjFidmVkeDhs?=
 =?utf-8?B?K3JMcFBEb0hoRThUc2s4MVJObXE4NllkZWhlbkhqL2hJQ2tuMXVpcWxGSmtF?=
 =?utf-8?B?V1Vacis5RlhnSmRhM2Z3NlpCUGJHS0pOR0VvV0NobktrRDdYZ1YzamVsSnIy?=
 =?utf-8?B?eEEvVTRSN3JZSWQxRWIwcWgrL21rRE1kQ09pdzJMNFVKVU5GTStyWk0wMytt?=
 =?utf-8?B?a3ViZjd5NlRCYmRQL0pNQVRaOUViZUNkN2NISWVBQ2tpWHVka0ZkV21aTUJz?=
 =?utf-8?B?R2VKTVlsVmNiNUdoU0J3Snl4YXYzd3J4dUpyanJsdXdTeXpZZ3ViQmRueDVO?=
 =?utf-8?B?QXh2WFhGUXAvM01RUWhzQjczeUIxRWtsLzRsSUsyS3RvcHJndUNkUFQ3Sk5W?=
 =?utf-8?B?Tk5IcFhRL3oxcGJVWDFoU2tWLzJUUmx3WDhiVUs1OVZkdFhtVmNFdE10em1J?=
 =?utf-8?B?bzNyczNrUDZrMHpzVHZjNEl2SG9hVW16aDgrTnJpWlhmNTlidW5sNDZRcXUv?=
 =?utf-8?B?TG1MOTdReFJlRmFIL29ONmliTjBmbGJjQi9ROFBNTWFDZUFqaHlZcVNKdlFG?=
 =?utf-8?B?Rm1iVE9vSHlNVVJjVTlhVWxxYXFMWkJVaXV6NkVQRmVCQmxnaktmMWdVcXRh?=
 =?utf-8?B?QU5HSUZtWWMyVmR5ci9EWHVQNHZGbjNNQTB2elRBcTlzdzhxZFBvSW9LcTIz?=
 =?utf-8?B?eC9lYTh3MVJsdnVmdlc1eHR3cW1MZDVvcGdaTzJJOVR3azhnazc4Q3lkcklq?=
 =?utf-8?B?eE14QXgvZVBFdEdiS3hGK0p2Qkl4M2psUkxjRWl3SG1PZEJMdUkvcDFRMUNt?=
 =?utf-8?B?SVdqK3l0NTRId2tvTmhoK05pV3c2UTNYVi9oZDBzRDdka0orRHFDdTdGb2dO?=
 =?utf-8?B?dUpLdHMwczdFdUNsckIxNk91Z2JGS3dDL0gyVVhGMllxWDNpUVU2cm84NE1z?=
 =?utf-8?B?ekNGWG90cU9DTHZUV1VTWHZaZUFHelpHTFF0MUZaTVUwcmZoTlpsM3h1d3pX?=
 =?utf-8?B?SC9QU24yWWdsd29Zb1phN0RDVW1YUEdhWnRzSzNlNVR2U1ErTFJycSsxVTds?=
 =?utf-8?B?aWtSVnhmUG4rWXc1Mit1S2Y5eHp2M0dWQ2prZm1iQ3ZId2JRU3BvREpzaHRG?=
 =?utf-8?B?Y0VEYmcycisvMTF0NmtqRkdRTHhtSGt2TDZqcWpOdWoxajRBL3JtTndKYlhy?=
 =?utf-8?B?ZzR2SEFianJBVmJxb2I1MkxNMVZERGlyTEs4SWlXVmpZRG9mQnFCL0hqZjl2?=
 =?utf-8?Q?Qt17W4UErIYyZzdtnwUjO7V17?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6822a27b-ae17-4aa7-387e-08ddeb275f49
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:49.3394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAjYCWJBAde2yjJ/ows94l1yoa99uw7/vVDZsqLdnlY0VIsJV6BeNseG83aUPC4AAb7RAXZofS9u6g8rPXREBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890

m41t00 compatible is not existing. Change it to st,m41t00 to fix below
CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6dl-ts7970.dtb: /soc/bus@2100000/i2c@21a0000/rtc@68: failed to match any schema with compatible: ['m41t00']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi
index 2e8573dac39e86f408a45da3c013e67e96c02fc9..17f6a568f0e8cfc8e71aeafb34eaee12d67a29aa 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi
@@ -213,7 +213,7 @@ &i2c1 {
 	status = "okay";
 
 	m41t00s: rtc@68 {
-		compatible = "m41t00";
+		compatible = "st,m41t00";
 		reg = <0x68>;
 	};
 

-- 
2.34.1


