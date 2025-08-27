Return-Path: <linux-kernel+bounces-788589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79BB386E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C5F46304F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1F2DFA5B;
	Wed, 27 Aug 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEKV1W0z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA702D6E5C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309528; cv=none; b=R+Bg1u8ULtHVoZAaLNTabTPssLpdLtZbBetGy5g7Sm7v3aatlAvZDNAVmoITLdO9Gj4Yv+rgli5IH9WhJdBjzTCwm8PObaoy+9snQuzAbl9NXf7veR1Pz2Zs17JCUV66cGysQqYUK+2nEdHXqkgAvDQ9PU29e9Anp6GkSxNo1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309528; c=relaxed/simple;
	bh=/p97CHZTchgZ2x/w77sCPBCAKYLVfRuzWu9KdaEGTW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmHKdOd0FsmpDoPI+EV95yAxNfwr7eRm18O4NDJ7k1hZtC3zWHcfV5LvjOZpzOU8eQYNf5e0FjuNX0uB8TcoWhnxkfgdJNt10vF47JrSRW7RMkpm3te5+HfUW3hI9lnUGkanzOHM5JiX2BrZHh2Os1eErHu5xkPB0SW7msSvw10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEKV1W0z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756309525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDqVhSeK1e71j8vG7CPDHZkgMbyJjBHY6Iqx2foqFvE=;
	b=HEKV1W0zWY3TKZKr56tGZ+rXCx+n60O6/vpc3uysTGflLm6l0UpNKw+7rw9TdT4IS2sWS5
	wEvPRscaTQZ3lypCsUL3xIlDwNjOOoJaSGVjXeGyWFxfI1BUZcTq2rmQDtmv66pFZc3jZt
	fjuG2veJYIxtTARGzGqEm2ByNbxzeGU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-y21-L0h3OE2FB9iGB2DbDg-1; Wed, 27 Aug 2025 11:45:23 -0400
X-MC-Unique: y21-L0h3OE2FB9iGB2DbDg-1
X-Mimecast-MFC-AGG-ID: y21-L0h3OE2FB9iGB2DbDg_1756309522
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7f2942a1aa1so279077785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756309522; x=1756914322;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDqVhSeK1e71j8vG7CPDHZkgMbyJjBHY6Iqx2foqFvE=;
        b=oZc+o3wYrnYYlAmHRxM7Bx+M+l4El9ysszlCul0mn+G7jMPaKOEd0QMiAwSIZlzXf8
         TvImz0iVFed26y8cffglN5X2yLDqCSGy/aLzhyTZXrxxTP6ZmqsjX+QplGvGDoK/p3zK
         g2wa8qPMSPDt8lMPKHKIjw3GdpkkhT3AEcL+zcnguWK1R5BlSJuuOJJf/LhLc8RpfzCf
         2ERxJNfTfTYBDTdHijmmqu3UaSbGpyJqtZ6LdB/j/mPmkYpo2b8XegWQaPLIkgSjrrTY
         MUikR+va8RRpUVWLeMlZykQ4NwJVKQdXicJLAQpYOQT2lY2iL2mLs1nqBWrlpdSrSEvz
         nkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWFPqsOQVN3gte7ceAJ/AJCCejw2/TCefig5eWSGmUBwxvgnpt1nHxNP956baFNhzLwhbvQVL4SV1vCxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnYck9lvVaUvFrjjAhiose0iWAoGMmx79jquoURtpFUHXUIDD
	P2HXE87sbXAmcNPSE3ChncUvbdo033WD3vRF5lPIucPYBjSoDt4VSMRS43KEV45fVL0U6My6ZSa
	/iM2107EHw2v+S3Z9AUxd8Wf3GKUcK0scww/Wq4gJjKf+S75vwujGFIpnpdBffHmlnQ==
X-Gm-Gg: ASbGncvVtLUI9rJ9pYLpIrlO4yk3lGLDYmwGe8wPo+p/BOTlVfiWvfGsQyM7cVeBmz/
	qgfjUJCGYSlW6wbLtmOiKUJQZaPvQacSBJmNB+5W0PPfZaUmLJmvj7hmJE7qmZyDc7yQikvmSm3
	5/j4pO8BfLSXvrQltvvn3v5wGCeWlqh8/Y05OZKDSbWpchj82jt++aK1txeILZjO3dRG1LyT9me
	XNzDaT51LRJIHVJvZEa6qFZqt5nkQeyV0QD/xeyGwviedAJxhEsD33c5ibO+FWeWbyCcUg4kLut
	V/OsmApt5CFxdDL6GGGL6exADXBvdWPxF+LYAIEiyxgUdelgrKT+Yhz+N4gHiyQIhQTIRf2Mwxo
	mV9c3XI3Eqx3++3qTXe4=
X-Received: by 2002:a05:620a:3709:b0:7e6:9753:d959 with SMTP id af79cd13be357-7f58d941f00mr677233285a.4.1756309522436;
        Wed, 27 Aug 2025 08:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmUGjZymg97kwzbvc9Ng0QsbL1xmqeZFpXH0SyMzHjWziskdn6bTnadHzycYk8K6ZKteAcMQ==
X-Received: by 2002:a05:620a:3709:b0:7e6:9753:d959 with SMTP id af79cd13be357-7f58d941f00mr677228485a.4.1756309521893;
        Wed, 27 Aug 2025 08:45:21 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8de632csm94044401cf.36.2025.08.27.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:45:21 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:45:19 -0400
From: Brian Masney <bmasney@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] clk: Introduce clk_hw_set_spread_spectrum
Message-ID: <aK8oD6HNw131avjI@x1>
References: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
 <20250812-clk-ssc-version1-v1-1-cef60f20d770@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-clk-ssc-version1-v1-1-cef60f20d770@nxp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Tue, Aug 12, 2025 at 08:17:05PM +0800, Peng Fan wrote:
> Add clk_hw_set_spread_spectrum to configure a clock to enable spread
> spectrum feature. set_spread_spectrum ops is added for clk drivers to
> have their own hardware specific implementation.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk.c            | 32 ++++++++++++++++++++++++++++++++
>  include/linux/clk-provider.h | 29 +++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..48c7a301b72b30fd824dae7ada2c44ee84d40867 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2802,6 +2802,38 @@ int clk_set_max_rate(struct clk *clk, unsigned long rate)
>  }
>  EXPORT_SYMBOL_GPL(clk_set_max_rate);
>  
> +int clk_hw_set_spread_spectrum(struct clk_hw *hw, unsigned int modfreq_hz,
> +			       unsigned int spread_bp, unsigned int method)
                                                       ^^^^^^^^^^^^
Should this be 'enum clk_ssc_method'?

Also can you add kernel docs for all of the parameters? I know it's
documented on 'struct clk_spread_spectrum' below.

What do you think about having this function take that struct instead as
a parameter to match what's on the clk op?

Brian


