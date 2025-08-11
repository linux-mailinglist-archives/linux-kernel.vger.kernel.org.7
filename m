Return-Path: <linux-kernel+bounces-762551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E33B2085E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C018A03C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3335E2D374A;
	Mon, 11 Aug 2025 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZVeDqCUU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gn+iyX3e"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757322B8A9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914087; cv=fail; b=SWkoRWvsNZBLnb7aoZT+qkSgc0HL7BKpEq2TyJfEEpPsAGhwmTZkNF7Q96szo0SK8vYDIINEgBOf2Crep2gNVzuCZkiRXKAZydcB4JhQ1Wcjpu4VrA6L3ADLoRzoKBM9e8a7ldeAfs+uFFAUN+TJqw14hOfwZ81ZVauTx6APo8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914087; c=relaxed/simple;
	bh=RLw5niB6iHAeDxhU7GEcFPHAbegOFTHve15e8cdzkCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pZzzDywcLhXJIKx4qmXy4vawZOJGLMO5vjikSPRSIh7m0QhfD62C9GnLDUb5SANBcgZ3I3ForM0b3vmf6ka5mqEOm69WBzk7QDDO6508bBCtiGM/83H+XYFNTF8nKoIeJkGBrzgGGLGdOeGmnVQXZP/NE+kykLVoPpNJhY5KmZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZVeDqCUU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gn+iyX3e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uIbZ028718;
	Mon, 11 Aug 2025 12:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TDnGf7Rstv0B000hbz
	dzjMvtD4+4WAlW0NeZ3a7fbRo=; b=ZVeDqCUUwb40/iw0/WzOAmwOI/nMG5H0eM
	Q5+h+4qveuXxTm/zof23oWXN5gAAXdDFfZ4XnpMolyvuWDPqSX/OBn2cuYAvDnfr
	jyPEwVo8c5MmJDD5PzH3MA98LZCE874IsqG/zsqe4FOKbwCHvcrdTCyjODEUN2s1
	Iesnwk87piTMdQhvvY4hCB6z7euwXIwP0tNEE5LhoqKPCIfN7w0pOuRVIv0GPUuR
	5KtNxWcmRTPBaPyxi2r3omP9hz9okvpTqbyQGR7jfhklyyyiQHsHKkzzC/p/GvFr
	F8OdRuNvIRR+HXY98fVucOJ6QnpjIh9AK5r8EwxbJ7S0qjG/KDiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf2am8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:07:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BA3Ntg017482;
	Mon, 11 Aug 2025 12:07:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8j368-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:07:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNfzS1sNg+IwKKYK9wS9G3d04ASmQ5cBiE+DapIGxUOu1rIPQyakIEI5xVl7AOWqw1p1z4mP44/OmUKj2RPCrSh5i4ifEvmx+YD+j+6365h2lysIsjzuwKwMleaudzEl9kvRL1CVUHFwaUb9t/fx+0/JPP0ib4u17Jv32UZBrB8lfEPlspsQw5YuF1dv/gVztGXv/5+TeHzOG+iAJsczN4Z++FNXWs6cjmNilC2Q+akx3Oj24z2E6svIAjRGn65enp7AFGt5A7sBXcoNZPbOL2wbuogOqy6h4PSI7BpoYRBUsxd3FqwmuMo8Tz3jE32ZRvYl9TjtxY2JmMQ8LHTZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDnGf7Rstv0B000hbzdzjMvtD4+4WAlW0NeZ3a7fbRo=;
 b=gmw5KFEHg1UT1GueFsOrNwPSSX2A7wQouvP9jrVh7rAuWFlzVbnKfAyl2v1pVCys8zSCk3ackAABMR4+OWoDkY/Smq17uIuZv8ntzVHNug2BxxM/Db7m2c/AbeshfrveEGBcX6YNC/gZwoINP5x6XJH5If0T/pqgJMST/V1a8XS/T+7SPDlAjUOvPZVmaY+BE5Lu+YuUypB/odIR879PIs2XAe5aUUJyDkoHHsC+jQ0f1BHtZLe4xO9AYvuPBJd35cRCLMbsr5Jej2WBoHYBJawyhxWnXyFdiV7u6cL4ramOhDSK3C1kzL7WYPMTz7F2aS5XM4TBX+Id+3Zi7hhhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDnGf7Rstv0B000hbzdzjMvtD4+4WAlW0NeZ3a7fbRo=;
 b=gn+iyX3eu8IDV3wtbkGHP7bvyHwQFgzl3fZDVdabx/aFk/VjfGOCZEmmZosRpGwtxVXeR3fTsp0XcuyqIkt4AA/q42eeOs/6crTG/Lu+XugRFIG6j1wcwVfZQXG/Ouv5tiF1O+euYypfqKI2mIE6zn7jzer1omWOrHDtdnW49bY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:07:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:07:27 +0000
