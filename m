Return-Path: <linux-kernel+bounces-781730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B78B315F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A811D0299D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4D2F99A4;
	Fri, 22 Aug 2025 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+fVgKDh"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106462F90CC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860250; cv=none; b=GSNg+oB9+w9hmXsrmyz5wYutHtBcH+9Nbgsnm3Zt17e185Yq2457aL5x4P/xT0IGirBNU9yNk1P6Wu/VatfT2dYkeqGh3JAdIAienc/PvfsZRW19LS+fF14z3e6/o+6dE91/8fsuRksV6Lpnd7A/evJsrE0cYvBd9X1BY77OXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860250; c=relaxed/simple;
	bh=ZTz83K7Cswt9cjSybe5vv3tPcAP/updXzpEtv7fbREU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=McjNH1Zk57mykZqKZXjRRI/TwU48CZyb8OnqWtuOIDMMhubA6wX0fIWT5pQg7yqUymyJUegBe8sX8FYzBCA0AIxHp+6pN47jr9R2l8d/hscAG88td/WFfdvc7lk4QqkGW+l2j9EJSJKFi7q0apGLcsjKV5mHF43BIKtK2IuquqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+fVgKDh; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0b6466so13905565e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755860247; x=1756465047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HBMLCCpgWuee3qZa2JZqxXuB7kIiXGM9JL4gtORBiI=;
        b=C+fVgKDhDSugs7c2ksYUO8oJG5TC2MRgOaHXUqhq24oFgk0785FBQrN2LRyeDnYuu4
         7t0CdhwgNaSSS3IWK4Y62/p7Lg/CLApcA8y/j1QDsuNBI3GMCX0vb+69l7fKIpMJ8KUq
         pdtfz24XwBGXqzqqvUXNg6HEbfNcvcrkWk0HTGQzy2EhXpxGk4JRr2dN1AK3ZKW0nuBI
         /qFhWjWC/sxkv3XlWNmaZL9CYLEiGrkwCmugZ3YKQnqOq4O4FAINfNSj7jLuVuyhv1VA
         Oj05lJ4NQrcupmT6dTz60MEx1vC5XH6ejFwYdAj1nU1WA8QDjPuwuLHnkmUEbT3/y8Hz
         2RUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755860247; x=1756465047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HBMLCCpgWuee3qZa2JZqxXuB7kIiXGM9JL4gtORBiI=;
        b=NfEkcqKkUCqUjF1Kil/9gEVnY4OCYQU/UOo/X+UEu5QDKGtfEllTLmRFLc0EFhkeDy
         RPrWB5W4pSzH5E1ZzDxMVaU5JKNgUIJhUiPVO7R7zYm6pWf2qKX++tuhLTIKPfhrKNtE
         KGv1sTwuqP0kRxG5oeRa2DFTzFtyHaVxz6p0b1n7NXYxiE+4p99/os5xjwLKbX1A5TAI
         TJv/YPPjBGABqmYP/chekCsewJNRySRiOziEZX9YUgZrhhaDj1RSKPyK53Em9Rmo84Va
         kN4hLf7Fn0w+e/iiRi/3+6Qi+RCyfvl23dW46Kbe9CBj7kVJSxHSKahllmONvszgfBuL
         AjPg==
X-Forwarded-Encrypted: i=1; AJvYcCX3JskCEB7noX1POEw5g/z1RU7MjykSAVLdn4KbRGwU1EKEpow+kxj5X+mibRLKUEPgG+YA1zbOFdNP3XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS09inz7dPzedD8aJJrh4N50D1giKAznFFh1Wu6Fa9D2+4wQDE
	GMEBaK23M63AofaGlH/VpMSbsJO+fqT5zzCs398M+QY2MB1ZggBUy44D9m9qXHa7gfyCaiFbjCa
	u//JiCzNGvQMEseng0w==
X-Google-Smtp-Source: AGHT+IFtLd078KoINMXpDW22Ic3sXy4RycWnf1VLTnYuQE76dQbTyWnKjFD4VpOZLK/xGSJAqubgJ4a1/kyy7Zk=
X-Received: from wrs7.prod.google.com ([2002:a05:6000:647:b0:3b8:dd13:ef41])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:3101:b0:3b5:f0aa:b1e5 with SMTP id ffacd0b85a97d-3c5dae060f2mr1770712f8f.19.1755860247490;
 Fri, 22 Aug 2025 03:57:27 -0700 (PDT)
Date: Fri, 22 Aug 2025 10:57:26 +0000
In-Reply-To: <20250822115221.24fffc2c@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
 <20250822-gpuva-mutex-in-gem-v2-1-c41a10d1d3b9@google.com> <20250822115221.24fffc2c@fedora>
Message-ID: <aKhNFn7hdsLapLWO@google.com>
Subject: Re: [PATCH v2 1/3] drm_gem: add mutex to drm_gem_object.gpuva
From: Alice Ryhl <aliceryhl@google.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 22, 2025 at 11:52:21AM +0200, Boris Brezillon wrote:
> On Fri, 22 Aug 2025 09:28:24 +0000
> 
> Maybe it's time we start moving some bits of the gpuva field docs next
> to the fields they describe:
> 
> 	/**
> 	 * @gpuva: Fields used by GPUVM to manage mappings pointing to this GEM object.
> 	 */
> 	struct {
> 		/**
> 		 * @gpuva.list: list of GPU VAs attached to this GEM object.
> 		 *
> 		 * Drivers should lock list accesses with the GEMs &dma_resv lock
> 		 * (&drm_gem_object.resv) or &drm_gem_object.gpuva.lock if the
> 		 * list is being updated in places where the resv lock can't be
> 		 * acquired (fence signalling path).
> 		 */
> 		struct list_head list;

This isn't a new issue, but it's somewhat confusing to call it a list of
VAs when it's a list of vm_bos.

> 		/**
> 		 * @gpuva.lock: lock protecting access to &drm_gem_object.gpuva.list
> 		 * when the resv lock can't be used.
> 		 *
> 		 * Should only be used when the VM is being modified in a fence
> 		 * signalling path, otherwise you should use &drm_gem_object.resv to
> 		 * protect accesses to &drm_gem_object.gpuva.list.
> 		 */
> 		struct mutex lock;
> 
> 		...
> 	};
> 

Alice

