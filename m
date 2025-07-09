Return-Path: <linux-kernel+bounces-724584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC264AFF48C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BB617548E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201A2242D76;
	Wed,  9 Jul 2025 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOo1f/Yo"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD923B61D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099684; cv=none; b=YIYpASHgHxbnnIYiK3zg8DyQAvou6dTw2ORoZab/u+xuCxivqLKtO7fUDZgjNrwqgNR4tHEHrBqgdgHx6ZP6rhIsktSoytZphgAUgek0/gxGwWE0L0IkDrSFDn4OZ+kJhSkIQoHM/Begjuv6VGLXUL8lq8pU/7ztbUM/+uW4j8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099684; c=relaxed/simple;
	bh=lRn5Xzu/HIT35eBhvWLX/C6sWrlucrMXJNu5lgmdO3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5JrdWPW9RmxlrDrnJyzYZGFUh3/mOmDqDoNTsSDMpaED/RAt4kGwmcq4+53OkiUM47TpD/scqjqN/ZQ1bBSE60WmOlhXmCPp3Tgdik7x6Kw4wPdTEPbD3vI/6ZCGOeOWuCPzNqb6GK0c/zdh6KAlztKh0FAXx1BJQpSzMB1JZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NOo1f/Yo; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso4390a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752099681; x=1752704481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRn5Xzu/HIT35eBhvWLX/C6sWrlucrMXJNu5lgmdO3I=;
        b=NOo1f/YolH3hFdMZ3L4Icuku0jmw/RQrBFgMt276heJYnThclbbBdKcMDFcdVR2rBA
         eYSfb6ykENaPV3yerS80OdwC+SdKmGo4QYzOlvC3v1cNKwokcYhbMdd/wldReRp/qHRa
         fGBcsqMye3Bnc+Z4BvaE0N1yH4U9xkVqO+ziKJ9PprP1yFEQKYl0U3NSX77KuCMpg/DI
         1N83U41Ry3EB8DLCP+GL8U0CwSlfphVXzeLfMoTXVHm4pR+tQDga98ZjFaIgNp8X9B2l
         MCO5+pRlWw0VMEXeHid273JwdsJs6+JgxyzvSm/Ff6KUc3mqd3/e8FoTYd/14vDszmuQ
         JsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099681; x=1752704481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRn5Xzu/HIT35eBhvWLX/C6sWrlucrMXJNu5lgmdO3I=;
        b=nO5OdA4ado+N+wP3QFVyYgZSsSJ5na4TuZOxVDKo5fzTlGcZRSYgJA61JJlFA+xuIG
         S4Agk7yeIhERiRmYH6arBwDez2goB82+vNnTElJZxEjvHw7cW7+Fn5APy5VdofUxqbcH
         RK8lklSjdfhX8MgTog9KthSm5gGp3eJPj3QXnsJRh/D82MrPzDCESvzD+W/kmZn1OCou
         wrZbphy3KsIr/pvOP6u2kviv/x2fVGw5X8MAII6IFB5WMrUWFcfmScyo1wZZpw/Pi14e
         wO7tO6FyrId7QaDBIn8MuU9EEvPbrILs0Mb1GGTEcH9WJcg69rwHyvfNL5xZpj+SbY2o
         IGuA==
X-Forwarded-Encrypted: i=1; AJvYcCV3sydqfQa5MOrC1xob+1wjJtmjdSnqpJ7luTd75Zd1cPO7lSyc+AnQQWBSapI/PDvpD1by/WS9pxCgjSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7TZlaxPwvdizobyG8VqhNsDK8Km4pxscVC0Za7SXghH/Mv+a2
	w+oWIU7A8uIlor61jBvy/cBPBublzhFSgojdfm3RHVsTvVQ609wIpNGsmllYHePZtQBr4FBOHp2
	KpcIjzxG0ejj0VCxOoPXKpgvH+EeC57eeuzxtquGb
X-Gm-Gg: ASbGncsWdSe1QLuXoC5suxgZdHatUr5ZYTNny6y9DFLPnlADsVMePvd10/M0oCleK8h
	mYBN05PGBX2YcUSLRrxrXBbjx6MPDs7Mk34TLijG3/QnXWk/8kWAO6D8puteoWl+AbshxAjP5NI
	ieCzgIP1jr+EdrRnp9rQwWk1Tr2cO8MkYho+nMY5QQDdfMQ0zJQuN7ECY6ltC299KhV3ExtVwyE
	Q==
