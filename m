Return-Path: <linux-kernel+bounces-627052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BDAA4AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 14:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267BE1C0739B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2021120C00C;
	Wed, 30 Apr 2025 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eotCkBgf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87725A2CF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014784; cv=none; b=XxUEiDcgXHWXiMnjTRGgaXN+jVC+rusfNsps18vIXjM56oQhyXo9OS4dB/q2oQWQbPQBTEdI7A7RixRUywwFL752W0tQjyJgYw5o1EtNWjLYegUHCLpQpzfNntpyf38770g896wrNZqmTqlCTubt/Sz4cMuupgXMbaHjeKZePZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014784; c=relaxed/simple;
	bh=a6RinYcb/aD0Hpy2iqfdEdvnwNQuxx/phQ3MZMM9Zyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUAz8jAEiovlfBODojkHJDXw7MkV1Run38rR4oKm7vT5O0DwATGpEeKdi/Wvdqqxom0EqDAwaPkcMEacvGqDnQF24JCrleuZtrw3i+gdoE01RgjkfP8bAC+jv88aLHOFdKuer11SwEQAca+gby/JiB+zrEs5qnUdbIoEwpC3cjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eotCkBgf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac7bd86f637so163582066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746014779; x=1746619579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ums389MIjLkJpJBvQUZ9Jlb75Ou3ktiWaf0gQqUjK+I=;
        b=eotCkBgflW9wYI552R0y4BGlY5QsGS7RIx8qnCXQKJt5MffKV7cWkIe/HU9Dt7yt+r
         XUlgXBZFN4tws+XJWiJ+t0MW9bsmh+eTT36a9WYuqo3uwwUtlcEkKPQKhOR9B30bEb+n
         d0EfSoXEiJR/J+Icmjzq4KxlIP3MVbVxXY3ziw7/tqOV/JkYbuA/UrpkMTeHjzQD9k5z
         irQIbD86CAXT7DJJkgu5LINXdeBLC1fkFpUNKLWxDO5s8GCQeKzlHrO/+sC8K+gW+7Oo
         PH7QbF0Ukj+dvSWRIpmTrRgPNoHkqizcJQI30+0En76JNrjyCOorj+UHevpHT5DlEckc
         drlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746014779; x=1746619579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ums389MIjLkJpJBvQUZ9Jlb75Ou3ktiWaf0gQqUjK+I=;
        b=wmLZhM4PYvW2H4OSKmqqFVelnpRK6ZcR589mAUWv+cn5dASBPgF2qAgX6GqTSi+A4W
         yxjRQ6qJzRWjf8yy42gyAGkhtYJwCLu9pC+6Upg29zmKVq1YSZ35vfG4fBCuslTFABvR
         tKEuQMEfoRKlC8SJZeYbJ+ONFyKVWECI1GZObrgAAXD21djoHo5UiLgeehlFvyancRtA
         aOtQwq0TrVcQrctVjNw3QY18DPa3HLZ+cYaIxAfI+pOXODMvKPbqX7nim8JS5GjmBUtd
         nJl6QgyLDnm/pLY4sUO/rXDpuW9O8y8p32b9nSESOvfOynkGBPN1pYNmC0Rbl1aF/bqY
         Jc+g==
X-Forwarded-Encrypted: i=1; AJvYcCUZq8XABli2C6qbm8Tlwui95jo/p9BQPGnY1o73B2/HdYuDfsCxdhIs/k4cdddgPiUVVzdfsw4UPYgBjwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMVCHAbbOnhHqqlbFLbnT0SEqUVHSOSKGokhPvfr0G8gkBxyUa
	rRp+BSMpUigl0jQ8cnvuaVYkni1LUNNpLPjBS98V9a70oNI0OsU/mJK1j5Q8PDlkbSLY31ffzER
	tifQFfdLI2YXFkrB4Uv1Tee4qd05Jpcx/8ig50w==
