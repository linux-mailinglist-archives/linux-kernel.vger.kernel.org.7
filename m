Return-Path: <linux-kernel+bounces-785736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61870B35042
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239FA20156D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C916B23B616;
	Tue, 26 Aug 2025 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="sp6E+c5n";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="K4NlMXIo"
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1B23875D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168252; cv=fail; b=hGyTB2pmIQ8tBFmOgjoW+CQQACHjFvcwWOZ1EiluflprN6rkpYWgVDMiVT/qE68XRDa9GMjZe7zjyG7AHEQYagBgz2XJmkXdjavt/IiK1uH61uqPUdTjkH8J3treF76aR+ZdU6uEtmMc+dhX35STVLdFxWxYquxS/O8KwZCJEEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168252; c=relaxed/simple;
	bh=TMRBkt2voLxk6gWOGHmJxgwMK3syHjFoF6bhl7lHjMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZtCV6HrAyO7gxNgUFifGw8LvNx0AOQPZCU2RadEXgo3o6sN4K0KA/SjyZeHLsDceRBs3Eo/xSRT6f2lcnBdmh4E7PC63bJxEiNXR52MKkckrbpNd6vB6zFg0WSqmQcsa+kVafrnrguxbaaigMG28akNIywmvT5GFMvhVgnRWzzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=sp6E+c5n; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=K4NlMXIo reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108161.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PL9sJT013234;
	Mon, 25 Aug 2025 17:30:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS1017; bh=5efEglA3w64cLzr3Z8frOwPR
	4VbJriSNzJR4lUaYH9Q=; b=sp6E+c5nhwkpgBajADyO1pM0VvZAYtxGgjncEoaQ
	ZSZzteag66LXlyKEDXZzoGfIlxlE/RYdetMxBgAN6nujt1jUnXaIsHnSPHRHtVh2
	3rFhqikVwB+Wg878QHsY4lybONv9aZptAjU6P2Pt7xLrzfLmB3+rj9wYNSTgIQf3
	hOiAVhkwFoQWYzIMSscu7Rg8PGFBq4KLx/LmklpYAol3RUw9e0aZ6cQ+r6Mn7ir2
	b/XG4n26QjnK5SxgkweO9p/t2OYpwBh7dtlpvzFy4iFCNnmciOCpjIcd1FWR+8IH
	0JV7Wjcwq3mW6EkmZ2N5Jqy+g19hvM8/EZnHdRblnGYB0w==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020091.outbound.protection.outlook.com [52.101.201.91])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 48rqhbtt17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 17:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxpEhOSI1tsa/5MNuaEREG3lXu6JJ9yTWMlpN+EKsvsOmKAs1UoXat/sZrnGG9MeDZaJRi1sNPdjhFZORsRzou8dq2VRpqAe7CT6tOTeQet0layyW73ovNqJP4/ad4CWZZGLFUHv86FKfYSFZ2VferB+4eSLbHQbM2dFYLNHj98ZCleWcbehCupc4OrERM96v7WwJ186mfXHsJiczPwaAvVryX+vn9c1qtMTPJcbyej14dIgN2M/62SN70/MapP/WBSplFfsDlaiacexIf+kVfCPGMoLh9E3klmJhOoMGML4ZfX67tinoCjo5HTNDmtJrvKkGVb4EO6sdOziCCJaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5efEglA3w64cLzr3Z8frOwPR4VbJriSNzJR4lUaYH9Q=;
 b=veeiEAHgkO8sdUs5lFCGaJrZX6CNmLwV7k/6/SzeLh/dTSb6sz6AogaoAhDv95oyr26kQdiSQ5vvAvIg1mW/TdphzAipwFT2u19BCzIzSgXiZztMI4iSEAiooPZHKZcHKuFwRgDRgcPoBmkmGBAViQBw85LZvX9+kMtPXIOiBHAVd6QTWvLA9ZV3uPoIGFqv648lFylSERefp3EC56m1BDuIL3f3C+vzBO8gZM6noFXrethhufFS/n67Roz7yxGBwXshknU5rjmq4lPJKSI2Nkbm+cKPc4OrTVPXJVOGuwpoqQjKM5RTeOMJlQO4rXkyu6Ms/nmEUS2DTTcgcmy6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 66.129.239.15) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=juniper.net; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=juniper.net; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5efEglA3w64cLzr3Z8frOwPR4VbJriSNzJR4lUaYH9Q=;
 b=K4NlMXIoDwNRF9Zw/0MadpA9fPTp/BvKNnFKYvJgPdizRYFWoDgkbhK3AfPnebhnAHsJpc/ZYHK+K/R32mbgyzH7uqFsQSEm+IDUdKcSVbbcfOvTodIBfdDxjJ/mIsYU+4q44Fs+o4spm8A6VB9NtvijgG68Gt9dlmNPXoSyOuY=
