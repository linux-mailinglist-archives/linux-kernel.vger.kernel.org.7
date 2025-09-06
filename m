Return-Path: <linux-kernel+bounces-804043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28766B46905
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9584FAA5728
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C89261B9B;
	Sat,  6 Sep 2025 04:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="AfoN5PEX"
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9A111BF
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132809; cv=none; b=LZwZn99oI+ymMqvFOfRZGL/Fe+C8RuT33aKbu0DEP6Ly/+SgC7OYcjc6kGgTugkBQto8eJD34uZNe8FS9jHyJZFgH236dcxMnsc0hOMdKogfTDTCGvgkbXxsU3e4jXycxSgchrqk9/hC+9stYhDMtL+ibPkZccPEB3FTDysjbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132809; c=relaxed/simple;
	bh=KwC4lpDLMxPKVwVx5Dl2SdHtr2ZSyZF3Pd6Q8PgYf4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBhoDPh3tS4mMBXv4maEq0+zTtWk18sqYCGEI2ZVZsIdZXHmqJU8BhtjT60RPO1jZhJs7Qla+FIv0aK1LnLIqbE8jXUZ+O1A5LOP1qu2oeppHFvMAYYLcF8UiRdzATC9PkJ7QDJAnCh7EUKaZ7PMVHEoQ4E42SDDgYSdJgBPSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=AfoN5PEX; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132805; x=1757392005;
	bh=oNqeH4xFdj3XF1b/TG19arHO3NxoRGMHAmffI6OkA7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AfoN5PEXKTl4MZ8d6Ir+zPc/xSrm3Q93ZRkNe6Lhv5qrC4sF4KF9AX1SEm/+s2bzf
	 B/T9MBahEOJlZtR2p+nQP0OFxRgWm3fUUpRmafiiydyvCf1e92ojZBrNDtYNg4bALf
	 NPbCf6SKGuw9N4ZCRivEUbNbMrsS0OZJZ0TAHMul/1c0pr8XiDSoVevr4plVNQciCI
	 5Cm6s+u/WKXA5wiZnxsKUxavNFnme+YGwQPwDC0/MfqQyEehUHcCXWhPJncNsvMf2Y
	 jnBrcDcGYppPdFkmZzEAtkwuu1eqP+NidYKykkud5dS0JnNv9tMqR5tBeH2JI8PFpH
	 x/ucfzaENwUvg==
X-Pm-Submission-Id: 4cJgCR2krQz1DDs1
Date: Sat, 6 Sep 2025 04:26:40 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>, stern@rowland.harvard.edu,
	Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH 14/14] MAINTAINERS: update atomic infrastructure entry to
 include Rust
Message-ID: <aLu4ANZWDhuC2gMs@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-15-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-15-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:41PM -0700, Boqun Feng wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> I would like to help review atomic related patches, especially Rust
> related ones, hence add myself as an reviewer.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/r/20250723233312.3304339-6-gary@kernel.org
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37a753ec2aca..65499b9303e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3991,6 +3991,7 @@ M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Mark Rutland <mark.rutland@arm.com>
> +R:	Gary Guo <gary@garyguo.net>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/atomic_*.txt
> @@ -4000,6 +4001,7 @@ F:	include/linux/refcount.h
>  F:	scripts/atomic/
>  F:	rust/kernel/sync/atomic.rs
>  F:	rust/kernel/sync/atomic/
> +F:	rust/kernel/sync/refcount.rs
>  
>  ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
>  M:	Bradley Grove <linuxdrivers@attotech.com>
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

