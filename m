Return-Path: <linux-kernel+bounces-885580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92DC33639
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31F8A4E5433
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971A2E0B68;
	Tue,  4 Nov 2025 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="PH0gCGP3"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4222E1F0E;
	Tue,  4 Nov 2025 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298975; cv=fail; b=j/Fjq1GKULEKcg5C2Mj4NLE1kovFN/m3tHXvzJd7rig7iwW3o+2UfUWRqLVQWPS2U9P62fj8QchgHI+vktiKDvJTBALcb5JsHaClppFfLPWupbY8ZHdeN/Rcv2PgPr9lt9Z59+lNG+97JMa79i0R9DXrmU2Zk4qcScheY45Th+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298975; c=relaxed/simple;
	bh=uIXX0auxt9R6NUOEoRZ2dosSxxmoQCpowhcVPR+y4CY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtyDps24j4vBI1fM6eIfhyWN0mSEeheAmZPQLqSn2fAK7IGYDoKck+5QpXUz+qQ27pGwwTObEi/8ASirTVtsrWxEpQfI3yS874rpAib1MJAqATnADPDI5Ks7ClNvygutGTlu+yp6587rqx2N6qi/IOADkKlgQ5mry0qDodt3z7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=PH0gCGP3; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWbMPIi8f1DBtK4+9nrcc7xpKWVWhQaYsNldDdeNtq5hO+YrGljT3i+fyy4on1wO4nE1oyDBFkw2z9p42rK6zXmAqQGbe3TtTmCiwJ6Xzj4C2E8AWAaKOKEPqpwDbNiM/cPxp27fU8F/fvJcGeCJEVmvZMaqBbNXjzduaEi+d4Cm4vKP1Ziz76nkI7vdc+KqUl4436F+zDWzPTTe9566CfbrQBPsabxaTWKqLnhgVbhtZhZcCncR6uLw0XkIooytg2PcnPxGXlI/i3oOkVW5bYOgq3c8v6N0lH8+ePP5CJLKan2PORZmi3Qu+dOdq1jS8cvYHc5cKbNqaxlok2YI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqTk1AyKcJqAl4vUzOhABXbhSXP7UDdJXu8pBLQbFzQ=;
 b=zBKM9gkc15T3k+p2ULtwm7fx19OunXrJ9+RE5+Z0hijaZc7or+bRZLR7atTv2ihkqcDJ1i3V8VcN65HVPE91V3xjS8yqYnSyi3r5QtOqoOj2fwI+hrFo4cdn2NwRIU/mihRxwl28TBmNOEF/xJU0FZYbQX9ZOgakaE7kBQSPAjJapJZQLU1eaRE/O2It42V2A+W5MQDmFP1UH16ZTk06w/9tWigVBGbcpTfI6mNihUluJqg/JiPDoouJHQp79kndqw0useV+tBeFTE9wneeqpmKfnyOvk6jmTIdoaNDLKqtdBQctGUKtnwrX9Nq/onUR3WwS6MOqKffRjrgNS/wNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqTk1AyKcJqAl4vUzOhABXbhSXP7UDdJXu8pBLQbFzQ=;
 b=PH0gCGP3SK6ln2vhPMcIQT/d37Ru7hqZxWzmq0niZJH6SRAbYzy9tXxVEn9/BjQtbzmPbidMuaCUOnZKWFMQhHZNv5KOGwjFWzkbrfj3ftCWm6/6wQoQygN+1heAAzJuYG933mFkrZcQUH2TU+c/uKK107XoZSGiBntvD7zW4UZCpDRzW+Fca/ikTHmWrP6Fd7jySfHgYA5gBHlGvrsLjXkU14GhVQWqyKjoAEMv7TYwQxit6C/ioGs21Hd/oXxisFX//SDDssmfzV6pm6MxNbntjx3vEeEnIi31KBZU6xcuj0/6vL3tW4ULWeCz+HQH5+vrT3tOJO9AZdaHgyHILA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BY1PR03MB7239.namprd03.prod.outlook.com (2603:10b6:a03:534::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 23:29:29 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Tue, 4 Nov 2025
 23:29:29 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v4 1/2] dt-bindings: firmware: svc: Add IOMMU support for Agilex5
