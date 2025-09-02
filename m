Return-Path: <linux-kernel+bounces-797385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CBFB40FCE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A05E7E87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776C21CA14;
	Tue,  2 Sep 2025 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8ALRLwb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0552C13B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850481; cv=none; b=HdcyW5RvLdsUOWnHRyi+cZgwvqPDiV5QkGHjOTlAhxIfTiJ441iuOE2Rb3OdQ0XjAMtFUI+/5uI52VQUjuT5+OA9BOu+8fwu8PXzpD5nyMFmIVGNkG2kd83VS8w6/fUroA8eN2AR8Fi7KoQGQsqezuivomjgIzp1xOC1l2P2Qxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850481; c=relaxed/simple;
	bh=1N0OiT1hYOKXa5OlHLueqrsCjuk6IWGRfgcwjdOYwNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bswqXxIdzGID5GMn6pMWUF4G1+GQhFPf71+AldhaG+KFlM/YAeT9/gt5EkcFQuB9n+MQNS/9Zs+NPCq20vbzfuqu2Hh257I+N6fEn6AYhM30w2GW7L+QJkuksO/9eXk5J2V52As+wTB97jSRKruMALlnySXL9bIyKHdWAd8QtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8ALRLwb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756850478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SovXZeidkxb+f2nxu3IUvrmsRI1+mbgwRLBssLQhxNA=;
	b=S8ALRLwbPrEbayi92AyR/gIYcU0iCbP43z5Yt+LFxAK4uTJZGyjhyDLh1QgEpAIghpZ8y7
	+ICxLOTG2B2bI6FR9941VNVc2QcotH1NNzA1dtdFt+rRl/af7Tamnlqywhl1cYs+TFVzZR
	cjvpU5zsBOyGfVRGgwZX/T7p9qaGbtY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-tk8OBq1gMSi-8UL-2avwrg-1; Tue, 02 Sep 2025 18:01:17 -0400
X-MC-Unique: tk8OBq1gMSi-8UL-2avwrg-1
X-Mimecast-MFC-AGG-ID: tk8OBq1gMSi-8UL-2avwrg_1756850477
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7f7742e718eso527478785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756850477; x=1757455277;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SovXZeidkxb+f2nxu3IUvrmsRI1+mbgwRLBssLQhxNA=;
        b=UX4CH0sJ6L4ELowFIscOMAZUH18gBIQXJqOLBsWIhPnQ1ZnLlJq4zPpMf3WPu6rQCU
         TaQg/sNfJ9Ii4rDadNxbztHFfe0gcZd387KqP5Fxth87WzAWPDu/P6nHT0zl9ex+7pa/
         mFfqja8j6U068bo+d+5pt0TnoXdmV45YvwYDeq5dr/MvWsgE4QpVrmLtC2hiIS99564H
         9nKNmFCexf/IPKY0FgWunMwS1kdzCAFXlomebHRmOS2plugM0a0sEE/BdQ8e8d4S8UtI
         KvnjBha2st3s0DulvbkO/mVisDrcA0p8o5fxfrajvLnJiKgh1IAJdBxaCF8g+2lKfylz
         Odrg==
X-Forwarded-Encrypted: i=1; AJvYcCWZaMMi+oYisxnqvPXkKjS9ZKWxVXJv14+XjVT+RivY4wnLEaSii4h078Ie1FAfrLWD2vK5OP/Rf1qpl7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMbrfFQ9WzRA7tSh2rf4BGLHKWNV2aAdVli47zXfJPPHXQtmc7
	XZOaSynsP3wXirZvP0nyg7/r0lu79IuogsdPA7kyA/g81UsetzmUbF2S+U2dCi2pzHhKHZpwBTX
	4wySF5TYi3lVqVt1cKx9HZ3PXxoVbqYEtovVXykQGc3OVV+NqiVjGquHOzSo+U1UoQg==
X-Gm-Gg: ASbGnctrQ7km5nw0F+v43R56EvtEtxHnUVx0VK2iSJIhILL7YloHYUr605MZDm268zh
	omuUCe7u29bEX78kdUjWDk3G3AkVpKS4/ueLOY5uSYqSrTnzV4yhdcsoqUzKjEUBLxqzrLe+wtj
	HARuXq1Bo0pT0uO3rlyhKZqdegIM9aISB46oe+nm9FB17mzASuJ/E0wQ06g71msNbkohD7qwYVW
	Zn19wb9hcPr8fUDP/v5hIGJ1vq5EErB4I4NiQqy2aTz0WdjwuExUvrlIIhi5d5CRvcEW37ImVcc
	o9Osp051ZapbmqGNQkIz7HgSsL9i04maOenW+hM/RdmDUIR5wSefX4TJUvhfew5lr+9mCEVxME3
	2ziGARLLVIt4QOjBaUj0=
