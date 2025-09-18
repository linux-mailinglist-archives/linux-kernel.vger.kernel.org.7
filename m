Return-Path: <linux-kernel+bounces-776409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C292B2CCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745353BE90B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0149322DA5;
	Tue, 19 Aug 2025 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nbG8aPKU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DFqKhVt5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7E31B137
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631664; cv=fail; b=PO8MpghQ1sPyf36lSBK5OEj5CUk5OHHIzYORmrgWblPAZFAZB8f2HpM8rjJaZi/2dQeXry2AP1SMeXwF/mJY9ITEsQRo8h6iNtdqJ3E6AtQaOt5Mm9jbr06gREE2atwoy2fyWYUXvnyddNcnucGVFReH6EwtPJeWpuVBmkqhmyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631664; c=relaxed/simple;
	bh=QTPOpNU0PB9gnQErEyLU4B4K+Jf14AYzJqA41oHCyls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LzFMfdbh0nz2xli/lawKYD4M2cxcTMtWkYPNV6709AlhwwecRzNo69rt6neFLxJ6JxiCJyfoPkeQRi5o86PJrzwA9tcTfQsUXOHxIDFDG+wpqKe+xzN2NcVOoU+bwepljP955rknXGNJu63d+fl1adCLD2yhkduBUj6J1JDxyiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nbG8aPKU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DFqKhVt5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JID0cX029554;
	Tue, 19 Aug 2025 19:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FlpRmwzb+zXetZEzKB
	DWt/L5YhucPvNUwcu3B1BXpAg=; b=nbG8aPKU5dh24CGW+DcE2IpciX6GKCHVI1
	e8tnk6ODMP7J/uiMt64vCoh01XWdt3pR3HmekN3QaJvas+nBo56N2bV9isNxvhYs
	VSJGnAFGKFXNmp19XqcJJqaGB6mtifnUqgUhjiSEJLFGKrQJ4DjGPVinsP0Tre0A
	MqV9vb+fLlL2DZJjsR09e68DU1RpFZ97gko33JfvR67tUUmQnCQ3YfRs8tj+nTpw
	P3DeW8s6/eiAvONeWN0nlz7aeM+NxzhuNSiZ7RcGE4Uyq7Jm0KFSjocrUl/tYYew
	lQzPlrN8DjBap0aA6uYYmNYYJiepvtV0GduC2J6kqi0VoLdpSH3g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jjhwx362-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 19:27:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JJ47u8007374;
	Tue, 19 Aug 2025 19:27:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3prt34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 19:27:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwOAHvClbt1bpVkdUuPZAUuN++EXPaxRlCw/14axIqoM2k/gQK1MFJMMVL1drMoLPDBTh6bqXOGEY6clTObLovrZV4V4zKEDKTTN65Z1p5TnjiABzHsrkEHmhtXU7/XP0+ynXNjKIivVil8122MnHVge/X3VrZe/5+LMStNEp0aRJiEqDsMJVnB9X1yY55zyEjLj0SggbZZ0t2aO3IgshcMq1CDSri8TqrJsHChWzU98O3oPiBH5IwMDzr3qhfqOYC9q1K9PdI/Z0uyfac1oGjmoWGN4Z74SniHCZWtkXw+VNwhj/sxs5Q90QFiGRuKLJc3TCy6KboqiOjzr9QWCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlpRmwzb+zXetZEzKBDWt/L5YhucPvNUwcu3B1BXpAg=;
 b=WZdxZZc9rvLZW+ojp+KFAxuW6TL/7SEqeXocJ5pH77Gy9w1ukn9+tjqStjFceVtSlx2/jU51g0YxawvCvYhCpJ2niTpCvkpPLoD/WrE8XKbJzRBnJnA5bqD0lzP6SpAEek2Utzy6UXfJ8qRCIAHgCsH0X8THjTwr9n2cDy/L1H8s3yecmIWl5toAihAmRIGIwHfDppkGvy5p8AOECPP5dQ0kf/Y/MrVQGu2s85BSNRh8uUvWi0jIOVtZljw1KzyLMfjPUB4LOeyRtPEMznCwDi777y6dN0baNGMl23scXC9Wd7ZKWrE7xUBy5s/VSLC4NfYInC+Fo5/KeVCjA9AmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlpRmwzb+zXetZEzKBDWt/L5YhucPvNUwcu3B1BXpAg=;
 b=DFqKhVt5ubzTOicN6xA8wah/0sVJqEWs2BJ0yLMrO1cUzjDGF2bmAL7uqz+i1i3dgnPcRKnv1SkLyeVCaRoFtubXv2kMRqJq9XiRUW/gZUrFWxrtORy/kgSpumMghsQW85Jb6LBIs3+KVpPEDw9G2NkkFNeWodT3aX+xwxvBPO8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6689.namprd10.prod.outlook.com (2603:10b6:610:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 19:27:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 19:27:06 +0000
Date: Tue, 19 Aug 2025 20:27:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 5/6] mm/vma: Add page table limit to unmap_region()
Message-ID: <ac33f990-1f79-498c-96ca-12ffb26d8093@lucifer.local>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
 <20250815191031.3769540-6-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815191031.3769540-6-Liam.Howlett@oracle.com>
