Return-Path: <linux-kernel+bounces-810063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D2B5155C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DA2562F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C554A27FB27;
	Wed, 10 Sep 2025 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFTvCaOq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7DE27B32D;
	Wed, 10 Sep 2025 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503363; cv=none; b=MUl7lrOImMbMJdKFDuOiNr7tiyvcMmpfFh+JV4UxJfoSC0FP9Cwai3EUdNx1uwzcclJa3ZYKLnydRiS/akiH3isX0Thnvl6WKJU0KRBKBVfdS7Yi40PMXzpTdLXNznnArqimn2nhhfpwGfrHJ3Am0wLnm/oFBhxnltcaS1xidgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503363; c=relaxed/simple;
	bh=qBV3NoC25/tu8WZzqGBG1S0R2mpfNgP/GrrsWYz2kzg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ClrwmHyE6wnntQ2R8gc+iXIVgnTq0fNCB5EGNI1X+cIKAcng13We60f7NXFRmDFaNcyT7inqekYEOuwcLYLJwpQHc8XAiXa4T9fjCEenkMq+FudoqlvdS4r3pW2wAIMKtY6wexniLy6QgwATu7uUxmwqJF2J6JcqPqM6lkmRvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFTvCaOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D765C4CEF0;
	Wed, 10 Sep 2025 11:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757503362;
	bh=qBV3NoC25/tu8WZzqGBG1S0R2mpfNgP/GrrsWYz2kzg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=rFTvCaOqMdx656zhfkMsOPXelz6ftNSU6GXJe0ONd2Jn0DWI2Mg+tqdkG72bd34WL
	 qmN01RiUGYoYYPwYB0cVgylHfo+H5dIJP+ebbVs1XQoAQ/PCoXhEDZPfg3JnX+fLbO
	 /h5DHSQmUA4qYQTTV4lWEl+OrEkzvex3YPYf5BYcp7MDExis/uOeLKTheUpRJVuqEI
	 n9FDPL06VjwQehZst5gcF3+n1sB5kmYym4Hct+LUzuHTRVtcLQYLUIschxHAoEan1E
	 0yvL3RiVyQXYcQQCX4wtjLiVgxipcSbQDAP/Yezox966Zu9PaSbAz4vSdj0zj9XkCI
	 KaX9aWcwmpyMw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 13:22:36 +0200
Message-Id: <DCP2XZWK4X7O.E8CW9LMKRU3I@kernel.org>
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
Subject: Re: [PATCH v3 02/11] gpu: nova-core: move GSP boot code out of
 `Gpu` constructor
References: <20250902-nova_firmware-v3-0-56854d9c5398@nvidia.com>
 <20250902-nova_firmware-v3-2-56854d9c5398@nvidia.com>
 <843554b1-f4c5-43f5-a23b-583339708bea@kernel.org>
 <DCIZ79KKSSF1.25NJT5ZWR3OOS@nvidia.com>
 <DCJ0UA7KM9AP.OGO7EJB4ORQP@kernel.org>
 <DCOBWF0EZLHF.3FFVAB16SJ3FW@nvidia.com>
 <DCOCL398HXDH.3QH9U6UGGIUP1@kernel.org>
 <DCOUK0Z4YV6M.2R0CFE57DY5CR@nvidia.com>
 <DCOYNWXYKBOK.XCRA4Z34RUXP@kernel.org>
 <DCP2UI9NGTQ6.3O0ARTPL4WCA2@nvidia.com>
In-Reply-To: <DCP2UI9NGTQ6.3O0ARTPL4WCA2@nvidia.com>

