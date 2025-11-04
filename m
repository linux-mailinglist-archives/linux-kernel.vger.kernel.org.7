Return-Path: <linux-kernel+bounces-884846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF86C314C9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F76E4EACF3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E669329E54;
	Tue,  4 Nov 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j877KRJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFB286408;
	Tue,  4 Nov 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264189; cv=none; b=RG9YVrzfKGzeN4DmrPE3eLt/mBGdaoVsirEEGuUyloC17W2pNN24/slhp7FHMBO3AZ/s0bkNpD7In4ht2qqWeKpbPEgDm2/l5SxZmEHE4AAn4iOSBzSZEBiSRJIFVnMLeOX8X5oSbakKNzmxjepZIs9LeBOQu+oBnvkwu2bRy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264189; c=relaxed/simple;
	bh=qAe+WnKRhyi7M2hgYxlX4ON4RtjRVE5CgSMyQVRb7Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiZE26NSUs8rCaBjEBHGRfRxNUwhbfa9fEmx3T4E3f2I+r3FqeRfidKR87OjvONvDHBQGarxY9LSgE9gw/VAaPHSsxW5lQN9owl5kvuaw8454FeIywP0d3z7egbcGNtK5dgLqKwh/FkvndxWL0G9E5uXpvD+dtQ70RQYi8QZsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j877KRJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47203C16AAE;
	Tue,  4 Nov 2025 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762264186;
	bh=qAe+WnKRhyi7M2hgYxlX4ON4RtjRVE5CgSMyQVRb7Do=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j877KRJbTrKeV32q1oEbIyDisS+qk+QRihArO5A2jdhVnNaVT1SsmLeR67MMCsyPI
	 iJLwzKKR0+oWOerzl7ZV1rp6OkMR+LM5FH3PconG4wL1tSJTaNRtF7wyVuYx4iiFLV
	 AmN34SEmK2OlyRjoJR3KwxPzeQVDtKrhcRk5pRWBsio6a+zU2x0YZdivy836nm44vC
	 iWtwpW+kRataeuMXBXOSQcT0wncfkLqh5beI1snwT8ucbO3xVy18XbaciYbNP+U1FB
	 xTNvix2BJm8eYYj7TljUHFAI8CTqlsQFBFOm3eLGeg5y4F3ZpBvbg2biUu++H38gSI
	 eq1R6jjtTVzPQ==
Message-ID: <daf3f3e9-19f8-4055-8964-a3ffba97e1ca@kernel.org>
Date: Tue, 4 Nov 2025 14:49:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] rust: clist: Add abstraction for iterating over C
 linked lists
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Andrea Righi <arighi@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 nouveau@lists.freedesktop.org,
 Nouveau <nouveau-bounces@lists.freedesktop.org>
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-2-joelagnelf@nvidia.com>
 <DDX1WYWQNTAB.BBEICMO8NM30@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DDX1WYWQNTAB.BBEICMO8NM30@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 4:51 AM, Alexandre Courbot wrote:
> I am wondering whether `CList` serves an actual purpose beyond providing
> ` CListIter` to iterate on... Would it make sense to merge both types
> into a single one that implements `Iterator`?

I think eventually we will have a bunch of iterator types, e.g for
list_for_each_entry_{safe,reverse,continue}() etc. (see also [1]).

Hence, CList has to provide a couple of methods providing different iterator types.

[1] https://lore.kernel.org/lkml/DDVYV1VT441A.11L5C11F8R7C9@kernel.org/


