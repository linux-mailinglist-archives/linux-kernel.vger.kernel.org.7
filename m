Return-Path: <linux-kernel+bounces-811780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E60CB52DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBD1174F84
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC2F2EAB7D;
	Thu, 11 Sep 2025 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U5MCWol3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gN1iiLH+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668612E9EDF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584450; cv=fail; b=QDSTZqfi5WZWD768MhfPQLaiu9bnGYNanYTL1e/iPVF4SrAGEDQrOdNipXl0Poh1vqM4m9IsaxIGWWvmv5bybwxBZEYwUgD+vM880E3SO6KsPJPEWNT7rXL4mkhjQXlTz4KcXnMNJNCsTLWZn/d+KHlg4WF4MUfCHwnP76c/7NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584450; c=relaxed/simple;
	bh=gw/g5UuAVGrLE2BMcplNSy5ISVjIWwWkIc8kc15Bnhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BdOLDkc+1N3yVMnQNDKS/FfkDSH6Gh4e16bASsWusKJlpzGU9kTTWXfmUeKFXSXMPweGcHjatqiiLIX202dqguglfsCoDp+/F91GQZ/rCZ8Nt6LJi0oGt+Gn1BqKh2BLFOUIc5ISuQJMokUWk75De4pTF6tn67pK9gPZSyw0VN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U5MCWol3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gN1iiLH+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B8fxVv021315;
	Thu, 11 Sep 2025 09:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Og9FVYRbCVjxc91/Ho
	9/VfbMPPQ7H6qwbQMsN9JfE/Q=; b=U5MCWol3SiMr9a3rNuOJLDLEjvbkoRFq0H
	bzfCjt8LNZktUwzcUHwna2xz56kI4rid9XfxkUOJaB5b6XwUNaOwILVLPO3MCPwn
	wCCXa34t1u10gPadPcY5aLC42oWxiuZVz8Ppyl6aKWjZ3wzWiNmAPpp+xLfkXu8a
	S8PMopJzTUs9okCGcMVmdHjy4P484osCHYcs9Fh5NPjCJGnGgcp40rf09JDyVb5B
	3VWkllz8YWu6TpxUM/v8O3jPpPEPHjMcr/9uppd/FAZMGOu3Dx0ay5ZDS9IvjK2W
	OYg4deha2vWFNt7Mf30mEdfr1JQk/j9+5tGliUQNEe+GuRqG4zVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1p2qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 09:53:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B90qp5038722;
	Thu, 11 Sep 2025 09:53:25 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdc82ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 09:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftn767XaWTJ1YYttfPwyJrAOJBKwx/kSO1WuuUS5WrdgpiCcb9ARGPTLZ1SeQt22SnZX87AEws+tBMgyOySnqhB3JJu9g4ROwnYj960tw/QUSlSuk2kB/avo+mqWiUKUvYSWi86Rx7G0GE7dGe/kBI/TqeK5J0nTspiWrpr+H/5KtVdnv8X60dGfJjNxE2tOLGCP9u8DEg49a5hkPVXwQjRIKqXS1Nu8N4aRV5KWbkZhldgi51owlNXi2mWprIUe8X4jHhS0G1PhDyMfmuyzz/vrT1uan6eWEdqXiMzhUMThVx9vAIWrdjrjrndZinfWyLXhDWlfJhVgwTtmltArKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og9FVYRbCVjxc91/Ho9/VfbMPPQ7H6qwbQMsN9JfE/Q=;
 b=X9ROcNED+2DNFVt8bsoP2SrPZ0kym1cpwC0VAD0wosxUMDS4BqXhP4Hin6LFVI55A410fRxvuVxfloVV1w1Dgxk6xrgdrgCWSfHOR73TMt5ZjCLnUDtkDtuwMNYQs+bD/ZrVqofynG0kVWSDo1MfdfCQBRAp5ZpMVnbHdbpPSLeuGVacwqWNI1R3mf/UvvpBolP4GGKhgKd5Lre6neUVm38X55nBzmWPyKtzazobuThpMfyf3N5LsCpSXX952Qlf6IaMkizO9dzpnvH0AGO5Wwp/pxp+hJ8ncGioFEOCHEGNdpYl/6aArguXXDXhzLcO6prAEycQe4vNPGJn+02f4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Og9FVYRbCVjxc91/Ho9/VfbMPPQ7H6qwbQMsN9JfE/Q=;
 b=gN1iiLH+/6tCMTQ9Apsxw0aYhVlyWX9ZXEptOL9RnVzxs9BYeBDIVvi0JqoCQegKe+LUFx48oK2STt577ZEXa2EVPNn4q92aVQb1mxwe/GunOWFQUFOoCc+7i/owZt32Rj3fz0W6p9cmiDOpbVF64u7QEx4rkPVKc7IkHdWOmN8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6088.namprd10.prod.outlook.com (2603:10b6:8:8a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 09:53:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 09:53:16 +0000
Date: Thu, 11 Sep 2025 10:53:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1 8/9] mm/vma: Use unmap_desc in vms_clear_ptes() and
 exit_mmap()
