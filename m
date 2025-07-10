Return-Path: <linux-kernel+bounces-724724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2838AFF63E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D842B54223E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F58266EE7;
	Thu, 10 Jul 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QoyDsjO0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jMnrEhXy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96E264FA6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109215; cv=fail; b=CPWST4yXkkgXikTFy2a5kguO9vU0JkIhTOvFwfBthc93vj5TuyjtAyC6HeiFLQ2WNc0POOCvBtG4F8Lvo14Rmi4ZbEKxphIcPEGBa7tc0aeddWX1z5RVtCXFus1WCXmxpItpdFZxQ1VyxPi5kW1tkcXX6xsFxwv5nWy3lWESGjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109215; c=relaxed/simple;
	bh=KS4uJJf9FImof+9KQywDkzd0+xDApmQD8ZFstVTZBN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gfymg1I4XsqM0szHVkEeYBKTBRKmV14j4/gUxrZ0+RAs4pJ7yPSmT3jZ0M8wJRMAUuEy0yp+Y7xYq4Kxxfskk2LZjsce+d6zm4/kCzZ3BMSCWtqZ1ONP9vlpsjOceVnMVXU2LN2Q4lTXVPuWpk9qbnmd5hC2IaJFl+DXuBmrl78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QoyDsjO0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jMnrEhXy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0H0dT019129;
	Thu, 10 Jul 2025 00:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SFzL0eMlDagqG8aPGteUXR9QroP1knBNBUpBZxjCP9U=; b=
	QoyDsjO0W6vLyiarW6ONnjzAX/IR5YIxNgQkb5OEwx/WQK6BhhcYS79dOk2hynNp
	S79dnKgUgrWkJTnNE3RZ4zAeAyh8uDTu9HOD4IU7Ef6yt5meyvQaSJnPv4DLqqKU
	JQmIpfwVHebfqu7EQFj3qcLyptkwW4475SEsO3tHn6WzEur0qG9dXt4/Sz2zqFMH
	FtNFkq9XRKYpxvkH9trqcO1w1jymp1zW+SPlHtxoTG+adaN3YKhqo70BYy1wg4vq
	Xh15slvmPuIXRqVK5/G4c9MAHw5AFGgU6j28TvSRwu1k+Iff32qF9kRqXbBT0idt
	Tp8AtDOcBqxIsRHCAX7nBg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t2u581nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569MFbRW027404;
	Thu, 10 Jul 2025 00:59:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbmryr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDQF/u1ID9hVtnqpanwUAKig+3kNHkPmXXkibZ4ZTZjVeiEiB/gwI5Afpac31tWIG6ngFgz7ikB3MP17Y1J7A8PZDuOI1AiKNNiiTm6x20w+YbBeyfHx4DZqJkbFbwA7EyueB31ieKLIHTOcIpE8t+LBLNmHD9efREjsEGjeKR2FsOnnuXa4DwfUeKWTuT+YF7PNnV8mv0GwFIwR3zGUHZ7SXnNq3J0cuwpUE0/eDy1MSzjxRrJBPcvtHofDLKACNl6puezhs7f98IRZwy3aIxNsgdrnnS+6sLX/33gs5i8O7qROtmOtqBqsCNtzxFcOW4MzbuqGzVAO42VA9QCaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFzL0eMlDagqG8aPGteUXR9QroP1knBNBUpBZxjCP9U=;
 b=I4GPNST/4euXRiaOV9ohI0wf9RwNsXaLGnfcPaPRqVwAKURVQkO5yK2O/zh4JWecjArVaw0x3HTcol/8qpHs57NT2H4NLKx/aaBt2juMrhUDAx+6LQQh3ynT+HLPLHSTQy5F70ZdNTd2Hr0nnKnNv5x3jX3g5OXuMV5sLpc7/kUNcu8qYHDfnawrkD2swj4gA32jHdShvt/qvgQKNzemkR/pr0DEVfpqtowu/HJx+ZY/DUOm0peUkO4pYPP+Jmjn6F3Iswzag4khuq3jhU8uIszE0EZY5UhiJQO64U67uJEwiqnejP+SvphORYc/9Tw8R0hm59jI99/Lbqicdmm/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFzL0eMlDagqG8aPGteUXR9QroP1knBNBUpBZxjCP9U=;
 b=jMnrEhXyWVfZERxes6sJ+slK/T5BcgfDK1vYiCv15oWC/n5d1gsvTG5cnbl4ACYiYV+Saohkc8Xr8JK2xik8UME32bKUhWj3Gt8lXIVzuYKQNqU5VqphPQR1dHsEu7tQJdcRxv73inf/ATkFwrC1BMDioS2WjCs6JiteCTP3+ho=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 00:59:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:43 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 07/14] perf bench mem: Allow chunking on a memory region
