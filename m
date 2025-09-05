Return-Path: <linux-kernel+bounces-802529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE005B45330
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8764F18881AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA51E487;
	Fri,  5 Sep 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXglG7sk"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB932F743
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064805; cv=none; b=HeYLvA4ADuzJmdsA+b6bqw2qUFTHQrdPF1QsJeuELzHMohaR48CqDd/PLuEFqOhs3bkEp1Kha0n2T7YS1aViG3vnAroVHBL6+YwCnQYXPOqpnPzqtExvuVsRQWAZOjRTSdAmPnXUcc5PoIDXkCjdVtO5lGz5TL35eAKoluuHJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064805; c=relaxed/simple;
	bh=YxpwHuQbUyxuClLJ2b1sDxFiEXWZOLDqREDUw5uBTpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lucdWUsmbIYvuhzWo0o/uL5d8QiWI4hCxXwtQ0Xoor2Wb6Yb1VqFshreztbYkUnTepoVLtHRoGNrdX8PpY8CBkVnkQdeoz9euw4IE+no0GuPQiHtGp5x8a+ioQ1jHPmrOvA4Lroi7smeRCfMzn8Q526IJAr2eKcS6fQ3MzCg3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXglG7sk; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70dfcc589a6so21293856d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757064802; x=1757669602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dxTlO6r9HaqREYsy2WnogBnYUWROJNvm/8zDKLkYW4=;
        b=iXglG7skX1A81hVGAO5VOlnt1rkitFs4hVfBJKUsjCtH6LLPTQPmfvmmYkszmD1vfM
         BqET/TV1OozC2oqJkW1neg0MW3qGXJd2eyyAdsPvIuREf5cg8IVGtpRn4dsnIssjt95K
         9EYu0N4/YQJ51FICBR6jFSGFCNZHHEyz1LonD15XQl4DmHKnkdm3qs9X6X2xm+nUPj5d
         5MApnTcWwdWeo0J+POiviw1bRhORY/iOyrfxAGBGrHoxEYT4aZPjhyY243nTu05ZYa4j
         sMBKAd0tljCio660pl959AX3dvjgelzkZJu72hDmWg4o9hzipM63HB4KpmEZ5ISBxtNt
         BNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757064802; x=1757669602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dxTlO6r9HaqREYsy2WnogBnYUWROJNvm/8zDKLkYW4=;
        b=okJ5jRja5oWkrUHukibGiCzzMS7x7lyfXmK1MHNH4/2VQhZvyeeWE8ATAR3OT7rbRQ
         xtyQTYBXy/OmSi9pyU215miTsCOd6o2Flr8rOMOB6l60X/EO7B3E3kCwTvgGP/gaUdj3
         Yzo/08fAtQXcz1ufnz60L0AuVym9VlBombAIftb9Rhqj8BIsqQ8aUswtXMTG00vMCJ/x
         zVRwoHCDNKVZeVuGHrnimcwUQEnPH/GCucxIuevNQ0ASMGmjri4MFoWi8YGDU/Nhempq
         Er7cqseKnZm9O6uCjmXpRW1erok6CoWxMtUWvJ5/2LszFDkPW4cJWgnhzsZrfcoKb3VU
         dwyA==
X-Forwarded-Encrypted: i=1; AJvYcCVZMck72Bfn50lXgc9oNB5MY1Tq3J4PB+mG4SV+ssjAEjr676tfd8eIvSWgz13/ErlPuB1kUCJj5mY0qjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNb9DNG2jM3ZCm9+Z+60kwdg5nWlccQ2h5CHNcPC9MMdiRpPru
	o3CMABjwhrzCR0Xf7FOCGcC2wiwDz8uRLNuD62kOHHwPKDWcRv5NT0PXkXOe1s2tVQ89ZbGUBXa
	2RxSQHEbrihRgz/N2oQ31c3X/3TgdqpCVpkH5AbCI
