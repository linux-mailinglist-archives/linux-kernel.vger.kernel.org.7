Return-Path: <linux-kernel+bounces-846763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 342B4BC8F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D32714E6E10
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B6E2E1C5C;
	Thu,  9 Oct 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wBM/sUDJ"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805315CD74
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012058; cv=none; b=WRlbR30WRTqKfvBg8VnYjWKDtkudUP2AuB4SRGr+eInTY2cA7UcFD3gxEyYM3F/g0pSIeUZnVJbk4Nt4O7t8a+uDvXDZKWT3wgQ7IHFgRAEBIxYfrrY8yQFM5C2Ex6FcxmCfPR+7OUmpGqhPY8jNAP7m6hftAvFMXOEeAx6U+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012058; c=relaxed/simple;
	bh=EDBJx0S+1Gq6v1Sb/NlzduzwM0TrouLVuDyXGKZIs9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVu9+guDqLALd86iRPUmVIs+kYNc6ahpswFACJmOmsJrner0C6RHcj8J3ISDDl72ov8sacZEh+zcRSfQlFaYZ8p4a/SiAth+f8bNG18P5kdD+Mtd1F7pEP1n+MRSMudQwkNXh9jM3stCm7gqc/ZAv52BjFfxDLcGouBPAZevVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wBM/sUDJ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCW7DG8gVINYnlk1FvoO2as6Oo5nmHNYBe6V2Za4ZinVmygB3gtJ+LqwtrKuycVC70XyfKecrOul6rLMt5k=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760012053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CUMZSpWPXzOS4pPPjCA/cHJPYX+kTpvk7j8DvEy4eQ=;
	b=wBM/sUDJwZNbSqtmpRfUJK6f4bv/7Kq5PDHo1uNQi/7WJ1bjGhdtY3NJ8TbajzELLCzbF7
	IpUVmpYTKF23hqmIpufnLiZtIeRrTyl71fmz6TxeHOSBVF6FoFak2Hpab0ikJQ0/eTOiCL
	50B4sYUG+LgAdP0oj3iNDxjlcurs1Ug=
X-Gm-Message-State: AOJu0YwieM1hZkHkLc2yLFfurmTxhH+jdhdYvh59AXgycYuTplSJN/JE
	uhpjTvJkO2oBD/6kWjdGYQUEYlcBzMstLZ08k8wZi9ca+upKJdVKf8WQZihERYDyskym8cYih9T
	7IPZnaDQDciqSAJGK88jFzYGbQLIPrf8=
X-Google-Smtp-Source: AGHT+IFyFmFwcV7VuN+oua1WO4Y4b9JOuSOx0GHrGSeP3Vz0UaQD1TeBB9STI2EBt42s1mOhK1VYbR5qXSf4vqmGaTU=
X-Received: by 2002:a05:6214:d6b:b0:820:a83:ead4 with SMTP id
 6a1803df08f44-87b20fede09mr87452386d6.1.1760012050318; Thu, 09 Oct 2025
 05:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009070045.2011920-1-xialonglong2025@163.com> <20251009070045.2011920-2-xialonglong2025@163.com>
In-Reply-To: <20251009070045.2011920-2-xialonglong2025@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Thu, 9 Oct 2025 20:13:33 +0800
X-Gmail-Original-Message-ID: <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
X-Gm-Features: AS18NWBIS184i6Kf0xw-Zy5px1Iv8SQwsppEhVOgel2w0XXUt5odRjDwHcgQWGE
Message-ID: <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory failures
To: Longlong Xia <xialonglong2025@163.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, xu.xin16@zte.com.cn, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Longlong Xia <xialonglong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 9, 2025 at 3:56=E2=80=AFPM Longlong Xia <xialonglong2025@163.co=
m> wrote:
>
> From: Longlong Xia <xialonglong@kylinos.cn>
>
> When a hardware memory error occurs on a KSM page, the current
> behavior is to kill all processes mapping that page. This can
> be overly aggressive when KSM has multiple duplicate pages in
> a chain where other duplicates are still healthy.
>
> This patch introduces a recovery mechanism that attempts to migrate
> mappings from the failing KSM page to another healthy KSM page within
> the same chain before resorting to killing processes.

