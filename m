Return-Path: <linux-kernel+bounces-804303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B992EB4719D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDBC7A765B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB341EFF9B;
	Sat,  6 Sep 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="El5u/stt"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838661C5F10
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757170777; cv=none; b=dpA0trbP6tNZO7IdqQYzGsAt6S5atbt5PCfo+p9b2X5kM5Fw0ZSRiGRJnCAbpVo9lXxqWvmj65arKgP3hQL2XsBgYUNM+AI98OckG1b5vPUae6ljwcSSEQ5+znATwSdQ+W/Gc/D5GmwcKfI9ESja6xwHa3VOWsA7N37BqBvsNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757170777; c=relaxed/simple;
	bh=2v9/DXDD/+4X7+vidU0pz9XcqTdWx/6iaCOi/GuP3Jg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fJWvfyBzTLWJIBykkez7bT4MmXwTDUu5l/npdghX7ZW8jN9X4hw8rduc/PAPZJDN5NpTaSTMA5EAsknbWZwXQcJwt3gTPX9ssLF8va5mmdyNYh82wPOc4DEz0uDFNyNH4muH2K6shoQOWTB7Q27/1ztSEijbDKuFoudnX0p/Gco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=El5u/stt; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757170771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQvX6M/SCpwCBwbFUlxqcK5BetnvxrCVF4KsXyyyLn8=;
	b=El5u/stt/6KWufCnQB4xz+7QvpdTfvjNfSSY/a6Zq6PbLUvnrZ97iCdZrFgTJxaUFUy4wC
	qRg2QUSOCWzcq3ydn3KlgkUvlGCigfDZbQIPROfuTHm/Cb6k1m9dasXtNuQ5eyCSd+1FTD
	agcXorwi/XMcmbi8Z67R4Os88hjt4Jc=
Date: Sat, 06 Sep 2025 14:59:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <405f6c44b4214ff466743ed94d16cb2fbea1b7f3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/rmap: make num_children and num_active_vmas update in
 internally
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 riel@surriel.com, vbabka@suse.cz, harry.yoo@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <4ifsfk44so7ychuu57mkbhujjl4lh5bxt2ufdseskunxsle366@3p6oo7qulwef>
References: <20250905132019.18915-1-yajun.deng@linux.dev>
 <4ifsfk44so7ychuu57mkbhujjl4lh5bxt2ufdseskunxsle366@3p6oo7qulwef>
X-Migadu-Flow: FLOW_OUT

September 5, 2025 at 11:16 PM, "Liam R. Howlett" <Liam.Howlett@oracle.com=
 mailto:Liam.Howlett@oracle.com?to=3D%22Liam%20R.%20Howlett%22%20%3CLiam.=
Howlett%40oracle.com%3E > wrote:


