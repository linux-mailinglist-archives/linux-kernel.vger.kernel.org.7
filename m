Return-Path: <linux-kernel+bounces-746210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1344BB1243A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB57BAC6A50
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21347248F4F;
	Fri, 25 Jul 2025 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KyF3+Nby";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LWPfGzwu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE92472AB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468897; cv=fail; b=OlPk0Zv+x3QdaTmewC7HVHBaS0l1fxPKFNP4QWN9btFZwOB9xLcDMPSRCJ72Kwg7OZgiHaeakP+pM5GPnLVVZ0EWwxu7w7d7TY5JZU8WF4CXx8j3B9jmUErySFlabZmeprxdxQ8osrEW3Tzl6l9P1BNKpTlBkEnK0Rc/2AoD9cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468897; c=relaxed/simple;
	bh=Ze5T3BxgiYFm1Q+dHqMdSVDb/Aa5N5bHklyz1EGSLZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BGEhPNFTXVOVS0OajgFtrobInoEiEELjGLkkc77J8oh6da0P7JhUM8xg2ecLSCYIzMPuWOUemJX2AHnJh8zIC9LzUAO7k03j7Tr5SUDeowDF56jnRMsMUe8YzJFZJBMrlsAvabqqNy4zAFvX+Y243x+NRpS8J1n7/CXVLnaYZGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KyF3+Nby; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LWPfGzwu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGC6MR007398;
	Fri, 25 Jul 2025 18:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YYSg+pGwV5fLhXP8j9
	NbDYXRysE4ntKglIkbR62/83g=; b=KyF3+NbyjZIyyKBgeK2TNVCO3XuP6KcSTx
	4keVNWecx/YrpG3HDEX2RIJF5TofVjfeTsBJAcWQHxrO2Yv7fdPvWFvPo6Ls9vbU
	w4goA8l1OD+xcMxAAA5GECqOOwYWCGFWM6Qn0LoqcyMdO6wjM6ISKe3TP50LfG5y
	sbW5uqDiwiOqJPAwv1CM3tPEFJGzzvoJhFuKwx39uDs/bSGzK3BrQVuJ9l3p5h/6
	+cuhDibQXOvZT2RGW8ngSDfzVAgF+u/TdYITACaiPVrZqEKyciX0fD4oasPDA1RD
	rOICdQ1tEQTmEGUqYIzOTsv7bQdZoKrkbNRKyI8OGn9QQJrZX7jw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k9ntj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 18:41:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PHsotY038403;
	Fri, 25 Jul 2025 18:41:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tdf3n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 18:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mx9H5QglU3JvmBgvx5vH2QEbRAKM06JgGZzms9vX4jQbdSku19M+w+qa8jG7KCo8pzNcNyfWd0s2f/dVwvaaVdYDAkT6m1mL+5SClhQAC6mMUoOFpOO7ZvtLxZXKrFqvJQ96p7DumCuTaQRD6yvA1za2nldkLJWDt2g5dX1eJAxaWZ0YgGahlr2SnoYK0ZumWr8uhzM+SlKDYly45CzpIg/nApkvQ5zq3j2MJTk5B+z4BrH2iUwKns/LO4/RtjSuiQ7+Ysn+G29eZviMxVW06hczfSndl5o86oyAIfnnxmtkXzvTRkk7HYCp/uNRoIpmHgY6SDt3cGa1G9UuuYCoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYSg+pGwV5fLhXP8j9NbDYXRysE4ntKglIkbR62/83g=;
 b=DNNFYdoJzrIlIsiTvixkCBrEVZ21rGT0c9ixlHi3y4e7J4jEjnOHSIkO6XE79vCN9VI1DZPwa09jKXYzV0r3eiIs3DEnElwX4f9erCJ6NNjGfMB8fHfne84w/QyKCidtPAw5qGRZp3Kr1vhufqHbMyV9fttqi2Nej95EI6iVSYqF0Mg/Ea2VtpdpTKmtR82GFpvSABRfAT6yCItJNTzNx+vYGsNmlnB0yetfjoCHfWwASaiovClQuSemnSZeYHLq1iKDeaPX3qyGix64gqkFTVOVVq2hXQQhXJVwMo66L2GwiOdN5jzXgneav2XhNk7YlKOdD/TM/MNT9hCKpXbqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYSg+pGwV5fLhXP8j9NbDYXRysE4ntKglIkbR62/83g=;
 b=LWPfGzwuHIxdee6LWMvnIlwUXY25QOSAdSb6EFbCq94K1hZ0EJdmvLZatDAc9TxWhNrywhLJVZF4x/9EvKgcuId2ywmxQuLt/jlIVkQMt6yCVUgN/TaS4n3jmFXM1YvKYqYvDHTWqEeQGroyz7BZyDzQdm4Ni7uCRC6IRQtFHMs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF8CB762A0C.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 18:41:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 18:41:18 +0000
