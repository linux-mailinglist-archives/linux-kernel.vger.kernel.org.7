Return-Path: <linux-kernel+bounces-779681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB40EB2F735
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF441C21FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439F2DE6E5;
	Thu, 21 Aug 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nJbdbHwy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01715223335
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777098; cv=none; b=b4VNkAq8VCULTQzxzqAZcRHtg6woQIqqOcE8+XXAuqUnK53eYIiY80OUr+MPzkF33rugSZdAWjip02lVqB5/0xX6ejomjJCzcGgetDGhXi8cRLGUoyegxL3pfkWq1SFQxh9tzZsQWMDL9rReMAxpyNv/wbjEJgmJkWZ4zLfK7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777098; c=relaxed/simple;
	bh=d03XXEvqiRt/RNkOzV4BVA6T1osymnw/eikOpnxXhQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaxovVUY8VGJy/TWuvQOnasuwIDl02lpUdUXowvC/PmYp6wk1ME5ugOuppj6p/pGd2rYp7iesRuLCj39Wyfl2KLJMEIXfrPtz/srOSxlHdNqbhjmU9hV+AtInsV3N/V2zk+mMx3zJUP8+z9/j/0YJ7ilkL8P6KlRFHhrj4kdUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nJbdbHwy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755777094;
	bh=d03XXEvqiRt/RNkOzV4BVA6T1osymnw/eikOpnxXhQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nJbdbHwyWai/8mIFSnwaC9HM44wQpqPpRb1BELwpuYoz6JnapEGqWDbkZ63uo9N9s
	 L9ujkuH43wg3Wj+ybkOyk9UKGbBT9fsMpp46cJ/VYGW7K+fjWo7x2pbqmXR7YA9ope
	 8Dy7Wg7pAblhNdH0mvRtBNWtwlATYrhEnIU69Z65ld21HyG34ZsXpMbFqtrTmOwABD
	 lMcPsP+uTHN48N3a8G7jPm9oxmmqtuBL+PzAfuUJgnmiunUYTRrHOwRCjUweP8IsuJ
	 GMcRpQgZNo4cMZ9dXT/wNK72VRRzTg6Th5dOKbsSAyzB25+Y/slBseKS6bL4HfaAXP
	 sJdXqP+H/+pMw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2F6A917E0458;
	Thu, 21 Aug 2025 13:51:33 +0200 (CEST)
Date: Thu, 21 Aug 2025 13:51:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Caterina Shablia <caterina.shablia@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Binns <frank.binns@imgtec.com>, Matt
 Coster <matt.coster@imgtec.com>, Karol Herbst <kherbst@redhat.com>, Lyude
 Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Liviu Dudau
 <liviu.dudau@arm.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Thomas
 =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, asahi@lists.linux.dev, Asahi Lina
 <lina@asahilina.net>
Subject: Re: [PATCH v4 1/7] drm/panthor: Add support for atomic page table
 updates
Message-ID: <20250821135127.2827abfb@fedora>
In-Reply-To: <0108b3cd-dfdd-4e4c-a2d8-157458e26f77@arm.com>
References: <20250707170442.1437009-1-caterina.shablia@collabora.com>
	<d4a6208b-a4a4-451f-9799-7b9f5fb20c37@arm.com>
	<2813151.QOukoFCf94@xps>
	<2434159.cojqenx9y0@xps>
	<0108b3cd-dfdd-4e4c-a2d8-157458e26f77@arm.com>
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

On Wed, 16 Jul 2025 16:43:24 +0100
Steven Price <steven.price@arm.com> wrote:

> >>> I think we need to briefly take vm->op_lock to ensure synchronisation
> >>> but that doesn't seem a big issue. Or perhaps there's a good reason that
> >>> I'm missing?  
> >>
> >> I think you're right, all other accesses to locked_region are guarded by
> >> op_lock. GPU job submit poke vm_active concurrently with vm_bind jobs doing
> >> region {,un}locks.  
> > Actually no, that's not necessary. Access to locked_region is protected by 
> > slots_lock, which is held here. Trying to lock vm->op_lock would also be 
> > detrimental here, because these locks are often taken together and slots_lock 
> > is taken after op_lock is taken, so taking op_lock here would be extremely 
> > deadlockful.  
> 
> It would obviously be necessary to acquire vm->op_lock before
> as.slots_lock as you say to avoid deadlocks. Note that as soon as
> as.slots_lock is held vm->op_lock can be dropped.

Yeah, lock ordering is not an issue, because we take slots_lock in this
function, so we're in full control of the ordering. And I wouldn't even
consider releasing op_lock as soon as we acquire slots_lock because

- that make things harder to reason about
- the locked section is not blocking on any sort of external event
- the locked section is pretty straightforward (so no excessive delays
expected here)

> 
> I just find the current approach a little odd, and unless there's a good
> reason for it would prefer that we don't enable a VM on a new address
> space while there's an outstanding vm_bind still running. Obviously if
> there's a good reason (e.g. we really do expect long running vm_bind
> operations) then that just need documenting in the commit message. But
> I'm not aware that's the case here.

I fully agree here. If there's no obvious reason to not serialize
vm_active() on VM bind ops, I'd opt for taking the VM op_lock and
calling it a day. And I honestly can't think of any:

- the VM op logic is all synchronous/non-blocking
- it's expected to be fast
- AS rotation is something I hope is not happening too often, otherwise
  we'll have other things to worry about (the whole CSG slot scheduling
  logic is quite involved, and I'd expect the
  BIND-while-making-AS-active to be rare enough that it becomes noise
  in the overall overhead of kernel-side GPU scheduling happening in
  Panthor)

> 
> Although in general I'm a bit wary of relying on the whole lock region
> feature - previous GPUs have an errata. But maybe I'm being over
> cautious there.

We're heavily relying on it already to allow updates of the VM while
the GPU is executing stuff. If that's problematic on v10+, I'd rather
know early :D.

Regards,

Boris

