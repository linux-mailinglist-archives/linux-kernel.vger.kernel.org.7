Return-Path: <linux-kernel+bounces-878091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C890C1FC28
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260314266DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7AA3563E9;
	Thu, 30 Oct 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgum3bRr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC15342CBB;
	Thu, 30 Oct 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822728; cv=none; b=YcddRsR5VT+4Bhga1q2Xh+q6c5y+F05XceEBBh9C7qgh/oxH62sXBeKLJKKxxfffvJob7SeAZ94zbyz2kB0U+S103QU6gMaMtibeCIo2169L50ev4BYTkMl+sKevKCNsdIjYwz1jpoX414SqwrvRD3xSmZQwTDSCGtjEcxn+iZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822728; c=relaxed/simple;
	bh=BSolpokxLywxqliZROQ9KV5FG5CYIMSvfXRul5jIyB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjeAQEgMwu9Lo10b6fWXzCrWABe5O9+LHm7Sn8qNkl01jTxc2EjnhjwAmW/Ii4fqNesZ5n7hIb8U3R67g70s51DpkZ9e1IsbaIcp6KceErRZlACfMUJrc6l86RFd+qw0WTddGaaEHHaXWQDwFv8S2BkaBKRtxD7P+LFJU8xBei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgum3bRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCE4C4CEF1;
	Thu, 30 Oct 2025 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761822727;
	bh=BSolpokxLywxqliZROQ9KV5FG5CYIMSvfXRul5jIyB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cgum3bRr+d2xng6DdIy3v1BDtvsKHbN9eWzQehMlNHRh5Hanx0alkIKGGFUgorLx5
	 CYu6xkABWusWSpXrVDHnnCwfHjdvdFg3dfA8FjF/1hXCi+genjkwvTKyn9N93nWS5L
	 gykWg3frvVbxoHyEtjFjFkt83hYxTkSLK9KxwD+0bf6Vx8bc+HbVKkS3dhy937JLMs
	 NeTKH4jKb3i4JmP/yZAfcwNpsWDIMeT/auysqszxvWV0KW9647BfEwXtMWIal6XG/7
	 1RNmyjsr3bW/W/pDd5s74yqz8onJxt2SfSPayoP0ijtWRpU4B2/kLKMcBcuOvlxsFQ
	 6jxtwBOysfXAw==
Message-ID: <06e18028-db5c-4a4e-a96d-29ddc07485ff@kernel.org>
Date: Thu, 30 Oct 2025 12:12:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nova-core: regs: rename .alter() --> .update()
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20251025010815.566909-1-jhubbard@nvidia.com>
 <20251025010815.566909-2-jhubbard@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251025010815.566909-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/25 3:08 AM, John Hubbard wrote:
> This also changes .try_alter() to try_update().
> 
> After this commit, instead of "read, write and alter", the methods
> available for registers are now "read, write and update".
> 
> This reads a lot easier for people who are used to working with
> registers.
> 
> No functional changes are intended.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

