Return-Path: <linux-kernel+bounces-869573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A2C08324
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 174E64EA7EB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D261D309EF3;
	Fri, 24 Oct 2025 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Svx/51lf"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA43F304985
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341533; cv=fail; b=mTQJHPa/KlZF02iHw3p9oagtkxSl5/UZZWLnCr0aU3y6YHcQJSph8yiTLs0Yyfq+pNTRdYl7+BBpGBuf3PGMW7+SkruSv5xY/9o1+cgv2P6tlLCKKBl+7vIio5NSqswpJXMjW9yN9Ys1aDUDzFxyRojpKNgc3pQROvZ6tZMo4ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341533; c=relaxed/simple;
	bh=zvrAtfIgCmSLJh3Wk9MQ+NPS7h3Swwq1AuhAnX06QZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WN1Qa8zWOfJVKXBd8NSTQmN4v2XTbpPqjqexOGZNJLCA/+m7V5R6HKPRqZVsufw5fPOeWsVgo5ag5VeXqQ7UEbFMH0E79tBRVtv14rWc7q2G9xzkrYescjwMx3+Ne7dn2N3BQVcgTDWGL5sDLQbaX82qwGVgCuWDKLyKyBv4/GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Svx/51lf; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs/JL1CVRORuhtsbjN8MGsYxWaAH0lVvidhVms6tSw96jXXss1kYt6ZwONE/yM8LBR1dWXq+UsMDFMZYJ2nRc87+y2Uv/uOzeGo5R7lXN6RPukFmXua7BGLixzhE4132ZqJLyRYrWADOziMUA69VLpvyWXUHuuvlmGkyyP+2sefAzoYzxi5j1nbuhRlMJ4c7zqJTSJf6VADumgrPBwfZx4nW+0qWMUfa/7gjwbCieVwQu9Jashvn1RIeXZ0HKirzOpZJJHro5DWtMJ/oy/yx+ONa/GH16KN4+oRDakLpeyRw/rgUFEKZ05ODBNZRkqngRF51q2WJudR4tkX69Fu3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWlEvnb0Hb3qCqMlSgWbLBPL4WEwca7Qv7FHWN/XnuY=;
 b=CHdSZ66o0ePjYXJrMgRkx/iXdSQH84BKz6LTVbj8E1z1anFVziuAGKB0ta6goti1XAmYjCgvztLrBMtKNUDmew4o+iXdaZo9qPMR6p4SkbRY919AjqvCCjOAMPKMLKuPK/6E0kfquBV++OQ8V/FkAsXYpUFdC0dyjUFwtfwXOpPjDfhs5s+9QVtASz9IUdVEegujuzqezlVh3k7To8XzSmWsTmh5EQhZ3deBG2uT56NLp1bo8l3WmW3ZpfIr1GYTkaU+IJw5TBRZ3IWqK5ik7rviSHDp3rUkyOl0snZn1jwVxmExShbN+erSnLxLQU939ThZnaK7afa6+0fLW7XeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWlEvnb0Hb3qCqMlSgWbLBPL4WEwca7Qv7FHWN/XnuY=;
 b=Svx/51lfRpja6xthJ0373lL3vZ1KJOLRnAlEkpti0L6QGxdhSrNekyBU0E/PF3X+Pw9dk8eO6x349PXzo4SN6LFcd9ti4p/kCXRAXOAwYn1y3dS3AzeDQypuloCkDhNuTmrckHNqAnHI3b+vJlXPli6Npvgn0Y+tjfSpyLbMvYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 21:32:08 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 21:32:08 +0000
Date: Fri, 24 Oct 2025 17:32:04 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: x86@kernel.org, regressions@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: AMD topology broken on various 754/AM2+/AM3/AM3+ systems causes
 NB/EDAC/GART regression since 6.14
