Return-Path: <linux-kernel+bounces-734412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC18FB08146
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5F16EABE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862C2E3701;
	Thu, 17 Jul 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjDd6rja"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED6645;
	Thu, 17 Jul 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710729; cv=none; b=d7l9cgNXuem+BMlPay0XpM+eC2TWEFPl6KoAMEvxLZFnx6tJPyomo4Uar3DUJDfJj46EmZbcW87t5ja75jRDn0+KBmnPRm3CdpafSfsj6kmnJXYtX7jbkOxbbdCzWGCARUBCSoXXUnIMOZmzorE3fOrmYhXvCpDCxyljXj2tLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710729; c=relaxed/simple;
	bh=KZzuMeicTTlM3brvrifv1Cs4ar0x89SY7EKfvB87SWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peEwYMZJ4F97C88fsCfXEavoA+7824A9+wL7Mo6qgU2406jwiABYGRNRvwUuuYv3ntjZbVKnOYb9LsU5kkR37Kboe7DWBxB+oYBwbG5TLuv2z5qO2ecyWsOUHxKMxSITu5df8iGUXQG7oBE5Mz3kwX3yxWmf8BpUpE8GAeyp3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjDd6rja; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234b122f2feso431975ad.0;
        Wed, 16 Jul 2025 17:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752710727; x=1753315527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0PD2z+G8vdSLdtZGP+Kk5CZjKHgRKgVkbsZP64r5bw=;
        b=EjDd6rjaAmNJea/MOQMXno5KZQOcV7BY9d1XPIyC7BuiY3HGzmVKMg12TLoZ9r+roa
         mjLV19WgE3ar6iyEp0rpB3SBrlcyfRk7C/YA2fhT6agNI8wsSqDJtvr+7C+LZGrGIzJ6
         11V/mzJ9z/1ZlVfClaXdcRp3vyo4Krwiyj9Ntbgm0TZ/ukkos+PbODcMlDa8/AWbFpaZ
         QlMhNGuPH+22OEGbf3FlTMT1dOrZSip72n71+aZLZoVDfXkWsa6CahtjCvUnpW98+S50
         oHW1IuAryfxvy7zybSDkkgoNaxFv37ps4wxcMghugQWYBCf2le/on1hbcgLweOMQrHB3
         +1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752710727; x=1753315527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0PD2z+G8vdSLdtZGP+Kk5CZjKHgRKgVkbsZP64r5bw=;
        b=alKm1dkKd1d7YVBxMUWn6ni5ZTixB4O/RV7y7DU5LRZIeL5e9xxl8oTPDTsu8BCQvc
         pZL3CxFd2jjl74ANlhj63VGXCqkZYFfFJ01FryuhlJV7oi1pDfKHhAoPJzYdaDheGFle
         zb3k7nPaBDH+NG3BH4n3NmwSR6q7VrB1Bsqe5qanPtMq5eK3dmJbfuxubEkyWeI61wZh
         Y+8FJRokSC8uX4tl7YKLB/zl3sPuqaJ4QO6kr73VexuGbPe6QnOEJb0AtVoSqLlvJpEc
         9QCTJrk6ixnIH/vv1Q1qylU+tdZZy4okEQUXslm1+25mu6kRYRqqZzY61ai21+4dRSP4
         Afyg==
X-Forwarded-Encrypted: i=1; AJvYcCXt1nUo1Fwg0Ct/cZ37KegHYlp6u/eQa1WxEq/5wZbm60qarz95CgOT+hUsHG8jkREkJZuWTmNnh1WW9gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTXnldNa4xohoXB2x5NtMq7vXgZqVOhZXbwu/oB2yTvcRSlUO
	NSiczBQKT2zSAe5Ot2JCTGysH5GmMvhynDuOE32unS/WxWoqdTfIG1/2EgvPg6V8r7KAhBX2NKW
	GOQ88QW8cbNQHGhekNtlHU+GW+6MRc0k=
X-Gm-Gg: ASbGncsvcvjH4fAdMNeOCqHKxYkkkLqHbcNTzgRuR7X3QFDNITTqqx12lPQ86WpB+zV
	tQ8+7P3uXBPu/T4SFvERcTrOw6ughQ4RHS8xO549/fHogJfSLPu9IhWj4JVjegXPc1WWLMo9K+t
	4F9yXTzbEzhUZ9jowOOnkWdgrc0OeWoSkiHq/Uzd0GO1aCsqy6q5utZxnc09MD9+Mbx5Vv/SGL4
	1LCFJpAChbND+XW
X-Google-Smtp-Source: AGHT+IGmWVmJ28UkY5WsUBhf/7CfbfwZExs11LLDDpuLwo/+ar8+IipsPx9EiJo4xagpeRxdvlHmZ3MjK0yxgwjwPqM=
X-Received: by 2002:a17:903:166e:b0:234:a66d:ccd7 with SMTP id
 d9443c01a7336-23e24f2e6d8mr28703055ad.7.1752710727004; Wed, 16 Jul 2025
 17:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710225129.670051-1-lyude@redhat.com>
In-Reply-To: <20250710225129.670051-1-lyude@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Jul 2025 02:05:14 +0200
X-Gm-Features: Ac12FXyxxrmAzenqzNwEf38yzQlwPoJbUixStNfRQeYZX9tvyMJZ0AeiW7QBrqQ
Message-ID: <CANiq72nAq1=xpAc=pi_N04spNWdKssJb8Nk5x9KaGHc+JhNAmg@mail.gmail.com>
Subject: Re: [PATCH] rust: time: Pass correct timer mode ID to hrtimer_start_range_ns
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:51=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> While rebasing rvkms I noticed that timers I was setting seemed to have
> pretty random timer values that amounted slightly over 2x the time value =
I
> set each time. After a lot of debugging, I finally managed to figure out
> why: it seems that since we moved to Instant and Delta, we mistakenly
> began passing the clocksource ID to hrtimer_start_range_ns, when we shoul=
d
> be passing the timer mode instead. Presumably, this works fine for simple
> relative timers - but immediately breaks on other types of timers.
>
> So, fix this by passing the ID for the timer mode instead.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Fixes: fcc1dd8c8656 ("rust: time: Make HasHrTimer generic over HrTimerMod=
e")

Applied to `rust-next` (on top of the timekeeping merge) -- thanks everyone=
!

    [ Removed cast, applied `rustfmt`, fixed `Fixes:` tag. - Miguel ]

I assume the cast was there just because the original line (`Clock::ID`) ha=
d it.

Cheers,
Miguel

