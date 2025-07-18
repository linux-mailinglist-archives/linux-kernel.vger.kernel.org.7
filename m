Return-Path: <linux-kernel+bounces-737295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2FDB0AA6D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C58D1885199
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D3B2E7BBC;
	Fri, 18 Jul 2025 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OHG5EoZ+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dpAZVj9t"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A5417A305
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864841; cv=fail; b=W+KGqRG5ypti4xZ8AvZgRMtL6yDTyNr1JlNkHB7e02A9lcm6t4DYo2Tq2LW7HXZgX9hsHf436/CAb412n4mCtiLd3SJlpkjjbCpsGA2uOVsen4Q/W2L4xpdl/Pp8UvmjzFNY3uuDWQ9MZcUDxxfLQYoII8a94H3Ll+wAiISQUcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864841; c=relaxed/simple;
	bh=Qvp4L8+euS9Og9PKFh460r1KW1A220VXJ6nmorfGrYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YC9PvuoI0BLHKJck4anYc4IR3ZpDdPSrVonagICu8NJ/XHg/noq4UUVJqfA8vM4WHaEjReYJRK5JQbYwY19y14AqQuropsejUyIq4DTt2SeH605xBnQ4ho3Rpi7tyYzqZpNOSiEkrwBtEItI+nKjECdgRGgBnELk0QBpyDiRv0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OHG5EoZ+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dpAZVj9t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHHjq7003786;
	Fri, 18 Jul 2025 18:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OwQB9WISLoHe4/feYv
	FgU/M8vy9QWDqFow5b5nvyJ10=; b=OHG5EoZ+KOAIhPgiBTyulBWvsB/8HrJI5p
	ijv8LK2mR7B7HuOH7DRiQmSfssLFH1fJ6SYpO3FzYQmsGMEPYKyZI3rplabk+WFC
	yApsPUnQlBjima+Bw0hL+q7L3eOMc2LLtftGJL8bVHCxh3Cz3xOnYTh9eSkRGxO0
	Sj1FUNXCKHWpbiu2AL+gzQIY7xOzvB0q0XCtlNhD6GoICnFluFeliTEq8YJBCLqg
	ZW8Do8rOUCdEt1xNS8t/QSQ1yrUQgTGJQR1iTn/BQ7T9r8TTDAz1D61rHvBOW/Lq
	zdzkv1My62zukKHDtjjxkSK+oJ88y1cHOMlBk+Arerl5MbbcGDwQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g5rgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 18:53:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IH8jLW030351;
	Fri, 18 Jul 2025 18:53:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5ebxrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 18:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1QT703Whp6EoIjFdt8vLusjLxSMIfqvvbQ/8/8hrVwm/9LVBbYE8MJ4bBB5cvZvBKP3PZflJvhYxtS82DskOAqWsIE8huRwYcPNUK9qEYwvT4Ns/GsVuSNgu4t0JHzXx7FsZbaqoxycC1uNvw8gOVc8ozItP0bYOTZLs+AJTK+Jz+wgF8kVtNpdEOA6+jFTWI1Yv//ADnjVUKh6tB9Tr6hhppBjJrfLUpuI3sHi7xTVQpR3WjZugs6oBIm3WfU96QTy7nAmxyo6GlGa1S2ozBdsLa1qlylRkxFBHi+0E4qqDsInlsbPGBXlkuq4ocSSNg7FJTw6e/D9Fzhsd1Graw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwQB9WISLoHe4/feYvFgU/M8vy9QWDqFow5b5nvyJ10=;
 b=zO81WxurQVFNurPQXywuabYDUTExHn/PrIKY9zHxeIp8s5j/T29a4ION3iDubbOHesGdtb9eSD9DMdVjiY4P0f8v15kBawBM9PL7O9Oe2XAyjPbeNZhlabScTJCkuKR6C9wupiqlk+ZOIPeT5Ogmbq08A5nJX8W+Lssg/3p0CZhJyYA17TzGp2CQcFU+uhxDDSFWzJgbsDS3ZiqZqf8Wu8UVfQHB3kN1oQ4xhqOiXpuKJ3iz7qCZnRIt5qzwrgQhJkP78Xm7Yuj7sFtSia2lhi4BEe7rapwB00VWfXmV7luGPrVFJi0WXnSpEkqmAkJBGHiJCpDNgDRznplaMsgtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwQB9WISLoHe4/feYvFgU/M8vy9QWDqFow5b5nvyJ10=;
 b=dpAZVj9tCmqb7EPo1wdiuMxnaufJIHxkcV1uVUKR6bXNZ5YcbDhyXS4AfXjte/phx41NuH5afN5SsSAyN2J8EBV9cft5nr/p1z1Z9hGD0r4jE1Hk9d960db+DfnWOAJn6J0avdJAzjZTlA9dPAeumH/W1Y+J1VS7Sl9mjiTYk9U=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 18:53:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:53:13 +0000
