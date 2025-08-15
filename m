Return-Path: <linux-kernel+bounces-770558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F0B27C68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71738B0353B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A02D542B;
	Fri, 15 Aug 2025 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YmaguRgu"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70AB263C8E;
	Fri, 15 Aug 2025 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248699; cv=fail; b=DwK/npXBMCHeUTDbAimsqO6rlGgd23VL9487PoL5J3aMkATOhTsc4pvcxMRvqzPv+z5K3RpzcY11KJ/3e8HdRPhfc1sN8/S/yLyolV9QVY4hJHcHoDsL+TGsmsadtPckTaFWk5VfezBfSG77Sn7stOwYPoKWJyhhPmTfiwbILQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248699; c=relaxed/simple;
	bh=yZ8CXMTGxo8/CEonEB5friIWyj6diqR3wWDZp49w214=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UEpYO+1MKfxyUudrtgqISRS6T7A4y9hl6Dz9UttNNXNE2pLl/bq5q6X6odFRX3Lup5DWwAt+iFdzF4gfljIaDOo4HNvAZIWJEX/YujpBrTZUPbNF1uk5g2OCLDGCGhZqXHeXU1ZB/6LuDXi/vn32rzy6T5kzZD5dxtDdEXMFKys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YmaguRgu; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2QT0el45WTGRpVRkW18dADdpqfEdS0lwRoEv0SvDDLn3pk4w1XXkv3C7g1VDNfS6Nlw7E0GRHLkkIOFjUFHsW6LJDkOh/bBiAChrbWnguwV3ESgAqCECLb6I2yj3EFwIpFDVbRdikg8MiU+mvk4swNjQL/bqCOJ4vaLfs+C8CxbuiLMYLzrgS8hQfV6+nQaQNbdUOJ6SPmKyYHX4zUgxdk1t8kuF5K4HWM+UYYeYb5DP/7r4BcyG8xRNe2vF0cHjaVGh5lX+q6wI/Wl0G0Llj7qU4Tq939Jq2pftT7jnIhzpd/u8DQAJcIZUYCvQI2e/y2AKWAbMZuaqFkQtpnRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ivs2F/E413vLbMLczc83O9h8fxzqNua7IgFLCp5rbdA=;
 b=fvGUNorjgG0twipyPrr47jRJE33AXU1C8VkaD25XAjCfgSTb3sv1MyTNOwenDZh/7TKu+Ur6I6M4DrXPHI0MHpJZFpZ/R3ZEuZ9bO0gXoZEh7aW8VN4C4Am3OQMtpZ3/VhIj/No6OBsXj2U0cmzm4AhWdn7X//fWK91a4M9zUhULeIDMhW5kv+azA3fpxHuaLtVNg3xVgSJkUW2vOv5GgPK4PIIErZmsQoHPYEZke1Vxu4MeFEIvxPcwVpFbpZNU5aq22tIiwIq/EvITN7MJrn5VpEzZHEFPDqNN5Pc5HCtIstd19gK9jMIVisMzK+sykn641VTnLzpOIde+ZOiP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ivs2F/E413vLbMLczc83O9h8fxzqNua7IgFLCp5rbdA=;
 b=YmaguRgu0h9vNiKb1OX2MW5XjaR+E75ZEOCARQFiZYgTCtJYWWkzuk8hvULZirlL1Ht8nD1fYObWXLlXeddT5xC6dcjXs+uwStcmk5B/H5194WtEIp+KRSJUTpRxcJtd7LJ4GMB+ulfIxBW6WcdxEx+R8vftCYoXivxgDTC7l5JRtOB7bkM9JR50WtSJn5L0HiOwknUCnNs7IA6vGZHqlu1r/gsixi8zyjvWLjqUqYBXK0PGiBP6XDn0JUHCS3kzgGKN6t2WJa85ze4RDj7yDlSHH2gsyULVepf7YHhaaURpqJZ+SXGMxkBBNpODpiOMpbKCPkAZagXVqvklPxa5+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 09:04:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:04:55 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:54 +0800
