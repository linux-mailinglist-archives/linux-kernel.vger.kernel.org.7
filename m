Return-Path: <linux-kernel+bounces-879996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD7C249A9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79C718985EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A03533DEFC;
	Fri, 31 Oct 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mpvQlkIJ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="VO2hJSIZ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D374342C9A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907739; cv=fail; b=VKueVGQoLiB1gIY7X+R0NH3eetx5qT9m5rlY9Tc0lH6cvjZXH46o314T/7YXtE07msqM+WGPLbEFLV4SjS9FzDI1YWR4jTpVzZbuRQHf2F/Lg6cZftkKhT8PAXFkTgluqOXCTEJyIjtM9MH3iOY2UQnC36q0yEAkLUOsz0DCfYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907739; c=relaxed/simple;
	bh=tTKnyCcut7HKEBfn9vCRUEFMLqGYe2PvZBRyTrGX+EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtT6oQjyzHOXfsQqzysxstewQ4QoR3znNEusbUTq31C27fack75ERPLKqjJPkZ4WXL+Me935m0l3/cnDM6MlvtDM6PkDHZhX2IBbS7uDmhvb9ivx3Pc6t8DfkUfrNhiqgUIxM7B4jKfPqdciC8URF1rsZ4XTAKuFi5v6tVb9z20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mpvQlkIJ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=VO2hJSIZ; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V38TJI3859819;
	Fri, 31 Oct 2025 05:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=hLWMPcwdSgo2e4uyyG
	NGbSD4PXKpwsjrz+s/H1X/3qw=; b=mpvQlkIJ7v42Ksf/FxK7nLsVrp9p4OK0pi
	u2BnqNgmTuR0BNxDlF0B1OTFNeurbdEyfEfrETxbgu9AstIPXJoV9BugaINKJNcf
	4pDdrgyx9E5XUfdLWfXeNNGDZbdoCanZd8lEpw5QiibWoIdPQkKE3fpzXT5U/UZY
	/YtSOVhOzZVbjeb4amY+twolsij+Ryl9xf+f8zSfYqk9gUkC1cwj5knKKIyr3sMt
	9s2Gh80IO3dSxcqxXzV7KYCE/eaTp7EtAOF3tPPjy95pM2ul14a5aM0uQiM2v6qC
	xJWWrUkKCwOl4e3AJGq08gUED0mIyJ5NLoGLuJcMnKeYr8q1+I6w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020133.outbound.protection.outlook.com [52.101.61.133])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4a4mxp0anx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 05:48:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlfdzCIGTf9t2VRjm5wrAKRbSLwX8xHuHBCyInljej8WfiRzGOOv0O5zaXo/TIJchQeSY9hWGPv3qnrcV/A1l0tCHeswByDoROsuJcZ27tyg8vrZ3IaiEUmuV6qL9D2b+VH7i7kBbH+4JpBdysa96jjWEej6TwFwZWVNmL5X7J5RFPBMs9puCDDkils1H2jZr9Y3XzZCHnrYBLEy+VbN2iVpgHYKJsmfqorVZCESliaG77ZTaE/XWverdqYCExJV7O0mQ55BGULOJa0uqS0A5nfvhVbSBbNv+rlbDRa8ZhPF/xYAKjf2AUFxVzhDKpZl1hGz59H0emGq5cisO0QVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLWMPcwdSgo2e4uyyGNGbSD4PXKpwsjrz+s/H1X/3qw=;
 b=xi391voSAKOKbKhSBgv992LMCG53WWOOjniMpMfrICvGhtss26W9hXVlwlkLYfJfufEF2rF7K/lFVUJ6Ase+H8BafMTQrHKxQ623jvlWCqXWrU3rBEVTVCiNWtUNMLwXE9On5cjXaNvl70zlAjJXa8zlwR0AdqwATMlcDCrFUpFs88Zy1iM5tT4Qq8jS6zLtG4budnHlu+4CIMDZAapnXE/iwhjsInhk0NIUKb6Z/UHEcM4/Sa6iVeb9RNckyR4Qcwam9MCmXetLzT3jl71MwRBXi5a/+TbOalFOmciMOLyiwg1xQcppVRPJMMOF2nYQ+jggFLyP/QpJbYepHw1asg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLWMPcwdSgo2e4uyyGNGbSD4PXKpwsjrz+s/H1X/3qw=;
 b=VO2hJSIZRwrbhuT9OeZee5GKdQf9GzzVkNb/bHMqoiCNaGdVPRMkGeUR4HDQ3PvmAHFeNSE305Brxv8pjJyVHBsFmVhXf6VS1ZjZIOfyMGuXGdF3W7X+SIXz4WeSXKpKldnNQPVy4wNDg3Fd8NXxR7bpTrKjsgVIvXvLMWxGHng=
