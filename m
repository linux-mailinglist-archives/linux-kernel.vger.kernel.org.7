Return-Path: <linux-kernel+bounces-724723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66441AFF640
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2171C45D95
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CB7265637;
	Thu, 10 Jul 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C6SB68ct";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pw1ixW2U"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A3263F59
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109215; cv=fail; b=TCam+wrQpfnNENZb1ZEH6OCAXdK8reP03NMas1LiCBmbUf26bIhg05+4C6YV9EHfcMCaa6ZNhjPWLNtlvhQipxpP6g8XYEeNU3+wCAkJtilCs8OrgDmJVRq61QbD7DA2crgyLAhL4FfWURYakIa/gMhURWZvDoYzG7k6AK8PHt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109215; c=relaxed/simple;
	bh=NVrfntKNiqk2kXEdB7/MReklD1KRIbCgxJIt9FrKbII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O5wTdyqfSqcU0RiaIyI+Pg2lIIjFd5dyPSSXqBGaIgzo4boIy7xHqP8t189bmanIHh1z3AsGyU+ISoOSHnNF6k7GLnOfvZ5n+cz9a5RhyJq025FzeWF6GbrplGJwMusde8G9Nq00DECMTkDm3pk9KzOQFnd/nL279XdyWfXYOVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C6SB68ct; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pw1ixW2U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569NJ0E0013830;
	Thu, 10 Jul 2025 00:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kIb7cITVYxosEqvvSgYOv78YPGqCfIux2UWSMzSloiA=; b=
	C6SB68ctq7uE17C0tRlPorbRMyRTHjler8ojacNiHIlL5dj7ATgABPi01MVDqI+7
	EOBsWSoeI29S4/e537ScULCMlYH0i50m/Z7830Oa3NCiFWNKLEjbkRv3gTfgCtBI
	pofrAFhKuFhZC/7OjO79Exq807Ia8cj0tW2T0NmZlAVw6YOtYPP1fEJvFM1qycCL
	c1o1f6/H1clmVbFd8O8/rEQWXXR5hxMNH9EY+Q2ymmSNin8Nr9UmaBvLVmUSrcEL
	3EhDlYJ6ARGrS8PPoX2gXdtQbbWqGAMh3IjKsFiZHlg8Nu9tOMFGTR2FylT61UiJ
	FHgDgbpEGx/uhOtZmfZnug==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t1y103e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569N4JMY027228;
	Thu, 10 Jul 2025 00:59:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbms49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFKo9uGufcWS4Dz6wCDt522dmiN1J73us9qH549RpteYsJv53520L5wS/7FNrEVJbfGbaWgyu+3OpzokUSCFQJbnKnM5yaFpj2Ui2+i6IIOOie0WC7TVCYpncjtUdv7Zlv6kdptFnd9gUVrWNWZlcZoFow0qbxxtj/d+5OUfqHX9cTVaifT8lNUA+HwB8VwkwSGr4sQj498NuQRP8ft1oYpQRyQDit/0E34bc8B9Ov+Q0EzskU7utxdFfVZA1UXPcFRFy4TvSjab0k5o4/dZL7c9ehulHPdQvsfC1hxGvjdS6VTduxFgGsxROkstygZ1RZKq4i7orZ+mduQv+nXyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIb7cITVYxosEqvvSgYOv78YPGqCfIux2UWSMzSloiA=;
 b=vB6ESaTZnD4IU79Nv8JDjbglsP9Y34Yrd5JAEOkev3YEYswn0twgmcpTJfqIwaJlOAPLHQ1wUt+2dR+52aWbZMoXm/IuqnPOyD7NUyN4vrb72qFrsf//WScmwtbRv9ywcdhoVhN1tUIWsYVJLT5SDpNRdhiEqQ9vLoNjVVmV6jaqQbVfsjV2dimj+kP3CYntGPGCC9SERPABp9h9rQFSsfz13qsQtDMy2rIj81wOE25DUSg5ul0n3xXRLorkjzEvLvKby8IbcRWpNBLUrUSB0iK+Bn7iKBTdO+VbPTuBOJMAuw5B5hiHHPFdBaU8vaBEngECGqc3D7/qb/1b/8yBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIb7cITVYxosEqvvSgYOv78YPGqCfIux2UWSMzSloiA=;
 b=Pw1ixW2UU063hFE3+seuoxyuyUgwLXVX0JZYssOmcAEisVZYZ1Yc9yMnHSfa/HehSDPuO/FuVlbJjHZ0hHRs0wGm/bou3tjlgQLYcToBDI0q1su6snd4fImLx3nQO/+tD3ltj3D25baTF+gnN0Il/G4LR9KhBNIPNCbny/Tpvsc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 00:59:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:48 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 09/14] perf bench mem: Add mmap() workloads
