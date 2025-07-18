Return-Path: <linux-kernel+bounces-737198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40243B0A908
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624FF163865
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990472E62DD;
	Fri, 18 Jul 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LPrc8zqW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kb18Ad3V"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193426ADD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858353; cv=fail; b=KlGoYCLc9iPIgM/06X/QBqnRvkvyz4bpC8L55LJzIQyXwOf9/7JMY/fJ9fo2z15XkF/KtvD/R6i0e0TWdlHvCmJol3scJs+q/RDLi1mq4aabpD7O9Yqy/K+HAFs8/Jstan4Vig0589XIfhQONPZGpnQ/ychbl6L8QPCW7jqimro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858353; c=relaxed/simple;
	bh=KRjcM6z/sTNCYyD4PrsSPw5cgJe1Nz/2NHriyyAmc3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XLCey3Hq0uf+0tYP5ptlPhgCZUhzjjlJuPEZdsmbUG+wZtu7L/p8AGKIawcrk+8YQhundDKlFYLVkvS3OnWiZPAXyL9QAymTpXp63TKesHOcvVkcyRWCUSw3F7M63IH7QYchiJIgU+8SfMotRb+Fid62XGsxtU1MmvxGLPsSzYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LPrc8zqW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kb18Ad3V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IGtlwK003457;
	Fri, 18 Jul 2025 17:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=I3cLRX9c/QMgcbKolh
	aGa1V7scMC7nHHF2MrrOeUgrE=; b=LPrc8zqWgtb+pnzqsoj6kpy4QjK9c5l0bg
	9/8BwadXwxQUsHOMbu6h0lEX/PzRs9PrFcQldyGKCloCbsH4acYZf/IeiMjUwuSz
	jcwMTOAll7FHIu7B59ZuyzCSKXGSzmaLe9Kk7+kKu4w/0poSZkP93SEGKHM3K+sV
	KoywL3VKmv8rVeVOXYPOZyJDgtaqRwu76FGRGc1zmEU/WjzCj4FL54YwMh3iYIU0
	C3LjnJ8a3xa4EaYvlMb9LIsYKis2ztGknXFEEN3lwo/sFXlLY5nMsv6oIZfhWreu
	UcGX+mCJ6gLKdCNX+QY6gewsDhKVTsHtZYyZikMIwvpgUPNCdIIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g5jpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 17:05:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IFcome028985;
	Fri, 18 Jul 2025 17:05:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5e0nhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 17:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HB5NAVxvAWhqyPsqJ9y1PQscCTIXsks62K6b2rA/PrpNsVxrae5V4w+CAUfOSzM6Z4wtz1gO6ccm7j3PshaQS2CEx8y/y5iAEtp+r7ynvbZkep54X83wdEdlYCdQkbkBXhFu/EkeUBiJYrcN9r6RHXN6KfoIinUxkoaBxpz4Cm+7cAIMNWhXpLHD+hnOsD56bdiMnMdUlaqXBKhvI5jjdQnxZRnnPsBRj7JWeYhWtJS2fPXCSujJgQXJjsgkAPDLQwN4cqSmL+A5Bl0FjghvOklrt0MzecL2yfyI1h4+xH6EuYZchVcv2l9dNEg2OACJs3m+zowAoMQjcqKi0p4j0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3cLRX9c/QMgcbKolhaGa1V7scMC7nHHF2MrrOeUgrE=;
 b=p74Mfi/+nQxZ6mbYoU3wpxBmU3pGV3lcuprxwCDdEukNlFTnSMaRUejVKb+QAe1P1GUWOegVCWVBaaY8DbuoPNS57+6WgkMDP3ViMk5vq1NQi/DI6RIJ4eRLFur8WqXQG/T6XkbjQH0y6C3d5yy4WtkTsAvuwKzJ+Gst5kJuhQhzrPYrfkIPVjAjfHpxydOlDJL2flGEl8pLj9owSaqMWgPETVAN/G3ur3q+BMijnms3zYYDNa16/av/Gg6aE8MNeWtxz8v/I8M0g7l8FaBGmB7AtY4NsjZ2wBfXuKr5TWwvr8HyMift5xUAO5FVU3Cm74jCKDG0bLHAtr3CkGtnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3cLRX9c/QMgcbKolhaGa1V7scMC7nHHF2MrrOeUgrE=;
 b=Kb18Ad3VwKqRGmqosKkILzqmCSn5StKyWfKGm4RVw88gejStowcEx0j96GHEghYpzpjhmF0JA82vRRCfaMjP4kvEbFCm/wDBrwsKpF8NOWVeTOii38Je1LHtqDM48D/XadHnAi4dhQd8KZEdej+Nc1Xv1jVhlYXjT/FgqWBO7Ws=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5803.namprd10.prod.outlook.com (2603:10b6:a03:427::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.41; Fri, 18 Jul
 2025 17:05:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 17:05:12 +0000
Date: Fri, 18 Jul 2025 18:05:10 +0100
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
Subject: Re: [PATCH v5 3/7] mm: Add batched versions of
 ptep_modify_prot_start/commit
Message-ID: <9e0382d0-0a21-4b79-bd07-374729358ebc@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-4-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718090244.21092-4-dev.jain@arm.com>
X-ClientProxiedBy: LO4P123CA0561.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d7c306-2504-489d-cce0-08ddc61d4272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNNCQSqyKiChHYfQ5vkeDuMsa0KxU1C1Q1DP6ZZDlFs0gA0Y/W1fmjb/9v/5?=
 =?us-ascii?Q?5ATXH9eNKmFVK6rCSlfH84mG+wGBigDISK0kDRqYiM5dQJRG2aSnI+DlOh4E?=
 =?us-ascii?Q?CI3oX+tzaL5DU1KOrALGKVIrmMadGbcMNit1l28n1jn1MmKFbKT+Izonr2hE?=
 =?us-ascii?Q?o0/OpwBEFUS6cCHD2ZZmj3tEm/MMTue2jFxyBIo+rZDo2C+/WZ2ODMlukbwN?=
 =?us-ascii?Q?TDCvtgiBpFzFa0zO4O8j8VVLGW5mMQLZaYxywv/gKaxTyWNaFCCv5i+VYGUd?=
 =?us-ascii?Q?hc2SZZwmfAcacEQfJOXp3qcMLqDGVRbg0pGpQpVf5DlFSffPMhkRWAMMxUIz?=
 =?us-ascii?Q?hEOJgc54YToiPnbK9LR990rCfWr9v9fTF7VCNcNQ+nXR8Gr53nS9AeQXKT55?=
 =?us-ascii?Q?8Tp/XyYIgP9cVi1Wd6VYnzmVuvtWYOMOBsmUZ/aUyX1dqRFBY7eo6vXo1hZa?=
 =?us-ascii?Q?8fPJXjOtDgTYDieo1j9SK8fpcsLKIizpsYtPcAJLDiQHf60qeW/Wx/zNq/ly?=
 =?us-ascii?Q?CF6SDqQ1gALEXMNKxx++VuCUi7gxsr7oIxc7GkOrMwe59g7NilcBIfpDzQJ5?=
 =?us-ascii?Q?8jSjtlGbjVzLtiMDsn4b/x62jo4TK8bVv74SZlELf0qD6b3r3OyrWEDIM/eT?=
 =?us-ascii?Q?qq4zaGYRrBt2PGQiavZkJc4wac7z62b30ueitEahaFEfKUUQD/CxQUCANeYy?=
 =?us-ascii?Q?ymsIbM1/Tytmd7B9ZawAum5bS/0Cvp1/EAAk+HQGEDztD19rTKIQzF1hmTeF?=
 =?us-ascii?Q?Z0vaNfzPq+WXFormbBcGUSMoPR8wYK340tNlmC1woJIUei19fCu0sTYrIvZ3?=
 =?us-ascii?Q?EMdz7KVPohBKsQ8qTnHXJjkssYpVgbeHDbgFCzrMRMMHSAmBPPvOXo9SI+TG?=
 =?us-ascii?Q?Qf1Hwb1WCv1p4k5WhvnaSzh1k/DX3OsBVslkdyoyYtIvOWv7WGyH4KBLcfZb?=
 =?us-ascii?Q?3k3FACXVwvNe/dfOvE9PhjSQ5MFE3Eqwl0bGuPGAfht4KsOyK3mpIAs3oJaV?=
 =?us-ascii?Q?4XXBEulNYaDYFjKIB9EkPmhl/O6O/eyyBB473B5mBU/1gUcedJ2m3G9UyRr3?=
 =?us-ascii?Q?Tl+G5hJRgS+JZTh5pyR/+ETyOm08vNVwVmxMARXb1JV5VF5NBYTQzKuemlBI?=
 =?us-ascii?Q?IqIw6++G1j0AAPK9e1E45rQtvCvHNb2UQAbHGVNwzO4r2lFDIAZmNGsWOUQo?=
 =?us-ascii?Q?xo3JeHl1R9K4MNXz7s9Blmx98KKLwyzYvdiU85JpM8QDQXvA3hQOD4MRuPZk?=
 =?us-ascii?Q?+pbYf7R5+bB3IFWDWLtlVPA9UNvidAg+9YYaJsaIjwlylCVuqiim4ECacDJs?=
 =?us-ascii?Q?3M8jkvEgdfI40/xPa4dyiznMfkfJLfM1yyZeD1q7+8JPmSeOlVSSJutk/Mau?=
 =?us-ascii?Q?NaGgHd7yOuDco1mDgIyOHApN7lUmUxiZRhgZzVFexTsLuUMe+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lctxp6zS1ILa7QQzcKJypvlRCcBV+tFOcHze9UR02dHTv6cb5/bFnWqpxYrl?=
 =?us-ascii?Q?MVKd1liWRY12qQ2MAcWyVtT4yMuvKbB7NWUDPI0+F4+V+gsd0wmiYlb12j8s?=
 =?us-ascii?Q?TJsYz3T4qJkN7nEGFSBNz1h4WcePXfI0OrXMkKagWch3YnvJHr4xUH6ejE0r?=
 =?us-ascii?Q?tNg2SJcbFkPaZPHBVccDp4KqSJhGpg3QSBe3dsiu1PLz0D4NIDIEp2TmYQtP?=
 =?us-ascii?Q?A84/UaSea4du1oUmQNEfyfuf/aekFkyCNk+DrR0D6PYxCoE8VB0X0eANfq4X?=
 =?us-ascii?Q?qNWlF9HFGKblkGwVfUtJkmfkm6kHzOdsvvJVxelLteuATKvp7aRYUUY2TEPV?=
 =?us-ascii?Q?IhuJBHzW/jF0hvFyx5sOqLXPGCDSuBHRLNpOmZ+Q/KVrv3UqzXJfg3+7Sn9v?=
 =?us-ascii?Q?XfRfbqI2OL3Rw8WW7a3/t1IhJPGlq55oncanTTwhn7CTma4kmvCip12a3wSX?=
 =?us-ascii?Q?vfpJvjhlsHFznTQxxDeE0nRM1mtqVJbxuU+JgioXQDR+m6PpaJdRQWJJ+JmX?=
 =?us-ascii?Q?81GjQh4GoypdG4l6yO4jq4GQV0bYYKITetaCPGYD5SP57NqKnsuK4l6SZDP4?=
 =?us-ascii?Q?NzonsBxINcCctVKjYQa+FIY1nAD/d1YDngdnMO5eaTSSq2JiQvNPQHf1TDk7?=
 =?us-ascii?Q?YrxQbaQM5gjWvzE4tZkJc4fFEO1qVrpGlr1bfHLGpkhq25sWEFkHv9zS7q7J?=
 =?us-ascii?Q?3aYH54kMBhPw34k6u9Fr0hHnIYvAIFNjvYBzGIUoW8v8bUQLiKAm1Xs3/3JV?=
 =?us-ascii?Q?78NtxqmwUc84f4zxyUpbf3hRtOSSqiRa40wogAwpRTXX12J9pZS7lYxPC9r4?=
 =?us-ascii?Q?C1vbAPWXZNoyGCw03ndrW+ru2xDRz4bk/NgmQeDUaECvmnps99E83iRVYlub?=
 =?us-ascii?Q?R7ZHbaD9aX4qCJ4xPf3DN9q0yadD3KU/2je2uBEcSML+lVXEkEvgfVGGwOCM?=
 =?us-ascii?Q?F7HCMdfXj5DryBbcdIlsMIPcA5/kiVDDwJBWAQFUubD0M7Zbw2b5aYW4zvCo?=
 =?us-ascii?Q?x3LNmyurU8OeEd4H4Nno0FSoAPbBXJ5Z63CPg2jpDXbAy3s0AxUMcd5+pDPJ?=
 =?us-ascii?Q?rBl7K6vppBZD4djmMQe27decxE5uDIJXRTwih4PGRBSCkX352jN6zlV76J6n?=
 =?us-ascii?Q?RandR+9vnTbm3SUzkDSwdNEAYlmuS5FwAYvzDJl8KMYHzNN6HjKyqAwZcR/q?=
 =?us-ascii?Q?VUTuh5H3hJdymWWhd90i9XXD9ALHVfVX357lzkMp1kFPWqP22Z1/0IY3DOR2?=
 =?us-ascii?Q?rKhpWPPg4uvQIT+hphE0ty4a0vjDh/IYGzywt3E+PBZmEDBMLxfwXi88QXMC?=
 =?us-ascii?Q?mI8O4bLLNw+04YgB23A+Hyamzz7onwhT+u7Po0zqplWvAjgWCy+N9UAmEfIl?=
 =?us-ascii?Q?wvO3fSwpJTuA0FgVvLRzoT4+q7icRhJFv4WIb90s1KBu7QXGtAfsgFvuzYaL?=
 =?us-ascii?Q?Lsgt1p0l+Gff/pKNv1o5zAljLkXO95bL27qgqFJn9W7cFSGMgmS9/3zOUpNJ?=
 =?us-ascii?Q?2DIxIg+WZtWtIHK7mwzxMbs6IcLGeW/48ljhxZrftnWPut+uLTHqVbHKeVcx?=
 =?us-ascii?Q?YGQ9ig9ebXDhA+qWp9d9xYTExWLdsLNRHX0eEwyiAm//2nrCs8JGsXeqzvLo?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dkHmWQgP4Ji4M1hA7PDGtZkXrfHYtFYKcIa3vBv/az3XF/doVpRTMHkjVZp7624+jsQIfXh1haKsxy2ImQYT/tZohqo6VlRJZ7nSUFCBlcQ2gKW8a+mO5qqtN9xUYLoX5U0XQWy8mexB3uOxYBM6l0uv41m9UGpggfa17QOhKkbyjpMN43QQT8YNQAEfGMhsl7d+r4v4VNZLmwWTWRSJmQxKjkkq8BvYgE1F/sMOPkqlSYf25FmtZwnmOKMxTEj0PFub+iz+EK9MinaU8XqBasuS+rDaD4Qs7mAl388IAidZIdF7e6XQemKpFA8xH5YNrpgnAAJtS8Yu+wuIrUDnZDMUNqrTW65YfrfU/TqkRRT140le/1HisDAxyiH1sEFQmxGlfmKh/02Ssn7Ofh/NbXML49VB7kknb4UWHXyFYp6Kxk5TPoyMHDnNIbHDG5dj14J1fDsGHys3VM/FP95v04AYeyb6Tn+foBYxiwFVg61AYw5A+RoMWdYWqpVEDG06IZTTJzHWNeN6qI1IJouUWFmUqE5yoSnEttUtrjkvM6bqgKWDTLf/K774NW89oa5YzRvVOQpJnyYkq5BPpdNeYqKZF9WeZXzOe9cpj1oRxRo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d7c306-2504-489d-cce0-08ddc61d4272
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 17:05:12.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BisX8XI6BDKc4ijDbdwsNdC+H2oCayOxnerPpXd1DcvdgqA/S9HXO4Nq+DCaLwUVtj3ilYwKyDaQ62c6UJJWzc1EO+QQb9wDLdOrXybIY0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180135
X-Proofpoint-ORIG-GUID: zHwDHu1CSIoasOS4voAQEpIXevj-JJWR
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687a7ecc cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=VoO9Cytc3JEJLQE9W3sA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: zHwDHu1CSIoasOS4voAQEpIXevj-JJWR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzNCBTYWx0ZWRfX/dlM14AunnjY 1UT6kK4VXi5sH6x0ogD8GOUxw5d1MMVW4pqR0gsdHw15L77sg1242dsLs5q1aRAJ/jmZkEYxJe8 4rFQBO6Q1EwZqUQPiHh3+rG8cKkFyFv+RJJ0QP6e14n5l6fGp6s9mLQSdl6qd2SaDJinm9itAby
 d8u7lqAXD7282RzP+04IkTzVqqzNGAR8X3vPOCgnDvZXOHYyxtTeQMXw8Bawm0valztXFxMgSeT 6VBLS04MfDkr0GQY61Y3mK418nvvSc9ZMDgfQTPBMtcbZzgjU08MXc9xNd2VwIcDLO2p6OB7972 FG4V8p6tTYc0ItuLkWM3bS99eDoS1n4ppKckM5/adc/OYatfmjLNhuPmADQRxlpqcQaxmePtzj7
 ypNDX6zHLSu2LxoJG+AHSr61ICWbCCzB774hhgqeHKL8hqsOWuh7YgE3fxdgTIaUxijFfxBy

On Fri, Jul 18, 2025 at 02:32:40PM +0530, Dev Jain wrote:
> Batch ptep_modify_prot_start/commit in preparation for optimizing mprotect,
> implementing them as a simple loop over the corresponding single pte
> helpers. Architecture may override these helpers.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/pgtable.h | 84 ++++++++++++++++++++++++++++++++++++++++-
>  mm/mprotect.c           |  4 +-
>  2 files changed, 85 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index cf1515c163e2..e3b99920be05 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1331,7 +1331,9 @@ static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
>
>  /*
>   * Commit an update to a pte, leaving any hardware-controlled bits in
> - * the PTE unmodified.
> + * the PTE unmodified. The pte returned from ptep_modify_prot_start() may
> + * additionally have young and/or dirty bits set where previously they were not,
> + * so the updated pte may have these additional changes.
>   */
>  static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  					   unsigned long addr,
> @@ -1340,6 +1342,86 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  	__ptep_modify_prot_commit(vma, addr, ptep, pte);
>  }
>  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
> +
> +/**
> + * modify_prot_start_ptes - Start a pte protection read-modify-write transaction
> + * over a batch of ptes, which protects against asynchronous hardware
> + * modifications to the ptes. The intention is not to prevent the hardware from
> + * making pte updates, but to prevent any updates it may make from being lost.
> + * Please see the comment above ptep_modify_prot_start() for full description.
> + *
> + * @vma: The virtual memory area the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a simple
> + * loop over ptep_modify_prot_start(), collecting the a/d bits from each pte
> + * in the batch.
> + *
> + * Note that PTE bits in the PTE batch besides the PFN can differ.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio. All other PTE bits must be identical for
> + * all PTEs in the batch except for young and dirty bits.  The PTEs are all in
> + * the same PMD.
> + */
> +#ifndef modify_prot_start_ptes
> +static inline pte_t modify_prot_start_ptes(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep, unsigned int nr)
> +{
> +	pte_t pte, tmp_pte;
> +
> +	pte = ptep_modify_prot_start(vma, addr, ptep);
> +	while (--nr) {
> +		ptep++;
> +		addr += PAGE_SIZE;
> +		tmp_pte = ptep_modify_prot_start(vma, addr, ptep);
> +		if (pte_dirty(tmp_pte))
> +			pte = pte_mkdirty(pte);
> +		if (pte_young(tmp_pte))
> +			pte = pte_mkyoung(pte);
> +	}
> +	return pte;
> +}
> +#endif
> +
> +/**
> + * modify_prot_commit_ptes - Commit an update to a batch of ptes, leaving any
> + * hardware-controlled bits in the PTE unmodified.
> + *
> + * @vma: The virtual memory area the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @old_pte: Old page table entry (for the first entry) which is now cleared.
> + * @pte: New page table entry to be set.
> + * @nr: Number of entries.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a simple
> + * loop over ptep_modify_prot_commit().
> + *
> + * Context: The caller holds the page table lock. The PTEs are all in the same
> + * PMD. On exit, the set ptes in the batch map the same folio. The ptes set by
> + * ptep_modify_prot_start() may additionally have young and/or dirty bits set
> + * where previously they were not, so the updated ptes may have these
> + * additional changes.
> + */
> +#ifndef modify_prot_commit_ptes
> +static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned long addr,
> +		pte_t *ptep, pte_t old_pte, pte_t pte, unsigned int nr)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr; ++i, ++ptep, addr += PAGE_SIZE) {
> +		ptep_modify_prot_commit(vma, addr, ptep, old_pte, pte);
> +
> +		/* Advance PFN only, set same prot */
> +		old_pte = pte_next_pfn(old_pte);
> +		pte = pte_next_pfn(pte);
> +	}
> +}
> +#endif
> +
>  #endif /* CONFIG_MMU */
>
>  /*
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 97adc62c50ab..4977f198168e 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -204,7 +204,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>  				}
>  			}
>
> -			oldpte = ptep_modify_prot_start(vma, addr, pte);
> +			oldpte = modify_prot_start_ptes(vma, addr, pte, nr_ptes);
>  			ptent = pte_modify(oldpte, newprot);
>
>  			if (uffd_wp)
> @@ -230,7 +230,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>  			    can_change_pte_writable(vma, addr, ptent))
>  				ptent = pte_mkwrite(ptent, vma);
>
> -			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
> +			modify_prot_commit_ptes(vma, addr, pte, oldpte, ptent, nr_ptes);
>  			if (pte_needs_flush(oldpte, ptent))
>  				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
>  			pages++;
> --
> 2.30.2
>

