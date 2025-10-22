Return-Path: <linux-kernel+bounces-864439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA67EBFACED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641B418C3CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD3301704;
	Wed, 22 Oct 2025 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YA7Zsbgr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B7301486;
	Wed, 22 Oct 2025 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120450; cv=none; b=dVcRO62WlNU3q5/YmG7F+5HtV9d696OqmoxqT/6v344zy/DEyS0Da4UmvERPEl9Rj11YOALTzDG4FWBxsfettg6gHUZlWEVdwpXh/M2BsG21CgN2VmwIOJnnNVM7barpbzgb9P/ziEOQnO36DX+x9bOZW8xgtmprdSWug9LNtOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120450; c=relaxed/simple;
	bh=7P9bSwt9jOskTfNtBeggd17KP74iKa0lenHo4xPTL60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg5oP5bGdf9p82foRsTXq5a3NwCi/kLzjR9R24ukzDdA/8HhVpZSAHg9CGjgYeyHeIgLibGB6LNLJzEEUCCCKQKL2A+UGTJKNbZm4gjLTja3kSidaUWoZ8aDZ4lLROwtn263uNbIoilU2hzobQcrIcP9aV3Cfm6XqLoayR/+2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YA7Zsbgr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7P9bSwt9jOskTfNtBeggd17KP74iKa0lenHo4xPTL60=; b=YA7Zsbgrfmg28/QhNIsKgbjysl
	TT6LCMFDNIiEb5+u4JzWxEWRwgCDcTFmv/mzfaBNd2yb2LjEUuwmaDfLfVyhYA3CzwPGif7GfNGvU
	0AfpUnvozCBCkuJIeuXDuhkOE34HQsmRo/rEaBjNwgIugDj9UefpzQ8l/eYG0n0Ki6UvpEaybcb6x
	aiOs4c68IVF76xGnh2UifiGBq5c9SICT/yBCklF2ha8nCtvlFQQT45HqMsI4hljdqLDIojqUgXaB2
	CALKsiL33eEqP4W9dk1n7yJ7Ji/x/7DL7xTmAS8+wSKCAI+HIAU+mYzYPQK7KMWIR+EBFxgkDuRCc
	JVNgYymg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBTsK-00000000I4e-2f2Y;
	Wed, 22 Oct 2025 08:07:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5F6733003C4; Wed, 22 Oct 2025 10:07:17 +0200 (CEST)
Date: Wed, 22 Oct 2025 10:07:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthew Maurer <mmaurer@google.com>
Subject: Re: [PATCH 0/3] Remove the usage of Rust native atomics in debugfs
Message-ID: <20251022080717.GI4067720@noisy.programming.kicks-ass.net>
References: <20251022035324.70785-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022035324.70785-1-boqun.feng@gmail.com>

On Tue, Oct 21, 2025 at 11:53:21PM -0400, Boqun Feng wrote:
> Rust native atomics are not supposed to be used in kernel due to the
> mismatch of memory model, since we now have the LKMM atomics in Rust,
> remove the usage of Rust native atomics in debugfs.

Doesn't rust have a language feature that allows you to blacklist them;
ensuring they are not used?



