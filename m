Return-Path: <linux-kernel+bounces-754392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC96B193CB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD838174577
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430925B1D2;
	Sun,  3 Aug 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HSfQMpR8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KhfPiQd9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08C2206BB
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219530; cv=fail; b=XEm8qVCA/gB/L1HpRX8c6TZSYRwDQCQmCS1a2T4aDcwbs7I/8DiU1JD6tcIQ97ftC5tnVgGutCNzHGOHmtf6EtNHXN8TWLWnwq5TJ2OnkMthyrT8SDzEHoRTyuQEi/guUe64KKFG9QGmYxvTPd/ZgFRdxtyR8TFgLeJteW/d5Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219530; c=relaxed/simple;
	bh=ezfqAkJMqElRIyXHtgwFzrTNgmptpSnxvZ5wOGaQwWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CuXEyBojTsMzV1q9xH1vq0PscZ00o+K8Z6K03PMzBH+5Ygy+OEGWITW+dLSqFbYDZ9PAuPAR6i5qPCIEZt8kdP9UJuONpvD9AEyzpr8bVyvB40pC2wDiEOv1kNE8Woq/75QnmYDzPdj3yKn23pobKkroD+zQQQU/ylDmFjaD0OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HSfQMpR8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KhfPiQd9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5730w3cM003805;
	Sun, 3 Aug 2025 11:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1FbmhUgjE8RwruodggOhbuOltofNSivaxxIp62Oi6Kk=; b=
	HSfQMpR8qNsQzP+3mz025YHrqnNwawKY0CMz+tqkbAWyhMgTtpZeyO5iKE62UdKi
	Z9WGiM0OYnTestcrxnYm00NXhFm0kIh+SBTrC7nvdYZnMcH29ftyG+r6W84SWEOw
	zHSaBN/nlcutGDcWI1XjyiLgmzA7kRBbfYJ+34x9h3zgBIPiGElbFuLfqkxX//BV
	KRV91qFI63fJpL7t9TFzFhPW8AxYAxnKe97XVX/n/jd3ipQc83DMm1fKSlwNv6dI
	+5m78/xUpGu7p11WTWr5ywj96X8KRXbedx/FvUTpq9tz5jN64zpT7R6D/ZTs8Gd3
	DFJxFe554Y48dZ8+xG6xQA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489b7xh8pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Aug 2025 11:11:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5738CcJf020538;
	Sun, 3 Aug 2025 11:11:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 489947419h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Aug 2025 11:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhR1lDl48bZxxjlw39TYBROYoIttQCdNQFQg8CV1+yokgTNk+Fw0M2sBG5NcGU8w+39b5PEYB+LIV0EktlzG8ljm6IXS9fF3oYax29JQOon7uyVbFYzy5g+9Z98nc6zR8RR9FAIQgtxY0QMeL5pN2x3OhSxoyyFwESDZmV8HeSTLDAyAINQy3/u8OoziV50KvmFSS0CFpiH0sawXzrIA2/4kVeR5x7C2dWhAlRX0uv6kAu/edt3+AFxc/Klu2hbBHUH45YkbkQYCZr5e8/M+ObkWxp5ETDPROxkxIcyt2KmXzkhbdZdq7HoJHcpCedadgrMaCT8mQEj7Ihy/sKm6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FbmhUgjE8RwruodggOhbuOltofNSivaxxIp62Oi6Kk=;
 b=wEZJzQ9a4WdgcQquHYlr3UG1WdtNkiok+dicgOJAT5cp0RC0Ylw3el0Ousck4BWCtZ3Rvy53XTaU92wRln7D0n3KSf4sW+ULc3Zj9KKGbv0I9bBQxIki6LjWP+iX0Vy1gj/NqmgvLyEd++lkzMxcAeGbXUwGaaTqicAoIZtNi46MJQ97x/NIKLqjSuQp86sP1b7zIymSINmmgkX3b9j02iKwongKLFE7VSn3Nsk3vKAHY0VvfeMEjpU/00CG/e2jPuZ8gdghVZK0e9O84ttO27xG3+NYoRtaCIlTTI/6p6nEU/+e9WzEf4XhUedpOnvqVWe/aypXPmMJrsP8wbCu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FbmhUgjE8RwruodggOhbuOltofNSivaxxIp62Oi6Kk=;
 b=KhfPiQd9zDE7n1TCB0cmkqmozvT0LZrHD4rC3hM45TOcamfMUduJ8KP1uhLUtJ66O6Avd+jYP3MD8inv2al925xci8zWJW/F63Y6Drf3AD97Qe7yNCXGUx9KrH+5GCf1UJ4ZxNHDluJMzXOvjgOjacipZ36oKWd/fy6Fhkd8HWU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8732.namprd10.prod.outlook.com (2603:10b6:208:565::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Sun, 3 Aug
 2025 11:11:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 11:11:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6.17 2/3] mm/mremap: catch invalid multi VMA moves earlier
