Return-Path: <linux-kernel+bounces-805594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A427B48AA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED7A7A8DB3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1A225A29;
	Mon,  8 Sep 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntzkPpcE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1901E7C27;
	Mon,  8 Sep 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757328985; cv=none; b=SMjvQFpx3ks81N9l9yt/5P7ifKIwgczYBGlCcYeNg9YDh0kYiitZvbHV1pqDkPjJ84YZ1jtbBa0qE0R/IH5rJQ3FdK2rKEDuXVw++raKVf3nY1+NMrYWiPB+e9uqUabFJtLhcICQuJ+b6W6L+qUaLqZcW4x2k7uPFVDvu2hBr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757328985; c=relaxed/simple;
	bh=egRqwTIj5juRtCDSGcwyu7lklaGTrbNM5D0WYRarOpc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UB7T+lxlGtxpHrxgVJnub++rpA4wMGrvcpcsdkO8NUFfFYor/DHOm6PHEUYiYn8V6U2da3BqoQUAeE3eRRgVW75YFgkfnj10gEEGiPjtazZg+CDUmN0ibYLI6VClWy6iCTlvszqWwLKbjFCmzHqP3IrB0tVMA7LgxFDhopqyKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntzkPpcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BDFC4CEF1;
	Mon,  8 Sep 2025 10:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757328984;
	bh=egRqwTIj5juRtCDSGcwyu7lklaGTrbNM5D0WYRarOpc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ntzkPpcEm1oXdoJoU/HpAo0RXgAD9pCzuc3p3Up5qK2WFTYV/V/mAU2zkSbSf7xmK
	 A99ze7yy0FuKwF/dN7Sv96oGbzgrNKjfD110ASx7Ye5BWEMmqMlAMH/XoDMM+JnXLN
	 1RUuL3UbUEtqcmW75Yu5snGFjIN1pTXijfozZubJ0OD0Nk4rJfRJmwj/vlPQk6YjSQ
	 8QcBPHKj5bbEDLZqepBuJ+noLDY+hvOwF+Y42h0bKWEpKjMJVFG5AmiccJsSNMm+5b
	 ZJ6Y8jJnzccjpgWOpT3w9BKKLlgj8pnyZ/2/iKogGgUz6+8GJNikk3h7GMeSlJXTD7
	 +a/3MZh6wMR3Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 12:56:19 +0200
Message-Id: <DCND4SAEHX7T.3I2S7MDMUNSNL@kernel.org>
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
Cc: "Matthew Maurer" <mmaurer@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Dirk Beheme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
In-Reply-To: <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>

On Mon Sep 8, 2025 at 12:54 PM CEST, Danilo Krummrich wrote:
> On Mon Sep 8, 2025 at 12:17 PM CEST, Greg Kroah-Hartman wrote:
>> I tried using this in a "tiny" test module I had written, and I get the
>> following build error:
>>
>>    --> samples/rust/rust_debugfs2.rs:64:53
>>     |
>> 64  |         _file =3D root.read_only_file(c_str!("name"), &hw_soc_info=
.name);
>>     |                      --------------                 ^^^^^^^^^^^^^^=
^^^ expected `&u32`, found `&&CStr`
>>     |                      |
>>     |                      arguments to this method are incorrect
>>     |
>>     =3D note: expected reference `&u32`
>>                found reference `&&'static kernel::prelude::CStr`
>>
>> I'm trying to "just" print a CStr, which is defined as:
>>
>> struct HwSocInfo {
>>     id: u32,
>>     ver: u32,
>>     raw_id: u32,
>>     foundry: u32,
>>     name: &'static CStr,
>> }
>>
>> Is this just a "user is holding it wrong" error on my side, or can this =
api not
>> handle CStr values?
>
> What you're doing should fundamentally work.
>
> The above error suggests that your declaration of `_file` is File<&u32> r=
ather
> than File<&'static CStr>.
>
> Also note the double reference you create with `&hw_soc_info.name`, this =
should
> just be `hw_soc_info.name`.
>
> You can also test this case by applying the following diff the the sample=
 in v5:

*sample in patch 5

>
> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
> index b26eea3ee723..475502f30b1a 100644
> --- a/samples/rust/rust_debugfs.rs
> +++ b/samples/rust/rust_debugfs.rs
> @@ -59,6 +59,8 @@ struct RustDebugFs {
>      #[pin]
>      _compatible: File<CString>,
>      #[pin]
> +    _test: File<&'static CStr>,
> +    #[pin]
>      counter: File<AtomicUsize>,
>      #[pin]
>      inner: File<Mutex<Inner>>,
> @@ -140,6 +142,7 @@ fn new(pdev: &platform::Device<Core>) -> impl PinInit=
<Self, Error> + '_ {
>                          .property_read::<CString>(c_str!("compatible"))
>                          .required_by(dev)?,
>                  ),
> +                _test <- debugfs.read_only_file(c_str!("test"), c_str!("=
some_value")),
>                  counter <- Self::build_counter(&debugfs),
>                  inner <- Self::build_inner(&debugfs),
>                  _debugfs: debugfs,


