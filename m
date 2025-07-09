Return-Path: <linux-kernel+bounces-723621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C08AFE92A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19091891181
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607CC2D97B0;
	Wed,  9 Jul 2025 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c4QmCaQF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pIb7jSa0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832A292B5A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064929; cv=fail; b=LNE6hziMLSXfH2lngdneYnuF+KZbOLu/DHk4gpDB2vtJ75nwl/WIt+Pj9TrS3xHAS5zfops/1I2/hxDU3eX2yuG1aAaB+iodlNFGQzMG53ELuUfTjwQIi8uJ3Oxbrb+9E8g+opf3fHRLomYJ1i8bATU/0n5hxDgkOeJf1wlO6jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064929; c=relaxed/simple;
	bh=RYir8Rh7AF2FuWG9BjjsGUwqeTjrmxPNtoPMZCW9c2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I/pNoyuIHIiYKW9gMQH1Bm1Ni5qaMUj5KrJmh3IgVTcW8HApAPqvOcxzO13nmJ+xJpE9fLvHbVRE9jVgdVqfw5b43p5bwFHoq23hvUlDauUaq9P0C9WGQgXep87VrGn5Ljh4lGUFJHPvHQNvgnFjLUtxmSd34iEtJnFJT5se0Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c4QmCaQF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pIb7jSa0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569A20rS012744;
	Wed, 9 Jul 2025 12:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tUqwQz5L22WgPx4Vg3
	ptsLp3/mhHzo06PF/25ayZb8c=; b=c4QmCaQFnr7G5eM7+1YgbCjo2cPGaZwDC6
	EjbjA/g7vaHvcGK9cNoHjkoG2bwZfLF5TNhM1llkNxOWZMIPYlBOa8tVPzZp8mhl
	QRgjWJvwaffkYkG6aHs1aT3e5ityZ/TYl+8pOlaH9hH8KVPLA2DgoeJ9dvedKjAK
	gvTZ/TQ7rkSH1Wbks8Oti5sZqFDFPripXXsvFLPfCL1orDmDqULrYeg0a/PZqd4B
	R9wcQPQVwPqsX/Z9rrkZLREy5Aij7K1Ub9F4EtJRsTyeXfd+44ya7jzoNx/7HRsU
	VNa3V5jyWB7reA8PF0PSuQ35vPrhwascQXmI8w06nxmykuh9GYvA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47spadr8d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 12:41:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569AUwAl021551;
	Wed, 9 Jul 2025 12:36:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgawcv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 12:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e28YZLSQDqWRCE9VYQ7vOpoDpRZ3YXIxjUWbOpKg8e3SziNQudky8cdkJz6y+gk+4XnU9tDb+dtYNJ/k6VqmnRIj23ybSgTmuccFGoeSALQM6/L5QgmB0IpNIFOFyRI0OQcAY5C7WutuBWCs9A82m9RdJOdbcWsy/xV1KCuoQZRirR2vD862D1Zm89KAyQzID0uTNAT/KNc6iucxjqdQ8zyOICFxwVL7UiJC4xIcBOnb2ti1SkjfdBrkGJ6Zuxl9xvOq8ZVYrS/YhIWzoBsVBXwRkPSKq7VybA6Is7JUkEnI0n4crY3upUdEzOdweaP2439xvcBncJGqEaPqpZ5RFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUqwQz5L22WgPx4Vg3ptsLp3/mhHzo06PF/25ayZb8c=;
 b=fP2Ea6mCAynZVYHmNyzVJHJDqWzYTyCZwkQ+2VcpPACtcWoX0fxmlqVpgRvivRW32zPbGORA2/ur5/j17KpuWnBJk/8knoSu56xYEA/acaYkdKRB2mrZIVdKGAiMwbqUbGbbQTX1Ytc9LhD/kzB48assD7yaW1ENJmggvs8LE6Eo9fRi4Kk2j5yLgzMycg/us0b0WbSXV9V3QOUQ9dGEIjy01QAlst0o9Ml9cuK6kJ1g7vhd6gaRjVhzJKC28sVYreSbKd2I+prNg2olVbfBUfaRC4NiYtsdULBkBt1rM45l0hYKdu8oohfHPYMdqgjW+mUNTY9+q45Ulyh+i2z2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUqwQz5L22WgPx4Vg3ptsLp3/mhHzo06PF/25ayZb8c=;
 b=pIb7jSa0kJY0fIGS+YLBTmxQKtUctp9A/gLSjkTtkDkrPc5YBwoMfcqxqDSkU2u8gIsG26s46BusAp5btAjErmH9KCD1DK63xLOvj1pp4IaLTdwZeecUSmh1rurqteNJ29t7NTkK+Yd+G58REEqiRJcddmaEKpDFc4PW0miS2zc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 12:36:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 12:36:42 +0000
