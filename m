Return-Path: <linux-kernel+bounces-851964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA6EBD7D00
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FCC3B675E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AE730AACF;
	Tue, 14 Oct 2025 07:10:19 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A75B2877CB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760425818; cv=none; b=uJ6V6ChcWa16C2RgfTyhwPkfjNINIM9GBV+VnTlvPVUCqrA1+dlSzJWDsN47V0qjSD0DkLvVmEOh6e8syWe7nZtUerxnkqQgN19eifuoqPf8eE8XCQeSxMvZ5Lb1L2f7UW6KeHTLmTByjHtF5VRytipxPR5PakFo/+jJNdx3+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760425818; c=relaxed/simple;
	bh=cq9uw8grWJhJrjC0Uudr9DxsgXmV436TasExQ1HyP6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bj2gf2/YvoB7W8Frh53zDQAZkjhUy4FtqJDdKa0axElQYyIlzM+m1ePwrNxDQsz1F9YII4NZl4iYbPOJjuzelDP3n9eE7EeN8FJcl90nMPOHpjuZml9iM2emh1MsdXHe5Pog3c2x++tlqR1uvPbCekrX6cXK+JWv0YIfaX09mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54bc6f33513so3331122e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760425815; x=1761030615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t19a6MXKzHciHV0Q6aOx1ZCqH/XgqkiiYrhyJp0q9cg=;
        b=gE4QOj3IK1NYNmLH9jAeh41/CPp/wRkA3hmAdhW5STvPNHqgSdUhfHd3waWGY4BD7e
         RuCAAisvSoAAX4A0lyzeIJOt/3vAZUCu/mOQkit4DESGHvCx9V9zCUVuyV1RNR7kK5cv
         CuwFN7yVx1foDIAfDfzo8LOUb/bodU+AgeZhvhB1Mwuf1xcKL16+akXhuFzTiGZo6YdY
         24f/KznE8nQFsBjsfvs2sL52/gOAn73KGHtq3sEB5uHJQdMBoD9BYC+nLavRJnYEYoL8
         l96wYPkub9f8ZBgYn77idXXdAZNhaQfk+yuchvrEvTUet1w6T315C3PXeJLS2ty3wl/N
         3muQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPPn1+WppP9X4SujBx3AzIB8W6NgD4QAOgNw5XUjFjhQmoUzF8vRVXIhwJLlvV+pUdm1fAxtFAyFo6U4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yTFwy9iq4A/oS8zE0i+fEHJlXzQiaLZDFyHfJKdg0243Qlwj
	M+R/qPbz3qiNZT/7hmlqaBWp2IdyYZv77wygq2caCqHkY994jptFVR1F4OO2vEEf
X-Gm-Gg: ASbGncsv4qANw7IRCZ0hw2aUyL8zWU/lenx9+MgpeqJJ4J7h02n0Q0L2zJE2tm5Bfqv
	zRndzvzIYTDxhOt5xETMFqpCzfbeUu1GJuDcS3CU7gGz57w/+b0GOf2mCofNCWXNF18SgdA+I1a
	56Mlajy+3GE86jMNE7GxIbwrE+0NU67o+ADU6ftiA2z9GNNrCon1g6ICY61gO3LAYKpvTEsyzZK
	cZGlA8Fj9eRjIEPBJGphXQI9+HXhBqo+ItXMvajOmnA2NzPSH82HQDRHWZDbviZ3Qy64JytAoWX
	s9OaLpP4hasNsDuCj4pJ7yoYj28gbQJvrRvFeqR/gm5qUqf65Zf6mQATYX791Z8369rWtxf4FOM
	8lKuSwnEB3d4anGLjfj9EdWirJ86Y36Z4IjZlNbnooKnWVtDmNgBi9YQPlRGQt1rvBgjqWxbk6i
	77TT5tQLKGUiYrow==
X-Google-Smtp-Source: AGHT+IGWCKlX7zFNKVXSvoyIlyFopMDgWT8W88c8/V8OK71zn3Xr3p0XkeOTadsSrkjjG4PSVT10ng==
X-Received: by 2002:a05:6122:169a:b0:544:79bd:f937 with SMTP id 71dfb90a1353d-554b8c23f89mr9343291e0c.15.1760425814812;
        Tue, 14 Oct 2025 00:10:14 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80aab53sm3832080e0c.15.2025.10.14.00.10.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 00:10:14 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5a0d17db499so4518409137.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:10:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTgShxbRMj5L6iEiMo6xn1V/wcbtCtuMDrJx6u38UTGS5Ys6SKA9fW4KAapTUrDWhFkDnX3ZQkx0ng97M=@vger.kernel.org
X-Received: by 2002:a05:6102:3f04:b0:5d5:f6ae:38e8 with SMTP id
 ada2fe7eead31-5d61e0b5ffbmr2234131137.41.1760425814222; Tue, 14 Oct 2025
 00:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69104b397a62ea3149c932bd3a9ed6fc7e4e91a0.1760345180.git.geert@linux-m68k.org>
 <20251013163211.GL6188@frogsfrogsfrogs>
In-Reply-To: <20251013163211.GL6188@frogsfrogsfrogs>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 09:10:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURm_mpK3Pnr=XtUqe2RsqJY_hVR-R797hRSSc0U_0DKg@mail.gmail.com>
X-Gm-Features: AS18NWAt5y941DryWLpHjW4UEKltrVPplKlP6XoI8IybklIeQYe_Y8B6bt0jZBI
Message-ID: <CAMuHMdURm_mpK3Pnr=XtUqe2RsqJY_hVR-R797hRSSc0U_0DKg@mail.gmail.com>
Subject: Re: [PATCH] xfs: XFS_ONLINE_SCRUB_STATS should depend on DEBUG_FS
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Darrick,

On Mon, 13 Oct 2025 at 18:32, Darrick J. Wong <djwong@kernel.org> wrote:
> On Mon, Oct 13, 2025 at 10:48:46AM +0200, Geert Uytterhoeven wrote:
> > Currently, XFS_ONLINE_SCRUB_STATS selects DEBUG_FS.  However, DEBUG_FS
> > is meant for debugging, and people may want to disable it on production
> > systems.  Since commit 0ff51a1fd786f47b ("xfs: enable online fsck by
> > default in Kconfig")), XFS_ONLINE_SCRUB_STATS is enabled by default,
> > forcing DEBUG_FS enabled too.
> >
> > Fix this by replacing the selection of DEBUG_FS by a dependency on
> > DEBUG_FS, which is what most other options controlling the gathering and
> > exposing of statistics do.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  fs/xfs/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
> > index 8930d5254e1da61d..402cf7aad5ca93ab 100644
> > --- a/fs/xfs/Kconfig
> > +++ b/fs/xfs/Kconfig
> > @@ -156,7 +156,7 @@ config XFS_ONLINE_SCRUB_STATS
> >       bool "XFS online metadata check usage data collection"
> >       default y
> >       depends on XFS_ONLINE_SCRUB
> > -     select DEBUG_FS
> > +     depends on DEBUG_FS
>
> Looks ok to me, though I wonder why there are so many "select DEBUG_FS"
> in the kernel?

I think select is OK for pure debug functionality, which is not enabled
unless really wanted; depends on is better for optional features like
statistics, especially if they default to y.

Alternatively, the "default y" could be dropped from
XFS_ONLINE_SCRUB_STATS?

> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

