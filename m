Return-Path: <linux-kernel+bounces-824567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD21B898EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2463B347B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F52367AD;
	Fri, 19 Sep 2025 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="roNl18MR"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C451E32A2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286616; cv=fail; b=Dsftvzadf+nFKkUkqGZsXasD0j+kSUFyzemvpPOMneEjo6z055BjWLuxIZkJZ3oytXRipBHQPI+2VWxwfprEuugRCHZdIfDx9bXIbof/7yMHoNzbHOR/xAW0gfI+nW7tLbIQTIzxu4dq+0WGtg5LkfTE91XvLJAYEzg/bEb/d+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286616; c=relaxed/simple;
	bh=27GkhTRMp1c9kgMUUkzzloMrviuFvuKsyeVf3YauCd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RsetxwsCG9f7dG0fHXwstUDoPMJSBpHp930b8/GG9V4LZX9TFESI+1c5dptsFi4hRXDcxUqMt1ibdHOLFIXON5zx/EPqyWGdHy13FxJ/0zf84JgPSfN0NudDyuxvnEcezWuUnqhArDzmKA4UkAF7sfHhobHjpWvh489QOePz8MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=roNl18MR; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXTenyWVrQQVc2A6aXV02weYMXRVAWjeb0eB2+jbGTzBc7ocFy5mLBUeHa/dXKxqaQsbgzgUJ7AaD+IW4Wp7kgPo+DKghvR+KrOTJuaF6aAGqShkyyDORD/BM457EQxoD4nMJuQSU18DefOvOC9vSQ5K3ABmon7FX4obTRjWcxf7mU00NpKiTwtAiGd+i/lUhcieeEjGJOE8atAh+y2Xhdieb4glB9SNuJkg7O0clQqFTfdlKco4IUATbPFZsSn6ARtYfFV/dXwDAt9s9xAbAwEjd3BWy8HNideB4F9sSqU+qA5LYP/N2VD5mBSa652hv5MbiFtjvVnKNyMzskW5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sXkyLG6zSpE8Zg8MgpvfJixz+QjhL4EEfTfyfr5+OM=;
 b=IcPc6oEJaZKIfSaYxwZUgjDGpU6ZRZMmGNoDIbzasdLo9RM0WGupIBB/tlBN38Fc4RZMMsah3IbcfUWN8DpatDLkscvomyLmF7ocwhTmS0xNs99id58q+R/E02s48DBcl6gkn60R45SrFeKCASDQ4FSdEapYcFFNVSzPTQeIAatnD7ijjYfVdk520APBS7VipUthSWFLhrlxILNHRNKZrhb08qthaFYwKTr2syOVtz2yniio5WA9/Ytw1uhyrq/Z6J8E28xgNBBfBgvp/5guSL0l2nl6rCt+Q5HiWCrXhICweuqAdLJ4Z7rEWKSUSWK4zgOuGZs7Q5HNV40MCDpKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sXkyLG6zSpE8Zg8MgpvfJixz+QjhL4EEfTfyfr5+OM=;
 b=roNl18MRbeyyjjyXYAS+iN+qs6LgxsBLB3CYONnJJqYkzw06LynGhfsp+6vSw2PCE5/eqxPympNHJMdj7EPvGziyc9t8gUvPtVxXLOeZu9LhZ6/vvbcvidYO9iVz9+BetNM2m/kCG9qLZgpKrVDnSU2KlRef4muzVIDTSDcvEW6HHc6/oJyZcokUj22M3EhmXi2ahSXiPkRDZPKx5YhUu0hIYkaFayt/Pj05zx36DOknj85yZn47TnzumZdc0o/3EwjnA6N6+LsKpRA642bHPMDUe7Nny94b9XkE2q1k6SUaTFwCzxYLPnKdCYE5Mzfz+dIvctZpF6+m9oBZPQs+sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Fri, 19 Sep
 2025 12:56:50 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 12:56:50 +0000
