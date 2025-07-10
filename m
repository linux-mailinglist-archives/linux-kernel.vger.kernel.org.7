Return-Path: <linux-kernel+bounces-724722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50AAFF63D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7233D189ED60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3900125B2FD;
	Thu, 10 Jul 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F+RBI55x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JzOFd/CU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7125255E40
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109209; cv=fail; b=VmeCRY99yKz3NLL+3fIUxmBNhh0S+7Kt8svP+i7WL2NO0CJP7xMOcbpzeYXFhR6lAUrPFAVbRP+dAloJtb4JAj1dSeQT2wnGg9nHlTn01Fugot3jJtoSgcLsQ9Bn7WjGbbY66flsaka7N3I7tDS+3kXepd/+krlFSnc2IzXj85Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109209; c=relaxed/simple;
	bh=u3GofZSg/lf73Wd+T6BP+Vuvjsjk7h4F/Q6LAtVfjJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R84oTCan3tCvkFDW0uzIP7jq0ax9pBeMELa7TOVZ7KlFhRuGflGj44+2fw4hKcfdIaQIAbBY58TXefmrBobDYqK7ZtZXxCqaEBYNnUK5R7jW/3l14cnj/JzKdW6EzhZkhgpfk4TYWagb6ayd8wBiP38J405Sowaen0c1GT4X1v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F+RBI55x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JzOFd/CU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569NHVm4011369;
	Thu, 10 Jul 2025 00:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MkyBUNoF5MSoFFldrAzDk9FWHt3zMxq6uzVA1L/+Ed4=; b=
	F+RBI55xRUyxGDXG5xXcXSUOufuY0Wi3dTIBQZc8jlKuhScBGXFdWXWgTbpsbaQs
	R+cc+TI1chRPJPJmFhzeORlcG8kbmgnweTRdWoZMuRpCcntbPbSw4ml3SKDVcBU6
	CpKjaB2UwD6BcF/OLcOPh7dVJ180vhRH/Scig0ApxbEWPLzpTjD5n0uNDDmujo8V
	F2/YywC1V4kzmujCK0Ok9c3hWFxIzllPwAwS2fVB1ZOlyUBdzqyEpSodm1RhnK2K
	v7/psINQUTJwkgYZ7MkEi/kG3UemQONrK28LJqJIT4cp4M5/j2H5WVYv0pLkPVwV
	rI91Jk8x/yHHRi1d7oTQpw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t1y103du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569MFbRX027404;
	Thu, 10 Jul 2025 00:59:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbmryr-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5XRjGDBlQ5bjn2b40+4DXmB4JOq1EIZu6d/9B2ptjRi8zzCN/YL23f750SNiuoLUAYEonYzcjO5CsEIhOD/LfW36o9nuzveY0p3YL7cJSag1x9UpVDGfFr2QnfA7Ql6lYURzVqLURXmfeoYkeUNPwZnT5ME3rGfaSCKibTc0qFYvysk2dIW2lt5YJKb1AczoaI3C2LXMNifpdG4H/6El7FMglv6Ywd2FZkzG3vDysLc4gHi8iurkPjXiOp/WMuOoqUcPZXqN6ZG4ZcZ0U96/0v6e/2R6NaoUXDFo8yOintfkXjYNraeNgskCKDBpnVJA3J2J1hSgZGftMEWuwqYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkyBUNoF5MSoFFldrAzDk9FWHt3zMxq6uzVA1L/+Ed4=;
 b=QvNZxiqFgXPwo9GAs7ytC1/C8Ids+C2xYNvuhS7Rl5riX2MbZy+vIFihSHlwIo7KpACcLQpHyb6FHybm9R3GkVXZ+yBL7aAYRXX5y0DyJn1MHb7TBzZLUNGMFwWbYw6TaWaWU2WpZLEbcu8Rv2t1qKzyOEZLheHW0EJfOmXTk1Arsfj65VwViQdI7E998drOZvFiWTwGRnfbgYLPB+ggbEq386Epz4GjiLQyN1L8krjZ2k5vZgWTqp5+YOQ6eBdQOfCqLW73imWLi7nkOlxDmargtWFhagGKPRzsEc9kDLUxTpdd76BaFpXa2fr+PSmoM0vxVvScY3SXhPNNm7WVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkyBUNoF5MSoFFldrAzDk9FWHt3zMxq6uzVA1L/+Ed4=;
 b=JzOFd/CUWAH97zp1e16oOvhWAZavLs8cQT2ytjYgpIepcTAJaUaTcsOj+3JsIAkAJFfSXa5v4M7Js11/cjuAaibC+JrBU8PL7c8I6K3lWKZWhgJxlWuUWeHmjsdpTADsCuyVUsqv/ueKbtla+PPxBsyeL9xWJnDY4+bu5nDXvkU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 00:59:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:44 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 08/14] perf bench mem: Refactor mem_options
