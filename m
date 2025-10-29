Return-Path: <linux-kernel+bounces-875924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8669C1A229
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB0189007A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E13396F4;
	Wed, 29 Oct 2025 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="krXD3UFf"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75265339B4E;
	Wed, 29 Oct 2025 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739657; cv=fail; b=PI8vLx/lL0FoSD5pQqXXjz8CtmqYz0MznxTcQmxUbrJwWIMMKhxfTQ52H9vMkaCoqlQjWtBSr03pOErSOhFlMFZnDO8Wd0T1WDVQpxfblZWE+ZQ6n2nrqVGq6UoSFFt6+D3I9atFNBrtS7qISnTogLFfyq1MjxpXOShrL/T/D2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739657; c=relaxed/simple;
	bh=+867azWDR/6NzPML2fphJ6RYPVpkS4y0vQDKTfIFpQc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WQKKkkfirTuoPKsLMMm1msA1UFNlkyguB870uJn2LXCBHjXZLR5MW3ikCynpCCwzI6aS6S50jXaYcSIgplE/UpvKWU002ciMvrkEJsvMWipU/2MtrqRUfmWJ1D2LX8dw8Yp93MQ+q5eXI1CoemMHjZnONtUJjdjhlmghrQwV1Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=krXD3UFf; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNQItyPwg3pKOPYAgwz0XEmBvhW3eqhgI9Yubhh48iw+YgcHBjhHMjKAFY5W3FXXqQ5W1d2U5R6q+/A2kzsfmKz8PGzdREYcSINR2e7AyJiJrqiiObN3PhfCFUVPHVhYSjtKBRG2voQyyS3WwyCQlQFFL5/lNT6DBlUr5w5eg+vVGhb21ksWEOvBvyi/BS6PR1kqJPjSdqt9XFcvsvaG4kxKfx6nOdu+UohtGeZ5N4twDOPm2Zlo1p66kOlV1Hy+/bQU8EhDUEeheuPDstBMZa514RERs8PTiIcvPe5gxEaXjibf0jfklzPfEJKjzWHXcmq5wJXfbL9+qbz61Tv4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dff9Ob3YxpHY1novlzyOkzYPlANCUy9YLHQhO1wHXFg=;
 b=R+ZBWE6yIDV6sX4OtccOQ/zcqm9OY5sBJe30Qtmxg5mpyB0GUpoNoUiSSzXTEoroE9hO6hzhaZVsO80d3J0VaDwaK5CKum/YoaDF72uDX7STRZ7WL9CXX2GjSD8weXflEd72HPDgO6o2bvJuT3jTxJNU5bFoTp7gT1oKfKqjk9Jt9hHX8+jm5mKHhnLdKiEQWjEt053i74yJkuuxlyvAEJ81LAAMGLaMDTGuLEjSmac08niEbj3OKClRDMJzdpvFvZwSc5vw87D0g1/FImz/YoeXdWJHS9e86tMJQCWecg47k4GwjARmdpfjzSn6Dsn306huGhujDj+FBhbW3tzJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dff9Ob3YxpHY1novlzyOkzYPlANCUy9YLHQhO1wHXFg=;
 b=krXD3UFfFhXmgUwMcrpHIzHzZ0TQ2iGTNF3CZNZz3M1SV23POQ9OBpWcsKBMs3MqoxD+tKgkL8PdTUApv44ZsVqdb9D7sUi//8YjTDd062zlmVFBqCMSWRGw+O4RGNy8JOMc4AS2Y/dBcoysMlm2NjQ0mVx8T04ufjXS50WQLr04c7MXh9H7QOvdJXw5zCeBLqyXTtSwLqNqDVxCr6ZSBJmBAsfiYscKEbvXwirTYyEi7s3eZ1HKnAElbdd3btYExzGoYvCtOvmDXAxri4z9a4yKOVJGEmOoKuCYU0O/b/iQOGbdgj6T0a56Q56JkP10SQm8SXD7qQ7GeQifLgXQ9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Wed, 29 Oct
 2025 12:07:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 12:07:31 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 29 Oct 2025 20:07:02 +0800
