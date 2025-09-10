Return-Path: <linux-kernel+bounces-810057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877C3B51550
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD933B6A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EB027E049;
	Wed, 10 Sep 2025 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QedmcP+k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1D277C9E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503086; cv=none; b=kdJa512QpGyHZf47tvD07IOkKm24SM+dDGyY6oIFvjUXjxM13iQnLCgVwnu+aaMiZ1Jtek4M/0dpsb5c2ONbIFCjMdl9aiCHFyGAcFKAIWiqBdwk0Qq7KWE55BP8hHii6cwU4dRcoppnIiNqeEZauspbtlguUfbxix/6cxqu5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503086; c=relaxed/simple;
	bh=dnHXgTUAZ7HIbkANA7iXvAXtInJBNledNswHBsB+TgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNDgsjbcyR4gUGAJPd8/WY9c/Nn8F8zX+We7jxfd9vC8vdVWqo9yGgJN7ZuoDtKcyC24bkE26EDcHWRu45wB9fgHmltxJvF+viFidwYtFQdSvWLxKd6E+hzZSDsvK2PLR/w/Qg/W+Rjxe0unMF0CbPTqaUTGVfF2dgHHRCqIULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QedmcP+k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757503084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQNBoOyxmrq7spEGbUcgPjGs/vcAB6E3uxzpwOuMRrA=;
	b=QedmcP+kG/+VHeWBioLXp77RqVefGxCxJe0AbVg92GJSwt/RozbtHXdOsfFcXoinCHaJBA
	7c2LNR4P2/hFwKXu2hN+6eI4d/p2v3D9cdnyGwUpUj4T0j4OfK6IP8kofNhFHbIj2E+Ynw
	TFS+aFrmOyMrQ0/OBPEb5DuC07YVk4s=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-MuGTcafsOJmfFND8TkdN1A-1; Wed, 10 Sep 2025 07:18:02 -0400
X-MC-Unique: MuGTcafsOJmfFND8TkdN1A-1
X-Mimecast-MFC-AGG-ID: MuGTcafsOJmfFND8TkdN1A_1757503082
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737c5efso4905310a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503082; x=1758107882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQNBoOyxmrq7spEGbUcgPjGs/vcAB6E3uxzpwOuMRrA=;
        b=uPmQsGuq/TBLLj+g1+cDqch0UGrvnEJaJ4/+KKTSWpk1seFgGl/F8P8I9j+9c3IcVv
         Pagm//wXizcY6ZA4ZPzsdn60AAfkptM045hKVWk7vIWNov+l2ssDc3FpyQ1hT0fysR4H
         faanfZQyqU8WpmK6PPzkq719gIZs1QRF4OpIheGfXuDXMiCewmICj8Th+o3ahK6azyex
         8kovkAEkabZH4IUC/VJdToRCPby5Qg6ekjrqm3CUeuOaHK3T+7KjUA742+6QqfxpYQbl
         7mVMe0tZd2AOArJuUOMe6xD0CyhXiM8bicb4zZ90624LTVFUl8Q8uxXU4c90o7WhPlQJ
         1rEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOZ/11/QTtqTJ2ogMxMJOunmx/pw0i990Y5sbMGhLrEEFsh/r66NEgMtRVc88q1ZiQygd0C0yuzFDFV8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhST22a6uNL+Q9ZcIVMad1YL8N/XOpxSQ88BjVCib8YJPv3j2
	VOCGXIFSwkl9PKEtB32ShyJZqwRIPONPr1DDB0CvAhv5p5PGItONIj3UVYIZ93XQqfOGRMnBx3F
	v1ao6kb5GNKL1zMOefa514H8J5xSeEfJliIj8VcIiXOEVVMEZxAaf3/wqqKK8YJ2WCA==
X-Gm-Gg: ASbGnct9cCmBMaJoKRJAba6R0GNTNMxQVC9LlGs65veUiH5QoUeLEhbEC8BaxVN33ZI
	tIeJHlgyA6ntypqOFvBgvuwbI92+eAxv14XN+dYx3gYQ2ZNzdAW+wxFD4v2dUunIumS/qCdl5E0
	WGP1Eymi9KMecwyVFqTYqNsv7IPiIw68RD2rmmcX1CQM7v3+lwZ4MNLBeb/kxgTMoCp4ONvZNqn
	qlHHZY4ee1ztAXV4xiTeAb+DxdgxSdU3qPevMtbQOF00x0x4fJfmNRb07ZnQnX2wukBNXFjgps8
	Fb0Pi4oiBUD6lIvtIn1u6BOHnIMv33/xsyE=
X-Received: by 2002:a05:6a20:6627:b0:246:3a6:3e3f with SMTP id adf61e73a8af0-2534775e1c2mr14891250637.60.1757503081743;
        Wed, 10 Sep 2025 04:18:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiMrvxjVgffC7DE9f/8FL4eREAcsUy0lGs5oMB5Ba2E8pPpwmAdota/m2q4TuNtlgFN8rhwQ==
