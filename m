Return-Path: <linux-kernel+bounces-584049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F008FA782A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 21:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B226A7A4D4A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8620F07E;
	Tue,  1 Apr 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UHkztP7h"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCE1E51E7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743534901; cv=fail; b=OLyJ1ZgJyI3WlyoJB6RNSGZ2os6OZoxJt4M+ViP/Aq+8wt4Q87SqtRjDLIFh7DBOxP9uINAGjPVJnXF0A0gnBBEDuMajw68DcFA5fzfT4HaXs0QYE5CEq+SnRpWPAK0MfZlzLAM/D/GdekMW/Ca8dd/7p/vbj0fXjQ+JO2t7vag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743534901; c=relaxed/simple;
	bh=+Mu4MZ113fUqT1ZAeJngM9q1AlnpNVRcOApXlELIbbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PnDpmhjc8r+6zxNICOjNH93OM2jXTAbLkoRDji3vRli6JMS5yb2wGJQ0YJcyq19kwFdHWk35nHZr630DMu5U7XMkH8mXpcn32HuGx32dLxUrKkDqVo1/4ixNk6U77d2xctzSIRVdI/rVYTMeqssGRsagB91mYxPOx4ZPMEwvV7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UHkztP7h; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYy461qI+oK+VI7EPigjSevEL0N59jlQzXYg96RT4ev5Pq4EhFATIVrv99oMzzjmaduGZk/KeLUCs9Vzi30AEuFJkWLyqLvvo/p9moO1OEoaFB6ewCezlC/4YzxM0RLZ1gEGkI0Acrlz+Yc4TuaeMmfqQ68mEgZeK2GUFukzvTLcYj4b5NwlGVY1Pz9yS4GleofjvD7uHB9ZBRG+j8dw0QhEHXmJqHUxY7t+lPIEZMHDlud6Ut5nDbm/zS4t79WFYyZyp4ubzBi1jigALEpxSabOxr2e5xb84ZolGj3H8IUT+GCp2cqibp8d/oJPO7hxW7DhnYpdWmQqUFXpcOZiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Mu4MZ113fUqT1ZAeJngM9q1AlnpNVRcOApXlELIbbY=;
 b=hu3L0Cg9B0C8UprZP+3Lozju7+xEaSfiLUxM4dot0DxOsJrSt42+m73skAmgRXCPmSRK1w8Cv/Khg+gWRxEE4YyyUQatiHD5Lcy4gfA/oJLcvPMfXEOBiQ311ZMPpsBaxcOOPBSpvF0fsLDXaE+K8WOXqli4mXtDjjn7LiI2CbApXkNuUbiuakPw1NUfJjDx8cYDjp8n89cWaQtweCBKeLWwq+9c9G4a7y1xR4YQo14DDGgjiK/lc0z9zRad5ZoSLrChkB5M46sTsUAllw2/m6C0vqhZ3RNZ3qgxAabllDP+ulXpdvkKVIdLiE3wNy8TTvGJF5qqYK9TiTOrzL+89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Mu4MZ113fUqT1ZAeJngM9q1AlnpNVRcOApXlELIbbY=;
 b=UHkztP7hBFPcMHlC14N3oJI7opwzQF5yEDILw19hbHttUBtO+p3Q9oNW6ENHGWFhFMFeMcOFm4AS1c6Mx5Kr7pDWNxNE178Bcj+Dzgm4z1y8jzfcCIsKo/zof2s+PK3ysqaQUoi6ctzUuGjAOIvbZhpDUKTRB9m+jo6AnOyfJkYq3cSM4aXugaLrxKcx6AqjGlSLl7V/ESKIvpEsvkc1kZ2t+qYE6a5UZrfBU+B3rOrTGCkabZx/CmXBjUkXVxhSvqXvBnVpzfh6xbuiLVZKlvkJHp6JbiWU51RlWzOxYho1ZSsXMo2lkL/bTgHVwgrnWzA7FQZKdk4E1DZrs/asXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 19:14:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 19:14:56 +0000