Date: Sun,  3 Aug 2025 12:11:22 +0100
Message-ID: <2b5aad5681573be85b5b8fac61399af6fb6b68b6.1754218667.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754218667.git.lorenzo.stoakes@oracle.com>
References: <cover.1754218667.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 053bf513-18d8-49b3-fd63-08ddd27e864b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1qTA30QXOtV0kWHygaBbt5pH0Vqq3xG+7TsPim60wats1Q+0qUBnFeOrFMhQ?=
 =?us-ascii?Q?AjS2z6xEalMbTWte1D+LBKnnDVxBnqVC7eYPBUHOtUJr15atwzHGaTZGq6xj?=
 =?us-ascii?Q?+AyN4QmIvYe5HLNxMvWgKd/7zvsA1CNdFHkQ3rHhqziCciF9aado17y6c/3h?=
 =?us-ascii?Q?9m+/iZRfykg5yHGuwBXerVTjxFxrCaPB3cqFqH08CCChWG3s9i1xZ5I7nU++?=
 =?us-ascii?Q?SepzRJFxrsMmkk/uyXX0CrIZzgqbWKyuzn5+G5CGWrlIHbGPLoHF4nMoVMoy?=
 =?us-ascii?Q?ZxK+5Hp0fIOxZMLXnVK27byNuuH1kccP2nZJZnxx+n0UOHsrhhGHahIr+y81?=
 =?us-ascii?Q?Kj+bSfb/EoAFe0NWne3yce7Fh0+caCTriNGOXU9uY6nokMiao/y9ehHFDIW9?=
 =?us-ascii?Q?c21luAezNDPJQfQsjKpqjqeR28hQwAAYXvfVEiu/CNVXi1FQ+nL2CObRccfd?=
 =?us-ascii?Q?IFEtzJzGJkLbXwU9ryZGcnwPyELRSYXzRzELVUhuAHE++7phw9oQD+OzO0vv?=
 =?us-ascii?Q?cBh1pEz3Drzv1Zo6zZgv/ZfKYoIsY/gxxVTJRaA6nhxoUBHja/7bgElJ9cmb?=
 =?us-ascii?Q?GziPv8unfQAhFpFxvEMBj7rBJ3j0/DAhkf2OpZyNJdayjKXHHxlk0+axEFL9?=
 =?us-ascii?Q?mxIysB6l2uSXWLBpd0WfAduYr2ezJu8Hv4s0zAAKDBlgHQhmoJGHvmTRCHhP?=
 =?us-ascii?Q?YAHMsYrGpRVQ1dw+xzJdE58jNiKUWuBscQOdQpBRUO9sVb+St9tU4Bw2PyLT?=
 =?us-ascii?Q?/IhEgEuz7LYHEeT3YbWBEorRmM8yDEEANyheO/1Jn5X/PTKkhMXoMBWQUi6Q?=
 =?us-ascii?Q?LgVWQQph2cYOy6TPBm4V1tiT5dPpyPhT7OepJWhLk/ANffBSkIf53pYE8it5?=
 =?us-ascii?Q?KV81ob3G292uxQhUEpoy3kCyMYbhdCl6V7LPW+l6KC3lptNeTSNKEf/bD6I9?=
 =?us-ascii?Q?FkriTogak1d4L2teODSOUsBTcxrJODZvg4m2o/MGzl6dhRKm7zG2OG2NOWLs?=
 =?us-ascii?Q?v7bi8B56X1mXE7GA1s1LuOzdFXETvEQN8+tvdkGxDgAr8cjOzoIUwLKE7fFr?=
 =?us-ascii?Q?aXk5vNu35AHYXFC1deIagruOHDN4C1Lk8w10GCQ8ZVeR+4CZPM58x+MhEnXc?=
 =?us-ascii?Q?QJ8OD706WnN4LpqKj4RLGNmW5GctXPmIXW9eztIBJqp0NTS2xJW98boNXV0y?=
 =?us-ascii?Q?DJmsqcWAIvudNYYSX9zIIXOaGegipZOeJeBF4FSk9TnED4uxG26zjBgAfaZv?=
 =?us-ascii?Q?xvUJpbjAyitXbtzOKusaAC7+LD4m4P/LMdyl8m4QHjlR66XNG4xh4g8HHbLg?=
 =?us-ascii?Q?pTqy4Bqg/Lxp7uAs0+UOX5Zgk4WmqMTAZg2cFvIb4nbZ7j4iwN9fogSZYYXU?=
 =?us-ascii?Q?iLmHaa4nnEIBKJLMYYG94Yl8AKyo0YvRp8ey9/x9/cBew7U/WlcPLOOdTTvR?=
 =?us-ascii?Q?/o4Axz1VQK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gm4Gzbh8qgeYXUThHyowsx9if3UnP2HetdN63sZ9i95BPNYF2sAX49Y+uWoX?=
 =?us-ascii?Q?JMz6QymWAdMPHZbYfIQJJmh+FNdhX7uVp2yTXjFYvKs1zFPSII61MkoOAnx5?=
 =?us-ascii?Q?vKOI5UIl9qf4fkzPUkukcIJTOBQsDCiDvCeSxL/RqmTjRuiNRrOF7ZVHKJpO?=
 =?us-ascii?Q?CtlDxg4cad+gaitAylv9YoqzY8O6m1ZxLUlGY4/wxNSFdwY8K744fo1Yh82I?=
 =?us-ascii?Q?jyI3w6Lz3GfSg1LNqWlQVOOjye/oCzvBdI2eQwOkpSZ0rLZgRHBwUNdmIvqU?=
 =?us-ascii?Q?Y6MgkwjD53az6tayWyn3OEFgvqqkLQtOzYYM4T+T0WJZxSIPhzsvStn/o/CH?=
 =?us-ascii?Q?jXM//7CYP3gcd+G52MzfIkMbLUdsrGQvXcG8BmO8FbTp28UVUgxhw35770Sr?=
 =?us-ascii?Q?ZaUwREi0mzN2BYiyOhZD6Oc9AADgNijeHDUWbK61eBAagaNjTo6u1YrWqWaa?=
 =?us-ascii?Q?qUqo6w4SbgzG6Q0vpnAU9cgexZDJ12n71wCmdr9VWI/mCJZYfeUcDqUGr5jf?=
 =?us-ascii?Q?oS/px8i8po7hyaQM7/re8Ew8e8+ZTxAnZ1L+wACfOvh6PybyDENPzWrXUGFu?=
 =?us-ascii?Q?5brzNdDxIfug5KC3E6tpccE0K6rMyzDVfdPm0KjJ+K3IkLEVzuByQtfTjIe/?=
 =?us-ascii?Q?UkevulzHIwe+JAIZDQcRLLees1Hx7fv8I5a/GYWfmL7O9yyMXCkMgTASrQxB?=
 =?us-ascii?Q?bseRrf9Vx6gM0oWZKlZNmlP9slWuGzkwgIsevZBu+kjH673uqMGRbOcXwyUz?=
 =?us-ascii?Q?u+Ei19wKKofxxgi45HT8v9NBqqaKy5skdodC/TOpisLb7r4zY/SqHPG8j6YO?=
 =?us-ascii?Q?+GWxpdkSKEcio9SNIxCYBL7vUwblPUR3Je8riabS5cW9evhKt6gYaaQIi4Et?=
 =?us-ascii?Q?4y5kjCm7HQywRunUSInBMyhpguhZrfRRzcirmn4C+R9PE57l1CrKO5iHsZmi?=
 =?us-ascii?Q?u5NurSByHhkUmX9zQmFI8OInz4E93eIrKx8OudUkhj7tpA/0NjcvG4qxA6Ll?=
 =?us-ascii?Q?yPOo6r65G4+eWvjVyUnZee/h4gM3g8uQrwa+dxk/1TyBw8MCS/OXwdFDraj6?=
 =?us-ascii?Q?KeRDvQzApm0Yem0LSqqmRICMx6u99wKxtNodY7iwVezZHU1A+wjfPt2d56Cu?=
 =?us-ascii?Q?XUs/MunlIW3ST9t7SG/3RHU64OrhgmBQvBRm7qsqDcQoMeR1aSimuIGfaECC?=
 =?us-ascii?Q?p21HnSQvF+FaiQEgA8NZkDJ6PhzHm5DZ4tIhzHC2TbMerns/CR/mKD8T+gqb?=
 =?us-ascii?Q?6KD3/ky7QjBUqJTRXCtyaOs4swUZgCSw7JdHugk1HrabVkVb2qumI3mpxyNv?=
 =?us-ascii?Q?zJni1PI5l7Zojced08s9PRbVqnbTE2Q4qFoCC+5m8xHK4+B3aDcv6Uuh3SZ7?=
 =?us-ascii?Q?H66WLCxlOVo8SYG3EqoPNwLG+tpWWx0QPm9XUpuUAfFrSqUFdm/hOB+CJMy0?=
 =?us-ascii?Q?9Kq3BpfJ5smut1+WPqkT0qHyflDTQL9dySzBXW+Bap6EY+BrWvrziZGb7wtc?=
 =?us-ascii?Q?ywhu22mLWPnPOWOR/i8RNdM/MIovRKs6uid5VsCWmZCfNHPzc97o3yHxdMsF?=
 =?us-ascii?Q?Km+N4KEOieRqrM8ns1cZDRwp4uRiWUO0/ar9AvI8/u/dG54w1SSYt6Y8j/UD?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qd3fnov9t2N0/CQ7Zc2rk6xNdPUEc01NAt+KV6CdXQEj8d1F/5aKDDopWH9Dij9o+M6VBmbmFFCVwfG7UsBNvmr6i5h8r+VeC4zw+7BiZ8BBtQ76Wq0WcDuX1ixZJG2CLWGZ2EUq9q67oL80WkT+K4JAllDPO+hcofUk3QgDSfvI7Dv5+ItJyOHmtpkpcoZaD+NGxwkjzVcznh0t8RQTPRuzlpg2YhKfTn1i+i9I9QgyCpVP4Ax+3WhaA5fraarlBxSvESmdI+qG1n0+GwnFhuBXpdNDmAwnTx8gjL4qvtl7iitHG0KRw/UOUo+FOVBWJ22WQJvoj1WpmsCaLSlF+RI4r4FKqHQCUv6FIuk56aZTS9HEE8+FRDXnwEbuBriKhtMRR46VtWcJ5LILieuHj5bKPPftY9rQ1X8PrCOgRzdnj53+8RsMcq0s0d6cMffub3+7V1+mOD7N7LTvre8xLpJ2WWZNpYCHkn5LKQV+y6CA0T1D56QEv9MwjIqMpK3FInOy66fg+1WVITjcKg6lSHIHBvRoW34Zf3h9+09h5ctaTV17MTjre4fEtDPgoa87PyhyB0FrH1XrKudkdJHf6nqQYYwRLJWUQy42ExZZT2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053bf513-18d8-49b3-fd63-08ddd27e864b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 11:11:41.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aH1LvMhkLgLW+r/ouGA7qa+v8IfJxzTpbM4EqXhzYCL/PAv7hTd52mVEliP/SwKyAqFZ/r4hz/fcu/24WN1rpZlspIKFu9tcKBFKsojt8B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_03,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508030076
