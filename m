Return-Path: <linux-kernel+bounces-796679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E24B405DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AAB4814A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6B31CA5F;
	Tue,  2 Sep 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CAg5cbLR"
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311E2FAC19
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821074; cv=none; b=jzO5Vp85cAY6h9G+VeAHFyejRRul8IgBtLEyjvYTzhzrnyp8x/uqpzgy/oEf5H7bl0/Ja/YGiX0f2BbGrNYJlBDWc59QymrXZbB3N+nloSQb84/huYbRkyEvUrJ2jeTgy+AU0bqrtkJBGpHAqTZm+nI0qpjKR25vxp10NoTwwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821074; c=relaxed/simple;
	bh=MZuO289o9QOg7gXO+cAH/6V/7S7ke8xAAu6olKkn7a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUeE1rpUkxCe2UyxdLfyEo50zdqZX6zqRpIno6XTiKDd+O8wkBvCIrq7wLLOm7n+PnAFSatANytZx+ppYzKQ7PPNmBFqQjMUTwfMDUf07pzTAYoJqYAVfMTYXrE+JHHluWhmivtinmqVB3SQhtAuZMeTy2HTxc67aVokT4R+agw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CAg5cbLR; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-30ccebab736so4715091fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821069; x=1757425869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2y04SbxjLUjPnwt2oUtKi0SQgUAz4PjsMivX8t2meyQ=;
        b=WYANPA9+dPlqQ0JNHlDlYG+eoTd09+naMBCgR2Q9S80+q+fTDjcM2hxeDF+axLRDCm
         QfLlufw7WBUH0xMvyGeum7GrO28XG0ksR85dGRsVOAufApTkIsZT/B6yJv5kWbZRxCTD
         wDu8htqo1KnV+qtiwRnvpXg6OwbqkAUvUyYrBK83EYWw4JvHEXfrSjmf/QXNDT772APA
         Jm/vokykFYbTAKqI2MXHu75KWu2tTVa2xq9IBywVPR0nIfeqbcue04Idv2Qn1DvmR839
         P7nUgP2nuDI8+iwqQEGwuyi9pAIge9t9+e76J6KAe+Hux9CgBLj9clQXwGjAJ/7wXyJw
         Iuug==
X-Forwarded-Encrypted: i=1; AJvYcCXIX61A78YXhJqVG+6oMGzYjysz9ZvlTG3DUEDWJaS2zDQYH34QpQW7/uZSbv8Ih7SLJX/66Sv3ugmq8lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMhqmUUgG/2TalD9DQq/7vTQmba+RPvZmljx4PPZesgTGRR8t9
	aYBsDc6SupVMFSS8qaTi6ZPdMtvOuNZ7CxWQgmwblxK9w0H28wvIsU9ddh36oej7jIA6k6xdHk/
	mAPAi6bI+AP8joMGq7LbzrskQMM9bkmg0taNA2htOQ8nBWY3GfocFWzKWaE/7rmUxlkJpbBNUbb
	yJYTjYIpFM7V+njU0yrgpo850zDtkW+RrdB/v0P29l8O0OJE/t/yUJwrpNgPa9LS0fIWe5vPrCq
	7tzuWLNHiN1LNns
X-Gm-Gg: ASbGncu/Hx27Or4nyBdua/dw32ylTqSMC5zdkcQgFwu4JEXgnLnvdON/XYVKDNKMFb4
	Hsk30kvRFAxttW1WyX/fyb4nrSn1twwmvd4I47w5A5VFQXwO761D6y2rXsF1pBJQEDk+JXHPSUL
	TObwOMlBFvJqwnxwPJgOZqq0eSok23bx0zHj8W+6+2WSH0tZje5RAAtPOnvediicD6d8h65035K
	xd8rr3CiggOYdrkIsorGm2++KBUSjU6tsmGQ6K4lh6z6QQnPR8vgNEBr8EW3l1qMFxFHBAisdTL
	4lLQa5YKJZF3u2USCRD8Z+2QKgcJbDBWengl+zRYNl3TLU63h1Jw+c5GtqLprUugliW5F6ru5yJ
	mhb15dH8urgBG7NKUMXXQxygeCwlyT5+HJv8SIKUQ9ygQEtwIWypCGHNMPjZ5bpjDwgr8oxA9Pb
	Q=
