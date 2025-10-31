Return-Path: <linux-kernel+bounces-880005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9560DC249EE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 412DE350978
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B044329E6F;
	Fri, 31 Oct 2025 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="i/OJLAr0";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="DPrWMujI"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D29322C97
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907941; cv=fail; b=LF5qe+FLjcx95mbsGY0E8qpIQyE4w7AbxY83JgmknutNZvD5ifyoxSzpMA0M6zDwf5SbXFcAkCbYz4CsrJrCAQuRsFP1GP5kJ32nLK0giTlwI/zSsNp8CWR/6/dFBs8Ca3aGbKcK0hzHMkNnZOsZS0y6Hv198i0xKoqyt0VrYPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907941; c=relaxed/simple;
	bh=EDdSwn1jj64rLqAoWkKLYraO92QARWapoRuG8gx7usc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO0I73UCJNNa81vhAzIWQgmolFjajQGU5p3wB8XOzrg/w8nlv2M7/z+ybVScwxeBnJcEjYIGB9CJpcqTY8R/bUUpWKgdQyl7lMuG+gUV2sym2RWn26Yhn0M06v8e7taMNWfh/dnDi+xuIkyrZhj3DokOdqfoXfeloc8db62wpAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=i/OJLAr0; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=DPrWMujI; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V59pao2199703;
	Fri, 31 Oct 2025 05:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=bXcFbVnZ9WFWYXzyiS
	8/cHPdLCfwUaOyVQ20QQmpy78=; b=i/OJLAr05JLTrX9sfpWKtNm7JKho8cSR1Y
	t9pv6w/wpxaDK6WS3rpnO9EpAcD4NiAEisVtfDDfRvcsZO3nZebB7H5nuyuSWZ8k
	U/Akc6uipzEJixDqr934pitf4UUdqIaRkwyGDzza0QB5kBtPKDV24KL5r06z12NJ
	12CDKpx9CrLEoA2t1/Tp3Z3Pr9eVUjBAjzDnFn/Og7LnUS8DnqYehsxAwbAuJ0pW
	9VDgKpo2hivQqN4FvtRKEk76w6DSo3a+OeNsJpAvrOPRBCPyNNkUqZC+Am4n0wYN
	N8iHIGdgWzzUkPVDxDPJk/P7bt6xNYVdQOWsVlHUyPtl5HEdqk7w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021133.outbound.protection.outlook.com [52.101.62.133])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a497vh8jt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 05:52:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChMrpjx6lEiIP1vdrXN4ygO75JKcD3ArZa3ycqi14Z0cqPRVniEpdsLShqxc+eHfvaeJgUrgN9mDPEt5eyvFXLckgFr41J4vxS+hLXoA3eSpjzA6XAaBsbhqVM1ksgndIxr+gqHPEv1F6pLuYpvBziIhWzkEOZ8zfTuFYi2BGhK2GR56cwEO9DIydCMe8DRqdWeSS5DzGFcyIoEDLqE5/vZE6cuDq+tGgSxk5dm6mjgBFe91t9SdMZd+VvSkwBsdLwI3kWrpuf2Vpnbx/WFMusIII2hS6JHATHLEfx0LbpwW5K5p0TnkPbJaZBaB0AbyG2w/4Bftms6hFT6Aqk0XRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXcFbVnZ9WFWYXzyiS8/cHPdLCfwUaOyVQ20QQmpy78=;
 b=e+JId5nyKcV7m0mhhmGErZBJCvweEDhfH1COS0GjsnSCebbvRBBnlSzT59bOqTnZuTlGgg7cnZKPP129ULmvQtH4HIX7oXW6YWxi2xDil9my5v+M7xiLTqZs2JC9L1Q3Do/D/ngajatr3KDpSj2QdUOwHyYryM2VdAqKUii5nW54anWl6JsDn0iVQSZYaBXfqk12snswF2NcaOcjua70PcftoKWrwY1DwPWKbXD/aBQOUP5YBLxbQtwuCsmMI7WzRIyOvpICr5jXElJfn3zt0V2s6+0pabPuR5SLNloo2mtm1OYd9Wn4UqFdl72SHr5D0bylP5gJycnOhJGW1ozEQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXcFbVnZ9WFWYXzyiS8/cHPdLCfwUaOyVQ20QQmpy78=;
 b=DPrWMujIcvtHf/3t8iJ9gG/qM2jde1ayPfjYkURTQQ0X08XGewOGRgZjEfz/RxPFh8Xz0OXZxH2nFnxo0Xu983wBiPuidBY8v6vh9eoq17JaKpjAC9IUt26lxxc9D9wHqWWvQhCjp8C6ZP6qwkTVFz5Rqb1s4slGNRFmR/Y100Y=
