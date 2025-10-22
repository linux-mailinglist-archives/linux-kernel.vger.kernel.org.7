Return-Path: <linux-kernel+bounces-865631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF59BFDA37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D9244EF4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7BB2D97A0;
	Wed, 22 Oct 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0fLYb71"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1012D9481
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154781; cv=none; b=qgx3Tn+GPLicyJ0Iuw+o921G/0kTHe9wMqgzogjSF96lpW5EnGER1M3Qp/8O0E6tW6tliPqjzk/Rm7TfRzQjIw7dPviflVLhCF7nXRm+rAfJdELyRJAVHJk/xtMdqKnl4gjaMdRAgdCp45CBEAOXkLPWl16IY2Mc60VtYHZ9ceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154781; c=relaxed/simple;
	bh=O2rS9th93VdiObqGHqJg9tF9FtBIZpNefdSGlMkHdmY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9S5+lN2ZqSldxmrEY4stI/K1XsGtMvSATWQeCmG+QyZShOLW1ZMwT7YN09BZwCGPxIjxicoHiPi06vfEiZXQESd4NdPAHjm40REk43vPTmM+WgpGqMzPsjI+ca56y6WD5+R7BrdReVAo6sJqJMBbIpUWbSJF3kxXg7locB8p+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0fLYb71; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so8930836a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761154778; x=1761759578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQdE14qwP3ArpvNj7koaLBKy4oXNS6rDuyXrc8Mb3G8=;
        b=V0fLYb71LWnbHwu7vx+4+aT/VvkpyKipsXg1ezt52QvFAnKAfO/rz8U9SAK3QD+I6M
         a3HuAHR/dntApw2kb4XyxrlPKGsIblTNQGIM7K4tFoGHgZ6ops7ZEi4ej4IlWOObDJm2
         IGIrsJfG3ZqjSKhfdC+6zndkFNPU5yo3U9KEVSZ91FQWAFQOEtArWzGhABH71QcRTZOg
         uvcGXrc7+cns1KPyTfU9cemH2ySU+42kbSGJIqEf8kt2hiXVHOmLb56+1/ID69JrZMux
         A9Y8GYgN8ATvaCfykkSZtFExjj/YN5o1fkoz8QhJi46JrLqbTSz3oNTO72YXBpdF6oLg
         QBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154778; x=1761759578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQdE14qwP3ArpvNj7koaLBKy4oXNS6rDuyXrc8Mb3G8=;
        b=qqFHCPZ/qP81VihtdUvUErzVRGycaa0uUvps9pTMD2II3UGYlmRmdoW5Mt1RsztVUe
         vsUoEuv0NyFcSNreJtl5YilIkN5lMWAMTG5gG7losuEqi5b/V57Ury1R8vbbp5iUz2o2
         Ai166Ad0MrJBH8ucxidVK8512Ml6H2RtzffdxbKqaR4CKRSCU3cUsC+58psBGPDgteew
         FxhKTIUUBtCncU4GaE3hrfIKP2TD8z7VLFkSMW8UGrDIdy7ruSVjWRMTj1jjMvxME5Zf
         2j91QMOBu+Ce17xgLX4VowzFCZ/yaZdIjRJQ6iRDuD7y8yVNJVJ7RIwH8r/GlOAb43zj
         8sdg==
X-Forwarded-Encrypted: i=1; AJvYcCUNCzs0hDtP6ruOVFdETlPabgUrOqqhdi4NTY9Z48bIGg9A3P8vvax2KXjBzQl7ex3gi4pbIyVklAu7gGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDya8YzklZo+al7VQkBV5Q3XlUkslU5KAUo3ksz4r/N/Rxv9rK
	yhFK3DQes09v7xVKZ6vcBTfEQxVb9M2sR2tRB0MZKFFrhz2l5OgDq1Kz
