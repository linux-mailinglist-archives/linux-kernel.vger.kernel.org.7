Return-Path: <linux-kernel+bounces-842368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BEABB9982
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AFFF4E19F5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3D926B96A;
	Sun,  5 Oct 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AgKHQ+vs"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098918024
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759682173; cv=none; b=ijXITcUaZdBe3vxsUX6vi+ZTaSMfGn64xadCFb3P4l7Isc2pvAeWHrFSHDMvHoNzrb8aJMKfgVY5mSscn3vT7zf7i6UZURInooOhYNgqgHge4eTEZ6nBExJJKP6tLevAilNrwekzI1qe2RnnSfwIh24ydxCLIdrxJSWHFvbZGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759682173; c=relaxed/simple;
	bh=nSyG2GZNUHBvHnW8NY48iLRfk44ksHCm53xs4fGzgHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1DYAhUjCTBPubGjLy3M2AdARa/LnO8qqS8LyU0Z+Xbp0WR5NXzTgvRqDIl7uz0OOYEos6Dy13NWh2jbIJ2PddFJgXIvqZIzik/gyJwVfB7hxoOYM9aTOt/KTYXvWbcwSBBJd9KjdOLw5Cb+eUpd0lmVShTRY40fXK2FM0fBqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AgKHQ+vs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so8174540a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759682169; x=1760286969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tzonFsNLsISTe3SOfhWNh3bHaZmf7NZhQIouk68cVv4=;
        b=AgKHQ+vseRBNtQzbsgwwK97OGnjdUMU8mlX9NAG17gAdGuGxxgS3zHEIY55AtSVBJf
         ym6UKP1v3Y6rFOex+9N2QpLT6+nPkm0a+XIxXjY8YpT8nUfBTh62N2/TkntjJz245eM5
         +6OPqEyY0F1Q3F1bNF4TzH/4Se8/wyYMyAKNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759682169; x=1760286969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzonFsNLsISTe3SOfhWNh3bHaZmf7NZhQIouk68cVv4=;
        b=WYBBkOFd96MmJr/BRH+LTdKKox80x4jiZ35gRav98MVACZ61shWS73ZyVT4b6VpITf
         Aqzaq1PZ60qMd0h5AmVo9ZP5epsK2KUrAXrxJuiMaDoCeyQ6uTdGP2idLg5JDfiRLGEI
         5OSISi2HNGIQ1DD9osk2Q9TB0oCh1kw6T3FLZ/RzJkLE6d3zgtTANyYQLL0mJ7JKAu/A
         kATSjYueWYJ0om0+n3oQVWN3wKszx7ZGa1AOjHQMDGFWGQ/K3LiLS06d1N0QcddMAk+Q
         HNIRoiVdBjO2oJIxbD8mZaJ7LDMOVUEKXJBPin2a4IAIoJagnXDjLS3PIuxIo4NpeR+a
         7nmg==
X-Forwarded-Encrypted: i=1; AJvYcCVaMu9gPbSK/Sug8LhhOvnlXp5iugVf6q5Gg5ToSvNy0J/9GebAcu3Yj7cLzXaksBuR0vaqwpA5/irgrqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywibv+Ac0jpftEwf7TEzEAAwogCdNKQ7C64s1EmGx2tSduSs9OD
	nl6CTUni1nmRCG9QWQ70C44iLoYndzMI9246BT1t/HkUuM3LF4j7m22AiNXhsB09vvUsd/ZzRpi
	3rXjKfJk=
X-Gm-Gg: ASbGncsGGg6V6xkuR5xkU5nX5kSoys778ul0u/mBie+QycsZnrKcaL+6R4rImqx1/1J
	B3FxqA1ceKI1FQtYB4Fy0z+BApobzZ4WqcL7ewuo+076wPgTst0XvYVIK3poTRK3NVzhJyRM6lt
	zQcic5xSUg2L00rCKiQ1h1gwx4rBDcu6p7SqpN04k2/QU4dbBFzBtszqztBINDyL9r9Ewrktdfj
	jja49mwZooS+xzlkc6ei4rnv1rWHyY9814z41sxV+TwqD8Vz06jhKlT5O4at8XnAGbnvPd1one+
	eWXTqaIZ6jSfLRDQwizaF3sgnYgT5vFrdyd1BS5IOVUUPS4RQdgePgYw2gV+7qGnjQIMnIi50LB
	7FjKTbIqBN4nRq5coAIAwAdZEulDPHCmFy1TapQFzrr85ELskecuIsC3QKlOCe6bSqah0Zb9NqY
	u49eLUYtrOigt4TmNHX9Av