Date: Fri, 18 Jul 2025 19:53:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
        willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
        vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
        peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
        baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
        christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, hughd@google.com,
        yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 0/7] Optimize mprotect() for large folios
Message-ID: <7d21fff7-bf2b-4362-b2cf-0cd92fe0cf7c@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <fdd6203c-dd9b-4c33-98d7-255f97973ad2@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdd6203c-dd9b-4c33-98d7-255f97973ad2@arm.com>
X-ClientProxiedBy: LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 381d3abc-b757-4e07-75a5-08ddc62c594d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R12A+8R9faSpIwaRyWqF4Lk8jQa3ZxeIMi20rukn0FCNal1UdOGi0UKxCBZr?=
 =?us-ascii?Q?mjuahUKJqLxIp4QnmzjVE8XRQWgK7JAKiLRHAkZlgTdNje5S16ZLTy5ne9Nq?=
 =?us-ascii?Q?4omVwJMbPyd1t82lE9SOP9pay08aZ3UD6vxqqRCCZ0d/r+EbfYyRgyioG6dr?=
 =?us-ascii?Q?w/Wts7whHRUfapUZEC9+KsxLyltQGOdEG0mM9NP3SnIkMDdf6lG2QX8Y3y6Q?=
 =?us-ascii?Q?d0lKjPG1g6ao0L+Sn9ewPJ6aKedZWax023M7xfm2gkCX9dEmuK7VJa4u9yr/?=
 =?us-ascii?Q?GH8XpX280fSVYKYsSDc3uXgIl/J2XAcB8vZm4XLSRrKsJCxitk/Ml2R12r0Z?=
 =?us-ascii?Q?TRe1o/iralt8t/IFZmQiEWUJA6ZaWVcERjo1QDKOogCn8RCssLkzWtbika12?=
 =?us-ascii?Q?mtdtjwl4dvpoqoyI61RaeGew+zrPn0PZrRygMYNUhAfcz3fKUicQ8ceBeEjI?=
 =?us-ascii?Q?AxOQCKSY/sFrgU4xHcJxx7WtOSPSjYvHfNhgyUmmuz4m9+BGP1kLO0ZKuH45?=
 =?us-ascii?Q?E7gSDig3GW9fe3jZ58eU3JONRy4HJPvASviLB/+EuEr5Mys2aIAkt++m8CAD?=
 =?us-ascii?Q?TZebnKofdOHTW8sG0UFIE01TPLwrYFsT5wKF8y4J/GDLHzf5AhCil3lAqsSs?=
 =?us-ascii?Q?CR6m6ND37w19Jzyww8JePqFg01qhIJNV4fyV6bE48VemU+JuI3IzvBI/ZnNl?=
 =?us-ascii?Q?PQvnITzbq7uuqg3id0dTGPVwMZ+IJ1eUAftYNPcOxvsNFNcDpr6F76QzYj85?=
 =?us-ascii?Q?p4IqWFCZNn5I8VuO3zvqj5WtvuZzN7o31eAF41U59xcXXJ6Mn3jlYknRvgkC?=
 =?us-ascii?Q?zHWwHLCpyrv2Yi3PkWmurm4D0Te4yUB55/A/8AN8EO7dfF5MD1UEQZWBv4U3?=
 =?us-ascii?Q?1jjKY99+/0GTkLPYdLVeNgZdR4jVr8IXsn+dxCzkXQXgNGX2PAVGlbKFD/4U?=
 =?us-ascii?Q?bbB3lNMQb0JYGZRxrsTzcLbHzYOYb1a+aYCP3wyLGXxTml5SvdXnsJP3Az58?=
 =?us-ascii?Q?edgqwunJ5RCKzChwqjvxz57MbZMImotaVqJwVjnl98CyNdj+DPxq22flFJEX?=
 =?us-ascii?Q?+MuXJPhH38yhakACBbTr0Mo1mLKlbC/EcYD8RT9GWXZbw7Z73WlHbgD+ZZ7U?=
 =?us-ascii?Q?8vaJcc1y8A/ajkamcWvJKQrCO502x7y7fPZlFDWrzRfWM+jdUWgral93MoEB?=
 =?us-ascii?Q?eufiJ/6CjTA3Kfp42rfKdU4s9jDNA3O3jIp68wlx+/YH73ImLuoYG14CW85h?=
 =?us-ascii?Q?u0i3u1vaCVqJwovCO8xHWY7SCqrI10U9ZK94UPWPklla/0yaIock/prktf5L?=
 =?us-ascii?Q?QJpnQ0UGAbvvOqy9EfliQBYU0MiOP5G0iCGhe3y9yywyQ4JxkfMTwnoAr4QS?=
 =?us-ascii?Q?A/N7lL8q+MnxFDl8wUoznbsoC+JWWlEnW8mSpt8nagzB8CRM0vYfodvp31KZ?=
 =?us-ascii?Q?nahk3U7cg4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?utBbif0qRmo6yEHv0g+r/CYHb1b6u8cuKtF7RQgiUQsMDXQ9yO7HAl60TXhv?=
 =?us-ascii?Q?+CFWe1UTXXxgqn09k95WDcn24IpVRuPvYTMzs90R7/oLYU6EnzJDE4DD8Fn8?=
 =?us-ascii?Q?4Asu6kdSIeJpDyYYs6EEQJtwY61a4aSUV7aaVzz+SIB459FDg+a7sts9FScg?=
 =?us-ascii?Q?feZFBXTEUDzImgkkUhygkGk/lTEBe55t1ohDgzQDBd8eplCh0qDOJdwugwCQ?=
 =?us-ascii?Q?9qdf1Q+6TTpmJ3ut2GjykkWNwbYYTdsY4MIctejF+MmIgaY/a8E1MnHAZhkL?=
 =?us-ascii?Q?U+ivWDhPOvC6fEikfleUpodhvAFUnCSc/vCKQji0rMJyr5xS5JCCnbQfaYKh?=
 =?us-ascii?Q?/OoMclHFTP9KfCrNhauOa1DnYp0kVSvqG3ECwpDa6QfDl76EdwVFVRs8vy6B?=
 =?us-ascii?Q?NjtChwtUYYnebt3BQom5vCOfEN0LmzhH3ZQvmYGKdBHq0h4tu+s9FhjRNMau?=
 =?us-ascii?Q?l/fYbAT5F0JlJxqdDb2gWkKeay2x0/Nwppx7M6/CT7TxBaDdAUfJ/15TleEt?=
 =?us-ascii?Q?rxSJyW3N7xRpvu3O/c+iO8EohaMr4ytr6gPd22z6i4i14QlyRfFSb5BSh5rX?=
 =?us-ascii?Q?OOInMbvYcvL6rvda/c+c0UHaSZAeWTd1qrofw/491jaoZ7Em4B4YoXJoEh8B?=
 =?us-ascii?Q?taRTgSR+JDP46W6U2RR48kY0DHJ38AU0wrDFOWYcUywXZMFMOFbQTUBsAkzB?=
 =?us-ascii?Q?N2NDq1mttkuqy8EMNj6I8M5f5jUxDVXG3g7+iLrE5eVMAZuNjnZIlk2cR0iL?=
 =?us-ascii?Q?pm0YCtMx5NCMFmoos8e8NQLCFVExEOr53WZ6ty76NQY16zjWSQ9Y//pfIkhJ?=
 =?us-ascii?Q?gJYgmgJxQPzlnXz4Y+B/UU2tZKHdX36EGpM7oEmp2n6dGtOcIJZw8tKD8Npp?=
 =?us-ascii?Q?XRnFB0vsI3kfgYNx490+0FiKv7TQx0kJtIVcV2SCOdZpV1TtYn/ohWwHOhA2?=
 =?us-ascii?Q?DubuVjCeMdI2BRQ1HZthnDTfjQauDBtvXBruKXH2uMzm69pFei97I7I5BEUn?=
 =?us-ascii?Q?wFw2ccNC6tvD573PHCGAonbZFX3U1AW1KK2WCI2zptSEfjJYyVPqe5Ywxdqc?=
 =?us-ascii?Q?hdnpY+eslGYj6+3S7J2ud5Jwddu6gIb75pJBlQvqp3f9sU02q3bfjqbl/dny?=
 =?us-ascii?Q?Bsz4w2e7/n1dJmA41END6Wc/OBsp15W8BQgFsIsMJtTuQF6i3+5U/qwR5pZJ?=
 =?us-ascii?Q?Bv9B7WXP9QkLthVoQMfbv1V0vZ6d9rvgHGIYDp32DIo/7G6BcElqAwD+xz/M?=
 =?us-ascii?Q?LObj+h7QQ8X9R3b6fYjFlDkAZe3ctnP6yH2zjEwvpOS6h7705Q8OXlBNtYw6?=
 =?us-ascii?Q?by1hlCNn8bCVOWUX+5yQIJP2DfIjWvHQfkobhhEriBrGEXIcogXVoO7Si08p?=
 =?us-ascii?Q?/vetO9rPVzLNv5wjdjRhbJoN9JbfWXsKMrVeHWCrnnGieQAdHHZth9SqzdX4?=
 =?us-ascii?Q?RQVrQFLaIjLdW22mHatX5IBnMGHrWGziYggFloe7Mb+QNQkmFkQy74XGYYIn?=
 =?us-ascii?Q?e5FZMuPlpMhp81e8YAL1mRz/+JzWDyxyccnXPUtMxZ8gPuZOXkZxrdH7Re4B?=
 =?us-ascii?Q?3rnBrWJReQ4LwUda4VL1s7Uknne3J8aMcO8utG4QyuZQvhwcEy1GGdt/L4qw?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/hwo6JvBqlHglF+RS2GRGNGQ2AqXVJdcwKfhplVhtI2MD/uf5LfCkmYX/3ePDfw1XOm5PwbLTiee1eNY09mU3OUNqXtRDClAKtj+o3GPLFpCcP16xp+38Y9GFBoQpd+vKuNYiAzN4kSQiKe4zjO0KQIDURoRyEr1/mg54bbs9yN+tyGfhSfjzOlPB+44XQJYMobl+aCjz4+Daj3D83OAjWlggvyzTsNOn42spDq88xhAgBAsQJAzIcfBiDTKofybuOg0J4dtwS5i+PLAn9ecAkYDd6aRXnUjK9BtDoblb/BUI9dteNjEY+w84Tn9zXKGeWVFae/GQQMxTPgNpqm9ndKnCwjXX/SHXhQfcXdeLVSa2LNe7VZSISxgExzH9AYJbhd2Aq69nOt8Xl0zLdmhyATxLirJ6rWpkqsVZUZTwpfQF3rG+YKy0qPm14mwuD7oS+Jg/wIwik6VEJHxRemgZ41iXkOtJAnBb7QYzKQHU5lJm5MsLruYFtlN1n3CaQGF6fXZFp7W+g+thiomGxRdQz266g8h77mAmzIt23vW/iQTMdN4HU6c76SDnpv0UeFyMys2di8PrdrAH29fwItJGVPgPUhUZCZ44tNu22l+/sw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381d3abc-b757-4e07-75a5-08ddc62c594d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:53:13.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AK9cxndIAR93ZKhvLwobgahuPO0x5hTtR/Hlp50ag5LNgBzo/GHX7Mmfxntw2D/Gj2Q6coelbt9csYFCYPbtPd6KtIzCNkTOb2j/96JDcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=821
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507180150
X-Proofpoint-ORIG-GUID: Q8gSu6nLxu6fiij8eioFGL54oNY0OKd-
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687a9827 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=zfgEDa7afI36TMyQCHoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Q8gSu6nLxu6fiij8eioFGL54oNY0OKd-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE1MCBTYWx0ZWRfXxdyDcVKsPbuW tEYSuXQVvLXaxUoDIoC3zUJbCfpRPEVwZ6SYcHShXhThl6MosTJcePYz8QsOU7uIqGffdbAeYOI xUFW26ARmuoa0yiHuRxYPTw0rLNZV9lA+wIJyuSvWHV7VoXkJbbWMAjchEBAk/XBbJH/z1htIQ+
 HHF6GdXtn+LO9pr7/KghJXWBOcp42VKYroRevJDxxE+8Q5mSwE1d61Z8Si1GVJ9h7idBzvPFOfe UPIgJPS/s91wnwb+WjfVpzWjDsRWiwVtwS8brLNOP73uwFPPn9rWFQtcJ4jScy5YxyyTA9BKuXa UjGNCLpVLULBEBV8zkJqi+Ihm/brL29mJa5Lq6zyEFHs+xrM3KkUkJqVGQbeBbYi00gPSlXedVG
 90Z9eKitfew1ypEws4mP6Lu6vBJRlI/majni4uIpEGdZE16FX9NwuUSw1KFaK/D9Yt0Od+8p

