Return-Path: <linux-kernel+bounces-800315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6E1B43630
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DFD4837A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6FF2D0C89;
	Thu,  4 Sep 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XzhPKKUU";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="YA/cXRPC"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F729B79A;
	Thu,  4 Sep 2025 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975522; cv=fail; b=Usq6J0o5e63/Vy1+dSEhTC1Ya+iDDc4o6IeZhA+vFHQRYPmGg+/OE1rbxTux8UMES0dOf6jhsOPAnVbgw/MKL/o3IzjQ6zlMuNkIzWh+rNSIXLJZkoGToROgGy40cWHjPSms1p4c5kSKTdhHLddrXg8PJGPb4QwjWZ+HB1XvjdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975522; c=relaxed/simple;
	bh=SZR3XxNItGD8nc/kdF1x2ZIVWa3B6X4CLcSHUyjR0so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtCeMrS6yAxddvF2j3PO/7Cd9eA8PmuoOKjerx6imM8uszyGjy2TZM9PRq0I7IgZ9uECTSOtHgz8ioeHclbAy7C/pSXW57bZjx7qXjrnTUB2s81trqRgrCG4qCsWZopsmG99HmGK5/m9Vd0FqWPXXuIG3IQu6qjlBn+1jv9lA2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XzhPKKUU; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=YA/cXRPC; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 583KVND5858992;
	Thu, 4 Sep 2025 03:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=FjSLNBiMusDmAZVe0C
	Lq9lfmj8Xk6bs8AtNbKm86YZw=; b=XzhPKKUUqQLuZ+YLoDvkoxFIMfQ3z4MNHR
	qkrmxWvoC8nF0ieUwTBpEJSKFFvkLTV2rs2hF1cLbYB/rv41FgvFIcNd/Oa5A5cx
	NEv9x/zGPbbAUMiEg+MhvohkShXvoCn6NsMqzJWo0Jt9VxdmyvSgq9fpm4DSRAbV
	OKnozDaK78Q7jv+E0M67o7zZYejhd2WE3MY1UoycCfdrDVjS37Q1EHaBirisofix
	WmFYHD8jq8o89q6nc3G8wf6RxqqNmFMkZKXOKBjytByUaPjb2QWbPTdqy8E9Nl5E
	BpI95va/a9yHiYlLpuKtkg9HEKLBW5fcrIdq0wYBTE4Ad8arVDYg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2234.outbound.protection.outlook.com [52.100.155.234])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48vensdvbr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 03:45:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0CXQlcufUQJLEFc7EF8rCEhd+V7SccpxqnCErAMn2dsDQ5Jg1seKWgxYS3uBOZqmcfJ7i7YpwdW+NaNt0m5FJv6ZHNj921QmC/sNAwK16bAaKwm7XadS6E1tQVlDrsJeQQp4byC/+/+UMSE7KNc6BhX0scmRmDtmQQYB6U++DvY7HYIbK1Lrwf+MYpPEjM5NbDRyv9Z754Lxp6vAjms9oqDUtf5ujmAXphbONm9NuOx4e1tbOjJ6U1LdZDTgWzEYDhonoU8XrCZam58/eTzM/Hq7UR5KRQYGiz7HTBsd4lAr/OKf5zdASXvP0ZOjQPj5dlqSjvDL2nH0+3acpK4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjSLNBiMusDmAZVe0CLq9lfmj8Xk6bs8AtNbKm86YZw=;
 b=PsHG35SzNMF7/5JbdvZzytoxqo1n2bv/ooCzxldewJtySZDkoxMguRaCyf11aPUme3Uo1E7n1/nknYtvsTeTm70gS7+D5Dl4VHQU3wlijFFpDzWQ25cdyLaDlsJKLn03rO5YYXpCqEmEIAu9CPvBWkA6f+s4ooSj8PsVFm7ARRIQiLCbFwf8oiwy/AhXjZzQI5+RKe7fe79YEFfvS4zkmmWtYyPMQ9qKtgWxnVfsENblGui4eTNOKzqTkIjxQkkSrwiC2SdKf+YcujBtMHjyyVTbF5xr4c1HLAyQ5j1b4nNVd6HXRvQJtEH5kS3QnKJ12ySe35fn1PFeqPu2MQLr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjSLNBiMusDmAZVe0CLq9lfmj8Xk6bs8AtNbKm86YZw=;
 b=YA/cXRPCKfLO0/cWDOFOOud/eXOZSGtRJRA5+/mRwdO0WbHXf02GUALJCuClh7Eva/ezLIrwb3ILeE/vKEPex73fATMug3+y+bS4rpHoCKnzcuWw6gzVqFECNTW0cZLFmzlqjA3QY3Y0NdqpRRmxzzKjM28ysMag89aE2GmYWEo=
