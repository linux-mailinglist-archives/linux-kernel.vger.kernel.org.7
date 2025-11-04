Return-Path: <linux-kernel+bounces-885340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34960C32980
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D14188FF3E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1060733E376;
	Tue,  4 Nov 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUv3mfeO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E833E34A;
	Tue,  4 Nov 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280320; cv=none; b=sB+dZY2SeBHWw3wtBBbdcQd/bsg2ytGIHUJNF1mGdO9ehP1/r9o9JXuaHdqETRgm4eQcZzIaPrHye7AvfkOCfVsB26nFanGC1AA+yQIDrspcyAEqoc0mpupOmAGp9mq+WIe5Z1zNuds3VsP7NFeu0Zv7FA6JXazaT76UWaI+m5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280320; c=relaxed/simple;
	bh=yGRnsBbb5Du0szO4BPlFV4TodS9lEiUCQrYF+bOx4vY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=AW0NOJHu/owzxtxIeFePKkQVcogkJQRcxsrk5VXOW3px4LsX/zjBJo+2Ip50GSLJj+nIHW9mXRYxkvvXgHrl/2uEil31f6i43SPlAlP3dpF6R4pboN9ENlbJ5FdARLocnMKMrHIYd682U2++uoqG6ZPAOAT4DaXdzeShA7tHR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUv3mfeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB74CC4CEF7;
	Tue,  4 Nov 2025 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762280319;
	bh=yGRnsBbb5Du0szO4BPlFV4TodS9lEiUCQrYF+bOx4vY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=GUv3mfeOHDGSrgJUzJs9qVbo0p0dJU6bJ3d3FdiooDni+U0RK+SDizQkkR9iEsSc2
	 yCiee8rVDxAfRAfRW5Hm8VU2YE5P9inYoRB5EG7J/FKeaV+b2ZFQTQoWKzwj07brWW
	 6QWyCshNGNYEMeiORj+FIlUjyuAsxUntV0cubbpDUQaqwoNKwN2s8UZ5MZbLpTtqzn
	 1GOXMpZAKrIM/LwmqTa7Jr4kIh6cVFQcXtG0YrykfLfO5wj69GR9nIUApG0KZHxjsT
	 lDopn9GkN8ubdtA7/UWqCtz6V/pNRrW0HLhqs1e0sj2IL6Acu93MGyZfC5laBz4Dxv
	 GBd7KsinxeLvA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 19:18:32 +0100
Message-Id: <DE048FD96PHV.2SXSVEHPD9ZOP@kernel.org>
Subject: Re: [PATCH 7/7] nova-core: mm: Add data structures for page table
 management
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
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
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nouveau@lists.freedesktop.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251020185539.49986-1-joelagnelf@nvidia.com>
 <20251020185539.49986-8-joelagnelf@nvidia.com>
 <CANiq72=SSQ5nSjt9yzX_A3Tgo2ByGM5CV0VqFnF1cTOzrZ-pbg@mail.gmail.com>
 <226d7dcb-26c3-4477-b1e9-2b837dc17cd1@nvidia.com>
 <CANiq72mqDWrLp9EjXHUgeODh1zh-9XaUnmgHWGgX2Awqs4G=cw@mail.gmail.com>
In-Reply-To: <CANiq72mqDWrLp9EjXHUgeODh1zh-9XaUnmgHWGgX2Awqs4G=cw@mail.gmail.com>

On Tue Nov 4, 2025 at 6:54 PM CET, Miguel Ojeda wrote:
> On Mon, Nov 3, 2025 at 8:21=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.=
com> wrote:
>> Also a lot of your suggestions are related to how it looks it rustdoc, s=
o I will
>> try to build rustdoc and see what it looks like as well, to get an idea =
of when
>> things in my patches could be improved.

For the drm-rust tree we also have a summary [1] of things committers are
expected to check (including a link to the generic kernel and Rust checklis=
t).

> Definitely, please do!

@Joel: Just be aware that for leaf crates no documentation is built yet, on=
ly
the kernel crate is built.

[1] https://drm.pages.freedesktop.org/maintainer-tools/committer/committer-=
drm-rust.html#submit-checklist

