Return-Path: <linux-kernel+bounces-730727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7EB048AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDC73AE340
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F63A2367DE;
	Mon, 14 Jul 2025 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VyQoefLE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GvdO9Gec"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FD367
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525375; cv=fail; b=WzpS25Q/EeX5LKH9TlFCP8T6mP5k27Fo7fRUi4IiMURtBFJFFVMTrOGga+jSwURbtzEtbP7qGIj+DY57rjHpa7GUT/j7m9PQk+CwJXewcbh32jWz2NlyDdrhwZvc0W0msMPulw0+OwE3jpYXOx7i0BAJbfZsA8R+Kt1tn+0c9Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525375; c=relaxed/simple;
	bh=cxgPgnl/9My94dejTlHZyyTxZdE5WWSC516gzOYRFD8=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=S6ln4e81JF8Uys9/EzMh3vMVyb6+xf+9nzXUblgbZXfRLgVMf/yDHgeg/NsaBEsUWS3Bf1+kmAr0ja529zu1v0fDf/FAyRw4zjJOWq6kNW2+NTCCFR5c4GbcwL89TerL+fSB/i033+WHfip/siT3HbBMcP20In4vuxnTTUCSfLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VyQoefLE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GvdO9Gec; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGss0s031168;
	Mon, 14 Jul 2025 20:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4/AnLF606ZsX1EV+NF
	KitsiRSb2inZdP1x8DuLxsS0g=; b=VyQoefLE8P21fWNtAI/ncj+qf2+nJpu9tn
	36tJpzexyZvmMxQU4RpsE9EJUGLEMYZYeFDn0+04FyVt6ARuOFT01ELcm2KfZCWp
	z7yAB0j1S9XsqiMp1VcP4ZoMhtEwQvaiJC7flV16TftmN80yoWTqxebDBK+PXPCs
	mrMWFsWskbbjKZRcjVk8F2GWNDlVrXj5PR8Jm7FIZsojZ1xyxRsSJBBC0l4Yl8Sw
	5AAKIKaJKvStHPQxF1em7sS9c2YUoJYEmpiBuGCZJp8rNpGhwCCh2gQ8308mKOHJ
	K5ofuHNL0nxKD/l17tmdMuXZylBIkSnr6fpqJvICwMzkEYhFEl8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0w40a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 20:35:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EIlEoB023762;
	Mon, 14 Jul 2025 20:35:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59257b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 20:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODsDyZ8/8huGqPvUwxLuf91D0JaUqzOKUORS/TI1uyWhPM/Ow76QUmRfO9cK7/hyPH03xKPZvF4RGh+N1JMz1Uat+Yba0GtEquDhpzrinItjS/CEmfMOwScJR1VdinxmwQ8QHI3GhysfGrI8SG1C6mzax95hTH8uhBiVkN8oEnINzPMVcNLPURoUsvpTM9rccoP4xqzxVt1xXGZyUCXEllzSLmGDeWQelLh5jN8dIl+vcA0XlHjeKZ7W1MSU207yQGcJjk0HVNULzL7BhZ8ac5B2fwJL/FNawFtJ5/MipTO+Ong6CBvrqraRB+x3nivYRJZ3dpbX+htw2EniYu8HBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/AnLF606ZsX1EV+NFKitsiRSb2inZdP1x8DuLxsS0g=;
 b=jld+LS3895iHZzuBTOEh1eX0DQmUVsOxH9S/rtWVPC9WdBgGzVquyhINrG/w5QvVCJUzB6KmrzjvhgW4rkEInXsvjtbSY3GPwH7xJbsLdXPJzieqW29ZARiAYU9GFCPsid0qSnsekNdLAU+2lKuOAWu8X0kBqXYGEXwf1cQ0QbyVUTlzcf74D6dIWdqyyW0UT+IMb5yGlXzBZ4en8ii2WzyZx90oQUYBjTT2gcQDXLMj8N4ZEZupQ/jZWxf/bnAnzVopjQuCVdU5gG7JXiHVRY2MXkJIMIWgFY/+QA6tINtgcSKt3gy8ZhvomP+i6SokqEIGr9JCLx7vrBCMyw8wNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/AnLF606ZsX1EV+NFKitsiRSb2inZdP1x8DuLxsS0g=;
 b=GvdO9GeccL6TTtq6sFUYQ27LV3cnu7mgwag3AWAfw3K45AElPq3K1T4QBAOPkhmsX2ns20rf59G1tGwmQkd6pUEHeU9lvPL+JBosSo7mSHd4ViVA1mFE/KY6yMsCLkCl+fsQ4BgP6JMJXPL3hBK2pItnv9AvZEZiaxB56D2HClw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFCC3E08AE4.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 20:35:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 20:35:38 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-13-ankur.a.arora@oracle.com>
 <fe138d11-e0fe-4e57-8e51-a5521bad1b88@redhat.com>
 <87qzymocok.fsf@oracle.com>
 <9865895d-c9bf-42e2-b813-bdbd39ad3af1@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ziy@nvidia.com
