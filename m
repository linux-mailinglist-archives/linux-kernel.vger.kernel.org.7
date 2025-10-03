Return-Path: <linux-kernel+bounces-841537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CDCBB79D8
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89C2D4EDF8D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9F2D6612;
	Fri,  3 Oct 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i5RlbWHl"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3A2D63F2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510420; cv=fail; b=uW3o0gammaQF/gOMrO/EDvBJt9zkn/+C1DelMier/aTjfS2IN3UNhXPhMpKVgupoonWiKCTnRAVrC6PIC7XX052Tj/hYFQ2iSC0t/weKJqGQgu6sc6s2+bu79G07w/KTDQ6uF+yCOEi4M8PfGzOhPD+iEfPMyf4Y/K977wyh5oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510420; c=relaxed/simple;
	bh=zpcWNeN9Osq0kkFMnKfffb4v6vOyDKbNPAn8xCCMRqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jk5onnzDzteucFrV29dalybkTaJCMWSOOIz7cirRIajseuiomRlMwIcXQdQPvLippvCywi4CsQeRUe1satiRu/EoFWYfkTgV4nUhaWqCnjC0SE9hqYmTnN0NugpDLfRtUfhOwEyVnZuLYNOAuQtepJPpI8zqlPOxxNNyqXPrhTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i5RlbWHl; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux7V3euvxEzC9TbWVHZ+oxzMeee07tBdGPvVpQxPFw8i0twBOeWt3KTXZYWBhEgbfV1Fukg291Obzps/fD5cI5vwILHAHVKfEYb/2hdiUCmaeLyWAzojRgbJdWAUaDKwrWCVuCC55eywvtr9s8eMXTsCni05PZfqTzuScRtl/NMbt4sbUHn6deLgLNVFShgppIGn0/8NiuZ0M3KWhtu6n8BTt0sz7dMeEsGGRINFJQsoGfavlik/jjjDpb8WIkZ16K06UkSk401+zhPFh091Mte5zNKgCtv1kV1eEc+wzXoHItD4sxYlKF2Nezv4eFxuCiNtJ3worTbRdg50sTumLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPWLO6xvH3wfY+u76IwmIDYy6E+Rvu7q9zkbVRNQA7I=;
 b=JkVjDvRImPv+KmBqfCTuSGGjUH4jECan7B/zFl+ZCX1cvWM70loXM06IgxWaP4i2H7ck3sv6+cJBf1mQsjD8cmdQDXrcE08gOHU2XhSWmFGT/ChkLun8tP1R82lcOyFZqV9JbsKdk6ODV792tuUfvsJpOVMw/pwYSIm7N+WxvuzD9QIo+p3phQJJq6Cc0WwbFR+/8k/6IIyjpoJiBEKXCzYR3y2hruAsYBUO0xDkiQSLsi1n7Knz1tVI+i21jDvWRzynKDd0Kpsati0n8TnqEyInqiunTwlNgN7eOMQoXMITa44GnqAEed15T8k1Y5KFoddNA084HtMRI+03m2hBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPWLO6xvH3wfY+u76IwmIDYy6E+Rvu7q9zkbVRNQA7I=;
 b=i5RlbWHlzLQUL3DrXGhTZjLL6KkkXRUWKtxqqHhn4K0rr0+kHSNTjfMPYuAl/hTVnBcD8dxKC5+NIvoS4R8wZy27mIpyIzu/PBqhKq492DzkPNvs/Iy3GHqJkfK/U5VsbKqwrhA2jGGfBLZGAyENLxCAp1q4ygA+zIXCCRAe+hBpJ0ISySUORoXIalv7RVmwffY4l/KevAkWCw3OJ2BHpx9gPZP4n+HoPM82QCrwbI9WHMfyor1X52FrM2WsG8NaQnOkIPWKe3RbQRxj9XsDswCpTA6G3iLoq7Lk5Fr271BimZNYg1dR5ilGXRzV/cxtGw4WD7nRtKFwbnSN0QswMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 16:53:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 16:53:35 +0000
