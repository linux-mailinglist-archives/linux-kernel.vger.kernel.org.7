Return-Path: <linux-kernel+bounces-896075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5392AC4F96B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98B144F181A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966CD325722;
	Tue, 11 Nov 2025 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PATnYtYT"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED1324B38
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888732; cv=none; b=hf7o3xX7nSfba3j+NNGJ9+s7MrGMuAbx0dKA33igQ400NPJ++UiGDpBP0RSskqvNFz4IjnuaYdMyprLn7Jr9JKyt4/v70AlpggHT+mZf9nJAQAWiPaGbOVXBGMgMN9IjewseWsCIMgWfSmMMg1mXw7FBRayLxQbxEUNLNXqJKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888732; c=relaxed/simple;
	bh=WrkIgi+zshvGxhLfLIup6m0PxGHGcR8zBqwWWiSJGUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0O0NXpfnbmaOvhWKSbxNQcP6no+HpkiipYV9kap8aKetR4F5RCkhEW5kDBWsm4Fp33ETg10pTd59Ny+PMaPXOW40eH3ABFWz3+UJ4h44u6Hg51EM2DeyQ0HNAPcSDOfNBpJWwY8WwtOlhR+7MYT0CGU/vhWF6fk9jR56ZHxLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PATnYtYT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b379cd896so3845f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762888729; x=1763493529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3g2GDGj5AAay/k4tJ+VCCSovbtJsKk41E0hucw1Xl2I=;
        b=PATnYtYTHXDllw9nDBdkh11UnLM9SWJSGe82d1Qs1Nv2d7LDMNZNWlP+e9NhTWk83/
         dB0f1wGo+2KoAFgTptXGAPOrFEHgJxZqXr6znIyisCpz878Ff/P5qDr0i15KjbMME0Wj
         fByCFLGPvMqbk4HWqML8u7tjuxgp/Lgzg0iOzK2ZLyFCl8Vz11WXOxx8oPf+y/DrKhRD
         Tlkbvj7JKmczlof4RmFiL3WS1qAxKLyS71g9+T9/ifo9FyDWcwPLNPOGXO4fGjn4l7ju
         Fu72hdKkD1Wn1BoDEvQm/H9JaaKNWCNjFK0XtfSLpI30epVECPIPCEUCoM/IYu6Ok3oa
         tn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762888729; x=1763493529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g2GDGj5AAay/k4tJ+VCCSovbtJsKk41E0hucw1Xl2I=;
        b=PJbLoilHCKSmTI5OmRn8tO4o0MVsfKDsKrknTHSSJYfj0tn9qGAiQHbNVZMuCQW7RI
         r9UQwZC4/r9eVbHRwqT4iCkoTaF2hzG7vD6uHSoTobMtfpYf3oNwLT9ya1I+9R96IF8x
         5KLSBKsfHWCzNxbjZP2kwK199FrEbeeUptvM39mXuI62tWgDyhraVY347Tw0D59/N7AF
         AgtkQZkPJUikrlNV3g+IAaKpgwy2sdHDiRfbhQtF7nPERkjl9GfbQJ2rN2olyOv6KkoO
         PqLUUBo+LMh/iAbsCwc5+fqfx9Dq7TsPvst9zqY7UQ0DQ9kf9Du2y2F8s8zG9uMVWxO+
         TI/A==
X-Forwarded-Encrypted: i=1; AJvYcCX7DIwSLVkHLvfgQ+VwTLKaHa3+DmcEKxap4Q55w9ImiLTltQ5VPvFMxxMZiLaClOuGLJyBQIJxTWn1GGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbYaw/mr3J6dYByhexWFIyJDiMDseVZUVGLTFPlLyyrzIWlSh+
	B2trXoMAoHv2etH12F3m4DJCtB/MCJqalijvgLZ9fJXQia+93IkH3yKh
X-Gm-Gg: ASbGncvw7I4kjXRFL13X00p9FZIrXPVE9wmq6D6H0RXt+DcnvegaCgdnstpPLVKyeDI
	WWZjrs2PfxjzCZEsUAYXK9wiUWqAxYQ6Nm3MIdktQtfd9i9ETY6CUI0eZdrrpX+nDrNcPqgLQpJ
	omFwZD8WXAs/CRBauHnz6s8vDaLo+iyMudl9W1MCWHeFz3dC+nqWqUfIX2EuoP0pZMbrIgefeF9
	2FwUHl16c3EP6oY/eTT3Jv7los3zbUfofCLTwo5SYrXsbDw8QzEuoWp/1HRwmCkIvXcb61CdxJa
	8QH2OOHVdMxTg0f8aewn3569Idi608UvbDpCVEKFeQ79Rc8HBGByinlj7f3PRsoXw2rOjlho2yC
	BBHQplUirR2Tdpwl1RNI0/8fI3Tm5NVPjrX7ctUSxJtA71siSWCrLBRE3RdAs40ux8kI2f2AtTX
	owrItXBy4=
