Return-Path: <linux-kernel+bounces-880256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DFBC253D3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9884A1A62E00
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D7A34BA33;
	Fri, 31 Oct 2025 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ePxF7ziI"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128E34B672;
	Fri, 31 Oct 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916805; cv=fail; b=ja0a4CDQ0+/xkB/ZUeBcHqy9fMcQ7D166v9Z7piV13lXtbDsGyRxaeTEFziIBzjcT5kQbQcLLQ9dWFZG9CLJn8R79+AQ7f6KVXx2H+YRaQ+nNImF7f9DtU9R1YZkqIOv+H6XuiuMOTModnTd9QrnmKNTsyibFIPmQw+72kFmtIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916805; c=relaxed/simple;
	bh=D425VT2AFTAsfAoHZXAe83MBKtWUI3JilGNL0gBi8V8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DU2hPPgPKLDdKQlptlBaqGBAZgcw7s/3pMQoYJbfbkiNYcqCnMI1nz82hY/52TtpILqOS+Kkbj0PPOXzI6OAbggWpBpSP+PGjGd4EZvNMgJ3CRXfy38VqJpiS0BtW81enLjqP71ffjPmviHJ2N2FuB6UqLEq4JAHIizSD/7d/RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ePxF7ziI; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdtB0WxmHOxjfMqu/XXsA8eFB+zTGDa3wskMVIrB0xpmXRaDRg0O4ZgSLCMURo1AZrr8PQXrBa6rNhBG00ivQTAzDbsIAYZ0I267QQ5/TYS/po63tvzHysY/IW0klb7NuT9PGAgPvJy6oszHXjHdO7rmmEfT/RLUmjxbaLtOvIXYUmJHcNqlx8E/QVZEdqhPFnU93eixELRY9SN8Cm5d2qWRVK4hjAjWCRJhzmAhm3PQKwbpf1kwil7D/kYKXX3ATX8rO75jQbsob/Mm4EyeQe2/b/1401JSo/eiZatk2IwL4FxIQFT2ApW52HZLAt++9Hg9zkcrGDxo7vFjn3NIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX8ZkXFJA5SF0SSZqT2W/jcf6DA4qsOKh8WXZdQBY10=;
 b=T1tq4dhRLSXzXKgKM1lRH+DS1+EANwcR8G+LS7rON0UsSeG4l7kKx3mj6NXfNshlvcrLfyVDGzu5/NDVXSVSRd9pdB5RizOLtFN7fxJ+3ZWm85LDamEEvbmsJ2uOLatKKlrl1oEq/RVe1R2aQCw1d6wfL+zxwnibKxwyLCzQd6ZW6Dtixr0xBLMA2+Suuq93iPc0eYg2UhFgetB7EyJYPtU6VPS7neKeOb0FwDkGJ3jCAwe92NIA1rTggx372BmbS7C7OyDuK5v20PtW+eNHL58V9bpn6M4phZEMXtO1ploKnqbN5EQf8Fa8ZO9Rjy4+dt9T3ZtWFCsSV39rGFlmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX8ZkXFJA5SF0SSZqT2W/jcf6DA4qsOKh8WXZdQBY10=;
 b=ePxF7ziIDwH9G3C7OQ4pe/vqc9LVrdsdQTlKvO0Cb68fhtOnQIfgv9Zu86DivOcohyuib8a1SAQ2VKbk+j+/I1P3KxXKaWdHkmG2osFArH16cLmYXVnuWoXtZHuj4X9pBloQlrsl7y10fdH8yEMgffq9K0xBYunYWRX8p/Yz1/P9LwO8yrXnIMpdOecA5BD7axb+jk/RwY1fte75sFaQaOcJa1dWQNyVvi/e+YPPbIx7xR9zUI5mTcIInE1oAVntQffWSLynD95RLohmsInXSYLln2KMqCeHXpTm5oAoEklZYtgr5tEMPQJ2eMnfBmfk6vyflA2+CpllevNM8nvlIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SA1PR03MB6579.namprd03.prod.outlook.com (2603:10b6:806:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 13:20:00 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 13:20:00 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v2 2/2] arm64: dts: socfpga: agilex5: add support for 013b board
