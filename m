Return-Path: <linux-kernel+bounces-846229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57914BC7531
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31C014F3C1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4588623ED5E;
	Thu,  9 Oct 2025 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nlVkLM0q"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D423C4FF;
	Thu,  9 Oct 2025 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759981726; cv=fail; b=vAjj9Kyb8ADK7N0B3d3ji+1IEafcYgZWNzJ/8JkfTA2XM+Qrk/9s2pVwFShciWScbdvEt5n6T7MG3tRorXwVOne03j4e/pi9cvGYTjoXFmhWQ/7mfr0FWIGefQ/bEOB7Mcc9DnNO7lMAfc68IlqoZdAl0ggixwPY6bu5DZB4YRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759981726; c=relaxed/simple;
	bh=LMMWz1Rjdrmydxqbxi44qTT4bO+jr1eCZC17C4TuEIQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ltHuiyaUmrPXckF5mJ6n6X0ZVLZi+j7PeA+Cy+vlYo1LjUyGQj6MxY5f5ONnC0R+9lOzWV9UgfzxotsPvleoO5KtpjbH3Z/2N8k7hPcgB7LYzb7tAj2+9oDtRLY5c2VxZQluPiYPgz4a9qWhWrz6OssR/0r/q2mF+LFc+rIQIjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nlVkLM0q; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCx32W8Z0d6KQIPREUJlsOh4FrshQ7cmxJSuJIVEMPpaPBviArjXeOdpVce5GU06N0Y0Eq07baGYG6xBogpcJ1CR4VbIqtICvevaQAuuzAGwXDPuH8+SwtoI3kLEVmDyAfi5T3D7E4xbSLs9WCYTHjQq4IkX6mNYHymSKxj+bGMXEQkqMJ/Jc3P61PCMw2a6eLemU/n87AILe5CA5X92EtEzHu8/jmdpJCBZTC5q2HE3iX8DVJ5sHJXS1onMC/3C+I/SPXh26LCZQ0bh2fSeuXP2yPeg+h46WyyZAM6rKgpMOPR7FBNLgonaae+2oKu1MjNq59OfesTk6XuqCjopug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5e/q+62StXU5LrlUiprYrNmetBl2i6Z7poJOrmjywA=;
 b=lUMcLU60FCkYN24ZW4bbnFaFwZVeaost1s0yRZ5ofq/BwIf4cxmDZie70m+hguQWFry1xEgT44wYt+rukfehIgyZzggItg0aK9EvIugR3HefThwcqlS6EMHJISkRWMaGZM1Ojg7f1c/OhY8KXaQGWW1idkNy41ZTlnKlpcwD3W4r0A+YyczqgH63G04CwfJ6BCMUNqOUqmH1kAkBU0G6szj/qW/3mZzqDsWLIy9oUh2iHqMZgxyhv+ZJrcvoXohrwlExqayK18vy+EifQAxwpVhmfMOWtbElPbNb9HKTYSmKN0b5F/j4q4mY75+JiDDtBhnb4QGsi2px11jhNvNB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5e/q+62StXU5LrlUiprYrNmetBl2i6Z7poJOrmjywA=;
 b=nlVkLM0q9hSSxnjU2bvhtlb7Tp855mGDAtW1sguxQHHBe+VcDTM5Pu5F5xn30eDzFl3enMdrB2tPprJWZdeXbbOCigCDZ7E8LyvKd/o0ZElBFlDw5jgGNHb8QpwH+deyxEhAt3SNgSqLc+4UQdGiuaffVmsKmdnQmcLu/D68crD0K4r8zS77HxOq8sFP4fW0klkPITyJCMHB/eH4FWLwQCkqIArTPBN0XL9z/Mj0oHY4KnxymS8hbJn9/XQ9U1GPdS87OeefN3pI4R5mWiwI3oWlZCDJb33BALAcJ3KaUNvk2jwYVKqQe18Ooao14l24Um/iBYIP+QfMYUkIVPzMew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:48:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 03:48:40 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 09 Oct 2025 11:48:15 +0800
