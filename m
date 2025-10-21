Return-Path: <linux-kernel+bounces-863220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3EEBF7469
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48D404EE24C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2954342CB5;
	Tue, 21 Oct 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B25ymGk8"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB40242D7C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059681; cv=none; b=h7Vk4bd0Xg3t9dJ4nJf6rQGOQm3VE1druUxm3Kfj8BrhJdiT9+I8YJGWD0XvxInUh7UiYc4kL0VXDQ/u3JuBo8JKrA8K4WROhx2y7oxKTTTG/panfqvMhPajGBm47tvmBIOrD7QTdazd1UV4sz3o03u7y9YGd4fB9UV4kJtK9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059681; c=relaxed/simple;
	bh=OBPNoahtqLQlrv9m+tCXzf5F3/neltQCeKhi/sO8Jc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIVy4X+tJQlu8cZ1yotHlTzQRlOojbtnHNU/+nv1LQrAqjjuuqouXI9BGY85lBNcI+WVzaYGBJ2YmDaiEsLDJh/USyMFqdwbn5hwRI1Edw7IGMlrX+rQ43VY+7CfCgD8AQ4BDq6Yl0PzB0aA8W/aa8EUz1ySN18ERE/KEKQw4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B25ymGk8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3737d0920e6so61452311fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761059676; x=1761664476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5p3iIWVRp3NUhUS8ltDIPiH8ErmpKdyMg8XkHtjDt5U=;
        b=B25ymGk8iWsDLc9hW5nIT9P+Q1povWBQK0/MsrnrEbetCc984A4uWSm/rB32/7oQ+F
         JWik7xXD9PqXRdXTBZW7FVcE5X+bmTw3KljPv0/P50sr5GUsldV8kben3tDVVzY3jzsy
         GitDCmd7Sdn1utwfCg8r0lfl2AhA5FooT4k3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761059676; x=1761664476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5p3iIWVRp3NUhUS8ltDIPiH8ErmpKdyMg8XkHtjDt5U=;
        b=L+TURSO4bfhmLdmU4S4TkfRHFLIC1uMY0DUKaJblHNTcyoINDVbMCzynhrbxqaQCFd
         79ikPhz+/+/zZUl5apWPinVHEGi9rdnN3czYK+ODyJx85zXi8z42Ig+kBWasivD0NvpE
         eGNNmA5h1EQ642EmTPMfdeyqW5x9tNwVI+6Y/faL6FyDNxgwB03+kqdnHsPcMGnSUGyW
         n+vvH9tAkoL4Qkowgr3embZPg6m75BNwHlWqa0TXcW0lEd+D5fJLYuGFZIsSIit8xnIz
         pRaeh1wnOJmuYQukaWVN6f4EteJSdU6c/zjcD0qjWFdFD7fsV67CePRdwRhXMXDtRiRr
         ViPg==
X-Forwarded-Encrypted: i=1; AJvYcCWazefryuWnIV3hGAMoVJ9QVA+MyQOyrt5soqzEeUJwhKixQJ72VxkwSGZ1MR/Av1OPJKUdqa7DeH602sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR890kIj/URPA+nmjsjvZxMo1wGKZmJIoUN8LGl7VsFyZ7aomN
	PWCwfIpoNbEx8EmUY8dZ2S57cFScOee2trg5rf0zOQvLVxz9Z0Ir5F42BYxi2lAbFsquE2w98yq
	anRZRhMA=
X-Gm-Gg: ASbGnctNjPkzoqbVIjWDL8lpKjApOho7YoBIJDdLnWuaM76//PLPKaKeGLspLMiaV9G
	STJxJvEFPJV/n/zlU8lXV/iSNhv8mYVfEScrkTULeTWR69OzEB55ZgCq86d47pdVgjohEeM8/YM
	4yNtmRQCK3dyAOXuxlj/8I7sa0R1nF6/2czyl1rmbSQMqrddEmo9NKwE39yJN1bpLwMzwZFpEip
	EZnOhTFxG0w+g68I4QlFIrCTg9jRchuygzuCAPDc5+U/+35vJy2E9j7rDRE2YdRW+EZVPR2zZOj
	xnMcR2xtROEXUsX50mCzeeDFBZriQDRhhbEY6ZMkXpIhYjzBbQ8oZIMDKEBHzC9EiRtJnKusvXW
	2uyuDAsrl+jkgMpHstHb6XuLdo+LEn9Fs4dSZnS64nGaKj9E6WpDWpGYbCiNYc8zvBgZv1xFIsC
	eoQ2YFdcYuGOoywbn4zya22+xaSL+1hxGsvk3IJKzQx0XKkLIqhg==
X-Google-Smtp-Source: AGHT+IFEdFLCWSHJB+uFoviKW+c8pHE/NrB2nydKFCgH5NnreuqkY44/nj7Zr5KyDpDFW0dzWJm2jA==
X-Received: by 2002:a05:651c:b2c:b0:36f:77e6:d25a with SMTP id 38308e7fff4ca-37797a8fa40mr54237071fa.43.1761059675564;
        Tue, 21 Oct 2025 08:14:35 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a921ae62sm29905631fa.21.2025.10.21.08.14.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:14:35 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-579363a4602so5780262e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:14:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCBbEKkHSqRLycxARxDlaiqLTaeyLggXkJW4L51PuHC8osHU+f1TRIYh5gfTlApHfDk1nrrFoDPaI9CTY=@vger.kernel.org
X-Received: by 2002:a05:6402:1ed2:b0:631:cc4f:2ff5 with SMTP id
 4fb4d7f45d1cf-63c1f6c39a0mr15531402a12.25.1761059216055; Tue, 21 Oct 2025
 08:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017085938.150569636@linutronix.de> <20251017093030.253004391@linutronix.de>
 <20251020192859.640d7f0a@pumpkin> <877bwoz5sp.ffs@tglx>
In-Reply-To: <877bwoz5sp.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 05:06:38 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
X-Gm-Features: AS18NWA4hFVtubdvPHiqdyKph2ZRKrwMfjnw6C6eEZqbhQOMaKTPF5q4gpdDvSA
Message-ID: <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access regions
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 04:30, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Oct 20 2025 at 19:28, David Laight wrote:
> >
> > (I don't like the word 'masked' at all, not sure where it came from.
>
> It's what Linus named it and I did not think about the name much so far.

The original implementation was a mask application, so it made sense
at the time.

We could still change it since there aren't that many users, but I'm
not sure what would be a better name...

                   Linus

