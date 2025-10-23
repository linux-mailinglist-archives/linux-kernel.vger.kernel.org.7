Return-Path: <linux-kernel+bounces-867062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA5EC0178C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C66D035A973
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F318832F76D;
	Thu, 23 Oct 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="alqrEbsi"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AC30216A;
	Thu, 23 Oct 2025 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226565; cv=fail; b=cwL71djMnCb9smUQYyJbKaSylDoYQ7TFrFrCzY0ycVCd4HyOtY9KF8bfCJ4cqae15DzpEW6X4JrGM2yEQZwvyFwsqa46WZ7axW1xwGfsdF0nPnCmH2WLe+HzwqYXu4njwkkM7Pz9drjk5PUmJq9W2hnzc8zvM7rUmFq/eanSJxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226565; c=relaxed/simple;
	bh=7GhYHM0oxHtRuJk6RrhxWIUBR+iAJcUfhrQwqQ3L2dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VJmdnPQfpc+CzKXjwYps4KzJl0+wwpmluA0J17abcn984kcmq3oRoU4TMmuZBtVWnuTJgyduJ4qaLNcdVD1j5HkH1gEHaybEBAExLLN7HHzzfSw5Ktiv5KXgaOW+LXgHyOSdOdwpoKjiipv65D0tuOISAiCU1lf75JtbIAm6JDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=alqrEbsi; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukBKU+hn7cPrZI4BgaebM2eL4hbkrzlnzXca786vXlr9gU1xWcwUyeLGC84nf7C0w9C+Ok3PZyKLt7rQriHO42hStnOwsx8rDdTONGShxzWj1K70Tnba5kaAwspgrFQ0h5Wjw/WqwrvT+katlji5ZqGi/K4qA99kvEr9iXGb2zD/bna0CU+lCa+Hj4c2BF+EqZpMmBEDMxPiJ9SNYQl0zQ3fltFB+AnD/j2qcqfjVqlmRLcIG94kEF28gWapbIjPol/Q2/sqOQqrO6EgHG9WnSkWRPRut0U+cvHwVA4HGE+nORLE7lrClinVjH4HMBrR+TbcC4+lJ+noNWmkuLG+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYouTR+mfG7sK85De1elb+3tZ3e95fN+GxvbaC2bu/A=;
 b=jAeP35qTBOmRtXjOaWRdj9e1PykjFBUaaJurokhB4Hr8E64XgwtKJbiVAkNyI0Fl50Iji43EUpVk+Bp91oJP/GysvXpF72MczoGjiv/ZVKleiVaZotf+rbYkm9EsacKkHA46HwoP4VXTgnM/6xYMCWXapdNGVVaW+rN2HOQTWPQ4lPe30VYElqyZ8rnLes9+zyjDn63E6hWBpfzxHSk37xL3uSiXV8iRgfKNnJaV/ClXfntDTO9xhKm3SfyHQHbm5c+Bpxb/0gXulcs7iWMWmciErPf+O/DiFmOiMsJOkLWXYsNGOIbfep76qhKvXiA0ofNCfxrkgPP+sErxk6e9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYouTR+mfG7sK85De1elb+3tZ3e95fN+GxvbaC2bu/A=;
 b=alqrEbsiQJabkGzmRZHzEWbc4eaqDYj1mmdfn8wVmCAYE5zc/tzvOzSbY8ayaadblZbaBOcxkKxjGQ+YsdNolRGp92ehtbhUSrgpFVTwY/nMNo/Ti/X50JXLYjdf00LA6UeUuLbe85xkt1CMKYhB3R//PrzUva5Orz8U7Wq8Nu/P3XELZvMHQAEOqAeWMn9H5aW3OewtxMjtljezeWztrBBClWG/HB0G6pYDq+gitGMvLre4z00MMiby768iM5FqzMyAy14r0K893ZJYRQiZRBpqm4ogMVQyIH+LUqJaEgl/DJmH8j/TtYvd8dD3bqKTNg2ONctxLi2pcMuY+T4pJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10282.eurprd04.prod.outlook.com (2603:10a6:102:464::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 13:35:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 13:35:58 +0000
Date: Thu, 23 Oct 2025 22:48:00 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Brian Masney <bmasney@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 6/6] clk: scmi: Add i.MX95 OEM extension support for
 SCMI clock driver
Message-ID: <20251023144759.GA29334@nxa18884-linux.ap.freescale.net>
References: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
 <20251009-clk-ssc-v5-1-v5-6-d6447d76171e@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-clk-ssc-v5-1-v5-6-d6447d76171e@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10282:EE_
