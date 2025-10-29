Return-Path: <linux-kernel+bounces-877106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D675BC1D340
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B821D4E12F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BD363BAA;
	Wed, 29 Oct 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gnsY3yb1"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F8363B92;
	Wed, 29 Oct 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769714; cv=fail; b=gUb+dR0TcuxOYjcLBLXP4HV/1QkM24rTrWru2Jih+36IpfwRUHC7POWlhIzXVVAGgu5QAkvWLfQ/jSSDyRePxBxuzTCk6sB6YQU6KPTK1ppgWyJ9/FW4LTprI76xjAGhcQijZao3dfuACvO27UxmPmllods2jbNg8+HR0QHVvpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769714; c=relaxed/simple;
	bh=N7+/LfgTdJz7oDAWx429LGBiEzFjGz34odLrBJR2XhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GN/r9ErpCUhhiREHwqiw0o2SuPTiC5k2s5m1/HiMe8bQF1kDJDgSBux7+p7epK0Qmz+dfHTqZZfWqDWhlOjGMdBhdHKyYRE9T3VHcW3bJTP1drUuEPAh4CTeVDhCHhvW/pEw/5lLl8RNPWJeAV3Jq4Uqtf1G9LIuKDFP2B0CJhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gnsY3yb1; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT/BFG7v2JPFJGN61pWlWLc0Zu1vSImgaE/js5RyK6k3i7j5MKnsneGKsn3hwmBR5A37TMlRXBGX4Pwk8OBgbEZANa/LppVsLhHZFsieXkOlD/jss5r1ZHXd0tmj8FgI2McVgix+IAeivvGCzQriFRwlIbNHfDmtSzy3uzVzoLlUrnOvcepfmUaEnKsbLaWEZtKh3VK7W/FPqM0q3b9DfLjH00fsxvAuaDnjDkmgcOzNToHpPY+i4l2poGTEbD58in40JWuBWKSGHk+bqbR+2FnKbrkJSRhl/lU6rwGo4px/C15JrrhdJWVSZUMb/M/qKBvkYV4IK0JcRL8mMFCXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TojNt6U4hf8yxC05B9QiDPbP8GGzin8dw0MI4zHIHew=;
 b=Dc3AbhTsYm29Huz0ZZegjVuskWeempqFBHqvsZwC0w064usWkhX/IDR4qEXJ3b/Vzlt3bxx56w/rl2bxOPJdt+foqYCTDqf1IpyNx1kr8qiBFDtink7sFXiXLr5N4i9EMer1C2syIaaq1Fd391OFLNycV9yOmH0RCWdSuDjsh54cFuKxSAVJNLX0thgPF9sOf7LpRtCcD1QDwSnvjnu57BEKjYfsuqFiJPe2vVYqn8cTUVbmDSqFP9DlbuRtnPNXXo6h+zUXiRI3BIb1+v6+swWlg+TpFlFwglusVjGzaVqi2wx/6oWb8Q8CDOrgDcMLq2kg5RXKYaA9cmh3BT7IQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TojNt6U4hf8yxC05B9QiDPbP8GGzin8dw0MI4zHIHew=;
 b=gnsY3yb1p/Hglv4Y78+DJM0MvX2my5R6B2uqIsPm4/5/KJw863pyaDuHtHSVz7oVrVZkeg/vS1OJQlE65r11LHUufRP3e7zRCrXc6v1Xbiww06Dg+inIsm/SxDwqK6u/IWrJG3m1I0v/Q7QIjHPoYp87tDVy29rqFqcrlG2mjde8nkLabz6vtFxTvWnM/jU9qML7Ah6sGykuGm1UpCc449BYPaaDPuNlfQ1TBX1kfOm+2qPn4HQ8l46rhB1ns9qonWRW/nUMhKatx51vgBhrW48o8bgf8oIlWTKlzCwTlugTE6AoPvkD0AvJtU6bOMw9UjYh1hn2gki/NEmVltEq/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB7870.eurprd04.prod.outlook.com (2603:10a6:102:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 29 Oct
 2025 20:28:31 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 20:28:31 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC32XX SOC SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 5/5] ARM: dts: lpc32xx: update #address-cells of arm,pl175 to 2
