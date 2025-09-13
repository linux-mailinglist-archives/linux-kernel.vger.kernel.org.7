Return-Path: <linux-kernel+bounces-815192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 231AAB5610A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 15:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5477587781
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EDF2ECE8C;
	Sat, 13 Sep 2025 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ16S2Tz"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2D2ECD05
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757769073; cv=none; b=p+z/Ysqi/NfJrSn4E+faWY9nPLkLtya+XRpmEi98+RvRfzKIGEhjMBhN8/YIxNe4DFNVlzb/dL4qaB93dVNcBIDULcizUtk037Un0oHwnKWgAPYP3/I6YEuDyyuBkq30wRdenXaTi5Xs7vWmKO7mw018YxpIizgBQ/7PcocyxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757769073; c=relaxed/simple;
	bh=oKJpDAv/IgzpjfgwUgdYGRiJ0C5lJdTjcz+qAOTK/kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET3iqXWi281yWaQWrkXKT5l6vv5umQw7A1KjZOFInq9aealPO8KhFJUwnsyJ9IE0tiTKYqkNMAs2WtKR8IAgwWv2kktcVRLIYrTgtZ7UgUX5AS1Wt2owe9NGJno33S/dacg9dpqvvo3ID9EBIqnKYwm5PCOW9lsPLUYp5XWDUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ16S2Tz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f6507bd53so2948643e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757769070; x=1758373870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWxwIgbTiJWjsGEavEfT0kkniKrODy1r+jAuDGwG3dA=;
        b=NZ16S2Tz+d2OYoxBdvbOczEP00GfPVLHQRzFmSrII9ZPWj2BxoKC5HVTMM1AtR8lRb
         frFEEfXhh6dDoLlrGluu/Op4RpDF1WmIa3n7+oqmk5+7iMtVPt7L+t07JncnL8z/9BR2
         z/fk91bvXxOac67AGyPqfdoP6PkGWziKlT38T3Ew9iceUHTypIkr99omj1ZowSiJt1Z0
         vOauwCGtklVDiNKVMXZGkFCAR5uCgqpHA7iAG+rOZyXROXTmpfBs4mhvPNlb6b4yjlkJ
         dD/uND9lgA+LWaWES5eershn8v5bjpwSO4ohXZQr6Ejf80vLMsGemqW4kWTGydWE8VG1
         Ub7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757769070; x=1758373870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWxwIgbTiJWjsGEavEfT0kkniKrODy1r+jAuDGwG3dA=;
        b=ijyROHx76xDXXTq8kYZs5ZMrhmd9NMeMmQxxDSPq/91mzSrERyIrBfEpyQ004pCYpL
         u3amAvyxQhbnzOsfHK+/B4XTCu8ob0QdY/FLjTYKMuYMHwc6FtyUiE3gdd9ESqSv344I
         7ovg9o/aJvtR0yrD5j1POD2Z6fY/Oqa9KeotqtCVExOiAwkFN91aKlq7jhKtAoc3D3Wi
         /DG92tLxJFL+FT4AlYEThKc9VhXpPz8WlA1JLyCf6CYsCvf886UAopQc1uGizQ3OfCk5
         kjjT9Liij9yqjNKBSLUUknPSG8BSDfPWlPX1emBeu47DEl6/NcPOWUMVCFmowBQmNQRF
         Oqvg==
X-Forwarded-Encrypted: i=1; AJvYcCWdux6nQr1c4DAV2g3ABRaHHiSsrkazohpgW0qkRjfEJVwwEBHTyzGCAh9G4sAzuzhEk7p3FHZbw3Z9HNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDAMC4PLxj8BwqnKLpPJx6/j/FO8gTJe2jmg6uZQ6AA5Mo7lgu
	wePdYtER9YagdcgeLsgTUAiL6V/HE/KHW8WdFZYr9V5613K/pk0F39uM
X-Gm-Gg: ASbGncufFMxD66PiCs+lqkIYqnT023bex5y1nPV6vnctR1ajz1otdn2Mji/fpNqVLG9
	A75RXIKEUwEedlQ+XU3llnHcFWql8KNVGZCKl+1bVgQTqZoK6r8Myr2u5S+7ztEHjpd26pXIW96
	eAStNowg/N76CHJujHO/qclDxm3PeoCatQX4n4FQ645ko6e7fsG12t2H4v0pfKyPX07nbYEmsM7
	XNu9EbRnuhievWpVvoXAbhoNqxKCmEt0s+QJfXCTUAL6mUxc4pLEh/fU4GpF35w35RcsDNXyt5n
	0cvbNU6pHrJ0OksxL2o2o6Loj8OISQOb47iR2Rt0CZ6f2E7pFySAa1A42nufiTc4tgt77jK0yci
	0x/28oHDjUqhjQy1HAQ9/ch1bXyAPPIHRzdjA
X-Google-Smtp-Source: AGHT+IFW3X/biyePEhlGPyL2QecOAnqaoRAKpWNM3rOTQZRDK64Zl3Y9eY7OF5QskdIkE2Rwq3bT2Q==
X-Received: by 2002:a05:6512:404c:b0:55f:5526:602a with SMTP id 2adb3069b0e04-5704ad8326amr2165663e87.15.1757769069492;
        Sat, 13 Sep 2025 06:11:09 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-56e65a34096sm1924029e87.136.2025.09.13.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 06:11:09 -0700 (PDT)
Date: Sat, 13 Sep 2025 15:11:08 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: Remove unnecessary goto label 'successful_load'
Message-ID: <o2ijjlbcicrrfflp54o53sj5v6morqedtkkzizhhyvl6cqvezw@yl7hx3naojcn>
References: <20250913121514.1789204-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913121514.1789204-1-thorsten.blum@linux.dev>

Hi,

On 2025-09-13 14:15:14 +0200, Thorsten Blum wrote:
> The goto label 'successful_load' isn't really necessary. Set 'res = 1'
> immediately and let 'goto done' handle the rest.
> 
> No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  init/do_mounts_rd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> index ac021ae6e6fa..97ddcdaba893 100644
> --- a/init/do_mounts_rd.c
> +++ b/init/do_mounts_rd.c
> @@ -210,7 +210,7 @@ int __init rd_load_image(char *from)
>  

>  	if (nblocks == 0) {
>  		if (crd_load(decompressor) == 0)
> -			goto successful_load;
> +			res = 1; /* load successful */
>  		goto done;
>  	}

This is now the only place where res will be set to 1.

>  
> @@ -264,8 +264,6 @@ int __init rd_load_image(char *from)
>  	}
>  	pr_cont("done.\n");
>  

> -successful_load:
> -	res = 1;

This does not seem correct? After this patch res is not updated to 1 anymore
if execution reaches here without taking another goto, i.e. the return
value is changed by this patch.

Regards,
Klara Modin

>  done:
>  	fput(in_file);
>  noclose_input:
> -- 
> 2.51.0
> 

