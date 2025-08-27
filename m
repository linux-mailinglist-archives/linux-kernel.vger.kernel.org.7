Return-Path: <linux-kernel+bounces-787770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB976B37AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C292A1B64824
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A6E2DECB9;
	Wed, 27 Aug 2025 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B8rfGT9z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GLtbR5yz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF02283FF7;
	Wed, 27 Aug 2025 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277572; cv=fail; b=Dt38QygAegPx8MVQ77GiOvQ7A5KQiFt/WZpIpvk06GHr2+XMOdqcUkH74rr53p/y57wktZenXwfjuzw/THQWiyJIFLMzwW6WVSotChetU83VrAXh4CZfFZKYEF79gIM0XNni84QZAvYIbkTQ48ksOWJkOwbM1DhVgym+LLEJAWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277572; c=relaxed/simple;
	bh=gFipyMRU3mHANFfpFrPx1HLWYslx+3OGzLnGGFxKUd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XFe9fhxffx1DtbuUE/VQjGtyH4qOLLKTXrzC904V89dBMUL3pq1nj7ve1PJWIt8wxZuuFQ8ft+BxH0d11jl4zStMPSGEivclxA80SbpreYKycWhJBymMEqUy/NMRsRyM+bWxEgITltQpgWeMxwzUeAVwMKsf2BT3BfxaliKz0vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B8rfGT9z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GLtbR5yz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QLLQAG028451;
	Wed, 27 Aug 2025 06:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0YfkuEQjMZuMgk+r/G
	SnSrGGQOtdeChizNadTGPA4yM=; b=B8rfGT9za3g0ZzRBtMnOdyVAcZmY3U90j+
	VQEWhoSanWLrl3OW5SIx9cyK4BvpY7eWHftI6+Kw/FNloZXIJQjaRVGbnVAhk177
	luOwhJoaIDqmKQLG18MWTFGQ2SO1CTh5hcrr1zVVGa9Y+heJxkJQPhs34HRgk2PU
	mrpMYwz2iY8uMa3M3ocVku09yel0z8EPxzopiDQ77Tky8puV6ekC9ZRAAkMgLeJg
	DcRSXgb9FiZUuj5fAdBlJkeyuX5cijeXwfS8Xzs1Va1JVGSAD99oazxZ8Pf34qxN
	pv2fkhAgXoNIuw2yshboiLP7G8N66abt6/P4yMMehiJF+wLeZipQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q678wx1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 06:52:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57R4DHBA027083;
	Wed, 27 Aug 2025 06:52:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43aa5bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 06:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU7EYqHV2kvbPQtKmFdLDo3Sjt0J+9IfvlDS3CgKKS5yvM6KLBhT5z4dzQoEQkO85eMqv8BgUEfNHhjb+fTqcm+VVP8q+Y7YUl7pA0SUlfAYJrhJrteZpKLED40txvCSLFHU1XIonOv2OtY3BqsNyNtnJqKVLA4vIcgGvoaNXNVnnqIS2+fc6fDM08aZIPYtUqSFq1fBpRS9Ify3l99uoj83lW4HbzYBJ+psxUGgeUU+9fWFTC1mLCL2abbaTq4n1kxHwh6e6ujiRWuHzotniwjiaalShs80u08FJuuHN7ecFwH7aIBzYwy4VSdfppk0QkjwvRTav6gwRErMcBXhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YfkuEQjMZuMgk+r/GSnSrGGQOtdeChizNadTGPA4yM=;
 b=O/I/wH+2yC1vuYZ646dFGoMi8YKMly2F0Yz+EJyTURY9v3BTRyjJ+7xkqoL1xXEdn0Esn10tYuFuI0ThaPWIQtGFn+Iiqmy05teoOGy86uZ+b141nGTpCScHbD4+Z3MYVgp+wJuhgtx8L2kZWKjIVG8l+ihAKqgeixntabAFTT6sb4iX3HuAd+TIczAEFj6ukfJKGl+a2qFx3r/tIif06ohnYPvEyvBdEDv8dS527/c1Z6NaCqmUaqDJvPqIBfAn/5CwmYTQATYvBP/nrbNkjyUZ8jVUJDP++JOy4WbJ8fpeJ2Ows6J5fNlMW3X/vYSQ4uZJAwe+4VfYZ//h2FQVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YfkuEQjMZuMgk+r/GSnSrGGQOtdeChizNadTGPA4yM=;
 b=GLtbR5yzrDiJIvW/V8NtNKJtpJO+b0T0fW+XUrBbSouHbdqYawK6W8NX6N7scFDk7XI3GPKDOl48BImQSS1fJqpxS/9atNM91vMnFJUJW7or5sAiELvRlrp4gyBmMk54PBD1N/UCxB0hTo6fAQPAhg9P8L2cC3qZtFi+gSCWWyQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA0PR10MB6428.namprd10.prod.outlook.com (2603:10b6:806:2c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 06:52:24 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:52:24 +0000
Date: Wed, 27 Aug 2025 15:52:12 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mm: document when rmap locks can be skipped when
 setting need_rmap_locks
Message-ID: <aK6rHBaQ-gpzgEVt@hyeyoo>
References: <20250826065848.346066-1-harry.yoo@oracle.com>
 <20250826065848.346066-2-harry.yoo@oracle.com>
 <6a8a32a5-95f0-4dc7-8a75-80cf639069ef@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a8a32a5-95f0-4dc7-8a75-80cf639069ef@lucifer.local>
X-ClientProxiedBy: SE2P216CA0024.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA0PR10MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 7733fc31-dac4-4c07-89a3-08dde5364721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uGjyCKyH9MkszVqehaRCHztFR/h+gEe+qJ79lQSntGWkoVDcMmDH6oaAVVTE?=
 =?us-ascii?Q?FUfRmHC8h9CLrN+h/JQZczjOIrpBd97KloJT8rPq8LzhzisgewPY4v/dv4g3?=
 =?us-ascii?Q?oKOcYGuLcUgji5VMlpnyDGV+rYf1ZzeIA7rIlPmIVqzeDGYfEZ8vCQjdzoo+?=
 =?us-ascii?Q?3v3XrN5kyKLQpJFsaTn+TzR++rBa+B96wfHClxFu19AjFrnAxqgmltD+YSrJ?=
 =?us-ascii?Q?Lg8aI/HbUHEfCkavx7kQSU7k9PsyZ0t6Qb4MEwidamOsbaG0TxN6EAI4Tzah?=
 =?us-ascii?Q?9FjijTYWQ0AuwWGoP5J/jNTTgObCE18A+gArbnU7U9bwlCn95Eyeeo7Vyqfq?=
 =?us-ascii?Q?fTXyPTXtdfGCugXoLaQdHI5BwgL4Kzdbh/rJse0VxJ13X8EdoJhFkLskLLba?=
 =?us-ascii?Q?AK3DHLd9q/WGfGSrpbvlurw5+d3fR2Jfa1/Uqk+Txk7/dK6PSkthib2C0QQH?=
 =?us-ascii?Q?krkDtUopMxrgqo1BlBuVkI++v9AZF5xRRLNC5xwVAkXX9ERBTKQLZdWIoU9r?=
 =?us-ascii?Q?jlvNPo/weujTbV7rMLwcYVca6gjQhFmNp+FwubU84IYRd+JBJv2rJ9+hR1Rc?=
 =?us-ascii?Q?qSk/e0ULUV9opVXiTF+RNEdgt2f/FmPveRMkwMK66eAaDHQ5zojdG14eDnYe?=
 =?us-ascii?Q?9FtJbph0Rkd6sF8nDCD1TG9l5qht0MgNd6vku9NAEmnyve4VJYuUpxcYJ7tZ?=
 =?us-ascii?Q?wmZDKp8v65SeitOcv5KLGbwuHXWyXMI2BaSP9tDUySywq55rCDEXmudGZIbb?=
 =?us-ascii?Q?fiSzlXmcF1Llhc24rIYSew4pF1y3xI4+QO29iIgjNz4cKaVOfyDZzAbkl7GW?=
 =?us-ascii?Q?INOhZQ0/PhC3sMCBv0T916ZQlOrwtm86N68kLDwr+F65TPmvWLFBT7AQ6HTp?=
 =?us-ascii?Q?khDBSiJcoEyar6etZ3S64bJGTgWsI76hi0/gYrLyKHDPLxPYn9/g/8Bpr0e2?=
 =?us-ascii?Q?FSq6pTjOkWHzaqXLTmhoc9bJtMeOj4StDCmafpTTv0+ZVt+WHfxYfGsFvAPv?=
 =?us-ascii?Q?tV/uS8mOvuZkj73JejKCAOpTehTlb6esRxOQHclm27Bzjc2oUfNwRpiaHbKb?=
 =?us-ascii?Q?6LWFKYGkdNcxUgH/nXjzhudvOgdAH1fO4faOPtaaYofay2NO9w3ulkV+RTA4?=
 =?us-ascii?Q?yKKVtq/T+++fcucq1E/+Z0ltCpvxgNjvmxygAGsqZ82mZS1OpveFfryL1vZb?=
 =?us-ascii?Q?TxnxY0NSssd0/boOw+kMg7vpGdafTqHiGzXx+/LPqZds5ndKZam4Cv9kGKov?=
 =?us-ascii?Q?dsfiyCOqmH0ZfU9jvveNeBtOIiJNV46t4walKnuiUJ92X6u/aAqFlzWBdsWq?=
 =?us-ascii?Q?MpJkkVpMu4abv801EvK0LLu7ZPA99Iyk9Nb8GWfNQ4oqETJzsNsBD0INOcIo?=
 =?us-ascii?Q?xOeGfO4AcfOzlnyhJSYry1y3W4qr9RojFqnPsXwisWV4p0uyVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jiWs8J7XIFn4KzYUcDuhzKxsSphi/kZFUJW8CkLpi0hS7t3LYTFw2P4i83C2?=
 =?us-ascii?Q?tonJcAo8jq0sfCWM8qalR10hrEfcn3IWCDCYA/1d4qkloO4DB+INBg1L2uWe?=
 =?us-ascii?Q?EcdezKoJIJyGzBcKykzFYv5jgkJrxP/mZxnkeIFdoyon3FUqTVQXT5vzowPQ?=
 =?us-ascii?Q?mNUR7348oTgMBqmwrU2BIeeqiCYaPNqnBcvxW1or9HyN+c10gr5i+Utndn5l?=
 =?us-ascii?Q?oOifd4dpeUa2KkvoQVQXjwnCeUXd9rmDCtHI1n2rlTrazKdmIHWUy1mlLl5T?=
 =?us-ascii?Q?c4Xr8+PeoSqCo1lpQ19eQdWciEhDPZZ81b8Js92A20qvvx1EPQ4Dg0okfLvE?=
 =?us-ascii?Q?x3U3Vx4JKb519rC7U9ye6FofITN7cAxm+h+RFYy/rJSI/5XJyl7bgqIndyIm?=
 =?us-ascii?Q?jGELyv1Kkq9+SWclX2lQ9FtSiGhbHd5yEy/O8/0LxjnNbGdiJvOvWpADFgUY?=
 =?us-ascii?Q?XmvYtISLjf8+y8sq0/bKEL5Y0rq2zKw+76jn8k7s55KQR+hjRmt2VJLpNxCV?=
 =?us-ascii?Q?ilV44EWFEFYLNtmOdQRFh/2K4dfS6yBQpo4UrUIcfzQJWDkFSy2uHcOeCaIV?=
 =?us-ascii?Q?3rkGEnnKBTd6IdoZgqkCBphWTs9GU5YMAzD6V67IfCj2NjazE957nkidzd5T?=
 =?us-ascii?Q?TAHzgieGUlnd93YJ6I0z7uLlB/Z14DAoWP6qDV6dLL9V3CbS/L9VL7d5AuBP?=
 =?us-ascii?Q?s2vU2D2AqO76V3tC0i7U9XQ2ZlbIKCGrA8/AuawY7/CsJu2qRjpNgCNktbeT?=
 =?us-ascii?Q?9/HVp9aVCP8XIwLhS1g5ECwXXxVTIPu5aq50tCPixlqPNzUndNQdcqp3jlop?=
 =?us-ascii?Q?XlFbgvdEiGpM48bRgGLyMJOnvUHzpHeLb6J7/LyhhgfuuL0g+Q/Ynvg2rBZk?=
 =?us-ascii?Q?xW6NQ1hf98mYKK9MFCtC9ITmtAYWOm+rIre4CegQWdkrKlHJ4TNGroRE83tz?=
 =?us-ascii?Q?1q40u9u1NsY6dUKYV7f7qj+EdNPWdKS9FzZu0emqyTKhuGl0ezth8U+m91WK?=
 =?us-ascii?Q?icoxk2xJnSsXqoi/njZJtYOYNz9cFwsyoY3iwElPXUgKpSoMxZ7PRD0tkoPi?=
 =?us-ascii?Q?Dvww+Xu2loBywPeYtW0nlbD/+BIiyxcFlVEE27Yjdy+kF+sfKrLNs+DVaTtM?=
 =?us-ascii?Q?ngq7pSloI51zwWEnESOcBjd7JReewXslRYrUeSv54y0C1rkvMHFYHyR6u0zR?=
 =?us-ascii?Q?WKmSNFSFsE0XtlrFR3IzTnr3zIeExcQeGwBQwusC0R6FawkPhPPd6bg6Dksm?=
 =?us-ascii?Q?Y5oTmKsbg98g/3YQMSMiwHlkxjyH9V3iqNHDPVwTZweRkP93QL/vcXVXdvtQ?=
 =?us-ascii?Q?jxLAQApVYqUP4MED5rrlqzmd8uOpUg8hS0smaHJGsCwGn+h/pwXUc18bQXkT?=
 =?us-ascii?Q?vreMC2HWE0NtXhgf+p8cM6iv9HFkc0qwR9PuO771ja0uAJ+cG4YK4r8/Q99Z?=
 =?us-ascii?Q?NyD+qIJ8LuB29snpp8/D96/Y/qqvUD0g+vT7IpOAIxPYlfH/0KB+k+o0KGdr?=
 =?us-ascii?Q?N9nzZjVTCF4+OAuUUOvR7zMnhdsGyQs82GQwEvy4evMP+Wj4tokHZc0PH3c/?=
 =?us-ascii?Q?gHgJLW8SqhpbKU/wSXmzvytEKjARNh4EU+uQHMAF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Sem/DcppWk3LwwiDkVcmaw4iFW/HTu5Y61bdtZfZUNo9Mkev0UkaegWIQfeISa0YEwAzL2wv7mN162rikepHohHoKrn9H63rOa3Fh9EYr54CbXHm54kMyugGHXcLRZ38HDtwCW2GB4AL/q/Zgd04beCOU/X/wGvYqMcr4aGVc+9B617bkT5rRzpPhh1HMtLMs6er5hEjLQCyKpvVZI1dPKOeUEkXRdD7WfQsqDsuvP89a1qqlib6qMfNCHblPs1EqMxX3kG55mPO9zui2JP3WbXJBVkQ3nZ8IG2xdQ8vKCcl362dVpQEvaNpOwGbNFFthiz9lYDu1KdK/yFXjqw3ElykIm3tvON42ucv+cHTJZnaJdGIwrZ7Ul+HyIcIjcBMaUOo1b27XGYvDxq3RIhSNaBZLaFrdtzq89BS/KzwrTISqTcjCIHx1YIbEN2LWtaWrDucrxzTdgZFUuXD6nBNsmIE8Y8vUZT/2Otw2ki/A8R1WLcJcZHwEHwX50sS+HvTNG6/IxswgeEyTag+6zMPsmLeJYkam07L2jMpYteEphu9HK3xlKidCPITYIgxx0RyF6H376+rvKMk/O9xZkA2fE6kEDzhvZ6wQdJK1mBeFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7733fc31-dac4-4c07-89a3-08dde5364721
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:52:24.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOuKipUXg6Kiw3d33DUf2Y3SbyKx9VrhhTnT5Vk0CQp2t1KvQRS+ni1N9QWhlM42gJT6Hs0Uh2vTQBVQds1xBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270055
X-Proofpoint-GUID: zZ98ih80sv6EOE0OpTpdDyCmp2fM5-KT
X-Proofpoint-ORIG-GUID: zZ98ih80sv6EOE0OpTpdDyCmp2fM5-KT
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68aeab2c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=AMM-aMmrk_CfW_4xUdcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfXzCgiJ0IYM3uU
 Zmk4Y8q6gED0hqCfZ/rpz96oFeJbRoJGH3T7NMEK0ULOzucBd8XQxldzEbRB4Y51fOv22joFwWr
 UPfhCCIgdJkdmsFeXw/9v5kuLoaDyc6RvNz8iZdeDQXh+GsxBw9b055n0VVIH9te/sDYZTqx5TZ
 G59ViVwvSaN0iBvGjf5xuq6bKFhl1xiDAe6v0+5aLyfU8nIOXckmIyrUBhL1EWtfp5bL/IQ5h0o
 6J3aS5Y5cuCAnsNXfLr2kNqwG1DjG58qRuv0IT8fk3WGVKXd3JrnEB8dG+IPkxIyL1ErDveF63/
 lmSOrFBUeXqVfJz/aA4qi4P20g1Y6Sfj9EgEIDoaAI8DJOxRoYZwx6gfamBN0hi85nqCVlNsS6u
 3b/x2Yhd

On Tue, Aug 26, 2025 at 10:46:24AM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 26, 2025 at 03:58:48PM +0900, Harry Yoo wrote:
> > While move_ptes() explains when rmap locks can be skipped, when reading
> > the code setting pmc.need_rmap_locks it is not immediately obvious when
> > need_rmap_locks can be false. Add a brief explanation in copy_vma() and
> > relocate_vma_down(), and add a pointer to the comment in move_ptes().
> >
> > Meanwhile, fix and improve the comment in move_ptes().
> >
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> 
> This is great thanks! :)

