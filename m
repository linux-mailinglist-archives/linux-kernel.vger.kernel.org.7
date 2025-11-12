Return-Path: <linux-kernel+bounces-896864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A158C517F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 456674FEFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871CF301714;
	Wed, 12 Nov 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjrGDI/N"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E52FF17F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940054; cv=none; b=Y3nxEQdIJHSAfDlJMF/DfGOhpYSoNhGDrQGh5J4OgbMUfzHld9w/tCDcgL7tzqRVFzwjCequb9NbYQ3av8T+xIRj9IWcYRDzJnItMMLHyIFRKZCGr5DwJ6Ecmw5UcOh+WTtRGHoosPs9SsrNMIQ7Jv+ehT7SVfi2BCSN+Z+ScJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940054; c=relaxed/simple;
	bh=x2jKNqGY/kiVKpHZUUrGXa1xAzr4YMtJ7n2T4FCXCgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gw5+s50PVuTWAPPKTsHG4xgl99OwD4p46CBvstzoN99TesAHrgFa5jA6xnnyCko3f8vbgbCSQG8fNQCNP9SweRx58CC3QJV9t3sG6b1kf+M3iPzvYYzrzZOgSUt0QESlp45FiMqdEZYxr6jE2TUBwlgCbgs/c9U4PivWjzYYYd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjrGDI/N; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso793287a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762940051; x=1763544851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+ph3n81MNofPspKtp5iN2RLnNXwZpO7ZQr4gG1y+Xg=;
        b=IjrGDI/NkqhS3NDtElz3W18OJX3jd4A2UQpatWoD5mbm7WgpXK6LHK2+BS/ywFOO4r
         DTFAwc5R0OC97BVil91RvUWrBewlI0zmsMlhaiynC3DIFunv40a/vyM5CgiCdnLwrn4Y
         FRQhR6eNToBo8P3Vp9xSlFvXyCGCr6zucmF7HmFoXDYnFsDkA+czHUwzJco+kWxKwtyb
         EmLZnqg+YhUd9BG1fMaJfRPdTMte0DIN0z1yiL9IaZjv/u8uwB49NZV+GFB1PvqVGhvb
         HVS5E70BQZk3efWO9HtbKhjbzM4Y/1ey3h/xH/sgRQ4Xpy49cU831BVYd7XgMYZLDhlu
         ZHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940051; x=1763544851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+ph3n81MNofPspKtp5iN2RLnNXwZpO7ZQr4gG1y+Xg=;
        b=YPDT1XGg6ywI7nwaZhckgYfc7OQfA/1SU4QNCbRofphJpbV91gHHopOCUnyM6giO7A
         5Aj9wWyjLarqRFAYY+0Tz53tRAZOL4OTHhp3DhIxqntOMfeP6MS73Gow3ohjelqURSkU
         9MCaQzo3V0us7b9D8Y/F9HOAs5qgL2FkkG8sDaryioMooA+G0pBx6F9VxcUSyKcSd43U
         hFge7oechDKEJtIjSTQG90RXpr1J5Rd78DI0vKlcaBbgxXV1XeiyZhKvku8UHbS9RdvX
         MYJUhgVQGXEiX/wK6y+X+NlF8ozxE4nwm0B6XwhYAwwRlGX6eGapV3Iyl74LIPiy+k+I
         GgLA==
X-Forwarded-Encrypted: i=1; AJvYcCUULsIF1fnQXAB/c5wCrDxapKyZvZj3Dn5BWIV48GHb/BiILVVDHtMvOq1erTDIta3eAcqPscMwe+/0kBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUK7/5aKOMcim0xQkWRkkVKcXsVzsvcOunTujGahy3BuRqDB0Z
	JPv2Cex64bDy7IXdJpWNLMBc87I+qEpPtgi8qmQvHGKecXhTDETjEL4=
X-Gm-Gg: ASbGnctAxUoD9Fpvot4v0GM8jE7p9NI3FRBNftf8Q+rnJLb1rQZBankD8Wkr/PGRMvA
	EPPjmmdATWp9hYy6gjHACP3QYHM2VJ2q+4R/s3yX9W93mizhRj4HqLhxeIehO1CD1+TxldYpm+L
	vAo0nGE7unLxewIskS2IbEB9fAOw8T2GhcSUXuuaBaOEjMWucj+bg1k4oUbD+b3DB86G7278NUc
	C6muJ01Rc4S9cgk3453wL/DTzbGbrD3+khefooiLptv8YSL0YJiOEcevKft84lspS7apMGRSHMJ
	f4yhObYuVzIqLjtwwuCZOGFV1BWAOF9dhEX8Y1n0fBmDcW7vQ/GcXHdAf33cRzFhuY9cRCFxuc6
	wLcZaWu4o+EIof5fpyZRdpyRk7LKjLq4RfapcBvDP/tjfpZnulhAU32oAmcO+gUwybgKdUk1t8v
	M1zQ/Vpk7gvA84uYxGUoY8QEFjFleI0+r8cXEg0kG7BQOjNABpCMvQ