X-Gm-Gg: ASbGncsjiv5uWx7yHm91VNt5aciAhJK6Pq0cUi8jQ/Xgrd0Tc0MkPS0SzlGTACGK4Z/
	/28HgaejgWVSj3NrEIdVpEUuyvmQbXIgW5xUc9yKCU7iEfACS7ciVjsfVoJ5PCHUm+YT8yxIRyJ
	ZWA2Zs6Fqv13WV0/Tvo1LI
X-Google-Smtp-Source: AGHT+IEU8jqT3+j4wcj73QsVqGpumC0aUkMyJjurYEs8WmO5pZ+5hdq1DauwbWHj7632d0ufaYcJqLu9SP4Vnh+/Ozw=
X-Received: by 2002:a17:906:6a1e:b0:ace:8176:9870 with SMTP id
 a640c23a62f3a-acedf68d357mr233700766b.9.1746014778858; Wed, 30 Apr 2025
 05:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com> <CAL3q7H7WPE+26v1uCKa5C=BwcGpUN3OjnaPUkexPGD=mpJbkSA@mail.gmail.com>
 <CAPjX3FevwHRzyHzgLjcZ8reHtJ3isw3eREYrMvNCPLMDR=NJ4g@mail.gmail.com>
 <CAL3q7H56LC5ro+oshGaVVCV9Gvxfnz4dLaq6bwVW=t0P=tLUCg@mail.gmail.com>
 <CAPjX3Fe3BZ8OB2ZVMn58pY5E9k9j=uNAmuqM4R1tO=sPvx7-pA@mail.gmail.com> <CAL3q7H5Bzvew9kGXBRLJNtZm+0_eMOyrgUvC1ZK544DunAPEsA@mail.gmail.com>
In-Reply-To: <CAL3q7H5Bzvew9kGXBRLJNtZm+0_eMOyrgUvC1ZK544DunAPEsA@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 30 Apr 2025 14:06:04 +0200
X-Gm-Features: ATxdqUGwuekFqy3-4xLqyC_YqBdOWD-45QVgTcFSy-apTOtK6oLj6F5Vcwyy1Y0
Message-ID: <CAPjX3FcDrr7D7nwh3=fyyOCxnp0iv+jeyPcGRX+gpw9zGHJ3vA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: Filipe Manana <fdmanana@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 at 12:26, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Wed, Apr 30, 2025 at 9:50=E2=80=AFAM Daniel Vacek <neelx@suse.com> wro=
te:
> >
> > On Wed, 30 Apr 2025 at 10:34, Filipe Manana <fdmanana@kernel.org> wrote=
:
> > >
> > > On Wed, Apr 30, 2025 at 9:26=E2=80=AFAM Daniel Vacek <neelx@suse.com>=
 wrote:
> > > >
> > > > On Wed, 30 Apr 2025 at 10:06, Filipe Manana <fdmanana@kernel.org> w=
rote:
> > > > >
> > > > > On Tue, Apr 29, 2025 at 4:19=E2=80=AFPM Daniel Vacek <neelx@suse.=
com> wrote:
> > > > > >
> > > > > > Even super block nowadays uses nodesize for eb->len. This is si=
nce commits
> > > > > >
> > > > > > 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buf=
fer()")
> > > > > > da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root=
 and into fs_info")
> > > > > > ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer=
")
> > > > > > a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_cr=
eate_tree_block")
> > > > > >
> > > > > > With these the eb->len is not really useful anymore. Let's use =
the nodesize
> > > > > > directly where applicable.
> > > > > >
> > > > > > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > > > > > ---
> > > > > > [RFC]
> > > > > >  * Shall the eb_len() helper better be called eb_nodesize()? Or=
 even rather
