Return-Path: <linux-kernel+bounces-846166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7971BC72DE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AD754EDDAE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469571A0BE0;
	Thu,  9 Oct 2025 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqlipTji"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CBA1F92E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975828; cv=none; b=jU/Qeb1bbe+gebS+vfoaXbVDP5be3xhL7esesvPmH3DkMEowrVLNkFxjoF+LI4JMNWmHYw8xRAzYdOW1pn5lhCWDBkk2WxjbNtGQQJvNBMTWsKAPvBuweRnkaIhJgKN8SXwmmfNTP+Sg55Is5FciYsWkpKnvt9kVeEght9IqxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975828; c=relaxed/simple;
	bh=UsphcAlBr+S2PNdLor0CBPJpMS317Bf37KWc9NojufY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcvW0rDqt/vsg0ohJwscxM10CKkCiA/UjOGb6ew82g3Gwya1rqTYkr4f6ivY1ED3TdxP0zdorT19P80HCuEmcxFKlAxIewdX7T+0YWYnLL/Wr7ndiP31j9BBmk2jOFX2icPcD7HW8UTHaanBfawnEdsjIwy0BSbFQRqU6C8GVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqlipTji; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso462681f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759975824; x=1760580624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8GzvFR6CGlZo09XYMPTCFUeNcSQI8ZtZkJiYSRu+iM=;
        b=UqlipTjiLUj101xDX5T9dctIDy9tM48KPUK2833DoHMj7JN4CaT2sWv+hAHltlOC99
         0i7tXNVcthX9GUDm3E8TLCh2bIY/W1Wsp/WkKOwLL4Dokz2qkSx9wAH2BUfASd5ZtiA4
         3SFe1Y/rgwpVHvxHMP76BQUDtIVPzOo6/6wj37vpprfzizUfoZ0m5DT+vncBq3Hb+K1j
         DglfMMyowLBZMW9rP7AS+2uQnH9wRQvPCwVbl6Sybrjdq5uDML826SqXgReeLSQcgJZ0
         Qc6s2sB1bVFjkQ9QRj46KyGSsK/eMW1DoyFp7frOWPXWKnAbNG3jjEwI5ib/O957HIi/
         VhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975824; x=1760580624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8GzvFR6CGlZo09XYMPTCFUeNcSQI8ZtZkJiYSRu+iM=;
        b=iUCvaGCgeaumLPSd1AfIPewOLmPyFBFshph4uhxTePJrmHBiSgK8R6NPKErOHGe0Kw
         Mk2wOEv6qbe/ffGfXpkd8N8KP+1zvwMCe0SDC4bJ+vD3Rh1m0J09nmAZwZNS2gRs2yDs
         xc3T3qKTh8/vG14QQ2xfJsqcigz8no3e7K1KGiGLP2/tNwU+wI8LDCiFpuJdYlcQqo6p
         Q4qICJC89FIOWEAOokoPn1PueVNS2khJPD4/tkWIsapQvyyctKs7dTijdTQ0qkEb66HS
         ZwevJ/sYEmBMUxLH8p10r906d7nxoHAfNeTY3jhE3fbIQ3HNa9AFhpHYYCSkGYLA/OT6
         FGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXULgOZj1VEMODJtj0HKH2Yp5+GsgFCONP1wqcuFVTpBODYa4+pvGpCGFwgJYjGozWsXfQNNhm/koUIrZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOZaSMEms0n4/CfbsFWy+YSeiCMz91+WWZ9DNmvVI9iXvVsx3
	0mdtt/RE+pBKrgmUfk4usNqwPOeRP2Dyi/A85ccfz713Y95bZ0yViAZz0KUvABitLE+lhG/Ml48
	mutqyBdYKqS7//WNbYnEKmxySUHTekL4=
X-Gm-Gg: ASbGncumezuA1jXXdc3zNQfMuhJyEaRNdxb2JHBS1SV6PQISx6WP478VcX+codibajI
	IjgOyw4lcKZc4xiVDR+oYsnFQaGrUNwUhtBhRuB+72luixxIY6mUkiXxfLmCY3YEybIkiUBMAq1
	X//LPuO/2YluTHy2u6l2OPCG04PVH4z0BfHYq8yutqHrzuVVSsWmIOA5m+FzaIXPzEWdPJFGm6P
	5WD9qwKHGMp+V620XR+c44gVp/QLo8EVP+x/lKVdoMOFZG0xjSzhCllyKr8rbwx
X-Google-Smtp-Source: AGHT+IHUyjygXotyw6ah99ayuf0MSKvceh9le+qsaRqcmfDUOI3HEIlsJDYmsBHuydizQMzuabarjvIlam8AoeAXSgw=
X-Received: by 2002:a05:6000:18a6:b0:40f:5eb7:f234 with SMTP id
 ffacd0b85a97d-4266e7cea15mr3454730f8f.5.1759975824081; Wed, 08 Oct 2025
 19:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759875560.git.fthain@linux-m68k.org> <807cfee43bbcb34cdc6452b083ccdc754344d624.1759875560.git.fthain@linux-m68k.org>
In-Reply-To: <807cfee43bbcb34cdc6452b083ccdc754344d624.1759875560.git.fthain@linux-m68k.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Oct 2025 19:10:13 -0700
X-Gm-Features: AS18NWDCubbh5qDnKeyx-bfbRiwy5wk-S7mU0B8RrK8RiyXWwNZsCaohYxj9EfE
Message-ID: <CAADnVQLOQq5m3yN4hqqrx4n1hagY73rV03d7g5Wm9OwVwR_0fA@mail.gmail.com>
Subject: Re: [RFC v3 2/5] bpf: Explicitly align bpf_res_spin_lock
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 4:50=E2=80=AFPM Finn Thain <fthain@linux-m68k.org> w=
rote:
>
> Align bpf_res_spin_lock to avoid a BUILD_BUG_ON() when the alignment
> changes, as it will do on m68k when, in a subsequent patch, the minimum
> alignment of the atomic_t member of struct rqspinlock gets increased.
> Drop the BUILD_BUG_ON() as it is now redundant.
>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/asm-generic/rqspinlock.h | 2 +-
>  kernel/bpf/rqspinlock.c          | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspi=
nlock.h
> index 6d4244d643df..eac2dcd31b83 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -28,7 +28,7 @@ struct rqspinlock {
>   */
>  struct bpf_res_spin_lock {
>         u32 val;
> -};
> +} __aligned(__alignof__(struct rqspinlock));

I don't follow.
In the next patch you do:

typedef struct {
- int counter;
+ int __aligned(sizeof(int)) counter;
} atomic_t;

so it was 4 and still 4 ?
Are you saying 'int' on m68k is not 4 byte aligned by default,
so you have to force 4 byte align?

>  struct qspinlock;
>  #ifdef CONFIG_QUEUED_SPINLOCKS
> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 338305c8852c..a88a0e9749d7 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -671,7 +671,6 @@ __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin=
_lock *lock)
>         int ret;
>
>         BUILD_BUG_ON(sizeof(rqspinlock_t) !=3D sizeof(struct bpf_res_spin=
_lock));
> -       BUILD_BUG_ON(__alignof__(rqspinlock_t) !=3D __alignof__(struct bp=
f_res_spin_lock));

Why delete it? Didn't you make them equal in the above hunk?

