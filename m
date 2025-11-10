Return-Path: <linux-kernel+bounces-892970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 461ADC463E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9680C4EC68C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20EF3090FB;
	Mon, 10 Nov 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtsCD+jK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3D307AC5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773875; cv=none; b=H9sPMhzmm3A5yrmQk5suFU+qaEQliRYyq1Ue133gwGpIUqSltlZmRBk+D/wTyrp6bQ50SxM44z5BTcvyTFY995255eZ6qqpElcXl1sb4peunLoMkiC+x9WZ/dKXssz9zOvXu9IdfAe2bwZVEKU5QrJ1aSyAIKEHZemLkU8/pzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773875; c=relaxed/simple;
	bh=EJyeyu9qrbyFTW3ZAMU0Et/efH4fzledufkx17gz7vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gawt7M73rrqgcvcQhr8ruEULUdSTR9rX1crmH5vvjPIMddb6wc1+2hEFOoIfGkttTrCn8dqg5l4mOo2QEQnlhlxdr+4HSVMsVmmeM/SiSXuiR5Ld9lCou/suDJi0iMMlbrQDv9fb8o3hAsmZhBLygv6bxfp38R7tEiZ8HcqAi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtsCD+jK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47714bb5c49so1105055e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762773872; x=1763378672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHVkVJbJqK7JYa82NcNOlxoAH1RMsDuV8bpVmsumva4=;
        b=EtsCD+jKv58s9eVORzVXNuNc77WkQghEV4IGdqYijPMRZUg6UDXCScInsqnkeJ+3wk
         KM5vt8eQiV5zEd7/CdmicGm661eqlfaZzOqEaVB3qFnx6uL2PfcMPc5AMhmGfoPLyNJW
         GV/uWhhwzS5I0PO4yXoUUOR8BnhO3rLXqM7I11gUHc0SgYBioGpd02P6VhTFlAIa9CzT
         JaikZrLQOoF9PC/9Ru/pL+kBumsQ4RCiw1ALoAHC68bhMvq7TA44nqMspN5nf9Ln+F2u
         K6nuBBm2Dezi0vGdP16K9qWg4b0BBws4tZlU10doWRXQHF6ZsRd5CHN+ysbLAGU45aD5
         1DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773872; x=1763378672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHVkVJbJqK7JYa82NcNOlxoAH1RMsDuV8bpVmsumva4=;
        b=FZK7oXOdVmlMCOuiILwqtddHuKQJtjS6PAE19eH71bYk8jy3fzwAJuOuNXOIY6eEUZ
         2k5cgH2Gv6bVT+lvpwWHHlfZwOagpXsF8rOljWPM6L/D9hRXtM5rpgsdsKfzeens+Mp/
         z3ld2NaWULl+uspFRJrSiyBi/rJ1ErK1z7d/i8sMe785M+osBIMDeRlugmYA0NFFwkSC
         TjZwLtnL+GhT4fINqFN+Sl50mQCIbmRq9ymWUlog/qXuKMMZNJh8mutMeWQuaL95bTOL
         EnRppbb7rMxPsSMTXvtvJJQ/5FR83hAQFpLKc7cQL8/8jX3mpF+FfbfKEdqZfbzFm5Wk
         ckcA==
X-Forwarded-Encrypted: i=1; AJvYcCUNYNH/XDXZeGtI+sl4M1qjBJoHg1Sw5IOJjCPpNeFkBWENmLv9mehIpULM6u/lcjIGXsa108DWndw6uRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJ5kZsrskHI1hUB+veGQq/U6EWR9eldoAVi2t6Wj+pjfLwxhQ
	OgyrsmwJm15kRey9c6HsGbHlhjKz+01Oj2+L23J/7JKBp+WyzSjdeyhT
X-Gm-Gg: ASbGncsedDZ6Vn+EQfdDjUW/owBgk5Z4AYj2Y3EWtO8QArPaMJZwu8rZ547SZB40lbs
	3HkeUT4t7N/0ZQ6JOOV6XtUmyu8LGMDOeKPfXRcJrhjEmuUD44+XTSEpLUjN9/bAbUUIwpy2gyi
	4AT3jGA75EphKMkxUqvKc1Vfs7DXAjeYfnVa/z8lBYf0XmOY6eddgH0tyH7OYqoBTFb9mMekud1
	LvFywqnzYDgUHqQwMmX82VU1op69N5S9qC/VxhsgvCUF3vuvtwvN0CuVllB91ziprR7vITyFvFj
	nlWbIr1QGJeuZzaAUJe2JVCn4qmD7F6FwsYzjPDf2jIR4tpUawkpXvFSBh/N/bF2kalFNeHuDMr
	zwiAiLXivEu+zXElTwt6RHYbJOB5N7hWfreRN31JItSt8d6KUaRaesn5X4k0JdT7PoMPQ
X-Google-Smtp-Source: AGHT+IFv2MC97DDRVbWlWDwdHkT6SZ1RsmqcVG6EYHokOKf3aRIupq3sW4kWIWGv6LqQLEOY+RHrFA==
X-Received: by 2002:a05:600c:1987:b0:471:ab1:18f5 with SMTP id 5b1f17b1804b1-4777328fc49mr38719265e9.7.1762773871479;
        Mon, 10 Nov 2025 03:24:31 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00b:be00:af04:5711:ff1d:8f52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477789f3f0esm92528885e9.6.2025.11.10.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:24:30 -0800 (PST)
Date: Mon, 10 Nov 2025 13:24:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: tag_brcm: do not mark link local traffic
 as offloaded
Message-ID: <20251110112427.bxibfxj7ziyukzfs@skbuf>
References: <20251109134635.243951-1-jonas.gorski@gmail.com>
 <20251109134635.243951-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109134635.243951-1-jonas.gorski@gmail.com>
 <20251109134635.243951-1-jonas.gorski@gmail.com>

On Sun, Nov 09, 2025 at 02:46:35PM +0100, Jonas Gorski wrote:
> Broadcom switches locally terminate link local traffic and do not
> forward it, so we should not mark it as offloaded.
> 
> In some situations we still want/need to flood this traffic, e.g. if STP
> is disabled, or it is explicitly enabled via the group_fwd_mask. But if
> the skb is marked as offloaded, the kernel will assume this was already
> done in hardware, and the packets never reach other bridge ports.
> 
> So ensure that link local traffic is never marked as offloaded, so that
> the kernel can forward/flood these packets in software if needed.
> 
> Since the local termination in not configurable, check the destination
> MAC, and never mark packets as offloaded if it is a link local ether
> address.
> 
> While modern switches set the tag reason code to BRCM_EG_RC_PROT_TERM
> for trapped link local traffic, they also set it for link local traffic
> that is flooded (01:80:c2:00:00:10 to 01:80:c2:00:00:2f), so we cannot
> use it and need to look at the destination address for them as well.
> 
> Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> Fixes: 0e62f543bed0 ("net: dsa: Fix duplicate frames flooded by learning")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
> I shortly considered changing dsa_default_offload_fwd_mark(), but
> decided against it because other switches may have a working trap bit,
> and would then do a needless destination mac check.

Yes, exactly. Or they simply don't receive link-local traffic via packet traps.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

