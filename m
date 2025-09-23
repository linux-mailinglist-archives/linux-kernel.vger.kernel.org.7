Return-Path: <linux-kernel+bounces-829148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C2BB96642
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720541620AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270A24635E;
	Tue, 23 Sep 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4KYFdok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F8233722;
	Tue, 23 Sep 2025 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638537; cv=none; b=eV2wBS6+yQ52GMTiHxR8UUBv5Q8+KO2ggvFAXUKcVftWOF4s7yUqbtMF6bYNyf8HIneqrMzefMIJrTQqPCBQTal6vkmw8hABqHuF3gKNz/ScH8blJFPhluW04QhmF1LEzwGJiDg9cHl8Ng5tvsHDxyb/q9mEUqcpmFP4E2MoL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638537; c=relaxed/simple;
	bh=6K077GRyfTK2Mk4OhbSpfWz0s8ygG0pgGdEAMzJ0nXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZvPRgGF4GksIAtjazDREGtG4+rl0XaFyOKwCvBKpCIbH/CZZDZ7DEtvF+gGsSgsXA03IebCZO53XBb9SHHdBQAMUsz56r7GXwdQZCm89tM/bMb4djDZULz8JBxkc0ZF3F9Ko+dpnyfiPHG+lOdvJImCWeJfx8D1R9m7z2z4vFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4KYFdok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB04C4CEF5;
	Tue, 23 Sep 2025 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758638536;
	bh=6K077GRyfTK2Mk4OhbSpfWz0s8ygG0pgGdEAMzJ0nXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k4KYFdokLCC4nNzWNYnLowkJAh1u/E9xRoPhUzQrf84e+ppnPDO9jBlG2nKGjiYHK
	 MfCo3vcqmAcumlXt/yM6KmziDVSCxYmYzINC9Ym4EysDnySbrYx1cDRhBByTofmNTa
	 sKHlhfD5qSK0EywS3VqjJ2aPpbmJVCf63EIKHVv+tL8XwZT6jfcwiI43RoG19X2L8j
	 nRcmMwGR/S3L6FzOxB6BAoMjboVwvt8Zw0ShnuOpZX+tn8bVbwCxvMy7wnbRjH2Qs/
	 G7tMoFIy85cT1USkcevgSwbjugh2j7xv2i4bUXNe+BUUIABNV6Y7AGRep22Tg7ERB5
	 Xgaf8qqXW7dWQ==
Message-ID: <9995561f-7157-489d-b48e-fe6c92e1f408@kernel.org>
Date: Tue, 23 Sep 2025 16:42:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <2025092356-rounding-eligibly-c4b7@gregkh>
 <f5a802a4-ac9b-4b45-8d1c-871e2e06d7ac@suse.com>
 <2025092307-scoop-challenge-4054@gregkh>
 <13ce0ad0-f0d5-4579-9a48-db727baa177f@kernel.org>
 <2025092356-glorious-unbundle-58f6@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2025092356-glorious-unbundle-58f6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 4:37 PM, Greg Kroah-Hartman wrote:
> Yes, you are right, it can be gotten that way.  But I can't wait to see
> how you wrap that C macro in rust :)

We can either create a Rust helper function for it, or just re-implement it; in
the end it boils down to just a container_of() on the parent device.

