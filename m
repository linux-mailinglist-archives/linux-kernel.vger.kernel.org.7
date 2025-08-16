Return-Path: <linux-kernel+bounces-771794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA96B28B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C48B5659EE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393723027C;
	Sat, 16 Aug 2025 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l66C4o5h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WNqB8e1h"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD7849C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755330819; cv=fail; b=OyUSfkpciXlJCslhcWwGZlu2Sdgs7odjS/5bRGMR1eyjdF+WyzCwiDJNY1FtOOEpEjJah1cIGT4L4u5ar5CxJ+Ff5atMfq0MS/v+76Qvxax6N+Tk9ukGGNLCVK8zBM7vqYOc9m7CYahAZdI+vjsULqrmYW5MCMx0bykGBxoGmLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755330819; c=relaxed/simple;
	bh=mhFYZ4dXGyL2NO/usBLUUTAc+wtpct8xVIHnsM6Dvh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uzwXVGxnCI6RUhx8Mh1IFdjEvTA7BWL1Qn9z/1C0HtYzbBR0vQJXBOKPh9/JOQpCR4GRAU35b++HseJRc5QDgM+iBtpbSYoAOLpnu5TQX+a2OyBJV79JLT5WNWNiEY2ima4uwP4R2q9XoVpBkKwwMm1ZaV4HwJF7wAHEwDf5EfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l66C4o5h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WNqB8e1h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G61QDb024452;
	Sat, 16 Aug 2025 07:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XNz+4usCjnVM90ZUYo
	unm0wmQM1Sujc+Yfmirhm/9Xw=; b=l66C4o5h9KXblYvKNNgeiQWpBSK3WzEVky
	wI8ldEjNxo8quM+mKRjyMZ6XT7wvLIvLyn40BLNK1TRyiH1jCbEtormAOtaP5IIX
	kHnm3C7wEMETKAWLLActgH9dC3dWgRsVnpjSjobpKoQvQ4LJ+/lrjHe8J8Q56y5K
	oFiF06LW6ubJtCn9Tv8Dp+awfnkiAz6H6/Rt5mwuSpXMj7qNgHuEusCwKq9pYXd4
	kdGcoARYAJtecG08EWMXE9GsFnuta/yzWk5IsCAdUIDHvbUay4Xe1ivKdv3ShjHp
	z6BcYRYDHoo4Wc3pW+WcHu95er9GevjL8zxz/D2hNnt5yehX6PAA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgwe885u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 07:53:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57G60KNW024442;
	Sat, 16 Aug 2025 07:53:07 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge6y4cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 07:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpS5DpFQsxDAOP5Qv/4YU8Ra0oiWi30A1F4jT1Q7TpmELpCDmMK9CS2yJepb/DJb55i+nnuKXG8ncHW3y/2INPH1q6yuEEahBGacfUny+2IdAbur0JbDgtBRP24rwbzgBM59QNeTMN50tpUq5Tg5+AbfpsMbXp+BjIKmh1t91KKXPbc+yKHctGofzfAmyCN9WubwCZUuNOtBhRtymYG0OGHsMj4IwgglUTpTrATvZhhjrdhe/cop3UEfZ5oIkvy6XLy9GwpJ/Zy9LQin+6Fq8rHnax8w0Muh9nytUVOjiGzJ/Sm3arf0vrF3P9OoBqvqOvVHiuxnESemq3xmrH63yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNz+4usCjnVM90ZUYounm0wmQM1Sujc+Yfmirhm/9Xw=;
 b=NWiijx85Uuk0u4wXgiyWeCfoXXOe0eJ+vDg4bL7Uyug94P0IDiebPYMd4EseTC5FNeTnusF0ZkD4uTlKRSr6oGvjqERF0/WnQ2xYUsu7Kgd8KDtKYx7PTd71Y1mLxa4e32dHGkNnqNw8BgK4zTVKnejXSB1wMp1xuRzW8jnc4gJ3uYZo91SR3V6vN+fY2E/9Ci5K/hXmD0bRhykh0epdUkTJTl3TrsgPNyhzOJI9jeJKQPGW8mOQOxHbSxEerj8JSu1C8r+KNgFmBBWg2d0ndJ6rCEq8zL/v8Oc/7Hoo0wLYxqVIwUE0uquOHGXbZ7u+YRuPsL/k+T/UAylhT8CSNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNz+4usCjnVM90ZUYounm0wmQM1Sujc+Yfmirhm/9Xw=;
 b=WNqB8e1hrqJ7RnMDpnntW9W/wg/1g4QnFAUwuzmAQBEmvSptj/xpRF8XPkW+oBWQc+sG1Dob/t6kRyZtk21jRxF3LsowB9INiJP/VKe/obro6rxZo24RAJgbWmaimAQjOQi9mZSdMg+4hqvWr/vqH7HkQlSSJD6ts6P6pBn+1aA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPFCCE340B80.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Sat, 16 Aug
 2025 07:52:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 07:52:49 +0000
