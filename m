Return-Path: <linux-kernel+bounces-804299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD995B47170
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1055A5454
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14E51E1E0B;
	Sat,  6 Sep 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YdCAu5ID"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89933DF49
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757170224; cv=none; b=rW7wsI2bgEiQ7NBfvzsqopD/mGheEjfa+m9Txw/+hgMIOyOvoVLRAOVjG/m19ECVre37dtnED2uEKMStE3l9dpAwu6/u6Sb2yXinrPhjKhrRC5U8K7MAlN0rpV6A1q6lHLMFp6p1IiMhbVcnVIRQoQSet7gRaMQY3ccjqLh5FHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757170224; c=relaxed/simple;
	bh=aHmqBSoIpU/EzAYMgOPd9azQQt5AWWSUheOENOEHPWs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=FnnypYpjZpNX1v5e68op/cnpVg0kt9I5fyRowsn+qxnkoD/XCLu+SGwSat8Ql7WxgGVximoNz9mDGUMY/tKj+4rM6j7HU0HLXnPR2KW+2qYaa72+UthWV4t+9sMlapBQy4E8xXtvKspprPc9Tf4ZVXIYuRicp6UPhYIlF/ULNb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YdCAu5ID; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757170219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Lrv+sHhSx9IhB2Mvksz3YeztAf/sFlnmhfbQojpIKI=;
	b=YdCAu5ID/S4OoTu66vju8cL4JPzfhv4Isi7CgyVnZYk0pVCkleNJewHEr6LZZHZyhRRCmk
	vtNj0xEMHLKCTnP+987/ZGaKhODKWMixGX2JgP3/sBVP5TP+1EuQ1yIiZWQWkm/HRXUuHi
	q97xT+Vs42eRpT3qRWnmMEe5RCdJ+9o=
Date: Sat, 06 Sep 2025 14:50:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <71a4ba4d4bdf8cb1803b3907f812821792d86391@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/rmap: make num_children and num_active_vmas update in
 internally
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <7c0101ac-afac-4601-8be9-24587877a5e3@lucifer.local>
References: <20250905132019.18915-1-yajun.deng@linux.dev>
 <7c0101ac-afac-4601-8be9-24587877a5e3@lucifer.local>
X-Migadu-Flow: FLOW_OUT

September 5, 2025 at 10:58 PM, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.=
com mailto:lorenzo.stoakes@oracle.com?to=3D%22Lorenzo%20Stoakes%22%20%3Cl=
orenzo.stoakes%40oracle.com%3E > wrote:


>=20
>=20On Fri, Sep 05, 2025 at 01:20:19PM +0000, Yajun Deng wrote:
>=20
>=20>=20
>=20> If the anon_vma_alloc() is called, the num_children of the parent o=
f
> >  the anon_vma will be updated. But this operation occurs outside of
> >  anon_vma_alloc().
> >=20
>=20I don't like that what is supposed to be an allocation function is no=
w also
> doing additional work.
>=20
>=20And there's literally only one place where this matters, since
> __anon_vma_prepare() doesn't have a parent, it's ltierally only anon_vm=
a_fork().
>=20
>=20And there are only 2 callers, so I don't see the purpose in doing thi=
s?
>=20

Yes,=20it is an allocation function. Some code doing like it.
alloc_fair_sched_group() and alloc_rt_sched_group() are allocation functi=
ons.
They are also pass the parent parameter to them.

The purpose of this is to unify the code. They are essentially the same.
One has itself as its parent, while another has a real parent.

> >=20
>=20> The num_active_vmas are also updated outside of anon_vma.
> >=20
>=20I don't know what 'outside of anon_vma' means?
>=20
It=20means num_active_vmas should be updated in a function.

> >=20
>=20> Pass the parent of anon_vma to the anon_vma_alloc() and update the
> >  num_children inside it.
> >=20
>=20>  Introduce anon_vma_attach() and anon_vma_detach() to update
> >  num_active_vmas with the anon_vma.
> >=20
>=20I really dislike this naming - VMA detachment means something entirel=
y
> different, you're not really 'attaching' or 'detaching' anything you're=
 just
> changing a single stat of the ones you'd need to change were you truly =
doing so
> etc. etc.
>=20
>=20It's misleading.
>=20

I=20will use vma_attach_anon() and vma_detach_anon().

> > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >=20
>=20Did you test this at all? It causes an immediate kernel panic for me =
when I run
> it in a VM:
>=20
>=20In exit_mmap() -> free->pgtables() -> unlink_anon_vmas()
>=20
>=20I haven't really dug into why but yeah, this is broken.
>=20

I=20will fix it.

> >=20
>=20> ---
> >  mm/rmap.c | 63 ++++++++++++++++++++++++++++-------------------------=
--
> >  1 file changed, 32 insertions(+), 31 deletions(-)
> >=20
>=20>  diff --git a/mm/rmap.c b/mm/rmap.c
> >  index 34333ae3bd80..2a28edfa5734 100644
> >  --- a/mm/rmap.c
> >  +++ b/mm/rmap.c
> >  @@ -86,15 +86,21 @@
> >  static struct kmem_cache *anon_vma_cachep;
> >  static struct kmem_cache *anon_vma_chain_cachep;
> >=20
>=20>  -static inline struct anon_vma *anon_vma_alloc(void)
> >  +static inline struct anon_vma *anon_vma_alloc(struct anon_vma *pare=
nt)
> >=20
>=20I really dislike this, we only allocate with a parent in the fork cas=
e, this is
> just not a win imo + adds confusion.
>