Date: Mon, 11 Aug 2025 13:07:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: akpm@linux-foundation.org, shikemeng@huaweicloud.com, kasong@tencent.com,
        nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org,
        chrisl@kernel.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
Message-ID: <46d4a5bb-5734-40b4-a5f1-3094500ef1c3@lucifer.local>
References: <20250808092156.1918973-1-quic_charante@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808092156.1918973-1-quic_charante@quicinc.com>
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c41c68-2fba-4129-20c6-08ddd8cfa36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aak9P4CRxzo4e0TfksYmrDp3mS7ylqhkjNDJjfSyu1e3ckYBYIafTDHbW5Vn?=
 =?us-ascii?Q?ava+qm/b8A0smts3VP29XZmEApCMliaEKarZ81hYARSwvk4xdhqT3hcyx0S9?=
 =?us-ascii?Q?FFTqVdyQdq6xoR6prh+tkrKbx9orHIEkE+Bu0vZ5GoLN9EvS4VZD9rLZhQ+p?=
 =?us-ascii?Q?TTzpnpeLzZrt3iHqs5GyCGNq1vvqL2paB+1rXy5dW16LrnHSceejzHfIREFN?=
 =?us-ascii?Q?qsJxWntvBapRi9oxa3fDGSzlegmUOWXjCaZTzTAkZ7320Be1lQ8Hjg9yNVw0?=
 =?us-ascii?Q?LMeg8gbfHzt3A7F/YBiVOIIgceOzMLpiXVHxDM1zHl+p4j4aceDkMrW83PzT?=
 =?us-ascii?Q?6XwwsUHXYuW4vrP1HLlT7nrRhxR3UIHP8wIqL1/OagOOJBEwdqUqO7fjA4vV?=
 =?us-ascii?Q?N5NwtMmHzW8l5NFZxfi2oF+H18HZ+nmevMUo4p71PHoxjkNXXwldrZfjoCkC?=
 =?us-ascii?Q?SM11L5itXb8Sx/XSlVx+87DGea5bbgPI2r8HgAImnOMXyRq1/6tnFDeIN9YQ?=
 =?us-ascii?Q?6pFOeMIsLePjh8VS3gmul7hzT8/s+3ivURwWeYXsQbcibUvruU0CSpp1TSDZ?=
 =?us-ascii?Q?M//VZwIbqUnzRxMQzabu+CRDF9HCsoEDDyNyDgCh8LMVzdFZ+dutX9pQBgjC?=
 =?us-ascii?Q?xNSJP2i/ly9uBsTlXPBYM1BNTZZ5q+TZcSPwW+pUgScX7Bl0JHbO8/jIEE3M?=
 =?us-ascii?Q?X5D7+7R+b8dr1opMBhWea1/UI88ID75XZLRrQ3ZHTKKyMCCOY+0q7dWe/1LW?=
 =?us-ascii?Q?D4h48zA5Bi9T+0pS2tkzkGLh4Oa9URHPEJFAnSbhPVgl3CzC7/+iewPpiXOY?=
 =?us-ascii?Q?sXQno0P94GGEOunYvCQ+tLzoLJEJsSR854Bz89fFXp674xeNim6EHOvoyrMw?=
 =?us-ascii?Q?6l9pRWVuSaN/SpZcxB23ImBODGfUg4MwylJzoH8DKBV3G2KwyyWmDGDm7kdm?=
 =?us-ascii?Q?jGrUTpJH7CBwBspqU22HHvgbTZ8XTAJibzyxpAFoKjZCwRUDlFnOfIFUBSJR?=
 =?us-ascii?Q?iDk8LVYW5PDatl2sXRCm3q1VtjeN+KWZFdmiLLN9ZqmUPmi+7wvIiPw4fhVF?=
 =?us-ascii?Q?HEwnmkDeZg0N9LsUqb7vHpNdJNizi1A+227NYc6GzyTig0IefnbxcRan2ncA?=
 =?us-ascii?Q?1tcotb2/E29Otpjd+hhwjCvw1eibC6l27RUBkSvwIEGgRE8qrRp/UmSxauoe?=
 =?us-ascii?Q?KX+H9BGHminsK3rr40f9ZdWacopFq2J+Ybse7ADIyKhWU1AbclLDKyp8ukn7?=
 =?us-ascii?Q?VcNf/Vw3G4OKsJOE8bQDOUBITGeucFGNG3HU3GEZu/M7u7nR+FdIlTSlauBZ?=
 =?us-ascii?Q?yaz39agxy5VNQHODVMA5HfGXCrQqVeVGz6lSpdYwNojL6Kov/2j3Fxyhcmm9?=
 =?us-ascii?Q?XaJCFHVGyI37raoOkYsMZWIXubj6hbvqby2Khquzb2R52pl8oCWoM5LmCth/?=
 =?us-ascii?Q?E4pY25YgFsU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L9uMEhUgJIL0s9JJ8yRWFrH7YUYohVUja6mxwvYDHrGiqdV/fnRKlIc5tSWV?=
 =?us-ascii?Q?hH96G66KBw65rjuk5JQM3S5HbSQSjpvOmk/Gd7k9OfvndigfgJaX7VUkv6YR?=
 =?us-ascii?Q?wvR6bzilte+pl5imBsIgqL7u16UKQQJugRN8Lt9EVvxu00T/3oNH2Ex95dGd?=
 =?us-ascii?Q?nV+q+EbbLVg0s2G1bRVUlhLFTYdaI6seGqd8zodUWjYBJwgD7UifIpqv7d4V?=
 =?us-ascii?Q?IRh+mhSonvMhzE5yAGHGZunumuXvXK9QGPM/CyaP9gQZHVVLQq+m2MXGV4C2?=
 =?us-ascii?Q?S8nDBYhOzFWpbEJS/6v2Qxy42LrsCl4M8QYlj4IU5on8dlCp6Qb/DVhaOlxA?=
 =?us-ascii?Q?uBJ85j3rgF32pgiQvvR73zL2iaZzaSvi8ZgnbC0DGfYUcBwVkbnd5XytlYOb?=
 =?us-ascii?Q?OJvup10u2vCX8DrgWSrv/UBeQhNo4T08YAMm0K946XlOL2ImLR3RiVipC7J+?=
 =?us-ascii?Q?ENVpbFqMdavb3+s+YwYvfhqnunYHSXTKCbachwXRn57Qm681AejjOTetGMR8?=
 =?us-ascii?Q?ExMqjBaxaH2B2kDgtIViSYNAosc006VIkolwh3uJY9UvCS8shGtMv/BfWdzp?=
 =?us-ascii?Q?BDAt76jd9pYrvFVWZdlmacI9JwoSWJSX+hXHA8X80upvEJ7sI9Y7QD/ile5z?=
 =?us-ascii?Q?qyxMS9wrv1dEyKDUhA6mD7YRCUIdd3RpoSjE4bXrHAMi9hdtm30yXXsKhu8o?=
 =?us-ascii?Q?JaAeNwEmVwYnx8yho8Iu4pF3ioGPQ9Lk9zv4BqwFQJUzHl4YN0UTmO1tMvyI?=
 =?us-ascii?Q?iOw7poJAzvjjDalDIF9oj0sR2VvqkRCE8RF7OpQUEUMW31tfGKipbBii8bcf?=
 =?us-ascii?Q?1k0uqgzNOZj8bjvOyPudd05ygWaxAfRuYmOQvL7zNnp+3TKWCz5wgG0kzfXw?=
 =?us-ascii?Q?hvE3t6hi4grna4hK0IDTfKQTVJLzSHTOK76mMPjZMLruoEAT0KW+86hbvTWX?=
 =?us-ascii?Q?m0P+K59/SSYZXuMTEwgfTLTaYfCGJQlmp2KMXOiDnH7IrmEA3UZfkXYZPCJ7?=
 =?us-ascii?Q?RRUrUMD/rOPP6gjSseA6bDi5grz+hwvF885cEBM/wyd6nwuo9Ct9YbMUm4qi?=
 =?us-ascii?Q?DXBxqcWIqUsIeUuHXGQ1/VK0mh7kJS21azjnlTdu02cUfLhbp08DG3RxKUF/?=
 =?us-ascii?Q?eBKdKpiovWXQPu+fVoMOU8eviN75uPxt8t98QQPL0NsD0dFKsqKVzMiXcgaj?=
 =?us-ascii?Q?7u6sgYL+Nonmz6Oe8Z7lhlGvOHhsSl6aWgVE9Eude5U9scNQ90nfDnIXlEYq?=
 =?us-ascii?Q?sO4oL8fyGyF7R++xuTT964nd1BFBoccsndU0v+2rqndE4/Uk5H8wIGL67zo2?=
 =?us-ascii?Q?arBoN6eMGD+n425HhYTq83ETqNg4U8HWHKk8JrSrhC50MGiXjjdU3uTfq8v/?=
 =?us-ascii?Q?3jEsIABA2Rqk/kM5/DAkZ+EkGsAHeJV8jbkw2qGiMSZdj1U4U4TqMciawKGj?=
 =?us-ascii?Q?kXyt2q7rRVQVBESkrCxNUkhd2vZRGEJ+P7xLu55HiQQLrDsrjDKK1Z3MwrZF?=
 =?us-ascii?Q?mFG5ofLLaWlOfeDVDHqkuKgGTkUCAl04xAH22cWR+9SKLNcMJCa1/k0PUq+5?=
 =?us-ascii?Q?2xChn41iEuz9NM9aVlN/xFInp83cYTOouuVKgrG3p8PNm50Jmwu/3uYZympF?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EpE3JA1maMVisMKjOyGKAsQSDvxXjS12SrJRNgW+49Z1PDLPKbmUVflLU/xkn6ub50KQMY1YJ0WBpJV17d0C2qy8jogH25GRrkLh/wKimp+0ocoD61EWKskkSyxwi9oD7V/0AzqEcpQwCXJ1rOe35e2bSdcnEiKAJfkOsc25/NrVMjoRYQHIRJ1mu0Y+gon/IM21X2gEGZvKoPWTc5McDQLoSFDugCpEgdk8Awj1QbJQdzqcVxa6O1TETI3bMabRiwfSo1KX6vMb+8OnhvS7KDLByGzhNk4zepC2J8sqZJ7X8IildFRlHIcIEcxSoIVOFLWXWRhQtfz6oCoF9BTsNcqYcFypWGZ3YW9xxvRDp4vWxduc0iBzx5WfTWoiMogG8kqpzVSvQ0Kj2NwCund2OjRrSJkPyRZzgd+hs7gfJkistahuJVcRuoBfwu1GAltuZG8E0WVgkCGh/spT+x48PuxqZi1ehI7kavs+H/v0/qUXMeCjm5Utrrza+kvzx5wqwbeAfoqvpR1mXIbfCxJHbJI1xtKfObTZQpDV9KSmUtmrgEGhGgMCFQTz7QAF6ZVj+myrGCVCMpmUiwLWnzTLunp37gC2UGflSm349KVDnT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c41c68-2fba-4129-20c6-08ddd8cfa36d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:07:27.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5CH+kZdOV73qXlkn0GxusAkYOZq3xkYuDeMt0iqcaXv7Txx5dqB+ljUQF+W9r7SvpzYBPqOyDA1Ya5rsEx1n3n8WG7X7lue9T67XFMJEv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110080