Subject: [PATCH v5 2/6] clk: Introduce clk_hw_set_spread_spectrum
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-clk-ssc-v5-1-v5-2-d6447d76171e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759981702; l=4024;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=LMMWz1Rjdrmydxqbxi44qTT4bO+jr1eCZC17C4TuEIQ=;
 b=mnW6Ew6neDJ5qD9xxeSdojdbAagas0Q3Lt0OLTG42hUpJuFU8PWZ2+rtHbc2UuZluwEr44eFo
 UHdlInYnfCdANyJ565w8NucNzWdBLoKZmIkyliXwwEgPaZwRmpidLNA
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
X-MS-Office365-Filtering-Correlation-Id: 1443f7ea-9080-4e10-e1ef-08de06e6bc59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S05hVlRtcWtvL1JRSFJkQzNCNHJlZi8zdnZNYjNRalM3T09HU0ZGOHd4RzJQ?=
 =?utf-8?B?WElxSU1zQ1prVEI3azNHYzhpa0ZwOFlNQUNsbTUvNkx6SU5GcDFjMzR0MXZI?=
 =?utf-8?B?YkR3aVUvWTNId0FCanU0VU00d2I4U3hRMkIwY1pjK0x4NDdqaGU1bXhNb3dS?=
 =?utf-8?B?cUNaaXpEcTdTYlFxa1dhN1kyTXdTRlZ4ZzJOODI3bDJMVytmREdHOHh2ZG55?=
 =?utf-8?B?eWlHWHp6MFFjVnpnQ2pkWWVGUGVFV3hUUExrVVN4K2hFUDdJOEVIckY3ZFNM?=
 =?utf-8?B?UHhldW9WcmhOb0RaVjBRSkNyL3ljYlRTQVdDdDFLVVNuOXdxb1BzVVpjWFZG?=
 =?utf-8?B?NWZNdWVrVlN0VXRHaitOYklZdWJtOFFXN1dCbmtoYWlVMVNmYWUwOXVYWGs1?=
 =?utf-8?B?RmdQbXRzSy8xcUJ5VTNWUGVlSWdXQ3pLcVZqWjV0Rkhzd012eUQ5Y0k2eStU?=
 =?utf-8?B?eERMekFoemNHWEhDYVNXakJJN041cnhIblBjdnNmQ1orTGJFYXY5aVJ2cFFq?=
 =?utf-8?B?bTZjMDA0aXpHMzdPWWZERzNhMWU3aVErTjdFT1liZ0FoandvWDdkY1hpY0Jl?=
 =?utf-8?B?QWJWSmpxTmF4eEh1a0czSkJqaDJ0bE5va0FhZFd3RUdEL3huazBYUzZVSzF3?=
 =?utf-8?B?M2w2cFhHMUw2TThLTzFFM3lLNVR1QkNBVkk2ZXhUV1FuS1RZVkdWbzlWalZu?=
 =?utf-8?B?VlNHL05RL3hlMG5sYml2Zjhld0FUUFFVdjNVZmxSVDMrV2pobWhoZFRxdVp0?=
 =?utf-8?B?Qkh6TjMwNVQxSEtVbDRDNWN5R3g3MWdtcHBaRzZFdVJBRFQ0a2YveloydGlw?=
 =?utf-8?B?aHl5VlR2RmY4MXZNY3BwcXp2VkxvSlFQSlNUb0JrclVCSUdyZmtyNTV4Smkv?=
 =?utf-8?B?dkVkWEhKWjB2TE1OVElsYkNFOWFjUzdrai9scXMrOEp1am9DT1h5VWRJUVJE?=
 =?utf-8?B?cFdOZ2RJZGZEQ0p4QUFzUGVqanY1bDR0UFFUVDh1d2RvbmY5T1ZqUFZJR3l1?=
 =?utf-8?B?OE5rbmJXcUVRREs1MWhEOWtzbTZvMjQ1ZnAyN0hvbmZjckQrVHhZQkNRZnRs?=
 =?utf-8?B?MFFyazNBMnl3UldNNFBkYmJ5QmRtV3Z5MzRML3RrTk1uTXRlMEM3dTRPbTlO?=
 =?utf-8?B?UzNJK250Vlk5Qzd4UWxhYTV3WnhTL1lsSzNZeCsvK0ZyY0hlS1RzSHBicnV4?=
 =?utf-8?B?U21sc0REQ1J4NVFaRVd0WGxxNEU5dTZ3OEJuam9kYWtZeW1NMjN5WkRVM21v?=
 =?utf-8?B?UDhyWWdSUnpyRnlQUmhaeGVWYjJ1YXFPN0crUVRZenlRSjFueGxPSmMxaWRs?=
 =?utf-8?B?bWJjQlJic3k0dVpiOVhsaVd6SnVTQnZRbisxK20zL3JLa0dGVE1vWjBPSFN1?=
 =?utf-8?B?akt1UHpxbExBT1d3RklCV1JVZER4cHBIV3kzMnZSNU5TUmEwUVpHRXE0c2cr?=
 =?utf-8?B?ek8vc3I5QXMxNURvaEMzUldNanBhdnc0QVJPNWxOVUc5UVVYVnVZWEgzd21H?=
 =?utf-8?B?TUQ1aVNaeWpXbjI3NkdBYjFBNEpqYzRsWmE3US81UjlweU1iaE01TG5ZMk50?=
 =?utf-8?B?WlNYTi82TDNCSWlYbXp0ZnZVV084TFpSSTNaUVFFWXRHbnBhMzlPczJtZzk4?=
 =?utf-8?B?NTJMYmxwOFM5b21sWG5xTFBKS2RyOWZUNmJ4bFFIenczQ0F0V2MwOUhSZjdH?=
 =?utf-8?B?NTlMYnZ6M3NQeHdHN0YzeWZ2YjZwMnExRDlWc2hoSGorZzdkRzNHUEhhaktq?=
 =?utf-8?B?RDdFTXVFT2s4UGsyeFN4cVZGKzV0L1V1elI1OHFqZEVIMkZpUUxSN0hDM2R0?=
 =?utf-8?B?QVl0NEpiSjhjSmpVNTdhOXFBZW44TzRZcXE4akRXNUk0cWZkT1dFZG1wcmp1?=
 =?utf-8?B?TklveDJHeEZVaWZGUTJUMFFLbXJaamVEQ3BUZDY1V3RYVlIvUm95dzR5QWJv?=
 =?utf-8?B?dUJmaUtxbC9xUFNldXhxVkd0MlFsRG9QRDNLUlYyRm9iVlJtcHBsL2gxR1d1?=
 =?utf-8?B?TDhmb2hYQ2EyK3dNV2JlS1F1UDhQTG93UFNHMGhJVTYzcWI0RUpSME1EQ2p2?=
 =?utf-8?Q?cTNqPN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3hTQ3NDc3J4U3Q5V2hZTVVLVzh1ZUd2Y1pLZnZOZkJRcE1CRTdtTURFdy9H?=
 =?utf-8?B?cVFmNkhUQmdHaXVqUk1FS3RGRlR1NjdnbHk0bHNVQzluYjVtNGsva2xGZ2gw?=
 =?utf-8?B?YldjWDlLS2lpbWltSEhEUjhQVWR1V0xRUUJEb0FzVkd5VkczbzBXamFNcEN2?=
 =?utf-8?B?anNQeFRTeGMvRDdSRUxya3dCdTd2L3VvQ21oT1JVcm1nTGRkdStGbW9WaUlQ?=
 =?utf-8?B?d0UzNHRIT0lmUlZEWjFQWmFvYUNTSnlSREU0cG1GUnMzdW9ObllYb0ZkaHRG?=
 =?utf-8?B?QUIyT0NyTGk3VFh5SGo0QXJrZkNwZ05IOUNqdzI3Q2MrNmNkeFhTdmRoMndy?=
 =?utf-8?B?a1krVzB5Qy9YT2hiRnEvMTBUQ0JROERzSm1nZFZSd00zc3Z0b2MrcW4vbjVO?=
 =?utf-8?B?QjQ4RXhYd2dQbytEOCtkMDR5Q0NQbnpQVFdORHJjRCtHQlVqK3RnbDA2TkUv?=
 =?utf-8?B?OEt5QjdkZ1dGZThucGMvTUhTNzExNFR2YWdudXFEdlZUczQyUHZIWno0Tk9N?=
 =?utf-8?B?R242TkNTSlFWa0tvUitTRDNkZnNSTGlmdExvUVdPeGFLM1F5ZkgvbHFHWVVF?=
 =?utf-8?B?OEhsTUp4YXRRaiszQnUwTTdqdGQzM3J1TW50WmdpQkJnUkNybkxrMTVUcEY4?=
 =?utf-8?B?RzYraGpuV093YnlGMlU0K3Rkbk15dmFHY0c1Sk5Wek5rdlRtdzBNbCs5aHB0?=
 =?utf-8?B?Uk5ZSkRkTjJ6T29KZjdJMVJ4SEV6NmpBRlNFWWlVbzBBb3V4YUVpU3BHelQx?=
 =?utf-8?B?dXNPOFZFNi9tS0Qxb0dpUC9XM3BtVEFkMnpkcUZIMkFsZlUwT2VOTmM5ZXpM?=
 =?utf-8?B?djhYTERGVTNvVlJKUlNzcFdGdmxISTMyVXorK1VWRzcxN0tiOVJMTVB1VzVs?=
 =?utf-8?B?WERMVW5mR1ltSHh1ZEc1TDdJeDZ5TXBqSitqT29Bc0FMOVhJUkVnL1ZyQnQ4?=
 =?utf-8?B?ZmM1aVJ1ZVRxUkRDOVZpYlVMT3d3ZTZ4QWNvaWFhUVJsckk5bFhBdDFkOE5h?=
 =?utf-8?B?MVJLTlo5RlhoaXRGSW9qMHp6Q0VWY1JLcmRRdjFhSUI0Y2hXTWJ0Wnl5Tlpt?=
 =?utf-8?B?SkpuU1BCaE81WDZQY3VBTkhjczBnbEc0WnVscmI5UVhTNGMycUNXcTNXRS9v?=
 =?utf-8?B?RFpMQ3hCNmdNWldSTVZwcGE3RENpeXpYeklWYU9EcXJRUjhYQndXSThkc295?=
 =?utf-8?B?Ri93ZzZ1NDlUVUNDVkFSK2kxTGNDd0JkblduQ1FOenNEbnIxR2syWitSSDgz?=
 =?utf-8?B?Q0M1WEo1K0IwaEtsZFBzaG9Pc2tKc2djOVZJK2dlZE9KcFdtQmoyQTN4cDQv?=
 =?utf-8?B?d3JCQ0wrL3lQcEtjK0U4OWIySkZ3aFJ4RXpGdGI4OEtlVmZUSzd5RkQ4cUx3?=
 =?utf-8?B?SW8rbHN6YVZnWHorYkV6TmR1dWh0RjEyYWFQYjJpN0F0V0RGMk9pSytLSVhK?=
 =?utf-8?B?MEU4aFoxdnN3eWNFcnk4RjFObm1BL3Zhd1R2RGxpY0pyQkwzQTBrcHY2MWYx?=
 =?utf-8?B?c3NoVWdDU0ZpMFliNXR2cnZUckM4Qy93TlhkN2JOUEVSV2c2dUdIMHBDSDRu?=
 =?utf-8?B?dnhMK1FOdG1meXhkZlZBdHhLUkgyUnEzdGM1U3VwOE5zL0s4am5OalZOSjNk?=
 =?utf-8?B?Wjd6czlJaUp3SEl6K3ZmSUlTelgzdys5NWVBVE40dlR5Q0p2emMxWE0yV0dq?=
 =?utf-8?B?Mnl2UmRJZW4vT0NOU1hVQ3ZKRUNDa3FpUXEzSTQ4UTl2Zk5hMWw1UVRsOVQv?=
 =?utf-8?B?Z0svRWRJYlljMzh3eW9XZjZqWjRFQU1aeVZmbkNaeWhyZDJaUi82SG9BRFhU?=
 =?utf-8?B?L0xrK2h1V1d4bTljemZ1S0lUeUxkeUttdXQ2QmxxTEtQdkoxbXNjc0ZJOCtz?=
 =?utf-8?B?ZWZqK0J4OUJvRzJuaGtBNXZQM0ZUaDVPbC9naWpWa0ZmUGJLdnBXSkZ1Q255?=
 =?utf-8?B?ZTY1SmdXZEwwclhTeFJEUXdZbDFLVGJnSWZXYzZhUFhWTmlyTjJkSmw0K2hJ?=
 =?utf-8?B?SXFlQ0RpdUY5KzY2c3Bwd1pieWFLTnFpdlJOOURITFA5WkdubHVFYitkK3k1?=
 =?utf-8?B?Nmc3MFJNWEpRQWRkaDlJLzJrNGFud0pMNm9oMWF3OVI4dkxHZWdPUWNHR0F4?=
 =?utf-8?Q?0FGdc+0XyzUVVwmTWbKj7DaQH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1443f7ea-9080-4e10-e1ef-08de06e6bc59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:48:40.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5f9DTaMmwvuSkviNCg1BG6gsVC2yAjEA3QAgHwfpIiv8oIZxbaO+sfi1WNEi/KuLGlMxVDleekwc7uaONQUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

