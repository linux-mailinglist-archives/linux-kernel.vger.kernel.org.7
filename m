Return-Path: <linux-kernel+bounces-868487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2005C054C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503641A63999
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643593093AB;
	Fri, 24 Oct 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzTYsYY+"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31318207A22
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297593; cv=none; b=JqcvcGXkt3ScmW1K2bbwRSY43ps4R5qaGHgneBu3IUeb5xLA1fdIitZy0qcoohnKugjRWBn0jA6vpEAUsf7sxTjtuvx+DgNawzmhDzeltGBbZYxQRVtHLWqPAJaqf2jFt6rxyHO1oE1LoKIZL8EHVt0BENlGfwteK0inq8IOdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297593; c=relaxed/simple;
	bh=1ygZcVGnCmKGz7NOebvoojWzWt2cpF6+mrcSswzdovc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EJ0dCHyCLg623E6cU4/F3LhlvSMViWHj5a0bMNbz7jL94esI5S03KChKsVghAoQtviK1OKH6JzGrBD1ED+v+5+IaHEkrgk5zvl0myCRTbJqTI+VsKwRUQQxgBbJhM2+aYOmhiBsdUoWq3W/67Cpl98JkA0B4vvItFGbiiBlEUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yzTYsYY+; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b6d580e3fc3so142450266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761297590; x=1761902390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jd/W2RriN/IcefKdT+b9L3eCBH6tlFv8DxZsI0zLOrY=;
        b=yzTYsYY+BQPYJyraSSOoOaJE/V6+m/0k20/ZwDHeuWMYyjEMjkuHMSgv8WzsucYm1R
         5fA6kcTMzlAm/1wG6iZEzX9eVv1c1rmYcSDW9LVVVZd15bB+qOksj3SKMyCMNyWauYv4
         wASzfw6IfxU9ac6UTUwPNwBRKI6givmYfC9ekMRHHjmOKTTmH458Q/UkVlf0PSd/LVoE
         xSPapWufBJ3AhPWqmjQhXfHR4FkMvrxmIHan4TJVY3pttbhZX+qWEzzFirfsFeVLYr4Z
         /m4aFXUTgiFsEeBHUR1kWPPMxugVo+DYMXkSIBBXhPfwC7C/ByVfLpNLsoHmIRHUv6jM
         v6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297590; x=1761902390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jd/W2RriN/IcefKdT+b9L3eCBH6tlFv8DxZsI0zLOrY=;
        b=b/b9nJ3Yauh0Pv1q0T30+rhsTjgwktDeiyXZPfO+tsE3LRzWs3IOtV49C/yKWCwki2
         P8yAiTrAbQdpKagGMNWXN02+jeJk/jQWyozoMgMkl2LppWxmjovENg1YaTCICxNChpY1
         Zi83FjWkVPf5vRO3+2LX7ZdeIaQmXaYa/jL1n2z3EUQA1vNcqRu1hdmSRb/SD/10KR6q
         AJA9MoTCpxT8CAXLF98agIa+OEAdwlPwPvqYDm4wr8y1geq8i0HScLMUCGigiZuiPerZ
         tqaveG8VpPwUcpoWVAtdvpHO7gOHwpSNiiT910V/8oEuP3dFmzowc2UwvnKLIRhJFwXw
         Q2/w==
X-Forwarded-Encrypted: i=1; AJvYcCWevpvG0QndeQAIoZdjPPAaMUTCWtvA7rUbATfAZhOLBuduBzzQkQ+5gRyLSssJZ0YsCPqtMTrFAuIKIsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Vjq4C/r4L9k70EITPk7hH1iEK9e4A7LRLcOlTL7eu0jLqEwz
	/57z2TpfQtbboVocwSvXBBhK1OJ6Z1jRQdYKtLOPIpRr5MjqOTWjohbLaltRdQi/wjmATZ5Pibi
	qi4S/+N40Yf/5h/7omA==
