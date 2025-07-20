Return-Path: <linux-kernel+bounces-738065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C542CB0B3CF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 08:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED9D189B017
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F4D192598;
	Sun, 20 Jul 2025 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z+4sxQuc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B001EA65;
	Sun, 20 Jul 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752994014; cv=none; b=uMjJVM0s+rK7WUkqK+CJZCw/j+ifzHJS0r5j8ozTeZzJvnp7LMZNEM7jQqRCBv4BCySVmKj6hc46sMKeBA3CaeaO7WWJeilM1cvh3CvC97mMbwGOMImZIgSxSr+g+KlqiRBulHCat+FafpXdD0eem2GWdwbfS5eb7ZLgq+ZJ+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752994014; c=relaxed/simple;
	bh=4G77iiVz0cnG6W7mqdiFXyEcR7JkSteEAIvXb68rA4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFFLZIqtk8ZwNlBYLia6PwDmo7/yxXBNl1mmGqb9O8d1euwVQxrm7MMezpzjba9WWIsIcicVtB5woM5kz2z+1zhNQOp+LnehFK4AqvoDMr60Uw+7VMCUD3JNH/Lt7DYBASoXsPm5U6CBIxrT0KWVnLlhvPcsfHJPyDbrU+DfDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z+4sxQuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A09EC4CEE7;
	Sun, 20 Jul 2025 06:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752994013;
	bh=4G77iiVz0cnG6W7mqdiFXyEcR7JkSteEAIvXb68rA4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z+4sxQucVpWJv54bzVM/oAehhIJtjYUv5eeuQycvclFs6e+sGyeJMojAJOJAPSOuc
	 hNZtq0gnZPMvJFQ0Kabi/sgwQfWB9RFNsNToRmeQMmF36dPdBc5RnO3K777tsBae0a
	 azJu7wm7Ge65WW1CmiISKBe628pUECQ6s3NLNXdI=
Date: Sun, 20 Jul 2025 08:46:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ali Nasrolahi <a.nasrolahi01@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: fix coding style issues and improve
 readability
Message-ID: <2025072034-universal-tanned-3d03@gregkh>
References: <20250719172346.23573-1-A.Nasrolahi01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719172346.23573-1-A.Nasrolahi01@gmail.com>

On Sat, Jul 19, 2025 at 08:53:46PM +0330, Ali Nasrolahi wrote:
> This patch fixes several coding style issues reported by checkpatch.pl,
> including:
> 
> 1. Comment formatting and alignment
> 2. Clarifying parameter names for better readability
> 3. Removing excess spaces and unnecessary semicolons
> 
> These changes are cosmetic and do not alter functionality.
> 
> Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
> ---
>  drivers/staging/rtl8723bs/include/basic_types.h  | 15 +++++++--------
>  drivers/staging/rtl8723bs/include/hal_btcoex.h   |  8 ++++----
>  drivers/staging/rtl8723bs/os_dep/osdep_service.c | 11 ++++++-----
>  3 files changed, 17 insertions(+), 17 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

