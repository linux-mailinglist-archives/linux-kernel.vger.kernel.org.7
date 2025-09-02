Return-Path: <linux-kernel+bounces-797378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14491B40F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9105E6E14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A535AAC5;
	Tue,  2 Sep 2025 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxT/Gj4q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1420311
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849765; cv=none; b=WLr21LVs717DAiLKkqzQgwOwD0Wwb21e34IOjjeE4gOIjT2nCPzjpJUULGZEjdtjFX2AuH9hdozzzIrnpWRZk9dgsMAsH6sKjcL/pUybE81c4Zu+eHxUHoS08SYU3yXq4aQo9P7vmVzh5xTddR1pdOqI753bnMV+KTrpCHu90PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849765; c=relaxed/simple;
	bh=neN4/Xko4YcDJzuw40O/2fBeVJJQtw7JPWEFeXXUNzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoQ8zlOoZZbnlfMQ5fazhCGXhWpRr75H0eJ8vuSo6e1igjz5/a0GiiPHQzyNTTJhSLuZ1RsfBd2pi0rIZolLxHMl64QYuBGSu7XCxm3+h6FjmS0Qh76/5hgOgfOkcGF1uR+MroegY4uEBwGxulg0cwrLUYJ1Ak5Tloy8G13cW7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxT/Gj4q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756849762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsHmX5g0hW2RuOd+pFemlGczz+YYMgcCD+tzI6cEH+Y=;
	b=DxT/Gj4qMk6XPrAdMMvLHM6wCVg+N1kwsv0ie69OmtY1rP/QbKpVDJYnLdvorzaRdZnr4g
	tCX47aMazn0goIu70OmDn6cfmDQ5AvfC0Po0OdOPZ5ykwF/RYX44cp5oiVb74smuoawF1O
	b1tS7/rnY/LAV97Phr8KwJ9spHob+Bg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-8oBHyZz2ODaw8-MPJ8foJA-1; Tue, 02 Sep 2025 17:49:20 -0400
X-MC-Unique: 8oBHyZz2ODaw8-MPJ8foJA-1
X-Mimecast-MFC-AGG-ID: 8oBHyZz2ODaw8-MPJ8foJA_1756849760
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7222232859fso10973986d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756849760; x=1757454560;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsHmX5g0hW2RuOd+pFemlGczz+YYMgcCD+tzI6cEH+Y=;
        b=hF/WofSfkjEk5shR/HCAboWp/J2ZbN9nLEgk0c52pg9VQjh4MgAZWTK4hzM2JhJQ7X
         E8toffTnHJ8o8Km5iG2PZKKTHUvmjO6S1j0lVnW76CXt36NGrBOYWOQ3hwvKE6S6pHST
         ViGbkj4O7qyTAADfVyMy9yZe+wbOqCbNvlp06POXxrPsW7qUALajUgEKlu0nvcvmoVW8
         bxsxhZWbHacDhIClCRU3V7HGdAMr1MrBfoUWvAry7gkBy827nYkDSdw/e/uEADOHh0WW
         wc6Kz3m0hxQNv81AQbdHfRrjZDiBQk2jM1k1b5WQCS/20veLV5tOe6slwdwJAot3DCBT
         J/WA==
X-Forwarded-Encrypted: i=1; AJvYcCUxnYPqh5mGwpm10A/+3xpjY4YYd0Hi8g3xoyYlVll8G78CgtF/IwbVFcOIp2tK2LZupEhPml/XTGXrdwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsdSciv2V1trPo/x16/Wft0a4TfTwpOSD7Zl1JG7J0Dbri3LoV
	dKuBrUdMbKVcMugsF3oTHxPHs83Aund1YdJlWmHw7d0jqomwq756v3jXT7jrnYjarNHnztovk7P
	lEUFWufgL8aT6NG8u/Upj1GK3LHPLBftU5Ilp32Do4X18k0BjLb8HaEUfOlFhRZFmSA==
