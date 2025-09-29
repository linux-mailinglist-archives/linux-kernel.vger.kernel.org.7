Return-Path: <linux-kernel+bounces-836304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15ECBA9406
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8529F18883E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5133064BE;
	Mon, 29 Sep 2025 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCgn4P2K"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2545B3002AD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150599; cv=none; b=RfL8XuX4Enqka07VQzob6y5HQLT2mwOakL3JHwR/cV9yVUdPCT+IFAt+gacfr3wAQcE3/gD6hNVWF4nJVU4dbNnFhABA1cs/H0Fp2KfGawPD+B+ptm/LGMjQHI0a9QI6Uyp+7GOjpVLViXQHS0y7dbXPXDlcrYgsfrqPP1wl95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150599; c=relaxed/simple;
	bh=czoR4K1G+s7y76NbjlWpJJ4z4V3QKtSDAu6HI/RHErw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psqwlUwkBR2Oh28rPmx8Q3fl9uMENdEsAYCiBbfaIl4k2MkosfTEUKckJfSyXLOO42FK0zh7fqFe6H3qPHmnm2rcNCeCZK54N3zpj51KxQhHStMUqVKmI26vceMmFvl5b8ZCIQ7vDg28G8E8LCpEP6zBZ0byXMDSreeXa5PZHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCgn4P2K; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so243465566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759150595; x=1759755395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT64PoBlF5OmMwmdMDL2m5IBI9zs1VxmhdKVWW/7dn8=;
        b=FCgn4P2K1bIgFAJoDuau++Y6+Tu6orG3eYikQptlTbn2qk5fvnEX7rNz9xsa4ZIAk9
         TNz6RZf1mVEJ+Su1njyT9bIYaseGuw0JWXQMPRpP00jx3gM9a4BJqrnV9kYHqPXbJaOq
         dhlEb8pqe7t8ANKhDaOdu1T1Y/mpR47EeDuatvBM511yYbhWL6Uu/rIc2s4AYq5Ndc0a
         fop7n/Pv7EAT0po0BdS0IYOt4RiIvQ6Mn+1uZG2p8wrWzsrtqds8fVEJ48NrNm2Iofnq
         nfDx40KqhrUAlKvyAFMaZdew5N8LuEja0ysIg0wwj2ntDhoqum1eyE8GcCYO/dnVabBV
         mIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150595; x=1759755395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT64PoBlF5OmMwmdMDL2m5IBI9zs1VxmhdKVWW/7dn8=;
        b=S61T+zsaRyQurBzTzbKmBdNQ3t08GlIld5SFyjeLZudEkxdsnhNiYx/1qYoNH91VML
         Uevgo12W3+BcxPE5qhFp/foBORTyQuuAikSWaclGBKbUyhNvXXnYznFTyeWqD+2hOQMY
         wm1lndL9BynJ7oibvTcX161jlnc7auPeEHmPPsZiTvft8jJ2SsGI5R7bqR2GfVK1hKyd
         5FFEKP4PjhZt825sx+NPRJKcn60sFuweygokJ94whgoqYilIWQrtmrU4t6SRrJEmVGgM
         ZiTpJwcSVCLKmZb4RASVFbBk6qBWN8BXzOj5+3+eeqtLK9YQs+QrgE1D2cirEaQ1ySWP
         gW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI23YJCrz9hi4xagvCL/LKv27qvrGzJWHUqFG3UotmesJIcg27usSSKMPJnKdAW0GgasZdeOnsQOAt6A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+QQOhN6aivtc0koeqW5ul2QGbVcBmRUpXweQK098laJ/LOfl
	TV++l5dnI4+gzsA1s/Xrj3t8JSAGhvzMdXMkT4BQU3fMUwF2s7RlKcBW5K6yd58kc7R8VMB8qRq
	2EYgXTDCNTix3oOiR1MtHzCUxog9yRRU=
X-Gm-Gg: ASbGncvheVfIs3uLyBxDb6qFl7ycMo7UNEnOW1241cTKUlXhm9QpZUfV2Y+Pa22eOgs
	S8JRbXjN5qG0BcLWpn4nJOU3d5JjI7M0eGKDsSagaqsrlU8FgIjLkk7BQFCklZh4qNIjb4J8YsK
	Cagx3KDgBJx2+Tq6TmNin+BIAXB4m8MM7+m5Ym2f/mYVPjp5B/Nl7ywJ5EgRqf6GPZk0VCbSC4c
	FSOn5c9fpv/bMd0jFWXIDKwSK8EV8cp5d6FflYsdVwU8dN74IcSo1pzM2DxAFM=
X-Google-Smtp-Source: AGHT+IHwgU6a7k1Tl/htBp66waMHN4IzraB7wwO8zA//bOHkHjYwuv41WV4gECwjjXP36V6Dgiwj6qkk1Bdqwjmi4TU=
X-Received: by 2002:a17:907:7291:b0:b3f:9eaa:2bba with SMTP id
 a640c23a62f3a-b3f9eaa2f1dmr276916766b.63.1759150595150; Mon, 29 Sep 2025
 05:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923104710.2973493-1-mjguzik@gmail.com> <20250929-samstag-unkenntlich-623abeff6085@brauner>
In-Reply-To: <20250929-samstag-unkenntlich-623abeff6085@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 29 Sep 2025 14:56:23 +0200
X-Gm-Features: AS18NWAQppLQGH4Q4QepXGfVar_40_jU-wol-wjJISWMpqe1GoM3Cv27IqmClpo
Message-ID: <CAGudoHFm9_-AuRh52-KRCADQ8suqUMmYUUsg126kmA+N8Ah+6g@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This was a stripped down version (no lockdep) in hopes of getting into
6.18. It also happens to come with some renames.

Given that the inclusion did not happen, I'm going to send a rebased
and updated with new names variant but with lockdep.

So the routines will be:
inode_state_read_once
inode_state_read

inode_state_set{,_raw}
inode_state_clear{,_raw}
inode_state_assign{,_raw}

Probably way later today or tomorrow.

On Mon, Sep 29, 2025 at 11:30=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, 23 Sep 2025 12:47:06 +0200, Mateusz Guzik wrote:
> > First commit message quoted verbatim with rationable + API:
> >
> > [quote]
> > Open-coded accesses prevent asserting they are done correctly. One
> > obvious aspect is locking, but significantly more can checked. For
> > example it can be detected when the code is clearing flags which are
> > already missing, or is setting flags when it is illegal (e.g., I_FREEIN=
G
> > when ->i_count > 0).
> >
> > [...]
>
> Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
> Patches in the vfs-6.19.inode branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.19.inode
>
> [1/4] fs: provide accessors for ->i_state
>       https://git.kernel.org/vfs/vfs/c/e9d1a9abd054
> [2/4] Convert the kernel to use ->i_state accessors
>       https://git.kernel.org/vfs/vfs/c/67d2f3e3d033
> [3/4] Manual conversion of ->i_state uses
>       https://git.kernel.org/vfs/vfs/c/b8173a2f1a0a
> [4/4] fs: make plain ->i_state access fail to compile
>       https://git.kernel.org/vfs/vfs/c/3c2b8d921da8