Subject: Re: [PATCH v5 12/14] mm: add config option for clearing page-extents
In-reply-to: <9865895d-c9bf-42e2-b813-bdbd39ad3af1@redhat.com>
Message-ID: <87ple2jysm.fsf@oracle.com>
Date: Mon, 14 Jul 2025 13:35:37 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0026.namprd21.prod.outlook.com
 (2603:10b6:302:1::39) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFCC3E08AE4:EE_
X-MS-Office365-Filtering-Correlation-Id: c1157456-d6b5-4c8e-d29d-08ddc315fe1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5tn3s3/dekWLw97KPwIZUlVFYLxA6uMlqGVAJqP6s8nfNxWVufsVgNYtadhJ?=
 =?us-ascii?Q?XiNKQBVqxI9L56dOHIdUTuoXuY1B7KqlOfHDndL2BmPKdeB/kcHy0Fzk+eOJ?=
 =?us-ascii?Q?KCiofYQrSSD/RyoAdY3QrSfcn+/vn0zrFKe1ZpsxuYpve7xlOK4iR/fu9nYf?=
 =?us-ascii?Q?0IZHqEkwAAdwPCzmuqAKqBaQG8HpyIJX0EqplEqHXHcpeAHw0YR1ega2k9+V?=
 =?us-ascii?Q?gpoND3q+SevMzB+jxWQX/Wifk+UuUwy+ZwMJMDk3UiWXisVG+T94Vjh0u8/D?=
 =?us-ascii?Q?tTqHLevhx7C+wGyNEX0sfmDKNoPsDyBi0+1LxCm+RA9WcQsREUpuU0TaZss/?=
 =?us-ascii?Q?mmc5y/uTW+hA1TthpS8hQAERwQLd8sch217sGmVoe98TdgE6xUoGycrWkM54?=
 =?us-ascii?Q?0Hdup8u5vC3kx/Y3nvYO3pp0emAHhuoXbWZo1lb44T2ZXRn52aI8NnH86g3x?=
 =?us-ascii?Q?1szl9L8kMr68iUVcniUuSyj/oUERqp131iPewXF8N4IXqyk4rtVvzP19tiz2?=
 =?us-ascii?Q?AF0LK6ofByIFohCAZVa1pWXHuBmrsgJnFSQxx6c+G2BLGU+SfoyGF6MXtVKL?=
 =?us-ascii?Q?9oBpgoMbuZaOiwyGWwxzESwEXTc7RBB9KK80nbFTL/DLN7HLepsPHRwxY+Ni?=
 =?us-ascii?Q?70dDGUXfpwSkks0lst1Mo8eYqk5TLQiXaD7C8GtN7L6bIyWCKbD6XtmZN90N?=
 =?us-ascii?Q?gS05mXe+vwfMN8+nmkf3L2NsbAFl//4dQYaG5sdHFc5PjPsGrI0KkCY4IWHG?=
 =?us-ascii?Q?qS88HDL4wzNy102lAYaB7uwpPx8zkysxAo5noxAyQQFAUVTIkEIHvcnXYDGc?=
 =?us-ascii?Q?WDUAQkkwn93f4/8YFgl8y+78G8FfSpqAZZsEHHzPHKWVbqPHCXqy9BgnElu5?=
 =?us-ascii?Q?CcFYF9RNVR2lzgnEbosJkldHs4O7VC8wXyVHhmDvY1x5V8lIFMwJWY+IVOe1?=
 =?us-ascii?Q?Oc7Hh/T6OSafIPfVLUPnYyhaSJaKqseTZg81e8pKOdMmx0fMcy0xgg3zEDkF?=
 =?us-ascii?Q?9i57n9amSYcwe/nunFODi6Q4ItaKIj51kM7vHFwWFyooNgdmHxcE1GmFadqw?=
 =?us-ascii?Q?3F+dxsAiDxuXcZyy8qMtK8FISadB9D1HVi6SIO8uB3vvG6MIKHeRM/cOcNdT?=
 =?us-ascii?Q?bsed0/I9zoq0kcjaIBgyOVXN7BRMUwwHZdW3sDxgoUc7jrGsqxCOMYnv3iVd?=
 =?us-ascii?Q?zGpiuAIClYCCDp1Csz4YVn7A08PrKclyH7xKTHoG0nJ4hKgouOf5GHqhMP80?=
 =?us-ascii?Q?EfAQ3f+JMazWll84a0FKnZ5Yt0Jz+i6ITEMwAO74byPOX1G11Rmr4ql88ela?=
 =?us-ascii?Q?UGjS40Iua+gECH+pYppn7xAAm5y0+/MejgpxsQ7d1riwmsTVhtxj9g0/ObiS?=
 =?us-ascii?Q?/QqZ1hPysIpX+nWvrKYPmydombU8p2+Z1Q8uko49daEUKtD2D7+mdUH+gozz?=
 =?us-ascii?Q?7nSQiNgsgMs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DeRWjy7S5M1TekvjtximqybYXkv4n7V3lq5t9maGGEQ1ngL8pzGw95xSjS4p?=
 =?us-ascii?Q?qWiNYARhPnCqXzGElQqCKAD0YFQlWKhGslgpV31JwVQMQL5FjW3bYt8sTq87?=
 =?us-ascii?Q?J3HUmboN86SIJ7rYcBp4vIqRaywS1ArHl41B3MfJj3Hjt77i73pLgWn9tueH?=
 =?us-ascii?Q?kS68QfIvyJY9bwmCwYTo62l4/z56gkHy+ZIZ9Wbi6VPwf9/p6XWm8MRwBBzB?=
 =?us-ascii?Q?10OJI3bJulyprRv05nSYzQaugA25NHr3jNq9AZgsYOhooHqp0jqpfFXQKBKg?=
 =?us-ascii?Q?UBT2hF/S9NkImWtFWVT/rATA7jQ+mvqgn5EyLerXOZpsH0UePqblm+Zf2ypD?=
 =?us-ascii?Q?6i+5B00/AFdikpl0k/DS5sFhZ8vwQKfQgJyO4CTYxe+kIwUuOkSbpWyngxQ3?=
 =?us-ascii?Q?bYMi/KmxLKBRIkeT2DtHzOM8DtO7tnxECKVqcXPz9SN53g6EA2XAGsqoD9P+?=
 =?us-ascii?Q?Ma0CtzqzSejA0jpitCs03K1XtO2llWGWeN8yQVeliUXkqvjFrGpJN2pc3RpT?=
 =?us-ascii?Q?O/guDD+CUkDWDb3Gyjrzo6PxHE1B3j2a3R7CEXNSz8Qh5TYLhh+7/3bYSaeE?=
 =?us-ascii?Q?huUgtNI2RJML4SEajh7/pK/MjjcVcNefRSi/oYAscB32svM33QK9uKDde2AP?=
 =?us-ascii?Q?CD14gL4kACg5SC7iRIWlWUyrGyyMhpiKCLyC5/gk6x1jw21z3lW/GT+xrr7Z?=
 =?us-ascii?Q?XR/0R5E80LNzHOFxi7eME/w3gGqun6H1ofMgOqsTyRtCyJnNSe8OIhb9maiU?=
 =?us-ascii?Q?dS/tsYTQEd4UZW26UEuE3c5mbWbjzJRkeOOpQQu2jNMupVWhkMUJej4v15yr?=
 =?us-ascii?Q?eJGWJ+7fGu8kIx/rCrqOURqqTE4gGonChUdLtwVd5bUMxC6OzIPIFd5q/w9J?=
 =?us-ascii?Q?A/1ZTfJ3bwsmCM/RViPfP3fnXD6haY1k3dPvidAyNEIM4uNSL+0kOxa4w4Ep?=
 =?us-ascii?Q?If08CdWfxa/e/xjonnDDhXcV1/syl0ySDCRTDmxTlm6hf91sjyAYpjM6XxkO?=
 =?us-ascii?Q?Vuy2AXNAgZjU0CRjk8hBBDJwwm7US/cmK8VTY+9mNKE2PtLDXN8Vp0FZegNJ?=
 =?us-ascii?Q?kiAxiNGbamTWoENwyH8QSckELaqVp1FG9jKGdiEJVPrwhumZbxfbnpjCxiTU?=
 =?us-ascii?Q?PAXELYmhSQlTN0/LTuYk089LjEedCmQxyFmV7NSHGpaoyKrvvLsUrPB6pp9L?=
 =?us-ascii?Q?85EahxZzFPe+gEwoYifZ0vPZ49pCUJlvhKZfrkDERxYFV8XUCNLwciIm4Mhk?=
 =?us-ascii?Q?hLgYUMN8gtsE8NhRu5Bm/SFIjkuC1zbkHx3izOK/rZ3udNSb1o8VIvDYG6w2?=
 =?us-ascii?Q?N4pggfMOJAQXerQLOkPfx48DeOtKb7s38XM2/B0eAc/yrvHowg8vcHrHzvLK?=
 =?us-ascii?Q?cVleblGr/rGgMAOqbAeZxeY1MTNzl6bPxm2Xb8PIv+Z3WRoblJlHKR8rGxV3?=
 =?us-ascii?Q?0uNVaHTIR5Ehx5XhYjMfC0OWLUco86jF9mprZsrjWSr39Mzj5/25i0J2NuOU?=
 =?us-ascii?Q?dri7LZ4PFpOAEhJrK7ed/pwYh0HJNjtq66mYVHmd1UrVMoSbpdpJp2HVBI2B?=
 =?us-ascii?Q?cAFNS6GpjyCzWRDqiyiqMnl5JsPzEHv50APwE/Tp21jK9O5Ji7uVaNVoDl2+?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MZWTQWtccH1hMD77c/QxI2qQCSe1f27keFzzFam5/ZiAk90eS2/w6ppMTX7AoJRZ5GougpL63emWUVHTTjDjiYdwua0XxfWVtdfsFGlHxqUSgH8rCQrIENX5Yt1PBeUYMhQGxcWDD8vmHxku3aYgSGh4Y6jCdritdx6XBfMiVfcgyvjq0VCmPMkpspVQnz536hK1+JmhZTcWxmLuAXB7ctOOyR66P/SRogx5JLmJ/os7qeoMg3aCg8Bp4bndxksmlDRuJ/GS/vif8ksisHSXbki3vRieyaFvziZUmZw5KngajXmqYfECthCbzioUcI0jnxLV3FbrhMe8/wyfhWaeVSAXoEg7cQOqAThW10mPFG8+zGOqNvn9ocMXxYmYic56zS6Bz/mbSTQGZawQg35tn5Acqhjgqo34ek6jj2FYWd9RNNBsi5iz59sB7VIsXO12I3RpuvcTDW4ge4asHbekdA9kKkvyShDdnp5jEcv/W2T8wwMrCRpwAZbetuW5oYD6tI/U3Kr9988DCYUJLKVrDEg7ivSOXd7tFs5VRockb/dPoRtnqQZx6o/pmSCCTVhIrg7tF7n4Qce1dZyEs06xWxRrERdo+pKAaOgVaa736qE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1157456-d6b5-4c8e-d29d-08ddc315fe1a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 20:35:38.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl4bQDdxoLoZ6Xe9W3LNoazvjBmvFqIHHlrvgOA+DrxvMZKWMbDIFZLMkx+J0a4mFslcqrUN6J5NhbwZrNGqCjoPZ3RLDprcV47H6KQng1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCC3E08AE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140137
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68756a20 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=5gTFVFuSgBvqhr89u34A:9
X-Proofpoint-ORIG-GUID: qnx7t0VFibwnQWxRHvBUuUXzzDJWs5b6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEzNiBTYWx0ZWRfX4lJlale9yrF/ N2ZHMxilP4Kf9eX+SNxsIhMkGDxrDX7SKK5X0LAfn1C5BTepibOEdI6XceOQeen/JhW9MiG0cZr NRmKtgyQVrApqt3qSsKH8PeB3m8h61y6bzqUbhsjZbfdDItZCuHHQs36AJqx5SBcBVuvRdgShWe
 gtriZ9iyAjkZpRM7VLHPm05jgLjMhlDOHx9ETBQTrZEwUvIuoYI2umUXLocwid4s7kWtaCrrlos fU8dlggnr/V04BG5a1cAE4BJer2jM0YXOGmmBZ+L/fm/s8s437FGwUOuhI4+Arugyt+YqzoBD1g 5ZE5ZmmySJgs4i26FAgn6J+UWnJsi2k4yAbxRgPtcjwDYqin6lnzJwNrKt1ox54swo+w6K2MkI0
 eV7tuOS2lVpGGkQKjnqgNvSk0aPgTMdZowtIa85zaXRMdMRAb1KdBWkwxrmIq7T3yHH/o5oF
