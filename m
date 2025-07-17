Return-Path: <linux-kernel+bounces-734987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7F6B08923
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662A23BD9F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C528936D;
	Thu, 17 Jul 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ksmid2UP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WmE/JSyR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D1E288525
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744000; cv=fail; b=JMsa/8x3r1GalfCmaUUf40/sZt7U5uOzTfdEUmI0L0ln+jP8u5paQsJydXgr/FBa5QuuiZpwfpZARx/rrk+8o/ekkFu79L537/VMndms6cXX4+9vYKxlT89W7BR7ryNcTHcu9a5/fCIAv6JQWKQefOTSFlwTGUY7BkLc7MilCJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744000; c=relaxed/simple;
	bh=/+JHaW224b27b6LM1AySIA1Q6toYYxrdfjgHWkSbD6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qHiNeG5aKzWzJFnDHEii30OTmdcWHD35cW87dAjGq2eKJWVcY2Nb18E4OR5fvZte0eAKBNNQGCWiMt07fydw0qM5xJG9zWdrE81Krn8CqqpxMFvHZBsKOEsOenpRbRfPbzoGhMJKVp3Y4Uu49MmiFP3eZj/TkbfGYBlDyQKfpaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ksmid2UP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WmE/JSyR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7goc6011701;
	Thu, 17 Jul 2025 09:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2KXvKYrE9Xc6ImlEWr
	TpDkh26ArHrrhwjqFE1/AI4ZQ=; b=Ksmid2UP8SmZbEdjAIBdi2XTiEnxss/yzf
	GAg3DB4sqp8KqZBjhB+VUdosWiV1EnaiYK+puI1qhSJ6fhopS94tRmD7xtNDgQUQ
	1ZFcyuD75YMgFsztez61pz8Zf7JXl/KmcgJszE79Oj2LL9u3UIbuOY4RWiLwhtZb
	QxPe+UT6VBFhuKGHK2FbjFzwYcWLcS6fM0fp4tzk4i4vkz4Y5JHO7C6o4CQLgVdU
	XYwpAASn8UYXTkV+CkQdSlgphNzT6zbgAOxYBbOJ4+QKb2Anuik8UBfAA+P6nKVE
	uIgfLeCYj7WB+tdLxouRcRTLmnaEdFwWZqj4vXbl7BYvdoYCYIbQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfb5n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 09:19:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56H8o2b0039601;
	Thu, 17 Jul 2025 09:19:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cghh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 09:19:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvX3dePYRuxvjMmJCCipnR1tO/pyi9d7fAvVtmuif/PS7D2mlFxlh8n5HNcKFQWXYRmzKOMqFeekYFDiBBWwsdmmvVQOIHWgyR6Il48FuXiBEBe/rlk9i/egp0/9kLxYF5DlWKYnJuOHGYX6tWXpRf9csuMkpw4nqx9Lt4aq9HOwyuDS3B/h66+KDnhGJacFPs5pJP/K3oUhdOZkQ3slvRjAa65021XwxP9jKnzCHiju96fTACFK1swTW7d1yxihrRxAFKMaLubT+onHHCbussUW7Kb/NOODoSFfpd9whiwiuz5SHpCHr2in+apt3KEjS6JNhTApfDm9378yLTTrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KXvKYrE9Xc6ImlEWrTpDkh26ArHrrhwjqFE1/AI4ZQ=;
 b=Xu/pQoH2cfxFLqp9PrIV4BDY5+CMboUICxOOZjiuvFOXPl+iLtj7N51IXSLAktP9WQChzi6SpAXG00HWg53U33MQWkgjRsmbjfcScb4aWF73pkxzGFRuDHhcaHsQHKEPKuafpZOBKFG7LLGWS3M8iIaCBlyjRdHjJ6juLkQidNXQqufqgecX3lWrmQZt5QducNvvuboJOTowKm7LWsheWytf+coxzeYk4N/CvxZ6ApiK9Xz1WPC2Hn+mLPsIEKU7Z84YOQk+v5LbzeEjDDIWYn9aAqsYqOl2GPARofVO2sG5dFSM6LidPc7Zk67hR4C2p0PtxKgeRck32tx3mzHV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KXvKYrE9Xc6ImlEWrTpDkh26ArHrrhwjqFE1/AI4ZQ=;
 b=WmE/JSyR3FriC/C2TBNQX+F2pVxk8KA6MPbrxog1igXWr4jxg+b/iFBL0tQ2ZTEQW1K7Q3TVSj6oaq/ANFDLFwctlFsI+Rpi3mbHWnUd0KNMKRgg9dnzDD843Lzw0cGiivSWSn5IgPCvGfGCRDsSwagEEkwY2iLGURc5gbVX1/c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 09:19:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 09:19:33 +0000
