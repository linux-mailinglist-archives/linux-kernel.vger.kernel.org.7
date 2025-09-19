Return-Path: <linux-kernel+bounces-824193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE8B88536
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7E9528358
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2C3043AE;
	Fri, 19 Sep 2025 08:07:21 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC910957
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269241; cv=none; b=bzbMETRc5UeUZImXoJTrGjWsB8C6RqEHrTDVVME9bfupr6WfFY20FWXVsiIOb3l/oogGdFsJ+J0bU236PeLCrGjTxOZCug5nTAlaFUroYcLO5EYkHJSU0cM9mps6Grgk5DAezqouOLxDDIgMBUeDI7EbMMKrjUXQ1sx7trPQ98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269241; c=relaxed/simple;
	bh=A77rA1nwIxS7ZB2vQqX0Zr4/khZg5TlczQ6wINQXVe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7/QqOY3ac3y/4HpVQkOKxOnAsVTbIH6wBPOvZ7U1Vsmgby/SurO6a8emN+aQqla0TTgNmy2bgqtkXyDaX1sMNKRlQQRhScGqJgke34kVo4hhDU3MgsEevHb524Fd6kMvk2fq5L+KzC6g5SRIIvOmc3TQ6rMpqhCbhHTukhxfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8ddcd2cd4e9so769849241.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269238; x=1758874038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jr2Z8JjLLW516ZnDw+SHlM+3eks1R5blpHFwbmMf0GY=;
        b=HThwgSwRYFwsmGyXzui2e3zZlPmSDOeZeb4muKHZQgMlKiPCXtrBB/HsdPrKaKXEZq
         t6XOoHKW8juv1AmlayEtPKZRBMPfFE18slS0UoSXSVNekdsW+xyHPdN8Q6XuEXu1H5NR
         cibSieNx0660DszLMt05dDUWxqQv4KePuGVxYuYIylhBjW2I9ljjUDLg6g8yQyJgitCL
         8Hd8cX04VAjOHc2dfGyqRnfm91rau6/NUyl1Gt8vWCXFD6FkqvGL2MFDvSnla5TUXINz
         p/vG3antPoPsrliAbl/JNCO/9ZOasXhLTzK0cto4uBt9Fw0gzEKaP4w9TzeHA51w8HjU
         +AgA==
X-Forwarded-Encrypted: i=1; AJvYcCVIN1sIAK2I3ptGqFYu4lua5orPVsTdwqi4S/uMZ/d/IWOnGlXG//VsNj768HO7/tm6tiarAa+gRB4Vlzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylZWAagLd29Jx/qoxU+L+DdAZRm8dJb0VEv9dsKcKeD+pgHzSd
	TTPsaja6ymZWTEl7wiRLUpN4vZ+yK5B9g215QbqP1mRQFwlBGrT8Xtp++2kHkxjB
X-Gm-Gg: ASbGncs1VfQeRPx+Zk2gGu3+S7TDickySw0v+pEy/GOOioddLKus8b0KYv/ep06UfNT
	m8RAx3BtbYCkvAk8923t8VKl4ed++L03GB9UdoCItTFeQqPGTw7BMnwW+DJ/4DtnhYASF4/Ythj
	E3XX+DeuH7KvyWGA/ncDptrKwZmapMVCJsKkFCn+YFTsnVxFLFlbVdOx24c2H5kowDN26fEVHNa
	Zb0Nyso072D1l7S9i9OgFAsSz6e5m/i0NQiNzYmXEOnWLybMogtCtmqRJvWLBgSaEk+rFqOtXOT
	m6isui0sJhENI4L7yJVHHokjTebVYLj5FZQfAextmDUzTm9f6TpZw7IsWZ73kpO8g+bBiedY/kc
	dha0AECHb82jevj196wIKLQfToebprCCEIvapmXHZeJOgcMBRModpPXQoRU3K
X-Google-Smtp-Source: AGHT+IHGf/fgAOPbVzxdhbKMyVGSOA3nExP4W6/5i1IefU8Uv6ct66WMkf6KzqF8a7QpeLfl02oEtg==
X-Received: by 2002:a67:e705:0:b0:553:cd2f:5bc0 with SMTP id ada2fe7eead31-588eed21342mr666298137.29.1758269237659;
        Fri, 19 Sep 2025 01:07:17 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8e3e58e765asm793183241.5.2025.09.19.01.07.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 01:07:16 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-580a1f1f187so541481137.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:07:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULS6lkpNzLJND6j9BBYsKQ2Lw9w/baxDFca1Xh3YMtRy1YT/H8qjuV8XySiAHOzrm28UNPCCrDa1wu5Z4=@vger.kernel.org
X-Received: by 2002:a05:6102:1627:b0:4ec:c548:e10e with SMTP id
 ada2fe7eead31-588d76ebbc2mr727213137.3.1758269235705; Fri, 19 Sep 2025
 01:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918114840.53581-1-abarnas@google.com>
In-Reply-To: <20250918114840.53581-1-abarnas@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Sep 2025 10:07:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUi1z3T5dFL15x23ZmkW-m9tzLADYtS0rwKb7KuZrTegg@mail.gmail.com>
X-Gm-Features: AS18NWA24mwTgPwJuiV4lrTa76WLXSZxDgw8vBVbC4rxB2V-sO3NiQxEmyRWCCo
Message-ID: <CAMuHMdUi1z3T5dFL15x23ZmkW-m9tzLADYtS0rwKb7KuZrTegg@mail.gmail.com>
Subject: Re: [PATCH] arch: powerpc: ps3: Make ps3_system_bus_type const
To: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Cc: Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sept 2025 at 13:49, Adrian Barna=C5=9B <abarnas@google.com> wrot=
e:
> Because driver core can properly handle constant struct bus_type,
> move the ps3_system_bus_type to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

