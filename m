Return-Path: <linux-kernel+bounces-594918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B02A81826
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 00:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C80424ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 21:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87322206A2;
	Tue,  8 Apr 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pivb9WHT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA76191F79;
	Tue,  8 Apr 2025 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744149603; cv=none; b=RRZuAYeu7xiLhw/P74gxAfNdlAp2Bo9vx2OlpiV80zK5ZykkmMlPkWbropGh4Vj+z15EOmp8Hekgnwrgz0kBObSCTucYaqGm5llE1mynvy8R5HCEtSrQr145uq6RcFx/56AsXUrHeR0LR9ZF2skNWCucFOa7vRgVsweYgrU1lyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744149603; c=relaxed/simple;
	bh=AjMKNMsrAuLwoFrp7noFAOmIvL9BDDzrxVNpfknHieU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAfX4vKvIy/WT4JqypVI16xnS9mDURDTgZ08h+LJSYHLZeOK7Yez9k/cJTCLW5D6b0uUbcf8OFJX2Nc0F8L9d+DPYw1nmKt5q+nGJpu85VO/prAP/TsT5pSxBFCuZ0DLQFIu9l5mJim5ibnLYTIRnHowKx5/FqWIqrXYzG7BI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pivb9WHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AB6C4CEE5;
	Tue,  8 Apr 2025 21:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744149602;
	bh=AjMKNMsrAuLwoFrp7noFAOmIvL9BDDzrxVNpfknHieU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pivb9WHTBk3nM3kLzdBe4Cgw3V8ZmhTAp68CWQSh4eFgVZr3Y5f6m1NzQTE+iLE22
	 8b3A9QxiWPKLjQRtFnBRqgDi8uMFmaRxUR07dM+ddGQiGgE8i1uwxdVOxE6SjLk3HT
	 WprOXVNhaxds+y4eyWOJrfe9eMlSY08bd/fglj27xh8Bnb/a/rg/fhXxPUYIbxnJj+
	 9tU2uNzYFQKZdvJIUVHHQtlH9KUCW3xmcJ2x2CDepzolmRN+CkRE6grim3gvruFzxx
	 Hpl23JC0h+2S55LrQ/AlAk0xQqXzma8PRfYDky7V0Lw4JVGEABRKqA/TVa/kvD0GBo
	 XtMIWG1FtfVJw==
Date: Tue, 8 Apr 2025 23:59:56 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, ojeda@kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return
 Result
Message-ID: <Z_WcXFJQtFTbHI6b@cassiopeiae>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
 <20250326201230.3193329-3-abdiel.janulgue@gmail.com>
 <nujfDI6IKBsjlQtGWaMrhjZSQYYeQYckCyOUs9jIzgZGsP1WTalJE0sSg6tp_WMACWo9mzuDfpdzsIlmkKnL8w==@protonmail.internalid>
 <D8REH728BFP1.2BGE9DTRP2IPU@proton.me>
 <87ldsahlxr.fsf@kernel.org>
 <NBhs6N93VPsKCxDOdnggZCiQWIxBfcYJU49nl2DmkqlTDaZet_q7V-_LjkS_uZPtkb8u2yW_oRh0TVjV3cLdkQ==@protonmail.internalid>
 <CANiq72mahS0jiOHv-7RE8QWQunYo0bJqeGo-FAVoUL7v42RsoQ@mail.gmail.com>
 <87a58qh1w8.fsf@kernel.org>
 <D91LB39LUIG6.1P7MMHZ6YHSMA@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D91LB39LUIG6.1P7MMHZ6YHSMA@proton.me>

On Tue, Apr 08, 2025 at 09:54:13PM +0000, Benno Lossin wrote:
> On Tue Apr 8, 2025 at 9:46 PM CEST, Andreas Hindborg wrote:
> > "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:
> >> On Tue, Apr 8, 2025 at 2:40 PM Andreas Hindborg <a.hindborg@kernel.org> wrote:
> >>>
> >>> But the `assert_eq!` would panic anyway if comparison fails, right?
> >>
> >> Previously the `?` generated by the macro would return out of the
> >> closure written by the sample, and thus it wouldn't reach the
> >> `assert_eq!`.
> >
> > Right, I see. So the question is whether we want to have the assert
> > panic here or not, of we get an Err. I vote yes.
> 
> The assert wouldn't be the source of the panic though, it would be the
> `.unwrap()`, but I think it's better to report the error. Although I
> think it would be nicer if the example could use better error handling,
> but this code is in a `drop` function, so no way to bubble up a
> result...

We could be more explicit and assert is_ok() instead and subsequently do the
assert_eq.

