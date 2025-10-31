Return-Path: <linux-kernel+bounces-880459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A8EC25CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FED6188991E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A128D26FD9A;
	Fri, 31 Oct 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei/9L18U"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F931DC198
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923621; cv=none; b=YtuHmy0S5pExoe5o8yW1lF8YrcMA6tJz5jfu308nZhjhQhwFqPcYHv9MvKzW/eopB11na7/Y15Fj7bJl2IYr/ObjL5ckDkgyGBB81M7UyE0xRsAFmEjxgEXxs1GI13Lq5hKQqbxyVLU1d5KD1z7+UQE4VySY8c4qmbHSGPIfN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923621; c=relaxed/simple;
	bh=uKzyL+jmwyriXmBvdMLiERXr9o5a0ykNZSCadruR89w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZERd9ovjdanY2qujgBBWX0OWDy2fUQgFLVNs1tf2Q7mwJCjdZFFfUIbpFCHnolMNbfN+X11vfturlDwJ+YJJxnPZl6rn9xMYw3jLfo/QaLA5X1Vvgn6FejlEuXR13EVYV+EbeUTq16FczIlCtXH8JZT4tFq0S8xHg0lsqUyF0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei/9L18U; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso512524066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761923617; x=1762528417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKzyL+jmwyriXmBvdMLiERXr9o5a0ykNZSCadruR89w=;
        b=ei/9L18U5HkAuC9pc7V+xpXWsUgxKwYYi76s8mjMJOfjpKLNPLrG1xRUFGf6ZM3Vg/
         PPzWJHhyzrdZHoIfAivQJRkY48f04jO7pvm30/huXE8fAauISJbBapC4GJ8y9rkdC3yZ
         G4GbO705BixBaKye/Cd4CYUVq0FOjFfnEe/C3O+VjFGb77lpwz03E2s6SqtQ4PUrsjKR
         +ravYwt74R7uuM0gnIH1BT5tEeOU9Tu1DJcWw2ow0d+hc4zkp19JMH16HlAa72LEVRgJ
         CCEEHUYRZBc3972zh3VVFxySnZ46+evH6rwuXYZ60dn81RL5VUw3NMNrFedjr1K10CV8
         gjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923617; x=1762528417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKzyL+jmwyriXmBvdMLiERXr9o5a0ykNZSCadruR89w=;
        b=cMDgEVY7TV/VECfnXNSHrPligEZfCc5PSY3vThIek5aT8xpw/3zjfSgBToOAYOusY2
         A4nZeLMw9Liqz0xBkpkkcsITAx5XWs7Qnm1564XJcJ3u1ghvE9UBUDgEHEj6F/qvC7H9
         aTC9qvb8opMDzhwbqw5wBYVG4z71DiZjd7RvXqG7jU0EDV8P66YIFvcS81r6j10CguEX
         2pn4Y7eRRZyFtSnBD6WUZ00CAxDYi/1VGSqe0dY40lL3YISO6Y2KilLGVWKweh9h1EH0
         KNivgQ+AOIpnO6Z0ANfzDRSpmXEvS1Uni+av2v5kTkvEw35sHOvd8zmyPJ3KvJL0zPdE
         BJBg==
X-Forwarded-Encrypted: i=1; AJvYcCWpMGbZyRCdmz5jypJL0183h2xTLlRxw8w+1CT9PjmZiF9KE6lUFlaSfM8dKHSR2zug2dCwk0A5wFCTdtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhxiHGkgPR1pxXAZbPnXdvo63ycUE1yXD5f6GnQx9+IzB/Qrwq
	DKAWsG+hCfUFXVLGGfxDhCHueSV9LuaxL/NrQRnKz/cmk2viZpkxXzuO2rWWdvH1eMr6FxtZFfG
	THx6J4AHEmfQrTvWf8sf9xAxWj9/xsU0=
X-Gm-Gg: ASbGncuWA9x0SFcTZtWgvbK9wo4Mr4+Ilbg961sl+nX+NYh+8orNwn5G5ehC7KyOQ/a
	jTKDk6gcGADiey8l7deAX4kF15BqbXiRBFziiOFnwLkzZ+wOkDBENr8xRsdMceDcdvTHeJdxqE1
	h21x2jDG9y22EJMdaT/ujfxfVtluIDKmSJS0sEJg63fbrJ5Rok6dN9hVoHthZY521I6021KVMfS
	lfNMCwgISlvnuCHJPYfLHdSwT1ft84dG+l+8ultIJxfBxHzxsnfTFpOu/ORQUtGME2FPuqYjdVk
	aZ14qDiuGOTr6bcRPQOXJbYUgA==
X-Google-Smtp-Source: AGHT+IFi6RrdmaEHmhz0DYmgTu3lth1+AIc+wR+yR6AFvkMfxIA2Fs0w32EasIWGWhuV3loaspaSUVluO52UjOA6gbA=
X-Received: by 2002:a17:907:72c8:b0:b64:76fc:ea5c with SMTP id
 a640c23a62f3a-b707082fb5cmr400438766b.52.1761923617081; Fri, 31 Oct 2025
 08:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
 <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
 <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com> <20251031-liehen-weltoffen-cddb6394cc14@brauner>
In-Reply-To: <20251031-liehen-weltoffen-cddb6394cc14@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 31 Oct 2025 16:13:25 +0100
X-Gm-Features: AWmQ_bl0QFNEHVEZqDt4NaeU-OmVLetqVQSG0lX8hIbhRTQHi4GhBcBiGlX77rE
Message-ID: <CAGudoHE-9R0ZfFk-bE9TBhejkmZE3Hu2sT0gGiy=i_1_He=9GA@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 1:08=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > I wonder if it would make sense to bypass the problem by moving the
> > pathname handling routines to a different header -- might be useful in
> > its own right to slim down the kitchen sink that fs.h turned out to
> > be, but that's another bikeshed-y material.
>
> fs.h needs to be split up. It's on my ToDo but let's just say there's a
> lot of stuff on it so it's not really high-priority. If you have a good
> reason to move something out of there by my guest. It would be
> appreciated!

I slept on it and I think the pragmatic way forward is to split up
runtime-const.h instead.

The code to emit patchable access has very little requirements in
terms header files. In contrast, the code to do the patching can pull
in all kinds of headers with riscv being a great example.

While I ran into problems with fs.h on riscv specifically, one has to
expect the pre-existing mess will be posing an issue in other places
should they try to use the machinery.

So I think runtime-const-accessors.h (pardon the long name) for things
like fs.h would be the way forward, regardless of what happens with
the latter in the long run. I'm going to hack it up later.

