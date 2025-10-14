Return-Path: <linux-kernel+bounces-853080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA60CBDA991
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC10C19A09BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2CC301466;
	Tue, 14 Oct 2025 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ISmccAZb"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154143009E3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458915; cv=none; b=Hm76IFM+ae4YJbBHsjfIGaIEjl9YSnCFN8XLopzmaEsnQUM7jo/Fk4rqJVFFPg8R6U+BVXgIfZ8ALmN37GUUOcpBu8Vcm9KIF5eF/tuitHv9j5Ny3ah8XgUyUp4s7tEchP0mtFR8GuvJYhjke0WjDZqz/w35VXQUE4THMYG0A0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458915; c=relaxed/simple;
	bh=1ockt3UvGLECOAaQWH6tVkRd0+TsZ62TiYm4MpBPTSI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BwGGSYQSjQmtxz8dyQZ+l7UtZNu2zHoWrmeF7UuKfzlnLgESvg8tkmCDBM+Mt7spmb2+eXgorHBT4Wr7UaYFN4SzT9OR633WZiU5ICdKuYClVQjcPpjGpIMNDiY3aFuwf+Jo1qobP9+y8SoRJqIqu5UxX/lEOWzP+v/tC9AB+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ISmccAZb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e46486972so33708245e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760458912; x=1761063712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGEZTXFiD8LOPaMPJT+QP3xsnmMASODltHyOui+E240=;
        b=ISmccAZbctkjFKHq3yexyZB2/2LDRnjMMWQM7PMM5fauh0IleH8JWDdeaSFu0OC/2g
         o+Yd4ZtcpUbp0ePgsAb97vYSXgKijqGTNFuG1ItRceSfJ8vEnOkit9FRaV2k52LNAEYf
         ZaXXmyWCB+SjILKV/bPBlGK9CusbS64xb+VBkCwzAA8tlAyHITBYO9ShSsJkB618UlzV
         HAf2NGuXQ10nFW/4gRmPKGZX8nyw6E2cQCdR3L2pFOuQNDbO0U9sXVm31PlWT3C9iAiW
         Lpl/qKj87auA/B+w4OaxQsG5soqipXiXDG3hYMHeY4JyE0jezFs6SCMgcx46p8+I0anR
         9i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458912; x=1761063712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGEZTXFiD8LOPaMPJT+QP3xsnmMASODltHyOui+E240=;
        b=fogRQTyea9Y8AfJtTS1DHDR269BVEY5q9OP6jbE3Shw0Ix9CfmfvRSrA0wH7q2RY5d
         3OCoDvG4sgBDGNZyD7q2HEzDp4QoeIVrXvcppV87+LGzNGfDumL55KajeSV9EjemetgP
         w1b1xIKc+0cPPfvF9ZyGAYCgc5ocPDinqcS2Rm2GG7TomDy5uwwqKVgJGsfhSpLeUnBY
         EGct481QP7nfftymLxvvrCoJLi3L7fLWpE8ZWQFub3/8Hlc/xMzl7KwD6YtXDjKE90kv
         /ps+/p/M4kmuubvy8/jTomXyoJuLETwYW/TB5rrrc6S4fhhYjNrbOoeBfk0Kaq3ppjGh
         Bo9A==
X-Forwarded-Encrypted: i=1; AJvYcCV+Kk8SBZZr9vFwvMaFRsbY8NGZOeDTjtfHbw9nQ820H3osPuHrgCTUMjTHBQ8OwTiOHdBxpF1TwLrZ4ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZzxEFvA+MEuftGHb/tgXa9fiB4YhHXPYSkjn8bK5p8AXtzvQ
	lPw5AuYQAYqteb0JhHIyMkZV8NOfQquJq4IIz19AvqDcJFmoXyj8TXsFbtVljdKjsaw7mdDB+zk
	HDMqlRMrgvW31rHqiAQ==
X-Google-Smtp-Source: AGHT+IHoAjuapMOgn96BGUuObSLekFaVbtcXEvLwM5YNydoj7wu3jFNwPTugPL0JpzleSqoLJxGWun+sdMDP8cE=
X-Received: from wmvw16.prod.google.com ([2002:a05:600d:42d0:b0:46f:aa50:d714])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4688:b0:46e:5df4:6f16 with SMTP id 5b1f17b1804b1-46fa9b1788amr171616585e9.35.1760458912468;
 Tue, 14 Oct 2025 09:21:52 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:21:51 +0000
In-Reply-To: <aO51pV5WSmqnT4rL@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013001422.1168581-1-ojeda@kernel.org> <aOzET46lagm-p8go@google.com>
 <aO51pV5WSmqnT4rL@yury>
Message-ID: <aO54nxGil6a5hLQN@google.com>
Subject: Re: [PATCH] rust: bitmap: clean Rust 1.92.0 `unused_unsafe` warning
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Burak Emir <bqe@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 14, 2025 at 12:09:09PM -0400, Yury Norov wrote:
> On Mon, Oct 13, 2025 at 09:20:15AM +0000, Alice Ryhl wrote:
> > On Mon, Oct 13, 2025 at 02:14:22AM +0200, Miguel Ojeda wrote:
> > > Starting with Rust 1.92.0 (expected 2025-12-11), Rust allows to safely
> > > take the address of a union field [1][2]:
> > > 
> > >       CLIPPY L rust/kernel.o
> > >     error: unnecessary `unsafe` block
> > >        --> rust/kernel/bitmap.rs:169:13
> > >         |
> > >     169 |             unsafe { core::ptr::addr_of!(self.repr.bitmap) }
> > >         |             ^^^^^^ unnecessary `unsafe` block
> > >         |
> > >         = note: `-D unused-unsafe` implied by `-D warnings`
> > >         = help: to override `-D warnings` add `#[allow(unused_unsafe)]`
> > > 
> > >     error: unnecessary `unsafe` block
> > >        --> rust/kernel/bitmap.rs:185:13
> > >         |
> > >     185 |             unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
> > >         |             ^^^^^^ unnecessary `unsafe` block
> > > 
> > > Thus allow both instances to clean the warning in newer compilers.
> > > 
> > > Link: https://github.com/rust-lang/rust/issues/141264 [1]
> > > Link: https://github.com/rust-lang/rust/pull/141469 [2]
> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> Added in bitmap-for-next.

Is there any possibility of landing this for an -rc of 6.18 instead of
for 6.19-rc1? That way, the warning won't be present when compiling 6.18
with rustc 1.92.0 and newer.

Alice

