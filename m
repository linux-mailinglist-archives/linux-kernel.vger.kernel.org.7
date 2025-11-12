Return-Path: <linux-kernel+bounces-897860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF276C53D39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7CC3B1D02
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92734A79D;
	Wed, 12 Nov 2025 17:52:16 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1E34A3B4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969935; cv=none; b=MyWSBt2fADREuTmfwL6GHftAqm+LfZlABvd784k30AAyRf8duo2tZNHvGQ7NK2JdzyCZdJvIVlfPMxmaLyd9JHhq4D5Kgfim4Y8NFRa6uW0DwtjkAoI2ayxyNLp6BPu4em6tC4KBVdaD/vRxwJx47T+7cSFNaEeY7I8xx6UGAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969935; c=relaxed/simple;
	bh=SFwbsqB0O+tUTWktvVVZyqJuNVNdERcvJx7zcL57ES8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP2sI3zFjMUfMgSqlBME5DMFm4nwGMVs3/tIwoq0RvY+bdKi4sfn14UaPPSVegqdRQggcSNjK4rndK/UzzWiBJjPb93fcgPx0MUGKqBQhAawOwUdwjn4Ku5Q5hjxY4gN6fHj5OqXawzV4lYTgj9/GmWWVVK4xyETNQvVtSy9sj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c2766675adso711224a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762969933; x=1763574733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzbvFRntyWDcqPtNXDS/uZhln+N71UAAKYfDgxB7UP4=;
        b=PoRV14ers7EAKBtmQT1p6UIzohAKU2aREqzc+h61Aw1+VEloaCO+v70jnXyecOqQSE
         D0jI2j9+FWKpQxK9Lku5POjbD0EZD1LGVedq74/e4eXTgG3NpZ2WjNhouGOhWUdmUkxT
         rOuN2+GDpPnQL0I6uXuOZbum4PIeV39DHcjeNlUNCzo5X36RsapCj8bp5Cz+7VogTUhF
         04Mx8JCyUeZszNN0rJIYCXSjyOAJ0pHaQURY82TuqjaJr5VdEMM/6+x7QZvfwYd2uG2I
         VkYXQNxHthNsTFD2q3P89MTKEvcNrhjq1r2OyaATA7UYtcnyGvtdYHfjKTE8XvjcDO80
         OPDA==
X-Forwarded-Encrypted: i=1; AJvYcCX5uybSgHz2uF8W/lDd5QZIITgisCrC7ubAJVsahwWT0rDfY7qarS0NNGIQOcPFE3oF8Nbbpt5BKOBl1LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYC4gnMlF78Mg0+JGF0ZoCPKpwdkgk0blgbE+lXBZZbk3O42f+
	imFa500es7bNwjXYq6lBAwkm5l4pJjjKus1/5+9Z7cnBweolH4ap7UBc
X-Gm-Gg: ASbGncvl5j8DBsJYTEOfKrv2y60aupQ9Z87qTEHEz5GiPTOSII6+KphDRrGHYLag3d/
	v5nhsPLOuNFsPmE/A23dNOH6wwcG2lgJ2A81Ww0xVQDRRZh56F2izmW3rSYbj8cpSaDdYp2NhKp
	M0Scxx9p52CLqvOpprMtZ7K7feeLg3RXelbnuEIUiasM0SmFz5U1lxCN0SOJwpcCkO9F/BP2lug
	C2dfinEMqP4whnlAoY0Qp2GFJlXHCcpKr2BHYz32My3H8M4Z4C+KQzwkRLPubXCgdm0W7YFXuGY
	BJo3NtqQKWV4R2etYFLwnh3b1sD8YSZrzrvfWGGaGUJTqyTIlItx5g1dyQYdubHlKO38YIxNOqZ
	dnKpatY4hUT5mlFQw2KJyItYwKoRBb/jaavAjWBMDMiSAvsC1jzOB1DatWqNy0avFcsgmDldr7w
	ByvZ8=
X-Google-Smtp-Source: AGHT+IHOBDkAaitCpQS5gqhSNc5RIO3uY8mN4wl3nl8Q4q11uEhKYnOOPm8WmrkxLHAK+NlFSLvsOQ==
X-Received: by 2002:a05:6808:1786:b0:450:18a:da48 with SMTP id 5614622812f47-450746a6fa9mr1811520b6e.62.1762969933082;
        Wed, 12 Nov 2025 09:52:13 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6571f334f82sm699002eaf.0.2025.11.12.09.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:52:12 -0800 (PST)