X-Authority-Analysis: v=2.4 cv=MdNsu4/f c=1 sm=1 tr=0 ts=688f43f1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TOQy-bbVWrDZCRUw6Q0A:9
X-Proofpoint-ORIG-GUID: 4KUc-oRIqu_rNu2R6nvZZ9WNJM4Em0qF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDA3NiBTYWx0ZWRfX8I0KwWcomc+e
 eFOcg2thtdX8OFvP3GVD5USTcRGrh+YIMNmn00XIGVxiwh7NhnWL9rlSCReCioo0lcRYX8t3sm5
 5mi822kXK+wFI9AysVmkhmfm++KhAZe2TieJ0BImDOpa41yL9jJzW3Jgs9IlEiSSR9MXxjj/06D
 iRQkwSdrFb9EO9Y6sbE0HvDHVet2vD4dKcU/TNJWZ70BzReqccv6XGqOM5Bn3UVLxfIrdHTkEhw
 t/5oT+qg+x//FEOl1WxYzYZ3hUk5dRSA+BHhOCeksTRvpjnJZEi4uBVwmUaRHxoHMRLHCIjoMrE
 /L7HpjhZ8thjZRkxdMX53vbzCpiXnXtNz59agAb4vVdyIreigJYAdAu9htp2UjS+ruxwfquZHV4
 qStJZTh4560QGwvA1nRD4j4D6TuZOSssZUvonJ0JTBn6dC77L/hpdlOBRZqGGBsHHxT4tP/8
