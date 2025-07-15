Return-Path: <linux-kernel+bounces-732533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D6BB06834
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C760A18904D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1892BEC21;
	Tue, 15 Jul 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="pcSIr9jg"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5A246787
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613184; cv=none; b=Y+fELx1hnpAq9RUMwNqCP4qmEy8Ap3mLt/UZWXyXt3k6MGnc6gv0XqBco9DojehHV5HvByfV+EHk9tH+1HLupM51/M3qeMKNMx69i5XyzwBUjV5KVHgVEDyrHJEx4y4EvgheYYHpVP8oqHtrmXZR9D4wlK/tn9w1DROS9RPce84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613184; c=relaxed/simple;
	bh=jK2PJ1pLXHoKPhr1KHcSC8ZcmaKbtsnsQeWzZk5oydU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpuzCjqE3tz/ONfjbeByeZJDsQumjrw4CqtW8Wq96laqLAaaBebsPaA3u55vcdJZ84M+W4f9p7Im4r9WMrwUyxIgTfUPvdnce434p80pzNKio45+aq7Hm/d8YFiaQPimYk/JgyPFn/vUx9Jg+pIXPC4rEhcspQn0ql/M5fFU0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu; spf=pass smtp.mailfrom=vt.edu; dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b=pcSIr9jg; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-41bebd9dd8dso374869b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1752613182; x=1753217982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpLIXS+YHqc5mxGfOSQbNuEZInQXTG4i5qkw5Ltm2ew=;
        b=pcSIr9jgyi0qz6jMEw3Kj0N+o0JdXAhJvjL9aE8lRhKq3Bi6XwtKLTRt3VC0vPgM/Z
         Ieg+9+61MFZbn72asU+Ghm0uWcjxHzZl26i/+RcneLG+V9N/BOztS1mV5LhcM3dkWtxt
         tRKrLq7AVaQg5ROuFXqELVkPPXd2Lcvmab6R/+hGW7oUtWz557LKnI4atsG2W7D09PPX
         LZY68y9GX9h0gveRoFOTt4JLmL5gfvBhAQdjakG8L15cvMoBtex1IVRL8TRDY2OQMaHm
         WTYropf59CMzEywtkC9ArhZkB6kHZFSZn4SHxYAJz0UkS/hA9b3YsSnt26gyqKO/+TpD
         t/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752613182; x=1753217982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpLIXS+YHqc5mxGfOSQbNuEZInQXTG4i5qkw5Ltm2ew=;
        b=fkhScqYnNkgd0HiIHUAGd9VWvstDgK7bEiIaoufjj9843+QVBB/aNb0k9e5+gXKlF4
         O7kXkjBbVXDJEt9TzvEf8vvyp3XVnNfgEBvr0Emd1AgONlwSCjYx0HqH2C2nYpVm+OCI
         SDip9WWfsdp8higli+UGrdVEQDqQUDGsHbSstSultdl8WSjceoufvIoq36+vuP17zFDK
         ZljkSHvvrXcLRm5/Io2maikE/i5Vu4gkeJ/Wyb7PQua+C5edmdwqkXKZZJK2vcfbROkp
         Nn2qwsvJ+XlN/dDcYdZx+5SmsdOv0erN/R6P/PtDP6Ay5iAAgvkGDm1c/KaKBlZv5Cwr
         Is+w==
X-Forwarded-Encrypted: i=1; AJvYcCUE0NbSZN7uR2AzCNKYo7Ppv8hxTk5Rj7byQJ4StH8oPVWFDQfaojyF8UkVXuNogxbe2PnD7aR6iGoSk9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuexHcuXzd/jCr1OjhkipD/rsDTgDawK2EUTnzRpLkI6VaElOm
	9Y15wtUYAFH1eepi5v2zqDIYRYmm7uaHgTlKsPUlatSbG5WDGoExTyPTJrkM6p7MFSE=