> > > > > >    opencoded and not used at all?
...
> > > > > > +static inline u32 eb_len(const struct extent_buffer *eb)
> > > > > > +{
> > > > > > +       return eb->fs_info->nodesize;
> > > > > > +}
> > > > >
> > > > > Please always add a "btrfs_" prefix to the name of exported funct=
ions.
> > > >
> > > > It's static inline, not exported. But I'm happy just opencoding it
> > > > instead. Thanks.
> > >
> > > Exported in the sense that it's in a header and visible to any C file=
s
> > > that include it, not in the sense of being exported with
> > > EXPORT_SYMBOL_GPL() for example.
> > > This is our coding style convention:
> > >
> > > https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#fun=
ction-declarations
> > >
> > > static functions inside a C file can omit the prefix.
> >
> > Nah, thanks again. I was not aware of that. Will keep it in mind.
> >
> > Still, it doesn't make sense to me to be honest. I mean specifically
> > with this example. The header file is also private to btrfs, no public
> > API. Personally I wouldn't differentiate if it's a source or a header
> > file. The code can be freely moved around. And with the prefix the
> > code would end up more bloated and less readable, IMO. But let's not
> > start any flamewars here.
>
> I'd disagree about less readability. Reading code that calls a
> function with the btrfs prefix makes it clear it's a btrfs specific
> function.
> Looking at ext4 and xfs, functions declared or defined in their
> headers have a "ext4_", "ext_" or "xfs_" prefix.

I see. Makes sense.
Does this also apply to preprocessor macros? I don't see them
mentioned in the development notes.
I'm asking as I did consider using a macro which would look a bit
cleaner perhaps, just one line instead of four. But it would also miss
the type checking.
So I guess the naming convention should also apply to macros, right?

Finally quickly checking I see a lot of functions like eg.
free_extent_buffer(), free_extent_buffer_stale() and many others
violating the rule. I guess we should also clean up and rename them,
right?

