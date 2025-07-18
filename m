Return-Path: <linux-kernel+bounces-737024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0C7B0A6B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6F13B4257
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F6292B4F;
	Fri, 18 Jul 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pya7Rg22";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rXaUFG+s"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93C1ACEDD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850715; cv=fail; b=jb9EoNpHkapYHm5pqJu7YoDgHSnfnhImKqsyLAlyJ2DxL0vm7xuZG3X2JWq38W8/N6nd+fKQKOPRmXPYDMjX21e5JkY6nM4zKmOb6OY/8U03rQb9PPK3FhFXfPKZrP0yL6xsjWDZA5tLmMUkxKlt0Ykh/YQ0d8tgKR7EXOQoeyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850715; c=relaxed/simple;
	bh=OgMTaQiH4CLq+NNIOzeECHIZIJm1eXYlGVspofz+CLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bsC8pj/hi9i4+PNE0yX621NHQUX3I9marPgw6L+3sCUxcFzDYnduOSgQsE9cBDW1hMsECNZjWkmacp/HxF5een4LL/Pyr3+GcMiY9f8jaLNKU1Je2N/RsRXZgV407qAg4Sh2ijWmdQPhsYF7bo/X4s1Ny3RHxhzLrwN9mwcJGc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pya7Rg22; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rXaUFG+s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8fv7p011298;
	Fri, 18 Jul 2025 14:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TKC1R+yEZOYUP/5JzM
	UYat+HRvpskTiAfZqe+T2dGm8=; b=pya7Rg22z3sII0YTizmLsVIwB6qawUhApf
	MINwjDbqjCmNx2/rafudl1uxCtcorlribbUXp6YERA6ByOAHJ0MEUC2/PrExJ7Oc
	IRVFG+Rt2MWvkxvvOs0yH1oRaBSK0afACgZ/tdevCNzu81uJ9di1uWaMUD3u2chA
	3QZq2NWrA0nbUu4a5ki4dN3DBFsJMuwi4OqtV+Bx/wqgBxt7W3xt5rfxyHetlcH4
	jjfKOy2nA3i09fvSrew9e9SfVcmjcQPYj0jrvsz1mhqtTicXdh0iZLpL30fLa/Wf
	X4cvXlfQN6VNnNfKpSTqwPsOesWsDzeXfRmZgC9YtPYBGBMSwIlA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk674xkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 14:58:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IEjBGd012987;
	Fri, 18 Jul 2025 14:58:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dpsd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 14:58:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVTbSEVHqdkM5BgSq5EbkFV2xsWcp17YJ8D0ZCz3HtFSXAxVki09+wUTHtJFfbfz1l9OMrtvTaaWYMNrX/cko/eXWSfTbRRwoRKTslROSFqK9BgXuDT05bW3WnhbaAHQbXIr5FnT3xN4PI1Xmz4IJvg1HLHdYtIXjvQB3b6hADujfPBc7aUIc6p4W4SDv6nh8BxPm8LedGX4U+Wvb99ODrpJ3wuSBCt5LIKLrGOSdL2zGqECLwIZk9VYGtGazmQsWQ1zefJ6Fh1iYJpyOLj3IYCHjtco3B0vGJuZAtCM14C770xNzMV40c8qJoaqWxYvQq+rZUtGTDPd+fYKcRdPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKC1R+yEZOYUP/5JzMUYat+HRvpskTiAfZqe+T2dGm8=;
 b=tqXcrCxYgJcWzX+AIYJgSwGyDcTbX5xCTi8juRN+9VNcVRgZseL+hgUfuncwIDpDO/cbKnoVea1GZort20YrWcrpOolK2mq6t74leDIXMPFmPfJcwoPiNPIV4GV3K6tI10KV5LoRG7nLvcZGqo2fpbG36yK1naLV8FHmiF0kzCTsjCQ0eZH3zZNCqDxkIeDjr7K/figVENUIe+F7x3BhIjEqKKa5cwYhpXIZ5AjSHga8KnQVmQmEhf4WtktVffoA1p1o4CwjWlo/X/AqY6gO8Pnyp3GWSTZVuijPKMeMkuhif2mdAVIXNF7Rz6+8M1ZQR9sBqvSJiy3C80vAtdt6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKC1R+yEZOYUP/5JzMUYat+HRvpskTiAfZqe+T2dGm8=;
 b=rXaUFG+smAPTnqJet/2cqHcjdKE0NW76dQsbWCCrdxAfKmxZGGQ2tHTfrOHUvFxqlnt6zr4lYqyiyPZU2DrfkxIaRRnlKquTv0gcHOb/AJOSQe7pOUxKYzNkoBUK11xctfRmKLF+LnJbD9XWdzhh9jUP20aWoi0aMNFE/k6Tj9M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6291.namprd10.prod.outlook.com (2603:10b6:510:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 18 Jul
 2025 14:58:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 14:58:04 +0000
Date: Fri, 18 Jul 2025 15:58:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Antonio Quartulli <antonio@mandelbit.com>,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Balbir Singh <balbirs@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] mm/huge_memory: remove after_split label in
 __split_unmapped_folio().
