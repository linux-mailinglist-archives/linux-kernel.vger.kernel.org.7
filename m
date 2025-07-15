Return-Path: <linux-kernel+bounces-731630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85AB05764
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED26166B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ECB246BD9;
	Tue, 15 Jul 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CUcaTA2t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vC2bR4Pm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EB615B971
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573778; cv=fail; b=XksTBI5F4WM/R/tfJnm/zhvyPY8QVdSXKiIYMIW76XwIKr/qYVfNK38FVuEnX8feSdAbuA+J7s6R6YnIUsQxztH0iCChGIBSEqbmOmx6z61AXEqjcE8TE5wdS6hXzCxSGLXjelxUpgqgHMWe4mD29z6X+9v5GWJRcsCrltoB+/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573778; c=relaxed/simple;
	bh=0TH7MylKUw37Xhgv1j/HzbNIctrRT9B65NYrp5vRVyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gTkrGbmJCTvVV4ceDt8kIz8fiYbjSHAE1iMumy0QYVm1GNZGzircV6M6NWMuaB3qq8dQxz8OexWdQmDZvqO4x5SjhetHL5NMqjrVI3WENgm4YNgxRr0AW7/r1Vl5GYnwr65tjOf9daJN0WZdD+c2YEquNFHL9aMgqezPN/a9G0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CUcaTA2t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vC2bR4Pm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9Yujf020564;
	Tue, 15 Jul 2025 10:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GGV3NRZo24Z+4BrtFA
	pJeeRTZOG9s40ajBdFEyLCiPE=; b=CUcaTA2tt1day9tLoOhlaxrYBDHtEP9Oo3
	iEINVruqk4/nA9iumkVD4YYoTq0CSr8yn9wadOfcIf0Krnda42hTX+knpKMDmQdQ
	PuiEx8fBlDPhD+5AEF+AM+qU3PiwyP0jvaTXsr7jlU98k/mc7dfY3DpnKZRQvjOC
	LjdDuVcus/UBGosxBLCnwx7cUxagCtH17genqntYEdxtgMHcBIUyM2TSYwaO+fec
	KMYyC9rlPJrzqszawsHV/e5UmrAdyk0UwKU1uuWZOL6rqZZ4qKgNTSiZfCD+g/hu
	KvXm4mRXHNgMURF9dKcsXyEpxSuTc8na1UGSI+WBH18ipIfDi/WA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1axaw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:02:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9kCFl011524;
	Tue, 15 Jul 2025 10:02:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59rq0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:02:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcVCnLnhVqnNGMD3IrC1pOB0M3YGwWGZUxLfSdPq9LYS2tZpPCprxu8Tj7tV/DlDmPXXfcKeaWlRKw8VUdgknXnzHFAOu03HqEzDWNtRXADkwtCsPScwqwSRW3q08MU3gGFWrAzfepSGfIB8cIXHEK6Vfa3SNepJFJP3GKMDr8V5zLr/gSPcEdJt/3M2DWNf1ThX63CSEHGsHj6W7dUXmLgqPFE1PhUOj7pIQd0/PBW+8kdzG4T7Sk8WJoSPeRNnv7VUrMGgPCiiChuD32LiSyWPGDi+AkPnRO3rHiYeljReQozsVaPvRYpeDsWADol0F14O2MXv3VKQ5ghMAIoS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGV3NRZo24Z+4BrtFApJeeRTZOG9s40ajBdFEyLCiPE=;
 b=P3kbsXcXmoQDL+y4HwDxcbkEUh28WBj7V9jxo/0XbehcjTdXHt1YBaBc+FmIhVMcUBZKkcdIYV5WHDuOcMydRaj+UAKFZQao6qBUzLiwndK7R3qEFnswO8dGgvjUNp0IpwaSKjAHim0fmZD5/uMN085DCGfx79p1RyjRJc2yD/OVV6/hJfkoi0e5p4LZBxh5SpCsgMk0sc5PEQvTCekey5wprPRcgLHOTBNKzW+xNFdMMiempu0YGT+QHyyHydD7OtxU0+4+76vWSBoZvdR2dTiQ5SaLhv++qZ1lMsU/140tXB2NeEBtbmSvCSppIB8nfRu1n/1daNcQAcw45XVd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGV3NRZo24Z+4BrtFApJeeRTZOG9s40ajBdFEyLCiPE=;
 b=vC2bR4Pmd9yH+wirFT3YsSOYjfM1to4YMbVFeb8nAKxCePFnwPJRrzii6a3lfzjaJ/MMuzFyiMa76hnG7qx/YskYGmBCci9lYWhs3kBq+giYkQ1lXK4L/RJo5z7OeuA1zu3AmhmWgJVNuaNL8AJ3LT+8vN/VDFfeRaVUnVblQf8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 10:02:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 10:02:32 +0000
