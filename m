Return-Path: <linux-kernel+bounces-819041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA8B59A81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EA83AF74C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875D532F77B;
	Tue, 16 Sep 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b8PlSm4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23B2F7478;
	Tue, 16 Sep 2025 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033428; cv=none; b=vAoJQ5K5nDyDL1b77lYpiudkp9WuzBKkQMnVwx63/QMsH845sVKinTF9UghQO6dM2kUq4n/TwuINABTzFcCgb5LIOFuEvu/w9Io7O/1F3pvZi0ohkf9ITZM/+LeVcPREWNVfsU6c6izeot7kR0YA4CzOijwmmmZiqgt0Zq96O5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033428; c=relaxed/simple;
	bh=7LINDBOZI291FwO5m/jlDbTyOobdTooAk6wQ4AMZvVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rADnvC6bhliUACuFqlpkTNEPFNeQiTlIhJ2KOZAr2shnYD1ZzYVI+eJm/JSQhuVuJH69TI9W0xAejoUoUREAKnHuMJX++bnLX/LEvfKTJ3rt7PnaDKF5drse62Jo7AtDBZqZvheJTS2lL9HkLn+LM//k+CVaGGnnkfTEte1p7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b8PlSm4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A999FC4CEEB;
	Tue, 16 Sep 2025 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758033428;
	bh=7LINDBOZI291FwO5m/jlDbTyOobdTooAk6wQ4AMZvVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8PlSm4C6d1SGdyzZDhDKIprTpudZ9DnrwNStyNVUwt6AKSsf6optDeNqbsFP2dDR
	 j98yYi1ZU4S0mQQwUqVkIl9lrLtl847Ozn5ORYcUkCk8tgnOFUsAFHV6aUavmncOSt
	 dJcZMWVyK2vkj7JyKzLH+rxDwtPbhIW0BGeS8DmQ=
Date: Tue, 16 Sep 2025 16:37:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tong <djfkvcing117@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	onur-ozkan <work@onurozkan.dev>, ojeda@kernel.org,
	alex.gaynor@gmail.com, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org
Subject: Re: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError`
 docs
Message-ID: <2025091648-scallop-projector-c470@gregkh>
References: <CAMfjjQ18NYsQh7CVzRs=+sYwve4T5y-vf=zMNLyxQvgYE4+mMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMfjjQ18NYsQh7CVzRs=+sYwve4T5y-vf=zMNLyxQvgYE4+mMA@mail.gmail.com>

On Tue, Sep 16, 2025 at 10:25:41PM +0800, Tong wrote:
> rust/fs: use intra-doc link for `EBADF` in `BadFdError` docs
> 
> This patch changes the documentation for `BadFdError` in the `fs` module so
> that the error variant `EBADF` is referenced via an intra-doc link (i.e.,
> [`EBADF`]) rather than plain text. This improves the generated
> documentation (so the `EBADF` constant is linked), and helps tools like
> rust-analyzer to resolve the reference from the docs.
> 
> Testing:
> - regenerated documentation, confirmed the link to `EBADF` shows up
> correctly,
> - ran doctests to ensure no broken links in docs,
> - built affected code with rustfmt / clippy to verify formatting and lint
> cleanliness.
> 
> Suggested-by: https://github.com/onur-ozkan
> Link: https://github.com/Rust-for-Linux/linux/issues/1186
> Signed-off-by: Your Name <your.email@example.com>

Note, we need a "real name" here :)

thanks,

greg k-h

