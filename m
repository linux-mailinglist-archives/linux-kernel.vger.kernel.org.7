Return-Path: <linux-kernel+bounces-808443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C4B4FFC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0781E7AA0B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3135208B;
	Tue,  9 Sep 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd7NI8IC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD7352065;
	Tue,  9 Sep 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429002; cv=none; b=X8wAmk1DomSkwi84PPlAIzP7wyfHqi3Tvu8Ps1ENoa10U6d5ZMw+W/xj33TCciZwVJfonk1F4pd/uxS99iLtJGtiT+YNUMRoyqAg5s1Z0LDJFmICyEPfT0AVoI8tF4g1Qvo2nyihUYBVlNfd10WSAbMDz041vXWG3qoXgpU7n+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429002; c=relaxed/simple;
	bh=kOLSsE1TcnY+gD8/KJbt5EmBVHc4itvLUUpgLRb7r8s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tYP0LFcB1JDuOcURdLI+SisvCwhSx1wD1eS1+rkRVkKQo1IVjqYdQkcHPgK9GcUKhGR6iysM8YzgsUFk1+isQZjMJomY1eNWD/t0Y+XQ05a9AmrvDmqZU6sKaVAHXzloMcs1Hlmw76CGbYO1qEVaTLFk+WzKfGcTb5800gNEhKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd7NI8IC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F36FC4CEF8;
	Tue,  9 Sep 2025 14:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757429002;
	bh=kOLSsE1TcnY+gD8/KJbt5EmBVHc4itvLUUpgLRb7r8s=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Fd7NI8ICq8/Xj73RQML2SSjWlryQTl90qxTRXnDC7G+4Wy51FDUU49MFVJEqqLIn7
	 /3kJOO+dvIqg+HX9M4PKWKScEthYd9widVsKPisKFVlyvJwfKAxgxtIIzNn4YTUkrt
	 6x23XQoqTpgV9DG5rRMKYqthdGuZ3v9IwZ3plFa1qw6jYmsgqp7ivFS61fUR4E0/CD
	 Y5kJp530UYLIMojmOH7fTh12l4fHBt0N77SFx1sLwg2muKNnCUODbpYwPXEwWCjiSU
	 GUnQB1MDqvsNnWfYLUKY/ihYJbnrm+wLTyFXb/IBNx1rN8dxFIbnyt4TUSaUhUKFXz
	 GI0ef9tPtyFaA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 16:43:16 +0200
Message-Id: <DCOCL398HXDH.3QH9U6UGGIUP1@kernel.org>
Subject: Re: [PATCH v3 02/11] gpu: nova-core: move GSP boot code out of
 `Gpu` constructor
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250902-nova_firmware-v3-0-56854d9c5398@nvidia.com>
 <20250902-nova_firmware-v3-2-56854d9c5398@nvidia.com>
 <843554b1-f4c5-43f5-a23b-583339708bea@kernel.org>
 <DCIZ79KKSSF1.25NJT5ZWR3OOS@nvidia.com>
 <DCJ0UA7KM9AP.OGO7EJB4ORQP@kernel.org>
 <DCOBWF0EZLHF.3FFVAB16SJ3FW@nvidia.com>
In-Reply-To: <DCOBWF0EZLHF.3FFVAB16SJ3FW@nvidia.com>

On Tue Sep 9, 2025 at 4:11 PM CEST, Alexandre Courbot wrote:
> On Wed Sep 3, 2025 at 5:27 PM JST, Danilo Krummrich wrote:
>> On Wed Sep 3, 2025 at 9:10 AM CEST, Alexandre Courbot wrote:
>>> On Wed Sep 3, 2025 at 8:12 AM JST, Danilo Krummrich wrote:
>>>> On 9/2/25 4:31 PM, Alexandre Courbot wrote:
>>>>>       pub(crate) fn new(
>>>>>           pdev: &pci::Device<device::Bound>,
>>>>>           devres_bar: Arc<Devres<Bar0>>,
>>>>
>>>> The diff is hiding it, but with this patch we should also make sure th=
at this=20
>>>> returns impl PinInit<Self, Error> rather than Result<impl PinInit<Self=
>.
>>>>
>>>> I think this should be possible now.
>>>
>>> There is still code that can return errors (falcon creation, etc) - do
>>> you mean that we should move it into the pin initializer and turn it
>>> into a `try_pin_init`?
>>
>> Yeah, that would be better practice, if it doesn't work out for a good r=
eason
>> we can also fall back to Result<impl PinInit<Self, Error>, but we should=
 at
>> least try to avoid it.
>
> I tried but could not do it in a way that is satisfying. The problem is
> that `Gpu::new` receives a `Arc<Devres<Bar0>>`, which we need to
> `access` in order to do anything useful with it. If we first store it
> into the `Gpu` structure, then every subsequent member needs to `access`
> it in its own code block in order to perform their own initialization.
> This is quite cumbersome.
>
> If there is a way to obtain the `Bar0` once after the `bar` member of
> `Gpu` is initialized, and then use that instance with each remaining
> member, then that problem would go away but I am not aware of such a
> thing.

What about this?

	impl Gpu {
	    pub(crate) fn new<'a>(
	        dev: &'a Device<Bound>,
	        bar: &'a Bar0
	        devres_bar: Arc<Devres<Bar0>>,
	    ) -> impl PinInit<Self, Error> + 'a {
	        try_pin_init(Self {
	            bar: devres_bar,
	            spec: Spec::new(bar)?,
	            gsp_falcon: Falcon::<Gsp>::new(dev, spec.chipset)?,
	            sec2_falcon: Falcon::<Sec2>::new(dev, spec.chipset)?,
	            sysmem_flush: SysmemFlush::register(dev, bar, spec.chipset)?
	            gsp <- Gsp::new(gsp_falcon, sec2_falcon, sysmem_flush)?,
	        })
	    }
	}

