Return-Path: <linux-kernel+bounces-787269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160B6B373CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C81B2749E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F82E62D8;
	Tue, 26 Aug 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5hUEyfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA022083;
	Tue, 26 Aug 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240026; cv=none; b=a9yjnRUWLtqgWifOUps2h7UVYQKlnBhLGHl+yGWxNlla7ZEr9yxw/pN6SLIIkm7GUMrEqgTC+DNz02TPikGBd5NTl8qzuwKk0H2sqCzAva1CBTdWmNFlZ4jsUniC7COwCPFM0IY6C9XIUJ8xLcx/+uX6wOtIilDgbiwpgmdGApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240026; c=relaxed/simple;
	bh=01/duG/wFn29EcghcT4EgAwqtdDZ9W/d09lk8kLQvRY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YbtlDRlbkKeq4zPRzdP0kDk8Gq9sevPdf5+exICahiaiC1RJrD7JLeHk4hFi2BTvNHWYnf+/c8ZwPg+OBjDiV7EXOAlTP3/J/aFTiCyRIhM3Gt6oNGAMGyPHOgkss44bn4vWjyT6EX/0v9tyE0NwRT9Zu+15LTiIOVaQH9t17nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5hUEyfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A24C4CEF1;
	Tue, 26 Aug 2025 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756240025;
	bh=01/duG/wFn29EcghcT4EgAwqtdDZ9W/d09lk8kLQvRY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=U5hUEyfeB59jQ5IZvjpspUVdadmFqYD8FOiXepZuMvOxqCBKI7Ose2zNlhilzPqVH
	 LhBQJO3VXMq6H/+lRA6LDXfXD1eiGkXWwc6kDTs5hwtDZlxMgR8cZ0kRtLk0FsBVdp
	 JBtsRMRODu/FkuNqaqyBASU5FtbCtlz8YW+Dnauq7NDl4JmhFmxlBiKz2GDxVMgJmD
	 3/SEGr2kCChGalUi/gccAgW21I1ERAPLFzq0Rw67aMirQVjtUNjYl+xc8xyCT4p8Bo
	 eTsgTKidg5uwUgmHJrYkp1FjLCkMPBsu3suqyFfGI9ShCcOuS6ecpRWEtYvMbVc9z1
	 3nAyyNj2M45JQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 22:27:00 +0200
Message-Id: <DCCN4NA8LSGD.10TKRH3LRGAEN@kernel.org>
Subject: Re: [PATCH v3 3/5] rust: scatterlist: Add abstraction for sg_table
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <acourbot@nvidia.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-4-dakr@kernel.org>
 <6625A8C0-33B2-4AFC-984B-130F8E06113D@collabora.com>
 <DCCLKO6HTCM8.YR8VE8PAXQTM@kernel.org>
 <3BD5A415-CD19-4B8E-A2A3-78F60FCC863A@collabora.com>
In-Reply-To: <3BD5A415-CD19-4B8E-A2A3-78F60FCC863A@collabora.com>

On Tue Aug 26, 2025 at 10:16 PM CEST, Daniel Almeida wrote:
> // SAFETY: It is not possible to mutate a `SGEntry` through a shared refe=
rence,
> // so it is safe to send a &SGEntry to another task.
>
> Or any variation of the wording above.
>
> In any case, I agree that this is splitting hairs a bit and I have nothin=
g
> against keeping it as-is, I just thought it be a tad clearer :)

Yeah, that's what I meant. The definition of Sync even says "Types that are=
 not
Sync are those that have interior mutability in a non-thread-safe form [...=
]".
[1].

So, both our wordings basically come down to "It's Sync because it's Sync."=
 :)

But don't get me wrong, I'm fine being a bit more verbose about this.

[1] https://doc.rust-lang.org/std/marker/trait.Sync.html

