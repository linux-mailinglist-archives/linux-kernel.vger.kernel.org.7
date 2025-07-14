Return-Path: <linux-kernel+bounces-730025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD3B03F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BFD1A607E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6582253B7E;
	Mon, 14 Jul 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DDTE96Kt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Va/pFHS5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78F24DCEF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498520; cv=fail; b=F4eFDxrf72ZPvF0v/MEZcdlgYt8U9wFosnflQYGSJZ5CKH5uCcZ9BWJQYvS7OVJhRUK9tvUxGdA+LFDU9My235F4X+0h2gGpUO+Vk+gXbmf7jbNqUWYhbuq+5roI+Gb7bIzBKwSOOW2Jlogw8a24TuYgNM3YwXEl8EVPood2Y1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498520; c=relaxed/simple;
	bh=RUtMvXsBGnE4lU0pGduMEd9TkHNKL8IIzbW55sP3FOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEYIyGFTp2IywLz3JtFMUJS3kQrxtHcxt6ED4vCc19j7TQZ7IxIoBGGv40v2Vp8A8O13w4I12miEqMmUjRfL8OuPscqcQQ4jhkEhLhwC2tihJ/HR7gH8jW5d/RITrOU8WJeG22fOYFby7poqmjoMlgPHS3aatbKnY7MxCMEmbuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DDTE96Kt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Va/pFHS5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5kO031168;
	Mon, 14 Jul 2025 13:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OCOmtQDm5mnrBtuva7djYlEPB0CMVcLEU+pv7oWaA1U=; b=
	DDTE96KtAJuNL9bg1g+gKxx2FusZpaRWwCpGfjDDDp0VWKL2e0Y62BzI+zw+Qshp
	o3loS9AcJT0DbT/ETPQGtxZGhAn5ZoCMeSK5xNxQz6+fwkxJ6amboLI2t6RN61Wd
	LjbPBSLh6zgQVEAejWv2QJucJ+uBczSstyWqf0fP+0L556j4wlzN+OrHDdmwmJ1M
	DeMvyC+iiJlHesW4pJRp/rKrko9d7CAY1nHijNHaQRJcYa/97xJ3GrAvpZnwXK8c
	03/e2hEileINeW49D60ztfbq9P62PgrrrqaNU4qAeyY+HmuCDi6bGavP5zLa3a0Y
	UNqWxLl5JrpIDKoQ6Z49MA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0v27k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ECDilU010889;
	Mon, 14 Jul 2025 13:08:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58hfcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+YclIMRziQQmPcYEVX8fTOU5S3tg5fsIrthR7odycNK/CmRxCrOxhJr1rvnNeBi4vh7i19z61CXC42i8cxKRTKe7gUxLKW2DIX6IY9cOGyLVlVP/zAadFTQN172GHhanQtCQQa6fUI28e/ZfdY9TjzlXZojrvaCUtW5G1xVeFuM5UA01WIszjA7TwH8fz6bnJ8VT1xATX5s0JfYCI+VQ7KJVYqKydVC9HFBkvEPqxM+acWZoY1dsU/KRrXhFSuhMk3FUIdXcG3xv83skr/bkd+jULVTeFMfvFM8K/bN5KyCpDhDIXQlKwD9NNKFbfxv0BgQ9SDdKyvv0eLTzMC0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCOmtQDm5mnrBtuva7djYlEPB0CMVcLEU+pv7oWaA1U=;
 b=jjZptT98QcV4zBRs3ch9Ij586vpHWovz6HJCaIg/1ftgQXcS0whr4lPHlav0BoiGj+Ah4anx0r7e7DiSNG+Xb0yj1XVk28x6jw7J9yot3mLAo3Ss7ZT6qh9in69U1w2OCs3ZKnW4jTtxBkqrzoNjdrukRyLU4d/36RKOCBKNVqigvfKtCnPumOkS8hFC8QQIhqN95sI28dsOGrgZLxsB7O6unMqLpqENiItYieUEot0k9UwLGiMzeGKS/zE82KyjVTFzYvkm2ZBe49S23GnEsSBfCAX7mXVMcPPlNf90yU/eiWHl3Z5RBPWJ3lHMHg1iMBIFymfBAfS4mT1E4flSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCOmtQDm5mnrBtuva7djYlEPB0CMVcLEU+pv7oWaA1U=;
 b=Va/pFHS5qVkkzbC9Fb7bnIbpT3vXBaUAqKLhVy3GVkT6qGM1xzEqzJ4WCAwHXyDvTcxnUdnNR9LCZzISb0xJbjGrJrE78rBZkgLPHUDVkUAtU5ujTzeqAyipvtsrTQrYitqhYWZYSmxc3pYoJ5fEnx9yw03+VEDR49m+vgZIbJk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPF1F3678C2B.namprd10.prod.outlook.com (2603:10b6:518:1::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 13:08:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 13:08:24 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 5/5] mm/mseal: rework mseal apply logic
