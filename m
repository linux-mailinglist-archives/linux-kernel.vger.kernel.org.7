Return-Path: <linux-kernel+bounces-847208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE85EBCA402
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B606A4ED325
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E59226D1E;
	Thu,  9 Oct 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIfhR7pZ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9D1E51EE
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028708; cv=none; b=e3nxHgUowy3EJ1NAFp6SxzM+S3JX5e+FC3/7z5EZLIDKOSGaxJ1IDDN24zjt+FzVTvELduVjUNaqNxnG6i9j0K21WFJvgi8lRSin37vf2SWvEFQmwwA9SFX8gNFFAbBGGG8J8XfJ10El/JivqgikgShT8FAYtgNzNqNbzhrj6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028708; c=relaxed/simple;
	bh=+a2pOhtNDqKyIpLR4qMYz/WHZhhwYxUfbln5vH4AkLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ0HlnO9iwV/5jnVsxqQ9VTzvQmjJb1Y6DphX5/5j9vgx7RXNPjxRDuBHft7L80uawWyfqKLwaQeEUu+2edgiuQHdx4afWPCfpOkxaJiIHVCDVSkFRY/dhnkt9VkfcZImcH83z0v/aRytrJjUrMa+GE3spHzqlaO6jTWqqbPGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIfhR7pZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27eec33b737so18784075ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760028706; x=1760633506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqmHH018eIDbXC0urYrHMAd6/ShdhXMsPDErX//Tqp0=;
        b=RIfhR7pZLOuMfG7XNwkWBwrJTNzBop+LsFaFzXqGbb/kAhRLFzRljbQA8hhIq0BT6M
         a2yriRJI5hKPABtSTjgb2wgSfJwnwS4CxCovMlqtbY0DZugs57kGRwK34ZOXnnL75RnM
         ec9n4xw8/+aM9GECRy0FVTwIy/gPcFETQE9ft6aiuCoVv464YQgagg3z1vEQjmVJCy/C
         QQzNGgFL+yCsOFvJGetpHFzJ1hU3Kp6I5TCmxgdQeItCAQEgPyaKuKsd6zmupKeo4XOR
         l+U869Lq3Ns9vDh9AoVtP86Y8ZRvUIZXxYfv4IZ6TkAfX+EJW+xw29v28MJlfexNCLjV
         t48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028706; x=1760633506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqmHH018eIDbXC0urYrHMAd6/ShdhXMsPDErX//Tqp0=;
        b=dVQIFaDSqMenVAcONrGNbFqFHaT2IQMeGCyobrNUsB8VVDOFSSn6NgGAn5PzwTzGmf
         ExT/Ml+X4dAUJPauvcRuH7kicq4F/+K1FxiVEz2HNMfpFgNiuAnKLuyl5u0wjlz7wbQb
         S9a0fld3iMM3viTlRob8tmycMFsYhPhYg2+9f4WudcCqka8+2GRtfuRyK4JE8UeDsrgo
         /4hQ35VVhZ4Tz63xERgkgV6Rhgxw/UxhwTZnVFW/pjPGpYTwwC2itvND/8QhoDZmb1oF
         uxtCyE6WBnJEZllGg4Poj8P1S4K+AGlCCari6z3GhQS5sZ/eJnd5S3CGl8NuNaUlsJlA
         kVgg==
X-Gm-Message-State: AOJu0Yw3UIeKL8hyVVfnW9LB8iVPakA8hReO82jJ5NvnzxrhBHCfM2y9
	ukTlGavi3OD4ybZKCMhmyu4deKbvTYNkGKW96Crpjme3UCSElkdI9juxNAi6leC8kzZzgQrZZzF
	TxnJtCT36G2dADakFpbcfaxGSfdVP+Ew=
X-Gm-Gg: ASbGncuWy/pToQnuA7b27uEWbjjGm30UmTp/cpVawmguPSrc2pwvlsyeg5VzaC/2bPd
	7tpo1UDHJz5Iw2XgMRmfs3y77dgKpRoherk5Ap153xi55UYZlA1bk1DEJflRlDJgKWcLYuvo/Ye
	8HClAIWSH10l+/I/G5Qf4Ene0IbuMgTzZDtxiatOmwX4zRIOmnpQ0+uV44shi+OIro0kp3o3Ubz
	lHDCKHiYDlWPa8ZcEBCad3yol6O
X-Google-Smtp-Source: AGHT+IFdfU5A2EO1cnO6t/ZSoUtst+Oh7dzaEre8Qcs100m3PE5llEDiXV8JIJAzY40L1zNmGpBDg9bK7AGwDbGfB18=
X-Received: by 2002:a17:903:2c03:b0:269:87a3:43b8 with SMTP id
 d9443c01a7336-290272155c2mr82694885ad.4.1760028705844; Thu, 09 Oct 2025
 09:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
 <20251006191329.277485-3-mohamedahmedegypt2001@gmail.com> <DDBISJ2DUDF6.150HCB14ZRPH3@kernel.org>
In-Reply-To: <DDBISJ2DUDF6.150HCB14ZRPH3@kernel.org>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Thu, 9 Oct 2025 19:51:34 +0300
X-Gm-Features: AS18NWCagJaEVHXZ5bkGbAUYt9PlzwGuW-LLGeY8ShWGeK5ilLP3wva4ncCA0eo
Message-ID: <CAA+WOBvu2Gq=SM2TBdahsQ-RVi+vn_U-oDa7-DG6kj9Arq5tpA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Mary Guillemard <mary@mary.zone>, Faith Ekstrand <faith.ekstrand@collabora.com>, 
	Lyude Paul <lyude@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

