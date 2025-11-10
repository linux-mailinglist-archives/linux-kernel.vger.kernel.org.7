Return-Path: <linux-kernel+bounces-892890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B674C460E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A29E3AC810
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131A5301034;
	Mon, 10 Nov 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sGWMG0/G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="foxyKs1u"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD582FDC22
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771756; cv=fail; b=Vfo8TNQDyX628DFLTVvQG3TpZG6/FUTGIRd/rzNStnKxODbN6lDqP05hpVg72xhnGNwDPAsYESFFZuG+Z97zBkxP/K06H85Cgspmfh5U3ExRKhaKBR2B4e22NrvHi02ZeHcOh4RUpfecZsV6ccovQMDVlmBuXVRo7BmPejKnhcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771756; c=relaxed/simple;
	bh=KSPFGHJ1BOSXoviqXeSZF/C3NbejIdsw/iucFET+Q3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pBOdigl/x/FIQ0ZlQxbyZoxp9UzXucNxX380qjRNnn1UT1tj4RW+ycOuJAEJnUPbi/VKXUsPp2sEnaVUs82EsVPFdbcAo/ohT3RGB+01A8zuGXgNE7sPUUvFUrCKGpXZicvVzfj+hGfAPUYwyvBGzf//Uncfives0aMYlMXCA9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sGWMG0/G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=foxyKs1u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAitZj014091;
	Mon, 10 Nov 2025 10:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PDpW6X541EFHoLgFIb
	BfGw/TykiM6ODafxYh49NEL/o=; b=sGWMG0/GTIJzcHLi8eK1TiiZ+V0G/QfjIK
	RLGvxx937EDUiubacelFJMYAKg0RI+lGEuNhhIY4SnJweDPoY4oiGHVS7knjAwza
	HMQ+trz+TXwaHHtM0459XYRieMCwVuIibiadUGKEPwvx1lujDDzZJoYBVY/pZrWs
	V/gskle27Xz3234dZTCwoJyvjnrt9qk/kbI48MfgPTluDQ2HBuQpFcsgPblWNhYq
	plGF5NN87/wghWlWFWhPAEfMPrKxh+xFQTQ+55iFBIrK+2ZcWcvMbrvFDvF39MMY
	DS8a0UbuerozPho3/h+emERD6LdopYIfxioYNjKjkNuMLg7+r/fg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abdpv041k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 10:49:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAA2p1u039983;
	Mon, 10 Nov 2025 10:48:31 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va801jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 10:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkfbHE4PaQuCPol2qAgF9p/5Nff2kwpVv7tfC0efjkFR8WX/68+OvesGuPOYSm+Lq+pJgz0CvCNQFAW+HzqDqRujI5wYKQCuZbkcH7s8moLlIZYS8nJOmvbgx4LLzR4VI97rfXmqylA3uBRkWS1PcLZ+qeJsZre/nJqk6Hu4tNagHz25URn9i2iX2qZh3os0RvsxJLuJLzuv6vQe6Uq1WYNDVzxnYJG8N+1nqLC6IYYVniYlF2ZjYiV+8wwGgNKVmivMmhGrxr5kQ42t9tca0k5mhSko9lERwVJvmsD6lNFF9PXn8k8smqacJo0CBMCZ/Ec7flzEDOIb/MZl0ETyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDpW6X541EFHoLgFIbBfGw/TykiM6ODafxYh49NEL/o=;
 b=aN+virSQSaxjiT/+20knsRTEBHe7H9LaQkdK8ERktkw07dRZtQ5HKL/hjhOdW5ILeS7od8oVrlY+T0shbM/3GOreeG8irkdAM4W5SfU8ZFcm6PYXH1jYTy/0i1bG9jtjMc8OjWqhP+5AJ7QSHPK2qGjV9uBnIKvHPVITS2fPerfdCfeAIsbhtZajEM2nj+UEWllE4rwTWF9TGAyWfQxm05r8uAXh4TbK3n7WaJgcaELbEnomZOxMBaDhGdmOqg4QLxf/gljLS5fNsavINmkyXcBi/YsOct3TTBjC9cn2+EsJXsQ4KeUvDMCce2lRIdY6taHdghfWzHVVf513WbAoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDpW6X541EFHoLgFIbBfGw/TykiM6ODafxYh49NEL/o=;
 b=foxyKs1ulVPVRPWeI0p4aJrCNPXGkng5sQQGWSeK9i0uUQFx3q0Wv4XtXzUdcE6R+nrSYVaCUJhPCeNWVeAZHgdW7lTFFdQSbhURI6GfVEdqZkhRuVWOe8ZSy83GW/ZEqUBFfpf5jvQTwQ778tLk2Dr2ieS2RFwL6fd/AqXN3po=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA6PR10MB8134.namprd10.prod.outlook.com (2603:10b6:806:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 10:48:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 10:48:06 +0000
Date: Mon, 10 Nov 2025 10:48:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA6PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 321a4630-ebfe-443c-2c02-08de2046a150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NIaSkolSAj9Pkyy6N4ZFgyWhm8uQ8JfFsXGgfrqXoKYnJwRs4cE98b0yJj/Y?=
 =?us-ascii?Q?MtFLxj2hnD3Gkf7ZTCLftKe2mp4bWLUpBZEHCbCWsPJFSvs/8MDDXaJNE4kp?=
 =?us-ascii?Q?XiOREiSFdbQtmpth1aKUHKPrSFgRAyypDvKFPZKx+dkn0DYVfucWoi3xhPfK?=
 =?us-ascii?Q?p7UZ9dVsmDoj5WP529jzCexku1h/47DCXZ6OmXweZZvr1IPgltety/E6Fhip?=
 =?us-ascii?Q?sdwx8tuz3gYGimGf4r0PXeCMv7UNFSC7f8v1n5gjCajSXDaeS7OjVPk6Zcmj?=
 =?us-ascii?Q?Zo1Ndu1GQIGWzKUQ4NPaLmgzrU4UDMeymvT/7eyoG0MQokEYt9dTEF7ncEGa?=
 =?us-ascii?Q?5y0P3Xiv4wU4DxfjD30077ijo5FDstIvYhrsMLFPmXZ0EsA6DfrOT3jonWom?=
 =?us-ascii?Q?LfOOsReZPZrjry+euB8gbO1E3WDAneYUer5lHFageY056AFZ5LeR1e+1LqFP?=
 =?us-ascii?Q?M+FU+FXg7gVmi7peiUpwRXwEmQDG9R6cDRLZCO62gzObRDuPyy+PolNX8XJ0?=
 =?us-ascii?Q?xB66KzNmpSki5qbl9GeJC/Kk29QsMV2q8sHj9yGoyorfTGYDvL+9XAJCrSJw?=
 =?us-ascii?Q?QLeLpcLqiOtAxXVDvZpe1/6k66C7sn1yHxy7yemazY65OtN+zvELdK80voY1?=
 =?us-ascii?Q?JNtIvc3S1gx2zPcwyMPztCstCzd0/HhMDTTXcGLlq3uwtlhkdrjZi6UesVxa?=
 =?us-ascii?Q?NSofTGqLyOtxRgkkkv8th1Tps08dKGPGFSFRTLsWAXjvrZvMU4qCp5d6ZXsY?=
 =?us-ascii?Q?nizb0goyqanCh5ZYWO+dwXhL7isSzWBG4Riq11LUckILungws6H2WoK8ihLL?=
 =?us-ascii?Q?kR49I7txDsrxVX2u5NohSoRZY8/DiXcXU0SdC+0VTgzkX7UKo+yuig+diSuc?=
 =?us-ascii?Q?v0uLQLBvwFQToHxRDGpGFv42FCszUA9FnBp4KiA+eZC6zlnSdcAOdkdErgL1?=
 =?us-ascii?Q?DnsdalgHOI1zLzuV3vHVN0sDgDRiTRWaHujeHDtstHqP73ZhBk1zCoD73o+E?=
 =?us-ascii?Q?zfUDtm6q2TBCzeMxgrQSivZsKjs1OI2wk+Q0rox7ZSGuLtriRwkq2eJkfdJp?=
 =?us-ascii?Q?kOt7QxzQq6fYBEHtyK995acKV5vmN+cZSMnckjTRAMUJiDttzgJpkeFlwGUy?=
 =?us-ascii?Q?WG20YKtULlHmvV11fAf0Og7aQy2a3fZzp5h3qEegWsr8Zhkl3PBZjwScYGwF?=
 =?us-ascii?Q?qNGEWt9U8OXv3C6N6DH/i+4g0y1VETnB/8vkgRBkMgErOdJ3yDaycITUPLPi?=
 =?us-ascii?Q?DVktxREfv7+aWpdWd1jdhqGEhXv86py9TE7uUdQRVUu+rOB5tPSojRvpdksw?=
 =?us-ascii?Q?F71MURc1G10SRW94Chhtu6jXGAa0rEAVhyFSInRKVWRNosJGe+nq2QEZgMZh?=
 =?us-ascii?Q?+b7HdfYmZmoUXzjcsWsmYahhfNtdNA6GudvuNnoCOP+3KZ6YLmqs+r35rZmL?=
 =?us-ascii?Q?uVTzKqXR+9N6ouz5OJMzdXtdQbk2IF69IzMCl/+qs85CVMk/tL8ckw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CpJtxkE6rvIqbPGoyauaq0tKgvRR9tNrkITPIN5Hm3TLbCDeOmWyA0AfoGpz?=
 =?us-ascii?Q?eX7tSM79oIGF6AZYAUKxirAfdB4AVxHII6GuOkbbJoTeZENOfp+5YcaCWX7T?=
 =?us-ascii?Q?lMQH+JK+YPTXJT8uSVb/FI7mEZKAAoGGzFGTznACRC8K+E7l5GIakuxxV8ce?=
 =?us-ascii?Q?5fOkV0gDKpUgHMAszUeFGdRW+MSUxZ2fzkhoeT+qLfzgLcE5XnKf3r8ksctc?=
 =?us-ascii?Q?yByfKjQzs8U16qA4oZaaM5x2EVGb1pn3vV+QxAU76mqx43llY3BSgSVxN2sR?=
 =?us-ascii?Q?AGO7ne4vZhhJfDDK9WG42UEsgI2YMRGv9Oram6nNQnMKO1zZiBNQSRBinBmO?=
 =?us-ascii?Q?8jp6cT8RScJmCqBF+CpWmsSXMLGFhSwdOMuFY5T0vZQ08ap2nDej5PbDN7Mc?=
 =?us-ascii?Q?c0RYHl+KCeI7KvfCz6oiLrPyNw0wJfZckchxT3kEwEQEOsBLGiwZkQWeC/Vj?=
 =?us-ascii?Q?AQXI0nAAmVfIP1zMe9zGHD3EjIyhvUrL1c44yLuut5LRYm5RrXWeg2UwRCAo?=
 =?us-ascii?Q?xe9M4SPHd53oSMcBzZc36MYd41KrlDovi9EIZwQEAI+/cz25+MrQR+PrUvbu?=
 =?us-ascii?Q?YQaN2D0dpm3bfSEWfAEn56kTk1aBXUuW7Axf/oVtUrgzkeDm1ZdbZujWDNNG?=
 =?us-ascii?Q?RPy3iKqAEE/HOrutqjJMYdaUy2JhF4G27DDa2sBeEpImfaOXW+UJi6i5QoSR?=
 =?us-ascii?Q?ELCEKGMD9gqX5KZrFJ/OgkfxgypBixXMx90+16rGKKb0EbHdwn3GRXVi7uCx?=
 =?us-ascii?Q?AVaTVcKusCNeOUIJF3QAypZsXZf0hdI8g1b785z4+7Dk7ZXuYbITThWXyH+E?=
 =?us-ascii?Q?aLGJJLFdkQp6zBd0eBg1Gn+H2xUmyj6rmTlV2T1hMCFD5IytOs0sYX9w4ENK?=
 =?us-ascii?Q?dqDWBmpnZoFSRrZp6iO8WZHyxjfbDTR5sTNQkSvb9ej0iFPVo9sNs57+ritN?=
 =?us-ascii?Q?7AbyP/GpLnJgFqImTNoyOxfdGxWlGsXRj6M0NWyAkZoXwivqoP0MJ9/AVsA3?=
 =?us-ascii?Q?6pzXnicionMEehrRSdcGYfKrHwpsuZ7kShHKWYgC+2T5XizoWMaU50BUnS/i?=
 =?us-ascii?Q?CYnKvwBk/V3HHZGvGaahiSh3fQskTK5WdGlZf5KdrWGqS4lLe2hFfN+kGNHJ?=
 =?us-ascii?Q?GZXcePjzixBjvv/WwW8Pm6+mAq8WZc48QzW6OqlEcUuKN1Ix32Ksy8B57EPN?=
 =?us-ascii?Q?hNy8XxgDxDTG9MDOObUOkoLSzNdbowuZxMeMZtVS2baPX6QQSCjYRDDHI8js?=
 =?us-ascii?Q?DEAsh706oeM5cnIHqDYwv2bC3uS9WD8INJDhDEbXGs9R/Pn5qV64OLw9RCe7?=
 =?us-ascii?Q?TEQ9o8gqEV+tHL1aMhu4ULxoqbnNIfA1RT92nTBxvrM5+amKTKx8CxLuLXLD?=
 =?us-ascii?Q?vMEGftW26K/isE04t76fv/RJs/m8H6PYVNl45+4RPojd7oaANugW3UbEsNvR?=
 =?us-ascii?Q?vzRhwq3yS1QzCNsuX9uoSIruns2Zzpksw2VV5HxIAhUccR2RuUgq3K8/oDq0?=
 =?us-ascii?Q?A8dWuxaYL4L6guSElx0pFcZknKMaX4mOtRkDzYiZ1CH0MV/2DnW7JDnpLdIX?=
 =?us-ascii?Q?1qglvcd2CdPpD65qIvLrZe0EUJNboSMO+xNQ4XdMl5s1DsbgEXUuy1S5K984?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ra1jH+92XSfmT2tRrbFgqstfqJaQxA2N93NrrwlYnMI5TmcqeN6tnwVo9sfINc7jnRHsP5CkPuhqXtbBhP0cXKHMgvQ3cVIw7XJyue6t59bqSRf9lV9F2s0rbWYbSNMwUY5tzh574r1nVfahGhhdqmFyUQsOBJnlmOmeboFodvB7X+DKtzDKqoz1UpQbyjjJbyBkBSTemS2UHpyKdtKjRH2hKjQ54nZuiaOhWzu5/vkl1Q+DjRKomUKlq0zzhulpeUy4ySJEzZI53BHbrcXMp/JL2M67kK4w0iwqCnndevlMgdCtCuBBz4Yl67Ve1YJib5i4ETEX+mhwaW7TLMcljZgDm1ydoesVsGKMxwaYj6Ct6CO8JpwDu7rO14ZdDPA6Tqd9mrwI53ktQWJt4IRCQcwyWczGjWH7IJkLB02sT654TQMh5pjp6rBD5AoVfAUpqmmv5tv8TQKXSA62AWQOFZ85HfX1PtthQM/3ZJZej/EcN5KLY6W9FaG8d4bOfeA/qp/hivP2VplPhsI0EMLwhBcQHDKAGFJp4QiQ6Ncj0ZX5ZGEHs6VdUUuU/vSNpZMxvKt/JnxYWmQkTUoZ2Us3p8eUafsYvl/Ol9ACKvHZxQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321a4630-ebfe-443c-2c02-08de2046a150
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 10:48:06.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OsMYSrTPXQ8/H5gSBJxHnZLc2Q75HiWs8hqj04D0ZdRye42fW5zhRmaD9uOsKJJIvy3EcxOPBfFznB/nx+deiP9PrZ+OTvYgxZBxttrLXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100094
X-Proofpoint-ORIG-GUID: 5vJKNz0E2B0MNiOfQmaKdE86iXDckYVj
X-Proofpoint-GUID: 5vJKNz0E2B0MNiOfQmaKdE86iXDckYVj
X-Authority-Analysis: v=2.4 cv=FooIPmrq c=1 sm=1 tr=0 ts=6911c31e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=meVymXHHAAAA:8 a=07d9gI8wAAAA:8
 a=ag1SF4gXAAAA:8 a=UYZxw6skQhVvl9hYx-UA:9 a=CjuIK1q_8ugA:10
 a=2JgSa4NbpEOStq-L5dxp:22 a=e2CUPOnPG4QKp8I52DXD:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA4NSBTYWx0ZWRfXxVt4kGr0DQwt
 Vp+fzMaiCBzu/5aySrmKpwytE+CuEYvVJZgyCfXKluJ1ptbv6Hw9GoKT8YwSMqgaD91XQXRt1Ee
 PlgDm6PCJ0vxyWnjA3ErtdwkIIkdS0KbRLMUyvcsfZEPlCBbQg8XFJSaiy21F1hWppAeJMA/34v
 IygiHLK5QodKHFmFvlXfulwM2Oqo3wYf2Bg/wM0TkrS3lTPJbFb3O0Z3vPrBLmYPHuQJcIIUCRl
 rAR2kov1Iu1vk/fw9UnU5VqIcPtpZgXWxud+CrE8Sfz/kx/OPsp+tKMbaVtDZ7941ckvMWZPItF
 W4ykJkjveuGu/VB5Hlb2xvyZTcphAjRiYSwQ1E1+ipRCnMY8RVzURo5HFcBOnZsBqFHnHWXOS4B
 rIcHeax+w0JFJPXAPo5uPpFIC+ZcQA==

I think it would have been helpful to ping those engaged in the discussion in
this area in related threads, e.g. [0] and [1].

[0]: https://lore.kernel.org/ksummit/49f1a974-e1e6-4be5-864e-5e0f905e1a8f@paulmck-laptop/T/#m30873ef3dc9bd2c4c95547e81efff3085474f2d9
[1]: https://lore.kernel.org/all/7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local/

I'm not sure what the process was that lead to this, but it feels rather as if
the community were excluded here.

It also seems slightly odd to produce this in advance of the maintainer's
summit, as I felt there was some agreement that the topic should be discussed
there?

Obviously there may be very good reasons for this but it'd be good for them to
be clarified and those who engaged in these discussions to be cc'd also (or at
least ping on threads linking!)

