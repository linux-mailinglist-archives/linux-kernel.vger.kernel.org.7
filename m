Return-Path: <linux-kernel+bounces-846231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F7BC752B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E03819E0E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7123D7C0;
	Thu,  9 Oct 2025 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O5Kl7/Rm"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4586323;
	Thu,  9 Oct 2025 03:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759981740; cv=fail; b=BVqagV+iiaEgKlsxvQZxzl9A8AdygAwLD4PWe8BtI8+N3X0o0i7DPVkjxfYXH4MWXsakRHorkMRC43xf39FDSPIMCmHMcKngMxv7XI6G3quGEedJo4EPmfuMV9IrB3fmRdBmAKM9hOvxSLFXnsO4yXDudLUMvs2pSWel9CPAmd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759981740; c=relaxed/simple;
	bh=AsqkTNTp73C1/4WrJFAiebOwtUCnyb2WWJQjvFHhlRM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TMyLUlFENTxN6Wk4Q3NzmOpC21mT+u2PtElxrfXpLy7g+zyA/k3hh0deDBfQZlQn+SJ6bWIBUAsPORKcJifAZ5WGigP3dr0P0eVmDKX8CYBMUDCIAjYFFwZeCKLfeBMBlKxFxxe7byaDDi8NsZpfPgfpSkNO4+kgmeqtPDv+CBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O5Kl7/Rm; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EClWr9A8A2JYdkq6uonFMpAWlpv52rfbLFoXzbOpaXGqZLlWnfBWiQxegg+Ok0h/EAI2U3ahVMK2yVQsALBC2fmU/6IVxkGrBVWFh5WJE5+XD8ch+UOiFWqtdMNmBSTBvEOmaK3BXpSNtdj1PTwCY++KO+SpapTmdbXWGE6Kb1ONp9e9cCbqf8qU8J9xjMwBkCqEAlayK8IndXTR+XlyL8BfHfdtVbisCDRS88+Yf0DMQaFz/WtWCsYz8JXYdfjm9xR1sdNRqWOa47QrdQnOP75x14wBj9FtiWOuygtnJR2Dnt13JJHoBy2CPLvfHgL3vrcfgmu05NI5ZAfv8lYIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loyQpg5t2Iqq1GHdLoQgHW7TKPsExAYriN5txzChjY4=;
 b=r1j42mtZR5lEh8XJtZoZlWF/1E06/aNJ9WoGxM3Cuq2zzmRSHcvqNhR/SpgXy9RoTlgUkCzfqbFpe6hA74b0/inAkwsdLMdmf9dEzABcG+dBRAKECsolGww8nGm7S+fON2WE5zNwLpk+F58vJIztmGDXr+hXajdV6ecuR5U9t3JGJJl26ZVLsypF8N6pJjbiAQEVKKt2i87jPVhtLSBZklqECrfD1GtDiJ/A/H0e4CuPDnuGvK9Kd7aVpexfcQOS7ympCPnodiZevO5tS9ruvhHJDNx6DOgtRhZY/uzBsedEvr47SUOlaFqbobl1lFIjK1imXPqdRo4yo0XyNTl3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loyQpg5t2Iqq1GHdLoQgHW7TKPsExAYriN5txzChjY4=;
 b=O5Kl7/RmomLf8pPqG9QCkL/mTLoVooJ92rgH/E8EDYkVLK0ED6QMCg6AXQSb94XhKAOSo2d/oy3slLy8rDI+QyvCGbDf3OxuA11QDWrVI4rjpn8L7n6FejVbMqHOSvGbkZbR1qUifEEOFODhvqtHZZ8DEU5R/bGh0KSnGL9WHuCKplbrKQmx0BFKCv3WxZlLLjb02CBuDCiqXJswvwbXQ9UCl1z3S1pq5OcB/7y6Onf82CcwpalaFd5YgmK1+0DLPjQrHo81/MtNKmeLentcsfRQqrHdZlrjVp0Y5ZiK9fLen8NwfU+mCz/RJN+1BK1yzeJhQs1Cp+y2hU0U18PEWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:48:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 03:48:50 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 09 Oct 2025 11:48:17 +0800
