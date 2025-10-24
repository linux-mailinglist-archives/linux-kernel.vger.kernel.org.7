Return-Path: <linux-kernel+bounces-868994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD9C06AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C581C1A6275A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273311F542E;
	Fri, 24 Oct 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJTzsgoQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BA01F4634
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315643; cv=none; b=gCCFVAJ+LMH9pU7IpudLlmkN7rqCUsPb4UadK7mFphmEBGvvrgCJYWI2FW1XmpyxKl70M1iOwEG3kz1q+wnbl+uqRxm6P8kYlIrisBw4/4a135c+3a3gX7PZsHy1XbWK6PkQp6iZIsqB6P0HydiPIOQ7Cx11SXmsrLb0/rWDdmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315643; c=relaxed/simple;
	bh=7bNrS0idSyoOK5HTHFIzxp/9RrnqV0K6hYOGVJ2o9c8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=elLaFG7UV4IQKPtni9XknJJ734yN3dJt6dkHM9OAfCzmCKAMyK9Pon7Z/9enaKjafkrbh/xN4A20XlCBQsOuTZzq/+Mem944JaQwhs+INWw3AppD0Dm2BcRJUeHSNAoQ7LQqLh8Z0PH5EaI9mxvIcitXK3kWqqyH5wP8o4pPctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJTzsgoQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761315640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0zG4FmLeJZKywQ/yv1mXTKBR1/QBymmCDORQZLAZOU=;
	b=OJTzsgoQg4nCuYHEcADj1FAeNCZvkTXFI4pW27NSqEHP1VerYLs6Ov3aGCIGnhyHOM9QDj
	Y5qfsmhpNAgXJ9ptCU5U0MtEW0+6TsjegyHXxjULjjyr4gw7ZQG7TE7OLDl1WEpopMj6+j
	jEyxnpGKRb7pWiGQskkWNL/VguwaZHI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-zGv5lIKeOUCahFiYqDstiQ-1; Fri, 24 Oct 2025 10:20:39 -0400
X-MC-Unique: zGv5lIKeOUCahFiYqDstiQ-1
X-Mimecast-MFC-AGG-ID: zGv5lIKeOUCahFiYqDstiQ_1761315638
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-63c10d86ef2so2238337a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315638; x=1761920438;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0zG4FmLeJZKywQ/yv1mXTKBR1/QBymmCDORQZLAZOU=;
        b=lhPezonfWD7QiuVffU/q2On8jKYSN1wZRUsoQnDzCBMhcnkS7NCCNLr+iONT2Bfh3s
         QUtNiKhdMMqPpvemqvC3rkrrb8oJ5I0fg/ojuWgkNA5tfpwPLkCw/oz2xV+Q/6Zgq42k
         u3PyalgKaYU3ebADgX7VSBXZo0a8y6OCndTkmiDKm7ITbJtQDwXd5Xvn8ga6ENPMj3yk
         JFsmrmpRR9YuY8NLW3btlE+roHfjJJfCSTH1GwNiu3ZNW6CYmIBkkHNqh6LXadEuUKmt
         tECL0dmmOQfl50LklutL/vt99VvBX+RygditIDjnBEnlDbiXGGLA1hby38SQSlSh6WMx
         o6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCX7m4MR/ctajE9ouxvsqMJu/PCcw4u373jTIhIVD1aYf+r/XvxmKo8ew4FtcIHh5aMpW9xrVCF2EbcJnXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4R/vbTkxsz1Pa9RimbOAcXyYv5j+gg2rQNpGulkQg3px9nU4
	NWyZnPYzpisPw0cCNwhpSQ9T/xwPlw/BLHg1tHcgWts4baE147V26juiBx5IYiST+FyUc8r1LSu
	6WWG0E/odlMgiTvhA4WJbrldxCekZYiLCIxLJZPMCwWWbqOp+u7UqjGOvr3ua0BFBQg==
X-Gm-Gg: ASbGnctwahZ3SRQMQIit4ZcZeStvGHG8FyU4HUvKhpbm428RvJZ3EOTiQmcLBhoofaf
	lnVYtl1m8DD+Va9VqB80lAzXziqOVOm1ARNQMOOlJgUg65OaoCLGHYS+CDKBLAZ9ZxcgcItRBJ0
	wn0IyJwqzQbKkMRCsMfnuU9F5J5YfQBhOdwnGnYiDvi+P68oarhAUeGpIkwO6MkPvGUh9WYmGzw
	ASqVGCo0KO2FY3tAnOZMavPJHLmeZfL/rUYDVU7xykP8aJvkfEq6uLHiDybUbOmmB4PTvk5JXcR
	AZPC17WCgd4E/eiN38qxOGgJ2qooangiaHY80nC3SOla7WPLhZX/fCcMbGxxuiYtFYDZLQ7tUul
	PLVErVH5xoIxCmw0rAlNlUus=
X-Received: by 2002:a17:907:fd15:b0:b60:18d5:4293 with SMTP id a640c23a62f3a-b6471d45e76mr3455763066b.9.1761315638096;
        Fri, 24 Oct 2025 07:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh/0Q+22Fax089EqYk+r+im+q7S8/f/gRHSVQ7yD+yp9r3NCNb9dQdJV5y04Li0W418orApw==
X-Received: by 2002:a17:907:fd15:b0:b60:18d5:4293 with SMTP id a640c23a62f3a-b6471d45e76mr3455759566b.9.1761315637667;
        Fri, 24 Oct 2025 07:20:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d727b4338sm203849866b.52.2025.10.24.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:20:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4FB972EA574; Fri, 24 Oct 2025 16:20:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, Nicolas
 Dichtel <nicolas.dichtel@6wind.com>, Cong Wang <cong.wang@bytedance.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
In-Reply-To: <20251023083450.1215111-1-amorenoz@redhat.com>
References: <20251023083450.1215111-1-amorenoz@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 24 Oct 2025 16:20:36 +0200
Message-ID: <874irofkjv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Moreno <amorenoz@redhat.com> writes:

> Gathering interface statistics can be a relatively expensive operation
> on certain systems as it requires iterating over all the cpus.
>
> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> statistics from interface dumps and it was then extended [2] to
> also exclude IFLA_VF_INFO.
>
> The semantics of the flag does not seem to be limited to AF_INET
> or VF statistics and having a way to query the interface status
> (e.g: carrier, address) without retrieving its statistics seems
> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> to also affect IFLA_STATS.
>
> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  net/core/rtnetlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 8040ff7c356e..88d52157ef1c 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>  	if (rtnl_phys_switch_id_fill(skb, dev))
>  		goto nla_put_failure;
>  
> -	if (rtnl_fill_stats(skb, dev))
> +	if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
> +	    rtnl_fill_stats(skb, dev))

Nit: I find this:

	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS) &&
	    rtnl_fill_stats(skb, dev))

more readable. It's a logical operation, so the bitwise negation is less
clear IMO.

-Toke


