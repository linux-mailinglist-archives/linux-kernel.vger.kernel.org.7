Return-Path: <linux-kernel+bounces-811904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC970B52F98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D74F3B9B26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3429B3128C9;
	Thu, 11 Sep 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kowlxELA"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF926980B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588927; cv=none; b=QkH9hPLvpkex917qnx/6Suf0TCItiFYMqFs38e3A6ArA4ZKh3Q0BOES7HudGIwgWVymZcVJiGhkPGsWhvt3BEIqAG+AB5khtabu+am/GoiP+ikhEpTBUSmCI1MlSaIPxdK3dkOiCH8JwdBmfVD9JhVwz3qJBqXfhcLAdLefpVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588927; c=relaxed/simple;
	bh=ScDNnU6M6rpSNIHcFJbM0W8mG0N4VnD+BAQ4TPaSNqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5j0bG7MtkqCf1lmv6pqzhdGdP42Rt00Xu/8yphaAOmZGQrveRqdhy0LiypSCiwNjsqhsF8BOKO8eCe8S7ggs7gcGAuJThpB6upfFE7fD6aN8tsAxXKjYzY1EfQKK7uHpLxgfajygAJqnr3uHKKqyq8x60tzDrTOGHAm4KkQco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kowlxELA; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3e067ef24aaso400145f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757588924; x=1758193724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLDaDteT3053I0ySW3rWWywH2rFVkM2hJVgvFeuu/Nc=;
        b=kowlxELAjYar9rkRPeOUywMX1EtpYCosCGU9ZnwDKv6XkGJ6rD9+4nGmGBM4BSp0L5
         AyF0aJK0t+0nIB9p3qq72vLrmcBWz5pqsACzTgpel1+zWiJKf3Bwmx8C0kKIzbsz1p+j
         U05IDgDfw49P8vagXfuooSt5zL/+BCgctFLwruf3CzKSeIpu+waKYQ2h5X9t67Yx6RHu
         GClSlUmT4BOL9Hl7gjLQWYKn3TjP213aTpIO5OFZPZnoskrrmKUlqm/Fe4JEAoJzlVaU
         KHrhsCGXe9jMN9a6JJoVbQh7dOcLvefYyPRVAMWTLVIayF2ZMPLZoNYn1dBUr4eBy1Qw
         RsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757588924; x=1758193724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLDaDteT3053I0ySW3rWWywH2rFVkM2hJVgvFeuu/Nc=;
        b=iScSOJG44f6D001mlxfpZ808wZz6nj0EPI3wQs7cJzzqONl/B7D3ihZY7RewDmbO+Q
         K9+ojgC2d6mpk8Ua3BJ0An/+0+qKd6d4uOA30fteSDdtctCpgeTaTRrqLyIEkI0p4eUx
         r5GmoY2yRgx57bp5Lhk2oiDODadVzJcXKDIeUCtsuzlqxQgYacDJqAToxzWnFMMqlu5h
         unjp5PT+jKZMs6QmImwdmq4P8rpjMDkC0Wk2NZkA8fS29zzHS4TW8xp/3rC7wIQq8mxd
         xXtl69j8uoxy+09b5qQop3ku1/ht8wdikoFIqf0HXZWyTa87aD7X/mPJQluOxHNctD0z
         Dr2g==
X-Forwarded-Encrypted: i=1; AJvYcCV5a1DRuhW2qeLrr1HuBQzRZ3nmO2V01xjxtyoYMQvhbVkePbKVd2q7NS7TVLcLYQgodbx6rDPwNfE46PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+uYG3caiZH2TjHl6u3EjQJJSLpXQQnnufZaork1eOe0h47KaK
	sv6RwD8SeH7Yfjt/ls+nltt059VpllhghoIxXfategTBYwDvky2rU4R9Tru4L6Ds8AdFniZ5kNk
	U0SAspIPh3EX9QC96gA==
X-Google-Smtp-Source: AGHT+IEk0csKfI2/BjWCy90xuPAu96V6W9xQvYBJ88BFoQPZm6+Zdl4YWe3zrLaDacwF6fcF/YNlvypSnsIR9nU=
X-Received: from wrbee10.prod.google.com ([2002:a05:6000:210a:b0:3b8:dd13:ef41])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:178e:b0:3dc:33aa:a2b8 with SMTP id ffacd0b85a97d-3e642da2f85mr15310927f8f.19.1757588924209;
 Thu, 11 Sep 2025 04:08:44 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:08:43 +0000
In-Reply-To: <20250911121537.523195c5@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909-vmbo-defer-v2-0-9835d7349089@google.com>
 <20250909-vmbo-defer-v2-2-9835d7349089@google.com> <20250911121537.523195c5@fedora>
Message-ID: <aMKtuwdk2HsejS-Q@google.com>
Subject: Re: [PATCH v2 2/2] panthor: use drm_gpuva_unlink_defer()
From: Alice Ryhl <aliceryhl@google.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	"Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Price <steven.price@arm.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Sep 11, 2025 at 12:15:37PM +0200, Boris Brezillon wrote:
> On Tue, 09 Sep 2025 13:36:23 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> >  static void panthor_vma_init(struct panthor_vma *vma, u32 flags)
> > @@ -2084,12 +2010,12 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
> >  	if (ret)
> >  		return ret;
> >  
> > -	/* Ref owned by the mapping now, clear the obj field so we don't release the
> > -	 * pinning/obj ref behind GPUVA's back.
> > -	 */
> >  	drm_gpuva_map(&vm->base, &vma->base, &op->map);
> >  	panthor_vma_link(vm, vma, op_ctx->map.vm_bo);
> > +
> > +	drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
> >  	op_ctx->map.vm_bo = NULL;
> 
> Hm, I don't see why we need a drm_gpuvm_bo_put_deferred() here. The
> original idea was to delegate the vm_bo ownership to the VA being added
> to the VM tree, so if we put it here, we have a UAF situation, don't we?

The vm_bo refcount goes like this:

incr vm_bo_obtain()
incr vma_link()
decr vm_bo_put()

There is no decrement in panthor_vm_cleanup_op_ctx() due to this line:

	op_ctx->map.vm_bo = NULL

So when everything is done, it is linked once and the refcount is
incremented by one, which is correct.

Alice