Thank you so much for the review! I applied everything for v2, except this =
one:

> Let's move the call to select_page_shift() into op_map_prepare().

How would this work? Originally when we were working on this, we did
place it in op_map_prepare() but we ran into the issue where
nouveau_uvmm_vmm_put() needed the page_shift retrieved (see
nouveau_uvmm_sm_prepare_unwind()).

Thanks.

On Mon, Oct 6, 2025 at 11:26=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon Oct 6, 2025 at 9:13 PM CEST, Mohamed Ahmed wrote:
> > From: Mary Guillemard <mary@mary.zone>
> >
> > Now that everything in UVMM knows about the variable page shift, we can
> > select larger values.
> >
> > The proposed approach rely on nouveau_bo::page unless it would cause
> > alignment issues (in which case we fall back to searching an appropriat=
e
> > shift)
> >
> > Co-developed-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> > Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> > Signed-off-by: Mary Guillemard <mary@mary.zone>
>
> NIT: Both of your tags should come after Mary's tag. The same applied to =
some of
> the other patches.
>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 55 +++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/n=
ouveau/nouveau_uvmm.c
> > index a92c729600d6..c336a121e320 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > @@ -454,6 +454,56 @@ op_unmap_prepare_unwind(struct drm_gpuva *va)
> >       drm_gpuva_insert(va->vm, va);
> >  }
> >
> > +static bool
> > +op_map_aligned_to_page_shift(const struct drm_gpuva_op_map *op, u8 pag=
e_shift)
> > +{
> > +     u64 page_size =3D 1ULL << page_shift;
> > +
> > +     return op->va.addr % page_size =3D=3D 0 && op->va.range % page_si=
ze =3D=3D 0 &&
> > +                op->gem.offset % page_size =3D=3D 0;
> > +}
> > +
> > +static u8
> > +select_page_shift(struct nouveau_uvmm *uvmm, struct drm_gpuva_op_map *=
op)
> > +{
> > +     struct nouveau_bo *nvbo =3D nouveau_gem_object(op->gem.obj);
> > +
> > +     if (nvbo) {
>
> In nouveau a struct drm_gpuva_op_map always has a valid GEM object set; w=
e bail
> out if userspace gives us an invalid GEM handle.
>
> > +             /* If the BO preferred page shift already fits, use it. *=
/
> > +             if (op_map_aligned_to_page_shift(op, nvbo->page))
> > +                     return nvbo->page;
> > +
> > +             struct nouveau_mem *mem =3D nouveau_mem(nvbo->bo.resource=
);
> > +             struct nvif_vmm *vmm =3D &uvmm->vmm.vmm;
> > +             int i;
> > +
> > +             /* Otherwise let's find a granuality that will fit. */
>
> Do we ever run into the "otherwise" case? nouveau_bo_fixup_align() seems =
to
> already ensure that your previous call will never fail?
>
> > +             for (i =3D 0; i < vmm->page_nr; i++) {
> > +                     /* Ignore anything that is bigger or identical to=
 the BO preference. */
> > +                     if (vmm->page[i].shift >=3D nvbo->page)
> > +                             continue;
> > +
> > +                     /* Skip incompatible domains. */
> > +                     if ((mem->mem.type & NVIF_MEM_VRAM) && !vmm->page=
[i].vram)
> > +                             continue;
> > +                     if ((mem->mem.type & NVIF_MEM_HOST) &&
> > +                         (!vmm->page[i].host || vmm->page[i].shift > P=
AGE_SHIFT))
> > +                             continue;
> > +
> > +                     /* If it fits, return the proposed shift. */
> > +                     if (op_map_aligned_to_page_shift(op, vmm->page[i]=
.shift))
> > +                             return vmm->page[i].shift;
> > +             }
> > +
> > +             /* If we get here then nothing can reconcile the requirem=
ents. This should never
> > +              * happen.
> > +              */
> > +             WARN_ON(1);
> > +     }
> > +
> > +     return PAGE_SHIFT;
> > +}
> > +
> >  static void
> >  nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
> >                              struct nouveau_uvma_prealloc *new,
> > @@ -506,7 +556,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm =
*uvmm,
> >                       if (vmm_get_range)
> >                               nouveau_uvmm_vmm_put(uvmm, vmm_get_start,
> >                                                    vmm_get_range,
> > -                                                  PAGE_SHIFT);
> > +                                                  select_page_shift(uv=
mm, &op->map));
> >                       break;
> >               }
> >               case DRM_GPUVA_OP_REMAP: {
> > @@ -636,7 +686,8 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
> >               case DRM_GPUVA_OP_MAP: {
> >                       u64 vmm_get_range =3D vmm_get_end - vmm_get_start=
;
> >
> > -                     ret =3D op_map_prepare(uvmm, &new->map, &op->map,=
 args, PAGE_SHIFT);
> > +                     ret =3D op_map_prepare(uvmm, &new->map, &op->map,=
 args,
> > +                                          select_page_shift(uvmm, &op-=
>map));
>
> Let's move the call to select_page_shift() into op_map_prepare().
>
> >                       if (ret)
> >                               goto unwind;
> >
> > --
> > 2.51.0
>

