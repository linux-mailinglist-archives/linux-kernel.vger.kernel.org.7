Return-Path: <linux-kernel+bounces-723616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D83AAFE91D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516FC188ACC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D353E2D9EFB;
	Wed,  9 Jul 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kVpLWkr1";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="A8xSo414"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A4293443;
	Wed,  9 Jul 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064750; cv=fail; b=oJbvAHtiIq8gZYhuQRpVQcUOQ4rSuvA4XAnbNHQTRqzfhlBsEUrR4SXNfVGSdv4e0YTGjyVUI8pDTmA9W+qG0RXmMDggvXeb/lvw4mmnR/S8BamOfPeFPEQJfv8prPhisS8OAl9cqAFY2fBMkwbMMHxloeHed9W7bOYyjEdSirA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064750; c=relaxed/simple;
	bh=UssG7Yh8+1B7/eKuEXbc9b12rrzFaO/CUEbl3Ocx8DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIjTzI+U/c35xXSVDe+1ANvVNyXz8B71LzA7aBqeypdwQKMF2X8+sdJOfguvF1x/98Rz1MaHm1Q2kwJKIoQD3Mhy2X7vv9rvFTWpPMxgnX+29BEq37VyY6/FAwu7sWxvyLOOtnC7xA8TFPMhvnI8eLPOMYUREod4gNMVB9qFXJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kVpLWkr1; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=A8xSo414; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569AXuu4020100;
	Wed, 9 Jul 2025 07:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=8I1wjHR9MC0bBph1zb
	IFIuM9ybXr2rzsYN5616tm4KI=; b=kVpLWkr1JNzhmDn6XVRsgToqvadvKB9jPa
	pQn2OjiILvlij6aqEJ4XUBs/0BaQa7xipO9LEqC8QqJpgZoQe8gn30OnRuqREHcY
	AMWEnM8SusSqapJJeUqkRoDY5Fa9P7aPuPSARmpgWRTUtbvE20LiFjO+5zF8KwB1
	ChxgZToYaUQURmCtrIZUQWHgy4jTiGTp6Tk2v8itKLIu8EO0FKE0Gk784B5kocuy
	OKT0LrPoMh415ZGx8NE5utiyumcY7PEPnZjLVKkl7KyEwN4A4kU1N5G35QxRNk1l
	ADmZ7AS//fSP2aARxcve4Q1BYQFl7mLaB27+7JoaLyXQjMwiWTmA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 47skytrcbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 07:38:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzPu343rf+0PdhFrBciAOaOZXTlJ/ngo84+TY4OESgBWxPN+5OJek/92wXW9hgX55MuPPzBNfIYPCdEE+vdImTCZa70LSBf8CECoVg1WNG1itpk4QJ9mTyHkTnErLT5vaSfaOFpy3BnNU2IFR36FC34Lw9lh9DdSP2rJhao7VDPll4e1fLS3GPWbch5dy1VGHEigJ7DcI4an7dUhUs+YcZud+NTUxxgV2yCBbpBdcg5hUU9G4I5I8pjgeQycNclZVZ2G7e2IYqXYNWjucDqMO2C6tg25kHs2vovix7fuwKVphb4OTer1g3ZHJeKje2TZUjjsAnaHhObdnhBMNxU4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I1wjHR9MC0bBph1zbIFIuM9ybXr2rzsYN5616tm4KI=;
 b=XVSQlzciYW5aCTuiQiY436KtG/crdS7Ym09MyVomXNXZfd4IvjH4xFWclH9uotvS0KdUNAZ1r+eGWTBlTPDPfp7E24OrFE2G/IGb9fsFY1z6sJSaTWuVF5Ryv/VEUQjtxGh+7Sy5pq0L1GT9ElFkqr1vE8K96gLobeuLx+0MROt05mywdKnA32xPaAtYx6S1u0wdyBvMKXut2CLeGK0tP9hSP13gpH+O8i2nx+A4J4lB4cpf/SnVSFPT+H7p4tlfPj87qIbq98cm6oM2RSa5GDmO/5kxCeOGcs1qCKGTQZAfVHX4P11ByM4zfYLxaGTdh+N+GIM2zs9yi+Y6NHAcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=arndb.de smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I1wjHR9MC0bBph1zbIFIuM9ybXr2rzsYN5616tm4KI=;
 b=A8xSo414taOWorCa2+xUQIAlsLbeCEjTDKZrpAYU8wXUBsftfmz8lb3obxqS7QC6NuPlgYtLBNzuBx6+dOCgyfRCavxSbA/N7zWCMgEJ8tjfqHUyow/mDFvtRjKF74h0+1xZFt44P0doWvbh/cWPxYB3hHXCR4U8ELwspyvwG88=