Message-ID: <35d63781-ea17-4472-87ec-541b6c8e0ecf@lucifer.local>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-9-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190945.1030905-9-Liam.Howlett@oracle.com>
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 4682a15a-29af-4f83-d005-08ddf1190789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zLkLSYCIgo6pcnXnm3fMIjXfe8W74BpTFVfSKwDOIALCkcyytBBbMCIyFoWg?=
 =?us-ascii?Q?PsGmprayBGyKOgUA/QatoR+eb9cjUpRcd1s+fAwC394uegJzc77lxdHBQudG?=
 =?us-ascii?Q?nNIesZJpikspGNT9mRDLRzq6raQBDSWAUJJHkvyQOzZ/nYWvmEAz9V6zyDo7?=
 =?us-ascii?Q?TestUTv28T6zUrwht33iVTTPVL1HRvSjkOr0tkZ6sQn/1/YHU2hvAniYSMer?=
 =?us-ascii?Q?deZ8gWsowL2D2Nwgx6jM9fDg5vrfwpfdVAbGv9wCNBvXJp0hvb+7iZDTy+LJ?=
 =?us-ascii?Q?XifKtLIz6EMaVcI38lE2zm5OZixLUZCIdWKJjpaOIavtoAn19CZBh+pwK9lL?=
 =?us-ascii?Q?+O1oQfqonAZEO/F1EHHI0AnjCIH9Ych+EVIBDt/Lnzv4E8iMGfYzmZ3cn4Up?=
 =?us-ascii?Q?tJtGSk7oB0/4SanVjGW9FZUX7LI/jULg16lje0nz4A+IeWtjW+AGUIPKobh1?=
 =?us-ascii?Q?1FzYwMD4xE8sUp1cqpn0oGMVRIDNmEpx2T38jsEIcN5alYR7/XUUTeVC/wcW?=
 =?us-ascii?Q?SYybwaUraPezrWclsVyV/nMwcPAKWxya2TFjunlLBRuwlk9lO61gi0Kb4SsQ?=
 =?us-ascii?Q?pPj1lqQcvua4p3SOpD3i+ltx8mZaZdkEhXhk+dBcqvzG86XuroKq2Qtn/FX7?=
 =?us-ascii?Q?tI7YEwNyRazqxz5A52eWhiddgFrC+pmyQmconPVZLcEbh6NnYLmAvwlv3HSI?=
 =?us-ascii?Q?73k9RT6hKj4BsRN3HREUzgsa/xM/qxXAZd46NjQ7NZae/wDlKdBNoHoeptQe?=
 =?us-ascii?Q?76zZ7mhw+Hot0X8Rc+E0a9lbbiNyi8jkrUJySb6pEFd6daaxMxdHl5lvTj4k?=
 =?us-ascii?Q?tWGTAMmgRXfhR85mDfBltsnpZxdGhW+pCQy+Nlc+faRLZCon6eCCOn/uzZA9?=
 =?us-ascii?Q?e6CvCExShiWpFOECJ1DZB+HceKzIWH/P2ZtNCfVQht6ICF+87JKLIOdPcOMU?=
 =?us-ascii?Q?Rn4kwBgviO8E7mxvmsrpZU8prS2qXtEYp1BcULSOO2GLBt4fGeopUCTTnu4n?=
 =?us-ascii?Q?wbS64Ic6WOHrVnGiTnhArKW0ddadgAj7gzKUtWg5yxKFtzNKnsmGogCiQIp3?=
 =?us-ascii?Q?wxP8wZ1rFWSUtJKBKUoXpSK5p2zeF7Qac9C51qtDMF2gHHnyDf4P4tkOgZIW?=
 =?us-ascii?Q?ffYJiE4NwSaKKtGWbtstGpTZmghn0HmxkIcyBCrr0GjdfqDwouFRbWgZUf0t?=
 =?us-ascii?Q?xG/rdeGd4s3xTK4MN9kotIXp+4z0Nr1AFSDmMTTUK5pDXouUslGXKWvEy+wn?=
 =?us-ascii?Q?YapGDjIq/1uWvYV5da5cZeCPz5Wb+L1Z8Xu25W58W/UEi1eTaIZNxcgOw5Rc?=
 =?us-ascii?Q?1xXqKu3cpddilbR5nFx0r0rZS8cBrPUwoQwW5AlqWvOfOKUCnPYNjbcKpIJV?=
 =?us-ascii?Q?AtpuwMVtdoySK1KsiLvz6tXvkPXt4cTMB0d+a9jixCw1dqVqJgnzCOur47m2?=
 =?us-ascii?Q?7hLBrVZ9SgY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37OBi8lExgFygf8ChEzDQwoGlBaOhQI54TNAPT/mchJEK3h/SuLNfVoArgtU?=
 =?us-ascii?Q?GrDOloYESFvBwoQ/bYL27CbDQSee1kSFVKQDM7KPuK1SD7vynoyaAXEuF3v3?=
 =?us-ascii?Q?kpLm4R8n1bK7v95s5TSvCEODEe2QjUFwdOz3AROI+usUU1J2ZEKaS9cX09GY?=
 =?us-ascii?Q?iMgSonmsZRW2WrXCxILv/vZArC8yerEzybXwHOehxzxI/17Y8ZjCPVIRucTc?=
 =?us-ascii?Q?DUF12HjnHqWbiKjncVK7/cGTq7XjedoDJHtTsiR9ov7+I+nQYStiwNLCry21?=
 =?us-ascii?Q?+bWYh9lxBuRtN1ZUhlBBZBYOYK7tp818hLWAllOxgIZvr9e9mwglPp+w149e?=
 =?us-ascii?Q?EjEx2x8IthYU0/ZJsNZ/WIPzOOytXHhVzc/nxSG7GsXuBSSoUx5oSoCNW3rc?=
 =?us-ascii?Q?fUui9X08u12NUrOfhJg99ThUFKJ4wjYNbyh6jtXrDdrKcUSSprQAZaocizhT?=
 =?us-ascii?Q?q6mRoHAuxSwTFX43y86wJcHaHM6Jc53MW3VB/660FTAY9hqw5m275E+MKTWB?=
 =?us-ascii?Q?rZRJS5WYDlPcF3dOV0mW+0FGiScMdm4GIg3WRHrNlF8TBIp5DFHgsnoRm9yp?=
 =?us-ascii?Q?9YHYLsKL66m3oY5EnNr6p70hOKgS1re0otxX/+0CA2cxTksOK8N7tMo+xWgs?=
 =?us-ascii?Q?+/n+N83+Mop9XNCt4Xpbg2+1lr+UTJ0F7fwz31U2QA3RvMNwcsrkFdsk2F0N?=
 =?us-ascii?Q?HmS+Xam2dG2EQbuRi9Km72RmEPNp8P7sZNaq2GVigCUYnri1GZ/VnjVdglbP?=
 =?us-ascii?Q?8pUmXLyPejqpHUYaSSOOSF5hlgeklqKLPBKMSUWjz2rY2scB2ZRGYG+Soq6U?=
 =?us-ascii?Q?2uqxJPB3v2pP3P1YRsJ5x4AU//5eruYZDJprEkpnVcLX5SbHYYmt+fHkMNYk?=
 =?us-ascii?Q?TnVIQRI3oH4YabzeRPQ6Xgslr2cHujsib0xhIobh8MSomvzNOF6ugobjFjX2?=
 =?us-ascii?Q?Zl26vP55TlW574TTMrRxZQc6mMhR8Rdw1h2YGc5pAya1VDEI6AOWoHc2qh+q?=
 =?us-ascii?Q?UB2W2gBqUFqYBXKhfieLnuhomj8nM0qZ5jatTZxBlyCR3fwQxq3rFm5nt5ij?=
 =?us-ascii?Q?9GWu/+9K/JU411MzJYaLvURW0zq4c+6wjmO1DslXC0fFPbzwzA48JDk72vRA?=
 =?us-ascii?Q?4uSELB6728nK08bfApAH1y9cLgxsrPdEKNO+me3g3tzzyR1SsJoG0Kc/TpOL?=
 =?us-ascii?Q?qd9oRQSahkrAgWfbJ7ubBfTkOcqgpgq4PafPeyvHHQUrrAnCa+AMSp2ka/XH?=
 =?us-ascii?Q?bs6jvWQOTF9mnLBmxS99ibCs+SVEB66SOLxpirbdySWhT2g2b/nF51LuGTGg?=
 =?us-ascii?Q?O1efdXckteHeIE1jMZ/95Csfd5U8V0UopZKzdgtduopWVUCi6LOnzsRMbs5r?=
 =?us-ascii?Q?kknRB6WrYBG9Z58PY59J1sBkwJco1zkQ+OpDQ2eqlfScyX9iQE4f+I1myKCk?=
 =?us-ascii?Q?qZ/5c30W5+P97t14clQCRAgFOm8dnnXiUVruA/OmOsQ3OyNtQXxPMhrYAYZB?=
 =?us-ascii?Q?P206Vd9L5zxSKpXAAFLJ8qA5BBzfn7dZGkIp9NeT+buJjnR86YV9a1c+247N?=
 =?us-ascii?Q?QIHNeCoH+W5tNqzh9X+LuAetLEWRQ1dZGrqR4qm80yNhIW+43bCrZb3mQRXz?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IXyxyUX576MD83j+EHKsyEzoThe3JE+LsAdqs83p6yi4zigGhWLxPq/8YQ5O0ji04xYABHwQ/3e1G5DArEkDXaCrdZodvUQMj2MIWnlJTRtbNwuSnv9Hk2QtVGtBZg9nuePQMHrMJeLK6tQSdxrB5y/qGEF4sxHgqxrDONwXynM7GcVSAwOyWSXka1KR//fE7BuMKTZGystAzlqA0ZnOeAb1jKexOflhPr16A+nw+QbBCsKFxWAXAEDzEN2LQv4sId2e4jH3tOofi8zHrGtiGnntoL0b9sWowicjp6GOgYqho8JM7zCfoDb6zmgVNs0EmndmH/ZOFATnbcEGa784JJsmBwAL2+XiAvn5zf0FTZ0LpQk3zJQb0oaB8q339APgE2sr0iBRfOUTUUtft6x3KiyXMw460PEj95RbMfUbQFzPVP25aXJ2XkfM6AEghjAuc0UFVjeS2aRPSkguQF3HEVXPNtadcMNyPwGu0kxOHRs+6sj+3YgHpHDXce7hMZF77PL5rJn7zB08eu0XtaP9jbv6ZyNgpYCMumW1XfU3oymeIerTV0DFja9K22HxjgoskOj7b6VO1WDgglQdeSDHAYHVd+/k6EC+iSddI+heYy8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4682a15a-29af-4f83-d005-08ddf1190789
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:53:16.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLljyPX+Fg7/KS2zfmNtffwJ5h39hr9jKPptWI7tzgfg1AUCbog4OzqM8rcgA1hjBXeZGhmVuGoqU8X8pYmsfZh1AbWxD0aXKxf/lYKZ3mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110089
X-Proofpoint-ORIG-GUID: 8pfXK5gtKwk56bX51Iww1FztIi9naYcr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX0KB3zbdaOEZS
 dJLe9JZF6GKf00HH7UEIQUzs+gW2bsGWI0j0sOUG9ojWjZz+G5w7SZJjABSaYmIU4lyOZAOlnPL
 q+oYjHdHzsRzOpQRqPldSkYZazmgNJZpH0fD1hLBQcFi1PSbGnlydMf1XsCfyDqLPlAQCapTyMN
 9ZGAmOvbCtWvtkvNkvFoGlqrytkhPHWSXnr2EFtYIaqjspTRjknugfFwdzSJPfcnU4m3EwLVrm+
 2yTgwBCPAs/Qj+bCjqlfjQTgWTgeB4eH4OfQM5ck+jW6JmSex1HEdYYEbTw+HiPJCXckPYiChBH
 RRf51L4i/xO5E1DcnRE86L20S4GEeD9wqwb0tQMlnX2VIjgeBU40VZ9XDu911OlrsfrVA6F9e5K
 t0Mm2ao+DDWXW9dOg/P5KIlwqKDIbg==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c29c17 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=K_yn9lloRhQFGIEGm1YA:9
 a=UyJwmPUJozw58VCsoXQsA4RukbM=:19 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: 8pfXK5gtKwk56bX51Iww1FztIi9naYcr

