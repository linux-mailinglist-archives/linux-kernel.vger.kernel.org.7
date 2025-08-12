Return-Path: <linux-kernel+bounces-764737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20396B2269D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F135A2A7FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B70C137750;
	Tue, 12 Aug 2025 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fwWBSdbY"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7910515990C;
	Tue, 12 Aug 2025 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001126; cv=fail; b=DuC3wOHu873vehi+U6njyFTdsgyWii9Xjugli/h2XKQ2tvIaFZdn/NPnufO+SAwN2aSxq5Ro3IkHWbshXzzPJSYi+mDKlb59Q7Mp6NyNLMUun6Qu4ZK0A62zuevcY5zwOowcMhGjJenBUG2RL7SuRvD3N2ClwUaSrnzM8LpKaJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001126; c=relaxed/simple;
	bh=6UoxghPDjT+22Ly1P0RQ6l342s392q0vWuGY6rqK9SM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DCfAtSNM1fBDd9uReP/4+GvU37GQoIEwqL5draPPMQFD3xDsPfuPRPeySzj4Y5uznBUHGN9wLpPbl+aHyh3myHdUc1xAKkE9ojJQkNfak+Ufn0VECN8Dxm9LiXXZh1CpDx3SRy6qYEiKtCfy5wYV12ezHeTsjPga3LFivgxQpzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fwWBSdbY; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvaGR1Ex72unkGTpRGljgC2lx/I4VE+m1kyJ/yPRA4SljoxyxSoU5iP/TiSX4XQCZM4EeRMdjLPF1rIhdve1WEgG6c3ECHmZnTPWxYHvO73+kXPQNWyjQqJKlXJEp0M6w0DKkT+/QXDaoGlRM5U17PM+r3isnH3+iE/kw/8wyVRZcARZOTEUDdcZdHnEQv7ty+g149MAlox97AA4JzHW9zuAy6ZNr4PB4LS7mKW2n5tQU7t79hg9ceLrFdQJZy2P4lCRwkQxR8uOUIUz7AAwhkzbfzKy8S/x3CLHdlnH7lG8kePIjzCO6KIKfA1kFhaaLIUmouN7NIsKAPcwCtmIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1msI7nyoVah6bDY9mQXOwQ2TB5aUsQi50ELaJ7l6n20=;
 b=jC0u3yjH0I+9Xuh0Q0l/LkBwjlzSc5J15Wa9cKN88hEsPEHtqmzvDqPe4eQlD3eWz4YV7EbSYttHllod0iSgTi3zFVJHBxMMUfELa9r5g383RCbXXtYID3utuC+by+Z0qQKFrVg5lWCxYEGX3Lw3DvEVPvr/dS/dSOuEFmZAxXvcX3oM1kWn1knOTcHsvNn9Z7rmecfYQR4wyxWSkxAvSXqCXTKzSEpis+0bcPsJeHZQKCtOrcAXNFqShP4uOX+hAqvZZZK/6L1Mw1+oXOYWz8JrzZ2OBmFWmh7huoXCAv5H02K+YKImDtxGUROiu5s5/xayrwh2Q7oYbKiLPejXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1msI7nyoVah6bDY9mQXOwQ2TB5aUsQi50ELaJ7l6n20=;
 b=fwWBSdbY8tc2aoONbtzpsqvoYvlWoZ73fngI6zN+o4E4oHrDVKpyRLlY9LRrMmAuQGLLJM3CLa7de0Oh/STzZFLa5CQTsgBqBkHMTAxgC6fC74v1uQEqDBOafsyBuhzwyPV73SZ8Bd4gpWdhWocTLhCyWwjyUSrjXXbyEqYu3gxFLldrMITBiCZ2M64di9CNlM5BVgmxO3+qFlytwDVvOHzMmEnlNTvkK98527M3eIlJQ6lyPBKMvgty+5xPEkzGUZG7XHbwUEnB5LAnI6Cnd1FjEAD4YSqATlB4bSZYBzKgObCjIFZHkNHbbtf5zj4nvP+OpRL22RcpxUjNC3arKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 12:18:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 12:18:42 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 12 Aug 2025 20:17:06 +0800