Date: Tue, 1 Apr 2025 16:14:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Dave Airlie <airlied@gmail.com>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm for 6.15-rc1
Message-ID: <20250401191455.GC325917@nvidia.com>
References: <CAPM=9tyx=edsZ3ajuAUAv4vjfa=WNEzobqAsYbBTjCfLbuEeFQ@mail.gmail.com>
 <CAHk-=wjcdfrDTjzm6J6T-3fxtVyBG7a_0BXc2=mgOuM6KPFnCg@mail.gmail.com>
 <87h6394i87.fsf@intel.com>
 <Z-p2ii-N2-dd_HJ6@phenom.ffwll.local>
 <20250331133137.GA263675@nvidia.com>
 <87tt782htn.fsf@intel.com>
 <CAHk-=wiP0ea7xq2P3ryYs6xGWoqTw1E4jha67ZbJkaFrjqUdkQ@mail.gmail.com>
 <CAK7LNAQThGkgtKgquRPv8Ysi_omedRthF1_++apKda-xWeWcbA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQThGkgtKgquRPv8Ysi_omedRthF1_++apKda-xWeWcbA@mail.gmail.com>
X-ClientProxiedBy: BL1P221CA0044.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f76c647-11b9-42a0-3832-08dd71517d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YqesK2fT3ypr9hQVnnSzIR8nQOz/77trtsyoR3uUlrrzNZ3j0t5ylfiCxXXj?=
 =?us-ascii?Q?kemVQiUNDxjpTGMrNq8lIHLLhy2OxPQwauQ8+ZBAAou8oXR3LFOJxTjjSrIO?=
 =?us-ascii?Q?s5guSsMAg4XqS9cx7m2aIjhZagU/M/Q0Bqa3VMeHfFcahU4SBd8DLEj24HxN?=
 =?us-ascii?Q?WIzSSST6VnDec1SuHg9ttioc32ACM/4I7fKwrThDlJTfpskCwwqWcnBCoeV+?=
 =?us-ascii?Q?5YXWruPvHVMV1pyBQYv9HMPnbA/KfghQ+Sb0PHwuskn1zO6nwqHL2MtxXoVk?=
 =?us-ascii?Q?xrR3R6KuuyQ4iVYvIFbAk7LDdetHRqnGHvSv0sC39tmGK9n+1fyzDGB+Kl3l?=
 =?us-ascii?Q?zhqKhxPfQu/gd8DN42wb63fDjqtkJhY9uIfRW9u2rfAOmq3GGFkbDUu2NJFX?=
 =?us-ascii?Q?MhxH06i+KBiknTvu9hgOAfLqhrssOgpj+0CkFUbwYfxLr3vTtGY/U+VSlIXN?=
 =?us-ascii?Q?UHNYWhR4wGGgDZ9R57QBFj+sQ/1FjVG/JNx1qwGvtqhzJ3WtQ4X3b4PqYTS1?=
 =?us-ascii?Q?a5GsFEQFMMoegY1bhTH79O7Mfjy0dVwMcewmkY0z7jpqOSUm6g7f25bpqSK/?=
 =?us-ascii?Q?hWL2nDPEVpR2WjPcGfQXYxo0unCsZkiOBbR6/nVMe++JyveXkCTbnUagdBUQ?=
 =?us-ascii?Q?rf7we2juJ1yHgNYVMNXmKk61hEOKQNL7o9P4++lW2/6qFyqBGIDeCd2ukQ3T?=
 =?us-ascii?Q?/BErCv7ge2e/qQljH3lHbiaNNnWqBCe3gbcA2j92QhMUzIg2igXGsIahxosg?=
 =?us-ascii?Q?ti05XAwuMzxYti7ljLKL9rpwJ1yeajeazGq7Q0uwqCfthwUSQIdY3hqNAgvS?=
 =?us-ascii?Q?4e3Z1D8bYJ52+PgP+Pwqm4NlDor3eEthByxwX/0RXb5aLRxh/5M5vTErvw9n?=
 =?us-ascii?Q?XIEowtZkZzDkLLHjA9voTXmKFN/REtNHH/BCdVP/BMtHa1JeMLeQA/dSU9HR?=
 =?us-ascii?Q?ZSS7fOUKigtCsJSTWb6G8oai+QHecykrWELS4SUszRmHPfaigj3miUTW03dw?=
 =?us-ascii?Q?AQRs59H2by3qE4dQoZHxygUOXaD3i6zV0Q4IGc/9j3NVABtrTJ7kcyyQLloq?=
 =?us-ascii?Q?GODK/gvmX5Z7YdRPUrO4NvwM3nIN0A30hBqkyKUxAl0t/T0pcVQn0J9QL8pJ?=
 =?us-ascii?Q?Sg6ZXfDDJ8ZNOlM6Jr3zCnje9ULiRo107VURmqd9J11T6BKL26IwxMnCdEOd?=
 =?us-ascii?Q?5rFohQ7nUC2FbsdVWfn3ts17GAw7Xu6Tn6jdmDCeXsSwZCfmG7XPPA3HskFe?=
 =?us-ascii?Q?5sJaNEkyJQTmJuxgjvDne5VHliaMI+J337A5jcKi77gqFCjv7Lms3x5x8N0J?=
 =?us-ascii?Q?OnFUabBEAFuFtAke62WOFSj9cyXCX7EI3VAsHAgJFhkJ4pFfVUD4ydftxNq0?=
 =?us-ascii?Q?WwH7lN/kWpz3Yo1v5C4tUyutCSYW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?alGRd6VM2LahTqjd+hK/04IKTN/QVZBHd1qeDw72zSebFb22NAp9V+6VIQmn?=
 =?us-ascii?Q?RHUwfHleq5N62ckiqjJDCD+mjRRMjZ4tjPezFcqYs9UAaSKMQRSsDFMjQuJl?=
 =?us-ascii?Q?HhmYeG+yu1147jJnLvUOb3K0iVAzns6A0K8m8uFqmBk5KZmWrhj3BAxMoesF?=
 =?us-ascii?Q?na2miWW7y/KHZq/4iEKMYU0MtAXvm6BVswyFpBM1O5qOSV3UHqUbK9P6DA+2?=
 =?us-ascii?Q?xiMxBoj9Z20Q1IpSjHb7RNLz2NFy3eVj8+BlkN5xjH+QNmXdh2qiuSKW830m?=
 =?us-ascii?Q?wbAIAEHSs4hqFuKv+hZIljat1PwhcuHj/tJ7KlePNvls9wx0CezAQSHKTIH/?=
 =?us-ascii?Q?c43KuVJ0uVU3xIOlBaDsKpQ0Dtm8LRvxAOSh7l2bwh4BVE8GrEIqibQHx9t5?=
 =?us-ascii?Q?u4HyI6/KMQImYEoDPJQMYw775oppwQV/6h70tCaBQKqu4812yjlsA/1A3pG2?=
 =?us-ascii?Q?X67T8XoQXAQIBAB/AwsKgn5eTwsxDDjCj+OK6Egrc3wyiby4/UI+H+hihqCG?=
 =?us-ascii?Q?bsUSIvnEDleAmroodDKCXT/V/Z4JJo18ZFVyj2AuJYXgZo8GW/y/rWMy7FM5?=
 =?us-ascii?Q?BYEQQqxZbG0Av0Jjw7Hg2sYS398aefyN4kEEk6auW5sKMZYm4ot2ztXPTjof?=
 =?us-ascii?Q?ta8xiiDaPjyap5YT0bX9B73eHLr/6YFWfJ9DvlFx4j74XT3c7D3SsygmeNMH?=
 =?us-ascii?Q?Mi7ssZCihVvP7z3dDAby3DLzN3dpqxpA/Nl8SajM0ivfcna3BvNxxEWF3T1F?=
 =?us-ascii?Q?/CL/EKh3/JhQDI8Hrk5u8B0OW59q5Pzq0JSLdBWhhoUJ3Mm6uAIcptl01c4D?=
 =?us-ascii?Q?PD5N1pf6u7FTTxXtrAdB+K5nOHdIYd5MAXc9xtcZtBnx/RHLwIHjk4poOXCS?=
 =?us-ascii?Q?J9xcfKX1M3coOSJSgwSS+6p1um2QdGyTVdIErD7a4wSAEW7h5IQhZUjcujwE?=
 =?us-ascii?Q?UIfW5hj5tLYxMs6je0joaj9GDJ7L8dTzJwToE0QIIVBUwtiZdV+l8tGy8IoG?=
 =?us-ascii?Q?XNCcs2jz+7CK6jPBwJDxVPX+73JKz5xTF95TwVMJ28Gvisfae2htZU9ZaCZI?=
 =?us-ascii?Q?dHYMt1TKhAXrka/gcGQG8PWLuyNQv3lShk+526vsEjFqeMaL8//i2bj7pOAh?=
 =?us-ascii?Q?oTGizMezLgZvDGNQ8hYrHcS+md2FVnUamQ67eZFpDfGoQktIlPwcWN2iPjNx?=
 =?us-ascii?Q?Ivy+t5931s7Z9SqzI4uEfT/TWEDiFpYKFJTD/nAlzd2d7V/dci1/ahnV4vSi?=
 =?us-ascii?Q?1GrfkY9LcJkegmqv7DT5qnxQE8rJF/yGTcih+nK4+O0/1SCXmIlsPMswaALa?=
 =?us-ascii?Q?oP54JN+++1rbRSRLRM/TOoa/c+5V3aardQ2FPKB7+TRyunsGFU9NfkNUJTSJ?=
 =?us-ascii?Q?Llut4PgT+FHfLAezXB9NtmTyY+/tli85Y0i4uZvvqva5jGT77Rl2gHNHlLeZ?=
 =?us-ascii?Q?RIssdsDW7DHCRCl8fVKmd3pMGvjWiUe+GIviZpSuOoluKmlMPWP/Mfrh/6oL?=
 =?us-ascii?Q?2kMcqITqZNUeYoYeJLvpM/hmNzo4Wx7HzTVJAdvqgCYCBEh/xEYo8Y6p9QQp?=
 =?us-ascii?Q?Ht+rg3GWSIFEzhq/bNRFjDLYNEdlby/1guupGCE4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f76c647-11b9-42a0-3832-08dd71517d07
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 19:14:56.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2FKB8NV/UulanW7TFK7rTMVLc6MBiE/qLYKdmYzYf3kHjmEs2hPcZC5GGdM+Bhd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271

