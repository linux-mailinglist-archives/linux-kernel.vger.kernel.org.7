Return-Path: <linux-kernel+bounces-832881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A3ABA0A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556657B69C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D73B3074A7;
	Thu, 25 Sep 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BbZ4MisE"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C03306D37
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818332; cv=none; b=fdosFp2EGhztiRXt3Uk9PL9E77UnSuhA5XMYVqIYFceSudFTThtCeqjj9ML6UrZWBejmlASNDQsSHgPTPdeT+U1tqP6ia9iMkqedSpUstSggBGfzUpbp/y4EsKsms4qZdsS7RDNQaW0eg31Q5+q2VYXoAoWc0Pupju88qTgEE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818332; c=relaxed/simple;
	bh=X/ozsUqbzdWkzmkoFkKbVGC0LBpffuHHFgznGBLwsiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrzVxqiAlG/8Z67M4nLB/LPAR156IPFQtqP2NfESxlVPMBV+mhzMB14f/46U+W/LPFaigutCCT3C7tGgQxjvDXbD+EXd1jrhOljxMnrzIl1H0Q+bLYequcuE+PMZLfDaNgXsJQYou2fHWV095ZFjduhrFBxiGIs9Pj5hUPvHoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BbZ4MisE; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4c73047a75cso436361cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758818327; x=1759423127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV5SiFKgN0xqXtp+SmL/RXOgvx1wAGZn/OBDrCPinZQ=;
        b=BbZ4MisEarcEKq0lyoLYX6RgeLYs9Q0NC9OQfdePHGn7SrjqfHCH7qEYRa3X2JVzmd
         ce3esBrstfor3r0hBlz9CO1HCDyUEKRvfuugGQXnQM39Cq25sZG+qJp5YTd+vtKbBFuJ
         Aht4BFqBVE2VZn0206oebaS6LCBVLli75MbU5yW51GMbarvzLqllEithxwu9Mv2dp9rQ
         T8nbpff8FtFwCJNeonYBBdNxsE7A7LO4ZdTHNzu6sAJM9HLd+rpe8JPle2zGYfaWzGHW
         MYCjoQ0F+hINojzqx88BiwkAUtPqsMYhNr2VZHB4/Nnfo3HJ2y3pS4XJOWLVOBcTe6gq
         JH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758818327; x=1759423127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BV5SiFKgN0xqXtp+SmL/RXOgvx1wAGZn/OBDrCPinZQ=;
        b=ewqwHZhkQewpWEPPNr+dJueINzwn/L+4AoO730g0zD8q7rf00JrKzDcaOsVYJScpOI
         iPoPtVw1nzWDdICJIPrXSkJdRdf/vDl+TDxhxfTU6g8HkxftbbNh4NZDMGTOi64+/oMk
         2ixKEjNeetGCWjkEll+R9Vfe/v5CyN50ePc4zWjUJKIvysLlhVlzZL288J6Djn9dbvwD
         qvND+qPnBdV+dobhcmut8/4KE3G8NNIy+i/XpnMTpyaoltUVocgtUwm/MSjq4LN8nm6b
         znQ2zbUevi3Yol9Ca0LCBY8QwKJ7kCZa+U3Nc1j7TrUBWEZ0I0nYjlpwSRm3kPqqlzya
         Q6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoT6CVzAG3ehdC434wjBb4ejYfWWD5T34g/gubKIBsORKfRizVIYB8vZqB7f65RExuMg2c7eGHuinRMfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/XSRdWMZaZVg+F/WbQXe3ZPrC7mSq+zXUS3K9e8HMU/NM33b
	EbtMOSG1OcFRO9gp8qOmFvw7ncte7bjkUYb5qwO03N64HAy1whiXrrd6/afulHqy54oOlEqE13N
	z0IPBWy0u5VEG8QBUcf9+iypk0ks3gcZAwQzcku/o
X-Gm-Gg: ASbGncum77o6xfULW+cj9NWdJ27nyfdNttqniDftnQ+UgGWTwQ9zyl6Gbud4DRFF3Ts
	UucMt3GXVCL3HQgMANTd9vZnFEHFKnpUvZqVgt30IglVqLUhAfd6zI4Nnt/6JVA8MTe0i7agOXP
	JoiHm0c6vONGI8PNeXB+2XzUL0DfnPjpxsxKiV+uTJ0Bt/OYQ6OmazUagDL18x5vKAJkGb2m1Wd
	EHv/u9byEf0qo2unpS2qXvRADmgFcc7Ur5tXc/e4Fof
