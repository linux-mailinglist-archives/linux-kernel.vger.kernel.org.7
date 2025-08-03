Return-Path: <linux-kernel+bounces-754391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBF5B193CA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8203AD461
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB52258CFF;
	Sun,  3 Aug 2025 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ukn+etFf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MRCGwvNu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02B8F58
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219529; cv=fail; b=FTKLNR0Z8KFMA1dDG72viLTnGZkgaOkvqal7cNkLbtwP26FqIehzMY3uG+BFdeDJms7c+2W2MpR/NY9hcuGuwTaO85jrQfUJWzi14TPXxXAVX9GHgzr5gMp4lUX2SMYVx3KfDhcGQ+FVLyhbfW/5x1ApJW+xJjqjIypfUcLqXZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219529; c=relaxed/simple;
	bh=ex34iAJ9zlacXCVCFrxGqm8A4Qz/reh87i6uqwnupwo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UOMnNy78BS3btSSIpLUQV+CKZxvxwn+3gPVUSTDb2qpcP4FbSlxwhS9E2o/ODPgzNmvb1hDVI/YF4D3z4IO/6Vig4XYE7aiLFacs7ZhF59bBLf/r5t78f3AOefyqh12YBQYY87WCBHansmGZGZlpJPkNjKm+q1GIp7l2nFmIsgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ukn+etFf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MRCGwvNu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5734sO88021439;
	Sun, 3 Aug 2025 11:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=DjBXaIo4zI4Mk6TX
	FsmoxLgaIJU0+Cu15ky/J5fqTLE=; b=Ukn+etFf2Qe4D/Sb5ptfIZJjSiTWbpY8
	65TwNfQ5C/Ycz0T0sKtguvzSz1tuWsDQqe7Pq+Hxn88xyZLeUQurFKFUkzUHCgMs
	89MVVP23uDk6iJ7+so8CCCDt9Dsg3NsRAAAWSyHooHErzzubw12lMbh277WoTCS0
	pw1+syAxMzwUIg3kl7BUpT3F+PTeaRu04RK5ShaMvwAiw5pMxe0MBS6aw7vso3U6
	EU+kooiN6gq6tRkf72xNTwPzFC82HpWhhVRE51iBN3xWelHnqaS6CflAK8PeOobg
	Rd5L8YP6m5SVGSez3BgvJVKcn40jU0SOiSWN2xML5aKPTNmgTGR2dA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489994hant-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Aug 2025 11:11:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5737hlC8020536;
	Sun, 3 Aug 2025 11:11:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 489947418d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Aug 2025 11:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w17oFsk7IsT9YztzUB5IFyHHraonQICMnsq130ZhFWP9qCbKertm6KsrphSQYv3iVpKAXykMBA2eCdyx8FQRRupYTPc2Io1vb7RHycrrve0ITMDdoDUx3lFAV8aq0xvAvLmb+mTTB3PJYs6uegVP00tf+2UgcZFpyY8noP/gmir7f9nRvzHoYgCkVe9l+30/VcVKiTJlStqlcUg+Fqmbrs/5VjegUzM5ZcQN3TGvLlZYyhuuxvgEmSNYh6MawL4a/tso34GQpAcIjpwUm1/3O8pRhpG0lXv1si96xu//FEcoaxTcHpTRFWqAu1+HZ8Vm7hLb6okcZEuGZBwWejTtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjBXaIo4zI4Mk6TXFsmoxLgaIJU0+Cu15ky/J5fqTLE=;
 b=hjOlsEk38N9C/NiIxbQFVSyfaC10g2ByrTLv61O6wMBQVbfrY0IlgzcygSJEabf6AkEJNpCOfh9k4RJycY1FVJJRb2FW72+ilXvbQS4VxPMOz1pM0UxObmeQ9cn7eN8JQWM/5EuVHaRPzwiyvSdlVFD/0TWdTsTTtWn2Iydl6i7/Sx22NoPiN+Xes/6AnhYx09+hSWAWHI1nw1xlv7KwMIBedthniuduce+z3C9vPHBCQDjJJWl52+OnzpjscAgkym21be9PYw4+cO5eO44RuOj+o3Nan0rD34ykadFhTU8u6MeAYX7Rq/dgNCX2Gh/irV9Sz2O0asxbdxs5oDiqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjBXaIo4zI4Mk6TXFsmoxLgaIJU0+Cu15ky/J5fqTLE=;
 b=MRCGwvNuHWxWBlJqM7ZIax30eQaq8opBfn3s6WPtG8cQZh4dRP0LlQNnHgKbv9Beeb0EuVB74GkOVEZv2JsP8B7MMT70KJh7VjmY6idtvenlLDchso+1xXccT4ZLbBvHkPrgORqS23VHt2QBy+PQ8omWWDjh+CPWAtHZLcOd9+Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8732.namprd10.prod.outlook.com (2603:10b6:208:565::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Sun, 3 Aug
 2025 11:11:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 11:11:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6.17 0/3] mm/mremap: allow multi-VMA move for huge folio, find ineligible earlier
