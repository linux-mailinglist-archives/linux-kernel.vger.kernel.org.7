Return-Path: <linux-kernel+bounces-869878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 221A5C08EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0B4D34A645
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94A22E974D;
	Sat, 25 Oct 2025 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym4RSbc3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8BD2E8E00;
	Sat, 25 Oct 2025 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761386493; cv=none; b=FFfGJYfPSoKXzbqUuzvayiFbbzE4ApG3aj3OpQLF6qemdhhB1GuRsCXE31f/xiWDkNSYxyAdFjpxsW2tAwWtMfZdG5KhPPzB2N/gW3o37j8LrslWZQ/GPvSBpg8dXfRGo13rQJJnC/8fCpeR/fpAoJ1DUD4kEJ707PupRzhtMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761386493; c=relaxed/simple;
	bh=exaezNJbwCRy7/a3GSg00pdq1sFZuuQu+e000B45S1Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=C8htbdR5DWCjIIPwvpeAXDD3qZkU4pCPj7eqwXfpYO6B6pzceqq0P1c0L5QqByo7Gj2GTbAX7VMZGB7DNe5zh50E8nPvAIqVlOLdvmfLdvx26VaeEHjnvM9gLQwRNEN3V82gw3HaDpxD7ADPhfa7Mq1Q9nxYs9mASzlAq9OqhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym4RSbc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3F5C4CEF5;
	Sat, 25 Oct 2025 10:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761386492;
	bh=exaezNJbwCRy7/a3GSg00pdq1sFZuuQu+e000B45S1Y=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=Ym4RSbc3ADDOpHv1struL2v3muUXzUhNR0dPS+sv4e+YAw2zcNzJxNOUNbIss70PZ
	 YU0A5ufafJ3xGGiuPOp95ObuqXePVAweyHhzUy9J2Dnq9rmsVAaO1EeZ2ysbgWg80h
	 ivPtQZd0B3s6BZ16cKkYdOyiGUPtWCu7nhUL3wEmcZ+FrWZkdYg+F/5WFSS2qaq+LY
	 GCm313JcAtrrcSsOmY4iU+2FHN/Ve4n/+2rGeZNnnUGHBIirwyqi/OB9wdjXhMMN78
	 mPwavLA+vDsOaWUYOxWjXqgdlBvFiVcVmimEufP3PiKvxrhbOv1x/ljz96Gy0baZXD
	 ubcWKrphwDoiw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Oct 2025 12:01:26 +0200
Message-Id: <DDRBED7J0QGR.2LOZZJOYYONIS@kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] gpu: nova: remove Spec and Revision types
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>
References: <20251025001459.491983-1-jhubbard@nvidia.com>
 <20251025001459.491983-2-jhubbard@nvidia.com>
In-Reply-To: <20251025001459.491983-2-jhubbard@nvidia.com>

On Sat Oct 25, 2025 at 2:14 AM CEST, John Hubbard wrote:
> In the fullness of time, it has become clear that these two types are
> not actually needed for anything, after all. Remove them both, and use
> boot0.chipset directly, instead.

What has become clear is that we don't use the spec field in struct Gpu so =
far,
which is not a surprise given that all efforts focus on the initialization =
path.

But even if we forsee that we do not have a reason to store the spec field =
in
struct Gpu, it doesn't mean that the structure itself is useless, see more
below.

>  /// Structure holding the resources required to operate the GPU.
>  #[pin_data]
>  pub(crate) struct Gpu {
> -    spec: Spec,
> +    chipset: Chipset,
>      /// MMIO mapping of PCI BAR 0
>      bar: Arc<Devres<Bar0>>,
>      /// System memory page required for flushing all pending GPU-side me=
mory writes done through
> @@ -191,16 +153,21 @@ pub(crate) fn new<'a>(
>          devres_bar: Arc<Devres<Bar0>>,
>          bar: &'a Bar0,
>      ) -> impl PinInit<Self, Error> + 'a {
> +        let boot0 =3D regs::NV_PMC_BOOT_0::read(bar);
> +
>          try_pin_init!(Self {
> -            spec: Spec::new(bar).inspect(|spec| {
> +            chipset: {
> +                let chipset =3D boot0.chipset()?;
>                  dev_info!(
>                      pdev.as_ref(),
> -                    "NVIDIA (Chipset: {}, Architecture: {:?}, Revision: =
{})\n",
> -                    spec.chipset,
> -                    spec.chipset.arch(),
> -                    spec.revision
> +                    "NVIDIA (Chipset: {}, Architecture: {:?}, Revision: =
{:x}.{:x})\n",
> +                    chipset,
> +                    chipset.arch(),
> +                    boot0.major_revision(),
> +                    boot0.minor_revision()

Now you have to open code reading the register, get the Chipset instance an=
d
manually format the revision, which was previously done through a Display i=
mpl
of Revision. And the subsequent patch introduces even more open coded logic=
 in
the constructor of struct Gpu.

Instead of removing Spec, we should improve it by giving it its own Display
impl, such that this code can become:

	dev_info!(pdev.as_ref(), "{}\n", spec);

