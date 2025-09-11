Return-Path: <linux-kernel+bounces-812053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EEBB53250
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F77DA84AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B561322A0E;
	Thu, 11 Sep 2025 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c06Sp8Q/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2491312802;
	Thu, 11 Sep 2025 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593881; cv=none; b=D00SIzP7npoAEuUMrHPb79tK+0yU7XZAmOUtPEsuTiCMjw9sqFKqi1hlPI5z0DL0OoWrOIcaLreNCHGNi9YXWTsEzsxUVvu729uznUaviPiJ2g7/wRP+3ZjtR4ghMcYGfJtgsYjl0rgmjkXpgUAswhxile78htSDx1/+f813SBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593881; c=relaxed/simple;
	bh=K6b51fWzAg1h8jw+QOy5A/3DHSmlmOFYyUDsQ8bcEy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8xoiOcLxYsTl3lTwzEnc8zrHYqaopFCbZb7C+kZWUxWnB8r67MzOwMBWQaJwzTugufzrztWEbL49JWorbT48ydCbz6Fd2fZoVwMlf0uVBchlAfWisegS3KGlUMeZCo3jtbcFNoFxyy9vC/0sogHNDz5IRUaYhLRqJrur48tMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c06Sp8Q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB09DC4CEF0;
	Thu, 11 Sep 2025 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757593881;
	bh=K6b51fWzAg1h8jw+QOy5A/3DHSmlmOFYyUDsQ8bcEy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c06Sp8Q/kv38/w351LhzH0bADeXIM27LzqOFWz+Nh46SiZueL60fgJC4Rsgoz1KYU
	 lRoLc+FftCVZ+0Pz3zvuX7rtHL2L7LB2aWIBKuRpEQew3EqwhUasBxx20uyhfLyvif
	 RmYeAS76hFZCosqOuSdEAwzU85otiOLypPQaEbSO+liL8POvXQRC+b4I0QvPVVvwHX
	 qxdnjMyvYqOZCq6uCLI9TGGYS4rg0qIVoGYx69kCIgV8JEqQf1AlGPS3C6j6CwnDvB
	 XQf5DeXP5Ykz3KAfTGuZ88nC2rjugKax/rip1CWx/eJ9ju7qdnNhsEcexIACZjx/6s
	 uu7QwZIZ7oTWg==
Message-ID: <ef1023cc-0dea-49d2-8d04-6666510b53e6@kernel.org>
Date: Thu, 11 Sep 2025 14:31:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] gpu: nova-core: firmware: process and prepare
 the GSP firmware
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
References: <20250911-nova_firmware-v5-0-5a8a33bddca1@nvidia.com>
 <20250911-nova_firmware-v5-8-5a8a33bddca1@nvidia.com>
 <9c1a7902-4e14-4b25-ba32-57a475a0bccc@kernel.org>
 <DCPYZSLUJGZ1.2D835NAHYEM5U@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DCPYZSLUJGZ1.2D835NAHYEM5U@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 2:29 PM, Alexandre Courbot wrote:
> On Thu Sep 11, 2025 at 8:27 PM JST, Danilo Krummrich wrote:
>> On 9/11/25 1:04 PM, Alexandre Courbot wrote:
>>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>>> index 06a7ee8f4195759fb55ad483852724bb1ab46793..8505ee81c43e7628d1f099aff285244f8908c633 100644
>>> --- a/drivers/gpu/nova-core/gpu.rs
>>> +++ b/drivers/gpu/nova-core/gpu.rs
>>> @@ -8,6 +8,7 @@
>>>  use crate::fb::SysmemFlush;
>>>  use crate::firmware::booter::{BooterFirmware, BooterKind};
>>>  use crate::firmware::fwsec::{FwsecCommand, FwsecFirmware};
>>> +use crate::firmware::gsp::GspFirmware;
>>>  use crate::firmware::{Firmware, FIRMWARE_VERSION};
>>>  use crate::gfw;
>>>  use crate::regs;
>>> @@ -285,6 +286,11 @@ pub(crate) fn start_gsp(
>>>  
>>>          let bios = Vbios::new(dev, bar)?;
>>>  
>>> +        let _gsp_fw = KBox::pin_init(
>>> +            GspFirmware::new(dev, chipset, FIRMWARE_VERSION)?,
>>> +            GFP_KERNEL,
>>> +        )?;
>>
>> Since we now have the infrastructure in place and the change is trival, I'd
>> prefer to make this a member of struct Gsp and make it part of the Gpu structure
>> directly (without separate allocation).
>>
>> Should we need dynamic dispatch in the future, it's also trivial to make it its
>> own allocation again, but maybe we also get around the dyn dispatch. :)
> 
> Ah, my previous talk about dynamic dispatch is a bit obsolete now that
> the `Firmware` struct is gone. :) Sorry if that created confusion.
> 
> Truth is, this object is not supposed to survive `start_gsp`, and we can
> dispose of it after the GSP is started as the bootloader will have
> validated and copied it into the WPR region. So we don't want to store
> it into `Gpu`, now or ever.

Ah, makes sense, so that's fine then.

