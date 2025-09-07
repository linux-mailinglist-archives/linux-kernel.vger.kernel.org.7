Return-Path: <linux-kernel+bounces-804641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9EBB47AF6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33B3172400
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83F82620C3;
	Sun,  7 Sep 2025 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFfoml2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED918A6DB;
	Sun,  7 Sep 2025 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244490; cv=none; b=eY0SlWj+cXV+VUGczqGP7nnwhYkaKCmn4bMW4bcpkPidrVcHkyZ1j3dav8p6nrUiZ/DOso4RbbwNfz/iYR2KY15yjCritBBxjnMFWqYZYJ57NyyDqkfnM/NWrti2dSi2TcYCk5APpJ+cgQfBQrkAeCCUpimFJZqu0SoIjkhlCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244490; c=relaxed/simple;
	bh=tBG3qsUhXJSETVKTnGc2g6fSFH/QzlIYxavO6aoOa1M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gYC9b5S+F/fgSsd37MDtaIc97mGSKiJObmb6UOdMLt3l7mq9gpjd7ImWVqrJEaACV8H9fn/+Tia65OBxAXWrOfwFLWrs9CWzwE4TD3Nhjg3Ned2Tb9Htn/mykx1/WNXxbbeamr3TgCAdgi0Ym69613fqyUoH36m/b9avCPHVkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFfoml2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36DFC4CEF0;
	Sun,  7 Sep 2025 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757244489;
	bh=tBG3qsUhXJSETVKTnGc2g6fSFH/QzlIYxavO6aoOa1M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=JFfoml2LK+FLkLBhQ6TeAIwaLtvX50ijXDIBd14KVq1tnhMxdiZCDILg1QxM+VdoI
	 OV4ILaYrM2+yOfYBtJGT+8YMkC2jQ0KjY3whS4WUeqQlaT/SkiqL3LJauvbQLIvWQ+
	 qBYo/znhWNl9mD117ZNsURq0lvRlObWoWb7UHxbWHms0at8DV9a1UssGrPDIud5XQ/
	 t4IR57hDPiirVkd/rVi5tacXyMEgROF/rvKPNzpF7GS9QlcNr6q6oKjfrs2ZKdovb0
	 51b2DU04dQ0OWQqtGN+p+MvWpcE/pc+plOK/kVd5g0s/zNEk/o6sZMFDeWxKpzCKUM
	 aj8uj6GiuuP0Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 13:28:05 +0200
Message-Id: <DCMJ6K06T63T.2UBTM1RL4YJ0A@kernel.org>
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
In-Reply-To: <aL1pSFB9iBsfHFM_@google.com>

On Sun Sep 7, 2025 at 1:15 PM CEST, Alice Ryhl wrote:
> On Sat, Sep 06, 2025 at 12:47:36AM +0200, Danilo Krummrich wrote:
>> On Fri Sep 5, 2025 at 8:18 PM CEST, Alice Ryhl wrote:
>> > On Fri, Sep 5, 2025 at 3:25=E2=80=AFPM Boris Brezillon
>> > <boris.brezillon@collabora.com> wrote:
>> >> On Fri, 05 Sep 2025 12:11:28 +0000
>> >> Alice Ryhl <aliceryhl@google.com> wrote:
>> >> > +static bool
>> >> > +drm_gpuvm_bo_is_dead(struct drm_gpuvm_bo *vm_bo)
>> >> > +{
>> >> > +     return !kref_read(&vm_bo->kref);
>> >>
>> >> I'm not too sure I like the idea of [ab]using vm_bo::kref to defer th=
e
>> >> vm_bo release. I get why it's done like that, but I'm wondering why w=
e
>> >> don't defer the release of drm_gpuva objects instead (which is really
>> >> what's being released in va_unlink()). I can imagine drivers wanting =
to
>> >> attach resources to the gpuva that can't be released in the
>> >> dma-signalling path in the future, and if we're doing that at the gpu=
va
>> >> level, we also get rid of this kref dance, since the va will hold a
>> >> vm_bo ref until it's destroyed.
>> >>
>> >> Any particular reason you went for vm_bo destruction deferral instead
>> >> of gpuva?
>> >
>> > All of the things that were unsafe to release in the signalling path
>> > were tied to the vm_bo, so that is why I went for vm_bo cleanup.
>> > Another advantage is that it lets us use the same deferred logic for
>> > the vm_bo_put() call that drops the refcount from vm_bo_obtain().
>> >
>> > Of course if gpuvas might have resources that need deferred cleanup,
>> > that might change the situation somewhat.
>>=20
>> I think we want to track PT(E) allocations, or rather reference counts o=
f page
>> table structures carried by the drm_gpuva, but we don't need to release =
them on
>> drm_gpuva_unlink(), which is where we drop the reference count of the vm=
_bo.
>>=20
>> Deferring drm_gpuva_unlink() isn't really an option I think, the GEMs li=
st of
>> VM_BOs and the VM_BOs list of VAs is usually used in ttm_device_funcs::m=
ove to
>> map or unmap all VAs associated with a GEM object.
>>=20
>> I think PT(E) reference counts etc. should be rather released when the d=
rm_gpuva
>> is freed, i.e. page table allocations can be bound to the lifetime of a
>> drm_gpuva. Given that, I think that eventually we'll need a cleanup list=
 for
>> those as well, since once they're removed from the VM tree (in the fence
>> signalling critical path), we loose access otherwise.
>
> Hmm. Another more conceptual issue with deferring gpuva is that
> "immediate mode" is defined as having the GPUVM match the GPU's actual
> address space at all times, which deferred gpuva cleanup would go
> against.

Depends on what "deferred gpuva cleanup" means.

What needs to happen in the run_job() is drm_gpuva_unlink() and
drm_gpuva_unmap(). Freeing the drm_gpuva, inluding releasing the assoiciate=
d
driver specific resources, can be deferred.

> Deferring vm_bo cleanup doesn't have this issue because even though the
> vm_bo isn't kfreed immediately, all GPUVM apis still treat it as-if it
> isn't there anymore.

