Return-Path: <linux-kernel+bounces-780087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A8EB2FD79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B688D1C20BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20EB2E3363;
	Thu, 21 Aug 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdVvUYzQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E22E092D;
	Thu, 21 Aug 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787682; cv=none; b=tPVjcNgnj0dJek3bPCvkFsLdwpIDm08xRuBDMf3o0n0WSt5NsdLM9iTry9bv6kn4W8DjKWVEngkSTy9YwVdVck7N3MF9NVFoWj+ee1X62zxfsyYInl4zEs74IEfzxid9eZPdEQoTld0KywcBI5QcSFDmE8Aetf/pxBTTU3X7p7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787682; c=relaxed/simple;
	bh=tB7QtdU0NteP+l/nGwCklPPyZMU+e1CWu4so91o586A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=eyXx99VlcpojiFKInqS/H5a3Q1BYqpuO8kR1jfMt0fK/yMUlWH9/ReeMnqb/6znq+wI7G+xxXPuTrDv57U8UBrPxCj/M9RmU7L7rFj3s79R8EWGNf2hT5o1SJ4Q+3v4q9vuLp9kPR2Zi8+rHMj6vVe/BY7Sov3J9FvXXeKUZ9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdVvUYzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4687EC4CEF4;
	Thu, 21 Aug 2025 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755787682;
	bh=tB7QtdU0NteP+l/nGwCklPPyZMU+e1CWu4so91o586A=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=OdVvUYzQRrZEGgK//Y4nFymFQ5F7TCs6nhQ5PooKRMxPVo1OVBB/T4VdpBV660B/1
	 f3Ogx1FjJjXzKwyimeyFSZ58icpJq6pgPtKcZohJtMrHD6YlxdzsT4SZ1GV9gKUvVn
	 pX6IAsWwX9UvkvcrIj04vccU6mLLC1eKZ1mg4eQmz0Aj9qwnkDwIw7wJ35MBWlfgOx
	 5pwcAMJGNcC3w9SiFdUGuMWrNPKnQyJD6mvfiINtleLKVmf6i0JB3auKe+Bu6JiUjz
	 IK4RV9LwTVQE+tG69CLeseSh3OV7o1O2I8kLHXRGtPbezSD9K/ju8W1AucL+tKzBRl
	 jwqIyq51xAobg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Aug 2025 16:47:57 +0200
Message-Id: <DC86SBUYSPYP.IRM1O8GC6CAR@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn
 Roy Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3] rust: alloc: implement Box::pin_slice()
References: <20250811101456.2901694-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250811101456.2901694-1-vitaly.wool@konsulko.se>

On Mon Aug 11, 2025 at 12:14 PM CEST, Vitaly Wool wrote:
> From: Alice Ryhl <aliceryhl@google.com>
>
> Add a new constructor to Box to facilitate Box creation from a pinned
> slice of elements. This allows to efficiently allocate memory for e.g.
> slices of structrures containing spinlocks or mutexes. Such slices may
> be used in kmemcache like or zpool API implementations.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

Applied to alloc-next, thanks!

    [ Add empty lines after struct definitions in the example; end sentence=
s
      with a period. - Danilo ]

