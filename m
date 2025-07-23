Return-Path: <linux-kernel+bounces-743090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2CDB0FA63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8C43BC696
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F7A20B812;
	Wed, 23 Jul 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mhimvxwn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XLxRdHu3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8501E1DFC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295970; cv=fail; b=Q1jJj1yxCYviLL6S3oKe94sDGCBa8k4i3VjnueStpSaZCkr/LqV72v8HqmzHik+ksI/QwtwgfTkya5Y09foH5n9aGvLj//cIURQZma5Of+YmLDDoZvlAAB9IdHIyVQuRfZUvVl/JhCJvdhQCTZIKL1kVvl1Ce30VCYgTl2XFxr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295970; c=relaxed/simple;
	bh=it+BQFBc44X8Jl7vsFfVjaFk7v1KiBaUHLDdLyGMXOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B6dAtXj476brvkHBjqmsVh6ww73kIUyviEeFlKB7WpCMRGceK5ZbLJbY+igCQUdAfhOfhy3vAsm6lPTCdY/Tl1lZ2P4CJfH0vgotHmm1CwQVffDTzhj/FL9w/ixzh2YYODGOZL5uJXfj3pZUlBOFudHMF7D+EvcxbWU2tLE7/rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mhimvxwn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XLxRdHu3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHtrKr007883;
	Wed, 23 Jul 2025 18:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5CS5hi2FPkDVsLBXwio2oKwkWYlqEPcZIILXqUltRDU=; b=
	Mhimvxwn5dubdncSMdKNzPCsw6iTiZ115pqS9xjzdAw+NHTNhZxiBynBkWrxgIju
	7FjRt5Qh3GWZF3A8rZm3VR2dDrlnw4Kd2vArPplrsV0dKQLF8+efxE95PdB0nKsA
	qA2FLq/JJRwkd9hoJSZQFFShSnpe+BrOq0zKI1tfg4IOGcjmW2XsS68eD6qLvZu9
	lJBkLr9SXYOJD8OwtWwoCc84+tDKLKoPMjRuAW8he+Q4iAOgkbAnBSMeFfjjmSQU
	SVy1IZnGJn0bbvdZsitF097jZIn5lQRmHzArCAr1ItFhgdmc44MWxKY9rB/8HYqn
	eMqkjHRoua+s5lcZRtykWQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hpg8m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 18:39:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHZnfA010365;
	Wed, 23 Jul 2025 18:39:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801taxrya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 18:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9qmJPwB3RZi9O7wVMUOX/PHrwKAycNpx6Lqyjma++N4u58lQLfP1RD9TdPW6YOGllMkZwxTgErGtxUdY7MTieBeu+x1TWoS83rw8AEhOQGFI/aOPfNquDKnkznE6FwVRWdgtHqY1fTcltJ7SMGdkNUna9EbmEwViTp0MEXDpvGoAsWgCSKD5OtfAgpdBEu0nvMO/uMB4utGt1beKXXQRr+K3FPVY5aOXL+zvuQXeJhjJVaEo11Wc4EjFmQCs78FcYD9On1mgA1EloWElS7bUMDdr67k7EYHnIpiHq1fU8WKTYj86CEO3rMVITuCV4mWPSb45+ZPqdSvYUPEzRT8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CS5hi2FPkDVsLBXwio2oKwkWYlqEPcZIILXqUltRDU=;
 b=Cpid/aPI+3iThb0HtfiVZJeEeQvwcZPo+iEhMzwv6MRDw0frMtyJEXq+dk4VdPfAk/8xxPkHTuAjaK3MTNAiD9WQ7QWFkb5gBmjVmAXwzpKjwVMhPHKyPaml8+Vc7EXl6c1AvaAPEKd6GrKC1n6SeJyOULWVHiqt4/SANBwQ/ks2dvhxXwFw9mEjVZFgsWHTvy1D1uUYIXw0Zr8dSVq5m6OypyFaNb1VZBSVG5S4uVxFHhnpcmZdWbVL8snrbRpKkLH9MO0vNVOMIUGmouG7IULZ67NVeaRPtSB8m0o4E6oFNB+NogLW6YL42fkiCAFuS7wmoZUIJJiRvFBT6+5ThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CS5hi2FPkDVsLBXwio2oKwkWYlqEPcZIILXqUltRDU=;
 b=XLxRdHu39Bg/P/pVxXOPGQ6h1w2k/JOre81CBE4IwWhfsf/ykjc/K1zInesoqfYtNx/OsSbzCVMoiQ3A73qvac2FH5kcz/ePlJf4Q+8ZxMjRG8tsdKq2Q4yISEibtNxL65VbXidsLD/aGEy1MiC/J5g2p6F0pne3Y6QY2TGomDw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5858.namprd10.prod.outlook.com (2603:10b6:a03:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Wed, 23 Jul
 2025 18:39:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 18:39:13 +0000
Date: Wed, 23 Jul 2025 19:39:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
Message-ID: <28e1fc65-995c-4185-b5c2-7eb001312698@lucifer.local>
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz>
 <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz>
 <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0289.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: a6045100-fe8e-4cdf-ff83-08ddca183892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enhjOEZ6WlowdVNRWDBMVG5iSHMzU1JXVHkzUWFSMWRjd1NtUHVlZjhiY2dk?=
 =?utf-8?B?aUMrazdCWm4rQ2ZtbHExVmtRaExWaHlHQmFsY0gyQ2FjeU1wL1FPQlBrRnho?=
 =?utf-8?B?QzRSencvTStoM2dDY21FQ1JsTU50UGtqUkV0dXdkbkp1eCsyYklyK2YzVU9O?=
 =?utf-8?B?Nm16VWQvTWxMNHJrNHRoNVMzR0liT2xXK3NPNjVwWTBQQVduYWd3WDJhbS96?=
 =?utf-8?B?eGlWbkhGMXpremMraEJUcHhUNjdlQWhTT3ptMk43bTdOOC9hRWNXM09oQUFL?=
 =?utf-8?B?M0F1WCt0U2R4TDlJWWhPRFF2WFFKWTVINkpJZ0NMN2JtaWkxZnYzR2tlUEQy?=
 =?utf-8?B?NENhZVZ2UEN5WUZWS1Jjb2pjUkZMT1JuWFNCaEloa3RjaE5vQkRLYjJHVHJl?=
 =?utf-8?B?SFJvOGZDZ3BOL1htVkR6NFpOaE03UDBsaU9FUFJBQ0hwYVdsRUsvL1ovMTJW?=
 =?utf-8?B?NXNIV0g5OUdURUtCV2lkemg0YVE5K1hKYTlXNklNdjZYcHJjL1FHY1BPWEZS?=
 =?utf-8?B?YjBEQ21CUXhVaHRGODJEWVBPM1pPV2tmc1BmYmNlVkhFSGZsNWRpMkduMkZl?=
 =?utf-8?B?SEwzOGF3b3JIY2V2TndRNzcxVllnU1NjaE1oY0dyWHh2ZzlaSUhiazhkc2F5?=
 =?utf-8?B?eG91ZEF0QzVJUW4vdVk2NlpDUnJWUHgyTE0vSE41WHNtQmU5R3BNL3F4RC9x?=
 =?utf-8?B?M1lkcURySTVNTllyMHpYbmlNUzZXLzhYMEhRWjE3NG1xYnpZbldRUFBsS0Vr?=
 =?utf-8?B?TGdicTJkZVpINTZDZzFvNk9BdFg4VWViaW9DOFoxU2NxQk1oNEloQ29tQWho?=
 =?utf-8?B?dFlOeWVsNGpQRFU1N0F1MnZ5czBZRWJYMHlGNXlWL2pHemhWUU90eGJPVjVj?=
 =?utf-8?B?Sml3YlZhSnNOY0xIT25rU1N6Y2FpeGY2OFdsMkJVUENyTkpMTGk2ZTZCQ1No?=
 =?utf-8?B?S1BXZEJyR0tZM1JxY2RyY0RKM1lMQlVOU0pTS2hPUzlkVkNmVlNzSGJXTmhk?=
 =?utf-8?B?RE8yektrdzNsZUoxRFczcjA1eXJrVGY3dFlsUGx2YW1hbEUxYXl2ZFlEdEJw?=
 =?utf-8?B?bVV0TGRvQlRJV3M1VFJPakdRQVZTdlRwZUl5eUZONW1ld2F4MWlLL3FTMHdM?=
 =?utf-8?B?N0xsMEFtZ1hWT1NhVU05aStySHN2ZUp0MThyMWNMb0dVWFMvOGlMbUJrK3B2?=
 =?utf-8?B?UFdCVlZxQUNiUkxTY0MrYzcyUWRQOTBkRzI2NUllRXFWUkllOHJBV2oyT2Iw?=
 =?utf-8?B?TFk4R1JtbkRKL2U1WlFUSm9ZckRQVTFUK20rZ0lnd0dNZy9GV0lVR2VnbGc0?=
 =?utf-8?B?ejJPN0JHYWJrbm5hcktaV0lxLytiNnpQaE1sNmhxYkpzMVU0aGo0YmxDMHd1?=
 =?utf-8?B?alRGbndmRzJPOTkzdmZhb3RpTXBaTGRuZ29jS1JRcXZNTlFaU2NlbGZyVW00?=
 =?utf-8?B?dDRta2Q2VDJCc3kwa2Rnd2xncG9iU2hvbE1RQ3dnM2ZxNE9HS3RhdGY0UzF4?=
 =?utf-8?B?SVptRnp1eGdxZUVRZVBvRDQ4UG1ONDR4WFBrQ29BcGRMN2NaNnVBeU5USHg2?=
 =?utf-8?B?SFNHQXVrckpyTG9mcjBkVG8rRE13b0tyV09ScWt3UWdLRGdnalRvdXFXVG83?=
 =?utf-8?B?Z0E0RVBVUC9wY1hTVEE5U1Ixbm02eGhiUmhCWXJNVWNEUzVhajNKVEZsRFpv?=
 =?utf-8?B?NGNIQTd0YW1ldHFnRktIaFFVVTZZTUpnMlErTjNtTVd5ZUhybVp6dFlhb290?=
 =?utf-8?B?QUUyMlowbWZld1NDVXJ4OCt5bUhzR3BkKzZRSmh6eEh6a3hxRVVwbGJxalpj?=
 =?utf-8?B?Mm02ZFQwYVMwRGNoZkVwdTdaMFF0dWxGZG4yNTE1UWF3MkFVNE9rR3B6cVpG?=
 =?utf-8?B?akNzSTB5S0Qvd3Zrdm9zVVpjT3Vra0Uzd3dJcktDT2xQUWhpODEzWFVnWnhD?=
 =?utf-8?Q?K3vjeqFnjQ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGR6UlFMRHE0Q3k0WVJnM1N0aDB3bnRka29QU3VVL1JxM1BBMDN6K2ZjcjRK?=
 =?utf-8?B?MU5PT1FQc2RFdHJrMHd0Y1NuUFdzbmdvcEphT0JVR1lRdFhtcUcvazZ6UHdS?=
 =?utf-8?B?TVVmbldwc2ZqcDZkS0RDZHQ0bzY0b1EvN3FYMkxTdFlBQnAwcGdGU01vdSsx?=
 =?utf-8?B?UGxGU2FQRlRUN0IyczY1cW9nazQ2TkJjNHpydU5UanZwUGVjWjRXUzBvbnRl?=
 =?utf-8?B?U1lpMFI5OUFsUzYrdnJLdXFMNm5yeWVlajRUMGFXYnl3RUJWNmd3YTk1WnV3?=
 =?utf-8?B?aXFqakVJdHlCY3VPOGRRNTkvdndWSjdEWmdtQmlhVTZDL2h2blpFam9McFFF?=
 =?utf-8?B?b2ZYOGhhZ1FyUy9vWWluZ1hYVERCcGYxWXJjUlRJM1BjdXpNOWdGNWVsaS92?=
 =?utf-8?B?N3Z0OHZ3L2hQNGNkTDQ4ZXlXZzFHSjBUVUtRMjJDODdicjk4QlpSaDk4Rmty?=
 =?utf-8?B?SzlpbWFmWGVLTVo3RDBJZ1o1WWxiZVVaRDlQQkpZQ3l6MjIyZEtKM0g1dUE3?=
 =?utf-8?B?ZExwc0xBY1JnOVo3Umc5bERnU2Z1cWxER0Q1aWtmdVNyaUR1c2dLUDVNMFJ3?=
 =?utf-8?B?R2ZwNEtGbVpwMkFqZTl5S0tJZDU1VHBCRzluTkt2bEFuZWlWNks3b08vYTJF?=
 =?utf-8?B?c2M4OG9FQy9Ra0Z6aWwzaHVHMjQ1aU5Sb3RYazJoRXV6WU5hNFdTa2RRYXk3?=
 =?utf-8?B?T251S210WnV3Si9pSW5vdG5aODg3dlRnQ3h2VFJLYUVWbXRkcUx3Vm1LdWdH?=
 =?utf-8?B?WmxidzV0UnNyT0tJOUx1Sm5BT1JyZFNSenB6QTFIUS9KekNrN09Ec0ZxRC9q?=
 =?utf-8?B?dkNzejRxb3FIQmt0cHFwWmVYSFU0SnFzZFpad2RtdHMzK21zVlJJMUxaajhl?=
 =?utf-8?B?dlhZTXVjU1RETUkydzJXeVREeHY5OXprNlRBNHpUKzBDWmJlV05iYmk4aHM0?=
 =?utf-8?B?anBtTlE5dlBZOE1rK3o4QzZzZm5PYjNyaUhQZytuSEtPdk5HYldmTER0alo4?=
 =?utf-8?B?M0lJZjNvODJWVWt4cVFxZWJ2YUFXZ0cwZjJNdEFWeHg2ZVQ3MVpBYkRoQXhB?=
 =?utf-8?B?WVdVa2dZdTVsV0g5akRjbGlHdmJmRHVDNnFaY1lpcjdBVlorRis3Y3k0MjJs?=
 =?utf-8?B?RDNjNk1mM2I3Q295TzkwTVRMQkk2L0haRjdSUjZyOFdUd2hOanZLa1dlN2JD?=
 =?utf-8?B?RVBlRUN1bDZkYlFVa056eGE2bGt5NGE2ZGdQU0liRUsrai9NK2xlNmtjck9Z?=
 =?utf-8?B?MlVZZWdGTjQ4ejVqb0FCSVlwKy9LZVE0TGhOVDJLaDlWN1pORkNDOFFzOHpl?=
 =?utf-8?B?aFdMYjFGL21YK1NVUzdxMllzYUh2UU00T2dCYkJzRTNaZ3VwOWsvUjdMWEZ5?=
 =?utf-8?B?REVPUzc5cVlmVklJQStqVHNRVWg3ZlgwWXZQS1Jab1FISzFuUlBHSmNuMXo2?=
 =?utf-8?B?VFl5M1lMNU8xbzlISVRvZWtLSXlUM2xlanNsNnhQa0pMZGdTN1NyOElnNDNF?=
 =?utf-8?B?Z1E0ZXlPaUtIQmgzK2hrd0pvNGxIMm1lUHB3blIra09iaDRiOUZZOWVYakZO?=
 =?utf-8?B?V0lxTTIydFdOZ1FZNmZKYmZqRXFUZ3BxWlkrYlViOTRaOUtDTk5QUVNvQWJB?=
 =?utf-8?B?YW8raGZ2dWhHTkFzWUd0UXU3REt3RVlROWdZdUdIWmFtbFV1MmhJekpxclN0?=
 =?utf-8?B?a092eFRybko4SzVtSHlUKzM4QmFvNzRIODhwNVlTMGRwYkY4Um9vVkpaamxj?=
 =?utf-8?B?SStXQmwyZE9aVHZoL3R6L1JSdGpEcFJxWlJ4YW1vQyt2SlB1ZGoxNFZScnlK?=
 =?utf-8?B?V1VjbTdBU3krUzZtQnZuYlJvMnRFK01KekJpTm8zZzFlL0hzQUwzb3ZCaVRP?=
 =?utf-8?B?cisxR0FLbHNacWszRjVYNHdxUFluTXB5YzhVZnZYTzVKMHdDTmN5ZnkranVq?=
 =?utf-8?B?aUtPVWl6UVkzd3ZLWXRselJPMUFXN080TVgreEpzNHlxWU1XckdOVVBhdmxj?=
 =?utf-8?B?YzJNL0R2QnRuRUJrRlNkbVBob3FhZ0tYZ1FLcHhEMkdEZ2doeXI1WG1BZmFE?=
 =?utf-8?B?WXd4L0QvVStrV0VUZ01Xb0pZeXhwVG5PNmJxeklvWlhkS3BjYjhHc250ckw0?=
 =?utf-8?B?aHBxbzlHeGpyR0hKUUdvOXF5MysvUGFwOXJpTHlOZFhqY0pNakNJSmZlQWNN?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TxeokXiJl4Wz8k0Zevf/ht/LUuUBTKWu6sBD0EIHOLuRx7X8e+i2mALXplNFrY/DKKirkzwZF7x8MEW7o0NUERHHFnedrXLgESFmVQSrSntb4Kqmmc1DGvqCi2zoLD31DvqWGJM3zw520rpiP55evi3UfMWjhnnAkBkwtvycPVZ5A9Dt2eB+TDHDlXTnaSH+F65cFX/+qysXGaxRGPR7I5iLqb3QWuITmnf1w8PAL5/b79sIr+cugcYEOv7k4tx4WkrDZF+FsA536AUVuyBxfQ0LO/4qQAeDD7cR0BrnQ+Qax+GRXGpEispBHUN1m5dOFVvuTtyj4iUhudoolGlTPfQ0hz5+lwCzrmb9BEdSxAjbX+4AzpmYCcHuXD+Qs6aK33hgD/dwCzM0PgXK5D0nmkSz2+d3B8n1nVCLUl0ib/OgT8MGFhBXG3Hd/DBV9uSz15YtK7MDgay8D8gfbbmVlD6u3BE/hj9u6IF0BjcNyNrXDisSDXTxvegqNe4g6wIfmkb/2U6diKXY6MagqPSxMCwy/efCDPtuJ+G9KQQbcs2DljBNR75AMaOUaKkEADOqlcrP38kRh/fQfP4010J4pYIKIAFVcM+mb+FZK4meb94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6045100-fe8e-4cdf-ff83-08ddca183892
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:39:13.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFUy6AcEoin93GzULzeVEf3Z1HRwqTElr4n3sIW8QM4MmkFUmK/laP6HpEiXjsvPgmHoQx5ZVLIo1VK5usyAq7N+RXK0FnkRQeJFeW1KOFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230159
X-Proofpoint-ORIG-GUID: kQwvBsEzG08Vn2dfptQ3zVio375pZABw
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=68812c56 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=ZjMWL1DCY0209bfNAFoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kQwvBsEzG08Vn2dfptQ3zVio375pZABw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE1OSBTYWx0ZWRfXzly1S7YBUQSU
 gxQj6SsBNOCxqRLvVT5EZ7S1LkbatU6w39dj/8cQjO/822QwAL/yllRF5mECy7+cMCd0JSYDEH0
 1fl358i2ck1yV2DAe6o7d3Vndvu7p/2w1hTI17I+QUCIURODL79pG2QcD0jbGTMboF4txcgy0Jo
 g7EJHdZA6C1PnQYB7kj3kq/GJFnbEkrNxr8hebjWMvI/XCPdAgQHnoyBd1zjVWoqMeWyUcbSY0q
 llHNh82LC7BTddgurqLZKRjUUO2McdNtsDEYc2lczdIavwGutJeeaBQtWMoTi727xW6KRLlOBv9
 MO2Idd9ZmjTl/aw46TeAcWXZyJReAIEt5tT0Ubj8usRjmobV2p3OWo6WUrGuRtd/QSFWQqYfwQu
 wphve9Y7oi8cFHaDo2AG9OKoBMRWP163VyDcx6AX4jpFS3cRQZ8YLLYUc9jI8SxJUVkSSAo2

On Wed, Jul 23, 2025 at 08:19:09PM +0200, Jann Horn wrote:
> On Wed, Jul 23, 2025 at 8:10 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > On 7/23/25 19:49, Jann Horn wrote:
> > > On Wed, Jul 23, 2025 at 7:32 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >> On 7/23/25 18:26, Jann Horn wrote:
> > >> > There's a racy UAF in `vma_refcount_put()` when called on the
> > >> > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is used
> > >> > without sufficient protection against concurrent object reuse:
> > >>
> > >> Oof.
> > >>
> > >> > I'm not sure what the right fix is; I guess one approach would be to
> > >> > have a special version of vma_refcount_put() for cases where the VMA
> > >> > has been recycled by another MM that grabs an extra reference to the
> > >> > MM? But then dropping a reference to the MM afterwards might be a bit
> > >> > annoying and might require something like mmdrop_async()...
> > >>
> > >> Would we need mmdrop_async()? Isn't this the case for mmget_not_zero() and
> > >> mmput_async()?
> > >
> > > Now I'm not sure anymore if either of those approaches would work,
> > > because they rely on the task that's removing the VMA to wait until we
> > > do __refcount_dec_and_test() before deleting the MM... but I don't
> > > think we have any such guarantee...
> >
> > I think it would be waiting in exit_mmap->vma_mark_detached(), but then
> > AFAIU you're right and we'd really need to work with mmgrab/mmdrop because
> > at that point the  mmget_not_zero() would already be failing...
>
> Ah, I see! vma_mark_detached() drops its reference, then does
> __vma_enter_locked() to bump the refcount by VMA_LOCK_OFFSET again
> (after which the reader path can't acquire it anymore), then waits
> until the refcount drops to VMA_LOCK_OFFSET, and then decrements it
> down to 0 from there. Makes sense.

Sorry, this is really my fault because I didn't closely follow the
reimplementation of the VMA locks closely enough and so am a little behind
here (I'll fix this, probably by documenting them fully in the relevant doc
page).

So forgive me if I"m asking stupid questions.

What exactly is the issue with the waiter not being triggered?

I see in vma_mark_detached():

	/*
	 * We are the only writer, so no need to use vma_refcount_put().
	 * The condition below is unlikely because the vma has been already
	 * write-locked and readers can increment vm_refcnt only temporarily
	 * before they check vm_lock_seq, realize the vma is locked and drop
	 * back the vm_refcnt. That is a narrow window for observing a raised
	 * vm_refcnt.
	 */

So, if this is happening at the point of the unmap, and we're unlucky enough to
have some readers have spuriously incremented the refcnt before they check
vm_lock_seq, we trigger __vma_enter_locked() and wait on other VMAs to
vma_refcount_put() to wake it up vai rcuwait_wake_up() if the refcount is still
raised (which it should be right?)

So actually are we going to be left with readers sat around waiting forever? If
the scenario mentioned happens?

If we make the rando mm we are now referencing stick around, aren't we just
spuriously triggering this thing while potentially leaving actual waiters
waiting?

I may be completely misunderstanding here...

