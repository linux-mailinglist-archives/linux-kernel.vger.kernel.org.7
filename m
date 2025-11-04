Return-Path: <linux-kernel+bounces-884872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D6C315D4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C7BC4F8E71
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD832C301;
	Tue,  4 Nov 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Mk08fj/g"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E43322C6D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264741; cv=none; b=m4xw6wR2gOu8GjbC5x9pXyTdZaf1CXMvf3nncJzabJUe7nqbDB2X7pC/GM4YxODgZsr7Wim9fhIS8ZnhFNxRXkafOnQlDX3/VRryVJkyfzXrNk22OhPyCRHXZnIFQVF6teQXVxXTjus0xLlVWXMvmV7XYr2e3CnjLG4PJ34vzBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264741; c=relaxed/simple;
	bh=gDQAEq0aqIqm792dh7j65fknWz98mAbMJ4Q0te0KDXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hS8iwGfTfZ2+Gsl94JAIJA3tmZrbVa6FpEr/46lKPFtJ7azKcNHzwvJWUiYKRr6IPJAI0t5wSs9180QFEcVzWSjTkqw5Q3U6m8HLpxzu7VkNigglwDBIsfBL4qcEMMeL0oi3gzIt+LUrX0z0JpXBaLdOZaRYe6zt1Vy3FpSvUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Mk08fj/g; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-472cbd003feso6544985e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1762264738; x=1762869538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KmxJ5G5P+273emX0t2zZMtLOkTrWXY4nFi3xqJqonC8=;
        b=Mk08fj/gro/Vtsd9asZL91UD3D897XQb1mcUGJqBrwBiNGWtIup3WmDpzB4LNjWAGB
         Er4ttPRxB82h4apOFXV1Ek0V1vSeDFQ7PYMAr5zoR5IjO7DhOqX4PVRU/Ov8bYZqIMf3
         TaWJGt0mucQdpL9FohrfGDrU2rU03eJA6iGHdkVSDQGb8j7/s4Lbsl/5tdbX8C/BaLjH
         YyI/bmGy4y21Ej6kQshfHZVcoSIEgRRFvhlJv0bVLwEnkIyKryNrevygi8k1ooqE/Zrf
         +IMjjjXk27HbWMdwfq2yH7imDuZS98dpcV3KZQA9CVcp11u/JP3rpTEkEEe8oiA9puUA
         59oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762264738; x=1762869538;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmxJ5G5P+273emX0t2zZMtLOkTrWXY4nFi3xqJqonC8=;
        b=YctNqIfMJedRLhfCz7pc2rm6aPrl6MxGXvZvLDha3fdBufwVc5iNC3END34pHmCcrB
         QyFJBH1ETGVdfoYljiMeMa6gXpysysv7KHnwz1V7XWCNDwJ+49GJr7fvQNzL0eZIHkvM
         03iQcmvmgnE2DK16hmQTsKPS2XSJTChwOtJaqTTxF7a27dCMISgWsLY9jCJGn9IMJry1
         ewon9FNypsxCFMTt7r0TH3OPOCaQLJuDCwGlF7Rs93DXeAzvSgGSomB6Uv7LH3Ey1izN
         SOpj2Cy8lGlR9sfi0wLP+H4rkrE78ZTCjwoupzFmtHeyqy0m6FvwUr8NHPgITq4nnBqY
         UMEg==
X-Forwarded-Encrypted: i=1; AJvYcCXX8vu/URBGVfJPpLPNBE61XDtvIrcwXRnL34iMUHZF2RxIjY9fHYH0D3XfB775O0PrSP6uer37IBZQucM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1a6QRuvf7ZpADrr3wy/DE43jqqaZxlFtg9T6JdKFw/Qm8/Xf
	/IQznzObZQCmL9ebQJ1tTFwnLUHrj9I7baDqBrgwvRoYl5Y34q1QtiimABx1vN32svc=
X-Gm-Gg: ASbGncteQTuske4iBnS93AVA5l7D0jlZukbny7uEnmj4tHI/GBLq4j5RmV+Z+qb2zBy
	6U4PGcL5RD5kqALqA/4N92ZjKXd2ryqrshJLgOOQNln+YLDZwqGQ6oD2/4eUPVKXyrHFceHSUsA
	TD62UXIYnXqfAtmKojSDj8PCM7LlqGzEB7XJuyDRlgU7lwJBFVRfrpqM5WaCSLz5KM21kcqF4yZ
	q0fILmmHzGVDT8HV1DOEgCbP1hr5FYwpzDhgWuh0a0XP08p4VSZo71pbc0scVZeQ9DS/7VlB3/z
	2c7MSIN2cKg0zZ15Ljk9/BfsnICP4yPaIc94goQqKDg1cLRH6Y6T5JKxad/JD+dVOXj26oZyMQn
	EVKciv1aHVYi0seImL+fCs2S3ZC9fDUeCCJGkWuILJzlFKYomjmXDW1MFY5DjldH1F4eiBh3ORi
	kMbofFpLjI2tYvn/swU1Cu69eiF+Kx8NFBUN6dasg/x4oQMQ//IGYp
X-Google-Smtp-Source: AGHT+IEMAEFOhmF/iejZZHhzu3oDjZhXz5PgqOizEIFkk0hnK98vc072al/Skn/kZpde0jEgXdkWgw==
X-Received: by 2002:a05:600c:4eca:b0:471:1387:377e with SMTP id 5b1f17b1804b1-477308ef9f2mr90453245e9.6.1762264738365;
        Tue, 04 Nov 2025 05:58:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558b2e59sm19868145e9.1.2025.11.04.05.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 05:58:57 -0800 (PST)
Message-ID: <00c18ba0-be86-41f6-89a6-62fa3051bf69@6wind.com>
Date: Tue, 4 Nov 2025 14:58:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, toke@redhat.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Xiao Liang <shaw.leon@gmail.com>, Cong Wang <cong.wang@bytedance.com>,
 linux-kernel@vger.kernel.org
References: <20251103154006.1189707-1-amorenoz@redhat.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20251103154006.1189707-1-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/11/2025 à 16:40, Adrian Moreno a écrit :
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

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