Date: Wed,  9 Jul 2025 17:59:20 -0700
Message-Id: <20250710005926.1159009-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b9c5b6-69cd-4b27-e803-08ddbf4d0f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6O0tMFoF26UO7BR7gOt9OGq1q/E6rw6jxJK5OUY5eaz98B1YcdFof++uWBBN?=
 =?us-ascii?Q?+rOBhq5b21ek57wSkBgn5/oMsRXMf3haTXVd8ftzOvasew61t9hr7ptEdsMS?=
 =?us-ascii?Q?9QFAeewsZmW7s+sqWA8jxQG4PBtW0TEkrCp0uqvk8W/Nvt49S/ESiGcM6KE5?=
 =?us-ascii?Q?iALajXHbD6pEQfUAaSrmjMsm82FDC5vTd5TLVSqKsu5kBjxAdWa2MEp53lxc?=
 =?us-ascii?Q?fPZfYmTHbn/3t14K75GBuDUKmTHlRj3hrIyOvDdoJtC12PT4SrecnknpV6nV?=
 =?us-ascii?Q?7inv9sC8tZw9bKo99Ke6K3NfF3b03z13qO8zqqaS+wBR08Gby89JpM2qqlww?=
 =?us-ascii?Q?e9TzvpbSG/+A+umyv7lb+YiwMaAQbYLindw+GIkEAkl5hwnHZ5SHxD/3vHg+?=
 =?us-ascii?Q?vtYy8E0io8QajpjpdPXqz6oYcxhTTViNzApjcjHqqNV4oTqh02Kw/l+u6rEe?=
 =?us-ascii?Q?hY/2GMhxA2KU8LXDchJwPBvnDoHJ6hhknrQ2pUR7pu7TsRASoOHlXZTzCHVu?=
 =?us-ascii?Q?UaSK4xXbMnttVnTIzxREkYmR8zRdZ5FYJ4iSHwhDqtnwWb2D7EwP4xW+sMcA?=
 =?us-ascii?Q?tKD3QkZI6puzQu1yskZkLf3ENep/HKpZI2DRfdwUzVUA7UjjkCGGP6MdAEAs?=
 =?us-ascii?Q?XBtB9SHublXCkS5oxUnxX4zo4kVvdQrWOtBwWAY0KLzzITb2Pcv+0W47UpGT?=
 =?us-ascii?Q?cNlDDbLaeObXiZHsH58UCuwuEvfPxsdIaTgTZeGFGwqz8Vv+t2hQjWOfU9uM?=
 =?us-ascii?Q?uJTcZTZKoqm7X047LvMxqp141SOhnClXT3C2N6E8cyyjA9XZnDd3emX2nMlH?=
 =?us-ascii?Q?A2yBYWan58WZtu+X4ommB4u2AfJ1ZCavjCHR6xysnHcHGlGi8BVuXNqN0cKa?=
 =?us-ascii?Q?IlPBzX6IWK9bwYxwA/fpOuYfCNW6h4EdyIYSutffFv8yUQVRbZBWc2tWkoSs?=
 =?us-ascii?Q?eJs1BDwwEmjrnG5spEscYaaLyOhNMJi91YRNhh/+9Xvo4nk4beG0maAZTsa4?=
 =?us-ascii?Q?VprNN5KL6GdNfSPzVXL6X80jFiEG27aFAX4C/W+C6hyj7IPsMf3NXa4iq7md?=
 =?us-ascii?Q?KWyQNdLShL+BIOw0OfdOgduxJjuT+biFp7MuWtlkIMPNdJzamHvXfRE76s13?=
 =?us-ascii?Q?MRE5C1QWZdJDwkNg9EsuNqD9M6F1gAFCUeQkcSWReSqEQR+KWYvZNUsBVtWJ?=
 =?us-ascii?Q?ACCScNcH/ps3pyE2PqwyNOMzZDNxxf6jQMqX79JbNE/78zJJPNRhSlcBLh23?=
 =?us-ascii?Q?CejfwqwpcqqGht1DKA89xNET3GzEUxId5YGrARUKFFpWFwuM5fRW+c2IaQfA?=
 =?us-ascii?Q?5miHBNPyDhCAp/hBIMsgSj67QFDOgkaj9gtx3YP2xUCkYWwYYBQCZKvKaWTk?=
 =?us-ascii?Q?k72pbBQ4ZfZUhOlr6Gjiz16IFnZE2lcXv8wSYHWWJfs2Q9xTy1tjYe0btx69?=
 =?us-ascii?Q?A9DTGJ1IjPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fe4U/gpMtj97Y3s7HWQSrF1aORWzGBUP136NIWHB4G9DXHZLIYm6pDIMyDlt?=
 =?us-ascii?Q?DkqVMnxW0k9rAHeOuHKc/xMvwKVjuqFGPPIpXZNTYo9n6hItG+6AomfhCyhv?=
 =?us-ascii?Q?DwqWkuZIkbcRGlinhRnjRUsBKAmHnfUqhHluZlF9llGBYcKUT3p+bKZho2xm?=
 =?us-ascii?Q?CCL42ntu7VCthfqvSnlob3TBcQFdGhhtizIe7AY5p7SEZTF7S03k0wuBSTTd?=
 =?us-ascii?Q?keNgcjmglDMTSenuPXvCNWfGyO8SRswEuV+MQt1YPxPsVdbNGGQn6snFM5KM?=
 =?us-ascii?Q?1jBLkIw3BwG0zEOA7U98+WN20oEOYj5LKrYvF4V4sOxEze9tltwAhoS83HEb?=
 =?us-ascii?Q?Ey3Tzjus+FV2Tm0vKaeto3XY86384vmoyXT+bbHh9dlUd/hQFdDlxUzxcvnG?=
 =?us-ascii?Q?283nGHq9lM0Y9zQga8yHonXVV02gQ4K1vVLVxKFVuoBAHgRCK3kvFaJ+Xchu?=
 =?us-ascii?Q?DHX6q+2RzlwSYLNUmONfu7tlepelFD2OoM9hyvh5Lxm8wbPIaIjEyZmywoWR?=
 =?us-ascii?Q?B/fmc6fuHI10ue+EoQRaZcMkRUj9ntk5DHtRsyO3y/d60C4SrbdTE/vLx2O7?=
 =?us-ascii?Q?OFD6slqIV8xFERVTeNVZQwrm3oufZgJ7OxcpK5+n9SjPQRzhivYMrrbT+LcI?=
 =?us-ascii?Q?3RxKJ1PLyFQyDM0+cEBOIG1PrOrLo+x4gejSIehkvZsXMN7s0fwvvyJk8kSK?=
 =?us-ascii?Q?h3vrNbAUfMRdKxNpF0In4y80DnyCrg/hpjzTlEROnNxeEp+5lxAvDSNRDBbL?=
 =?us-ascii?Q?ZY/KWT2CwYIW2/AazTCW/XjZpvTZ5GyZnEDW/Q9DYJBLN7RxSFwvIR2tfGty?=
 =?us-ascii?Q?lduLwXKsiR03iWqVIIxymYwrusefL+ZG1Etjq0ttGUOoeinC8rD8GjgyPZy+?=
 =?us-ascii?Q?aZfKl4VAesc9uej4f8BFDvQajR3D48ttEOwtS7WkkXGTxnDYt74gSLat+KR2?=
 =?us-ascii?Q?9rCyQdlvKPwWW5cYkJ9dXl0HcuBOUL02BrseZRLF6vuWinUV6g/6i77smMXF?=
 =?us-ascii?Q?EwHTYwOYSnwb2lg6BVOATfypgUa0ThsO5hBLoG4vELOXSYAizEHxLiWOEE3+?=
 =?us-ascii?Q?RBtKKgmhXoBCMvmz2aB3csr1DOfwVHNeG8laNkpvtBOH0JuFX3Zq6JdgTr9a?=
 =?us-ascii?Q?3j0VwbO99pFXnOmRJYKSi8+z7pYaHn3erDSWZdL2Q2jiMVxgVPYMbOJWsIJ5?=
 =?us-ascii?Q?2+NDnQ4uleOQeuHh3QRGYmkKcfiOSLuns214y1+46Wd0qZh6wtwIfMIIU6kX?=
 =?us-ascii?Q?+Agpv7Kc5wlc1OiarvdiQHTcNaxHcSJHYAYAacZg7G8nNZ5HZHETRT/ieiyn?=
 =?us-ascii?Q?NZHere99EnHhBv+iD9tklcMXCsWmsXm0P7c83tJzABIVoLON/TaWey1Okx50?=
 =?us-ascii?Q?1i49iFSWemmXypg36U9J5EbdphqpFYOhe9K+VWKCYshDxpYhgZhtrzII0tlG?=
 =?us-ascii?Q?wRfZQ4t5rD5wuNDIQr4EdDS7+67O1ieMtsz7yZj/ihRQ55b3Ggn0nDExQCLi?=
 =?us-ascii?Q?N1XMG7JGDpAss6RCg1r0aFiigbGipzcB077wizLqJHwxKkahjDxilb10wCEB?=
 =?us-ascii?Q?evAlzVdvLfekgBZeqTovX86HS/rLMS4+3odHVAVc2TRl9EUtzIi0iynlDgLq?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hKev/inlVYJ/tTAEXkbiZ7IZAsUzhavTfraGnRYBIbFvRiGTjubuoPX6nySY9YFuLQ3Mv5mk0m22mOIDxottXcGPGxvOpKMhA2hCM1h154qFoektOiqSCVUkXVpptFyzGujmPT881agB1HB34B7EoArfjSMem/09iZC1nnPtBjv/ptcoraZqEVTqTLzuBgK1et+1PMG4Lx05neiVwJacN20JChk4n/sx2m9+Z/9pytgjUvfDFgXiuShK8P4zlN0GkgXamJuesG5CIfuQkoTPiQ2RLI0Uzm0QdL3EhcxWi55eGtibQfXyHaLjXAJeCbCexcytlf+KDW3E2gxWF1iw35x+pcej5ZQoSM9wpoWCYA/leK8qZAly0AmysVjORlPgIXSBiCNfGDpG/B+iNx1ZJjaxMbp6lYrCZLHEDLyjrhgvnbvZWahCse5pOgoA5RHSc2ZNgwwqYtMLWsDCFHocRjTZAqiUt3F5cYJbD+idt1TfVTjXZY8wAkf80KOkzpdLlz0tdgKX5uOsFaikuI9f6b+k8ookfJ/d1FwfN6XNISXSydBGxIAaKXCLssw+DREDv+wTAx92XxZqNFgVoFCRE18IzosY+cy0dBTuUkQW0L8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b9c5b6-69cd-4b27-e803-08ddbf4d0f39
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:44.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAQfKRG5b7Og2wihge68PvyNLRXyZW382Q/X6YcINf5sElqAQmjBNnGxUsQ7YHZAiIbPoBg5BfM5088ggXLV3s9uxeaifyk2FpLk0oEpsSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Proofpoint-ORIG-GUID: JlQU5TVCM2vb1fPrRPKBvs8lBTIloEOT
X-Authority-Analysis: v=2.4 cv=UqtjN/wB c=1 sm=1 tr=0 ts=686f1085 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_oAs_-Zd7h5Ft3cs7ucA:9 cc=ntf awl=host:12057
X-Proofpoint-GUID: JlQU5TVCM2vb1fPrRPKBvs8lBTIloEOT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfX+OkMG36xP1o0 /lgOsK0ERyRt+cLe/TsoVsou1d2XtKtnmwcm8ndbc0cK6G3Wt0/f2L1vjrGpHJ9Uecu3DaMmFRi yaeIauNeI27/zXCBZx+95CMt3lg2gZFbrdl2Jleffy464ZgMru6sKA4cbM71LKWOfDW9GOz5H/1
 Og8ZuYfFdWnAZSvxLiaB8cykbvIvkhPW1c2fan83ITbDdk+MeOsBuOuzD1zr9lQz/x7XxzrHWYw kPLVUJ/bsKYaVc1nuxfG+J6YXyfYm0jQzaT/T/5Krc/+DnFpYPENkRShZQvmzITlmUT3rw0E8ws M26cXJXrlaEwSYGKA8lRZs8hTeOvQzJ2kWB3UjjZ41RKfYAuFi2B3uYzx5cYutVi5TcDbdfW696
 k8Z4I2bjAEfbvO+GNCYpCFqnL1MrZldCaPGv23Gvqsvhk5tGGcccZTnRI5YicndMgNU+s0ak

