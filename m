Return-Path: <linux-kernel+bounces-897307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E2C52917
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 319E04F5886
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF29A33891B;
	Wed, 12 Nov 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tix4SF2V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UZmrqYAT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE528328612
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955033; cv=fail; b=Ngl/zsBhIKzY17gbPQv8rcoykz6Vc95p7DGqOvCAGm1k3/uc0qFQu/iwrwAlUIJIdJdiPi5TNTHQgHBOHfQ+O3rv4FRCZhfSk/h8Vesl3EzwuMzti9VthumFPY9eNG61fL9atBfQTogXepjGI7z/Leo1yZapsgj6GVEsAZJp1Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955033; c=relaxed/simple;
	bh=bzYdsd4Tmorgixq2n37Nxvl18OhxWL5aCE1QcG1gdNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QN3Ru3bOeiiiMpysEvjZKU4pRPNvwA8eBs0rfkz//PqRcQW9oUBAhtMUJZZnIvvz52MLpEdv4vAcM7vHWXBSBVTSc3Njbte5Qbv2DHk2Kpksh5NG+Uwg6KzMqVSk3Jb53O69dDidj5HQtZ1tWLkwESBVeuHL2NNL8hiP8a6hiyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tix4SF2V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UZmrqYAT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDBKc5018763;
	Wed, 12 Nov 2025 13:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=t/blHTn9XQl6oGdr8P
	VsXhS5Fi+3BpZKH+R9TNPjyLA=; b=Tix4SF2V7dlTvWau3jMzKbU+DDQk0+1MPQ
	M9DaJzhA0hHn1CYjs1s5lTD5EbZIKqJqFK+ZEahDNRUEY1FEaxDB85E3hp7DLAiX
	1BZfy6SmcCuiZjiZJ4Zy/V6qAVKcoOndICx3GjllFGJNzLo+KYYvfjs2iomlYDpw
	rd9+7CUfjhTq/z47wjPi+mQmViK8dxZTcHAA1b1eSJCpgEAuUUJImlzi0buLg1FG
	oW4fT6R8k3ry81Ih30et/6QjXVff6AOgkQY/KTrlO5+RE0+HU3ST+yK3yN3hDuBR
	8sVYNTtkrtx0T7AXcQgHAIKVripDncWA1D3OdVvNpYXvZUQU+nxA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4act7p84r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 13:43:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDbm9B010108;
	Wed, 12 Nov 2025 13:43:19 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vamfkrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 13:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc3l2uv3me1DL0bjDiW2ripkPQlSS82OLhETtXxrU3OSk7ZyTpSkvN3Zgz+KEW+UyLNBZnYn9qDZCxr1AAP+HFHS9pJOl/6BOXY2IuQC/9aY3MLeP+APaRxJ5t23wxucXJa7+ZE8p/rlMuk9Wmsld91HgiwDWkcgX+8lCoerLTOGX3/xdtu60kVURL5Da3oQ/DOQEQbr19ovWZXdFp2JsKXTTWpyNqek7QvNDRoJVm61iEIhPywxMG1SJXfzrkRazIR/nScaBHnQcH6/Fx34dIZLt2zpsFmNrVBZniUq1djQNUi/Iy3fP4KTMjQncK8edP613qMVp+8qQzLAmmldaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/blHTn9XQl6oGdr8PVsXhS5Fi+3BpZKH+R9TNPjyLA=;
 b=XZyN5lVCtY0Z9GpMpSdKkFcKA6524QwsH08nx47QOocly48SLIxi3TEk3oMG1P78H/hZcPSU60ERQvLyLjs+D/DqGH8E7gs//CX5O9b2ivEYK7xyGNZUPBjlFG/r2OMErnVLQ5s8UhUSef/XOVS6IJm0NqsCld7k5zZxXhAlPrbpniTnuuBQ+QBkhgsBpOY8NyH3jO6Z3S4i+fLnEsMlzrPUmerJnTTUwJVyRiG7IByL7f7lV16hxYtCPftdxCV1GtJKapAnWgt0od/MZJk3xRKQzun1VFQQVLSYUfiBvfovB+5EgvmOINdmI4poLcQXvj297aViU5S+VSqlKI786Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/blHTn9XQl6oGdr8PVsXhS5Fi+3BpZKH+R9TNPjyLA=;
 b=UZmrqYATpGVuBChUYs2fgXpqU1zIdP2DgG94/JeNXqv3NzHoxjmlwO3uAyig7aKaFNCLhAhKRid1lZmS7WzjeM7nLJGOJ5LyLQTMo62tw0EenQ6LMahyhud8M17EAtYoILmS3Ar7aSyqxASX9Q/xFUtwhISxq1uPX+jEteCtURI=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by LV0PR10MB997567.namprd10.prod.outlook.com (2603:10b6:408:33b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 13:43:15 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 13:43:15 +0000
Date: Wed, 12 Nov 2025 13:43:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, David Hildenbrand <david@kernel.org>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm/huge_memory: softleaf device private fixes in
 remove_migration_pmd()
Message-ID: <c5ebefad-2b1c-45c1-9a82-17a024d52d1c@lucifer.local>
References: <20251112044634.963360-1-balbirs@nvidia.com>
 <20251112044634.963360-2-balbirs@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112044634.963360-2-balbirs@nvidia.com>
X-ClientProxiedBy: LO4P123CA0614.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|LV0PR10MB997567:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d97129-0a6c-4684-f59d-08de21f16e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LD+/CFQSWgSxPDAvdxL0LGKZlw9m3dUrjG4GbWu4+JrRynYVtjIbnTQhxF3A?=
 =?us-ascii?Q?UGNVAmWqxEq7Du9I8uDaOr1fUlubzxPzeVyfF6rvLKyoNqm0L9931+4qNd4c?=
 =?us-ascii?Q?8/OKDVeMDLEzpXPxdhm9EYGQD3rkxgdxDfcTgUpOddUsESMp/+NFhoBSFBZH?=
 =?us-ascii?Q?TBVo+M90+xpxgIWgTBi3gobxpJ8Xa4YxW0Vh+Cs/jrhdTXQH3yp4SkT1qBSr?=
 =?us-ascii?Q?+Vu1go818AuxhZmvDt3AlyeMcBTwDRo9hjmVZ93igRWlIbIq+p5rWdRICWwE?=
 =?us-ascii?Q?RbOqVHl3xk+KEOkQULwE+X9WEw8XTXWGWlPq6mTlEn3PTYUJuh6hmXsOwLff?=
 =?us-ascii?Q?Cji1eRcCQCutCfcHhFhJsTv4wzWumzfWCbSPauwcLgMmM5cjaHWOJwaheN8R?=
 =?us-ascii?Q?Vd6nSRLpiaIcf2H9RRlu1QEc7yRwnsle1M36s2/0gI5DrbPnwxqU9ZWX4ejo?=
 =?us-ascii?Q?C+kwWrlohxO5GxvGQ1peTdWd9KieRRmYj3iz6BxCQlrKP6FigPS6pLcQK8XL?=
 =?us-ascii?Q?YI4XP/oE3nubtxJCU5FsAFT25BKrsgpjjFidEbcIrOs02EnggLrFXahOqIf8?=
 =?us-ascii?Q?Qeyi/6EMoYSbD7k2CXBToPwD5/GoBpq96dYx9jeTF8PEz/3yosHp47MumrQp?=
 =?us-ascii?Q?VEcclZZEsfUsnmNLC1k/4AJ7Mryk8mxDxBkfzQDh2zKZgcS2oKEha9Bug3OQ?=
 =?us-ascii?Q?hlIGYX9p1gFWiwSxcMpSXBAUlIkkfdYEAFKfB2SHi6mV3bhtuL+C8bIOv1rS?=
 =?us-ascii?Q?LkGFjVMg5wSbdcKYuhwl0PrRWNoUBhRN6QtMancu28oW2Hlt6qgEGI0LSjY8?=
 =?us-ascii?Q?EsCQJ+q048wbPdcghTgafT5MhIuVrInjtb6xq+vXy81Q6DXkJNjB3V0MARwD?=
 =?us-ascii?Q?mgBxBA4HXOto9m57VkRZuZ+nh6aHOuGz0nTTVQpiAcQJAxWZTgvDDWeGhAYe?=
 =?us-ascii?Q?GnXY+kx1Dq0kP9UHEyfQ/nLyM+mbDMHvKPJzCPkJHNaQREmbv5SJEd9NY3uk?=
 =?us-ascii?Q?kEHT44R+ZVvjHah6jlPklWFHwUxU0+mQ8RDQrQ5gG8J2L3jQXWn4szIs/kDg?=
 =?us-ascii?Q?ZQ6MLwhSRH8JWjzhpihvLAFjY9LVHZNoUVzqUGUMEMxAlL89MZk9R47s2BxR?=
 =?us-ascii?Q?i40j4jEhMOYkSwAYbx2OAYmjIoBUcVzFs0zku6EfTN5uc8s5B7FU1pBjIogO?=
 =?us-ascii?Q?EBgzxyYlbsohXEsL52Oz+lvQ7ie1FuBZAR2dTHtAkK0Bx9oQH1h3wvrzkCwA?=
 =?us-ascii?Q?A9Hjd4uGbqs+q76Ez5bBhAqZeGwqRxDma0/CGmbYdIMTkQK2BTyTAFEhyDhr?=
 =?us-ascii?Q?y8OkR+sytT/CEA9ZooM2J8nWjCmiItHojO8iaMoIa/gjeNlG1+hmjzOLfscF?=
 =?us-ascii?Q?HDToqaa8PYdQGyet7dZ9/Hz89QzE+ZvulCHdeVZdiOsV9bIRQpLbeXTr2/6f?=
 =?us-ascii?Q?C5F4Mv+mn2GTcGHCE90mTFg6TWoaHaRj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i8pg803WFlJtF0qx125qkg2xofcVOr9CfPEzGOs+Xqc7hJgMkXEUU2cpIkbV?=
 =?us-ascii?Q?cLupAQ+kvnaJSucPg1teLCRLfzGCsDuPU1bb+WMRYBK01cqAasU4GS6hhi47?=
 =?us-ascii?Q?x/lP5wDmAyeM9LULimIscYBFqAJ5M5B0KUJulDPH1zvlbomJKE8DZx+GAU5r?=
 =?us-ascii?Q?VXJbkt+mPCBahKul4Ky4PtJ5ooKvoRd8ueX1+9Mntgy70yDi09kL6CLYPkwu?=
 =?us-ascii?Q?75Q+bjmXKTXeF+cfadl+akHC2eXP7bH5dV3RFitGtH2SHZx6siXYz+ap69ke?=
 =?us-ascii?Q?wGTVrMG8WZyH/XBAR8etdDUMHMQazJzQto87w/QU6BkUQFA5pihdAz8LbKBt?=
 =?us-ascii?Q?r6ZJIeYEopCktTS3KzOv1Uld3fcwhUMft2Uuo+0yDGKkwvEiErmYgsbel0+G?=
 =?us-ascii?Q?eAwyaogxaq3mDUoh7RHtgPAuOwqTVXUZmWuVD8WgzrLWm8YZ5N3NWRdIHJ2i?=
 =?us-ascii?Q?uYICdwG7eImMDbDdl05hkX4fho9Yb07RSsm+BM1wb/e3jmSZ/q7mOuRwcuwE?=
 =?us-ascii?Q?e25AZmWHG0NXbTnQSJxCAOrq6UVNv4gBv2uYv/mBPXTExlQLsz0B7pbCfB29?=
 =?us-ascii?Q?9DJ2bSKqDF8UUAM1ioVkikVA/qui0Ijt+l5Wl4XRH0Hm7oKCKfviOObns/pq?=
 =?us-ascii?Q?0tS1XsZzD3juh7R7IUXoZzj5ApDsW1+pE3dwrP90Q4NXHZUk1HJBVapeg7e/?=
 =?us-ascii?Q?kCj8nnT3Bbd7VhEsSLuOcRqiO5inINbW1Y6CN06z1ieTtUUEEhZ90s9oI8rg?=
 =?us-ascii?Q?0+3QtDB6x67Bs1TLQFnNmiBZGyWWcuFdzmk8x158TzdomZmIwoTvWutrKBSC?=
 =?us-ascii?Q?LLiZroGuyY+lAmBX18vzms+72EzmSlh3egTMxIlEjpqPbTAjw51nVx2mZTWx?=
 =?us-ascii?Q?/cj0cE0JsZVno0ZTjaqayNtx/aUbqIjX65hfP7yyrBM+iNiIRQli5uGX5f9f?=
 =?us-ascii?Q?TpHrUFz9uYa4qoL9aPk5LnGv217F60CmfAeCDvszY4rR0RwR0/GtucAm1NMn?=
 =?us-ascii?Q?LuXKvIFVmHZpKK0SO+yaD+Ghnx/W5/nPIBDRjMKYTz0Ik0j81Nodq12wLtDw?=
 =?us-ascii?Q?ZyNGe3CRNfOHZhu3ixNLZ9B8yBYaoHFscxcTjCiY/FNZErGsIDyZLtq5/PBb?=
 =?us-ascii?Q?tXi5F/npDoDGrhmCkaQ/ne0DFNax70x+ltP83ib40WkS45suRLYYFkCXCJmi?=
 =?us-ascii?Q?N1nLfbgcDK8x9/oP6HUPxzA5+rpFTs+mdpqtW3HcMks+WKEBv+xLSBOA+RBP?=
 =?us-ascii?Q?EJ7EjvaK7h9jzZ/FJVIJLX/Q9E7A96XO01qg3Ci53Hs47tjvLbEldB8GZAIG?=
 =?us-ascii?Q?he2TqxSfXhLIwq/naP8wN8VpB313kKY8LjYD1tYVFvJUIhh1ckLgmzCirxm3?=
 =?us-ascii?Q?7SSmcTu0VTa1cYaBme84AfToR3n/1t0VKrQiAji7J7Fz0LBCve5H/AB4ZmFH?=
 =?us-ascii?Q?CI0ilYulFF/AiDgTAvXpdgYQ1P0GwpORaGR7HLJ/ACA/czSHql3gPAa/SGdz?=
 =?us-ascii?Q?KJ8PbUoPHevAKVGqxwy22JPWPlgk3SwydadehBbewFOlTe0ANbV1ISCD9+W9?=
 =?us-ascii?Q?iMRa76MbGbQftilOWAx8m2jq7C/at5iXpV8yvXxLdJSHJ5fBDZ/1/f0CsR70?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Byl5NJ2xFQ5GZeyyqsIljCisR55uSb+3bpMTX+cRng4hOqF1/vUFXo+gyT6s2CWJojzlRey/7K4yciSqgGIgW5Jp0dU/93tuKlf9xO9XFXYtzQIkvYjeglROpd/OpUTj/D+XvhU0k7ezOwx+n8mVEWnSAv4JCDB18ah5EXADOWnqbiYrqEe00P6H77v6hPvKfW9eXJerTmlb+ttiQJ/r0TQbluAjfppfynxNFtSUIT1Lb0GS2sTM2+CRdnAAzNogrj0kQmV8EZueZTMVLIZ1vw2MyxtKzUdQfOF3GdTVcGP/gbSYH+vUOvMHffkxLcxOoEJ2zRK237bU9T0n2Px7I+KOpEPdkbhHgrPx79ISB1wGny/6J8/KEnZoOAUX4vycW2FinvSkzf1V+fCL2BiNxDuEUaIdTIC5rLA6sCHC2RCVebLvjD8uRFqSbvKmaAmrUHDhC/h9vTz+9svZ+XX7xlkkiEYjqqVYaM3hyAYy2oFbqCueqlM5hUNul0m/bbqCIP/xTqSUswwUCrB3huUYcJ7Ub3kizjp+LxDshspN++1usfXkjFLG0y692TEgspyyWqk1YvirJaUzpT+pTLO09zX9vMCEl4i+sZBviWbSwuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d97129-0a6c-4684-f59d-08de21f16e10
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 13:43:15.1433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeLuMS+OUK70ZPwntOaOpZzJpBMIAvR3MobuzSiCf7NkZl3+07Vkv9n/sMJFT1PA/+OGZ48WfHIpCJowma4kH0zttmh01BLxberXZzPJtjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120111
X-Authority-Analysis: v=2.4 cv=OPEqHCaB c=1 sm=1 tr=0 ts=69148ef8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=SRrdq9N9AAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=PRfKf8xcJO_4-veeR3AA:9
 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf
 awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEwMCBTYWx0ZWRfX+6WStE4J6BSN
 IG/usKQp+Q0CkHV45FX01l8oiF9zEOmICXMdXr3QIse+SclnorSSS2QfrQWGbikU2CnEVCHveQ+
 miT3zKFLyJB5oosNaHfLk3HHYux0aK6q3DXIhW+yezXbr9n4o/cCnmS4Ldtmk3W7XpkOVBMYNjI
 Vk27uGRYcsvpV8WXqKB6Ok3wC+aWvBk1JaFlfLAKXOFQwu4/FnGNXt+GDnG2j4HmQjxC0Y8E4WF
 v0Demz6WamsEq1m66IS/M76OBWCo8mpIT7Z8f+j+ndUHyBKNyjWZiqXQFPJnFETfPTjPZFSgSgV
 Ql7fyEK7GlwcuybQsNhxtDzhuNh3hGw88FXLhRvgAJjpJevnNi626dktR13XkU89lNYWVYqQ0XF
 /+T5EJw1hiTk6im+NGovg2PXWOQwHaRw0rh9dmJo6m/FQzKXA9k=
X-Proofpoint-ORIG-GUID: 6dIIz3QTso_K3wwsoR_PkTy_dXLP2lLb
X-Proofpoint-GUID: 6dIIz3QTso_K3wwsoR_PkTy_dXLP2lLb

On Wed, Nov 12, 2025 at 03:46:34PM +1100, Balbir Singh wrote:
> commit a6ca2ba46390 ("mm: replace pmd_to_swp_entry() with softleaf_from_pmd()")
> does not work with device private THP entries. softleaf_is_migration_young()
> asserts that the entry be a migration entry, but in the current code, the
> entry might already be replaced by a device private entry by the time the
> check is made. The issue exists with commit
> 7385dbdbf841 ("mm/rmap: extend rmap and migration support device-private entries")

OK this is _hugely_ confusing.

Is the bug in my patch or in yours?

Why are you replying to your own series with this patch?

You shouldn't reference non-upstream commit messages in general.

If the bug is in 7385dbdbf841, fix it in your series, then perhaps send a
suggested fix-patch to the appropriate patch in my series to make life easier
for Andrew.

As mine I think in this case was purely a mechanical replacement of function
calls I'm guessing it's a bug in yours? So I think this is probably the best
way.

>
> Fix this by processing the migration entries prior to conversion to
> device private if the folio is device private.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  mm/huge_memory.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 942bd8410c54..82b019205216 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4939,6 +4939,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  	unsigned long haddr = address & HPAGE_PMD_MASK;
>  	pmd_t pmde;
>  	softleaf_t entry;
> +	bool old = false, dirty = false, migration_read_entry = false;
>
>  	if (!(pvmw->pmd && !pvmw->pte))
>  		return;
> @@ -4947,6 +4948,19 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  	folio_get(folio);
>  	pmde = folio_mk_pmd(folio, READ_ONCE(vma->vm_page_prot));
>
> +	if (!softleaf_is_migration_young(entry))
> +		old = true;
> +
> +	/* NOTE: this may contain setting soft-dirty on some archs */

'This may contain setting soft-dirty' is confusing. 'This may set soft-dirty on some arches' perhaps?

> +	if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
> +		dirty = true;
> +
> +	if (softleaf_is_migration_write(entry))
> +		pmde = pmd_mkwrite(pmde, vma);
> +
> +	if (!softleaf_is_migration_read(entry))
> +		migration_read_entry = true;
> +
>  	if (folio_is_device_private(folio)) {
>  		if (pmd_write(pmde))
>  			entry = make_writable_device_private_entry(
> @@ -4959,20 +4973,17 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>
>  	if (pmd_swp_soft_dirty(*pvmw->pmd))
>  		pmde = pmd_mksoft_dirty(pmde);
> -	if (softleaf_is_migration_write(entry))
> -		pmde = pmd_mkwrite(pmde, vma);
> +	if (old)
> +		pmde = pmd_mkold(pmde);
>  	if (pmd_swp_uffd_wp(*pvmw->pmd))
>  		pmde = pmd_mkuffd_wp(pmde);
> -	if (!softleaf_is_migration_young(entry))
> -		pmde = pmd_mkold(pmde);
> -	/* NOTE: this may contain setting soft-dirty on some archs */
> -	if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
> +	if (dirty)
>  		pmde = pmd_mkdirty(pmde);
>
>  	if (folio_test_anon(folio)) {
>  		rmap_t rmap_flags = RMAP_NONE;
>
> -		if (!softleaf_is_migration_read(entry))
> +		if (migration_read_entry)
>  			rmap_flags |= RMAP_EXCLUSIVE;
>
>  		folio_add_anon_rmap_pmd(folio, new, vma, haddr, rmap_flags);
> --
> 2.51.1
>

Thanks, Lorenzo