Subject: [PATCH v5 4/6] clk: Add KUnit tests for assigned-clock-sscs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-clk-ssc-v5-1-v5-4-d6447d76171e@nxp.com>
References: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
In-Reply-To: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Sebin Francis <sebin.francis@ti.com>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759981702; l=22518;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=AsqkTNTp73C1/4WrJFAiebOwtUCnyb2WWJQjvFHhlRM=;
 b=njXh3Hm7uesGrXF0z6ojALY1zn7vfdyqq5hhd6lXHZOFDYC5DAHb9r5QgZP6n8V9DrqC72Ogw
 mcUOuwi0r1fCG8U8lHOaaLBw0Ro3Lonah9JW/fX4j2UqAhnc6wN5l34
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: f85b0b6c-38d2-4140-8389-08de06e6c243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3pIOVBqbHJqMFF2NnpNT0VKZ2dxRTZZeXRpTXU2YlRhTEdLVmdROFUyYlJu?=
 =?utf-8?B?SW14NExJUWpiNVNJSXMzbVBYejhoemt5UFQ1U1FObVppUkV2TWJ4UHJuUnZo?=
 =?utf-8?B?bnRURnNKOHRlQUVqdW1nWVFYcFlLZDc1TVJmVllEdWU4cVZSanlFK2FKenBj?=
 =?utf-8?B?ZExaeWtNcVpRTkxvc3N2ZGtNS21uTmVFdjk3TE9Zdk5mdVJmdTZnTDdXVnNU?=
 =?utf-8?B?bEQ4RS96UkxKYXRHdG82MlpBUExmTzB3Wk91dHdBdTBScVBsRS8xbnpRVGEz?=
 =?utf-8?B?ZDYyalN0SzQ0Y3E4MXcxWFIvSFltWTE2WVNiYUhGRytXSDgwYTYyV0hUWFdF?=
 =?utf-8?B?Mnhuc3VmYmphQ05FRXJISUhmK2FIeSs1bkVQYWJpaG1VblVaZGZuWE5XMEg3?=
 =?utf-8?B?UmRaL0JtZUhzU0dib1ZadjNPM0o3eFkxbUZjeE9XY051TmhXdnZnc0ZSbEY0?=
 =?utf-8?B?LzRBbGVFWkpzcjA2QnNwVGo4T1lwSDk4WWhsU1AxYXFCYTIybjErZDVycnhM?=
 =?utf-8?B?SWRSQzVVajJyY1lVVHRONjN5SmcvVTRBcDNYeWZGNmJPeFNIa3NHQ1FuOE9H?=
 =?utf-8?B?WFYwMGp4UEk0ekhDcjRRVmF2WkF1WjFKY2ZXTlN0MUNlVXRFVEZPVEY4Qmk1?=
 =?utf-8?B?TVkrTkNmdmh3OXB3NUZ1aFJEb1lacHlSbUo0cDRUTkozUkxuM051RGZhTUlh?=
 =?utf-8?B?R2YyODlpRXZ1djFtanVhNHVNdnhPNmFZTDlieUpRUHlmUmVlR1pBdzlPWmxM?=
 =?utf-8?B?eGtpbDBWVVpIV25mRUd3ME44Sk14UFNzT2ZDekxaYk95cWVFRmNmdHl1L0xr?=
 =?utf-8?B?SnBEeEpDKzZwUmV2Sm1ZamxMOWtqOWtOUWZyVjd5VmRxS1dTTi9obWtMT2Mv?=
 =?utf-8?B?d3lUU1RpanZUM2lERVRtblVlaDY5OWRFeUJYT0FDTDhPQVZvZDBZMUxFTTFU?=
 =?utf-8?B?SXhHbExTdnRpZGI4Z2doNkRxeUxBSU4xVW42Mm9ZNzRNTXA4cXV6S3YzbFZE?=
 =?utf-8?B?QWdoUTRlZDh5aTFjeXZvK09saTdnOHArQlNSaE9rNkVFQXp1TlIzNHQ3d3lE?=
 =?utf-8?B?WWVSNVd3N2JQcEhEb3BmL2JFaFhUaXYxQXlDZzN5cW5weVJITFZJTnlKTXNp?=
 =?utf-8?B?OUh6NzRuejRuYWo2Q251eWs3T2xDdkNrcjJyNlozRXQ0cE1GQkx0NTRhWHpD?=
 =?utf-8?B?Q1pYYzhwTWQyN2JuT245bnEycFUxYTRYRFU1c1VsRWM2alpqZGxHL3VkMmhs?=
 =?utf-8?B?aWZ1R01JSXBoUW9VQzFreTZjcTFNUEprdzdZZnlBUzlFMFdHVTl5Y0pRUXM1?=
 =?utf-8?B?MVZRRHZpcVhuRkpOOTNZRmFjdEpNN1g1bHJGNnZHZ0dMeHd2aTVLNGF2dWRP?=
 =?utf-8?B?NkEzbFBzc3FKQUs1dkNOUXhUNnB1UURndVR6V3IwNmxoQzRDa3RsSk1QSzRn?=
 =?utf-8?B?Q2ovdlFMRm8vTC8za1d0a05ReUh5MzlUdkVXTDNSTzljWnNyY21xSUJkMmdn?=
 =?utf-8?B?QUFrUnU3QUpUWE9NaG0yR0QvMUM4ZjN1R1FScllZWHVPMVA0KzBuWklxbEdn?=
 =?utf-8?B?R3EyY0NyZm95ek96ZW5wVjdnOVRTYVVZbk04Q29rZGFlY0pHZVZkSmErQ0Rr?=
 =?utf-8?B?anIybkJxUmVJaXhGVFdFOWxEeWF4Vlgzc2U0VTlBZUpiY08vOE1td3kwMGpP?=
 =?utf-8?B?RG1UQTRSUDJ2dDZpK2dvRGVJK1Q4dklETEVkNi9qeEs2TkpPK3RsbG1qbVhR?=
 =?utf-8?B?SkdCOWtIWjhkcTU4OFAwRkRoelhJME9GQWtKWGJJS0xNRWo3aHpqU0FUUXB1?=
 =?utf-8?B?ckVaWFRDV0x3L3pESWE2M3ZtSG9Pam9pQTh6dUxOOFcyeUhBeU45Y01GS3BE?=
 =?utf-8?B?Nlo1MENFdXBCWWJlTGNpVUIza2JkQ25ndm5ZSUttVzVHM3pZb01rbzdqNUpT?=
 =?utf-8?B?Qm1VME1FczNLRG9CNktNR3pqVXpDOUl6QS8xcFBqT2ovaHFJUHhNRS82Tzhy?=
 =?utf-8?B?UHlHOThXMllQRTFuSTFCOHlrM1ZHbllGc0laNmUwWTRXRk0zNDAwRWI2V1lU?=
 =?utf-8?Q?ZuPQX4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3Q2S0tZNUhjWHRaZGJYWFZEYkEzS095ekRna1VrYTJjVENCakszTmNUZ0Nx?=
 =?utf-8?B?K2U4dVQyMjQzQ29LOGdlK2Y5OXEvdC9jeHlKWWYxQWZSaXEwNUZOeDlFdnNL?=
 =?utf-8?B?Q3RTR2ZtZVU3dHFQU2pTWjhLMXhDdHlFN2VCb1lCMEZqSkFVWmJNUnVUZlRz?=
 =?utf-8?B?VXkvVFhKbW02Y2p3ZzA4WW1XYmIyVHV4R2xFUFVMV2xnSzg1aW5MalZzOGFx?=
 =?utf-8?B?M1JaRDhZcWpxaVA1UGhITkYyQ0VZeGhQN2hxM3VIZW92MEMvcVVCcC9VTXBY?=
 =?utf-8?B?OHliL1VySUR3NlRKYjZjby9KWlNMVGkrQ1ljbDBSbVR0QllaMUFxTWo0UHhS?=
 =?utf-8?B?WFlDSkZMcU1KWlpaQU9CdmI3a1Rkc05SZndLUDd6RXF0RlM4U3JZbU9RWGFJ?=
 =?utf-8?B?c0dMUUdqZXlJMHhobExnajRRbmtXNWlOd2grVWt2VXNuaHV6c1dNNlY2RFN0?=
 =?utf-8?B?dDVueTNJQ3BtZE82NUlEYXVrVU44b2J5Slg2cmhWM051VjNQUkMvdkZnaHVO?=
 =?utf-8?B?ZGl6bVhocktOdThBd3h6a01yL24zVXpZVFNUeE55Y2M1bGxEWXhjL1liczkx?=
 =?utf-8?B?c3NkQUNXZW9zKzAvS3FsZ2M4c2ZkQmViNkdKYVhaTy9MTndxcGZsY0xieVAy?=
 =?utf-8?B?d1VrMHpPanpyMEFrL2dMRXgzQ3FjbkRlekI1SEdZWFF4T3I0cGdsdWFmVnlq?=
 =?utf-8?B?RklGa3lUWkVBMjRJd2YySkJ1REI2c1Q0aXZMQmxjK2tkU0E0R3pzSjFUWDVW?=
 =?utf-8?B?elZBd1BOU3BjbE5YRGs2RjlTbGdlcDdKZVI1Wk83YkR0bC9CNzlpd3FPQVZ2?=
 =?utf-8?B?bmVudG5vcW0vN1d1MzFvR0NiTHdMaHlTR0t4cytuUE50YnhGSnpaZTZreGRm?=
 =?utf-8?B?MHJWdStPT01BRHpWWjZzNWtpU0lGUWNYUG5rbGZ4RExGbGFYMU1peThOVG4x?=
 =?utf-8?B?MktDVERwVy9oUHc2dWtLSVIzTVA0Zk9JazhyZEFjeXhtbVE3WEFXTkRKWlo4?=
 =?utf-8?B?VEFlZDVGY245WTNabnNKRGNmQ28xUFQ0WEdhWjZPSUw4TmlKRjZ1TktQVGk3?=
 =?utf-8?B?a0hhbFFaQW10dlpZemxwOHd2REtFUVJKZ25VQjRKZEV6VHJQQVE5bG91Yi93?=
 =?utf-8?B?c0ZuZW1KQWlSUjBOaVRoVFVIbVgwSjNxSG81UlhabVNCenQ5MWtXTFE0YTZ0?=
 =?utf-8?B?UndHMDdFcEpMbFpGVEEvRnlZM2ZxVHZjNWVJTkUzYlFYaXAySEE1TXJEM0hn?=
 =?utf-8?B?Q3h4MFptWEJ3QW44R20yQklkSUE4UUYzeHA3UjF5MWhpRm0vbjA1V2hKNmlw?=
 =?utf-8?B?cjNGOG44dVNRbzdqWG1xOW5zQ01aRUxFbXJKQVB3aTc2UVpmNEEyOElQSUdF?=
 =?utf-8?B?SU9zekkrN0ZCV0J5ZzBiNkQ4Y3owMzB6ZTZLb2doMi9mQ3ZIUzdHM0kwQXlG?=
 =?utf-8?B?VVVYUEZRR01CaUdoK1N0bTlqS2c5TSswQ0lWR1dRa0ZFOXhIckJJVEl2c3kx?=
 =?utf-8?B?QnVTVDlJVmNjV1ZSUHdodmFhb0RyK0JVWXduZjd4Z1dCVVlCU29pZzFXd1BB?=
 =?utf-8?B?VXZBbWViT0luUFFabTlUaU5ZNVowa2JNVEo3bjl1Nklhd1FaZUVjZUR4RWJD?=
 =?utf-8?B?YnMzZ2MrOVh2Q3VpK2laTzZZTjgxMVdVc1UybXJmNlNtY2ZRTmJhaUEzWGQ3?=
 =?utf-8?B?eXpMRXJ0d1d2QTRzU0tURHFjVGRjRHZ3ZHRCYlMrL3FGM21rM1RKU1NrZ0ZS?=
 =?utf-8?B?SnoxSnppZ083Um9rZnZNczhZRkZ2eS9WNE5JS1UraGZJQ1ZDZVlWTXJaQ2c2?=
 =?utf-8?B?MmQyQVFWOWh3K1F5d1M2bU9Kd3FtOHk5SHpQd1pzeVQzdTJhY1p1VWxvRmd3?=
 =?utf-8?B?YUxGbXo5R3JBVEtIRDBhNmZKS1VDRW1WSElLRjVDMy9BQ2hjdFY1TkJwVnpR?=
 =?utf-8?B?Qyt3Sk5YZHQrQVpndDFBVDFNV1dLaWljR2VPVjMwS3I4TUJwbDRnMUNUa01o?=
 =?utf-8?B?T2tlejVPaW11T3hBK3FsUGRNOGU4dmhLbk5sNU9wUVBVaUUreGJmL2VIb1Zs?=
 =?utf-8?B?THJWZHhVMUMwbzZ5UWxZSmNMWi8vL0xqMFVNQUVOWkN6QklBV2NLcERZSkhQ?=
 =?utf-8?Q?aMBnr8hfqPoZJliM9aNWueqcb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85b0b6c-38d2-4140-8389-08de06e6c243
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:48:50.6597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GokBsE0wBsztZ1hJLuunpYp6mdY48UEET5VfLmszUlpWvJn6frWcOd0SUkCxPb3MK9R8C1X9g0RvK53Op4ZOvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

