Return-Path: <linux-kernel+bounces-724550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FECAFF42B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFC3B5A51
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC1F241CB2;
	Wed,  9 Jul 2025 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYTg17Nw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6C221DB4;
	Wed,  9 Jul 2025 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098220; cv=none; b=arkUMav1BGIswXf+jXZXN9jMQbgkRBMiOfoMJ5IWrREZlQRwvSLm1OQcYPAjCOp39VC4QPnD6XjJIgCykm7YFD8DFcB19jTkrLY0Mu3FqWACkjaGgdg81RKeGoO6ASlynt6AQcLCpr07QictYmNrCNbagH+JM6sagwXah1rSlN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098220; c=relaxed/simple;
	bh=x/oR2L6ZzEbzrswP/5d6Ev5HJ7o6BugogSH7USoFYlg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=maGV7GfCSiGnYkOMmtjt08AwW5w+0b8ZEl32a3oxi1hZHq+vKU6F+1F7xqwfkgme7GLZhbBYqGSt4g87RvS9IaZpCJtvE56vYwN1GLyrj7JG6roOmrs0MQ9oz94ur2UE467DlHkBXp4gNApD3sga+pSR4bzPOq3q79NJsx86v/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYTg17Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594C1C4CEEF;
	Wed,  9 Jul 2025 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752098220;
	bh=x/oR2L6ZzEbzrswP/5d6Ev5HJ7o6BugogSH7USoFYlg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uYTg17NwYSKT1f+gpwsEtqcpwauG1lRnWWGPnTJYQy6PSU72DF7c0DOqCm1Lsf8RD
	 4XMEe9tgQHw/mW6ZhwyensUh9Bv03jB2nc8DQepnUG55tHLiq67a7VvjvUn2V//AS8
	 ++yz1nawCXq12LHzch5pqgYHbyv4PUp3G83dvCZxT9rrYEOySM52HtRJa4fz15/QTd
	 vw66pWK/FlJ5qXUhRkWeqdz29jWKoseXhSvYcSAMPEbaZ7q2bDwBCZz/K2/995buIE
	 VJq2pUPmSfxzaulnApXIKTFGCR+fX8nVurvpqo8l0oxxg6YyImzcrQMNOm157L612A
	 2voCmk0wz5nMQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 23:56:55 +0200
Message-Id: <DB7UZCKSQ4G2.ZZBIWS6YJAOF@kernel.org>
Subject: Re: [PATCH v9 5/5] rust: samples: Add debugfs sample
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <20250709-debugfs-rust-v9-5-92b9eab5a951@google.com>
In-Reply-To: <20250709-debugfs-rust-v9-5-92b9eab5a951@google.com>

On Wed Jul 9, 2025 at 9:09 PM CEST, Matthew Maurer wrote:
> +// This data structure would be unlikely to be there in a real driver - =
it's to hook up mutation
> +// that would normally be driven by whatever the driver was actually ser=
vicing and show how that
> +// would work. We're assuming here that those methods would have access =
to a `&RustDebugFs`.

Please see also [1]. I think you're making this too complicated, and due to=
 the
missing write() support you have to create workarounds because of that, whi=
ch
serve as a bad reference.

Keep it simple, Create some driver private data in probe() and export a cou=
ple
of fields of this driver private data through debugfs.

If you really want to showcase that those values can change, queue some wor=
k and
modify the counter and / or the Inner type that is protected by a mutex.

[1] https://lore.kernel.org/lkml/DB7US8G7ISG0.20430M3P7I0K0@kernel.org/

> +#[pin_data]
> +struct Wrapper {
> +    _dir: Dir,
> +    #[pin]
> +    _wrapped: File<File<RustDebugFs>>,
> +}
> +
> +#[pin_data]
> +struct RustDebugFs {
> +    pdev: ARef<platform::Device>,
> +    // As we only hold these for drop effect (to remove the directory/fi=
les) we have a leading
> +    // underscore to indicate to the compiler that we don't expect to us=
e this field directly.
> +    _debugfs: Dir,
> +    #[pin]
> +    _compatible: File<CString>,
> +    #[pin]
> +    counter: File<File<AtomicUsize>>,
> +    #[pin]
> +    inner: File<Mutex<Inner>>,
> +}
> +
> +#[derive(Debug)]
> +struct Inner {
> +    x: u32,
> +    y: u32,
> +}
> +
> +kernel::of_device_table!(
> +    OF_TABLE,
> +    MODULE_OF_TABLE,
> +    <Wrapper as platform::Driver>::IdInfo,
> +    [(of::DeviceId::new(c_str!("test,rust-debugfs-device")), ())]
> +);

I don't think we need both, ACPI should be much simpler with QEMU.

> +kernel::acpi_device_table!(
> +    ACPI_TABLE,
> +    MODULE_ACPI_TABLE,
> +    <Wrapper as platform::Driver>::IdInfo,
> +    [(acpi::DeviceId::new(c_str!("LNUXDEBF")), ())]
> +);
> +
> +impl platform::Driver for Wrapper {
> +    type IdInfo =3D ();
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&OF_TA=
BLE);
> +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D Some(&A=
CPI_TABLE);
> +
> +    fn probe(
> +        pdev: &platform::Device<Core>,
> +        _info: Option<&Self::IdInfo>,
> +    ) -> Result<Pin<KBox<Self>>> {
> +        KBox::try_pin_init(Wrapper::new(RustDebugFs::new(pdev)), GFP_KER=
NEL)
> +    }
> +}

