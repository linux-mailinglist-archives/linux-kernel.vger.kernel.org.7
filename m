Return-Path: <linux-kernel+bounces-814752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7CCB5582A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142581C24094
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3213932F77D;
	Fri, 12 Sep 2025 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X8u++rSy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Aub2vTJf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F032ED41
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711588; cv=fail; b=QIzcHKLmJjBWG/COz/mh5UOyc7EkIp3E2zgqkdsenttd0btBM2Adg9OSTv6jCrKQ7gOyNo/eZRwG+PDD/rjnjyG/lekgHGH6DeOvNP/dA2Eq7kjy+ODbs3TOZOPjxDnddb8kn20vxGrCTHmIa7ZAxKcKE/9zD34Xp8SI8GuYX9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711588; c=relaxed/simple;
	bh=fKgid4BetwpyrUaU59Te2tCEHlebcLQGOPiBZTFm9f8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=OpPgiKjgCyDC8PBOhgz35Io1CalG8Ip3tSexEbKp7FHce3zVfkjpv92rxIZLpPoe4iFQy8E45FNf1QyS5TcPQBT0VZFN3yqntMp+vK9fOGxRfjSY4kw70VKUCEZ1ltbNVd5pqUeA2GHBXSwDQNcCYOr5OFXTgcG4Q87ggPkIMcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X8u++rSy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Aub2vTJf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLBvIK032749;
	Fri, 12 Sep 2025 21:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+/+1dHxTWdLvW8e1BX
	jlLjdWFLJ/Uv3UCjeFMna1In0=; b=X8u++rSyaXw0VNY/I0nKwyocnObs7+ujcw
	hxL5EzCFZ7cb1htHNk9xdyGuY2/mRCbGzIGrw+p+0csDwWZCVLIsH8TSmkv+A7bz
	Ek/lz5heo2b22JArkVnD/4fyP2ZWLSZPpeUtMhnFfDJx4/t0GbX+1bnqLvlK3ecB
	KrR/V9Fn7lo5MOXcB+nwBiAq/VkNRgtgmn0L1Wp/DBjxwE/R/jI5TlXtC92ejVtg
	wMfvRg1WcL/SMuDYDP/1CsS94w08jRFKcQ0aZtE2k2EsVYdy9bv+LxjjIkL5nVlq
	EHeRbW26g9X65nUPH0XHAEGlAVO8ZZB1JmFyR50hvJKr1hFoPbAA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1s3ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 21:12:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CJc7Wi013394;
	Fri, 12 Sep 2025 21:12:23 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdejm7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 21:12:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btupdeq7mk1YVN5e6UAIi/RvfWv/YOvEzSnvmr3V9pSUFQ7K1B8jooM/X/XxlFN1Z7d7BhqvrZnLrM9DaVTboIr5BdozPU0bC8dmxA2KjxFO/ZCNnIpU1PHAKseCe4xUMn328INO+BzQ5e8nidPz9om6VvVUFX2ab96O/81zwk/Va50gPuOsSi/7ZzOY4i1XZfIkGrxEo9zo8ll7sq8goyGYFjbK09oYgsrKuaxF4xpKxuZjovB78bLfvkf3YbzH4aVn1w6KT1MEgZqQyI9n5Zuus9XvFDdFIXyqciduP85Xx92N+eeGO/HBhLNPRHnaZrNjjJFgVge2ajQco5FMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/+1dHxTWdLvW8e1BXjlLjdWFLJ/Uv3UCjeFMna1In0=;
 b=qqmqoS3gHdXxNHLD/zrY0O6nIqYVII8ctCkHe8wwkqibYc5AyKiyep+cOEd0JnC40FP1odyqOsZLb4j70SAJtotF8Vjrh3BK/hPY6ReA0wmgg6Tn3UB4ydHm/cwqIcQ4e3C8tTEhRaJcUVoomUWUklltRf59J5b6er0cnc1w4MVg4XdaGp9ObZNKrRmq2wnPEPkT5fLBCqpBhzMlyzrM9c3nVZTJw54qAz8yWvLuacAY+3A0dq8lsyhFfejrA3DUPJX1k9thmhXTTMNS4178zCJKlzKUuMX7l/q4bR7Q7aZeWI4Dz+l1gEYTu/u4Sxqf0/on4siWnr+eQ09/aPUyng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/+1dHxTWdLvW8e1BXjlLjdWFLJ/Uv3UCjeFMna1In0=;
 b=Aub2vTJfuR3oWCeRZnYF7U9Wgrczk26Ml6vkKlJmGTphEzL/2x1rCp0ng65jwf5gG1n/8GG5hNOdwWsZwf0M6hxZII8iiEok+GLK4wkGUfPwIF7MZrXWrMiQfHSClVWjFg5NRcQPg+B2Dmo4Y6G5M8W4Hv2Z13ZmAlyqUQJEMFY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH3PPF539203119.namprd10.prod.outlook.com (2603:10b6:518:1::79e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 21:12:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Fri, 12 Sep 2025
 21:12:18 +0000
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
 <aMRnarU3w_XykRHG@x1>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v6 00/15] mm: folio_zero_user: clear contiguous pages
