Return-Path: <linux-kernel+bounces-798874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A9DB4241E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422297AE3DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F95A3126C5;
	Wed,  3 Sep 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOYnk5FL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B13112C4;
	Wed,  3 Sep 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911243; cv=none; b=TUSwO+vShVI3MVO79TFH2Rab87YaZPBLuP4uG+iOk7kXXq7vGFzAXC1J2RAsEo1XkgWTkAJ2rCiaIhqPZYflzeh4kqs30Sq4QGxyXdctD8Xkkn2CIB4RkAB7qx04yUN5+VELEhZypC48JgyPqW0EtDl73wYHur/qCcbsOpqDer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911243; c=relaxed/simple;
	bh=7dxGcjkVQEaBQwL4M7LziNmEIKiJ5GLHnlBKDFlV1x4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=bAn+53cwaWYOJ3eLdzlkvl7XvlZc9yOgMzPcbi2UUzHdhioETuJbxGw7hq3zxS2PvoLeM945p3NZIfc2XRxBue112R7y5srSNgFb0BPSFPkIUfwqrg+A1m7pNDCMHkkm3RonrPLt0K9Mwq8BaP2L6jjEdU7jI5WrGDjwE8Vf0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOYnk5FL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DED0C4CEF0;
	Wed,  3 Sep 2025 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756911243;
	bh=7dxGcjkVQEaBQwL4M7LziNmEIKiJ5GLHnlBKDFlV1x4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=cOYnk5FLKNlwh9PbZjvvg9kqFbsgBfKkUoUjIFl87XE4B3zWld6UdRWlywX2SnV1/
	 j4Quq4c2Mjixm6/oxIaFuMMm5KNp5Y+a3EtVEA3maIcpQtxmpo3IgDffU9l96ieClU
	 s4nQW7A9gQjfBCdMV9gqLVd4igDUp0zIh9TCDdX1YfKj3qp7IQmUEGgbzNl2DkAE5Z
	 8QNJ2AJuKi4js9nSBkrFMuenQ/ktrly/VMSdIs8bVVBqOhKJdgx9Lj0e6DOdLPnV2G
	 PyvhG/4RqwBYiPOVP/pKhI+aYCGQMDwUIXsLjaDBfwBZoVvVOtPs95IeTTAhbqqQoW
	 kaf5jPmxdl4ag==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Sep 2025 16:53:57 +0200
Message-Id: <DCJ9206YBEV2.1ICN4VILLM09J@kernel.org>
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
 <DCIKSL18GE9A.2R4BAGR56YVPF@kernel.org>
 <DCIZ5VVLACXO.1L0QTYM5YVRQV@nvidia.com>
 <DCJ0T81CZQ88.6IK6LG0E0R02@kernel.org>
 <DCJ3R8YQUYK1.3K5BCWHMAEOL7@nvidia.com>
 <DCJ46WGRUXR8.1GKGGL2568E1X@kernel.org>
 <DCJ5ZOH6DO2S.8GGF9FABSVNT@nvidia.com>
In-Reply-To: <DCJ5ZOH6DO2S.8GGF9FABSVNT@nvidia.com>

On Wed Sep 3, 2025 at 2:29 PM CEST, Alexandre Courbot wrote:
> To be honest I am not completely sure about the best layout yet and will
> need more visibility to understand whether this is optimal. But
> considering that we want to run the GSP boot process over a built `Gpu`
> instance, we cannot store the result of said process inside `Gpu` unless
> we put it inside e.g. an `Option`. But then the variant will always be
> `Some` after `probe` returns, and yet we will have to perform a match
> every time we want to access it.
>
> The current separation sounds reasonable to me for the time being, with
> `Gpu` containing purely hardware resources obtained without help from
> user-space, while `Gsp` is the result of running a bunch of firmwares.
> An alternative design would be to store `Gpu` inside `Gsp`, but `Gsp`
> inside `Gpu` is trickier due to the build order. No matter what we do,
> switching the layout later should be trivial if we don't choose the
> best one now.

Gsp should be part of the Gpu object. The Gpu object represents the entire
instance of the Gpu, including hardware ressources, firmware runtime state,=
 etc.

The initialization of the Gsp structure doesn't really need a Gpu structure=
 to
be constructed, it needs certain members of the Gpu structure, i.e. order o=
f
initialization of the members does matter.

If it makes things more obvious we can always create new types and increase=
 the
hierarchy within the Gpu struct itself.

The technical limitation you're facing is always the same, no matter the la=
yout
we choose: we need pin-init to provide us references to already initialized
members.

I will check with Benno in today's Rust call what's the best way to address
this.

> There is also an easy workaround to the sibling initialization issue,
> which is to store `Gpu` and `Gsp` behind `Pin<KBox>` - that way we can
> initialize both outside `try_pin_init!`, at the cost of two more heap
> allocations over the whole lifetime of the device. If we don't have a
> proper solution to the problem now, this might be better than using
> `unsafe` as a temporary solution.

Yeah, this workaround is much easier to implement when they're siblings (le=
ss
allocations temporarily), but let's not design things this way because of t=
hat.

As mentioned above, I will check with Benno today.

> The same workaround could also be used for to `GspFirmware` and its page
> tables - since `GspFirmware` is temporary and can apparently be
> discarded after the GSP is booted, this shouldn't be a big issue. This
> will allow the driver to probe, and we can add TODO items to fix that
> later if a solution is in sight.
>
>>
>> I thought the intent was to keep temporary values local to start_gsp() a=
nd not
>> store them next to Gpu in the same allocation?
>
> It is not visible in the current patchset, but `start_gsp` will
> eventually return the runtime data of the GSP - notably its log buffers
> and command queue, which are needed to operate it. All the rest (notably
> the loaded firmwares) will be local to `start_gsp` and discarded upon
> its return.

Ok, that makes sense, but it should really be part of the Gpu structure.