Spread spectrum configuration is part of clock frequency settings,
and its behavior can be validated similarly to assigned clock rates.

Extend the existing KUnit tests for assigned-clock-rates to cover
assigned-clock-sscs by reusing the test framework. Add new test
device trees:
  - kunit_clk_assigned_sscs_null.dtso
  - kunit_clk_assigned_sscs_null_consumer.dtso
  - kunit_clk_assigned_sscs_without.dtso
  - kunit_clk_assigned_sscs_without_consumer.dtso
  - kunit_clk_assigned_sscs_zero.dtso
  - kunit_clk_assigned_sscs_zero_consumer.dtso

These tests cover various invalid configurations of assigned-clock-sscs,
ensuring robustness and consistent error handling, similar to the coverage
provided for assigned-clock-rates.

Co-developed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/Makefile                               |   6 +
 drivers/clk/clk_test.c                             | 121 ++++++++++++++++++++-
 drivers/clk/kunit_clk_assigned_rates.h             |  10 ++
 drivers/clk/kunit_clk_assigned_rates_multiple.dtso |   6 +
 ...kunit_clk_assigned_rates_multiple_consumer.dtso |   6 +
 drivers/clk/kunit_clk_assigned_rates_one.dtso      |   3 +
 .../clk/kunit_clk_assigned_rates_one_consumer.dtso |   3 +
 .../clk/kunit_clk_assigned_rates_u64_multiple.dtso |   6 +
 ...t_clk_assigned_rates_u64_multiple_consumer.dtso |   6 +
 drivers/clk/kunit_clk_assigned_rates_u64_one.dtso  |   3 +
 .../kunit_clk_assigned_rates_u64_one_consumer.dtso |   3 +
 drivers/clk/kunit_clk_assigned_sscs_null.dtso      |  16 +++
 .../clk/kunit_clk_assigned_sscs_null_consumer.dtso |  20 ++++
 drivers/clk/kunit_clk_assigned_sscs_without.dtso   |  15 +++
 .../kunit_clk_assigned_sscs_without_consumer.dtso  |  19 ++++
 drivers/clk/kunit_clk_assigned_sscs_zero.dtso      |  12 ++
 .../clk/kunit_clk_assigned_sscs_zero_consumer.dtso |  16 +++
 17 files changed, 268 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index b74a1767ca2787a978db36b0055ea34cb909310e..9e8c989b24be0f7cfdf2325c9b19d05e9d2a8eb9 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -18,6 +18,12 @@ clk-test-y			:= clk_test.o \
 				   kunit_clk_assigned_rates_without_consumer.dtbo.o \
 				   kunit_clk_assigned_rates_zero.dtbo.o \
 				   kunit_clk_assigned_rates_zero_consumer.dtbo.o \
