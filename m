Return-Path: <linux-kernel+bounces-759339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0999B1DC52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E66B1AA77E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732622727FA;
	Thu,  7 Aug 2025 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zg9MefGU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XBpQh6gJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273026D4E5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586524; cv=fail; b=RRH1IyG1m/RkCkWiGV13fgqSBgZBqrsslIp1D0L4bkDJP6ZBAPPqgiAiq5fqNMQmgmzlGJL7HDg/DIgvGsgtmx50pFCWGVhf9cNuVdfnkTNtqqdyAac9Vdq/lE0d8s0OZKZPMmMLxR9NwhXyIrleUkpbqGe/MrdQXb8k+lkgljM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586524; c=relaxed/simple;
	bh=aX+m+Nj8Uhh0N26hVUpsXQZvYKTm8Up2oZ8sK33KXNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YMfuPGkCNO4f4OjKJ6y0AUTE0VXnBEI034JZULUpKt8DT0LNy8UJWa5DcnHTLNHOvLDhhy5qnCkhQUgvkB1WNV3gXGF6HMFPHAmAvcmZvtPCG0vBvAPbS/lr/biHe8qG2uNMAupoy7LOCobQvqcoTShqMobRwCxhO5CWp9sb8uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zg9MefGU; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XBpQh6gJ reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577GgEus008796;
	Thu, 7 Aug 2025 17:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fipLYyJu/pPxPnSL+Vfb/c0t3uwlbcfnvijtM3dPzSg=; b=
	Zg9MefGUqRb4c+tArFLbW+STnozzxjZrzNytXjBYIr793hjenut37XU0kFylQGnT
	ZR9heoEFUJgU0iRO5dvkmbBzH4zKa7fzxVVKCMdrAnDHEhQdqwr82ycMqmnHIKS7
	PyYTTRDyCUVg69DHJIFE+azLrQJs2WjC3oRf/EurbS7OstIDCN6OAX9KZIWOBeva
	AS0j2hxrpy1/F+VjuWSEzO7sW1oALaU8hJYtjXLKG8I3uFLWsmmJOUj4CSAofX1v
	ft6e0a+ouPxrFwiKta/U8I8zndZZBfXGQbbuGOOXlgHkffMa1X/JqSOBahSPFew5
	DynST325GG4drrW14B+dXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy4rmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 17:07:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577FnYaF028190;
	Thu, 7 Aug 2025 17:07:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwnx4w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 17:07:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPhyRloV6HHWzY/5i8E0Hy2YtLJaIPZiGclIs6jj+5mhgudKe2eG/kzgXl2JZSC4yXWB0rxGXa48vjTYGKFkUlODHGIfN/4KRLWPfY5EJtXo+K+u/4pajUikaBk4YHaOqU3fv8n/C9lNwsgBd2rmQgv6QGnk5Qvgb2MBJS1vWFXmkBxGTGfVXZ4Qr3tjX6UENNWq7Jouf4lyNTRV2i4gwHuh7pVidS9Em4IVHjNEPhOXuUzMs6uZoIkL+Cr5APgEimHUwijxMZQV+WPzFpl1I+MWQbDYQKrUieEnOhcvxEMZ0N2m/7ZKamf2s2i26xJFgMinGo+L6yYDPcdzD6zBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeULpkoIgGapdJUwdbcYfo2NUp9WGLRjkE8FwsUdCj4=;
 b=hWSK7458zhpt+TjyGK6dgPQHGqz4sfik+y0N/25ChkLeLWeGKeetzl2oTJ/RiV+ijjIFJu3Gwa0K4cuVZTS/HZbGyL5nUJaeKcj2Hf1G11CBTB6Zu9kF7dMM3pp8ZO/6Kl2GGBF0I2AwXU/RpypHkn2GDO5GT5M68zaRqsV9H4PArJRev58vaNLHBCXGzg20nlYcoDPvlD348+KEKoBNg+4H/pYRpNzBaAHG2qpk2biLJJ6NLuC4kA+8YexFJWi6Mvehz8HhL8cpeAzh4+QTVEP4SSm1S9ksGPp9iueDQ589C1IdR5t6B87KSBuUVi2oRwiC4KA82v8jCeL+XeVMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeULpkoIgGapdJUwdbcYfo2NUp9WGLRjkE8FwsUdCj4=;
 b=XBpQh6gJTMOnuUqMr416Tapk9lF9HB30aRdqLJQqb5LrHpLP+8vjBehSviGgwEn4ZyzC81l7iqv5Bj4DGznXSlxs9lkB7Uv6GNiO81OEkbutBTJ133XWTnh3BzFdwYDLUzcnCF3S6ozWaY5lrYG3Dwk81S04Xo5+yH9BmOB7VFo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5141.namprd10.prod.outlook.com (2603:10b6:408:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 17:07:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 17:07:42 +0000
Date: Thu, 7 Aug 2025 18:07:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: David Hildenbrand <david@redhat.com>,
        kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <baohua@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Bang Li <libang.li@antgroup.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        bibo mao <maobibo@loongson.cn>, Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Lance Yang <ioworker0@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <yang@os.amperecomputing.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org
Subject: Re: [linus:master] [mm] f822a9a81a:
 stress-ng.bigheap.realloc_calls_per_sec 37.3% regression
Message-ID: <404ae0cb-9c70-4aa1-99ef-b5e90c500140@lucifer.local>
References: <202508071609.4e743d7c-lkp@intel.com>
 <9e3a59b2-11c0-43ca-aff3-414091f04aa4@lucifer.local>
 <97419aca-af5f-4328-84dc-c97bb73ca1ac@redhat.com>
 <96e931a6-c70e-4a11-9e8c-c5a08da7f512@arm.com>
 <66f44615-8df5-4e81-97b7-1f6a01401687@lucifer.local>
 <923f1a9a-4e34-4922-ae2c-c8d974c2522b@lucifer.local>
 <507b057b-8130-4f71-bcb5-11a2000f20af@arm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <507b057b-8130-4f71-bcb5-11a2000f20af@arm.com>
X-ClientProxiedBy: LO2P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b0e890-fce7-415d-6ff0-08ddd5d4ec0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?f6e0SMFPg2Pyojv/n3gU0Rvg8YIqKxZ6tFSiSubHQo8tyowrw2E3LxuTqy?=
 =?iso-8859-1?Q?rTmywQfC3tPErXCW6BKGDday4W5uWTKfR04LVE6y1AUl07S3Tqcfpz6h4D?=
 =?iso-8859-1?Q?f0MrCcy65vd/k5lmJy7Mp6bfPbmoKPleVRHDRprMHavq0AsaDKX0c/G0AS?=
 =?iso-8859-1?Q?p/3bR6JVXry+gfpRmWVI8JTj5x30rGi0U0ybzxsqHAkwE09+gkCwYg7IPc?=
 =?iso-8859-1?Q?zJjzN3Ah8QV2tzeRgImKSJhksKxvlRQpmB8DY6zgCpqyZp+qfEh1yGV0p9?=
 =?iso-8859-1?Q?F8yi1YrjGdecMHzB9OogRulXdapzI8vNUqLhTT4CEsaHwROgMz8iKLjTnG?=
 =?iso-8859-1?Q?PSoSIcNnz16g+vBsCp+9ZHxFPH/JTYhaGUr9+QAvTgLIub2fxQm08HUtJt?=
 =?iso-8859-1?Q?Y9EvxGXgm8PJYtgW0Dtr26+pg1+Q2tV+xqW6Qse9z2XS/JXNN7uzv1Ru5Z?=
 =?iso-8859-1?Q?t1ydT72VVg8uLJsP8RkKFuu8Nz/TzDsH8CuZDhyQoSbDE5JlhnAsBmEuq5?=
 =?iso-8859-1?Q?Z89/TVuc6DZcpy7SQCcRqma1t9trIoyT56qaPAY9+4o3RDwW9VM9vbjg4N?=
 =?iso-8859-1?Q?rq4BL84lWqiIydMJpn+BkljvLcOKACFimp7h0dp6gcVd6R52uLpxYvE2af?=
 =?iso-8859-1?Q?RYDO9m0dF892l/CtRF4OF6ZMNAIP+fVpkumQJwQ+V6/NpiYqMXgdhHfWAI?=
 =?iso-8859-1?Q?MzMeqMMDx7F0fuvv0JnhMzzivy6PZHt9PNuosFS/Q0zcXinbxJFTK7JRwo?=
 =?iso-8859-1?Q?M4Q9YG8fDTnMyFwE07q+1dzeck3VAocz4IhaQuPtf4GhTltdLaAE4mmlIH?=
 =?iso-8859-1?Q?sUrAt7u3jkO135y8gKmEPhfVqpZZ5j/cy/DZGoRW6zrZ3wLwblLTvy8Xcp?=
 =?iso-8859-1?Q?C2PZfc4/mAI506jUCr9a8VlsqELmzvNr1t6rui8TeV6VWK9joMQQ8EyDi8?=
 =?iso-8859-1?Q?ZaCKfODPesR5bUZkJqVGnssBK3mwYQhNoED2hwMU4Ifl5SDQBhmPIIHt7s?=
 =?iso-8859-1?Q?ALn1KnNFNHivhTkdWF/5phN7gXOyA3MIzXHlMGpxCr5ST7Ku5HZleROw9+?=
 =?iso-8859-1?Q?J0Yjl0KOcP+2TGgpnV07GagS8UlAQrzfWodDmgJOE27A2TTy+PR8g96vZ5?=
 =?iso-8859-1?Q?cr9nyE3bxQCOhTgfS2lbMOnwXHimbRGdvp7bDiwJNUBezPxB7Km+rp1Zgy?=
 =?iso-8859-1?Q?awU23K6zIbx3oWOtQRda4TL99I9otDqfIVXTKGpUYlxBLRVr9TCBthnSGq?=
 =?iso-8859-1?Q?qRPXuwMaqPLe9PKk3EmJVL3RBXPW5iNTx9q86RljV2jG4eyI5o+FSfz36w?=
 =?iso-8859-1?Q?UHPAf3v5RnSyfnSil9ahKvP2mkrC1bppFgeF1GeQJbNmh0SnzykIYY/vRv?=
 =?iso-8859-1?Q?IvUlPIxFzwtssWMyQov9BxmJlfK3nqoCxa0lEWeK4lKrzeBv5pZHW9dpOs?=
 =?iso-8859-1?Q?wO1ccU1NlLczQ5z01DkVC5uKUPjweHS6Sw4yKGcTJqm0H7DB9ozHCfs8q3?=
 =?iso-8859-1?Q?Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?V1X15ndUcAbbMfL6PbL9CZHctHdq0gdBYZO3glqtEPoOtIpoN9uUcazNVg?=
 =?iso-8859-1?Q?9an8/9Dq9jwdLRVwOkbwcEWnjoMZObuvHULi4XMtvNKbu4n5ofMpQGVCuE?=
 =?iso-8859-1?Q?pXGPCnIALIsYl4XFZOX/oQ/rv3owRVeNQ1oLsLR8/p9m9CjeIKbFNB5th1?=
 =?iso-8859-1?Q?GjmVDPDcRTRQu19Me7YuFcrXb61tjCulsrgwAgbVsam88s5VHMOarmr74d?=
 =?iso-8859-1?Q?yZimwaRxs/6Wq7j0aKibDuwqDEgO0UrGyWPsk3wCxD3NWA3DJqQxQ6tZdA?=
 =?iso-8859-1?Q?c73NGdF1vwwbaR/cZiGZ78nrcrxPJRw0YPVqIiIhGoqJ3WzK7STscVepGj?=
 =?iso-8859-1?Q?5a5FgiP0UT74RvzHSAD+dnL+iEVI3vvoglOBDHEVrDTjDN3xfCZzIZ/T++?=
 =?iso-8859-1?Q?mBzGnc4r8kT7yyQ4rbqBt+DRD7VQ4reTxx1FnYL53jjPnSDn3rCP3xrHBc?=
 =?iso-8859-1?Q?zF/RXkNspUpotS8O+FsNayY5vwTjuwtO5KodQg8VJaapqH315cwo8D+8Ck?=
 =?iso-8859-1?Q?btw9Z13DCOHCGN9vcRq8O0WzSEQXTwqJ1w2hSqJGGooBCt8HC0cTUgTD+H?=
 =?iso-8859-1?Q?XaSWegK/tytZnVxCUBIB+yrF/85G1YVmhlOxIX+leAkkVSdWnGYeHUL9iT?=
 =?iso-8859-1?Q?DEB7V0WoVm1Dsq9XsDRSC7MTrj33p56z7jCWpfG2gaN+NReYjuOqUNQ2e9?=
 =?iso-8859-1?Q?Jaji/0ktu7g7AUuhBv+nzp/s8AJSM4neayl9Vg7HxiU1YhU1Wa6PAIagAb?=
 =?iso-8859-1?Q?5L3nvrVoHx/c/h9BlFlMRGWmCQ1bk4woC0FfazrstLa5RkvU0Fz7/uoM7J?=
 =?iso-8859-1?Q?rpDbf2NSskxwWbBurFp/EFDiLF/0S9WHQo7u+pDQ5+p55t2Ns+1c2egC8N?=
 =?iso-8859-1?Q?8FFlDtMLC0UXD/o1sxV9tUtGm02rajuj01kCjKY7CcSW5kAZAAiNuN3sVU?=
 =?iso-8859-1?Q?c0rYjvXljPS97lIVD3JzqBs3C7aLfWMdd7r1wXkbpJyxYs3U5vGSRdqpFC?=
 =?iso-8859-1?Q?rYLjTlbLuIhMc5zVzu97DX38w8gNYQb9Qgzi6YuXL3Y1xENC9tqTjPRwjP?=
 =?iso-8859-1?Q?2ZPTUuWtgSIYGy68d0f/Ot8NYsgIMLVohiu+KfqHhGCGAFW6yhvytSKpIi?=
 =?iso-8859-1?Q?zZswtuG6Lz3kdW9QfFuMSP92C8ZYkKBiLtonnqx2GBWevXMR/jC2FIzz4f?=
 =?iso-8859-1?Q?OhgsFw5SuVrCr6NpOPSMWr/tji6hnMWT3q2dXR9uG/a3OzDJZidowb1eO1?=
 =?iso-8859-1?Q?Dbq+/HHrtXHotvaeDmlV9SUVZHk+RFxjKWzRnIoQOzSRVfhaNjsW/Ol4nw?=
 =?iso-8859-1?Q?KTdI1J84p03IEd6JEaF2SdszjiQVr198s4osBG9veEArH06y+k5ptUiAcu?=
 =?iso-8859-1?Q?Xh2RJCzudCpsqLowMfZnJfCgljeTTjhKriiFNnqcJGa155HjvZASBP0N3Z?=
 =?iso-8859-1?Q?AOmJV/dJeM5r2Y6+e3+4c0VtdNeqZfxVSWrDXlYPM6UjaL3QOZ4ik7CggN?=
 =?iso-8859-1?Q?9dMG/2o6EJ4wIi3b/27aX+uX2+6/uZ3c6OE3m18hfi4aVsmzkWwuKzYGfp?=
 =?iso-8859-1?Q?BeNooNbd5gWQmV5uqn8LvnNwf3Wg/p3ZPZH9p1Jlb42VV5uDu99YfcEEaB?=
 =?iso-8859-1?Q?nv0FgGTKiDVcIlSCC8VsLCOCf9/nHVMOI8yImU6CxlZomHK3jMfKWSSA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o8QhWC5CGJX3ckBz7XWPt+2K9Me0+FT7A+3ivgrexkdBZjTjWunIswwkpXEVrq6Oith+ZV/+oGMsDrZWEkIw06zIezcXWIs/IgVgjck6H4xSEnGCm09OqEkv8y3C1vGICxsmLzByOPA2yTMvhZrvEuk6G9VXdPSIjfUjYoPcnlIEDBnmEevyxjnEB5bFnG+6nMww1ZmsvNoTn0wWzmTxLvRI98cC4z/tvt1NGoRmz9gsdxr28o/KZv79wDjv69x6ef3Hoa/8wfm2qq1pbgShDIKW8iCJviO51SQgThtFGAhGDLCkzUNwcMTIR+QnO3Sprw5tJqkQH1bIVzib7iFBMN98gY+y6jQ1Ux+UqcErer6A/kw66YWRpl+5cf/eGF+ecmE1iJ/2F3pzSyxklU+IcBm1sd5vp9PCF1mewmjoBFGkQ/iYu1ttdwmna7Qwv+emqBF5rNg+K894mZEczEZP5i+Y+hzsKGxnIM+5uu75Qr3wSZmheP/5z2Q9uN6V/dZm/xUyaoC5eUWvJLVS+cs1suySRjZU0k4mW3/0SbmUh8PepgAzPXMyCbSEY//q/6L8liM4X9xLWUocmbzp4VosQnK4tFpB1TSVm0QTwgBtsCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b0e890-fce7-415d-6ff0-08ddd5d4ec0f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 17:07:42.7330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xQfQNAc731SNKCX52qQRzfMhg63rvcyMl4cgm7njqQ8truc0b4ZKqsa6jG0laWXIjZbj6goeclfXHI/Y8v0aIszg6rhxcc9UwUfqFr1HtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070139
X-Proofpoint-GUID: mbN2zH6FhJZpb_P1LKDW0qKf39FT4QkS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEzOSBTYWx0ZWRfX1P6/I6LlP5FB
 kDL7bhmqcS9hPinvq9EQt5BFTCNAAkxaACHXOpbuO6ECO837Uq9Eghug/OuI48ykxjbK6WYXl5S
 yDqleLNeuPmSxjprz07IhgsD9alZnAxVCU+VJZU4oWOCCU/BrJe5AL6bgwEnuprtcFuDr37rywq
 YaPNtb3IgGvvYPkb5C0Wb9eFv70qE+d5odfoUHuJCIlU7HHneGU6HYJa9ek+ZMaoEumjkuVK+15
 N/ydx/udyNySGl2U3o9MAjkFE6C1DuscDCEkGY9cxhZFUKUjAGVWSdKrdPyAfjvvyxAqYGYIEe+
 py3HGZkr/WFKRAvZD9F7oXOBFRFuFnm9o2+GpdRJ/x6vvsrI2DyUW8oRL/TXAVREPvisBPKvgUF
 e5osuMnGOmD0k5AOuxM7Md/pJzVHiSYr+PuH0G84YQdm6YNCD+RQiurTqFVxndMh0OxYnIkm
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=6894dd63 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=jQ7RC0sj0H2E5TSe71kA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: mbN2zH6FhJZpb_P1LKDW0qKf39FT4QkS

On Thu, Aug 07, 2025 at 10:34:43PM +0530, Dev Jain wrote:
>
> On 07/08/25 9:46 pm, Lorenzo Stoakes wrote:
> > On Thu, Aug 07, 2025 at 05:10:17PM +0100, Lorenzo Stoakes wrote:
> > > On Thu, Aug 07, 2025 at 09:36:38PM +0530, Dev Jain wrote:
> > >
> > > > > > > commit:
> > > > > > >     94dab12d86 ("mm: call pointers to ptes as ptep")
> > > > > > >     f822a9a81a ("mm: optimize mremap() by PTE batching")
> > > > > > >
> > > > > > > 94dab12d86cf77ff f822a9a81a31311d67f260aea96
> > > > > > > ---------------- ---------------------------
> > > > > > >            %stddev     %change         %stddev
> > > > > > >                \          |                \
> > > > > > >        13777 ± 37%     +45.0%      19979 ± 27%
> > > > > > > numa-vmstat.node1.nr_slab_reclaimable
> > > > > > >       367205            +2.3%     375703 vmstat.system.in
> > > > > > >        55106 ± 37%     +45.1%      79971 ± 27%
> > > > > > > numa-meminfo.node1.KReclaimable
> > > > > > >        55106 ± 37%     +45.1%      79971 ± 27%
> > > > > > > numa-meminfo.node1.SReclaimable
> > > > > > >       559381           -37.3%     350757
> > > > > > > stress-ng.bigheap.realloc_calls_per_sec
> > > > > > >        11468            +1.2%      11603 stress-ng.time.system_time
> > > > > > >       296.25            +4.5%     309.70 stress-ng.time.user_time
> > > > > > >         0.81 ±187%    -100.0%       0.00 perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> > > > > > >         9.36 ±165%    -100.0%       0.00 perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> > > > > > >         0.81 ±187%    -100.0%       0.00 perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> > > > > > >         9.36 ±165%    -100.0%       0.00 perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> > > Hm is lack of zap some kind of clue here?
> > >
> > > > > > >         5.50 ± 17%    +390.9%      27.00 ± 56% perf-c2c.DRAM.local
> > > > > > >       388.50 ± 10%    +114.7%     834.17 ± 33% perf-c2c.DRAM.remote
> > > > > > >         1214 ± 13%    +107.3%       2517 ± 31% perf-c2c.HITM.local
> > > > > > >       135.00 ± 19%    +130.9%     311.67 ± 32% perf-c2c.HITM.remote
> > > > > > >         1349 ± 13%    +109.6%       2829 ± 31% perf-c2c.HITM.total
> > > > > > Yeah this also looks pretty consistent too...
> > > > > It almost looks like some kind of NUMA effects?
> > > > >
> > > > > I would have expected that it's the overhead of the vm_normal_folio(),
> > > > > but not sure how that corresponds to the SLAB + local vs. remote stats.
> > > > > Maybe they are just noise?
> > > > Is there any way of making the robot test again? As you said, the only
> > > > suspect is vm_normal_folio(), nothing seems to pop up...
> > > >
> > > Not sure there's much point in that, these tests are run repeatedly and
> > > statistical analysis taken from them so what would another run accomplish unless
> > > there's something very consistently wrong with the box that happens only to
> > > trigger at your commit?
> > >
> > > Cheers, Lorenzo
> > Let me play around on my test box roughly and see if I can repro
>
> So I tested with
> ./stress-ng --timeout 1 --times --verify --metrics --no-rand-seed --oom-avoid --bigheap 20
> extracted the number out of the line containing the output "realloc calls per sec", did an
> avg and standard deviation over 20 runs. Before the patch:
>
> Average realloc calls/sec: 196907.380000
> Standard deviation        : 12685.721021
>
> After the patch:
>
> Average realloc calls/sec: 187894.300500
> Standard deviation        : 12494.153533
>
> which is 5% approx.
>

Are you testing that on x86-64 bare metal?

Anyway this is _not_ what I get.

I am testing on my test box, and seeing a _very significant_ regression as reported.

I am narrowing down the exact cause and will report back. Non-NUMA box, recent
uArch, dedicated machine.

Cheers, Lorenzo