>=20
>=20* Yajun Deng <yajun.deng@linux.dev> [250905 09:21]:
>=20
>=20>=20
>=20> If the anon_vma_alloc() is called, the num_children of the parent o=
f
> >  the anon_vma will be updated. But this operation occurs outside of
> >  anon_vma_alloc().
> >=20=20
>=20>  The num_active_vmas are also updated outside of anon_vma.
> >=20=20
>=20>  Pass the parent of anon_vma to the anon_vma_alloc() and update the
> >  num_children inside it.
> >=20=20
>=20>  Introduce anon_vma_attach() and anon_vma_detach() to update
> >  num_active_vmas with the anon_vma.
> >=20=20
>=20>  Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >  ---
> >  mm/rmap.c | 63 ++++++++++++++++++++++++++++-------------------------=
--
> >  1 file changed, 32 insertions(+), 31 deletions(-)
> >=20=20
>=20>  diff --git a/mm/rmap.c b/mm/rmap.c
> >  index 34333ae3bd80..2a28edfa5734 100644
> >  --- a/mm/rmap.c
> >  +++ b/mm/rmap.c
> >  @@ -86,15 +86,21 @@
> >  static struct kmem_cache *anon_vma_cachep;
> >  static struct kmem_cache *anon_vma_chain_cachep;
> >=20=20
>=20>  -static inline struct anon_vma *anon_vma_alloc(void)
> >  +static inline struct anon_vma *anon_vma_alloc(struct anon_vma *pare=
nt)
> >  {
> >  struct anon_vma *anon_vma;
> >=20=20
>=20>  anon_vma =3D kmem_cache_alloc(anon_vma_cachep, GFP_KERNEL);
> >  - if (anon_vma) {
> >  - atomic_set(&anon_vma->refcount, 1);
> >  - anon_vma->num_children =3D 0;
> >  - anon_vma->num_active_vmas =3D 0;
> >  + if (!anon_vma)
> >  + return NULL;
> >  +
> >  + atomic_set(&anon_vma->refcount, 1);
> >  + anon_vma->num_children =3D 0;
> >  + anon_vma->num_active_vmas =3D 0;
> >  + if (parent) {
> >  + anon_vma->parent =3D parent;
> >  + anon_vma->root =3D parent->root;
> >  + } else {
> >  anon_vma->parent =3D anon_vma;
> >  /*
> >  * Initialise the anon_vma root to point to itself. If called
> >  @@ -102,6 +108,7 @@ static inline struct anon_vma *anon_vma_alloc(vo=
id)
> >  */
> >  anon_vma->root =3D anon_vma;
> >  }
> >  + anon_vma->parent->num_children++;
> >=20=20
>=20>  return anon_vma;
> >  }
> >  @@ -146,6 +153,19 @@ static void anon_vma_chain_free(struct anon_vma=
_chain *anon_vma_chain)
> >  kmem_cache_free(anon_vma_chain_cachep, anon_vma_chain);
> >  }
> >=20=20
>=20>  +static inline void anon_vma_attach(struct vm_area_struct *vma,
> >  + struct anon_vma *anon_vma)
> >  +{
> >  + vma->anon_vma =3D anon_vma;
> >  + vma->anon_vma->num_active_vmas++;
> >  +}
> >  +
> >  +static inline void anon_vma_detach(struct vm_area_struct *vma)
> >  +{
> >  + vma->anon_vma->num_active_vmas--;
> >  + vma->anon_vma =3D NULL;
> >  +}
> >  +
> >=20
>=20It is a bit odd that you are setting a vma value with the prefix of
> anon_vma. Surely there is a better name: vma_attach_anon() ? And since
> this is editing the vma, should it be in rmap.c or vma.h?
>=20

I=20will move them to vma.h.
> >=20
>=20> static void anon_vma_chain_link(struct vm_area_struct *vma,
> >  struct anon_vma_chain *avc,
> >  struct anon_vma *anon_vma)
> >  @@ -198,10 +218,9 @@ int __anon_vma_prepare(struct vm_area_struct *v=
ma)
> >  anon_vma =3D find_mergeable_anon_vma(vma);
> >  allocated =3D NULL;
> >  if (!anon_vma) {
> >  - anon_vma =3D anon_vma_alloc();
> >  + anon_vma =3D anon_vma_alloc(NULL);
> >=20
>=20I don't love passing NULL for parent, it's two if statements to do th=
e
> same work as before - we already know that parent is NULL by this point=
,
> but we call a function to check it again.
>=20

I=20will add a wapper function.
> >=20
>=20> if (unlikely(!anon_vma))
> >  goto out_enomem_free_avc;
> >  - anon_vma->num_children++; /* self-parent link for new root */
> >  allocated =3D anon_vma;
> >  }
> >=20=20
>=20>  @@ -209,9 +228,8 @@ int __anon_vma_prepare(struct vm_area_struct *=
vma)
> >  /* page_table_lock to protect against threads */
> >  spin_lock(&mm->page_table_lock);
> >  if (likely(!vma->anon_vma)) {
> >  - vma->anon_vma =3D anon_vma;
> >  + anon_vma_attach(vma, anon_vma);
> >  anon_vma_chain_link(vma, avc, anon_vma);
> >  - anon_vma->num_active_vmas++;
> >  allocated =3D NULL;
> >  avc =3D NULL;
> >  }
> >  @@ -306,10 +324,8 @@ int anon_vma_clone(struct vm_area_struct *dst, =
struct vm_area_struct *src)
> >  if (!dst->anon_vma && src->anon_vma &&
> >  anon_vma->num_children < 2 &&
> >  anon_vma->num_active_vmas =3D=3D 0)
> >  - dst->anon_vma =3D anon_vma;
> >  + anon_vma_attach(dst, anon_vma);
> >  }
> >  - if (dst->anon_vma)
> >  - dst->anon_vma->num_active_vmas++;
> >  unlock_anon_vma_root(root);
> >  return 0;
> >=20
>=20anon_vma_clone() has a goto label of enomem_failure that needs to be
> handled correctly. Looks like you have to avoid zeroing dst before
> unlink_anon_vmas(vma) there.
>=20

