Return-Path: <linux-kernel+bounces-863059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD8BF6E84
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27683506E75
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3223396E6;
	Tue, 21 Oct 2025 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sazqVkl6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3A2BEFED;
	Tue, 21 Oct 2025 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054700; cv=none; b=dSsZkwuPry03FtKgnpeU5rcjKx4JXYAd/NxBYcV3WpW832aAWUe6oW75uJcf6dluHM9YPcuYLRlV8tWYszeB7QoueiZeJt9U+S+ShLBcO4qjg0rdAcmoa5AbDdkYO4ecdRjvdL812C76DUirHS2HCeS9ERl8RitQfY7Rm9i6qkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054700; c=relaxed/simple;
	bh=VAVJx92B0MVr7C4HDSOeGAhnQWMNJKXn0oReX7qLlKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePVLRBTyr7dGBHzahA6ZRmQe59x4ppgiMeSZx9O/mtaq7Al0s1LjxN+njXgQY0LpNPAFYSQLFbJZsNxvNtHvVUtwVx66Efn5xLSoEQpI20WIB5BRP4F54wCTbpHYoA2NkMgZTHIML+pSnvcqFFrK2OQPvKwKTGlNaxEh3le86/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sazqVkl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC4BC4CEF5;
	Tue, 21 Oct 2025 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761054700;
	bh=VAVJx92B0MVr7C4HDSOeGAhnQWMNJKXn0oReX7qLlKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sazqVkl6KgZMlHA+dxA6cCiSLmrM3ORYcfOKEDvhQ826alKSQLwKb+sxVafJDJeQI
	 Kkh9YC+rPDX04fbGm1ferSimYJaLtLsrcIFS178gBOVWzLV4sscVTlTDAI6GGNW8ee
	 tDPyw/zct7dDTJnIfDo7tj/zmbfNXdbasiNYOjcWRkmgwTZgB2tck6EPzq2TR5Wx72
	 z68CZJwSMWc87jq7avaG5wB4NmBI69LLbxYbFY3u+GWDoEVW9WUuaIpQBRXeUwKVhD
	 Gt0eVi5gx06Y2jbWXVFZqP/uvt9O9NIGETHQ4bOVncCcJhDhlLAQzfwI+Q6KeU3HqM
	 gsR2pUO4AoZnw==
Message-ID: <899a0069-864a-454d-a7f8-333cc835cf23@kernel.org>
Date: Tue, 21 Oct 2025 15:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7.1 0/4] bitfield initial refactor within nova-core
 (RESEND)
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
 Yury Norov <yury.norov@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, nouveau@lists.freedesktop.org
References: <20251016151323.1201196-1-joelagnelf@nvidia.com>
 <DDLHP1ABV9BA.3V0NXW3RWHGL6@nvidia.com>
 <059912ef-6023-4af4-a8df-f4b34fe98e71@kernel.org>
 <DDO1O4XLJVHR.1642YK4GK85CT@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DDO1O4XLJVHR.1642YK4GK85CT@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 3:46 PM, Alexandre Courbot wrote:
> ... and as dim was pushing, I noticed I forgot to add your Acked-by. >_<
> Apologies for that.

No worries at all, it happens. :)

