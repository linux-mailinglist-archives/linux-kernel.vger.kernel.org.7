Return-Path: <linux-kernel+bounces-835475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E07BA73EC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A52C18969CA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCCD226CF9;
	Sun, 28 Sep 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0SM9na7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F6A927;
	Sun, 28 Sep 2025 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759072867; cv=none; b=hrPG2Q5Lvpu4eBgrGDL98vvGZ+hCdKGY7XDIBDR77ERE9lsG2d7V2rxjK9crUCKlDbABapZvszOajIjCLt459+l6mUVKfYsPu+dQWNjP+awelw5DYIvDksTLJ+HMD95cRYdB2CEFQpPGbJ9s0lJ/KrhpO2fe+v5OWuj+xJkiSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759072867; c=relaxed/simple;
	bh=Qy13vn/0xGJisCs8MfBrt3Mi0jPcM5ZsRRMAKMd4hds=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=kEtfiLwBOZjgQ/QQfsV1lXjZeCOjVy8NvoKv8Y5/idh51l9G/Letr9SQ3Sszxtgl7AOBixb7OkLtWCWdPmfY5DT7rDTzgg3JZhILwhn8wXYfE+cJP37uwrpI93JahO7ogqnu48y6Zb2xHYpq8a6kMjgdC3nXd7/Ol9qXbHYzOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0SM9na7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D785C4CEF0;
	Sun, 28 Sep 2025 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759072867;
	bh=Qy13vn/0xGJisCs8MfBrt3Mi0jPcM5ZsRRMAKMd4hds=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=e0SM9na7g5z+/YmdwtIrWAvqZlqdauEPixsNjBAEuutoSLqXcYLvyWLQZOAq6GSck
	 2fLuaOmmlsxhdaMkKMWYf4qmEjLed3qy/qbkDnMfHxM4WXdvduT1+s1ZMRqqMmXg0S
	 EgirIm3T1nkz0fW3RLyvEtoD2fs/vZwRtI71Sjp2UsrXsVwk26j8Xyry0Syg3dQiD6
	 t+P5uQ5ITRG5VoxNEqsOj2MbGawm1apTKPRDq0eSPpuOCQJaODbTqjJy26K+AqA8fp
	 4Rb07T4rKlSWoAAHjcHVbiTQHLzi0dOloAmX6EiRFwG2wMrTv9/UdUqccz9FSXwAXX
	 iOV61NQUDgQyQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Sep 2025 17:20:59 +0200
Message-Id: <DD4JABIXIZLT.120ZAR2GODC1O@kernel.org>
Cc: "Philipp Stanner" <phasta@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Waiman Long" <longman@redhat.com>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt"
 <justinstitt@google.com>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Asahi Lina" <lina+kernel@asahilina.net>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@gmail.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Krishna Ketan Rai"
 <prafulrai522@gmail.com>, "Lyude Paul" <lyude@redhat.com>, "Mitchell Levy"
 <levymitchell0@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <llvm@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC PATCH] rust: sync: Add dma_fence abstractions
References: <20250918123100.124738-2-phasta@kernel.org>
 <aNa7BDpKS2KA__4M@tardis.local>
In-Reply-To: <aNa7BDpKS2KA__4M@tardis.local>

On Fri Sep 26, 2025 at 6:10 PM CEST, Boqun Feng wrote:
> I missed this part, and I don't think kernel::sync is where dma_fence
> should be, as kernel::sync is mostly for the basic synchronization
> between threads/irqs. dma_fence is probably better to be grouped with
> dma-buf and other dma related primitives. Maybe in kernel::dma? Like:

I agree, kernel::sync may be a bit misleading.

> rust/kernel/dma.rs
> rust/kernel/dma/dma_buf.rs
> rust/kernel/dma/dma_fence.rs
>
> Thoughts? Miguel, Greg, Danilo and Lyude, any idea or suggestion?

To me it depends on if we want to maintain the code under a global
DMA MAPPING & SCATTERLIST API entry or if it will just be added to the
DMA BUFFER SHARING FRAMEWORK entry.

In case of the latter I'd go for rust/kernel/dma-buf/, analogous to
drivers/dma-buf/. (Though, I'm not sure why this is under drivers/, there's
nothing like dma-buf drivers; I think kernel/dma/ would have been the bette=
r
fit.)

In any case, the target tree would probably be the drm-rust tree.

