Return-Path: <linux-kernel+bounces-748920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117A2B1479A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3744E37B6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9F238C0B;
	Tue, 29 Jul 2025 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TEvnfkft"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896286250
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767250; cv=none; b=F7j8q6HzL7MZoa0IOeG0tmwia3BxvKZ5xhXggHNtYe/Z29FXC5IEUhXAZKk88XsksJ6jpYTtX1RnRHjh6RfGr/9hvAktjcjkzQUSATF3HqobfcfBIFwdlEUS/is5K+IQfuzb6Pq7WMyBiEBqhc6Ct6JsDAzXU/00eIYz7y+eRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767250; c=relaxed/simple;
	bh=qKAC5DW2JQ8V1S2ikGUaLAAv7w7fEROv695RWUPOfNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aE0QH1/5vsAyHCJzWfsNBY/rn8bcyW9RjUMDjHZ43t03B57y8DVQXXNRqReqo24RipYRuQPCshW1YqdqfveBuOKoTQIxeRmM+jGKR9lsgK5VXbTstgpLRomWptJwoytQlTHKnnabB53E8SyAg4OCWQrJy0eQJDjGo9EE5OI4Ca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TEvnfkft; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so8053816a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753767246; x=1754372046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6p1/M8lR2WSDDU9YBd8I/6HRm8nPQPg6ynn7GwgSIk=;
        b=TEvnfkft6eN8qTHnRUNU1Vs9xCga/OQL9w6R8tkgkMPsKzo3iVSnqMk+BHyWFvnlYD
         dF9bakA0ZCvfshN8jRICHvST2OS7GiRoSMxxEyXnigeejxRVj/jEsikZtI4og2p9IrC+
         pYUL4UHShjNo9VEhnD8bwWGL5LNsKGJxJaIHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767246; x=1754372046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6p1/M8lR2WSDDU9YBd8I/6HRm8nPQPg6ynn7GwgSIk=;
        b=aWO0kcLcH8+YHq/B9Lb21pj5ZL4ERqOgghEdrgwQzVVBDPwO1DfzoqxySoi9B8qEsa
         honX64L8sbyun5T7Rq209i4FT2ocKMuvGonLVr9uKH2F2omuV+70PWH8daJ2Kb4ZvJyf
         e41SLtViOMKX/ihfnP3TiGV9HW3BkL8QfWyA5+UFNzplpIGYbSXfvfa59lpF++vRIExw
         oKeExIPno+6pvyZdvjPLJFI+8xFXnF0oFCl2W+C+GRz+TxGAr4hHxWTDpt58XwehbSzn
         4b0X5yWZiO7At00UDOGR24QpHzRjiT0mYZ+9tIbfiO6eiLObZhDQdHcZmhuQwD63rFg3
         T0iA==
X-Forwarded-Encrypted: i=1; AJvYcCW8ZnW/aB9Q31o05/5sa6Yv/OZu8Xx1QQlbv+ncRzAvh1TQnBAqwbAVHghV41GdqEJiiCqqRpLQlootRSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhj9qj96S4TpesJroklJ+uMb/Gi8lzcu06AzGd9rPyU6wxxIDM
	KtasiSZvM3ffSsN3FQNvZ7/5Nh2RwAxIUcPsbSLAyA7rSeSAvHr9D3df0tlygvuSBCVQbYXoMS8
	0uEdGODE=
X-Gm-Gg: ASbGncuY/yDpupsFLWDzpIOX/cNRP4xW6A3biUK/YhTFrSPn76Fqdpi2HIP1RGDp35M
	KnRgZnvKgvtmbLHrpSDxo6K4zLLSIAEEJ8qIJELZUs2ujktB8BRMFQWP+AcN+3n5PWjQnOoqQLn
	LvNaR420mLYznpO/IKD+kTh9wsO1VKvPf8rMcH0HpmJfFt4ZZ+8uWHazL1pH9GJKdtRkte/MbNg
	vUrHI/y2TKOzzeOQBcvJDdVt1i9MCM5hf/xZQ0oqYAyQ9q9llFMDwIJuFY2+b93/E0l6RKLVXkC
	ZNJRPQQbhLyNHkGM/qRQ5JBiR5OsdhFg0zQSh3knSKdR7BbQQ7kZqRDw51c9p4z+yJ6X/ocAtEX
	8ZSIJCANafrg7MdOd60nNFVl35o4EWemUiGr5ok8V5cIPlufe1aY6gQuIqxtzp1dW5KyOofeb
