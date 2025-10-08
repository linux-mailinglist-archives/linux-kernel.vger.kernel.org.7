Return-Path: <linux-kernel+bounces-845316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515CBC4617
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2D5C4E7430
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140222F60CC;
	Wed,  8 Oct 2025 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvbuXq/H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C462571DA;
	Wed,  8 Oct 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920078; cv=none; b=T2UasRlQ2pPiOWUWkM+L6UZ544F6CdBz8mmqwwBjy1NgTXwQaGaXpWajkjAZhF5O7pqkJHzEz7yJI2cJ+EB7MWqSZPnQgHbrLgn1oCGiaySP4Rt4iO1QwXB2j1EAcRiLT/zSWV44nvh9pTL5uOy3q7NrF68zw7nbTCGqc/W+jzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920078; c=relaxed/simple;
	bh=YatX5O63Ff4zVnHnAT/CplF1NLfDnBDH5HmwjIgR74c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZlnGePF+lGCyLGWAn5WGS90/9Kji+6Qfi0WZj6mEp/7MaDmA0aMV685MbWqtY6WI0PcOJzSWFTLgE36v7HiDEV5ocPrc6aMQSxZSFFsbx/ktqmbIQyb5yvRaG0QNP/FFQPHQ4RxEMtYQYoj9iI9sl3Aji1cibJvEqMlGtqy0lqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvbuXq/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6B2C4CEF4;
	Wed,  8 Oct 2025 10:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759920077;
	bh=YatX5O63Ff4zVnHnAT/CplF1NLfDnBDH5HmwjIgR74c=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=RvbuXq/HH76eVY2ILF5zuYaBDIL6RqA/dEAriJusY0TlAl5qwo5b5WThl6AQLelU8
	 +0571aA96HW0Eh6f0Vu6d0FYE4BFmKcKQ0+OAuS2x7bfI+vs+bzJGQasfpOcRMPZ0w
	 AmhxXL9VppZY9QcyUwE005GicsWdw7Ns8cEBcCRLbqkA4oH+H1qhCUfRv0kl2p5/PF
	 +pUm+PyiF3Lcy4+xVh6K1uxfAnLtRP3Sq3j3dlpIpGrpUbqHdD1Qhnj4uLPyHFGtgP
	 OshtBBA9kdIFzxslM7dfkUMccTx3j+dq/ybIWfzRnfJPpU4w86lQrY43nN8kP2Z7BF
	 B8z2tIjfyukdQ==
Message-ID: <d3246f19-e2b8-487f-b896-3bef1ee0174b@kernel.org>
Date: Wed, 8 Oct 2025 12:41:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] gpu: nova-core: Boot GSP to RISC-V active
From: Danilo Krummrich <dakr@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 acourbot@nvidia.com, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
References: <20251008001253.437911-1-apopple@nvidia.com>
 <17dd5928-f06f-4747-b36c-195be4ac5082@kernel.org>
Content-Language: en-US
In-Reply-To: <17dd5928-f06f-4747-b36c-195be4ac5082@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 12:38 PM, Danilo Krummrich wrote:
> On 10/8/25 2:12 AM, Alistair Popple wrote:
>> A full tree including the prerequisites for this patch series is available
>> at https://github.com/apopple-nvidia/linux/tree/nova-core-for-upstream.
> 
> The prerequisites in this branch seem to be upstream. When submitting patch
> series, please base your changes on the corresponding upstream branch (i.e.
> drm-rust-next, on Linus' tree in this case) and make sure to include the base
> revision (git format-patch --base). If it depends on other pending patch series,
> b4 can help to track those dependencies.

I just noticed that you have version nova-core-for-upstream branches, but v4
seems to be missing.

Without the any base revision I can't apply the series for testing purposes. :(

