Return-Path: <linux-kernel+bounces-724560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EDAAFF45C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC021C469F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20BA241695;
	Wed,  9 Jul 2025 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qy9i49LT"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8292367A3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098706; cv=none; b=I5a2IL8yts+7DafUPL8Ep7ckSn7OAU4yIioc65qCnhkb00A7f6Hq5gY04PLfghAVY/b5GgRd2AoEpwvVziJuD5exPdxgtT9/egfnxpgHkaPUAISQ9R8ifBpqV7tancnAlEhwNO1u482970DLWm2JoZZVFJg0ZoU1FA2qOkE0y54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098706; c=relaxed/simple;
	bh=vn7EJCVn7vkbl/99TMM91++Va4PiEu2rnwusD2cqc04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZeFetoqOahhjrEWMfvprFqpnVqnxQeYvFbexIVGNAWg0Lopr0KDIbgLIodJBdShIHI3BpIQTlW/zOimnvfqegACbD+eZi15pArhuDYaCTFLjcgieV21bP3AfKXCHF6GDXlhiJV1MicbEw4QTbeQBStNd840koF3Zv1wA3hKNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qy9i49LT; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso4265a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752098703; x=1752703503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn7EJCVn7vkbl/99TMM91++Va4PiEu2rnwusD2cqc04=;
        b=Qy9i49LTAIrfq2A0CZWH3j7JU8KK5FgEISRoaNJxBFR8IldWmlAKwm9wOP1rYgOpC1
         T6Hn2E9VPv8V8L2QJnL/kDCN+8Wy5IEd3qGcGDNqLIWe0WZNqXFAdsdFDKBejLDb+ptH
         S6bWm/0k1siZUxUzwhlvYkUnqSdP2kOVu2UQSRRWDuBBJEogDQfgg6sW9WmazknAh++Z
         Uk/XxdWBGg1aYAaq1K5Kdyky4p9w0ijUPA1Acf3p6j14o9Ab6p8Ru4TLD3UMMH0bRtxI
         sxsPfxynJJmWQsVC+yZ81idjLi7czckathpyXdPK0OfyK8RIwpgyr5nDDsrXDjT3OEWt
         hP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098703; x=1752703503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn7EJCVn7vkbl/99TMM91++Va4PiEu2rnwusD2cqc04=;
        b=g+5ax5mbDDZ4DsjGaQ+DXk9jHt07J/iBe7gR35JEf1fK0L550vYpCzorwjdsQ9kbZ8
         u8+CeRvsiZ9kX+JZvDYANFk82Wl68yMN4Zm76J56vkhm30HT1G3IXj4QQUd7PtYpzMmW
         kds+judfAqotLiya39WLO/uHOCnAtPZAVYHpUVvFMzCi8siYg06sMYoo/q+1Pdk/buR3
         ea5CzfYncmPMGJFXV8/AqQCOI7AeTH0nm4Tm7Pt4MvuIoIRDwt6QlPHFess57yhJ5UF8
         LcBo6p5UGL3ugQ/psriOesLYnRweRqaKVu9wDOha0i7NGMKdsjsp+4A2ON8n10rFL0XQ
         aayA==
X-Forwarded-Encrypted: i=1; AJvYcCUTxwx+OW/f9UwSoR+hWnnyBG81zQxglHy1HZTyQM7xZcuBlfSl0glLUU0Ip5hVr1Lp8jC/maWh18JRvSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeuCoQnGvdiqW6keMXsZcic+z8YmeHJPNZ728xTFXmpUqMulG
	CXmWFuaXU56W8ElHA3fQzYtzfxaluG+L2M8isEj9xXhpTdymsDbbLkoZSh8DCAvPt/L9R12OpT9
	a6mLXJL9u2XplNfoVKq1b2WUPU536tDzmKjQawT/d
