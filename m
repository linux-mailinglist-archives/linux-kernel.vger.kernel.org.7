Return-Path: <linux-kernel+bounces-859883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D504BEEE04
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 00:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2738A3B1F87
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 22:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1623F417;
	Sun, 19 Oct 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="JcLWKVJX"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF2282EB
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760911880; cv=none; b=UjgeLEGywFpOB/rLRIB9UZidOMCm//oO1VN03GkJ1vSDa8VF2hnJws16/lmwZURVqZXQ5skE6d4D+ttZNyZRgYMvi7Rc1KCZRvUTMGVaG5zySyS3h/zp+S7IYTrnXvEIl/Y4SyoWki3TqxabL7+UAXlfMggoYxgK6Wy2JyXUSpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760911880; c=relaxed/simple;
	bh=CFji2GBxIwTjwBWzEkBa3boskHVWwJ0yj1rRtqjDE5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp3XQn8EOD1cLeWxeqG8BPw/ObkprN2pbqozJBmJwnhQ/0pF9wLhatAU8guMsvH6CLjEzd82UF9ncN2F9LOx5kfl86zNrYGkhyjC7nOKuhP6Tp6vSvE8msPfzw9mrI7GQoWmQa0OcHYlZdKeDfPeNTsyMH2grRPebZ/DJz06cHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=JcLWKVJX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so922896b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1760911878; x=1761516678; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ITotXCHgCqdxM2m7biNFUouN5fBGEv3mYrcjHpAyWU=;
        b=JcLWKVJX6HWIfdft0VnYdqYXCAqY+c1ZMwCqO6yVD91650zWLwHq5rEHmTnm2yIU/C
         U9XNC1zsDUMBB4TqfVXws9iTOK++f5HDYiCpdiAjTk6JMdftkTN8PDBJ/E8o6tUpF2Td
         qgzgU4RA6zJOcZRGH9RXpeRelVkcS3QuPuDxXBWhOD4OH2Jl8Ik/WbNLnEqUzaLurZAq
         sr7qfWtzhBPbiclx87Jqbu26KFE5E7z/koQ2nvaVLkytvQKrOQLm2RbrIfjzNfWndfMM
         sJc7OjhePbKKaKSqb5e4NHVI/JSH4SbcUm0hNl9d5jc0Q5f6+s4IlpbNmV33haI1eESb
         Ey6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760911878; x=1761516678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ITotXCHgCqdxM2m7biNFUouN5fBGEv3mYrcjHpAyWU=;
        b=HW5/abY3U1fVTZnDoxuq+8i4/RMzxttW2BUWesgNILEl2nooJnckLqz90C2NtnAROf
         MpOgr6URa/GPkWhtJ2JHpkV7K3IZwiXP1cKB6oZM4IvQrz+q8Tlh5goqs6CW1KKZAO9C
         hzn+Gcf5yFx4wym4+TpXJ7uS8XNuIxl4hRaACY1h7BalnK9KbA/y2W7fgscQskMf/TEC
         DoM81NYpgTsrNF1xwgg0NqQ++4usX3oW8FW7DRzqFcb+QY4cimitjWFeQmmjKdzAQ3Z7
         E3S1P+ME05HAejSGqk96S87MFai/Kdr4SfB86C53s3HCSs1mc+oM+/9JI8ncq4Qozh0l
         SHrg==
X-Forwarded-Encrypted: i=1; AJvYcCWeypgb2Vhp49190Uint2HuFKEm6ACZO+J6eHxt6VBxq3e9VMS4+NL+e2i95URvkIbIrY6wsQ9Bl3BC4B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8NF/y3bCpoQHYR27EapTEurJT11rLYyYt4dtqJ6mV5syLI0/w
	K9dmyIkjV+xooER7K7rfdrDS4TgbTNdPgiRi0fadpbnB6d/6BqB1ynNiuBb1fGTBRUCQ
X-Gm-Gg: ASbGncvx9s8QsuWR43+7tBEDSislLwXinQ6x+F526U4iQ6il80xKvAW6BNzCXtyLGrC
	zxF8+rDDHDi1TPj6VJb+R5litO88fuQnbXx1TeR4+btAKSuOa25s6FOzLhg8JnsnAFqBDj9Lzug
	x0gE4SMUhvQrEUGDF1Lf17+31NK8WKIlnaufRg8VQWb+og8w8MxKUzqLB7nw66bZZtU+B8kDuZP
	7tylu3o/cJqG6J+Jji+/JlYdaf6Zo09w9O0d3dfCSrBxWU2qBEW0F7MOd7xZ3YvkAjyyRVORrKy
	xULxPGYQ7jDZA4MaKs+uE2rcOgM7zuPboKXFjHWqxfNEJhyGHB9AIpC69gukQDMMG2/3vvHeiBT
	XKC+30j3VNFXmkl0yxxnwFdAR5tOzsP9aFZ24wjUpKIUnLJaRusYBTwNUnSlQ0vwdVZLlxak+ln
	nxK/NU+F3KjchCfw==
