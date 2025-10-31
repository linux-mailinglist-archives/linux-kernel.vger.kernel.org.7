Return-Path: <linux-kernel+bounces-880672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21051C264E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB89189E633
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A933043CB;
	Fri, 31 Oct 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc4n61lq"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B733019BF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930658; cv=none; b=EDMg2xfp4CeEBkwfYXU6LclTGlFOrJqWw/1jNrFGiTn4fEzoMddm1e4Yh2HblPmpNnSDbBJj/whtAoGQn8Tr+hqQlt24kegYvtx66ccmFW2u95hyNe38xoP4Angh2FHe5bQSOJEAZYObFEMikWJFFSJRRv4yIMHn23TIf1oK45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930658; c=relaxed/simple;
	bh=1V58FwaG0NnqB9u+ZkGTXiu0T/QMWq/olMjJkPFsV1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2s7RwAIZnhYQ+R4HJNByBdNvenrWx63IUJIiY4q7YyUU4v7mYwOnQGejC3tn7Bhi5+w77PnbP+6LYQXpy+PcjfpITMP9H2mHMiMuWdbchUX9XMFTuqdJiBIomaOacBfGodi6GUVPxmyLWRis44BCf0pOQNslV7ZvPVvNvoHB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc4n61lq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429bcddad32so1024651f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761930655; x=1762535455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0UiwqRJqkZXUe5MyPuxH5cks4+QEZvrm/OruvGxuDf0=;
        b=Pc4n61lqphr96LaSv1xAl4cE7zItAPxUsg4itZpNRbePQ3L057kIysBT0/aI6d6z7w
         lbTzYq399yuLnrcgGQWQKQoBOO/w5obpuOe/i5vS3IlaAa8bsrX/xeh3e8roN5KkVA0u
         oA9jXHbzdZDeaqBCqKiGnXCG4rVsTMOmUXRt/qjtvqIFxM7lAV+amVO5fHlDmXhyLNvn
         VDFIwvi67odSu4TlPuuImHUdPBXRLmjOdvR9OL2VgNQ9hrr09c7iUeB11Tl4Ll14ciiO
         TKtzP2Vdd5chAeZ6M351i1sn+h3ufNrB0wMUqlE6dF9ItredCJguUnCKw/NTwk5o8aDr
         5rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930655; x=1762535455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UiwqRJqkZXUe5MyPuxH5cks4+QEZvrm/OruvGxuDf0=;
        b=JJTssXvK0oQ5Q7d0IY1kWNKhvdNRrXBKkzVOUyiPAlrLc/0jJrhMtOi/l51EQHCQKn
         TZpqhwaQzeoZD7BedQN7xdWUpO126imPX0gYKj/X3QomHe/1ku6/pds9nl2xiJ4ernv+
         V69B39WGAHVJFyb8oMaMdB63oH1I6FWnq99Hc4JRfhOfkyC2wOjUnErnFX+i80BPSJSw
         5Tk6aF21Lx97ZTLmrMKNpD7VAwvtVmyMzQmzNIdfRyMJksV+LqqEUf0auhrp/7AoqEAh
         g4c1PmV3B2Lt+UtreJqOoRjaWYOAmrTdm9CsuUcryjLP0QUp77kTOgOojShvknlpPpez
         RQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH+G/eYZXgDuknXhxJcq10ldOYHZ7/rsQDRjsSQrJYa1frwrz03Cy3nEDrnrT3LZaGMKbK+Hzhlio76Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXgLCOjNjsw3HGXwXl3nZROvcfE+Tt+f/nV8gvO9SrGJIxYYZ/
	ffBUVJ/sXR13j+iUBKUEH1A7VNvNnaT6Cv9PuOdEz3crDjHRmEvtzLJf
X-Gm-Gg: ASbGncunm+NuVSVkEVq4LdBgYo9a60URAQLAsLEE0gT4XA+cW40rdJ27HChU/dkIkuO
	Mov0vaTZocn0OYnN+nOh7+MyODNdw0BpsjoqW+PVmNUUcmCx2+f+66oiLsJ0gTmtEegeD72nJUv
	cE28izg8ZofPQi+XABWSKh6KTV7PiQ4qHH9JgozroC6yu3yUeVSYlARucHvbLwsSr7MMU+R7tjl
	JnrhiIsLyydbYSmGoVJBnwu5AKR3G0LzXBxcpTcaTte0hSa3JX0SYKom65qtcw0zq8vzypIuy+C
	BWbB2JSgrbKOJGTPOapeL7xtKPbqn1TmpHLL30YanwRCOIcoNTewvD3SRco6B6xzeRQG+m4HXgZ
	D063c3Ew6YfVcFky0NKs2EMecFmZpkUsU5S7AUEoNRFiZbzcR+BpdRXTXFNdBZs/+vY/CpDfYOF
	bdgA==
X-Google-Smtp-Source: AGHT+IHpGDWDV7wqUvqekAtpscxPtUAdqlp3pOzwvpMAnIt26zDqvsJCUbs9jGS8XQvH2aYF+esanQ==
X-Received: by 2002:a05:6000:2410:b0:3ee:3dce:f672 with SMTP id ffacd0b85a97d-429bd676a03mr3523737f8f.4.1761930655051;
        Fri, 31 Oct 2025 10:10:55 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110e77esm4372653f8f.10.2025.10.31.10.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:10:53 -0700 (PDT)
Date: Fri, 31 Oct 2025 18:10:46 +0100
From: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH] drm: sti: fix device leaks at component probe
Message-ID: <aQTtlvoe96Odq96A@thinkstation>
References: <20250922122012.27407-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922122012.27407-1-johan@kernel.org>

Hi Johan, 

For some reason this thread went through my filters, sorry.

Le Mon, Sep 22, 2025 at 02:20:12PM +0200, Johan Hovold a écrit :
> Make sure to drop the references taken to the vtg devices by
> of_find_device_by_node() when looking up their driver data during
> component probe.

Markus suggested “Prevent device leak in of_vtg_find()” as commit
summary.

> 
> Note that holding a reference to a platform device does not prevent its
> driver data from going away so there is no point in keeping the
> reference after the lookup helper returns.
> 
> Fixes: cc6b741c6f63 ("drm: sti: remove useless fields from vtg structure")
> Cc: stable@vger.kernel.org	# 4.16
> Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/sti/sti_vtg.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
> index ee81691b3203..ce6bc7e7b135 100644
> --- a/drivers/gpu/drm/sti/sti_vtg.c
> +++ b/drivers/gpu/drm/sti/sti_vtg.c
> @@ -143,12 +143,17 @@ struct sti_vtg {
>  struct sti_vtg *of_vtg_find(struct device_node *np)
>  {
>  	struct platform_device *pdev;
> +	struct sti_vtg *vtg;
>  
>  	pdev = of_find_device_by_node(np);
>  	if (!pdev)
>  		return NULL;
>  
> -	return (struct sti_vtg *)platform_get_drvdata(pdev);
> +	vtg = platform_get_drvdata(pdev);
> +
> +	put_device(&pdev->dev);

I would prefer of_node_put() instead, which does the same basically, but
at least it is more obviously linked to of_find_device_by_node().

Best regards,
Raphaël
> +
> +	return vtg;
>  }
>  
>  static void vtg_reset(struct sti_vtg *vtg)
> -- 
> 2.49.1
> 