X-Proofpoint-GUID: P1IFoYx_qcuP3k7L_Wy0c4rTQxwTXQra
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4MCBTYWx0ZWRfX00N3vsPToHNu
 n0ml+bDfbyj6QvvUIsI6dSUvSBX1lJgWEFuLwpltVq705O0lPDBV2rQYMLqjwg38SqjOarQqKRs
 UVWNqtuAKw9/io3T91nX5kpd/nQjNGXeRqJm2LE5ZpUZto+zACmmFjjp8OIlS32xdFSmbhSHIQt
 Lqfh+/jsUriSzq5YWp5U6BMKBkhdK7cQrjvazbDnvhD0P5kltHh4hkuMm1IEP5ZP/tdtrVj0zku
 GUwLVl3Yoifi//cN0L8hlTY5Tep8DT6zw47UfP5/tY6cQTEbIszhfyJbbxHXsj0mGHkxOmBw0/i
 p5sfnPW4jKHAjyliXzl1RarLFr4fv33BHleG+uiArvKT7TH53hbuNkiaa0DHv+jIcqph1Pz8c5L
 hZK2AvFIZzLolLmXu9xxu0rYEzChLZwAFwOz1rYcOiKsuD2ocvTjFFqWBmtZhAftgTauvmAc
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=6899dd02 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=COk6AnOGAAAA:8 a=2CSkBLkUDH9fJauFa50A:9
 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: P1IFoYx_qcuP3k7L_Wy0c4rTQxwTXQra