Date: Sat, 16 Aug 2025 08:52:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.17 2/3] mm/mremap: catch invalid multi VMA moves earlier
Message-ID: <b6dbda20-667e-4053-abae-8ed4fa84bb6c@lucifer.local>
References: <cover.1754218667.git.lorenzo.stoakes@oracle.com>
 <2b5aad5681573be85b5b8fac61399af6fb6b68b6.1754218667.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b5aad5681573be85b5b8fac61399af6fb6b68b6.1754218667.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: MM0P280CA0062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPFCCE340B80:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af28ca5-3dbe-4c8a-7cf6-08dddc99e4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CCRJiTNMZJoSBuqqKqWtfJGL44Oxot1t467qZvz1GmZ7yE4xYMsfc4YjmHJd?=
 =?us-ascii?Q?5/WL5v3JxqgDFLW9bSvNilBu2c+nD14fWIdifc10VacGtcV6J05pS1JvxOjD?=
 =?us-ascii?Q?9/WoNpDzqKSm9axaQibWuD/LP31eOlTFsygornF1h/pVn4ThqmLQvngM1Xch?=
 =?us-ascii?Q?D7C9KtuWSjRy3vfyplV1XRWTBP5mXfXzYTDFO/GVFnidABkI4+6gwMZLljbt?=
 =?us-ascii?Q?9lfTwGwODSsWQEkol6kxS35DZduBocFth8oZsrDhVz9oxDikCdHkqRJz2LwP?=
 =?us-ascii?Q?Pqg2V0kA1cJ8DhVbaMinsfiZANVVYWB6xWzghsqMNXefFJIJOA+VSVDH/UVH?=
 =?us-ascii?Q?6yNIxxpKAo4k35JkWo02WgG7HkL666wpNhsSWE2vmiUcagN/pgfZfUidEstX?=
 =?us-ascii?Q?ZiEH7sPsD1te1sNqsj6vl0/3x8kWRlcxsJ+2xUnWRsRAMRZLU8+m7bDD271p?=
 =?us-ascii?Q?+Lv61+WT0YqmkBzxIP+7T2Khy/xXBZe6zcKr+JxeCo1C7f8wPPqdQVUWKWHX?=
 =?us-ascii?Q?pC6AecSx+Xmvs2KHqD/mN9bZBpdVWudlTcqoCk8pPZJLMyhbrfrkQwkqUfvp?=
 =?us-ascii?Q?e/ripK8UCbRsCDtPKjGimDlMc3duoe76Xfngya55od/wKgwI2OnKZhK/Gy//?=
 =?us-ascii?Q?3SfcbI7ssX4AFJ/zA05EfwcSx8mTwTNdhFs18sHjpb9qWrudD/CaXEtN7toe?=
 =?us-ascii?Q?IAN9R7nIi11kTNymzvj+6japsyDn/wgBfGLGbUlJZT+i3knuAk1rdesSAZ+Q?=
 =?us-ascii?Q?+mUQXYuVCjEZyJLHr6N/F3xZw9QDwX5fYa6ry4mhp8wjjJLg8BDvjmCdXzQF?=
 =?us-ascii?Q?cRV9A1kRkpNsh2Rfo0DWxbcm8pvlj8r12c6/QNC8z/8XLFGCbxvcBZNThchq?=
 =?us-ascii?Q?Oe664qicsHJqUG5hn1DgR786+aixIOIrDtAp0UogWkzHipN5y7SoZRg489ID?=
 =?us-ascii?Q?s2uAQThOb/G2QhvCTn3LCPUBn5RymU4ydykTtxw8WRoDFOKslt6zbnXpfLWG?=
 =?us-ascii?Q?XuHXJtWhVUExOlS9WHTQkepssVFoXkRdz4KdP2uvJEd1/bAM+vpiYVUPuY6D?=
 =?us-ascii?Q?Y5Q7lsfSB7E5RTcUezl0TZv+QtVXsi8NeoWxmAYuIqSGMN5EGhzzhiE/5OfZ?=
 =?us-ascii?Q?UlofwqwDP8tu+WGoRE3quvDbzoeU9JN0CtgkNILpVWm45/USAxMXycwIgXBQ?=
 =?us-ascii?Q?DccXlZAw00XRIBhUXSoNjo7Wg2oGYac5TsZSgY5QF68wTG81mQK9j/1MKF8U?=
 =?us-ascii?Q?oI9yMz/h4p9ZfVra0NsOJSoPaq1YGRVyXfY/LqtAmt4JOZCNbRouTIZLh5Kn?=
 =?us-ascii?Q?pREuj8esddv2TfS9e7f5kG8Ce+B9EZPfgMk3lAAXZP6nkRwFYxclebZzAqBY?=
 =?us-ascii?Q?UrDN0MwqJV9hqyh3TWOQd2VEUoVsgEEA/tAOqWNiulk5cxDmJy4b3cUFsNAa?=
 =?us-ascii?Q?6KHfCmQJM7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8I2Ja/16QZE4TV87tjdrV5dj6Ns5myriHsFaY5Dr0eXaH6sntUJ1tdO+GVbs?=
 =?us-ascii?Q?z3W87NCBKyOoJg6NUnVKO16U7FDRtk7pUUWuxsBeX1kDoMPoNKhs+3dUW7MZ?=
 =?us-ascii?Q?RUJYTbo1gJkVP78z+5bQXEjfQoWnFe1r0Wfbw8vCuLSWa5a4Na/YArqY3PdL?=
 =?us-ascii?Q?MQF+7uib+OuTdDEtMEEHsN86E8pVMM/nAwYfxjzxh1ipt2vJ9kMFENpJ2Mv/?=
 =?us-ascii?Q?q88pF7qX6/bYmfxWkvLB3pQ5FYMRRkKfxK4ml2BMtsULcjGWeWBDdreNj+zg?=
 =?us-ascii?Q?pvMlcbXgwFMbIs72bBedwQks8cDa76ruKoN8z3mlfRHb1yhhbLH+SgQ5Ddus?=
 =?us-ascii?Q?rdB31Jq8xiE7IGLRP8KHr81keQveWO/W+/HwHxbsXR/7W/8xxqdIuL0BcOYe?=
 =?us-ascii?Q?ofO6YaFlly4zrvGl84KMm2jgyOCb7Tm4BS62ZLGUqhQKtsb1aPozStH2jZXi?=
 =?us-ascii?Q?+H8aTO93PIhs6ycVC3JjEXVHZqhUh7+HDSmivHwJ2w8kJPCtLodl24QM6Slv?=
 =?us-ascii?Q?ZXr49vhLPcvEjLAo6NSJTNA42SBPTk1bgxtLsoXq93E492p7MGzlKTIBawSY?=
 =?us-ascii?Q?JiMYo0Tyx7Y5164Bz19vonuXKrwjuPlskJpuW/zxIYa6he0dLnLG+Eucqn4d?=
 =?us-ascii?Q?VqFndIxxV7/W+uU/odP7w9/QowxMKvPsseahejRNbFNpCvahUi3h6uHa5jBp?=
 =?us-ascii?Q?tdQdqdRBzt86ya1rXh3hy/hTxLWptWX6YPG2uc16iXZA1uuFPRJkoBuqxskA?=
 =?us-ascii?Q?Kjkh60WLaWGDHUZGnDoWLqiWZdLRqOnMzkye0YMuzZhuiUjZwb0PAl/PhbiE?=
 =?us-ascii?Q?Rtg19DXkw4UIw5xzmkWsIrZo3srRs4UYaC9fMk8zH8QeaWlYN48oAHiexgb6?=
 =?us-ascii?Q?4u4tUYvgNfRIyAwz6XmONFjT+JEt3P4E6EM2kW46+VWTC8PKPL9cwUVm9LTV?=
 =?us-ascii?Q?+ZzZKKKccQjP/Rtd/Pn5ls0dS4EA00v0AoB9BRHhuy3aGMJYZnk8fuqlohok?=
 =?us-ascii?Q?im22FfrikEIObCqc8DklXxb+KXb44PdQaPrHAgCVx/MwOBu8Yb6w6o4Ycvpz?=
 =?us-ascii?Q?/rcoRNcL34cqAT65hZMl20xFRQiMs23PLv0v3ymGEzquK/8IFhYvsyPCzCOc?=
 =?us-ascii?Q?DIPOmwp846qDu4YIsvsQY/NxtYw1Hz0gbrIBZ8C2x7bonp5X99ckSWzjAgAR?=
 =?us-ascii?Q?W2H69TAKcW1rCgce1DRfwTS/+ODXFXqb8N5XeBhD10zOENaD/jd42ZJS4QJ3?=
 =?us-ascii?Q?1ocUEJfbVT7LVg5+fgjWNxsw2popw8m0dQ0k9Y1cvb5Ibko52VpdrN3N1NAP?=
 =?us-ascii?Q?bQZwq6USwjzed66m60AC3yROq7smikvZNnDoO8j4YjedHJ1IxRzHB6rvMhm/?=
 =?us-ascii?Q?bpHih3jnvcAWbPt51YbmEq8HS0MXc9/TjLa/NmvBWUVlcWIsYYNkBC54VDC9?=
 =?us-ascii?Q?nXk3TZrNZ70EKgLb6YGt5FmtUUFvfQ+co2MYB+yystaKjta+k8rynvdUwZ1u?=
 =?us-ascii?Q?JxY479nWSNhTMEIDFT85H5T94rOYYuYZnPBfgEfXCQFR//vx5L5ri0Or56OK?=
 =?us-ascii?Q?rqWXHaFmqgC2pr1BiHy/7JY971cYAdf5TQq7tQ39Mwj/alUuwQ9/Lbq3ak5L?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X6Xx4fsLnbBbBa/V1qgFHhHYIn1/Acb8eNsSdhTWoXWwn6ojG7xOyBcsulyKlYO1+R1ZGFoSm7g/9uibbTFFjQHtZtoinqvCg7hpjAq9yJTmo9rAxZQWIJWzphicvAuDVm2qtMAYKAucmtf/mGDV2BqMFLaJilQKGfpGIRU7ncFhfDXUnT2DwO2W0DcUpCdTB6hrVq8iC3GFq312AiNnyHyl+yjfxk97kHBGCX8Aq4fLp30TOHWD+b1NKY0+i2g+3L8uwCDkP2r6RpGGNkkhMSvvGLaIg4Yp0iQNjmgOGniqg5fbw+/Q24vE3UhPYWSa2Gkg2EM/TxeGH/jEH0igMEorDr1jYbBISAYf2xPA4QbGzjgkkXU4iZIoDyX3ETDeY8ZgaK9Igks7OtYHi5jqNGkCUaz60vR8Aa4NEnNjKtMmdsBTmQSa200Z8ytNPAaEZDn4IG9WhqnxrpcWTiDqAy3povQ+o6XU/FRYS1KONoND4ZONIqBmfECOyc5Rgxug3yNU/yUBxL+bUcY461ikK10qyT92zlSSLQsjOABJ0M+MdPu5FhGnq/BMXsFxsnJXo/TvdbRa+IgTzURWXnHtO1VuOWHPES5heJQ9nc41Drc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af28ca5-3dbe-4c8a-7cf6-08dddc99e4c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 07:52:49.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv2meuSEkxHk1iSYfVLhHBM74mRNGF3i4rigI6FRneGMssoVX+LQ9TCrTGqX0H5+igJpG7ms6tJsB1biLNZB9xXCM5UI2hJsBY8AmMjFj7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCCE340B80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508160079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA3OCBTYWx0ZWRfX91x4ZHnd/nwG
 uyg7Zr6raumYkx6oefJ3i/qC1/SrLvqNngRUSO0ldCK1Dr53R1fKcPhUsXFNw/r3oIFCUudqvc/
 PiN3pvl9IVeoD882ss/1esY7W4gOgTl7NvZ9QYZUTdkfTYAZwxyhUXXFwZCkwd+H0U65eK+6AdL
 4gOUFH+wf12HcTflEC0v+eTglh5FACqS558WGf1tNP/rZryYVamNLmYut1cWJhgSyrbMe6XMRT4
 yXySb092GoeIczgpwNOtIueDqNrv2oZnPEiP4nRK/tOosL35nEuJGCFwYAGJQRDtMlCT5jqbyKq
 LkHVAlPouUVCt8Reri7yGOpz672DJycu8YnJOd6khV6hbZwkLduyPip3MHOGGf49DawWa8raxlR
 lnSljNEpbcSgT0hqLsexSUiJvzaKMSNZHDWJVZmLz+umdGgt7mPcZXDlPu6J83+YD4X2ZsiE
