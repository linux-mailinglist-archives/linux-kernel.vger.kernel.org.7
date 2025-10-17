Return-Path: <linux-kernel+bounces-857591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 693DEBE731C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76001AA1423
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775DE2C21E8;
	Fri, 17 Oct 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="KX+ZM8tE"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CCE269AE9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690063; cv=none; b=YWZ/ZI+4ileYwD+4tCFvUHY2RLrNHNNLSyqZ5SWgL5Nsd5C2UWjEZV3h8J6dQfJaxdINeKSeTR37CKMtaJ9STu600R9+PQJOSslCAxQ/LcrkOM7h69CCMlqf1dXuuVoPWXVYL+3mTOwPZss/hBVd8v6pAhNRYoxVa4H1L1hD8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690063; c=relaxed/simple;
	bh=rXUmxrGIqOAJYZ+/gxnEEhhhSgt5g34jwsL9bWpkQsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNCBrvXsTYDTbPzrjLn3yMh89ir8RZqGjPZCSQfr4wAGeLwsQF8UdxHfCV36lM6vIOA3HG4MA+imDpzQRf55OC0KZD9kFrHm70P/mb2QvKvE338FQMsRXr9nZEzMGd0TX4tI4O+Wrnmzzn6MJqCyaz5YBbyQX2+ZFFbQ0/NCdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=KX+ZM8tE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so1086948a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1760690061; x=1761294861; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zwWTDPTxdZ8sUmLlagbF37tgnT8oA3Q8eIsLoS6sVgo=;
        b=KX+ZM8tEogSRJD2TpIDLVIrSqbhYcA+vD3yWyhHXavrTPJ50uNXZIF209RF+5KBP+c
         vptBXmy9+ZaTFzLxMP9imLp0+Gk8dYEeYJgw2TSaiuT4rigb8T5zI8XX9Fdnqa7v50RB
         QMT8GLrwlshe3NFEmI07o8sM2RP7JJJuecD4dBNc1tmY0svq+O8R9UU98GVOme67MBr7
         GhPijiTiG7ncbKYQIIQpUJTaIaseHxnicwZj6UvXm3Ygc26j28tCOdHvTL+NuYpcmVjO
         JQ7j4Dr6cQUJisLzwIo0xnaknINYr8Q8aUOx0zSIYRn348vj3YqTWcFYeEQcuhgFNYvv
         whlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760690061; x=1761294861;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwWTDPTxdZ8sUmLlagbF37tgnT8oA3Q8eIsLoS6sVgo=;
        b=S1Ukbyw2S6Qr6uNLHYalM80cTkAFK5r2IR42ehhWUszHNM+j3WoLuAa3IUzfJcBy2s
         c/ANUGfhCEvR/A8BZgutTF83TjKaCa+SBlPAaAOsFyG05AIc55srO4tcdqZEeZC6/3CJ
         o0tojOEIZS+2fPD/9dhL4VV5AELbj4xagWYsp9HqCy7adq0Jgv2obUWsqb/B6B1O9S6/
         cgia8PKxVBR37b5rNEU0jvAqP12YSsBmX00Ht0n/oj15m8j3AM7uilJ0IVvEbHRQsHbQ
         sLeXAhqiS0RLlLSPilC4w8QRvd0VbIqWKP4oLTZd2rdNLhAk31/X2hlhAJoSQ3j5fA1p
         xr2g==
X-Forwarded-Encrypted: i=1; AJvYcCWMZZhV8cyKhxogjiGArK5aENCAIY4XvYmcGc4dBKdbGu5QgZ8zOpmgRntZSpC5gJLOdrldsCxz6dsGx6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIHEtzT2LQkSdYhpJnnFx2IQPzPCsKpVsqNL0tEj9moP92Ybb
	ExX716wexutQtxo6Kujpo74NooIbEmHqRt5vncnXDJhKvrrLZDz5wDHDayGAAKRnGaw4
X-Gm-Gg: ASbGncuG8fpWK0SvuCkpfp/N9usFJWXz2PI+DR257lsEtieSKvKxxUczb93Tt6eQZ0N
	uWS8c8sO79JHx5Dgo+i7cvN81jyx6fDtvsXFhxTkAXhFr7UoRNZB38kt7GoYPT4WJYTpKGgLu7h
	F9NoTNb0iq99vTCCGZ4JHwmWhsNB+VmMUH+QVI9YQbh/7sVHyMDdcZ1AH6BVWTfopXqW7OHWkPX
	waIox4XqSEdyHR5zo6MfDE/M5VnfPYBOlxc/F1DJ/UCmdbNC6lsBy1Yevd8OF0QNHrKXEFl82E+
	Jh3d2MBQ3rwoiBDswYXzcYnmO4wg2OqKRro9SWmEv70bvAxZaWmhvu8AQnrLBWthmYcq8n5Tvzx
	TM/y2YsiOVjsFpzCHkmmYxYR6ZqGEufUUxnGKaoN4kAA4uKtxTrKMXW7nv2wS/GSgkjf8Q+VzF7
	XhWZXHv6ei1DQ+8w==
