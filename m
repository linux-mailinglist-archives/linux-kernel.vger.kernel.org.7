Return-Path: <linux-kernel+bounces-779684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970CCB2F746
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5461317AE32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1EF2DFA5B;
	Thu, 21 Aug 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OtMwwDtm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF942DD608
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777209; cv=none; b=bjEycuK1msRj2/fu2+JGQRv6hHM/9JzgJrOnvW/68N3uOM32e1mRAj2A60oz3HmPA5JtUXIljPGdbPeh9rtt0cc282UzbG7HM9CKNJM29W43mQDWU5/s+so9oavCk7XzeQfyEwJvYWwt3MaE0MVOAwmUWcX5fawjBcvutrRK9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777209; c=relaxed/simple;
	bh=gj8Ewp98g6KH3AuYkRIp4/z6BIYMV5RScmMuaTBfZz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTBCYtfdSv+x+Lpzvap+oHu++aysqV42VdKi6mXdoG/yOrB4Ys4eTSmFLgz7sy0xbmNOX1G00Vvt6cNS0aa9ZBHRTzzQuH5BLSL7UlI7d1rL/b11d+5QJq+VSXaII1InXLgsJg1XjtBSUImVwEcqAt2k7OMW5smmkRWdYBDgWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OtMwwDtm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755777206;
	bh=gj8Ewp98g6KH3AuYkRIp4/z6BIYMV5RScmMuaTBfZz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OtMwwDtmwa/O7ggrird2cGFI/hroLbmib4VzTSaghb7/uOklbpvCSFe9mZZoGodol
	 7NYNjM26c0+wW/QA95kR/E6UCcsSpc5wcVo90h5eEXfV9nKxlSEyuarkJw+5jIEOU4
	 ugO/IkuZjikRGQsSnH+MiASOer3itiHp2tsSVYiCWsjkZXTQd960IYyen1pEYg137H
	 aBi9t7TDJUNqSHuPrhu0mIGBArA9MD1h7M79wC0HyvCkG2vjFu5bBxpuJEtIb1Mssd
	 brpaYAQPly2x+LErjxR16y0mXIXd7rZG9nRoledFXM9guZnoyiZML7x1DidHwZjJ0Z
	 VkBIHzzD9MLPA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8EBAB17E127B;
	Thu, 21 Aug 2025 13:53:25 +0200 (CEST)
Date: Thu, 21 Aug 2025 13:53:20 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Caterina Shablia" <caterina.shablia@collabora.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Binns"
 <frank.binns@imgtec.com>, "Matt Coster" <matt.coster@imgtec.com>, "Karol
 Herbst" <kherbst@redhat.com>, "Lyude Paul" <lyude@redhat.com>, "Steven
 Price" <steven.price@arm.com>, "Liviu Dudau" <liviu.dudau@arm.com>, "Lucas
 De Marchi" <lucas.demarchi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <asahi@lists.linux.dev>, "Asahi Lina"
 <lina@asahilina.net>
Subject: Re: [PATCH v4 3/7] drm/gpuvm: Pass map arguments through a struct
Message-ID: <20250821135320.670f2409@fedora>
In-Reply-To: <DB61N61AKIJ3.FG7GUJBG386P@kernel.org>
References: <20250707170442.1437009-1-caterina.shablia@collabora.com>
	<20250707170442.1437009-4-caterina.shablia@collabora.com>
	<DB61N61AKIJ3.FG7GUJBG386P@kernel.org>
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

On Mon, 07 Jul 2025 20:44:49 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Mon Jul 7, 2025 at 7:04 PM CEST, Caterina Shablia wrote:
> > +/**
> > + * struct drm_gpuvm_map_req - arguments passed to drm_gpuvm_sm_map[_ops_create]()
> > + */
> > +struct drm_gpuvm_map_req {
> > +	/** @va: virtual address related fields */
> > +	struct {
> > +		/** @va.addr: start of the virtual address range to map to */
> > +		u64 addr;
> > +
> > +		/** @va.size: size of the virtual address range to map to */
> > +		u64 range;
> > +	} va;
> > +
> > +	/** @gem: GEM related fields */
> > +	struct {
> > +		/**
> > +		 * @obj: GEM object to map.
> > +		 *
> > +		 * Can be NULL if the virtual range is not backed by a GEM object.
> > +		 */
> > +		struct drm_gem_object *obj;
> > +
> > +		/** @offset: offset in the GEM */
> > +		u64 offset;
> > +	} gem;
> > +};  
> 
> Can't we just use struct drm_gpuva_op_map instead? The structure is identical
> and represents exactly what we want, a map operation.

Sure, we can do that. The only reason I didn't is because I thought it
was preferable to distinguish a map request from the sub-operation it
might be split into (the latter being described by drm_gpuva_op_map).

> 
> Let's use that instead of redefining an identical structure.
> 
> With that,
> 
> 	Acked-by: Danilo Krummrich <dakr@kernel.org>


