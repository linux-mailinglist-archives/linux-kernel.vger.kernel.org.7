Return-Path: <linux-kernel+bounces-842554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0366DBBD00D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 05:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA8454E2FA6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5D1D61BC;
	Mon,  6 Oct 2025 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="hhTvaof4"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4763CB;
	Mon,  6 Oct 2025 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759720230; cv=fail; b=NDTjsfyXN1yu18lL2aUqm/acyyQY/NKHnS4oNtGQ9xL7vlim4KL2mV8kKVV5SH7ydp+zRUEF/rSqEdhGS2Jl8DipCKx35+2WqqZVUNllH315ekV2H91X+LGIeV8XHuq4UY2oy7mQpxSw/XOg05BbwXqQsSu9nqAbLfSfsrbGsmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759720230; c=relaxed/simple;
	bh=6DDoTSKrDl9geeEHDvR8XWmoeJIGPnbsTihFQQYFdTc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X6ecyq/TMRKwAKDWxqXqY2Y7rXC2zVHyO+gKSIlwRfn5SXI3ADV+ai0fNCq7WqP5tKUh9EmvZNIbMiJfKpfDPbx70lP2xH56KnVAuAFOWRBgSPdwsufgGCzJYl9UsLO10au9nB4rP656UF6NvW1RFjRGfZ0ISwK1g8XdF4BOLy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=hhTvaof4; arc=fail smtp.client-ip=40.107.208.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9+sUcdBeNp5JG1UjAG9d9VN38/QOxm7SnRubdnRZL4SoRXNuCZBfDkNt2Fl2DELOvYG3GwFir8EZPWTJ4F/Qkq53ZDDEQEp3HHgwbp/qj8vJr3gkCP7X08V/Dqq9eSjLFYHJelBWUD/VUafTUq8FsezXQeC1tXvRHZRQ6zwTXC9uzR1NitrlPwVAATQamsuJq40WE5apVTE6sU/D9hvvPBcMDcOSWyf7s5FW9SxIRY6qaBvz+iDlRm5rSytwiMLjzv59keBCAhdby8JFxiMaWF6B2kkAnzfEqtb1jAPXv2kcHau++wQ2ssoCV071bOdOPKDTGLUTkuptwf2eLoh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvzw5JLDFQTXGmr6r8+cDFAL3Vhe95uOFwj5dgkuBOo=;
 b=Cc3Pm/k76BKivdps1zwYQ9xgQo1oKG1dR+fUAX+j/JH3nBMx/4kM2rgd3K9ggvQhR9+lMmAZKU12EJvgZ9KWsctfG6O24yg1/uubxX78rArD8C4S8lMC3gabUreqhHgVh0uFozpvJusDBYCnIVTpqCiuRspJYJd2/KS/I9b+SMMdLdhyoq5UlY8/Pm+4O7bk1Os17JMwkrCCJW5QMujdeTCk1EXMXglsL6QlUQCMn8MRdyyHYZHOZgP/SiMwQkMymTkhebnt9kUCUXxp2tRlog/TCH3XWR5OE5VfwTDzStoIqUOVjEQweb0Si6Yb4jEcww8O+ZLBBHxO7ILxnoaJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvzw5JLDFQTXGmr6r8+cDFAL3Vhe95uOFwj5dgkuBOo=;
 b=hhTvaof4YAPmmEcm5+ow4T5jQsuuCyE3DFhRxEg2iyFJdny94AGzHx3NTMpgSYaN4jCBl2ot/lKL9XyozaVI85pGljgH22GnTajupERsWE8SQ3GAd5E8o24VlE8hpgOqtwIPSiEgIPsHuv2aC9SUObyGLkPC/YQ14EPfovuCClbegx3T1b1ZmdMwfe9cZbOVQyLSMCGQsjjYqsPqLs/DNqScNjsxNg+qxSKNiAGD7yippHGv1JCzjswq6L7E7lQs8mhdDrBmLTyY2OLkjmeQnmTuCeD+T9Iis4IOe435e8PF69rRbZZ0EeHeM4Zhk5h2pkT7DIClmoG8WYlTU3gj1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ2PR03MB7041.namprd03.prod.outlook.com (2603:10b6:a03:4f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.14; Mon, 6 Oct
 2025 03:10:21 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 03:10:20 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	Ang Tien Sung <tiensung.ang@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 1/1] clk: socfpga: agilex5: add clock driver for Agilex5
