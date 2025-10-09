Return-Path: <linux-kernel+bounces-846267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E50BC76EB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B1319E5145
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238441DF75D;
	Thu,  9 Oct 2025 05:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FjI6+Zv3"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494BE25C6E2
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987933; cv=none; b=rUjhFFZ1mwQrmJZuXgdOoGn6qjoFuw5Kqdhwg7/23VQ6ygWF1Pxi1Lzn6AwUD5Ru10AovFSadOkiSX7hgjx3JIWh3Qaqqf/kqcjEQDCBWaYwA2Rv2QrM0Ioq5VzbZC1rJhO1YzGnRtCCQHBRs5Y3zqHlwmDjHmfGJLGN3dmslZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987933; c=relaxed/simple;
	bh=p0WDAtk/m2ooYYDQvo1mfLf3Y8e8XUasvdbpgjXqJIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rB7ZT8DRJXtqy+0aX3GG1/t6daRxJzpV8aEjYaoEc3y96JGCNfuxolYPjC0+gK7t+SUpJO9YS+SGL/cH27RUqca07PO7TFVt/3l9HeNAqpW1cpl/3CtR40mobkCWaxbmX4Ux/lFeWfnRh8DhKWeVh8ohTaHGfQ78Dr11SxpLvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FjI6+Zv3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso1111148a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759987926; x=1760592726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5iUIuF0PvXlOQIXyN7mabhFThgTHnFDsNn0DAFrYiaY=;
        b=FjI6+Zv3i4QaQgWAn3w6bumcsxAVtKsObP+Nh+PaQVKt/EVTy282Qzt0m8cNIb5IbP
         QkMMaKpeeQiNP8M/Ll7FpLzejRXK9ExlYJI1qPhEZvxFGYsq5Rdfs1V4QtzU0CKUPXLV
         VMuhU/unBoKve+UMdzairoiGUN22P8QazeBKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759987926; x=1760592726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iUIuF0PvXlOQIXyN7mabhFThgTHnFDsNn0DAFrYiaY=;
        b=IviHooEIJwEDmQ8RgOR+F3H7rKDVIfsqBtK4mluGQ9rry8E+VTjifYBfaRSsHh4hPI
         zuD8jfD2mC9RCr9OzXRDGVYwTHGj5tGqkdBZZIMpg2jnX25Lz2zMZdwpJrF1kFgnce4p
         v1QT0XgBnPhmFUws4l4aQRw23jhy4iKWpRPKuWqixPUhkagyOIGiMWtVEmoR/stdeZZZ
         uig/lN8t+sYlJ2M9XTMp5tMmXdlQF4kewhLlViG6fo80U90TKYjhDo1RLHsvothUWRAJ
         lwTYDk7bgxQSyDgFM2Md9h+GzNqvNi+2cFFjRUroYJ2lw060JA/sjn52U8N/f8BfNhOq
         iFaA==
X-Forwarded-Encrypted: i=1; AJvYcCXeYRamPI2WBAXQTRFy6+khVF3Zpp+EwURNvG3lQJTW3c2Al0MV0eN6MoL49m49BsWxrTVkBkMXe+37dDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQS1Vtv8y7RGp5pkUxwx90RNuH4y6gA9b/46cdFeSOGjWHwTb
	Wy2DF+IZniNhae0XggarF3j91GBD6CGg8Kvc6ANrWG3StyaqGAE+YViOioiZfgj/nI6tNUXNyAB
	V4QhkaFxb3Q==
X-Gm-Gg: ASbGncsqhTfME46UrsqyrtSMtn8/Toqyl6xmAneEH8nFmrALAUaotVkHWnjNqjoysRK
	esiyC6EWjGq1jSBdIVhg5pIfNkpkA/rhH/IGxb+pO2JSYlyyX+B+wxeM/CfwhqnKYEAV/w8imcq
	D5G4UDOaPik7VOKPX0tSvlQ0e8acFsLsef7TmQud7bwZGIHR6OwYRgQLbehgTddEOlhKUqnwgXa
	g5kC4Uy2OwNs98lPx9jIZfNWDomzD8lAuhTqx/ocMAntIHNYS3FqyoKjUpJoA5vFd/qeBspdZFQ
	jSe/OXA2/Dd/ILtUDPuJcHiU7MTPrqR0luGNonMHDI8P8RSIetIXmP5onsyMJzKfnhSKwmgU5qo
	WntZAivFY/kgQaMht5ZdspitRVzMpgxzz6UjFb2T3h28DGARqUTCymn5vAnFJeOLRZgNwQqL/m/
	C8f1yGtu3CEFegbaHdVzwd
X-Google-Smtp-Source: AGHT+IErGFv9MHHGjxrzXtYc0To0imJRi7mxlVPj8J3YCSUHZmDut6M/3cWByruuoGFbBHSJhbE34A==
X-Received: by 2002:a17:906:f5a5:b0:b29:c2ae:78f8 with SMTP id a640c23a62f3a-b50ac5d08bamr703623766b.46.1759987926327;
        Wed, 08 Oct 2025 22:32:06 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e7c47fsm1829475966b.37.2025.10.08.22.32.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 22:32:05 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-639e1e8c8c8so1045248a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGQQS3M+3nyChkA3j3HhywykG2UfexwuaX69epKiFqDFfSyF9xj/eu3QKbIXH8OAWfbypkX43yUMqV+rI=@vger.kernel.org
X-Received: by 2002:a05:6402:5193:b0:634:c1a5:3106 with SMTP id
 4fb4d7f45d1cf-639d5c5a3dfmr5439388a12.31.1759987924767; Wed, 08 Oct 2025
 22:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008123014.GA20413@redhat.com> <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
In-Reply-To: <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Oct 2025 22:31:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
X-Gm-Features: AS18NWA_8Cfdb68OVnzoIohElsdBiWblfIoQ8JOzZXJX8xy2nSMX8RubDlSjGTw
Message-ID: <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and scoped_seqlock_read_irqsave()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Boqun Feng <boqun.feng@gmail.com>, 
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, Peter Zijlstra <peterz@infradead.org>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 09:05, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think that you should make that helper function be a macro - so that
> it can take the unnamed union type as its argument - and then make it
> do something like this instead:
>
>   #define __scoped_seqlock_read_retry(s) ({ s.lockless ?       \
>         (s.lockless = false) || read_seqretry(lock, s.seq) ?   \
>                 ({ read_seqlock_excl(lock); true }) : false :  \
>         ({ read_sequnlock_excl(lock); false }) })

Actually, it shouldn't do that "s.lockless = false" thing at all -
because that's done by the for() loop.

So that was just a thinko from trying to translate the whole "*seq =
1" hackery from the old model.

But that hackery shouldn't even exist since it's all handled naturally
and much more cleanly by the surrounding for-loop.

The only thing that the macro needs to worry about is whether it
should retry after the lockless case (and take the lock if so), or
whether it should just unlock after the locked case.

             Linus

