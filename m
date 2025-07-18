Return-Path: <linux-kernel+bounces-737033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFD3B0A6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D09A42685
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282AF2DD5F7;
	Fri, 18 Jul 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T568qU0L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bIapn4sI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7312DCC02
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851149; cv=fail; b=dJ5rz8GTwVWhVLtJ3biQoOgTKu4yt6RhMQFg/0TW/j56o9EH6c9ijvi/YMAHpdh9fMOeCz1NBepsNDL1nYylMox7ZUxDsZX6KPoHlEYDcYtBP8mWFNjwUPPGiG5Xogf0DqMH0EOXX88PFoIUDpczIN+DjFhhYIWCQxfoWYN2dBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851149; c=relaxed/simple;
	bh=3WbzrUCZMZ4CZDajNS478yfKKOOT6rcg5x4W+9rEZ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cl6YxSp5OqDEeXNIsRbpKA364eBZ9kNzR4MBTTxrDL8mkn+f36wq/8zQzzwMxdTwjap1aoYaGu0k/POstiwu3k4eR4PIiLAd/iPJ0GSvy/zRxkXijZymfQO0AL3ZCi7S+VfXfLU+7NFAGTAP2GJuBthsn98E17JCyfv09b1gAOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T568qU0L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bIapn4sI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8fmBH011207;
	Fri, 18 Jul 2025 15:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JdDMwf/U/fH1KWewsN
	zTe0p1PFtg6c8xDc038mmpyO0=; b=T568qU0LR/KMtZ29oOMGuX8tvfrQUfXi0Y
	jC5Rv+eQJZRoyno+tF56MotuAOWl3QqegwU9ASXJQ5fJBk8cwMR4XadN6zfMZoJh
	7bOplz9m94524nLYUo+BoYiChmlvxeiBkw3B5u+2Pf9VlY/Uaz46EvIfRGBezJEO
	+lLfBNikjCFGFwueZD2mDQDq+ViY3mtnhW+ORqH3205W+G0BYQk6BRyl8RNV0Epf
	xi4ZcfVARlhOmZdgJebmkFthW2/g3RXiUl5/FpabNLgMjdp9vopvWA+DTmm6TgKp
	CWhzR+fjScmez1TsrhKQcFtQvfCQFzQH/pP0vDdyMAa4dEFtpLRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk674y44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 15:05:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IE2xRf023762;
	Fri, 18 Jul 2025 15:05:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5e4qmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 15:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfAVIs57rAOogNfhK4vLTwUIpxlWhdSZq8b4qT0hT1lene/cIWr2l/BdZEDE/pNsrvIHr6T+6cOtWFUUHn5O48SBOGpif7XoSJ7aepUZwTv3d6Mt3OJcztv7M6MQffI1FjEKSfaOvDn4yPqpgd2YkQoytVzgYxV7ymSrNrjUghKaTEGs++QgfcGPKolzYvoCLj7pmCkAIXF5ZZuo4Fm7E+nUuEtlKuqV3m7qAbSx0zhQfwZOMl/aR6U3OeTxqlHbVgQ+geqkDQiAbYGenex23ihN1coQhmk9awv1WsIGmiobANSJ0JXKQRZYUr+1sKeoOreOYWzyELjgE23oyGx7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdDMwf/U/fH1KWewsNzTe0p1PFtg6c8xDc038mmpyO0=;
 b=lGBjQrBQlMyJI4+U+koE1Dx7G1AukqyJ0VdL+di5CKymCdkHLVcHZXzTjRdXUsP5QEnEfSk105sB5h1D1f6wKT4kkk8V6SCgSC06bumMrjh14LK3IkB7YN4GdhOMgmGaXiWQqEuWFHRz+MtDgGNaYfrZ/TPUOyBlSHWduYYWpisYpkdUrH7TPLc0QzV2ZFLfxUrePfIh2HyNMFT4TCT1+dbUA+rB5gviL3W7cwkYpZaXONRTvuGMuCJDRTCE0tDlVrKvBoPTbWaRD5/qr1idySH617Uh4L0JHAZhWJXhMpf8i8tSm33ubJZG4R28PngXDEya0D6kF8lzbO0ACaagtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdDMwf/U/fH1KWewsNzTe0p1PFtg6c8xDc038mmpyO0=;
 b=bIapn4sIZg27nuBAtEpExtYq4gim2NzIW7zAnqrAIyck3MdT0JZugWcoRFOYCyYYf5uPu6xZaPo14qmkA5JQkWbR32b4Y/Aqx6TCLvfZHDGYLyyYoydeI+uHBZr6xQ2Ew+eINDUruktpg177JCo2NVAVbSbdXKbQys05Xx7IoVY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 18 Jul
 2025 15:05:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 15:05:14 +0000