X-Gm-Gg: ASbGncsue4z1/BLcf3Wv2oz9PXW483XIbCjRJseaMl4lFjmwLGMj5Ql67jA6lDfXQWB
	6zEAGvASU22bJchsXVe6uTb+yRA3eM9ACNMuqTkIx41TPAh+x/Mx5/tbMC/XX86TN0gfFSQIse/
	5Qq52TC2m4den9oL4+zkfjOZKyxYHau8Dsk0HDsHux+TP9Se9BRjwOgxzGgQP4CbyAT9badaRVx
	YEbpPocewatTlRP+Hx4W1o1q9HcwPnOvUTJZu9GS70yzLqsigYsQeo=
X-Google-Smtp-Source: AGHT+IGQkQamDqV7XCEOyIUgjXvJXRgsMMyMEK/W8ipJeEavgvLDykrYzw3fu54iUR6ZTuvy7C3FIAyRxwYRKqoZ2rM=
X-Received: by 2002:ad4:5ae7:0:b0:71d:9d4c:1907 with SMTP id
 6a1803df08f44-71d9d4c3002mr190638486d6.11.1757064802234; Fri, 05 Sep 2025
 02:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com>
 <20250901164212.460229-2-ethan.w.s.graham@gmail.com> <CAG_fn=UfKBSxgcNp5dB3DDoNAnCpDbYoV8HC4BhS7LbgQSpwQw@mail.gmail.com>
 <CANgxf6wziVLi5F5ZoF2nwGhoCyLhk5YJ_MBtHaCaGtuzFky_Vw@mail.gmail.com>
In-Reply-To: <CANgxf6wziVLi5F5ZoF2nwGhoCyLhk5YJ_MBtHaCaGtuzFky_Vw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 5 Sep 2025 11:32:45 +0200
X-Gm-Features: Ac12FXwv0qVlytn5UPR2kOevtwfln-V7rGK7j7x55WfwpJGZ-qo_gaxhqOnmQY8
Message-ID: <CAG_fn=VL1j42TxEoWD8Z3jO0uvU0j1JNzPS3BfUXd5AGE-nDkw@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 1/7] mm/kasan: implement kasan_poison_range
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, brendan.higgins@linux.dev, 
	davidgow@google.com, dvyukov@google.com, jannh@google.com, elver@google.com, 
	rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dhowells@redhat.com, 
	lukas@wunner.de, ignat@cloudflare.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:46=E2=80=AFAM Ethan Graham <ethan.w.s.graham@gmai=
l.com> wrote:
>
> On Fri, Sep 5, 2025 at 10:33=E2=80=AFAM Alexander Potapenko <glider@googl=
e.com> wrote:
> > > + * - The poisoning of the range only extends up to the last full gra=
nule before
> > > + *     the end of the range. Any remaining bytes in a final partial =
granule are
> > > + *     ignored.
> >
> > Maybe we should require that the end of the range is aligned, as we do
> > for e.g. kasan_unpoison()?
> > Are there cases in which we want to call it for non-aligned addresses?
>
> It's possible in the current KFuzzTest input format. For example you have
> an 8 byte struct with a pointer to a 35-byte string. This results in a pa=
yload:
> struct [0: 8), padding [8: 16), string: [16: 51), padding: [51: 59). The
> framework will poison the unaligned region [51, 59).
>
> We could enforce that the size of the payload (including all padding) is
> a multiple of KASAN_GRANULE_SIZE, thus resulting in padding [51, 64)
> at the end of the payload. It makes encoding a bit more complex, but it
> may be a good idea to push that complexity up to the user space encoder.

As discussed offline, it might be good to always require the userspace
to align every region on KASAN_GRANULE_SIZE or ARCH_KMALLOC_MINALIGN
(whichever is greater).
In that case, we won't break any implicit assumptions that the code
under test has about the memory buffers passed to it, and we also
won't need to care about poisoning a range which has both its ends
unaligned.
Because that required alignment will likely depend on the arch/kernel
config, we can expose it via debugfs to make the userspace tools' life
easier.

