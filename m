Return-Path: <linux-kernel+bounces-793771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AC8B3D800
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F24D3BBFBE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 03:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC96E22068A;
	Mon,  1 Sep 2025 03:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cSIyU7zv"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013052.outbound.protection.outlook.com [52.101.83.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B21FE451;
	Mon,  1 Sep 2025 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698745; cv=fail; b=WYVXks0nmft9WO+04Y9uvqTBxg0QQ2276xFyZ+8syVsh6SsrhW6/V2EbXbcvu3rX0QXwBBImYRaGMs3EVKi9FDfY/KFtj39c4e/5i6MRBW1+fjZaKrX1C0F5dOSukS6qUjUoLgHMfbHk7p2yo6UEXVd27vgmYYTU+wBeWY3KSnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698745; c=relaxed/simple;
	bh=I8dZ1Y+pdQi1FtS7fxvS86sC7Z6ORGJMrVZmOLkKcuM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TibgE/PhZeJkxJtzdGJehwHtSZAI+wY9nJMn07crYC7NFwlGOPMJl0Fjpgc4WFfjhdT3KJs6zfI5No3jSLaNrdSI7B/5C8dMABKi321Q+c/A+erCRflTJERTLUm5qruFwQHVn5KjHqPESN4X1GNaAyCujQ80PFxC/dYxwwpetUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cSIyU7zv; arc=fail smtp.client-ip=52.101.83.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PD3LKtwoqyki8Nlc1td2MAdrQDIx0j5ciinA3VH0AnnU79XYlQSlFy7i3FRCt1BzKbvLEp/FAsHLzMfU+o37BzHM+GoLJgYVpZsHKXWnrgpxuebIoegawq00iVx8q0rk3KIbBFr4MLBd9cxi3EvejeGo531hNaKs50SjnOAG11fpeoCsh00kzPywKPK5WHu08G+MPsGJcC6OUk7sBWY9cznEz7Fx+e/AoOP1KtOZeDwh3sj/fIX2WdjFRjGgh29AKqRWHZrrpGGFQtsVBM9LtuqXTcABX7cTOQhT7L2oB2/i4uQF5+4d+8AQERfe0a58vVbwKoe05Lo2YL3lfnF0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvwk3rDsTi0CUYTRWDKTxNknuMe7upJNcwuegNGFoNk=;
 b=hh/yHjtCrTV/Z6Bbd1LO1vyDxQcMLH6UcQEwZyOvrbnJF8T7xSjWD4Z9rFcJgecdoYzxvLNIGX3QBRGndfBqv9uwaUcFOz28sAn7bjROVv+3ZlR4PdvWyKYaG2dCLKyMnkJdRFsruCTZkdDpzuZ/uB7OP8tWAbsAi+A1KJ/AzpbW1pNcctVlhZeIQrRcJK5AW3ZiDBBfZDLN9c+DeTfUiMCMliWh9WeFebgaEGMGsdms19KTZNpCKE9gyjzf25DZzwQ5gi9FryGbDkKKuTdcvhVtvcjQJARe2uR1xXuj+sL8rNcDjKZkZNYzgZqDYjJ/lQJrs8e5naehIW9IcnBMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvwk3rDsTi0CUYTRWDKTxNknuMe7upJNcwuegNGFoNk=;
 b=cSIyU7zvRlpgBEfv+G+SP+rA1M7FE9YD0pUoz8K0gm3bfuEeRSF9F219DVooZernwRArXSlVJOEbFSbmg8qtcuPX1gRM1EmGsvFayqxkbEBGW9FwNj6hPcT6w2aUkmnTEKbbsvVKOEhsfSWP4qlu1chCcvo97t0LSUKWINEgBX3BsH4zQeLUkG0yfW3B8ybMlOEsh2GMXjCSnEBMEkMAvpg6g4lWviDH2E6rENG0o9YZMLTwOiEg5/O3KF8DwvylJvW8KJmOaxcrWWR7Kjh6tsGe/UMIoyhCPjNoQcsojeCg/M1xD/tHPJ/Pd+J3YboMbnPzKC9J43GqUiE7POJFmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10355.eurprd04.prod.outlook.com (2603:10a6:150:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Mon, 1 Sep
 2025 03:52:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:52:17 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 01 Sep 2025 11:51:47 +0800
Subject: [PATCH v2 3/3] clk: scmi: Support Spread Spectrum for NXP i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-clk-ssc-version1-v2-3-1d0a486dffe6@nxp.com>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
In-Reply-To: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: Brian Masney <bmasney@redhat.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756698713; l=6023;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=I8dZ1Y+pdQi1FtS7fxvS86sC7Z6ORGJMrVZmOLkKcuM=;
 b=9IGD9jPlkBwjNzCcvXNFMhl4k/mWW/2KBbP8C6qEavPq8L1/c3whQRJ2NmgsFTFadeZp5BUew
 1CWRs7VlFxNCpybDzQyl25QgkgZNT6TiT7eCmmViIXI8NjxkymngFcA
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10355:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d57a72-5cb0-4929-a02c-08dde90af1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXA1UW9zd3FEZS85SE00MzNaTFNHZzVMalBobVZDSWppNnBROTUzU1VXVER2?=
 =?utf-8?B?VkFwcHk2VTl4MUQ3Z3pvZDFGVHIwcVp5ZzhUdG5mOVJnRXg0TFJES2x2dkpu?=
 =?utf-8?B?UGU0d09wY3liNG9VU1h1ek1GYTNQWldMOHBGQjFhbXhOenhqN3ZOMitpTFgx?=
 =?utf-8?B?SWtJMERSd2g3Y01lclF1cXJHeUJDaG1Zdnh5dFFYOUVXSytOcG9MUzcrZEZq?=
 =?utf-8?B?MnlldWpKOHR0U1kwVC9KTnIyOTgwKzF3TksvV2FIdnNPaUovaXhkYkV3SGNh?=
 =?utf-8?B?RCtLK2wwUEU4VEkzdUhLQzREdEpOZ1NWYTcxY1VldnNqL1AxbFZNQnpxa205?=
 =?utf-8?B?RWo2cmhPSDQzMit5K1pwZURYT0ZnbmYydUdpQjAzb2tva1puSDArbEtuMmll?=
 =?utf-8?B?MjZLTHJYQzhvUm1Tb3ZYUWxHbTBhU2I2VnF6bDR5SFVmTWUwMVFFQzJ6SVRO?=
 =?utf-8?B?RHZxVFNDdXJIOHJsNHJwYkZKNWNRcFc4MkJMNzE2c2ZOUzJ6SlY0MHZuTjcz?=
 =?utf-8?B?czB2Z1pTSzRCNUNKS25mcFllWlRYS0NySVhVWGpMUGo1dVh3WXBrNGlINy9C?=
 =?utf-8?B?Slh5T0tJMHArVkRqNDhOUzRxSFBSMzFWOU9OSEtpSjVESVlaUU1KdHg0SWFr?=
 =?utf-8?B?c1k5Yld1ZFpuZG5TMTdGT1I2NU91amNWZ0JrL2JVK0M0eGFuQ3p1SDhYcHR5?=
 =?utf-8?B?WUE3aVBmZXRCR2N3Mml2NXEvVlRvQURGak1XSEl6N25jUEQyRFVPb2ZiWVZY?=
 =?utf-8?B?QldsWXNqT2lGWWtEUFRKUFVpdzc0R0RpZmlHeUNHcmtXYlVlS29odSt0eVZC?=
 =?utf-8?B?YUthQ1MzODIxVWh2NXVpeTJDZGlBa2c1QUZLU3BQQVowMGkweUlYWUdEVCts?=
 =?utf-8?B?NnJEeERCREorYWdkNDlBajNNbmFhRUNRZndublhHYTFCdFBWZHludHZTUzNN?=
 =?utf-8?B?TDVZK0RRS2w5aUV0bUtsK3ZzWVNaOEhLTk9DTWJtTm9rdVZpNm90VEhZZ1FD?=
 =?utf-8?B?Q1M1MzBuVU9rZC9JbmU1N1VyUmdDVDRjZHNwUE9LVGlWZ244VW9mbkZrdS9n?=
 =?utf-8?B?aFdqVGJYdmhETnFtdDFVYTFScFVuM3VHVGRVNnFGL1NHTmJSQnMrdWRSbHU1?=
 =?utf-8?B?bmxpSWdsTHh6U0pING1GMUNHQjNIT3pjbjJBSG9rTDNGc2hteDFVdHZrdmlx?=
 =?utf-8?B?Y1BtUGR3TTRlQVJuNlJXNmdobjlocEdqZTV2RkZoc2tYeHZsa3ZRRnFINVVR?=
 =?utf-8?B?T0ZITGdvR1JmelZmZTRDZ1RXbHNYcUtGc0YzSTN4bmJDaU5MUWlVWXNHMVB2?=
 =?utf-8?B?NWVWVmQwY3hwZjFoeGJvaWpGV1lBL1FQMFdXY3ZCWGhXUm5sckt2WnpiVk80?=
 =?utf-8?B?enJTQUxsZnFxQTVtWUtvdS9BMXoxc2I4ZlQrczhCRTJoYThrSE85UGxpY0FO?=
 =?utf-8?B?SVJxZG9vUS91allyL29OT3QxeGhzRm5odkZjMjhuSzZGM1ZnREZtMWFGbWk4?=
 =?utf-8?B?dTZ0MjN6RnNuSnpUL28xelAzOUdtMHdmVFJtUFNpTUQyQnZxWFgxN0JsYkZr?=
 =?utf-8?B?MWhwbmlvMXc4c2JjMW1lM2J2Q292cHRKN1UyenRKeUxZK0JFWkJyTFh3TTFu?=
 =?utf-8?B?aStvbmdiTVVVc0NuN1BmUXVEUWV3VktQczdPNlY1d2E4VUY4T1JBK0plU0lJ?=
 =?utf-8?B?cG9jNGNQUksvYk1QRk9TTVloYUgzMXc2clcrVjRTMi9sWjRqWHVHbUdUckV5?=
 =?utf-8?B?ZWl2d0Qwc2E4OTZWWXVuc3I3ME4zV1h0UW5wWnpsV0lNL1VQTUtwOTdWYTI2?=
 =?utf-8?B?dVNNandtQ21uUVB2cFRRWGcxUHFQT3YveER4aU5aNjVTMVhMOU16US9nV3Ju?=
 =?utf-8?B?LzZXNDFLdUJtVU9jVVZGTWdNTlUzUUMxZjE2ZldicTNzRzMycFgvV2QybWtv?=
 =?utf-8?B?bE5MK3krOWtCUzJ2anhkRzFVV0h6ejFSQnNoTUlDaXZNekxrbFUyMWdXNzJ2?=
 =?utf-8?B?MTVwMkdMOG9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkpKYUtaUDlqNzlHYjlNSk4zOG1PamhFZng2UmNJbUs4TUl3RnhkbzBzelJQ?=
 =?utf-8?B?RnZMUk1iTjJyT05BbjA2OTZjUlkvVFhza29NSTNlbkpHNUIzcW5KRGVQYm5D?=
 =?utf-8?B?a0VUelNuVjhQTnFoU2M3OXFqc01tT2Z0Zmw3UXlHNms3L2ZrdUtNbmdjdXFS?=
 =?utf-8?B?RzVKcUlyYWRKZ1lqZU40dnkrNDRKSTIxMUhzVlpzYWJQUElTckwyT2NSSVBo?=
 =?utf-8?B?N2xVSnBHSTNOTXBxai9ZUkhNOTZ3ZklXM3Q3OW1HbkNma05CMkM1Q3ZUbWRI?=
 =?utf-8?B?RFVDMUlzZ3huT0lZZ1R2QkZvSHN1aVhtWitScjZuL0xOV28rQnFpb3BGbWxv?=
 =?utf-8?B?Nk9ZNEtDeGEzY3FkYzlabkJvUUk5NUJLL0JteEp3UmpIOHByTThhYnpJOUJk?=
 =?utf-8?B?S0h4ZCtwOWZJUFQzMlZwUTIvazRQM2Z0R0o2RzJsL25FRmlUWVpNVjdhdEFx?=
 =?utf-8?B?NkJQNmdEQTZTaTN1b2VaM1ZLRVhvamZ2bzNNWklZTWZDbmFlU3pZQlVjRDZY?=
 =?utf-8?B?ZGJjSGhXOGQ1Q3ZrVnZJUHp3QVJyei9ZSzZMc3lObitKMXkycmRiQzBUSUls?=
 =?utf-8?B?SXQ5aHh3cVh1Nk1ZNjJuejRSYWhyOFppUUZucUdTWVBOSi9rNXJPUjAxVmtv?=
 =?utf-8?B?cHdObldYYjVSckJCN0U5cDhUM2pEaExkN2FNekh6aUx0VEZsdk1MaWkyOHdR?=
 =?utf-8?B?bUxDUlZjM1NWMDBRVmxhNk1LeGdSNUdqT3Jod3FVNURoWWVYQjdNa2FhNFBo?=
 =?utf-8?B?eWw4TUZWMkpzYTc1enM3K2RwZ2J4bkNDMmtzK0FpZm9HZmdoUDZ5Ym9pekdw?=
 =?utf-8?B?Y0l0Y1hQSzNubFlwbE03MXlLd0FEZUFoUEczMFZVVmZ3L1RoRTFrRjhlUGZo?=
 =?utf-8?B?bmZ5M3N5bkdoVUNzMHBsbHJpV1FtVEs4NXhtMGV5d0dqMTVYaisxcDQ0TTlz?=
 =?utf-8?B?Z0hTNkJqSzdxanRKQkhUbWwzMWw4RXNJM290eDN6V2NIUWNxN1BmOXp1YWRi?=
 =?utf-8?B?TXhxNHNLNXhGMm1Nd2lwUjV2d1hrZ1FCYmRMd2loNXdlV1R1WmV5SkNJK0Zy?=
 =?utf-8?B?T0c3dnFvNFR1TUlVOUQ0YklPbTdaWk94OG9nR0hsNVByLzlJQkhUT2Ziblg0?=
 =?utf-8?B?RWdPMWJueGF4SkN6OERjeW0yd0J2cXpEVEE0ekRrdFE5M3pmamRIK25UWFI1?=
 =?utf-8?B?RVI5aU9TaXRIbUlQYVFLV3d3NjIrL3M2TExyS3FkZXFyV0hvL3pqa2NBNHV3?=
 =?utf-8?B?VUFqdS9rLzFUdEFvSkQzQi9JdXV5QUNuSEoxa2RtdXYwUGVWSFdQdmFnZDhF?=
 =?utf-8?B?ZXdsbmt5ZkxLbXpvajgzUUF2NEFjVldUeTk4RlorUjNjVlVzck0vUys2cDVv?=
 =?utf-8?B?ZlBPVXZxRjlRMjBET2o5dFpvYWRZQlVhelU2TEFtdWtZeDNFM2ozVjZIZ3ZZ?=
 =?utf-8?B?Ri9WL05NeUZqMWtRdTU5dDJzTHhIZzFXeWhaRG5SOFBFak5ERGM0dEJBZzRP?=
 =?utf-8?B?OEI4Vzd6aVgzdjQ2cU4wNVdLSHY5TEhYajVCY0NydVZhd240Y283blp0OFNt?=
 =?utf-8?B?YUxYTEJ1RjM1T0R4TG8reEg2SFhrY2VSOFp5d25zNDcyUFk1akhoL1ZxRXNE?=
 =?utf-8?B?T1FWeWJORjZBZE9HOFF2UE9SV29LS3lEcGFjbkc3elB5Y2FQSzVObUI0dVY1?=
 =?utf-8?B?K1dVcHhBazZMMm5tSnV3d01HSWhEWmtzUDBZUnBENTFVRlVlM0VOWmpPbXhi?=
 =?utf-8?B?YlR3VGE5Z1licS9MMjB3eXlRWVhpRjFybEMrUWFGUnExSWt6WmovQ0Q1ZjZn?=
 =?utf-8?B?YWV0azV3SVIzeS9MYUpjZldOTHVabXA1Z3pnS0YyUjM5enlwRVQ4bm82ZWFV?=
 =?utf-8?B?bVU4RGQ4cndMMXF6T2JvcmRUckE4SlltRFNmZGgyWDV3TGlqZjQvWVVCVG5Y?=
 =?utf-8?B?L2JCdlZYcENOMklDTmU2b2RwS1VKTTNidGpYQTFYUjZkSitMbGU3aE9ld3Vm?=
 =?utf-8?B?NHNvaGltaVNYcS9oM3Q1N3IxNjBZZElUYm9oQWxhVnJ4eUZqdWdkM0lZZjFx?=
 =?utf-8?B?OHVKZUxiU28zTFVNbEo2Z1ZBLzhpck13M2k3NUM0dXk4VnUrVmt1OUlabW1q?=
 =?utf-8?Q?lQMZv+ov0rzZYjgEZcInWbD1N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d57a72-5cb0-4929-a02c-08dde90af1a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:52:17.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xccw9ZZvYLHrQltvC3qLS1jmBenoy4HsrwC40ZgoQKNlYV+SZVPRsYQ5L/wLWqXfKc9RKqWFDpKrcS77cMmaIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10355

The PLL clocks on NXP i.MX95 SoCs support Spread Spectrum (SS).
This patch introduces scmi_clk_imx_set_spread_spectrum to pass SS
configuration to the SCMI firmware, which handles the actual
implementation.

To ensure this feature is only enabled on NXP platforms,
scmi_clk_imx_extended_config_oem is added. Since SS is only applicable
to PLL clocks, config_oem_get is used to verify SS support for a given
clock.

i.MX95 SCMI firmware Spread Spectrum extConfigValue definition is as
below, no modulation method because firmware forces to use down spread.
	 extConfigValue[7:0]   - spread percentage (%)
	 extConfigValue[23:8]  - Modulation Frequency (KHz)
	 extConfigValue[24]    - Enable/Disable
	 extConfigValue[31:25] - Reserved

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-scmi.c        | 64 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/scmi_protocol.h |  5 ++++
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index d2408403283fc72f0cf902e65f4c08bcbc7b4b0b..bb5e20dab18e92932ab4b99192b496e0c4d96417 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
 #include <asm/div64.h>
 
 #define NOT_ATOMIC	false
@@ -23,6 +24,7 @@ enum scmi_clk_feats {
 	SCMI_CLK_RATE_CTRL_SUPPORTED,
 	SCMI_CLK_PARENT_CTRL_SUPPORTED,
 	SCMI_CLK_DUTY_CYCLE_SUPPORTED,
+	SCMI_CLK_IMX_SSC_SUPPORTED,
 	SCMI_CLK_FEATS_COUNT
 };
 
@@ -98,6 +100,35 @@ static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
 	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
 }
 
