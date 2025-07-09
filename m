Return-Path: <linux-kernel+bounces-722994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9874AFE17F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35700179C86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E229273D8B;
	Wed,  9 Jul 2025 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Fyx0jAOV"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382F272815
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046678; cv=none; b=D7qclAjN2aPBKQcg8Qk4NEw6N++3c5hDGqjz4EaOiM2i+pux4znH94PdSPaCZPoVclzoxO2welWw6q2a0/rOrdPCDjZ2yRUG+1Vx9tZPMlR1R/km6ZcmGpFdNxZ2/LqEYd+4MBNGan9nEiuvM7QB117KFMmAQgj9Oa54nK/JGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046678; c=relaxed/simple;
	bh=9OPmNg1Ke93Fs8SkZKBisFI6U+uVxoHqsm9QDX67Rgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxZRcq3Z1emgH7uiS+e/q7n6vo8AArsms4c9UMyq2uXmX2EkRkTnrRQ4XtJ8Gg1aWehanU43Kp+WINMCuOzBd0rFDx/uiDLRxG4CSbzGbaX+qwCr4iINI9Ua57n0dgjZWjVEjbDWOoED5L8ePWXnzXCkVXBnfj5FAw3EMumeyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Fyx0jAOV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso911070666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1752046675; x=1752651475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AF17i32IwMLY62AXSip2mxJYEDMY02Ret/Hrjg5ZK0=;
        b=Fyx0jAOVtP481WsWBZ5NWcYpPL1fT5ZKqKrZq+LAj+HgBJf945INpeqp56yXMTt9BI
         1eE9321Nax0+yrQnBRuLuX384KLwGUk6XIEy9adBSzXKf+tGIFjiN/uRiRBdzouYiHnM
         ZqnTu4cQNzotKyKcUHeaImmmetjzNbVlzQtq+r7UDGMN6AuxbtzZQEGEtQaQLD6xFdOB
         mEGrJdrpxT0NLzlM7ZjgqlGsUQVNgRh1EoZ4mQJfs4xByBRUu5IzeehyDSSuLUl4mdEt
         XgBN7nNkfWDPUra62kCWaPl94JtN+PGIVnZKKT+YTh5KAV7PRbINNxTZZOXlPF7D7tLx
         0grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752046675; x=1752651475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AF17i32IwMLY62AXSip2mxJYEDMY02Ret/Hrjg5ZK0=;
        b=LDqvMZ2Rk52Zaig9c9GLF9n+c/1x7Obk3hdHQ5OTHlPmabaLO/bUK7edIhvrlfu+w8
         13vPHg807+k85rzpRhELBZ1Ro/+xBUvot4rdI2JqOyt0G44jCsoPqkzilhRQV8Svwlpr
         mk7uSacBtPxexaNEoGINpW0iuZUqNWM3v9DIMipCNHcCRzyGnccbGgRFpAmVZ4zj1Xjy
         QKgU3APsXZ9DpIYKWdDjzupHjhbVwgz7FGKMFFIQT12203ccCdwonWvsStIWRAkt/Rqc
         c9rqCEvETf+gfVnJC5kGB3sD4sheP/ddZHXMh1v+8cqQ0+2qSX5mryQ0TgcSUq7t77JG
         ZHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI9yrU+owPjop7Wan/Zxjyn2fdXVOx8veXoVhAWFoS4nUxxeLs84w574BNrImQa+QXJOWQvAsIxTdNaLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9VzYy/sgQvWvd3m5t5IkaR2CzP50P9lC5go4qlI0Wf6euLAK
	Re8C+X0mgmYIwzANHBSRfUJESFz/XZR8LGc3QAOgI+6jwG4spgk92ZFRDWIwYll6iBSZLsAaHHe
	Zc92UG8U=
