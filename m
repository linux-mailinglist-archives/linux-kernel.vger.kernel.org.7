Return-Path: <linux-kernel+bounces-733536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F3B075EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCC63AB5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4FF2F5336;
	Wed, 16 Jul 2025 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AnCV00wE"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9E2F5314
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669633; cv=fail; b=HTtLCIUz9P6gr/dS43qYRuu237ResHQlBvmYb8v/Ykx4CUFb4fx2ty/jyxIfFqp02fgShZMqCHk59le3BARb2yyH2+c6sNJFbBuS0qlORwOPxDezpkKeUiSMWIg1C/NFgZOeld4sv/SZT1/lqPDfp16P5JAwJdYad9eT7zRTZ7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669633; c=relaxed/simple;
	bh=iaFH/NpCzVzxJvTM/choCuuACTzzTxnabnPZcHyjgZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zc1j0wZO0Uhvh6z0LEJJC4Sf8mivkw8CO40yca/DXL4ozeQxJFCVQ3YCfpqxpQNfEXHKbjiVib+JEgb1I0MnBc+4AnNw8H+c8GuRTtuMzcye+x1bhCXxE8bdKItCL65u2WDftZdrB6CTGgiHZlmW1/3EhQADdLirEaL4SBV7h7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AnCV00wE; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kd3ZNflBAZ/4wuyP9ix4FhlsAgqoLPWrQgqr0sLnuibPdnjTStQzCHZWWQ3xiEINDBMu9AUYSZFvKt6r4K65q3+rkO2DL2XQF1sNmkHx74QjZ7VF30onhgZ4P6mwS1O46tQ6JqpoMLoJKn3WEcMl4LevbxNRWsnhM/zUygwy2Rgi2f0uVJjxhtPaVgkw8Hy+pdLxBmNBmVZ3y9IJpzeDu3/9H16g/Y5xfwNl6JaHNMPVI/oXLthhvylXPBvpB62WRhOrcs+/eU4N52tGrTUP3oL1j4TqNJpH0Hfaci+Doxy5Bjf3MaVmNZRoWCNDdJ0K0iWp57tXIXyY2E8lS76KcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n+wYRxkPkn2/lo1KqYOv1Jjqoh5Uj68MvaULBKGgIk=;
 b=jjI4heNFgoLB3YQGNfkvn1B28lwv7dx8r+YrDM0C/VuhR/g8gRez8j0/NJOVPEuSNcKNoF3GaYQ0WyTEUbAw/CkEr5HnLyzFhJXTCrExzxNcwHUZgR3KRgWFo4fs71xWtv+/kBQpuKk/h8EKX1JOvzfyHa/6Dz6zIW1E5Xx+kYFrLjcnekXxy9qd+M5LGfmYKP2BeDVzA8h2gEXiK+tUYmGhdFkUYJAvasvjADO5XWMeSzFfmeQK0PhtBMycgg2TQQ4JhmuU4tzjn/MpL1Q+7ivalQ/UU6yEggs4Ia9F42sz7AJUWWTTkpN/zwIoTX24cqdUD8anBMywxdTUSNlmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n+wYRxkPkn2/lo1KqYOv1Jjqoh5Uj68MvaULBKGgIk=;
 b=AnCV00wEKrwvQULS36qUJbRan7kzbZNq6fTIjU/Z60O5rVUaWZh3mta7wLPz/PlhM1qOaTQ4N5guvQ+j2yxQdCsTIcixF/glajowHqMHeZ7Yv26YMEUAF0Fudaphs5Qk13ozCnQD+2WF+Mnih3v1Fv+8kA6dNljvV9WwxXsH4ypkmt4QGbqY0Z6o6/Q+5XTuC3ru7nLdPIIwedCT9+wZ2OzgBGWJI0+I9JF/W0uwDTJOTh1EIJNFWil0P52jWuFo4MkB550jGRhiuGmYw+OFXSm6WxsvfNajUZvU7uMkDnGC7Br6HDhyf1ygDm0QCSdew7frppMuZHjP2aqjIrKvqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 12:40:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 12:40:28 +0000
