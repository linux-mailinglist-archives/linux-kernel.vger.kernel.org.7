Return-Path: <linux-kernel+bounces-897091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C156C51FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2AD426F36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168A30DD17;
	Wed, 12 Nov 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqre9r0n"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CDF2F25F2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946425; cv=none; b=oRhUPBoRATcqgjfYtJHkzR1MP/CYX0uPlMN1KDJ24JUJX2kk5ICSDPaW9Ky1SEKvYRLnTEVyPxE/6okFXKQNdHhMLhhEJD5bvoV26GJ8aAqe833I6rGwqv9A1G6ka9l7oVS7VtYKGjKz0nfObNPbIJJohQ7sdDD9w7GL24h1xiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946425; c=relaxed/simple;
	bh=Knk4ujiX8WU3ociFntVm9Iw7JEzNqyZTnRUVewgSDYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjFmD1xnrGfFXnzvyhUrcPkH2GrhlNRx5VGyLAQrxRqtImdHfn6vVSDyw36ePqrfcaWfHSMe2EKJeNf1vZoPBeDcq0TnV5ELpRjXhifKYTtGKlCijr2dvhzcXbV4zLrV/bK7xlNf1cqOlvS8LmJApEOMU0kFle9PlA8DbLxGCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqre9r0n; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b72134a5125so112731066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946422; x=1763551222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN5e9QaZYINqmL7C9pPTFE+y1JKslvRnzLuWM0BGZbs=;
        b=Wqre9r0nbPJ+Mor7ePhdXLd2pq+ceduhqCftS3bn2fVMIGVTVRF0QT76IFD7SlcCkv
         A8E9XBmVoWk5qXlCCyk489w9yMdDdGUZh7JxN5l8Dzsjgyaad1VSZmELBE/DmvwTtSne
         8BeeFrnTfb2PAdJ/WT71446uRw8I8pmgrpczQj34uKKnS/AKYJXdGPgcpgRKDP8bFABV
         MHQiXu6uy+jbQ+1IH5Vp4kgyjDRTI/3T/t0L1AW2OYBT29dIJlSJgTJrTFaXwR9rym8C
         J+lrXSTxcPddFlv4MomLqIr0SuumIc4g69UFO1fc7pKuSYU+CaXGYPPRvhOrx736r9HC
         HPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946422; x=1763551222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zN5e9QaZYINqmL7C9pPTFE+y1JKslvRnzLuWM0BGZbs=;
        b=R6v7jZytOdp+3UDRBqRtWnOwfdsRALaTsDVymNPDOCHKeq3gMn/ktevHCaCPCQ5cbG
         qwGbjrXDaZdW61pHaYc8KqJgktmiNtT2E0UQcfNKlDwdtil4k+Nf+xeDdkU7HWm8hxEM
         Wl7/gHyY94MGze4XA3WG8vJiDse5nxm2pjwAYTDZfg5IfOxoHQGfKyvzXKGmyeTmL2JU
         ptzZyCkIQuXG/17U9/vg8ZFPu4zbds7DOo9VV0mHARzsfjVJZMQJ/6tpC4N+b1f494GD
         4ovdknfRKoQbYlTEP1LLEylSqIv0JTGlCtoOHSPmDU9VLsPWogU35Df19KK9+uN3m6im
         zFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK0OLmR8amPypCjaoqmkGMFDQbcnAMnNm8SyAXs4U+bW0hYpZNto9oCCoh8JJWnvxYuMqUS1aQzGJsoS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMBQ1zyHWZwT5L3ZKgH8uSrUpzxtEFz/rMMlirEbuJ9Nl8A9qL
	5VTkHQwwTUDO4COvjjoPqLN6PkbmH+5EnIHU6lE0l8sAUU0C1EpeTBZPuUYoGc9YTUY2IdkK3R0
	frKbNXmBhH+B3CtZCF8YQ1LCHOAf0otFZEw==
X-Gm-Gg: ASbGncucOQ6aSkx5Irs1tFzFuH+D77Yos6n8kRTNEAyvYx5utGohy1Y+IPPOc3T6ahp
	ZrJyPnmQ8jqAfPZQHiTa9iO+FuZVrHC18SNbyaCZ3+DY3eP9Up/ZdqNvVJnGzarTvhykLqFLVGf
	QNypaRTSRdRL5p/bxkY3bIxMV1T9Y7N/l4d/lA6insbpJvIBDPUgNkQVn9S8MqkOjT8dlmrr2x5
	a96sYboLGw5C5XNxrH5+AxGzzdx9GObiF2sEjVx7Ng9KkW5nGKi9L3L64ZP776mb6w+gzhPGMmu
	eUpqgiVg4YUO/r0=
X-Google-Smtp-Source: AGHT+IGNDAdeHAQwBdFpSJaoXJQGx7YCs8ZG107WfxsSGbmCdnZGEiPXex/Kcl5wI14bSDYMkO03S1ZtjbAfCbwDU28=
X-Received: by 2002:a17:906:dc89:b0:b72:62ca:d30c with SMTP id
 a640c23a62f3a-b7331ae8aabmr220157266b.59.1762946421421; Wed, 12 Nov 2025
 03:20:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105150630.756606-1-mjguzik@gmail.com>
