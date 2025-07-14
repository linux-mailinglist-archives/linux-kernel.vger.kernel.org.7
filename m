Return-Path: <linux-kernel+bounces-730024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E658B03F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33011189FC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC0D253B56;
	Mon, 14 Jul 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TfFID7tl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rHatXrXr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8C24CEE8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498518; cv=fail; b=GmghaUBeJkUlEjMq2boezBa3izt291LyRS3s7BZv5jSHGejEAiEMfemLhLKwKTYJuAr4650uZbaToU5FEo6FWMhdCCF/EUWlGuo/w0kmbIkpnUNpngk07NLlDfESR0/012awQJb5qapHwITjzYk3ff+WbPz+JS2YM6z4Bx/Mzjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498518; c=relaxed/simple;
	bh=F5wtWlEgfCRLmlxk0iFY67kqBt29kXawS6bF710lIKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SyUuMKCq+HPYWBRIymh/iIzVe7I30fzHSPP5wPTuH4IYqasu1AFu1B+/z+w7SfAXu8rf1rComsvL4fJlcJJPgSYoun94DBd1JF4Ump4BilsRcnh7to9e4IehzHxvcnPBIV2i6HES1k3WqnaX2VmNAmFfQc1ARTGf9zGXFZNvzfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TfFID7tl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rHatXrXr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5nq031151;
	Mon, 14 Jul 2025 13:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=i3NlFKGrj4yrT5+Dw0ykZ9qQCdEthGzEp2slOEuJang=; b=
	TfFID7tlXQTergKcWFbgQ1/ZpLwgyEirSNWQ0igSlDSYoSxPLrZuKXF1NC4kfHGX
	kG9i9Zruvuo10qQZTU7F7tj0DFonxq1peY+u+Geqwg9+NvsLzIp4Lx9DC2FD4hCI
	nUhqvIk44ODy3DofeIASAPvLt3F5M9XqctmMQmYf5lEQquiCw5pQHzvFQjC5drBc
	dUpH68vnLdTsa/xqtFPa7VADuvYgyBOB2O6driiNmvk9aTPNXaLSozMta8+45nfq
	HN+8UxJqAwUouKeAMIZT2e/4OzL8g3Cf1PPZQw41srH+RdUVLgwomshkBfm70gXA
	e/Ztrls3mta1wf3pZKdJGg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0v27d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EB19tB030299;
	Mon, 14 Jul 2025 13:08:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58h91u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCjXKu1q0M3NM0L+mUm0iqgn+LAzjZS5esqZTbfTLWICKVfdfXux2nyzvKW+phG9HgE7gQZy5EvJbj/03Vqi82G/QPgV6SDN1FzEKIA6URkonBxi7Xx6mZERhUsmvkk8J0YJCfqyMW3HiyJ5xmD6oIqi0HS10FvE8AzTwnzdkzry9BnqayojHt+eMJvCo6mao5MBsnZcxqhrrjK13rcNRcn/OkPNWuuOp0huF8VxTxyhc60CFZuILJN4tb7yy08X2de2aMjPynkbm+2VumVBp2zeGOPCHAMVnJU0ohcodkNulNDeXku1AGcsGFSrfwYe/wFjWcRaIQdrNHZ78VNQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3NlFKGrj4yrT5+Dw0ykZ9qQCdEthGzEp2slOEuJang=;
 b=jjJuNUfRDzdXlfbeSBqOr8hXxYPiHfmt78EUTU0yzvmhfw9rtwFcKbbrpPoqd1xFcqAH8ND9UGmSZQKeKjX1IklPb2x7GhMGdUt5tKboBsNmRlET+dRuX/JsdDNdSuFaxPTWsMDAWGzuiFwg1ZZQH9Bv+rkn6vIN4fLr/sT7rk9jRMbNiTgdMtRSscr/1Lkbd8UnI/w08nDxm9aX+NIU+8zf8iKoqQgOLfCQgDfIrR1Sb+i0Iop67w1ijustR7JMssbjrr60F/dw+Lt6FzcPK82clAaS4lKFaFh0Fq3OBdy9/wxUVhzXrZ9jCFNrW8my5hTomE+0MMd0NJvTa4W8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3NlFKGrj4yrT5+Dw0ykZ9qQCdEthGzEp2slOEuJang=;
 b=rHatXrXrCYczTUfpC0YUEks+7RGx8DaNq4mmHg9LTX2jIpkzv88b0Hk1LOnEJR5PfpkPa0yMiZZcdI0wgEXYcqRu6XBXAtD18tM5S38q1wOFBx+W4+qmAYhlmPDKQNhDPMAb4fNXh1lbbl5Zo6KNnraTazNs9XQM8Mlo984IhJU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPF1F3678C2B.namprd10.prod.outlook.com (2603:10b6:518:1::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 13:08:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 13:08:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
Date: Mon, 14 Jul 2025 14:00:37 +0100
Message-ID: <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0667.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPF1F3678C2B:EE_
X-MS-Office365-Filtering-Correlation-Id: feff6f8e-9cc5-42ac-013e-08ddc2d77e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3T/z25ZGKiC52aQAjZ9IiyJnM4XiAQ8VOTAG3dFE04WR1769CFHVE9oKFqJA?=
 =?us-ascii?Q?n8nipAjTtwfi/z3SbmSqSbjrWure9T7Wi6IcNEI/F3u1Cu8D+f8AXtIlfuDR?=
 =?us-ascii?Q?p2xknBLrPGwd7998fvCNOiye6uOV5NU9i4i7ES0wy2wSDwWlSxW7+u9PWMhW?=
 =?us-ascii?Q?SfCx+iR3X7Voib3FI+1hhZlB+8NTKeVZz6qX/aoFJm0qS/PQzbL1xTV64q4G?=
 =?us-ascii?Q?/cSK3hr5O54bfaeyMMzBcGVcAtdi6R/HdR4jdENZG9kSCFiVlFC+CPSJQ64S?=
 =?us-ascii?Q?w97gw3eA+5UQwKhEzq+xvA0M4MdSnb0KELepwjig9o7ektL/+VhHNAMOjkNJ?=
 =?us-ascii?Q?KAJ3ZbwfhIslEN06JGEFYauWPHIXnXTvg06BsC2AiQySGgSSv035q68pkmAi?=
 =?us-ascii?Q?fDng8TEEcoTPO7Rm0M+9It2IpaRuuaZ+IcbhrlqQCm8dlJDGGooxetFH7rgf?=
 =?us-ascii?Q?3hrFV8dw5CbQ6W2pdyx35jmg5KSJvWaSfWJ4SPT8pCmCFUkBjgq9A3z6tyP5?=
 =?us-ascii?Q?lKqdpiCC/1gaaPuDoJ9+QYtnVywihSG7eqIkO/pRFoE63aTmekl6Dr851t3f?=
 =?us-ascii?Q?Sq3c6S43G/r7rJ/XI7kOjfejXbhHDWzxE5h9XAUbEpHfsratK8m8/Lc6Sra6?=
 =?us-ascii?Q?fgUEtXbi52RwhS9DnwBcOEMcTyjHOFLlF/iB21V//Crf7taaoZdslAEIBCn2?=
 =?us-ascii?Q?Anfz8frBAxAp7hDlBMSOpKm4ft2ECCJKGWAzS7V3BbiUcQWbddrvH2FqdGz0?=
 =?us-ascii?Q?EWH2cEB6wuSZUfgEOBtgG3pvEIm+D9oeagJVPRMQEJCIkQb70WPTaD5s+5pN?=
 =?us-ascii?Q?UPhGxIyojreXyN5RzeaPc0vx5433MjauXIC/Iio7/EXt1MAl2z7bPmSkd012?=
 =?us-ascii?Q?o+0gVYQ267N8lnwoiA52enamHEJftkxMYVe+v5nAADLycgGce4TYshAPsfrp?=
 =?us-ascii?Q?l5zt5pTON5kaH2Ah1TNYebfdU7YXPtJ4nDar3EQCg6xv1bq97mcEPomiPHVo?=
 =?us-ascii?Q?jcGIcQpk/F1vUzTaYEUnoOEcM1ub0y6nd5ejCs4PC3MPcyoeFaeZsTY+EdFP?=
 =?us-ascii?Q?zRUSYmCpYlc8ldBu5vjIunMZA/7Tv2fHN2bTgDlttEbFu4xNpRiYhh8YSRON?=
 =?us-ascii?Q?51amN+tSD6n1fzYxLud6Nb1eGXTQL8+/+goqjvj7T/tRTzVZlXGxh3NSG60k?=
 =?us-ascii?Q?ux5t5HO02T0eJuWYgQcQB9K97NGGBN2Pb3AeMPCIvNulYYg/7WfJJigPJ35g?=
 =?us-ascii?Q?0puvRA/QSmHw64Y9XkhNfw1pw8lroG0OnWZf729H44175WwZh1+p2n0yRQbo?=
 =?us-ascii?Q?OyIpGJ9AxWqc+J63fMyjO0U1cpRAlYGV4bN8FguUDijNl16scVlmE22dYOE8?=
 =?us-ascii?Q?oxrVRixTq3aJaU4FiuZcwhYDDz6CqqvExWly+x6W1EkJFgM1TyEj+y/jnxTY?=
 =?us-ascii?Q?n1MI3H7hNWY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OW6PCK+hSE8JzIiH6dVhHHezobxiOk94ICD+9HunN4/rPXDUINQ/cTueY/cO?=
 =?us-ascii?Q?RtMkeekP6rh2K6JE+gomukXaPNUxCEi+us17j+OP+HHdQ/DgALotEE0tevA5?=
 =?us-ascii?Q?geLMzm8H/YyKwNfp37Wj1ltP8aqF5Wucnio6iTb9uv+NtyvoLCpWs8/mvmhX?=
 =?us-ascii?Q?Gy6LXx2dM/2+TS525NxPmtfe+SgPTBSyZVtelaJ4xRVdJzSuTYOOMMWrjT84?=
 =?us-ascii?Q?LVlIDu1iDmoizKYvMUqL7iHlUL8fjg6+klKGCwpkyikLvD3BTC+X6kp1+pfG?=
 =?us-ascii?Q?Rej08Zel7S6F8SvL5XELFkw1BlYeQUPQX/Fz0v0LlkL9XLwnf5rx40qDtVmV?=
 =?us-ascii?Q?xZyC5ICSMZ8IGby8MlOwJyANKuBmrkfSUuUPvJUGha12ImBsgyvhqrLd/yys?=
 =?us-ascii?Q?4aHIVhkHbc71mRr30J8xq0/rVT2b0rRvcdP8Oc6SBMzzq+q+vwcUz5oldpS8?=
 =?us-ascii?Q?3EuljBX42pW2ChuscVEVCTxy86WOBUKqd++GT4epuSyVqSaY60WqSMT1hS6j?=
 =?us-ascii?Q?QhqgI/b/m8y875R0roGq6TVPF8EmZI83nabc/XB+x1agAK5O3NmxydlOnC6s?=
 =?us-ascii?Q?FIct6uHRtjO9RH8sacqOfxvhxPV6CNslCfyxtmaQXeVrjIk9h15Pj5j/SPgx?=
 =?us-ascii?Q?/UCnBy1PawWJYfAyYNCCdz8dgKyAwYEmeOvO7ydF6u8lA4EGknbAJuOW+0Uf?=
 =?us-ascii?Q?Brchu9YMdsS9mRFXgaSRntoK7twTBPWVSOFnMaqHoV28SMf+bB4Y05+lFtGJ?=
 =?us-ascii?Q?BXqSs+HuoRoMnxkrNnIcRENtCH0a08lDwv1eA8gGmbazpJUYFUZFuI3naB7C?=
 =?us-ascii?Q?WT8Lpl1vFd7VPI+0gPVr5FuO4v2WQyI7lHP1PrDFjjrDDPN6OzudUvVG3Ool?=
 =?us-ascii?Q?4FYXI3jGmTgYuhR3JQWxJDcptZkTlabNnO7ohg0/BYQB4x7Hw5luOFrLEile?=
 =?us-ascii?Q?J6QlEIQeSEVK6k6n/cuSbBS3GpH0gFqKu7a7RyJzprV9Frgxm9X6HZVnwqwn?=
 =?us-ascii?Q?N/8z1zDs1zkZeZwMuuAHDWHBkcSbt9TJSoRAdxzXwCVlnF63H2raUhUFThNN?=
 =?us-ascii?Q?4uKrbetpgRvtPckSS3HlTRfqXhL9dzP4OMLjbNDPZ8tx0KVMTFyd0YQDnCEi?=
 =?us-ascii?Q?MoFqM7AhkvY71K45nUUPhyIX5xGJTklN6KrQkr9gXBECIF2MyWGu2u0avtJD?=
 =?us-ascii?Q?nATJ0dfA7W5Sw4bdIfoTw6PVrV8bKn90xEE91OwRw/1U9/xF01PkGqqCao4G?=
 =?us-ascii?Q?ceuik0nvb9SWh7QVTgRoJKPImCgWnQWFqBABO6yMVR1/YFpLalsCI6hwAq89?=
 =?us-ascii?Q?Bb93NWcaVHWu3YAE7iLvY7y5t59Y7GBLAEpYyiRoj8/xTpbxwiNV4X8KRSMH?=
 =?us-ascii?Q?a/5ir93GsOfQujbzbKiiVhbtxv5Ro/r1hlmitswkqXq3/SqIxU4r/HxsTR00?=
 =?us-ascii?Q?JmFY8kN0vW3jXoNXgQzHpkTGcaBEHmsGzu0FWZV78OxcyzZKpxT26ImroKs7?=
 =?us-ascii?Q?8naR49kp44CX+8FwO48wn9syz1swLSaAFA1Sbwjl2zZ2QXtAve8Q47LBCJlS?=
 =?us-ascii?Q?1S7Qvmyi8LblPG4mxhJNoCZcKW/ilj81SwxpRiGenR6gKrrlJ22PNlOs+E3A?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DZWyMoY82d+WDNE2qy18W4CqdzEMoBH/Ul9zQoqYE+sY9pL9VaykbwZ/oWKZh+oefaiAkaAZDTJd0nMmhucTmp2SgtFHziRhOgYf+Ooe6IaH04Y8yuFl5ljbENpQbllP98nCeWCGKKSiX5qH0wHi5299nY2edU9PYgdNv/PlAW3kgAbmjOF3f6tc7HlHypZsAcgLlyditJNHq5icaRyavHKwzv48fb5ZBuZ6pbnSuDnqvS7fcy8vDKYjCWUIJDHqSLRK3pABdGGyyZ+FQxt8Mh5beZW0r0dNkEw2/M6fVv97XY+sqaEjLP1fg/GyaJvgKP9CDcTkL8GAFAGjxMlJ2t2uC0YSDYxQrMXd4GJgd0MXif5GevNK0zZL7ntH55xxXHi0EE7/h7OjrFf6vwTI15FCAKOIiIgNVq/YyNbt2FqyXjLXNd8s5Yr+rp59X5YZvRClOXJjLmLQSz7tp9WvMaCeN+z8IX+HM2XGojjf/lWSeGF+DwoCTzZabCir2ADQJ9xv/cPwn69oUyMrl0O+JblU262yi3bEmDkTV1z4U/scuASD7qpwQXnEJ5a07fRP53qW0ud4vRImMdiLsdj7zCBYL4kdF+G/LVhC1uPxYz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feff6f8e-9cc5-42ac-013e-08ddc2d77e61
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:08:15.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WhLi8qobOdAzr5iMR10PmAe5v1lSBhvR8DcaGctCGdHH/ep+APFy18CUJ43tMbd1tlxfLdC47eQkTM+RUFnudw0kledY9MVmoRFA6vxW+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1F3678C2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507140077
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68750143 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=rn4GbVJYIfTtwe4WNGEA:9
X-Proofpoint-ORIG-GUID: ggXTN95BSt0XgEf9xwVCIxCvYGOCdRsX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3NyBTYWx0ZWRfXzpzC8POYKBnD i2lUEJUMNB21FSLWpaM5ni43vZfDTAjsrkGWmxO2YXeH3soLM8RURptrEQwBZ9SUiNvaxHNe0/0 uFYGtS9lE8sLapg9+mEG1kiaa6MNk55AtYr+4V7iY2of/hYsinjuCyru3uvdUBkoQpqVhpaA+LP
 BzIkqaP35tuvxf0fHxb5Z5/9WlaXHDlLdxTf4fSBsHSq+fQJMSg//xo6HEgPXcDNaqkrwZwE6bg mCaskRkISnllCIUteMeh23SZAJKNpXnPc/m2ZrcmqaA6vO7WnJtZsV4AoI2Ff6ddjZ8SXNdr7cu U9JnhMZ1cIwjltTtZ4rl4zaE54v2f46bnw+MqBHXiDHK20oF3UgUAytDWWda2XqLcMK4HX7Psiv
 x5ugPvRzhZwLIkv3QIMaxuXDJmIOR5doRRQmbteM8a60ri62fmOLQGc64kYdLQJorYBgpq8r
X-Proofpoint-GUID: ggXTN95BSt0XgEf9xwVCIxCvYGOCdRsX

The madvise() logic is inexplicably performed in mm/mseal.c - this ought to
be located in mm/madvise.c.

Additionally can_modify_vma_madv() is inconsistently named and, in
combination with is_ro_anon(), is very confusing logic.

Put a static function in mm/madvise.c instead - can_madvise_modify() - that
spells out exactly what's happening. Also explicitly check for an anon VMA.

Additionally add commentary to explain what's going on.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/mseal.c   | 49 -----------------------------------------
 mm/vma.h     |  7 ------
 3 files changed, 61 insertions(+), 57 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 9de9b7c797c6..75757ba418a8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/mmu_context.h>
 #include <linux/string.h>
 #include <linux/uio.h>
 #include <linux/ksm.h>
@@ -1256,6 +1257,65 @@ static long madvise_guard_remove(struct madvise_behavior *madv_behavior)
 			       &guard_remove_walk_ops, NULL);
 }