Date: Wed,  5 Nov 2025 07:29:16 +0800
Message-ID: <655d380b817d9ffb11fbe70ba7d31576bf641b45.1762297657.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762297657.git.khairul.anuar.romli@altera.com>
References: <cover.1762297657.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|BY1PR03MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d54423-1768-44f0-5bdd-08de1bf9ff83
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AnynBSaIPsdxsI+kU/XrZxHmVx4ZaFHy9QwZ3RkiojruB5r9wr+MCOdlysdz?=
 =?us-ascii?Q?BNwjHzObp1Vd35xHEKAuHa4T6kY9epdNE/H1Mu3z6yf5C5c0TrLYfEGpKYRG?=
 =?us-ascii?Q?tpGHzalpMKZUsTvmrQY6uzKpxtb/CEtpB0fv1bSwQvCVIDiTKJzM1Ay08xHG?=
 =?us-ascii?Q?p5bCYQumPG3we23X3wN5/Z2hS6hRU5Pg3vrLDHnfiprM1Cl1Gyn3Z+dPuEwk?=
 =?us-ascii?Q?BeThBCC8Us+LMYHwmF71PwpSr4haZ5QvdddQg4sOCzmJuGRdB69Wf5TNtR+D?=
 =?us-ascii?Q?Fl1aZ1ZO5sGzt4Mn0jJ14pAv5c+mfwIVlRGxRKjb7ocNqYC4V+T8B1yHo9Q8?=
 =?us-ascii?Q?t4QgxXsOCvDaZDnWrI8bWOplZWxCwDzXulBhOmi17ds2Yu6rZDOioUBaaDOW?=
 =?us-ascii?Q?bsevY1+6a9mNmnPva/m1MhAu5z17PVrrzAZuFfWd6iu8flt6Ed0aub35/42v?=
 =?us-ascii?Q?8hDHNj45VxEHBDHEMF4JRl/I4mRr2k3VtcY27/i0KsNyIw4dLy09a1dTgUE6?=
 =?us-ascii?Q?mbyStqF8n6MTCpVX5zhxwUArzsTjdIdi5jkJ6pol3ulkdrvcqiEud63zl4qG?=
 =?us-ascii?Q?/BmwAxfEuNnOOpdq3Hn62W7oTaGaCc8vKxvMLdF3snuJqwQpIxHKM9pZ2wnE?=
 =?us-ascii?Q?azqm/QxU4CWOl32nAspcXSrpxWtY4VaRmfZMsCHlaD8ktNCqFHcwxUoUw/un?=
 =?us-ascii?Q?G0zk8hdHPv2P+UWhTTBcejuI2dTS53RIMtqM8rf/8PtZsrf8M1mn2txQ5cjH?=
 =?us-ascii?Q?wsxbaRi8gsuYfz+6krlgWVSay/UpD2f5qPM9XCCdThC0Ke5tAFz7EIMSV7km?=
 =?us-ascii?Q?owaz1HyeNnScNNOlbCiyzvwDA3NvBHyv7yPcVkbs9WcUeBRCWri2x6JLLhAp?=
 =?us-ascii?Q?BfJQ8vB+wzVk1aHA2JKr2LC+0qldjkw7m6/FqDeHLzd3kVuPWTZqriY1kDks?=
 =?us-ascii?Q?I2V12uA7F1ynRovMm+ltzK1PScSIawtoenv0FdWRMsXeCx3i5605yU7iPDz5?=
 =?us-ascii?Q?UXCN0BQLk9YsQOVOcEIWbzPioyzdTz5aXYqYgg/IkO++87KrEerzfd0c5qts?=
 =?us-ascii?Q?x3Z2aCjIlOyDVCjZN/moPutl+j4YCBClP5JuFQbWtC3+E7VuomepadttJagX?=
 =?us-ascii?Q?lv1jE29yQ/rRAdCzsS62dSDQd/jIXpSlqZxNl9T1RRx/QaaQwA++ZhTbyr1s?=
 =?us-ascii?Q?JYt6rYhle2Gv0WUzux6eQcOOHP/KRBwS3YFDJ9TDC77igc6wY/28/myxmsqf?=
 =?us-ascii?Q?1oxQiojl+75aiN/LlV0m/6OA8/FsvMqwxLSTe7kFWdSY++7zFobTbou8HxRT?=
 =?us-ascii?Q?R1pnVUm7x1EhzXkdb8d02BgMExPS23/OsLPfYUWkPEIAaXmSXBKZMF9TGlz7?=
 =?us-ascii?Q?wk4c1yORWteDWcSEn4kVJ+TVfw/VWsx7l5gqjdJIibF4BuZbf4RDeJeOLgqy?=
 =?us-ascii?Q?JxWEdMURYIBpN8bTC4QNPU9Z1R3djRqjCZ4k2M+kbHK6O69yBQbCEtpNkTYv?=
 =?us-ascii?Q?C3zf/VExPbD72pY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o9/OF0CpEtSqA4Q9M22sUq0kwL8P5NeUp9VJ88Eons6fpO1bKb4NLA5UrjAw?=
 =?us-ascii?Q?DMPdPeeuBc7XNLq/Fr+FvVzXCV5U2hpPJtRtA77Io98vCEmTZK6ib+7CabBv?=
 =?us-ascii?Q?OoYl3aeJoOdPvQExyCb+RYTRs8zLRdO4KhNb/+kPzNRH9JL487MbNXaeVzlf?=
 =?us-ascii?Q?HO4T9OMMRwN93xV40X4c8u7zPtZn/+l7P2KEHwM/VRQBvgWUB90uTWMGDysE?=
 =?us-ascii?Q?0jSNmKaMaN2GN3AC7YjVmGHlAeKViZ3xY1Ww3m63flmT7qzuw59Idi5GxUVs?=
 =?us-ascii?Q?ws1+ZVDs9luwrRXPHPUoRr2+ejWodg5c5LbzOEahNOtGArNJ49HvJRcdF85z?=
 =?us-ascii?Q?tnVjAXfiE9RC0ZRXxdGr9kPEKSltsRNTMyMzLv4nxMi7A8QyPh1+xvhdz1nw?=
 =?us-ascii?Q?866WyK0YBZRSXwxn45VubOm83WEzEQtdonmMdw1EI/ZBNiJuO8Tpc0thj/K/?=
 =?us-ascii?Q?jFyfWgPej5WQt6hBGqffUFFtyp3w06V6FHZGKkYVAFXXya+SVsMQdWr8NgDC?=
 =?us-ascii?Q?Q6vUqfrjkV9MT7Y5nh9EXx16w4Ew6xj0LC8cqW6B03YWAtKeOuz44V5QrlxB?=
 =?us-ascii?Q?gVU0Z+6Thly1/ExPi4WjRgPxyRRyNpGHVFnAwi6rhnZm5wIDx+Jo7d6lJ0ND?=
 =?us-ascii?Q?oAA7JcT2aY3gcTUiQ8CGHxjdw0gSNymlOG0hwFfNGky7H2Q6pZDhYk5qyrLe?=
 =?us-ascii?Q?iTTGoKld0wlVDpR/Sk+HcB/qQ1H+gzAxDOmb133KEO8HflHMgYGoQUzpe0cg?=
 =?us-ascii?Q?aMv4mejCe4yg2rQdYEpP+tbYZHYtYGg2tMXTy7jEbpvsTpa5+qXUbJyH33sk?=
 =?us-ascii?Q?smtXxPueQpSd9CERlyiLHViQ1sD5N7VSMdhFv67J5lzehmhc4K1LkX1d7qmt?=
 =?us-ascii?Q?JtlmYC6LPB7RZ/ILeDf0b1xEtmI0F/jQ61k+t+y2xZ46bL4W+rl2ifnyGx9+?=
 =?us-ascii?Q?unSSbK0Kzy3pgnKBfE2YRtvbEf55m5R/Ec1LbimFfjh4Dv+cD4EuIDy60IRn?=
 =?us-ascii?Q?8r+MCRWWe2II9OrWmXwpUEcatSDfFcmnBE3dju47lbcLkEmX2E1wC+1Ua2NQ?=
 =?us-ascii?Q?I+0N4thyVIG0fU1FON6t66YBCckWRGSsSXmMQzIeOsWB0ItDXb4QcdQRUefe?=
 =?us-ascii?Q?1eB7xLMwJKk5zNW98/GsBzXiqbH52G2ZaAPSNyP3tChlIkiBWX23G9PjrjQX?=
 =?us-ascii?Q?x7rGL1PrbX68PUCLjyjrOnzEjlc0iRh3wXHuNp+QXFSF7yHgUevCmrP0Nrao?=
 =?us-ascii?Q?YcCioibh7nNrj1Z+Fk6x6Mq1QRDQ47ItkqJYp/+z5VKyQ2Xd9EMeyf7eM/fO?=
 =?us-ascii?Q?erE8j+8VQLsBbdtyHAh9YGxZ50Pj7kWqauxpcQUSYlOxv35YLEAT5uLJHNt+?=
 =?us-ascii?Q?8CtPm6Qf6Qn67Uy44UlODSQ3ULYPZfcdugvQT+O7GLwx0aKVAfUrBGJiOIOC?=
 =?us-ascii?Q?KtXu6gao5iPOSpwLmxPwgAchtcAoYYqJ9RLWIpRx/CyFobVUcY02XlQE+2F/?=
 =?us-ascii?Q?Mrou6gLqyEqT3tRKFcU+QS7rQcsGi9QEeSFBLQ7sETjfVpqURDZAV7UHEVTV?=
 =?us-ascii?Q?R85PDrvIMUZNu9QcM1MV/63+/uFzqnj2kWsz7KhcA8kEFvbG2L0fxV1FyZrE?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d54423-1768-44f0-5bdd-08de1bf9ff83
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 23:29:28.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/fVAvAlFjuxUMOol7U++spZEsobaQrl1+oyLv60649Aq8r0FMEC3+a5KTesHGhf3XKAvc9fKYniu7mZaszyUGqiOvWSUQe/y06mZlfBzDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7239

