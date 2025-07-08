Return-Path: <linux-kernel+bounces-721562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0235AFCAE0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC173BEF69
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D7E2DC34C;
	Tue,  8 Jul 2025 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b/gxEcTq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qZNOe492"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8517A2E0;
	Tue,  8 Jul 2025 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979023; cv=fail; b=L4SOaa4K6chpbGtzdw1LnJH29FUfosqW3Kxl5icLKo0o5oSq5pUnKFINJYkA7vaR0whf6H7m1ppcoNDh/Mf5+f/gIIEk0XHWfDwMED6b03RTT7oqz72eNidObfcQ5Pu2zXW1gExvPWoCqT10+Inb9LRHGtU+O3CQ95CCHq4UjWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979023; c=relaxed/simple;
	bh=Z7ggCaR4jMQs5t99kxMvjqcBgLWUNzzj34ZzCTyrYZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YfnVQsETGWHJelH28Pz+5Ne77AOIo14zkYzSbzyHDHw13wUDkqHfQu4D1749tl2JFuJrwU+piIV5XDytw2rzFkCy6ZG5yxdsF4DTc1bd9RwfRNqfF30rViEVSJvtjFO2oetjIrNkxbTKBVkgmCviQnM12xbt23+kIoMAMSau2yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b/gxEcTq; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qZNOe492 reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Bq2gt032686;
	Tue, 8 Jul 2025 12:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Lk0yOwR9VG3dcbA2WRu5r/r9xubo29fHnnejHPKScZE=; b=
	b/gxEcTqUBxFV1btRvbsTz1PletGU/qnvBkfL7IbBU5tqwBlj207+YJp9lmpUAIP
	x+Dz2UaUqf00z3XfphMpPTGHponqHsnsn1oxTaEvEJmvGEgw74dxC9nsNmAHJF8Z
	Hlg73DVqbD9qC9CUCF3NRlcj+U0Pjq1KwyoZVSa/XucPMV++2LFHHOzpUzQFQ5YW
	FpLxkqAZpHRovyPQnImSD1nXkVxc7uGgrGDjbYGt1JEOndBdAZvk7VEU1cmCMlsc
	Fu3TWnQXTdiNJ5rLkawsDBVpx8/EG1TWpATtj4c6XAI59dAtbnzL+mfCP8bFJJmB
	NOjxQ+M6+QIFl7IZIcdBzg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s2tw84hw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 12:50:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568B0KnC014170;
	Tue, 8 Jul 2025 12:36:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9jg9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 12:36:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFoiU0yxVhOqrEdh1xyYfJ4iilZd7N0d8DFHkLr9UeSq7cNi2/6hnK+BNKxXVElih5iHIvPNlTSHtoZfOPoTW0uzkPYcwOw1FTNgDX1XmJvDx2QlhVElziPME632yMbbAKC8mb3aOj3Ux613OjXLVXIbX0GLSI4SbZLUDb+Hk2pTj0cNmFKhbNl0P60BWhOu+u9k9s80hfaIxImvNYjbM3aSN3g+kEC7/0gYWUdLv9cYpf7UaNoPo29+T6XqMF43qbfVDM++DNh6P1MbEzWAP1oJZQK99evvLuIsL1q0P6yGy7lwm2jhcxz5czl0R1OsMjNeqaTmm2T/2EMN/NlQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kveNQx5Y6PO8O8Tfx5F4BR8Anp/VlNhyNNxzRwsPvR4=;
 b=zRMfNgXgzEDSWry3YmalqJLNh0gkWGz6Sk5boRsBzG4pZrk3hRkyjWBduUmkwFOPHdY4hL9wr6cvYr8Ap6XR005r38FOnbN3stFrx4QdNY0yaMFK3GIjLTVIw3y8ioJJQ7QGIBSKsjFIScptPmM/6/g7700VA117OxOu2Xos/HWYmgS9/0UcFuuqWhA47/qlXPNlu82HRZfL4syppVzkDB3cqWgxVYGYPCbRtVxDE4FyF6eXo60kpw/f3Et7M1VjFC3+lrFTF+QgrSdSA3RYg3GTbooe89C1KrVOKQjV0sw0rYiQ7eKFiomdlQPq13WPRxdBf6G5XcK3TtDGVIv0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kveNQx5Y6PO8O8Tfx5F4BR8Anp/VlNhyNNxzRwsPvR4=;
 b=qZNOe492aGNA8OANUJzYoeIlL7ZY7cQHvcs7+aoMKuwojaXG5269baXNnPskTwVHkEbzqsGeA71RfOmdJZLjnJsXN8ydqBAuRnXx5YAOi8jwTvG2ZPFeZ+1L02+K7ohCaDUGUaP1oQBA1i3/H0gGgofA/BUXJoJAiIOXoWxcDD4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8114.namprd10.prod.outlook.com (2603:10b6:208:513::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 12:36:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:36:07 +0000
Date: Tue, 8 Jul 2025 13:36:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Message-ID: <8a08931c-ce54-4e96-9e99-e7c696389dc3@lucifer.local>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
 <aG0HJte0Xw55z_y4@pollux>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG0HJte0Xw55z_y4@pollux>
X-ClientProxiedBy: LO4P123CA0491.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: d9eaf7ca-adc1-44b7-70e5-08ddbe1c02de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?RIT9vuAyPNY7OqQslDPjxnKpiyJ8Ffg7e4c0Dfzi4l8cN+0c2lD7OclcXd?=
 =?iso-8859-1?Q?sxFoi2N3NvSmpCRzE8l0VNrrrWYRiWJCqCmW9TTgn704bFMBSp+XE6kA/q?=
 =?iso-8859-1?Q?vBib8/J7wOty1YFxZyLsQn+TVPxeVd14w/IroccdA4IzPshFK8ehn/w9bo?=
 =?iso-8859-1?Q?mqjfxoXMD/1onDJXa6ANKUAaNA984IhTeAqKDJqp3RzXYyybPkZEDu0el0?=
 =?iso-8859-1?Q?30rFj5Nro9Hwbr1KgzksuLmqL8c+dpULpUJdgt7K+2Jdjp5CipNuaAoREb?=
 =?iso-8859-1?Q?mufTmNvZIad8+Ynrl0IiBtgD0I/gUp4WAhLU+TZgKkmZnqZiZQlSidQY+F?=
 =?iso-8859-1?Q?d7oILM85ZDMiIB5gGO5Qe0tT3hzVwaJKlUOpxHNvKpObb/7pL93M1s03+G?=
 =?iso-8859-1?Q?XjUW4j9Ckr/0GKxpw4QBbpw4YDknM9hn3k4gp8pwlV0MRIFqTUdlPEIdkA?=
 =?iso-8859-1?Q?pb7Q6PaUjHGQsRCk5LAq4ru5Nz0rnpLrSHiU807Sy8rFXDDqYfOcyxQjk2?=
 =?iso-8859-1?Q?TN67EVIpOQ0q6pEwLVQjEFF/yBXWedTC10AeOeWE3ONjka0dV0VecMUScX?=
 =?iso-8859-1?Q?JCPxJJCGj6If+cMw5DXqfeun/+BwEg0K7FX7Xq0faE7nG82kRt9kzTg3xN?=
 =?iso-8859-1?Q?MRB8ZsOyXq+Yx8vYlK3P+HZXaWhVDfefqLSnuq4gRfouEArNmqB87z6qxj?=
 =?iso-8859-1?Q?0gX5ws+SVuOqLSHZcxD3J2xJyG9o3hFwINL0iibT3c4QcE6vTvo3uSST43?=
 =?iso-8859-1?Q?aVZ3dUQGNH7pTj8Mw4odKfqjAeGyTcgyjkrMnUmiXBWpd4ssOn3ry+DHkw?=
 =?iso-8859-1?Q?fk/0h1GzYxjQF4zWBghonZSBYNu79n7Pc1QDMbzXM8R8qkjSblvsz2OW7b?=
 =?iso-8859-1?Q?2zAg8gUP8n076OKcNnAh8o8Bwq3U5eE//uyerEgTMtRpwcwhMFgtjugamd?=
 =?iso-8859-1?Q?G8ZU1Euvuf92LIxYcHCadiftbezc0JI04a/pMTgF2uB7Rf6ohL8MLoprtb?=
 =?iso-8859-1?Q?uVliPlNcgI7ekPWntLFrrgdP6IjRabHR1pY232wA6jLz+cGtfY9DEu1FAk?=
 =?iso-8859-1?Q?71waX/p0rkosnWj7lBTHzSLMabyLz1pDhkO7Q7tYHCYzs0dL07OOLAsU/L?=
 =?iso-8859-1?Q?Y8LZdyZleEiiyvv9oH/CKo7z4uBLdy9PCx8r/sRZNZRPjS0dFS6Xqe4/Xl?=
 =?iso-8859-1?Q?BRBEYC7z5pCLioRKlroOK4DewESG6CzCsT2KCpZl8nMMOMNfx2sFBCtFSL?=
 =?iso-8859-1?Q?Sf3p4NXWCXvJEPcLWSCd21i5o7HHhywbal6YWnzVJr+MeSvJy7HO+jC/EB?=
 =?iso-8859-1?Q?aSMRUKBpquBr0LaH9wsHSouX1Rhz7STDMxUE6bu4lY0OnBNYZn/XWKLDqr?=
 =?iso-8859-1?Q?Oem2/xfyQwSuEeLF31jhVG/rxwMWZBU8k96EcRc5TnDuGDNnl3suzq01XI?=
 =?iso-8859-1?Q?Yf/njrHorPrw5UEbeHdsM2rgxJbWkoLwNsXfKXl407IwXdkH+280iTCfGX?=
 =?iso-8859-1?Q?0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?VAF5tn/bh49uLMAOGREcDtmYmUuVOdVWmWjomM7XFHF21trAJLExvpRnm8?=
 =?iso-8859-1?Q?GkNXwddq9KKL5+2sIIWxsUx7mhKbsH9cmBnEwz+EM7Y0xMWsCR1Pf3yT4k?=
 =?iso-8859-1?Q?d4A+noRtk1E2zP5dToaOhu/Jj7h3UVyTeD7mF/nnC4Abqh4a/aKKxhbQtI?=
 =?iso-8859-1?Q?1uT/RhHLXZK3sIalFv2nuDQgjhF5GpQer9t4H0cN+7VT3JlVva+OqgX6NF?=
 =?iso-8859-1?Q?PbSK2F3JXLTz5EtZsVYpPaut462NI8mO9aIafI3FfvHc4IbChAuk6QCEiG?=
 =?iso-8859-1?Q?QBJAwpVZK5dx5D3XC0iVhuzaB9c1UuAXEWZ/zjDyoYLiMwcMeWYN4KhX7l?=
 =?iso-8859-1?Q?xzlzUSBUk2Yzz9Akpgtglgis3XMP4RirLbFU8ItSOxjJf1eTiLtB03wlAh?=
 =?iso-8859-1?Q?L9vYwLqwuPIP/CiuXz5/zplypwLJoJGSTC3J80TSPt2oXP4y3ifjpeuw1Q?=
 =?iso-8859-1?Q?Qz1ioXGNGK8E7kjN+wSZYyoAo7jUPbpBpqmZocYHX4p/ciytlzItMD2x4H?=
 =?iso-8859-1?Q?e69rsHY6IcgN8yIHJ7qw9Oj9e3EOtTFvGgWx0KtdxKqmZzg+6kiFS3TqYQ?=
 =?iso-8859-1?Q?RDA2kF3CHDsyF0l2wIyGTKjCwnlzlEEbXV0EOtYoqPlnQFnqtJ3lWNuyM9?=
 =?iso-8859-1?Q?sD4qkLpuamk9HFnvkhgRkVygxdHLBBAkmJxdnpwsWuOxOxIeCO6P7C76hp?=
 =?iso-8859-1?Q?/4/kfqrnYOGKxTmh9CJpPIVdKD8tNLna/GLqyLWt+xwV8jF/JOrsAbLCWg?=
 =?iso-8859-1?Q?rOzsGGGyUSmV+s5gLDUJer5fsOT6H5iPauX8m3eJ3kBumrv31VkxsnCJme?=
 =?iso-8859-1?Q?+uS4Q6TZwFdFBXD2aYgHGvWGYNMPTJdfJJDGTMyFbcH+xE5s04tv+xtEQ3?=
 =?iso-8859-1?Q?dU7kv441aSfhpLFAm53R36wbjhXEniliIkJJpeKyv0qP11DuB+rvsGIYvP?=
 =?iso-8859-1?Q?WT7bI64nFutgVOGPatwNNtTr17nKr14Fw3mN2lp0vlA2oEpP7PCJL549nr?=
 =?iso-8859-1?Q?ncGq3UZ17GUnTF3SX8HohHOfCWFQCZoWiBk//w48DUQ4As1m0Jz/gbIR7Z?=
 =?iso-8859-1?Q?xPhjFu+xYU8+3XpAoDmzNMcIryP0cPdIAdAsDiYrsm0/bYnJvH8wieNkR7?=
 =?iso-8859-1?Q?WpplwANZsVwoE7zCtGlrJEzY8KG1QLa70QZQ0OFXjLps/MTivmfG2B6mrg?=
 =?iso-8859-1?Q?zp4I8iVejRS1sBiRSCy2VFq83B53PO+si8FrfRYvWaq5UBhf+iwStgDpHe?=
 =?iso-8859-1?Q?R+GUT89E4slvZ6DZe8Y4dxu9DeFn0czKK3+vDESJ3OlE+TBI5ZIAS8P/cg?=
 =?iso-8859-1?Q?Eh2zD38or09zHviFZjKfMNWQKjDT5EDDrIrwWK3g029LwGLKndtHrQC3sf?=
 =?iso-8859-1?Q?qKJjbpK0TYB5gziXElQf86j4hUMJO0myNzt5EnaVAqVudVnvNCOQyDn32d?=
 =?iso-8859-1?Q?FFt92gX7qeQzTSmODTr+NUIFuiRMz8FIpL5S1tDEa4scjHvfNXIuQ+3l3t?=
 =?iso-8859-1?Q?T9wEuJIh3lw0hiwxoTgjV1zJmCgqGZNNw1QuHKtsLE+P+E9dC9dglguJTR?=
 =?iso-8859-1?Q?qC+OTwbkc0idxHhv2nY7SUSDSOdtS9SobgAdjtfU25G9zcZ23FNsi6tJEV?=
 =?iso-8859-1?Q?tJejAlFpVb+qKBA2ukx16d8WeaWK0Owa6bQLmitzGHWXk430yFwYK9rw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GYBXSgh8Iv6S5zOlaq151olVSgQBf5U20KdDb/Lh3bKyV7l86iws+m4y7BeKxt0tL2rI+CESKzfrsmIYgvy+xT4cI9ABa5Vj7LHYI62ex96c3Y6ThDc+WoSziHpNjO1EU4/8RER5FneEhilTWKdtoH9jcImHURRHefM4KOfwMmrZk4p5rYikif5PrAp3hlnGn1y6JKuZa1TZfFvWbYYy6H5+KU1+/Rha+C7K609liB4GRkrxNUSrVJm6eI0dNN2AE/7JkX4woG/dMnLjC8d/Ly+Vcs7pr3F3cKZhiQxD8ZMO9bkGZaMZSbiUjLv6w0XHJXORBPV13a0JnsJM7n+s92WuJMFh10WdPHN267Rx7nnbUZB3JVw8TWPUD91vaKfm343U/sSaFqg3urPKzuyJQmTtRb8b4dbEtyUk1BB7dm9X3b+nk2OPQJm0Ps6hUiImtd/4//xN+gVrK9fjG/hHQ5a3ajvwnZh1432n1Ppkc0N7nemiZa7f5+GMjmEADABvJDMHvMgwiGBlatkBaAwCq5fRAVGVhjaQrwjf4lgKs2cBbId/CmapDN/ruk3Lh8e/tw3Lem6t460AtQ2Stnff2rzJyLns5Xe/mc2OOOwQxUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9eaf7ca-adc1-44b7-70e5-08ddbe1c02de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:36:07.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrLukD437fu4x4kLnWfJVM8JfnJTUgVulwtyd3/RsSRyUTnLTiEzVDsaEYqRYWSGXa1JZUawIAsw2t8nQ2Ss6rojuxP0RNI8z1Gn027ZboM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080104
X-Authority-Analysis: v=2.4 cv=BuGdwZX5 c=1 sm=1 tr=0 ts=686d13fc b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8 a=_2yia0w1AAAA:8 a=sfOm8-O8AAAA:8 a=1XWaLZrsAAAA:8 a=31EDEB-C88dqbkG5hGAA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=4yAS8WwzZ1jAEY03B-5r:22 a=TvTJqdcANYtsRzA46cdi:22 cc=ntf awl=host:12058
X-Proofpoint-GUID: ci6cCgIPRSBSrE0xpzy_5pMDFy6SEFnn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwNiBTYWx0ZWRfX4nwJXML2yOLK Q4rPT0viiSpOhBtbO7FtZJ7w5qa3qhpRlOxZPq15B6Eec1uMTb3Q75XNSIFGEDBWYsTWRW/+KS7 0H+n1wgZNmstscVWcPF0O8V+iISkH0yRnty9FMdNLtP0+4xXiYq8ZoJU3RAkiCqAhe1zsA+6Wfq
 bvLgYeXwrg+TsD/R6hIYssMkmlxyTgvaeabDKHVJKHPz8IADHXpjC+4RwjZw+5rViQPhrkTe+GX Dg9rD3NFVXASJVJK4GuIz8XbGaGg85sktI24CcQfiPmAYcx9YJRDMubvaDMtUBt3Q3ZR1hfAgI7 CC9LCtYVbjOxrwP8XW8QYdQjpGNdy59BdH/ofCJ7Xv6LdrWGcuRxfV4KjyOazHGFpo7Xa++7a/I
 phHwV0wr5jnkF1WqvnAqKa6aUaLPGwjfVVt3NnCJKp10z8CS1sk2v2y/JoP+781GiDdDFg9i
X-Proofpoint-ORIG-GUID: ci6cCgIPRSBSrE0xpzy_5pMDFy6SEFnn

TL;DR - the real issue here is not cc'ing the right people (Vlastimil was
not cc'd until v11 for instance). Beyond that there's some process things
to think about re: rust/mm section.

On Tue, Jul 08, 2025 at 01:55:18PM +0200, Danilo Krummrich wrote:
> On Tue, Jul 08, 2025 at 11:58:06AM +0100, Lorenzo Stoakes wrote:
> > +cc Liam
> >
> > Hi guys,
> >
> > We have a section in MAINTAINERS for mm rust (MEMORY MANAGEMENT - RUST), so
> > it's slightly concerning to find a series (at v11!) like this that changes
> > mm-related stuff and it involves files not listed there and nobody bothered
> > to cc- the people listed there.
>
> What files are you referring to? Are you referring to:
>
> 	rust/kernel/alloc.rs
> 	rust/kernel/alloc/*

 include/linux/slab.h           | 40 ++++++++++++++-------
 include/linux/vmalloc.h        | 12 +++++--
 mm/nommu.c                     |  3 +-
 mm/slub.c                      | 64 +++++++++++++++++++++++-----------
 mm/vmalloc.c                   | 28 ++++++++++++---
this ---> rust/helpers/slab.c            | 10 +++---
this ---> rust/helpers/vmalloc.c         |  5 +--
 rust/kernel/alloc.rs           | 52 ++++++++++++++++++++++++---
 rust/kernel/alloc/allocator.rs | 46 ++++++++++++------------
 rust/kernel/alloc/kbox.rs      |  4 +--
 rust/kernel/alloc/kvec.rs      | 11 ++++--
 11 files changed, 194 insertions(+), 81 deletions(-)

These are clearly specifically related to mm no?

Apologies with comment re rust/kernel/mm/... I was misreading the changes here
(lack of diffstat unhelpful).

>
> If so, they're indeed not under the "MEMORY MANAGEMENT - RUST" entry, which
> so far seems correct.

I think the sticking point here is that these helpers are considered
trivial wrappers around mm bits. More below.

>
> Please also note that we had "RUST [ALLOC]" before "MEMORY MANAGEMENT - RUST"
> did exist.

I'm talking about the mm-specific bits. See above.

>
> > I can fully understand there being some process fail here meaning you
> > missed it - fine if so - but let's fix it please moving forwards.
>
> I agree that this series should have a couple more people in Cc.

There were 17 people missing. So more than a couple.

Until v11 the slab maintainer wasn't even cc'd for changes to slab :)

v10 at https://lore.kernel.org/linux-mm/20250702160758.3609992-1-vitaly.wool@konsulko.se/

This definitely isn't ok.

>
> Given the existing entries in the MAINTAINERS file the Rust parts seems to be
> correct though.

scripts/get_maintainers.pl says:

Alex Gaynor <alex.gaynor@gmail.com> (maintainer:RUST)
Boqun Feng <boqun.feng@gmail.com> (reviewer:RUST)
Gary Guo <gary@garyguo.net> (reviewer:RUST,commit_signer:3/5=60%,authored:1/5=20%,removed_lines:1/9=11%,commit_signer:1/3=33%)
"Björn Roy Baron" <bjorn3_gh@protonmail.com> (reviewer:RUST)
Benno Lossin <lossin@kernel.org> (reviewer:RUST,commit_signer:2/5=40%)
Andreas Hindborg <a.hindborg@kernel.org> (reviewer:RUST,authored:1/5=20%,added_lines:10/26=38%)
Alice Ryhl <aliceryhl@google.com> (reviewer:RUST,commit_signer:2/5=40%,commit_signer:1/3=33%)
Trevor Gross <tmgross@umich.edu> (reviewer:RUST)
Danilo Krummrich <dakr@kernel.org> (reviewer:RUST,authored:1/5=20%,added_lines:6/26=23%,commit_signer:1/3=33%,authored:1/3=33%,added_lines:9/14=64%)

Most of whom aren't cc'd.

This is based on mm-new's MAINTAINERS though so it may not be up-to-date.

>
> > It's really important to me that the rust efforts in mm are collaborative -
> > I really believe in your mission (well - for me it's about the compiler
> > _helping_ me not shooting me in the foot :) - and have put substantial
> > effort in assisting initial work there. So let's make sure we're
> > collaborative in both directions please.
>
> AFAICT, those efforts are collaborative.
>
> Back then I sent patches to introduce vrealloc() and improve and align
> kvrealloc() and krealloc() [1]; it was also mentioned that this was, besides the
> other advantages, prerequisite work for the Rust allocator patch series [2].
>
> The subsequent Rust allocator patch series [2] was also sent to Andrew and the
> -mm mailing list; the previous code replaced by this series was maintained under
> the "RUST" entry in the maintainers file.
>
> With the introduction of the new Rust allocator code I took over maintainership.
>
> So, Andrew is aware of the Rust allocator tree, please see also [3].

I mean there's process issues here too I think. I think ideally best to cc mm
rust people too, sending to linux-mm is usually not enough, since we are all so
busy it's hard to keep up.

I'm making real efforts to improve this by adding explicit MAINTAINERS entries
for things as best I can so everyone's life is easier - and absolutely this is a
bit in flux atm - so forgivable to not be aware/miss entries that were only
added recently.

Anyway, that series appears to me to be more so _internal_.

The important stuff to have mm input on are things that _interface_ with
mm. Even trivial wrappers should be at least tracked so people can at least be
aware of things that might change.

And absolutely I couldn't agree more with this going through the mm tree to be
sync'd up with the mm changes - there was broad agreement on this at LSF/MM.

>
> [1] https://lore.kernel.org/all/20240722163111.4766-1-dakr@kernel.org/
> [2] https://lore.kernel.org/all/20241004154149.93856-1-dakr@kernel.org/
> [3] https://lore.kernel.org/all/20250625143450.2afc473fc0e7124a5108c187@linux-foundation.org/
>
> > We have rust/kernel/mm/ under MEMORY MANAGEMENT - RUST too, I'm not au fait
> > with your approach to structuring in these folders but seems to me these
> > helpers should be there? I may be unaware of some rust aspect of this
> > however.
>
> The Rust allocator module is a user of exactly three functions of mm, i.e.
> krealloc(), vrealloc(), kvrealloc(), with a thin abstraction layer for those
> three allocator backends. Everything else is rather Rust core infrastructure
> than mm infrastructure.

I would argue that making use of mm interfaces would make it important to cc
relevant maintainers.

>
> > Can we please add these files to this section and in future cc people
> > listed there? We're here to help!
>
> What's your proposal regarding maintainership? Are you asking me to drop it to
> "MEMORY MANAGEMENT - RUST"?

I'm not making any suggestions re: maintainership, I'm suggesting mm-related
rust files should belong in the mm rust section and that people who've
volunteered to review mm-related rust code should be cc'd on series relating to
rust + mm.

>
> > A side-note I wonder if we also need to put specific files also in relevant
> > mm sections? E.g. the slab helper should also be put under the slab section
> > perhaps?
>
> Yes, we could. But in the end all Rust helper functions are transparent
> wrappers, simply forwarding a function call *without* any additional logic.
> They don't really require maintainence effort, and, in the end, are just
> trivial boilerplate.

It'd be good to keep track of files like this and to know who to cc when
you change them.

