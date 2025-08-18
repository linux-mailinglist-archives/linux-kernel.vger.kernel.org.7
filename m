Return-Path: <linux-kernel+bounces-773814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446BB2AB22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9BA1BA2CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136542343C0;
	Mon, 18 Aug 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AYIyfnZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108F21FF3B;
	Mon, 18 Aug 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526727; cv=none; b=I+01t1cXBHOd8Dj2Dwd9NsVXkOw+Rf8LuQyFPaFxfogfFllr26d+gKDKQq3oMRD9X2Wu3p4HHEjxK9Llq+pJJZgrifjQ/MkCW3PE0i7hn2rhN3ys0D5tFcm6VExiwMs/E1RSdA7P+4+VCgfStukuK2dnL3+vr9nmbU20RbS/9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526727; c=relaxed/simple;
	bh=Ln2PVc1fxRky4q++xSOUzCjoi9Fk15pcsrJAtRwtxDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh1I99sFiQZp+YK/ThYn+BqV9No6uLf6ynngBAcIwmV9khZt1gOqcfUvgQWAwDwc3ymjWPg+Cs5cucHPdcQeSPcCnhA3+/CIolqtMolfhnWD50Gu6Gb/4Sy0moBvnnmiAy4eWuLtCBzgxbCo1+lYh2ir3NTUbktfdENr/Fgj690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AYIyfnZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDF9C4CEEB;
	Mon, 18 Aug 2025 14:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526727;
	bh=Ln2PVc1fxRky4q++xSOUzCjoi9Fk15pcsrJAtRwtxDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYIyfnZV2NSpFdGJrAtxvYNRxh4eXAKRNTBluvSOdR1+LuNUFo1R5mxUW5Z9Cv9fA
	 pcdrLWASUmkCwc4/EMchHjwVWHhOj7YbR34kg/1dY45KgM/Cw7msJ/G5WoNhx6aNgn
	 XfqJcWaOUPEWYrKmySicAwBfeP2ozGPVPCVMy8Y4=
Date: Mon, 18 Aug 2025 16:17:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, lee@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rust-next 1/2] rust: miscdevice: add llseek support
Message-ID: <2025081836-unbraided-justness-4b43@gregkh>
References: <20250818135846.133722-1-ryasuoka@redhat.com>
 <20250818135846.133722-2-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818135846.133722-2-ryasuoka@redhat.com>

On Mon, Aug 18, 2025 at 10:58:38PM +0900, Ryosuke Yasuoka wrote:
> Add the ability to write a file_operations->llseek hook in Rust when
> using the miscdevice abstraction.
> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  rust/kernel/miscdevice.rs | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

What misc device driver needs any real llseek function?  The ones I see
in the tree are only using generic_llseek or noop_llseek.

Do you have a specific misc driver that you want to write in rust that
needs this call?

thanks,

greg k-h

