Return-Path: <linux-kernel+bounces-727443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE33B01A45
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670DD1CA5CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2051DED5B;
	Fri, 11 Jul 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xp24FRau"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B260287267;
	Fri, 11 Jul 2025 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231889; cv=none; b=mBRIWP9E38pQX/8wiuTwrmt0Hn37ASRl7dKxjm/jjZ7HewKf2nzGMCO0e9LfEXUxpmMAs+37xVPAQPXJ10fFTZurfzP2hOs7G6SVrPYRt6KYNUQBbs05FabejkN837yeH8LjoOJXokKSjcjquFRXXUqZBGOOYZXpyprfoT7zfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231889; c=relaxed/simple;
	bh=NtHeuCKGiSTnbgzikZeY9tkyb9JY8Bqf8SvYvXjjkww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmZ/BQ+MkyGTN+h4cos1mOanXWrUBzM4nuejYQz29O3O81X75o2TRwhkust61r5SoFjrTNb95tx9mtNzHeoiX5nOnhJfjfeMQ6bdeQowYzO29h0uwMn8tZ5Z3m4Xmn7DjT8yznCkJ2LhHs5wWn9XkrK8bC3IY8urM0NS6Z2qFZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xp24FRau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25749C4CEED;
	Fri, 11 Jul 2025 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752231888;
	bh=NtHeuCKGiSTnbgzikZeY9tkyb9JY8Bqf8SvYvXjjkww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xp24FRaunrOfNSnomWC/jWqU0k4qntV7fUjMaxtsNtOoA7MmXhi71T7v00LtaATzL
	 dVaIRTw6I/MERQz5J/c27wXDYv00Q8O3EePKnhlcWWjojMtFFMfRSiY0SgZMQrwg3O
	 WiB0DH9Z3YEQRnvuGgDYe5Ye1exE2++jgCFSusTQ=
Date: Fri, 11 Jul 2025 13:04:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: oushixiong1025@163.com
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH] usb: gadget: uvc: destroy worker when function is unbound
Message-ID: <2025071112-angriness-cornflake-e751@gregkh>
References: <20250711083550.425714-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711083550.425714-1-oushixiong1025@163.com>

On Fri, Jul 11, 2025 at 04:35:50PM +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> Destroy worker when function is unbound.

This says what you did, but not why.

Why is this needed?  What happens without this change applied?

> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

What commit id does this fix?

thanks,

greg k-h

