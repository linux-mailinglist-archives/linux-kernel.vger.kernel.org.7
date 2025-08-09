Return-Path: <linux-kernel+bounces-760932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30EB1F220
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 06:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6C31AA0C58
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 04:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E023F1BD035;
	Sat,  9 Aug 2025 04:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HAOKlaj0"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA961E4BE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 04:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754715534; cv=none; b=R1sNEz4H35zrKMxwcDJjxhlLxg6EdaOcv79CLN74U4RF+LZ5j3754fiEGuqpCXHze2Gl8fAADQd6Kapy7AvO3vNOUowN3ZPbdKvWk/aQ9DUIEUybywSLqyQhUjNyIJcF0hyM2lvQzMbLF4hdKvS844bluVTvOOU95Jm5UZsY6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754715534; c=relaxed/simple;
	bh=hWzJJhZnpuNl+t+epWdTunDjh5inIwD3tNoxQIUigQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KanbxDwcwNXP4MUurzTrxs5QrDcn1qrx+LaDOdCeTzErs8hzO9eNAvnIwBVHo32thJ52Be0ZJYlqTAX7sZu1YoHE3DpIbBBtAUuI57D1Z74QEXJvpRLHq30YO5SD7pEXHuI+CkVIorL5qsDxIGMENlw5LaGjdvY3DYLeKYzTjhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HAOKlaj0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af949891d3aso387234966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754715530; x=1755320330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=at1zhscRtEKfmJ9O1JFBsDnAS0TG5AN6PuvpSo8Km/o=;
        b=HAOKlaj0WERdMxPYiUX8VMKaRNVAi89EkbCB8GaqHpFmagWl8VUvk9zJESUuQUgydu
         D74Xn+HYl0sCNLbtlQirZVrwkvXA2d4TWmtr+ZnLzkG0pXM50gx+D9dRPXxzmMxxpMaQ
         cLMs6/4sXFNYLpsWud5I/nCcJMdhVczaenouM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754715530; x=1755320330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=at1zhscRtEKfmJ9O1JFBsDnAS0TG5AN6PuvpSo8Km/o=;
        b=OQwAMRgO8W0jrqpBGopz12hu9erThcQucM1HA+ffiCaz+ZyNccOB+TA51zr+N75dMw
         JjG7ENnA1+zjaERlRyoC56qPLc+I7uArWgHaMLbqkdaGz7lIKQz85islcDVxC3ISTBLD
         4f1ZnQFJFVI2GmONunFevFkGPf3AT2faVI7+g9P8Yd0ZsbmDV/UbKIohKzM3kCXp2rS6
         WZsHYYgjrro8LzKbxjQsEC/ci7ohm1FKJLhzO+BZly2Nh/nqYfdK01Nj65AiB7m7gk/E
         S3CyBKiB88N0H2lKWIeSMtaPXjx4s2rFHIOAU+WkebHH3u3GuMZahLbt16DRnPgox+49
         khGA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ51RX+b2ptmQol99elMErshv75jsmd4ogxMlvgahG2/O68vsdV9r2WvFPk2hg2m9IxQXRwOERpShmQb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLYNc0aSffOcN5faEQ7F+GpUthpQvjlhi4qvMg8533LJiFkOX
	/VCm/obep/zVueWq58O8VSuW1IZCu/y1lBHbFTwhbiFbnMVNuzX/3GMbGxXw94MYt27fyNctOYi
	VApiMTxPjqw==
X-Gm-Gg: ASbGncs3HEkWgmLnQeA/DGlsrz4UuplkQA2PGQ7vxz/zfdCiRd80mJRPxyxAfTLCmnE
	1aWS40qdGy7fpswTyLA5yTTkKtgQ5K9Te50zpCbSLeSuF5QXHdnPAW0HL/H+0WvxW0iea26HiDv
	gzXKs8t+zYVhv66hSducCka5l2GMiwmUriQQ7CvKE0uu0yKK+7MndbqNHHtzp6BMDeI4FbQ1P9F
	77uCJkr5GYBIGicp2w3JFzTk7O1wvVqZA63rCtejPM6CEsW6wo/LxCOoZ5cg4loGTqyi5QBrgd/
	MGJf3vKtAVMkt+tUSlgTUIcGzmh2o4DCt6vknJ2f0zhRe0EuO0GNmkLyY78HwV6VsmBkDy7NpxJ
	jE6cMx3dxTckD45Qy+tecVIgpKT3H1SCmp5PApotxLICGpm3wvTFPSbdRr0sOz13TJjhDWjp+
