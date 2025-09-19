Return-Path: <linux-kernel+bounces-824728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E90B8A004
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DAF162A45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269FC313D67;
	Fri, 19 Sep 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gRwohQOz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f7pU8h19"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84332313D65
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292523; cv=fail; b=dC/X7kMYs+7yk/Xu1z5emeadoQRRpo50IvS4gSfNY7fNO2F32UJWRqZxMNX80oFNSQdDoBDUw2vh1+6ADyXlZhEu/6T8GcOiBViPdTROpPCgZW9qJhj0xVRznMBq8DPyC3ooAD+XI7TfwRbCR1coC3Va32h9h1gpZb5UVp2mcNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292523; c=relaxed/simple;
	bh=W+MlKWUza4ElOLL9TgJPJqRC9oQSMA51R/Rnp36yP3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LxwzhxQrMQgGlYSPnrVKoIzN2s8Jy8YBpvVdYL+Sb8jRFc+jNsFVVtb+LSA3jSuywf1lSyYp2Fs79lZY+wf5eX+7vtGpTP0KGDmGYx6lX4LZYkP0RB9KD6v+g47pLfXEg9u4jCGGoqDx9POSWRehmq9SsXi1n/jNYKxtibAf1P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gRwohQOz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f7pU8h19; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDuSmv018787;
	Fri, 19 Sep 2025 14:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=b4yDCuMYIitax9e6W5
	FNLHNJesAJH4QZKZ7ke8BD4fw=; b=gRwohQOzzeAu78BX0CMod01XlgKq7hssBo
	wN3c/ZR4tMswVvWAaZsaDFhiiWCHdbRJtFCMnM339WMPWO6mgKydAqxkZ95C1Gga
	V51iG8EYkngsBpdVB686LfHNqyljuVngNhiI5O3+asq5Nimv5kSElrSNSSJf6AFX
	+ooGyv3+9w11egC8Mv1ERWwIUeT/63pnQILlSajFUfNjt4huw5jU3kItXmtI8sZk
	rO13rmyyLQhfnO9yWqAqNSDZYkvCzl7LtOeWdUxS+hft51DgZDrzd0sjhzV75Mzb
	qmHbxOZhsT0fW8MXo07V2EKM0pX0tPxXvnCXa48IwniX/qIVe1GQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9wr9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 14:34:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JENRcx036883;
	Fri, 19 Sep 2025 14:34:46 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2gk6wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 14:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDP9iVe0qbRy4f6kLcOIW4eXLdIQqOjyhs6gpK2W2zmqIg8An6pxIFpMikMBUYlPlVfOPtyGmtqYtMg1a3zn7LjVHMtB6UymZltgtyjH4P3ycPUa5G5xikLxx6Prbca8bUcoBraiAAEu+x7ajWUdk2IPnP7sbgJZ/W5OdbmdFNK0DTfbmSqGM1xc/waImwY+jC+6wR8u4eQhLDd+Eg67HHDznFw8Khyo03BPf48H5msIeafyVTPWRyUJe94MW2PRj1Ru8skeG9gH+e3B8B2EOtam7S28Q5S7IgmMNNLg69sm5UY9gwWjpvIyz7HD8cYlTl22TUUrySgLslYq2lbQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4yDCuMYIitax9e6W5FNLHNJesAJH4QZKZ7ke8BD4fw=;
 b=vodOY2cNsjvIBVdWcShY4YgYc2MFunkIoIxk7ZMEzivk4LAOzWoxmH61qeyhH0iygY+nc0CqUvSy/3WVTlfrc+gxVPVLQON/HYtg2mzjZhssLhG8DpODVDW5kmq7ELrGumvkPT3SHynjbDxM37cQf9Z3E3b7+SiN/0YGDuNkbdSOcRCcF/sS0KftCuPzAn47T0gcSIxdIgc6iUGiazAFia5WRmJZAYBeNexJvydl0FkAPMwJjT22QYOwfwwmcPdqCaoK4NESMO1jDjcAUQeTwbYByGyFBS0bd5jUPQJG7O747qdOIuheVI3Gy2LAu+nkOAitPkFuXbJIp9t8UBMy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4yDCuMYIitax9e6W5FNLHNJesAJH4QZKZ7ke8BD4fw=;
 b=f7pU8h19hYk4D51aw/yLLSLJ204OZ12phDagVF3Mt0lwsmN6j6/qeL7Khwwq3Qr5JLBlNjiXVPogR/ywNBE/iTcDQqQCETTQQyW7aLaNR7HLU0GtowvFRVaE6odpKcO/RjckpSYJGB7cHOAXYmCJDIotayY3bJD1uOM3fhhsZX8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7003.namprd10.prod.outlook.com (2603:10b6:806:34d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 14:34:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 14:34:41 +0000
Date: Fri, 19 Sep 2025 15:34:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Nikita Kalyazin <kalyazin@amazon.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <33dc85e3-f3ac-4179-bf1d-821135fe3c42@lucifer.local>
References: <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
 <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
 <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com>
 <aMxNgyVRuiFq2Sms@x1.local>
 <cigo2r2x22bk7wzr6qvazcdkmt5kfqhbgb7nslpuff7djufucg@f6xucfuntz3q>
 <aMx0oGwRpSTcfdnf@x1.local>
 <swfs7qpgrezamnijhheiggwdfklfqdc6ahp5g7nvprr64m7wz5@msf2mqajzbuz>
 <aM1l2YMmvBgiXJ8a@x1.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM1l2YMmvBgiXJ8a@x1.local>
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: cafad5c7-e6cd-4d4c-296e-08ddf789ab6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?us+rmjEQFEKBzf0o8QiTmN9s0WNHS+z4tiDloDFMerGtXGr5iaZ71ZK+tv0a?=
 =?us-ascii?Q?Ks+OxoP4rFx0iC69prg6UvsXGWtH6aHvgxWNS/gBoMA+7tmWsPxbHcq4++Tg?=
 =?us-ascii?Q?oFvLxrHqt7HH0OLUHXrRM4oJFTjIkDaPyETywNgyEz89fPewka9lLw9BBGEJ?=
 =?us-ascii?Q?jyLYoDAPNJtjF/IO8SkgpPC/wbLVDhM1en/4UJW1e7OsRg5GTFEitLuh5M3k?=
 =?us-ascii?Q?qgdNBL+lpVAENeTGc5DknkpvCWUNBNa3rBglrrEZgVS6tpcFHA0DfKkpvkv9?=
 =?us-ascii?Q?22b4pb1DRbhbS88v6N5hIc4ocZronu2dbkEiQZwDfztLkdCF9HcmFc961bDQ?=
 =?us-ascii?Q?2lxymxDjQYXL/xtzFi8cTVPtyBEaZTBoFJhbFpYfbNShF2jp7YRIu8JYMHpB?=
 =?us-ascii?Q?tXKZ3GDPOlzxSX4PAU1meczYKgdm8jBafQtCLLScEeYhN/LnkFsUaDdjkIll?=
 =?us-ascii?Q?aELvRnpitQSMHj4CjxMJvjzAP/T4g6eXzz/ZXqYp/ZtX5yI/C6UBTI423X8v?=
 =?us-ascii?Q?40+DWuqez5OiXY0S0fHfIEVMUa9cuC9eU5mTzFR9IksSwJ+5D/tWrd/QBAc8?=
 =?us-ascii?Q?NaP4eaGeWx+gZIaUDuV633ZRgFd8PgwMfPYvwU68OTJ5YwUr8YqaaGxrrh8S?=
 =?us-ascii?Q?Cxq7gliA/cf8GjEntnhEQhnHEpFKPnvZeK/Mhp8PwYcGFU9mRZVJuS1Y6zf/?=
 =?us-ascii?Q?rvU79aY+t+qHGbmmyw7F7Ya4wD+16vSUKGwUJWMgACyiDfsGXPC/zZpx7G3d?=
 =?us-ascii?Q?WfaoFFxSoZPAhLOxSxcQ+//Ueqfsqg9aNS+tTI5cxnmmWm1ZwRvhn26WuX32?=
 =?us-ascii?Q?On+la1/Sp4r3hfaR4Amm34r15L8XS3WyQa+VwqbE+XvRY7WW0RHiaUunT4vX?=
 =?us-ascii?Q?/Qbz3a/Z05TuvqdME9uUImOKcOCu0fgooDRgKVdJNwweRKZ28lQ5ElZ/G7Kp?=
 =?us-ascii?Q?A7zJrDOWVtyP+IQBIKoe31ts3SyvHSyXXhM62o9O8pwYwWfTjjGOgAJ5dZgl?=
 =?us-ascii?Q?jj5v0pqeuMbkm+YUOew154+/hbxQWOy5ROonQEKd2Mq+bC9LsR0Bj+5wYHVp?=
 =?us-ascii?Q?A4hPL4iywr+fdOY2dm8q8Yn+O7HY0wkqo5NrtWZb+Ui3xxOvfqsHPvBJAoYM?=
 =?us-ascii?Q?B6mqNQYmOlCu7DKpO6Zook7NhtJ6wvc8IM4p/Y4hxsv+izeES2+CquOzrUnr?=
 =?us-ascii?Q?xcK3zts6AIw2Bu+/EhBWS/7EUkPGv4U0ZT/vQ5F70geICJA5Qo35Odq44+zg?=
 =?us-ascii?Q?WLtcONrlqUDQdJZP9/VK1VXptuYohgPaozBef1oe1NSxDuHZ8AI1GdOXv5xY?=
 =?us-ascii?Q?yhei1PxA3Z5PnCWwQh6STmEMTHuyPl2tQz+gNCTDmiO46JLyFmLxK7jc3ofQ?=
 =?us-ascii?Q?nbdcHJm/rsNNFG5/FLpQv6VSzAsb9bx39KQnaXZHaSENfpxWwdXW1M1V1p1n?=
 =?us-ascii?Q?CXcxknoy/vQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ct8o/LpbreNaPqThTKhy4RRNzePtifb31V3zBFS5tCNGSONeAzI5wk8lWb+5?=
 =?us-ascii?Q?zGMoGyKMWLEuALI+2W52/IgzJqypztNfcuR570onqg1kq7cPgYkrykkW0voo?=
 =?us-ascii?Q?3rm8wxV8f649IdvTiVof//g+8ruH11t8h2SF9w6lM1taLU+3a5qM9mfbVfUG?=
 =?us-ascii?Q?5nSEmg4lSmyaONpSkv4e1ejQBYBKB4oAwdeYs5FJmG3+eqA2981H0f6vPwT8?=
 =?us-ascii?Q?Uuzr27Q4QV8L0XWBliY5Lxw73MPUrU6nWwuFAwtK/XxnthvpB196XgdW52IE?=
 =?us-ascii?Q?clTH5YRE0RHg4+vXZ/kc9g8phHtugiCI6X9ZD79YDLXnCyUCOp/V5kQGV84N?=
 =?us-ascii?Q?/9cKCu2lp1Q+fte+1eiXTwcnE1R94IpkKPkaaUMSOUwFntHbORqVXHwrsvo+?=
 =?us-ascii?Q?GZpM5+0Q7KUvw003XS/xBWx/wRn3B/jjV8vedhzaq4IdHAHyO4yXzMgnYYxB?=
 =?us-ascii?Q?5cMlgKIwoA8iQPfAx6G3Z25ic3VjYQRdcRM9zSNsz8qmDlv1P2XPtAWFgkFi?=
 =?us-ascii?Q?e1kkpFMsHIxBQJ8afYmJE9/HHzeq5VEhbC4KDonjuId4pxpoV7sg1kejIato?=
 =?us-ascii?Q?tv8Wlbi+Mxw2XmsvYkDuGn040IfsDMegN9dguFhO1Dlsm8QJJ/V1tV8b+Qy0?=
 =?us-ascii?Q?w6TdxebuPJS1m6bQGpTGJaZQfuE7Xn5AbwvaL+ZHP1qHUThuydJF7bio4VG6?=
 =?us-ascii?Q?wzypVFnPoZIJRghk/NYkibjVNGeIlZo9fEeWzdqhfVVrgHd1jwYPiAc7UE5h?=
 =?us-ascii?Q?1giaxmqgXB8zw1LPLOgXeAWmyocaI3JXbXPpJDH6CJXwBaYIZXdtnKCDQs8i?=
 =?us-ascii?Q?JKalQLk2bwlB3MlXytaCG0v+6OScTwzxlJ8DcDo0IRhT0QZU00JIvOGiGUEF?=
 =?us-ascii?Q?vfmCQtIeULNhR0VKXuy3WdxrmQQ/3IZ/ht7OMzrL024betmR+NKmK2N0Rihq?=
 =?us-ascii?Q?fitfjDUFQky+5RomDca8HPWRA4Si7OXlaeUEj941yxn8ZugY+4hkMCet0QhC?=
 =?us-ascii?Q?yelRzkvHu14ABynK18yo1dnnGgX4YEa1JGekYuWOU7NgmhS9skuUPkBo1uss?=
 =?us-ascii?Q?2GvOZ+FUmCvqhd7xTUy+yVpruHSTAc85VP5nj7aG/vFmwMAgKvRIKSoy/nK/?=
 =?us-ascii?Q?ZAnNU4GDSiOwezehhMKisvmEqQM9c4IL/wIM3vFtRlbLamuWmvwfm464/SGD?=
 =?us-ascii?Q?3qQp7vq1hTPgu0+hg83xt1j8bUS3tNc0+LDKRVw/DtYIyHFftz9UvCFHiIpn?=
 =?us-ascii?Q?ulnrY900+cfqLeUyyVr7u7xFqxAOcMCXVdEhu8BQI5tEwj2/u7ehXczb7VHl?=
 =?us-ascii?Q?lhd8/sD5y7UKWEdS+t7FZ0lamHJgFueLh0tA5Kn/e5wOGGyyOvnASXGg/MKP?=
 =?us-ascii?Q?P7qxwABVXtlsEfplDFCGCWRavUa8jOh9voiMeO9nCSZqwUPOdGKn4ZVKNlrx?=
 =?us-ascii?Q?gmLGoaMI5O1HaqSSIXvjfvkW7cdOolJ6gL1uyPiD0q75uLW46RiZw/tSdbWm?=
 =?us-ascii?Q?ohWwzQn/7VUR0uXCx+cp+b6Ix0XUAZCIzhpIQ7/IUiMpSANp67365Sj4NyaX?=
 =?us-ascii?Q?hI105QffuKXJcrl0spNcUtyM4EwADPHd/enNarpC/BzHwz0bD34LBy+zXtzp?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lYqFSYfQB2tDjxm8pTWoLux9pkOIc++93k7MNz6DFQAfcOAYc4pMDf2ZQwlLAc8SkWKWufAKbqlX57AsZKWARVxiWX1zYlVAyI5ebTN5DnSIZ0lFpbKCYmff/GAyo0GCFcyFT2gXkGz83ZPI52IiTk7aPap8UBer4xwqn4j4IOaisySJ/caBkCfKBtYnVkHk/rmDo2uQoKgOx524fnhQW/Hq5BKQu4AgW3Z0egDCP87lFE6s3a/93ecIPBkNpNXbyj/kFMYkjFOEpeIxNy86vEgsDeAvdP5ZWcJtoC9zEp31sk13xxAakKcOex0ruo/zDoGN7j/K7iXNZ5ipv+CJwq0FWraeN296ApnSU0aETea9cGORJyL3LerDFnrqkzT6boRyjFgL4uSoqDBqtNT/oQ2F2qk6TU+IKx4uhS06YDewvdPauMBUNxwWfaUP2QxzltCALKnoujSWDjZ1suZXaIa47XZgGOIdgi8CPmEGoqoiLNh3ixmounR8q68NdK8XneeMmUBQyX6K3JjpguwEBwkjU3uRCL2VKb9hak20OvPpAp2NvuzF4eBAeisLZvyDvl8JyD0YrrMDO6pc/qN/V1DhfWMHye60R1/ACvyZVjQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafad5c7-e6cd-4d4c-296e-08ddf789ab6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 14:34:41.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUCtGMtx7rlb87SiozeUFW3UdPVdyJFvEXM3oSvrcbOJT1TlHZfmjHRSbI8td3we1+33o8JExzvL/SPZlyrJ4WOcUBa08XOGzM3f4TDI9kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=855 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190136
X-Proofpoint-ORIG-GUID: dSb-bZGyminFYgV-MFjIVTkUnXh6LTPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwEJ/xJrt/tL1
 tnAS1IeV7yMe5mwCA4ip/pOAB6VBjaUt1F7bjdO97hF4tT78lg2gVel3J8e88H+CJGP4ucOmysx
 uh2OTrPmFC67wHyH5l3YEP8feKqsEBTms4vdPOOiJ5155wi8RloEJ33OQh59AFPp4XkpfkbWJsp
 kgdcT71TNbGXKbLGNT5C8R7L2R5CcJZh1uNMUicd0fOCXq8N6lLD9MvyvNxLr/D/1CfvLymUbRP
 IjmEN3LC/RP8xirKgcAhVYlfGbTnFg5Y31PiYe3c0mF67G6iaDJuDzFfnFabf9UfYf441+byAW5
 +qT7MiX5otRoh+HJmgMkMTQDYqzfTZZYG6sx6fGExGmshnU6HAKmFUbpyQEcT5YV+jYjRFDE2jg
 izwO60zR0JUqS+ln0qEvKVZOBMfZiQ==
X-Proofpoint-GUID: dSb-bZGyminFYgV-MFjIVTkUnXh6LTPo
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cd6a07 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=BQ96kVCl4kuJBprGI7IA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084

On Fri, Sep 19, 2025 at 10:16:57AM -0400, Peter Xu wrote:
>
> You described ->fault() as "a hole in our boat"?  I'm astonished and do not
> know what to say on this.
>
> There was a great comment saying one may want to make Linux an unikernel.
> I thought it was a good one, but only when it was a joke. Is it not?
>
> >
> > My thoughts were around an idea that we only really need to do a limited
> > number of operations on that pointer you are returning.  Those
> > operations may share code, and could be internal to mm.  I don't see
> > this as (a), (b), or (c), but maybe an addition to (b)?  Maybe we need
> > more ops to cover the uses?
>
> That's exactly what this proposal is about, isn't it?  Userfaultfd minor
> fault shares almost all the code except the one hook fetching a folio from
> a page cache from the memory type.
>
> "could be internal to mm" is (c) at least.  No one can do what you
> mentioned without moving guest-memfd into mm/ first.
>
> Nikita and I drafted these changes, so likely we may likely have better
> idea what is happening.
>
> Would you perhaps implement your idea, if that's better?  Either you're
> right, we're happy to use it.  Or you found what you're missing.
>
> It's not required, but now I think it might be a good idea if you are so
> strongly pushing back this userfaultfd feature.  I hope it's fair we
> request for a better solution from you when you rejected almost every
> solution.

Peter -

I've been staying out of this discussion as I'm about to go to Kernel
Recipes and then off on a (well-needed!) holiday, and I simply lack the
bandwidth right now.

But I think we should all calm down a little here :)

Liam and I (more so Liam recently for above reasons) have pushed back
because we have both personally experienced the consequences of giving
drivers too much flexibility wrt core mm functionality.

This is the sole reason we have done so.

We are both eager to find a way forward that is constructive and works well
for everybody involved. We WANT this series to land.

So I think perhaps we should take a step back and identify clearly what the
issues are and how we might best address them.

I spoke to Mike off-list who suggested perhaps things aren't quite
egregious as they seem with uffd_get_folio() so perhaps this is a means of
moving forward.

But I think in broad terms - let's identify what the sensible options are,
and then drill down into whichever one we agree is best to move forwards
with.

Again, apologies for not being able to be more involved here,
workload/other engagements dictate that I am unable to be.

Cheers, Lorenzo

