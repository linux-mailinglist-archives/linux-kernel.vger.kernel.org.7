Return-Path: <linux-kernel+bounces-846164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA5BC72D1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 110664EBE64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE1192B90;
	Thu,  9 Oct 2025 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sm2OTqgE"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73F1F92E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975653; cv=none; b=QPcpLcnDJBjg68E6klL8QvDQ/dNi5ek5z0OJMn7LwDHO8MxzN53F6iyhyurXRWVx9F1jpsNAmmELG6IDHIR7feSqwwa59QZ+lzYFexAF3rjZoc3H4ak+6ou0kfFt71p2Bo4o2S1WF+t1rAMghE68lTZWyjcN7yTV3Mvkh0dE2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975653; c=relaxed/simple;
	bh=+9Z1568QWUrsstP4FCLDtQpFkE15FgcQ+1tmS7WJ0Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPfaHTHaEi4ak0VtvsqM7rLY8IHM+JZ6J/mWn+v4hZNRJEIAiX/aAAt8D0MoruC9Lx2gJjV22R/jWOfErvhWboDpIe4icc8/1tnIR41jZhw0CZURItMBWk5v7vnnwXTTsPsrJX6T2DzkkeE4vNJHb69uFuU70vdfJHiYWPU7bF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sm2OTqgE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso299253f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759975650; x=1760580450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOYj62ptF6atgMYt5r0y+73WXkLSYqfPTH3G+5RzDpE=;
        b=sm2OTqgEcMkZ+KVmUDyd3o8K3r6WEhrT88ETWiklDVfGwJHSwZGCmL2ZLq14HNyWPL
         +ysVAxc/Ugjrc8JIPICIKoLFRmJp7u+N5bW/MEsMx0yqesgP0o7WPEU0/28qBxBscmL4
         yUGGfvgt8sF2jWtZ2v4BxjKRnakN52Y7TpMB4ud2UANKHdHajfrWbuZIjnjl6TMLKz+l
         ryhIYUJyWOU4nqtgKjWKpsqpvhc7Xa+laGsbJkYBh+1+EwHV81R0jp310qcNZj0A6Loc
         pmQIVgL81RGbxzxTZQcw0VKph0dg+aEwpr65YELxAL6YIVTDOq2oxky+TV6a/ZpxJLfF
         YdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975650; x=1760580450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOYj62ptF6atgMYt5r0y+73WXkLSYqfPTH3G+5RzDpE=;
        b=SyLvwPovOiAqYUZ2CgxEJVLxdfJySQh3YUwyrA0wfA48iUEjMS0WknxPlikQoNSml4
         Gc5a6C9Le8Gh0SIzIueP+A+M+Vr8FWZW6cR3SxUkDmu30ky6RhexXSpWLd1/eV/pUjHH
         d0oRVRp5DQBwdMtDHDZdM+ujVw/6WWMitvxmwEO6eZnyMTZFdZ3Sdbbg/IWULdOEXjn4
         8ErJegtkYNZGFTBiefGSn65RT+jIteikLRjNAz+X7On28oNi0ppntUz18qCAAh25RLpM
         VSpWO/UZfqAA7CXFHRlUgV1/u3GL/SUPJKLrWacI6pK574T6brHyKMMIncJXw/7BruGL
         5RZw==
X-Forwarded-Encrypted: i=1; AJvYcCXpvdMzPB98IJzSadMASZlrvCBVlg1ZVHpLysZ+lpmyzVgyvEF/7NrSEXZtF/hCmoTqXDk/AbbFjnioJzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuP1oO5PSn4yS6sQJgAV244t0Tdy4Dx31C2AcLU6Yol8LmFj4r
	hA6xYxNkWrSPHLKyi2J6w88eBpb9vVCwJaxiPBSsopje0lUAoCDjaPdF5B/I6OFily7Qk45dOQB
	JWNno63VheAzuBqKA/Db1m+CkPYJ3vcBnB2kCV6dQ
X-Gm-Gg: ASbGncsbbtWlDZ1ZVTxcVsdKo000bWJgZhfNPIElzu6LvMg7UC+YxJwnZM4IOCrqkw4
	U1ke4qgJ8mYsR5YsaWR5KEeOtDJ63RwYq9NxEYexFfO4pyiPsMs20Jcf1wk6U/EkQ4+Q+QquCCY
	ejYC3rMgUz69AtbU7t3UDLF5lsKVozbQyzFS0H4Lurtyt8Ilyhoo4+Twr6GZ274wrTCybfgA9ft
	dx6yrwmcS7vWfG6bVwRvkT8/9htVlMr0YKFbjnUbGzr7kMB64jah4ebQgYNN9UyasT1iPll6nxa
	c+I=