I will add a wapper function.
=20
>=20>=20
>=20> {
> >  struct anon_vma *anon_vma;
> >=20
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
> >=20
>=20You are accessing parent fields without a lock. This is not good.
>=20
>=20>=20
>=20> + } else {
> >  anon_vma->parent =3D anon_vma;
> >  /*
> >  * Initialise the anon_vma root to point to itself. If called
> >  @@ -102,6 +108,7 @@ static inline struct anon_vma *anon_vma_alloc(vo=
id)
> >  */
> >  anon_vma->root =3D anon_vma;
> >  }
> >  + anon_vma->parent->num_children++;
> >=20
>=20This is even even even more not good, because you're accessing the pa=
rent
> without a lock, which is just completely broken.
>=20
>=20I note below where you're doing this.
>=20

I=20will add anon_vma_lock_write() and anon_vma_unlock_write().
> >=20
>=20> return anon_vma;
> >  }
> >  @@ -146,6 +153,19 @@ static void anon_vma_chain_free(struct anon_vma=
_chain *anon_vma_chain)
> >  kmem_cache_free(anon_vma_chain_cachep, anon_vma_chain);
> >  }
> >=20
>=20>  +static inline void anon_vma_attach(struct vm_area_struct *vma,
> >  + struct anon_vma *anon_vma)
> >  +{
> >  + vma->anon_vma =3D anon_vma;
> >  + vma->anon_vma->num_active_vmas++;
> >  +}
> >=20
>=20Yeah I hate the naming, you should have lock asserts here, I don't lo=
ve that
> we're pairing the vma and anon_vma like this, and again I just really q=
uestion
> the value of this.
>=20
anon_vma_chain_link()=20also didn't have lock assert.

> >=20
>=20> +
> >  +static inline void anon_vma_detach(struct vm_area_struct *vma)
> >  +{
> >  + vma->anon_vma->num_active_vmas--;
> >  + vma->anon_vma =3D NULL;
> >  +}
> >  +
> >  static void anon_vma_chain_link(struct vm_area_struct *vma,
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
>=20This 'arbitrary parameter which is NULL' is also pretty horrible.
>=20

I=20will add a wapper function.

> >=20
>=20> if (unlikely(!anon_vma))
> >  goto out_enomem_free_avc;
> >  - anon_vma->num_children++; /* self-parent link for new root */
> >  allocated =3D anon_vma;
> >  }
> >=20
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
> >=20
>=20You're now losing the cases where we didn't reuse an anon_vma but dst=
->anon_vma
> !=3D NULL? This is just broken isn't it?
>=20

Yes,=20it is.
> >=20
>=20> unlock_anon_vma_root(root);
> >  return 0;
> >=20
>=20>  @@ -356,31 +372,22 @@ int anon_vma_fork(struct vm_area_struct *vma=
, struct vm_area_struct *pvma)
> >  return 0;
> >=20
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
>=20>  - /*
> >  - * The root anon_vma's rwsem is the lock actually used when we
> >  - * lock any of the anon_vmas in this anon_vma tree.
> >  - */
> >=20
>=20Please please PLEASE do not delete comments like this.
>=20

Okay.
>=20>=20
>=20> - anon_vma->root =3D pvma->anon_vma->root;
> >  - anon_vma->parent =3D pvma->anon_vma;
> >=20
>=20Yeah this is just not worth it in my opinion. You're putting code spe=
cific to
> forking in anon_vma_alloc(), which means you've made the code harder to
> understand.
>=20

This=20won't make the code harder to understand=EF=BC=8Cthey are essentia=
lly the same.
One has itself as its parent, while another has a real parent.

> >=20
>=20> /*
> >  * With refcounts, an anon_vma can stay around longer than the
> >  * process it belongs to. The root anon_vma needs to be pinned until
> >  * this anon_vma is freed, because the lock lives in the root.
> >  */
> >  get_anon_vma(anon_vma->root);
> >  - /* Mark this anon_vma as the one where our new (COWed) pages go. *=
/
> >=20
>=20Again, please do not remove comments like this.
>=20

Okay.
>=20>=20
>=20> - vma->anon_vma =3D anon_vma;
> >  + anon_vma_attach(vma, anon_vma);
> >  anon_vma_lock_write(anon_vma);
> >  anon_vma_chain_link(vma, avc, anon_vma);
> >  - anon_vma->parent->num_children++;
> >=20
>=20So now we're updating things not under the lock?... this is extremely=
 broken.
>=20

Yes,=20it's a mistake.
> >=20
>=20> anon_vma_unlock_write(anon_vma);
> >=20
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
> >=20
>=20>  - /*
> >  - * vma would still be needed after unlink, and anon_vma will be pre=
pared
> >  - * when handle fault.
> >  - */
> >=20
>=20You are removing key documentation of behaviour, please do not do tha=
t.
>=20

Okay.
>=20>=20
>=20> - vma->anon_vma =3D NULL;
> >  - }
> >  unlock_anon_vma_root(root);
> >=20
>=20>  /*
> >  --
> >  2.25.1
> >=20
>=20Overall this patch is really quite broken, but I don't think the gene=
ral concept
> _as implemented here_ really gives much value.
>=20
>=20I _like_ the idea of pairing adjustment of these kinds of anon_vma fi=
elds like
> num_children, num_active_vmas etc. with operations, but I think there's=
 probably
> too many fiddly cases + a need for hellish lock stuff for there to be r=
eally
> anything too viable here.
>=20

Sorry=20for the V1, I will send V2.=20
>=20Cheers, Lorenzo
>

