Return-Path: <linux-kernel+bounces-888707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6886CC3BB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EA21B20A4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B490342C96;
	Thu,  6 Nov 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1cc9OOq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MX8E8WqG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2C342148
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438743; cv=none; b=NzFPkxRpcEgy/7zn8MKrihn+gKYHkHKgN0bBJd/528eqr3bJFuHDizwjFZ7xT90a5NgnFCxXzFoxt9RwfM4mta2EZzm9cl1C2sPuCCXMea4TCKaroYf+TTHqXKcuWHuDIvdqFOO0jnZ7MSCRGVIFm0ZYHkrgBJCi07hdotsr9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438743; c=relaxed/simple;
	bh=ecXPWFAbT2zz2E6hGr3lsgOC2vwHjsIE0/qnPxMclIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ldQAypdzTreG0lodVScQyKAi5XLFNXUwEAcUiNY6GskOrJ6R90pBN5HhlXVh8ayGZRl3kqCBr3ZSwa/KFh3etvCwyi7e/m/kbXhz6SFZrowqdsrOhA8hoE3ae0HXYFx2+uo+2Up7X7nAB+oUCs3SQc4+WEzFaH3Ake3hmRoUD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1cc9OOq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MX8E8WqG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762438740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2558/5DuSGeHTSysEKVn43dBQXRVp9ibyTXm/MgXyNU=;
	b=Z1cc9OOqo23nTkSiBS9XnJMGHjMCY1/vTmvAMXYs/zowtj+c7gkztKUO8Jzmqsf1zqHxAC
	Hug9JlxEZ103/dgg7Jk9x/JZIKgrOUH8DwKk/lRV7qZHgTPHutR6m0ytFZA3oYveblHJmy
	yvLI+Y4KFZquNDXHQ+5nu0fzys+nTAI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-TBBYtv5rMt-ys9MLhZkoCg-1; Thu, 06 Nov 2025 09:18:59 -0500
X-MC-Unique: TBBYtv5rMt-ys9MLhZkoCg-1
X-Mimecast-MFC-AGG-ID: TBBYtv5rMt-ys9MLhZkoCg_1762438738
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477212937eeso6273675e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762438738; x=1763043538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2558/5DuSGeHTSysEKVn43dBQXRVp9ibyTXm/MgXyNU=;
        b=MX8E8WqGP2A//cTJpXEtpNVFwQeSFR9cfCKP3ixLcaqQhj3ezDsbRJ+E1PUiK+jA3o
         Oyt9bhYwgaIXTI8irjV40OVI0IBHK0n/SFaYq6iSouNrrgNDrRLHD+cCa+w8POzDx4cw
         d70ZIgh1phTfn0Qorcr4Kqy9lVDHfJGFP8AbX0I9cS1tBadZfDoPo6jDgQxWQRTebLsf
         sVBZiE2eIoMlK0SmmS91IHNHCBX1hvUM4bK6+1QJxWnG69qb+uZefR9tdVYF+DUlmykK
         KZAe2R2etXJ06Oi0lUQ6i619ANnow7W1p1wjpVw0uyngyaJ4+Ad/+lMks3bY0mVgxnph
         DjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438738; x=1763043538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2558/5DuSGeHTSysEKVn43dBQXRVp9ibyTXm/MgXyNU=;
        b=t1Me53m4gBywbYsdZL2TPbgPABYabrLH+SU4XmVGP3DS37Tfy8rro/+ALsbUP+j2ZO
         TRANEQOyiQhclnehEBBzXuIk7EI9BZkr3eyHjCESBgH5EgdbtC0kXmtT3apt72dpGljR
         YRr211ZgJbOpB5hd5haRE67wdFlokhOVscePnjAiEaMa2kvvFKHdBR4ZQJlW2ayTr2Oz
         BXZ1r3cSRIevKmpbAjp1t5CNHs6vf7f+qnX9LmVmBjC0NwuwYQi5ejoS1gARQWv25Red
         ljXlO0P78qiSgYv8tmKMOiUwM/rKUQqp0+PpALaOELJAKCxCy51Nj0Ngbo+qytWoijyC
         gwig==
X-Forwarded-Encrypted: i=1; AJvYcCUTHWkSD7o+Tr/opJIIbUCl3HIuSxIni0VQVI+fupf5sej4jQ8YxFO3h8CTCgsV3SxGZNU/tX8eKWLM5Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCrFi+qC6AqGW5h8S/Equ37XFboaQHpKeZc/QazOy/0k15N7v
	/gIV1tnxAUyXsFM08LyOLloSuhS/jOc2nbIWAp4ZkrOdHqy11+s9l7EQAu2DzGnpRqu4qT7uLw2
	JayaxewYXLQl35oCfd6iuLgmsFAn2C1MJiCYTktb+ZeSq4gTHVGeQh3Lmza4M1JZ1pg==
