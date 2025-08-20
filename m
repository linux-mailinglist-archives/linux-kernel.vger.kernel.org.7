Return-Path: <linux-kernel+bounces-778650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37526B2E877
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E62C94E1502
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF492DA755;
	Wed, 20 Aug 2025 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="aL5EOl8S"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781151F4192
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731362; cv=none; b=M6LZZZ1wVRnOr7NQZxkC6MXluGDZG8xvHNNQIOh7xwc/fANxRwDQrix3ueURLg9u2YkQL/4uAA4nZ+p4IUpepQ3MywkSpQYIJwtec3kCSSkaM3qVAr5S19wYPzUNTqNT5UqH2e/IbS9nMZ/Zbn11FeI9NOPzjt92F+85AJxJHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731362; c=relaxed/simple;
	bh=0MvkcO4mhSlpud9CTh58nSyQC+3/p6Nxn3ZWMBIjpXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGkRRX+yCgwCbUU0IBjt0qYVySGvzFzjJ8LHDN5oWND3ZxgYganykQJg/2mjZwT4KPUh6uSSyWCEUGxD2zDy1EtSCww+Ru3pvOwZ9khka3acouIbknTdmoOllJbWSO9H112Uvey2IzPcXAot889yQVRO44GnjyyEfxctBC0pFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=aL5EOl8S; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so448617b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755731359; x=1756336159; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+tyuLMv7fowbfjD40sfmjyli4eEIuNfpbDs2bqEjHDc=;
        b=aL5EOl8SA+UBfAbOqMXqy1phBrMai2TFNbeFGPn00HNiOYJOPsAoRa5OyRuJfoVixN
         BiGcxPp/7iULrkZykRx6LQI6V2/ZANPrzmSSKV9tyXVg+18VAshuNVssM4RxU3I9h7ak
         5rPk0zHuumjXAMFMCgW5eJKFcubzjhlnqRVpTlQol47xL1wnLK5ECyIlJpYbwjixRUYm
         uGe/BjyL+rwZBvXCMjf43u0hOJVM0OmDbm8xq+qEDOx7mEsZztMewY6oxqRhyfExob6r
         I4C1QS5mvdSc0lJIARARnAqBEBon5BCyclGxz+6YSDTEDxtNJtEveNVmX58Ur8Nl5vfo
         /MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755731359; x=1756336159;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tyuLMv7fowbfjD40sfmjyli4eEIuNfpbDs2bqEjHDc=;
        b=RMQa8XXsrT04Uy9d5u3fktPjTs4ZqJo2ZUVomDspG6l8z1XsriN50JjZZLZpL0osAg
         rRBvSFyzDWizPIXmt5HOb/yJITKmH4cRnyExS6jgQNzYnGutGZI3Hd94URVTsbh6xzFM
         71Nwz4hD9cIp/R2lGWx8s4etbt9YWGrTkTNhBvsONlYYYl4wJHVnC26zQeiJZiexBBA8
         gAbHN+R4LaPvfkbKSBXzgguuDzXDzyElO8MoP2QUhP5pOENqhmpX77JoVZ5buluLNoW7
         5k5VCZ8eApISfMgd/hxgrOtGUtZdOVSBSeB3RG7T0tKGuAPkGEVlNAwFkQKaKGr1W37E
         TDDA==
X-Forwarded-Encrypted: i=1; AJvYcCXQv2WIdGugMwqnTaMPvj9d7qmxwnKUNveWHa1czMf0RD7voMixlRQIUH7mvqlkUxNodAdpBxJ17+f2gNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2714qWovz9dNe5TF9jmVUqYXXkjOR90B8nHp8ZbWodLR9+gh
	8Ig+YWUX0dPUjpQKEH7t3UQAU+F3DCJn9WfciNEzOqoGsfLHV4fRG7ThxG/y7Wh7aPI=
