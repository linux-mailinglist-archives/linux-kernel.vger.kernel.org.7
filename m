Return-Path: <linux-kernel+bounces-830044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72997B988E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3495717527D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810DB27E7EC;
	Wed, 24 Sep 2025 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8jMeUnc"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6927B34C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699160; cv=none; b=F3cmy3RTofUJ1LBJxr2wIY/iUnAB6ZfMKQqYecFRkHFjKI6Jyx/gW7sH6eZ0vFoH+Po+hk88yNm70FOgl9596y+hjNZ5yoO+TppGWoEpARp1QfcCPAOFlZoxD0NBiG3K9kyZPNvsEI8WqCNEZEz4mZMJ2fo57qyI+3dTiWdETVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699160; c=relaxed/simple;
	bh=9KA6NgKdGXvd8i8CCEUdZAHb1TbPEoknAwIsbb9/tXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVD3WLevI59gadh8roFm5EhRhktzuycyhYAp2XuEi3akf7hd7u78VLC8Aa9rR28Fc+6c4XXk1CJjrrgxJSfDN9fgnf3k4+9dE0Euc8oBwLtuRTLWRFtOzri2FnNjYSCGtlnE7sljIvoSxB5G0rMLpIyQBic5enJsu5WgUm0QK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8jMeUnc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so4454196f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758699158; x=1759303958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLnpvIBACLN7NS7ibWQG6o0GPmfDuqaqxgOUby46Dms=;
        b=A8jMeUncWhfk5vozxvorrZSNs+HI9KBTdc6sByXNAZkSsaOgTZEc09w1gZ+Ttqyv8O
         v6g6xIrUOCiFO1bmiDuoS9/baMVca6EKKoL6VdDnFMV5GKW2AKwPQnrnC5ankGs1EpOO
         C4d4TiRpjsTYSclQmfqhBDJcu1B0Wa7rHaqt64vcc1DsA7SKdWbUGj2hOXtWGckzeVr3
         UQIfUnD0+uuXT2fW5MkouSwUxhpou3ejG/fnslMp4HxQZcFY8k+S0xDI/4Y6KxwxfZAq
         cRL8EY2MsHfOdoJTTskGuTcMhKn20+JTljJCHcj/SmUb6jlL5xGtbS4FsnzmxgJgX6Wk
         um5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699158; x=1759303958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLnpvIBACLN7NS7ibWQG6o0GPmfDuqaqxgOUby46Dms=;
        b=Hq2ObZpLqyHxgUJNC7R4aM8IQC0YFSPq6GVFZhcFrz3I889pbw+VeErpmDCQVYrSsY
         hzAV/EYeqPwXJChRX4lr/CcPFo3U4wMzpIbwQOInjWTwScIfCRwZNw0v8I4fk/o99Df8
         f+ZtEmLJ6wwambGjHskbj9pGSueQDBdv6rSgiJeru4nX5xawX4nY58OQGKSRju0y6EGd
         nlIrI0hmGFmQHgAu2m9JuwRgQhxopUrtyuBITVoKgDjC73X2Mfc0pFdZwY7COsu/pUPN
         qB3AR5DhfHHK3zAEOASN9fnxSesTcWi1blix1peSLzESMf0YWGE+NGj9PAvKH08lgfT8
         yOfg==
X-Forwarded-Encrypted: i=1; AJvYcCV+irkyAvGYmxsDgRYWTS2Kc0KrnQqe3mJhhT4mDo8wpOQZrW0Z31ePBK2PG5fcmv1e47WexR5nd+XRU+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6G9DGMKqjpFobIeBbgcUUtRlRhgaHOwyfiWr9SmlpUys7Ph2
	HBazbYXmdGIDP1q4K0nh3/whxYjkM7bLz4g+nvaPFrNDSUaG3RrCvmwhZq4TYYEkjcRgv/oRC5a
	UkvgPOZstIw7iUxrEt42gBJxI83QBTSY=
X-Gm-Gg: ASbGnctvSOVLddGxF6HAfAXk0SMAXzDVny9oZXmtf5Sk5wbwCXsDoHVXpW96eyIm+fF
	CzGIvZQ7MWQwM+d5jp1kxOmIUaPUQFoL0qpNI8MAL/tQUyBoX99eezRXKqAgpx0BIpZrpNY4jIh
	W/rL/zirkqYBPwGi4337zFfQn2Y9lk5TdzxVyzzDu2Byexso4VAiE2Rzkpa3OXXSwR6Da9rekWz
	t/cUlIY
X-Google-Smtp-Source: AGHT+IHDKV06Xr+H8gztN5UsclGTiBRvo+Ta5hEoujKupv0OJHICrsA8kaK5pR/i+RMpNDz9hcgE0XqJObdb9HnTqM0=
X-Received: by 2002:a05:6000:1a8f:b0:3eb:6c82:bb27 with SMTP id
 ffacd0b85a97d-405cc5257a9mr3992126f8f.61.1758699157420; Wed, 24 Sep 2025
 00:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com> <20250923174738.1713751-1-listout@listout.xyz>
In-Reply-To: <20250923174738.1713751-1-listout@listout.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Sep 2025 09:32:25 +0200
X-Gm-Features: AS18NWCY3D9SnbPaiQWZXaLzOvdo5YQExnnyVafMEnDCQIFDReWFNzn2kdHtpvA
Message-ID: <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: fix NULL pointer dereference in print_reg_state()
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 1:43=E2=80=AFAM Brahmajit Das <listout@listout.xyz>=
 wrote:
>
> Syzkaller reported a general protection fault due to a NULL pointer
> dereference in print_reg_state() when accessing reg->map_ptr without
> checking if it is NULL.
>
> The existing code assumes reg->map_ptr is always valid before
> dereferencing reg->map_ptr->name, reg->map_ptr->key_size, and
> reg->map_ptr->value_size.
>
> Fix this by adding explicit NULL checks before accessing reg->map_ptr
> and its members. This prevents crashes when reg->map_ptr is NULL,
> improving the robustness of the BPF verifier's verbose logging.
>
> Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  kernel/bpf/log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index f50533169cc3..5ffb8d778b92 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -704,7 +704,7 @@ static void print_reg_state(struct bpf_verifier_env *=
env,
>                 verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
>         if (type_is_non_owning_ref(reg->type))
>                 verbose_a("%s", "non_own_ref");
> -       if (type_is_map_ptr(t)) {
> +       if (type_is_map_ptr(t) && reg->map_ptr) {

You ignored earlier feedback.
Fix the root cause, not the symptom.

pw-bot: cr