Date: Mon, 14 Jul 2025 14:00:40 +0100
Message-ID: <7ff13c42220bc3fc19610e93d5b73637146aa7ae.1752497324.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0442.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPF1F3678C2B:EE_
X-MS-Office365-Filtering-Correlation-Id: d804d4bd-04c0-41a7-8e9c-08ddc2d783b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fYGFeYj8VrguCAirlYV2x/+WFK2NjX2Fxj/Fw4PrQ/QRww915l/0jXzY2oil?=
 =?us-ascii?Q?1PMTnhdeqs7JAgcQl6MZ3EyJIZCGnZz7QiulAqvOGT6FZG0fodwfdzB5899s?=
 =?us-ascii?Q?Cz7LdI7rz2JN//RwVPDmT/f5hDtHDoQRQNCBgywMo/1U3TNFcZOTjfEwNDVc?=
 =?us-ascii?Q?hgBSvbfEXgWiWqBqR8K7l53+SR4TCeQ0jxghM0oP4kZeWm3/AhGO1uyEgO7R?=
 =?us-ascii?Q?5SwHXYlooyE4z9iQ3bL+wQzccTt0LiMKD/EvjEPTtYe6ZOaXWpEet8xjUikg?=
 =?us-ascii?Q?ek820Toj1JdxawHy8XvZifwscG8ldp3/B39WISkU8HNE5l2iBslkmSh1YdGA?=
 =?us-ascii?Q?mGPjGsLk75uaA5jUUVhIZ4cg7hV0fqcde2YzzEpPKLE+h0RfdcwVhehvcUaq?=
 =?us-ascii?Q?0CILH0Ob5RH7IXWE5N4K0np9zx+EBPQPi9hkpZp2d55j4Mek4rFBhEYDAVWE?=
 =?us-ascii?Q?MhLrCJE7Nk5JFU9nMf0sf40ryaZim/LIT6CoZFM5fZG9mdJGo96jHDhLGW+k?=
 =?us-ascii?Q?Ja8745hCnLCzbENXsbwG8KcinIk2me4+b3e41JMdbK5n9so3X6CXarmScxt9?=
 =?us-ascii?Q?nVYfFi841HVNoiut9Em64dEsyFppl6thKDn8zcn3UER/m3GMHvLtd4fDD4kh?=
 =?us-ascii?Q?/CUSL8hyWuaMA2UTbqtwkHTWLUD88R+397YFfQ/jimzJyutuOEFATcWvtfw3?=
 =?us-ascii?Q?t/9sJJG4E5MSNCRMVNeYjlA9V7uSHeitZyZp40w4Bv+veK2slvyOkt80wFeH?=
 =?us-ascii?Q?MH0ay/gipnxnGlQw6gs6B7SwKOq0wCMrbhdLkNL7GkknYeayD6aB9RIH8+UA?=
 =?us-ascii?Q?SksRu05KmCga0Df2sTJGHBBnn2+9tNP056/YRMDlCXFLEAzU45nyZli49YQb?=
 =?us-ascii?Q?20kI8KfC1FFo+degbgOiwcZbz/w9lLgGRfP4wvtTunSs9GY1gOZ/9344xTL3?=
 =?us-ascii?Q?ENd3VojVxEhJOG31xGVjfdaNfNGGPJkk809evPypJ2yaoxlj4+Yz9wpdP8F7?=
 =?us-ascii?Q?4yeXvQtMoVybb+Sf+mvYsHn15qb14DaFpMNFMl4AGB8yGIo7HEiuVr9YA0MA?=
 =?us-ascii?Q?Qp/OlVidxKuYaoPWVw++qw4hbgyz5FqobqY86mi8UrsOAWOaizNu2stuM8gA?=
 =?us-ascii?Q?MBGYmoZKWaaBspXUzOSRki/3jacUPWAyUDDdMhJNp3r/4NmeZiyiCFmhvWBy?=
 =?us-ascii?Q?WH8kxL+l4qcOJ0ndVHlfsZmri0nsXkNLiTjXk+Y6gmFmHCR3j4MKD0Gev4SE?=
 =?us-ascii?Q?S1S5Wz4wBkCstHRF1lLF4+eEMHMYa6aYJHCEGkFomtf6lE//VphsoXgpiDum?=
 =?us-ascii?Q?EsMsUgh8gMl1KG0hgCCS58E9yKYA6S4vSi0gMFaN97AnmElv51Q21GQQrudB?=
 =?us-ascii?Q?LtwJtR6FvbBvqm6PFNByH5QWfTu4hnmstNsAaagCL14bSGtuXvBzXHcGWQKe?=
 =?us-ascii?Q?hhSKlltm2lg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kKq9ZX3Vz1l3HwK1KW6EMmopCMAbXHE6B2oQblaKlQK36DbmnSQ2f1QjxAum?=
 =?us-ascii?Q?KaDRlHkKShX8kueTV3XIme/QZWv5Uwcgi0aB2vb8IvxSWMsbBzng1lYjx39L?=
 =?us-ascii?Q?NiXX5MxLyqs7Zm78nmAHVjrvbf1QAPqFKWKmCfvpDm+4QPZgQtBqOIbRGXr3?=
 =?us-ascii?Q?OXSFMgARIubfG4/GOv6jFi8WsXT0mswamZVN0iw8uXqVe4CxwgOVWvbOZhES?=
 =?us-ascii?Q?OvRjgSc+2Cl2S0EWWscOXuQG+qgfDOrQAld7dBqt1CLB3qt6wCKNVBBFBmQR?=
 =?us-ascii?Q?+C0cHSkWjJpI1j6mYt+L8OG3INRAwSGjdFYm2Ks7cohZj/QBaBCOqVi8U4j+?=
 =?us-ascii?Q?0vqKXny8Hy1tiyXnTJDdtZkIoZTlsL3qqQ7X8SGbrjNoR2vmVmBO6ZVO7zpr?=
 =?us-ascii?Q?OE3pp6JxvdbZCvIU9txKyjUrnyqgoxZu+KbMH9/4+N8eVRw+RocQKlYe9O6r?=
 =?us-ascii?Q?j4QJgSRcDUvTAfZkaGOCny11aXGepnbsq7lfYHceS2/aPse7rdO9jhCxLsQR?=
 =?us-ascii?Q?v9vowdFA57xYSjqjAeYqagqVb0a5bo4ps3mssY8aC+orTk+EsFEsVRVSRgz7?=
 =?us-ascii?Q?9bLiEHuvkghXN/VGRCQOhYMaIRqFY5VP4nEdLtpZO52UJeX+ciPGe1/STRSM?=
 =?us-ascii?Q?3H3hk4PRZZ1Si52p6i8P6X8qb002XW4D7SMp/Z2NMhHCNTsZCa9rpnaLCqen?=
 =?us-ascii?Q?+wzKEM2sWz8Mjojj2NC1mutv2m47mJhEWnEgCFB8cgzW/qeTeffDnrgDIHOk?=
 =?us-ascii?Q?B6BEEYxhkAEA6DMfnLgkyBJOCfC/Jx1ZtD6SnV7yVvmABKUAFJeNSRWPtl0e?=
 =?us-ascii?Q?b2d7uvuFzPlGeZxq85pMevO4X2WrfVK1oOoFN+6qcE5kYqWbvAz4t3BWRCxl?=
 =?us-ascii?Q?eMAbXO5S+f9g5U6irct9fY5nUlPRUz5ayCh4kW6rMAW4JBNZ6LczOd8StOGq?=
 =?us-ascii?Q?A0rDHhL9l1dqTcrnVeEzbadtH9WKrlQiw+6YNKVU25Ld2gH1sO9nvS2zzRY+?=
 =?us-ascii?Q?sGIpXMZUx3lef3DSA1ZyI117/TsuQEHdDeufZ/Oy3fIrDBrYLY6lbU3J6S21?=
 =?us-ascii?Q?1gW2LdhXRXYwIVzqU/7SCj6lpgbmUbX0HY8qXBl6/z3Cfx8ZffOPStPrdvT3?=
 =?us-ascii?Q?mdnDLuvdHQ91Ln4RT/ksXszbZJg31cYpH4UXNx1LbZHqzjq2CuGmOvLLm0Mf?=
 =?us-ascii?Q?UKv2BuUR9RJ37jX2KXZuRA/nQ2+6vRcdevM/cr+QDI5UTztzSjXBsKF1Dakq?=
 =?us-ascii?Q?xNkYMQaoBUeMNBI+CWqgMOUOVI+QrEmX+PBtgD0whXV3kWAbBiHhOu6jfpsJ?=
 =?us-ascii?Q?rVKONgYJLrjEylnPtzjkX1kKOKwr5XKxe3FWJU8MvBahx+GSp0QeMeh+XC65?=
 =?us-ascii?Q?kDxaJKhQTjfjC5RzlBGS7EiH/bpL+HGcbUjnOQW4taUxv3n6hCJCjQhOL4Rk?=
 =?us-ascii?Q?OJbopPPvqkNvNJk9eg4TEhWXVxpWvE6Flp5KglB0Kfh0TaTUvosbNnNhNz0i?=
 =?us-ascii?Q?f97x6wxlwJ78MNeYmHBcrsl34sQcIGKqqzedZG//47Zlj15m+cTMPe4y+zPF?=
 =?us-ascii?Q?3L+Tcrsej3rHxy7GkubYKDXMevVL2WBMEIssJYk16L85DOG4uU505Jgpa4Uh?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lb//OEi3ysqtbETxr2usS3TRZT4UwqYLMWdYtpPkTFGHXl4109RuqmIfVCM2MidSfqays5tVgJDBuN4vUQq4imQBqR2W4kQHIEEtEMjSYoy6yMLxh7HH/1ZHtgt481mNmFFwMyBO9S6sdm+u24djzaOMUonefPOeGrGaCmFUfkN+M6taTlCnYRRy6PVX2NwOAKQD/dwBUHJKYeQaKkPaAHO9Yc6Qm9DfRlyq976Q1fMyChb7yNTU03Y8wgbPPwVnwNlu5zQPKrUtQ077vMxAH7x1bnKIVWPxKilztTBv49L2RkzHRJ3Zhp3gb6XuceQclgDEkmNtmQyaT/cQW4e6MVdr18QbCItRFBKP/iYBbWLIXlDo8rHR3B2yoqFbMwhI6DsbGH6hOcPMXTLr7yd6WODOumSJ/Pdsltcv3bWcP9W/gF+N+obl/wPRRO/8IhMF+Ur8BqubkODsU7Lb2LuTOFaqRD3dlzbWGn1xEPbMrL8izBXtdmVL8pJERsIjzAmryZ1qAIq26x/mKr6Q11sXYaDDMKe6B4xPF9boCBeoNed23G0iSi5PQ3jiI+YF0IgrCGBdF/VcIbWA7Ku7VvQYXnM2i+114p5PUcWvwxzFdjE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d804d4bd-04c0-41a7-8e9c-08ddc2d783b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:08:24.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7uk/QGEhMZ6IImUeYC7X9+bcFkgV0arIrI9UXh/HTL/tqh3c7oLd3aqASXlzoSYPIqSPgII8M19zJfmfHPsqoWCGIHYCAakQEWAviEBFaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1F3678C2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=813 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140077
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=6875014a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=bYyZlYpX74AIGI5vcOsA:9 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: Ir0eLzqcIj5UkixuxM3WKCOcMyehz24p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3NyBTYWx0ZWRfX7tTzGkfU5Ti8 75nK9qcy9KzrLXCiTz7BN3Qrfs/piL4mIcVfl9xZ9b9tjVFAQ21tUZ0U5PuqdOAQ9u6tYgxDGwz cPhQXELeau1fqG6bBj0XiJtil/4IcxVci9HctCmRVpv8NUf9evjI1elzI4uG1Lla5Qc+RedTQaP
 F075pBsLFFmtiGkE++BLLyQcermlQvqYIMCVhbWf1lPBNITL+4B+jwA5mAe3uhvi6wn8EZrVc1N qFqR6mHp9dRpikU3Q/3B46n5L4HG9FDVXpilSCUbUUKo8Q3yDzywOKyp0ga2DDnNkyaFe66/jbz 3meeH3SSUNVX6hZw7JPRtqboNtIAlKwJtuMOG8bRD6YDsSIcUg/W49etIRMD+yER5F2+z/RGPHd
 ByWppAGLnqb8bl1+3PSm1ZlazDq/aw77iVSdnbv5VZfYjHJ/zuyZ6PJ3hLYJRsa8ZTECSbwg
