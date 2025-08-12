Return-Path: <linux-kernel+bounces-764247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC94B22068
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268191890424
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA52E0915;
	Tue, 12 Aug 2025 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8SlcYjY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF302DE6EA;
	Tue, 12 Aug 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986310; cv=none; b=FSOyonQIcGDIJkxTJOGWVeq+Z6O+KKgEpnrgNNG5eB8k6diVCBcCyuQlns7BLjVgHwiKbD1Hjb08lPsd5yc2Hh1IHj9Lh2ApeDn9ds9NK3EAALUWllAEpRmmajnsse1yek0ZbpcTCITAL3dGtF0Kwq4AGlDa33eF4TZuqUu+/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986310; c=relaxed/simple;
	bh=0V7U3rTiwFSJd5eMfwC739jhVOM/UljdnAB801+DTgQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SpDD4oJGk9jj9v6Xe1gzqsMjNp6yxIHOv3feD17T1YVqt80T7K3AhjgrnU9PGhkpCzMBMraUdUaBxCAlSkeWcJOjUwTHsDj4XGwUvQ9zz6NzrPx6Dom7LUa279NFjPtsgc5TxVLtp6aBskEkW//l7ie4oXwRKfbyNglqeDb9/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8SlcYjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A53C4CEF0;
	Tue, 12 Aug 2025 08:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986309;
	bh=0V7U3rTiwFSJd5eMfwC739jhVOM/UljdnAB801+DTgQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=r8SlcYjYjFOwegtCIGl/2aOv55Xef/MYMPC6+HwMc/JRWuIhpD92NEAVF4UFHBKOY
	 N1zv+UzRNlxYP4AP3uYBy1ZqptGaOEI4YgLZli7ZMgpoMzj6bTcXNPRnzDLZV6bqwW
	 GisPbyzel86QToq2OosB9iKNX9MfSNVUnPs8+0wpFxjLDitnfDSU94Hculkx/EurkG
	 +I9f8b8o6LOVQ8Sve/Evi+gxRGEac11sDEZ/PZsMopFfuW2U0fHO69xT3Uuk9I05eI
	 t0dHYEIDr0rYVFXphYyk2RxlQPVPYh4bj0iwaW96K/peWjDuPnWQoJEYDEVRgXlIad
	 CA5bG3dzQkOZw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 10:11:43 +0200
Message-Id: <DC0AQ1UOF0TG.134431D3TCJ9W@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, "Fiona Behrens" <me@kloenk.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] rust: implement `kernel::sync::Refcount`
From: "Benno Lossin" <lossin@kernel.org>
To: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Tamir Duberstein" <tamird@gmail.com>, "Ingo
 Molnar" <mingo@kernel.org>, "Mitchell Levy" <levymitchell0@gmail.com>,
 "Lyude Paul" <lyude@redhat.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>
X-Mailer: aerc 0.20.1
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-2-gary@kernel.org>
In-Reply-To: <20250723233312.3304339-2-gary@kernel.org>

On Thu Jul 24, 2025 at 1:32 AM CEST, Gary Guo wrote:
> +    /// Set a refcount's value.
> +    #[inline]
> +    pub fn set(&self, value: i32) {
> +        // SAFETY: `self.as_ptr()` is valid.
> +        unsafe { bindings::refcount_set(self.as_ptr(), value) }
> +    }

One more thing, I think this function could use some better docs. When
do you want to use it? (How) does it synchronize with other reads/writes?

---
Cheers,
Benno

