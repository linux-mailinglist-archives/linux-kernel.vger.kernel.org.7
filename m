Return-Path: <linux-kernel+bounces-863167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF21BF72A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF23481EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8CD341ABC;
	Tue, 21 Oct 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvVDD/E9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94F33F8C1;
	Tue, 21 Oct 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058014; cv=none; b=UXpDLVnXQrkItiN7IAhyRQXjj53+qUgW0PpxJB1EwqEkjDjovtwSVDFDK3RH1+dG9zByA9kCPUl/adksqcoTc0bPPg3yNl4p0MhXRFCCpAkVUscjraE3kkP4cWVrCUZ3IzdLfuuq5j34delNSBy60LExbJkEgGpLZQlY8EwcNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058014; c=relaxed/simple;
	bh=6LafgLKl/jr0eBL0blTksKXhLI26P06pH8jkNqckT64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV/w3F9oBndSpCMWzUhDdBQQ6H2Ea2wZD7gF/KqnpIndHdwu8zF5RxkWrl/zkRJTOlpQJeUqN9sjd5JN2MZ8WlHGLDVJla7XXKpRMI7VtHzXc3DpPZMaw/OViQE7Ica2NhVxi/Fv8iI1s4NvASGY2ABcoBq7DsxpUm7NkhZLPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvVDD/E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D937C4CEF7;
	Tue, 21 Oct 2025 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761058014;
	bh=6LafgLKl/jr0eBL0blTksKXhLI26P06pH8jkNqckT64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lvVDD/E9awuwjfEgIYXiDpeMidmlXzdZX68hL/vT63pqXw9Of+yqCHV4N4zaJpp+B
	 KnrZI+LCUJbeJqMyJmUTEb9pvjaZ5DN5Z7tfZuGfiiE0RdbhaFiiCZBl+vEvqJ1f72
	 9OO2CDvSmcw//rutcCH0WHaWTmChVsAmc9ILnPDaQ68ZJUnXv0O4ZfHTzjDENwxnVd
	 4/j9PKcwt/eJlardiZRGzIisCs+dmn8qLQGwgKVkyZ7d/G+s0EiczkSQczs195TY/Z
	 SPPFJCInizx14f2f08zedDwmhSKIZq95qZ9J20oaK4HclWl0khME8Tu1+E65Z7ANPt
	 h+4xa/Rbk39ZQ==
Message-ID: <54328318-c235-413a-a069-5ea93f1dcb2b@kernel.org>
Date: Tue, 21 Oct 2025 16:46:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, aliceryhl@google.com,
 daniel.almeida@collabora.com, a.hindborg@kernel.org, alex.gaynor@gmail.com,
 ojeda@kernel.org, anna-maria@linutronix.de, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-2-fujita.tomonori@gmail.com>
 <DDNZL452A8JR.K1AA7LHZEXW8@kernel.org>
 <CANiq72m+uAWyRf6y6vAKjCQnwsMqVVGQx3VrHW1yAp4a-5eWew@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CANiq72m+uAWyRf6y6vAKjCQnwsMqVVGQx3VrHW1yAp4a-5eWew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 4:39 PM, Miguel Ojeda wrote:
> Now, for runtime values, since random drivers will call this with
> possibly computed values based on who knows what, a warn once may be
> too much. A debug assert instead would be less risky if it makes
> people more comfortable.

Exactly, also consider that MAX_UDELAY_MS depends on the architecture and HZ.

Given that we'd have a WARN() for any value passed that is > MAX_UDELAY_MS, and
given that WARN() is considered a vulnerability if hit (Greg, please correct me
if that's wrong), this would literally become a vulnerability generator. :)

