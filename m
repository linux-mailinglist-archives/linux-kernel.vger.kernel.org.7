Return-Path: <linux-kernel+bounces-808892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F68B505E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81461B27DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F774303A01;
	Tue,  9 Sep 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JUQtA/sN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VKoqu772"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091E1DFE12
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445035; cv=fail; b=ibHwmCKWdc7u8R+gC/xoLwTw+apEYm7UJPYWuHTeyA6ovBfUgCVcvMkMtZpXIo0XwdHNO7KXdb/4RNs9CtqKxG+GikNWaTVPnlJ01C6Sq3QntZdYRSBO9q/mAqKtAhUdMfpZpPd2VAa4y/5urfKRBXbUUYXwm9JNKEtXKNLD32c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445035; c=relaxed/simple;
	bh=VXr0zwWnlslFSz4I1tmH+5J8w0yiBx3onN3zmH/oXlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PQb4pCU9NBnxrfPSKmToJ/N2+caKgMbrJiHhH1tSOmC0oCHbdRpz7mPYA2rxbOxWqQte/AEDwhvcPWNTGFZiFJP0k+TEJxFa+ZwpSeWZCdjXvxzi2sfiE3AUhKuRtGEhvtUM+RK8ag+FKhx6jsTqGfct9JleejHf54+rcJ+jEmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JUQtA/sN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VKoqu772; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589FtgWo020291;
	Tue, 9 Sep 2025 19:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mEEePusihNpX7da3SzTojd1qJc9pT0Qu9LVSHOZ2qSo=; b=
	JUQtA/sNvI2WozhnK2LYC2tdBRicuLLjn3dmXbmj6oES5SxAduBx/jvMlB5DjsLH
	JkM0EirAHiLSRYQ02GFnCmxHFYIbaHgC+17KXilFA0538WoVkjyo1bGoq9vi+2LZ
	GisTZJWIcUjLywXlpjk2cilVinO6FHevI/pRcoLFdwzCPhk/yoivIF/RTGVV/kHv
	WW3p7/4peGwA0hM4qglKddcRc0VY5SP3pvtN9i6n7yj0xd/LFBgoWshSHYL7XrLj
	XSu8q0nik9JZZrSNzZbO7Ir6DGy/l3PgWyiAtbmbnKT43UO4iIixBv+Szvt7eU2C
	AwXynVBHMoryS+qJcsNyzQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shtjd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:09:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589HFIqr012871;
	Tue, 9 Sep 2025 19:09:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bda8ett-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O//kPNLdBtcn1jHxWLrnlA0f9+/95seNopFsrR+gscI9X0Fj133TJtvsHqY3dcpGdJyavGk1CYPFyRQt/sC+f8FlpIvJtnp/LY0m44Q7oYuKA/s2IWuU1g7z6uqnKgYVLO8cL2rH+2lS1zi4zmWnt8K3pnnvqRBa+8Y8ZKghPQQeGN3nm2uYPx2cHHSXUb/W7eJceYWQMPmg5tYkmAgZUkUb10veZLsjjIefVrsrtwPMY256/VnzO6y9D83FSo/HsJoRcqOJh8HQOjzTIBRuBqiSThqZesTXl3MjHQd7rOkF6y7wGstl1bVExMnZoEeM10h1C8a1dwPBkoQDyHXpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEEePusihNpX7da3SzTojd1qJc9pT0Qu9LVSHOZ2qSo=;
 b=o3KzAv6VTg1EZW7OQ2aQk3DFF2RaQ2ZH3Y6YWu1wKOp1tgZB4tz7VMzp3JGVAltfZSJ4DLcBv8ds2sSaff9kDBfpFr5+bjKC4fuFvKqdU67+ffxQmYvrW7zYNsYjjnoAlFBje6aUdXuaz5U5qSFsyaL0FNAjjP6YhVL9/GwswhhciNEGE2zIvGwOM4S8mONDdbgBolurxoFayl9Vqi7HZBAkZ90kfFmicUY2b/OPdMTBOuYQuPWzbQArQOlSSfhh1rlVOA33yWArDp64Xv4cpKMDoZYGwtvGY+3P4GAVBWT6f5zpJQpLlVAwm2r4yRSNMX9Y4z8+wbnNrSRbV6lW0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEEePusihNpX7da3SzTojd1qJc9pT0Qu9LVSHOZ2qSo=;
 b=VKoqu772YXNGGMfZP39syUznHfm3GWqRexVOk8fmwKB2J8NLN7nXB1tt8bBBL9HyNZKzrro8XC8rBLME0EPwz7Sx1Ik+CTXuu1FsllowpOIE2Z9VLfYr4JhaczXnLr64H+Dy6/Dh5xZIYsK9UQ9e4vlrZuT6bVMmLPrYHjQaz+g=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB7052.namprd10.prod.outlook.com (2603:10b6:8:14c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 19:09:51 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 19:09:51 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v1 1/9] mm/mmap: Move exit_mmap() trace point