Received: from MW2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:907:1::40)
 by SJ0PR05MB7708.namprd05.prod.outlook.com (2603:10b6:a03:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 00:29:57 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::45) by MW2PR16CA0063.outlook.office365.com
 (2603:10b6:907:1::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 00:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 66.129.239.15) smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 juniper.net discourages use of 66.129.239.15 as permitted sender)
Received: from p-exchfe-eqx-02.jnpr.net (66.129.239.15) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 00:29:57 +0000
Received: from p-exchbe-eqx-02.jnpr.net (10.104.9.15) by
 p-exchfe-eqx-02.jnpr.net (10.104.9.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 19:29:57 -0500
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-02.jnpr.net (10.104.9.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 25 Aug 2025 19:29:56 -0500
Received: from buildcontainer.juniper.net (qnc-bas-srv120c.juniper.net [10.46.0.14])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 57Q0TsVv012872;
	Mon, 25 Aug 2025 17:29:54 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Brian Mak <makb@juniper.net>
Subject: [PATCH] x86/boot: Add option to append to the cmdline
Date: Mon, 25 Aug 2025 17:29:20 -0700
Message-ID: <20250826002920.62397-1-makb@juniper.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SJ0PR05MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a37655-d416-4ec7-d058-08dde437af5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EAZnDcQ8VCo1DKFZVne1AuTjtD8pQ5FjxVJTG0kPwY+WtMVYSEZSH2YSmhVv?=
 =?us-ascii?Q?o0MubbD4teHQQ62O8k5NQKvMVbEjAoJQD/5AgKBN7U87eZc2DnVD2LFvAm0W?=
 =?us-ascii?Q?5DFhbtw5c/pbFnPi8sL0fkQCV7KbudXh1RBkdy95+jEQEHX2KhyhTe5IzwK0?=
 =?us-ascii?Q?MAOzbEiISUA+KHv8ODgNe8zdSmwuq6rJqKy/5pJ9s1VrMfM9+2s6M+7OLRfG?=
 =?us-ascii?Q?MjHvxPO7QkCSlmkGX99fbTdGkKakhh5yai2guMHg61smbKmLmzy+EEj+/O1/?=
 =?us-ascii?Q?5QO1m9XrFRo5SDL0uF9FKVXihUqUbm025LO3PNDdj5Lw+NcIODS2Cjurzgd8?=
 =?us-ascii?Q?+YVSYTY03FuABE1aZ94AZXJpZrQ3zPNm0AUiFyjFYNEzJCc8kxH4+90koxv+?=
 =?us-ascii?Q?DGX7Ff9BEYJQ3fV0AX8fVwOFwUkrEiiz48ncDlWJrmlApBFu40A9f4q8Y1hO?=
 =?us-ascii?Q?YZanmIniS6kMQI4m44DW2CeOku0r/+lycvKaJiEgadwxS8Jx1KvopPgkf6I9?=
 =?us-ascii?Q?6b5168LyXIemFutKQClvZ+iyr37toFo2pfWAEkNDPQYrDZaH3B+OjdAJaIeZ?=
 =?us-ascii?Q?BEk9Uhw6GJi0I6L1StqJEGTwD7VF32TM9u8535wVPGtwLoFWDW2OUumhb6JX?=
 =?us-ascii?Q?ar++MJH5iWCo9E7ySqq8TBvytoz0h0HSSF7oX5LEoEGlbNvAsBsgRnqEvgmX?=
 =?us-ascii?Q?Xy+O6SC8aZw61mLP4iWD5p+jfwAof6Op03j/lvAriEPyH5yflRyBYiEFFj8M?=
 =?us-ascii?Q?AA3nuKS1CWxcvDppQsoiZU4GLwgXl8efbwu95tQRB0tAR+oSI70swKe/CUlZ?=
 =?us-ascii?Q?0hoPmxcwZhy7PM0AKl5QtyPAePRpbnVwEKwZ+SEaRz/8pidFDENtN9FaNR4a?=
 =?us-ascii?Q?j7w/JiMioyh5rRRQ/IcHHBkoZGS8tKB4K/3HSUuv4UdPXghmK6aMFTrVFmx1?=
 =?us-ascii?Q?ij09IcT6ghXecqU3g/fhzBGustcGBhpdN6BMhvyBM9J8lNnpLCOOWWXvk1p3?=
 =?us-ascii?Q?o+/gjax4L3hnzVfvyDRvGDzd9nWg8AS8gh22nv5+8Jwu2toHsupK/Yf5Rp5u?=
 =?us-ascii?Q?hQf676btZ2qrgyb8bz85uBNYuxoA8Hq0DROkzI65BwicrvQVBjiucgK7KYRM?=
 =?us-ascii?Q?9PPuu14SFj7m68GWAXdfnHBcWV7DFalpbeVt7ST00ZCzXHFrhQxYPgFhIO/L?=
 =?us-ascii?Q?8g49WHtfve3n8Zbi7vQxPdRKnal4xKLaFBgxipcGn4Xy1+JUOAg1D6EL1Bgi?=
 =?us-ascii?Q?Q4m45wqUYqLsBR1IqbcWMhXG0QsF0blPsrkgnDSA99yRBOkprWClpjcZI260?=
 =?us-ascii?Q?4W1BD40SXaZ0rq2N3TT/CG++P+qR9Inmg+t5ze0gV/A+vF4nkUj+uVKR8woF?=
 =?us-ascii?Q?vaC5bS/fNUufnFBeaHPtBVuTURdcB31a9vSTE6sg+RxWWf5yqJ6Da7yiqYUr?=
 =?us-ascii?Q?DyuEbfhCOjx8iGz7UMoPcxw2JCmRIpQyg+en6AEQJg0/nP1xGb+8BRomfEXx?=
 =?us-ascii?Q?uCh7jJrNHgkoAONhaUc/z1X0yP3gHZmACYOc?=
X-Forefront-Antispam-Report:
	CIP:66.129.239.15;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:p-exchfe-eqx-02.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 00:29:57.2597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a37655-d416-4ec7-d058-08dde437af5a
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.15];Helo=[p-exchfe-eqx-02.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7708
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDEwNyBTYWx0ZWRfX0KkLHNdNGQLy
 0VzYpB0Z5/zf2ZltYOwfr43bTho0V6JTebyhy87puAF+nwqm9FnUO7iOfKxZCoWyfLZLy6ZLL3b
 ud1cw7L4v/Zp7E/Tu+r1lJAdcSwZ/CuhmrDL42noHHgazUdaIDt8cn/cDwPxvjfRiCb33bNk6Dx
 xYFD0g4m+PkRyf11l27g0sn3xVJtWZgyHtW8T43Dlf6bV6+De2ex6fyZOv7vjz6Q2ykcbbKkc6l
 p64TMsllLVF9BpoZi6hLzIkeqzUipJl5xr+UHgAhRuKUxG3ZO1043WUln7t0gudzTo2st4agJvL
 BPuPQKy3pXcQPKOJkjQ3+/By0wN8zXm9DVeufa89kVygIj/q0GayT9jH7xy9JY+hBB3tKSWxoS7
 XEE3p6Kv
X-Proofpoint-ORIG-GUID: KgftDbyc3nI7MvLTktBcOXkBsz7YA05C
X-Authority-Analysis: v=2.4 cv=ToDmhCXh c=1 sm=1 tr=0 ts=68ad000b cx=c_pps
 a=XRAB2LWAunOdTDivPrw6VQ==:117 a=YQU41r7WENJiSYrYYNJVsQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10 a=rhJc5-LppCAA:10 a=OUXY8nFuAAAA:8
 a=T8OkcMHtG-hyPi3r-k4A:9 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: KgftDbyc3nI7MvLTktBcOXkBsz7YA05C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_11,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508250107

Currently, the bootloader-provided command line can be prepended to with
the built-in command line. This is done by enabling CONFIG_CMDLINE_BOOL
and specifying a CONFIG_CMDLINE value with CONFIG_CMDLINE_OVERRIDE
disabled.

However, there is currently no way to append the built-in command line
to the bootloader-provided command line, like there is on some other
architectures. This is necessary to work around bootloaders that are
difficult to update, where we want to override a subset of the
bootloader-provided values and keep the others.

To solve this limitation, we add CONFIG_CMDLINE_EXTEND, which is already
available on several other architectures, to make the built-in command
line append to the bootloader-provided command line.

Signed-off-by: Brian Mak <makb@juniper.net>
---
 arch/x86/Kconfig        |  9 +++++++++
 arch/x86/kernel/setup.c | 13 +++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..8da39ebaddf4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2275,6 +2275,15 @@ config CMDLINE_BOOL
 	  Systems with fully functional boot loaders (i.e. non-embedded)
 	  should leave this option set to 'N'.
 
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	depends on CMDLINE_BOOL && !CMDLINE_OVERRIDE
+	help
+	  The built-in command line will be appended to the command-
+	  line arguments provided during boot. This is useful in
+	  cases where the provided arguments are insufficient and
+	  you don't want to or cannot modify them.
+
 config CMDLINE
 	string "Built-in kernel command string"
 	depends on CMDLINE_BOOL
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e1..86e4d8ab8558 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -911,10 +911,15 @@ void __init setup_arch(char **cmdline_p)
 	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
 	if (builtin_cmdline[0]) {
-		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND)) {
+			/* append boot loader cmdline to builtin */
+			strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+			strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+		} else {
+			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+			strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+		}
 	}
 #endif
 	builtin_cmdline_added = true;

base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.25.1


