Return-Path: <linux-kernel+bounces-735533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E46B0909F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C8B3B3D73
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80CF2F7D18;
	Thu, 17 Jul 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GYEBON01"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEEC1F1537
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766245; cv=fail; b=tL+6Jc10As5LLAP/nicr52DtelWTbtCLLXOy664X9pLl0MbLEcvEwWYGjBucF9dXATMumogK+tRXe7o9tVPyZVlks9gS0bDwF4tEN7lsie0KXIycIaCO6Ksp5wpR4MXY556IQFNJxuxlfykC69wG7vjP5EaAqss/94+39g9odM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766245; c=relaxed/simple;
	bh=XPfIEHV3BYLBRwQ/gPNeIheKtdVs0ihcf+RIch8e1vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QNEokKSbBvDRB4nO+EQwFnq4seFB7gnh7cLemO2FXw/4ZnGO8yC6HxTsI7WrPq3aquETgN3lZcEB0ZHhk2s0jVhHPQ9foDSljbteMtbvfMFzx/sDicCc9oQBv9zcfIzqk+KyVymWbqeTYDu2je53Y5kgdCDxyn7hj12a8pmHA8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GYEBON01; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqkDRy8B8fas8bCQjf7W6qJ4MgQg/WjnICnytVUJl+HA16hRd2Cw5DR2XDMPpbo1hgjC5HBht8jkPCW75soRWGEH6nS4hnhqdcrVak+3uitNMtxNIUcswrGkOdUmNU4C7Kwawds0hfpk58tGVBPowuIZm9X0DmG+mbZnfw77A/dEE0LR0OKDnNlZsMRPivrftFBApuftPLsYUgOkPoRunbYtlCrjatBNS4jjxQE6c+F54s1+Kh2QnqjAMNkNQMd+JEsi8ElCMc5DoLD52XqUn3ag5zrRHnGDLyClUP/k8m4ZJojwAyfljdv+WsXN0sgtJc/3Jk6v/tsi74RnoDbmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrkfA+GRz//7aL8A20zwk4lloyL53qphmjxAeVl/4oM=;
 b=J0VaTtPS+MR85H33ZMTOKGVNwqgJiB5DAoG2ZBZ+O3jfMHcmeWR5LRWwPED8ZOE6olxtz4x8+gKZ/uqkIPShuzHrp5xSVLgDPHvE14Yp9srhFitbrSRsj1sXZwz9k7wJAQWaYh0FzDHC4PmwdrvPFqrx5eVH9fS20wgyUd7t82T2czr1one7YhVc4S821OOVYcd1Tf/wxgzy9qdGuNQtRb3zScqWLdP+2aYJoWUK9iThHPDUK2WgH773tgmrNYM2gsr04zh7I0GY5Ia4e5YD3V0IGH/hN3fHrrNsyIcir7YsrX9ky+6APeW+Rngel+khWp/C81o+AViTeUGje9nNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrkfA+GRz//7aL8A20zwk4lloyL53qphmjxAeVl/4oM=;
 b=GYEBON01fDHGFdmfwAxns2ZDbJLordsbVtPvfGSvHsk1LP/hcRO/1x1GWxtSyAKhuc2mS/GOHav44RXYL/u+V98ZU3CugeAiIO/GuLHsgwrrveMVTexHhe7xnfNrbG0kQJy/tNjA0DZ0o+xui0YwukBBZJNXJGdEdVXxw/tapx8XD0iJ+9KTctr/3hUnnU+T4+WJXj4xpkRzggpxXloamzR6XMkDuFG/IgOBFPw83PP2IAx36tB9QCNrNqYvzVn6NG+k2JbHMhlQYHVDAlmXvDpaGjmegsrIdxFyD5GAu54vWVJJ+B+Q0Q6aJaQeTVV+yiLD7VyPZBW3IZW1dIG4Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 15:30:40 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:30:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Antonio Quartulli <antonio@mandelbit.com>, linux-mm@kvack.org,
 Hugh Dickins <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Date: Thu, 17 Jul 2025 11:30:36 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <31D32C5B-6719-4E3D-880A-666044C4A48B@nvidia.com>
