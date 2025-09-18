Return-Path: <linux-kernel+bounces-821811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1915BB82588
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6855D18975A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1F1E89C;
	Thu, 18 Sep 2025 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCnMfX9n"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44C28F5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153908; cv=none; b=EGYITKpnXN8UbVpYN/0u+1b9IhcxQajCa2+yuFvpJVIAO3Q+X6E5FTf7E9V4b6iSpOYLROJDtUxEJMnUY4MnldyIqyCcOMLuCaQ/1udqKNWK7/JEXQnFx5dpjIqH+HW4vFNcYf6n4A8lZckTiTpf0sGrfFdTlxve6wM44hkhWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153908; c=relaxed/simple;
	bh=/60HjsF5kDxVQb13pIAAZhD9mjEiPULAqqfFawaT56Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDlEpdVXcwtgISgN1oLNowpdC7aJ++iNgvck6TEFtACkBsFdM7KD5rZe23BbjPlKLyH8l757J0TkTkYTQqJuQZFQ1At9V2ssMaOZRP9geOdGL5y9qCjFk+AGgULiWlhKdSoToYTiEqpHJOwN9jTcazFU68kVhkdV9PwulLzEc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCnMfX9n; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07d4d24d09so60134566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758153905; x=1758758705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7rBzal2frbQpnRlW30Mxkh3elZt0aXaSIdElcYyVLY=;
        b=eCnMfX9nb2niiMkElvWbWYpa4nkIf/PMO+FAJQTRxvqJJGHMmwDnPPSsVwmRt6mTI4
         260q3Mgnk2P0OrD98cBMEpZBvS5gyw1QVeTi9UNkIZ8yPFslTSr1muU6PHgYrMY6g4Kv
         9DouSVdfLJ67uRCL8NW78Joa/ZZ3uQFjbXiRhUNvSXEuLwEGmOnWX0gPPzT65S9HMxfk
         Sf2sxR91myFqMafdi9ZiM1RhLzShswJDnBVqWxoV17/ZczzMiPmL4Zpvxn5LrjyQD2Lm
         pEgRkvoAtHupuZtkZfLNAK9v16g5hPnbd4BgaTitsvlI1P5YQcIR3217kztIGBnK5yau
         PQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758153905; x=1758758705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7rBzal2frbQpnRlW30Mxkh3elZt0aXaSIdElcYyVLY=;
        b=gPxyzXtiqzCz7HLknsTJwI1pcb2tTxjp1qA6g66KGco8HIkWM0OZinWNWvCh4bBe9k
         Ei39xEPTK9k8RltRUjOs3XF5IkIc6mWsjKzzLyhlhN+MqIQhggUf91422WbFn/m7kjnF
         0I9ooyx7IKbfpzqGuNFdbfzAwhRmaTcclFz8jvzUQ2iWvnKXtFAvbvfhI2nfI6Q/V5Ei
         zDnk0lwYTMnhxJ8Qwd4IcnOo3/4+VTwz/Nrhu9k/JwAfVYkaAL4/AUWLDrYkighrCBoU
         N7a4LR9IDDG7zAg7ajqFmEEt2bZyDSdGXkDSbqAGYReHH/eHiI31KZYNskfg7GU17Ybw
         8Hpw==
X-Forwarded-Encrypted: i=1; AJvYcCUHNJ5WplDEXVs+rCpE1xkf1Ald5M94IE+mVxoKW7tRcqkMm8YApVsjpaCjF77vXVX4JKkq2iFwrqfVqwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdE4vKJtnsxZytk4DdQcdD27p5U7MU5Bzk4wH2k6s0nDyntZY
	29Lr+9BqRZ41Eibg412VmKd+sYoDcarvBlSB7I94i+uWjSSOwACYR+amddZoZNqOj4LCQufXMfu
	hbXu3YjrK+7AKdfrNsH9GDLZxpjkxBlU=