On Fri, Aug 08, 2025 at 02:51:56PM +0530, Charan Teja Kalla wrote:
> It is possible to hit a zero entry while traversing the vmas in
> unuse_mm(), called from the swapoff path. Not checking the zero entry
> can result into operating on it as vma which leads into oops.
>
> The issue is manifested from the below race between the fork() on a
> process and swapoff:
> fork(dup_mmap())			swapoff(unuse_mm)
> ---------------                         -----------------
> 1) Identical mtree is built using
>    __mt_dup().
>
> 2) copy_pte_range()-->
> 	copy_nonpresent_pte():
>        The dst mm is added into the
>     mmlist to be visible to the
>     swapoff operation.

Yeah that seems really not right.

We should only expose it to swapoff once the fork succesfully completes.

This is surely the correct solution?

>
> 3) Fatal signal is sent to the parent
> process(which is the current during the
> fork) thus skip the duplication of the
> vmas and mark the vma range with
> XA_ZERO_ENTRY as a marker for this process
> that helps during exit_mmap().

Maybe we need to think about doing something else in case of a fatal
signal, as this seems to make this wildly more likely than an OOM or such
mid-fork that we've seen syzbot's about before?

Just a thought...



>
> 				     4) swapoff is tried on the
> 					'mm' added to the 'mmlist' as
> 					part of the 2.