Received: from LV3P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::14)
 by BL1PR19MB5988.namprd19.prod.outlook.com (2603:10b6:208:39f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.21; Wed, 9 Jul
 2025 12:38:30 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:234:cafe::eb) by LV3P220CA0014.outlook.office365.com
 (2603:10b6:408:234::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 12:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.1
 via Frontend Transport; Wed, 9 Jul 2025 12:38:29 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 5ED92406545;
	Wed,  9 Jul 2025 12:38:28 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3BDA082024B;
	Wed,  9 Jul 2025 12:38:28 +0000 (UTC)
Date: Wed, 9 Jul 2025 13:38:27 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuming Fan <shumingf@realtek.com>, Arnd Bergmann <arnd@arndb.de>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SDCA: fix HID dependency
Message-ID: <aG5iwy6j3rR0YdPy@opensource.cirrus.com>
References: <20250708184618.3585473-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708184618.3585473-1-arnd@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|BL1PR19MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc90960-00e7-45ab-45b6-08ddbee58210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|61400799027|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1RkyvazR6MoyuwIZgRXzor5GB/PIjAP+74n1SGmET9+T0uD5zglO9/nmpuqN?=
 =?us-ascii?Q?UdVvEWIOszNyI6FKUcW3mekTMvmttYYOux/gnEKyTtfjcvnsp+S0h1kddq3E?=
 =?us-ascii?Q?LcqYMYTBAdygz/5AU/bq0wlP9xFW7Qa41XKoCMyraIVFKutWNYJkbxaJKJW1?=
 =?us-ascii?Q?XED9FTgCTI04gBNX6EFvXgvPN7PsR1U3H/TOccN+Z2/oapgELnixiQEoqRYZ?=
 =?us-ascii?Q?Bj6PnoK2iiQzeD0JX9PB124o/Yi10BVLFF0QIwutApGIhj29s5/pgQc3Auec?=
 =?us-ascii?Q?QgVt/UpDtkbCQh5i0WlQAqrnDWZb10zbAgWr2XAbATK3AgKwBENGC3jSjtWy?=
 =?us-ascii?Q?qPaL1m8SkeaOdgJPuzyNli1rBVN26o5K7/VIdbnpOnwQaJ4cv09PgNYZrEG8?=
 =?us-ascii?Q?c3N6uFtCpmzvD2v06UPrQTVOiZ8uKq1ksW7VrQwif1UJaQN//U8Cvlzvbr0k?=
 =?us-ascii?Q?SIMXSKhGt/LTvDYPVvfUbeYNSTUgVLxxrI7dYf+BA1/tTi79FdOmS9VUN3l2?=
 =?us-ascii?Q?PtE4u+BYlBy8JyilwdY7Msxev2PAO2PHjpYuIWVxOCgpYEDJjgq8Y3DbONDe?=
 =?us-ascii?Q?Y7G8wX9SqManq1a1TcmI54YVwZlAQaurF2oFa3520dbhutoZnvEzXiZiryPr?=
 =?us-ascii?Q?lihFyUgKUd1ucxbSryyTwJSjA5iFJDECSrQ2ELhWHAT5Av0ySOvu0Qf+UHDc?=
 =?us-ascii?Q?weg55VULbzUK/79vAv0amQxcWQ0Z4uGnMncUja0A9ks0mRC5PtUYQBgOzedi?=
 =?us-ascii?Q?zfIs6qe0nk4+2LqGFNtvb83zPn8Ln6CcGS+w3ufu/0jwaFq5d1HzORXo/CbW?=
 =?us-ascii?Q?eIz5pL2w0zy4g2dzNoRvS/x6vEOtI02xmMDGa+lJwA2d0+nSy4Bv+GNsDf8x?=
 =?us-ascii?Q?dsCeayLeKitM4lDx7Ds8DlggnNVPGF95mTjdL7ekQbs0Bd97p+7fK3XYOMla?=
 =?us-ascii?Q?FahoAtagB7ESaiZ3+IZx1zcRTg2KVmlVCU9gef0I/Mvcn3BKmZQgnJj+efSf?=
 =?us-ascii?Q?5IDQYaPjW2FpdmuQfJBNn03FUVZ5WdQTmoCdAb+Jmd9+N7g1zULciht+bdnB?=
 =?us-ascii?Q?coNTUgCTdqBb5b7jyIl+YOyctQysSLt6LuUCuW6lzZ3SnDHby3a2AN2hSjc1?=
 =?us-ascii?Q?OCmP+SUh9qznjuC7uB9ZUR9KVbYsXphj+kxU8jg9kvXIdqnMWiM8xh6OF7I0?=
 =?us-ascii?Q?i4S7rQrMXwUHwW62c6yO0fGUOXOF6VgvO0oE83EGAmTVREwPMMQdzbUUBY7+?=
 =?us-ascii?Q?MvJr1vdpLg4P3CH+2lTgG16lUQMSEu6QUq8/H+IZBl9jOGgKN8rHGpztnS2e?=
 =?us-ascii?Q?izl4tFztiyWU/VXCnHLDRR/z/IGKCwAZoGoRwYOpoc/OSOmdUOB2miJ00ss6?=
 =?us-ascii?Q?56UXID8N6tBqRQI2Y/7clHxzgUrbr5arARNWK4S3cwa/6QWz8WgW5768BeBB?=
 =?us-ascii?Q?DzSxZot6WFy5WTCKjEmvtsyxkEOOqVd/pIWNnknuNoOnPY2g0kipv1A9MdAC?=
 =?us-ascii?Q?5/2NaKiPkfGpX/KG+AKNqqrl+FXrAB3Qpx+a?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(61400799027)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:38:29.3208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc90960-00e7-45ab-45b6-08ddbee58210
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5988
X-Authority-Analysis: v=2.4 cv=BerY0qt2 c=1 sm=1 tr=0 ts=686e62cc cx=c_pps a=8v/ZJ2ZVVIJmb/7pfl2wZA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=RWc_ulEos4gA:10 a=42tJLid4dYyMX-9g48MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: GzPlNTnV69w4n63_Mq2W0aZlzwvCuvDb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExMyBTYWx0ZWRfXxgSUnUO5MQqy pd0BYvYLwMyfP9C6mS+pdR4QEYvh3jHzC8UCLeSD2jDqwxD1GTdL8nFU6r/WYfHiLtcP0b6Bxqs NdwcHV1lma4Ib4UgG4Lsm2SPpZfBZTY/T1PYc1kw/TGjNw+6sBRk8TCPiNj/QxoDVaSO3PwHKv+
 EdYB8m5ndy7MwMkY3kZhzVUnWzUiuCwHweyZ9ZT04MrQwAHAiER9f8gVz1XW0jVwSiYFbKLGvF/ uLbUcRr87Jbn9Q8TftUiopFdwHizJ3pjuNExhfnT4Uzse7FSZ41cJZaWMEJdcy3D4BoSPxKp/a9 GQvvNbqn+DjJ2BlWcW+z7nRe5jhK5ZagPsjF5DJjn9eNhN2Tx73DsCipJ1oyfbHDds+27LUJDeH
 ZnXyUYXCZ2N3tMNKJgyXP3DOKP5paur15lNxISd/brEWqH/rDIpIgxrEebHNqhzspC0nKiHG
X-Proofpoint-GUID: GzPlNTnV69w4n63_Mq2W0aZlzwvCuvDb
X-Proofpoint-Spam-Reason: safe

On Tue, Jul 08, 2025 at 08:46:06PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It is not possible to enable SND_SOC_SDCA_HID when SND_SOC_SDCA is built-in
> but HID is in a loadable module, as that results in a link failure:
> 
> x86_64-linux-ld: sound/soc/sdca/sdca_functions.o: in function `find_sdca_entity_hide':
> sdca_functions.c:(.text+0x25b): undefined reference to `sdca_add_hid_device'
> 
> Change SND_SOC_SDCA_HID into a 'bool' option that can only be enabled
> if this results in a working build, and change the Makefile so this driver
> is a loadable module if possible.
> 
> Fixes: ac558015dfd8 ("ASoC: SDCA: add a HID device for HIDE entity")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for spotting this.

>  sound/soc/sdca/Kconfig  | 3 ++-
>  sound/soc/sdca/Makefile | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sdca/Kconfig b/sound/soc/sdca/Kconfig
> index 53f6926255ae..36c2fed54dad 100644
> --- a/sound/soc/sdca/Kconfig
> +++ b/sound/soc/sdca/Kconfig
> @@ -12,8 +12,9 @@ config SND_SOC_SDCA_OPTIONAL
>  	def_tristate SND_SOC_SDCA || !SND_SOC_SDCA
>  
>  config SND_SOC_SDCA_HID
> -	tristate "SDCA HID support"
> +	bool "SDCA HID support"
>  	depends on SND_SOC_SDCA && HID
> +	depends on HID=y || HID=SND_SOC_SDCA

Does it perhaps make more sense to add a (HID || !HID) dependency
on SND_SOC_SDCA and leave the dependencies here alone? I feel
like that lets the Kconfig figure out the right settings for
SND_SOC_SDCA automatically, rather than just disappearing the SDCA
HID option when HID and SDCA are set incompatibly.

>  
>  config SND_SOC_SDCA_IRQ
>  	tristate
> diff --git a/sound/soc/sdca/Makefile b/sound/soc/sdca/Makefile
> index 2a3938d11ca9..1efc869c6cbc 100644
> --- a/sound/soc/sdca/Makefile
> +++ b/sound/soc/sdca/Makefile
> @@ -5,5 +5,7 @@ snd-soc-sdca-hid-y := sdca_hid.o
>  snd-soc-sdca-irq-y := sdca_interrupts.o
>  
>  obj-$(CONFIG_SND_SOC_SDCA)	+= snd-soc-sdca.o
> -obj-$(CONFIG_SND_SOC_SDCA_HID)	+= snd-soc-sdca-hid.o
> +ifdef CONFIG_SND_SOC_SDCA_HID
> +obj-$(CONFIG_SND_SOC_SDCA)	+= snd-soc-sdca-hid.o
> +endif

Yeah I think making HID more of an option on the module rather
than a module in its own right makes a lot of sense.

We should probably do something similar with the IRQ stuff I will
look at doing a patch for that once we have sorted this one.

Thanks,
Charles

