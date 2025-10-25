Return-Path: <linux-kernel+bounces-870087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09249C09E12
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA7514E1CC9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136A2302774;
	Sat, 25 Oct 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZA+PHghY"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218329CE1
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761415007; cv=none; b=H1OWILz7SAONhI2iRPL5Ay30J2bazPA/QTxCWBEmbQuYEQMv09Zvf8OWc9by5pjg+GJz+yTL/aaMnh96uJGBEjY2b3OhV4JjriR4x7G3B/NdU4qYucf1iMAMdsiIEGsZ75Rek0gfrNM2gx4MdAl7k+XY2i7zbne3m1oXi7RSlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761415007; c=relaxed/simple;
	bh=1s3zZbXoXuXbG73d1ctMzMs4o4nY/PD3TwXtQ7vgb6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYe7Wm9uefMGgw9cE4bjveDOYaLZkCCrR35pWf8XgCaScruhgUMTWUUHYOMDVifGTmFthNaX4SHLb4hbbMG1ddrdaMPL1pKpg20ALettogO5dMSB8SDLiG3ia/aMfUEx1KRR+SexeTIwSROouWr9q/Vz6gzclANpysMd1MWh0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZA+PHghY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4539dddd99so667335966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761415002; x=1762019802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uIHoHfWwul/SDuhHqNAPoAHHQqzZBlgkrRx5b1EY89A=;
        b=ZA+PHghYTYHUd9Y/nrm/fT8DDBMlhjuKM8yavyHVYldvtQFwxcZ9oppSCqb0bt7jTK
         +lfViElSh8gVsFYcPPOsXBr6WyquXePQC7BOf908SBPYosQP26Y+7bBp8uZw2qjBOZOW
         Ru3HkV9IFq+8jQ5Fomc7igbSX4aGc/8LBTk3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761415002; x=1762019802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIHoHfWwul/SDuhHqNAPoAHHQqzZBlgkrRx5b1EY89A=;
        b=s+91/ZgRCdvFIYAlnYV36/Q+EZzqrq9ZEAoRhFckAjImSqYZEa3188LTcDYz7JXWHs
         fpWV2Mhah6Q2W601yO4GtxTcdcvmrIh1F0ijANu+JyoWfWyepUgqn02qWamdmbW8Vnbj
         tC7A7xBx1eT6UIDD3MNEX2LSXk/Wj9OtL4hh61FNxWFj9QuWckIJLf1SKlWzv5UNVpuD
         CBjBXszb36fnxck8BVb0Rjlve+LupEofW3/XhFx3ojB2dxV1ZCKGhpLlAP4vt54fJOWT
         1bvg/o+y5gnANSSxI6MupL7eEIhKbU0XWbGbI9zp9YRogtm8n1E99ERib1JU3CISdojg
         GPBg==
X-Forwarded-Encrypted: i=1; AJvYcCW0qKeOQVnbe0mh8kIXHrx1r1DP+uJ/Ja6t4pBtEDrhHlPiB4tn1PYGZnycUTEUOcerQRKkBCxBCKMxuz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kMsMxsznK/eGqgpiC87O5k26sPAqYMu6oInIwtMY6HW/7tJH
	17DrHIjmQo6MObhvoOrOjdfXgebZ0JWo4IQqSpqwuPh3CZKNrLtUfyxH0G6TMueeEc+/m+2JXNQ
	cuFPkXu0=
X-Gm-Gg: ASbGnctNt2S5r6vQO/Kz+k5re3ff1/BV2dnA94ne0vyO9bh98GT7lvP7dIBebCtv9D2
	ZuirQ1dWMzvDkN9ppX6aCzz2U505VY6XQ7UKZE9E4UDEI8ypiooZVvmX804d8dymrWF3vHiazmx
	Kz3s6g7UEIw1/V+hKYV4cCXnGHMxHqIWh+9CTKM1807ibiQlMlhyFh9udrrpj+molFhHmMf4+ji
	j8LUPHv+MZUXcDa0Pc8TuBSvIFohEz/UPVzfEnoWBVDLAzKPhM5tvhFvkf34QE2MsFq3ntV+TpB
	dySYnkwLpXOdugPUp7PWpUCyq/cLqakXxcLA9/+wrpk5cmzXQYBs1MXhco/f4WAQhyuUXhU9NCM
	1kS2XIgHoRqalZieXTaezmlEeoLSI+a380/mzjSxyHD/rvY8mkyWlTzNfVxUXPKZeZ1SfBpaEaa
	Oy5UncurvVnELoFHN6ueWQF1/M1wtcxe21IcrfXV86XVxE5CLHgYEewgU+yXNF
