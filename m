Return-Path: <linux-kernel+bounces-818563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0023EB59370
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AC84E135F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625913043D1;
	Tue, 16 Sep 2025 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4xwDrKCQ"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB32E8E1C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018130; cv=none; b=ImDaOhMeB6ynBzxFWy+j/Bx4lApM9QaCYLypHpNYrFI7od5eP2QQZ1tmc8vxQKj1WbgmY0D+U7IRYlci31Nhn8pqECCvj178ve/Wid7r+D54gEpe0jHDO7LoevWozDtDIZH5vXJ9K7qw7dRpX1BfiUFgI5ikFFkFvjc2eIj4K18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018130; c=relaxed/simple;
	bh=A9w+UJd4v8RhCRa+BhDctAaf9V0sYFUiRfKGTUevroc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfE7ZBeMdzQPadGh1EzLyvpId/4rkpLPaNGkH/F5MsTi1KW+HjO0GV7whRbu6ktkZ+EcNGw8WAT/GMV2e4XWOBeOfMohABSDQQ44tx2qpw44ta53aWX9Ccc1t3ujjmtYpXl+Zn8Ms1i3c7bJomuhWk4wEjeJpxXmB1MotdCRDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4xwDrKCQ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-782ba4488b8so22410186d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758018128; x=1758622928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fDdVkJYP6n8rFxsmmwdyCR43GJXYJ4e6lkQY1k5jhI=;
        b=4xwDrKCQ16W5xgDkZ7lwklnNqKOSoje/r+blQKN70VfjfbRT/ckZAJAaOqEwxJ833X
         b53KI+SqkWA5KgB7eDCljezBW50xqANoatvd5W+F/qsLVUxKY26Zzz562MXGOVE00j4r
         510BKdg9IfHXH+FKHU6czPrZmxeFsfjj6c44801s8R1orIiyXvUdIt2gQhgd+66jeIk2
         qtDvKIB6h+4bAyhKfg2TBIbLCbOc5vlq9NQvSlwZRKFUqNzdhXU3eKH/tceDlg6OrQ6E
         isRGK0NdjTiVR4KFdfEB8+Q48hbwI9x3uM5qieY1Cm/wYp/+6N85VMgbxaEjCLwRo1Xj
         ZDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018128; x=1758622928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fDdVkJYP6n8rFxsmmwdyCR43GJXYJ4e6lkQY1k5jhI=;
        b=hLVJdkwKC6y8sh5/l+zcL/3EUNy229RS9IMO0Gy8do66A98kNlA+Mu/3tGNRRanZjg
         acntJbeXYjfON7hQfpGih3UPLXAc/P9NAKSkm9yfmBgCa8ouQNAqoohuPZPQEHtl0/L6
         386bMc+bQs7xt5p+cCdxG3hu3dsuA9byCA4yL8SO/eRsJ3d8Q3uHeTob4YL6Ozzn9bE2
         8BRyvHK8bHQbhb+FPdx+/dDSHtPr2+eUT1ob98gCdZOsaxnALSZoKb6Oo+J7bnrLTvrS
         ODVdQ7LtlBDGJ5Sm9svO5R4Xn2nIw8kWNPobyYq6rWK77HYMO70pzfQ4VkkgABaB7VeY
         KPzw==
X-Forwarded-Encrypted: i=1; AJvYcCXA4dGIAs7TnxVAFqYjppbqE1hd5IqB2wCdfqLJukwLUgGSaXAsWcNHKhXy/uQL3VtQ3vj+s3gLP/6KH2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHk643bvRJCulx/9PF2expfs0Ciqn61hXIbzpvl37JdFYUOnQa
	yC2xJiea2ooPo1j+r36Md0kzJXxxPZA6qahqZL48CoxyZP4MC8e/paFww1PY0X8HmMLYyr2vC0A
	y50cFXOTYAe4L6EfGOSW+ivqmULhc3Ycvik9RGbCU
X-Gm-Gg: ASbGncsD4b6JA/CAj5h/G6Qzxpfrpu9dBlraoEil4dy6Vg5CkHmHb15g7jha5b9bm7b
	TRBg+8Tlwu1Nx6FtOwLxaNMTeZzDaAHlxK5jLdiesmHmdakziBD8NdxrozZ33tg758BJa1WhKcr
	9GllD/4am/ynt+Ax/IKPtCijy0bv+kmBOqPIblKDD3bsKIIkK8mjqwN+l1SakjM4c/stnyAh9AN
	PCB+vHUtJzfz4ZBsFcUluEqmNdRBgoT1U71Pb/6nFFiXi96DxZu0dI=
X-Google-Smtp-Source: AGHT+IHJjKoQJCCYYuGTfxXsKe91BImRKJTHt9tE43tLxxHwyTxwEt6wyB79lNc8nOP5l+AzdDg7yLv4Nd7/rU5xvGE=
X-Received: by 2002:a05:6214:1c4d:b0:781:a369:ef8c with SMTP id
 6a1803df08f44-781a369f19fmr98103496d6.16.1758018127627; Tue, 16 Sep 2025
 03:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com> <20250916090109.91132-4-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250916090109.91132-4-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 16 Sep 2025 12:21:31 +0200
X-Gm-Features: AS18NWAvlqXEHGPKEvaBnkig3ksosFgvoGuvVmEMsd87qxp-V32sXYdPaxYq0Tg
Message-ID: <CAG_fn=U0dOBumngmQQ1cna=SZvbDXjJ8NrVUZyCHY5dzJV4rVg@mail.gmail.com>
Subject: Re: [PATCH v1 03/10] kfuzztest: implement core module and input processing
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:01=E2=80=AFAM Ethan Graham
<ethan.w.s.graham@gmail.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Add the core runtime implementation for KFuzzTest. This includes the
> module initialization, and the logic for receiving and processing
> user-provided inputs through debugfs.
>
> On module load, the framework discovers all test targets by iterating
> over the .kfuzztest_target section, creating a corresponding debugfs
> directory with a write-only 'input' file for each of them.
>
> Writing to an 'input' file triggers the main fuzzing sequence:
> 1. The serialized input is copied from userspace into a kernel buffer.
> 2. The buffer is parsed to validate the region array and relocation
>    table.
> 3. Pointers are patched based on the relocation entries, and in KASAN
>    builds the inter-region padding is poisoned.
> 4. The resulting struct is passed to the user-defined test logic.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
>
> ---
> v3:

Nit: these are RFC version numbers, and they will start clashing with
the non-RFC numbers next time you update this series.
I suggest changing them to "RFC v3" and "RFC v2" respectively.

> +
> +/**
> + * kfuzztest_init - initializes the debug filesystem for KFuzzTest
> + *
> + * Each registered target in the ".kfuzztest_targets" section gets its o=
wn
> + * subdirectory under "/sys/kernel/debug/kfuzztest/<test-name>" containi=
ng one
> + * write-only "input" file used for receiving inputs from userspace.
> + * Furthermore, a directory "/sys/kernel/debug/kfuzztest/_config" is cre=
ated,
> + * containing two read-only files "minalign" and "num_targets", that ret=
urn
> + * the minimum required region alignment and number of targets respectiv=
ely.

This comment (and some below) is out of sync with the implementation.
As we've discussed offline, there's probably little value in having
"/sys/kernel/debug/kfuzztest/_config/num_targets", because that number
is equal to the number of files in "/sys/kernel/debug/kfuzztest/"
minus one.
It just came to my mind that "num_invocations" could be moved to some
"kfuzztest/_stat" directory, but it can also stay here as long as you
fix the doc comments.