Date: Fri, 18 Jul 2025 16:05:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Antonio Quartulli <antonio@mandelbit.com>,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Balbir Singh <balbirs@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm/huge_memory: convert VM_BUG* to VM_WARN* in
 __folio_split.
Message-ID: <203a3260-45c2-4c82-9ec3-556599b17d53@lucifer.local>
References: <20250718023000.4044406-1-ziy@nvidia.com>
 <20250718023000.4044406-5-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718023000.4044406-5-ziy@nvidia.com>
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: b46dec05-6a6d-44a5-8cfc-08ddc60c7fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3VP1UWL2TNvayQD2fvgTCFuW1N6C60AS7KaMPbNDwffu7+bY8DPbFySRM+Nv?=
 =?us-ascii?Q?qkzNJCxECW5MwLop+C2kD9HcVPZEHt9ONcBXJhrDYwrdyeDPJWMs7lHQoRi2?=
 =?us-ascii?Q?43iWapi7QGBY6sRAz5BMnLpIGgVz9hrTYV9C/pL62Le5O7rS0U9t5PBXN6kl?=
 =?us-ascii?Q?EayCvty47zt+ALc6mVj/BahdMtRPt/iy9Exz3Y2PqdiavuTGQ/cBrDP8fKSh?=
 =?us-ascii?Q?WP5KoNWwZklnBsq3rkgyADg9/e9c06c128QgHozk3+kFJA1t7RtxeRcdS2Jb?=
 =?us-ascii?Q?aAWV+OIrRUDA+IfRyxQYKxSuT5VC3FO4yCrHOE6xbzjL/KwszlX1SGsfZ3wE?=
 =?us-ascii?Q?SEWMi2izIXx6hUXfJL8m+CPTrNr/19zKpgQAsp1XH7ukzKUjUzfplxpJ0ieo?=
 =?us-ascii?Q?9aS+E5/5ZSjDgGm1WSA1529uOTS52n3hOOCkBt4gE/TvZgyCrHbYl+TWxLby?=
 =?us-ascii?Q?wCTycr24D6JDxWkcmnQKZY0Q/6t1X1HSgTKzf4CmJuw7JwQpvvvb50MHmU5V?=
 =?us-ascii?Q?u7jV5HxctJ9mlvRnPTUhfTNX6baa+n5KAXOXDMX9ptocymQWgTlcvrfulra0?=
 =?us-ascii?Q?1bUCPXpYDQ9e4ASd6G+ZNn8u1Saech/uae3l8Mg6YDE4j2Fm2COHaPMOfSeH?=
 =?us-ascii?Q?maAKIcqW6CXsULbStdYtSN3BWiKK8ZPyDBylJ0EN3QYHvZTesZU9pv+WBBmM?=
 =?us-ascii?Q?Wqz7S3ZzWkoBWrAfu5xafRa9d1xeCs6cwsMG4Howm5Dk1Kow+2IaU/MYMrnj?=
 =?us-ascii?Q?pyTGhCQvNmz4iLXkS3I4zeM8tCs0AM/J/bOr6BJu0q//1nTjgOYBAGlA8liI?=
 =?us-ascii?Q?m/VB+CZjgNIWI1PgwhvJybhrOQwCtmd8gXNmT9CVi0H38I5nY4ktDLJtbqk0?=
 =?us-ascii?Q?yv9c/jFgERh051tDTCi05W3cBOVgafJotK/BfTSm8DdYLbPEZDByfenC9iwq?=
 =?us-ascii?Q?QuIQHSbXL9Z1uHtghf9aflATKKhrX+VojiPgQRZciVokQNs/f/M0xF58DYZP?=
 =?us-ascii?Q?/ITsyF36RM+Uuqqf0R1GDZZ02WklgSGhBvhCst1jylV0Bh7SxEAN8bd7WhZb?=
 =?us-ascii?Q?JBJcWj+g/ZzlHyerFEY7hfaF3/zoGK//jOgaPbszSGK0v+3PLmj639ic5swL?=
 =?us-ascii?Q?FZHzVjtL78j0JI+STZNDoXc6U7mn1BZeh9KS6TtxdUEyoxNzY8qZkJs/hSp+?=
 =?us-ascii?Q?cmCZebTSt4N/nb7M7fmB/yhDZSA1hdvfqPK7phJEP1HoCVKkNojfNR2DqZV1?=
 =?us-ascii?Q?DgXXwvcvf+NxZ43EtKcU9Q0Re/QEtIXydkrdjfZKwg+aBa4dLGNaOy5ljDKi?=
 =?us-ascii?Q?tNQqQUZdRxIGdWuDZWF2DN9K7L5e4nznL+V71uPg6qOZO8b8zvERK1MlwZNq?=
 =?us-ascii?Q?AzNtrVB89QqpkyyE0HnNu0xvkJyNmBpxiR5yPkswgCziOhTWFyAHYyePvoHs?=
 =?us-ascii?Q?p1fY8sVXlAk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ONTRdhK71n2Xev+log29BgBPdtA6K4FQfulaPvrbZVjpRwBEEHfS7QV2zNIv?=
 =?us-ascii?Q?9L0+awAt9jkjWhnogNo4XN1chYlDqTOE9geC//tavPMXZnCm5TqsLHNEaGyO?=
 =?us-ascii?Q?CHlnop7uQ6+l1WicCLCD5SiWEN8PslaP69RPSlMJ5hpZMwcHShVJXtxHXBUZ?=
 =?us-ascii?Q?5Qr4LQ9qJb/I98pTilMevv3/GmVAJBiY+bGjLwMmIsRIKLOjHh3LPZ6OIwwA?=
 =?us-ascii?Q?OjT4An0+QJ0bVOL7vrjFFLe9hYjiKHljkrySxgQ/iz2+SybebZA+tFNULT/6?=
 =?us-ascii?Q?MNqNjaDE9O27ruqRuNXtT0+EOS3Zh/lyzMNMsOJM+4X7/66+9PPjH1wihmCK?=
 =?us-ascii?Q?b5upg8PJnrv08X8f5xNbqHwTT5aSk+GTRx7YivRv8NtUtmRy7c07D9Fl2tcg?=
 =?us-ascii?Q?51II/A9Sc7RfYrMot6cqnttifN7zCveICtuJeFfSQGShhVkBzp+qBKxJkIg/?=
 =?us-ascii?Q?qz7l+3XRY37yK7wl6xEEVaJSsnDsv/nzIg6IzZ1hn0Q4H7BEoXE9bvff6lY3?=
 =?us-ascii?Q?fufLcDe3vEJsrE8MJArUcENgWX0QequyvKE/5vZr8hbRHY7Bh4Zx8rp1SDRf?=
 =?us-ascii?Q?mcrqQ/PugTmm9oCFzOFBEMmSSrwEdVnIa5oL1qsUYYkgPRtJ1FYK5o8DOGzX?=
 =?us-ascii?Q?ui+J8+NVvzMKwYU9uFSSvY/Y+FcOGMkVAzkt7nNUzyzMJXUfWD0a1AQHYPI7?=
 =?us-ascii?Q?KFMYKb04rsQHCGaidhVqv69WV23MNHFkd7nU9ZV/dGQDP6Wc42Vfcfd/lsUV?=
 =?us-ascii?Q?L+tR/h4sUD5z/tVz0Ha5IpaaMRL3Bm9QSzTGl+VpMMfBZAq4MsLG/cCFffRf?=
 =?us-ascii?Q?56qhJEN4gBWdIwdP47lEFedgF3A1krEUABrDhknOX55VxX7A8Gg4xvD3MdOy?=
 =?us-ascii?Q?z0qmtvMa8qJYTtI7P4ZKQQQbBTFNU0lxkAS5A/C95fkSnlwCD7YMzhoQUeWu?=
 =?us-ascii?Q?oel6zigyVM/d+hiEvAuW/5RlZEb4aqLVkKnzPEBPJq2PFsmI7rMbYBssfRD4?=
 =?us-ascii?Q?2bZsjGGPJaTrig69R468hu5ZI+XA9aQIbHZjxSB7kb1mFT3zUKvo6A829pwL?=
 =?us-ascii?Q?FCKSWCZ1nFjFw4PYksQPz1xitkO+uxFsw7RFlOSQqfaFH8styuVk2312JBFD?=
 =?us-ascii?Q?2fCwkiDVNqwr2hR2k5zOWqXU0oD9/rOa5tEZ0nFWhwuaHEMtABE+LCT6Nt+l?=
 =?us-ascii?Q?rpmt/XLfnYqk+ZOPINL2DVOmnpJmnHJXBlEx88TM71oJ58g8d2499/emiTTN?=
 =?us-ascii?Q?ewZId60+9qBrx9VuJoHfqfO33YXb8Yp3MNCOOkr7RnlCXfg+rubuvWd3ei5Z?=
 =?us-ascii?Q?2yOkcl/01FumhChepsZ75djR/QmyVUvWNm7yZ5W3RXd+Tv3+KYDHpA/aAHiY?=
 =?us-ascii?Q?k4Ee+aoM0QQ88Zihs4h6MA5j+CgVzYwmiPkG1ElH6XE9vipN3L5Jd1alFSKG?=
 =?us-ascii?Q?xygFWHQPuQZsHkpEefBh3ri/fCdVT1K8HW/QzBUM2CF0p52xB48dWuvhDDyv?=
 =?us-ascii?Q?ANPvtKNLdkaVw9WZVKiZGUhFYW+8hHybLZtHN3GTi9QZQB87HWpImooPBCek?=
 =?us-ascii?Q?L8VQlGE2NktgzviNSaVHpWjOv6l/Tpx3flMBVR5WkBCITjsF4mmA0MajndD9?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DbZnr1Gj7cJH7nWYSM/cbFEvlBigZWDnB00mJzEWb9kCg55Umz2lMPxuOWRig/4+0HTeiOq0tAF25HsWebGVjJKXwGDHG+FnMBN1eBIxZxj3loGZqYsaewWR8fySrgT3PAKGyZcSBaiw0urzXgK4YJbTTlUbqSFEZOH/RE2rVYZUrYC6krrilCP8yKI1m6r6Cgl8Zoq0skWf0sGIcMkfGW/Olk2eY/XMGjHbrf/k5E0f+KgYa4ZiT6L8ikR+mrG9mCSaqWUVAipFPsbCddryIA569oL3BpU1SMWuucVQnu9ghnSuiKbnVAZ5qwXmz1silmKYVbTwos+iQXq44eJXo+61p2S+Bx+V27at9CVylwKI59Ufk7RxaRaSmleodupyJCYoUbwGDzt2znR/Jc7rSxb6qepRv+cLgD6ZbrjGKEw0puCI6jCL/BIxpCdSLPT9IDP6K5wvXxiBwizPdC9u5je6zIxdqRgfcGVMIjNxhUsVGfthdkF+rB2cn0f4CYyc2xi6KCVhvVCP5A285ifdpHTHy/BWMEYLi6HgWzg4bKN6tgO913LjX0+mzuJ9Fhb2UqCu6GeXd5tv3eSHFacjxbvm2esGRL7V6QBKTrm5mj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46dec05-6a6d-44a5-8cfc-08ddc60c7fd2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 15:05:14.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+iVnBLjoRmDrtMS3iDTzcA36Ie9+zuGTMslA0y0OXlcKL7ENKBgRI9PKlyb03Mfbchm703jzgG2Tmqsnm75GWjidbah9yY+dvPHUNedIf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180116
