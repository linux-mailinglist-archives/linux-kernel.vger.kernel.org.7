Return-Path: <linux-kernel+bounces-878519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D4C20DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A55A3A9663
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F172B363376;
	Thu, 30 Oct 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lCBlTrVM";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lCBlTrVM"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022131.outbound.protection.outlook.com [52.101.66.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC7286405;
	Thu, 30 Oct 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.131
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837411; cv=fail; b=LLhH3UqLWYyZ05MSIzGRujedh6C+eUygKaQzwK5IUo0NKp3+HZlNRU0nqViB6DK1GbpmJUBjsdNXJR1CbV+4uk5yHGu2f6yU7MozQJbvpVH1VWFqaWOrlJgOStgtEuYI/cEhTMqbEDzuUkzJzOTxWqenjaBmjiobzGhxYxCYZio=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837411; c=relaxed/simple;
	bh=9LuLcUS8lDsUNWc6MNcIBU3YmgUEHCC4RMufZULwd7w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=hpO2y/CEH6C+JuMQKoITc0ThpznXlivDeI3FEN3skA7tnsYNWPBrRwiz+ZhIeZs5iBPSJWAWzgxZ1Nhm+5KOP1xsZK9u2Bqr1KC/ETIjJ5hnImjvqhMjx7XNLut4Co2P+xO+Dxel4rIRVo93PZVGO8D+UE6tTUaUvtQSJFOid4Y=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lCBlTrVM; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lCBlTrVM; arc=fail smtp.client-ip=52.101.66.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fyy89re58lJHdHXxPvVb2FBchF3sXg1K/P/4tt+r3UzdvJXCZRLYBlZtxpAUlNbE53M+zdMUFxiceXymUjmJ+UlRAYsSM1c7ribsRIA646+av6Iv4h/0kJDCPrP+i8yrgc/5d/45uiaCwwvr6cBbeMBOTmpZ6DmkUzljKxFNtfM0s01a6Xqh0UoUkUlZyE4lrnkh9lV1deKKSJXWOPfl2NdS/CSmD4XgBDrXEqS7Srg6VfNvEfZKzOSgbvqo0oRhNJovN98g2BPnFSt+m27AUd0xmZeHK5BuudeRlSUljpn67f9UTMYqz2Yo6dtLAhWyQW31oYM5UIssBbkJq9VH3w==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kMfumQsZkXq3EszHbr/pbX0MvWNPrW7GDKwf6idmGk=;
 b=sr6WRvGWotWXxAmMmBcE88aw/Rwv94xuq9IMcDsoTqu9nz5k0jTTX9MONJi6FKDArgxQZEMLxWuNjMp2GWdtJBXTFU6kwN0ofQ9M5f4qG6mXQSTp+DFd5tItGrbVA5OoOietF54PJJTMresW736VSJUl3CzasGdRdFAlarRymUCUbUKvhH9HSNs3YktabMQJy5KOTwoZ9aDf+tMLGAcSAsFTad+b0HV4d5PAFZ4VP3HZlVnIz8xp+KEtre5H62l9SiH9aHgqnkHCzTG2VY4EnWySS4hjDhuiP5bi2TbTjpLWsv5f6OKufrWwNUe+XOACQIHRORkhQOICxwE/4YImhQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kMfumQsZkXq3EszHbr/pbX0MvWNPrW7GDKwf6idmGk=;
 b=lCBlTrVM+hZTDH/ZWb7z7NjJ+ewoZ4yF7SRUNk4XdJXQzxMuqoClRNChzlbUxOrZ4mGZQ13qENBTnIAtzFaVe3RML//G0wvCek/3yQji3Oox2eHQwDJ7YEUhHEf82Sp6UoZa9lN1+aX3bwFhVM0TJIUIxkXx3Peh032n8NhiFNs=
Received: from DU7PR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::22) by AS8PR04MB8467.eurprd04.prod.outlook.com
 (2603:10a6:20b:34a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 15:16:46 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::21) by DU7PR01CA0026.outlook.office365.com
 (2603:10a6:10:50e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 15:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 15:16:45 +0000
Received: from emails-1846786-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-148.eu-west-1.compute.internal [10.20.6.148])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 96404806BE;
	Thu, 30 Oct 2025 15:16:45 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1761837405; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=+kMfumQsZkXq3EszHbr/pbX0MvWNPrW7GDKwf6idmGk=;
 b=NIs0XJZty5thYdqODnJ/itmWFl9eMyVfev+2PPoUl8Rf0qtKc5RwDnO7L7PBBQO7/1E0A
 zudpLH5M1NzhLp5ZpLyGG3lG8Y/aWe94QbZYi50RtWdN0ymkTvTZE5va0DHfL4dFXLPefp/
 FjabUqS/Z4VRDM3+2IChsiUx7gYPi9o=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1761837405;
 b=kiZ6dV/9RDAq/wKUyTmQ7YX1cwprgyGTSa1YpcDq5HAP8WuAgr5n3duT2ECkwS0s7jBqt
 fFIT163xYBg4Z7VtQCn6nva9ovVoJZY7mHG+vYrU2UslSsji1NhCBEZmBAnDldeyWWlR/u5
 8n70k4Czu+2pAVx5R4se1ooHacRSsjs=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFO6s5t1MRsV5tExNaWZqgd1OVH3mwHUtYvGh/4EA5Clxvx4AH5Qt80Ly5bVK9qSTbtIv9LqarB1FxmdjBnw4lZQW9b9KIo765tRF+TAfmMLA2g8BAxzZgityspIz9f0nIPYkD+ozpXVWspPdyRLSqUVVmJVWBiijJ6u4mIcD4jvddeczpW3hLwwpVrW01oNF4/UXTEZEGKtXVT0+RySHrDviBfVyIrRoBXiQkUn1uzRl8hzXTby4HIfVMLR+1QsrVSzK3tWN4bl7ytHLvNuUbhKR0JUrwabzjy2N3cabZiFpzmy4ar40YWSOrsBZ19xvSY3jMxupMYRPRDuZwwA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kMfumQsZkXq3EszHbr/pbX0MvWNPrW7GDKwf6idmGk=;
 b=Fhzow1K4q1TLYFvXjyixan9sMSPjudHSaW5tDC1msr09ESa7lzzS/dL89AezH6bAgqLPjg9bYDBaV2mlD+H3egyTB5XfR80TPme92ogKrKV/wVt0qg56OEZ1EvvpdGL9UfGCEwfy+Cxos39qI4FDRpGtjViCx2cT5PIBWcNv8q3pNgphcv8gEqmufzAdUJZydw4NXEsv5KBBimczmAwzlvY152/cdTd6jCedMJFV5+/+IJVLCXoevKF7XFKK/5z837fjkwC8bQCS/Jrh6A4R9fowIt8uNlwcDl/7OGXbwhiIPqOwZ434FqbpbihQJ2LHU4yq2R+Zucp47mdZ5u5+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kMfumQsZkXq3EszHbr/pbX0MvWNPrW7GDKwf6idmGk=;
 b=lCBlTrVM+hZTDH/ZWb7z7NjJ+ewoZ4yF7SRUNk4XdJXQzxMuqoClRNChzlbUxOrZ4mGZQ13qENBTnIAtzFaVe3RML//G0wvCek/3yQji3Oox2eHQwDJ7YEUhHEf82Sp6UoZa9lN1+aX3bwFhVM0TJIUIxkXx3Peh032n8NhiFNs=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 15:16:34 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 15:16:34 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/2] clk: mvebu: cp110 add CLK_IGNORE_UNUSED to pcie_x10,
 pcie_x11 & pcie_x4
