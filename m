Return-Path: <linux-kernel+bounces-883811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E545C2E7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495513B48CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100E30147A;
	Mon,  3 Nov 2025 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPU8cHco"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AAE126F0A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214027; cv=none; b=G1LbR9dRFIz/tjewlW4Xf7e98KhwX0TI/qQbp1Df7ZZu4z513vcO/SB6d7uKzmHX3Hyd/T2l/1gjI9t8GIbmTMvSbjcIKf0wC/RBY4ZNojeI8T2laSe5OJy/APbomg4RKZ39aP7JYjiYxAYu0+a73lQm9GohVrRf8BYbuY/4OKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214027; c=relaxed/simple;
	bh=lATDq3/M9pfPxFBynTedjEEBJifdEQUpyUvP8lpjLgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ci162TChOUfn1eTtMPkNzNCnAZWUECaLBsFrDrtapDMwTBcqTQIpqULMQ06V3Eg6QiZ80D2qcKV9XjOEBTDdxRHSE/RCqwKKcfDGo4PA7Yrzc+DPXpm5Nt7O6/Cb4Sxm3aGRVrY7QRRAQsQcT5fL1jPo5TAINO6VD2ohAiQdnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPU8cHco; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so1271087a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 15:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762214025; x=1762818825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLjxRtSfyBJOMagychkpTepNRla4EVPcURJSVrcQeQY=;
        b=UPU8cHcoWqCAz9gjw1NchpbsuFCJKX5S33o67qk8hDAn8sBj9c9I9bfl7MART6FjCU
         7Men0lchVDtS/favjV7nTZMyMfbBKkBa3EPFUjLFZ0nFQFzCcBHgdHhVUQnz0C4NvaUj
         jWXIOCfU8fFB/epFjy/aw/fPrzICwhuJFlJJldx4PDbw6eSuUIIz7duSJGvX49nQ6hys
         t+aGMlgBEhlXVzlT7uPlz5+uTjA7NPU+3WSAwex8wX+8WPR2cehiXBLYpKLt4QnyeyNf
         4WxqbqJ9BxPLvKERCSJcHvTESTWztj8ciG8F3dwSAWKID3tDB4AVpFkSkg4vNqI4Vz6m
         tIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762214025; x=1762818825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLjxRtSfyBJOMagychkpTepNRla4EVPcURJSVrcQeQY=;
        b=ncnoTLhJWiIbLOMWJsSyBLYR/Ry+m4t3NjG1UYz2vy5EWJIpUetZY3MRWYyOU3Tqn3
         u3AHuwiufECVhoKRr3rFcT6gtuhAjKPhRgEcZnEA9alhNSuRVohjz+gSOPeX+S94SK0L
         ILqW8B0kvrdg7/axHHFe5j+aGKGczygKOinTnWUalTkI1Jx0gizBiSVDu76tU5K6yIwb
         wzoWnZTFnZSj/BeM981jFzB7ZESpvdAhNC6LwjYjvXJ5m3yMrZKA4xjMgX2uWN1BsR3n
         a88N16kyS4IYAZJ6nBMz44SoJMyRLsPlr9JC5x5dyGmWZe2FBBEB2fmbncgVSvIOoe4s
         +eZw==
X-Gm-Message-State: AOJu0YzDWRQwaLetBIJll01vJofveBJsEmpG6/+ciNw2XeqsX2TAkDTa
	EAsI7GlO+N/qA34YisuzoDp3DtcRM89+8mPaauGPdOhx5WVmVGKWjy7cS5TJRFT5xxnNTTQjMeR
	IcETUpVR4LVRAd8HSxOIJOKiqLOTqKtU=
