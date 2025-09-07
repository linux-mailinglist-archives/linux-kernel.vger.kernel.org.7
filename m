Return-Path: <linux-kernel+bounces-804649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D857B47B11
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 272F64E0F96
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83742652A2;
	Sun,  7 Sep 2025 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4zYbyEj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9625B1D2;
	Sun,  7 Sep 2025 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757245464; cv=none; b=potx9HEL6rQgREECYIiFKd5lpuhTSHEJtpJmTOLbrfuO6rmhcZAFc6DhtLZBa/mwul16WDvUz5xnhVcyuRL5nKEwdy9WRZqAXiter8ZHFYC3jZo1TnmzwKef3dtEJiV7qEVHAerJHpX/BnqYXWbym6jFD+U66ComviEOubIJGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757245464; c=relaxed/simple;
	bh=OvDT2Q/6yP6Dr4ss8IQJNkHW43Mx6ronKHaCUw6k19c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KGw79omyMIsmQD64WCPErs8wdwg9ISZLTXn9hU3TYDVOpVztHPyDvFN4VqVexnmBubA4/gNbPOHP4oEDM1AFN/vuNRDlyxIIvSUe97PavGLnFCy1dvoDK0vGWmmpCO1wOhdc/QOxsgS47lXErhMpeo1TBLPgK+Tb21ZGZNsW2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4zYbyEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DA2C4CEF0;
	Sun,  7 Sep 2025 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757245463;
	bh=OvDT2Q/6yP6Dr4ss8IQJNkHW43Mx6ronKHaCUw6k19c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=a4zYbyEjoxjWiq8i+8Z6u6XzG5ZdbrD5mL4mRfMR6gVL/aHHWWcMBRDacX66Crddp
	 iJm6nho7ridjF/uP6udJxYYT7Ns/N8oeVm+NCYs9ODako0PT5T5KsjzdEohwkziTy8
	 a+ATwY7B4WETEmDo4/67Cbx9fc6zul749ph9nv/LLQeB22/dQnzDT9Zy2saQI/J1yl
	 aNC22KWgBRvxqqqtl5eLiz8h7E9Ntj2ohmcdNzET0oLT30vcorTdTqJU00d5QH6sB1
	 E4fX6f7g1gvNyMtSltbTXubIhoOeFV7v3P9/cZJ+yYbLlvyIJU5TurAEtvBFbWGfI9
	 bAN5YQkXyEdtQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 13:44:19 +0200
Message-Id: <DCMJIZJKOFC0.2F9NNE8FAT4B5@kernel.org>
Subject: Re: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
Cc: "Boris Brezillon" <boris.brezillon@collabora.com>, "Matthew Brost"
 <matthew.brost@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Steven Price"
 <steven.price@arm.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Liviu Dudau" <liviu.dudau@arm.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
 <20250905-vmbo-defer-v1-1-7ae1a382b674@google.com>
 <20250905152505.005a610d@fedora>
 <CAH5fLghgqv0mNYf8r-rdeBaCGxYsdkBouqgo_ohx3DYHwpcZRQ@mail.gmail.com>
 <DCL8DQV23FIZ.KJ74UQ9YOFZV@kernel.org> <aL1pSFB9iBsfHFM_@google.com>
 <DCMJ6K06T63T.2UBTM1RL4YJ0A@kernel.org> <aL1u_YxOkuj1kIq6@google.com>
In-Reply-To: <aL1u_YxOkuj1kIq6@google.com>

