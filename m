Return-Path: <linux-kernel+bounces-721512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A48AFCA30
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D341AA8750
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD62DAFC3;
	Tue,  8 Jul 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8Oh47Jy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE46230BEB;
	Tue,  8 Jul 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977015; cv=none; b=CoIlmTvcWK9+QIj8zmcdpON1c5kDmpl9a+B+MzDgyXHLWzJYPz6q5TcGByczNe+l9noCSWdwdruOzlmVEprMnYstLluw4TyLI9yG/mYb1FVSnK+YGtC/4V3BzI6P7VAE0daq2gAgXr7nkN4RJoz8S3m484Ne6Se0Gmx1vcRla+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977015; c=relaxed/simple;
	bh=UX5SL30m1Xk0f/z9EjIAeXqtJadRzsa/f1YsG2h4mZ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VPq84dsY7V4+7zZfdkFFar7KZipkFNK+nwTjl7/3ezRNn5/Q4UvJS6kp9VXNh9+DuJ3smL35cm4iqs21qfdDBEV2b4OjJIYM4mrPqXMOo2xPsiy6DMULWWGsH/OyOFgHAymK6y777mOYZaNW/gZjtlzl1q1JkFP2kOg1125pJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8Oh47Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAADC4CEED;
	Tue,  8 Jul 2025 12:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751977014;
	bh=UX5SL30m1Xk0f/z9EjIAeXqtJadRzsa/f1YsG2h4mZ8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=H8Oh47JyYF5FOH7w8PE1aJfcC5j6Ba7j6+kVL7hvPjKkwyDw0FrUF17CcuMny+Ual
	 8EyC/M9mOdIcNuCdbqvmxheE2VeIhcfA42yfUYdN96nOwlxZguU0JtNlXmUTFxz3kg
	 i1MU5VhXNu/QhKzy3NFOtpw3Q7BrYN7WaL+nsund1VvbKR+2jthvgYPRP/IJEr7qDz
	 XLP81ZVyj/cF1O9ZMj19RJAmy8jFRJFVeWrAMF6irRhFsSCyv3r7pkTEBNVSbLJFMn
	 aHRvc+d2jiXPWwvYtDVLy67jeYt6uNobeDYO0MX0gipUcFrvydQC4vBCHskSiionBG
	 rx+Yi7hiH41VQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 14:16:51 +0200
Message-Id: <DB6O0NWIIQT8.28POWW36WI5Z1@kernel.org>
Subject: Re: [PATCH v11 4/4] rust: support large alignments in allocations
Cc: <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 <rust-for-linux@vger.kernel.org>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <20250707164948.631563-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250707164948.631563-1-vitaly.wool@konsulko.se>

On Mon Jul 7, 2025 at 6:49 PM CEST, Vitaly Wool wrote:
>  impl ReallocFunc {
> -    // INVARIANT: `krealloc_node` satisfies the type invariants.
> -    const KREALLOC: Self =3D Self(bindings::krealloc_node);
> +    // INVARIANT: `krealloc_node_align` satisfies the type invariants.
> +    const KREALLOC: Self =3D Self(bindings::krealloc_node_align);
> =20
> -    // INVARIANT: `vrealloc_node` satisfies the type invariants.
> -    const VREALLOC: Self =3D Self(bindings::vrealloc_node);
> +    // INVARIANT: `vrealloc_node_align` satisfies the type invariants.
> +    const VREALLOC: Self =3D Self(bindings::vrealloc_node_align);
> =20
> -    // INVARIANT: `kvrealloc_node` satisfies the type invariants.
> -    const KVREALLOC: Self =3D Self(bindings::kvrealloc_node);
> +    // INVARIANT: `kvrealloc_node_align` satisfies the type invariants.
> +    const KVREALLOC: Self =3D Self(bindings::kvrealloc_node_align);

Please also adjust the corresponding type invariant. With that,

	Acked-by: Danilo Krummrich <dakr@kernel.org>