Date: Tue, 15 Jul 2025 11:02:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] khugepaged: Optimize collapse_pte_mapped_thp()
 for large folios by PTE batching
Message-ID: <7ce82695-f2f6-4a9b-a512-422e9efa902c@lucifer.local>
References: <20250625055806.82645-1-dev.jain@arm.com>
 <20250625055806.82645-3-dev.jain@arm.com>
 <71350398-b5d8-45b9-b05c-d2b63030f766@lucifer.local>
 <8109236a-9288-4935-8321-dbff361dc529@arm.com>
 <e9b027c8-9db9-4950-8d25-9984ae0a4de1@lucifer.local>
 <d58dc96a-4082-4a24-84cf-fed27b85763a@arm.com>
 <b82b860c-8ad9-409a-8668-e3db11b9f7a5@lucifer.local>
 <adf4fba6-f246-4bf5-ba90-ac1357024dac@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf4fba6-f246-4bf5-ba90-ac1357024dac@redhat.com>
X-ClientProxiedBy: LO4P302CA0005.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa37030-429a-4476-0a3f-08ddc386b77b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KVOH6UlaRNbhdAKKBaHisBZTR5mUcfBZ+ieekwLQPOrLIqH0aHLT1nK1Sza?=
 =?us-ascii?Q?S1LpLZpUprgY4gmAqelS4CR37pPb9XAIZ6sA2AAdXUfgWC5KnMEVJopZT1/z?=
 =?us-ascii?Q?b2UzRhrGnktgWbwdIzm2neM61SLp+xy6WgdrSpQ8aH7z/obIcyrhN2z8MzZZ?=
 =?us-ascii?Q?wuo6xTmTepdC0BJjMFuyiClbjDvar7F7NnOSbnUMoKp4+EdgDj4ni5a1939h?=
 =?us-ascii?Q?av2ryzP1wYjCcdz2kcjACqPeM90Npio1H4yr+pJcaiLMpXi3Hy7oYd7juW2o?=
 =?us-ascii?Q?KKQGQEaQ2JinejiAbLwIXnvYaf0boHOSKX4VxJ4wFoW21xLpm+4bcYNKoMP5?=
 =?us-ascii?Q?Dw37HYN0Qb5eIHCRGtbxWIt+WhJYLaPccVinEgEdge7jN805AuXE9UoDfv/H?=
 =?us-ascii?Q?alk/6Gilbv51At5rvcVgICt52FxhDuZzM2YjY4uxUYKT7OXWPgYhIoBscsMu?=
 =?us-ascii?Q?qSnmUONlsiXSlN+EJYkPniiq1EZko5h/o8eMuZnnYAIhBXF37m/bjcHIQecD?=
 =?us-ascii?Q?36FfHBLNqEyd5R9ubWB+06bjVuaeBElQBI0Sqypo90vz4lOtGmGonLclh2y1?=
 =?us-ascii?Q?rEZuDq6tIiFUhavPDDrt9/nClBWtQl/9X+G9a+zcQ81bOi3F3I9SWxSD6nUB?=
 =?us-ascii?Q?xX8Mk+nK1QOBEJMfQu6BZwi66wjhVK1YPYdI6llkzkd+PPG8ojBjA4RfG0u1?=
 =?us-ascii?Q?h7xSgDb8pboqvMN66XRyjCYIJeL7hRmTqlzCxOUVlWJ5CkSged5F0Q8bxMu4?=
 =?us-ascii?Q?7zfgyjHd0uubaTZVvCPvCRYXriQu/WEmaO8fhYAZ67zVhbJwnHXG80BjN3OW?=
 =?us-ascii?Q?fjW1sKs7oMwIIbfdgwi7wcjGLNjWKYOoZLJJY14SXDAzRrI3pvarHgvC/4Gy?=
 =?us-ascii?Q?1iSjH7hGX+AJtTwSqsoBQXViljj533V1ujW3iG4NbyO4L6G5AsCWn0nSg/7q?=
 =?us-ascii?Q?3RbRGo+fmaz8ec89uenH9geUrEBcHIcsUdldNGRxnbhL865EVi1Q0RhzJyTE?=
 =?us-ascii?Q?t0t8ng8c/xIAdrVUOsndKDZ4iyNh1YvaN5D+OyvXLA5fhXYLzmTBQ/6ducKU?=
 =?us-ascii?Q?JkDsd1ETOeit6WdtCd72c/oQELLMy+I+VFUy5uotUpgAt18IyZ4r/prdl1zR?=
 =?us-ascii?Q?Ee6/qWh+KcLJFsJWd5fkW5HhluHv74zzI3PILc8bkKgS0np1LtZULkQfP1xG?=
 =?us-ascii?Q?WLCm5C397HPk0yU2a7zyMesWaN5mtgRkhaOU5zNehvmy6iRAsEu1d10z+Ff9?=
 =?us-ascii?Q?7QjtAZONLQjezz/rfjtBhKra+sgn6U/LjobpNYxgPyNo2sMX7wcwpl1JarmI?=
 =?us-ascii?Q?hFP2oFl08InR+u6QpV3TouxhG/DLp3WVGKzSvPKTfQgsybQOlep2wpbVazGs?=
 =?us-ascii?Q?S0RPYcdNenuk8sPr2rocYW9sM/vtgIY394YKCEmdN8j7QHC4UA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WfUcCS5UW7YFqLKodHUf7dt/R0v7dcqYZ356BQqjE81MCaqRrPVcdlbsYW+O?=
 =?us-ascii?Q?kATTx9UqTtpq2Jr4ArshdwFD0B9ZQ4mJJBfWd0fbOJc1264KVqYgHlqOv1MT?=
 =?us-ascii?Q?OR7ONHls7uMZc+6lUD/ecHZPwY6B9CBtZaT2AehDSsunV1qV9yw/XGxap12+?=
 =?us-ascii?Q?zBYlhWzXI6JvekAeP2u62uqNlMA2H1H0h07rz5qVJbRzRGscyNXCNrVglJFQ?=
 =?us-ascii?Q?WcuQchK8gHShjlAzK3jprlVcWhJIOqFb+cNXjzjXYRx5aU64TToZuViStc0P?=
 =?us-ascii?Q?Idka739vlWa6mhjkAUQVb/4W6b4qb0KxG+b4W12VLQvzUf+tnDAChS4nbmlx?=
 =?us-ascii?Q?JGQPwLh5M497KZMbkY0p7yfKEVUdFkcMPJr9T114rYvyC/5sVPL5qHw3/qm2?=
 =?us-ascii?Q?ImrzyhWXaQlEZtHEQux9/MDCzrg+ivwfemDhfszPIB3QJo4JEH3aOGvxzxK9?=
 =?us-ascii?Q?poyN4zY07/jjGHU4AkHyD8lq4BOixU/6UeoiG0H0usE2g2ozgTHXPd/mMiYO?=
 =?us-ascii?Q?im6Cv9qsvN+wul0RTZ/qYUe3PNebdc4T9o1dyFhdRtSCUoFgIPfWFSRlq4AZ?=
 =?us-ascii?Q?ASdQNzSVcmvb76J8HjEQeDZqk4Z8YIDamuJzCxMqPIIuRsii5cvOH5kF3uR4?=
 =?us-ascii?Q?ZUv55bUL+KilmxQaQ5mnC5ucLlFSiNrx7Y1scng9KWSm5Q6ODhHJtUEM76Kb?=
 =?us-ascii?Q?mjdMOWDpLkqxjYMHMJnNpELCaZP/Dz52Sd+Kkz6obcCIp0h+XQTBUccDY2xw?=
 =?us-ascii?Q?pWjnORuGRFT1EsB/eU2t3QEdTNddp37g9JpJ+CEb+1qQJ1Nl1CPlfz9nDcpH?=
 =?us-ascii?Q?gUFqVKUOhYEuuMPTxVYRO898NMQPBZ9nkJpK6h29cLJ6a1rqbOkc/3Z/g14s?=
 =?us-ascii?Q?s/OHYXSKQVocqe/enZo0G3HSAhtRI5+id7BDw2IRHShulyzLc1Ae8p28QfyH?=
 =?us-ascii?Q?zcSHk+vYTZMDw+OwFQsODSCgREqOm4J8vYmg6sjowuNHC79c5ioGx2UtEh7h?=
 =?us-ascii?Q?10ZkxTTiVor1y8sMFordOH0Hdj19DIrvWgCzav4ICjnk52QXyxV9hbndGjp5?=
 =?us-ascii?Q?9PwH7WMWKhKv0IyaL/ETsRfpzCSkLzpNH59QNbjiL30touHTlLAB3BClMbTH?=
 =?us-ascii?Q?8QhPlH/QcmVb12dnlbeXyBv3HSBMf29OwHV8kYuhqXrfkKzYsUcrbj+h1XZw?=
 =?us-ascii?Q?/16SQ7Mb2m/ItDAq5+S3y74pcgAtbUsgMAd8GdLsIra//vw9R6mezQyVMYlN?=
 =?us-ascii?Q?cOqjsu6cMpUb5A7vd9wdd93dBQQWKJhJOoZWtnMueZHSuVKQCuY13/3VFcX7?=
 =?us-ascii?Q?zetkkm580fCEStjuT/r+zj6PgywxkNlYnJ2af7AYYbl4Uz0jhjbepZMOLSLM?=
 =?us-ascii?Q?VE/4Y1USncxgWy65NMikSVE+L7dGwwMvhYLBiOakt2rrk4mspcs5jnhlZQNa?=
 =?us-ascii?Q?+rfmNNR25/qerl8WzcOk0FPtO+NrdiXSHmPZdEJKXNAF84FmjMFuwdnam4eo?=
 =?us-ascii?Q?Etop/RPjzBmQ6/Hw/j9p5BxhBLad7HcbTOE50nWftiBps9Z35/DlQlXDjcB1?=
 =?us-ascii?Q?yz/1cboMeF7iu8LcWR496HOcBJaWcGcJzhC54uFblaSpTqQHuWnwySArOQ1r?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J4oDApLF3a7AW1Te+2jxmN5PT7sh9ILYNRRvoHQ1GTBBGce1MA5XiyWpGc6s4/C+66F2bgC/VxWr7/L1/1UUdVaKdwsLBZMhAuPIyTwAzV2JNESyJ+fkS928K2Uo4Il/zKD/NtqWx3dpBHG/4AdGaUzWg2S6w+fWH/ZINFJbLrwizFj6nRa8spBoiIFT94/0TdZnw1F84btH0kx3fT5qjW3C5Sot8xHk0KrXvczn29fsLD6BWzK30IJHFSe9ZE+QBVsV/orUucE5NKrXHyq2tGm6npoadY5khvjrdpTmOEMUKe/vWT1fyVUuz7ucwsO9ZkNyWhoAh/2ATMbwhEDycjJaESbLYRH1pqsHdTrH4tbN4NWp8qxtFIlMBrXvj8jXSM9oGHWOp7jZDoLDtEm7Ll+Zx0KTPyILMBml6cVNl5ZR2ZZPTaSxmW2nwYDSSlFn6U6PxoAoCIhXOoog4w4NCP2aVoxjyUVDFld0NrAoT6BtEWQh/ABHM4iPrcUlcwUh6wxaxPqAOrdodNSyUVUVqmjNkhdxwJ6heZABKBGkwj5+0vJ+NqzMFkkU1YDqr/4i8g2gAAB97YVdXGFOk2qKL74nvM/huIo2oLMd/JxUbos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa37030-429a-4476-0a3f-08ddc386b77b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:02:32.8443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV78CicKx/d04hdjjv4PPsgIN8OCJJDVKFciIdtKx3g+EyncwgfGJwOhfbU31G9QPExvCxCQY5lIhRzUOZ3c3Srt/ShfK6mLpi+nq6vNuSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=860 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5MCBTYWx0ZWRfXxMq4hE7NHZvC hWFnyxN3SMU3fFfg4JyUfaPpiTX+5EPzExE/YUu20QGue9V4AuZxS2IKRGnmkmJJKaWBbuDUDSZ hA4CyibA7xi16hTXQND0j3a/pxfABMqn5RnQEDqy4LCt4jggVDc14i4BfkKmAYjLKYMe1paKBoZ
 x1PBNsaZb9jat66XC/c9bd1mVWEbEswNnU9ULXDahuJShJCfCVuUGD3z5SwSyegyHqiOT+YAs25 RUAIrV7ouETl5Whidx52ExDAMmUSCtFV6spa3P1cQmtD5TTis4MVgKtsXR6BzhBSlf9W+cJaLzF MsBPseUfFaFYKWOWx/DqAAICSnbJ3KoFz7qLkf11+1yuAI2+fjCD2FsJSlpp1A6oEGyqlewStnW
 sEgj7L1LtAXCWiRKjheqFiX4QeBtUb2U/DCegG0FjdkMQU4LF2WkdI3w5+HakZt9VnH/K4Yz