X-Proofpoint-ORIG-GUID: K-h35hXl0mNigRP8qVFFNksXQ99wjVhZ
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=687a62ae b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=dfzRIDnsRKRgdyhXuegA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDExNiBTYWx0ZWRfXxriDIMhtQEmw mwcQLDGkSz8IaYfb9bQ0J/C75zQeFaxfXTiF4BeUcbK2HCDZsl1Dev2PD1vfIef03zajZlspWdA CRDWoE8Q0SF3rZVZplMiOto6i8zg4VCioqiXlMxJZATm35gwc5FI8UOIDb1Prvf8ZEFsW1NV1Ge
 xD+PazSOwvPfG5tHm5bo4FlYP6+WOCfV/lfU0P8I7MRmhwKuUS9FsUy0pLajx+5OGc13yF5vV/l y/SjQNI9fKrI65dvk9UQekttTIrisLwcTyKTPLiLnmHaHEKTEFWWNaMF9It4tDLOXdOXQfN0exd GZyurM8awICE5KxJxHNEbmFm106DmxZf5YylF4h22eDpfSEn8kilSzdLW97M4vzwwNmqwHwGopJ
 ro9LSp6cDsDqlk1PDPsiQiUlOcFkvn56wASlXOq3cBJ1uRAYedczVP61T7YrBlL8Zbfes7y7
