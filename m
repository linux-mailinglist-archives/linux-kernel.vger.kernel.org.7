Return-Path: <linux-kernel+bounces-880006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D68C24A00
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 276104E4FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6B6342CA1;
	Fri, 31 Oct 2025 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jev7xHww";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="nCW83qzI"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3927815B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908025; cv=fail; b=Q7eVK1W5My1WYh0j1OI7MBpF1ENREFYrR5WVW+y9soPrkNbjjx2aDbukklo2PhyWXVrXHtlFlAbrID2ANyok6mXLsNGw9Qgd8iacgbOlwAfqdizT8r1ZmcuTHgZZYiClKI0g1RpDHIkT8nejVAJXwYGNVR8q8c9vUXWL+nMbaIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908025; c=relaxed/simple;
	bh=KI2SyEDJ7VJhijBbwj4glk0M+ZOH9ZnXu+xGTnXMRpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxzdWAcMQvD3ELwEs8uor4QZhWLIfa+0KWFJqq+MfVNh8GqUtepW3RZfXtw8QSVVHts+1nkG9unhMrfiW51vvua1w3shsN7EvMMqvEd+4if3mtEBO8SpUJYLlkl+M5EfS+TUOqtlrjmcabL2e76HFBY/9FAKxmug0l+rDK72Wsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jev7xHww; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=nCW83qzI; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V38Png3859790;
	Fri, 31 Oct 2025 05:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=4WFimaoGTiYX/EgHbj
	VKnRy3l6gX1ROlaL0sKzmuGe4=; b=jev7xHww7UsTS0ifXIf+ZpdUlXiXWOQlIx
	/x+ra+ycC+WWzcQZNzCdfYk6vTAoDCjTARaQJQcbg0xMdPDAs2S7VSjJQdZ8W3B8
	mS/bkl3KtKsr5gMpb5DkjqOaGCj9E30gct8VO5AdYYC9BZyEuPJD+afYizCBCuk2
	oWVrllbyAX0plvDYd1oCe6FpZUu1MpiYqQ3/fr+LPGk3Tc9ZIocT9PeCBKV3urXb
	bNZ2yDLTOe/ywxgvFMk493WZ3bWdREbIiIdsJNxzW8ihnU8b/qXLxLmaiTR+KPoi
	VI8LF55Ai5rgtt+3Z11qyj9GoT4A6KFhk5KmGJyCzus+76nYF2Iw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020138.outbound.protection.outlook.com [40.93.198.138])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4a4mxp0atc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 05:53:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBDz1Ht4UxWU/IDHbmY8KAgNiW6bi4gkM2Y1wGLO21L9it/w5AKcnP4Dn+d0G16Nc6FWgYTGPA2dUomiplyK5gmM1zGzl3s16pqyXVn/7sm6FJaMB9+3Ejccqc8F5CBLA8Bx1zoRC8IW77NqerniMoZxTOHeXxkyEMmfgITsUyoAXXDgwBnUPh4j9fgMvOBfEVjTpUwodqbGfozBtu3SkYxCOq0tcuX5TEkiPFbOWfCkOnoQL/7HY7spbXf4HdQAmF9Izqj9kqgNur1zDGu+9tSyhEqzBhCAAMmO7Oh7Et1DAtBD/nADgAZ00QW9ywl0hlhNIhjSeWQW5Q/0Qt/KcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WFimaoGTiYX/EgHbjVKnRy3l6gX1ROlaL0sKzmuGe4=;
 b=RnlbjE3RM1mB+n5Mc2edwWepgLjE5m6E3TAfpocC/xxl0vnNsnol/nf9n5orwUL3zdXTrbzJPMT0rpxJQv+G5NI3g7CqQNUlEJLwCRsgnUAB5XX4jebGeX2MPqK3FiyybIqoNp5cjrWOMSlH4BBbTdZntxam2cvwQZE8trAQ1cTuw8rJj2tG4d1M0xl8OiV235YUmgJlqhXzUVw3wvXf95ZXxrgaFikB5B7zxI+jGJfD/p+EzauuwbxWMImiH2bXJY4r5U3uEv2t8jESWIIFr2KpZ5+hxp60ouqx2bOJHNW+R/Q8JtB1aeP2QwUT4ANh1uS215mrLE0eVzYk7BLUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WFimaoGTiYX/EgHbjVKnRy3l6gX1ROlaL0sKzmuGe4=;
 b=nCW83qzIl5xZu78HiI64CAXik9fyMDEErYEntoYaBQaPdSDYUfS8uFmyDrFKhcsufO0ljW2qzVrW1TTgWDNY1qKPZBm0RJwqavWYrTJOIHcxe230IFg1U2asdPvt05ZGLNDy84XPLGNod1dyJ3RjoCLVz80gelqC24A2flhj5Nk=
