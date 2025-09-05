Return-Path: <linux-kernel+bounces-803751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC2FB4649D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE347C88C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BE62874F7;
	Fri,  5 Sep 2025 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnogFogC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B81F4262
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104480; cv=none; b=kZ1gqWlt+dsdPPCZlzAP78r8jtzR6V1Bk290NhFNmhtzY87QM8XTaUGHXwYMjylTHyrp5lAbRsrCoZWTmVCyaHTS9K1rwsv7KfSuJo8W7fuDC6Q6RkxFWp0N/bwAXp97QzPN4HGV+3LjZaiDDZvQxnTTLdv8yXTlKBInATzjF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104480; c=relaxed/simple;
	bh=BfAilJ2gxaTlTEXjw4cUYBqev2DLfb4NtdyYplV2cLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAMgQ4vj4R9rtWqSFSD7NaUNx8peUn1ZX65f18AJ+VEEGC8GARJxV24LaGeUVoZncQdAeHv8L7+9A7P6Q7g1UZHjzW9WfH5V2S++J07FF5KU0DHWQ5Sohs0BX+BpQ08QIhe8jSfPslY/kOKEd1EqQE8gOnOx5W5pIyXVJyCOiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnogFogC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b627ea685so19741605e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757104477; x=1757709277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfAilJ2gxaTlTEXjw4cUYBqev2DLfb4NtdyYplV2cLk=;
        b=BnogFogCoNOwrtalPZBc36zr1cYn0dmyXQJyXKLmR3RHHVRs77PD2YJMVC9yL5bRBd
         hQu241tGD0SybXJSjntsd4Pt8UgvwvfW8Z/jXqljg+NbCrdPYM8Xwgt/5lGGcRvKCiJI
         G8pJi4qghi8RPdfTJVut9buUISYgEp6aUW9gz8IvADoxmbwjoeoFCdgf43csxZecUeA3
         bFNytblYlb6NymoyZxADiVZHFytkNXusz2yKCoZPgH9Xs0ESeqC/k8A7CmszAxajil9V
         xbxcW/3BFYFsAlvBByjD06Dueq5nzmbsPGOno/jR4yTBDFhcazA1QPoOOPuVaKw1MpbH
         d03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757104477; x=1757709277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfAilJ2gxaTlTEXjw4cUYBqev2DLfb4NtdyYplV2cLk=;
        b=i+kHvFQXadORi8UmZNg6JFOrdempE5fzBv1ime+QDXVONFxvo8TXSl2HB4dxpMdHWL
         W3rW7SPncSBpwVWtjquU5k77Vyx5SlZ8xOouATXp4et8JIEoo0jqETpstq4gF8OLoD77
         gAWtAe3TiZ+R+SbVJV7x7SYx0nLOlWHSQnx2IbQTI1SyJuEuOBQY170b/v0zJbLigrjl
         znWQyrdqdXnd0+8DN4aLY8TRzJsnII5MRj4J/xAX68FNh3v1OnXmGuFgnsp1TjdIrOCD
         RX++Np+fXBHyCsnbXg8gZNAlUfCKlXkr3HA2NmG3X2EbkxGM9DBsuU/63kC7Y4LLk5Ad
         eKBw==
X-Forwarded-Encrypted: i=1; AJvYcCXSflVkhO9FYVnM5Y9WAAuIQfl+Zy5fAF29gDbI9uqOXvHXsVELkQ9knRHVXdkrn9R99csGHoGY0pr8Fxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywodpk59eH3uP6qUHEn1W0gFTk3pfSi2MkDKwWG8r6WZoLZsqz3
	AAC6CyCRv8qdBu1gLCc5X2KL1ml8eWWCsutPfSwSvj6o5kt5ECOJgnRHWxPyq7VXfhqLsDYG67U
	2Af+nSK4C9CA4wEEzdCO58ibuvU9eliQ=
