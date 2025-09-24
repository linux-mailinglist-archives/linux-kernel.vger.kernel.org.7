Return-Path: <linux-kernel+bounces-830986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 104B3B9B14B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458951B23C07
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D6E315D4D;
	Wed, 24 Sep 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPeXBiSP"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4C19066B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735506; cv=none; b=ULJ+DHbd5TzJ0YnuOXrqKNSKVlM2WUxoL+M4cnF5CIvNXaWPJ0Y/QTJhkuxGniiCrqrDFc2oSAnJVhOmZlMvNk0tofXihm9DMsPJyNxrWfqoe4ghcpbm+oXIE+foqZ7oMKF474EhpVyxqwCamnldVuOmMjObxGOWAFBu+CGJSsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735506; c=relaxed/simple;
	bh=Z17DVKG/RBCGaD1+SPrxGUmyIL1h9oOOffGlgKmOAgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idtkUaTaoxez17oYvNGzGOudgU9isBQ42jtt934WgR7yNTIFQ3brlSUol/Y5DplYL5I5UjkfsOx7Nb9jPEM+k0XhQIu8cG/ed2PxkKs6zTkGXOr/pfRvHfBYNpnkKEnASatb83MclkSLQu8MgXfcd389EkLjPe23xiLpaQ+WHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPeXBiSP; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42575d46250so416135ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758735504; x=1759340304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30S3XZGJU9mWOJVs113Jcz1pN9m3tlO1m1w4FB2QQH0=;
        b=cPeXBiSPhgKvAx3yB0w4jDUrHctCeUNFqhbOXc2T9CpMVkspdxQcgJSbSx4o4PK/7v
         XmjLZv7Z7Hrm1fIRhcVXsmm3gkgLXNxpa2aJERTwFCEFa3cRCZJ2tUPIycLL/pD37od0
         oHcPcgbp5StjHKkGyU+uTJoqKUK2oRxMajJZH2L+zjxhG/TjymzDr7jKWg/JS6xcILPC
         2F79GAXeQKhB6FSnT7ukBnYDf30oG7IPq05qEfxG9jARDUhDtN4rA3KiHX2lPECx0pm/
         /deecOo2UpcAnCfwLz0vnw2sHZK6d05wvVfIBsp4L4DjkssildmipWKlag/tIu3f7tm0
         +ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758735504; x=1759340304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30S3XZGJU9mWOJVs113Jcz1pN9m3tlO1m1w4FB2QQH0=;
        b=JGFXHwwRKDT7u9IJblXMsw0iot8btEX4RHbxCW9UXp1M17IzKohUy15EekOA19h3XI
         lwhhRJ4LMRT7LZfe8GTZ7HpqgsooKo83qdBkO+TfXRvQcUpzqO8cqOSJfdADcPh27IOw
         xgGuip4G0gEDHMGn9IFm0ICu5OUwSLOa7EPdd9ae/Qdwboa9Vwhq8O62T0khbGDnWC/1
         YJlxxPAuTYTpTkiKSUzZZ3Detf+sHj1pR8m7qOVkYW+hTx1LRXVBsmPiCvsJN0YdlvPE
         2GEAct+noXhagOyTSJXLKZRv0XFvBOonmSrXjj5bRaoQtOwYix7li/HUOwIFVFL9pXbK
         JW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyNsA8L8LdAwi0TA5rouCFLekbXow/jK6wRUSP89VW2Jl1+sHtJ+V62XiHvz0Yj5VOoksHZOpk6hCGTas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOJCLrr0NtUj92sbtw6HbLQ4e1azztEuI39UZwVfvvY20Ym5d
	GzZaH4C2fL/XpXrsG5tHo7Jajr1BI3uU6OBX3dKHuczAXVN5noCIWBafNRJnN9NWjCMWDTM4QVz
	+lBhcvqmfpaRQIhAs+4glANtsIGOE0l0=
X-Gm-Gg: ASbGncv7H8vTR4lFsihVh4Bd8WzY48a9sKUQaO0/Adv4Vuv800vFuY+YI/w+JvcOSGd
	KkmK9n0fovbBpc5d3DKiyhuzo3WsocB0ob63QohhBR4B/JVAnvvBCLKis4uSTR9psnyC9+KURTP
	a0xILjr5ypBmoZ/ovRRANXpYPzAlLObE5MTQ9CMhm03ZnoMMV7Lu0GXyGS3d/9xiiCyFQkB495r
	ObY