+				   kunit_clk_assigned_sscs_null.dtbo.o \
+				   kunit_clk_assigned_sscs_null_consumer.dtbo.o \
+				   kunit_clk_assigned_sscs_without.dtbo.o \
+				   kunit_clk_assigned_sscs_without_consumer.dtbo.o \
+				   kunit_clk_assigned_sscs_zero.dtbo.o \
+				   kunit_clk_assigned_sscs_zero_consumer.dtbo.o \
 				   kunit_clk_hw_get_dev_of_node.dtbo.o \
 				   kunit_clk_parent_data_test.dtbo.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-divider.o
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index a268d7b5d4cb28ec1f029f828c31107f8e130556..eb28f0a61ef0057bcc9c1d75653357a442bff81d 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -28,6 +28,7 @@ static const struct clk_ops empty_clk_ops = { };
 struct clk_dummy_context {
 	struct clk_hw hw;
 	unsigned long rate;
+	struct clk_spread_spectrum sscs;
 };
 
 static unsigned long clk_dummy_recalc_rate(struct clk_hw *hw,
@@ -83,6 +84,17 @@ static int clk_dummy_set_rate(struct clk_hw *hw,
 	return 0;
 }
 
+static int clk_dummy_set_spread_spectrum(struct clk_hw *hw,
+					 struct clk_spread_spectrum *conf)
+{
+	struct clk_dummy_context *ctx =
+		container_of(hw, struct clk_dummy_context, hw);
+
+	ctx->sscs = *conf;
+
+	return 0;
+}
+
 static int clk_dummy_single_set_parent(struct clk_hw *hw, u8 index)
 {
 	if (index >= clk_hw_get_num_parents(hw))
@@ -100,18 +112,21 @@ static const struct clk_ops clk_dummy_rate_ops = {
 	.recalc_rate = clk_dummy_recalc_rate,
 	.determine_rate = clk_dummy_determine_rate,
 	.set_rate = clk_dummy_set_rate,
+	.set_spread_spectrum = clk_dummy_set_spread_spectrum,
 };
 
 static const struct clk_ops clk_dummy_maximize_rate_ops = {
 	.recalc_rate = clk_dummy_recalc_rate,
 	.determine_rate = clk_dummy_maximize_rate,
 	.set_rate = clk_dummy_set_rate,
+	.set_spread_spectrum = clk_dummy_set_spread_spectrum,
 };
 
 static const struct clk_ops clk_dummy_minimize_rate_ops = {
 	.recalc_rate = clk_dummy_recalc_rate,
 	.determine_rate = clk_dummy_minimize_rate,
 	.set_rate = clk_dummy_set_rate,
+	.set_spread_spectrum = clk_dummy_set_spread_spectrum,
 };
 
 static const struct clk_ops clk_dummy_single_parent_ops = {
@@ -3097,6 +3112,7 @@ struct clk_assigned_rates_context {
  * @overlay_end: Pointer to end of DT overlay to apply for test
  * @rate0: Initial rate of first clk
  * @rate1: Initial rate of second clk
+ * @sscs: Initial spread spectrum settings
  * @consumer_test: true if a consumer is being tested
  */
 struct clk_assigned_rates_test_param {
@@ -3105,6 +3121,7 @@ struct clk_assigned_rates_test_param {
 	u8 *overlay_end;
 	unsigned long rate0;
 	unsigned long rate1;
+	struct clk_spread_spectrum sscs;
 	bool consumer_test;
 };
 
@@ -3116,7 +3133,7 @@ static void
 clk_assigned_rates_register_clk(struct kunit *test,
 				struct clk_dummy_context *ctx,
 				struct device_node *np, const char *name,
-				unsigned long rate)
+				unsigned long rate, const struct clk_spread_spectrum *sscs)
 {
 	struct clk_init_data init = { };
 
@@ -3124,6 +3141,7 @@ clk_assigned_rates_register_clk(struct kunit *test,
 	init.ops = &clk_dummy_rate_ops;
 	ctx->hw.init = &init;
 	ctx->rate = rate;
+	ctx->sscs = *sscs;
 
 	KUNIT_ASSERT_EQ(test, 0, of_clk_hw_register_kunit(test, np, &ctx->hw));
 	KUNIT_ASSERT_EQ(test, ctx->rate, rate);
@@ -3167,14 +3185,16 @@ static int clk_assigned_rates_test_init(struct kunit *test)
 	KUNIT_ASSERT_LT(test, clk_cells, 2);
 
 	clk_assigned_rates_register_clk(test, &ctx->clk0, np,
-					"test_assigned_rate0", test_param->rate0);
+					"test_assigned_rate0", test_param->rate0,
+					&test_param->sscs);
 	if (clk_cells == 0) {
 		KUNIT_ASSERT_EQ(test, 0,
 				of_clk_add_hw_provider_kunit(test, np, of_clk_hw_simple_get,
 							     &ctx->clk0.hw));
 	} else if (clk_cells == 1) {
 		clk_assigned_rates_register_clk(test, &ctx->clk1, np,
-						"test_assigned_rate1", test_param->rate1);
+						"test_assigned_rate1", test_param->rate1,
+						&test_param->sscs);
 
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(test,
 			data = kunit_kzalloc(test, struct_size(data, hws, 2), GFP_KERNEL));
@@ -3203,6 +3223,9 @@ static void clk_assigned_rates_assigns_one(struct kunit *test)
 	struct clk_assigned_rates_context *ctx = test->priv;
 
 	KUNIT_EXPECT_EQ(test, ctx->clk0.rate, ASSIGNED_RATES_0_RATE);
+	KUNIT_EXPECT_EQ(test, ctx->clk0.sscs.modfreq_hz, ASSIGNED_SSCS_0_MODFREQ);
+	KUNIT_EXPECT_EQ(test, ctx->clk0.sscs.spread_bp, ASSIGNED_SSCS_0_SPREAD);
+	KUNIT_EXPECT_EQ(test, ctx->clk0.sscs.method, ASSIGNED_SSCS_0_METHOD);
 }
 
 static void clk_assigned_rates_assigns_multiple(struct kunit *test)
@@ -3210,7 +3233,13 @@ static void clk_assigned_rates_assigns_multiple(struct kunit *test)
 	struct clk_assigned_rates_context *ctx = test->priv;
 
 	KUNIT_EXPECT_EQ(test, ctx->clk0.rate, ASSIGNED_RATES_0_RATE);
+	KUNIT_EXPECT_EQ(test, ctx->clk0.sscs.modfreq_hz, ASSIGNED_SSCS_0_MODFREQ);
+	KUNIT_EXPECT_EQ(test, ctx->clk0.sscs.spread_bp, ASSIGNED_SSCS_0_SPREAD);
+	KUNIT_EXPECT_EQ(test, ctx->clk0.sscs.method, ASSIGNED_SSCS_0_METHOD);
 	KUNIT_EXPECT_EQ(test, ctx->clk1.rate, ASSIGNED_RATES_1_RATE);
+	KUNIT_EXPECT_EQ(test, ctx->clk1.sscs.modfreq_hz, ASSIGNED_SSCS_1_MODFREQ);
+	KUNIT_EXPECT_EQ(test, ctx->clk1.sscs.spread_bp, ASSIGNED_SSCS_1_SPREAD);
+	KUNIT_EXPECT_EQ(test, ctx->clk1.sscs.method, ASSIGNED_SSCS_1_METHOD);
 }
 
 static void clk_assigned_rates_skips(struct kunit *test)
@@ -3222,6 +3251,19 @@ static void clk_assigned_rates_skips(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->clk0.rate, test_param->rate0);
 }
 
+static void clk_assigned_sscs_skips(struct kunit *test)
+{
+	struct clk_assigned_rates_context *ctx = test->priv;
+	const struct clk_assigned_rates_test_param *test_param = test->param_value;
+
+	KUNIT_EXPECT_NE(test, ctx->clk0.sscs.modfreq_hz, ASSIGNED_SSCS_0_MODFREQ);
+	KUNIT_EXPECT_NE(test, ctx->clk0.sscs.spread_bp, ASSIGNED_SSCS_0_SPREAD);
+	KUNIT_EXPECT_NE(test, ctx->clk0.sscs.method, ASSIGNED_SSCS_0_METHOD);
+	KUNIT_EXPECT_EQ(test, ctx->clk0.sscs.modfreq_hz, test_param->sscs.modfreq_hz);
+	KUNIT_EXPECT_EQ(test, ctx->clk0.sscs.spread_bp, test_param->sscs.spread_bp);
+	KUNIT_EXPECT_EQ(test, ctx->clk0.sscs.method, test_param->sscs.method);
+}
+
 OF_OVERLAY_DECLARE(kunit_clk_assigned_rates_one);
 OF_OVERLAY_DECLARE(kunit_clk_assigned_rates_one_consumer);
 OF_OVERLAY_DECLARE(kunit_clk_assigned_rates_u64_one);
@@ -3384,6 +3426,77 @@ KUNIT_ARRAY_PARAM_DESC(clk_assigned_rates_skips,
 		       clk_assigned_rates_skips_test_params,
 		       desc)
 
+OF_OVERLAY_DECLARE(kunit_clk_assigned_sscs_without);
+OF_OVERLAY_DECLARE(kunit_clk_assigned_sscs_without_consumer);
+OF_OVERLAY_DECLARE(kunit_clk_assigned_sscs_zero);
+OF_OVERLAY_DECLARE(kunit_clk_assigned_sscs_zero_consumer);
+OF_OVERLAY_DECLARE(kunit_clk_assigned_sscs_null);
+OF_OVERLAY_DECLARE(kunit_clk_assigned_sscs_null_consumer);
+
+/* Test cases that skip changing the sscs due to malformed DT */
+static const struct clk_assigned_rates_test_param clk_assigned_sscs_skips_test_params[] = {
+	{
+		/*
+		 * Test that an assigned-clock-sscs property without an assigned-clocks
+		 * property fails when the property is in the provider.
+		 */
+		.desc = "provider missing assigned-clocks",
+		TEST_PARAM_OVERLAY(kunit_clk_assigned_sscs_without),
+		.sscs = {50000, 60000, 3},
+	},
+	{
+		/*
+		 * Test that an assigned-clock-rates property without an assigned-clocks
+		 * property fails when the property is in the consumer.
+		 */
+		.desc = "consumer missing assigned-clocks",
+		TEST_PARAM_OVERLAY(kunit_clk_assigned_sscs_without_consumer),
+		.sscs = {50000, 60000, 3},
+		.consumer_test = true,
+	},
+	{
+		/*
+		 * Test that an assigned-clock-rates property of zero doesn't
+		 * set a rate when the property is in the provider.
+		 */
+		.desc = "provider assigned-clock-sscs of zero",
+		TEST_PARAM_OVERLAY(kunit_clk_assigned_sscs_zero),
+		.sscs = {50000, 60000, 3},
+	},
+	{
+		/*
+		 * Test that an assigned-clock-rates property of zero doesn't
+		 * set a rate when the property is in the consumer.
+		 */
+		.desc = "consumer assigned-clock-sscs of zero",
+		TEST_PARAM_OVERLAY(kunit_clk_assigned_sscs_zero_consumer),
+		.sscs = {50000, 60000, 3},
+		.consumer_test = true,
+	},
+	{
+		/*
+		 * Test that an assigned-clocks property with a null phandle
+		 * doesn't set a rate when the property is in the provider.
+		 */
+		.desc = "provider assigned-clocks null phandle",
+		TEST_PARAM_OVERLAY(kunit_clk_assigned_sscs_null),
+		.sscs = {50000, 60000, 3},
+	},
+	{
+		/*
+		 * Test that an assigned-clocks property with a null phandle
+		 * doesn't set a rate when the property is in the consumer.
+		 */
+		.desc = "provider assigned-clocks null phandle",
+		TEST_PARAM_OVERLAY(kunit_clk_assigned_sscs_null_consumer),
+		.sscs = {50000, 60000, 3},
+		.consumer_test = true,
+	},
+};
+KUNIT_ARRAY_PARAM_DESC(clk_assigned_sscs_skips,
+		       clk_assigned_sscs_skips_test_params,
+		       desc)
+
 static struct kunit_case clk_assigned_rates_test_cases[] = {
 	KUNIT_CASE_PARAM(clk_assigned_rates_assigns_one,
 			 clk_assigned_rates_assigns_one_gen_params),
@@ -3391,6 +3504,8 @@ static struct kunit_case clk_assigned_rates_test_cases[] = {
 			 clk_assigned_rates_assigns_multiple_gen_params),
 	KUNIT_CASE_PARAM(clk_assigned_rates_skips,
 			 clk_assigned_rates_skips_gen_params),
+	KUNIT_CASE_PARAM(clk_assigned_sscs_skips,
+			 clk_assigned_sscs_skips_gen_params),
 	{}
 };
 
diff --git a/drivers/clk/kunit_clk_assigned_rates.h b/drivers/clk/kunit_clk_assigned_rates.h
index df2d84dcaa93511694b6da842debdc3cfd3a6c19..d7ae5ec2d25bed79b8438e8ce580872131ce4286 100644
--- a/drivers/clk/kunit_clk_assigned_rates.h
+++ b/drivers/clk/kunit_clk_assigned_rates.h
@@ -1,8 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#include <dt-bindings/clock/clock.h>
+
 #ifndef _KUNIT_CLK_ASSIGNED_RATES_H
 #define _KUNIT_CLK_ASSIGNED_RATES_H
 
 #define ASSIGNED_RATES_0_RATE		1600000
 #define ASSIGNED_RATES_1_RATE		9700000
 
+#define ASSIGNED_SSCS_0_MODFREQ		10000
+#define ASSIGNED_SSCS_0_SPREAD		30000
+#define ASSIGNED_SSCS_0_METHOD		CLK_SSC_CENTER_SPREAD
+#define ASSIGNED_SSCS_1_MODFREQ		20000
+#define ASSIGNED_SSCS_1_SPREAD		40000
+#define ASSIGNED_SSCS_1_METHOD		CLK_SSC_UP_SPREAD
+
 #endif
diff --git a/drivers/clk/kunit_clk_assigned_rates_multiple.dtso b/drivers/clk/kunit_clk_assigned_rates_multiple.dtso
index e600736e70f5041ddeb1bfb0d6074746a064e08a..6c54d65444d5d779c9fa4bb2a79c4742dd88f6d0 100644
--- a/drivers/clk/kunit_clk_assigned_rates_multiple.dtso
+++ b/drivers/clk/kunit_clk_assigned_rates_multiple.dtso
@@ -12,5 +12,11 @@ clk: kunit-clock {
 				  <&clk 1>;
 		assigned-clock-rates = <ASSIGNED_RATES_0_RATE>,
 				       <ASSIGNED_RATES_1_RATE>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>,
+				      <ASSIGNED_SSCS_1_MODFREQ
+				       ASSIGNED_SSCS_1_SPREAD
+				       ASSIGNED_SSCS_1_METHOD>;
 	};
 };
diff --git a/drivers/clk/kunit_clk_assigned_rates_multiple_consumer.dtso b/drivers/clk/kunit_clk_assigned_rates_multiple_consumer.dtso
index 260aba458daf2bc57fde46b5442453e7de10faac..b1fee396c4b1e51341a411168569d8351bb23b12 100644
--- a/drivers/clk/kunit_clk_assigned_rates_multiple_consumer.dtso
+++ b/drivers/clk/kunit_clk_assigned_rates_multiple_consumer.dtso
@@ -16,5 +16,11 @@ kunit-clock-consumer {
 				  <&clk 1>;
 		assigned-clock-rates = <ASSIGNED_RATES_0_RATE>,
 				       <ASSIGNED_RATES_1_RATE>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>,
+				      <ASSIGNED_SSCS_1_MODFREQ
+				       ASSIGNED_SSCS_1_SPREAD
+				       ASSIGNED_SSCS_1_METHOD>;
 	};
 };