+static int scmi_clk_imx_set_spread_spectrum(struct clk_hw *hw,
+					    struct clk_spread_spectrum *clk_ss)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+	int ret;
+	u32 val;
+
+	/*
+	 * extConfigValue[7:0]   - spread percentage (%)
+	 * extConfigValue[23:8]  - Modulation Frequency
+	 * extConfigValue[24]    - Enable/Disable
+	 * extConfigValue[31:25] - Reserved
+	 */
+	val = FIELD_PREP(SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK, clk_ss->spread_bp / 10000);
+	val |= FIELD_PREP(SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK, clk_ss->modfreq_hz);
+	if (clk_ss->method != CLK_SSC_NO_SPREAD)
+		val |= SCMI_CLOCK_IMX_SS_ENABLE_MASK;
+	ret = scmi_proto_clk_ops->config_oem_set(clk->ph, clk->id,
+						 SCMI_CLOCK_CFG_IMX_SSC,
+						 val, false);
+	if (ret)
+		dev_warn(clk->dev,
+			 "Failed to set spread spectrum(%u,%u,%u) for clock ID %d\n",
+			 clk_ss->modfreq_hz, clk_ss->spread_bp, clk_ss->method,
+			 clk->id);
+
+	return ret;
+}
+
 static u8 scmi_clk_get_parent(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
@@ -316,11 +347,33 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 		ops->set_duty_cycle = scmi_clk_set_duty_cycle;
 	}
 
