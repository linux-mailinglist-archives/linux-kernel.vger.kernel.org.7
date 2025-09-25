Return-Path: <linux-kernel+bounces-831745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C73B9D745
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019921B267A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E9F2E88B3;
	Thu, 25 Sep 2025 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gCoeqN+R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tNpxZttD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBA1DF27D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778043; cv=fail; b=FuelNe2rF8n3m7CbnZbnRxfpcWkRgtX9vYUhT54i/KExmXMZ3ZYzEXaONOLmuH2QIVDkgcDZ+dTGkrYTALXOwfge9UBAmgExm7IJ8KX6zcE2aHBdFtWcW1LSxJWOAHLEiej5UUN9uon1hSln9cmYferkrwMWn2RpW+UG2jw2uWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778043; c=relaxed/simple;
	bh=2itM+TSEYp1KnM+XS3WZmKpy+86kF7NUwKnWjhQ6+tY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Aw7c0LGPl4YwlOnlZzWE2I/kxkqZnrVGXcGLm/cAJVXz4IWT5Wz3DdLRmwwLy/NzFz+Z8f4IdOeUWf5ZTD6u/LGwufu94Z5PLxUKh+qNO+3cMbfVP+OWpM+QKPzJ8eZ91MaxKOyWZ+6wiI2EvlubAmnpiVofL88oFgEeGQuamr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gCoeqN+R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tNpxZttD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4Bsa1004933;
	Thu, 25 Sep 2025 05:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7fPl/yL1prkEeGNzSX
	ujCAf0uZRJkt3uOx4sSA3opm8=; b=gCoeqN+Rv4mGoH0LN7YvYush/U3Uy5mbKc
	B2UTkAl0eESndeRmJOrbZ/hL1/d5kQ5Iw1HdswTdw3K2qU55ponkrdHwKNu0MCsB
	Ev5SiAivuLnZo6gPIGSp+Tl9k+r8+3zJCGs5H+apKGE+ihab3B5mnhk56ckkYSmW
	Yv+NTitqHrG9snTaDVVNhWXw41118dbBrq5IJ1fvrGo7tLk3n3jSnh9ExOQB6ge4
	r89OXPrarFX2zUYS4BM23/l39LX+oSebCoAMdSDCBmSDXu/p/JulcR1i/Y+XgqBP
	1k3SYNEKpLRgdsVdQMqBrq1IGXb+vmBXEKf0ITBRB0l38pu7KWIA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k23h73p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 05:26:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58P3b6VH035496;
	Thu, 25 Sep 2025 05:26:41 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jqawhyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 05:26:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzIgmhRMYvOi0BCkehDtyQ/3LiEOI9S0k4nhnwgzXcYudO7fBODfZ4L+K+1rBQMhrugYqVPoay43l5qcNPYRsbixJBBuUjug83T+Wo7b3TImTru/+r/9pv6Tp52Q7aDeYnIeoja3kaH1vbhS0LGwppSpLPS6SKX1Q7QBu0tGyGmKBFT2rhoXb9jFijNgYa7xqx91H3Fr1+01s7M3gVez8JHFOoBqyS+J0JEp2nmai6pyqA8W7Zoevzpx6hEK8Os0phBbOvhO0AShb4PO6FzIXaXRCpypsxOA0Y/EFQbGlU8b3VSCJusM+wFBqrmpS+1Gcnsmkmow7BYZ6ddMjlISHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fPl/yL1prkEeGNzSXujCAf0uZRJkt3uOx4sSA3opm8=;
 b=woNYYBSm6XgTTaQAibJ4fuDJhYUrtVqzgOhpMUHvZhHxW5TxVW62rAadsOpi6xe2h+OJDEUura17sQoKWfEsF6MxAGNdIazR+RapaWX6N5v7cCwuY0qKO0uCXEKFZwfdeFwEgygaByE/fdBYD1qGkmsbOg0Q0WMzwzqIhWda2TVWz+9xqGx1cJqMuIl40ZZrfG0l+M6Vt4vuZUbpTmQhX/zw8bEAYHim7FKUxRQ6zJzIzTzfXaKAjRkTPd0GWR9WDhFFBdLW0STfO+lcZPa1vZTFO2YldUwjroNYUSckv+o7MNMqGyLKB6QuTxyZXX5CFmTLWQzTKyA3MOF7PK5eKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fPl/yL1prkEeGNzSXujCAf0uZRJkt3uOx4sSA3opm8=;
 b=tNpxZttDp3U1xn6vCdV+NKkK3W4l8D9TniNL0zxdVK47YigrLbnRtUnKVC10JZs+KMMTZLT13Yn2clpg9Na0fe1Gif+94iAo3ZFMdQCxaSnsCPj4aMhKx56ZzsqJYV45LTP1C2N99rvcda4608IDWc7Ze9hiYgEb4rm4Na8gBgU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6102.namprd10.prod.outlook.com (2603:10b6:8:c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 05:26:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 05:26:32 +0000
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-12-ankur.a.arora@oracle.com>
 <6626d497-4c27-4263-9be1-1c05d2672019@redhat.com>
 <87ecrwewn3.fsf@oracle.com>
 <4e061f4f-cd57-4df4-a001-9eba80d1ded9@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v7 11/16] mm/highmem: introduce clear_user_highpages()
