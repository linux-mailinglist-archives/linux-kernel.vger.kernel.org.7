Return-Path: <linux-kernel+bounces-795785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4AB3F7D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612507AFDF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9192EA46C;
	Tue,  2 Sep 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GP5Rdzpu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QMhWlgx4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0592EA17E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800560; cv=fail; b=JSHbLJaQu1mD7XA+9tOWFTVC6C6U/qWXdV0HPe51mHxf4qWVzWOrHoyij40Kl38Ryar68doBVv9+ArIFAXte4Q/9m+jrcgVzbk7T5W5wPYjnKg2fLTY+u2ybETMCZAU7XPBwmTs68xcZ3WYpiLr1ppJMLTJ35nj0vieYtOVlrB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800560; c=relaxed/simple;
	bh=zxdKxtQe25JhsWdzD3hNR9eTLtrFFmWHJMY/VSegL98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kgkFUVFvnb81UeVPPfJScEc+TzsiwulmJmrBPXid6PaFEl4GQI4spjdj5OAnmTaoTPu4L/6W1f8dEyEa5COiI7gQYSEagzu1qdUne4KwVMRoq2MXjHLZadoHZ5OafRf0WMaf44UMCXs18ti3fGSNylPtMN4EOqhuSk46uSigDI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GP5Rdzpu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QMhWlgx4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826gGQp016311;
	Tue, 2 Sep 2025 08:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VqoCzjfhEL2rdMru4TewvuP/h1Vc0PiNXOp11ZfZ85E=; b=
	GP5RdzpudEVUJPWqysEknOMHZhlH8un/cNx1IOVkqjJ0ZFoav9bZqp54iOMPX8hL
	xQCrOhmnZ0wRmdms85PpiF5VG+GIsI1ptiB0da1x20lom11YhFO/4SLYb2kEA1yu
	F2Ro19UbhJOJMbDomJDRCQdHy7MEDUOuTi7ztI76FBrTsZzExkKe/ZKVh9E0npXH
	EWRWRwlXRckVP83tmB07w28+9b55eHzUbV6Gq/AUS7lLvyW9QF+AGOEAWHNVo+u+
	KXA/xRKFhzsqZbY0Uu7qMDOk4EVdECrFm8C6GEuJH+Y8Pg5vZfNErbOkEmJnDrBw
	Jb4OphoioVfKSUEfsZFQiA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnbg7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:08:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5825ukHr032302;
	Tue, 2 Sep 2025 08:08:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrf3n3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3XkXvhMcyEAaiRfRuFR8tryLO0/aAPN3vosSUCvM3XEfWUOYmSQKT1d0qMMv7euhZmfVZHH5GhryOvFgixq8pab1emTDSI5xYxdnT2358gqsA7a8XgxFsSCdCwdGt6SDPMsSFgtsrNIeNO3XwPzliNiv6jOcQkTRvN5+ejtH0TSw204Uakidub0RWg50GLCIziudEIX/kE3Pqexrri/Fi+gRvjqgjFCrz6EPqLMBJAq/IcqJeSW7jx5EROGQqhvbAlsq92Afgc8q1y/Zrgj2gsxUaFVA6kC2daaZiUmI5CKefwms1OvR1bkOEytk/0rj0pcvJ72+xvcZa60IjmVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqoCzjfhEL2rdMru4TewvuP/h1Vc0PiNXOp11ZfZ85E=;
 b=m8DYgGGqgt/PGQLu6Ga4NAqUgavVLOlx20yVQZh24nPJY1TlnTjaxV9NfQo4j7PS/5PcOhv+Y7W8yRmGRwTYRQt8PJbVH6+hPxre5WpZpOR+Hb/hE/UiOSk9hWoa/f8dnOhsRPbzHyCIbxuev6ekIP4nM0VNXfxNXs128+dLYMx+KJhIzI7gENELQSNOfiLPseVWT7ihZkdy6U5pZUqq6jG0AN/P/7BFclVlbkpUX9LX7yKnQo+3bbCUzLbWz78PdYii4Ak4Z8jO6lBf7JM9Je4hPxKDAP4vx3y+lhyJ/EXrk5nFac1oDHCClAQJWb+UWN3HW12dFDV2D7ywHlwLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqoCzjfhEL2rdMru4TewvuP/h1Vc0PiNXOp11ZfZ85E=;
 b=QMhWlgx4fIeaG3UYfvO504jneXtxj0+puQv6M5oIEsNogp/qQSh4VUr8Fp246zcAR4itV1fJm1ZtBr3yHnqD2l3NCd3jojMnTQLya/aZpTl8rlm/mBQiRDk1qumS7xwJs3o2BQ3R6AMWXRw9rVeyzCtWWzXw5a6DPzII91SiMog=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 08:08:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Tue, 2 Sep 2025
 08:08:47 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v6 12/15] highmem: define clear_highpages()