X-Google-Smtp-Source: AGHT+IEIg14BCh/MvTFM8zMUPDwzSAPlSz5/+0VBZJxt8k8qV9/8IPFlPxgvs5CsxqfGwfmV9u0z9w==
X-Received: by 2002:a05:6000:401e:b0:42b:3dbe:3a54 with SMTP id ffacd0b85a97d-42b4bb98aa5mr278784f8f.17.1762888729119;
        Tue, 11 Nov 2025 11:18:49 -0800 (PST)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm28745773f8f.9.2025.11.11.11.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:18:48 -0800 (PST)
Date: Tue, 11 Nov 2025 19:18:46 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] netconsole: resume previously
 deactivated target
Message-ID: <h5tdoarzjg2b5v3bvkmrlwgquejlhr5xjbrb6hn2ro4s46dpfs@4clrqzup6szk>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-5-1654c280bbe6@gmail.com>
 <e4loxbog76cspufl7hu37uhdc54dtqjqryikwsnktdncpqvonb@mu6rsa3qbtvk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4loxbog76cspufl7hu37uhdc54dtqjqryikwsnktdncpqvonb@mu6rsa3qbtvk>

On Tue, Nov 11, 2025 at 02:12:26AM -0800, Breno Leitao wrote:
> > + *		disabled. Internally, although both STATE_DISABLED and
> > + *		STATE_DEACTIVATED correspond to inactive netpoll the latter is>
> > + *		due to interface state changes and may recover automatically.
> 
>  *		disabled. Internally, although both STATE_DISABLED and
>  *		STATE_DEACTIVATED correspond to inactive targets, the latter is
>  *		due to automatic interface state changes and will try
>  *		recover automatically, if the interface comes back
>  *		online.
> 

This is much clearer, thanks for the suggestion. 

> > +	ret = __netpoll_setup_hold(&nt->np, ndev);
> > +	if (ret) {
> > +		/* netpoll fails setup once, do not try again. */
> > +		nt->state = STATE_DISABLED;
> > +	} else {
> > +		nt->state = STATE_ENABLED;
> > +		pr_info("network logging resumed on interface %s\n",
> > +			nt->np.dev_name);
> > +	}
> > +}
> 
> I am not sure that helper is useful, I would simplify the last patch
> with this one and write something like:
> 

The main reason why I opted for a helper in netpoll was to keep reference
tracking for these devices strictly inside netpoll and have simmetry between
setup and cleanup. Having said that, this might be an overkill and I'm fine with 
dropping the helper and taking your suggestion.

> > +
> > +/* Check if the target was bound by mac address. */
> > +static bool bound_by_mac(struct netconsole_target *nt)
> > +{
> > +	return is_valid_ether_addr(nt->np.dev_mac);
> > +}
> 
> Awesome. I liked this helper. It might be useful it some other places, and
> eventually transformed into a specific type in the target (in case we need to
> in the future)
> 
> Can we use it egress_dev also? If so, please separate this in a separate patch.

In order to do that, we'd need to move bound_by_mac to netpolland make it available
to be called by netconsole. Let me know if you'd like me to do this in this series,
otherwise I'm also happy to refactor this separately from this series.

> > +		if (nt->state == STATE_DEACTIVATED && event == NETDEV_UP &&
> > +		    target_match(nt, dev))
> > +			list_move(&nt->list, &resume_list);
> 
> I think it would be better to move the nt->state == STATE_DEACTIVATED to target_match and use
> the case above. As the following:
> 
> 	if (nt->np.dev == dev) {
> 		switch (event) {
> 		case NETDEV_CHANGENAME:
> 		....
> 		case NETDEV_UP:
> 			if (target_match(nt, dev))
> 				list_move(&nt->list, &resume_list);
> 

We are not able to handle this inside this switch because when target got deactivated, 
do_netpoll_cleanup sets nt->np.dev = NULL. Having said that, I can still move nt->state == STATE_DEACTIVATED
to inside target_match (maybe calling it deactivated_target_match) to make this slightly more readable. 

> >  		netconsole_target_put(nt);
> >  	}
> >  	spin_unlock_irqrestore(&target_list_lock, flags);
> >  	mutex_unlock(&target_cleanup_list_lock);
> >  
> 
> Write a comment saying that maybe_resume_target() might be called with IRQ
> enabled.

Ack.

> Also, extract the code below in a static function. Similar to
> netconsole_process_cleanups_core(), but passing resume_list argument.
> 
> Let's try to keep netconsole_netdev_event() simple to read and reason about.

Ack.

Thanks for the review!

-- 
Andre Carvalho

