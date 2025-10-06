Return-Path: <linux-kernel+bounces-843156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CE0BBE858
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D511897D4A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E952D8791;
	Mon,  6 Oct 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9x7WclQ"
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDC2D8399
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765388; cv=none; b=DOckqEoM9tU5pkecfooLqpbmpTG4H2CQeolZdZjIHGbpBps0u/UmfqxznFbHZQe+cWFTu9OWAjRBEpfw8OyXJUEvKKxMsDQgTTCJ+Ip2CTq9A4HMnx8vqejecB6Tj/RvBcGtuN5Ii94TY3LEJFoVFOBThNGRACGrgl/qIvoflws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765388; c=relaxed/simple;
	bh=Sq6l5xabB9e+e6U34Yp8QyEMCZS5fpLuZ1RC7incO+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWPDPyNPaRVHTATGcBJoZ+QJG93swy4UhQV9iGmTN3l0bei/TW2wqiuC11/LcWh/t/nUnfD1UgywrclgIO6sRBGDEEWDQaoacj3cMRLGdoaiZt/+R/a0LGHtP1c3MGijilFwpxcV32bsQ/fPcGNloJmxnf+Qa/QHNu+TdnSvQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9x7WclQ; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-77f9fb3bea0so27955127b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759765385; x=1760370185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAe+1R0ImOzNI475E01dkfR+/+6aOuLI6QONqqqxB90=;
        b=I9x7WclQkl6qDxljhnz2EAFnkZqMEMZgqHWks6hQTosEwjwf++sH5ODEOU5CgZCYt9
         WD949Zkyg2iV6R0wTeCwSea98dQW8/x7nzH7ac6vKgs3QrW95xY4lSRyYNpE0+ZSkuDx
         sni2xdCWfH1sh0GfHXC0mgGmnQZ79GrKJ1LnvPMphA+KYXq0P5UK2f1pXWcMLP9V4R0P
         sFDYYnu0/aRGFacVq/wzM5VypNzWhS0LJFVR+GXuedQfwtCFEkWSy1qmF7CGriUopPbE
         eWNn15VQ7jfl9EU1n1Uur85YxTYJlEblcq70Si0j58xyFT/7D8r6ToEXQ7ZZ3/7DjsB0
         6qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759765385; x=1760370185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAe+1R0ImOzNI475E01dkfR+/+6aOuLI6QONqqqxB90=;
        b=hnFyOn2hrMXQAlXcrtV7QMID1Jv9zDWQ6J1ra9B0KGThRBQbdZFLGMLd/8oDY5RW6D
         tjIYrRRvYbh+CRnRo+IQ59vdNbpD0016LkZIjNRiBJjZU6OU3PU51KLlmK7MwPc1bNLK
         B9s4Z0AYOHASZau3xUBClCU/kom3hrYTxBBREuoRo1P4nTqCL93SYOlmJTVMsnqNJunE
         klzp/W6CHuwsBSxWZkoVtqhQRsmWJxO/L5kvLKHEVWbqUOibzepHIO0xBelTdeVhRJjC
         whCQPOyeOtfou9IeHv89/mvWpbrM3fTYOPkEZnedDlxD4RSYVg3KlMnj4EqsQsw9ncg5
         1S4A==
X-Forwarded-Encrypted: i=1; AJvYcCVSgJ13yhSaEsJTZKlG+cAJuvozmtJOFlLFGcytUxCm5ul7NFxuOOmU7N5IYHqbB9S4hMMIWbrwhfRWtLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYb553uHScEahFuuOkzIyBW9r6JLrZ82g3HqlQZb4juthrhZe9
	R4QuVO63/zH4gJjrKde05hO42z9RbLi+62wCIJq8BZEbv2lEV7jRa7pw
X-Gm-Gg: ASbGncvsJmUMfLeidlWPjV4HDU1i7S3+GRyqGT6HRZHUndMs/JIVSiZdFwdIV8P9naG
	MU371oo49jZ1J/+8vRgSb/RPfOT2ZuzakSci+rkNSq2eL9LjfuEtN3QGA+5uR89Qrqe+D/VfH10
	uCnBIJ8MZ6fKwDLbBumknlFZqwDwXHVLwdqyBrevA8do33feSoCvWC48Kc+9spg1PRxg0ttEbf3
	opDf7jyyvJh75E1VZEbnRCO5K4Ahsd+iIc22AuXlB7ToKwdIoMc/4aYVWP8yiNMSidjfzHoOfqR
	6eUGl5SLb5JqOhVI7z0O5++LBxKdRbdyfQXYKGfos4nLbwpB/JhQ4G56JqYiU3/rqxrH+s6h2b4
	xNq6sbcIw9RPBk02ZsZk/VgTdHPKxxvORSb7/1LBod5qKZQ5VoHTuOp19wX1YzNcrenh2w7yigC
	d1i6O/PNtAgA==
X-Google-Smtp-Source: AGHT+IFY8kuDypIqImPefgYyCAzqc7QXd8Vok4gUo6a6htfoqAVFzbCA36siBwVWpS4uIroE6Hc6hQ==
X-Received: by 2002:a53:c042:0:10b0:5f4:3486:edb3 with SMTP id 956f58d0204a3-63b99f3508cmr13089941d50.0.1759765384581;
        Mon, 06 Oct 2025 08:43:04 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b846a7b95sm4465545d50.24.2025.10.06.08.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 08:43:04 -0700 (PDT)
Message-ID: <9cc66694-6fcd-4460-9bce-cdbcb0153a89@gmail.com>
Date: Mon, 6 Oct 2025 11:43:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Trigger host query on v6 addr valid
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 Ido Schimmel <idosch@nvidia.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
 <aMW2lvRboW_oPyyP@shredder> <be567dd9-fe5d-499d-960d-c7b45f242343@gmail.com>
 <aMqb63dWnYDZANdb@shredder> <aOEu6uQ4pP4PJH-y@sellars>
