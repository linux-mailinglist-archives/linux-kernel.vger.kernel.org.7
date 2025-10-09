Return-Path: <linux-kernel+bounces-847084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65413BC9D37
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192553E42A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6540E215789;
	Thu,  9 Oct 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+HXYPVN"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7C1DF26E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024324; cv=none; b=rBC6uGsh6ukUTVjLcw/mX1A/kF2twRJGik1BIFjYo1V8O94UFUDqfszqb3ll+OzyYIaktxd5lNto15WnGIGfaO1UpbePoRy4qHjXylZxFX55I/o7qBX1UCXu50XnzE/d2Z4MeIgBOvETgLJGRIViSMN+yaeYViRQRzPTIsdRGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024324; c=relaxed/simple;
	bh=z7Ea42APZZ2MsKzMNHUw5tv/fNDz5o3iaIrDzYK/1yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCbbOmrgeSODmLzUG4x5Hc9VXsU8FCmOd0OrYCx1tvOud5X/fh+oWmBDZYL0D+HufHpuoiKZxOpURdk7eBIqIGrE0P78BoLH2mZqdacmprTTnxbQuUia6fk5FS15Awd1glddLoSOap4Ah/YV1PS7z/BD2xdSXG5StS8Rfn6stBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+HXYPVN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so10906715e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760024321; x=1760629121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQkxYFoW3fhngqbDfc7FB4prxB/MP3/9y4tccx7Eb9g=;
        b=O+HXYPVN9SvN2fTQVzIPaulOZ9CQoHxoUCyr0db+DRN4+4x4Md18h3/qOd01aYQKxw
         vF1oZN0D+OAwRCvQCveGmHKtSgUQ5leHSsf1MofbWE1hgs0xjsFKaZ4LLs/+jE4Vzo0B
         FWuddK8KVxRv+QpOFWMu5UqAIObB8VN4Qu/ES9sYPm8MBw0sbKL8kyjdKgIZHMmmxcmM
         R2rdd5wEnTS0DqrDKAqVcLnrnxWwdvx1FrXFytXSU/d4ZLrbcEag0Ops5jrQCPynKn1L
         z4lCH2kNHAT4BK8kPhSuL15Bh53t5szqG1H4OftIXsFIwjEf1Fedvx1Gokv3Mo4AhYu1
         qEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760024321; x=1760629121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQkxYFoW3fhngqbDfc7FB4prxB/MP3/9y4tccx7Eb9g=;
        b=uPFJHjqJ8+mGG2MAcTUdBmEyjZyCICqKxOchqRG4VVwjVHWwifQvImU90qKJQ58W12
         53jZsryBmsL80Z8XVGDogv1x5cqMEFQVONnTD9+bkpXqly0eiXegTBxcZV561kUExfK+
         Y0nNDte4cFElxb3UQHQ8stmPbnkLoi6al6YIZsyVFURPh2I275LNme4KroLAF8eUqpfG
         r3po6b7+mLlVBq43WlskBkzDJFDPP6ud5f/v1melFHtQHjPYTr7Mw0Ye0V7jqn3Evnku
         NHj06p0YrLQoZEBQyoIV564w6TQ/M/fEfK1/k0AyyFcOeZcNIjXkY0AV9RQDGQlS62J+
         XF9g==
X-Forwarded-Encrypted: i=1; AJvYcCWBz7tZYURiHXTOmWy33hVG625A4gvxgm2zTvQRJIwQV5bhA/jCg3TVdNfUNHaPFJ253dsNhOcw0jYYSms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3IOHSOTCEdhSTY2yZ3I3rep/subXCl9xCfU2HnjntH5EDQiC
	hnYKFUbuefZUdPsn317KCEF36jGECpU/BNrguJwltYzL7jxOGPdFzfvsVbM5eIyk6fvUmerbShm
	lptfQ4DGkDxWZBBHzr8f0Dz//Dp85apc=
X-Gm-Gg: ASbGncu6UbrakgvpEvNJjv1KjHltn1CkMFVPKMAt/AwuGTs6l3rE5EgLMGJAEIkaG4f
	TN8v3FavOpCgoOh5hyIDKgMEaD8aG0/qSuXE5Rg8DgQRF9/btZ89tbLm86AnV4/LL6cgzdXglIn
	RAv/DuXs3bmVbVDQWfmrvgDrFr63pccgt9W75SzkxM0rThab53d7JxlFcUXsnL6fY8H8Bj6prN2
	Vx3AZIZ8exAQxOgjk3nDT01KoR3sNZScuT6lp4Ceel8ohzfIHDLhtm1BzSc8nN6
X-Google-Smtp-Source: AGHT+IGgrqYYOGBGtMKaRbrc/kVHY5g2aEmz2TaX4Ez0CcvauPu8X0DUtsfzwWEzS+JPm41ng44Mvzj/hW7vj8aqNdg=
X-Received: by 2002:a05:600c:608d:b0:46e:6d5f:f59 with SMTP id
 5b1f17b1804b1-46fa9a8b2aemr50381095e9.4.1760024321223; Thu, 09 Oct 2025
 08:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009062330.26436-1-chensong_2000@189.cn>
In-Reply-To: <20251009062330.26436-1-chensong_2000@189.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 08:38:28 -0700
X-Gm-Features: AS18NWDLz_Sock_v4Ibb74lme2e9ww0rt5f8tkGNzURm2GEz_dE_DJlg716IyM0
Message-ID: <CAADnVQL=FSax6b1qOG5G=9Lz-FScQWHAS=YZ+=b86Skvyeqing@mail.gmail.com>
Subject: Re: [PATCH] kernel/bpf/syscall: use IS_FD_HASH in bpf_map_update_value
To: chensong_2000@189.cn
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:23=E2=80=AFPM <chensong_2000@189.cn> wrote:
>
> From: Song Chen <chensong_2000@189.cn>
>
> If IS_FD_HASH is defined on the top of the file, then use it to replace
> "map->map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS".
>
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  kernel/bpf/syscall.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0fbfa8532c39..2c194a73aeda 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -154,8 +154,7 @@ static void maybe_wait_bpf_programs(struct bpf_map *m=
ap)
>          * time can be very long and userspace may think it will hang for=
ever,
>          * so don't handle sleepable BPF programs now.
>          */
> -       if (map->map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MAPS)
> +       if (IS_FD_HASH(map) || map->map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF=
_MAPS)
>                 synchronize_rcu();
>  }
>
> @@ -274,7 +273,7 @@ static int bpf_map_update_value(struct bpf_map *map, =
struct file *map_file,
>         } else if (IS_FD_ARRAY(map)) {
>                 err =3D bpf_fd_array_map_update_elem(map, map_file, key, =
value,
>                                                    flags);
> -       } else if (map->map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS) {
> +       } else if (/(map)) {

Let's not. It only obfuscates the code in this case.

pw-bot: cr

