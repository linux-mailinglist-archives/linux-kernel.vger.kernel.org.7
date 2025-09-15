Return-Path: <linux-kernel+bounces-816369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5326B572EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A323048029E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60712EDD57;
	Mon, 15 Sep 2025 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gTfWG1go"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F22F0C48;
	Mon, 15 Sep 2025 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925037; cv=fail; b=Apvja590uZvaKecVLQ6DBuW8Z67I8VICj6uqISyFoLDAGIWV3RTwW61+bvtyQoqY11x9saU72s9tPNWBS2iOG4FwOVh986A7FUQaJP0b9oeGfOI9D6Oy9lxJZGzvQj34IPCSmqKESvE0Zk0jvvP17Lw8pwzF3GKMjWjx0WwdWgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925037; c=relaxed/simple;
	bh=KXI5+OWRhC+DEfwoI27LBcMYeeBwhNiMRAiQASaZY5E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eOl1RomVwzx83h2kiKzrXl4Pei/OQRg5BtAd54mO7JxKXOO5oY+/Og6vmshZ50MIuhaYQi0MfiPKlz+WHD3k61v2zt3+mNpuo/5ypNctfFvme3XJgxeoLTGSc5w+iyIswN8PXD2BkP4ckwargtp447RIhaGtynDWwBji51dHHdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gTfWG1go; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFoKkHsySOKCTwVTykLide0PokXqUVYC63mQmuPF8ew0WSwPTuRQv9dhJNeRnqon80a2S9Z/tK2VF98b7nojRbjFyPCSIENm8ywO7XsTUVBxa514Sff5vtmhpUsviquj6XhNNJ0LtpIXFQGSOl4JlrIZUGwOzyZxsZdzeHCZMlX1ohvSWa8PUQM5ll/k3cPCgJ+WwAE6lbSP3gmFWNZBL6jlJBkFVGok3PdRiwvRpw3yS9lkRsM/dBT91faYbnxUn1q25YCW+QxbGGWqvOmWXjD8o47Sl97m45+d+5WlfmuODgYdlOpsrzKcGZSy2Ag+OPGx5GE7GCDG0yBhHl4IYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTktGQYtJAlpe96g9Nfk/AbZ2GYgHcSJbds2+bEMWfA=;
 b=dAJqJ/715bZVH7FGXBi8byd5SbgfZj2rvQvKvJu0vBX/cQMSVM4CN0j+/eAQS0unRj1Hc0oAyGqqg9Mr3xAArmaKyJqH5uBoW8Aqk0al8EqEm9cQcXSb9PNtNOjc6RZzdCL1eThyS3ALmOl8Gr+3YfPdrSfm/7fD3oNCytSqpuA/dlN1nSlg6B0wYldDUx9CxqPVEpv/wcgmkUse/5f4uYIZJCugbCsEq0JYfT+GRGYZR4Dw6+8pVy4scrrm68HV0jPzDM3uK7q4Lj6Dt+kx7Q168DTmauRv+XGWidghufldxv0zqNUZZ1/t9rDCYmogd5OUpEomRHBBv+V3bsUpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTktGQYtJAlpe96g9Nfk/AbZ2GYgHcSJbds2+bEMWfA=;
 b=gTfWG1gouhQaPjtV0YH8J4KACv8cDZgoMNiYKPw5kYRIRB1h9hJjhsV2NXuZPJSHDXmB4dUuTCgqkvyZFxZoSYyc/owb/Cm/psuIvSFR/DU93kQye8TEVKnSynaVVU2jbGDtl5sP+7m0OmUdOZV/ZH2q377HvD2F90pcacCcS4t33VjNgGOp+n7wUK0HI1hP6mkt/dTtpzkniLh7BdwHBcg19L64yNn66M/HeQKGEDEaIxc20KprccD6K/TLMUv2IX5ZcOm4bY1IXWWPxCB8n1HAev1uL5TZbnJ65lIOOQ2d0F54fahdd8vZiuTj8jDsht2Zxf7EG/PHK/6/MIVnDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7181.eurprd04.prod.outlook.com (2603:10a6:800:12a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 08:30:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 08:30:31 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 15 Sep 2025 16:29:38 +0800
Subject: [PATCH v4 4/5] clk: Add KUnit tests for assigned-clock-sscs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-clk-ssc-version1-v4-4-5a2cee2f0351@nxp.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
In-Reply-To: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757925004; l=22518;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=KXI5+OWRhC+DEfwoI27LBcMYeeBwhNiMRAiQASaZY5E=;
 b=eCyQrFLr9kZh/sDcInfR9n8d1KdBaMfA5DhyJhN6HCVvUvL6zOiEMZ6eo8r7lOzaatSuMTlXx
 NV0ZsZT6IYDCsaZosGI0FViQdph2f//wsoXrQ1Kx1754oBbLkN1F7Mv
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cbc369-6368-4440-3502-08ddf43221c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3ZRbVlxKzlWRzZqcmgrU3FXWXhETHNiZ2tsS2p5SnBvNUdKQ3N4NVVaQlNm?=
 =?utf-8?B?LzJXc3duS093NDlYUHQ3YUtjOStRcWN6SUc5LzFnTFl2dXZESjhsS3VxMEYw?=
 =?utf-8?B?WUM3N0ZSOTluZ251YnpYUHF1Rm5Bd2crbzllUytqNnFQci9EbDdEcjNkS3VH?=
 =?utf-8?B?TVh3TXVKcmpVZENFSDZ2bGV4eVFBNUNYdVFZSGVsd1A1R0VvOFVWbWI5cENP?=
 =?utf-8?B?Q2RlZm03M2hSVy8xTnFxODVFVzVva2hXRUJFTWNjYThsUi9MK2xOZHhLVVg3?=
 =?utf-8?B?MmxWNmkxZE03UVcybFNnUTZscHRCbWlQSGp0b05vVzFXT3QvY2RGOTVHOWdX?=
 =?utf-8?B?SGtnMlM0Q0JpaVlKWWZFUFcwQUpLZVlYYnQ1WXd2M25zcC9hT0pvUTdTNit6?=
 =?utf-8?B?U1NnUDBQRndaZWpnaVg2cVpTSU5NZHFTRUVtM1g3cTQ5LzcxMXRKMUdaK1Rx?=
 =?utf-8?B?ZXBJVzVnNWtVby8xVHg4TUQyWDF0TGxaek1HNEFmQmRtWmNnRkxmT3V6bWky?=
 =?utf-8?B?RGcvTFRNT0lZaW1icU94NkhpZ0lTTWVkY2hPMU9QdjdrMWdVUmJteko2K1B3?=
 =?utf-8?B?T1Y0NU1sRGVVY1g5Q05RWEx0dWdHdy9VMlZwdTZid3dCeW5oQ0NNQUhTVVRo?=
 =?utf-8?B?a0JPSTVEODEzYWhmK3NNTkFySTRWczZFL1p6NEw2NmxIbjBwakFFQytGVStJ?=
 =?utf-8?B?UzhPL01PQVV6RUYweXRHVTBhTzB5UkIrRTJqa1c2U2NJSVNsVjYxNlpCY1lt?=
 =?utf-8?B?b3F3RDVQdHprNWgzU1J5U3lSdU9GQ3BqemdMRk1YVFlFN2lMMHNzaTNmSHdL?=
 =?utf-8?B?cjhWKzdKZnhSVkNISUhiMDQrVEhEaGZGQ2xlN0NKZi8rWGhPMEdjelVWZjhx?=
 =?utf-8?B?VWZsTWtFeXZtbkkxenBOVmpJK3Frc2kxZHBKNGpac1RLeTg5Qmd6ajkrSHp3?=
 =?utf-8?B?YjFGZjQwblZMUStvZnZvR3BwYjdqRDZmU3lQaERrOEhGNG1ZMjRwZXIrbkQr?=
 =?utf-8?B?R1RLVlhJSnlHZTJZR2dyaHgxSll5Y0RLVXdTSWVSRjFlSWNIQVBYaitPdjN1?=
 =?utf-8?B?L2MxaU5KSmM3K2hIWFErSjFvb1NVQXNQQlZkb1hFankxbk9XMlhzQjlpRUZn?=
 =?utf-8?B?V1F2TzVjZ3lmcE9xb3lLSFMzQ1ZzbGpqbEhPamJlTXlPb1l3SGRhZXh1clJH?=
 =?utf-8?B?bFRxSmpOZEpieWZHQjJ4MkZuUlJOL1hCK3pXeGtiTVZjaks3T1Q4N0ZkREZv?=
 =?utf-8?B?ckkrQ2RBYlI5Q2UwSUxjMnhGVEdWWW5hcmNvemdsdzhsMzJVMHh0YWdIWVFU?=
 =?utf-8?B?OGJFNjI0TW5HY3I2QU9SbUtqRm1FYWpvUE1EdXpQNmw4bUNoZUNIU2VMN1lq?=
 =?utf-8?B?eEZpblllNW83Tld4aS84dy9QcUlrZDI0U29iaW9uMlRSa2huVGVpbmRxUks5?=
 =?utf-8?B?b0lRMEoyakVWL0FnN1VMNkJuNE80WU5lM0RXZnN3OUp5UWQyck8yeUhMQzc4?=
 =?utf-8?B?TTMvWG9VK0VndnV0QmxVZWRNdEVxb0JwRFhjUzlReXUzNHdtR1JIUkF6endG?=
 =?utf-8?B?SnNuTDM1dXk1SnRnQVNuVk1odFRWa1hGbWkwOWdJN3pZcEp3RG9vYTAyZVhO?=
 =?utf-8?B?ZlpUVzdjQ21GVll6QVFoVzhJbGcxT3UreUNkZHUrM05kQk5yY01YMzk4WmxF?=
 =?utf-8?B?bGtmN1JpT2k3UWtTUDAvTUNMcFAyMTJLL0NBQlBYZlhWMCtnaFpNd0JWVXRh?=
 =?utf-8?B?NXZ5RGJTNTBROHluLzRXbWttN2lpb2M4UFNIUlRIWFRscTBoK3R4SzNxNldn?=
 =?utf-8?B?S3hOVzZScnB3cTZvdXJXWHh0Y0IyQTZybmxXejY1dG9oUysvNm5vbVVoOEdK?=
 =?utf-8?B?Mk96WXV0WFFtQzRRSXhIVEdWaE9TVmZpYnlBR0g0THpCais4OGNleWRqRWxn?=
 =?utf-8?B?Y3RzRTFxRW1XYy9IQXBWVm5jTnF4eXdNeDAwZUg2T0N3WFZ3TkhjQlJIVUFL?=
 =?utf-8?B?eU1kWkNXWWNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YllORGtMTkRIUHVBcWVHaHFIYmZ2T0tpY1hzMUszZHhSa29aRHc3UElnVmJC?=
 =?utf-8?B?STNNR3ptK2QvbmJOaFBnQ1ZaMkk4dlV1a2c2eVVjMVBUMTlrQVVyZ1liOGxN?=
 =?utf-8?B?cVNDWGUwOFdLdi91QjE5MHF6M0E1c01hSUdaaXBhQk91NFlCUnNtSDJ2bFJW?=
 =?utf-8?B?VU9FQVVueDFsdzFWNG9uTHhvSDZpNXNRU1U2Ynpkdk5oTVZLVEtxOFdaUENi?=
 =?utf-8?B?L2cyNUEvaXJDeTZFZGVZKy9Hblg1R0wwa1FqMUsyTFVvODlqS1Y0QjlVUStE?=
 =?utf-8?B?NWVGUEErNCtSR2JjOVd6WFpoL0JpOU9JemsrZURDKytWandYZ3FYaGVCcktj?=
 =?utf-8?B?SE5ndmVMYzRPNnYzNEtVVi9TWU43aVhZRWRmYmpUbVdiUHBJY2M0eDd0U21r?=
 =?utf-8?B?NndwVVo3bmFpMExTdnJlTWhZdjgzdUprdUxHYjlKNHVqUGZGclVPM0o1THhS?=
 =?utf-8?B?VmxDQnF2UHpUQy9sOTF1djhnb0Q0NlNKeC9TNkdwckFVMnBiVGVCR2FSK0tX?=
 =?utf-8?B?ditMTFVZK0doNk9TdmYxV2crSk5VYklsNXRFNnlUbmUzOVB4WUk3MzZScE1J?=
 =?utf-8?B?UzZ6cTBYMzZReWdOSU5SdFVXeGlHT2xoekFRMmZ3aEI1WDRpSldDODhFRnZy?=
 =?utf-8?B?blhBWktrQXVjbWFvTGs3Y3h2MituUVpPektzVjBvNysvdS94MVMwRGxzM29o?=
 =?utf-8?B?b0s3ZzJiWENESW5PcUdZOHRxSm52WUZMNzM5OGVmejluZXNDdnZZU3BDSnZI?=
 =?utf-8?B?MGx1QkNkUzlQZng1d1VOWFdWdmlQcmhIM0RQNmhUVFlkZEMvdXhvdFBhUHpl?=
 =?utf-8?B?Z1NtU1VJSXI1TDVIQnBkWHVOdS9QcmIwQlYrditvWmFmenRiWWZEc1BUZGdN?=
 =?utf-8?B?NG44bDFUV0hia2pJMDBnbThSSHNJQzhNTnI0TDQ4Qjh5eFF1UkxLVHJFaEVS?=
 =?utf-8?B?Skd3YysrREgxeWg1MW1OZTEzUTIxUW1TYUFwSVRSWW40NEdrUjFFZmVMMWJV?=
 =?utf-8?B?R25zeFk3em1pTEtmUUcxVTlvdHhZTmVhRCtFaHdkSVh5a0w1ZzVUVUQzUnNM?=
 =?utf-8?B?dG12S21qVUFPcVVPbXMyK0lCRlJubnFjczZMbkJZZWNnZURFQTkvU0JxYld2?=
 =?utf-8?B?YTN1Wk8rY1pSbjk0ZWxMc0J4QkwyMFg4RENnREUycm1SQkhSUFJsNU42a0hp?=
 =?utf-8?B?WUhUM0UxVHJmRi9XcEJVSzg2SmpuWkxXbDFUeEVKSFo0Si9mazNCak43N0h3?=
 =?utf-8?B?SUNnQi81dXlRVXpqSWFkY3A4L2JkYkFjdmJtbkRnOXZjWVNMd2RpdVhna1VR?=
 =?utf-8?B?R013OWR4SDBVMi9pZlpCb3Y3WWdVOVN1RXF5RDY0ZWdQSzRKVHA2ZWVEK050?=
 =?utf-8?B?VDdYditLeHA5b2lPWStyUzBUbk1LYU5aaDdCa3p2dk1aZmt3SmZrQ0hKVDV6?=
 =?utf-8?B?d3RSZzNtS0lwYml1YlA1QUF1WnhudHRaSU5tRU9EVXdJbnNvZm54OGlZL0ww?=
 =?utf-8?B?cDlhUnVxcUZqdGx5MHgzVC90TWFEWEJkUTkvek4xOHRqN2xIUTdMb3pXRTkz?=
 =?utf-8?B?VHYyTHhoZU43dlZVUWFXbHM0SllkRzdaZG1FTmtzcW5vdXdKUnpjSVJSOXh2?=
 =?utf-8?B?MjJ2eWYyeUx1VCs1cVU0cmc1RDNsbjlYaThiaGV1cWp0YjZ2UHYyKzdxUXNq?=
 =?utf-8?B?Nnh1M1RvV0hPU2xoUCszbDlNVUl0eitkMGZsOUhFLzJ6ZVExcVgzN09JNlBD?=
 =?utf-8?B?a2xBSDJDb3QxWjJGKy8wOVJ3b3RCQ1ZkOGs4K3VucVlNRXpiUHRqM29kTzg2?=
 =?utf-8?B?SEN4cGV2M2MyQk1FVXhqY0d5QnFaMXU1aGZvb2Q4blQzQkZ6SjBoVGNkcWZ4?=
 =?utf-8?B?K3V3T0NiVk1hbDhsV3VSdXZ0YzBndFRIZkNWTUxsYnlpN0dEeEpEczN6RUhi?=
 =?utf-8?B?cmpjdi9WUmRSOXB2bWN5a2tNL2M4TDVGbmErU3YvbmpRS21McTlXZ01na2h5?=
 =?utf-8?B?Z2xHZFAyNlR6MkMwTDVreFdxNUt2eWIwcHRBTnBkeTQzR1d4QWlUQm1SelY3?=
 =?utf-8?B?NUwza2dxVU5kWW0ybGR3Qjl1WkZKblVxdlg5U05sUWpIYTkrOFFvRGpmb0hl?=
 =?utf-8?Q?1PaRmzaoMyowf4L+JSdVIDWVL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cbc369-6368-4440-3502-08ddf43221c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:30:31.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsKW4V5NnlAUSJSvPdZjwDtGDxdHn2nCPy7FyTewXK1ma5TaO0es6Yi2AFBKXKMSnT64/aMI7KuNKs5T9DqIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7181

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
index 18ed29cfdc1133b6c254190c6092eb263366d5ac..ea93e16c5a0080f610c8cfaccc1ac68fefa481c2 100644
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