Received: from SN7PR18CA0001.namprd18.prod.outlook.com (2603:10b6:806:f3::15)
 by SJ0PR19MB4624.namprd19.prod.outlook.com (2603:10b6:a03:282::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Fri, 31 Oct
 2025 10:52:09 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::c3) by SN7PR18CA0001.outlook.office365.com
 (2603:10b6:806:f3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Fri, 31 Oct 2025 10:52:08 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 09C89406541;
	Fri, 31 Oct 2025 10:52:07 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6F4F6820257;
	Fri, 31 Oct 2025 10:52:05 +0000 (UTC)
Date: Fri, 31 Oct 2025 10:52:04 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sander Vanheule <sander@svanheule.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3 4/5] regcache: flat: Split ->populate() from ->init()
Message-ID: <aQSU1DHkNbih3lnt@opensource.cirrus.com>
References: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
 <20251031080540.3970776-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031080540.3970776-5-andriy.shevchenko@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SJ0PR19MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f10a1d-b5da-4b04-ac46-08de186b8a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Iu6XJkB4VWNhFgV9A2ZNCnX+JIqy6g8my2KE8wwZon28H07NKEUXYrwcYEt?=
 =?us-ascii?Q?rILshlIZVnVgQY3+W0FrrHTJPVjlIttEsvLeSr9qP0l8XbULjrme/voFiG+S?=
 =?us-ascii?Q?7hJZuL0FsPp/CtaSQuGsvwZ24nbldxvJlUjerw72HYYBYhwtCR7OaXSylsr5?=
 =?us-ascii?Q?iNEssmpKjEWyNKxL5Sj3yaA57mvz/7UocVTDlqWs6Tn0LmjQVAAGThMc7Jsn?=
 =?us-ascii?Q?u9q2UwaI9e5v9wqDiYNaw2VOIS+9tt3J5NaYqRwmy7o54wUOJFL04YqtkYT8?=
 =?us-ascii?Q?Yic94BvjTU9KhZhpehcY0YpNS+L/aSVUJWIJZBbeLstB/iq7I6W8+EK67W5Z?=
 =?us-ascii?Q?qfg4e1nXI5BOHuYCJYf/g1DuvtAo/UhQEPh0//6mN1eEytFaI7JgAI5TpnSu?=
 =?us-ascii?Q?/OaEVzer67FPxrkKKS+r/K8Hj4wWBtKbsScgBypqJFp3v3FRaTjnr+d5qpa/?=
 =?us-ascii?Q?G8vm6pQlKj2VAQQM0XRDgalvyfOOf74uTq6ukId7ecoHSndkqIsfpCDW/fDe?=
 =?us-ascii?Q?yhZ5ruxKQkBm6sZDc4hHzDnN+0jy4jkNTf2QmB5LyNZAfu8i73GojYYa9cIg?=
 =?us-ascii?Q?0fEUX5+ABX2aSCFlsvBRZhec56Oivqi5C52fpCHQ4nw8iwL6K1yYX/vBbK29?=
 =?us-ascii?Q?F7cnx3Ps28Nq+3KbTT7TgHSCIdTqIHmQomEQjRu8ha9NnsnhCTExOIaYZB9S?=
 =?us-ascii?Q?0SNK4ISDAeh8fSGJni0Q7FU1J/gyYhopUkM1JnJn7pbcYnP0u1le0ALggRSe?=
 =?us-ascii?Q?mWbns8oCJQYIE+3IzxTxScTpvhY4gnOEgNUQHB7cxBXn47ToRLCnW5oGtvjt?=
 =?us-ascii?Q?e+5zqZLkLozEB1YM+k89PmtGyonNThqN+6wfTA+IcF2/A2qUp9fAzsN1Pkat?=
 =?us-ascii?Q?kV7AEHmUc7ta0Y+5ikWNqx5eH1KjLft2CtrLXKWaKlfJ0SJZarp4YxM64oKY?=
 =?us-ascii?Q?Hr4E29i7S6K4FXKiHezYRcOEMqvcJrlS93X/pPpsKrnCKzyUpvrjLjABwFbj?=
 =?us-ascii?Q?n80yIzIxDk/V9lQxQRolJsOjQPbR6iWtDHoXNGNkF71f7xdGEPcCHOt5pmWT?=
 =?us-ascii?Q?GqNSN1K5L3CIdYGxVlfgAMZE9gRoc8zC98173Gv9T8f/wO+1EbvU4qr79wfm?=
 =?us-ascii?Q?930/96SvC3oYxhVQ9Qig2cdashZyAB+uFkdIYRp83jK9M6+1JpHAuP7C7tPo?=
 =?us-ascii?Q?fzY8AdXnBQfnw9pVMGuBsdkJS/UJleedNPotPDq+XIvdSwyY3h9DDOHg8Pj2?=
 =?us-ascii?Q?PSBFeK5tRfpPRyhxPKTzDD1oLH1JzevtyYBg2z35tn+X8ojZV5xBDav29qna?=
 =?us-ascii?Q?H9dtDYdUFRwtJ6+7zY4BnRzBaxQKS+NnV7XFbLZXzPFrJ/D1BhVU8V0PiUTX?=
 =?us-ascii?Q?ZVEYUTxeypz8B38hIFoS1Cfqr9Qml4ggI54MYtC4U3vyauw2tYgl0Hyp61wY?=
 =?us-ascii?Q?ebDPJGSZlHgSmBiJFpChK2mHVbwT5Pkzq/g2D5tKOMrpmSDnP1wbpnrf0Jo4?=
 =?us-ascii?Q?e0HwKgM7CsC6UYt1wkoBuSPVaa+0fI+UBiKbxtwX1OKaffuMHvJFeeTzWm68?=
 =?us-ascii?Q?zKg+F1cNpW33M/TOmrs=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:52:08.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f10a1d-b5da-4b04-ac46-08de186b8a1c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5OCBTYWx0ZWRfX5glzDExV3nak
 OqyRStlkcvMP6a+mNS3yyOq94B7Soi7FdxNsrCS7O+J10A6/wkUqjGfjwafpCRfRp7zC9DjMjKj
 iQR/9DnJj03ILZrKolaus1yG+D5Y2HR4WZSi1+2IlJSRuC0vBGyGjCgGCSz1hJeqQSYpCBA+0qQ
 mDZFvXPSVeKtmgZfvlIWLKlumHHpjWXzSjZPazXrUGOyQSYB9K9XMavcAzHa48VSkZ1fp+qwC1Z
 MMCsXnnpueyDaQ6Zl8sVnF9mlPMiojdhdgtRTI944pVqNAB/7fWEt1e++UBct1h2mbtlu1+xAMB
 Z+jhYiZ07r4gdlc4jA1/bZU0fpRwu9o/MugXscVL7xrJgsRA8pTUqImtP93n2Cgi0UO1KMaMBPq
 w6Rody1mqXYdXeb40Kthu+2XR79Dag==
X-Authority-Analysis: v=2.4 cv=Jtr8bc4C c=1 sm=1 tr=0 ts=690494de cx=c_pps
 a=0TjXLQglyxsLlDBGQ9rQow==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8
 a=y0tFvjTcr97v7v2fSIQA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 81iVBbEXq6-Do1DtwyJC7S308IopB4Xb
X-Proofpoint-ORIG-GUID: 81iVBbEXq6-Do1DtwyJC7S308IopB4Xb
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 31, 2025 at 09:03:19AM +0100, Andy Shevchenko wrote:
> Split ->populate() implementation from ->init() code.
> This decoupling will help for the further changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

