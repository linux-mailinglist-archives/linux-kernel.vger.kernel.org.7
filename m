Return-Path: <linux-kernel+bounces-829722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A757B97B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150DD2E8559
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A0630BB9E;
	Tue, 23 Sep 2025 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VLeXlADs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xeirB9qg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55024A48
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666368; cv=fail; b=TODvw9mnE74YVbJ1CrTPXPn9UjYJzBZiCQ0BH6kZ4ijCex6Be0bPTh/qLyj0TkLEEEA+LyqTnAy5up7fd3T2D0/6RtMzXD75AJ/bQgcR2UOAJeCp/oHPsn0yyQ9GhNTRA2bSKZrHeFNpYzfSiaBpeRWSBuvHnd29OwydfS+RcGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666368; c=relaxed/simple;
	bh=6RJv9yOHVzB3bLe3l+vLe1kBRC9Sq4r6TKHrFpUwb7w=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=m5+NOD33F+SzfVEwuLemHVXKI18XvpssjNjniix7lqRKWeGlASem1ZwIX4tkOuqgaXnqVSx/5GZ8TX/+mKVfSWL4vRdPmaF6Hnl2EUAEIADndEUkFqDrMcWFclndL1ui8PSvOTU00vA2y1DLg/h8NmXJSm7RXE7kiCqA1lZjpOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VLeXlADs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xeirB9qg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NLbNGk023862;
	Tue, 23 Sep 2025 22:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Cvtw8BdC0XKadnd+Cu
	PkryqxadvnXTxhX1O4ktwT87g=; b=VLeXlADsc1uRjDitQ8tPEOhWs2Di/bvUD4
	zCDHy8q5XcX+6K6bu62EcqFWvVEayVhztHZ2M6UNM5GQPLJhy2PNmgx0EyukCeGY
	7a5zILTj99dcLf/8BGgkGJT7DMcGYQBzm6Q2Jbbe0+7+X69DtmImqAklqo55wjjE
	v6mYoZ35inw5QGrEjSonUPxXSo+k0nJDheH8YN1gCpfuaRZwcUNW2JETnxa4/GcX
	6cePMflYvlJCoCTF7zPIWNGZ4pcA4DdAWOuPdR43osooHu51/1t0ARtI1JCwU5vK
	DKEiVAseZPx5JjbiGPIcUYfSJHbV0eF9FgRuh0N1VCDzcg+LXtKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k23dqma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 22:25:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58NLliuE028395;
	Tue, 23 Sep 2025 22:25:13 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq92qg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 22:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmUVmvq1dZVcD0yZBeI5BM/ANd/m0LZPOTggUOC0a+tCjZjJieviuFBrI1DtDpUoORHZldD5Zz0PQbWmcuk3q4DfChAl6p8xHsHUG4I1pTGA+p8OvTotlNU5O9JFhDu9W9IaMikVxx4/XuLuSMHv/aFBF1EOLT9BgOR7hSlEh11Q1TLp6PuAC/oGm7kxcNI+J+k9jIS8JGKFzk99No3rYuVVKRFt5VN2IUBS+iicDdP7TKgW1G985Gbglz7tJTyVZPinnu1LL+vWYKesBlkh8oSA0SkZG8HlRGGDGVuRL24Qo84+zf9Q7OhxjztKOyEz0+kkOwTRk7EvxDfkPwDHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cvtw8BdC0XKadnd+CuPkryqxadvnXTxhX1O4ktwT87g=;
 b=PlJS8lTWSB5muFF2wJHl6ysgyzPSlUwn5167BywmKQKOT68C27hVkwHqFzgB8G6vN7ec8aIpbqYXC0R7rCqvpKfDIHQt44K9f/6amYB8Y362e8o8eqfz71mT2PMX45Ps/Q9g5OtGDtc+in3eG6ACvxoU8NL8l6mb/2ZSMNB3mLAZRFRbxmsW/6ccBGNpkH/LNqbEXANbUnzWrgbEtMdo5bJpVZO6JZnkKiBlFye/i4iy3Q4gBAwS7UFjC++YRACp/RZ7N4SVd/lGI8gSJw/X+UjEJp1fHRPEh7Xq1I2RRzknjDoVyuWXLAk4WfF1s21jz4UhcyzA9zKRUanBspz4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cvtw8BdC0XKadnd+CuPkryqxadvnXTxhX1O4ktwT87g=;
 b=xeirB9qgb8QFx0oQTvxtn7FPljM/r/vvSZUE82bSqcTVZtMCsZJOsvHfbot+Cc7/s3v6/UpMksuqEwHGJzmCKttEOxYWXgNuxeiJtgzpJROa4+VADto0L4QuUhR301hnBtkrNLMD3ERkKS7gtrXox5F6GG+B4Ar2iPqzye/hHR4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7307.namprd10.prod.outlook.com (2603:10b6:610:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 22:25:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9137.017; Tue, 23 Sep 2025
 22:25:10 +0000
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-13-ankur.a.arora@oracle.com>
 <d2dca02c-ec5a-4b3d-92fe-2b3a3614b5df@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v7 12/16] arm: mm: define clear_user_highpages()