Date: Mon,  6 Oct 2025 11:10:15 +0800
Message-Id: <a4e14e6002d3941fcb918053c1453eb1a757ef49.1759718838.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1759718838.git.khairul.anuar.romli@altera.com>
References: <cover.1759718838.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SJ2PR03MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: a73662aa-9ccb-4e01-7ead-08de0485e217
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yFa5S0dTpOLnrDIHBCX0ywmAZyDG5TZuH4a/VIgW/vXO8B/9wClEwvdbfpCs?=
 =?us-ascii?Q?M/jLw9tmAesGiV+VWwdQ/hLTJxBlU0DmGeWp5Hau/VRXxAXfksBJ3h0y++Ej?=
 =?us-ascii?Q?rslJi3pSHBBc7Yhir3/syOI483ie08ftfm5IFw/5GKJNXKMJUx+xEn1+2jyO?=
 =?us-ascii?Q?CNNopsqI7sMnHAPreR+JXfvPLdK++urwlw5cRVBiGEtnzm0Xc/XtqUS12vyO?=
 =?us-ascii?Q?nv33F2WDnpoG54431P4ypQEEzsca7bExGUHdtgp6Nnbks+7IntZ/P/dh5tZd?=
 =?us-ascii?Q?Sp3KogHDKnCTdvN10g4U4Ae93qg15c8UN84AeaFTQ/HH28YhUJA4fx2NvH7L?=
 =?us-ascii?Q?4+RS25THD9ed1E0SZPGiosv+QYip95aGL0mokbN3BTaGMP7sEWXcnxe69LB3?=
 =?us-ascii?Q?hLEzxTmywwrQ5ZHxvLL5AjjKCKS9hUuoSP2fzfzP7jRmYSYRq6da8UaHIZFH?=
 =?us-ascii?Q?NKBJsE42KBn2sozA3RRFNmALdIKWUSuhZDWZrCZtwn+mdmhiwijGZdS+W/Go?=
 =?us-ascii?Q?6Uxup+0OstLHsbcZNvfYdExXHRQsDOu6U1H7APHffCMDKo5gdT1PNvwgEmgO?=
 =?us-ascii?Q?N1indz4yq8r8GC2QyJLkQYbXkSKozbpWR22VAyq2Lq1Q6ZyueCQN31xAcHQk?=
 =?us-ascii?Q?Zy9tdCiIl1ctPpGkq3BZUqRemqYfBIWAJW3aReClNLkD464fuYDD0iOoFtS0?=
 =?us-ascii?Q?WLGlpSCpN8w351Wosp7nRdq1SgPjSqDVPxJVTqvkgdaL+6a8JlIcmImZYTZ6?=
 =?us-ascii?Q?U0ia/ySez9ToYj7HhtCo3FNjBN42/Kjv5gCr/W5Zju/tDdPtI0mtLlElykcS?=
 =?us-ascii?Q?tScOj2DuhDvG81ZmShshPXInbD+yiWqFh3H54LMJQf7Cu+cLXhR3DCIf4YV0?=
 =?us-ascii?Q?KMAhggUcfshpYSXYKR8WumxfYIfBsHRtnWrR22CAQZCcTJjNMslaBdauvbAC?=
 =?us-ascii?Q?UwUeeqARjuPj5j+r9IVAVsbF/iKBtsyJWs+ve7EsXuehByHGF7eNuQ9KKK75?=
 =?us-ascii?Q?UYGUNhZRaHuxmVnR3njpjbxY9QNABlAI/cKUg/m4aF9PTpdBpXP6pakKJVkR?=
 =?us-ascii?Q?WYQd38626rkc3WsA2jlYTXjfK5wHtFwjsqB4pA0uCOG4c5C48kwf8YqwSdqX?=
 =?us-ascii?Q?w+MwZoAReBG13t0RxRvIPhnsndbAan7YXQVE+zin+AVAcu4KiOVqizo6mV47?=
 =?us-ascii?Q?vaRR7DSK6IwgUdyq1EXWiTItAPTbKQOJ9QTnGdP3FENVoMD/ibWt6H7e5sjs?=
 =?us-ascii?Q?cZkIB37McUAsEsHj2loNUaTTOO0hRG8lT278BdXeAxiYHufq/Qbk/34Nyirc?=
 =?us-ascii?Q?B4pwQjMxZQ9HkXrIuwQUHcpXEawajdiNGt0gOjRp/aW8W8k+7A+sgQUK8hQF?=
 =?us-ascii?Q?gCjzcDkxmhtVhwja1XuIrad+Sj5rR0b2CRIw8wKFZjmXsKp8RE+Hc2vSKniN?=
 =?us-ascii?Q?l9vtZ6qA/Bm2eC/6kLxsnvuJ/PlgshNP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nQnPS2adJojhxSq4kUmJD+Pu/vWRgDLU2QQe4iBlfiHaNn5giO9AjeVSgdW0?=
 =?us-ascii?Q?GQS91dWb9GdIx3Yz8wrEOCqBTgeUv2UTEhJholhcMDPL5trBQiGjak/+q0JJ?=
 =?us-ascii?Q?tHic5ejMz7p67kyy7Rx/CY74BGkat+SB/DqQnS6UERrG0PnEXMUtC3Ei+tIQ?=
 =?us-ascii?Q?WezWyxiF1N3dVQ4z+UI7Z8zREiIVdd424izRMH4lUyI2An8n75+bQE9Zq03y?=
 =?us-ascii?Q?ipXJYff6pQNvjbHl8y+39VYlzvV5nYeOaCDWjK2ksprJaPiB4sLJb1m1Itu8?=
 =?us-ascii?Q?El2Z2vSSOY9U9wuBir62Emsx7S+tXYub9bF4tHCh9JH33nVwhswFpBRxunEV?=
 =?us-ascii?Q?R6gkzw2FOnerXkJ+w9YdaIPsuZCNd2XNBFhpmnfvwMatKC0mpvYuSI8V/bmq?=
 =?us-ascii?Q?kgwX38sUmVCfdc6IMd5QHTIh3UXeta2wDJWqUskc0eQls1MRE03sf3UkIrkh?=
 =?us-ascii?Q?f74hza1jxf9mKgPBpybbB9SpN2n+H5Rua/TasIMTWcADTJo/EH09jABwe3vb?=
 =?us-ascii?Q?LDRJwKbNAb1nwMUcFandawy/Yuz0vQ7cMWyq2QHzlKW1tACW83lisFKJs6bJ?=
 =?us-ascii?Q?++0wyNrotnAxUC/Zq0ERR48rHLvjSygv0LJQsTWtgYeYq9UAS64OjHuy9P9U?=
 =?us-ascii?Q?m/wAUAFChuNYOyKNM2aMRntgXzrT32ELwJuHtl9LhPoplK25OdBluCJCyEx7?=
 =?us-ascii?Q?2ORVZnX/FCnQfLObEzgw2yP9p2CLekbGSjxM9yoVoNrKBNVn768dGRqQkyD7?=
 =?us-ascii?Q?dmpCJxut5QQNX9ooB5U6GDP7uAu9Rui2gg7ITjoP6uEvazt9GjNDPaFTdhUg?=
 =?us-ascii?Q?pAf5cVUbPdbkVZ6oBLQLKbZoiRlbBs65wfs2gT8Kle5CEMkUrz3E9Hp21RXH?=
 =?us-ascii?Q?PpNkx0tle/O2tb3CTD6tCZIKVuNz7/zUKpVVLwQJaRz5FIsQ8tCXa3Xt6nlu?=
 =?us-ascii?Q?yTKgTT+PTBBwy1FmGFS9PAtzne7PyDKW9frENfRfpatshdy+8UX/o1hiHeHY?=
 =?us-ascii?Q?v7dv8YTfMRN5UQiuRhCajRkVxthnTwdKAVUV7wZ3YJIQqc1uOlud/APVZqQT?=
 =?us-ascii?Q?odoHMxe7mGbalMLCgm1wmmxgMy2cAj2spxp8H7qgbzu5bE8MpnkL1S/7hmNU?=
 =?us-ascii?Q?3Svzf0ROPKXdHKLQU7TKByErZqDxRT9fu4PKk6NyauhgzcbPufqAmkyFvh6r?=
 =?us-ascii?Q?lucssRBQHEYjAMqsIRfgnCKtWutmxb1JGH22B7+NyOaD9ui3J2syz3KtXH28?=
 =?us-ascii?Q?u+vAfXYNZVLKEsfuwCCyiSM96YICGhRyjF2NjwSap9MMMWmeUcuHmjCjOmpQ?=
 =?us-ascii?Q?iCK4gvocU4PCQzV2RWDfK5YBjohv2r6yJqg58HHyCUWp7Pwv4eBGvqV5iPss?=
 =?us-ascii?Q?8YV7AA4y2dtpkF8af9m+Pg2NuxC6HOd6cRT1xx4P9oLBZ0juvBExbJjG/ZSp?=
 =?us-ascii?Q?q5gJDPx11Ts0LErF6P0+llBOq+PUHe9zwY7B1XQmDxF4Zd0GWMtTmsRoFRNG?=
 =?us-ascii?Q?DDk/1Z97Hn2aIaGmE4DhmWIkyj7P0zyzd2tVhVYrUwU1aalhTa/vdeIH2i2y?=
 =?us-ascii?Q?qiPjULmiXvNrIP2w6wgoP0mdabjMpxi6mbI9jdYOWFSLpDd6akTEOW73REcW?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73662aa-9ccb-4e01-7ead-08de0485e217
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 03:10:20.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDK+uYR63qEBIfzaAxQabqPZM+czvEEg8tUQxBOzdVyGzSudRvDFsa/Xz32zKQkh/8fq3VwrBPufJWlCs7TxqkvEJqj4xhFoqcCarDRldVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7041