Subject: [PATCH v3 2/2] firmware: imx: sm-misc: Dump syslog info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-sm-syslog-v3-v3-2-64e14a6e3f87@nxp.com>
References: <20251029-sm-syslog-v3-v3-0-64e14a6e3f87@nxp.com>
In-Reply-To: <20251029-sm-syslog-v3-v3-0-64e14a6e3f87@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761739635; l=2383;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+867azWDR/6NzPML2fphJ6RYPVpkS4y0vQDKTfIFpQc=;
 b=0njABjLWu/mkTTgPZ3j0EiiOteVLQVVFm54LF2UljOL1iB/TRWchba948eiJXCPcjxL5PJA8q
 0XI+G21voVoBptLu2K1sb45W1ocJTk5YmhO/rSuFOp1PjAbjmFEc71V
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa3807e-d7c2-424f-bacd-08de16e3bc59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUhMcDEvaWJRNDErM1VFaHRmWDh0U2NPWlJMd3Y3b0JYV25zNjg1UHBsbjlr?=
 =?utf-8?B?Qll2STVlTFZIUlh4WmtXcUR0dUdSckdoeFpTZmVCVE9NWTI1KzZTVys2VXRX?=
 =?utf-8?B?ajBOdmFoTG04ZW9HaElIUXZFNGxwOTdPamVIbWdiVXp4TzRtMDNRb1JvYzJX?=
 =?utf-8?B?c0FWYWZ0TnNkV2R4TG1jdytVYWpIM0JmNEI4bi9WNEU1Rmhvbmp0L1NWQlFY?=
 =?utf-8?B?WmN4WXBJcldHKzVZa3RyZW5PME5XYVZJc0FBWmwyUldXcWtzRlJBeVFVY2dD?=
 =?utf-8?B?T2xBRDc5aXpWUEtSV0hVKzdsaDg0NG5yY0dKY2dRb2dnYnRUb0twRVc0dy9k?=
 =?utf-8?B?SnphNUVPaWVJeFltZ1R1enFiaDhGTlBBdFhGemx0MTBLYnVMdlFHS0lQN0lM?=
 =?utf-8?B?TXBHTGhsdGt3UFZoNmlhWnpCR1V5dGVJa3BkZlVEbXdYWmhLZzNxVWJyczIx?=
 =?utf-8?B?cmFqMnA2K3hBQkJBWlZnQ1YvN0UxMXRJNGRTeTVwazVSUHJOUUNQcndqNHhl?=
 =?utf-8?B?Q080S1pFcjF5S2RqU2F6djZaTm5xNkxDYTlUd2tUSy8wSzNjZlRhNWF1YVVz?=
 =?utf-8?B?L3MwV2hHcnJyWlJkNWlITHVwT0dBTDJTSHJ0SG4yTGJmOXozMXdjckNIWUR2?=
 =?utf-8?B?eCtaS2pOdHMyUjBsVFNTM3dCZzJCVUI0bEE4b0JYamN3eWMvazQwMnVZbjRh?=
 =?utf-8?B?d0hCR3JvWmgzV1JxbmlySllZZTQzNnVtZG5lalhocys0bDBUc0dvc3ZPYS9m?=
 =?utf-8?B?Kzlmbmw2ZDl4SnVhTzRYSG1kOTRXK1ZEVWk0N1phZDFQUGFwY1krVUI3VlN2?=
 =?utf-8?B?SU83aXZWdWlEbjlQU0g1QzBock1XWFlYdy9iWXlIaUVKdHR6TXJqNnVzWWlG?=
 =?utf-8?B?RkJ4TWlFeVM3azhva2pTRFZTY3h5TENNMGwyN1VpZHFzdkk4TW5XS01iK2xn?=
 =?utf-8?B?RGQ1MzNlYk9ZSnBuOWJiUWRJczQ1bk9zd1ZqSFE5MERPeXZyTUt5NUZMOHkz?=
 =?utf-8?B?S0ZxdzFSOVhjZ1Z2bHI4TWlDT3NMbit5TG9FbnN2N3pNbWV0aFcvM1Q1bkNV?=
 =?utf-8?B?dzQ5M2phL1ZITGdqblhpYjJWYUlkcFJzT3duREZ1Y21VRVRhZ05wZ1EyYVdo?=
 =?utf-8?B?aGNmSjJTVGpyZHRjTUphUE1hcHBuMVdrU2JsZUlBUFljV01xMTQyOVYwaWN1?=
 =?utf-8?B?SWkrR0JBLzJMTzhac0RDZE1Kc1VkeTRJL0JxUnhvOERQTndsaWVvcTIraFFB?=
 =?utf-8?B?M0VxYUkvYXlVK3Q1SnBnNFo1SEFWc1ZtdUtpL0dlc1VZK0psdWRmcFd6YVgz?=
 =?utf-8?B?QThKOHY2UTcwZy8xVDg4bU5DbXNNN0VuditLZFpTWm94eVlIMkZlT2ZzbUVq?=
 =?utf-8?B?ZGgzTnFwUi9neHI3cThPNmpFeTNJR0h3Q3puSzhaTWcvb2kvdFRIWGE4MGMx?=
 =?utf-8?B?RVdna0JqZHlLeEhvZGxiaitWbEl0dUVUbDhma2E3czA3VlpEdXBWNk9RWDNw?=
 =?utf-8?B?SXJ2cTlkNHVTVUIwMDB3ME9xQ1duRnZvelpSME0rUXFTc0F3MWxFaEgydXBO?=
 =?utf-8?B?Y3hkNXAwLy9rZkI1UmthUGkwaGFKMXlWOWttdXRyR2NNVDZIMGJKcXhqVzJr?=
 =?utf-8?B?amdRWUFvVlFwNGpueDVCSys1ZnVmekE3QUlNZ0F4dFRYTmhuT29WUXZKbmFv?=
 =?utf-8?B?TCsrTEhaY3hRdWhYdGxTeUJaUmZmTjBZSnoyQWg1bi9nOG5HdUJoV29UMzV5?=
 =?utf-8?B?Y1Y0T0orL2xLbndoVERqREkzNWlkYk94dkpFaWNjSmFmT2ZuWHNobkhLYVBv?=
 =?utf-8?B?RFdoTHRwUDZ6ZlpYSzE0czA5R0FJc0ovWDBjaFpoUTJRVnltZFRNb1d0VGtJ?=
 =?utf-8?B?eVZqSTJoc0tVVTJPSTdvak90V1V5aEZ1UUlWQlRZcWFEcnczM3lIQk1NYThJ?=
 =?utf-8?B?S3F3K2ZLMHNkTFNrOGZHakU4OGQxK0trSW10U0VoWS9aWHJ5OEVOcmtNMmpj?=
 =?utf-8?B?cUcvS3JPQ251dXlCQW5NS2piUlZHUFNCZnRRQVhSbXk1OXliNUJ1NFV6TEtY?=
 =?utf-8?Q?rcNYRH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkZUYXhGQmZ3b3JEeXJvZk5zTU55ZkhsaXBMR0ZTcEt2SE52b2VLREZkbTdj?=
 =?utf-8?B?NGpKTWJTT3krNEd3ZHV3TUpldDhUVTNkMmsvaU9icHEwT2J0TVYwMlRTdDVP?=
 =?utf-8?B?YlFvbzlZYksvbUlCMTAxdFpscFloSmhReldZdktGY0tNSHRoV01neTNzaURS?=
 =?utf-8?B?Q3U0M1ZiYXpRZXBWVkdiVUd2amtLQS9lbjZxb00wRk4wWHJ2NUpnd1pFdDFB?=
 =?utf-8?B?V3h6NTArTStzbFdFbExFalE1YnRYT1pPRkdOVFNaUDJIOWVpeTlHS1RxMWFF?=
 =?utf-8?B?R2J5b244N1RJcGlVR0RTZW9WcXAwNTFneTYwUllGd1ZoVEg5S3FnUlZ3Wi90?=
 =?utf-8?B?UTF3TXlCZ045VHAzKzI4M0tZRkdTeTdRS0d0a2hqRTk0d0dORVVDWHZoSkJp?=
 =?utf-8?B?WGdmV01uVXlQb0d1MVU4TzV1T2RTU1h6aDN1a1ZzdzdxTTZ4SlhubjFHZ0Q1?=
 =?utf-8?B?RDNSWFdBZEgzUm5PUXR6ekQ2OGhPZmFzaDEwMUd2Q3pFOFM5NkRzdUxuMEJx?=
 =?utf-8?B?NUNrSUVGYXMxOUVCcGhrbHUvUk9lZnd5Sm4wL3BzL2FiN1NxeWxNZ1JIQ3ZY?=
 =?utf-8?B?U3RRTy9CbWtxSlVHaHhOQ25FQXljRk12Vm8xekJzRk1DSkRYTFo1bXBUdWFu?=
 =?utf-8?B?TTVBVS84N3hTTElQVDVpOEJHdEE5VzV1TFl4bXRPVlhYVkpwaVZyaXRDYnVH?=
 =?utf-8?B?MXNBM1lNNEIwSnR4QUc0ek1YeVJkcUxHNzJCK1lBSDdvaVR3YUo4cHhRaEV1?=
 =?utf-8?B?SmFCRFdVaTFxZE9NWkQzZkY5ZDlPenBTVytTek55OW55ekdPSGN4dDgzSHB1?=
 =?utf-8?B?QWhnRGNzMU1LSVZSSHhXbXZjNnVXV1J4anVEcW84eER6K05tL3VyOXpiNFJJ?=
 =?utf-8?B?WUxnUkZieUpBUjBldDE5Q0hrQW82ME5lVFZOUjVmaTJjbmUrK010Q3Q4VjFW?=
 =?utf-8?B?aUpnVG02TWJZOUxoSnVGcEZUdFBXNm50R1lmUEttVEx1NDNhL2pKVkRwSzlT?=
 =?utf-8?B?dng1eEh6TVJoL1VhcEdKM2x1a3FmZTZQVXZsRlkrY0RkZ3FQek5CaEs4RGU2?=
 =?utf-8?B?VFR5ZERVTmNVOEdZbkJHbG14aDg1ZWtXSjBLZDdwWHVIbGw3YzV2MmR4K3FC?=
 =?utf-8?B?WEtoTGFnYjA4T3p3NnZxbHU1YkhZcSthdXl3SVR1SXUxZGd4YmhZWWVoUGZx?=
 =?utf-8?B?Uk9NamY1N2pPQVBUVWdtRi9jWlBTZW9hbm1wUTNncVcwcENqUUtldFJkTmJv?=
 =?utf-8?B?Z0x5RnlFNzU1cE93YXh3T0MxZk11RUhNM2k2dEZhczBqcnUrRlViVmowTm9O?=
 =?utf-8?B?RzFZdzRKeVpoOTJyeDhXa3J0S1M0T2hDUWZXcVdGNURHSnFjVzRxaDIxRS9S?=
 =?utf-8?B?Y3YrdTVnRUw1ZTNBNDAwWjE4WGpNclg1U0h4M1NkU1hmNm0vVFhnU3RlRkFr?=
 =?utf-8?B?S0pjcndlWnRkREhyYWl1OHBtektLaXJzUllxS0hVNDc1SXd1cGkvUDdJd090?=
 =?utf-8?B?VndOTTQzREVoaER6UDJ4WjhhWENEcHgzOFN6Zmt6TmFCeDVQN0piZTErVXZQ?=
 =?utf-8?B?OHlEYmtwY0pCaU00eStyQmZHYmNDSnRiaTZqNjdtVEkvK1BxbVRSa01VT1No?=
 =?utf-8?B?YSs4c3dDQUFiQWQvaXBFcDhaUUlJTUJxMEhEeGhQWEdLczBvUEU2RGU2MmZy?=
 =?utf-8?B?WEpoaEl4ZTZMWEh1bytCUC9KMFBnQzFVYUhNYnBwM0xCdjhEMFJ5amhZdWFs?=
 =?utf-8?B?WlJTTG5lK0RsWUdHVktqYXBtSVJYYUZoRWhGenhNSEFRMnFmUEI2NjNQS2lJ?=
 =?utf-8?B?c0hHYkY1REcvTUE5Z3NVSHE4Y0x6dm1ZSkZKSUc3UlducFF3bE5nclVuNldx?=
 =?utf-8?B?QzA3RnZZYURKdWpxSWlTYWxhWEszWU83bVo0Nk50cFBJSjNhZUdHT0lhMWxx?=
 =?utf-8?B?V1JQYUJaSUd6ZXpMRSt3a2V3V2p5c1lTZFFUL2ZQK3pqUXQzdFVZRGQ5NHhm?=
 =?utf-8?B?TjZxV0F4OXRQQUxMaVZCb1BYVjZnUDkxUEdmbXBGbllhSkdnQTFEWXNaNk9s?=
 =?utf-8?B?a2dyNWxwWkpDQk9xY0Z0ckpMOGlXRlo0RnhNNXA3Nnh1elpwWlBQa3BGSVZo?=
 =?utf-8?Q?CYnHBO6Klo36HwShYeK2O1yU7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa3807e-d7c2-424f-bacd-08de16e3bc59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 12:07:30.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQOpRUXW4hFAal5n5AWU1x9fkyKRONGTcCJ9vVzc99J9n6VGjo7d1M97CPq6FWWIayMxbJEE3j8mJaR0BlXMBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708

