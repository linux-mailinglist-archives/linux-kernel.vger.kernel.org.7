Return-Path: <linux-kernel+bounces-781978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829BB3198B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E25417D1B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A572FE591;
	Fri, 22 Aug 2025 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNHiryKh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2012FE585
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869198; cv=none; b=pPFZB97BZd2KvLJFPmzOQHt2Hx8LauO3nVxpbNFj6vImMyXVNPxTTEDMkUZ9TXw603i28V+kxO0qZglU2YN0wCdUN4I3mjkR94TMYcJKM+kiE0CwGLZoFh7pIio1+FBNeTDHAEFQsQfRBI1o5pnj5tkPvn35wEzv6R2pVpNMV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869198; c=relaxed/simple;
	bh=RANV6Gs9Vh0y/VAo+p5yE7zNz6Jq6kT91iEhVGdXL7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1gpWagznZhFcMhJ8M74sHLwmFrzJKt1jhHp4lCd96doqo56mCKqM7ir6vFSEyz1vzLfAQOHth1j3W+Mzx890Ts5OK+bwlIEyx4W+/n4HL77U9jlF0inmE5fNlkUJXgy21jZarlXq78o7nBcbx/FExoJgkDHHx7WCLcxBfJFtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNHiryKh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755869195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S420RL60CZZdB1VzGp1TEQ2bkpwHaqIWzRVn6C44bUk=;
	b=SNHiryKhrs4yOH1sRJC6zLERBlUPXS6GHM78r2u+YoqdAI01rya6s9rQAwKI5nvMCzLQfQ
	q0b9EjJbRCmXtGakWfyAra8lv1IOnHL4Z1g0VqTkTAF5y/bggQxJR95hXtbxKr9sHBNBD7
	5QyMrO7f/qqFIa6KWeMPqeO/GPJqjvc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-c9epHWfDNkO-2q08wPg-4A-1; Fri, 22 Aug 2025 09:26:34 -0400
X-MC-Unique: c9epHWfDNkO-2q08wPg-4A-1
X-Mimecast-MFC-AGG-ID: c9epHWfDNkO-2q08wPg-4A_1755869194
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109ab1e1dso85163611cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869194; x=1756473994;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S420RL60CZZdB1VzGp1TEQ2bkpwHaqIWzRVn6C44bUk=;
        b=RXDowUmpW3oNxGgF+4IINF/jM8aDYrDOuxczK3L0Z+edu+8znFIz1Bt8G5RGxOla3t
         goEED07C/rk0O+oexBtY/6V7hfXX2oGh6uzkb+rfr8lhy/gO3jjVVYJ8ZFLotALlR6VL
         IYd8lfd4J2yM1PAYZGOF9Ullu/DLrP+GaQSq2IlNT848orIa9A0yHs7/fknx+gPA7pyF
         oNELpMfn+rdwHR3uYbansh4Xv1R1ZQUdf6KaGT0RV6wLGnJAn/kLxYw2OH443XXAYK+y
         8jAMHhcF/x/b4Gumg+2GagZs4Hc9aaLuaqqHYcsVahV3ECsT7DywQuTeHGh15l9vxPv2
         JOkg==
X-Forwarded-Encrypted: i=1; AJvYcCWoIEe69UzF+2wShCiU5bHK3KIrrFB643DI/FJGPq0PB5Q8f9qGvIj8aCoyhn4r30oLNpiQPiakbMJYKNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3lWl2qZzG6lz1O+VYzsqvyZhjxhfbnn3uZRniuMczKZO5jeB6
	AXJazkQhYKNBbaTppXIboTejy4XdbS2IuxGQxGUVjor0t3EW/DaUd2yi8acJUrUMvZ3okV/WoL9
	FeORRMXZ7e06xF7pQGiML/LPIqoy7XZpWRIhKhSjkJW8lFsxHEbg9ujp1iFshXEwscg==
X-Gm-Gg: ASbGnct3yiLio9LmIvNIA0fhwyzbiYxh8tPEUQWyNt/MIF5rL2ZVP2WPnYcKXmK8jS6
	Bdoi9Qqu+C7FReErBVYolvw8xX5FDrAID5njXOo99HPPAxxkcny87isV73FW4upDJVoHpJLr0U2
	bFipgrAPXMcDbyDyyhUUOMe5564BLp4BE4ARBJM8XVgVlkMkHDtX/RTdFjovHInuMhdfcR9RVqi
	JmU0V0ApEvfSbHZsHaBOy962I1g846At1VjQEAhnY//jBt8n+ShENJ1ufSjBWca88p8FkFod7l3
	hgvI9oFQt9cyAf3LiIcGcNMGVkKeeNnShmY8cmxh6aUvVIlMadFiHlLXVSHt+b7f30kClcJUmhi
	rni4vQzZWS/Uua2vYWGo=
X-Received: by 2002:a05:622a:1f10:b0:4ae:b1c9:85ff with SMTP id d75a77b69052e-4b2aaa7dfe9mr37005131cf.2.1755869193841;
        Fri, 22 Aug 2025 06:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHUHzR1DMxxA6MQlfrHhbtm3IrPOrR8xfmuEXbXSQpLFypKCHoC/yBGvnM/QYtIjFKFdfpwA==
X-Received: by 2002:a05:622a:1f10:b0:4ae:b1c9:85ff with SMTP id d75a77b69052e-4b2aaa7dfe9mr37004721cf.2.1755869193335;
        Fri, 22 Aug 2025 06:26:33 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de15ebcsm120303891cf.46.2025.08.22.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:26:32 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:26:31 -0400
From: Brian Masney <bmasney@redhat.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: Sort include statements
Message-ID: <aKhwBxLdOH7R73BJ@x1>
References: <20250814035317.4112336-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814035317.4112336-1-wenst@chromium.org>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Aug 14, 2025 at 11:53:15AM +0800, Chen-Yu Tsai wrote:
> The clk core has its include statements in some random order.
> 
> Clean it up before we add more.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/clk/clk.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b821b2cdb155..2eb63d610cbb 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -6,21 +6,21 @@
>   * Standard functionality for the common clock API.  See Documentation/driver-api/clk.rst
>   */
>  
> +#include <linux/clk/clk-conf.h>
> +#include <linux/clkdev.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> -#include <linux/clk/clk-conf.h>
> -#include <linux/module.h>
> -#include <linux/mutex.h>
> -#include <linux/spinlock.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/init.h>
>  #include <linux/list.h>
> -#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
> -#include <linux/device.h>
> -#include <linux/init.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/sched.h>
> -#include <linux/clkdev.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>

Reviewed-by: Brian Masney <bmasney@redhat.com>

Just a note that vim will sort the four linux/clk* includes at the top
slightly differently, however I like what you have better.