You're welcome!

> > ---
> >  mm/mremap.c   | 4 +++-
> >  mm/vma.c      | 7 +++++++
> >  mm/vma_exec.c | 5 +++++
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index e618a706aff5..86adb872bea0 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -218,8 +218,10 @@ static int move_ptes(struct pagetable_move_control *pmc,
> >  	 * When need_rmap_locks is false, we use other ways to avoid
> >  	 * such races:
> >  	 *
> > -	 * - During exec() shift_arg_pages(), we use a specially tagged vma
> > +	 * - During exec() relocate_vma_down(), we use a specially tagged vma
> >  	 *   which rmap call sites look for using vma_is_temporary_stack().
> > +	 *   Folios mapped in the temporary stack vma cannot be migrated until
> > +	 *   the relocation is complete.
> 
> Can we actually move this comment over to move_page_tables()? As this is
> relevant to the whole operation.

Sounds good, will do.

> Also could you put a comment referencing this
> comment in copy_vma_and_data() as this is where we actually determine whether
> this is the case or not in _most cases_.
>
> Let's just get all the 'need rmap locks' and 'corner cases where it's fine
> anyway' in one place that is logical :)

Will do.

> Also could you put a comment in copy_vma() over in mm/vma.c saying 'see the
> comment in mm/mremap.c' or even risk mentioning the function name (risky as code
> changes but still :P) e.g. 'see comment in move_page_tables()' or something.