On Wed, Nov 05, 2025 at 03:15:14PM -0800, Dave Hansen wrote:
> In the last few years, the capabilities of coding tools have exploded.
> As those capabilities have expanded, contributors and maintainers have
> more and more questions about how and when to apply those
> capabilities.
>
> The shiny new AI tools (chatbots, coding assistants and more) are
> impressive.  Add new Documentation to guide contributors on how to
> best use kernel development tools, new and old.

As others have pointed out, this is strangely gleeful, can we please drop it?

As mentioned in the msummit thread I have a great concern about how the press
might report on this kind of change, as I fear that a 'kernel accepts AI
patches' story might result in a large influx of AI patches from enthusiatic
people which will have a direct impact on maintainer workload.

I don't think comments like this help in that respect.

In general I feel that a more restrictive/pessmistic document that can later be
made less pessimistic/restrictive is a better approach than a broad one on this
basis.

>
> Note, though, there are fundamentally no new or unique rules in this
> new document. It clarifies expectations that the kernel community has

Hmm, I'm not sure the conflation of pre-existing tooling which always required
some degree of understanding vs. a technique which can simply generate entire
patch sets with commentary included is justified.

While I _do_ like the idea that basic principles that already existed still
exist for LLMs (that's a powerful notion), I wonder if we do in fact do need
some new rules here.

I think saying this also pushes back on the concept of maintainer-by-maintainer
policy as 'it's just like it always was' doesn't suggest that it warrants a
higher level of scrutiny.

> had for many years. For example, researchers are already asked to
> disclose the tools they use to find issues in
> Documentation/process/researcher-guidelines.rst. This new document
> just reiterates existing best practices for development tooling.

Ironically that document is considerably more strident and firm than this
one :)