In-reply-to: <4e061f4f-cd57-4df4-a001-9eba80d1ded9@redhat.com>
Date: Wed, 24 Sep 2025 22:26:31 -0700
Message-ID: <877bxnayrc.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:907:1::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e833dfb-7982-4815-4f95-08ddfbf4168c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ytXXcAwqxbXO5rQGFxtcPGpdE7quKr6E8TDvoAWRyhYr4yhrPrT4uLZIM0Lc?=
 =?us-ascii?Q?H2641tHW9p5NxLg7sFQp76+6BcUqRhpi5cRt9R2bHVAwJ6dcVA9F/s6fxRJc?=
 =?us-ascii?Q?8jMqe9C2sIXrHEhHwKol+zQJ9+MYfxyO1IurOXILtKxdf9gsoN6AlOWz2n4E?=
 =?us-ascii?Q?iHgBdF0NGQehT7dRbrx/5eEdFWXqoQc8BIYYXu2Qtbhe/gsWsaVzw0OM8KAF?=
 =?us-ascii?Q?edGKrFUyzTWMYf58bia7BFJQuDoX5/2CBkDtnHsvU7aCCjJZFhviPbnrjryL?=
 =?us-ascii?Q?0nyXKt5k74A5IPSediLO8WqKbthp057mlU87rLkYO2t0OFCOpXKwGxGHPtHi?=
 =?us-ascii?Q?cFfkwl3M2s5cyAsana6EIn48R/OazhdBs/BY5FQJmAKQHXkoCdfR0S/hnzrO?=
 =?us-ascii?Q?Llxjsnug37pwnk5OxTfzjbz54PAX4i1uZ0C0rqiXvCdZoo0F9iRA+j0iaHqI?=
 =?us-ascii?Q?q5lQ1F37omAh7l+ODTtNNQpohnSHlcHmSl3V9zqwM1NI85EMsfn9+2gHIdz+?=
 =?us-ascii?Q?qUvQuIvaOBFjCf7riiL3IKHmLOjd9mqMWJbOtAjPrv6coQf/OhWVWNm0hq6Z?=
 =?us-ascii?Q?ajkeJ8uBUJgtfTixXHBkdXDhk8az6C0j0XDQ9IGhEmWJKnbg6M3n7VIJ9L/o?=
 =?us-ascii?Q?8R8/jRWv9twDlVy+Lxx/uRdNvDz+aPbU4lvk8lMaM9U2QNfgizrZvKsbwb16?=
 =?us-ascii?Q?NKSt9pvUuUEZIRI2voS5PWrPTtilActiy+M3aS217zfYtpYfkmZ7nwmQNGNY?=
 =?us-ascii?Q?69T9V1OLiGKqTgNKVncpImKRetqbByGhZcZBNBd/FH+j3DFfbRqpTS82PS5R?=
 =?us-ascii?Q?rq4tazH0NzTqGEHLE+vnAsQd+jP+ePpSbjD1vC0oU1QvTNKB7p7gm7FYe+dl?=
 =?us-ascii?Q?CtvLw56IP21dePQsm0+U2uSUPZwcOJJEl6ndmqMIyPGXh8r040Fhs9tS+JUd?=
 =?us-ascii?Q?cTf4nCx0KBBAUoCvFoKrOV8jDNmBecV2jDPgpH+KtBnqTRLX5mVjuRF5ZErd?=
 =?us-ascii?Q?WHMITmhUPC2prNJlfPvhV58GULmLVBBIPvhnWIzMWGcgK+BA2oOTTXRdtFMj?=
 =?us-ascii?Q?BFeoWeM1j0VWUsNfJUe+DOyky8OWXvPx3A0SyoEwag0aAIoFqP3GN3NEuluM?=
 =?us-ascii?Q?n/sU27uZ1EtCzr6V0zYp0/KJtO4tCmiyL9hcEDZ06xYXT61ZOQyPV3iuzOER?=
 =?us-ascii?Q?uA4BYGtZhfiEckApoCT6DvKxNASJpGO7tJwe0u00wAnUShWsM6tlzw0bllNg?=
 =?us-ascii?Q?wayZZcj2zFC/KIKLZRr1d1DdUrqtd8LPWlf5G1Io+qUNek71R3IQT5wKjsL1?=
 =?us-ascii?Q?vDuLSZtfWmiCCN1RUewZwas032dW3m53sqRr0VZGEWE5yN9hzGncS/pB0OYf?=
 =?us-ascii?Q?gGs/Hqf9S8Rni5lN2K3ITtDDPjfPOTFoeaiR79IoJWiafShbsDtfbP/OcrcJ?=
 =?us-ascii?Q?ZShBFx7tI9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPy85y56lXtjVpSMEmTi15veewldWU1tmtJJxlRCt4KMUCmNr5PDqXvLVG/B?=
 =?us-ascii?Q?dd13/gSk+httJLvyvE90CsdYZopwhVpNYqDc433G7SwyS/RN9Umrg9hw1EEw?=
 =?us-ascii?Q?ScI01ziW+XsL/m8n1FEmYwuvibBJAeveTVGGRO+DJqwh0j1Iaeqxq+KdKK+F?=
 =?us-ascii?Q?zQ676PbTkiE+0feyYFFimjZHYpgvWS5ow36W5ZdV/+BRlQRgaMWpdZqBh1YS?=
 =?us-ascii?Q?E/IsDEOSBHe35plau0sepctzlRenyzc3ol7oeDOJJbth2fMrTnmCVwGNIYfd?=
 =?us-ascii?Q?Wl7Mgp5trZinqHAIild7IgDwFN14j7Zw39ouHlHqK3mBFN6BHN2PyG7EchdJ?=
 =?us-ascii?Q?Ioa2jxsa7vSu0y/pUYPKRXJDGHSYibdveV7IVVqDcIqC5qTei0TkdkteVWGj?=
 =?us-ascii?Q?cuo7lDr+6HAd3wN3R6do7UUeJUReeBZNnme04kpoCBzCVy7OVviqbGzfbraI?=
 =?us-ascii?Q?1pxxYKZyzy/QFxcz/rFJdR+fq6cJmjiFgXPOVlnRlfqcXQOQEk2kIZwWjmxS?=
 =?us-ascii?Q?AEL5u39pT598slTRH10hiHZy/JMTSS9uOlqgVPHegGmaqhWw3M3xGiDEjH0j?=
 =?us-ascii?Q?LXshhhfPEDfCX9qrHMv6ROYBAaLYUDbLd6437zg+rv5SB0/F6wMIIf0gcqj3?=
 =?us-ascii?Q?6/Y9sBQSgc3EvVVIQPrIASU7sBRvlY0pAIFvyyszK3H4X8VVCsI0SnCGkYb5?=
 =?us-ascii?Q?toPpSGqzwtR/mB7T3bCFywraPW0M46kcqpOAZXoEB6AA2TSm+EhhFj36vmcx?=
 =?us-ascii?Q?r8DmxevQgcKbCYkVcVNEHG9z25v1Oi525oxSMg9nZX6T5SqGCwrqMU/Kpodh?=
 =?us-ascii?Q?3H7iJQrxiHqkkxK2QvH1n54Jxeid07/O2QwImvQcq5FMzISRYTY7D+jRFrey?=
 =?us-ascii?Q?BQrlK/atxslQIlOJSDT1kONQdS6ojX/ExQNgZEh/NRSHnS5MaPyuVd8OqBaj?=
 =?us-ascii?Q?j02ICsU3JIBfTwTTfZhh1MWmHmXoVlRyzOvTMfgY2X7KITwbZpXoWupR+ecJ?=
 =?us-ascii?Q?TZepzutmIlADKQsUfeX2rdAeHlonaaP5xPYnKtCMqC4ATHDqovZTVWkJtTyH?=
 =?us-ascii?Q?NbG0v5wwfq71uoH0ODGxXVJRBsCsOoEJtccEz5zJvBxcZQZXk6HMu9J4uv7n?=
 =?us-ascii?Q?kNtpZkNG1/AXzer3FbbqqFhoWTHUerIgzuHFJ/0oODBSwgloXeLMUl6nyC9Y?=
 =?us-ascii?Q?KaadPGpKP63MrNba+8GN1LfwW9KGsECxVmm2FvXiIKhXV3PgyCDueRnwI52G?=
 =?us-ascii?Q?4/7V0KgO4MQ9mGZYYjQOADd12LnNKniVYKLWtFODjghvXXgClrHAu7xKC83W?=
 =?us-ascii?Q?XekbAwg2r/is7XBwjO2fPJvq82MR0DH0P8Osyki6UsWUAw/4kotZRYDLI0gn?=
 =?us-ascii?Q?4wc61egoNZ6eAW4am4P9z3BmpUjQlUzATB10Jbd4Ci+L+uKcV9HRaQP3V1VQ?=
 =?us-ascii?Q?OsYmCfhNv8skEaR6ol5OE+zHW+VjCtGCLLzwWzLZEcMw9NAoOdzN3tjDFPzO?=
 =?us-ascii?Q?9JZBMa3ekvUWXStOhYSEE+mcoSoESqGNP3ZOfzV+EaoiCiDsnjDOS1PH3KIg?=
 =?us-ascii?Q?t4XcY19q7ROnvzfIKTRUabAPH3FtZcIPROskFcQyWNzkTLvWFvAHpgmwm6ub?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mg6z1Orw89d31pL8rMDAELovtt+AaxCD6/NoD7Ar3O6pUY1gjqomyxjvggwlajSg2emf6PWKOroUFBLUXl4CjO6D3PvyCZ+MyL9PZT5iRp+lc22UAyZHJSpULVBzIRMkv5INP8N/WMUr7FiAO3f7vOHCRuG1hzuSB/xL6rtmyrq3uMoeobsITLuZZH90tnMDl2kb4uI7a+VQ8SN8cocRr4GJwxJb+c0itQoi9VACLI+yPCTMGzIBeOtLzQeV4bTN0l2V+EL9dYYLJ81X/E39c8zbk4nzqy0rVle6emeZVimZvIXa8cdPGGlbq+CYZ4EVqXeYFUkYI03Plcu2b9/Qzmc2CkhOB9MCcsAiheQetT07i9MOuTaL7lrBp2z204lJ9ueAU/eMSY+qJ0UKTeCYf7+hfDN7TN2ujUtTyQbnWWg0oOfIqUIkULCNH3ud/aVn52X77wZSS/t1w76Z4gbdO9XN6nKKmwnb6Odun/zyYdX3CkEPLTwdYKHi8y9tHug3uHqapJIyoOQyeaMV6yaooMG9DeWFGbIVsc4vCZnBWRIp3iqZEyOc1xJhHTtYceSo0no+JDvqiF3mGbfc2AM69N10iH5/NEQjoQQmovha2x0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e833dfb-7982-4815-4f95-08ddfbf4168c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 05:26:32.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYGtz7ki6Gj7qTRPEO1SOu/WtxtpNhNMnrAjKguNfQXiRUNG8UWcSf7SZcpOBfHRiYZuITLyvcnOLZXgeknLyspvDyY0X0MXQGi83NGf8Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250049
