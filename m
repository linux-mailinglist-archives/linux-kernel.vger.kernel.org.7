Return-Path: <linux-kernel+bounces-796999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00029B40A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2C4162EED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30C3314C8;
	Tue,  2 Sep 2025 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfPQSswz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C5322743
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830496; cv=none; b=R4XrRfdbKxxGUckR1DESw8+i82yE/K3VDm+srRAy+alGhwp6trGz4qZgU5/3az/w21S9icvX29g6mqPEebo5VgkjbuVfAb7TDUcz77Oss2y9nCH5fQlpd1Wxh8vwM72EGFTnjuCL33XcxGUUFZVCrC/5WAYKEGo9EcZ6ygDuhAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830496; c=relaxed/simple;
	bh=svINLsSJMh/BcPoBz2XfKr3O0GfkyI08Pu4Zg7tytXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRaU4D44LFy2SSnX9nilzUGsBerjC/4S/zTUOET8cSzIU6KUEOUBbpYYXeM4hHuuPADTEynVAtXc2q8BZ9HvnB9gaA+b2TaDTBoWiRvsXqCiUvzSlaI05jNLY1JALozMQsa+0KMqmE/YCoquOPCsg3FXQ18veKKeehiKBUxYLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfPQSswz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756830493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzmLw/jjBIBGG3Rql/Mctp6+GwqPNw3WmAgzj7f/Q4g=;
	b=GfPQSswzAPT/JO7XgLXfSJDdS9Y/0wRnKaEppBNdEjKBwjv0c5Y7l+yU4dsAoFfp+5Lyfi
	dOmC/dWJ1jX6O60JEyAVFth5u/AZyeomeduaE6AoCFa/u+u8ubrwCKSeCC1sZVglnFIKex
	8dH615ZkLpsnbsSD0JApyPYkwr00dB4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611--cAppG0COK2lpW5wx2rR6Q-1; Tue, 02 Sep 2025 12:28:11 -0400
X-MC-Unique: -cAppG0COK2lpW5wx2rR6Q-1
X-Mimecast-MFC-AGG-ID: -cAppG0COK2lpW5wx2rR6Q_1756830491
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24868b07b5bso109419615ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830491; x=1757435291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzmLw/jjBIBGG3Rql/Mctp6+GwqPNw3WmAgzj7f/Q4g=;
        b=QgseNAeo+6zs+BKzek20mOInZNVakD6Yoiv2N+ZgEQFPffI/G/K0z7fHt8NpNGMPuc
         NpSD2gufbC8XGcYFMzdaOgy7hfYk2CMclU4iK6mf/eHkiFY+j3BounB6FTTgrsHv0MBV
         kRakJVIWJ5utm2mvF0edLICOvEoLasHrdjKkG3NkHzRKNQfG00EBj/o0PdeT3xNQDXqK
         KDZIcrSWOzSEUJN9r6OvowXsuKYvZY3GfAouSxj9E1m97+6LcEbyIkbXPjXt9jkpafLr
         IN+dpOmED6dnzn0XNDbJtoJpy1CS/J+mEbkapBe9dJ5puY1HwLzC8ho46YrKbGwg5kLr
         CUPA==
X-Forwarded-Encrypted: i=1; AJvYcCVgjxVfTQ2dv2tfTFVu5ASTGTJ6d6nHOvxiRYkc9Cv6YvIjrUpOns3dVkTKv7FP4HG1ubYXjx4ssTvXpQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwenbdW3sDdOGNnyhQcEcmo/lV2MEB1ffkvf3MylLh8qL+dA/zi
	1FO81ofssBzZCHgDeldfQUOcti0cRgfDlvNWBi6FmeGwSDWLnFaml9CtFDXxWMaAv6ifKll06kZ
	M0y+xoj1QvqIjsKSkS/2LEidGRCRfinIET8Y6P6X66UQn/FA9lNTPRAM/l6yLpuEqtA==
X-Gm-Gg: ASbGncu9uvNk1HEIPzkodcPUhkr0OT82cG51HMD+1VNISFGOhlRGntEKgHQ8E3itD8e
	L8Yd+JXf9fkxt+iMn24gxKvVpRO02fRBY/rTNTSXZ30yxI6YkETHC7R8u+JsBvCtgyD4scus5vz
	bqGp3yufrnnpab58jwsDloaBPgbHQHQmsgVW2iJucHQS+Sn1Ow0P5Xhgw0JMoGO7divB09G2XKu
	SLY2WKi0YSvxjgV0t+Nu7cORuDRz/5CRg0oa2sl+7MYs3Eq5yLFo/btOAAbVWPpxyaAzwV2Q+DC
	RmhXxkvoLCLgBd4UPncryyZNvhJFXHeFV2E=
