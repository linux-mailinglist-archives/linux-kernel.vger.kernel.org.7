Return-Path: <linux-kernel+bounces-776585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CECBB2CF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A942A7BA46D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C02BE634;
	Tue, 19 Aug 2025 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL83M13b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F92609C5;
	Tue, 19 Aug 2025 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641890; cv=none; b=RkguikKkFRwFm0VmKRJZW1KQYhBgoQjVK0+Tb2tsrypdyUhP7KP58GPb0U2wg4YqUAAMgs3x97MwJHhzzP57I7Jf6ACqPwVsB6wEV0i9RJqgaIzzZwo+brHPWwznKk5f9U0ffvvoRuY2DmG6U4y1bapvHYFMc5GtIqdyVbh/PGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641890; c=relaxed/simple;
	bh=eqOwQR2jm2IeWD3JgzkN6rMCM830M3BeoB2vXL4wVu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+IGxJw93w9Yk+OUCXrLoXGEWBaHHZ3Msk10c1gczNhMVm31ynFssQB78Qna+iF2xK64ZfpmqbNf8m4jzcMGBIJBx3VBLJ0ZNB6vpWtKIXf2jHd6NEltkh/opOi63au289i7dOlqcmAtPJSXL7m0CMt2DgyCDihzXJsifSWGrEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL83M13b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494A3C4CEF1;
	Tue, 19 Aug 2025 22:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755641889;
	bh=eqOwQR2jm2IeWD3JgzkN6rMCM830M3BeoB2vXL4wVu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RL83M13bJInaSZihQU9TONkgy/RQ0cJ8/FF/BzhkDaReiFSjkxd+/8L6QRt5Zqv53
	 rfIJJKeqWymhdiD6FfZU3O1SyEUDNkB6pA8VxEQq02qCt8HakohxWAAccQNeET4dTX
	 85QPv+muydeFIMLkN+hWAVQdEXIWaRdQT44h77anXH9FPg92S8WPVaLV+InzMbz1ds
	 RKUya+W5mH9BYpdTODaAheBdrftTT36U71SoIwPw1KRMSXsxwwngx7/N+nv/GbqSDa
	 qoVTXyDFnGhZRw37AFyOmQD55UHTv+DpA3mu2hv3lEH1CyjMbPlZ3hbjS2RxsQoQaL
	 jBSEOoWo9RrBw==
Message-ID: <975f5715-0303-49b5-a3fb-e0af414e483c@kernel.org>
Date: Wed, 20 Aug 2025 00:18:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: drm: update ARef and AlwaysRefCounted imports from
 sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815161706.1324860-1-shankari.ak0208@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250815161706.1324860-1-shankari.ak0208@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 6:17 PM, Shankari Anand wrote:
> Update call sites in drm to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Applied to drm-misc-next, thanks!

