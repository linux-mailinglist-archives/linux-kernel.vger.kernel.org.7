Return-Path: <linux-kernel+bounces-746154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664A6B123B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F997BB707
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A036242D83;
	Fri, 25 Jul 2025 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fIr8a/uz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="giu2OfXm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993618F6E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467805; cv=fail; b=IAfAqXatqOFMdDU/P0H3gmmwk3zOuRFzKJ6PG7Fc/Mt/VhlSccAdKOSF2KXOJTJh8Dkes0pDTPA1W2ukq3Z739KyrSL///JytDoibUMSnH7xJhg/zctpJRAsUZBxmQBAKOQNhPFC6l8+XzeYJ0qFB309vdoPr3fwy/dqquF0gYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467805; c=relaxed/simple;
	bh=YRquLExzE4llmSOYFJtY4KPp59hZxDgpPhuvLY7q3cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bgjRQM6OiouAf9NUU10reuv3xv+2MqUPT90GLgOgMYgad3SiiOj8X1Gc76ANKlPSIdTWSWWsi7runutJZHiOFQXYiuZ4ELwdmQ8KzW5H+xkEDEYo1uTxMPFNePQLJ36WDxtKm2MRfXjyFwlQAGShqoCDSCYfVVlUImF/iknyX0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fIr8a/uz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=giu2OfXm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGCC5I026400;
	Fri, 25 Jul 2025 18:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Xutqlqnx+6VK1cL6Ck
	X/9CMvSC5vsK9OhHMJZLI6tvg=; b=fIr8a/uz9B6UyqPT9Ns7TrvBGgwyNw6+ls
	GokmYsqJYlUjmwCGN/hlzq8uKLD02anbrC2R/F0mK6u3M46+8CEF0CocmEXAnhzz
	uKHWFQ4EMt30VJIHqfDPa1Or/Hbca8MCU0SvRWC4wIZkYhFEzfchViJO0Khjoox5
	yxqGP/NRop7fLtq1HKDUIt+G2njiMZwk6SzhmfXmAmptpgYFJFG3fcBRQLW5RaiM
	dzIPwTOivxDH2e/8gO2Ln1y/W40EcWgIjPvWZ7YfJWUPKb/CuP9idwDOvXQOJL3/
	ZIMEk2H+2YnHd5bwiaUEBVKo3/nBbzgfdH6k0iMK8e9O+VqeuqcA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1jhku8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 18:23:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGXJA4031483;
	Fri, 25 Jul 2025 18:23:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tkr0up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 18:23:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/oR34AAIXtmPZGPofBVYhd5Cw5+3R1R0N5vsgQao5vTidUBXVhP+wfy30b17vawiZpyPh33OMTRTdIgSyxHEph+/egwq3Q1/vZw+TAuDsrHfO1LmPdbIOqGw9fP6RtUbZ0gbMUyOd549wHoBI8kXuLLZgYKpln1vHPm2O+RXynEjmZC2xdfY/jqHZRpbFUtpA/PZgAnBFUrlvDDhojJl+34elH4Hmc8KNmMDPp+ad0Vf9b+cuP5/dw5yAs8472pIoSWyR/XbsdXWj+NKkLGWTqfGPRKmbbwizzVUaelECR2b/8XnOBviioYOev/jqnm3zBwPpV5eAPEqZJcjSUkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xutqlqnx+6VK1cL6CkX/9CMvSC5vsK9OhHMJZLI6tvg=;
 b=uJ6LT2BAsGKEVZsdTc1fZNxPdvjIkHiWX8dlVtBlS23nYF8RSZKbZqXUNwWnr3FIvkkOByVxFR6NIIsxMzk+QlpwrKa4spvw+5LDrqMm7PkncBbmlU1BJRP44U8IuhnTkP5c6F0t/j2ln2nlXWmaPLmrLxhliCEKx/k4gk4/KLQ0q2lELmbqsQAy2I8NLTXdqvYjLQ2rbv71wzAu7e1Lab6i38QCIX97S3UW6A0AfUi0uFAMc/CeGSQHnkiJiiHwWbdE80hNJDtd3bbu/isIcyef3QuePCRSTZCP5zJhdGOWmI3GhjoPotSiQBymBi6DAleqFiFcgvBzpXowXyug6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xutqlqnx+6VK1cL6CkX/9CMvSC5vsK9OhHMJZLI6tvg=;
 b=giu2OfXmHsGS2xbCnbFxaZXxofEuFR23284EBx3lnbPehCXxNAfNm7WZD6dA9iwprgK5x7Ts4gSCU87r7km+Rh/9ERrJH15z/Z0VXwPdgiOlY0PfEn7jpWMI3ikOxXlfGaqn8h3aMX9OK9JF0jUy1krl6h+gzUvs14LrtV+rI6Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 18:23:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 18:23:01 +0000