Date: Wed,  9 Jul 2025 17:59:19 -0700
Message-Id: <20250710005926.1159009-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:303:b5::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e06966a-0dcf-406e-3985-08ddbf4d0e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K61Jr5i0JWiGou82mebt07oApF0AMWftys81f3T99V8Y3ExfMINRV9PnHdHC?=
 =?us-ascii?Q?wk/aohSL/yogBkxq4J7T7/MHX3OiFgP2nEhymByW2HUnlQxbq3de/sZnVHrF?=
 =?us-ascii?Q?9OjFdw7se2LhymzKSZ8RepM3bFnQe1ml/S1ppivvGGQRRXnVDPuh+apQMcBw?=
 =?us-ascii?Q?XcBbqeiFWS1HNXh74y7kyAHG4sSU9nlGMRurbs2dMoW69YxYRjqvdueCVY3Z?=
 =?us-ascii?Q?IiH72/C3Nci0imgcKzYuNuyTAs3pM591GV0bQ1cAL4s5yoSphXNr7ATV/Wnj?=
 =?us-ascii?Q?kQMK1N3MNc3R8is3+yw8cyCK7+v/ZHh3p8Xgpw25vb/seW6JVN3jC39D/I7T?=
 =?us-ascii?Q?prn80z2uGDgK5bRvBJnwRdCbnmtCX2TCCHP1n9GeDkYhQudyLTryhJ7vc2ag?=
 =?us-ascii?Q?DADtHC0/UIJFqeK8Zew/fyXpHqQGeq9eecQOGHqblMn8DAEElHMIU1ow0WWQ?=
 =?us-ascii?Q?Z3u4X3274X2FEIjfY0BzJG+j4M9C6bvkLpubgvaOuoxp8Ho3LwYyB3k87ZH+?=
 =?us-ascii?Q?hcoozJnWkZWmJeFjYvXlTDufS50h2LYFOFlzUP6Nh9jyDhyqaw3HdWTM3mSP?=
 =?us-ascii?Q?FuLCXn9gbXttiXvDS4HW4WzOkFTS6cmsvGK2//shtoVwQdt0aJadLE+quCaA?=
 =?us-ascii?Q?l45juRnbdtbB3Hqr58jBCKl6MbPrvRuKc/G2DuPFtnSnRDSkRibEuFvnywfk?=
 =?us-ascii?Q?qzRUOWgWTEZd7nM8L2P+XVDxviC7o3ZwyT77V3rDULUpPWH1N4tgi4OO/HUz?=
 =?us-ascii?Q?pdm4/+l1wwrPhxE3JzhEAO4zZG+7UpIINkKrxJU/+f6DMTqoryAJtumu0CAj?=
 =?us-ascii?Q?9+Tfo30ZrrbYAv+JJ1rKhjkSYCZrSbxkGjymQN+kDLQtt9x2sF28c5eKQdxR?=
 =?us-ascii?Q?SHFsAbmaKRi1sxIJq9xwVD6ooGZN2pNEmn9Xsy2VYthyNGmegq3+VyqUnEYw?=
 =?us-ascii?Q?7OTS6NAtMy1bD6tk6iAwfhYpxKzwSz2MMUd0QU19U4Nkc40Gu8meuDm06o2V?=
 =?us-ascii?Q?d2uZuz6WooIriVw+87FK8Ifo7FQZ0mmpXQo/wrVCp2qxyb3iQH8d7VPPnaUb?=
 =?us-ascii?Q?V/P6zEMrp2ERO7bghz34WYvFQEnUPnhGX8RJmkfjJK3D/X8QAUEW8fv+qF6z?=
 =?us-ascii?Q?OL0q7IsFE/AAT9NYKa1Rra1KlSRI4IjUFpk5deM1rX1XIJOrOfDSmoHs+XFN?=
 =?us-ascii?Q?DovoIb2PGASGSdK3QSgAGwDTGEoGm933Sey6nN5bJfL/6rc0rIAoeC94Uwsl?=
 =?us-ascii?Q?LmT/6R2O+dhzzLLpwAnEqORv7aj9UUGEqlngGe70MdwHqdZ2dImRcvG4e0f9?=
 =?us-ascii?Q?XvXLch5VPtFrKEQhPDvCoRUzBC1fHh5JGoVgejSLhciHO523Mqo7mhi/vgLw?=
 =?us-ascii?Q?2YjaoDVZ+ucratksciYNCOjBVS2rbJT1AKamwv+00emKUnGTNBIJ/KjPJy34?=
 =?us-ascii?Q?rL8I0ybAqHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kjVFJc1yVpbucoV47g6LyUh/BrzNX4Cv0Yz0/eHQLZOR1r1B4UetbtoE0l6B?=
 =?us-ascii?Q?65kswjwvh/JG0pJcKJcfPwKF1rqRNWanqnaCVq2USRUW4R2HYpOj5Oqd3YYp?=
 =?us-ascii?Q?uQT+1+kRiWVG1NgJqThMMQvA0LqDzTzqzQnd5R3BNa7p4tXeBANcc6a6pTYv?=
 =?us-ascii?Q?CRuwbDM7p9H7f15PlyE1Tad9gHit2MgFPjea9NQndrqqMHAhSJL0b/OLbhkL?=
 =?us-ascii?Q?By4yxLFfJV88m/4zmHXlkHNiUBt8ApVfRbkjne3v9zAsuXJvSh9uG/LjNvBT?=
 =?us-ascii?Q?OolyEk9YQ7bLJOosNn0GCHo1cU0jApAV/OwBOf2oOUPYkP/q1juWRTJ4u+4z?=
 =?us-ascii?Q?i6Ipk050RrHWaswm4QbZIG9f5FUCFjgnd0Lc3k/xTN9ewPVoowJ6a2ftzV6m?=
 =?us-ascii?Q?vS/aSY94TZ6EQ4kGxxMfCvedwKQ19L4urHF9PTGi+IbC88w5/XAQY/LVc/Hi?=
 =?us-ascii?Q?WzAe6cQIv5JlVfNSyMLGgrj71SzXZ7NdcdPEHU070zNOIF9b93s3kEoG76Vq?=
 =?us-ascii?Q?lqYmEoC6WapqV/shtg8/xpwCLjEwtvNWR2PkHsQSPdHf+TogJeo2Kii5i6BD?=
 =?us-ascii?Q?0lFyZwdNOnqv+E06xb6b79POEqGWFkMDQweY5+Zg2y0vbkon3hoLEKJmLy6M?=
 =?us-ascii?Q?zDIhc8TE7Q03lHLCZmDIkJnIfIdDEx/WC7cHxysSB/V+4j9yoVgSR4rcI5B+?=
 =?us-ascii?Q?P1tRqKEGrD4YMYbpDaME5SKoZHJACMwP0zZ68Sn70DYmwADfNLMNnbqwgg0Q?=
 =?us-ascii?Q?qeVIjZ5+PS1nzL5AxIAAsgp0nbkAlVqn5YXPq8Y+iU2nACe41VnTbaOitlFU?=
 =?us-ascii?Q?wSzjVOKr7692nW1yXF/N7BoZdS9C971E7rAN7g2A6y2r+MHBaBcjg56szOmU?=
 =?us-ascii?Q?BogOFxwfvq5kOG64VupYl23fNJri4rESwYlTA5iOxGuKNShL/C38xDBhgOiS?=
 =?us-ascii?Q?zfHVJDjZmOcjbxnKsBlJgpWVIKfmyo5+TBkd9gFQgqpXPqdTgusPBqHTt/4K?=
 =?us-ascii?Q?FbCTiW0aI9ja7TcnIBlotx5leyHsa5jdf2b/yzTBFnS27f+TW2Vo8kPiMxpq?=
 =?us-ascii?Q?VGRQ8v+T97tBX6IoDT3m2B+eA0P0UKnq73rVKcR2aBXrGHJPHoG9caWqA+0U?=
 =?us-ascii?Q?dqg+RohuHPD8XVlNmGo5G5ve707WqqAtpsPRESyzOppOBcZ83vLGDJQ/CanQ?=
 =?us-ascii?Q?PYLstDi86o9FrTbgVUWHhAKvGkUcJGUdadAdhl2b+G1M6pTjRSwIG4+e+tkr?=
 =?us-ascii?Q?uhHUtRYlv0K4brhLma/u4zdqQjq/U2U9sEOt51GltC6xHwJMcbovyH+zA91z?=
 =?us-ascii?Q?ZB0LCKse1Cm9Oeq4bWDGHo3L7tGD2q0dV9L3zO1trwHFi+xhPMi6cIifIUug?=
 =?us-ascii?Q?PzMXASJTID/qL9l7qF3A8l58s6e44T8lTxsh2I5sZ7MIYe5djm4xKlnoSNzs?=
 =?us-ascii?Q?fNKrFpY4ko5rTFZKIUiFWA93r5e/r0EOmo7Oj7ex05l8RDbjSyrB75dheclH?=
 =?us-ascii?Q?Epcx6/Gs21nZs11/5EDpdToXZ4pq1QxFUeyVNBMTyh6GPd5FwNhfcHktWYeL?=
 =?us-ascii?Q?ySPuHGi7T0eiuVxm3/jSRgKvKQuaQvqzHj5k0EczM+Oe3d4FUpPY0HzelUnU?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ht5gmY5yKx8c6gAljCIMt5KQUYhN0GpFiQy1eg9KfoQQWGP2a6y0+SxvtCXEd8hYFUYX66XNDS/GDJWi4l0MjCppQaypr1h21TvIQLl+mp3XV/2T7Nq141MfUFk5y0IQkqACaoqILDosZl6dJboAe1jVYzQzlfeyxeGpg7j1JVa+knh7loSFlVSxN7ZcfENsLt2ZafeKu+AI7/vayncCWGbvQ5+8Ft12TSJ3FB/acgYp1+g+AX3oXEuwgt62BzwLmnlLGOW8am1ehIuUdDNayqXyJlWVnRYad+yX9yZ1ugXvBfh7PgQzHDLs2NTQ56NCJ0U1tYvnwn0HhijXZZ9lZZjfpysxdTzIj2GYGrr7KmS8bSPc37wmf6vDalRsLpuNUSqHcW5WjgynnfFyvcMQOJKU0zrXcLHnfDaYyep+XT4kvnGFHSBmbiRTCOABpPm6ju00/7roxECWTVWemWfOF7DNG/DCL5yMRRLeLB4Ao3GZU9VZzngZnsQ771y7RNLORVHgVqr0J1Oxvus0ro4Qp/WqgBzEYqeoU4yVU9tP4eEyoSXGiZLVjyEGxV5QcGllmRBN45vsdA2LDOcFQQpkx1snIDMDZae63ukNk8DRuhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e06966a-0dcf-406e-3985-08ddbf4d0e91
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:43.5267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2xh1KjUgFlnOMv+xWQ3LyasIwWdBlZte2yaOaHrVZj7GMrFL/6mOWa36ZeJdF2KZAAxJIi8fbmvCNT3/uu0WTEmxxNaQJZpB7VLOdBIELM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Proofpoint-GUID: iBE2-NeX_LsuMbWhrmkbjH013nKNwzXh
X-Proofpoint-ORIG-GUID: iBE2-NeX_LsuMbWhrmkbjH013nKNwzXh
X-Authority-Analysis: v=2.4 cv=Av3u3P9P c=1 sm=1 tr=0 ts=686f1085 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=j3Oc6Xy6ULSXj8zZAogA:9 cc=ntf awl=host:12057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfX9k1n69o+cvPG Ckz3gMEw9lFCAHHoIsPnjCIUAfnvmJCJvNbBrVYZ0PccQPn4cqRMtqKIfGUr3DtQmYCigEcBtvC Sy+w3HJayIlnnsIQpeEqSzSmguCYRmE3/c7Vs6ax/Q4AEpBujqwbS1tM+dIG/f5m2RYHgjyuWHR
 IY0x3nG1PNSlsv3yn+d/1nPSYXSvkzIMb235Al8TDNTsjlf8c3wW4gYjc74phjr9q5mSem19dsu qUX4oZU3YQOwRCGLj5XFteWzOOs/fThayfqFAeAStvupBTFUJmHEbedFQTpRTynBH96upHJ8TGL 4yUuY/Zu83S4J+w6xjFbBPQwRehUdjtCNTM3VYIh+uKHusD2H1gpqMqg9s/FPnrwDjgg4UGSZTh
 VtxbktMVasRA+gokcQaIOevrVoCAxvenyxYAXmwIXck3tjvkbi+siHNnIELW+eayXo/SeJsQ

