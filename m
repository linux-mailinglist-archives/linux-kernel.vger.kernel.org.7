Return-Path: <linux-kernel+bounces-748660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15551B1445A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE718C1FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F86E229B15;
	Mon, 28 Jul 2025 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ABFxcP4U"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F51E4AB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753741304; cv=none; b=GuVYpc7cjv0VrxS81H8eOCW/tm/2tzafCswHs6bgOCMT9uyopaD59SKNnjFN6xfLXFn2+giNM2WksiIIV5u73K80AuaD++NxmIIWDySfPCQQFx0CNX7wa7jciftUCzgSo2icC+ddGoTxdfmG3nKLfhsd0Z0bDT2/z86HxrmA+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753741304; c=relaxed/simple;
	bh=xOpI2jYETyxLIMK6Q9ED9DU01xuFZr4mDYMkTCbHb6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1EiBz2vxEPk4LNOhvnVB52qOjGALXIexbyFfS0ZQhOfxZOJClYYoQ8vsx9rcja6vj8RO+ZVUI5IRrX+Z5+ljx6NgOCv2U/oSZ0DL94VS7pmR665fBYuirLA8CccQ/44CmdpK0ZsHjoE8oNn3drgOmVC4lRduFSbFrYMgfxB/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ABFxcP4U; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so2526137a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753741300; x=1754346100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JqExg814NmJsAheHoSQFN76PuNVP4UFH80zpicXvJrc=;
        b=ABFxcP4UTdFAfbqBRu+Dy9jGZAzAjDFgKSwz+/e1+DTi1Eq2UtrNtWQ+ZnYCm85iE+
         Vlmv4041IhsK8tctjl422r8SC+egpRpjrBgiZFQ6yP0u+0Nq4O/Ru0MKbFHlmYiwTvjm
         YCWXkm9+ZNRG9kEViaO0l85KnY8uWDuTpq1xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753741300; x=1754346100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqExg814NmJsAheHoSQFN76PuNVP4UFH80zpicXvJrc=;
        b=wNO3AT3Ak7AIsjIuIGh+Tx3366sfEJmBoNREliNZrPEvmEOnyqRaXj6n5La3d6NIjz
         KbvbUEHbgZLpNEG2OsAFyCcmHFoo7Yo50k2Io3nCs4JGJpzu+EYYXmAYftky2bclf636
         +tqLJ2qqYPkBhzTpnDsYRt15jfkFwDCo3Oe6nSMStj+Aj/CpWrIU8B/pVHKEcQET92Fz
         ec3fLXpVjZwb1+MeuWtod4hVFOTtUM5qxBQHdmKWxs4SV7kny2U4vVLwDVkqwaWh/MHB
         7Rz7smt1EmrTW1tns3TFiZKdfShgRu2sVZKj6wCr6WSs49OPlcmiR0Do9TvZEYXzzvFx
         q7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUMfq2oSNUNKKDpxp+4LdB0jPpy0HeXMnEl0oonK2O1x5VcGswShb91hS1ma0wU3tRKprjVEvUHZY20AUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOo+W55FL4l8UY/gNvEvS1thEZ9vtB/x8qaa5ACN5wKdHNMxYp
	t1hFawRrJDd+JueR5vo6g1+dYD1kDPO099fnT25N5ZVG0uDqtQqRBhKfRXZRpzBaQy/nfzAxYS+
	qW5JbSgw=
X-Gm-Gg: ASbGncvHI2qtBs1atJyzbFhPNtoLOjH3pFcTThtW0lxNJSkxQe2hJ8BFycO6fGYkuCW
	8NOP9ImdnTaMxvtOBfaBI8B3Hz/lcBdnrTWw/AMTJSUdf40c6qPsRXoKem91Xds3Blyz/Oy0KTh
	EQp9jYbxcrY3YMa6nu4gv0pje9CT4zCIIZYUxAriF+Gykkbi76f/DF1piqvmbA7ZOHmkN4bzO2e
	ioRhpK8X/5bfGy0fE70ZU4SDX4tjMwkHpElebw9w4SQzyKPRsH69xqdJC3AH+aS0LwG3EyystEX
	itwV8pQ9mmYrUQo6u1A9Dv/VTpJmn2t8MADpoMKk/tzp52xroK/X3MZxTZalR9C80YDPaW+wRxo
	rN4DKkWAq3lNI5AXXXylAbZtV1Yo0+uASPtlRKvn2WoXeMXt8gkfnlmAb1XDaYlvoiRquhYua
X-Google-Smtp-Source: AGHT+IFfQkmmfdoKmHapAjeFrJRX0Dkcb9HpYILso3LQ4w3V2mdhkINXuCcqeZugpbI0xeLYBtKwXg==
X-Received: by 2002:a17:907:97d4:b0:af1:8336:6651 with SMTP id a640c23a62f3a-af61940d2f1mr1487005666b.33.1753741300459;
        Mon, 28 Jul 2025 15:21:40 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358c3d14sm486112066b.58.2025.07.28.15.21.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 15:21:39 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so2526108a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:21:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmT2E9XwZeSdaUU+XeJgUUZWzf6y9U6Ko57cujgJdsrnCpdL2wDj3WsQNdwx4R9T0cz2FVQF64MVTHCOI=@vger.kernel.org
X-Received: by 2002:a05:6402:35d2:b0:615:5aec:561b with SMTP id
 4fb4d7f45d1cf-6155aec595fmr2603824a12.17.1753741298741; Mon, 28 Jul 2025
 15:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-integrity-d16cb92bb424@brauner>
 <0f40571c-11a2-50f0-1eba-78ab9d52e455@google.com>
In-Reply-To: <0f40571c-11a2-50f0-1eba-78ab9d52e455@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Jul 2025 15:21:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2-ShOw7JO2XJ6_SKg5Q0AWYBtxkVzq6oPnodhF9w4=A@mail.gmail.com>
X-Gm-Features: Ac12FXwBHyV1oTWHkUDzkz967sD6oQ6xpn7rxtt-GEiesYTsoGqtNNJfDxE5ks8
Message-ID: <CAHk-=wg2-ShOw7JO2XJ6_SKg5Q0AWYBtxkVzq6oPnodhF9w4=A@mail.gmail.com>
Subject: Re: [GIT PULL 11/14 for v6.17] vfs integrity
To: Hugh Dickins <hughd@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Klara Modin <klarasmodin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anuj Gupta <anuj20.g@samsung.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Jul 2025 at 18:29, Hugh Dickins <hughd@google.com> wrote:
>
> It would be great if Klara's patch at
> https://lore.kernel.org/lkml/20250725164334.9606-1-klarasmodin@gmail.com/
> could follow just after this pull: I had been bisecting -next to find out
> why "losetup /dev/loop0 tmpfsfile" was failing, and that patch fixes it -
> and presumably other odd failures for anyone without BLK_DEV_INTEGRITY=y.

Bah. I *hate* this "call blk_get_meta_cap() first" approach. There is
absolutely *NO* way it is valid for that strange specialized ioctl to
override any proper traditional ioctl numbers, so calling that code
first and relying on magic error numbers is simply not acceptable.

I'm going to fix this in my merge by just putting the call to
blk_get_meta_cap() inside the "default:" case for *after* the other
ioctl numbers have been checked.

Please don't introduce new "magic error number" logic in the ioctl
path. The fact that the traditional case of "I don't support this" is
ENOTTY should damn well tell everybody that we have about SIX DECADES
of problems in this area. Don't repeat that mistake.

And don't let new random unimportant ioctls *EVER* override the normal
default ones.

               Linus

