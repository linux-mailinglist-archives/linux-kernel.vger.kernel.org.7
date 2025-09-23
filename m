Return-Path: <linux-kernel+bounces-829293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB4BB96B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B04C2E5CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37961261B99;
	Tue, 23 Sep 2025 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Dr6a2p"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C5257842
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643397; cv=none; b=mIuCNkQ2w+EPub44y11qlxCiWLbDyFTnkMHtaLxz5N3Dy1tRsr3iH1axibLCyhZ9BYW8YjKG1C43Dlq3Pe3AUNCJZbIDHOeNAK+w2f4OlWxOPVKHulC0CozH3a83JFrL4qVk2f9iBBLnwh6Emw+fSGyDJXpXIqW70oZ+ySqQHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643397; c=relaxed/simple;
	bh=+eCklkEo4Dd5/86Fex5KOYIdlbYxcz9vSH+N6Bhs0v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro6WNSWBIpaYg6nA9l1IcfRXyWKs+7wMQiqZ7OM78DzxVADphU9msO368IJENHrJ6uJW+sy4sUxr6pwKWkMeXeWDxSzxKYEd577HyeR1t+i8adlYEuTieXuXKzTluGgYxUKoIOExWkr9O/C280UMFCil6RaF7hm/hEWHP9t5LYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0Dr6a2p; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26816246a0aso12714495ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758643394; x=1759248194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2ROfUbxr/KN7oAi0rJA/6LeNf8GF4G0Z/s0Uz4C+7I=;
        b=A0Dr6a2pjBftbkzQl7rGy3HsyD/T6Yv684SAy8YMhxC+ulMAJHeoodfcw2YzdzA8Xy
         xwl7X8GVSVpkcmq4y6mU5ypg/IMNvjQdEWWNpA8UcSidn4Flg9+EFbBEzQTH8qAhFDDZ
         W9STtdzRW5cEabf6Me9orDlu4B0BcNQLOOnetZteYCVx6PdbCIHaSuDzmsQQYx2a9U4v
         Huk9t7wrUfZrkEohDiAVkkdlKx1YitvydMLg4Mmwd4wIWSsuFVuXgWdR4g/AlyXXXiAd
         uakXeYW7kHqsTkgFGIgS0F/hnhaE+GdXseDM/nuBO4lrKsx7/PyZEBGlUnH7ZD/47QQT
         3LfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643394; x=1759248194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2ROfUbxr/KN7oAi0rJA/6LeNf8GF4G0Z/s0Uz4C+7I=;
        b=Swh1+shHUoRuKb6CZC30YR6PmJNb3fywt+lvMXYqpcbqrj7zdlQ7nniNmnwg5BcIxB
         B5yL1/2jmndXDrDt4bPhJcitXo84pgToEjaA6pGA1x5dtadJ/YFbNgevWOQXgDIjx4LS
         x3uEXyyb9JfKahTRwwQEYHBhCjWuT0qbjI79yh7L7nzkPGJSdFhc3D9AGCfuwlVIHup+
         S411DDniO7ZIx5++WdmShQgWuwabWceEYz/7NjxzcTk9q12rMN036/zBw/il5NMTS8PF
         6dg5miMo6NXHyV98bLi2sYWwqpHRH9DshRBMpAnGs1Th78pTyelviDNKrvJrsfRW/Cge
         gtzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx0DSSPC7wOeH3MpyARCLh32zWgFmi2weryvgxcgqH8bFmxlu+qUvHRLJ1pDT4X6MNbo1auUAnMazgfD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysyRhgtOYVEYx+URE1XWZsocvuKXDmdcq9QF4kOnktvbKC0BJV
	9j/SYiQnfmp3E3y3VId4EyTHb1LGlqrmO6b4L8LsPTonIKQFL9em5JahCzlRkXhxkMQ+PR+TpV6
	nQJHFU60rlBK0iSnj0v8MFXGKvJSnCts=
X-Gm-Gg: ASbGncuCxuypVNmxO0cDws8s3+CR7nVA39aKorOditt9tlmWOHYofgyCRqWbwkuHPuL
	9mnW6xvnpQUfk/KvbV4+4DeShKCMlUPDNrzeYYqLc3vSnch94ra8knbOT+fQOkKXXG9uDSHt1rq
	FDF2RYsBJ13HlzQ8oCdWVyRVwcYwXmp9nWYI0ogOQki2yXJh09vgI6JwCu2UULJgsOjhW2kawmQ
	wOR6W8=
X-Google-Smtp-Source: AGHT+IGBbiHkgD0/2labtH1NeFTzXLVqipenHtdKCLOlRtkUCqCDTMEK1XiJMTv9TX8U0v9Y4TZdy6Zkg1xfbYYFpBI=
X-Received: by 2002:a17:902:b695:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-27cc712154dmr18207895ad.6.1758643394109; Tue, 23 Sep 2025
 09:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923084157.11582-1-hsukrut3@gmail.com> <9fe75192-9260-44f7-8f13-e024e2bbd731@suse.de>
In-Reply-To: <9fe75192-9260-44f7-8f13-e024e2bbd731@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Sep 2025 12:03:02 -0400
X-Gm-Features: AS18NWDnCIuE4uDg0qpAn-RzVENplvgl1AQzC-tA5opkGWF7-LN_yd6zTJ3mypY
Message-ID: <CADnq5_NHu5=esJZrgy_S80jF68ZapRRYX4_L70DwDDSN3VXitQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev/radeon: Update stale product link in Kconfig/FB_RADEON
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sukrut Heroorkar <hsukrut3@gmail.com>, Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, 
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:29=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Hi
>
> Am 23.09.25 um 10:41 schrieb Sukrut Heroorkar:
> > The previous Radeon product page link was no longer valid. Repalce
> > it with the current working link.
> >
> > Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> > ---
> >   drivers/video/fbdev/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index c21484d15f0c..3037455adf48 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -949,7 +949,7 @@ config FB_RADEON
> >         don't need to choose this to run the Radeon in plain VGA mode.
> >
> >         There is a product page at
> > -       https://products.amd.com/en-us/GraphicCardResult.aspx
> > +       https://www.amd.com/en/products/specifications/graphics.html
>
> May I suggest to remove this URL entirely?

Yes, agreed.  I doubt any of the chips listed there actually work with rade=
onfb.

Alex

>
> Best regards
> Thomas
>
> >
> >   config FB_RADEON_I2C
> >       bool "DDC/I2C for ATI Radeon support"
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>
>

