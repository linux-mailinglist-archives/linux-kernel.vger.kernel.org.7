Return-Path: <linux-kernel+bounces-781731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC8B315FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D064621FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97D2F90EB;
	Fri, 22 Aug 2025 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mr4SNV8l"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9224CEE8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860306; cv=none; b=MxRS5t7AZ3uWDff/yh8+i4fPiMBReKoS2dmZN9w3TfuwxSYAeL+ia2UEMPCY92B86AW5O7En2gcd3uYCfP3bXTrAC52tvinmz5xQ2sGfOYcpcbadxSUilXvhPuBhf6uOPKOl7nI8P//GpU5RxL4Cq/KOfIEswc6wYQ+JoL0wVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860306; c=relaxed/simple;
	bh=EHVCBzEbcUAQJGbAuSSOiy4tXKlutq+NSztlPN9BBjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dfNwaeJf9z1v6MvbMaN8hG6b1nWyqqK25vCCu/FHb3gTLgYDBpazMqD/boe2AUN+jJm6Tx89CYLqy5rfyxdCrjFlwnlzntB9MmqoKArjwLW3YkJZdnJsEvxQKeQEqe1Td9zUvj28BSxTx+YyIjd5NSPFlZcctJtLlhnZk/U+aGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mr4SNV8l; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0d0feaso13860575e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755860303; x=1756465103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lN++07lUAqPEyNZeQbX5pIHFHJClvSv5yNvs5J86bac=;
        b=mr4SNV8l0iIdGwyMmzZYPiaRFAhe/p8s6SB3/f9MS2aXYgDZihfm0G7MasneHYTPCN
         MRO0b+Ju7JO/X/FYvCDMBzB6sF3RZJAAajvqytOLTOTbSAqJC1iMLkkTvNQ4sbRmyOp5
         ilVRhLoGkec1EaVoo8SKA7K+EO0thjqbrbC7dJcDi6ga8fh37CUfZtGwgAvVQ6OeOBih
         1QOWdpHjZvpvsjO+cgQpSOaIcTLTujAXiKYeVoUZcaQGGP5DWpXOBuG5ncleZ0hr8SJX
         +LsDjJGSaoGQgjq7xgrPg2oKW4Mdbr8KwOmlqDSRliWaB7DH7bRtklvm4dFevNq+EvB5
         j4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755860303; x=1756465103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN++07lUAqPEyNZeQbX5pIHFHJClvSv5yNvs5J86bac=;
        b=rs/9FrlBdKf3pGclJiO6fn95zWF7D/EOQs3iKu507f1M5d0wa/ooMBEI3/oA004zit
         ohWAytkA+3mAMf4HoJ7Vvn9p5fFkCFDUQkn0G1cITm9iu+3ToTDRerqd8UTblK0WnwO1
         1uzmAA5qVCiAr7Gloft6rZSwzs/R6f/v/HEE2g3R5ki2Kfnsfg0KN1/ocmKmxroaxRDd
         9PZ9GL07GeGjbptO7TEEsjtB3mCobd/+eUl/Hsdt8FeurA0hvQTFU/Li4J7Feuq9L7Om
         /cJSQUmuYvAb5WL3OU0j4kNBhRH8rytlLTBIc9WdtkGjmVLawkp6UYVozCF5JqDDvcu0
         nYRg==
X-Forwarded-Encrypted: i=1; AJvYcCVGAsNU8mBJQJDmHLhgLAxcue8vqzJULY9EkVlSgyTkReNzpK1bUBKoU+7pQ2GWuorEJ4N+956M2PQvSCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVd4MqrVmbwsszqD64nO6nlWEdLXLmYP9X6itobHFhYgkhJPHC
	1fRyXfe/sulYEog4ilBuf3c/ls9Qq3eSddzpinnWVikOT9heSXyb2hLzK9cqGzF+PWzzRjX1yqV
	2QwkMvu2Bqq6zxSZnwg==
X-Google-Smtp-Source: AGHT+IHpXT7FmVk8RuJ028/KgbugYZVF29dYSJUueN6hZexCX/5at84pZTIxdA+EfL+hrrSqvoKJLIl/f66psQg=
X-Received: from wmbfp14.prod.google.com ([2002:a05:600c:698e:b0:459:dd85:efda])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:450a:b0:459:dfde:3359 with SMTP id 5b1f17b1804b1-45b517d9bd1mr17939435e9.32.1755860303434;
 Fri, 22 Aug 2025 03:58:23 -0700 (PDT)
Date: Fri, 22 Aug 2025 10:58:22 +0000
In-Reply-To: <DC8VTZ5OZY42.1OCS3QJHZGPAK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
 <20250822-gpuva-mutex-in-gem-v2-3-c41a10d1d3b9@google.com> <DC8VTZ5OZY42.1OCS3QJHZGPAK@kernel.org>
Message-ID: <aKhNTpQ_8ZWXTbpq@google.com>
Subject: Re: [PATCH v2 3/3] gpuvm: remove gem.gpuva.lock_dep_map
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 22, 2025 at 12:25:34PM +0200, Danilo Krummrich wrote:
> On Fri Aug 22, 2025 at 11:28 AM CEST, Alice Ryhl wrote:
> > diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
> > index 4a22b9d848f7b3d5710ca554f5b01556abf95985..598ba376b9430cdd4ab7bacdc15de031a887cf71 100644
> > --- a/include/drm/drm_gpuvm.h
> > +++ b/include/drm/drm_gpuvm.h
> > @@ -196,10 +196,20 @@ enum drm_gpuvm_flags {
> >  	 */
> >  	DRM_GPUVM_RESV_PROTECTED = BIT(0),
> >  
> > +	/**
> > +	 * @DRM_GPUVM_IMMEDIATE_MODE: use the locking scheme that makes it safe
> > +	 * to modify the GPUVM during the fence signalling path
> 
> I think this isn't entirely true yet or at least can be ambiguous for now,
> because it doesn't prevent users from having DRM_GPUVM_RESV_PROTECTED set, which
> requires the DMA resv lock to destroy a struct drm_gpuvm_bo, which may happen
> from drm_gpuva_unlink().
> 
> So, for now, until we have the deferred drop idea in place, it also
> requires DRM_GPUVM_RESV_PROTECTED to not be set.
> 
> (Eventually, we of course want both to be represented as a single flag, such
> that it becomes an either or.)
> 
> I also wouldn't say "makes it safe to", but rather "makes it possible to
> safely". We have no control over what the users do with the mutex. :)
> 
> NIT: missing period

Yeah, it probably makes sense to modify this wording, at least until the
deferred vm_bo thing.

Alice