X-Proofpoint-GUID: 4KUc-oRIqu_rNu2R6nvZZ9WNJM4Em0qF

In remap_move() we must account for both a single VMA case, where we are
permitted to move a single VMA regardless of multi-VMA move eligiblity, and
multiple VMAs which, of course, must be eligible for such an operation.

We determine this via vma_multi_allowed().

Currently, if the first VMA is not eligible, but others are, we will move
the first then return an error. This is not ideal, as we are performing an
operation which we don't need to do which has an impact on the memory
mapping.

We can very easily determine if this is a multi VMA move prior to the move
of the first VMA, by checking vma->vm_end vs. the specified end address.

Therefore this patch does so, and as a result eliminates unnecessary logic
around tracking whether the first VMA was permitted or not.

This is most useful for cases where a user attempts to erroneously move
mutliple VMAs which are not eligible for non-transient reasons - for
instance, UFFD-armed VMAs, or file-backed VMAs backed by a file system or
driver which specifies a custom f_op->get_unmapped_area.

In the less likely instance of a failure due to transient issues such as
out of memory or mapping limits being hit, the issue is already likely
fatal and so the fact the operation may be partially complete is
acceptable.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 46f9f3160dff..f61a9ea0b244 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1816,10 +1816,11 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 	unsigned long start = vrm->addr;
 	unsigned long end = vrm->addr + vrm->old_len;
 	unsigned long new_addr = vrm->new_addr;
