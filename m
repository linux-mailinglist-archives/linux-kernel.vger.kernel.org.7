Return-Path: <linux-kernel+bounces-733878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717EDB07A22
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D00E3B5295
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E89F28643D;
	Wed, 16 Jul 2025 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="i1kO+21c"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4391D79BE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680572; cv=none; b=Bbv5G2TDfmGhPjgsnQ1LMssXoF5iTiO+PZz4K74kn6oHpOOnMSMP8C7XONtDjgMz7hpSvwhby5bQS2sFXgHY96P6lsLjxBSVjCdXmpXIE/2ncsRWgaoXwmhPcoxTpJlnfqY40HGERaowRq4KZqFZU8tJ8brPSwxcLyI1VbM4bbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680572; c=relaxed/simple;
	bh=LkfYF7pYFAHo2uQSC7pPYzH3bZTmHka3sLvqjeIRpbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkF9e/orq9rCdPlkEddzL5/zibOfuI7RcJZK4v7DgT9iVijBisSBvhoTFUigoqhLvMBlf9JsiLBCz1W82Q0PqtVnab9ptgZrWxyW80gnhe03lLzaYZ1v+TwXfAdNHOAU/IB/VaofGPazkG6b/vwz/ZUcopT9z4IxXnp/jIoZmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=i1kO+21c; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso11772466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1752680569; x=1753285369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxjVPc9lLv7029fkYsxMY5nTf0b4uYTpgTGxXCLpHBQ=;
        b=i1kO+21cCeo7W1/aDgEkRR9vtxOOMn9LoyV1Esz8w26gSg6bCy+sqxAvxnfBwc6IQm
         GlslMeGi8Vx4CHnp4R5BuaeS8JAudfGweM7G+TCTxmyACQJGGft4xlI6ifHsmOeTq0dV
         NC292onhmtdzfCQwJqZX/+YjzcGIKjHrsaRYDkP+/uuOPN5buq2j+NNKHmyXJOU4OKoM
         J9EpoT9b6XrXDS9r0gnnv267tm+fYCnRRekcm59QOQNZVQMD+zwmnHp5rFFn4kAGP1qS
         tAwHDU80L3vUHbHa9zjlVjxWVGCLMGSnRUIfPIygmX473WJZFglkmTdRPahBV/NIl9eJ
         QofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680569; x=1753285369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxjVPc9lLv7029fkYsxMY5nTf0b4uYTpgTGxXCLpHBQ=;
        b=fQ+wyTnmcIVMuMMvIzwjIUbvyK5rzBuucvEcOJnlzl4uqhAqi11HNKdVnjPg4hrbd/
         XYGdN0jHRjeJUIOIYkZhTFdguUJl+7qXUiE5e8ELRS+Yfx0I05AyY+v1soKKdwfw+22S
         h1trnKhQMwP5pNWSCXKZRMdQkUcKrIZ/B01fdQRVE/sA7GtdMqoXJnZ99CVZGaltbzg1
         BknzE8YOr5HE6KyRZuUHcjXRZ4ootiHmfN/as24HNCtN4/t4Junn41qb55RiSfE/TsvU
         Bm0EU1g1XZLtNnRszPER9V0ebXd2zQZqGwaW0ZZzBteABUBs2dboudzjtDsYRYKCyMax
         tUxA==
X-Forwarded-Encrypted: i=1; AJvYcCVewS608Fm2sdQLlfuQB2V92hg4KKj3ENYfmGpJDKwV4RSLwEi/tUZWUXhJN7dGGqN8m0sX+bPM4AnMfW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0KHwve9di7niy4wVAQCJOMpnWy3ql8kT746RhQK3Rg760QP7
	qlyBA66HwqvJMrh7MC5ETkP44gfq9OHkG+02+/VwalSfbyQmnEe+Z+Ga2hEeyr8R0oI=
X-Gm-Gg: ASbGncv7V5FqacVKPskzTyjiHAMFE+9HzPtSidY31/aYcNm8CDNpnb0I0wVuYYK48TF
	0TZRob05ZtIKfWzo5LfoqrCgWPNBjQdJIoZ+6gA6DqGeiW6j5l8PRUZ37X+oeoyUs8GwL7jOYi8
	E6wLU834VCbRPqTNeL/8c479TJQE2PCg3wpb+P9td+EAEBhtYWRSGLl2dCe1whSbkpcNBKmncJY
	xiOjmho5+ui+2hTAbPkA/H48zsjACsPEBWDAnUdPPWtG94PsoHrd9Q+gs546Qj5N8AeYIELwYLe
	Oplwn+JQO5/1Z1ufhCZObqHmX363ieOL7mJ4b2G3+A8jx0H4y/gYky9opDpvJJjvtVj3HUlrUHU
	Tb4nSwLoPbIuDe4WMEKIBMTfvzqCOZZmV38k6JqBijdfG6F85KCdmOQ==
X-Google-Smtp-Source: AGHT+IEXxAmRZhBfXJJ6RXAaXnDHc3IiJuVLZMZWlWOmL9qwv0jbe41xNN9dmF6K4gloyVg6nJBmJw==
X-Received: by 2002:a17:907:3f94:b0:ae6:d51a:4ca3 with SMTP id a640c23a62f3a-aec4cff8016mr2809166b.25.1752680568653;
        Wed, 16 Jul 2025 08:42:48 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2efsm1217605566b.151.2025.07.16.08.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:42:48 -0700 (PDT)
Message-ID: <1757a42e-573c-41ab-b2c4-b8e1f2c8f46b@blackwall.org>
Date: Wed, 16 Jul 2025 18:42:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] net: bridge: Do not offload IGMP/MLD messages
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/25 18:35, Joseph Huang wrote:
> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
> being unintentionally flooded to Hosts. Instead, let the bridge decide
> where to send these IGMP/MLD messages.
> 
> Consider the case where the local host is sending out reports in response
> to a remote querier like the following:
> 
>        mcast-listener-process (IP_ADD_MEMBERSHIP)
>           \
>           br0
>          /   \
>       swp1   swp2
>         |     |
>   QUERIER     SOME-OTHER-HOST
> 
> In the above setup, br0 will want to br_forward() reports for
> mcast-listener-process's group(s) via swp1 to QUERIER; but since the
> source hwdom is 0, the report is eligible for tx offloading, and is
> flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
> well. (Example and illustration provided by Tobias.)
> 
> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
> v1: https://lore.kernel.org/netdev/20250701193639.836027-1-Joseph.Huang@garmin.com/
> v2: https://lore.kernel.org/netdev/20250714150101.1168368-1-Joseph.Huang@garmin.com/
>     Updated commit message.
> v3: Return early if it's an IGMP/MLD packet.
> ---
>  net/bridge/br_switchdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 95d7355a0407..9a910cf0256e 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>  	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
>  		return false;
>  
> +	if (br_multicast_igmp_type(skb))
> +		return false;
> +
>  	return (p->flags & BR_TX_FWD_OFFLOAD) &&
>  	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
>  }

LGTM,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


