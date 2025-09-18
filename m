Return-Path: <linux-kernel+bounces-780053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60EB2FD10
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BC71D0348D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4842DF6E5;
	Thu, 21 Aug 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rii/t+cg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KlEyUUuT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BBD1A9F8A;
	Thu, 21 Aug 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786464; cv=fail; b=uXRKCHUx2/gCBh5dUeFTxBShWKBld00eUKV7zbYjIb5FIt0GAUTg1pm6ouh28tEv9+qEf2sR7Wn4VfSwVJ2Kj7x9+EXvJlLhAwDJTRSgYFHMEC8rZXIevkiKDNbkO7x5P/RtA+oAOibP3XRA8oywE0Of5dmDTVQyF2V3Z6G4TFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786464; c=relaxed/simple;
	bh=UOoCYg1JTVj4760F/oQMuhlOwj3bdHlyz6RWg1EOIBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YdRHJv5Qbb9LUfzZLFPTDBNemn9nY+N3aSDYk/nfJGNJjDjCVcMOP+7btZ23Gp6pwlEEh1Z6CeH+DqxPmI1k7HoROCBq/h8HU9mUl/CGEfSmzk1l7NwYnabNupdfcUjy650aUjj9OPXNgq+fmY6OQr6w6yEUP7u2vSrYcyatuf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rii/t+cg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KlEyUUuT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LEBxlc019544;
	Thu, 21 Aug 2025 14:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UOoCYg1JTVj4760F/o
	QMuhlOwj3bdHlyz6RWg1EOIBA=; b=rii/t+cgN3ne2VW39TZCfBB0x2ujhPOAlr
	2L+7GJmAfhBc+k3IJLDMml/1FTAW6umjBOiapc+fcHQh/UXsbw3UnIZ9AX+lLaFQ
	D/4Jd70fnxmKGWpoEWFe/cg5Csk4kUDyPfI8gRX9OnLJB6TRDp9ec/TaKcS0z7PF
	eZW5fWEaDOLCMsxSoWFqA8vyIb3OCfh7cG9Bgd2I/UxKBe2ANrQ4MwrwXaVgVlTL
	3zNfeo0hZcjpII1LTyoMu+USGitONLF9KF5YSRiaGGpyOfEj1iv2eEmQXm4rYsvy
	ZUhkM+lFrXluwkqg7moyU1q9rb6iKJG0EPm0kiGl3Is/zlntxiew==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tr3jxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 14:27:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LDwiq7020632;
	Thu, 21 Aug 2025 14:27:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48nj6g4nv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 14:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcswwiU2dJD9sys831bwyLgjSrS8w7UACT2xHpxgsQ84GfM0VSgl090cUMJrJ4ullvAIRwYXFa8KfcDkDrH/ZuwaVNOSeOsPwHqyyUXCNVBsSeQZsTaIG6UP6DIOvlN2dk9ZjXdz2pcmu8I99QusBy6MM8dJxZmEcMar9f1J8Hj9pjdaRLUENk9qqhoIR5QGGBWDu8djZbUVdV2XMO4mrBaDjBwWeRZWALOVzNdMVIPM/DE2zhDRj5w+mdvIGz3GJMNzpiEXYLeBsY/M+YIpQAsIetfjMOwL/Ji4P2o+4nV2o60KO7XrOzIDi1R6G3Y1WB4dFm+O1KmS5klBqc+7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOoCYg1JTVj4760F/oQMuhlOwj3bdHlyz6RWg1EOIBA=;
 b=eNdxROBB4Y0dftLnDwWGhQgFNOE/iG/aaQUHUKC/71iKaIuigumDFO2Eb2sPfsqB3lU+P5u/+tBtl/hyZ4h/9N93GT2xPF0VShpruuBWx+RdMnkTYDaZxFHtUohfcj8Y9hoJKrV1LrCFc3TdAxX7uXxaPUy0f1yiRTTGP3LitaKJt5zIso88dT66V8wky/k+G1ZJhJ/at90UZjteR0nCQX+58snq0xvHmPRpvc3HCN73na+xid+tblvy/XxGEM/oYA5lylBCf8hBz+rec6l7sj5DeV1a3E+1CQi1knwDuizP/3a6VRyExU6tcgfD5ZkHwKSrupNseztFf62CHsqw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOoCYg1JTVj4760F/oQMuhlOwj3bdHlyz6RWg1EOIBA=;
 b=KlEyUUuTYjBSHW/44G3wOAot7rchBUfNkRPk39ooEkAHvp6OcYNuxyk3RvYxViPU1sabqtSLGsfXAxqppPw4kss8b4N7AeuiVPBJitJMi5Xys0h/BdDta3I2AL3e8kerDqpA/ai3H7TPCYBBm2X109B1jqVMpH6DyENR2ctjMLA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB5685.namprd10.prod.outlook.com (2603:10b6:806:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Thu, 21 Aug
 2025 14:26:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 14:26:58 +0000
Date: Thu, 21 Aug 2025 15:26:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
        corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
        tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com,
        jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 10/13] khugepaged: kick khugepaged for enabling
 none-PMD-sized mTHPs
