Return-Path: <linux-kernel+bounces-843273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 881D7BBECF2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B98B4ED3D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87823FC49;
	Mon,  6 Oct 2025 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="L//Ns0QQ"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CBA23F421
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771658; cv=none; b=Aj1z6N5jpUB3d60Jr/maiLJLYs87e2OB3n43zoBSe0WUQDsIawSEynVQ+4xvUB0/R7v0bwOMEfxgH27yf/nOpAGeMJpKJRv+uXDCkVsRIV85FEXVW71OZvNuk5A3BzXzblGuERtPrYX7NMIlkBlowrN5l+H9QFAgh4hJqExvxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771658; c=relaxed/simple;
	bh=r5IJc1+j8RKf+8RNQVOccDGTvfYzMYTB5nopUJb+tL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvRowtCZIEQu2kfM3YovDX3PlIyZeOS+3SG1GY6L7hyiGtpiVHOrvDcJkCnb62pzmmpGsXPzjfYEjyQ9xsZ7sMkYP4b/K8xAstR5M+rPHzMQVsBzLVpH2rftXcZt2LvQvSLzuSq8KMWgKTSIX+SIoJ2DHDnu0DzjmZhdxqdvKA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=L//Ns0QQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4d9f38478e0so52355151cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759771655; x=1760376455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ku0CTKpCW0+jCKseUl9YA3cobk32kED67HOsvkr/Nvw=;
        b=L//Ns0QQK4u1NqTMRNj2qbv4SYWmDdwVds6ms9fTo9BLHyw22T4a3+LhNfuvtFTlyL
         nHEnrgzhc5REWERdUt3Zc0zZ6leR1UR92ClgmTunMyk13Tk/qtTCrYARsqGLlDXfPG5f
         pu5fmMtTQf7RO0GeWsWJ/o50Kehhbma+M29ZQ80FaMDs7ND2AJ9hrzFGecSdxJahYts2
         IawNEPtp6QPki8LT4SX1UPsAjkkCtEcdqqJBjXP79epLNC0fzK1KxY9kE2XgFuBfJ2Ny
         RjjvtZLhowWUuid5KOmxj0/VxobiTCTPT+GUep4QefHmGC9jN0hCP1i0KNbsOUyYkg1k
         YY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771655; x=1760376455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ku0CTKpCW0+jCKseUl9YA3cobk32kED67HOsvkr/Nvw=;
        b=CLzPeQg3HuSFNMxp/z0dbjpZcEMMVEGesnSBClaxwuziT35tIJMxw0AV02/8UCFdjI
         EM55wJhlg7lPQmbKomBttKFGgIVKBVs7ZDy/N8CHA52xrZ0b1/r+O8KbtSncFiKwXsrY
         DR3/ilXeqoqgIdAp7uPS/3IJn3pR7GBjGSuSR6kbv4uzznvu7GIaDbwsK8rzILhEVByb
         UhWJ2o45Ucaa86BsrN88X3h5glogtXzS3Xb6RYttgtCfNLti401+K26bfRc3NMFfSk8F
         4933Yy8ZEKY1MqK+M5IREcWW/7z3yM0/TZm7Mj/23jG4qIpmjo1cDNXWKT8p45IL4v9e
         jtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKG+SLtlbXW1kx40YhV8eJrXKX//kX6XTCdr4aA/ltVp1cXoAIkmkfgPrH2TBX9yO+lXmJIkn/+HonX0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeixlTu+v/l+WpnCxpe3/aqXlpobkWPHBJSbnTwUlHe2Kz5G27
	G48dJkKTWj8OLwbOyDFy4TFRKBlP4b5fvBTlLtuhM1+xFHEqKS06W/lnnVJrJlgkzTQOu8BcMnY
	9GzTTjtFnEUGKUCcVJ9/cccIuCveT+4xWBYJzYPQElQ==