Date: Thu, 30 Oct 2025 16:16:24 +0100
Message-Id: <20251030-cn913x-pci-clk-v1-0-e034d5903df1@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEiBA2kC/x3MQQqAIBBA0avErBtwtAK7SrQoG2soTBQiiO6et
 HyL/x/InIQz9NUDiS/JcoYCqitw2xRWRlmKQSvdkjIKXbBkboxO0B070jzbqWvIeq+gRDGxl/s
 fDuP7fu2i7FpgAAAA
X-Change-ID: 20251030-cn913x-pci-clk-1bb9a6419ff0
To: Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB9280:EE_|DB3PEPF0000885D:EE_|AS8PR04MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e8a98a-a2e2-407c-b854-08de17c756fd
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?a1FUREF2VTBraFBoK3JmRTFLcFI5NjJxUk9sZks1eEJQOGVVdjNvc3BYMUdn?=
 =?utf-8?B?SXNYMTAvSzAvc2xOWThZTDFUY2ZuQW9NYXEvMVcydnoxbzVSbEQxVEhncTdJ?=
 =?utf-8?B?NjdkdnNpM2ttNnltaXlicm1xd3M0UFA5Sml1ZU1GMVN4SzVkM1ppVTBFUHdr?=
 =?utf-8?B?RlRsS1czSVlnbVV0NTI4Um16MU1vcURlUVN5TGc5bVFXVEJVOHJyOUUrZUx4?=
 =?utf-8?B?RE5LQzA2dFoxZ3BINnNDczUyQ1BabWNrOHNXWjNqN0Q5WGpOZ1ZwTnUxQUJ2?=
 =?utf-8?B?bnNKNGZnaUVlbnAwNGFMN1VRWGNUM0NVbmQ5RmtMK3A4b3ppa1BidFZaWHRF?=
 =?utf-8?B?SUlZYU14SUovV3pwbVl2MWErZW9PZ3FaenR3OHVsanpIUlZmcEpZL2xuVEZJ?=
 =?utf-8?B?YXpyTXBpVTBSdnptY1llRWZWZVl5YkpReVFKN1k2RjZKZml0K2JpdVphY0d2?=
 =?utf-8?B?MFcrMFo2SGV5Z2pONFZ0cDV4bFFNV1I5cVpCS3laSGh0YTEzNWJkUXdKbUpt?=
 =?utf-8?B?eGlkOXZ6cWlqek0rWmx1enp1dlUxbytXMG5mRW1YeS9UVFlITmtqTFYxYTFn?=
 =?utf-8?B?amV3NGw5blBYd1dtYyttRWEzemVaZ3lHQm9uSmdlWC9lOXRPbm4rYVFCVVBa?=
 =?utf-8?B?bk1HMlZPam5SdnhHeDBmOU9La2FUWFh4S3dlK3FCQzZKM3hnbnhESC9uOG9P?=
 =?utf-8?B?d2g0R25YclBtS2U5Ky9DazVIaTFScFpPYXREdlVBSXpwVXpJS0pNV3lJMVZq?=
 =?utf-8?B?bmtKQ2VneHVKZy8rdzBRS0dqd2JIYllRVWRUVEdGa2IxdC9QYWQyZDFtaDFt?=
 =?utf-8?B?dDRvVS9uNEJmZnN5MnpYZmU5MDF1ZURhMUUzdjBVQ1hSdU9na2duQm1yTmxR?=
 =?utf-8?B?aXY2QzhONmQrcEpxanVwTncvQ0RTQkRwa2l2c2JPTGFmU1JhbGVWMSszM3dD?=
 =?utf-8?B?RzdnR3BnUkRJWlRTZytBUFhEbmNKMHJYZDhYbkJ0Ymx6bVIyTCs2ZUVvQ3c2?=
 =?utf-8?B?RU01Um10d29taHBISmlpNlYrQXh4WEwwUUNRQmNpem54YzQ5YjFHcFhleDYy?=
 =?utf-8?B?SjJmUkxWRHFRSHZ6RlNCdmJGemE0STR3YTRrdjJYMnpXaVM4eGM1WlU4cHZF?=
 =?utf-8?B?ZXpwTEh1M09aWW5HOUtpUTlLSGwzQVRrMDlVQnNobW9EZVlTRWtWRUZTLzhL?=
 =?utf-8?B?V0Y0L0lNVmZoMWpmV0M5eEhYV1RYSTZDUmc5MXMwbkxieEJ4ZFBNRWp6Qjha?=
 =?utf-8?B?Y1FOTFlISDNlMk4rSkpnZ1JPMXVoVG1ubURkQTJLTENkQzVldnRIMDhNYkhl?=
 =?utf-8?B?d0cydHZDUkc0eVgxeVNkYXJCUytnT2hRV3RhRjIyQWpYZEV4UUh1MXZ6Mm1X?=
 =?utf-8?B?NzUzQUhQT2VFV0ZPdWQ5OHM3RnRvYmpUTk1VTzFucldTOEpHdUdYS0pqdDQy?=
 =?utf-8?B?Qi8wNURwOFB1d3ZQdUpkemZwWmpQWHBkcE9yTGpIZUNvaFlpTTZqWFJPV05a?=
 =?utf-8?B?U0R6elMySGE0aVhzR1M1OGFxb1Q5SGpSRTQ1MDd1WFdzd2lwM1ViN2Z4eUpo?=
 =?utf-8?B?NW5DWVAxRXJxSW9XSThTQ0hFc01GcUZLOFpONDU1ZUJFVVFyWE1sa2pDZFZ1?=
 =?utf-8?B?TjFQek9FUHBBUExoQmFrQ3JuYThOOU0rRDBrTEE0UHU2R2FiQ0tkUmhub2Q2?=
 =?utf-8?B?L0N4bHRuZGl2eXo4akRUVlNzNnVrS1lPWnNzMEROSCtPVGtVUWM1dzk2Wk1i?=
 =?utf-8?B?aFhBc2JSV3M5a2dmNHVyK0lmelBkRWZ5SjJoamkrc0RNbVAxcmlyaTZ2Y3R1?=
 =?utf-8?B?NUFnaGJtSGRiTHdnVFpncHU2bkdIeCtOdGs2Qm9TYW9wYU1Dd2FZaXdmbnB5?=
 =?utf-8?B?eHFwTzNURUxsWnoyVjlIMkdaT3dEdmpkVHZzWjNXc1ZLWUpIeWgvODhIdWoy?=
 =?utf-8?B?endpSWVtbDRCK1NIZms2S1l2OEJMcmtMY2RVWjNUMExEcG5IUWh3ZHFMNnN1?=
 =?utf-8?B?R3luWitMY0xPbVhtQVVHRFQ3dkpkY2p4aXRDd3JLcEVONmhJbGh3citLUEZ1?=
 =?utf-8?Q?OgYZjI?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 3d96c81537644a229a07b2f1381e20f5:solidrun,office365_emails,sent,inline:4dfface508d283f6e9253e75a0eee328
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1ef379f9-857c-45e0-d773-08de17c7500d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnZsK0ROVG1CQXkyU3V0a2F3TlJ0WWN5RUZlL3lNWjIwVkFaTFNVT2ovU1B6?=
 =?utf-8?B?QlE3T2hYWk16VjVGNWpCWHJncDhCMkx5SHVpVVFFZFQ4aHUzZHJVZjYxd2Jw?=
 =?utf-8?B?QjUwZVQ4clUxM2lrNEhmQ1VacjU5K2g5T0RJNU1SMGhQakFGN3ZZNmRPc2th?=
 =?utf-8?B?OUNhdWhWS1BwS21rUGpMQmozZlhRa1Z4M2xFKzBpM21CdUQ4R1k1OUFLRTdI?=
 =?utf-8?B?THplOW1wVkUvT0xGdEdWMEluM3Q0NGNIQzNKN0YyRWFMK1BJWDEwcDRUdHgz?=
 =?utf-8?B?a3JUZUIrVzJpK2MzcFhQYWZOc255NUZhaHZRNzdTbHhWN2VmcTV3NURsaG4z?=
 =?utf-8?B?ZlpCcEtxeTh1L3lGb1A5UGE2MHl6VXdjcStzYWRjeXdPYkt3cnN3aVdUeGNL?=
 =?utf-8?B?dXVSclhhN1MyYzZIYVV0alo4OVVVMTlYMDVsTjhnOEhWclpWZmFUWW1GbTR6?=
 =?utf-8?B?MENYYTdMVFI1TDhldDNoZ283OGtoTmhPSnljS2VFL0l5d3ZlRzhRTm4zMklI?=
 =?utf-8?B?TThKeEc2blN0RlBacnpVbWZ4bEdmVFh3djVLVk5EZ2w1b3JvbXFvamNJMFdG?=
 =?utf-8?B?am4xRlRUSWFkS3BFVnFHNzdnZlZ5S3BQcE9FRWs0OGlFUHg3cVRiUE9BbG5T?=
 =?utf-8?B?Und0YW05NURqZi9UMW5QY09JYWI5ZWRWSURoaFBDeGdpUlNaWS9jQ0kzbCty?=
 =?utf-8?B?WnBCVnZnMDg4cEQ5aWJpMFNvRi9IdkZvWUs2YnUzMUgvNkVGdVM1akVDdDhr?=
 =?utf-8?B?SUsvdGgzdUo1MWlPeWhHSkp1dDNBSkhtcEc2TFdxaU5ra2hYVUpOTy81bUdF?=
 =?utf-8?B?ZmhDSnBZUUQwdWFQWkVKZUdISnlBWWorRjdXbDBtN0lpMlFZU3JvUjZxS3lM?=
 =?utf-8?B?d1ppNWlFazhTVUl0Q1dUazF4OWdLNVFOemxFZTkwOEg0eU44N1ZacHN3UDh6?=
 =?utf-8?B?UkI5M01Ic0lsU2c5eVRlR1Z2QUhKUVh2WktYeU5zbGxMS1lGSW9hYllwZVRp?=
 =?utf-8?B?dFdhRk1UbTlqNXZDZGVFNWFSaHhsQXorcUVZdUZpNHNoU3pOMHVZOVNiZ3FF?=
 =?utf-8?B?bDUrZCtOcThmMVNMcmd6blZXTWlkN2JGU0hvcnBobEN4L0JXcFFrUllJbGVQ?=
 =?utf-8?B?aFdMM2NDSEZXcSttamJOMytWMXYvR2RadVpSM3ZuNkdEOW9YdG9wZGdCODlt?=
 =?utf-8?B?bjZ3a2FzOXd0UVQrRDVSN0tYUjE4VjJPejVvM2JaZkxhdDZGcGZFVWpuKzdR?=
 =?utf-8?B?cW53U0h2UUp5bDcvRVp6K3JJL3lKbkFRdDNGOXNBOWlncUY2K0FTOHhWR3JM?=
 =?utf-8?B?ay9lcEYxeDZZWndWWDdRTlpacy9xR04xSnRDWnR5a3M4UnRwOE9CNUYzbGtM?=
 =?utf-8?B?SW1Jd21oRlVEeHhoSm1FcWhCOE92TFBySTRURFJiOUlxSEVIWXUvRU1UaDgv?=
 =?utf-8?B?cTlnNXNtL2VQb0lyZnpaeGZlR0dqRG1JM1cvS1Z6anQ3QS8rVnZFRnNMNUs2?=
 =?utf-8?B?VE82eThDK2c1MzdGM0d6V0NpREtNU0pUQVFBM1pSRDB6SlBIMkZVMVAxeWtK?=
 =?utf-8?B?ZWRBVUtSOG80a2VTVWRKZnQzdTZGNk1xdGRqK2dDeTJ3YnhRM1d0NmNZTy90?=
 =?utf-8?B?K1dFR1NFRHJGTERRcGFSR2hzam04WDRpSG1lT2I4c3QwSkJXdzBqUFpOcVhS?=
 =?utf-8?B?cW1kQUZLVHVqT2FIc21McFB3dU9wRzl6T3ozSE02ZW05VGlOaUtqNXg5aFBj?=
 =?utf-8?B?RHVKVHZLdmpjQjBQS1RzaDVFVCtKMER1YUx2ZlhHMVFOZVJPbm1YdFRwSnNS?=
 =?utf-8?B?Z1RCYTZ3MEJkSFZMbk9LdnQyNDE1Ny9zbmlXVjNqMXg1MTR3L1Zxc0lMcHl2?=
 =?utf-8?B?dnlNTytVUUgrc1BPVDBISXVyUndrSHJzMisyUTVwVFhVZHhEenRDNEM5VDdL?=
 =?utf-8?B?alBwZGtuNlRGZ0J5R0dJdlhHYThUdUFvNk4rUGtHTFVLUXVnbTlqRHVaT0g2?=
 =?utf-8?B?WnhnTlp4TlFFRXlRcjlseGxSTlgyVHNDdmswemZxK3FzWjlTTGFuZDNtMDda?=
 =?utf-8?B?ckQzbFJCRlZwSWFwbktiUnRvdFdVaS9rZjY5YlJpdURtRlpBbGF4OEdHVjZY?=
 =?utf-8?Q?pFU8=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:16:45.8159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e8a98a-a2e2-407c-b854-08de17c756fd
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8467

This patch-set implements a fix for pci errors on armada cp11x based
platforms due to timing of clock driver, clock coreand pci controller
driver.

It further reverts an ineffective previous fix attempt in device-tree.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Josua Mayer (2):
      Revert "arm64: dts: marvell: cn9132-clearfog: fix multi-lane pci x2 and x4 ports"
      clk: mvebu: cp110 add CLK_IGNORE_UNUSED to pcie_x10, pcie_x11 & pcie_x4

 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts | 16 ++--------------
 drivers/clk/mvebu/cp110-system-controller.c     | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 14 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251030-cn913x-pci-clk-1bb9a6419ff0

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


