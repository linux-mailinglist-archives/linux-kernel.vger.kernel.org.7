Return-Path: <linux-kernel+bounces-899847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7BBC58E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACEF4A0A81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAFF342514;
	Thu, 13 Nov 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+3gerQl"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9E2FD668
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051953; cv=none; b=YpiBIjb0vZIc+ggv/LSkMy0k/HOdjd6LHHp38OgzqZOftSXHy3Yq9+5CbEWdRTL8xsiD/llFfnXldU9XGpiYoGTfOSf/j1E5Uddtc/gHh+7+QrYES6/Hraj/UrIUkxlKWkN0TWynzHmyNC6UE3gxwDqsdpvI6yQ5EdkhHHKfiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051953; c=relaxed/simple;
	bh=jMiV4RbMNeOesGqKgORN1iKerZRElW5XEIqKQrbUT2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpQgCQpXQtFZheJgA+Hxkb2YTEzgaKiWET9z7ez2f1P8kcbdLqS2dNkH1l1jjxWSOjq6RVfpb3oFB8xDRV/Rk6Ot8LK6hLburVc5VetyJYZCVg/5jewEZx/byVcAi0CuSl8qZunOSDtPmzizkAjYGBLQQ6IbtBUGyESkfV1u7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+3gerQl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2958db8ae4fso10344255ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051951; x=1763656751; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S/ucMNEdTPs4tdBdIab98EcaF+7fPlknQB7RoGYRpzI=;
        b=G+3gerQlIFcYM4wJuPzSobt5Qkzq6fvAmv5Sr1xJ5rs759VDfzk07c1fm93sC8Wxl7
         jfcpnmRNhjPQgs0bRPRckHBc7ZD8pikP9FUWkJbmRBNSOXPaVSN4+pVouphjOov7QzsU
         Fw0h79PmIy1OeD8NmGyKYQuFlNgl8u485Xxt6Rwi5jBvddnr/Sd3XfdeVEQepPuYctDR
         O2ui0b7yAMuKnWq2kl8s3PyoXeZ5TbdWQPgZXoIODDfmN/+FGvkflhzQEPT/Q05jGTuw
         dpaZavWkLPgbWI4R1JfdpkdxjO/nHlUjx08PoBUpWZskMfNB6/Dr6hRiwQfxNLgwK/cM
         NARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051951; x=1763656751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/ucMNEdTPs4tdBdIab98EcaF+7fPlknQB7RoGYRpzI=;
        b=UMZLn75y6V7O7a6pkk1Dg08NOKG+EJRfT1s7r4+d6Kb054qtNYPeKfXXdXNyFnfLDa
         /kmdy/odpoxEaxQzHFzaswlbUtb1z2NdSNDIgtBSQjb34d1zw2yXC5/Bu0K6J33KQ+1G
         VKeAyfsUCOELkjvMRpEFADG0AzfEXtKyuGUxeK/b1MVu8PT5kRTXRASm2A1ou6Qo7v4q
         kyLjMQPlL8gAmIfjrTS3XZxkqLqAbBo9UWwPkJ/3Vo+DMI7UY4Vd+lRjnEKd3dRLUfam
         d/WMyuEyHFn/XSaqpXqEjxe7+yYXH4kgAfuCDOd8aIEPMOnHazDs82msIZil1MMeZ8UT
         ShJg==
X-Forwarded-Encrypted: i=1; AJvYcCVvTDtbJOfmnzJ1A5cRMDpuoYEslhsYz7xJ4yFov2SglVTGe4+gEHZ+eYVUX/vRUbordqGFaWwBmFDfzxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZR6S19BFs/xhqYVWVv5KZGmV/wDanP/Xe1CgIApvY/atfCoL
	Bp3Q7SOdG62ibgzsJewhM3gtq7t54BBpXiLW7rMDOz2zK2ETK6bltN3w
X-Gm-Gg: ASbGncvLzZt/pSUSyyOKVIg9MbqBzk4IltDCYTDz6S7E04AuAuHDrGWlQABJxZK4wIV
	wNjszYEjHwaaOQs/rE99ueY8q+s4CM9Ivzfe6C6ekBIZMxpH3ztNS5MwCELaCt3LAYJwthisE7q
	uJCn73OiCx4cEmzhk+eTq/8+AwWQlAubfUV5MVJInHY8E2HZgST8pQYlpnIK9Gxno8EiJ2OGWas
	gnS8p5IdqFnFuAhxtnNGQkgmaeHwC1hatZxs15gx+HjH106tCs3vc7YSI42p+OHj+zP5Vzbu9dj
	Y3HR2RoE+KGiFPIZPkCUuhDYMB8b2dB2+7BtboMU2STUeHaYhcJBG8rOEMkJKtI0s9d63LfY5Iy
	qDbL/ENYHqrW1N+5J4jKCl3JtYcEVajFPigvEp25FPPORFk9nptPKnMOSTGXpLVgeAtUUd9e3ZR
	+Cdk4=