Content-Language: en-US
From: "Huang, Joseph" <joseph.huang.at.garmin@gmail.com>
In-Reply-To: <aOEu6uQ4pP4PJH-y@sellars>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/2025 10:27 AM, Linus Lüssing wrote:
> On Wed, Sep 17, 2025 at 02:30:51PM +0300, Ido Schimmel wrote:
>> But before making changes, I want to better understand the problem you
>> are seeing. Is it specific to the offloaded data path? I believe the
>> problem was fixed in the software data path by this commit:
> 
> Two issues I noticed recently, even without any hardware switch
> offloading, on plain soft bridges:
> 
> 1) (Probably not the issue here? But just to avoid that this
> causes additional confusion:) we don't seem to properly converge to
> the lowest MAC address, which is a bug, a violation of the RFCs.
> 
> If we received an IGMP/MLD query from a foreign host with an
> address like fe80::2 and selected it and then enable our own
> multicast querier with a lower address like fe80::1 on our bridge
> interface for example then we won't send our queries, won't reelect
> ourself. If I recall correctly. (Not too critical though, as at least we
> have a querier on the link. But I find the election code a bit
> confusing and I wouldn't dare to touch it without adding some tests.)
> 

I agree that there might be some corner cases which the current election 
code does not handle very well (one of them is outlined below).

> 2) Without Ido's suggested workaround when the bridge multicast snooping
> + querier is enabled before the IPv6 DAD has taken place then our
> first IGMP/MLD query will fizzle, not be transmitted.

This (#2) is what this patch trying to address. With DAD enabled, the 
first MLD Query is never transmitted. That essentially means that the 
Robustness Variable is 1 (which is not very robust).

> However (at least for a non-hardware-offloaded) bridge as far as I
> recall this shouldn't create any multicast packet loss and should
> operate as "normal" with flooding multicast data packets first,
> with multicast snooping activating on multicast data
> after another IGMP/MLD querier interval has elapsed (default:
> 125 sec.)?
> 

Some systems could not afford to flood multicast traffic. Think of some 
resource-constrained low power sensors connected to a network with high 
volume multicast video traffic for example. The multicast traffic could 
easily choke the sensors and is essentially a DDoS attack.

> Which indeed could be optimized and is confusing, this delay could
> be avoided. Is that that the issue you mean, Joseph?
> (I'd consider it more an optimization, so for net-next, not
> net though.)
> 

I'm not sure this should be categorized as an optimization. If we never 
intend to send Startup Queries, that's a different story. But if we 
intend to send it but failed, I think that should be a bug.

>> In current implementation, :: always wins the election
> 
> That would be news to me.
> 
> RFC2710, section 5:
> 
>     To be valid, the Query message MUST come from a link-
>     local IPv6 Source Address
> 
> RFC3810, section 5.1.14, is even more explicit:
> 
>     5.1.14.  Source Addresses for Queries
> 
>     All MLDv2 Queries MUST be sent with a valid IPv6 link-local source
>     address.  If a node (router or host) receives a Query message with
>     the IPv6 Source Address set to the unspecified address (::), or any
>     other address that is not a valid IPv6 link-local address, it MUST
>     silently discard the message and SHOULD log a warning.
> 
> So :: can't be used as a source address for an MLD query.
> And since 2014 with "bridge: multicast: add sanity check for query source addresses"
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6565b9eeef194afbb3beec80d6dd2447f4091f8c)
> we should be adhering to that requirement? Let me know if I'm missing
> something.
> 

This is what I meant by ":: always wins":

In br_multicast_select_querier(),

	if (ipv6_addr_cmp(&saddr->src.ip6, &querier->addr.src.ip6) <= 0)
		goto update;

If querier->addr.src.ip6 is 0, nothing can be less than that, so ":: 
always wins".

However,

1. querier->addr.src.ip6 is (un)initialized(?) to 0 (I couldn't find the 
place where ip6_querier.addr is initialized)
2. Querier election cannot take place due to the comparison above, until 
the bridge selects itself first via br_multicast_select_own_querier()
3. the bridge only selects itself after the first successful Query is 
sent to the host
4. br_ip6_multicast_alloc_query() will fail if v6 address is not valid

So, without this patch a system would have to wait for

31.25 seconds (for the second Query to the host to selects itself) +
~125 seconds (for the next Query from the real Querier to arrive)

in order to receive multicast traffic. For some embedded devices that's 
a very long time (imagine turning on a TV and have to wait for 2 minutes 
and a half before it starts working).

Thanks,
Joseph

> For IPv4 and 0.0.0.0 this is a different story though... I'm not
> aware of a requirement in RFCs to avoid 0.0.0.0 in IGMP
> queries. And "intuitively" one would prefer 0.0.0.0 to be the
> least prefered querier address. But when taking the IGMP RFCs
> literally then 0.0.0.0 would be the lowest one and always win... And RFC4541
> unfortunately does not clarify the use of 0.0.0.0 for IGMP queries.
> Not quite sure what the common practice among other layer 2 multicast
> snooping implemetations across other vendos is.
> 
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0888d5f3c0f183ea6177355752ada433d370ac89
>>
>> And Linus is working [1][2] on reflecting it to device drivers so that
>> the hardware data path will act like the software data path and flood
>> unregistered multicast traffic to all the ports as long as no querier
>> was detected.
> 
> Right, for hardware offloading bridges/switches I'm on it, next
> revision shouldn't take much longer...
> 
> Regards, Linus


