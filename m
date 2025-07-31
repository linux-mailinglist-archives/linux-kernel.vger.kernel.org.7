Return-Path: <linux-kernel+bounces-752247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486DFB172EF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5086202D7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5342D1F45;
	Thu, 31 Jul 2025 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qigsglt1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD128D8DA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971237; cv=none; b=IAdNuscKeTmm9AAPfix61Z/FeB7UjnWkKehYKv1TIvAtsCnMQpoqDYU8jqaH52Jjmt+RcCdqiwamNkOF1L1UVkvmKR0YZ996iQMtikpvHPD8oPTmhp9IMBwMx8Cjutb+yx3vhIQtuX+lOOdQoL96DoFEcNyQygPIQrb2CzJ6CLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971237; c=relaxed/simple;
	bh=xNRrbMuy6e7eZWmJJbcCZi/M94eXw6qYWtknXZKUCjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyiLrkRf8vdagkJlTP+RrHA4kegA5KOF4mu09jqFLi2a6ui0x0d3WX5ZO+IHoImEXgxf6GmjLbN82HgyZa2NLDgClLn5j7sq1L7NgnGIwXPXtA2WPePFIEccJhBjsxRuEIj+2r092Rldq+GzcAThzOtyYM5n/MYl/wyLdbSYBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qigsglt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E695DC4CEF7;
	Thu, 31 Jul 2025 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753971237;
	bh=xNRrbMuy6e7eZWmJJbcCZi/M94eXw6qYWtknXZKUCjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qigsglt1D2dbDtlT/8d0tqu1h8oxdF5kawLmPRsp+IjYMthXVOSvRfNcNWUYTuSIh
	 noV8qWHU733eqBZwBIm4raHEraxCcu9nmeFmCKoLiafC5HpKTJ4q9P1iYi1x78dJzH
	 ggB127yGm0R8xDgVI5jlVpIcmtYRQ8vok2yM3RvYABHyoR6HNHtFedq8t8pSJ/DFRT
	 +Wbs3ID8f9BlBxHF+hiZpjxAkEbnwixbkbWLWzrSH6LmgY38tXFolV4G+YdPXpGznT
	 m4sriaajKjVnQCPlyVt+TMwktATnnP5FaD7UgVDXeFPJD3i6ckKESecObpwVv/3zs5
	 hbEISdmukM9cA==
Date: Thu, 31 Jul 2025 07:13:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ref_tracker: use %p instead of %px in debugfs dentry
 name
Message-ID: <20250731071355.2da07d06@kernel.org>
In-Reply-To: <20250731-reftrack-dbgfs-v1-1-143ee1cfda44@kernel.org>
References: <20250731-reftrack-dbgfs-v1-1-143ee1cfda44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 07:57:05 -0400 Jeff Layton wrote:
> As Kees points out, this is a kernel address leak, and debugging is
> not a sufficiently good reason to expose the real kernel address.
> 
> Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debugfs for a ref_tracker_dir")
> Reported-by: Kees Cook <kees@kernel.org>
> Closes: https://lore.kernel.org/netdev/202507301603.62E553F93@keescook/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I trust that Kees is right here, so let's go ahead and fix this. I gave
> this a quick build and boot this morning and it did the right thing.

Assuming Andrew will take this one since you haven't cced netdev@ ..

