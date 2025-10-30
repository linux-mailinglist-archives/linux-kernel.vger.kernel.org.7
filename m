Return-Path: <linux-kernel+bounces-879154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6F6C22655
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6AF834ED2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6F42E1F1F;
	Thu, 30 Oct 2025 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6CKBQtA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0734D3BE;
	Thu, 30 Oct 2025 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859033; cv=none; b=F5jnYWWrzvIE6KOK1HiGm01JV81qnIP9SqAl2egc0ISQJETijoLe4Gil8j043unIbJBN9zzEtIOGDFiOnXyheuDZVPvkamaMjgc95lwh9zCXcCDUyXkui0PfASlEjMaABIMlTvOfzhkWbtH+rVqZVdBiua3S56STQ5aDGoNPtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859033; c=relaxed/simple;
	bh=XermN9jQ3wZ4fqlqqOotYOXuBNHynIWoOTfpAp4RGHs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=btakyxWdBYOprG82JL6CjAl94Dke1cRVfHXRrOQhk4xQP9N8PT1s9uFgFPyDlIwWMfbIUOZaJoHK80aNsv7FubEdsET+04yODQP5EjlIgsRwUZQ7l/o+VFaMf9Z7SJ4wnue4WG1AhpCXSznUJINefsc+KHFUCrolvHyiqTenyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6CKBQtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9C3C4CEF1;
	Thu, 30 Oct 2025 21:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761859033;
	bh=XermN9jQ3wZ4fqlqqOotYOXuBNHynIWoOTfpAp4RGHs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=i6CKBQtAZlBdtQH0O7unusyS7sO0aEpyqbQLRfXvYDlYSBC1ShdDPzNSNS9wijlik
	 mEx4tLoxpKcnpALBY9+5WuJEjuiEUNVi76+KrThmXpWcNE683gNJH3hSB2Ug3qjWXN
	 QLXnpalf9B7HkXoZe5Fp6KxEMuKgiKYWeM+6nEYseue1SNT8p9X8hsDAcdCQnt9Wnb
	 Q6lmf+LdtEtSk6OQTUPvLGIpTEG9aiquw3B08cvPdvHIXUy/+UcUvTmTtG2t+301am
	 kj98w6ag8lOE4msRzrcYL8gXR5PMVsbQrRVr1s6ACdZRPLnkq96n3e82FY6zxW3sgW
	 yLGBc9cR/tMiA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 22:17:06 +0100
Message-Id: <DDVYWF5UL3T0.QDZNMBTX582T@kernel.org>
Subject: Re: [PATCH RFC 4/4] samples: rust: Add sample demonstrating DRM
 buddy allocator
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, "David Airlie" <airlied@gmail.com>,
 <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <nouveau@lists.freedesktop.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-5-joelagnelf@nvidia.com>
In-Reply-To: <20251030190613.1224287-5-joelagnelf@nvidia.com>

On Thu Oct 30, 2025 at 8:06 PM CET, Joel Fernandes wrote:
> Demonstrates usage of the DRM buddy allocator bindings through
> a simple test module that initializes the allocator, performs
> allocations, and prints information about the allocated blocks.

I don't think this should be a sample module either, the code looks a bit l=
ike
it tries to reinvents kunit tests.

