Return-Path: <linux-kernel+bounces-688123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC90ADADF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 13:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FF5188E6C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEAA29DB95;
	Mon, 16 Jun 2025 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ALpn2hza"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2D298CDE;
	Mon, 16 Jun 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071731; cv=none; b=a/ll1VZwItYBSlXYBpxp3zikq8jWlo6cbOJW6xCuk3+pK3okbriQ58TJKDlBiw7JttsNorwuHBqwNb3otkdrGq36UQTnFILgoa3198alNMwvLbvqmB0Ypw9+Z5nhSJi5aaWaO7SvCZEQoqmWCjLySD5fVSYL1pgto2qkrRA66Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071731; c=relaxed/simple;
	bh=V499AuoAYOwUcIoTrbAP40H/M6RJyUhNKhE3UiNlLt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TCK4XKz8YMRGOc3CdkZgCyvuT8S05GyhMK0dGF4xUnhiYzAHVp3k2qoppzRdyZTaFCNI6Zx5bR3kUQaS3wsBV6DQ8iAl92FGi1K9ZqY4nuCj4swyCNyk0cqaEmzWlYgl5ettHQv3/ZCf1ibhsavTfPor5VSYi71HXxvITHG43+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ALpn2hza; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750071726; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=V499AuoAYOwUcIoTrbAP40H/M6RJyUhNKhE3UiNlLt0=;
	b=ALpn2hzauV40aPZkKnm84b6p/clppws8aQL6deZk4wQzByk/XERgQWwcdTlMhmdpWe69FN81asKy5sqFYTzBf98v3QgXpzU2OWpDGlozW6+bT5vBQ3PNx9rS/Sf016QTBDMdsujrBgNkgY4rgE4pRjnyshvDXgBsK2SAaSpICKg=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WdxhvVd_1750071724 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Jun 2025 19:02:04 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Cc: Bijan Tabatabai <bijan311@gmail.com>,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,  sj@kernel.org,
  akpm@linux-foundation.org,  corbet@lwn.net,  ziy@nvidia.com,
  matthew.brost@intel.com,  joshua.hahnjy@gmail.com,  rakie.kim@sk.com,
  byungchul@sk.com,  gourry@gourry.net,  apopple@nvidia.com,
  bijantabatab@micron.com,  venkataravis@micron.com,  emirakhur@micron.com,
  ajayjoshi@micron.com,  vtavarespetr@micron.com,  damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in
 include/linux/mempolicy.h
In-Reply-To: <e40aa590-f0a2-4666-84b0-c33c8f4fef87@redhat.com> (David
	Hildenbrand's message of "Mon, 16 Jun 2025 11:45:58 +0200")
References: <20250612181330.31236-1-bijan311@gmail.com>
	<20250612181330.31236-2-bijan311@gmail.com>
	<5a50eeba-b26d-4913-8016-45278608a1ee@redhat.com>
	<CAMvvPS5U8exSvy0fknfhv8ym_dKgMVa7cfMOqn0fGyd+NSjSuQ@mail.gmail.com>
	<e40aa590-f0a2-4666-84b0-c33c8f4fef87@redhat.com>
Date: Mon, 16 Jun 2025 19:02:03 +0800
Message-ID: <87plf43q6s.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Hildenbrand <david@redhat.com> writes:

> On 13.06.25 18:33, Bijan Tabatabai wrote:
>> On Fri, Jun 13, 2025 at 8:45=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
>>>
>>> On 12.06.25 20:13, Bijan Tabatabai wrote:
>>>> From: Bijan Tabatabai <bijantabatab@micron.com>
>>>>

[snip]

>> I did not use get_vma_policy or mpol_misplaced, which I believe is
>> the
>> closest function that exists for what I want in this patch, because
>> those functions
>
> I think what you mean is, that you are performing an rmap walk. But
> there, you do have a VMA + MM available (stable).
>
>> seem to assume they are called inside of the task that the folio/vma
>> is mapped to.
>
> But, we do have a VMA at hand, so why would we want to ignore any set
> policy? (I think VMA policies so far only apply to shmem, but still).
>
> I really think you want to use get_vma_policy() instead of the task polic=
y.
>
>
>> More specifically, mpol_misplaced assumes it is being called within a
>> page fault.
>> This doesn't work for us, because we call it inside of a kdamond process.
>
> Right.
>
> But it uses the vmf only for ...
>
> 1) Obtaining the VMA
> 2) Sanity-checking that the ptlock is held.

3) update NUMA balancing per-folio cpupid state (via should_numa_migrate_me=
mory()).

This needs to be called by the NUMA page fault handler.

> Which, you also have during the rmap walk.
>

[snip]

---
Best Regards,
Huang, Ying

