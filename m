Return-Path: <linux-kernel+bounces-734220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C0B07E89
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF5E566BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68F42BCF4B;
	Wed, 16 Jul 2025 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKtFW5m7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30506264618;
	Wed, 16 Jul 2025 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696419; cv=none; b=d5zhnPGhqJ6/oT4oZIuIyyYrAzjYrDerihr73diZ1jROkGHNm9/qJQr5Rdvnby+Nyx6EtNVa2tK0Z8YTGzgFSUuuTglq0eIZv7OPRTsikWERQlHf68rH5SNU4F9XJm/w1kvOz3wmiMrSdnOZcz4scwuU5INrdbAQPet+mPDJ3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696419; c=relaxed/simple;
	bh=XnBmWX7GkRUoTQVZ0sClSDh7tgJspj9XYLtujPHUBSc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=IJG5ijP0YtZK0KwlEywHJDOsNURUFBjIxihMlY1KMtG39NHsZRGYj+IxF+uiLgqlgi4r63GX3kiXaKOZ9p2Qrxfg9+gzifZuXI5sJQJEBicLDJVN8KYQbeHMj/sOtNqsHPzev8kIhSPB3+SEygksxeEA8rKLrnMLvYvCWrBV/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKtFW5m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D58C4CEE7;
	Wed, 16 Jul 2025 20:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752696418;
	bh=XnBmWX7GkRUoTQVZ0sClSDh7tgJspj9XYLtujPHUBSc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=NKtFW5m7K/CZk7pEqB0Z3ndUHmRqKddy+2pjJ0l9X7yNLmzlSi4Utmrgz9I1eBGZn
	 5mMOOeFRJVq8YKROOH5jiTP6ilsMP7ZWvgCMCNoFCrWS/XPIoEfn/2TLexm71K+5Bx
	 o+Q8bMUCcowujM/JlWBARli7ooDVGmWcWQixz4ppHEuKqJCgBapYukt7TSO5tJlcZR
	 kqopylNtdsujZj9CfYj3eI07Dg4cE6Rmz6aZBBnLvFmrrygREePO5Ybu6XseQIH81k
	 WmRqRSaE8/zrvCM0xmX6cndxkvMnY5cCG0TiZFolDKtZpAfgvtdflvaoIrjT8jcVrf
	 Kse27JsTG/0hQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 22:06:54 +0200
Message-Id: <DBDR0X23V1Z8.B3FYX0G7XTCZ@kernel.org>
Subject: Re: [PATCH v9] rust: kernel: add support for bits/genmask macros
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>
 <DBDP54SLN4EZ.2EQ004NXWCX2L@kernel.org>
 <705CD461-60D9-492E-B82F-C88A848A4348@collabora.com>
 <DBDQASMSS32U.FJBYKS3LWEQ6@kernel.org>
 <1DCA3EA2-5CBB-4193-B1D3-7E286C344A14@collabora.com>
 <DBDQNDJDV41H.I58GXBM55PVG@kernel.org>
In-Reply-To: <DBDQNDJDV41H.I58GXBM55PVG@kernel.org>

On Wed Jul 16, 2025 at 9:49 PM CEST, Danilo Krummrich wrote:
> On Wed Jul 16, 2025 at 9:44 PM CEST, Daniel Almeida wrote:
>> I guess this is the same problem as u64: drivers will usually have eithe=
r
>> i32s/u32s and this would require a cast.
>
> I don't understand this argument? We usualy use usize for such things, no=
?

I already thought in terms of the register!() macro, which deals with targe=
t
types for us anyways. Without that, you're right, u32 is better.

