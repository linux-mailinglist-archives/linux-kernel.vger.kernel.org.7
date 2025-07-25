Return-Path: <linux-kernel+bounces-745471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D6B11A72
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723F43ABBE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D75F254AF5;
	Fri, 25 Jul 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pQw2vktH"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631824886A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434128; cv=none; b=TntFQqrp8WRAdb9aCpFQpwIGiP2gl8nIrP1nXpL9ZVria4UZWPAc+VQSDH2ovnucbah+TBVmMCCXDlHmSRtU4zOd8Tj6L7APyyWAo3HnHigfIbxilx2mLYm1iNjbSyRXionWQ+Snl2G/4fpcUQwv46I740AA4puZ0Pwru1Nt0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434128; c=relaxed/simple;
	bh=cD4wUVo/vbQVM6nWfwdPMyfvlFCUGoiwmbISWLR+Smg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWrCuTIdZzWU4XQMwysEVADPX2oDqQiacJaXJeBwlmeEPWCQ1RyGXYq8jSlvUbJbLso+bSB8olV4lqjs3GxIWXJL+gIq6ukZCIR0sX6omxBGu07Mn2sGiRYopntFZl7utKQljHcY/KLUtBMIOssJlvns3asUnsLJDawa3fTFgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=pQw2vktH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0de1c378fso257817266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1753434125; x=1754038925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZpbSWBE7SN1ByG284oM5dg+KrDkwDu7o6HtVen04Y0=;
        b=pQw2vktHvUHA6GOaoidIdxPvTvC6LVMu45TeXBG7I1YGCHLxghaYQq6z2VWJ2IRWOj
         iOLBBNpWRvdrkKBH9FB9NKzZ5n9bpUkjDyNc148ZVsLR6K40ZyE6hWHSeUtEz4fH+NAh
         yxy9VCizFDNKvHr20yKXSif28PRLvIaXus+Y28mIBGxxDFooJHZXcws/KQza3OZAydx6
         lQPWFA32IwdPRPYT1tfRxiYQedlRGg0Gl3idqtIPTkKNwc+tpt0uNTFaDMEoiN6wwRa6
         +CmadrvBNnaU4OGWZcjahkK9hv/x/YG7vrstqpaIDm7npL0Lxkhr3jps9Qmhkr9gfHs0
         F2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753434125; x=1754038925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZpbSWBE7SN1ByG284oM5dg+KrDkwDu7o6HtVen04Y0=;
        b=NHyUVdZ9+Qj78LylwHBe6XeCjh9kIJgC9ZZaxkiKiXVfZ4eU/oi8njXka/jI1+Hh/g
         yEPEHBPsH/3qr5tZsK5GLRdQb2S3cUdbyqIYddXbqVTEIYB4x6aKt/LNXo88wPUCSC+t
         SkFAUX7XH4228/iBdxbbiPxmm6/XW7Xd1enKrazFumY6U4f67dyMRaTkzrbED2oXfGDO
         hCTrQTgGWAgjKUhUicF4MwJJh2TDWqpvPrO13nh8e4WzaU8GV2BYCO9MHAZAd4PN7cnG
         EsSzWT6g0rADrezNA2WtNvk76qFysBqOHSgVVd/r6uxV+gd2EKQdfBrm50RrcD9jtlGV
         IEyA==
X-Forwarded-Encrypted: i=1; AJvYcCWt3N36FWOZdyX2oIFbV1bebiA0QlpJ6iQkkUth5qrLhbGeTOxuDSRnEROH6I/pMZa+Y9aUEWStnbS+YJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbfRssGzCv7v8cBh2zLkL2HUgEohl25aOZKRgBpZWOJtP7M8AE
	WssM6b5fNSLfl/ZadGCNwBAzDhgWxepJ1AyV5XIKBDERh9n+cVKj0l/GKl73kePzYtY=
X-Gm-Gg: ASbGnctkhZvidyyoRt01gzY8ynQ+xQ3VRGKJ4PLqZsX/4FT61j6Ab2YsS3RDIrq4Vlg
	t0qg00DxY2Dv76qKEqFHoJCn9G31OqPXSrNuTr7pUc3JIyywMfdT08p+cq8JtrBgWWGTm6JkrRD
	FQgdqynxGm35LljfVbE/ikUCUFxbkinWP0wFBIVLxZNOS2m7xz5xZ0AfPxEOAVENvMhfsiSBMYH
	pPA59viVUsDsHBxdSCjLvDW7caTGeiRGbqnw21eJe8tWdD0amX7oouUrBpYzHNVVd3VO9zYt6AN
	VCzK3NFQAUm5WzdHFTqQTWT/bUKX62H21ToBui25GRiMz7MVspS0ZzdH2iIJ288PWqHAkfqtaa1
	5tXA/AVL+GbKgeUfVLaR5ffCzmqCt8PNbVStaNrWNHsOpTyLEoI0X8QwLgTGh8nN2
X-Google-Smtp-Source: AGHT+IGywcyCdmfJvRsAO8dl073J5Gfa54nQQ0N0SlnERuU+rTuw0R2baPIBOQdnizxdHQ8swdzxQA==
X-Received: by 2002:a17:906:7315:b0:ae0:bee7:ad7c with SMTP id a640c23a62f3a-af61d37d714mr168915566b.46.1753434124572;
        Fri, 25 Jul 2025 02:02:04 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47d53dcbdsm240527766b.61.2025.07.25.02.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:02:04 -0700 (PDT)
