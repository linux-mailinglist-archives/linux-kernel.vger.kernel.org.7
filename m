Return-Path: <linux-kernel+bounces-779455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFBFB2F453
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD063B2C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186592EAD01;
	Thu, 21 Aug 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7TAx8Tg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6022EFD90
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769361; cv=none; b=Ngop6NC+cPBINtz23yvLrG0zdXiHMKPbFSe01xoTiAsvb20QtQAR9PrwKPwuJTmWJFORwZDid+WRjHBdsfW8PjMMk2fqk9qb75nO8Tgve7lRaDB6h+koj8vmeAVUalE0+aUguflXP8hW17ZZfDuMAAlkxA1UtzNf61llB4LqMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769361; c=relaxed/simple;
	bh=Y/8/4xBnYM+a2pABQYuBM5lM5u9sXzSEfIpVTCZenc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFS9CEB6HCH1Iq383/VtTNwYxXgS9bwnXGN1iu/tY9FzAJpAUrLOpCMt0RxYF2hWVNqmUiyKfoQ+WA9JzVeRbN4uEsOAxR0Pm4nY5z8j7A+UTRoIcGvtYtFcmVLnbilVpsacGhWaa3aF0knsgVXFknF9pS6Uv1x6AXtSlTb11XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7TAx8Tg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755769357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7e/AESVWGY80+OX7Lbi81zvHgzcoacjfV+IOdwHfo64=;
	b=S7TAx8Tg09Q7RRTIcPsELr9A92FLss7JgRqhdFmHJeOsLDJ8OBHar0SB9P2u5Q4zdDP9BM
	ISqhHAtsOmEkHIvdNrPDLJgpOkHzq/odkddXdF4ZfTRieex/ywxDdiRuFiB/wuE90hcu50
	kLI143XFJnmfIGZWKQN0sirBHapVK6g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-6G0tKp6FO6-VGQuDageWcw-1; Thu, 21 Aug 2025 05:42:36 -0400
X-MC-Unique: 6G0tKp6FO6-VGQuDageWcw-1
X-Mimecast-MFC-AGG-ID: 6G0tKp6FO6-VGQuDageWcw_1755769356
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e86fa865d1so256522585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769356; x=1756374156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e/AESVWGY80+OX7Lbi81zvHgzcoacjfV+IOdwHfo64=;
        b=DAR3DHn9z3ua3AXCW3TnbdydoyLk/DCvZY2I5MZQ15sgZYIE2zoRAdvT2kdDRTWp/Y
         Uj2swUVFX262a0nZOdYxmbI3hp7y3pBg7Zt/CjDpsrgHAP0C0czIjoboqea6JSuXnRJR
         G2NZfjsSG2ZVhA8xRpav8JymmxynPDh9E0fyrSi7OeSk4XVjgb9dsnlN1stTejI1TooV
         rMXOo5VcrPruTqFHnGqevl7RzfEX/UCzULhyYVThf+yhBeqtcoN2b1Qj72hPoBeaJA/k
         zp2uDpuOqcqVOBz51B2ulTdT63UuTpFMA7w0xHsRrTBXKBN9G2FnNboSb7ssDc9QxCVW
         tXag==
X-Forwarded-Encrypted: i=1; AJvYcCVauAvihSOXht4NllN669Ahwds1rtErGXTPgvm8ekt7ru+tikKOY+1ynAkp5vaC9SmI9C4vYAJ8cwBFbm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzScOM26fEB87/jNmC64GGOKH6f9VJRtPNjwvXYBUoOrmzY5Jq7
	b6TgsfzF0bSE+lCOXdxqDUtTxRESG7uJY0LnkHrnA7ke/lLNULDv6E2atrFWiJZnwBiNKUFksI0
	UFOhlk82wFMjxFtw/zOQXzE9oRgCb9eXcvXGmIEuNmvreKA8V/Q90QKAbc6tAPbqDKw==
X-Gm-Gg: ASbGncteBx+KYFuFgFA093iKpgdwmYVQE1ZqNB9l1HzwdBCk8/SfuDhOItVO3AOUuQK
	5Kk0Nem69ij2Js0v1kQpJknYeRQdETaDVIBhgitSc6uAkZO0/wcKXs2W1C4ItKLgk8d337ivZHO
	diO7HbIDFZ3qyaqcQBwxskyhWpBPjzNLCp/c0Y5FOiQgPYvKFd3mV7FS/Sfp3EZDuVfDiyhJR5Z
	ohCCmz5jFx5nVDwsYAZGFp1jZgF+VItS51EZl7kJoEXPaZY7tv8Au2MOjfKL/DhGJylMbY3Lr1n
	LVX2oxtwJLj6jihup30QLfSBn8LpaOT6LDJJK1h43BsJLg3hLSOtWLq80No2JkbeOEtSFy5OUuS
	4LuUcy0b4wuY=
X-Received: by 2002:a05:620a:3943:b0:7e8:594f:d3d3 with SMTP id af79cd13be357-7ea0948de2dmr177139385a.31.1755769355806;
        Thu, 21 Aug 2025 02:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnj5oa0giFQO7yCjIQInKC3BV64wT5OGw8vHaBnbe4tBPDAmYH9TUEvawpexDCTQcgTiSnDw==
X-Received: by 2002:a05:620a:3943:b0:7e8:594f:d3d3 with SMTP id af79cd13be357-7ea0948de2dmr177138085a.31.1755769355405;
        Thu, 21 Aug 2025 02:42:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ea048399f2sm179119185a.42.2025.08.21.02.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:42:35 -0700 (PDT)
Message-ID: <4ff3b7df-cba0-4446-8411-7b99b5cdce69@redhat.com>
Date: Thu, 21 Aug 2025 11:42:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next] ipv6: mcast: Add ip6_mc_find_idev()
 helper
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818101051.892443-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818101051.892443-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 12:10 PM, Yue Haibing wrote:
> @@ -302,32 +310,18 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
>  }
>  EXPORT_SYMBOL(ipv6_sock_mc_drop);
>  
> -static struct inet6_dev *ip6_mc_find_dev(struct net *net,
> -					 const struct in6_addr *group,
> -					 int ifindex)
> +static struct inet6_dev *ip6_mc_find_idev(struct net *net,
> +					  const struct in6_addr *group,
> +					  int ifindex)
>  {
> -	struct net_device *dev = NULL;
> -	struct inet6_dev *idev;
> -
> -	if (ifindex == 0) {
> -		struct rt6_info *rt;
> +	struct inet6_dev *idev = NULL;
> +	struct net_device *dev;
>  
> -		rcu_read_lock();
> -		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
> -		if (rt) {
> -			dev = dst_dev(&rt->dst);
> -			dev_hold(dev);
> -			ip6_rt_put(rt);
> -		}
> -		rcu_read_unlock();
> -	} else {
> -		dev = dev_get_by_index(net, ifindex);
> +	dev = ip6_mc_find_dev(net, group, ifindex);
> +	if (dev) {
> +		idev = in6_dev_get(dev);
> +		dev_put(dev);
>  	}
> -	if (!dev)
> -		return NULL;
> -
> -	idev = in6_dev_get(dev);
> -	dev_put(dev);

Not so minor nit: if you omit the last chunk (from 'if (dev) {' onwards,
unneeded), the patch will be much more obvious and smaller. Also you
could clarify a bit the commit message.

You can retain Dawid's ack when posting the next version

/P