Date: Fri, 25 Jul 2025 19:41:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 4/5] mm/mseal: simplify and rename VMA gap check
Message-ID: <d85b3d55-09dc-43ba-8204-b48267a96751@lucifer.local>
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
 <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P302CA0004.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF8CB762A0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4cbee1-2005-4051-78c8-08ddcbaad7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+20FedJHXXNVCSGI8DlrWLiZR8UePGVhuNTdAQXPswFBI/b2JRbsbLMDm+i?=
 =?us-ascii?Q?RxilbB2nzUdfCghmIdyKsWrv1fVtjUZbdUgRVDi8tpOFEWt2WwM/xZunUpxt?=
 =?us-ascii?Q?c9kDGK6vOaurg30vsmWTnUzxQjX665Qt2Ur1Y1EBOu/xnjOilXO9cukj8Tod?=
 =?us-ascii?Q?ReYc9UyRDT3d7CbhrWcC9mpeK5D/H3P5iQZHToi9F1OecTlsVYEn7EoD0NRE?=
 =?us-ascii?Q?c9JiY2AvhPzyHpzJO2Q2cAbHCzPC9FG1DuDy/RkapHDHwmZcoymJTe5/iKU6?=
 =?us-ascii?Q?ytLuzWftexVf/6M5N3ojfD6cb8Kcnp7Y5ii/OOG/aDmwLUQ4S3++fcFuhCX6?=
 =?us-ascii?Q?Z7BKdNeGyl7jQxL6Izu4DhJJfbwF4b1A0O9CRt/ng3LU0ebkf986yLTAupPM?=
 =?us-ascii?Q?xOuvTj4zeOvchDwJNT5E6exAkHrBd7+x+7Oh01w5CeGdeyyivHBia2hJ1GM1?=
 =?us-ascii?Q?mr9Ed2r0pX1cqHvXAUGPiYL4VLyE/pKeC4ygVPco7Ev6yKTeyLUe708npml2?=
 =?us-ascii?Q?dVu6AAlv2+arr2WVtMnes/T1UTOHDrOtPKupYFAgCALiW6a00hxUCK1oQ7TN?=
 =?us-ascii?Q?c/WnF1konlQ+lutbFjpD7afTGB8OlE7PHgarNzvW4DA2pQnijUDnIho3QG8Q?=
 =?us-ascii?Q?/iOaNRa/78nTREMZjR9264pXp4Qrld2zqmKDcYUaWqMrd3RFskz4eviaWUWG?=
 =?us-ascii?Q?l9PsNtaIx9py0on+8nmUDrA89DobgWoqSQOU2dWGiWZNDuBQMaLK8FN0pmD4?=
 =?us-ascii?Q?BlCyoYg+hzbYd0sfirt0IuFnbqW4s8TPohY9W5rS+m23JXZ/MSldiuJ/Mcfz?=
 =?us-ascii?Q?MM82Jb3mjNCPH4t/UZA8XlfTAZ2Twp2fVtVMj3G0dPAnewK8G/gnVECSunmZ?=
 =?us-ascii?Q?uw5HFo3j/8TBvSW9c3/oTDCs936x0pj8L7OkvKIYm2/pRbkcX/JfwpXYQyOk?=
 =?us-ascii?Q?JU4HaVbRXqrgELMb/eJv5BvIont/QFLaDnzsouJubnXPuBpMio4/nYaDFfuc?=
 =?us-ascii?Q?hizSxLkQkLfB5nafmQloqbDQfZPfudV8s7Y6H1r4WeSRyuFNZf7cpQccKfo7?=
 =?us-ascii?Q?rBG0UOMDeMez9zUoh+sa64vbJCKVr3BLQ+UvPCl8F7aMUtYFySWPAxQ26iaX?=
 =?us-ascii?Q?ZywaiePgJmfF8WDRSB4xf2lCIJw+lTV387SPqDob64rPw0agzVhVM0wLkuIX?=
 =?us-ascii?Q?YmOtzFK15EcLGNITm1IOXtw5TAVxE5DRWBfUbRdjLI5iiezJGcqw4kz89feo?=
 =?us-ascii?Q?DeJQwRD8OMCMIwlW4gJEhqQHl0fiPCJfpR2iwK1YjksMw3YTw8Iw8Z3d80BG?=
 =?us-ascii?Q?+dCEp+MmHh4D0WWFdocK5/eJKyfvCQwXX0xUGKlNmyedGaV0VAH65ilBiXmQ?=
 =?us-ascii?Q?vRkR65GZOh2Q3MRsohu/LgyrRQswZCMBDn3jhx1ydWfz0bkiyfzlRaEUdrak?=
 =?us-ascii?Q?Hs/98tgi1GM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qe4LkI+1kN4ssCcsEy5swRTpl9Rrb6MfrYzYzNM8/3lzni2hzlBh64L+TucB?=
 =?us-ascii?Q?NgxSkJHtJb7PS99a/k6JCg6G8KWt/o1VnZNWEvOZXxHHWxQjMoCVGymqlAgx?=
 =?us-ascii?Q?oPYhGN/9LsPu9f9MAfadFCoV4iC5zbBlDcuTmwqhWZKU14/ura1VTmRbw2wh?=
 =?us-ascii?Q?hgDRthelmUt1qbfnZeG61yZ6cbOlPo/p5Xp6l3tnZYrxfRzlzWN7stuWifsS?=
 =?us-ascii?Q?Yirii4j7v5UnPOsOuRO1YLCEPysbeflOXl1QvY+CWLNcmN3+7HH+EmAy2FUw?=
 =?us-ascii?Q?ar1pZ0URt+OAPQbuQ0VlsU3F2laI6VucMXd5PqqSL1RPCMCEpe58q/kVDfzI?=
 =?us-ascii?Q?qatB1Nv6Wlt0sAS7rf9WnrewBxdR7PllLniDVK1uhGJm7IHGE7pE3d6+nKku?=
 =?us-ascii?Q?dHhCXtKZzH5L4KUVzB/ARJKkYfXpxvdQ2s4x+mG/l//ToyurOt/eFPIjADxg?=
 =?us-ascii?Q?n0xLcPfFK05iTc7V+Wqqb48T90cT1LmSD6DstYSJ90ZwHClz1u2Wo029aUcp?=
 =?us-ascii?Q?GZlhmVcPZFSDMoukeC51UrXGb14E1m+/BqPd1gfsjMKj8GiUhYKhCqO4metg?=
 =?us-ascii?Q?KR7CoWdolNxfKj+ECC7Th1m/W0/iInMfthyxACDnSCXZm3cPoHtM/eoNcq2H?=
 =?us-ascii?Q?r6iFpd9P6JwwFxcogy6aZsoyQQ8Wvi1/FhMQGkwHVFykvfPXfpOIBE0TREaS?=
 =?us-ascii?Q?JQL/ORaW7cmk+wFIeqAUkxcKZyZm1d0gszQBBojnbdlpTp8oe+UzoxotBeim?=
 =?us-ascii?Q?oUnVCdAan4YZ0OE86hwZ1vyDXF1K8D563Zd8WQBAn4rf6aFjD1u+hhpLMq4r?=
 =?us-ascii?Q?PCNpulhwBjPiAcPGe+ChQXCdJs7BgE8/8al81zqWMvj2IumUQls6knw6PzTD?=
 =?us-ascii?Q?plJRbqw/q4L+DWgAxWsepE70ndcIeQKiC64lc8g+sFmRtAvebYf+XN4lBMhP?=
 =?us-ascii?Q?LrVl9Uajm/quL9jEVOdUIZzviJCmLjZenPk8PiOoHg2YBUC4rOwLliSiVsOg?=
 =?us-ascii?Q?w3OvGkJZPJw4JcI9XLhYaM1qJzHuhHJbxwJH8FFl6hsdXr7PJpSw9mEL1Fu+?=
 =?us-ascii?Q?lSi61mIoHZsRe52H706BJmTJU+ajNMyEgtwtjdjTYdCZLEPINyuZiJMZusEH?=
 =?us-ascii?Q?CzmoxL0kr4MPVqvVy+WDhhhVAz8LqzWfFg4SHNKdwNeEagVaon346fmVn0HK?=
 =?us-ascii?Q?Y9y63RogTs6QALH69SoHNCv+J37kiVANl3Tlq7THChWlzjC+D09oQegJaExq?=
 =?us-ascii?Q?qgDL3XkaVrMPdQcJz5PNKQei3cHOrKQFK9OFY+nVvpUCpvTWD7T4wbyF9a6r?=
 =?us-ascii?Q?QfslePh5LZM3bCYfTr8U6+zLBUizQo1byMf+efqmauHIgNVnmoDNgjM0XaJX?=
 =?us-ascii?Q?zmCsAY96HmmwgMHUch2K9BIFXkSvVxgik+qpxsLArPweo5lXE1KH8kCn4IP9?=
 =?us-ascii?Q?rFTd88KNkxr0gYqn29EB6WrhCNDQCro7B/hZi/kluf26swWH5+6c3rbKtVAF?=
 =?us-ascii?Q?OfBiZZ11oW2jKLYAaMYsuckVWugk75Mzf5AFTtr7BLT4uitkH4kBDuRwjW30?=
 =?us-ascii?Q?Ta4NliZjLmU++ol+/lmkhtLUyMg3f9ZZ+9QyNSin/I1u7VSyaQEjikLfarTv?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HpzENBCaCZwnCZgFSVm3EvMMG9wBsP0wQ6G1jhmoNRh+qEFyUAHisIzASD92BNVVN5xPhu6Q7wIivnPiOevby5mtDrI7cQV9giLUjPwZ/Mg0yrHUOMT+T0XuPsw95XHzxlThWozClGOabtkWvgRhJrIb57sGi9jgA0rx5YqWF8nLTwuvttnEZA0ujyXz/35I1oPKz/XOIpXTJUny0iUyAfhMWAvsCAZBcgN7cKqL7uPgKA/cGNUsqFSCznx5dEPhTVzDBOBj6pHlwSR0th+tbIT3JMarkRoaWXv2ALKBtqB3UKK4gsllDNmn16kNR4hIgQb7coO0vUtyy/kAaHXoQeoGOw6uKk3P3H1To3I8CRHMONOHuKpbNxRDKkVXQSiuczr/mI12H0dV0gm/tqru90S5cnZehNmfThS5l2V0FQ9mjaCNzmESuTubDJIrDX4xGHg/D9vRxFhNtK7mACBFFaILWWtIAhrT21l5SbLQ3OzrU5vd3nZLogl8KXKq4NAtP5YoJDqqe4Rhc9lZBgwf2DZS9w8dSZDOfAiqeoIVdkWzuAutklQYgDKAuygDiQSIm+vNacDthGuc5qGAYj7X/EsW/QAiR6hCuSdZefpXum8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4cbee1-2005-4051-78c8-08ddcbaad7f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:41:18.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TD5z8XZgh4jpGixF/N00e1qtagK1kp1AoLw7gxMTWokYh8oR/ZFmB42JhA2QaFmzzFBrXz4BXjrgrYMdZxTAZJfbiXed3ZIApHW5wVV7ycw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8CB762A0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1OSBTYWx0ZWRfX7k78QY6DCoMZ
 P2iYPg38W+GmUCAh/H3yIwEPvDhwiPLy0QuqUXOJZnLKoO6AFDUTapIWPLbgxqbmoIvJgOKLENP
 hTxGNK0yTIp6e5Pey687VYHv4QCjFidOhsxwYzv6Poi2HTEpQ8D+pOQ6Y0q7kAnKRA5M1fDxn03
 0NsWlGaCotkr0zLjO/8GTZ1SsRhVxQB2tnyB9lbcfxJsLci0kpKhsQejXTK/w9aq/VKe7W3nMdv
 qFMtpxwi5n0QjrKRABFduW66sszixArk7dR00fpvDZh3TMw+WCAQPRThvGYlmS2RLZr8RhItAmN
 n1tzCIgyw37qpeAyhBUwi4xh9Ps+DZyFe8TYV81RxXErLRe8YcKBLQRoHJaT2CDkGj8IDOnY6FQ
 vuoDjBNVSj74eSEinJYGzGhZNwP4iSUVl0MgCKXXB2+WnJjJ0lwrE8P1p9LFpPqzLpCm8/TY