Date: Thu, 17 Jul 2025 10:19:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>, david@redhat.com, ziy@nvidia.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fault in complete folios instead of individual
 pages for tmpfs
Message-ID: <fea0d5cd-ad63-4fcb-a425-bd9b0d598006@lucifer.local>
References: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>
 <20250704151858.73d35a24b4c2f53bdb0c1b85@linux-foundation.org>
 <4c055849-d7dd-4b9f-9666-fcb0bccf8681@linux.alibaba.com>
 <007c4a94-c94a-418e-9907-7510422f8ca4@lucifer.local>
 <23f1c3ab-16ca-41db-b008-22448d9e08f2@linux.alibaba.com>
 <d0b24095-d7fc-459d-85ed-9c0797e9fca3@lucifer.local>
 <3bf50873-4d1b-a7c7-112e-3a17ac16077f@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf50873-4d1b-a7c7-112e-3a17ac16077f@google.com>
X-ClientProxiedBy: LO4P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: b06dddf4-7eff-45a4-fed6-08ddc5130aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o1a/acy1O6soyk12mejdEo//5qf802ZiRq8kODDUZzpccMzkdrp20m/ipzhp?=
 =?us-ascii?Q?s1gHQLzbjZzXZbC3FTVHPtHzJuM/yIU++52nNV6ll0BfUwkT5NdwFIeKnog0?=
 =?us-ascii?Q?ldyDycfollvt+3qLjiWRmxChpg5PzKNXoMRDUYUpua1Z+YxubQTVLLSaSE13?=
 =?us-ascii?Q?WHiWgleu09Q7vtjt0ep7qJYuDXLOhPrmLciL/ctMPMfaj9sNCZVgTp1CKC5a?=
 =?us-ascii?Q?cgO+3HV96teAvdhij49tZhie7KdvoCxyWuxGr4RWGsKKbjev7bP5rdGqKB73?=
 =?us-ascii?Q?CqEg8YbT5Mi3prVnCu5KefWVDC4vU9F1hu/YnfQ1ckLpU7VuxXUjvWFTrHYj?=
 =?us-ascii?Q?1mPDdTvGKazj9ldInxyFWkV/FgxDJsm+CqbW8YGuRUmdcTAtHqgSKbw7wmPn?=
 =?us-ascii?Q?xtIt0ANJQ6F/pahZ4YgYB+OAdrNYIV7iOM5yq5d6ZRU0xMFgp6ZNwCnlQHIC?=
 =?us-ascii?Q?FizOqtD3Snutj+Mvjd4RVSxLW0MpyzHFWo4v4YUqQ0Jn2ODXy73vA2gYJQHl?=
 =?us-ascii?Q?s7yr3juS709KcgbMGSlKg0yOVH9qitW0y5BUD5K7PXMuZzgvpo4wlP3hQ8Z4?=
 =?us-ascii?Q?g9LYH6jid7sWwqlLG8pvH4QooNegc5CNoP0U8pchzPJtW93687NO29KBXC5i?=
 =?us-ascii?Q?dOZPDkeZMMX8DsEK0dWy6iFi6b9rLgqq8/OEvfoIydnmx2Tnw37AvlPI9UNX?=
 =?us-ascii?Q?WFBBCK+oRt5G0dUxuBmDjtDjEGwbEsVDF2j8XYZNY7UJ6tnjCfyNAfom8ppi?=
 =?us-ascii?Q?fh5c0eY+iPqEPcd7Pb94cqZ+KhpLX3zHKoIaCl0ZQKTMe/76TCpe8LyxZOWq?=
 =?us-ascii?Q?7zsf3Omg8nJa9ebEyp9H1qCIcCAB+QcirnEJNHQIRPTkizzr3/o4W7YO/hHr?=
 =?us-ascii?Q?b7590ticaH2g2jg4gdHAamNwg2suovB5zhN/vNSC3OLDfnBqByz9W3g/33St?=
 =?us-ascii?Q?DXClChRqldb9LCoxSWjar8p1cH5uPZPr7iuLWYZMkTYT80fCdLaoR520BOLv?=
 =?us-ascii?Q?GQ2RJY4/R37xCAdprEH4zqpj783czgox2D3YvErWXi4EsNB0/iNFtgT/692b?=
 =?us-ascii?Q?QmMKWCGVksBAwEa6WP0NcuugepS9sYfVAZHn8kldqvx9eebF9nxfRWkNuxfC?=
 =?us-ascii?Q?AWDNtCnpPTiwrWE21dc3d9RBXpYdC23o1RQJBV40VvQikC6TPY1PZG6b8t8z?=
 =?us-ascii?Q?07uRF5nSO5L9+ayEnDnr7l8+NnCuibgXGkl4NmnY8jUWeJJb4a38voCB4Qmv?=
 =?us-ascii?Q?Lrk7W+Xun/OUHTwIQdvILxmRQ7VX8ry2NuesHAaa2HR3fGVo2Yzdm2DAaOVr?=
 =?us-ascii?Q?/9fzwNlFGaB1VMd+FXyOJ1RXyd1uLwx9+8pSzokPg5Rtn69q9xjyDdyo6drl?=
 =?us-ascii?Q?gqqEerSNO8qD2uF6yVX73Vobve+xuCu1tPzkLNdBWleOrldK7JYe/Y3j6l4K?=
 =?us-ascii?Q?uqyy6OsI7og=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W1o6R2LUf2Buzh9x926I1H7rACnA3ZN9AHiYYawPfpHs5nzB+rQGFUo9bteK?=
 =?us-ascii?Q?MYhN6o5MYoE46Dy38+HxjRGvMkkvUFrLlzv1H5Q1vyAD/6g2talewgYK9jwy?=
 =?us-ascii?Q?LRIKTQJ3OYN68QxxcJVD4Vpa8j7oWMUezf1g3PdHB+xEqz4Ug5fK+z7DguKW?=
 =?us-ascii?Q?fuvhHMvSMiqlFDS/K+c5e4FhthNFyhcj9J/xCjukI4DqB0kb+uDocWngk3wX?=
 =?us-ascii?Q?3kxmdV4pbd2ETpVcSWT4WH7WLdyJKIK+OYB2PRTQ5jlYW46uy4m1S6Dwic6T?=
 =?us-ascii?Q?1eDTfygW8Nz0NohiAEtFYVA6dTonMMzCPXdXK2Z0Fg020YzdSFfvy+NiqK2E?=
 =?us-ascii?Q?2fchDzlJCNLs7bgeFc5CnQfPQX+G/1I9a6cuQCMIqzoU3Y7OfYqEbLNQvEpa?=
 =?us-ascii?Q?1MsEFmKHqtS1lwwyh91iUBt66Bh0e4nHyt0aUdc91/ePBSCBSxzsN6TXgn3P?=
 =?us-ascii?Q?lnjNrkXVDkk7tLvjyyjrFqRvjzXaosiavZhnRg7q7mFBEghu8QtsmCku3J81?=
 =?us-ascii?Q?a/pNT9uXAnfOQ5hkRyBFQS9tmptbCynGvWD5tJgoQPo9CgdjNFV81+hNbObP?=
 =?us-ascii?Q?Ugv2AncAFeh+fUIhqx9ovrXfvIA4tJdXUOF655AOyheZ8dklghKEL3KFTnbb?=
 =?us-ascii?Q?FF49sFQLlMVYrelBFYLSKPaQp3F52JrmUko3J6v+Ti9FOO3yr/jwMs2w9pA6?=
 =?us-ascii?Q?uSVfECjIs3s50hiZ/MCk8Romb+7mFnVNydeXVYDJilPr/XMiGQv512EVD5iG?=
 =?us-ascii?Q?2zKnLMU0/5SqPF35/GUu/mFLI4E6zxa8KeJIf/OIYuADRYBqB83u5by1QORG?=
 =?us-ascii?Q?tMVSJlnbkR7sWD5HeREt/O5MzIBIBDG7QhXOvqKoogS3ffnuySwn7CxkZTCj?=
 =?us-ascii?Q?S4zTwCZRfRNqgs3U6sb/AICNWNZjKTcTWhmfk6leRW3RtLop7YMbYVyE8p25?=
 =?us-ascii?Q?0rc3s2ZUD53LkjBRYnMTulVS91SPRAHzs13JsF2K3SAp/bilBgvP93X38OQY?=
 =?us-ascii?Q?4x4L2wbLuDxcm+K+QNoV5N6zslEJcwh3jI+6U75vyqFns8hSdejjbfOAGbuU?=
 =?us-ascii?Q?7GIoBA68lEstf7jLxqXUank1NHVi6U4sWQDDnKbzNuj/mNWZSF476Lct6cgZ?=
 =?us-ascii?Q?uv1rcwhxIRKOvPU0jjPzstckwu8RtHTQSQbR/RC74iO6YXo8+uZ+ewQjmwd2?=
 =?us-ascii?Q?AlR6drrAbkoGr29YStF/0tcRh8gexuLdK6ZbQJmOX5y+RHpDdeoO7hZgM2ji?=
 =?us-ascii?Q?dFZYJ1t2r/ZngY4XbDy0lJgsuYjYty1D2yLrT1pT3sfifmQKM8JUh0Ggf6AQ?=
 =?us-ascii?Q?334KbWeT21nFfM1OS3Fg9kIwylak1nkAROOAN3bZU1xpLxream1xJ67AKfJ5?=
 =?us-ascii?Q?uGePl9TgcEEKB8xDvvjJ68IeCwHpYvSspkUsG/cWDxMDdC6d2TEsANJiAjXC?=
 =?us-ascii?Q?gpZ6kGVwqR+sEp3FXWtvtPEITdxfDbf2fg7FOKCvb0L8NCgfACfo0/+EDk7h?=
 =?us-ascii?Q?zaDLN5Jrj0xGWMWcE7A3/LkqFVIBj/UenctUaWB0jvSc9/CDUTnxS6gEXvWl?=
 =?us-ascii?Q?HgFKOTf9oPlNBPLuW7H4NyFjQrfmxxmBGDj5lhwH2WRaHx6O9vMXaAuQIarf?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v/Bl3atrRqPKyjY3KJF6pV+5GfvFZmW9vGNG/YjH/wOm2ZIUjVGKdfv3Y0o8BtiwNqgwAcuvnJr2EYVcJD3vDhVJN4msTPSjgbHnOLWlk+3GF5I2AR/+2uvziQLuSUyn7xeY8qvg/YWH7pSzsBxqbP98+TT8bgzhR2EapUQGuy2WFvm5bFWLU5YusVHsHN79KKs2wkLnHuRbEzcNJh1m6buC0w68oLsmCh7pBH/49goMB+Otkle02voYBQQp1QkeGkaw1kWxcwixwrWctrRoMsBeDmqGRDtmTseXXslQPV5j0pBsGpFizAFxZZMzqygUhe3iydJNSja4yy5sMN2W0oqKRVw3ij6vkm9b6WZxv7KxqrG1vRbrrIcIvik58tV0nATh2zW/Ugmsao6VfF7WHFupD+3jVtqe6wFRyoaamcgwXJwmPWJAz/gWVlyiw2XMhdpirF+ehHFBKD7qj1/cLl4V18EUwJ69A+GNxbKDyauALFnC+istWdq+MBxsaDDDlMm21B8uCIKVPj8x71NOSO/EiO+QSidknc8CaGkoYLiPGXhW3BAeFYV6NlAJwk4lwgvJc6k0rpSGxD7hbxru48Hpj2phO3+Fud524D1dKak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06dddf4-7eff-45a4-fed6-08ddc5130aca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 09:19:33.3383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7v3UEWzPhhrYEJNAP+ubMQO46IBXKeoF6VnnsK+2cp5F6DEv9ohTW4aj4MDP8QvcoKVJesHi9AJG/1Qpzb4T6dNh4eEOPyql3iE9kGNEsmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170081
