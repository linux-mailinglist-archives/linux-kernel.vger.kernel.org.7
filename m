Return-Path: <linux-kernel+bounces-782222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B2B31CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BE6587D74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B597031352B;
	Fri, 22 Aug 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QNX/QUZ+"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98660312813;
	Fri, 22 Aug 2025 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874222; cv=fail; b=pr+YnM2cOw9Oxp2gRw9ABWNB+Je1LFp+F4M0bprUuFL9N8brh/Bquql/eHEMuqNYmDtpg5yP/eRIBQAA0icirhbB/elmhzxOMqkD3w6Of+rNvFyyl1apzUguayj9uJhe5oelprwGBzEEG2+WmHa6yen0ly73dT/ssvpMNjZ2ItM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874222; c=relaxed/simple;
	bh=4xYyKmqOTb/zDgc2xjVS8gWxDRzXcWtGplxTIjYX8pQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ToU5T4BOwyQD7CUoNOI7M6Ui63euqHRGcuym10eKuPcRH3bVqM/bsGpDt3n1ToCE50S29kmDfoTgyuUX9TjwtdlbjlE7sErcbcajd+W1V9bskNN/KIbNvWHrZI/Tkh4V3FOBBmX3cZ908i5ig12KXlHRkquohAOflJ8zss+b3/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QNX/QUZ+; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvqcrLICYliWO/WHonNr9J2VcsiWQ+m34eQAR3L7mU1ymST5J2OwcDaOTbhcmxFL1WD/GV62a6Xoe4zN8LlEPX2560E1p/jQqnWp2VeYwkYEXrRRHJbexJBwdXC9ls9lcoyJ0ypF3DYlWXDJTYQuMGEnFLfZ1JWe+G5sqkudZLg0g3CMjunIvDN90ocTB10NJDKSYmvKqCm+7ayWBEhpoHrCuLRfuB6O3DC6lifX9S89W94FsB9gkP8xnLzC6j/mz0IRNlHMoN76ly/XEknQORagO6T4l2V0U/+89qDMuas4rBCLFOP23MwTNnVRAqsgcfTUcJewxcttAmFJabZi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4fhU+1byf/RWNiESEBEV5aV/31RVbgMgsgTXpjHiY0=;
 b=k0Qm+NLEDr1B2TX9ddV5zcN4TqntCHJLnKg28jkaM+sS/Aeijft3oTURX+7LRK3TjCsaKW79e3vz+n/veWMXWnTTCq+HbgImYJD4eN0SFjXaoh2FeIt5BHeFwAEGAX2K0hngSCYM2D+IHOHGlugAFMOcOojBJuuKquS3XELJxnhtEs8tlrNZdr+GFOCeBkSGdP/M+15RtMVbzuesN65nH3Alyhe6FzvuByFqH1HxaXYGZh5gRC4UhA6ue03aRNZuQtJQwe2aG9GIQ0AwM9oJ/5lzQODaZP1H+q23jNoHKYk1+gB1kTPNX+wKfN5hHY5Cthozg4A4mBPPd2fGBouY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4fhU+1byf/RWNiESEBEV5aV/31RVbgMgsgTXpjHiY0=;
 b=QNX/QUZ++9Jknfyekus1YiQIpBv16MnvZAztLFp9buRqgOe5vYCmGFBtGqLkD0PzqxUQxSwKVrBxkpqn4LJxsrhng8QSR1skXfaVRmMGm4RUS8je7Z5esv0eEfmW07dG2cp759FI75EjE8Mx872tMHa7TGTWo8hsjxowxf81N3JZoz+X4r7EH9nG0T2TxB016JDdJtvYsGw+l4HvGLgExaNBFLH0mH/h+JbwzYkjxzAJelfPc65aKtnpssVMKs3FLHnQYheCQo9KDxCEg6vK+X5Dilve0gin1/A21746OIghvvRIB42GGYcNu+WweoskQdSS7TxY0osHEuwPtGf5AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB9086.eurprd04.prod.outlook.com (2603:10a6:150:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 14:50:17 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 14:50:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 22 Aug 2025 10:49:59 -0400
Subject: [PATCH v3 2/4] ARM: dts: ls1021a: Rename 'mdio-mux-emi1' to
 'mdio-mux@54'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-ls1021a_dts_warning-v3-2-6b611a2f23a4@nxp.com>
References: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
In-Reply-To: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755874209; l=1159;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4xYyKmqOTb/zDgc2xjVS8gWxDRzXcWtGplxTIjYX8pQ=;
 b=q/V2h72QA+ZkqEu4ukpjmyGvR0VyrSbcQgOEhoMWXIw3pRxyv/pbjbxlGke2nBNkqpemclw+t
 gKdt4Amell8ANroLkvVu3TJJ/cGG6L/Fqj7+zVTp+IW+aj1NyfXLsU3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 38552bf3-2f17-4487-5ab6-08dde18b35ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmFGR20yaVJYMDRHdHFmd2JYNVpubXJTNy9ZU2xLaFR4MXdjV0dobzNoVita?=
 =?utf-8?B?RnRNckM5djJCR3BUYzU5T2lFZTVZa3FmeFY4V2NqaVYzSWVBd2xoZnJPYVBK?=
 =?utf-8?B?MUh3RWZzT1lZU08xbmhSaWtnUHpENjV3bFNOdlNaOVN5R05DZ2lSSEhjMVFM?=
 =?utf-8?B?TmlwMkYwSDMvNHBHUVFxWFQxSzlQdmw1bXJhQnQyZXQ4cjZLclNNbUJnWkVv?=
 =?utf-8?B?bmF6TFBlMEl3RkliVCtpUm92eXp5bWZrMjY2SXA1VkpkUHdTaFZld3hkS0hH?=
 =?utf-8?B?YW9OUkpkUEI5a0lYNmlWemI1bXdPdmtrQmFyYnpWNjBvMzV4d28yTW1oVlJJ?=
 =?utf-8?B?VEVmcGJwMUZIbWJiRzhteUZXTFpYbE5aTGN1a3pEVHYwbCtwTUplTVVMVWFu?=
 =?utf-8?B?WEg3eldoaXZkamU2N29RVXhVUW1iT3lWeHBCc2RQYndiTG1mdlYwNWFETkE2?=
 =?utf-8?B?WUtiWURETHJKRE95RHFtaUNMWGhGREtsZHdFVXFMSzQ0Z2FnTGZDdzN5WGxT?=
 =?utf-8?B?dndhYlg3ZTJnSENRYUtrUy9mc3hyQXdYZXJDc21FVW1tUVBpUzI4M2dxRFo1?=
 =?utf-8?B?WGw1Tk1FUWdLNkRFUUJuL0ErRjE0ekZTdFFtMEJnR3kyWDg1YzhuRU5MUjJN?=
 =?utf-8?B?WjBhRjA0UHpNUVFCRUEwVHlQSTVEczg3cFVQa28rbmJWZXlwZGpLWkp6WHlo?=
 =?utf-8?B?T3JKNUxrL1phQ2NGYVZvVWxwU053bHB2bXZtWkpUNUczOW1yTnFtWU1kY0Vm?=
 =?utf-8?B?MXZvT0NOVXAzYlpBYXVMaGk0NThjbzJmSkpaa1piL2hWL3FvbitXSVZLVTRM?=
 =?utf-8?B?akRYMnQ3WkhZVHU3aXJWcUFBS0xpamFzWm1Kb0R5RFF1dFlqVUtSQklVWldt?=
 =?utf-8?B?MzlrNmtWeDYzL09LSmNEYk1Qc0ZhbVJGTnRpSVdMRmNiTHBqaFpaRUFqcE1W?=
 =?utf-8?B?aU9qamZMT1ErTzRzUU9UMjdUMUt1MUVITjJrbjloWmIvdThFZEViK0g1a3ZR?=
 =?utf-8?B?UmRodUhqU0EvUzJkSUk5N1FadlV2OE5vUUcra2JhZm5KTlJBNFlOZnhOQnE3?=
 =?utf-8?B?Q09EaFhaMjhTOVgyQVNPZ2xzaEJ2NTNHNXFDYmd3RklZUmRmQUpML1NBMmk5?=
 =?utf-8?B?emkwNHBBb2dGZE1KQ3hxU254endYVHc4d1kydHM4ZFloRm8zVCs4RUExV0FM?=
 =?utf-8?B?QjhTK1Fsb2hVVXgyWjBjUS92aGwrOWdTMmliQUtpMUI5ZXNxNUpNSklZdGFR?=
 =?utf-8?B?MVhBOUpFL3hXelpvMTdsVXNaOU5yODhldmNsd3RTcGNuRVk2LzBiYmoycDRz?=
 =?utf-8?B?cGFvaEZkZjhTNGt4b2dnc1lxOUw5QXcxQllZUGlhMzBtK0VJMlRQeEZhM3hw?=
 =?utf-8?B?T3VNN2cxM3JhbG1XcXhWRWJvays5MXdzeHZua3VLelFGa1dobmVqSEJVUDU1?=
 =?utf-8?B?ZXM2YkRQUG54Mm9EYmxzYmdnWmUvMklyeFA0bmRib0NzNXpPbjMyTEN0SlVE?=
 =?utf-8?B?K1BIWnZmbmZSU1FQRWZLQTFjb09NUkx2WG5MZ2Qyalp1b1dMZ0V0RHZMZnR4?=
 =?utf-8?B?TjcwSS91NU03ZHZKZmpLM3I4SGxOR0hoeWd3ZS90RGxPWHI2cW84elgzZnUr?=
 =?utf-8?B?RVRsQ1hiQzBhd29wd1RWVStzM2NGb3NtWmt5ZCtydjBXQ0NiaHZzb3lxcWxm?=
 =?utf-8?B?MlhqWVh5bnRSRnROV1FIOWU1Z3BBZGJUbHdpUUNqcXV5YWFJZHdqMHBHOEJ3?=
 =?utf-8?B?YURzTm52bUFuMmloNmJpUlVLNWdjQ0huK2JoQjJPR0JmQmVuT291eURYYnNk?=
 =?utf-8?B?SzB3dEJUcTJyUk5UdWNZMGxkSVZBS2pQWEFlcnFSWkZYR2d5MUx3RTM3RXBt?=
 =?utf-8?B?WTkxSytjb1FlM0hDbVpISk9aRkRNQVRldmpsOWtyNTJENWd0K2xlYisxN3Y4?=
 =?utf-8?B?UlRKOGhlS3VWdEIrSllpSXFzanpYM0R5SVpwcWg3T0NSRUlzRnVQblVuaGZq?=
 =?utf-8?B?czNWbmlVTXd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NStBZ0dsV3k5clpWSDJPQkVMZGRWWUtRMHB4b1g5TDc1Qk5hS3RoR3RFRThC?=
 =?utf-8?B?WjNMZjFLWWZaVFFyYW12N3RCRkdjcEhhZ2NCMjRDemR0WUMxd3ROUHNNNU8w?=
 =?utf-8?B?ajc5TjlmR2VJNU5KWUpINUY0VEp6ZkRpTVZCSXp4SXQvZElDSlA5bjQ0UTEy?=
 =?utf-8?B?R2Yva3NZbU9iWVUrbFlMc3duWW9wVGYxMkZIVmZUMEFVVWpEcVpIemR4bEhM?=
 =?utf-8?B?eGkvZUtZSmtYbFVYc09zWlJxSlJYUEVjOEd5aVZZS1IxTlQvcFk3bG4raGE5?=
 =?utf-8?B?dHFHOGczL1pjRnpXdlZTUmRMb2Z4S1Q2K0JZZHdPWWpQS2tMY1hHb0EzNWVh?=
 =?utf-8?B?RExVZkdHWGV2a0hjNGNoRzk0RGFHblhhL2NqZGZCOTQwSDcvZld2QlJoa1Ux?=
 =?utf-8?B?MHVvSDhJV045bk56Q29DSGo4MmFnR2RvU2taMUlXVVlCcHV5WERFTFZSaWpI?=
 =?utf-8?B?ZnZ6NlNidWxIMk5qSnU0Z2p1WTErdk9zb0VkNjZOYlJ2c25UUktyeXNVUFQ1?=
 =?utf-8?B?VUFvV09JN0crUURIMFlNVFUyZ3QrMVFIL0UrbEJrU1VFZFkzRVFZNjMvYm53?=
 =?utf-8?B?cERuQ2puZzdmZGV1S3VpeDBJWjZhK1dRTzc1cWdkZHQ5aXUxOFNTc1hXd0Vr?=
 =?utf-8?B?T01PbnNucGVETUdOc3hnOUhDUFJxb1NDVDZJaTlpSjFVZ2gzREl1a0pONmFR?=
 =?utf-8?B?NWswL3RlOUxId0JMZFkvZklhcGpHQ0FFWFgwY2VGWms3bUJXaHVTNm0zUUVI?=
 =?utf-8?B?c2NPdEhrMzZxMDhOeFFzYXBwa1lpZzJqR1VOYStXR1ZoVkwvZXhKTlY2MERO?=
 =?utf-8?B?Q09HdmFaZmY0VUdMZzhIb3ZvWkZiN0paajBOWFJtVlFtZXNQZWN5S0taZHR0?=
 =?utf-8?B?blJQMnJZUWxvUWt2Mnd1ZUgrRGlBSjdsMlR3K0ljSGhvMCt1WWltMzQ1bGRJ?=
 =?utf-8?B?RG5vY014SFNZc0FnMzNMS2czV25SWGN3L3JtaTNxOE5zd3liNmM1dXNHSlM0?=
 =?utf-8?B?cXBwSUI3OGdtVEJTZWh4QWdDN0JqRzlDajR4U1BQblVZcVNUUzZzZk9aVDZi?=
 =?utf-8?B?dkd3d2VyN3hhcUt6aytGZ2djTHhnU09ieFZSWVl4djcybWNYeHdySGNaNEV1?=
 =?utf-8?B?dHhsUTVjR0RmWXpGTldMcEdKQkN4VG5md0g0OGFMVG5vZ0t6VkpJWTRtdmlF?=
 =?utf-8?B?cnBRc0kzNjRrMHpFVHI2a0hFUjd1RDVTQit0Sm1CMEgvdlFNMmZZeDBLUmg2?=
 =?utf-8?B?RC9sSEM0SktpVytlaE9CTHFXb0NCWFZrbllTbmJMcUhLN3h3ejZpNUtYYUtx?=
 =?utf-8?B?Sjl6V2FHemJYRHdXaDRNZW5sd3RWVk1NZzROUjAxbUh5KzVjY09VWHZYYVY2?=
 =?utf-8?B?MjJPaTNmWTJqeS9QYXNXUlBqVzRTeWdsNGFZeG5ySW9lUC9MaEJUVGtJOUVW?=
 =?utf-8?B?VzVVNjdHQVp6RjR4K1FYUnExV1dMS3NKb3MvTUMxblQyZVBtekpMeGFSQ2dG?=
 =?utf-8?B?UUYzSWVPR095YTByUGI0bk1BbnZWZlhLb2cyRFNDUFpRSEc2OGlUTW1nSEpQ?=
 =?utf-8?B?cmFMeWpUT0ErZkhsN3pXUy90bWJqT2N4dVMzaXhmRlpHNi9lUVVVUWJ4MWpn?=
 =?utf-8?B?UjRBaVBRamQwZ3dyYVovM01SaXVOaDJSMzBBanV5aGZyUnI4cm9RQUJJUFcw?=
 =?utf-8?B?eDYvNUNHK25BYkhtZWlKMEtnTENsRUF1R0RYNElWYnQ5ZVFFR3FldGtnZTlE?=
 =?utf-8?B?K2FiRFFEc1RQTzdyMGxtVHlpS0puNDk3NStXTTc3bndnRlZWbXNGQ1dlZStn?=
 =?utf-8?B?bFR4b05kaVpMSW0vY3RlQld5SGJMZDlFc01yVWVWUU9ZU1JWUmZETkp4NTJk?=
 =?utf-8?B?UFVMc0ZaaUhNRTMxR0lZQWZsYjRGOWEvaFppQWhUOGVGT3FxUEJKdmlxMDhZ?=
 =?utf-8?B?MS9FdzVtWjloOE9qYWNVK1A5VWtEeDlYdUNadEZoOXhvbEJvcmdob20rYmFt?=
 =?utf-8?B?OURqcmsvR1lUMExBKzRod3JTMTI3TDZxOS9GVGJ0UWVad3VVUjRkWjZvMmNm?=
 =?utf-8?B?MXFPMlZnUURsbUMxdDJKTW14aUxPbFNSNnZrenZUbkt5RE5jMnFReitsKzFJ?=
 =?utf-8?Q?j8Ms=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38552bf3-2f17-4487-5ab6-08dde18b35ad
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:50:17.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ijkPxjx+F+uMfw/mvvyt5xYCmd6fOPwkXpW68UbhhUVxWqId8Ox70LmdcNZgHMF+9pSmGFYdBMtgrF5bnYHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9086

Rename 'mdio-mux-emi1' to 'mdio-mux@54'.

Add fallback compatible string mdio-mux.

Fix below warning:
  arch/arm/boot/dts/nxp/ls/ls1021a-qds.dtb: memory-controller@1530000 (fsl,ifc): board-control@3,0: 'oneOf' conditional failed, one must be fixed:
        'bank-width', 'device-width', 'mdio-mux-emi1' do not match any of the regexes: '^mdio-mux@[a-f0-9,]+$', 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
index 8bc8ff2e3b03d6eeb43d79fe0555842536ab735c..a880875ced83e10c37a4d49d9b9951cd3d458ff0 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
@@ -211,8 +211,8 @@ fpga: board-control@3,0 {
 		device-width = <1>;
 		ranges = <0 3 0 0x100>;
 
-		mdio-mux-emi1 {
-			compatible = "mdio-mux-mmioreg";
+		mdio-mux@54 {
+			compatible = "mdio-mux-mmioreg", "mdio-mux";
 			mdio-parent-bus = <&mdio0>;
 			#address-cells = <1>;
 			#size-cells = <0>;

-- 
2.34.1


