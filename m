Return-Path: <linux-kernel+bounces-737207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C414B0A92C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE537A4C79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909BA2E6D04;
	Fri, 18 Jul 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BX75toXs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kbiPqFFq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060E1EB5B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858768; cv=fail; b=D5pUQ9WgVaA+VYZd9yuOeHeNK75hjDdqa3+BSnnGaHYCvQ4tSD0J3QCck3NTlq8DtqybAf5Q9DLxXGeEUB7wXARTsIDFYzT46GTvA1QwXHqroxdR2cPLfxuf5Kjr/ko63IJQkTLNhPPOxUrbsAX8DuxzsZjPEj9J8YlkXDs9HoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858768; c=relaxed/simple;
	bh=sjMI7YnC7c1vaTr8TLBq9ghzk4hsnACGNq+TJrHu634=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gDPEH3pTIdOQbSN4gCmmLcG2HgvQzrYAa8b7Gq/htlW5BEr0QwaNV9vmhLAjzYVtW2QnY2epUVqqr4MzyRtIRWSdLeW3Vroa/9H6lYF4dgHGtuzNVUzDqT97+AWJ//wBLi6C3kfkyv+hA5PONlnEOLBZaOEIuS8qY4U/+jU44gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BX75toXs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kbiPqFFq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IGtnrQ020663;
	Fri, 18 Jul 2025 17:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8027o68iROtafh6GJM
	3k9qPGBsIsa0WjIu4ebvYcMfM=; b=BX75toXsM9/a62ebPK+cFjFzdYyKLOfvzI
	XojgfZmfmnmxI4ORhRsYUbWH/q7bNQ1qxjaGpydZmiDM71cHZYDosiuGzB5a+pyo
	uBLUQ9wPzPm2FJJgbTPdBIreHBK2wjjTiXWsA3NqvgSVJvSfm2BG2HMGuQoH533R
	OI3VGntsMPdf1NkSvmZZeioEOkMHk2WN6L03xwm/LWVVZQgGuqHVE9v0B7PLHrNq
	Svz2HuTUQdyzV1+3o1H7yruzdkIYJ8rG3prWxMOBzWwatbt+FMZ47/mfjXwS7/hQ
	UoU95KFPD4IH8S5aOMQyk9YDojId++ZgOPublK7G8DmW9A8CyG5w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4weev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 17:12:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IFPuPV024538;
	Fri, 18 Jul 2025 17:12:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5e99dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 17:12:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLrivB8yyiqmiVzOIo1BHvH2lPBtxYDk9HNC9gwuHrDfJ2PDbeLs3d032t7VTUKJVDCXz+36Z3yBJCGXoNbflxtNQzXsMLCQcHsw25/UXNFPOPlL6AuR/Bq1++CSfVFUwFwC+cSQ0eqGEAMeqnpxvApZOC5pn4DXPM6r5RBoCmyoz2I8wclfgBHCbjrE2FUDDMk3CvnOKxDo4vXW8ixP3a8yEEguiKrjaS/F2KipN3LGDLXBTMGMoj+JVcBOA2wAv6eJ9GBzLOxATBSjdR8f0z89YIEF5iWSkrHjKFC+1AgZs4PuEyOuwcLcEUTuTdGKXzaD5WQcQFQ0DhE7aquhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8027o68iROtafh6GJM3k9qPGBsIsa0WjIu4ebvYcMfM=;
 b=En2DbTaU0n8/2VYu2VA4OdQwiQIjqDoJTKfErBag9+QCJjRcEG7aQhhoeEB9mNnIweXjYQNtI12raHvE2qt7NSyX8uE3q99+SYU/y6HNLk1aEUIma/lw0Ov+fIjp0tbOaoBiJutRNwqMxC0cPmu3fkSRPIL8GIXxZGSekPmii2vzytGpgGWXjrAEFCfi3gZpBcHsHFrB1nwXgbZxH0wnJo1V+SkvxU9qtTjiZeLARw8YwKydWrGT3pmPlJmlvcaOCpLvYnzFU7NbD2J93QmwDLHp18GLdNjdC7hGBS/v2cDKJ3tbkQD5hk/7qS8yyD1kxBVypdTZHR0MJ9EeVuQEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8027o68iROtafh6GJM3k9qPGBsIsa0WjIu4ebvYcMfM=;
 b=kbiPqFFqb9OMwNsxMaiYcKbslzvkyQzTmB9E1x+LcIASMWbeHTNRZA2Zzbo/4PonoyfM9fZBQCxtVpY8XbCy8O1cNPU7NrZlAV6wKum2lAYzrQ7Vd0hn4IVoci5p2r2McnLsoAhyPPnwGfEUQX/O9w7t0s6S8RaRwjGvH8spaY0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8493.namprd10.prod.outlook.com (2603:10b6:208:55e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 17:12:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 17:12:13 +0000
Date: Fri, 18 Jul 2025 18:12:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
        willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
        vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
        peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
        baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
        christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, hughd@google.com,
        yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 4/7] mm: Introduce FPB_RESPECT_WRITE for PTE batching
 infrastructure