X-Proofpoint-GUID: PlQy44PSc0Hkkz3c9fNg9n9NPtWXLk3a
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=6878c028 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=LIa6L2LOgPGLNQ-dgD4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: PlQy44PSc0Hkkz3c9fNg9n9NPtWXLk3a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA4MSBTYWx0ZWRfX7ee1qoueD8mJ N9mf2/4w2oSDqBFlXlMndh7Cepm816PsOjS6g8DLS4KeyeYcWekzm++C7RRQkBefHgH0axDX3rK J/M2kEMoJ+Znq/s8gEvejedMHEVsv+rBMXHCME6nr3Px7CxBRUCP9qbl3JAAfw5Mw/gYP1BP7z6
 Ulkbj8LmN1sojLG+bY8arKBf22UEjxTuk3R/u9Hn0io4OFcyVMi5wCaa77fLPwQ2fDy4XfgDWWN Cp+Wg42UoPZRH5t83M0LyYM8vGdVtv0n8aYc5qjNOG7E96kjny0WTeK+tDMTUgwfshg478v6VuV 20nYUH8oEqbrTkWlJHCK1HWc86+zAeR1DWED20TEc+k2pQDXeqDo/UyECB+p5n9tvL3av+Nn+PE
 /FvlGyvEKZl39oXNOHDCh0iFv7kzLIpJyzbceoE2WuNbK7IECdQXhCMc7b1rBikyYj9V7EyI