Will take a risk and do "See the comment in move_page_tables()" :)

> I'm confused by the 'folios mapped' and 'migrate' bits - and I think people will
> be confused by that.
> 
> I think better to say 'page tables for the temporary stack cannot be adjusted
> until the relocation is complete'.

But is that correct?

Out of all rmap users, only try_to_migrate() cares about
VM_STACK_INCOMPLETE_SETUP via invalid_migration_vma().

I'm not sure what prevents from try_to_unmap() from unmapping it while
it's relocated?

Looks like it's always been like this since a8bef8ff6ea1 ("mm: migration:
avoid race between shift_arg_pages() and rmap_walk() during migration by
not migrating temporary stacks")

> >  	 *
> >  	 * - During mremap(), new_vma is often known to be placed after vma
> >  	 *   in rmap traversal order. This ensures rmap will always observe
> 
> This whole bit after could really do with some ASCII diagrams btw :)) ;) but you
> know maybe out of scope here.
> 
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 3b12c7579831..3da49f79e9ba 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1842,6 +1842,11 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >  	vmg.next = vma_iter_next_rewind(&vmi, NULL);
> >  	new_vma = vma_merge_new_range(&vmg);
> >
> > +	/*
> > +	 * rmap locks can be skipped as long as new_vma is traversed
> > +	 * after vma during rmap walk (new_vma->vm_pgoff >= vma->vm_pgoff).
> > +	 * See the comment in move_ptes().
> > +	 */
> 
> Obv. would prefer this to say 'move_page_tables()' as mentioned above :P