Date: Wed, 16 Jul 2025 14:40:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Track currently locked rq
Message-ID: <aHedrl4G5DecVzpS@gpd4>
References: <20250422082907.110167-1-arighi@nvidia.com>
 <20250422082907.110167-2-arighi@nvidia.com>
 <xy47uzzirvauag3otkqhhhzwyhlpnnmeh3s77i2snmtoub3jhl@ywoeaxl3iq3x>
 <aHaN3FqRG6gXNwbv@gpd4>
 <qxulb3ckm256bltfep45iac3vifv342o24654ulh4zt6shvg5j@grp7crx56rk3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qxulb3ckm256bltfep45iac3vifv342o24654ulh4zt6shvg5j@grp7crx56rk3>
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f6bd2e-b15e-4b7e-6565-08ddc465f1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WUaP86nHnoXfkgws0JTvn5RXIsgKpr9LKhhUGO2gkCDVEItawrJst11prJG1?=
 =?us-ascii?Q?vbdBybsL84vboCroXkyhF99QMxwDeOUpGt8Qc0uFyOTnmxnfoJfdbYNYnfSi?=
 =?us-ascii?Q?Sd8azGkFqbrf0kAUPWfvOHtKO2doEUCBX/L//gfjX/5GLaCvXjp4J5Mu7nhx?=
 =?us-ascii?Q?mcHyGrqgMaZScgUUZtVg38PsBCTDmW812z7J1ZmyAv7VdB7wYoQ6pmoB87PJ?=
 =?us-ascii?Q?SY0PYlfN0iF+c/VPlunIqRwl2u7DENh/SgX3LjprygKHpaygD2TdTcShHvk1?=
 =?us-ascii?Q?dll8BVjn2yBWhaZLx6U4qaxNpnux9tOK3i1gz+TaeG4IAxfEUh6QAVcukXBq?=
 =?us-ascii?Q?uhQWRi0FiUmKrLyMynFl8XrZQ4zSzoTO5o6zh3GrfdqNgeyr+HjwgaPSDool?=
 =?us-ascii?Q?XprsCiso/T3v7p4p9TYM4XJkfCOGuyYJGEIs4IhSNax/r5VuU9l/Yt4hXkTZ?=
 =?us-ascii?Q?BCsXxfTEZdKz+A6qHnshiSMqeAqD5xWuO65ajIuqw2cd8iOZwahI59YnudKD?=
 =?us-ascii?Q?yRCosxl4Mxdw/+2df2gObBFb9I8bNzAxg0D2Y/Lpvb3Q6eo85Ablp4WWuKN3?=
 =?us-ascii?Q?pz5Hzh2lXiiSwteSxLh3mXFKd32RgmTOWbo6ci2Ty6PBp5qvTUFKAgGo68N+?=
 =?us-ascii?Q?y5jMtrri0d94BMNaKeDcROk3K58XD1ZT7cgQ26FTDu6XmCf9hs6BpF6xPPyk?=
 =?us-ascii?Q?vkCp05hABBjHfAu0LU6kJQ24w8MIrHIRUWg+y8zxKLBVVIhU9My49JfquzFi?=
 =?us-ascii?Q?jGVzE8fD8qD5MU9NCTnpYWgpesrCIBNYEQFprzRIy8x6CW0Bln4F0ATKk34l?=
 =?us-ascii?Q?nUkul4d8Ee7drz5uRrder4Am/AWzafGA+Ipsi9FcTxiCNIORL+eSTGFKRiq5?=
 =?us-ascii?Q?lM7e+pzAJyVfKFeBcLTy+tTiZCjUgbWH0JyqOMAsGiLmI2IllECMSMIvTlxl?=
 =?us-ascii?Q?MPrm5gIORjY86td6MbSYU9RGoTGKgkk7NNcjjV2rn8EqxMrKDNBFxWhEWvyU?=
 =?us-ascii?Q?50OQSbKR0nG6lXcz5Fz5Q9FXyntGjWHqSKTeiL3eLZTRv9qw02GEC4Is2kVD?=
 =?us-ascii?Q?1Ur/dk8Iox4ZgbeoYrs8f7UObkZzAYczvUXohi2hKjeMqueYwvDPU2vOdabP?=
 =?us-ascii?Q?GsOSfkc1pmvK+sezWQ1S/QUUdBJQZahhFnLj+oIThxC0WxQGD/h0I9a7RIvQ?=
 =?us-ascii?Q?aIPwRcf3bYW+lY1UOssUbGPmtrS2vWdSyV1jHFjzRuoMgQXrZAmPn0rGURZt?=
 =?us-ascii?Q?qiepMKdzEwOc8uJRjKlhHUpTfIZp7O9mBlZM+JNaQwsAIwzKidHAag8CK/JA?=
 =?us-ascii?Q?voI291vN86U8x6BzUtnYsET6rM/xCBpXsGKZhw/nt26cqh6AI+xegMWWyoZY?=
 =?us-ascii?Q?fJ43kxCpxCRhlgL3ADl38Ql4lNFvK5kFzC+POjDNT5PYjM1AokXooWRiNFLq?=
 =?us-ascii?Q?gdvPOlDefw4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FQSlEhrC4IMV2JLsTAw2XlXyRmOy8ZAGu/fqf1W248DYgc4d46KOoxScCpFh?=
 =?us-ascii?Q?YgsBsyThIoqxr6uq9OuYeFBNtBZ24O0DdKQ//m5xEHicbrndzeMxuWjpYQRM?=
 =?us-ascii?Q?d0sC1Qg6nadpAWYgFF3pTK5txHATUYUhzDKcoBcq9N1yueIvz4/e6drKRsje?=
 =?us-ascii?Q?45CoMLwygGkehhabVgldvOsLRnY8xd/RS/uYxPcSrkD2I29xuhY+X+x8VWvn?=
 =?us-ascii?Q?7ShDx/DP6A82hU9P5XCtaTCciqb8bM3uNELAYLIjKOaRvXHJ4AQERFcYPsh5?=
 =?us-ascii?Q?LLhwdIL7zmppqFoajuYHTf7PypNliGgwhxjfOyQ+CxDEK1KdAy9Etv2ZBpgU?=
 =?us-ascii?Q?i9bFB7bMQQ0okFYCN6XYN/VJE6+9nwTITno7thSI/QFQGUE77PTZO6N7s5Ne?=
 =?us-ascii?Q?bQbC6chswpkbP+W+7INlP5tdKvfYMyiRUfXjX7JZ35xFG/KS6SG3RObfCD6Z?=
 =?us-ascii?Q?Q7SK6aVJjYGxMnqYjyvQTMS4hiO2Oc83JZMsgwefKGZS1cxW8EmztzSVVGLG?=
 =?us-ascii?Q?ECK63QWtEuw+lGONTJbVTQlPcwWxUdqkCZtWuZ4Xmg2VN62pnDeJohBuFgId?=
 =?us-ascii?Q?rnqRi7NBWxKxUgZ45Ke/TbfaYB9YlrqwXoefcIHFnsWPWg3VVT4h5ShsYKva?=
 =?us-ascii?Q?UfvoOP1Fib4VA/Hv8Q0STAG9FotVsNzWhq/Zi8wfUprD1QTf3pUXLb8rMF+t?=
 =?us-ascii?Q?oKelunBvF93SMYJjNCTKIkdTxyGEYeVPqMHYyGgciG1eqpF9cWOcTxPbaR25?=
 =?us-ascii?Q?MzhswMzek5ULHrI+FRTnDYZZgbGzTlwwTrz2DGht0hl3FtyFmf08L485PsUu?=
 =?us-ascii?Q?xuYfvqUBcbunKqt77KEY6TYK3+7P7TUPW/KbI9EjXLA49wFsU+Z3+jrWB4CX?=
 =?us-ascii?Q?AS7PU3ugz+bUeeQZUcWrISNk6aFVnWSKhw5waw8cmzVjrXQIHQuq6unSouqe?=
 =?us-ascii?Q?jazV0INnt3bfbPtC9+uVkC7x5alixD/ZUjwa8+rKTrSlDCeQtAwcxk0/xZEZ?=
 =?us-ascii?Q?h7T2bcWjdRbP1FoCpQjINnJ4HmHsY31XnHgMuKyYXAchR4N2qld58Mh8xgdj?=
 =?us-ascii?Q?+/FqhUFeMuC3Bo0PVV8DVcjkZQJApnCPkB8Vyb029O3KuLD98hpawUyBcCAx?=
 =?us-ascii?Q?pTuiThtWo3ovcHZKK6NUXw+P7tflxIbOZLbwV/8ymLSc2DQtWW2Fzq4HkJh4?=
 =?us-ascii?Q?vjxmk2S+22jxRqOS2wYU5XuywmEom8kfbMR6RfTqpeyFpW8EZduCpM3Nj90E?=
 =?us-ascii?Q?6ysmgnvRAqSj7+dKiOqfGt19WX7pGSeM+IwfWYI2hVH2m6y24Dq5jdyPSbb7?=
 =?us-ascii?Q?mfupeetz2jb+t8ONufdlISHED/gyd2tPzuut+C0nR92UnLoIQsAxAHmeXauo?=
 =?us-ascii?Q?B31k+s3b2f2lQnoEsaAqcibNs2xKzYxlCJsHEBVi2HErvMXoiFweKCqaS9u+?=
 =?us-ascii?Q?9et/Y+0cKJOpmcfEIq1OldTu2NzJnlcTnel5/gKKXp90189xKWf5z2O/Gizk?=
 =?us-ascii?Q?lvV52EXnEBmFbrvHKYCoUub3pDpRmF6XDzAnB0omKTiGQazk+LP0kppFUOc8?=
 =?us-ascii?Q?3xgI84jhAqBqTXQR3ZgSxaz9x7jk3BqNqHe72MUV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f6bd2e-b15e-4b7e-6565-08ddc465f1c6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 12:40:28.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8u/ZC5R+W4uFDIzznYjG80XFmU8lUYoq2jUk41VZDro+styfbIo0Ywsd82x+G9vA9uPDs7Q+p1vKI8BoKvzUOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413

