Return-Path: <linux-kernel+bounces-856118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F337BE3248
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205FB1A60FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148C31690A;
	Thu, 16 Oct 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Zn1ppHKH"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F5215F6B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615147; cv=none; b=qaDUcgQ/nKf2oxAa1t/grLh7f/Nf6VZd86iQo5O4chSFq6Oy9uoSKtE0wdnifznL0ZRlZEQgDoVp9+k5m9e/DBtn6Z+s79kS8gKj+/GJY4+fVIZjceRabZMsZJp3Q/iW9qtTyIBRuZN4uI+rSfYjkdzw1IKLs17wUP273KU63Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615147; c=relaxed/simple;
	bh=KhvEm4XFWGxbCXqhwXamgxBv8272sn5H3qSFc0nk0nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YouhJ5hPed3KjZ4KZVseFhVodANNqNQ/m1+vHEgc3aiHFEq46mGGrdJaSrjsq6smf7ugQFkjf+8cI2zVwfiunSpC3NIVBgeRaMJSqi2+CHcfPABOJij+pB+86cX6KIq/dPJNf3Zqd5TNYgGwoE1Gg0m4olIe+geYDKErUbprGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Zn1ppHKH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b50206773adso347499866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1760615143; x=1761219943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9ogow/MCxwC6xQPq5tlB+OoZn7KTGO1gzWJixSspeA=;
        b=Zn1ppHKHZ+o4XR5K+7kYdLB3khls5GqDiEahqZK8grKGdv3DLCkLRGyyp1xJIBefvM
         bYhTWoW6RDpbEBTBnqUHe7yFx8h9j6VZ70F3irb6YU1YjGLv2aeV9pdyAyGBF3d+E/pE
         D6fTy4C9Pu6mfFGvGC08c64P+5ly6b0BwXoAKK5JMaCvoMeWNvnvtT4atVoYMIghoCPl
         xuzJVZq3gchXOuXfbFGMFJIJIW/jT57wyHoKN1hwO7xeWVlzWPr3/Ae7IsMDqSXvug6H
         m+d8zNjpjhRQCg9HiHh/XCJJtpqIhthpsAuKatRzvhuuhp/fIYWiGuyXprlaYaxl7usa
         yNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615143; x=1761219943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9ogow/MCxwC6xQPq5tlB+OoZn7KTGO1gzWJixSspeA=;
        b=AlFM3I9m5SQok3x9EtsfxIWVwxMZ18ynMMNrSPFihAkQ2+kktuioHt8bem9fI8MWDf
         iv61rBgQKdvtZIGxX3FQvDWxYahH3QwlkYL0HYhPdbUhpfWIpt+8ByHc97YCf15NAZNL
         fPNlwSB363+6Fn3pdbd/S5ld02VcxlpiBEf9eSZOkaiXnYc5uzsMGQTtqx/0h9FFzXM1
         0k3Xl/RFTsZQkhhbTcm3bAAnwi0ywBBrGfLeyDY3HoeiKKzJfb7L7JvXmnFCfx8677oX
         rbqOPtbCm7ZgIIqoiuUKFhnM6KMPw/8477By2rqviP1++46IK/mcTzyZLQ/f64DSXQ1D
         CSVw==
X-Forwarded-Encrypted: i=1; AJvYcCVGNDR+fdt9dnTI8zzKIcZmtHA1SPT5x8gpxcWZJs8/TA9zQi0P/AASwAzM5jhuDHqDMs47jYj3A+V/lZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwzXeHCgLeaBBsRvI5HsrQS7hdQlFTQatkv/uW3C6/a4O//tAK
	5rq/nXJLR6BUWM0pzmjdBiHeKR7kwcdJHtadRL9TjqTVBozEEjKwEcPWqnhEfxqZKyc=