X-Proofpoint-GUID: qnx7t0VFibwnQWxRHvBUuUXzzDJWs5b6


[ Added Zi Yan. ]

David Hildenbrand <david@redhat.com> writes:

> On 11.07.25 19:32, Ankur Arora wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 10.07.25 02:59, Ankur Arora wrote:
>>>> Add CONFIG_CLEAR_PAGE_EXTENT to allow clearing of page-extents
>>>> where architecturally supported.
>>>> This is only available with !CONFIG_HIGHMEM because the intent is to
>>>> use architecture support to clear contiguous extents in a single
>>>> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
>>>> which excludes any possibility of interspersing kmap()/kunmap().
>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>> ---
>>>
>>> Staring at the next patch, I think this can easily be squashed into the next
>>> patch where you add actual MM core support.
>> I wanted to do this in a separate patch to explicitly document what the
>> responsibility of the interface provided by the architecture is.
>> That said, the commit message didn't actually do a good job of doing
>> that :D.
>> Copying the more detailed commit message from my reply to Andrew,
>> one important part of the clear_pages() is that it be interruptible
>> because clear_pages_resched() implicitly depends on it.
>>
>>> This is only enabled with !CONFIG_HIGHMEM because the intent is
>>> to use architecture support to clear contiguous extents in a
>>> single interruptible operation (ex. via FEAT_MOPS on arm64,
>>> string instructions on x86).
>>
>>> Given that we might be zeroing the whole extent with a single
>>> instruction, this excludes any possibility of constructing
>>> intermediate HIGHMEM maps.
>> Do you think it is best documented in the next patch in a comment
>> instead?
>
> I would just add + document it as part of the next patch.
>
> Looking at the bigger picture now, you introduce
>
> 	ARCH_HAS_CLEAR_PAGES
>
> To say whether an architecture provides clear_pages().
>
> Now we want to conditionally use that to optimize folio_zero_user().
>
> Remind me, why do we want to glue this to THP / HUGETLBFS only? I would assume
> that the code footprint is rather small, and the systems out there that are
> compiled with ARCH_HAS_CLEAR_PAGES but without THP / HUGETLBFS are rather ...
> rare (mostly 32BIT x86 only).