Yes,=20it's an error.
> >=20
>=20> @@ -356,31 +372,22 @@ int anon_vma_fork(struct vm_area_struct *vma,=
 struct vm_area_struct *pvma)
> >  return 0;
> >=20=20
>=20>  /* Then add our own anon_vma. */
> >  - anon_vma =3D anon_vma_alloc();
> >  + anon_vma =3D anon_vma_alloc(pvma->anon_vma);
> >  if (!anon_vma)
> >  goto out_error;
> >  - anon_vma->num_active_vmas++;
> >  avc =3D anon_vma_chain_alloc(GFP_KERNEL);
> >  if (!avc)
> >  goto out_error_free_anon_vma;
> >=20
>=20At this point anon_vma has a parent set and the parent->num_children+=
+,
> but vma->anon_vma !=3D anon_vma yet. If avc fails here, we will put the
> anon_vma but leave the parent with num_children incremented, since
> unlink_anon_vmas() will not find anything.
>=20

Yes,=20it's an error.
> >=20
>=20> - /*
> >  - * The root anon_vma's rwsem is the lock actually used when we
> >  - * lock any of the anon_vmas in this anon_vma tree.
> >  - */
> >=20
>=20This information is lost when adding the parent passthrough.
>=20

I'll=20add it back.

> >=20
>=20> - anon_vma->root =3D pvma->anon_vma->root;
> >  - anon_vma->parent =3D pvma->anon_vma;
> >  /*
> >  * With refcounts, an anon_vma can stay around longer than the
> >  * process it belongs to. The root anon_vma needs to be pinned until
> >  * this anon_vma is freed, because the lock lives in the root.
> >  */
> >  get_anon_vma(anon_vma->root);
> >  - /* Mark this anon_vma as the one where our new (COWed) pages go. *=
/
> >  - vma->anon_vma =3D anon_vma;
> >  + anon_vma_attach(vma, anon_vma);
> >=20
>=20So now we are in the same situation, we know what we need to do with =
the
> parent, but we have to run through another if statement to get it to
> happen instead of assigning it.
>=20

Some=20code like it.
init_tg_rt_entry() has two callers. One has a parent, the other does not.

> >=20
>=20> anon_vma_lock_write(anon_vma);
> >  anon_vma_chain_link(vma, avc, anon_vma);
> >  - anon_vma->parent->num_children++;
> >  anon_vma_unlock_write(anon_vma);
> >=20=20
>=20>  return 0;
> >  @@ -419,15 +426,9 @@ void unlink_anon_vmas(struct vm_area_struct *vm=
a)
> >  list_del(&avc->same_vma);
> >  anon_vma_chain_free(avc);
> >  }
> >  - if (vma->anon_vma) {
> >  - vma->anon_vma->num_active_vmas--;
> >  + if (vma->anon_vma)
> >  + anon_vma_detach(vma);
> >=20=20
>=20>  - /*
> >  - * vma would still be needed after unlink, and anon_vma will be pre=
pared
> >  - * when handle fault.
> >  - */
> >=20
>=20It is still worth keeping the comment here too.
>=20

Okay.

>=20>=20
>=20> - vma->anon_vma =3D NULL;
> >  - }
> >  unlock_anon_vma_root(root);
> >=20=20
>=20>  /*
> >  --=20
>=20>  2.25.1
> >
>

