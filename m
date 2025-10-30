Return-Path: <linux-kernel+bounces-877485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79493C1E33E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B711889BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D33B288535;
	Thu, 30 Oct 2025 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kT3JgA54"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4F37A3BC;
	Thu, 30 Oct 2025 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795020; cv=fail; b=NjmlXAamlnnFNL/HP+VcwwjLVKkfSp5h12wFvWUB42BJfFu20jO0EYkz/jaIXETwf2wKKZtseMOj9hriVTFH6JiucrmzBrC+z8ZeAPyBnASdXH3/3WtVjcLppHrHfqXWhmjppxi0xwIXgJ7frm5wp+KSPUDxfn3WLf8AOQeBXls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795020; c=relaxed/simple;
	bh=GZ6u7QrNlF7D+tCqw+VO+gtbRmBX2uxnjACtBKS8FJc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gtrg2Q72WWDZCRY/hAmtW/rQ7jJxcdB6O310DCqgxaqqyvtaJlILExOlwGZd070ZiW8EgV8YZWVkQ8pYkmTmyeaoatedKq4E5X01ZN9+WXueLlfZd5Iq0gm1wcdOQqhQ2mXuui91cw/6DhYA0lzLJr3bnz7gbC8zVx6xR1G+jTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kT3JgA54; arc=fail smtp.client-ip=52.101.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDVFR1C1igkdM/sHTkADkU1PdTqYV4clgSnUazE2niPSLUSg2oTTaarlz1qaVWbHwQQ6F7ewCQ8u4OOjzSEQpiTk6b0cTSh102GfwWx6MpgL9KimhP/S7WFjzj0BdDxwijvb1Lki0k2H38DL5RBkLa499Y7+s1jaojPNUjtJTA79JhXrexjh66KqRPi6yL6UEUC2oOV6GtDeIDmsZR6aTLOsPQdFRlkRBO/kH48pZYUIFLiBkNcm7rDFRQhqcpfNSImsS8PpRigjrvYNw7GL+CB0xlvk5Q6m2thSp3u6fcqe79A3zq1uN3GvvUyoXdJmGaF4LJO3hPzFoSlgc6fgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fVwk1By6QKGBUa6mNIdNMzxXzX20YO1y/rmjp0mAHw=;
 b=W2i0/uZelUU2EvSNPUVL884cdSwT7nUhWdutdZhJO8y/Vjkbb8inEzIAX4VvpIixmV90LyBKK2A/UTOgsQQqaChCPsh9X84i7vbQK0NqQejx8HVh3Kk0I38LiHW2r6qk/AyDvfWh+TmUYO//g5ad2bKrAQjwLOkrPRPsfes2OOk+emrisKdsG92NQk2irPgIemeB870E6r8UFX21W5FcQd0AFUxKRoRIx7Z3uuW4U+8dwCxeLXhZnxpQNipmi7LhCSCmrhHbp/Prvy9eaaEczpD10ASn92IfJJhcfAlr6Q4KreEox/1wnibQZSGUHY2WH8QmVTpVRqBqkkEJmzHKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fVwk1By6QKGBUa6mNIdNMzxXzX20YO1y/rmjp0mAHw=;
 b=kT3JgA54OOBPA1o+ii79oX7FKBA5DwAqpueyHYKVVYrRAjR3gentUcapYb9351izYJ4ZR5K6EZhtltnh/0esPBprf2yHlDDfGjM7zgglHarqcbhaPl9lLF474MIZfvTGk1k7WHdae0RIom1GWmlXKmPyhSjuEkl+IR6otN7+cnLHB1ymc0mXoQyJryefmWCFgxTuMvfYvjJmYQATTWtFRIDrEgigfmRyIE3akzl0N3mcetBsLrFo9Wxt3jFM5F8knqfJefQPtXqLIW0pdQjPzNIDG0ca6FQTKeQHl83pKJmyoSvseGebXrLzRFEikWR8JHtLRiDZ67eovHn+JUqjpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by DS0PR03MB7655.namprd03.prod.outlook.com (2603:10b6:8:1f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 03:30:15 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Thu, 30 Oct 2025
 03:30:15 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 0/3] Enable Service layer driver for Agilex5