X-Gm-Gg: ASbGncutVJfAGgirU7Rng1pn9YyzkUp/4Hvqm9Bu/S11Akx8Ai/aj963C7HRImGrARM
	hLiOFhCS2UD5DIb2NOWAX+YHm+YV/3/foTniOVLQm0JVqMu0v6BgtIgJ0xhfSJfVm0sq5AP5td5
	5ycqhtIiZxR7fsJg7K+wOlrgjpXw7JXOZjYKbDU5bPcHJv7/vizxBPyTU/NdNjgXMtbzQtQu+X8
	mZvNv2IhxK6bAQnWxMAM+f+7kLBt+3ndF0DIL4=
X-Google-Smtp-Source: AGHT+IGjwaWmNcZg1BOGu3Lg22in3+tENKw0l6sBQmtPIPzfXbP/uKdYn+6Dbs6vJDK/UWx2hnc6bcJqDsmk/KFcfOE=
X-Received: by 2002:a05:622a:4a05:b0:4e4:d72d:69b2 with SMTP id
 d75a77b69052e-4e6de87d231mr5887871cf.24.1759771654434; Mon, 06 Oct 2025
 10:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com> <20251001011941.1513050-2-jasonmiu@google.com>
 <20251006141444.GN3360665@nvidia.com>