>
> In short: Please show your work and make sure your contribution is
> easy to review.

I wonder whether we need to be very explicit in stating - please do not
generate patches in large volume with no involvement from you and
_emphasise_ that human involvement is _necessary_.

In discussion with kernel colleagues who use AI extensively, there is a
very clear pattern than a key part of usefully making use of this tooling
is for there to be an 'expert in the loop' who reviews what is generated to
ensure it is correct.

I therefore think we either _should_ have a specific rule for LLM-generated
content or should (and it really makes sense actually) have a broad
'generated content' rule that - you _must_ have a thorough understanding of
what you are doing such that you can review and filter the generated
output.

I think stating that we will NOT accept series that are generated without
understanding would be very beneficial in all respects, rather than leaving
it somehow implied.

Being soft or vague here is likely to cause maintainer headaches IMO
(though of course there's only so many who will read a doc etc. being able
to point at the document in reply as a maintainer is useful too).

>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
>
> --
>
> This document was a collaborative effort from all the members of
> the TAB. I just reformatted it into .rst and wrote the changelog.
>
> Changes from v1:
>  * Rename to generated-content.rst and add to documentation index.
>    (Jon)
>  * Rework subject to align with the new filename
>  * Replace commercial names with generic ones. (Jon)
>  * Be consistent about punctuation at the end of bullets for whole
>    sentences. (Miguel)
>  * Formatting sprucing up and minor typos (Miguel)
> ---
>  Documentation/process/generated-content.rst | 94 +++++++++++++++++++++
>  Documentation/process/index.rst             |  1 +
>  2 files changed, 95 insertions(+)
>  create mode 100644 Documentation/process/generated-content.rst
>
> diff --git a/Documentation/process/generated-content.rst b/Documentation/process/generated-content.rst
> new file mode 100644
> index 0000000000000..5e8ff44190932
> --- /dev/null
> +++ b/Documentation/process/generated-content.rst
> @@ -0,0 +1,94 @@
> +============================================
> +Kernel Guidelines for Tool Generated Content
> +============================================
> +
> +Purpose
> +=======
> +
> +Kernel contributors have been using tooling to generate contributions
> +for a long time. These tools are constantly becoming more capable and
> +undoubtedly improve developer productivity. At the same time, reviewer
> +and maintainer bandwidth is a very scarce resource. Understanding