X-Authority-Analysis: v=2.4 cv=C5XpyRP+ c=1 sm=1 tr=0 ts=68d4d292 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=_oAXWQufAOcG58O0zIsA:9
X-Proofpoint-GUID: TdGDKKYWyLFWgM48aLWv0zdwJhpyCd2u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNiBTYWx0ZWRfX3RG5eSz2WBWq
 CDmdI1xSE4QCDhZMp3syNwH3UxOG9d/3c6wET8smfFVvzCxr7MwI1n39Yz1GxYrcH010lJhR6+7
 CdsRaQzqAzWqnSINoQNM6PwFOH1YHoeEQ2xXbjGtRXkTj1UncRQeOcjPnubVK85t9U2Vv6LrfUg
 Yo6ZXEJAIi2qWtpQeGiU804eCCDfgHp0fSiuhWoiahD1da4pF+KTdtiPYEAJn34en5vwW/KOrEK
 yTSGzdiKgzDgD+j7205c7X5yGx5iPrtggKt8CxujIApdUNApkBpQvxngQxWb1FW6TiTQbHVpwhl
 P9yY4LxpF9r670NC9eIUPAOY+uhjFYrS4r9PDaOnlXFDGPyKGdRQ29SeChFPKJZ4IKr1+LZwE3p
 d0qZo8Ya
