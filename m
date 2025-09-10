Return-Path: <linux-kernel+bounces-809933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C90BB5139B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E925E176503
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356153126AE;
	Wed, 10 Sep 2025 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+xf1mIC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD6234984;
	Wed, 10 Sep 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499211; cv=none; b=qPeF35/xTpq8a31SIJHS0ahyRpT4KMYbe3hnt0puuI38w5HQfm8R77pr5ecsEgSv995LMBZ40YcJkAQ9UMphOvBBlEdnyA/9QSoKnUzoslm9VigzibL7ubCNOpPXFem7BBJh3ZafVYWHABoMAXFUnQzJotNyGeSq2LEte5uW0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499211; c=relaxed/simple;
	bh=XCVfIR2sQZnF7lqSTt0wZ7w7Pi2Bbv8CJ0wbgy1I5sY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y3PptxKMM9Gmn4rl9lvdgyFhVxWvffQKln7+LRA5o0Yz8YQfAgq6lWtGHroSz9G2ctEWQoeJq79+u1K+ANtNMMutZ/pxvOeeZqzIZIWKXtWPKnVR0n39HoaetwR5BU0nKK7hB7HG1dmYLmjF8x+uj/NVIGCEwrrFgI4p4J2uP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+xf1mIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F2DC4CEF0;
	Wed, 10 Sep 2025 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757499211;
	bh=XCVfIR2sQZnF7lqSTt0wZ7w7Pi2Bbv8CJ0wbgy1I5sY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=W+xf1mICuCkvkNcHJzCcBnebtRtAVel9hbB45jEoFI7o+j/TbKrcnKlcZsOo0CA/u
	 8TpwmG/apsKtQzgqLdZy1ZPGGnriu2rbPcuFXyD5flJ7/7EOVSv3R9NALPWvEErhng
	 Ls7Vfj58Z9lspj5ec87uymu9/KDAna7Q0Er0tNJAL8eqCYo3jCQo/xWC+pSNM4Cjyi
	 D5Wn5K85SyKQ4k4UVVhNvdiQTbi01YSDYVCazw6lvADZ4iJKeI8l4kqcbLbvz1OS4h
	 iS4e6M/zRTT0E5qhnHiQyP+XNYHaxsiqpNXVm8h5HMZ/f/qYBMKqlj48Oov7AwCoNF
	 YS/LzNfp9UBWQ==
Message-ID: <f41f27a3-5519-4c89-ab3e-85b3f747bb70@kernel.org>
Date: Wed, 10 Sep 2025 12:13:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!`
 macros
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>,
 Christian Schrefl <chrisi.schrefl@gmail.com>, Alban Kurti
 <kurti@invicto.ai>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250905140534.3328297-1-lossin@kernel.org>
 <DCMQM2OEGCWN.ERJD4G3M1JQ8@kernel.org>
Content-Language: en-US
In-Reply-To: <DCMQM2OEGCWN.ERJD4G3M1JQ8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/25 7:17 PM, Danilo Krummrich wrote:
> Tested-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>