X-Google-Smtp-Source: AGHT+IFaQlOGF7jfoGyERZwgjVQMuHS58KgnEBjTc8+8hMqX8KBgv3+roefoce5t6bhohmLXoaL6chlfrguL
X-Received: by 2002:a05:6870:9d8b:b0:315:af55:f439 with SMTP id 586e51a60fabf-319631f7628mr6305558fac.22.1756821069239;
        Tue, 02 Sep 2025 06:51:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-74574388732sm513055a34.8.2025.09.02.06.51.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Sep 2025 06:51:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cdd69ee330so2429339f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756821067; x=1757425867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2y04SbxjLUjPnwt2oUtKi0SQgUAz4PjsMivX8t2meyQ=;
        b=CAg5cbLR5SdtmE5F5MACuIVpelreJjp/qapDAOictCesGCZb7httfpNoUPyHvFN2GR
         N49YeallCASosVOD5ogBWmSAL/f1A7rLtNGJjYkVRYio/elEhCZp143+qN7h8m8y2eMm
         rOelATtg/P7X5kRHhwEqDCjFuHCBKmYtYtsdM=
X-Forwarded-Encrypted: i=1; AJvYcCUWVRKB4eFYbrzL2acqcQ1G19Ghtnz6QH7W33boNHzwhs0RPhp8TlkxOaQr243mToqFC0ju3/hkB/sTJvY=@vger.kernel.org
X-Received: by 2002:a05:6000:2890:b0:3d4:6abb:7df8 with SMTP id ffacd0b85a97d-3d46abb822emr6487908f8f.19.1756821066500;
        Tue, 02 Sep 2025 06:51:06 -0700 (PDT)
X-Received: by 2002:a05:6000:2890:b0:3d4:6abb:7df8 with SMTP id
 ffacd0b85a97d-3d46abb822emr6487881f8f.19.1756821065983; Tue, 02 Sep 2025
 06:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901083701.32365-1-ryasuoka@redhat.com> <20250901083701.32365-2-ryasuoka@redhat.com>
 <0439749a-ed43-4dc8-8025-f7aa1eec10b7@redhat.com>
In-Reply-To: <0439749a-ed43-4dc8-8025-f7aa1eec10b7@redhat.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Tue, 2 Sep 2025 08:50:53 -0500
X-Gm-Features: Ac12FXxXjc3QuYJewNzzTSk87-3c05HPYICcIOyMMi0czQFq3Dw2MEWmXngiWxo
Message-ID: <CAO6MGthz5wJvdhy8S7H6Dg2mmWhLS0H45T0BxhcrpxSbacvkDw@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next 1/1] drm/vmwgfx: add drm_panic support for stdu
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>, zack.rusin@broadcom.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a21d21063dd1c72d"

--000000000000a21d21063dd1c72d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I don't think this is the right approach. It would be better to write
to VRAM and then switch back to legacy mode. That shouldn't require
any allocations or command submissions which are unlikely to succeed
in a panic situation.