X-Google-Smtp-Source: AGHT+IF6MTXy6w1DyXC7/o/nI0lSM4Q/Gz/7/Id81c+he4tFC30Z8cRyZeTvBBdURAh4Zo5aTq0YpXpMF9IG5v6/6so=
X-Received: by 2002:a05:6e02:218f:b0:424:1c9a:cadf with SMTP id
 e9e14a558f8ab-425955ed4d8mr6926285ab.3.1758735503219; Wed, 24 Sep 2025
 10:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923102547.2545992-1-vitaly.wool@konsulko.se>
 <68d2cfc2.a70a0220.4f78.000a.GAE@google.com> <20250923215929.GA1122379@cmpxchg.org>
 <aabca3ff-3cbe-468a-9b65-290d5239d987@konsulko.se>
In-Reply-To: <aabca3ff-3cbe-468a-9b65-290d5239d987@konsulko.se>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 24 Sep 2025 10:38:11 -0700
X-Gm-Features: AS18NWAPSCyNKHQcdiRVEaduc42g7VmVYowOBIJ4ozJua0iyYaZ3jlavJyn10Pg
Message-ID: <CAKEwX=P18Krj-+rXvTSCocRt+Q3o07Ghisv4nJLRCJ8tLus54Q@mail.gmail.com>
Subject: Re: [syzbot ci] Re: rust: zpool: add API for C and Rust
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	syzbot ci <syzbot+cica6a1c285444b25f@syzkaller.appspotmail.com>, a.hindborg@kernel.org, 
	akpm@linux-foundation.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, chengming.zhou@linux.dev, 
	dakr@kernel.org, david@redhat.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	lossin@kernel.org, mhocko@suse.com, minchan@kernel.org, ojeda@kernel.org, 
	rppt@kernel.org, rust-for-linux@vger.kernel.org, senozhatsky@chromium.org, 
	surenb@google.com, tmgross@umich.edu, vbabka@suse.cz, yosry.ahmed@linux.dev, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:46=E2=80=AFPM Vitaly Wool <vitaly.wool@konsulko.=
se> wrote:
>
>
>
> On 9/23/25 23:59, Johannes Weiner wrote:
> > On Tue, Sep 23, 2025 at 09:50:10AM -0700, syzbot ci wrote:
> >> syzbot ci has tested the following series
> >>
> >> [v6] rust: zpool: add API for C and Rust
> >> https://lore.kernel.org/all/20250923102547.2545992-1-vitaly.wool@konsu=
lko.se
> >> * [PATCH v6 1/2] mm: reinstate zpool as a thin API
> >> * [PATCH v6 2/2] rust: zpool: add abstraction for zpool drivers
> >>
> >> and found the following issues:
> >> * BUG: unable to handle kernel NULL pointer dereference in zswap_store
> >> * KASAN: slab-out-of-bounds Read in zpool_get_total_pages
> >> * KASAN: slab-out-of-bounds Read in zswap_store
> >> * KASAN: slab-use-after-free Read in zpool_get_total_pages
> >> * KASAN: use-after-free Read in zpool_get_total_pages
> >>
> >> Full report is available here:
> >> https://ci.syzbot.org/series/e8b22352-ae56-4d7c-9113-75573acf2b64
> >>
> >> ***
> >>
> >> BUG: unable to handle kernel NULL pointer dereference in zswap_store
> >
> > struct zpool {
> >       void *pool;
> > };
> >
> > struct zpool *zpool_create_pool(const char *name) \
> > { \
> >       return (struct zpool *) prefix ## _create_pool(name); \
> > } \
> >
> > u64 zpool_get_total_pages(struct zpool *zpool) \
> > { \
> >       return prefix ## _get_total_pages(zpool->pool); \
> > }
> >
> > You create the zpool by simply casting the backend pool, but then you
> > deref it twice as if it were an actual container for the backend pool.
> >
> > I'm guessing you didn't test this even superficially?
>
> LOL, no, forgot to run git commit --amend so came up with a wrong version=
.
>
> The Rust version is correct though.
>
> > This also still proposes an API with no in-kernel user.
>
> That's not correct, zsmalloc is the user.

A single user does not an API make.