On Fri, Jul 18, 2025 at 03:20:16PM +0530, Dev Jain wrote:
>
> On 18/07/25 2:32 pm, Dev Jain wrote:
> > Use folio_pte_batch() to optimize change_pte_range(). On arm64, if the ptes
> > are painted with the contig bit, then ptep_get() will iterate through all
> > 16 entries to collect a/d bits. Hence this optimization will result in
> > a 16x reduction in the number of ptep_get() calls. Next,
> > ptep_modify_prot_start() will eventually call contpte_try_unfold() on
> > every contig block, thus flushing the TLB for the complete large folio
> > range. Instead, use get_and_clear_full_ptes() so as to elide TLBIs on
> > each contig block, and only do them on the starting and ending
> > contig block.
> >
> > For split folios, there will be no pte batching; the batch size returned
> > by folio_pte_batch() will be 1. For pagetable split folios, the ptes will
> > still point to the same large folio; for arm64, this results in the
> > optimization described above, and for other arches, a minor improvement
> > is expected due to a reduction in the number of function calls.
> >
> > mm-selftests pass on arm64. I have some failing tests on my x86 VM already;
> > no new tests fail as a result of this patchset.
> >
> > We use the following test cases to measure performance, mprotect()'ing
> > the mapped memory to read-only then read-write 40 times:
> >
> > Test case 1: Mapping 1G of memory, touching it to get PMD-THPs, then
> > pte-mapping those THPs
> > Test case 2: Mapping 1G of memory with 64K mTHPs
> > Test case 3: Mapping 1G of memory with 4K pages
> >
> > Average execution time on arm64, Apple M3:
> > Before the patchset:
> > T1: 2.1 seconds   T2: 2 seconds   T3: 1 second
> >
> > After the patchset:
> > T1: 0.65 seconds   T2: 0.7 seconds   T3: 1.1 seconds
> >
>
> For the note: the numbers are different from the previous versions.
> I must have run the test for more number of iterations and then
> pasted the test program here for 40 iterations, that's why the mismatch.
>

Thanks for this clarification!

