Return-Path: <linux-kernel+bounces-733390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D632B07412
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DC1505D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE02F431D;
	Wed, 16 Jul 2025 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nR8WndKs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v+RIQfce"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBC2F3640
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663332; cv=fail; b=dOXc9Sy8WSYw2hha2LfmpScUd5BEI1HnxwqHAB4jMLVjdfnzG0A56/3QI5hK64wwC5WuS7vyBoxZNUZr8CsPfRWCIFJytto642nxja7jP0dW/3ub+gfjKKsi3gAdLTm/C1if4K6HEAhJVkglXaakpzV1JhIAg4avJBZ7qpMs6Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663332; c=relaxed/simple;
	bh=jDIfIMN7DaGQv6pB5pqM0kaVLRYK2iEMkMEjk6MdPOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JEmW03kOHoTryCvnr/DOdT/Xbl2p5xUQqDVjOh4EdS5y5PYKtGWZYQ6t4pzA/7g3fwjyAyhEUm7eDKr/8tGsdUTisl1CVX95ifInS6xkB75I2l4amofU7ks1Qc7oUc7JfyVCnV/Ws4R09p1f/xog/vl0+pUMH3GaVFbanrIFNEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nR8WndKs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v+RIQfce; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G7ftKn024556;
	Wed, 16 Jul 2025 10:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YY0cxskSVuIIe4cRdY
	+W7dF3DWpfDU8c/IJabXNWr0A=; b=nR8WndKs2/9jcHER4OFG87l6du4n8rJ1sX
	VEekdAI4f9771oOB61GNBBmALrXcZBZT2t92eslO4q1c9C5SGwFeuBHk8Z9JIxjY
	Uwv3An0HqXsygMnt5u7cQAuEGiwjkkjFMEi9IM3tSWeFCZAkfM82qALS70hkRk5b
	Q1ihVW8cM6SQ4Ny9odGC4UWN04ljeQJXZXuKGmB1RDKUTLREjDKV7FdE0tsSyOWK
	KHIgbIDmrgLUHR/dPoYucqu3UT3FckUgbkXP2SQUDWAgMzq7bMegTKJ5LU9GTEa2
	feiQReUJicgJh7Xm5cII7GyGF3ks2Xn9xuF9d9PBEq3kUBhn5p8Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk670d5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 10:55:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GAGuGG028989;
	Wed, 16 Jul 2025 10:55:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5axa2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 10:55:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSW+g4ZlY8QTIOMiohn/9MTMW4BKWzUmRQq9XY6Yhx0SddmdJRrMyjP+TH6LmgR2Y97QUmSIpG3VKe3OP63XwcZdSuuOPBdmLoByLvpLB2GNLL9Lj48DVTybHUCktS1nkK91QOOKmiAMUo7UD05kT5qsm0ajPXfqC0E/RakQOX0kj0tiTXsLWCdEWg1dLf/EEYNqcIJs1DQYYlUv+94a60F9orvfecobywXkid5ocoRivP+3H4gsVRhiz5hSObVIXMENS8Zh6ICcDXQ9fry6WVDdYHfM+LpuW7EG85RcpHOXb77ujIVlyTx8yYtyZQ0CWrxz9fdsZ4o57Y3AB10Y6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YY0cxskSVuIIe4cRdY+W7dF3DWpfDU8c/IJabXNWr0A=;
 b=JNKn5luIQKCHkcuvdyWPLA+1jV1BnUDU5/NdoWCj1t1QU/mlyJF/QpA8pEScIDhyCTQ9t+hNXL/Nv6KdVz/4HT8Nzm+tjNylLUb+QDa0hy3F8lXSaydq6N+Na2W7ardJKTbKkHDCup/qdbG4GI7itbm2KED4dF1u8lWb1yyuzamAp4N6SfivuQRpWIX+r1K3qzYK9jVQNYwnCmlU4gw6IGNKAfC1S7X2RNf3fMoP39pRyoZ2Ffc9EU/doWSqz8tFHXdZw1Kz7KmVcOu31+bDl9YE5EcbF6lcbQivJ8TjPGEum0GIe0twi9WJamup3UvlGEc5fBxDPmj9u/T3dnwXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YY0cxskSVuIIe4cRdY+W7dF3DWpfDU8c/IJabXNWr0A=;
 b=v+RIQfcevbymUBSPvcrnmbfbBmuXB8+RsRqrgn1YC0rvee3J2BrL74n9uvIMUWkY5ZNiitEZTFXGNAJE9R3hDloi/DfjHQze3Wt43T8Px3aFW2MYsBNXbwWjphbHd4JLABQkKvKgd/nO4QWifMPvD/Pk4uxGVzTWg+Yla+M0PdI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Wed, 16 Jul
 2025 10:54:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 10:54:54 +0000