Add the new Clock manager driver to support new Agilex5 platform. The new
driver got rid of the clk_parent_data structures as there are no 'clock-names'
property in the DT bindings and use parent_names internally. This is based on
the previous feedback from the maintainer.

Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- Add clk-agilex5 to Makefile
	- Add Kconfig to include Agilex5 clock manager
	- us of.h instead of of_device and of_address
	- use devm_platform_ioremap_resource to simplify the get resource
	- Fix bound-checking coverage struct clock_data
	- Clean up harmless TODO comment
---
 drivers/clk/socfpga/Kconfig          |   2 +-
 drivers/clk/socfpga/Makefile         |   2 +-
 drivers/clk/socfpga/clk-agilex5.c    | 561 +++++++++++++++++++++++++++
 drivers/clk/socfpga/clk-gate-s10.c   |  53 +++
 drivers/clk/socfpga/clk-periph-s10.c |  41 ++
 drivers/clk/socfpga/clk-pll-s10.c    |  36 ++
 drivers/clk/socfpga/stratix10-clk.h  |  43 ++
 7 files changed, 736 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-agilex5.c

diff --git a/drivers/clk/socfpga/Kconfig b/drivers/clk/socfpga/Kconfig
index 0cf16b894efb..d88277e2a898 100644
--- a/drivers/clk/socfpga/Kconfig
+++ b/drivers/clk/socfpga/Kconfig
@@ -13,7 +13,7 @@ config CLK_INTEL_SOCFPGA32
 	default ARM && ARCH_INTEL_SOCFPGA
 
 config CLK_INTEL_SOCFPGA64
-	bool "Intel Stratix / Agilex / N5X clock controller support" if COMPILE_TEST && (!ARM64 || !ARCH_INTEL_SOCFPGA)
+	bool "Intel Stratix / Agilex / N5X / Agilex5 clock controller support" if COMPILE_TEST && (!ARM64 || !ARCH_INTEL_SOCFPGA)
 	default ARM64 && ARCH_INTEL_SOCFPGA
 
 endif # CLK_INTEL_SOCFPGA
diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
index e8dfce339c91..a1ea2b988eaf 100644
--- a/drivers/clk/socfpga/Makefile
+++ b/drivers/clk/socfpga/Makefile
@@ -3,4 +3,4 @@ obj-$(CONFIG_CLK_INTEL_SOCFPGA32) += clk.o clk-gate.o clk-pll.o clk-periph.o \
 				     clk-pll-a10.o clk-periph-a10.o clk-gate-a10.o
 obj-$(CONFIG_CLK_INTEL_SOCFPGA64) += clk-s10.o \
 				     clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o \
