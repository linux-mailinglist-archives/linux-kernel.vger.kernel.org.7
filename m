Return-Path: <linux-kernel+bounces-736441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCFAB09CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB37A3AA55D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188A427AC3C;
	Fri, 18 Jul 2025 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IcqRStjj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6727B51C;
	Fri, 18 Jul 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824767; cv=none; b=Pgfwt/7rqQ51HIvS2e9qKZTpk2BintU05CTrtU3nQUPykbqCVPfS09pOlA6PYmc7Ty1vkpFl1cVp5dvwD75+7PkGiKz8ougVUrrsh4DrPnBqEwdaagACsITNOFwF3+3g2hz6QxstkuRuG570a9Jhj5TVsYmCj+LGWHczbuh61O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824767; c=relaxed/simple;
	bh=V1rqD+7v1f36V63WJXdXj5uO0cgm5H2sGPsV3R2+jhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a795Mu+X7KghjxzQbdYPe9AnevQKYCkW+29jQO7V4c5RXfaminBPyHd3ZYDJ2vEt0GAiCHPywGo4J48Sp/Ke6/AtA0hOqLepKC44FID4NraihMELnO++f6fU3SSsz3NDmojn40MUBbbBn2dsPgQ70mlZJjACgHTXS62XeLIC6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IcqRStjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96908C4CEED;
	Fri, 18 Jul 2025 07:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752824766;
	bh=V1rqD+7v1f36V63WJXdXj5uO0cgm5H2sGPsV3R2+jhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcqRStjjogF2tiT+jJOvaAeRlDnL75dQg8Ij8i2wGCbzv/Kn20xn/Vgig9Fq817Ex
	 QDxhCuZk0hPyy8IsnvTLK4LaIUlXom+KSjLaDv60bCpdgpX9EkAYDhpD24pNhoIZdx
	 Ft/JhI4FvDFWo/mdUPcogFCYZV3iJFYEC0TsRP9A=
Date: Fri, 18 Jul 2025 09:44:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: sm750fb: make const arrays static const
 char * const
Message-ID: <2025071808-jogger-snowflake-1911@gregkh>
References: <20250718034913.49300-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718034913.49300-1-ignacio.pena87@gmail.com>

On Thu, Jul 17, 2025 at 11:49:13PM -0400, Ignacio Peña wrote:
> Fix checkpatch warning:
> "WARNING: static const char * array should probably be
>  static const char * const"
> 
> This makes both the array and its contents immutable, which is the
> intended behavior for these constant string arrays:
> - g_fbmode: array of framebuffer mode strings
> - fixId: array of framebuffer device names
> 
> Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Always test-build your patches so you don't break maintainers workflow
by submitting patches that break the build :(

thanks,

greg k-h