Date: Wed, 29 Oct 2025 16:28:01 -0400
Message-Id: <20251029202801.3963952-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029202801.3963952-1-Frank.Li@nxp.com>
References: <20251029202801.3963952-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 550c1e91-cb70-4294-f833-08de1729b9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mBFo73VaxB7/FgibVaP3DRKt5NzQk5PAvkU0mXv2sPp6AwDyBnpHws8UJ+Ql?=
 =?us-ascii?Q?5u7blRVm8Q93tbYhSiOTX02DU5UantPmbNAiFSg9aMgx0VpbVfdFe+HAa3uj?=
 =?us-ascii?Q?6GKvvEpYuNKKn+gj4+xfCiDb72F6wbtSFYcUO3fI6QWPOMHODS6BZ/I20FED?=
 =?us-ascii?Q?M+NtzIEeNT24zpW/jD+hL0qaBdKSKhpzS0NO2jRoHYUgati5dZXy4n4GWsHw?=
 =?us-ascii?Q?gBxEUlWykkgbr0aPx0cWQgKX3vcSbOh9RzQyJK0FuLKQg08vYkTrR+FjssY0?=
 =?us-ascii?Q?aBlwEPXgTgORjM+tLnRFbLcjBjgqd3mUKrjTEF8QemnOGcSJVjTZBE2JOQet?=
 =?us-ascii?Q?tMFgHjm1g/DSnYN/k0RAgYoKJH2UfrXTOelLxAh9aAwF3xPxet+b/hsn/aHj?=
 =?us-ascii?Q?FkiN5CpG7sJBJdVU+MZnDzu8CXuH9/YCebkV6xpmade52Pgv5q07CmtBI0Oh?=
 =?us-ascii?Q?5yo8oQwJpX2W/fJ8ntwhhE1e0IAyvpCKASq/yidWJSA/7XzJfBfp5JonP4NX?=
 =?us-ascii?Q?bGeY0VvKC2C0w3P3Gq6WPckxL6mLLe13aML3pJr8TD6o9/sCTh4B7JLADTVO?=
 =?us-ascii?Q?BEkr8d7+N/Yps0FoWQREKCjVKuj5LRg9PmOGZhKZ+bsNxMcxGUg7Uu5Zk+hW?=
 =?us-ascii?Q?12xbRG4J7BnKsfH0xSrlEh29vwF9Q6d3Zi0N6mroOG6UeJeeYRTrKxFBlqVb?=
 =?us-ascii?Q?jIOBjt4Y/2c/0/3kCppfWXxxV9W6CA9Y1J/1EUmMHY53nx1LQhkqUetYCLWy?=
 =?us-ascii?Q?02JvwY8UNbexBQtYejz8eA5KG23VQJ+YrzPrfRUx+Zrimmt02KPpQtwZw9Qm?=
 =?us-ascii?Q?YPv3TWKBgUR7r7Mkq2BMnH5md2MBkxqa7nHIrq4snHu73Uw6VUnQmb3dhbb5?=
 =?us-ascii?Q?5K6TXU4/6SBgCG5MC9bPddXAicZ08yRJpXto1TqAA0dqloIuSYEhnJE89wnJ?=
 =?us-ascii?Q?/AMk7lWiX6MRlge4zmfgkzvj157IvVt1f/9cbgDuJo9SNxmk42bG/JXFHBKN?=
 =?us-ascii?Q?MrSX1qG2I4Rs6WG4zffOrSXmFvi0G97Xz69dLL8XHRChC1ALwhVq2ZniqNN2?=
 =?us-ascii?Q?6u27avox3QNDo/Rqx7TIoAw7/lzLr5ATDKN2s0B4mbphqXtGXZVxu0F8sds8?=
 =?us-ascii?Q?C6yqCTQnw547QlBzQssoBYRMhbWFOpqCQ7G6B0GCxuHtMByN0SUHKFFvdli1?=
 =?us-ascii?Q?M8GgXkLyZC1SIgb+ScFJIeCzHKwRnQ48RgECAy1kKLEN8M8lCX1K8t9/iasY?=
 =?us-ascii?Q?8o5LthIv7YpjQnTsJxBlXGAFRglat5+pki9OhSRlPAklCINPCgIqXQgfw27A?=
 =?us-ascii?Q?sKELCXlyDmWzMIDQ4PCWs9BMACsHf8B5T3Ms+EE+J6NiXtiUykEdYS9jxiNQ?=
 =?us-ascii?Q?QJLk6JyxoAlrhN4EyYQBbgC+vJmgBTMg9oD4xKfqBQ34otL5gHO6suaR+dcY?=
 =?us-ascii?Q?Yc3Rxro3Y7WLPqcUJ9/BNCzmEUmAf6eBASfnHlwnISWW+M2r6HYsiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?phB8RBxWtR6SvTC8xfePgkL/7NTFrD99So7SCRKgUl6TNHxsnw/0FtpBDVaI?=
 =?us-ascii?Q?y7oAsUsWAsANwvka6u7bmER9h+XvHfxH3M/hRJz2rCKJ3KyKTPTeQB46aO4s?=
 =?us-ascii?Q?980rlFWAIxivDuKxOeLqo6PiB9P80+6s8goFAwl6Fi9yYeueRkYI6/LApdua?=
 =?us-ascii?Q?y6z62u6Kb2sLcMclWAV3yhcil2ndGv0VYXoFccpjlcQVIx66b2LTQQhuJw2I?=
 =?us-ascii?Q?1XE5+StRWj1nRDcseN5H0/dOrpSAD4TuOLcDwbaL16IzNoI/RG5K2daMjTRC?=
 =?us-ascii?Q?BsB/Mw1j6o5tO4lzmtNpivei5Alvbi/ZZsJfn+/OIegUZwLubl9ngFyg+g7m?=
 =?us-ascii?Q?ys7qZ2sT2LRQdkYqAZ0uNDnXOKZABpmxxbkeqUAc8CU6cSivSc4j9kr+vpY8?=
 =?us-ascii?Q?CuNLsaPnEAppPheewlvCdtNk6CrBfokxrUvdvYcP4CwHmknjaNmNHpMRxwIH?=
 =?us-ascii?Q?rvzihWZDysXFX5xmvtu0us/6Ill+wBbgLageWHxKfcbr753LAzOw56EftWGy?=
 =?us-ascii?Q?nOitPJpbA8EVUK0wc68fGcK24bf7jL5Co4iA742gdvhZpUMU89Tt8fHDX4Rq?=
 =?us-ascii?Q?iMxO1YEqlVd97Zgm9qrBVBsqihqB8qxJR+bchD2i1kGeXbpwzkasABHu7V0w?=
 =?us-ascii?Q?To+ne4yZfZQoco8RoDlAoclBiRXewrwAwAe6RpPFCy15c5ovhrH41bbMpoXH?=
 =?us-ascii?Q?0dubl4dYqLJVuwffqvgeVZaUdhFigNZHc9ji/ttIPWJzKRtwASfUwUfOkvsv?=
 =?us-ascii?Q?gQcLbdhKzAJgGTuiy7/ON+yZgndYa4Jk9B/e7KUjbK6w022rLerGcvPzUDsO?=
 =?us-ascii?Q?EJayVWOLgphZmZSD6AzdFZYclXNiz+6I6UXDnGB1xi/CyazUTdViJf9UsqGU?=
 =?us-ascii?Q?VTKBCqxXQPObgoCR8be1y8xXosFHqwE83/t9TIwxed+7m7+KHvgQyhrrcSWH?=
 =?us-ascii?Q?x27DKXDQ056eYRqLOeTPshr1XaFYEqxwAvnlGZJOXAWXTNvhn6PGhSuafiU7?=
 =?us-ascii?Q?qokym2k23cXduLFZY7zXSUbXWrqcMib6RmLvcwCiSPTwTPN0/Kirp8DmH6NA?=
 =?us-ascii?Q?HfeYh2xbe5Fnkrs+Nmqb1B/EL6TqatYcuKJgtGheh2XoQCGfooE00m3qYtks?=
 =?us-ascii?Q?xmQhgsZHA17F1b/J8Hhmj34aswn39UBf5MnQiZwCvYAsKbZH/z/3RE3z9t/C?=
 =?us-ascii?Q?ZBBTpswvl/Jn1Yr/Py/P0VlDRNK+IR51eADTJrFfxwx9kqGi6Kj/F+8WWiOi?=
 =?us-ascii?Q?6RdzoX9LHkwIUEG0kTOgVZ0LfYIdkfxvtr5JZEHfKOnPMDXncbOaxOy7axG8?=
 =?us-ascii?Q?wG3j/HBvixTnZkmcIeVeWl+F3vLuIh0bQmWaJC6NgJQK0nSpGWp4w4cxOUHK?=
 =?us-ascii?Q?v0yLW4pjaThSnTOIxZdv4uvIJW6hCl1pqMj9kT+szGjYD5LGT7On8ecyhOEl?=
 =?us-ascii?Q?iLB+/+w/QzBmmzDkG96xeRwWR0NGNZYOtlJMJ8nyelZTlw43cYG37NKeoBz0?=
 =?us-ascii?Q?baiX8ilraxEylKlMfMHkMl3PeFp/zFTS1QHHOnTZxv0hbjYX/Xn96QuIXNhH?=
 =?us-ascii?Q?v7ZHQ45F/4MqFoR89xw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550c1e91-cb70-4294-f833-08de1729b9e4
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 20:28:31.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AsedbO0ANVKp/euemDiZtLUB/HzvxPVxEsY6Bbglomsp39taZprdD6/3AQ0s7+oHIrLaf04DZjoQ5QNkfXxQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7870

Change #address-cells of arm,pl175 to 2 to fix below CHECK_DTBS warnings:
  arm/boot/dts/nxp/lpc/lpc3250-ea3250.dtb: memory-controller@31080000 (arm,pl175): #address-cells: 2 was expected
        from schema $id: http://devicetree.org/schemas/memory-controllers/arm,pl172.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 77f210a2152dc..0249a1838ee0d 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -155,7 +155,7 @@ emc: memory-controller@31080000 {
 			reg = <0x31080000 0x1000>;
 			clocks = <&clk LPC32XX_CLK_DDRAM>, <&clk LPC32XX_CLK_DDRAM>;
 			clock-names = "mpmcclk", "apb_pclk";
-			#address-cells = <1>;
+			#address-cells = <2>;
 			#size-cells = <1>;
 
 			ranges = <0 0xe0000000 0x01000000>,
-- 
2.34.1