Date: Wed,  9 Jul 2025 17:59:21 -0700
Message-Id: <20250710005926.1159009-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:303:2b::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 525208d6-db06-49da-8842-08ddbf4d11ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1c8eByPXVAJMq+WouMu23dKUZmJoiSzn0e24kH2uREEnhBVx9btGEd3nbECf?=
 =?us-ascii?Q?ncBrBuHp1FpoC8XrpjyTeciszYewwn41/YSrTVF7A/8k/dryIQaf3GcBfo1c?=
 =?us-ascii?Q?IdwFY+swsdpdvTCOXpSki3GWxQcC/zKRIaDfMtt7Mtxaot1gw5zIuAt3PVnU?=
 =?us-ascii?Q?knGegMqauCZXqtXsaU+atnzBw/kmojLOlKt8CjCqhM9K5SAr7fqvKFAUwPVt?=
 =?us-ascii?Q?rybsPoIoeKCaLoLbLOyjY+wcxqUvvfijHxOxjlreAYuWFyVpBuf3KzkPr2iU?=
 =?us-ascii?Q?qq2mVHyOityMlGIhvEzpzjjc2pFdAG7cF2gIHXWb4AIfHTrN3uqrVSV4u54E?=
 =?us-ascii?Q?uhzQi0ipDU9Zy04gFdOU4zk/l9j7ga55AOfwoAHY98Hlo1eqAjJK3n2ndLsB?=
 =?us-ascii?Q?YC+1CqQid/6BvVAt9668t6ZLntvhVlz3Hz780fFclFGsZAvdTsey9z8ID1RL?=
 =?us-ascii?Q?o+phGDymLaOvpB9pkve353onApy4COLn3NBa86y26VhsR6UNShRXyDsqRAat?=
 =?us-ascii?Q?YCxZSNtlKTWIWh87msXXicL0GKWA6+AH3nTya6XILr5c0xsV4/efrE4Alfyi?=
 =?us-ascii?Q?soSwZKa5EdbEt7skqG8BbqvKvME8zHFjPq/3Gdh0SVNCXscLaA+iViSLSZkG?=
 =?us-ascii?Q?WsBVZxX0YF0fII01l2OTZ8LTYum9alIwX3RS+/2z9F3Wx4AEQm6LUmTAFn7M?=
 =?us-ascii?Q?WMjfD+yGX4KAk72ivS9bj6ngpbD2bkKJwjILrYv7El0VoETe8iON6ft0k8EY?=
 =?us-ascii?Q?JMRAevN5hIul1lt5U8YyhFJDJzE8E1SmFoPBSAWisITc5gMtrSd92brZn/01?=
 =?us-ascii?Q?UN/Fj0ICr03cWEv0OOFQZIZzf0c4FcTeEqvV+LFx22IEzoUixKPsZrVUoK1D?=
 =?us-ascii?Q?vIKx7AYRcmA7h56u/AGwfRiB0omuD83Uw1xI5rdaCXWeBkjHT9RNe1iarGlA?=
 =?us-ascii?Q?/pV11+cfpxmWkAkstmPETTlul1y6F/dg1urJICxgmn8HkhmWg0qhv8NZhWZD?=
 =?us-ascii?Q?FJi5TYQPH8NejVP4u7WCCNhE8NafBT55OoRZgxbm5x1kM/9gv6KUL/FoYUJ+?=
 =?us-ascii?Q?SoZhASgLKncZN7QOsYB8rxZ4T7BuQ2MPjgE4zNce8Qq6aHDGYY5CzDaq/0ZH?=
 =?us-ascii?Q?J6uh8m8C1Rf7cwnzCHBYCODwmfcthgXH6Bua9ObXMpaq+neSM9vtkHTRGMz+?=
 =?us-ascii?Q?YfNoWX0AZMTm10CNLa1nuEd5oXXxgzNCHpsa37NK0iBY+IybUKmWpP/NAWSG?=
 =?us-ascii?Q?AkO8ioOyyqI9Jd3V1j4+BLfHIDzUPLbeG4+4cdCI2fksKagkVcTEX0fS378X?=
 =?us-ascii?Q?sAcPc6QMgM9J2rVbT5sq5EqSwVKOC7tHw0+1ETBRMQjezTp++GuOKuNrHj2n?=
 =?us-ascii?Q?r2eH+qHHfXU6UKk0vLwqjgSgZh8Gb027uGTlinW6eGar1jiJ39qIAwtF+lHg?=
 =?us-ascii?Q?I2iWYnqvSvg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IRQ4WI/7IxC7Gg7M1+GMvui4Gk9r8OGHAc4yhf01qh9ULVV7SD4gW0aV4Q0k?=
 =?us-ascii?Q?woVLP41ePCpjndr3mtwQFBBO8pgeKfgEvVFbF8yzNu1rZ/EqwXoS3XFGyfJu?=
 =?us-ascii?Q?102ggIUPTyJJ0ryW2myMn4rTiRdm1tnUYGK78lT02sBP+ZtyPQVsrgnuXw+t?=
 =?us-ascii?Q?EPoswFSq9SSpMhY62B9ZbxdJKopge3JFTwZnDrcSNC+MVGtbyBpQFg6N8FNc?=
 =?us-ascii?Q?wWL3I81sL5Ed5klOlCEUl3cx9hwMrqkUeBcPETwUe7c4J08DmQu/AHXYozcB?=
 =?us-ascii?Q?NhBX0s3DO1N5FIiftAYB3A60SweXeGvjGnkOovO1jaiPFaOL3TgZq0of1Ze5?=
 =?us-ascii?Q?0In2HdLdIQYmvhWVnoizuzZeqcmZHkK+SuyRBCHzTTU6Bg4fBZkY0TmiZU0A?=
 =?us-ascii?Q?H6egdFLmKfgFqK3Mv1J3ww2ovSSRRQme2g8BpeDJN/mDi90//Y8el18KZQPG?=
 =?us-ascii?Q?fmdwzJYB7psJ73WWlBNzyfR1pKRd3caJ6yMBLWsdi578bK4UOb0KMe1hZnMh?=
 =?us-ascii?Q?rIQkMV3oCUosUb89bsNAo+yaA9+y7q2ixiNYKUAFQln9AvToYjZwQ3BIA537?=
 =?us-ascii?Q?UZkTkVClx5q83XZ4ioUPfls92g27snGSwDCmc6XeX94nrSxii8hVGTLnh4Nl?=
 =?us-ascii?Q?2YpNlxD2J1g4VS267+VRiT6bt71ensjET3gfAQgusyKodvKTZIRRJh8geQGj?=
 =?us-ascii?Q?72ctqpq6xE51k4Lr4h2obH75V7ToV4Vms7y4EcYmWDrR6nlYafKxLIvIZD4a?=
 =?us-ascii?Q?DrqcSom6WMVJAZ03dC58Qplkz8KTwT/nbe57BhdcQQATISd/Z0ybEtHNA3ww?=
 =?us-ascii?Q?K8xxZTtnNPNsYnhF70vIRFS3XaTKSeVXPGLz9RtVSoDcEBqLKGVYfvKsFAaX?=
 =?us-ascii?Q?LGC4pXfcTe3kxtfzEll8YHYs1iGKzk2ytPD4fazIt6JmAf4s9k3eL20fMKp5?=
 =?us-ascii?Q?bzs5YjP9iokzN3+TC/d5R9ZoZbzbSN5Ua0zPXKLihE0WbZbUcFk32d8COSSl?=
 =?us-ascii?Q?I6YTqn4R6NfrVBnR8H5I1vw8aFAyha9usJx7CpyqWR1ECfliAQr9VjMbMwAY?=
 =?us-ascii?Q?z/GjoZCzwOBnstABs0SqtgDKDv32B4zFrG6dZuTSth3HiYo/VwqLhX3YDCL7?=
 =?us-ascii?Q?woRF/6mzp1gSO+KqUgdA6rCG0vEMLCz0MDr1tKS9bHCpUBbLxjT/IUo7LaP5?=
 =?us-ascii?Q?C3ZpfSxryjok3GhLS+l6VrIDmb4sM/V+n6o+2DHJKRMBvV+Y2NhjSeEYMA5+?=
 =?us-ascii?Q?sm9HgGNe6gw2d0+dPIezS/iGOVX563sFGQydsB8AfCPXNI93ykaQUCiGfb++?=
 =?us-ascii?Q?DlE1U7MoV3vI6KIcFCxVmrl6rTxshhgbI+sd/+QyedzDBym94uzB14FUqhZl?=
 =?us-ascii?Q?11oOJS2CA4/nu5Pv3vaU9ZmxVwwraLcrH+ltaz+01IzmrAEq8tl7zbaKjlQc?=
 =?us-ascii?Q?z4NyO5eUHO80iPwOljCrBU+9mVf9Ud2HiftHUYnl31Py2KLrC+P7xn/1G13z?=
 =?us-ascii?Q?+XAOM6syRpJKn7OZqDET0FY1EHVCeUuibU8sldEN1zTRwVYe0B7NofTwE6Q3?=
 =?us-ascii?Q?fo8Jr6knC8a+RLdQA6AB92oIQWzgxAlPLJoL0LWQ7zP0/LnO4Ywq71NVN0V3?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V9+5uRTmyzeGXldnUPDjq53sjUtigWRFEEh0akkgKmLQcfPUmNaox1cTP9/TLdfMvAFAEm2pr2WrGTVuilpRhG/YcAO6jqU4zep80PVXtLywMrd/xYPvRs4UD6cxxP30lP3HaEGk0+AAvAHRCMLGJEeHvd86QasLIsio5DKfLDvDhPgf0eOPtT5NHjo/UpLg7BzINpIQfD9XBl1tJO4zsaNN0TXy3LzNvhmEJwZSUbA5i/J01QgJYAMFfaxOci9pEpVegzHq29XMfWPlhA8jX6W/MChitjY68iRU2KFqsz+xxyfRFXX4Nzvqo0aNXo8XbTQ161I0XwfiJFiH6w1BeMLgYwurXgW4nZI19etoJrV+X/8+T1J/Mowh6kviPyoI3fdRGpb4z3xTsksjrjyNXq4mCjbrIiuSo2yVurqf6trwFrx3BIaqmyUPbvJ6GChvl3moNIiWXjvTMIHQuyFbJeXK19R21UslXhbuv7UHRg/UEtr0fZ4469clgbzGfxlBHxIIcpT+3DzQ9KxwmLb0cKsr5HYefaK2fV9bypj2kgyJ3n6z2mLPvKuwoyZ6l2JO4QP9/c17emFkYUptYhPLT8zRfxmppczLVMsspWg9ay4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525208d6-db06-49da-8842-08ddbf4d11ba
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:48.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeTJc3lvv2LMbyCqFAigrufl7j+4DL3Tsiin3c6CAX5XP5dQ10Cl+ZFHT+EddiaB9VbzZrEoMxkIGbGPA7AISjafKI/vYvORl4or3a/E19E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Proofpoint-ORIG-GUID: 0W4IwjxHywNAQrhRfHN13vesMKlJ8qce
X-Authority-Analysis: v=2.4 cv=UqtjN/wB c=1 sm=1 tr=0 ts=686f1088 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=l6V3Glt4oJD2QoyZdxQA:9 cc=ntf awl=host:12057
X-Proofpoint-GUID: 0W4IwjxHywNAQrhRfHN13vesMKlJ8qce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfXySFc8vTUsZy3 wlmdbrVIks50qIQosW2rA2nFFHYFkyH3Ptyg5nhhlXlzG17bBd1bAFw0dlf606VT02bctxCWAYl MEvbQUA0+JgOtbubv/sQwSXZBGDEv4rptzFnK65RAC8zzjLSh2M6jbn3TCu+BtErlHw4273crrI
 ByrnTVpobq47MS0eUqBZmHtbEyPclvqgMIagNs9qvX3npYccVTfPskhHQM8ucMX8rFi69SvATKd 8zL7Lre06PVWmZjjd81HAWtk/yrsB+NakZbmj1M4aSeSEGByYWZz37vdO6kgMiuqte2ALxTdI3r GkPsp0t5k9lg78LB664GOlyjrB7XlqHVpBTtQ73+31BHFs4js856KQPNh2iXPyydynvy8Cg21J6
 q6hGazhK8SWyJcU3w3c8N0UgcVaZA+5tKegGRaa5TmUbT3e6voBsB5y8e3iym0FYwzVD9E1E

