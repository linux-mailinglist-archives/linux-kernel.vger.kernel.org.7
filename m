Return-Path: <linux-kernel+bounces-745856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C30B11FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3504316F94E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2F1C8FBA;
	Fri, 25 Jul 2025 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GJLnW1G+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71052E36EC;
	Fri, 25 Jul 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451915; cv=none; b=YVY5lOmveEXXiPyZ+t2Xsa+QjJsZXt5rDVrukId8X/5FeMXS2C2yBs+HoKfW2jz2N9emffaAMCJ6H2i6IBg2xgGCHFuDqSI/beoXooLfDlnlb5OxumEUpYkV7BDI+751vgqTwTLiw5i3APmnItTJikbRiFxjhAQtyCrzHJlr8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451915; c=relaxed/simple;
	bh=WAmlAki6gh5YfjkDSiDmjXgGfoEzhH2hzgXc9JJIQOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2Fo2+O1rLXqbjFzOQK53elplFY9Y7e5DC16AMyyV7KbSZdcU7Sbi+cjmvTzC8pXgwTxi++WDRvPJloljFz1UNF8EdedriHsI9NAsZd0ZO1YdwIJ2HiGgnKG5aJqQHfbekB4K0dEQWO1Nz7ocBGVUgg61SQFze1TYi9iUU8ADNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GJLnW1G+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730EAC4CEEB;
	Fri, 25 Jul 2025 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753451914;
	bh=WAmlAki6gh5YfjkDSiDmjXgGfoEzhH2hzgXc9JJIQOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJLnW1G+c0cny8HoHKeYVTCogD4GbIy9jlhktDby4jvP4JuWe7wKjDxpgBSlz4ogd
	 0ddvENxQINP/a79QcY6PVbXvXR5pNw9AyEtLt0LMpNWHhvyPZp5ljq9RKNrcZuW0/v
	 Seq+aZEgd35xnmOyfhTi3OfSRRn8RUPr2TBkKcY4=
Date: Fri, 25 Jul 2025 15:58:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Darshan R." <rathod.darshan.0896@gmail.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: Checkpatch fix done and Clean up coding
 style
Message-ID: <2025072526-guru-reacquire-408d@gregkh>
References: <20250725135533.8410-1-rathod.darshan.0896@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725135533.8410-1-rathod.darshan.0896@gmail.com>

On Fri, Jul 25, 2025 at 01:55:33PM +0000, Darshan R. wrote:
> The shuttle_usbat.c driver has several coding style inconsistencies that deviate from the Linux kernel standard.
> This makes the code harder to read and maintain.
> 
> This patch is a pure cleanup effort to address these style issues.
> The changes include:
> 
> - Adding proper spacing around operators (=, *, +, !=, etc.).
> - Adjusting pointer declarations to the standard type *var style.
> - Fixing spacing in pointer casts, e.g., (struct usbat_info *).
> - Removing the redundant = 0 initializer for the static transferred
>   variable, as it's guaranteed to be zero-initialized.
> - Tidying up miscellaneous whitespace and removing extra blank lines.
> 
> These changes were guided by checkpatch.pl.
> No functional changes have been made.
> 
> Signed-off-by: Darshan R. <rathod.darshan.0896@gmail.com>
> ---
>  drivers/usb/storage/shuttle_usbat.c | 252 +++++++++++++---------------
>  1 file changed, 120 insertions(+), 132 deletions(-)

Please do not run checkpatch.pl on existing subsystems and old kernel
code and then send a huge patch to "fix them all!".  That's not going to
work well for many kernel subsystems as they do not welcome the constant
churn that would cause.

If you are interested in doing this type of work, do so in the
drivers/staging/ subsystem, which welcomes it.

thanks,

greg k-h