In-reply-to: <d2dca02c-ec5a-4b3d-92fe-2b3a3614b5df@redhat.com>
Date: Tue, 23 Sep 2025 15:25:08 -0700
Message-ID: <87jz1obyd7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 74abb5e2-b80d-45c2-9023-08ddfaf00e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vGfMRHbUydAfx2Rm3+wZ8QAL9xgaauu8geTkzy2Ej9GORDX3PitZWmL377pR?=
 =?us-ascii?Q?BdkhTyoWvBomiMRuPyXsAf0nWiGXquRrUFXAvFV5grOjZQRw/4beFk5LbGea?=
 =?us-ascii?Q?zG9T1SyPkonso0TaQdsWucYHXDOW2HopMlHQyCN2jqZnYRg3QFNIpbd8pnep?=
 =?us-ascii?Q?EXdRmSG1TS0wRX+sNaZSw94B6qAYUDRA9CTipAzhuBXPjx9Ncmg+wlwiktpb?=
 =?us-ascii?Q?+HJ4zJzgYlPi29DESQGs1LGg1eHpR1fqfrvjBaE11cPoQ0iksMXVwFkbbIeL?=
 =?us-ascii?Q?KpNzfmb8JhsDVJQis17h+N6fIGYmcrwKuoqF4oe/XIq/zbKN1o1PGqniuAPw?=
 =?us-ascii?Q?3HL69+yF49LaCnD79mlDVbdZ/kqdZTJc1WVnwiiXB94K2MfFQHgQPCVFnxBF?=
 =?us-ascii?Q?tCCYHJj/WirggYA279gPZitXdZlXk0UZjIcqWSNrwujtJdfm13kaFfnXF3Xr?=
 =?us-ascii?Q?FjzkWefQzNoNzgF7rQDPbID5CeuNB7zVjrU9VAM5XmsQteqTY48GPLFvlWPB?=
 =?us-ascii?Q?xXv4u0Kkvpc1l+ROlv/bVJmTTf3ro3uQLj0wzFqPyoNA4qlKD/PveLFqTcvI?=
 =?us-ascii?Q?dadSc3bwQH7aMl+nLJNI5oRBl+Cr+X2uzQ2HvcPw8K7jK2w0KmwLLOLV/V2r?=
 =?us-ascii?Q?de36Kvr3HiFJOm59Fq59U+0b4agINZh78OIYpjhYdlUpZtyWeayuyPDIuALy?=
 =?us-ascii?Q?obW5AMNPO9wgTSvnzXTz6f17b3uSVosVUxGlMqC824ZL8a4dxlAXvj8Z2h89?=
 =?us-ascii?Q?h/2W73GHojR8Y2RbVUy/j4lkFagJubbYJSpgUrmuWbZgZw/pVMJ+idDH2YQz?=
 =?us-ascii?Q?gpAN0MMhW8GhQfrN6B9qB9nuQx9d20OspIOVlyzGdqannPdSxpjN326PWCKa?=
 =?us-ascii?Q?hx4nt2koua9vFJZH9P+Aya4PscJW/iHYNIW3d7rSqKEHnKHZ0FjbRvYQa6M5?=
 =?us-ascii?Q?9n1Amyx4WSzBRD6m9pM7D8hyA6dhY7wJyLgk4ceXU7BYLfuf7qcwhxjmqmR7?=
 =?us-ascii?Q?kP2CLcjqM7nlmqUb/hnIfvKWsdhlZkxp+OotqUW4VIkKz8yN9e4XJ4wP92mV?=
 =?us-ascii?Q?PCfEztDNtnt2u/mQ2PFfD1B9DQSyozecdVKbr86J5uEZFZ7UP6N80RupsXJj?=
 =?us-ascii?Q?VlHsNiIV5fGXs+fVIAwoVYDS6QymefyfSEcL9Eek+wkCZebxJqL0hOn/2s9n?=
 =?us-ascii?Q?TbWcbAylPBKgk0O9VkkV6Zl31NaY7LakOchNWJK4B3M9Ud6MDQ4/1aFnBt3P?=
 =?us-ascii?Q?JtzVwVyduOBGirqFqFvRVHfVEcuJoPgtNCDNml1Kmy0WZ+Q53iRkbg/oYoIJ?=
 =?us-ascii?Q?6qTJ2ZM93pQC1cgbQMVim+ylxf9J8jsT4bg7zdsfH+WELhfnQvj4r2NXCL2c?=
 =?us-ascii?Q?283xckdnJrBAOSBpQTY9zWMI01alWg0ZU19WEt3SQygIlErwGhHbUywRAinW?=
 =?us-ascii?Q?s8CK4xipQmI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DygfAJBDXCS/RMgqwc8bKcutkFaDpe8dbF9mcd9MegFNX3CcX+h+Uu14VDIM?=
 =?us-ascii?Q?h/FAF/7S8KZL9gTTcg+GEbxf6MQTKpSG3cc40dUCB/SPtq/b7lojEV0pS/+K?=
 =?us-ascii?Q?VXFtruGEGV3ebGclpE01+fN/A5avHGxpyMEonxuaC+RewtwSq28jaRZLI+a1?=
 =?us-ascii?Q?k8G1MutN+ZhEg44JiiNa5OvYMgKaFyrmPkef1NLbG1fQI2A0emmgvnewmmHP?=
 =?us-ascii?Q?1pfuoj86voCHW27iJd9uwfWnUZzqc+nHpBz/cWX/JJz7MVHJA8Y3xt7QzOIA?=
 =?us-ascii?Q?klkKV6kzD8VWCN8it+sImJlhHt3WI5c2QGSafNpAB8mNztYceFpCbbcamwfu?=
 =?us-ascii?Q?/tP6eAtAT0m+8lYFnbYdo4zbbxq+nnUIWWqVHU7MrsiOmN9/L57sc/PmnWr+?=
 =?us-ascii?Q?Bg64YFO8QH5yTQnRIjcY/mWP4JmzEVxJhkVyC81gzTNgyQijUWVCsewod91L?=
 =?us-ascii?Q?YFtOw4WDOL95j43XdiquNoGbga0SBpDYDsBRHWi0Hy25lLmnma0ZKNkOzQxg?=
 =?us-ascii?Q?zF4O4pRReLcubg2K+EGWPosouwXj4pvz3N6VX3uMK/nly/cLbNaK3hd9NLgk?=
 =?us-ascii?Q?+lJWXdU0F0DG81XUFgNJDmptakBojPS/tmCzB7Qqg14mPkPc9CaA4nIO3TaO?=
 =?us-ascii?Q?b3C1LG4xOWGBtQVN1foFdV0Nvp2LwZ+Zlryi8QsVoUjob7D5G0W+Bk8IWVaz?=
 =?us-ascii?Q?sM9gRa2U67lxYcpe85f6vzroybFT3R3om+S5B74CJP0Wpxx3KfKGiXy3rXMG?=
 =?us-ascii?Q?ZovsqxQZIviwAypXTLmPv5owRdS9kcfMs7U2DCfxSQpDLLrXxbD7zMDeEsz/?=
 =?us-ascii?Q?JjQvehWAj5uZOyhjypcm3wYFQ7WXsIEeGcRNoeDV3nq1+QNC3aeMU/MWJ6Lk?=
 =?us-ascii?Q?QZbp0u4RyTTXou67raktSA98A3xeUI+QFQjyNTl4ob5hEnNLhocZqYEGE1GS?=
 =?us-ascii?Q?I8zvX9eCEwyd7/tWiHoaBOyNfN48zjOfamwJHSz29gxx0lEi4vt+lCvBRjrr?=
 =?us-ascii?Q?EgN4rJVthZpCI+pkoSOviOSyHc0RJR3XtUrqiUwaP5KAxAEqDE2ZEkJLSO6c?=
 =?us-ascii?Q?DzyLw9L44Vepgtw+ErL1eao6GhPdCfrArSiTlF1z49Sb+RRJnNR9J7JB+RLG?=
 =?us-ascii?Q?0Qs2v2V4legcTEBVMoPCorRQy9heVBOrUkT2jYoxPpHLsa67q4GMHRxr5evq?=
 =?us-ascii?Q?DZ94zNn+Qq4mTJZN292ZXZCk6a5odwwVR/Jr4iMtTaS+dBqcYdFm2MaVD4mP?=
 =?us-ascii?Q?vE60vAps0B7Ov9DH2PKpCYVr7/XMnjCBbwH72xQqdxm14ilqyxjrdWDTW/0j?=
 =?us-ascii?Q?KdiOwH1+uc2i/O1XJnuRGETZyL3FtlkspN3B2JTV2KRPSO+uvupwk4KU2XxU?=
 =?us-ascii?Q?sL8/W/ejVr6pSGRDxTPNsoQFFeT+g69UhYhouzRv8kbn9oDe3SjalYDdyjUZ?=
 =?us-ascii?Q?+468X/SxDHuIUfig0lIauwIMiZuq1F1if7WE1IYJWDpmxqOmsEYu1+bRjvE4?=
 =?us-ascii?Q?XBsKFH1AUWhwO8QByvIT1XanSSDfgHwFuTnJcdt8J7x7wLW5qKxMZxqASbGQ?=
 =?us-ascii?Q?bfm3q1qUkGlGGEGA6BU+/ezBZfGZAZDaAvHXQHs3RX+1RLpIIQN2jZ+IfFMa?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XEj9UZeZ0KzagvFQz6vNhxLjEFC+WFeCrc5zER73JboovIFNZYa4gsSZdYdnvQ3+jgzCOR/+1fPS5M5bue0OWn2p9+5lJ7KVQSBJJY1SQwFEqJSH87Y9au5FYXsB2Q+7vsLXtB0QjjWtrlnE8A0uPO3gVDhx5xoxGfWkkajPaniq6rxVCymJhsN6ong3xo8RhMk28VAa60f1K/vtl4dDY3n6FTr84YPaj0kahVppIA4g2N9Dy5r6Ge/04YDPdjE99yN417slz8VAN0DaC/T9MpDZZqKojkUrCEZ66S0LFCDTC/OzhaGuhaykrIJ5xu66FUBrlO/K2n22OSe387eDQwBcLGDCN2JSFP76qjk5BGhat2IpZQ9B8oZO5V/ZVw1XRBOwjtnc5xqoHsQiI2Ih4C7jv9XjXEh87v5XfinLxAyh2TTi+r22aczNuNSMqbDcn22ef4A5ctR04idneQ5/+IO9klukYSjWBy/8xqm/+axHP5Y5eMlZ4xdFRXV2ieuIKy6CUpyZ34S+Sxzs3W/zEoEJu2UhAvW1FcfPumafe74yDCZhvbKjmBktUAFJbCXKgr8fMtMgy9aWswDKDqzE1m0GkNpHWUxVJJfSnrYAsB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74abb5e2-b80d-45c2-9023-08ddfaf00e6d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 22:25:09.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHFHVJdtVvEiwBcSFKBP9eQdG2gM3TFEA6ll6nFl8XPWFq+aQmHrsKHHHSHJbpcFWuoSnmAg4k+ZJRwciGkrTN3U5k1N3aHsJ+kKDmCbQTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_06,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=721 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509230204
