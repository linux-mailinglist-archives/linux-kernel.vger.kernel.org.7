Return-Path: <linux-kernel+bounces-837550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2FEBAC8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B8D1C1F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF992222CA;
	Tue, 30 Sep 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QTjlXH2q"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F501EF363
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229177; cv=none; b=UiZ1Eq2hoQ/E1PB0mUo2fnesh5gZ/SpBA5kXyx2NiPNLfoDisohgTMkO6/0F8QZxb8lj5xxjBZGGKzJQj7OJAtgzUNSYtHwGwvjzz4SEGXBcNl3hXhwdDXj/Q+B5Ioz6KCLWVAI+zSQ/lqUAL+D7tWew88uZwjZWZrNeKp9xz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229177; c=relaxed/simple;
	bh=D7FPMpVUID4VWIVsRLfS5OjhCnjT47sZGTl0id6lZQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfCjfn5/I6c2lEDPcRAoOcjWAQFpbR7XDY5hJzEOC98LAqpumazGZLRHEB67hGv+wYhMl1XmzaOP4DCMFpW+radbMWP5TXOTlZQ1ALj4bkCkZBnEMue3YjQjQ7zxSSPEU0bxy7AQdze+AD7fHD88Ogiz0YFlP7ASn7fiYXQtaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QTjlXH2q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759229173;
	bh=D7FPMpVUID4VWIVsRLfS5OjhCnjT47sZGTl0id6lZQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QTjlXH2qlSMLT94RF69MdmWM6gnsmuNpbnGAeDVk1OFSCE7ihPVo6rNvTIG/Tpe8w
	 vNGepnhvL010tfDYKJQl6E05PrKb8kutNjqacgZjs/Kq5Hss/drZ9NpqvKNbm4J2pC
	 8HxDIJ7eFltlQetIVqrN6rrC3ye9kzs/tS+mOE/1FOm2Q4+S/Ef7Ouj35S5BMygvHH
	 5xxg9pkWPGbseOA6vdpLQwJmreCPctFohglY6D0BHYsgGQVNUUXyoJeKZpiFa9qXs6
	 PpSBuODe7zdLCk3IdG3klbaab4KPtqvbO+ITsVd+nISzyN9TkGdbvJOT5rJNB1kOhk
	 SW9R625asBKbQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B361117E0CF8;
	Tue, 30 Sep 2025 12:46:12 +0200 (CEST)
Date: Tue, 30 Sep 2025 12:45:54 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Melissa Wen <mwen@igalia.com>, =?UTF-8?B?TWHDrXJh?= Canal
 <mcanal@igalia.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, =?UTF-8?B?TWlrb8WCYWo=?= Wasiak
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>, Nitin
 Gote <nitin.r.gote@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 2/8] drm/gem: Introduce drm_gem_get_unmapped_area() fop
Message-ID: <20250930124554.5459194c@fedora>
In-Reply-To: <20250930123003.75370854@fedora>
References: <20250929200316.18417-1-loic.molinari@collabora.com>
	<20250929200316.18417-3-loic.molinari@collabora.com>
	<20250930123003.75370854@fedora>
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

On Tue, 30 Sep 2025 12:30:03 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> > +unsigned long drm_gem_get_unmapped_area(struct file *filp, unsigned long uaddr,
> > +					unsigned long len, unsigned long pgoff,
> > +					unsigned long flags)
> > +{
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +	struct drm_gem_object *obj;
> > +	unsigned long ret;
> > +
> > +	obj = drm_gem_object_lookup_from_offset(filp, pgoff, len >> PAGE_SHIFT);
> > +	if (IS_ERR(obj))  
> 
> Is this supposed to happen? If not, I'd be tempted to add a
> WARN_ON_ONCE().

Taking that back. I think you need it for non-GEM backed mappings, like
userland IOMEM mappings.

> 
> > +		return mm_get_unmapped_area(current->mm, filp, uaddr, len, 0,
> > +					    flags);
> > +