X-Google-Smtp-Source: AGHT+IEnb6UjQcer/I5Rw31GyT+MdTerRyv2aeOuud+h9gNncxVu01d76QtKrkpwP6x0XkSdMK0XZw==
X-Received: by 2002:a17:902:fc8e:b0:27d:c542:fe25 with SMTP id d9443c01a7336-290cb27c8e8mr37576595ad.41.1760690060687;
        Fri, 17 Oct 2025 01:34:20 -0700 (PDT)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290a382a927sm51595225ad.106.2025.10.17.01.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:34:20 -0700 (PDT)
Date: Fri, 17 Oct 2025 01:34:16 -0700
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
Message-ID: <aPH_iHmPFWTrrOQE@sultan-box>
References: <20250911100847.277408-1-Bin.Du@amd.com>
 <20250911100847.277408-6-Bin.Du@amd.com>
 <aNzP2LH0OwUkMtGb@sultan-box>
 <c28eb905-b578-4512-aa9c-37281d3a0ee4@amd.com>
 <51c24e3d-be89-44c9-8247-95fb776aed78@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51c24e3d-be89-44c9-8247-95fb776aed78@amd.com>

On Thu, Oct 16, 2025 at 04:13:47PM +0800, Du, Bin wrote:
> On 10/11/2025 5:30 PM, Du, Bin wrote:
> > On 10/1/2025 2:53 PM, Sultan Alsawaf wrote:
> > > On Thu, Sep 11, 2025 at 06:08:45PM +0800, Bin Du wrote:
> > > > +++ b/drivers/media/platform/amd/isp4/isp4.c
> > > > @@ -178,6 +178,16 @@ static int isp4_capture_probe(struct
> > > > platform_device *pdev)
> > > >           goto err_isp4_deinit;
> > > >       }
> > > > +    ret = media_create_pad_link(&isp_dev->isp_sdev.sdev.entity,
> > > > +                    0, &isp_dev->isp_sdev.isp_vdev.vdev.entity,
> > > > +                    0,
> > > > +                    MEDIA_LNK_FL_ENABLED |
> > > > +                    MEDIA_LNK_FL_IMMUTABLE);
> > > > +    if (ret) {
> > > > +        dev_err(dev, "fail to create pad link %d\n", ret);
> > > > +        goto err_isp4_deinit;
> > > > +    }
> > > > +
> > > 
> > > Two problems with this hunk:
> > > 
> > > 1. According to the comment in include/media/media-device.h [1],
> > >     media_create_pad_link() should be called before
> > > media_device_register():
> > > 
> > >      * So drivers need to first initialize the media device,
> > > register any entity
> > >      * within the media device, create pad to pad links and then
> > > finally register
> > >      * the media device by calling media_device_register() as a
> > > final step.
> > > 
> > > 2. Missing call to media_device_unregister() on error when
> > >     media_create_pad_link() fails.
> > > 
> > > Since the media_create_pad_link() will be moved before
> > > media_device_register(),
> > > we will need to clean up media_create_pad_link() when
> > > media_device_register()
> > > fails.
> > > 
> > > The clean-up function for media_create_pad_link() is
> > > media_device_unregister().
> > > According to the comment for media_device_unregister() [2], it is
> > > safe to call
> > > media_device_unregister() on an unregistered media device that is
> > > initialized
> > > (through media_device_init()).
> > > 
> > > In addition, this made me realize that there's no call to
> > > media_device_cleanup()
> > > in the entire driver too. This is the cleanup function for
> > > media_device_init(),
> > > so it should be called on error and on module unload.
> > > 
> > > To summarize, make the following changes:
> > > 
> > > 1. Move the media_create_pad_link() up, right before
> > > media_device_register().
> > > 
> > > 2. When media_device_register() fails, clean up
> > > media_create_pad_link() by
> > >     calling media_device_unregister().
> > > 
> > > 3. Add a missing call to media_device_cleanup() on error and module
> > > unload to
> > >     clean up media_device_init().
> > > 
> > 
> > Very clear guide, will follow your advice.
> > 
> > > >       platform_set_drvdata(pdev, isp_dev);
> > > >       return 0;
> 
> For 2, we found when media_device_register() fails, calling
> media_device_unregister() won't clean up media_create_pad_link() because it
> simply returns without doing anything(see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/mc/mc-device.c?h=v6.17-rc7#n797).
> Therefore like other kernel drivers, we'd rather not call
> media_device_unregister() in this scenario, it doesn't cause issues, but
> it's not logically correct. Cleanup for media_create_pad_link() occurs
> during error handling via isp4sd_deinit()->isp4vid_dev_deinit()->vb2_video_unregister_device()->...->media_entity_remove_link().
> What do you think?

Oh, good catch! You are right about media_device_unregister() not cleaning up
media_create_pad_link().

But I don't see how vb2_video_unregister_device() ends up calling
media_entity_remove_links().

It looks like media_create_pad_link() is actually cleaned up via
v4l2_device_unregister_subdev()->media_device_unregister_entity()->__media_device_unregister_entity()->__media_entity_remove_links()

And I mentioned before to add a missing call to v4l2_device_unregister_subdev()
on error, so it looks like that will cover the media_create_pad_link() cleanup
and therefore you don't need to call media_device_unregister() in this scenario.

Does that look correct?

Sultan

