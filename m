Return-Path: <linux-kernel+bounces-830922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E36B9AEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532452A6225
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13EE31355C;
	Wed, 24 Sep 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtUBN6jZ"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E51FB1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732576; cv=none; b=XfaufSY/E50jTRy5ffbVQBLq5gHAMgL/sOqS37k3u2V0kfYol+tOg/JfXLvsrA9qx0Vg+ZeEaxEfiJrh9c3ROH30srUOLR6p6ea2HjfXoaEJVWIp9KP5VA9Gv+FEEJfx9NDXfQpFN5zZzs1onWIAwgW2TCv0Idn9fds3CFF2reA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732576; c=relaxed/simple;
	bh=i631qAijwETG12yrH4H3BbU91qlt5cJOWY9XMqxvPAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qbvt8SxuZcH6/fq0Q8Jr2DtSHKAqqc9uwpx0NI7wKLir/irpTf1TqD3fSPAxU6YOwEU6104XzQPCj1anUvnLDny4vbcWy0E6SXCViryff5nlh0kWfu3rACQFcMV0EMoQ4WfmeVgANw85KRKZLNABS/uXF8XNy4llvdR3Id/zaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtUBN6jZ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4bb7209ec97so613051cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758732574; x=1759337374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JvFELxPCxwY74AcuaB/2r4NripPELBrPEQdEr+31uM=;
        b=XtUBN6jZfbf5FeCOa72rCsBPZSJaylqONMQNErCwCclqllIWubI66NJQ5wKn+F8H6j
         i3W//Bpkt3rRZAe1+XcA850XfLQR59UwRiyUPAVyATCvAES6HYUluuyugFr0DSMMoZrW
         UUIKbXIU0g5bnlJ6dxrECHyxHGOMu5Xe2bs6ZiO1Iy9BRZ4WItauhTODS7laMkjh8+Td
         1ZWBbXAYVBWZep8AxT7RpafpXmNfWGUEGUH+2pcT9jHWhozh2ue0BU92KBl/jPWfav/7
         xdxo7+Z6ciriEHdWAQ30rZMnVgInxc1U2antwdq2WG4CQ6RyaJb9Ce12MLTE6jPJGk1J
         tLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758732574; x=1759337374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JvFELxPCxwY74AcuaB/2r4NripPELBrPEQdEr+31uM=;
        b=u1IkJOHp3S6tQPsXcSbs7WX8DsIPpbhKW0mScGJYBiECW0cJ4NzbbiZ23uBXShuwSg
         JPjhprlmISc3OUCSA8Vz6uDAvh/CqvBffNrXAjj+bR8f4MGOh/NYTpEDhrdla3MLALO2
         brG/t/ReSjRPC72UBGSKKRlgKZYt6feFWSBcSsHceiLX4CC+GNE2ZT1Cw/W7KQhxQXo5
         EbgrGZq3xpd0vS7zHwt8bjKhokfMVoYVRqxqyZ5Gn40mSkxDvXZ7x13xCauMyLe+/Z7c
         RqasyCE2MBVI2LfgwcKrsBJxfpRLE02X93/io3ZI+MhKNMSGYLF7Jxvt/LuFFXsEggAd
         tcYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLCqNPqd2lmkcRmR6zMH6IPL7HM2QNsZ+dHoFoaw45Kc3QcWHDhZ3ymJRmaWPJMLVs1YodSn3w7oO7UxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/8bbCVAdhDOA3b6RQ7jnd8Zyk5A70STYzBEjFbGVKcJWoSg/
	NLI0Bg+VU/GqQRs8YngrybTyq7Qm/hXvOW9/jhGEr220dTrZlH8XS5Wpv4LUKAv4q98GJswwQIV
	QBAz/NvYYJEY16LrBo0UVfAAWfgA+kynHFCtMQXVy
X-Gm-Gg: ASbGncuko9jBVvX1iDElnHT46FKe7jWMjW6D39jPth9pKFJmDUZ4PnDnxlKycKxeoRD
	WJy/WLn+VBFt+hqImMq7ip7tuNSeCmy3pzyN2fA06B7qrOZndgUNI5Z4Xqu2/EnD92Z28Qkq7co
	icdZCBp0f9qmGc6/wkmtdQKNUwlryqKpM7VGc4zm14mYjmM6ERDu5TCXjs351sibw477VDOYH5w
	JZfYh+UJRZa8IPBtJobfF0m1G0xsvW4CTByz/DU+w==
X-Google-Smtp-Source: AGHT+IGMhOROnHAHwCWHqP41TFW4SwH3fT102kMQ13CWu7KInQWNKqQYfl3q0oAPFRaFbRuo/IaOLBDDK9OLZu1oDik=
X-Received: by 2002:ac8:5996:0:b0:4b6:2d44:13c4 with SMTP id
 d75a77b69052e-4da2f12a974mr1030921cf.10.1758732573085; Wed, 24 Sep 2025
 09:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-1-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-1-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Sep 2025 09:49:22 -0700
X-Gm-Features: AS18NWCIXTS-bjNMv6stOKe8Aj5QIFYPyCiaTgRjLhznKLAkt4P5WJ5syBfmC9U
Message-ID: <CAJuCfpE0AQ+59=PLb0xWK28NVAn_BxG-X=EPxy+dcRn2xWb6=g@mail.gmail.com>
Subject: Re: [PATCH v8 01/23] locking/local_lock: Expose dep_map in local_trylock_t.
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> lockdep_is_held() macro assumes that "struct lockdep_map dep_map;"
> is a top level field of any lock that participates in LOCKDEP.
> Make it so for local_trylock_t.
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/local_lock_internal.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lo=
ck_internal.h
> index d80b5306a2c0ccf95a3405b6b947b5f1f9a3bd38..949de37700dbc10feafc06d0b=
52382cf2e00c694 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -17,7 +17,10 @@ typedef struct {
>
>  /* local_trylock() and local_trylock_irqsave() only work with local_tryl=
ock_t */
>  typedef struct {
> -       local_lock_t    llock;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +       struct lockdep_map      dep_map;
> +       struct task_struct      *owner;
> +#endif
>         u8              acquired;
>  } local_trylock_t;
>
> @@ -31,7 +34,7 @@ typedef struct {
>         .owner =3D NULL,
>
>  # define LOCAL_TRYLOCK_DEBUG_INIT(lockname)            \
> -       .llock =3D { LOCAL_LOCK_DEBUG_INIT((lockname).llock) },
> +       LOCAL_LOCK_DEBUG_INIT(lockname)
>
>  static inline void local_lock_acquire(local_lock_t *l)
>  {
> @@ -81,7 +84,7 @@ do {                                                   =
       \
>         local_lock_debug_init(lock);                            \
>  } while (0)
>
> -#define __local_trylock_init(lock) __local_lock_init(lock.llock)
> +#define __local_trylock_init(lock) __local_lock_init((local_lock_t *)loc=
k)
>
>  #define __spinlock_nested_bh_init(lock)                                \
>  do {                                                           \
>
> --
> 2.51.0
>

