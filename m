Return-Path: <linux-kernel+bounces-877049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655AAC1D123
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4293556133B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0870A35A937;
	Wed, 29 Oct 2025 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rwr/XZVU"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7C35A153;
	Wed, 29 Oct 2025 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767703; cv=fail; b=qpk7deyyK0LFqwRDfn47z8VfazO9VsmRupTMpO5EFPh3dqMP7pP0VqHsX87lHWLTTv3yHV9k8FVy528hb5QsRlkLSAjehR8AvJyVLcDjzFdo0Kvnr9G072ARX6AueAx0dMsKf8XpJBmkWY/6n5h2LrDNB5DfD7eP1T1f15Uge04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767703; c=relaxed/simple;
	bh=eieDjQHH3GKwbZsHK+BkWhGPRwKkW323KbvB3pSY+xY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uoD/cIPbIadE3ck2BugJIJWS0ZJtaYaWtZkcHn9rsewUL0aRQFbZnWfcKbf+2A8ajPPCEwpVyutaNiGObs1XvFrRz1Z7fTD4vmqtlIC4jnF98nPlruBe3p3rw9DbjKxDwF3uoluZiQzI244kgNlv58AtnBmPOeR6Ok3A5a2KlOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rwr/XZVU; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxxm9ZikUVbCaqqOb8sdDpCbnI2yzxl8Rjgz5UJd+yHMARNXohDkUUE6FMG48q+A94iIu5jkej3FfyX1l1pj4NY+SsLTYSPN/NuKBsWojIPHxVxVq3n9U140XDz3W5AHcjvEZiiii0pvniikLtpyEgqnszw0U+PsCHk7LwmAhQsUu5Y0x20tc5GpYC3VbTfGKZct7YY8PUI5sNkiCKpfpPZ9BBh+o3eTv54aFZZVwzroO6nKICLb0P1wXZWEgSd2eKkCi9vezbIt7Vws/X6knlPJoS4v1vAA8kZlQUwyS9poKxUZpMEiYbV0bj25Tw08497eiQIBMuceBvZiC98lDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFUah2ux+kVsSMHTlcacA7B6cZWzEjuqittrDckG+QI=;
 b=qCPg/TMztwVKAyZ7j3YOgXWmnh191nnhJf7dRCG2ajdExbWOVowVOdiuBFTnotHHw62JMDvvRL2YElPyc7mVhLK03fsOGZi2e8kGHxLJsmcR1CyuUP8qJvjqkbqz4IxfzlujTBJiNy9ZEc++zwDvBtPaY4RTJxgUwfveYijDIiGo7hoIqJI6gt4cgYU9IbYHXdOmgWaa8s4/Zf4Na6mCa1L+NgujKKrBGiU/LeH6wUf8N8+xJxRMFbaKPfVHrbult455EnEfAvgV99GJ3OdB3fm7h+PRPFbqjtIbwWxBUPH1dB5ZL9nF6u9t0eJiZYkHRNoQOYS86jfmAkT7BhQKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFUah2ux+kVsSMHTlcacA7B6cZWzEjuqittrDckG+QI=;
 b=Rwr/XZVUKNXresHBFv3Z19o5x7zt4SKgKMpMVyousW+eVqgfaPEV2q/5vkBmlHedhdddFAcxyu0Ma1aP15vkGVN+VBUyhqWViDeDrcRg8qgB8hh913QWEnuYzG+KkbtqucYRuOg4laSQFrjFfRIb7fLV1LdOED9nT9h1hHuo8E5Lv7982fVpj+eHJI/MGlxT7Z7s4z/Lt3+/+lMr8usb+UAteidqib3x4TpbojU9J0qE2nmXD+a4Tqe5OW4B/srH1Ugveh5XvN+iDjnf8eo3FSdd70HGgpiseE5PUq6FvEoXQmeF2l7h1QwgPD6airFpO7/Yb11gmqed8OzSHaHV1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11377.eurprd04.prod.outlook.com (2603:10a6:150:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:54:56 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:54:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:37 -0400
Subject: [PATCH 01/12] arm64: dts: imx8qxp: add MAC address in ocotp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-1-cf61b7e5fc78@nxp.com>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=771;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=eieDjQHH3GKwbZsHK+BkWhGPRwKkW323KbvB3pSY+xY=;
 b=4kZPJswbP2ghLmOKX8eJqEup8kv5zCM/cTjoRY9vBYuSNgeMSU4x0nQUmWqeV05FlOiaLXQv6
 9dN1dUVl6N0BuJk7X9XmZjaS1oVoqM12RKXMK8c6++qEZRwGtDMG1fp
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
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11377:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e371141-f13a-40c3-ed74-08de1725086c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWszK1EyWnJYU2lNWkx2ZkgvQXhwbDZXRFNnUUZEcGRWSE1sdTdVUlhzK2FZ?=
 =?utf-8?B?TitBVVZ3bWdrbXU1MS9NQ210OEprRSt1TkpzUm1WNkMvOUdVekV3TGl1cE1q?=
 =?utf-8?B?QlQyNThJZkdmK1hYWGJ3S1pubFJDZmhMTDNNQTRLU2J1R0h2cVFSM25jOXl6?=
 =?utf-8?B?cEIvT0F5T2JONEl3c29DRm9ESCtMN0JTMDZBU0NIOUV3ZkdiSmJrUnU0UzFy?=
 =?utf-8?B?elVOVGVUMmZyR2F6ZFBQM0YrN1FJVHdBalpBeWlsb25PNUhjZCszNGk4RTFn?=
 =?utf-8?B?ZlJjUkhHcWNSY3JNUGxHWkJsZ3FWMzIxZ3FvTXp0R28vd1pFZ1dRd3N3cjZZ?=
 =?utf-8?B?cmNwUzNFUVhQVmFXZUtJYUZhR1V5R3hKZlRuM3kxemRjUFkvT296RXNrSklv?=
 =?utf-8?B?S2hsTXY4ZFBXV1N2UDdKVDdDTmcwVkg3TGthUEtFWWJsYWQwYUxZcHllYytk?=
 =?utf-8?B?VkMzbXhrTHp4UFpxM3p3Mzk5M3QwZlZjSHkxdnRqWkpGRi83bXdhWjZPa3FL?=
 =?utf-8?B?TE9mbGd5WnlzSVFNbXNlNVhDdW9HY0ZZbVVpMmhDRVZKNFp6SmlQdlN5WHBn?=
 =?utf-8?B?NTlpNVIwNW9oUnFPZDFiaHViSkpINVFSR0FMQ0ZPN3Fab0d1ZzVWYS9GQXBj?=
 =?utf-8?B?dzNDSWpYYXAvcHFRMXVKaG1SWXovN2tFQThLczVlT0F2RUJOR1FBM2YzNUZt?=
 =?utf-8?B?eHN6RXh6K013TkI3QndYUmh1NWpETDFrVDlwRTA3ak9pNU5NRkZNbm5VbUVB?=
 =?utf-8?B?T3RhUElBL1Fna1JtZDc3WjhDVmdYd2xyNy8xWkdHRllhbzdGRnlyYlRaM2Rj?=
 =?utf-8?B?SjlJWGV3SSttNS9CdEN3aHIzV2FDTDdXT0JLWG5YOFRvcVpNWmlNTWVDaXZJ?=
 =?utf-8?B?RGtabHh3ZFVKamhEZDZFUlBSbkpXZkdqOTJrdHV3UDJkcEJ5emwydXArWE5H?=
 =?utf-8?B?aVBHN05jbzI5NW9ON2dMN1V6dVZjSE1oT1QzMzJqSm95WU5oR2NNVGpVYlRj?=
 =?utf-8?B?Ty8zTS9qUDNFT0N2YkRBZ2x5a1RtSzRIVnNEelllNm5vbXI5aUl4Z0JiVWtp?=
 =?utf-8?B?V2dhc3ZUTkxnMWw5NUJtcU4yeXZuK21IUkJBL3VoSWJZY0tQVUdiK2ozZ3JN?=
 =?utf-8?B?Z0NmM0pVZ09TNklyZ1c1c2pEaWc5MVdZcTVwMlRXVTJHdndwa242Y3N1Q3Na?=
 =?utf-8?B?aklaRFZpV1JZNFprQi85ZitSSWx1SFMrVVpOWDA2R0w1eXlKQkNNa0FRWW5I?=
 =?utf-8?B?WmMwT2UxMTl2OEQwRnFweGlRM1JyQ21BLzA3VHkzUU13OUZQSXZLSEU2Tysr?=
 =?utf-8?B?RjJ2cDVybEdQbzJjR2YzVGh3MDRMc3htNDdBNHlQSEkwQXRlNGVWL2wreHFs?=
 =?utf-8?B?Mk5nU2tReTA4U0QvejY1SWRINEJCTkd6a0Z0N2RZSW5LVXBLUDRBa093Z0sx?=
 =?utf-8?B?eG8rLzdJRHd0OEJ6dGNJKzF2SFRIMlVCaDE3MkZESCtRTDA1VnBsKzdCNXRC?=
 =?utf-8?B?cXNhaE5GNmkrcUYrQzVKUGVsTWZ3MC9OQkxLWisrV0Z1cXRrT2JOdEJTeXY2?=
 =?utf-8?B?bHRxSnBuU1NEa00xUk1aQTA3eWNOYXVqbEcybGptaG9YSFEvOFMwdGd1VzVM?=
 =?utf-8?B?VHVKanQ5YWw0WU5VQk51RDRETlprMkpXNjdReHdjU2xuVlkxTm5rdTlTNW5E?=
 =?utf-8?B?elE0R1ZNczhIeE5YT3lQODJJeEMyK0FHN21MOEJEL25xbElYMENjc1NLaW5k?=
 =?utf-8?B?WDZFUTVYODJSVGg1OHM5TnRzV0NnYmowRVB0TU9WVlVyUTl5MXUvVFhoWWY1?=
 =?utf-8?B?TjM3QTQ5QWdJbjNyY1FXd2xiL2JDaG9DbzNDc2pXQmhDOFdsZTJYUW9kT1Yy?=
 =?utf-8?B?Q0d4SldGMWpQUlptZGlTa28zYlFYeUIrTlFZQmlQTTdkTXp0Q1pKNmhPYU5Y?=
 =?utf-8?B?QlBqQ0dmZ1B2RDJIK2tSeGwzaUVBaTFwalNWVDNMMkRPNmtVMm9SQWQ2RnZ2?=
 =?utf-8?B?b2tVRnk1YjdzdUdhNUE0R2pMcmdBV0V5R0I2UGxTUmNRSnJlcndHZWlOUUgr?=
 =?utf-8?Q?BPUarS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0Q2bE4wcURLNFA3WDMwWTVjWC9UR2tmZGJNaEdiU3QwemczV2FkUjZrZmVh?=
 =?utf-8?B?VWhVUXo0L2dYeUl4MzVGWXZ2U3N2Tmt3dCtsQ2UwMGdMQ0tuck1DczhSM05H?=
 =?utf-8?B?RTAvVUovM2ZWN2g1Y0RMTmU4a2wrQnNabjZTZjZnb2JmUnJXYlRoczlsai9S?=
 =?utf-8?B?aVVwNHlxSHJOZ2VTQSs2ODNVTkk1QjZMQk5VQThOc1FTMHN1YS9oTEppYlNF?=
 =?utf-8?B?QU43QjVJOEUzVkpxSHhKTkQzQmhDb0tFU1dRTlcreEt0MTdhQit4M2pXb09M?=
 =?utf-8?B?ZWxlM1lXYlJKRm4yaXdVSFBZc2VEd2RwWHJpSUJ4bEJydUY3cW00NG5FKzVV?=
 =?utf-8?B?QVJvdndqbTJ0SHJ3QXZva3dtWG1acTcyR0dRay9DWFVrc293ZVVhMHMzQlhz?=
 =?utf-8?B?eS9CaUZZZlFpV01GTUptVVZzWUx3MkI3UVc2OGVpeDhsbFRXQVRBcjRVazVJ?=
 =?utf-8?B?bitoWVNEa0tRMi83dXZickpRVCtpalNjVVgxQkVjSWYzNDZhOURhbWdlOC83?=
 =?utf-8?B?cWNSUnBYWThMaXEwMFg0a1VwSjA3K2VBNXg1d3JmcU4yc2ZDeHZmMEZ4NlRE?=
 =?utf-8?B?TlZ2cXlpUXU3aUM0akVNWC91NjZpa1VNNEFFWXg1Z0pRcjE3QUkzTzN4NnA3?=
 =?utf-8?B?TU1KYjAwV1MwWFBBS1p2VVFzcno5WGd6aFB1czhzS0Z0bVhvSnI3WExpRGdh?=
 =?utf-8?B?UjVRSHhqQUtFWm9XNW4ydzN6NkRCTjdCY0kzU29oZmpzREhYaWpRVTZ4Tlgz?=
 =?utf-8?B?YmVhREZDZ2xmdHZLS1Q2bGRaL3R6WlFOL3V5VVFNUUpDMFZkY0JyK0ljRUtt?=
 =?utf-8?B?SERSZmZDQ0E0NEpDTys3YjhhZnNyUHZoczh5MVB4RG0xWW9kZWZieVZKcEds?=
 =?utf-8?B?aDZZZERrN1VmZkg1MGprNWt3U0cvekowWlVMVkwwSXdnenVmeTJHcTdXQmdN?=
 =?utf-8?B?VGYwbTVXaGZWbUh2SGZiRnY1MUIwYy9GVlhER3dZRzJxQ2VjTXN0ZW9qVW1V?=
 =?utf-8?B?alN2MHVFdmh3SExTVnYxTER2MEJRcS9zbzZERnR3eGN4Vnp2emx4TFBZaTdS?=
 =?utf-8?B?QjZmVXRwTUEweFlIZ213Y1Q5Y1k4bC9jUFRSMVVJNFBuaklsYkZ2TUJMbkcw?=
 =?utf-8?B?ekg3T20wZUdBNmF4SEtXeEE4VlZJczlEMDU3dWk3enUvUzl0bW12VFQ5Tk9l?=
 =?utf-8?B?ZTdWcWlwQ0JQdVlMS2w5VnJYWlBqTHk3R1BscXh3QXdldGtseG82dzFMN2hL?=
 =?utf-8?B?ci9MQTRQTk0vNGN2REVpLzJnSzE3OG4wMFh2SGtBZXRwSzJidFU5UnN4dll3?=
 =?utf-8?B?eGswOG85L3BSNmJyWTl2MHFpZ3dabFJwYTFSZWhPMkJwcHlUb0pDSllKdFl1?=
 =?utf-8?B?Mm8zREpEdTRIZjdVbVNSNlFES1lSTWpYS0RNbDhTazMrVDNlNFpkb1k3aldn?=
 =?utf-8?B?WEQvY0M4WDNFRmVHU25VWjhCTlc3S1JDWWRRM0xUVFpyOU5QTWdBNEt0TCtJ?=
 =?utf-8?B?RVdaanEyb1g1VklnYzRVY05UN1p0VytmNUtPWC9aREo2R3c2STFabHhjQnlh?=
 =?utf-8?B?R1Rjd2loKzdwaitGd0Q2ei9xTGVybjdmR1IxQWRVRng3QmNXVWk2cWhUL1Fl?=
 =?utf-8?B?b1pySStTUGZwdFFjQy9wK3FlS1IzQU9KV2xWdXV3d3MrWDN2dmFkelNDTldv?=
 =?utf-8?B?QUVpZ2dFSTRKcW95N2hseGpIUFhCTE1ZVlYrdTBHZFVtSnhLQmh6QXMzSjhD?=
 =?utf-8?B?SlBHOFZ6U3FhYmc5amFiQ3RRNUk5cW0yUWgzYXYvNys2TDlaWDQ1MWEvSm12?=
 =?utf-8?B?cTUxZVhuMGliSFFCTkNnOWQvMHR1QUxmdk02c3BKa2hBU1NwampoSHE1WmxG?=
 =?utf-8?B?L2YweHROOVdvdHFpNUNKOFNKU1F0TXREU2ZrcVJqNElWZUlUQ0VDcUtLUk5O?=
 =?utf-8?B?a0RCcU9wd3B0ZGZMcmtWU1NsUWdGZFZsd2s4cEdwamEyZlI1V2dlMEh3UWY4?=
 =?utf-8?B?bm9hOUREUTNXMHFIYU52VERxZlphZENmcklyN1RFdzRGQjZCUFJwTjVlZEkx?=
 =?utf-8?B?UGFQLzI2QXZJZTg0RTlKQVVXNU4wTW9KRGx3eEJWMW8xNDJFMHNJRE8wWXNY?=
 =?utf-8?Q?UEofulzqrGfAqJSLubDLTbOoJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e371141-f13a-40c3-ed74-08de1725086c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:54:56.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b16izRr99jU4/2jJligZXQo3xJwmPG8gg4ejKiw9GPxkOFK1zSzaUGVjqUT2IdZbTOOKc4dZII0kyzuyC4RQvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11377

Add MAC address nodes in ocotp.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 95edab058276bcfc87b9bd85426b999d1ab32360..def6de8d579d40919e4bf7f88e119611ae4cb69a 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -234,6 +234,14 @@ ocotp: ocotp {
 			compatible = "fsl,imx8qxp-scu-ocotp";
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			fec_mac0: mac@2c4 {
+				reg = <0x2c4 6>;
+			};
+
+			fec_mac1: mac@2c6 {
+				reg = <0x2c6 6>;
+			};
 		};
 
 		scu_key: keys {

-- 
2.34.1