X-Gm-Gg: ASbGncv0QxWszrJSEn6PqbvZ7c+IZUIqBIMVGihquIfxIxs8xsAXVL+njinFZcpYnz2
	Y3ULX389a8RyHSFMvXPZzx3IGGABye78XWI+5ukm3HVrKhOhqYK8uAv8pLYtXc8Ol1rh5O3peEi
	HZkb9PhmaKZNPbVpsiop7CvgGO/6lzqR/Cz47Xn4Hs22eefbW23UEfJNfnYXcWYEZGqSfPkyRyS
	k4GzqOlL2B5LMTfs38tZtcbPXYplwsGVPeWQsIOjLtWWbPVzlv+LGg+jEtuu9UcSzTMddj0JVgt
	KxklTWDaqBMeAAAvvJMS1K0UdJ36/wLlL1IVWiTHQsVvOuXAPCtwf4Gc+8bAoTXk28231z1o+xf
	TdYojkF3KBhbmRLl8qsY=
X-Received: by 2002:a05:6214:c67:b0:71b:f511:7228 with SMTP id 6a1803df08f44-71bf52ff870mr81595586d6.51.1756849760163;
        Tue, 02 Sep 2025 14:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwgG5MrCRiY+YEj7wHA6pGiT+So5GhjsjCrEdcrEastQ86ZBZAbzbVRYsDLAAf8z1862oXzQ==
X-Received: by 2002:a05:6214:c67:b0:71b:f511:7228 with SMTP id 6a1803df08f44-71bf52ff870mr81595306d6.51.1756849759591;
        Tue, 02 Sep 2025 14:49:19 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b475d63asm18667696d6.48.2025.09.02.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:49:19 -0700 (PDT)
Date: Tue, 2 Sep 2025 17:49:17 -0400
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
Subject: Re: [PATCH v2 2/3] clk: conf: Support assigned-clock-sscs
Message-ID: <aLdmXcdJnoeXEJaQ@x1>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
 <20250901-clk-ssc-version1-v2-2-1d0a486dffe6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-clk-ssc-version1-v2-2-1d0a486dffe6@nxp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Mon, Sep 01, 2025 at 11:51:46AM +0800, Peng Fan wrote:
> Parse the Spread Spectrum Configuration(SSC) from device tree and configure
> them before using the clock.
> 
> Each SSC is three u32 elements which means '<modfreq spreaddepth
> modmethod>', so assigned-clock-sscs is an array of multiple three u32
> elements.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk-conf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> index 303a0bb26e54a95655ce094a35b989c97ebc6fd8..dd6083597db3f8f27d86abf5640dfc3fb39a9b88 100644
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -155,6 +155,71 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
>  	return 0;
>  }
>  
> +static int __set_clk_spread_spectrum(struct device_node *node, bool clk_supplier)
> +{
> +	struct clk_spread_spectrum *sscs __free(kfree) = NULL;
> +	u32 elem_size = sizeof(struct clk_spread_spectrum);
> +	struct of_phandle_args clkspec;
> +	int rc, count, index;
> +	struct clk *clk;
> +
> +	/* modfreq, spreadPercent, modmethod */
> +	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
> +	if (count <= 0)
> +		return 0;
> +
> +	sscs = kcalloc(count, elem_size, GFP_KERNEL);
> +	if (!sscs)
> +		return -ENOMEM;
> +
> +	rc = of_property_read_u32_array(node, "assigned-clock-sscs", (u32 *)sscs,
> +					count * 3);
> +	if (rc)
> +		return rc;
> +
> +	for (index = 0; index < count; index++) {
> +		struct clk_spread_spectrum *conf = &sscs[index];
> +		struct clk_hw *hw;
> +
> +		if (!conf->modfreq_hz && !conf->spread_bp && !conf->method)
> +			continue;
> +
> +		rc = of_parse_phandle_with_args(node, "assigned-clocks", "#clock-cells",
> +						index, &clkspec);
> +		if (rc < 0) {
> +			/* skip empty (null) phandles */
> +			if (rc == -ENOENT)
> +				continue;
> +			else
> +				return rc;
> +		}
> +
> +		if (clkspec.np == node && !clk_supplier) {
> +			of_node_put(clkspec.np);
> +			return 0;
> +		}
> +
> +		clk = of_clk_get_from_provider(&clkspec);
> +		of_node_put(clkspec.np);
> +		if (IS_ERR(clk)) {
> +			if (PTR_ERR(clk) != -EPROBE_DEFER)
> +				pr_warn("clk: couldn't get clock %d for %pOF\n",
> +					index, node);
> +			return PTR_ERR(clk);

This chunk can be replaced with dev_warn_probe(). Sorry I missed that in
v1. Otherwise the rest looks good to me. With that fixed:

Reviewed-by: Brian Masney <bmasney@redhat.com>