X-Gm-Gg: ASbGnctuqasVpeXahN11RRL3KyjwEFT6K1r+Ce+Kap7A8nTihsAH3Yo7b4lNoRFJEGI
	C4cFirzxYud9gWAC1A9pyUVpPbpjeGu83DpHDOGgk9s1fjAf/92LTUV2xJvxnXM0GlPHGXJCXJY
	fH/YZIx9aFa9vfI94ALan2tUuF0Pg90YQI4RTPB3p18+HoqGZok8u/s4RG6ft2nvaIenXunw31D
	hsp8ICzBeR45pgDaZKz9hxtytfjZS7lJVHXRxb5QHN/TcR0W9gX2vSIKUwUk6Pl0dc0dFCGcg==
X-Google-Smtp-Source: AGHT+IFjJMuWOmDjj0eb6+pcmZCA68pLvX3OxhDBYHicRd6uUs/i7l+bHxwzshvHtyXhYzBsiR+VQipKQQKkZ83KoZQ=
X-Received: by 2002:a17:902:e842:b0:295:5a06:308d with SMTP id
 d9443c01a7336-2955a063493mr111188005ad.14.1762214024930; Mon, 03 Nov 2025
 15:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>
 <20251031104924.10631-3-mohamedahmedegypt2001@gmail.com> <0bffd718-3659-4add-90fc-fb0e098f2897@nvidia.com>
In-Reply-To: <0bffd718-3659-4add-90fc-fb0e098f2897@nvidia.com>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Tue, 4 Nov 2025 01:53:33 +0200
X-Gm-Features: AWmQ_blaOgJXhX7FTUGULCEM7fLqKNjCy5MDT2wZ0GCoGUGz9IYwhuxzFGdEeJk
Message-ID: <CAA+WOBtmbPHigscFQCFgDo=9WSM6V-JMXGCO7orP=01XOqTPHQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] drm/nouveau/uvmm: Allow larger pages
To: James Jones <jajones@nvidia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Mary Guillemard <mary@mary.zone>, Faith Ekstrand <faith.ekstrand@collabora.com>, 
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for the shout out! Looking more at things, the logic here
is actually redundant. It was originally copied over directly from the
bo allocation code to stay on the safer side (basically the idea back
then was to make both the bo and vmm sides match exactly). We aren't
at risk of having an aligned address that is in the wrong memory type
because the bo allocation code (nouveau_bo.c:321) forces anything that
has the GART flag to have a page size of 4K. Anything getting a page
size higher than that is exclusively VRAM only. Additionally,
currently things marked VRAM only don't get evicted to host memory
except under high memory pressure and in that case, the context is
paused until the objects in question are paged back in, so we also
don't have to worry about memory placement there.

The memory placement check in the vmm code could be removed but I am
leaning more towards leaving it as is just to stay on the safer side.
At the same time, it would be more useful to keep it for the future as
one of the future investigation targets that we want to look into is
all the memory placement rules because the "only 4K is allowed for
host memory" limit that nouveau imposes is a source of many pains in
userspace (originally thought to be a HW thing but seems it's actually
not), and having the checks on both bo and vmm paths would help
starting out with that.

Thanks a lot again,
Mohamed