X-Google-Smtp-Source: AGHT+IGg+A3Es7wd2Rb8jHkpFBt0aMOiOOMhaNYd/J/ve+isQvTHJ8Cswy1lIpArcef4ZyPh6DvsSA==
X-Received: by 2002:a17:907:6ea5:b0:af6:3194:f024 with SMTP id a640c23a62f3a-af9c6370cc3mr483344466b.13.1754715529940;
        Fri, 08 Aug 2025 21:58:49 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078afbsm1599682566b.4.2025.08.08.21.58.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 21:58:49 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso4182881a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 21:58:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnkSDKLWD40BEozBKR/S1PcyR3hgbbBq3Tml3IfzHMf0vNAaq/yuqkiN9RfPs6sbdtgbeVE8xI287W1Ds=@vger.kernel.org
X-Received: by 2002:a05:6402:5251:b0:611:f4b2:379c with SMTP id
 4fb4d7f45d1cf-617e56474a7mr3487462a12.20.1754715528810; Fri, 08 Aug 2025
 21:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mhng-7755CB81-B0C6-42D3-82B5-CE37669F176C@palmerdabbelt-mac>
In-Reply-To: <mhng-7755CB81-B0C6-42D3-82B5-CE37669F176C@palmerdabbelt-mac>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Aug 2025 07:58:32 +0300
X-Gmail-Original-Message-ID: <CAHk-=wjLCqUUWd8DzG+xsOn-yVL0Q=O35U9D6j6=2DUWX52ghQ@mail.gmail.com>
X-Gm-Features: Ac12FXzevhMtU9rC4l8wI5Rp-sBEnJ_jj9Gsv-onhS1DzwjKacJE8hz2OkVlG0g
Message-ID: <CAHk-=wjLCqUUWd8DzG+xsOn-yVL0Q=O35U9D6j6=2DUWX52ghQ@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 6.17 Merge Window, Part 1
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Aug 2025 at 21:19, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> RISC-V Patches for the 6.17 Merge Window, Part 1

No. This is garbage and it came in too late. I asked for early pull
requests because I'm traveling, and if you can't follow that rule, at
least make the pull requests *good*.

This adds various garbage that isn't RISC-V specific to generic header files.

And by "garbage" I really mean it. This is stuff that nobody should
ever send me, never mind late in a merge window.

Like this crazy and pointless make_u32_from_two_u16() "helper".

That thing makes the world actively a worse place to live. It's
useless garbage that makes any user incomprehensible, and actively
*WORSE* than not using that stupid "helper".

If you write the code out as "(a << 16) + b", you know what it does
and which is the high word. Maybe you need to add a cast to make sure
that 'b' doesn't have high bits that pollutes the end result, so maybe
it's not going to be exactly _pretty_, but it's not going to be wrong
and incomprehensible either.

In contrast, if you write make_u32_from_two_u16(a,b) you have not a
f%^5ing clue what the word order is. IOW, you just made things
*WORSE*, and you added that "helper" to a generic non-RISC-V file
where people are apparently supposed to use it to make *other* code
worse too.

So no. Things like this need to get bent. It does not go into generic
header files, and it damn well does not happen late in the merge
window.

You're on notice: no more late pull requests, and no more garbage
outside the RISC-V tree.

Now, I would *hope* there's no garbage inside the RISC-V parts, but
that's your choice. But things in generic headers do not get polluted
by crazy stuff. And sending a big pull request the day before the
merge window closes in the hope that I'm too busy to care is not a
winning strategy.

So you get to try again in 6.18. EARLY in the that merge window. And
without the garbage.

                Linus

