Return-Path: <linux-kernel+bounces-857002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB4BE59DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6EF1A660A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A442E3B11;
	Thu, 16 Oct 2025 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="Jmi9JU/s"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29AB2DF3E7
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651703; cv=none; b=OUotwOxboN9klbGDMsS/0o+MSY60rI4bkCjLJQ6uudlfuVL6Fk3x05+zFlZB8VuUw3hCFJF1DuBiJIsG+I6krBonPmcH8+nBWB4oshQPUTPKswrdAuS5/ODY5my5w6FaJgTNAiO6D37l/tVgxTzFwWAi/MuHdSKvREw9emTwrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651703; c=relaxed/simple;
	bh=OzbV6V2UrOakoVLDre1ObAY+8/mBt6xFPW0LyFljjK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EonzWjRivDXidAMOdzn7no1mGlqa7E70qoOQHMpLntcjVz8jjLM7IDCxBamrW6lp7U2u9ja21OVDNfdDGMq6Xdci3rlRRb63zThJOSZnIcVXkyMuFzIgn5WjfY50VlxqpvxReJww7iBAHqWkQ7o3EaaWtS7EOVQ3MXtiKEim0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=Jmi9JU/s; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
Message-ID: <f9e9e33b-3338-44bc-abbf-5a9328719601@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1760651697; bh=OzbV6V2UrOakoVLDre1ObAY+8/mBt6xFPW0LyFljjK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jmi9JU/sHxktO1Jxdxb4TX9INRPqybwHwF4ZZ6ZpKaDhJGk+VSIiVzIt3Qm9WADCq
	 /Gso+9FPWLrEa8UDMhBS1wUwVPK1TcraSDZ+0j8d+qQvjIBkPPp4TGnwyK+ldc+OC9
	 djnXQU88hg0vFI3d0n4t/Optn2zfHhwzeBeY6f5SmJJnp8mP2Y1yplUED5m7eNslAU
	 JrBk21LtYxS368uBQ0C7vV7iGbmBCHdk+fl8O40hQXC8u7Tk9NgIXz/btJM1GbGQ3A
	 8M7VBl7xgLlubMF4Ou4rnvpN1IQt1smuuDWAHYNldpFyBgnD1AfLaZuhp5dVglEC+N
	 vu1DkTqZ/GLoA==
Date: Thu, 16 Oct 2025 21:54:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Andrew Morton <akpm@linux-foundation.org>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251016012236.4189-1-pedrodemargomes@gmail.com>
 <20251016140735.d7d4c282f0fbf22954a4b4ee@linux-foundation.org>
From: craftfever <craftfever@airmail.cc>
In-Reply-To: <20251016140735.d7d4c282f0fbf22954a4b4ee@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Andrew Morton wrote:
> On Wed, 15 Oct 2025 22:22:36 -0300 Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:
> 
>> Currently, scan_get_next_rmap_item() walks every page address in a VMA
>> to locate mergeable pages. This becomes highly inefficient when scanning
>> large virtual memory areas that contain mostly unmapped regions.
>>
>> This patch replaces the per-address lookup with a range walk using
>> walk_page_range(). The range walker allows KSM to skip over entire
>> unmapped holes in a VMA, avoiding unnecessary lookups.
>> This problem was previously discussed in [1].
>>
>> ...
>>
>> Reported-by: craftfever <craftfever@airmail.cc>
>> Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> 
> Is Fixes: b1d3e9bbccb4 ("mm/ksm: convert scan_get_next_rmap_item() from
> follow_page() to folio_walk") appropriate?
> 
> The problem which is being addressed seems pretty serious.  What do
> people think about proposing a -stable backport of this fix?
> 
> It would be better if this changelog were to describe the user-visible
> effects of the problem.  A copy-n-paste from
> https://bugzilla.kernel.org/show_bug.cgi?id=220599 would suffice.

Emergency Update:

A moment ago I had ksmd crashed, so patch really needs further work. Trace:

[ 2472.174930] BUG: Bad page map in process ksmd  pte:fffffffffffff600
[ 2472.174938] pgd:11394a067 p4d:11394a067 pud:100f96067 pmd:102c68067
[ 2472.174941] addr:00007f2ae1511000 vm_flags:c8100073 
anon_vma:ffff8ab79bcea1a0 mapping:0000000000000000 index:7f2ae1511
[ 2472.174944] file:(null) fault:0x0 mmap:0x0 mmap_prepare: 0x0 
read_folio:0x0
[ 2472.174978] CPU: 2 UID: 0 PID: 52 Comm: ksmd Tainted: G S  BU     OE 
      6.18.0-rc1-1-git-00014-g1f4a222b0e33-dirty #4 PREEMPT(voluntary) 
b9513c77908d39edabd314a5ac9b34ef2c53c2c8
[ 2472.174984] Tainted: [S]=CPU_OUT_OF_SPEC, [B]=BAD_PAGE, [U]=USER, 
[O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[ 2472.174985] Hardware name: FUJITSU LIFEBOOK AH532/G21/FJNBB1D, BIOS 
Version 1.12 06/10/2019
[ 2472.174987] Sched_ext: 
rusty_1.0.16_ge25cc6e5_dirty_x86_64_unknown_linux_gnu (enabled+all), 
task: runnable_at=-5ms
[ 2472.174989] Call Trace:
[ 2472.174990]  <TASK>
[ 2472.174992]  dump_stack_lvl+0x5d/0x80
[ 2472.174997]  print_bad_page_map.cold+0x26d/0x355
[ 2472.175000]  ? ___pte_offset_map+0x1b/0x160
[ 2472.175005]  vm_normal_page+0xf4/0x100
[ 2472.175010]  ksm_pmd_entry+0x1cf/0x2f0
[ 2472.175014]  walk_pgd_range+0x5a2/0xb50
[ 2472.175020]  __walk_page_range+0x6e/0x1e0
[ 2472.175025]  walk_page_range_mm+0x150/0x210
[ 2472.175030]  ksm_scan_thread+0x166/0x2080
[ 2472.175037]  ? __pfx_ksm_scan_thread+0x10/0x10
[ 2472.175042]  kthread+0xfc/0x240
[ 2472.175046]  ? __pfx_kthread+0x10/0x10
[ 2472.175050]  ret_from_fork+0x1c2/0x1f0
[ 2472.175053]  ? __pfx_kthread+0x10/0x10
[ 2472.175057]  ret_from_fork_asm+0x1a/0x30
[ 2472.175062]  </TASK>
[ 2472.175132] BUG: Bad page map in process ksmd  pte:fffffffffffff600
[ 2472.175139] pgd:11394a067 p4d:11394a067 pud:100f96067 pmd:11989b067
[ 2472.175143] addr:00007f2ae1712000 vm_flags:c8100073 
anon_vma:ffff8ab79bcea1a0 mapping:0000000000000000 index:7f2ae1712



KSM crashed.

