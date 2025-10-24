Return-Path: <linux-kernel+bounces-869059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55E4C06D55
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE4C3AF969
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122130B539;
	Fri, 24 Oct 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="d9U1m62S"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267992E091C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317972; cv=none; b=m5mBaaG7MirXZKwEyqe05pN5KD06c9CqEKspB89nuP4UGLV0fHCwKPEUWdkbtIcUooqGfhbAjH5CGhmp8zanaanrVbxXf+yy1rke3c6HMwi22wH24ixVLQtgRsCeKy9H4JeFg8GXtFOwK66rmwbuDWsyWO1w1u15UkuLDMW8JWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317972; c=relaxed/simple;
	bh=Xo23AlrJFpeHh6DJkPO6dpHgBIWv33gQ18h2Hfun2vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLdvIWtFCuteDt8y9L/lCdgDDPHFYNeFLDyimd8SYEzB1hjb+gwl+WYt+FHbwh8MybRZRFbdZ/lEYbMkp4TCVIgo1Wb2aFfajRyn6R/+/cHi0d/hrfJb7UVBLYGpO7WV4lr+XvMDpjthEhSMhETffSxITA7YoMOHuVXf3i7ifYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=d9U1m62S; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4285645fdfbso359396f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1761317968; x=1761922768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S03wUtYmG3kE6LJin33WuT98F+yQ/qV5EGqRiSgb7bs=;
        b=d9U1m62StamCGV+DqYkMa9TXwcbTBYNlmkbxfz0xTD99jl7fAgldCQhTeK/Piz7LI8
         PXqUxwER/AIGWlwqLigy7wNjp7g7+RRt/d+uNt6V4RXMHVXIReyS07dx1OlQct3OWRHO
         ZR/si1UvwtRGtvLfvSNlOUhpAzO4N9OcyEIUG6B58DPOfB0xoVLIVan0YS5PHydGMJIC
         IMym+uD1n/oTzWbmRZMNM3Cp9+gPHYCZ/6dr2UM9Apoh4s772oT6IU5kf8VTY8OEH5f0
         kKB1Fm0fUYfM51TTHeIsACvvPNdsOlAy4FZhwZ7mpwPj6Q7mvAWIE1ViSzqr/XRRpSZv
         eTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317968; x=1761922768;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S03wUtYmG3kE6LJin33WuT98F+yQ/qV5EGqRiSgb7bs=;
        b=ju6vH85jYGt8ITPIpH5Bq5oDwS6xVjWJd2N8JoxQqXRnogSM1tOZkm4q4BA8ZVhmzf
         1hwLihDXBcz0GJJvrxRA6LlFy08K93egptlooXOpU5CBaT4lq8+yphun4U2LW3QjEQkq
         dalTJNS0Fr7hfxT9uyo5DAJ66/2ADYm4JWGgLepZfqZpv1IuEaqwOU3iPPgddsvM47nX
         vgYXCqR75fABmUUvz2C/S5p/61BM6uG+RCcrKqH2n3h6ixGDtodLqbR+5hXz5Hqa8qvq
         AB1xoK606X8+p8x9BrkIyiupd/XVKbTFRB/s/OFi0SvbIj9z/v+DjDzJ69ztubj43FVY
         F3HA==
X-Forwarded-Encrypted: i=1; AJvYcCVDusjOuRKsEYtKDQNFgLG5LOHqb/o1rn72Il309pIAj6b1mUPM4nxoobl/DmKFoKoJYbeDe9vGaTt1zHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwawLccuGWpQ2dOa+HHXtDO32bFKyEVLakAsnYf+yxp2LYxUf2C
	0ewd9N0/Plot5Pygku47ChJcpuIp4cvqWs1cEgCKAdK1jIMIsqKE/z1xMyVV4yO6llg=