There can be a significant gap in memset/memcpy performance depending
on the size of the region being operated on.

With chunk-size=4kb:

  $ echo madvise > /sys/kernel/mm/transparent_hugepage/enabled

  $ perf bench mem memset -p 4kb -k 4kb -s 4gb -l 10 -f x86-64-stosq
  # Running 'mem/memset' benchmark:
  # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
  # Copying 4gb bytes ...

      13.011655 GB/sec

With chunk-size=1gb:

  $ echo madvise > /sys/kernel/mm/transparent_hugepage/enabled

  $ perf bench mem memset -p 4kb -k 1gb -s 4gb -l 10 -f x86-64-stosq
  # Running 'mem/memset' benchmark:
  # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
  # Copying 4gb bytes ...

      21.936355 GB/sec

So, allow the user to specify the chunk-size.

The default value is identical to the total size of the region, which
preserves current behaviour.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index e4d713587d45..412d18f2cb2e 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -36,6 +36,7 @@
 static const char	*size_str	= "1MB";
 static const char	*function_str	= "all";
 static const char	*page_size_str	= "4KB";
+static const char	*chunk_size_str	= "0";
 static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
@@ -49,6 +50,10 @@ static const struct option options[] = {
 		    "Specify page-size for mapping memory buffers. "
 		    "Available sizes: 4KB, 2MB, 1GB (case insensitive)"),
 