X-ClientProxiedBy: GVZP280CA0066.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d15efe-f9d7-4500-55b0-08dddf56622e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8majM+4oCZQye6qHwl8Qq3GGgppH3dNxpJ5+gUkuZXxsnQzM9Yj3d7yhQ/2y?=
 =?us-ascii?Q?/0rcw+4Oy2bjXgUik25m6t6KjYcuJ6aQdL8hFlQTicJYJI4KUNv+UwQqshCc?=
 =?us-ascii?Q?aWaaraXW/pv4xscesbsShWTpuyKuKspPD3+BTJ2H2CtNIvWTk8vqA+SSU04w?=
 =?us-ascii?Q?47to2rHcvWDjO9JFXPMlVylBtGCxqFBq0BhFcexqMSnCmPXgBrUJ7JOCsLpx?=
 =?us-ascii?Q?2vFIRbtnN02qipWnAMnn+x/A5DWPJphCc60i9a4fgsErYXnsx5zwuDcXrMkl?=
 =?us-ascii?Q?7x34NeePPl0vTFwROE9b1oMHj0dsdbF40SEN0vfStEvKlMqyBWnKiSy4tHnG?=
 =?us-ascii?Q?POys82B5XEjhU1ak8pLaHPTwJqVv1t/X2+NUdpTWr+6K6hSSg72vesUeokfz?=
 =?us-ascii?Q?9KqqiQsmoVJ+PU4u0vMkwQPkM+q6Lq2FinJ3Q8f33TwEJ5f2duaRZr0c2ZBS?=
 =?us-ascii?Q?Mw4lU6t598kJn6EHXo+7LJbKNirft+DVCLyHWXQUpQj7GS+P/iTPK61lHyxT?=
 =?us-ascii?Q?56miy+ax/V39JJXYpEYOmCIfXA9x68a6fi1vayW5OvPyPqGveq/p98GRgaXy?=
 =?us-ascii?Q?T0hDR85kWRy90NXOKoRX9H8UwdQJyeqxak5RrXBVu2AANs+R+xfEop+bpiBe?=
 =?us-ascii?Q?tg3i4ddWBjZBIbYuPtI1SFseJZROM9Yy72PRBJGEYHu+Gzp3rinTjaRwY8/2?=
 =?us-ascii?Q?OLIy2n9mesMmATJqzznX2BN2jdgmVp4Nb2c+MmUDi8FhA/N9nEyFPYeBh4wn?=
 =?us-ascii?Q?5MEqa1fSRlGeq9U0qkhp5NT4ndhTN51rbyF+Khw3vNQuOfPkvJ+ugTi1O4aQ?=
 =?us-ascii?Q?D6aVYHXFyj5f3dlU1f9q4niR9eSQcfW/WDPBR+P6Am8RY9BAEOWH8GcqzbUY?=
 =?us-ascii?Q?AX8Bv7BcQeCTmWMtCvTQHnReHZ4CQhzbVUa9PcZ4+uNZPO56B6US6KaLJp3x?=
 =?us-ascii?Q?hikvDP+5pSSBkkmCyvpUyTQ/5okzdYUW5n8/gl3WRoCSeAsxM3UG9vm+twJI?=
 =?us-ascii?Q?ZZIE8ITDptRDZi0D30VxsdR6eFEricJB+fN1YUCSjKdK2fywhXWN6Snv7YcI?=
 =?us-ascii?Q?hfipEPZ9kT9T/KF0jd0KLnc+shS8Z6ogRAOiPixPw2rs9yNHCm1YUf3zGwnb?=
 =?us-ascii?Q?TblvPh69e+Pt1Hnv8lNxe9590O73nOdAZ3uq55KERuDLfhlTnd4G0LGaMzCB?=
 =?us-ascii?Q?/tSXym1fwel2uYm6/3k3ZkSs/b3yGEjIeKGbRVT34KUU8eBEZOgeZxQt0fJJ?=
 =?us-ascii?Q?OObQsvXtczVMlb+xT+gN0E3vArjj5BWxO4gz9VmyF3mKQ83UPgraMfsUpwxf?=
 =?us-ascii?Q?zVY8jMa++gnG6xb01T4s65JXUAMdBQfAeiYb4tRUwHQA7VqBVHC05+PyBp8A?=
 =?us-ascii?Q?8Xazw+d8fs6KlnPoToR7OmXCEmu3rJbkTetUMFciU1Uf/W4a8+yqQduyem+5?=
 =?us-ascii?Q?HM3gZoWDshY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6OqUHLhEz7En0kdb+TE46O8UxYYfpDGagcPobs9JipaGg1okQg39FGDbRaWC?=
 =?us-ascii?Q?V1bBiugY9xN3hvrD5Yk1N/w13IvyGonSeVcBkCK+uwSbLWjSNw0t4gS4z5/U?=
 =?us-ascii?Q?WuVBQ8SP/poZEH5ENoWSY9iOH/hlr6nfki2QajOJII4NUW5nuusQcIXDUhqq?=
 =?us-ascii?Q?bHjGqx1X2pGHQfDfpAokJI8cdiMP5JtH7h1e854XB3mgvrofj9aG0rTISqlv?=
 =?us-ascii?Q?LIchWw33vn6HsJ0DPiWf3/ODj5ZcYwwU5QeB6TfpDP6TSNP/2cv97LW+RWk2?=
 =?us-ascii?Q?q094nBWfM47Wk7GOoiBgf7YAMwLJ5RaDjaMI8rVmp/EuIEv33knVRj2wQxoN?=
 =?us-ascii?Q?P7xTmU6wz3Ua412ji912DV98BtKuC16QAcoaG96x8NNk5csTPknjD8e3vVCU?=
 =?us-ascii?Q?aQlineifzUk6KPhoRSIO+4eUR0KWE0P9oY9ixPSTJa2tUw+KTmTySlPBlizI?=
 =?us-ascii?Q?evsGWKbSLOQL7btW7i8IcQDRw/a+hLSOgDrGScPsDZTR7/FoZWf778n8l3B/?=
 =?us-ascii?Q?MEzt9Vs8RYjOBNPZzUwOntzKFQVCKc/Sqvpbj/JrKtAAGH6h8Q3Ty6PIcFD7?=
 =?us-ascii?Q?HJUeWBQ6RvBpgPCek+pg9iLToQOG9kgh7HCRLXuxBCGH0BfjzpoDyTFJLq5m?=
 =?us-ascii?Q?oTRaJHJpnHhPhF6MAh3ZsMoTfSAhNwKgojuabRBGL1oPdLb3TEh1O5cKnG4x?=
 =?us-ascii?Q?ZEpX+Popwocl3J4VY8A0IOXGNWDtehs+dYjS/SMj9XnDaQPSna3SPNdaYiKd?=
 =?us-ascii?Q?oYMluSs+3B93JDKLDAMsLwXxSR7Mcw2U5vH+iCFtQ4dUImvvgLDB/3bUOPhu?=
 =?us-ascii?Q?yRD3toc/yv1oOp/ujehZngERvoQxpJLxmTpneWzqHphoobpuF7mpNNsaxM5U?=
 =?us-ascii?Q?4mrycVZ2uwHvAGX7LOuVsByZanYrm29pEjzHSFBcOgbz6ImDXT9E0au4Jwxs?=
 =?us-ascii?Q?2FHU1978EtlHHe7CrOkvicTEbeBaOtFFh7G/jTq9Zk3WSQlvOeycihARySmp?=
 =?us-ascii?Q?f1Hajsz17Hf+QD4oX0AzX3vbF26bW0rbxxVjRrn2Qhnkq1ECKjTM6cCLTEwp?=
 =?us-ascii?Q?F2J8/keeBHOfSQwnvg+6Oz+wGM0SkyLBW+WxVSNsJzqLrqLclhTRXH9O3uB9?=
 =?us-ascii?Q?0BzHOc+AwEOBTPCj1z/M2m8EtSIj/yftOjFltwAAXCXisrDsUWQcJQJ5K7cV?=
 =?us-ascii?Q?rPhxjIkAyuBIsi1BjmIuN4+i3lkU+47RtIkLcnTfniNT+7pR6819Z+SOvGGU?=
 =?us-ascii?Q?D/jIfa3pxVW7GIiwMZxOn3GMHnOcrjVwLbwyL7v2W7cMuCXDjUluX2Zwwg3a?=
 =?us-ascii?Q?cUZSN8xiuwQXHLGGxN4bLT66oiLmt16RJSQEOtUDe1PsdYwAzS0JiaGbDYAe?=
 =?us-ascii?Q?ggAdLmErSreFZSt0JkjyZmoQdI6QMMO812luLoOOEHLdQTN5eI5aYMwBTfLq?=
 =?us-ascii?Q?OQhU4Qlc+dH2QdHm6cOWu+Ue3T/5RyZJu1zP0AQvdsQGEmHWh+rgr0ttoBGL?=
 =?us-ascii?Q?ig/f5djRxdDn6QRlWX0MT13TruedtupzXYM4Uv7MSkXt3RCVLkRjoffkEE6t?=
 =?us-ascii?Q?SBXQ6bIip62jWktvtFxO2X3GHeF1Pu5e/S4PHi8G15vmdUhI72vlGhaYBV4z?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	niBQPYW4oufnj3Q91xXdIwh05Y/2xajN227GvD1SJFg3LmXPYhC3EThktOuywz9gB0hbK5ImgCRDiiJaJCRi0g1NeAdH2uIXIfzljKNuCAJS3lMagRGIhsMvdvT8lZw1qWPLrQ3NQv0G0Y4BnjxUQ6hSUNmyzrNYlmX7/aFz2bVPZ6mr5F9Vtofv9iNnA1B4Zrzmm8DYEVwdfMoTjxmWVRBUERr6hqzEWeTSWXSaYK9rAtoENuws7L0Fz6XFosuOYKrRgqAfqmy6ZUY81HpHTaR9WY+DddL5jgRSeI+vLGzZiblNm0kU03K7iJs6XktEv28fQd4mYczjXwTwYGYdu7HdX/UIZvtYQ+M6VardeTKI/Nv3bORS3+XXFrX00jz6yuP9RXVfI/YOSOh080PvC02dv0aEpnV159MiSzeMfxAkxjRWoHPpjOi2gu+JvvsO0UFybPhtawl6Rqw72Krx5DNwxkipDlTfHUzfGZRWFAZAAMmEYoBziW8mSzg+KeSGHFEJYokUvChpUjKpCfw6S8UNPmI+JjyYlS9sTwqzCjmN2dUiIY7hx9xueGBNaGBL02/eLP3PSHCOhdZJZNBYPPdvqKBpEvZB+5LihZCqBeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d15efe-f9d7-4500-55b0-08dddf56622e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:27:06.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LCcKaZz8dTZAusBz1yDn5fVZcAPgIUtN+fLvDorANymdm5tUZKYvY8F8+fKdbJxLsfhi2A9eoKRj/mwlQnu3qbJI1u+hP3u4gWq9hXDcXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508190179
