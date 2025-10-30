Return-Path: <linux-kernel+bounces-879151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16341C22648
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65E8734DFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842362F5465;
	Thu, 30 Oct 2025 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtpTPwT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610A273D73;
	Thu, 30 Oct 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858968; cv=none; b=pjj1isDPHPk8gfvxHjrzFIAnHL3ymr2gGatuNtiDSh9AhS4BCihZLs/hi69PzpkEXRKtoKJq5brOoqunXyahKx8jqM18u21Ms9v29Ma4yT4NU+xfDQ70/ufItJVo+g/MPTqbmAHDTwzokQsgL4ruivJUR3sZEQaWsf0prJTBRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858968; c=relaxed/simple;
	bh=+NHcvXtDxhDQK0BCd82yMG17qtbqNUMyemzVA1CEOZk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Dw15I9VYGCkoC19+2DC603CN79zrTXKIyAPrLxgJ2Hgz4HLab/rcx9vA04Wof/8KDU61nBjC0v5w31bdB2bzEx1qikZEOUQ8TQV0hxuHLHtaYmXkMjGtATb4DFvldwjrwgHXHdGhEIuNLzcpx/zjdlHhUQXxUrEIaoksUQvHURg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtpTPwT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52408C4CEF1;
	Thu, 30 Oct 2025 21:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761858966;
	bh=+NHcvXtDxhDQK0BCd82yMG17qtbqNUMyemzVA1CEOZk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=PtpTPwT6DPmp6kvIEXa7KfuxLfuk2yfzkYRFE7Yh5LQcWGvBL/ME8OoBF3BRXZ3s5
	 icGOERXYm6Sm2t2G93oBJiybf3i8CtzsWS+91NnjsYUMqW+0CM3GsnzuAxqZ3Ay9fr
	 4QgLPhOsWmDxzXoLCWASiYb7iyygnYz2XMJ5i4VB5b28oj8C8c3eNNV12Y0SsPVRv+
	 txayhoac4485v4zTv4fAQqf+r/PESlV47GzIpCOV/dOCeUOFYhk6agBu3ba2kuV2fi
	 YFMUo5UNbPHvooGMlQQOVZg6BnfZCiY99UWJ9aZPNjyGdvshyKvChlbST8+pOLF0d3
	 4uyisTVbx5UCQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 22:15:59 +0100
Message-Id: <DDVYVKDW8WG2.2STCJ4ZU00MZF@kernel.org>
Subject: Re: [PATCH RFC 2/4] samples: rust: Add sample demonstrating C
 linked list iteration
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, "David Airlie" <airlied@gmail.com>,
 <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <nouveau@lists.freedesktop.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-3-joelagnelf@nvidia.com>
In-Reply-To: <20251030190613.1224287-3-joelagnelf@nvidia.com>

On Thu Oct 30, 2025 at 8:06 PM CET, Joel Fernandes wrote:
> Demonstrates usage of the clist module for iterating over
> C-managed linked lists. C code creates and populates the list,
> Rust code performs safe iteration using the clist abstraction.

I don't think a sample module is the correct choice for this. It makes it l=
ook a
bit like this is an API intended for drivers. I think kunit tests might be =
a
better fit.

