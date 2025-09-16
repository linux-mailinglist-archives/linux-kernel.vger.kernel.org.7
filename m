Return-Path: <linux-kernel+bounces-819128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF70B59BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54D11731EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEBA346A1D;
	Tue, 16 Sep 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jM1KfHys"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8021E098;
	Tue, 16 Sep 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035852; cv=none; b=E7yzuVHkmHUIE/+0Y3JE3GCc9Vr4Ee4KDrrsnY0Icdfe/a4gDBFvloChsqET1pRWvOp2xid7s/dV8NNHfTCeQrm6TkGmD9t0kX6JNo/yoiEGjWeKYrvBHp5LjwAci4eMnWgLVj0HzJtHGnpb+iT+/x1G4MmKyX8fkEedkYMJx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035852; c=relaxed/simple;
	bh=Moovu0u3vriDMSBtuBX4XqVq/8MvxfsXh1P03vaOARA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBInQGNzLOExTyV7cjvnxL/5wf+ZA06IOuWnk6l8lFV8xiNXdELdpVySKVAEj+dTkzeAQI+z38X2X45Jow2E5LIuX4Y1b5COV0oLLzqSxUf/1+1JudN3Op2XwS2CsmK2AJ1cHezp5Eudq8P5zeGJdLESR8Lq9sKT8JGf8OCMrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jM1KfHys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D81C4CEEB;
	Tue, 16 Sep 2025 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758035851;
	bh=Moovu0u3vriDMSBtuBX4XqVq/8MvxfsXh1P03vaOARA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jM1KfHys5YOxfaoW5hS/7PwWRLlkWJ9ERJ8NLzI9vic6Y+pVF6ouI6xDP2PuipV5p
	 c6aefDVDLd2PI9yQDQWty85tjr3FTWVXbCjPflExH7DHDaaYGRdEzoLyxdrgkYZKVi
	 +TAo9HCJB/lhy5mYWehrSqrjZVcd5bz//MRKzzmo=
Date: Tue, 16 Sep 2025 17:17:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tong <djfkvcing117@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	onur-ozkan <work@onurozkan.dev>, lossin@kernel.org,
	gary@garyguo.net, alex.gaynor@gmail.com, david.m.ertman@intel.com,
	bjorn3_gh@protonmail.com, ira.weiny@intel.com, leon@kernel.org,
	dakr@kernel.org, tmgross@umich.edu, ojeda@kernel.org,
	boqun.feng@gmail.com, a.hindborg@kernel.org, aliceryhl@google.com
Subject: Re: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError`
 docs
Message-ID: <2025091644-smog-stamina-5a3a@gregkh>
References: <CAMfjjQ2a2HdFWcUWV10qP0qVmPS5vGiAJTa_7qGjoCTW5+Lm-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMfjjQ2a2HdFWcUWV10qP0qVmPS5vGiAJTa_7qGjoCTW5+Lm-Q@mail.gmail.com>

On Tue, Sep 16, 2025 at 11:07:09PM +0800, Tong wrote:
> rust/fs: use intra-doc link for `EBADF` in `BadFdError` docs
> 
> This patch changes the documentation for `BadFdError` in the `fs`
> module so that the error variant `EBADF` is referenced via an
> intra-doc link (i.e., [`EBADF`]) rather than plain text. This improves
> the generated documentation (so the `EBADF` constant is linked), and
> helps tools like rust-analyzer to resolve the reference from the docs.
> 
> Testing:
> - regenerated documentation, confirmed the link to `EBADF` shows up correctly,
> - ran doctests to ensure no broken links in docs,
> - built affected code with rustfmt / clippy to verify formatting and
> lint cleanliness.
> 
> Suggested-by: Onur Özkan <work@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1186
> Signed-off-by: djfkvcing117@gmail.com
> 
> ---
> 
> >From 87d6b4e61da0db96a018b86baa011b9c6635e665 Mon Sep 17 00:00:00 2001
> From: Webb321 <140618222+Webb321@users.noreply.github.com>
> Date: Tue, 16 Sep 2025 22:58:26 +0800
> Subject: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError` docs
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> In `rust/kernel/fs/file.rs`, replace plain text `EBADF` references in
> the doc comment of `BadFdError` with intra-doc links [`EBADF`].
> This improves the generated documentation (so the `EBADF` constant is
> linked), and helps tools like rust-analyzer to resolve the reference
> from the docs.
> 
> Testing:
> - regenerated documentation, confirmed the link to `EBADF` shows up correctly,
> - ran doctests to ensure no broken links in docs,
> - built affected code with rustfmt / clippy to verify formatting and
> lint cleanliness.
> 
> Suggested-by: Onur Özkan <work@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1186
> 
> Signed-off-by: djfkvcing117@gmail.com
> ---
>  rust/kernel/fs/file.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

You seem to have 2 changelog texts here, how did that happen?

Also, no blank line is needed before your signed-off-by line, AND it
should have your name and email address.

thanks,

greg k-h

