Return-Path: <linux-kernel+bounces-855426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731DBE12F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA43AC012
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F543AA4;
	Thu, 16 Oct 2025 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/DCLpCX"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D92BF510
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760579137; cv=none; b=AmiGgCX9Vz1p7GcOi9LkY/r2yxuL1xqPSmZG8ADu8kC0jqn2UHdtatWLJDcusR4gkbWGRcR49cw2oEySkSnEPJ20Pw4vVj0tvK4+OBp2OZCt9MSZ/yWXAvZgglIXlLWnIW4ZpKy9uNpVCBU1lfvY6+OTB9UdtejE5NISGJ4tAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760579137; c=relaxed/simple;
	bh=BmO9QvsJixoNrPHTLBb7ox8ODljvqV5zZ13V/ZDyQ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD4pQxvKx07RwQpZX4ifgbBTJKG7ZvmfNlIgvG2pBuxK0nE24NgEZMuZvr2cShaLDie9al+/yaF/w6vdHz2TGiHEw+TajlrTzcoJLsfnNfTBLnBLej5BEDijuLbfhx919myDmbxQkTu3BHa3Wx19ULO0XlGHtBVn1BtBjtX16Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/DCLpCX; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-92b92e4b078so9152039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760579134; x=1761183934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9rwUSd8nuRKW1ZndheoOnbtiXymXGXCv7wri7PtzlnM=;
        b=b/DCLpCXZe5+5Q8BKTkDyuv+dL3M095rdN3cw8MBCV2AmaDe/5/i941c7jApxzrcZ6
         as1t4S03m+nzYlK8RpKVUdgQq4yucmRBf6Odb5HG4eXkvCwrNuhAxzTIjR9jKK/nuW4B
         iRk92yiMPfNjxLWR+X9Z/86kvbHQ7wyq/XOZHP61W3aDBalAuNe8lLHeeOIVh5G+oOD8
         paJLTdOokatQ211VqnYF/rqopoARnZz/h/s+jXOobcRl7dOmKkdhneB6T8kHuWbO78TR
         bCg1WuiQvLtwaiSJ+KWJ1DFuQuk1289I7M0fmyaAa/0lMPL1DS/jYDJ99LCluudirncd
         j2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760579134; x=1761183934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rwUSd8nuRKW1ZndheoOnbtiXymXGXCv7wri7PtzlnM=;
        b=d1we/9003S8fIcnWOUK9/BKxysJwjz5Dow+PxH1tb66BYq8AAeY7PqNPuOT3darPe3
         zhrOIvHHd22ycGQjNyctsJ8wJCvcenWotcneGBjz4Rhc1RRgx0ROr76A0gcYwUj9qrVy
         qgZzb/+sy7zbOomz6xkUtNvu8Q5pg1kS0NMeaKcbKS86EslH+5Hy+95NolD4YsIFPhIA
         ySqYD4eTvzPfpW5UCnAW4eWxlHMmRjFoMMKC2cfU9IFwZFDOQzvV4PZr4SsSMr/Msgeh
         ap5Vy/0kEvDgLwt5h5cY4fQZNpF+aJ8GfavY1QEELQEF/78DVP6W3+UFFfLslgO/mKVo
         gHCg==
X-Forwarded-Encrypted: i=1; AJvYcCVKvtbzX5vr7ZR0Fg4uTMYPPWIg5iYSv/gzWQsjI4DhjF8rSoJ0EKbeC8p/80bFHig9Ildnt6jOcGDTRQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyalvmvS1qPUdZ7z7PuTpkY7Ux6K9ojA0t7pQYu+sCRQYPc5f9u
	ee4O6mtLKe+wEFUaCnoWoLY+INJRvPsW/W4eWvFb4DI4q99qbIr2d9TM
X-Gm-Gg: ASbGncvMm9x8ndMn/m70B5lHTGoEp1izN1NPsWMtOam7s7uWNKdNnJvnj0ksNJv+T2H
	xjGu7j1d70cGQ7tuk47d7gIXfrPCaHhDvtAXuo7nx08t7O40GggXMpD9XTN4qmog9oqNxOEhzkE
	vIByg7emcDW/2aDmtr8EF7CJbUIJyjTc2BD8sFHL2nKFJFuOdzh44ODPtyId5D2mbKpj680DeV4
	mkoC2J6WN2E2YTvYRXj4FBZASJLCWmXpAabgiWpJBLjQi8glWZq2W0Th+JPZSB7fyMLitL9RqtG
	5tQoyhLU1+3l1UtYR9cT3VZWiw4U4IiUA3r0XWTv84ccd0gcFmmopIhEaEyWWSB8eh/Mq12Zpnv
	6lA7VDlEopvFNioJT2/gGr6XNIduI25OsPZHX5YTNBkZRNMsrqzuxL8EiqpdLTytQRQhe/w==