-	bool allowed = true, seen_vma = false;
 	unsigned long target_addr = new_addr;
 	unsigned long res = -EFAULT;
 	unsigned long last_end;
+	bool seen_vma = false;
+
 	VMA_ITERATOR(vmi, current->mm, start);
 
 	/*
@@ -1833,9 +1834,6 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 		unsigned long len = min(end, vma->vm_end) - addr;
 		unsigned long offset, res_vma;
 
-		if (!allowed)
-			return -EFAULT;
-
 		/* No gap permitted at the start of the range. */
 		if (!seen_vma && start < vma->vm_start)
 			return -EFAULT;
@@ -1863,9 +1861,14 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 		vrm->new_addr = target_addr + offset;
 		vrm->old_len = vrm->new_len = len;
 
-		allowed = vma_multi_allowed(vma);
-		if (seen_vma && !allowed)
-			return -EFAULT;
+		if (!vma_multi_allowed(vma)) {
+			/* This is not the first VMA, abort immediately. */
+			if (seen_vma)
+				return -EFAULT;
+			/* This is the first, but there are more, abort. */
+			if (vma->vm_end < end)
+				return -EFAULT;
+		}
 
 		res_vma = check_prep_vma(vrm);
 		if (!res_vma)
@@ -1874,7 +1877,8 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 			return res_vma;
 
 		if (!seen_vma) {
-			VM_WARN_ON_ONCE(allowed && res_vma != new_addr);
+			VM_WARN_ON_ONCE(vma_multi_allowed(vma) &&
+					res_vma != new_addr);
 			res = res_vma;
 		}
 
-- 
2.50.1