X-Gm-Gg: ASbGncvgpEPGPrOv/8vVKiZ5TwZmW4cVmbG5VbqA5epqrVUotnX0iSlbfd8C7QpU5A3
	FQ4s3z/0/ANMXN1COvTEehS5rB2DEHuyFr3Y2DH1sJ9YnqRHBaRd1abjdGfoi1Kdt4LDtUK6PG5
	CZPCF0KGUDpv0bm66i4EmlpnrBUq5vBopklTi+9067JlNZMlDyDggyEoFTQl2+8VLFh20B4mJ8A
	nChyzWFQf3D3S+JKjLDLi8kR3JyE83myQsunUNsobAiqbIK/TH3QpDsWa7i0Vvb8qWdYCZLPc17
	X86ZIiIUPSXIDd6Yr0e32QvDqta+6isMtC6j86//QJYZThnEMNyARF+s5uOBk8qDWaZNafM+qUm
	NHdrJfRWSHd8b+8delg==
X-Google-Smtp-Source: AGHT+IGKNKwRhwXTcmwtGN+5HGqX7L50fvavD2PabeX9y+OqiZC5bMINAl/BO5b4T2iWDRdBG72Lbw==
X-Received: by 2002:a17:907:3f9c:b0:ae0:cccd:3e7d with SMTP id a640c23a62f3a-ae6cf73f3f5mr147273866b.33.1752046674928;
        Wed, 09 Jul 2025 00:37:54 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02f68sm1054983366b.117.2025.07.09.00.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 00:37:54 -0700 (PDT)
Message-ID: <f382be0d-6f30-443e-b161-d1d172dcd801@blackwall.org>
Date: Wed, 9 Jul 2025 10:37:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 7/7] netkit: Remove location field in
 netkit_link
To: Tao Chen <chen.dylane@linux.dev>, daniel@iogearbox.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, horms@kernel.org, willemb@google.com,
 jakub@cloudflare.com, pablo@netfilter.org, kadlec@netfilter.org,
 hawk@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20250709030802.850175-1-chen.dylane@linux.dev>
 <20250709030802.850175-8-chen.dylane@linux.dev>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250709030802.850175-8-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 06:08, Tao Chen wrote:
> Use attach_type in bpf_link to replace the location field, and
> remove location field in netkit_link.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  drivers/net/netkit.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 5928c99eac7..492be60f2e7 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -32,7 +32,6 @@ struct netkit {
>  struct netkit_link {
>  	struct bpf_link link;
>  	struct net_device *dev;
> -	u32 location;
>  };
>  
>  static __always_inline int
> @@ -733,8 +732,8 @@ static void netkit_link_fdinfo(const struct bpf_link *link, struct seq_file *seq
>  
>  	seq_printf(seq, "ifindex:\t%u\n", ifindex);
>  	seq_printf(seq, "attach_type:\t%u (%s)\n",
> -		   nkl->location,
> -		   nkl->location == BPF_NETKIT_PRIMARY ? "primary" : "peer");
> +		   link->attach_type,
> +		   link->attach_type == BPF_NETKIT_PRIMARY ? "primary" : "peer");
>  }
>  
>  static int netkit_link_fill_info(const struct bpf_link *link,
> @@ -749,7 +748,7 @@ static int netkit_link_fill_info(const struct bpf_link *link,
>  	rtnl_unlock();
>  
>  	info->netkit.ifindex = ifindex;
> -	info->netkit.attach_type = nkl->location;
> +	info->netkit.attach_type = link->attach_type;
>  	return 0;
>  }
>  
> @@ -776,7 +775,6 @@ static int netkit_link_init(struct netkit_link *nkl,
>  {
>  	bpf_link_init(&nkl->link, BPF_LINK_TYPE_NETKIT,
>  		      &netkit_link_lops, prog, attr->link_create.attach_type);
> -	nkl->location = attr->link_create.attach_type;
>  	nkl->dev = dev;
>  	return bpf_link_prime(&nkl->link, link_primer);
>  }

LGTM for netkit,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