On Fri, Oct 31, 2025 at 7:01=E2=80=AFPM James Jones <jajones@nvidia.com> wr=
ote:
>
> On 10/31/25 03:49, Mohamed Ahmed wrote:
> > From: Mary Guillemard <mary@mary.zone>
> >
> > Now that everything in UVMM knows about the variable page shift, we can
> > select larger values.
> >
> > The proposed approach relies on nouveau_bo::page unless if it would cau=
se
> > alignment issues (in which case we fall back to searching for an
> > appropriate shift)
> >
> > Signed-off-by: Mary Guillemard <mary@mary.zone>
> > Co-developed-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> > Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> > ---
> >   drivers/gpu/drm/nouveau/nouveau_uvmm.c | 60 +++++++++++++++++++++++++=
-
> >   1 file changed, 58 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/n=
ouveau/nouveau_uvmm.c
> > index 2cd0835b05e8..ab8933b88337 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > @@ -454,6 +454,62 @@ op_unmap_prepare_unwind(struct drm_gpuva *va)
> >       drm_gpuva_insert(va->vm, va);
> >   }
> >
> > +static bool
> > +op_map_aligned_to_page_shift(const struct drm_gpuva_op_map *op, u8 pag=
e_shift)
> > +{
> > +     u64 non_page_bits =3D (1ULL << page_shift) - 1;
> > +
> > +     return (op->va.addr & non_page_bits) =3D=3D 0 &&
> > +            (op->va.range & non_page_bits) =3D=3D 0 &&
> > +            (op->gem.offset & non_page_bits) =3D=3D 0;
> > +}
> > +
> > +static u8
> > +select_page_shift(struct nouveau_uvmm *uvmm, struct drm_gpuva_op_map *=
op)
> > +{
> > +     struct nouveau_bo *nvbo =3D nouveau_gem_object(op->gem.obj);
> > +
> > +     /* nouveau_bo_fixup_align() guarantees that the page size will be=
 aligned
> > +      * for most cases, but it can't handle cases where userspace allo=
cates with
> > +      * a size and then binds with a smaller granularity. So in order =
to avoid
> > +      * breaking old userspace, we need to ensure that the VA is actua=
lly
> > +      * aligned before using it, and if it isn't, then we downgrade to=
 the first
> > +      * granularity that will fit, which is optimal from a correctness=
 and
> > +      * performance perspective.
> > +      */
> > +     if (op_map_aligned_to_page_shift(op, nvbo->page))
> > +             return nvbo->page;
> > +
> > +     struct nouveau_mem *mem =3D nouveau_mem(nvbo->bo.resource);
> > +     struct nvif_vmm *vmm =3D &uvmm->vmm.vmm;
> > +     int i;
> > +
> > +     /* If the given granularity doesn't fit, let's find one that will=
 fit. */
> > +     for (i =3D 0; i < vmm->page_nr; i++) {
> > +             /* Ignore anything that is bigger or identical to the BO =
preference. */
> > +             if (vmm->page[i].shift >=3D nvbo->page)
> > +                     continue;
> > +
> > +             /* Skip incompatible domains. */
> > +             if ((mem->mem.type & NVIF_MEM_VRAM) && !vmm->page[i].vram=
)
> > +                     continue;
> > +             if ((mem->mem.type & NVIF_MEM_HOST) &&
> > +                 (!vmm->page[i].host || vmm->page[i].shift > PAGE_SHIF=
T))
> > +                     continue;
>
> This logic doesn't seem correct. I'm not sure why there's a need to
> limit the page size on the host memory type, but assuming there is due
> to nouveau architecture or HW limitations I'm not aware of, it should be
> applied universally, not just when falling back due to misaligned
> addresses. You can get lucky and have aligned addresses regardless of
> the target page size. Hence, this check would need to precede the above
> early-out for the case where op_map_aligned_to_page_shift() succeeds.
>
> Thanks,
> -James
>
> > +             /* If it fits, return the proposed shift. */
> > +             if (op_map_aligned_to_page_shift(op, vmm->page[i].shift))
> > +                     return vmm->page[i].shift;
> > +     }
> > +
> > +     /* If we get here then nothing can reconcile the requirements. Th=
is should never
> > +      * happen.
> > +      */
> > +     WARN_ON(1);
> > +
> > +     return PAGE_SHIFT;
> > +}
> > +
> >   static void
> >   nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
> >                              struct nouveau_uvma_prealloc *new,
> > @@ -506,7 +562,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm =
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
> > @@ -599,7 +655,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
> >
> >       uvma->region =3D args->region;
> >       uvma->kind =3D args->kind;
> > -     uvma->page_shift =3D PAGE_SHIFT;
> > +     uvma->page_shift =3D select_page_shift(uvmm, op);
> >
> >       drm_gpuva_map(&uvmm->base, &uvma->va, op);
> >
>