Date: Wed, 9 Jul 2025 13:36:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
        ziy@nvidia.com, Liam.Howlett@oracle.com, npache@redhat.com,
        ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v4 0/2] fix MADV_COLLAPSE issue if THP settings are
 disabled
Message-ID: <573eb43a-8536-4206-a7c6-d0daa1fd7e70@lucifer.local>
References: <cover.1750815384.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750815384.git.baolin.wang@linux.alibaba.com>
X-ClientProxiedBy: LO4P123CA0508.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b8a08f-b89a-4aff-4a69-08ddbee54211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rGmnINiKyN0k7NM7I1ua0+NWVz0GRaYSDWfxvnfborCGs7y39TRR/4cXO2zk?=
 =?us-ascii?Q?enQchuWJ/kRNnd1y9stleDDSXXVfeObnACpz5e9RhEj6BIDgfiy/RBxi1GWR?=
 =?us-ascii?Q?ChJ+vFgUta1EBn2oYWTz3OkEeFdjyk22+zeRlIkbNY7uBbaGtvrpiOiImrym?=
 =?us-ascii?Q?VlopRrZ5q63uPpvo5EkStMxg5N0KeFFn/1S6XIteU/727qbANu4WcVLPtZnn?=
 =?us-ascii?Q?+BWtc0u/IKOAbqHP9Ly4mzV2ceVlDaZ8rWiiz7v1Iz2Jji2VFUthPXvsN1+r?=
 =?us-ascii?Q?AA+LPuHyCc98VC7QGU7/jKfwXTOCq+Ahm9yeuiMJyO/Qq45PyQoj4YXkYw5K?=
 =?us-ascii?Q?hkn2IfMfEtPr/1QkjBBZbXruM/l04WGOFpuux2J3PLzVv5bXc7I73hy/IZfe?=
 =?us-ascii?Q?7BTV0+DU3ntEJUDguvo2Ogoat6klQybFEq6787TQBC4VEDe5FA16v1gKuSWS?=
 =?us-ascii?Q?3hht6/PkcV94LAMyGVXC7qIZmrPNwePwD/QyCW3nvbcenG5Ms8kE7Fi14lCP?=
 =?us-ascii?Q?1Xaw7krGn7c04CvnZva7bczr3Qc/AKNK9EDGimC3BcGMx0Ll87Wr7hgHAE7/?=
 =?us-ascii?Q?vBsYKGj30EBMOZ8XsdOg6SYI7fuEmcpI6Cxj8iJ7FbWhdC7NniN0RATVFkr7?=
 =?us-ascii?Q?LBoVwDBqBB3IsQl3dhpZ4T/BZdnxSlhvnk3jjwTWIyGQEVypIiD/amzOr4sX?=
 =?us-ascii?Q?1M4Mdifv9kc9nqiYfsyv+ZfcrKmqRylyoWjca7vI/JyspL0j0UhKQYibZ4Kk?=
 =?us-ascii?Q?CqeXtZ3mUyZ+sIFIdRQH/nu7bIi1OpGHZlm0QpTCDRXkpntksroGVDM5wfFi?=
 =?us-ascii?Q?ZH1XCW+GNwhALXeGwEX6IDQnHPJYtegWSZd93BV8oQ3EzpJK5fRkezGBZnxW?=
 =?us-ascii?Q?AqFtBV/1zqmr/+AyBxfFClruDROKIXoquuJTGToyzmklPpqUxCVXkzI9g+vu?=
 =?us-ascii?Q?mS9keO20fcfn1w/+gUAej/lgo2HEFdjIBgorgdH04EmJyiPlxXreYqZkl5L3?=
 =?us-ascii?Q?aZzHunkoHYloQnP7R1JKVNtF9zC6jRPyxcyAuNBscGWQT31Y57M1jTRHbn/l?=
 =?us-ascii?Q?n5rqz4czdul1nB5MYtxpj9GXxbxofwrzAXJNfFFwrSFSFC3oFenkLfXDclfY?=
 =?us-ascii?Q?N5ieABmTVZPahKqIJ+wi+A76fFbUUTDn1HEjVhMtkvgLRUdAInQrUfQQQSge?=
 =?us-ascii?Q?rxWOIlJPfzK0s2xFzBTMb9Okl0QdzLcusGnckQzKqxNGKWwUXSVtVn9J7tn+?=
 =?us-ascii?Q?9GLZ57xm50vJ7O0+8TYLg5aBXVxC2IVOwvnTCAsE880WClHikcVtUuUKltDO?=
 =?us-ascii?Q?BRXTM6z6i6v7ytVNFfO650jwOh3Z075ifXA+6KEhGbKFs3wcnlNX+NukxC6t?=
 =?us-ascii?Q?C0ZkUJbBOwSNOi+IzPELNzRzD9fj6PFMEtsc1tFz4Z3Qrt0mh97ie78J4DlB?=
 =?us-ascii?Q?AYxEWj7U1to=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tmGTE6Abz7RsCkZIplSUiHwEcHRJGiv6FZGE+bup81HYbHc5eHJ5hEHf/2ZN?=
 =?us-ascii?Q?0lqgfmPI+J2egRuqPZ45ibpYjYmAakedCsruDH6iaBxwD/zv4G2ydv/orkjg?=
 =?us-ascii?Q?bEoTc0g52lNZNgy4Ui4uCTUwsLZNITzGwMKErZv62kuCLvZn/afybjjejKDR?=
 =?us-ascii?Q?4TYnGcVddMOCbAsrRGCQoNbhAlTHCCGV0heeH0vpSAJCdY4f3dfXLgqV7zjg?=
 =?us-ascii?Q?rvI4k+pHMqYXOymoOvP3z4I8ay3+VC1cMKlhJdXRaP6wpAXx0gr3I4la6KHT?=
 =?us-ascii?Q?P45wEwDsiqYRT0RiNe1Eocf5jblo9f5oW6TpWvFt+bdhpWQRL7ZR/frW4j0e?=
 =?us-ascii?Q?yRtXCfIjqHgRNTdxFg6euiIDiFAOgY2cMbUnf2gZbccX2nil5YXW8RDRo6Iz?=
 =?us-ascii?Q?r/Ank5S83aPAD8cKawumm3L375MDCk2QHgCx4oMFBUdBUypvVLPDw6K4H2ye?=
 =?us-ascii?Q?dmwIA4orbIcYrqs2AQefiEkbFkjsaXw36s6oHVoIMb/Zxv5sv+GflmEEpXU0?=
 =?us-ascii?Q?f/5phT7dGT2vUEGeJgYMTIkbiWOpjjkbUwJ2Fxh0TFqWLM4OlwaVPQjkDYLD?=
 =?us-ascii?Q?TLAb0pAxhU7FKl3tdn8M1zkZyN1c2fl4SDtqw62Ft1gBgPoqtFQnlnYzJd5r?=
 =?us-ascii?Q?9ySm3vNDFtHLGtU173gglhs4XLCPDWO9M6QV0iIuQAT9bZbmO8MGfjNj6jQD?=
 =?us-ascii?Q?vKkXoYbbe40cjbTiXgdXPctP/L0gVWtfEjlOIopPWIbfx/i08ifXbNZAXkS5?=
 =?us-ascii?Q?nhRAKIAcvzymIWkFj2xYaUhaNNSXiTkSzah8P5UhlQmD+98yYTreO2zwHWHy?=
 =?us-ascii?Q?jTINYyJ+q4sVV93/tQUNE1+t/gqUqzgTXe/h6Rrtee9Ij8wq3k1dacfwdD8P?=
 =?us-ascii?Q?ur8BEp3DO61A8VduGuHNBL8ClYvWrhoMHwuhODO88M4pO0c5d7KmWEcBSVGK?=
 =?us-ascii?Q?0kNZjBQ5hh5sjobiMieaqKa+WW/JZejo8R7p1mMkFSh0HBr9f+cWxsql740h?=
 =?us-ascii?Q?4XctJDatGVChIuK3COelhXTrZUuUVape+6fXIVkxsuqrZqAp/yYYBu0kCgwT?=
 =?us-ascii?Q?81EcmH2JVWumE7D6WDCb7nmdQLunZYykOuCrZOdktZrWAYtnt6qx+5OzOnCU?=
 =?us-ascii?Q?PRMWK+xy0kWFrwvEFkcclBQc9cA8wMxZiWoDD7H+yfFaZtA0zkIb0+X2ZJXw?=
 =?us-ascii?Q?VjgyPrOdbTI2xlShEernHaTAZ94pXmOr4KFA40Aa4S974dMVTjj1nzxXwzZV?=
 =?us-ascii?Q?x4rs09q12S8B409UhenC2VEWwVgGBPXTaX+jLkN0tjGVwA+XaYBs9Ay9rqBa?=
 =?us-ascii?Q?/Lih2IHK/pTHeYDvLj6UwqYAGN1nR7PNZIh5mJyIiFZMTg/X5CVfZKbgZHcM?=
 =?us-ascii?Q?mraP/6YS2sawlUoH3xriKX8CE/xBMcVa8CiRupDNTdwk+FgtOST7q74joo6Y?=
 =?us-ascii?Q?Q17oDgVyN98SQV0jwsks/ghzrJ/pvjguHokluWm0SAj1bZ1omzg2IW8qmxiX?=
 =?us-ascii?Q?NyrQ4E2IW5sbaLT0JudrWxC4hrE9fGJnqG9yZizWDW9ltE5861XSukUqnRI+?=
 =?us-ascii?Q?X2SG9McJ5H65EPT/U+lINYobp+0DM3fj6HD8/7ggtsFu6UwWNzk2jIAcdDQ2?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	29qTmbqPY8c2yiSryxcSpXbdqSGFXsILlGipZSI6j4Nh13TD+TeWttJCLRCM//qsSt6DdWvULQk1X6zKGJD0upiSNy0uy3zrFIg4ity2sF1lob4MroA0MvbAZhkV/WzoTlpAO5ruUyeo4D6Ge5WMRcg8XGIsI5HOjNS55aT2Una76FxOKTysOWcM9oin29icLJ87cQbUkqgPwFzvolUppX4xoUEpRMQb/D9cuznYBxNJZDYkoDOFPJR0tlM2BVwNXK06zUlavudc3rdE9sYHLSCf6wURJvuAoQU84iRflFcQbHke+sOAbZ3HGJiGN4WLHnAuHclvgrXorVQbQspEYvceLWPAb9r26Wn6mNIdBkvqYvIkqYQtmS5ZdlyQXQzCifLPB1RbhiCIIk9eUav2VvJWcmMrWFr1Ot2rsRPbImpkL0Apd9IRr73KUYCHSaRMs2oNRt5UXtx7Q4oSXtCXtdo9TGErJgFi9SSkLNR4GWu9AoiR50NfpMs5D35ZBFTVge0JfsSBTXLeh2moG5vkx4MzWvoKmTdP8+LMha1qUHGotnb9ubEarFFgyPN3oPoxxLjo4rVYQe8IVUJhG7yHjy7DFLES9QxvE3wwo5vJu9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b8a08f-b89a-4aff-4a69-08ddbee54211
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:36:42.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCJ8n0aGl4ScjtrqTiTekNiWOniUZb4JIBgGZvAkgnGXUOLlISfeGFFEPWiNPNRL4rDw2kskZASH7cDqH8ZgEiVYKOTRMGgF9hMtJzCFiJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090113
X-Proofpoint-ORIG-GUID: P95CiKB7grUXyAK2Bln24zh99LF5GTxH
X-Authority-Analysis: v=2.4 cv=caXSrmDM c=1 sm=1 tr=0 ts=686e638b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=WJxuc7IjJ3eoLCQNQEsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExNCBTYWx0ZWRfX9+w61xQE/XFS EoKHwleIWfjP9caRIq0LG9D826N7+5esKTFJSFJ647V13vNGk1KhdHk0Xg+FClCZ9Z6/OnNcfZY T5ZIzSZWdPtGbn42uHsDn0FgYjZmTMJ71WNR5doZ1rE4U11ut+whR+mVmjS2PMRlVdxkNFaD9OS
 M0qB52ViUgsoRQxfYv1XobOpaNJ8TFFIureXnHjGn+yx/9ViLv4XrAp6CvI5FYH+hBD6dC9kOk3 JgNeJDIQ8m3y8lOZ/7nSMDgeGGm3gEmnYZuvkcvtHHJDcLhgFbi8rAURgx3NzNCbIwpme650Rl/ uRGNYnx6dv5NeQQxABJJn+laPGPXRY41BpgQkoxL4+Salnrj61zeHXwhheHuKo2UP90IyrO0XH9
 0yM7DOs1A4e1RBkUzfLPspSmF8J0OsjD4Hp8p8wmvl9pkYNeNkxjY8JlaKIm1uSf/vReOkm3
