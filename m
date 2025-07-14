Return-Path: <linux-kernel+bounces-729904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8089B03D52
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA13AF52C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECABE246BAA;
	Mon, 14 Jul 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHtprIo6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD52AE6A;
	Mon, 14 Jul 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492348; cv=none; b=TkD6gMhqJkBBxICbPxDoDzN2zBtDl1smnznrqCdhr7RvL3f6P9dYcyNEQPkg4lAQjlgk0GUPOyExVWBPKCrwUAxmyfEnifvUZ5u6BGFaneK5LbssGQX2wad0PmTsaAfYe852Ww1MbowCdzKrLQeFHJHGOU7n6DPLep0EQEG6OiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492348; c=relaxed/simple;
	bh=d0CF/6aQzH/rQNpNsktTzOYq6IzKLScD2DanqTY49v0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BIZb6ZiF1gDtOx8t3dwAAV8O+RSXRB4saiSCsItb10wTqtSLnQoDWI2uM/rvriT5Sru/2keuUwyFwULgR2g7o+7ixcfQrfTq//26+ssm82XFBD4PcyYCid6FAsc+AXf7iOLBNynbNOf8l2jZjCa9A5L7EL7QYTyTG459vEMHXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHtprIo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2CEC4CEED;
	Mon, 14 Jul 2025 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752492347;
	bh=d0CF/6aQzH/rQNpNsktTzOYq6IzKLScD2DanqTY49v0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=XHtprIo6setBWMmBOgG1J8q9WxeYeHZXYkgYC8HXcILsLc47XoZ5APfE03L/i5Xd6
	 urJmgpMhdIMs/kT8P0nBgeLtb434ABvf9Fg44bu/rqiLB8HWgeD9aCfxb7Wc/HY7ug
	 ytRU+7rILaqp0jQ+lIec6Uih/wV4HIeYXnQHq89nnl7hcv5dwEUHQat91YfBq3pV8L
	 soLlru8qCOxOU9fpC3qDwmRrl1Z0ALvG8ERTl00AETB13pbnJK+0Ilz1uihKVIXJu3
	 taxIqY6Cx0I9f6gTRuFqvCwKfVeXrJVxwSCZQFnXUj98Q5OMC9X2oVKYRz5pwTAwgn
	 7YfMPXhrHOqGg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 13:25:41 +0200
Message-Id: <DBBQORC8GLOW.1NOJ8RVEQ5V7T@kernel.org>
Subject: Re: [PATCH v14 0/3] rust: replace kernel::str::CStr w/
 core::ffi::CStr
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Waiman Long"
 <longman@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <nick.desaulniers+lkml@gmail.com>, "Bill Wendling"
 <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>, "Christian
 Brauner" <brauner@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
To: "Tamir Duberstein" <tamird@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com>
In-Reply-To: <20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com>

On Thu Jul 10, 2025 at 4:53 PM CEST, Tamir Duberstein wrote:
> This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> have omitted Co-authored tags, as the end result is quite different.

For device and firmware,

	Acked-by: Danilo Krummrich <dakr@kernel.org>