X-Gm-Gg: ASbGncs9tDFcYweSGkLKPaxkV+sjVLjW9DwQhqcbivA/TWn6fR4wJ2iw8243YtV2gE3
	Nimtb1paZjCk8Xu7H+EU/g3xtFcM4XE7YSI1lXySCldU88EZGkkigFxWqZMTAmsxMaE+D4se1a7
	d88HR5AGEFBsp4Szl14AjEO/w8CjEAJVN3ZSi3IIpZ8fV+L64zGRC3LOx7+oo3obLG7gJosBPsM
	g==
X-Google-Smtp-Source: AGHT+IHMY2S2cOq4aj7R9JhuwZRVDDRnUaRyOd/9Y0XjkBE9lTZ7Q7zt7tkV73zfMNNQfimDA/LHV+q48SyKRNdcNnw=
X-Received: by 2002:a05:6402:a41:b0:60e:3d45:c65a with SMTP id
 4fb4d7f45d1cf-611c79717abmr16007a12.5.1752098702766; Wed, 09 Jul 2025
 15:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <DB7US8G7ISG0.20430M3P7I0K0@kernel.org> <CAGSQo01hORWAtrGaYp-_xxrAiN47JkJg=jiqnqdpw87QKzt9jg@mail.gmail.com>
 <DB7V19QE6KFB.3MR0BAOWXT7M7@kernel.org>
In-Reply-To: <DB7V19QE6KFB.3MR0BAOWXT7M7@kernel.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 9 Jul 2025 15:04:51 -0700
X-Gm-Features: Ac12FXz-6atGuBPiC5MKmxYtYy_PzNi1g8QW4v6Xr2bH3tjr0kUa_yJ4Vji2mrw
Message-ID: <CAGSQo01drZoy1-j-+Y-BHHOX5AzCG4A5KiUOu5TJ40JOdfcB0g@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] rust: DebugFS Bindings
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:59=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Wed Jul 9, 2025 at 11:53 PM CEST, Matthew Maurer wrote:
> > On Wed, Jul 9, 2025 at 2:47=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> >>
> >> On Wed Jul 9, 2025 at 9:09 PM CEST, Matthew Maurer wrote:
> >> > This series provides safe DebugFS bindings for Rust, with a sample
> >> > module using them.
> >> >
> >> > Example interaction with the sample driver:
> >>
> >> I understand what you're trying to do here, i.e. showcase that values =
exported
> >> via debugfs can be altered.
> >>
> >> The problem is that the current abstractions only implement read(), bu=
t not
> >> write().
> >
> > I was trying to keep the initial bindings simple. Adding `write` is
> > definitely something we could do, but I thought maybe that could be in
> > a subsequent patch.
>
> Absolutely, yes! I didn't mean to ask to add it now. :)
>
> >> If you really want to showcase changing values, you can, for instance,=
 create a
> >> workqueue inside the sample driver and modify the counter periodically=
.
> >
> > This is supposed to be sample code, so ideally it should be as narrow
> > as is reasonable in what subsystems it touches, no? If people would
> > really prefer the sample schedule a ticking counter I can do that, but
> > it already felt weird to be registering a platform driver in a debugfs
> > sample.
>
> I'm not asking to do that. If the values don't change for now, because
> there's no write() yet, that's perfectly fine with me. :)

Potentially I misinterpreted Greg[1], I thought he wanted to see how
mutation would work.
If we don't need mutation, I'm fine simplifying the driver to not have
any mutation triggers and just export a few random things.

[1]: https://lore.kernel.org/all/2025070349-tricky-arguable-5362@gregkh/

>
> >>
> >> We really should not teach people to modify values by read() instead o=
f write().
> >> Also, without this workaround there shouldn't be a reason to export th=
e exact
> >> same value twice, i.e. no need for File<File<AtomicUsize>>.
> >>
> >> - Danilo
> >
> > How do you feel about the `Wrapper` struct, intended to simulate the
> > driver doing its actual job and show how that would look? Is that
> > similarly verboten, even though there's a comment on it saying this
> > isn't how one should do things?
>
> Yeah, let's not do that -- don't give people ideas. :)