X-Google-Smtp-Source: AGHT+IHcrc+yLJUOHS46PCk6jijsLCVtSLqJ0Qx3tLkumqKA6tM5U/1nEZosmcRGMfwfiKWzvR4GsQ==
X-Received: by 2002:a17:906:c147:b0:b3d:8fe0:536d with SMTP id a640c23a62f3a-b6d51b0ac67mr1136428566b.15.1761415002552;
        Sat, 25 Oct 2025 10:56:42 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8530905dsm259908366b.6.2025.10.25.10.56.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 10:56:41 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso6940407a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:56:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLm5o/irMBFhAFUlfQuS9ywmHUb40vYUOicbpxycwSOt6b7nM17IDe2T3JKESCoIjHArBV9vV/l34SWqc=@vger.kernel.org
X-Received: by 2002:a05:6402:1ecf:b0:639:7307:2403 with SMTP id
 4fb4d7f45d1cf-63e3e10b712mr8410407a12.11.1761415001123; Sat, 25 Oct 2025
 10:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025164023.308884-1-yury.norov@gmail.com>
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Oct 2025 10:56:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVYPp1-06PVU8dZ1_BdXE8MYinviMSX9S+P75kWv3GoA@mail.gmail.com>
X-Gm-Features: AWmQ_blFhDk_WzwRra_UuPnoPCy5QHVsb30SVzWg8zqGYyxOeYGeHyfmSM-cGFQ
Message-ID: <CAHk-=wgVYPp1-06PVU8dZ1_BdXE8MYinviMSX9S+P75kWv3GoA@mail.gmail.com>
Subject: Re: [PATCH 00/21] lib: add alternatives for GENMASK()
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Oct 2025 at 09:40, Yury Norov (NVIDIA) <yury.norov@gmail.com> wrote:
>
> GENMASK(high, low) notation reflects a common pattern to describe
> hardware registers. However, out of drivers context it's confusing and
> error-prone.

So I obviously approve of the BITS() syntax, and am not a huge fan of
the odd "GENMASK()" argument ordering.

That said, I'm not convinced about adding the other helpers. I don't
think "FIRST_BITS(8)" is any more readable than "BITS(0,7)", and I
think there's a real danger to having lots of specialized macros that
people then have to know what they mean.

I have an absolutely *disgusting* trick to use the syntax

    BITS(3 ... 25)

to do this all, but it's so disgusting and limited that I don't think
it's actually reasonable.

In case somebody can come up with a cleaner model, here's the trick:

   #define LOWRANGE_0 0,
   #define LOWRANGE_1 1,
   #define LOWRANGE_2 2,
   #define LOWRANGE_3 3,
   #define LOWRANGE_4 4,
   #define LOWRANGE_5 5,
   // ..and so on

   #define _HIGH_VAL(x) (sizeof((char[]){[x]=1})-1)
   #define __FIRST(x, ...) x
   #define ___LOW_VAL(x) __FIRST(x)
   #define __LOW_VAL(x) ___LOW_VAL(LOWRANGE_ ##x)
   #define _LOW_VAL(x) __LOW_VAL(x)

   #define BITS(x) GENMASK(_HIGH_VAL(x), _LOW_VAL(x))

   #define TESTVAL 5
   unsigned long val1 = BITS(3 ... 25);
   unsigned long val2 = BITS(4);
   unsigned long val3 = BITS(TESTVAL ... 31);

and that syntax with either "3 ... 25" or just a plain "4" does
actually work. But only with fairly simple numbers.

It doesn't work with more complex expressions (due to the nasty
preprocessor pasting hack), and I couldn't figure out a way to make it
do so.

I also suspect that we shouldn't do the core code conversions without
having acks from maintainers. Some people may prefer the odd
"high,low" ordering due to it matching some equally odd hardware
documentation.

               Linus