In-Reply-To: <a479057f-5401-44ea-b3a8-dfd82b826721@lucifer.local>
References: <20250716171112.3666150-1-ziy@nvidia.com>
 <a479057f-5401-44ea-b3a8-dfd82b826721@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:208:32f::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 0242d922-24f5-47d7-5cc0-08ddc546e2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlVaYUROOHNyQzlPTHQxeCs2ZXR5dnpsNXp3QUFiMVN3cWs1MW5ScU1PM0R4?=
 =?utf-8?B?VUpra01Cb2JpZnlWazVWRU5zeWJNeFVkNUIyMFJFMlpuL3VaWkVzUEU5RUZq?=
 =?utf-8?B?WHM3WlZFeHJtSm0xbHYzRHdHbGMzTzh0VUJnZGRvR1c0QWJGRlpRM0hETFd2?=
 =?utf-8?B?R0xaWXREQlMxMGc1aVlmNm8vc2p4S3UwSDN4UHJNYjBmREFhaVIvYjlHVjJH?=
 =?utf-8?B?L1g0NVlSbVdnaHhpRDQ3NE5xRnNxL1VKVGtyTzlSNDdsRnY0RW5La0ZZcG9H?=
 =?utf-8?B?cUhSMEhBV2U2VVpwSW1UekJMWTFuTTlFZkU0NFRiYnNKRmJoUnhFZE1nU3VS?=
 =?utf-8?B?U1NsZHdxSjk2dm1ZRGkrT0Fwa1UyL0JhVzlOUytHb1hMUTNvdndWbElPdEN5?=
 =?utf-8?B?amY2cFhkMDV5OEtVdnp2THBxd1d3aFRGTGwvM2RSNW9qS0Q4UUtXYnpXS05X?=
 =?utf-8?B?ckJjT01hV0FzWmZ2VjRlZE1GeEpmT3N4YU9PUzJ4dlo2b1NNaHN1Y3BaYWNL?=
 =?utf-8?B?eXozZ1pKNHFheDlZQUNCY1Y1QVJjRkQzY2duMnNDTng5T0JkLytwdzhmN3Zx?=
 =?utf-8?B?MTBrcFFJWUNwT3RWMXBVN09oTHBJb29qZHVjVzJ1WVQ5TGJlRHd6d2QzUzRq?=
 =?utf-8?B?aDlJeCthL2hLMFNDVUFlaXJlSnZnWU5qK2NSNWhQcW10ZjZ5Rmxzd2hNZml4?=
 =?utf-8?B?bHFpWkxWVVFvcXdSbTdWR2lHbG9YVnBFYkFDNnBPMFcwL1ZJdzIzWHhFaGxD?=
 =?utf-8?B?N2kwWGVHU3J4L1BNV0JRMWcwNlhabzVRWE5uRTAzUWM0bmpqMTlsT2lEZFdz?=
 =?utf-8?B?S0FaTXU5eWwvODNRZkl4VDZmanFUVnRQZ0huZVR4aVU3bjJrcGdJdjFMKzVR?=
 =?utf-8?B?bVRwT1laSkg1aW92amp3aXUwbHhnOGNvWENDRitvR2lwa05YQnBmNTNyTndv?=
 =?utf-8?B?YkVVT2dsQnBkSTI0SUE5SmR3NjdJL2YrbUJPNXRjNmdaa3VveVBady9TdXV4?=
 =?utf-8?B?ZkJOZWlFemJYMnNidHQyelhuQ1ZHUUFyMGM4THVtV3JaT2s5dHd6eGhSd0ly?=
 =?utf-8?B?dE9XdmpHNmhjUWx6RVJKK3JCaHk3ckNIV21vL1cxbSt6OG1rL1BVSzVTS2tm?=
 =?utf-8?B?ckVTTjZESW9ucTFQRlUwWGYyN0tHRk1iYXIzSCszYy9pc25rZXgvaFZXdXEr?=
 =?utf-8?B?bTE3YVZFMlk1ZFhnU2lLazhyQWlKVTdpeHpOWFNZQVkyZTIxbkR2OENqS2Jp?=
 =?utf-8?B?UUFyUzVVTmNoOVpSbGZkdWdTR1ROT0czQWhxTFpuUEViU0FEVEFqYm1ORG51?=
 =?utf-8?B?VE4wWGZjQlZsNlo2VUg4ektmeUFVc1JzazV0UFZMRzBuN3pGdWwrUGNEMnVS?=
 =?utf-8?B?MTA1cG5GdnpUZVlxZEhIS0ZvMkpROUxNdG5HcDdOUS9COXdEZVRqZUg4TFUx?=
 =?utf-8?B?cnpyNE1WTnMyZnIwSnZsY0JtSjZwYVpjTUNYOGVrU0RhRUllbmtjUHZvYVlV?=
 =?utf-8?B?eUlRR085ZmpzZlVzWldteHZNRSsvL3JtS1BkRDNBM2MwK0tjU1ZrSmVJakU1?=
 =?utf-8?B?cVpOMGluTXoxRmNEclBESUpmSGJHSjNmUGwwZEs2TnlleDNJTzdBb24xdytD?=
 =?utf-8?B?cmxUZ0RSQzczSlZFcVhtUFdCeUlRdVRXVHNCRDljN1dRVG9OSVhFVFgyN1ZX?=
 =?utf-8?B?MEhFYmZBK2tOalZSNFhmemIyUXpXTnM2dlBtTWZ1Qm5UK0FXTVlFMjFlMml0?=
 =?utf-8?B?KzJxWXovK0pRR3NKa0NzOVhkNGtqKzdHQ3BBcG5ISWZwUW5FVVFDTDFkcE5q?=
 =?utf-8?B?T1dIQ3R3QkRWejltTTFMS0kzTVFrTWlVVkNWT2lnRTFhK3ZYeDZqd0Q0d21V?=
 =?utf-8?B?Lzljd1ZYUkZTckZ3VmIvNmxyL2hJMzNiMHpLNE5jSHhFekxZTHhYMTF5OC9q?=
 =?utf-8?Q?L0mQ+6tLxuw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0RnRjR2ZzBRdk9mY1ppS0t2T1dYeDhDN2JkWDR4UGY3bDFtUTFvRVBUczJh?=
 =?utf-8?B?RGRmUHZkblJzcHFSeGMxVVV5MzhLVmpqQjAyaFpYREUrczYwZmdIb3FTNTZk?=
 =?utf-8?B?d01RS0ordFI0TmNHZGg4akwrNVptMEUxeDN1MkpEOGo1Qk9yMWtVZ2tWcTJv?=
 =?utf-8?B?Q3B0SnRPR2xia2h0djFNVlVjS1VZbjI4cXBSK0JFbmhiQ2pVcG1WMk5vWkov?=
 =?utf-8?B?TFVMQUQ3K3g5bFFCQ0RSM1ovTU1aSG1uOU1jN3hGaG9DeEFXaEJEdjhLMzVy?=
 =?utf-8?B?WnQ5RVVaeEYxNXFyUiswdjVXY0tkK0dzL1V0cGtqQTBodFVOaTYwNlJkNEpH?=
 =?utf-8?B?RWQyK0N2SVdjZ1Ira3RaQWxKVWVHUjFZajNrTVNIV01Ca3VOQ0NJY04yOUpG?=
 =?utf-8?B?aFlIMU5yU2dNL3pMYzlVKyt1cnVrQzN5ZzVvWXF4cTZ0WWI0RlRPb2xRWk5M?=
 =?utf-8?B?K2NnWjArK3ExNmVjdWJ5ZVFTU3BpRTIwQXNpMVVUQmRkK0xUbkNzdFRSNjlt?=
 =?utf-8?B?ZzArL0wzSlIzalRiTU5PWEErcUxJeFpDaFFhNUxvejRzTDRScjV2cjR3d0FH?=
 =?utf-8?B?enIrUU9VRkRqTktURWFlelpWdjdnNFRJbithb3NuV1lMN1hXZHhJUFh0THB1?=
 =?utf-8?B?UGRDOG5MdjNaVGdPVSs3VjlUN1NmSHFiQ0t5Y0Y5ZGtSZStGR0l3MkpZYjlN?=
 =?utf-8?B?Sy90TXR6TWNaREdoSHdhei95dExtYzNsTWt4cUtoYnNxeEdWS3grYm9Mb3pC?=
 =?utf-8?B?dzVYc0Z6WGtBLzd1UW9wK0U5Q0xWODJkblpZaC80bkU2NUdBWXUwOENJMmFU?=
 =?utf-8?B?RlY4VDA4dGJpQWVsUWdvcDlSU043S3V3NVNrTlNUaDVxZ2sxVG9Sc1pDNUNj?=
 =?utf-8?B?dGJRaGluWU8yMjUvcm9XOEF6R0JUOWVqcWhRNGI1eml5TTQxZGM5QzU2Q25y?=
 =?utf-8?B?L2hhL29LSXFUWUcxQ01FNDV0eHZua21tMzZJV2ZrVlgzN2c3UWtFc0hmMUMv?=
 =?utf-8?B?M0hpZFBvMS8rTVNqdVZJdFdWbjBJUUl2Y3dZVXBYYW5HSGZWcnBFZGJPaWl5?=
 =?utf-8?B?ejJ3L3BZbUJhcUlEMVlMdzBEcTRLU3lEeXZXcm9ad1lEQ3dHMVpLUmFUM2VK?=
 =?utf-8?B?aUNsYVpxbTV4ZHVOUnUvUFhkaFJzSDh0VFl4bnpVNGYvQXcxNStBS0tGZU4z?=
 =?utf-8?B?RnhqKzZoMGVQb1I4QjdwZ2VtMmZHWFpLblcxQ1g2Z0tRVE1XUVFLL3VvRWlu?=
 =?utf-8?B?TTAyUjZJTTlYL0Y3dkxLdEJYMy82VW9pc0ExNDJDa1did3dvbXB2RzR1L2ll?=
 =?utf-8?B?MUMrcnZkZXhHbndvQzQ0SUlPTHFCNGVDRjZJc1hkWlByVW14QVRvU2R3K21j?=
 =?utf-8?B?UXd6RnBJUjJBbjIvNFhQMXNRY044aTl3VGc1NkRTZUszckNjZHZOUW9SUkU4?=
 =?utf-8?B?blRSd3VuaHVXL1RYOGQyVmwyQnVwUElkS2loNmd1N21jRTJpdDFjQnBGajNK?=
 =?utf-8?B?RnVDL09Wbm1ocVpTeFF6d3B6c1V1eVdtdzFrNlNNTFJ3RnFPVXh5RkZMN0Vj?=
 =?utf-8?B?VTVYdDB1SlJ1MUlzVGFBdTFacnVwZlF5ODJudGVVdUkxbUF3dkUrZjZ6cW9v?=
 =?utf-8?B?VkgyZ0liODVmeFBScFpKdkJ5czRBdnk4dzhMSlBRbFBRamtHYnNlVTBrWThx?=
 =?utf-8?B?Ym56OTBkNi9Md2xXbi9UZ1R2Yk40Yi95cllBZkt1Q3NsTExudmFGYjJmayta?=
 =?utf-8?B?aVNyZW1BTTdWTVR1dm9JZXlna2g0OUUyNTVZWk5uY2NlOFNJb2lkQ1BlZUo2?=
 =?utf-8?B?WTA0dlhLNXU1d1FxS0tmNnhkTS85SXNQem9mcGV1Q3o4cnRpYmdieW11RkZE?=
 =?utf-8?B?ZnlnV3cwVjZLUExCa0FDUUwwSGVTWUtkd3RQM1pjTkU3dnVrNENyeCsvMm9E?=
 =?utf-8?B?dERwQnU4YU12cXp1MFBKLzE0YXB1eEFweGZVc3BGU0NpUENLWVVKcENtYW5K?=
 =?utf-8?B?ZWVNZUhvWG1Va1d4L3g4MWsxaEFvcGVHTzkzSWFCeVBEQTFZMUZhd1QzRjBi?=
 =?utf-8?B?Y2N2Ukp3STd6QWFNMUc4SzlCWUtEZTVNOTRjZzNDRjZkb0IwdFBhdmlLbktq?=
 =?utf-8?Q?dHITHFxC79OdEZvyh5vs5G6zq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0242d922-24f5-47d7-5cc0-08ddc546e2b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:30:40.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNHdbCXE14AXgksUvn8sqX8M7aOFXk8nQyrse50pXna8Sov7DRrgHyIknBbdJ9x6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

