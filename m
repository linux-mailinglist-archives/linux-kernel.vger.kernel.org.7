Return-Path: <linux-kernel+bounces-723259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B25EAFE514
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235B45A19B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7969528A719;
	Wed,  9 Jul 2025 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="HVBkhPig"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E330328A3EF;
	Wed,  9 Jul 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055453; cv=fail; b=T/k88tN+boYrNkH0JQEZlU4AIRVR9fx15oMdVTuz7gpP240Rxh7qMTavHiEkgGIJ6fOOmvk2LlF8/x4eUiRcZMdkovBFSUmUJYRWpIj4hWM9cbODyZq8qDvoSTcZ82A4YWitZgcT6QWbhwQIv2ffNoVCokXuso83bBFTMBF+95s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055453; c=relaxed/simple;
	bh=MTJ4sG9YFto8xkpl2ZCdG+Dvef7uYHJfMaSUnWTCWNo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BJn6Q0T2ywY54JYDYQBHvPqJ9bH43rMvU3bYk/8z6Gc384RDeeWgKa5ohElmIcTOHS9GGGvddrf1emielqDLfeBB/NzV8gMojzgVMh05simBq2tJEZWMnJEVhhmz0qELRfVZcuk6Cd52cSF/TlfJ1UL4GY6NudWbp2AxUhLjKmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=HVBkhPig; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcvVAr5aZRh+yidWdm3cOw3Bid6VexRxPCSzBWvfzx67vqfarY8UCq3HOsDeZThBSyN+W09aeWpht9IM+8dqeZdmKozjPjUuimQZyUN+EjYppeuc4Crl0QfJYvS4qAeJURygWuxM2aVgiRXPkZyEsEcNaqu5j2fzPbPZBIDH4pmqIrlBL5sIbS5VNWa/EjIzEMBqQtLTrAtvdde6ikcPftk8Cb4aKpZh+DC05R4axLFgJrpGiYvA2K+ISIk5NbngJeRDB8KEwYceJTx2UWhPiIBsgqW3JLjR0EDvhaheO2KT+7/q89IYT0FX0wMK/v5Wi28fOzqNU5GUd9/We5Zu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmqWynWCLyfVYNvOKfm4T4uf+EKFob2hnud4dBR6bCk=;
 b=eLIf1gS6Ijy7kMFJshWJqeFjQbVhdLCTNOZCClVtpwC40L7xh7kUflasBcmrteMIkS1cCCnVZcpJi8yUO2AslS6ROTEgk+ezVuAMpDdv4UX3oHWhKT/rSCU6z5VdYf3p5BJpjaHiuoOyLnAjLnctsGbYWF3Oes36xFInQAiVQEjzNoOI2ny4l45PeyJJ5L53lYlML1z06l8743IE+Fvf2fwUhy6sF6WG+mvKzNKkOQszauAldmaiHdJMl2CTR3NgpOcdK8xKIwa98rXMPuq6hhIMMfZGALjsM+J8MWXsrgY3C800OTQwOpoZJ09UQ0pVxNLtM0CXlkR/f6TRWjrPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmqWynWCLyfVYNvOKfm4T4uf+EKFob2hnud4dBR6bCk=;
 b=HVBkhPigTagqBKXj/QhOZr0GXHK1ZT6CJ80INUgjBfvEnsuXB/KmQb1APLzLeIcIjL0tyWX8z0oR8JydCo+FNOVclZDpaCEYjLEkn4zfTZLvrI/bbf/vpkAxfJ+I2vtVNzNYVRoICzXshCBiknsxw+Wb/ZFBu8yXDaxbYbLQi8/VMjxQyCAKn4ZtHAQaA617wTfykLM9gr6bUXpzNZyrknmRekAyABoMdUccOxE735Kbd8JtobLkGN7VvTIZhWXtEPIPkhQ48qrBL5MZf7GgtOMZZTXUGSbb0OXYTNlYj3dukVfSilOdjOVsVN25k++/pepU+1GcTxYqiTynANZm5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com (2603:10a6:10:2f2::12)
 by GV1PR03MB10584.eurprd03.prod.outlook.com (2603:10a6:150:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 10:04:01 +0000
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com
 ([fe80::a4:d971:86e0:ff72]) by DU2PR03MB8123.eurprd03.prod.outlook.com
 ([fe80::a4:d971:86e0:ff72%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:04:00 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wojciech Dubowik <wojciech.dubowik@mt.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Markus Niebel <Markus.Niebel@tq-group.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Heiko Schocher <hs@denx.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andre Przywara <andre.przywara@arm.com>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Junhao Xie <bigfoot@classfun.cn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/4] Support i.MX8MM Mettler Toledo Snowflake board
Date: Wed,  9 Jul 2025 12:03:23 +0200
Message-ID: <20250709100341.1492456-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0084.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::8) To DU2PR03MB8123.eurprd03.prod.outlook.com
 (2603:10a6:10:2f2::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR03MB8123:EE_|GV1PR03MB10584:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa20f3d-8880-4bad-dd94-08ddbecfed67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yGoA6G2cmO2Kgj2sMcd8MIIcbcegqxv1V53GrNgoM5sT9af+U25VtbsSPpA0?=
 =?us-ascii?Q?7Fr9UKTTiJWfSVzutHNCKnmQBxQ7/tjRNqMcfmeITljOl5gviIB2I/SFKoGH?=
 =?us-ascii?Q?zzVkg1WquoK1xqkDRXQmJx7/FxJXGIMYwKCxF9YpmyIu9NjCTabwRQC3m00f?=
 =?us-ascii?Q?3m663Z730cH5P67vuVgo6YQOeGuNSx+9L+teKP7bDu1//dQcFbPxtbWYCna1?=
 =?us-ascii?Q?mptGsHox3f1j2fCjG+GkLgQw24FVwGlPFUk5sPl7tm3n2hTYCsmGhLVe0WJv?=
 =?us-ascii?Q?zjrbSo/WHSxe/l/rAwT+YrhhUGyV+QSwvOAkE2QIw9IRPLvT9LVUmtrYTdbG?=
 =?us-ascii?Q?iHTxJCx8CADsJUrpRG2UURdskWs0KjExzraH3I7Z0BvSj23cY/pur9Y+bB10?=
 =?us-ascii?Q?/PDxXLP1Xud5tPPwMQYUdycAkyQzQ/DWArlIfJ67mfbDOBaSBU31nUR20I+F?=
 =?us-ascii?Q?AZOWr6wjwsO13du+E8jbH/i7gpmG9Sp1KWGNbnVswUtrPhFn9EXwSL201QjF?=
 =?us-ascii?Q?YQUPHoNje53tVTqxWEAT7KwXTEWipVZ19MHfvXG+V5ngiwRiQHBRZmHFagR4?=
 =?us-ascii?Q?ZAPLnSDgG/tqANlti47EaFZZqJ0Lck/J3uZMN2NHVP/Lw4zE9XOib32V1GNo?=
 =?us-ascii?Q?jWPZpUWl+5PWpDbwV+GLOp1BsTUw9Nc4ckA4b/3DGv9fod4ihzdyWm33GHpN?=
 =?us-ascii?Q?tSnlfxEbENvsCvblAh0b3XmKbeGcOPmJmjptSB/OrstmaqvkoCeLeO5ts4Wt?=
 =?us-ascii?Q?jdtgXUdCql70rZwwoYoi2vNnWVO7+mmokivGj9KFmCZiVAhF8hAfkTpgZJuh?=
 =?us-ascii?Q?22zy46wu39LKrAT8joOPxjTw67AmNweMg5i+TObrD6+PV2vwdbs8WSvbOhd2?=
 =?us-ascii?Q?Te5lYBJF+9grA6atf9cKoAOHOjCbJwdgj+o3qaRif0T0W844zcdRoPySEuDV?=
 =?us-ascii?Q?LlZKbEhAQFkJo6mlbRJOp+7E9yV4f2wS/kssKwdYN/88yKjYsiLXUYwTKy41?=
 =?us-ascii?Q?8kcyqCOh4K+QU5+leTs7Vb7cJfeEuaDq6kQxAQmMe/5cPtZ68o5x2gfMc2UH?=
 =?us-ascii?Q?ij9xhcyGr1j+gIB7pKc4qCk5QS2JYop9oufSHE+arbqw32AiBGT3jYnS+Ns8?=
 =?us-ascii?Q?BWl5KuE7ltdfwjgXC2nl0fwm3sHEFb1rN2BzbLX/VGRM5D1c/4/Wcq/ed84W?=
 =?us-ascii?Q?/BgFuatwExyelvirZrM3B6rxw8GQ599bAsX3Rxd21HqRgxJ1SfWrsCrCSr6M?=
 =?us-ascii?Q?zLlZE0hJtlfuE5+TQ+YklKToQXAKIzUxyV8DRDBByE63djisQN1vGOKz3sXl?=
 =?us-ascii?Q?MWEdNf6nCqQDkgfdVLlxhav2UtLFA8WLaWw9uJQ5PFo/bsPispLGmNv4Ne9a?=
 =?us-ascii?Q?Yq4Dd1xNDu/v+KFlM3y5ra/OSW/HfvHZjMtXoTcptiVuGy8EhNnJ0zYaVT5X?=
 =?us-ascii?Q?qxvUwKSp3af4A/OIn6PvngxaRIViBJxu3CjXvPRZwum6V7TJh/NmJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR03MB8123.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOjQxfKwehBVkUQsmpw4l8dK5dCUEeBcV++rK/3dYxKCldYU2c1KWQ2NfAtp?=
 =?us-ascii?Q?BHvub1SNLUfFy+8VvLKMJ06EKm4Q+kc7P6RtwnsDvAFMhJteYw0Mlvq9mBeF?=
 =?us-ascii?Q?CEG0/FVmYvjcPKCfgO+SGT21Q8CX7FvcHSq+KQVaZP06+h7WZ4KBxNwBNkID?=
 =?us-ascii?Q?+cG019ygn9x1W0lg7yVUonrfXuZo0/7cX7wl31U4X4nXL0Uz15j8widpj7uc?=
 =?us-ascii?Q?Dcx9tdaJBCX/Lb4sSy+pQkEJgZIhuEEVGlG9BLDxxtPxdvVxdxJikcgI7GZy?=
 =?us-ascii?Q?qqq7tUJuNjyt0kOjuyLfuLPY8V7ih0OzHCmjVWu2CQNuOriSQDxFBcuhq6i+?=
 =?us-ascii?Q?t4wltKlIdNXBy9vZVpuPxQHN54kmscBbs38kWxuSjUvBkbR2EvZ2qcHxYefQ?=
 =?us-ascii?Q?39goCUXkTIHDT319e26XmkblYuijMwesox9IUMtiyyXcUotaVcr+qmqHwdv+?=
 =?us-ascii?Q?tuQocD5tA+jO7XHnEEx56oo23XWJxLUUfz0OHz9q7MdX4CJVZ4LYb2O49F5s?=
 =?us-ascii?Q?qNv0T8+cRH2CXyKcbezwHUGi22djzZunOHl+yutvrXaTsxTlgJ/0jacJO1qW?=
 =?us-ascii?Q?PccBEGqm9pGhRBwYQtzXMTAjsiqYZYx8j0Otnod99f1TXvruP0VMD5DWHHK/?=
 =?us-ascii?Q?enY0wAHFI9JZO8BAN8UGLT4g9xwSznGMsTWZh50OaejiiJGvIudtnDl0GvVq?=
 =?us-ascii?Q?FbFyf0j0xbNg721ZZdxNAzuwfgVeo6a4OxGroZ5EQ3vR6Er20sxTBNDmXalI?=
 =?us-ascii?Q?PTuSh9hhTSeO3TnDnAa1YLAwJG3ICAK7NGHsfOuAiQskWMpzh7XbJPVYFgEN?=
 =?us-ascii?Q?2xqC8qQtojJJQVoRY16UVRr5zFR9aSSZyfjWeBpnvdjVLMhV79EQBnR+i5Xw?=
 =?us-ascii?Q?S9iQW1nZNHNkcjScmTgfB6xBLZpsmafNSRT6tTkTOuxaC8Pd0mSDVmJZgcub?=
 =?us-ascii?Q?CsNfT9YeScZ1WPKkpw6jlY2aEu6n1Le20a+m9A1P/aytzUcRrXhgbReuXGzM?=
 =?us-ascii?Q?fCsjOjhm+HTxYR0adj0FvpZvgjceotkIo0y5tCWL4G3+hE6X/lVbSXxvJM6K?=
 =?us-ascii?Q?N5Dxq5z9SMYojYAb5SA2z2CgKhCaTCdTtO4+1UgFwRzCtqcbXwHxIcKss7k8?=
 =?us-ascii?Q?uHgkGxNyqQTG2ptO8pRCUKPE7tWzAmHbsh0OhJD7ynFJPVTgjBzfsYZ5ihLY?=
 =?us-ascii?Q?Lync0LHThzAC8KDnlqmuBUsA857cS2djoaQStNcZ7YlMYEf8TefXqDpwy/9M?=
 =?us-ascii?Q?Hm/ojGLZcicM9ozYYgqpwzHl2tjGgb6q8Sl/C2EHGS6vr4brBlgyyyvYVeHY?=
 =?us-ascii?Q?aLwnoPliISiRyYqxrZpf+PxnC8cM9uxNfQoCKXJkguPVOTIBVkaAdQPSyacr?=
 =?us-ascii?Q?nm5UhfQLPDaIZRGiXD0DOihYnJavJq0YghYP5d//UVCeSGwmex6TG9vtW2Pn?=
 =?us-ascii?Q?alH66ufcDHZTeFz/qt7TtkzaqIUfQLU5pEgMDUTpv3xiOMjOpm+u2tWWVKAp?=
 =?us-ascii?Q?SHXJvJGzqso//kJesIGyXLvMXNomvua6EM20489Xo5OpeUcP8ZkH1glR/YnA?=
 =?us-ascii?Q?vlyYExKuKc3FPNW09dG07Zfs0R8i5AVtR+cwVu28?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa20f3d-8880-4bad-dd94-08ddbecfed67
X-MS-Exchange-CrossTenant-AuthSource: DU2PR03MB8123.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:04:00.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DB+gZtATcz0piK95nlbRLX9Jr7/36gqioHIxLZNk64z/wlCf4BPAo50krM7mn1gysygUgY+XCNYrKxP+3GH3Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10584

Add initial support for Mettler-Toledo Snowflake V2 terminal.
The board is using Kontron SL i.MX 8M Mini SoM with 1GB RAM.
  
Supported board features:
* 7" Display with touchscreen
* RS-232
* I2S Audio
* SD-card/eMMC
* USB

Changes in v4:
- remove rest of unneeded status entries missed in v3
  in sound codec and backlight dts nodes

Changes in v3:
- cleanup labels
- remove unneeded status entry

Changes in v2:
- In imx8mm-mt-snowflake-v2:
  - Reformat with dt-format as suggested by Frank Li
- Separate patch for dt-bindings
- Add bindings for Mettler-Toledo vendor prefix
- Add me as a maintainer for MT device tree files

Wojciech Dubowik (4):
  dt-bindings: vendor-prefixes: Add Mettler-Toledo
  dt-bindings: arm: fsl: Add Mettler-Toledo Snowflake V2 board
  arm64: dts: freescale: Add Mettler-Toledo Snowflake V2 support
  MAINTAINERS: Add entry for METTLER TOLEDO BOARD SUPPORT

Wojciech Dubowik (4):
  dt-bindings: vendor-prefixes: Add Mettler-Toledo
  dt-bindings: arm: fsl: Add Mettler-Toledo Snowflake V2 board
  arm64: dts: freescale: Add Mettler-Toledo Snowflake V2 support
  MAINTAINERS: Add entry for METTLER TOLEDO BOARD SUPPORT

 .../devicetree/bindings/arm/fsl.yaml          |   6 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   5 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-mt-snowflake-v2.dts  | 479 ++++++++++++++++++
 5 files changed, 491 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts

-- 
2.47.2


