Return-Path: <linux-kernel+bounces-746638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEDFB12940
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 08:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102AF58138F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4824C207669;
	Sat, 26 Jul 2025 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yQGY0M+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B6202F87;
	Sat, 26 Jul 2025 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753511994; cv=none; b=ibPi+21sFpV8M92SDEfZ+D+l1NwOQj4i0wgF4BcXBcpbR5LmOY4fJZaRAKfnJoI7yG6M2RZ3KgPGQ0xDtlGF+Wr0oizJUAiC8CIsFcXtxcwctAjlkThucRP0ifN4j9hfMuHZ2mAybUVM35Joha6dyDBlvi2iojzL4bBfWuh9k0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753511994; c=relaxed/simple;
	bh=X14GJbue3JTd6xDO7+C47pi90kQh5Op1cdhyUhrppJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/8MMf8tesVC5AwVYiD3xfvJObPU4hu8eVyiz8Rrjp12fClRshtcNxOlkaB6Kxot7lkce9ZziWy2znR2gVIAZXxVvDL3UJ7UIkHC+R0ynEMZmlB9mTdOtAJMnKopNCWCnz7a+cif4G0WtAshqV5Ylwwysrz1LXguihSw2a80ltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yQGY0M+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB89AC4CEF4;
	Sat, 26 Jul 2025 06:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753511994;
	bh=X14GJbue3JTd6xDO7+C47pi90kQh5Op1cdhyUhrppJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yQGY0M+MrnP1xsP4BsBX9p4T7MMJAEBSunswoE4lCfKJHzwNuAP2KHU921RETnX0O
	 Qa3rUltMr0zQjn/4I5EZWmQkNP2ndc3t0RfRM11hALcquu3SJZwq5s7pc0hw26fwWT
	 E6gsbJXD1FJat4qvmuP8BCXR6hrpuS04owsvkl74=
Date: Sat, 26 Jul 2025 08:39:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Olivier Tuchon <tcn@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: Address review comments and include
 missing files
Message-ID: <2025072652-chewable-stupor-9a4d@gregkh>
References: <CALU+5Vb8kFrR_HMOrBDktxEEQE4d4qBTijVpSdSQz4d3qXsfJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALU+5Vb8kFrR_HMOrBDktxEEQE4d4qBTijVpSdSQz4d3qXsfJQ@mail.gmail.com>

On Fri, Jul 25, 2025 at 11:09:26PM +0200, Olivier Tuchon wrote:
> This patch addresses feedback on v1 from greg k-h and Alan Stern. It
> also includes files that were missing from the initial submission.
> 
> The following changes have been made:
>   - correct initial coding style issue (spaces for tabs)
>   - add missing file required for the feature to build and run
>   - improve FIFO full handling by truncating event data instead of
>     dropping the event entirely
>   - avoid capturing redundant data for IN submissions

This is not a proper way to write a subject line or comments at all.

Look at patches on the list and in the tree, nothing starts with
"address review comments", right?

Please go back and start again...


> 
> Signed-off-by: Olivier Tuchon <tcn@google.com>
> ---
>  drivers/usb/Kconfig                     |  2 +
>  drivers/usb/Makefile                    |  1 +
>  drivers/usb/gadget/udc/core.c           | 78 +++++++++++++++++++++++++
>  drivers/usb/gadget_mon/Kconfig          | 20 +++----
>  drivers/usb/gadget_mon/gadgetmon_main.c | 41 ++++++++-----
>  include/linux/usb/gadget.h              | 23 ++++++++
>  6 files changed, 141 insertions(+), 24 deletions(-)

Please read the in-kernel documentation about how to submit a kernel
patch, it should explain all of this, right?  If not, please work with
someone in your group that knows how to create kernel patches, don't
require the community to do that kind of basic review/training for you.

thanks,

greg k-h