Date: Tue,  2 Sep 2025 01:08:13 -0700
Message-Id: <20250902080816.3715913-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 20168ac4-8b07-4a70-e2dd-08dde9f7f188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnydAC8fx5y6BpI2uZ1+C1CVSN+jH+ZIzOylAcDY5/yX+upZPG3E5qwlqnJM?=
 =?us-ascii?Q?rKoAQV0FFBJvJslhPQl+kT8TzldgAJHbBUUbhbowUtxTDaHuo5pCVQzWHCBM?=
 =?us-ascii?Q?/LTBpp3E6KByzDUkbVVbYnMWW7Qg0G75UewwV1iy7H/po8TvwA2qSyI8FvON?=
 =?us-ascii?Q?BTam+Y/tapKaYF7lnJrqf6aaL7AgcLSo3EiEIgJfqkDkKLOD5NZ7+7OWqOYj?=
 =?us-ascii?Q?CKdyqu3M1VRx0CwTxI5IAd7eZnPft9PfNxIvNjvBRG5nMHlhbpBxhoSJyij5?=
 =?us-ascii?Q?AtIPAu4pDI2vzG7+KYGEDNRKywOdb9RFIur51Imf3e0uh5DNRKKqJyhDvdE5?=
 =?us-ascii?Q?fTkIB+WpCMUNZOxqdq8SrwiNNPlgv+Dnsi4t0SeEEODc+1Avf4clL5431BVg?=
 =?us-ascii?Q?NEQcRcUuUtM/pjEWMN+oLIaROanszBAxFIwbxTEs/JtlmBqSMO4yItPDohCU?=
 =?us-ascii?Q?eVzP2iO/+Nq8UqRZDCzv4bA4MTCaY5pu4pgrOr3A7x6Pq/R3bRp4lx4OGFKq?=
 =?us-ascii?Q?JAq/eGFLSh7VMOnTYRtYmDrK55zahertjQy/0UT2BsoPF+RkZXM9Udyz6uGa?=
 =?us-ascii?Q?tgj/XKCL7XSmJchSwdPvCooPQH85TAAbsZ0SQXvfo3BR0DpTxL+mZCvLebdB?=
 =?us-ascii?Q?wvFCfu+VVOs/0ShunrSSCKwfSlwK6V3By6MuLb21T6ksTMbJb+/+irGsf1hm?=
 =?us-ascii?Q?0153YzgRkYaj9ebw5BcthPuVmseLq62TxkIB2rhZvWpV14en8Bl4abNsfDdJ?=
 =?us-ascii?Q?QL6tvzfcmJ9ZqVRUEx/EpaZu8TWNpL+gPSHIpH2TH1kYcD7IB1vbOBSUh8yM?=
 =?us-ascii?Q?60plFzv4bJPkrsQxZDjPISjNK7Awhe3Nqo2cd1pK0Jud/D09XIhjFAxw8SKg?=
 =?us-ascii?Q?dBfr9nqjWoyAFubhJDYCUp579d3ECb+C1nqifWm9n2g6nUCcmH/OG299X1wJ?=
 =?us-ascii?Q?dHPMk/xLlgTTADjoXj+JeLPf/53tX9lVeI+6x+ZnS/b3Zv9e2eqeKfAf0G5g?=
 =?us-ascii?Q?3b9vsvcInAzSVNq/0Heodhz3Zxk6uA43+Q6XSqDlCmgQ576m7JVLy+AyE9zJ?=
 =?us-ascii?Q?G2rwo4YGVHBI1FDcMYRpbmtqKikGic4F7p9iIUr5xKKJHysQjIqOiRDg7/r8?=
 =?us-ascii?Q?T5NZ2QPymYAo7GM78vovYV2gbvmfzuci8Rrl3pdPcqGGwayENpOHr0j0aBsk?=
 =?us-ascii?Q?xS44iFb9J765jrJrvTipIANUs/bMvd9ixWFYwQGTZOAdcUjI8eB3nHJXcAhd?=
 =?us-ascii?Q?2QVWa7xK1l4NqLFgAXNBiLBUb2JTT6dsIfLWb5sIB4t4P+dGKL196CyhdjS4?=
 =?us-ascii?Q?5DXtxaAQI8Q+6EkAgYfVl4Ua1k+0Ymqfc3Il+KOyKIq5NOeKhYr8bcG8jdpe?=
 =?us-ascii?Q?71lyEVeR9xNoddHElkWMmY6cNT6tI26Z5y7n6a+rwmh+XHomqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vPR4BRiGja/8UFKVDbIhdhajIAslmuXuY07BCT30nBfpbJ7LawB26x2lkZX7?=
 =?us-ascii?Q?wcjdy5lfxrU4+tiLOXW7sNYQxFqXmKAjEkLzjRg2Iw19ome8oRaGXsgc1iEm?=
 =?us-ascii?Q?a72k14nM6W6FPxmvHO8/B9DTszY9tJ7oqVR3IVnG5v1/HW+KSHHycR1a49Pp?=
 =?us-ascii?Q?ZJ+qTmXniQlbPOD9A6Ch6qJGow46z9gB7BJ4rw2agm1bCYrVokL1cOVjlqAY?=
 =?us-ascii?Q?dystqanHwzBWmwe86KarFQYo3fRxVB3Jf9qC5uoCRnj5Xd9molfqKu6kCDFH?=
 =?us-ascii?Q?mC9yNmzFTUi+xET00tU6V85PDO2Z++h9hSeeUH6PCVljEMUwrg85HFj0lyJJ?=
 =?us-ascii?Q?6PmCp/qwhykSPU5iFkWL2GnO/VMyA1/uGm+BxRFE76XnDdSv+/GkHo2x0RDO?=
 =?us-ascii?Q?3V7VX7dS1d/soizfAGnpObo601b7KaCFnCIXbsyWwnL08w7b7mYC/J/edeNV?=
 =?us-ascii?Q?O6zY+AtJVRq6OYbq3wIoh1sfmbxfPd2mquSZOg+BkSq2MigBc/Dt5LR/Tpt+?=
 =?us-ascii?Q?CkFiwlYxU5dpmGBoYiHUuQI6PifmatH5laFTTLuogPuz+av+DsDdcjlv7TsY?=
 =?us-ascii?Q?2MkVNOKNf6ME+il20A9K/HpNKWxSduDRuw1IG1JuWa9j3WovbcrA3IBe493c?=
 =?us-ascii?Q?BgvExdhjUYHZ+G9CeqjwkG8yPBHMZ8NwVoDCM+ULwILKHubySK4TTXJjyVjL?=
 =?us-ascii?Q?5hWsJnKbjlrapBvEf0h8cpf0NKGS+ni1ZBAJtfKT3Joys8VSJkRUl799UOiZ?=
 =?us-ascii?Q?a+21/OBKAsNvK98TmbHmKdSc8AnMsqpIE//iXS6PGZp3MmRdHtjIXx2oglBe?=
 =?us-ascii?Q?D08xVLXrjRd4vW556zaKOxXFMMvZ+LjQ93VGXi8wTp98gP8l23Nln8IlGm6V?=
 =?us-ascii?Q?pVXFh5/U8YUBkYbpSD/9gOZlH0R66Ql18IARB1wQ29ECYoBuhp9b31sRlSji?=
 =?us-ascii?Q?zMzdS4qYqw0hPPZSda1hORWK3qrb9/1TnrqaEbqWH79p6MHeGhUg6L8sg2fq?=
 =?us-ascii?Q?stsn7R/E3B9+VQXuYkH6I6OlsCdtuzlUfhP84ozMKVuShP+d7/dXXsGn6Z/N?=
 =?us-ascii?Q?hvV/eKzkbV2+4yQxgFnquemfA0non2rnPvFZfFoz5tITI4Slbne0aHUWJ8O2?=
 =?us-ascii?Q?v0650Fk7Br1vFC0YdcAIRfRu9WkWXCzFiBApstWu6sElIe7NKorg9DWZQt7l?=
 =?us-ascii?Q?9OFv2euWeT2m2t4WTiQ12nnLoyjj6JiSUcWR++PJBbETWDHLd+e8kocvNOFe?=
 =?us-ascii?Q?oTz6hYrR7GN5u3+SzaETsefao81vTBzNx90yNBHzGbquxfOhvykC14DnTJZL?=
 =?us-ascii?Q?TYaI/XVyztP7hCMZ7ncbFB8m0uxGjp2U92cXgo+iNw0sug8JDqFOqZhvzvtP?=
 =?us-ascii?Q?AKfxyy5/rKHrZveIbhsg7cknUcx9HOuv4u2sDXI/E1pxjO/dT53A9EGl27dd?=
 =?us-ascii?Q?uogS9GEV9t7b758a8Kyo0nbnOut2VYB3nAxuPcu9sxO6682Yjwl63XanrNUe?=
 =?us-ascii?Q?EHM28UDP9lyEzgTK8vB9a7PNk/54eEQvcKV/UoC6WGYJ3JfVZ8FHBZJl+9UF?=
 =?us-ascii?Q?5HHeqnMwK+lfHcMNZLHdfWmx1qibLWyfw1/hMKIym0Rx8IDg3C2zRCCpI8lR?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fK1aiwcMSPtuMVEz9i7j0IR8e6KSqDrPcDzNL+cHprOz/oeHy4usQw4iR2quz1GUXNKaR28WTzllHbIM10/Evnagyvb+t3jJoB/f1WFf1WXbamXShYiw6XaUEMvKXnHHjNuK8cWzmZZUg+JHR2iyu3X5KfL9srNgMMFa4I97wssZb4PUHOcFty7IeukqE144bzMvXY1DvJl4x24RcJEXgkWdkhdD0p6DOwOQkKQ3C4JYhmSdMC3Y4B3P9p/wu7X9MA29H2upRiaGsZxnnJNedw4NRYFOTai0jq9xiFkBV8BqyBdR+TfLkDHHcl3E2PoJElAvg9+gIsTvkXFO7boVhV1nSNgrGJaSkBO+IV1+WaR/Ncj0t5KjUang5X2qoF13bGXGWApoUl/z0K51XLnWuCsE4argcdoMINigAXxmIN7Fqsh4abJBKk3OZ9/NdTfV/ehSYhwLOPY2JTyH4xraNOQF14W4voYiQN6iRII5SBuwYU1z5F5wfi36oOu2DCYX0CMaGCnInHSz//LnBZKroZzPl+3Gh2HI+oIv34YJCyHR46dOUUfXgSujd8qjjK2pwSQBqUp+SPC4lgRaJOqAn7UuaAsfEUB//E+LFa6BQ9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20168ac4-8b07-4a70-e2dd-08dde9f7f188
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:08:47.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ypz9bgBwZKIYWubHwornk18OI+2nTssc9DXobEHePHu9PQ0X8Hwcx8HLTjCnNqTLASST2j+ew6hGY3LyovvvGiQQTHwv10ijJv5TnyC2+Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020081
X-Proofpoint-GUID: PDTeiw3jLgAg4aLKQMak8JQm6ggNfMMj
X-Proofpoint-ORIG-GUID: PDTeiw3jLgAg4aLKQMak8JQm6ggNfMMj
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b6a613 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=0BMyZFS9aL5pxuX05u0A:9 cc=ntf
 awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX5ktpEREYcSAI
 fxmt0Fe6i/Ps7naHaADKZqn9mDqp9fFl2q8XghOqbC25IUrM+J/289IM/wbbiKVnmiAtI7hp9ca
 gRxn1cLZp1FHwSt/kvXiVbxUb9PDym0Bq1I7bX8Ib3nx/39xFZyi52YWHdX/hzs0e7h6S2qbW5K
 koVfZM+6DHOE5nm6cX3Yg/3N8Ip2Ncs5wUtqr3/fO+VBpy+6hbQ1tZctbibmom+KGTInFCUQ3gT
 9bQl1py2iYMr+lbyb6e9LI/5sw9LZbzO4tGB/5xlE0/LQuQf8F8wtykjOdxX/34DfiZrSOy+wSN
 iIlIRZvJ4KGwGOTsFWZu/KqziEQNUfCtfR9G3GZIKbLt/gMuWQQ1fTonVLuYAAiduF0NWoRQ4MF
 vv2Y6k3ZRKN8ClG26Bc8zEtTpOx7bg==

Define clear_user_highpages() which clears sequentially using the
single page variant.

With !CONFIG_HIGHMEM, pages are contiguous so use the range clearing
primitive clear_user_pages().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/highmem.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6234f316468c..eeb0b7bc0a22 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -207,6 +207,18 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 }
 #endif
 
+#ifndef clear_user_highpages
+static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
+					unsigned int npages)
+{
+	if (!IS_ENABLED(CONFIG_HIGHMEM))
+		clear_user_pages(page_address(page), vaddr, page, npages);
+	else
+		for (int i = 0; i < npages; i++)
+			clear_user_highpage(page+i, vaddr + i * PAGE_SIZE);
+}
+#endif
+
 #ifndef vma_alloc_zeroed_movable_folio
 /**
  * vma_alloc_zeroed_movable_folio - Allocate a zeroed page for a VMA.
-- 
2.31.1