Message-ID: <20251024213204.GA311478@yaz-khff2.amd.com>
References: <20251024204658.3da9bf3f.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024204658.3da9bf3f.michal.pecio@gmail.com>
X-ClientProxiedBy: BL0PR01CA0023.prod.exchangelabs.com (2603:10b6:208:71::36)
 To DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ad5ef1-1232-4c84-ae89-08de1344c901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?65c8ZLZqmV0MD0PE0wsEXqZdB8DNURU4vEKlHGULQeFRwyYB5crxEy1YozJb?=
 =?us-ascii?Q?KPsFSlhJS81df3RLkeors9KsmBYsTbsG/TuioH9Nmby4ATVB4Z6DXb/aWGK9?=
 =?us-ascii?Q?XqDogEzY3dbW3RIhrFaJum24UJfw2XPlnWSgEI/CpGEMRTfRbC7cTfe9hlob?=
 =?us-ascii?Q?s1/oJWt9B18xp1eOqW4qHD2DmB4OMKvNk5Fl/oyDOZDgvEeXj5Y7NxCjZOpW?=
 =?us-ascii?Q?/y2SVZ65+/lz9lQ4bMxK7b2DhCN7StFCmRu21HoMBVyzLs6Sr8C3ZwSx16gf?=
 =?us-ascii?Q?U4K3ORqj40nbrzOL3q/JP7bgV+T2wj+gjCZXQ6qxJTGwb5RLuXdPT8YGdM1B?=
 =?us-ascii?Q?QdrvbprL+K8b2zwf/6ZnOlM2cqk1qatBAXEsuz9h9+Y0KL04sUtYmSFOA7TY?=
 =?us-ascii?Q?UY24Vibc80QBITt+lNnPFduc1KNoYNaMy3ZMhn9qWrTDZP3V6YZphmCdxlp1?=
 =?us-ascii?Q?iQ/sEPSjvbmkmUpVgeMFG+OARTOzvjcVIVCophCyv7p8ScBywRFfviacFsgd?=
 =?us-ascii?Q?DqAC+7TwDhyTJmQNVcsH0ouPDQm3tzQPkmu6ZvkxETgG6xW4b2Tf0CgGDkoG?=
 =?us-ascii?Q?6/xjivQ8n0GYvVF7uT86UK3fQuoxd9gkmw+PWeugcTGjFHCLHkLq2lsq1b2n?=
 =?us-ascii?Q?GZPOaK50aTBjrVCUTfm4U626ig9HmcGi/sFr4cVleN+V2JJGAlMxtku/f9Vp?=
 =?us-ascii?Q?Kt2HpucdQf9XyXR+dl97rQz3oSldg3StSpEPth1G1HporWh0AET+K1nM18uA?=
 =?us-ascii?Q?u3/KaxRiWqiJNxrdldcMMaCGZBbRTaAnvC4lczKb2DXdoGfaPh6AbXsR+bRo?=
 =?us-ascii?Q?WU+BL33S5QpjVPqJLzY4FiLXDad7wcSEiRc6BJXe+2FbSY+w97GmrJe6MKzh?=
 =?us-ascii?Q?mUE7Z7+lb6mwNa19pxDeMnWT0xK3dvgxqJn1gxndaXZ0eWWOYZnZTz8C9ltD?=
 =?us-ascii?Q?YMiZJyp6gR7QKV7aq0Kn3qiLBRA2wFjHG4N+Lg5qQOCloDHwy2/CwjeKuXFj?=
 =?us-ascii?Q?uksEaqyovOSiYj6e3Clb/fiVW9FqdtBgTuKWqmjtf9xFF1XNIqR4jeoCWi3k?=
 =?us-ascii?Q?edJnpPqa4GKVZWAWXevONH96wndHdMWUqDNvP82i8RAfVixfwUjbxi5qPog8?=
 =?us-ascii?Q?8IVAe700Ytx0PEvh1ntGybJvqmVEIzS8TSVnRvA78Aq6W5fb0SQQ35q2OEVG?=
 =?us-ascii?Q?RlDGUAd9n9LKDHZiA5dCTr1gnoIavQwncP+YniB3KtAeBMLru9rnB7BYjTFy?=
 =?us-ascii?Q?TkMjUiFN002HM+wB4pCBkJw+68LjymOJW78i59gO6b0Tsd2xipzIVqeCjjcm?=
 =?us-ascii?Q?jxtNy3weXnSEH3ChaXi1lFixYyy9EKfw/8T5K5j4LoLU7EEjELOQ5gQ3rdhC?=
 =?us-ascii?Q?VP5wC4LRmm63/bSKNWwmefO763u07dj3V7kG47Vw343jacCv9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jH3t6cGLbDexo4dh2kTyo0GPDcR3PPkxlJyBnwXUAP6y05BIS6e8PyaYGHdG?=
 =?us-ascii?Q?HKVM2r+7e6panxnS4cfmkbVCEbzt0bN0WK+uGFeWV1Dt46elJ+0WKW6+R87l?=
 =?us-ascii?Q?UCjvNDklQim9Xr+84hxNOymFkcJXWSIlqtzzOkXgEex0f5YuObVvV69WtSvm?=
 =?us-ascii?Q?4y0nbmPNFQ2Ds2uYysgzQJw9VYW6NjkbHg52jLb87TWt3lWEqWDMGr1G65Yg?=
 =?us-ascii?Q?qrmimvncCkoLx3cvy89Xphb3eEnwG1TNxqYl9Fhn+I4XsaIdh7xODLLd3Dmn?=
 =?us-ascii?Q?MntMSXmgh8wumog6Z4VE+tMlOp+tUNGvOTzwU8N625tox+FXP2dOg8IzNpZT?=
 =?us-ascii?Q?nKtMu8sZjgV6AjIWJpOS6BwehEmyG5iVtP6feyAoyQBoF/w9dxKt366ree1B?=
 =?us-ascii?Q?VmehN44/KLObqKYiBTL02LOdNQEgvzDKIX88+nbKzXACIeeHhdU/37nEclTw?=
 =?us-ascii?Q?L+YPTFex2gHLd9vnLFijUKS/obG9NAP6pTijF3g5FihBuIjjcLo6yRAz7Fz3?=
 =?us-ascii?Q?F1u7TQr4NZ6cRKsKP6Frf2i9UpH3LlbdckhidIPyhVMLL75QG6mt04SGohYr?=
 =?us-ascii?Q?rJlZ7LBOk+yHAlkRMXCjQM7acT1G7eV0tcrtI0PY9nAN6cqehRc1voEjRaqb?=
 =?us-ascii?Q?GhocaC9BvPmHgLC4nS/sulo8EqJySX/2K1wi+U66akUdhjQlzWPSoD1Mb1Xg?=
 =?us-ascii?Q?R0I/Z2jZ/dRdq7DObeeQJf9heXct/gz27cwWY9R6fdH0gPvUji3bIC8Fl/3O?=
 =?us-ascii?Q?AZ77F2RL5IAeOTW473a2RY6K6rlHz04VlAW1+pYJ1NUsKs1rAhntuJul0QEA?=
 =?us-ascii?Q?gqNm5aMuWFM9ImHRwXuHaPgYLMnW3QGxY5RcuXLJZzKkpuzZxMKrNAfelBY6?=
 =?us-ascii?Q?zcxq5i6wT2PQOrgDDyy8Axtn9EvHPWZ8BNr+BxR8YL0xvhOtk3lbr2jnVbXN?=
 =?us-ascii?Q?9L9OauDC52jPGRKdYNO7B6y04bB9G3DK8Mq0oG9Z9eEMvwwxP+PyxzH+dV2e?=
 =?us-ascii?Q?930bQ3K+q1JXL9zPQUiYtxhaFiWCE+7rUKiiu8YK++ilT7v0MrvdVM3jTLrb?=
 =?us-ascii?Q?fydC1xus5rgCgK4qcGUu+YtTa7bAIXvfUuhpbfArQgsEdyapOjAv4gdJTkVH?=
 =?us-ascii?Q?u0ybij7FLhDPWdyrVvDdEZq+lBxSSxggK4zs55E3nDgRGjV/OBq0qsBcFKa7?=
 =?us-ascii?Q?q4mPgfiQ+NOfF+MGd2yqAjqVfXNPEZzwa6e9HrTmWrCYzU/8SFtzpOfEbAZp?=
 =?us-ascii?Q?c8QArTX7x7qPcDcIazJ/z2tiCyajMpOCWMnhEL6tFnQfFXZmCKzpueguIVP/?=
 =?us-ascii?Q?x9xqqOvOwOS+uZLvioTbnx8s/7sbCuIdLFLlWcuQZdy3iM8oNW6Ew7B/o6kG?=
 =?us-ascii?Q?+9P204Y4wdEX8xdD0zVhnXX1rW48FR/3RJbVBcGyob9RqG7/0JXVYi6cbvHs?=
 =?us-ascii?Q?PxluqfVowkILyIpKkIFYb0MHCRSsxbp4oVhgc/TRsl7CEsz+wvoBRShhXWaH?=
 =?us-ascii?Q?5iBgWRKMskMXIloCf2Pmj7zcXO+dg0mYvbSyqgv7PkJP8oICbx9JR6Z7xUGY?=
 =?us-ascii?Q?os9H/OOkg7Bsc70A2jXVTEhNLdxItdqRIYiKaqLi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ad5ef1-1232-4c84-ae89-08de1344c901
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 21:32:08.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKblW2lURhv1DDiy3PgRMkpHENAA/8E1y2fRCO6OHStXbfc2ojg6aWavURldT0ZMaZ8Pv+6HS1AQqSfo7+mppA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068

