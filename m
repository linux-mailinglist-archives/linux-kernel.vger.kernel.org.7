Return-Path: <linux-kernel+bounces-878543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA796C20F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1911888066
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6E53644A8;
	Thu, 30 Oct 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vxts/fQZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B71990A7;
	Thu, 30 Oct 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838417; cv=none; b=K2vd/kCcxkPAdKMGXtIFtjcf+qotyeNOFPzWNi6AwasMvBKX//+eXEDQyhhO2mzjMI2VqwIVTE+3CPVgvSQ4CSLTA9sicHB/EDp9xR5AEK563FgwxIRoD90p6HmgAS21ZBnEuACQks76E9biSp4lzHOdG5isTseeqQ3mndl0CKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838417; c=relaxed/simple;
	bh=yVmx64HxX9GoeUiK3VwYFbYD1eZhphaMlhQqO1pIxo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7l2E0iDSNnuG2fOInF/TxulHo8p0Yn4wYFV3dDp+av+tN7aVsogJP+DpVwSa7ZCoPmaKjsCICmroLfSJycWBGuMN2+64rfwkv22ixJ8jp+6pk/40YYY1RLMLwcGJLZw5HT7wtSvC4mgdRRUxpRL0sRJWpsSEyZaOyZWTYh71oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vxts/fQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B341C4CEF1;
	Thu, 30 Oct 2025 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761838416;
	bh=yVmx64HxX9GoeUiK3VwYFbYD1eZhphaMlhQqO1pIxo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vxts/fQZyEIuU+lhUU90wioM/NMijSFswy0qskCM/9RCaL7WTpnjn44TzUWyVhqjp
	 rkscBWjcLpOb9ooGIHRSOs/i3qxljOWdmmsbsuXf8aGJdCo0LFch4BLZVBgNaRAafy
	 M7x8SlMedtG46ZNvS2MYNSXddc8KkxGDlf9k4+fQ=
Date: Thu, 30 Oct 2025 16:33:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: f_tcm: Use auto-cleanup for usb_request
Message-ID: <2025103010-awkward-gentleman-150d@gregkh>
References: <20251030-auto-cleanup-v1-0-db30584fadfd@google.com>
 <20251030-auto-cleanup-v1-1-db30584fadfd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-auto-cleanup-v1-1-db30584fadfd@google.com>

On Thu, Oct 30, 2025 at 11:14:19PM +0800, Kuen-Han Tsai wrote:
> Refactor f_tcm.c to use auto-cleanup mechanism for usb_request
> allocations in bot_prepare_reqs(), uasp_alloc_stream_res(), and
> uasp_alloc_cmd().

Using guards are great for new code, or for bug fixes, but please don't
just refactor code to use them for the sake of using them.  It makes it
hard to review and justify the churn, especially when there is almost no
code savings here at all.

> The explicit nullification of fu->..._req and stream->..._req pointers
> on error is no longer needed. This is safe because these pointers are
> only updated after all allocations within the function have succeeded.
> If an error occurs, the fu structure members retain their previous
> value, and the existing cleanup functions like bot_cleanup_old_alt() and
> uasp_cleanup_old_alt() already handle stale pointers in the fu
> structure.

This seems to imply this is really fragile, and tricky, and maybe not
worth it?

The comment you added kind of enforces that feeling:

> +	fu->bot_req_in = no_free_ptr(bot_req_in);
> +	fu->bot_req_out = no_free_ptr(bot_req_out);
> +
> +	/* This line is placed here because free_usb_request also frees its
> +	 * buffer, which in this case points to the static fu->bot_status.csw.
> +	 */

Which is "this line"?

> +	status_req->buf = &fu->bot_status.csw;

This one?

> +	status_req->length = US_BULK_CS_WRAP_LEN;

Or that one?

Using guards for buffers for other structures is rough, as you have seen
here, I don't really see the benefit at all, do you?

thanks,

greg k-h

