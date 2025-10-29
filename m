Return-Path: <linux-kernel+bounces-875405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA963C18DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 848133548A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32092313263;
	Wed, 29 Oct 2025 08:06:20 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AD31B137
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725179; cv=none; b=E8DddRGN4KPITc8PlyIATJ51DITSzliCjs8WaYSn7UhfKUMG0waM1RcyH3gCOV/DRHa/BBNyFMfDxn6gTpFat+FjKyXJcIzZ3BCn8AQ0BXexU+/1oX/eSZyuke2LzMBsHh/drMfi/hE7yXb/MbFf6fDa8E/efm3YbsrpyBFsDOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725179; c=relaxed/simple;
	bh=eNjQcFAeEfWwk1uuUNhaCjr8n5IvcNmOte9M46Xneq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sB+xphARiIHzvLGWrJ4r3GnWcEUjSl2JpoSMZzFgz/MxEnbe8SmkL7QUT3rivBtqXdJJzeIu/OiOm0XUygySrB3LJilu2j/Ox7YniPs8vdb5V0QJXct/Sf67UiOzyg/Qt9/XMQUuZHJrHwiDXaN7d3TfLS21Rw/I/ZX4dhB5Bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 071F6A1C18;
	Wed, 29 Oct 2025 08:56:22 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MyoH-mr6tvXg; Wed, 29 Oct 2025 08:56:21 +0100 (CET)
Received: from begin (aamiens-653-1-40-48.w83-192.abo.wanadoo.fr [83.192.199.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 6DA61A1C0D;
	Wed, 29 Oct 2025 08:56:21 +0100 (CET)
Received: from samy by begin with local (Exim 4.98.2)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1vE12a-00000009aGe-3kj4;
	Wed, 29 Oct 2025 08:56:20 +0100
Date: Wed, 29 Oct 2025 08:56:20 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Bo Liu <liubo03@inspur.com>
Cc: w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
	speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Accessiblity: speakup_soft: Fix double word in comments
Message-ID: <aQHIpJ1XiMfDzhMs@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Bo Liu <liubo03@inspur.com>, w.d.hubbs@gmail.com,
	chris@the-brannons.com, kirk@reisers.ca, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
References: <20251029071629.17705-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029071629.17705-1-liubo03@inspur.com>
Organization: I am not organized

Bo Liu, le mer. 29 oct. 2025 15:16:29 +0800, a ecrit:
> Remove the repeated word "the" in comments.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/accessibility/speakup/speakup_soft.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
> index 6d446824677b..6549bfb96e7f 100644
> --- a/drivers/accessibility/speakup/speakup_soft.c
> +++ b/drivers/accessibility/speakup/speakup_soft.c
> @@ -446,7 +446,7 @@ static int softsynth_adjust(struct spk_synth *synth, struct st_var_header *var)
>  	if (var->var_id != PUNC_LEVEL)
>  		return 0;
>  
> -	/* We want to set the the speech synthesis punctuation level
> +	/* We want to set the speech synthesis punctuation level
>  	 * accordingly, so it properly tunes speaking A_PUNC characters */
>  	var_data = var->data;
>  	if (!var_data)
> -- 
> 2.31.1

