Return-Path: <linux-kernel+bounces-842937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8E4BBE027
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C36734EB651
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7AF27E04F;
	Mon,  6 Oct 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEVnoyUL"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709A6ADD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753242; cv=none; b=hRgpWtWdMP0hduu6HP3LxW8cWM0CDpQBDHE1hplXjb64mwx3EhwJ/V4DXjwQPfTrgUbafNOyA+l3zkSrc6SZbPZlVXpue4imnGa24s2y+euojjIBN4Xc9bR07eV1sJ6BzJVBW4//qK8AR8sIdzEox1zRhME68p8CZn2qItvBmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753242; c=relaxed/simple;
	bh=UJp7RolsMUHZN7Q7qTulrrtFzCt5CPP5p/bQu247Voc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWK0fOp/bfwr+MwOoSB7GQPUmELan0oYzXPedsYJMku/EFCrMMShBY9pNezl4vNSnBpKFRk4gpDKGBZ2VM1CqP66OHCI0HLxhcc1S+sxpEYeT7CrHUp/6yabL11pzd09Wm2/HhILyG8qi8tWkjUIEGih7OsGcUYOWMEUMhWcOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEVnoyUL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so7299154a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759753239; x=1760358039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrL0phxbtwcYAWxQ3FOdLeN1W9DvB0MwUwXu+o2snlE=;
        b=hEVnoyULNLmmVXusF98M4I7X2I5m/5GIVkpMiRL7P9fUBCFBAxuLEQcSj78QVpuWCB
         twogFgZopoBJguQ4c+t2mR0A0Aghj77ZVWu+49diY3VV5p8JWdDcRlupTStq+Ofo8a2x
         9sde0gAHsXB4p7DF+LR/MXs11gEMLYMCYlrq1Z4Pa+mtm30BkG8iH8rf1aIUQUWq4W8w
         8n3soZOkvMZto4PnHm0qrEUVucE4CM29ACCDQk4tZgAYJEvNyCUQzgAC2eWT74AQEwMj
         Wtfp5ExA1fJzHuJPMIPfCHZR06jY+jDqjQycXSk7avlD84U+p+t/hxFX5K+pBrnSKRQr
         OL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759753239; x=1760358039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrL0phxbtwcYAWxQ3FOdLeN1W9DvB0MwUwXu+o2snlE=;
        b=W4Os57a8Sv9Nt+SJ8VcmBlnVE7XXFbTFSXwC7gXA8jIB0GT4svwxG9AxayvKzs9FBc
         +TWXHNS1S+//Eo0ySonM8RP1H4wKwSYZjs3bqkazR0hjmf2h5WLoFOiEKCwQU6LIR0OH
         vspXWpTYVvU5ykmFd0voKMpunSSfEYehYxZy6j+2YgL+JQwWNdtXHwa2Hw+s+JosuyKX
         DqhPZ6OG/xZhd2KO1RxIUgWHyEQpH2kbt85OrMMNSEzqpXn6WXVIhWOaqGN4q8URpACh
         JPZ2ET2pChzBsNQKXilc0bJ+gQomJ1WSiGpaSO4snKOtnKXJR0COR9I/sZLbiXBRJ1lm
         jvbw==
X-Forwarded-Encrypted: i=1; AJvYcCVUZlpE483gkHlM/9DAA0CSYdBCZeMElWB8sijwbHnJsSNuuVA8tSj4Hkq9agzdlOiQgqrVWPp854FCAxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfK6qlBZTorydZ64nqVQ6udksBjhJg6Lffvs3Qtuqn+cOUDT3
	z7sU+qeTVZMwkjAdGNjqvH3QdlqMj/qnwOX5K8Pwe4kI16iPgmJk21wDIOfZbgmDXSeDvR6Bgor
	FnuridLocf3kYnMyLwfUI43k0ur3MDJs=
X-Gm-Gg: ASbGnctER69uPVz6b5cmztYEyYC0SVNqKTafZiQnOHYAxIoUulmvqQs1eBdpqor4bEZ
	Zo4NSBdIpuJKdXev9D8raW/eOGZZDk6ddsYVdfBv2SFO5zFc9+5vx/6t07vq5MshwchU3vfqkcS
	gemqianyogm4/Jz7onMdBRmXtTqsjL6VszyCs3tlIfKFkZhLXi1igjg2ow/ozgJctU4ZW1ubGdg
	2pj8KyBFEJ8xK8iCPkJSLBWlX2/grhpwg0jpf0td94kFyTlxa2epXiVxfz0ukQ0M5dRl7dCRA==
X-Google-Smtp-Source: AGHT+IETWefcq8gw2n4ALL0l81SdRUuET/WJavOZT/5HdxcH+PJFJtXUks1IJxr2y8maVZe6XORVjN+hQxlMjpgZGOs=
X-Received: by 2002:a17:907:7f0d:b0:b3e:9818:30e0 with SMTP id
 a640c23a62f3a-b49c2a59c15mr1591033066b.29.1759753238606; Mon, 06 Oct 2025
 05:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005231526.708061-1-mjguzik@gmail.com> <3ectwcds3gwiicciapcktvrmxhau3t7ans5ipzm5xkhpptc2fc@td2jicn5kd5s>
In-Reply-To: <3ectwcds3gwiicciapcktvrmxhau3t7ans5ipzm5xkhpptc2fc@td2jicn5kd5s>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 6 Oct 2025 14:20:25 +0200
X-Gm-Features: AS18NWCUHzufbDlED1IRCwWRQuPWlZsQxQKvzKtob8VW4zZ3AcPnNwifuCHrG5w
Message-ID: <CAGudoHFU7F07kavPxpEo7dxF1aWofu2i1xK_FENFhCRawK0s4g@mail.gmail.com>
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 2:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 06-10-25 01:15:26, Mateusz Guzik wrote:
> > diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> > index 22dd4adc5667..e1e1231a6830 100644
> > --- a/include/linux/writeback.h
> > +++ b/include/linux/writeback.h
> > @@ -194,6 +194,10 @@ static inline void wait_on_inode(struct inode *ino=
de)
> >  {
> >       wait_var_event(inode_state_wait_address(inode, __I_NEW),
> >                      !(READ_ONCE(inode->i_state) & I_NEW));
> > +     /*
> > +      * Pairs with routines clearing I_NEW.
> > +      */
> > +     smp_rmb();
>
> ... smp_load_acquire() instead if READ_ONCE? That would seem like a more
> "modern" way to fix this?
>

Now that the merge window flurry has died down I'll be posting an
updated i_state accessor patchset.

Then I would need to add inode_state_read_once_acquire() and
inode_state_clear_release() to keep up with this.

I figured I'll spare it for the time being, worst case can be added later.

That aside I have a wip patch to not require fences here and instead
take advantage of the i_lock held earlier, so I expect this to go away
anyway.

