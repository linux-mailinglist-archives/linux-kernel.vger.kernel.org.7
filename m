Return-Path: <linux-kernel+bounces-705902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C56AEAEFF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D7C1BC5E42
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CBC19309E;
	Fri, 27 Jun 2025 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmOl2NqA"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36012207A32
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005437; cv=none; b=IMPAT59iUyaQtdwwa8V4NH7vYL48Dvnx8+IT2dm+EgoCLX5OHneIUfiXFpLTCT/WWGQsQZ2VjPvMagBsOPHB2BvlF3DMA2Dg+hzP4YEeo03FgKOMoY4ts/DjFI07DoYtoPcsQNZsMTqPeGZbtj/qHzISYuBytIJMx55Mr3n/hcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005437; c=relaxed/simple;
	bh=JnvY3RTmBx6MRqAVlV09eZbQ7sUKQlL0Z57F3QhInhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4w699qhSdMAwhLKjs57chj33zyIBTzQv8A5BIKCbnpz47iHHol2OtGrUeGIibnnI6G5t/5l/Ue3aU6UBj3XiXU9x9J6sY6cuLRW3hhgvi/UmlIhIyukAs05YSTv5lrclkxmmFGHb83Upj2lNB3MeX2yq9IBkPP5fGNznLGMwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmOl2NqA; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32adebb15c5so13250621fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751005433; x=1751610233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FRG6NNG0VVS1jQpfAYOrqcRu7QV8DTB5ZsV0Je+hvWM=;
        b=lmOl2NqAi6qQWiT66POpwtJzpdKBFT4hqF+fBTY2YYgfBBmzGO8e4umVZSjFwk/6t8
         jZKV7QjuAK7pJ2FSZDAlXR83jwdIxVQ+yDHU+dS14vVwsM7HuNfPFzS5G1NzZNVDRhvQ
         Bj5uN6sBlRoEnLTsWqjX+5Iqu8B575NTUB9NAxX7b1/T7SyIvQBfG7Z2h2M09+DgdqFq
         2IeM9vE9So8+6RX1pngN2WL+5g9A91yvg6hm7Tncny8fiH7d928hqyQzyoj80oPU+LZI
         B/zWD5/I7QkcfUQo49MvOWNHPd9weNG7qMROCYaBqDmTA8ykaeER10MaqqjNQRlQRWZf
         4D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751005433; x=1751610233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRG6NNG0VVS1jQpfAYOrqcRu7QV8DTB5ZsV0Je+hvWM=;
        b=vPFT1vf8ZWNalI8B6JONuwJmcrD7JgRYEytZikWxeqYV+LGrtU0xxrOc0hD+tFXaQF
         nOU/uIiCKA5KhADfWSg9a0f5oMBh7Li+73uECysfUU9FZT5CD3PYR/eqiJ9MNgwoE46j
         flFbLgEgQjV+rSDXVLmg8kyMcs+G5WW0kiNqJEYGXKX+957Mo9/+iKO4cfe4eJuRaxN0
         xlc49nC/IS9kRVVPKy+jvRBNrlCWio9FN3Oq6+MCC1oKGuY++/0zRp6BEG1Z99F2NUg+
         gsLDgiVAXP/3jyupTc89ZjL+9mdeqdJnL7K1jU45mwd+/li8GAbcEX0qdlMCOO2oqq0f
         dK7w==
X-Forwarded-Encrypted: i=1; AJvYcCWF0OjuRCtP/LYejI1YzbfKhpkShylZvlkF9x0soTG+OdLWIRuir3b3ChcB10t4BW3TASwa7EuqcKB5vfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5JedbllOd7U1F4uCe0Vrm3MT1FeRYShkMrjoDV54569QD5AJ
	neo2zajY01JvXixhW7MYZ/4EZQ4TiFsykIdg3YXW38JBZt9q92PP4MYE3FuuX7RgPv2IQzdd8nq
	uCHapVxF1DhLY9WZlR3el50lBjKZ1OOGwAij0AtI4
X-Gm-Gg: ASbGncu6n+VoH/AKOvRemw+5B91LvmNViXqoAGsVr0smeBS7ZyiqcmrUC0O2TI9+0E5
	taYZq+2VzOF9Gw5wqpkIKGpuezudFuVj25zQMS9J7SZV/nGyjmT/wBeGYnLqctBq62m79QGhV7A
	AGAEucpulpjx+w+h1hmTiPPvOz5xpCRRHwdtiyk5oCSvKWKfI7qbNgXW/fKsqrmDJXZc3Ioz2Qf
	4w8