X-Proofpoint-GUID: 5FLy7PLdFsAzTAxlWh0GtBaR9u3v87Oo
X-Proofpoint-ORIG-GUID: 5FLy7PLdFsAzTAxlWh0GtBaR9u3v87Oo
X-Authority-Analysis: v=2.4 cv=G4wcE8k5 c=1 sm=1 tr=0 ts=68a4d00e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QYIonxR6D-brHg85P_0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE4MCBTYWx0ZWRfX1l/ZP50IVIqx
 nXwdbTIksQLog44SEpv9Xs9hU7S+Aq34nLW12M8L+AAwxf9MbyNmIB4eoDv3VV476XnzCIApRUo
 34k/52iiTlO3khhjs5KcGuBnuetqvMy5AUYvn3at+AsPccaZIp9gwqgHlgxOotlJhpK7Ojux/tx
 HvY72YNjIgDWCD0PZFL1/xsrDvv9jf7v7vlNN1ZvCPmfLoTWq3VQ39VO2UGQRrM6T34Gmklh8aO
 i3MEFF8g0aQWBJDSYC+wyB1qnqKDblXOkKzNeMi05vWQuakmE2YyTiNDTgyWWDbQq74jEz5ALjj
 655LmqUCRNOyjUrrhVfTP2PamlFK48BWqBtj7rO3WW0UJgEMAyy8TA/68RsCk+QvMJDWP4Rw8qJ
 rBti1Zk4a6lkFHvDowCp6JyEz6PuQyTc9T1KYwiF8pym7IeAm5SuG/8f510PN1NA5KrQlHrJ

