Return-Path: <linux-kernel+bounces-774478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A7DB2B2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDAD1BA3623
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C821CC4F;
	Mon, 18 Aug 2025 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aZl0xUgx"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E7216E24;
	Mon, 18 Aug 2025 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550123; cv=fail; b=Lvk0QTyOa0M6k4lfUKiQsePTSj+FOPD/rFEyxdRXiWnn2CS1hAiwumHIUxxah1u9ORBydYVLlPI4m7YGQefezMN7j7vq8M7FOfM8WQ3sV7RjPzjv8zslGWwVI5CqJGwrSEFHRmBMWy1wi0FEt1jxKIF9OobpS1V3tzGLYM5rXrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550123; c=relaxed/simple;
	bh=PVbx5s5b+1NnuW5ceIfqVH0vFtSzbQ8pPGk3pf8Eo3o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FYLZWgEXV7U9JT0hwqQqMAVGuQwlhbiVvVKKpHrGr0+Hi4MqeAz22s8V2nh2xnBND9QBV9u1uKAj3cWUc9eXxr39993XpA4YPKV0H/Sqn7ZuxDUd7D6zJerad6QafS8F5Uu1Gb57h3HYtscttL/QtqcDh+QSI1zifqSGHWVlfoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aZl0xUgx; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBtWeEXYE2myty078cskF2yqNBbmDtwNTdHARy7Tl/VUcktmMgfAFfZWVpR2vKBHt0GL69JvSS7+7yhvMSPYRVhnNCFmQCa6oxDTmkyww+F2XBaaqV+bwcESehT5AH9o7iyDgqu7vnmeZ8hEfr9Uby346JVsYIU6RMITt4yXcT8nBWCZDyvAB2qunV4PSTISqVJTEhcqai1MNJuybvlcEjrrdQlaL7SytuoYFGDQsrzABmjWCwnUOhv7Nk4fq5dDL7gvquIxs6SBSuVGQUBgrHbh8h2G5WCHvY2+WE+HQQDgkAnkZn4/ir4+9wt8BTrg8zgzmqKnm2QeIrR7QWFIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFK72VGdZHXTN70v2JLnPiYmVG+C7Q22yN7yAD3WW6c=;
 b=X22yEaqC61JAKVEUzI4Og5UB6Bykc7HuQa2VKcM2YVMfhaF726n5cKt/ET//TdtDD1ORrUljaw54GGPUb6kmPvB0+H8B1q0A25o25PBKhWEcjPF2LawGqja8kXrm2dBiAGL72krB6AcZObO6THr2BPw/hZ30h61quskZ3qMerP+hK7GInew//Wq5yYz+RaMF+uf9Du7D2reR9x/hYmv3NzZVHwHNyhjmobe46rTsER9P+ucVjkfkZ0bixWkwZegGXkEiZupnJEBLtPvkvrjhOT4w2FOrAqr19KYHWJeuZ7UtGkr5xq0plcU/Qj/5aki8rWg6Zxgcq71TELYLVwV8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFK72VGdZHXTN70v2JLnPiYmVG+C7Q22yN7yAD3WW6c=;
 b=aZl0xUgxWgwfpnJ03+WFk6vvas7KwOQ3TcHfXctXPIGKVC2gc1kYkibCDHIifGibZNX4pE1coVWAYWGCrSme31Cq+7ZQhecKYNuyCX8Qc3nkma0pv8iSOUCFTH7fkvlnqhLknQQnIL2NMcaPS4EPUuSaDmKbp7gTBnj+Oih5khfr6UAne/gD3bK8SnsJFg5shsqgH1YOWslmoXU3ANVmxAm9OqrFA/kHnYSU60TWoizgbqOd555wcG81J76UjurjEY9sc/pCdhwKyOWMpbQHSJlBE1sR/MTwoS0eKc81qZ6yIwO0H0SdENK7HLKiakQP5d5hHQNiofaUoGqDmNc7RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:16 -0400
