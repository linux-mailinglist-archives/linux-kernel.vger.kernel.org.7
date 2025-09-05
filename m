Return-Path: <linux-kernel+bounces-802428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7125B4524E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44D73A9CFB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782571805A;
	Fri,  5 Sep 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj+yg1DG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F32D1F64;
	Fri,  5 Sep 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062808; cv=none; b=GOJ7ItXE88fkaEAZ7H390OiuTJeLfzt9D3nVDIuMW8JLYUBjpj6oxnuxlzBIzkJGvANeimiOAvQUy9X9q1lV0sGuxhaDgDWsQvyJHXNuh1oAeyBEM1FPzh3FHgOqudFJZQAheI3fKJ2B3OAxM0thLfuhTMM9yA/AN1df4ZPDXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062808; c=relaxed/simple;
	bh=8ijI8iLawoBKYo/neDNtLZHH221638zcRNFfo6wvkZ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fvxfps4nD4OzutO+XvWfhORIcBx9lZ6+RfCD7N0npu1O7Glbd/OxUIHYgXMCR8cXetCRatF9n/9uaOes4rgCYgDHgmUS5oNe4cdG8eWEHSEICmb2G22Cdsnh7oVIJ3VS8SaIQaNnwScEhlYI3XdrAh5NS4aYbxuQsG5pV6simII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj+yg1DG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDC8C4CEF1;
	Fri,  5 Sep 2025 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757062808;
	bh=8ijI8iLawoBKYo/neDNtLZHH221638zcRNFfo6wvkZ8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Lj+yg1DGRv3d0iVz93BJ/kHZUHXD+WVqecd8OaNPgzt3TF9NlX8rJf+HWwCFletLj
	 6/jQyYAHMb4+GxSZ5Wr3gG3qczOH/dVXn+jSjiKq9jTrGgdhuMyAQxt57XgiJ85llO
	 Yh9AHmCcNQAc/EMeGqjHIjRaxvkm2kjr3Y5W/04HLGO7/p60H7HEBTQ6oN2Gvkfl3D
	 K0hS0UUr/sklfVja7a4Aht0iXgFtSSYHjXvJKph4Z6PFeiQhV7wYNfv76Myg45U7RB
	 IHpFm54AegdzC5ZPYhIm3qjt38b11XhQ24FhxazJM/ePyIfjI7GizFehIwZXbt9hoR
	 151din7s58ahw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 11:00:02 +0200
Message-Id: <DCKQS4126EVC.38ZJ0GOFDYCP7@kernel.org>
Subject: Re: [PATCH v11 5/7] samples: rust: Add debugfs sample driver
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Dirk Beheme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-5-7d12a165685a@google.com>
In-Reply-To: <20250904-debugfs-rust-v11-5-7d12a165685a@google.com>

On Thu Sep 4, 2025 at 11:13 PM CEST, Matthew Maurer wrote:
> +kernel::acpi_device_table!(
> +    ACPI_TABLE,
> +    MODULE_ACPI_TABLE,
> +    <RustDebugFs as platform::Driver>::IdInfo,
> +    [(acpi::DeviceId::new(c_str!("LNUXDEBF")), ())]

This should use "LNUXBEEF", as we explicitly reserved it for sample and tes=
t
code.

I think we could reserve more if we see a benefit, but so far it's only use=
d by
the platform driver sample, so we should be good.

Either way, no need to resend for this only, it can be fixed up on apply. :=
)

> +);
> +
> +impl platform::Driver for RustDebugFs {
> +    type IdInfo =3D ();
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D None;

NIT: This defaults to None, so it can be omitted.

> +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D Some(&A=
CPI_TABLE);