Received: from MN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:52d::34)
 by SN7PR19MB4783.namprd19.prod.outlook.com (2603:10b6:806:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Thu, 4 Sep
 2025 08:42:57 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::9f) by MN0PR04CA0029.outlook.office365.com
 (2603:10b6:208:52d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Thu,
 4 Sep 2025 08:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Thu, 4 Sep 2025 08:42:56 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 14B65406540;
	Thu,  4 Sep 2025 08:42:56 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id EA55282024A;
	Thu,  4 Sep 2025 08:42:55 +0000 (UTC)
Date: Thu, 4 Sep 2025 09:42:48 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-sound@vger.kernel.org, krzk+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh@kernel.org, conor+dt@kernel.org,
        drake@endlessm.com, katsuhiro@katsuster.net, matteomartelli3@gmail.com,
        zhoubinbin@loongson.cn, KCHSU0@nuvoton.com,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2 3/3] ASoC: dt-bindings: wlf,wm8960: Document routing
 strings (pin names)
Message-ID: <aLlRCEG0wWsqTT+V@opensource.cirrus.com>
References: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
 <20250903160119.83625-4-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903160119.83625-4-jihed.chaibi.dev@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SN7PR19MB4783:EE_
X-MS-Office365-Filtering-Correlation-Id: c937ffba-49c6-423b-c722-08ddeb8f0c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|61400799027|36860700013|7416014|376014|82310400026|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3LQY+ajSh8oeYcVveiq7z79xD/clWiJiTxE1cFhVZRLiEEO1pYFwBaOJuXdI?=
 =?us-ascii?Q?xWm7p9zwqs7AnakJNT+Io/rpD35FSP1M6pOT8m7oX2LXBni6bvUksyp2zk6O?=
 =?us-ascii?Q?voeTUopG9GgFfr6f/3E21Ma2et8oIvan5wMBR4Xg+fvVPsPvd49K4ypjsGfH?=
 =?us-ascii?Q?pq3g5hFFC7pIJTN8skBfhlvoBsEmH7qjTmgC4uzQVe+ryy4BmHlIclzZz6v3?=
 =?us-ascii?Q?bBWWqbe9kAiUcpYuIulF8P7V41mSUqmbgGNwnB4ao7KUyckSzTX1WWkgMlGE?=
 =?us-ascii?Q?BDhHo4VSkcxSlzdI47fZcAyUV5Hsycm+b4Dbm8xLARP99+ED8nawA+LKpyrD?=
 =?us-ascii?Q?JiF5KvJOo0OMCVkrF9sjk7R9QUrko/3pQQla9rw/DFbDPnLx9DkFsJp61g+n?=
 =?us-ascii?Q?TWVEWzMQqh7j6mAg1PkVJtoSW+fA3ZlMsJHvNnFnWkQ2gfGzGXV5DZn5KwTL?=
 =?us-ascii?Q?ur6pasWhHn8RkDsAf0QshUIMQDMBK0oe2WuBzHeINhROA/BpCj6yq2dFul5c?=
 =?us-ascii?Q?kknOkH18zqRqfzMdlpjI9Ir1FL44lwglpyDzcn3PVdJnXGB5pk2sLaq3Kg9k?=
 =?us-ascii?Q?kb3ffmLBNBmANOpoh8uwpN/Ha7u++PjslPctiKZopCcl/EtiM+gVimnQdQ3w?=
 =?us-ascii?Q?ma67h6O+h4ORwH3rJ/rUMzxr82GOWhwAmJFrpeMKm8GYNL6h7gmgSuEJSbB1?=
 =?us-ascii?Q?YMsS8L2hmF9npcGoJLpni0e2BPil8ySvmDp5buTrGbC/GMgUAq3vUIRObjPp?=
 =?us-ascii?Q?MtMLvwZ8NN7PKviOQeCGBoAmzDKKVJBX7CLcbhpTQ/u88Abz5Zs4V+XA3Pr9?=
 =?us-ascii?Q?Hvm6fGMIsL8diqqHgVJ8YshDcaj1mG5HPTB9uZrrWRWw7yPOipAyjo5FeVT9?=
 =?us-ascii?Q?93reSPDKK/zHdsRbdkHBeBwzjT5jQI8vRWkfkchdH2UgYhqM5TUmxh0AaKLQ?=
 =?us-ascii?Q?dz1VGAf4D4a5owh5qrsdUE7RnJhy7vilwqSROsHE7yKOMtkBd6+mc/Tm9eaS?=
 =?us-ascii?Q?ShkrUwqIrGN4/6ahigG3KUmSlGj64+uUBWzwb0/iqvL53+6Q5SndocU+FqyG?=
 =?us-ascii?Q?cVh5yBU2CGwK96oxHe38cx0Ole1byQwrWotdt1sW43L6yosRL5dp0S7HBHt8?=
 =?us-ascii?Q?VVamwiCK55ukCido2+pBfBUiZNIVmAKYfFS2MsfzRRwrsbEschnq+xcz11kQ?=
 =?us-ascii?Q?p9XcPy5QWspfk8PkVf1+iyZ1ZX6Ugz88AFCqtM0QWwlz06YUVLa2uWP1/XpS?=
 =?us-ascii?Q?MXsUzNCzhN/DVsofuHIyILXIS5wiaqmIGxUJ5x+f3UTDYKl8dYnof2LZsMu5?=
 =?us-ascii?Q?uBLFaHx22A+zp+lp9aFb5HFDZTnNNY/6udeohf/D50ZduukNbsD9wx0yap9d?=
 =?us-ascii?Q?cIeScZgLUKWsCU/UNGi6UgwnxuYjp+GL+SDSJ54bY67oSGmJ+HqW+42sbeho?=
 =?us-ascii?Q?r1CNVyrlz9oNYrZGPJslNtPBgWtJJnJ0hUBFktRaUd7SbWBqgGFFHFDtyA5f?=
 =?us-ascii?Q?4ckCnbriuBq0AsTAgHkvs+S5A7HGaLlCBnns?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(61400799027)(36860700013)(7416014)(376014)(82310400026)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:42:56.9530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c937ffba-49c6-423b-c722-08ddeb8f0c0f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4783
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDA4NSBTYWx0ZWRfX+WRQLceMf02v
 SAOvZkFCOj7n3LMev+wFs8MHaQ2LvZiwvLjH5Xa4YDwBjco8ncjPqfMTJiQgC3eAUmTIX+/iIl7
 9ieXu7Ha6hjp9nN8PM1B1TuQKhgzJBa9es6jAXA8KtCvq5Pm7ScK94SkJ1T96fwYgRhgcsHiA3g
 DcJWgb5K9MA0X1u+4HGxt8GD+Qa4z7cgD8FJHpJxxgXq7259NXYrs2FiBo4fnjKYLDFjzQ7H3ee
 XsCkZ0GL2tn5yTpCyKt/RoXuHH1xJHJgf2Fv2c9uuR27NOtQNeZbtpOgjta/1xusvdKm6bUJuR1
 ofD8sepuqez69Fme/e0ndnaswtF0QKqY9ji9TUd4XlVgunbJeamOIgEkGzz3iM=
X-Authority-Analysis: v=2.4 cv=BY/Y0qt2 c=1 sm=1 tr=0 ts=68b9518f cx=c_pps
 a=JJwXrzLqIvH9IQDf6WAMrA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=nAqlLpj85_Hn8JWBAUkA:9 a=CjuIK1q_8ugA:10
 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-GUID: xKlPsR3UaMfl3qyk1CVLweakeqpdsAIa
X-Proofpoint-ORIG-GUID: xKlPsR3UaMfl3qyk1CVLweakeqpdsAIa
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 03, 2025 at 06:01:19PM +0200, Jihed Chaibi wrote:
> Add a list of the wm8960 pin names to the binding's description to make
> it self-contained and improve the user experience for board developers.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> 
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