Date: Sun,  3 Aug 2025 12:11:20 +0100
Message-ID: <cover.1754218667.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: b99b2d64-4c53-429a-9d3d-08ddd27e8271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y+1NQux5DSHXF2t8EVGKCxniIjBKkbPXeCPcWjFGjlG7IAGTp1R0kuU4hZBY?=
 =?us-ascii?Q?CuDWoaXOpggj+wR+EtyLWrBXNx3Pj+6yzoFUpfi458LerZ27MpRKWm9ydM81?=
 =?us-ascii?Q?e+cTVSCxAVYm6pDhuozexust1CYeGkbjF8WlHIh15uariQYq5Ct1MkM/q3Zf?=
 =?us-ascii?Q?tjG4GSQQny0QUw6tSqhgalVKzkpFx1f092DDaor0uTM+O+YFNpKPPN2iad/0?=
 =?us-ascii?Q?JOVGlghqf2FHhcchuVifX6qBAhkqLX9e/Kzdhg9IZq1Qs+7H/lXDF5N6iRCP?=
 =?us-ascii?Q?I7il5ze8A/Y0qncdsVhLtPapQXMk7JIhJ5/pry3jcx5VAYE7lWMDZBULPc3r?=
 =?us-ascii?Q?v1AY1ZEz4dcux81AUtgGskVKa0CVCmPd1vRLQuJprBNp72JwIfP58tSxoLOq?=
 =?us-ascii?Q?BzuBO4Yk2bTCdMZiEReoa/cxD28pDZYF+ai9gaNZegCviCwQiuI+ggTuJSlP?=
 =?us-ascii?Q?8YLkT3Mrh8+LnJFyKy6IVcyZ9/J5g1xnnssEW2VhlJREyv0cyyfZb6u0p2H7?=
 =?us-ascii?Q?hJsZnAOY5uEZs9ZO6BPywub9Heiswk7dWK8c68AV5Y3kZkw20Ar8fQk8s4Ez?=
 =?us-ascii?Q?kO9XrhCTBPzunkMkLxdGjGFoUWgMMQq7NOf9yFxavNE+M9LGD7Tm+y1imckj?=
 =?us-ascii?Q?otSC++0MP4uQQsIKKAfjcx3hG7RQQnR6cvD0AGK12rsUuBcqtxvYEke4XRby?=
 =?us-ascii?Q?gvTSY3h5ojk85RxK3r7Ao3XlxxTFl/nZ+Iky2zFSdUv9/1dVbIrSeo0KdyFY?=
 =?us-ascii?Q?SXQwDRRLzwDceCVIdkxFOvf9xDgneahx1T8XEFTpOroaFXi9Vexdf8HY8aqZ?=
 =?us-ascii?Q?4HUI4BKfA7zS1jmnIewd0/JbRVDMIZw6Exz2wrmWdFB7THwPJKySHtG+idC5?=
 =?us-ascii?Q?HXuBxQlGRKcXc4qxeh4xLZG0+ZP/LGZ+f1VKjpCrAtNgMGLI+XMjqkeTySlB?=
 =?us-ascii?Q?D9rjuBhwoJQkGJK1BlHcFmn9+cNzpT/XNS1kmNif5djxnRUDVN1PnJKtfue4?=
 =?us-ascii?Q?zX7gXYmu4oze3PYDE+lAYMRIQKF/C2M/AuZ/6bv8MC2cfn1pBwDhzuUPl5Fz?=
 =?us-ascii?Q?BcS30fTye42uCW/L6dcNvK67KzLcYarjyRwnVloXfvb8f3ofmp7p3Q+TAHgO?=
 =?us-ascii?Q?sRuoL1UOe8WaNWeETszq7x31uDtKmgC4nc0x4scb80Io+kI6ZwM7KbZwRAw+?=
 =?us-ascii?Q?/XhygIwfnGVa8Y2GR3u/qeBUcUqfp//IXMUkhXQ9oQdgFC/Y1wSIaEIIwf2J?=
 =?us-ascii?Q?EVG0G+cgM2uIzbtDxhVwCTbE/azjkz3UDDVNsiLzaLedP6PnhtNPLX9ferWC?=
 =?us-ascii?Q?5M4RSDtkNlykq4K6CvTf49MqRfEP4XqzBWyRfYsU0kkITtKrCL845Wqy9Q8S?=
 =?us-ascii?Q?q5FeB0uBNnmnWRlCR4dY+dmuq2KZxaYvcGdhJjETE/GTfiqUph+wPgnOdvjm?=
 =?us-ascii?Q?svM00nSVa7M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jWIUGbrjz2V1uV0+o4OQXNh9KCSC+AFs76OhnsWcvAVZhJuKFBeulwg71RVn?=
 =?us-ascii?Q?1rgec9y92WRH6geH3KMyqZVaMDx1M1dW5POxf1XSi+IhRu6KlqDtQky5Q0is?=
 =?us-ascii?Q?ufAsgZnnH83bpiC2crQ38/q0WG7QS6V/7qSxVIk5XNj0c6ZhrtkmzdI6aNup?=
 =?us-ascii?Q?z/C6kSiegQxehVDrfS5SkqYh1GFy/C/l35SIuPATCINmeN2/jaenOG1Cp6+D?=
 =?us-ascii?Q?DKI4627gi5t4LuH4a/aMPbdMhsXXIqcUVAAPCVDGIWDJsuuEjmvOMaqmaToU?=
 =?us-ascii?Q?pDKTKo17klwt0e7PQ357I0Kz/Qq8Qi9PKFvG4obd78o5uZgYkThCyjgvZ0Cx?=
 =?us-ascii?Q?fR9HqUNLQXoPWRVyF7UVtQ+bZzYEd+AT0/3wyvASh3F3cXdtffDaH1anCp7L?=
 =?us-ascii?Q?f4+DtNHckJPqN1Zio4BNGfQzJx1MEIDFUfb0lQBK+gbtZnw5lGmtjl/N+JPs?=
 =?us-ascii?Q?6fyt+H9ezznxm2pd88SRJ8llbJbi0yPkjW8GtshKXrZuj3ZEo8Bk5hl5uXSv?=
 =?us-ascii?Q?geKKr5ywwXkANUhPZPsadjjEObN3i4umRDxslDIhs1vxCFA1u9L57zoGwQlD?=
 =?us-ascii?Q?8jhAeOszSnlPyOJ7ARA0TMtOs7WyhtGcBFkiIz/KhSsr5G+y8lnWstLbqnCs?=
 =?us-ascii?Q?mTmPNGzhXzpud0wrcCMlummLXHRwEiHYg4edq1MEeO6bHeOTVSoy9YiNOEIS?=
 =?us-ascii?Q?osL+EYVzzg286LunL1rSA5AY8t6ZWSmAL3xwZclREh+1M24Fy7ESeb5ZuApw?=
 =?us-ascii?Q?dssRQo3f0bKnY8zF4mT7Tkp83sIN8N1ccgPuzRbqo4X9vV0W9mkdvIKjUTqz?=
 =?us-ascii?Q?LGikESDchBjpMN5OjB9QksRqxfUaKcG2DNwr+ftlRNSa7bB4s+8vGbbjDoIT?=
 =?us-ascii?Q?2zuVjTIJWwcbz6Xp3Fau3A79cZC9CpfMTnqefD6wN8kAVQ1kBn9Bto4Y4tHq?=
 =?us-ascii?Q?dmtHtoYbRYJaUT1bqhD65Q8dsUOgqL+zbjk63n3dLmneCbgJOlmmeUyb16Ry?=
 =?us-ascii?Q?ZzAw3XXN3WQBu6vVNTkXxjl2JbCiK69igGmi6raPhkFnCuz1ujHIrm2pXosS?=
 =?us-ascii?Q?Fh4R9tn8q5Dixc+syv2Ij3vWQS44HLJgzcPBtwuVSqgIXo1FH86GzYP/9RLt?=
 =?us-ascii?Q?Xe3of0LczWMqKgqBkFwuU81TuNCcc/AittK3X86N2cp35DUSAPBUhoih9r8X?=
 =?us-ascii?Q?0GswPeV6JnrBSxTsqju8fdxXMKD+C/tHw/SqocbhQk1keZmL079GrvUhwYiR?=
 =?us-ascii?Q?urmMS6uKA/VbVDBEzCeFodZsUs3GFlLkn97/tl6Zvy5FuIAmzVoTLIprPhBh?=
 =?us-ascii?Q?vMXLhhExHZ62oLFxVnVkPzNd9JtKTJEx6biJPIz8zAhFMYdvfxYleJRs0Yzo?=
 =?us-ascii?Q?Jr5BRuDMFY6J6nbnDLEKOdxGtf2TOeVIO8PXUETqp/zGNfTucUC9l609p6im?=
 =?us-ascii?Q?ah6tybfnmLTrRUJ4V0zj9J6AtxP1FdHu/aQmG9x8qjhhxoQEMMVMxn/KVqtH?=
 =?us-ascii?Q?qNJ5tiVRBVH7lX5flcFBH1b5c2I2HxGXW1I1R89FMVjvwQPN1hVCCd8eo6Il?=
 =?us-ascii?Q?fV2J3YaeGcLYicnN0mHwtuS8uvWjwPgT/HLK+P3FDhZGHUtlDY1NQ/Zub0L/?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hzW9cyAbfpN35MNlSug+t6Q1inCymZwupTYFhMvAy75ow22IEhMKsHflG8AAzIrXoaa98gi9zfewFaSxdJbCopgmMRlNChXsCnKs+HVI6AQL0ngRqgtPRmnleogEvjHrjgWKdYxddr5lhZzt87qUJmZfVCtc+C8C3bjx/FshFS0DW4zSuIqgoF8k2dZpp/8TO0XP2zOoLzW5I/+iSDG/HUMjTQ9Bb+ySLgTj0qYeiVVCjJcBpKA9d0wwvbUOamUJXUSOBQKbsySJSQC6qdwRvbOUTWRKmyR0Eb4WBLhWZ36TS3srXR+Cz4TnRD0SDIxzkSAsa1oA27U0Xn9B92JfdkZogyibcjj8sY5P5wDAZdbwTTRKeF1/WDGnE29HZxg78oD8iNH+Uhaq40i/VnSKSXmOCDSC16w8vE1mpobZTjxLFv1N+b6+qye0Nj9e5wwVrWJK+43dV/IU2iw/ovT5RaqB+nnfdhk2YehtBYNGuWSNF5U4A6v3MOTfkEeftv8kxFAU7jlTpo+EBTbvFkP3dn/suHxBKVS6WRqBKmAiJaFqJ+DqqmL/tKaZjrccvSnaC4y4AYZMHe2UHTv+IKIwwN+jcjS3u4puGaLy55h8Kng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99b2d64-4c53-429a-9d3d-08ddd27e8271
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 11:11:35.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xt2V2IWnVaoFCxSX5NQiJzdCXNZaBki4aYcjOYnKhUlDPUt8gsXcP/1Bue/YYwTd6vyfTc8AmyfXfAQz5a0tsL6J/mGW4Lo/4WMiGkXdy1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_03,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508030076
X-Proofpoint-ORIG-GUID: yYX5kEcnXSGqSODvn9HJDmP5HV9pf58b
X-Authority-Analysis: v=2.4 cv=HY4UTjE8 c=1 sm=1 tr=0 ts=688f43eb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=nemWY_MS2Kd__8Ea4UYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDA3NiBTYWx0ZWRfX+JQUkNaxgyOk
 RwSinA7Pvqup+8aIOHKp6GeEUvBejFZ60YiMp7QPzTzqKWgndhniXfX8hehNRqHXWnP1WH6pDJX
 Wy7ZhjIir1lAqidEsb+jZFnaEWVlSU3+ehk5rMKib9i7spoJFN/Ccwxe3xoJAluymed+H1z3U7Z
 R+WajvoH88QiQQGRCrthcXHfjT0pkmbThjlHjTk9aa2QP8zNRd6OJZ0cxkvobocw/BV8guRm5Gb
 c6UFDyp5EtR+pdIOaF3Md0e4Op2KzUjChRCz3N8u3SH+LwQGLjq9W3Hsw6+Jl7BU1cTIVDzXW1x
 bROXfnexccan2YTqXlNTmkCXYdAsM2NbmJ7HlI5GRpEo3CotqqV6sx9a9hmKbm9FYVBeD4W1l5+
 4eaWe87ss31lf430KF3GaD7Kn45t7e96//YjAZStKBbAUOAMJ9hYFyANacvWlWGE6Z3+4BSw
