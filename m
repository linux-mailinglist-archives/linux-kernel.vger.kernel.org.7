Return-Path: <linux-kernel+bounces-853234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEFEBDAFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F51718A7913
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B22BD5BF;
	Tue, 14 Oct 2025 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vpyErAT/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAFC25A64C;
	Tue, 14 Oct 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468108; cv=none; b=PeHOoQs7Ue7STcG5gQUgQVmb3vR7PO7HTTocGzNnx5s1+Y2qN4PpeFrWVjt/sP/NGSlgfCRABljduOa8EarENkgrvQ5SC+HOxxUbViW40bQRaFx92cSkvIZ2SxS6yd0JjaOUMDhdeELE7KzpxZpbnMGQv/DQ4phQ+YyPv5NrpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468108; c=relaxed/simple;
	bh=LIE11cvoeVeqGaWqiaEes/vnzfu/vA1n5oByRdFhEAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHN4WjihP3r+Ki2o9z/WQBQZWVtzF7irl8s3TfLXhFG50qpRqY+0kcw2s26mbRgWF+IGZj6aBHQy5IzXk6yX7vKU3u4q2cI5RqayeuwfbmfR+PH9mHU1YESExefg82ZWe4NPt0Les5At/q3VmeeOVylIrGYvFu3JY/I4OYE2ISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vpyErAT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AE4C4CEE7;
	Tue, 14 Oct 2025 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760468104;
	bh=LIE11cvoeVeqGaWqiaEes/vnzfu/vA1n5oByRdFhEAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vpyErAT/QWkq4hN/GqFaItrMCx/csU+GyXX1b32lWKrHbA1LOyztzLEkgTB/SzDXU
	 PVblZA1VMJKVZZG2kgpnvAPNBUFfl8FtNah+V0GLETcCQ8i/YCIkcpGkQ2Z9+Pi30/
	 NcBcc7IExokOJm6EUZ2ND5AxH/PS5F1dwQbDlDIU=
Date: Tue, 14 Oct 2025 20:55:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: fokaz-c <fokazmchakma4427@gmail.com>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: pc2: convert // comments to /* */ style
Message-ID: <2025101431-ancient-arrest-9dfa@gregkh>
References: <20251014181745.171714-1-fokazmchakma4427@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014181745.171714-1-fokazmchakma4427@gmail.com>

On Tue, Oct 14, 2025 at 11:47:45PM +0530, fokaz-c wrote:
> Signed-off-by: fokaz-c <fokazmchakma4427@gmail.com>
> ---
>  drivers/staging/gpib/pc2/pc2_gpib.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