diff --git a/drivers/clk/kunit_clk_assigned_rates_one.dtso b/drivers/clk/kunit_clk_assigned_rates_one.dtso
index dd95ec9b1cf977883f71564a94602ae518937132..da6e91b9e6bda0ef2c8f601a08aef1f10fda4baa 100644
--- a/drivers/clk/kunit_clk_assigned_rates_one.dtso
+++ b/drivers/clk/kunit_clk_assigned_rates_one.dtso
@@ -10,5 +10,8 @@ clk: kunit-clock {
 		#clock-cells = <0>;
 		assigned-clocks = <&clk>;
 		assigned-clock-rates = <ASSIGNED_RATES_0_RATE>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>;
 	};
 };
diff --git a/drivers/clk/kunit_clk_assigned_rates_one_consumer.dtso b/drivers/clk/kunit_clk_assigned_rates_one_consumer.dtso
index a41dca806318b031187c1b8739fcf71eb088a480..4b6e06048f863d014aed8222652d6d9d38e9238b 100644
--- a/drivers/clk/kunit_clk_assigned_rates_one_consumer.dtso
+++ b/drivers/clk/kunit_clk_assigned_rates_one_consumer.dtso
@@ -14,5 +14,8 @@ kunit-clock-consumer {
 		compatible = "test,clk-consumer";
 		assigned-clocks = <&clk>;
 		assigned-clock-rates = <ASSIGNED_RATES_0_RATE>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>;
 	};
 };
