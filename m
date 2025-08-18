Return-Path: <linux-kernel+bounces-774567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62485B2B446
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB027623CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83E215F4A;
	Mon, 18 Aug 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ckEn3MR4"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568BD3451B0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558068; cv=none; b=DhQxEuPTU9YUD9ftkHvbXsLDCYbJCqGhskhItzVPgnq8XFz/mWL4FtdNvxNuCMH/AFB2PPovmWfMO0QREMUZYr3Dl3dHHAFoXL29/rLo88lg+I7oFGskq3bs/FCxPo2jvple8Zr1SJt6leWtM/Sm5sBgleEVLtNGzZqinlPdnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558068; c=relaxed/simple;
	bh=HRNJeJuGb/XA8OYTD6hs1ZiVROyyrC798bMA5h1n050=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnE74kf6KrW8As+9prlFwNSK6YUPkagZsEJ9WqpkYRrFJ0o7GPji6UUy9RduHOCk0lHH7Uagre2vPXnzz/wl6Gos7Kcms31zW/uO8BprNYjSJ9kYpnpF+myaJGTi4NKTrHs5TqQdTvW6y0Y3Cy124QanyYTX6Lpj7uOT/tKQo94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ckEn3MR4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb79f659aso703533266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755558064; x=1756162864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=17llHjHP+b+V2SJCZ0PRBv0FMcxdkNEYJQnyUnS6msU=;
        b=ckEn3MR49iebNXnu62dHR6Qf5L+pNNdLa4I/usL3uZUuTds4qhqmScydKcN+3PF3/U
         KRZ2L5ReGrDAaCTaTeC9tRizYQxFaz38xv85TQ/e5strGuhQKrjFUpHhNu1oowCF9tL7
         uaG7SxG4dBLGiUVgpogPXUOay3Olib5Dln2Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755558064; x=1756162864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17llHjHP+b+V2SJCZ0PRBv0FMcxdkNEYJQnyUnS6msU=;
        b=IQH5pfNuSoG4UgJ+My70dwf99TTV49VaAy6SIVUVF8XQOxUh5AfqOpueRAofl/b5ne
         DGeHLcwAaf0oNfApW/fxf3MTQohf7wEkmcEvkyyS97Jsi0PzuABrJ58dlBcFBZxhV53T
         WAJmcXc+d8SJsZVSfmflAL4odEzSD1TXPEpgMPOzm7h6wl1IJ/BDoPfaFUuz7XeBqfDZ
         ahq4fHQi6HmkLqUPFvle3S2UFblq7/Z3D2hmVa/g0GbZ2yPJeAa67kOxScRNRw4dX6LF
         YlBVhfUTs7PJ9zrJyixf52ckGWCnrjwpObZiEMAPIEZh/x+7143RpFqNBM84d/5EbMyW
         822g==
X-Forwarded-Encrypted: i=1; AJvYcCWgtzxKZfWCACnWLuIp0SiTvaA+/QkiAPTpvtbsop2z6SLaJuiUcJ4WFgvXSg2cPIC6GdJO5YdDeJzgBP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjpqrwDZOkvM3QKOyUfB+JCdQkwGrz/lTqariM/DIg33y05dz
	rkmuUt//wT4uyjcoxoDyDdovUxZFkiRje28CuN8of1JAh/iwuxJQeNhPKQ8PMKMUtzdr4I84KRo
	lKxGISFM=
X-Gm-Gg: ASbGnctad+dHKItM4qEJ0M5o2hBCy0f8/4W1trw3YBrMOtQkoZCoRzCLHDz0hVcqh+r
	7I2Ve76wXjSaCGbglMPDYx/cA5PocSljvTQnFyLPORxhLn9UGTs7eWlCwnwlQm8tHrqcqbwkwmU
	9+1ahXBrv967G/2VQjsFXFU8BLPCJmK35Mos42wP08DdPALkSJtN3Tyn6x7N9lGoCRGOG53c1kQ
	J/fhHqGcB144GK09PLkWPsZ9TbbeC/jS9dBYJdCM66B3Dz3RS4zuXVsO09s4M0X22SlhZEYqqil
	ogPlU5DBPeRa6Eme+AUByCsu8lOel8reBPHZ0SpzTh0GT2hrgbSgHJ64xw3J/OQ3+bJOYfT4efu
	e9R42Dui77QswCVMzA3vexmIOXS6uOp/sZ17u/ykf/MEbuoBPTskdNisaBazkzkvqDZ3Gb5su
X-Google-Smtp-Source: AGHT+IHVrIC16M7LYWkIFKODxYrHDlTyCdAwVsVAjW0q9t/fZbuHstW2VD1TcHZPRbOoTztk+P8mkQ==
X-Received: by 2002:a17:906:6a0a:b0:ae4:a17:e6d2 with SMTP id a640c23a62f3a-afddccd62e8mr40612066b.24.1755558064336;
        Mon, 18 Aug 2025 16:01:04 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce72d7fsm877763966b.45.2025.08.18.16.01.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 16:01:02 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b654241so8360537a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:01:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVh9o7MqWCwBTme17DCwJ4UkHZYq05UJi0MvwzYJdfdIQioPZNlMjPzhJOFSlmSUm63KI7w//DrwUbqOzw=@vger.kernel.org
X-Received: by 2002:a05:6402:210d:b0:618:3a9d:53df with SMTP id
 4fb4d7f45d1cf-61a7e747c19mr213830a12.17.1755558061328; Mon, 18 Aug 2025
 16:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813150610.521355442@linutronix.de> <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin> <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
 <20250818222111.GE222315@ZenIV>
In-Reply-To: <20250818222111.GE222315@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Aug 2025 16:00:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvSAi1+fr=YSXU=Ax204V1TP-1c_3Y3p2TjznxSo=_3Q@mail.gmail.com>
X-Gm-Features: Ac12FXxULL4QK8KXBA50iu4xiKeMFDhhLCw9cvXUyNBQ0OP1pxsh2LoxfQt5QCI
Message-ID: <CAHk-=whvSAi1+fr=YSXU=Ax204V1TP-1c_3Y3p2TjznxSo=_3Q@mail.gmail.com>
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked access
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, x86@kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 15:21, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I suspect that folks with "goto is a Bad Word(tm)" hardon had been told
> that goto was always avoidable, but had never bothered to read the proof...

I think it's just a combination of compiler people historically
finding purely structured loops easier to analyze (back before modern
things like SSA).

Together with language people who wanted to point out that "modern"
languages had structures loop constructs.

Both issues go back to the 1960s, and both are entirely irrelevant
today - and have been for decades. It's not like you need to actively
teach people to use for-loops instead of 'goto' these days.

Now, I don't advocate 'goto' as a general programming model, but for
exception handling it's superior to any alternative I know of.

Exceptions simply DO NOT NEST, and 'try-catch-finally' is an insane
model for exceptions that has only made things worse both for
compilers and for programmers.

So I do think using labels (without any crazy attempt nesting syntax)
is objectively the superior model.

And the 'finally' mess is much better handled by compilers dealing
with cleanup - again without any pointless artificial nesting
structures.  I think most of our <linux/cleanup.h> models have been
quite successful.

                Linus