Add debugfs interface to read System Manager syslog info

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/sm-misc.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
index fc3ee12c2be878e0285183e3381c9514a63d5142..0a8ada329c9de3c1627da241bf142fa91a8085d7 100644
--- a/drivers/firmware/imx/sm-misc.c
+++ b/drivers/firmware/imx/sm-misc.c
@@ -3,12 +3,16 @@
  * Copyright 2024 NXP
  */
 
+#include <linux/debugfs.h>
+#include <linux/device/devres.h>
 #include <linux/firmware/imx/sm.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/scmi_protocol.h>
 #include <linux/scmi_imx_protocol.h>
+#include <linux/seq_file.h>
+#include <linux/sizes.h>
 
 static const struct scmi_imx_misc_proto_ops *imx_misc_ctrl_ops;
 static struct scmi_protocol_handle *ph;
@@ -44,10 +48,38 @@ static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
 	return 0;
 }
 
+static int syslog_show(struct seq_file *file, void *priv)
+{
+	/* 4KB is large enough for syslog */
+	void *syslog __free(kfree) = kmalloc(SZ_4K, GFP_KERNEL);
+	/* syslog API use num words, not num bytes */
+	u16 size = SZ_4K / 4;
+	int ret;
+
+	if (!ph)
+		return -ENODEV;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	seq_hex_dump(file, " ", DUMP_PREFIX_NONE, 16, sizeof(u32), syslog, size * 4, false);
+	seq_putc(file, '\n');
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(syslog);
+
+static void scmi_imx_misc_put(void *p)
+{
+	debugfs_remove((struct dentry *)p);
+}
+
 static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 {
 	const struct scmi_handle *handle = sdev->handle;
 	struct device_node *np = sdev->dev.of_node;
+	struct dentry *scmi_imx_dentry;
 	u32 src_id, flags;
 	int ret, i, num;
 
@@ -98,7 +130,10 @@ static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 		}
 	}
 
-	return 0;
+	scmi_imx_dentry = debugfs_create_dir("scmi_imx", NULL);
+	debugfs_create_file("syslog", 0444, scmi_imx_dentry, &sdev->dev, &syslog_fops);
+
+	return devm_add_action_or_reset(&sdev->dev, scmi_imx_misc_put, scmi_imx_dentry);
 }
 
 static const struct scmi_device_id scmi_id_table[] = {

-- 
2.37.1


