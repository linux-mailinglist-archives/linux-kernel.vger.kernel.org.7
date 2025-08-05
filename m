Return-Path: <linux-kernel+bounces-756831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6CFB1B9F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA3418A14A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B055B2951DD;
	Tue,  5 Aug 2025 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HIVF6jFi"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC354F81
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418160; cv=none; b=fUlZMbsuq66KBV7WgeDRaB6PBltqV7CuPQGSRihggipf31y9lY33/Q3+N4JAXZ3jMtzHBxtnoOq4t3ShwvduNZRpFlfeEVSIPtPhz5j98emj5Ygf52/t0ELcLEctGQwhwdVq7m3PX6LO7oi8jN93lDoc5O/82OZKOzZPBJtkRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418160; c=relaxed/simple;
	bh=yRwKa2dpxZLra8wGKZ7T59g5/UHIisUODlygBYDlzWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV7Ga0BAdHPiLwZkrrO2O4DJiRDsBtW96DpM77xPGL4i+hIgOHVTWYl1Gp4OsBQ9jN58vcSQP1weSKbRyqYNGeEZSmn+kR4vA1Hkb/AINGqc22TAfQl5e1549qEVBTvWhsc+f5ISwBvTf66Mm2vMai7syU9diQhckxv+c5rxRdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HIVF6jFi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af96d097df5so443814066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754418156; x=1755022956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=raX1gawg21AY9SOkHHAfr69KGWhZgSSn9UJ00DFOtpM=;
        b=HIVF6jFiws0PRns1DZy4v6UD9LEb7OtusRuMoq/zgX+FKMeWxZCPEaH+l4x4kOCvLp
         dgOo/cNLGqYpOwtfl//JMPWtE2Ptcx6m/KzJ7FJCsviHxdtUUzB60Z/xKbmg4qJlzqC0
         lHBPx4YwjRZIHiyzNW0BMzUjCbrLBVSYAmRXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418156; x=1755022956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raX1gawg21AY9SOkHHAfr69KGWhZgSSn9UJ00DFOtpM=;
        b=IDVTqowIDQTfEvPOcpHqceuadOAlWNcFb9C2kwASZUZzr1CsnzE6fRVkUJae34AKUj
         JMrpeP2u1Ep0VBdYVI+FgIN56xsA8OsPGXp6a2dZsrUEhfOpZ4JDOvwuiP27oYTaFWL5
         VF+lcaDt9YIIar5wK0KsedwxKcE62Q+9rihJPWgk64rxxK5tcHHWQoV7wPJLwJVfdwdc
         AcCHSH/I0qcyC3HnzwHZyUzw+1CFQfyMW3WG4kdjgiotFQL7q6nnKeMfuSmHIB+AoqQv
         BZiQBPoLJx930jan5jktH6tgbMLsGzEurzPZCTiJWtweh5WM5j5g9F/gO1OgyIVbVnlP
         5oLg==
X-Forwarded-Encrypted: i=1; AJvYcCUc8RG+wHBVDcB/+yfotE2qaGxEJLry/q/DYar6FaDg+r0Dtg2/TZlVhW8Ur/sn0+7YHJ/w84VP2D9Rh5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOwaPmnwQgF+mo1pqtzwPKvUZQjlDXYCXffDlgzbWW8UvMUs7
	Y09LY57ziU5uq0/kvQQkMgwlAiwirq/lSJk+9hwNJLPRP8SaTmGKZFMKv9ivarhH6EOPU6Sl1uX
	rFv17G61+xw==
X-Gm-Gg: ASbGncsOT5fNC/6iiLglBL+cjwJEBd74rX9bklYi5kqlF5cbqsu2mE087H/OsIz8HiT
	7ZbeMrt6mySfTHlyKAznblYHmazKSsGVeBmFf1mokxDUdFNpxVqDuhuOt2yANqOVZ72s1vepTwK
	yZ9E96T0AaoTKTnUXWwutrbAt6gY0WCoWegZSqIBa5vlRz+oMokgnMihYXhkF9b5uQ6y6ZUhoiD
	4kjdOqyobxdVGnCxG+N0Ds7xSCcAi4ompoK0gpZ6ILb9BPgRADuISbSZweD5kUmNvxen70kIV9c
	eqvCEfw7DXRmlcA/77rr8QsbHwBFuv6Vy9zS0wc67KmxVA3tQr32Y+otWVnyNx3hBeMB8hC+VAf
	4ZihRuSUL8u/NJT2DQbwPtbaGWstKbqSzl1qjI03l5ebxUI0OTgZ0JzA7McupS/9hXeWJStB3o8
	Y1MX3+sms=
X-Google-Smtp-Source: AGHT+IGGG+h0NptbyvgDSNI7nUPdqWXeTqc2ZF3OuuxTCDxDePnSh6RrfjyvHm8AfjmQ98jK3cu2RA==
X-Received: by 2002:a17:907:3d55:b0:ad5:1c28:3c4b with SMTP id a640c23a62f3a-af990389045mr2942266b.52.1754418155863;
        Tue, 05 Aug 2025 11:22:35 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c157sm944297266b.100.2025.08.05.11.22.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 11:22:35 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af9618282a5so587981466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 11:22:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWW9bEzkmohgnuAdpBF9L+lx20wN3STFbbvavWSQbggLpJMYRfDZ3BEgJ187vGC9NkoojWahm2tjlgjBMU=@vger.kernel.org
X-Received: by 2002:a17:906:dc95:b0:af9:14cf:d811 with SMTP id
 a640c23a62f3a-af990078cdamr6855866b.17.1754418154788; Tue, 05 Aug 2025
 11:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727013451.2436467-1-kuba@kernel.org> <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
In-Reply-To: <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 21:22:18 +0300
X-Gmail-Original-Message-ID: <CAHk-=wiQ0p09UvRVZ3tGqmRgstgZ75o7ppcaPfCa6oVJOEEzeQ@mail.gmail.com>
X-Gm-Features: Ac12FXyErT7ozxXaXNrZo7vnN1O87X36CHHYSSDaB5dnqnfCuIGERvksssGxq0A
Message-ID: <CAHk-=wiQ0p09UvRVZ3tGqmRgstgZ75o7ppcaPfCa6oVJOEEzeQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.17
To: Jakub Kicinski <kuba@kernel.org>, John Ernberg <john.ernberg@actia.se>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 19:22, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 27 Jul 2025 at 04:35, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Networking changes for 6.17.
>
> So I found out the hard way while traveling that this networking pull
> seems to have broken USB tethering for me. Which I only use when
> traveling, but then I do often end up relying on my phone as the
> source of internet (the phone being on the single-device flight wifi,
> and tethering to the laptop which is why hotspot doesn't necessarily
> work).
>
> It *might* be something else, and I'm bisecting it right now, but the
> networking pull is the obvious first suspect, and my first three
> bisection steps have taken me into that pull.

To absolutely zero surprise, it continued to bisect into the
networking pull, and this is the end result:

  0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f is the first bad commit
  commit 0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f
  Author: John Ernberg <john.ernberg@actia.se>
  Date:   Wed Jul 23 10:25

      net: usbnet: Avoid potential RCU stall on LINK_CHANGE event

and I'll test with that just reverted on top of current -tip. But it
bisected right to that commit, and the commit certainly makes sense as
a "that could break usbnet" commit, so I expect that the revert will
indeed fix it.

Considering that I will need usb tethering while traveling during the
rest of the merge window, I almost certainly will just revert it for
good tomorrow, but if somebody comes up with a fix for this that
doesn't involve a revert, I'm all ears.

             Linus