Message-ID: <ebcaf316-4fb5-4d7c-adb2-81edb429ef8e@lucifer.local>
References: <20250718023000.4044406-1-ziy@nvidia.com>
 <20250718023000.4044406-3-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718023000.4044406-3-ziy@nvidia.com>
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 20af3e6d-bd50-43a3-4104-08ddc60b7f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1AeW+DMlYfl7R9wq6//agzG3S1ydA+k2yFaCu0QSJ5dxceO6A4Ea98Nkj7zp?=
 =?us-ascii?Q?re9Ceophsf++bewrek97SeqBZBHjO4H+nF3B8RENFo+o4sqOAo687185/2o+?=
 =?us-ascii?Q?3KnjtzXdGWX5Z3YAStl2PYM6eE6dPyIKDeSUuOAo60LU8cpra6hPbs4pannW?=
 =?us-ascii?Q?m5SNYyma+Boa3HlcLPEZLTl8u+kd8VGc4zIqRGK/QXowI9q+2OnBKcyvhnuT?=
 =?us-ascii?Q?tQRG0zBsPx0tSLSjhAjQMXFiqmJR7DswWhYYv4U/Tec+4gEBMD8UShYyiLEc?=
 =?us-ascii?Q?k67s1wfKU1BL9i+3jzAxqTmP8RJlay+2hEaEe3cPt7huxeG6S2MQ0P5tfFo6?=
 =?us-ascii?Q?X5C2Cv87K0b7AhUsorTinwYPjBEE0XiWWx48Wgd1iX56nHzm6siiX8uvF3UN?=
 =?us-ascii?Q?Xj++6WtEgdTFswLcnb/7xH9wut51oyRoJBFLgZZ1SeqYm6Gw9Nxh2sILlVFe?=
 =?us-ascii?Q?aL4oueA7nQ7vjif/1W1p/YUZmam2VpAx6MUD0vRXzK43Rk0W0wgBljGOk6Zn?=
 =?us-ascii?Q?zaav6Ho9WWVI6gKgz5owSHoAW3SccoN3YUlFCDCMwKRuJaZmtSKxm2DGZdtn?=
 =?us-ascii?Q?JF0vnod2JlzwsoinaBlojlA7anRmGzuJDoP5FmSlDZDbGA+PjH/E4DiNa+Ua?=
 =?us-ascii?Q?eAt1NqPf4FKBxxzBE1+pCErEgVZIHaVmyZU7FPBzOE0UemEdlCP5UDH2i72K?=
 =?us-ascii?Q?mf1+pTvZXitR0OPp+caEnQA5QUdy64Jr7YFZ436af8VZaywvRqalSGPVveQi?=
 =?us-ascii?Q?BauWIlQ5H8hyjxEZSpC8P/pIVf4qdbCpo2n0gTLCw+GTBooLowGArjvElFSG?=
 =?us-ascii?Q?adMyaQzDLidm3kp62EqISaIujy8auSeFignYVgFA+oeY5FfOus6jNv1rQMht?=
 =?us-ascii?Q?l9JW3CFC3h2ybdzOC1PbPPXKTDWELXp/9dyMILk9Rg/ug3Hr3nd4s3QVehoL?=
 =?us-ascii?Q?S5hqPZhMwpSX8bk8ydCIl1nv9tBYas4dr3loSl1WJFQRe3MUau/YfwwfAgSr?=
 =?us-ascii?Q?DNGrcLreYliJOi03XS5Eix0J8cnIcgz5F+biPmEgmJMFw/tuPEMLmUhHEOwO?=
 =?us-ascii?Q?r2dgw8NsAvdkO2uqRkrMXxLKxDB8+8K2y52gU997iDV2LF+fCw23w/O2eRdw?=
 =?us-ascii?Q?/o1qCKqMquSQi/9pbh9qnXeBViWwCYX6udkIuRlEtLbXqRDqmlpyAcUW0Gzn?=
 =?us-ascii?Q?PJze5SfgS+U+tuIDiARaKVXCGuPUuGOIGHJp/inRW7FtqqnWOfV5tOw3nv0W?=
 =?us-ascii?Q?jGsCKTZKDyA13fZO86DiBy8WPpdbP6P9N9N64VV+bGRDkK88at3F1j1k/3JA?=
 =?us-ascii?Q?QuPBizMC39KuXzQvxvTP4l6+lDIP2h1eKdIyMMxmxm0MosbKPMs1EXCfQ7X3?=
 =?us-ascii?Q?mL26+V3MUQlovJETcnicXMgSbvQTaUs1SSwxiSI8pLF5GMx7o57l1x+7k59K?=
 =?us-ascii?Q?OZ6TKiO+zDc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rsVfGu0jkAlsqEeyhYAvSboRfoeE0bjYNUUY5B1/oTZ5et5hnAJ8YbtWYkCj?=
 =?us-ascii?Q?PY4VIgA+W2pUMXpExnQyfxOcA2mRnu1omoQfBd8vEid1g6Fk9bPY5xbDZXOm?=
 =?us-ascii?Q?d7Ph4POtMFhVZIxxu062uYyBMvpyt7tG+WR0qAPpRzhsatwHH18UJ3/TCwKM?=
 =?us-ascii?Q?5F5yoLW+hminZwut3TwUQ8M/erDycsrUyhyih2ev0ik3lViRrR25tflGWnVI?=
 =?us-ascii?Q?lvR16r5WcPQHfbfDkS6yraJ7A48eZF5qTKT/7/ZtkmY0/6b1VKXw2bsyP4wr?=
 =?us-ascii?Q?RN2p8nJ2bBcLPTYdrvYg3w6+jA4tHa/6u+Oh/CNwWCFQhAW+kI4YoJC2wL2y?=
 =?us-ascii?Q?FaSNd3w96A7+k20TCDSUDbBCiwJhWSfuZF19pJEXET10u5TZbrxHWKWhvyf9?=
 =?us-ascii?Q?+m+XLwfLnu1ORH/piWCbHCc6vcdF8JUkJiYMISpVVBtvxm1WY5141en8FzA8?=
 =?us-ascii?Q?+Ri3oq4UejP2tUPFPmnCk21IfN1XF9wkIRnBwDqxaIQ2gsfeI60ahNIAQ3v4?=
 =?us-ascii?Q?i2x7aLhlTxvNzWLLBZCBupYf9+4OphammAVP5mfWS3jCrMXUxoite7p6NkR4?=
 =?us-ascii?Q?pJj9jFCUqzd7lY0ZPdIYA7x6pnNHCak8JhuGU1L4rXAF6AJxR4n5jaY3HC2F?=
 =?us-ascii?Q?sBpoySe1IULg0OyS2I37THMN6ru9dqvSkgOBOM4O9qMudw4tbK1G/SrGwQkj?=
 =?us-ascii?Q?qg8KMoMWiZE1hl9t8J4Zap33vPGHyeVnwLjNLJMIf43ieDWHGZHZfvhFxr0v?=
 =?us-ascii?Q?kLgJuBVczGSk15IbLsu4I7BYNNYA+5dLDIGmMWFZSnyqbhMw9LbMuzGMp42R?=
 =?us-ascii?Q?Ti5DiZaffnScvc83nXFGi/i0YXXFuMszrcv/saxDqDPWxRSE56mpmyXrEX6Y?=
 =?us-ascii?Q?+LODySJLV1av4wzSydodx7Enbg0YX/mWukvKjrsU2x2EU0w8gaLM53j92GYn?=
 =?us-ascii?Q?JRoeXChl62MxPfyxZULhQ34dvOAJAu6unHtdCQOkbJ/6bZLfPzuQXeGOdc3M?=
 =?us-ascii?Q?Lm5VZM/tq82Jk7566d2GE8Djo7d7I4AZdFencDU44yF+IGqhe3NXb5E45tor?=
 =?us-ascii?Q?pC8fNzSbqBQRdpEWZ+J3fqGZe141dNjkN6/0B/TmNCRIKAie3BsllMfWaYrS?=
 =?us-ascii?Q?aMgcpArMze1Xqrpi07qPZ5cI1yr0Q+Cher/df3uM/CVX8E/zBO/1Y6JRRogW?=
 =?us-ascii?Q?fN1SQukIaQPPdUSGFnBXYBmB+FOGar3h7uY5YontP4+rziVWjluAr0nQEORY?=
 =?us-ascii?Q?02HhmqF0LUAswlhu+zI0TKMY2hiVNyiokPhHLVaDzXa7ZcUkbANjTIXGYPSD?=
 =?us-ascii?Q?Qkjfk9HBCSN3ozMhX7fJv9/QSHiTR3QvdTeeON+Rgw3pPOyiAr758mebJoM8?=
 =?us-ascii?Q?Y0Ec3B0qsTChoCMeF6XEZto277/+cFN9roflPClc1Z+RBry6iDGUBP0Q4NDB?=
 =?us-ascii?Q?idrY+E5AE0X9QZFoR3w7sAMAyHnrkbiFCStRERo5B4/jWCWX8yW46F8gPxNw?=
 =?us-ascii?Q?+IdPwe5mkpAu/Q8ll+iATjtCQsXqVlojnUhuNcQ5uBOtwaZ5I2vx3diS2I+9?=
 =?us-ascii?Q?g9tgIfXDIc3tre91vNq3AhyHTY2rHas8vHEFYgWkOfc0PSwxj3e3zC0TPRi1?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r/1p4npyKMmCG0KXbV8KVRLFiymhd7yR5S7m0Y+FQdfBbbJWl1cCoWimcffLDhpBOClsVhVWPDINB9Sm0/2/Owl7ybYeaCAomb47suoXkcV38jWyhcS79MNXCL3HG1ANeqkRAFKA1nalClnbtsd9lvpIAnnZ7ga5TMdOG51bpzbd9kgFdnxCHp3g23YjBaLziYQYrqYum2NMDKsQz81OfbTd0nb9SLV/3e/fnjk9HVRVQFRQebvDjPd0xBL9l9+Q5rQ7QUg6G8T1epmWSurR8US/60rongCQmmyGJDHdX+hmvVzBMqWUNHLbm+K5nbCa5kLZG7atFRl1jDwzM24K/xQA8TOWgFmFfyzRZnp044A1RHBXfjTJ71c7YuQR5Huj0yGBY3pvjdNrTm9ZZRiXMF3CrvhGA40mCMEGoL/1X5kB9UeTsKWqTiVhc4k3unHYQBHJI85F3B8Q207vm/8/6SmCpJC6Wh0IcHnaT0HewWRHpcj1Z+rtj2C6SKC4W4gSfAsYhPZg6qjw+qZzA/Xf96oljdFVtOTSfxbPnR195t94VeVI7de4QgLELoIBIDrLyZ1I5QGTkKfJy5tRvizTwohisu2qW0PEPr28gREYPHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20af3e6d-bd50-43a3-4104-08ddc60b7f9a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:58:04.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cs+eBYKUnaiG7Ingpc7DktT7Go80VJlna8+riQLunxknOfVLokDsoePqZxHh0W33zpYheE5fxp0dNgEIGFBr9LjF+8VWn+aKub6O0Vhf+Gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180114