X-Gm-Gg: ASbGncsKs/0TLfUQUUrAkw/ig1XvIFl1S9UpIMd5u28iRDbaXUcxNgBp5JFUXZTcjZa
	OUuGe/OQt38Z74exCjGLrO0rFkFJF+/KZSol/j5DdMBwZjtJTfROBhkrES1Koz2oGhdV8Q035xY
	9YyoBO4Uxyi2Hw/5Kr495nT8PRSvByf7dy1H2ChLDKyZ9JkxioZXRdH4WZ8F4q8XyNv30kaK/Ml
	XnwQPZaL7y/aG7PQ1NMO0qNQsf6vNf+BAeCnRJ5PgflCDnpxwECdFFQVpjgsxrxOHJFioYJQ0CZ
	eUJyiIuC4aXk0h4PXi2H1BgcURqxPObmiZcZIR6sJySLWmbKEtwpaCV3VVbGJkPjQooP/h1BIKv
	+3nDQgOsU3e7DiVg32CNo3UiS
X-Google-Smtp-Source: AGHT+IFTC4LLt5KycWqz0CRruTcc9AAbBVXRBu/bAtT4l8lBZAyrQijVfp3CZ6NeR2DmzF+sRssJQg==
X-Received: by 2002:a05:6a20:6a0f:b0:243:78a:82ac with SMTP id adf61e73a8af0-24330ab8681mr356174637.52.1755731358637;
        Wed, 20 Aug 2025 16:09:18 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f76b5sm6286301b3a.59.2025.08.20.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:09:18 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:09:15 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michal Schmidt <mschmidt@redhat.com>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKZVm-0iiMsUfexu@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <089ba88e-e19d-40eb-844d-541d39e648e8@intel.com>
 <aKXzzxgsIQWYFQ9l@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKXzzxgsIQWYFQ9l@mozart.vkv.me>

On Wednesday 08/20 at 09:11 -0700, Calvin Owens wrote:
> On Wednesday 08/20 at 11:41 +0200, Przemek Kitszel wrote:
> > On 8/20/25 08:42, Michal Schmidt wrote:
> > > On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
> > > > The same naming regression which was reported in ixgbe and fixed in
> > > > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > > > changes") still exists in i40e.
> > > > 
> > > > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > > > ("devlink: let driver opt out of automatic phys_port_name generation").
> > > > 
> > > > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> > > 
> > > But this one's almost two years old. By now, there may be more users
> > > relying on the new name than on the old one.
> > > Michal
> > > 
> > 
> > And, more importantly, noone was complaining on the new name ;)
> 
> I'm just guessing with the Fixes tag, I didn't actually go back and try
> to figure out when it broke. Let me double check, it would certainly
> make more sense if it broke more recently.

I actually checked, it really goes back that far.

> But there are a lot of reasons I still think it should be fixed:
> 
> 	1) I have ixgbe and i40e cards in one machine, the mis-match
> 	   between the interface naming pattern is irritating. Can't we
> 	   at least be consistent within the same manufacturer?
> 
> 	2) The new names have zero real value: "enp2s0fX" vs
> 	   "enp2s0fXnpX", the "npX" prefix is entirely redundant for
> 	   this i40e card. Is there some case where it can have meaning?
> 	   I apologize if I'm glossing over something here, but it looks
> 	   entirely pointless. If it solved some real problem, I'd be a
> 	   lot more amenable to it.
> 
> 	3) It's a userspace ABI regression which causes previously
> 	   working servers to be unable to connect to the network after
> 	   a simple kernel upgrade.
> 
> And, at the end of the day, it *is* a userspace ABI regression. If it
> matters enough in ixgbe to warrant a *second* userspace ABI regression
> to fix it, I think it warrants that in i40e too.

I just want to be clear: I'm not here to whine at you all about having
to spend ten minutes fixing some configuration files. My goal is to save
a bunch other people the trouble of doing it over the next five years,
if it's not too late.

If it is true the majority of i40e users have converted, than yes, this
should stay the way it is. I'm *very* skeptical that would be true only
19 months after the release... but I don't have any real data to argue
either way.

> Thanks,
> Calvin