Date: Wed, 16 Jul 2025 11:54:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dishank Jogi <dishank.jogi@siqol.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] "fork: reorder function qualifiers for
 copy_clone_args_from_user"
Message-ID: <45b037cb-9847-4d9c-90ab-b171e3830ab6@lucifer.local>
References: <20250716093525.449994-1-dishank.jogi@siqol.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716093525.449994-1-dishank.jogi@siqol.com>
X-ClientProxiedBy: LO4P302CA0026.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc108ac-0ab4-40f9-dfb6-08ddc4573259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d+30R4JYbUvc/pcJr5TDBy3+u8tpGF+nglRKwZGkwYsyT9NCdcfWc1lVPad1?=
 =?us-ascii?Q?Nkf4qhK0xOhR5V6tXBIoV036+AXD8L0J9pOQYNepIVT9uhyUHKtwW3md9yP9?=
 =?us-ascii?Q?EZwWMfjMHG3scZ9KcGQqJwY1B6Lpl5QTJA36IvzpKso2V4PS0yIinJw+EjM3?=
 =?us-ascii?Q?hnCaCJKBNnveCoOWPwbkWRYJoygGnFWUMueAH7/DkdUN0633LZPaRuptnunO?=
 =?us-ascii?Q?SOhSDNTK4YpvneWhl/z5b2gOa4K/k/N84VZ78WWXVPvDEDCshjpZu93AvUqV?=
 =?us-ascii?Q?E9HHLREpy6uWvGwy2aHm6+58kPPrbKlNG7OuRUccLGDv3JxrQaOGIIITfjBy?=
 =?us-ascii?Q?T8Xnk0K0ZzbXFJGi8ca2tGuksyiPthq6+CsehLkay4bYbwWdNu1+UC57ZaO7?=
 =?us-ascii?Q?XKzAIUNI8mdPCqiQV+WD68OHGK651ajqbdZ0/qcLj6W6e9114YdBCCxv178l?=
 =?us-ascii?Q?C8Ok2XGIJAUBRMMxUw6QUaxsAGHJnaEd9diiCIL1C2u6HF17YvDzUVW4YiP9?=
 =?us-ascii?Q?+3vovLt4Bxbg8YNzZWe5i/kfdBYSSYZV7arkD+He4pxptODYszvbLWGiz2eg?=
 =?us-ascii?Q?nCNCP85X5EJyx0rsJJYbbLxTOfQFqOW1GjUhekaDT+t8zTTENZD5wHyI+O6V?=
 =?us-ascii?Q?bQ+ByzJYEaXvV2l2Soq9zNFq9a7MwFKMIsnjYjHV3Etyf1IPLUlwWxoenJTb?=
 =?us-ascii?Q?AjkptDBk3/CdNBB0nwX8CMgjqVfmXvK3SQ5lRJdZBDuYR/RSYezNkpkdDeI+?=
 =?us-ascii?Q?Xw9F9w2hXjNS+u7p8zdrucLr47mMQLHR8kmGo6GkLMi7NncHoePCs3pvtNfP?=
 =?us-ascii?Q?EpIhx9RE+oyKZcy/90I4VgeMy1AUON8ZHTL0xvms+EB5odkFXyJ1/5Kr1yoG?=
 =?us-ascii?Q?lOOPEJb/sb6lRp1pS2ZopSfgmRl3tCiJWO4426mvGGMLjm4uAGCwnEPjfFe+?=
 =?us-ascii?Q?CPdYWM0OlDt8nUqA2rVOZS3D2e/CG2QPrcTI1tA3pVa++IorZWr8pvOkLJXI?=
 =?us-ascii?Q?5Lllfc5FPJjY7z8eyRCuKDQewrL2op9FHZ4uPupGypGHWg1S3/EZ1GZ7Ouxt?=
 =?us-ascii?Q?4hNTQ+ZLrRbS8YRIxo2uIh8GrMXzovAB/8f4CPeXIhx8CHN8oU40QrA46ofZ?=
 =?us-ascii?Q?P+VwwAmpze4QJy45EBUlBaiGAnDb6eqtiKSx1mwzs8wNm7Zdo+IeeuHJ4PBZ?=
 =?us-ascii?Q?6iNRMxZwZfmAq5nXi3EcdcVI9akA40WqafLUPN9ub8cyeBkPy1HfLOC1thXr?=
 =?us-ascii?Q?ZlAGmPoCKsNTrEIwifROGg/kF4X/Oq3FPzCgW11FY9Nj/GuswD6L0GCkUvgK?=
 =?us-ascii?Q?chZ3yLoKLeiVFAwaIh/zvGFHhVdsYLPuWyCEyS/aOZikoFWbuSrzZJUMP0HR?=
 =?us-ascii?Q?Y1JQ2fYWyc2eYvuOP3rkLPNhw5dXNvf4tjcLmyPKWNBQ1OVW2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zv+I8vTrZWFmzW4swWbG6460zhnkFlZJCLWENZZnO9ks82org6ubHm+l4DDG?=
 =?us-ascii?Q?fS0lrvxNowSFg2eI6ang56Ge1JylaJlaVpEgzLPUxVNs0e0xYb1Wb7Df7dDL?=
 =?us-ascii?Q?RzVglrVOaDUOn30oKSyrlvw6lt0yDCW4c+cSH5haKNCFwqa5YDhgwtHF3VN6?=
 =?us-ascii?Q?Czv206OoyBROXPtCQZR9DZjLdcLpJMiaG67hSLlugTtsfnFF/eRft6OF+W95?=
 =?us-ascii?Q?29oSbY2VQ7nJGWNaxYQrUnuePX+hm/AfvRLpDF5LJgNaAa9457jkv9mJMX3R?=
 =?us-ascii?Q?qnM0VNyarpDabTx8KN0ylASHsQdqRHqtFtjQNuYAOOucC8rOC7Yuop5t+K3/?=
 =?us-ascii?Q?2CdYe5wzm8cKef7W9rA0gLqHzGYducJ1iRxOQIiQ4Tfhng+fG6i0DOhZI0W4?=
 =?us-ascii?Q?L7tSzqlXKP+eBOQP/9Y6gAOHRGrKX/+WLhxdMj3cTx/yqQOLAXGVOUMtwc/w?=
 =?us-ascii?Q?MgRnizrvGcobbo5/VANa65qyqjbnUpEK3TKIssP2dYhHFc45/j/xtvGsyA0a?=
 =?us-ascii?Q?8qxOYERx2j0ubIK3B3gDs/lrBw+JwwzG+HLiQ0+XR1EI+3noL33O5x5k4nnd?=
 =?us-ascii?Q?qjlCsI/8nXLcT0g9TGWcocpRTurSeJLIGkh65hdRjyH/eT7PCnim4puwdb5x?=
 =?us-ascii?Q?gbLsFALhN8gjKzrKx0h9jfmz3+HhTHA57uUN+td/CUM9MCLMOKOTAuouN+zW?=
 =?us-ascii?Q?B2Tq9ZbnDiHxm1rj/ObZQd6actOXqYt8oN1k1tcRFjgnbxrBlX/9dRy2MDar?=
 =?us-ascii?Q?jkWKWPWpN9Zqf8Zv0vJEvOSrU7hub4oTZ53pDbPdRMue+Rl4MltLI3+Ez8bu?=
 =?us-ascii?Q?/JGk7k18oyvRyCESybKulnBPrfrDFLPd+oefpRMInOAQeekhoOxuW1iIxMEE?=
 =?us-ascii?Q?YzH1ha1I8OvnMC335RxWRmoBKbomP2dW912bayNJEd4Mt+QFBbql3Bdl59iM?=
 =?us-ascii?Q?kvVVVEaKe481OdNR4AyatPrlizUaj/aDSsxUSUS73bPgcLsjLLBB91lS5YyW?=
 =?us-ascii?Q?WaboUYdcDPFe5ehQ17MEGMLKssu17ctN4S6ezkGe6aw+59JfOYyKYJFK7/zN?=
 =?us-ascii?Q?pgx2vSg9LW0tt3PasREuXJ4l6dPhOu3CHcIZIoeWNnkvUXhKAHgWBGXGQdEY?=
 =?us-ascii?Q?SU1UBrFvnVWjRnkJ6fsUTaxeayyIP5xDo4e9Ye/+TfqLiJKSGj5x3jq6QxSa?=
 =?us-ascii?Q?yXn9klZ2e8OVimI+OM2mZY4eqLPhOm4htnkjhsFS0gsD2Jv/DnuulRwzJRoO?=
 =?us-ascii?Q?mymKo/CIaaiUx/LhMjgK3HduXnB8i+i8sV4Orjhv5Fjj0fjBA8N+gsO9f22z?=
 =?us-ascii?Q?BfSNWtOG3Mo7zceByWqFpvY6aTXqWIGkpWSCwSYi+gTpXaeeHyO9kE28Z4Rw?=
 =?us-ascii?Q?s7LQtY8xRQD8byDm2RwNhoJxUnr9jDqyG9hzo9+3+41vmkOUMlC1fHajPQkG?=
 =?us-ascii?Q?ePVgCUCTHVZiby/ZryolvshdXgNBViQ4p53QGoaQakmhm6fE9pnzLzrOpRKN?=
 =?us-ascii?Q?B6J9lfBidx9V6CP56LvP7j++ZmKJ3GmSXVK19Z6Crgsdy8sGJPfaaVwHD740?=
 =?us-ascii?Q?mKLCqIFdTPo9Vk+DVO/14w5vgOdhCShus2kyWThZs+U5sz7PlDJDMJMmq/TU?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T8hQO6qbmJzpFTUNRc6Vvu3kvhcptyM2fVLTTHrSdPeFYq6xXvKtkhyC7zgDj7fGqal2N//phNoqECfLovbPxwreLUNLt4vrjbTRcQuGJLfhELs2VCi7YLDlTTYrI8qTbBEBw5o8y9oU6lALqJIoVDBEmqB9ws+z7aLyIVu5F+GO9+rdEmBAwyJECxCs2gcD+8J1nNziS9Y92E2GMbF6UdB/ZbLR1BQ+OYsajAuO+N61M6hoj3LuMVDQ90UhWnBiQKIGp/0z6XCRk4y6bfFEKACRSKP6TgSkr4zz5TkiGyqhO5ulsfRqN9QeugVf/Bz8sIbwf3T213abhwffnVSbSAakXITDMOgwQ1KTC5SWprrGS+d/UtM0D7XMnBo5QtkTsbGSIxUzb8tPHMuG1CJwUGPjMnYz8nuSGwUCirSfzAFV9f0aTXtCW6ixRC15orvY51GSmgbVV9iJyi6P/w9rpcFdSSQ+VtNiCjJTaE/VvHb8/1Fh/cr/m08HRzO7rYE9mzyfnptFWWIJ4+n+HWc13T1O2GlXQe9oZTWpu0Zppt3p0ZbhmXlQTnexMRsUkhTppiFJ36m1eI96hJe2WxJkbVdYr6h7tMp2lMglrI+pVsw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc108ac-0ab4-40f9-dfb6-08ddc4573259
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:54:54.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FGC/eIExm35vWTtLqL+Yi6bTsKL7nMQw9GNaotJT6lNzK0c3UUHYo3wvoG09sNCdPeAfbgSahmhfBR3bGI+qQHD7N7Bhwb1Mv1r6v2Z5bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=787 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160098
X-Proofpoint-ORIG-GUID: C1ec2BpA0oZ9Lgk0Q6cBF-YfmAV4fJ2G
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=68778505 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Dk1iwPu2AAAA:8 a=yPCof4ZbAAAA:8 a=5K5Y_2Jo2QQfheOYPmEA:9 a=CjuIK1q_8ugA:10 a=i7bt6S_etotbxtfMFQE0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA5NyBTYWx0ZWRfX1kVQpk2B2Jrh waa2Aes6N8HxsKtQSnf0C5kCHCql7QiYxy6oF4O4EB3KR59Qjqg8Y4xq2XctEclImuHFjUzI4d5 iZZ56dG3J7vhbkQaJsIGnKN0QaWPN43dvIVO28aY9+sjsoPlfvzMRGTZFclSDxl+sk/HJrn+jgd
 Gj7OJunYj1fDd5DHcNnBfFICtxVWcGpiKzCI/qGaHEsOesa9EPeqvMCml9pmwQbv44e0GxuPjHN EZAKKbRq9WCMgtyqnopDXYY/zrodmPOo+GSK4qTc42xemhkn2ePqUX6j4DjbJ9bUXWCPLVqArXR P04Y3zgfx4uEEmIgZWsA+QGT7JipRgLSyGLYqdCUocJmY5gR7Z0N8BcKRyKcpJIenGxdF4PfieN
 tH9+VBm0Wh+fHfyRLxEDdefuTN0dE0aLlwuYxJNBHewIIQVKMSJt8cdRke/LmDv8k00OrDtv
X-Proofpoint-GUID: C1ec2BpA0oZ9Lgk0Q6cBF-YfmAV4fJ2G

I'm not sure what the "'s are for, hopefully whoever merges this removes
them :)

On Wed, Jul 16, 2025 at 03:05:25PM +0530, Dishank Jogi wrote:
> Change the order of function qualifiers from 'noinline static' to 'static noinline'
> in copy_clone_args_from_user for consistency with kernel coding style.
>
> This is a non-functional change intended to improve readability and maintain
> consistent ordering of qualifiers across the codebase.
>
> Signed-off-by: Dishank Jogi <dishank.jogi@siqol.com>

This seems fine so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1ee8eb11f38b..574ff0d983db 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2743,7 +2743,7 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>  }
>  #endif
>
> -noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> +static noinline int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  					      struct clone_args __user *uargs,
>  					      size_t usize)
>  {
> --
> 2.25.1
>

