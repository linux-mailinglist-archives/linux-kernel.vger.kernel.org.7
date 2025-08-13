Return-Path: <linux-kernel+bounces-765917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC1DB23FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9902372558F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B9D28D828;
	Wed, 13 Aug 2025 04:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pgsL/Eru";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mjPbmtd9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1384623D7E4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060521; cv=fail; b=NneU1eO7lFA4hqg5nFVqE/QDt3MvLeJwZ0UXXB7HqQ9Bg3wBtiNfTg7bXWM2GhAezh0bsH0NSNZXuu77GO7/tCN7/9uMQzCrNcKxQAs/ZkhXrIaLjSxkEMM085XDy/B1umTc6mAArWN+xewszuV39qpsCKK6GI73YUSZWojwdNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060521; c=relaxed/simple;
	bh=P7ne/8eIDNq8/Vx6ozopSESGXbjGkmh4auYFVmgGHkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZ6xd8Tb+fRhErFQtAfrYKPTKJpnYLqIN3zumAwnpGd3iu+HPG3+TiJWYKEH1+zRI1ePxd0Vrbq0sz/6OYfFjN0tjNZw34KktYz4uq2of+g2MnjXLVShUvyBVcZJtNzz6u1Y6/ry9YbkwvYFGaLVUXKkqqPbfs7pJnBGYed+MOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pgsL/Eru; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mjPbmtd9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CLREXV028955;
	Wed, 13 Aug 2025 04:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Hk2/uFdvfZhdmCEk5W
	1gwwC09di6G0sxgWWcj02Unpk=; b=pgsL/Eruv1Zten/V1Wcl9WBW7S0ag5Cigc
	IF1rDJjjLE850qlWeo3E2F0PgTLhByfCGIMA98x3EqWzXyVGUrnp4n8LQ29yL7EG
	baulGuDYtS7Ph3yU4uJKgVYp3SuIsk/rTjaU8dM6t3kCzV2AkEBtSZIZS/Xy3HRI
	t2dT147ZKUGZ0fcXNL4DuTj99Tkh/TwqxO67l+rPFazsr8zkXVSiHWsMqPOUB1SJ
	Cxlae74o/WCL7Bk13m57p4Aorb+az2p2OmZFhU9k3m5PelLFN18gaGJ55p8rdVeo
	Q/YGViAt3y24tziwIKJgq0jrwBgc10JVQRbIAFR69slr/uzBmloA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv6bha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 04:48:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D2UfnG030247;
	Wed, 13 Aug 2025 04:48:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsav5n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 04:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt+9hgwvIspwbix3fhnOWoF7AgVTrIWTgyhre3h2DAW/OtOBvNRbPm1cLYIO76U9ToOQjTdMsigHB2/q+LEywKwCH2ePwPvl8z2nvDzPZoOnDtzMZLIevEjSkfBlGmPD1UEAXk7LQB2dx//xkcZMcgGaYCpxq51/ecpJ1oH222ZhM5GKV80n1YnH/Dn7SsBN7IyHAuNwKFxjmlglMuGrkJjYJ0Ls6p7JavlJsm+cL+NLy1nM4XAZpLBoY5aFSFGXQL0IUUvUxyLraStf/FujfThyhvmB6rtpm87V50KG+4w9OKYX3QFXQQw3NVO8binqov0WVGVdq//AnlO4XzdTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hk2/uFdvfZhdmCEk5W1gwwC09di6G0sxgWWcj02Unpk=;
 b=Xfeb7uWID6TGY+xOgZJ7Nfyi0fN/J3TZSKAVGU9izRQPM9rJjwdx+EDgvI5X8xJ4PgAroioeJI+GiGuqdsanV52X/4wGbD7sOyx7a3xoWlDDhZMT+ofTLrLPwTwXWhtP4k8IBDpr3cQppO6nriPPyCJZ/ISqonbS7dKAUwSRQrwVGNIrwPtkLor22cXifqMoPJvj6ZGhcioilHtJ0AmMFOu1Da8Xa0WzFsWED/4dpS9t83wUz23ThVZK9brmm3D+4zT0mDCpjtsM3ggLDC04rZNWgE0swfqCOkhhOLoDULYxz1+vL4tJx7aCSXIMcEx6jHdfHsxiKzWO7bTQ9NyKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk2/uFdvfZhdmCEk5W1gwwC09di6G0sxgWWcj02Unpk=;
 b=mjPbmtd9DFqp1ecDWJRHCSloM98Eoy6A6utY/Nv57UZn4z36xZjv0jToAJqqMPW+SUCi1DEX2vtvWeHTtQbo6f6vf0qu7MfISzaZCjCO1Xpjd22dKYUBSi3kT5SkcFVt0pJjvFwXEXxrBFxpg9uP4onFACt5Zqf3099iVALPSsk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF01BF54C53.namprd10.prod.outlook.com (2603:10b6:f:fc00::c05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 04:47:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 04:47:55 +0000
Date: Wed, 13 Aug 2025 05:47:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pfalcato@suse.de,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
Message-ID: <664ea661-081a-4040-96c4-26307ba020ed@lucifer.local>
References: <689bb893.050a0220.7f033.013a.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689bb893.050a0220.7f033.013a.GAE@google.com>
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF01BF54C53:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b68278-baaa-413f-ca4d-08ddda2491ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/unAHiGJAUHVcq2zYgMFrARJHyU+b1PdXlhOScQXNSXoGOVJhRCRXonhwGNE?=
 =?us-ascii?Q?YjdVnWujJVGoQNSnfmj36BvipvkRb97mf4bqVdF54nXezuzOgiJcH+0PJ6fX?=
 =?us-ascii?Q?4aH2qkg2yDQTLQtfeAZLRn0w7MidHG9QJ+INtkbQtP8msa2dpJYIdz/96KEB?=
 =?us-ascii?Q?ZIeUf4D+Mw0l3WZm7hs4pwrDxn9fg3wcu+BewAKDSs06RnGE/+WC2/Mo7ns2?=
 =?us-ascii?Q?Du/OJAYDOpzq+AZ0wEcDQi+ZQhV/QZB5K0yI+On4AXX3YwI7yq0+vOFXcnU2?=
 =?us-ascii?Q?iEc3XsplnzyWhzI7jUVmhvKqYeidBiY0WYSoHjWzEbbYLbQKjBvIov+hQSFb?=
 =?us-ascii?Q?wNoWEWy5j+w2uxzes0cHPBDUXuwlE2MW3ZJ7FjVvrRu2A+lsSaVQfELv83pM?=
 =?us-ascii?Q?3nuVhFoMcK/wJ8Pxb1de5/rUqXvHjge1ZaaSoh+PxOe5vjo9M9uAMUpAoigV?=
 =?us-ascii?Q?hDkWz3Kp+pXgfsx0j8fc9l3LeSPxO+pA+jmsf4UY74P7RNduPWgBblxC57Su?=
 =?us-ascii?Q?KrXhqbahstZIocWuA6d1qcmrVk9Qn8R0SgGdbf5SQLzZsmqYeYvSuGUIS7B6?=
 =?us-ascii?Q?9Gc4/t4yFoQHSsIRygA45Z+DzBoG0r7xw9k9uwl5z+bLsFNkr+XuBJxq9pyW?=
 =?us-ascii?Q?HVRKrfZYlscK+877d48gjFGnjmCJrMDaQETl0qjpUgR3JAGk5TBdov4zqLyu?=
 =?us-ascii?Q?0DN76y8HfjhBJQqXtHQvFX6iUncC56u7Y2QaGB7Kz9xc33DFyeP1IH+nWkeD?=
 =?us-ascii?Q?EGTqpzm59pc/HFLzZeSH6nq5XPAIY4RdsYBuzcunbeCtihuWR3q4BwXiczNJ?=
 =?us-ascii?Q?co3XTFOkm82gKdPUeDztTH7YdI12R1181p9a6EThiW9mxP+/3HJVcU1ruQRJ?=
 =?us-ascii?Q?RyXmLzWgNy4hahRJvO6KAKamwnaWQLCieFiGMAk5PXyZRjCswlKxHRhiBwRl?=
 =?us-ascii?Q?ccHzSJLa/mx4DLA9Fg4stbaosRr93apu07mVglNejyNyTajNX1hNYZ404wXU?=
 =?us-ascii?Q?XWzQbx/gmetEDDwl8c6diFzJWqNP4Uh51WNwX2n2AAYxkN2z9RY3UXT9VrmH?=
 =?us-ascii?Q?3G8AyqxyPht4PMeSaBExI5iGdW4Sxi9NQHHquFOf6KX5BvKm2MBofT5eIRZd?=
 =?us-ascii?Q?00meIbfXXh0CA6UhU1XYqUgqA3rUJR+CmD+lmWZpqJ2OuVbzcQpx1RVM/CSM?=
 =?us-ascii?Q?rNCkeIfKpPTeQ+NwTaKQRbxu1d7+SkLHcY6WW360TY2Pnmldyje72+hRgGxZ?=
 =?us-ascii?Q?uOIdlvNeVUyhzXgI4h7xVqyH5e5sw7K1noCP41kfUX5oFemgCdV1/FnAKq38?=
 =?us-ascii?Q?b7/Jt4C9pZ3To1/NUhbAFT64Xa4HY1oiGAaWMJgnYja3235BUnYpWHcnOFCo?=
 =?us-ascii?Q?jcd703YrXPscoJRDWNR2NLjmg76a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cpGdKFl1gZfYdTi/oxsZEUO4zCoabq0xE9V+aOvnZv7Fd2jOCtsgJ330ZhbV?=
 =?us-ascii?Q?SoLPCSN3pVCx4XeK+DAtZdH1S5aXXMyH/vepZp+o9OKhVbO572PDpxWMfP8j?=
 =?us-ascii?Q?Aauqi/1pW5HUjSyfYpmahCIKLXotuhLYtf2HNWwdn6I/cEZ2LvgNbAkFv4mO?=
 =?us-ascii?Q?/e+/eg2QP7pJeil1jbSH66HGF0bw7P7MjAb6DjM51PBdDL7iy33srIDaObFG?=
 =?us-ascii?Q?4ftXChT6phij8PE5P/wsHP0z5KXm5G2rH6qVqM7SI1banQdk3dW4854Z3XLQ?=
 =?us-ascii?Q?KcnLrgnEikt1Dz5RanIg+km20xa+9X3M29vboo+Zmq/+Vd86yUNusedYNC6W?=
 =?us-ascii?Q?5VyeF05SeJSCGQM9EGjjofO8Nbh0uYK/BtaMHHrKWqZEuDRoOC2FqgUTEcdj?=
 =?us-ascii?Q?Kkz6pDn3IjggAK4pt8ILwrLNYhHbIarQl2H3tEi32zmB89bcHWB3cKS8AgBM?=
 =?us-ascii?Q?Z721UvBcmCCv7ZVmabNX8Rj+INZKmZocAKzAjF4DtsUZzTGCY3QsogeqsKof?=
 =?us-ascii?Q?I2sq7sfxXAAEkL64AGiMYGqnVUeqvZOQrcjKejVfJ5OFCKbF2lNgWow85TiW?=
 =?us-ascii?Q?Eu5gHuvy+wiQkEswL9os4uvASO80FRBZvh9rX74yvjLwewtv03lrK0Y8eR/V?=
 =?us-ascii?Q?j+4RA9yBiH1GmycwwGakkT0NAcT7vfOGDOeqEWE9A10wGGInr1bOIhchhymG?=
 =?us-ascii?Q?2zUoMjGKnnl5lJ1MzwtXzUj/2iqcBtVXg5m9wKHU9G/WSTZ7JhBW7JbR4R/+?=
 =?us-ascii?Q?zLey2NFV2/bVr0r+PK2AGEkGGgc6Ggz1h4mXfuFFBr5/cyO6yaSRm3Jvhrmz?=
 =?us-ascii?Q?1GhWVjr/TT4heMllYSVmCzZmX7eJ5pgH3QqxUn0Q3poGg1c9LoOwnAmDmJZu?=
 =?us-ascii?Q?Ibt/Yl8MG+KR5pT//+oYOsEx0iCZZKONhbwowwvfuzR/Hw1323H7z+WToD1J?=
 =?us-ascii?Q?qKvS76J3uIY4Vh4VCqTc1mnE2kyAny6GVuQBcUf5CkY42YFPPqtHtk85TPHI?=
 =?us-ascii?Q?jAK0FBlf8EzwlwMTtrcytVQrEyELRLUPl34l05DBxrN/FpUMJBj4QU8GZrmK?=
 =?us-ascii?Q?ilPMxkELeKx4M8bcDydx+YK6uKmqduu8K2sBdv5U41ISJDAoCbKpnkI18R0b?=
 =?us-ascii?Q?lWjknSzEARBIuG5Mb04NzZihzw6WNwSK6k/7En+NFMhRc3tlOErwXB6mZfHw?=
 =?us-ascii?Q?IfRP0YY5x0NIqkRcyoPCtyzanHtUymoTrj39GxxbKJX0zQ75ZURBilZQDhz5?=
 =?us-ascii?Q?KjwJB/QsYRQgJWKv9oDCiwi3CLrxLRB5XutpsERdXHSzOdRuXtoMd8R+CRXB?=
 =?us-ascii?Q?8ib6hqrSU65DQNT2gjGsZxnzN+pB6X6HvtRrA8d2WaqKru4JfVpU148dC1xA?=
 =?us-ascii?Q?8hyObVKuPPtIdvuHAqL9ToLkdu+UjHNLn6wnmn+xw0oYXqRoEaKXmVbajQ49?=
 =?us-ascii?Q?clDDAm7kneHNAKzWF6FDHivOYBawNeIeoi4lChFZt11zBMwPPe1K3g2xlGDR?=
 =?us-ascii?Q?hXn2WuVi5FH6jguMOX/dpwmzx5ctgRxF//W1H+pzjEy+5bw0lrc6WH13PCXs?=
 =?us-ascii?Q?vtQ2GVl2tjzukN70sfHRIoZHgqYp1NAqcLInjNQ+eNDObFIv6+Rk+WZ9Vmig?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gzH9ahQRvvsOGaIrJVfvaFZuN76ESaxFTqdu6XEqZiOfNOLMShm6hP0d0IhGkSnck3jrpNoOn7PXpPuMysQHIyaKbDPE3Erz7IYWv+mG8/H+QA9YWJeVMWDzYK1lf1oTb7wJ3icqd5COLT4pl9pAIjJxjmN+hqwRqOlgLasS86YWpFljDTGL7B9RvrWQTtQAN0Cjc7Rvzh9ahGmGuQt8IdV1kN0y3ARw5QOP4NrdKB7EYSpAWuFBCStdmEmAhlchDX1YMVi+YEyQs04XZnwV21OzMSZ1krc426F0iZG0RDDQFj22Xe/tzVWi5Z/OQm5ooneggsAz23LdIzb7SuCFoszjENmFhxsrQfL1y7qYAlCGCHJkQQLSmlaxMBm8WRT00X5q/92XbZTvd1MyVHdmU8ZVr/lwavd1inWxBWWXnF/0cmbCfEnkZZrNz+mb37vbHNrVgc3Ktyqyl7TTonfN19X0o2Ej7YNgOgwp7bvBEO9KK8J18LpCsPJj35PlQNFDCJO5ipmU/Dnl8LfXaxID1edNJBi6soAAft306fbI2tuejSr5xl7K+qhHfQUUk6kpxHvv5iLJ7g5mj3kxLeeSKIM7moLzU5Db869d/1ySISY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b68278-baaa-413f-ca4d-08ddda2491ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:47:55.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imfRn5chCX0SIn8z9TilzswZX6AKrXSAD9O0w0jYYBZyRvBEK1JbVxswyJRdqMYGOPxf329a874R6Sp4xjKVwYRjWYjILh/EicNp0wQe3kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF01BF54C53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130043
X-Proofpoint-GUID: aVlB76oj_rxxbKYxBNiVnnWoYntN7az2
X-Proofpoint-ORIG-GUID: aVlB76oj_rxxbKYxBNiVnnWoYntN7az2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA0NCBTYWx0ZWRfXzLMEyqdBeLuF
 lfftIcBjC1Of5QhbRh+GWvzJ1XBNjsumgvEEJu0dsT2lU4qT7btdy6OWYI9+2Wxz0hfxo3EkKTM
 256f/xAR00SLexWkuAqz7uIR7rEIxQv7sSmgS0aBbr9HctdQaaqZ/bBp95sClaAelHv1Pph8GOh
 ti5hOV+V2PM3JdEBZPOiwITbfVYIXAfXVZylAlIkg1icyP6HmkwiSDtfzx37egyqBAbY/na1A9K
 iyNpD0fXHWnMoAZQJYgRcnxo9Hea99inDazUUXIcYwkV1ZZerOblIAckKlYQSjZBfpdljGW2/tO
 m/7NdyQqNXWVjt/kdHm0Zt90k9FeyACQ/KF8ID1Fs5IJ6yli6gKD6TKXK9Bi87nJKo6ZIGCHLGi
 pjD75AI8c12HwjwlZUauAY/Y7szMj8g/GvQ+zIiDwsGOW88vcZSB6aN3FZBMILyC4UQcZnOR
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689c1918 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8
 a=4RBUngkUAAAA:8 a=RezEmeUVKuBSdK9TwOsA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19
 a=CjuIK1q_8ugA:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22
 a=_sbA2Q-Kp09kWB8D3iXc:22

On Tue, Aug 12, 2025 at 02:56:35PM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    53e760d89498 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=165fe9a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9319a42cfb3bf57
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14172842580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b04c34580000
>

As usual the repro doesn't repro for me.

Let's try [0] as a quick check as upstream doesn't have it yet.

[0]:https://lore.kernel.org/all/20250806145611.3962-1-dev.jain@arm.com/

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-hotfixes-unstable

> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-53e760d8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/584b4139c7e3/vmlinux-53e760d8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4d2474607300/bzImage-53e760d8.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com
>
> R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000002
> R13: 00007f00d0db5fa0 R14: 00007f00d0db5fa0 R15: 0000000000000005
>  </TASK>
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_normal_pmd mm/mremap.c:357 [inline]
> WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_pgt_entry mm/mremap.c:595 [inline]
> WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_page_tables+0x3832/0x44a0 mm/mremap.c:852
> Modules linked in:
> CPU: 2 UID: 0 PID: 6133 Comm: syz.0.19 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:move_normal_pmd mm/mremap.c:357 [inline]
> RIP: 0010:move_pgt_entry mm/mremap.c:595 [inline]
> RIP: 0010:move_page_tables+0x3832/0x44a0 mm/mremap.c:852
> Code: 02 00 0f 85 b6 03 00 00 48 8b 2b 4c 89 f6 48 89 ef e8 e2 1b af ff 49 39 ee 0f 82 d5 cb ff ff e9 0c cc ff ff e8 1f 21 af ff 90 <0f> 0b 90 48 8b 44 24 40 48 8d 78 40 48 b8 00 00 00 00 00 fc ff df
> RSP: 0018:ffffc900037a76d8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000032930007 RCX: ffffffff820c6645
> RDX: ffff88802e56a440 RSI: ffffffff820c7201 RDI: 0000000000000007
> RBP: ffff888037728fc0 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000032930007 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffc900037a79a8 R14: 0000000000000001 R15: dffffc0000000000
> FS:  000055556316a500(0000) GS:ffff8880d68bc000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30863fff CR3: 0000000050171000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  copy_vma_and_data+0x468/0x790 mm/mremap.c:1215
>  move_vma+0x548/0x1780 mm/mremap.c:1282
>  mremap_to+0x1b7/0x450 mm/mremap.c:1406
>  do_mremap+0xfad/0x1f80 mm/mremap.c:1921
>  __do_sys_mremap+0x119/0x170 mm/mremap.c:1977
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f00d0b8ebe9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe5ea5ee98 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> RAX: ffffffffffffffda RBX: 00007f00d0db5fa0 RCX: 00007f00d0b8ebe9
> RDX: 0000000000400000 RSI: 0000000000c00000 RDI: 0000200000000000
> RBP: 00007ffe5ea5eef0 R08: 0000200000c00000 R09: 0000000000000000
> R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000002
> R13: 00007f00d0db5fa0 R14: 00007f00d0db5fa0 R15: 0000000000000005
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

