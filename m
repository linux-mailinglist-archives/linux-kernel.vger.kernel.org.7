Return-Path: <linux-kernel+bounces-797589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF8B41237
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29076486E07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359381F1311;
	Wed,  3 Sep 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VGklzj4I"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0E1FDE01
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756865594; cv=none; b=fFsn9E/NnQxAmIl56h9v1fehSI5aLgp7Z8GibtCTXnWrVyC7cYDe42DIxnXwfb35LnyUTS1L7iQxldHIHBEegLdhwmkoxTgtXSk5ryd2nCrnivWd7mjTIfW+iqizx6rvNWGJqx24bpjO0lbdIEFRqnkeUFJqVDG311w1K+MiU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756865594; c=relaxed/simple;
	bh=CDURzxhnSpjNpbop87SnV2kQDooaQjM6sjUMAT/kMpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C5ldmd69IREmMhmY5AuJJ+V9avRDmfwcRWblw+Chg9Sx3DtuKVn5iT+DlQPVImB1r1IBys01lkIs2EQ62rTv/VQAj5/kaJLjOG4CsWjS9X+/9iWgzIN80P5HLETZilsy0ggvLj8ZPi4iPda5dTEyydEpG+uAvZdpE83xSmisf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VGklzj4I; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756865589; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=YJM5aDMEMhlJm6ksbZAor+Vg6bFxrrvKR8Asi7b/Klw=;
	b=VGklzj4IC7A+iWECeGpLVRVNbyPo2hxROMd0lvRwHVHMDVCZdpjRxJf0EcWOOoGHGYA3rU5M5cwEB0+7oLw6JP8iHIaUjfp/XgoQRUX5v+YpGLAAPvRewBXXsoWyDDvy1KdxTEZFBeAZMBb7VL1bSA8QsR2FTY7yxaO0SEj/8BM=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wn9UZSB_1756865573 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 10:13:08 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,  James Morse
 <james.morse@arm.com>,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org, Takao Indoh <indou.takao@jp.fujitsu.com>,
 QI Fuli <qi.fuli@fujitsu.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Rafael Aquini <aquini@redhat.com>
Subject: Re: [RFC PATCH v1 0/2] Don't broadcast TLBI if mm was only active
 on local CPU
In-Reply-To: <20250829153510.2401161-1-ryan.roberts@arm.com> (Ryan Roberts's
	message of "Fri, 29 Aug 2025 16:35:06 +0100")
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
Date: Wed, 03 Sep 2025 10:12:52 +0800
Message-ID: <874itk1dy3.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Ryan,

Ryan Roberts <ryan.roberts@arm.com> writes:

> Hi All,
>
> This is an RFC for my implementation of an idea from James Morse to avoid
> broadcasting TBLIs to remote CPUs if it can be proven that no remote CPU could
> have ever observed the pgtable entry for the TLB entry that is being
> invalidated. It turns out that x86 does something similar in principle.
>
> The primary feedback I'm looking for is; is this actually correct and safe?
> James and I both believe it to be, but it would be useful to get further
> validation.
>
> Beyond that, the next question is; does it actually improve performance?
> stress-ng's --tlb-shootdown stressor suggests yes; as concurrency increases, we
> do a much better job of sustaining the overall number of "tlb shootdowns per
> second" after the change:
>
> +------------+--------------------------+--------------------------+--------------------------+
> |            |     Baseline (v6.15)     |        tlbi local        |        Improvement       |
> +------------+-------------+------------+-------------+------------+-------------+------------+
> | nr_threads |     ops/sec |    ops/sec |     ops/sec |    ops/sec |     ops/sec |    ops/sec |
> |            | (real time) | (cpu time) | (real time) | (cpu time) | (real time) | (cpu time) |
> +------------+-------------+------------+-------------+------------+-------------+------------+
> |          1 |        9109 |       2573 |        8903 |       3653 |         -2% |        42% |
> |          4 |        8115 |       1299 |        9892 |       1059 |         22% |       -18% |
> |          8 |        5119 |        477 |       11854 |       1265 |        132% |       165% |
> |         16 |        4796 |        286 |       14176 |        821 |        196% |       187% |
> |         32 |        1593 |         38 |       15328 |        474 |        862% |      1147% |
> |         64 |        1486 |         19 |        8096 |        131 |        445% |       589% |
> |        128 |        1315 |         16 |        8257 |        145 |        528% |       806% |
> +------------+-------------+------------+-------------+------------+-------------+------------+
>
> But looking at real-world benchmarks, I haven't yet found anything where it
> makes a huge difference; When compiling the kernel, it reduces kernel time by
> ~2.2%, but overall wall time remains the same. I'd be interested in any
> suggestions for workloads where this might prove valuable.
>
> All mm selftests have been run and no regressions are observed. Applies on
> v6.17-rc3.

Thanks for working on this.

Several previous TLBI broadcast optimization have been tried before,
Cced the original authors for discussion.  Some workloads show good
improvement,

https://lore.kernel.org/lkml/20190617143255.10462-1-indou.takao@jp.fujitsu.com/
https://lore.kernel.org/all/20200203201745.29986-1-aarcange@redhat.com/

Especially in the following mail,

https://lore.kernel.org/all/20200314031609.GB2250@redhat.com/

---
Best Regards,
Huang, Ying