This is absolutely the key issue here imo, maintainer bandwidth. Glad this
is in the opener.

> +which portions of a contribution come from humans versus tools is
> +critical to maintain those resources and keep kernel development
> +healthy.

Agreed entirely.

> +
> +The goal here is to clarify community expectations around tools. This
> +lets everyone become more productive while also maintaining high
> +degrees of trust between submitters and reviewers.

Also very good.

> +
> +Out of Scope
> +============
> +
> +These guidelines do not apply to tools that make trivial tweaks to
> +preexisting content. Nor do they pertain to AI tooling that helps with
> +menial tasks. Some examples:
> +
> + - Spelling and grammar fix ups, like rephrasing to imperative voice
> + - Typing aids like identifier completion, common boilerplate or
> +   trivial pattern completion
> + - Purely mechanical transformations like variable renaming
> + - Reformatting, like running Lindent, ``clang-format`` or
> +   ``rust-fmt``
> +
> +Even if your tool use is out of scope you should still always consider
> +if it would help reviewing your contribution if the reviewer knows
> +about the tool that you used.

This is great, I agree very much that we have to be reasonable about these
uses.

The final sentence is also great.

> +
> +In Scope
> +========
> +
> +These guidelines apply when a meaningful amount of content in a kernel
> +contribution was not written by a person in the Signed-off-by chain,
> +but was instead created by a tool.