Received: from SJ0PR13CA0207.namprd13.prod.outlook.com (2603:10b6:a03:2c3::32)
 by PH7PR19MB7433.namprd19.prod.outlook.com (2603:10b6:510:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:53:33 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::d7) by SJ0PR13CA0207.outlook.office365.com
 (2603:10b6:a03:2c3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Fri,
 31 Oct 2025 10:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Fri, 31 Oct 2025 10:53:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 66A0B406541;
	Fri, 31 Oct 2025 10:53:31 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id CC186820257;
	Fri, 31 Oct 2025 10:53:29 +0000 (UTC)
Date: Fri, 31 Oct 2025 10:53:28 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sander Vanheule <sander@svanheule.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3 5/5] regcache: maple: Split ->populate() from ->init()
Message-ID: <aQSVKIU07nq17qFR@opensource.cirrus.com>
References: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
 <20251031080540.3970776-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031080540.3970776-6-andriy.shevchenko@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|PH7PR19MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 240efbd5-786d-4f8c-d026-08de186bbc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RqqJQ6TOPDWVGhxPim6p72aZmP5hwIAM8L3XJ1T4sOd2Vx9arT4+wmWQcFMv?=
 =?us-ascii?Q?bdBBI6Vimq1+vyW1fE+9ZGjxGFmpooEbuWXYZvO8M7GVJmooabMcvEkvBCX+?=
 =?us-ascii?Q?aeR5dPLaMHKYoQuI+pryy+bC+pQqh+Rqhk9L1TK3CTM7D0Qbn1EGRtIfzu+x?=
 =?us-ascii?Q?U/TZmf1fKSZvprRlKPpyZHbonmHBCBTSwabTpWWUJD82K2aqusOZQ69o55gO?=
 =?us-ascii?Q?Fi8s3b4UVBs0wDVw6zc/2/TBWRXvV9UrQLDP/iS7yiexXDrWTkqlQUUuLRj4?=
 =?us-ascii?Q?kXtS933Cjaajiwv9Jcw3KJ2Hn2Ybvb9pydFQfjV78Nq3vVk4IZOgCEx/fzju?=
 =?us-ascii?Q?BiMgPXzaEVeMz+D6C8Kz0U13Cg960yZpiXX5JDk0LYtxOkwUfttsXPL28Dmf?=
 =?us-ascii?Q?C3z9paCN76KiC7PxmzXABPo5DIU0ipDnJM3FKhmzg8NSIT6KJrClyjAOga28?=
 =?us-ascii?Q?V3RiBFkehcZgFvs0pf+9rnZoZ2VqTBRAumWdTS86WKbRG0aInd1WxM93p3mL?=
 =?us-ascii?Q?BfvsymtwOvbOMk9N3KD6uZRHNBcbDMn1F2cJbUhI8iuX3/ZcXPLn3QgakdAD?=
 =?us-ascii?Q?192Vw4wIwvedplJMXoKDLoCaclxEqY81tA6fsIQ/4RTSzmP/D/0t0f/zXd6g?=
 =?us-ascii?Q?PkBc0Tq3Bc3z6T0fh+ZOAx/p+DBfppZ9qAxVLKt4Hk8kbSsxADmgLCa98CNw?=
 =?us-ascii?Q?vYvwbhREXkyH/f3isZP39mlZD72cpnG8mVNEmbVIRH2feDj/NLQX67CI1rfq?=
 =?us-ascii?Q?8Z5ItNvNMIf+VNaiMUgGW1X7mfM1b0OPo+re8s11TGVieiNu1dnlydEFZRwk?=
 =?us-ascii?Q?bCpbT5jUP1U85SxXeYp5ryYleGyFwNJ2Myi19C7Lk+BvLvlznZWMNYymUP/I?=
 =?us-ascii?Q?LgTJFVeOd6pRcN0IkRzAfso0BFD2vZFxel/QsqbpCW0yDwzw+0bhsJ3CAfQP?=
 =?us-ascii?Q?h52TUXB084jPSzZOzwlIb7B3ipeTKQLy4qWeR3aZ2B1qToxzgW187gnnNHKd?=
 =?us-ascii?Q?aG/fwrbEqw6o+UTq8Yn/1vYcDpKUyxE+s0d2ICeX9YhpnyChyPsQOkEJiJHw?=
 =?us-ascii?Q?8RzxgnSBgP/l9fIaA5a+hEdP4gzODXxW4PlpytQzcsq+M1I7jWc8Zr06v/o8?=
 =?us-ascii?Q?NGNWCOIUpvTIjhMgSO/nyIXPgM5NziJJhrLAhX6xprQwl5BoY2yk6Fwi1dip?=
 =?us-ascii?Q?JFi/RiOE07OSwn0eGx/m7pVhKdkMTzyxNK6y/o4AFF2ZSKGQPIs+oXjSj52t?=
 =?us-ascii?Q?IUAp01SRDRY4AetcR9XLdO40mEV657BPFIfv/TQTwspTbJ5dXx8/GpoqhC+i?=
 =?us-ascii?Q?5r4KT8NNLIuu23Pu6p3pF+jKXkOhRw05uBxR+MDt3DJa00PaeoMJctYZWGZ+?=
 =?us-ascii?Q?funU2UUByYZWBqcJftUPCsvn0neK3dLTLd4WMWkYuM7Y0pnqCKUtw7cF5hYl?=
 =?us-ascii?Q?s7eFoHyqZa/u3G7Wog5wHRp9tYok7vrZTqRU13y7tVs3+hHNPGugN6aSAscf?=
 =?us-ascii?Q?liXd1Imsiao19WqwqTf6O5NCakAiOT0bmj6oSKzhEpus66w48vNlEEk+gsYn?=
 =?us-ascii?Q?yHssnxY2nbhwnoXJeAM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:33.1533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 240efbd5-786d-4f8c-d026-08de186bbc6a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7433
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5OCBTYWx0ZWRfX8kZr+ld8+zgW
 JQ6B+VkyyGNJxMYJuggRD0KrY2TFIafDo2mUPpP0IlTzyle+WmmcVm5xI6lb24WCY1ulf+au6b8
 +NOCFiMRubJAHAtScTvsozLHG1EZA60d+kXY3IEeQXFMTSu1weCuzbS0qJYg0pZe/P8mNmouUT3
 7MrWVc0k4mn72sU1FCaWujJrgucW2mCpBrR+jn4yANKWefco5wZUwZQFoNbMIuAPYTHgwj47Hgr
 eAclsH19ZaayNC60TJaCtHuzhxg7SVUI3n7f+HRe+YgvXGwtDsicg0vzAV8+UUlbaH3w2j6nSaW
 VDNe1f/+AUq4wcMk4IScWeRr6MG3Ul6dbHVnFHNSwnMoSJsFnuWnewfGkOu0e/NGiaubeyNvW1U
 oJ43xXiurTZvfnnxAWITbkqI5VhYeg==
X-Proofpoint-GUID: kfhqEmVCu0P9zVGcam0EFlaHeQU2Y1vV
X-Authority-Analysis: v=2.4 cv=XMI9iAhE c=1 sm=1 tr=0 ts=69049531 cx=c_pps
 a=33nGjHHVSK1XMij75uKlEg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8
 a=okfCuM7Qwqpgi6HzE9kA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: kfhqEmVCu0P9zVGcam0EFlaHeQU2Y1vV
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 31, 2025 at 09:03:20AM +0100, Andy Shevchenko wrote:
> Split ->populate() implementation from ->init() code.
> This decoupling will help for the further changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

