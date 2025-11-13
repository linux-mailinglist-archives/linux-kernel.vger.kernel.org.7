Return-Path: <linux-kernel+bounces-899006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0871C5686D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F12F3AE2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F62D7394;
	Thu, 13 Nov 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPwhSTpJ"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2D2D23B6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025262; cv=none; b=iV8TW1CsCtdkCHhvTK0y+iYxRxDoLyyDggvi5JfvYJJcDhSHiNt/keZmyMiNWRv/Sovyfn0CX+FLKUcW0uUrAnAuoU9FFIkCFZfiZgDIk1+HMlCS0xWe/5ZMN73JMhMUdlce5uCliyt4vcjbQqVyqUaL979ASUTDNf2p5JtdKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025262; c=relaxed/simple;
	bh=ixMIOZhD0/70JnbtzbP6Xma0+jz+MweJQXVsIXaeEkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TRrtVuTcBH7fpDAVuIUHBbKnfFWzkmU8+W/5NMY8sknlTgXCwz1SRZYciomQTCfuvKeiOfjH2/IAauVQ1gPihQYdrO5zSc1v1UoyzkHS/GGBCcxhIhbCVYi7zZZKslfumFVXAYV2i0XKd12OGCUXqQT138nkCMEUtgaDYntsJLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IPwhSTpJ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b3339cab7so306162f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763025259; x=1763630059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixMIOZhD0/70JnbtzbP6Xma0+jz+MweJQXVsIXaeEkg=;
        b=IPwhSTpJ4h9CBul70I0nCXAHS5/QCsuJrsCqmEaFt+muovAfLMJk2wi6h+3uEgAHA/
         LeTOhgPLaX49QjQFO+Mfmii3iHQmlI9R7rMgwu6/7WmH2QNxfyTfWaL32ft8Mbn7IOzL
         ccHaIzGtgUnfOtOmFVAO4fl11LL6mODb+UOybhGdlQPX/AH0WEf//6OriCY7m0V1Uby7
         1D+oHQNmj4krqRxjshvp3ALsrME/3u7f15isEd0Al3SY3ZsW3T5A21aAGHFBapGQkSrx
         dAJYR0Sv7/LJ/fMFQPHqvejz4fqHj9VRhU7rLNlwJv7YeP7K/s9AFfKIYW4F2/0313/q
         G/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763025259; x=1763630059;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ixMIOZhD0/70JnbtzbP6Xma0+jz+MweJQXVsIXaeEkg=;
        b=bwcYBAhVGqX4rEEEdaqmod1J0IAL6ATTQquRRGZynb1j39G6NfqQ+zFk/BGLn1zL6Y
         A4vO+ufX7gr+ccEYdWDJM6a4Q2jnpNURAIS8atWBeUr/8Q/7vMIdSwSsWx9hhKpp7VnY
         uVvT148kSYMTo9M8ZNKu+nZ7JGkzVGp0LQasXvnqdE/jt6yp1tWePh868IVJDT211Tlg
         V85oWzDnmfaVEj8HsScNby5qu/7KOXMagYKmBd+gORhO8bXPm2EbmEPqr67e9MZCvC21
         oe9eI1VUzzH0ylB+kfYq5wS+CxtuCMlCyl3fU4eKYfQGGS27S9Fle9hAsciYFz2Q5AUx
         pokA==
X-Forwarded-Encrypted: i=1; AJvYcCXIlc4vf6EHZ8YyL1ePek864L/8aF0kptbicbHahYrB6XPjEwISVEGOtfxrPatEq+NViYkI9uB+IvK9A+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOn18j0knC8SIW7y7Eg+sdhrONnfIZ8GQLpL5U2hGq8qHGltF
	QN0XFSr1y8EQ+evVZZnH/a7/hJPokiJQuTwRvwzg+OQt+ovmr/SQdhXMhlkKvrnNOMS9C1tiKTx
	e1WsmS1/61Gs7dcI1gQ==
X-Google-Smtp-Source: AGHT+IFW/uK7rukH8lOhBTxny9oRqQsJbj1R6wN/AoqVDmx+yvVrDe0Qkq27CvYv7nilaGtcLciqMLlKNMvRLUs=
X-Received: from wrtp18.prod.google.com ([2002:a5d:4e12:0:b0:42b:3a01:7810])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2086:b0:42b:4247:b07e with SMTP id ffacd0b85a97d-42b4bd90a34mr5310747f8f.25.1763025259157;
 Thu, 13 Nov 2025 01:14:19 -0800 (PST)
Date: Thu, 13 Nov 2025 09:14:18 +0000
In-Reply-To: <CANiq72najqKYQGWpc9UuOnDzPELiFB3hmFYmX-7pk8Eh7zA+Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
 <20251112-binder-bitmap-v5-6-8b9d7c7eca82@google.com> <aRTbX6RPsFf0NW48@yury>
 <aRUZq0Fo6T1f3lOD@google.com> <CANiq72najqKYQGWpc9UuOnDzPELiFB3hmFYmX-7pk8Eh7zA+Rw@mail.gmail.com>
Message-ID: <aRWhakNj7_DGZDYC@google.com>
Subject: Re: [PATCH v5 6/6] rust_binder: use bitmap for allocation of handles
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 09:32:10AM +0100, Miguel Ojeda wrote:
> On Thu, Nov 13, 2025 at 12:35=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > Although we should never hit this codepath in real code, I don't think
> > we need to kill the kernel. We can treat the r/b tree as source of trut=
h
> > and adjust the bitmap when mismathces are detected.
> >
> > I could add a kernel warning, though. That shouldn't kill an Android
> > device.
>=20
> I guess you mean warning in the sense of `pr_warn!` instead of
> `warn_on!`, right?

I was thinking of warn_on!. There is already a pr_err call.

> If so, could you please add as well a `debug_assert!(false)` on that path=
?
>=20
> Thanks!
>=20
> I will create a first issue for the combination, since I hope we can
> use it more and more.
>=20
> Cheers,
> Miguel