Date: Fri, 25 Jul 2025 19:22:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 4/5] mm/mseal: simplify and rename VMA gap check
Message-ID: <53222f36-ec38-4b3b-95b9-23204a69da66@lucifer.local>
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
 <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
 <CABi2SkVeHWt+SKWWodXUNhXZi1Wv9YazEOGWEUJLvgPbopqBrA@mail.gmail.com>
 <ca6af6bc-1c5b-47fc-a00b-11d46867b5e7@lucifer.local>
 <f860d082-384d-4230-bb1c-09206c7daf72@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f860d082-384d-4230-bb1c-09206c7daf72@redhat.com>
X-ClientProxiedBy: LO4P123CA0502.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b476246-c641-42e0-2e51-08ddcba849d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9K3G6newMoULepEK7skgvhO2rBd8u+dT/6uD1cCyDjhfanZ8bMWTJMNb0aJq?=
 =?us-ascii?Q?Ou+47e8u+XIY9aFB5N2dpe8xFXhxjtLiV4F5WqSKDWwK9WXuBf1vok6sXnyd?=
 =?us-ascii?Q?xm+Tvj80CoTbfCeOMi3dU2Rr9PvHuj9Mc1llTX/I9SoL0x0cO6Wd7gCByTbe?=
 =?us-ascii?Q?CEVfDkicPpuRR23estv5Z2o1h716MF+bRxoJ0J8e8Hb4tRFdcMBWJBU7iP34?=
 =?us-ascii?Q?Frw2hi8qagE/BMfp21vF/dlQVi5Tj3OsPMqciOIuYbwuuE6rjpP0KpyXY3eK?=
 =?us-ascii?Q?XibNM1cHBFW/x2gHP6d23BAZ5HJOru6nzrcftN22NQ9cnbyoKjFaMgU56zPH?=
 =?us-ascii?Q?9OADtTsHyqyXTtxo+v1XLNdV5Z10xHhWnxrx2bD+Lu/4+UPUizbSy99Xdf0z?=
 =?us-ascii?Q?HWrHxhYY4Tw7rnPqeyAXcTOp98g87MpH4dqTNqNsswB9fD00FXJZ5V9E3ZCL?=
 =?us-ascii?Q?nnSApt1cUOCckm31DM1VasbCF4pIFZ35MGbpUHeq8NgQfzwB8hQ4363WMVj8?=
 =?us-ascii?Q?Jyzs5GdHgwV58CTdhQX6caeGzEP0vBIounIOUpsWwLcErzsftMx/E1W5Ed67?=
 =?us-ascii?Q?lLtUo6WaLP1OPkkgDNW6e0Jg2dlpM7TI/vwloTHRbRWQushaXTu8u6Qk4RsY?=
 =?us-ascii?Q?m3eLtQ+KXjYnF8GDzG1BJzuOQawL6xP2VKtuBCFwqzlxtQPw1X6pC3CWok6S?=
 =?us-ascii?Q?DcHayH5qo2YN5LXq1MgPLIthyG8HupKaYSDRYnKsOhKWNcEWVk7mwIBDS8Zb?=
 =?us-ascii?Q?j3tRNPaq6+kL7L6MUjSIDOUFa9jWXeLC4yR3G1/HQ7OdOpnrT+Krqul4iIKL?=
 =?us-ascii?Q?hG1n4XABV9KVqH0V1QjDdTtGnAdhopLthUFrx48llqxVjkSyFo/vYglX13Y2?=
 =?us-ascii?Q?QpqEl4gqV0k0kLyzrj8RZuMRScNW4jL3wM7mRnmUF6Rv21nnEMUFQkZuEUxE?=
 =?us-ascii?Q?hDUimQYm8rlQ5EVdFwjSYU31Ivbje3IJU7JUkGiM5fucPNcp6GiczKlgC+dl?=
 =?us-ascii?Q?UJZ2L+wfpXN73PG9JC6YMema+ZebeCNa3yb0m4nnvllk+pSR3oI6gDuxEH2k?=
 =?us-ascii?Q?4yfz7/7dNR1WVTu5ZaW5lmacOWi4aCyrrlq2d+qxFY6WSbPmBiM+3Sh0WgU/?=
 =?us-ascii?Q?1K4t4uzf744so721PPbCdyHEaVvh3QuRJx6Pn1ZCzuknObjtDIBCYgHnTX6D?=
 =?us-ascii?Q?vBjdVduqbSiTnflh5TcZ0FAe/cltu2oG7yca+FE15ep4S/i0AA74FzYERnxi?=
 =?us-ascii?Q?5cw3CoVWfnWogSFuT4Fpqw76LeiKb28eMO1NGrHn0igo6uhar5lGQp7MY6y7?=
 =?us-ascii?Q?CZqy1gU+EynJHAr8rEP4mYJXOLB1q/ypSNyuN505GyDrwlUl+VIJRrYinCnm?=
 =?us-ascii?Q?ql6a4K/0nJFC9tlCwLfiQrziY1ss+X1AacD9JUloctKD/DlMtHxrHOQZdj7c?=
 =?us-ascii?Q?VVPdCwnGuZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+e0xEGPzLeCQ0taDkVkrSDct6U2G66WKutMG1cmbWx1ehaHRJveMIfaJXUaz?=
 =?us-ascii?Q?KTf3byu2nSP/122rLJGBSLThRQFZ1jxh1N3OdhBUezq3DvbmP5ZcLf7DPH5S?=
 =?us-ascii?Q?RqAERKfinBFyZgYeiwagX3ki1hetRsGIksSbMkew+5qrExzPa01In0nJK7Hu?=
 =?us-ascii?Q?upq2nhouF/lg4GyTHnF1RDvDTQVTvU8GDvHrAJt5jB/KnFlUv8bVyzQWh4mm?=
 =?us-ascii?Q?rlz3jQ9co6mwBKHZMn5UBqzTdIHh6e7MPV0oInxom6bKP954t3ztURdoYIua?=
 =?us-ascii?Q?E144ItrGwqxcH2FIw117mMU3jeGZGtj4KdWD73XsSLCB1D1PAr65uv84jQCY?=
 =?us-ascii?Q?uzLL5a795GTuehf/4GTMVN7qz9f0innLtEZte3CyZmVotXD7FPXeV7SgOK1l?=
 =?us-ascii?Q?YaVIIdghuFrvUuksXx8Y5aUzNovzEzxkE0kAz+yFMDGgUcwny5va7k82b8PL?=
 =?us-ascii?Q?agjogtUbsNd7rQMVMM/fhceh1m1V45kB1y4F0Pm9SRhDO2KNoYW7n3/jamPH?=
 =?us-ascii?Q?DLARgK8YpAU56Lr3hPFZM3H62d0WxPYC3zIThOJK/6OZ5D9zne3pmntaRv6J?=
 =?us-ascii?Q?SZ2YSIi7WHFP+fY77V/rkdKyFtuRiR4JFSWhzMDiMd3fEU0eYfZvO877MOIT?=
 =?us-ascii?Q?BrKbGrzfKyBj55BqwNQK/ZfpvC98SI7O3JcI/cQ8veTsrCBcp3njDAtST8OX?=
 =?us-ascii?Q?YZLsbrO48rzRSyUbge2EQmhnimifloWPcBX72bQmNA8AaJbcNYoL/0lNKJ6L?=
 =?us-ascii?Q?5MFwZY58Gf4yFHXdhpIQXW8+HSTK25XO5eCvE5QLhkZZnh0OB8cwFJgb8osc?=
 =?us-ascii?Q?nIKE8z2yOl/W2gPcaGQZMdVu156A9QB8wr0btWolOWpyx2zr9EOsYY4JPnTM?=
 =?us-ascii?Q?1Q7Rtwy8qhNsji/0xt2s2b1BAYimyanqsim3HZt9lG6FjQG141xxPWWUUoez?=
 =?us-ascii?Q?tj1kkutRRUG+Xl+aHDEcZxVmnqNNroK+KGnMM9BL5QHr83k/ym6KpZTH3T0p?=
 =?us-ascii?Q?MCZ23cVMCNpABKezo2eKHjZJp73hdtMcG4/vWnYnC0GmcBpVZhG1kNKYYfR+?=
 =?us-ascii?Q?/0BMkZiPS+j1jhkFEFBasbcBy3r0Lyu6s1kIChaHGFt9L4k6OGObgVhQ13zp?=
 =?us-ascii?Q?1RNf8ivYdcZMQ/2eY0uy06DvBPCXcfquToSUypCAS/V/UhiPQElU71WU1STU?=
 =?us-ascii?Q?UgsVd7VVHlIS62y7Iy5QTkfrIjKUvICO6aKBa3fLwRNvXdCXpZEq3heebEKk?=
 =?us-ascii?Q?9CsqkGriRLw96sD0A+3IVnI8JXZ39/fxI7OeVwTUZ9xqY0cLQhcjazbjnt/+?=
 =?us-ascii?Q?NlORJwRfI4/b/U1K5aNWGhz9klW/VoANXfjQMjmsCRVPxQqa08kAmj1ymmOO?=
 =?us-ascii?Q?tnXISPrb2XDqY7q5yW1yn/76ifgbSUAMb+eQv1tWvZn82HsSudHzrN0d++KQ?=
 =?us-ascii?Q?dMSr53clCoA6+eHgR8r7hw2LmKpoQx5BibW47j0Gzif6U/O7rEa+smMVknfz?=
 =?us-ascii?Q?j7eh3UV/E/8XJpLWgrPubWxaJKpxj9OB19plWiz/gUjjw0n1cPlXxcf6n4lO?=
 =?us-ascii?Q?HcLw/bEH6NsGx1vAd0wm/Ja20LgvWqt+Kaz9DiBz2sZbyupFPV35HWCXDfZG?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QgprYQxeHuHM8w1tbviAjFCWZhuZ56qDjAbb0krz6Hq2BQQoGn62zgbALcjISfOMMS98U70lKybs+1uWwjcKv8+iE1bAFm19jzcRbbPGHh9BSta3AcC8RIVJzhHKxqmL9ysrUIZ6nhnNZWfEi+nxSzC0rCyPAfDjPegW+l8rRKlSXWayXaRn1fLWellt9ocitDXL/vQ7uADm5K4i5tuqVjdB8NKapkRiqyoc63742NT4o8YgukyXistoNiRFyRW5YS+sPI6pJFWI4INRQwY0cB1ucQBnS73D0Qmew8OVrxvha4oe0bEwI8bd1Xc8v4F9PzLwXwwCyd4+LMVGKvmUmY0CrL15oE3t2qz+xqzQZIFEjL/MyBXEuyigaplGWa4jWysOpHGy0fXwqJq8h6d8JKH2+/RF2E2tW60GhWcL1e1rAw1at3gtlF9TjQizOeqcu1aPcmqyVdug3RI+BTMvMWevsKvSFJd09HIZq7dl6UMSiNL+dXcO9sJTk9k0svWOdAUeH/lJjCOXsMP9UN3OREDI2QE6odVFQ2cwt/7E41GyVFvp/VCuqPP3dt70WYKd70ZXiv8cbDSKUUtuxSQ7xfpIyIKuJnW0xZVhpHtwRp4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b476246-c641-42e0-2e51-08ddcba849d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:23:01.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3zNpDuqvVY8I0zTkst5uEGcEo8NFhPc2Tlu5TMNpSB2WF1H6yzDzxvDusKbyOvHDNiGqQ9xIzxKta8ACFrJT8wnpujA19+5uuZBatlbdRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1OCBTYWx0ZWRfX1V1oIDuEgnv1
 GUswpMpk3/pTmnW5SvmHTdWJHZq5PG6ypUW2t4UBfYBQwZmRZZ4FbCGNJPWr73/CZBvwpqkXElm
 Dy6iAwoWGOBYgG0IfCIHu2VjGTh0Oqb3LGpNiXrLQyIUX+fCbo5noH/4SDqEC/Y1jO7h2GLs6bR
 iZ6tWwEoLoGf327RvnXkhTVRe6zhjgyiw+wGeRm26GBKn809ioR0MPW1cZbr3Z1A/z4u2bq6cxA
 /PjTQNrJ4NdBnxUc38U1tXONZed31S3QSN86Umo0guBEyE7V+KAYnhF+Tew+l0uyvuGX6ATCmhF
 oORENabfXL+aHfq9igyCc0pbcSIlI72M963bY1EJ96EW1tlfxxNkvrXte1yG24QuG5vswpxOlZk
 wWfkWgJ0rJ8beHA4Vll8ZzkPOPcaDY3wmDgifSMji6kA1Ym2Sm4RRsgh8pnUt1JZUd9FtC73
