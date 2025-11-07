Return-Path: <linux-kernel+bounces-891081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F15C41C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A110A1899C08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BC30FF03;
	Fri,  7 Nov 2025 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKBU1jFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4E23507E;
	Fri,  7 Nov 2025 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552766; cv=none; b=Wrbuy9DV73HjW3BjKeF1mB3ETjDhhgXi4T9XPHQ8kV6LGEpwsXZMRpigGRTK7VB92cHKGyXEZMWxnFlxp0IK35ea2qit8OwsAspc0PVaiULJvI6GZdF4+/qz58uLePbwmUjJbm35bDZ6v8MyMT64htFpavOh9JvSpy4cOYAwhT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552766; c=relaxed/simple;
	bh=dOZeiGdFdu6aBHSajmK3uZUVzYuU1sCAeoyGnDzNcAw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YSMJ/0fs7VIkQ0d/rhSBejyoQ6cN/KIq5r+XNd5ME2KC6Viz5C3qZvFWgaTbOXhfAAR6aJ1zfZ9P0slwVzHp4GR0wPxVovFv9Ydgi8OQ+WmKhdiHjJN/WfWbKRXxWHdnFWNARlxJnsso7TASMoJgeh3QWbcBoWC5Q1V4GHAPpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKBU1jFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE42EC113D0;
	Fri,  7 Nov 2025 21:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762552765;
	bh=dOZeiGdFdu6aBHSajmK3uZUVzYuU1sCAeoyGnDzNcAw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=UKBU1jFEA9xiFIh9W7aLUXAlrMThrRyKjeNf88YS6uoowlVphgND7gf3s3ErXNFo2
	 2Tx+b7MkCDqTGSb63ulCTE2HxfYm/QM8qiFrfd3vNZgVxxlAAcZyVW3I+cSdnBTnLZ
	 0QX+C45azd1dIbJn1TO284l9UcBv0Nj+kuIMH6YvqyQFKlSOjGgd4yzM1RbhbobBiH
	 P5mQbA5h2mtmFPpdedJ93m1We+qtgvR9D5Vqo71TibNEfaQOMj7/kL16pVi4+pH0L+
	 7uE30ZcmxQubiirhA/AkaLfdkSfsP76DiXWK9vgikANYX3rGfGnalvnq/vcivVstax
	 5LR+LMo2D3SzA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Nov 2025 22:59:18 +0100
Message-Id: <DE2ST39SK8NS.3EPFHATBG0X7K@kernel.org>
Subject: Re: [PATCH] rust: debugfs: Implement BinaryReader for Mutex<T> only
 when T is Unpin
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Stephen Rothwell"
 <sfr@canb.auug.org.au>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251107091612.2557480-1-dakr@kernel.org>
In-Reply-To: <20251107091612.2557480-1-dakr@kernel.org>

On Fri Nov 7, 2025 at 10:16 AM CET, Danilo Krummrich wrote:
> Commit da123f0ee40f ("rust: lock: guard: Add T: Unpin bound to
> DerefMut") from tip/master adds an Unpin bound to T for Mutex<T>, hence
> also restrict the implementation of BinaryReader for Mutex<T>
> accordingly.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20251107134144.117905bd@canb.auug.org=
.au/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-next, thanks!

