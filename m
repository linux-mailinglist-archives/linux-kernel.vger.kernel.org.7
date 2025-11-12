Return-Path: <linux-kernel+bounces-898301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B70D0C54D34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 459213476C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF372F2619;
	Wed, 12 Nov 2025 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNzgPqhh"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562426CE02
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762990934; cv=none; b=DvmnApwScaSA8p2pL2RyBvSMh6UCyPuoJHGzFOze6klEHEeB4inAKiZMRk6xKeCGvzQV2Vk5ftet5h726BJp18HefoSd6LnE6fSYYM27uYOLhRF2DOfp9P7UcaXgFLcjGQZqOV570Cug+9qC1yCI2WlCOcfOx37HVUL/gqBP3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762990934; c=relaxed/simple;
	bh=1lMoFMACzbECk38vPby/3BbYs6Z3LfIE8mVZSaO1JLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyPf6633m6VMA0RWvsvSmraIK2hazkxQtEz0PBEv3/db8ysz0oRwW0RrHKTq1txOKQh3/fRK0/661ZHCMULQu8seLT1fbMg6FsXIEc0fVLOIwS9GYyDMajsw37GV8O2Z3UQmOIXE9xP2f4/zbY3IEkOLYQKHyNS1fBD7cWZc6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNzgPqhh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471191ac79dso2299355e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762990931; x=1763595731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TshU2etaSOogd1M2K3cI72dRrmMqzWKUmJSokl5dOkg=;
        b=KNzgPqhh7/bu2fGYbsl+Imz2xNGDo0JoWjIH+/0TkRhmmy/p6zLe5vE3qM7ujpKNIZ
         iCDDpOupX+oOWTe4cMXXOqA0baZNu2sZSMDvUs/z6+t2MM8uifBgwGwBz8OmcF3ZXDC6
         Z86YfSAUROymmb+DRUWtnqU8/Ohbbd1JsgKcpZ5Jgupt4MGTFfV0lGL39RG8UeznO2TZ
         fILhu8SH2xIjKvLLu35Bw1k4lMQ9mxez2sVSUwLStqNsgJw0H3LMK+0fCt27MfD2MBkJ
         xKanfAXxXlJkxemqmW6dXX2CW+TUopQOe2p1O2w26PBVb65ZlYR7q95dTviWLaZ8Qfmk
         h56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762990931; x=1763595731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TshU2etaSOogd1M2K3cI72dRrmMqzWKUmJSokl5dOkg=;
        b=kOFxX2Z/OxJ8jfaPgEbkT+i14Nmj0aCJI/CXti482vldNMGJ883YUSIPaA9l3YIupI
         DIilPStbGOlrLINoOpvFXI9GvSBb5TfZHqnb1LHvtDnDGwDVYjw+mww76ECyo1UE15lS
         WZA4YQHtzjKzl/TCL9U5h/+ujEAVx0GaM6pnhAhk6mHFqlfH2MrVQM5KPyZsfwU2AoYv
         srygi0T49Re1jEKFVIrEuwBWF9DXSLlz6o8UnS1TggpjbE4Mv9KVOX0lPADTTUJqQqpt
         M2q3c0vzNT2dYMhLPwPINCZ7HFEVFM02WflRN8b5lnnAAPWkUSuKjQXylbmB0ZRbvpxr
         mj9A==
X-Forwarded-Encrypted: i=1; AJvYcCU6qXxlkNnDiyI/dxkpDU07Bx7WY0xuZ6NVz++JCYWxrV5xJxqADRQ5RJWyiYsgEo9Ec9u0Vf8eavG85Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2QWrX28is0Ga2y3gs672TdDmCj9PGMYd9G+gQ65s+4HMdMfjU
	ntSqfppV9goggRIP/uF8PFPJaQ1x1hYTX/wXpvmpc71VL0eH0iCm9TA+
X-Gm-Gg: ASbGnctyD1fZ7PF66qBArMqFOIg6jOVQm2GvXsHeNwAvQYrqUgryhwoeirqPpQ7DNNW
	aruo+qwyC/l2eeb68mVifNFo/sG8EqKn9n3x1117jSj0VrtZz9S0u7ipFbJk4N73X3lKLVOX5MY
	GlAiVs92eMexd3BfqI65EY5O96DFM1vsoxl64BznsnP/OF7Ecov7CLXtiCLG25UtMwdii2issXd
	7B6DyCmvcyvFRrbjIXnMOYPSAW9bQQ8sAfmGDDtWniNeqs6MaeTaYjeDx9x3K86m5W1R0490QSe
	AfNgJ2r5MhPUk5gsIL1EQV1c8YY03rGADh/9t36TRWuKrzzOPYaNaZeD5rxExTO4k19IR2QbKKp
	bspKFWhAN2eVFdgdSLxnNZceQgF7Uwq6faD0hDOJWPjS4hT1bxrYjiMiIgx01/eufYRbM0f6E
X-Google-Smtp-Source: AGHT+IFFAk8S1cUSmChXmujEvmDeQzGglCBvYNUZFPq/4dEK7j7TC7hepzqst+d+TMDKaX2Il38imA==
X-Received: by 2002:a05:600c:3546:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-4778703e738mr51144505e9.3.1762990931152;
        Wed, 12 Nov 2025 15:42:11 -0800 (PST)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae98sm368059f8f.2.2025.11.12.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 15:42:10 -0800 (PST)
Date: Wed, 12 Nov 2025 23:42:08 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] netconsole: resume previously
 deactivated target
Message-ID: <faql444wbuoqwtfsl2722xjphijchannmdk2d5gemupnpluhom@bvv2k6zy7lhx>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-5-1654c280bbe6@gmail.com>
 <e4loxbog76cspufl7hu37uhdc54dtqjqryikwsnktdncpqvonb@mu6rsa3qbtvk>
 <h5tdoarzjg2b5v3bvkmrlwgquejlhr5xjbrb6hn2ro4s46dpfs@4clrqzup6szk>
 <j67rta6sn3c2tgor3gtcrr2hvcdnxk6iqvzkhqkjkr6cgaezbh@vri4vhhzv5rf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j67rta6sn3c2tgor3gtcrr2hvcdnxk6iqvzkhqkjkr6cgaezbh@vri4vhhzv5rf>

On Wed, Nov 12, 2025 at 09:52:10AM -0800, Breno Leitao wrote:
> > The main reason why I opted for a helper in netpoll was to keep reference
> > tracking for these devices strictly inside netpoll and have simmetry between
> > setup and cleanup. Having said that, this might be an overkill and I'm fine with 
> > dropping the helper and taking your suggestion.
> 
> Right, that makes sense. Would we have other owners for that function?

I've looked at other drivers using netpoll and from what I could find all of them
are using __netpoll_setup paired with __netpoll_free. They don't seem to 
rely on dev_tracker to track references, I'd need to look a bit more to be certain,
but I think other callers are own the devices and track their lifecycle separately.
So I don't think this would be useful for them.

Since we are moving netpoll_cleanup to netconsole in your patch below, I think I should
drop the netpoll helper and keep it in netconsole. I wonder if we should consider
moving do_netpoll_cleanup to netconsole as well, since it seems to be the only caller
and then we would have the same symmetry I mentioned above.

So, to summarize, given your refactor patch I think it makes sense drop the previous
patch and do the netdev_hold in netconsole as you suggested. Does that sound good?

-- 
Andre Carvalho