X-Proofpoint-GUID: Ir0eLzqcIj5UkixuxM3WKCOcMyehz24p

The logic can be simplified - firstly by renaming the inconsistently named
apply_mm_seal() to mseal_apply().

We then wrap mseal_fixup() into the main loop as the logic is simple enough
to not require it, equally it isn't a hugely pleasant pattern in mprotect()
etc. so it's not something we want to perpetuate.

We remove some redundant comments, and then avoid the entirely unnecessary
and slightly bizarre invocation of vma_iter_end() on each loop - really
what we want, given we have asserted there are no gaps in the range - is to
handle start, end being offset into a VMAs. This is easily handled with
MIN()/MAX().

There's no need to have an 'out' label block since on vma_modify_flags()
error we abort anyway.

And by refactoring like this we avoid the rather horrid 'pass pointer to
prev around' pattern used in mprotect() et al.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mseal.c | 69 +++++++++++++++++-------------------------------------
 1 file changed, 22 insertions(+), 47 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 8e4c605af700..cf28efbac371 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -15,60 +15,35 @@
 #include <linux/sched.h>
 #include "internal.h"

-static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct vm_area_struct **prev, unsigned long start,
-		unsigned long end, vm_flags_t newflags)
+static int mseal_apply(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
 {
-	int ret = 0;
-	vm_flags_t oldflags = vma->vm_flags;
-
-	if (newflags == oldflags)
-		goto out;
-
-	vma = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
-		goto out;
-	}
-
-	vm_flags_set(vma, VM_SEALED);
-out:
-	*prev = vma;
-	return ret;
-}
-
-/*
- * Apply sealing.
- */
-static int apply_mm_seal(unsigned long start, unsigned long end)
-{
-	unsigned long nstart;
 	struct vm_area_struct *vma, *prev;
-	VMA_ITERATOR(vmi, current->mm, start);
+	VMA_ITERATOR(vmi, mm, start);

+	/* We know there are no gaps so this will be non-NULL. */
 	vma = vma_iter_load(&vmi);
-	/*
-	 * Note: check_mm_seal should already checked ENOMEM case.
-	 * so vma should not be null, same for the other ENOMEM cases.
-	 */
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;

-	nstart = start;
 	for_each_vma_range(vmi, vma, end) {
-		int error;
-		unsigned long tmp;
-		vm_flags_t newflags;
-
-		newflags = vma->vm_flags | VM_SEALED;
-		tmp = vma->vm_end;
-		if (tmp > end)
-			tmp = end;
-		error = mseal_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
-		if (error)
-			return error;
-		nstart = vma_iter_end(&vmi);
+		unsigned long curr_start, curr_end;
+
+		if (vma->vm_flags & VM_SEALED) {
+			prev = vma;
+			continue;
+		}
+		curr_start = MAX(start, vma->vm_start);
+		curr_end = MIN(vma->vm_end, end);
+
+		vma = vma_modify_flags(&vmi, prev, vma, curr_start, curr_end,
+				vma->vm_flags | VM_SEALED);
+		if (IS_ERR(vma))
+			return PTR_ERR(vma);
+		vm_flags_set(vma, VM_SEALED);
+
+		prev = vma;
 	}

 	return 0;
@@ -167,10 +142,10 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	 * reaching the max supported VMAs, however, those cases shall
 	 * be rare.
 	 */
-	ret = apply_mm_seal(start, end);
+	ret = mseal_apply(mm, start, end);

 out:
-	mmap_write_unlock(current->mm);
+	mmap_write_unlock(mm);
 	return ret;
 }

--
2.50.1