Date: Fri, 31 Oct 2025 21:17:39 +0800
Message-Id: <20251031131739.914012-3-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251031131739.914012-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251031131739.914012-1-niravkumarlaxmidas.rabara@altera.com>
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
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SA1PR03MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 0551c732-b0bb-4765-57c1-08de188031cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BokXp7QEye06+Lc56Am/vA7BNChiBvZ0bHQ4lomi5rXI0i9gfJIxZ9yWfAay?=
 =?us-ascii?Q?p2vXdMvSVEz+JyJ3g9/j4d/kr318gj1ImjxtffFZmhPj5buc9fTjQHzsD5Vy?=
 =?us-ascii?Q?T7trf1DNkn7b3JYX19MfllF3i+vQiuQJXpNIgQE5JbrahPRHzqpTT2fwfgFQ?=
 =?us-ascii?Q?hj9/aeuLpCu2V++jpG7QU1UoVnGRIAst0V2MRfW7CbqTiGWNJ4i+MqdYApwO?=
 =?us-ascii?Q?ypuFPRbaXNH5rCMm/3FBtC2pMYv/DtDrTmAMgU558UP50azdVgH4xIF+30/B?=
 =?us-ascii?Q?xAnGM1lowCZNhKpIdFNS3uxTzN/5bzm2gD24/3/BhiEu87OrD1uA0TNgtfFy?=
 =?us-ascii?Q?WhSVup/VaCrPZnoppFETjnYiYqQzB8eojxGtnpZ5q3VlAJpj1E6HKpOLnU0K?=
 =?us-ascii?Q?1nNcZ2IsFfJl+j9Q9MJysFu2bidN66FPZIr6ja2dZnX1gIoz2fcEmnL1K3F5?=
 =?us-ascii?Q?urqKbve4qrYu6Pk2CtjBh6khK5OD7q6WdQSneMcqrrTkNmCC1Fr12+JxLB9q?=
 =?us-ascii?Q?GTW+W2cpnS9ZyiSW4/7UE/UKKaSgeXelS5fHR6Rqhjr6Y6olHrXcuU30aLAu?=
 =?us-ascii?Q?iEyb8Miv1oko8J1wrapihXROlKvurH8jVxQ8nC5pdsFHKFnznXNjMJcJSaTl?=
 =?us-ascii?Q?SEEHtfuaRkAmNj/vcQ3kVwlY5+JtPOAuv80Vjne1Mf8WeIMC22RiHNgRzXAh?=
 =?us-ascii?Q?D/ZUoep5c2H9qgoTcUcDmqEJaMFi4Hlexbg10WXBp/0QYrIwWEXeMVuiOz2U?=
 =?us-ascii?Q?6OjywceuPcUmyPrEiCpD/AV3BPNas0bK4roemniQSwyIJ+QxEC2br3zW8MUy?=
 =?us-ascii?Q?IPbqlaqSkUkrMvlU8qCx0u3EVPvJ77rkcPL9VNVmT9LjTcygAh7x/Y7N4PLF?=
 =?us-ascii?Q?8ZAxhBDHKrohQCBNOAo41mUSRstLDqcQWBT5K99+Q0bSRBSWsILDx0ncVEpF?=
 =?us-ascii?Q?gmcABTjPUOo0D9kXNN2RXm0xcF2iYTpeDa96wuzz9v6pXR2d7qztbmmFY2H+?=
 =?us-ascii?Q?0TUlVVpFjdCRwcUajRS6Obhvt9L/Vm9SKOI20l21AyN6nljZOpX4Lok3V05d?=
 =?us-ascii?Q?Y/qHma6WQCZ1WWsrmIH4yISRRqwUnT095iv4H8ZO7wWt21lp6y5xCY+TzxfK?=
 =?us-ascii?Q?pa1EisC22Y6y30usLgC4J8x+yp23A5yqWcqnn9rPYZdggfd5HwnBpJ7SGzJv?=
 =?us-ascii?Q?scw7Aj5FkRA4yhCzPGB382mdXHvPWdlcLn3Q6FPhYuvp29rtzRrM0mEwWnPZ?=
 =?us-ascii?Q?OffYpgfdjTgaGVdlk6S0zp5BpyaUC2vCCyGs45DYeelRcyQEgfZzGaD84S7a?=
 =?us-ascii?Q?eGZlK33A/Jr5bj42Tf+I5jzj4ebCqHzroG9vVkDTaxF/dHwTI6ywVGVCMdJk?=
 =?us-ascii?Q?hIMjrgixEDu2emJhJWzACrDk1IT9hxNAf48i3pEBp8QPmhAFS7FFUY67nQo1?=
 =?us-ascii?Q?ZKUyE2AI4/EDnCtoIlLiDAn1uLxnJiqJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBY44DOJVdMLul//m6OPnf5mAfdwtHCQocTfu+t6isw4p/KKa2vvkO+ZSfbz?=
 =?us-ascii?Q?CkhVaB1hHm1WSgB2nhaloOMb7ZixM57OMvtte2eWNWCvnbvgJZLwngHICANw?=
 =?us-ascii?Q?aVLqXR3izP2XLddNyAUHFBZI0PifGIkgKrPSeAn0es3b7gcRBB2LUHdU6ZbP?=
 =?us-ascii?Q?ZWwbki95gKX9JZgQ22i04oDeVY/ELr5AULDkPOPvpiVZz8VHVF/xyRMjke2x?=
 =?us-ascii?Q?9R0xeHiOhLYl2WBKbiKthIrgQW4fiixbfamPUvhhbMYh8ZlEfBgBKW/lyw1a?=
 =?us-ascii?Q?znC5NHORgv9FKyk7UjSULynxNIvuzdJ/aiaaBp51ZDAY7ID/edgBY74xjafI?=
 =?us-ascii?Q?V8kFuqE11CudvUjCXGNTIfOGv7+A757uUbXtQ+ceeRvPtn3mDEd/RYtdAzwJ?=
 =?us-ascii?Q?tqy5CAINaORrKRL2bE6qvXB43qsd0RXv7Al/Oi3LAGgpWPOS8VtCkthTzXTm?=
 =?us-ascii?Q?aZq+6u0TFpgwM12mdUamGUy9TnwYthsONITQvSuy/NjasrVLFtBfg38ZHJWM?=
 =?us-ascii?Q?Y2zAQe5RtF3EV2YXYm8hY5GCNEnNkNWXfFYoJnjXkS3Ueq8kCOsdDcJK5nnd?=
 =?us-ascii?Q?WV25OvuSuaaCfzsv8TJYRf/Ny/7j2LzJMfdGjQYF1+2fFvRA8j/MZeniLAQk?=
 =?us-ascii?Q?p78gBwP7pf+RkFY3ydYxHe52V7xqcDgHtV3brtA4Wvlfe/eIC0Zm+VfSdsxN?=
 =?us-ascii?Q?najGISFgvDa47nsUBZju0kSjPlEEimWnIpRlIp+V+jR4HXjLJ+yxJtu59H07?=
 =?us-ascii?Q?wyOkxT4hg9cUzfnniZnNLggWR9SRBd1HZPyiZeqxLOB15e5zVbZUwwp3e3J8?=
 =?us-ascii?Q?xirm6PsappwtWSO3CiLPcMFIAADusEA98+gKnbBnaAiNTj75+VJ7g5UpZMtA?=
 =?us-ascii?Q?9Neu7iXFPhCRWQ5SV3Wv79ejQWkhPJMZk2eOweVaQtI1fcpz5xu74GhhqARA?=
 =?us-ascii?Q?qZ10ft3ocr1c5PsV7WaxALwktzZUYVkzIlikj5QTb+zLnpZ+Zb4MJL4dLMZ9?=
 =?us-ascii?Q?pY9phTPQmo5D4HFIrEvrmhhqfX4l+etWuyOCLWjtN5+IbKj/LjKuhl9ZYngX?=
 =?us-ascii?Q?9YjMESvvvwzUgAK/IP29fS8jdY4RWeYB08X75CLt5PeQJDvmbWauXvpv6dJg?=
 =?us-ascii?Q?GAm5iETy3YiLZNux/cZawQ7P9+TtVPj1rr4c4VkYX6zgjxWmuXZ8sjMyK9ij?=
 =?us-ascii?Q?/Szsf04uE+vJ2uYAf517GLbcWeqEVAgnNMN9YgSZIp9jr0AwhqXxGCC4kaqi?=
 =?us-ascii?Q?lvmTyXgxeqhBjU/S5in9iLNA+XIOe5P4YDLrCkUfXlSXkoOhC7VjAaxWl9qY?=
 =?us-ascii?Q?4TU4TWfBnXXOW27fjhn2Ss2kqbuN4S9RwZy5n8fqVGqQw7QuC67CsxCUYpDi?=
 =?us-ascii?Q?t/dkSOIXAWTK8rsU9STqsNQ+Ot/RvjDgLC9hHLhHrTAEym+n4KLMFlV6AY4A?=
 =?us-ascii?Q?IOTg/oGdHg0EXjLCdXsbLeuGUcj95Bnr8N/S2lbvx+SAllBhGUeZJWuU1uzz?=
 =?us-ascii?Q?0ymps1EJVAjcFQULuw3VUH9M8NMkXDga/Tmz5b5VXKViet/pMV0g8zQkxkNm?=
 =?us-ascii?Q?FDLfRnhDDmZe8n+pGntd4QMcmcxZvzReOJU+osBkei+aBabrT/fsI79Bes12?=
 =?us-ascii?Q?U/hy/Yw/pQCbEasx8eZnZdYj1vKa9OOoHZOf1nwPfaNw?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0551c732-b0bb-4765-57c1-08de188031cf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:20:00.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOVTJ8KJmli2nOiYqySV6sjhtK2OuVix/pS3lkDyYTPND6/TAKqmLCotfxLmd+Hk9taGZoHvh8njE+xCFvaGrVc/A6Bax/hIbVfSXs0qKUAATgdiRA0X4tKnI1LVCDfO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6579

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Agilex5 SoCFPGA 013b is a small form factor development kit.
Supports both tabletop and PCIe add-in card operation. It features
expansion headers for Raspberry Pi 4/5 HATs and Digilent Pmod modules,
enabling integration with popular ecosystems.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---

