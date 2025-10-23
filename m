Return-Path: <linux-kernel+bounces-867141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4781C01B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3057E3B2E36
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2422A31D733;
	Thu, 23 Oct 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjZSsazL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761430F544;
	Thu, 23 Oct 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228450; cv=none; b=AgvGCVAwz62SauPlyJ0ptJoVdXzVoUYYENck/qZkdlrN50vTwtsEG7bD+7NtYJcUg1p4DiFp1wPfABmETSIaTc6ir4CilaQjf9391KCiTKSK2lbRAD5ccVAGqxuX62sU3SJb6RRmiHik08KLY1dgC6Ks/rvw7O0Bd3PW9MQYBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228450; c=relaxed/simple;
	bh=JwQLpCZil+iYyJLg+5cxLrOGFlc3x7C3P699NLnVNAw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=lYQMeM1kRvrApHIdAuD6neN7UQk088TU49OV0Bv+NzB3SXfCgWZFo/ULh+N9yKkY8RKD13ECYO9fJgH2LoaqBLf4Uq+3nddkFn83DrlPULV3VUc6E81WImgi3kVikY+oNTcQvKOmeC9k9JMY4yaNuCX/ammH/wi2TTK6vcsOCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjZSsazL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95487C4CEE7;
	Thu, 23 Oct 2025 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761228449;
	bh=JwQLpCZil+iYyJLg+5cxLrOGFlc3x7C3P699NLnVNAw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=OjZSsazLdapyeGKSNIxvnmSbyxj+os64UIaKEolDqwd/vD0Gp7AAi3ut/9LJ4wrE7
	 cP77hQlMkP41nBf5j+s+H2pfeJFTTnkEW0hXQjy1HaQPJ3hz9+6drP7Gnn7BiYWYr4
	 COUDWwbpUW+TNokbHzqmnHZGENHn2XX3SLf14Yv/SPKeA725IvzK7aSv1eITi+jJR1
	 QMGzRuT2AzuyyxuXrPl/UymzOOWE0qXBjysaQfwaZjDVQfZqOHiU4x8AxYjp/aRjgl
	 jVchVZDx88HuoGLSxRn7gZyqVpFImTw+PTQABisSkUjreWCr8CZAFo/JisxpR8q1d7
	 TeNYiNnyOX4WA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 16:07:21 +0200
Message-Id: <DDPRDKFEK3H3.2CE3YMXRTLGTI@kernel.org>
Subject: Re: [PATCH v6 4/5] rust: Move register and bitfield macros out of
 Nova
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, "Yury Norov" <yury.norov@gmail.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Andrea Righi"
 <arighi@nvidia.com>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>
To: "Beata Michalska" <beata.michalska@arm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <20251003154748.1687160-5-joelagnelf@nvidia.com> <aPklNydcTdOeXtdU@arm.com>
 <ACAA327A-AE2B-4D21-B8C5-C66BB5E09B7C@nvidia.com>
 <aPozw8TGp85YdmNU@arm.com>
In-Reply-To: <aPozw8TGp85YdmNU@arm.com>

On Thu Oct 23, 2025 at 3:55 PM CEST, Beata Michalska wrote:
> I guess everything that would use IoRequest::iomap(self), which generates
> Io<SIZE=3D0> which is a game over for the macro.

To be honest, we may just want to remove this API. A driver that requires a=
 zero
sized MMIO region with only optional runtime derived access offsets seems a=
 bit
too exotic.

That doesn't mean that occasionally we'll have drivers needing runtime offs=
ets,
so eventually we want to support that with the register!() macro, but it's =
not
*that* urgent.