X-Google-Smtp-Source: AGHT+IHFGBlwkyomkdGP+02MpVf0OmgYgkGJzmO0wXhaXnPevK+aEz3O3W5DnuNfHGv90uQYvqNSpuGSu7q/Lmv5aj8=
X-Received: by 2002:a05:6000:4202:b0:425:7346:d1b6 with SMTP id
 ffacd0b85a97d-42667177b78mr3443459f8f.17.1759975649815; Wed, 08 Oct 2025
 19:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com> <20251001011941.1513050-2-jasonmiu@google.com>
 <20251006141444.GN3360665@nvidia.com>
In-Reply-To: <20251006141444.GN3360665@nvidia.com>
From: Jason Miu <jasonmiu@google.com>
Date: Wed, 8 Oct 2025 19:07:18 -0700
X-Gm-Features: AS18NWB4PW66azTKpAtdJovUwEfqAjBAxqz9kEyCAdzq27GwUtBpfhjUIx6ym0g
Message-ID: <CAHN2nPKjg6=0QTcSoptxvQW9MpP0YwGUTx_gQDBxgCtSzxY5Pg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kho: Adopt KHO radix tree data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Thank you very much for your feedback again.

On Mon, Oct 6, 2025 at 7:14=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
> >  #define KHO_FDT_COMPATIBLE "kho-v1"
>
> We don't bump this?
Will do. Will be "kho-v2".

>
> > -#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
> > +#define PROP_PRESERVED_PAGE_RADIX_TREE "preserved-page-radix-tree"
> >  #define PROP_SUB_FDT "fdt"
>
> I'de really like to see all of these sorts of definitions in some
> structured ABI header not open coded all over the place..

Do you think `include/linux/kexec_handover.h` is the appropriate
place, or would you prefer a new, dedicated ABI header (e.g., in
`include/uapi/linux/`) for all KHO-related FDT constants?


>
> >   */
> > +struct kho_radix_tree {
> > +     unsigned long table[PAGE_SIZE / sizeof(unsigned long)];
>
> This should be phys_addr_t.
>
> > +};
>
> You dropped the macros so now we don't know these are actually
> pointers to 'struct kho_radix_tree'
>

Agreed. Will change `u64` according to Pasha's comment. And we use
explicit casts like `(u64)virt_to_phys(new_tree)` and `(struct
kho_radix_tree *)phys_to_virt(table_entry)` in the current series. I
believe this, along with the `u64` type, makes it clear that the table
stores physical addresses.


