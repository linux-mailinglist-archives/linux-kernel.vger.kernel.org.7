Return-Path: <linux-kernel+bounces-771445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6619B2876C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89041AA6B17
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD6B29B8C0;
	Fri, 15 Aug 2025 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IurERnTR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200CB23D7E3;
	Fri, 15 Aug 2025 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291151; cv=none; b=fHdBeAJjU7e8X6tO9sH7gy4qjWBGHXg0Yp6FxKjlH8PJSv4uGQ/Uq+yeFkZubxKuo+GN3cxo3zHxkVH20CCtiVsLswqymqFzLeJAilv+V87ygA0a7FVMC6rWxiiYScJAo+Y7LuYTvVKSQvPtZn2z4BTuzHa9IAieVHxU1AkF/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291151; c=relaxed/simple;
	bh=eHAzQami6XAVAlrDUTRWmkOkyDvVH/c1wmYM49+rAbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkcoEUbcBdoJWpOuM6tSg4pPwWWsnCfjCA4/Ym2wR4U6TY4uYcKMWaaTLJbFYwFtoAdfvW7h1qQENWyWBSCMFnsL903KHvz0WWWPhJm4doUU/oHechxHJkPE9IyMwwhW2N4eXtZ1rrB0fPWChw/Kos7fixrOpoip9ZjRIUOm48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IurERnTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61260C4CEEB;
	Fri, 15 Aug 2025 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755291151;
	bh=eHAzQami6XAVAlrDUTRWmkOkyDvVH/c1wmYM49+rAbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IurERnTRzArysxbhxgERbhQomOm77YOzbaFypkjdMDLMetsgUI+ed5xb7WzZoR096
	 2LWHR7IIYzZcY3eMDLCqaXWRNTm1p49uyXACH8Ap+Zgm8BKZEZibAMGqJ6Ta7nMCuj
	 0cqLydND5agMIsuQ5PnebovhNercbi2YRzq+bxO6Be7arepRy5Wry/FGrfcDPiGGGq
	 6q0ZtPotY6oJheD74apG6xTPsvrCqTL5mUdLusEh8HKcnYEFHJdg7Gft5LAkxBkBiN
	 +mG/s1d7GEG0pqpNEoDM2sA4w8w0DKOMq1EtfkdzVUSxWVTsS666ssySXoMolBE3vP
	 04ymJQonxHB4g==
Message-ID: <160418e6-79eb-488b-a028-009ebdbe66f1@kernel.org>
Date: Fri, 15 Aug 2025 22:52:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: driver-core: Update ARef and AlwaysRefCounted
 imports from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814104615.355106-1-shankari.ak0208@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250814104615.355106-1-shankari.ak0208@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 12:46 PM, Shankari Anand wrote:
> Update call sites in the driver-core files and its related samples
> to import `ARef` and `AlwaysRefCounted` from `sync::aref`
> instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Applied to driver-core-testing, thanks!

