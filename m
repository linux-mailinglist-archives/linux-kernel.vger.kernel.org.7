Return-Path: <linux-kernel+bounces-694409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D02AE0BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 19:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850351BC5FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 17:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B512128DB77;
	Thu, 19 Jun 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJWuuCGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164BA28DB4A;
	Thu, 19 Jun 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750354380; cv=none; b=R+NCF+3MABPEAjpKmQn1Kn+rRyx66hshx8415brd8bkppdPtMEpTLWUVP4V7WvZnGExRo573X0DZ/99X6Mxd8GcGCENwril48IzgbJOSxpgFVwmbdT4J7W2wbkdyzqucVVXoEKfoUEvlU8lkYLotKQaYzbroKSEVmQSZvxaeaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750354380; c=relaxed/simple;
	bh=iOCYm2Q0ejh/wpUJcN5TvpQXAQZko1nXFyp0be677Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd78VaZkz+OOK2KBUOPvZ9IZQMi7HLDL3WB3vozz6pETpb1W4khBTfT1y3RtFu9DFJ/SlyQPw+cZ9hVy/J2021TZzCFwynBdwHVWNzw5VG3CPq2zrT4fMk2WFA6g7ivVYrPxW1OQMVxp0iXqOgnVrA6q+4jA8EXFDxYEzaTuQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJWuuCGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FCEC4CEED;
	Thu, 19 Jun 2025 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750354379;
	bh=iOCYm2Q0ejh/wpUJcN5TvpQXAQZko1nXFyp0be677Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJWuuCGD8Cj4SnXlfiAxM5JdfncyBbq4Y+XC086oR78RG0t2Xtb8xmJ5nMUmOfR9H
	 xwKZFS8YbfUZihRmC3bFKq9K8fxIFfdPZy4QKXmGW+oTDwnAKH+luLhdR2bf4zqSgK
	 g1DCSG/1Z4obIrDY5U3Srx7vR2m8MqXr3Vxk8X6WP1mEhQAOWZX//GXBDKgGg8gTjk
	 2wTACTBjjtZwtUBlDgx5gBAXMRq3WESnliAKyycfUMck+EeMl/p9zsYPrkMdxxPd3N
	 hvI7f33eDNnDWymycgQ0ZSfHZhkeTYeMnYNj/xFEg0tn/hU1A/5H2fIINMrrhsQRpg
	 HVkMopKnL3DGw==
Date: Thu, 19 Jun 2025 19:32:52 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Lyude Paul <lyude@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v2 2/2] rust: drm: Add GPUVM abstraction
Message-ID: <aFRJxCFxA0Hqwmqu@pollux>
References: <20250422-gpuvm-v2-0-44d4fc25e411@collabora.com>
 <20250422-gpuvm-v2-2-44d4fc25e411@collabora.com>
 <aAgHGuzCZzh7YPz2@cassiopeiae>
 <DBB3E8CE-19AA-437D-AF54-BF23763B254F@collabora.com>
 <aAj7gAzFVRX3dN7L@pollux>
 <F731D6F7-312D-4633-B677-69B7CC7194A6@collabora.com>
 <20250619135709.634625e0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619135709.634625e0@collabora.com>

On Thu, Jun 19, 2025 at 01:57:09PM +0200, Boris Brezillon wrote:
> I'm digressing, but there's an aspect I found very annoying in the C
> version of the API: the fact that we have to take a BO ref, then lock,
> then release the vm_bo [1], because otherwise the vm_bo might be the
> last owner of a BO ref leading to a UAF on the lock itself. This to me,
> denotes a lifetime issue that I think would be good to address in the
> rust version of the API.
> 
> It's not exactly the same problem, but I think it comes from the same
> root issue: lax ownership definition. By that I mean it's not clear
> who's the owner and who's the owned. gem_object::gpuva::list has
> weak refs on the vm_bos contained in this list, which kinda makes sense
> because vm_bos themselves have a ref on the gem_object, and if we were
> to make this weak ref a strong ref we'd never free any of these two
> objects. The lock is also part of the BO (either the BO resv lock, or a
> custom lock), and since it's the very same lock we use to insert/remove
> vm_bos, that's problematic.

I think the ownership is actually well defined. A struct drm_gpuvm_bo holds a
reference of its DRM GEM object.

When the drm_gpuvm_bo is freed it needs to remove itself from the GEM objects
drm_gpuvm_bo list. This also guarantees that all list entries of the GEM object
are always valid and can be safely used as long as the list lock is held.

The reference count dance you describe does not come from the ownership model
(which, again, I think is fine), but it comes from the design decision to let
drivers take all required locks externally rather than locking things
internally. Or in other words typically GPUVM functions behave like a *_locked()
variant.

The main reason for that is that GPUVM had to be designed with a certain degree
of flexibility in order to be usable for different driver use-cases. For this
reason, the external locking approach was used to avoid drivers running into
lock inversion problems.

For instance, when we use a separate lock to protect the GEM objects list of
drm_gpuvm_bo objects, we can either iterate the list of objects from a scope
where the GEM objects dma_resv lock is already held (e.g. TTM callbacks), which
is a common use-case, or execute operations that have to grab a dma_resv lock
while iterating the GEM objects list of drm_gpuvm_bo objects.

Meanwhile, I think we have some experience in how drivers typically have to use
those APIs. And I think that in this case - as long as we keep the external
locking scheme for the dma_resv lock - we should be fine to make the lock that
protects the GEM objects drm_gpuvm_bo list an internal lock in the Rust
abstractions. For this, we can rename the existing, corresponding C functions
into *_locked() variants and provide functions with internal locking for both C
drivers and the Rust abstractions.

- Danilo