X-Proofpoint-GUID: K-h35hXl0mNigRP8qVFFNksXQ99wjVhZ

On Thu, Jul 17, 2025 at 10:29:58PM -0400, Zi Yan wrote:
> These VM_BUG* can be handled gracefully without crashing kernel.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

This LGTM, but obviously this is predicated on David being happy re: his reply
but from my side:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d36f7bdaeb38..d6ff5e8c89d7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3601,8 +3601,14 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	pgoff_t end;
>  	bool is_hzp;
>
> -	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> +	if (!folio_test_locked(folio)) {
> +		VM_WARN_ON_ONCE_FOLIO(1, folio);
> +		return -EINVAL;
> +	}
> +	if (!folio_test_large(folio)) {
> +		VM_WARN_ON_ONCE_FOLIO(1, folio);
> +		return -EINVAL;
> +	}
>
>  	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
>  		return -EINVAL;
> @@ -3766,7 +3772,11 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		}
>
>  		if (folio_test_swapcache(folio)) {
> -			VM_BUG_ON(mapping);
> +			if (mapping) {
> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
> +				ret = -EINVAL;
> +				goto fail;
> +			}
>
>  			swap_cache = swap_address_space(folio->swap);
>  			xa_lock(&swap_cache->i_pages);
> --
> 2.47.2
>