Changelog:
v1->v2:
* Drop "Agilex5" from commit header.
* Add more details about 013b board in commit message.

v1 patch link:
https://lore.kernel.org/all/20251031103117.910187-3-niravkumarlaxmidas.rabara@altera.com/

 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../dts/intel/socfpga_agilex5_socdk_013b.dts  | 126 ++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 33f6d01266b1..391d5cbe50b3 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
 				socfpga_agilex5_socdk.dtb \
+				socfpga_agilex5_socdk_013b.dtb \
 				socfpga_agilex5_socdk_nand.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts
new file mode 100644
index 000000000000..37ff715b7928
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Altera Corporation
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 013B SoCDK";
+	compatible = "intel,socfpga-agilex5-socdk-013b", "intel,socfpga-agilex5";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "hps_led0";
+			gpios = <&porta 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led1 {
+			label = "hps_led1";
+			gpios = <&porta 12 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+			rxc-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			txc-skew-ps = <0>;
+			txen-skew-ps = <60>;
+			txd0-skew-ps = <60>;
+			txd1-skew-ps = <60>;
+			txd2-skew-ps = <60>;
+			txd3-skew-ps = <60>;
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		cdns,read-delay = <2>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x00600000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x00600000 0x03a00000>;
+			};
+		};
+	};
+};
+
+&smmu {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.25.1


