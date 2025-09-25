Return-Path: <linux-kernel+bounces-833236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD62ABA17B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCE6741CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020A12D0606;
	Thu, 25 Sep 2025 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QhzUn6To"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E071321438;
	Thu, 25 Sep 2025 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834872; cv=fail; b=MfnzAe6uATPVJOQjzY3/9VuFHQMwFDMzyVSiG2GeKm01y07X1ksax7Rp6qUnnTvBeRdRbJ2DgUMGqXxH9zofEvArydsLFWAUf6uR0q0Lqks6bKHWUgJFsmF1+pIPrU662wQL7Xvf5iwZkhh5QEim4hZ++4riKWmfqwbK39lXvZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834872; c=relaxed/simple;
	bh=IBe0dESJLCX7jHaCf9dLwBLd5K8sW+7qIOzaAeP0mA4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bqdW4Mo2jDv83XHenqwGwocWFuVeeijlTik8lXuOJPMypGeTtB3RtgmuY9SmwiKq+n2FQfn+ZHLrvumPSn2RcYRBe7xL2D32RGTUfu1uCLu+0fF+7AP8DfdMPRjC7p/LSBzPFzzxEk6jSuYHFT2By/fnNbZm64rLngQZS8CCgs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QhzUn6To; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxwMkSfX1n4fxIPlXHx4CuC/NVj8YUNtUjone3uAYBD5lMOaEPXUYnmmEMdE1UfQ6AyW+pCe086uQHyTlZqhhlcQcz4e/yFZ3x7TYMdhgI0Mor15IvKQoRZvCQw1F/rN5UgEA/Epn1Wavjq0Z+o6b994hfsLcHedCs8641X0XyCfonNLogoOpire6TW5JW1qoxv1pG4snobPmnLLnm83is3TNdnuE7RnlTHtzqFvnET/jQXurDhRcFXmqHnuAM0AwOqC7zzgJOE05plKVvh9vTVqTXu2Wu28MZyECaSUOhvLYq5+IxrnwEzCBrBxwL2sEMd3oIHZ3hOw/bgDq9vIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDXJc4Up7QXPdAyEDqSa4Ayrn8e6rVWtgxGrmOuUZ0o=;
 b=jWsPPU2KKOLhhu2rFjsAY3E6Si+eUG4Z+44+UY4chPmR8i3ViZBI7LepPj0BDuN+IRPm0HUsmCXGM8eVSgNCgfPRt+yNpTROJ32LLjy8vBXvM9jvATWmGmZq9BhRvhUENbTlWRU12Yd1ltdVQ4aOrVK/74xFpVjSY61JunZdrDd0ZyjZtszJamZ/9G1yKo2ryHcgR5xHvQSpb+0Qp4X2itearu4RbIp/efR6lJanFSmelqZ418xWkE67Rm2aL8FeCCWskYHC7yMedP6Qq27rBZRcMbe9oM9oC4MIMKIMNky4yOxP2R/u7zXYxjAqVlIrtkJsow3CoL9i21km+CgrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDXJc4Up7QXPdAyEDqSa4Ayrn8e6rVWtgxGrmOuUZ0o=;
 b=QhzUn6ToRZLmtVAsWNr5tkhQEmvSyeE1iOkYuVCkoaGPgigdpn2TUu/RP2N91l8lVBKAWsAq6inFvPIvv8hlaJsW4Xu4F8LG6WVCyHYH1YMF0B1pl4MaQg45xMZcVUGmnK5d/5Xoqy8cxJeruRiYrEcjkbQUd7fvb0STuMGoA+7OKjM/kGPL3iqPtdwskR3IYgIVQYGd7H3NWv0OIIL6bMbU7D9ZHTtJTW4cyne7oViTykHv++LSMJk54EfyCku9CjvgKQ+yLOBPcVK6Kh6peQg4uv5RVvofUioKg/J073+sS1z+kw65R85af6ZAH3u/Gy1o+Vtx4d+/22rhiDYo/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:27 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:51 -0400