X-Google-Smtp-Source: AGHT+IEbaOVdolpRZRtQY4C4p55uxdFbLWKLEJUaTQ2W0vBS9wly5TtrzUUAVAA7VNF0NNYTPywc0g==
X-Received: by 2002:a05:6402:3046:10b0:640:b814:bb81 with SMTP id 4fb4d7f45d1cf-6431a55e501mr1856940a12.32.1762940051127;
        Wed, 12 Nov 2025 01:34:11 -0800 (PST)
Received: from lithos ([2a02:810d:4a94:b300:ec52:7cf5:e31:cdb7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64165b2aa03sm9869160a12.6.2025.11.12.01.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 01:34:10 -0800 (PST)
Date: Wed, 12 Nov 2025 10:34:01 +0100
From: Florian Fuchs <fuchsfl@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geoff Levand <geoff@infradead.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ps3_gelic_net: handle skb allocation failures
Message-ID: <aRRUiYIrOcpSiakH@lithos>
References: <20251110114523.3099559-1-fuchsfl@gmail.com>
 <20251111180451.0ef1dc9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111180451.0ef1dc9c@kernel.org>

Hi Jakub,

On 11 Nov 18:04, Jakub Kicinski wrote:
> On Mon, 10 Nov 2025 12:45:23 +0100 Florian Fuchs wrote:
> > Steps to reproduce the issue:
> > 	1. Start a continuous network traffic, like scp of a 20GB file
> > 	2. Inject failslab errors using the kernel fault injection:
> > 	    echo -1 > /sys/kernel/debug/failslab/times
> > 	    echo 30 > /sys/kernel/debug/failslab/interval
> > 	    echo 100 > /sys/kernel/debug/failslab/probability
> > 	3. After some time, traces start to appear, kernel Oopses
> > 	   and the system stops
> > 
> > Step 2 is not always necessary, as it is usually already triggered by
> > the transfer of a big enough file.
> 
> Have you actually tested this on a real device?
> Please describe the testing you have done rather that "how to test".

Yes, of course, I intensively tested the patch on a Sony PS3 (CECHL04
PAL). I ran the final fix for many hours, with continuous system load
and high network transfer load. I am happy to get feedback on better or
acceptable testing.

My testing consisted of:
1. Produce Oops: Test the kernel without any gelic patches, scp a big
   file to usb stick and create high cpu/memory load (like compiling
   some software) or extract verbose, tar xv, a big file via ssh
2. Safely re-produce the Oops using failslab injection, so I dont need
   to wait for it
3. Develop against that failslab injection, high load and network
   transfer
4. First solution was to just always refill the chain, which resulted in
   RX stall after some time, as the dmac seemed to be stopped, when buffer
   was full and NOT_IN_USE head found and needed rmmod/modprobe to work
   again
5. Run the final fix for many hours while injecting failslabs, high load,
   and high network load with continuous scp and netcat
6. Further massive improvement is to convert the driver to use
   napi_gro_receive and napi_skb_alloc, but this would be a separate
   patch

> > --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> > +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> > @@ -259,6 +259,7 @@ void gelic_card_down(struct gelic_card *card)
> >  	mutex_lock(&card->updown_lock);
> >  	if (atomic_dec_if_positive(&card->users) == 0) {
> >  		pr_debug("%s: real do\n", __func__);
> > +		timer_delete_sync(&card->rx_oom_timer);
> >  		napi_disable(&card->napi);
> 
> I think the ordering here should be inverted

I thought, that there might be a race condition in the inverted order
like that napi gets re-enabled by the timer in between of the down:

1. napi_disable
2. rx_oom_timer runs and calls napi_schedule again
3. timer_delete_sync

So the timer is deleted first, to prevent any possibility to run.

> TBH handling the OOM inside the Rx function seems a little fragile.
> What if there is a packet to Rx as we enter. I don't see any loop here
> it just replaces the used buffer..

I am not sure, the handling needs to happen, when the skb allocation
fails, and that happens in the rx function, right? I am open to better
fitting fix position.

Thank you for your feedback!
Florian