Subject: [PATCH 05/15] ARM: dts: ls1021a: Rename node name nor to flash
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-5-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=1511;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PVbx5s5b+1NnuW5ceIfqVH0vFtSzbQ8pPGk3pf8Eo3o=;
 b=uK249Ui87bxmRG2vAi6LCssQrKl33SCTztoDsjol9INl6x0mGPVzsI8g2cEs6mAIS0Wvf18s1
 tmGS7CYv9coB3vpWG9VSzQpfMucE+cB0fOV/gIc8MiCyDcHhn57pYsL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ca785d-9b1a-426e-3ad8-08ddde989b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cldsVjhzWk40RmI5UHgrTXNwTmp0NEFMN3pDOFNRVW9HTnJUVmVnZzlLMWxr?=
 =?utf-8?B?SEVqbUg3ZXZHS0t2UFRweXlmQXpaaFZmNEp5Tm5JeVlqbG0yaDN5b2lybis5?=
 =?utf-8?B?a2xXZVUvcklSM2ZtZ1dic2lWRlNDZ1BwTXJZR1hsUEMxT2J4aU9MZUdjYlEz?=
 =?utf-8?B?OVcxVlFuTTRLMytPQ3E4VzNOQmZ6LzVrRjBwMXZ4MzgzZ0xmVVNPUDNjNUE4?=
 =?utf-8?B?YmthenpvNmNRQ05zbnM5cmE4OThCU1lucGlTMUlKUXRhdW5LSVdRR3kwWXR3?=
 =?utf-8?B?MjR5T2NUcXI5NmlkdG9MU08rSWFyOUQxSlJIdUpPNkpLUmZnN3AzdDlwclVv?=
 =?utf-8?B?emhmSXFqa0NPeFROR3RJMW0zSk43VVVtOWh2M1pDT00zUytzSU4yK1habUNt?=
 =?utf-8?B?eFdISHEwMUxhRjRycitQNVZaWGJQMFlzWjVUdDZ6ZnZaYnRDZ00ydm5GWGdT?=
 =?utf-8?B?dTJSV24wblU1bzZrNE81dWZkRXg1ZFBVKytFZEFGbmdJTkNpNkx4T0pBMWVK?=
 =?utf-8?B?WjJaV2txcUh0ZjVJVGxnV2VZdXF2bHNZVjI3MlpPdlZKTUJ4by9nVTk4T09S?=
 =?utf-8?B?Skh6OWIrZWJCdVBuMENXZ2lXVGFaUkFrTlcwV1NSUThJN3doalhTWmxhTE9k?=
 =?utf-8?B?ZE5ZUzFkRUJ1K2o2L3ZiaGRUUUtLVTRjOVpTVXZhdHFsK2pvNEVtZXNNNSsw?=
 =?utf-8?B?ZkhoUDQzaVhjYUYxQjdCalVpUzUxNEs1cDk2cGw0d3V0TWJ5RlppSitRUDdv?=
 =?utf-8?B?eXVHRWFKbVJkVDNLb3FreDBiRnZQS2xOMW9DWXphUHFTWXdPLzVvYkhna3Z0?=
 =?utf-8?B?VlJTQzhhV0ZaNTJ3SWRVNS9ZTHB2U3p5eUNMMG56R0hlV0xEbzhrNmY5dGtB?=
 =?utf-8?B?Y1BiZG9BRFR3T0RMd2NHZlhiajhEOHZhSmY0UXFsMHM1L3pWa0h0ZTh5Y1A1?=
 =?utf-8?B?Z25VZzVTdjlHUFZHOVI4K0N0akE1aDRNQ0l6Y0Vjdmp6clNOVWZMU0VRRytS?=
 =?utf-8?B?akcrR3JmMUZjZUN2bTJRRmRMSFZxSVh0Mm5pNGg0YklGeHlmdDJqSCswZHlD?=
 =?utf-8?B?ck5RRUV3ZGlyTG82UVRDRXlmS09ETzMvZjJvbGhMeUFla0RoOWo5TTV4Zklv?=
 =?utf-8?B?aEtuSk5wU096L3BySnYraEs4UnMxTXpJYTVuODIyWExtWGk2LzJSVmR4M1lm?=
 =?utf-8?B?MmgxL3I0d0tLTGQ2RFlrMEJyUDRGZUhNMFJZK2Q2Um1XV252aG5POEhnV0Uz?=
 =?utf-8?B?N0ZPL0NQWlNxZi96ZWlwQTZVcmt4eXlubFh4WlRITER0MGZnUVBIbDdrU2Vt?=
 =?utf-8?B?QlpLQmVNVnJaNUoySXJNV3hpR014a3Y4NzhHRDQ1Rk5GSm1ZYlZpdWxSbVZ4?=
 =?utf-8?B?Zk84SFRJekRDSnoydFJNSmxnRnNON3AweDFMQkQ5enIzMVVmVStLM2srZnJS?=
 =?utf-8?B?dStXdFJDNDI3Uy80UzJTUXViSHJmYndWS3d0UkphTkF4a2RaQy8yS0VVOVBI?=
 =?utf-8?B?M2lZc0c0WjNYNE1rUzZ5SHFBU2pqYThoTE5QSDlaOW9sUmRVekh0QktsWlVt?=
 =?utf-8?B?N1FEOEdoeDVzUytCeU5SaGZPYjQ2U01ZVEI4TzRZWm1aWnpYY3daZkh2Y1VF?=
 =?utf-8?B?Y1pjVytHK0lVVlFHNitlQzhaUzdsOWJXL1M0aXFobnNYOTJHeEYrNi9qYXFj?=
 =?utf-8?B?Q1V2YXhsR0VVNWEwSlh1cm9uZitUOHA2WU1KbkhGNml3eGI0UU5Dd1R5SE9K?=
 =?utf-8?B?Y1Y2YUxLNVJFSkZlUkZaQXgzYlVQSDh3eHdDRGRxbHl0dEQ3eEVRZlF0c3JJ?=
 =?utf-8?B?dk5HcW0yQks3TTZ2eFVrSnB2SkRWbkNhMk5OUzdKcVJobWJScGx0OVhkYmhZ?=
 =?utf-8?B?V3ZkRXJHRDNuRFFrMCtpWW5RWnhoVVB4cWhwS1ppY05FeWNKMjRmQ3hQd0dF?=
 =?utf-8?B?QUM0bFJuRXl6UUhaeEZvYXZTM3R2U3B0QTNqbk0ySXczZkdEV256alFjeXRy?=
 =?utf-8?B?TWpNQWtXUnR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVpGZG11ZXc2MFdRNFlTUU5SVHgrMFBhMDNYbElneXVLK2VkYjJGV3U5N01V?=
 =?utf-8?B?SWFIa0dLZTdweDNIWlY4eVFLaSsvRmZqOE13TlNVYVJRSDc2RUowY0NlVEsy?=
 =?utf-8?B?akh0Y2txNU9VM3U3T0MybVlxNFkrM1p3amRmR1B5U0VyYTVadlpsTUxWMnZM?=
 =?utf-8?B?OWRiZkdQWUFmd3hxdGg1MlkxRUF5c09MK2t3M3pCdWFTS2wvWFZOV1RudEcx?=
 =?utf-8?B?RVlWK0VLWHcwdHoyandyazJRQWl2OVZPSzByUklZYVhYcWNPUjBtNHpvbkwv?=
 =?utf-8?B?NUVOZWhTS2libFcrSjY5WkViUzU3UFFwUUcxeUNqQm9oampXUjlwR0gzd01J?=
 =?utf-8?B?QktXWWJEcTVSQjdaU0RKRVU4QzRmT0diM21YcnFGUHMrTDZxaCtQNzBlWmlB?=
 =?utf-8?B?cS82UFVtZFhQT3AwQ1BQdGZXb3FtZmxnaWxISUNKU1M0STlqZ0JWR1BEUHd6?=
 =?utf-8?B?OGRJUmFsVU41aDdRS0VaeWtTdEVrNStGaDgrbHNDS3hET2RGZU9tNWV1eFcz?=
 =?utf-8?B?N0VsMTVIS2hQVDA4WXhWWXdWUnA5V2xhdHp2V2lTeUNyYUltZ2NUTWdEYXRZ?=
 =?utf-8?B?Q3RUK3AxSnJRa09LdGV3ajBtdmdDcWl0bUVnOHIwbkI0QXJQUmxkUnRIamJq?=
 =?utf-8?B?bjNyejhMNkVFZ0Yxak1UbHBxVi9SZk45V0N6SWJkUWlnM1lBQyt1bzNvNFVh?=
 =?utf-8?B?cHJKbDNyRHcxRUJqaituZ09BRnJnc0RKQTlENUt0Sm5qTGZ1aExDWlQvL0ho?=
 =?utf-8?B?K2h1U3JUS3AydE1CbjcwbmN2SFVmc0RIL3gxSjN0eWVhZG83d25jN2VnL2ta?=
 =?utf-8?B?L3ZjMDhHNWwrSEI0Sld5dWVwVUVpU0JlT3pBTTZ2T1UyVTNWKysrbE9rUXFj?=
 =?utf-8?B?YnJMcTh1Rmh0WjhDaEVzamZzN1RYQnJLMURSeDRLUlB6S21YbTAvSkF2c3VP?=
 =?utf-8?B?d1hvTjBhZU5sU1Zhdm1TamRBeGxLKzRJTTFoN0EyQThRNDUwbndOTWcveFVD?=
 =?utf-8?B?ZmtMVGRCRWJ4K3B1WnpTU1RDZVc5R0RvN1dOakJ6c0ZzTFp0Q3hvcmZIRWFK?=
 =?utf-8?B?M2NFNXN0b1VZQmRybUFGT29JZ1BMZnNhNXpUWlVwWk1BV2N4UjQxS2RRY05Q?=
 =?utf-8?B?TkQ4b2p5cjh3Q0VQTElHL3BqL05wams3NlJkcEk5bnFkY2FBQnhXLzNQMUxD?=
 =?utf-8?B?ejFUTmFCWThOU0lzUzBhdUE0ci9VNk92MytkQVlxak13YXZPeFlhYmduVGZY?=
 =?utf-8?B?YkdmbGRWa29MR3owZUhmQWcwdURIOURyWXFTbWx5bXNUcUE2UnZ6Wk9yZ2hX?=
 =?utf-8?B?cDY0VUwwcjJZcDRxSFlLeEVGMDRYUlRDU2xGMEJCZjBGaWEzWlJJL3RoQkc1?=
 =?utf-8?B?ek1hK0JwZEtDUDBOUklsT1BJQ1IwaVdjSDdFemd5M1pGRlg0Q043aWFSTWN0?=
 =?utf-8?B?czhNMHhXZ3JQN2hXS1czMWFtM0h6K2JUd3JENmVYN2lpSTFIS0RCY3BXWXdI?=
 =?utf-8?B?Z3h4UEozdThVSFg3UlJHNXcxM04zcFdaSlpNT0ZYUUw2T0Y2c2JoUVh5RDlZ?=
 =?utf-8?B?TEsrVGxVZG5TY291NHIwZ2J2eVRkVWxnUnZDMFAveGdGeklYek9tWnJJSkZX?=
 =?utf-8?B?ZExyTlZ6LzliemM3emxybjlmN1VJYnBoNEVaTEZnalV3azFVTzQreWM0NlU2?=
 =?utf-8?B?K21NRFozMVJmRml6VlRudXBsOEY3TWtQS0VPRHdaS2ZBbDJiMjBUMzIvV3Bq?=
 =?utf-8?B?NUZOTVlUOE9qbHNzV1Y1UmRyTmJaWUQxb1ovVXhEZVpqeGJieG1EdzlZSzRL?=
 =?utf-8?B?UEw4MHJsSlpXQ2xwb0dtTm5MRnZtKzJtbUIwUkVYc0x5TnRqNnJuVHRyQ3Jv?=
 =?utf-8?B?a2M3K2hpL2Y3YjJmaEp5eDdZOGxrczR6TjJHdm1FRmRmRXdpUzQvSldjMUhE?=
 =?utf-8?B?OG9QRVZFY0dwVGhkbFlxSFBsUnFpdXVXaGliY1FUZHdZZHZrdzhjR3piTkFz?=
 =?utf-8?B?U0RlWXVwWi9CR24vNlMzb1VlRWY0SGZpNEx5YS9qVzdnRDBFY01kQ0RkTWdP?=
 =?utf-8?B?UnZSZnpoV0xlSndldzhlK3J4WWhtd0VBTzhaQ0hWcjBLWjNDYnoyNHBLaU44?=
 =?utf-8?Q?kgCssQqROLRebXkPw7BbCIgsm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ca785d-9b1a-426e-3ad8-08ddde989b14
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:37.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L82yFbPZ4pmKdO3nctx7k0GhEcnMVscfMPGI19xDUBVb2JmFDK2JYL4d38i6B+KxkTnacPpeOLQjwKvB9upNsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619

Rename node name nor to flash to fix below CHECK_DTBS warnings:

arch/arm/boot/dts/nxp/ls/ls1021a-twr.dtb: memory-controller@1530000 (fsl,ifc): 'nor@0,0' does not match any of the regexes: '(flash|fpga|board-control|cpld)@[a-f0-9]+(,[a-f0-9]+)+$', '^nand@[a-f0-9]+(,[a-f0-9]+)+$', '^pinctrl-[0-9]+$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts | 2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
index f1acb97aee69bbcc30c8034e627a0bc6584bf608..227a886ca6825465cfbb404e93c8f5e9977b1321 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
@@ -187,7 +187,7 @@ &ifc {
 		 <0x3 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
index f5c03871b2050c7cad854afaf59db046640df3c6..38281b904301df6a9d612fdd4384475a68b0cb33 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
@@ -151,7 +151,7 @@ &ifc {
 	ranges = <0x0 0x0 0x0 0x60000000 0x08000000>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";

-- 
2.34.1