X-Google-Smtp-Source: AGHT+IF7EFMfh9hpTKYxFjlOfr4NyFAZcw2ciQi7703n1mbj3+1nKNd524Hx6o46quCrGfBJvi5I4Q==
X-Received: by 2002:a05:6402:52d1:b0:62f:2f9f:88bf with SMTP id 4fb4d7f45d1cf-63939c2e226mr10247334a12.38.1759682169136;
        Sun, 05 Oct 2025 09:36:09 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b7225sm8237062a12.16.2025.10.05.09.36.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 09:36:08 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b403bb7843eso836821766b.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:36:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZNGEO2fp1NhgtujmFWvXZY0oI/vXU5vqAbhwuPeL+oFB0i3TGFI8OeRIMn7XiUODOnHeNMWbhwTd+Kuc=@vger.kernel.org
X-Received: by 2002:a17:907:3e95:b0:b41:b0c4:e74c with SMTP id
 a640c23a62f3a-b49c47abcc2mr1249582966b.33.1759682167815; Sun, 05 Oct 2025
 09:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005144929.GB1188@redhat.com> <20251005145016.GA1254@redhat.com>
 <CAHk-=wjPvwcRwqNmvuZ=jNFyX9g8kO=ECN4u=shHiBknNuTZcA@mail.gmail.com> <20251005160753.GA6063@redhat.com>
In-Reply-To: <20251005160753.GA6063@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 09:35:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFEBjrqyV1n8cHDjYio44Tt4izKu8LdE0duTsF9b3BoQ@mail.gmail.com>
X-Gm-Features: AS18NWAUduOc2BNKZW8NXbbn5JSC2UrYPjpMTN6BpyyA3NKs6ZTJwOb4M6OojA8
Message-ID: <CAHk-=whFEBjrqyV1n8cHDjYio44Tt4izKu8LdE0duTsF9b3BoQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] seqlock: introduce SEQLOCK_READ_SECTION()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Boqun Feng <boqun.feng@gmail.com>, 
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, Peter Zijlstra <peterz@infradead.org>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 09:09, Oleg Nesterov <oleg@redhat.com> wrote:
>
> OK. But if you don't object I'd like to avoid another DEFINE_LOCK_GUARD()
> or something like it in this case. To me it won't buy anything.

Oh, absolutely. I didn't mean that you actually *use* the fancy GUARD
infrastructure we have: this code doesn't do the whole '__cleanup()'
thing at all.

I only mean that as far as users are concerned, this all looks
similar, so please use a similar interface even if from an
implementation standpoint it is very different.

> The problem is that you can't declare "int lockless/seq" and
> "unsigned long flags" inside "for (...)",  but I'll try to think about
> it more.

I agree, it's an annoying limitation of the for-loop variable
declaration thing that you can only declare one type.

There's a somewhat strange solution to it, though: declare a structure
with multiple members of the types you want:

        for (struct { char *a; int b; } c = {NULL, 1}; ... }

and then you use 'c.a' and 'c.b' and friends inside the loop.

It looks pretty odd, but it actually works fine and we should probably
use it more.

[ The *really* hacky solution is to just use one type and pick the
biggest type and then possibly mis-use that type.

  That's effectively what you did with 'lockless': it's declared as an
'int', but it's really effectively used as a 'bool' anyway.

  Of course, in that 'lockless' case it's not as noticeable, since we
often use int/bool rather interchangeably in the kernel for historical
reasons anyway, so you probably didn't think of it as a hacky solution
]

               Linus

