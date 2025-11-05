Return-Path: <linux-kernel+bounces-885838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E90AC3403B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 210074E4E93
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089F280A29;
	Wed,  5 Nov 2025 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vi5Z7AcO"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637C274B42;
	Wed,  5 Nov 2025 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762322091; cv=fail; b=NCBowdtM1+jDL2CxQow3CNzA40r+eER/7aeLic1pRClqlVRMC692EAO9mW6L8Br6j+nroAMZ9T7KcLTIvzJykecEXK2+hi8OXPtJAeKPLanov0hZYZbCiUOx6A+4DZpl8MVqpqV9KSm3jjZ1oLdQ+t19W0FFkQpS/MLUxYU4n2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762322091; c=relaxed/simple;
	bh=CYDOZbIUuafLES2AsW/aqbqQPXeE+InsVnAPdLp7C+w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=pkOjSl85xng48Oa9uEIo4pIw6IodY7OmmWxRjNdwdmzmtreTxkD14oNG0UZ3bRDp5h4IjSrIoIuZe3fGNWw5kjYk+hnKQDv/E6ADypuBqGRUtPBx42RHRQVpx0tO37HuPHVKr47N3SwIKl//7WeRcT8/B+QTIm5pBwWjCJiyi8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Vi5Z7AcO; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaVukz9bb5kEKmnUIc47y8mY84ElW0G3tu2oliHYuLoTdU+8vmXL5IQD7guQA2+AU2Xup3N7lmYH2JBHD15CjyKBlKAG7vOTquZWogJZ402bmFgnbq3JZcW+ta31UhQKw3B5WiMe/3DZmERpy5tTtCAY3nCaY1NcST0fiiusKA8GGOnzNWYOYlJ2pU9pc4tM6DoT0QEXR3+/MnjK9qxLSzZOSFSq4uo4XMCTq6A1i3QD1G1djPIns4gKBu30VtaTjIrz3K39eVJ6VpXHblFfBmBN/+C+e3YFXxWkPgM7fAmJe0WEjcMOkCglfVUGLqS4oVNJNfLq+VIGy4WZRuLQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D70Jg6f77rQLPW9Y97xxcWpczj5IH7AlrxUWxjXdF8A=;
 b=Yl0sLbW2N2l86/++PvVuPb4eQQXrAyCxHzOtdlZ4cmj6jWTymiEget1+yimBwbWeMwjhnBbNMZO2z1hCTofm210vl7nrry7sENGslTuxemR10jmMRgU3+jUx7qT+u0Wovd21hzpJMGdFK36PGKNOEDTi6O4kgUbA3Bi6Ve/5Md7kpzgwgO0VyUwKuHrKwLejJ+Ib49ltJTayNFTKQSJ1rxWMlR8qimQ3D/Diyntytm6NZ3rvpkYdNvU0qT04iIjx02+XFd8dsTW250juXjlcemQq+MrYOJNwCTdlQLVNd71mItCq2p8oILG/TX6I67sUkzdiXCPJwd4WqwKSxVDxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D70Jg6f77rQLPW9Y97xxcWpczj5IH7AlrxUWxjXdF8A=;
 b=Vi5Z7AcOveEccmPqTsK+9yJFP1+s+0IXzsd7trqNTSG25fxACTHir8ioktE73Y+57nGsDJqP+WmIzlafKZaGRpVpQWiMZz3abH87F+ghtNoPvyczrn4hzO7i6rdOdmyYZEo1nFsk5/gtL8ABL0HUw5VbFe+DqrKDbCFDhpVDnN/xf/tWdOB0KkVg43dIi9FOJXU1T3iDfIAuu1J84zbWWJ5o3HvUVnKWK04ZDvWwJUj1u8zjpoQuQywMKEYCGKOldRaR096/TXw9a3FBdWq6afY9x1AXxHVNfR8CpOb9q3hhbWAhcg7zGWgHuq0SZouUmfIK0hxccjyB3NPetA5qcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by AM8PR04MB8002.eurprd04.prod.outlook.com (2603:10a6:20b:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 05:54:44 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 05:54:44 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Subject: [PATCH v3 0/3] media: nxp: imx8-isi: Add ISI support for i.MX95
Date: Wed, 05 Nov 2025 13:55:09 +0800
Message-Id: <20251105-isi_imx95-v3-0-3987533cca1c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3mCmkC/1WMzQ6CMBAGX4Xs2ZpuayF48j2MMdAusgd+0pqmh
 vDuFi7ocXa/mQUCeaYA12IBT5EDT2MGfSrA9s34IsEuMyipjKzRiLx48pBqI5A0lrpzVJcK8n7
 21HHaW/dH5p7De/KfPR1xu+4VlOryU4kopNCNw6arrHYl3sY0n+00wNaI6vBQ/nkqe1aatrJt/
 lh3eOu6fgGDY4mY2AAAAA==
X-Change-ID: 20250915-isi_imx95-1e3163fde962
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762322131; l=1749;
 i=guoniu.zhou@nxp.com; s=20250815; h=from:subject:message-id;
 bh=CYDOZbIUuafLES2AsW/aqbqQPXeE+InsVnAPdLp7C+w=;
 b=LY7G+uuqegHWHUtLsA9YBeHdsHDYaBCCZ0diAQCUKYUiMOlRet88c2FOtqgJ2Oh/Fzp9s8No2
 /L24qnq4oavA/MkyO8yl7q7eWc0YA6HCI6Zv9BSEXaGdJoqpmfxCoJr
X-Developer-Key: i=guoniu.zhou@nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR04MB9080.eurprd04.prod.outlook.com
 (2603:10a6:20b:447::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9080:EE_|AM8PR04MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: f5978a85-ded8-424b-ccec-08de1c2fd1b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L05LbWpHVVFYUlg0bXZQWm1vc2RmdUcxcDJNYjd5ZWo1MWt0VW5rL2ZlM3Mv?=
 =?utf-8?B?UWdjNTBJTUkxRjQyMWhuU1BlNmR1SVoyc2o3NDJoeWJObEtYYXVibnhsNkhp?=
 =?utf-8?B?aXdxMWkvK0M3cWNudEFvUTRPYXJ5N0hJR0NzNjhuU3lXOEsreUpQMHV2anVV?=
 =?utf-8?B?T2Y3dk5oVWllSUpndmhaaHVaYko3VTY5eGNydVJha0Y4SkR5QTNMNVpKdkt5?=
 =?utf-8?B?aXN3ZkwzbUZKdWZiOXhJRWxvN1R6d3pvVjNaVXFCek5wZE9sTk1JYWE1cE5y?=
 =?utf-8?B?NjkvcGpiTDFUUEQ2eDV3QUlGTjF3WUUyS0NHQWxKTDN0bTliTkhjdHRYa2xG?=
 =?utf-8?B?ajVVdzZqd1pVTUw4ZGl0Nk0yV1RYc0srVGZXT3krQUdkb2dOYTNqTHZYL0p5?=
 =?utf-8?B?WkVaUE9odWg2bWxQVTZyU2hlUCtDKzZybTFzdmdjOTVIQXFjd1lTd0JUS2xN?=
 =?utf-8?B?dDhBQkt6ZWRGZXo5NEEzbE9jV2h4ck8rMURVZVF1bHlueHVqUVozRGdlcXZN?=
 =?utf-8?B?MFBRMFdYdTFRSFR3UTZuQ1ZwL25kdGhBR2xTdE5MamdQMmhDZWRnY3dicmVK?=
 =?utf-8?B?dGtiVUVTS1ZGUHBjcGw5aFE5Y2Y2UzRXVUZDUmMzKzlKdjlGUm1LeGZFTlRQ?=
 =?utf-8?B?RnZteVlKUC8zd3M4endhaTVxZGQ0VklXcTNZSWVRZTduNFRIRlVVL0Vlc1Iw?=
 =?utf-8?B?RjhtZkRlZk8xK1lBVDJiVGlqTGVwQWYrdkpiWTBWSHRVM21tdVJFTzJaYjRW?=
 =?utf-8?B?eVhRRkRNWlhnOXJwK3YrcVQzTkRWekg3NXIwWGRhaFd3WWJiTllqUDAweDFk?=
 =?utf-8?B?QUFqbEtQZDEwZU16bmM4eUR6K1hKS05FUUpwSmRHNHJkNTAyNzhuQkJZQ1Z4?=
 =?utf-8?B?Z05WNCtFMTlnL1dwM1JnTXl4ZVNZSjRhZlhHczNYNGV5U3dqTHRPZXU2ek83?=
 =?utf-8?B?NjlYVnl6WU5hbUFWQUtxWHZvekpLNEFKRjhFUlo1UWdUbjFQeUtsOHQwcGZ5?=
 =?utf-8?B?cVBWaU8vRjNLNy9OVC9hQkU0ZFFWVFhleEdLdnNQSTdWNWN6NUdGY3dFRHNZ?=
 =?utf-8?B?UWdNckhLbXZ6M2diYm4xTkVKNE1kV3NQRXJpMDZQUnQrS3ZtS2tlWnd4R0Nk?=
 =?utf-8?B?Tm1oYlMvWUZ4bGp1UWlqLzBMQ0ttckEzVFlIWHhNbituSFNicyszQlBpTE5Z?=
 =?utf-8?B?WGlkdysvS0ZueVYwK2tJSmRndFR1WFE3Q2NjMTBHSURsNmVIend5ODlaWC9L?=
 =?utf-8?B?WGtZcGNDKzlHY0x4dTQvQ2xIWGJOd2pxeFZ2UW02cGFkMXVMZ1k4cnVvN1d2?=
 =?utf-8?B?S1pSbEM3elNhYVVKM2pubmIvRHd5UlVVcW5EK3pVcUtOY1Jid0liS0g2MGxh?=
 =?utf-8?B?OU9rSVBCeFUranBBSGZyYzFmU1V2YVRPU2lleUV5NGlKSVV5WEJrM2hlOHlu?=
 =?utf-8?B?WDJnMXN4aFRJVHRvQlZiWlFWMzducDlBWmNGU2p3clE4TWQ5anh4ZXUzOWJL?=
 =?utf-8?B?bWJNdUMxUVYwOXV1ditqeXpGek92Y3p0VWFRN2w5L3FGN0lGMm5kT1B5M251?=
 =?utf-8?B?elRnMmNWNExCdloyVlBvMFRGY2d2cTFCeWpxWHhhcUwvL1EwWEZQRHdCTlI2?=
 =?utf-8?B?bHIwMEIrL1FZVDBxam4xVG1EZlVjbExKY0JIaFJSb3BqOUdGa3JNM21zSDU2?=
 =?utf-8?B?TEM4OFpjN1MxQTZicVZtMGpMM3Q2UE5XOW5Hd0JtbDRFSXRGTlBOc2ZXR3dR?=
 =?utf-8?B?bUtvMGdFUkQzZWEwR1IwRUd6L3gwRWF2a05mbE9vU0E5RnkzaVQvb09aYWhP?=
 =?utf-8?B?VkkyNHlFdTFFZXpGdUkyWHhJZTVVM0dZQXZqekFmUThmemdIKzhSNGNERkYz?=
 =?utf-8?B?VWpITjVrSXRZTUpFd0tBNUFtNm91YkZaV0xPMytUcTRVRHlJZHpCSW1oeFEw?=
 =?utf-8?B?S0pvUHhsWkxPV255SmJRRWh4K2l2YzJFTCtGUXMvbTRqQzRzcE9vMFA3RDF0?=
 =?utf-8?B?SUlJR2x2SUtESVJlbDM4MnZwdFZIUldGU0s5T2RtcjE0VjFmakN3ZDdReEF2?=
 =?utf-8?B?QWdKNVZIa3hvdHhkQWNNd05aS3pKK2VydjM5NUkwRDlQOGZRZGRkZWRtRThm?=
 =?utf-8?Q?n4oM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WVFFa1NhRW1QUmVYaHYzRmNZVC9tVDlYeHJuZVg4cWZEOGU4STdheVJtU0Fa?=
 =?utf-8?B?OUxqdkRKejB3Yi9BODJYb3RpZy9xN3pLTURKb3RXelZBdlMxOHhCN052VW5n?=
 =?utf-8?B?UldGbEptNG9hUkcyTjBoSm13RU50MlNITThsNWhRNUNybkRVVU9tckRVbUE5?=
 =?utf-8?B?OUVpZkN4T1hDbWRUdWw2Q3hwUnRObEpaZ0hJMWhvZ1YzbVZRck5Idk5OMm44?=
 =?utf-8?B?bXNIeHNVb0F1TDR4aDJhekVISGlPdmNuS2JOVll5MVF4SEJwWXZJRUJCQ0Zi?=
 =?utf-8?B?bmtxMmhGU3U4cFNYRVVWQjAxOHN4UzJ6UGRkYXR0UVBEeFVSRGZGMHNhVWZB?=
 =?utf-8?B?THR6L081Z3RMRHlIcENZdWVla3BaNGdOQ2FnNkdZa3E1RjBTbUhuUHRqdWh3?=
 =?utf-8?B?MG5STytBdWdzWUpkN1llVWM2TFhrTkRuOVRacEVyTEI0bFRmdURwZFUxWnpm?=
 =?utf-8?B?YkpQZGJvU200bHhsRDFZcytVRjhJaWQ4SHp5OE1yaDlMS3ZTU3IyVlFXTzFs?=
 =?utf-8?B?YTJYU2k0aTJTV3dmNjhENWowOEtsUDBzM1FsRGR4Q1NiOVg2d2lMVUpDVVcx?=
 =?utf-8?B?SGluR1hUUEYyN2xlK2RMSE5PdjZIZm1TQTMxSnlkZlVJVjFtek56WGpYUWdt?=
 =?utf-8?B?Y2R0WFJPTFVaQTFCalBGL1FVMzNPcm1UTDJTUXFaZmZDZmQ5L1d6eldVVDlI?=
 =?utf-8?B?Y0czMWxWQ3JsMWNRR3FRbFI2Rms4TFRhUHFSZWNDUDZLZkhLdk9kQmN0eTJB?=
 =?utf-8?B?eTZJbXE3TXRHSEpqbXE1YmpxeHRUVlNrL3Y3TE1jbUovOFVwZXltQ3Y2VWZ4?=
 =?utf-8?B?T1h4THRlbzJRTTZLWncxOWVxWnJIRVRpbmptOEYwSERjd09NNC9OM2Npa2dV?=
 =?utf-8?B?REJQNUxWNHJvRDNaQzZkWloyVm1QSzJ4RnIxSUF1dGR4YjBFMW1PUXZKdnFr?=
 =?utf-8?B?c0dXSTQ4OThPeUh5R3BMTlRNQnd4dHVYWkFKK1BiNGZxbDh5b1dpcWd2WjNX?=
 =?utf-8?B?UkoycGh3NjJuNmJWTjkzbG1BWmVWL1ZucFh2ZUN2aXNmUitHYk14MnZPM01W?=
 =?utf-8?B?NFh3VjliOUtQM21RZ20vdWdHck84TU1sby9MalpRYk8xdkNxTWdxMEtKQnNs?=
 =?utf-8?B?cHZDbjFHam9iTnVvVXdCc3R5NkFVUjAvanF3M1Y3YS9SemJrY2FCcmhBWmlE?=
 =?utf-8?B?ZGhXUVFvNEp1dXZnOTZyN3h2U1ZhdjZlQlhSZC9jbEN1b0xSNTRWTnB6ek5o?=
 =?utf-8?B?Nk5wV2Q4Z0JnaTFMOU02TEV1OGxjUUVlZUtJTUJTR3VnWmlTcWltSEdvMFhv?=
 =?utf-8?B?aWRMWUhRaENXS3M1TitlUDhMcFNjUGIwL0lWYVdDc3JrZUYwVnUxWFA4ZTd2?=
 =?utf-8?B?dWl2bGVzamZoclBJSjFud0greFdubnhkNC9JWGlhUVM2WHV3S2ZxSW95TmVn?=
 =?utf-8?B?Z0M1akl2SWlrMmcxLzVyYlFtSnF3dDBvSmNTSUNYZmx0NGJ0c3ZCdXBuY2F1?=
 =?utf-8?B?a0g4OEh1dlFEV29FUGNaZUVCN0lHWmxCTGU5VnhyamRVOWN4ZkpjVFQyY3hH?=
 =?utf-8?B?eHgxZE1MckMrSmRIWFp5b0NIQ1RnWjc4US8vVHNrNEVvQVYxVG4vaDhMVVJ2?=
 =?utf-8?B?MVBGVDRKMmJEbThkVlg0Uzc2MWRucTRTa3RTN1NZM0x3TnUzaDZnbnQ2QXBq?=
 =?utf-8?B?NFdLSWQxcmI1WWxjbVdJNmpFNkFkOWZLTXFZUFVGWlA3SUgvNHJZNWR1cVdI?=
 =?utf-8?B?VmlNK0NMTUNZc3NpWm1tQ1ZlUkMzdXBFdW9lTitnZEwzR0k0UTIvelJDbUgv?=
 =?utf-8?B?MWRSK0dtNGdRQkpyM082OVBxT2dTTlZXQm82a0JmOWplZWxBNUFqQ0JWanZW?=
 =?utf-8?B?NTZvRUo3STJYMkF5QVhwRUU5RVh2aXZtc1ArbGxzS0tlSUIyY3UwSngvQ081?=
 =?utf-8?B?N0ZmM240cVFPaTZqNEpoeW01clF5NllKQ0prY3RLR1JnYlFLNVE0d0M0YUxl?=
 =?utf-8?B?a1ZvUll2RkFBVlFPS21TOEdzaExUVGUyTjhyREc0WUhEYmMvZEt3dForSFpE?=
 =?utf-8?B?VDVlNzkwRFp5aDVpRFFzeGFsUS95aVJRNnRlVkx4WWgvK3k0QlFZTGxtZVor?=
 =?utf-8?Q?8MguuNFwDZ3nV/8pPDPV5rIbg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5978a85-ded8-424b-ccec-08de1c2fd1b2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 05:54:44.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DHdOHdAeoDTQWJKM7Z2vLgjOG3YImvE8JQAYD1Crl1B9AkOClymgdU+/mLOQC4U3I8uir2RbAcvwQpWWGfk1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8002

Add basic functions support for i.MX95 ISI.

The ISI in i.MX95 supports eight channels and interface up to 4 pixel
link sources to obtain the image data for processing in its pipelines.

Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
---
Changes in v3:
- Remove "else" block since each variant already constrain the interrupts in its if-then block.
- Update commit message in patch 3.
- Link to v2: https://lore.kernel.org/r/20251104-isi_imx95-v2-0-c05b7cb104cd@nxp.com

Changes in v2:
- Change maxItems to minItems for the fsl,imx95-isi conditional block.
- Add minItems for the fsl,imx8mp-isi conditional block.
- Add "else" block to keep the same restriction for existed compatible string.
- Update commit message in patch 2.
- Remove gasket callbacks since icc driver still under development and ISI
  could work well without QoS setting when system loading is normal(no buffer overflow).
- Rebased on latest media/next.
- Link to v1: https://lore.kernel.org/r/20251024-isi_imx95-v1-0-3ad1af7c3d61@nxp.com

---
Guoniu Zhou (3):
      media: dt-bindings: nxp,imx8-isi: Add i.MX95 ISI compatible string
      media: nxp: imx8-isi: Keep the default value for BLANK_PXL field
      media: nxp: imx8-isi: Add ISI support for i.MX95

 .../devicetree/bindings/media/nxp,imx8-isi.yaml    | 27 +++++++++++++++++++++-
 .../media/platform/nxp/imx8-isi/imx8-isi-core.c    | 12 ++++++++++
 .../media/platform/nxp/imx8-isi/imx8-isi-core.h    |  1 +
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c  |  6 ++---
 4 files changed, 41 insertions(+), 5 deletions(-)
---
base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
change-id: 20250915-isi_imx95-1e3163fde962

Best regards,
-- 
Guoniu Zhou <guoniu.zhou@nxp.com>


