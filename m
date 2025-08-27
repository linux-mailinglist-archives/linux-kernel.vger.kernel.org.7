Return-Path: <linux-kernel+bounces-787554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28404B377BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D657C2B21
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B182741B0;
	Wed, 27 Aug 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBbjfZph"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D22741B6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261805; cv=fail; b=sHmxAQaY3c9Ehm62zGBbU3dFTxCZI4/xfiGTmAXkfBi9htFiLcGxqUg5wuj63+0B8wF9Y05ahPlRd/AOxSeHK3zrmrRdzjyF8ZCDCasu/53pRHW1ZYp8aPkCfAJJYMl72jlC2yUL9GA5DKAnpSgNWAdtGIud2uf2YsZfrWlmGBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261805; c=relaxed/simple;
	bh=+vYyD1QFRa2RSfOwMWJkmLiIJLhGdEVv9R9oV5dRHc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nu1oNc3DzAlfCqFR2EBBLZwD6asmKU8+DTtnbElN2afdypjcXIyJDu5xdri3LDJd7MtT/6RYZtlxrdyQ+je2n0RLwpT8jpPYKibZCv1RYjtfHgwFM3+BiW+wTmWJq8vsBdiRBzaGPDejGiL/x0OYP7E7Dwjrjxypy186dEZLBbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBbjfZph; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQJcmst7E/wRvGqxB+Hf2VG5wkUF/T7WkmnA+nWxnUIKHZKIMcBXFZOra9LlmMWBxemKWuzR4pgmElYPa77/+mfENzjd4Vb69y5DRkcLC2QbMcrUW+zdf2zxY18gBMiur62DZEJZfQcW9FseyDO8yBntdnm6pMJZ4OoT0nUyG7JLgweFc4eyLTY6FjW+Ghj7lHU+Tf6Cd4XJmoZLv5hOD7Ule3sjynOkoiHOjUjKwetR6EZUO3M1EePiz0NtntqbwDDW1ryYL+q5VtafjKVDhmw1tbMRJEayDnVdd+adMuhuEcqLtyQ0nU6x7RGzx15z+FEVhGFtC6iNBzMr0/frig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dexFsQOTqqUQWqFEyfblKK2Vd7BeIy3rknbSAUEGT70=;
 b=lQMzr9V7D+yHdZo4Y62/rFXMRP87ICX66IalcvMCEOnpCGg79f7u8KJwnAn97S4dwTdXC/3MKjow6/CMglngt1pz8hISAt17FcjbQnaGAPHIU01d37CXfre6inoctSylUcPz1/O0U4FxzpRA6CItf6mGy2PD7A7IkhBqeiS4feJbii1DMGkgZu4G7mMxZmPh5V/V3pbY3DzJkSKREfspTt9od2hmSmg6WOzikRvjTPvJxmz5Gsu2WqLJB3pYMFfLc0gvloQmINtQVCLE4mc53XjjZESZp0YmchneDaasZLxpx+6JV5ogB99w9uYFP3LXN8LMtcjghcORSV4hpDiIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dexFsQOTqqUQWqFEyfblKK2Vd7BeIy3rknbSAUEGT70=;
 b=nBbjfZphFrzrAiGKzKP0bPW8nzYhv5OTY3HJJyAqoFT6dzL3joO89ykURc2288OhlP1CoEM0zXUuxlAwX2kn/0XslH7XR48E7vumUbH1e5K6nV8MTXhWmNgvwMJIECwty65LnWGeDMz8mLM9zvk9fAVbnO/AstlbdbUnBXVAKMx8awHcww6gHleEHvvizcOvonWySvuT2VnvgH8TNQz/D3TLoK0yLwFM1T4VRkXXdCHGsiLz4LyXyiYXz6Cc9usoqoXWRM3hCtjAV10w7ZIEKrEFdYbh1Aw/A2Dg3uMQUUHCtiDxdfkef6xP7upwMvJwiwV4xjtFZEMqqGx0uNB+TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Wed, 27 Aug 2025 02:30:01 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 02:30:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Jackman <jackmanb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Harmonize should_compact_retry() type
