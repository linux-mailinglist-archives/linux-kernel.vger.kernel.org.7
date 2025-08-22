Return-Path: <linux-kernel+bounces-781927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F685B318A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D32BB61C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664722FF14D;
	Fri, 22 Aug 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld4V7Snz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375D2FC034;
	Fri, 22 Aug 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867482; cv=none; b=fvPHObBh+OToMQZc3REZxW8Y0e3ngKwBV4CIaMdarcVPjMs84UYwiNiTQpDK0nfYSUij9Vq6jA7dbdNqj1ARJERZZ+Y6iJZuB4Jqg3SPDectarfajwbEYzTb9fJRwaZt3GxTSMqgL7gvrg9X/A0IwUlNtZ2ep8QTcziey5enBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867482; c=relaxed/simple;
	bh=NthJul2t/ihkNQEDNJDxStrByPgsFY1WvD6qbeKO9zc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=J0MJn8iD9JDtpqieOMC2Q+yDtGFjc1sOi2pRbb85rE0DwdEHh1rs5IZIBe7UKo+HWry/jAFvEmVCmGNJTF832SwSNfd9rtjUKQkySIAXuXkYasSfZfa6TwgeY1Jl+85GOD9hPfiIvPISpNYttl1dnQhU+pwW+6KD2XGbXFXvoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld4V7Snz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B36C4CEED;
	Fri, 22 Aug 2025 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755867482;
	bh=NthJul2t/ihkNQEDNJDxStrByPgsFY1WvD6qbeKO9zc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Ld4V7SnzrCinLkVqtfXR19IT/hb1L9Tyb7FRqml4IsQfef9ypJcEfou5A31TbgctY
	 Dcqn+lvrg+NzS/GnUjmVgAH19bZvj4EIaMuzQjl6RKT5xx194NJQ0IzYL5+hg1WcaR
	 9fAHCcQz3P1o4/Wrb7XKZiOeeWKqiJmdEGiDJAPbkIqwH//4fWylhFJ69/5CBrUOVT
	 wb0az991RPI2g4veMLJceH7H92NkEmTLkt3VXz1Ng1u9iQXpyJWfxTyyUs2wa2Oeq9
	 jsM+BypbyKe0rJEdESPC8EIz1V78M9PEIZtRyaUOub1E898ol9BSUazGmXujY2eZdC
	 SDH2cEZipJjpA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 14:57:55 +0200
Message-Id: <DC8Z2MLOJN7D.3IOSY6SJ7DPVD@kernel.org>
Subject: Re: [PATCH 5/5] gpu: nova-core: firmware: process and prepare the
 GSP firmware
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250822-nova_firmware-v1-0-ff5633679460@nvidia.com>
 <20250822-nova_firmware-v1-5-ff5633679460@nvidia.com>
In-Reply-To: <20250822-nova_firmware-v1-5-ff5633679460@nvidia.com>

Hi Alex,

not a full review yet, but a few ad-hoc comments from skimming over it.

On Fri Aug 22, 2025 at 2:47 PM CEST, Alexandre Courbot wrote:
> +/// A device-mapped firmware with a set of (also device-mapped) pages ta=
bles mapping the firmware
> +/// to the start of their own address space.
> +pub(crate) struct GspFirmware {
> +    /// The GSP firmware inside a [`VVec`], device-mapped via a SG table=
.
> +    #[expect(unused)]

Do we expect this to change? Otherwise, just prefix the field name with an
underscore.

> +    fw: Pin<KBox<SGTable<Owned<VVec<u8>>>>>,
> +    /// The level 2 page table, mapping [`Self::fw`] at its beginning.
> +    #[expect(unused)]
> +    lvl2: Pin<KBox<SGTable<Owned<VVec<u8>>>>>,
> +    /// The level 1 page table, mapping [`Self::lvl2`] at its beginning.
> +    #[expect(unused)]
> +    lvl1: Pin<KBox<SGTable<Owned<VVec<u8>>>>>,

Instead of creating three allocations, just make struct GspFirmware pin_dat=
a by
itself. This should even propagate down to struct Gpu, which is pin_data.

So everything can be in one single allocation.

> +    /// The level 0 page table, mapping [`Self::lvl1`] at its beginning.
> +    lvl0: DmaObject,
> +    /// Size in bytes of the firmware contained in [`Self::fw`].
> +    #[expect(unused)]
> +    pub size: usize,
> +}