X-Authority-Analysis: v=2.4 cv=C5XpyRP+ c=1 sm=1 tr=0 ts=68d31e4a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=hh4u7GO6P_rPUrxy3ZQA:9
X-Proofpoint-GUID: Ac4_zvxPBGtqtom9ZZkwA5CzasGi1xqM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNiBTYWx0ZWRfX84CDLpXrU6cR
 CpAeLBMaa9O7LSkoPFXneT7ujpEbZIjdJJYnJnWaD27s1KBPS+PqVPPPJV27nS6Xuv7ldl0qnce
 WvZ0FnH2sj8jkiYXXzLIdBC49ZUX2qAiGqLeLCtrNB79RlCN0hN/u5HdncmHGTX3NIoP2NaTB53
 AO/pf5/njiYfpfgUrf+wJce9j/HPTI54jjTAQVH/nGTaayq8Vh0kumhzYU8EX1mhFvqlFx7z/z3
 rCF0s5riyx62Mfp1U5jZVgoEGKFKgsuawOpLrhxAOxafG36Zt1y0RRQ80VNjfh+xT8S80Q8+8BK
 XQEWpkPnGfD71mGPuAb1a1i4JmqET5MGYaSoafuH/mr1LdJviFOQ5rki54JLJo12RPHGeXpj1bv
 SvsKOCy2
