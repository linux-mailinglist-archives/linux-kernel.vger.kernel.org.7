Return-Path: <linux-kernel+bounces-862050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CE4BF4508
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60430189D24F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C46D24677A;
	Tue, 21 Oct 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUj9gfrj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706A226CF1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011402; cv=none; b=FYx2XgJTDw4jGnTjEHRRTkqcw68kBFu+iQBkAskEEtCWArNyG5dlSj/m4uGdh4G95Eb3UsNo+SlBxE2qDdGVaIGBaTlDvFQgb+eVWEo9jxhbSKgA7iaLBqH7VUSWCTJAg3HFj4nR2MO6OKOodU6WDoutkiqHsZWReYWnQWkvWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011402; c=relaxed/simple;
	bh=htcS7Ohbflq3HUTJuNNJeirXMdxoa+XlP8nG/tkLPa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf0VBx0Ex3xyT++IrGrO8WOYOh4sVcFwY/gkhJEUM8ZIQW1EZEA2tJb8cW6FVz6qcqMuE/Mn+JllwrDkVoRrDjmAX3anifCZ3JXba7KgO57FmK7hXAoQpWAVNlpWGRUDTa/Br3msH3U195XDykpLyuSI9G6NdYjP81KL0sRH/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUj9gfrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED84DC2BCAF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761011402;
	bh=htcS7Ohbflq3HUTJuNNJeirXMdxoa+XlP8nG/tkLPa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tUj9gfrjbMUc2HjSdbkbdtX0zZ8DuMDl9rUOfOHWp9Dn56FGMeQ/Fa0yFl6E8xWTG
	 CKf/f635obNVt9eGeZedlZDNilfRJnBfPtC8ScsjO7xaOSU1XEvA+C29keGFOXkZ/w
	 GFW1E1OS/PXIh5clQrLROY7Lgpp0FVdkdNysClaagasItwZXH48FqXduXKKSf8dHYs
	 s4mXdPMpPIXdwpAmcU6qeEEg+22h8rG2+adOE090/zwAJQVG5l09uGLrordaxfcWoX
	 rNBC96s9aMmWlamYdK6THWF+bsa0VoNn6WFYWVK2110FH866mPF4oPHCOutK9iUjPE
	 K+CXTGXJRI81Q==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4539dddd99so908981566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:50:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8jV2z+B6+YYCSRB+IDa87eej+5Z6O4Qm0ZJ1vMvms9Lib5dAU6y6bq1e2OK60+I+qd3qho+r6XwVf8iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZG+rkdeF9JKsuV4ejx98FBAK1gKx3oSThjwQaBnXHpVrv/pU
	KdF6PWRn5rYx+KzOLKxVJOmtfuoOsiXOq7V3a61w7k7e2t1hNU8ZX7YMdGL4sZIB9diGUCu+hef
	fkwV5EfbQ77+xunDTnlFvRvDA6Fbz9sQ=
X-Google-Smtp-Source: AGHT+IEzzb+tmcQzG2Fm+h+6do+wmWZd/xd0gS43UlshdlRbK/t6x0HY5waSa9V02ECCBr00hHlFk8aDTkjzJEqTYw8=
X-Received: by 2002:a17:906:7f93:b0:b5b:3ab0:a5b4 with SMTP id
 a640c23a62f3a-b6474f18313mr1312614166b.49.1761011400289; Mon, 20 Oct 2025
 18:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020020749.5522-1-linkinjeon@kernel.org> <20251020183304.umtx46whqu4awijj@pali>
In-Reply-To: <20251020183304.umtx46whqu4awijj@pali>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 21 Oct 2025 10:49:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-EZ1i9CeQ3vUCXgzQ7HTJdd-eeXRq3=iUaSTkPLbJLCg@mail.gmail.com>
X-Gm-Features: AS18NWAiuswYJeAln1hUra1uPeRZcQXi-vK-HcyFwpUVUqXqdEfbnYt4Niiowak
Message-ID: <CAKYAXd-EZ1i9CeQ3vUCXgzQ7HTJdd-eeXRq3=iUaSTkPLbJLCg@mail.gmail.com>
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, ebiggers@kernel.org, neil@brown.name, 
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:33=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> Hello,
Hi Pali,
>
> Do you have a plan, what should be the future of the NTFS support in
> Linux? Because basically this is a third NTFS driver in recent years
> and I think it is not a good idea to replace NTFS driver every decade by
> a new different implementation.
Our product is currently using ntfsplus without any issues, but we plan to
provide support for the various issues that are reported from users or
developers once it is merged into the mainline kernel.
This is very basic, but the current ntfs3 has not provided this support
for the last four years.
After ntfsplus was merged, our next step will be to implement full journal
support. Our ultimate goal is to provide stable NTFS support in Linux,
utilities support included fsck(ntfsprogs-plus) and journaling.
>
> Is this new driver going to replace existing ntfs3 driver? Or should it
> live side-by-side together with ntfs3?
Currently, it is the latter. I think the two drivers should compete.
A ntfs driver that users can reliably use for ntfs in their
products is what should be the one that remains.
Four years ago, ntfs3 promised to soon release the full journal and
public utilities support that were in their commercial version.
That promise hasn't been kept yet, Probably, It would not be easy for
a company that sells a ntfs driver commercially to open some or all sources=
.
That's why I think we need at least competition.
>
> If this new driver is going to replace ntfs3 then it should provide same
> API/ABI to userspace. For this case at least same/compatible mount
> options, ioctl interface and/or attribute features (not sure what is
> already supported).
Sure, If ntfsplus replace ntfs3, it will support them.
>
> You wrote that ntfsplus is based on the old ntfs driver. How big is the
> diff between old ntfs and new ntfsplus driver? If the code is still
> same, maybe it would be better to call it ntfs as before and construct
> commits in a way which will first "revert the old ntfs driver" and then
> apply your changes on top of it (like write feature, etc..)?
I thought this patch-set was better because a lot of code clean-up
was done, resulting in a large diff, and the old ntfs was removed.
I would like to proceed with the current set of patches rather than
restructuring the patchset again.

>
> For mount options, for example I see that new driver does not use
> de-facto standard iocharset=3D mount option like all other fs driver but
> instead has nls=3D mount option. This should be fixed.
Okay, I will fix it on the next version.
>
> Pali
Thank you for your review:)

