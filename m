Return-Path: <linux-kernel+bounces-721238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CA7AFC674
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A0267B2FEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052432BF3C7;
	Tue,  8 Jul 2025 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpvCR1Rh"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECB21D5B2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965246; cv=none; b=MA50DwlnPZZ8EXhAuBqSo3wkbr3VzURsP81Koq6POmioDjO4LkYVY351EPr2I/kxfvuSvKf839mTur/Wf7u4mSsP2I0pjTbWwmysB8UEMLuyhAAQGTKbVUWuNcsyO+NOYmGURex/K3q08jB6KsSPbJ3xtuKPPs0fGDSJj0jNpew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965246; c=relaxed/simple;
	bh=oKiHS2QwaWhx4aHXHXDOqQrhGwenflpYapHEQjYl9NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L664z8bFAJ/iZ7AuOAehwEI3GSfO5dLkb1wqETD9sTAVTXWiEmldKAlvKWofa2sMhhm6eslCz7itmA0KM0JswQSlnclRdn51SHFpx4eK3XyUbvwMz8Vwx1oDQGEOlYhPBC9z4GdhLR8Pwonppvr6d69sOAFYzHHrplB6y2aAzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpvCR1Rh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so3375152f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751965243; x=1752570043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fAlswa67s9tCEEp5OLnodGYtTI7dff1nxXHYTx812U=;
        b=hpvCR1RhJ8BM2sJEPgmbYOP4Sjo0RQsrgfWrCjT3AdQQATZb5RTSiyBl+Xuc52BSAZ
         PfSykbFMlmTuf/8ZJcq8USaNksvvJ86XMIdoL6pjHpnAAak2t9MFC0IysZrhpIvJAFUA
         A0/ZejF3Dd5u+HUGiOLKYNPMctlCqPKx7EAZm27H8KTTeMQqoSGILQdtVRtVODkMJVnV
         Zeqeleq+MnfWw152AG9DRH1SMCC+sIcJUAFXLaygEk3CaJvmxngGQMpmEY+q4XA3yuyL
         f9Tv/IvOa9haiUXwaODY5g4EwOQm3TtAFp06tpDsBdkd0TWJKZI6IcTFRI//dzFadWLI
         p6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751965243; x=1752570043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fAlswa67s9tCEEp5OLnodGYtTI7dff1nxXHYTx812U=;
        b=rqVNFXjBNgNmowvc9mItTPApAq6ahmsjST9AuWJoG09VlyonPw4aSsPT1NhkoG+qBO
         9l0uBWNCt0Ko7VBYF8He82pbA9yt6TM0ehf7H4VUzFMJxfEf2oTnVWlbNTbZyMyZn678
         TcRGpBnqWmIQwzS9P05EUTqqsLP3USYkBDCyhjPMGUfq5v+QJZmKzLZsEHILw58Ey5j+
         yDIq0zHYGG3crG1WTPIlsIBos+HDm6waGe6913SMk6Uj+Q5BzJXkr0ZkuChUcTLqE3ue
         X6zok6uF9QXxBqmnD2/Ve96nMvxLc4YrdwvKEErVW/zZDMiZpqy43AyAt/PJBVlO8pv9
         KrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQZ7nyO3P3UzAxfNjEn532oGHMmX6KRdhF70Baj+DIEr1elmKJw2TLnIgqUj0FbaA5RGhRiQvusvSrbUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZC5QV5m83zCv1R02tJ/c+fYMlBPTiwN9R6WWE1y+AI5aqac+L
	TUlD1YNWUx4yxe0wb5DEUGMOHiSAgnlB6JuE6qaWNq76d4+vJ9loyMqZq713/RbLb0q36XgLmo2
	B1AHuqfzu0/w0Secfzrnd63ukPTo2f5djx9YYyCft
X-Gm-Gg: ASbGnctzmObIf3rWl57OfKwWnClkooOOZGpCITaKXV7cuwwFlFQoHHtgG+8Dx6/+UDy
	m013V7rudmCnwukXxexrkppD+ddhcYGClzAxrCGWzkKCWlzwBUXujXWAo/44H2+edF/8RR71j0A
	ZDAvcG420QppEdThq+q8iOt3RHgSIz/HzWhkSp5LtOd9JaZWps7LYvPpRL3AvX329mQvfGYbyV
X-Google-Smtp-Source: AGHT+IH5ZMoI2SoH4Y+a/fAF+bc85q9nK8PHUbdQ9aUoJUXw0mepkCi34+aNRnk2VfCKiIbsEaGEwLKTb04V6G/hB4I=
X-Received: by 2002:adf:e185:0:b0:3a6:e1bb:a083 with SMTP id
 ffacd0b85a97d-3b49701ca8dmr12897112f8f.25.1751965242575; Tue, 08 Jul 2025
 02:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-module-params-v3-v15-0-c1f4269a57b9@kernel.org>
 <20250707-module-params-v3-v15-1-c1f4269a57b9@kernel.org> <miAy8nyEfpbNOEEKc8GGbUJCVpgjOlfffFKuSdwzwiFTR_Q-U3oUWKShLk_Qed5HHKwUEK-f_UA6nJbhrubQdw==@protonmail.internalid>
 <CAH5fLgiKo=jN_V5cAe_AJqxxp7mQWqhKx7knkEj6js3yiU9sqA@mail.gmail.com> <87cyaboypx.fsf@kernel.org>
In-Reply-To: <87cyaboypx.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 8 Jul 2025 11:00:30 +0200
X-Gm-Features: Ac12FXyPWMUr7E_ukuI-GyjKR418XEws8Yf2arU_DB6yQ4eyibRsSxTLgENy7jE
Message-ID: <CAH5fLgj6mfkvnOCO=EQSz9pyN5OFRF3z3yGfyZHkLzqxjsPJ7A@mail.gmail.com>
Subject: Re: [PATCH v15 1/7] rust: sync: add `SetOnce`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Trevor Gross <tmgross@umich.edu>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Greg KH <gregkh@linuxfoundation.org>, Fiona Behrens <me@kloenk.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 10:48=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Mon, Jul 7, 2025 at 3:32=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> >>
> >> Introduce the `SetOnce` type, a container that can only be written onc=
e.
> >> The container uses an internal atomic to synchronize writes to the int=
ernal
> >> value.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >
> > LGTM:
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> >> +impl<T> Drop for SetOnce<T> {
> >> +    fn drop(&mut self) {
> >> +        if self.init.load(Acquire) =3D=3D 2 {
> >> +            // SAFETY: By the type invariants of `Self`, `self.init =
=3D=3D 2` means that `self.value`
> >> +            // contains a valid value. We have exclusive access, as w=
e hold a `mut` reference to
> >> +            // `self`.
> >> +            unsafe { drop_in_place(self.value.get()) };
> >
> > This load does not need to be Acquire. It can be a Relaxed load or
> > even an unsynchronized one since the access is exclusive.
>
> Right, that is actually very cool. My rationale was that if a reference
> has been shared to another thread of execution, we would need to
> synchronize here to see a possible initialization from that other
> thread. But I guess it is impossible to end the lifetime of a reference
> without doing a synchronization somewhere else.

Yup, a mutable reference generally implies synchronization.

Alice

