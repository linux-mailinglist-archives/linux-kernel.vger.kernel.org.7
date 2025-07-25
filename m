Return-Path: <linux-kernel+bounces-745606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B0B11C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEDA5A5DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5F92D6405;
	Fri, 25 Jul 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WF//5+gv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G9zF3dvJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F92D63F6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438660; cv=fail; b=nN1dzq2X2sLBB+ulV6W+kqQaqFRrKISzpyE1KINzU1BoVwblMwTROE1stgvjVY+NpoRlO68aZ04T/ZGTGnpAKWvRNa4VNZ6yQYLGY05J6tZbvPfPS63LuMO4czj+Sgfxf/xJ5fdh8It/ivgPmhr/icJ9N/JdpdtkNG/yF9/XNF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438660; c=relaxed/simple;
	bh=ZUCemMbAGhiS1fhrTg5iwKUboUTTwwU4fofF0YdWpzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uJ1sFuOsMSiQg3TZLAPGAUJwZgsmyR46PQOFmRUc/0AWPG2430+vIU1nPb3uF4PS+mgMkixJK0ezm6pVkKxNGn/xtN+Q/Xsp+bJmME0fYWJ4x6QQP6W8cVsMOnaggiK8aNr1l30uLZkrkj0x1VB5ynD13amZ6BXplGM5wwsSgDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WF//5+gv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G9zF3dvJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P7gktd006834;
	Fri, 25 Jul 2025 10:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZUCemMbAGhiS1fhrTg
	5iwKUboUTTwwU4fofF0YdWpzc=; b=WF//5+gvlFVdj0eIJZGURzkY384+/EvX8s
	A7FKIlaMTZTX8Im+juV0rV83gLtsMvpE5z5lny6OV6Xil6R1kF2kPXkjvAXGRHjy
	ezQRVzQmpRhDx17iSRPYnFsuqHVS+vkZRnGBhwxkuBBd/mT9UymjEbZHGVprFJ4s
	ORZeYFNwfo/gUdFRCMu59dYMZIKmVIvq4e/flhKe0zv/BSUcFdxoOZ5UYVHXMtDE
	Vr27BCu3X7vKIde2+2YbQ62ThftMzLlcezcZDhUDqL35mRpSHQuckZfCzO+hhoJM
	+HuvjkosyIumvfY2+/4nahXThXvr4EQ7Ts1XyfRbUuCXtWQrOWqA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1n0rc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 10:17:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9fXVn037682;
	Fri, 25 Jul 2025 10:17:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tcy39e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 10:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pl189zPoM801YHX9HNUeF28U7eHcyAQSymYjpkqbErd4u6Je+ZqPdntIuyA4IrTOa7hyQnUxg9qQtOxsXULPggRRzVdFQpjF+EJ8IFLyJVLiJp3VoDpf9Ipn6WWdZkJLUS9yTjvNM0yc9/D1LjM+GdBir/dPqG7X9w6ELvx0OFQd2IiqZLWInwSNQqNO8OmVvvSryguG8T7o6ck7YFqH10MJdRpe8teE4peJwgBvxVL2ODINAaDTphoqO5HoV2y6toTL74fWkMS5VdiyUVYCVFqx8RqLCuR7WEmF6cCkYhmpFLfFH6R5TixcVQbi6X+htL08f0GpVTMn9JVv43btGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUCemMbAGhiS1fhrTg5iwKUboUTTwwU4fofF0YdWpzc=;
 b=MEERjjH8CQlPSWzpNkLV7kqDtuz+X9mJM4tewCLpuZlUyyqKEFCTMcRYcomSs9lwczhf0sxMGPFRr89O9pxAqoLYd+tiOjmylwFbEAPT5XEdUG4zhNN5yZ313H/lX7lE9cMr48/fPoQbg4yYNNeVnZssK62iTQctDSYtVvSVZzLggAYefmnumwylP0IThaSpmbzrzmfvLhxFcnEBggSpnHj+hBelffZYwr+xLEglRXowBGYRyIvV93ND0gtzXwSx+r7p+lk4WrhC7aoPX+hZP160ELXXmRFgclxBgUMQCw/M/ik8j5Mma15ujPHSGr/bKj2Wl9A8hlgJvlT7hvXj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUCemMbAGhiS1fhrTg5iwKUboUTTwwU4fofF0YdWpzc=;
 b=G9zF3dvJ7nlEMit/wKPXp/1lwOAKUtGwm8QXUPN4fMU19sOjHIYVf0PihqNKtRpmL724X7VdeKv0VDqYnvIYAsZHuk9GMNyVI40ATe3Qy8fnnW3tu2YtafqoSTO5t6Nbeohcz2qVsk1vuRoaEKCYW+2o36o5L6lWbJwAuQTHWD8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8018.namprd10.prod.outlook.com (2603:10b6:208:50b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 10:17:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 10:17:25 +0000
Date: Fri, 25 Jul 2025 11:17:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
Message-ID: <3a18d1f9-1ec4-41a8-ac39-53e9a275cdd6@lucifer.local>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <4f66d89a-631a-43eb-b4f9-c9a0b44caaae@redhat.com>
 <692f9624-e440-4cf2-8202-861c679ddb73@lucifer.local>
 <0ad414a1-9a57-4050-a7b6-fdea08aebbd1@redhat.com>
 <507a09cf-291c-4886-92e7-9d9cc294a247@lucifer.local>
 <aa839e3a-11f3-49e1-8c3b-a60106c8d165@redhat.com>
 <d055173e-233c-4513-ab40-d7a10a0b81c9@lucifer.local>
 <649565be-eab2-4783-9595-b4263ac50310@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <649565be-eab2-4783-9595-b4263ac50310@redhat.com>
X-ClientProxiedBy: LO6P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: ce245d3c-d4c6-4d97-2af3-08ddcb647303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PzNvt3XpQACgcL4msbl1Us0eMKs/wH7GDXkraf52wxvv6mInJPXnkKIHvBi5?=
 =?us-ascii?Q?nHxy461h/p0OPHf0/Wvg68SOsWVzTLHyyz8o9f/XlX9ASqwzuVwH44SpxXRp?=
 =?us-ascii?Q?KaWKdCOm1w6pTJK3w3MSm/DRISL/m48NnLAq8i0+Lm/Y6Uy6+NEuJl7Ysf62?=
 =?us-ascii?Q?oFmEP7cdtO6uxhcc/Lfwly8PpBs5f+tPNtRmM40IfzVIlbHkXDUgSSgBFyRQ?=
 =?us-ascii?Q?C4tk4xXyza7jE+8m+XUenWXRDbKErU/6XCIlr5WDqpCT6GcLdZtoobABWbOT?=
 =?us-ascii?Q?psk6ImWfnY9eA1i5C/6C6geOdzxjSaGn/ylosMvCY4x2mW2Bq+YftEPbdmen?=
 =?us-ascii?Q?TU1xvvmnP7glel6UuWooqISIyH7dznEea+DKL9Shr9OAEgBkhVtAzLI5Jqib?=
 =?us-ascii?Q?JEVAjsCmHP1OfUQdyGBZjAsDpKHObLCBX+E6aK7to4KR4Y2/Xz51bZIMCg5u?=
 =?us-ascii?Q?Zfk+DZQxEKvI9yLzdVXBfCjz3KJ/GaVRKg5T8FSVGKNeWmLdPxbZqSVT4xQr?=
 =?us-ascii?Q?5O/smZ7N/yNZ9l7555xCqCzbfpPUIWJA6n6uG7QmLilwwol1816nSlbA/O0l?=
 =?us-ascii?Q?Er7bJZn2oeEvufuuFVOHyfobpGwYBogKZm4FdmJfAMMY6l94p3Y8WFB9J3Rz?=
 =?us-ascii?Q?ArTanp/lHp2wk5Ceoqj/OdpT4Z2QOGJQXUsumGP63gnbK98854oDVl+u5o/C?=
 =?us-ascii?Q?bcmeAMcfx0vXgEfFk/nNh+LUslEm7S3oonYbURjAwxT+dzB+zRIwf8aButgL?=
 =?us-ascii?Q?NYEB9dnlZ8xw6tYkMyUWwePY5Z5b2bL5nUC5PQXmlwhwZ3afHWCEwL2Ih/bM?=
 =?us-ascii?Q?I38PIT7Oc8jdCUH7uKKOqQYQn9sm/kCispDYQFw7R/3P0g/pDl8H/E8wc7Wu?=
 =?us-ascii?Q?S47gpHDZPTicnjv4Ui83WXda30ymVseWXXsTs6LcRVgul+fkMf8+xSNOaL8L?=
 =?us-ascii?Q?NuYlUuqzdlOVHCjcv/t4uBddESz2qiw8MOC9feM8gVwB50doNlPhj7szvvVf?=
 =?us-ascii?Q?2KszFkFRIb5C/LgPgzTUhVdQyzhWXsYqDNVbZ+46vCwiRoJGyKTHC6uMyi8U?=
 =?us-ascii?Q?fOk3SKonAT2JIv7uyMqJNmE0z71Lx/v8yARn1Y4v4qmf+R5wykdgkT16uTW8?=
 =?us-ascii?Q?GRUH1UO+p1wqU46qlTw9JFYsBVn49b0R2jrjstUl4KRJh3DwEnYHuJkzhQ8B?=
 =?us-ascii?Q?O9mqURjS0BOx2umWXmJ6FtCbhQARv3e09qS55hPw6xlrywt74TgHG1ZX080C?=
 =?us-ascii?Q?xAY52zDoDkhYhCujw+Pte6lhncYZrp+jSYSXwp5IXcL6XB5rmU6RmBt7rvJo?=
 =?us-ascii?Q?zwMUXFXZABm1D64C9ZB1zX1LRScRhd2oDVnC4mik3kd7ulGcJW/eB2BQbu4j?=
 =?us-ascii?Q?LiobZczjrPoUjjvaUO5iYY5h7Ppi+duHlk5ZZyh3T5UaBaZ8XHqKJd4iZdUX?=
 =?us-ascii?Q?m1JOtmgvIUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FNP1oU1SPfFd7DzrRF0haLSOHih+03W5PJJ6y1bOZyUVARYa4JBmmotBlg2g?=
 =?us-ascii?Q?dXS26+TwKi82Fom3gcybrPb048Vb46dcsjm0SkrF+Q2cUV8ZA11zUQDMCvYE?=
 =?us-ascii?Q?Ds3GSyWjjHBGyA7aA04V8IusPgDI3qDRVlC5OudM/1SSnAjTidHmok7t61cx?=
 =?us-ascii?Q?LLGbamqffx9G/fOWK9QcjlaNDLzb1ipLi1gyVvhfckqPSaJ77+PWuRJnp6jj?=
 =?us-ascii?Q?HsaLmgUkrYbU0SjFRYi0nLdn+VHtiZ7bhdEGTVNK/8UpEJrIx7EzZWKGYORL?=
 =?us-ascii?Q?WweO2cPUq6oHXgloq550bfQytBId6ll69WjpRwz1VP9KscXrdfQza+Zaq9fv?=
 =?us-ascii?Q?QQeDVWxfy0vNytm+mgU7aG2KjhEH6YMHsVmbJ+8ZBR0YktaHH8JjmuAlfixO?=
 =?us-ascii?Q?xPZE3mKxM4NwGtx06s1qSTcfiesGDFz8TsGMgbsFEL+D6bdTmjfcRjWKsOX8?=
 =?us-ascii?Q?mdVfLcBnmg/p6Hdtz7V40vTsXM1pfWgsPNTVIWQr/OwdzwPumIP0JmuIrTvk?=
 =?us-ascii?Q?cGM1IeK5iRw5Cu+RWNCSURLinvexS6t+xPa6XdNfL+cXhHcVraBDTiSqD7BZ?=
 =?us-ascii?Q?IOjiHwVzLnIZxcFQTNGXI8rHqG2KFwIqEmiuRCAqzG7syGrDakZ6njXajUEl?=
 =?us-ascii?Q?c4uHhs2AZXTXY/Y9phvv1YMhlfJN0QHTW3UuYgbl+Vvt5PKan08T55TWKKvg?=
 =?us-ascii?Q?hTFaeFylsnR3XzwN9AnAOapWYnIIW0aS1IdnKplIR0gakK6fnrZ8c/kszQNd?=
 =?us-ascii?Q?bGlvFJQQiCYVCkiGLu//Nc5a1dHkn/7RqOFSvPvQwbZc3QwMbflLyI/6lFyk?=
 =?us-ascii?Q?2oKBgnJHTGYmZKrrYzpaqpA7q40xPlbmi+/LTSu8tsu8a+32ykCKWx5mwQY1?=
 =?us-ascii?Q?wJG7VnsCGMt8+Z6S7W6zO82Di4xpmAiXSI6MsxmrLTlxl9ckO2cEVmxhxttd?=
 =?us-ascii?Q?D14bAsxXFa96f5RkzyPTwj1bvrZxPQhl8aF9ujuRkaRHkjyqLnV7o7mXTDJx?=
 =?us-ascii?Q?nquLO+dhJc3BySk0MNUYXCStYQjIxd2uq+6epawD0KYtU8bYsWkB4rZgRj/I?=
 =?us-ascii?Q?PciFSH/J/7Dt9wAilRP7LeynfEAiVw4XysnMd6Wg72IioOsrUHMtpYnscNNM?=
 =?us-ascii?Q?CSoAkytvq4I6qWRLmhjZiMvlQR3I6zpYWiyel1/SZoQ6zMV+TXm1kXMkotfy?=
 =?us-ascii?Q?N7LvK/Bh+D9mnGtoTtCX49m3wXh8JgSTbKt8a4hFqzi7m+UDWuX78JQa0/mH?=
 =?us-ascii?Q?xV6HPiri5D1gkbDUXLSZF6YpOoJZbMx2G9aFwHDO5CT68L+zOAS5FLNt2ZJf?=
 =?us-ascii?Q?JFk9AtkPZW5lqJusC/bkzU43LqV5wUKzmlNKllocDev348fLFEfzf9QtOvYN?=
 =?us-ascii?Q?nex7Dn2XH22URfymEtSID7AYlnMSayDvwbjNVUXCn4HpugcDgLokrS+skbIX?=
 =?us-ascii?Q?/Vw7ooLQLhOOtP3NxOP/yW4uTcFU+kFzo178ok1ra1sjH2q7/VSr/OQJCZM7?=
 =?us-ascii?Q?BSTa/ssUbxu2ZnEylv5CB+2nxWD9YUCxciXVwXZds/uVK+RhY755NreTzaA3?=
 =?us-ascii?Q?JR2DubZi7c9/JuuZ+ITKtGpR0JqS0AzVA10WD+6s0aA61SJG3BWon3tXhKL5?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8hEo4s/vOtFWSBEHQTADoH+kSgoaVr7OwFuB5ILksr2jlvj+WNMngy0Gd8iGdhqNaFcN0KmPxTF6wlt5ALxQL1lExPDZmwiK3AA69UvbFhc5a0uqL8uWsE0QKBaZfqtcULEox3Va6DkgQBe//Hrka+JgX9TAeC4Q8/EPCOLx6b8hhtbFhStgGN7+kdy7pslZ1VFJmcxpTB/Uesij0aphVGjxI2emJ9DOct5l1OzvK4axU4c66m5jju+38dB3OoDjH4FtjlEA9foIo1b12RRCIMTWmel+EGXSpY0rHkdqP4juJGxkzt3g+TCW2tIiUhsh2FYm5YBBZtqfVAgSWQjQB5LQr8iK//1Oi+TMljObykrSWC+dwirbO6j7zacniid9RQj8MKySN+ktBfJTAiSbp+jeZqoqGWNVnX/FkdyRpMBoJ/AuMywUA+erU5epVCtJ6TN8rriDlE41iv1JWJM0gq8xGRV/bmJKImFii0Gkaqs+Weizwrjg2I/ZbNEMOcekSRCNLkjCItAJ9KYy0riKR2xGQAZK/sF1J/SmDOjOxAwTZ+8VdCqUAsjBTDy2Vqxv2bOu+YE/fp8twJSD1RRtyuH+0UBQPmZSSqFlKTdZTkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce245d3c-d4c6-4d97-2af3-08ddcb647303
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 10:17:24.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6P3/tSkfq61ozzpT33FkHOE5SG6xxeFZIVDVCnp8dsQgXWSKLVZnn+NSc2JHNwlytzOCv00S3sFDGzxoMg7t5RmhMLJjNtOwk82yAAZI1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250087
X-Authority-Analysis: v=2.4 cv=ObmYDgTY c=1 sm=1 tr=0 ts=688359b7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=GqLArsuH38viTByJHOIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-GUID: d9otFnxFHbT_x9NSUFBZ-yRvWJew-cgP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NiBTYWx0ZWRfXyrs/TVyivuTC
 KoC7MwBk7KvT3lOyJnFT0/sS+srlzw6Sg30rf5vq+eKsW5J2XCj3xncxpMdNkwmdQfOC71hJxK9
 37ciFa8ovN3ERZjEoyGHC+O5U0/VXAbjB142kW+8BF6Pp35Pl/8piowJSSd2DV7wws3jArc3SLF
 zhI/FhMmrq5F4AfYBddw7PwHeZ13lZgM36lETI/bLH1pJemH7c3Jt5sAwh1o7x5+r+uniFMM7i6
 oD39ImcNfo8n8QTLnpBuVHw5C01ZeO7zijpBtdcLCzFyEidk543ourqtduC5tE6LHCVVCl+57w6
 xfIhHmwcjjma1CDA9nuRdrCV9ruDJSfwLUTBu+U5elGfVhQodygLuloluQPyYG0HqweZe5fMJdi
 uvS4ZdExz4m/WgJ/WJRWohPRh2Xtcr7gYrRmy7FU32wVflb7jbpARPGu9C1C8U9a3ohK0m4c
X-Proofpoint-ORIG-GUID: d9otFnxFHbT_x9NSUFBZ-yRvWJew-cgP

On Fri, Jul 25, 2025 at 12:10:07PM +0200, David Hildenbrand wrote:
> > > > So - we explicitly disallow FOLL_FORCE write override for CoW file-backed
> > > > mappings.
> > > >
> > > > Obviously if FOLL_FORCE is not set, then we're ALSO not allowed to get past a
> > > > FOLL_WRITE and !VM_WRITE situation.
> > > >
> > > > >
> > > > > >
> > > > > > Hmm maybe I'll soften on this anon_vma idea then. Maybe it is a 'cheap fix' to
> > > > > > rule out the _usual_ cases.
> > > > >
> > > > > Yeah, something to evaluate.
> > > >
> > > > I'm thinking more and more we're probably actually safe with !vma->anon_vma ||
> > > > !(vma->vm_flags & VM_MAYWRITE).
> > >
> > > I think there are possible races, the question is how much you care about
> > > them.
> >
> > Yes I was just wrong. Please just disregard.
> >
> > I mean racing with MADV_POPULATE_WRITE seems a niche thing to worry about, and
> > so what if you did, it's writing a... copy of the underlying file-backed folios
> > no?
>
> MADV_POPULATE_WRITE does not apply. It's only racing with FOLL_FORCE, like
> debugger access.

Yeah right, that too. OK so we might have some breakpoint or changed some data,
then discard, I don't think this is _too_ problematic right? The debugger is
naturally racey anyway.

I think we can accept these.

>
> Again, a race one probably shouldn't worry about in the context of mseal.

Yeah agreed, so I think this is still sensible.

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

