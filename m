Return-Path: <linux-kernel+bounces-882620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD91C2AED0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3A53B7672
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993C02FD1DD;
	Mon,  3 Nov 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cfycmGRi"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822CD2FC00A;
	Mon,  3 Nov 2025 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164496; cv=fail; b=rUq7tXjedy6ul5jS695La3HOfL0tRa3Zbmvo29figz4BVRGsirMlw/MvqMKzSWI9hwWaaPabz8BtpOb9tw1ob7W64u1AfhMmIt5ire/c0wWO5a9gYSVxUttkyQkV5PN+oYEqqzSyxLrud0stI54Rf23nhInoVEIY7Bozqt7zh3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164496; c=relaxed/simple;
	bh=QPaEGllPqzjbqjisj0UjhOVhaw6OpyVrVtKxj5z8AlA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Cp2sMWrh9866/chg2Q0svhdTtb3FtvVCP9qT4cSY4vTv1KRTHMzUUtt/guu6ixPSy76mgtS9LqexRuxK/WNx4YPCap4VJXxXgIDXfMieogUKpZjw8bbH3e+B4+9FYwTinmVN5fyJmiK9YRshtsSySJ7C6TsvlqJzaeZNUs+ek34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cfycmGRi; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeGvolHtcxqC3U8LNoXJiPINamCuMFJO2CXlzt2QkB8uSFeCJjC3RCIDG9LGwQuoXHtbFaNOgs0wuOGbIFmnUiC0VwjAGFsiQXcsLguAgwEEyH67FiBNSgxSsuhjZAywdPd1TOUqKXcMh5LQxnm12YaMrAEnLOMRSalDqEq1HL3IgXAXsSulk455YQgzwE6CGzgth22d0IfeEUyt/LquhUFBjewie/qQHVNJBfvdx7LhiQ6DchcOqULu0BjpwarxhRcAdjSYsnB6PAUYleEos3vHavYQg3eYyHYCgNhfiARDCNWgTMCSsVIwYv1Xwt9/IWX3uw/ZeK90tyjOsJhflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIr6d7E+T+PY5lBuaAwB6zov1hF2VUR4rjhlimp9Gf0=;
 b=uM3gUqopVHkE6/4Zvcww+zt5QDh/bXG7lYxeDPswTmvR4wb2vHbAnCo91BZjI/+MIi9rXHTVTHVLJvx3pYLomSyO2JAsMP7Q5o7ENVRp2tNqW9OxNBZU1AkcFFpDsQ6v8NuCsQqcQbvj5bj/rREfbDHDNgdB74MO0LvVo9xfQKn//nxVuTMNiK3JYT11+I3z1765lA5PdbowlU0kfhxMBxM21FcBuuPQeDqMgZ9MgpmaP0BdhMxbvkUHdysxOxPQQp3xTS1+xYF5P6p2niS4hgrYSR5XpBvo2LDwhOE1IS/0D98KNRa1kaCQcHOYJeamLT9y5YwVcxKZWgEC49Im5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIr6d7E+T+PY5lBuaAwB6zov1hF2VUR4rjhlimp9Gf0=;
 b=cfycmGRiQqYcpejc81gech78qzcniU9aHVg0rrFJC5Fm0Fs5CpfzpBCbx5fPALw3eTu6wdoJlYukbwxUApzCRTC0rEqNU9MldnVO5N+EPUlxhTQuT0OpjXuZqL0sKJju7RkWM5f2nsTKmc5IjziHghO+rZJRWXV2zJd8nRWgE4E4ESD45acDGSJzpcRkItfqtR6SFFFBqRDLK5pDox1AlgHI1BP5v1+Ri/ALQ68VhNgIl9RXy2fQ3LVA4M/CUwI/aWE6XLygSGpAhGhaTsyMp+BrRgH2gi1+U1l9/XoEkWd+UHEs55+N13yNwaAuLV9RcqozZUDZHc6KMecyk5G0uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DUZPR04MB9872.eurprd04.prod.outlook.com (2603:10a6:10:4dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 10:08:09 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%7]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 10:08:05 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Mon, 03 Nov 2025 18:08:32 +0800
Subject: [PATCH v3 1/4] dt-bindings: phy: imx8mq-usb: add alternate
 reference clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-usb-phy-alt-clk-support-v3-1-18b8bd4f01b0@nxp.com>