Message-ID: <149e5957-80ec-4b73-936f-6ab7e67cb6ca@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-5-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718090244.21092-5-dev.jain@arm.com>
X-ClientProxiedBy: LO6P123CA0040.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 90529532-5180-44c7-02ac-08ddc61e3d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?poPUfGiyVnPY7fjwrxzq/KgDCDzXd+J5bCMlLrAM6t4VMAvO58NUtqm/caR9?=
 =?us-ascii?Q?WdV+zOEJI70kmRwqaZR6C/WcVzXIWLYBngAaueFFCKEGRfI94EROcgefF2VJ?=
 =?us-ascii?Q?VwAJIrThnk62kglUbQAq/WrHXryjlQByyKxTZ6BrID0AV/szaf0qqkM82xW+?=
 =?us-ascii?Q?RBfYHPnzOF+p/fwaQ7mrFzJVZqKF1sqWj2r5ipy+ARUcNChrOLH4REuxNxNc?=
 =?us-ascii?Q?48NRxoh2pNoxSZ3Qi1z7COiTQzt6jSsGkEpJfgGfQuFFQiufpKDeJUnm40xt?=
 =?us-ascii?Q?VN0yhR/y7fDrWvnCQZAot5qQVu0vtshU5OY9O2Uhs3LjtfNjxQEOo8DInZMv?=
 =?us-ascii?Q?ka8fpDvMKjfbDRAulTEVHR7Tr5t24Kp7Gw4FTPCOAJVfjtsai5O62iS3EgVR?=
 =?us-ascii?Q?KZnJ/YYt1xKIaJD/yKyHMr++oTkTnSPUeXMTr8Ce4zOt8+oRmaBYK1thlPHo?=
 =?us-ascii?Q?5Kly3W8G2VYo7Rwo2JUfnCefBny/oQnHtmsGgLeKlSlhJRNGZgm5y7Sb14Jk?=
 =?us-ascii?Q?2mVp9yhzLtgdLQX/idWu3x61YRC/wu5fgs0MAljv87y5KK60+ZQy7cqEZOmn?=
 =?us-ascii?Q?oACyNsqLDJ7OIQE5Xl03nh5yc1Va62uE1THl3G1lIzD/el10axc8JOOkRaSz?=
 =?us-ascii?Q?jOo80/NhjF5LKui7P1A9XajT24LasnnYa+nyw1R9GELzxYg+qk/S+H89SKq7?=
 =?us-ascii?Q?t/kM2MmziYuTjh1KV1A81qlDsaKHj0mhgaH+lHu/1auzSS0fwkuprH6dQ9JL?=
 =?us-ascii?Q?XELeYe3+RP681hYKYlCY7+3wxBVe0whfaAmY02lOz3SflM3uhTXRQ+XlsDfO?=
 =?us-ascii?Q?5VyuZE7vBheAUpnvvGJqpue/CIbvJm88aH0YmA1AtWV49HxbgG+xI/dA6yoM?=
 =?us-ascii?Q?UfV66X89b75K6dERWRUYOHTPAoUXmWcAkV9RZkNeL3pXrNZXW080r8Nq/CBC?=
 =?us-ascii?Q?P0eUbk00TMQkoJYlw0P8qvwbQUxlPaVWwnmB0DkEj9Ep+sinoRAfcGtNc0cY?=
 =?us-ascii?Q?DmyIlTb7AdRIBwHbtOd0Ix4rxfczNux/8ryn1tgidC3LnCtkF2qiGbvpMIu8?=
 =?us-ascii?Q?NmmPeuTPB21hLeMkJS/zi7/J14koDD0eiXjn5seuiZS2fjaTrPpQE+MeZVpX?=
 =?us-ascii?Q?euCKGNeNXWff3gfIZZ9V528xhqY+0JfdFDfcSOu0aTGRyknP2ES07KOd6Y5o?=
 =?us-ascii?Q?Twlpq/TPVnm2uAkUrbMSpaxNiPqwT3b+qjVNLzuUbeykePiQkeeL5pJH203R?=
 =?us-ascii?Q?AF6tK12GZkb8CggnpvJN+vQ6wfQLfEyNMrwjJTKQR0dVCbEh3NWBtgTENheF?=
 =?us-ascii?Q?09gkwv9BjRZ8+YgbBq9nDYTD39txJfrVQHJDOR0aoixSkzaTa4a6W63aIVhu?=
 =?us-ascii?Q?aGFzxt73CZVgq/wO1O0sRH2hPx8sUL7zeIXjyCsJyV0GMLYaWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ka3P4wSm6mYjAT6s1ty7q6XQJd3hoqQVexd3WGuBnPki2Vje7cqdfYHA6RA?=
 =?us-ascii?Q?NjpW9UneZcstRkJ5v3IFSjbVmZ7KXjOxI7E+nI1x8his+RTuDTDVijGqFjIt?=
 =?us-ascii?Q?qfj/i7+6bGjsQOkg3YVpbTUNb6E5RwM/GoX2YPS1QbUmcXWnR/gE32zAXBJt?=
 =?us-ascii?Q?1E3U5dGmB6q8hltyVMhNDMTw/tHei3kAH3PtbSjHPfGmV7UGYGOCQkh1PFRW?=
 =?us-ascii?Q?sTItToJ0ESyGQjIxyCF1DAHx48/+qejWw3x9YJhdR4zf464NpsdgCEnHqH/m?=
 =?us-ascii?Q?ovDOcsHAjP93Ap/rQ/Ru06/W6rNCqdJocLVdMxjI4txlwI0e1FzKu5V+nKHn?=
 =?us-ascii?Q?mi+pz6R93a+NuiUWF/v9CY7DYhu1Z6AZn2z8TQNwt5deriFGSCE7vuGVKaeI?=
 =?us-ascii?Q?NARoE4681h3VXtfIx+0zi3Yf3SU9xC2JddbbV2iVO7LNddJ2uDWe/Ffeggjm?=
 =?us-ascii?Q?4w41siFM2Po0Y7RwNHObhn0bQ/wepGd8IQi8v8e30gVcHMckbr0deh2/RKkq?=
 =?us-ascii?Q?gT07+xUWQsA3jSst1ACsNNYmAwRFndt+fD0E99mZab58Zsco2HGKdrIM52WC?=
 =?us-ascii?Q?yenSHhd+VJ+HSghBhqdKrHLQi7Cne9x10Kt3mWXhyKv0TIaeOhOmj8Sn2dUe?=
 =?us-ascii?Q?jHH9XwVAQfbogRQ1pb0hMB1A6hNAejswudNsUUVntuYFKs+O39k8RCXneYMi?=
 =?us-ascii?Q?vHiClFhc4Qw4rjqlswIit4EO4sv+Bz5yd2beNpgW86NIOnfunFEdxz8G2MGr?=
 =?us-ascii?Q?nicN4aYp4Q5VnVw/nY/jFuwCvhbbFvpg0lCDyLGB7zh95gX57NnljjSNXP/q?=
 =?us-ascii?Q?X63fKYsWynaWO/WQq2nuuH1dG67m09pHdifvg5AN9GobULp9qFVnWpyIkspv?=
 =?us-ascii?Q?9y+RvWuuxG/Nqs/XoOto7NqGZPa0RC7dOLOk3MhAc+NTpVMwocknBQHjx70a?=
 =?us-ascii?Q?e8wWSH25SlLt8XwgzhFlLwFfpX8Rn4G4N64IkAKG+1EzrgGRfJT/Or507Cd2?=
 =?us-ascii?Q?eM0IdhYzO75kWwK38QhKB9MEah4nydeZa9UgczHsrXnWA4OfXWohL3b+g9/r?=
 =?us-ascii?Q?HUv/IqCjWXlXimpiN4XZUaDC+yY1DExZhKhgjRaCYsIwNl7lKLGeT1Kcn4oM?=
 =?us-ascii?Q?kattH/5nzetcj9ppicGO7wUfA1UV7l+2BAV6BOtRodpFakZQJ7MLQWz3/QHL?=
 =?us-ascii?Q?E9Qaj3uGP/ycj6aCpptkD/u1ZICYZXYxdbaRugcxicqStBgnNBExpcmTqh6/?=
 =?us-ascii?Q?zmWfJL22Ix7FbYaW8mvqIS2igGrk4V+aq2iyF4UEfA7LeT/VZl4dAi4K/vlX?=
 =?us-ascii?Q?zxASRgvynH1/SfE/P9078PXkLIE1rFzKLXopW+ldUWRzUNVG/5cTzXaldX8f?=
 =?us-ascii?Q?ftsHh6/M3uMbWsdmOpCtka/7SHMBMoe1j9gurjeAlgNBTOy2wK73Q6RdasTw?=
 =?us-ascii?Q?yGoS2QpvWsH7P71TpE6lSrepuOBsQrd7EPJQvQH+ClMiB+q1UMxg9g8QyfqH?=
 =?us-ascii?Q?mPqbxLE9fidrKuLz1Ar2UTJqzxRwyu3q5NSFJmVid34PqoRF5u5lZd5+UAY8?=
 =?us-ascii?Q?XApC/hhUBEPPc/4PtteO68D7tjukb+1IqS9ZpjVcJzQAJrgcnwQboWpUpn3w?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vMTLGWEBd7lCtxjlw1pPXy4hrbhnElVavyMaLxVILOx5YEvAzaeEUgS5x8ea1pgTpEcD0CEvsj7/75G9ZuWyg7+XtEO6KtfmVByYwLhGVj2rhRvLV/rn4W+RVnIPOsFgBK0uC2yAdAd79YlpYKLuW5jEkeQHnKUPPnl0909hPOMNHaGAaa83ZzyzkvcBIEGye0O96o7lslXs8XKokvnYP4vAE1V6TBJdl6TsYYYKRYswJ3Tu8JkeTSji7dhRK76tSKBbE5iSrJMte3bzmwmff85UE4jWxiShDja+zLlvDRKkK0eaUe9zRNLth/kR2qfd4rZuejO8sZ+pFf9b3mnPQSYdlt7dtd/r0TL+d+P3C3lto8DCkICzAUjsBgK1/AAxMQwlA/VwhmIsGmFhg/52GTAleNT8u1lHW/Txjk2iw8kTj93zMPUob2t0IfbzLtccgPpwHI2uWzKOMtro0PRP6xorarHn7LuRM885ySIKIspira+aotRso2Ce9ZnTzF/PeuRr91i/x640xRlMSkasREB9vrQjokqx1rS/fvuTsBs+PTgoa7M+2eIQlxCoR9uGGItN5ou1BLaMUo2Om86jp85Jvnte6fjBz9whS+aSz3E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90529532-5180-44c7-02ac-08ddc61e3d32
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 17:12:13.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9QLZAFHH+Y/nRlz3eSgpA4zPBO+MwQJY15QCTuty7xFQ1r7RfoELI53GWysc8ewiqAU3BEI5cVNKjPIvJuNoWH3VsG1BKUEDbmREbwE8A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=955 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180135
X-Proofpoint-ORIG-GUID: -y3h-njI67Qq1-oCq7A3HY1XzybhYm67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzNiBTYWx0ZWRfXwdhvUuZHe/59 xNxD77ClEhaT6fZS8QOcR/R1a+IAc6sPY6f2zblqrhVAz91azsnW+upcq6+Ve+UUU5gsD0yg2FO LYQPg5W+xRtWGeF3P5R2dSj+fjGQ8I3JIwzFatnPuqixuBKsdt+osivFtFJcXiHx9UyueY4oYcs
 nBngtYQONVkSUOz0W4NpXxOFLz2hpkJjJd2gDEjtfo70IODr6LNtmQtF+nTphzGbxnpf6s3KMvR ye7Aow+FvKHci5M81q5y0yZXsua8fBpjZjQDYdg5iA2r5C+y+HBrRV/yzCK8IbkK8bbcpgy5BX5 XhGiwYfrEjFXFOCZ3a3iN1dFTTP8gwdtzrViBd9cDoI76PLU8xE8zSw1OZl3iMPAm274Wuf+drm
 uAZz166OCE3c3/upEJObs0tTFtseI4Z4liW24sKMtJF6S7J95aqG9hqJIiVzuMfeoj3QtQjy
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=687a8072 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=OY308A5dfqXCxgfEiF4A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: -y3h-njI67Qq1-oCq7A3HY1XzybhYm67

