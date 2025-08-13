Return-Path: <linux-kernel+bounces-765960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1D1B24097
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592A71AA3B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7552BE05F;
	Wed, 13 Aug 2025 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWyJeYc5"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB802C08C2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064134; cv=none; b=RKHROlnDOnWwZT9SY4vFgN4oZQJn2QJ/FgFVaUEYHc2M4ylFj5HQMck4FiBcSJgKXNiSMydbXAVRpIOlZbN3z5cEDGAVwWnL4H9uB6Uf6S7Zm0FtraJACzEfZngotHikgx2c+7n6Farb003g/tQRReB2i4wvLCH/dzfD9o9ThAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064134; c=relaxed/simple;
	bh=0IyPMQRVWg5ixL3LBlEz+Tb1fH/4h9rT/zzQCy59j1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKfvDxuew2Vo43jTWLMhoJZjtZYLY9j7Of4KLaCF/z5xGlC1Eza9acct2An3WVMaE/te1o4G+BGZNy5X3vFzWijXQ3sHn/Xt8lfpZQVSRV0j61zdMHzFBUtEeEWUAhxm+YmVQFgrY5iF0S5oq7UFObS0NZLdu3bTD4MRaw2fuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWyJeYc5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459d40d16bdso39560875e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755064130; x=1755668930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=br/KFQMisLWNAK11Jh+i4JA1Nu+Hjv1i9FwCDI747D4=;
        b=mWyJeYc5JZX5QlS57FbJ35QUJ57T468ArYypNSifEE8botp4pS9Q8YAmMyWUry4cSm
         VWxPQW2/WA9lkUlXYbY0VNJe31O0ZLmqlrU1sbny+zUyAJvBD9AW7Voc/KK8ibUwor6U
         piuSNOhL2uopz9THUX5cDcww8yL0DmInr0W6QSIsNV1kg4IioNu84j9v+OdLzOebiP8o
         tLk9A0JXSrQo/pFfNQAiJzMBkAJPdL3WXKL9ndesLdr7xYzJk13Iq4US634jlDJA5ynh
         BNYXXoAVyZf9Phod/VfYqlmr7cyMguHYAN11+28VR/oWj3SUztVASJ8alXjshDbcNEsA
         X4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755064130; x=1755668930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=br/KFQMisLWNAK11Jh+i4JA1Nu+Hjv1i9FwCDI747D4=;
        b=nXRATorRfmtgA9/jZeJttJxOBcpvKWoDE+VydkAsboACtyCXPwtOH2sfV4k+YbhC8+
         Jq2m9DDDyhiHGnTGtpwpNzrfrvGJ7+kZf9QwKimpaoTgcrZZYeE/NZ4+Hzy7+BDWIJZx
         oPeVLHgBiFxZsuvmHgEcXtq7j/Nt1pauBFGT+HUZFvc3xVGHSbUcSuwCbKcVDk9Sd6ln
         eAOjvGild9p6wdr4oYhtqa++oFM5ZMkLfYjcUJBCapU5tnycp9RKgytKb9n+Up8QAOFF
         yN/xu356wkFITI+rO2Zn9j1X5wP1hfoMNbJduJRhdwK9JmBbcFkwQHFzIUrYT39uGkI5
         OAKA==
X-Forwarded-Encrypted: i=1; AJvYcCW866rtROxpBMX+8mWH9AooxmGmkBMxWJb/ZbDZtZdgrMKOEqtPPaifKuusSAcaqCUNvdSCHQq9bRvxrg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/czrLnxlSQ1jS0oDmVgFUzZBtQW3I75DLfkjhYCM9EyFQID4
	TVmIknJE+sGsTi3gcmOpBMsGATzlEFnZtuZHiBlQsfgO88oezE90ULu1N6fbSmWGBKE=
X-Gm-Gg: ASbGncszy1BXnWpuNkk/WOaFxg2bSpsP9HPIkmgUM1ND0zOaTHCCxXnVgRn/fkaLunb
	535pA5EzT/YPFMrGGzHRUJ54RIjB8UmwJuObbHV8LfD4fXmY36BBaN8xl3WvKySc4M3adW8NiKQ
	OiopQcnK89pYAv7U8+1z3yPmn6BPwKhxu/WTIlw8LN11mMKmEMDectFQpb9SF//as5Ye0NKE44S
	QCFHBgf/ZWnAneCWU7z28+x50IMSzd5gmKG9CGHGRpQ5/rrxnbgrzQ7Aj2IEyWJNAXKKf0/Fu3o
	CO+LEzSg4AfaV08HUJ3wPnvBjCp+Y3UbXygpqg2yAmNu6tSVUzajUJ158RShLKuMm6mjwOAzDtY
	hS8Z2Xss70PhoDHvgnDIJcS++z3GUszCjZiGhdw==
