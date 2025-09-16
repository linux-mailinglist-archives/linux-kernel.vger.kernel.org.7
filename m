Return-Path: <linux-kernel+bounces-819333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0288B59ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FB1461FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF222FFF97;
	Tue, 16 Sep 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etd04EL9"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3727A124
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042471; cv=none; b=N7NLCyRLeFJ1ATG7n7J3C8nR8tu9fkCg04BV7WiqKs3ForVqXRKunClWlIjwGeMZGd9S4n8Va6e4JU94Y3eG9jgTw1f365qFi/9i6YpKgg8RDWMAGL6Wf839ssptuMIiGCiiltf0vfNHykSwZtfUQQRMv3j0OrhCny5P/ZvRVmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042471; c=relaxed/simple;
	bh=RHgS+ND+5R6dc2Cm7AnwIcEeZk7Qr58oJgQ9va4pwh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onD5FcZdv4tD/hTCa4k7Y4I/5V8w2BBuYsLQrdtVRiewhNXILC8ePNv8gCUrRcD3P+P603na5cz8d/3GByJ44AH9SI3fXSGTviTB2D7ZexPu90CvOPa9xPioDh3ZelUcvXC7sSoH+vDbgUsmQpnLcMrT59QVXI9LXEP2i9cMphw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etd04EL9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so18881775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758042467; x=1758647267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6+3XcAL3z9giV1LrkT6nAX6YMeV+sppNk95XqTT+Fs=;
        b=etd04EL9S/8PUPugOtRze7wCOuhSyFrxqZ8qBEfBSKjDGC+Yxug+awDd7VK1sVlDDu
         8TVaHbkdSPrMNnGNdco/pHzgCSl2sK1jSNVmbz/LiUdQQKivzt+cNDjEfmXgZ+geaYMb
         29AqyEcuIb2Jj3SIGaoMegV7BOyL9w06GrQtTbh52EBf7Q5VSHKu54USCoQ6qSEb0mI/
         XU4A9JoHd4rdZQvgin3qoKXVbBrMOgg/tCEM4XQITbVh/ckTsIR9+r0ihBfJWb//I3kC
         ZIeKP70a60fdy8qjJFIKtwnar60ZzR8xlBg2BKhM7aApRDkeCL1qBDpV0v7+kpC0t0kP
         sMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042467; x=1758647267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6+3XcAL3z9giV1LrkT6nAX6YMeV+sppNk95XqTT+Fs=;
        b=lA/cMEp70eITr+0IgmYAf9pggeWAaMPCta5iCltH05V40JNlSmU2FQgsL4phSAyvoY
         goBMDZNdza0+rkEID5/TmZxP6hkUaGqpvdhbywjcotYXvffTVEQo6SgqJ57HT7u6Qqe/
         pDS5fvPaLSUPEY/OCUEszj7oPlkxcp7hb2yh4drXwsmC+fePFA2RNLz4K2r+XgG/Hp2g
         uUS3JZj8wOrmgfdk/WT5m/k9HgbNuCHLzyX871FPr/h3qc5UjOJVeFOiyhLQ+NErc2ym
         Ypi+IEQrvBQ5Y5L32rJXq6tb6Zqd0Hfh5Y9FZNc6tjKjpSDvaUp7F1ihr/IJjEX/P2oG
         H/gg==
X-Forwarded-Encrypted: i=1; AJvYcCW9RWhJVl+ERrbsnVz6PPnf4iSXcylIaYkjl9rHSoN7AnY9/pFOL5HkmzutjUNhDY/qHvZM8UldNL+qZu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaeaREQ+N/xJclOWm7zHHwC7MDtlMHwpbTs/PVc3oFRl4TEGM
	2a5vm6rRKu+HUOuH8XGrS7487wpenJdTCzuXgkNP+ZxKe7G/G0vNzMVp/6HWno5lb/yGdzj/7JK
	FPAIaqMyeVbejcuQAeGGGksKT1WVKFD0=
X-Gm-Gg: ASbGncsDfZwEkiKjnsIHmRX7cpNhQc2Ovs6vPcP833i0u1WscwTDK6MSZ6iK4Tig1uF
	xulLcEz8mG8hpL+E5tyMhu0zvfyvLMY6SgWGVcNIDzvw42fE+wFKNKTPlHMY0ap13vI3bGTlMXx
	av4f9LFcSYdg8w5k1EWI40iOgsUmM6y6dcrjd/wbeUPXoFVjWe5ivzD6EEYerSGmJJMnRgaEPm/
	UCZ4tKhvPB7JLK0eHKBZb0ozE+5veTb
X-Google-Smtp-Source: AGHT+IFpfePcRjrUCROTA/qMZeDM0oYl4QyH35KqktcZMpXonmsBnXa03WAzUsM0QzWbDIZsMpOXkCjcr6HuKHM/LZU=
X-Received: by 2002:a7b:c4cc:0:b0:459:db71:74d7 with SMTP id
 5b1f17b1804b1-45f211fecdamr106914835e9.27.1758042466979; Tue, 16 Sep 2025
 10:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916054111.1151487-1-chen.dylane@linux.dev> <20250916054111.1151487-2-chen.dylane@linux.dev>
In-Reply-To: <20250916054111.1151487-2-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 10:07:33 -0700
X-Gm-Features: AS18NWCH37t630t6KW5uArvsRduTtKgiYN9kYTvI-gC5PPhRrI8hLbk4vZT8Wnc
Message-ID: <CAADnVQKfH6QnLHfsGO_sL10LhTjL+YUWDist2+xGM_PiPjM9Wg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpftool: Fix UAF in get_delegate_value
To: Tao Chen <chen.dylane@linux.dev>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:42=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> The return value ret pointer is pointing opts_copy, but opts_copy
> gets freed in get_delegate_value before return, fix this by strdup
> a new buffer.
>
> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/bpf/bpftool/token.c | 47 ++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> index 82b829e44c8..c47256d8038 100644
> --- a/tools/bpf/bpftool/token.c
> +++ b/tools/bpf/bpftool/token.c
> @@ -28,6 +28,12 @@ static bool has_delegate_options(const char *mnt_ops)
>                strstr(mnt_ops, "delegate_attachs");
>  }
>
> +static void free_delegate_value(char *value)
> +{
> +       if (value)
> +               free(value);
> +}
> +
>  static char *get_delegate_value(const char *opts, const char *key)
>  {
>         char *token, *rest, *ret =3D NULL;
> @@ -40,7 +46,7 @@ static char *get_delegate_value(const char *opts, const=
 char *key)
>                         token =3D strtok_r(NULL, ",", &rest)) {
>                 if (strncmp(token, key, strlen(key)) =3D=3D 0 &&
>                     token[strlen(key)] =3D=3D '=3D') {
> -                       ret =3D token + strlen(key) + 1;
> +                       ret =3D strdup(token + strlen(key) + 1);

Instead of adding more strdup-s
strdup(mntent->mnt_opts) once per cmd/map/prog and
remove another strdrup/free in print_items_per_line().

pw-bot: cr

