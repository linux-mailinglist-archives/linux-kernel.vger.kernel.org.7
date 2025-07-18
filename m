Return-Path: <linux-kernel+bounces-736307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E766B09B59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2367B9444
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E6520B7FE;
	Fri, 18 Jul 2025 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2aLUpw6L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8546204866;
	Fri, 18 Jul 2025 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820013; cv=none; b=iNNnXfuQGp0K87lEREe2oNNasl0OxnZd4qXKvdi55ZiH2sSccsHbWCrSZR7nO3TCj3ItFm2SIqdtsD7LwHkR7FQ4sHZmj/eyhNFXOtS/TvOe+kuUIrBlM7ZVwIWn5pGO+u70ieTW8BWIT1yBs0ohUdjAE3J1FonwBZueORzuTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820013; c=relaxed/simple;
	bh=EllZm6rgyVKouVRTSLqgvp410qckULx9SyHtV7WMx1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqe4yj7teE6qsxGWtMER+qddNKkFtHhFzRoWFTT+seEOhxl1+ekBrzkdqqSPnfuIyTMyU5bE1Z8zGg9iCBpy6sScdWlGQ4rlknuTVfon6HskizNoCOG7VR2tIvheyXRc6WEEoN+MkV/pkn+BIj+zs8NbcjqYMXb9P7oQY/7yNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2aLUpw6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F71C4CEF5;
	Fri, 18 Jul 2025 06:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752820012;
	bh=EllZm6rgyVKouVRTSLqgvp410qckULx9SyHtV7WMx1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2aLUpw6Lp17wLrpYO7W1I2lEazd23MrPdQ+Dw0TkqlxGnD/xZNnk4STH04QMPpthZ
	 saYgI9QA9G0aSvrsLU0RCR2ATEloccqJNEhpGC7kJ1Db1gV6HJEikjWetPvLu2oAyI
	 sXErx7xdHRQOhb9DR3GnYm/IxrqJidEoczr90tQc=
Date: Fri, 18 Jul 2025 08:26:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	"Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] usb: vhci-hcd: Fix space, brace, alignment and line
 length issues
Message-ID: <2025071837-recoil-fifteen-a977@gregkh>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
 <20250717-vhci-hcd-suspend-fix-v1-2-2b000cd05952@collabora.com>
 <2025071706-overarch-flaky-035b@gregkh>
 <3a1c8ed6-c123-4a11-b2aa-405babfa2948@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1c8ed6-c123-4a11-b2aa-405babfa2948@collabora.com>

On Thu, Jul 17, 2025 at 08:26:54PM +0300, Cristian Ciocaltea wrote:
> On 7/17/25 7:18 PM, Greg Kroah-Hartman wrote:
> > On Thu, Jul 17, 2025 at 06:54:51PM +0300, Cristian Ciocaltea wrote:
> >> Perform a first round of coding style cleanup:
> >>
> >> * Add new lines after several statement blocks
> >> * Avoid line wrapping when 100-column width is not exceeded and it helps
> >>   improve code readability
> >> * Ensure lines do not end with '('
> >> * Drop superfluous spaces or empty lines
> >> * Add spaces where necessary, e.g. around operators
> >> * Add braces for single if-statements when at least one branch of the
> >>   conditional requires them
> >>
> >> This helps getting rid of the following checkpatch complaints:
> >>
> >>   CHECK: Lines should not end with a '('
> >>   CHECK: braces {} should be used on all arms of this statement
> >>   CHECK: Unbalanced braces around else statement
> >>   CHECK: Blank lines aren't necessary before a close brace '}'
> >>   CHECK: Unnecessary parentheses around
> >>   CHECK: Alignment should match open parenthesis
> >>   CHECK: No space is necessary after a cast
> >>   CHECK: spaces preferred around that '-' (ctx:VxV)
> >>   CHECK: spaces preferred around that '+' (ctx:VxV)
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > 
> > Coding style cleanups need to be "one patch per logical change", not
> > "fix them all in one patch!" type of thing.
> > 
> > Sorry, but can you break this out better?
> 
> I could split this into something like:
> 
> - Fix spaces & blank lines
>   CHECK: Blank lines aren't necessary before a close brace '}'
>   CHECK: No space is necessary after a cast
>   CHECK: spaces preferred around that '-' (ctx:VxV)
>   CHECK: spaces preferred around that '+' (ctx:VxV)
> 
> - Fix braces
>   CHECK: braces {} should be used on all arms of this statement
>   CHECK: Unbalanced braces around else statement
> 
> - Fix alignment & line length
>   CHECK: Lines should not end with a '('
>   CHECK: Alignment should match open parenthesis
>   
> - Misc?!
>   CHECK: Unnecessary parentheses around

Why not one per CHECK: type?