X-Gm-Gg: ASbGnct/NJrisT0yS5C4TuAhtFk5Kw4yN++i3Tw+GLqBs/z6TCtpX4Q4YB20thb4b98
	q32TG89EiMrneQbLCaqRm6dkXDAWRd5r1Kj1zbGyntK1hQzYhKZ7847jkScU7L6UjkbglLYZgz5
	moG3WM8q7+17FW7Fmq1HZxKPtJZN1GDiyS09Sn61ptD8LooRGjAFzARPojiEbijpVopE4doRPS1
	5x0iKAKQd0alu5sMTupEqR19a//OVTj8H/49HKhUyUyljK7Pf2OKdKLUqnlgFpJbCVv0jeogTeQ
	TcGfRfqzLV97YBfxBCJrNQN+y7wDcfRC7Uv4V0/kzxqD8ZwDwQvRN4PasALgIzU/dWs3bj+ZAKC
	SRLpB3aazfTKWAgnKJPVe0KTVjRmoG02WAnP6t9TPqJKGIJ+RMcBRZXzwmP0HMOnSbduqNi0xpm
	sWe8Zk6Oa1nggIWGd2/mWJWPHsW2yl0L4egz7FLaFo4Mw=
X-Google-Smtp-Source: AGHT+IFfgI0RzU2YIEloFmDatyMK/vukia6tq364+UTKGou0F1vugc7gBfyEZ6gk3pRfF4mh6gIVJQ==
X-Received: by 2002:a17:907:60c9:b0:b4a:e7c9:84c1 with SMTP id a640c23a62f3a-b60521b11d1mr435792766b.7.1760615142901;
        Thu, 16 Oct 2025 04:45:42 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdacd88sm488482666b.43.2025.10.16.04.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:45:42 -0700 (PDT)
Message-ID: <bd16ced2-32b2-4f94-aedf-cfa8a955fa7e@blackwall.org>
Date: Thu, 16 Oct 2025 14:45:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] rtnetlink: Allow deleting FDB entries in user
 namespace
To: =?UTF-8?Q?Johannes_Wiesb=C3=B6ck?=
 <johannes.wiesboeck@aisec.fraunhofer.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
 Vlad Yasevich <vyasevic@redhat.com>,
 Jitendra Kalsaria <jitendra.kalsaria@qlogic.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gyroidos@aisec.fraunhofer.de, sw@simonwunderlich.de,
 =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
 Harshal Gohel <hg@simonwunderlich.de>
References: <20251015201548.319871-1-johannes.wiesboeck@aisec.fraunhofer.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251015201548.319871-1-johannes.wiesboeck@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 23:15, Johannes Wiesböck wrote:
> Creating FDB entries is possible from a non-initial user namespace when
> having CAP_NET_ADMIN, yet, when deleting FDB entries, processes receive
> an EPERM because the capability is always checked against the initial
> user namespace. This restricts the FDB management from unprivileged
> containers.
> 
> Drop the netlink_capable check in rtnl_fdb_del as it was originally
> dropped in c5c351088ae7 and reintroduced in 1690be63a27b without
> intention.
> 
> This patch was tested using a container on GyroidOS, where it was
> possible to delete FDB entries from an unprivileged user namespace and
> private network namespace.
> 
> Fixes: 1690be63a27b ("bridge: Add vlan support to static neighbors")
> Reviewed-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> Tested-by: Harshal Gohel <hg@simonwunderlich.de>
> Signed-off-by: Johannes Wiesböck <johannes.wiesboeck@aisec.fraunhofer.de>
> ---
> v2:
>   - completely drop the capability check in favor of changing to
>     netlink_net_capable
>   - describe intended behavior already possible for adding FDB entries
> v1: https://lore.kernel.org/all/20250923082153.60030-1-johannes.wiesboeck@aisec.fraunhofer.de/
> ---
>  net/core/rtnetlink.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 8040ff7c356e4..576d5ec3bb364 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4715,9 +4715,6 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	int err;
>  	u16 vid;
>  
> -	if (!netlink_capable(skb, CAP_NET_ADMIN))
> -		return -EPERM;
> -
>  	if (!del_bulk) {
>  		err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX,
>  					     NULL, extack);
 
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

