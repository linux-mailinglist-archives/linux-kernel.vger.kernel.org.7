Return-Path: <linux-kernel+bounces-765095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AE1B22B57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC83D3A914D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B642F4A1A;
	Tue, 12 Aug 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhKaQEwi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B93F9C5;
	Tue, 12 Aug 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010813; cv=none; b=kERgE6OnnVgPM6g6WrJSrSnLQYWumWV0EAWQ/7sSAf/N+oDYR7ccCW6SdE1a5ehnFlYqsmXlGTDT8iqVbLp0XYK2hZx7vih78ABNHztpQsdmgS9mB2wIdf2RA2LHd7L1zJHOeo3hci/2F/OiUAHrBEj5qYKriKUaUg4VvXTCWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010813; c=relaxed/simple;
	bh=H09K59n8L1ZRoaDl9HxOZMCF4c9fmpYFFOM0IwKG+Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYU1YG2SrVDfMyXgS1H+NB/rUnZ1+s1lvLpy2BM1tsMMV4O36QP3OYsncRyMHubEM4X1pf8ktKivQFQZec2YAHT4p0rI0ZfGrnyRnzMcSPsL6j/A4xWfyd6IWGX1CcQQCk567KC5hZlVFuD/KPA6V7px7rl0YKNSg+ZUKFuc6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhKaQEwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F331C4CEF0;
	Tue, 12 Aug 2025 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755010813;
	bh=H09K59n8L1ZRoaDl9HxOZMCF4c9fmpYFFOM0IwKG+Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhKaQEwiBMDGS10smyFpvZJbrM9yF/HpXpR2/ZkrzwtGIJ/qdf+O31oaQheWY3Gin
	 Fc2EX9DuMDQu2BB/5d+hfT61+zj+W6kGywZignoM5MgFTz4FdBxNvUHcDOhjGBclWH
	 olsdy4vE6yFUSyyL0hejXatQBvClhzPYzGZXmCJg=
Date: Tue, 12 Aug 2025 17:00:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: realtek_cr: Simplify
 rts51x_bulk_transport()
Message-ID: <2025081249-guru-uptight-98bf@gregkh>
References: <20250812144358.122154-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812144358.122154-1-thorsten.blum@linux.dev>

On Tue, Aug 12, 2025 at 04:43:58PM +0200, Thorsten Blum wrote:
> Change the function parameter 'buf_len' from 'int' to 'unsigned int' and
> only update the local variable 'residue' if needed.

But why?

> Update the rts51x_read_status() function signature accordingly.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/usb/storage/realtek_cr.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Have you tested this change?  What caused this to be needed?

thanks,

greg k-h

