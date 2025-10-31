Return-Path: <linux-kernel+bounces-880254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181E7C253BE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1CC3BCF50
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01B34B42E;
	Fri, 31 Oct 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="btE3Fhfp"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613134A3CA;
	Fri, 31 Oct 2025 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916796; cv=fail; b=Nhdf+AzqMJNMXB1uoDLVPCV1BfOtxZXImtzM5A1Q8zd2I/n+iu67EbAGmhtJ+8iHzsRzl7r7cub0Fojm/txWdtrSLKg0NAWogpt/BhRqIce4gfcKAeIzVqKHGXyL9VHXlhfl53Ss7klW9qIs50SQxpLaBL8RANdr8y94415ybUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916796; c=relaxed/simple;
	bh=C69AUB1P2Wl54RiurWINqadsMX6kUfr/l0O0lJyJh78=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Agd2VIn8UxmcRO5BJ88gBnQoqTTdagmYWGAXyLr5YZiTA2eR2RFNU9bIGBYpCadP9vl7pcIwiRb80nSC/b4RvvZMqzFHlqOxqrCmVr9TbfnJOOAZ5fySy9FY34j5kW1Ax25utR+T2oV9fiYbOS12CEZN+/fa6LOFscpwnmC/r5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=btE3Fhfp; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHoO2vyczE8QflpFipqbe3UxfZvrt4VIF6taZ37wnutsiN5lochA3D6AvwZb3O3I5xQ3QMXamrV5iKWm23sx8UCIX4nsofMrCMX0yNg0wI5q9gZAwzEPCNeg67LSEEJsmK+5f04kgkEQXz/YWspYae+n4xd3vUtoVTWDuyUecljy7shJ5JTIPJtntIongu+Ng++vpef/SJKTcfQ9bmJNGTmWfE5BCewRnupLykm8sOfVSICa2nF+kaUBRGYYRrDYHkoAgrNfOjDNW4gjSfOYQ9u05WCutwoc7zK+4YA/SgH3631okpVqLYbN01HZ6Y6RlTcqjBpt6jEkV2bj6q4FLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfSnsk7Y6zM7v2jwur2p5WX3mTZnBpwGwCbkTORdY34=;
 b=EDJyW257lsAURODl2UGrSc9mMlRfuqazPl9TgmQSFieM7FY6Ho9MHJA0oSFjZhlrFMGqwe7RTHzld4Jalmpj4qz814h2HHhVNEI7/v1tPZwvSeQ9emnC9hfzmHQ/KieJKYZXUyuhaNSmO17mhky08C9fXJA4St0KMHvP4MxUxWoY5Nnyl0xlM+05+BCKexf5/tdg6J7hY8ZLlMokFiJQn0rIUvswdSPQdEHunlXKpBPs5VVsyQhQXDVy4QX528lCOOZ4PnbH7H9phkdlZdUBUaX7FozRT+ohyuSg1JbEGT7SpM3TQw0vFPFG0lj+/3MjNDtJjtkrw7z98PtVIX0bHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfSnsk7Y6zM7v2jwur2p5WX3mTZnBpwGwCbkTORdY34=;
 b=btE3FhfprK+UZJikrZTVTfRMkFWRHv2StgwpXaTQiGYToD0GEvGkejvD8V5aDjsoFYHL5nSAn9gv/puIzGT5KKvpaaD5YjTAUNcAhYr816EpcZEStSUJaMQ+qnPtzkQH26N25zMRnope7MP027Do9FsRxayovMYTpMHJSVIkl8JPXH1KeRcDXHIweDVfvK2yOcz6CvvlOb91T6zMo8lFQNrxFEFsqtT0jjGBelyZNHVFkLmjS/3hf3OxNPgTZYLvXlP9TpCSLtc2R3qDXQrdmQUEuQGHaWwkSL6jbAiXdt2RFAXIKyQO4Wb0qrFK6PP6YBaRtRn1ykbLKHjlXuujEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by IA1PR03MB8310.namprd03.prod.outlook.com (2603:10b6:208:5b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 13:19:51 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 13:19:51 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v2 0/2] Add support for Agilex5 SoCFPGA 013b board