Hi Breno,

On Wed, Jul 16, 2025 at 03:47:38AM -0700, Breno Leitao wrote:
> Hello Andrea,
> 
> On Tue, Jul 15, 2025 at 07:20:28PM +0200, Andrea Righi wrote:
> > > On Tue, Apr 22, 2025 at 10:26:32AM +0200, Andrea Righi wrote:
> 
> > > 
> > > > +		lockdep_assert_rq_held(rq);
> > > > +	__this_cpu_write(locked_rq, rq);
> > > 
> > > This is hitting the following BUG() on some of my debug kernels:
> > > 
> > > 	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
> > > 
> > > I have lockdep enabled, and I don't see the assert above. I am wondering
> > > if rq is locked but preemption continues to be enabled (!?)
> > 
> > Interesting. And it makes sense, because we may have callbacks called from
> > a preemptible context (especially when rq == NULL).
> > 
> > I think we can just put a preempt_disable() / preempt_enable() around
> > __this_cpu_write(). If we jump to another CPU during the callback it's
> > fine, since we would track the rq state on the other CPU with its own local
> > variable. And if we were able to jump there, it means that preemption was
> > disabled as well.
> 
> First of all thanks for the suggestion!
> 
> What about a patch like the following:

Looks good to me, feel free to add my:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> commit 9ed31e914181ec8f2d0b4484c42b00b6794661b9
> Author: Breno Leitao <leitao@debian.org>
> Date:   Wed Jul 16 03:10:59 2025 -0700
> 
>     sched/ext: Suppress warning in __this_cpu_write() by disabling preemption
>     
>     __this_cpu_write() emits a warning if used with preemption enabled.
>     
>     Function update_locked_rq() might be called with preemption enabled,
>     which causes the following warning:
>     
>             BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
>     
>     Disable preemption around the __this_cpu_write() call in
>     update_locked_rq() to suppress the warning, without affecting behavior.
>     
>     If preemption triggers a jump to another CPU during the callback it's
>     fine, since we would track the rq state on the other CPU with its own
>     local variable.
>     
>     Suggested-by: Andrea Righi <arighi@nvidia.com>
>     Signed-off-by: Breno Leitao <leitao@debian.org>
>     Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b498d867ba210..24fcbd7331f73 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1258,7 +1258,14 @@ static inline void update_locked_rq(struct rq *rq)
>  	 */
>  	if (rq)
>  		lockdep_assert_rq_held(rq);
> +	/*
> +	 * __this_cpu_write() emits a warning when used with preemption enabled.
> +	 * While there's no functional issue if the callback runs on another
> +	 * CPU, we disable preemption here solely to suppress that warning.
> +	 */
> +	preempt_disable();
>  	__this_cpu_write(locked_rq, rq);
> +	preempt_enable();
>  }
>  
>  /*

