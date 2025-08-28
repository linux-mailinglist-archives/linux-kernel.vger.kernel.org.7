Return-Path: <linux-kernel+bounces-789550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1B5B39733
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40B11C22FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379E52E040F;
	Thu, 28 Aug 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOdWZoog"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3332C8B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370283; cv=none; b=ERUGIle/x6WbZiTwobg0snHdIGUB8YoDfBG6GIXx7w6O6QbNx8oLVqjrs3j2gpwWi+ar7qaLDQgHyp4gWze5hEJe7zfKfuBJesoiVDwXfSuJcYXc6HZRGqVzmI/90h9sDUXYo4ww8cClXEmviZ+zGCIWm2X4HF5v2uNhT67d/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370283; c=relaxed/simple;
	bh=RLF9Eq6Z6idVLMgdhF1IxeUg0uG5/P336meJJ/91tmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOpPzKmgI8XtniMXVt2CNq+L4+3JC1l32ZMzKkvoL0oX0Uaw7fgCcAFuQrJyoyFIB4q+/7oFKzaPhc+SH8iotItRcVSo5FhBIC9Xmt39BUT+wfvrcLf53XrxIx0hf3PDTGSlO8gRqx7fj5/LLk63qfHIm98kDowdVyTKODn74YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOdWZoog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A37C4CEEB;
	Thu, 28 Aug 2025 08:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756370283;
	bh=RLF9Eq6Z6idVLMgdhF1IxeUg0uG5/P336meJJ/91tmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOdWZoogkvhUp2tYBgKmEUo+uNcZyZ4yJ5RkXDCt9rd5wUTS31gu6nNh9TuOC+pxR
	 8Djxzg1W6/SF174hnpdATFGA+HT851CaZ8p0SY7FHZcFTsILZAuGgcStu8QdZ17k0e
	 tIvZGhajvxmgMJtuBFZocgRE1Ixt7J4Wly3Cubf//79+jyWiCnoWcOgZLzoq7Sv8OM
	 sIAr6Qgap0prHZstzZ0zpwDBuPeNdEOWS9yD7/V0y5Px95d9/t9MuHxyt+mIbFAx+v
	 srmw+zPSfyX43tSvi0PvTDd6fH8woqLnztC7WVFRK9os6N11mKLlcm0Gx/kVP0t4rN
	 Tvv8EJD0+fecQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: apopple@nvidia.com
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	airlied@gmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dri-devel@lists.freedesktop.org,
	gary@garyguo.net,
	jhubbard@nvidia.com,
	joelagnelf@nvidia.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	nouveau@lists.freedesktop.org,
	ojeda@kernel.org,
	simona@ffwll.ch,
	tmgross@umich.edu,
	ttabi@nvidia.com,
	tzimmermann@suse.de
Subject: Re: [PATCH 00/10] gpu: nova-core: Boot GSP to RISC-V active
Date: Thu, 28 Aug 2025 10:37:37 +0200
Message-ID: <20250828083737.22214-1-ojeda@kernel.org>
In-Reply-To: <20250827082015.959430-1-apopple@nvidia.com>
References: <20250827082015.959430-1-apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Aug 2025 18:19:57 +1000 Alistair Popple <apopple@nvidia.com> wrote:
>
> This series builds on top of Alex's series[1] to continue initialising the GSP
> into a state where it becomes active and it starts communicating with the host.

No big deal, but in case it helps since probably it was not intentional given
the rest of the people is there: the rust-for-linux Cc is missing.

Cheers,
Miguel

