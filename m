Return-Path: <linux-kernel+bounces-872423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AFAC10EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBEF0353117
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79D831D742;
	Mon, 27 Oct 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPKiTO1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125630F526;
	Mon, 27 Oct 2025 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592992; cv=none; b=foikL2zMxOvfVy+GpzUmxxmJCWhhLDl3tOz0dKWF2GzqcHjL64uYll6DO3sdtuPkUc+cB8MzbP3xY+uuhJTICyx3M38yzvalSK2Hi2ECEL/6ISqs1h+D11dtzEk1ShlWv/J9fR7er+M8nIvfITHRMEIgbJdlZOs6dqSyuJlGGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592992; c=relaxed/simple;
	bh=uTrTMXHYa+MgSvqmFyrlRj8NJs2QdjeXyKWclcED2Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ra3p/BWtRMye0NoyBrCu26q0A4EaHg1aSSl3kXntNqj3o+31UPTuhsS/8+o7qGp9cy6V9YRk7yZLXNXkqLnkUBiyEbziUE09g7BT+92yIm6ugxxngi2Wtg3Ua/0sEe1l3VqyZFJN/nDMzI9NGArH6j6eTBOU9Fls5vzaoJDWREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPKiTO1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D93C4CEFD;
	Mon, 27 Oct 2025 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761592991;
	bh=uTrTMXHYa+MgSvqmFyrlRj8NJs2QdjeXyKWclcED2Jk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gPKiTO1ACxs53vukMNDQBgl5Tpn58gtc7ZA/bo7QiutJ9EJ1KdJDmYZNzHP5Jje1f
	 FvmbqPdOQIqPlxjgPg9DthVjs2cWm9w/DFxYC/q5ExXXESZPE8RHkqxTSpnbWiTldi
	 tJynXMecooAAP6UEX2seGq4S4YmUQ1k99QqgqxRhAXnonv61mmdtLEaajKU9c2D/vK
	 fuLCH0jZDmtNcxn0SoYecODCR50z7QONE59ii/Bt4wwpr/ffReJV2IMeRPIm0y8Ce/
	 CorwtOEyXKF6Wiy6qagSF89e9oV9uAJuosnoAIA+IMYBQy6JF3gMbRSB0KRUwJ6B7U
	 lkfJDU892oOcw==
Message-ID: <10945c03-8642-4c19-b0ed-ffb20c075291@kernel.org>
Date: Mon, 27 Oct 2025 20:23:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] gpu: nova-core: add extra integer conversion
 functions and traits
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl
 <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20251027-nova-as-v2-0-a26bd1d067a4@nvidia.com>
 <20251027-nova-as-v2-5-a26bd1d067a4@nvidia.com>
 <c94dd17e-0e81-47cc-9482-e8743d3bc68f@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <c94dd17e-0e81-47cc-9482-e8743d3bc68f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 8:09 PM, Joel Fernandes wrote:
> Why not just implement `From` and `Into` for the types missing it then, with
> adequate comments about why such conversions are Ok for the kernel, instead of
> introducing a new trait? This is exactly what `From`/`Into` is for right?

https://doc.rust-lang.org/reference/items/implementations.html#r-items.impl.trait.orphan-rule.intro

