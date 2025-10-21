Return-Path: <linux-kernel+bounces-863483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A439BF7F05
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 009924E8489
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1EB34C807;
	Tue, 21 Oct 2025 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrHSLIQN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9434C151;
	Tue, 21 Oct 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068614; cv=none; b=dXkygYLtvbxif3yXztpABWXqLs0lMLaj27fuA5EJT6Dkf0Fj/gjE5tvUGyft36MaRFt4ZL33nKh8yamVK8r1mo29xWwvH2DON/A1EAezflI1Pyibk2rDlDonAFPTzDXqCXqowCw07f/rKYlSJLtcPNtzVQoyvJSYP06iB7XPSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068614; c=relaxed/simple;
	bh=xyrItL/Oko7IcvMF4j5xjyFM3GWwAEGO3Qw5Gma9kjI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kYurQsWaAtFG515DDU32KoKuk3SZpTSwlQHgLoOCa5QyEmjQXbSXEYBoPunr+jZeDXhgBVjcQGbW0u/3jz+8I+bjcg5cRFXAyn/my55kGp0C9WnTxGUwAhiDF70iQ0N4RJDjItXjCrg0xJg/HZIkhW+8CuJQaSoufmHZMx+5eG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrHSLIQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6D6C4CEF1;
	Tue, 21 Oct 2025 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068611;
	bh=xyrItL/Oko7IcvMF4j5xjyFM3GWwAEGO3Qw5Gma9kjI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=UrHSLIQN5PEaFeked1+oIdxevYxeM9BzJ2LDUPwp2FhLCBu6jC0VPfHyjHKZ+D5Dc
	 W1Bp1oAbknkPz1Ue6urijcb+730GCpS0VpCUQx1uUcMg39A4G/pTYoTSQ1ySK39qFR
	 BTzXJnJ7+bmdS75YH6dTyfamlF7hj4zfMgAEjsITZBIJ8sbyh0FMXv8N9BbrapNZuz
	 /4NOP7tkGDtE9KmDjWb4i+poh6P1mzs8rqK1gpLD2KBqwScuT5jP7jnMR/8ZKe2Www
	 eTTammgrAVb20s3Tv2eYPRA+9Mcej3X2fy6lbgoMxGg6s6pP5P1SL3qy3FUskJH3hL
	 Cfx98cfhLTW5g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 19:43:27 +0200
Message-Id: <DDO6PXJKZGOU.9AWQMAML1K7J@kernel.org>
Subject: Re: [PATCH] add `[pin_]init_scope` to execute code before creating
 an initializer
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Fiona Behrens" <me@kloenk.dev>, "Christian Schrefl"
 <chrisi.schrefl@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251016210541.650056-1-lossin@kernel.org>
In-Reply-To: <20251016210541.650056-1-lossin@kernel.org>

On Thu Oct 16, 2025 at 11:05 PM CEST, Benno Lossin wrote:
> In more complex cases, initializers need to run arbitrary code before
> assigning initializers to fields. While this is possible using the
> underscore codeblock feature (`_: {}`), values returned by such
> functions cannot be used from later field initializers.
>
> The two new functinos `[pin_]init_scope` allow users to first run some
> fallible code and then return an initializer which the function turns
> into a single initializer. This permits using the same value multiple
> times by different fields.
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Applied to driver-core-testing, thanks!

    [ Fix typo in commit message: s/functinos/functions/. - Danilo ]

Benno, thanks a lot for providing this patch as prerequisite for [1]; your =
quick
support with pin-init whenever something comes up is much appreciated!

[1] https://lore.kernel.org/all/20251016125544.15559-1-dakr@kernel.org/