Interesting, thanks for the patch! One question below.

>
> The recovery process works as follows:
> 1. When a memory failure is detected on a KSM page, identify if the
> failing node is part of a chain (has duplicates)
> 2. Search for another healthy KSM page within the same chain
> 3. For each process mapping the failing page:
> - Update the PTE to point to the healthy KSM page
> - Migrate the rmap_item to the new stable node
> 4. If all migrations succeed, remove the failing node from the chain
> 5. Only kill processes if recovery is impossible or fails
>
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> ---
>  mm/ksm.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 160787bb121c..590d30cfe800 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3084,6 +3084,183 @@ void rmap_walk_ksm(struct folio *folio, struct rm=
ap_walk_control *rwc)
>  }
>
>  #ifdef CONFIG_MEMORY_FAILURE
> +static struct ksm_stable_node *find_chain_head(struct ksm_stable_node *d=
up_node)
> +{
> +       struct ksm_stable_node *stable_node, *dup;
> +       struct rb_node *node;
> +       int nid;
> +
> +       if (!is_stable_node_dup(dup_node))
> +               return NULL;
> +
> +       for (nid =3D 0; nid < ksm_nr_node_ids; nid++) {
> +               node =3D rb_first(root_stable_tree + nid);
> +               for (; node; node =3D rb_next(node)) {
> +                       stable_node =3D rb_entry(node,
> +                                              struct ksm_stable_node,
> +                                              node);
> +
> +                       if (!is_stable_node_chain(stable_node))
> +                               continue;
> +
> +                       hlist_for_each_entry(dup, &stable_node->hlist,
> +                                            hlist_dup) {
> +                               if (dup =3D=3D dup_node)
> +                                       return stable_node;
> +                       }
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static struct folio *
> +find_target_folio(struct ksm_stable_node *failing_node, struct ksm_stabl=
e_node **target_dup)
> +{
> +       struct ksm_stable_node *chain_head, *dup;
> +       struct hlist_node *hlist_safe;
> +       struct folio *target_folio;
> +
> +       if (!is_stable_node_dup(failing_node))
> +               return NULL;
> +
> +       chain_head =3D find_chain_head(failing_node);
> +       if (!chain_head)
> +               return NULL;
> +
> +       hlist_for_each_entry_safe(dup, hlist_safe, &chain_head->hlist, hl=
ist_dup) {
> +               if (dup =3D=3D failing_node)
> +                       continue;
> +
> +               target_folio =3D ksm_get_folio(dup, KSM_GET_FOLIO_TRYLOCK=
);
> +               if (target_folio) {
> +                       *target_dup =3D dup;
> +                       return target_folio;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static int replace_failing_page(struct vm_area_struct *vma, struct page =
*page,
> +                       struct page *kpage, unsigned long addr)
> +{
> +       struct folio *kfolio =3D page_folio(kpage);
> +       struct mm_struct *mm =3D vma->vm_mm;
> +       struct folio *folio =3D page_folio(page);
> +       pmd_t *pmd;
> +       pte_t *ptep;
> +       pte_t newpte;
> +       spinlock_t *ptl;
> +       int err =3D -EFAULT;
> +       struct mmu_notifier_range range;
> +
> +       pmd =3D mm_find_pmd(mm, addr);
> +       if (!pmd)
> +               goto out;
> +
> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
> +                               addr + PAGE_SIZE);
> +       mmu_notifier_invalidate_range_start(&range);
> +
> +       ptep =3D pte_offset_map_lock(mm, pmd, addr, &ptl);
> +       if (!ptep)
> +               goto out_mn;
> +
> +       if (!is_zero_pfn(page_to_pfn(kpage))) {
> +               folio_get(kfolio);
> +               folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_NO=
NE);
> +               newpte =3D mk_pte(kpage, vma->vm_page_prot);
> +       } else {
> +               newpte =3D pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(=
kpage), vma->vm_page_prot)));
> +               ksm_map_zero_page(mm);
> +               dec_mm_counter(mm, MM_ANONPAGES);
> +       }

Can find_target_folio() return the shared zeropage? If not, the else block
looks like dead code and can be removed.

And, a real hardware failure on the shared zeropage would be
non-recoverable, I guess.

Cheers,
Lance

> +
> +       flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
> +       ptep_clear_flush(vma, addr, ptep);
> +       set_pte_at(mm, addr, ptep, newpte);
> +
> +       folio_remove_rmap_pte(folio, page, vma);
> +       if (!folio_mapped(folio))
> +               folio_free_swap(folio);
> +       folio_put(folio);
> +
> +       pte_unmap_unlock(ptep, ptl);
> +       err =3D 0;
> +out_mn:
> +       mmu_notifier_invalidate_range_end(&range);
> +out:
> +       return err;
> +}
> +
> +static bool ksm_recover_within_chain(struct ksm_stable_node *failing_nod=
e)
> +{
> +       struct ksm_rmap_item *rmap_item;
> +       struct hlist_node *hlist_safe;
> +       struct folio *failing_folio =3D NULL;
> +       struct folio *target_folio =3D NULL;
> +       struct ksm_stable_node *target_dup =3D NULL;
> +       int err;
> +
> +       if (!is_stable_node_dup(failing_node))
> +               return false;
> +
> +       failing_folio =3D ksm_get_folio(failing_node, KSM_GET_FOLIO_NOLOC=
K);
> +       if (!failing_folio)
> +               return false;
> +
> +       target_folio =3D find_target_folio(failing_node, &target_dup);
> +       if (!target_folio) {
> +               folio_put(failing_folio);
> +               return false;
> +       }
> +
> +       hlist_for_each_entry_safe(rmap_item, hlist_safe, &failing_node->h=
list, hlist) {
> +               struct mm_struct *mm =3D rmap_item->mm;
> +               unsigned long addr =3D rmap_item->address & PAGE_MASK;
> +               struct vm_area_struct *vma;
> +
> +               mmap_read_lock(mm);
> +               if (ksm_test_exit(mm)) {
> +                       mmap_read_unlock(mm);
> +                       continue;
> +               }
> +
> +               vma =3D vma_lookup(mm, addr);
> +               if (!vma) {
> +                       mmap_read_unlock(mm);
> +                       continue;
> +               }
> +
> +               /* Update PTE to point to target_folio's page */
> +               err =3D replace_failing_page(vma, &failing_folio->page,
> +                                            &target_folio->page, addr);
> +               if (!err) {
> +                       hlist_del(&rmap_item->hlist);
> +                       rmap_item->head =3D target_dup;
> +                       hlist_add_head(&rmap_item->hlist, &target_dup->hl=
ist);
> +                       target_dup->rmap_hlist_len++;
> +                       failing_node->rmap_hlist_len--;
> +
> +               }
> +
> +               mmap_read_unlock(mm);
> +       }
> +
> +       folio_unlock(target_folio);
> +       folio_put(target_folio);
> +       folio_put(failing_folio);
> +
> +       if (failing_node->rmap_hlist_len =3D=3D 0) {
> +               __stable_node_dup_del(failing_node);
> +               free_stable_node(failing_node);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  /*
>   * Collect processes when the error hit an ksm page.
>   */
> @@ -3098,6 +3275,12 @@ void collect_procs_ksm(const struct folio *folio, =
const struct page *page,
>         stable_node =3D folio_stable_node(folio);
>         if (!stable_node)
>                 return;
> +
> +       if (ksm_recover_within_chain(stable_node)) {
> +               pr_debug("recovery within chain successful, no need to ki=
ll processes\n");
> +               return;
> +       }
> +
>         hlist_for_each_entry(rmap_item, &stable_node->hlist, hlist) {
>                 struct anon_vma *av =3D rmap_item->anon_vma;
>
> --
> 2.43.0
>
>