Message-ID: <d5b2f8df-8a2e-4319-809a-ec06d8381038@blackwall.org>
Date: Fri, 25 Jul 2025 12:02:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] bonding: support aggregator selection based
 on port priority
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Alessandro Zanni <alessandro.zanni87@gmail.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724081632.12921-1-liuhangbin@gmail.com>
 <20250724081632.12921-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250724081632.12921-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 11:16, Hangbin Liu wrote:
> Now that per-port actor priority is supported via ad_actor_port_prio, enable
> a new ad_select policy to choose the aggregator based on port priority.
> 
> This allows users to influence aggregator selection by assigning higher
> or lower priorities to individual ports.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/networking/bonding.rst |  9 ++++++++-
>  drivers/net/bonding/bond_3ad.c       | 29 ++++++++++++++++++++++++++++
>  drivers/net/bonding/bond_options.c   |  1 +
>  include/net/bond_3ad.h               |  1 +
>  4 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> index 5e105e7ac8e6..a234ec12ece7 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -250,7 +250,14 @@ ad_select
>  		ports (slaves).  Reselection occurs as described under the
>  		"bandwidth" setting, above.
>  
> -	The bandwidth and count selection policies permit failover of
> +	prio or 3
> +
> +		The active aggregator is chosen by the highest total sum of
> +		actor port priorities across its active ports. Note this
> +		priority is ad_actor_port_prio, not per port prio, which is
> +		used for primary reselect.
> +
> +	The bandwidth, count and prio selection policies permit failover of
>  	802.3ad aggregations when partial failure of the active aggregator
>  	occurs.  This keeps the aggregator with the highest availability
>  	(either in bandwidth or in number of ports) active at all times.
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index 4a1b2f01fe37..6f8a406ed34a 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -747,6 +747,20 @@ static int __agg_active_ports(struct aggregator *agg)
>  	return active;
>  }
>  
> +static unsigned int __agg_ports_priority(struct aggregator *agg)

const agg?

> +{
> +	struct port *port;
> +	unsigned int prio = 0;

reverse xmas tree or alternatively you can save a line below with
port = agg->lag_ports above

> +
> +	for (port = agg->lag_ports; port;
> +	     port = port->next_port_in_aggregator) {
> +		if (port->is_enabled)
> +			prio += port->actor_port_priority;
> +	}

minor nit: {} are unnecessary

> +
> +	return prio;
> +}
> +
>  /**
>   * __get_agg_bandwidth - get the total bandwidth of an aggregator
>   * @aggregator: the aggregator we're looking at
> @@ -1695,6 +1709,9 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
>  	 * BOND_AD_COUNT: Select by count of ports.  If count is equal,
>  	 *     select by bandwidth.
>  	 *
> +	 * BOND_AD_PRIO: Select by total priority of ports. If priority
> +	 *     is equal, select by count.
> +	 *
>  	 * BOND_AD_STABLE, BOND_AD_BANDWIDTH: Select by bandwidth.
>  	 */
>  	if (!best)
> @@ -1713,6 +1730,14 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
>  		return best;
>  
>  	switch (__get_agg_selection_mode(curr->lag_ports)) {
> +	case BOND_AD_PRIO:
> +		if (__agg_ports_priority(curr) > __agg_ports_priority(best))
> +			return curr;
> +
> +		if (__agg_ports_priority(curr) < __agg_ports_priority(best))
> +			return best;
> +
> +		fallthrough;
>  	case BOND_AD_COUNT:
>  		if (__agg_active_ports(curr) > __agg_active_ports(best))
>  			return curr;
> @@ -1778,6 +1803,10 @@ static int agg_device_up(const struct aggregator *agg)
>   * (slaves), and reselect whenever a link state change takes place or the
>   * set of slaves in the bond changes.
>   *
> + * BOND_AD_PRIO: select the aggregator with highest total priority of ports
> + * (slaves), and reselect whenever a link state change takes place or the
> + * set of slaves in the bond changes.
> + *
>   * FIXME: this function MUST be called with the first agg in the bond, or
>   * __get_active_agg() won't work correctly. This function should be better
>   * called with the bond itself, and retrieve the first agg from it.
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 2b8606b4e4f5..708ca1f18a00 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -163,6 +163,7 @@ static const struct bond_opt_value bond_ad_select_tbl[] = {
>  	{ "stable",    BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
>  	{ "bandwidth", BOND_AD_BANDWIDTH, 0},
>  	{ "count",     BOND_AD_COUNT,     0},
> +	{ "prio",      BOND_AD_PRIO,      0},
>  	{ NULL,        -1,                0},
>  };
>  
> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> index bf551ca70359..34495df965f0 100644
> --- a/include/net/bond_3ad.h
> +++ b/include/net/bond_3ad.h
> @@ -26,6 +26,7 @@ enum {
>  	BOND_AD_STABLE = 0,
>  	BOND_AD_BANDWIDTH = 1,
>  	BOND_AD_COUNT = 2,
> +	BOND_AD_PRIO = 3,
>  };
>  
>  /* rx machine states(43.4.11 in the 802.3ad standard) */


