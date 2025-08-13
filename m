Return-Path: <linux-kernel+bounces-767174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A0B2500B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F65683057
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203E28750F;
	Wed, 13 Aug 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP1yHvOj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C81F582E;
	Wed, 13 Aug 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103119; cv=none; b=CkGskdWv2ESEMpSHyJ7Q2+qklb0VhI4GcLB35KxY3pJ1+KgOKs2fLV1hRY1ZKYJequ7YKJ/z5Bex00W8G4HC6byAucw73OlpkN71TdiAv7jGnjJf+m4tX8XYL7L/UoO1hK4ivLuCP8SNCnK/jSfD/HEtUDnWnk56wzM1ltpwDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103119; c=relaxed/simple;
	bh=bSrrYJ5nRDWxnTYtZQ5RJ6DK7pOBI7sCfAHQbe6iUn0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=HPDQaLX2phHz+Ky7Of/nMwNxsKfAp5FfDbNDRi3MsOJ2GQhjAcFPUMcUhRE6cTlOjziRHyV9rKDOv7Iz0oNyw79xflU2uNCqftVGmzNVSKjsCt7n5D72nijhC0iE+rTfH1MyQNYxyMvdRkzoNwUi3bi27G1YtRGxyEPj914JOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP1yHvOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43AAC4CEEB;
	Wed, 13 Aug 2025 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755103119;
	bh=bSrrYJ5nRDWxnTYtZQ5RJ6DK7pOBI7sCfAHQbe6iUn0=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=sP1yHvOjv02ZSqgZeENV92Xi+fFFvsJkrBbZwT7YK81a1qQHI4NBYnGeGjiiI4xEz
	 ARTXNeIrGjxGuuGNnWmUmf6geP/VmBMo7bxlnau5bGqz16e1X8rLqmXkVuWa+ZSe5M
	 eMciiIvBlH3eo4DoCIfbABMp2cz7tdLf5KvI0soFSBRtuyiaj49GdTHHLUDk8X6jf1
	 BNulZ989JCXagLCTBEukOTP+bif8/qiXahWyg57njDF3TgVTbxAQq4hFBEVIF+qjhA
	 YUHOwT1MEn40AkWM+AqLmavKgOOX7rqoYsh+gPRnI+K2ADWeZa4w+SCr8YFbjmGjBH
	 0hnDXO4V/OE0w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:38:34 +0200
Message-Id: <DC1G4NVZ9MES.3KVK7FPXXNS17@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/7] rust: gpu: update ARef and AlwaysRefCounted imports
 from sync::aref
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
To: "Shankari Anand" <shankari.ak0208@gmail.com>
References: <20250716090941.811418-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250716090941.811418-1-shankari.ak0208@gmail.com>

On Wed Jul 16, 2025 at 11:09 AM CEST, Shankari Anand wrote:
> Update call sites under gpu to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Applied to nova-next, thanks!

    [ Alter subject and commit message to be nova specific. - Danilo ]