Will do.

> >  	if (new_vma) {
> >  		/*
> >  		 * Source vma may have been merged into new_vma
> > @@ -1879,6 +1884,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >  			new_vma->vm_ops->open(new_vma);
> >  		if (vma_link(mm, new_vma))
> >  			goto out_vma_link;
> > +
> > +		/* new_vma->pg_off is always >= vma->pg_off if not merged */
> 
> Err, new_vma is NULL? :) I'm not sure this comment is too useful.

Sometimes the line between "worth commenting" and "too much comment" is
vague to me :) I'll remove it. Thanks.

> >  		*need_rmap_locks = false;
> >  	}
> >  	return new_vma;
> > diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> > index 922ee51747a6..a895dd39ac46 100644
> > --- a/mm/vma_exec.c
> > +++ b/mm/vma_exec.c
> > @@ -63,6 +63,11 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> >  	 * process cleanup to remove whatever mess we made.
> >  	 */
> >  	pmc.for_stack = true;
> > +	/*
> > +	 * pmc.need_rmap_locks is false since rmap locks can be safely skipped
> > +	 * because migration is disabled for this vma during relocation.
> > +	 * See the comment in move_ptes().
> > +	 */
> 
> Let's reword this also, people will get confused about migration here.
> 
> 'pmc.need_rmap_locks is false since rmap explicitly checks for
> vma_is_temporary_stack() and thus extra care does not need to be taken here
> during stack relocation. See the comment in move_page_tables().'

This looks good! except for one thing, not all rmap users check for
vma_is_temporary_stack().

> >  	if (length != move_page_tables(&pmc))
> >  		return -ENOMEM;
> >
> > --
> > 2.43.0
> >
> 
> Cheers, Lorenzo

-- 
Cheers,
Harry / Hyeonggon

