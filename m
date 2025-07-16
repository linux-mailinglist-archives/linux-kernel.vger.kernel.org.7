Return-Path: <linux-kernel+bounces-734086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C6EB07CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485CB505237
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57A129A333;
	Wed, 16 Jul 2025 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yx82h0+3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QTWsrIRk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F3917B425
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690479; cv=fail; b=Iw1GgQiEeZTQXxGEZJ4SevrRUgvDTQOJ/BHSAi3gthQft2zibsUJmL6vy8ngZSnU3G1LRfOOP4YyfcPm7i/o+FRqtxJ2kG7V9rDHLSBXjJAUQSYQLgrSOSk44t13Z0vHkY4VJkD56M34+tygZHEoNXFlW+ENPBdrV8s5hwjW7+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690479; c=relaxed/simple;
	bh=npO0wlkaF22kCev+JUJ/E3/teQduEWfaafzytUT2lhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PN79IxmYWi5S2j5OxBpuYXS8QB0Y3o5M3OEFtCwdZkEiiQLc0dcp1ZOaw7i7wr7Zrq1Pdkg0GVpn0KCqMVR5a5DqbomgnZYSzHDUKD03Cq+T/jQIvkFdq3ThQkwgTHULIyTgtUEtJejmIj7zA1GpBEBGt9P8pIDpU5dDiF6MRvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yx82h0+3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QTWsrIRk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHfibi005649;
	Wed, 16 Jul 2025 18:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=c8f9g92x99WJj+hmuo
	A1Ri+0BVcuaZ+eN43W52y+1p4=; b=Yx82h0+3mAWdGrmqe6Qu+eEoMa2STlVOAg
	csDrsNzyUwGsa37WfFniBYzbh9uHjxmBaPjnlxiCvb7f/zYzb+XrADcKq/wFdiCC
	QmwbQrZtrbb5q0bu5UuYBKvrNz8xuplxYCpO/HchHOZ7nr1sC3VN69D1NLVZXZbw
	C98K7JjBpdBRD/kRaCMma9CVvz6SeExx3DTg/LKLkkDGMHn8Q8nLBIdKnTwJyC2H
	9x1aN/7w5FQKihTvRafpIDlf4K3ujKVsaI8Rq8CnSPLeMEMTXK5zDK5Ae1WRAccc
	jU8MeQsmtNbRrLrfj3Vyd1wZP5Xms+sklTLFODBUZ79oD1xwEsmw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqtad6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 18:27:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHoHII029634;
	Wed, 16 Jul 2025 18:27:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bear7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 18:27:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIF424KyYkZkrc3r3G/JbRGkbjB5q+E/fDGL+ggds2qAnrhINPj4X83wZRof9tKUIa204JDPFPTWxIRFoTdBl3SCpzLr+Sl7DURwZJv0R0gMsI+8YTJzhWx6r/SQC5tE0nrJBXTnZLOd2TgHGzpW20dIz5cYJO4dCHZWg2y4G9gDLYaoSKsPoNRFamxD5VW1g80anmiEljodJL/5VuGLxbhQeeoirC0JRH9vEUc+bmis2KysNtNuH8vtC3B3reWPoH0i6fOhJVzKVtpkxomUO+Ex1JcNrkqH81bRbSwl1vcIOApYfPsM5TIm+19bpXNIJnI+7dUr56H0+rqQPNOEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8f9g92x99WJj+hmuoA1Ri+0BVcuaZ+eN43W52y+1p4=;
 b=f22O7VQea5326dJTI76E2vV7dXkQkyi6tIFqrleWPVdfJYTxbyC4YHhLabcjKN7ZlSoCo1gQTo4g73kj1WxezzbltGZs976ZXKUTSmTg3Q1VF6vYde8k0B9w/s8oXitFqDmiqyOr7iu679rNjaG0CppRYzLGcPn+oUwgJmtYzzCFHBkSpFyezy4IObTa2Dgf+2IlQXr/9cW7fQxJIBGPgnn+AkOmcIcZykc1dvWAVF+dUbqvXtGri+YzDZPFsr6XvMw4FOcnEDl3Od+3mnFUgDUGk2kaRDT4KszljnAn5ADFISswQkAR85n9LR0yZRGLmwOeRaNnXy5YmwFn3rjBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8f9g92x99WJj+hmuoA1Ri+0BVcuaZ+eN43W52y+1p4=;
 b=QTWsrIRkjxakbiEmPonyCZJDlr+ZhFV4CjV7rZq88h8c+MUYFL6VUzhXarS/GRDfJzSl/tSY3yR/xf9ftQ6xYiQ8cYxm5F7bgs0SlktVnjamY4NTbiF/pzeZdWoGRFCon9exKAgtEUuzJJdAUmkf7sKmh45FhtJz6+xnoamO7Bs=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS7PR10MB4831.namprd10.prod.outlook.com (2603:10b6:5:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 18:27:38 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 18:27:38 +0000
Date: Wed, 16 Jul 2025 19:27:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pfalcato@suse.de,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot
 (2)
Message-ID: <ffeb2324-a1f3-4252-8f6e-4639bc37a151@lucifer.local>
References: <6877e797.a00a0220.3af5df.0012.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6877e797.a00a0220.3af5df.0012.GAE@google.com>
X-ClientProxiedBy: LO4P123CA0472.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS7PR10MB4831:EE_
X-MS-Office365-Filtering-Correlation-Id: bd91488a-42d6-4345-bc29-08ddc4967167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QePqz9crYy7GaTdg1gq7nIafIqShykeuj4qutuL/icQhbRdzbXSLwwC/8f/T?=
 =?us-ascii?Q?1LNio3vDKQT5G+XLJT6WU599312vAAvk4mO0RpxSB+q17ejBOEuyjtWHkTCK?=
 =?us-ascii?Q?3Gc01NrXzlTFBd2Sp6KDztLtn9tmMB8E2aDXtQNiqkmpGVVa4GylGKz4sf0y?=
 =?us-ascii?Q?Wd/Yr2RTc8oXriy2OmZB6FIVlZlaJP9tnyZR+51xvXhg/ZmvyITQtetlFoSZ?=
 =?us-ascii?Q?U4lLvFisuid229sme1JeGjm7Kxmmhjz6xdxzDWgJL2qnX4n18baCFeXKY9Qa?=
 =?us-ascii?Q?ltftGay0YA0gXi9X3H7yC/JJwlnVbntjMIxpOXYvtVgXLyEKvgkyp+B4wS+l?=
 =?us-ascii?Q?XzGvnOPwDFFx5SWHERDwnt+5atIKwNfMR/y6ytb385UCHKgmARCx72ZqfuG3?=
 =?us-ascii?Q?puRYveAxrrz1dtQXejeaqDFokE0f9sjXrA7SxpdJwwqQBE/MNT8i9i05sH3Z?=
 =?us-ascii?Q?Y73KXW5kOpYceWw+tGdzcolKQdtmoDMF9YtQAMbhAubIj+04sENPsXThFXwL?=
 =?us-ascii?Q?tagmTj2Q8DzX5brW1zEmVdv+0g3Z4K5S8sugNkFN0pVdEXqiBOzQK0vrYTmS?=
 =?us-ascii?Q?SMC6NX66znA23EKMqeq+/UZ2V2whteW2wP9eNIkt17I6QQLQZgXOCtYX8pFT?=
 =?us-ascii?Q?7NTPynWHyLOnLzeB8rIazfYiwfTELwSVpdAwmGtN0YDRBrA1IBUCsYPByqh6?=
 =?us-ascii?Q?bvPAKKdgwQycjxRXptzwVz1z+z2vlIpam3I/q6BYzHFIiJLATvIJUjhBoC4k?=
 =?us-ascii?Q?WnInOusJRNPQGvMllXq9+5q+xaMqICtnCnOkTArtcA0Vc9umYQFZ5c0kpggn?=
 =?us-ascii?Q?wtOxiIalK0QFCc++KjIOWQxZnECcjjkAoPgXA03kbEdl7nHzGEkcIOYn7qOe?=
 =?us-ascii?Q?Vmp4nujRxh3zh4MEDNrNB0mqbirmAHZicadM456Hdo1ubBFgUn3smmJtl41V?=
 =?us-ascii?Q?BkeXGSa7+eH2m0VtFO4E6l93wRKkmUyYYavNekaCK/2soaTJfl5i0pY61nN2?=
 =?us-ascii?Q?n4O705JnQw87yWJfNIOcQ0ZH6D4iDsdTFF9aHOdyuZfHlYEXz+YHP+D8eVt/?=
 =?us-ascii?Q?hvZzPDMamgC1jmqRfyRHoekj+Sf/gmMARHJpvE+mjucg7CMlAb8xneXe0nnE?=
 =?us-ascii?Q?MuQQqAyTioxcLHALEy85A5tIUfvu0WUZA9gs8yz0uLi7LVfioaFFxFSnl95H?=
 =?us-ascii?Q?A08V16L0/w+tVhGJxt+Aqds/wVq0K+ouR+m5WVBit5BPdA/H3oLWef9f0I3a?=
 =?us-ascii?Q?/PIj6VwZe3b6oN57OhrdENV1eddGOi2TgOVB1SsvTPuuK8vY6siPkXdy9xXE?=
 =?us-ascii?Q?VUwJEqLgkbA890U+5rj3zqc9HBnpSEMjppko0wfmYWFZ3RYorDta84cGbsEh?=
 =?us-ascii?Q?IDak9XwnUsUouQIh/n9OvRiE3MWB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5sVmw8Z9Ml64mpaG0AyiGeIJfQBas6ACQnTqpOpy9cichjNnakIoeau/etKx?=
 =?us-ascii?Q?tQJh9ltOpTK+3WvPQXtS6QYliE8hcLKLbA2QqXOoQMd0vmIUVt1y7Y1LgpeM?=
 =?us-ascii?Q?LZe0OLSEsU/cl3wk4FN+vXQtKOrN5oZzmeD11U08aBukFfP5D4RAn9gJm/XP?=
 =?us-ascii?Q?7tWfYGuIXtm/oQGwWTkAnhKs7tGWywdDE3sMDHBINyH6bAoK79airaFOAWBt?=
 =?us-ascii?Q?N/28SoalYLwSGFEJzeZ4qHtbJmsXp1aJx48sbW4RLLU3RKUIPBhfiyXqQ3bT?=
 =?us-ascii?Q?qphdw+/qPKVFTPNvYuXFy7KEWsAhlDduMdCgWzPf7F0HjvJavGW2DV+/VxzB?=
 =?us-ascii?Q?BeEp5qQN10pcMD3XYfN4a/liSBmr6rYEYvZue3BRqtvxC3Hkc4x3NQNqhqrn?=
 =?us-ascii?Q?RY1JHfXr1xGwlCge1m0GFTsUzCVzc7/1aHs87A6wKVy1jfBimcx45q6jDz/i?=
 =?us-ascii?Q?st3OI6ie3vvhTgBaGP85MrUX8CfGiVAQJE8ZAi8Z5iMPCLjGnAyC6KWjx7or?=
 =?us-ascii?Q?8lqdZdgHPmg78ZWZgFCfIi3KKfFIKF/J+hgGNGgywf7RDPdVsLWRL0FdDps/?=
 =?us-ascii?Q?aqRnWOzraaOK7bO0b3u0BxCTgY3wOL0ovuzmtMHhBOf9bQG3RqqX9P6AklT5?=
 =?us-ascii?Q?u5FOSPJm1oN/3Ta9r5hNXbpymu0vS7apIU+jWzOYLRdnD+umRt0j7dbHCawy?=
 =?us-ascii?Q?es2MbYWw9NzE0j/tR6mm9yrRhLxWfw/7r9jSrP5t/YGl6h319Ugf4waEinNi?=
 =?us-ascii?Q?Zr2NvNBuoXGcaqPSde+XSCqxTkLcvUPTh6RArnTQakwjMniRmf/JqJBHJo2d?=
 =?us-ascii?Q?861IVObKm8Lsk5kSQSQiFfh67ObMxPPnZbs5O9YxfnFHqyeX6IHtYtar+q45?=
 =?us-ascii?Q?5PF/qH5HBcLkUkaYv4MAgQlOQY99VOHjOJOW5Wd0Ryzs5wEKzS90gBpLqy9L?=
 =?us-ascii?Q?Xi3caAOMLKFEzKLeFD5TRxpzK2DyjsmYqqi1Pw2IkzkVEDMDWWbzxl6CXf0l?=
 =?us-ascii?Q?WB2iWRKk/led7K3oSsDNEl5Jc6v0Pis/oihtFXMZaPWaKhqwQs9zkzvLne6b?=
 =?us-ascii?Q?DNXRE3vvqYghjaJv+MR+KZfXN9Y9QSgy1rLJr3mwuYcD7ZYexWrbwjuRPVD+?=
 =?us-ascii?Q?Ve6I3c055GwM3fwQkWCQgxQ81Es702KsWre5BjQP3EWlZ78hQWvkUCu9vub7?=
 =?us-ascii?Q?wFc2JeRcPA/H1UZnd/UHflMYDCQ6gpS9G75NokpfAB/y2A9tH9QHRIxbXTQW?=
 =?us-ascii?Q?Err48fK4quisb10oLtC1Vt4yu4cC03AdbrgYi2UZzM0wB3ymHM28qhgCW01P?=
 =?us-ascii?Q?lHijiMORwQFUdFl1QvnJyjVZRyua6XA+GGBeNvLPKbg55QiLGnuyb9KCUYaP?=
 =?us-ascii?Q?bRVwLpxKEc7ItJdBu85v2WaIyvcQu6h3s+8QwcD96HeBDm9FI52f2OJedUEr?=
 =?us-ascii?Q?HZ5sT5rJAMJvtwlmsVhCRkrZQpOlYJJgz0hZQ+59V0NKJU2sTl0eaq6wWBUn?=
 =?us-ascii?Q?GZwghj8aUujZYTH3wULE5Yhx/OemKXbfN7jTS2PaTC0o/SrWAcXHI9zUg45F?=
 =?us-ascii?Q?/GymW8g+Lec5D5Hw1eUc9A+90JRluhka2gZI3QfE9sOZKG6/Nt5truoXav4z?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gB0KBoW9uCPDFcYIfsYp5+tK7NBBCvEMUwCawwPm1/xop3wAS94V9A2/CcLFPj4Esebgzk26tDb97MydtRBSQ2qQvpXvM7a5MZFw8dEOR0mQMpOVrrbJNIQjjs75GQnyf0KsfD64QT5Pu6+bn4VGsSBDpBc26CIWtZpDS5mV1e4zXhsivSg0fKmTknJBsbrCuhbwlDTWnxp6LbJC+OIjarVBif7HmGcTaZplF3OQwo4NLh8oPxKWe01JNKp01ZYgGU0k7eWwmm6spbR9KkFXHlQShjNlyeSDIrAMbyJnqeQ46flwn8N0FZT5eeXdRYRC+YhfWByLNzs6/TVVpD5iofNaQe8PHS+XwD1177scqnDKrz166d8+IDwqKOm6S8EBat/u10N+9mtbN1w6E0Uuu7fPjOQ1FeoAPbHqwOBfQXAiJvLgUAAPjeec9CLJvGjH7KuyiDk8ZpWViBBT5djxCyCQ7dHQbk+Ujvwr4QOOU3MX/Jsism3lstamnqa6cgUHXK4tBP3tZauLE7MaKw7VdAdsOOwRAdjSUGMH5UVZCTmI3XICYTEe88vAU99Qz38jbHTaIIWyHbICHYqzHoS4fMwtQDysqR4xtpWeKLEGkHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd91488a-42d6-4345-bc29-08ddc4967167
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:27:38.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWJRZoe6LSqhjv6Epa7N6XwWvlmqTm+W5wRDqkuEjwiIR1LCHrwa03ylusQPJu7c1cZvucExtNUxJ0juVZEPehWuVI6J3gJCn5/b9IDtXNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160166
X-Proofpoint-GUID: ZNhbVcwRnJqatHkLRPYREemZHvqtBw22
X-Proofpoint-ORIG-GUID: ZNhbVcwRnJqatHkLRPYREemZHvqtBw22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE2NSBTYWx0ZWRfX37X1veyf0cjS XMGFkoTUog2C8xFuQ/QiLZCHnHYIU5xcG55DSIja6+OoStPUqcspeHAgeLSuKd8XAZim4Cz/kZx PgksrYYztkBx1EFuGezNFfmg3mhsNLt0vJS8kRvxFik5Kbj4l52NVworaCNJnc5cGk0qUixa0RJ
 C3AOT9iDRA9M6M2dvlO17e/ZETzwPGHHOTu5FnYCLOrNsCTnYMdAbrjltZOpINeCxTaC1rMCW5x ChO3EB2tRfc80bHYs2ZiY7xNuAs3vSLKLDImemrHwdS8XPRukWsL+XDVNhEhpUt6YMZlOYLramu gdX/k4yOcogCZ/AdtB7wFI+6ih65zCP1NKaEvzzdZ4BNA957AFvPvU7ZZg4s7IAf005OKRFgU7N
 0/XFMPx7/hy8UgqOUPZvwfLBzXjcBWWqXKlDuMFwhno3gf3+p3RHzR+2yGI5cnGx98my/3EW
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=6877ef1f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8 a=4RBUngkUAAAA:8 a=hMFDTOyKs6d5ScOmRKoA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19
 a=CjuIK1q_8ugA:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22

Thanks for the report.

This is due to an older version of the series being in -next which allowed
MREMAP_DONTUNMAP for the move operation which was incorrect.

Andrew - I guess you will merge the newer version to linux-next soon?

In any event, this report is therefore bogus.

Cheers, Lorenzo

On Wed, Jul 16, 2025 at 10:55:35AM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a9a7d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=adc3ea2bfe31343b
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebfd0e44b5c11034e1eb
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0658c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd858c580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/13b5be5048fe/disk-0be23810.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3d2b3b2ceddf/vmlinux-0be23810.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c7e5fbf3efa6/bzImage-0be23810.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in ma_dead_node lib/maple_tree.c:575 [inline]
> BUG: KASAN: slab-use-after-free in mas_rewalk_if_dead lib/maple_tree.c:4415 [inline]
> BUG: KASAN: slab-use-after-free in mas_next_slot+0x185/0xcf0 lib/maple_tree.c:4697
> Read of size 8 at addr ffff8880755dc600 by task syz.0.656/6830
>
> CPU: 1 UID: 0 PID: 6830 Comm: syz.0.656 Not tainted 6.16.0-rc6-next-20250714-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xca/0x230 mm/kasan/report.c:480
>  kasan_report+0x118/0x150 mm/kasan/report.c:593
>  ma_dead_node lib/maple_tree.c:575 [inline]
>  mas_rewalk_if_dead lib/maple_tree.c:4415 [inline]
>  mas_next_slot+0x185/0xcf0 lib/maple_tree.c:4697
>  mas_find+0xb0e/0xd30 lib/maple_tree.c:6062
>  vma_find include/linux/mm.h:855 [inline]
>  remap_move mm/mremap.c:1819 [inline]
>  do_mremap mm/mremap.c:1904 [inline]
>  __do_sys_mremap mm/mremap.c:1968 [inline]
>  __se_sys_mremap+0xaff/0xef0 mm/mremap.c:1936
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4fecf8e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff93ea4718 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> RAX: ffffffffffffffda RBX: 00007f4fed1b5fa0 RCX: 00007f4fecf8e929
> RDX: 0000000000600002 RSI: 0000000000600002 RDI: 0000200000000000
> RBP: 00007f4fed010b39 R08: 0000200000a00000 R09: 0000000000000000
> R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f4fed1b5fa0 R14: 00007f4fed1b5fa0 R15: 0000000000000005
>  </TASK>
>
> Allocated by task 6830:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:319 [inline]
>  __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4180 [inline]
>  slab_alloc_node mm/slub.c:4229 [inline]
>  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
>  mt_alloc_one lib/maple_tree.c:176 [inline]
>  mas_alloc_nodes+0x2e9/0x8e0 lib/maple_tree.c:1255
>  mas_node_count_gfp lib/maple_tree.c:1337 [inline]
>  mas_preallocate+0x3ad/0x6f0 lib/maple_tree.c:5537
>  vma_iter_prealloc mm/vma.h:463 [inline]
>  __split_vma+0x2fa/0xa00 mm/vma.c:528
>  vms_gather_munmap_vmas+0x2de/0x12b0 mm/vma.c:1359
>  __mmap_prepare mm/vma.c:2361 [inline]
>  __mmap_region mm/vma.c:2653 [inline]
>  mmap_region+0x724/0x20c0 mm/vma.c:2741
>  do_mmap+0xc45/0x10d0 mm/mmap.c:561
>  vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:579
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 23:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2417 [inline]
>  slab_free mm/slub.c:4680 [inline]
>  kmem_cache_free+0x18f/0x400 mm/slub.c:4782
>  rcu_do_batch kernel/rcu/tree.c:2584 [inline]
>  rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2840
>  handle_softirqs+0x283/0x870 kernel/softirq.c:579
>  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
>  smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
>  kthread+0x70e/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> Last potentially related work creation:
>  kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
>  kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
>  __call_rcu_common kernel/rcu/tree.c:3102 [inline]
>  call_rcu+0x157/0x9c0 kernel/rcu/tree.c:3222
>  mas_wr_node_store lib/maple_tree.c:3893 [inline]
>  mas_wr_store_entry+0x1f1b/0x25b0 lib/maple_tree.c:4104
>  mas_store_prealloc+0xb00/0xf60 lib/maple_tree.c:5510
>  vma_iter_store_new mm/vma.h:509 [inline]
>  vma_complete+0x224/0xae0 mm/vma.c:354
>  __split_vma+0x8a6/0xa00 mm/vma.c:568
>  vms_gather_munmap_vmas+0x2de/0x12b0 mm/vma.c:1359
>  do_vmi_align_munmap+0x25d/0x420 mm/vma.c:1527
>  do_vmi_munmap+0x253/0x2e0 mm/vma.c:1584
>  do_munmap+0xe1/0x140 mm/mmap.c:1071
>  mremap_to+0x304/0x7b0 mm/mremap.c:1367
>  remap_move mm/mremap.c:1861 [inline]
>  do_mremap mm/mremap.c:1904 [inline]
>  __do_sys_mremap mm/mremap.c:1968 [inline]
>  __se_sys_mremap+0xa0b/0xef0 mm/mremap.c:1936
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff8880755dc600
>  which belongs to the cache maple_node of size 256
> The buggy address is located 0 bytes inside of
>  freed 256-byte region [ffff8880755dc600, ffff8880755dc700)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x755dc
> head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801a491000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> head: 00fff00000000040 ffff88801a491000 dead000000000122 0000000000000000
> head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> head: 00fff00000000001 ffffea0001d57701 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6828, tgid 6828 (cmp), ts 120765032919, free_ts 112542256570
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
>  prep_new_page mm/page_alloc.c:1859 [inline]
>  get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
>  __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
>  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
>  alloc_slab_page mm/slub.c:2487 [inline]
>  allocate_slab+0x8a/0x370 mm/slub.c:2655
>  new_slab mm/slub.c:2709 [inline]
>  ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
>  __slab_alloc mm/slub.c:3981 [inline]
>  __slab_alloc_node mm/slub.c:4056 [inline]
>  slab_alloc_node mm/slub.c:4217 [inline]
>  kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4236
>  mt_alloc_one lib/maple_tree.c:176 [inline]
>  mas_alloc_nodes+0x2e9/0x8e0 lib/maple_tree.c:1255
>  mas_node_count_gfp lib/maple_tree.c:1337 [inline]
>  mas_preallocate+0x3ad/0x6f0 lib/maple_tree.c:5537
>  vma_iter_prealloc mm/vma.h:463 [inline]
>  commit_merge+0x1fd/0x700 mm/vma.c:753
>  vma_expand+0x40c/0x7e0 mm/vma.c:1158
>  vma_merge_new_range+0x6a3/0x860 mm/vma.c:1095
>  __mmap_region mm/vma.c:2666 [inline]
>  mmap_region+0xd46/0x20c0 mm/vma.c:2741
>  do_mmap+0xc45/0x10d0 mm/mmap.c:561
>  vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:579
>  ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
> page last free pid 5955 tgid 5955 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1395 [inline]
>  __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
>  __slab_free+0x303/0x3c0 mm/slub.c:4591
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4180 [inline]
>  slab_alloc_node mm/slub.c:4229 [inline]
>  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
>  getname_flags+0xb8/0x540 fs/namei.c:146
>  getname include/linux/fs.h:2914 [inline]
>  do_sys_openat2+0xbc/0x1c0 fs/open.c:1429
>  do_sys_open fs/open.c:1450 [inline]
>  __do_sys_openat fs/open.c:1466 [inline]
>  __se_sys_openat fs/open.c:1461 [inline]
>  __x64_sys_openat+0x138/0x170 fs/open.c:1461
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff8880755dc500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8880755dc580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff8880755dc600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff8880755dc680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880755dc700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
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