X-Received: by 2002:a17:903:28c:b0:245:f2c2:64ed with SMTP id d9443c01a7336-24944a742f8mr153498295ad.24.1756830490453;
        Tue, 02 Sep 2025 09:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS4SMqa6PLQjub5Ko6ZZQlU9+VjJO01QNgYca+p7Knt00OkVx3G0kdDVhfbg8U2FoI2kfBlA==
X-Received: by 2002:a17:903:28c:b0:245:f2c2:64ed with SMTP id d9443c01a7336-24944a742f8mr153497815ad.24.1756830489772;
        Tue, 02 Sep 2025 09:28:09 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490372734asm137661735ad.42.2025.09.02.09.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:28:09 -0700 (PDT)
Date: Wed, 3 Sep 2025 01:28:05 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Ian Forbes <ian.forbes@broadcom.com>,
	Jocelyn Falempe <jfalempe@redhat.com>
Cc: zack.rusin@broadcom.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next 1/1] drm/vmwgfx: add drm_panic support for
 stdu
Message-ID: <aLcbFSrUPhwN1vqS@zeus>
References: <20250901083701.32365-1-ryasuoka@redhat.com>
 <20250901083701.32365-2-ryasuoka@redhat.com>
 <0439749a-ed43-4dc8-8025-f7aa1eec10b7@redhat.com>
 <CAO6MGthz5wJvdhy8S7H6Dg2mmWhLS0H45T0BxhcrpxSbacvkDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO6MGthz5wJvdhy8S7H6Dg2mmWhLS0H45T0BxhcrpxSbacvkDw@mail.gmail.com>

On Tue, Sep 02, 2025 at 08:50:53AM -0500, Ian Forbes wrote:
> I don't think this is the right approach. It would be better to write
> to VRAM and then switch back to legacy mode. That shouldn't require
> any allocations or command submissions which are unlikely to succeed
> in a panic situation.
> 
> On Tue, Sep 2, 2025 at 3:02 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
> >
> > On 01/09/2025 10:36, Ryosuke Yasuoka wrote:
> > > Add drm_panic module for vmwgfx stdu so that panic screen can be
> > > displayed on panic.
> >
> > Thanks for this work.
> >
> > If I understand correctly, this will draw the panic screen to the vfbo
> > buffer, and then in the panic_flush() function, use
> > vmw_panic_bo_cpu_blit() to copy that to the guest_memory_bo.
> >
> > I think it should be easier to directly write the panic screen to the
> > guest_memory_bo.
> > To write to the guest_memory_bo, you can do something similar as
> > vmw_bo_cpu_blit_line(), but using kmap_local_page_try_from_panic()
> > instead of kmap_atomic_prot().
> >
> > You will probably need a custom set_pixel() function, like what I've
> > done for i915
> > https://elixir.bootlin.com/linux/v6.17-rc4/source/drivers/gpu/drm/xe/display/intel_bo.c#L98

Thank you for your valuable comments, Jocelyn and Ian.

Based on your all comments, my next plan is to write the panic screen 
to some bo directly, pass them to a VRAM, and output it using 
legacy mode.

Ian, I have a clarifying question regarding your suggestion to "switch
back to legacy mode". Could you please elaborate on what this entails?
I've found some possibly related code like vmw_ldu_fb_pin(), but I'm not
sure if my understanding is correct.

As I am new to this vmwgfx driver, any information or pointers on which
I should check would be greatly appreciated.

Regards,
Ryosuke