Date: Tue,  9 Sep 2025 15:09:37 -0400
Message-ID: <20250909190945.1030905-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 0468cccc-efa6-411b-937f-08ddefd473de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AUvlZRkqrHPa9FsBX4NjqBiqbQmsXvhzBtxFYQoxxhOCOHlJxXTbhxccMPMc?=
 =?us-ascii?Q?IiMiN04NhWrS+8C4Ldp1/Y+jV6+feZ4fpophy+1iGibRnmy1LukHmHwLF3OJ?=
 =?us-ascii?Q?jmSTLqhhAE5jOmOdQ6zO2NKEQenPlxUJQ8wRnrvTJMZZXKZAxIlwHtgWWydl?=
 =?us-ascii?Q?cMfAOebkurOnQnAj8l8Mcys6VecGuL4iLv+l9v0ckMxn6aiintg7ujlYSjDw?=
 =?us-ascii?Q?cbGr7dFgQd1cbXA5n869jkJbDjfWHpUmcHg82qWavSEUS7Q9zMMZiAeiW8Mo?=
 =?us-ascii?Q?TIKpSbxUiX+7XfRKExSUN5DdS5sGHHYAQH7f7zvmNBKa/ndqQXqeqT4SKzFl?=
 =?us-ascii?Q?UiPKg4Ti5lrS2f+NL+dIe6QeedRtamJwpNERNiQJTmhoDokDnn6JxG0cnsVU?=
 =?us-ascii?Q?Ozd5a+MKklWKa7ssi5KgsRvvKJyr3DHSMZDsZuD961SZ/QCxOGFAFpuYUVEd?=
 =?us-ascii?Q?mT5LlT859/+vy7L6ssomNOcVTRS16JJiobOAdRLPjV/nSjXZj2YKUkZR3F/N?=
 =?us-ascii?Q?ARyRNoZqmhX74m4KnhBgkgv1aVOKpESASiwsBJY0UYKk9PhtoRJd+RIxQO/z?=
 =?us-ascii?Q?rOwtQQietqK3N3vyH/TtDw+VgiWj3myRv00eTKo2xnkZCm/YVga/CgM3TYIN?=
 =?us-ascii?Q?4aq26720EPXyeHTV9jL/as0jRBEnWZ4pWzptdD66wo2vcg/X8KmVre5oWuuq?=
 =?us-ascii?Q?S9A1o76BYTlAQx3wjXmEhOJFUY4wnjL7FVppgFGDRGUzSBEhG2uPIYgbDmEi?=
 =?us-ascii?Q?hT1NJTPR0UQWo+a25/J2rS4hLbGcAKeNBaFZuPx8qSj5K8ZxYGuAMasUFFIL?=
 =?us-ascii?Q?k2dPwxVxuuGf2w6KJEY008gUUBG9dHWSV+Yp9v0xnfguYoLkzU6t4PlT+DWL?=
 =?us-ascii?Q?dktQoKHpjh3JSBupFu2b6rT5dOtRq7zGz0xQfdmHIhft70zdriiZuy9Zr1zt?=
 =?us-ascii?Q?mAqEPl79fVy+AXhr6EVdR/SgRTlmf0P9xWKCbJz7nA+48Ho9ySv4bAcC9rCQ?=
 =?us-ascii?Q?62xZp4dSCM9WM1fS+mnlOMyNBzN6d3JRoZhdLe9O0y/wNwWDWn/gtqPGe7Zt?=
 =?us-ascii?Q?CF82UQJjmAtcxYnZlGQOqFkUWUGx+9D2hBuW6i8HYXCoV568NYvDyoC9UUq7?=
 =?us-ascii?Q?hahg/VSOwRHJ+77gG9rIQP2SAC+opOJ3kh0S83BGWdSJhsETRVMBbiQvuTWd?=
 =?us-ascii?Q?qgXXAzbSxRdOl/9LOG7H+/fPHyvAHqzkP+t5cIKv0Dv3yBHOXjf3pLltpsOo?=
 =?us-ascii?Q?Nk0h3y7IKXjTNDHsGdD+ODChbfTVywN9s1+uG1Ler8d3g6iyzoOr9oomkvwQ?=
 =?us-ascii?Q?YwAQdCCGLD4LR+a3GJLmgHnxBQmM0puaT3l4UkokGyyduprEZmfV20nJVNGW?=
 =?us-ascii?Q?9JE6TXQPB8qjUIZeWVZ0F+OcLWths9n9929c5ozaOffKdYZSmDC+gk2HGL+A?=
 =?us-ascii?Q?HKgz9qMRjVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1ZzvYAoEHU7FgFix6jKNbpjWRdt6/cjSP8swLfHx3CnhFDalq2WS9B271Fc?=
 =?us-ascii?Q?kvIhs4l/eKYkPp/hhKbu+Z02YjZVZ0PWGKx3LJZpqrcDNmlOFJj94d7oSXnh?=
 =?us-ascii?Q?DsQSB+Ky6XvZE7+nX/XpryoSl4G3mvc7N9+Y/bHp8AI9UOxKRKv2Ifjw8inz?=
 =?us-ascii?Q?4HoG3FfL+9ldeyPdFKF5zcNUg+tGCRCUIP+dpSvgW7USyWlSsYbOMPZHtxCH?=
 =?us-ascii?Q?6kl845cda1eyNTgC5RrIFVwMm5udYko+QuVts5fgnqbCowAqGEH1x5maShAR?=
 =?us-ascii?Q?hVO/L0JNLJ9GuM7GGQ/Hq3b2HDY4pgKmRouqntJ7SjzQYT3s62VC3nkK5JNt?=
 =?us-ascii?Q?JardH/i0jNwUqfVpjmPgLR5BF2BmGEQMvcTz/fBHk5NIMhhJo/XJ9Ai3AgjK?=
 =?us-ascii?Q?dxZdnjnMSrodXiVNhLeW4osSoMrA5BSiLzMMATe/3fd5VGnKauqkWxaU8w28?=
 =?us-ascii?Q?VKF+Z6ru3Txrgy+jpKF5wlHu/vkJB+hwTASkEySO+y9DSlKHJiPYp/JWE6rA?=
 =?us-ascii?Q?+qHsUt04SlkUzzPqW82Jzwa1+0V7PREgNGIH8h5xdgqyJD7vGcqXtmD8GXUN?=
 =?us-ascii?Q?6AxBtWwFZ9OEjYmynMAgD8CLZyeoFP+7YXd/86wqizZq+AaxM+9SfrxXD2V9?=
 =?us-ascii?Q?OY+7mT15cmCZF6zLGC4VAZClwVdD9ZnpAboW1g7E9BDAiCYt163/ROWeIkkx?=
 =?us-ascii?Q?lkTwd1WJK3YkQZJ3LGocK/U7CjgpbsdBwMuankdwio3WdxkXEk8abv9ZLJOR?=
 =?us-ascii?Q?NxihCrSY9r2lke4GSNDhCocSN61rgto5gN11fj3CgZ9XlF194NuCyKUXb4R+?=
 =?us-ascii?Q?YiZ6J8p9oZuB/qy/lQYxHJMbmA+0+an6Av+sXpFL/k5bw72jCkHUFRycYnkH?=
 =?us-ascii?Q?QxT+0Ve0iSoPxE5EVIydJFAH0UFiv26O9T2sCNyVLyiYk3tbyUI7fQZ7fN5L?=
 =?us-ascii?Q?pXB8XFFTO5LR6c5j3Ms8jH6JqwSCOVjnTriwpidliPKUY3Fk1mgLIODWMOWV?=
 =?us-ascii?Q?EbcgyfcfVmSvD5I6c0jFEvP5QiOe+24RSLCHLi7+YQibhJ+obtiumAXufnAO?=
 =?us-ascii?Q?dNpGMQVRVooylBf6LMbnw38ye32x4CyYiApTw3dFb5HPmtwR4Q7zo/WxnAqx?=
 =?us-ascii?Q?6dtnDadif2pBtABtKOQA0PVvUsO1X4+PtsWQWeXFCHJ+bzHTJL/pMCpmhVRs?=
 =?us-ascii?Q?E5uRyGcbR6o/6lJk3k2N3ylCMWWIMtft3pvyvHcsS9Jx+zmux4kn5oHmHzf5?=
 =?us-ascii?Q?nNVLRdbIZpB2hC0hfUsgs3v0NH6QY82FijvdBG2t7CwpHfyz2g2SAQvB1nU9?=
 =?us-ascii?Q?mvhn2Q9nxtZUZjVwDsMnO1mt2dPHVeCXNPvOZINM0Gl177Uf/yVxS/qylnlr?=
 =?us-ascii?Q?eEe+saBQhBbgnhkUg5EPHChls8g1APKfb4IcHjl2da8Uml4CiY4GZgh2HwqZ?=
 =?us-ascii?Q?TaPOZ98q6ALXJLwWw03NfScyXPyzCqi3DDrOqUPjkgpGSkb75K+MtUhsv+BV?=
 =?us-ascii?Q?ZqfDFsi3QBhOrt91Loz7xMAZiyZsjkH2UBiBm99tPRKx0QLy+0U9zbB9Qk+h?=
 =?us-ascii?Q?pM8iKVb+fX2FaR74LRkVOBFOv+HTZx10sgzw0+s8/uDqEouMJb2hVNLTbXhW?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EsIPF6utmNfPylShyM0haqBGs82bmJdWJRf0VfCxnEhH7E1pUcbwdbhiHBw7/YVAaPNjeEhBzSaNBeo1M2OBdyzxGtoaVKsqJvPullB412uJ44NnHwvRVrBZgOlckUoBcTsQ48QMasf5p7+HM/bo2sI7DD9OVp1g8LlJVWJ29sEmXIR/4vEEJ65LIaVQllcbNX5M3b8ip1rkw5Cv1lyawsinA3M6RZ7Mo8NjMPqCyrsoP7IwueuC7/RAmQJq9WAUg2gMtarB45NlAnJtIphVCP+yd/yK0fCAILFbz2OZXefxBHeQeqXVoIHdlV0UgPWuDiLIrO54sVkzjn2ZaIrICjf8Fv0/yyl0S5vIkqMmxXtztmDwBj94geiNgqW+BfpmWMtn8SFhv66Ww5V1/kjtkeJMJEUPmQFWbRy23tXxgG4o94V+yHuo8LyzJjItYkBmU31+ssiGHIl5VsTf6ZHxmFoG1ZrfEjGiJdVitkH6VJq9AVqOaUZru8DEfaWXl1Vh902RbLPb3DsU02EUkJ1SrkW9+5DVxl4/6fwv+2hsA41tr33IJIj6DFWrn8WvLP1Aos43FLeohmxik5gbWphNC31J/CF9fMxKna+sTq9Bvmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0468cccc-efa6-411b-937f-08ddefd473de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 19:09:51.3936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3XvejdM2FEVdKLRKkO+3DVB5dNq3uzOHgZ6Sm44dXeP9+2tbBaBJqudoTueMVeBP7jhGl6H6T0MTxO2T4yNMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090188
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c07b83 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=tpUyc1irQyRqAcisbJgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX89f3TY74iyTg
 b27CS57I+Vf0suwzzYZQ84T+haA9HzLw4X26+3weyCNIpye57tFsYovpbygfPBHshi3ZD9etFTy
 vB6iYzl2hHyZmw8P2SVAFekb6UT9ytuAktgBL4XskMaJ9jnvhPVE2SSPaEWDIj1Ed4BYfvCYE5x
 r1LLk5nEqlvsUOxuK6AY3D3uzfEyGom1sGFUvJAoBgdiS78pUjIiC5IS/rVX5sp0TZ26IdDtHpa
 o4NxFXAdHSE4bsgomy78XWJDOkP6MtDz4hvUI//g0yHU/tjJ0r43Y3W66E08zo1a4yOm2ClHyeP
 vSCpdpaonn/mlWzOcm+MgbMeCn9tQxN2AWe5RFX5hxH9q2I4qYfVt2fDUEeYyX/4+CFEpfNhaS7
 QgOv8a+2
X-Proofpoint-GUID: Ojz2gcOysINMSGUMXzdtOImjABRLib_i
X-Proofpoint-ORIG-GUID: Ojz2gcOysINMSGUMXzdtOImjABRLib_i

Move the trace point later in the function so that it is not skipped in
the event of a failed fork.

Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5fd3b80fda1d5..b07b3ec5e28f5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1310,9 +1310,9 @@ void exit_mmap(struct mm_struct *mm)
 
 	BUG_ON(count != mm->map_count);
 
-	trace_exit_mmap(mm);
 destroy:
 	__mt_destroy(&mm->mm_mt);
+	trace_exit_mmap(mm);
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
 }
-- 
2.47.2