Yeah again, why are we exposing an invalid mm tree to swapoff? That's crazy.

>
> 				     5) unuse_mm(), that iterates
> 					through the vma's of this 'mm'
> 					will hit the non-NULL zero entry
> 					and operating on this zero entry
> 					as a vma is resulting into the
> 					oops.
>
> Crash reported:
> --------------
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000446--> Loading the memory from offset 0x40 on the
> XA_ZERO_ENTRY as address.
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
>
>  pc : try_to_unuse+0x188/0x79c
>  lr : try_to_unuse+0x440/0x79c
>  Call trace:
>   try_to_unuse+0x188/0x79c
>   __arm64_sys_swapoff+0x248/0x4d0
>   invoke_syscall+0x58/0x10c
>   el0_svc_common+0xa8/0xdc
>   do_el0_svc+0x1c/0x28
>   el0_svc+0x38/0x88
>   el0t_64_sync_handler+0x70/0xbc
>   el0t_64_sync+0x1a8/0x1ac
>
> Fix this by checking if vma is zero entry before operating on it.

Any syzbot link or further information as to where this bug was found? Was this
on your system?

Has this happened in reality or due to fault injection?

>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  mm/swapfile.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 68ce283e84be..91513830ef9c 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2245,6 +2245,12 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
>
>  	mmap_read_lock(mm);
>  	for_each_vma(vmi, vma) {
> +		/*
> +		 * zero entries in mm_struct->mm_mt is a marker to stop
> +		 * looking for vma's. see comment in exit_mmap().
> +		 */

This comment needs to be _WAY_ more specific, and talk about the race.

> +		if (xa_is_zero(vma))
> +			break;

Yeah this seems wrong to me.

The solution is to not expose an incomplete mm to swapoff in the first place.

>  		if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
>  			ret = unuse_vma(vma, type);
>  			if (ret)
> --
> 2.34.1
>

I _wonder_ if we need something like this as a temporary hotfix, since it's
probably not otherwise harmful, even if it sucks horribly.

But the real fix is to not have swapoff get access to an invalid mm tree,
that's just crazy...