Yes, perhaps useful actually using the term 'meaningful amount' rather than
trying to be absolutely explicit about what this entails.

Also allows for maintainer discretion.

> +
> +Detection of a problem is also a part of the development process; if a
> +tool was used to find a problem addressed by a change, that should be
> +noted in the changelog. This not only gives credit where it is due, it
> +also helps fellow developers find out about these tools.
> +
> +Some examples:
> + - Any tool-suggested fix such as ``checkpatch.pl --fix``
> + - Coccinelle scripts
> + - A chatbot generated a new function in your patch to sort list entries.
> + - A .c file in the patch was originally generated by a LLM but cleaned
> +   up by hand.
> + - The changelog was generated by handing the patch to a generative AI
> +   tool and asking it to write the changelog.
> + - The changelog was translated from another language.
> +
> +If in doubt, choose transparency and assume these guidelines apply to
> +your contribution.

Yes agreed.

> +
> +Guidelines
> +==========
> +
> +First, read the Developer's Certificate of Origin:
> +Documentation/process/submitting-patches.rst . Its rules are simple
> +and have been in place for a long time. They have covered many
> +tool-generated contributions.
> +
> +Second, when making a contribution, be transparent about the origin of
> +content in cover letters and changelogs. You can be more transparent
> +by adding information like this:
> +
> + - What tools were used?
> + - The input to the tools you used, like the coccinelle source script.