+	OPT_STRING('k', "chunk", &chunk_size_str, "0",
+		    "Specify the chunk-size for each invocation. "
+		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
+
 	OPT_STRING('f', "function", &function_str, "all",
 		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
 
@@ -69,6 +74,7 @@ union bench_clock {
 struct bench_params {
 	size_t		size;
 	size_t		size_total;
+	size_t		chunk_size;
 	unsigned int	nr_loops;
 	unsigned int	page_shift;
 };
@@ -242,6 +248,14 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	}
 	p.size_total = (size_t)p.size * p.nr_loops;
 
+	p.chunk_size = (size_t)perf_atoll((char *)chunk_size_str);
+	if ((s64)p.chunk_size < 0 || (s64)p.chunk_size > (s64)p.size) {
+		fprintf(stderr, "Invalid chunk_size:%s\n", chunk_size_str);
+		return 1;
+	}
+	if (!p.chunk_size)
+		p.chunk_size = p.size;
+
 	page_size = (unsigned int)perf_atoll((char *)page_size_str);
 	if (page_size != (1 << PAGE_SHIFT_4KB) &&
 	    page_size != (1 << PAGE_SHIFT_2MB) &&
@@ -299,7 +313,8 @@ static int do_memcpy(const struct function *r, struct bench_params *p,
 
 	clock_get(&start);
 	for (unsigned int i = 0; i < p->nr_loops; ++i)
-		fn(dst, src, p->size);
+		for (size_t off = 0; off < p->size; off += p->chunk_size)
+			fn(dst + off, src + off, min(p->chunk_size, p->size - off));
 	clock_get(&end);
 
 	*rt = clock_diff(&start, &end);
@@ -401,7 +416,8 @@ static int do_memset(const struct function *r, struct bench_params *p,
 
 	clock_get(&start);
 	for (unsigned int i = 0; i < p->nr_loops; ++i)
-		fn(dst, i, p->size);
+		for (size_t off = 0; off < p->size; off += p->chunk_size)
+			fn(dst + off, i, min(p->chunk_size, p->size - off));
 	clock_get(&end);
 
 	*rt = clock_diff(&start, &end);
-- 
2.43.5