On 17 Jul 2025, at 10:46, Lorenzo Stoakes wrote:

> On Wed, Jul 16, 2025 at 01:11:12PM -0400, Zi Yan wrote:
>> Smatch/coverity checkers report NULL mapping referencing issues[1][2][3]
>> every time the code is modified, because they do not understand that
>> mapping cannot be NULL when a folio is in page cache in the code.
>> Refactor the code to make it explicit.
>>
>> No functional change is intended.
>>
>> [1]https://lore.kernel.org/linux-mm/2afe3d59-aca5-40f7-82a3-a6d976fb0f4f=
@stanley.mountain/
>> [2]https://lore.kernel.org/oe-kbuild/64b54034-f311-4e7d-b935-c16775dbb64=
2@suswa.mountain/
>> [3]https://lore.kernel.org/linux-mm/20250716145804.4836-1-antonio@mandel=
bit.com/
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> This is fantastic, thanks Zi! There's a nit below but I actually almost
> _don't_ want you to address it :P
>
> Therefore:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
>> ---
>>  mm/huge_memory.c | 43 ++++++++++++++++++++++++++++---------------
>>  1 file changed, 28 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 31b5c4e61a57..fe17b0a157cd 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3804,6 +3804,8 @@ static int __folio_split(struct folio *folio, unsi=
gned int new_order,
>>  		 */
>>  		for (new_folio =3D folio_next(folio); new_folio !=3D next_folio;
>>  		     new_folio =3D next) {
>> +			unsigned long nr_pages =3D folio_nr_pages(new_folio);
>> +
>>  			next =3D folio_next(new_folio);
>>
>>  			expected_refs =3D folio_expected_ref_count(new_folio) + 1;
>> @@ -3811,25 +3813,36 @@ static int __folio_split(struct folio *folio, un=
signed int new_order,
>>
>>  			lru_add_split_folio(folio, new_folio, lruvec, list);
>>
>> -			/* Some pages can be beyond EOF: drop them from cache */
>> -			if (new_folio->index >=3D end) {
>> -				if (shmem_mapping(mapping))
>> -					nr_shmem_dropped +=3D folio_nr_pages(new_folio);
>> -				else if (folio_test_clear_dirty(new_folio))
>> -					folio_account_cleaned(
>> -						new_folio,
>> -						inode_to_wb(mapping->host));
>> -				__filemap_remove_folio(new_folio, NULL);
>> -				folio_put_refs(new_folio,
>> -					       folio_nr_pages(new_folio));
>> -			} else if (mapping) {
>> -				__xa_store(&mapping->i_pages, new_folio->index,
>> -					   new_folio, 0);
>> -			} else if (swap_cache) {
>> +			/*
>> +			 * Anonymous folio with swap cache.
>> +			 * NOTE: shmem in swap cache is not supported yet.
>
> Nice added context!
>
>> +			 */
>> +			if (swap_cache) {
>>  				__xa_store(&swap_cache->i_pages,
>>  					   swap_cache_index(new_folio->swap),
>>  					   new_folio, 0);
>> +				continue;
>> +			}
>> +
>> +			/* Anonymouse folio without swap cache */
>
> I almost don't want to comment here because 'anony-mouse' is really cute =
:P
> but yeah nit I think you have a trailing 'e' here that my cats would be
> VERY interested in... ;)

Will change it. :p

>
>> +			if (!mapping)
>> +				continue;
>> +
>> +			/* Add the new folio to the page cache. */
>> +			if (new_folio->index < end) {
>> +				__xa_store(&mapping->i_pages, new_folio->index,
>> +					   new_folio, 0);
>> +				continue;
>>  			}
>> +
>> +			/* Drop folio beyond EOF: ->index >=3D end */
>> +			if (shmem_mapping(mapping))
>> +				nr_shmem_dropped +=3D nr_pages;
>> +			else if (folio_test_clear_dirty(new_folio))
>> +				folio_account_cleaned(
>> +					new_folio, inode_to_wb(mapping->host));
>> +			__filemap_remove_folio(new_folio, NULL);
>> +			folio_put_refs(new_folio, nr_pages);
>>  		}
>>  		/*
>>  		 * Unfreeze @folio only after all page cache entries, which
>> --
>> 2.47.2
>>
>
> Since we no longer need to make new_folio->index >=3D end work for anon
> folios, can we drop the end =3D -1 in the if (is_anon) { ... } branch?

Sure.

OK, since I also need to address your comments on
=E2=80=9Cmm/huge_memory: move unrelated code out of __split_unmapped_folio(=
)=E2=80=9D,
I am going to send a new series with both this patch and
patches from __split_unmapped_folio().

We are not in a rush, so let=E2=80=99s make it as good as possible. :)


Best Regards,
Yan, Zi

