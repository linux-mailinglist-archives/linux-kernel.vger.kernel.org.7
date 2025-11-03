Return-Path: <linux-kernel+bounces-882985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C81C2C167
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D351893B8B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C802DC334;
	Mon,  3 Nov 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIfc0l6k"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B626F2B6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176596; cv=none; b=Ql9VFhyktFM0P1N7QBteAjWVWor51xM28D1mVYguU+ViroxguXvFpieQHt79raijGQhAAkHxme3FOwFuJoe8+HDwMgiyn2dTehiyhx1NblK2gAiYuIqbgjDxzoctN085FbivmxfZnef6yO52NU1Zd/tdzuf/sueVAiEBbBgENQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176596; c=relaxed/simple;
	bh=3P4uhXaD5ilvYs+a4RtrwVqLA5w/zngN8+yS2F+4lkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJWm1XH5uylpJQ7v33ic9N5ng1XHMD+plirswRINIBx6JFYOHluC1LoprtkBVlSG3nwt4w3NDrEsDJVHDy6H1W6Hr4pI098CB5Q3NomJspfAE9GuR+LR3Llnk50GEAe0zFTgzrePrQouZm7jGySvC7agC813l+NyJB6Vh7ivoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIfc0l6k; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64091c2e520so3302137a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762176593; x=1762781393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a21JbFZrSRmyl+TIWUp5y75+miyXDqyFyLKW07xgMRE=;
        b=iIfc0l6k9iNQArxxX2qbTR4pYsdaNIZ+O0bZS+XBE8EwQROeAVrFCu2U6PBIjIhraX
         suZNP2HKkCrkhFRfJVo9pyOplIYGW7dcmUuqnY9c40lEekzqbtTY4i73leXVc8hl4+jE
         ZWGuzBP6tGg8MH0wbbwhE09bM1bGXHolSrhfM1prGDB9cyYHmiQ0l86NMY9N9e22F752
         ccz127Qgm/Zwcw4gYj9gylM3DpNnvguc4OeZElaIjAP9QE6YuQMj3CCTOmjmIvcXW2At
         4esTOikzxDAhxUICWw0ISVF7OFAeqdFTaNPpF0fHIOFA39W8YGD9CwZ0m5QUbAAdpKLC
         f7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176593; x=1762781393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a21JbFZrSRmyl+TIWUp5y75+miyXDqyFyLKW07xgMRE=;
        b=S1LhNQbemnklQ1U4ghXR0Ao+RIxgwKlTV5iqEpc700I+EEOgt5Sy4DXmTDvD/4tO8v
         cQjK3YFo2TJW72ETUewGhxP2ehVU3gcHMq9Ow9Y71lD29KJ0Q3wmPu5e6PkdkW7vuQ9w
         NXklt5/JI5nxv0GJXHiNpoWGJZEclTxyRKlv4bl4fxt7zR2zGE27k++l7WYK9GHtT0K8
         ZeosVGypmjpsVd8PK8FUXYUvvTbiJZJOCcZn2R4y7h0+OukzqQnDdoK+hz1vZsT26WyK
         JX6mWwxVdBgz2onBCkktW4Po1pQ3uTLpyqiyEexnEMF3DSVYb35mqdjvaMaC2NMafN+G
         riWQ==
X-Forwarded-Encrypted: i=1; AJvYcCULB6jX34A4KRlcrJa/guGGSHrk68TweY9rPWncEA54GEpJ6c4dPHdwP7jG4o7SWNJPtI57MzyVrAqssHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwoX2Rec7gfqb/8tEBz6fJbEav7/nKay5fxaXh5En+fr9Wyk9y
	di7dR98WB7ZHQZQmpdTgy22ac1Vg+Ekt0QPW2FPgODSIxlzi1rdBAg7M1nmhUUD26QMMwDJ31DW
	0fBTHwG39Zi/cfzBhG/kXga7GHGsBNt4=
X-Gm-Gg: ASbGncuFYNhyFKCNTDCbYR9/nHIlW/ATq2CvitHAZexSmpRH9H19sbsgtxxJMbyy6ef
	UIU75PLk8zlohZLd4g+Mrs2QoutCCMclsMMcE4RdgaxX8n5Juz9FnY8+7gcrsQCMODDiiuwjDFg
	5rW74GBAe4g5t3MI8g82ugJ0NsUiTB2TjAFMdu3l+M6kFMh2FXec5ig+HbVl57XXgdfC6slEct6
	O6zRXEQ6E4nbCxfIrt/AltEEK6wzxykUult+Tfk+Cywx1aFPxnjGHxMFF1/CItFYLdq7xVIxTyT
	TZJdhWkbxoeHB8c0Z1KZT83wCWW88AkFCFAvkqum
X-Google-Smtp-Source: AGHT+IGWyTZduHZ2AUQOMuHAUDSKDxSYh2Boylo//kHY7uALzcMyPCHh3aobLMS0sfZ3SBLE+RqIGbSBBaWJY8VJe/k=
X-Received: by 2002:a05:6402:5108:b0:640:aa67:2933 with SMTP id
 4fb4d7f45d1cf-640aa672a40mr5173930a12.21.1762176592344; Mon, 03 Nov 2025
 05:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Nov 2025 14:29:40 +0100
X-Gm-Features: AWmQ_bmz-aFyM_2e0ocdnrdFR9IUaRm9-CuMDUtbkHwY8CVjQjk6nDFhXg5Zzks
Message-ID: <CAOQ4uxgr33rf1tzjqdJex_tzNYDqj45=qLzi3BkMUaezgbJqoQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] credentials guards: the easy cases
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 12:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> This converts all users of override_creds() to rely on credentials
> guards. Leave all those that do the prepare_creds() + modify creds +
> override_creds() dance alone for now. Some of them qualify for their own
> variant.

Nice!

What about with_ovl_creator_cred()/scoped_with_ovl_creator_cred()?
Is there any reason not to do it as well?

I can try to clear some time for this cleanup.

For this series, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (16):
>       cred: add {scoped_}with_creds() guards
>       aio: use credential guards
>       backing-file: use credential guards for reads
>       backing-file: use credential guards for writes
>       backing-file: use credential guards for splice read
>       backing-file: use credential guards for splice write
>       backing-file: use credential guards for mmap
>       binfmt_misc: use credential guards
>       erofs: use credential guards
>       nfs: use credential guards in nfs_local_call_read()
>       nfs: use credential guards in nfs_local_call_write()
>       nfs: use credential guards in nfs_idmap_get_key()
>       smb: use credential guards in cifs_get_spnego_key()
>       act: use credential guards in acct_write_process()
>       cgroup: use credential guards in cgroup_attach_permissions()
>       net/dns_resolver: use credential guards in dns_query()
>
>  fs/aio.c                     |   6 +-
>  fs/backing-file.c            | 147 ++++++++++++++++++++++---------------=
------
>  fs/binfmt_misc.c             |   7 +--
>  fs/erofs/fileio.c            |   6 +-
>  fs/nfs/localio.c             |  59 +++++++++--------
>  fs/nfs/nfs4idmap.c           |   7 +--
>  fs/smb/client/cifs_spnego.c  |   6 +-
>  include/linux/cred.h         |  12 ++--
>  kernel/acct.c                |   6 +-
>  kernel/cgroup/cgroup.c       |  10 ++-
>  net/dns_resolver/dns_query.c |   6 +-
>  11 files changed, 133 insertions(+), 139 deletions(-)
> ---
> base-commit: fea79c89ff947a69a55fed5ce86a70840e6d719c
> change-id: 20251103-work-creds-guards-simple-619ef2200d22
>
>

