Return-Path: <linux-kernel+bounces-732501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B6B067B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A81C20A70
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD6528000A;
	Tue, 15 Jul 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNILsdsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727617BA1;
	Tue, 15 Jul 2025 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611375; cv=none; b=p9EfPOxYgD+f4AqXlMmq/Rlih3S4lY6AOoLZ1rxqS/+J3dzHX9Vh7VDEKiO07dF2sdnHhwVZXv9JZny6gNdhNNA3M9aeePakuaoItihC8TfPAfZB7BkBk13xhdJMh3O837i9xOrgxud8Y/A8CCZXpL3dYoeqzJ5Crun9/kl2dDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611375; c=relaxed/simple;
	bh=dWV0AOGFfsNzLSm694vzHVb8NS/g7l9T2ZgoYSgKYR0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dsjhMcWH8irfFvj3n6zINZ6Fc+Y0DeZf6uOw3tHxc7zGE0LKIMWQcIpYo5ScOULNsXnFDZX/5xIvvoKAAZz7Ej/c6V3pyXRLupmCeEvG+SYBnCQIS5G2tu7rCqPJlcvTCIacXtyKDqVR1PQVtvuwvT3Y7nJj88JkR84fw4Dkh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNILsdsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92867C4CEE3;
	Tue, 15 Jul 2025 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752611374;
	bh=dWV0AOGFfsNzLSm694vzHVb8NS/g7l9T2ZgoYSgKYR0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=dNILsdsShfcJucSIJZt5B7bPM3kYv7DhMqm7dBg73FqStGPvULwZG7mQFxCY2YAYo
	 9zyLum1XNeIHRbAKU7Ca0IpufeZlU17Bmjh1g1Z6jHRXwD+cu9xLQM0f/1FdSJQx27
	 vaHeuyNCBCVBTQ8U3NfofoAugId+gCPOWsmGYwVjxcbqDtS4w50n3hUKmCt7G0ToPl
	 TNEiMFTiP1Puwxpf9DgnM2GcnSVmROYzkqBIcndxIx9NiIlq89pO2QBiQmIpFC57la
	 93ltivouyWhGtk9LAISC/vL81ndpbulqz1c0OssJHwdE6T0bBaX/cl2notwVNe66TR
	 jW0AAZstgQI0g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 22:29:29 +0200
Message-Id: <DBCWVO6JLS7R.2U9HD1LH0JNO@kernel.org>
Subject: Re: [PATCH] rust: devres: initialize Devres::inner::data last
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <m.wilczynski@samsung.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250714113712.22158-1-dakr@kernel.org>
In-Reply-To: <20250714113712.22158-1-dakr@kernel.org>

On Mon Jul 14, 2025 at 1:32 PM CEST, Danilo Krummrich wrote:
> Users may want to access the Devres object from callbacks registered
> through the initialization of Devres::inner::data.
>
> For those accesses to be valid, Devres::inner::data must be initialized
> last [1].
>
> Credit to Boqun for spotting this [2].
>
> Link: https://lore.kernel.org/lkml/DBBPHO26CPBS.2OVI1OERCB2J5@kernel.org/=
 [1]
> Link: https://lore.kernel.org/lkml/aHSmxWeIy3L-AKIV@Mac.home/ [2]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-testing, thanks!

