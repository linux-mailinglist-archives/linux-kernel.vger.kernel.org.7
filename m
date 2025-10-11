Return-Path: <linux-kernel+bounces-848918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEC3BCED00
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6913E7C68
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014BB1548C;
	Sat, 11 Oct 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnVjNzE4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88925632
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760142556; cv=none; b=rzDtVIOC7Zv2dQ3nPP+jNCZlGS8a6ryf5dYYIVp+c43c8HcBrQaHl7HmdGI/HSERcLGusw9Km2d56jbseiLodgXLUE5dfO9b8LCM9qC9q4VeXXEKwhUgNQymD3Cv8Tw1w9lm9XWybKQY70F27ReuhA6JaXdMQV2s4w13FsilT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760142556; c=relaxed/simple;
	bh=nJPkko1t8OZBp4EpqJyu/7G0WHvVmwVpWHBanJWh0rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bygu3yDRPJ1nz+bbvkwjkcxLlydfQivfWrYSpWTdzvggOdWAGZjYHlrYxIoObpqSN9xW4KuawVTOhpq4U5rbscXjapCLlwayn4wlM5nh4zoLrGHwQh8aB2wwQFfl/8oywP5Q+CaZF6JMZA0RVi3RTHHKSnPgd3UvpR9V2bKws0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnVjNzE4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760142552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YGBdS36q9u92C+dNsmvvGg5yj0CMbWzvorswoVbSWII=;
	b=PnVjNzE4Icr0DrHy1qCxOQ1FuPey2dUKwMgkPViXERUclK11prglrcBD01C5dhu8LlOxKA
	SKGxpkviz30YPc38MMRKxx18csSijWoTHnV99NYaMj6bPwYxDizzjOuuNKvNDCUE4qcMhY
	AGttvni9EF1ThXnT6B1rDdcwodbcymo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-z5qoH3zLM4KIDZtqxRG1NA-1; Fri,
 10 Oct 2025 20:29:08 -0400
X-MC-Unique: z5qoH3zLM4KIDZtqxRG1NA-1
X-Mimecast-MFC-AGG-ID: z5qoH3zLM4KIDZtqxRG1NA_1760142547
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10CC11800365;
	Sat, 11 Oct 2025 00:29:07 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.71])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DAC81955F22;
	Sat, 11 Oct 2025 00:29:04 +0000 (UTC)
Date: Fri, 10 Oct 2025 20:29:02 -0400
From: Phil Auld <pauld@redhat.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@gentwo.org>
Subject: Re: Boot fails with 59faa4da7cd4 and 3accabda4da1
Message-ID: <20251011002902.GA479718@pauld.westford.csb>
References: <20251010151116.GA436967@pauld.westford.csb>
 <CAHk-=wg1xK+Br=FJ5QipVhzCvq7uQVPt5Prze6HDhQQ=QD_BcQ@mail.gmail.com>
 <e4f2a3e3-649a-423b-9696-6406ef56340f@suse.cz>
 <20251010184259.GB436967@pauld.westford.csb>
 <b63f1f40-a8f5-4b54-b025-d8d1daf78c9b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b63f1f40-a8f5-4b54-b025-d8d1daf78c9b@suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Vlastimil,