X-Gm-Gg: ASbGnctW6HcALy3uSnxUZgdpHMfsqH2+z8Ikzl5X95S0HoU9DFCMuWz12IbksgCKkPL
	1YsIH+/+lDC940Mv/xBvdaNrj/LEbuDEolzLR/GKRuQgAhpwWv8srvuW+IncERsTgRkMOEcF8Dq
	Z82qND0TneaSk1WX5DurofgE19vV4NP1dwGLXq5ZZ/FeBe0mRKk+KppSNxk1gWVgniawhz/5AXj
	5mfK0h5YONdMJJNll0gKSSBA5GfSjqIVwUC3EN2blRuOmKro1KOPWj3o+ysK+dc9tXVogfs7VK8
	uerTHggyQq50mHuc6XoC+6aFZeRBMLwnHJGjAFr+ERzpXy1SRYbVvAQfrDcL0alxHEBplFib6Kx
	sg2KyT96LD/4Oklv8umnbYFPT+dPUafwvsbiRDfPxd97t6GUEONETCACHDXyYR0Uo
X-Google-Smtp-Source: AGHT+IHMuvYgTjdEJouwL9rFNOehORJPx/jwpmcs0VZMmCrB+BtDdM4ygC9BoJ12UmywSThmX7MsOg==
X-Received: by 2002:a05:6808:1814:b0:408:f80a:bab9 with SMTP id 5614622812f47-41d033f488dmr188402b6e.11.1752613181573;
        Tue, 15 Jul 2025 13:59:41 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:68bc:2e93:4664:2a0f? ([2603:8080:7400:36da:68bc:2e93:4664:2a0f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41d05f24034sm42642b6e.33.2025.07.15.13.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 13:59:40 -0700 (PDT)
Message-ID: <c9eac8f6-8e7f-4ed0-b34d-5dc50be8078f@vt.edu>
Date: Tue, 15 Jul 2025 15:59:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from
 counter to jiffies
To: carlos.bilbao@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sforshee@kernel.org
References: <20250715205733.50911-1-carlos.bilbao@kernel.org>
Content-Language: en-US
From: Carlos Bilbao <bilbao@vt.edu>
In-Reply-To: <20250715205733.50911-1-carlos.bilbao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

FYI, I was able to test this locally but couldn’t find any kselftests to
stress the bonding state machine. If anyone knows of additional ways to
test it, I’d be happy to run them.

Thanks!

Carlos

On 7/15/25 15:57, carlos.bilbao@kernel.org wrote:
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>
> Replace the bonding periodic state machine for LACPDU transmission of
> function ad_periodic_machine() with a jiffies-based mechanism, which is
> more accurate and can help reduce drift under contention.
>
> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
> ---
>   drivers/net/bonding/bond_3ad.c | 79 +++++++++++++---------------------
>   include/net/bond_3ad.h         |  2 +-
>   2 files changed, 32 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..8654a51266a3 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1421,44 +1421,24 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
>   	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
>   	    !bond_params->lacp_active) {
>   		port->sm_periodic_state = AD_NO_PERIODIC;
> -	}
> -	/* check if state machine should change state */
> -	else if (port->sm_periodic_timer_counter) {
> -		/* check if periodic state machine expired */
> -		if (!(--port->sm_periodic_timer_counter)) {
> -			/* if expired then do tx */
> -			port->sm_periodic_state = AD_PERIODIC_TX;
> -		} else {
> -			/* If not expired, check if there is some new timeout
> -			 * parameter from the partner state
> -			 */
> -			switch (port->sm_periodic_state) {
> -			case AD_FAST_PERIODIC:
> -				if (!(port->partner_oper.port_state
> -				      & LACP_STATE_LACP_TIMEOUT))
> -					port->sm_periodic_state = AD_SLOW_PERIODIC;
> -				break;
> -			case AD_SLOW_PERIODIC:
> -				if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT)) {
> -					port->sm_periodic_timer_counter = 0;
> -					port->sm_periodic_state = AD_PERIODIC_TX;
> -				}
> -				break;
> -			default:
> -				break;
> -			}
> -		}
> +	} else if (port->sm_periodic_state == AD_NO_PERIODIC)
> +		port->sm_periodic_state = AD_FAST_PERIODIC;
> +	/* check if periodic state machine expired */
> +	else if (time_after_eq(jiffies, port->sm_periodic_next_jiffies)) {
> +		/* if expired then do tx */
> +		port->sm_periodic_state = AD_PERIODIC_TX;
>   	} else {
> +		/* If not expired, check if there is some new timeout
> +		 * parameter from the partner state
> +		 */
>   		switch (port->sm_periodic_state) {
> -		case AD_NO_PERIODIC:
> -			port->sm_periodic_state = AD_FAST_PERIODIC;
> -			break;
> -		case AD_PERIODIC_TX:
> -			if (!(port->partner_oper.port_state &
> -			    LACP_STATE_LACP_TIMEOUT))
> +		case AD_FAST_PERIODIC:
> +			if (!(port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
>   				port->sm_periodic_state = AD_SLOW_PERIODIC;
> -			else
> -				port->sm_periodic_state = AD_FAST_PERIODIC;
> +			break;
> +		case AD_SLOW_PERIODIC:
> +			if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
> +				port->sm_periodic_state = AD_PERIODIC_TX;
>   			break;
>   		default:
>   			break;
> @@ -1471,21 +1451,24 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
>   			  "Periodic Machine: Port=%d, Last State=%d, Curr State=%d\n",
>   			  port->actor_port_number, last_state,
>   			  port->sm_periodic_state);
> +
>   		switch (port->sm_periodic_state) {
> -		case AD_NO_PERIODIC:
> -			port->sm_periodic_timer_counter = 0;
> -			break;
> -		case AD_FAST_PERIODIC:
> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
> -			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_FAST_PERIODIC_TIME))-1;
> -			break;
> -		case AD_SLOW_PERIODIC:
> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
> -			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_SLOW_PERIODIC_TIME))-1;
> -			break;
>   		case AD_PERIODIC_TX:
>   			port->ntt = true;
> -			break;
> +			if (!(port->partner_oper.port_state &
> +						LACP_STATE_LACP_TIMEOUT))
> +				port->sm_periodic_state = AD_SLOW_PERIODIC;
> +			else
> +				port->sm_periodic_state = AD_FAST_PERIODIC;
> +		fallthrough;
> +		case AD_SLOW_PERIODIC:
> +		case AD_FAST_PERIODIC:
> +			if (port->sm_periodic_state == AD_SLOW_PERIODIC)
> +				port->sm_periodic_next_jiffies = jiffies
> +					+ HZ * AD_SLOW_PERIODIC_TIME;
> +			else /* AD_FAST_PERIODIC */
> +				port->sm_periodic_next_jiffies = jiffies
> +					+ HZ * AD_FAST_PERIODIC_TIME;
>   		default:
>   			break;
>   		}
> @@ -1987,7 +1970,7 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
>   		port->sm_rx_state = 0;
>   		port->sm_rx_timer_counter = 0;
>   		port->sm_periodic_state = 0;
> -		port->sm_periodic_timer_counter = 0;
> +		port->sm_periodic_next_jiffies = 0;
>   		port->sm_mux_state = 0;
>   		port->sm_mux_timer_counter = 0;
>   		port->sm_tx_state = 0;
> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> index 2053cd8e788a..aabb8c97caf4 100644
> --- a/include/net/bond_3ad.h
> +++ b/include/net/bond_3ad.h
> @@ -227,7 +227,7 @@ typedef struct port {
>   	rx_states_t sm_rx_state;	/* state machine rx state */
>   	u16 sm_rx_timer_counter;	/* state machine rx timer counter */
>   	periodic_states_t sm_periodic_state;	/* state machine periodic state */
> -	u16 sm_periodic_timer_counter;	/* state machine periodic timer counter */
> +	unsigned long sm_periodic_next_jiffies;	/* state machine periodic next expected sent */
>   	mux_states_t sm_mux_state;	/* state machine mux state */
>   	u16 sm_mux_timer_counter;	/* state machine mux timer counter */
>   	tx_states_t sm_tx_state;	/* state machine tx state */

