Return-Path: <linux-kernel+bounces-874973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE305C17EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581841886FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85802DAFC7;
	Wed, 29 Oct 2025 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTC0B4ym"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189592DCBE3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701298; cv=none; b=rtrY4mMHQnto5IKx/ECAXHNxpW+km2dbthU9SwIeLE+vzHZu76k6GALAVdtZrvL2oLfNlSTJ7/2fK/LVl2hoKbKR1YhaGLiJnUCVUpqV25SBqdpDh1k4+WLfkjBdvsThhTi+SY7yMBcTDRTRu8wmxmeJ2W3qBRFMYwk/7UYG7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701298; c=relaxed/simple;
	bh=eRkVGT40E6hmlnm4Nhf9X/Lc1rYs8yQVaX3bg3LdNSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXlua+m0D3eEv6OVaVry0ZDEjPkCbdIw8SIjBsHDcwvn24jvn86hHSORyPNuHhY/8j0zTOmnNwHSPEdlhO9dCGfFekcPe3LIULi3FZS1T8wJASXVj+oreVCcvsd8SrI56e+8iH9M65Aj+h8aQQuPA4GU5b/7MWP2V3IqT7W0cb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lTC0B4ym; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471b80b994bso91286875e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761701294; x=1762306094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkMWjO1rSdAnohkJyNyWXb5OhMJ5uqLxrhrL1OkZrHQ=;
        b=lTC0B4ymspRlj91NQl9LVqrJLNR9JJA9ySa3nRLrDjYIh0udXwcKcNtEFJ1F1mhEWX
         Wzgyosa8Tvs7FrcBUZdVKPMMdQ32avEpopS0eAs8a4y77wvZ4m96bE1TQdiO4/4P/IX1
         4iH5MbDGe0P+zlO8OGlZ8bwWTe/u1jTQpEC+fGEdmj8PXMwVJc7JHSH4t2LoqExgmTfA
         wVmmvzxnxf+6OH+Bl1/vvTto09ONnAUgbSnOMp7v7yw/j/qKdNjyg3NAMR5Csyb4lZOr
         MkxZlNfCtQyMv8fg2X7yck202dt289+iD7tWZWa0PiAIG+lVSdjHZNHZ679oRLd8qdf3
         WySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761701294; x=1762306094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkMWjO1rSdAnohkJyNyWXb5OhMJ5uqLxrhrL1OkZrHQ=;
        b=kmlg6A2ZvYwJOoJb9tKsxKRKlZ4X5gYyGyrCgIlrO0TVTx+lpRZ0bVZ9OLcfA200Tk
         iIJaoLC2jRHIjXeMpLn9Q/CMXPVM35ii6Lh8Uju6UYewKJ8UPV840hWt7YLVmHQpVvES
         ib3aWcMWC2UoeZg/asaktbpmz1A5gtqQSbQoQj3LtHczP14W7C9qregVOiCC6hmtAYBp
         IqbMu3UagyLx1VYOq75eOOOnffL+f5Nhwm/2aSN4lyUtSa+PF5iNrx9nNR3m+IMb6ieP
         YRIhjratF9t5WkurNQv/ysH1O3kiNqkKHE/nWTGF9iHSZt445C3YtwMKfSr9r9kjZwTB
         cxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxHBtfm3DReiB/rpsL655+ITfiEd76dgw3n7KyAfkLPAvxEuSW5dHdNK/sXi3yT3Fg00hqpIJ0qp0pvV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNffFjCL++ssyIh1zsWpTk+Jnc/rmzGHCxWcAt50st+n0P1Cd
	4/kR7ZyEYXy7XDH84u5sRK7CJ0LhNxOW/daevhOh4AVdnqD7Irs6Go6H3zsZhCWRrB5qOpV47Q2
	smACiYM29eyvSqhV+1gJ4Dl9HyFrPCh7MQfmIZuUP
X-Gm-Gg: ASbGnctp18yIELOORgxSK2WJqhWIZpM15GeN5y6sErbp5KRlttGcndlR3s0wbE3LfPb
	bFYTZG7ox3y+8XiWqBOSuv6SySECHRpXf3/DDXyBNtRhK7R4XdlyjA1qvxMBVItCE2yZboI2mjI
	heGbOXvmOTs40vhhlJO/MhMXG3/QRw10ZUybd1L/tmzaY+SzWiXq4NVuIn4PBMwtclRMvHHw2Ma
	Wg9vwfpIRURbrqOr+Qx4u6XZ2jtHeIzfI291+5EsrqETBWt8aF3O+9+M5OJ6vd6KgI6jFXTVXj5
	D0xGBvM79PePPLA=