X-Proofpoint-ORIG-GUID: LoZlWmW8mj3D8ZeupoR1Z8UylQgbCaFk
X-Proofpoint-GUID: LoZlWmW8mj3D8ZeupoR1Z8UylQgbCaFk
X-Authority-Analysis: v=2.4 cv=JIQ7s9Kb c=1 sm=1 tr=0 ts=6883cfd1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=mwLXZKzjd4ue-Yc61lQA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12062

Hi Andrew,

Can you apply the attached trivial fix-patch which adds a clarifying comment to
mm/mseal.c.

Thanks, Lorenzo


----8<----
From bf8211317183353b3652baac1af1d35555733d2b Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 25 Jul 2025 19:23:50 +0100
Subject: [PATCH] mm/mseal: add comment explaining why we disallow gaps on
 mseal()

This explains the semantics clearly, the 'why' of the situation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mseal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/mseal.c b/mm/mseal.c
index 1059322add34..d140f569c4c3 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -37,6 +37,18 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return ret;
 }

+/*
+ * mseal() disallows an input range which contain unmapped ranges (VMA holes).
+ *
+ * It disallows unmapped regions from start to end whether they exist at the
+ * start, in the middle, or at the end of the range, or any combination thereof.
+ *
+ * This is because after sealng a range, there's nothing to stop memory mapping
+ * of ranges in the remaining gaps later, meaning that the user might then
+ * wrongly consider the entirety of the mseal()'d range to be sealed when it
+ * in fact isn't.
+ */
+
 /*
  * Does the [start, end) range contain any unmapped memory?
  *
--
2.50.1