On Wed, Apr 02, 2025 at 03:46:34AM +0900, Masahiro Yamada wrote:
> However, it is annoying to make every header self-contained
> "just because we are checking this".

From my POV itis not "just because we are checking this", I have a
very deliberate reason for wanting headers to be self contained:

I want the clangd code indexer and editor integration to work fully.

When clangd is asked by the editor for a report on a header file it
cannot know the missing implicit includes and it's functionality is
degraded. It reports fake compilation errors, can't do all the
indexing functions, and is generally a bad experience. To be clear the
header is parsed and loaded into the database when some C file
included it, just the actual editing of the header doesn't work well.

This is a very big day-to-day negative for working on the code. I'm
frequently annoyed by headers that are pointlessly not self
contained. I'd really welcome someone doing a cleanup here.

I agree it should not be a hard rule. I was reading the thread you
linked to and I'm thinking the approach is not optimal.

The only header files that should be checked are ones that are
actually used as part of the build with the current kconfig. Christoph
is right that there are endless cases where headers should never be
parsed outside of specific kconfig settings.

So, I'd suggest a better way to run this is first build the kernel,
then mine the gcc -MD output (ie stored in the .XX.cmd files) to
generate a list of headers that are actually part of the build, then
only test those. That eliminates all the kconfig problems. Opt out any
special headers that really have a good reason not to be stand alone.

Jason

