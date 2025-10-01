Return-Path: <linux-kernel+bounces-839442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB605BB1A10
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B4C19C21EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD5D28467C;
	Wed,  1 Oct 2025 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WN7Y8Sz9"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E64C347B4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347582; cv=none; b=qEIlu5epgY5OC6CZJd1SJP5ej23Mi0sQY9TGRsQ7Rp0FTMlR7kSCY9Y3C4auHCS+0EbDyuYgTwDtaL1Xi5nUjaAIIe8PrrlRcHIjLJdODRafie1NixLHGjNYCoDr/Q+U1/2ngzX6s1ge05ceP+wXFyfOwkzPxiiyR81raurhHOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347582; c=relaxed/simple;
	bh=NfE3QuXN6BX3zRiveIb7jNl7Vn9dGhejnIUd1uLDtr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTqeItZYtcnbQRSHoRVA3Uy0JVOmasDSnN1JeTpvXLlJ00sqs2u2JP1wtrw4R9MwRQdgMFx/8nUduTsqak+OzFS8e8xNRMd5/Y5PYWfTAZVkZ++M3/Z8/ICGAPDfa8mQhQixqLlu6vrNcjer6jJIqLYRGILQTkxIL7q6yQ0xZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WN7Y8Sz9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so40826566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759347577; x=1759952377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EyU2xAA6jBou2pgzogPav9cxdB63oJabTBBunDFicTI=;
        b=WN7Y8Sz9WAlFOIGZmMY1L3+7Z2JVwiO8AkPf0V99ONDT5jpVub6dYEUTltsLEldds1
         kzgoyYcT03dkouWEjLGqChwHmF8AoU16x3j5zrQn3n3O+CHFNmfMEqvUMx1NsxbwlR6T
         Y/k9ZHsnIY95tnc2W75J3B15VDRiCFGBp+bq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347577; x=1759952377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyU2xAA6jBou2pgzogPav9cxdB63oJabTBBunDFicTI=;
        b=av1kv89U1C2U/Z5xdkf9XdFsqxDflSet7GjKfmcRQiRH+D97K4aOu7IWNMR8G5OU/v
         o0Z1GV5cshy9rsO76urWFmoS2h5jBtmvlO9P2ks++kA6v+vfPFZdh6oGnwl0fMCWr2Qn
         TteV3rIGOW2H6eniBLb5TteVxv+Yex/Z8gKULdlG+bcLeboTx0Zqcth7DNre9+3acMJ9
         zDS/0gQcP/GnwMPzlDtxq8mV2SA9beg6v9fQlgDsI3WGc/b/rCEd5sKCTh/5N73htIXV
         Cm0iom7yoyxd5FONeuHRzTMZdKwABJEfT53utfMHujmxYkRZ3JEmmAkL4EIMNTz44KJj
         EAag==
X-Forwarded-Encrypted: i=1; AJvYcCVEFYL1WbVGfPidUn/AI+cLyoya1wpUZOKZadM2uiiL9ZtACSy5LSzzU5jtF15Urv5WCWglYUVItxTox4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgfSQ7HGsfMTeAKqK8IvFjT0V9htBD72M4daw39cmt3I52k/W
	zXqe14iNDJVqdEPZfKt5YTzFVBSq4Q4VbIqM9vlRzCpZlfLNBuZ4D9nG2D2GS7ePRSFpwCyF9gb
	tG3/AxCc=
X-Gm-Gg: ASbGncv6B+J7dcTKE1c+jDavwUVjGxfABIojYymOkS0UOCWAF6U6PbjVWA1MI8TYWGL
	2wmSM46vYcvNadraWpMukzU3AdiyndgsAB1ja/M5VbJYieI40r8KdrenZrVFlGtzEg6U7LBNgKO
	ygJCfNQMCufU1WgRbw4F+vgdurTzBHOXPq+Iy+iKVo5qCD+r/VZhzIHG+2tZKguiI1HKRz0oMOf
	zZTSYsICMPYpaU7U9opBkDMdOeHGb/Lb94XEb3tw6sN8EuL5c7f0scE4G/TVeXWVLURZSOMjusa
	sHHOfHJ30W2ItRF0KBVnbwJzMKDe8yrcfS9gHczA3PCTMtoFyO8C3AhC0Fq44kqDpgwKMRRE2PN
	nruqjksclqv6jjgmZkbeBT45efvuY5u6XLqtOr9AP0Y2o37UUPS+R62vQ6SOOApx0WnC5pkejzb
	80yLUlIJgdHyapkS/jOVw3
