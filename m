Return-Path: <linux-kernel+bounces-779687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE2B2F74B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D89A587B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDCA2DEA78;
	Thu, 21 Aug 2025 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ly8rgEvX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A630292B4D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777288; cv=none; b=MB4SHQoFSnJ8nWtlnXcRy9ScTGY/x4QlUPNHfsXklLgk1FF2v7B9072YPlj9RbQASwKjfZfI3eJONx+aV368aNnzlP3adCBuHY7nPkL5obDN0WP1oYCTTFY44TRrLqe8+xHOCdhH+PcVjAQQm4IfwKG6R6GbaGhfbweqCyubn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777288; c=relaxed/simple;
	bh=69wzCZHhSFHeHuTH3cr2PUYgHqtI+f+GALGK+wokVyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLlEcdxvBRyqNgur9U6ZZ97cdS0KGrUlrMqt80hJQ+f5MWNhMvpV/xKPHYg24F95yzI5e6PVHDUoFXbta52pZ28K2GKzu3r//EdD6hdazadcD9IObwCIFbzoD48ykRBcPRMluT6KuiFYN2PcxqLJml7FEDNndj5HGUJE9Failv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ly8rgEvX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755777284;
	bh=69wzCZHhSFHeHuTH3cr2PUYgHqtI+f+GALGK+wokVyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ly8rgEvX5U+tO7SJMmv4YFydyn0vAw3UgGN9Bx2xeLJA5ukPvo3AsnW6jngbMxY+N
	 lKez3ppvehdP16jThVFB4BjSU9smlrCz50csvQJA989iC1n8oX+lc+TXvjdNMKveBd
	 ILd9DPlfPzlvVTSOMKPpT3sCrzyqYFWnS2g7jHC7R69oDiG3xAaO4GJ/7z7x6JQswH
	 h7cIxm7z2uUZj71qJIEzgqj4Tkiq7UuJ38zd9DeerR9Tp9rxEhHkXuMaUJ/5OXOYkN
	 fH21M9MwIPuYBCT4FwQinAJOwGQWfQPTAVp7QdLJ1+Miy5lvb+fUDqnBVskzT0s/GA
	 VVCum848K4ViA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EF55C17E127B;
	Thu, 21 Aug 2025 13:54:43 +0200 (CEST)
Date: Thu, 21 Aug 2025 13:54:37 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Adrian Larumbe <adrian.larumbe@collabora.com>
Cc: Caterina Shablia <caterina.shablia@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Binns <frank.binns@imgtec.com>, Matt
 Coster <matt.coster@imgtec.com>, Karol Herbst <kherbst@redhat.com>, Lyude
 Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v4 4/7] drm/gpuvm: Add a helper to check if two VA can
 be merged
Message-ID: <20250821135437.499d9a6a@fedora>
In-Reply-To: <bvoiomc5x7cbyc4l35rbideznuyw557u2ttp7utoifaxs27j3m@6mc7ya7asmpy>
References: <20250707170442.1437009-1-caterina.shablia@collabora.com>
	<20250707170442.1437009-5-caterina.shablia@collabora.com>
	<bvoiomc5x7cbyc4l35rbideznuyw557u2ttp7utoifaxs27j3m@6mc7ya7asmpy>
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

On Tue, 22 Jul 2025 20:17:14 +0100
Adrian Larumbe <adrian.larumbe@collabora.com> wrote:

> On 07.07.2025 17:04, Caterina Shablia wrote:
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > We are going to add flags/properties that will impact the VA merging
> > ability. Instead of sprinkling tests all over the place in
> > __drm_gpuvm_sm_map(), let's add a helper aggregating all these checks
> > can call it for every existing VA we walk through in the
> > __drm_gpuvm_sm_map() loop.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_gpuvm.c | 47 +++++++++++++++++++++++++++++--------
> >  1 file changed, 37 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> > index 05978c5c38b1..dc3c2f906400 100644
> > --- a/drivers/gpu/drm/drm_gpuvm.c
> > +++ b/drivers/gpu/drm/drm_gpuvm.c
> > @@ -2098,12 +2098,48 @@ op_unmap_cb(const struct drm_gpuvm_ops *fn, void *priv,
> >  	return fn->sm_step_unmap(&op, priv);
> >  }
> >
> > +static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *a,
> > +		      const struct drm_gpuva *b)
> > +{
> > +	/* Only GEM-based mappings can be merged, and they must point to
> > +	 * the same GEM object.
> > +	 */
> > +	if (a->gem.obj != b->gem.obj || !a->gem.obj)
> > +		return false;
> > +
> > +	/* Let's keep things simple for now and force all flags to match. */
> > +	if (a->flags != b->flags)
> > +		return false;
> > +
> > +	/* Order VAs for the rest of the checks. */
> > +	if (a->va.addr > b->va.addr)
> > +		swap(a, b);
> > +
> > +	/* We assume the caller already checked that VAs overlap or are
> > +	 * contiguous.
> > +	 */
> > +	if (drm_WARN_ON(gpuvm->drm, b->va.addr > a->va.addr + a->va.range))
> > +		return false;
> > +
> > +	/* We intentionally ignore u64 underflows because all we care about
> > +	 * here is whether the VA diff matches the GEM offset diff.
> > +	 */
> > +	return b->va.addr - a->va.addr == b->gem.offset - a->gem.offset;  
> 
> If we're reordering the VAs for the rest of the checks, when could underflow happen?

I think this comments predates the re-ordering (I originally tried not
to order VAs).

> 
> > +}
> > +
> >  static int
> >  __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
> >  		   const struct drm_gpuvm_ops *ops, void *priv,
> >  		   const struct drm_gpuvm_map_req *req)
> >  {
> >  	struct drm_gpuva *va, *next;
> > +	struct drm_gpuva reqva = {
> > +		.va.addr = req->va.addr,
> > +		.va.range = req->va.range,
> > +		.gem.offset = req->gem.offset,
> > +		.gem.obj = req->gem.obj,
> > +		.flags = req->flags,
> > +	};
> >  	u64 req_end = req->va.addr + req->va.range;
> >  	int ret;
> >
> > @@ -2116,12 +2152,9 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
> >  		u64 addr = va->va.addr;
> >  		u64 range = va->va.range;
> >  		u64 end = addr + range;
> > -		bool merge = !!va->gem.obj;
> > +		bool merge = can_merge(gpuvm, va, &reqva);
> >
> >  		if (addr == req->va.addr) {
> > -			merge &= obj == req->gem.obj &&
> > -				 offset == req->gem.offset;
> > -
> >  			if (end == req_end) {
> >  				ret = op_unmap_cb(ops, priv, va, merge);
> >  				if (ret)
> > @@ -2163,8 +2196,6 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
> >  			};
> >  			struct drm_gpuva_op_unmap u = { .va = va };
> >
> > -			merge &= obj == req->gem.obj &&
> > -				 offset + ls_range == req->gem.offset;
> >  			u.keep = merge;
> >
> >  			if (end == req_end) {
> > @@ -2196,10 +2227,6 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
> >  				break;
> >  			}
> >  		} else if (addr > req->va.addr) {
> > -			merge &= obj == req->gem.obj &&
> > -				 offset == req->gem.offset +
> > -					   (addr - req->va.addr);
> > -
> >  			if (end == req_end) {
> >  				ret = op_unmap_cb(ops, priv, va, merge);
> >  				if (ret)
> > --
> > 2.47.2  
> 
> 
> Adrian Larumbe