X-Received: by 2002:a05:620a:3182:b0:7e8:6955:90fe with SMTP id af79cd13be357-7ff2aa225d7mr1459466385a.42.1756850476984;
        Tue, 02 Sep 2025 15:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0PC62ojWiM/vLd9z8Xwp9bJyLjgplk2IMzQjw47Isk4CcYNDohrklNKP/ZniSDGJVijAGoA==
X-Received: by 2002:a05:620a:3182:b0:7e8:6955:90fe with SMTP id af79cd13be357-7ff2aa225d7mr1459458685a.42.1756850476355;
        Tue, 02 Sep 2025 15:01:16 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aaacfeb4bsm15561385a.41.2025.09.02.15.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:01:15 -0700 (PDT)
Date: Tue, 2 Sep 2025 18:01:12 -0400
From: Brian Masney <bmasney@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] clk: Introduce clk_hw_set_spread_spectrum
Message-ID: <aLdpKEwfqP448eMd@x1>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
 <20250901-clk-ssc-version1-v2-1-1d0a486dffe6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-clk-ssc-version1-v2-1-1d0a486dffe6@nxp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Mon, Sep 01, 2025 at 11:51:45AM +0800, Peng Fan wrote:
> Add clk_hw_set_spread_spectrum to configure a clock to enable spread
> spectrum feature. set_spread_spectrum ops is added for clk drivers to
> have their own hardware specific implementation.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk.c            | 26 ++++++++++++++++++++++++++
>  include/linux/clk-provider.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..06db8918a1b35e3280e565272bc4603a88295a92 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2802,6 +2802,32 @@ int clk_set_max_rate(struct clk *clk, unsigned long rate)
>  }
>  EXPORT_SYMBOL_GPL(clk_set_max_rate);
>  
> +int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spectrum *conf)
> +{
> +	struct clk_core *core;
> +	int ret;
> +
> +	if (!hw)
> +		return 0;
> +
> +	core = hw->core;
> +
> +	clk_prepare_lock();
> +
> +	ret = clk_pm_runtime_get(core);
> +	if (ret)
> +		goto fail;
> +
> +	if (core->ops->set_spread_spectrum)
> +		ret = core->ops->set_spread_spectrum(hw, conf);
> +
> +	clk_pm_runtime_put(core);
> +
> +fail:
> +	clk_prepare_unlock();
> +	return ret;
> +}
> +
>  /**
>   * clk_get_parent - return the parent of a clk
>   * @clk: the clk whose parent gets returned
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 630705a47129453c241f1b1755f2c2f2a7ed8f77..251035a96244c34ff2cbaaa349a08f4ea094e7fc 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -84,6 +84,24 @@ struct clk_duty {
>  	unsigned int den;
>  };
>  
> +#define	CLK_SSC_NO_SPREAD	0
> +#define	CLK_SSC_CENTER_SPREAD	1
> +#define	CLK_SSC_UP_SPREAD	2
> +#define	CLK_SSC_DOWN_SPREAD	3
> +
> +/**
> + * struct clk_spread_spectrum - Structure encoding spread spectrum of a clock
> + *
> + * @modfreq_hz:		Modulation frequency
> + * @spread_bp:		Modulation percent in permyriad
> + * @method:		Modulation method
> + */
> +struct clk_spread_spectrum {
> +	u32 modfreq_hz;
> +	u32 spread_bp;
> +	u32 method;
> +};
> +
>  /**
>   * struct clk_ops -  Callback operations for hardware clocks; these are to
>   * be provided by the clock implementation, and will be called by drivers
> @@ -178,6 +196,11 @@ struct clk_duty {
>   *		separately via calls to .set_parent and .set_rate.
>   *		Returns 0 on success, -EERROR otherwise.
>   *
> + * @set_spread_spectrum: Configure the modulation frequency, modulation percentage
> + *		and method. This callback is optional for clocks that does not
> + *		support spread spectrum feature or no need to enable this feature.
> + *		Returns 0 on success, -EERROR otherwise.

I think it would be worthwhile to call out in the kdocs that this helps
to reduce EMI. How does this sound?

@set_spread_spectrum: Optional callback used to configure the spread
		spectrum modulation frequency, percentage, and method
		to reduce EMI by spreading the clock frequency over a
		wider range.
		Returns 0 on success, -EERROR otherwise.

Everything else looks good to me.

Brian