X-Google-Smtp-Source: AGHT+IEs0sHw9yn/h78U4VzfNtAGyDH+Vb8Xjj0sh1kFUc43l7I1lswC+8d2RPaL8vbpculyPwUdyg==
X-Received: by 2002:a17:903:1a28:b0:298:485d:557d with SMTP id d9443c01a7336-2984edcaaaamr90085595ad.45.1763051950935;
        Thu, 13 Nov 2025 08:39:10 -0800 (PST)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2cce59sm30165515ad.105.2025.11.13.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:39:10 -0800 (PST)
Date: Thu, 13 Nov 2025 22:09:08 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: gregkh@linuxfoundation.org, snovitoll@gmail.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: raw-gadget: cap raw_io transfer length to
 KMALLOC_MAX_SIZE
Message-ID: <u3okc42qhpzi2uorrdei3jigq5wwgdqb66u3u5khtuzxhwbamx@f3dh3fivx3uo>
References: <20251028165659.50962-1-krishnagopi487@gmail.com>
 <CA+fCnZeZ+c15X8BXg59ppbEmEUvp64aMaTPjXARyO_0x6KL+eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZeZ+c15X8BXg59ppbEmEUvp64aMaTPjXARyO_0x6KL+eQ@mail.gmail.com>

On Tue, Oct 28, 2025 at 09:15:47PM +0100, Andrey Konovalov wrote:

> On Tue, Oct 28, 2025 at 5:57 PM Gopi Krishna Menon
> <krishnagopi487@gmail.com> wrote:
> >
> > The previous commit removed the PAGE_SIZE limit on transfer length of
> > raw_io buffer in order to avoid any problems with emulating USB devices
> > whose full configuration descriptor exceeds PAGE_SIZE in length. However
> > this also removes the upperbound on user supplied length, allowing very
> > large values to be passed to the allocator.
> >
> > syzbot on fuzzing the transfer length with very large value (1.81GB)
> > results in kmalloc() to fall back to the page allocator, which triggers
> > a kernel warning as the page allocator cannot handle allocations more
> > than MAX_PAGE_ORDER/KMALLOC_MAX_SIZE.
> 
> Ah, right.
> 
> >
> > Since there is no limit imposed on the size of buffer for both control
> > and non control transfers, cap the raw_io transfer length to
> > KMALLOC_MAX_SIZE and return -EINVAL for larger transfer length to
> > prevent any warnings from the page allocator.
> >
> > Fixes: 37b9dd0d114a ("usb: raw-gadget: do not limit transfer length")
> > Tested-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
> > Reported-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68fc07a0.a70a0220.3bf6c6.01ab.GAE@google.com/
> > Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> > ---
> >  drivers/usb/gadget/legacy/raw_gadget.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > index b71680c58de6..46f343ba48b3 100644
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -40,6 +40,7 @@ MODULE_LICENSE("GPL");
> >
> >  static DEFINE_IDA(driver_id_numbers);
> >  #define DRIVER_DRIVER_NAME_LENGTH_MAX  32
> > +#define USB_RAW_IO_LENGTH_MAX KMALLOC_MAX_SIZE
> >
> >  #define RAW_EVENT_QUEUE_SIZE   16
> >
> > @@ -667,6 +668,8 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
> >                 return ERR_PTR(-EINVAL);
> >         if (!usb_raw_io_flags_valid(io->flags))
> >                 return ERR_PTR(-EINVAL);
> > +       if (io->length > USB_RAW_IO_LENGTH_MAX)
> > +               return ERR_PTR(-EINVAL);
> >         if (get_from_user)
> >                 data = memdup_user(ptr + sizeof(*io), io->length);
> >         else {
> > --
> > 2.43.0
> >
> 
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> 
> Thank you!

Hi,

Just following up on this patch to check its status.
Thanks again to Andrey Konovalov for the earlier review. Please let me
know if any further changes are required from my side.

Thanks,
Gopi Krishna Menon

