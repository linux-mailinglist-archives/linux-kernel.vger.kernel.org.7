Return-Path: <linux-kernel+bounces-860678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F2CBF0AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9122B189D8CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9E4253B42;
	Mon, 20 Oct 2025 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cDAu9XPB"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DB255222;
	Mon, 20 Oct 2025 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957512; cv=fail; b=RyDrXT1BstpT5Il88rKI+ZZkzRGFlwcT/9V57ERM9meZtOBq6mL8NHsTGLtvL6Syke8CJEFH17g33/Lo6Q11xu/jgHMKFgBUIPk/6Yf6u8AOACoJ3Hic5lQRJKPQ0vRC+ps/feudpxvtcpRIQ7LXOOvPxaUfAGwhl/bDRt4ISdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957512; c=relaxed/simple;
	bh=dn1hP7KSP17Uqe8oW76XjuMD6Iuu2jByZhdYD2KpwyA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=J6+uqqY619Q31MrwtHkizaxuCZ4c6eTNCA6dlilZDC/bx1yIYD2VNXtM+a079z7GdubswLDVO98+KtEH+Lj8SFj127/KArBSEFc/4k3gVUCENWmnFwvffOsdtw1lGpz4zFxbJTX7uzGpK+OPd70PUo8oB0vQhQ9I/qF9TUryY+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cDAu9XPB; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIQ7g9AFMcJr+yQYKgcfBxw70DUq7Vk2MBueAFlHWLeugncmqjIfaP/ItTKjIS5Cv2ogCmgym0IAHrq6r9Rmzw8flcmVkvFEfj+ubDfVJKwsN2o6z4kO2/K4qDYpfAo0mDQbG7hML6Ew2Wgm1djjM0qA1+NDDJUSazKOk7wi/9IV9UgW2enR3HyPXxu/xM92n6oVOa0WmdBxmdoXYbP7ajLAzMYVsxBW+H7D2CCI0IKv51/ApgUbxwVPQj5xh/sopAWmXvCActCiMUPu+BiV7XiGZ0Ka2tr1VpBmrgass5r9TsQb/NYhR6MGRj2qwx1a6GJaNhGM2jfCGwS/YoIFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f20WWX9TB/v5726FsBBQRA/JTNxxdftRsJl7tGqb/8=;
 b=I2Xm94dutmYsZcmiHdAVb2yOwrAquoC05IW0NhGlO7MqZZW5LhXzTfpfR9VlADlG4VBBOoF0rELNs/6QI+WyzQSNcg+YS8fnZFKWuekRu2dzj3Wt3yjqPJOUiRKxtWRtd9HCk5tKZBh/a6DkdtJQvEIxqk/lcl6lkeg3+WYZKcWpOgCN1RFaF8uk0Sq5a6dmVKdqiJpCist/uzfnqzvZdF+odfMiPgD9LsAzG7rRv6cVpsQYjmQs+B1idF3yrTrQ3L2dG73VZhG+8UYf91Ym3rXkPu7SqhgaKaHoNL4Nv+fAO496MgPJHbPRTwNm0XPWVtRji3mTLvlhoBxDS5aQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f20WWX9TB/v5726FsBBQRA/JTNxxdftRsJl7tGqb/8=;
 b=cDAu9XPBqa7xha86SMlFWz+H4wAANWrQc7Co5hRETnNdyvRY+sT3jPOTAAnJ+EKgZ+dMpyXfi1s9Pjghluytz/0vMdLjn/+dfP0OM/laSX6Oskq2fwqylr/u/z08IwAPdzvb+91ekdIRGDkLgv1tV0OcTtE2/ZIePnDQbtC8dbC9/McBVXbL1PuuV4ffJKZORKosXpRa0TjM8HPuVhJbtd4PXjGoXudVDSOxxfddWoE7N3+lfCZR+7k1Vb8B8OoFDJdXIqrnabaErxg7mBH8O2br4dbQHia8wt1MXtj7yOgy8cUeAg/9mdDctxPACcRtjR8/5EQkNMbC+m1iv6jV8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11683.eurprd04.prod.outlook.com (2603:10a6:150:2b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Mon, 20 Oct
 2025 10:51:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 10:51:43 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 20 Oct 2025 18:50:42 +0800
Subject: [PATCH v2 1/3] dt-bindings: nvmem: imx-ocotp: Add support for
 i.MX94
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx94-v1-1-0b4b58a57bf9@nxp.com>
References: <20251020-imx94-v1-0-0b4b58a57bf9@nxp.com>
In-Reply-To: <20251020-imx94-v1-0-0b4b58a57bf9@nxp.com>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alice Guo <alice.guo@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11683:EE_
X-MS-Office365-Filtering-Correlation-Id: dd054901-b9ac-4d46-4492-08de0fc6a814
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmM2dzBGbld5UjhKYjk0NEpBdkc5V3V5YmN0RHF0OWVHb2dmQm5YSExoMmI3?=
 =?utf-8?B?YWZnOGhIYkVsWGtBZ3ZuMnM5dGI2bDRkMThwN2svZmp5OEo1MHFGWDFRRVFX?=
 =?utf-8?B?L1pyeDE4elR4dnVybGVLbGVJVlVRaGVmaDBRRDh2MncwejVHMVFnZjdXaDNl?=
 =?utf-8?B?Ti9mVEtpOHdHZkpZaXpOenFRYTVjZ2NIVWRrdTRHTFhmcDNkQ0UzR2hvUTZR?=
 =?utf-8?B?QjhKRzE0T2VrQnNQWnh5UlBMOEtzd20zdXNhbGpyQ0pwYVM2VVRjUzJ0UEZ6?=
 =?utf-8?B?ak9ueG91ZkxZOW5RZUkyQjRuSDUxaEp3cHRJTHpHVjV2ekFMbXRCZ09HN0RN?=
 =?utf-8?B?QkE4MEtBaHdZdElTRUZUUy9KVk00WncvVzhMZUdDVHQ3bkZwN1NRakdtdk8r?=
 =?utf-8?B?Rm5VMXZWUlYvb1o5UW1UY2h6ZFZGekFScnJHSFdhQ1B1d0daSWFTRVd4c01O?=
 =?utf-8?B?UkZMOVlpTTNpbEZ2eWVwNmVaSiszNU0rcEpGK2VmYnFjWWdTQ2hjbjRhWFZD?=
 =?utf-8?B?ZkVQSWV1MlA4TVpYTkJ5WTVKenJyVldRN1htckM1QWkyVVFzNmZvUk1RTUZ5?=
 =?utf-8?B?bTRWSVhGVUcvcEIwSWlSSEE4SEJHUWhUTjJEdjAxYnl0dC9XbXhINUY2Z0Rk?=
 =?utf-8?B?N0hLV1JGKytPSTZ1QTlRY3BtYXdHWTdzdkduNnh1UjFsVFptYXFaSENNQVlX?=
 =?utf-8?B?bW9vVDBmSWZaMElMMEtoTGRHVCt5TzAyem5YQ3dPQkg4VWVvZkdFYjhqQjJQ?=
 =?utf-8?B?ZUl2NmVURVNPRnZrQnJiNFkyY3AySG1pTnloKzhjTnRIYzdhNTEvQmhKSWdU?=
 =?utf-8?B?akpHaUwvL25Ra1FORWU4cm5qdnJQRmdyRmdEd0ZncHZsTVNJV3k4b251V3Rh?=
 =?utf-8?B?RGdIOFRNRGowTVoyOXNtZDY1ZUdDanpPcmd6WWpkYTlsVTFtMWVoWFdIQk5L?=
 =?utf-8?B?Nks2T1VxanpueGJRODF4MWUvRDdHZ3ZOSFJiTzBPZE1FNFhFVlRJV0RuWnEy?=
 =?utf-8?B?VmVCTmE2S1VaanMwOWx5eGRHK2h3di9SSk9vMXBiWFRuSDlBbXBMeW00Wm9m?=
 =?utf-8?B?dExzZ3AyYk50TG5VOGdhaFoxWmhUYy94Mk42RU91NEp0ZG5yWXRWMHBzV3dy?=
 =?utf-8?B?WTFRd3M4WDZYODRFcWVPcm93c1pvTjUrNSt3aHZlSUJ4Z1FTRmZGN3RwWFNk?=
 =?utf-8?B?R0QxLzRaclcrcUZNa3lBaEkzR05uZ3Y0dWc5TVdUN0RQR0hmekRIajNidVNZ?=
 =?utf-8?B?ZDdUQkVpZE1iQzRuTm9QTWp6WllHa1BlYVk4Q3FYeFZTUU5oS2t3b3l0MjF5?=
 =?utf-8?B?ZFBZRVFxRFMwRHcxZlZ6R0JSOUh5SWZiS2JYUC94a3dUcW42cjgxR1JVZFNG?=
 =?utf-8?B?bTQ4T2VhL1NuZ3RtaldZUERHTC9Oek5sQWN2bkp3TytXcEhjTFRuOHFMcitC?=
 =?utf-8?B?WjQ3ZHNNU016d0xkdmI1SnNZbTVXajB5NWowbFFhSWlCUEhJei9PY01YU3hQ?=
 =?utf-8?B?Q3dLcGZrRXQxWDJ5TTJrLzJWTko0ZkhCSW45TkxnbFdVdXB3QWJIT0V5V3Av?=
 =?utf-8?B?eml2UU12cGlkQ1FKTUZqSUp0cGZaM24rNUdNZWNFa2tPMi9iM09Xd0UxeXJt?=
 =?utf-8?B?T3lWbzAxUVBMM2Q3diswRDE4YllPRXVYTjFlUldnZkpvQzdoZkYxYXpEY0lo?=
 =?utf-8?B?c1dodW1UYXpxS2JUei9rSE5xd3E4RjltSnFkbmJza3Y1MzZBVFJlOUpoQjcz?=
 =?utf-8?B?SmRpL040ekJrczBJQlNYeUhnV2E3Z1FJSTdvckJ3S2pQMGMwNEptOS9aeTE3?=
 =?utf-8?B?cUZ2Qkl4SXhVMW5jczNCWjh5MnFKenBubXFFUnkxY0ZCcXBpRE5sZkpMMlRL?=
 =?utf-8?B?ZlBOU1RtRlRQdlREamxNOUlydUg3ZGhRcnhPN1VnR0YxS01YTjgvZEJ0ZW9r?=
 =?utf-8?B?eGJCUy9iSFpnVzFUbXdFeGoyZGwvNXFYZHYwaEpMRVBmbC9teGo2SXlXS3p5?=
 =?utf-8?B?cGdsNFZBOEJJOWVOdVlzTGxpYi80enJiZVdtY0tMbTc5c3R4MHRJWWFpcGgz?=
 =?utf-8?Q?JHzLNv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXF3blU2L2V4c1pHcHlsdGZ5WE1WRVdtT012cDU1TXhCeGhvcnJyY0ozVVlF?=
 =?utf-8?B?QUZqZjIvN3pSQmRXRWR4NU9ySXFyM1JZaTU4QjhFbW9wOEJyd0M0VEY3bXNo?=
 =?utf-8?B?c3JRUWEwdGhvN1IrZjNzU2RZVUxwOFlFRUpTWVpMRXZqeHZsakU4WFJydFZO?=
 =?utf-8?B?cnR4QVp2cU1LbGNaMHJlbCtDanltK2NJYWZkUU1qZzBTeVJ3WmNSVGlSYkVX?=
 =?utf-8?B?eUlxTUJnVVBJSWxxbFp0NlQ1WS9CdEtrSTVpWjM2b3lGRWVoSXd5OGMvRUMy?=
 =?utf-8?B?ZVlKTlowR2NXVFdxUGhoRjFlcDBPQVNUeHNQRStxK20ySytBVU5wdkVWV2lq?=
 =?utf-8?B?Wm9QVFVhRkJoY3FYMlZreCtUcldobG5nSFBGQ2dwbEgxNllYc3lUVFBPMkpQ?=
 =?utf-8?B?bGtKZGlHWmRPOWtKRnJTVzV0Mnc0b01TUkgxQTZxS0xZQ2xUTElXRXBVTzBt?=
 =?utf-8?B?SzVWRGhiSTkwdXF5dXNrQjRLUStqTnR5NEo0L2l3ejVLV09vTkhSako3LytM?=
 =?utf-8?B?YTFETWVrUlo3Z1JyekQydzdqb0xpK0tHL3JoclByUXBON2Z1eWU2YnpOVGl1?=
 =?utf-8?B?ejFjZnkxVFdTVjdZajlPVUlWWVFhbFEzVHlqVGN2S1JPVGZIN0hIMnNNWDlS?=
 =?utf-8?B?R1RmTGpMN24yMlg1bTdZcDc0N0N6Nk1ncmZ2VzNnWUNMMEVEczB4S3VVTzhr?=
 =?utf-8?B?NVlvN0taUkVjRzVTS2FERkRUOFh1UDVoTFZPeGk0VktUSkkzYmpWZi9MOXZR?=
 =?utf-8?B?aVJCVGNVanc5OHJFaFlGSFZFTG9pSzRPanRwcUIwZ0dINzladHd3ZmRFczhS?=
 =?utf-8?B?c1VWQXVmTGJKL0FLSWJCNWJwQTJLMHNPdm9VbkN4RWFyTkpRK3Zub1pWR1ZW?=
 =?utf-8?B?QU9QdUZ3bmdwSm9EOCtDVGR0KzNrYjRwTHRvY2luMGdYRjNhL2YzNE84ait1?=
 =?utf-8?B?bnZRZlRiWG4yRk0vYU03WTdFcW9yZFE0TFB6ZU1oZUVvQUhnSU5PZnlVclFv?=
 =?utf-8?B?WlJhZlBybUdmL1MzTlhwV3h4OWh5Nk9HMXg5UEhEYUp1UUFoeVF6RTdCY2ZV?=
 =?utf-8?B?cGZZTEFIYzRRdzh2RVJ5R04vMnJmR0FQK1F4TmxzVENZOXpVelladHluWVpE?=
 =?utf-8?B?ZGZ2VTZrMC9ZcFRTWkM3K0N1SG5ORmhaRDcxR1ZVemtaN1BSbzNTL1BIZ0xM?=
 =?utf-8?B?MENKUzcrMW1YYW5xTmpqQTNGNkxvYW44d3ExOGRQanJwZW1Bam8rUFkzRmZm?=
 =?utf-8?B?RHc0QnhmeVVVNDB6WTdOdzdsbFZxbzlYV0p4R1I3ZnB3Z2hpc2daSG9TYmIy?=
 =?utf-8?B?U1ZTRkYvamwvVkc2bmhGNzc1ekFPb1RUODg2YnBkVGoyRks4Tk1KQURDd1J5?=
 =?utf-8?B?a2Q3bW1WZ3dyZVgwR0JhWFRhbFpzRll4VzdtbkpwSktOaDRJYVcrNSs0bWlK?=
 =?utf-8?B?YmdpVUQ2TDBOMHBRL2lYeHhWditzaUtOM0FaZlZSUTdjZG9KdzVnSzlFU2xy?=
 =?utf-8?B?bGJkSXprbk9sbXpZMEsrTzF2ZUYrK2UyU3RIWGxLQUIzOXE2TlZNbERMRDdt?=
 =?utf-8?B?L2lTVDFUU2pjaSt2dnBtVHZLYmROY1hERllNMHB3RVNQU1Y1V2V1eG5mTE5i?=
 =?utf-8?B?MW5rR0FXa01NcXZQQkIxbXdZT1NwVmdSRlJDODFzNUF1N3BSbUVaKzl5SjV5?=
 =?utf-8?B?cytSeWt0bUZyWjRJNDUwTWhGUzA5c1d6M2pNMjZ5eGtYYUlmcURKL09zZVMy?=
 =?utf-8?B?ZWxMenRrdC9oWkl6VnVJWmZzRTR5YXNLaVUzeFp1Uzk1dXJESHoySkpQa0J3?=
 =?utf-8?B?TkdYV1RMNXAycHltaCtVN29vZjV3a1NtcTNobWdBeUV5ZmdiekMzcG1RWGdU?=
 =?utf-8?B?ZzhSU1dqaFFqSWI3YXViTitnN21Ib0tHL0hhNEw5OXk5ZE94UnJVN1Y1ME4r?=
 =?utf-8?B?d2dTZVFXQVdhc3gwTThvYkRsVEt2YTJrNkZpaWxZdjNLczlwNGdra3JJMDhn?=
 =?utf-8?B?cm1tZGFiOTVncW5DdVhHb1c4eHFvazVER2srTlZrMHg1b09jVUdFVnMxc1gy?=
 =?utf-8?B?S3pta0IvODh1L1psZVZGRmZZYXdRWHhseWxwSXRlaHYwR01FczMxRnA3S3hj?=
 =?utf-8?Q?mOfWUC1aGQs+vEaY6TtCJp9so?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd054901-b9ac-4d46-4492-08de0fc6a814
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 10:51:43.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jhj/b+pOnRz6I9mXqO1YoGbsbxwMZtg1p46w/lPwstPNynm2pdEcTLtlRcbh4tK5lKZ6HlNsGOeAMYFp75a/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11683

From: Alice Guo <alice.guo@nxp.com>

Add the compatible string "fsl,imx94-ocotp" to the imx-ocotp device tree
binding documentation to support the i.MX94.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index b2cb76cf9053..a8076d0e2737 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -14,7 +14,8 @@ maintainers:
 description: |
   This binding represents the on-chip eFuse OTP controller found on
   i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93/5 SoCs.
+  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP, i.MX93, i.MX94,
+  and i.MX95.
 
 allOf:
   - $ref: nvmem.yaml#
@@ -36,6 +37,7 @@ properties:
               - fsl,imx8mq-ocotp
               - fsl,imx8mm-ocotp
               - fsl,imx93-ocotp
+              - fsl,imx94-ocotp
               - fsl,imx95-ocotp
           - const: syscon
       - items:

-- 
2.43.0