Date: Fri, 19 Sep 2025 09:56:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Miu <jasonmiu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mike Rapoport <rppt@kernel.org>, Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 1/4] kho: Introduce KHO page table data structures
Message-ID: <20250919125648.GS1391379@nvidia.com>
References: <20250917025019.1585041-1-jasonmiu@google.com>
 <20250917025019.1585041-2-jasonmiu@google.com>
 <20250917122158.GC1086830@nvidia.com>
 <CA+CK2bBbSSyCDAAgThDSSwH0WdOeHz-eVgB-1bdiwsDtTSE5pg@mail.gmail.com>
 <20250917163200.GC1391379@nvidia.com>
 <CAHN2nPK+Z5cvQ_waTWyPZiEoeSc9o7e3YnQLLjRzNzrb7VhAqQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHN2nPK+Z5cvQ_waTWyPZiEoeSc9o7e3YnQLLjRzNzrb7VhAqQ@mail.gmail.com>
X-ClientProxiedBy: BN0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:408:ee::11) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a716519-2ae3-4775-68f1-08ddf77bffc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qaIJtcENLcfThMaMroqcCIaMUUV3D3bYhUK3k6DODtXRnQuqi575g/CpTnsl?=
 =?us-ascii?Q?mHJUWXJKw8e/BStdFZiB8oIex9wpBN5j5lz6cQ6gnIY5WkBLRpR8Z4v1jZ9U?=
 =?us-ascii?Q?bcpuQmg3kurrSy4wV2ArOL9RdPYvyOzs7lZe2OHBoVz1FjrjM6WA7zhDe3ty?=
 =?us-ascii?Q?KeHGZbrT/4/rvafsq2i6DzzrIwEP2SiZubsIyiqXiFPbIQruF+ecak67NBGp?=
 =?us-ascii?Q?Uki67JpDR42kv740IMTcFXjpq7KTXR219tGTj6F+oZlRR0CYIfdRzP7iTkXP?=
 =?us-ascii?Q?Vlq+WnkAfwOlKSMrzyNFNpYcpfMTRqMJBZML9r9XMTJubPOm+2oQRGGf5nGS?=
 =?us-ascii?Q?R8SVPAmN++XpuzPzOJ10EQAed+PT6wRSa9CJf8dxwUOxOyUzZV++bHJl5iFw?=
 =?us-ascii?Q?kKbzIkuEF2SZCwn7gIaeoPq7Fd7Up8yCVZbagqhousCkJIXLo4iby2lBQZWE?=
 =?us-ascii?Q?u28mum4DmyoWFO6OqthF7jbFo5IABmG38Us+ExBuh2dse/Suf2OncE36v/23?=
 =?us-ascii?Q?9rSMrPFxwNeTUPrsAFUVZsyJiuCCH5Q+g7qMmHE8vRotFpbb7BKWHaGLDkiN?=
 =?us-ascii?Q?0hJHxBFVcyQtr5aWLcQlMdvyaxI/+plLFShJsfXjKCc4hDVuuaUrk6YwhijU?=
 =?us-ascii?Q?a3LnLaICsFrHq9tgmUcKBcnA8uDloUqnu2DNlyQxUBQWnOpl8Lchds401waL?=
 =?us-ascii?Q?2fd77KVrKHR+6GM52L/G9VertQObHAgBybLv6d0ttSKNYS9e4aw5ikkS0PQq?=
 =?us-ascii?Q?4yQ/dGyUiSAz9bDStEp9GU/Q8Eu5cpYSK9pp8qhMV8hb94O+JQMp4FHtF8s9?=
 =?us-ascii?Q?hFsCQVayKgi01Gi2xGLApeaTlffD3tbKy8UMnlnQ1G01LH1uX8xfEMWfm+KB?=
 =?us-ascii?Q?C79GkcEKbnN+n/RL6ah8QrEiFFOqsZd70wHVuzCfJIARHBfLVR3qYTkVmQ2s?=
 =?us-ascii?Q?PARYsFXucjJp7Nyw1IJSxqaiUpvyTTXSskYXbRjdc+Pn54bLXnSJyxV3ykA9?=
 =?us-ascii?Q?qqf0oNWtxfyBCGMCoGXOwke6JTS52hFMs+tyLa/g+AluRmk3OYYRFu0IJf5W?=
 =?us-ascii?Q?/10YcuhTszgBkfCkZnyB5olaVjkP0VBYyf0aaUTpzHvWlKR4xZvvOE8u5svz?=
 =?us-ascii?Q?T8wxEGknfO268050bL4MEeKI9Q46dnu6MzTDJuPGJFxFaOh+m+hIlo9Arcac?=
 =?us-ascii?Q?qus3DyLeU+6qXL7X29kem/mHPssX3Fh4naSd7f7iOB0LKjTHgqhMZ1eIkNhj?=
 =?us-ascii?Q?E2j22Ic7U/kyvs4gp5ovd9DNWf1HG9OnoaoS9ahfoLTbzPJ4FY1a01e/gnHV?=
 =?us-ascii?Q?uGWrysLdqYVbUCBwRW9422pdqdL+CrxCvDfLvfanbX/Ux7LhH67u0TxwXEs7?=
 =?us-ascii?Q?JRSlv54H/2QG9CAPJlkA8PT1RclAcxnvf8YUEwvQ12z4VMcHyzb6Wta1FjQF?=
 =?us-ascii?Q?FqlHXt1HQe4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KoOwwgxlryghWI+9M+Ca3/wpHYiU4RaDBoAHJjmgnt0sbcWFaKQsu8VfVfQG?=
 =?us-ascii?Q?ZgOpSpDa4XbXpWYQhbHv7b/7LVzqWnjllOtmkoREOsH7DPsFj6ZX2Ey5RlQr?=
 =?us-ascii?Q?PkRqbQFQcEhHSawo5HkKF4w0qxAPI3DmT2Pbnh0Bh8fbipH5Dt8bLSu4RPMu?=
 =?us-ascii?Q?/Tce3l2b1hBoAPl9Pw5TGOM7ZZNbFfPwZgvVuX1YXUU2rTKR888dxsNMeNZr?=
 =?us-ascii?Q?0UFj+C/rord8yvga7Uu7jlhOxUgEjJ5GQuoe9AdRroKu0+gyPsmX+Fe+BhPO?=
 =?us-ascii?Q?KtdMhTA9NQwkjOLjJb+d7dJtPzSfmfYjAS2aKFhdn3Kdx2W1rRFOKxe9150+?=
 =?us-ascii?Q?YVl+NXN/eNEpA5TKFqLtoNGao1QqnYu41Fs1XScB6h8RjJu3jhXpktliloo2?=
 =?us-ascii?Q?aNcAc2jTcISEtRMSeJqCyrb+4DnUCplW348jM/dEpO8/G2wSP3aAOrTU1S+I?=
 =?us-ascii?Q?4RSg2fUtuV5PXw2SImMFQXTzLEgXgQxGYpGyDeNseIpZVG+b+k32ywutK8kP?=
 =?us-ascii?Q?L3vmPauvQfUh63BG3f829EZROK4gnvFApD/DekXpt+HGS4KR8zeoCodsd9Zu?=
 =?us-ascii?Q?3UxgsBUzsA1TWDH63vx1oql43xqoz/m09BSoZiAwuCm4e3YobtC7zWbDO0A4?=
 =?us-ascii?Q?vNjX4AtjZgxNrrwiz3rk5JTTRRZY0c2Xn0X3a6xSmi1i24QLYGEtKgZGMLaf?=
 =?us-ascii?Q?c8s0gMZ3OqmURfv8tJE+dnkS3eEtFg47XxycokKvpE4iCTyjtqIPs6PqMV/6?=
 =?us-ascii?Q?dS+QfsIcCdiF8oMnRgipZCl/LB29BaQSuQOa0U8a8v8+3ZJObLGeaqZZ8pro?=
 =?us-ascii?Q?xSwj7bVf3CUyw4z26+mpVoLvsotI9I636i6IDEjH/uSD8TzV/OITTEAj2IXI?=
 =?us-ascii?Q?kO71gqzUnTtxfPxZ8QxaWMnfqUzdhKiCDCKxn3liBV3V7Pvkl/rjAzFdMClY?=
 =?us-ascii?Q?kiGnsTosrhwF7ffGggoNZpqK6ccPAPF/LaR2WMnZBR2MJcO82WziX2NBKDUU?=
 =?us-ascii?Q?sWveDDgUG3v3pEe5hOFoqFh4VAvATf1DNY7JA9bmt+dcIpiDuFKo4R1XrUIJ?=
 =?us-ascii?Q?SiW2Vgd0gB26f4Gf62k/jEkQVYdpPmfKBpVoaZjzNO2U1BmtEbYhfC4VqFRz?=
 =?us-ascii?Q?d4cH9C0VhAyw0z+bmzWsh9XV8Mkt2bHu0B8o/WrDpng0ROqLTYflEAqUBtt/?=
 =?us-ascii?Q?FBLosGQe3iFtf0sRkGznafeIktmrOTAtuCCegjzdssVHjVdUQOD5s4twdzLd?=
 =?us-ascii?Q?6VBorPJ7WZ2RWeRwP0kcXMs081QUjOflwuQm/lauzy0RP3tadB6Z8bxnY3U0?=
 =?us-ascii?Q?P5nOWbGKzzmKInG0nytfhN5t+/oUjHDEJ1wLE9j3F38fC+BNs0TNXtNHweoA?=
 =?us-ascii?Q?uEfVWw3gCXI6wFrGATjy3v/487GxUTscmeaUtcMB2TDZndTf/rsZl1e2CuY9?=
 =?us-ascii?Q?Rzjv1gyNqQS8aMylP9JkOHodhmpER2irj3ezg9EqZAg7rTMgjkJVUPgpK6Yl?=
 =?us-ascii?Q?Y3ng28kn1FtYoI7U5cxMW0gN24WPbo61/RcpLuHlwMwzLsY//ouJTemIW09e?=
 =?us-ascii?Q?e45gTlXvtyx0WWq6nMYSCpzgZenr0b/SESkzVCNN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a716519-2ae3-4775-68f1-08ddf77bffc0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 12:56:50.2191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5FV3mbMYndknWHVLlL3yIXRhxk2bumqw4wrZuljx48M6JZ0iP8Mtd/qYtao5pwF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662

