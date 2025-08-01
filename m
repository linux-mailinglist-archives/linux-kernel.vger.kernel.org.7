Return-Path: <linux-kernel+bounces-753185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7E7B17FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80261C80AAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171B231A23;
	Fri,  1 Aug 2025 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4Mxx2yk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249C1C3F0C;
	Fri,  1 Aug 2025 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041972; cv=none; b=RCHthcvpHGP98kM1aO6349nJ5I9FXbFGyPaUmJvA+ZruXVx9PPLKYCabp/S8oJ9kGPCUJkfGUD7BSrYfoXIv3WQpzW/CDJh3+CYpM4m8+3xbFa1IVccTXPesQPkCsXlYzUtfu2fEBr33MQjmDPGww0DPo1xvP/Ts6laPNGKX7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041972; c=relaxed/simple;
	bh=XWVfJARE29L6S8L6M85DEoeDJhaQJ3KW7VCi1swPty4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=UP/juy8slUGeiaM4Wpk5NNlXLqjKxxbuYitBKaKGsmd+c2exIl6yxFjXxeNR5Unv5W1J/iNW1WKGI4TW2mKXgWcwmw4TZplyVE4YXg5hc453n4ck0EVbLNs30tfQjQqRuAepbkw2SA3PPGiylzjktSebWqFzHSSs8K0ml2sNyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4Mxx2yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253ECC4CEE7;
	Fri,  1 Aug 2025 09:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754041971;
	bh=XWVfJARE29L6S8L6M85DEoeDJhaQJ3KW7VCi1swPty4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4Mxx2ykiiEkKOFURdp0PlixlkEvQxTrQgVUXrvhUEVPRzDMUMaU9F9sycyJ8zQQt
	 yOfMbkqws/fTDUC/1EY+A/NrHiE4BYTa5c9PW931U2kisyu2oV/6fF3pulWVjX6sh9
	 dWCBneHfldpyTP7gAEbbFOgiTYVOvnieelMPZfx5pO5qdbzpCTwIXrZoHRyWSdpQZ4
	 xY7qoOHZKL5jWShRgvq8pZGgNrpfhuGa1E7W2w46Bme4lgRJ9KmHkbn4V7zGCg7v1J
	 mduy6bptGG9AQy+oCOesoWIXx8Yo85pEU8zZizvX84lz+Ph1OpfNWTBG1paOiepcBl
	 IrOIvdDU0JPXQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 11:52:46 +0200
Message-Id: <DBQZZFBPENW5.1S84EVRD3DDH0@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <lorenzo.stoakes@oracle.com>,
 <vbabka@suse.cz>, <Liam.Howlett@oracle.com>, <urezki@gmail.com>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
Cc: <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] rust: drm: remove pin annotations from drm::Device
X-Mailer: aerc 0.20.1
References: <20250731154919.4132-1-dakr@kernel.org>
 <20250731154919.4132-4-dakr@kernel.org>
In-Reply-To: <20250731154919.4132-4-dakr@kernel.org>

On Thu Jul 31, 2025 at 5:48 PM CEST, Danilo Krummrich wrote:
> The #[pin_data] and #[pin] annotations are not necessary for
> drm::Device, since we don't use any pin-init macros, but only
> __pinned_init() on the impl PinInit<T::Data, Error> argument of
> drm::Device::new().
>
> Fixes: 1e4b8896c0f3 ("rust: drm: add device abstraction")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/drm/device.rs | 2 --
>  1 file changed, 2 deletions(-)

