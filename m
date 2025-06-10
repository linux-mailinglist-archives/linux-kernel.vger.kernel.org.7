Return-Path: <linux-kernel+bounces-679638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27861AD398E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 15:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67A11635B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AABA25B30D;
	Tue, 10 Jun 2025 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aKKh7GD6"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA212CDAE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562682; cv=none; b=Ziy5NRmXz+k7ccBddUf+2aaZhFsPHwHe06cpJd8b46c+W7ySxHhjfVAc/GFJo3aXzTDgpfWj6acVURWvp+N72Zph60xIuPEqMlk40N8YNHRuZ209Yx+Olh/xIWfwKlHUCgPOElqRbf88TPasq7ruOFFFHbjVSofSLbYuZMre/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562682; c=relaxed/simple;
	bh=AhPf0HPlWCa0aJD35+a4IfqIt8OKABnu+k8qfBCHN9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjSJ8cqGMUEuIX6CZ02ZpFi5zhlGG10nfRO2YigvqnjbGujIgzRWo/+NAUuE2Zr16wz7F6N0wdDW6lL6tL1Y4UjUwT55BqRnsk/W+a//O41qnb7iZgO8w1VcjbBHxqD+VAQWyeJNdZ2lmnMGn4h3KObabmUsQ3q2bysal/CqjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aKKh7GD6; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Jun 2025 09:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749562667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kbrE13Z6Z8RsWUrcqg26zEiS4673dzviRDejxhOoIyU=;
	b=aKKh7GD65rmNR9h/MOTdkZQ8+wMS0zf742dSYvcPsjvZDGFCIGIcuMQbgNV7uQT3QZAyO6
	wgOtaYX9dBCZdCIz2WyFuM2Cf+YAU7WUmWhq02opYls3gni2zvKAWjr2HBAdt2DAyfu/s7
	3zm+jMepc3qgZqrOdJT2wAJU7ztwLPI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Thomas Bertschinger <tahbertschinger@gmail.com>, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] bcachefs: ioctl: avoid stack overflow warning
Message-ID: <okwdyhfmx6qocem3ckgvt3jhdglyjav7tdrjzgquugj3kkolvn@ontqnranltb6>
References: <20250610092413.2640349-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610092413.2640349-1-arnd@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 10, 2025 at 11:24:04AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Multiple ioctl handlers individually use a lot of stack space, and clang chooses
> to inline them into the bch2_fs_ioctl() function, blowing through the warning
> limit:
> 
> fs/bcachefs/chardev.c:655:6: error: stack frame size (1032) exceeds limit (1024) in 'bch2_fs_ioctl' [-Werror,-Wframe-larger-than]
>   655 | long bch2_fs_ioctl(struct bch_fs *c, unsigned cmd, void __user *arg)
> 
> By marking the largest two of them as noinline_for_stack, no indidual code path
> ends up using this much, which avoids the warning and reduces the possible
> total stack usage in the ioctl handler.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks

> ---
>  fs/bcachefs/chardev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
> index 2d38466eddfd..fde3c2380e28 100644
> --- a/fs/bcachefs/chardev.c
> +++ b/fs/bcachefs/chardev.c
> @@ -399,7 +399,7 @@ static long bch2_ioctl_data(struct bch_fs *c,
>  	return ret;
>  }
>  
> -static long bch2_ioctl_fs_usage(struct bch_fs *c,
> +static noinline_for_stack long bch2_ioctl_fs_usage(struct bch_fs *c,
>  				struct bch_ioctl_fs_usage __user *user_arg)
>  {
>  	struct bch_ioctl_fs_usage arg = {};
> @@ -469,7 +469,7 @@ static long bch2_ioctl_query_accounting(struct bch_fs *c,
>  }
>  
>  /* obsolete, didn't allow for new data types: */
> -static long bch2_ioctl_dev_usage(struct bch_fs *c,
> +static noinline_for_stack long bch2_ioctl_dev_usage(struct bch_fs *c,
>  				 struct bch_ioctl_dev_usage __user *user_arg)
>  {
>  	struct bch_ioctl_dev_usage arg;
> -- 
> 2.39.5
> 