+	if (feats_key & BIT(SCMI_CLK_IMX_SSC_SUPPORTED))
+		ops->set_spread_spectrum = scmi_clk_imx_set_spread_spectrum;
+
 	return ops;
 }
 
+static void scmi_clk_imx_extended_config_oem(const struct scmi_handle *handle,
+					     struct scmi_clk *sclk,
+					     unsigned int *feats_key)
+{
+	int ret;
+	u32 val;
+
+	if (strcmp(handle->version->vendor_id, SCMI_IMX_VENDOR) ||
+	    strcmp(handle->version->sub_vendor_id, SCMI_IMX_SUBVENDOR))
+		return;
+
+	ret = scmi_proto_clk_ops->config_oem_get(sclk->ph, sclk->id,
+						 SCMI_CLOCK_CFG_IMX_SSC,
+						 &val, NULL, false);
+	if (!ret)
+		*feats_key |= BIT(SCMI_CLK_IMX_SSC_SUPPORTED);
+}
+
 /**
  * scmi_clk_ops_select() - Select a proper set of clock operations
+ * @handle: A reference to an SCMI entity
  * @sclk: A reference to an SCMI clock descriptor
  * @atomic_capable: A flag to indicate if atomic mode is supported by the
  *		    transport
@@ -345,8 +398,8 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
  *	   NULL otherwise.
  */
 static const struct clk_ops *
-scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
-		    unsigned int atomic_threshold_us,
+scmi_clk_ops_select(const struct scmi_handle *handle, struct scmi_clk *sclk,
+		    bool atomic_capable, unsigned int atomic_threshold_us,
 		    const struct clk_ops **clk_ops_db, size_t db_size)
 {
 	const struct scmi_clock_info *ci = sclk->info;
@@ -370,9 +423,12 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	if (!ci->parent_ctrl_forbidden)
 		feats_key |= BIT(SCMI_CLK_PARENT_CTRL_SUPPORTED);
 
-	if (ci->extended_config)
+	if (ci->extended_config) {
 		feats_key |= BIT(SCMI_CLK_DUTY_CYCLE_SUPPORTED);
 
+		scmi_clk_imx_extended_config_oem(handle, sclk, &feats_key);
+	}
+
 	if (WARN_ON(feats_key >= db_size))
 		return NULL;
 
@@ -459,7 +515,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		 * to avoid sharing the devm_ allocated clk_ops between multiple
 		 * SCMI clk driver instances.
 		 */
-		scmi_ops = scmi_clk_ops_select(sclk, transport_is_atomic,
+		scmi_ops = scmi_clk_ops_select(handle, sclk, transport_is_atomic,
 					       atomic_threshold_us,
 					       scmi_clk_ops_db,
 					       ARRAY_SIZE(scmi_clk_ops_db));
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 688466a0e816247d24704f7ba109667a14226b67..6f9f197ee671540e38470a5666eb5ba8ec9de439 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -80,9 +80,14 @@ enum scmi_clock_oem_config {
 	SCMI_CLOCK_CFG_DUTY_CYCLE = 0x1,
 	SCMI_CLOCK_CFG_PHASE,
 	SCMI_CLOCK_CFG_OEM_START = 0x80,
+	SCMI_CLOCK_CFG_IMX_SSC = 0x80,
 	SCMI_CLOCK_CFG_OEM_END = 0xFF,
 };
 
+#define SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK	GENMASK(7, 0)
+#define SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK		GENMASK(23, 8)
+#define SCMI_CLOCK_IMX_SS_ENABLE_MASK		BIT(24)
+
 /**
  * struct scmi_clk_proto_ops - represents the various operations provided
  *	by SCMI Clock Protocol

-- 
2.37.1