X-Gm-Gg: ASbGncuexg1HMWvCm3h/zn2WXvymmCTPI9jOxxBkzbvwKbo4jZKv5MTVUaUoyc+P1u1
	MIB8k/4ovRmxZIpl3KBL/435QbqSgOFwBIUfzeaI38rPhmAh8Cn4Hf9JTNTvnyhqyh6oTDhGUWG
	FuER4Z0UgOhGYeHhzqg4qN/+TBjabiNt0KagkTtfuVjZ5akJvVj3M4yu1gwM+GiWWS2DVM3ailn
	0pnA2xj2Awx2CIBweOEaw6SgGq/KOsKAhaSyFwmCFYUGl+/0YaJj2rfq8Q59fHU6mcMDm/CMbq4
	aVwQPjaf1Jr1SV9T/NFe9pdforOo6mheMAH+jAdU9NEj/qLIMKR/jgumc2V9YZo2VpOP2SuoYwn
	o/A==
X-Received: by 2002:a05:600c:1552:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4775ce3f136mr88569365e9.32.1762438738011;
        Thu, 06 Nov 2025 06:18:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn0NuCZ5fprkStyYtobcANdwvR7UeicN84jVnofOHneho0o5wIY1CsG7J8Q2tZQ79l336p/Q==
X-Received: by 2002:a05:600c:1552:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4775ce3f136mr88568195e9.32.1762438736530;
        Thu, 06 Nov 2025 06:18:56 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403849sm5669190f8f.1.2025.11.06.06.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:18:56 -0800 (PST)
Message-ID: <d9b8ec8a-f541-4356-8c42-e29adced59c0@redhat.com>
Date: Thu, 6 Nov 2025 15:18:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ppp: enable TX scatter-gather
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251103031501.404141-1-dqfext@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251103031501.404141-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 4:15 AM, Qingfang Deng wrote:
> When chan->direct_xmit is true, and no compressors are in use, PPP
> prepends its header to a skb, and calls dev_queue_xmit directly. In this
> mode the skb does not need to be linearized.
> Enable NETIF_F_SG and NETIF_F_FRAGLIST, and add
> ppp_update_dev_features() to conditionally disable them if a linear skb
> is required. This is required to support PPPoE GSO.

It's unclear to me why IFF_NO_QUEUE is necessary to avoid the
linearization.
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v1 -> v2:
>  Changes dev->features under the TX spinlock to avoid races.
>  - https://lore.kernel.org/netdev/20250912095928.1532113-1-dqfext@gmail.com/
> 
>  drivers/net/ppp/ppp_generic.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 854e1a95d29a..389542f0af5f 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -498,6 +498,17 @@ static ssize_t ppp_read(struct file *file, char __user *buf,
>  	return ret;
>  }
>  
> +static void ppp_update_dev_features(struct ppp *ppp)
> +{
> +	struct net_device *dev = ppp->dev;
> +
> +	if (!(dev->priv_flags & IFF_NO_QUEUE) || ppp->xc_state ||
> +	    ppp->flags & (SC_COMP_TCP | SC_CCP_UP))
> +		dev->features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
> +	else
> +		dev->features |= NETIF_F_SG | NETIF_F_FRAGLIST;
> +}
> +
>  static bool ppp_check_packet(struct sk_buff *skb, size_t count)
>  {
>  	/* LCP packets must include LCP header which 4 bytes long:
> @@ -824,6 +835,7 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case PPPIOCSFLAGS:
>  		if (get_user(val, p))
>  			break;
> +		rtnl_lock();
>  		ppp_lock(ppp);
>  		cflags = ppp->flags & ~val;
>  #ifdef CONFIG_PPP_MULTILINK
> @@ -834,6 +846,12 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  		ppp_unlock(ppp);
>  		if (cflags & SC_CCP_OPEN)
>  			ppp_ccp_closed(ppp);
> +
> +		ppp_xmit_lock(ppp);
> +		ppp_update_dev_features(ppp);
> +		ppp_xmit_unlock(ppp);
> +		netdev_update_features(ppp->dev);
> +		rtnl_unlock();
>  		err = 0;
>  		break;
>  
> @@ -1650,6 +1668,8 @@ static void ppp_setup(struct net_device *dev)
>  	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
>  	dev->priv_destructor = ppp_dev_priv_destructor;
>  	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
> +	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST;
> +	dev->hw_features = dev->features;
>  	netif_keep_dst(dev);
>  }
>  
> @@ -3112,13 +3132,17 @@ ppp_set_compress(struct ppp *ppp, struct ppp_option_data *data)
>  	if (data->transmit) {
>  		state = cp->comp_alloc(ccp_option, data->length);
>  		if (state) {
> +			rtnl_lock();
>  			ppp_xmit_lock(ppp);
>  			ppp->xstate &= ~SC_COMP_RUN;
>  			ocomp = ppp->xcomp;
>  			ostate = ppp->xc_state;
>  			ppp->xcomp = cp;
>  			ppp->xc_state = state;
> +			ppp_update_dev_features(ppp);
>  			ppp_xmit_unlock(ppp);
> +			netdev_update_features(ppp->dev);
> +			rtnl_unlock();

Instead of dynamically changing the features, what about always exposing
SG and FRAGLIST and linearize the skb as need for compression's sake?

/P


