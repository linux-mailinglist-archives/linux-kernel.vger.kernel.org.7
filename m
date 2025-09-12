Return-Path: <linux-kernel+bounces-813139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3905B54114
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9707A00AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38EF252912;
	Fri, 12 Sep 2025 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LgPYqvcR"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52247266B72;
	Fri, 12 Sep 2025 03:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648195; cv=fail; b=aIo46VS3kQ8fo1woyJmyQpykPIhlOWIWpNPEi+XpE5SOlMPTHYeGb58o75SieNl3ixJ/QfmyZDj1lQ3T9LD5pmCsMk4GIjfN9YNf1NNK9EBxezrjgMrAnzKGNATM5bgVj6Mkvn932RVYkrYe4P4DO9B3FiAmm3GqO0mOcK2TrVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648195; c=relaxed/simple;
	bh=/f/t/uvptCFsPsDbOruMFADsd8OrSPUdYLFUpJTxZ8M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZdD65rGWGq/JDLr2htEc2/9SCc7eKc5n3os1i8qEmgguZ3ZzUf4Tore1qz1SJkLYgatctvmV+2vkjUb2FXYOwVi/2AWdIw8pmOcV2LQKsSUfPMWNjwH+BI2Yta64/g8dM/ufQSWh22A3eoN+viFE9ZwiSUfBLpHFO3+NUJSs9NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LgPYqvcR; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSTOfArNWWif+wl7n45GBkhnUoJSym8GYt2LZ86tBMpU33KrUN9xpao26iK4x/Fvt1wsDfSKOPXJuF54HjlMjsQACus4LqC7Gdhrb27xgBo07tvB0aBtPORJQjfNzWluJ8LKJYi7Nw6lRLf0RTfFInlrfqaz5/r7ppSUeCMxvL2JU5hw8AoBvqu0vJuIOifS87xnIa0cgQRCPwSSCyA+3ncApVqZutvR141oPNrWWGLnR5WA35srHHHvFTLGkI/zOinBL1FVh1kAuO4lC0DdC+073vypngJ08AOcXsuajq5VU/rfQcfHaYBgCb/nriGP2Q76hGW2igis35gFnCQDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIJfCg4N2oQGUDEPTId1k3KrZRqXxJU5TwK1ZfHn4bY=;
 b=pk5xjF+FWeMQaeoZhtbcpl4+xoZko+xvgO4GCz9kslsEXwoLTUVdxS2TKBguMVRtsAnGesEAOkmd3nsrAnMD1ToA7f3UZsq31pJUS5+XJGN1m+vYgzXhqRpslt8Sr2ctRSVB4u0tgdcUxH86pqlvAyhvx6AzO+JRllz0AlMG2Jxhbdpxso9DXDC86DlHL+LY4qV3MglXhPjgy+yuqiOP/An0C1KXz4tpKvvzIPsRsBimtBYynSSkaL1+0NkqU8tSlKUdVXnPSqPq6rPnC4IF9rt60W8HFIvH4kl353AozVu55KcAFeHJafGhkG3u8jAhgBd09D05zhLprY8scA5tXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIJfCg4N2oQGUDEPTId1k3KrZRqXxJU5TwK1ZfHn4bY=;
 b=LgPYqvcRvhVxd3f+hi68TmbTYcwUw9DZRmAeRgDT2GKfMLPi/qAI5sZDX4N3X28IuNTPtkFeyCoIFdfXO8md7CnWcdFQVI7Ed8Cqwnw4lSTrnOxLPginbVqrPvJ4Dz5TnQAHV3zzvJcd3Fy8JtIuNH6Hy/LBBmxSPeL+wy6sSGv8QrnFV9VKQlTRxvHbUfTrtDNa3BMHpUq7AZ5nQQb7mPiw/NNOmlBPoBhIYBs/VezjSrjGKhik0wSqwZgizGi0hqOBPqxlginN/oZXrV/pe+g7UmUcqN7dSLsvkEzC77qqs/nlqE60JknwNYcj2203Yf0yDQ9AGtw+ofIrYOdhrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8526.eurprd04.prod.outlook.com (2603:10a6:102:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 03:36:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 03:36:30 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 12 Sep 2025 11:35:54 +0800
Subject: [PATCH v3 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-clk-ssc-version1-v3-5-fd1e07476ba1@nxp.com>
References: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
In-Reply-To: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648158; l=6023;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/f/t/uvptCFsPsDbOruMFADsd8OrSPUdYLFUpJTxZ8M=;
 b=ZmvT3tIxXmGMeGz4DnO20VKQT1X1F44CzQzERPhsy9tw1WJGgGRXOR1dovD/gYwlFIhRAU/NR
 sagkc3vyB5aDsAJMZQl9ybFx2CsIxg0LfF7AEymRtdxawDhx5bj9fbI
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd7036f-327b-4414-2f8b-08ddf1ad8ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHNOaWJieFpmR3Q2YU5BYjJQSFRXVkQza3dnMlZEdWpvaGxSRTFSYVJ2bmNz?=
 =?utf-8?B?NmptUDBNYXVCZFl6WWNIY2JyS1A0NTRQQ2hLeVpOUVU0cEFEdmh6bG1neW9h?=
 =?utf-8?B?S1YyZDJEdStrejNIaXFkYXQvTHJCK3pGWFNHb1BRbjl5cVVBRE1vWG9CMHNj?=
 =?utf-8?B?YmNGZzNCclpSV0E1b3M1aCszSTNLS1dwM2lvTDMwYnUyeDBJM2kxS2VGakwr?=
 =?utf-8?B?UkJGSmExa1pKVUJEZ0VGd1RQZmZsUjVCT2l5bjErQVgrdVhnWnV2d1JFSG5t?=
 =?utf-8?B?bklWTENteU5JWU9iU0lCcWZwa0xXNldmQS9yeUJ3cWJaZ2Y0dmZ4TUUvNC9i?=
 =?utf-8?B?Sk43WUc1bmY2L21GNWpHRVB6VzQyS05JUUNJWUhySGxPa1lqdm8yOVNreVdB?=
 =?utf-8?B?d2Jwb1g3UjkwcFplc21reElxVVlCSWFCVkR1bHZ1bHViRlpYUVk1a3lnOXpw?=
 =?utf-8?B?cVdJKzJPTy90ZUNuK0crdDUxanFQNko4bmNiMzhvLytDUVpOWEpiSFQzZE9v?=
 =?utf-8?B?NEs5eUdwbU5YMWpCODlEaXp4ek5JemNGQStBclQ2bEVWRTN5TFlVTFdqQWFk?=
 =?utf-8?B?c2o1REN0c21qTVB3cmVqenhyeHltRTdodG8ydzJUeXMyM0VrSlFIYzUvdTBx?=
 =?utf-8?B?dnFIL0NKWDhkbWhtRi9La3QyY2tGVVVuNkRIaFRDaFZ5Rnp2Y3lCN2hKK3Av?=
 =?utf-8?B?MFFLL1RENlp0Zys3SWZab3N4RjJHUDh6UU5PYm5iVlFUNU9RK0hoWUtWcGJo?=
 =?utf-8?B?VzJEWksrUnVnTnRTeDAwNUg0WmRKdFI1TFI0ME9EV0hZZ3NqMDNKaUYvQVNu?=
 =?utf-8?B?NWlURE1aWnFnMGYySVh6dUZFLzV2NzZ5MHpTR2pqSXhyQnlLREYvQ3RvaFhw?=
 =?utf-8?B?S2xmY1hqdmQ3RnBMRjVjTkN6Nm1WUnhGVXErTFZkVkU1a3NUTnBGc3BMd3lO?=
 =?utf-8?B?a2FGeDV4QmdnU0hEY281ejJuWC9CSEZVMW1OSjZXMkY0aUpVVFAyM1ZvM0k1?=
 =?utf-8?B?Y3JTeWNyeHRJK0JDWjBKbjdaTFIzOWpCYTNGbkk0NFlya2MyWFJCak12ZjZl?=
 =?utf-8?B?UmF6bU9aRG9CS1ptMDJEdHZhRlNHSEZEZ3lpb0dXcDdzNkx2SDNySVZrUFFR?=
 =?utf-8?B?MTg2bll5YkhPUEM3alUvcTFCbXpTYXY2Z1dMZnZrdk9OVkJQTCsyUXJVeHBC?=
 =?utf-8?B?ZFo2QVFBNG0zUWpkVlAzR2tiZEN1ZWVDSURrTmhJMENIbHlhN2Z6a0ZNVDlL?=
 =?utf-8?B?RldzVFB2RjhvVnUrV3ptbDJqb1JqY08xR0UwOVpRTmxJRXRpUkI3em15VmVT?=
 =?utf-8?B?NzEzSTFRNkhiRElrbERLM2JNZWFkNHpEb2g3MmNoZmp5M3NaVDl6MGVMelZi?=
 =?utf-8?B?aEgwa2M4ZmwzMWl2QWFuL0pSbmxYcWNCbEowbk9LaVBLT2pITWFudk95d3Iw?=
 =?utf-8?B?YkN5ZTV6MjZOTHlRaWNCN3lhdFZkOVEwaDR3QzFHSVltL0lPNEVGVkVXcTFw?=
 =?utf-8?B?dFc5L2VKaUYrQXJZNGIrbkh5Y0t5Skw2WmU0Zkh2K3NzZlduRkFBVndCUEM4?=
 =?utf-8?B?VjhQSzdvQ21KZHB1QmF4Q0JTc0d4SjNMalNUYURpSHRVTjk0clF6cnE5NFF1?=
 =?utf-8?B?eHZyMTVMUEhHL2s5MmJrK3d6VWpNVnhmeGVCZHUwSGlGc2VSY3RHK0lIZ0wz?=
 =?utf-8?B?dWpIUjlFaTZ1MkRDNFZqRHl4dlRTKzZOWVJMWXpDdXhxNHpsUVU2Y0lXUXVk?=
 =?utf-8?B?WE9vWUpKOTlwSmlDZS92bUo2UzdKM2FCay9SbXZ5cU1aanZwUm9RU1RvalpH?=
 =?utf-8?B?WnBHWDdONWRCbm90dExvRm9TR3RudHcrOW1oRDd1bURNNk45ZVdwMnhzNXpF?=
 =?utf-8?B?R2pCbDkvMS9tMkwxa25JMlBJS2FlemxGWnA2YklBSUxCallTTkYvUCt4dFJi?=
 =?utf-8?B?VVZ0dGpmYXRSY3ZvT3ZraUQvT0RIT2NXQk1rZS8zTElhVnFKK0hLdjYrTUNH?=
 =?utf-8?B?NFpKM00xREpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TStKMmEzRldnNEJjL0tZcDRJQmR0Ni92MWhUdzBuY05zOVE2Skt6bzBUYXZG?=
 =?utf-8?B?L0NHaDZ1T29FUElxOURGRmtuOTl1a2wyYUVwNzZlaVhMcWdyRWNkVVpMendF?=
 =?utf-8?B?L0x3L2hmSWVtZW03MFJEN0NrWno3TCt2bHR5UTVvNVpEUHNFZzdTVTZBMVJL?=
 =?utf-8?B?SDNaNHpNMjBOcDdERmxEUE54cVRBa2NKOURWUEpyNjRpNWY1ZjBlOFI1Y0hh?=
 =?utf-8?B?aG5SbG90UkZoVlVtY2dPSTF4YUQ5Z1hIeTBJWDRBQ3p1ZTdvdFFkKzIrRmhx?=
 =?utf-8?B?d1BaSnJJeWRmNENoUTVlZTdWUDc5WmpzazZrNEgzaGJCUStVT3J6clpPR2w1?=
 =?utf-8?B?cUsydktCUHBRRmNJQmpvK1VhRVMxcFBFcFltNkhuYTlldytWQy9jVGFWMmtl?=
 =?utf-8?B?RzBUcTdJVWNRSVVMNUg3TGNRWmlYN2FkU0dpelkyMzNUemJLTnNKOVg1eks0?=
 =?utf-8?B?RTN6MVc0U3BHMVFzKzc3QkQ3UHV4Z3oyOStoM2YwbDlpNCs3aG9vYVk3bHZO?=
 =?utf-8?B?R3JLeHMxdlRCbTJKeTVSdGpYUUw5QnVsZXlEMDBzSi9QMVZoWkxvVkVhQUov?=
 =?utf-8?B?cWk3NlFBekVZV0lUNm5iQXl4S3hPV2FUbzU4b0lzNU5xcGxRbnBkSXpXRFBK?=
 =?utf-8?B?RlhXcktpSDdQZU8wbmgwaEtnNGRXUVNpanM5Wk03VXdkcUtxaXpVdmRSK1ll?=
 =?utf-8?B?MGhtZW5aQ1B2bkpqczJuS1k3S1E3dGc1UVpZZjNXVFBrcmNXL2hMS2pPMUp2?=
 =?utf-8?B?SlB3VkNyY1JPSGZ3ODFnYVRIRHc5MU5IQnMvczUzZHBJN2x4SE5rNmhGczM1?=
 =?utf-8?B?bnVDMVZqb0lrODBwNGp0WmxYTk0yQVhob3RCeml4VkRxVGc4bVA5VjdhcSsw?=
 =?utf-8?B?d3pmQWF0NUkvdno5NUJoYmUwc3lPOVlNd3ljSkEwSHo1SXNjWGFQN1kwd2ZB?=
 =?utf-8?B?WXJ4WGFXeWJvd1pVK2l4YWJFRytJbmN3WEo3YlV1S0JRVXgyMUIxRlBod3c1?=
 =?utf-8?B?czJQMXlvcHB3SHJtSldWQVFrN3FIS1NDNUZkUVd2OGVVVklFWWpTd1I0L0hu?=
 =?utf-8?B?cWl3dk5yZzAyQkY2czBCZUZGSFI1cVJLQTNqTm9RZjB2bDRlMWtqMVA1ZHpx?=
 =?utf-8?B?VmpYTk5QMWFkTXhMQXFtbHBzMkhSNHhsUDlXL0tlTUtpdlBMR24yTEM5QVJK?=
 =?utf-8?B?UWg2NU9pZUd3TGdIZVRxTUNTOTNZRm9JdzU4WEtlWkRzVmkzeUdoY1FpNnhF?=
 =?utf-8?B?b0F0T3lmcU9jemFObHB6VWo0MmtmRzcvL0I4VjVCTG4rSTJwZnBRdjUvbHN5?=
 =?utf-8?B?aFdkNTFFQllpT0ZQbnIzZE1TU1V4eFZJK0NTME9nM3U2Ry90eDJvRUpVVlgr?=
 =?utf-8?B?aXhRNXY3dzZNREhMRm1hUHhIVDJldnNCM2YwSWdOM09XcTBuSUIyVnRlc1cw?=
 =?utf-8?B?UlpjMzlSM0xIR1FVSTZWQS9xbEVrZ2U3NDhleDFwVWdRT2NwMnF2N3N5ckow?=
 =?utf-8?B?VGtodUQ0ZFJjeUpVejNWWmx1RVd2TEp5c3RTTGdOYnZIcHRBL1dFUWFRRndp?=
 =?utf-8?B?ZkJxSG52U1FGUFpRSXdNdGRrdjBNMEl0OVdXdXJLNk9RaUNXRmRGZHRZc0dp?=
 =?utf-8?B?TDFySVVIaGZnaVY2YUlUWE54dGdXRDhqV3FQRjJ2TU9jeUdvWFkxT1lDSndn?=
 =?utf-8?B?d01sQnpIWmdoTzA5U0dLaDRqeXkxaW1DbGJvb1J0QmVOaTFDMVU4a09VR3dI?=
 =?utf-8?B?WWdYa20wWmJiZURJRzNlWGNqVkEvSXpubWJxSmIyZkg0Q0xqajAyNml5T3pu?=
 =?utf-8?B?YmdMNjBZTlBvN0dCU1NQb0d0enRld3NVZ3UrN3V2c2Jad3R1R1MwMmdpOStk?=
 =?utf-8?B?MmFidENmaE1INzg4Z3RtTkJiUWx1S09yYzNKV0RiSjFTczNiaGxWUTV3K2Rr?=
 =?utf-8?B?YTVxN1U5NWdhUHJrRkxsQTMzNCtGR2dVN1BtZEczL2R6d1hLd0hsdkFTdGFR?=
 =?utf-8?B?RE9WQXJjb1p1WW4wU2dCK0g3NlQwRjFCNE9mczVDV05PWXBtRk5VZ2IvVytU?=
 =?utf-8?B?YStVVHNWNDBKbU9mNDNNaCs4c0ZkTGFQeDV0WnJLUUhrc01WaHdjUy9JbE8r?=
 =?utf-8?Q?xvndSSNRybRkrIVTeo6o++eMt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd7036f-327b-4414-2f8b-08ddf1ad8ff0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 03:36:30.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gt5PgDzTQAHyO5IRbc1wapGqvTLELStAV3Sa8v8m9zx4ItGy0a2kTV8R5IxaUOpnlNQqHJuzmmqd+jHTGghqqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8526

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
index aafaac1496b06a6e4f0ca32eee58a9edf7d4a70f..37f422b4b1ef2af2b4231a1677161aa24e07d0e2 100644
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


