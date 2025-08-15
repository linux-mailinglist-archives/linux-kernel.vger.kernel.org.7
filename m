Return-Path: <linux-kernel+bounces-770556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AB1B27C59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6071885515
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AF92D2385;
	Fri, 15 Aug 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xf0EOj+X"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6CE2C158C;
	Fri, 15 Aug 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248691; cv=fail; b=exRoEDYnJK7IkXcRLmHQHF2ewa5k7CU+WeIe/4/pFwCHrbyQNSCYt7ZUhDaM3CQzDxZynTEGZjwz5VAXgiYV4mv6oAnNp8oykZ0Dlu920UAAwnJHOsR2KRrI5eFKjq2rUIm1N49Qe8+Ie4C4HsEBDsN4knfCazHxRBaaF2o4PdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248691; c=relaxed/simple;
	bh=iTz6e2sicQazX/DoNtABBs4PuRvoe/WXcqFz9VWGyUk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sLHVMrkIwS09BD5XwVfgPCYhibY2W5eyhDHBEcvK4jp4lEN9w36lATlQOTfxJLWl+zgcUkgxoY2aid8Zou19SYkpWI8KQQ1RcWdeeX7e7rUTdBq1jLh5QNUSZY3zvnTMB/C0xcPToYE3Ps0mkRp3bdmtxcj86l0uxegPLR2uem8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xf0EOj+X; arc=fail smtp.client-ip=52.101.72.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsWaQV2yHAcNhvAn86dPZZnJdU664+jlM54/VaN2aA8NoGnwmLautJQBKGGHmAtD9p+lsILqKPJpjN0jBdz3r8hpFXZuma8dBzoM2L4JMsXUZ0gUVUYR3h+ZfQYmeIslI8mrKmbmMn0PxcDYOKkGVY9ZzfK/UxBGZGmyOmtSEy040BD4WqloD0JFPquSVgQYw/zr6rvbx+e1vivkLkhmoqiNEowu6lMLhMCxGHM38B40TtLLePS8EHfK6E0YCTFKt+GT4AIET/R2ZbeYQozdEEaa+lsix14YmzPJogezepT7URijMVloRdhT+QuBQZvNIisHpNOUn3uPGDvgUaIgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EoE9f2XeVGlj/NfOdJGwFhsRQ+JOnt8B5npcHv4PtI=;
 b=rLjzIU9/M9x5XJ91lbel4/fY+eKRB0qGYE2M4SfeGjWh0EhCFjga0K9QSoijGymG6lHyciyFtQs6BUzuEHAK2sCOc9MIraZgmPU7vzoB4xbvrd4eEBw9axjFun9Ew7fA5Fq/5toLHJvP5fHutnMMOKOkFkP+fdJsAgIMTQcV6FynoJyqhFE400jWV5wzx5aW+fz1tb/2n3+7IgdpV3E4GYiN85obYftHjxp2Q+S0ZFCC0UvpuzbQteO/Bn6aOcHm57E1JrcnQjpv/2zM7P11ABV1zJLPVxq9gxEySmUiq5BDVLto3/hJwzNkeHbxIl2F6P3HUi8Ti1IhdnRXCKTbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EoE9f2XeVGlj/NfOdJGwFhsRQ+JOnt8B5npcHv4PtI=;
 b=Xf0EOj+X3LJYy+fWRU6ciB+2eZJ0R7+mbdu6AxdAV/68wyq7APa69wHmEA8+hMWJMx0ElGyDGdDSEfIX05FFiVojYv188uPVuUxzLc9THqjNBnalb2dbU9QYbq0ytEdwFr19Lqj9P2wzKAs2Q5Bp/piHT+LM20DU8pP4eWa6Az8i0xPD88LYLh+v9aQ8wYVXlgMeK9B25VzVAHyWfh2+cJTv2VqT9OZTmrxCr6jeNowW1cWIPZXJTM4CrYyPAWiuMc08oZ3ee5YetPpBvReut+keJbFwvMtxiexoX7pcNGSQ/XCJSvjUsj7gmkv2b0c5RurrpXnjkwUKKol3LlF1vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 09:04:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:04:46 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:52 +0800
