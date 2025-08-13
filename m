Return-Path: <linux-kernel+bounces-765936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B3BB24043
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE15189F200
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539462BE05F;
	Wed, 13 Aug 2025 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="buYcBwH6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rnDBca8B"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC07285047
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063374; cv=fail; b=R6c0Drwl0zDtigXGrHziKiTQulZn2aVrslA4tAA34x9Vh57kHqs/vhXLJrMqGsQ5fN1yV3qrcpb/Zc+BPhvOszS/J2GqEd2QW9hVzHIbXxjD6qPzpKF7mA73OkoREZP+7MBHrqQNs1RBkJ3voUYQktJG1OfntIoNquUSevIEWas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063374; c=relaxed/simple;
	bh=Vs10SnMf62Ni+IsTP//2zw3RZeRVm2mGtvcGVT153Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VIV0wt3Xod7KX/2YTsrSQEA4t0HYFrUla0zpjjn7bcVjg3ubmvGhw9VVZV36wWgItnG5FyUfPXmqQ3bhGeUn6FaO8GHbE3lAH1pYW38+h9ef6lYiozsPO7zhnO+yy+2VnLjPy8DKoiXnYd6NdYHKPIQ0xEekIvXtsrI8nlxDIPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=buYcBwH6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rnDBca8B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CLQuKD026948;
	Wed, 13 Aug 2025 05:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PwO1h4ffe+lkTwdKnU
	a9HMrL0zV3n5bo5EtYTrc0nFQ=; b=buYcBwH6q+Fkx/Hg+FVCmIB2RfK23MIb0O
	xbudGSrcFOqw98qGOYah/PuoJ5mqN5hvoi/eZnEewPaBXhHDmVoiDj3MrkvnsQ9g
	/i7p6JJPbBRQfduQjgREnNqCPdahtVTd5Fn0UDFxZXgaKei5siPW9vTcs3uE5Q7y
	jtiPLoFVxy7oqzKF07PU3qnHT+JEtmJjPlhb4WJ1i77F06QKTSMsyHQvpT3fscPG
	CPqy6T24vNXpYe6yC3Npm7FpC3VMIg2QheFJWMNEcnUsW11OwX/xwh2whZ+GZeb+
	6tACg49k17wbaCoBPKdf/qUtdLnryr29SZaFa9zJQirV3yti2vfA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf6h9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:35:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D3M74c005774;
	Wed, 13 Aug 2025 05:35:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsaq58a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pe/YyAW4kOPsyLqIiCAGCR35woytV5rtbwtwLIBuAQtlLhI7y7Qj5UljMr+Lnt2kigIMHn+GknrsbgoEG6qccOTa8WZSaw5RFbYa3QUE4SMKLS0lU97flhYLEntbbcBw9Ozesfc2tkqXu+AgG6w6nPnbYdfyP2j9rGCWn6errFEB0932pL3YDpKSWyfZwAKD5LL+bw5K+zB74YARfDX1ANP+43+//cPKwKtQactibfRrV4bwP79fCPuCMz2BWbj5K6so6fXuj5OiKIu42AhSdzsLK+vhmLurasYChnsgpRD50u47jWvdrk9/Or03cHWgV5FcQswno/dIRrnOMPH6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwO1h4ffe+lkTwdKnUa9HMrL0zV3n5bo5EtYTrc0nFQ=;
 b=Emh1C6iuYH9YMiuQey9597v2WzYQWk6nwNkLFqnVFZCQN+s2UtQF8xa7sqm7UcFTpUVF4rmIZIc4ufYmun6klwzjdnqqAVrE6B8cUwvOVa8V6A3egeLpFoQ/ldv4T73ldZgT7s3bj/xtjoZH2tUs+Gc9D1RtY4lc/4wULGmnh0mj3CY3q3NoF7drUE6z7phl7HH0MMOU7eccFvYbL2mmK9Gj7cCd35rsWGkXOqS6KWeiouzOO4Cgc+UGkrzT72YmW6YqAZCiN/ouM14BNmCczWbknout6kf0t4DHSkq2+Cz2UTWg3CZ1eLalQ/cQOPp+3TNVcX1qCcTnEwLkuJ739g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwO1h4ffe+lkTwdKnUa9HMrL0zV3n5bo5EtYTrc0nFQ=;
 b=rnDBca8BlPpnOVIxlzHQUW0PYcypQShdULJfCgiHGQZJCxqZ0DvGOYL0BnS2KOrxQ6qdSBacSDrjZyIWxX6mHp6alDoyP0AwhQ2lgsuYbupjJXFzJud24mtHLdiNLrMJt0qkgnfQ4459bT/CbERRRw2cm4QSf0VJkDXoddrMnZQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6797.namprd10.prod.outlook.com (2603:10b6:8:13d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 05:35:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 05:35:47 +0000
Date: Wed, 13 Aug 2025 06:35:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 01/15] perf: Remove redundant condition for AUX buffer
 size