X-Google-Smtp-Source: AGHT+IFp34gerWyI/eqrZfZ7861Ql4TRlIasFqKa/zgiw4czVi2L9IWSlxhtzXGcGKWZ9dJtvmyXZw==
X-Received: by 2002:a05:6602:1645:b0:93b:da4b:d0a3 with SMTP id ca18e2360f4ac-93bda4bd174mr4031136539f.19.1760579134525;
        Wed, 15 Oct 2025 18:45:34 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::ffb])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-59043f842bfsm5965410173.62.2025.10.15.18.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 18:45:33 -0700 (PDT)
Date: Wed, 15 Oct 2025 21:45:31 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Simona Vetter <simona@ffwll.ch>,
	syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbdev: Add bounds checking in bit_putcs to fix
 vmalloc-out-of-bounds
Message-ID: <aPBOOyrV3ihF_Bpq@arch-box>
References: <20251003073210.48501-1-albinbabuvarghese20@gmail.com>
 <b4af6e84-6555-4629-8291-fc4c2c99390b@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4af6e84-6555-4629-8291-fc4c2c99390b@gmx.de>

On Sat, Oct 04, 2025 at 02:43:33AM +0200, Helge Deller wrote:
> On 10/3/25 09:32, Albin Babu Varghese wrote:
> > Add bounds checking to prevent writes past framebuffer boundaries when
> > rendering text near screen edges. Return early if the Y position is off-screen
> > and clip image height to screen boundary. Break from the rendering loop if the
> > X position is off-screen. When clipping image width to fit the screen, update
> > the character count to match the clipped width to prevent buffer size
> > mismatches.
> > 
> > Without the character count update, bit_putcs_aligned and bit_putcs_unaligned
> > receive mismatched parameters where the buffer is allocated for the clipped
> > width but cnt reflects the original larger count, causing out-of-bounds writes.
> > 
> > Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
> > Suggested-by: Helge Deller <deller@gmx.de>
> > Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
> > Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> > ---
> > Changes in v2:
> > - Partially render when height exceeding screen boundaries instead of skipping
> > - Update character count when width is clipped to prevent buffer mismatch
> > 
> > Link to v1:
> > https://lore.kernel.org/all/20250927075010.119671-1-albinbabuvarghese20@gmail.com/
> > ---
> >   drivers/video/fbdev/core/bitblit.c | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> 
> applied.
> 
> Thanks!
> Helge
Thank you for merging the patch.

After the patch appeared in mainline, I observed that syzbot continues
to find the same bug through different execution paths. My fix addressed
bit_putcs, but the crashes now occur through bit_cursor and cw_putcs,
which bypass bit_putcs entirely and go directly to sys_imageblit():

Crash 1 (cursor path):
https://syzkaller.appspot.com/text?tag=CrashReport&x=11fe95e2580000
Call trace: hide_cursor → bit_cursor → soft_cursor → sys_imageblit

Crash 2 (rotation path):
https://syzkaller.appspot.com/text?tag=CrashReport&x=164f0b04580000
Call trace: fbcon_modechanged → cw_putcs → sys_imageblit

The original syzbot reproducer depended on character height going out of
bounds, so I focused on bit_putcs where character images are drawn. I
naively overlooked cursor drawing - apologies for that. That's why I
looked at the other crash reports after the merge, because it seemed odd
that it was still hitting the bug after the fix.

I believe adding the same clipping logic in sys_imageblit() would provide
comprehensive protection. Something like this:

void sys_imageblit(struct fb_info *p, const struct fb_image *image)
  {
 +       struct fb_image clipped;
 +       u32 width, height;
 +
         if (!(p->flags & FBINFO_VIRTFB))
                 fb_warn_once(p, "%s: framebuffer is not in virtual address space.\n", __func__);
 
 -       fb_imageblit(p, image);
 +       if (!image || image->dx >= p->var.xres || image->dy >= p->var.yres)
 +               return;
 +
 +       if (image->dx + image->width > p->var.xres || image->dy + image->height > p->var.yres) {
 +               clipped = *image;
 +
 +               height = clipped.height;
 +               if (clipped.dy + height > p->var.yres)
 +                       height = p->var.yres - clipped.dy;
 +
 +               clipped.height = height;
 +
 +               width = clipped.width;
 +               if (clipped.dx + width > p->var.xres)
 +                       width = p->var.xres - clipped.dx;
 +
 +               clipped.width = width;
 +
 +               if (clipped.width == 0 || clipped.height == 0)
 +                       return;
 +
 +               fb_imageblit(p, &clipped);
 +       } else {
 +               fb_imageblit(p, image);
 +       }
  }
 
I don't have any way to test this other than testing it with the existing
reproducers. I can prepare a patch if this approach sounds reasonable.

Thanks,
Albin