Subject: [PATCH 06/13] arm64: dts: imx95: Add coresight nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx9-dts-v1-6-e609eb4e3105@nxp.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=2956;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=iTz6e2sicQazX/DoNtABBs4PuRvoe/WXcqFz9VWGyUk=;
 b=1BEmXRM/rUbx+rbrDBeQVZ3gO+c9jkHqBH0+uDeqwLA1Y9vEyWO0f27pKUxlJ5ImrZjIcXnBN
 tJyguhew5RYATVbtyqdfHK7nkHBC1grgm1ZWb2QwQezacEmB4qURAij
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 05427bf6-93b9-4e34-6f73-08dddbdac849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnkzYXl5YitYM213WE41TWkyWmVGZlR6T0xMNlVKLzAwMXJIOGNCdVUwVG5D?=
 =?utf-8?B?Sm9OcWNZMFNpeTNTS0s0Vmdwa0cyV3dKVG10cmtsOG43MnhPWTk4bFZHaW9C?=
 =?utf-8?B?QTVpaXB4VWxoSlEyMmhhd201d21VM3REWTJ5WHZqS2poSzZFUEZYMUdHbmVQ?=
 =?utf-8?B?SHBnY0FMWklsMVU2ck5Ic2dtaTJFVVhoRWRZNWdlVjA5ZTlFa1llWERMWnRD?=
 =?utf-8?B?bTNxSmhENmFLd25SalBLSFBXbTBEZFFEVXlZdXNxSHoyK1RuS21CUTdDMlh5?=
 =?utf-8?B?SFpueDBvUXdWSjczaHFEcWl3V3dNUVpKZ0Z3RCt6VkFSVTh5d3BibGVhQVds?=
 =?utf-8?B?SFkwSy8wbU5VZTYwNkg4RndIRmhYL3V3Z3FkL2FPSENoZlAybTE1dzJaRGdy?=
 =?utf-8?B?bEQvaVhYVjExVCtHcVZOQjQ3OXVvTnF4T3VNOXloVzRFN2l0bEpNQloxMGYw?=
 =?utf-8?B?dWphNG04WDJiRTM0ZDRCVHJWaUJEdm1mUHFNSGpsK0tCOXd5MWYxUGw2Ujhl?=
 =?utf-8?B?WndLSEVWWlYzQ0RqVnpyMS9zN3F4K3g0Vll5Q3hremdycm9vNVRZN29TZVFj?=
 =?utf-8?B?VUhTWmYwKzJqVEJUVkZXTitiUXpuOEFsVzkxVWVnK2RsRW5NQTE5eXZuNXlh?=
 =?utf-8?B?ZkhHWSswUUd6N0pWWWJUbVVKZ1VKL1NMTzV1bVh5UktqRHVsVzVFWCtMaEJ3?=
 =?utf-8?B?akZzSEhINzIxcEdBaWJWYkZPQmZZNXRucDh6cURhZmY1Q3pKejd0YVorV2pD?=
 =?utf-8?B?MlcxWU54dkxZb3BwRzd5UDVDMXFHQjhIZlJGQzVGTVpBL2U2QXhPaTBaaHMw?=
 =?utf-8?B?dFJIMDRlS0d5NytqUElZNFhKc3lONWUyVDdlUVYyaFo4RjV1NGl5TXBDK3py?=
 =?utf-8?B?YTkwRjdaa3Z1UlRhcC9DV3FpQTBCRW04Qjc5c2pSdjYzR09tWDBOZnhaUm5R?=
 =?utf-8?B?RVFJa1BYRC9Hei9rTGp0Uk9TT0pDQjgyb3AxRXp4OEdUYm1haFQ1NWhrMFhv?=
 =?utf-8?B?Ui9JLzF0MFZweTJ6WS92Tk43MXBIbTBUTmNHVDdBL3dkWVhTbnNHZ2VlR05l?=
 =?utf-8?B?VlNkdW5MMk9tdnZmSzFhY1VRK0dKaHdiSDU5cUd4YUNPQVB1UFl6ODVBbGNo?=
 =?utf-8?B?YU5WK0tzYVhTQWd2bjQwTTR1WnNhVEtXeG5rNE5GS0pXNStPWjZja1A4b3hC?=
 =?utf-8?B?SEU2MHI4c21HeC93UFFMb01zLzlsVk5wOGtndWk1QWJOaFNQZUJsTmQyOEdV?=
 =?utf-8?B?ckdVL3lzNXJNT09hUGE0MnJScWoyNEdvOUgvempGY1hkMUE5MURNVllVOHhn?=
 =?utf-8?B?YTNzMFlkWDZYMzFSQmhDcFN0NmVoTFFRNEQ3bEZqc1JOMTQ0bHdCMC9pL2tP?=
 =?utf-8?B?K0JydHIrRndmUS9oV2lvZnlkVE1GL0s2Zm9vTlZicGRuYWU4bWcyWVFJdEJM?=
 =?utf-8?B?NXhzblA2Q2I1amt2R3RhSXQ1V3FTdmdDOVk5cFNITUVrcW1NT3VtT1hxVklE?=
 =?utf-8?B?Z2lWU0lNV0NyNEpvNGJlZDlCUWJZNE9uWnFsdHJUdHB1YzVLZlVuSVJUR2Q4?=
 =?utf-8?B?Vm9TTy83ZC81WVc1WkY1OVR1YTk4OVVWcXRQNytYR3NMYkZ6aS8yM0xhN2VG?=
 =?utf-8?B?b0xTVDEvZ05HTi9ERnRUU0VNS3AxbDA2elN1YVdSZlhLcXNJdDI1bjN3bFhs?=
 =?utf-8?B?TWdDZE05OHEyV3Mya2lLTCtRQWduc3phU0pubFNZZWVuZWdNWTBRTkVaeXFT?=
 =?utf-8?B?eDkxNjZEcEhWN3JxZksxcFJXNy9mcEx1RDdPazdhMGpXTXpOMEtySW5LSjI0?=
 =?utf-8?B?aDYyN29mK2hEU1lqdU1DbXZpZEFBbXhCYXVKd3dnakxvZzUrNTBmZDdnbVFK?=
 =?utf-8?B?YmwwMzFqZ0c2OG9wSkNkS1Z2czVZZTZsTERaWWhRbmZsZWZVY1pGNDdxTWlC?=
 =?utf-8?B?YkhmN0VSUk9lUTVlZkIrQThvdkMvZHl1OFpJMkRtMzE5TGQxTzF4cktkbzhO?=
 =?utf-8?B?dHFudzZNN2FnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWlQMmN2TVdRZjlBMm5ybVUvL3R4SUV5WUFTTjZWbXVyT0R1bkNyM2dyWmJK?=
 =?utf-8?B?NFAzNW8zTjJKYyt1YzJFR2wyWTRXRVNMWmpWZDE3ZFRxaHZDMTBCQzNtMVZT?=
 =?utf-8?B?NHozdEo4TzJ2SEtQcVpaczFlaGFQNWF4OVVjKzMrb052UVpFZHhudTFtUTJU?=
 =?utf-8?B?Y1ltTHVaRE91TzU4M2pBUjY2K2creWxaRHpUNnhJSUV3N3YveEE3TUgyQitH?=
 =?utf-8?B?S2lvaGZYMWIrVDJ0aGQ0SjNjMWhWNGZSa1h0UldzdGlmdWJNNHFqdm91dGVn?=
 =?utf-8?B?OEdWeVM1TXFiMTdUU0liOFFONnZxVHFtQ09oYWJESWowYVVFdTdZN0VZK0w0?=
 =?utf-8?B?eGtqdG9pR1RSeFdod3dkQzVEa2Y3SlR2TE10TjFwR0xpTlN4V20rZWZ3bUs3?=
 =?utf-8?B?T3JONGpuQS9mSXZsam9FRGludUZma0JNaE1xWEQ3NGE3dFFOYTdSTUNyZi9X?=
 =?utf-8?B?aTBYZGNHMURZNDlMODUvTmwwdUl0RU9HSWFYZk1NOHUyVFQ5TGpSRHJjZXo5?=
 =?utf-8?B?NGJYWmFmY3VRWGNqUWlZZW1wOG81djZjYTlTNmlIck0vUG5TL2tvV3JJaS9h?=
 =?utf-8?B?SHVsM3ZZcGx1TG91TVFCdWtlYmpzUy8yb0ZDRUVaLzQ2VEJRWUF4UmdKYTNr?=
 =?utf-8?B?QVRUNTJ5eEplRTFtazNFZGtvREV6a0srRUNpbUV5UHh1S2UxK2hiaVl4akcz?=
 =?utf-8?B?ZGFyMmhwUEROckpzdDRzRWtFSTl5QUdSTGtlVlVORExJTWpZaXJDTVp2RVRo?=
 =?utf-8?B?T3F5VGJjY2VjUVEyRUpkNmU2czB3U3hFRmx6RlFUMnFnbEFsZTVLQ2tMekhz?=
 =?utf-8?B?T3hlMGFZdWl3NXNiem1sNE9rdmd4Y0JsS2VPMVdaR3Ftb1lpallFeHVndEtj?=
 =?utf-8?B?aDdjNENPMXpQbXA5SFNxbmd4L2ZJYXE4TFUyVEVQMVJmZVV3Z3JEdnBpN2JJ?=
 =?utf-8?B?WThhYzdSRmtUcHZheDdOM2E5UERMbEZjSDdZdDFMNGJVcHZkdmYzTmR5UXN1?=
 =?utf-8?B?T1p4amdmK3dWN3JMQ0NtYVFJM0VheUZLWlQ4bkdheWRSNWkvcTI1ckhFdEZE?=
 =?utf-8?B?SjVmakd6WlUzaGdKb1VzaVRtcjJ1cTNHTTFvcUZrMUxBSjllejJDSnJUcWtQ?=
 =?utf-8?B?RGFXUWdValEzQ05QYW9IRjhJQTMzWkdVVml3N1pFeWllR3ZuZTRGNkVSZk02?=
 =?utf-8?B?U0RTczdReXM5emhwMHphY1BuSkoweUtJUlZoM25qbmhTMCtzb2xha1NVb21y?=
 =?utf-8?B?ekFIaE9zVEgvenhXandZZTdndzhlVnFwK2JQS053aFV0Z3lKblhsUHcrbk9J?=
 =?utf-8?B?LzUrU1RkbWZuQkNwaktqd1dLUHFZSVJFcVU4NUdjTW1KVGx6b2tCNDZOdGxP?=
 =?utf-8?B?S0RTUmppN3NKVE1udC9mZHBUNkNLUFhxOVExT3gvMW5BWlNSWTNSbStQd0h6?=
 =?utf-8?B?bmI2aU5iRk9ScUUybFVyaUk5UDJmaExReHFhbHByTThuMzlTeE1zZk5DcWFl?=
 =?utf-8?B?N3Z2cWFncnJwd1ZKVEQ1R0JzQm1UeG1rNzNsdDIwMUNIcE9EaHZzV2FuWW1w?=
 =?utf-8?B?eHg5Sk4zSnRGN200MW9TbDd4bkE2ajh2K25Md3hkRnpRVVZvR1JwcU5UWlhK?=
 =?utf-8?B?VWI3S21XYmhTNXl4Q3g2azArYjNkTW1SbUJreC9zTWE5QnVkRzdzMlRPeUNT?=
 =?utf-8?B?OVE1Y1BGOFRFTVYzeVo3ejRLbnJ2OUVnOHI2OVF1MytUUldaQmdNeHllb1d6?=
 =?utf-8?B?S2xQVFdwVE9RUWtvK3BLVDhUQ2lqRjBmT1NCQ3U1d0ZhSnpDdExyN2ZMM3FS?=
 =?utf-8?B?eXVKVUMxOHFPaFhKb3BIcUxUaG5DbkUxcU5JeUtHS2ZHTld2ay9xMDl2SVl6?=
 =?utf-8?B?aG53ZzFoWkkzb282RnYrK2JpbmxFZmQzam41eEtlT293d2RzcmJFdE54UUJi?=
 =?utf-8?B?QXZFZjFCeTJNSi9hM20rZjBobUdQSkIyQmxkcVVyR21VbC9LNUNnQXZKcFpV?=
 =?utf-8?B?YTNZWEZSM2NxUlRDZ1VuRXdHendud2hNeHJFNW4zUGpsUnFIM21obUpubURl?=
 =?utf-8?B?TGY1cDRJazNZQjNzVkFiL2FXTTRRaE01Nnk2Y3VXLzdaOWRtT2xaYWlSeUZO?=
 =?utf-8?Q?cb1jAPZvHANX7OW8GpT37hVCK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05427bf6-93b9-4e34-6f73-08dddbdac849
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:04:46.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcDMUgCunzIi5DUM4yF1giuqPW6AYG2z6tUVLDx3h2AovWTGHNJyDpDUhQG+AtfY4J0ZuCHfXc703v3d5tlW6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

