Return-Path: <linux-kernel+bounces-744089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6559B107E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFE1AC4CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124F267713;
	Thu, 24 Jul 2025 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jMNcgaL1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D1218E91;
	Thu, 24 Jul 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353508; cv=none; b=GMFSVVjRMwfsUyr4xd+zICpdgUjLy3kfuzS5uHzIw5lv83PNKpQsBu0rMwgbhhbG3Bh3TPrVGJUPREgtpqsZGH9Db/kI7l5ofxBYWEQvGhLgSk6+0gIyrvLxsXhRXEddZVHI6Is793FZXPCKf4VRE/BYY52QZVcLOBZFpYCMcOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353508; c=relaxed/simple;
	bh=kI0t3TBEMVWbBG32IrGZsBZwEow/Om1r7MbtOtAGh58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXTdAD5gjyk1KrA8imHARULy1tpsuJCubEpnzYz9DtqXNhasbQT8MixvdcxRDeDbml4onxDd6NCFGLSZQrNgVal0qNAjm8JJTnih7yAVjm3Sj9VunjTHEOePM4xEMlEDT7qT+pNzkgL/DOzrnwSQQjgs84wYEMQqZqJmsg6aobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jMNcgaL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAEAC4CEED;
	Thu, 24 Jul 2025 10:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753353508;
	bh=kI0t3TBEMVWbBG32IrGZsBZwEow/Om1r7MbtOtAGh58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMNcgaL1HE87qpDOYoJzkCd2Ii3Z5ekOKk5NtXFysM9KhHD9moTQIA+0vwniCfOUj
	 Pz2Of2Nj2mCBtmH0uhl8yj/TTttvbXzq+r82pJTMeJCGbKj3VmTRTltNZrBb+/cfp6
	 sKhdlJDecFvBvkoT2zzgcFaKg3CjCsbAiaI3PcxQ=
Date: Thu, 24 Jul 2025 12:38:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: mention MIT license as a compatible license with
 GPLv2
Message-ID: <2025072459-tweezers-dingbat-b748@gregkh>
References: <PN3PR01MB95977C87764A556FFD49FB72B85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN3PR01MB95977C87764A556FFD49FB72B85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Thu, Jul 24, 2025 at 10:03:41AM +0000, Aditya Garg wrote:
> MIT is a widely used permissive free software license that is compatible
> with the GPLv2 license. This change adds it to the list of compatible
> licenses with GPLv2 in the kernel documentation.

No, please don't.  This isn't a proper place for talking about the
different license interactions.

> 
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  Documentation/process/1.Intro.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/process/1.Intro.rst b/Documentation/process/1.Intro.rst
> index 25ca49f7a..c3465e3aa 100644
> --- a/Documentation/process/1.Intro.rst
> +++ b/Documentation/process/1.Intro.rst
> @@ -235,9 +235,9 @@ code must be compatible with version 2 of the GNU General Public License
>  (GPLv2), which is the license covering the kernel distribution as a whole.
>  In practice, that means that all code contributions are covered either by
>  GPLv2 (with, optionally, language allowing distribution under later
> -versions of the GPL) or the three-clause BSD license.  Any contributions
> -which are not covered by a compatible license will not be accepted into the
> -kernel.
> +versions of the GPL), the three-clause BSD license or the MIT license.

You forgot a ',' anyway :(

thanks,

greg k-h