X-Gm-Gg: ASbGncsxlnLo97kyJcFx23g/TKf8ogUHzqP2Ie3OBdQqMOgnSD8c68Z0ai/hFBRDl5Q
	+ARzRdq9M1El/Ph0MsdYq2s7hAwkLx59qJdg3JeZX+XIKquaju64KTqpHSlLTHqxQPNDzbPlTOl
	hWOy5ob7cycY/AnM2WfZnIOln21HVQlCw85Fwx/BcJNtRmOoRw0WHW3Q77NtkK/yhxUtw/Rf2VZ
	5+YEz+VkrWJJ4f7byW4T9MnYZX3l3qxMOcbFAg5MWarGpDD6wzkn60hP9Um7GgHl13fi8Na29XF
	IHL+r/qca2eCOyI93PYIpJEoQ8+zHsZlT7l5Hq55eIJHKQCJbFcoPonSjqqG6AURs+swvjv8GPr
	FgWy89Yv7I+frT3VKhim62lDyLnyNJ0WGjzDC3BcX6QYiVnQQkNCL2WRY7UFFyzNY3CU7Bn4uyy
	/mbzo=
X-Google-Smtp-Source: AGHT+IF/wQlvN1PHS4P0FuXHnhUI6gRONo719YP7lTtUWQHYnX87iTmhZHJVAyR2zlOCWjra1Hg12w==
X-Received: by 2002:a17:90b:3c88:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-33bcf85d01dmr25963979a91.5.1761154778032;
        Wed, 22 Oct 2025 10:39:38 -0700 (PDT)
Received: from lima-default ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d11c8sm3174342a91.4.2025.10.22.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:39:37 -0700 (PDT)
From: Your Name <alessandro.d@gmail.com>
X-Google-Original-From: Your Name <you@gmail.com>
Date: Thu, 23 Oct 2025 04:39:29 +1100
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alessandro Decina <alessandro.d@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aPkW0U5xG3ZOekI0@lima-default>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
 <aPkRoCQikecxLxTS@boxer>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPkRoCQikecxLxTS@boxer>

On Wed, Oct 22, 2025 at 07:17:20PM +0200, Maciej Fijalkowski wrote:
> On Wed, Oct 22, 2025 at 12:32:00AM +0700, Alessandro Decina wrote:
> 
> Hi Alessandro,

Hey,

Thanks for the review!


> 
> > Whenever a status descriptor is received, i40e processes and skips over
> > it, correctly updating next_to_process but forgetting to update
> > next_to_clean. In the next iteration this accidentally causes the
> > creation of an invalid multi-buffer xdp_buff where the first fragment
> > is the status descriptor.
> > 
> > If then a skb is constructed from such an invalid buffer - because the
> > eBPF program returns XDP_PASS - a panic occurs:
> 
> can you elaborate on the test case that would reproduce this? I suppose
> AF_XDP ZC with jumbo frames, doing XDP_PASS, but what was FDIR setup that
> caused status descriptors?

Doesn't have to be jumbo or multi-frag, anything that does XDP_PASS
reproduces, as long as status descriptors are posted. 

See the scenarios here https://lore.kernel.org/netdev/aPkDtuVgbS4J-Og_@lima-default/

As for what's causing the status descriptors, I haven't been able to
figure that out. I just know that I periodically get
I40E_RX_PROG_STATUS_DESC_FD_FILTER_STATUS. Happy to dig deeper if you
have any ideas!

> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..dbc19083bbb7 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> >  		dma_rmb();
> >  
> >  		if (i40e_rx_is_programming_status(qword)) {
> > +			u16 ntp;
> > +
> >  			i40e_clean_programming_status(rx_ring,
> >  						      rx_desc->raw.qword[0],
> >  						      qword);
> >  			bi = *i40e_rx_bi(rx_ring, next_to_process);
> >  			xsk_buff_free(bi);
> > -			if (++next_to_process == count)
> > +			ntp = next_to_process++;
> > +			if (next_to_process == count)
> >  				next_to_process = 0;
> > +			if (next_to_clean == ntp)
> > +				next_to_clean = next_to_process;
> 
> I wonder if this is more readable?
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..36f412a2d836 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -446,6 +446,10 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  						      qword);
>  			bi = *i40e_rx_bi(rx_ring, next_to_process);
>  			xsk_buff_free(bi);
> +			if (next_to_clean == next_to_process) {
> +				if (++next_to_clean == count)
> +					next_to_clean = 0;
> +			}
>  			if (++next_to_process == count)
>  				next_to_process = 0;
>  			continue;
> 
> >  			continue;
> >  		}

Probably because I've looked at it for longer, I find my version clearer
(I think I copied it from another driver actually). But I don't really
mind, happy to switch to yours if you prefer!

Ciao
Alessandro