X-Gm-Gg: ASbGncs8VJMjLiQ4E63jp4GCdtumblO1PyzhzpBMWZvWtU9y/Uc8Z/8Wfmf+wrPhIlu
	1Mv5/MDWxoUs6H7vze60VA1mHGULQxIGDhPRr4h+YgHdtFMIEUGzd4Lax0NDqt+LEW8/pq843ti
	F324HF50FSYqjMcox+i+0e8PvHTZJ1qVO7WriuMGSfh6BiGMemASuTUKb334RZ1eQ3CuvoLTGOJ
	bNeJmI=
X-Google-Smtp-Source: AGHT+IHAHVwclBpybbHsJm/2lJguUcGowceRU+Er1bB8qLNDR1sjTRVlcevgD13lm8TELeXUorSoWEH8Q8YTbd86dPY=
X-Received: by 2002:a05:600c:1991:b0:45d:d6fc:24ec with SMTP id
 5b1f17b1804b1-45ddde8a579mr1347145e9.1.1757104477218; Fri, 05 Sep 2025
 13:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
In-Reply-To: <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Sep 2025 22:34:26 +0200
X-Gm-Features: Ac12FXx365TCqrnAMDPozsjaxIlbZS7cS1EckX64FuOxYCiii9Ap4uOCa5qcCQw
Message-ID: <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Baoquan He <bhe@redhat.com>, snovitoll@gmail.com
Cc: glider@google.com, dvyukov@google.com, elver@google.com, 
	linux-mm@kvack.org, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail.=
com> wrote:
>
> > But have you tried running kasan=3Doff + CONFIG_KASAN_STACK=3Dy +
> > CONFIG_VMAP_STACK=3Dy (+ CONFIG_KASAN_VMALLOC=3Dy)? I would expect this
> > should causes crashes, as the early shadow is mapped as read-only and
> > the inline stack instrumentation will try writing into it (or do the
> > writes into the early shadow somehow get ignored?..).
>
> It's not read-only, otherwise we would crash very early before full shado=
w
> setup and won't be able to boot at all. So writes still happen, and shado=
w
> checked, but reports are disabled.
>
> So the patchset should work, but it's a little bit odd feature. With kasa=
n=3Doff we still
> pay x2-x3 performance penalty of compiler instrumentation and get nothing=
 in return.
> So the usecase for this is if you don't want to compile and manage additi=
onal kernel binary
> (with CONFIG_KASAN=3Dn) and don't care about performance at all.

Ack. So kasan=3Doff would work but it's only benefit would be to avoid
the RAM overhead.

Baoquan, I'd be in favor of implementing kasan.vmalloc=3Doff instead of
kasan=3Doff. This seems to both (almost) solve the RAM overhead problem
you're having (AFAIU) and also seems like a useful feature on its own
(similar to CONFIG_KASAN_VMALLOC=3Dn but via command-line). The patches
to support kasan.vmalloc=3Doff should also be orthogonal to the
Sabyrzhan's series.

If you feel strongly that the ~1/8th RAM overhead (coming from the
physmap shadow and the slab redzones) is still unacceptable for your
use case (noting that the performance overhead (and the constant
silent detection of false-positive bugs) would still be there), I
think you can proceed with your series (unless someone else is
against).

I also now get what you meant that with your patches for the kasan=3Doff
support, Sabyrzhan's CONFIG_ARCH_DEFER_KASAN would not be required
anymore: as every architecture would need a kasan_enabled() check,
every architecture would effectively need the CONFIG_ARCH_DEFER_KASAN
functionality (i.e. the static key to switch off KASAN).

Nevertheless, I still like the unification of the static keys usage
and the KASAN initialization calls that the Sabyrzhan's series
introduces, so I would propose to rebase your patches on top of his
(even though you would remove CONFIG_ARCH_DEFER_KASAN, but that seems
like a simple change) or pick out the related parts from his patches
(but this might not be the best approach in case someone discovers a
reason why kasan=3Doff is a bad idea and we need to abandon the
kasan=3Doff series).