In-Reply-To: <20251105150630.756606-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 12 Nov 2025 12:20:09 +0100
X-Gm-Features: AWmQ_bl9yil3WTlUosVOtwjPuwRCiZJUwpRvvlkwPbgkU3BJnU4rSe9g5zyKIgY
Message-ID: <CAGudoHFNDC_5=T3XKLzNpsMkZYaf_KbjHrL36rc0YWDWaJMS_w@mail.gmail.com>
Subject: Re: [PATCH] fs: touch up predicts in path lookup
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

any opinions on this one

On Wed, Nov 5, 2025 at 4:06=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> Rationale:
> - ND_ROOT_PRESET is only set in a condition already marked unlikely
> - LOOKUP_IS_SCOPED already has unlikely on it, but inconsistently
>   applied
> - set_root() only fails if there is a bug
> - most names are not empty (see !*s)
> - most of the time path_init() does not encounter LOOKUP_CACHED without
>   LOOKUP_RCU
> - LOOKUP_IN_ROOT is a rarely seen flag
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/namei.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 39c4d52f5b54..a9f9d0453425 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -951,8 +951,8 @@ static int complete_walk(struct nameidata *nd)
>                  * We don't want to zero nd->root for scoped-lookups or
>                  * externally-managed nd->root.
>                  */
> -               if (!(nd->state & ND_ROOT_PRESET))
> -                       if (!(nd->flags & LOOKUP_IS_SCOPED))
> +               if (likely(!(nd->state & ND_ROOT_PRESET)))
> +                       if (likely(!(nd->flags & LOOKUP_IS_SCOPED)))
>                                 nd->root.mnt =3D NULL;
>                 nd->flags &=3D ~LOOKUP_CACHED;
>                 if (!try_to_unlazy(nd))
> @@ -1034,7 +1034,7 @@ static int nd_jump_root(struct nameidata *nd)
>         }
>         if (!nd->root.mnt) {
>                 int error =3D set_root(nd);
> -               if (error)
> +               if (unlikely(error))
>                         return error;
>         }
>         if (nd->flags & LOOKUP_RCU) {
> @@ -2101,7 +2101,7 @@ static const char *handle_dots(struct nameidata *nd=
, int type)
>
>                 if (!nd->root.mnt) {
>                         error =3D ERR_PTR(set_root(nd));
> -                       if (error)
> +                       if (unlikely(error))
>                                 return error;
>                 }
>                 if (nd->flags & LOOKUP_RCU)
> @@ -2543,10 +2543,10 @@ static const char *path_init(struct nameidata *nd=
, unsigned flags)
>         const char *s =3D nd->pathname;
>
>         /* LOOKUP_CACHED requires RCU, ask caller to retry */
> -       if ((flags & (LOOKUP_RCU | LOOKUP_CACHED)) =3D=3D LOOKUP_CACHED)
> +       if (unlikely((flags & (LOOKUP_RCU | LOOKUP_CACHED)) =3D=3D LOOKUP=
_CACHED))
>                 return ERR_PTR(-EAGAIN);
>
> -       if (!*s)
> +       if (unlikely(!*s))
>                 flags &=3D ~LOOKUP_RCU;
>         if (flags & LOOKUP_RCU)
>                 rcu_read_lock();
> @@ -2560,7 +2560,7 @@ static const char *path_init(struct nameidata *nd, =
unsigned flags)
>         nd->r_seq =3D __read_seqcount_begin(&rename_lock.seqcount);
>         smp_rmb();
>
> -       if (nd->state & ND_ROOT_PRESET) {
> +       if (unlikely(nd->state & ND_ROOT_PRESET)) {
>                 struct dentry *root =3D nd->root.dentry;
>                 struct inode *inode =3D root->d_inode;
>                 if (*s && unlikely(!d_can_lookup(root)))
> @@ -2579,7 +2579,7 @@ static const char *path_init(struct nameidata *nd, =
unsigned flags)
>         nd->root.mnt =3D NULL;
>
>         /* Absolute pathname -- fetch the root (LOOKUP_IN_ROOT uses nd->d=
fd). */
> -       if (*s =3D=3D '/' && !(flags & LOOKUP_IN_ROOT)) {
> +       if (*s =3D=3D '/' && likely(!(flags & LOOKUP_IN_ROOT))) {
>                 error =3D nd_jump_root(nd);
>                 if (unlikely(error))
>                         return ERR_PTR(error);
> @@ -2632,7 +2632,7 @@ static const char *path_init(struct nameidata *nd, =
unsigned flags)
>         }
>
>         /* For scoped-lookups we need to set the root to the dirfd as wel=
l. */
> -       if (flags & LOOKUP_IS_SCOPED) {
> +       if (unlikely(flags & LOOKUP_IS_SCOPED)) {
>                 nd->root =3D nd->path;
>                 if (flags & LOOKUP_RCU) {
>                         nd->root_seq =3D nd->seq;
> --
> 2.48.1
>