On Tue, Sep 09, 2025 at 03:09:44PM -0400, Liam R. Howlett wrote:
> vms_clear_ptes() is slightly different than other callers to
> unmap_region() and so had the unmapping open-coded.  Using the new
> structure it is now possible to special-case the struct setup instead of
> having the open-coded function.
>
> exit_mmap() also calls unmap_vmas() with many arguemnts.  Using the
> unmap_all_init() function to set the unmap descriptor for all vmas makes
> this a bit easier to read.
>
> Update to the vma test code is necessary to ensure testing continues to
> function.
>
> No functional changes intended.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  include/linux/mm.h               |  3 ---
>  mm/internal.h                    |  3 +++
>  mm/memory.c                      | 24 ++++++++------------
>  mm/mmap.c                        |  5 +++-
>  mm/vma.c                         | 39 ++++++++++++++++++--------------
>  mm/vma.h                         | 14 ++++++++++++
>  tools/testing/vma/vma_internal.h | 14 ++++--------
>  7 files changed, 56 insertions(+), 46 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 892fe5dbf9de0..23eb59d543390 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2450,9 +2450,6 @@ static inline void zap_vma_pages(struct vm_area_struct *vma)
>  	zap_page_range_single(vma, vma->vm_start,
>  			      vma->vm_end - vma->vm_start, NULL);
>  }
> -void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> -		struct vm_area_struct *start_vma, unsigned long start,
> -		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
>
>  struct mmu_notifier_range;
>
> diff --git a/mm/internal.h b/mm/internal.h
> index d295252407fee..1239944f2830a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -197,6 +197,9 @@ static inline void vma_close(struct vm_area_struct *vma)
>  	}
>  }
>
> +/* unmap_vmas is in mm/memory.c */
> +void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap);
> +
>  #ifdef CONFIG_MMU
>
>  /* Flags for folio_pte_batch(). */
> diff --git a/mm/memory.c b/mm/memory.c
> index 829cd94950182..8d4d976311037 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2084,12 +2084,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  /**
>   * unmap_vmas - unmap a range of memory covered by a list of vma's
>   * @tlb: address of the caller's struct mmu_gather
> - * @mas: the maple state
> - * @vma: the starting vma
> - * @start_addr: virtual address at which to start unmapping
> - * @end_addr: virtual address at which to end unmapping
> - * @tree_end: The maximum index to check
> - * @mm_wr_locked: lock flag
> + * @unmap: The unmap_desc
>   *
>   * Unmap all pages in the vma list.
>   *
> @@ -2102,11 +2097,9 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>   * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
>   * drops the lock and schedules.
>   */
> -void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> -		struct vm_area_struct *vma, unsigned long start_addr,
> -		unsigned long end_addr, unsigned long tree_end,
> -		bool mm_wr_locked)
> +void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
>  {
> +	struct vm_area_struct *vma;
>  	struct mmu_notifier_range range;
>  	struct zap_details details = {
>  		.zap_flags = ZAP_FLAG_DROP_MARKER | ZAP_FLAG_UNMAP,
> @@ -2114,17 +2107,18 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>  		.even_cows = true,
>  	};
>
> +	vma = unmap->first;
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
> -				start_addr, end_addr);
> +				unmap->vma_min, unmap->vma_max);
>  	mmu_notifier_invalidate_range_start(&range);
>  	do {
> -		unsigned long start = start_addr;
> -		unsigned long end = end_addr;
> +		unsigned long start = unmap->vma_min;
> +		unsigned long end = unmap->vma_max;
>  		hugetlb_zap_begin(vma, &start, &end);
>  		unmap_single_vma(tlb, vma, start, end, &details,
> -				 mm_wr_locked);
> +				 unmap->mm_wr_locked);
>  		hugetlb_zap_end(vma, &details);
> -		vma = mas_find(mas, tree_end - 1);
> +		vma = mas_find(unmap->mas, unmap->tree_max - 1);