X-Proofpoint-ORIG-GUID: TdGDKKYWyLFWgM48aLWv0zdwJhpyCd2u


David Hildenbrand <david@redhat.com> writes:

> On 23.09.25 22:34, Ankur Arora wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 17.09.25 17:24, Ankur Arora wrote:
>>>> Define clear_user_highpages() which clears pages sequentially using
>>>> the single page variant.
>>>> With !CONFIG_HIGHMEM, pages are contiguous so use the range clearing
>>>> primitive clear_user_pages().
>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>> ---
>>>>    include/linux/highmem.h | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>>>> index 6234f316468c..ed609987e24d 100644
>>>> --- a/include/linux/highmem.h
>>>> +++ b/include/linux/highmem.h
>>>> @@ -207,6 +207,24 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>>>>    }
>>>>    #endif
>>>>    +#ifndef clear_user_highpages
>>>
>>> Maybe we can add a simple kernel doc that points at the doc of clear_user_pages,
>>> but makes it clear that this for pages that might reside in highmem.
>> Didn't add one because clear_user_highpage() didn't have one. Will add
>> for both.
>>
>
> Doesn't have to be excessive. But even I have to keep reminding myself when to
> use clear_page(), clear_user_page(), clear_user_highpage() ...

And now all the multi-page variants. Really motivates the removal of
the HIGHMEM stuff.

>>>> +static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
>>>> +					unsigned int npages)
>>>> +{
>>>> +	if (!IS_ENABLED(CONFIG_HIGHMEM)) {
>>>> +		clear_user_pages(base, vaddr, page, npages);
>>>
>>> Single line should work
>>>
>>> 		clear_user_pages(page_address(page), vaddr, page, npages);
>> Unfortunately not. The problem is that I'm defining the fallback version
>> of clear_user_pages() as a macro in the previous patch.
>
> Yet another sign that we have to fix that instead. :)

Yeah :).

Thanks
--
ankur

