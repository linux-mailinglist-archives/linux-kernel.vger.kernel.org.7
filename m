Return-Path: <linux-kernel+bounces-887965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE2C39765
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7A11A43C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F22E6CC0;
	Thu,  6 Nov 2025 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o017u+az"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBB14F70;
	Thu,  6 Nov 2025 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415492; cv=none; b=nYaq8HT/P6BGinqdWPY+ebkrlFTegOd6nMNuZWuz7yqEw8q4Vg634JV6Uj23FhMJY+j58OlRqS+1oghwpJkcJkOTsjpRnkfpj1G26tm36DEpJhKxxsa3Qp5iR1zEZwdN7St95Yqjh/Gud3UPL11YzzMXfNMEUGILrqjE7qq8ykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415492; c=relaxed/simple;
	bh=rqZkEZn5/jiwO3tbD9RTfheGonmzs7WwxaaW7BtTwps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWu/748OWtUpbD+kXH6j72Gf3CcdWI85AAuj8GXfbXxOAa3sHb79Z1vtGgyF1rX4uQs4q5ffO0bC8O0vLJbAgCRUsMfuVE2q0Ff49l0iUhsie/CGBO/Gxq/LgfE99Sv27S/jwGScNbdxr+vWIC28Q/9v16AH3gdbXSYiDEdqOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o017u+az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F092BC4CEFB;
	Thu,  6 Nov 2025 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762415491;
	bh=rqZkEZn5/jiwO3tbD9RTfheGonmzs7WwxaaW7BtTwps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o017u+azAiJb/EgMQxQQ30bKaSwafwfR3nJf3NpDGY7TWbEufGoF3Q7mcnDX5A1m3
	 bh+xJjf/Ixk2daTAnSuBGROVTc55joEx9STaabe5Y6e0jyJ2E6SSv1uUzyadqmclkr
	 5ozEgIz6iT5Ak0c+6SSuQPo8FolamCW26CJ7swFY=
Date: Thu, 6 Nov 2025 16:51:28 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Clint George <clintbgeorge@gmail.com>
Cc: arnd@arndb.de, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, khalid@kernel.org,
	david.hunter.linux@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hangcheck-timer: use pr_crit and fix coding style
Message-ID: <2025110649-elves-steadying-a4d0@gregkh>
References: <20251105140541.9658-1-clintbgeorge@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105140541.9658-1-clintbgeorge@gmail.com>

On Wed, Nov 05, 2025 at 07:35:41PM +0530, Clint George wrote:
> Fix coding style issues and improve logging in hangcheck-timer such as replace printk(KERN_CRIT ...) to pr_crit(...) where applicable and replace non-standard %Ld with %lld in debug prints and use proper pr_debug/pr_crit for kernel logging.

Please wrap changelog comments at 72 columns.

Also, please split this up into "one patch per logical thing", as you
shouldn't be mixing them into one change.


thanks,

greg k-h