Add etf, etm, etr, funnel nodes for coresight.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 104 +++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index adc63448aa15b148ca0eb8499ff5bc217fe8208e..2fbdd9c7ca099ba6971e4f6914be680a5b96da36 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -492,6 +492,110 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		etm0: etm@40840000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x0 0x40840000 0x0 0x10000>;
+			arm,primecell-periphid = <0xbb95d>;
+			cpu = <&A55_0>;
+			clocks = <&scmi_clk IMX95_CLK_A55PERIPH>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm0_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port0>;
+					};
+				};
+			};
+		};
+
+		funnel0: funnel {
+			/*
+			 * non-configurable funnel don't show up on the AMBA
+			 * bus.  As such no need to add "arm,primecell".
+			 */
+			compatible = "arm,coresight-static-funnel";
+			status = "disabled";
+
+			in-ports {
+				port {
+					ca_funnel_in_port0: endpoint {
+						remote-endpoint = <&etm0_out_port>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ca_funnel_out_port0: endpoint {
+						remote-endpoint = <&hugo_funnel_in_port0>;
+					};
+				};
+			};
+		};
+
+		funnel1: funnel_sys {
+			compatible = "arm,coresight-static-funnel";
+			status = "disabled";
+
+			in-ports {
+				port {
+					hugo_funnel_in_port0: endpoint {
+						remote-endpoint = <&ca_funnel_out_port0>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					hugo_funnel_out_port0: endpoint {
+						remote-endpoint = <&etf_in_port>;
+					};
+				};
+			};
+		};
+
+		etf: etf@41030000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x41030000 0x0 0x1000>;
+			clocks = <&scmi_clk IMX95_CLK_A55PERIPH>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+
+			in-ports {
+				port {
+					etf_in_port: endpoint {
+						remote-endpoint = <&hugo_funnel_out_port0>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etf_out_port: endpoint {
+						remote-endpoint = <&etr_in_port>;
+					};
+				};
+			};
+		};
+
+		etr: etr@41040000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x41040000 0x0 0x1000>;
+			clocks = <&scmi_clk IMX95_CLK_A55PERIPH>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+
+			in-ports {
+				port {
+					etr_in_port: endpoint {
+						remote-endpoint = <&etf_out_port>;
+					};
+				};
+			};
+		};
+
 		aips2: bus@42000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x0 0x42000000 0x0 0x800000>;

-- 
2.37.1