References: <20251103-usb-phy-alt-clk-support-v3-0-18b8bd4f01b0@nxp.com>
In-Reply-To: <20251103-usb-phy-alt-clk-support-v3-0-18b8bd4f01b0@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762164524; l=1178;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=QPaEGllPqzjbqjisj0UjhOVhaw6OpyVrVtKxj5z8AlA=;
 b=VMLS8b+ilF1GfisW3+wBBnUWh1CB121dClmHra/rQ01TAe+eALBNLGM9xXItPF6zrfxt7cAgy
 /qumvBsn1fEDfMt7Bku3LUwX3dSojSzcC1hicbAX0eR0Z8BMsnc6F69
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DUZPR04MB9872:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe18443-2098-441a-0622-08de1ac0e162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmE2TTFGS2pjejR4NDdubGFrcW1waFNFSWkvMXpvbndaOS9INXhNT2pyTWhp?=
 =?utf-8?B?aTdqZjhKM1hjL2dFMVRSQXc0VWJDQ3MxaHNadnZXdUV3VGJCUytyZ1J1UFlU?=
 =?utf-8?B?bEtCdWFEbVJIUXpEYmJkTnl0Uy9TVUNtNU1TS0tZa05zU1ovZElUVTNGNUx5?=
 =?utf-8?B?TWRHMGJuZjBvSFNwSFM3RU8vSHBUYisybHQ5SVZUc3kzRHZOWHZDZW8yUGY0?=
 =?utf-8?B?WGdhM2xuZENwQkFIRDNoc1J1dEZqM2NqRzJpdkprcStoZGVRUkZMWGVnQXV0?=
 =?utf-8?B?cWJWbDRIR3RndGZDYWhUV244enRjOGtsMGlDMnBoK3FGaDdJblN5Q0F6MC80?=
 =?utf-8?B?cXlmRFo4VDI2SXhsWitWaUc4RjJuVEJEMGxFbTJaVjNTZ2V5MW51VmtaRk52?=
 =?utf-8?B?TklEQjJXa1BmYk15N0s0VTltcFFGdjNDVzJGVklQZkRwTTRPOE1DYlpkSlpm?=
 =?utf-8?B?WWpRTVFCTUprd0RVbk4xMDhjQ21UTTI4eEVjUE95dENUcGJKd0ZTQmpyMkw2?=
 =?utf-8?B?QkVyOW1aT0U4T2M2U1lOY0R5UzVNdHcwc0lScGJnWDZIaWVob21JUUFEMjBw?=
 =?utf-8?B?MmxTMiszSk1FSDVLNm5YcFh3WkNwQUIxT05jeHpCcUloWlhMem82dDNEU2Jj?=
 =?utf-8?B?R29QQWhGSTc3ZjFBanNZU2VNTVNSUG1Kb1VZZUFWWng1bXF3VTlBNUx4QTBm?=
 =?utf-8?B?aDRUOXFYSno5TnFFVHdzSERMOG80OXlwUUxPek1JWFZqaklRUktSMW1VZlhX?=
 =?utf-8?B?MkV1cGI0VjRTcFkzZUswTjNrMDFITm9nYms1cVN2MkZzdUhFWTNpR1d3dTFM?=
 =?utf-8?B?UVh1aWFVWlVLQ25yNGlQNnZNdGJGc1UyNjB0UkJsN0tsWHpIMW4vd2hkNnln?=
 =?utf-8?B?bHBJNnBra1hxeURXa3RWMm9Tb2hBVXBXSTRFc3VPM3I3eVRrY3IvZWIrN2Fv?=
 =?utf-8?B?YkZOSHFkZ2R0OVJ1R2pUc0ZVM01Qd1lHWWlmeTJGN094S1I1TXZMSU5zakcx?=
 =?utf-8?B?TG5tRHpTamRLZE1xUjBheHg3b3Z3TlNVSnNmR0QyWTU0N0RsK2pvMVk3cFRB?=
 =?utf-8?B?cmtRYmpna1VuMVdrL3A3R2EzcVduQVgrZkZIVTZaYjVzNU9GeVorVW93am1j?=
 =?utf-8?B?c0Q2MVFscjdsSmJYRmpoN1JkK1VlVnp2dXIxQWdtZVYxRWJzWjBYRitia3ZJ?=
 =?utf-8?B?dXJaM1hheFd6YnZTWVAxa014RndsdlNGSFJxWUtWTDM2aWlLZVdId2xIS3Yx?=
 =?utf-8?B?MTd0NEVzT0wyV0ZyL2I1MkVKczhHMlh0TlRlUmpTNnV0OHdJVm9OYWlzK1E4?=
 =?utf-8?B?K3llcXE5azhxM0lzeWR1djZ3NmxIanl5cnBBYnhUbUlDMCs4SnpJR1hxc0JJ?=
 =?utf-8?B?REUyUXFKZkJKMTRDRHBtMktyU010M3Q2OS9DbUdjeTBUUk00a1lQVWlpRzV6?=
 =?utf-8?B?bVBVVDQ1YlpYT0orYnZsNHlCcWhtQWZ5ZzBaLzVwSTlHTCsyRFhtQnRxMTAv?=
 =?utf-8?B?aXdyN2lBZGN2VzlGTTNyTVZzSThGZ2ovRmxLcThHS0ptQm5WUjlveG1lTVhj?=
 =?utf-8?B?MEp5b2lwZjRka2l2Q2lqZHV4cVFTaENwNGlZRXBXbHdDS2xPN3B5UVFxaWZC?=
 =?utf-8?B?d0VOclZkYlNwR0wxWGdEcWxqQzhqdSthMmhXU1AvSmY2VHlhVU56UkZhRnQ2?=
 =?utf-8?B?RlZtZGJWWkhzU1FOWWYyemc1eXBFdU5lU012cjM5ZHV6MiswQk1Ib2hSRjQ0?=
 =?utf-8?B?L2luZ0JHTG9EYkRCbUJScHcwT1poV1JFZ0NXRFV2OWszT05KbEZIUW9vZW1I?=
 =?utf-8?B?TVR6VUprZ09mVEZDajh6c2YvRys0eW1iL29qbXZFRzJkakNodnF1NTlZdXFv?=
 =?utf-8?B?S2tlalArRHdaOVpucStSZTgraXZ3bi9PTHVkeUl1cnJ3UHpxMTNkSXpRMzVQ?=
 =?utf-8?B?c0F6SS9IVFVjUWhOWlJVOGdLM3l2NVBqSGJCRnptWENPZGRGVjhhZWxETnhs?=
 =?utf-8?B?U1RNYWkrRVRJYVdNN2tLN0FzUGFMQUxkYlAzSUcwZ2xEZkpwRmxMT01sdFA0?=
 =?utf-8?B?di83YktCaFVINENOd2dzRzJmUnNRQytpbDY1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjN4VjJqWTNONmlmTG1KdlhyWll1TE1tdVVSMG5zTkNIRHFuRGplVFpVMVJh?=
 =?utf-8?B?U0tPODIxV2sybThKODYwUGFNMEg0TVFHVFdPOGJ1emFiNVhzVjZMaDJnb2Jv?=
 =?utf-8?B?ek1FK3I4SHlrWlNtRXp0bWZMYmlqTlY2REN2WU9RUi9RMHNxTTNHMFRibUJk?=
 =?utf-8?B?T2h6UFQxQkRlaEtHMHVodjUzUWhOMTFrSHRRNU5PZ1BDY3kycVU1WXNkL2o4?=
 =?utf-8?B?TFU0U0xidkJTUDVlR0lhR1ZqZGF4NVdKY3VqeVhyNC9TQktMSmR6K2VsNVBS?=
 =?utf-8?B?ZVd4aHhUWTB5QTZCV2ptV2MyTkdsTmJnNktBUDlYeHFMVzFlWWhFM3JwZG9N?=
 =?utf-8?B?cEh3VFVJYzF1ZWVJQWQ4VWtEdTBpZFp1UmlveGdNcmFHVzNhb2Q1QXZPa2dR?=
 =?utf-8?B?S1BiSTk2QWtoajB1dzNreXRLLytRQzhuYmdEamZ0enFaSVJyMU9nZ0hueTd4?=
 =?utf-8?B?Sm1MSHhuYXc1bjR4Z2VNRWRpWm1MN0E2cWt2VWpYamdNamt1TWhJWWpYTzVM?=
 =?utf-8?B?Q2Y1ak9TN0lwTjNHaFRXaWUvQmNzdGtLL1Q1ek9TVmZrVTBIOHRnRVhBNVV3?=
 =?utf-8?B?eWM4SHdQYnlTQVVhWHNMcE9kTHRTYlAyaG5BZUd4T3pvY2JqVWxWY1Z2Yk9o?=
 =?utf-8?B?bG9vS3luSUlCdGR4SkEzMCtka3hzTDlNT2VDM2lVclZoSVVvZE9hc0RNb0hL?=
 =?utf-8?B?STNZZUVuVXBDSUVvdlF5TGloQU1wM2hqdWQvRWVCNXZWd1dRMERvZGZYRllw?=
 =?utf-8?B?UmxjVjQ3UWlVOUQ4dTZrUGZvVGh4Qkk1ZEtxUjNZUndwaEt5elo3WjJpMEFB?=
 =?utf-8?B?Q0xteksrZUNTbkltZm13aWlPOEJmUmkzd0pCVU4rbkJiZzNTd2VNOXh5VTcv?=
 =?utf-8?B?cmxuQ0NvUmVCbFpSeHRJTWNRN1c0UldqeHRNTWZqNUJYMTArV09HeUJjSVVl?=
 =?utf-8?B?YVpuZlNzeGVoWHJOS3V3ODV3L0lKeFVkYVVhZ0VONGc2ZlNEb0tMVEVlbW5Q?=
 =?utf-8?B?VlUzZjlrSVZ0eUR3bW1XaVgxQXJFY3VEc2orUmdyd2dzRk5WOUc5NG1xdW9D?=
 =?utf-8?B?SnhxUzV4UDlVWDJKWkc1SVB4RjJjUUt4VWhCMlFZclg2d1VZYWZRZTZnZVBt?=
 =?utf-8?B?SGxIOG16c1EwdXkrc1hoS3BKYmpSVkNNVlJ4VXF3SE9EQUREK2FvOVVxdUpB?=
 =?utf-8?B?TDFvcEdDSktsK3UxbExzbVVjSlZ4QktjK0tRb3VCa0R6cnE3ZUhFMEpsM3Vs?=
 =?utf-8?B?aCtIVWhEeVVuR1hMWktaWUxZeXJ4WHdnalRobEZYU3QwRlZFMTZpV01CanB4?=
 =?utf-8?B?dHlaNkxvWllOU3krSG1qZmZ2alZVY0pNQnNpYU1xYTNhQzFGWDhqcjVHNmlS?=
 =?utf-8?B?bkxnNEs4TWlMSmZyT2NZcmRpVGFtL1gzMU45WVFUQURGNUlaTWQ5Rjh3MTRE?=
 =?utf-8?B?ajdyYm1vdE56dmNwRnE5eER1S2dBb3JzTCtVV0pKSllRSS9WR1RuQkRNSXd4?=
 =?utf-8?B?MGlCbVhxZHAzRDRFOHdpcGxKWXh1UHdGNEZpY2c4ZkxVdXcrZzNJNTZnSEF3?=
 =?utf-8?B?bk1rNkZzVjdPTFVRK2xqR2V3dyt4THkvSmF2blp0Zm5tZnYrRDRtUVQwMUlP?=
 =?utf-8?B?aDR6RFJ0SlBJcTVCdzBXQXJJeW0xcVozaW9nT29Gcm1EeGpLU2trQTczb21S?=
 =?utf-8?B?WlN6MWZpWTN4T0ZQL1ovckVZR092bXhoOHlCNVlheHhMMWhLUzVqVG5wTGpV?=
 =?utf-8?B?aTNXcUNlVUhjRGp4bFNMZytpUkFoU3JPZmxXcXZWTGJTd1ViRUx0TDlmVkFH?=
 =?utf-8?B?bnQ0czVkY09hT0RvdUVHQW9FTHRvSjU2N1JNNmxHVkE1OFJIQ2NZR0FPUG9H?=
 =?utf-8?B?YUFkUERqblBWb0dpKzA2LzNHN2JOcWFyTkVQNEZWSWRERXdRS0N2TUZUampN?=
 =?utf-8?B?MkpZbkxXRi95cnBNUUR2U3pMM1YvS0wySUNYaFMzZ0VwOGpCc2hwVHpKdkVE?=
 =?utf-8?B?SmZpdVVqTEMrZ29VZVhhYUp5STlqRlRaaCtVeS8yOXFpSk8zSzhsa1J2emkz?=
 =?utf-8?B?aDRzWnFhbDB0QmtYSVBFSk13bGxsdFhBb09nVFM1bmhyQmZ5U0tJNHdXTHdT?=
 =?utf-8?Q?NI6JFszwmI9APUvt6Gec8mtBt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe18443-2098-441a-0622-08de1ac0e162
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:08:05.1902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAdJJJeMACj4wdkrRKHMI0EJwIGFsYHggnTiQybFq1JM6Eoubqux7IB6kUBlhKvzjkx2Wlyrsw9RIi2E68jbJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9872

Beside default 24MHz clock input, there is an optional additional 100Mhz
clock input 'alt' for USB PHY reference clock.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
Changes in v2:
 - improve commit message
---
 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
index f9cffbb2df07d6fa352a844071af7cc894652d0c..8a00a6c58edd47872c04bc6d8263895eaa258fbb 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
@@ -27,11 +27,16 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: PHY configuration clock
+      - description: Alternate PHY reference clock
 
   clock-names:
+    minItems: 1
     items:
       - const: phy
+      - const: alt
 
   power-domains:
     maxItems: 1

-- 
2.34.1