X-Google-Smtp-Source: AGHT+IFcMDTK7Qu4ZC7nlXttWooxXbJSLLV2zHBxtvmzb4Q3sahk0UhmGPH7DhFAOinlsQYal8xNDw==
X-Received: by 2002:a05:600c:1649:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-45a1787a29emr3451565e9.3.1755064130316;
        Tue, 12 Aug 2025 22:48:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3bf93dsm46609898f8f.27.2025.08.12.22.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 22:48:49 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:48:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] clk: conf: Support assigned-clock-sscs
Message-ID: <aJwnH2mlRdqp1K1u@stanley.mountain>
References: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
 <20250812-clk-ssc-version1-v1-2-cef60f20d770@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-clk-ssc-version1-v1-2-cef60f20d770@nxp.com>

On Tue, Aug 12, 2025 at 08:17:06PM +0800, Peng Fan wrote:
> Parse the Spread Spectrum Configuration(SSC) from device tree and configure
> them before using the clock.
> 
> Each SSC is three u32 elements which means '<modfreq spreaddepth
> modmethod>', so assigned-clock-sscs is an array of multiple three u32
> elements.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk-conf.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> index 303a0bb26e54a95655ce094a35b989c97ebc6fd8..81a2c1f8ca4c44df2c54c1e51f800f533c9453b3 100644
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -155,6 +155,72 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
>  	return 0;
>  }
>  
> +static int __set_clk_spread_spectrum(struct device_node *node, bool clk_supplier)
> +{
> +	u32 *sscs __free(kfree) = NULL;
> +	u32 elem_size = sizeof(u32) * 3;
> +	struct of_phandle_args clkspec;
> +	int rc, count, index;
> +	struct clk *clk;
> +
> +	/* modfreq, spreadPercent, modmethod */
> +	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
> +	if (count > 0) {
> +		sscs = kcalloc(count, elem_size, GFP_KERNEL);
> +		if (!sscs)
> +			return -ENOMEM;
> +		rc = of_property_read_u32_array(node,
> +						"assigned-clock-sscs",
> +						sscs, count * 3);
> +	} else {
> +		return 0;
> +	}
> +
> +	if (rc)
> +		return rc;

Nit pick: Please, flip these conditions around.

	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
	if (count <= 0)
		return 0;

	sscs = kcalloc(count, elem_size, GFP_KERNEL);
	if (!sscs)
		return -ENOMEM;

	rc = of_property_read_u32_array(node, "assigned-clock-sscs", sscs,
					count * 3);
	if (rc)
		return rc;

> +
> +	for (index = 0; index < count; index++) {
> +		u32 modfreq_hz = sscs[index * 3], spread_bp = sscs[index * 3 + 1];
> +		u32 method = sscs[index * 3 + 2];

This math would be nicer if you created a struct:

struct spread_config {
	u32 modfreq_hz;
	u32 spread_depth;
	u32 method;
};

Then you could use that instead of sscs.

	for (i = 0; i < count; i++) {
		struct spread_config *conf = &configs[i];
		struct clk_hw *hw;

		if (!conf->modfreq_hz && !conf->spread_depth && !conf->method)
			continue;

> +		struct clk_hw *hw;
> +
> +		if (modfreq_hz || spread_bp || method) {
> +			rc = of_parse_phandle_with_args(node, "assigned-clocks",
> +					"#clock-cells",	index, &clkspec);
> +			if (rc < 0) {
> +				/* skip empty (null) phandles */
> +				if (rc == -ENOENT)
> +					continue;
> +				else
> +					return rc;
> +			}
> +
> +			if (clkspec.np == node && !clk_supplier) {

Could you add a comment for this condition?  It's strange to me that we
don't iterate through the whole array.

regards,
dan carpenter

> +				of_node_put(clkspec.np);
> +				return 0;
> +			}
> +
> +			clk = of_clk_get_from_provider(&clkspec);
> +			of_node_put(clkspec.np);
> +			if (IS_ERR(clk)) {
> +				if (PTR_ERR(clk) != -EPROBE_DEFER)
> +					pr_warn("clk: couldn't get clock %d for %pOF\n",
> +						index, node);
> +				return PTR_ERR(clk);
> +			}
> +
> +			hw = __clk_get_hw(clk);
> +			rc = clk_hw_set_spread_spectrum(hw, modfreq_hz, spread_bp, method);
> +			if (rc < 0)
> +				pr_err("clk: couldn't set %s clk spread spectrum %u %u %u: %d\n",
> +				       __clk_get_name(clk), modfreq_hz, spread_bp, method, rc);
> +			clk_put(clk);
> +		}
> +	}
> +
> +	return 0;
> +}