On Sat, Oct 11, 2025 at 12:22:39AM +0200 Vlastimil Babka wrote:
> On 10/10/25 20:42, Phil Auld wrote:
> > On Fri, Oct 10, 2025 at 08:27:30PM +0200 Vlastimil Babka wrote:
> >> On 10/10/25 20:19, Linus Torvalds wrote:
> >> > On Fri, 10 Oct 2025 at 08:11, Phil Auld <pauld@redhat.com> wrote:
> >> >>
> >> >> After several days of failed boots I've gotten it down to these two
> >> >> commits.
> >> >>
> >> >> 59faa4da7cd4 maple_tree: use percpu sheaves for maple_node_cache
> >> >> 3accabda4da1 mm, vma: use percpu sheaves for vm_area_struct cache
> >> >>
> >> >> The first is such an early failure it's silent. With just 3acca I
> >> >> get :
> >> >>
> >> >> [    9.341152] BUG: kernel NULL pointer dereference, address: 0000000000000040
> >> >> [    9.348115] #PF: supervisor read access in kernel mode
> >> >> [    9.353264] #PF: error_code(0x0000) - not-present page
> >> >> [    9.358413] PGD 0 P4D 0
> >> >> [    9.360959] Oops: Oops: 0000 [#1] SMP NOPTI
> >> >> [    9.365154] CPU: 21 UID: 0 PID: 818 Comm: kworker/u398:0 Not tainted 6.17.0-rc3.slab+ #5 PREEMPT(voluntary)
> >> >> [    9.374982] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.26.0 07/30/2025
> >> >> [    9.382641] RIP: 0010:__pcs_replace_empty_main+0x44/0x1d0
> >> >> [    9.388048] Code: ec 08 48 8b 46 10 48 8b 76 08 48 85 c0 74 0b 8b 48 18 85 c9 0f 85 e5 00 00 00 65 48 63 05 e4 ee 50 02 49 8b 84 c6 e0 00 00 00 <4c> 8b 68 40 4c 89 ef e8 b0 81 ff ff 48 89 c5 48 85 c0 74 1d 48 89
> >> > 
> >> > That decodes to
> >> > 
> >> >    0:           mov    0x10(%rsi),%rax
> >> >    4:           mov    0x8(%rsi),%rsi
> >> >    8:           test   %rax,%rax
> >> >    b:           je     0x18
> >> >    d:           mov    0x18(%rax),%ecx
> >> >   10:           test   %ecx,%ecx
> >> >   12:           jne    0xfd
> >> >   18:           movslq %gs:0x250eee4(%rip),%rax
> >> >   20:           mov    0xe0(%r14,%rax,8),%rax
> >> >   28:*          mov    0x40(%rax),%r13          <-- trapping instruction
> >> >   2c:           mov    %r13,%rdi
> >> >   2f:           call   0xffffffffffff81e4
> >> >   34:           mov    %rax,%rbp
> >> >   37:           test   %rax,%rax
> >> >   3a:           je     0x59
> >> > 
> >> > which is the code around that barn_replace_empty_sheaf() call.
> >> > 
> >> > In particular, the trapping instruction is from get_barn(), it's the "->barn" in
> >> > 
> >> >         return get_node(s, numa_mem_id())->barn;
> >> > 
> >> > so it looks like 'get_node()' is returning NULL here:
> >> > 
> >> >         return s->node[node];
> >> > 
> >> > That 0x250eee4(%rip) is from "get_node()" becoming
> >> > 
> >> >   18:           movslq  %gs:numa_node(%rip), %rax  # node
> >> >   20:           mov    0xe0(%r14,%rax,8),%rax # ->node[node]
> >> > 
> >> > instruction, and then that ->barn dereference is the trapping
> >> > instruction that tries to read node->barn:
> >> > 
> >> >   28:*          mov    0x40(%rax),%r13   # node->barn
> >> > 
> >> > but I did *not* look into why s->node[node] would be NULL.
> >> > 
> >> > Over to you Vlastimil,
> >> 
> >> Thanks, yeah will look ASAP. I suspect the "nodes with zero memory" is
> >> something that might not be handled well in general on x86. I know powerpc
> >> used to do these kind of setups first and they have some special handling,
> >> so numa_mem_id() would give you the closest node with memory in there and I
> >> suspect it's not happening here. CPU 21 is node 6 so it's one of those
> >> without memory. I'll see if I can simulate this with QEMU and what's the
> >> most sensible fix
> >>
> > 
> > Thanks for taking a look.  I thought the NPS4 thing might be playing a role.
> 
> From what I quickly found I understood that NPS4 is supposed to create extra
> numa nodes per socket (4 instead of 1) and interleave the memory between
> them. So it seems weird to me it would assign everything to one node and
> leave 3 others memoryless?
>

That I don't know. Someone from AMD might be able to help there. This system
has had its BIOS and other bits updated just a couple of months ago but
this numa layout has been there since I've been using the system (several
years now).

> > I'm happy to take any test/fix code you have for a spin on this system. 
>  
> Thanks. Here's a candidate fix in case you can test. I'll finalize it
> tomorrow. The slab performance won't be optimal on cpus on those memoryless
> nodes, that's why I'd like to figure out if it's a BIOS bug or not. If
> memoryless nodes are really intended we should look into initializing things
> so that numa_mem_id() works as expected and points to nearest populated
> node.

The below does the trick. It boots and I ran a suite of stress-ng tests
for sanity. Any performance it's getting now is better than it was when it
wouldn't boot :)

Tested-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil

> 
> ----8<----
> From 097c6251882bf5537162d17b6726575288ba9715 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Sat, 11 Oct 2025 00:13:20 +0200
> Subject: [PATCH] slab: fix NULL pointer when trying to access barn
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 60 +++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 135c408e0515..bd3c2821e6c3 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -507,7 +507,12 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
>  /* Get the barn of the current cpu's memory node */
>  static inline struct node_barn *get_barn(struct kmem_cache *s)
>  {
> -	return get_node(s, numa_mem_id())->barn;
> +	struct kmem_cache_node *n = get_node(s, numa_mem_id());
> +
> +	if (!n)
> +		return NULL;
> +
> +	return n->barn;
>  }
>  
>  /*
> @@ -4982,6 +4987,10 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
>  	}
>  
>  	barn = get_barn(s);
> +	if (!barn) {
> +		local_unlock(&s->cpu_sheaves->lock);
> +		return NULL;
> +	}
>  
>  	full = barn_replace_empty_sheaf(barn, pcs->main);
>  
> @@ -5153,13 +5162,20 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  	if (unlikely(pcs->main->size == 0)) {
>  
>  		struct slab_sheaf *full;
> +		struct node_barn *barn;
>  
>  		if (pcs->spare && pcs->spare->size > 0) {
>  			swap(pcs->main, pcs->spare);
>  			goto do_alloc;
>  		}
>  
> -		full = barn_replace_empty_sheaf(get_barn(s), pcs->main);
> +		barn = get_barn(s);
> +		if (!barn) {
> +			local_unlock(&s->cpu_sheaves->lock);
> +			return allocated;
> +		}
> +
> +		full = barn_replace_empty_sheaf(barn, pcs->main);
>  
>  		if (full) {
>  			stat(s, BARN_GET);
> @@ -5314,6 +5330,7 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *sheaf = NULL;
> +	struct node_barn *barn;
>  
>  	if (unlikely(size > s->sheaf_capacity)) {
>  
> @@ -5355,8 +5372,11 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
>  		pcs->spare = NULL;
>  		stat(s, SHEAF_PREFILL_FAST);
>  	} else {
> +		barn = get_barn(s);
> +
>  		stat(s, SHEAF_PREFILL_SLOW);
> -		sheaf = barn_get_full_or_empty_sheaf(get_barn(s));
> +		if (barn)
> +			sheaf = barn_get_full_or_empty_sheaf(barn);
>  		if (sheaf && sheaf->size)
>  			stat(s, BARN_GET);
>  		else
> @@ -5426,7 +5446,7 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
>  	 * If the barn has too many full sheaves or we fail to refill the sheaf,
>  	 * simply flush and free it.
>  	 */
> -	if (data_race(barn->nr_full) >= MAX_FULL_SHEAVES ||
> +	if (!barn || data_race(barn->nr_full) >= MAX_FULL_SHEAVES ||
>  	    refill_sheaf(s, sheaf, gfp)) {
>  		sheaf_flush_unused(s, sheaf);
>  		free_empty_sheaf(s, sheaf);
> @@ -5943,10 +5963,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>   * put the full sheaf there.
>   */
>  static void __pcs_install_empty_sheaf(struct kmem_cache *s,
> -		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty)
> +		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty,
> +		struct node_barn *barn)
>  {
> -	struct node_barn *barn;
> -
>  	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>  
>  	/* This is what we expect to find if nobody interrupted us. */
> @@ -5956,8 +5975,6 @@ static void __pcs_install_empty_sheaf(struct kmem_cache *s,
>  		return;
>  	}
>  
> -	barn = get_barn(s);
> -
>  	/*
>  	 * Unlikely because if the main sheaf had space, we would have just
>  	 * freed to it. Get rid of our empty sheaf.
> @@ -6002,6 +6019,11 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>  	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>  
>  	barn = get_barn(s);
> +	if (!barn) {
> +		local_unlock(&s->cpu_sheaves->lock);
> +		return NULL;
> +	}
> +
>  	put_fail = false;
>  
>  	if (!pcs->spare) {
> @@ -6084,7 +6106,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>  	}
>  
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
> -	__pcs_install_empty_sheaf(s, pcs, empty);
> +	__pcs_install_empty_sheaf(s, pcs, empty, barn);
>  
>  	return pcs;
>  }
> @@ -6121,8 +6143,9 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
>  
>  static void rcu_free_sheaf(struct rcu_head *head)
>  {
> +	struct kmem_cache_node *n;
>  	struct slab_sheaf *sheaf;
> -	struct node_barn *barn;
> +	struct node_barn *barn = NULL;
>  	struct kmem_cache *s;
>  
>  	sheaf = container_of(head, struct slab_sheaf, rcu_head);
> @@ -6139,7 +6162,11 @@ static void rcu_free_sheaf(struct rcu_head *head)
>  	 */
>  	__rcu_free_sheaf_prepare(s, sheaf);
>  
> -	barn = get_node(s, sheaf->node)->barn;
> +	n = get_node(s, sheaf->node);
> +	if (!n)
> +		goto flush;
> +
> +	barn = n->barn;
>  
>  	/* due to slab_free_hook() */
>  	if (unlikely(sheaf->size == 0))
> @@ -6157,11 +6184,12 @@ static void rcu_free_sheaf(struct rcu_head *head)
>  		return;
>  	}
>  
> +flush:
>  	stat(s, BARN_PUT_FAIL);
>  	sheaf_flush_unused(s, sheaf);
>  
>  empty:
> -	if (data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES) {
> +	if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES) {
>  		barn_put_empty_sheaf(barn, sheaf);
>  		return;
>  	}
> @@ -6191,6 +6219,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  		}
>  
>  		barn = get_barn(s);
> +		if (!barn) {
> +			local_unlock(&s->cpu_sheaves->lock);
> +			goto fail;
> +		}
>  
>  		empty = barn_get_empty_sheaf(barn);
>  
> @@ -6304,6 +6336,8 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  		goto do_free;
>  
>  	barn = get_barn(s);
> +	if (!barn)
> +		goto no_empty;
>  
>  	if (!pcs->spare) {
>  		empty = barn_get_empty_sheaf(barn);
> -- 
> 2.51.0
> 
> 

-- 