X-Google-Smtp-Source: AGHT+IGK26L0oF+ODv4+XuY/ZlAuNolDiZF/FXqYhLEt198LoohKc+0K2UtZS/2z5j494oWFlLA35IH14x7tPXsm0Fk=
X-Received: by 2002:a05:651c:20c2:b0:32c:a006:2a36 with SMTP id
 38308e7fff4ca-32cdc524859mr3524071fa.20.1751005432932; Thu, 26 Jun 2025
 23:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFNYQkbEctT6N0Hb@lappy> <20250623132803.26760-1-dvyukov@google.com>
 <aFsE0ogdbKupvt7o@lappy> <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>
 <aFwb_3EE2VMEV_tf@lappy> <CACT4Y+b9u6_wx9BU0hH0L6ogGKN_+R5T7OsgJVFAWm8yeD0E7Q@mail.gmail.com>
 <CACT4Y+b1Sou9bzhsuJ_LAjwCtynWN1iNRnaUkkTecNWxLUfMUw@mail.gmail.com> <aF10Cu0GI092Sjr3@lappy>
In-Reply-To: <aF10Cu0GI092Sjr3@lappy>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 Jun 2025 08:23:41 +0200
X-Gm-Features: Ac12FXyAYSKfz7cidEHmKYezvS3_pE2Q0zztohcM72AP4oIRG48UsLnRi3saK5Y
Message-ID: <CACT4Y+ZB45ovD0hX3xX_yTUVSRDc1UCXnVDB57jxyWPPc7k=MA@mail.gmail.com>
Subject: Re: [RFC 00/19] Kernel API Specification Framework
To: Sasha Levin <sashal@kernel.org>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 18:23, Sasha Levin <sashal@kernel.org> wrote:
>
> On Thu, Jun 26, 2025 at 10:37:33AM +0200, Dmitry Vyukov wrote:
> >On Thu, 26 Jun 2025 at 10:32, Dmitry Vyukov <dvyukov@google.com> wrote:
> >>
> >> On Wed, 25 Jun 2025 at 17:55, Sasha Levin <sashal@kernel.org> wrote:
> >> >
> >> > On Wed, Jun 25, 2025 at 10:52:46AM +0200, Dmitry Vyukov wrote:
> >> > >On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:
> >> > >
> >> > >> >6. What's the goal of validation of the input arguments?
> >> > >> >Kernel code must do this validation anyway, right.
> >> > >> >Any non-trivial validation is hard, e.g. even for open the validation function
> >> > >> >for file name would need to have access to flags and check file precense for
> >> > >> >some flags combinations. That may add significant amount of non-trivial code
> >> > >> >that duplicates main syscall logic, and that logic may also have bugs and
> >> > >> >memory leaks.
> >> > >>
> >> > >> Mostly to catch divergence from the spec: think of a scenario where
> >> > >> someone added a new param/flag/etc but forgot to update the spec - this
> >> > >> will help catch it.
> >> > >
> >> > >How exactly is this supposed to work?
> >> > >Even if we run with a unit test suite, a test suite may include some
> >> > >incorrect inputs to check for error conditions. The framework will
> >> > >report violations on these incorrect inputs. These are not bugs in the
> >> > >API specifications, nor in the test suite (read false positives).
> >> >
> >> > Right now it would be something along the lines of the test checking for
> >> > an expected failure message in dmesg, something along the lines of:
> >> >
> >> >         https://github.com/linux-test-project/ltp/blob/0c99c7915f029d32de893b15b0a213ff3de210af/testcases/commands/sysctl/sysctl02.sh#L67
> >> >
> >> > I'm not opposed to coming up with a better story...
> >
> >If the goal of validation is just indirectly validating correctness of
> >the specification itself, then I would look for other ways of
> >validating correctness of the spec.
> >Either removing duplication between specification and actual code
> >(i.e. generating it from SYSCALL_DEFINE, or the other way around) ,
> >then spec is correct by construction. Or, cross-validating it with
> >info automatically extracted from the source (using
> >clang/dwarf/pahole).
> >This would be more scalable (O(1) work, rather than thousands more
> >manually written tests).
> >
> >> Oh, you mean special tests for this framework (rather than existing tests).
> >> I don't think this is going to work in practice. Besides writing all
> >> these specifications, we will also need to write dozens of tests per
> >> each specification (e.g. for each fd arg one needs at least 3 tests:
> >> -1, valid fd, inclid fd; an enum may need 5 various inputs of
> >> something; let alone netlink specifications).
>
> I didn't mean just for the framework: being able to specify the APIs in
> machine readable format will enable us to automatically generate
> exhaustive tests for each such API.
>
> I've been playing with the kapi tool (see last patch) which already
> supports different formatters. Right now it outputs human readable
> output, but I have proof-of-concept code that outputs testcases for
> specced APIs.
>
> The dream here is to be able to automatically generate
> hundreds/thousands of tests for each API in an automated fashion, and
> verify the results with:
>
> 1. Simply checking expected return value.
>
> 2. Checking that the actual action happened (i.e. we called close(fd),
> verify that `fd` is really closed).
>
> 3. Check for side effects (i.e. close(fd) isn't supposed to allocate
> memory - verify that it didn't allocate memory).
>
> 4. Code coverage: our tests are supposed to cover 100% of the code in
> that APIs call chain, do we have code that didn't run (missing/incorrect
> specs).


This is all good. I was asking the argument verification part of the
framework. Is it required for any of this? How?