Date: Fri, 31 Oct 2025 21:17:37 +0800
Message-Id: <20251031131739.914012-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:820:c::13) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|IA1PR03MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2f4feb-b921-4c17-2458-08de18802c5d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4S1h4LbR4ZSfxPZDz0us7YpbM8Vmg4dOXg3aX9Km2RUmaXWbqncGw0MWXICb?=
 =?us-ascii?Q?4ARg2TfssjderEFRaTT55OrzT4P2kTWCyQraO5XP8kpDMfCGlpGv5OCPCUwX?=
 =?us-ascii?Q?X7SzFXhy8V3g9LGFddxTb+7MpM2kyDYgx3QzBgo3UTtOahclYBhMAxclGzG7?=
 =?us-ascii?Q?fkikfOHNDaZ7zxeQ0D7YKZBsFcx0RTdBMPxtWxz/EYjkoWcTg7lQt0FoYwps?=
 =?us-ascii?Q?g5istbUipofNXi7Wvxhgq+kAfTNFTKeCNemHVMy1tg05H0uuF+v+4VDfhLah?=
 =?us-ascii?Q?mvkZlqJJguveeLyGuQHYqKsktiQP2zr1wff2bJxsv6l5syQDJyQZemyGshBY?=
 =?us-ascii?Q?5afSStZHEwYJQLc81AGUMFzb5U9oPIhnj2AyILyoCOGlG3iBg2Kw95pwqK6Q?=
 =?us-ascii?Q?hQZQ35z4vNCFNm5IKyeg7OiZkO/qay9d1/l2OEN6xWXVhoP94RKooxOUrbQ8?=
 =?us-ascii?Q?bVfzXO6AuzZaQEVcwZ/5o8fi8wSEvUBoVIflraJwaE+Wuhvgys2L/VCGPETr?=
 =?us-ascii?Q?QSaDcyZRGHCF+LZ41t2kqG/MpEz8LzH+7Hz6Zam+jsiPWlSeGXXfUviOcc97?=
 =?us-ascii?Q?iz88tWwC4jym7gxpVp5pk9SjFE7l0eHhu5Pq83jb8hnA2E3UQBDKIQZZrt4C?=
 =?us-ascii?Q?IX/544CkHTltdTAIOHjNI232bW7QMg83ILMayn9UOg0ROLW7qhFkw943tRzZ?=
 =?us-ascii?Q?PEdI0m568y+w+7mOr+EXyHjxSS6z7nuyQowsUyGY2hDM4FcB2R9pkwFUfta1?=
 =?us-ascii?Q?uhQRawb9y2RKeV7SbO9bQFRMfaltqc3IpM5Y2fxJ9nHIoEQ1hL/l7I3cLS7Q?=
 =?us-ascii?Q?uw23nE1I40yjHC2p4KoG7DwGzmt8luhcEeADRPHpLtHBSZyDgCYGCeKsGRZl?=
 =?us-ascii?Q?L56JPEvIJ8ucLubQO67UUEHdk+WhMpwXhZ6oSX3zlqCgt3ia51jnx8eYxJzM?=
 =?us-ascii?Q?Ojx2ImlnsSUGenennCUVQKtoM1YyojhhT5chxZNy2HiYL2jRhhydybA9a1rZ?=
 =?us-ascii?Q?bMbYGEHkRSrJyt8LnP/9CNIILkk2UpNPbu7OI831r9bO85Xcq5L/VQEnuh53?=
 =?us-ascii?Q?+m/yj0oT0qVQBtYBQzd566p34bkYEkpfq8NVQQeDSGE7d843tHmXKRYWQWqk?=
 =?us-ascii?Q?FpbbxEDISS5hNWBR89ow4Xj5Trc8WrkcDEYrXKMO3neojoJSQR/AlafRLjcm?=
 =?us-ascii?Q?MsYpWCUPhvIztzWcVqBqQ+2HkDpC+wAvQ5RG/S91jJJ6J/v2KzTxvso9yrk9?=
 =?us-ascii?Q?vqn02eadqr4aqmhrJWy6Vy0yPq1g8aF0D4LM3CLsQtTtAl4HIs7X9OG/KXt8?=
 =?us-ascii?Q?GDzEYYEQDh90lOKx67kIoVl9nJN/t21ZS9/nXGnYRHB91x5IhTLpRd2n3pHr?=
 =?us-ascii?Q?1vbvDpPJxqIad4Ows/aIjfJsvBqoP5A9i3xSbr1FPSU+OowerA9o8P/JM+bl?=
 =?us-ascii?Q?KSpaCk7CugS3diKFiRPx/KCljyGTxuPcIvMtDIMS2ypDil7rMqBzSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l4lwjGXAVPpDfv5jpZdyNCae8AUsXDGA+ku7XQUiJyXaAHoD4Y4Wvw6djkb2?=
 =?us-ascii?Q?5yTRfQ1VUOhlQ3Ue1BQJ7HrfYiScLuoab0f6keu57Wwg7u6sgPMvv+goBjGK?=
 =?us-ascii?Q?JbPJSnyD0bLRrDvC/UgdJFXsJEwGgEsS7iGNZp/t0tWiojdDUfzaz4DODpOf?=
 =?us-ascii?Q?MKPtruxYT95YuSDLQw1Hrlo97Wp5flWOCkc3E8w8DmpYI+/jEzj3R9PE7nCe?=
 =?us-ascii?Q?PRTp7WqYEdVRPdpY5DUPCeG1c2xO8aOHEZT6IlEZW5JXItkeQ/MNG7VNkfHK?=
 =?us-ascii?Q?vqP0UHWZDr2sqDoiNOu0VoWz5usGcER+2qYM+4y1lpuBY12ghEXu2M3NAKke?=
 =?us-ascii?Q?mEM838UyrDEMJUwLc0QWI/4k7rfXEA32qLVWkkh4l+YxW2D2lnVsWIiDpOhz?=
 =?us-ascii?Q?X0iVggD423Z5GGbNavtM66MifbdHv/0Y8xns54BWLYKN03U0jiqImmAJ7N+5?=
 =?us-ascii?Q?v1zK3LZC3PqKdIiRF1u4ICsxT8Mbu0D1rvqwbT4+ZTfI+ETvN/8ukMVBi4qi?=
 =?us-ascii?Q?HMSnCcv08DkDNoJAV3XiwSIy7UzhZoG8/BohQG88caJYJHxaGaDjVPqonD3Q?=
 =?us-ascii?Q?MyqLxmZKSo62zTz93jOcEZX8Lmhhj7BpPffb3JwIfdhibt2M1eWo6SdtpWDg?=
 =?us-ascii?Q?X1oUfsxqmD+izjiWmnUPLbw29VlEzKhPiYmC7tgIqTa2FWIbYCDWzBCybN++?=
 =?us-ascii?Q?/j0EI6TzKwIbVlIr3yCaepOYmtkhhJslAV8/9snbfObfA2CZCi1ta2tHId/d?=
 =?us-ascii?Q?cjYRUYbsJgD4qNykl6bg1ZY7oSl3+JIlTAyeAEVqeb5BptOwxyrnH7wlsfgB?=
 =?us-ascii?Q?m7b8W7xMqjJKPFZuOj1U2kWkfcu6liuj8wE+h8adlUKqTwZxvjI8pDvS79ji?=
 =?us-ascii?Q?CEDGtsf+CYq9DSuak9B3EWiTuPBFS4uYAvcc5/zmXpUASUefz+z5Pb3dRj6G?=
 =?us-ascii?Q?qmFSav/h6OpmTKdyDlarSyqMe4AkCNaQ290J+2Ln9UGOl5H0+7iOPArRw68t?=
 =?us-ascii?Q?UQE4WKCYbcBi8UbQRbthrGS9CEpWwRnPu5kFc58RHf1+3BvHf6Nud2ojM078?=
 =?us-ascii?Q?yKQFhphXby1KSzGJ12zXRaz+IrjACo93ph/NOt4v1qyxt1JKOGUTDlXMIhq+?=
 =?us-ascii?Q?4mCWrJrJ5j16DykhW8T89bd43r5walNrEnmZ+uWJgdTMySlqkPR5HnNM4Aim?=
 =?us-ascii?Q?2LgM4jPOIStUMw7n4jsSbY+OW0v+yNM3HVNqjrypBZObiAwveBJrRRlGIS7q?=
 =?us-ascii?Q?WsQyee5hnv+azCmm+FgHPN4aSjRuFJ0uvbC6WxY3FwHOBAT7bwK6KGkYCNDm?=
 =?us-ascii?Q?dHZ6SkPSwCCfya4qx+RUzdQ7dOAlv8afWJnPdgilF0kZH9KEQMTwndwFR5L8?=
 =?us-ascii?Q?x+s8y/W0NTqd3qp61Nmm3e3z8TDpKgbpzlbUdUY2Dh6qT2yPQm5vwbwq5Wf4?=
 =?us-ascii?Q?OUkDWuUEilnEtR8a26pyr526wLFkb4MXHhjkgXqiAgyqgUZfya2z2Rs3jCaM?=
 =?us-ascii?Q?BkhQwymrIqnMtHcqHlj2u/AtsLvE6eL5iwk7FQnPcj6Ul41H+FUzhKTtXIJS?=
 =?us-ascii?Q?lysSYMVKYMjjoVJYzwQMOGJVEJo2MxAMm04quSCUp3tE58lYSPSaSUhR7K+H?=
 =?us-ascii?Q?/DetwDXa68NtjujJF01G8sA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2f4feb-b921-4c17-2458-08de18802c5d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:19:51.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YRpUidWXEtHhSKuloaJ647apKLgVsJIWCuPuETpLcqCap4KlQahbNcNtYhvHXHQGwSy9sphuqj6kdawxUk/mCIRgNYJCmRJyTSce7NMZMLAtbb40N9ybnAVrrz2MhGm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8310

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Agilex5 SoCFPGA 013b is a low cost and small form factor development kit
compared to other Agilex5 development kits.
It Supports both tabletop and PCIe add-in card operation. It features
expansion headers for Raspberry Pi 4/5 HATs and Digilent Pmod modules,
enabling integration with popular ecosystems.

https://www.altera.com/products/devkit/a1jui0000057q9nmau/agilex-5-fpga-e-series-013b-development-kit

* Patch 1 - Add compatible string for the new 013b board.
* Patch 2 - Add device tree for 013b board.

Note:
The patch 2 depends on the series: "Add iommu supports"
https://lore.kernel.org/all/cover.1760486497.git.khairul.anuar.romli@altera.com/

Patch series "Add iommu supports" is applied to socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

Changelog:
v1->v2:
* No change in DT bindings patch, retains Acked-by
* Add more description about 013b board in cover letter.
* Drop Agilex5 from commit header in DTS patch.
* Add more details about 013b board in commit message of DTS patch.

v1 patch link:
https://lore.kernel.org/all/20251031103117.910187-1-niravkumarlaxmidas.rabara@altera.com/

Niravkumar L Rabara (2):
  dt-bindings: intel: Add Agilex5 SoCFPGA 013b board
  arm64: dts: socfpga: agilex5: add support for 013b board

 .../bindings/arm/intel,socfpga.yaml           |   1 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../dts/intel/socfpga_agilex5_socdk_013b.dts  | 126 ++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts

-- 
2.25.1


