Return-Path: <linux-kernel+bounces-838255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15732BAECE5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC843C3D91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DA62D2490;
	Tue, 30 Sep 2025 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TcpwUp1h"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53712D23B8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276427; cv=none; b=TQsnwf0UKYiLPPNGo74bXq/bJypWpTlYcqAthacsXZCnUQq/bd2HEbnyQUqm4nQBMOlHxc9bv/HO3rvtoBZhCous/jdAzkfg/IkzI1xqagx+ojJXh/AXcDAO6ZDHSjfh2stDHWZ3jQ4Mq7a4zD0fSMaY99oB6huK1T29iWbuO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276427; c=relaxed/simple;
	bh=KspN55AmLndTjpqHaEhY2luUZ+bgeTgMVxnjZBlfuH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmE74dz1a8RUZ6gUjOjsVBtkjhXH5XHJH/LMqyUfcvZZLN3oV4P3KnoA2SFZDOR+dehASxy5feBPJ20Xn1ptndvG2/WHOlD1X5rTqqpGWtGmhsSOnw3NWcOImNEmsmH8+PukQrzxLU9LK7x6MPFi4mQVFOoI9CC/gWvbAGJ19QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TcpwUp1h; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6366b7fd337so1998158a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759276423; x=1759881223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h3FgMGsAF0plFk4zuPYd3xzqTmZvpyQhfjL8rI22Lo=;
        b=TcpwUp1hf5kZXlyFuHzugx63fHJQT2nRQesCWuNAaT+s+1o0pfsVUdsc3kCKYt10ta
         6bAbd/2D8uMROO3uWdl/GclX4g8Onbswt4rkwLfKslXUfJjEc5gtwgHc7KvY1MxKlvAt
         tbiGvcTG9PhnmefXjY9BJT/l4NSGSfPdMoR3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759276423; x=1759881223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h3FgMGsAF0plFk4zuPYd3xzqTmZvpyQhfjL8rI22Lo=;
        b=p3d2nyZfN2dQE1WVU8rKY9ytbCNKr2z2GJVeNdv3UI5vYl6wWpPqxn/21d0u9bYTVI
         wvpNL+dvY5YA/m0d0Yer1TlGLVk0h9cS7ujbbU2IZPbRVXc/43e/rSmOd2llFgsjEsnC
         LXDMZMLxG0JE1CT0oyYpw+jridGaxqk77/QVN0ewhk1YxM8e8YHXjuZ5hRCVmfltKdzC
         hMOHi01sIPoJaUyPjZlXl9td5ZnaMBuY5alhHiwjChqLRjmHX72fLTxyDYPNYICAQf5k
         h2WPxoy2wWZ4+8GeUdIHdGSiK28zRzWuaqHA8gUIMbzYzk9SDNTABSwrxVaTomJTApZy
         tn1g==
X-Forwarded-Encrypted: i=1; AJvYcCXbm/M4wrjJ+W6DgkfGgSFLWns6lfeiq04nrUHxUwjMQaDFM+n05KxOIlSlYm+ImnznLExe4hZH6Yrl7CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynSq6QdK1A9FqZCbsoRd8Y1PpwFvp9tLMEt6QZwrJIShGmA/hU
	/sWpNPExQwPm5a7KmQKTvXh4Qzn5FsbB6hyXkAhTJEOJ7GURWC8lpRE32PimxUw/Veet+WHbV5A
	YdK5dA2E=
X-Gm-Gg: ASbGnctipJdx5Kc6PBf/fz/x2odtYdnJKaqAJsPDyDf9r4uNNDRWLMhg9YDF2SQNdax
	7zFhVJ0vo4G8a/T9LWKhEn9/7dMyFheO45eGIRin3hqNLDWooOacO8nb4wRfXDycHfrmaQUJMF7
	24/esYlBDlud9tm6J9Lpxfe94AiE+EoXH7rCpanIZ5Y7Hg++pDafrtx392altHfBikDRUpK72RK
	a3b3t973v8VcFkYvhJ/mw2IFLHlwmpeFG13roMnVhBoxVdBrNkO/I0ptWM4+8Fta+3Gjv7s+/5l
	SknQutku7XSE7hpKi6MZZnK3eBVKRysI/kN6UMV26JvbjMnY66zxzkv0F75RXvnGxGdPrt3Xc+V
	/cJi0tvNrZShDQmdnR0vUbGb9XxEW6MoFVMxauuCrmZ0z+ybkbmnsEKVJYftMEmisM/LNCOSulr
	79W+GrLJrk9SzNVERjZ2R4OgPuIQWOp3w=