X-MS-Office365-Filtering-Correlation-Id: cd18a66b-d0f7-47bc-97c6-08de12391952
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVocAV4dK4LETo+LmbZY6cXl1vcXYiwWZAYeUXyYtfdZrKgJ3azpUifwalNc?=
 =?us-ascii?Q?kIJntmUwYox92S+NTGqd384W8l3SDkr8Btf5oNZYmkwtvtVJe7/62bEWjXDo?=
 =?us-ascii?Q?9i7h7aX7Zqc7ockF/XeJbn8GeeAY1Qk/zvgRTQQ6SQy41ExAzS95eN0bWRDU?=
 =?us-ascii?Q?xff7Hpp0p2EKOj2MFoDDjWvDne5MsApXL5NP68W3nPWRTG0OiFz6zZCl8dnv?=
 =?us-ascii?Q?03kLeibHUS23Xv9jQSDJS1hFcEQrW8+N6ij4UvmNmWDZxDoKXtwQA/H/IKug?=
 =?us-ascii?Q?KAavq1HgeuD2EVTwlhYLeYOOqY7NJQn54PefzT+9qbgCepUOeSBDBrDzjjq9?=
 =?us-ascii?Q?qbbAnoFOHB+CBMQdi24JGhLyka/0P4IT2bM7dpGWEBCuZAmnb4E13XlNstw6?=
 =?us-ascii?Q?1N4NLgQoT4OmBOTmK/ZXTPfIV46GiJ9IBTc4deaHGUOubmy03l3WZaogPDon?=
 =?us-ascii?Q?bzKwERz4j52Dn6GFKc+0IzioS4cA6twObezECCDl/NL1Pnxiyr53Fsvsa3nb?=
 =?us-ascii?Q?fFdFmPCWfYg1fLHqG8PDrEzW/v73VvmD9wOuWHtYmFVKmDYZFAinVVM6y+Vu?=
 =?us-ascii?Q?XuPfV2QBaUb/+aarcczuArYIXHiE0mqM3IHRbb0c3/C7HoeK2ohG8r62T6fy?=
 =?us-ascii?Q?j7lXyyE8JJN8nUXaKkWyk7CrJysbAvi/OyjEudGEzUYNqR2wzOuzI7AXKchv?=
 =?us-ascii?Q?P00SP0W4kPzcjELvBQC1x/Yd5Qaexpu5pg+Z9wv2vXui+cxPCdqv/vySF2/G?=
 =?us-ascii?Q?LnXFgkC98Q4zFdi0p1xzTv6i+udxLUle++grQLgCaGWAcA3y5KxD8CYufJTE?=
 =?us-ascii?Q?L3aw9RpHm4GUJ4FZE+gO7Q8HNGI+PX6ayjsxG/dxPsbuXB3+uA24GehBGJ+i?=
 =?us-ascii?Q?LQNQN4InlHIOQPsAitGxy9ISNsYRzjdHTDkG3CxED0IEEy5deftGv1kBKVEB?=
 =?us-ascii?Q?ywPhsN/rG4Dv/zbQKsrhphNdhBD61IGx5o+XCJUtYYXjw4cg+lUghDzuOzrP?=
 =?us-ascii?Q?8ZKT78ayFJyGzrikDLf5n54eEtF7gT3I/KA5IVZvKtxTvHK2O2OX+Ysx1um2?=
 =?us-ascii?Q?tdE3D1aL6GQlNpgQSv4BqVkMYQvZRtWft1Wfp85OFaizGF+Nbwm+FeeQgF5g?=
 =?us-ascii?Q?VSsXlI3DIS1mc4mIJCO3AAlLUtIM72hUvRJi29ePBrp6eOhD8sKkriOZUm8N?=
 =?us-ascii?Q?UwK0/3tw357rPPJxUGjA8MLCjJO4ZQkylLW6Ysr4xaPrDVR0LuYSmT4KZ0ZE?=
 =?us-ascii?Q?Wufn/8ZFN3+nTwcCayyMgf+d0zr7bEwOMZuP+2Hq9UvmkeSSGnWpNeFf8FU2?=
 =?us-ascii?Q?jvLYIGwfQK0HmCX2VYijyPXXuWzx5hYvq1ftydcaaDUBuGiCAukv/paos0Ez?=
 =?us-ascii?Q?ZopDPOVpjJhYDpid1c1J7ioeYow3r8IopkMMepKDJVipQ/b8Wd2+a5uIDg7O?=
 =?us-ascii?Q?6BIQOqy9E11tzcwgbrmIXP3lX5meLzXz8QlpsCYkdDJTDK9ijs5ApqLo9YCv?=
 =?us-ascii?Q?/Q3lIicY4AqtWJ875IlU9tZ5a01mp0+4vwQw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OA4afWaPZBuwW8evqXqELWceiDsn72/W5+OcpsB1Wz+dT2TKsvyVUvwXY5VK?=
 =?us-ascii?Q?r+VV5xRVP1Rsk1jaSSVh0HySDwhDwpEYD/sikH84DBSGQtVd5tyXLruuzrRY?=
 =?us-ascii?Q?H4h/gQQ1OA+Zi7eDfPfYzjBAGOcedDhygMN561o2rI2Jn4dLWNtLkJcSQvZo?=
 =?us-ascii?Q?1ZO5GK0SweF7nAx9vX3Nh9faXL4vmn9eKTdtJeaZd6YDsYIgp8dufQ5aTud1?=
 =?us-ascii?Q?KaHBtpONYvPgxwo9hf/5uqdOBWfed6/DOpPLXVer4umR0jhTn6ZrTKp0hLzT?=
 =?us-ascii?Q?vXP6OjX9IXitaeKRZ/c2W3ymC6n2lO3wfRrHRPUvvn3exSzhlkEw7Wgw+aDd?=
 =?us-ascii?Q?oLRPFO/XMO/hJ00ZPWyP4cHdJYbZHDRPc5L9jKcFbY/t005DmDGa3Wnj8OA2?=
 =?us-ascii?Q?yw0w5Q5Hzt9/I6jyM0RuiKRwbOba611DWAt6w4MEjeBhkyzNo2MxjszY9G35?=
 =?us-ascii?Q?fZX8W2KybyfeVBxuwddKH2Yd/fkGRzKRSmsvxvDbhV2XYHiJcZ0oozLQgtsU?=
 =?us-ascii?Q?H6M4MUU0kPJ+V2UKEN3kPII2f4hvLgtOBHy4eZ9bBR5wl5WzQbSy/jxAooJP?=
 =?us-ascii?Q?k3rctW/7+zMo/tRYD3rA/ORgMbmbBoYUM7Tbylb3xKU87Kzwyd4t+YMwX1ny?=
 =?us-ascii?Q?cnYQ8vN8j2meghuZjeMdg5XMBc70qOXbqZN6vAmTwBHxOkW2bFOENtcOEECF?=
 =?us-ascii?Q?doEJIS/a5kSFnW4cUP14C2FtDhRzY+b5MJngVSf43FMHuw0BRJxkNsIpqzZU?=
 =?us-ascii?Q?ux1NFI5UTNlW0ZXFNT2CQQOsFgb4yadwXfE8NY6u1YS88WawVHP+SxataVvC?=
 =?us-ascii?Q?i2dSRNO1wuo+x/LsNZm58QYaz/91VxpuHJS3/0VeDursiP445cr+/uxGXz5c?=
 =?us-ascii?Q?vaWyjMGBfq7IvIjcWVlYUNo0PObMeMr5HSErr0Y5l/jS4bD/Ut0q1V60ON6i?=
 =?us-ascii?Q?XY1H6fIVBNRHgFjyyAdnytvOP8BMLXmqjhhzGxNDxYyo5WgI+rN2fcoXYe+F?=
 =?us-ascii?Q?LUxQMsfzmKbVH7CgsftuHrB3zxuvmAlucfID2lTxdkacEbGspOrDrPQWU2Ug?=
 =?us-ascii?Q?ajaL1W/Opev6swWRwEhHoT3/FbKNgAXd1j/0PlTdmn2lJPFOD9Dy4eIiWBxn?=
 =?us-ascii?Q?1w64MShig3nJz707kpSdIZss5YgpmOtUhSy+FqVsgTI/hP0A0p1sMnS2E/kX?=
 =?us-ascii?Q?uHbXowz6k7ZKnO1fGs+BqRvIWqPzKqDOxqPAzmUHGB7oA3mRYVd+8zESJKwx?=
 =?us-ascii?Q?ueT1wAP9aTT9x93nVE2LtXv5VEhp/T4PbkU24UTXKPpAZc2nViHb6NuydTuK?=
 =?us-ascii?Q?4NgQTOXh+35ZW6nh5EB3foO/HPr+aGWdA1dNREYTkgTo8JIXafor7vcBC3PG?=
 =?us-ascii?Q?HMVMFNxSeMHH7mN7P7eWHuCIOAxmre8cBmKpVNb5kyzjfTpN/PhO3wJqzR0v?=
 =?us-ascii?Q?tKnmc62ZM/H0QtFs0qwc/SlsSOA4Z7tY0sec6x3qahq8bCtu8PZ5TZcRSTF9?=
 =?us-ascii?Q?xFSslZuhxUv1VTgW9J4eV8HVwt+Z6aBo8Ohpu9Ozib3XA7FPaVMN/yRjC4JL?=
 =?us-ascii?Q?1U9MeeqAKD+b7ne88loZrC8S+9SwT0ld5W888rF3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd18a66b-d0f7-47bc-97c6-08de12391952
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 13:35:58.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYq/bRZCgHisBQ5nvVSxGLQ4IBj190WDV9y+gWT1i8Rz6pI/51E4WSowJ/44LXq9v00OILRGsXWN1HXc9PDhhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10282

Hi All,

On Thu, Oct 09, 2025 at 11:48:19AM +0800, Peng Fan wrote:
> - Introduce 'clk-scmi-oem.c' to support vendor-specific OEM extensions
>   for the SCMI clock driver, allows clean integration of vendor-specific
>   features without impacting the core SCMI clock driver logic.
> - Extend 'clk-scmi.h' with 'scmi_clk_oem' structure and related declarations.
> - Initialize OEM extensions via 'scmi_clk_oem_init()'.
> - Support querying OEM-specific features and setting spread spectrum.
> - Pass 'scmi_device' to 'scmi_clk_ops_select()' for OEM data access.

Just would like to request your feedback regarding the SCMI clock driver OEM
extension. I'd appreciate any feedback or suggestions you might have.

Thanks,
Peng