X-Proofpoint-ORIG-GUID: n-R7F4gLTkNuPMqxeypLNF0rcoa_AGVX
X-Authority-Analysis: v=2.4 cv=arOyCTZV c=1 sm=1 tr=0 ts=68a038e4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=yPCof4ZbAAAA:8 a=hSkVLCK3AAAA:8 a=APlSODtWc97UeWhVmOEA:9 a=CjuIK1q_8ugA:10
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: n-R7F4gLTkNuPMqxeypLNF0rcoa_AGVX

Hi Andrew,

Fixing a silly issue that syzbot picked up, I reuse vma incorrectly, very easy
fix, fix-patch below.

(Vlastimil had a look at this off-list).

Cheers, Lorenzo

----8<----
From 87fc8e42946938688d637f694cd6e80552a26667 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Sat, 16 Aug 2025 08:37:41 +0100
Subject: [PATCH] mm/mremap: do not incorrectly reference invalid VMA in
 VM_WARN_ON_ONCE()

The VMA which is referenced here may have since been merged (which is the
entire point of the warning), and yet we still reference it.

Fix this by storing whether or not a multi move is permitted ahead of time
and have the VM_WARN_ON_ONCE() be predicated on this.

Reported-by: syzbot+4e221abf50259362f4f4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/689ff5f6.050a0220.e29e5.0030.GAE@google.com/
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

---
 mm/mremap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 18aa0b3b828f..33b642076205 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1837,6 +1837,7 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 		unsigned long addr = max(vma->vm_start, start);
 		unsigned long len = min(end, vma->vm_end) - addr;
 		unsigned long offset, res_vma;
+		bool multi_allowed;

 		/* No gap permitted at the start of the range. */
 		if (!seen_vma && start < vma->vm_start)
@@ -1865,7 +1866,8 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 		vrm->new_addr = target_addr + offset;
 		vrm->old_len = vrm->new_len = len;

-		if (!vma_multi_allowed(vma)) {
+		multi_allowed = vma_multi_allowed(vma);
+		if (!multi_allowed) {
 			/* This is not the first VMA, abort immediately. */
 			if (seen_vma)
 				return -EFAULT;
@@ -1881,8 +1883,7 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 			return res_vma;

 		if (!seen_vma) {
-			VM_WARN_ON_ONCE(vma_multi_allowed(vma) &&
-					res_vma != new_addr);
+			VM_WARN_ON_ONCE(multi_allowed && res_vma != new_addr);
 			res = res_vma;
 		}

--
2.50.1

