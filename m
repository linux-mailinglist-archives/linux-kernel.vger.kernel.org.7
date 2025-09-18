Return-Path: <linux-kernel+bounces-822315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FBB83848
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A530E1BC5382
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08EA2F3C39;
	Thu, 18 Sep 2025 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Mzd+OQZx"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F32253A1;
	Thu, 18 Sep 2025 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184198; cv=fail; b=Ndu8zbjIWv8nPdvaDMW70X3lbUe1kQm9LAZKuKLhMfrayaoWF5s5YQScdvScetjmXUmSpt5Uks9JyRwkZHFdPslz1DW6SBGw9ifi+lAScRZiNXUFjZ51veYNVYwPLdZXF9X0HZ2jxmNTDRsNZXOMg36Kb5hQ2fYGFIeaVQVviX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184198; c=relaxed/simple;
	bh=GTLhTRE12DtvX3JbyR3cjTwc69PjA46g67qT+jOF608=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jBzQRm9Ixr4q1eAl5mmQvxMvca3hea6QbSjrenx4p1nvBWlGwTv3fK9hNCMHKipc61F/D1wLyOiP3+Y1ngh/ShZ7u12Ph8AZ6YC5oQH36kTLpr/H4BTwhQYQzQMjVOzFIBu60FAThzlU9qGWrZw9adLkTp8mLGDexAh8R+o8Ld8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Mzd+OQZx; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1zsNLtG/1lsYiYyzAe8QqzsYTae0HuYGDYbEuLgRvrKF1kDxm8Fso45fYtwTq72N4re+yOkCQQu/gP0nSDKfEBmwl2pBqtrky2aw23go8yZWPfY4x1WdChsjwLl8MrDF8FbdYYSqkD7yEBK+YbWw8GAYkf1XMDZBm45+7mX8c4UI6x0/Ucd5kD8IHVddlEdJD+/bjlzirOav9jT8Qha80CAswbAFvoK9lY8u9iV9y9LgYGjSah07EdjF9yLtR8vsv7ZEQvhLJ+8oHnkXGlJwFDk3zYgBZy8r4hmWHL3HgqxOqowdr0Qiny/AaSAnUfpS1HtFzmvgexYo9e8JoxBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CSw51gPDhLvYysySFDwNskNYVwrnFNk4nZweUi3cbQ=;
 b=KFnojsp7u2Q6goHWoTVQef0C+VitBmu6vcknDgphXxjLLcFmjFgPRw+6TnlFEBd9RIIEcg0CkRB6AOjewrBpjbeOKodNet9tweOTdMH1NwkOhfvbpp8Q66ZHmq9YrRG64zCKlA0LcID8tdrf/sIK/xMGpvFvxyARgF3O90DVhGQYC6uOs8wMfMpoYWasi9/VPkWEgEBdJJ21veKiAVH6KJHprXZWGXRjkjhyAL7hooR1uuqXvKyO9OrFI46Wmzaii+T4Wv1txuDsjdc5KEQVQTgERXCQJxRrMbcnsjDDYXNSOz3M4cBaHPZ7F8IkPX9iXZbphK0JYnA27uOgr+H9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CSw51gPDhLvYysySFDwNskNYVwrnFNk4nZweUi3cbQ=;
 b=Mzd+OQZxMb44CZKPy8Yc5ujrqmgZp/aJUTrgZwihp+PwnrtY+yW7lAgBcwwkUtv5B0aEiYKxk4g2UUwvaH2meYXUMwi5gE1nbdYYVkvWYy0HMSH4y988MveqNCnpYxr0PnHAcKLp5qe/neW/9MHLGISHOz2wWm5XRpqMALUREmN20uAdzRSS9qyqXz/fMEZYwp7mAIb0LfBVUJyAVmmzuYimCqQojLvwx+vvSA+jpbPOLvH3fyifgpNL/agjpnwrPgo/7zXivvHF/7ajAkB0aqo1o7EozoUCuFvGuO0kwMdpxEUY4mAArPO2nJJ2YMMEYd8en7H/vHKbsvxfRX+WVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 08:29:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:29:52 +0000
Date: Thu, 18 Sep 2025 17:41:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] arm64: dts: freescale: imx93-phyboard-nash: Add USB
 vbus regulators