X-Proofpoint-ORIG-GUID: Ac4_zvxPBGtqtom9ZZkwA5CzasGi1xqM


David Hildenbrand <david@redhat.com> writes:

> On 17.09.25 17:24, Ankur Arora wrote:
>> For configurations with CONFIG_MMU we do not define clear_user_page().
>> This runs into issues for configurations with !CONFIG_HIGHMEM, because
>> clear_user_highpages() expects to clear_user_page() (via a default
>> version of clear_user_pages()).
>
> I'm confused. Can you elaborate once more why we cannot take care of that in
> common code?

So my definition of clear_user_highpages,

    +#ifndef clear_user_highpages
    +static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
    +					unsigned int npages)
    +{
    +	if (!IS_ENABLED(CONFIG_HIGHMEM)) {
    +		void *base = page_address(page);
    +		clear_user_pages(base, vaddr, page, npages);
    +		return;
    +	}
    +
    +	do {
    +		clear_user_highpage(page, vaddr);
    +		vaddr += PAGE_SIZE;
    +		page++;
    +	} while (--npages);
    +}
    +#endif

assumes one of the following:

  1. clear_user_highpages is defined by the architecture or,
  2. HIGHMEM => arch defines clear_user_highpage or clear_user_page
  3. !HIGHMEM => arch defines clear_user_pages or clear_user_page

Case 2 is fine, since ARM has clear_user_highpage().

Case 3 runs into a problem since ARM doesn't have clear_user_pages()
or clear_user_page() (it does have the second, but only with !CONFIG_MMU).

> If it's about clear_user_pages(), then you can just switch from
> !IS_ENABLED(CONFIG_HIGHMEM) to ifdef in patch #11.

It's worse than just clear_user_pages(), since we will have
clear_user_pages() (due to the defintion in patch-10) but that
is broken since the arch doesn't define clear_user_page().

I think the fallback defintions of clear_user_highpages() and
clear_user_pages() are reasonably sane so this needs to be addressed
in the arch code.

I defined clear_user_highpages() since it already has clear_user_highpage().

Another solution might be to define clear_user_page() for ARM which
would also address the broken-ness of clear_user_pages() but that
is more intrusive since that needs actual knowledge of the ARM mapping
model(s).

--
ankur

