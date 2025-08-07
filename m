Return-Path: <linux-kernel+bounces-758852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F59B1D4A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D4917817F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8490821E082;
	Thu,  7 Aug 2025 09:23:25 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ACE2AD00
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558605; cv=none; b=C7+FWu4S6IwFbNZFrr9bBLCwdIQsoMoYqJWKDl7cK5kVbII9x6PqVsjjojj10GADvSsGSI+d7AqAo0VX592PmjX4hhxSXBMpdxnrXgirLc8dvEaBSBVhvX3cNXX7Hs+Nz9jUVHS90/8YcsxKtquz9GZdWVKfEiyZxKHMuVYe6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558605; c=relaxed/simple;
	bh=e3MUUokPjw0bTZ2ANzf/uKJTeFbNCTn3AWgwhIT6uRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEfky1Q+OBedQKpLAHIP9SdFdESnec29/zlxD2eHFjzN3DPb/BP04KLmf5fvtKNHHroM8dXc/amyYjS4LyOerIq8yEXKmUBVSYOMvxvMZXkxjpOa+IDLiccu4jjdAMfDtPY5R5FsWw9PupDkYOPxi6DlutvLNmDtxaRoeagNlL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 7935EA0493;
	Thu,  7 Aug 2025 11:18:00 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zKMl65vKd_rK; Thu,  7 Aug 2025 11:18:00 +0200 (CEST)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id EAA70A03B6;
	Thu,  7 Aug 2025 11:17:59 +0200 (CEST)
Received: from samy by begin with local (Exim 4.98.2)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ujwl5-0000000ALFG-2frs;
	Thu, 07 Aug 2025 11:17:59 +0200
Date: Thu, 7 Aug 2025 11:17:59 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
	speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accessibility: Use str_plural() to simplify the code
Message-ID: <aJRvR9xEkzMix5zQ@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Xichao Zhao <zhao.xichao@vivo.com>, w.d.hubbs@gmail.com,
	chris@the-brannons.com, kirk@reisers.ca, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
References: <20250807085930.429665-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807085930.429665-1-zhao.xichao@vivo.com>
Organization: I am not organized

Xichao Zhao, le jeu. 07 août 2025 16:59:30 +0800, a ecrit:
> Use the string choice helper function str_plural() to simplify the code.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/accessibility/speakup/kobjects.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
> index 0dfdb6608e02..57139971e997 100644
> --- a/drivers/accessibility/speakup/kobjects.c
> +++ b/drivers/accessibility/speakup/kobjects.c
> @@ -98,7 +98,7 @@ static void report_char_chartab_status(int reset, int received, int used,
>  		if (rejected)
>  			snprintf(buf + (len - 1), sizeof(buf) - (len - 1),
>  				 " with %d reject%s\n",
> -				 rejected, rejected > 1 ? "s" : "");
> +				 rejected, str_plural(rejected));
>  		pr_info("%s", buf);
>  	}
>  }
> @@ -740,7 +740,7 @@ static void report_msg_status(int reset, int received, int used,
>  		if (rejected)
>  			snprintf(buf + (len - 1), sizeof(buf) - (len - 1),
>  				 " with %d reject%s\n",
> -				 rejected, rejected > 1 ? "s" : "");
> +				 rejected, str_plural(rejected));
>  		pr_info("%s", buf);
>  	}
>  }
> -- 
> 2.34.1