+#ifdef CONFIG_64BIT
+/* Does the madvise operation result in discarding of mapped data? */
+static bool is_discard(int behavior)
+{
+	switch (behavior) {
+	case MADV_FREE:
+	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
+	case MADV_REMOVE:
+	case MADV_DONTFORK:
+	case MADV_WIPEONFORK:
+	case MADV_GUARD_INSTALL:
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * We are restricted from madvise()'ing mseal()'d VMAs only in very particular
+ * circumstances - discarding of data from read-only anonymous SEALED mappings.
+ *
+ * This is because users cannot trivally discard data from these VMAs, and may
+ * only do so via an appropriate madvise() call.
+ */
+static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
+{
+	struct vm_area_struct *vma = madv_behavior->vma;
+
+	/* If the operation won't discard, we're good. */
+	if (!is_discard(madv_behavior->behavior))
+		return true;
+
+	/* If the VMA isn't sealed we're also good. */
+	if (can_modify_vma(vma))
+		return true;
+
+	/* File-backed mappings don't lose data on discard. */
+	if (!vma_is_anonymous(vma))
+		return true;
+
+	/*
+	 * If the VMA is writable and the architecture permits write access,
+	 * then discarding is fine.
+	 */
+	if ((vma->vm_flags & VM_WRITE) &&
+	    arch_vma_access_permitted(vma, /* write= */ true,
+			/* execute= */ false, /* foreign= */ false))
+		return true;
+
+	return false;
+}
+#else
+static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
+{
+	return true;
+}
+#endif
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1269,7 +1329,7 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 	struct madvise_behavior_range *range = &madv_behavior->range;
 	int error;

-	if (unlikely(!can_modify_vma_madv(madv_behavior->vma, behavior)))
+	if (unlikely(!can_madvise_modify(madv_behavior)))
 		return -EPERM;

 	switch (behavior) {
diff --git a/mm/mseal.c b/mm/mseal.c
index c27197ac04e8..1308e88ab184 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -11,7 +11,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
-#include <linux/mmu_context.h>
 #include <linux/syscalls.h>
 #include <linux/sched.h>
 #include "internal.h"
@@ -21,54 +20,6 @@ static inline void set_vma_sealed(struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_SEALED);
 }

-static bool is_madv_discard(int behavior)
-{
-	switch (behavior) {
-	case MADV_FREE:
-	case MADV_DONTNEED:
-	case MADV_DONTNEED_LOCKED:
-	case MADV_REMOVE:
-	case MADV_DONTFORK:
-	case MADV_WIPEONFORK:
-	case MADV_GUARD_INSTALL:
-		return true;
-	}
-
-	return false;
-}
-
-static bool is_ro_anon(struct vm_area_struct *vma)
-{
-	/* check anonymous mapping. */
-	if (vma->vm_file || vma->vm_flags & VM_SHARED)
-		return false;
-
-	/*
-	 * check for non-writable:
-	 * PROT=RO or PKRU is not writeable.
-	 */
-	if (!(vma->vm_flags & VM_WRITE) ||
-		!arch_vma_access_permitted(vma, true, false, false))
-		return true;
-
-	return false;
-}
-
-/*
- * Check if a vma is allowed to be modified by madvise.
- */
-bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
-{
-	if (!is_madv_discard(behavior))
-		return true;
-
-	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
-		return false;
-
-	/* Allow by default. */
-	return true;
-}
-
 static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct **prev, unsigned long start,
 		unsigned long end, vm_flags_t newflags)
diff --git a/mm/vma.h b/mm/vma.h
index cf6e3a6371b6..6515045ba342 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -578,8 +578,6 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 	return true;
 }

-bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
-
 #else

 static inline bool can_modify_vma(struct vm_area_struct *vma)
@@ -587,11 +585,6 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 	return true;
 }

-static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
-{
-	return true;
-}
-
 #endif

 #if defined(CONFIG_STACK_GROWSUP)
--
2.50.1