I thought about this some more and there are a few other interfaces that
end up clearing pages:

> clear_highpage()
> clear_highpage_kasan_tagged()
> tag_clear_highpage()

In this set, there are many loops of the form:

   for (i = 0; i < n; i++)
       clear_highpage();

At least some of these (including kernel_init_pages()) could be migrated
to variations on a clear_highpages() which could be:

    static inline void clear_highpages(struct page *page, u32 num_pages)
    {
            if (!IS_ENABLED(CONFIG_HIGHMEM))
                    clear_pages_resched(page, num_pages);
            else
                    for (i = 0; i < num_pages; ++i)
                            clear_highpage(page + i);
    }

(clear_pages_resched() should be safe to be used from here because
everybody using this should be in a schedulable context.)

(The kernel_init_pages() was also suggested by Zi Yan in a review of v3 [1].)

> clear_user_highpage()

Only users folio_zero_user(), __collapse_huge_page_copy() and
userfaultd.

> clear_user_page()
Not many users apart from the highmem interface.

> clear_page()

Not many users apart from the highmem interface.

I'm happy to do this work, just not sure how to stage it. In particular I
would like to avoid a series which tries to address all of the cases.

Maybe it makes sense to handle just add the clear_highpages() variants,
folio_zero_user() handling and some of the obvious users of
clear_highpages() for v6?


Thanks
Ankur

[1] https://lore.kernel.org/lkml/AC2C5344-E655-45BB-B90B-D63C4AC8F2F6@nvidia.com/