An aside, but do kinda see David's point about min, max & start, end & floor
ceililng, perhaps the prefix_ is enough to differentiate these and we could be
as consistent as we can be?

>  	} while (vma);
>  	mmu_notifier_invalidate_range_end(&range);
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5c9bd3f20e53f..6011f62b0a294 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1280,10 +1280,12 @@ void exit_mmap(struct mm_struct *mm)
>  	struct vm_area_struct *vma;
>  	unsigned long nr_accounted = 0;
>  	VMA_ITERATOR(vmi, mm, 0);
> +	struct unmap_desc unmap;

Perhaps :

	struct unmap_desc unnmap = {
		.mm_wr_locked = false,
	};

To be clear? I mean it does mean we're initialising some fields twice
though... but at least avoids uninitialised state if we add new fields.

However I see you're already seeing mm_wr_locked to false in
unmap_all_init() anyway?

Ideally we'd have something like UNMAP_STATE_VMA() here, but ofc you don't
have the VMA yet.

So probably something like what you've done here is the way to go, but I'd
rather we initialise this var in case of adding fields later.

Then again... you would have to make sure the _init() function set all
fields anyway so maybe not necessary. Hmm.

>
>  	/* mm's last user has gone, and its about to be pulled down */
>  	mmu_notifier_release(mm);
>
> +	unmap.mm_wr_locked = false;
>  	mmap_read_lock(mm);
>  	arch_exit_mmap(mm);
>
> @@ -1295,11 +1297,12 @@ void exit_mmap(struct mm_struct *mm)
>  		goto destroy;
>  	}
>
> +	unmap_all_init(&unmap, &vmi, vma);
>  	flush_cache_mm(mm);
>  	tlb_gather_mmu_fullmm(&tlb, mm);
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>  	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
> -	unmap_vmas(&tlb, &vmi.mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
> +	unmap_vmas(&tlb, &unmap);
>  	mmap_read_unlock(mm);
>
>  	/*
> diff --git a/mm/vma.c b/mm/vma.c
> index c92384975cbb2..ad64cd9795ef3 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -481,8 +481,7 @@ void unmap_region(struct unmap_desc *desc)
>
>  	tlb_gather_mmu(&tlb, mm);
>  	update_hiwater_rss(mm);
> -	unmap_vmas(&tlb, mas, desc->first, desc->vma_min, desc->vma_max,
> -		   desc->vma_max, desc->mm_wr_locked);
> +	unmap_vmas(&tlb, desc);

Nit, perhaps didn't notice on previous commit actually, but you're being
inconsistent between naming this 'desc' and 'unmap'. Let's choose one and
stick with it.

>  	mas_set(mas, desc->tree_reset);
>  	free_pgtables(&tlb, mas, desc->first, desc->first_pgaddr,
>  		      desc->last_pgaddr, desc->tree_max,
> @@ -1213,26 +1212,32 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
>  		    struct ma_state *mas_detach, bool mm_wr_locked)
>  {
> -	struct mmu_gather tlb;
> +	struct unmap_desc unmap = {
> +		.mas = mas_detach,
> +		.first = vms->vma,
> +		/* start and end may be different if there is no prev or next vma. */
> +		.first_pgaddr = vms->unmap_start,
> +		.last_pgaddr = vms->unmap_end,
> +		.vma_min = vms->start,
> +		.vma_max = vms->end,
> +		/*
> +		 * The tree limits and reset differ from the normal case since it's a
> +		 * side-tree
> +		 */
> +		.tree_reset = 1,
> +		.tree_max = vms->vma_count,
> +		/*
> +		 * We can free page tables without write-locking mmap_lock because VMAs
> +		 * were isolated before we downgraded mmap_lock.
> +		 */
> +		.mm_wr_locked = mm_wr_locked,

These comments are great thanks! :)