>   1. Find the `start_level` from the `target_order`. (for example,
> target_order = 10, start_level = 4)
>   2. The path from the root down to the level above `start_level` is
> fixed (index 0 at each of these levels).
>   3. At `start_level`, the index is also fixed, by (1 << (63 -
> PAGE_SHIFT - order)) in a 9 bit slice.
>   4. Then, for all levels *below* `order_level`, the walker iterates
> through all 512 table entries, until the bitmap level.

You don't need any special logic like that, that is my point, the
whole thing is very simple:

static int get_index(unsigned int level, u64 pos)
{
	return (pos / (level * ITEMS_PER_TABLE * ITEMS_PER_BITMAP)) %
	       ITEMS_PER_TABLE;
}

walk_table(u64 *table, unsigned int level, u64 start, u64 last)
{
	unsigned int index = get_index(level, start);
	unsigned int last_index = get_index(level, last);

	do {
		if (table[index]) {
			u64 *next_table = phys_to_virt(table[index]);

			if (level == 1)
				walk_bitmap(next_table);
			else
				walk_table(next_table, level - 1, start, last);
		}
		index++;
	} while (index <= last_index);
}

insert_table(u64 *table, unsigned int level, u64 pos)
{
	unsigned int index = get_index(level, start);
	u64 *next_table;

	if (!table[index]) {
		// allocate table[index]
	}
	else
		next_table = phys_to_virt(table[index]);
	if (level == 1)
		insert_bitmap(next_table, pos);
	else
		insert_table(next_table, level - 1, pos);
}

That's it.. No special cases requried.

The above is very limited, it only works with certain formulations
of start/last:
   start has only one bit set
   start & last == true,
   last ^ start has bits 0 -> N set N > log2(ITEMS_PER_BITMAP)

Which align to my suggestion for encoding.

Jason

