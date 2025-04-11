Return-Path: <linux-kernel+bounces-599677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7358A856C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0890A1BC0F62
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B88296158;
	Fri, 11 Apr 2025 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Iff5vv69"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAAB29614A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360686; cv=none; b=omk0Bo9+0ZwLl/NK74tvChpaY1wdoNPZii3iajaMAZzR/ZOt/YlmSsJCYuirrIq+oRonmhMbNQjg++35e2Ky/ri3zZI3p8mt/gfGPRYGEYtcxTuYTJBDjf78aa5c5gL7TnZDOLpW+wWe2iI5V6J6cY3t1CvOznrc9FrPCLYrG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360686; c=relaxed/simple;
	bh=zeOdHeb0cEPOLGeV5uDXd9eThquhAqBHHrmbSduW4ZE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQVIyMyR3lU1FIXKIP174Imfg2bZ3isNTyyxvokgIJppIK2zSYjCup4zF8k5sOfuMfg8vMmzdbzH7wO6Y+sh+DnmTcJFhmN9zdXHVE1/0QllDDxvJX1DvUWts0sk+NaAowZU/pp1IUKQvu8nskhpsr7Hde6bIki4C5qzLVUUto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Iff5vv69; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744360677; x=1744619877;
	bh=kWNQ84PWxU3tqA/geC7N9i9pPYvKCqLN+AhB6yEpDAU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Iff5vv69TYmnu/JfH4IWYjE9DPYpO906ksMXhQ9VrmeMlMtJqywsGtLtwtoWMub/i
	 jDT+ExcpmSQgllTyCEFhej/B1bzyn1+UW8qk2ZBVqsQn6w4ZJcL0VdI5xpepu94si6
	 kwWyS1j2T5SzCxNPtRT7NJq579u6y4sXG7HZQldbXMRUrPM/PT9yGIhv1SiQBWOZMu
	 WH1kUSbxi0LCikkJokXzCdidFAHYWcQKIiE7swHiXy2q2PzKJgalcKL7VVHZ7mlSHz
	 dufxSV8TDWeI1eg+vHol6TH3uC7uYGUI1DUbWOsrzaXJbI3aSlIKeYrDQzHeC8ofyP
	 gsfjW2dFIk4bQ==
Date: Fri, 11 Apr 2025 08:37:53 +0000
To: Christian Schrefl <chrisi.schrefl@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
Message-ID: <D93O91QMOY5T.2D9WVF0PF1WRR@proton.me>
In-Reply-To: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c315255c6f7011f1b79d60b9175108d002de031e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 11, 2025 at 9:14 AM CEST, Christian Schrefl wrote:
> When trying to build the rust firmware abstractions on 32 bit arm the
> following build error occures:
>
> ```

[...]

> ```
>
> To fix this error the char pointer type in `FwFunc` is converted to
> `ffi::c_char`.
>
> Fixes: de6582833db0 ("rust: add firmware abstractions")
> Cc: stable@vger.kernel.org # Backport only to 6.15 needed
>
> Signed-off-by: Christian Schrefl <chrisi.schrefl@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/firmware.rs | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)