On Sun Sep 7, 2025 at 1:39 PM CEST, Alice Ryhl wrote:
> On Sun, Sep 07, 2025 at 01:28:05PM +0200, Danilo Krummrich wrote:
>> On Sun Sep 7, 2025 at 1:15 PM CEST, Alice Ryhl wrote:
>> > On Sat, Sep 06, 2025 at 12:47:36AM +0200, Danilo Krummrich wrote:
>> >> On Fri Sep 5, 2025 at 8:18 PM CEST, Alice Ryhl wrote:
>> >> > On Fri, Sep 5, 2025 at 3:25=E2=80=AFPM Boris Brezillon
>> >> > <boris.brezillon@collabora.com> wrote:
>> >> >> On Fri, 05 Sep 2025 12:11:28 +0000
>> >> >> Alice Ryhl <aliceryhl@google.com> wrote:
>> >> >> > +static bool
>> >> >> > +drm_gpuvm_bo_is_dead(struct drm_gpuvm_bo *vm_bo)
>> >> >> > +{
>> >> >> > +     return !kref_read(&vm_bo->kref);
>> >> >>
>> >> >> I'm not too sure I like the idea of [ab]using vm_bo::kref to defer=
 the
>> >> >> vm_bo release. I get why it's done like that, but I'm wondering wh=
y we
>> >> >> don't defer the release of drm_gpuva objects instead (which is rea=
lly
>> >> >> what's being released in va_unlink()). I can imagine drivers wanti=
ng to
>> >> >> attach resources to the gpuva that can't be released in the
>> >> >> dma-signalling path in the future, and if we're doing that at the =
gpuva
>> >> >> level, we also get rid of this kref dance, since the va will hold =
a
>> >> >> vm_bo ref until it's destroyed.
>> >> >>
>> >> >> Any particular reason you went for vm_bo destruction deferral inst=
ead
>> >> >> of gpuva?
>> >> >
>> >> > All of the things that were unsafe to release in the signalling pat=
h
>> >> > were tied to the vm_bo, so that is why I went for vm_bo cleanup.
>> >> > Another advantage is that it lets us use the same deferred logic fo=
r
>> >> > the vm_bo_put() call that drops the refcount from vm_bo_obtain().
>> >> >
>> >> > Of course if gpuvas might have resources that need deferred cleanup=
,
>> >> > that might change the situation somewhat.
>> >>=20
>> >> I think we want to track PT(E) allocations, or rather reference count=
s of page
>> >> table structures carried by the drm_gpuva, but we don't need to relea=
se them on
>> >> drm_gpuva_unlink(), which is where we drop the reference count of the=
 vm_bo.
>> >>=20
>> >> Deferring drm_gpuva_unlink() isn't really an option I think, the GEMs=
 list of
>> >> VM_BOs and the VM_BOs list of VAs is usually used in ttm_device_funcs=
::move to
>> >> map or unmap all VAs associated with a GEM object.
>> >>=20
>> >> I think PT(E) reference counts etc. should be rather released when th=
e drm_gpuva
>> >> is freed, i.e. page table allocations can be bound to the lifetime of=
 a
>> >> drm_gpuva. Given that, I think that eventually we'll need a cleanup l=
ist for
>> >> those as well, since once they're removed from the VM tree (in the fe=
nce
>> >> signalling critical path), we loose access otherwise.
>> >
>> > Hmm. Another more conceptual issue with deferring gpuva is that
>> > "immediate mode" is defined as having the GPUVM match the GPU's actual
>> > address space at all times, which deferred gpuva cleanup would go
>> > against.
>>=20
>> Depends on what "deferred gpuva cleanup" means.
>>=20
>> What needs to happen in the run_job() is drm_gpuva_unlink() and
>> drm_gpuva_unmap(). Freeing the drm_gpuva, inluding releasing the assoici=
ated
>> driver specific resources, can be deferred.
>
> Yeah I guess we could have unlink remove the gpuva, but then allow the
> end-user to attach the gpuva to a list of gpuvas to kfree deferred. That
> way, the drm_gpuva_unlink() is not deferred but any resources it has can
> be.
>
> Of course, this approach also makes deferred gpuva cleanup somewhat
> orthogonal to this patch.

Yes, it is.

> One annoying part is that we don't have an gpuvm ops operation for
> freeing gpuva, and if we add one for this, it would *only* be used in
> this case as most drivers explicitly kfree gpuvas, which could be
> confusing for end-users.

I think the reason why I left GPUVA alloc and free to drivers was that I wa=
s
expecting them to use a dedicated kmemcache for that.

However, we can still provide drm_gpuva_alloc(), drm_gpuva_free() and va_fr=
ee(),
va_alloc() callbacks for drivers to implement.