X-Google-Smtp-Source: AGHT+IEQ94U1fvSWcpXAWE2JvhcvcltuiNrRv5VNTTZpoM43pYSapuzJzbyOorltZUkC6l784GtTgNKGGWaxL1s=
X-Received: from ejclf27.prod.google.com ([2002:a17:907:175b:b0:b37:d295:d0b8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6e8b:b0:b41:abc9:6135 with SMTP id a640c23a62f3a-b6d51c064damr620414066b.41.1761297590599;
 Fri, 24 Oct 2025 02:19:50 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:19:49 +0000
In-Reply-To: <871pmshfku.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-3-fujita.tomonori@gmail.com> <DDO06754OMN5.G0AN9OCWTFLW@kernel.org>
 <h4wUwTMyHx85K0_CDEI0TkQoZFaEof5pJhADCtIUn01egSGxEcBVfQ6Y613ocOd0gU_j6X9g1agE9ealXqnE-A==@protonmail.internalid>
 <aPeTFMeVoIuo8Lur@google.com> <871pmshfku.fsf@t14s.mail-host-address-is-not-set>
Message-ID: <aPtEtbNUdZxhkz6H@google.com>
Subject: Re: [PATCH v2 2/2] rust: Add read_poll_count_atomic function
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	daniel.almeida@collabora.com, alex.gaynor@gmail.com, ojeda@kernel.org, 
	anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	frederic@kernel.org, gary@garyguo.net, jstultz@google.com, 
	linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu
Content-Type: text/plain; charset="utf-8"

On Fri, Oct 24, 2025 at 10:25:05AM +0200, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > On Tue, Oct 21, 2025 at 02:35:34PM +0200, Danilo Krummrich wrote:
> >> On Tue Oct 21, 2025 at 9:11 AM CEST, FUJITA Tomonori wrote:
> >> > +/// Polls periodically until a condition is met, an error occurs,
> >> > +/// or the attempt limit is reached.
> >> > +///
> >> > +/// The function repeatedly executes the given operation `op` closure and
> >> > +/// checks its result using the condition closure `cond`.
> >> > +///
> >> > +/// If `cond` returns `true`, the function returns successfully with the result of `op`.
> >> > +/// Otherwise, it performs a busy wait for a duration specified by `delay_delta`
> >> > +/// before executing `op` again.
> >> > +///
> >> > +/// This process continues until either `op` returns an error, `cond`
> >> > +/// returns `true`, or the attempt limit specified by `count` is reached.
> >> > +///
> >> > +/// # Errors
> >> > +///
> >> > +/// If `op` returns an error, then that error is returned directly.
> >> > +///
> >> > +/// If the attempt limit specified by `count` is reached, then
> >> > +/// `Err(ETIMEDOUT)` is returned.
> >> > +///
> >> > +/// # Examples
> >> > +///
> >> > +/// ```no_run
> >> > +/// use kernel::io::{Io, poll::read_poll_count_atomic};
> >> > +/// use kernel::time::Delta;
> >> > +///
> >> > +/// const HW_READY: u16 = 0x01;
> >> > +///
> >> > +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
> >> > +///     match read_poll_count_atomic(
> >> > +///         // The `op` closure reads the value of a specific status register.
> >> > +///         || io.try_read16(0x1000),
> >> > +///         // The `cond` closure takes a reference to the value returned by `op`
> >> > +///         // and checks whether the hardware is ready.
> >> > +///         |val: &u16| *val == HW_READY,
> >> > +///         Delta::from_micros(50),
> >> > +///         1000,
> >> > +///     ) {
> >> > +///         Ok(_) => {
> >> > +///             // The hardware is ready. The returned value of the `op` closure
> >> > +///             // isn't used.
> >> > +///             Ok(())
> >> > +///         }
> >> > +///         Err(e) => Err(e),
> >> > +///     }
> >>
> >> Please replace the match statement with map().
> >>
> >> 	read_poll_count_atomic(
> >> 	    ...
> >> 	)
> >> 	.map(|_| ())
> >>
> >
> > IMO, this should instead be:
> >
> > 	read_poll_count_atomic(
> > 	    ...
> > 	)?
> > 	Ok(())
> 
> It does not really matter to me. Why do you prefer one to the other?

I think it's simpler.

Alice