Date: Thu, 30 Oct 2025 11:30:06 +0800
Message-ID: <cover.1761648711.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|DS0PR03MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: b37dd298-d527-4843-37af-08de1764a3c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nQIBeNmkH/3es6QZ7eiPMAvV1QKeDI5zrsaCnLuHhCsKRmpLDGG41+lZbdNz?=
 =?us-ascii?Q?TzxENQZRgczEW+ScjxpEFAiyrvSm6ip7N8jBKHuHZ9ww2U42akLzx6Y+iJ2c?=
 =?us-ascii?Q?bOcKNQ89mJ+pcZ13gW4lPpa4QtoywLqj2EJnct4+xEMTxc76v9nbGoxa/CZH?=
 =?us-ascii?Q?KprGmffTuaPAdE/2QlavXa/P8jEMQMdMan204gUEQGGuvQa3qHcg7YYkdk9r?=
 =?us-ascii?Q?fTYeXjbFPn/Xlm7gtb4/lr6txbHRbOoKLqzddIhVbhGWL3CNeYB5+X1yY5kE?=
 =?us-ascii?Q?nVKbLWfJl5gRGgtonsCbjhTQHXwc5ulhpjQonrFMx1mu+dEH9/kJ1wg7wbxD?=
 =?us-ascii?Q?GVqfq3fE2hia7bwe0UuHcj4bdOje/79YRgrNNmI4d/DQ/ZLZTw6Yaevcu1He?=
 =?us-ascii?Q?x0ZabPiGNfwRf6dnVK4etyOm+Mt81EgLBHMPEgKC3Hu2H/IxyqQxdvTECnAT?=
 =?us-ascii?Q?j6Y4+cKnVePVtNpGpi/RIurDJuwa8S7wBqeinAb4BCKF6yQeyGdugdF/RDNA?=
 =?us-ascii?Q?3dPthEAowqoDJW8bIqTrYMx2iikGKv/y8OeZqd/BkaCyWusE4uR/3Plmpkkt?=
 =?us-ascii?Q?hPdrt1koIwaNv6z5RZZw4LNQKGYwamPFjNhdPsSw0PsJC4gSIC4vRI+r1b73?=
 =?us-ascii?Q?ZEeYzc9d4zTEn+5kPm4AU+m1Jw3Lq5vtfPpwjMType5de8sMoQFiXJw5QW+I?=
 =?us-ascii?Q?Rqg/EXcJTFraAwStxgLD95cLgZ3bd3jvSkMvQeDu+WKGR1BRH6pnm9QesQSW?=
 =?us-ascii?Q?a7/NoYZJOknJ/DbQkJh4nhXogckljWkTB8cHS8mCMcwuepkG+Ac/cZUEHrc8?=
 =?us-ascii?Q?hcC0lGCs4D2pVWvZpWpwZskkkZFtB0yW5RLObjQaJ19vP4sNovGqmo5/9xwR?=
 =?us-ascii?Q?eaW9zWg85Zojvmy4X52qh7s7ps/ylo9XhyXjNJbOJFQGzwB6LtAyXvdWJO8O?=
 =?us-ascii?Q?eZAdW8Iiqk0iqMZPye57dsW0BwCqrGvmRivEywCPZoLUXpV9AuAwdC75xDux?=
 =?us-ascii?Q?WqfSYyT7pRA5lJJwpYUGdxf+Sn/GW4iOlyxrfrp3FLrF4qkMYUXdBZ5fugES?=
 =?us-ascii?Q?YSCvG5jBpwVh3+pd+QCTW4i2oycp7hFJ9laDR3tGlJu8WEjb1y4P+I62ZpGO?=
 =?us-ascii?Q?o9CFDLVFp0DZHeFeCQ55GFksZSx/coeN1h/6m93Ad3DdUVuRut5j2BOrYPSY?=
 =?us-ascii?Q?pDwuGqODk/lQzWLzGCC/yyd35XdfJ0AgjjPNxeJlz9pgtRFiAl+u+0I9kPVW?=
 =?us-ascii?Q?1AvLFjsBUUSfFgNB37W1+zTflJKv/Rcl8GjCxJRXesdiBH21FiAB3HEGLzEx?=
 =?us-ascii?Q?Y98ceVeFnG4mfyq87Yu6P2b1DJvbvJogp/hj2cgvPAJVXdTPtYZXtB7QNKu+?=
 =?us-ascii?Q?50RRPUUTqCEXI1T0Y2Tia8+knVzZ5U9gifCaAYMWE2YqYRrSHhDTfJxCmVMV?=
 =?us-ascii?Q?hlPFnKR68mocJ8WyWKGP9PKPpQaHHeNB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J5JEaxCmM4bqcm+PtO0r1EJECp1zu96OmHQRqV921jXk0w1VQyKpyptbKX/Y?=
 =?us-ascii?Q?lHPIfxVrJ/3LvszGDJ6qdlUea1Bvoo5yGhHg9dGHW8CHX8xN7selSFwQFIek?=
 =?us-ascii?Q?QRQbZEUK6SpcyJVJWqduYcUoArlKXRZqJEz1/7TBq2DWdu4aNjy3sx9xi26e?=
 =?us-ascii?Q?6opqDWsNtQ5UYSYoJK58/9YpI/KxfEdLxIIpRcSpYtQ9mC/5urXz6zTrIu+O?=
 =?us-ascii?Q?UIgCL6dFW68YoLnv7n0fW7emdkIFk+IujkJ79qboiRlDn73qDpyPjdjaAx5m?=
 =?us-ascii?Q?Bcr8kaY3GZ0gKGURf7qgHA+BdQWtf3/YyhzSTplKJYTb0OuG2mRlFcOViNpM?=
 =?us-ascii?Q?ee78ZUvxxaERX8muBoUigvvUuYgWywzQKX7/Lmr1qWTS0yD8N/2fdgsixAg0?=
 =?us-ascii?Q?HMB6DTuJxwBL/nLa6++02jwsC2xswaVlnNRo5XAVgSKliQZDddZtDSJ1WshZ?=
 =?us-ascii?Q?0Kr5alysjAs3UC2NCJnQpEFTOClsUl86UEmCCVXm4MqznC8Vh0ysIxbo0pGM?=
 =?us-ascii?Q?UoUIKl02pZ/gCVfHK2M8qC6veMFF3gfDwFJ7KhGEbN0JHB2iNRJUbVrx5fkS?=
 =?us-ascii?Q?C7XOdG/1Ve70cYBBUG3qi/jqsRZQbeNHwPgFA0hQfbtXe2+UU8rYxFZMAIXz?=
 =?us-ascii?Q?ykhCEckqtfNLB/jRWj9ZcLBU6d0sjFbm99X7rh7NcXZIn5Ysvuae6mwRrHpN?=
 =?us-ascii?Q?wYmUc60o/0l8N6l0yn019IBq4tOTdTPqO/iX66zApndQUI2G4ig0pL1d0ABe?=
 =?us-ascii?Q?OMigT7d5Z7J1jWVnyL2PbEF5wU4W1LE5GmkWuvqeqak/+3A0JmJiYlHznn2c?=
 =?us-ascii?Q?JjPWIxtVYfJTx2nZnrmc6yqEVLlvTTNUDF7vnyaowMSw9kC4dat7cTHfSPk/?=
 =?us-ascii?Q?8ln6Gbp/ctZPKEN2h7nswttYg3m1Hx87p7zHHO67wz0SfXr31sE0ddmxxFHd?=
 =?us-ascii?Q?hNMaMNQGEMmzrU4tZlYX12eH06oc12E7JBUF03Rk8ft0fssckzosBgdsL3z/?=
 =?us-ascii?Q?IEIrmUGjzqwY6kYN83MLbnAMKvdCD0sdgxVqNBTxZ19ZaH1dzVLY7TkjMwRi?=
 =?us-ascii?Q?w1tpCk9cymoTLa8LK1/elUHiDA5i83SFx7wVx304qMr//SUr6rhSGpgQ+dkT?=
 =?us-ascii?Q?0jcSRRpHJFOCBo/3fXI89t4ku8PhFIrqinEgVMEs31AIwuXd23wSS+qeJUCb?=
 =?us-ascii?Q?vNcST1w/ImcjgnxNGhzwdowoh0rWA8rOJjoDtw/h+fg37u5/spQK3IpBN/62?=
 =?us-ascii?Q?4kDZRhBRWNZi3P+kYIT5VjfcmUGRi+dZsGFgvrI0cQhF2ciTG0yabYpa4pK+?=
 =?us-ascii?Q?ycJGKztyS4ORPVi4f1EUEK6sUsdpuXhi5B7pHicY4W7UbQ4TJlMBFSmiJJB0?=
 =?us-ascii?Q?hS4AyR2qeX32+Ha+R1JChgQgVxC+mWmnAYz48Gm+z7iD7VNwY0uIJevkrGOp?=
 =?us-ascii?Q?8bScMNVrw8psUy8FQzgyDIHVpXPbiexmMIk8UJai/xjKxCBaH4BF0w/UKrLT?=
 =?us-ascii?Q?po4j01ss/wuGurNLm7pfCOb1P5Shpy4nQQCaO+8CfAHdjKqAV7T9q8JoYwzd?=
 =?us-ascii?Q?tDEvOsg6xP8nNBbey3O53ELaAePSDmUGgSlVAenvakMFBulxvHxmdoSQ/82k?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37dd298-d527-4843-37af-08de1764a3c7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 03:30:15.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0tkITHVcKqxlUV5XXgUl3eCL1Tax8CUj6ehypECNYPCgkUnSBCwo4M5VGsMh7E28kA68n1I30OzAARRGhPv4Khky84QvhRgu/H3xbFgJ+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7655