X-Proofpoint-GUID: 3i519LCw20ttUtdidLU9B_FOaTsy5GAR
X-Proofpoint-ORIG-GUID: 3i519LCw20ttUtdidLU9B_FOaTsy5GAR
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6876273f b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=U6k0C-rBQdo8m1MFaJgA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062

On Tue, Jul 15, 2025 at 11:56:26AM +0200, David Hildenbrand wrote:
> > > > > > > -	if (nr_ptes) {
> > > > > > > +	if (nr_mapped_ptes) {
> > > > > > I know it's ironic coming from me :P but I'm not sure why we need to churn this
> > > > > > up by renaming?
> > > > > Because nr_ptes is an existing variable and I need a new variable to make
> > > > > the jump at the end of the PTE batch.
> > > > I thought you eliminated nr_ptes as a variable here? Where else is it used?
> > > >
> > > > Oh how this code needs refactoring...
> > >
> > > If we retain nr_ptes, then the two variables will be nr_ptes and nr_mapped_ptes,
> > > which is confusing since the former is plain and the latter has a _mapped_ thingy
> > > in it, so instead now we call them nr_batch_ptes and nr_mapped_ptes.
> > >
> >
> > Sigh, this is still awful. But probably just existing awfulness. This whole
> > thing needs a tent thrown over it and fumigation... but again not your fault :)
> >
> > I mean fine, this is fine then.
>
> Probably best to be pragmatic here: as long as the educated reader
> understands the code, all good. I hope I'll never have to explain it to my
> daughters.

:)

To be crystal clear here - Dev - I am not asking you to refactor the existing
mess, and obviously I concede your point on the issue raised here.

Did you need to respin other things here? If not I can relook and give tags.

>
> I know, I'm a perfectionist myself ;)

I mean if I wanted perfection I'd have run screaming from the kernel right at
the start :P

But in general on the refactoring point - I think this code is hard to
understand even for the informed, the endless nesting and nesting and levels of
'you just have to know what's happening' make it really easy to miss details
here.

What I'm saying is - we can improve on this, and really all I'm doing is
todo++. Possibly even dave_todo++?? ;) Or could even be $<name here>_todo++ :P

I find it impossible to not mention this when it seems apparent to me... force
of habit :)

Cheers, Lorenzo