> > +static int kho_radix_tree_max_depth(void)
> > +{
> > +     int page_offset_bit_num =3D BITS_PER_LONG - PAGE_SHIFT;
> > +     int order_bit_num =3D ilog2(__roundup_pow_of_two(page_offset_bit_=
num));
> > +     int bitmap_bit_num =3D PAGE_SHIFT + ilog2(BITS_PER_BYTE);
> > +     int table_bit_num =3D ilog2(PAGE_SIZE / sizeof(unsigned long));
> > +     int table_level_num =3D DIV_ROUND_UP(page_offset_bit_num -
> > +                                        bitmap_bit_num + order_bit_num=
,
> > +                                        table_bit_num);
>
> All should be unsigned int. Below I suggest to put it in an enum and
> use different names.. And since the function is constant it can just
> be an enum TOP_LEVEL too.
>

Yes I did think of returning a const for `kho_radix_tree_max_depth()`.
I think using enums is a better idea and I can place all above values
as enums.


> > + */
> > +static unsigned long kho_radix_encode(unsigned long pa, unsigned int o=
rder)
>
> pa is phys_addr_t in the kernel, never unsigned long.
>
> If you want to make it all dynamic then this should be phys_addr_t

Should this also be `u64`, or we stay with `phys_addr_t` for all page
addresses?

>
> > +{
> > +     unsigned long h =3D 1UL << (BITS_PER_LONG - PAGE_SHIFT - order);
>
> And this BITS_PER_LONG is confused, it is BITS_PER_PHYS_ADDR_T which
> may not exist.
>
> Use an enum ORDER_0_LG2 maybe

I prefer `KHO_RADIX_ORDER_0_BIT_POS` (defined as `BITS_PER_LONG -
PAGE_SHIFT`) over `ORDER_0_LG2`, as I think the latter is a bit hard
to understand, what do you think? This constant, along with others,
will be placed in the enum.

>
> > +     unsigned long l =3D pa >> (PAGE_SHIFT + order);
> >
> > +     return h | l;
> > +}
> >
> > +static unsigned long kho_radix_decode(unsigned long encoded, unsigned =
int *order)
>
> Returns phys_addr_t
>
> >  {
> > -     void *elm, *res;
> > +     unsigned long order_bit =3D fls64(encoded);
>
> unsigned int
>
> > +     unsigned long pa;
>
> phys_addr_t
>
> > +     *order =3D BITS_PER_LONG - PAGE_SHIFT - order_bit + 1;
>
> ORDER_0_LG2
>
> > +     pa =3D encoded << (PAGE_SHIFT + *order);
>
> I'd add a comment that the shift always discards order.
>
> > +     return pa;
> > +}
> >
> > +static unsigned long kho_radix_get_index(unsigned long encoded, int le=
vel)
>
> unsigned int level
>
> > +{
> > +     int table_bit_num =3D ilog2(PAGE_SIZE / sizeof(unsigned long));
> > +     int bitmap_bit_num =3D PAGE_SHIFT + ilog2(BITS_PER_BYTE);
>
> Stick all the constants that kho_radix_tree_max_depth() are computing
> in an enum instead of recomputing them..
>
> > +     unsigned long mask;
> > +     int s;
>
> unsigned for all of these.
>
> > +
> > +     if (level =3D=3D 1) {
>
> I think the math is easier if level 0 =3D=3D bitmap..
>
> > +             s =3D 0;
> > +             mask =3D (1UL << bitmap_bit_num) - 1;
> > +     } else {
> > +             s =3D ((level - 2) * table_bit_num) + bitmap_bit_num;
>
> eg here you are doing level-2 which is a bit weird only because of the
> arbitary choice to make level=3D1 be the bitmap.
>
> I'd also use some different names
>
> table_bit_num =3D=3D TABLE_SIZE_LG2
> BITMAP_BIT_NUM =3D BITMAP_SIZE_LG2
>
> Log2 designates the value is 1<<LG2

Good point on the level numbering, we'll switch to 0-based where level
0 is the bitmap. The modulo operations you suggested play nicely with
the 0-based numbering too, thanks. Will also update the names and put
them in enum.
>
> > +             mask =3D (1UL << table_bit_num) - 1;
> >       }
> >
> > -     return elm;
> > +     return (encoded >> s) & mask;
>
> It is just:
>
> return encoded % (1 << BITMAP_SIZE_LG2);
> return (encoded >> s) % (1 << TABLE_SIZE_LG2);
>
> The compiler is smart enough to choose bit logic if that is the
> fastest option and the above is more readable.
>
> > +static int kho_radix_set_bitmap(struct kho_bitmap_table *bit_tlb, unsi=
gned long offset)
> >  {
> > +     if (!bit_tlb ||
> > +         offset >=3D PAGE_SIZE * BITS_PER_BYTE)
> > +             return -EINVAL;
> >
> > +     set_bit(offset, bit_tlb->bitmaps);
>
> set_bit is an atomic, you want __set_bit()
>
> > +     return 0;
> > +}
> >
> > +static int kho_radix_preserve_page(unsigned long pa, unsigned int orde=
r)
>
> phys_addr_t
>
> > +{
> > +     unsigned long encoded =3D kho_radix_encode(pa, order);
> > +     int num_tree_level =3D kho_radix_tree_max_depth();
>
> kho_radix_tree_max_depth() is constant, stick it in an enum with the
> rest of them.
>
> > +     struct kho_radix_tree *current_tree, *new_tree;
> > +     struct kho_bitmap_table *bitmap_table;
> > +     int err =3D 0;
> > +     int i, idx;
>
> various unsigned int.
>
> >
> > +     down_write(&kho_radix_tree_root_sem);
> >
> > +     current_tree =3D kho_radix_tree_root;
> >
> > +     /* Go from high levels to low levels */
> > +     for (i =3D num_tree_level; i >=3D 1; i--) {
> > +             idx =3D kho_radix_get_index(encoded, i);
> > +
> > +             if (i =3D=3D 1) {
> > +                     bitmap_table =3D (struct kho_bitmap_table *)curre=
nt_tree;
> > +                     err =3D kho_radix_set_bitmap(bitmap_table, idx);
> > +                     goto out;
> > +             }
> > +
> > +             if (!current_tree->table[idx]) {
> > +                     new_tree =3D kho_alloc_radix_tree();
> > +                     if (!new_tree) {
> > +                             err =3D -ENOMEM;
> > +                             goto out;
> > +                     }
> > +
> > +                     current_tree->table[idx] =3D
> > +                             (unsigned long)virt_to_phys(new_tree);
>
> current_tree =3D new_tree
> > +             }
>
> else
>
> > +
> > +             current_tree =3D (struct kho_radix_tree *)
> > +                     phys_to_virt(current_tree->table[idx]);
> >       }
> > +
> > +out:
> > +     up_write(&kho_radix_tree_root_sem);
> > +     return err;
> >  }
> >
> > +static int kho_radix_walk_bitmaps(struct kho_bitmap_table *bit_tlb,
> > +                               unsigned long offset,
>
> phys_addr_t
>
> > +                               kho_radix_tree_walk_callback_t cb)
> >  {
> > +     unsigned long encoded =3D offset << (PAGE_SHIFT + ilog2(BITS_PER_=
BYTE));
> > +     unsigned long *bitmap =3D (unsigned long *)bit_tlb;
> > +     int err =3D 0;
> > +     int i;
> >
> > +     for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
> > +             err =3D cb(encoded | i);
> > +             if (err)
> > +                     return err;
> > +     }
> >
> > +     return 0;
> > +}
> >
> > +static int kho_radix_walk_trees(struct kho_radix_tree *root, int level=
,
>
> unsigned int
>
> > +                             unsigned long offset,
>
> phys_addr_t.  I would call this start not offset..
>
> > +                             kho_radix_tree_walk_callback_t cb)
> > +{
> > +     int level_shift =3D ilog2(PAGE_SIZE / sizeof(unsigned long));
> > +     struct kho_radix_tree *next_tree;
> > +     unsigned long encoded, i;
> > +     int err =3D 0;
> >
> > +     if (level =3D=3D 1) {
> > +             encoded =3D offset;
> > +             return kho_radix_walk_bitmaps((struct kho_bitmap_table *)=
root,
> > +                                           encoded, cb);
>
> Better to do this in the caller  a few lines below

But the caller is in a different tree level? Should we only walk the
bitmaps at the lowest level?

>
> > +     }
>
> >
> > +     for (i =3D 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
> > +             if (root->table[i]) {
> > +                     encoded =3D offset << level_shift | i;
>
> This doesn't seem right..
>
> The argument to the walker should be the starting encoded of the table
> it is about to walk.
>
> Since everything always starts at 0 it should always be
>   start | (i << level_shift)
>
> ?

You're right that this line might not be immediately intuitive. The
var `level_shift` (which is constant value 9 here) is applied to the
*accumulated* `offset` from the parent level. Let's consider an
example of a preserved page at physical address `0x1000`, which
encodes to `0x10000000000001` (bit 52 is set for order 0, bit 0 is set
for page 1).

If we were to use `start | (i << level_shift)` where `level_shift` is
a constant 9, and `start` is the value from the parent call:
  - At Level 6, `start` is `0`. `i` is 2 as bit 51:59 =3D 2. Result: `0
| (2 << 9) =3D 0x400`. This is passed to Level 5.
  - At Level 5, `start` is `0x400`, `i` is 0 as bit 50:42 =3D 0. Result:
`0x400 | (0 << 9) =3D 0x400`. This is passed to Level 4.
  - At Level 4, `start` is `0x400`, `i` is 0 as bit 33:41 =3D 0. Result:
`0x400 | (0 << 9) =3D 0x400`. And so on.

As you can see, the encoded value is not correctly reconstructed. This
will work if the `level_shift` represents the total shift from the LSB
for each specific level, but it is not the case here.

I will, however, add a detailed comment to `kho_radix_walk_trees` to
clarify this logic. I also agree to change the name of `offset` to
make it more clearer, how about `base_encoded`, or do you still prefer
`start`?

>
> > +                     next_tree =3D (struct kho_radix_tree *)
> > +                             phys_to_virt(root->table[i]);
> > +                     err =3D kho_radix_walk_trees(next_tree, level - 1=
, encoded, cb);
> >                       if (err)
> >                               return err;
> >               }
> >       }
> >
> > +     return 0;
> > +}
> >
> > +static int kho_memblock_reserve(phys_addr_t pa, int order)
> > +{
> > +     int sz =3D 1 << (order + PAGE_SHIFT);
> > +     struct page *page =3D phys_to_page(pa);
> > +
> > +     memblock_reserve(pa, sz);
> > +     memblock_reserved_mark_noinit(pa, sz);
> > +     page->private =3D order;
> >
> >       return 0;
> >  }
> >
> > +static int kho_radix_walk_trees_callback(unsigned long encoded)
> > +{
> > +     unsigned int order;
> > +     unsigned long pa;
> > +
> > +     pa =3D kho_radix_decode(encoded, &order);
> > +
> > +     return kho_memblock_reserve(pa, order);
> > +}
> > +
> > +struct kho_serialization {
> > +     struct page *fdt;
> > +     struct list_head fdt_list;
> > +     struct dentry *sub_fdt_dir;
> > +};
> > +
> > +static int __kho_preserve_order(unsigned long pfn, unsigned int order)
> > +{
> > +     unsigned long pa =3D PFN_PHYS(pfn);
>
> phys_addr_t
>
> Jason

Will do the update in the next patch version. Thanks again.

--
Jason Miu