Not sure repeatedly using coccinelle as an example is helpful, as
coccinelle is far less of an issue than LLM tooling, perhaps for the
avoidance of doubt, expand this to include references to that?

> + - If code was largely generated from a single or short set of
> +   prompts, include those prompts in the commit log. For longer
> +   sessions, include a summary of the prompts and the nature of
> +   resulting assistance.

Maybe worth saying send it in a cover letter if a series, but perhaps
pedantic.

> + - Which portions of the content were affected by that tool?
> +
> +As with all contributions, individual maintainers have discretion to
> +choose how they handle the contribution. For example, they might:
> +
> + - Treat it just like any other contribution
> + - Reject it outright
> + - Review the contribution with extra scrutiny
> + - Suggest a better prompt instead of suggesting specific code changes
> + - Ask for some other special steps, like asking the contributor to
> +   elaborate on how the tool or model was trained
> + - Ask the submitter to explain in more detail about the contribution
> +   so that the maintainer can feel comfortable that the submitter fully
> +   understands how the code works.

OK I wrote something suggesting you add this and you already have :) that's
great. Let me go delete that request :)

However I'm not sure the 'as with all contributions' is right though - as a
maintainer in mm I don't actually feel that we can reject outright without
having to give significant explanation as to why.

And I think that's often the case - people (rightly) dislike blanket NAKs
and it's a terrible practice, which often (also rightly) gets pushback from
co-maintainers or others in the community.

So I think perhaps it'd also be useful to very explicitly say that
maintainers may say no summarily in instances where the review load would
simply be too much to handle large clearly-AI-generated and
clearly-unfiltered series.

Another point to raise perhaps is that - even in the cases where the
submitter is carefully reviewing generated output - that submitters must be
reasonable in terms of the volume they submit. This is perhaps hand wavey
but mentioning it would be great not least for the ability for maintainers
to point at the doc and reference it.

> diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> index aa12f26601949..e1a8a31389f53 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -68,6 +68,7 @@ beyond).
>     stable-kernel-rules
>     management-style
>     researcher-guidelines
> +   generated-content
>
>  Dealing with bugs
>  -----------------

I guess this is a WIP?

> --
> 2.34.1
>
>

Thanks, Lorenzo