On Fri, Jul 18, 2025 at 02:32:41PM +0530, Dev Jain wrote:
> Patch 6 optimizes mprotect() by batch clearing the ptes, masking in the new
> protections, and batch setting the ptes. Suppose that the first pte
> of the batch is writable - with the current implementation of
> folio_pte_batch(), it is not guaranteed that the other ptes in the batch
> are already writable too, so we may incorrectly end up setting the
> writable bit on all ptes via modify_prot_commit_ptes().
>
> Therefore, introduce FPB_RESPECT_WRITE so that all ptes in the batch
> are writable or not.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/internal.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 5b0f71e5434b..28d2d5b051df 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -208,17 +208,20 @@ typedef int __bitwise fpb_t;
>  /* Compare PTEs respecting the soft-dirty bit. */
>  #define FPB_RESPECT_SOFT_DIRTY		((__force fpb_t)BIT(1))
>
> +/* Compare PTEs respecting the writable bit. */
> +#define FPB_RESPECT_WRITE		((__force fpb_t)BIT(2))
> +
>  /*
>   * Merge PTE write bits: if any PTE in the batch is writable, modify the
>   * PTE at @ptentp to be writable.
>   */
> -#define FPB_MERGE_WRITE			((__force fpb_t)BIT(2))
> +#define FPB_MERGE_WRITE			((__force fpb_t)BIT(3))
>
>  /*
>   * Merge PTE young and dirty bits: if any PTE in the batch is young or dirty,
>   * modify the PTE at @ptentp to be young or dirty, respectively.
>   */
> -#define FPB_MERGE_YOUNG_DIRTY		((__force fpb_t)BIT(3))
> +#define FPB_MERGE_YOUNG_DIRTY		((__force fpb_t)BIT(4))
>
>  static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>  {
> @@ -226,7 +229,9 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>  		pte = pte_mkclean(pte);
>  	if (likely(!(flags & FPB_RESPECT_SOFT_DIRTY)))
>  		pte = pte_clear_soft_dirty(pte);
> -	return pte_wrprotect(pte_mkold(pte));
> +	if (likely(!(flags & FPB_RESPECT_WRITE)))
> +		pte = pte_wrprotect(pte);
> +	return pte_mkold(pte);
>  }
>
>  /**
> --
> 2.30.2
>

