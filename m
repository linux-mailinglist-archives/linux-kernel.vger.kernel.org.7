Return-Path: <linux-kernel+bounces-819426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF7B5A081
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2405432370C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A932F5A24;
	Tue, 16 Sep 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FJtD0DTL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F562DC32E;
	Tue, 16 Sep 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047413; cv=none; b=bd7wlqLiM+byd4iXuNE64hW4WZOILgZFTrJJPSj7nlGm69x+CKUMOPpNohun1N1C+0r7X5XgQpSUii2b6YPzjueUixbyOcRkMfXhPgL6qGdTEq8jXSHMPFn1e6o84SsbGHDRX9lJ+PVzrqmaKgPQUb7Ea14WZD7WL6C2GI8jnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047413; c=relaxed/simple;
	bh=+0lyfz66rfu/2A/99APbaLCKFW0eRmn2nxRS53Y7YM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcIWNgaKnJVaFsxvSifqvFn6Sjr+5AXfHkhDKd3UGg+XF2atZpbvBd8yXk8r2RtbW6p9EYpcDDx29m4oNc90tcG6XqqrLAd6iY5vC50MNQSAk53ZXwKA2yx97iLx6Ijtk9ZvbiEOyWM+DdN1vV9PVNoWkq0N9RDWV8xmXxcGZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FJtD0DTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E10CC4CEF0;
	Tue, 16 Sep 2025 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758047413;
	bh=+0lyfz66rfu/2A/99APbaLCKFW0eRmn2nxRS53Y7YM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJtD0DTLElbsDDs9GpB0BjQVcR0U3mPAntWghewL3od2KlqSl+K5L1Dw8B7dxZhfi
	 V5CzDHkh9TS1KbL2ka3t66sAndIptQ21RxKV+bUT3O/2k7P7rH1oNjGLwzIUq6U2R5
	 KbAxEXRGuB5WHlXLq1rU9He683ARtGGRKfLY5o6I=
Date: Tue, 16 Sep 2025 20:30:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tong <djfkvcing117@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	onur-ozkan <work@onurozkan.dev>
Subject: Re: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError`
 docs
Message-ID: <2025091624-mud-scotch-4c1a@gregkh>
References: <CAMfjjQ1Gtjg4iG8L6Xdm1HP6FmoVgDHC6QhtMEGbA6_y-_6SXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMfjjQ1Gtjg4iG8L6Xdm1HP6FmoVgDHC6QhtMEGbA6_y-_6SXA@mail.gmail.com>

On Wed, Sep 17, 2025 at 01:13:38AM +0800, Tong wrote:
> >From af7f05e99ed67f57c83e51ca3a1b3010e3e87762 Mon Sep 17 00:00:00 2001
> From: tong <djfkvcing117@gmail.com>
> Date: Wed, 17 Sep 2025 00:25:44 +0800
> Subject: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError` docs
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

Perhaps try using git send-email?  That way this will not show up in the
body of the message.

> In rust/kernel/fs/file.rs, replace plain-text `EBADF` in the doc
> comment for BadFdError with an intra-doc link [`EBADF`].
> 
> This improves the generated documentation (so the `EBADF` constant is
> linked), and helps tools such as rust-analyzer to resolve such
> references from the docs.
> 
> Suggested-by: Onur Özkan <work@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1186
> Signed-off-by: tong <djfkvcing117@gmail.com>

We need a full name please.

thanks,

greg k-h