TL;DR - I am fine with this not being backported.

On Tue, Jul 15, 2025 at 01:03:40PM -0700, Hugh Dickins wrote:
> On Wed, 9 Jul 2025, Lorenzo Stoakes wrote:
> > Well :) you say yourself it was an oversight, and it very clearly has a perf
> > _impact_, which if you compare backwards to acd7ccb284b8 is a degradation, but I
> > get your point.
> >
> > However, since you say 'oversight' this seems to me that you really meant to
> > have included it but hadn't noticed, and additionally, since it just seems to be
> > an unequivical good - let's maybe flip this round - why NOT backport it to
> > stable?
>
> I strongly agree with Baolin: this patch is good, thank you, but it is
> a performance improvement, a new feature, not a candidate for the stable
> tree.  I'm surprised anyone thinks otherwise: Andrew, please delete that
> stable tag before advancing the patch from mm-unstable to mm-stable.

I understand that we don't arbitrarily backport perf improvements,
obviously :)

But at some point here Baolin said (though perhaps I misinterpreted) this
was an oversight that he left out to be done then, in effect.

But I'm fine for us to decide to treat this differently, I'm not going to
keep pushing this - it's all good - let's not backport.

>
> And the Fixee went into 6.14, so it couldn't go to 6.12 LTS anyway.