In Agilex5, the TBU (Translation Buffer Unit) can now operate in non-secure
mode, enabling Linux to utilize it through the IOMMU framework. This allows
improved memory management capabilities in non-secure environments. With
Agilex5 lifting this restriction, we are now extending the device tree
bindings to support IOMMU for the Agilex5 SVC.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v4:
	- Fix syntax / style error.
	- Refactor code not to use AllOf but instead use if directly.
Changes in v3:
	- Add iommu property.
	- Add logical check where only Agilex5 required iommus
	- Rewrite the commit message to explain why this changes is 
	  needed.
Changes in v2:
	- Reprase commit message to exclude iommu
---
 .../bindings/firmware/intel,stratix10-svc.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
index fac1e955852e..d253943d8f5e 100644
--- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
@@ -34,6 +34,7 @@ properties:
     enum:
       - intel,stratix10-svc
       - intel,agilex-svc
+      - intel,agilex5-svc
 
   method:
     description: |
@@ -54,6 +55,9 @@ properties:
       reserved memory region for the service layer driver to
       communicate with the secure device manager.
 
+  iommus:
+    maxItems: 1
+
   fpga-mgr:
     $ref: /schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml
     description: Optional child node for fpga manager to perform fabric configuration.
@@ -63,6 +67,14 @@ required:
   - method
   - memory-region
 
+if:
+  properties:
+    compatible:
+      const: intel,agilex5-svc
+then:
+  required:
+    - iommus
+
 additionalProperties: false
 
 examples:
-- 
2.43.7


