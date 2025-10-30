Return-Path: <linux-kernel+bounces-879135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559FC22597
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EA5534E8C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F235335543;
	Thu, 30 Oct 2025 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NSnRIZ/+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UgSJONBH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0C332EBF
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857587; cv=fail; b=UV7EQ/iK2s5KPxTYgbLSp79Wl6FG4o3Db00j03jbM3J6PaVeyeN9+AxWy9NTjLaz08NCR6Sv9buIAekfozAwbPPUGWIYui1nYY5hgrhYu8cpT0Z4hRf5xyISMN12k00rUlh+GQXlKvMxklzKjYspUHUFD8btl65EF/GFB884XxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857587; c=relaxed/simple;
	bh=e0HWwJSZvxWYIvyo+XfpsObyONqL5AMSaAYLjFgU79s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WgbCCp+/zEWMkVTLlrW0sOr2N+83yx3g3BTHpOW4JhbEUVxwEc/ChMFKoyS3l+paXo11198yjz4mJUEyk26bKSKtyYncrk6dP576it8ZUUtJNknCTz0m2AD2u+guv+OFrRMF6YJr6youkKS800VzOrQrgimAC8d68kchpDaGPNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NSnRIZ/+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UgSJONBH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UKV2N9014760;
	Thu, 30 Oct 2025 20:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Ewum2Y1SQFSDluivDv
	/mkKlV7/Jy6F8aCxMBN3/F03M=; b=NSnRIZ/+KdS3FaI0Sw/9on0AfwNkxKd/lU
	YJEqQGCdfJqj+soRCq96JqdAPc04iWevaEZGmAqXOMR4t3AiFl0V698UTz+8X2zA
	LW39eF+gkQYSyU4nylVqMXjhzQYl4487FZnRfQl0p2VOTGfsOFEc6O26kqtYTK3z
	wiUDDtPkbXdhtYx9imC4Pm23UbBUlSEUsycetj7FRSOQKOzzzekWa1/9+zyFX9SX
	7xEmsUl0n40r8llsgJ4nPuBKPUMuGEGfuq3XimRjdj8E775sqw0rPQEQ67YQLLHt
	yIoum/J342g/5qFHXSuqcA/cPqTJY1N0W0VCnqbRHe9tibYNnKYg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4dsfr82m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 20:52:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UKCO6Y023360;
	Thu, 30 Oct 2025 20:52:37 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33w06248-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 20:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZ5QITMj9vdmSvw4SKRTuCF7cjIaatdTrlum/+tWx8dBlBK7vuirbbci1S1cLPEDABtF15dG1bOoWkDSEpCCjMWzjLaQsEtLLq53hWY8U91esQ6+CXE3wrOako2KdUcZYDSTL0/T493eGES1rOgqVuWqxqo+7Qa++sRw9FLKLTT0Ab6t103z9FvO8en9aI4dbsmBaAHy3kFDAgnGF8sIPtalwxrOIRo+E8ggl3F7LYVVj7ew8+0MdMr3Jl9kfOi13sDXqsXFBz1hBDmXVlmpQHfJ0k5srgzEtMyztYr6wKBPgl9L/e/Fxs2X6TEZoPxbQ1Vfqq7GBr5kbldnvimFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ewum2Y1SQFSDluivDv/mkKlV7/Jy6F8aCxMBN3/F03M=;
 b=nkAvPlZdfQ8CDN6k8v/1bhnyyb1U8VlVxg1cDj2DN5DzV11QsihYLPkohb/5uEXiDQCxSzDFyo8BV35UjL/O7X9KWeJtnnuk26hDfxoJfZc9EOFv3plQXvkyBhjFLcP5arOOFbzLKcEC5Gy2iRlakHfxywhOx4JZ4JuaFoIZdzAh/IGcg5+hKgKB7aBm3EYYfpvnuRrOmWGdmHf3p9qNOlg54lNzNITq3oqTC48OZQPhcGCzA9Wkm7Wr8sEmZttKMuthyxcZIg4LSQlYNZDSc7L/RkX+fP4FnSoI0Dxkcr2evkdPwCAvdhTIYz6aCsb/N/IC8jxZr61J6JS/Ivopmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ewum2Y1SQFSDluivDv/mkKlV7/Jy6F8aCxMBN3/F03M=;
 b=UgSJONBHP+X69vPs0ZTaZ6+GunRlnBBnE0a4QURRt8zmDh1w451xZkQm1dAmrtfgFjtHeQsSx3lKlvlBlzVg1bbC5KHNkswfQk1BIdp3dhDjHqikg4p2f6WbKdxJyQLqYpZv+2+wfbbVAKSsN82zrLXoDOoIxonB/2hWVx2IDdI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB7273.namprd10.prod.outlook.com (2603:10b6:208:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 20:52:31 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 20:52:31 +0000
Date: Thu, 30 Oct 2025 16:52:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nikita Kalyazin <kalyazin@amazon.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
        Ujwal Kundur <ujwal.kundur@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <bx3pshg4iwcgbzihgsoxmpubbsecgm5r2x37g3sfriloke7fk3@kbyponznh3sl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Axel Rasmussen <axelrasmussen@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, James Houghton <jthoughton@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ujwal Kundur <ujwal.kundur@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local>
 <aQPCwFZqNd_ZlZ0S@x1.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQPCwFZqNd_ZlZ0S@x1.local>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 074d4447-141d-4cc7-a999-08de17f63eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0dUxSEeY9TCIiSDEIDgTVUVnWUklcoVjQaeLJAjChEnnVxVA9o/0SrDLKl+T?=
 =?us-ascii?Q?DXX6M0ydZlCrlE0fNt1sJdv0Z8MXeWc00URgoiKvDzuDJh10gP3xKeou0hKK?=
 =?us-ascii?Q?470iEfpNIkB4uvWoFDiiIhfIr+6kYiqNp2T0W3nOvRLRtsmjKcp5S+eDnA3E?=
 =?us-ascii?Q?FN4SyxZ3PhTHaHR0Kkr/OiVkkkAqJ93Dy0ERBp+a7JbF6Vslvk3e4LDJ5gfw?=
 =?us-ascii?Q?/B8rHHY35KP7TjZ5K86tar/3ERUU/zPXgyvhGAh44nqNySb04hKRKSjr5USF?=
 =?us-ascii?Q?Tbm1A2c1AMCHnZBpHwrtGHEGmuIJnDC8yMn3sxbLKLIx4GXgwWgLD6FyqbNX?=
 =?us-ascii?Q?/5xXYNSKsu16uJ92PCb1U30yavU19byLF6oAN6IaCeiksGbC8+xaMrNU10z0?=
 =?us-ascii?Q?Bfy3YikvdNV7rkm93IlGq74gMffIdYsbmb/eCedI16Xu5gJRrWCGzj+O+6Jy?=
 =?us-ascii?Q?AlLmFfd69Ql/KUAFGmzkrvSr96gwvt+ZR7g3Xl/FMCMvvu635S74APo63Yb5?=
 =?us-ascii?Q?p+4O5SpBLl1nvgl/ns+o4Ky4mX5JPalxILP3ZpYndR7iC70n5Tisf0RXcw97?=
 =?us-ascii?Q?PAt4Ukm6oLDXAxwkExUqeDHEmhIuHDWIWJOefpVOANzkOyj1jXMbnoLzJziE?=
 =?us-ascii?Q?lJ42M5yrD7h5cqPxIlVFOwTpYMQt12gIPtnn8y2DQ0FVmAAGVasLDCZqTHTd?=
 =?us-ascii?Q?F5k5dUhbJNXaL0l/PwDcmb/v5Vidxr7B+cLihUhgK58gyx3qydotbhsObk2d?=
 =?us-ascii?Q?OgOdqmSgAbM1KpQj0j/dJNysrNhC6MMmQg9ELo4m1DS1F+7tMkMCnWKfLgQi?=
 =?us-ascii?Q?c09Ui0h6beMwJs/LmyRa5iWkJOHe7NeIevs9/MofIHXtyRHZcu7Z6Uq4+feH?=
 =?us-ascii?Q?jCNklVOEv7BwiiL+HhdVZbJeYXBEA2FK2lyUxFdfUY9Z/JUUtJYdRIv1Mggk?=
 =?us-ascii?Q?slIFGsol55cxjxI/T4pFgHawsRFQ5C3TTxtOw0qJKmKc3+M2Yoc6v23qZznQ?=
 =?us-ascii?Q?FD4xkuqpFgl703U1HBokfj3QcSEcJXtHpfwAphS+d6B1cCKzMLjz6CgvDOsE?=
 =?us-ascii?Q?ZNco+RsVAXgNujYSeTzdaUUni4UgpdPaMnsLeK0z/rpOEc69V1ARL5gasdZ5?=
 =?us-ascii?Q?HZHJTBdqJ4Qbb5N3t1LeV2YVzXy90oQYcmtN9Q/KYES3SVrR3LtfAPxX5h3T?=
 =?us-ascii?Q?00Ad3m2jaH8rpgiZ0KjYl0rBC1W+zshzAb07J09XC2wRHQC82+hpxB7wwX6s?=
 =?us-ascii?Q?iWnj3+EEUeMe1K0LWQXAKafI3A3sF8VlncSbxW0PqD9ZAOWo7nxbOkW7/YzD?=
 =?us-ascii?Q?ClTE8gIPHSc4DUFbZ6LuPYDwArrLh3PBgpqfCod0ZX8qbx2X8AZenlegt79H?=
 =?us-ascii?Q?nPDPV7jG4KUQI3UhDFu8giVz786ovZwJplTaDj47O8dba5vLlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/B4txKT7HXf/bFo+A7OAHalQ2xfhH65/gu1U2O0zI1n4evlbyEIoyVXSBIa?=
 =?us-ascii?Q?9RGLXBopQZc8UPTSCGlPUGrWUrOtXDghir2SmMSFLUSMKSvhv7qGT2glMRlE?=
 =?us-ascii?Q?HCG2c1cM3B1n1wsKpU0RjNAIFWl+GTArOGoTW69OQhHLdKUmEvM86K3wiRVA?=
 =?us-ascii?Q?nqh+TBxl/pjbQV+Fpuf848EkECGJ/k1JFob+vRiEgXyiHeoKkUmaZozBZtWP?=
 =?us-ascii?Q?G4Xhx2cA3orfiKZ1ULD8BGuw9GiLAgi7a+frmjY6jK6OM93HJD7y3E6B6HXC?=
 =?us-ascii?Q?m1NwoRU+r1/KByHWLRHOsGZGKEG9Anq9FBe7vjj4eu2bpmjLZ867OJgOHnND?=
 =?us-ascii?Q?aX2NIwcrzfzYP/xp8tdmteAg3eaAl96IeRwBv+Yg+x5PvnpoLPeEfCwIEnaA?=
 =?us-ascii?Q?0J2tht83xbBiykTv2MknCEhrz6cG0IMEYfcil4Q9CMALn2xLA6T17d2iAQ7u?=
 =?us-ascii?Q?H+yjN5vfND9UA1fwfvi5y7XodiibKqsCEluXlx0/pP/X+J68Uqm4zEuqRs0U?=
 =?us-ascii?Q?8K7qU/h7cQsMQZn6drK7K1JqQ5qkQ+rNnCcqfka7/lc7lfnDfzjeaLA2wZTL?=
 =?us-ascii?Q?SIlelRrcag7FRNh3cmRUFvSRouamDf5XWnWvRWNKOKhVsZhTanzbBXUiUcTY?=
 =?us-ascii?Q?Uao5F7YDSYsx/KP/PRbSP+SinxRS+kGlFTt9PEI9duX0bJnhKJO1Pig+X4Br?=
 =?us-ascii?Q?hhEtpy7PiiVBFPwAbywm432b8Ok+QEbNSdaHMBmYFRP+6ERl8MnXCruCNU7K?=
 =?us-ascii?Q?KYEivvCSFEzTkVxFhEb3U/VZA/exHgqzA2x1Glsd/U/80vkadh677eC8Fdr1?=
 =?us-ascii?Q?4ylvtWW3uva6KFyvkmGX648ScjH7xuSnmSzOqai4zJJg1WysWMN572v4msTk?=
 =?us-ascii?Q?zTRxkf1qNePvTlMvuPeTB1+H5/ON5UNPNL7P4bH1bM5bSuoIYIufpaOlKQCM?=
 =?us-ascii?Q?mXPSouuLPQ8ol40oHrDm0/Vr5ocW38XzhjXnHDQms6b91IwDEO2uMo02iuiF?=
 =?us-ascii?Q?S3RgLER40LWKkjhg6JMP2ycthN4nOL9kIWuRqn3ayZ4aur1f/VjVHAbzS551?=
 =?us-ascii?Q?ZBtUUnYuLiEbjYT6iqwmtuTxszkY887dEfM5ec2U1woFuAXiVwK0nj1BYJfB?=
 =?us-ascii?Q?pb/KnWpN0NIDW08U9mtWB8giOXmOV0coo9jCJq1TUL1jPJpILNYp4K9FT/bu?=
 =?us-ascii?Q?Nq1UbtCjRKn51a1MFEqGm4aB2SPy/HkBetvbCbUN7PO0oiEwyzD2x+RfHh7+?=
 =?us-ascii?Q?TjNYbP/IKvdqUxLWdK/IKDwXGLLe7bBSHvvRWQvPfodqDAY73ySzw6MyyXrC?=
 =?us-ascii?Q?arvvmJSqFFgl+Sx2t9r4ij+TMHsgfCugnucNPeN2h+k2IfGxiTyw8qRmMCt8?=
 =?us-ascii?Q?rHXkI2hRJymX+kK91TUAkqP3DyZm2Va7pCQa9VI+JwQr5lUO6T6Y9dI16dOg?=
 =?us-ascii?Q?arChrbKWTVbzp1+/qSJwE45kbk5APgp7x/s4HRbbC4KIinv0VQXjpTP3uCpY?=
 =?us-ascii?Q?zIH95+D94OmMC8i4IKYNe8137MvTfa/xxEqbTYdPADuu6Q/TdyggRBWFpvVK?=
 =?us-ascii?Q?9vDKI1sAlNepWDjbHRfopQ5A48cwzGIYu6/3Lvo/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O6ecZkBnAO1n53KiztGYzBhNeTa73Cf5eR5WmNTalPcifV5FjKBlf89WtFQZUSs4nL2VS24AivIJKMJ6pdsBAmkz/i2YhLANl8e4vfr4VgV0KJ3DJkhQ9wmZBa49vzLT/aaBlRAAh4x2eD+4LwftkYAa5+cVqfYt9fmB2SsHtSRqw65tuyi5XeGhrMRLljmEJlXKuVRFBGgewDZmG73tmwCgMxSZ9Niag8I4S80fNXEwX+asJQnXBHNDQc6UmKoXzWeRXVR9eRIlJbTKWpe/bIoiiTKLT61z4hOhbs3JeOsu2wLDP1x8mGPz7tAdUfYwo/ReR7Z+6qnn0dMODhAenQYt4kSnbkC0VydtJ+uKNe9Ak50NRjzVjBsXGftQiLbq+EfIcIY/FxsHcifSuSZ5zF9kLrn46+TrCKEoaS9lY5eiiN8GjCb7CNbkuLc7Hos0+ob+k6RVZy8oy4PQhzY85ShNYt3geGxRwo/ziDPxCrWWOvcg8VsHgIUT3QGXBvCbDGmmW1RaQMONBMSoUzjeQ5qr5HQ9C+CiiMR3yLuEsH6QbLq+Df4JHFfG/axXLlfnqPX9H//0P7rJJtyLMOBtZ3xxX8fyHkQxOSMf1wf7qLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074d4447-141d-4cc7-a999-08de17f63eab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 20:52:31.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LMHyfe4PLCXo+5H1ednlKwLXtnX1RnAHxaKNQe71DV2eM4RFj0pXsPS+6mgpxzEdeoHp+D0SqAjpq2+jA19bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1OSBTYWx0ZWRfX+y2m6Em/lRYd
 OXPnOfHnBqJVcBuQ8B5DhrzlT4IOnWOSjcDQBLAgtVAHO6pfv0rYIluVUopoWk4Zdwdo+OyaIUB
 OTxtmlmnFLYbjC3f+v691zfk8gJAjG5qT9ts9YmoPZjG5m27ZxLLfSEZ2FyWRIRj5jY0eBzbQHh
 BGCjyE/zqyyx2bM7B4D3jAMIyA+1xaTSSG+qJbYHCiNu90vIrq14ednP/o+ihuFmpO9BalBOWGe
 yVoEdFMcmqnD0FPYU3qb2iL/Jh19rUSYZ5uxKfA4zZcphWxDTjSssy/D9UD9WEE5LHXn0fmFc+E
 5Rt0dlujt/WqWyfUw37DgyZ381iedmWnOXxtqfrmSiD6Vf+NlKG9h5lMOMq9Gt9Hc6qp+OzXB0G
 xxse5q1eKXEuTRl/iIij1sYAeLFMjQ==
X-Proofpoint-GUID: sXK-ftLdx3SRi1lUpcbHSIXddRcLE-8m
X-Authority-Analysis: v=2.4 cv=P803RyAu c=1 sm=1 tr=0 ts=6903d016 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=u3LlL6Ff7Sp_n0vlufoA:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: sXK-ftLdx3SRi1lUpcbHSIXddRcLE-8m

* Peter Xu <peterx@redhat.com> [251030 15:56]:
> On Thu, Oct 30, 2025 at 03:07:18PM -0400, Peter Xu wrote:
> > > Patches are here:
> > > 
> > > https://git.infradead.org/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/modularized_mem
> > 
> > Great!  Finally we have something solid to discuss on top.
> > 
> > Yes, I'm extremely happy to see whatever code there is, I'm happy to review
> > it.  I'm happy to see it rolling.  If it is better, we can adopt it.
> 
> So here is a summary of why I think my proposal is better:
> 
> - Much less code
> 
>   I think this is crystal clear..  I'm pasting once more in this summary
>   email on what your proposal touches:
> 
>  fs/userfaultfd.c              |  14 +--
>  include/linux/hugetlb.h       |  21 ----
>  include/linux/mm.h            |  11 ++
>  include/linux/shmem_fs.h      |  14 ---
>  include/linux/userfaultfd_k.h | 108 ++++++++++------
>  mm/hugetlb.c                  | 359 +++++++++++++++++++++++++++++++++++++++++++++--------
>  mm/shmem.c                    | 245 ++++++++++++++++++++++++------------
>  mm/userfaultfd.c              | 869 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------
>  8 files changed, 962 insertions(+), 679 deletions(-)

Including the following highlights:
 -#include <linux/hugetlb.h>

and

 -typedef unsigned int __bitwise uffd_flags_t;


> 
> - Much less future code
> 
>   The new proposal needs at least 6 APIs to implement even minor fault..
>   One of the API needs to be implemented with uffd_info* which further
>   includes 10+ fields to process.  It means we'll have a bunch of
>   duplicated code in the future if new things pop up, so it's not only
>   about what we merge.

You can reuse existing functions if there is no change.

> 
> - Much less exported functions to modules

I haven't exported anything.  You asked for code and I provided it.
This doesn't do what guest_memfd needs as it is.  This is all clean up
you wouldn't do.

> 
>   My solution, after exposing vm_uffd_ops, doesn't need to export any
>   function.
> 
>   Your solution needs to export a lot of new functions to modules.  I
>   didn't pay a lot of attention but the list should at least include these
>   10 functions:
>   
>         void uffd_complete_register(struct vm_area_struct *vma);
>         unsigned int uffd_page_shift(struct vm_area_struct *vma);
>         int uffd_writeprotect(struct uffd_info *info);
>         ssize_t uffd_failed_do_unlock(struct uffd_info *info);
>         int uffd_atomic_pte_copy(struct folio *folio, unsigned long src_addr);
>         unsigned long mfill_size(struct vm_area_struct *vma)
>         int mfill_atomic_pte_poison(struct uffd_info *info);
>         int mfill_atomic_pte_copy(struct uffd_info *info);
>         int mfill_atomic_pte_zeropage(struct uffd_info *info);
>         ssize_t uffd_get_dst_pmd(struct vm_area_struct *dst_vma, unsigned long dst_addr,pmd_t **dst_pmd);
> 
>   It's simply unnecessary.

Maybe we don't export any of them.  Maybe there's another function
pointer that could be checked or overwritten?  We can do that without a
flag or setting or wahtever the name you used for your flag was.

> 
> - Less error prone
> 
>   At least to support minor fault, my solution only needs one hook fetching
>   page cache, then set the CONTINUE ioctl in the supported_ioctls.

Your code just adds more junk to uffd, and fails to modularize anything
beyond getting a folio.  And you only support certain types and places.

> 
> - Safer
> 
>   Your code allows to operate on pmd* in a module??? That's too risky and
>   mm can explode!  Isn't it?

Again. I didn't export anything.

> 
> - Do not build new codes on top of hugetlbfs
> 
>   AFAICT, more than half of your solution's API is trying to service
>   hugetlbfs.  IMHO that's the wrong way to go.  I explained to you multiple
>   times.  We should either keep hugetlbfs alone, or having hugetlbfs adopt
>   mm APIs instead.  We shouldn't build any new code only trying to service
>   hugetlbfsv1 but nobody else.  We shouldn't introduce new mm API only to
>   service hugetlbfs.

Ignoring hugetlb exists is a problem.  I have removed the hugetlb from
being included in uffd while you have left it in its own loop.  This
doesn't build new things on hugetlb, it moves the code for hugetlb out
of mm/userfaultfd.c - how is it building on hugetlb?

Believe it or not, hugetlb is a memory type.

Certainly smaller changes are inherently less bug prone.  I honestly
think all of what I have here needs to be done, regardless of memfd
support.  I cannot believe that things were allowed to be pushed this
far.  I do not think they should be allowed to go further.

> 
> - Much less risk of breaking things
> 
>   I'm pretty sure my code introduce zero or very little bug, if there's
>   one, I'll fix it, but really, likely not, because the changes are
>   straightforward.
> 
>   Your changes are huge.  I would not be surprised you break things here
>   and there.  I hope at least you will be around fixing them when it
>   happens, even if we're not sure the benefits of most of the changes.

I have always been prompt in fixing my issues and have taken
responsibility for anything I've written.  I maintain the maple tree and
other areas of mm.  I have no plans of leaving Linux and I hope not to
die.

I can maintain mm/userfaultfd.c, if that helps.  I didn't feel like I
knew the area enough before, but I'm learning a lot doing this.

Thanks,
Liam