On Fri, Oct 24, 2025 at 08:46:58PM +0200, Michal Pecio wrote:
> Hi,
> 
> This report is related to discussion here:
> https://lore.kernel.org/all/20251022011610.60d0ba6e.michal.pecio@gmail.com/
> 
> Commit bc7b2e629e0c ("x86/amd_nb: Use topology info to get AMD node
> count") bails out if it can't find the NB of each node reportedy by
> topology. Then NB features like EDAC or GART IOMMU aren't available.
> 
> Which was maybe not a bad idea, nobody expects those things to work
> on selected nodes only. (I think?) But it relies on the optimistic
> assumption that topology knows the true number of nodes.
> 
> Today I tested 5 older AMD64 systems with socket 754/AM2+/AM3/AM3+
> on MSI/ASUS motherboards. *All* of them report more than one node if
> the CPU has fewer cores than supported by the BIOS.
> 
> (I also have one AM4 system which is OK, but can't speak for others).
> 
> This is due to peculiarity of their MADT tables - they report as many
> LAPICs as the BIOS can support and excess LAPICs are simply disabled.
> FWIW, it's also a pattern that disabled APIC IDs have 0x80 bit set.
> 
> The kernel counts this as "hotpluggable CPUs", since supposedly it's
> indistinguishable from actual multi-socket systems before ACPI 6.3,
> where the "online capable" flag was added to disambiguate hotplug and
> nonexistent but theoretically supported CPUs.
> 
> Or at least that's what commit fed8d8773b8e ("x86/acpi/boot: Correct
> acpi_is_processor_usable() check") seems to imply.
> 
> On pre-ACPI 6.3 systems those disabled LAPICs inflate topology size
> and result in breakage on recent kernels. A few examples below give
> an idea what those MADTs look like and how the kernel reads them.
> 
> Regards,
> Michal
> 
> 
> Athlon 3000+ on S754:
> 
> [02Fh 0047 001h]               Local Apic ID : 00
> [030h 0048 004h]       Flags (decoded below) : 00000001	# enabled
> --
> [037h 0055 001h]               Local Apic ID : 81
> [038h 0056 004h]       Flags (decoded below) : 00000000
> 
> [    0.027690] CPU topo: Max. logical packages:   2
> [    0.027691] CPU topo: Max. logical dies:       2
> [    0.027692] CPU topo: Max. dies per package:   1
> [    0.027703] CPU topo: Max. threads per core:   1
> [    0.027704] CPU topo: Num. cores per package:     1
> [    0.027705] CPU topo: Num. threads per package:   1
> [    0.027706] CPU topo: Allowing 1 present CPUs plus 1 hotplug CPUs
> 
> Athlon II X2 250 on AM3+:
> 
> [02Fh 0047 001h]               Local Apic ID : 00
> [030h 0048 004h]       Flags (decoded below) : 00000001 # enabled
> --
> [037h 0055 001h]               Local Apic ID : 01
> [038h 0056 004h]       Flags (decoded below) : 00000001 # enabled
> --
> [03Fh 0063 001h]               Local Apic ID : 82
> [040h 0064 004h]       Flags (decoded below) : 00000000
> --
> [047h 0071 001h]               Local Apic ID : 83
> [048h 0072 004h]       Flags (decoded below) : 00000000
> --
> [04Fh 0079 001h]               Local Apic ID : 84
> [050h 0080 004h]       Flags (decoded below) : 00000000
> --
> [057h 0087 001h]               Local Apic ID : 85
> [058h 0088 004h]       Flags (decoded below) : 00000000
> --
> [05Fh 0095 001h]               Local Apic ID : 86
> [060h 0096 004h]       Flags (decoded below) : 00000000
> --
> [067h 0103 001h]               Local Apic ID : 87
> [068h 0104 004h]       Flags (decoded below) : 00000000
> 
> [    0.147372] CPU topo: Max. logical packages:   3 # not sure why not 4
> [    0.147372] CPU topo: Max. logical dies:       3
> [    0.147373] CPU topo: Max. dies per package:   1
> [    0.147379] CPU topo: Max. threads per core:   1
> [    0.147379] CPU topo: Num. cores per package:     2
> [    0.147380] CPU topo: Num. threads per package:   2
> [    0.147381] CPU topo: Allowing 2 present CPUs plus 6 hotplug CPUs
> 
> Phenom II X4 965 on AM3:
> 
> [02Fh 0047   1]                Local Apic ID : 00
> [030h 0048   4]        Flags (decoded below) : 00000001 # enabled
> --
> [037h 0055   1]                Local Apic ID : 01
> [038h 0056   4]        Flags (decoded below) : 00000001 # enabled
> --
> [03Fh 0063   1]                Local Apic ID : 02
> [040h 0064   4]        Flags (decoded below) : 00000001 # enabled
> --
> [047h 0071   1]                Local Apic ID : 03
> [048h 0072   4]        Flags (decoded below) : 00000001 # enabled
> --
> [04Fh 0079   1]                Local Apic ID : 84
> [050h 0080   4]        Flags (decoded below) : 00000000
> --
> [057h 0087   1]                Local Apic ID : 85
> [058h 0088   4]        Flags (decoded below) : 00000000
> 
> [    0.072112] CPU topo: Max. logical packages:   2
> [    0.072112] CPU topo: Max. logical dies:       2
> [    0.072113] CPU topo: Max. dies per package:   1
> [    0.072118] CPU topo: Max. threads per core:   1
> [    0.072118] CPU topo: Num. cores per package:     4
> [    0.072119] CPU topo: Num. threads per package:   4
> [    0.072120] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs

So far, I think the way to go is add explicit quirk for known issues.

Please see the patch below.

Thanks,
Yazen


From eeb0745e973055d8840b536cfa842d6f2bf4ac52 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Fri, 24 Oct 2025 21:19:26 +0000
Subject: [PATCH] x86/topology: Add helper to ignore bogus MADT entries

Some older Intel and AMD systems include bogus ACPI MADT entries. These
entries show as "disabled". And it's not clear if they are physically
present but offline, i.e halted. Or if they are not physically present
at all.

Ideally, if they are not physically present, then they should not be
listed in MADT. There doesn't seem to be any explicit x86 topology info
that can be used to verify if the entries are bogus or not.

Add a  helper function to collect vendor-specific checks to ignore bogus
APIC IDs. Start with known quirks for an Intel SNB model and older AMD
K10 models.

Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/topology.c | 52 ++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 6073a16628f9..704788b92395 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -219,6 +219,45 @@ static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_leve
 	return cnt;
 }
 
+/*
+ * Some older BIOSes include extra entries in MADT.
+ * Do some vendor-specific checks to ignore them.
+ */
+static bool ignore_extra_apic_entry(u32 apic_id)
+{
+	u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	/* Allow "physically not possible" cases if in a guest. */
+	if (!hypervisor_is_type(X86_HYPER_NATIVE))
+	       return false;
+
+	/* This model only supports 8 threads in a package. */
+	if (c->x86_vendor == X86_VENDOR_INTEL &&
+	    c->x86 == 0x6 && c->x86_model == 0x2d) {
+		if (topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map) >= 8)
+			goto reject;
+	}
+
+	/*
+	 * Various older models have extra entries. A common trait is that the
+	 * package ID derived from the APIC ID would be more than was ever supported.
+	 */
+	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 < 0x17) {
+		pkgid >>= x86_topo_system.dom_shifts[TOPO_PKG_DOMAIN - 1];
+
+		if (pkgid >= 8)
+			goto reject;
+	}
+
+	return false;
+
+reject:
+	pr_info_once("Ignoring hot-pluggable APIC ID %x.\n", apic_id);
+	topo_info.nr_rejected_cpus++;
+	return true;
+}
+
 static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 {
 	int cpu, dom;
@@ -240,19 +279,8 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 		cpuid_to_apicid[cpu] = apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
-		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
-
-		/*
-		 * Check for present APICs in the same package when running
-		 * on bare metal. Allow the bogosity in a guest.
-		 */
-		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
-		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
-			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
-				     apic_id);
-			topo_info.nr_rejected_cpus++;
+		if (ignore_extra_apic_entry(apic_id))
 			return;
-		}
 
 		topo_info.nr_disabled_cpus++;
 	}
-- 
2.51.1