On my part I was talking about a standard stable backport not somehow
arbitrarily shoving the two patches into 6.12 LTS... to be clear!

>
> An unequivocal good? I'm not so sure.
>
> I expect it ought to be limited, by fault_around_bytes (or suchlike).

Yeah...

>
> If I understand all the mTHP versus large folio versus PMD-huge handling
> correctly (and of course I do not, I'm still weeks if not months away
> from understanding most of it), the old vma_is_anon_shmem() case would
> be limited by the shmem mTHP tunables, and one can reasonably argue that
> they would already take fault_around_bytes-like considerations into account;
> but the newly added file-written cases are governed by huge= mount options
> intended for PMD-size, but (currently) permitting all lesser orders.
> I don't think that mounting a tmpfs huge=always implies that mapping
> 256 PTEs for one fault is necessarily a good strategy.
>
> But looking in the opposite direction, why is there now a vma_is_shmem()
> check there in finish_fault() at all?  If major filesystems are using
> large folios, why aren't they also allowed to benefit from mapping
> multiple PTEs at once (in this shared-writable case which the existing
> fault-around does not cover - I presume to avoid write amplification,
> but that's not an issue when the folio is large already).

This seems like something we should tread carefully around.

>
> It's fine to advance cautiously, keeping this to shmem in coming release;
> but I think it should be extended soon (without any backport to stable),
> and consideration given to limiting it.

Yes agreed!

>
> Hugh

Cheers, Lorenzo