diff --git a/drivers/clk/kunit_clk_assigned_rates_u64_multiple.dtso b/drivers/clk/kunit_clk_assigned_rates_u64_multiple.dtso
index 389b4e2eb7f74f1770ff5f5c4be5b45dd344dc9c..3a717dab2d00b7fdaff580e30ed2cc520683ef95 100644
--- a/drivers/clk/kunit_clk_assigned_rates_u64_multiple.dtso
+++ b/drivers/clk/kunit_clk_assigned_rates_u64_multiple.dtso
@@ -12,5 +12,11 @@ clk: kunit-clock {
 				  <&clk 1>;
 		assigned-clock-rates-u64 = /bits/ 64 <ASSIGNED_RATES_0_RATE>,
 					   /bits/ 64 <ASSIGNED_RATES_1_RATE>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>,
+				      <ASSIGNED_SSCS_1_MODFREQ
+				       ASSIGNED_SSCS_1_SPREAD
+				       ASSIGNED_SSCS_1_METHOD>;
 	};
 };
diff --git a/drivers/clk/kunit_clk_assigned_rates_u64_multiple_consumer.dtso b/drivers/clk/kunit_clk_assigned_rates_u64_multiple_consumer.dtso
index 3e117fd59b7da19cd8a603af77eff29175ce6900..cbee7cbad068f3336f0c8997a5b3e9af4db565c9 100644
--- a/drivers/clk/kunit_clk_assigned_rates_u64_multiple_consumer.dtso
+++ b/drivers/clk/kunit_clk_assigned_rates_u64_multiple_consumer.dtso
@@ -16,5 +16,11 @@ kunit-clock-consumer {
 				  <&clk 1>;
 		assigned-clock-rates-u64 = /bits/ 64 <ASSIGNED_RATES_0_RATE>,
 					   /bits/ 64 <ASSIGNED_RATES_1_RATE>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>,
+				      <ASSIGNED_SSCS_1_MODFREQ
+				       ASSIGNED_SSCS_1_SPREAD
+				       ASSIGNED_SSCS_1_METHOD>;
 	};
 };