> > Best regards,
> >
> > --
> >
> > Jocelyn
> >
> > >
> > > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > > ---
> > >   drivers/gpu/drm/vmwgfx/vmwgfx_blit.c   |  43 ++++++++
> > >   drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c |  11 ++
> > >   drivers/gpu/drm/vmwgfx/vmwgfx_drv.h    |   4 +
> > >   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c    |  48 +++++++++
> > >   drivers/gpu/drm/vmwgfx/vmwgfx_kms.h    |   1 +
> > >   drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c   | 139 +++++++++++++++++++++++++
> > >   6 files changed, 246 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> > > index fa5841fda659..d7ed04531249 100644
> > > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> > > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> > > @@ -514,6 +514,49 @@ static int vmw_external_bo_copy(struct vmw_bo *dst, u32 dst_offset,
> > >       return ret;
> > >   }
> > >
> > > +/* For drm_panic */
> > > +void vmw_panic_bo_cpu_blit(struct vmw_bo *vmw_dst, u32 dst_stride,
> > > +                        struct vmw_bo *vmw_src, u32 src_stride,
> > > +                        u32 w, u32 h, struct vmw_diff_cpy *diff)
> > > +{
> > > +     struct ttm_buffer_object *src = &vmw_src->tbo;
> > > +     struct ttm_buffer_object *dst = &vmw_dst->tbo;
> > > +     u32 j;
> > > +     u32 initial_line = 0;
> > > +     u32 dst_offset = 0;
> > > +     u32 src_offset = 0;
> > > +     int ret = 0;
> > > +     struct vmw_bo_blit_line_data d = {
> > > +             .mapped_dst = 0,
> > > +             .mapped_src = 0,
> > > +             .dst_addr = NULL,
> > > +             .src_addr = NULL,
> > > +             .dst_pages = dst->ttm->pages,
> > > +             .src_pages = src->ttm->pages,
> > > +             .dst_num_pages = PFN_UP(dst->resource->size),
> > > +             .src_num_pages = PFN_UP(src->resource->size),
> > > +             .dst_prot = ttm_io_prot(dst, dst->resource, PAGE_KERNEL),
> > > +             .src_prot = ttm_io_prot(src, src->resource, PAGE_KERNEL),
> > > +             .diff = diff,
> > > +     };
> > > +
> > > +     for (j = 0; j < h; ++j) {
> > > +             diff->line = j + initial_line;
> > > +             diff->line_offset = dst_offset % dst_stride;
> > > +             ret = vmw_bo_cpu_blit_line(&d, dst_offset, src_offset, w);
> > > +             if (ret)
> > > +                     goto out;
> > > +
> > > +             dst_offset += dst_stride;
> > > +             src_offset += src_stride;
> > > +     }
> > > +out:
> > > +     if (d.src_addr)
> > > +             kunmap_atomic(d.src_addr);
> > > +     if (d.dst_addr)
> > > +             kunmap_atomic(d.dst_addr);
> > > +}
> > > +
> > >   /**
> > >    * vmw_bo_cpu_blit - in-kernel cpu blit.
> > >    *
> > > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
> > > index 94e8982f5616..e39cc2f214be 100644
> > > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
> > > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
> > > @@ -983,6 +983,17 @@ void *vmw_cmdbuf_alloc(struct vmw_cmdbuf_man *man,
> > >       return header->cmd;
> > >   }
> > >
> > > +/* For drm_panic */
> > > +char *vmw_panic_cmdbuf_reserve_cur(struct vmw_cmdbuf_man *man, size_t size)
> > > +{
> > > +     /* Refer to cur without cur_mutex since this func is called in panic handler */
> > > +     struct vmw_cmdbuf_header *cur = man->cur;
> > > +
> > > +     cur->reserved = size;
> > > +
> > > +     return (char *) (man->cur->cmd + man->cur_pos);
> > > +}
> > > +
> > >   /**
> > >    * vmw_cmdbuf_reserve_cur - Reserve space for commands in the current
> > >    * command buffer.
> > > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> > > index eda5b6f8f4c4..c71ce975bf52 100644
> > > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> > > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> > > @@ -1271,6 +1271,7 @@ extern int vmw_cmdbuf_idle(struct vmw_cmdbuf_man *man, bool interruptible,
> > >   extern void *vmw_cmdbuf_reserve(struct vmw_cmdbuf_man *man, size_t size,
> > >                               int ctx_id, bool interruptible,
> > >                               struct vmw_cmdbuf_header *header);
> > > +extern char *vmw_panic_cmdbuf_reserve_cur(struct vmw_cmdbuf_man *man, size_t size);
> > >   extern void vmw_cmdbuf_commit(struct vmw_cmdbuf_man *man, size_t size,
> > >                             struct vmw_cmdbuf_header *header,
> > >                             bool flush);
> > > @@ -1329,6 +1330,9 @@ int vmw_bo_cpu_blit(struct vmw_bo *dst,
> > >                   u32 src_offset, u32 src_stride,
> > >                   u32 w, u32 h,
> > >                   struct vmw_diff_cpy *diff);
> > > +void vmw_panic_bo_cpu_blit(struct vmw_bo *dst, u32 dst_stride,
> > > +                        struct vmw_bo *src, u32 src_stride,
> > > +                        u32 w, u32 h, struct vmw_diff_cpy *diff);
> > >
> > >   /* Host messaging -vmwgfx_msg.c: */
> > >   void vmw_disable_backdoor(void);
> > > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> > > index 54ea1b513950..160a4efbf342 100644
> > > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> > > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> > > @@ -1717,6 +1717,54 @@ void vmw_kms_lost_device(struct drm_device *dev)
> > >       drm_atomic_helper_shutdown(dev);
> > >   }
> > >
> > > +/* For drm_panic */
> > > +int vmw_du_panic_helper_plane_update(struct vmw_du_update_plane *update)
> > > +{
> > > +     struct drm_plane_state *state = update->plane->state;
> > > +     struct vmw_framebuffer_bo *vfbbo =
> > > +             container_of(update->vfb, typeof(*vfbbo), base);
> > > +     struct drm_rect src = drm_plane_state_src(state);
> > > +     struct drm_rect clip = {
> > > +             .x1 = 0,
> > > +             .y1 = 0,
> > > +             .x2 = (src.x2 >> 16) + !!(src.x2 & 0xFFFF),
> > > +             .y2 = (src.y2 >> 16) + !!(src.y2 & 0xFFFF),
> > > +     };
> > > +     DECLARE_VAL_CONTEXT(val_ctx, NULL, 0);
> > > +     uint32_t reserved_size = 0;
> > > +     uint32_t submit_size = 0;
> > > +     char *cmd;
> > > +     int ret;
> > > +
> > > +     vmw_bo_placement_set(vfbbo->buffer,
> > > +                          VMW_BO_DOMAIN_SYS | VMW_BO_DOMAIN_MOB | VMW_BO_DOMAIN_GMR,
> > > +                          VMW_BO_DOMAIN_SYS | VMW_BO_DOMAIN_MOB | VMW_BO_DOMAIN_GMR);
> > > +
> > > +     ret = vmw_validation_add_bo(&val_ctx, vfbbo->buffer);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = vmw_validation_prepare(&val_ctx, NULL, false);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     reserved_size = update->calc_fifo_size(update, 1);
> > > +     cmd = vmw_panic_cmdbuf_reserve_cur(update->dev_priv->cman, reserved_size);
> > > +     if (!cmd)
> > > +             return -ENOMEM;
> > > +
> > > +     vmw_du_translate_to_crtc(state, &clip);
> > > +
> > > +     update->clip(update, cmd, &clip, 0, 0);
> > > +     submit_size = update->post_clip(update, cmd, &clip);
> > > +
> > > +     vmw_cmd_commit(update->dev_priv, submit_size);
> > > +
> > > +     vmw_kms_helper_validation_finish(update->dev_priv, NULL, &val_ctx,
> > > +                                      NULL, NULL);
> > > +     return ret;
> > > +}
> > > +
> > >   /**
> > >    * vmw_du_helper_plane_update - Helper to do plane update on a display unit.
> > >    * @update: The closure structure.
> > > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> > > index 445471fe9be6..e6299390ffea 100644
> > > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> > > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> > > @@ -499,6 +499,7 @@ int vmw_kms_stdu_readback(struct vmw_private *dev_priv,
> > >                         struct drm_crtc *crtc);
> > >
> > >   int vmw_du_helper_plane_update(struct vmw_du_update_plane *update);
> > > +int vmw_du_panic_helper_plane_update(struct vmw_du_update_plane *update);
> > >
> > >   /**
> > >    * vmw_du_translate_to_crtc - Translate a rect from framebuffer to crtc
> > > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> > > index 20aab725e53a..65b41338c620 100644
> > > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> > > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> > > @@ -36,6 +36,7 @@
> > >   #include <drm/drm_atomic_helper.h>
> > >   #include <drm/drm_damage_helper.h>
> > >   #include <drm/drm_fourcc.h>
> > > +#include <drm/drm_panic.h>
> > >   #include <drm/drm_vblank.h>
> > >
> > >   #define vmw_crtc_to_stdu(x) \
> > > @@ -1164,6 +1165,66 @@ static uint32_t vmw_stdu_bo_clip_cpu(struct vmw_du_update_plane  *update,
> > >       return 0;
> > >   }
> > >
> > > +/* For drm_panic */
> > > +static uint32_t
> > > +vmw_stdu_panic_bo_populate_update_cpu(struct vmw_du_update_plane  *update, void *cmd,
> > > +                                   struct drm_rect *bb)
> > > +{
> > > +     struct vmw_du_update_plane_buffer *bo_update;
> > > +     struct vmw_screen_target_display_unit *stdu;
> > > +     struct vmw_framebuffer_bo *vfbbo;
> > > +     struct vmw_diff_cpy diff = VMW_CPU_BLIT_DIFF_INITIALIZER(0);
> > > +     struct vmw_stdu_update_gb_image *cmd_img = cmd;
> > > +     struct vmw_stdu_update *cmd_update;
> > > +     struct vmw_bo *src_bo, *dst_bo;
> > > +     s32 src_pitch, dst_pitch;
> > > +     s32 width, height;
> > > +
> > > +     bo_update = container_of(update, typeof(*bo_update), base);
> > > +     stdu = container_of(update->du, typeof(*stdu), base);
> > > +     vfbbo = container_of(update->vfb, typeof(*vfbbo), base);
> > > +
> > > +     width = bb->x2;
> > > +     height = bb->y2;
> > > +
> > > +     diff.cpp = stdu->cpp;
> > > +
> > > +     dst_bo = stdu->display_srf->res.guest_memory_bo;
> > > +     dst_pitch = stdu->display_srf->metadata.base_size.width * stdu->cpp;
> > > +
> > > +     src_bo = vfbbo->buffer;
> > > +     src_pitch = update->vfb->base.pitches[0];
> > > +
> > > +     vmw_panic_bo_cpu_blit(dst_bo, dst_pitch, src_bo, src_pitch,
> > > +                           width * stdu->cpp, height, &diff);
> > > +
> > > +     if (drm_rect_visible(&diff.rect)) {
> > > +             SVGA3dBox *box = &cmd_img->body.box;
> > > +
> > > +             cmd_img->header.id = SVGA_3D_CMD_UPDATE_GB_IMAGE;
> > > +             cmd_img->header.size = sizeof(cmd_img->body);
> > > +             cmd_img->body.image.sid = stdu->display_srf->res.id;
> > > +             cmd_img->body.image.face = 0;
> > > +             cmd_img->body.image.mipmap = 0;
> > > +
> > > +             box->x = diff.rect.x1;
> > > +             box->y = diff.rect.y1;
> > > +             box->z = 0;
> > > +             box->w = drm_rect_width(&diff.rect);
> > > +             box->h = drm_rect_height(&diff.rect);
> > > +             box->d = 1;
> > > +
> > > +             cmd_update = (struct vmw_stdu_update *)&cmd_img[1];
> > > +             vmw_stdu_populate_update(cmd_update, stdu->base.unit,
> > > +                                      diff.rect.x1, diff.rect.x2,
> > > +                                      diff.rect.y1, diff.rect.y2);
> > > +
> > > +             return sizeof(*cmd_img) + sizeof(*cmd_update);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >   static uint32_t
> > >   vmw_stdu_bo_populate_update_cpu(struct vmw_du_update_plane  *update, void *cmd,
> > >                               struct drm_rect *bb)
> > > @@ -1228,6 +1289,28 @@ vmw_stdu_bo_populate_update_cpu(struct vmw_du_update_plane  *update, void *cmd,
> > >       return 0;
> > >   }
> > >
> > > +/* For drm_panic */
> > > +static int vmw_stdu_panic_plane_update_bo(struct vmw_private *dev_priv,
> > > +                                       struct drm_plane *plane,
> > > +                                       struct vmw_framebuffer *vfb)
> > > +{
> > > +     struct vmw_du_update_plane_buffer bo_update;
> > > +
> > > +     memset(&bo_update, 0, sizeof(struct vmw_du_update_plane_buffer));
> > > +     bo_update.base.plane = plane;
> > > +     bo_update.base.old_state = plane->state;
> > > +     bo_update.base.dev_priv = dev_priv;
> > > +     bo_update.base.du = vmw_crtc_to_du(plane->state->crtc);
> > > +     bo_update.base.vfb = vfb;
> > > +
> > > +     bo_update.base.calc_fifo_size = vmw_stdu_bo_fifo_size_cpu;
> > > +     bo_update.base.pre_clip = vmw_stdu_bo_pre_clip_cpu;
> > > +     bo_update.base.clip = vmw_stdu_bo_clip_cpu;
> > > +     bo_update.base.post_clip = vmw_stdu_panic_bo_populate_update_cpu;
> > > +
> > > +     return vmw_du_panic_helper_plane_update(&bo_update.base);
> > > +}
> > > +
> > >   /**
> > >    * vmw_stdu_plane_update_bo - Update display unit for bo backed fb.
> > >    * @dev_priv: device private.
> > > @@ -1458,6 +1541,60 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
> > >               vmw_fence_obj_unreference(&fence);
> > >   }
> > >
> > > +static int
> > > +vmw_stdu_primary_plane_get_scanout_buffer(struct drm_plane *plane,
> > > +                                       struct drm_scanout_buffer *sb)
> > > +{
> > > +     struct vmw_framebuffer *vfb;
> > > +     struct vmw_framebuffer_bo *vfbbo;
> > > +     void *virtual;
> > > +
> > > +     if (!plane->state || !plane->state->fb || !plane->state->visible)
> > > +             return -ENODEV;
> > > +
> > > +     vfb = vmw_framebuffer_to_vfb(plane->state->fb);
> > > +
> > > +     if (!vfb->bo)
> > > +             return -ENODEV;
> > > +
> > > +     vfbbo = container_of(vfb, typeof(*vfbbo), base);
> > > +     virtual = vmw_bo_map_and_cache(vfbbo->buffer);
> > > +     if (!virtual)
> > > +             return -ENODEV;
> > > +     iosys_map_set_vaddr(&sb->map[0], virtual);
> > > +
> > > +     sb->format = plane->state->fb->format;
> > > +     sb->width = plane->state->fb->width;
> > > +     sb->height = plane->state->fb->height;
> > > +     sb->pitch[0] = plane->state->fb->pitches[0];
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void vmw_stdu_primary_plane_panic_flush(struct drm_plane *plane)
> > > +{
> > > +     struct drm_plane_state *state = plane->state;
> > > +     struct vmw_plane_state *vps = vmw_plane_state_to_vps(state);
> > > +     struct drm_crtc *crtc = state->crtc;
> > > +     struct vmw_private *dev_priv = vmw_priv(crtc->dev);
> > > +     struct vmw_framebuffer *vfb = vmw_framebuffer_to_vfb(state->fb);
> > > +     struct vmw_screen_target_display_unit *stdu = vmw_crtc_to_stdu(crtc);
> > > +     int ret;
> > > +
> > > +     stdu->display_srf = vmw_user_object_surface(&vps->uo);
> > > +     stdu->content_fb_type = vps->content_fb_type;
> > > +     stdu->cpp = vps->cpp;
> > > +
> > > +     ret = vmw_stdu_bind_st(dev_priv, stdu, &stdu->display_srf->res);
> > > +     if (ret)
> > > +             DRM_ERROR("Failed to bind surface to STDU.\n");
> > > +
> > > +     if (vfb->bo)
> > > +             ret = vmw_stdu_panic_plane_update_bo(dev_priv, plane, vfb);
> > > +     if (ret)
> > > +             DRM_ERROR("Failed to update STDU.\n");
> > > +}
> > > +
> > >   static void
> > >   vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
> > >                          struct drm_atomic_state *state)
> > > @@ -1506,6 +1643,8 @@ drm_plane_helper_funcs vmw_stdu_primary_plane_helper_funcs = {
> > >       .atomic_update = vmw_stdu_primary_plane_atomic_update,
> > >       .prepare_fb = vmw_stdu_primary_plane_prepare_fb,
> > >       .cleanup_fb = vmw_stdu_primary_plane_cleanup_fb,
> > > +     .get_scanout_buffer = vmw_stdu_primary_plane_get_scanout_buffer,
> > > +     .panic_flush = vmw_stdu_primary_plane_panic_flush,
> > >   };
> > >
> > >   static const struct drm_crtc_helper_funcs vmw_stdu_crtc_helper_funcs = {
> >



