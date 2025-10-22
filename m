Return-Path: <linux-kernel+bounces-864695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70788BFB5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51270422BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCAF31D377;
	Wed, 22 Oct 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN2BwmZ8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA83112B4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128224; cv=none; b=knxsjMuI28xra4TvuEKpcpjgsWisqdY2IsoOcXpcVgFnDYiXpMkiCLLgGZP58tzl2IKq6IIRW2K0nI2DNj1XcCRF96pezJ8FWHzF0e7fBr3oqcJA9WddoA+qbu39LbjqxPCzwsPkISJFSELCHQfkX/gWcVcnaXSnjYIHYdMun7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128224; c=relaxed/simple;
	bh=MOfnKJSokBhEykhaIEQ9e0dlA9aH+M2wOpsTtdzrEBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVTnqfCz6nkUqngeM3QfIiXDU6P8TaYQRIGXBUXGOa1Z6hakc08crCMl+dm8vXj941hX8c1M8Sa8RpHQAf26ajul0yRSJ0wcLTByoHIZ6aam0dYuK8tNOSPsCdvSArAzOWyhGE3Vg/gNbrHrbrgzo9f1qedKn0+NFvF8h2XZoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN2BwmZ8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so6161324b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761128221; x=1761733021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haEcx+owQUrAtI+Twa4lANyM7LrcsC0gpzpLCA3x0ZA=;
        b=EN2BwmZ8hwQNOx5QcH2aMlfGe4VjO4VYjcwotMA65k1bXwCyeZPKygWuHnCJzNQ7RH
         hH2oDFQd1v23PZcQvZvDZtP0XGdGYy0jkX1Rny07Y80qMgf2FHSI9apv50gYfzBmpjha
         8w5/Wh0G7CiE4Opdj38dDBDXii34Hp5+OARPs72pbA4hisHDWacJjHuEcCyMzAfBJEkn
         sDaglxxX4BerD+rBPQZSjqxOm9EbPb0ALt/7gX1SgEFN+BRltA3muswQwxwmyvOFV4JF
         CzPGTuJiqEclIZ555o/yzFCox3hGTQsC9UTbTMgeHh/RVi4KvhskvfVodIb2i4peZeE5
         30mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128221; x=1761733021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haEcx+owQUrAtI+Twa4lANyM7LrcsC0gpzpLCA3x0ZA=;
        b=XyAexoHNCfxjXEl9KlK4sKVWId9ZEnTsD6OOoW0wPoR3tFosRhCB4KuXhMvnCjp6Km
         bFUsan8SNQI7vrSaOzkh2og36lhpXDMyQCFfLlg7B+AZ4iOW5nBZnHBFeYCc8kWN1Waa
         aGQMaI7m6mcyzA1coT1noK/MzvuBGiryt1/rehGY5qrIyOET6vIQLbnRfYAErmWPVi0D
         jHEXRGLQ8ee14DVlwsi9YFhDyDXJKkLWzcOKyf3rLLF0Pbm6EkbuIgsXkxpegOEouJtF
         RYJRBrg4eOCV3IhBHBCxPMphRvlLspJmXMzOjMowkOqOHiNTygGs3WblNLWbNfmCThdw
         F9zw==
X-Gm-Message-State: AOJu0YyiWVxU8dFQS3fIOj16hAw0DoKEzq9ELYvzpjuHzoljDFx5kmpe
	ybIG7y/8W8f/QtS6Ujyo65rMY8GuUPhptJYxkxIoqiRtZLK0+iAlUwlIi+JwOrZIgWhRjERFTS/
	7aMLKO/yQ4xayrM55PVafqVdMCQN3bARJDGYh
X-Gm-Gg: ASbGncs3HripC3hwgVdX1F8exD8gJid0g+P3wcMiLoRHbWw/R5u0O+fl0PajPTNnreo
	U1vnGIpnj9aTK+VdC22UZwEXV3jMg0Ug/dZjANASPUCNIfXcHKs5ltYuarEwCBdi+mF7nliJJ3g
	jesuC9BCgXXykDUr59OEPPmP4QYvwjuc8DRQA4Eg+J2onmmrLoeJAwD1rrYha7d4doMmzGSgi1k
	z88xNUZjR4vpnjYSCwiR2UYmNcj5OpgXof1641egAs4+mUx6uRnl7Gpedawcw==
