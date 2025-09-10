Return-Path: <linux-kernel+bounces-810901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE31B52148
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7102E1C86060
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E999A2D9ECF;
	Wed, 10 Sep 2025 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLZv5DNq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F02D8DDD;
	Wed, 10 Sep 2025 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533346; cv=none; b=N1rV8fBRegFGdzVYK0Fmos+vwFmiTdyvXqzA8JXPOjDmp9Z4TFMT7iBy1jH5yTERvYVKc+QzFSheVt6YWCiGnb4/J371yXFu448JsXdzsYWtOH6vyS71nZ8rpvVriDOFQIeHOU10QL2TshPSvpVa8+Uqfqr1RKdG27QM1r7Rq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533346; c=relaxed/simple;
	bh=dRSuphexGhPsRU7Dsn/n61L4Dsi2hwhLEGy7lYMVtG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noZdcgU9468AeQs6xBzk2TzqJ2f9T/24VMZlnQozoAxNUEPoGqlCQlakiXrRb6QQMxhpcnfBhtUIV8jixD9thy+/MJv7HDtXxxyMpxnf+K7weEcqOy+EEpiku9/WMDnVWukbNrHb4PHDxhmOJq6N0xdrA7cxOwgg22jLfmlgkJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLZv5DNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAA7C4CEEB;
	Wed, 10 Sep 2025 19:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757533346;
	bh=dRSuphexGhPsRU7Dsn/n61L4Dsi2hwhLEGy7lYMVtG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PLZv5DNqG/EVOZVzePsr+alycpjeNDf2sOh18exOkUZDYneA8xBnEUg4cdnTtR95V
	 E7B8pstiJGI9CAdnQdExpqwlelObISwVpcU9Wg/B3RgEPDpisSbcyvAQY/0fby3/8r
	 MyJbK7BhTDJXFqXap1cdUilTyVx9huYkVt+pGE2rmL+eiHkZFNpJE5bTsgVW0DW7/w
	 F+bzgg9sIaKkccOSdbLSu2X+EKaalBL2k2juEBVx7XqkvWyjgJJz+elmO5619/YmDJ
	 vlF6epRC+hhQ3pTqnzEcAlfiNkoiRiftv27EV+O+Nbr1qSoOehT9TGXg4x+IiYgcA+
	 YfGOApCsnZSiQ==
Message-ID: <0d8b8918-fe90-4eca-989a-d24cf95c1dd5@kernel.org>
Date: Wed, 10 Sep 2025 21:42:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Vitaly Wool <vitaly.wool@konsulko.se>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com>
 <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
 <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com>
 <3f8de021-8eb3-4a7c-9adb-8244c5aa250a@nvidia.com>
 <CANiq72=ex8zJx+KZTV5eRoqkYE=PUkbG5TTvOJo5cXTtd7b1Fg@mail.gmail.com>
 <e49f9e6c-69ee-4ec1-bcc8-3a60fda9a7be@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <e49f9e6c-69ee-4ec1-bcc8-3a60fda9a7be@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 9:40 PM, John Hubbard wrote:
> It leaves unanswered, the question of whether (and how) to use something
> like the &raw feature, which requires Rust 1.82.0, given that the
> stated min Rust version is 1.78.

The trick is that we have the option to enable unstable features that (in the
exact same way) have been stabilized in recent versions, without facing any
downsides.