Message-ID: <48fd52be-170f-4807-9717-770f0fb6c88c@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104018.424519320@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104018.424519320@infradead.org>
X-ClientProxiedBy: AM0PR08CA0023.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 568ea8da-6fee-4af1-3ab3-08ddda2b41c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J02ID6FaczPuAIUag+Z0b96UQYVTU1c4Y9a9yWpXAZe76dUSWu486aMthsfV?=
 =?us-ascii?Q?5WnMMgToXNIdLV2A+XT1ck4aalr1k0midpF+B2OFD6bVHMXD3NdLHe47vV1S?=
 =?us-ascii?Q?Lxq8S/ofaVle0CsdMBA5lpUTlC6Ul9+vtKyViyTGIghZOGBx2fO2ye3GdJx1?=
 =?us-ascii?Q?msMEuBJy0tyUbV6YTlkNygMmfL5NfYObBYXGSbe/rxxCfhGavlvLjF67HiFw?=
 =?us-ascii?Q?5wuHfejQGrCDKHUSoEaG8cZYRbsV9aD7P4VYlU5J1w802xL72ZhDXiIszpd7?=
 =?us-ascii?Q?vOGAsyy4Rrb/3vTpuixoo/77IZYtzqb66yOi8QKdDK15vDuz2bo+bChSR8RO?=
 =?us-ascii?Q?dKloKBdJZ0FwG8MbId4zv6DAERc1C9fsjuQuo+YKLvi+YLu20AVPk34Ox13e?=
 =?us-ascii?Q?9lfLt0b4qVgTbggpVkksMuXJH+hQZPrm8Gar7JuUpcvmqy8ZTq5zUul9akUp?=
 =?us-ascii?Q?cl1bRUT8y3e/PUoPZ3qsktlkroTzDmiIlwqRwpI06lXddNwN3Xsfh/02aCOR?=
 =?us-ascii?Q?2GGtGCk9VlNedePtZlWjBPl+qcZZaZfgfp++ll3xhXUA5wdZl1vMpH7CCmRD?=
 =?us-ascii?Q?Q9I91Uxxn1s9YbAWMyKwtonsAdmg7l/jX/5NZiaLuNvB/A7QKy4ZqRvuBnve?=
 =?us-ascii?Q?3rE53XXvdgOeB8RaZ3KNOwLnI1H0Usxj1LPW8jqgNEW6qB7+aDXDigcr2YWb?=
 =?us-ascii?Q?nBv/SlnmC76v9QYEHq4gNcAmUgDCsriXSuwcqoeWxNNpt8CAGYKGKIPoZN44?=
 =?us-ascii?Q?SB+YklZA+wC7Ovw3K+Dv6GRVrFkGbE1wXETbImod4izErzPQU/wdHuIdo+M+?=
 =?us-ascii?Q?+pEdGarJLwdFiBLjEOP3r5ZLVX4spPV3Dn7PofZ0yKqPcYzhhI7SDgshPgtU?=
 =?us-ascii?Q?z81eNOohUolJ6HoKGSEK1ozF07ZMnUDChL5vYThm7qLy7+Yguc1B67VOXnHr?=
 =?us-ascii?Q?pMCOnslxOTF/adGhm9hwxah3QxWy6rs7JWlf6WSH/WDqwY65uEHZUHgQipMK?=
 =?us-ascii?Q?ycpwnFYDYSvslljrO6lWFebzwIlvUqozFswmY/pBWVzsmpBCvUGXSWwXY9jF?=
 =?us-ascii?Q?EJvsFSA2BUXt1HhWFet+xlXKz8xSsFfPWAWWb4gqNTxatg0/u6fWPgluR7dD?=
 =?us-ascii?Q?UdPXrYfJo41dxowpRVtpO4KlXla6lz5V751FkmCyUxN0DJCKt4J35pwA1ooa?=
 =?us-ascii?Q?mX57yhjBe8Qo14WBGLffdbbYc3YrN4oiCKURbMPuLC04/6GJCpsew7NL92fd?=
 =?us-ascii?Q?i0pPNbwHFwFwKrEW850XDk+PS/+rlOIxqh1d8kIYXa55+tA4yqUWXk8+nqmx?=
 =?us-ascii?Q?/vIeyFUp3yDWsdSnlYSiitAGXgSs2xohZ9XJs3jR4DU73ENFrE6939EZ7HUN?=
 =?us-ascii?Q?GT/CjOKRDBaPYnUhJvKX7PNFjEF356L3c1O5MmMz8ZLf6OQY+WZdxjAo5Uo1?=
 =?us-ascii?Q?cfN/gUjWJVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kRjc5Sll1Viwd3/IU+I17lff9ODbFc+5qmPcv9Lr/rHdWnvQPcWqSBwVD3E3?=
 =?us-ascii?Q?VuiyfIcpBhzWUIao2fwAy03kBV++OCKIRuEZYaWXLFadVEMIPTFHNdeWSxIy?=
 =?us-ascii?Q?/9RPjTA13CCjeZzWEFJXcv1b7YcW35ut9E+TDy8S8ZtJWYVS3sZCi2FnlHmJ?=
 =?us-ascii?Q?6D7/Oo3jtpVkUy57+OmsK7C0S8CxP8tog3RkCDXQbUvWOMsGJjqqUlRpXPHo?=
 =?us-ascii?Q?3m/PVtEADBAg1WrHil5sIbijBPqlvul+dChBzmdeNZJiHFiIdbTp8g/bwZog?=
 =?us-ascii?Q?ifKbiHNr/hYIfm8zgD63N2Nq54bRK9S+L6a25FHI8/8AWGxAZ5p9i4nNHZgD?=
 =?us-ascii?Q?ucLqe/lgW9Zut+arxa6aPckMCQjVoASbzd/PpyWTaWvgFJXwbW79ePKANntB?=
 =?us-ascii?Q?XMHjq+bSfUmBDy1mdsOc+xM9OyZV6nd7vW0om3mGfmVwzk/SBOk9QSjqeu37?=
 =?us-ascii?Q?lP7rhiivAZStHQK/V62J9XxSS1nj2znDOKdKAqBGOo43VVUnBWwsS3eVrXbe?=
 =?us-ascii?Q?ekRW0cquHNH+EdarFM2spoLBxmkF4yhPFvu7XGU0aHVXzOa0oq87NcwY83xl?=
 =?us-ascii?Q?jied1xtDX3mnys2LISRn6N5lzM4bqsLsZMXudGKZQI2FFLZOsIX4Zki0bmg3?=
 =?us-ascii?Q?+g78jM9bQbOYuJFseSWwzJdrfPaIbYw0Kh9NSVsCzZxGLwbY9xkghHB8pQsv?=
 =?us-ascii?Q?sB0cM/3Yxx8gkldVshw/ddF9lNh9kCtRshq8zim6q9Oj+eiZjRVcxIsRKPmU?=
 =?us-ascii?Q?NurjzLkb3lT1QRB1+jRJy78RbYWBNapwnzLRYTLyBJlYGJvNO0g/Ib63qL78?=
 =?us-ascii?Q?VYCkjRj4lGhVH5TM7TMy3uwy+1IyPqpl0ZPUdrgOGr5798gxn7ba8Cph9RMg?=
 =?us-ascii?Q?z8oP//fkBgneh8nVVQDFTJddKT7Ov62TxA5Vi0B2ghjCbqV8+TBWzMfElLBR?=
 =?us-ascii?Q?LdM1oZbpz66bh6GvRk5Y1gsyedhoDDl3K2tFeWTzjGnyspNFottyLgSL/DN/?=
 =?us-ascii?Q?SDAkmUX5G/bAF9SsknEmpvP4yFgKUjwmDW1cZVwpqGsJrIeRZmcr7juw+D8+?=
 =?us-ascii?Q?A7O4mnxuvcpSEFUHFuxOrfvu8ThYUq+vhbGzJaHdOJJSDnMyCDuuF7noHC4k?=
 =?us-ascii?Q?gR+R7T0EurW/tWIN2y5Id3v8nBGtK8h3vcnXuJ4HV3M/xMUGKFCzBNgTHdv+?=
 =?us-ascii?Q?vIK7abG0i0IMLUsKzKd1TdDkIEjeDC4447up8MOt5mkdpDk5u/6iwyNqFwzf?=
 =?us-ascii?Q?XslJJZwvUjO2B+XEBlZp9WCoE1NAt7MdSvBA2XjvWqiHspyOm/It/tUyyo1Z?=
 =?us-ascii?Q?NUXdm/OyAKJ2KH1GjChLEiW0jcmnC+V53M4lkDlpCeSow0LZ1HyH0ukouxtq?=
 =?us-ascii?Q?dpinV6RlLvpn08oNjvKS1l426JutjeN7muRQgKm95p/V07y80OfQ6ijgaX4h?=
 =?us-ascii?Q?5SjTyXxsRPFEn1eZXmQTvlhbMNoTKScoLulszG4OR/YeTvh4Gx4iSaa5Y9RE?=
 =?us-ascii?Q?EKpyL4FEkgS98NJP4hFkGx3nUmFGTSCMya4qznoCp5gHkjfHmEptM64qqLNJ?=
 =?us-ascii?Q?vVs8h/EkdiMaINWzpZw44LBLiQHdq7gxFysThGlxXqEJsaRlS29YIqwwIgWe?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ovL7sMN88LMM7trTW1lKNn7Pm+L8WzdK9EcbUAgIWvt6Kalf0zxhJOcCpZKopgU+445b6M01wn3b3oUZ1F5ZWFMUGmt3oYmqidUwGWsDRuKsgZl0Qk3kIuWnjus4oKO75E4ksF2L08vx1i48LraAbbaxKK+xfZHRSEQD3xZs7fgY+LnafnMj6G0T4fc6BGyiQQ9wYzcDPkbUoh/2oNq7pnpihj7T7FS49mLqU3V0wuSljHCywPTH0mzSU4CMI1XBr1iePSiiDNcPd+efKbUGsnPSuMhESNMR1vrQYGOQtd4AE/UtZlITBaeebUXuK/m6aevN8fS/+FXkAnmMJmBXlGGUBBfmwQk6Wqkug8ph33N3UNp299L3HJdyUYS4HKGTDYv1iJeWKrfVyhhcd3iGduYMpr4W5nekwcN29/fMyjO0YwEZUOthCLF9anHtFym/dUgEK9uPWVnkofgJe8WNfTDQ/s2G5kJTw0oilHGszoc45cbDACT1vk62f+o0QGZqpsRnbvzn3e+/5T/tc07LLrmmWTvubifcr+KFdrzbiQTmfyEzi/JZy+FPep7XEMJNPOqVZnC5TQPrFiPyEJBeztx964vlfUXBFcq5rSJequY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568ea8da-6fee-4af1-3ab3-08ddda2b41c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:35:47.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhmzhAGNt9LO4LPmkF4C/cR8dK8Z3o92l6AHBuOIkNkTfdL8tbvYCo9aFujJdrEkm1NaA7tplG6FlUgG4LGT7trzPXhdCv5eHiFUpqX8xQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130052