On Wed Sep 10, 2025 at 1:18 PM CEST, Alexandre Courbot wrote:
> On Wed Sep 10, 2025 at 5:01 PM JST, Danilo Krummrich wrote:
>> On Wed Sep 10, 2025 at 6:48 AM CEST, Alexandre Courbot wrote:
>>> On Tue Sep 9, 2025 at 11:43 PM JST, Danilo Krummrich wrote:
>>>> 	impl Gpu {
>>>> 	    pub(crate) fn new<'a>(
>>>> 	        dev: &'a Device<Bound>,
>>>> 	        bar: &'a Bar0
>>>> 	        devres_bar: Arc<Devres<Bar0>>,
>>>> 	    ) -> impl PinInit<Self, Error> + 'a {
>>>> 	        try_pin_init(Self {
>>>> 	            bar: devres_bar,
>>>> 	            spec: Spec::new(bar)?,
>>>> 	            gsp_falcon: Falcon::<Gsp>::new(dev, spec.chipset)?,
>>>> 	            sec2_falcon: Falcon::<Sec2>::new(dev, spec.chipset)?,
>>>> 	            sysmem_flush: SysmemFlush::register(dev, bar, spec.chipse=
t)?
>>>> 	            gsp <- Gsp::new(gsp_falcon, sec2_falcon, sysmem_flush)?,
>>>> 	        })
>>>> 	    }
>>>> 	}
>>>
>>> It does work. The bizareness of passing the `bar` twice aside,
>>
>> Yeah, but it really seems like a minor inconvinience. (Especially, since=
 this
>> will be the only occurance of this we'll ever have.)
>
> It's definitely not a big deal.
>
>>
>>> here is what it looks like when I got it to compile:
>>
>> This looks great!
>>
>>>     pub(crate) fn new<'a>(
>>>         pdev: &'a pci::Device<device::Bound>,
>>>         devres_bar: Arc<Devres<Bar0>>,
>>>         bar: &'a Bar0,
>>>     ) -> impl PinInit<Self, Error> + 'a {
>>>         try_pin_init!(Self {
>>>             spec: Spec::new(bar).inspect(|spec| {
>>>                 dev_info!(
>>>                     pdev.as_ref(),
>>>                     "NVIDIA (Chipset: {}, Architecture: {:?}, Revision:=
 {})\n",
>>>                     spec.chipset,
>>>                     spec.chipset.arch(),
>>>                     spec.revision
>>>                 );
>>>             })?,
>>
>> +             _: {
>> +                 gfw::wait_gfw_boot_completion(bar)
>> +                     .inspect_err(|_| dev_err!(pdev.as_ref(), "GFW boot=
 did not complete"))?;
>> +             },
>>>
>>>             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spe=
c.chipset)?,
>>>
>>>             gsp_falcon: Falcon::<Gsp>::new(
>>>                 pdev.as_ref(),
>>>                 spec.chipset,
>>>                 bar,
>>>                 spec.chipset > Chipset::GA100,
>>>             )
>>>             .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
>>>
>>>             sec2_falcon: Falcon::<Sec2>::new(pdev.as_ref(), spec.chipse=
t, bar, true)?,
>>>
>> -             gsp: Self::start_gsp(pdev, bar, spec.chipset, gsp_falcon, =
sec2_falcon)?,
>> +             gsp <- Self::start_gsp(pdev, bar, spec.chipset, gsp_falcon=
, sec2_falcon),
>>>
>>>             bar: devres_bar,
>>>         })
>>>     }
>>>
>>> The wait for GFW initialization had to be moved to `probe`, but that's
>>> fine IMO.
>>
>> That's not necessary, you can keep it in Gpu::new() -- I don't see what'=
s
>> preventing us from that. I inserted it in the code above.
>
> This one didn't work for me, but maybe you have a newer version of the
> internal references patch:
>
> error: no rules expected reserved identifier `_`
>     --> drivers/gpu/nova-core/gpu.rs:323:13
>      |
> 323  |             _: {
>      |             ^ no rules expected this token in macro call
>      |
> note: while trying to match `)`

Yeah, you also need this patch [1].

[1] https://lore.kernel.org/all/20250905140534.3328297-1-lossin@kernel.org/

