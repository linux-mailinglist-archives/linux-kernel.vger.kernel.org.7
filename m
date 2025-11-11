Return-Path: <linux-kernel+bounces-894929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD3C4C789
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782D43AA2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C52EC084;
	Tue, 11 Nov 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMvWt+8+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F02E7F00;
	Tue, 11 Nov 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851133; cv=none; b=u+yB9wi0O1a/GU+C8bowKZrMAEAvyMD5IYyH+WeJyKtmT67thwOB45/0dNDIKkSYj3D0RyY+HKRKdxC3xi+mBFTmsNzJ0DCM2OiQpwFIlGK7hv8AMInt/nn3mlFLMzuy5WDja0jh47quco/c4k7B10f80EKvCtOEE5vaGAXZR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851133; c=relaxed/simple;
	bh=7/WPrD/tWAvIBsaxFhnTLzPsZGGal6J1vjhcUM9a8KM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=do2a9ROwjgVadtMcIqa2JtqV+PAG/EYrE+lwhACuBm6jhnBlB+1hkaS8VIcPSZZ4mAxttWVE1tSdOeuAJDTGjZNwz5I+XLBsPuR4BFaptuqQM4JrEnS5CK8Qij9PGoa1jAb1pNVaY0oYr1J7sS2+yl2hq6KfG+P8YwOgLOwpKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMvWt+8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B717BC4AF09;
	Tue, 11 Nov 2025 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762851131;
	bh=7/WPrD/tWAvIBsaxFhnTLzPsZGGal6J1vjhcUM9a8KM=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=hMvWt+8+HR297yqUBagSlCrnbi8oAgGaYOQ37lInuAoAFI1Y2Es9gDG0rHeUQew74
	 oKCqwjgDsGcivgH14BY0PyrR4AsmLxRNWcTJrF7j9xsrZ/a8ZSBFriIg4wL1y0sYrM
	 3HHEC9gj1/KRxyQCtDm5P4Np6vucBYKBrbGh6olJ6FX0Fw3HxBL1XCBvTmsc3dVVit
	 FM3YsL6JkGXvcnC03bp+pzd3KNSEpCz+WVmb9109O7D6/uMmyau22oezi1VSZykQVb
	 Jok4G4aup37WMsWXPRl4xhnf64x9SHdqrzyCPlbUjUWjN+C9uVVHYi13WpCUzdZpAL
	 mDLyDMxpahptw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Nov 2025 19:51:59 +1100
Message-Id: <DE5QKGHF1IV4.1169X9WBAGRTH@kernel.org>
To: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] rust: dma: make use of start_ptr() and
 start_ptr_mut()
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>
References: <20251103190655.2326191-1-dakr@kernel.org>
In-Reply-To: <20251103190655.2326191-1-dakr@kernel.org>

On Tue Nov 4, 2025 at 6:06 AM AEDT, Danilo Krummrich wrote:
> Using start_ptr() and start_ptr_mut() has the advantage that we inherit
> the requirements the a mutable or immutable reference from those
> methods.
>
> Hence, use them instead of self.cpu_addr.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-testing, thanks!

    [ Keep using self.cpu_addr in item_from_index(). - Danilo ]

