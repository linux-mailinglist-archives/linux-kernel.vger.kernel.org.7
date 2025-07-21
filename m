Return-Path: <linux-kernel+bounces-739454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FBDB0C67C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA8B1AA283D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D3218AD4;
	Mon, 21 Jul 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKg5UB/G"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529CA1E260D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108576; cv=none; b=NXSbfvP51n/iQ6FtedToHVGnP2qDz5uRngUJK4b9zMG8AEDrx2tlGBz36xcbVWO2BSZvJpB4xzlk+8gbNHk3HTLbQ++pMbA2LJCqTKBqBV6HbQXjuZ++UnqLzOycpGYUB+bPaBc+0RQEsU0t2YJf9v83fiBQICzXEAxSfRYEZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108576; c=relaxed/simple;
	bh=uMbi7Kxr8rvZ7kIsukRrp4ZI9YsrDaZgWVczVADFjIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oI+sbRj2wK9UXBtB5klE6VaHFc6tCBlJHiYXNonvaKctqttOPgtxy/Hs76y36JlJRZx05Zuajv/2pnosXg65cPLVXDeE83cnUxcNYFA5+1rq7fGbWuLbdsQ/BKqlt9DflQfQsm56z6t7WLJ3kJLm2a5biSfZICtVBi4t94v9z78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKg5UB/G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45619d70c72so41551315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753108573; x=1753713373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTmlftLa3/YVt1RZ5+485y5Gyr6GHR6cDRdtU6PtQ74=;
        b=VKg5UB/GNZmHLg07aYkm4xemIVnKjq81ZS6sFEHQDXm5TSPV5/8M83s1e2ymStzIwh
         1qymgNLw2w0FcavCyp7CMs8ND90kB5+uFHeyw6I8CTAzBkH9mutjYeCIpC+u1DZI9hso
         KiOo0al5PIvAp03ctobTeh4axgSsrFFuipnPGOnxFrciJ3ktWjs1SeLqtdeDiwfXgxot
         hAUuOW0ar7maFdR9AZmLLswOUPqmy6AMdth0NAO8HCHV0t0zFs2Bg3+PmkAdI/TiL/zA
         OG1kYOluvtuRF4XsfMY2MRi65t0Dys0qTk+m0+Uc/qvIplDmK85/990fdj56zPpySK51
         8+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108573; x=1753713373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTmlftLa3/YVt1RZ5+485y5Gyr6GHR6cDRdtU6PtQ74=;
        b=k/pnH1HdrG9yIYWN9q57Kd64VvTxIu5IIOvaeT7+Kjkwmme0wcjRPi63itVicsFdLn
         QZLoYdgVpu/yj+w2SWreKITUVgOtVZjoMVMVjZx8QaDFcaBeK7gAXgwAwZyb6Kwi8W7v
         M2kPqsXSKBlR4+ZVlWhkGRr/pUxj11G1PsH/65Iq7DZkRfhXg2WaBSxPk/Sf0l9qohpV
         OPz7G8fh6aq0RsC6lksNXyUf9pTsT1v++BbMF0V7Emg8ov3Vu88K0cPjkH8D7jtg2ruA
         jH49NdzbNZPx0goq1u+iqrPNa3mNoRKq990BigpYZn02qjCIm8PgBeYt+R9TUc5bfzJ5
         IAiw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Yh4BDYLqo27PVGqA1RvR6PalnrmZqGMol7JEq45xLzgd+HkPfmcRmSnoGy37pX4PpBYeaOOV9AfhAlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGaM+QVyeJnyrYIRYzxFydVJ4/+UzEjKSVLrxpjxFY1ktcb8Wj
	pvYg+c6S9i8e2em2MGuNct6uAV4Sw44ss3J2y7AAp8PdDg9yKI6tzcEWs1eV/Zu6A/WiTL48pSp
	kmmSwmFaMOaJIy6bUhC0W0EBLVxdW/Zf8p6qBWlCZ
