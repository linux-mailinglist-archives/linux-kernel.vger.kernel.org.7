Return-Path: <linux-kernel+bounces-824087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115ECB88169
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BF42A2E57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202D2C0F90;
	Fri, 19 Sep 2025 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g9Hs4Q9q"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3BE2C3278;
	Fri, 19 Sep 2025 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265406; cv=fail; b=N4ql5ROR0KQQ217J1UNBSBmKSyPA+ptkuj2iyl9x161Mf5LsdCR6eYxZWBTOMrEEe17gDk2GI9mj2FsesCB8b8TO28Q5YBD460zOmDDKp+DkA9ZddFQzK/Y3QhVjr2RNFa/4ZOwSNy3zTuYPMessvnEi4qh4XdUDYwlMhwtvVyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265406; c=relaxed/simple;
	bh=p8bJ33G6TNZ648xcQoCJNj2uxRlgG+Z04XqZ33gHMxQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aqDwj1dUmJOLHIcpR87HpyI9+VJBMqPGic9NimyJ/d4ZTtucxpgq2FaV5ZWIkl9spSbOtJe3VcF8R10hT72wo0hT7I1HqATK+Es0NP/SJVdtARDnnvnInqaK7x+rEmKYgqdZgpHUvudXO5poza3ODcXojBveOdhAk067WwYZ2bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g9Hs4Q9q; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzGkevyTixasmwvMjvHzq6289ftqDPDXE/zswKvRmMpeS/J6LgbKZ2Kwa9g6yDAxQQ5sQpsDxFFhSGcj1g0R94RE/ChMjNHhJKOVu6PHRXovMKnX5pVo/m6pMkM5LnzmQmRONmcUunQ5f7BsSFyZmc2lXEl1n5ap0m9ZCSA4+8EReiOvcdpwjwgnG/vVo2PtGHVtr9PMh2CQIyuZo+HinC7drRODlgEnp0KaSHJgvZQGX0+yWUM9iTFeiZiBRRLgKTZNCKWpsUj8qdmNacWsZWVSSfBR9nt4WE0173TanPLFUTvj29rQx1YvC1+BXj5sVGEj1yv+ZxjCoZomnIHtag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGuuJi88A8vWvPl+qe0+U/4HKGZ7vWdoH0UDZwur+ok=;
 b=xhqliOVCr+eBhxg4mBICnlo1xNviwmW+K41clkEtuGiRJw6dluHWgrdO41ukBmm1UqN7SyAW/5XFqfjcQIzHBp+amx9oPr85W6DnT5JDvU5RXejiq4zQQ6jEWvA42Ka4Mtbob1kpLzxDy1UAicfr9ZUz8oEnHHiBdSJ2Hf1HyTWm9AV5yQGdR+ZkC6YPkvBTnJcm2p9Ene+rztuPkcxn9EEcGB/Mb2S1MH9MGuW3ffuFkqySV16kXFGcQLidCOT36RvpJdFjM4StScHi+RvYhxpd8VDgZmmRi3FevHXJPPjfaE2OLZN8BBI10wdNhDRbyc00IazDN6w0PLLRsL2X0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGuuJi88A8vWvPl+qe0+U/4HKGZ7vWdoH0UDZwur+ok=;
 b=g9Hs4Q9qhm3hyrahZ6Fu4vSGgu8lJSmHhUPLf6a20faCle1kD00EhgPIgByrGQ3rQ9gAI+bUvYRxJ/pPuBWyXeLe429OsfQRhaVTfeQ5RNjerJ2t8Vo1VFo/O+aWZusYmBnpm8Ml3kzMDB22nqCJLvMrXzQlbauy8BsAlNPnyY9nFQjDnPQEoWNg8q9QpwyEFTTnjN/zhqpckH1lhGL8U2SUvlkfgHEjLvzfI7Fr6mr4c/RsH4Kh4ANxL0QRy/4UsWPh92DGUx0n43njLD+87p4EwXb37WuBAAZFD7hA5G5eTxskjDhgEy/JTw+Tw3tENczxqpwMBrETt2FwbCGehw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV4PR04MB11452.eurprd04.prod.outlook.com (2603:10a6:150:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 07:03:21 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 07:03:21 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 19 Sep 2025 15:02:59 +0800
Subject: [PATCH 3/4] phy: fsl-imx8mq-usb: support alternate reference clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-usb-phy-alt-clk-support-v1-3-57c2a13eea1c@nxp.com>
References: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
In-Reply-To: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758265397; l=2684;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=p8bJ33G6TNZ648xcQoCJNj2uxRlgG+Z04XqZ33gHMxQ=;
 b=OcyV43NxQ7ypXqdqbL+B8Nr1lNTOVLMgZgtoBDrEIFRpjob5w3eAqiGj9DwPBZPcyLs45qnNm
 4vODCwGAZabABhBh8iCb0/SRF32nIr08HYBN4J/yqAjxZXhT/peC9ri
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV4PR04MB11452:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f03319-4974-4190-176e-08ddf74a9e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YytLdi9xQ2ZIWmNLaW9sNjZCSVZvdjhMUnl2ZXExVDFTTGxxaTlqNkh3MzhO?=
 =?utf-8?B?Vk5UNGNsbVA0WWVTNmJlZkovWFcrd0NpUUxsWlN2bXA1TW4vbW1TeURib3VR?=
 =?utf-8?B?U2wvdGFWSVM3QUh1RklWZmhhYWdDb0dPMW56Rkh2MGZsRUZlMEd5R0FBTVB1?=
 =?utf-8?B?VmpFU2R0dWxvSnRUVVIwS0I2ZkxUNWdrek8xaU9YR3VHa1ZudjJkaDhCYzFk?=
 =?utf-8?B?WkJqdy9XaWJ2c3o2cWdZY3I3SnI2bVBXcXQvODFVVDM4azF5MExoU3NTeDYw?=
 =?utf-8?B?UFZxM0lOUXgzamE0MXZrYXMyaHJxVlhGT1NaVHhpYkQ3SlZ2K0lJOStzM1Bl?=
 =?utf-8?B?UG1nbmVKcVUvSFJ1eUs0amFYNzY4NjQrQ08zcXlOTHFuRGxwY2hjQmxaTU1V?=
 =?utf-8?B?RllEN2VpekVRdUlWUEpWUVlFUnpLOWdZK2tXRDJESzI0VVBmZUpwSWRxOTJK?=
 =?utf-8?B?YW90R2E5MlhNSFRQd2xqY0RSS1RONVhxSDU1d0Z3UXhuTXBTK3prdDdwb25k?=
 =?utf-8?B?MzhybWF1ZDZzd29sMjJPRFVIWndrM3J4S1VyMUJrUW1qK3Q5eWpidU42SDY2?=
 =?utf-8?B?cWpzeUM4TEwvdlhQd1I4OTRnalNabng0SkNxZk4yZGZaalhNYlZCWFl4b1lQ?=
 =?utf-8?B?WE5SbGRlbzFxbE5ielNsYlh5OHNxdW9oa3NIN05scnAySmZLYlJacWVVOEE4?=
 =?utf-8?B?cHBxZXUyL2VDK1JQRnVJQjFwaG1FSUVUOGlmQzFZbmZaQzQ2dmtZT0p1djc1?=
 =?utf-8?B?YTZiYk0zUFFNdjB2K3F0cjU1amZXMUJGdXB5VVdZMmtyQzJJd29wZlFWYXlK?=
 =?utf-8?B?RVBHNTN1OHRrWWQ4SGJsSjJ4cWNubmRTMUpuSkEwK1lZcXJ0VmNzYncxZTFL?=
 =?utf-8?B?d3VYdW5MSU9rYU9icHRNL1lOVU9lUUV2Mm1nTlk3TG1oQzliM3JaVDJ2aUhv?=
 =?utf-8?B?bU5kQ25valhDaEVlY1pEclFvdUc0bW14cmJZWTZyamdrM1UyNER2N05iS2Qx?=
 =?utf-8?B?RGVyell5akhpL3R5QzQ1c2VHd3poK0NwS0UvMG9RVUwyQUdyMzBVYU5jSTZ5?=
 =?utf-8?B?ZHJPYnlNNmhqZWdGQVg5Mys1dlVqVmhyZUlJVUlPSUZmUktSNDdJZlI1WWxU?=
 =?utf-8?B?eklXSVZrV25SZkE5UnBETXJtNDNHQSswbXJpQTZ6bjNIblZmNm5HTnpwVDFF?=
 =?utf-8?B?V0xNYU5MWW9rTXlUUzY2cU1nTXZzNlpqdElCano1SGQrbmpaV0pydE9VdE9y?=
 =?utf-8?B?QWErYnZOTG9sdnBxWXZXc1RuaWZWU0J0SXEwRExMbm1HYkowYWp2TkdKL2gz?=
 =?utf-8?B?OERweXoyTXhkaFpZNDAvWnAvbGlmVTVnMENHeXRSUDdZbVRadXczSWdVMjh1?=
 =?utf-8?B?S0YwZ2g1TExaYVFsdjhIdzRhQlY0dXpXVklDYzBpNmhkTGVVSGI3QW9wMVR2?=
 =?utf-8?B?cG1iUWUzbUhpSXZMeHFLY2E2MlFDdStZdFN1eVBTWGFMSWtzK0ZSdm1xblhw?=
 =?utf-8?B?c3llSTEzdW5IUnR0bWNSYXRSd2N0ZzNzMkRDTjM0bEMzN0VDWEhDMDZyQVdN?=
 =?utf-8?B?MXI0eGJtYzRYbXpGQlZGT05FWmVFUFpKYkV0TjlESmtsTkN6MU5LVlNadURJ?=
 =?utf-8?B?VTFjc1NLMzFDQ0VkQ3djeHpvakNhNEJ2K2ZJSjRsRGE0ZG5xbVExMnl6NXVN?=
 =?utf-8?B?ZHdTOTlvSzQxSWp2cFNVV2lxbWNjL1kxUVl2VXBwNFdvOVNIWXMrV3FsaEg4?=
 =?utf-8?B?UitUWUhUdUNOem1jb2pLMWxFdmpYdEk2TEJkekEyTkZpUzZ2OUtGNnZUUFY3?=
 =?utf-8?B?MkkvNXhGSGNaZUxjaE9QcEwxUldTTTVobDR5NUlYNFVzZXJUVnVoQmZUSDF2?=
 =?utf-8?B?VlVZWDgram5IQ0xNZnh2c29zRmR5ZStiNXhraytzVjdsSnFBZWhIMFNXdmR5?=
 =?utf-8?B?YkYyS1l6enRabW82N0RMSmwrZEkybXlkNGhDcEI3N3RwRld4MFVoTFRHNW5H?=
 =?utf-8?Q?x4ZZKISlWibh7QxtsiHlIsvkDYx+I4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1dhTjFBYzAxdEhLQVFod2pCK1o3NDBsUVc5UDFvbUlDMERiSFVGKzdHUTRQ?=
 =?utf-8?B?U1B3eGFhZklubWpBdERmaE9TUFJHMVZ6ckJlSi9tS0ViUG50TmVxTUJNMkNr?=
 =?utf-8?B?U0JLTENLUU1uNUkxSHEyNEk2aXI2V0NpcmZUNFhCbmRuYlUxclhUcUJnN01m?=
 =?utf-8?B?MW9IWVRpUFVqZlcyTnFzbktUQTRhWHN3UWZQYlA1VXZTUFZYNzVkN3Rkd0da?=
 =?utf-8?B?VnpyQmF6NFFHVDRwU01BMER6bmpjNHpreXc0c2lDUE4zWU1ZYngrSHVSUjJG?=
 =?utf-8?B?Y2lUbm5vaGlaSzcvT2Q1czBGWFBKTS9vdk8vQTJ6cHNoTHRLb0ZhWklVQ1BD?=
 =?utf-8?B?aHlXVVJpZmtJYzVudEJpcWYrWW9TYTlLZHRYSlRlaXY5NG1EYnk3VlRTand6?=
 =?utf-8?B?QnRHZXg3aFdSZ3hvR2Y4aWpScFJycDlCRERJSU9Bdk1SNHRTeGhCeEdMcVVG?=
 =?utf-8?B?bE5kTUovS2VHME1EYi95aWNaNmd3dThqNFJNMEFCem8xRDRwYVRtak02eDJL?=
 =?utf-8?B?MUpJcXNHeEk5dUQvZzllYXVWNXNvdk1aTGM5dGVMckpKVStldzVoK0ZxQUZa?=
 =?utf-8?B?K3JsckVXYjNONzRhR0JMUDdqWURxQkpYRWhldFFybUtVbDZUNWJDWE5KYmhl?=
 =?utf-8?B?aTlHYUNHdW16c1JYTGplTjgwWHhRRDBJNnlESjhnd1JYL05mZlZ4a0dJTFNW?=
 =?utf-8?B?ZmZoS284eStaYlF1WWVRZklQUWZYSVJHSjZpRXJvVlBmQlVRWVJKNmNoaFpQ?=
 =?utf-8?B?RG8wTDdHU0VTQ2E3Z2hFa1NORVRONHQ0TDQxcFZKdFp5eSs1ZlZZb3I1MStG?=
 =?utf-8?B?YnhsSzJlUHVteWtDY0N4bTVpSmdoRzdnbCttUWpydGhYR05MWE5EbHRSTTM4?=
 =?utf-8?B?TmVqeVR4K29FU3RTcGtHckVOcEFtREJlVGtiL1FnZXZoTVhoUDZ3L0JEYldw?=
 =?utf-8?B?S01hRGZqMnYzc3ByN0VKaXBlcWU4RDI4TkNNMkY5NFdXSWxQbVVoLzJwNW5S?=
 =?utf-8?B?T2xvNVVqc3NBMkRVQXllVGFta2RaZzVXZjNzSG5SWllsWVpNaXkzbFVwNUZ4?=
 =?utf-8?B?L2kwZHRkbThJcXJrcStTSEovME9pdDB0NVZ1YXBYeHUrdnI3WWwyYW9yeGRH?=
 =?utf-8?B?bGhzRVI2ODJFeWZNNHo5YzEzYmF5RzZXSlg1bHdZVDR0MnJBNzBpOFEzK05h?=
 =?utf-8?B?S3IraGFzTk9neDA0UWFHTkI2bGN0ajcwV0xSMUN3NkZ6UkNsZTZUbm5KYlI5?=
 =?utf-8?B?cnE1MGxmbHZIdkRodXZ2Qm1ndnV4Q1h4ZmwwN2c1YW5xTHhEcnRoa255blV5?=
 =?utf-8?B?a2c3Vjg3ekJyUXRKMnU0VVY2eHNqSEU1dFpudjc5czNOVFAwQTBVWHFSWm5H?=
 =?utf-8?B?eSswZGRaWmZlRW1FaDN1eHpNUXZXOHN6RnprcVpFTFRDejN1VVRiaGZSUGhr?=
 =?utf-8?B?eGFiSTZFOE9YU0tNUXFWd0xidzl5c0hCbUhMUFNlaHk2WHBIRTlJOWxKRCtE?=
 =?utf-8?B?Yi9yN0NIV0JEak5PMFA3V0x2SlREUnZnTU0zWXlvOUhuaHRHMjRUTHEzZ0VK?=
 =?utf-8?B?VEhmY2xRVzljd0I5ZFM4b0plT1FDNlRleFdMQVUzd3I1MTlTOCtYOTJMbm1r?=
 =?utf-8?B?LzNibk4vcUdNcE4rQ2R1S3NuYlo5TnNiOXN4S0p4TmxOYmI1WnA5eWVjMk5I?=
 =?utf-8?B?T1NranljWXg2aG4rUmVJb0tmekxGMG9xRnphY0pIempmQjF5M3NOZU05WGdB?=
 =?utf-8?B?TVZQZi8rNnpCYnQxUlNwMWZLb1dHOGRlTFltZllxRUdScXU5RnJJR1ZUQlFh?=
 =?utf-8?B?c256bFV0RitTNXEwWVByVllBMjhSaGNBTEtaNEF3ejU1NmFmMUhuRkxmQysx?=
 =?utf-8?B?SzdEeDlsZXRMdUFRalFqa3R0eHM2UnRoaHZoVTBiZlMyNllmN0hsOEZkTGta?=
 =?utf-8?B?bnZjM0xVbk9RZVJTbG9wTXMrOElLRlRMRHhsUVhnL0sxaDIzVElOUU9mYnZk?=
 =?utf-8?B?SHFMWG5TVHZYN3B3U2xoSDljVlBabjF5b2p6ZFRuWTJaMjQ0QkRUcFNYZ1BO?=
 =?utf-8?B?T3VyblE3cTBVM1NyNG0rVmZnVWhoeitBY1pYRnBRaGNNRGcrVFlPV01Gcllh?=
 =?utf-8?Q?+lTTeqWmcdH3m8pkRgb2hFiiM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f03319-4974-4190-176e-08ddf74a9e6e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:03:21.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COZaKPQPsVu30+7F338DmgTeeCOqf66rDpGpCSIuBbuBxiCpm+8b8p9WMChSNs0HuBNsqw867yJ5K12kdE8iWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11452

This phy supports both 24MHz and 100MHz clock inputs. By default it's
using XTAL 24MHz and the 100MHz clock is a alternate reference clock.
Add supports to use alternate reference clock in case 24MHz clock
can't work well.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b94f242420fc733cd75abef8ba1cd4f59ac18eb5..ad8a55012e42f2c15496955d00c6d5fd85c5beb2 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -16,6 +16,7 @@
 #define PHY_CTRL0_REF_SSP_EN		BIT(2)
 #define PHY_CTRL0_FSEL_MASK		GENMASK(10, 5)
 #define PHY_CTRL0_FSEL_24M		0x2a
+#define PHY_CTRL0_FSEL_100M		0x27
 
 #define PHY_CTRL1			0x4
 #define PHY_CTRL1_RESET			BIT(0)
@@ -108,6 +109,7 @@ struct tca_blk {
 struct imx8mq_usb_phy {
 	struct phy *phy;
 	struct clk *clk;
+	struct clk *alt_clk;
 	void __iomem *base;
 	struct regulator *vbus;
 	struct tca_blk *tca;
@@ -582,7 +584,8 @@ static int imx8mp_usb_phy_init(struct phy *phy)
 	/* USB3.0 PHY signal fsel for 24M ref */
 	value = readl(imx_phy->base + PHY_CTRL0);
 	value &= ~PHY_CTRL0_FSEL_MASK;
-	value |= FIELD_PREP(PHY_CTRL0_FSEL_MASK, PHY_CTRL0_FSEL_24M);
+	value |= FIELD_PREP(PHY_CTRL0_FSEL_MASK, imx_phy->alt_clk ?
+			    PHY_CTRL0_FSEL_100M : PHY_CTRL0_FSEL_24M);
 	writel(value, imx_phy->base + PHY_CTRL0);
 
 	/* Disable alt_clk_en and use internal MPLL clocks */
@@ -626,13 +629,24 @@ static int imx8mq_phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	return clk_prepare_enable(imx_phy->clk);
+	ret = clk_prepare_enable(imx_phy->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(imx_phy->alt_clk);
+	if (ret) {
+		clk_disable_unprepare(imx_phy->clk);
+		return ret;
+	}
+
+	return ret;
 }
 
 static int imx8mq_phy_power_off(struct phy *phy)
 {
 	struct imx8mq_usb_phy *imx_phy = phy_get_drvdata(phy);
 
+	clk_disable_unprepare(imx_phy->alt_clk);
 	clk_disable_unprepare(imx_phy->clk);
 	regulator_disable(imx_phy->vbus);
 
@@ -681,6 +695,11 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(imx_phy->clk);
 	}
 
+	imx_phy->alt_clk = devm_clk_get_optional(dev, "alt");
+	if (IS_ERR(imx_phy->alt_clk))
+		return dev_err_probe(dev, PTR_ERR(imx_phy->alt_clk),
+				    "Failed to get alt clk\n");
+
 	imx_phy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx_phy->base))
 		return PTR_ERR(imx_phy->base);

-- 
2.34.1


