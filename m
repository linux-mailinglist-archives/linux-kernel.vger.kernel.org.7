Return-Path: <linux-kernel+bounces-694303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D1AE0A73
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 17:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952943B3AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E1233151;
	Thu, 19 Jun 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pzEhQX2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889ED220F38;
	Thu, 19 Jun 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347028; cv=none; b=Qsv5Y/pyupQPK3d/DllBeiDs4HtZtTM0fFSx8hHwzkm4VwXRZCHC4UIPDrMmC+KRpVxfLz3yRaYtVXdRbJ/QfsLXHiiEAgO19qeVPlDjG5iivb3drkBoZDKsTgRf5AotI+HL6Qj+2y0A8VFNwFLXpQaKofag4UmE7SanFAtpVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347028; c=relaxed/simple;
	bh=PwE/0aiGmWqwionyxvwueOuqxJ5a0Dsl2UoalFM2xdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYeXzO6yfJXzVxdv6XW+G0tIFEhGeHvnQ7TmoRzoHcd+GQg8GnMRIM3sHGQ/P4ZN4ixMbTXji5WTut9v5445m10atN3IRlLbHwVPIXxIIBFrqsnhhTVBpIKH+uX+gwVBT1Kadhch7As4NIA/YAeSGJOjm8EnMQBjlNY1bg5gFRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pzEhQX2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0881C4CEEA;
	Thu, 19 Jun 2025 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750347028;
	bh=PwE/0aiGmWqwionyxvwueOuqxJ5a0Dsl2UoalFM2xdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzEhQX2diIDTU/OlK81V4leRPXT+WkSshR5P0nL6GBMBNZvLlO11BFiFymKR2iept
	 AkweKq+A/vKECWP/sCP1OzhKoi2IKuXB0LV4bkCg0aDzRFyvPvZX9jPMef93MhJh5u
	 k5DJZA/1t03uBEuhw19Q753z6ze0PyS/C74zgRu8=
Date: Thu, 19 Jun 2025 17:30:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Florin <ericflorin@google.com>
Cc: teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: sm750fb: Rename local var `nDirection`
Message-ID: <2025061916-overcoat-deduce-5a62@gregkh>
References: <cover.1748365488.git.ericflorin@google.com>
 <f247ceee80387ece536aa5657f105321809470f1.1748365488.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f247ceee80387ece536aa5657f105321809470f1.1748365488.git.ericflorin@google.com>

On Tue, May 27, 2025 at 10:11:28AM -0700, Eric Florin wrote:
> Rename local variable `nDirection` to `n_direction` in
> `sm750_hw_copyarea` to conform with kernel style guidelines as reported
> by checkpatch.pl
> 
> CHECK: Avoid CamelCase: <nDirection>
> 
> Signed-off-by: Eric Florin <ericflorin@google.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index a34d8f6a033d..b9f90c934b7d 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -153,9 +153,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>  		      unsigned int width, unsigned int height,
>  		      unsigned int rop2)
>  {
> -	unsigned int nDirection, de_ctrl;
> +	unsigned int n_direction, de_ctrl;

Why keep the "n" at all?