X-Google-Smtp-Source: AGHT+IG3KRiPIoob60XGXfb5m+5xbP/GP4YmXgJstFq9lCOwlcC3zoZDZB5x16vG8VyFsQPcmth6oAyMlVZsee0e+BM=
X-Received: by 2002:a05:600c:6384:b0:475:e007:baf2 with SMTP id
 5b1f17b1804b1-4771e1f5a1fmr8930625e9.41.1761701294081; Tue, 28 Oct 2025
 18:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com> <20251020100306.2709352-2-jasonmiu@google.com>
 <20251023174317.GO262900@nvidia.com>
In-Reply-To: <20251023174317.GO262900@nvidia.com>
From: Jason Miu <jasonmiu@google.com>
Date: Tue, 28 Oct 2025 18:28:02 -0700
X-Gm-Features: AWmQ_blKKmsXCeIJmd0P-TrVuYl0Tfsj5kSCFLMW2X0j-f70Ldi62zWKU78x_VA
Message-ID: <CAHN2nPKbxM5Bc9SDHHyvHbUPvsatMa6W59tXuVwfytxF7v+DRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:43=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Mon, Oct 20, 2025 at 03:03:04AM -0700, Jason Miu wrote:
> > - * Keep track of memory that is to be preserved across KHO.
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
> > + * |     Level 5       | (struct kho_radix_tree)
> > + * +-------------------+
> > + *   |
> > + *   v
> > + * +-------------------+
> > + * |     Level 4       | (struct kho_radix_tree)
> > + * +-------------------+
> > + *   |
> > + *   | ... (intermediate levels)
> > + *   |
> > + *   v
> > + * +-------------------+
> > + * |      Level 0      | (struct kho_bitmap_table)
> > + * +-------------------+
> >   *
> > - * The serializing side uses two levels of xarrays to manage chunks of=
 per-order
> > - * 512 byte bitmaps. For instance if PAGE_SIZE =3D 4096, the entire 1G=
 order of a
> > - * 1TB system would fit inside a single 512 byte bitmap. For order 0 a=
llocations
> > - * each bitmap will cover 16M of address space. Thus, for 16G of memor=
y at most
> > - * 512K of bitmap memory will be needed for order 0.
>
> I think it is valuable to preserve this justification for
> bitmaps. There was a lot of debate over bitmaps vs ranges and this is
> the advantage of bitmaps. It is a bit subtle..

Sure, I will update the description about using the bitmap, along with
the new values.


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
> > + * offset. This allows its order bit to be set at position 51,
> > + * i.e. shifting right, without conflicting with the page offset bits.
>
> This description is correct, but the diagram is misleading. Maybe like th=
is:
>
>  *  |0| ... 0 0 0 1          | pa >> (PAGE_SHIFT + 0)              |
>  *  |1| ... 0 0 0 0 1        | pa >> (PAGE_SHIFT + 1)              |
>  *  |2| ... 0 0 0 0 0 1      | pa >> (PAGE_SHIFT + 2)              |
>  [..]
>

I see, giving new examples makes the order bit positions more clearer.