X-Gm-Gg: ASbGncsY8jSaOgk4lPLW370mA9EFVsDBhIlcS3jQq+PSj8DPSPwsydSKLLPY0+ISOF4
	kGyCtQLsAg1W9BDY/5nfbRVfnL/LiY0jliKcuTj7IrF+DcOwTMAt10x14PGFqWcAMscrnlem3gI
	xM0/Q5/xjNtE08P8oly53e6UWq+pjTS4cye2wKPGEortIlEne4jHyzTK69uilsPcPgtI7X+DVCj
	tb7mqncJft0pPZJ19Lb8kEJX2M9ao+CTKtPfeCKWoNVc6lFfc966ymtlQ==
X-Google-Smtp-Source: AGHT+IEG0rY/6zoPQ0V4J9TEMxL5qWtyUtLwQjBHHbE0kU7UOpID9Vbuyc6wLRhaE+GAd8+JbDeWJnkobCY95bQb0m8=
X-Received: by 2002:a17:906:eec3:b0:afe:e9ee:4ae0 with SMTP id
 a640c23a62f3a-b1bbb7425fdmr420216666b.59.1758153905204; Wed, 17 Sep 2025
 17:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <aMs7WYubsgGrcSXB@dread.disaster.area> <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
In-Reply-To: <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Sep 2025 02:04:52 +0200
X-Gm-Features: AS18NWA8wIEg-rpkslqLzmFrp09CSxzRRbJVlRWEvQeLl_2xapCCNgyg1L-JlpY
Message-ID: <CAGudoHEpd++aMp8zcquh6SwAAT+2uKOhHcWRcBEyC6DRS73osA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Max Kellermann <max.kellermann@ionos.com>, slava.dubeyko@ibm.com, xiubli@redhat.com, 
	idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:08=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.co=
m> wrote:
> > - wait for Josef to finish his inode refcount rework patchset that
> >   gets rid of this whole "writeback doesn't hold an inode reference"
> >   problem that is the root cause of this the deadlock.
> >
> > All that adding a whacky async iput work around does right now is
> > make it harder for Josef to land the patchset that makes this
> > problem go away entirely....
> >
>
> Per Max this is a problem present on older kernels as well, something
> of this sort is needed to cover it regardless of what happens in
> mainline.
>
> As for mainline, I don't believe Josef's patchset addresses the problem.
>
> The newly added refcount now taken by writeback et al only gates the
> inode getting freed, it does not gate almost any of iput/evict
> processing. As in with the patchset writeback does not hold a real
> reference.
>
> So ceph can still iput from writeback and find itself waiting in
> inode_wait_for_writeback, unless the filesystem can be converted to
> use the weaker refcounts and iobj_put instead (but that's not
> something I would be betting on).

To further elaborate, an extra count which only gates the struct being
freed has limited usefulness. Notably it does not help filesystems
which need the inode to be valid for use the entire time as evict() is
only stalled *after* ->evict_inode(), which might have destroyed the
vital parts.

Or to put it differently, the patchset tries to fit btrfs's needs
which don't necessarily line up with other filesystems. For example it
may be ceph needs the full reference in writeback, then the new ref is
of no use here. But for the sake of argument let's say ceph will get
away with the ligher ref instead. Even then this is on the clock for a
different filesystem to show up which can't do it and needs an async
iput and then its developers are looking at "whacky work arounds".

The actual generic async iput is the actual async iput, not an
arbitrary chunk of it after the inode is partway through processing.
But then any form of extra refcounting is of no significance.

To that end a non-whacky mechanism to defer iput would be most
welcome, presumably provided by the vfs layer itself. Per remarks by
Al elsewhere, care needs to be taken to make sure all inodes are
sorted out before the super block gets destroyed.

This suggests expanding the super_block to track all of the deferred
iputs and drain them early in sb destruction. The current struct inode
on LP64 has 2 * 4 byte holes and llist linkage is only 8 bytes, so
this can be added without growing the struct above stock kernel.

I would argue it would be good if the work could be deffered to
task_work if possible (fput-style). Waiting for these should be easy
enough, but arguably the thread which is supposed to get to them can
be stalled elsewhere indefinitely, so perhaps this bit is a no-go.