X-Proofpoint-GUID: qTacti9Djc17aaroEixFZdTokjY30MUz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1MiBTYWx0ZWRfX9sSCJmM0DxR3
 DAGgkX3TzrZOwOWaZCN57O2Na/TbhJIfHNuUBDkNc8I0os12j8fZgcDMxmpRGjKWNu6ndkDN3nX
 hIkqbSeZCVo1FLiruk+haLzIz9Kemvyf5bl4SuSg8CY7pZpQw34JoGzkRfNL3GGqbLmfwz5rqd6
 /SlDkvbHAMBWl9VF/cjUHVqASwzTAJPOrUvsC2Nwnc40JaM2UYy7ON3Ria87RLmp7VVNdZexfga
 LT9uIauEGXOcw33dUyrHHw1cXg3vaZ9bCRB0v25N9ewva+UOzuT7CSgJPxcHmU6wGVdzms1Zx54
 jQ20PxPvQhENZJkwVLdbCjHn7Pw73sLQ2lbrl85mRCcdG9+kcuxMW1PmTyS4NAMpE3ZEjkzoBio
 bDb/CoUmWNOs4rOTgwW+IArzK4RyL+WdYjr2pHNWcR+NR+0BC3mrd2lXazwpldit7aol8PsF
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689c243a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=PVl-bu950hoLcbqyWoYA:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: qTacti9Djc17aaroEixFZdTokjY30MUz

On Tue, Aug 12, 2025 at 12:38:59PM +0200, Peter Zijlstra wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> It is already checked whether the VMA size is the same as
> nr_pages * PAGE_SIZE, so later checking both:
>
>       aux_size == vma_size && aux_size == nr_pages * PAGE_SIZE
>
> is redundant. Remove the vma_size check as nr_pages is what is actually
> used in the allocation function. That prepares for splitting out the buffer
> allocation into seperate functions, so that only nr_pages needs to be

NIT: still get seperate -> separate typo there. Not a big deal obviously :)

> handed in.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Link: https://lkml.kernel.org/r/20250811070620.389961756@linutronix.de
> ---
>  kernel/events/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7043,7 +7043,7 @@ static int perf_mmap(struct file *file,
>  		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
>  			goto aux_unlock;
>
> -		if (aux_size != vma_size || aux_size != nr_pages * PAGE_SIZE)
> +		if (aux_size != nr_pages * PAGE_SIZE)
>  			goto aux_unlock;
>
>  		/* already mapped with a different size */
>
>