>
> > + *
> > + * This design stores pages of all sizes (orders) in a single 6-level =
table.  It
> > + * efficiently shares lower table levels, especially due to common zer=
o top
> > + * address bits, allowing a single, efficient algorithm to manage all =
pages.
> > + */
> > +enum kho_radix_consts {
> > +     /* The bit position of a 0-order page, only supports 64bits syste=
m */
> > +     ORDER_0_LG2 =3D 64 - PAGE_SHIFT,
> > +     /* Bit number used for each level of tables */
> > +     TABLE_SIZE_LG2 =3D const_ilog2(PAGE_SIZE / sizeof(phys_addr_t)),
> > +     /* Bit number used for lowest level of bitmaps */
> > +     BITMAP_SIZE_LG2 =3D PAGE_SHIFT + const_ilog2(BITS_PER_BYTE),
>
> "bit number" is a bit confusing when using a lg2 terms..
>
>         /* Size of the table in kho_radix_tree, in lg2 */
>         TABLE_SIZE_LG2 =3D const_ilog2(PAGE_SIZE / sizeof(phys_addr_t))
>
>         /* Number of bits in the kho_bitmap_table, in lg2 */
>         BITMAP_SIZE_LG2 =3D const_ilog2(BITS_PER_BYTE * PAGE_SIZE)
>
> Then use the constants in the structs:
>
> struct kho_radix_tree {
>        phys_addr_t table[1 << TABLE_SIZE_LG2];
> };
> struct kho_bitmap_table {
>        unsigned long bitmaps[(1 << BITMAP_SIZE_LG2) / BITS_PER_LONG];
> };
>
> > -struct khoser_mem_chunk;
> > +static inline phys_addr_t kho_radix_tree_desc(struct kho_radix_tree *v=
a)
> > +{
> > +     return (phys_addr_t)virt_to_phys(va);
> > +}
>
> virt_to_phys already returns phys_addr_t ?
>
> > +static inline struct kho_radix_tree *kho_radix_tree(phys_addr_t desc)
> > +{
> > +     return (struct kho_radix_tree *)(phys_to_virt(desc));
> > +}
>
> phys_to_virt returns void *, no need for a cast
>

Yup, will update the types in both functions.

> > +static int kho_radix_set_bitmap(struct kho_bitmap_table *bit_tlb,
> > +                             unsigned long offset)
> > +{
> > +     if (!bit_tlb ||
> > +         offset >=3D PAGE_SIZE * BITS_PER_BYTE)
> > +             return -EINVAL;
>
> WARN_ON ? These are assertions aren't they?

Yes, will add an assertion here. Or should we use "BUG_ON"? As if this
error happened something is quite wrong and I do not think it is
recoverable.

>
> > +static int kho_radix_walk_trees(struct kho_radix_tree *root, unsigned =
int level,
> > +                             unsigned long start,
> > +                             kho_radix_tree_walk_callback_t cb)
> > +{
> > +     struct kho_radix_tree *next_tree;
> > +     struct kho_bitmap_table *bitmap_table;
> > +     unsigned long encoded, i;
> > +     unsigned int level_shift;
> > +     int err =3D 0;
> > +
> > +     for (i =3D 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
> > +             if (root->table[i]) {
>
>
> if (!root->table[i])
>    continue
>
> Remove a level of indentation here
>
> > +static int __kho_preserve_order(unsigned long pfn, unsigned int order)
> > +{
> > +     unsigned long pa =3D PFN_PHYS(pfn);
> > +
> > +     might_sleep();
> > +
> > +     return kho_radix_preserve_page(pa, order);
>
> might_sleep should be in kho_radix_preserve_page() ? The might should
> be placed around if statements that might avoid a sleep, and that is
> not in this function.
>

I got another feedback that we can merge the kho_radix_preserve_page()
__kho_preserve_order(), so the might_sleep() will be in the if
statements.

> >  static void __init kho_mem_deserialize(const void *fdt)
> >  {
> > +     struct kho_radix_tree *tree_root;
> >       const phys_addr_t *mem;
> >       int len;
> >
> > +     /* Retrieve the KHO radix tree from passed-in FDT. */
> > +     mem =3D fdt_getprop(fdt, 0, PROP_PRESERVED_PAGE_RADIX_TREE, &len)=
;
> >
> >       if (!mem || len !=3D sizeof(*mem)) {
> > +             pr_err("failed to get preserved KHO memory tree\n");
> >               return;
> >       }
> >
> > +     tree_root =3D *mem ?
> > +             (struct kho_radix_tree *)phys_to_virt(*mem) :
> > +             NULL;
> >
> > +     if (!tree_root)
> > +             return;
>
> Seems weird?
>
> if (!*mem)
>    return;
>
> tree_root =3D phys_to_virt(*mem)
> kho_radix_walk_trees(tree_root, TREE_MAX_DEPTH - 1, 0,
>                              kho_radix_walk_trees_memblock_callback);
>

Yup, this looks more natural, my mind was thinking to check tree_root.

>
> This is prettty good now, IMHO
>
> Jason