Subject: [PATCH 07/11] ARM: dts: imx6: remove pinctrl-name if pinctrl-0
 doesn't exist
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-7-748380dd0d22@nxp.com>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=1499;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IBe0dESJLCX7jHaCf9dLwBLd5K8sW+7qIOzaAeP0mA4=;
 b=ZZ6jxom/trQomEovtvBKGQS5znqYD0qTjczlGkGqwklFuccOrYsY8eRLOVdtYYDDdIIB+iF28
 DWLScJ7zDmkDoR6MkOpQZaE3RhbAaY7PSPOHGdWay4c6kJdZXMZGZ9N
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f8bc03-dd37-445e-23e0-08ddfc788240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXBHeG1IMkNOZnNiMGxCQndSOGFGd2UwOXNyYmlQSWtFRGVKY3B5VGpENktK?=
 =?utf-8?B?VWE4QmFTZ3RDYUFxK094TzdCVzhqYzkxcCtEdkRxdjIzekF1N2JvWEQ3SjVz?=
 =?utf-8?B?eC85WHYrQ0N3c2VRS01LUGVXOHQrSEprY2RGZmg4bEFIWmFmUGwvKzVhRmN0?=
 =?utf-8?B?M2RYV3N0aXpSbnUzY2R6Um44VnFjSGxqaEhZejlpcDcySnRaRFhLUklMVnlh?=
 =?utf-8?B?YWRMc0laM3h1aHJyamRvTjJTbmNxd1ZRSFd1aGN0UlA4MVpOM1IwZ1hNZnpO?=
 =?utf-8?B?bC9rU0s4UU0yZElyTVJWd3F1eEJJbVpSN2d0cFo2QUJnb29nM3Q3YmZidy9r?=
 =?utf-8?B?WElLb2lnK1hwd1JjMXcrS1ZmWnlwb1JJNDFGVGFxbWJNRGtzeElWNUs1Y2dl?=
 =?utf-8?B?Y0VodlJOaDRVZXJGb2VFVGN2RXVJZVlMTjlsSWMrRUYrYitTVFo1YlZWNmdz?=
 =?utf-8?B?djRQNTJvVXZ3RTQ0S1N5SXFLbmZBYkhVZTlMN0hEdVgyU3VyeWdKTlVkK0xE?=
 =?utf-8?B?Z2Z6ekVCTm9mMkZFREpyNGJkdFNxZ29OcXRUUGorYi9XK29EalE2TWVqUWFz?=
 =?utf-8?B?dWtiQVFWRnJNYStNV2FUTU5TSlpWdE0xbGkyUytYbnRFcDJRYW5ERXZTRCs4?=
 =?utf-8?B?L1FLcFBSNVVOV29LdVZ2bDlpbmZFRXk5NU5NbTNvdWdOZ0w5aEJOdkZpOHFt?=
 =?utf-8?B?cUovM1c2UUVPU0tqVWZmekcrM0Rscm1qMkxvLzdESkRrVldrRmF5azJWN28z?=
 =?utf-8?B?L0haU2RBMTlpazRndEU5NnBiRnlRVE4ybVNpTVdvNS9EbzJVQU5idG5YNm85?=
 =?utf-8?B?V2JGd3o0Vm5wQ0hySWZxY1BZY2pkNUtaNWgyMjNRdWpPOENaRHZJaEh6akZN?=
 =?utf-8?B?ZXM4SkMxQjNCbFhzRitXR3E4VFJFQ1VDN0pKdStuSHhSejNoeS9oT0Y1SGU3?=
 =?utf-8?B?UkNOWDBVS1A3dWhPMjBaNXRoamVTV3FiTFBYczJIZVBWcHJTWnlwOHp5aGxp?=
 =?utf-8?B?dmV5YmlWZmRUTExWaWkwcUtsZUc3bnExa2FTV1FFZjZkY1pVN1IxM1lhekRi?=
 =?utf-8?B?bS9WZ0c0a2hvbVFnZ2svbHdlcjhwL3dySGNlZUF2ODlFYThjVlB0b01GU3dm?=
 =?utf-8?B?ZkRGOU1Sci9PNlBjMTBxRFA1Sm44Z3dXT1dJR1F5azJ4VmlYbWpSQ245MVdE?=
 =?utf-8?B?ZjI0TlUrK0p3dDVCYnhBVHhvK1ROSGFxTkZjWVRrTXRkQ1pheXVTdjUzUHZM?=
 =?utf-8?B?QjNsc2lUUHE2UXR1ODN5U2lRN0VBNVdPczJqVmVyb1NmaXU1S2hwVURwS0hV?=
 =?utf-8?B?QU1jVVNjTnhJWk9PODJ4VGgyMFFRbFVzTlU0eUNWbllxak5NUFF1WWp4aFps?=
 =?utf-8?B?RlJoS3dGdG1FSDZDWU53cGdmVGRPemVabFZHemhkOGNiSUFBR3VpTW1QcG01?=
 =?utf-8?B?TXNIMEh5NWhjdVdrRTBpckZZaXFHZkg3WDVTRWU4cHk4SVhBYS9hRGxLK2Iv?=
 =?utf-8?B?T05tQW9qMUxtYmtPOE8xaHQxT2xpcVR2MlBud2wzRmMrTGNFME1DWGMyUEdL?=
 =?utf-8?B?ZThhcXJyZXpvb0Fac3pQeDVsNnd4MjlMaEZkRG5vMFRramdiTGJkTHF5cVJV?=
 =?utf-8?B?ZXF1aXpHZ0tqUEpGNzEvOVU4R2tLZkVtdXdYSmVJZCt5RVI5Z2FNM2sycUox?=
 =?utf-8?B?QytUQnVRczFIL0tzbHdFbmFCT2VVV05HM1Z3dDFsT3MzTCswV1FWU1d6eXBn?=
 =?utf-8?B?aXg0ZlV3WVJ6dWx4NHhLazU3Qnd4Sm5uUHl6elJIVEZzekRqWG9FWVhTMWVJ?=
 =?utf-8?B?dy85YTdLNkpOUWQySGdGTGVianJQWXp2d1Yvc2llL0JITFZjdE1JZzBITm5M?=
 =?utf-8?B?dy9TS2RXR3JJYnBMdEc3cnZMVnA2NTUzcDgzbnpUNkdMS3JiT0hyTUc0dHFy?=
 =?utf-8?Q?/znNIDe2ohM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUpPWU1PMlZNNDZsTWtxZ1RPVWc0V3VmMXdTOFZSUldsVUtwVDROSDcvam9U?=
 =?utf-8?B?dVJSS3o1dlpsYlUwNTJtb2MzMjQwRWpHLzJCYmVxZFlDUHZYSEVXYlRzYzFZ?=
 =?utf-8?B?VFZNdC81SEtlVlEwL3oxdFN3OWdVTFh0dVR6QlVjUmk0TmdsTzUrSFFYZDBH?=
 =?utf-8?B?bFFkVzNTSFNrQ0UvMWJhTERTMmdBVW9YMjUzR1E5Z3F4YzJqR3FNTlpCajRh?=
 =?utf-8?B?UHVQYlhDMnJZaERhc1IwdGJ2bWNVNkVjU3BpRW1lckMwK1NwUHdpU0ZVbGJN?=
 =?utf-8?B?T1gvZmsyMUQ4bitUZE5UZmEzQXdOa0lWOUF3WE5keGk0WGc2dlpTREZtemd4?=
 =?utf-8?B?Z1J2dUV6RG15bm9Qc2Y5OWJRek5RdTJSTVIwQStkMlJjb2c0OXJSeXMvM2ht?=
 =?utf-8?B?TURaOHlWTDFmWnFlakppSVJWTmxSTUxNTFhlRUV2TWQ4dFJLWlNISnRKR2E4?=
 =?utf-8?B?QkRYTkhhTVJjY1NWcDZZMTQzQUhpLzNzTWF3cXNPNkxodWpBM1l5QlY3NFc3?=
 =?utf-8?B?bVNzTHhYRXlGL3JYU21kWEs0MjdJUjFOajVTemJjRjhjUE94ckcxUDF3bWp3?=
 =?utf-8?B?cGp3Wm94RjZnVExkUXl4RSthYmtGS3FRWmJkMy9kb01TWjU2SHNIUGd3ZUFW?=
 =?utf-8?B?dlZtN3oxMUdVUUxVbTE0TXRmUGdwOXVka0poaTJWRXhLWXBKTjBuS2k1bTMv?=
 =?utf-8?B?Q0twM01zRmlGcERzV2tXc0k3VG5qVGNxTUpaMWpKdHpjZlpPMFlRb3JsOGRQ?=
 =?utf-8?B?MFpzdXE4TkpLdUluSzdVbnJQaGJGSzB6MktYWkFJS1BaTG1waXBjVVJmL001?=
 =?utf-8?B?M0daTUZCdjNwOTdJVkQ2K29XbHM4U2doeW9MNGpDb1JHbkdVWXNZdHVQNzFP?=
 =?utf-8?B?WEMySEVqVldCb2xqTzdKQWZSeDFGd2kyUkk1TS9EbUdTVGMxdS94aUhCdkxv?=
 =?utf-8?B?cVp5M1hXQkk3eksrb3JwM3ROK1JNWE5kOGcwT0R1Rks5Vk4rVHZlMHFXRkRD?=
 =?utf-8?B?VlpYQk9WOUZsekd4RVp3K2VrYzA3cFBJZGxWUllmOVZsbUJ3ZC84UWcxc2Zo?=
 =?utf-8?B?Tlo4RG5jdGxnTjEyTFJ5RXZ3d3k5VG1vcWFGWnFLVERHeEplQ1hnTDNzTG9s?=
 =?utf-8?B?WFRVM1MrbGpuSWw2WXRUU0hsWjg4Mm05VzhIeGpGZHBIL1oyTm9Bdm9HRThH?=
 =?utf-8?B?djMxVGF4OTBtVlhCVi93OEluVVRZZzUxSlZQcDRuVEhXL2VyV3o4REFuT3VV?=
 =?utf-8?B?UkpGV3NTbjltWnIyWG84bzN4V2hhbHM2cHpRcjV3Uk5aNTNwRkswUythdnhi?=
 =?utf-8?B?QkdNRnNEWkh0U3M2YjBacFg4dFI3UUlNVHhTa0kzeUZYTE8vbHJUdE4rRXJI?=
 =?utf-8?B?RDZ4eWNwbnVXMk1oVGVEcEdLSTRzYitwZ2xaN3JOQXE1R1ovc3NMZXlyREh4?=
 =?utf-8?B?U3JVRWE5dmxQaWJTQ1JFQ01tUlVkQklyNnlPdkNWcCs2c2lnYy9La2d6cG42?=
 =?utf-8?B?alpOd2kxMW5BdjVPMEhWOTZuU2dXcEYxdjVYVTA2d1BPWjBwL1VHWFR5Mlg1?=
 =?utf-8?B?NjBkQ05KMVE3SzMwU0RXVS9UeWFpdktCQXpDcnB5V1ZOQVhPS29WeHFDamps?=
 =?utf-8?B?UjZmbUNGaWNVZjNIczdwK2hUSEdKN2wwNldtZys1MW1VckxjSUJqT2hqT1Ir?=
 =?utf-8?B?V3Bac1haS29zQWFVRm9lZkltb2x6ZTJ0cWprUThjdGR0c3FRQkhrbFJlM2lt?=
 =?utf-8?B?VmZtRW1XRnAvK3h5akxrbmNibjc5b3prTTlmeitDb3BUOEFQSEZWeTZuVVBW?=
 =?utf-8?B?SXVuMTNJTzNJMjNlRHBCRHlNTSthWHlZaUwrMmF0OUtxSHI5eWplRGlGTkhW?=
 =?utf-8?B?aW43ckI2anFRQUhNTzdMMlRzeDlKWXcxSnltbnZ2b0pFMlVROU1OZCtlQjYv?=
 =?utf-8?B?S0UrVmJ0a1FqZjAzNFdvQ1o2cG9mNXl1SEtESE9TbGF0dE5ZZHZRcURkaGZa?=
 =?utf-8?B?WGk4RVRFS2lsYXc4VFZxdTVJdnNGVk5ZVyt2MFlrYk1SSnJybllGbWEvcHZy?=
 =?utf-8?B?dnBJVk5yN0M5Zm9ZdFZ6d3B5RnppRUI5azhxMmNTano2S0J4VlFucUVFdTgy?=
 =?utf-8?Q?pudigr2HnWzUZVG8lLV6wNUSd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f8bc03-dd37-445e-23e0-08ddfc788240
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:26.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msPXYR8BTki5qP0QwX/wvqOVDiP57/eASPzje6eH0h6HcJTv854VXMBFdCem/iYidp9pgmr0MSHgZrqbgszszQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

Remove redundant pinctrl-name since pinctrl-0 doesn't exist to fix below
CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dtb: pinctrl@20e0000 (fsl,imx6q-iomuxc): 'pinctrl-0' is a dependency of 'pinctrl-names'
        from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts      | 2 --
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
index 56b77cc0af2be51d8eb6a9b0931d977e1f267670..6665c3ee623d915f4a4a2e240478e41a23d1b0e5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
@@ -324,8 +324,6 @@ &i2c3 {
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x1b0b0  /*pcie power*/
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
index 2694fe18a91b12718c756c015ba99589073bbf07..7cda1f21e4182cd26a9322bc92ef6b7f88945eb4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
@@ -227,7 +227,6 @@ &usdhc4 {
 };
 
 &usbotg1 {
-	pinctrl-names = "default";
 	disable-over-current;
 	srp-disable;
 	hnp-disable;

-- 
2.34.1