This patch series introduces support for the Agilex5 service layer driver
(SVC) in the Linux kernel. The changes span across device tree bindings,
platform DTS files, and the Stratix10 SVC firmware driver.

These changes are necessary to enable firmware communication on Agilex5
SoCs via the SVC interface, similar to existing support for Stratix10 and
Agilex platforms.

Although Agilex5 shares architectural similarities with Agilex, there are
key differences in firmware interface behavior and hardware configuration
that necessitate a distinct compatible string. Using "intel,agilex5-svc"
allows the kernel to correctly identify and handle Agilex5-specific SVC
operations, ensuring proper initialization and future extensibility without
conflating it with Agilex or Stratix10 platforms.

---
Changes in v2:
	- Add driver changes for Agilex5-svc compatible
	- Add cover letter for the series
---
Khairul Anuar Romli (3):
  dt-bindings: firmware: Add Agilex5 SVC compatible string
  arm64: dts: intel: Add Agilex5 SVC node with memory region
  firmware: stratix10-svc: add the compatible value for Agilex5

 .../devicetree/bindings/firmware/intel,stratix10-svc.yaml | 1 +
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi            | 8 ++++++++
 drivers/firmware/stratix10-svc.c                          | 1 +
 3 files changed, 10 insertions(+)

-- 
2.43.7


