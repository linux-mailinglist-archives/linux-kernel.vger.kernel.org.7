Return-Path: <linux-kernel+bounces-797451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFDFB410A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0033AC238
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF8327A92A;
	Tue,  2 Sep 2025 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDQTrL7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0D1A288;
	Tue,  2 Sep 2025 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854739; cv=none; b=uG/QLqMJDlA6eW8Y70nzat8dQDuqMo55o6D5zFLqVmEGhagJCHoQ3Rx6WLBldLwjXPdHAfccNVjE46veRpCJDGiQB5CGAIlVIAXpNKogM84zqTYDPS6UhwePbxn/baBkL0q9M5HsBt+g5LOmrJUqOmRTVZsufGInXb4ACmcy2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854739; c=relaxed/simple;
	bh=nGd6ubL9Tf/e1xXoHEq4QdDtCjYAfInQ7R9+GVfgkr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzNKrr3/N2xyKh0SjlPRII6MneFUCS/EtAHTswImAIQ4othbID+vDWfPg0XCeLFuyfh6v/JS5nblgXlOvNFX9zfo3dZIehN80NICnPtnDi0YXhtNo1RLHlgsBGN1CKezUG2V4MrT/ZMIOTvfIJW31SALcTizrV3iem6dvNv25jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDQTrL7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DDEC4CEED;
	Tue,  2 Sep 2025 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854739;
	bh=nGd6ubL9Tf/e1xXoHEq4QdDtCjYAfInQ7R9+GVfgkr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bDQTrL7ukZTL5zgkIX5VBewQ0FdZgocbX6GbSmLy/+MdtvPcsEwaOnZStytUVCrML
	 7Lrw5b1arUATJvNXgcR4Nvmms0kqYMACqF9yNduS4XCV4BcCj/JtJWZncuHwrIciTy
	 oQUtcInfo4Wcf47DtuIMQmm3bDJzkXWhhzXS+vlwJvkhMjuaI3WEdiaF1FD6OByiN+
	 hCHucubAA9r8rUX5zM+wfHcQ21+hmhMmtzwugJn9eyII0EA1k/rsjLAnuHuq5+1IIU
	 7+Bp1ovO33f4F3vcGVs/36vNBtyowvZl/ZbuU/gEeFMqr5+rTBTb/CkdblfFanZHhJ
	 JWofrD5m+pJRg==
Message-ID: <843554b1-f4c5-43f5-a23b-583339708bea@kernel.org>
Date: Wed, 3 Sep 2025 01:12:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] gpu: nova-core: move GSP boot code out of `Gpu`
 constructor
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20250902-nova_firmware-v3-0-56854d9c5398@nvidia.com>
 <20250902-nova_firmware-v3-2-56854d9c5398@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250902-nova_firmware-v3-2-56854d9c5398@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 4:31 PM, Alexandre Courbot wrote:
>       pub(crate) fn new(
>           pdev: &pci::Device<device::Bound>,
>           devres_bar: Arc<Devres<Bar0>>,

The diff is hiding it, but with this patch we should also make sure that this 
returns impl PinInit<Self, Error> rather than Result<impl PinInit<Self>.

I think this should be possible now.

> @@ -293,20 +317,15 @@ pub(crate) fn new(
>           )?;
>           gsp_falcon.clear_swgen0_intr(bar);
>   
> -        let _sec2_falcon = Falcon::<Sec2>::new(pdev.as_ref(), spec.chipset, bar, true)?;
> -
> -        let fb_layout = FbLayout::new(spec.chipset, bar)?;
> -        dev_dbg!(pdev.as_ref(), "{:#x?}\n", fb_layout);
> -
> -        let bios = Vbios::new(pdev.as_ref(), bar)?;
> -
> -        Self::run_fwsec_frts(pdev.as_ref(), &gsp_falcon, bar, &bios, &fb_layout)?;
> +        let sec2_falcon = Falcon::<Sec2>::new(pdev.as_ref(), spec.chipset, bar, true)?;
>   
>           Ok(pin_init!(Self {
>               spec,
>               bar: devres_bar,
>               fw,
>               sysmem_flush,
> +            gsp_falcon,
> +            sec2_falcon,
>           }))
>       }
>   }
> 