> +	};
>
>  	if (!vms->clear_ptes) /* Nothing to do */
>  		return;
>
> -	/*
> -	 * We can free page tables without write-locking mmap_lock because VMAs
> -	 * were isolated before we downgraded mmap_lock.
> -	 */
>  	mas_set(mas_detach, 1);
> -	tlb_gather_mmu(&tlb, vms->vma->vm_mm);
> -	update_hiwater_rss(vms->vma->vm_mm);
> -	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
> -		   vms->vma_count, mm_wr_locked);
> -
> -	mas_set(mas_detach, 1);
> -	/* start and end may be different if there is no prev or next vma. */
> -	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
> -		      vms->unmap_end, vms->unmap_end, mm_wr_locked);
> -	tlb_finish_mmu(&tlb);
> +	unmap_region(&unmap);

HMmm why are we removing all these? I'm guessing this is a separate
refactoring, could we perhaps break this out, as it doesn't seem to quite
belong in this patch?

I mean this is really nice :) just I think belongs in another patch, unless
you feel it's really tied to this one/necessary here?

Sorry to be a pain... :)

>  	vms->clear_ptes = false;
>  }
>
> diff --git a/mm/vma.h b/mm/vma.h
> index 4edd5d26ffcfc..8b55a0c73d097 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -164,6 +164,20 @@ struct unmap_desc {
>  	bool mm_wr_locked;            /* If the mmap write lock is held */
>  };
>
> +static inline void unmap_all_init(struct unmap_desc *desc,
> +		struct vma_iterator *vmi, struct vm_area_struct *vma)
> +{
> +	desc->mas = &vmi->mas;
> +	desc->first = vma;
> +	desc->first_pgaddr = FIRST_USER_ADDRESS;
> +	desc->last_pgaddr = USER_PGTABLES_CEILING;
> +	desc->vma_min = 0;
> +	desc->vma_max = ULONG_MAX;
> +	desc->tree_max = ULONG_MAX;
> +	desc->tree_reset = vma->vm_end;
> +	desc->mm_wr_locked = false;
> +}
> +
>  #define UNMAP_REGION(name, _vmi, _vma, _vma_min, _vma_max, _prev, _next)      \
>  	struct unmap_desc name = {                                          \
>  		.mas = &(_vmi)->mas,                                          \
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 823d379e1fac2..d73ad4747d40a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -884,18 +884,12 @@ static inline void update_hiwater_vm(struct mm_struct *)
>  {
>  }
>
> -static inline void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> -		      struct vm_area_struct *vma, unsigned long start_addr,
> -		      unsigned long end_addr, unsigned long tree_end,
> -		      bool mm_wr_locked)
> +struct unmap_desc;
> +
> +static inline void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
>  {
>  	(void)tlb;
> -	(void)mas;
> -	(void)vma;
> -	(void)start_addr;
> -	(void)end_addr;
> -	(void)tree_end;
> -	(void)mm_wr_locked;
> +	(void)unmap;
>  }

Hmm why is this still here, I thought I'd removed all these (void)'s... I think
actually that's what's in Vlasta's tree, so this will conflict unfortunately.

Anwyay, please just remove all these (void)'s, they're unnecessary.

(Also I'm sorry for making updating this file a thing, but I'm not sure there's
a better way)

>
>  static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
> --
> 2.47.2
>