Message-ID: <8f640d64-5bd4-4ed3-a108-8b85788c4f67@lucifer.local>
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-11-npache@redhat.com>
 <d9a02ed5-0d6e-41e6-985d-23f5a2de093d@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9a02ed5-0d6e-41e6-985d-23f5a2de093d@lucifer.local>
X-ClientProxiedBy: MM0P280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 3704ad9c-5961-4904-c7eb-08dde0bec958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pwYQ41hOHA5lHRNQtP2zAAyRPcrSvvc01+ptoTekmn+9V79WisqUyw87TO4g?=
 =?us-ascii?Q?KR2MmgHySbtJNwH5bQhofq9llTzsa+TIuP5zt1ik2zqCTSOmQFFluzIS01lC?=
 =?us-ascii?Q?iELKCyxVOzxGlZLRfPn7VeTQsip6xrthAeJRVquBRxwFLtJi53WS/HT5r63M?=
 =?us-ascii?Q?/sLNGGrgZ0iXEzEjRjn8egs7J2I5eKsmrDnYVAtU5IFhkJsu3q+lGv+FYJZy?=
 =?us-ascii?Q?gnafrFv9JcqwZholtzEidQOC86QoIo2YdMsVXtpqpEMZu4NXAV8LFMpm7lsP?=
 =?us-ascii?Q?GVZSotaiqLcNvaea0YChteUrBcVjJVp4d2sH/afNvRXIWS9bQzu2xGr3P7fz?=
 =?us-ascii?Q?dSAiZiLfJv1zlP0tdMsXqFQsg86zKBZQLB6BaP/FqWF5MNLPCu815/dbAfXx?=
 =?us-ascii?Q?hhMwo9eFQtUoerklXknKsP4v5Dyfpr9b9KjlIfbBFP344NuTWkEfxYezwXCc?=
 =?us-ascii?Q?DiNHQYv4iqfCNdG12ss6QxkZyMjt78wZ/mZUGz2I4jYDtD9xZc8RnTjU7/E9?=
 =?us-ascii?Q?BhHQZlU5S66yfCDp/nhbKu+mcqVZlVebtEkjyVxEgyEgEQh0p+bTRbrCycmy?=
 =?us-ascii?Q?VLk233fqUw8kLVm33KXZK64J4mencZQANulGvzE9xEHghILHliabCtGdEWJG?=
 =?us-ascii?Q?8WfwFobOVOMvlcF/2gCYOaPKtpoX+jqJRuH/uGI10VrfkyY71hsayMtLrjrQ?=
 =?us-ascii?Q?rh5me540ZHPlV2fCVJMcGUqg2cROrFL1alnGzmrwvcH5x53/8GREUzxTnwSl?=
 =?us-ascii?Q?zd1Lf76smw9OuzDyRBtjJ2HexmNskEvvX/jhUF/ygZsap4Q9DcZTEVaQb9l0?=
 =?us-ascii?Q?9sZyCs1kyUiuHo8GdSQOyQN78ad6OaCgUBMtt+3G0cwTbrK0hIOm0/uJ3NKE?=
 =?us-ascii?Q?NkCElGNwttzfSUCYYY14fw/J7oMwocqv58hhL5uykJyLZZ1y6fMYDPXfS5iy?=
 =?us-ascii?Q?x+v+O30snEQJ7VwdJIT8gE+3+5is0eTBy6dxA5rofBPGh7VM+4Q62zD0y6dr?=
 =?us-ascii?Q?dl+pUoZNtXL75s1YmuGykJGS6Sk6qbPJUjNub+iIhn7T1OKp1HpXPLUGiKhO?=
 =?us-ascii?Q?PMig7FrQTkbVrqzSVCy7fem6nJySQDkoERW61nwjNpAANn5Ob9vbe+ArYFPw?=
 =?us-ascii?Q?fjDX3hfaxZ2jR6IZtH1zvj2XpxbIJ5kHKmbwLZdEAIU6rRJQdfhrNIT2NCRV?=
 =?us-ascii?Q?jW55g5EkZJO38EeTQJv+zjReeDJr4wbumXFZNRJRQ8l3JrqA1d6Fn3t7cI18?=
 =?us-ascii?Q?gnepB0bJIWrWaInzMtIG/rxhyAhnxH8jJDCJXX6koVqnBJSh7ZN2ms3e3iTz?=
 =?us-ascii?Q?RH+tEwM/LsnLdZ5yOvsFL1dYGRtjNLYzYmZN4kb2DbYPa3I9Z/iCXNtWjUHp?=
 =?us-ascii?Q?WYn1bzXr6mEJKHn5yarKEIp1pPY+iFEv02cYy9zZeRicbTmuxZjZ52do02md?=
 =?us-ascii?Q?hvPBKP2nkP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?THi+PvZBruJP9qsQWuXsR1iUxHLj0lRn6R3ppz/d+pHr72w0vXfcI9NRikJt?=
 =?us-ascii?Q?Z9/R2XR05ZtfUN3dOLbT/MjaY2m5cQOqw/ZGWonx6gHWBTgaHi6k1qnM0TzK?=
 =?us-ascii?Q?M4GUTJYgjf27UoP8LE2rZCTdntoXjt2Q/towyVjFtSMEQZudZYkjUni4lruI?=
 =?us-ascii?Q?7BTP4SZdZ0sn2zVJGZHlHgieVmcnaqWv1x0Mwib/LnRiYax9FLhLTLJt1q5w?=
 =?us-ascii?Q?bMPP7pL7uWB8MjSgMdPsX04hep60jYucVuWqP28XTkcgA+Au0d6gfpBJeEIt?=
 =?us-ascii?Q?/3v7iNTQCHyMKtnmtldd3FY6h0hu1IIvpNM2cRZfgg3XoZXJQl9VpIbRNW6d?=
 =?us-ascii?Q?6FNdCN3OYp46+imTmfcZwGxXHUU1FAWfmV109EZcP79NTSK8lZEanWSjAjNT?=
 =?us-ascii?Q?UoLUPHncWIMwdHMJEUatveNRUyoSJ53z7QhhYb5F4RjeDaFXNdlAUNC2r5Ze?=
 =?us-ascii?Q?gvwsTSGv5OXVUsLb+9Kyp8Gaw2LhfDIbO6RGKy4sctg7cERBV3ZxKeokhzt3?=
 =?us-ascii?Q?ifjHZ30UhyDOnIZkX5yMH5j/OH94AsGsxGCze2R1hEkSvgFfMLhQm0WAy5Pq?=
 =?us-ascii?Q?h39WVcysn9jYOoM/+7z9RHU1jjmXizGO7S1vu+bl7jtyA++v+yCfpRQ+U6p8?=
 =?us-ascii?Q?QI22yH0md+sWMnfG75C/984GLp7zYq5WFbl5DkqT2TgSdk7GXK0O5WYgSdAO?=
 =?us-ascii?Q?nLPlStwHOfRmas/9QjCbCrB8kWDNg/T42X5oX3aMwxvveLFkWFMKkZo9cRrF?=
 =?us-ascii?Q?RnhvwEFHecsZSVW82p0MPYnsVeuyQvbZiaH475bWugxaesV3M0dcfF/Z/4gi?=
 =?us-ascii?Q?hpuCyRjOIN1LVG72cvIciMKW3BJa4VMMGMDatI8Tp52ymCzR5Pa8uelAXlBV?=
 =?us-ascii?Q?kVV6tjA3P6J4vR23C13nlO7gym3laZJt94vW665ZA81URgQJTNpHJ/ku9o/C?=
 =?us-ascii?Q?zThichtovjilnBsbDYMSwbzHVeL2V5QtbK9eW6G6Tv9NwHDLToIQQitqOMEF?=
 =?us-ascii?Q?HcktQvtZILF2rJaW4tXum+sLAVBGJXgnfj72OXKoHYEw3G1ZsA6ovMhMQzhm?=
 =?us-ascii?Q?BqpO47Gp7u4mcM8jSL69Ha52Mi3qpUTt2YkzO0ZXfuv1n0fuGnoTxcLf2RiZ?=
 =?us-ascii?Q?1hNyz/pVKjOKkco9oejY2bPb74t6YkPbXUU6EMiubusXFRe5isxr4qfZ7PTh?=
 =?us-ascii?Q?p6xZospeQ33IkXiQPRMs8R550GTXeksmOZ2jj7Dwbx3ASkfIa3EnRJnCuzkh?=
 =?us-ascii?Q?0nBpkABpktikONwfYF9Y6/URBEkYslAsYlLrD09yDQSdU0GO6pIpKMNDKsA7?=
 =?us-ascii?Q?aUkF4lRNGhQ0vjoZ6ZsstA/GujEDXkJK4r6auVY8PVsLWtLeKVf/Z+bLxKzZ?=
 =?us-ascii?Q?cB3cRn5K+w2H7zASLgfcPW1XBUT29IkwdSlScoF9RGgMhsc3uERRm4W0YT+m?=
 =?us-ascii?Q?9suVXtU9pI18UVz1pyvfSrY2YFf0xju67JIwlalYV6MVHVeBSpzKItEWPGWp?=
 =?us-ascii?Q?nT0+WJW7ULFC5y9Z43IvQZnlMnzbDrsk7gZk1DaUP9ZTMadrE2WqcxxyXTLW?=
 =?us-ascii?Q?SaUdBO3POsfEAsQ57cD0d0AnHEdJAAjKE29C4dVYSbe1aTD7vTgnT8N/6sx4?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vuv2D/3NSUja6Su0lKKxxa5gbDQG3dXIMLazbc9ijbgbKxTDen75D2Q+L6RPtq1gUq60AyuJmFLoI06TkgC/tdN+DtckJjI07CPxDlSeUa9GFP3Zek/umFNRwKoMRFWOTfgi1Lui6GTcNRjOTUA3e3KIhA598MjuyRe3bVUVgd4vHcGnmEf5mJO+E+BYxtxLK39OI5u01JKX3pNdIRly04AWBySBKTGrG/kKUgD4TQZKq5iTNSl7D/LnjBT6uMk9apdh1sV7yEuGtg8ZOcfbEHBJbJxB9gOZ4GrHuJch6Bh/W7EqeEZvYvXIg/wM3hWfH2xdCxfCZrMcAls7UkWZjXkB+im+Kq9y2/J3Xyk2Zv99orXVsmL9zgbtHB0J5H1NB3QRHoDN/0qQHxkBl0TX5RGYPsw++Q32undNIJQ9H9iLqd7jv21XCieWNkv77E9UifHj7HHaH3opE/4Eg6i++BLMwjMqbpDFKRhxQhDQ5bg0y93UbyN63Gf/JaWMk+gDqgpCw3gMQ/OxfJCKNFIM7J5Epf9VePuVie5qo4oJuZVcHxYBij42IKRwqGw/wC4op/UmSxH3Ja2xkkthOcviingskXoDOuBSVLSoWWoDmKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3704ad9c-5961-4904-c7eb-08dde0bec958
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:26:58.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usd8uV+3vTsYijuXjVK1kaaqkaX6uMyguDoC4W6ZR7ai96I+hXq/3HzFZWWi+G9pcXITRgjF7/riUVaLDcgOn/zZOQz8vLxfBCUz618G9Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=720
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210116
X-Proofpoint-GUID: wnCqZpq8h2OoBTlkHzBsg64nsi1wUc-E
X-Authority-Analysis: v=2.4 cv=FY1uBJ+6 c=1 sm=1 tr=0 ts=68a72cb7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=aCsQUMTWovaOMRiWN_QA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: wnCqZpq8h2OoBTlkHzBsg64nsi1wUc-E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXxmn8X+rVop40
 W3tJPImZF0zHiaIHiAVpA47//NOHXQ0Ch5ZAAxrofASxeSUKF+qI8V8Wrqf033U/+PP5Se0ue0p
 1pqPfkM8fycQMyijNlPtm19OVBGah+jWvPZywlz2BnqPdT2s3l+a1RfKZW2bgHFNJUtN+/JOUst
 XyvoT0RVKF7N+gLnz7oGQ4sG4bBRd4N7vxrpKtTehan2YSAbGK8LkKhmMUZYp3YqAeF5fIJHvOZ
 RVAMii1pkHs3VjULqteYkjA5UU1oCCr0SrwgPjju4ZXPttn69vnIvA1zfEfNn1Ux+VyWPfnRsiD
 MicRxWtaw9SK2t+K+xvJgzb+YGeL/K9HJ0AuJ5rBOYtYCEt3WiMq7knhfsvRjZ8aswqBRXDwlMN
 SvIXOCDl5gm+9tFnr/qB8BjnRqgdrJhEQ3HxaGnFDmvbXLnq0+o=

Oh and on this one I forgot to say - this seems to be where we're effectively
turning the whole thing on, right?

I think it's really worth underlining that in the commit message :)