X-Authority-Analysis: v=2.4 cv=W+s4VQWk c=1 sm=1 tr=0 ts=6883cb89 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=WyVVfNK6Zpc_bWtwifwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: rfbSf3oLPwCzI7uJvL1JMZNh7hCYBNKq
X-Proofpoint-GUID: rfbSf3oLPwCzI7uJvL1JMZNh7hCYBNKq

On Fri, Jul 25, 2025 at 08:10:11PM +0200, David Hildenbrand wrote:
> On 25.07.25 19:43, Lorenzo Stoakes wrote:
> > >
> > > Contact is a great way to hide implementation details. Could you
> > > please keep check_mm_seal() in mseal.c and create
> > > range_contains_unmapped() in vma.c. Then you can refactor as needed.
> >
> > Wait what?
>
> do_mseal() calls range_contains_unmapped(), so I don't see the problem.

Thanks.

>
> We could add a comment above the range_contains_unmapped(), call stating
> *why* we do that, which is much more relevant than some check_XXX function.
>
> /*
>  * mseal() is documented to reject ranges that contain unmapped ranges
>  * (VMA holes): we can only seal VMAs, so nothing would stop mmap() etc.
>  * from succeeding on these unmapped ranged later, and we would not
>  * actually be sealing the requested range.
>  */
>
> Something like that.

Actually this is useful, as it explains to me why we disallow gaps (which I
found silly).

Though I'm not sure I still agree with this (under what circumstances
exactly you'd map within an mseal()'d range afterwards and then assume that
mapping is sealed, I don't know).

Anyway that's sort of besides the point.

I'll send a fix-patch to include this.

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