X-Received: by 2002:a05:6a20:6627:b0:246:3a6:3e3f with SMTP id adf61e73a8af0-2534775e1c2mr14891224637.60.1757503081330;
        Wed, 10 Sep 2025 04:18:01 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662905bcsm4934270b3a.51.2025.09.10.04.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:18:00 -0700 (PDT)
Date: Wed, 10 Sep 2025 20:17:56 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: zack.rusin@broadcom.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, jfalempe@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v2 1/1] drm/vmwgfx: add drm_panic support
 for stdu
Message-ID: <aMFeZG9_CvWX9vz-@zeus>
References: <20250908141152.221291-1-ryasuoka@redhat.com>
 <20250908141152.221291-2-ryasuoka@redhat.com>
 <CAO6MGtiOuQhGcHUjDjcYwnDrcZOWy9yM_kFwhxcTfbB-_OHQvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO6MGtiOuQhGcHUjDjcYwnDrcZOWy9yM_kFwhxcTfbB-_OHQvA@mail.gmail.com>

On Tue, Sep 09, 2025 at 03:48:01PM -0500, Ian Forbes wrote:
> On Mon, Sep 8, 2025 at 9:12 AM Ryosuke Yasuoka <ryasuoka@redhat.com> wrote:
> 
> > +static int
> > +vmw_stdu_primary_plane_get_scanout_buffer(struct drm_plane *plane,
> > +                                         struct drm_scanout_buffer *sb)
> > +{
> > +       struct drm_plane_state *state = plane->state;
> > +       struct drm_crtc *crtc = state->crtc;
> > +       struct vmw_private *dev_priv = vmw_priv(crtc->dev);
> > +
> > +       if (!plane->state || !plane->state->fb || !plane->state->visible)
> > +               return -ENODEV;
> > +
> > +       sb->format = plane->state->fb->format;
> > +       sb->width = plane->state->fb->width;
> > +       sb->height = plane->state->fb->height;
> > +       sb->pitch[0] = plane->state->fb->pitches[0];
> > +
> > +       u64 size = sb->height * sb->pitch[0];
> > +
> > +       sb->map[0].vaddr = memremap(dev_priv->vram_start, size, MEMREMAP_WT);
> > +
> > +       if (!sb->map[0].vaddr)
> > +               return -ENOMEM;
> > +
> > +       return 0;
> > +}
> > +
> > +static void vmw_stdu_primary_plane_panic_flush(struct drm_plane *plane)
> > +{
> > +       vmw_ldu_primary_plane_panic_flush(plane);
> > +}
> > +
> >  static void
> >  vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
> >                            struct drm_atomic_state *state)
> > @@ -1506,6 +1538,8 @@ drm_plane_helper_funcs vmw_stdu_primary_plane_helper_funcs = {
> >         .atomic_update = vmw_stdu_primary_plane_atomic_update,
> >         .prepare_fb = vmw_stdu_primary_plane_prepare_fb,
> >         .cleanup_fb = vmw_stdu_primary_plane_cleanup_fb,
> > +       .get_scanout_buffer = vmw_stdu_primary_plane_get_scanout_buffer,
> > +       .panic_flush = vmw_stdu_primary_plane_panic_flush,
> >  };
> >
> >  static const struct drm_crtc_helper_funcs vmw_stdu_crtc_helper_funcs = {
> > --
> > 2.51.0
> >
> 
> You only need the code I've highlighted in this reply with some minor changes.
> 
> 1. You can call `vmw_kms_write_svga` directly in `panic_flush`. There
> is no need to mark the buffer as dirty or send any commands.

In my test environment, it will be unstable without dirty command's
submission. In test environment, which is Virtual box, I've
observed serveral instances of the panic screen appearing.
It sometimes appears immediately as expected, and at other times,
there's a delay of about 15 to 20 seconds to appear the screen.
Another pattern, it's necessary to switch back and forth between
the Virtual Box console window and other windows.

With command submission, we can stably get a panic screen. Even if it
failed due to some reasons, we may get the panic screen ultimately. So I
think we should leave vmw_kms_ldu_panic_do_bo_dirty() to submit
commands.

What do you think?

> 2. The format should be hardcoded to RGB565 to minimize the risk of
> overrunning VRAM. Adjust the pitch accordingly to 2x width.

I see. drm panic supports multiple pitches. Checking pitch type 
in get_scanout_buffer is not difficult.

> 3. The sizes should be vmw_priv->initial_width, and
> vmw_priv->initial_height. These are the safe sizes for VRAM in early
> boot and will work in panic as well.

OK. I'll try to change this.

> 4. You want to ensure `get_scanout_buffer` only succeeds once when
> using display unit 0 since all calls to this function will return the
> same VRAM.

OK. I'll add a check in get_scanout_buffer. To confirm this, Is it
sufficient to check if lds->num_active is 1, or do I need to check
other places or values?

> 5. memremap flags should be `MEMREMAP_WB | MEMREMAP_DEC`

OK. I'll chenge the flag like this.

> 6. Move the panic related functions to the vmwgfx_kms.c files since
> they work in all DU modes.

OK. I'll try to move them in vmwgfx_kms.c

Thank you for your review and detailed comment.

Ryosuke