> > > > > In this case I don't think adding this helper adds any value.
> > > > > We can just do eb->fs_info->nodesize everywhere and in some place=
s we
> > > > > already have fs_info in a local variable and can just do
> > > > > fs_info->nodesize.
> > > > >
> > > > > Thanks.
> > > > >
> > > > > > +
> > > > > >  /* Note: this can be used in for loops without caching the val=
ue in a variable. */
> > > > > >  static inline int __pure num_extent_pages(const struct extent_=
buffer *eb)
> > > > > >  {
> > > > > >         /*
> > > > > >          * For sectorsize =3D=3D PAGE_SIZE case, since nodesize=
 is always aligned to
> > > > > > -        * sectorsize, it's just eb->len >> PAGE_SHIFT.
> > > > > > +        * sectorsize, it's just nodesize >> PAGE_SHIFT.
> > > > > >          *
> > > > > >          * For sectorsize < PAGE_SIZE case, we could have nodes=
ize < PAGE_SIZE,
> > > > > >          * thus have to ensure we get at least one page.
> > > > > >          */
> > > > > > -       return (eb->len >> PAGE_SHIFT) ?: 1;
> > > > > > +       return (eb_len(eb) >> PAGE_SHIFT) ?: 1;
> > > > > >  }
> > > > > >
> > > > > >  /*
> > > > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > > > index 68fac77fb95d1..6be2d56d44917 100644
> > > > > > --- a/fs/btrfs/ioctl.c
> > > > > > +++ b/fs/btrfs/ioctl.c
> > > > > > @@ -598,7 +598,7 @@ static noinline int create_subvol(struct mn=
t_idmap *idmap,
> > > > > >         btrfs_set_root_generation(root_item, trans->transid);
> > > > > >         btrfs_set_root_level(root_item, 0);
> > > > > >         btrfs_set_root_refs(root_item, 1);
> > > > > > -       btrfs_set_root_used(root_item, leaf->len);
> > > > > > +       btrfs_set_root_used(root_item, fs_info->nodesize);
> > > > > >         btrfs_set_root_last_snapshot(root_item, 0);
> > > > > >
> > > > > >         btrfs_set_root_generation_v2(root_item,
> > > > > > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > > > > > index 6287e71ebad5f..5086485a4ae21 100644
> > > > > > --- a/fs/btrfs/relocation.c
> > > > > > +++ b/fs/btrfs/relocation.c
> > > > > > @@ -4352,7 +4352,7 @@ int btrfs_reloc_cow_block(struct btrfs_tr=
ans_handle *trans,
> > > > > >                         mark_block_processed(rc, node);
> > > > > >
> > > > > >                 if (first_cow && level > 0)
> > > > > > -                       rc->nodes_relocated +=3D buf->len;
> > > > > > +                       rc->nodes_relocated +=3D fs_info->nodes=
ize;
> > > > > >         }
> > > > > >
> > > > > >         if (level =3D=3D 0 && first_cow && rc->stage =3D=3D UPD=
ATE_DATA_PTRS)
> > > > > > diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> > > > > > index d4f0192334936..711792f32e9ce 100644
> > > > > > --- a/fs/btrfs/subpage.c
> > > > > > +++ b/fs/btrfs/subpage.c
> > > > > > @@ -631,7 +631,7 @@ void btrfs_meta_folio_set_##name(struct fol=
io *folio, const struct extent_buffer
> > > > > >                 folio_set_func(folio);                         =
         \
> > > > > >                 return;                                        =
         \
> > > > > >         }                                                      =
         \
> > > > > > -       btrfs_subpage_set_##name(eb->fs_info, folio, eb->start,=
 eb->len); \
> > > > > > +       btrfs_subpage_set_##name(eb->fs_info, folio, eb->start,=
 eb_len(eb)); \
> > > > > >  }                                                             =
         \
> > > > > >  void btrfs_meta_folio_clear_##name(struct folio *folio, const =
struct extent_buffer *eb) \
> > > > > >  {                                                             =
         \
> > > > > > @@ -639,13 +639,13 @@ void btrfs_meta_folio_clear_##name(struct=
 folio *folio, const struct extent_buff
> > > > > >                 folio_clear_func(folio);                       =
         \
> > > > > >                 return;                                        =
         \
> > > > > >         }                                                      =
         \
> > > > > > -       btrfs_subpage_clear_##name(eb->fs_info, folio, eb->star=
t, eb->len); \
> > > > > > +       btrfs_subpage_clear_##name(eb->fs_info, folio, eb->star=
t, eb_len(eb)); \
> > > > > >  }                                                             =
         \
> > > > > >  bool btrfs_meta_folio_test_##name(struct folio *folio, const s=
truct extent_buffer *eb) \
> > > > > >  {                                                             =
         \
> > > > > >         if (!btrfs_meta_is_subpage(eb->fs_info))               =
         \
> > > > > >                 return folio_test_func(folio);                 =
         \
> > > > > > -       return btrfs_subpage_test_##name(eb->fs_info, folio, eb=
->start, eb->len); \
> > > > > > +       return btrfs_subpage_test_##name(eb->fs_info, folio, eb=
->start, eb_len(eb)); \
> > > > > >  }
> > > > > >  IMPLEMENT_BTRFS_PAGE_OPS(uptodate, folio_mark_uptodate, folio_=
clear_uptodate,
> > > > > >                          folio_test_uptodate);
> > > > > > @@ -765,7 +765,7 @@ bool btrfs_meta_folio_clear_and_test_dirty(=
struct folio *folio, const struct ext
> > > > > >                 return true;
> > > > > >         }
> > > > > >
> > > > > > -       last =3D btrfs_subpage_clear_and_test_dirty(eb->fs_info=
, folio, eb->start, eb->len);
> > > > > > +       last =3D btrfs_subpage_clear_and_test_dirty(eb->fs_info=
, folio, eb->start, eb_len(eb));
> > > > > >         if (last) {
> > > > > >                 folio_clear_dirty_for_io(folio);
> > > > > >                 return true;
> > > > > > diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/=
extent-io-tests.c
> > > > > > index 00da54f0164c9..657f8f1d9263e 100644
> > > > > > --- a/fs/btrfs/tests/extent-io-tests.c
> > > > > > +++ b/fs/btrfs/tests/extent-io-tests.c
> > > > > > @@ -342,7 +342,7 @@ static int check_eb_bitmap(unsigned long *b=
itmap, struct extent_buffer *eb)
> > > > > >  {
> > > > > >         unsigned long i;
> > > > > >
> > > > > > -       for (i =3D 0; i < eb->len * BITS_PER_BYTE; i++) {
> > > > > > +       for (i =3D 0; i < eb_len(eb) * BITS_PER_BYTE; i++) {
> > > > > >                 int bit, bit1;
> > > > > >
> > > > > >                 bit =3D !!test_bit(i, bitmap);
> > > > > > @@ -411,7 +411,7 @@ static int test_bitmap_clear(const char *na=
me, unsigned long *bitmap,
> > > > > >  static int __test_eb_bitmaps(unsigned long *bitmap, struct ext=
ent_buffer *eb)
> > > > > >  {
> > > > > >         unsigned long i, j;
> > > > > > -       unsigned long byte_len =3D eb->len;
> > > > > > +       unsigned long byte_len =3D eb_len(eb);
> > > > > >         u32 x;
> > > > > >         int ret;
> > > > > >
> > > > > > @@ -670,7 +670,7 @@ static int test_find_first_clear_extent_bit=
(void)
> > > > > >  static void dump_eb_and_memory_contents(struct extent_buffer *=
eb, void *memory,
> > > > > >                                         const char *test_name)
> > > > > >  {
> > > > > > -       for (int i =3D 0; i < eb->len; i++) {
> > > > > > +       for (int i =3D 0; i < eb_len(eb); i++) {
> > > > > >                 struct page *page =3D folio_page(eb->folios[i >=
> PAGE_SHIFT], 0);
> > > > > >                 void *addr =3D page_address(page) + offset_in_p=
age(i);
> > > > > >
> > > > > > @@ -686,7 +686,7 @@ static void dump_eb_and_memory_contents(str=
uct extent_buffer *eb, void *memory,
> > > > > >  static int verify_eb_and_memory(struct extent_buffer *eb, void=
 *memory,
> > > > > >                                 const char *test_name)
> > > > > >  {
> > > > > > -       for (int i =3D 0; i < (eb->len >> PAGE_SHIFT); i++) {
> > > > > > +       for (int i =3D 0; i < (eb_len(eb) >> PAGE_SHIFT); i++) =
{
> > > > > >                 void *eb_addr =3D folio_address(eb->folios[i]);
> > > > > >
> > > > > >                 if (memcmp(memory + (i << PAGE_SHIFT), eb_addr,=
 PAGE_SIZE) !=3D 0) {
> > > > > > @@ -703,8 +703,8 @@ static int verify_eb_and_memory(struct exte=
nt_buffer *eb, void *memory,
> > > > > >   */
> > > > > >  static void init_eb_and_memory(struct extent_buffer *eb, void =
*memory)
> > > > > >  {
> > > > > > -       get_random_bytes(memory, eb->len);
> > > > > > -       write_extent_buffer(eb, memory, 0, eb->len);
> > > > > > +       get_random_bytes(memory, eb_len(eb));
> > > > > > +       write_extent_buffer(eb, memory, 0, eb_len(eb));
> > > > > >  }
> > > > > >
> > > > > >  static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
> > > > > > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > > > > > index 9d42bf2bfd746..c7a8cdd87c509 100644
> > > > > > --- a/fs/btrfs/zoned.c
> > > > > > +++ b/fs/btrfs/zoned.c
> > > > > > @@ -2422,7 +2422,7 @@ void btrfs_schedule_zone_finish_bg(struct=
 btrfs_block_group *bg,
> > > > > >                                    struct extent_buffer *eb)
> > > > > >  {
> > > > > >         if (!test_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &bg->ru=
ntime_flags) ||
> > > > > > -           eb->start + eb->len * 2 <=3D bg->start + bg->zone_c=
apacity)
> > > > > > +           eb->start + eb_len(eb) * 2 <=3D bg->start + bg->zon=
e_capacity)
> > > > > >                 return;
> > > > > >
> > > > > >         if (WARN_ON(bg->zone_finish_work.func =3D=3D btrfs_zone=
_finish_endio_workfn)) {
> > > > > > --
> > > > > > 2.47.2
> > > > > >
> > > > > >