X-Proofpoint-ORIG-GUID: dFMYGemctW9bhSsQlseNxlHTj5sy0Wfi
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=687a6101 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=BcCAeLx_hEWpryQ6Kh0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDExNSBTYWx0ZWRfXwK52iHwL6H4L Gr552+dKiRJmDRBE9BOgQNxtA0uEVx9HJNsYa/wrb1qz5c1TgK2Yl8lw7g7aRmCNbScqcMGZBAo vNWTgtH/YiNtZ+16glOU7rSdYUViU9S4lUrbKir2KE5lGe+rySEDsRUwWRn4yTQUYP0C8WIW7FT
 f8kGZy4FLbbp97JVTPGfbKGT9Lfq40mK2BG2R+ovf6m3Qq2kowxFfKUmchenPic+1BVOfsMzyfw JdKGPaKb2/Hyrc/A+mGnJSeMr59izpGh3o/v34SHfJ2tqZjbKS+BXEbmiOzO/hHAotB+JGR7SY7 t34QHvYi5HzQLDZxkSZgWUKOBsQdpO4BEk4bnMgsdc44p/0E+bH1+7Day+LXpB+iblWt6v5EFCq
 0VJw/nRQKaBFZ9KDfOrOd58nj+VnggV6ja2dcWOVzz6Yi7FNBIMHOw5CtsUfeDxg3HNOWRVy
X-Proofpoint-GUID: dFMYGemctW9bhSsQlseNxlHTj5sy0Wfi

On Thu, Jul 17, 2025 at 10:29:56PM -0400, Zi Yan wrote:
> Checking stop_split instead to avoid the goto statement.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com

Thanks, nice + clear!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63eebca07628..e01359008b13 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3463,18 +3463,18 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  				if (xas_error(xas)) {
>  					ret = xas_error(xas);
>  					stop_split = true;
> -					goto after_split;
>  				}
>  			}
>  		}
>
> -		folio_split_memcg_refs(folio, old_order, split_order);
> -		split_page_owner(&folio->page, old_order, split_order);
> -		pgalloc_tag_split(folio, old_order, split_order);
> +		if (!stop_split) {
> +			folio_split_memcg_refs(folio, old_order, split_order);
> +			split_page_owner(&folio->page, old_order, split_order);
> +			pgalloc_tag_split(folio, old_order, split_order);
>
> -		__split_folio_to_order(folio, old_order, split_order);
> +			__split_folio_to_order(folio, old_order, split_order);
> +		}
>
> -after_split:
>  		/*
>  		 * Iterate through after-split folios and update folio stats.
>  		 * But in buddy allocator like split, the folio
> --
> 2.47.2
>

