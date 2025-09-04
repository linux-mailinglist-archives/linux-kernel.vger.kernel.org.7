Return-Path: <linux-kernel+bounces-800898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B214B43D7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0A37C2A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFC33043B8;
	Thu,  4 Sep 2025 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SJc/3VVR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i6pundF/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369C2F3C3F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993401; cv=fail; b=U4y3YySjBbCGVzv2jARFIVX+xr6xcp5Kh04ODvi96fBq7Eab/F7eoddQhRkgs7nLUz5MF/Dy8wxOmtb5dCIEo0KGpvzDA221gImZXODPW/l1CHZxGFYkgTKUiqIWUSi95PELUWA6WNn3fOwIlMRzvDTZhDqSj0Bg8FZ1SvdeEYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993401; c=relaxed/simple;
	bh=qLXkoGa+l3ai7qbPrvglDnu9HmqKLIrKoZboFd3qaJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=URyp/grKzOobCzIiSF1zTruxpT58vzIcHZC7HRbyyhED8i4Thv2bUMPKcqmmp5GXauvghQ6vEQsNlHZvQJ6VgsTLASPj73hPuKcURYpMb689F/+tkJuEky89fbcnad+mdTkBL9FnxHY9F8dD+qrhgh9g6KTfYG9rJpfp5LCt3pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SJc/3VVR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i6pundF/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584CndKI015177;
	Thu, 4 Sep 2025 13:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=O2eL19uvqkyeRfnQTg
	nMmPTeTUUuVMJB+MV/u9voi9s=; b=SJc/3VVRFW59S1AlJ8QlwM2kbju9ZY38tU
	Mfq5ISV2XDR1olqOgKaiBPWiRoJnEYzE9PlFq37V/+bC7LjOLxE0+fqU3Vq7iUuE
	FAIPyXwQeiREMjSdqTffcF9XXrnDdq1AJNa6JOB/t1wLH3zrqw95YtUxSri1+g2H
	ZD12EzlTmbGnQ9mBTh/uScL1xHbC9HRNkY9mzt/8c47o1BM7/4Nj9qxV7Eo+icAr
	xPcplpQEFJ2J3Ae1m7qq/0pZjKt+4kQxP3l/H96cKbOTaO21f6VH0KKlRL0hhmBS
	nEjW79+HQT0XC8E4DR5kB+nMdXPrE8bx8GvoVXL8osh+7kVrdvow==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yb43045m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 13:43:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584D2HuQ036253;
	Thu, 4 Sep 2025 13:43:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbjv6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 13:43:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfEZVY+0qrW5Z8iHaT4HCfl9UC20OOBjS7pgEYCabtT2lIeQIQu+Ea+a6+tUh69Jsu8zF3j/Mw3458973FlCG8MS/bL/whIiXoUfr//HsiBFVasDl8Ht59g90AYREkTVxKLTW5VLk4Qf5hlt9t+zL8uycFWM/JpHnkofJ8BDYrlA7b8v6Jg2F31gZQWwFAqr/TWtJwOl3phfwQhNV/mH3MrxP8FShlTr+fZgFfty/mTV354I0axkCJmnZSXvOAWlY6FtJujYAM0exol+bXxBmCeXf9e9cJFR8Ao36azseMB7gloPmQZAqJfwPLyTOPMX+s1kZlF4cxhcpqelGsPwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2eL19uvqkyeRfnQTgnMmPTeTUUuVMJB+MV/u9voi9s=;
 b=vX5wCh8pz6+0cCPYkayotq+e1YWf8rH0KJ3Zo9NBXCvNIFcpeKYck3YrPDW7EQJ1AHBISKc88L3plt8oYmpE7hb+XZHRQq7saP48nLU7t8tophLN9WhSLqO1IfQWCIlD4p7LJCh6PSB/eb2oP/Q2N2R/DfknmW/2W1VLzmxy4GoYC6fxiJj3iWu0EFNJAeVi7OPl/VBR71GNz/ZHosbJXNSoJ7GmyzmBkwV5Yb4HfedmCGQdFhaolagd6aXwJm+8mWcWzdIG/xfLlJ0QGiIuqqMqGkMExm+BeMWFM6a1bR3lWoJebtMhH6u1/kRYDLwFe4UVCZCSb3Xh6zS5CXBc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2eL19uvqkyeRfnQTgnMmPTeTUUuVMJB+MV/u9voi9s=;
 b=i6pundF/93JAcLH4ZQv+Wby3XnuVY2TjmOWEVsWYIn/wlkxADDexoKCsVHd6FeBqw6q2ZiC0JRgyXf6Rkmfw6UAuZ1yDkhKkF2Hd+poix7hb9ktWFigrdEUzsb3LIKMSPUomw90/cdWwXe/6sBpbkzOdaZPnn2ptherI9I4wG+w=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 13:42:58 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 13:42:57 +0000
