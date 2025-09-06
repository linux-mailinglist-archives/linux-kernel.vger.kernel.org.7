Return-Path: <linux-kernel+bounces-804198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B817B46C85
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE921C258C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5276C286D53;
	Sat,  6 Sep 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AMhb5YXh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6724A2D;
	Sat,  6 Sep 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757160934; cv=none; b=MUCOtuAwyeBWtVC74agyqmlxeJGazVGFnYI64cZcNQH4TMSxZOX9XgxDhtUJpKviooDp2z5rWN9HBta25ft2k117nw2nPsfaJgKDICIbmeo8Hgsl0RSnSnngSQ11fyAWCNtvj7HFZsqqEEE25hwh/Zp3vQgAoiokXxjeWRZNCVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757160934; c=relaxed/simple;
	bh=7126ls5/C9A4yJCLNijJws6QxM+hUlyjQzcboTlPrPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejuQk5IGopmLXlMS9Uq5z/JD8Gk63rNA6lHaJCmoqNmAVXib9a4ZXFoGCZiPzN/BGEJnfkRrE+1Oy1Lei0bQBWBwYkYU9nBQ1iN/fpleaqPrW5m78B3cpRWcxz1vKho8hZfterO7GvDSTXdtx++gVm/ctcoDB0vM1UG4AW0bAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AMhb5YXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84751C4CEE7;
	Sat,  6 Sep 2025 12:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757160933;
	bh=7126ls5/C9A4yJCLNijJws6QxM+hUlyjQzcboTlPrPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMhb5YXhnQ9fDFWx1wxQPdPjiFFshVf0Jr7hAnq+U7uebsB4NrPEnl8h2kb9ImMxv
	 3kjs4v0iHhZcO9ByDuqstBClJjC0dOGXkPmzGYJuXp1P7titqqfYHs9YEhTB5rCDBZ
	 IZVx5KVPuFweAyD+xboJltQ+qxO5cHWQeZg6HgL0=
Date: Sat, 6 Sep 2025 14:15:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: zack.rusin@broadcom.com, krzysztof.kozlowski@linaro.org,
	namcao@linutronix.de, yauheni.kaliuta@nokia.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix NPE in ncm_bind error path
Message-ID: <2025090651-unifier-award-3e0a@gregkh>
References: <20250904114854.1913155-1-khtsai@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904114854.1913155-1-khtsai@google.com>

On Thu, Sep 04, 2025 at 07:46:13PM +0800, Kuen-Han Tsai wrote:
> When an ncm_bind/unbind cycle occurs, the ncm->notify_req pointer is
> left pointing to a stale address. If a subsequent call to ncm_bind()
> fails to allocate the endpoints, the function jumps to the unified error
> label. The cleanup code sees the stale ncm->notify_req pointer and calls
> usb_ep_free_request().
> 
> This results in a NPE because it attempts to access the free_request
> function through the endpoint's operations table (ep->ops), which is
> NULL.
> 
> Refactor the error path to use cascading goto labels, ensuring that
> resources are freed in reverse order of allocation. Besides, explicitly
> set pointers to NULL after freeing them.

Why must the pointers be set to NULL?  What is checking and requiring
that?

And this unwinding is tailor-made for the guard() type of logic, why not
convert this code to do that instead, which will fix all of these bugs
automatically, right?

thanks,

greg k-h