X-Proofpoint-GUID: yYX5kEcnXSGqSODvn9HJDmP5HV9pf58b

The multi-VMA move functionality introduced in commit d23cb648e365
("mm/mremap: permit mremap() move of multiple VMA") doesn't allow moves of
file-backed mappings which specify a custom f_op->get_unmapped_area handler
excepting hugetlb and shmem.

We expand this to include thp_get_unmapped_area to support file-backed
mappings for filesystems which use large folios.

Additionally, when the first VMA in a range is not compatible with a
multi-VMA move, instead of moving the first VMA and returning an error,
this series results in us not moving anything and returning an error
immediately.

Examining this second change in detail:

The semantics of multi-VMA moves in mremap() very clearly indicate that a
failure can result in a partial move of VMAs.

This is in line with other aggregate operations within the kernel, which
share these semantics.

There are two classes of failures we're concerned with - eligiblity for
mutli-VMA move, and transient failures that would occur even if the user
individually moved each VMA.

The latter are either a product of the user using mremap() incorrectly or a
failure due to out-of-memory conditions (which, given the allocations
involved are small, would likely be fatal in any case), or hitting the
mapping limit.

Regardless of the cause, transient issues would be fatal anyway, so it
isn't really material which VMAs succeeded at being moved or not.

However with when it comes to multi-VMA move eligiblity, we face another
issue - we must allow a single VMA to succeed regardless of this eligiblity
(as, of course, it is not a multi-VMA move) - but we must then fail
multi-VMA operations.

The two means by which VMAs may fail the eligbility test are - the VMAs
being UFFD-armed, or the VMA being file-backed and providing its own
f_op->get_unmapped_area() helper (because this may result in MREMAP_FIXED
being disregarded), excepting those known to correctly handle MREMAP_FIXED.

It is therefore conceivable that a user could erroneously try to use this
functionality in these instances, and would prefer to not perform any move
at all should that occur.

This series therefore avoids any move of subsequent VMAs should the first
be multi-VMA move ineligble and the input span exceeds that of the first
VMA.

We also add detailed test logic to assert that multi VMA move with
ineligible VMAs functions as expected.


Andrew - I think this should go in as a hot-fix for 6.17, as it would be
better to change the semantics here before the functionality appears in a
released kernel.

Lorenzo Stoakes (3):
  mm/mremap: allow multi-VMA move when filesystem uses
    thp_get_unmapped_area
  mm/mremap: catch invalid multi VMA moves earlier
  selftests/mm: add test for invalid multi VMA operations

 mm/mremap.c                              |  40 ++--
 tools/testing/selftests/mm/mremap_test.c | 264 ++++++++++++++++++++++-
 2 files changed, 284 insertions(+), 20 deletions(-)

--
2.50.1

