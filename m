Return-Path: <linux-kernel+bounces-872434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CAFC11327
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8A185465BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA532779A;
	Mon, 27 Oct 2025 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw6IvwQz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B16320A02;
	Mon, 27 Oct 2025 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593292; cv=none; b=FwcHmv+use/H/Mg0a/Iq4qkmWhEDEhVQE2nXtNv59g0mMPW4GHmbVAKuvGHxm2oKg5V5GYJpeutYFGgta3YDNVK4dFEiwUoKhNxge6PNcF7krXKgBP4syzI6XNA9wR6iu5MTNr6pgZldetTRCemMqSg5v6U0VxGY4iXmBK9InfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593292; c=relaxed/simple;
	bh=mEn8TJATXk1tz9tGLRPYHPHeXgwksh2Kb5KZxPPolWk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MaTfoEqhzEDpj3DQPb1lWMVujjI03qVlDYcA86RPdU4C+G7tYkqKRVx3izcQwwn1w2vwVarTQvRPmNh+JznGL883TK0mBjVZ+/Su/mZgXoLNKi3Npn2ZkqEf+hQxWF/Sa/hVqvfNzOwzcHa6YpdXy7efVsdFExsRDXSEpwTah+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw6IvwQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC92DC4CEF1;
	Mon, 27 Oct 2025 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593291;
	bh=mEn8TJATXk1tz9tGLRPYHPHeXgwksh2Kb5KZxPPolWk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=tw6IvwQzmD6dYwYnVSFb/aYd1E87zUZ5c1HSqHGuVhjyX94xKCZ4BeLSAXYr7SZW9
	 zc9gJur4jQ46Dy9Ml1fHpklJ6vjZNSBG1wziev3FvZPUACkLcHgsuDDnrDrQfiEF7G
	 9CI7y6R2YryeCqsvaFCJOmUTn0qnoXQNshG47ilhWRd9bXV7Qm0gBwnf8ZEODH0wp6
	 HDm8hjNoSEKY9O9GkHfbBq7q7qOS4UZbF1prymxsTsEvDeo6Y3677FYVSOwRPw+rIN
	 RKtTon5ikS7MfjgKfP8Gq9RW3gbzZVYseq8rbIYnxaBFUo9uLxl8djumfmseBXXmNW
	 Lw+Ubom2a0vug==
Message-ID: <4ec735c2-d0cc-43ad-8184-b30359c8d570@kernel.org>
Date: Mon, 27 Oct 2025 20:28:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] gpu: nova-core: add extra integer conversion
 functions and traits
From: Danilo Krummrich <dakr@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl
 <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20251027-nova-as-v2-0-a26bd1d067a4@nvidia.com>
 <20251027-nova-as-v2-5-a26bd1d067a4@nvidia.com>
 <c94dd17e-0e81-47cc-9482-e8743d3bc68f@nvidia.com>
 <10945c03-8642-4c19-b0ed-ffb20c075291@kernel.org>
Content-Language: en-US
In-Reply-To: <10945c03-8642-4c19-b0ed-ffb20c075291@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 8:23 PM, Danilo Krummrich wrote:
> On 10/27/25 8:09 PM, Joel Fernandes wrote:
>> Why not just implement `From` and `Into` for the types missing it then, with
>> adequate comments about why such conversions are Ok for the kernel, instead of
>> introducing a new trait? This is exactly what `From`/`Into` is for right?
> 
> https://doc.rust-lang.org/reference/items/implementations.html#r-items.impl.trait.orphan-rule.intro

(Sorry, I didn't mean to send the link without additional comment.)

We can't do this due to the orphan rule, but even if we could I think a separate
trait indicating the reason for the conversions to be valid is a good thing.

- Danilo

