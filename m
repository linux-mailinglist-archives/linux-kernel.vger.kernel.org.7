Return-Path: <linux-kernel+bounces-878413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E0C2086B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA8F3AB183
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE3824C076;
	Thu, 30 Oct 2025 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7VHHOUy"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A47230BCB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833637; cv=none; b=PBa28XZcDEtrrpBoKPBGGPM+uuee75r5CAXty2XJ3wCpi+5PwO8HHh/SP2+1cjDxBkbfsOXWwh87dhtCBHAXpQ1VlF+h+YMEvhqZLARCSpZWUM7F8RSc9/SZoRAvVXp8ayXP1S+5A7FPAE5n8Z9Vw7EFlrUFUD59uySWyR4Id8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833637; c=relaxed/simple;
	bh=94nDq8zBh97mffHHJCaEGopUfRCzcjVIRb5EcN4m/EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4sQC8AQhgDoiUdbKCsZFXUezUGhC0plvuF1ewXM4GDRxLU+ymsrxWKaR0OkGByoak4GaMM47mlFhqBrx2Pz6EXtheC4MqG+MirWHceSo8hAAxboObXbxokdAR5/SkaySroSmassEw9YCqA/QkyBZMPQnYT+5gBM/pdkz2NwrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7VHHOUy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso132280a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761833634; x=1762438434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOC9DCoI/J/8bu8rwIJ0BqF4IPlr7KAf52CibhE5rhU=;
        b=O7VHHOUy4Y+X2t4LqR7Q3shM0D+MZEgB2ZenQg9mRTVdyQf8zbim8m39gaabue3uvI
         wd9r9osTkueechVgHqRrmanq/KOr8VtUB3AWXX4jcf5OhRLC2dlvMTjTUhH0ICZupj2+
         SzX/O+vWc6FGBHBUr50hI1a50XZBW0WVNMyH18lFGF0YOXX9baz49fC9DD41ZY2OP9A5
         z4taTY1dQ+eS0V12FkFS9Ju2W8I6D229VmyM2VCiNi8HFSaTNzmS+UiH0LUFnLu22pgQ
         Oq9usp4mLK70qPzt6OvMfYa3AyU1CpOCJV/ufRtr5OKIobZe2inrKXtwJUX/LAXxW19v
         /OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833634; x=1762438434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOC9DCoI/J/8bu8rwIJ0BqF4IPlr7KAf52CibhE5rhU=;
        b=mqjzmXqUFGOzfG66dPfyihoCS9HJsboPFdPRVrogf57FeI/Lha0j2SE8Lb51+9FYCw
         GrRXG46P2CghKGC+eXBa62O/ENBSaIMYgUN4Xgkl5cukaTuT44v6eKc0ptinQu0JskfS
         NGBf3f67FTXyUk4fkymOltbT98b1UA/ru5e7luM0qUrwxlHafvsV5/a6t61yGXWgh3Cm
         1QrMu9AZcqprUqpEi+c/a7auHO9S9g3pnOtdjHIitMycw1uDUTRownD2nRmV/Ywtp3i2
         DHCPA2Uk/hFiLnWFcCs5BpEH3kbOLb/upIiKWrPX5FwQUERoC+gUbhiKkt2ZxLPRrTSq
         TPlg==
X-Forwarded-Encrypted: i=1; AJvYcCXACSBjj9+ocVJLHGal4sy94juuUcxmFiUZfe+yxEYmWE5lTgdXqsTMZKAyHObtJNZpndtlv91VmysIFQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZTGx6ZOviriw+8HAAnHXTmjajNimRrzIvBy+Dtqo945XCpBJU
	qNwxRGtEhNRjuIiNw9wRJcoPMAflL2Yo1ENGcyrGa+vlTx1frsAoHH84U1xTnFgRMUyu+mfLgBs
	jrz6wpRxdwCHc59EVvFRXOZF6/RZmykE=