Add clk_hw_set_spread_spectrum to configure a clock to enable spread
spectrum feature. set_spread_spectrum ops is added for clk drivers to
have their own hardware specific implementation.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk.c            | 27 +++++++++++++++++++++++++++
 include/linux/clk-provider.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 85d2f2481acf360f0618a4a382fb51250e9c2fc4..6cd941a729590b501d66101e352b99e51ca18464 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2784,6 +2784,33 @@ int clk_set_max_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_set_max_rate);
 
+int clk_hw_set_spread_spectrum(struct clk_hw *hw, const struct clk_spread_spectrum *ss_conf)
+{
+	struct clk_core *core;
+	int ret;
+
+	if (!hw)
+		return 0;
+
+	core = hw->core;
+
+	clk_prepare_lock();
+
+	ret = clk_pm_runtime_get(core);
+	if (ret)
+		goto fail;
+
+	if (core->ops->set_spread_spectrum)
+		ret = core->ops->set_spread_spectrum(hw, ss_conf);
+
+	clk_pm_runtime_put(core);
+
+fail:
+	clk_prepare_unlock();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_hw_set_spread_spectrum);
+
 /**
  * clk_get_parent - return the parent of a clk
  * @clk: the clk whose parent gets returned
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 630705a47129453c241f1b1755f2c2f2a7ed8f77..9ec25bbccd613eafd77aca080dd7f51b1bfdadc1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_CLK_PROVIDER_H
 #define __LINUX_CLK_PROVIDER_H
 
+#include <dt-bindings/clock/clock.h>
 #include <linux/of.h>
 #include <linux/of_clk.h>
 
@@ -84,6 +85,26 @@ struct clk_duty {
 	unsigned int den;
 };
 
+enum clk_ssc_method {
+	CLK_SPREAD_NO		= CLK_SSC_NO_SPREAD,
+	CLK_SPREAD_CENTER	= CLK_SSC_CENTER_SPREAD,
+	CLK_SPREAD_UP		= CLK_SSC_UP_SPREAD,
+	CLK_SPREAD_DOWN		= CLK_SSC_DOWN_SPREAD,
+};
+
+/**
+ * struct clk_spread_spectrum - Structure encoding spread spectrum of a clock
+ *
+ * @modfreq_hz:		Modulation frequency
+ * @spread_bp:		Modulation percent in permyriad
+ * @method:		Modulation method
+ */
+struct clk_spread_spectrum {
+	u32 modfreq_hz;
+	u32 spread_bp;
+	enum clk_ssc_method method;
+};
+
 /**
  * struct clk_ops -  Callback operations for hardware clocks; these are to
  * be provided by the clock implementation, and will be called by drivers
@@ -178,6 +199,12 @@ struct clk_duty {
  *		separately via calls to .set_parent and .set_rate.
  *		Returns 0 on success, -EERROR otherwise.
  *
+ * @set_spread_spectrum: Optional callback used to configure the spread
+ *		spectrum modulation frequency, percentage, and method
+ *		to reduce EMI by spreading the clock frequency over a
+ *		wider range.
+ *		Returns 0 on success, -EERROR otherwise.
+ *
  * @recalc_accuracy: Recalculate the accuracy of this clock. The clock accuracy
  *		is expressed in ppb (parts per billion). The parent accuracy is
  *		an input parameter.
@@ -255,6 +282,8 @@ struct clk_ops {
 	int		(*set_rate_and_parent)(struct clk_hw *hw,
 				    unsigned long rate,
 				    unsigned long parent_rate, u8 index);
+	int		(*set_spread_spectrum)(struct clk_hw *hw,
+					       const struct clk_spread_spectrum *ss_conf);
 	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
 					   unsigned long parent_accuracy);
 	int		(*get_phase)(struct clk_hw *hw);
@@ -1430,6 +1459,8 @@ void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
 			   unsigned long *max_rate);
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);
+int clk_hw_set_spread_spectrum(struct clk_hw *hw,
+			       const struct clk_spread_spectrum *ss_conf);
 
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
 {

-- 
2.37.1