Received: from BY3PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:39b::32)
 by PH0PR19MB7456.namprd19.prod.outlook.com (2603:10b6:510:28b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 31 Oct
 2025 10:48:43 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::e6) by BY3PR05CA0057.outlook.office365.com
 (2603:10b6:a03:39b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6 via Frontend Transport; Fri,
 31 Oct 2025 10:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Fri, 31 Oct 2025 10:48:42 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8BD42406541;
	Fri, 31 Oct 2025 10:48:40 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0370C820257;
	Fri, 31 Oct 2025 10:48:39 +0000 (UTC)
Date: Fri, 31 Oct 2025 10:48:37 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sander Vanheule <sander@svanheule.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3 1/5] regcache: Add ->populate() callback to separate
 from ->init()
Message-ID: <aQSUBdjGIV8h1fJH@opensource.cirrus.com>
References: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
 <20251031080540.3970776-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031080540.3970776-2-andriy.shevchenko@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH0PR19MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d4edb8-07ac-481d-08e2-08de186b0f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CXmvoeaV1uIx2vwH7qc9bFzX4TmjWuTx09V8uDt+IuMhF4UfB4WRiB3SoGem?=
 =?us-ascii?Q?t2azVigxJ5FCR1yPRCa9FyqowktNkX6rg+Bua//S2aALDkc0nM7zKn8U0wUB?=
 =?us-ascii?Q?2TF/5rOxqO2KJfOGF4/aDeNZlLWgdbmxAwFWmluIFMfoUQgw3V0RJ5V8r3Eg?=
 =?us-ascii?Q?9DtUMzwtKsOk+GLch9V11b2qCvQRCXx5p04iN/LoJcf9TXqvQVf/hb4BKlWj?=
 =?us-ascii?Q?MckmkvA+UHLlRfaGty3ZZGyyV1ZAPXfF0BVS4w7VALR7OBVl3W/UDB74hN32?=
 =?us-ascii?Q?NdA0ZCN5ZFxvIYa5X6WLRI08bP8tZ8lykdFM/dGri0jofLgxFcLCeqvZSLV8?=
 =?us-ascii?Q?IwhgtwwfodZ735qL/Vlk0SR0RCLyOmizyCMDDq7U/Z+l8+pY0YkAH8UTPTj7?=
 =?us-ascii?Q?RPMv1pShUL1Fj/qs+ZjOCaZi8CACInyBnwv0yOszMEQJzSc+GcJLis2cHg5L?=
 =?us-ascii?Q?HdJ8TvNso4vVGRDRHT0aGu7C4hXLFeqkEQVFA0+wX8NTt1yQ7SZr0tKsVFzq?=
 =?us-ascii?Q?3BxwJi/hs8wPWUgpk2DPiMM+zMBFM0O10Mh5wJpPyNCZ1fnQYYTYDXViXeuQ?=
 =?us-ascii?Q?OFJNnyVosGfSfsaoDLKK7Go9BriYdAaP01FV1ljyzg9hhfiZdzOZ1cslci1Y?=
 =?us-ascii?Q?012ioIEKMyEz24YmrSw5gjzD7mUCffFY4rU6JQcCC65I4r0NDHqclN1xu8zB?=
 =?us-ascii?Q?xEi6cS/ClaVmCMTTJlMMv1Z5p5QMIGd0GbSYaSQkPXqStJzoGfszEBmg8ST0?=
 =?us-ascii?Q?CIa87PZHutj8hv2oq3MVwzs7keM8w17V9sJeCBBfvDQPLwYsHJEQP6Tkcqbg?=
 =?us-ascii?Q?XSbCcOYytV9Ww3MOI62YC4WgHmMIzjPM0wwp0vQ9kpwp6GiYNEj8sZOP72eK?=
 =?us-ascii?Q?jqPeb7qD0qIy7x/sSU/cXCACLuFCzlYt5PE08iqam/JtuVDam85ZThqXHwZe?=
 =?us-ascii?Q?mMNvR6Z3uWhJXX7ZegEwkBGo8VPxT+bwz3Gq/VTQDP/3QOTCAKDBCzkOggLB?=
 =?us-ascii?Q?CAf/ju1GTBlOY0CNAPR76QdtwG8Uj0XhqZguspbqnvhLoDzvupL0Ps89vplk?=
 =?us-ascii?Q?AA9R4CmMve1ry1vCXFz1vw8OfmvoJ+8dns4tWqVdywv6PDLDeg3WlemSgbLb?=
 =?us-ascii?Q?75UzGzjksTHG+2Lp5xBZmUxhkhrdg2LgACsa+b11EFww1PUL68FA1lJ5FTBm?=
 =?us-ascii?Q?hNiOvEyebGvEGfShOHJMNGz5MGbFAl0HhLQ0MDflbGq+iY9sd+tbT5TUiEUQ?=
 =?us-ascii?Q?NBWAoKFTkhPNtbfLzyQFM5k4hlr8euIO1OZwRnFLNUI2Es76qOqNOX0bUNHj?=
 =?us-ascii?Q?QQp7nNaZA0f09SzEbE0vWfLlgZcFjytwfGH/A/SmYU0XRv1hm85j5njC2sme?=
 =?us-ascii?Q?I9NpNHvceJYaS6mcUZAribS2G1ZDkQKuSH9Z92CSlxeXqihY8OX1YgwrPmac?=
 =?us-ascii?Q?RkNlxkdozYpbLezZszR/oQozNh3wFfxlQ78ShZiNs/7F96yOTQrH2xQoezo+?=
 =?us-ascii?Q?dWEbrxFzSynUbcBz+kmASAe+7klHL2GsF/jcF60wX+7VqZ6qcSR5IX6rmGSI?=
 =?us-ascii?Q?iLJgqvSzyy8YWhpT9Ho=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:48:42.2655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d4edb8-07ac-481d-08e2-08de186b0f09
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7456
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5OCBTYWx0ZWRfX44YsD2Um2OSz
 Ks6t+6BfGX5FRf7jBQgbhFBzNAHOmK/gIIYCZVMjgqEssaZ0zifuIDYLvIJRjImBPYdkUjZ5Twa
 IwVN2viUgTxZBnkJXE3DY29+zZflV7o7Z3hxvYxRdsdIJ650ysCFXpKx77XKqghpwBh2t8eL+Wt
 0t59KM9Cf5cJcVZ/SQTeq1e5jSMLO6KNCgxfR/uPHLrWU4Aw7outLWkXitQgzEPlO/gqFvilLc3
 bmTD6gYK+7pnHHxlC0ZnBFPwViWmrwA5/zTWGdLECE8EO2c3zUxNIo1/jij99K2vpwbf3fQJ1Po
 OYgeM8qtBnoGh0warzAtMRpt9fpYBTG8rS9t1OhF3hAXbcF0wLblPMXSx1yEwFiNFuDkeUxITNo
 NSlFCohJB0k9uC3b6cA38TjSvS5IKA==
X-Proofpoint-GUID: 0q2_dQGogLkKjl28OJowQ2U5hVooXyGH
X-Authority-Analysis: v=2.4 cv=XMI9iAhE c=1 sm=1 tr=0 ts=6904940e cx=c_pps
 a=3l++41Tsbfu3Vy6U+n14cA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8
 a=_ksuxH4TymCuldrx8mUA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 0q2_dQGogLkKjl28OJowQ2U5hVooXyGH
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 31, 2025 at 09:03:16AM +0100, Andy Shevchenko wrote:
> In the future changes we would like to change the flow of the cache handling.
> Add ->populate() callback in order to prepare for that.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