X-Google-Smtp-Source: AGHT+IFJTEE/HiXWIG5TrFeKs4d/L4HVAF/6dXh5N41lm9MqW0h0eE/vtqgH9ezqqCt3yptuBI/ANyhTR2qjHPJdc28=
X-Received: by 2002:a17:903:3806:b0:24c:bc02:788b with SMTP id
 d9443c01a7336-290cb27d765mr263955945ad.44.1761128221090; Wed, 22 Oct 2025
 03:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com> <20251009233837.10283-3-mohamedahmedegypt2001@gmail.com>
In-Reply-To: <20251009233837.10283-3-mohamedahmedegypt2001@gmail.com>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Wed, 22 Oct 2025 13:16:47 +0300
X-Gm-Features: AS18NWBQRfdO1-l7UglbvLD1hS6ztsSHvm9zOj3-1-7RwG9-CwiA8rLqNmZ653w
Message-ID: <CAA+WOBvVasy2wRP_wmP-R6Q8y5B4sN08jNYfHuDVjiWXV+m23Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Mary Guillemard <mary@mary.zone>, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Pinging again re: review and also was asking if we can revert the
select_page_shift() handling back to v1 behavior with a fall-back
path, as it looks like there are some cases where
nouveau_bo_fixup_align() isn't enough;
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36450#note_315919=
9.

Thanks!

On Fri, Oct 10, 2025 at 2:39=E2=80=AFAM Mohamed Ahmed
<mohamedahmedegypt2001@gmail.com> wrote:
>
> From: Mary Guillemard <mary@mary.zone>
>
> Now that everything in UVMM knows about the variable page shift, we can
> select larger values.
>
> The proposed approach relies on nouveau_bo::page unless if it would cause
> alignment issues (in which case we fall back to searching for an
> appropriate shift)
>
> Signed-off-by: Mary Guillemard <mary@mary.zone>
> Co-developed-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 29 ++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nou=
veau/nouveau_uvmm.c
> index 2cd0835b05e8..26edc60a530b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -454,6 +454,31 @@ op_unmap_prepare_unwind(struct drm_gpuva *va)
>         drm_gpuva_insert(va->vm, va);
>  }
>
> +static bool
> +op_map_aligned_to_page_shift(const struct drm_gpuva_op_map *op, u8 page_=
shift)
> +{
> +       u64 page_size =3D 1ULL << page_shift;
> +
> +       return op->va.addr % page_size =3D=3D 0 && op->va.range % page_si=
ze =3D=3D 0 &&
> +                  op->gem.offset % page_size =3D=3D 0;
> +}
> +
> +static u8
> +select_page_shift(struct nouveau_uvmm *uvmm, struct drm_gpuva_op_map *op=
)
> +{
> +       struct nouveau_bo *nvbo =3D nouveau_gem_object(op->gem.obj);
> +
> +       /* nouveau_bo_fixup_align() guarantees for us that the page size =
will be aligned
> +        * but just in case, make sure that it is aligned.
> +        */
> +       if (op_map_aligned_to_page_shift(op, nvbo->page))
> +               return nvbo->page;
> +
> +       /* This should never happen, but raise a warning and return 4K if=
 we get here. */
> +       WARN_ON(1);
> +       return PAGE_SHIFT;
> +}
> +
>  static void
>  nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
>                                struct nouveau_uvma_prealloc *new,
> @@ -506,7 +531,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *u=
vmm,
>                         if (vmm_get_range)
>                                 nouveau_uvmm_vmm_put(uvmm, vmm_get_start,
>                                                      vmm_get_range,
> -                                                    PAGE_SHIFT);
> +                                                    select_page_shift(uv=
mm, &op->map));
>                         break;
>                 }
>                 case DRM_GPUVA_OP_REMAP: {
> @@ -599,7 +624,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
>
>         uvma->region =3D args->region;
>         uvma->kind =3D args->kind;
> -       uvma->page_shift =3D PAGE_SHIFT;
> +       uvma->page_shift =3D select_page_shift(uvmm, op);
>
>         drm_gpuva_map(&uvmm->base, &uvma->va, op);
>
> --
> 2.51.0
>