In-reply-to: <aMRnarU3w_XykRHG@x1>
Date: Fri, 12 Sep 2025 14:12:17 -0700
Message-ID: <87tt17ide6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0344.namprd04.prod.outlook.com
 (2603:10b6:303:8a::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH3PPF539203119:EE_
X-MS-Office365-Filtering-Correlation-Id: 203d543b-8ffb-4fa0-6653-08ddf2410e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S5Wetukyp6dRwEJbDXs1TMH14Ils1+Fr9tiNxgtxdg3N3wYqIBodjWeCGYtk?=
 =?us-ascii?Q?H3Yb8tyGkGMX00Q71xKpedJbFdz9m1LZPTlVBdDXNS3RUfi3CmWSijOb1Hsd?=
 =?us-ascii?Q?jcOf6YjxXqAiI5PrA6IxR6kNSitkyUzMhFv4mJmgNldg3Op/kadb6jHHaF3q?=
 =?us-ascii?Q?oayNPd8ZrFFWluUlNXgyZoLKBWM+AXMQhEudX/ndxEQ5eawmZ0agvrDs8u+F?=
 =?us-ascii?Q?Tu0LktzmVn2BIEL9zfKdxYwkWNJnEP5zzTHOjc2su3CDSdLvezmxmCBo+HeJ?=
 =?us-ascii?Q?fj0FCMKRv8NrkqweYqOtsON/owpz8ySxN3dF/gRkhyiHW9bAzbS3O4yOgX9T?=
 =?us-ascii?Q?KdGZqZm6rRcdjZ8J6Dtx2x+cFITmnpJ7KnG9NsXrjjoAa4/grK/wno9h9quR?=
 =?us-ascii?Q?/naJOXNH4a+6bUCvGRKsDJFxbqLCMgX7WyViSCBVZRuLMsZRIPyD29xuSrf4?=
 =?us-ascii?Q?15iaLyGBUg5TZfvdfnTrKMfhEO+h00aBEEzpETKonONdNEJ93cF1fRDnImWS?=
 =?us-ascii?Q?L3hbN1nr6qWRd/e+g47h1BTk9vRAcRLHvtql4gF23abYwWxfHm7RKKbpJ4bm?=
 =?us-ascii?Q?BTGQuiYykLV7evaSJJao8k3HhQUZgrsPVc9nsnCIniAi+gp7oTL8hcUDfrjK?=
 =?us-ascii?Q?s7aWc6x3TUPzh69L+AWfq0oRnRv1leHFLVWA9H/VvQ4H347HeZyAIhnILo8N?=
 =?us-ascii?Q?xhDqnH6AG+XDJzJupn1MhTmMavAWDYKLuO/GJksyHQAarxxz7XXi5pNlcs7J?=
 =?us-ascii?Q?Qcwwo1x4aYQzl1O8YKF7McZGyIWJApMeVdTsuFKMttwgYb7eDg3MkyfmZBb1?=
 =?us-ascii?Q?qSXBbqgxtSPd2/hANOeBD3NZUikgEgHwRgCWzFj6KvVANsV+n4AqoH9xgkXY?=
 =?us-ascii?Q?LFe8Tz5lcP3LnvlR57zvwlqzN8sXrDUCOH1jAj4gvnFBlCLFfXXYwWM80azg?=
 =?us-ascii?Q?rAyXj0eNJtkRI9JRYWU9os0tbuFs9nlvMRMj4MFWW6FkFpFKveVVyZynfv7Z?=
 =?us-ascii?Q?gWZJARcLrGHDJnoVhpd5m1m5bZaYyjFkFwMTuVepkos1jtrO+indBJ2WeM92?=
 =?us-ascii?Q?+gEPZLFiWtErhCcGW5T+pkwRjAdthn36mC/Pes6uQBAe5RfCsf3djr0yj/z3?=
 =?us-ascii?Q?4dLW6ADKYrcgZJILlCPmncT8Tom4fKjiWg8azOyBDJlxnIFmCXQj0NHE8qtf?=
 =?us-ascii?Q?knYl6fQcjIvXq9uLgoh/IXVQZzAa9gPOQcdYMnMVBXB9gNfef59dHwQWpMa/?=
 =?us-ascii?Q?lEUWCkq4D6Ec4Dl2qmxYyaeNWRpg8VkwDGLIGdgAAVqBKoaUC+s2YopGk4QI?=
 =?us-ascii?Q?Uu++8ZYujf0ChZzCu8u8hhUk8eznjCm+DDh+1nAgvZK6GZQQkBlc+p9igiOv?=
 =?us-ascii?Q?QeneUX3bVxjXZ/yfPWX1UkBfKmOAzrJ24NhpEbkZ3EZrtgmSbDXcgyOXCHsY?=
 =?us-ascii?Q?rJ3Etoxtxwg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6iGm4YZUq4QS4oLDYWAK+jNgvEz3j2JioaJdRFE4kOGINSviu9xFjcc6oWB?=
 =?us-ascii?Q?XQ5FSbAe6kBGEg3q/nNC6Mx7SgjzmzsxGWUBK04b9Y0evOmz8s+Q21m6OseO?=
 =?us-ascii?Q?R9tblC1UTf3MTp93IIe8ig28TIK22YU8kuPG1F+0jKQOGp3yQlyXMY7+ZRZ8?=
 =?us-ascii?Q?KBLaBY54wV32C3+I008U8ITbMbQK/gbeJ8cpCTSOu+cALcm/hj96mdVSryoB?=
 =?us-ascii?Q?YPVA1Mvi7SUlgtjM8BN4uSj0NLxs8iSU4bmQjyb2i4vWWxcV4AqtEWMIaw9R?=
 =?us-ascii?Q?9+WKdIU72ZQiY/sGx+KH9WSa83YiyQLF6rt+pvDG64CaPUnPBdKLBj51v6qb?=
 =?us-ascii?Q?IzaIVVv6duRdoAwdzaOFsF/cNewekejUlKaoh/Jnx1odLrNRPs9Jd6wwDlrr?=
 =?us-ascii?Q?it/Aofe6sqI2Xg6bkJdaHU8C0cikmNybSEkKKvhU1CDoLqFdpOP6OpJoxWaa?=
 =?us-ascii?Q?4UY1hQBQkcdUX1pxd4uwSPBtnzWG3jB0N304RRtCuWhZVptLRFlZGHd22B+D?=
 =?us-ascii?Q?/aQ11TIDPO1Sb0f3GYJjOdXO2qXnj/Vpo+aTlqkep8ejPooExwwJiudUXwr1?=
 =?us-ascii?Q?MsQOxywBcuc4Krbt1RJZdomuJkWO23zoJjt0VDgcN3nHXe4iQHeewRZynEaM?=
 =?us-ascii?Q?Ppp6RU9etPP5U5S7y7WAE3h/ttM+n1F4XwNkDEnB+cNFteU2z7lS2ANtX6ip?=
 =?us-ascii?Q?L3MYRWhldevTFvtLEdBELH6CCPP1h31kcifzFEivRvqJTbUqK+mkNh9K2fR4?=
 =?us-ascii?Q?udQueNxpL5hETLoF49+3NZTarP9rWcPOmkOqJCQOQZwDnZa4DNhr0PrOL7YF?=
 =?us-ascii?Q?b0wUYubQXY5+dp7mWIw132tLUBEMASsJPYWHZl72AufxJs651XPGz6UJnud1?=
 =?us-ascii?Q?gNyLtgVPyQJgbujDovR8zB2Qu5CY4f2dqDXVcHvi470bFhL0q2lyf4Jw2wvl?=
 =?us-ascii?Q?AGWeqpvlnM6brEUBqrJNs/0r2AeGmkhnAkMPy+GgiTVbtG9tEtW2U4mZ1K8H?=
 =?us-ascii?Q?bEGG78Z/79WdQWVNmLGORbgb530J1jTJbsnGWxPlAIh6IGRoKlTScJqHNa0+?=
 =?us-ascii?Q?8xll1Jx1S4b8dDYBs/E6bPkGfx43EnfYH4YkY9kLc+MNOqh10OjyqmQOEN2L?=
 =?us-ascii?Q?cmpULUiggGB4EVSH0PyfPpGIa2i3iXh6quzoBdDRPLnEEhC3379oLriT6F/4?=
 =?us-ascii?Q?5fWCLb9nL7JlAc3kwrVrhhl9bXotXCWPazHicIQrnk/X/ZDOcB39iUNL2h3G?=
 =?us-ascii?Q?oTYQr67NUfbT+Ev+FFhU9sqvUW/uk2MeUhtjwqa7QR3kyqE6TmQMxVc+aVia?=
 =?us-ascii?Q?Kke2WkihH03vl8Wjj0vpfjArwvqSF/vdDy9jFloNl4uRaW6C7MCnBnaFUG9j?=
 =?us-ascii?Q?IIcpVEZBcz9dvx1JRvwKKmRx5mvoJmDYWXi9+QnlS/tFttBiXm+hCF0IwQmp?=
 =?us-ascii?Q?tEutrVa3OZRxWH1QwTtCrip9k9yPuQH4kA4fhaBHTNFi1oEOv2l1A8Kzixbw?=
 =?us-ascii?Q?rif8+YauPv6IErKSGIpvJWD3U+HfsMk0caltO/1jSVk6Ute8jjCo1b9hPnCf?=
 =?us-ascii?Q?vOPVZIOSEkfJEvJJfbEAyBUpsMlfTcd4q//bjufXjjUNOnLljWLZVLc6Bd0H?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7+jpcTbJcyq3iShD+aTdroTGU2srAKpjTlpOu2m9ILyay9cY1pYpBEXi1tLX60V73Vg8FfRDbLsnSdC5JD249WJZPyh/7WkvIkq6tcM+2AW6tlXDLfmo0Qnc/YZDT6bHr9jPTemyIVx+wUea/c3szdzhtscJupwdDj+nJ8pymPmtFEOiZjlxpPlptc368R27EnJZ2zTwHN3fvxl7t34xklQlnadq8290xAfuh4IA6EpINLEXZnPdDF8x4oV+GkEOsiHYgh1wDHHkfowBLDXlUiQmwW+XojBnMe4s6pjLmOo4Zw+eGAUkEqE+JPTB7NJjZL7UhyYIVNeubR6pQytPMq2gWp4clydKmtKNkDhj7UC6+SvRdO8M2BvEsyK/0xR/N09d0MYFu6tQJgO5DtjDnORiO+7Kt1deZBMEmdKNYi8M0MgjjiKJW17X/VpRKFTFFe6/LFG6kh6Wn+V/DKGCzNlMltAEAf3dQssAIEfs7z4eXW8LJT/6gUzHAyo9/SdkzPmmYucudVRwE1Qnsi+jdNpl+iZRolARfRAq7NBxJtZ/3oGO2l8UhNkp2MqLnroeE2V2lMofTqxzIso1FM6UBwuL+3E3eKoH6AIF7m3GXF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203d543b-8ffb-4fa0-6653-08ddf2410e51
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 21:12:18.6129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzyJVc2e1md5qEpSCjkoRGAczMRNlsS3L1cxLjqVTBDzYTAyIWE2IudElALCOdb5cGgfPPR7dFTWX2a3rVHotIxC0TFdNitIxdcJTeZvuxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF539203119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120194
X-Proofpoint-ORIG-GUID: 0uAd9vIKn3FvGysLYz_sDkAj9Xn3jSSJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX9BS/oDabWz4o
 VBrFC92A4sVt9W3lYEqHBN8WJDX9iciMlNvYEH/JczY/cZMiOgaOqyzlVVoziwByIUURvRYytLT
 LBJDj5WKtZCjYJvgQ4fZ7SBrLSaz9Hp4xldS+XVTydqvkbEWfbIyZhGKkQEGxlXHYdMWYat1trf
 b2QwjP+Eadgd/Xb5ZBmz5wDEkruVSN1cp54BNyawOwG8S9N5F44QkZhjy4flv9zAXMHGD0SeHYK
 vTOA+rbD4040Ybxub7fpRuMTQFBDpj1rcYKF2D07107B7zdX2GpV198Ep64bUEWBCezVbfRW7Zc
 z6svccn4WgF6bqj9Tw7HtPQTQsbbksEQmei/nOsUlUs7jjcEhMtFxHIfWLwgPEwEcRykuju34QG
 dRt6BCp+
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c48cb8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=RAQp6ecQrlmDnSzifY4A:9
X-Proofpoint-GUID: 0uAd9vIKn3FvGysLYz_sDkAj9Xn3jSSJ


Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> On Tue, Sep 02, 2025 at 01:08:01AM -0700, Ankur Arora wrote:
>> This series adds clearing of contiguous page ranges for hugepages,
>> improving on the current page-at-a-time approach in two ways:
>>
>>  - amortizes the per-page setup cost over a larger extent
>>
>>  - when using string instructions, exposes the real region size
>>    to the processor.
>>
>> A processor could use a knowledge of the extent to optimize the
>> clearing.  AMD Zen uarchs, as an example, elide allocation of
>> cachelines for regions larger than L3-size.
>>
>> Demand faulting a 64GB region shows performance improvements:
>>
>>  $ perf bench mem map -p $pg-sz -f demand -s 64GB -l 5
>
> So, can I go ahead and pull the tools/perf/ bits into perf-tools-next,
> Namhyung already reviewed it, the rest can go thru the relevant
> channels, ok?

Sounds great. I think I have Namhyung's R-by on all but patches 6 and 9.

Thanks!

--
ankur