Date: Wed, 12 Nov 2025 09:52:10 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] netconsole: resume previously
 deactivated target
Message-ID: <j67rta6sn3c2tgor3gtcrr2hvcdnxk6iqvzkhqkjkr6cgaezbh@vri4vhhzv5rf>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-5-1654c280bbe6@gmail.com>
 <e4loxbog76cspufl7hu37uhdc54dtqjqryikwsnktdncpqvonb@mu6rsa3qbtvk>
 <h5tdoarzjg2b5v3bvkmrlwgquejlhr5xjbrb6hn2ro4s46dpfs@4clrqzup6szk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h5tdoarzjg2b5v3bvkmrlwgquejlhr5xjbrb6hn2ro4s46dpfs@4clrqzup6szk>

On Tue, Nov 11, 2025 at 07:18:46PM +0000, Andre Carvalho wrote:
> On Tue, Nov 11, 2025 at 02:12:26AM -0800, Breno Leitao wrote:
> > > + *		disabled. Internally, although both STATE_DISABLED and
> > > + *		STATE_DEACTIVATED correspond to inactive netpoll the latter is>
> > > + *		due to interface state changes and may recover automatically.
> > 
> >  *		disabled. Internally, although both STATE_DISABLED and
> >  *		STATE_DEACTIVATED correspond to inactive targets, the latter is
> >  *		due to automatic interface state changes and will try
> >  *		recover automatically, if the interface comes back
> >  *		online.
> > 
> 
> This is much clearer, thanks for the suggestion. 
> 
> > > +	ret = __netpoll_setup_hold(&nt->np, ndev);
> > > +	if (ret) {
> > > +		/* netpoll fails setup once, do not try again. */
> > > +		nt->state = STATE_DISABLED;
> > > +	} else {
> > > +		nt->state = STATE_ENABLED;
> > > +		pr_info("network logging resumed on interface %s\n",
> > > +			nt->np.dev_name);
> > > +	}
> > > +}
> > 
> > I am not sure that helper is useful, I would simplify the last patch
> > with this one and write something like:
> > 
> 
> The main reason why I opted for a helper in netpoll was to keep reference
> tracking for these devices strictly inside netpoll and have simmetry between
> setup and cleanup. Having said that, this might be an overkill and I'm fine with 
> dropping the helper and taking your suggestion.

Right, that makes sense. Would we have other owners for that function?

> 
> > > +
> > > +/* Check if the target was bound by mac address. */
> > > +static bool bound_by_mac(struct netconsole_target *nt)
> > > +{
> > > +	return is_valid_ether_addr(nt->np.dev_mac);
> > > +}
> > 
> > Awesome. I liked this helper. It might be useful it some other places, and
> > eventually transformed into a specific type in the target (in case we need to
> > in the future)
> > 
> > Can we use it egress_dev also? If so, please separate this in a separate patch.
> 
> In order to do that, we'd need to move bound_by_mac to netpolland make it available
> to be called by netconsole. Let me know if you'd like me to do this in this series,
> otherwise I'm also happy to refactor this separately from this series.

Oh, I see the problem. That egress_dev() should belong to netconsole not
netpoll.

I've sent a patchset to start untangling netconsole and netpoll, and the
patchset was conflicting with the fix in 'net' 

https://lore.kernel.org/all/20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org/

Let's keep egress_dev() as it is for now, until we got them untangled.

> 
> > > +		if (nt->state == STATE_DEACTIVATED && event == NETDEV_UP &&
> > > +		    target_match(nt, dev))
> > > +			list_move(&nt->list, &resume_list);
> > 
> > I think it would be better to move the nt->state == STATE_DEACTIVATED to target_match and use
> > the case above. As the following:
> > 
> > 	if (nt->np.dev == dev) {
> > 		switch (event) {
> > 		case NETDEV_CHANGENAME:
> > 		....
> > 		case NETDEV_UP:
> > 			if (target_match(nt, dev))
> > 				list_move(&nt->list, &resume_list);
> > 
> 
> We are not able to handle this inside this switch because when target got deactivated, 

You are right, that is why we are doing the magic here. Please add
a comment in saying that maybe_resume_target() is IRQ usafe, thus,
cannot be called with IRQ disabled.

> do_netpoll_cleanup sets nt->np.dev = NULL. Having said that, I can still move nt->state == STATE_DEACTIVATED
> to inside target_match (maybe calling it deactivated_target_match) to make this slightly more readable. 

Awesome. Thanks for the patch!
--breno