Subject: [PATCH 2/3] clk: conf: Support assigned-clock-sscs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-clk-ssc-version1-v1-2-cef60f20d770@nxp.com>
References: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
In-Reply-To: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755001109; l=2972;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6UoxghPDjT+22Ly1P0RQ6l342s392q0vWuGY6rqK9SM=;
 b=umhFRKGZjVKJnzBrBGUPWBfHA72LE0T2CAg637haCu9x7gvIh1YM8vWJoIiuN7oF+mI0LxPtU
 6icUgsEoS4lDPOhlyb2eHDfoU5+gh7MOhZIMKmJOtyb/DNZPGUzpHCf
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 6903ba86-8a75-4906-673b-08ddd99a602e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1BNS2taby81dTlzcW1BZ3EvSlc1akFqMnNPMzlMeE5DZ3RDVWZKa2NCOExX?=
 =?utf-8?B?MG8zaHpURytkWEw1R0ZxeG1uNDZMTnRtUzcvUklhdmk5SW9yVGFXODZ5Q3NQ?=
 =?utf-8?B?VDVlWTlSTUJQNEJxdW9XZXRZYUxSTis2bEhEcEpqYkNPZkRTNDNQTkg1R3ND?=
 =?utf-8?B?WElUM0NrUG9uZWZzK0xldGMxeldjUlRlU3NKSitXZkVXSzBYbktxRFI5SStX?=
 =?utf-8?B?L0pPeERQM1NJaEtETENwQUhsN2xNWjJHeHlMcy9hUkJDQXdnOThXYUtNQlBQ?=
 =?utf-8?B?c3R6dGR0Q2x0NitkSWREL25BNGhjK3RFdDdlQ0FnZXhTUnAraFpGbWs5T3R6?=
 =?utf-8?B?di9OUHB0WXpRWUk3SkhvcEJZQmpjdHNicnptYStpaHRTQ2dSQ1pTNUxvNjF2?=
 =?utf-8?B?YU1FT1ZqUmp6MW5aN1VwaXZURXVZcDNJR2JoYndnZnVxZW1aOWUvTU9YZVpx?=
 =?utf-8?B?d3BvTUt1ZzcxUlVNamQvaEw3ZGptYi9rcFJvN3kvYUc3RUM4YXdTZkRUMUdK?=
 =?utf-8?B?UWJnN2NhRnlGTFpJenF1TnNSRGlQSlN6aWNRVmNtWjNaeFlxbmNzcDZiVyti?=
 =?utf-8?B?OHBlcDZsS0xnRy9ZK3lNc3VvTTh6K2dsTVdpNlRqUzZDTm5VL01sc3B5R1NZ?=
 =?utf-8?B?M1pWdzI0MjdiYll5aXl1TnZCRlR3Z3hKNzd2N2tqcXBGSlR3b2RYNkJaM1NW?=
 =?utf-8?B?cENYRjlPMUIrTm1TZEtDbmtCSFhPU2FjbU1uNG1vQllWaUJLMFNnTzhPUVFQ?=
 =?utf-8?B?NitMcmhUL2RuZXBwNGF3NW50bTFnT2FHMHBkbFpxUFJuT3ZCMkwzYjBnOE5j?=
 =?utf-8?B?ZnZvek1RYzk2bzJ0MW1QYjhFR2s5OXhwZG9iL0JJZlI1ejNnWkE2eWVJZ2Vr?=
 =?utf-8?B?Mnp3cnJydkYwcHpUQTQyVm9DUEN6R0lrd2FWZytHQU91Y3BGL3lZQTc0Y1FK?=
 =?utf-8?B?ckYvQzVZdlNLcHZwQU1QZ2R0QngraTc4b1ZJY2RoUW0wQmtiVXhseE1sQjFI?=
 =?utf-8?B?SnJUWWgzb25DZkk0RWU4TXF0MDB2L1BLQUlscUVIeVVCT081Z3VNd2xPQjZJ?=
 =?utf-8?B?aklWbEE3d0RoUnFSY3BNRktBMDBGYys5c0I5TS9wMEpJbUhPcy9vMytnY3Fm?=
 =?utf-8?B?b0lxMWlSYmFmcFFSdU9UU3V6TEpxWHo2MlVYTkNTa3krQkNTcTFrbDdBRE5t?=
 =?utf-8?B?RDVSSEt1d3RlK24vK1BKbzRsdWM0ZUJVTnVuempwaTU5YlJFMzFWNTM4dFYv?=
 =?utf-8?B?dit3TktxMzZtMXFhK3JEVDVSZ25VSWJGT2o5VUFrMS9GVXl4UFd4RmpBSlBR?=
 =?utf-8?B?V21UK2ZwcitOY1dSb0xxdDVabGhLbWdnNEFoS2VaS2FydDZBL2p1bW9BOGpk?=
 =?utf-8?B?ZG1rUG9SS2JXKy9RV05xeDY5czBURnVRSUE2a1hJVENITkFwWXZiVDVTY1Rz?=
 =?utf-8?B?TFV2ZWt1T1plR2x0aXMvV3BuVTBxTW40bHZmRGd3cTZvY2g0SUpXUFlWMUNZ?=
 =?utf-8?B?eWR0YjJOUXBHNklTcGduYllQYzBxOVU0YjNGOUJ1NjBJcEdOQUxPSHNrRDRP?=
 =?utf-8?B?NVVPSFg0NnNwNDF0KzVuZ2NkRXhzdk93MkdPcmtkMlZ1RWpxcUdTN0hub29l?=
 =?utf-8?B?Tnc1V25Ua0pwZ3ZuWmdaMG9UTkVwTzZrays5WnFIMWVPZFhyS3Y5TGxqY0Jx?=
 =?utf-8?B?eDNSVWZFUDh2YXM3cmNYSC9ISWt5TTViV0c3T1UycHVueDdwZ2l3UXBVZ085?=
 =?utf-8?B?UEpheDJTT2Y3SlM4NW5NM1BhMnlqd0dHeEd4TmZJdllwdDhWWXBhMWIyTDdG?=
 =?utf-8?B?elZaak9mQkhFL2hRdnpZWFczRzFETngrL1doOXAvT0U4OFBBUnpSRlZHQnpX?=
 =?utf-8?B?bzFOdWVUWXdxb3h3ZmpueTBPMTBaaEkyamZ6bGVIT3prYlAranJndzZZL3Na?=
 =?utf-8?B?WWpsNE0wbjJFUDQwOXg2QVFZNVFTaE0wZmk4SWxBWVVlR3NnRU1vaTJ0d09r?=
 =?utf-8?B?S2ZnaGlDZE5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGFqZWhiM3crNWs4ZTNWTWtVM0djWXVGZUF1cmVwajJldzRuczRsVnBzTjZB?=
 =?utf-8?B?bmluRUZaeGZlRldDdTRsZ3FzalVtdVJhaGExajR3cFVvWWw1MjdWN2VlQlR1?=
 =?utf-8?B?d04wck1nbktvRXdSNUhqU0puMXovdVQzcE5UTWtyUUppTkZDSUx1OWZtYTRs?=
 =?utf-8?B?T2wzeC8xZlJNU1JENGZZMWErWVQ3MUZUTUhXVEo5N2NVWEJpUHhhRUFVTHNk?=
 =?utf-8?B?YkZ1bnprZ3IzMHJjVEJKUmN6OFlDNkhPekt4MEZmU3V3WWxsZGRsWUJadmcy?=
 =?utf-8?B?cU5seXdmR3pkWmlhaXdnUXgvMFRMa1YyZTJlSDRUdWtFbFZETmhSVjJwN0FN?=
 =?utf-8?B?SVZEcFI5bHM4TFRETFZ4bGVNN2plREw5VGltc0dqakxNWG54UmZ2R1VZRUpJ?=
 =?utf-8?B?Y1ovQVlYa0M3alF0UnMyNGg0cUNIcXloRC9tZE9aaTc1QmJIbnExdGdyTCtp?=
 =?utf-8?B?SVRaN3ZBdDY1anhoaGpQNXV4TmRaWFFMcmRuL3JSVlJUWU5FbzcwbWpXcksv?=
 =?utf-8?B?K1lBa2FrOXpHUnlkYmdpODUyaVloaENOZkdNb2lKQ3h0YmNaMlNGV2M2eHR1?=
 =?utf-8?B?ZElweEczRWNtakRzbVJYbDhCRnVjRlh4VUNrYzBTejFaY3lMRWNyTDJIN3lI?=
 =?utf-8?B?MmMrUmoxaTQ5SitVQ2t4QmZtNjgySFJ0bzB0eHlhakVUNUFmbXZRdk5pM2ZX?=
 =?utf-8?B?SWZ6bUYxK0d4dWhjblZVSUZOVExPY2U5dUoyWlpwWHVvTVI0YnZkUytBbVhR?=
 =?utf-8?B?elNoa2VGL3A4MTM3SFUwdG9pdU9mSmZTM0djV2UvdklSU2dGQmZVcG0xTnYv?=
 =?utf-8?B?dExDYmpKemVLWGVCNW9lREkrS29WYnBNelhITm5tWUY5UWtiZ0hkbktabXJD?=
 =?utf-8?B?ejUwZlVoNFNzdGZRL2dWQ1JDelU2dTFSbDJhRC94bmt5VEplbXBkQ0UvZStE?=
 =?utf-8?B?QlZRekFWaDJIeFlvQS9UZTg0NVduWkcyRmdqMG82WDFhQ2ExMTFTb1ROSytB?=
 =?utf-8?B?TXJrb29RVWlkTHArbUxkV0tMNU5TWGpqU0xXVWZEeTdEeHZhMGhDc0R3QVJl?=
 =?utf-8?B?MENuUjcxQjh4MjlpcVM1ZnNLNFBhTC92clFCblNHRnhkcVJ4Q0xQQVhxTzRR?=
 =?utf-8?B?MEVSTG1iNElWWFY0WUwzUGNQQTFrcmZiLzVRVCttemFLaW5OeW1pUGVBbWpx?=
 =?utf-8?B?M29VVGtRd2h6QzRJS1RvUFhhOUJ5akRNUjBUQnpZR3EwQmZOS0tuVXg2REtI?=
 =?utf-8?B?OWlaYzZKSDRmcmkvN1hjaTNnM2dXOFIwSHE4cTZnYjBRNU45Y0dvaUwwSTJS?=
 =?utf-8?B?MDVkYkhQYW1aa2drQUFqbzc5NWc3MStJY1hOc1RlYmdPZXVpN2ljS3RjR1Z0?=
 =?utf-8?B?Nmdrc3kyc1kydC9PQVd0VE9vUng2SGd1dVFIelMyd1IwVXFObmhEbkVsdllk?=
 =?utf-8?B?U3RtNzB3TERad1FNcDV6SU8zMEh4MFNscE5WSkhTUVQ5cVpXSHZXbTJpUUNF?=
 =?utf-8?B?V204bDh2TTdMQUltNklVenpBemh2UXpPQXZvOVB3NDc0SlZRQWZqd2tXRXRC?=
 =?utf-8?B?cTgwcEsyYWhZWCtwZkI1cEVaNVlDZ0dUdVZzNFE0dFdwVXJ6TnlPYWxPSXlm?=
 =?utf-8?B?OEh6KzhQOFBjOGNtRlIrTWsyQ2I4cXdMYi9OaUhVdmt6emRuVERUQlpFaWEx?=
 =?utf-8?B?YmlmcGw4L2N6Q0JNL2VEOGQ5VGlYZiszRUx0RHM2eFM0YStMSUF2dG9KQ3E3?=
 =?utf-8?B?TlhxRDQ1Z0lic01UR05lb1ZVTVVzdExHcldHb2xvVjg3Q2I2dHNGL1p1dW1i?=
 =?utf-8?B?a2JJQjF2cy9XVjhsTHFiWVk1eVJ3Y25oMXFVTTNpYVQ3eFROSTYzMUIybi9z?=
 =?utf-8?B?SnB2Tlc0eDd3OEF3cFBIS1lvZzNiT0J4MVBpN3ZHOUkwcGtxVVRybTg0aEJo?=
 =?utf-8?B?SUNBKzZsMThJTkJZejMrV3BRcTZndG1ZNnJSd1Nud0h6bXlzWHZFYW41aDZ6?=
 =?utf-8?B?Um5VelIwakxIOTJSa1RKZUxwVnA5ZmtqRmRKSUJJcXQvbXhwaHJDcnZwanA2?=
 =?utf-8?B?ZlFYek5JMzVRSHZQQUppblZuWlVIalRUY0N3WFpCOXVmN2VhMEp6c1dxVkJX?=
 =?utf-8?Q?IXGbXLqPE3QKhVrwDfMaOpwFm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6903ba86-8a75-4906-673b-08ddd99a602e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 12:18:41.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaN/Y2f3mFgKSXXJrm6jN4zcfYuCrN3o0okg8wIGJyrJvqGZZaIOFxOJ7muUesPAJ2pLbCsWyaxzlucr3i42fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721