X-Gm-Gg: ASbGncvCD0hoC+QTzLrqFapyHG8smhxkh9kQUS/RflVqUh4NcOMyfuwH+mbCpra809o
	tQpmCONOx7egfeZ0R/TIVE7/DgmykQXyJrCzld15NOW1sXxliNDP/Xlygai/+947SIwt/hkCBZV
	vfQ5uHLriXby4zvSCLuIY5pTG6xVKagbr5mXhZbhhnqauP9f+F8hynVmpwHttvF5+YBLg+mL8o2
	oVOjOTDPXVmu37NUnqSlYtPLPzsuSulvbeQ4x8HYaz6SCdvP98R94wgnXGJPU5EMHf47BICxBuu
	83+kaOXvxhbL/KRhUSu+KTS8LNGNzzuaem4GmsGGmtloNjgVRjzeAu8DvZfh5lJWknjLX3Zir8T
	cISAvE2ps06vkIuTTDk2bvKOYKbAGs+B9jtQERPLKoq9SiOFlYb/0EAnepzeJbKTEni+btCxKNy
	LTd9MqP199glQ49+Tk2R/qxaiLG8BVVdHmQaR9Uoo1C4LXZLoMiJFbnP5vT4tuqz4=
X-Google-Smtp-Source: AGHT+IHVh4znL8o504Bn84IxG9lVJmICafAHUtQizwzd9EwC2Na0fIoNIB6qTB3l08lWzAyyfX7XAQ==
X-Received: by 2002:a5d:5f56:0:b0:427:401:1986 with SMTP id ffacd0b85a97d-4284e576585mr5566114f8f.9.1761317968159;
        Fri, 24 Oct 2025 07:59:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898adf99sm10260322f8f.28.2025.10.24.07.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 07:59:27 -0700 (PDT)
Message-ID: <43916b1a-e6bb-407d-852c-eaa3c4652d03@6wind.com>
Date: Fri, 24 Oct 2025 16:59:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
To: Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Xiao Liang <shaw.leon@gmail.com>, Cong Wang <cong.wang@bytedance.com>,
 linux-kernel@vger.kernel.org
References: <20251023083450.1215111-1-amorenoz@redhat.com>
 <874irofkjv.fsf@toke.dk>
 <CANn89iL+=shdsPdkdQb=Sb1=FDn+uGsu_JXD+449=KHMabV1cQ@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CANn89iL+=shdsPdkdQb=Sb1=FDn+uGsu_JXD+449=KHMabV1cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 24/10/2025 à 16:35, Eric Dumazet a écrit :
> On Fri, Oct 24, 2025 at 7:20 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Adrian Moreno <amorenoz@redhat.com> writes:
>>
>>> Gathering interface statistics can be a relatively expensive operation
>>> on certain systems as it requires iterating over all the cpus.
>>>
>>> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
>>> statistics from interface dumps and it was then extended [2] to
>>> also exclude IFLA_VF_INFO.
>>>
>>> The semantics of the flag does not seem to be limited to AF_INET
>>> or VF statistics and having a way to query the interface status
>>> (e.g: carrier, address) without retrieving its statistics seems
>>> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
>>> to also affect IFLA_STATS.
>>>
>>> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
>>> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
>>>
>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>> ---
>>>  net/core/rtnetlink.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>>> index 8040ff7c356e..88d52157ef1c 100644
>>> --- a/net/core/rtnetlink.c
>>> +++ b/net/core/rtnetlink.c
>>> @@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>>>       if (rtnl_phys_switch_id_fill(skb, dev))
>>>               goto nla_put_failure;
>>>
>>> -     if (rtnl_fill_stats(skb, dev))
>>> +     if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
>>> +         rtnl_fill_stats(skb, dev))
>>
>> Nit: I find this:
>>
>>         if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS) &&
>>             rtnl_fill_stats(skb, dev))
>>
>> more readable. It's a logical operation, so the bitwise negation is less
>> clear IMO.
>>
> 
> Same for me. I guess it is copy/pasted from line 1162 (in rtnl_vfinfo_size())
I agree. I didn't point it out because there are several occurrences in this
file (line 1599 / rtnl_fill_vfinfo()).