On Fri, Aug 15, 2025 at 03:10:30PM -0400, Liam R. Howlett wrote:
> The unmap_region() calls need to pass through the page table limit for a
> future patch.
>
> No functional changes intended.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

This functionally LGTM, but see comment below... about a comment :P

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/vma.c | 5 +++--
>  mm/vma.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index aa75ca8618609..39f3b55a020b2 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -474,7 +474,7 @@ void remove_vma(struct vm_area_struct *vma)
>   * Called with the mm semaphore held.
>   */
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> -		unsigned long vma_min, unsigned long vma_max,
> +		unsigned long vma_min, unsigned long vma_max, unsigned long pg_max,
>  		struct vm_area_struct *prev, struct vm_area_struct *next)

See previous comments about refactoring unmap_region(), also let's have a
comment explaining what's going on with these parameters too.

>  {
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -487,7 +487,7 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>  	mas_set(mas, vma->vm_end);
>  	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
>  		      next ? next->vm_start : USER_PGTABLES_CEILING,
> -		      next ? next->vm_start : USER_PGTABLES_CEILING,
> +		      pg_max,
>  		      /* mm_wr_locked = */ true);
>  	tlb_finish_mmu(&tlb);
>  }
> @@ -2420,6 +2420,7 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>  		vma_iter_set(vmi, vma->vm_end);
>  		/* Undo any partial mapping done by a device driver. */
>  		unmap_region(&vmi->mas, vma, vma->vm_start, vma->vm_end,
> +			     map->next ? map->next->vm_start : USER_PGTABLES_CEILING,
>  			     map->prev, map->next);
>
>  		return error;
> diff --git a/mm/vma.h b/mm/vma.h
> index 336dae295853e..ba203c0c1d89d 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -281,7 +281,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  void remove_vma(struct vm_area_struct *vma);
>
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> -		unsigned long min, unsigned long max,
> +		unsigned long min, unsigned long max, unsigned long pg_max,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
>
>  /* We are about to modify the VMA's flags. */
> --
> 2.47.2
>

