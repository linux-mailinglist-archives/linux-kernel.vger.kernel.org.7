Return-Path: <linux-kernel+bounces-819052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824E8B59AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D438A1887006
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE6343D66;
	Tue, 16 Sep 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh/pih+E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155D93431FC;
	Tue, 16 Sep 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033785; cv=none; b=uSPBQBSmb4u09CZFeaeI5QDyp8LGOPcK6U5Ueqkt1pCxbEQCtmJSwl1jVei6fnir/RCrPgXnOMQnGXt9rudnUa8NYQAMjJ70pV7fyYEFFyJ/4DAnkFunnPFzhNq9dxJkXxJrbmyVVoyC731Q2fA8033xOUb1ATzldjfvy03mfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033785; c=relaxed/simple;
	bh=27ySvtd3dUO78XvzUBYQ1gA9ElOvc66NxkQRlwyPYfI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RkUONsex0M1Mfe7w6AI0exgPGfQFD5I2ZPjmNx8yB0VKk6uDxv+IfXxBIOWC702FpAleXrH9c8kiL0PZLF8GYxN3Ciq0YLNJG6aUDf+urk7WW9FDye93A6ggO/Pz8vgG7iGtnIvyUpwliPQD114ymEjxvuJqwpHi/LftoyVh40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh/pih+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B099C4CEF0;
	Tue, 16 Sep 2025 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033784;
	bh=27ySvtd3dUO78XvzUBYQ1gA9ElOvc66NxkQRlwyPYfI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Mh/pih+ELUPiwHaVc/5+/no3vUj4N50DWncI5OZDjVYTLqf2vB9gb/8jeQdD6BR1U
	 MiU83MiTC5eUHidRAe3IUhqZ+padDI8Zn3xfbCpHUm40Hshnr+ZUaGJnW1qgnSeyvj
	 fEfjhayffU9+phEOFpwcE/cSRlhR/s0rZ8W7PURxJnK6wugMZvXfdQOAzIf5Q/EPbe
	 gouCIumTkECRbygED4AJmR0FV6B7ASA58hoCmm+wKouYnz1SxzoMUCDu8WZNrij4W4
	 GZa8g2OgbybCELuCicywK4vnYw0sLYzLR6NpvtuaziHIby1/ICMdvXGOraHrEBQIRr
	 /TH7xsoHTeKNw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 16:42:56 +0200
Message-Id: <DCUAYNNP97QI.1VOX5XUS9KP7K@kernel.org>
Subject: Re: [PATCH v6 10/11] gpu: nova-core: Add base files for r570.144
 firmware bindings
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
References: <20250913-nova_firmware-v6-0-9007079548b0@nvidia.com>
 <20250913-nova_firmware-v6-10-9007079548b0@nvidia.com>
In-Reply-To: <20250913-nova_firmware-v6-10-9007079548b0@nvidia.com>

Two comments on this, just for the record.

On Sat Sep 13, 2025 at 4:12 PM CEST, Alexandre Courbot wrote:
> From: Alistair Popple <apopple@nvidia.com>
>
> Interacting with the GSP currently requires using definitions from C
> header files. Rust definitions for the types needed for Nova core will
> be generated using the Rust bindgen tool. This patch adds the base
> module to allow inclusion of the generated bindings. The generated
> bindings themselves are added by subsequent patches when they are first
> used.

For now this is perfectly fine, but in the long term we should avoid creati=
ng
bindings from C headers. Instead, I'd like to see the tooling that generate=
s the
C headers to generate the Rust data structures (in a more Rust idiomatic wa=
y)
right away.

> Currently we only intend to support a single firmware version, 570.144,
> with these bindings. Longer term we intend to move to a more stable GSP
> interface that isn't tied to specific firmware versions.

Yet, we have to prepare for proper abstraction of the firmware API:

(1) This is a community project. And as a community project it has to be
    written in a way that is guaranteed to remain maintainable for the
    community in any case.

    This means that the project can not rely on the hardware vendor to prov=
ide
    a stable firmware API; rather it has to written in a way that can deal =
with
    changing conditions.

    In fact, this is one of the issues why we don't see a way forward with
    nouveau, so we can't lock ourselves in here. :)

(2) While I think attempting to be as stable as possible with the firmware =
API
    is the correct approach, I also think it is better to reserve yourself =
some
    flexibility on changing it.

    I much rather prefer a firmware API that is evolving when really necess=
ary,
    than squeezing new features into an existing API (e.g. by adding confus=
ing
    extentions) that just isn't a good fit anymore at some point.

> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> [acourbot@nvidia.com: adapt the bindings module comment a bit]
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

