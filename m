Return-Path: <linux-kernel+bounces-811912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306FDB52FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E600E3AC70C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E231280F;
	Thu, 11 Sep 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kdRV6RbF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A92C2340;
	Thu, 11 Sep 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589517; cv=none; b=ZlV6VGKDru4sBPYPDwRYE+CTICMgj6PcJuYisUIih/gCRYjxAOz5nJCDigeynKu1tnoy4XCY18aZmQ08gR+WCY/H23sI5Q33Mdjq4gjC53w1qTPeDjpFdTwJPEAoaL6wyf1S5OzTfIJLoWD+QLT+Zxty7PGLO5RsooryQX1KcuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589517; c=relaxed/simple;
	bh=IY6irs1xcyfinm+ECQ+nwn7CQq/0lCo73oLaURZh2Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ci5JnDFZsevLWoG1H1HtKFM36lsTADkhtmHQ2+uFXf/MqMwV3wd3PQ6q6xmudlOfs3PbNpZPPoNsEkBjS9O/d1AbC89hPLwVNbyRe1FR1fax3lvP6fqqjILY9xoH9vHhSQDVlQh8NvPv2x3KIujMBZGrAoKvoS3wn+zgY926xYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kdRV6RbF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757589513;
	bh=IY6irs1xcyfinm+ECQ+nwn7CQq/0lCo73oLaURZh2Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kdRV6RbF12GupEHynvvxuBmEHCmbvW9aQ497kWd1+uMnSVFmTh7041KRM2kGeZEJS
	 FsrXgjgUt93JPRznoD3WO6AEuVekylI6EZnJ35PsnqjPoxS6cXbX0+IE05loUf+TkL
	 P6abjFEmEChjx1tnURfWQTF2+h1NBVJX3rLvosohGUtFQt+8sTiUKvMh7AYOMuUfR+
	 yTFRnSOyVOAz+xpXh3wcmjnHIdefpWqzf60sjG9xVZuJ2/7dbRvEs8AMnRB7bpmsHr
	 UPH+ppC0RrOFq9kMiMCppfSPVzTzGXTPYUsuNJ5Q2Gy9fSOEZrOp6eg84UyfCYIGyR
	 7fzjzfThn8Ptw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BACD917E0109;
	Thu, 11 Sep 2025 13:18:32 +0200 (CEST)
Date: Thu, 11 Sep 2025 13:18:17 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, "Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?="
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau
 <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] panthor: use drm_gpuva_unlink_defer()
Message-ID: <20250911131817.3e0ab0d0@fedora>
In-Reply-To: <aMKtuwdk2HsejS-Q@google.com>
References: <20250909-vmbo-defer-v2-0-9835d7349089@google.com>
	<20250909-vmbo-defer-v2-2-9835d7349089@google.com>
	<20250911121537.523195c5@fedora>
	<aMKtuwdk2HsejS-Q@google.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 11:08:43 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Thu, Sep 11, 2025 at 12:15:37PM +0200, Boris Brezillon wrote:
> > On Tue, 09 Sep 2025 13:36:23 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> >   
> > >  static void panthor_vma_init(struct panthor_vma *vma, u32 flags)
> > > @@ -2084,12 +2010,12 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	/* Ref owned by the mapping now, clear the obj field so we don't release the
> > > -	 * pinning/obj ref behind GPUVA's back.
> > > -	 */
> > >  	drm_gpuva_map(&vm->base, &vma->base, &op->map);
> > >  	panthor_vma_link(vm, vma, op_ctx->map.vm_bo);
> > > +
> > > +	drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
> > >  	op_ctx->map.vm_bo = NULL;  
> > 
> > Hm, I don't see why we need a drm_gpuvm_bo_put_deferred() here. The
> > original idea was to delegate the vm_bo ownership to the VA being added
> > to the VM tree, so if we put it here, we have a UAF situation, don't we?  
> 
> The vm_bo refcount goes like this:
> 
> incr vm_bo_obtain()
> incr vma_link()
> decr vm_bo_put()
> 
> There is no decrement in panthor_vm_cleanup_op_ctx() due to this line:
> 
> 	op_ctx->map.vm_bo = NULL
> 
> So when everything is done, it is linked once and the refcount is
> incremented by one, which is correct.

Ah, right, I overlooked the change to panthor_vma_link() where you drop
the _put().