In-Reply-To: <20251006141444.GN3360665@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 6 Oct 2025 13:26:57 -0400
X-Gm-Features: AS18NWDfvI9sQ2V-f9FenduGtjBMq7JKIMo0f5LFRGNvBcQXIH9FiriSpPm5yuU
Message-ID: <CA+CK2bBaQEVySFcNmyQnWayZ7K=z5FxU7wTyNtmO7ja7NNGo3Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kho: Adopt KHO radix tree data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 10:14=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Sep 30, 2025 at 06:19:39PM -0700, Jason Miu wrote:
> > @@ -29,7 +30,7 @@
> >  #include "kexec_internal.h"
> >
> >  #define KHO_FDT_COMPATIBLE "kho-v1"
>
> We don't bump this?
>
> > -#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
> > +#define PROP_PRESERVED_PAGE_RADIX_TREE "preserved-page-radix-tree"
> >  #define PROP_SUB_FDT "fdt"
>
> I'de really like to see all of these sorts of definitions in some
> structured ABI header not open coded all over the place..
>
> >  /*
> > + * The KHO radix tree tracks preserved memory pages. It is a hierarchi=
cal
> > + * structure that starts with a single root `kho_radix_tree`. This sin=
gle
> > + * tree stores pages of all orders.
> > + *
> > + * This is achieved by encoding the page's physical address and its or=
der into
> > + * a single `unsigned long` value. This encoded value is then used to =
traverse
> > + * the tree.
> > + *
> > + * The tree hierarchy is shown below:
> > + *
> > + * kho_radix_tree_root
> > + * +-------------------+
> > + * |     Level 6       | (struct kho_radix_tree)
> > + * +-------------------+
> > + *   |
> > + *   v
> > + * +-------------------+
> > + * |     Level 5       | (struct kho_radix_tree)
> > + * +-------------------+
> > + *   |
> > + *   | ... (intermediate levels)
> > + *   |
> > + *   v
> > + * +-------------------+
> > + * |      Level 1      | (struct kho_bitmap_table)
> > + * +-------------------+
> > + *
> > + * The following diagram illustrates how the encoded value is split in=
to
> > + * indices for the tree levels:
> >   *
> > + *      63:60   59:51    50:42    41:33    32:24    23:15         14:0
> > + * +---------+--------+--------+--------+--------+--------+-----------=
------+
> > + * |    0    |  Lv 6  |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1 (bit=
map)  |
> > + * +---------+--------+--------+--------+--------+--------+-----------=
------+
> >   *
> > + * Each `kho_radix_tree` (Levels 2-6) and `kho_bitmap_table` (Level 1)=
 is
> > + * PAGE_SIZE. Each entry in a `kho_radix_tree` is a descriptor (a phys=
ical
> > + * address) pointing to the next level node. For Level 2 `kho_radix_tr=
ee`
> > + * nodes, these descriptors point to a `kho_bitmap_table`. The final
> > + * `kho_bitmap_table` is a bitmap where each set bit represents a sing=
le
> > + * preserved page.
>
> Maybe a note that this is example is for PAGE_SIZE=3D4k.
>
>
> >   */
> > +struct kho_radix_tree {
> > +     unsigned long table[PAGE_SIZE / sizeof(unsigned long)];
>
> This should be phys_addr_t.

Maybe u64 ? This is a preserved data, I would specify the size, and
not care about 32-bit arches. Also, if we ever have to support larger
physical spaces, this radix tree version would need to be bumped
anyway.

>
> > +};
>
> You dropped the macros so now we don't know these are actually
> pointers to 'struct kho_radix_tree'
>
> > +/*
> > + * `kho_radix_tree_root` points to a page thats serves as the root of =
the
> > + * KHO radix tree. This page is allocated during KHO module initializa=
tion.
> > + * Its physical address is written to the FDT and passed to the next k=
ernel
> > + * during kexec.
> > + */
> > +static struct kho_radix_tree *kho_radix_tree_root;
> > +static DECLARE_RWSEM(kho_radix_tree_root_sem);
> > +
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
> > +/*
> > + * The KHO radix tree tracks preserved pages by encoding a page's phys=
ical
> > + * address (pa) and its order into a single unsigned long value. This =
value
> > + * is then used to traverse the tree. The encoded value is composed of=
 two
> > + * parts: the 'order bits' in the upper part and the 'page offset' in =
the
> > + * lower part.
> > + *
> > + *   <-- Higher Bits ------------------------------------ Lower Bits -=
->
> > + *  +--------------------------+--------------------------------------=
---+
> > + *  |        Order Bits        |               Page Offset            =
   |
> > + *  +--------------------------+--------------------------------------=
---+
> > + *  | ... 0 0 1 0 0 ...        | pa >> (PAGE_SHIFT + order)           =
   |
> > + *  +--------------------------+--------------------------------------=
---+
> > + *            ^
> > + *            |
> > + *  This single '1' bit's position
> > + *  uniquely identifies the 'order'.
> > + *
> > + *
> > + * Page Offset:
> > + * The 'page offset' is the physical address normalized for its order.=
 It
> > + * effectively represents the page offset for the given order.
> > + *
> > + * Order Bits:
> > + * The 'order bits' encode the page order by setting a single bit at a
> > + * specific position. The position of this bit itself represents the o=
rder.
> > + *
> > + * For instance, on a 64-bit system with 4KB pages (PAGE_SHIFT =3D 12)=
, the
> > + * maximum range for a page offset (for order 0) is 52 bits (64 - 12).=
 This
> > + * offset occupies bits [0-51]. For order 0, the order bit is set at
> > + * position 52.
> > + *
> > + * As the order increases, the number of bits required for the 'page o=
ffset'
> > + * decreases. For example, order 1 requires one less bit for its page
> > + * offset. This allows its order bit to be set at position 51 without
> > + * conflicting with the page offset bits.
> > + *
> > + * This scheme ensures that the single order bit is always in a higher
> > + * position than any bit used by the page offset for that same order,
> > + * preventing collisions.
>
> Should explain why it is like this:
>
> This scheme allows storing all the multi-order page sizes in a single
> 6 level table with a good sharing of lower tables levels for 0 top
> address bits. A single algorithm can efficiently process everything.
>
> > + */
> > +static unsigned long kho_radix_encode(unsigned long pa, unsigned int o=
rder)
>
> pa is phys_addr_t in the kernel, never unsigned long.
>
> If you want to make it all dynamic then this should be phys_addr_t
>
> > +{
> > +     unsigned long h =3D 1UL << (BITS_PER_LONG - PAGE_SHIFT - order);
>
> And this BITS_PER_LONG is confused, it is BITS_PER_PHYS_ADDR_T which
> may not exist.
>
> Use an enum ORDER_0_LG2 maybe
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