X-Google-Smtp-Source: AGHT+IHB11KabbcI+ZPShYZBM6U1vgBV9SjX9/XOJTl0fi6uGEKwcUfbZUV6/aX8A3ri1gJR8OXPGg==
X-Received: by 2002:a05:6a00:1783:b0:77f:2dc4:4c16 with SMTP id d2e1a72fcca58-7a220acb8fcmr11428639b3a.21.1760911878008;
        Sun, 19 Oct 2025 15:11:18 -0700 (PDT)
Received: from sultan-box ([142.147.89.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23011084csm6376643b3a.58.2025.10.19.15.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 15:11:17 -0700 (PDT)
Date: Sun, 19 Oct 2025 15:11:13 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, mario.limonciello@amd.com,
	richard.gong@amd.com, anson.tsao@amd.com,
	Alexey Zagorodnikov <xglooom@gmail.com>
Subject: Re: [PATCH v4 5/7] media: platform: amd: isp4 video node and buffers
 handling added
Message-ID: <aPViAdn4Z8OAO1lj@sultan-box>
References: <20250911100847.277408-1-Bin.Du@amd.com>
 <20250911100847.277408-6-Bin.Du@amd.com>
 <aNzP2LH0OwUkMtGb@sultan-box>
 <c28eb905-b578-4512-aa9c-37281d3a0ee4@amd.com>
 <51c24e3d-be89-44c9-8247-95fb776aed78@amd.com>
 <aPH_iHmPFWTrrOQE@sultan-box>
 <3ff43351-9236-43a6-aea8-ab492cc86699@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ff43351-9236-43a6-aea8-ab492cc86699@amd.com>

On Fri, Oct 17, 2025 at 05:53:27PM +0800, Du, Bin wrote:
> On 10/17/2025 4:34 PM, Sultan Alsawaf wrote:
> > On Thu, Oct 16, 2025 at 04:13:47PM +0800, Du, Bin wrote:
> > > On 10/11/2025 5:30 PM, Du, Bin wrote:
> > > > On 10/1/2025 2:53 PM, Sultan Alsawaf wrote:
> > > > > On Thu, Sep 11, 2025 at 06:08:45PM +0800, Bin Du wrote:
> > > > > > +++ b/drivers/media/platform/amd/isp4/isp4.c
> > > > > > @@ -178,6 +178,16 @@ static int isp4_capture_probe(struct
> > > > > > platform_device *pdev)
> > > > > >            goto err_isp4_deinit;
> > > > > >        }
> > > > > > +    ret = media_create_pad_link(&isp_dev->isp_sdev.sdev.entity,
> > > > > > +                    0, &isp_dev->isp_sdev.isp_vdev.vdev.entity,
> > > > > > +                    0,
> > > > > > +                    MEDIA_LNK_FL_ENABLED |
> > > > > > +                    MEDIA_LNK_FL_IMMUTABLE);
> > > > > > +    if (ret) {
> > > > > > +        dev_err(dev, "fail to create pad link %d\n", ret);
> > > > > > +        goto err_isp4_deinit;
> > > > > > +    }
> > > > > > +
> > > > > 
> > > > > Two problems with this hunk:
> > > > > 
> > > > > 1. According to the comment in include/media/media-device.h [1],
> > > > >      media_create_pad_link() should be called before
> > > > > media_device_register():
> > > > > 
> > > > >       * So drivers need to first initialize the media device,
> > > > > register any entity
> > > > >       * within the media device, create pad to pad links and then
> > > > > finally register
> > > > >       * the media device by calling media_device_register() as a
> > > > > final step.
> > > > > 
> > > > > 2. Missing call to media_device_unregister() on error when
> > > > >      media_create_pad_link() fails.
> > > > > 
> > > > > Since the media_create_pad_link() will be moved before
> > > > > media_device_register(),
> > > > > we will need to clean up media_create_pad_link() when
> > > > > media_device_register()
> > > > > fails.
> > > > > 
> > > > > The clean-up function for media_create_pad_link() is
> > > > > media_device_unregister().
> > > > > According to the comment for media_device_unregister() [2], it is
> > > > > safe to call
> > > > > media_device_unregister() on an unregistered media device that is
> > > > > initialized
> > > > > (through media_device_init()).
> > > > > 
> > > > > In addition, this made me realize that there's no call to
> > > > > media_device_cleanup()
> > > > > in the entire driver too. This is the cleanup function for
> > > > > media_device_init(),
> > > > > so it should be called on error and on module unload.
> > > > > 
> > > > > To summarize, make the following changes:
> > > > > 
> > > > > 1. Move the media_create_pad_link() up, right before
> > > > > media_device_register().
> > > > > 
> > > > > 2. When media_device_register() fails, clean up
> > > > > media_create_pad_link() by
> > > > >      calling media_device_unregister().
> > > > > 
> > > > > 3. Add a missing call to media_device_cleanup() on error and module
> > > > > unload to
> > > > >      clean up media_device_init().
> > > > > 
> > > > 
> > > > Very clear guide, will follow your advice.
> > > > 
> > > > > >        platform_set_drvdata(pdev, isp_dev);
> > > > > >        return 0;
> > > 
> > > For 2, we found when media_device_register() fails, calling
> > > media_device_unregister() won't clean up media_create_pad_link() because it
> > > simply returns without doing anything(see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/mc/mc-device.c?h=v6.17-rc7#n797).
> > > Therefore like other kernel drivers, we'd rather not call
> > > media_device_unregister() in this scenario, it doesn't cause issues, but
> > > it's not logically correct. Cleanup for media_create_pad_link() occurs
> > > during error handling via isp4sd_deinit()->isp4vid_dev_deinit()->vb2_video_unregister_device()->...->media_entity_remove_link().
> > > What do you think?
> > 
> > Oh, good catch! You are right about media_device_unregister() not cleaning up
> > media_create_pad_link().
> > 
> > But I don't see how vb2_video_unregister_device() ends up calling
> > media_entity_remove_links().
> > 
> > It looks like media_create_pad_link() is actually cleaned up via
> > v4l2_device_unregister_subdev()->media_device_unregister_entity()->__media_device_unregister_entity()->__media_entity_remove_links()
> > 
> > And I mentioned before to add a missing call to v4l2_device_unregister_subdev()
> > on error, so it looks like that will cover the media_create_pad_link() cleanup
> > and therefore you don't need to call media_device_unregister() in this scenario.
> > 
> > Does that look correct?
> > 
> 
> Yes, Sultan, we moved v4l2_device_unregister_subdev to isp4sd_deinit as you
> suggested, so current isp4sd_deinit() looks like this
> void isp4sd_deinit(struct isp4_subdev *isp_subdev)
> {
> 	struct isp4_interface *ispif = &isp_subdev->ispif;
> 
> 	isp4vid_dev_deinit(&isp_subdev->isp_vdev);
> 	v4l2_device_unregister_subdev(&isp_subdev->sdev);
> 	media_entity_cleanup(&isp_subdev->sdev.entity);
> 	isp4if_deinit(ispif);
> 	isp4sd_module_enable(isp_subdev, false);
> 
> 	ispif->status = ISP4IF_STATUS_PWR_OFF;
> }

Right, and v4l2_device_unregister_subdev() is *also* needed inside isp4sd_init()
to handle cleanup on error when isp4sd_init() doesn't complete successfully.
That's what I meant in our last few emails, since isp4sd_deinit() won't be
called in that scenario. Sorry that wasn't clear.

> 
> You are correct and I believe both isp4vid_dev_deinit and
> v4l2_device_unregister_subdev can cause media_create_pad_link() being
> cleaned up. Because isp4vid_dev_deinit is called first, so the link will be
> cleaned by it, here is the call stack FYI, does it make sense?
> [    5.198328] Call Trace:
> [    5.198329]  <TASK>
> [    5.198331]  dump_stack_lvl+0x76/0xa0
> [    5.198336]  dump_stack+0x10/0x20
> [    5.198338]  __media_entity_remove_link+0xdf/0x1f0 [mc]
> [    5.198342]  __media_entity_remove_links+0x31/0x70 [mc]
> [    5.198344]  __media_device_unregister_entity+0x93/0xf0 [mc]
> [    5.198346]  media_device_unregister_entity+0x2f/0x50 [mc]
> [    5.198348]  v4l2_device_release+0x112/0x190 [videodev]
> [    5.198355]  device_release+0x38/0xa0
> [    5.198358]  kobject_put+0x9e/0x200
> [    5.198359]  put_device+0x13/0x30
> [    5.198359]  vb2_video_unregister_device+0x8e/0xd0 [videobuf2_v4l2]
> [    5.198362]  isp4vid_dev_deinit+0xe/0x20 [amd_capture]
> [    5.198364]  isp4sd_deinit+0x25/0x80 [amd_capture]
> [    5.198366]  isp4_capture_probe+0x1ec/0x2f0 [amd_capture]
> [    5.198368]  platform_probe+0x3f/0xb0
> [    5.198370]  really_probe+0xf4/0x3b0

Thanks for clarifying! I was wondering where vdev.entity gets cleaned up, and it
looks like that is where it happens. And the subdev entity, sdev.entity, gets
cleaned up by v4l2_device_unregister_subdev().

To summarize: Assuming all of my other advice is implemented, the cleanup for
media_create_pad_link() will already be handled on error and device removal. So
the only action you should take is to disregard this advice from me:

 "2. When media_device_register() fails, clean up media_create_pad_link() by
     calling media_device_unregister()."

And that is all. :)

Sultan

