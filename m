Return-Path: <linux-kernel+bounces-885529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90608C3339B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 162AF3489D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22749333738;
	Tue,  4 Nov 2025 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cuw4ATSB"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4631327F;
	Tue,  4 Nov 2025 22:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295261; cv=fail; b=qSIO5jOUwCSusAPCuM44nLq8lQLtkjcAHLX4grqLgrFOPeYs/5YIRFNd6Tjbhhmo0W2jI0EfjRufSzSF/XUiEk3SBPA6pfKuknFEVPV7y4t2RzWIhQTHXOJiZ/08ANrS9IQ7zR93+o/QTKiN3fDJGZ+D8fgSeZMdB0qUX3sMsaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295261; c=relaxed/simple;
	bh=gacryfK23BnLTliJQpyEE0Ekp7F7jAU6Alw+ilaR0dQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IVQHwn0ouqtXVPVb7UUEaMgzL1Xks0k6E7ZMWlR8/T56mPOuausSPUTpO3pvz+c5mrJhyke9w4PIG1vaLr7Aj09aSyr5cx+vaOBOn/sDO2PCWivaEbFCGW0ZhIrOQsi3ty2dM59bMivMTgPCrT2pr1M+BzHKX4kmRA0zDhWLDbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cuw4ATSB; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Atuq03Y+gsY++7vkNHWAsaBS+y/uuvzCR+jYzcyh2Yp1EiQP3vdp30CV5VplsOFl1Phl1VCIa9t5wtZmxlusJVBekxH9MoT44dB0gGLgpuUL8aRR0B7uikDEcB+vhMr+Wbm6C7baPvJ936AEkUY6Tau9LSGTH2t7u2mwFdIAcOPUjwz8DGHx5qTs5piLrl6vQQ0ttQXdMZ6+lcs5yYfy5ZIOTi/UDSs7lv1PPazbhj3wsBBITf4zuqSHK4bFYN/W/o2RPKnnAE5Ya2e9dxwSpt9hjS5CXh8SLjUH7TrVjNp/NvNNKBHsIgFuaYXhOwoYIdJApn4A8bn5m+kzcTRkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPO8aMwAlTy4ITKtltzsnpQLEiQ9M2NoJ227v9g/QwE=;
 b=WwXFVlU+s8sySjegEQaNtSOgUu4pq3PYPjh+yKVyW5Vq4bhxOXuQ1C2IHaglZ7HOz9oMAt/SI15PSsOA3Nv7LiZLQ834fXOR6IP/o/aNF+sw3PjIo4G9OhYUPq3OZIk+sbR0zs1zTc18+uvhnVV6Vg4vlb09G3wBEshnvD0Gy2cqX+7lPXdIKC7PyXVTWa1zIpLtuvxSy0REMyhnpPVdaMbTkhAlVSfqL1HtJEXk+DyVg9fYtDh8RntcV3RKFSm40nUpuJpB1bh1mn9ytQT5CIWkkE01a7fRNkXvJhi0WF+FRZuuwOA+74U9PsySwveMcF2z/foDaM6pJeWOtZiLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPO8aMwAlTy4ITKtltzsnpQLEiQ9M2NoJ227v9g/QwE=;
 b=Cuw4ATSBiDN4gMaMsab5Iv7winbutf2nIFqzXVQitx3nfBHxLsfrZBNPXfvdm+cU+h1WJfm6iIT8IPwflIOSYfs1e4IzdpIi5SXx3cyAVojtYkjJaaGORTFvwYQYdDkTnbOPIYicx7zboQO9GtxlbMOBQEWW0B+vYktyJ3NK74EX40FQJwcDHQrmA7KKrKOUB5y3lGoSYG0WRLb5XpxffF4zF3mgy9uG/PdFqiWPWM4weKk/dlIGmkby/PsFHj+6UaWNpBbGaluTmopjDVZmHDXGZK/EYaYfVEIM3PPCmhlI3c5ZdrfQWctob9AU+JRb/Q4WlTKV04jLYxOfKXWylg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DBAPR04MB7286.eurprd04.prod.outlook.com (2603:10a6:10:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 22:27:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 22:27:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Nov 2025 17:27:13 -0500
Subject: [PATCH 2/3] ARM: dts: imx6sx: update gpmi #size-cells to 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-gpmi_dts-v1-2-886865393d0f@nxp.com>
References: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
In-Reply-To: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762295246; l=1061;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gacryfK23BnLTliJQpyEE0Ekp7F7jAU6Alw+ilaR0dQ=;
 b=5eTgRG29ke+0Gk2KHOBHdEyDJnn3pUVeZYnxln15rJUNNvje/KsYyQgzHhkYtv1ujJWHU7Iqo
 X6JjDeHrGRMCKJfvqDSDRMhCIiW0V0Ovs2TZBRsQJNql6COeSJJ7rPU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::46) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DBAPR04MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c3d5f8-2480-47c3-5bbe-08de1bf15b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1o4MzJqQ0M4VVkwaDlLa01IZ25sa0VtaTRpQTZzRytjcUNVdUdubFF3RmN1?=
 =?utf-8?B?NHR5SHpsbDMxeDFEWjBUcTYwMHJiTVpXM1lKQ1hPNFdaeFdPMnQzaGVyVTVo?=
 =?utf-8?B?VjMxVGNrSjBSVVV5bEd1dWVXb2IrWXZLRnhJNzA0L2MxQnFtNkVjaHJCSUo5?=
 =?utf-8?B?TEVmNXI1VkMxTS9zaGRqczl1dERGaWFhYmJSeFlFK0lqdHQ3TVJvSkxDNHJZ?=
 =?utf-8?B?SEdDd3daNml6Umg1ZjJ5Y2pjWVdlSGZnbm5KbE1CVVVqOERhaXplZ2NGa0d3?=
 =?utf-8?B?d1ZJelJ6Uld5a1RZNzIzanpaOC81S2YwVDc4RmpsV1dBNGN3NXI3UkgxbjZO?=
 =?utf-8?B?TTNzQ0QzdlNtRTEzazlqKzkySlI5RC92VkZqV2d0UEtXNStwL3FXWlN1N1VY?=
 =?utf-8?B?cHlsVnJoOXR4N1krR3NyaWNRUnhKM2JiR0JoOE9qL3NnN0pSOTd5Vk5MVVVV?=
 =?utf-8?B?YWdhM3F2eUp0bkpBYTZIRmtMNzVqRU9qSE5nVzQzOTNIZERBc3pnZWhJNExa?=
 =?utf-8?B?R1djUHkrMHU2d1gweDZmVUR3SFlGZTVXR2pVSzlaNi9KcStsRmZqR08xVG16?=
 =?utf-8?B?cXQ5Z1ZDclVxMms2ZU04QnR1aDNTdFdvWFc0eENZeG9zZXlTR1NqZkhwTnB3?=
 =?utf-8?B?UTFqTVRKZUcwUEkrbWJZMHRpenFlMGpRdUNJMlJxL2VOaXY5YVJicU0ybHlJ?=
 =?utf-8?B?aWNtYWNJL3NtQjhtcmV0QWlDcVhhRFFrcnhWaUcvb25tTldlSldDeGpncTVl?=
 =?utf-8?B?ZVVLMEdoMytMS0RSVlpSeGg5RmwzQ0ZFV1ZOU1MrSFg5WENlcUcrRGorTWl0?=
 =?utf-8?B?bThvQW1rdGdqV09tdU03KzB4R2VXdE54WlJWSUZaSkExUVJIcU1PU3BnS2Z6?=
 =?utf-8?B?Skc0Z2ZJRm04cFpmVTNFbURBYVJjUjhzOEtGWGtQT2VZV2VMWnVQRFh2MWZs?=
 =?utf-8?B?c1pySWtwVmFQanAyWmxLdGs3emhBcVdCRXhseDlpTUQyNFJua1d0b2FaYTMw?=
 =?utf-8?B?VmxaVkFWSGluRjMzNXhuL3UyZS80Zkx5STh3Tkx2dEZVZkY4TVE3Y0lLNGhm?=
 =?utf-8?B?U1lZb2Npbk1wZGsrME9ySWZKeVB0eTlGdnhkRlZIK0lIY1IrMk5zbEJacFp6?=
 =?utf-8?B?OTNRWUtmMVVLTmIvMEZrc3lZdldFc2Q5bWZPVk1HSENDTUF0N0ZVOVJMbU5r?=
 =?utf-8?B?M3k4U3IxQ2V5dVQwdWdDcW9vSzR6L28rUHNOWFkwSS9uZkFTd1MreHhjUWJ5?=
 =?utf-8?B?eTFiRC9Pd0hvSURUQ3Jub1lRbE9xMnd0WXA0b2ZRSVRDSmtSN1M3K09RdUZ4?=
 =?utf-8?B?ZEtBTmJxTEhta3p4RGxlOWsyUVJzQnBaYVpWVms0ZEJ2d0s5MUUvRjVsR0dk?=
 =?utf-8?B?Q0RYSUNBSTZjTjN0R0N6M0l4VkxLaW9GWjJRV3hROG50NVU3ZWhQemhnZEl0?=
 =?utf-8?B?czJ1MjN6VWRkNEwyZmJRcEVQNStCMy8reDRDUnhpRXQrZnlObUE2dlZkRTVM?=
 =?utf-8?B?dS9RdE02M0M2QUtyRmtRWmZvNFl4UHRlUExKenZISFZqY0l0N1FRTWZ4KzNs?=
 =?utf-8?B?NDN1UTRKR1NFSjhQdnB1eVFvVXU4aWw4RkJaNDZFL09kUVB2bWQ1T3JseEJ6?=
 =?utf-8?B?WGhXNFUwT3ZOS1RZR3BHRzNhVTM4elUzRG5BY09IT3dRMW4zU01SKzRBbFdC?=
 =?utf-8?B?SU8zMTQ5c0dDQ09UcXdrbWN1Q1BQbVovdk1kQ1hHWWVUS0RwQTZ4aWhUYWtY?=
 =?utf-8?B?Wmp3SlB6SWZoRUNsMWZXQ1dRbE5EcVk3MVlwbTVlV2hnRGI5anZsMXZOaDVI?=
 =?utf-8?B?Tlk3aFlRMUs5RWJTZXowbXRabUJLTjk1dXQzcXhsdS83T005UTlhbW5OQTNR?=
 =?utf-8?B?NFgybEtRNXhJZlRaWnIyMjY4ZStsVzFvb3RDMDM2bjE4SWVFdWUyTXlmR2VP?=
 =?utf-8?B?OGhkS3dnZm1pWi9QY0Rxbk10MTF3Z1lMRkZNenRURDBzSHpLUDR2SXprdGVj?=
 =?utf-8?B?OCs1d3laWGtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3k4L0xNOUJUTXJzcWRabjZNSVZ1K2kyRTFEZCtiYkRTRU12bW80K2QwbGtE?=
 =?utf-8?B?cE9jbEhmNnFGODB5S3ZHcmZXbHdyNFV2VjYzUXZGOTBkREdtZFVBOFFHa0tK?=
 =?utf-8?B?c1BnSlpDblh2aXJLMTVJenpRa3YzTVo2VXI0MTJuNVlEOW4zSjlPdyt2d3NN?=
 =?utf-8?B?ZENOVUh5SytzSWhrUDAwdms4VUIrR0VwRkhVZVpzc3hxQk92aWdRUmtUSnR1?=
 =?utf-8?B?QS9scjRLV1hDVFh2d0xSc0RaMUt4S0tqVlVXWE41NHk2RkQxTyszY0p4U3pa?=
 =?utf-8?B?eUZqSzdBYjJVcmtXdngxQnVBRmVIRElUT3pCS0tvVERWWXltT3JPdTR3TkVk?=
 =?utf-8?B?cmlMMXJFZG96OGw2WEdQcTgxanBFMk5LTHpGQmdXcEZ5dGwxYW9IZVNUelY2?=
 =?utf-8?B?bnZHcnBwS3JXSmcwSzJqUGlxOXl5TGZRQk1pYUwxOGgxS3ZkT1orSnU1SGN2?=
 =?utf-8?B?M0FBRmxGaml2NytlaFNUc2c3VFdqemQ5c2ZpK3l3Rms3ejdiaU9pQkpEd0Iy?=
 =?utf-8?B?V1NFSjVvRXFNR3hTYTZnL1kxc3lHYjNja2pyTmZCQjZkRGVXcVM0Z3lEclhR?=
 =?utf-8?B?eXR2T2ZxQkVaZENjWmlXd0JJNlVkNEdKSnZLcDJVTHlicS9MTWZ3bHE2SU1z?=
 =?utf-8?B?d2VIMWo3STR2UkpPcHFWTVh4RmQweHJxVlJtaVlReWk4M20wVmNXWHYwSk1x?=
 =?utf-8?B?TEM2akRac04ya2J2YTQ1N2xCcGNxTDBBL3h6SWFDd0FXM2V1TWlWdTE4ekdW?=
 =?utf-8?B?amVaQjhoVVYyOEVnUWdINXVIMklFWDJCZ2VMcUdoRzhLQWRNT3Jnbzd6dXYx?=
 =?utf-8?B?T25KVGhrcTFVVGplSjZ5VlZ6UE5wSlpvUENraFZxaWJnWEU2WDdnMURKVVc5?=
 =?utf-8?B?WFNDampvdVlFWVp2Z1I0MHhnZlYyRDdFUHFHNmhlTHFVdmZpaExxcFpKYzJl?=
 =?utf-8?B?d3BZYlNUNkxSdXp1UWNvaXk4WmtwSGs2SjF5dStlczhLVGU0VkVOSVNKWWsw?=
 =?utf-8?B?UHBkYWhQRmlZQW1POVdzYkJnNWd6L1VZTS91eXozamZVQ2U5dHZrczhvZE9h?=
 =?utf-8?B?d2tvR3ZkSWFTTTFTRWhZV0VkY3VxajVud3ludmFrcmRWa24zTTdkMzV0STdH?=
 =?utf-8?B?U2Y4TDZhMVZsWGkySjRRTXV0Sm5kMmhMcXdKdzdSdjRiL2JXckswTXpSb3FZ?=
 =?utf-8?B?OXJ0VWt1czhnYStFbFVFTnpVc0hkOWpCZDJHTElzcCszN2NqcS9MVFRVKy9l?=
 =?utf-8?B?ZHVyQnltQ084aDhTR2svWjNyRDQxdVQ5OXNiMGdONzkyM0EwdzVTTkdsSWN2?=
 =?utf-8?B?ZkJib0pQSi85QjcxcEUwZnk2NXJKVFRkY3dsN1RvaitESmdTdEFRZXgxNStx?=
 =?utf-8?B?cUlKTk5aUzlsTnV2MndRWXI1a3JndlFlUUQ5NHpocE1rbTdDMjVCNVNQNTNk?=
 =?utf-8?B?cEt0cWc5ZFdCc09yblJzN1lWOGdPQ3docUZPcUI4bCtEa0h4aG5FREdPU3gw?=
 =?utf-8?B?bld6VjZxdVRWU0FCTmY2SFZodHNzeVdBMjNTeldpZ1EzS21MbG1qWnlvekF5?=
 =?utf-8?B?NUwwMU5Ud1M0djQvMHkycERwVGgwd0lBOWxPQVhJcVVIRi9mcUcvakFvaVow?=
 =?utf-8?B?eUVqcFg0c2NtcXZlMW9Ta0RQblNybVNpMEpDbXFRRjZId2FyZms2a09RLzRh?=
 =?utf-8?B?NERsWHVQWVJpNG1yQ3F0ZXR5UStLbjh6cjVaOUZOdGF2aFlya1VLYmdrRWtF?=
 =?utf-8?B?UXMwYm42dElDQnQzR1lLbzhuWkd5bjJMN2NtcUJ4YWwraUMzTCtlTkwvRi8y?=
 =?utf-8?B?a25NYU5Scm9RTlB0aXBKbkpOUm5waHhvaWU2NWxwL0Y1UEJrd05oVmVVZVhj?=
 =?utf-8?B?VG9mZDVBOVhDanFwSzM3YkVGVWR6ZzVLWW9LcklPZkFOVzFvREVzaGRVWDBS?=
 =?utf-8?B?STZXenMxdU9UOGpwQlRybnlSakw0VmRyQVU5SUsrM1dHS0VmenhuSE0vOUlW?=
 =?utf-8?B?bHdacjAzU3hmQVZhT1ZNbWYwKzhJN1BQNUxkNXBtN2U4K1hNdFV3aXRqbkJ0?=
 =?utf-8?B?R2pPM0tzQzdiZkVjZmUyL3ZZM2s0UmwwWkt6QVlEMlBXWmFpdjVHY0p0N0ly?=
 =?utf-8?Q?5Vcx6qyHLyFJ11073eQ1W0MB8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c3d5f8-2480-47c3-5bbe-08de1bf15b7a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 22:27:37.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5t7M1qwmziDX4bFCHTUq1jUAk0I4DajTipK8xxb+Qi74zQNYYAJPxqusRRkSi3zgxuytM7XtaeDwNxehcUeU1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7286

Update gpmi #size-cells to 0 to fix below CHECK_DTB warnings:
  arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dtb: nand-controller@1806000 (fsl,imx6sx-gpmi-nand): #size-cells: 0 was expected
        from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index 5132b575b001564b9767605ae7ff044701516673..1426f357d47448ab0ed289a5233f71c1e365033e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -224,7 +224,7 @@ dma_apbh: dma-controller@1804000 {
 		gpmi: nand-controller@1806000 {
 			compatible = "fsl,imx6sx-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x01806000 0x2000>, <0x01808000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.34.1