-				     clk-agilex.o
+				     clk-agilex.o clk-agilex5.o
diff --git a/drivers/clk/socfpga/clk-agilex5.c b/drivers/clk/socfpga/clk-agilex5.c
new file mode 100644
index 000000000000..f7f0ad884f64
--- /dev/null
+++ b/drivers/clk/socfpga/clk-agilex5.c
@@ -0,0 +1,561 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2024, Intel Corporation
+ * Copyright (C) 2025, Altera Corporation
+ */
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include  <dt-bindings/clock/intel,agilex5-clkmgr.h>
+#include "stratix10-clk.h"
+#include "clk.h"
+
+/* External parent clocks come from DT via fw_name */
+static const char * const boot_pll_parents[] = {
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+};
+
+static const char * const main_pll_parents[] = {
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const periph_pll_parents[] = {
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+};
+
+/* Core free muxes */
+static const char * const core0_free_mux[] = {
+	"main_pll_c1",
+	"peri_pll_c0",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const core1_free_mux[] = {
+	"main_pll_c1",
+	"peri_pll_c0",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const core2_free_mux[] = {
+	"main_pll_c0",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const core3_free_mux[] = {
+	"main_pll_c0",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const dsu_free_mux[] = {
+	"main_pll_c2",
+	"peri_pll_c0",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const noc_free_mux[] = {
+	"main_pll_c3",
+	"peri_pll_c1",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const emac_ptp_free_mux[] = {
+	"main_pll_c3",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const emaca_free_mux[] = {
+	"main_pll_c2",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const emacb_free_mux[] = {
+	"main_pll_c3",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const gpio_db_free_mux[] = {
+	"main_pll_c3",
+	"peri_pll_c1",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const psi_ref_free_mux[] = {
+	"main_pll_c1",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const usb31_free_mux[] = {
+	"main_pll_c3",
+	"peri_pll_c2",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const s2f_user0_free_mux[] = {
+	"main_pll_c1",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const s2f_user1_free_mux[] = {
+	"main_pll_c1",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+/* Secondary muxes between free_clk and boot_clk */
+static const char * const core0_mux[] = {
+	"core0_free_clk",
+	"boot_clk",
+};
+
+static const char * const core1_mux[] = {
+	"core1_free_clk",
+	"boot_clk",
+};
+
+static const char * const core2_mux[] = {
+	"core2_free_clk",
+	"boot_clk",
+};
+
+static const char * const core3_mux[] = {
+	"core3_free_clk",
+	"boot_clk",
+};
+
+static const char * const dsu_mux[] = {
+	"dsu_free_clk",
+	"boot_clk",
+};
+
+static const char * const noc_mux[] = {
+	"noc_free_clk",
+	"boot_clk",
+};
+
+static const char * const emac_mux[] = {
+	"emaca_free_clk",
+	"emacb_free_clk",
+	"boot_clk",
+};
+
+static const char * const s2f_user0_mux[] = {
+	"s2f_user0_free_clk",
+	"boot_clk",
+};
+
+static const char * const s2f_user1_mux[] = {
+	"s2f_user1_free_clk",
+	"boot_clk",
+};
+
+static const char * const psi_mux[] = {
+	"psi_ref_free_clk",
+	"boot_clk",
+};
+
+static const char * const gpio_db_mux[] = {
+	"gpio_db_free_clk",
+	"boot_clk",
+};
+
+static const char * const emac_ptp_mux[] = {
+	"emac_ptp_free_clk",
+	"boot_clk",
+};
+
+static const char * const usb31_mux[] = {
+	"usb31_free_clk",
+	"boot_clk",
+};
+
+static const struct agilex5_pll_clock agilex5_pll_clks[] = {
+	{
+		.id = AGILEX5_BOOT_CLK,
+		.name = "boot_clk",
+		.parent_names = boot_pll_parents,
+		.num_parents = ARRAY_SIZE(boot_pll_parents),
+		.flags = 0,
+		.offset = 0x0,
+	},
+	{
+		.id = AGILEX5_MAIN_PLL_CLK,
+		.name = "main_pll",
+		.parent_names = main_pll_parents,
+		.num_parents = ARRAY_SIZE(main_pll_parents),
+		.flags = 0,
+		.offset = 0x48,
+	},
+	{
+		.id = AGILEX5_PERIPH_PLL_CLK,
+		.name = "periph_pll",
+		.parent_names = periph_pll_parents,
+		.num_parents = ARRAY_SIZE(periph_pll_parents),
+		.flags = 0,
+		.offset = 0x9C,
+	},
+};
+
+/* Main PLL C0, C1, C2, C3 and Peri PLL C0, C1, C2, C3. With ping-pong counter. */
+static const struct stratix10_perip_c_clock agilex5_main_perip_c_clks[] = {
+	{ AGILEX5_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0,
+	  0x5C },
+	{ AGILEX5_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0,
+	  0x60 },
+	{ AGILEX5_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0,
+	  0x64 },
+	{ AGILEX5_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0,
+	  0x68 },
+	{ AGILEX5_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0,
+	  0xB0 },
+	{ AGILEX5_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0,
+	  0xB4 },
+	{ AGILEX5_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0,
+	  0xB8 },
+	{ AGILEX5_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0,
+	  0xBC },
+};
+
+/* Non-SW clock-gated enabled clocks */
+static const struct agilex5_perip_cnt_clock agilex5_main_perip_cnt_clks[] = {
+	{ AGILEX5_CORE0_FREE_CLK, "core0_free_clk", core0_free_mux,
+	ARRAY_SIZE(core0_free_mux), 0, 0x0100, 0, 0, 0},
+	{ AGILEX5_CORE1_FREE_CLK, "core1_free_clk", core1_free_mux,
+	ARRAY_SIZE(core1_free_mux), 0, 0x0104, 0, 0, 0},
+	{ AGILEX5_CORE2_FREE_CLK, "core2_free_clk", core2_free_mux,
+	ARRAY_SIZE(core2_free_mux), 0, 0x010C, 0, 0, 0},
+	{ AGILEX5_CORE3_FREE_CLK, "core3_free_clk", core3_free_mux,
+	ARRAY_SIZE(core3_free_mux), 0, 0x0110, 0, 0, 0},
+	{ AGILEX5_DSU_FREE_CLK, "dsu_free_clk", dsu_free_mux,
+	ARRAY_SIZE(dsu_free_mux), 0, 0xfc, 0, 0, 0},
+	{ AGILEX5_NOC_FREE_CLK, "noc_free_clk", noc_free_mux,
+	ARRAY_SIZE(noc_free_mux), 0, 0x40, 0, 0, 0 },
+	{ AGILEX5_EMAC_A_FREE_CLK, "emaca_free_clk", emaca_free_mux,
+	ARRAY_SIZE(emaca_free_mux), 0, 0xD4, 0, 0x88, 0 },
+	{ AGILEX5_EMAC_B_FREE_CLK, "emacb_free_clk", emacb_free_mux,
+	ARRAY_SIZE(emacb_free_mux), 0, 0xD8, 0, 0x88, 1 },
+	{ AGILEX5_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", emac_ptp_free_mux,
+	ARRAY_SIZE(emac_ptp_free_mux), 0, 0xDC, 0, 0x88, 2 },
+	{ AGILEX5_GPIO_DB_FREE_CLK, "gpio_db_free_clk", gpio_db_free_mux,
+	ARRAY_SIZE(gpio_db_free_mux), 0, 0xE0, 0, 0x88, 3 },
+	{ AGILEX5_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", s2f_user0_free_mux,
+	ARRAY_SIZE(s2f_user0_free_mux), 0, 0xE8, 0, 0x30, 2 },
+	{ AGILEX5_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", s2f_user1_free_mux,
+	ARRAY_SIZE(s2f_user1_free_mux), 0, 0xEC, 0, 0x88, 5 },
+	{ AGILEX5_PSI_REF_FREE_CLK, "psi_ref_free_clk", psi_ref_free_mux,
+	ARRAY_SIZE(psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6 },
+	{ AGILEX5_USB31_FREE_CLK, "usb31_free_clk", usb31_free_mux,
+	ARRAY_SIZE(usb31_free_mux), 0, 0xF8, 0, 0x88, 7},
+};
+
+static const char * const cs_pdbg_parents[] = { "cs_at_clk" };
+static const char * const usb31_bus_clk_early_parents[] = { "l4_main_clk" };
+static const char * const l4_mp_clk_parent[] = { "l4_mp_clk" };
+static const char * const l4_sp_clk_parent[] = { "l4_sp_clk" };
+static const char * const dfi_clk_parent[] = { "dfi_clk" };
+
+/* SW Clock gate enabled clocks */
+static const struct agilex5_gate_clock agilex5_gate_clks[] = {
+	{ AGILEX5_CORE0_CLK, "core0_clk", core0_mux,
+	  ARRAY_SIZE(core0_mux), 0, 0x24, 8, 0, 0, 0, 0x30, 5, 0 },
+	{ AGILEX5_CORE1_CLK, "core1_clk", core1_mux,
+	  ARRAY_SIZE(core1_mux), 0, 0x24, 9, 0, 0, 0, 0x30, 5, 0 },
+	{ AGILEX5_CORE2_CLK, "core2_clk", core2_mux,
+	  ARRAY_SIZE(core2_mux), 0, 0x24, 10, 0, 0, 0, 0x30, 6, 0 },
+	{ AGILEX5_CORE3_CLK, "core3_clk", core3_mux,
+	  ARRAY_SIZE(core3_mux), 0, 0x24, 11, 0, 0, 0, 0x30, 7, 0 },
+	{ AGILEX5_MPU_CLK, "dsu_clk", dsu_mux, ARRAY_SIZE(dsu_mux), 0, 0, 0,
+	  0, 0, 0, 0x34, 4, 0 },
+	{ AGILEX5_MPU_PERIPH_CLK, "mpu_periph_clk", dsu_mux,
+	  ARRAY_SIZE(dsu_mux), 0, 0, 0, 0x44, 20, 2, 0x34, 4, 0 },
+	{ AGILEX5_MPU_CCU_CLK, "mpu_ccu_clk", dsu_mux,
+	  ARRAY_SIZE(dsu_mux), 0, 0, 0, 0x44, 18, 2, 0x34, 4, 0 },
+	{ AGILEX5_L4_MAIN_CLK, "l4_main_clk", noc_mux, ARRAY_SIZE(noc_mux),
+	  CLK_IS_CRITICAL, 0x24, 1, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_L4_MP_CLK, "l4_mp_clk", noc_mux, ARRAY_SIZE(noc_mux), 0,
+	  0x24, 2, 0x44, 4, 2, 0x30, 1, 0 },
+	{ AGILEX5_L4_SYS_FREE_CLK, "l4_sys_free_clk", noc_mux,
+	  ARRAY_SIZE(noc_mux), 0, 0, 0, 0x44, 2, 2, 0x30, 1, 0 },
+	{ AGILEX5_L4_SP_CLK, "l4_sp_clk", noc_mux, ARRAY_SIZE(noc_mux),
+	  CLK_IS_CRITICAL, 0x24, 3, 0x44, 6, 2, 0x30, 1, 0 },
+
+	/* Core sight clocks*/
+	{ AGILEX5_CS_AT_CLK, "cs_at_clk", noc_mux, ARRAY_SIZE(noc_mux), 0,
+	  0x24, 4, 0x44, 24, 2, 0x30, 1, 0 },
+	{ AGILEX5_CS_TRACE_CLK, "cs_trace_clk", noc_mux,
+	  ARRAY_SIZE(noc_mux), 0, 0x24, 4, 0x44, 26, 2, 0x30, 1, 0 },
+	{ AGILEX5_CS_PDBG_CLK, "cs_pdbg_clk", cs_pdbg_parents, 1, 0, 0x24, 4,
+	  0x44, 28, 1, 0, 0, 0 },
+
+	/* Main Peripheral PLL1 Begin */
+	{ AGILEX5_EMAC0_CLK, "emac0_clk", emac_mux, ARRAY_SIZE(emac_mux),
+	  0, 0x7C, 0, 0, 0, 0, 0x94, 26, 0 },
+	{ AGILEX5_EMAC1_CLK, "emac1_clk", emac_mux, ARRAY_SIZE(emac_mux),
+	  0, 0x7C, 1, 0, 0, 0, 0x94, 27, 0 },
+	{ AGILEX5_EMAC2_CLK, "emac2_clk", emac_mux, ARRAY_SIZE(emac_mux),
+	  0, 0x7C, 2, 0, 0, 0, 0x94, 28, 0 },
+	{ AGILEX5_EMAC_PTP_CLK, "emac_ptp_clk", emac_ptp_mux,
+	  ARRAY_SIZE(emac_ptp_mux), 0, 0x7C, 3, 0, 0, 0, 0x88, 2, 0 },
+	{ AGILEX5_GPIO_DB_CLK, "gpio_db_clk", gpio_db_mux,
+	  ARRAY_SIZE(gpio_db_mux), 0, 0x7C, 4, 0x98, 0, 16, 0x88, 3, 1 },
+	  /* Main Peripheral PLL1 End */
+
+	  /* Peripheral clocks  */
+	{ AGILEX5_S2F_USER0_CLK, "s2f_user0_clk", s2f_user0_mux,
+	  ARRAY_SIZE(s2f_user0_mux), 0, 0x24, 6, 0, 0, 0, 0x30, 2, 0 },
+	{ AGILEX5_S2F_USER1_CLK, "s2f_user1_clk", s2f_user1_mux,
+	  ARRAY_SIZE(s2f_user1_mux), 0, 0x7C, 6, 0, 0, 0, 0x88, 5, 0 },
+	{ AGILEX5_PSI_REF_CLK, "psi_ref_clk", psi_mux,
+	  ARRAY_SIZE(psi_mux), 0, 0x7C, 7, 0, 0, 0, 0x88, 6, 0 },
+	{ AGILEX5_USB31_SUSPEND_CLK, "usb31_suspend_clk", usb31_mux,
+	  ARRAY_SIZE(usb31_mux), 0, 0x7C, 25, 0, 0, 0, 0x88, 7, 0 },
+	{ AGILEX5_USB31_BUS_CLK_EARLY, "usb31_bus_clk_early", usb31_bus_clk_early_parents,
+	  1, 0, 0x7C, 25, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_USB2OTG_HCLK, "usb2otg_hclk", l4_mp_clk_parent, 1, 0, 0x7C,
+	  8, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIM_0_CLK, "spim_0_clk", l4_mp_clk_parent, 1, 0, 0x7C, 9,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIM_1_CLK, "spim_1_clk", l4_mp_clk_parent, 1, 0, 0x7C, 11,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIS_0_CLK, "spis_0_clk", l4_sp_clk_parent, 1, 0, 0x7C, 12,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIS_1_CLK, "spis_1_clk", l4_sp_clk_parent, 1, 0, 0x7C, 13,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_DMA_CORE_CLK, "dma_core_clk", l4_mp_clk_parent, 1, 0, 0x7C,
+	  14, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_DMA_HS_CLK, "dma_hs_clk", l4_mp_clk_parent, 1, 0, 0x7C, 14,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I3C_0_CORE_CLK, "i3c_0_core_clk", l4_mp_clk_parent, 1, 0,
+	  0x7C, 18, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I3C_1_CORE_CLK, "i3c_1_core_clk", l4_mp_clk_parent, 1, 0,
+	  0x7C, 19, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_0_PCLK, "i2c_0_pclk", l4_sp_clk_parent, 1, 0, 0x7C, 15,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_1_PCLK, "i2c_1_pclk", l4_sp_clk_parent, 1, 0, 0x7C, 16,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC0_PCLK, "i2c_emac0_pclk", l4_sp_clk_parent, 1, 0,
+	  0x7C, 17, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC1_PCLK, "i2c_emac1_pclk", l4_sp_clk_parent, 1, 0,
+	  0x7C, 22, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC2_PCLK, "i2c_emac2_pclk", l4_sp_clk_parent, 1, 0,
+	  0x7C, 27, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_UART_0_PCLK, "uart_0_pclk", l4_sp_clk_parent, 1, 0, 0x7C, 20,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_UART_1_PCLK, "uart_1_pclk", l4_sp_clk_parent, 1, 0, 0x7C, 21,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPTIMER_0_PCLK, "sptimer_0_pclk", l4_sp_clk_parent, 1, 0,
+	  0x7C, 23, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPTIMER_1_PCLK, "sptimer_1_pclk", l4_sp_clk_parent, 1, 0,
+	  0x7C, 24, 0, 0, 0, 0, 0, 0 },
+
+	/*NAND, SD/MMC and SoftPHY overall clocking*/
+	{ AGILEX5_DFI_CLK, "dfi_clk", l4_mp_clk_parent, 1, 0, 0, 0, 0x44, 16,
+	  2, 0, 0, 0 },
+	{ AGILEX5_NAND_NF_CLK, "nand_nf_clk", dfi_clk_parent, 1, 0, 0x7C, 10,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_NAND_BCH_CLK, "nand_bch_clk", l4_mp_clk_parent, 1, 0, 0x7C,
+	  10, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SDMMC_SDPHY_REG_CLK, "sdmmc_sdphy_reg_clk", l4_mp_clk_parent,
+	  1, 0, 0x7C, 5, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SDMCLK, "sdmclk", dfi_clk_parent, 1, 0, 0x7C, 5, 0, 0, 0,
+	  0, 0, 0 },
+	{ AGILEX5_SOFTPHY_REG_PCLK, "softphy_reg_pclk", l4_mp_clk_parent, 1, 0,
+	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SOFTPHY_PHY_CLK, "softphy_phy_clk", l4_mp_clk_parent, 1, 0,
+	  0x7C, 26, 0x44, 16, 2, 0, 0, 0 },
+	{ AGILEX5_SOFTPHY_CTRL_CLK, "softphy_ctrl_clk", dfi_clk_parent, 1, 0,
+	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
+};
+
+static int
+agilex5_clk_register_c_perip(const struct stratix10_perip_c_clock *clks,
+			     int nums, struct stratix10_clock_data *data)
+{
+	struct clk_hw *hw_clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		hw_clk = s10_register_periph(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+			       clks[i].name);
+			continue;
+		}
+		data->clk_data.hws[clks[i].id] = hw_clk;
+	}
+	return 0;
+}
+
+static int
+agilex5_clk_register_cnt_perip(const struct agilex5_perip_cnt_clock *clks,
+			       int nums, struct stratix10_clock_data *data)
+{
+	struct clk_hw *hw_clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		hw_clk = agilex5_register_cnt_periph(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+			       clks[i].name);
+			continue;
+		}
+		data->clk_data.hws[clks[i].id] = hw_clk;
+	}
+
+	return 0;
+}
+
+static int agilex5_clk_register_gate(const struct agilex5_gate_clock *clks,
+				     int nums,
+				     struct stratix10_clock_data *data)
+{
+	struct clk_hw *hw_clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		hw_clk = agilex5_register_gate(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+			       clks[i].name);
+			continue;
+		}
+		data->clk_data.hws[clks[i].id] = hw_clk;
+	}
+
+	return 0;
+}
+
+static int agilex5_clk_register_pll(const struct agilex5_pll_clock *clks,
+				    int nums, struct stratix10_clock_data *data)
+{
+	struct clk_hw *hw_clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		hw_clk = agilex5_register_pll(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+			       clks[i].name);
+			continue;
+		}
+		data->clk_data.hws[clks[i].id] = hw_clk;
+	}
+
+	return 0;
+}
+
+static int agilex5_clkmgr_init(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct stratix10_clock_data *clk_data;
+	void __iomem *base;
+	int i, num_clks;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	num_clks = AGILEX5_NUM_CLKS;
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
+				num_clks), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->base = base;
+	clk_data->clk_data.num = num_clks;
+
+	for (i = 0; i < num_clks; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
+	agilex5_clk_register_pll(agilex5_pll_clks, ARRAY_SIZE(agilex5_pll_clks),
+				 clk_data);
+
+	/* mainPLL C0, C1, C2, C3 and periph PLL C0, C1, C2, C3*/
+	agilex5_clk_register_c_perip(agilex5_main_perip_c_clks,
+				     ARRAY_SIZE(agilex5_main_perip_c_clks),
+				     clk_data);
+
+	agilex5_clk_register_cnt_perip(agilex5_main_perip_cnt_clks,
+				       ARRAY_SIZE(agilex5_main_perip_cnt_clks),
+				       clk_data);
+
+	agilex5_clk_register_gate(agilex5_gate_clks,
+				  ARRAY_SIZE(agilex5_gate_clks), clk_data);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_data);
+	return 0;
+}
+
+static int agilex5_clkmgr_probe(struct platform_device *pdev)
+{
+	int (*probe_func)(struct platform_device *init_func);
+
+	probe_func = of_device_get_match_data(&pdev->dev);
+	if (!probe_func)
+		return -ENODEV;
+	return probe_func(pdev);
+}
+
+static const struct of_device_id agilex5_clkmgr_match_table[] = {
+	{ .compatible = "intel,agilex5-clkmgr", .data = agilex5_clkmgr_init },
+	{}
+};
+
+static struct platform_driver agilex5_clkmgr_driver = {
+	.probe		= agilex5_clkmgr_probe,
+	.driver		= {
+		.name	= "agilex5-clkmgr",
+		.suppress_bind_attrs = true,
+		.of_match_table = agilex5_clkmgr_match_table,
+	},
+};
+
+static int __init agilex5_clk_init(void)
+{
+	return platform_driver_register(&agilex5_clkmgr_driver);
+}
+core_initcall(agilex5_clk_init);
diff --git a/drivers/clk/socfpga/clk-gate-s10.c b/drivers/clk/socfpga/clk-gate-s10.c
index 3930d922efb4..dce3ef137bf3 100644
--- a/drivers/clk/socfpga/clk-gate-s10.c
+++ b/drivers/clk/socfpga/clk-gate-s10.c
@@ -239,3 +239,56 @@ struct clk_hw *agilex_register_gate(const struct stratix10_gate_clock *clks, voi
 	}
 	return hw_clk;
 }
+
+struct clk_hw *agilex5_register_gate(const struct agilex5_gate_clock *clks, void __iomem *regbase)
+{
+	struct clk_hw *hw_clk;
+	struct socfpga_gate_clk *socfpga_clk;
+	struct clk_init_data init;
+	int ret;
+
+	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
+	if (!socfpga_clk)
+		return NULL;
+
+	socfpga_clk->hw.reg = regbase + clks->gate_reg;
+	socfpga_clk->hw.bit_idx = clks->gate_idx;
+
+	gateclk_ops.enable = clk_gate_ops.enable;
+	gateclk_ops.disable = clk_gate_ops.disable;
+
+	socfpga_clk->fixed_div = clks->fixed_div;
+
+	if (clks->div_reg)
+		socfpga_clk->div_reg = regbase + clks->div_reg;
+	else
+		socfpga_clk->div_reg = NULL;
+
+	socfpga_clk->width = clks->div_width;
+	socfpga_clk->shift = clks->div_offset;
+
+	if (clks->bypass_reg)
+		socfpga_clk->bypass_reg = regbase + clks->bypass_reg;
+	else
+		socfpga_clk->bypass_reg = NULL;
+	socfpga_clk->bypass_shift = clks->bypass_shift;
+
+	if (streq(clks->name, "cs_pdbg_clk"))
+		init.ops = &dbgclk_ops;
+	else
+		init.ops = &agilex_gateclk_ops;
+
+	init.name = clks->name;
+	init.flags = clks->flags;
+	init.num_parents = clks->num_parents;
+	init.parent_names = clks->parent_names;
+	socfpga_clk->hw.hw.init = &init;
+	hw_clk = &socfpga_clk->hw.hw;
+
+	ret = clk_hw_register(NULL, &socfpga_clk->hw.hw);
+	if (ret) {
+		kfree(socfpga_clk);
+		return ERR_PTR(ret);
+	}
+	return hw_clk;
+}
diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
index f5c1ca42b668..f12ca43ffe7c 100644
--- a/drivers/clk/socfpga/clk-periph-s10.c
+++ b/drivers/clk/socfpga/clk-periph-s10.c
@@ -214,3 +214,44 @@ struct clk_hw *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *c
 	}
 	return hw_clk;
 }
+
+struct clk_hw *agilex5_register_cnt_periph(const struct agilex5_perip_cnt_clock *clks,
+					   void __iomem *regbase)
+{
+	struct clk_hw *hw_clk;
+	struct socfpga_periph_clk *periph_clk;
+	struct clk_init_data init;
+	const char *name = clks->name;
+	int ret;
+
+	periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
+	if (WARN_ON(!periph_clk))
+		return NULL;
+
+	if (clks->offset)
+		periph_clk->hw.reg = regbase + clks->offset;
+	else
+		periph_clk->hw.reg = NULL;
+
+	if (clks->bypass_reg)
+		periph_clk->bypass_reg = regbase + clks->bypass_reg;
+	else
+		periph_clk->bypass_reg = NULL;
+	periph_clk->bypass_shift = clks->bypass_shift;
+	periph_clk->fixed_div = clks->fixed_divider;
+
+	init.name = name;
+	init.ops = &peri_cnt_clk_ops;
+	init.flags = clks->flags;
+	init.num_parents = clks->num_parents;
+	init.parent_names = clks->parent_names;
+	periph_clk->hw.hw.init = &init;
+	hw_clk = &periph_clk->hw.hw;
+
+	ret = clk_hw_register(NULL, hw_clk);
+	if (ret) {
+		kfree(periph_clk);
+		return ERR_PTR(ret);
+	}
+	return hw_clk;
+}
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index a88c212bda12..1be92827cd93 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -304,3 +304,39 @@ struct clk_hw *n5x_register_pll(const struct stratix10_pll_clock *clks,
 	}
 	return hw_clk;
 }
+
+struct clk_hw *agilex5_register_pll(const struct agilex5_pll_clock *clks,
+				    void __iomem *reg)
+{
+	struct clk_hw *hw_clk;
+	struct socfpga_pll *pll_clk;
+	struct clk_init_data init;
+	const char *name = clks->name;
+	int ret;
+
+	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
+	if (WARN_ON(!pll_clk))
+		return NULL;
+
+	pll_clk->hw.reg = reg + clks->offset;
+
+	if (streq(name, SOCFPGA_BOOT_CLK))
+		init.ops = &clk_boot_ops;
+	else
+		init.ops = &agilex_clk_pll_ops;
+
+	init.name = name;
+	init.flags = clks->flags;
+	init.num_parents = clks->num_parents;
+	init.parent_names = clks->parent_names;
+	pll_clk->hw.hw.init = &init;
+	pll_clk->hw.bit_idx = SOCFPGA_PLL_POWER;
+	hw_clk = &pll_clk->hw.hw;
+
+	ret = clk_hw_register(NULL, hw_clk);
+	if (ret) {
+		kfree(pll_clk);
+		return ERR_PTR(ret);
+	}
+	return hw_clk;
+}
diff --git a/drivers/clk/socfpga/stratix10-clk.h b/drivers/clk/socfpga/stratix10-clk.h
index 83fe4eb3133c..d1fe4578b3e0 100644
--- a/drivers/clk/socfpga/stratix10-clk.h
+++ b/drivers/clk/socfpga/stratix10-clk.h
@@ -73,12 +73,55 @@ struct stratix10_gate_clock {
 	u8			fixed_div;
 };
 
+struct agilex5_pll_clock {
+	unsigned int	id;
+	const char	*name;
+	const char	* const *parent_names;
+	u8	num_parents;
+	unsigned long   flags;
+	unsigned long   offset;
+};
+
+struct agilex5_perip_cnt_clock {
+	unsigned int		id;
+	const char		*name;
+	const char	* const *parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			fixed_divider;
+	unsigned long		bypass_reg;
+	unsigned long		bypass_shift;
+};
+
+struct agilex5_gate_clock {
+	unsigned int		id;
+	const char		*name;
+	const char	* const *parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	unsigned long		gate_reg;
+	u8			gate_idx;
+	unsigned long		div_reg;
+	u8			div_offset;
+	u8			div_width;
+	unsigned long		bypass_reg;
+	u8			bypass_shift;
+	u8			fixed_div;
+};
+
 struct clk_hw *s10_register_pll(const struct stratix10_pll_clock *clks,
 			     void __iomem *reg);
 struct clk_hw *agilex_register_pll(const struct stratix10_pll_clock *clks,
 				void __iomem *reg);
 struct clk_hw *n5x_register_pll(const struct stratix10_pll_clock *clks,
 			     void __iomem *reg);
+struct clk_hw *agilex5_register_pll(const struct agilex5_pll_clock *clks,
+				    void __iomem *reg);
+struct clk_hw *agilex5_register_cnt_periph(const struct agilex5_perip_cnt_clock *clks,
+					   void __iomem *regbase);
+struct clk_hw *agilex5_register_gate(const struct agilex5_gate_clock *clks,
+				     void __iomem *regbase);
 struct clk_hw *s10_register_periph(const struct stratix10_perip_c_clock *clks,
 				void __iomem *reg);
 struct clk_hw *n5x_register_periph(const struct n5x_perip_c_clock *clks,
-- 
2.35.3