X-Google-Smtp-Source: AGHT+IFFKv/QLHy1a/3mr+vFTVbWSD0Nn5fjVyY3hlTN89lV1WacGQ7YUr0JXzkJdgF0vflTLKI3vg==
X-Received: by 2002:a05:6402:51c9:b0:615:5aec:5604 with SMTP id 4fb4d7f45d1cf-6155aec596amr3518192a12.5.1753767246175;
        Mon, 28 Jul 2025 22:34:06 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500aedabfsm3828216a12.60.2025.07.28.22.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 22:34:05 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so8053793a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:34:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6MJHbRY16aAugkFQD3NUGbcoa1viT1AYRitBtgw3Dt5mMXbhuZ6DtH5qLiwFSyksv/Q4ECnSLE5/kxSw=@vger.kernel.org
X-Received: by 2002:a05:6402:560f:b0:615:78c6:7b12 with SMTP id
 4fb4d7f45d1cf-61578c67f57mr138067a12.30.1753767244941; Mon, 28 Jul 2025
 22:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh0kuQE+tWMEPJqCR48F4Tip2EeYQU-mi+2Fx_Oa1Ehbw@mail.gmail.com>
 <871pq06728.fsf@wylie.me.uk> <hla34nepia6wyi2fndx5ynud4dagxd7j75xnkevtxt365ihkjj@4p746zsu6s6z>
In-Reply-To: <hla34nepia6wyi2fndx5ynud4dagxd7j75xnkevtxt365ihkjj@4p746zsu6s6z>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Jul 2025 22:33:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiy=vZu63bfD8uJ6wSK8Pw_vsz-Fe2=WjFLGa_f1JnFWg@mail.gmail.com>
X-Gm-Features: Ac12FXwMXGQ8qR47Of_hZzjFq_Xr2vB0JGiqe4Uq_C-qLobzrwFzNBbnC87IKqQ
Message-ID: <CAHk-=wiy=vZu63bfD8uJ6wSK8Pw_vsz-Fe2=WjFLGa_f1JnFWg@mail.gmail.com>
Subject: Re: "stack state/frame" and "jump dest instruction" errors (was Re:
 Linux 6.16)
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Alan J. Wylie" <alan@wylie.me.uk>, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 08:42, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> The problem is likely that CONFIG_X86_NATIVE_CPU is using some
> AMD-specific instruction(s) which objtool doesn't know how to decode.

It might be a good idea to add some byte printout in the objtool
'can't decode instruction' error message, to make it easier to
immediately see what code sequence cannot be decoded.

> I don't have time to look at this for at least the next few days, but I
> suspect this one:
>
>      1a3:       8f ea 78 10 c3 0a 06 00 00      bextr  $0x60a,%ebx,%eax

Hmm. We do have BEXTR in our x86-opcode-map.txt file,:

  Table: 3-byte opcode 1 (0x0f 0x38)
  Referrer: 3-byte escape 1
  AVXcode: 2
  # 0x0f 0x38 0x00-0x0f
  ...
  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By
(F3),(v) | SHRX Gy,Ey,By (F2),(v)

but there's apparently two different versions of 'nextr'.

The one we know about is the "BMI encoding", but there's also a TBM
encoding ("Trailing Bit Manipulation") that AMD introduced for
Bulldozer, and it appears that we don't have those in our opcode maps.

And yeah, I think it's bulldozer-specific, which explains why nobody
sees it (because bulldozer was one of the not-very-great AMD uarchs
before they got it right with Zen).

             Linus