X-Gm-Gg: ASbGnctFPC1ts3lmnIJ+xtaEqz7oNiQpXV+AsHPBJUtS76gHjlr4ubFLRcThpmmGJis
	hXAsCzut2vvNj083xjTcDDMqMUGuhjvt2CEIUJnVKXx+ZiaoSPOfGvd0KQBhvoujI5e4KyTgJek
	lUf21H5EP4zXAF5Vm9LD2QBlCBa6PODj23EVOj81G2QOn571nNCqFELXitjVuiTQ/zF9io/y25c
	2R4Xm5bTGjdTnsQvSmAtRAjzQPsXX3edRNzqFWRVgJXBNAhCK8v4Srp09zC9oU+N2vX3v/goQqA
	3lmwNT6ZtJftw06n01AMZ8pvtw==
X-Google-Smtp-Source: AGHT+IHHiFU7O4X2/IErWSfBx1kH/lPRHPmhsiq+izBQRCkA7d5xQXqg6CS0MeVhAebPeWBMpKqtWUmkxAZqrttEmnY=
X-Received: by 2002:a05:6402:35d4:b0:637:ab6d:71c0 with SMTP id
 4fb4d7f45d1cf-640441cde44mr5940503a12.7.1761833633789; Thu, 30 Oct 2025
 07:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029131428.654761-1-mjguzik@gmail.com> <pzstmkemz36aecf7ckphbcz3ph55cn6si3ca2nm6sku444365m@pntnbgblgxuf>
In-Reply-To: <pzstmkemz36aecf7ckphbcz3ph55cn6si3ca2nm6sku444365m@pntnbgblgxuf>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 30 Oct 2025 15:13:40 +0100
X-Gm-Features: AWmQ_bkA9dBRMVR-2VtG6VNKL-gCT_mzVoOQ03lsjs4LdqZ-PeopA_KO9V5L_2k
Message-ID: <CAGudoHHsV5oyOnKNuQNwQXTeS4ZQp2pTnbrQ3B9+_dvFkmA3bQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fs: push list presence check into inode_io_list_del()
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 2:54=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 29-10-25 14:14:27, Mateusz Guzik wrote:
> > For consistency with sb routines.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> Not sure if you've noticed but inode_io_list_del() is also called from
> ext4_evict_inode() (for annoying reasons but that's besides this thread).
> So there you have another list_empty() check to deduplicate. Plus ext4
> actually uses list_empty_careful() for the unlocked check which kind of
> makes sense because in theory these checks could race with someone removi=
ng
> the inode from writeback lists.
>

huh, gotta say this is pretty bad.

i'm going to the updates later for the sake of the clean up, but long
term if ext4 has to do this, the evict func should postpone
inode_io_list_del instead. there is related mess in interaction with
writeback as is though, so this is for some indeterminate point in the
future.

>                                                                 Honza
>
> > ---
> >
> > rebased
> >
> >  fs/fs-writeback.c | 3 +++
> >  fs/inode.c        | 4 +---
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index f784d8b09b04..5dccbe5fb09d 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1349,6 +1349,9 @@ void inode_io_list_del(struct inode *inode)
> >  {
> >       struct bdi_writeback *wb;
> >
> > +     if (list_empty(&inode->i_io_list))
> > +             return;
> > +
> >       wb =3D inode_to_wb_and_lock_list(inode);
> >       spin_lock(&inode->i_lock);
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 1396f79b2551..b5c2efebaa18 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -815,9 +815,7 @@ static void evict(struct inode *inode)
> >       BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
> >       BUG_ON(!list_empty(&inode->i_lru));
> >
> > -     if (!list_empty(&inode->i_io_list))
> > -             inode_io_list_del(inode);
> > -
> > +     inode_io_list_del(inode);
> >       inode_sb_list_del(inode);
> >
> >       spin_lock(&inode->i_lock);
> > --
> > 2.34.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

