Return-Path: <linux-kernel+bounces-774521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626D5B2B389
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE45584013
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EFC215075;
	Mon, 18 Aug 2025 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J7Ec4Mvt"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A933451D0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553015; cv=none; b=SIz8ql5WRRMLoO4tB2pfqmoWetzqVy0e+msCwwwr7z5z9srfrA6/snvxuQAUJxrWNcJ9VEHcJYJXWH77aPj0+W5mP4k/OIa1Sff5lGiu5popsoolFoE6ol+ylXfDkpkUSYA5W+zpy10o4Dh4KGyYJ09iFMuTA6n2ucguXEe1crI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553015; c=relaxed/simple;
	bh=qSXmxjkE7tWxGF9GYswWGcUoeX7dBav9UeXc81vA4C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXNQKICg+L0hKtmhO8R7L44hEtZcWSFqIhG/ePGDcMBQGg5xlpyuuBA8AAveHBRJWTSnqmwhCgUbb1lgz2ssSCy2DvABOB/pc9JMD3/geAFHTBrrjHmvAodQfS7c4tOJX/YvXqKlER+T/gHhL4A4NFBjp+8+grQ0ocoW2mzcm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J7Ec4Mvt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7347e09so743953766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755553011; x=1756157811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ6Xr/RwWLTuxcCIJ1FhU8AVBTTArUeQ/AN3U4J5Pw8=;
        b=J7Ec4Mvtfkvh2JkPL02eizTd+us1u4nL8RRyAQ+njST8t545fQiZpEfrBhdqyw3V7t
         IpSZTKjbiX6rhPeIjCEaAUXcyUSxiVPzEejrcgqPAvVExv1is4yh9I3Kk1Np5yDijFBd
         B4XYfMVpu0YouSVyVe4yygqAEo9UccIEnHNwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755553011; x=1756157811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ6Xr/RwWLTuxcCIJ1FhU8AVBTTArUeQ/AN3U4J5Pw8=;
        b=CRToVbMPF+lu+nuvp8k/oV9lZDsbzszZOyulreexES2ItuJjM9aSSXg83XVZX7MREk
         I8PwW6/0PCpWHEHhpefRM7u/qHPXCjmjdncd7m30ci8ighICKH8FfQqy709bKqNMeOsF
         iUyqgfeb70s9hU76CkfI0a4/Hd/eqWmDLP/iM2L+edmpDqIx149Nw8KhfCGbHkzIi61/
         iG1+AY7tIzIkV4AW5OYDPhpYOXRClQJWk9kYOOIgp/wz3eAQiQLhiwaRU5DeEaEt6TVU
         3NdZCxr6tCUtlPuoZiQxy+VAVWVRHABKTs+lcJf5Dv4qPr1Y0AtpV2JaKV8LCE2uyJkg
         ui2A==
X-Forwarded-Encrypted: i=1; AJvYcCVeMoKJY3hYsTe657e+y3l6yv8GwZA6LamedxHJQWc3w0PXiYp+8yyAckSYE4JTKG3qAI7OBc7Obo31Nf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BdBix5Q2c5vEtinwhy5g5McC+KFuVDNpWYwRQ7XC0Un6EbrW
	XXMdB4yUuvqz+DGyajWK1IWFASpfOks5+TxqO1hq0t0dL3Lr4rPNWpakTSpmpSqydVFpeg15sOD
	6jV4QuTU=
X-Gm-Gg: ASbGncuGSx1T6px2Q54DzA45s8w4YPsCXNCzoZvr9J6K4pmV8TplZoWqoPpwU2DkyWD
	WV2N6ZXx79Rb5XqFQbMT/ulF0R53ewPvQS07PbmMqH/s2+wD3itHd6rTHURtYlc+oXchGuD7XCh
	DE6VYu+iHMNbdIVGUhhHzH2VUBhDJR/ExT+OahRY5s/M8/G7OqttpAeDn6NJqXzfF3A61MOcOZx
	QoZsgEHGxchjH2uSWyuIZwe1cExNWWmX2PAO5gMmOxwjpyTTn+DWPCsClE8uAGwXw/tywUg/Izy
	vkbOtL+VhBRqrEPaq/IxTz7gnokLAEWS9TU5m5VvRdrvn/EvC17Wzxtmm+6BQQUAJapPklC4k04
	krUuU337Q60lj2Ajyt6dxvTxgqNB8ZTwpzwFVjKipDP6lXxFQyq/PT9fSmDT1FFkuuWLx05bMS1
	reCUaAH64=
X-Google-Smtp-Source: AGHT+IEgxceSM3jKOLFeaZjaqTYX5fkg+RDlfNMpw6k+fKmB6aEEKNH8A+TMJLg301T+9QGFFSsPUQ==
X-Received: by 2002:a17:907:6d06:b0:af2:80c9:7220 with SMTP id a640c23a62f3a-afddd0b5f4bmr25126466b.36.1755553010538;
        Mon, 18 Aug 2025 14:36:50 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01ab55sm870682266b.97.2025.08.18.14.36.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 14:36:49 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b7532f3so8319856a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:36:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaz40HU26JYFO05rFE0wOp13KHAracKTxqNZkTLX8yV2x2JLoRUTw4uXOoBbhnVuBw3P04FQiJ/uRWzSg=@vger.kernel.org
X-Received: by 2002:a05:6402:274f:b0:615:cb9c:d5a2 with SMTP id
 4fb4d7f45d1cf-61a7e737ccemr64589a12.18.1755553008944; Mon, 18 Aug 2025
 14:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813150610.521355442@linutronix.de> <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin>
In-Reply-To: <20250818222106.714629ee@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Aug 2025 14:36:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
X-Gm-Features: Ac12FXxf0x77QebHuGiALx_MGnJLRb3R5d6KhLXyrQWXnGFnx9g-2vQrxqt1ti0
Message-ID: <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked access
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 14:21, David Laight <david.laight.linux@gmail.com> wrote:
>
> Would something like this work (to avoid the hidden update)?

It would certainly work, but I despise code inside macro arguments
even more than I dislike the hidden update.

If we want something like this, we should just make that last argument
be a label, the same way unsafe_{get,put}_user() already works.

That would not only match existing user access exception handling, it
might allow for architecture-specific asm code that uses synchronous
trap instructions (ie the label might turn into an exception entry)

It's basically "manual exception handling", whether it then uses
actual exceptions (like user accesses do) or ends up being some
software implementation with just a "goto label" for the error case.

I realize some people have grown up being told that "goto is bad". Or
have been told that exception handling should be baked into the
language and be asynchronous. Both of those ideas are complete and
utter garbage, and the result of minds that cannot comprehend reality.

Asynchronous exceptions are horrific and tend to cause huge
performance problems (think setjmp()). The Linux kernel exception
model with explicit exception points is not only "that's how you have
to do it in C", it's also technically superior.

And "goto" is fine, as long as you have legible syntax and don't use
it to generate spaghetti code. Being able to write bad code with goto
doesn't make 'goto' bad - you can write bad code with *anything*.

            Linus