X-Google-Smtp-Source: AGHT+IElpydce8/aiG+Co2qqFsWk4TL43jhm64lTv49EhFptJ1RhxZaus7tO/Ghn0kH6oitJUQaaNS3bgEeYmpkUgvk=
X-Received: by 2002:aa7:d393:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-611c7970cccmr12327a12.7.1752099680891; Wed, 09 Jul 2025
 15:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <DB7US8G7ISG0.20430M3P7I0K0@kernel.org> <CAGSQo01hORWAtrGaYp-_xxrAiN47JkJg=jiqnqdpw87QKzt9jg@mail.gmail.com>
 <DB7V19QE6KFB.3MR0BAOWXT7M7@kernel.org> <CAGSQo01drZoy1-j-+Y-BHHOX5AzCG4A5KiUOu5TJ40JOdfcB0g@mail.gmail.com>
 <aG7pP1BTLQKInFrl@cassiopeiae>
In-Reply-To: <aG7pP1BTLQKInFrl@cassiopeiae>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 9 Jul 2025 15:21:08 -0700
X-Gm-Features: Ac12FXySMpY36tMHMG71IrRFYO_x2FjYq0SXxQFyheNY1upiOBF5N9pRRg3iQ8g
Message-ID: <CAGSQo01ge5QvhRtq9razpmrMNSPJuT3+q9Cafd1Hd=wmEjXfBQ@mail.gmail.com>
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

On Wed, Jul 9, 2025 at 3:12=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Wed, Jul 09, 2025 at 03:04:51PM -0700, Matthew Maurer wrote:
> > On Wed, Jul 9, 2025 at 2:59=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> > >
> > > On Wed Jul 9, 2025 at 11:53 PM CEST, Matthew Maurer wrote:
> > > > On Wed, Jul 9, 2025 at 2:47=E2=80=AFPM Danilo Krummrich <dakr@kerne=
l.org> wrote:
> > > >>
> > > >> On Wed Jul 9, 2025 at 9:09 PM CEST, Matthew Maurer wrote:
> > > >> > This series provides safe DebugFS bindings for Rust, with a samp=
le
> > > >> > module using them.
> > > >> >
> > > >> > Example interaction with the sample driver:
> > > >>
> > > >> I understand what you're trying to do here, i.e. showcase that val=
ues exported
> > > >> via debugfs can be altered.
> > > >>
> > > >> The problem is that the current abstractions only implement read()=
, but not
> > > >> write().
> > > >
> > > > I was trying to keep the initial bindings simple. Adding `write` is
> > > > definitely something we could do, but I thought maybe that could be=
 in
> > > > a subsequent patch.
> > >
> > > Absolutely, yes! I didn't mean to ask to add it now. :)
> > >
> > > >> If you really want to showcase changing values, you can, for insta=
nce, create a
> > > >> workqueue inside the sample driver and modify the counter periodic=
ally.
> > > >
> > > > This is supposed to be sample code, so ideally it should be as narr=
ow
> > > > as is reasonable in what subsystems it touches, no? If people would
> > > > really prefer the sample schedule a ticking counter I can do that, =
but
> > > > it already felt weird to be registering a platform driver in a debu=
gfs
> > > > sample.
> > >
> > > I'm not asking to do that. If the values don't change for now, becaus=
e
> > > there's no write() yet, that's perfectly fine with me. :)
> >
> > Potentially I misinterpreted Greg[1], I thought he wanted to see how
> > mutation would work.
> > If we don't need mutation, I'm fine simplifying the driver to not have
> > any mutation triggers and just export a few random things.
>
> I mean, the most simple way would be to create the debugfs entries in pro=
be()
> and mutate them - still in probe() - right afterwards once. I think we sh=
ould
> do in any case. And AFAICT, this also covers [1].

That's what I did with my `InPlaceModule` before and it evidently
didn't count? I don't see how the constructor being `probe` rather
than `init` would have been the issue - the only change that causes is
calling `KBox::pin_init` on the value you would have returned.

>
> > [1]: https://lore.kernel.org/all/2025070349-tricky-arguable-5362@gregkh=
/
> >
> > >
> > > >>
> > > >> We really should not teach people to modify values by read() inste=
ad of write().
> > > >> Also, without this workaround there shouldn't be a reason to expor=
t the exact
> > > >> same value twice, i.e. no need for File<File<AtomicUsize>>.
> > > >>
> > > >> - Danilo
> > > >
> > > > How do you feel about the `Wrapper` struct, intended to simulate th=
e
> > > > driver doing its actual job and show how that would look? Is that
> > > > similarly verboten, even though there's a comment on it saying this
> > > > isn't how one should do things?
> > >
> > > Yeah, let's not do that -- don't give people ideas. :)