diff --git a/drivers/clk/kunit_clk_assigned_rates_u64_one.dtso b/drivers/clk/kunit_clk_assigned_rates_u64_one.dtso
index 87041264e8f544dafddf2e905efc89dc1f917c54..9b04d6927f0830a5621af1cbea503a427b46bee0 100644
--- a/drivers/clk/kunit_clk_assigned_rates_u64_one.dtso
+++ b/drivers/clk/kunit_clk_assigned_rates_u64_one.dtso
@@ -10,5 +10,8 @@ clk: kunit-clock {
 		#clock-cells = <0>;
 		assigned-clocks = <&clk>;
 		assigned-clock-rates-u64 = /bits/ 64 <ASSIGNED_RATES_0_RATE>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>;
 	};
 };
diff --git a/drivers/clk/kunit_clk_assigned_rates_u64_one_consumer.dtso b/drivers/clk/kunit_clk_assigned_rates_u64_one_consumer.dtso
index 3259c003aec0be3269ab60a4a3a95df69f8de1f8..4784d40520f4193e4f08c8981386f0772a063452 100644
--- a/drivers/clk/kunit_clk_assigned_rates_u64_one_consumer.dtso
+++ b/drivers/clk/kunit_clk_assigned_rates_u64_one_consumer.dtso
@@ -14,5 +14,8 @@ kunit-clock-consumer {
 		compatible = "test,clk-consumer";
 		assigned-clocks = <&clk>;
 		assigned-clock-rates-u64 = /bits/ 64 <ASSIGNED_RATES_0_RATE>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>;
 	};
 };