X-Google-Smtp-Source: AGHT+IFwU6RlX6RkGPBzGILYT1BoCl2ZFQVgy5tSCpKP10kTT01WNmidUw6kbyDUH3eHzVV7xL8WGw==
X-Received: by 2002:a05:6402:1149:b0:636:24da:490b with SMTP id 4fb4d7f45d1cf-63678cff0f6mr1365048a12.33.1759276422752;
        Tue, 30 Sep 2025 16:53:42 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629badsm10380195a12.9.2025.09.30.16.53.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 16:53:41 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so13087595a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:53:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq7spLbB83pw/vGJokW2R/SAt/PaLGOn1fL4lWur3vk0e6XSYCnhx9LEg33Fh8BG85f7y+8BJRvLMgm60=@vger.kernel.org
X-Received: by 2002:a17:907:25c9:b0:b3d:b8c3:768d with SMTP id
 a640c23a62f3a-b46e0daad49mr180171266b.7.1759276421427; Tue, 30 Sep 2025
 16:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
 <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk> <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
In-Reply-To: <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Sep 2025 16:53:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYcOiFvsJzFb+HfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com>
X-Gm-Features: AS18NWCgDHu8MuPyS-TiEIKJaGU60doaJ515YpT3XFOuRRfLKrmyR46GA4zDZis
Message-ID: <CAHk-=wgYcOiFvsJzFb+HfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Sept 2025 at 09:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh Christ. Is somebody seriously working on BE support in 2025?

Ok, I just googled this, and I am putting my foot down:

 WE ARE NOT PREEMPTIVELY SUPPORTING BIG-ENDIAN ON RISC-V

The documented "reasoning" for that craziness is too stupid for words,
but since riscv.org did put it in words, I'll just quote those words
here:

 "There are still applications where the way data is stored matters,
such as the protocols that move data across the Internet, which are
defined as big-endian. So when a little-endian system needs to inspect
or modify a network packet, it has to swap the big-endian values to
little-endian and back, a process that can take as many as 10-20
instructions on a RISC-V target which doesn=E2=80=99t implement the Zbb
extension"

In other words, it is suggesting that RISC-V add a big-endian mode due to

 (a) internet protocols - where byte swapping is not an issue

 (b) using "some RISC-V implementations don't do the existing Zbb
extension" as an excuse

This is plain insanity. First off, even if byte swapping was a real
cost for networking - it's not, the real costs tend to be all in
memory subsystems - just implement the damn Zbb extension.

Don't go "we're too incompetent to implement Zbb, so we're now asking
that EVERYBODY ELSE feel the pain of a much *worse* extension and
fragmenting RISC-V further".

I'm hoping this is some April fools joke, but that page is dated
"March 10, 2025". Close, but not close enough.

This is the kind of silly stuff that just makes RISC-V look bad.

Ben - I'm afraid that that page has "further reading" pointing to codethink=
.

I see some CONFIG_CPU_BIG_ENDIAN has already made it in, but this
needs to stop.

The mainline kernel is for mainline development. Not for random
experiments that make the world a worse place.

And yes, we're open source, and that very much means that anybody is
more than welcome to try to prove me wrong.

If it turns out that BE RISC-V becomes a real thing that is relevant
and actually finds a place in the RISC-V ecosystem, then _of_course_
we should support it at that point in the mainline kernel.

But I really do think that it actually makes RISC-V only worse, and
that we should *not* actively help the fragmentation.

             Linus

