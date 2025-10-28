Return-Path: <linux-kernel+bounces-874560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3503C16937
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31431AA29F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3934E772;
	Tue, 28 Oct 2025 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A5pvgHYc"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DFD25784E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678780; cv=none; b=so/ssPbYDI5TRZnUzq/dx+UTl+/mirIbfUO1pK9SYRKGTkLVPTOWQR7fCPPg6qNZ7Jtv3EhFS5+xErTuLSHa2/pivjtWez3LnlcpUJj9uOl7G3aF9VCauQ5dqSraiG1V4dRmyp91MkN2fBMPm6bTe3EEK4RqdI/rim+TvZNHMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678780; c=relaxed/simple;
	bh=7pmpFBPAooA7uZTEq5xcWaQNGdi3bnLGsp3ozlowH2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdAByl/CuJmezNHE2OaNPBG5jxMXUUCmLnycOAsEDLsGwDP4B2JD3fNVDJsEPz08eEgosVVihzebgrqlb+nsDdacVA8Uu4QwbusTrxba7KJ9V5y+mYmmr1vpyGKrdLnORLNEepBwr5IFrGpuQAmg1bZMouuG/+vmzkmTqAEuJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A5pvgHYc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso10343693a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761678776; x=1762283576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oL3CIqlSnEUIPnF8RN18LXFTdGCghKUIKc2P/11P0YA=;
        b=A5pvgHYcJfha4zDZIWnmkYQfwj3RI1tNaemR+ASLzd/QxCJtHF9K+XJ7sDGApCxzhZ
         diyahb+FOttWKq2HiiwxO4GtTC0zlpe6VTeY1fR8HfbNKIimmGvW7nRwP+Zh9WFxwfAK
         OTAUO5adRNN9D1gRrhqtqB5+1KLxXRGYIhyU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678776; x=1762283576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oL3CIqlSnEUIPnF8RN18LXFTdGCghKUIKc2P/11P0YA=;
        b=Y/5oaYlBau06XYgtms9YLrbUuxR3rrmhrizBV3FYdZeyaeSwhW0JIH21KGuD2KqTU+
         bHOhdQdIp56LFjSAsJ90Nibud6mAUkTn9sF6z4kGZV2wHeScBQguzqQrb/CWTr69fUPX
         pF7qMNfm7CE/OmBcKcV8p3SqH6hEtXf7pNjbTmxNzX37aVXBS38PaGgnbMeU1XG2h1K1
         dk3S73ZDGbqagzmYJ6GQcD8umyBwNtBFLSUIWEGrhP8/LwWnJQbLIo68+SwgSfExML5C
         S45QYfe4FtCKihkEg7iS0EScvAe7OgH8xcBDG2hSQ+nFbUA+7mUVH1kKLKRKpbojx3tS
         CpdA==
X-Forwarded-Encrypted: i=1; AJvYcCXQuhH5Z1pP6cMAQYz/RomRmH9S7ArsvVJuy3zWn6ohdhsamWOGqcwfhROq0Jb8ajHiqvrala1CiKhx2WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAq9gKolZjjfwoQpDz25t6N9jX3u/lco3OZLmF3G1ot/Zb/2F9
	9JmWEOdz6+K6aa0SkUid59v/U1m3STmPJL8NMPBaRDi9tc/NrSSYbRHxttw9JEVhTmiTsztcyMX
	N1V7OsQceyQ==
X-Gm-Gg: ASbGncucHYnYqKO2cetwILe45Mm3mWy3UzY0bxr5w4MBsCZrLIJK0woBkUtCcjlktZC
	eSHFlND+2l6hB5JGnniPoEaQiNdGoRAOUDxjUAPomAqHzP3BkCqlUnCo/Yy13rqsKcD+foq1Btb
	AIIwJXdVdDE7LZxA16ysKGInX+7nhD2kR4QZj7IRVmUkZ0wGIDJXeG92H1IdjrObJNWb48s1Ohg
	LdsuP6I3AyxfahaG7+NJPHPCGjI30lc3y888l0Wl9kbBaoYWBXBbWTpoLHoH8O8WZa+maSt/Lbz
	GfiHQA51ZVOzRjGMwI/jgt/ZCfc72bPQJuZN51XZrsEqw3FpfqGqyz4+3wrFEFuMnALCfDmCFum
	xJBXcZIFsU4drspubwVQoUbigLEua+vnszMHjT20otQSgJFYaACkahPC47eM3WEhsvXP5/5jZC/
	qSbPLw2mtVLKNXGiFq4NLmUKyZX4J3S5g4Es0U/FjWIyDfIW4KQA==
X-Google-Smtp-Source: AGHT+IFB2lIxRhRDiaCCUq/cjbUlGJ5D+CGJRz4kd9kBGzr54qxLHEXs9hsyQ5HdJIK+01wB5LGfzA==
X-Received: by 2002:a05:6402:1941:b0:63c:4f1e:6d82 with SMTP id 4fb4d7f45d1cf-64044252dadmr133340a12.24.1761678776286;
        Tue, 28 Oct 2025 12:12:56 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63ecf3686c5sm3946264a12.36.2025.10.28.12.12.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:12:55 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso9291652a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:12:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKir0ys4aAatmhwN5igUGcd1bluI3uiGsGfyOQ9WeDMjlOFTiuHmRKEoJKt517JT5lopBO1zn8nQ4u9kk=@vger.kernel.org
X-Received: by 2002:a05:6402:26d5:b0:63b:f909:df50 with SMTP id
 4fb4d7f45d1cf-640441bc6d3mr138626a12.14.1761678774925; Tue, 28 Oct 2025
 12:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028175639.2567832-1-kuniyu@google.com> <CAHk-=wj7s3VKFP2vLmEHhHZ=VBkr5v8J-Y47uzidnt=Kt+dzng@mail.gmail.com>
In-Reply-To: <CAHk-=wj7s3VKFP2vLmEHhHZ=VBkr5v8J-Y47uzidnt=Kt+dzng@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Oct 2025 12:12:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYvRqYYCi3Wcq==Y7Zg_i9u-04sk4BtXrP03txZ0yzww@mail.gmail.com>
X-Gm-Features: AWmQ_bnlLqcYXf_eOcV10dIkw4sE4pAJUua6DYvNIrtovqBlD8HS0-THJ6CDcXI
Message-ID: <CAHk-=wiYvRqYYCi3Wcq==Y7Zg_i9u-04sk4BtXrP03txZ0yzww@mail.gmail.com>
Subject: Re: [PATCH v2] epoll: Use user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <david.laight.linux@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"

 On Tue, 28 Oct 2025 at 12:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Because I think the proper patch should look something like the
> attached.. For me, that generates
>
>         movabs $0x123456789abcdef,%rcx
>         cmp    %rcx,%r15
>         cmova  %rcx,%r15
>         stac
>         mov    %r12d,(%r15)
>         mov    %rax,0x4(%r15)
>         clac
>
> which honestly should be pretty much optimal.

Side note: when I say "pretty much optimal", the truly optimal
situation would be to do the address masking entirely outside the loop
in ep_send_events(), but we don't expose that interface, and we have
absolutely horrible experiences with doing user address checking
separately from the actual code that does the access, so I'm really
loathe to add that kind of logic.

So the above is *not* optimal in the sense that the

        movabs $0x123456789abcdef,%rcx
        cmp    %rcx,%r15
        cmova  %rcx,%r15

part certainly *could* be done outside the list_for_each_entry_safe()
loop in ep_send_events(), but I do not think that three simple
ALU-only instructions should make a difference here.

              Linus

