Return-Path: <linux-kernel+bounces-767303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7AB2529F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF481881D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E16298CDE;
	Wed, 13 Aug 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/WITrVl"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91F2957B6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107768; cv=none; b=DHiSDbtRYjMtUKJs5fY8qtYoWmPO3I5L5niepEXvwpnv8kVlkxKMwldRg9wBUMyDS0snnYevtNdAMvY6IfQZvmoNGBPCY4gMSd6m7QqXr4XRMp13weEEpD+zUGfXaFvyZgbW5Kjw0drK2NxFafbLX37ZWkg9rWAV22BuRqbrUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107768; c=relaxed/simple;
	bh=V51uJT4A0r7hr5YTUOsZNBFHeS8Uo5cK1ak9EIJDOR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1DuRwhhjtTi1OpGPNXk9J7OufcELqIyLBFcQxHKSnVggpb7cok1j6AJLCm5OXe6HguCtnueyHHZE9L06YLuv3dJ8Og4wA/iN9tvETJuMsPhQ7scWCkipFu4vWKpNvYv1dxHKwnAc3WXMRr4h673BWh9xbEzVERAnVtpjWKEIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/WITrVl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e613e90so162269b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755107766; x=1755712566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9QMxHu3t+iVo775MrexW0tJfli2gyhC4QZtnbpfiQo=;
        b=b/WITrVlxvJNWOeRCTDycowpZVW8XWPAITxFnhD7Hzyjt42kHYlhsHmd4ky6vFjKJ9
         t9D1vgWAyT+2y2v4oi5DJ+WMooJXzNALsZ13IxQg/nAFkhOUEdd+Atm1lMl0l6PRfVr7
         7bY8VOOuVFST4mdgyrNYXMnBG9vG9up5ieaSmH3ULIY4+hCzBibe9DFaKKyg3EU/Zhjy
         4EwKb4QsuIsjMSbRKJK/597GQzPtU2i/sxhcfb3XHH4EMNd/2fTsM4Elf9ozGfIvcJqS
         +jTBCHFXaSzcc9GrXM2COHzc15/FLu5zOdZKdKT9u1Q5dbJwfZiMeY1uY8kAAXfzhg90
         X4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107766; x=1755712566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9QMxHu3t+iVo775MrexW0tJfli2gyhC4QZtnbpfiQo=;
        b=xB0kd4fMxcs9F5RiezNq2UBso5kGOCqGLHufPogxMjuLNTHopc6T/uhnH0+Pg2nbo6
         rqk+8S87TyV14t/gOcMlp6EAVHRvEOTr0HeVUHtdvwBg3hg99Lz792kcBiPHHnK9TlP2
         9XdNSw593phHZx1zZ62vyHUE6DGG5WjXo0DrP/ZhsVVCBOnd9TouANHqdy8VqZjj3wNn
         Uf8QWX4zzpPKmvLqZS62FqS5D48XVrzRgMd1slwcW4+dpndah9kWalHSFhKUAkt8jKZu
         QWWTlQYLs6DF259w/VNqxOgoTK9Mc2Wimu8V8HJsWtBrCvjehZxFdHBu1RGVwiiCXOnk
         cRDw==
X-Forwarded-Encrypted: i=1; AJvYcCXbN6dcXckJuCLtuvNJZMKP0HKdZsvmnEcH/zDM9UNXOowurW8LrwrtdV1jHz5ox/56Jc9VB07C1jNYOZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6v8d6PtDbEjfGQ/ZceKLF8WsDZ/2QQnyO9QN5PfIb/JJFebl
	iynU6E8WcdrcTatUwgnDatE6cP7NdEU2NMfXE55FYLrXqJKuswXzP4RR9C0UvcPBI+NyQoauXOl
	nw1/3HVyNsAnx1qS5A/q+D/L+HJr6jtIeUWmgeL9A
X-Gm-Gg: ASbGncu6u557/5KDCU5d+ootRDpvGqbLUmvejmRH3ZdDIOd5NEfSed7LSYXMl2R9rgn
	7VfsgwSC6xhcFj5aNe5KdVsbSDM4O5N2RrdbpZrjgsZx3lnmLJn90I6y3Hz07vyL3AdXJUEm5f7
	cZzLj0HbWPqSoQH3rN/rO+kCys/MKNapKWDP5MrjajDv8e/9II/EmtBRh6R8XU8TeDWLD3MUp3X
	mRjJWx94Z0pT1VBZ+QyZ9Did1+MNa61jT8BoroiV4otD86cLDc=
X-Google-Smtp-Source: AGHT+IGs3FKzRr3oj4hqhoLmP3i10WnkmREI+GoYHnTSGNrLjIuVPInPJfZTAnaddEHUgl4hb24A0JuE74xwTlpCXr0=
X-Received: by 2002:a17:902:d486:b0:240:9ff:d546 with SMTP id
 d9443c01a7336-244584af9ccmr94195ad.6.1755107766091; Wed, 13 Aug 2025 10:56:06
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812125155.3808-3-richardbgobert@gmail.com>
 <20250813062904.109300-1-kuniyu@google.com> <799c2171-7b41-4202-9ea4-e28952f81a65@gmail.com>
 <aJy3la53tn3mS3Jc@shredder>
In-Reply-To: <aJy3la53tn3mS3Jc@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 13 Aug 2025 10:55:54 -0700
X-Gm-Features: Ac12FXx6A6P3y10zhXnAjRuFnvi2QA9wi78ESybO_RVdBQRYKwugQpUGoKV9YAw
Message-ID: <CAAVpQUD4Z-UrANUtdrt5v8xwB5-Qfi+hVUcFr=FZc1eohYU7QA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/5] net: vxlan: add netlink option to bind
 vxlan sockets to local addresses
To: Ido Schimmel <idosch@nvidia.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, andrew+netdev@lunn.ch, daniel@iogearbox.net, 
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, jacob.e.keller@intel.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	menglong8.dong@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	petrm@nvidia.com, razor@blackwall.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 9:04=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Aug 13, 2025 at 05:46:44PM +0200, Richard Gobert wrote:
> > Kuniyuki Iwashima wrote:
> > > From: Richard Gobert <richardbgobert@gmail.com>
> > >> @@ -4044,15 +4045,37 @@ static int vxlan_nl2conf(struct nlattr *tb[]=
, struct nlattr *data[],
> > >>            conf->vni =3D vni;
> > >>    }
> > >>
> > >> +  if (data[IFLA_VXLAN_LOCALBIND]) {
> > >> +          if (changelink) {
> > >> +                  NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCALBI=
ND], "Cannot rebind locally");
> > >> +                  return -EOPNOTSUPP;
> > >> +          }
> > >
> > > Are these two "if" necessary ?
> >
> > Creating a vxlan interface without localbind then adding localbind won'=
t
> > result in the socket being rebound. I might implement this in the futur=
e,
> > but for simplicity, I didn't implement this yet.
>
> I think Kuniyuki meant that you can just call vxlan_nl2flag() without
> those two "if"s because the function is a NO-OP when the attribute is
> not present and it will also fail the changelink operation.

Yes, I don't know why other places were not converted as such
when vxlan_nl2flag() was introduced in 70fb0828800b.

>
> >
> > >
> > >
> > >> +
> > >> +          err =3D vxlan_nl2flag(conf, data, IFLA_VXLAN_LOCALBIND,
> > >> +                              VXLAN_F_LOCALBIND, changelink,
> > >> +                              false, extack);
> > >> +          if (err)
> > >> +                  return err;
> > >> +  }
> > >> +

