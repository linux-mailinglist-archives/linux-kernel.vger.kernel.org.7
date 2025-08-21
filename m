Return-Path: <linux-kernel+bounces-779416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8941B2F3D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706613BC1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AFA2F1FF9;
	Thu, 21 Aug 2025 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AM5fe4ma"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EE2EF655
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768212; cv=none; b=E22DgoJYWBqNmvmP4GLl1pbVkttg+lNUevjP6BWssjL31XofmVos7epZr42bLywryrFHic6p7QpOgxqEdXR9x7kKLn6fpreKKzSvTOP6fW+ukiz9hAB3yvrNuI13Z1d9T5RZeADK+ll6q5UVVQMk2Q8izm/gtPwpYpbrmN06hXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768212; c=relaxed/simple;
	bh=bqK1EohHu71zjabqHTqoKWsH2VYa/lqUaQNt1/AZT4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1nnXLJsJRGVRBZTSqaiTboLoSfUWfGDhrBE89W85vgngxbcIBgXuD2Nux3JQ3EXOrE6CiRt1Rdjwrc0/WCTl9jOfgusTwyzSBSk0oC4kAZCoXvr6U8aeASQP7e5hRfEtrgLqrp8g6obfJlP58MRS3LEZBarS/kL+OX62PHNAYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AM5fe4ma; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755768209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOJOZZdThAmSYOmW8vQd0bDMJuONYkO1YWwTFftLPfc=;
	b=AM5fe4maG/g/9HnhWALhkMhB7DAVlIfNZW2OnmvPGcRFmuBi2R18sKXaGL/Vp8t019OohU
	drQDgcMMHjxLxZESSfUYkIzrbC5tcaAaXRrxZhv9IoKJZqMNqkHge1yGhAvnScSLcqImMR
	zqfsyqM6dExxXSewXNRKtHvXzleoUsA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-T5IxXDsgOySGGEOgie8YZw-1; Thu, 21 Aug 2025 05:23:28 -0400
X-MC-Unique: T5IxXDsgOySGGEOgie8YZw-1
X-Mimecast-MFC-AGG-ID: T5IxXDsgOySGGEOgie8YZw_1755768207
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9f57ef93so16758696d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755768207; x=1756373007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOJOZZdThAmSYOmW8vQd0bDMJuONYkO1YWwTFftLPfc=;
        b=St0cdZSzw5iEdO+wJ8CuO9nN/QVvvycdpy8v5rYzUc8L8qKRvRJmVUY/DiLxAJW+2Y
         EPISPCppV6PzEQVg4zyHU3K/GCVmjjnRjYLZb+JczXMs+H4es2og7HPf3UtB8L+oVPTf
         ZZnPvPrt1IViZRKderlViTz9RjkZt5sUnGl4PHyVtkt/d5/gSKTJYTLoRwrpBS/8JcTQ
         0+1w/jN6kKiP3gmgKbrrpXbmR1mKSd9tTBFpuzrSLTyFFp+tjQ8/aUKW2dQE2f+6ONw0
         +7+UOekQQGBSD/xbx1Ov3I0JpGQZ7dihnDe0kHLEhL/3K0M0BcHfU8dSroPR669lGeAQ
         tYww==
X-Forwarded-Encrypted: i=1; AJvYcCUu17x+PABboPP1x7CLC+AJN6X1imULqeIkHWwfTPPPpkGaMhgHaOkLrAJ5x+aK/dYWoeaDuYBjAmS1kHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KNPD3qONjjLKLlHZlRLdMTkJQJEP/koiokMNwea/ETL5lhCc
	LXJFzT1oeWc6KXw+CCMwoMeT+XMamxhGFFJ5vCJLcHFs5VH2LBmpDO/gO5mRAjlnGj55v3EvTD3
	vM463wDOn11hX3hmdt7Xow7V65GK7NlsXJX1HCJU8GmclMG/wIn41veaq1RyeXyXqMA==
X-Gm-Gg: ASbGncsO+tfdpge7zv1pvZMU77p74QFIgmbK793XTR01UcL+dTWIkhDiEV9cKf7lNuI
	z5CTI4K6LY2IKRVB6xVYORIlPdSujdhlNH+Lao1nTO4zrQuut9LcRAvveTjeMNgexiw+BzkPr+Q
	nhqOqYReshxMA9tOx5r9Hr78Cdf5qvQJd0adVLOQkTO7/pzRXpGdd4kl0zTgd6FeTkgzbXIQcsT
	UK7QhUmHiAi9wWUGJI9XROQYZlhoggIZqixznmoFvyM1kmOPQlneIyUZdxc39jwtjG4qDyaWDLJ
	EE6ePyAiH8O3dGHArdTEFjsPTweKq2CAXHqO56CwW1+Bpw3jAvfsoE5lHdyIyUe6qbs33AbGAoq
	Zy8Eqm3EPjqo=
X-Received: by 2002:ad4:5bac:0:b0:707:4aa0:2fb with SMTP id 6a1803df08f44-70d88e92700mr14422366d6.16.1755768207416;
        Thu, 21 Aug 2025 02:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHQeoOWaOCAlmZqkreErWZ1WAJZpVAGCQsupGfVEE7FWFJd2NfiFuKMU9Iyktu8wjNf2tj3A==
X-Received: by 2002:ad4:5bac:0:b0:707:4aa0:2fb with SMTP id 6a1803df08f44-70d88e92700mr14422236d6.16.1755768207031;
        Thu, 21 Aug 2025 02:23:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9382300sm100386566d6.64.2025.08.21.02.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:23:26 -0700 (PDT)
Message-ID: <062219ff-6abf-4289-84da-67a5c731564e@redhat.com>
Date: Thu, 21 Aug 2025 11:23:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: mcast: extend RCU protection in igmp6_send()
To: Chanho Min <chanho.min@lge.com>, "David S . Miller"
 <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com,
 stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20250818092453.38281-1-chanho.min@lge.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818092453.38281-1-chanho.min@lge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 11:24 AM, Chanho Min wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 087c1faa594fa07a66933d750c0b2610aa1a2946 ]
> 
> igmp6_send() can be called without RTNL or RCU being held.
> 
> Extend RCU protection so that we can safely fetch the net pointer
> and avoid a potential UAF.
> 
> Note that we no longer can use sock_alloc_send_skb() because
> ipv6.igmp_sk uses GFP_KERNEL allocations which can sleep.
> 
> Instead use alloc_skb() and charge the net->ipv6.igmp_sk
> socket under RCU protection.
> 
> Cc: stable@vger.kernel.org # 5.4
> Fixes: b8ad0cbc58f7 ("[NETNS][IPV6] mcast - handle several network namespace")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Link: https://patch.msgid.link/20250207135841.1948589-9-edumazet@google.com
> [ chanho: Backports to v5.4.y. v5.4.y does not include
> commit b4a11b2033b7(net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams),
> so IPSTATS_MIB_OUTREQUESTS was changed to IPSTATS_MIB_OUTPKGS defined as
> 'OutRequests'. ]
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

FWIW, the SoB chain above looks incorrect, as I think that neither Jakub
nor Sasha have touched yet this patch.

/P


