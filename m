Return-Path: <linux-kernel+bounces-875876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C395C1A02C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4D284FFD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C433031D;
	Wed, 29 Oct 2025 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjjuyGwS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED9032ED3D;
	Wed, 29 Oct 2025 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737199; cv=none; b=RqGHRvVmox11lZmUVd/oFF6JdU7at4u1105fP0R7d256f31P5v7fKb65XwaLTdcGWh+4Nd+IbjHfgKmmRq5S19WWzGv9IX9dtcapb8I1pRUx8+ikukQe7OCRUMCv4k7sHjCTL5Yf1lzhw+m8z4/YBQCwPQP8Cri20x/MPOwAKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737199; c=relaxed/simple;
	bh=Jy2Nmn1rHJmpbulUrLW0Fx610dEyh5d9CQubhs7LzL4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=HUOO56UhxF08r9N20HkSez0eX7zXUXqi5dMnlKVhvvXN0wv364ZzTFff37nnrWPKpRQiou63nT4GUbdpsW0wF1tj4LzoJ0eZdgSVvPbsXvWc/Mqty3qQd2QZlrsTwZEDbMUSTnBfbbBnhnrzyGdO8roa3aTi46eVsTF9VGZLOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjjuyGwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCB5C4CEFD;
	Wed, 29 Oct 2025 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761737198;
	bh=Jy2Nmn1rHJmpbulUrLW0Fx610dEyh5d9CQubhs7LzL4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=SjjuyGwS/uydZTXSG9ee2QjevRPbg7DIrLDq7pDEvzhL86InZ0z0l686C+RZG6bus
	 p6ZQEvM9zLTYaW0OYmzjnXg4r12YaBvAiD2gsnO5E7ny1X939hvuVA/3k3p8D44GOo
	 H45Em2qVNSRdk1GY5pHr0cUeJNxuQfp8dXYGeUIhkP48LUNYR2TICd3+bqvy2N4rlq
	 JGwd3oMkA/RU/mfvXiIbQPL0l5s5H2TY4qRrKaqdXAAvKh4/tvqrcNIDtciPg9juy/
	 XnkmY9bDC4ZU+s0HjqSDmZ/YdrT8euuAwrzEWEa29mo+XInQDbIEbPpSdKiJfktNKu
	 l2YbkOUFgB5bQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 12:26:33 +0100
Message-Id: <DDURPPIWWIA7.27RFSM7KRLN7I@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 2/2] gpu: nova-core: add boot42 support for next-gen
 GPUs
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
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20251029030332.514358-1-jhubbard@nvidia.com>
 <20251029030332.514358-3-jhubbard@nvidia.com>
In-Reply-To: <20251029030332.514358-3-jhubbard@nvidia.com>

On Wed Oct 29, 2025 at 4:03 AM CET, John Hubbard wrote:
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 6f1486d4e9c6..6762493206ec 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -134,6 +134,34 @@ pub(crate) struct Revision {
>      minor: u8,
>  }
> =20
> +impl TryFrom<regs::NV_PMC_BOOT_0> for Spec {
> +    type Error =3D Error;
> +
> +    fn try_from(boot0: regs::NV_PMC_BOOT_0) -> Result<Self> {
> +        Ok(Self {
> +            chipset: boot0.chipset()?,
> +            revision: Revision {
> +                major: boot0.major_revision(),
> +                minor: boot0.minor_revision(),
> +            },

Actually, would be nice to handle this just like chipset for consistency, i=
.e.

	revision: boot0.revision()

> +        })
> +    }
> +}
> +
> +impl TryFrom<regs::NV_PMC_BOOT_42> for Spec {
> +    type Error =3D Error;
> +
> +    fn try_from(boot42: regs::NV_PMC_BOOT_42) -> Result<Self> {
> +        Ok(Self {
> +            chipset: boot42.chipset()?,
> +            revision: Revision {
> +                major: boot42.major_revision(),
> +                minor: boot42.minor_revision(),
> +            },

Same here, could be

	revision: boot42.revision()

> +        })
> +    }
> +}
> +
>  impl fmt::Display for Revision {
>      fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>          write!(f, "{:x}.{:x}", self.major, self.minor)
> @@ -151,13 +179,43 @@ impl Spec {
>      fn new(bar: &Bar0) -> Result<Spec> {
>          let boot0 =3D regs::NV_PMC_BOOT_0::read(bar);
> =20
> -        Ok(Self {
> -            chipset: boot0.chipset()?,
> -            revision: Revision {
> -                major: boot0.major_revision(),
> -                minor: boot0.minor_revision(),
> -            },
> -        })
> +        // "next-gen" GPUs (some time after Blackwell) will zero out boo=
t0, and put the architecture
> +        // details in boot42 instead. Avoid reading boot42 unless we are=
 in that case.
> +        let boot42 =3D if boot0.is_next_gen() {
> +            Some(regs::NV_PMC_BOOT_42::read(bar))
> +        } else {
> +            None
> +        };
> +
> +        // Some brief notes about boot0 and boot42, in chronological ord=
er:
> +        //
> +        // NV04 through Volta:
> +        //
> +        //    Not supported by Nova. boot0 is necessary and sufficient t=
o identify these GPUs.
> +        //    boot42 may not even exist on some of these GPUs.boot42
> +        //
> +        // Turing through Blackwell:
> +        //
> +        //     Supported by both Nouveau and Nova. boot0 is still necess=
ary and sufficient to
> +        //     identify these GPUs. boot42 exists on these GPUs but we d=
on't need to use it.
> +        //
> +        // Future "next-gen" GPUs:
> +        //
> +        //    Only supported by Nova. boot42 has the architecture detail=
s, boot0 is zeroed out.
> +
> +        // NV04, the very first NVIDIA GPU to be supported on Linux, is =
identified by a specific bit
> +        // pattern in boot0. Although Nova does not support NV04 (see ab=
ove), it is possible to
> +        // confuse NV04 with a "next-gen" GPU. Therefore, return early i=
f we specifically detect
> +        // NV04, thus simplifying the remaining selection logic.
> +        if boot0.is_nv04() {
> +            Err(ENODEV)?
> +        }
> +
> +        // Now that we know it is something more recent than NV04, use b=
oot42 if we previously
> +        // determined that boot42 was both valid and relevant, and boot0=
 otherwise.
> +        boot42
> +            .map(Spec::try_from)
> +            .unwrap_or_else(|| Spec::try_from(boot0))
>      }
>  }

Without the comments this currently is:

	let boot42 =3D if boot0.is_next_gen() {
	    Some(regs::NV_PMC_BOOT_42::read(bar))
	} else {
	    None
	};
=09
	if boot0.is_nv04() {
	    Err(ENODEV)?
	}
=09
	boot42
	    .map(Spec::try_from)
	    .unwrap_or_else(|| Spec::try_from(boot0))

Which I think is a bit heavy-handed. Let's simplify this a bit:

	let boot0 =3D regs::NV_PMC_BOOT_0::read(bar);

	if boot0.is_nv04() {
	    return Err(ENODEV);
	}

	Spec::try_from(
	    if boot0.is_next_gen() {
	        regs::NV_PMC_BOOT_42::read(bar)
	    } else {
	        boot0
	    }
	)

