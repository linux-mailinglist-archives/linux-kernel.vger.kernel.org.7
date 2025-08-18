Return-Path: <linux-kernel+bounces-773043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13415B29AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73F118A05E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88F1279DB2;
	Mon, 18 Aug 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FWBeSAst"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC427A127;
	Mon, 18 Aug 2025 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501973; cv=none; b=mSiJntnQIqIiObiL4YJPhKAwkM7N3r7BoH7TPpUcXjmQT2W9DwUqbA/wx17HroP7XcNhu3H7NdLQsMe1TJeFU2Qc1lSHIv4/MFaYZsWMo/40ibY937T33Fuac3eiv+HVsBLaESu8yaXErxDQ63drPN+p7+b7XdMJXMdZ70QPHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501973; c=relaxed/simple;
	bh=boE3r3t+8aTrJlM5pFqX1Ii4PqTCxgBVNXHCPYTbCRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFBDIHnVwYQnyiV/QQ5CRT92j4+DqCxyDZGIuENTu+tDHn4ZWiBEat8esAqvIGr3/4A6POebqDbGp2JLoO0f7C4Omin0P267+YhDKfPsM4w08Rgwg2tNl+NM9By0ZluEn4CLxMm/dUi/Fv/i3OLsjT7a7Y2kssDX36dHR2bMNLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FWBeSAst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E57DC4CEEB;
	Mon, 18 Aug 2025 07:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755501972;
	bh=boE3r3t+8aTrJlM5pFqX1Ii4PqTCxgBVNXHCPYTbCRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWBeSAstB1803UwNbbAfADiXqQeUg3oBwCQ1i9ae+wgdmHMk0vy2ZgFrB0mvP993K
	 NCvLQpXLoEHh6Fw9+Kzo2pE+F0pGhbj/26GCcGzxpDekg1nllD94PCwagz5OOPiN5e
	 dS4Ldux0X+VqOfUC9L2VjJMEmY3624P2bCcoWjcU=
Date: Mon, 18 Aug 2025 09:26:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nino Zhang <ninozhang001@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	straube.linux@gmail.com
Subject: Re: [PATCH v2] staging: rtl8723bs: fix coding style issues in
 core/rtw_mlme.c
Message-ID: <2025081850-carpenter-radiation-8790@gregkh>
References: <20250817054202.31171-1-ninozhang001@gmail.com>
 <20250818071411.90159-2-ninozhang001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818071411.90159-2-ninozhang001@gmail.com>

On Mon, Aug 18, 2025 at 03:14:11PM +0800, Nino Zhang wrote:
> This patch fixes blank line issues in coding style:
> - Remove unnecessary blank lines after an open brace '{'.
> - Remove unnecessary blank lines before a closing brace '}'.
> - Add missing blank lines after variable declarations.
> - Add blank lines after function, struct, union, and enum declarations.
> 
> Signed-off-by: Nino Zhang <ninozhang001@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 29 ++---------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)
> 

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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

