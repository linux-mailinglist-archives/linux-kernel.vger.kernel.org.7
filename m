Return-Path: <linux-kernel+bounces-805353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0392FB48772
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD264179E38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833912EC0BF;
	Mon,  8 Sep 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVvjhfak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A32EBDCF;
	Mon,  8 Sep 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321251; cv=none; b=XLsWlgW80X+nE151qVK8xMUrgA6ex7/e9yokhQ4NT6A5WNM3doE8atQ/MML1brTA9iERc6qFXs7nyqXEtEFrXf20MKPoYGaJiDZA7y0NjNnxXgCG+qtlQ9pMtkhvpamxa708qegBA/foEtmJuwY+sEsJDSu7pIoAVHoFE+3AuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321251; c=relaxed/simple;
	bh=ueZh40oOF4fWY+NsRviR20R3sj57twEAQP9li/mb1RI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VHcJKVDQ2sPoN3GRwzs33I5sgIKA4TAI57yxQ6O5ymcatwOFaEwa9BJeRUjMoWwoAE2azZ2PP6X8LYrwly/rTGGWwsok9AxKr331ehTeDkhCKeKR6CrOX69s5VVZvfa45QZZseIn0L+4BsAWeceCXCPrvk6EYict3keX7fKV6Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVvjhfak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F04C4CEF1;
	Mon,  8 Sep 2025 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757321250;
	bh=ueZh40oOF4fWY+NsRviR20R3sj57twEAQP9li/mb1RI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=CVvjhfakDYIvvfgyM27x1bvTdcvvm6ORc1rZvsc1xczU2oNLEnonP/I2/pUx0O2Bt
	 T8Mt6s9nDeXi5ouF0Bm8/25Jxw6yZmZjK31CFOvKIUtVgU5Rj8JkGkJNa1kt+yBfAD
	 zh2u/WrQNLKFAQL20tMH5rCI95l+iw0p2gpL1uhj8zTJs8ALcM6EwhySodtf9PDLpY
	 W42cY85Qd4EE81GrEveV3yT0RhzggShySwmVrH1YM+WeyXiWtIdqhbEVSSsZhJsJDF
	 5l5LR0PM+pNyi04UrbRMTujk3DRRhRhZqhWYPqBiYPlhcYOwAgQBW4FjMIkYqwNUc3
	 Poja0iLDZoBgg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 10:47:25 +0200
Message-Id: <DCNAE3CJMEJ0.JH1F0MJABXQI@kernel.org>
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
 <20250908091140.44856fde@fedora> <aL6TJYRmWIkQXujj@google.com>
In-Reply-To: <aL6TJYRmWIkQXujj@google.com>

On Mon Sep 8, 2025 at 10:26 AM CEST, Alice Ryhl wrote:
> On Mon, Sep 08, 2025 at 09:11:40AM +0200, Boris Brezillon wrote:
>> Hi Alice,
>>=20
>> On Sun, 7 Sep 2025 11:39:41 +0000
>> Alice Ryhl <aliceryhl@google.com> wrote:
>>=20
>> > Yeah I guess we could have unlink remove the gpuva, but then allow the
>> > end-user to attach the gpuva to a list of gpuvas to kfree deferred. Th=
at
>> > way, the drm_gpuva_unlink() is not deferred but any resources it has c=
an
>> > be.
>>=20
>> This ^.
>>=20
>> >=20
>> > Of course, this approach also makes deferred gpuva cleanup somewhat
>> > orthogonal to this patch.
>>=20
>> Well, yes and no, because if you go for gpuva deferred cleanup, you
>> don't really need the fancy kref_put() you have in this patch, it's
>> just a regular vm_bo_put() that's called in the deferred gpuva path on
>> the vm_bo attached to the gpuva being released.
>
> Ok, so what you suggest is that on gpuva_unlink() we remove the gpuva
> from the vm_bo's list, but then instead of putting the vm_bo's refcount,
> we add the gpuva to a list, and in the deferred cleanup codepath we
> iterate gpuvas and drop vm_bo refcounts *at that point*. Is that
> understood correctly?

It has to be a special unlink function though, since otherwise

	drm_gpuva_link();
	drm_gpuva_unlink();
	drm_gpuva_link();
	drm_gpuva_unlink();

leaks the VM_BO. Sounds a bit messy, but my concern is really about the bel=
ow:

> That means we don't immediately remove the vm_bo from the gem.gpuva
> list, but the gpuva list in the vm_bo will be empty. I guess you already
> have to handle such vm_bos anyway since you can already have an empty
> vm_bo in between vm_bo_obtain() and the first call to gpuva_link().
>
> One disadvantage is that we might end up preparing or unevicting a GEM
> object that doesn't have any VAs left, which the current approach
> avoids.

Yeah, we really want to avoid that.

