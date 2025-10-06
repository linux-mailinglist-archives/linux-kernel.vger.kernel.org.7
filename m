Return-Path: <linux-kernel+bounces-842880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDBBBDDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FE63B6A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B789426A08C;
	Mon,  6 Oct 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHi2K8pb"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D51CAA6C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750276; cv=none; b=UMIyA4M1Iunn2CHslNExv+FPrOsqhF2Mz5RFIQuOGmhD1AA6wzP74If9IMG4SroYtnpfjZKwyVPTvXh7t+NdVt+30uEDrbmAn2IKk/FcabXcZxEQj48PizZCYCU8gJnQOd5w1n6Mx/T26xz6Y2Yof1Naw8w4Kwt77NaCa4OZp5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750276; c=relaxed/simple;
	bh=KBB8bLmnKxiKJBgmqu9qRxSybSoobmjy5KqsgBWgLSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3sHybkn8pfJDbr0VeBypH7S6OFMwko2NdROLjtqkOqrnaUJJTgQ0LEdzhBKAXjm75/hZUPnTyAzhseweib4XFNJny0Zg4+ep2TNiCiBf1/BrDrl+59S1nA+mZ1q1ZNuNpTlhvsKX8HZDUSN5cn0dD6yMGg6cN6mFHIiR0otPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XHi2K8pb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so4086194f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759750273; x=1760355073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hynuoczeLJTVBLZvXLTFWBQJF44SryF2C9fl7xOgImY=;
        b=XHi2K8pbu77Tj39tSC6V4GuIDOHXqZCLVi7qVWTMpcU8NIBDN0hFvnWlIi5koXLoP8
         pLmy6/9mPfysCmCIu1Xea1v/EKaKmRfCAXspcNW0YjEYN7Uyt4TjWPh9OKdbFTdlXNwX
         RWGV9hNz/B4Q5DU9Vui2eOIgOKGQeBS9zHEAl5ul537Zl8xbgHSq6ePOCrufNlhxBB/q
         2VQ4VhzkbCVSFcKF30wbKh8pmkB++jxMNcm+dJLoUhJpnvihsSTEYQ3DaGcCTC70SEJs
         W40TCgQyTU8Hu1bcs8pRItp5Yahc22K3TvjeQ1FPkBIVrpjovY2wvgB1WGxXC5S/O7N5
         VKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759750273; x=1760355073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hynuoczeLJTVBLZvXLTFWBQJF44SryF2C9fl7xOgImY=;
        b=XCqXWwvURM0rCeVxZPxoLtJr2d758r8U+Wb2gr3g0e1Tw482Pn0YHv/tTdmJElrJ3A
         IFigCsov7S7zE2TS5l2Rz3ai95dYw9rIAsR/QXc3N2FbNcWjNXhE6rgTlGxCI6PRmQ2J
         tgWhjvGRvEGLY0FfcwKD49y8l+iNI/8grtR24Z9SvlHewM3Bxjyz2WB4/5VjVA4m+aAR
         yR3UAeTSvFFssMXEyS2wAW2MDLXq94mSd350+U0hZk9HTdhO3ME0z/+EMx9hIkBSC4+/
         hp2m1293xKR5NUEM40nR07+EpWjCgwTsY1aNQAFVWP1j7uJZab5dY84HQM0hH9+JsOKE
         0h9w==
X-Forwarded-Encrypted: i=1; AJvYcCW9GK7Tzga9qeruqCDVukIY8COR8vfRR3wDVtup2TU5dO6vqeLJJ3G8i6G9JOkQRIVZ3a82fQUFYYyRh4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqq8JJMtGdj22uaBPYix6UA4s5sT7KQ99PyMSTUDa0wtf93LJw
	tPv7PPDsZ/POh5YjdVq10c31v+dheU0nNFSQvPinkAuzQZ9oNaPhixO5j5zGTHDFpOc/vfYlwnU
	Zp35xGu7DPqyCJC9zYe5ZHKPWSSAGAc656WVRCJMD/qZb6YbgyB73IL4G
X-Gm-Gg: ASbGncsQAa5q29IcOyjeE+kSSuGMrLesImYfh7xaj5GNkMik1Q212lOnhFMbt5aM5YV
	RF5mgmgp1+QmwsweCkoTOHc96bQrj4eKlsIl02zjxxcj9tz0cbtxjQWLsi8wU3D6rlYWromanZf
	6JriDgTJ1wokbRf9IXV6+PMFidYare9tPdlHUuR+JBMzx7UsBxrxbGvtGE8NkpmjNN8zz2TzC0E
	zZYtY+AVl3eudo3O3w7li7m040iAqkfG94otBqD6rHvkR7JEzA/RnEu5Eocl3VFcfq/sk94MvLi
	wk4=
X-Google-Smtp-Source: AGHT+IHvyJbvN6G9/V2BAekCb/eczdhEbJ4N40IyXAkqljeVImgzHiqmjBf+48NckaYcxwY7yRHMElzQvdgz8RRqA3o=
X-Received: by 2002:a05:6000:43c5:10b0:425:70cb:9ba8 with SMTP id
 ffacd0b85a97d-42570cb9bd8mr4248192f8f.1.1759750272637; Mon, 06 Oct 2025
 04:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com> <20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com>
In-Reply-To: <20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 6 Oct 2025 13:30:59 +0200
X-Gm-Features: AS18NWDt63QT61YPNpzRLuOD6qlBzTV_WQ7rT6iD_6SVfpk6AHE4bvqw1ogfIKI
Message-ID: <CAH5fLgipghDp3W+Gr0YfHT0HOp3vcF+mfBAbtiAiLOKRYt43Sw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/gpuvm: add deferred vm_bo cleanup
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 12:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> When using GPUVM in immediate mode, it is necessary to call
> drm_gpuvm_unlink() from the fence signalling critical path. However,
> unlink may call drm_gpuvm_bo_put(), which causes some challenges:
>
> 1. drm_gpuvm_bo_put() often requires you to take resv locks, which you
>    can't do from the fence signalling critical path.
> 2. drm_gpuvm_bo_put() calls drm_gem_object_put(), which is often going
>    to be unsafe to call from the fence signalling critical path.
>
> To solve these issues, add a deferred version of drm_gpuvm_unlink() that
> adds the vm_bo to a deferred cleanup list, and then clean it up later.
>
> The new methods take the GEMs GPUVA lock internally rather than letting
> the caller do it because it also needs to perform an operation after
> releasing the mutex again. This is to prevent freeing the GEM while
> holding the mutex (more info as comments in the patch). This means that
> the new methods can only be used with DRM_GPUVM_IMMEDIATE_MODE.
>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

In this version, I got rid of the kref_put_mutex() usage, but I
realized that maybe we should bring it back. With the current code,
it's actually possible to observe a zombie vm_bo in the GEM's list
because we don't drop the refcount while holding the mutex.

Alice

