Return-Path: <linux-kernel+bounces-840452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED08BBB4756
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB0016B61D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508E5242D6C;
	Thu,  2 Oct 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0QJpXZ4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9613A2417C6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421665; cv=none; b=WbMb+YCHSiDQGrbSrXZC+WCBD9oCn0J+IvS6QqgndQy/hMjR5p+miO9avFxothhVy61YTVmbyPTLPMYha2j1cIpS6JPiF7U96YrKN6htBYX/YtctgeKjSqsIAdT1/LOlyScfGolrrnvMbEdd0DXgbDteqFk7IoGno1+mVQkn9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421665; c=relaxed/simple;
	bh=32bEZfQqYfO2q5Pt7FYaL56K+Lify5q3TdZ8WSTmDxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVTmfGATZkjE4yMGboMpVIHk19PYC6yFAv0Z+eizWFs8YymmZEwC9hdNMmJTX8dmiTKvgHPO/ZrYnfQkVlSy9kC0Bmq7Anwz8QRTCymBr+JFhXdCiKX/9JqANlcJYp6nHsRo7hV719iH/ZR4QN7kf6I+gOAmPhP7d6+ywGcrPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0QJpXZ4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759421663; x=1790957663;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=32bEZfQqYfO2q5Pt7FYaL56K+Lify5q3TdZ8WSTmDxE=;
  b=M0QJpXZ4624+CGKi5iXCrEW5mYH789IvFISpJ2IL0VBioXlyirULTzQK
   qk673ENVBzkEDpujY17/lbBwcnr+cClI7qx4h1DnmFZkQhuWI8tP6VvJR
   vZG0wv3+U83DvRPluNhWMIpt7F+hfqm8HIwRZP0rCqGw0lWGrwZ36nPCr
   tqx7TLSd3pGa4SuCVN8yCC8HT7uFd1BfWLMVv9lkOfypXvphMUwPpgiIn
   e5WmAf1HBhw6+ZALEpwMgvW2MrFg+wsFJtBKZXiBaQs9VRyvILJq4epZz
   aCn6iLv0eh+eONGk3NsAwTgIgkYwjQm3qxrpvXQY07lG5VGARlHuQ2sFS
   A==;
X-CSE-ConnectionGUID: Xbzxcx3KQZ2Fpt691mREFA==
X-CSE-MsgGUID: /MgwwQ3aQqy8v1uF6UsHSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="87161775"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="87161775"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 09:14:22 -0700
X-CSE-ConnectionGUID: 4rl5JEvCTB6hUYPmJ1BgGg==
X-CSE-MsgGUID: Yfh0zKiTRAWFH8UOEu1BJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="178710489"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.249]) ([10.125.109.249])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 09:14:21 -0700
Message-ID: <9502454a-8065-4a65-9644-2b7fe0ec5f7f@intel.com>
Date: Thu, 2 Oct 2025 09:14:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] x86/mm/asi: set up asi_nonsensitive_pgd
To: Brendan Jackman <jackmanb@google.com>, Andy Lutomirski <luto@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
 mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org,
 david@redhat.com, derkling@google.com, junaids@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com,
 rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
 yosry.ahmed@linux.dev
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-4-2d861768041f@google.com>
 <b0fb40f6-8baa-498f-bb88-50113cb80f53@intel.com>
 <DD7W6FACMRPU.BXJCZU93UMVQ@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <DD7W6FACMRPU.BXJCZU93UMVQ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 07:05, Brendan Jackman wrote:
> On Wed Oct 1, 2025 at 8:28 PM UTC, Dave Hansen wrote:
...>> I also can't help but wonder if it would have been easier and more
>> straightforward to just start this whole exercise at 4k: force all the
>> ASI tables to be 4k. Then, later, add the 2MB support and tie to
>> pageblocks on after.
> 
> This would lead to a much smaller patchset, but I think it creates some
> pretty yucky technical debt and complexity of its own. If you're
> imagining a world where we just leave most of the allocator as-is, and
> just inject "map into ASI" or "unmap from ASI" at the right moments...
...

I'm trying to separate out the two problems:

 1. Have a set of page tables that never require allocations in order to
    map or unmap sensitive data.
 2. Manage each pageblock as either all sensitive or all not sensitive

There is a nonzero set of dependencies to make sure that the pageblock
size is compatible with the page table mapping size... unless you just
make the mapping size 4k.

If the mapping size is 4k, the pageblock size can be anything. There's
no dependency to satisfy.

So I'm not saying to make the sensitive/nonsensitive boundary 4k. Just
to make the _mapping_ size 4k. Then, come back later, and move the
mapping size over to 2MB as an optimization.

>>> +	if (asi_nonsensitive_pgd) {
>>> +		/*
>>> +		 * Since most memory is expected to end up sensitive, start with
>>> +		 * everything unmapped in this pagetable.
>>> +		 */
>>> +		pgprot_t prot_np = __pgprot(pgprot_val(prot) & ~_PAGE_PRESENT);
>>> +
>>> +		VM_BUG_ON((PAGE_SHIFT + pageblock_order) < page_level_shift(PG_LEVEL_2M));
>>> +		phys_pgd_init(asi_nonsensitive_pgd, paddr_start, paddr_end, 1 << PG_LEVEL_2M,
>>> +			      prot_np, init, NULL);
>>> +	}
>>
>> I'm also kinda wondering what the purpose is of having a whole page
>> table full of !_PAGE_PRESENT entries. It would be nice to know how this
>> eventually gets turned into something useful.
> 
> If you are thinking of the fact that just clearing P doesn't really do
> anything for Meltdown/L1TF.. yeah that's true! We'll actually need to
> munge the PFN or something too, but here I wanted do just focus on the
> broad strokes of integration without worrying too much about individual
> CPU mitigations. Flippping _PAGE_PRESENT is already supported by
> set_memory.c and IIRC it's good enough for everything newer than
> Skylake.
> 
> Other than that, these pages being unmapped is the whole point.. later
> on, the subset of memory that we don't need to protect will get flipped
> to being present. Everything else will trigger a pagefault if touched
> and we'll switch address spaces, do the flushing etc.
> 
> Sorry if I'm missing your point here...

What is the point of having a pgd if you can't put it in CR3? If you:

	write_cr3(asi_nonsensitive_pgd);

you'll just triple fault because all kernel text is !_PAGE_PRESENT.

The critical point is when 'asi_nonsensitive_pgd' is functional enough
that it can be loaded into CR3 and handle a switch to the normal
init_mm->pgd.


