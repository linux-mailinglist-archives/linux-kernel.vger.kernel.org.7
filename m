Return-Path: <linux-kernel+bounces-875570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C174C19527
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9383AB933
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37792314D27;
	Wed, 29 Oct 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Qd33Os0h"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6F2EC54A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729014; cv=none; b=grkHims8UCdrcRo8f9Nq5ZmFG5dMHtJW93KiduB2zWSHz9rwYKty5Aq65PxtvmpfCIG5fhvq7eTO+KDJAahoGNckSBJ3pfK/A5XITNDlPfG/MP6GLg+1YJrWV0fZYzZEyi9sgSuyZKsiuLFhyymiBydHhEr0hn5xKk31F0daAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729014; c=relaxed/simple;
	bh=2GmHdalk3MuFmANwSpg04quM/tlXjTBn/QKE/sM6KMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDH/UNBDpYBhj/9GQxWYoT2b35SLedblAWWW0kAWEXzQ0t1JcfOXer3LWpQ+69dCvPWk4lbbHamIKMymbJ2juUij9EY1ky7xfqaAAP3UAYp/BGmo4R023Eqr+jCk3RRHJVDCVUvt9eSue9C+8ujAs6vKw7h4RrUXIHU0B3Na/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Qd33Os0h; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42992e68ea3so442122f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1761729011; x=1762333811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9tu6Pbq45SqequK/vWQav9ZlOAAI95LlNmutY09dbN8=;
        b=Qd33Os0hFdn9rIRYXdf/npCqVU5fGkCkxmBieLKbd7snz1+ZmpRo8R7TpeZpoWXts+
         RbbOhfwSMeH6bXKSZvZ6BeyZgFh2mP0M3ziM75OvGMX6kjg7JexgoyhJztzIOAZ3iirx
         RP4orPazGNQ3dEJVfuzxABrYvU11HV+AdnOfGzM3Fna78Yw6l98lm5tJer+oz/s5Jk+W
         W6bY8yzdD9k0pH4ER6Hq05Ljjls0qK1P3pB95cGRMzMYdj+I0tLscZDC/KXZJeqPWYj7
         4guBFNDtJRr89RRlMZgFS50VByVGS5SC0Lo9mT8X+hCLs/yDnPjKNq9Oda5thEPSQVta
         R3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729011; x=1762333811;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tu6Pbq45SqequK/vWQav9ZlOAAI95LlNmutY09dbN8=;
        b=Mnc/KqY6Sysz8ASA0vHAMIdprHyVdlgSzn8OMyjvqEsXwmoPp3TD5a5i/YCP/Ia2rL
         0V1DRGv3JjyAoo2U+2ThXdFZQZaOQTi/xCytnuml5Cj3WfM46ZruLZCHHFpv5VjpeAwk
         LdKyxCpR9d8qACa8OVRFEVBDlPQsbt5nkmeWt3oMCgis+UiGM7G3J4HijqOoivOGxLMg
         exXcZtOe4JBaB0h1j6IT2g+XWfswlOyrokarpqKwoRSrtRd3Xuh362B0fiiSJv0P9opQ
         GfzgcvShaNjByXFcKnYjbjH9/4ItB7hA+EjQv9MBJUxjNvPsNNUY/GmdrxsmbicqTjQ6
         KOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbIrZtgIgsiT0mo6arWoDZOmCyIuo9okop3B/WJbyhWbh5G4LjVdwgBB/GDTNcWPbapKUv93hhYVvANU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4oXI4hw0aHJwqD26WAJ+NG66Xhrl1vcW73ViJIp1/JsMc4elU
	5gm2reYoZ2SABkEN8Pd7Xor6bsJh+vyD8YQ8Y74ml2N1d9WAf62jBBAmKCEfU/52Bvo=
X-Gm-Gg: ASbGnctcH+bdVQGhm0HeaLljLbfLv/t7Y5Pi4473nTScGi6ofE+ztdworLjIieDfFPT
	lIfFZE15ymKx4P5jf4683K3vN8FnTDWUjPDDF+4Swi7kfFFqa7kEmPeZDJSokIDEeJHoSTtjmre
	sbRgvnli91JXX41P3uGm1I+PVA6gNRdyfzcpuS5Zoxk3yc/jf8OH0TuXdIzzK2YpM8WpO5ke4UQ
	gwBpbnHVjdSApQY6Rf3aTo+ZVqDYJX2fQ7FvyCccUB1XOJLUsgBG/cqJww1J7xEVinBDbgI/stQ
	e+YFGJ8k62iqBMl5hSNw9K9QdSEyCJ3UOu8dRcXlhPTD6M89/xe9UmxD+k/tJ7KZ29FZaS4PpEk
	1lEmznJmA0Gf6WwxzpWzej1LI4ZVHDbEaclVzn1o11RgMHsYrYH9mdik+zl0/J6PPVXLZ9QQE5f
	zfLTUX1s1VIcTK4S7YBn+u051hR2wsn7ynjPE2APl/oWxvyYkik2ysiXmwgU7Uq8w=
X-Google-Smtp-Source: AGHT+IFqk4ToMqpQP9bB3P1SCAW8S6ESA+1pktajcUdB8bOXcy42rhR50x7FVTyOeCVsMCp4F3DgfQ==
X-Received: by 2002:a5d:69cb:0:b0:429:a89d:ed02 with SMTP id ffacd0b85a97d-429aefc0387mr570340f8f.8.1761729011055;
        Wed, 29 Oct 2025 02:10:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbc55sm25933421f8f.10.2025.10.29.02.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:10:10 -0700 (PDT)
Message-ID: <3ccaca17-28e8-42c5-ace9-0798713a6dfc@6wind.com>
Date: Wed, 29 Oct 2025 10:10:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, toke@redhat.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 Cong Wang <xiyou.wangcong@gmail.com>
References: <20251029080154.3794720-1-amorenoz@redhat.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20251029080154.3794720-1-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 29/10/2025 à 09:01, Adrian Moreno a écrit :
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