X-Google-Smtp-Source: AGHT+IGa7ONjOU7Pwop9QuQediDIp73V5+MJ086sfctnWro3d8zXciPnATvPjV5t2pocu2nFoMlnvvQ3Yz+j1Okhx8k=
X-Received: by 2002:a05:622a:289:b0:4d1:b2d0:2e2b with SMTP id
 d75a77b69052e-4da2a9cab55mr8170571cf.6.1758818326772; Thu, 25 Sep 2025
 09:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-11-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-11-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Sep 2025 09:38:35 -0700
X-Gm-Features: AS18NWAeX1iMVfUqAISn6e6lKAN6p2ZuFWUr3Hai7ObvhRjcjjSPYZOlE0tYU7E
Message-ID: <CAJuCfpG_3+D+dPN=kzYwSLJR76p6zCwMcA3gHVi1RhFPnEvKtg@mail.gmail.com>
Subject: Re: [PATCH v8 11/23] maple_tree: Drop bulk insert support
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>
> Bulk insert mode was added to facilitate forking faster, but forking now
> uses __mt_dup() to duplicate the tree.
>
> The addition of sheaves has made the bulk allocations difficult to
> maintain - since the expected entries would preallocate into the maple
> state.  A big part of the maple state node allocation was the ability to
> push nodes back onto the state for later use, which was essential to the
> bulk insert algorithm.
>
> Remove mas_expected_entries() and mas_destroy_rebalance() functions as
> well as the MA_STATE_BULK and MA_STATE_REBALANCE maple state flags since
> there are no users anymore.  Drop the associated testing as well.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  lib/maple_tree.c                 | 270 +--------------------------------=
------
>  lib/test_maple_tree.c            | 137 --------------------
>  tools/testing/radix-tree/maple.c |  36 ------
>  3 files changed, 4 insertions(+), 439 deletions(-)

Awesome!