X-Proofpoint-GUID: P95CiKB7grUXyAK2Bln24zh99LF5GTxH

+cc Pedro as he'd raised concerns here also.

Hi Baolin,

Just for some clarification on this - thank you very much for this series,
but based on discussion with David and concerns raised by Hugh + others,
overall it feels as if, while the documentation is no doubt vague in ways
it ought not to be, this behaviour is something we have put out into the
world and we should continue to support it.

So overall I feel that this series should not be applied.

Your work here is great, and really massive apologies for this after all
the work you've put in (and of course the review work here also), but on
reflection I think it's a risk we shouldn't take.

I understand this means that MADV_COLLAPSE can't be used to collapse at a
mTHP granularity - we definitely need to have a think about how we might
provide this sensibly.

As for how to move forward - I will go ahead and update documentation to
make the situation absolutely crystal clear, both in the man page and the
rst.

Thanks, Lorenzo

On Wed, Jun 25, 2025 at 09:40:08AM +0800, Baolin Wang wrote:
> When invoking thp_vma_allowable_orders(), if the TVA_ENFORCE_SYSFS flag is not
> specified, we will ignore the THP sysfs settings. Whilst it makes sense for the
> callers who do not specify this flag, it creates a odd and surprising situation
> where a sysadmin specifying 'never' for all THP sizes still observing THP pages
> being allocated and used on the system. And the MADV_COLLAPSE is an example of
> such a case, that means it will not set TVA_ENFORCE_SYSFS when calling
> thp_vma_allowable_orders().
>
> As we discussed in the previous thread [1], the MADV_COLLAPSE will ignore
> the system-wide anon/shmem THP sysfs settings, which means that even though
> we have disabled the anon/shmem THP configuration, MADV_COLLAPSE will still
> attempt to collapse into a anon/shmem THP. This violates the rule we have
> agreed upon: never means never.
>
> For example, system administrators who disabled THP everywhere must indeed very
> much not want THP to be used for whatever reason - having individual programs
> being able to quietly override this is very surprising and likely to cause headaches
> for those who desire this not to happen on their systems.
>
> This patch set will address the MADV_COLLAPSE issue.
>
> Test
> ====
> 1. Tested the mm selftests and found no regressions.
> 2. With toggling different Anon mTHP settings, the allocation and madvise collapse for
> anonymous pages work well.
> 3. With toggling different shmem mTHP settings, the allocation and madvise collapse for
> shmem work well.
> 4. Tested the large order allocation for tmpfs, and works as expected.
>
> [1] https://lore.kernel.org/all/1f00fdc3-a3a3-464b-8565-4c1b23d34f8d@linux.alibaba.com/
>
> Changes from v3:
>  - Collect reviewed tags. Thanks.
>  - Update the commit message, per David.
>
> Changes from v2:
>  - Update the commit message and cover letter, per Lorenzo. Thanks.
>  - Simplify the logic in thp_vma_allowable_orders(), per Lorenzo and David. Thanks.
>
> Changes from v1:
>  - Update the commit message, per Zi.
>  - Add Zi's reviewed tag. Thanks.
>  - Update the shmem logic.
>
> Baolin Wang (2):
>   mm: huge_memory: disallow hugepages if the system-wide THP sysfs
>     settings are disabled
>   mm: shmem: disallow hugepages if the system-wide shmem THP sysfs
>     settings are disabled
>
>  include/linux/huge_mm.h                 | 51 ++++++++++++++++++-------
>  mm/shmem.c                              |  6 +--
>  tools/testing/selftests/mm/khugepaged.c |  8 +---
>  3 files changed, 43 insertions(+), 22 deletions(-)
>
> --
> 2.43.5
>

