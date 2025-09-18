Return-Path: <linux-kernel+bounces-822907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66597B84F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB737C6A38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02E7224247;
	Thu, 18 Sep 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qos9mH/I"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1351EEA49
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204081; cv=none; b=BeTxTrnbs5fsBI4qCx2IY79SvlvMgj6LgxFppS907wHr/I6j/ao//pEN6YWlUHzxdkNyo+GaHxKKjz1W2C879smD+8QWH3g/pprSLWQDKmcYPro+LYZcjkM0isz4AwD+V121XWyyIUI1aCFC0MMIelXdDGdQVER5bT6UGm1yYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204081; c=relaxed/simple;
	bh=nQXbNFRGteQ5sQcKTS+R+cIbFxjMYn75rSXxx/muXvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYdGVuLUNQ65n9+W6UCxZSPqOzrmntczEhXnHP/5LguaOlnzlMMm6Gm1u2sBNmpBe+47eJ1SPcGrCL0NZrmGNe4jXhofmGI3q/jtsvi6v+a0uNohqDAQK7aZWfIew0KsKpSoVJYn7chE6Jzue9cReCPfkrGQf/3vHy9MxiyGja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qos9mH/I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dec026c78so9295765e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758204078; x=1758808878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaWUgxon+Xb6FrjH6O0C9Bi3oSkKAAwiP/2JQApbLis=;
        b=Qos9mH/IU+BH3k+ZIMfXBfwRConV9XRfl+E7gVzH4+ozQZbLWTVqRiCP0xuiUOOZ8i
         3N+++0buPi8GLVKe8ikVdECiGXIN5+MkF/ENgdGc9XhKVAtCeLIqnNUqiHy3E7w3ghDD
         v+ezzJpLNKyelv6CXJJ/NFK/eeVTkLq17Ck4RIS44OKM+eWpqDmfEj6cOvalOsH/2/D1
         +u1sRk1X6s5ND7dVoz1OHoXdv66NNlpW1+JpoZi1adrTEBgwkEFEH6gCT+a1Tqbs+3ZL
         08L+d0RwkHUMakfdU52W6Cg0N7fkA2yqbMFbt2piEQ6EP/tG2mugESXigtRqGCSHyz3/
         pKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204078; x=1758808878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zaWUgxon+Xb6FrjH6O0C9Bi3oSkKAAwiP/2JQApbLis=;
        b=NshCmeP11Bf7fbrpSRJHHkAOa3UwqkhydYdnFcGVZRe8p6gFcM1m/UwqwdL72hfpQI
         2NVUEHeVImZr+JIn29jjiDjZSbqOZEwFq0pJm/fZxrpVtMBLWpTWYago/MbXCpvtu5x3
         sCqMxZOfXsGQ6U4lHG5v1MTq+CwkR9vGrmeihhnOpDd9aPjtHcYfebx5NcHumzGMQPew
         /ISvtogMasy+qvhEStYn/JXmJyD6YjhKH5zSAbGxF3PoA5huXn3ZbZZbiSprjSSZ8cGN
         2s5eKozJeW9FmvFd3KOXgDrL9yXZz+o4I9sJG57PSHXa9+lTL7KZXm3MH4i6UVQHLrBu
         xg5w==
X-Forwarded-Encrypted: i=1; AJvYcCU/++OToJo6OQ1B1zAVax5favxC4vofPtQ8hWi/UbF0jX1QibE2o1Cmogj2JiSzy20Xgikn4aBhKi+x15g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVA5PBI7Pyq6LoZJM9gAi2HJS4Thodm/f1crXANm+SC4bRNrR
	86oeXJvONhOdeb7Im47/DFQ9594zE6E3jB+ovX9HHogaRK0Dw2WvI/sz
X-Gm-Gg: ASbGncvj+HA82JwCrp1XI9MjHMG/rWbwlUTgVwdCc7CdbnL4O5DrkFFLnw5fbngdCRf
	vFkTXzwJOwCk8RjstckVGU6RStkpul8/Tq7LVkBqdBAXBsABZbiOI8NubdtJ/KzG2wStEUdwqxo
	y/OZsFLjLxYaYIrLs3A6xOUBPaEuxJTGdTV1Oor24VuJZO0ecScxMsjzZXYgbJHxPSFYijXMhpr
	uMjMB9+7JA6MwMjxsvZXKCuvegjO8ho/EoGp4n1B2E4upOA9UBti1+w0Z1fHK1JpiNxIi5Z7yWk
	pVZnojTmSSLpnMkX/ku0xTwsys3IcMU86QSyW5kOLJFGPhFSRO3q7vQy9hybj/7E4tlRYQrf8J+
	AfgkwtN+i1HHHYFDDpGmirdev5VxmevLm+HOK9AfQxw==
X-Google-Smtp-Source: AGHT+IERhi0ttbTQo7U5CDSJQlptbQTdHlo+lnabNgzEp0i9XMu8w6gt9JnH1CQDgn2GAUpwL99/Jw==
X-Received: by 2002:a05:600c:350d:b0:45f:28ed:6e22 with SMTP id 5b1f17b1804b1-46202175f42mr59095015e9.3.1758204076009;
        Thu, 18 Sep 2025 07:01:16 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461eefee9f3sm77154855e9.1.2025.09.18.07.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 07:01:14 -0700 (PDT)
Message-ID: <84aea541-7472-4b38-b58d-2e958bde4f98@gmail.com>
Date: Thu, 18 Sep 2025 16:01:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 ecree.xilinx@gmail.com, willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-5-richardbgobert@gmail.com>
 <c557acda-ad4e-4f07-a210-99c3de5960e2@redhat.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <c557acda-ad4e-4f07-a210-99c3de5960e2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 9/16/25 4:48 PM, Richard Gobert wrote:
>> Currently, packets with fixed IDs will be merged only if their
>> don't-fragment bit is set. This restriction is unnecessary since
>> packets without the don't-fragment bit will be forwarded as-is even
>> if they were merged together. The merged packets will be segmented
>> into their original forms before being forwarded, either by GSO or
>> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
>> is set, in which case the IDs can become incrementing, which is also fine.
>>
>> Note that IP fragmentation is not an issue here, since packets are
>> segmented before being further fragmented. Fragmentation happens the
>> same way regardless of whether the packets were first merged together.
> 
> I agree with Willem, that an explicit assertion somewhere (in
> ip_do_fragmentation?!?) could be useful.
> 

As I replied to Willem, I'll mention ip_finish_output_gso explicitly in the
commit message.

Or did you mean I should add some type of WARN_ON assertion that ip_do_fragment isn't
called for GSO packets?

> Also I'm not sure that "packets are segmented before being further
> fragmented" is always true for the OVS forwarding scenario.
> 

If this is really the case, it is a bug in OVS. Segmentation is required before
fragmentation as otherwise GRO isn't transparent and fragments will be forwarded
that contain data from multiple different packets. It's also probably less efficient,
if the segment size is smaller than the MTU. I think this should be addressed in a
separate patch series.

I'll also mention OVS in the commit message.

> /P
> 