diff --git a/drivers/clk/kunit_clk_assigned_sscs_null.dtso b/drivers/clk/kunit_clk_assigned_sscs_null.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..43b2068c845dea53ea1328bb63a2f58a4b8ef339
--- /dev/null
+++ b/drivers/clk/kunit_clk_assigned_sscs_null.dtso
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+#include "kunit_clk_assigned_rates.h"
+
+&{/} {
+	clk: kunit-clock {
+		compatible = "test,clk-assigned-rates";
+		#clock-cells = <0>;
+		assigned-clocks = <0>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>;
+	};
+};
diff --git a/drivers/clk/kunit_clk_assigned_sscs_null_consumer.dtso b/drivers/clk/kunit_clk_assigned_sscs_null_consumer.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..bda008f5aaa35e53af97863e4f2e6d8a168cc053
--- /dev/null
+++ b/drivers/clk/kunit_clk_assigned_sscs_null_consumer.dtso
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+#include "kunit_clk_assigned_rates.h"
+
+&{/} {
+	clk: kunit-clock {
+		compatible = "test,clk-assigned-rates";
+		#clock-cells = <0>;
+	};
+
+	kunit-clock-consumer {
+		compatible = "test,clk-consumer";
+		assigned-clocks = <0>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>;
+	};
+};
diff --git a/drivers/clk/kunit_clk_assigned_sscs_without.dtso b/drivers/clk/kunit_clk_assigned_sscs_without.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..08660846b55c12122bfb211c01c377a3a45223c9
--- /dev/null
+++ b/drivers/clk/kunit_clk_assigned_sscs_without.dtso
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+#include "kunit_clk_assigned_rates.h"
+
+&{/} {
+	clk: kunit-clock {
+		compatible = "test,clk-assigned-rates";
+		#clock-cells = <0>;
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>;
+	};
+};
diff --git a/drivers/clk/kunit_clk_assigned_sscs_without_consumer.dtso b/drivers/clk/kunit_clk_assigned_sscs_without_consumer.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..e1c089c6f0c0223f16f7ac9a396e7ac7b821c967
--- /dev/null
+++ b/drivers/clk/kunit_clk_assigned_sscs_without_consumer.dtso
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+#include "kunit_clk_assigned_rates.h"
+
+&{/} {
+	clk: kunit-clock {
+		compatible = "test,clk-assigned-rates";
+		#clock-cells = <0>;
+	};
+
+	kunit-clock-consumer {
+		compatible = "test,clk-consumer";
+		assigned-clock-sscs = <ASSIGNED_SSCS_0_MODFREQ
+				       ASSIGNED_SSCS_0_SPREAD
+				       ASSIGNED_SSCS_0_METHOD>;
+	};
+};
diff --git a/drivers/clk/kunit_clk_assigned_sscs_zero.dtso b/drivers/clk/kunit_clk_assigned_sscs_zero.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..f39f4e754e532c9c1b1fdf034700e5af1f3f0779
--- /dev/null
+++ b/drivers/clk/kunit_clk_assigned_sscs_zero.dtso
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	clk: kunit-clock {
+		compatible = "test,clk-assigned-rates";
+		#clock-cells = <0>;
+		assigned-clocks = <&clk>;
+		assigned-clock-sscs = <0 0 0>;
+	};
+};
diff --git a/drivers/clk/kunit_clk_assigned_sscs_zero_consumer.dtso b/drivers/clk/kunit_clk_assigned_sscs_zero_consumer.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..d6bd7dfada7e2f455cb23e483b9bd6ce24839e3a
--- /dev/null
+++ b/drivers/clk/kunit_clk_assigned_sscs_zero_consumer.dtso
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	clk: kunit-clock {
+		compatible = "test,clk-assigned-rates";
+		#clock-cells = <0>;
+	};
+
+	kunit-clock-consumer {
+		compatible = "test,clk-consumer";
+		assigned-clocks = <&clk>;
+		assigned-clock-sscs = <0 0 0>;
+	};
+};

-- 
2.37.1