Date: Thu, 4 Sep 2025 09:42:53 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] mapple_tree: Fix build error (`make W=1`)
Message-ID: <2ts445ufkl7mhtdd3ucs2c6lsp7fxbx6b5tqmu2tdecxprok55@fdr2dwppnoks>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
References: <20250904090423.2293933-1-andriy.shevchenko@linux.intel.com>
 <6nk7wvp2vbsc5myxnx4mfohpq4yk4ixazkvif4hntilpuz7jtw@a2q2if4nc7kn>
 <aLmWF3V8ILOkL8W2@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLmWF3V8ILOkL8W2@smile.fi.intel.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: edc01025-ac03-4ed4-37e9-08ddebb8f4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zKi9Jt+w9yrNzNvPu2Bik3QMLn4Bif2MNmSgbxZmDyc0nE4tu+1Vyn2IBCwu?=
 =?us-ascii?Q?BEiP8tTBuJ4YETbsM5eIsCQ1jSi4jtLLi3feUJ38C0Vb4ltuihYrSY5Q94k4?=
 =?us-ascii?Q?oMdTcD3o8QujCPy/l6ZPJ2KXo75fILBihTYm8l4FbhpIqqbQ3ofFrt+oQdBX?=
 =?us-ascii?Q?0H3g3QWLlxQt998bXt5X182xQh7aN24FDkcvwE4bB+YuZXiFNuedpgWPxb6F?=
 =?us-ascii?Q?8hKskP3VqOdc0rXGUZ86AMJgJOHPIGaEr9zjRcEWa+vhBd2Lyf6rddElkphw?=
 =?us-ascii?Q?+weiMYK3q78/85wtT7aqhEEfm/EL1vQKjs3xuCiqIJXmLupOIDETMGwj6DJP?=
 =?us-ascii?Q?4kDRXa9n/21GiOAzqxpnGRJGXXLLAGF7nZXIP5sZ4a6fYIPS8oxKDj4TTa2e?=
 =?us-ascii?Q?lOHhWMkSjj8KUKTCeE6l09p5q8a0CYeMAwt/AxNlPp6xI8YoJn0rU3LPAZjb?=
 =?us-ascii?Q?bPAlvwqciqEJXBCfkHyaUxNe/7/h18OxSSWSCV0/8Z12qFt3i0lZCiD58GH1?=
 =?us-ascii?Q?cItniqzBQ0UCC0/qo5vCSt2Wq4F+CQ5ofXnRBXqxn3m2q2VPFzV/8MMKT/NB?=
 =?us-ascii?Q?tg/OFVfHBJify28jCvksmWFaDfETWMRgswaUEM8QWYvvq4yPetHapLJhnRga?=
 =?us-ascii?Q?hC+nkYRrg049dNHaHG4k1WBdjcPxTSWT7ilrSIKYg5uvGWjVkshHl1FD6PUq?=
 =?us-ascii?Q?2Ok9dEGlKeoi5W7VbElyNio7J8xKoOJcP2kd/c/Z8YuTtsldGgHIEmGyduyC?=
 =?us-ascii?Q?5oB3SRMMeRVqxv3DtlTw11lkaVDIhAjIGnyvyqLlMjoapeJfyjclR6qWF7PM?=
 =?us-ascii?Q?pxF/06Q8KFEJDzn1emIQeauMd0FeJOza6/Gn7CKKm6DZ6NO0FchQK/r4G2t+?=
 =?us-ascii?Q?BJWWMlGtFYgV3grAHWdvl3KfSClkpz2drPVZgB1Ue4gv116sBOt/FC8VJtWQ?=
 =?us-ascii?Q?JPi8kPgiywzK6cFhvAhKKciyR6+b4HkHCoHs4Q1Id5TRiBvSGE5cSzHmrGIs?=
 =?us-ascii?Q?MiK+4J5ErzoLm0kN6BBzGSpdy4rca1mw2peOJt8nchVlHzvl5+1bldBb8kVP?=
 =?us-ascii?Q?upbb/n7iFH9WLmWbWTiM9d+QNiBagB0mcg5tXhJUfg9Ng9GzQutYxIXTVrUG?=
 =?us-ascii?Q?ZAUPe8C0/dhBsQcxUmCotyX5lZmsEbWySIuC1B24/ayfM4YOx3xCI/ByXIl2?=
 =?us-ascii?Q?TPKAo0yKMgaXBbBqvXr3oZhAAGZvLMniwQVa3cIQh31P8b3/ephJgtPwfmii?=
 =?us-ascii?Q?xt5Bguj5Xe0I6u4PNmpc9fJ1vqylBE5dfFwGdvjIg8KLrDRsHjeHrYNZJ9Iv?=
 =?us-ascii?Q?isNt31aPt7TYo/C/7jDknunTORo+pdV91Ak4VIW1h328VzS8r11d53ujYP50?=
 =?us-ascii?Q?XrhT1ocOkhKNP4BEHNPkkABhGc/5ZyJ9bZBtNtul8k6oWP7Z+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v93R8nWus4Drnm9debuWoynb9Lh3l7gkz47SDW49nBPOoFoSa6ZZ5ReENOgi?=
 =?us-ascii?Q?P+gAFG2ii/WdmR0rNxoH1ybtvegrb4w9Lq3M5j4oj1IJfw/30PZFYZKdt/T7?=
 =?us-ascii?Q?WtnhQgzoLMHSXDu5847AgiEWfVflXQkEwEuw08Jw0VHqbbtvgfqlqXob4Jg9?=
 =?us-ascii?Q?RU1Gi23/Q1CzAkzNnne13ivxHddQaQLWWbKH1W7zJq37EOpRURLLRfKXY0Eq?=
 =?us-ascii?Q?GAXb7ekQhJnn9Pa04wkSWwCL6PX03nFJ87rKT8AA9oDApzaCPSETJNmGtZyd?=
 =?us-ascii?Q?zTb/rjfEWCXpVs4y8oOlQYCAdUSHr3EWKUUgmXPpm27J472ZYsNBf81TQ0I1?=
 =?us-ascii?Q?xjA1qNRXjhNiFCRlBGy5UJap/D499w5nmMDn04ol33e45vkreNjOZycn+Vnd?=
 =?us-ascii?Q?RVF21tVosXHDsUbdbshBgANhN6dg1naoUddwKOeRfWhSkn6Ii7bMkUzCEIV3?=
 =?us-ascii?Q?v7UaAVJnly607ZpRoJO1TC9GUKzqoxTHYtOQgISohinquFPC0UU/aQ4kXBqE?=
 =?us-ascii?Q?Dq8JQ0YHaFfgK247rg+XR3UyYirfO+JBVBqjpHHtVccbDE05TwG+bbdar2Qn?=
 =?us-ascii?Q?DtujCqFGhbqrZ5fLckzXcMtIn33BKDQ+jp/QIi/TA+O4Yg7FEkIItK5UjfGm?=
 =?us-ascii?Q?a9sEn2OuUA1e/WWTvSwYJ9wLAUfWqZhIQvwH7LVRl6gPBp23tgD/FY/TV+9m?=
 =?us-ascii?Q?/sUpuzWSQlUE9ZVDKLYGeDsji3IWwvsx2sHy8hJhzQJqjiaIU7v6Cv0jw8A4?=
 =?us-ascii?Q?w2B3msVAeUFk7Tjov4QXZIlyhYEN9xYntV6vYwa3TvCjYiiaMU5zsmyb8WSv?=
 =?us-ascii?Q?lLPbJe/rHxqS/IbFHoyWkz8mbct9U0HVI51zgHISucJM3IKumrAopH1UdBzs?=
 =?us-ascii?Q?P2eiIAtxZVNB6KFSBI3Bo8MjPW96HHMdIXd9gcKUZhMB2W47ZpwGmlb0VX7D?=
 =?us-ascii?Q?dNYbf3haGbsxME+3LfkHVHsN0AKT8fIBq+ysb71ZbKjbCz/8gh4NEQn2EVPm?=
 =?us-ascii?Q?3v7/WZ3GcHliSwMxmcLguTsdy6MgxcE/nvfJpBctTyDq6G0/Xkkb+nYwBGM9?=
 =?us-ascii?Q?0H2RJu4IynOeKANXyfE98k0Nv8X8uU1cUQb6w+1qG2pw8PV3l+dSE+pNg653?=
 =?us-ascii?Q?NZOG8vf7zIoTk5gYrugWR3utsx3YFTq+qBGTXGsfFTXKWvtyYociX11mdzKI?=
 =?us-ascii?Q?kzNwlVhuOR6jBqrGY8kROukZE6qiLWninv94YQHBp4IQke/JzVVcZGVbVpB1?=
 =?us-ascii?Q?+mnjX33LFY4OFefufih2MgDLh1d3G6jryYxkVGeIN9JBvEJbgVSCsnMId3I/?=
 =?us-ascii?Q?khqTaAC3ZTp4U1W58L0r/u1DlSUXuvmCV+do6Ds5h9FZgRuqNGENrO1d0W/f?=
 =?us-ascii?Q?g4eRSWZr5iGcHabgEekjktogGBc1/0u2bwFTRQMPqihDEPDJz2aW0/0ZZxRt?=
 =?us-ascii?Q?6wNhspfoVTxoOTCfT/R1EhotSGrXluA/y+LCVDWTpeeZIyBfdGLZXe/OGOx9?=
 =?us-ascii?Q?pa5DO2/L5S9W3LSSoumGU7dZeL1V+cBsl7nDbcF9kFC6i47pYyAP/N+yzvat?=
 =?us-ascii?Q?qSXlCk/8t7mlJYJoUFyTL02/jg/F8CuEqyV5U44T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CQxrJCsFiXeVX3n5dIYK/He4YMkwC1+AwFgv7roZcBKgT+LFJwhWctUa7ezzkhwhLkmAXNwttUXqzEQ7how/nPHeeeTwuxKCyQw4txU00uhEQgjkUoFZ+mBPx5YYrQY6mdYW47BZX9V+cYS/uf1S8+b4M9N9kYOYP7VM4FDDimoIlGEbuSnxMevsmqrU0EO43PK9d5+NRtEJQAu0cflh7Fqf/4xFgzaceivwvAvQoSs4vbvpx8E5FViKUH1E3SKjHLQb+7yxLbJ+6LLSolHpcLH02FO5uSHkiqCXdsniUsOTXoTHytTRVSq9JDYPwg52J4YA15ozOWskhhZmNPELaqjGoOc/8NONGo0ynAHHqnXgojnri6/3IeK+cJLKXjeoaF+wwIm0ICKvru/3ghLfRLS337gKP+81h3RNzBLFq9R6O/O6exbYXOiBfumXh5SKRD+mLqfg7xPawoppUrzmNhnBM8SqmoNw5eFX9+yirtM5N1mGDPIoPGwqXiF08IBeTWS4pF6A0k18/2lhpZBGW7IRBngkiC6RppXt3yhGSUdXUq89GHtDELvZy3SbxTVYB1viO9rhJQDnFe9/ws/9TkILLTylcWsZTNRQ1grN3+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc01025-ac03-4ed4-37e9-08ddebb8f4d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:42:57.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efmceHbGa/jpZPFp2iIKzMRaGUuAnO4JCtf+gHdpt9my5YLEu8LcsOnbbyTPm4g6BAUd8o4dDmP1xzRuHelr4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=830 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDEyNyBTYWx0ZWRfX6ZrVB340covK
 MkS6wm++h713QyRsaEtWKkDVZEXpR+7KYb/8rq7YS1spQdZ2bl9GZU2n9bDYregfFt6wrJHmRRd
 oJcSrGy9uLisMp+qkaYUj/PkE+7ma+toBwN0IEfo/Nx4jN74egj9jLZzURBTYIwZe8JNl7TY7EE
 F7ToTY6JoFk9DVYBXnjbDOx8+uFlIJCyF3ZXhfEe6vQdVJbGuoF7qdL/0fVCM5/lfI8HuDglKUI
 OwCdL/GC2NgGHMMZD7A06VzuBepB/mQyjSES+k+JAdaYfoHXApqFjAmyP9w63INIEASVIHso+PI
 4AuVSbF7isUAGF+hBWzPaNpoxKbYzxBlArumK+fNid4L73dQLmSO7fGEbozKj7anhyuK1NFGOPS
 nGQaAaf/
X-Authority-Analysis: v=2.4 cv=FM8bx/os c=1 sm=1 tr=0 ts=68b99766 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=Wm5M4ToSKWjrba0siNAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: asNFU2Sxy4uVBmkMotmN9k5r9LbnlU2u
X-Proofpoint-GUID: asNFU2Sxy4uVBmkMotmN9k5r9LbnlU2u

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [250904 09:37]:
> On Thu, Sep 04, 2025 at 09:32:52AM -0400, Liam R. Howlett wrote:
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [250904 05:04]:
> > > clang complains about unused function:
> > > 
> > > lib/maple_tree.c:179:19: error: unused function 'mt_alloc_bulk' [-Werror,-Wunused-function]
> > > 
> > > Fix this by removing unused code.
> > > 
> > > Fixes: a48d52b2d21b ("maple_tree: Convert forking to use the sheaf interface")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Thanks.  This should be squashed into the patch listed in the fixes tag
> > since it's not a stable commit yet.
> 
> I fine with any solution, I just want this to be fixes rather sooner. So, please go ahead!

Sounds good.  I've added Vlastimil to the email as it went through his
branch.

Can you please Cc the SoB people next time?

Thanks,
Liam