Add two mmap() workloads: one that eagerly populates a region and
another that demand faults it in.

The intent is to probe the memory subsytem performance incurred
by mmap().

  $ perf bench mem map -s 4gb -p 4kb -l 10 -f populate
  # Running 'mem/map' benchmark:
  # function 'populate' (Eagerly populated map)
  # Copying 4gb bytes ...

       1.811691 GB/sec

  $ perf bench mem map -s 4gb -p 2mb -l 10 -f populate
  # Running 'mem/map' benchmark:
  # function 'populate' (Eagerly populated map)
  # Copying 4gb bytes ...

      12.272017 GB/sec

  $ perf bench mem map -s 4gb -p 1gb -l 10 -f populate
  # Running 'mem/map' benchmark:
  # function 'populate' (Eagerly populated map)
  # Copying 4gb bytes ...

      17.085927 GB/sec

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/bench.h         |  1 +
 tools/perf/bench/mem-functions.c | 96 ++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c       |  1 +
 3 files changed, 98 insertions(+)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 9f736423af53..46484bb0eefb 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -28,6 +28,7 @@ int bench_syscall_fork(int argc, const char **argv);
 int bench_syscall_execve(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
+int bench_mem_map(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
 int bench_futex_hash(int argc, const char **argv);
 int bench_futex_wake(int argc, const char **argv);
diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 8a37da149327..ea62e3583a70 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -40,6 +40,7 @@ static const char	*chunk_size_str	= "0";
 static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
+static unsigned int	seed;
 
 static const struct option bench_common_options[] = {
 	OPT_STRING('s', "size", &size_str, "1MB",
@@ -81,6 +82,7 @@ struct bench_params {
 	size_t		chunk_size;
 	unsigned int	nr_loops;
 	unsigned int	page_shift;
+	unsigned int	seed;
 };
 
 struct bench_mem_info {
@@ -98,6 +100,7 @@ typedef void (*mem_fini_t)(struct bench_mem_info *, struct bench_params *,
 			   void **, void **);
 typedef void *(*memcpy_t)(void *, const void *, size_t);
 typedef void *(*memset_t)(void *, int, size_t);
+typedef void (*map_op_t)(void *, size_t, unsigned int, bool);
 
 struct function {
 	const char *name;
@@ -108,6 +111,7 @@ struct function {
 		union {
 			memcpy_t memcpy;
 			memset_t memset;
+			map_op_t map_op;
 		};
 	} fn;
 };
@@ -160,6 +164,14 @@ static union bench_clock clock_diff(union bench_clock *s, union bench_clock *e)
 	return t;
 }
 
+static void clock_accum(union bench_clock *a, union bench_clock *b)
+{
+	if (use_cycles)
+		a->cycles += b->cycles;
+	else
+		timeradd(&a->tv, &b->tv, &a->tv);
+}
+
 static double timeval2double(struct timeval *ts)
 {
 	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
@@ -270,6 +282,8 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	}
 	p.page_shift = ilog2(page_size);
 
+	p.seed = seed;
+
 	if (!strncmp(function_str, "all", 3)) {
 		for (i = 0; info->functions[i].name; i++)
 			__bench_mem_function(info, &p, i);
@@ -464,3 +478,85 @@ int bench_mem_memset(int argc, const char **argv)
 
 	return bench_mem_common(argc, argv, &info);
 }
+
+static void map_page_touch(void *dst, size_t size, unsigned int page_shift, bool random)
+{
+	unsigned long npages = size / (1 << page_shift);
+	unsigned long offset = 0, r = 0;
+
+	for (unsigned long i = 0; i < npages; i++) {
+		if (random)
+			r = rand() % (1 << page_shift);
+
+		*((char *)dst + offset + r) = *(char *)(dst + offset + r) + i;
+		offset += 1 << page_shift;
+	}
+}
+
+static int do_map(const struct function *r, struct bench_params *p,
+		  void *src __maybe_unused, void *dst __maybe_unused,
+		  union bench_clock *accum)
+{
+	union bench_clock start, end, diff;
+	map_op_t fn = r->fn.map_op;
+	bool populate = strcmp(r->name, "populate") == 0;
+
+	if (p->seed)
+		srand(p->seed);
+
+	for (unsigned int i = 0; i < p->nr_loops; i++) {
+		clock_get(&start);
+		dst = bench_mmap(p->size, populate, p->page_shift);
+		if (!dst)
+			goto out;
+
+		fn(dst, p->size, p->page_shift, p->seed);
+		clock_get(&end);
+		diff = clock_diff(&start, &end);
+		clock_accum(accum, &diff);
+
+		bench_munmap(dst, p->size);
+	}
+
+	return 0;
+out:
+	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
+			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
+	return -1;
+}
+
+static const char * const bench_mem_map_usage[] = {
+	"perf bench mem map <options>",
+	NULL
+};
+
+static const struct function map_functions[] = {
+	{ .name		= "populate",
+	  .desc		= "Eagerly populated map",
+	  .fn.map_op	= map_page_touch },
+
+	{ .name		= "demand",
+	  .desc		= "Demand loaded map",
+	  .fn.map_op	= map_page_touch },
+
+	{ .name = NULL, }
+};
+
+int bench_mem_map(int argc, const char **argv)
+{
+	static const struct option bench_map_options[] = {
+		OPT_UINTEGER('r', "randomize", &seed,
+			    "Seed to randomize page RW offset with."),
+		OPT_PARENT(bench_common_options),
+		OPT_END()
+	};
+
+	struct bench_mem_info info = {
+		.functions		= map_functions,
+		.do_op			= do_map,
+		.usage			= bench_mem_map_usage,
+		.options		= bench_map_options,
+	};
+
+	return bench_mem_common(argc, argv, &info);
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 2c1a9f3d847a..a20bd9882f0a 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -65,6 +65,7 @@ static struct bench mem_benchmarks[] = {
 	{ "memcpy",	"Benchmark for memcpy() functions",		bench_mem_memcpy	},
 	{ "memset",	"Benchmark for memset() functions",		bench_mem_memset	},
 	{ "find_bit",	"Benchmark for find_bit() functions",		bench_mem_find_bit	},
+	{ "map",	"Benchmark for mmap() mappings",		bench_mem_map		},
 	{ "all",	"Run all memory access benchmarks",		NULL			},
 	{ NULL,		NULL,						NULL			}
 };
-- 
2.43.5