Message-ID: <20250918094130.GB9196@nxa18884-linux.ap.freescale.net>
References: <20250916080635.1520551-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916080635.1520551-1-primoz.fiser@norik.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f24907b-cb5b-41f6-92f3-08ddf68d89f3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QNfn4g8hCGswddp18w93ETUXhYqNYX333SZB0baXZG4miD5IDUKoK4FTJ943?=
 =?us-ascii?Q?YHwHIf78B+5w5tlQdiFXYpc8GkhtuQzfnnHM4qFHp2qgMrcuZz14y4cuUxJ4?=
 =?us-ascii?Q?7vwpsqDlH553Vc2ujZKSJ9sE1kKHKRYt8buSR3MAWQIZAh/xSSFtTjCOFY5d?=
 =?us-ascii?Q?Qujr1btkxEUGIlen6c+/VxiCLIfkzfY5WO92IU8+AyRw+t5rDNdnZhpollbT?=
 =?us-ascii?Q?B2R3dFqpeXuAyErSfIJ1K1pk0tZTuddwOH2MmMkBDu/CtyW8//Hs2FH8whq3?=
 =?us-ascii?Q?t4Oeb24Hd8hDuMgge4T3vrT3elZP1lFi5te8xbYKpdMMcwXIIfocI/vDFG4j?=
 =?us-ascii?Q?cfhWR14CF14/xV7Ncr+TziZepI93T11L2eH0uFtAnA1suH8wqm1xLeXcW3Sg?=
 =?us-ascii?Q?GJz4TZ6JkKNlV+t+P25u2CASk2jVo/nmytaqXFwp4sZziBa3fS+nn4FfXBeX?=
 =?us-ascii?Q?Y9NJs0El5N5VPTjuZQ73FfxAzcR9z9m6/YeB0uAWWNyQSyYqDArtzVZ3BUTW?=
 =?us-ascii?Q?tDdPNmq97JOqQYfmZ9rMjJAA2QNwpc9eXx17gVaHJsL4qx/sYwUiPE2EIDL6?=
 =?us-ascii?Q?MKncIyq254up/mk7dNjkdnODhCTcxM/tGp0Q1rDBamOay/aa6dN2HuKqYAMp?=
 =?us-ascii?Q?GG2Xata5034brwrhp9JNX8Hauu7POep567DkE8rTwWgUCdgZqy58ZPOj8tUz?=
 =?us-ascii?Q?fv8HoM+4hTNUMFB9h0zd8F6g9Hmn0RGOFoLpY7cimSHqmbaXjFrTyhqpLEVL?=
 =?us-ascii?Q?1ZnAoxNZAZktVmokXQavsObhvHioi2jrE/9Xd9ukLAeT+F24vsCJ4oCL4MIa?=
 =?us-ascii?Q?WpvbWJH24x3prLsv+Uiro2Vu0m1RjR8AdE3qmUeplhT5uoXPcGhrLnAMm0Wq?=
 =?us-ascii?Q?ZK4Fw2BxQtBYarBVj73ln8DXkeKThqwXq0Na0j/jf3jkf1J+uPxREJuyL0fM?=
 =?us-ascii?Q?qMZM2MT88tjKfFvUqmQYqlpGy/2YQDW9v+bfcHGOV6UmQJqmkJQJqVMQi+e8?=
 =?us-ascii?Q?JvBTId8lBEqYsIhGm08gqINGtzf2BPwGR+yD4uKP878YIRIrlhB8ZdHiCne4?=
 =?us-ascii?Q?44KmZacS0+ZkDg3bBn1pYqAdHDOIQRSfNsOYhKvKdXr4SwUMbyYFtjZRmwqD?=
 =?us-ascii?Q?JDQb0Cq9qObKx0EITbuHnngp6aixcLgxlY296tf04cgwOgYoFes205wwUpD7?=
 =?us-ascii?Q?migSPWl+x3CAbcpXVuBPhbxMxsjofmcwUFNCg8IbOi4F1exyTH33T3Ekt7fg?=
 =?us-ascii?Q?xHFXqOU0IfwGE4/QBLltVmaL6fI/aSlHydiVAncRiJgy+aGEyvQ9jd6sEWA4?=
 =?us-ascii?Q?aNpZf4+CFuuq3RvlewU/u2FHufQNZUpqK8qXH3nZ3sqw//f7IbvoJ6Z7Hb85?=
 =?us-ascii?Q?GZCeqKnkkmu61phyHOrb6bNvHSmCc32/XS/gy40MV4wHWRpqw0I7RRECLAWg?=
 =?us-ascii?Q?/FUF9ttcWdVjMeVdVgfnVWDq42QLNygDuSzEMgSNcWMa25ipLxehNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ANpKvdFRpVMsWqUFHWi4J8KdyZ2IOKeBCSNkaWpYOWqiY/3SsQwKbIlyftW3?=
 =?us-ascii?Q?u8emEWS/WHj9zgIWQ34bIjaIAc7Lm68bnmR0BOtHdBBuac2h8XRCzOO/Zpt1?=
 =?us-ascii?Q?571Fh/PGx89cbZWMK8vV5SMZQfCELeQgVuMlW0MOPGgEn3GhcsiXHRlirWaT?=
 =?us-ascii?Q?EvEatUBIh3jktO+FiKfuNzeVu1CBwb4q2VtHxUXe/Cc8IM8gc/rBmePQBWl3?=
 =?us-ascii?Q?4m4yxOIzVttvWjDG1lvT5ykq4Cj2FSIMHwxM85RApTByAzKLrH8afxZMl8Vj?=
 =?us-ascii?Q?amiYWYz7DULLP1Joqh0TXbktJ0qO7Er4vbvAZVwJcXA2yUfphibJ+/5ILyKT?=
 =?us-ascii?Q?1Og98d0iGPZCBYAjnGHkP2N42MeeSGtNyXGnlDBJfuUhm/oJTTGTA/0cqtNJ?=
 =?us-ascii?Q?VMF2hhVP1FCVOoDJHX2bRRcsJd/JWJBZvyA28rlKE9e5L01OXSqQlryWSYWW?=
 =?us-ascii?Q?O1SI7lbv6Cf2gS9y4UONf6BClfExgISq89cfUQOEezAH/2XFJk+HnY3dzFeb?=
 =?us-ascii?Q?rU8+wTxndyyAJ/xs4GOCiVDXSd2wtTv/1O5bG0jLaUFpa6sS/E7qVXAQyDol?=
 =?us-ascii?Q?q4mbCXUr/8aoJclksuNhLn/0I2pvn6Jj0+xyUlZV/XbGVa/OGDHVomus4Sz1?=
 =?us-ascii?Q?1Pt5F9A342X8N9GoYXODydHFGCmouRdAzRlPR5NbiXanxjzYN5/pcKbGwaDI?=
 =?us-ascii?Q?VwYju1lz5fuzBnJnBd+lL2Qx4wDnLvJDqH5D/WmSjaUlAHNfgMwFR0uItRkv?=
 =?us-ascii?Q?Z5C7K9iGKS6kExK08eOJieyJ22mYd/3G5Opd4Ej3xiwi4/nlh6M0HFVUzjH1?=
 =?us-ascii?Q?fANL1OGfRSCx+ceGCNbWc+R6cO/cZ9Hj+TiB4Pi5r6/4URT4nOLK+mc4NiDV?=
 =?us-ascii?Q?skGy+HHWsoxJbz7W5W9uIgWbsOWK5Ygb28adu47OAhiKpb5uHAEkCgbqFcYc?=
 =?us-ascii?Q?6JZL+SkQObHJ+cwGg24YDmLWhQy4k4ycN+HPtC/55RDL56h3hR1894/0O7FX?=
 =?us-ascii?Q?domPlegzOabyf67elfaB/HDDjzCa7b7Whaouflxt7HJyq/rkl2KQnzWo5nOa?=
 =?us-ascii?Q?GN6MJnE7eTKC+lseIhWFNxHpdB+RKEjMXlvzh3ay0p25Zg0Bi5x0p2zkEzIP?=
 =?us-ascii?Q?Va663Fppn9uOpXwqwp2qr8BlkGdo0pAtA0WXrQSAdaQfgFdUHz09P/Gp8zoR?=
 =?us-ascii?Q?LGwgBrifT9b7IxNU1b5ZpmXknK/27/YrSyV88aUPFAP3YOOjEFh+c3Ebts9J?=
 =?us-ascii?Q?oGVprQiOIgshon6F2mAk8NhvKEMtIzKTWvw9oi5LPb5UrajIpJSyDkJWz0t4?=
 =?us-ascii?Q?gWeFxSspi0+xpvPABx1qILD8yRZjyjGuM70sm4Tj2TaCnahBtXgEWHyFwmCe?=
 =?us-ascii?Q?MG65jUJ6yXiP7QbS3UpHRSsqs86VA1Etg5M4/XkBWaqYGEf8IpPHWL8c3WwF?=
 =?us-ascii?Q?N5jRrBl/6uKw0o69RgxHYr8IKtnrKNJ6kwd60VKRNjwkuzjDN2gFmFQJ1OqP?=
 =?us-ascii?Q?SfCnlXm9ezT/RHjKhUWTXZmqe5mgs0N2fVALhU8/wuuaWqizmoLcEC8YEcvl?=
 =?us-ascii?Q?7s4xdz1dV56gOv96vqHvGP7u5dMhGrvqgIKaulcT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f24907b-cb5b-41f6-92f3-08ddf68d89f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:29:52.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJbCFhHjt6IJJqe3vCiS9LuKS2msgFZBKWy67FV/jH/kZtrGkNZLNDpSeIv+wxAJ19qaeg15ckQ/CRyAMo5eRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910

On Tue, Sep 16, 2025 at 10:06:34AM +0200, Primoz Fiser wrote:
>Add USB vbus regulators to silence the following kernel warnings:
>
>  usb_phy_generic usbphynop1: dummy supplies not allowed for exclusive requests (id=vbus)
>  usb_phy_generic usbphynop2: dummy supplies not allowed for exclusive requests (id=vbus)
>
>Because generic USB PHY driver requires exclusive vbus regulators since
>commit 75fd6485ccce ("usb: phy: generic: Get the vbus supply").
>
>Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