X-Google-Smtp-Source: AGHT+IFaqYIMubHJZU9R2XZfRyF48742fOd/7iic4x1gLENHyCOgmxaHpu83W6Oe8wOE9XM5GlSQlw==
X-Received: by 2002:a17:907:6d16:b0:b42:9840:eac1 with SMTP id a640c23a62f3a-b46e927b07emr579275766b.49.1759347577521;
        Wed, 01 Oct 2025 12:39:37 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a173b4csm30838066b.86.2025.10.01.12.39.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 12:39:36 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so423467a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:39:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQb5NFw1rV29uBotDsuGi6ceFLjvTly9V6fkryy5Q6+8rwnLqN65ix4hpbmcTbeVWjl5hUx7VeozCsyEM=@vger.kernel.org
X-Received: by 2002:a17:907:7ba3:b0:b3f:3570:33f6 with SMTP id
 a640c23a62f3a-b46e92792d3mr558060266b.48.1759347576045; Wed, 01 Oct 2025
 12:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
 <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk> <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
 <CAHk-=wgYcOiFvsJzFb+HfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com> <20251001-patrol-recapture-4bdd58ad7582@spud>
In-Reply-To: <20251001-patrol-recapture-4bdd58ad7582@spud>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Oct 2025 12:39:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wji-hEV1U1x92TLsrPbpSPqDD7Cgv2YwzeL-mMbM7iaRA@mail.gmail.com>
X-Gm-Features: AS18NWAcg4y35bgDLtTylWGCwrYt77STUObMvEAm9g4dQ-aeAY5vIymwKHS9zes
Message-ID: <CAHk-=wji-hEV1U1x92TLsrPbpSPqDD7Cgv2YwzeL-mMbM7iaRA@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
To: Conor Dooley <conor@kernel.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Paul Walmsley <pjw@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 12:03, Conor Dooley <conor@kernel.org> wrote:
>
> None of that was really done as a deliberate attempt to add support
> for BE, in case that assuages concerns you might have about the taste
> of the arch maintainers..

Thanks, it does.

As others have mentioned, the arm64 support ends up being problematic
and people are actively trying to remove it.

BE is dead. There is one good reason to support it - legacy
architectures designed and implemented back in the days when it wasn't
dead _yet_.

But it's a huge pain, and the world has moved on. Dealing with BE with
any half-way modern infrastructure is a dead end, since things like
PCIe are all fundamentally little-endian.

If somebody really wants to create bad hardware in this day and age,
please do make it big-endian, and also add the following very
traditional features for sh*t-for-brains hardware:

 - virtually tagged caches

   You can't really claim to be worst-of-the-worst without virtually
tagged caches.

  Tears of joy as you debug cache alias issues and of flushing caches
on context switches.

 - only do aligned memory accesses

   Bonus point for not even faulting, and just loading and storing
garbage instead.

 - expose your pipeline details in the ISA

   Delayed branch slots or explicit instruction grouping is a great
way to show that you eat crayons for breakfast before you start
designing your hardware platform

 - extended memory windows

   It was good enough for 8-bit machines in order to address more
memory, and became a HIGHMEM.SYS staple in the DOS world, and then got
taken up by both x86 and arm in their 32-bit days as HIGHMEM support.

   It has decades of history, and an architecture cannot be called
truly awful if it doesn't support some kind of HIGHMEM crap.

 - register windows. It's like extended memory, but for your registers!

   Please make sure to also have hardware support for filling and
spilling them, but make it limited enough that system software has to
deal with faults at critical times. Nesting exceptions is joyful!

   Bonus points if they are rotating and overflowing them silently
just corrupts data. Keep those users on their toes!

 - in fact, require software fallbacks for pretty much anything unusual.

   TLB fills? They might only happen every ten or twenty instructions,
so make them fault to some software implementation to really show your
mad hardware skillz.

   denormals or any other FP precision issues? No, no, don't waste
hardware on getting it right, software people *LOVE* to clean up after
you.

   Remember: your mom picked up your dirty laundry from your floor,
and software people are like the super-moms of the world.

 - make exceptions asynchronous.

   That's another great way to make sure people stay on their toes.
Make sure machine check exceptions can happen in any context, so that
you are guaranteed to have a dead machine any time anything goes
wrong.

   But you should also take the non-maskability of NMI to heart, and
make sure that software cannot possibly write code that is truly
atomic. Because the NM is NMI is what makes it great!

   Floating point! Make sure that the special case you don't deal with
in hardware are also delayed so that the software people have extra
joy in trying to figure out just WTF happened. See the previous entry:
they live for that stuff.

I'm sure I've forgotten many other points. And I'm sure that hardware
people will figure it out!

              Linus

