Return-Path: <linux-kernel+bounces-885620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993BC337A3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB71434E59C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4870A27732;
	Wed,  5 Nov 2025 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVFq9yBf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F7EEAB;
	Wed,  5 Nov 2025 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302694; cv=none; b=gOq3MUZ/x226udNL/ScnPqPKvsydh1FwrESA189ITM1jto9VVaL3u/FcngfjL0ty12FyNEN5lABcnLpiffLL2j48Afn/RRIekIWUu3exvP8xzfzGu9EdtyL2qZ1zBw4BsCBxNMVID0Uf3ZUpzCRQ+wBtpMZJzoFnKVlpYnMeXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302694; c=relaxed/simple;
	bh=We+izUg09eb9ItNUyWuuLLa4bSBS75HUkKyrOf0Lj6k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=WzjdQmmMM1XUiLY/XzdSCsLg6zWwrBpK+woHn/8mgQ47s6eTdzluQfVVpN8ZBOdGyxImB4sInS0+eUbDb9VgHL905Uvx/VA0D8aLtVXqK9SNvBLBB8/2FTtKvtGo1yVeT0pzoLpYfOMbOebCw2wEYL9zEREh8LXrKWRghJoYVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVFq9yBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D92CC4CEF7;
	Wed,  5 Nov 2025 00:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762302694;
	bh=We+izUg09eb9ItNUyWuuLLa4bSBS75HUkKyrOf0Lj6k=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jVFq9yBfPf82b1jRb3mgPKTGUDjEiSKq9TYeYHKnsi8wLq8rwzR5rB4XSzzErEx2s
	 wLs8YdD3XBJWh5Ufv3XgbunCVc1IHasogIFtp8ctiPKKVDwReWwyEnfCdqY0dhdtFx
	 QGhjNuzmoGiPnxfgBrVRSwret533knqTYU5rruBOV0NgleY033zpT8W0LJFUI9Q4KP
	 TiXluiCOEwYW1Ibg2HcYHxlm5+PUqPSJbAB7ygSvNkIBI5hj515v4SBhuaSADTXYAO
	 oGhp+YxcmIuu/8ITKq8pNUUSJCDwzwr60c1ebzQwzgfTXQyYl5P2tscDuy/fXdAnJi
	 4qmCOBpxouUMg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 01:31:29 +0100
Message-Id: <DE0C5YXSZYWZ.2NND0468WA77F@kernel.org>
Subject: Re: [PATCH] rust: auxiliary: fix false positive warning for missing
 a safety comment
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251103203932.2361660-1-dakr@kernel.org>
In-Reply-To: <20251103203932.2361660-1-dakr@kernel.org>

On Mon Nov 3, 2025 at 9:39 PM CET, Danilo Krummrich wrote:
> Some older (yet supported) versions of clippy throw a false positive
> warning for missing a safety comment when the safety comment is on a
> multiline statement.
>
> warning: unsafe block missing a safety comment
>    --> rust/kernel/auxiliary.rs:351:22
>     |
> 351 |                 Self(unsafe { NonNull::new_unchecked(adev) }),
>     |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     |
>     =3D help: consider adding a safety comment on the preceding line
>     =3D help: for further information visit https://rust-lang.github.io/r=
ust-clippy/master/index.html#undocumented_unsafe_blocks
>     =3D note: requested on the command line with `-W clippy::undocumented=
-unsafe-blocks`
>
> warning: 1 warning emitted
>
> Fix this by placing the safety comment right on top of the same line
> introducing the unsafe block.
>
> Fixes: e4e679c8608e ("rust: auxiliary: unregister on parent device unbind=
")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-testing, thanks!