Subject: [PATCH 08/13] arm64: dts: imx95-19x19-evk: Add phy supply for netc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx9-dts-v1-8-e609eb4e3105@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=1422;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=yZ8CXMTGxo8/CEonEB5friIWyj6diqR3wWDZp49w214=;
 b=0StYWkuy5FiX/YvRVmH8O6BNNBHRvuLTDoMT5U9RSsKsNJGDOK25uFbpG3ENIliSvNDYDBTTw
 KnZk3+E5dRnA+D1gvd3/A/bZY9rSPmcHn4SypKPxR0nTKHZEfd4tQyh
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
X-MS-Office365-Filtering-Correlation-Id: b01417ab-4994-4cee-4c38-08dddbdacd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enZDTzJFTnpsWTgrMkQ0RlZLMU9EaXJJaHdaQUp0c1E3ZGs1STI1VDYyUlE3?=
 =?utf-8?B?cDltbWFDTFVCcHN1V3BtWlE0dDJuUnovUFJ1UkJTdjNrUlcySlFNOFg4M1B3?=
 =?utf-8?B?NUNEdkNyVC9maStON2lGS1Avb2d5VWV0KzhZUnBJWHg1UW80Vm5XQ0o2anBu?=
 =?utf-8?B?Y1BobVZPTzZlQzVmbGZNeGdWSHBxNVR3MTJpelEySWN0QWs0cHljWmkyQlR3?=
 =?utf-8?B?TTFMYkNiM2FEZ2hxNTNwbWdOdjY3WkViRURBSFFkYTUzR2pxSUk1S2dnTkVR?=
 =?utf-8?B?bmJMa21mTlF6UGlhdHAzMkJ5anZzeFJ1dVRkam51VDI1NVNMbTlHR3V5VXcv?=
 =?utf-8?B?ZFhJODY5b2ZHT1FuUnl5ZW5VK2ptdkptZnIvTm5TSlBLNjl6ZTcyakZJcEJt?=
 =?utf-8?B?VmkrL0p4MHJBa0NxSHdyNkFOUnJZdHo5YTh5OUpCOUFsTmNQd0FxTUpkeXJh?=
 =?utf-8?B?WDhiaVJDM095d0U5T2hjK1Fza0FzMDJEdlY4bHcrV3BTb3BWTkF3bTVTcDR6?=
 =?utf-8?B?dStsWG0rSUFNTkRCTiszekZuYkFzczkrZTZRWWJLVWhjZjcrc2FHdmxhdjVo?=
 =?utf-8?B?M1d1UitkeG5wMDN4emxoWXRZZlh2S1NTOXZaZ0ZFeEpkZjVVOG5wQ3NETExt?=
 =?utf-8?B?TmRwQUs5ZnZTMFY4em94QlJBY2VjYjRXNTBtMXBKVFpMSTJwd01wTFpSbGlt?=
 =?utf-8?B?cGV0U3NGbUFsZWRnWjRnUXBoUHA1UTk1T0ZiYW9WYU5KZVVOcDhma0l6cUpU?=
 =?utf-8?B?Q0loMU9zK1JCRVpkamhJQ0hUV1N5V0pjb0Flb2p0MkZTeXQ5b1JPcjR2eWly?=
 =?utf-8?B?TXNKdUdSVHkvODhFeC81MkIzR0tuNThzNjNEK0FRV21waGZqZUhjZk9ZMFVv?=
 =?utf-8?B?Vkk5ckxJeVJWR3hYTWlPd1MvZlhpb3RtakU2SzhHL2FXOEFBSGxSVFljS0gx?=
 =?utf-8?B?YlhnUDAyWFR2MFJZZFgwUnlxVkVHVVZOVnlXYVh2b0xsaHI0czh3NjhxQ2RC?=
 =?utf-8?B?ZCt1d21JTFB3TWwvVTkvWUlRT05NT0R0cHdhaXBhS0YwbmFQNDhIazlSb3g3?=
 =?utf-8?B?M3BUdmlaWm9PdWtNN2lwbFltNkRrcGZIY3NWQlh4V250MXJzbGc0S2hPbWk1?=
 =?utf-8?B?UmhUUHJMVGJaNWdycm1HWjBUbm1meUY2a3IyU0pvcWJlOUdpRzlVbWJBcmFJ?=
 =?utf-8?B?MEM1TysxQm1CMk5wTFNXNENzaWJveDRvRkYxU2ptT1BabER3UUNCTUVMNkFN?=
 =?utf-8?B?ZjZQM1BFVlBzeGt0bVlMVjJJeXJzWU9OOGgrZmlSeVVxUWtBNkxOTlYwdHNn?=
 =?utf-8?B?aFdyaHZvM210YVJTRFd4WDRKYU04b3JaQ3pla3ZFOUx3V202N0R5SnlFVVFQ?=
 =?utf-8?B?QUFwaDFSNHg4ZEh2VitSc3ViblZldWVlZyt6VVBjRTZEekpRZUhOQ1BRR2Va?=
 =?utf-8?B?eGlJV2s2ajJXWitSSFErK0Izd1RHTG11VkFqQXZTd2FjY2d2Yk5TN2NSMW1P?=
 =?utf-8?B?N0x5ZUlYalVWYWxlRTRVQUs3N0dUMGZSU3lDSFlaSkVrZ0FsU1gzS1BFVS9S?=
 =?utf-8?B?Q1VnSFArSEgzRE1hamdEVXhVbG1NSWxZaGNBQjNUQXhjRk5LNk5zMmd0eXpK?=
 =?utf-8?B?eUxKRmgvUzMvNS9pSHBpY1NQbGNNUnlHWG05TTBKTUVKRlk1R3BkTHlXbkdz?=
 =?utf-8?B?Z0dkL2d1eGFTa21LUXRzbkhwRTR2WENldEJEYUtHL1kvNDk1Yy9rY0tTdnVN?=
 =?utf-8?B?YXRLbmx3YTdJczFFRXJCNjRpOXQ0L1VKM2F4eFdJY3VyUmkvSTA1UGhkMEZT?=
 =?utf-8?B?SHg3QU1CaHVSUndiMGt2bWJ4SUpzQzV1c2trQjNyVUZKcDMyWWh4UDRCaDhx?=
 =?utf-8?B?UnE0OVBPK2l0cFRDNUx6VzJ0VWFrcmZac1IvRDJHS2NwUlVuN011Y1lSMjhI?=
 =?utf-8?B?M1NpRjVMdzZoVFcwdEc3am1ES2d4ZW85blF0bWo0SVROSkoyeVdCalQ0QVlY?=
 =?utf-8?B?RjZTMUwzcnJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlV0b3hvYUFpZ1pEL2ZWV2E2NFNELzFzdGpDR2ZmbzA4NjFRelRPc25XSncr?=
 =?utf-8?B?Z0pnc0FudUE0cFk0emk2T2g0a0hFUUtXRHlLYkFVOHMvQVFnWmwxYTU5eW9E?=
 =?utf-8?B?d3lkNGZmM2IzY05rd3JIblYvblJOSXcycDFwb3lISUZZSFVPL2wxY1RHWEUv?=
 =?utf-8?B?cEtMY3Y3L09aYWd6QXYrQWdnSTc4c0NCWTVBc21kQ2VlQmlCeWRWTTJFcGhz?=
 =?utf-8?B?eDVhSFk0YmFVMGRTZ3RFVjkvQVhXeVZiUlo0NTBBUlMrZytRQzFlWlMxNHVI?=
 =?utf-8?B?VGZpeTNNOFJ0N1dFU3lwWEYwZ3UrQkZhMXFYQUFWMFV2WHVJT0k3OG5CU0pR?=
 =?utf-8?B?UnQ4SzF5QVlSM1l6WUl4eitLUFc0UjZWOVd3bUtIZG8zeDdXRXRMbHMra3Zt?=
 =?utf-8?B?T29lT1hMYXgxRkQ4Unl6M3NRbzhzSlVqQ2hJeGllWXNnTkR2alBxVHo2RWRk?=
 =?utf-8?B?alJkbXVRV0JySGxLaUN5TmtBUGJFYU5GYkszV293bHdCNGQ0dnZacmxXRURS?=
 =?utf-8?B?ZjU1dkVYenBRN1NYcGt5VTBsQmhGbVorUVpEV2ZhcmFCL0ZHb2M1TGJTdjBI?=
 =?utf-8?B?LzJjenZaaVhRSnVjTElROXJPTUVoNU1kcm5RZm5oMWt0UkNQcktUcmkvQ1BL?=
 =?utf-8?B?SWJWaERNUHNYT3dwZFJOZ3p4aEhVdXg5NEZGdXRPeGtuUVIveldEYmRqclZj?=
 =?utf-8?B?b3VGbTcxcWZjMkxiZ1hVRkhIb3RKb25nWC91dk5xK1BLd1hTbnNuTDB2d0dB?=
 =?utf-8?B?YWFTejV6UC9ad1o0TUtBekpRQnRDZnFsM29pVDh6d29VTTRuZUtncEZCZDZ5?=
 =?utf-8?B?Q3JvbWoxbXJscGp1L2EvTW1vM2lrSHR0UVI2RmsybjIzMWxZUEVLNzA5RmV5?=
 =?utf-8?B?ai81LzMxOTFiTmRLTGdFVkJsdWxKY2xWNFh0L0RtVG9Hby9aaERRbTJmbWwx?=
 =?utf-8?B?WEFZSDdkR0hGSFlxeHRqbDBvdFZjcTJkZ05iUEQwVnZvYnpwV0FzYWZlVkdx?=
 =?utf-8?B?cEszdXdXaSthSWRva2pIdTgyczIzL1RHbWFpL0l3TGJVQXlxY1R3bnpuanZD?=
 =?utf-8?B?QVo5amVjeGtZZ3lDc0xmZnhrQzR4MFVtMllBSkNUdmQ2YThQSi9pUFI1cnk0?=
 =?utf-8?B?eFAyWTZOZEx3R0VtVitrUHkzNXFqTDdNY3FFbUl1d2RqcGNLY0tqc09KNGVt?=
 =?utf-8?B?MFByTXkvaUZHa2krZVNwOUE3Tnd1S090Y2NqMUlUSjZQUFpNM2FPb1UvZ2ZS?=
 =?utf-8?B?TWlKZGZtSFZ2azMwUWQvQTFqdHNSZTdZVTZhMGxFVU5ZaEFKbmpVT09XNk4v?=
 =?utf-8?B?UEZWdFpRMThCUlFvNlRRZDVEYUgwQ1NnQ2JBVTM5TXpmYnRqa0lObWdreUZl?=
 =?utf-8?B?UFVmek4vdmx3cm52NFRIZVBSMkNlc2xURlVWaUFDdUlsVXF5QTRLL3NsekNn?=
 =?utf-8?B?ekFXVExabGZkdEJlMDZlaFpCaUdiaityWTdVZEJsMkVNSEhUSTFpYlhEc0h3?=
 =?utf-8?B?eHo2dmxpbjd4RnlTTk51WVBMdUY0TnRVNjBOVDhZdjdmL3IrM1dTTlBmRG9R?=
 =?utf-8?B?VTRrWFowbDRsR3BEemsyVUtYdVEwWE5rRHFxVlBZcW50bCtUeVZGUVBHSXBu?=
 =?utf-8?B?eEJOL0FZL29jWXFKSEhrVXRiRWJoKy9RNjRxTisrRzY2K2dHcGF4eXVseWpl?=
 =?utf-8?B?ODRnOFNTMng3Ty9FcEtsYlNWL0RDZjBqdDF5OW5iRlVFTS9GNjNnUkltUXR4?=
 =?utf-8?B?eFA2U1BqV2ZYMXk2N2pNb1BINDMwVUR3cWJNa3I0Ty9zQW9PTHhVazlPZWlD?=
 =?utf-8?B?Zmk1dUxyc2VjdEpTS211ck9Kd0VOclZRZ09iNEpNQTFYVWlPMDFkUWJaUWoz?=
 =?utf-8?B?WkE2WUZlSDRaRXUzbFNpSXpDMzNxSlpLc2VqSHFMN0RGNFZTTUMyN1ZOM3VL?=
 =?utf-8?B?OVRMdUpOdHV5dGVHa25vdW5USkNlWUQwM0tZNnVaenNFM1Y4QVpCUXJBN1pY?=
 =?utf-8?B?ZXBqd0FNKytvR3hYWWwvSmdlQWYxaHFYSzRZOFVQc2lGdEMyMWdPSkdyaTYz?=
 =?utf-8?B?aUVkM2d5bnN3eG9yamo5S1MvZ011RUFxMkNlTXB2RGRkcFljNzFQNkNTdDg4?=
 =?utf-8?Q?y0fxTxe/zIJsvkVIkP4DaJ9e8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01417ab-4994-4cee-4c38-08dddbdacd5a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:04:55.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6Me/MTJyhIp0rCplCoqik8qHVswYsT31a2EkrGvNEKGpCyBxspprxaWAcp6+EJQkcXnIbyZjMhB5yByjItEqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

Add phy supply for netc emdio on board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 39815b21d235d2f8cfa49720d3be49d056ea039a..feee6da65d37cae7413b09216014d6fe2b76b032 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -226,6 +226,25 @@ sound-wm8962 {
 				"IN3R", "AMIC",
 				"IN1R", "AMIC";
 	};
+
+	reg_aqr_stby: regulator-aqr-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "aqr-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&i2c5_pcal6408 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_aqr_en: regulator-aqr-en {
+		compatible = "regulator-fixed";
+		regulator-name = "aqr-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_aqr_stby>;
+		gpio = <&i2c5_pcal6408 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &adc1 {
@@ -502,6 +521,7 @@ &netc_blk_ctrl {
 &netc_emdio {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_emdio>;
+	phy-supply = <&reg_aqr_en>;
 	status = "okay";
 
 	ethphy0: ethernet-phy@1 {

-- 
2.37.1


