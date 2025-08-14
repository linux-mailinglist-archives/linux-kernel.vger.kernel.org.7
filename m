Return-Path: <linux-kernel+bounces-768225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E98B25E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92E02A3A14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8306C2E7199;
	Thu, 14 Aug 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZE5IBOU"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2A2D73AD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159127; cv=none; b=sTLC9HvcKhufKkjaveP3F3zCf2rqlOkH9MBk4dLXTxsBsTZQx84pI/X9vQ4Ncbpb1X73vM+243EKrE4+n+BBu3ujqLkQrocWEierPk4tB/pPKaniAGoeEp+/6P3fjjgyGEG8/LrDDXQVLIUKB1kcd34q8tyWzWMu3frTATeOUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159127; c=relaxed/simple;
	bh=etPciUF+58gxBC38Z5tb2kbCgRKAGBYjba2+obhP3Pk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GJo8xLiD4IVUgfDDGarz1p5yRKLw1+BK4OHier5R3/WqeoZEFHoOz5RvH+AFSTNnylbP080px0fnFalnwkaZTQo/r+7yURmz4G5YlfZUEYfoLVa3mV/IVlJT1L7aRFwXsYtRCCgTtcq+TMKnPBb1vUP6ZdrUQZ53iHaM0lpqIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZE5IBOU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso3229295e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755159124; x=1755763924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iiv0D3Enw9HFquQbvd+ThrKyXaUitLTqjTCCoxDtDU4=;
        b=yZE5IBOUbz8EFYZpMjKI4pgWb2674opRK1u7Mp8CpZgBoEp1Gi+ABWV3tfs3ct8ifA
         Dlc3rjJG+hdeMN4QvAY3+NCxn3xL/o6RI2WU99gzxkMCd9QY3PHmRGcAPXcRv0twn73G
         TZ/rYCZmGHtXaa33MN4rV/ag8rNG9edLePWdLE/cBHExO+GTOqecCXAeHa2lIAY5+iAg
         C4/P6NUxgK6LLXEpCakQSiJxJJ/XlPp41S4yML41pEDIncEZAqrkNGUFcKkMDJbAK96A
         oYsoEjZ74t3ueGi99QYjBaY3KWhioV85S4s72nRV8M2IieZjpaX4vT0WbKdM2LeWqtbK
         TFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755159124; x=1755763924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iiv0D3Enw9HFquQbvd+ThrKyXaUitLTqjTCCoxDtDU4=;
        b=tRJqbVlvJNbYktpU4ZryL8s+Hn4Bxm5tGtaGI8lTTmkbE11MnuM1FzPTvqaG2mne55
         3kM+X/5qC5DpMza8s7JH1S60TXMSPHFc9VAa0pK80SdR8JQHV+oyHhoUPai9zccPjm7s
         aMtCwugbubWLxgY2Rup33pZR/ywb58feji45qxSwafgKHsN1SCrouDPetDX9JTpCHL/t
         Ff3F1Ubn3fb8CscVmTomg3N70IC3VBpWlCkYKZTfyifIB77i7iCVhenZYV3blJikS6FM
         4T239C8IdC5DEvqWt9vLarvXMpsBnJonKvJf3WijhuL2a+2pPtkS58oI7q4k4ukBJ9RP
         LL/A==
X-Forwarded-Encrypted: i=1; AJvYcCWYrzroAPtY018TpekGvMH7TpXYTH3pdd/+sUtdjL1CGcNIz2D2zVCQ1DRQrVzlNVQYSHC0xay766ZPc0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/tYkDu0fzjvfUY8zSbflOiaIti8Ga6ujYTQnYCOv6QQ8pQPF
	lAZfDYIMdPv9ZVbE+eQs1ZSdytG49jIGOMJZNOLXfNh6PjRpkw+k5aluBOD9FYKeWqNdGvRKucY
	0pkdxtQUmnfLpYqXSdQ==
X-Google-Smtp-Source: AGHT+IESv7C6uOw2zHqQOv3YRyUouZwm6W4bbO31jyAkUIflR+veVNh5T/iYXpCb7ihU/hXwmic0ConekAIa/1U=
X-Received: from wmsp31.prod.google.com ([2002:a05:600c:1d9f:b0:456:111e:4717])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cb:b0:456:1bca:7faf with SMTP id 5b1f17b1804b1-45a1ba14d28mr15596215e9.16.1755159124425;
 Thu, 14 Aug 2025 01:12:04 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:12:03 +0000
In-Reply-To: <20250813192621.25255-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716091827.816971-1-shankari.ak0208@gmail.com> <20250813192621.25255-1-shankari.ak0208@gmail.com>
Message-ID: <aJ2aUwi1L5RjK-X_@google.com>
Subject: Re: [PATCH 4/7] rust: fs: update ARef and AlwaysRefCounted imports
 from sync::aref
From: Alice Ryhl <aliceryhl@google.com>
To: Shankari Anand <shankari.ak0208@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, Aug 14, 2025 at 12:56:21AM +0530, Shankari Anand wrote:
> On Wed, Jul 16, 2025 at 02:48:27PM +0530, Shankari Anand wrote:
> > Update call sites in the fs subsystem to import `ARef` and
> > `AlwaysRefCounted` from `sync::aref` instead of `types`.
> > 
> > This aligns with the ongoing effort to move `ARef` and
> > `AlwaysRefCounted` to sync.
> > 
> > Suggested-by: Benno Lossin <lossin@kernel.org>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1173
> > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> > ---
> > It part of a subsystem-wise split series, as suggested in:
> > https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> > This split series is intended to ease review and subsystem-level maintenance.
> > 
> > The original moving patch is here:
> > https://lore.kernel.org/rust-for-linux/20250625111133.698481-1-shankari.ak0208@gmail.com/
> > 
> > Gradually the re-export from types.rs will be eliminated in the
> > future cycle.
> > ---
> >  rust/kernel/fs/file.rs | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> > index 35fd5db35c46..18cf579d3312 100644
> > --- a/rust/kernel/fs/file.rs
> > +++ b/rust/kernel/fs/file.rs
> > @@ -11,7 +11,8 @@
> >      bindings,
> >      cred::Credential,
> >      error::{code::*, Error, Result},
> > -    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> > +    sync::aref::{ARef, AlwaysRefCounted},
> > +    types::{NotThreadSafe, Opaque},
> >  };
> >  use core::ptr;
> >  
> > -- 
> > 2.34.1
> > 
> 
> Hello, can this be picked for review?
> 
> The initial patch which moves ARef and AlwaysRefCounted to sync/aref.rs is upstream (commit 07dad44aa9a93) [1]
> 
> Thanks,
> Shankari
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440

Christian maintains rust/kernel/fs, so could you resend this patch with

	Christian Brauner <brauner@kernel.org>

as a recipient?

Feel free to add this when you resend:
Acked-by: Alice Ryhl <aliceryhl@google.com>


