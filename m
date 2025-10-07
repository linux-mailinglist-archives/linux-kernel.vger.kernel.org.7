Return-Path: <linux-kernel+bounces-844287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4ADBC1757
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2A7934F0F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A722E0914;
	Tue,  7 Oct 2025 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhEl/zG+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC934BA34;
	Tue,  7 Oct 2025 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843003; cv=none; b=f1uPDSSROMaaWD5Oh0gV7K8lgL9E2GVEoHjTe8pIYckmi6P69JUDWaROOxZ+of7f49ZbHnZYS36O9r5S0ztGqteB2I40wD8lC0Hh8QnoMD9iurHMUpe669b/Z4g/hD0x3pq1aT0TCLVFYyyXwxSMeBVNBZNupdWPpdTDzOemH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843003; c=relaxed/simple;
	bh=6UjzVlz1EtzKDtCcbFvNlSfCTmDJhScI63/zH3jvfVA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qoakepgld4I0c0uisGmUu/ap01Ucfe7L4mTrdRWTCqSSFbzKl7HoAnMu2W+IjbeTFpC+21dioo+IMawhBqyMrejbqQBJHkMKSKQNuAPyZuz7vfOFthi9OUrf+4naqLozn3xIYyn6v6qIBumD7pKmMZWbgxMPnnlnZdGsvikith4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhEl/zG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB19C4CEF1;
	Tue,  7 Oct 2025 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759843003;
	bh=6UjzVlz1EtzKDtCcbFvNlSfCTmDJhScI63/zH3jvfVA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=DhEl/zG+D7xFgqiPWQVAdl3fHwTnoe02BBj4mm/Hut3L3AvLtiropA6iQKNKR9ihj
	 PrDT+saQAFcMRAX90RlVlIsHlT5aSWD0Jun9zUaMYd1q0lm11iY0q4xTAH5bxq4BzW
	 Imdfn0O0PVR1fezkl+US2ZbE2qKJrPd/JvACcmAJ1AWQ/bYAqYbptM3BiMKz9A/Pjz
	 PJJVjtZ2YgwVK6RnK+i2UHpCyuoGHIuHRXM+fGJdFvf5pO/XqgZPh524KbGltDXMkm
	 CsvbFYPZOYFlGn0tc6e7yh9a/XT4R/XE4NsqkLutt3X0cyrbsD5Uz8knxfBlMfKmMZ
	 5QT6K/RWDIkbw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Oct 2025 15:16:36 +0200
Message-Id: <DDC49ZIRX79X.2Q4KW0UY7WUF3@kernel.org>
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to
 rust/kernel/
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, "Alistair Popple" <apopple@nvidia.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Andrea Righi"
 <arighi@nvidia.com>, <nouveau@lists.freedesktop.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <aORCwckUwZspBMfv@yury> <DDC0VAHL5OCP.DROT6CPKE5H5@nvidia.com>
In-Reply-To: <DDC0VAHL5OCP.DROT6CPKE5H5@nvidia.com>

On Tue Oct 7, 2025 at 12:36 PM CEST, Alexandre Courbot wrote:
> Because letting it fully mature within nova-core also has the drawback
> that we might miss the perspective of other potential users, which may
> make us draw ourselves into a corner that will make the macro less
> useful generally speaking. We are at a stage where we can still make
> design changes if needed, but we need to hear from other users, and
> these won't come as long as the macro is in nova-core.

There are two different things here that are getting mixed up a bit.

  (1) Moving the register!() code out of nova-core to make it accessible fo=
r
      other drivers.

  (2) Generalize the bitfield implementation that so far is baked into the
      register!() code.

Both of those make sense, but they don't have to happen at the same time
necessarily.

Now, I'm not saying that we necessarily have to change the approach here. T=
he
current merge window isn't even closed, so we have plently of time left, i.=
e.
there's no rush with with patch series.

However, if it helps, I'm perfectly fine to take the register!() implementa=
tion
into the I/O entry in a first step and in a second step generalize the bitf=
ield
implementation and move it out of the register!() code.

Again, there's no rush as far as I'm concerned, yet the latter approach mig=
ht
add a bit more structure and hence run a bit smoother.

- Danilo