Date: Fri, 3 Oct 2025 18:53:27 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: Re: [PATCH] sched: cgroup: Move task_can_attach() to cpuset.c
Message-ID: <aN__h87LFTCG3jBp@gpd4>
References: <20251003121421.0cf4372d@gandalf.local.home>
 <aN_7iDbWQq3HXvd3@gpd4>
 <20251003124300.4698dd18@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003124300.4698dd18@gandalf.local.home>
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0bacb5-d031-4593-d323-08de029d648d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OtGuVLE39fqRNYGQaXALcWNSzP1RrFDiCEZLs0nIvshxUUh6AL1N/D4Nmxug?=
 =?us-ascii?Q?2qR4DdodvkaH+dRJ+jEVGznBMbbUqWY+H71hidTmi2tklqhs/+4GlODadp68?=
 =?us-ascii?Q?VZcsRVDXJZs3pfqAeRQxhWgbniLgk4BA6wtHW4bgP8l7l4JRnvy3rgNsajyK?=
 =?us-ascii?Q?k+3ezX5zJVm0y17CBgl7MPz30LplQxGdpd1D1ZW87f+b8tGIa7nZTToz5Bp7?=
 =?us-ascii?Q?KuOqwuuZKowWOvOatPMo+dwWxVb/yXlQHp0HhUh715Emb5eOLSlYIwQGCeDP?=
 =?us-ascii?Q?0xh5/IYf6YM0asBW6XfA+OgLdPsbkzeu2Tvq4Rd7gGONXnjuSyC5LFyeuF09?=
 =?us-ascii?Q?bEtHpd1IiWIVrFUHwt2mAWXtwWhsSaBIIj6VCRXqN1+qXpfH0EA6BYpzytYW?=
 =?us-ascii?Q?oYCl/AxdcziPwxINXbKRaRLdQid6TMEFki/DZYcl5DSqgNushqp7uQS3zqZc?=
 =?us-ascii?Q?qoe0dOaqO1EAONM5AU8QWdqna/CH6o4XAqFn+vpahy3e+Q0pJ54u8s0C4ewk?=
 =?us-ascii?Q?6FUpksKasb7ptE1/0YV7eY3TaZbeSDApSuignNAC81TCpzzyfTF9GuLEd1FD?=
 =?us-ascii?Q?1BXB2h+3i80AWIRkPQiS8IrVlc5v5u28WYW2krB3ri6ufO25pQJ3fpTTgkC5?=
 =?us-ascii?Q?8GBMnO8OqJmP177MZeetyWUHFFJT6a2SMjtsgoByq9JNQXihElMnMTi/aitH?=
 =?us-ascii?Q?uy2jcDTUZuuW3cDRKZr5FHLoKXbfDGE5lvPXjSrTl1z/Fih5FgVdzhW1aG+N?=
 =?us-ascii?Q?3VKLs+ZUPXHovQ6OzDhZWNRVYlOZGhYNuuw7uqUdMRMKeefJKNwjRavriXHX?=
 =?us-ascii?Q?irPojTzagU6cpXAqBL4Oq6X45mYgSKUyqzMcnhVMuIAibKhkmmnRU6KrVi4n?=
 =?us-ascii?Q?w5ye4Yv2zaOHfKX7nY2JbeR+akpFdtJzfiK5VBc+QYwc5gLnLT6pm1rcYhLr?=
 =?us-ascii?Q?qH4M2HTAIHvDanM2P3i0b7f+qJPOyfz7vJYbXWsDeMXDU0gbu4TCWM5c2opp?=
 =?us-ascii?Q?EMWQ/2t7wFzEzA1gQT6WGwGMQAYP0A+6CkIhtNNqYX/CtsWl45ArJojNEmXQ?=
 =?us-ascii?Q?1jaNpp32gF8JLaQo5FUbjlmttOBSkNQcdX3kYEvb6QyyuTN9G4ChMVrWvr0g?=
 =?us-ascii?Q?iXACCS+dmA0IjBZp5LnNxGkTzZsdrpkHvlrsPK57CYjoB24tMkBkX6OM00R2?=
 =?us-ascii?Q?ItSScAH1ULO/Oq8woWM5YMUBzUkxzXYyDSYC+vEvaXQPI3SGOBzUtokO9M7V?=
 =?us-ascii?Q?kOxAhEj0k8PtVKIBvOZjh6ZjvF9lieJFbhtOIRWiZQuWSv10BPdkfmGJEHzb?=
 =?us-ascii?Q?PIAcjpEVH5nn8AzXv82wo+JlSiLpyKTYJ2ca53K7cVtn/KL/YySGcTVd5x9a?=
 =?us-ascii?Q?jI2+RMfxYVfpHgBqhA+iCuSPVexPCAfJq+sgOKFWUja9JfT8HemGk+vpSGox?=
 =?us-ascii?Q?MIIHRCKyOlOq3XrJFbzgVJ5X5fDHT0/u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8QWQ4ulHQdt5ej0hpuQIMXBs1W5Uumo/oGQ0XFCcVHXGfo0Ky3Ha24xppXcm?=
 =?us-ascii?Q?g9KGIehrzP12rcVHMhfTXlZTBX67eLL3Z4GQwouOqVufiZgx3mMNgRZxd9Lt?=
 =?us-ascii?Q?yHyIxw7wzPK5wsw+JRE2bOH0UKNLA5Bw465kKeuf/BDLMvDXIi7co8xFh1N9?=
 =?us-ascii?Q?n12JSUFbJBGZCNTNe64iaWSJmwRWtcVjiOnFkd8ncCa7WH/kCPQI4jQqVw41?=
 =?us-ascii?Q?JaFHjw89QOoR4P/r5JyqTVkMLC9ZjXS1uulp5NoQOw5C2b1iqSdEJefmqvbX?=
 =?us-ascii?Q?Gpr587RKfpIy0S3r2srOy+UcLhcBamm9xv+EHPlrBHQAEtZXLCrEC5muiXI9?=
 =?us-ascii?Q?+GDF6SGc8MJh47K3yWTcaklPnohxeHxWWsgoFOM7QYMN30rUNYbXCnOguikN?=
 =?us-ascii?Q?t5LuMswVmae4d/OCfJK+VTip62Zk+jnlVuBkwl+3sL9Z8XqkKRFsqVOSjQwm?=
 =?us-ascii?Q?uLg7ho/q2FIML/hE4T9iLmrzFU5xgIABZ5kBEIU7UWrl8jkzAF7Qch3ecVaA?=
 =?us-ascii?Q?n9YVBPTkU70VhtFv36xa1+wcNd89dNwwCulxUvuGnChNfIVHvyuywKItr1MF?=
 =?us-ascii?Q?05d/DHZFylrl1ZM4GqNnP3gVFKRX49ITXLWmy7Fz/iHmv8h23hRllEHuIBeF?=
 =?us-ascii?Q?4jHE/V0o61tfpW0QTtke3NS/6UpxidyaKml5sbSfT+yGSwo9cCnfKQnvfddP?=
 =?us-ascii?Q?gpj0++SFt62QVr2Z6pjlpRv85uKSoDnCp/5aObC61XEC36hsZ8+Gyykcts6F?=
 =?us-ascii?Q?aJqVlJN2G/tf2CKfQB8cWv19ta/67r9ewTDET1xeZ7dtIbRa7d07DuHgPm2Y?=
 =?us-ascii?Q?X6xEdrR3Y04WM2F4N2RBRY2Ar80PgnrJV+LFePrO6QZ56B/v/14HgbUDYc/j?=
 =?us-ascii?Q?0BWTrnv97c1z/jAntjA+aUBHNWbec3mwnlZcFlIX2fTCwRWyMyyKcYpFb1oP?=
 =?us-ascii?Q?hKNGBr7cXcwxG/5U+O5PW8znnjoc8jWQuJy4OdvBZ7+SfeIycrhjIPHQ06nI?=
 =?us-ascii?Q?vcC1iOvPplqvF5CA4F97ur9I/p/U+V2mq6GzcLcEjU9OrFYjFBukdWn2WFZX?=
 =?us-ascii?Q?jDOe4AErRU7H1qHLQyVdxIGQuPFRorH3MbOkXccd9GhrOnNDAdJ2r2r1c5HV?=
 =?us-ascii?Q?uXVvrhKgK4/+iNji8/GeCRZ1duTqR8LXsuLuT1niMAyUpEmBxd5I2GBVrJYB?=
 =?us-ascii?Q?zM7+itXMmgfS2pOniKbIks9tZG4fGbA7/V8+rd76tf9hYc10/kkyJx0yhJ8z?=
 =?us-ascii?Q?+tuK7X7uMuMmcJaeUA/eFfq2d4GdiLMNTR+zvoUS5Y66IDXew8JERbBl0Moi?=
 =?us-ascii?Q?Oedhfc1A3jpYTa4rY97JIMLfJY8FOtI2Lf0qn9ZlhPhPwJT6JK7RhgGTqHef?=
 =?us-ascii?Q?zMAUEW8JT8vkCRL1yInl8lVXcHd2COee+qU7ZW8lTm0NpNXydQppfQ4JbUEd?=
 =?us-ascii?Q?tqsC/l0XYKhE5yvDWLwTJz9H9o7Ot6Z+b+bwXXSl32TaZ9BGWya3vks90oSQ?=
 =?us-ascii?Q?yIbY9vDTSIH8Boilyo5dW0OR32uj+tZKxzYxhRr+wjiIr1SA0uuJfnZFA8Fs?=
 =?us-ascii?Q?Tu9gXCtWIHy9YkoS93/I8aPTSSspqVbWEYL9cKc3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0bacb5-d031-4593-d323-08de029d648d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 16:53:35.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9rkk1zjwC4jTyIMRdANJb+SCFOeUJcYdmLhQQGf7F++rAehQrCDowWIDlhhPdIUHa6lrNtpaETIzD1GF0+b1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

On Fri, Oct 03, 2025 at 12:43:00PM -0400, Steven Rostedt wrote:
...
> > > +static inline int task_can_attach(struct task_struct *p)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	/*
> > > +	 * Kthreads which disallow setaffinity shouldn't be moved
> > > +	 * to a new cpuset; we don't want to change their CPU
> > > +	 * affinity and isolating such threads by their set of
> > > +	 * allowed nodes is unnecessary.  Thus, cpusets are not
> > > +	 * applicable for such threads.  This prevents checking for
> > > +	 * success of set_cpus_allowed_ptr() on all attached tasks
> > > +	 * before cpus_mask may be changed.
> > > +	 */
> > > +	if (p->flags & PF_NO_SETAFFINITY)
> > > +		ret = -EINVAL;
> > > +
> > > +	return ret;  
> > 
> > As we're cleaning up, we could just return -EINVAL and 0 directly and get
> > rid of that ret variable.
> 
> That should be a separate patch. Moves should really not do much else. I
> even wondered about making it a static inline too, but figured that wasn't
> touching the logic, and the function was going to become static anyway.

Oh yes, good point. In the meantime, FWIW:

Tested-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

