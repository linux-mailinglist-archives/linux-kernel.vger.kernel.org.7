Return-Path: <linux-kernel+bounces-860754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF2BF0D89
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 401D84F3F43
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76F52DE70C;
	Mon, 20 Oct 2025 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3cI9PGH0"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825416A956
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959909; cv=none; b=oJmNYLl1DTT+lD55bNKBRgSf0CZr7hxcw1b9r4iTYQeliRi++m38pZ/m6T7lWrdRdfqKzqbthLhRddFOaZz33eFzhKksVSTMHwQGJpx74BuRYyBBJH3APieVSOhY6vcf8DEiDbtdhL8quGpvn5nbXR+UTPLaJoZTF6jtakCBV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959909; c=relaxed/simple;
	bh=xUL1IZfu6NSHyBPakjeeczS83pdOroPBsqx7VPP44vM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VNTjeGZ33rMjBplkWETGF1jQpXwCDGqYF9qiRR2dWsyPJ/C5re1in+Ek4+xu+lefTs542xgO6XzEl2AetUkb7xhatwV8h+95ebxMrgDHnM5CraLI0O8D5G7yxxcYAyBxE2LoYHg4+XX7MwgtDhYehPKM0LMkN+6rDH3jet/nZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3cI9PGH0; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so5104574f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760959906; x=1761564706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMcqFZ5cAqBQM1biUtf3Krfxn1U/zGBC3gm6VwatmXg=;
        b=3cI9PGH0/F87DVw+3zkTuXopR91jijvohjU9W1/oXEP1r4XgTcKaB0BkI/GunPGKC6
         QgL2LjVjv9HdsewEnbvbeAsVpdB4drlMbj/CsOZ0iRPKfKZQMqyBa/mDo3PvB8+OQ2BN
         SIXPIy4r/h60hLB/hmbM/3A6EreftMTtQXB1tpL2Z4gcIvz2HcrSDG9t2sDEZmcQ2vTE
         3aSdvoo4rLiNLL7KNFhR64U+KHBzQUbz7TQ8/lTaiR7tievbqdRXvB81Shb0OqahdSHz
         M4EfxvMakd25HVbYvs1N6es3WcRcIC0LBx9N8hhQ2Ekubz0Ezmsb55s+lZCohlvJWTxf
         m/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760959906; x=1761564706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMcqFZ5cAqBQM1biUtf3Krfxn1U/zGBC3gm6VwatmXg=;
        b=lQo24qjdSpp5Q8DS6vYMkxhzLszgnDXYKPqSGWt1TJ+ii/gpuzIfYYqkeI/lF6DrAA
         tAjGhAgk/Ajih+UzrudqvM+thd92R+RZrqPkjXkSCvi7GtS8bIMlpYqWNEhx9xMgGDZT
         z+dkYb/3TzJ7bluVNO64DPs+6bOX4U3ZsHJGpiWT/4RuNjcsJCp/0CHCrgxODY7X9uje
         8jNLiWDC2wY3bwg/I4sv4Rn68OJexzsdM6RtpM0idykrO/cWKoAihlef2neEFJ7nFCJu
         KpWW2HoS301clkhEpmte0mEmm3enmaSC4/RbEkj1C+wUiK6pcr92ZvdFhrHW6KtMiPNR
         yuKA==
X-Forwarded-Encrypted: i=1; AJvYcCVcHDEUh/QZlzFibfSLowYtzl+PS/ufZx+m6qP+z3DQdEE9pAWP5YhhPb02ys45KWzYBQk58+LZL7n8S8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYVMs6lbfp/i+ks+8QnK43wmzvqm+Raa3Zxv6SKHjOoZwSEbY
	dwhvCzxIMNsgUBKotFOPSybxge/NWk3WNAl2FBfk0GIbR/fHAXaLXKcKgZbMPA/CrtIVPPeKACG
	ntdE+Yx3+Kt4QeEFxTA==
X-Google-Smtp-Source: AGHT+IH2Qofc6ndiBT2TBEJUwAKSdi714gdnYYSKwoeWjdLZfKMzLOYYEgFO9KCms/5i7YzVpY9EuZiKpgOsDG8=
X-Received: from wmbjx13.prod.google.com ([2002:a05:600c:578d:b0:46e:5611:ee71])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ec6:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-4711787bfe8mr99039325e9.9.1760959906081;
 Mon, 20 Oct 2025 04:31:46 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:31:45 +0000
In-Reply-To: <20251006-vmbo-defer-v4-0-30cbd2c05adb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006-vmbo-defer-v4-0-30cbd2c05adb@google.com>
Message-ID: <aPYdoU-Fey8hBqJ_@google.com>
Subject: Re: [PATCH v4 0/2] Defer vm_bo cleanup in GPUVM with DRM_GPUVM_IMMEDIATE_MODE
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	"Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Oct 06, 2025 at 12:05:54PM +0000, Alice Ryhl wrote:
> There are two main ways that GPUVM might be used:
> 
> * staged mode, where VM_BIND ioctls update the GPUVM immediately so that
>   the GPUVM reflects the state of the VM *including* staged changes that
>   are not yet applied to the GPU's virtual address space.
> * immediate mode, where the GPUVM state is updated during run_job(),
>   i.e., in the DMA fence signalling critical path, to ensure that the
>   GPUVM and the GPU's virtual address space has the same state at all
>   times.
> 
> Currently, only Panthor uses GPUVM in immediate mode, but the Rust
> drivers Tyr and Nova will also use GPUVM in immediate mode, so it is
> worth to support both staged and immediate mode well in GPUVM. To use
> immediate mode, we must manage the vm_bos and vas during the fence
> signalling critical path.
> 
> The first part of that work was the introduction of a fence signalling
> safe mutex for the GEMs GPUVA list in commit e7fa80e2932c ("drm_gem: add
> mutex to drm_gem_object.gpuva").
> 
> This is series the second part of that work: Dropping a vm_bo object in
> the fence signalling critical path is problematic for two reasons:
> 
> * When using DRM_GPUVM_RESV_PROTECTED, you cannot remove the vm_bo from
>   the extobj/evicted lists during the fence signalling path.
> * Dropping a vm_bo could lead to the GEM object getting destroyed.
>   The requirement that GEM object cleanup is fence signalling safe is
>   dubious and likely to be violated in practice.
> 
> Panthor already has its own custom implementation of postponing vm_bo
> cleanup. Take inspiration from that by moving the logic into GPUVM, and
> adjust Panthor to use the new GPUVM logic.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Pushed to drm-rust-next.

I added this to drm-rust instead of drm-misc as a prerequisite for
another patch. If merge conflicts show up, we can do a backmerge.