Parse the Spread Spectrum Configuration(SSC) from device tree and configure
them before using the clock.

Each SSC is three u32 elements which means '<modfreq spreaddepth
modmethod>', so assigned-clock-sscs is an array of multiple three u32
elements.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-conf.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 303a0bb26e54a95655ce094a35b989c97ebc6fd8..81a2c1f8ca4c44df2c54c1e51f800f533c9453b3 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -155,6 +155,72 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 	return 0;
 }
 
+static int __set_clk_spread_spectrum(struct device_node *node, bool clk_supplier)
+{
+	u32 *sscs __free(kfree) = NULL;
+	u32 elem_size = sizeof(u32) * 3;
+	struct of_phandle_args clkspec;
+	int rc, count, index;
+	struct clk *clk;
+
+	/* modfreq, spreadPercent, modmethod */
+	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
+	if (count > 0) {
+		sscs = kcalloc(count, elem_size, GFP_KERNEL);
+		if (!sscs)
+			return -ENOMEM;
+		rc = of_property_read_u32_array(node,
+						"assigned-clock-sscs",
+						sscs, count * 3);
+	} else {
+		return 0;
+	}
+
+	if (rc)
+		return rc;
+
+	for (index = 0; index < count; index++) {
+		u32 modfreq_hz = sscs[index * 3], spread_bp = sscs[index * 3 + 1];
+		u32 method = sscs[index * 3 + 2];
+		struct clk_hw *hw;
+
+		if (modfreq_hz || spread_bp || method) {
+			rc = of_parse_phandle_with_args(node, "assigned-clocks",
+					"#clock-cells",	index, &clkspec);
+			if (rc < 0) {
+				/* skip empty (null) phandles */
+				if (rc == -ENOENT)
+					continue;
+				else
+					return rc;
+			}
+
+			if (clkspec.np == node && !clk_supplier) {
+				of_node_put(clkspec.np);
+				return 0;
+			}
+
+			clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
+			if (IS_ERR(clk)) {
+				if (PTR_ERR(clk) != -EPROBE_DEFER)
+					pr_warn("clk: couldn't get clock %d for %pOF\n",
+						index, node);
+				return PTR_ERR(clk);
+			}
+
+			hw = __clk_get_hw(clk);
+			rc = clk_hw_set_spread_spectrum(hw, modfreq_hz, spread_bp, method);
+			if (rc < 0)
+				pr_err("clk: couldn't set %s clk spread spectrum %u %u %u: %d\n",
+				       __clk_get_name(clk), modfreq_hz, spread_bp, method, rc);
+			clk_put(clk);
+		}
+	}
+
+	return 0;
+}
+
 /**
  * of_clk_set_defaults() - parse and set assigned clocks configuration
  * @node: device node to apply clock settings for
@@ -174,6 +240,10 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
 	if (!node)
 		return 0;
 
+	rc = __set_clk_spread_spectrum(node, clk_supplier);
+	if (rc < 0)
+		return rc;
+
 	rc = __set_clk_parents(node, clk_supplier);
 	if (rc < 0)
 		return rc;

-- 
2.37.1


