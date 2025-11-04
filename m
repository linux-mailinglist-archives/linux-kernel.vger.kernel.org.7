Return-Path: <linux-kernel+bounces-885388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083E4C32C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D27518C06D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241812D9482;
	Tue,  4 Nov 2025 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YulHaBjQ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10C2D3A6A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284330; cv=none; b=a5QVrDaviVFZLJ7mjCu+lo20ZI23UoRiZpuZiK/8+m9MrwuAeLHqA04fKHg8qAK6Qxtx5GSdWZcxGclUsD9RssbHjzd6OVa0N9gpN3vtQo+pDs638zjPlXBueSMtnRwLnryA4q/s/2xzGZx9eT/ih3qBXI/9k/eL630vYxjRaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284330; c=relaxed/simple;
	bh=K4Iyxi52gh1Iw5mMl2HUNeLP4ewV8sTogXEjAzGJ4AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXtK9looDdLCODmO+O1jNQXpDgit5fzr7BSZ1Go7DEgTOrTp4A58Di520mHlc5KuisBnAygr57+/iNrK08BF0gs+O/nIvn1e6uJllef3Dgvn+qABT0fZ+e1r48Rwhc0x98easzzXrvkFMeP7ZFuDoRO592YPqWpLsON8aBQrZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YulHaBjQ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34053e17eb6so852272a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762284328; x=1762889128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cZx+RW3Kt24V+mQj1nrZgt3YKwbbGOTRzEZ/APfqy8=;
        b=YulHaBjQLep+BxaF4go+ruxEoS+ZiTtfZh4ABv90s+iVii+093rI5CCgJfusCW1O47
         9Tj8VNSfJMJfLFLduKczLAvy7ar2TG8zjel95yMd4DsgQf8/I+BWqJ2kzNvHLN2y1/1w
         Vvw/1yH/uF4U0JmyUSrTdwlEQibdF0+YhD4nFT2WBsSd+tTTNeYVNQMzhO7NUILHpFYV
         9NlLEPK4NUu4dr3hZiD/AN6J4NO2O6AGR450IJ2j2+B0gJN9DqA0Ozy0gJCNI6sE5U6q
         cSPYtRPzT2Pkw8UcFH5sxHykLnvCXrBei2HmlCrQCrkWQhrFI3HfS1U+OL6fUHEP4z+/
         Tubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284328; x=1762889128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cZx+RW3Kt24V+mQj1nrZgt3YKwbbGOTRzEZ/APfqy8=;
        b=rsc9THUaghn5FM2tDwLfZxh+BdoQCN5v8z8C5GVYDmK82Ns4ntTHVExld8/YpvLQpW
         sXmMTzis1+y7kxgZs7T78d0czc49vkv4maqEuam+L1fviyhsQhLzNGJkqt3ZRI5fq+4D
         r+L3jZJJIA/UeMuNd5XZdG+mHCKd1AU48terY/S+sLnrOEtPq4Z5naYMATr6K6FP3R+W
         iPe2ZM8Ics+3ZFJpRDMwj4rHiDrpa4fkF+6Dd5YaIw+7MCGpvZtMsOPOw2qlnbWuwdNc
         lzQQ8yY51yZW93kw1d6SOGc6dtrAndk6hVykjWvdJYfEKxjO+kZEkiY1GPdvvTxrfXFy
         MUcg==
X-Forwarded-Encrypted: i=1; AJvYcCUdWmzq20ck45bl0fJ587IuK2UEIpIZP7PsDemuBtSAe/s3GZnk6u2rvnfShP/gC2QEbr7XREKtth40JTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZaLixp4IQrXBIhjIO09lBoD/3zTAp3Y0ntFQERME0f2I5Lh9
	KikIK5hN3S0kgTuxSQzFkp2E3HX7WW/FzuE+6fQSriR5LLkH2TQlsymZMyycxn7rbpOuvwcE1mY
	VQMY8pd5OhD6PtnCOF7/ns/j+3TjqL6w=
X-Gm-Gg: ASbGncsCBFPi+RPTZ27noLmEIGnRkLb4XgSgdMpScMFZbN7dmVN4k9jI4vxjAU4kXAg
	HpZI3RTYQYEmW9nBWh+AeTf/BRs82wEUayl17AwjLIYSqNW3tA8arEQEC2R/h3zAgycLQwE8ysx
	wgwTfJR+85SwceDLeAV08hlYoI/1xm7rRAlzX+FIQk+E+401RHyjkpXzcWZ+vr7Gc3xlxgmO0nC
	YdsN8bVnHXEa7RnBr7WURQOfu56XcqbS5YxY3TX7bOxnEn8EtzrmVnVvTRjSOIgE8ENYG7M1Gwt
	KgZZoIg91CFKxhkcVitWQUE5xl602UVupVmSfRgRmKtg6lNfwQRrlQ1ANsz1vxM7BuT8OSFBD2T
	ZVcA=
X-Google-Smtp-Source: AGHT+IFWzYsYUL37lFrxSC7sVl0Ij5MeA0lOHpSQOZvdZ7ftbuS95sPOKOarVGGOk6+VoduotS4rq+ThkHUUIHnXHbM=
X-Received: by 2002:a05:6a20:258b:b0:34e:8e9a:c610 with SMTP id
 adf61e73a8af0-34f8630155bmr221747637.6.1762284328313; Tue, 04 Nov 2025
 11:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101094011.1024534-1-ojeda@kernel.org>
In-Reply-To: <20251101094011.1024534-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 20:25:15 +0100
X-Gm-Features: AWmQ_bny94bBmKIB7QhLmeowyrAuyscE1LVW-SgNclTZu6rQpXUrhoj1poxn8j0
Message-ID: <CANiq72kWcptN+hu+gMwN2n8WkXrOku4kCHkSRsMzJmQeiCAJOQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Huacai Chen <chenhuacai@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 10:40=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust 1.93.0 (expected 2026-01-22) is stabilizing `-Zno-jump-tables`
> [1][2] as `-Cjump-tables=3Dn` [3].
>
> Without this change, one would eventually see:
>
>       RUSTC L rust/core.o
>     error: unknown unstable option: `no-jump-tables`
>
> Thus support the upcoming version.
>
> Link: https://github.com/rust-lang/rust/issues/116592 [1]
> Link: https://github.com/rust-lang/rust/pull/105812 [2]
> Link: https://github.com/rust-lang/rust/pull/145974 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

It got stabilized and merged upstream.

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

