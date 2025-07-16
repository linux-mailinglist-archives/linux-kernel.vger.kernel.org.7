Return-Path: <linux-kernel+bounces-734222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 672CCB07E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45567AA6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7C82C159E;
	Wed, 16 Jul 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn35v6TS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C00288CA3;
	Wed, 16 Jul 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696470; cv=none; b=eWMdntsVgmM6jVItnleBkxRboN0T/eKdwCTwV9qnmTCzZLAlelDn9WXEbKMdpBjjVrbJ0COtHYRg1vrwrKBMAd7JFsmaY4secGs+pqtKwqtZQnmEqSpksI4crqBe0I3eHtXR+YLL/aruV7j88/REtkTUXEDbzdAoL/EQIT8LSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696470; c=relaxed/simple;
	bh=fAIgMVKK2KkM5ZGHECNMLFdHJy4OxdfxT7hvIN4/5/U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=IwT9Pu6jX9NhPVBSTrdkzRFxJxQar0FZUe1q8+Fs6LdVX2tz/pEjgmETAyyXCImytWy720nMwM/TeWJrT5zngRo9Du/7s6iPx+HulFYcQkKrgXkHMfy+eyMdirPan3GwbLzF/A9lXu+wX6V0J9hhJ+H5i8s83bfOnu73lfVJotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rn35v6TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B98C4CEF1;
	Wed, 16 Jul 2025 20:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752696470;
	bh=fAIgMVKK2KkM5ZGHECNMLFdHJy4OxdfxT7hvIN4/5/U=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=rn35v6TSJFR8GzDo7g77/ZCJC3MUq5pZXU1AFRtQWRHY9rstJdp1ZuljauRWizVnS
	 OnrZ7lKT5PbpF3i9tA55xpfazSYLiDwsAplH6Xdy40jjgeD5Bya5u67QMYrrL25L4L
	 Zxi6rqmZTyNm/CPXC6yyS81HMJuKmfmWgrO8ds64FgCtjy2jmEVKmYvDjJ5mOnm3Hs
	 jKXBVqX5L4pPfmVnfH/8aulUmfXJCptyxT5I4snOb5UpLmMHPZauljMjDA2WeOb6kL
	 pxHMPD8JgLDNtIgA8RRhtNBn0ggAdgqtOFh16aG0w1lynSMmfBhBxr0xX3PjRDWNnD
	 BazS5wCBEl4dg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 22:07:45 +0200
Message-Id: <DBDR1KVCW5DB.23SDI0QO7P95V@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v9] rust: kernel: add support for bits/genmask macros
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
References: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>
In-Reply-To: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>

On Tue Jul 15, 2025 at 1:29 AM CEST, Daniel Almeida wrote:
> In light of bindgen being unable to generate bindings for macros, and
> owing to the widespread use of these macros in drivers, manually define
> the bit and genmask C macros in Rust.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