>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 38fb68c082915211c80f473d313159599fe97e2c..4f0e30b57b0cef9e5cf791f3f=
64f5898752db402 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -83,13 +83,9 @@
>
>  /*
>   * Maple state flags
> - * * MA_STATE_BULK             - Bulk insert mode
> - * * MA_STATE_REBALANCE                - Indicate a rebalance during bul=
k insert
>   * * MA_STATE_PREALLOC         - Preallocated nodes, WARN_ON allocation
>   */
> -#define MA_STATE_BULK          1
> -#define MA_STATE_REBALANCE     2
> -#define MA_STATE_PREALLOC      4
> +#define MA_STATE_PREALLOC      1
>
>  #define ma_parent_ptr(x) ((struct maple_pnode *)(x))
>  #define mas_tree_parent(x) ((unsigned long)(x->tree) | MA_ROOT_PARENT)
> @@ -1031,24 +1027,6 @@ static inline void mas_descend(struct ma_state *ma=
s)
>         mas->node =3D mas_slot(mas, slots, mas->offset);
>  }
>
> -/*
> - * mte_set_gap() - Set a maple node gap.
> - * @mn: The encoded maple node
> - * @gap: The offset of the gap to set
> - * @val: The gap value
> - */
> -static inline void mte_set_gap(const struct maple_enode *mn,
> -                                unsigned char gap, unsigned long val)
> -{
> -       switch (mte_node_type(mn)) {
> -       default:
> -               break;
> -       case maple_arange_64:
> -               mte_to_node(mn)->ma64.gap[gap] =3D val;
> -               break;
> -       }
> -}
> -
>  /*
>   * mas_ascend() - Walk up a level of the tree.
>   * @mas: The maple state
> @@ -1878,21 +1856,7 @@ static inline int mab_calc_split(struct ma_state *=
mas,
>          * end on a NULL entry, with the exception of the left-most leaf.=
  The
>          * limitation means that the split of a node must be checked for =
this condition
>          * and be able to put more data in one direction or the other.
> -        */
> -       if (unlikely((mas->mas_flags & MA_STATE_BULK))) {
> -               *mid_split =3D 0;
> -               split =3D b_end - mt_min_slots[bn->type];
> -
> -               if (!ma_is_leaf(bn->type))
> -                       return split;
> -
> -               mas->mas_flags |=3D MA_STATE_REBALANCE;
> -               if (!bn->slot[split])
> -                       split--;
> -               return split;
> -       }
> -
> -       /*
> +        *
>          * Although extremely rare, it is possible to enter what is known=
 as the 3-way
>          * split scenario.  The 3-way split comes about by means of a sto=
re of a range
>          * that overwrites the end and beginning of two full nodes.  The =
result is a set
> @@ -2039,27 +2003,6 @@ static inline void mab_mas_cp(struct maple_big_nod=
e *b_node,
>         }
>  }
>
> -/*
> - * mas_bulk_rebalance() - Rebalance the end of a tree after a bulk inser=
t.
> - * @mas: The maple state
> - * @end: The maple node end
> - * @mt: The maple node type
> - */
> -static inline void mas_bulk_rebalance(struct ma_state *mas, unsigned cha=
r end,
> -                                     enum maple_type mt)
> -{
> -       if (!(mas->mas_flags & MA_STATE_BULK))
> -               return;
> -
> -       if (mte_is_root(mas->node))
> -               return;
> -
> -       if (end > mt_min_slots[mt]) {
> -               mas->mas_flags &=3D ~MA_STATE_REBALANCE;
> -               return;
> -       }
> -}
> -
>  /*
>   * mas_store_b_node() - Store an @entry into the b_node while also copyi=
ng the
>   * data from a maple encoded node.
> @@ -2109,9 +2052,6 @@ static noinline_for_kasan void mas_store_b_node(str=
uct ma_wr_state *wr_mas,
>         /* Handle new range ending before old range ends */
>         piv =3D mas_safe_pivot(mas, wr_mas->pivots, offset_end, wr_mas->t=
ype);
>         if (piv > mas->last) {
> -               if (piv =3D=3D ULONG_MAX)
> -                       mas_bulk_rebalance(mas, b_node->b_end, wr_mas->ty=
pe);
> -
>                 if (offset_end !=3D slot)
>                         wr_mas->content =3D mas_slot_locked(mas, wr_mas->=
slots,
>                                                           offset_end);
> @@ -3011,126 +2951,6 @@ static inline void mas_rebalance(struct ma_state =
*mas,
>         return mas_spanning_rebalance(mas, &mast, empty_count);
>  }
>
> -/*
> - * mas_destroy_rebalance() - Rebalance left-most node while destroying t=
he maple
> - * state.
> - * @mas: The maple state
> - * @end: The end of the left-most node.
> - *
> - * During a mass-insert event (such as forking), it may be necessary to
> - * rebalance the left-most node when it is not sufficient.
> - */
> -static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned =
char end)
> -{
> -       enum maple_type mt =3D mte_node_type(mas->node);
> -       struct maple_node reuse, *newnode, *parent, *new_left, *left, *no=
de;
> -       struct maple_enode *eparent, *old_eparent;
> -       unsigned char offset, tmp, split =3D mt_slots[mt] / 2;
> -       void __rcu **l_slots, **slots;
> -       unsigned long *l_pivs, *pivs, gap;
> -       bool in_rcu =3D mt_in_rcu(mas->tree);
> -       unsigned char new_height =3D mas_mt_height(mas);
> -
> -       MA_STATE(l_mas, mas->tree, mas->index, mas->last);
> -
> -       l_mas =3D *mas;
> -       mas_prev_sibling(&l_mas);
> -
> -       /* set up node. */
> -       if (in_rcu) {
> -               newnode =3D mas_pop_node(mas);
> -       } else {
> -               newnode =3D &reuse;
> -       }
> -
> -       node =3D mas_mn(mas);
> -       newnode->parent =3D node->parent;
> -       slots =3D ma_slots(newnode, mt);
> -       pivs =3D ma_pivots(newnode, mt);
> -       left =3D mas_mn(&l_mas);
> -       l_slots =3D ma_slots(left, mt);
> -       l_pivs =3D ma_pivots(left, mt);
> -       if (!l_slots[split])
> -               split++;
> -       tmp =3D mas_data_end(&l_mas) - split;
> -
> -       memcpy(slots, l_slots + split + 1, sizeof(void *) * tmp);
> -       memcpy(pivs, l_pivs + split + 1, sizeof(unsigned long) * tmp);
> -       pivs[tmp] =3D l_mas.max;
> -       memcpy(slots + tmp, ma_slots(node, mt), sizeof(void *) * end);
> -       memcpy(pivs + tmp, ma_pivots(node, mt), sizeof(unsigned long) * e=
nd);
> -
> -       l_mas.max =3D l_pivs[split];
> -       mas->min =3D l_mas.max + 1;
> -       old_eparent =3D mt_mk_node(mte_parent(l_mas.node),
> -                            mas_parent_type(&l_mas, l_mas.node));
> -       tmp +=3D end;
> -       if (!in_rcu) {
> -               unsigned char max_p =3D mt_pivots[mt];
> -               unsigned char max_s =3D mt_slots[mt];
> -
> -               if (tmp < max_p)
> -                       memset(pivs + tmp, 0,
> -                              sizeof(unsigned long) * (max_p - tmp));
> -
> -               if (tmp < mt_slots[mt])
> -                       memset(slots + tmp, 0, sizeof(void *) * (max_s - =
tmp));
> -
> -               memcpy(node, newnode, sizeof(struct maple_node));
> -               ma_set_meta(node, mt, 0, tmp - 1);
> -               mte_set_pivot(old_eparent, mte_parent_slot(l_mas.node),
> -                             l_pivs[split]);
> -
> -               /* Remove data from l_pivs. */
> -               tmp =3D split + 1;
> -               memset(l_pivs + tmp, 0, sizeof(unsigned long) * (max_p - =
tmp));
> -               memset(l_slots + tmp, 0, sizeof(void *) * (max_s - tmp));
> -               ma_set_meta(left, mt, 0, split);
> -               eparent =3D old_eparent;
> -
> -               goto done;
> -       }
> -
> -       /* RCU requires replacing both l_mas, mas, and parent. */
> -       mas->node =3D mt_mk_node(newnode, mt);
> -       ma_set_meta(newnode, mt, 0, tmp);
> -
> -       new_left =3D mas_pop_node(mas);
> -       new_left->parent =3D left->parent;
> -       mt =3D mte_node_type(l_mas.node);
> -       slots =3D ma_slots(new_left, mt);
> -       pivs =3D ma_pivots(new_left, mt);
> -       memcpy(slots, l_slots, sizeof(void *) * split);
> -       memcpy(pivs, l_pivs, sizeof(unsigned long) * split);
> -       ma_set_meta(new_left, mt, 0, split);
> -       l_mas.node =3D mt_mk_node(new_left, mt);
> -
> -       /* replace parent. */
> -       offset =3D mte_parent_slot(mas->node);
> -       mt =3D mas_parent_type(&l_mas, l_mas.node);
> -       parent =3D mas_pop_node(mas);
> -       slots =3D ma_slots(parent, mt);
> -       pivs =3D ma_pivots(parent, mt);
> -       memcpy(parent, mte_to_node(old_eparent), sizeof(struct maple_node=
));
> -       rcu_assign_pointer(slots[offset], mas->node);
> -       rcu_assign_pointer(slots[offset - 1], l_mas.node);
> -       pivs[offset - 1] =3D l_mas.max;
> -       eparent =3D mt_mk_node(parent, mt);
> -done:
> -       gap =3D mas_leaf_max_gap(mas);
> -       mte_set_gap(eparent, mte_parent_slot(mas->node), gap);
> -       gap =3D mas_leaf_max_gap(&l_mas);
> -       mte_set_gap(eparent, mte_parent_slot(l_mas.node), gap);
> -       mas_ascend(mas);
> -
> -       if (in_rcu) {
> -               mas_replace_node(mas, old_eparent, new_height);
> -               mas_adopt_children(mas, mas->node);
> -       }
> -
> -       mas_update_gap(mas);
> -}
> -
>  /*
>   * mas_split_final_node() - Split the final node in a subtree operation.
>   * @mast: the maple subtree state
> @@ -3837,8 +3657,6 @@ static inline void mas_wr_node_store(struct ma_wr_s=
tate *wr_mas,
>
>         if (mas->last =3D=3D wr_mas->end_piv)
>                 offset_end++; /* don't copy this offset */
> -       else if (unlikely(wr_mas->r_max =3D=3D ULONG_MAX))
> -               mas_bulk_rebalance(mas, mas->end, wr_mas->type);
>
>         /* set up node. */
>         if (in_rcu) {
> @@ -4255,7 +4073,7 @@ static inline enum store_type mas_wr_store_type(str=
uct ma_wr_state *wr_mas)
>         new_end =3D mas_wr_new_end(wr_mas);
>         /* Potential spanning rebalance collapsing a node */
>         if (new_end < mt_min_slots[wr_mas->type]) {
> -               if (!mte_is_root(mas->node) && !(mas->mas_flags & MA_STAT=
E_BULK))
> +               if (!mte_is_root(mas->node))
>                         return  wr_rebalance;
>                 return wr_node_store;
>         }
> @@ -5562,25 +5380,7 @@ void mas_destroy(struct ma_state *mas)
>         struct maple_alloc *node;
>         unsigned long total;
>
> -       /*
> -        * When using mas_for_each() to insert an expected number of elem=
ents,
> -        * it is possible that the number inserted is less than the expec=
ted
> -        * number.  To fix an invalid final node, a check is performed he=
re to
> -        * rebalance the previous node with the final node.
> -        */
> -       if (mas->mas_flags & MA_STATE_REBALANCE) {
> -               unsigned char end;
> -               if (mas_is_err(mas))
> -                       mas_reset(mas);
> -               mas_start(mas);
> -               mtree_range_walk(mas);
> -               end =3D mas->end + 1;
> -               if (end < mt_min_slot_count(mas->node) - 1)
> -                       mas_destroy_rebalance(mas, end);
> -
> -               mas->mas_flags &=3D ~MA_STATE_REBALANCE;
> -       }
> -       mas->mas_flags &=3D ~(MA_STATE_BULK|MA_STATE_PREALLOC);
> +       mas->mas_flags &=3D ~MA_STATE_PREALLOC;
>
>         total =3D mas_allocated(mas);
>         while (total) {
> @@ -5600,68 +5400,6 @@ void mas_destroy(struct ma_state *mas)
>  }
>  EXPORT_SYMBOL_GPL(mas_destroy);
>
> -/*
> - * mas_expected_entries() - Set the expected number of entries that will=
 be inserted.
> - * @mas: The maple state
> - * @nr_entries: The number of expected entries.
> - *
> - * This will attempt to pre-allocate enough nodes to store the expected =
number
> - * of entries.  The allocations will occur using the bulk allocator inte=
rface
> - * for speed.  Please call mas_destroy() on the @mas after inserting the=
 entries
> - * to ensure any unused nodes are freed.
> - *
> - * Return: 0 on success, -ENOMEM if memory could not be allocated.
> - */
> -int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
> -{
> -       int nonleaf_cap =3D MAPLE_ARANGE64_SLOTS - 2;
> -       struct maple_enode *enode =3D mas->node;
> -       int nr_nodes;
> -       int ret;
> -
> -       /*
> -        * Sometimes it is necessary to duplicate a tree to a new tree, s=
uch as
> -        * forking a process and duplicating the VMAs from one tree to a =
new
> -        * tree.  When such a situation arises, it is known that the new =
tree is
> -        * not going to be used until the entire tree is populated.  For
> -        * performance reasons, it is best to use a bulk load with RCU di=
sabled.
> -        * This allows for optimistic splitting that favours the left and=
 reuse
> -        * of nodes during the operation.
> -        */
> -
> -       /* Optimize splitting for bulk insert in-order */
> -       mas->mas_flags |=3D MA_STATE_BULK;
> -
> -       /*
> -        * Avoid overflow, assume a gap between each entry and a trailing=
 null.
> -        * If this is wrong, it just means allocation can happen during
> -        * insertion of entries.
> -        */
> -       nr_nodes =3D max(nr_entries, nr_entries * 2 + 1);
> -       if (!mt_is_alloc(mas->tree))
> -               nonleaf_cap =3D MAPLE_RANGE64_SLOTS - 2;
> -
> -       /* Leaves; reduce slots to keep space for expansion */
> -       nr_nodes =3D DIV_ROUND_UP(nr_nodes, MAPLE_RANGE64_SLOTS - 2);
> -       /* Internal nodes */
> -       nr_nodes +=3D DIV_ROUND_UP(nr_nodes, nonleaf_cap);
> -       /* Add working room for split (2 nodes) + new parents */
> -       mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
> -
> -       /* Detect if allocations run out */
> -       mas->mas_flags |=3D MA_STATE_PREALLOC;
> -
> -       if (!mas_is_err(mas))
> -               return 0;
> -
> -       ret =3D xa_err(mas->node);
> -       mas->node =3D enode;
> -       mas_destroy(mas);
> -       return ret;
> -
> -}
> -EXPORT_SYMBOL_GPL(mas_expected_entries);
> -
>  static void mas_may_activate(struct ma_state *mas)
>  {
>         if (!mas->node) {
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index cb3936595b0d56a9682ff100eba54693a1427829..14fbbee32046a13d54d60dcac=
2b45be2bd190ac4 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -2746,139 +2746,6 @@ static noinline void __init check_fuzzer(struct m=
aple_tree *mt)
>         mtree_test_erase(mt, ULONG_MAX - 10);
>  }
>
> -/* duplicate the tree with a specific gap */
> -static noinline void __init check_dup_gaps(struct maple_tree *mt,
> -                                   unsigned long nr_entries, bool zero_s=
tart,
> -                                   unsigned long gap)
> -{
> -       unsigned long i =3D 0;
> -       struct maple_tree newmt;
> -       int ret;
> -       void *tmp;
> -       MA_STATE(mas, mt, 0, 0);
> -       MA_STATE(newmas, &newmt, 0, 0);
> -       struct rw_semaphore newmt_lock;
> -
> -       init_rwsem(&newmt_lock);
> -       mt_set_external_lock(&newmt, &newmt_lock);
> -
> -       if (!zero_start)
> -               i =3D 1;
> -
> -       mt_zero_nr_tallocated();
> -       for (; i <=3D nr_entries; i++)
> -               mtree_store_range(mt, i*10, (i+1)*10 - gap,
> -                                 xa_mk_value(i), GFP_KERNEL);
> -
> -       mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN=
);
> -       mt_set_non_kernel(99999);
> -       down_write(&newmt_lock);
> -       ret =3D mas_expected_entries(&newmas, nr_entries);
> -       mt_set_non_kernel(0);
> -       MT_BUG_ON(mt, ret !=3D 0);
> -
> -       rcu_read_lock();
> -       mas_for_each(&mas, tmp, ULONG_MAX) {
> -               newmas.index =3D mas.index;
> -               newmas.last =3D mas.last;
> -               mas_store(&newmas, tmp);
> -       }
> -       rcu_read_unlock();
> -       mas_destroy(&newmas);
> -
> -       __mt_destroy(&newmt);
> -       up_write(&newmt_lock);
> -}
> -
> -/* Duplicate many sizes of trees.  Mainly to test expected entry values =
*/
> -static noinline void __init check_dup(struct maple_tree *mt)
> -{
> -       int i;
> -       int big_start =3D 100010;
> -
> -       /* Check with a value at zero */
> -       for (i =3D 10; i < 1000; i++) {
> -               mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
> -               check_dup_gaps(mt, i, true, 5);
> -               mtree_destroy(mt);
> -               rcu_barrier();
> -       }
> -
> -       cond_resched();
> -       mt_cache_shrink();
> -       /* Check with a value at zero, no gap */
> -       for (i =3D 1000; i < 2000; i++) {
> -               mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
> -               check_dup_gaps(mt, i, true, 0);
> -               mtree_destroy(mt);
> -               rcu_barrier();
> -       }
> -
> -       cond_resched();
> -       mt_cache_shrink();
> -       /* Check with a value at zero and unreasonably large */
> -       for (i =3D big_start; i < big_start + 10; i++) {
> -               mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
> -               check_dup_gaps(mt, i, true, 5);
> -               mtree_destroy(mt);
> -               rcu_barrier();
> -       }
> -
> -       cond_resched();
> -       mt_cache_shrink();
> -       /* Small to medium size not starting at zero*/
> -       for (i =3D 200; i < 1000; i++) {
> -               mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
> -               check_dup_gaps(mt, i, false, 5);
> -               mtree_destroy(mt);
> -               rcu_barrier();
> -       }
> -
> -       cond_resched();
> -       mt_cache_shrink();
> -       /* Unreasonably large not starting at zero*/
> -       for (i =3D big_start; i < big_start + 10; i++) {
> -               mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
> -               check_dup_gaps(mt, i, false, 5);
> -               mtree_destroy(mt);
> -               rcu_barrier();
> -               cond_resched();
> -               mt_cache_shrink();
> -       }
> -
> -       /* Check non-allocation tree not starting at zero */
> -       for (i =3D 1500; i < 3000; i++) {
> -               mt_init_flags(mt, 0);
> -               check_dup_gaps(mt, i, false, 5);
> -               mtree_destroy(mt);
> -               rcu_barrier();
> -               cond_resched();
> -               if (i % 2 =3D=3D 0)
> -                       mt_cache_shrink();
> -       }
> -
> -       mt_cache_shrink();
> -       /* Check non-allocation tree starting at zero */
> -       for (i =3D 200; i < 1000; i++) {
> -               mt_init_flags(mt, 0);
> -               check_dup_gaps(mt, i, true, 5);
> -               mtree_destroy(mt);
> -               rcu_barrier();
> -               cond_resched();
> -       }
> -
> -       mt_cache_shrink();
> -       /* Unreasonably large */
> -       for (i =3D big_start + 5; i < big_start + 10; i++) {
> -               mt_init_flags(mt, 0);
> -               check_dup_gaps(mt, i, true, 5);
> -               mtree_destroy(mt);
> -               rcu_barrier();
> -               mt_cache_shrink();
> -               cond_resched();
> -       }
> -}
> -
>  static noinline void __init check_bnode_min_spanning(struct maple_tree *=
mt)
>  {
>         int i =3D 50;
> @@ -4077,10 +3944,6 @@ static int __init maple_tree_seed(void)
>         check_fuzzer(&tree);
>         mtree_destroy(&tree);
>
> -       mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> -       check_dup(&tree);
> -       mtree_destroy(&tree);
> -
>         mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
>         check_bnode_min_spanning(&tree);
>         mtree_destroy(&tree);
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/=
maple.c
> index 172700fb7784d29f9403003b4484a5ebd7aa316b..c0543060dae2510477963331f=
b0ccdffd78ea965 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -35455,17 +35455,6 @@ static void check_dfs_preorder(struct maple_tree=
 *mt)
>         MT_BUG_ON(mt, count !=3D e);
>         mtree_destroy(mt);
>
> -       mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
> -       mas_reset(&mas);
> -       mt_zero_nr_tallocated();
> -       mt_set_non_kernel(200);
> -       mas_expected_entries(&mas, max);
> -       for (count =3D 0; count <=3D max; count++) {
> -               mas.index =3D mas.last =3D count;
> -               mas_store(&mas, xa_mk_value(count));
> -               MT_BUG_ON(mt, mas_is_err(&mas));
> -       }
> -       mas_destroy(&mas);
>         rcu_barrier();
>         /*
>          * pr_info(" ->seq test of 0-%lu %luK in %d active (%d total)\n",
> @@ -36454,27 +36443,6 @@ static inline int check_vma_modification(struct =
maple_tree *mt)
>         return 0;
>  }
>
> -/*
> - * test to check that bulk stores do not use wr_rebalance as the store
> - * type.
> - */
> -static inline void check_bulk_rebalance(struct maple_tree *mt)
> -{
> -       MA_STATE(mas, mt, ULONG_MAX, ULONG_MAX);
> -       int max =3D 10;
> -
> -       build_full_tree(mt, 0, 2);
> -
> -       /* erase every entry in the tree */
> -       do {
> -               /* set up bulk store mode */
> -               mas_expected_entries(&mas, max);
> -               mas_erase(&mas);
> -               MT_BUG_ON(mt, mas.store_type =3D=3D wr_rebalance);
> -       } while (mas_prev(&mas, 0) !=3D NULL);
> -
> -       mas_destroy(&mas);
> -}
>
>  void farmer_tests(void)
>  {
> @@ -36487,10 +36455,6 @@ void farmer_tests(void)
>         check_vma_modification(&tree);
>         mtree_destroy(&tree);
>
> -       mt_init(&tree);
> -       check_bulk_rebalance(&tree);
> -       mtree_destroy(&tree);
> -
>         tree.ma_root =3D xa_mk_value(0);
>         mt_dump(&tree, mt_dump_dec);
>
>
> --
> 2.51.0
>

