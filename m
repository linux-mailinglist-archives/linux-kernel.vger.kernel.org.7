Return-Path: <linux-kernel+bounces-860472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7ABBF0337
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBCCA4F1481
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E332F5334;
	Mon, 20 Oct 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVyNFMJ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C52A1CF;
	Mon, 20 Oct 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952922; cv=none; b=K/YQbSNk4+q62U1TKIZVGZLv2DmG+5sQ/LdWBhZZzdbHVdwU5NZQrRYwf8j4JzftmrvgItKxBd08wMSWJ3NrZmBxVytiDtwqyO7hmtkDTs6e4mXsiyPsW59VOx2ZOlJ5BcxbOPaYyjn7qKCfWv0h9PSFz5gmB0LzEy4uzAvQffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952922; c=relaxed/simple;
	bh=LLyOa3QLpzxgIqcghaTmISubG8xXzRS6HwwMdELXLXI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=frQosEE5AY9QrGseot+YngiIvCP/9nAs40P6oM+DAwqQyMUdn3CnWs0iU5sECfTARUI12AxJ6YE7K1jRReAoJHa2GOScBbRebHLKO0Ak9hHZyigNkEV0Q0ieiz0DdPan9B/Ex46d/iZIRRy8jReNX4gcjVFoIlnBg1Olx4kvm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVyNFMJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840C3C4CEF9;
	Mon, 20 Oct 2025 09:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760952920;
	bh=LLyOa3QLpzxgIqcghaTmISubG8xXzRS6HwwMdELXLXI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uVyNFMJ+ki3C4druV3ytkAxUwpwNSm9xX7BcInsNMz/I/aE2EslBJY/bVxKOXxder
	 rsRPbUO4LvjVWVaUIl0qsprGRYKrzYXiAOEk3PN3lHRzYg+xx5gJvjaBX+aJ+4u5ds
	 QqqJSSvru+wwx6gqMuUqeQgFvIbk6KRGOToz4p+5wJrWraxAk3QVRNW9K/66o9Wz9T
	 FF0qlOeeYcKvh2j9bpQc23W8QHwuZZQYsYRarwNfdDAKCEXez6lRVFB5Yo/1s2EvEa
	 jURinj8ffPzry7CCIJ7XuHsxM2656OLFbZ8DPhWOD1dsNx3dl5eunlmIBWzs0cY+eC
	 cbJCYH6Pu2guw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 11:35:15 +0200
Message-Id: <DDN1PLK58C34.2XF7BCBQNAW5X@kernel.org>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251003222729.322059-1-dakr@kernel.org>
 <20251003222729.322059-4-dakr@kernel.org> <aPI9tNoh0I3KGDjl@google.com>
 <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org> <aPS0aTUUwDsXmHFN@google.com>
 <DDM9EDPP7XQN.2SW537AZ7DAZ9@kernel.org> <aPXvJPcSgZdNlGtB@google.com>
In-Reply-To: <aPXvJPcSgZdNlGtB@google.com>

On Mon Oct 20, 2025 at 10:13 AM CEST, Alice Ryhl wrote:
> I ended up using i64 for simple_read_from_buffer in iov.rs instead of
> loff_t. But if they can differ, then yeah let's introduce a loff_t type
> alias.

No, I don't think they can differ (I used i64 in earlier version that didn'=
t
make it to the list as well), but I think it could still make sense to indi=
cate
the relationship with loff_t. When I see an i64, an offset into a buffer is=
 not
the first thing that comes to my mind.

What about uaccess::Offset?

