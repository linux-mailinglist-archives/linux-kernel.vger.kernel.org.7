Return-Path: <linux-kernel+bounces-737759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E342EB0B034
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1D1AA45C1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB17128724D;
	Sat, 19 Jul 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LENUoug5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB72046B3;
	Sat, 19 Jul 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752930945; cv=none; b=dUp5Ly8x8plGiOFiCt7adF60JNp8l75XnuOzQhDqRIEqJJ/in/liNZBPQiOgMMvxa5+oVNyBkykyLP2dccZQF1Iy0aycf65Hb1IZldsJ1PhMv2HKze/STd7xCEzY3/zs/cRGsvkOGoF4BVVO8Z+Neozs4yw/HFtlzwl67q+LqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752930945; c=relaxed/simple;
	bh=Q9CjqBh6qRR1VX7PfQpXfa7t2Y7m39HLcLpR1Xe++J4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=aWoH4g92AovmiGgxeaNwq7T84wCF4BqYQwnjOGVmdfVmTM+y2vX4c9ur9jy8+/FZZYliKTSZirZO3hJd+UViDSDwNbUb+wAfBdxSYRqoZMlm1FL0Tkk3KjXuxkdl7eJUsodGCSev6QATuxZdBtjuSc5kUuHdeZQCBEobet71XSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LENUoug5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E438DC4CEE3;
	Sat, 19 Jul 2025 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752930944;
	bh=Q9CjqBh6qRR1VX7PfQpXfa7t2Y7m39HLcLpR1Xe++J4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=LENUoug5d0i4CU//Hmi6t/5JbY3FehDxlKxvS4BSHAAs2fd4XxTeI7FPsEybJhLCf
	 HvPScU1xEvU09H3l2p6cmzlMqzgbMv31zvZJb/6vFa8d7QUd0Phjs/iZV7XqeAe1s5
	 y2Hs9W58I8aa4HfEsTY7pHK4/Tq4+pkLvBuTT1reYWZRdLmoN44nd8G12O2baFJnxo
	 nrFa8mwceSE8fJHRloAtoABIlRiGbT8oBpxcwcfFBwKzLKzIDCLZQ94qxdcfJmY4Ny
	 /vLnfCEeGFihr1H2iM8VmkhwRPAwG0Tigpd1eue+jLcrlciWJS9Hz2HmPNrFIuuAcM
	 zXLQ/LvxKjFTw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Jul 2025 15:15:40 +0200
Message-Id: <DBG25OQZJ18V.1W13FEOPX8MOH@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v15 3/3] rust: platform: add resource accessors
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com> <20250717-topics-tyr-platform_iomem-v15-3-beca780b77e3@collabora.com>
In-Reply-To: <20250717-topics-tyr-platform_iomem-v15-3-beca780b77e3@collabora.com>

On Thu Jul 17, 2025 at 5:55 PM CEST, Daniel Almeida wrote:
> +impl Device<Bound> {
> +    /// Returns an `IoRequest` for the resource at `index`, if any.
> +    pub fn io_request_by_index(&self, index: u32) -> Option<IoRequest<'_=
>> {
> +        // SAFETY: `resource` is a valid resource for `&self` during the
> +        // lifetime of the `IoRequest`.
> +        self.resource_by_index(index)
> +            .map(|resource| unsafe { IoRequest::new(self.as_ref(), resou=
rce) })

It seems there's a bug in some clippy versions we support. My regular testi=
ng
shows a warning for this with clippy 1.78:

	warning: unsafe block missing a safety comment
	   --> rust/kernel/platform.rs:275:29
	    |
	275 |             .map(|resource| unsafe { IoRequest::new(self.as_ref(), r=
esource) })
	    |                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^
	    |

However, there clearly is a safety comment.

It seems it gets confused by the multiline formatting. If I write this as

	self.resource_by_index(index)
	    // SAFETY: `resource` is a valid resource for `&self` during the
	    // lifetime of the `IoRequest`.
	    .map(|resource| unsafe { IoRequest::new(self.as_ref(), resource) })

the warning goes away.

@Miguel: What's the preferred way dealing with this? I assume we just want =
to
ignore this warning for the affected compiler versions?

> +    }
> +
> +    /// Returns an `IoRequest` for the resource with a given `name`, if =
any.
> +    pub fn io_request_by_name(&self, name: &CStr) -> Option<IoRequest<'_=
>> {
> +        // SAFETY: `resource` is a valid resource for `&self` during the
> +        // lifetime of the `IoRequest`.
> +        self.resource_by_name(name)
> +            .map(|resource| unsafe { IoRequest::new(self.as_ref(), resou=
rce) })
> +    }
>  }