Date: Tue, 26 Aug 2025 22:29:57 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <758DA9C6-D4FD-4985-B6C2-B68CF9F4622F@nvidia.com>
In-Reply-To: <20250826191320.d5aa551eb5abef316de41175@linux-foundation.org>
References: <20250826-cleanup-should_compact_retry-v1-1-d2ca89727fcf@google.com>
 <20250826191320.d5aa551eb5abef316de41175@linux-foundation.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:408:e6::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0b9f23-5b0a-4ad1-cb9e-08dde5119ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0paC7gZEEVr5bh7/0Y8kN1gY2lnKEGipKqkjps4zOisdR8fLerUIxXeZvim?=
 =?us-ascii?Q?bIG4wfZMPh1F018BKKzLakTevA34BRCsRJ3N1ob0/cVXfLGihFgLaSg416GZ?=
 =?us-ascii?Q?bZ/Prai8/pV0iqB0D6QDggnfB1OtDuri/QLDNZXZMr95SFqaQDrA49bRPvLC?=
 =?us-ascii?Q?JXP37JGuoTU7SqyoEd8oruf/C7loGO94h1/qSa2asAc7+Zmk2s8sGLP/0oNI?=
 =?us-ascii?Q?MLyPPgFig8XgctfvocPxceS+o+uv+ldv4N8Xx7t+vHtZf4v+hzjpV6wvu6s/?=
 =?us-ascii?Q?03U39q9uaODYL30Jf4DUxvRUM1cxVT/+h+FRHOfSOIh0jXWTXreu8nPbUyMb?=
 =?us-ascii?Q?jkGYR/Y0wLj1U0JmpCARA3pS+MNtd8prBSclMFqXUeD/8REhW/KRZy4fnk6V?=
 =?us-ascii?Q?J2naxcIlz4eJm1mLnweUrL0wTzh3za5QYRkZfHfcB29yUPa6reOO8GVeURLQ?=
 =?us-ascii?Q?S/scZKaD0hvoQmrX+kUA1aG8zfvvd0bBY0V7LUReRqm+AxqlBXcN+V2Q5HBm?=
 =?us-ascii?Q?dEeLHGZSghsij2ngkNcLS5X5I7YkWpGQKobjoaAcc9PvZwuTDkyVnUJTUJ8C?=
 =?us-ascii?Q?x1QmtMxhStCIg47jL8RV0AUQkKGew1/+l7ML2RJx0G7lw03Ee9qh8qOSAoqy?=
 =?us-ascii?Q?fi1q/CegDXn6c8sGefAdonC7XXkhPKEL8r/iCz94Ql5Vy0n9naoj9ggbiPE1?=
 =?us-ascii?Q?NZe4GSIzBXB3UqlhHslq/hff0uFLbXL4TaDucgXa3s0CNTCxFsg84L1luH8f?=
 =?us-ascii?Q?5qL2D6UoPXZeoATfc0Ii/Oy/wil9UMJlMxhFkPtjoGUl2LnnzJ7QYiBi1eZR?=
 =?us-ascii?Q?14+fa+z2Iedda8txPnNlBlZRhJ9izA/H+9RF1Q25xjxYog0Xb0NobNtV8P+3?=
 =?us-ascii?Q?ArA4JI2atGj0NQ0KGNJFI+m1Wk0utgs1iJcxtulnz7cFuI0O2YD2xO4HeJwB?=
 =?us-ascii?Q?Uk3beKnJ2ExXkYktAGeo0v7Il4lWv57c9y0NWUEMkP343roxzS+M2sXhF19t?=
 =?us-ascii?Q?zpvvm6gNfzifCSVHZYf92usKyFxwcQ2p2Ylvm/q8Q9wjvpUs5HrbYuRiK00r?=
 =?us-ascii?Q?DZrANaVSR2VuvmFV+K2+hdHcEusmRVQVxRHvMdIGaJstw+Bmo03Xn/j1XpTv?=
 =?us-ascii?Q?JtgcIBY3JCl4Mt8m8xBEB7zJZUcpXMKeEQLY2Ss33r3KzRMOuxM2qNi1Eb+z?=
 =?us-ascii?Q?yDK6fiyD8RcbUpH8skwT1O+STGvsEl6CaS4Kj/yoFIcRXWRkU/F8EPUG54oh?=
 =?us-ascii?Q?L1Dtc7P0T6ofUD8JqHbPZAlygIlqhbnGdC8I0TJm3QFMSEbVn20SWIXQhDlo?=
 =?us-ascii?Q?2ToLyqLLpfx62B1zueNidBQEJKzqe/QHOxMHqI65MShKcQhAJLU9CA3S3pjK?=
 =?us-ascii?Q?asLBbf3qs5uSX08//+JjtDdgGMaPgJhplL9A1LiioC/nNW042u2+cPV9Zw8H?=
 =?us-ascii?Q?e9JrCYVcg7M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hR+fmPirHNcXI4alrcWlyxuoOekEd0wr9PZwkHqIDlN/sNg4N42GGWm6iYTt?=
 =?us-ascii?Q?xdH4SPFTgd4OdsjdzL8s8vC95+ONVcTB8jUDOa7wfcGl0Qzn0nsr1djtV2Rf?=
 =?us-ascii?Q?ABWdhv1J1HCm5NWgZ1+aeFYRYOyJGuxcoSAW0KJQoQeAa51yixyAYVKauvfQ?=
 =?us-ascii?Q?ghAmZM5rILEDXnHG9BgpLq5LSWug1l6TivPzC7/4pDyxj2xpQsli0hV1KX08?=
 =?us-ascii?Q?5G8fQ7m/oAiTsNuvy4rtpibQG2UnuZW8EW5K4XjkCt2esaVXxuAZ7jAkx0Uv?=
 =?us-ascii?Q?JLB7hQt68/kzHIZq3IIHqje8f6XY/fKqPWMw3ClHwh4gQDoz26MDrbMemQys?=
 =?us-ascii?Q?FOCVCA+iQv6ippLkPj5+JxHI3MwC0LAslC4dAXxRGS9wwoOgtBoTksJbKE7V?=
 =?us-ascii?Q?oWY+vM/azxO+ji5IOsB2RImNfH70mV7z3x5KnN3uzcd6LjnG4KmaW8aUzn3T?=
 =?us-ascii?Q?R6bbMsejj1BrhwVtyamEpxT4i3kxbObXvV2/ezmW4jnnK2FynS7fLGS7iG9z?=
 =?us-ascii?Q?ufKpLnIbbwIBr742qw3MR6UqudDMq3KI94SbTde1TrCJc+7q0IOnzUViJhy8?=
 =?us-ascii?Q?dXregx2aUbj2fXxzamB2AVqQV6AzD39fzKVao9o/JPJAKTV9CK40nKqBogPo?=
 =?us-ascii?Q?fdM7uX3uXEqB+KRBvOhe6zClk+kauNNDU/jt6Eglokt0kifeSASynePW/Aj/?=
 =?us-ascii?Q?yf2CtPATTsCYdn3kdFOf4XJB4xMZi9pcxoAN8zZfbIXGTYWe9FO7Ppw7+X/X?=
 =?us-ascii?Q?0/hSym2WsHJ3S0ZdVFkWJoQIqvDug87vPEFyKdvzX0OBm3CacBql7xJZ2UpL?=
 =?us-ascii?Q?9lhzVZYqxpHVSpEw7pTw20zb62MWeaUV/2KQ6LwSvkbnK5pRKIxkx/iTPxpU?=
 =?us-ascii?Q?hjxYWxJG3Gxi7IiLSxSlxhwN/Fs5mX4MX9d9O7wUCaTvjwKPpguNe5WizRhb?=
 =?us-ascii?Q?LuEl066ppadYUQbFfIOMEXO1Hiuzr6ZQlvnuR/PyBkWt7v80jKN0Al9zNMxw?=
 =?us-ascii?Q?RunJryYhf5zy8x+wk4io+9UaQEiPgoPDB+LbZ9dUzwzqUruq7vywNNm+Prus?=
 =?us-ascii?Q?eE2glp6BrlRV/wrtz6cPN3vRLHbOqAElknPb+iA5+v5fBkyBB5reLvF+uLbi?=
 =?us-ascii?Q?I14GN5lYrh8HegMr6pVCXNby6J7gzceUYfRm+s2YawLVG7lUxzQt5oSvqEMD?=
 =?us-ascii?Q?ziw66/sEzNu0DhSgSL9Sdh9RjF0aoovRxT/bRFwO1ZVvRQpuRlQTtFVAHh8a?=
 =?us-ascii?Q?H38H+HGXHPe3MKkzWvty48fLPi9th7QcIBy6MuQHjYj4zHLEwkWS5HNPKpzc?=
 =?us-ascii?Q?TBRyJpxeYXj7+vdoto5t7lMcfaXhNY7ayQp1Thj0Ow6Ca0IRnkQeafaGK03H?=
 =?us-ascii?Q?hrlsc9ig7/viuq9kVWsGk/BhOOlcoEV1G3j4u/U6Iw0CVmB/U+pyJi9OMg3b?=
 =?us-ascii?Q?o35TVfBQ5LSBduWN4nUxANbpEWnPf5KAlLBkxpBsdb80MK5HdPN2GOmDCIAU?=
 =?us-ascii?Q?SBNdVq/eqd/Z4RLqQVCDml4uWcIUr38PYjdsGn3GUsmglplFmJd9WZT9d7x7?=
 =?us-ascii?Q?kXmXzmGeZ3kTkeO+Z/ooLJswJka+2HY97WztzdaJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0b9f23-5b0a-4ad1-cb9e-08dde5119ed6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 02:30:01.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OvuS1Q90RqkIWpAUOfMKuYcKovkfR7X6Tb+7t5o5qOanrqWT321FfQwbj3oohgN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

On 26 Aug 2025, at 22:13, Andrew Morton wrote:

> On Tue, 26 Aug 2025 14:06:54 +0000 Brendan Jackman <jackmanb@google.com=
> wrote:
>
>> Currently order is signed in one version of the function and unsigned =
in
>> the other. Tidy that up.
>>
>> In page_alloc.c, order is unsigned in the vast majority of cases. But,=

>> there is a cluster of exceptions in compaction-related code (probably
>> stemming from the fact that compact_control.order is signed). So, pref=
er
>> local consistency and make this one signed too.
>>
>
> grumble, pet peeve.  Negative orders make no sense.  Can we make
> cc->order unsigned in order (heh) to make everything nice?

Unless we do not do order--, where order can go negative. See next_search=
_order()
in mm/compaction.c as an example.

>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4182,7 +4182,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, uns=
igned int order,
>>  }
>>
>>  static inline bool
>> -should_compact_retry(struct alloc_context *ac, unsigned int order, in=
t alloc_flags,
>> +should_compact_retry(struct alloc_context *ac, int order, int alloc_f=
lags,
>>  		     enum compact_result compact_result,
>>  		     enum compact_priority *compact_priority,
>>  		     int *compaction_retries)
>>


--
Best Regards,
Yan, Zi