On Tue, Sep 2, 2025 at 3:02=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.com=
> wrote:
>
> On 01/09/2025 10:36, Ryosuke Yasuoka wrote:
> > Add drm_panic module for vmwgfx stdu so that panic screen can be
> > displayed on panic.
>
> Thanks for this work.
>
> If I understand correctly, this will draw the panic screen to the vfbo
> buffer, and then in the panic_flush() function, use
> vmw_panic_bo_cpu_blit() to copy that to the guest_memory_bo.
>
> I think it should be easier to directly write the panic screen to the
> guest_memory_bo.
> To write to the guest_memory_bo, you can do something similar as
> vmw_bo_cpu_blit_line(), but using kmap_local_page_try_from_panic()
> instead of kmap_atomic_prot().
>
> You will probably need a custom set_pixel() function, like what I've
> done for i915
> https://elixir.bootlin.com/linux/v6.17-rc4/source/drivers/gpu/drm/xe/disp=
lay/intel_bo.c#L98
>
> Best regards,
>
> --
>
> Jocelyn
>
> >
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> >   drivers/gpu/drm/vmwgfx/vmwgfx_blit.c   |  43 ++++++++
> >   drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c |  11 ++
> >   drivers/gpu/drm/vmwgfx/vmwgfx_drv.h    |   4 +
> >   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c    |  48 +++++++++
> >   drivers/gpu/drm/vmwgfx/vmwgfx_kms.h    |   1 +
> >   drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c   | 139 ++++++++++++++++++++++++=
+
> >   6 files changed, 246 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmw=
gfx/vmwgfx_blit.c
> > index fa5841fda659..d7ed04531249 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> > @@ -514,6 +514,49 @@ static int vmw_external_bo_copy(struct vmw_bo *dst=
, u32 dst_offset,
> >       return ret;
> >   }
> >
> > +/* For drm_panic */
> > +void vmw_panic_bo_cpu_blit(struct vmw_bo *vmw_dst, u32 dst_stride,
> > +                        struct vmw_bo *vmw_src, u32 src_stride,
> > +                        u32 w, u32 h, struct vmw_diff_cpy *diff)
> > +{
> > +     struct ttm_buffer_object *src =3D &vmw_src->tbo;
> > +     struct ttm_buffer_object *dst =3D &vmw_dst->tbo;
> > +     u32 j;
> > +     u32 initial_line =3D 0;
> > +     u32 dst_offset =3D 0;
> > +     u32 src_offset =3D 0;
> > +     int ret =3D 0;
> > +     struct vmw_bo_blit_line_data d =3D {
> > +             .mapped_dst =3D 0,
> > +             .mapped_src =3D 0,
> > +             .dst_addr =3D NULL,
> > +             .src_addr =3D NULL,
> > +             .dst_pages =3D dst->ttm->pages,
> > +             .src_pages =3D src->ttm->pages,
> > +             .dst_num_pages =3D PFN_UP(dst->resource->size),
> > +             .src_num_pages =3D PFN_UP(src->resource->size),
> > +             .dst_prot =3D ttm_io_prot(dst, dst->resource, PAGE_KERNEL=
),
> > +             .src_prot =3D ttm_io_prot(src, src->resource, PAGE_KERNEL=
),
> > +             .diff =3D diff,
> > +     };
> > +
> > +     for (j =3D 0; j < h; ++j) {
> > +             diff->line =3D j + initial_line;
> > +             diff->line_offset =3D dst_offset % dst_stride;
> > +             ret =3D vmw_bo_cpu_blit_line(&d, dst_offset, src_offset, =
w);
> > +             if (ret)
> > +                     goto out;
> > +
> > +             dst_offset +=3D dst_stride;
> > +             src_offset +=3D src_stride;
> > +     }
> > +out:
> > +     if (d.src_addr)
> > +             kunmap_atomic(d.src_addr);
> > +     if (d.dst_addr)
> > +             kunmap_atomic(d.dst_addr);
> > +}
> > +
> >   /**
> >    * vmw_bo_cpu_blit - in-kernel cpu blit.
> >    *
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/v=
mwgfx/vmwgfx_cmdbuf.c
> > index 94e8982f5616..e39cc2f214be 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
> > @@ -983,6 +983,17 @@ void *vmw_cmdbuf_alloc(struct vmw_cmdbuf_man *man,
> >       return header->cmd;
> >   }
> >
> > +/* For drm_panic */
> > +char *vmw_panic_cmdbuf_reserve_cur(struct vmw_cmdbuf_man *man, size_t =
size)
> > +{
> > +     /* Refer to cur without cur_mutex since this func is called in pa=
nic handler */
> > +     struct vmw_cmdbuf_header *cur =3D man->cur;
> > +
> > +     cur->reserved =3D size;
> > +
> > +     return (char *) (man->cur->cmd + man->cur_pos);
> > +}
> > +
> >   /**
> >    * vmw_cmdbuf_reserve_cur - Reserve space for commands in the current
> >    * command buffer.
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwg=
fx/vmwgfx_drv.h
> > index eda5b6f8f4c4..c71ce975bf52 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> > @@ -1271,6 +1271,7 @@ extern int vmw_cmdbuf_idle(struct vmw_cmdbuf_man =
*man, bool interruptible,
> >   extern void *vmw_cmdbuf_reserve(struct vmw_cmdbuf_man *man, size_t si=
ze,
> >                               int ctx_id, bool interruptible,
> >                               struct vmw_cmdbuf_header *header);
> > +extern char *vmw_panic_cmdbuf_reserve_cur(struct vmw_cmdbuf_man *man, =
size_t size);
> >   extern void vmw_cmdbuf_commit(struct vmw_cmdbuf_man *man, size_t size=
,
> >                             struct vmw_cmdbuf_header *header,
> >                             bool flush);
> > @@ -1329,6 +1330,9 @@ int vmw_bo_cpu_blit(struct vmw_bo *dst,
> >                   u32 src_offset, u32 src_stride,
> >                   u32 w, u32 h,
> >                   struct vmw_diff_cpy *diff);
> > +void vmw_panic_bo_cpu_blit(struct vmw_bo *dst, u32 dst_stride,
> > +                        struct vmw_bo *src, u32 src_stride,
> > +                        u32 w, u32 h, struct vmw_diff_cpy *diff);
> >
> >   /* Host messaging -vmwgfx_msg.c: */
> >   void vmw_disable_backdoor(void);
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_kms.c
> > index 54ea1b513950..160a4efbf342 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> > @@ -1717,6 +1717,54 @@ void vmw_kms_lost_device(struct drm_device *dev)
> >       drm_atomic_helper_shutdown(dev);
> >   }
> >
> > +/* For drm_panic */
> > +int vmw_du_panic_helper_plane_update(struct vmw_du_update_plane *updat=
e)
> > +{
> > +     struct drm_plane_state *state =3D update->plane->state;
> > +     struct vmw_framebuffer_bo *vfbbo =3D
> > +             container_of(update->vfb, typeof(*vfbbo), base);
> > +     struct drm_rect src =3D drm_plane_state_src(state);
> > +     struct drm_rect clip =3D {
> > +             .x1 =3D 0,
> > +             .y1 =3D 0,
> > +             .x2 =3D (src.x2 >> 16) + !!(src.x2 & 0xFFFF),
> > +             .y2 =3D (src.y2 >> 16) + !!(src.y2 & 0xFFFF),
> > +     };
> > +     DECLARE_VAL_CONTEXT(val_ctx, NULL, 0);
> > +     uint32_t reserved_size =3D 0;
> > +     uint32_t submit_size =3D 0;
> > +     char *cmd;
> > +     int ret;
> > +
> > +     vmw_bo_placement_set(vfbbo->buffer,
> > +                          VMW_BO_DOMAIN_SYS | VMW_BO_DOMAIN_MOB | VMW_=
BO_DOMAIN_GMR,
> > +                          VMW_BO_DOMAIN_SYS | VMW_BO_DOMAIN_MOB | VMW_=
BO_DOMAIN_GMR);
> > +
> > +     ret =3D vmw_validation_add_bo(&val_ctx, vfbbo->buffer);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D vmw_validation_prepare(&val_ctx, NULL, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     reserved_size =3D update->calc_fifo_size(update, 1);
> > +     cmd =3D vmw_panic_cmdbuf_reserve_cur(update->dev_priv->cman, rese=
rved_size);
> > +     if (!cmd)
> > +             return -ENOMEM;
> > +
> > +     vmw_du_translate_to_crtc(state, &clip);
> > +
> > +     update->clip(update, cmd, &clip, 0, 0);
> > +     submit_size =3D update->post_clip(update, cmd, &clip);
> > +
> > +     vmw_cmd_commit(update->dev_priv, submit_size);
> > +
> > +     vmw_kms_helper_validation_finish(update->dev_priv, NULL, &val_ctx=
,
> > +                                      NULL, NULL);
> > +     return ret;
> > +}
> > +
> >   /**
> >    * vmw_du_helper_plane_update - Helper to do plane update on a displa=
y unit.
> >    * @update: The closure structure.
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwg=
fx/vmwgfx_kms.h
> > index 445471fe9be6..e6299390ffea 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> > @@ -499,6 +499,7 @@ int vmw_kms_stdu_readback(struct vmw_private *dev_p=
riv,
> >                         struct drm_crtc *crtc);
> >
> >   int vmw_du_helper_plane_update(struct vmw_du_update_plane *update);
> > +int vmw_du_panic_helper_plane_update(struct vmw_du_update_plane *updat=
e);
> >
> >   /**
> >    * vmw_du_translate_to_crtc - Translate a rect from framebuffer to cr=
tc
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmw=
gfx/vmwgfx_stdu.c
> > index 20aab725e53a..65b41338c620 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> > @@ -36,6 +36,7 @@
> >   #include <drm/drm_atomic_helper.h>
> >   #include <drm/drm_damage_helper.h>
> >   #include <drm/drm_fourcc.h>
> > +#include <drm/drm_panic.h>
> >   #include <drm/drm_vblank.h>
> >
> >   #define vmw_crtc_to_stdu(x) \
> > @@ -1164,6 +1165,66 @@ static uint32_t vmw_stdu_bo_clip_cpu(struct vmw_=
du_update_plane  *update,
> >       return 0;
> >   }
> >
> > +/* For drm_panic */
> > +static uint32_t
> > +vmw_stdu_panic_bo_populate_update_cpu(struct vmw_du_update_plane  *upd=
ate, void *cmd,
> > +                                   struct drm_rect *bb)
> > +{
> > +     struct vmw_du_update_plane_buffer *bo_update;
> > +     struct vmw_screen_target_display_unit *stdu;
> > +     struct vmw_framebuffer_bo *vfbbo;
> > +     struct vmw_diff_cpy diff =3D VMW_CPU_BLIT_DIFF_INITIALIZER(0);
> > +     struct vmw_stdu_update_gb_image *cmd_img =3D cmd;
> > +     struct vmw_stdu_update *cmd_update;
> > +     struct vmw_bo *src_bo, *dst_bo;
> > +     s32 src_pitch, dst_pitch;
> > +     s32 width, height;
> > +
> > +     bo_update =3D container_of(update, typeof(*bo_update), base);
> > +     stdu =3D container_of(update->du, typeof(*stdu), base);
> > +     vfbbo =3D container_of(update->vfb, typeof(*vfbbo), base);
> > +
> > +     width =3D bb->x2;
> > +     height =3D bb->y2;
> > +
> > +     diff.cpp =3D stdu->cpp;
> > +
> > +     dst_bo =3D stdu->display_srf->res.guest_memory_bo;
> > +     dst_pitch =3D stdu->display_srf->metadata.base_size.width * stdu-=
>cpp;
> > +
> > +     src_bo =3D vfbbo->buffer;
> > +     src_pitch =3D update->vfb->base.pitches[0];
> > +
> > +     vmw_panic_bo_cpu_blit(dst_bo, dst_pitch, src_bo, src_pitch,
> > +                           width * stdu->cpp, height, &diff);
> > +
> > +     if (drm_rect_visible(&diff.rect)) {
> > +             SVGA3dBox *box =3D &cmd_img->body.box;
> > +
> > +             cmd_img->header.id =3D SVGA_3D_CMD_UPDATE_GB_IMAGE;
> > +             cmd_img->header.size =3D sizeof(cmd_img->body);
> > +             cmd_img->body.image.sid =3D stdu->display_srf->res.id;
> > +             cmd_img->body.image.face =3D 0;
> > +             cmd_img->body.image.mipmap =3D 0;
> > +
> > +             box->x =3D diff.rect.x1;
> > +             box->y =3D diff.rect.y1;
> > +             box->z =3D 0;
> > +             box->w =3D drm_rect_width(&diff.rect);
> > +             box->h =3D drm_rect_height(&diff.rect);
> > +             box->d =3D 1;
> > +
> > +             cmd_update =3D (struct vmw_stdu_update *)&cmd_img[1];
> > +             vmw_stdu_populate_update(cmd_update, stdu->base.unit,
> > +                                      diff.rect.x1, diff.rect.x2,
> > +                                      diff.rect.y1, diff.rect.y2);
> > +
> > +             return sizeof(*cmd_img) + sizeof(*cmd_update);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static uint32_t
> >   vmw_stdu_bo_populate_update_cpu(struct vmw_du_update_plane  *update, =
void *cmd,
> >                               struct drm_rect *bb)
> > @@ -1228,6 +1289,28 @@ vmw_stdu_bo_populate_update_cpu(struct vmw_du_up=
date_plane  *update, void *cmd,
> >       return 0;
> >   }
> >
> > +/* For drm_panic */
> > +static int vmw_stdu_panic_plane_update_bo(struct vmw_private *dev_priv=
,
> > +                                       struct drm_plane *plane,
> > +                                       struct vmw_framebuffer *vfb)
> > +{
> > +     struct vmw_du_update_plane_buffer bo_update;
> > +
> > +     memset(&bo_update, 0, sizeof(struct vmw_du_update_plane_buffer));
> > +     bo_update.base.plane =3D plane;
> > +     bo_update.base.old_state =3D plane->state;
> > +     bo_update.base.dev_priv =3D dev_priv;
> > +     bo_update.base.du =3D vmw_crtc_to_du(plane->state->crtc);
> > +     bo_update.base.vfb =3D vfb;
> > +
> > +     bo_update.base.calc_fifo_size =3D vmw_stdu_bo_fifo_size_cpu;
> > +     bo_update.base.pre_clip =3D vmw_stdu_bo_pre_clip_cpu;
> > +     bo_update.base.clip =3D vmw_stdu_bo_clip_cpu;
> > +     bo_update.base.post_clip =3D vmw_stdu_panic_bo_populate_update_cp=
u;
> > +
> > +     return vmw_du_panic_helper_plane_update(&bo_update.base);
> > +}
> > +
> >   /**
> >    * vmw_stdu_plane_update_bo - Update display unit for bo backed fb.
> >    * @dev_priv: device private.
> > @@ -1458,6 +1541,60 @@ vmw_stdu_primary_plane_atomic_update(struct drm_=
plane *plane,
> >               vmw_fence_obj_unreference(&fence);
> >   }
> >
> > +static int
> > +vmw_stdu_primary_plane_get_scanout_buffer(struct drm_plane *plane,
> > +                                       struct drm_scanout_buffer *sb)
> > +{
> > +     struct vmw_framebuffer *vfb;
> > +     struct vmw_framebuffer_bo *vfbbo;
> > +     void *virtual;
> > +
> > +     if (!plane->state || !plane->state->fb || !plane->state->visible)
> > +             return -ENODEV;
> > +
> > +     vfb =3D vmw_framebuffer_to_vfb(plane->state->fb);
> > +
> > +     if (!vfb->bo)
> > +             return -ENODEV;
> > +
> > +     vfbbo =3D container_of(vfb, typeof(*vfbbo), base);
> > +     virtual =3D vmw_bo_map_and_cache(vfbbo->buffer);
> > +     if (!virtual)
> > +             return -ENODEV;
> > +     iosys_map_set_vaddr(&sb->map[0], virtual);
> > +
> > +     sb->format =3D plane->state->fb->format;
> > +     sb->width =3D plane->state->fb->width;
> > +     sb->height =3D plane->state->fb->height;
> > +     sb->pitch[0] =3D plane->state->fb->pitches[0];
> > +
> > +     return 0;
> > +}
> > +
> > +static void vmw_stdu_primary_plane_panic_flush(struct drm_plane *plane=
)
> > +{
> > +     struct drm_plane_state *state =3D plane->state;
> > +     struct vmw_plane_state *vps =3D vmw_plane_state_to_vps(state);
> > +     struct drm_crtc *crtc =3D state->crtc;
> > +     struct vmw_private *dev_priv =3D vmw_priv(crtc->dev);
> > +     struct vmw_framebuffer *vfb =3D vmw_framebuffer_to_vfb(state->fb)=
;
> > +     struct vmw_screen_target_display_unit *stdu =3D vmw_crtc_to_stdu(=
crtc);
> > +     int ret;
> > +
> > +     stdu->display_srf =3D vmw_user_object_surface(&vps->uo);
> > +     stdu->content_fb_type =3D vps->content_fb_type;
> > +     stdu->cpp =3D vps->cpp;
> > +
> > +     ret =3D vmw_stdu_bind_st(dev_priv, stdu, &stdu->display_srf->res)=
;
> > +     if (ret)
> > +             DRM_ERROR("Failed to bind surface to STDU.\n");
> > +
> > +     if (vfb->bo)
> > +             ret =3D vmw_stdu_panic_plane_update_bo(dev_priv, plane, v=
fb);
> > +     if (ret)
> > +             DRM_ERROR("Failed to update STDU.\n");
> > +}
> > +
> >   static void
> >   vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
> >                          struct drm_atomic_state *state)
> > @@ -1506,6 +1643,8 @@ drm_plane_helper_funcs vmw_stdu_primary_plane_hel=
per_funcs =3D {
> >       .atomic_update =3D vmw_stdu_primary_plane_atomic_update,
> >       .prepare_fb =3D vmw_stdu_primary_plane_prepare_fb,
> >       .cleanup_fb =3D vmw_stdu_primary_plane_cleanup_fb,
> > +     .get_scanout_buffer =3D vmw_stdu_primary_plane_get_scanout_buffer=
,
> > +     .panic_flush =3D vmw_stdu_primary_plane_panic_flush,
> >   };
> >
> >   static const struct drm_crtc_helper_funcs vmw_stdu_crtc_helper_funcs =
=3D {
>

--000000000000a21d21063dd1c72d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
V0fYJUiKJMCwvDmndOil8EtMA8j2T6taUZoQINiKQ0oDWgY6eYVv7AdPVIeOOs3noCyUL8AyA7Bl
yoOPBB2/gk8VGcolEKgAAj+3hPbBF/d19x1bZzU3wABizBomVwykx5ms1nVXDbQajz8jqYECKWh9
3OMo7BuC3TAClu5mLr2zs0Ccpp6NRRkjTF8WtCJ+jSnjFJGLAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2lhbi5mb3JiZXNAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSvJWzgGK7aSByS+CQVBVfM
Xgm5azANBgkqhkiG9w0BAQsFAAOCAgEAfrWiLF3zrYq7D+KPNRaAP70FbxHeaiUfn27Hbu37Eefz
xeJTcFZH04IEtXqpM3NWYZm4A/dFn/VQPbLCRaeXzpT2TESVH6EFY7BEF0rnSSlUbFyi000MnSH3
h5m+MoyE+PzLqfzLBZS+EU/haCpPy6Nqhs3fPKG3w5VTnUPsAxXK7rSmkIDVNsvwRttuMq9KHJzH
Bx51dP/z3mel4OuMjgrwHk5uNY1Sn1MZAUQztVUsWguyfoKcmhxXbBccR5DdEfBgDEbq8bicPQ3J
kqEy1QZXJfHlJuAJIiEw7odGctwqLeGCU6cBLhnsg54ngjO3uYC6tIySul55MRxFKE8HIwIrx+D5
2SwhDeVLZ8sTK40uPzW5xg5laOWVCvmy2b+cHCGzarUeIlYdtw0ejdH9Hbkm0G7IrDvjkhPa64gR
6Q+m5CGRDk+8iWhieH6WFE4HL++BpZhoi+YsOkGU3DK0dA+pxQnXNcNw1s0eNbSUVwQzmlC4LqiK
Gj5JV81HTPLhoAya57a9i28Fp5qHZiFnCq4HMvwiwY7IWe+UwUuueU199aTK80xNiS553vHc6FpI
/vxGy+LveJqEtodfKqQKwDOVu//c1Lz3uergJHqFYTMykk5U95J3FG5q/7Mqe4RF6E9OgtuAJidS
6Ca5anjLQ/qzIfTjoXX7TJSjPztehRQxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgx2/5+PPF/QoW30N7swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEi5
6SdQLH2D2MWEPW1TABFCrHK+vKz20WQOwR/3BKrXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MDkwMjEzNTEwN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAI0g3SYxYpIBofux2xXd/acmrtisnQI9Lkr9LUyx
HArscUMeDBX/RdKNgE7H/Ly3C1HXAbnWlSoy69YhyHq8s6rcufprNyGRpPd48NhqXdk4mQx79VWn
rrN7HuBHvYEgN+NZz4rQ0gfT/WzDxCyVag+lYWQocevuHVPud2A0VQxwIvib7oUqIvCIUc+zsrxi
3nLm7rExFUxHDVZZKjleNHCfXeNKViUC5lR5AK7lNWjHsQPgA+8/tW3lbKiIkCedMJCsotHLTGtl
ZsdNvUtXmkI7jxVQS7bcsx3pRgwKl+Vs30qgN5gPn5UfisLgpP47PcDQgpVniHnSmWZSEGiBSwY=
--000000000000a21d21063dd1c72d--