X-Gm-Gg: ASbGnctlIi5S2qqCVQv/ktNHOeJUbmCSV+HmIcRF8qsl/NOvqactoELcuVBND56cPQs
	BggKbTw8HFVbNcswF/rog8I46XzHhtNYnstiRjUD3QMOjBvI2eOSchRiXW7rJ+MdfxQPF99jJOu
	vF93jPXg4oEXlEGERnXITk6Ps3dwkhZTv0eb/hGfsuk6+HWwEPBwldXHNi4EFN6GoEyPu/M0l5K
	YNZMfeLM3ZwgvbFmMZZsW33JLlVPAB03AiNHA==
X-Google-Smtp-Source: AGHT+IGSY4dsqLiio99W2pKDctUPS+XE0logFsjutpzA/f6pr5pm+OBm0u/2cQX4+KQJjnUSoHcgMnJBXPlq1m5pw7s=
X-Received: by 2002:a05:600c:6747:b0:456:1281:f8dd with SMTP id
 5b1f17b1804b1-456348caa04mr178354145e9.12.1753108572583; Mon, 21 Jul 2025
 07:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625051518.15255-1-boqun.feng@gmail.com> <aGKWIFVl4nwSl8SG@Mac.home>
 <CAH5fLgj1C-BVAfK8Qoaxb4hV=s74-SNPUeHq9LtmQ5q8aqcd-g@mail.gmail.com> <aH5FrrpORLWpDCkk@tardis.local>
In-Reply-To: <aH5FrrpORLWpDCkk@tardis.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 21 Jul 2025 16:35:59 +0200
X-Gm-Features: Ac12FXy_09uVssfF9ZpXS0xbrdTDC24Zuz9KFSNdkFLnm71hbdRkTgvYqBmGTAs
Message-ID: <CAH5fLgjajEq-FnVyUaNECZJYB67PoSARCfc=JPNpbr9VDtt6YQ@mail.gmail.com>
Subject: Re: [GIT PULL] [PATCH v2 0/5] rust: Task & schedule related changes
 for v6.17
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Tamir Duberstein <tamird@gmail.com>, 
	Kunwu Chan <kunwu.chan@hotmail.com>, Mitchell Levy <levymitchell0@gmail.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Borys Tyran <borys.tyran@protonmail.com>, 
	Christian Brauner <brauner@kernel.org>, Panagiotis Foliadis <pfoliadis@posteo.net>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 3:50=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Jul 21, 2025 at 01:00:49PM +0200, Alice Ryhl wrote:
> > On Mon, Jun 30, 2025 at 3:50=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Tue, Jun 24, 2025 at 10:15:13PM -0700, Boqun Feng wrote:
> > > > Hi Ingo & Peter,
> > > >
> > > > This is the updated version from my pull request last cycle:
> > > >
> > > > v1: https://lore.kernel.org/rust-for-linux/20250506045843.51258-1-b=
oqun.feng@gmail.com/
> > > >
> > > > Please take a look, thanks!
> > > >
> > >
> > > Ping ;-) I forgot to add that this is a dependency for Rust version's
> > > read_poll_timeout(), which is a dependency to a few things:
> > >
> > > * In the `Tyr` driver:
> > >
> > >   https://lore.kernel.org/rust-for-linux/20250628.224928.690831629261=
546521.fujita.tomonori@gmail.com/
> > >
> > > * In Nova, the gpu driver:
> > >
> > >   https://lore.kernel.org/rust-for-linux/20250619-nova-frts-v6-24-ecf=
41ef99252@nvidia.com/
> > >
> > > * In the qt2025 phy driver:
> > >
> > >   https://lore.kernel.org/lkml/20250220070611.214262-9-fujita.tomonor=
i@gmail.com/
> > >
> > > Thanks!
> >
> > I would love to see this land to unblock the above users. I wanted to
>
> Thanks, Alice. It's already merged in tip tree:
>
>         https://lore.kernel.org/lkml/175153176741.406.1455708180747580017=
1.tip-bot2@tip-bot2/
>         https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commi=
t/?id=3D7e611710acf966df1e14bcf4e067385e38e549a1

Thanks for clarifying.

Alice