Split mem benchmark options into common and memset/memcpy specific.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 412d18f2cb2e..8a37da149327 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -41,7 +41,7 @@ static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
 
-static const struct option options[] = {
+static const struct option bench_common_options[] = {
 	OPT_STRING('s', "size", &size_str, "1MB",
 		    "Specify the size of the memory buffers. "
 		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
@@ -50,10 +50,6 @@ static const struct option options[] = {
 		    "Specify page-size for mapping memory buffers. "
 		    "Available sizes: 4KB, 2MB, 1GB (case insensitive)"),
 
-	OPT_STRING('k', "chunk", &chunk_size_str, "0",
-		    "Specify the chunk-size for each invocation. "
-		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
-
 	OPT_STRING('f', "function", &function_str, "all",
 		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
 
@@ -66,6 +62,14 @@ static const struct option options[] = {
 	OPT_END()
 };
 
+static const struct option bench_mem_options[] = {
+	OPT_STRING('k', "chunk", &chunk_size_str, "0",
+		    "Specify the chunk-size for each invocation. "
+		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
+	OPT_PARENT(bench_common_options),
+	OPT_END()
+};
+
 union bench_clock {
 	u64		cycles;
 	struct timeval	tv;
@@ -84,6 +88,7 @@ struct bench_mem_info {
 	int (*do_op)(const struct function *r, struct bench_params *p,
 		     void *src, void *dst, union bench_clock *rt);
 	const char *const *usage;
+	const struct option *options;
 	bool alloc_src;
 };
 
@@ -230,7 +235,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	struct bench_params p = { 0 };
 	unsigned int page_size;
 
-	argc = parse_options(argc, argv, options, info->usage, 0);
+	argc = parse_options(argc, argv, info->options, info->usage, 0);
 
 	if (use_cycles) {
 		i = init_cycles();
@@ -396,6 +401,7 @@ int bench_mem_memcpy(int argc, const char **argv)
 		.functions		= memcpy_functions,
 		.do_op			= do_memcpy,
 		.usage			= bench_mem_memcpy_usage,
+		.options		= bench_mem_options,
 		.alloc_src              = true,
 	};
 
@@ -453,6 +459,7 @@ int bench_mem_memset(int argc, const char **argv)
 		.functions		= memset_functions,
 		.do_op			= do_memset,
 		.usage			= bench_mem_memset_usage,
+		.options		= bench_mem_options,
 	};
 
 	return bench_mem_common(argc, argv, &info);
-- 
2.43.5


