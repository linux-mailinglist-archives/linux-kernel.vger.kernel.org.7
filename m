Return-Path: <linux-kernel+bounces-838858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0DBB049C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91EB2A212B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644B22E92D9;
	Wed,  1 Oct 2025 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haK9n6CH"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A82BE036
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320748; cv=none; b=pRYEJBEwv/tU1gn17M2WJPvqmuv9w8GTMWqnMAKvGKfWSj1yFigH6+jIiLiq62f1pOwQcAuza7RonahNvh/Hr3mPd/C0GqHaFDrIVIPxxSlLeIW6q4WtQ4W22NgicZJSZlJTxcTeb6tAlwDIUqzrOO04MKFFgwErj8SiEvcVkQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320748; c=relaxed/simple;
	bh=wm1BeP3OIG/CEpv0bx0FPzGIxfrbnvmyJFFdHO4c9MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goVs4YEdXMbXWfEueVAZAtECIj1EPO/0dC2wlGcTbVIVntLnhgHzQqU0bqOJKs3ck2XmilAAH7YBKJMm8WSWLby44VokC3c3zPzBmXm5Y7Bkh7osNJ1uHx2rwl/3EquMDCOVXyDWJKIDHzztIwr4M5KuYUrO+g+u/Yz7TXpHZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haK9n6CH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b472842981fso119469766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759320745; x=1759925545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMNKUKq4O6fuNIsiIVyyJX5XuuNZnMram+bZtI5+QUE=;
        b=haK9n6CH8B3B7s+yzcJ09ROj+WyVMVy/FAF8imtoDJQsyRuh0He8kPCEZlYBT8unTG
         joyKlviP7y6nZmKKMhmjpMBghtWqYXV/C9JOmDP3qxGA/vP+iHZ4fUtf0hDFqKTw3JC9
         WxK9S0FRLoAolwCnMdXNrGskEXEJCXsvnrKxq5aTwxumpol5y/rwTZP3E+m8lcQJMvek
         HWff+Xp1TXNlIUSIIpJYws7uCz/kcLMna9o2plD8NnYkrmyh1rSdoh0Zm4TQszTEVwtH
         E+LiJTUtHTLUqrq7kAIpfVo0zt7KX1PSAID5aAsfGP/VFu2dJxKG9jaDP/wq6/8P42qP
         iBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320745; x=1759925545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMNKUKq4O6fuNIsiIVyyJX5XuuNZnMram+bZtI5+QUE=;
        b=dcKR2v1JuHOR/4CC3747BnPcC7PzNN7Vv8itU5Q89wwKJp0LIo7am+f7VGLbvye8oc
         vFfV49D9Ox0zKbI4qh9nnXVEPV9B3K6sDa6U0rMf+qF2bMn8MwNIzFTZmJ+pdRMYUe86
         zdB0U5Wpww3KQDTlUdBESPkDxkFqq52biNRTvpapbiR9GNxZP+Q3iIQx/zdwhqlsnenJ
         zRQ7W/CBoXz/i4PC4kAlcq0LQqBeWXHBxmiZ/9wOxR5Ss1Z5QBTxOtbiMkLdHOi9PO8a
         PjSki4NomYadluKoE5rtkGq72Bx0eKq6FFKlC6fG526g8F1F4NkvFoAxxmEjYavxRRIG
         +3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXmoFhfgSnCKwPDnJQ4leBLW3HZoCJRcblLBSa0kbOb6w+L6mES2ptfoOZ1vbwhTQZqXhswUExRVFzfgVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkF/DUwCl9RkhFipPv0BSXBg/XkyNlAZE8MLvVKlkNM3is0WcQ
	ZG69r2n8Qj43q/um7EhllZNwSWyb6jkwaELNcRILbX6DFTXCQRZOR2x4a6mNDz7pMwajf9Xomnm
	dp/QpLcNPNuOeCTn3q8aC4ls5ALOFIyc=
X-Gm-Gg: ASbGnctQWLCwJC92N/ON5JnV+6LVfc8SX+tk8ax+a6Wrz2fevfCN47MdNr/uvFsMaX9
	9gSFVR4aCXggqchPYvdz3NmGTk3RdecptOHi1bAyf1+8NjWR53QP54ZNTligE17R/7m/WI7nVJ8
	wmbfHIOfIrQnsxZPaRu2kVPLf3lMCgbUGH7PWiYx8/BeUk5t3CSH7gbzFZqCnbqxxSiKknD+3wc
	9YCOURObI5zl9KG8cObgft8DUqXOIH0MEGK/193WLYKv33k13ug7FxKSeQ+GIkK3w==
X-Google-Smtp-Source: AGHT+IF8r80Y0ZoXsIQn0Y5R+RdX9mAD1JyxavDsPaW3QjZWyIinKq3HCORm57T6oAyaRkcFtYjYf2FoIDT7QGrslA8=
X-Received: by 2002:a17:906:dc8a:b0:b10:9e5d:d173 with SMTP id
 a640c23a62f3a-b46e6339e6bmr357263366b.41.1759320745155; Wed, 01 Oct 2025
 05:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001010010.9967-1-mjguzik@gmail.com> <zvd5obgxrkbqeifnuvvvhhjeh7t4cveziipwoii3hjaztxytpa@qlcxp4l2r5jg>
In-Reply-To: <zvd5obgxrkbqeifnuvvvhhjeh7t4cveziipwoii3hjaztxytpa@qlcxp4l2r5jg>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 1 Oct 2025 14:12:13 +0200
X-Gm-Features: AS18NWBAHDbuuueF6_VwFlNYhEG4JuTxqmkvI17PQrp5AyJYj9GIJmIn87xJWkQ
Message-ID: <CAGudoHHZL0g9=eRqjUOS2sez8Mew7r1TRWaR+uX-7YuYomd3WA@mail.gmail.com>
Subject: Re: [PATCH] fs: assert on ->i_count in iput_final()
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 2:07=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > diff --git a/fs/inode.c b/fs/inode.c
> > index ec9339024ac3..fa82cb810af4 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1879,6 +1879,7 @@ static void iput_final(struct inode *inode)
> >       int drop;
> >
> >       WARN_ON(inode->i_state & I_NEW);
> > +     VFS_BUG_ON_INODE(atomic_read(&inode->i_count) !=3D 0, inode);
>
> This seems pointless given when iput_final() is called...
>

This and the other check explicitly "wrap" the ->drop_inode call.

> >       if (op->drop_inode)
> >               drop =3D op->drop_inode(inode);
> > @@ -1893,6 +1894,12 @@ static void iput_final(struct inode *inode)
> >               return;
> >       }
> >
> > +     /*
> > +      * Re-check ->i_count in case the ->drop_inode() hooks played gam=
es.
> > +      * Note we only execute this if the verdict was to drop the inode=
.
> > +      */
> > +     VFS_BUG_ON_INODE(atomic_read(&inode->i_count) !=3D 0, inode);
> > +
>
> I'm not sure this can catch much but OK...
>

It can catch drop routines which bumped the ref but did not release
it, or which indicated to continue with drop while someone else
snatched the reference.

Preferaby the APIs would prevent that in the first place, but there is
quite a bit of shit-shoveling before that happens.

