Return-Path: <linux-kernel+bounces-740388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7767FB0D3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F223AFA51
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906E2E3B07;
	Tue, 22 Jul 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KloGL+zb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD32DA760;
	Tue, 22 Jul 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169829; cv=none; b=PAkcs5mGfNZDpDPJJokEdQ+Z+bUwVeuviRM2J32axgv9+ZBjsW6MITqG2XfbS/uHceh7gd/h+uAn0TchxzBnjizqo+TKRAUqmwejVwi+LXssyKErSO2WGjKtFLhua6/Va4rIfygv+BD7Rqtj/1DhV7PFpO9gHgemspquRS1Ju7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169829; c=relaxed/simple;
	bh=2d1azXNbCL/mkAP3q1E7r/u+tfD/Mi0QIqW0rDmZcDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUbyx98olI/i4a+YznZpXJmbvfCfJrcL5egKbkwGxnoOgalnGAhgGyuiuGqkS2NIrvahvt1USn2yb8/Zw4r9TudXkyAUSdnxfarJJXpqXMa25w99qK5nk+vnf2GklHl5FEsuxp18UfujmA4j7DYxeHfNoRBixC6XXmao/jqMUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KloGL+zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FEFC4CEF4;
	Tue, 22 Jul 2025 07:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753169828;
	bh=2d1azXNbCL/mkAP3q1E7r/u+tfD/Mi0QIqW0rDmZcDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KloGL+zbkZ1Z0mLDXuXTSrzl7kW0wqDnXVgcaVH/6C0j7Lma4YSu0xASGAs6Mj8u/
	 YarSKKEb1jityqdgmfNG5FzW7lJ2HwLyY3kU67pH/VIPbLCG8UUkchwIqWqnarDGDR
	 jEuZq2Ytv/xkgDyKWz6ASyxj2lEMv2706OC8BS7g=
Date: Tue, 22 Jul 2025 09:37:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ali Nasrolahi <a.nasrolahi01@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 0/2] staging: rtl8723bs: fix coding style issues
Message-ID: <2025072239-verdict-saloon-1263@gregkh>
References: <20250721164343.8395-1-A.Nasrolahi01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721164343.8395-1-A.Nasrolahi01@gmail.com>

On Mon, Jul 21, 2025 at 08:13:41PM +0330, Ali Nasrolahi wrote:
> This patch series addresses several coding style and comment formatting issues
> in the rtl8723bs staging driver as reported by checkpatch.pl.
> 
> Thanks for your time and feedbacks
> 
> Ali Nasrolahi (2):
>   staging: rtl8723bs: fix comment formatting in basic_types.h
>   staging: rtl8723bs: fix comment style and formatting in
>     osdep_service.c
> 
>  drivers/staging/rtl8723bs/include/basic_types.h  | 13 ++++++-------
>  drivers/staging/rtl8723bs/os_dep/osdep_service.c | 11 ++++++-----
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> -- 
> 2.50.1
> 
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

- This looks like a new version of a previously submitted patch series,
  but you did not list below the --- line any changes from the previous
  version.  Please read the section entitled "The canonical patch
  format" in the kernel file,
  Documentation/process/submitting-patches.rst for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

