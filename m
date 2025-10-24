Return-Path: <linux-kernel+bounces-867972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6653BC040A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2235F3B4B92
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773A1B85F8;
	Fri, 24 Oct 2025 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QRj1jkVH"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A0D531;
	Fri, 24 Oct 2025 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270381; cv=fail; b=DWfDlVkub9lEbt1pkd6Sqd0wXpyCaDVMxWXTtBIbAqRminbmQSGXwzGqFKqEJ6k2qV7wNcxseudcVhFirElEZvuH188nIJlitirFUUUcnBV6A1U3FwUhEIMj9wmwnEAElyHHgkU0oBtKDsNIO03TSf7iLRJcsRuJPfY5ilO/7lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270381; c=relaxed/simple;
	bh=QW/Y2XtHBrEB4kfJixw/V6m56an9GzNH9oy17+zFtDg=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=oU6v0zhTAFzkf0o40IxNS2zFaGTR5r/Xmi9Knr508h+XV13SVgqoU12AIStucdlS6CUz21zbjLbKJgaZc2hHlO/FCaxDzxfH/4BVlsDi475yJXBA3Tnoc7Te5Wz60JLIKnGOl/9s5l9n/R1X1pj5iulUShWBkDS6mAtH1k5ZvTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QRj1jkVH; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSkbRaoaaKdAPDfeRRKHy76mDRO6SsKVJ2IfsAjVpJl3teuKbdttE68Y0x0YKEdtXuu5w7BrAWUolu5L2LbWKfwJQpdvicTrHSAoDItVq8NPU7NhyZJkGNc0sLAP8mQWoElzKNYjkR8G8sTyqO0MclujFXmm0V1WJzRp5aqr9i17snCIJYOrq0mP9iYEc9mEcmYokAPS9tVwCWM8RIeaIMQOP1VViBcHp4WLK+Agw8YJsBGonPP8IZpQX3s59sjvkCp31dbgaQ68kGPLCFys8r0DhWqrV7KLDkEpZGOOsVowADWG3ZY3WdobiNFCGeNccqV5ims2We7aAFBW7ZDU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gooj0TaeEHK/sqkhbbrwjTWvbvT+eybNYoT9jlpByV0=;
 b=fgFV5rg40OYBQWmDqUdFoK1NifqtA2NZ6lm+evbMrCZHkTuPFQCS2I2R6+NCnH+EZQYYfd5punITGHGO6JM4uGo3L4lC+Va7FSUdgoNNtitNhDXrUIknEYDxjqWJEgRoTMdWkoQMEg4VfkYUioiH09qdx4brkyqb7+c+J18601QmN08S8xcR8eqSYD5KGW051dvtZeOrtJqSRYVirUd1x+hbWFFWev+ugPrfu2bu0CI8s4aodH3dJnpxuCaIfKzeW+2svj7oNK2qcJmJGKsuHLFKbojIwph5lDaJmitnYRb50eUyBX9zz3YZiVXA0f0MoL6izIOFKwt2QD0etAZ9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gooj0TaeEHK/sqkhbbrwjTWvbvT+eybNYoT9jlpByV0=;
 b=QRj1jkVH4AA3qEsF+l1G5GG7auCpa+W1K0/FQuK13Djdd1N34old+trEF2OZW2dcdvSNZKxozW19gfFlQgVThxh556YchnW05uUNThfCg+T+BcDKQnRBHKEnmN9FV1+eW0m4EVVXT9X0Ql87dMOeCmgOdubJM9MRKRbNjj6aYa9p8DVEvkllKWjpoAT0QxMtfw9bXArUjRqSunkS+DATrapirOiXzDH5l0zvXU/K8SytXo5yph6z+Dvy26gzFey2ZL1zYsAenUk7sWKTM+TciVwdfcLnwCcyFWrqQn7DIWN1MIJlcZI9m8TVnUG8ikRglEX9bacZBcfiIOzt5Jw2Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7303.eurprd04.prod.outlook.com (2603:10a6:10:1af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 01:46:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 01:46:16 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 24 Oct 2025 09:45:51 +0800
Subject: [PATCH v2] clk: imx: imx8mp-audiomix: use
 devm_auxiliary_device_create() to simple code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-auxiliary-v2-1-a353dc9e6b1a@nxp.com>
X-B4-Tracking: v=1; b=H4sIAE7a+mgC/23MSw7CIBSF4a00dyyGhxpx1H2YDuiF2psoNKCEp
 mHvYscO/5OTb4PkIrkEt26D6DIlCr6FPHSAs/EPx8i2BsnlWXCpmPkUepKJK1NaX0d0VuOoof2
 X6CYqu3UfWs+U3iGuO53Fb/2nZMEE40ZcJnNChdb2vixHDC8Yaq1f9CqJ56AAAAA=
X-Change-ID: 20251023-auxiliary-3998bced9cb9
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>, 
 linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761270366; l=2365;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=QW/Y2XtHBrEB4kfJixw/V6m56an9GzNH9oy17+zFtDg=;
 b=KJgqkz0HOw/hNvVt9dCLFFtbedsec0tw1OlqJ1DygKkzXLsIXXNf/5zC6el86sm2HFRbwigDd
 hBmFGCC8tCSDIZn+4Kkx2bSWiUjtfyiHCiD+hJSWDoFoxs7fmQlGzMP
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8e0d92-8fd4-4456-50c4-08de129f1eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDMvRjd4elJySFhkQU8yNlhoNXo3SENBVll0Q3ViS1JkYmcvSVcyMWs0Wm1E?=
 =?utf-8?B?aXh2bzlqbjRVTlJZazRQOEpZVjhiOUNBaSt2em8ydFRkTHZqSXJDTys0VHN2?=
 =?utf-8?B?dmt5dWZsUzAxaDVMMlk2UHN4b2ttQ0dBZFJjM09IM0VBcHN3Mk90QVozSTh2?=
 =?utf-8?B?eThyaHdkaGNlWWRYbmpua2pWS0NNT00wT1ZEczNhSTQzN3FYN3NmdHhDdlFR?=
 =?utf-8?B?aGVtWStEY3FHb1ljUXAvNlcrMDlhT3BNVmJGSUQydU5WNmUxWlhzejhUMzg2?=
 =?utf-8?B?dWRObUNKVk5vZ2svYjFiWFA2VzRPd1V4V2lvalhGalArUC9KOC9COUlHK2p6?=
 =?utf-8?B?OHdnRi8yY0ZoZXNNb0thV1hHblAvSUNGZERLZno2RC81Y3BRV3RQTmJZWTFO?=
 =?utf-8?B?bG5kRGpmMERhVUtwWHB4NEkzc1VGZ0RrVmh0dXp6QnJBY3NJR2xONkZSa01P?=
 =?utf-8?B?NmtCRFNyNVNsZjVPcHBPUW4vWUIwVjA3SGxZKzlCUDBJOXJsRDA3ZTF0UkpZ?=
 =?utf-8?B?cElMcFlHMEF3bDZjYmFOT1crZjAvZEkzcEd5VkE0bFdZNGdWZEhCWmRyeFV6?=
 =?utf-8?B?R3BMd0Y1OW4vNmlKUVNZYUV1ZnE3NDBqd1FkcG05cytPMGdkbmVYcmFRSDha?=
 =?utf-8?B?YjBSUlM0ejVPdm1kRE9Hdlg0azlmTTd5UHV1ZmtMQ3hseU8yWERQblh0NWV4?=
 =?utf-8?B?eG1wTjhLLzk2YjJjb2NIb1krS1AxOWtrOFFRSnMvU2RDRlBYM3MwZklkRTNp?=
 =?utf-8?B?Nk5lK1JSVlNCeE9tSFc4b3diUE03YXhuVFhoWVk4dy9Gay90NzRwNkZvNE14?=
 =?utf-8?B?ZWdnZUp6MkJsNHVpc3pJUEhUa3FHNVNzZG4rMHpGVyswT0oxeG1xMDM3Kzd4?=
 =?utf-8?B?dzcwZ3BEenJpQ0Z3OXd3WnNFanprN1RCalUwVDdJdEUzQ0Q0T2h1OE9pR3JV?=
 =?utf-8?B?QVk4emJLUWdNKzNzVldFZXkydzYzZ2tJVUdYa0Ruc0xubjBmcklBY24rejQr?=
 =?utf-8?B?UXEwWlhjelVkaVhaZGRUNFc1bkYyMS9NYlpuOVB1SXNwWU1Qb2wvNExreWJF?=
 =?utf-8?B?dnVRNlJLOWZNcXNVOGEraVRNWDNaRWVpWk1KY1paUm5CTU1HeDZJR2J0Vy9x?=
 =?utf-8?B?WE83K1ZVZGJwVG0wZHR2dXJ1aWtBdmtpcGRMSUdnN0pNTEJlTXdLVWhaMC9U?=
 =?utf-8?B?NE8xNHNJWHZuNjRERHl0S0ZHSW9hTjdXM2dXaXRQcUM5c0prOUMwMWNRUnZh?=
 =?utf-8?B?Z284U0VKbVh1Q1RSREhRM211WEFBZUJiTFNYdW41dFZWY25iRTQrc245eGU5?=
 =?utf-8?B?TlhHU21hM1VKK2tvU25ZVFpOdForZlMyVHBrUm1rWWFXQlhlcDdic3k5bzRj?=
 =?utf-8?B?UzJ3dlcvR2Q2akl0c3BCZ0k1RFZxeWJBbE9FRmUzL1NKL2hVQTljMG41QThY?=
 =?utf-8?B?cG16TzZqVnNOeTh1dkFIMkZUaUkvODRKZ005aWJYVUhmcUtoS0phd2ROUWNh?=
 =?utf-8?B?OGxUOWpmcS9yaXZWUmNYV1Y2VEE2WlZoWndlWU8rRXhabnFLQ0plL3A5dzRi?=
 =?utf-8?B?OHhWbnp6Mi82aTlucjJQb3BFL2VhN0UyWDlWa0wyd1VpUlEzYnc4azF0QXND?=
 =?utf-8?B?bTc3M0h5UjFPNVlRUXJ1YVJaN01nbFZzaFNJa25uSlFxcVdMUVpzb3pMeTJp?=
 =?utf-8?B?QW1wTDk2aVlRT0Y5Uk5XcThnR0YxTW5HUXRwR0pTZ2tXUXZBeC9Rd0R0cktP?=
 =?utf-8?B?K3dTUEJZODdBdm9jOFduN05DNTl6b0ZSOWlyT1N4Q2NqMFFTTm1XbFd1QWpF?=
 =?utf-8?B?UHBqWHM0S1VHNndvc2JqT08zL24zek45SEozYWZ5VENVQURxTy8zbGJHUFV0?=
 =?utf-8?B?amJMYnhXdXlGTW9TK2hBd2JQMGdrMVZuWEpuUUc5YXNoZkVrblBtOFlEY3F1?=
 =?utf-8?B?cm5JeU1UczlqeHZRKzBWR2NzaGltYVVZUmdxU0pHU0hqWVQzcHZVUXV0TU4v?=
 =?utf-8?B?OHcrNmR0RCtsQS9Dend5K3pKTGs0dEc2Q1NpMll5cjBIWXhTU0dLbldzTGVT?=
 =?utf-8?Q?/uTbq+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R25iM1MweHkzR0JZQnlKbGVmVHlTWlUrNnJ6RmNQQ1VUYUJsMVBIMTUrNnN2?=
 =?utf-8?B?VVhqZVJhYTFQV2E5T3E0OW5FOXJDS0o3eEtBM3p5ZVE5aGFGVENycFNGQklY?=
 =?utf-8?B?TUZ4NW5YWFdMS2V6N3MyK0k0S0swSzFnV0tqckVncWZJeTBSbGUxdDdkdWlv?=
 =?utf-8?B?TEJCTkc3eXpnVmFkaDhzNitnWXp6MFlLN1BVOEQ1ZWFGSldSSmVVZVVMN3I1?=
 =?utf-8?B?RmNUQmh3TEFoYTNLZ2xyck5oajF2RGtrVjNtUXRiWHRpNWEvRWNCQmhkK3pl?=
 =?utf-8?B?YmN2WHBpeXlEZzFmeGFQakh3ZkpvM1FUdFNsSDhuT01lNkVLTzhOUEJNOFdK?=
 =?utf-8?B?UkE1K2d3NlZVVHhUemZrT2JZV0RBWTdXdUJlMEZWMlVtMFQ4THRENGIvdkl5?=
 =?utf-8?B?dVBOcU1DTnpKTVUxaldIZ3RlSU5FL1ZkL2RPVjVoOFFoWCtzejFuS3Rxd0pQ?=
 =?utf-8?B?MEYrSTBBc0VqSGlFNGJ3TFhJWlQyYzVIZFI2eVBscDJ0dHNlNzVROTVhc3Zj?=
 =?utf-8?B?dUYzcGFzL2QrUUNiNkhvTFFYVVA0MHIya21nVVZaSTVHbERZMk0yTzZmY2M0?=
 =?utf-8?B?SDQ0YzlhRzdvMTgwMUhaUlV2enROWW5uKzBrUW9KREk2a0szSDlSOXZ1Qzhp?=
 =?utf-8?B?NDhjVEIvNm5sbHVUd21QVEVvUk5wU0J0L2tqTHQ2Y2RCQmNuN0ptemhySW9o?=
 =?utf-8?B?ZU5VczRLQjB5bXIxK3ZFY3lORHNHNUlRZENlS3lPOURkdDljRjM5L0xRSExH?=
 =?utf-8?B?VnRFN1VRRGtURHVDeVRGd0VvQ2JaclJhdXV5WFgvM1IrUyszRzZxMG5qVkpZ?=
 =?utf-8?B?b1dFREYxZ3pjVWxiSTNSTFVaM0R2eW5MZlBVMFRvTzNoN0N1ZVM3Wkh2bk50?=
 =?utf-8?B?Wno1TEJQUlh1SUh0cS83YzFpc0txQmZkWkFzRjJZQmRTQm44NWtQenNhUTJR?=
 =?utf-8?B?eFREOU4wb0taQWNIb1AzcjFWWW14YUZxaDJzUmRtaDNBUXJJdkdhOVJCTXBG?=
 =?utf-8?B?eHVjWWJmQlFUZjk4RUNMeXRTVzdrS1Ava1FSak5udFErV3loSy9xamRoTnVh?=
 =?utf-8?B?Wiswd3NLSWI5bVBsaURJd2dHcWlTbGtsNnYxeU4wOHo3Z01PT1JxcFJnREtL?=
 =?utf-8?B?Y2s1QlQzYm5jNjF2dVdyRUExcHpYaUdvRDNZbWE4UlNYNHBRZlU4RytvdnJG?=
 =?utf-8?B?enVuLzYxN2ZzUG9paXVBN2ZTNm9iNzlCYlQ5c1poMnY4OHA3R3FwKzNqVzdu?=
 =?utf-8?B?cXVmeGdiTDYxZ3NMVFZqRkpWdS9wU1MrU1dFODh3aldVWTBoSVZ5Syt5dXJU?=
 =?utf-8?B?ZFUwMCtvZE93MlREYUJwcUhkSHdNMllrTlVPbnVNeWdEVzIzanBSM2kybC9U?=
 =?utf-8?B?MThTWUVRUTlrbEdSdmRTazViVk0rMTBhZlRtYThDVjhWbWpNdTd2a0ZGdkhW?=
 =?utf-8?B?OElvOXlFbWpuTUh3OENtbXkwSXBTME9TRXYzM3EzMXJPbTc3cGoxSU50Uk94?=
 =?utf-8?B?Z2oyNDFwNTM4ZjJlL1Bwa1lGdDFPdUQ0YWhyR3orNXhEL0NSVjhBb1JFbnlS?=
 =?utf-8?B?YWNXSGlQaHJ2UnpwdG5LT2VxUWdmdGR0UEdQVG1PT1VQL0YyWmNhVEd3bWl1?=
 =?utf-8?B?NnlpekljcldWOTUzcEcvL2lpQTVMcHFBZ3h4c2Z4VGVCbytHbDJoNEVPS1pu?=
 =?utf-8?B?bjRydERYNXFKdGJzRlV6ODhuOUVVNG85QTJqSExVckNRS0Y2SGZjQUJsUEs1?=
 =?utf-8?B?WVRWWVIzSmNCSzNveUhIemVhSklYVTkwQzhzdG1KVHliemlOTGlubGdLTWxt?=
 =?utf-8?B?YjBJZW9oRjVvaGFXUTVqd1pRdEZMM1o4R3RnaWhweFh6UHU1dThibHNJVVJ1?=
 =?utf-8?B?STJUMjZ0clFrbWp5Zy80cGluSFpmbXg5V1RGemxXbWZMRnVkeE9LWnF6T3pl?=
 =?utf-8?B?ODlscWRvZEw2ekk2WUdnYzRCd1FERkVvekFUVlhQNWFaUUlPMWp2WWhlRUxS?=
 =?utf-8?B?N2J4Y2ExYW1mS0VmNlRJb2lvdzZRZ1kxYm1jQjFmNHBkalFOcGVpeWFFazNX?=
 =?utf-8?B?WmNJcHFpY2x1MmU2TFNkNWdiZVhqcVhuSjFFY202aUxMbUpsb3piTkd2a3Ew?=
 =?utf-8?Q?8GZzD9cOgC83EwXp96HD5WJkd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8e0d92-8fd4-4456-50c4-08de129f1eba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 01:46:16.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NInoN7LuB7+5tg7JMtWNZv3BDwuNmXkc/SRG9i7NTnyjhbJu2p5rljs9imLJEcY+V4638BSkUOBUDGtMWG2mDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7303

Use helper function devm_auxiliary_device_create() to remove some
boilerplate code.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Update commit log per Frank
- Add R-b from Frank and Abel
- Link to v1: https://lore.kernel.org/r/20251023-auxiliary-v1-1-0a16fa4c3cdd@nxp.com
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 39 ++++-------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index 775f62dddb11d8cfd17a4ebf7a677ef399c5e617..131702f2c9ecfd693af47094fe61b486ae6e8f6d 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -230,50 +230,19 @@ struct clk_imx8mp_audiomix_priv {
 
 #if IS_ENABLED(CONFIG_RESET_CONTROLLER)
 
-static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
-{
-	struct auxiliary_device *adev = _adev;
-
-	auxiliary_device_delete(adev);
-	auxiliary_device_uninit(adev);
-}
-
-static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
-{
-	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-
-	kfree(adev);
-}
-
 static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
 							 struct clk_imx8mp_audiomix_priv *priv)
 {
-	struct auxiliary_device *adev __free(kfree) = NULL;
-	int ret;
+	struct auxiliary_device *adev;
 
 	if (!of_property_present(dev->of_node, "#reset-cells"))
 		return 0;
 
-	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	adev = devm_auxiliary_device_create(dev, "reset", NULL);
 	if (!adev)
-		return -ENOMEM;
-
-	adev->name = "reset";
-	adev->dev.parent = dev;
-	adev->dev.release = clk_imx8mp_audiomix_reset_adev_release;
-
-	ret = auxiliary_device_init(adev);
-	if (ret)
-		return ret;
+		return -ENODEV;
 
-	ret = auxiliary_device_add(adev);
-	if (ret) {
-		auxiliary_device_uninit(adev);
-		return ret;
-	}
-
-	return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_unregister_adev,
-					no_free_ptr(adev));
+	return 0;
 }
 
 #else /* !CONFIG_RESET_CONTROLLER */

---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251023-auxiliary-3998bced9cb9

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


