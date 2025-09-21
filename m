Return-Path: <linux-kernel+bounces-826189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9460B8DCAE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAD717BBFE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8F2D1F4E;
	Sun, 21 Sep 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE34BSOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442191624E9;
	Sun, 21 Sep 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758462574; cv=none; b=r/qIPtyq5klLQ+R/nbSP0TTygdNJxBoRNNVSx+qby/3A/s3lNwk+TI7oZIetOnVQjIByQBRtNLYl+/mVBoZD2jq6ZKeyUuDWa7UpsFvlZKdTj26YRAjgi0cNX0tn0/vbVZPu8KJgtVAPnwuBeESoYTXrr7JIcKa/OzWFxoh174o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758462574; c=relaxed/simple;
	bh=e5+K3Urlg6adLZ4Pwf4KqE2HE0p++T1FsRQvdME9z/o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=W0n7qMr7esUfBrVo5XLoTRXWAso99cD/c8wPSdObzwcgipb8857qGdIMj7sxfJOHVUCeeIZn/C1FyxUSFzZEq6py5mtYwgGf+ZwYdJVt+Xw64Qo4x0dAkxgOewx+IVElznHQ58hgBaSOTwvrHmX/3hlCwsEKIOWp9XPTeRpRCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE34BSOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C34BC4CEE7;
	Sun, 21 Sep 2025 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758462573;
	bh=e5+K3Urlg6adLZ4Pwf4KqE2HE0p++T1FsRQvdME9z/o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=nE34BSOpdK7Rh5C6ebcUs3ASozou0kkmg0iq59RQAyOX81p26aH7O/NUXtBWnkA8W
	 Q5vCI67SX+EhmhruBDt3SeWUmEHeEFuBXPsW4iFwJHyA6Q91S1+sXzOva5+WNVg846
	 mdYWYt8x0d13nr8M9t2QdntZjz9dRgYY6pM7kA053izi62U6pIFKrO2bPhuztYOKeK
	 hRzBMdYgUk4yH1eFuIvpzW0SqMxYAisxie7B5h+ISbs9Tx0Mn5QtTJ1v3X+E1vaOgH
	 NxluBCSb8pWvU/oiVLS0tj7TcsWayKkhRotz8v3wzqtDLYmUNx7NDBE3FnWThrs0bI
	 4CdYwy5s5vc2A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Sep 2025 15:49:26 +0200
Message-Id: <DCYIYF3C745Z.2WYSNYOTK041R@kernel.org>
Subject: Re: [PATCH v4 1/6] nova-core: bitfield: Move bitfield-specific code
 from register! into new macro
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <acourbot@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Yury
 Norov" <yury.norov@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, <nouveau@lists.freedesktop.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250920182232.2095101-1-joelagnelf@nvidia.com>
 <20250920182232.2095101-2-joelagnelf@nvidia.com>
 <2025092157-pauper-snap-aad1@gregkh>
In-Reply-To: <2025092157-pauper-snap-aad1@gregkh>

On Sun Sep 21, 2025 at 11:36 AM CEST, Greg KH wrote:
> Your example code using this is nice, and it shows how to set up, and
> query these bits, but that's not anything anyone actually does in the
> kernel, what they want to do is read/write from hardware with this.
>
> So, how does that work?  Where does this "drop down" to the native
> bus/memory transactions and swizzle the bits properly to work correctly?

Please see reply in [1], let's continue discussing it there. :)

[1] https://lore.kernel.org/lkml/DCYIX8URVIWM.2ZK3GHH3J82XQ@kernel.org/

