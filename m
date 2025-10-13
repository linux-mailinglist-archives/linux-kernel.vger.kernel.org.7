Return-Path: <linux-kernel+bounces-851526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0585BD6A84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E3AF34F16B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6172FAC07;
	Mon, 13 Oct 2025 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I3e+5SHF"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844271990A7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395644; cv=none; b=TfUR6bPtFOUdRm3LAPBTx0F6e0NxKVetCeSY6hffFroAU+Cc8gihvUpVSpHe6cXjLTVlVwn5KyLZ4j5WpSQ2GHF6PXyF4pjMHgYyfgEdorGyvQjLC7xJqUzBi4o23ZByIEGnq0hXemrk1pnuhe6CDsaHvv77/qjN1Pm02zPd5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395644; c=relaxed/simple;
	bh=YB6T+iksAdaFSybd1uus3MCfkm4akoiZhW6/MGSVQic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GcoIx/VYFs5I6ar5fCuQboYBZsHSZAQy4i05y/6DCjL+FE2SOEo/ymDwhdcqX+j9xB0IBwi+tb3fmK9GElMATBkkI8zUtunf3CR60QmeFWcQJGDe5uh8EUaYW8nGQwaJKblIvFAnmENbOz0o2743BoUOSW/H9/qfZP6YyrbcoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I3e+5SHF; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760395625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvVrgqE5UCoUQhWcYn4T+nWyANRYtASSr9LcpzAHUuA=;
	b=I3e+5SHFTgUvTqFeG/5a1PCCaKzBtf7GtUS8bYY/Hk6NPHCv8U3BRHMHvuPl3cD9tHs/Dq
	tnESMYYeNWKpp7T+21L/NyVh0PIS0d7053jHpSE7IK9gPgA8kyZyI/PRHQxAxl84dUnqtZ
	KrS4TcSHu1uRIcx43kjX79znlQhPiDo=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Barry Song <21cnbao@gmail.com>,  netdev@vger.kernel.org,
  linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,
  Jonathan Corbet <corbet@lwn.net>,  Eric Dumazet <edumazet@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  Willem de Bruijn <willemb@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Brendan Jackman <jackmanb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Zi Yan <ziy@nvidia.com>,  Yunsheng Lin
 <linyunsheng@huawei.com>,  Huacai Zhou <zhouhuacai@oppo.com>,  Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,  Harry Yoo
 <harry.yoo@oracle.com>,  David Hildenbrand <david@redhat.com>,  Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
In-Reply-To: <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz> (Vlastimil Babka's
	message of "Mon, 13 Oct 2025 20:30:13 +0200")
References: <20251013101636.69220-1-21cnbao@gmail.com>
	<927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
Date: Mon, 13 Oct 2025 15:46:54 -0700
Message-ID: <877bwyxvvl.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Vlastimil Babka <vbabka@suse.cz> writes:

> On 10/13/25 12:16, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>> 
>> On phones, we have observed significant phone heating when running apps
>> with high network bandwidth. This is caused by the network stack frequently
>> waking kswapd for order-3 allocations. As a result, memory reclamation becomes
>> constantly active, even though plenty of memory is still available for network
>> allocations which can fall back to order-0.
>> 
>> Commit ce27ec60648d ("net: add high_order_alloc_disable sysctl/static key")
>> introduced high_order_alloc_disable for the transmit (TX) path
>> (skb_page_frag_refill()) to mitigate some memory reclamation issues,
>> allowing the TX path to fall back to order-0 immediately, while leaving the
>> receive (RX) path (__page_frag_cache_refill()) unaffected. Users are
>> generally unaware of the sysctl and cannot easily adjust it for specific use
>> cases. Enabling high_order_alloc_disable also completely disables the
>> benefit of order-3 allocations. Additionally, the sysctl does not apply to the
>> RX path.
>> 
>> An alternative approach is to disable kswapd for these frequent
>> allocations and provide best-effort order-3 service for both TX and RX paths,
>> while removing the sysctl entirely.

I'm not sure this is the right path long-term. There are significant
benefits associated with using larger pages, so making the kernel fall
back to order-0 pages easier and sooner feels wrong, tbh. Without kswapd
trying to defragment memory, the only other option is to force tasks
into the direct compaction and it's known to be problematic.

I wonder if instead we should look into optimizing kswapd to be less
power-hungry?

And if you still prefer to disable kswapd for this purpose, at least it
should be conditional to vm.laptop_mode. But again, I don't think it's
the right long-term approach.

Thanks!

