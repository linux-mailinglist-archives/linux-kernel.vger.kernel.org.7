Return-Path: <linux-kernel+bounces-845592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56510BC5784
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7DA3BD746
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC82EBBAD;
	Wed,  8 Oct 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQl07CPX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210942AD31
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934671; cv=none; b=lesSBg3W5CcT2P3dJDGB8n6HYXfu4xg0QfJoZIOSmINfoAMycZEipsoXkJIfJwb7XgqoPa1XA3KZ1p3mjVEeDMDBIsU19e7GSA6Jn6KtgzQ169O8Y4/o9FSvecdZnTLkly76ZhPSA5UsViSN6vod1bz05FB8uYZXEUeIO5A+4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934671; c=relaxed/simple;
	bh=mqtJTf77FO0OqBC1ebGqrXe0vOjT6F1YNSSqtSlVUQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjY/bVkn3cZN9kZzrkfNPTsaQ5h1OS9wuy/Vi6OkuE/prCRR014Si3/msIxMXCCXT/fsjXCXUizkUL0QrVmD4narCUJyDs+dRnKgkGP7RWVA1tDF+4AvOLMTlX3KcWHoxf2JJDmTLh/a9NS0Vw11FM2XRESH+jfC2gAnEtFW0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQl07CPX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759934668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5D2ZBCJD8c3xdACE6ypAt6xt/+t9lS2ExG+K8u97CUY=;
	b=AQl07CPXXSLAE+ex3QQEffkerjMHd1pxtmLD9niw3Y8Hyfc1gfuv4YReldeTVzYghXhmJA
	H6N5QoBCjQWTH8G1Ca5l/jCaryogb7WNu6icq9csx/cyVcDOV3I5H4Bp/zGxGA0N7M/j6T
	KM8Z+x/szwUsOffLcwbnhp0RkgBVDkg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-F2v4pXL1P5mcMtxOvb_Qog-1; Wed, 08 Oct 2025 10:44:27 -0400
X-MC-Unique: F2v4pXL1P5mcMtxOvb_Qog-1
X-Mimecast-MFC-AGG-ID: F2v4pXL1P5mcMtxOvb_Qog_1759934666
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f030846a41so4640602f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759934665; x=1760539465;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5D2ZBCJD8c3xdACE6ypAt6xt/+t9lS2ExG+K8u97CUY=;
        b=TzsKiy2IzxTEMuqcjFVieZ5nWqedrejfnWzmer6v9PUDPNpcBqvAk1WqDEJT+/WMgc
         mzQlHAImLHPvhvgT3ZI/qe1rWcDAPuo8n2/N879zCVUyXGp85/nM03bET6cm2eRFBCwo
         QeAtSdLumT3O3BHN/jzvlQWkc8pFDXxx+GG24CN7rRLM3FYJ6Ye68mexvKs7tk+CcNcC
         jPSJCnGO3pO0aRt4RSXC3SU8ow2fNSXYCc9BLEcQwzA9EJyM6TjtJqo4D6+IXxPI1UMl
         R3G3rOU1r0Rgmd7hQc3j4hvHX393bG29IoSymxwuY64oy2E9o9RVEphTAtD2rs98N9ZE
         ggFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxedEvjDyl0sKBvU2ggBGFUICm2YAntfUpQO2S7fa8F/EERtOHe72i8hHcBeijrh7RvQIcaPljE6eE1Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwraFPmt1JOMhvR3dS+96j3PUB9JlxUpJaq3BA1zOwplxNaMaAn
	mnWZrPd5CZPgLrGx7Ign+JZWeX0ejqZlBXEbbpWeKsVpHnlv2b7gw9dbbOMwVUjialEuOUInlg5
	PS8gedVSyQ+7vIceOh9J/dT5r4JK/8Qeb0Lvv1kcyOzKbrfBYYDqg1qsjUPaRsQE/Iw==
X-Gm-Gg: ASbGncu2O81vL8SBAvN7D4CYWgB0XjTh1pNFUZ2MHe+2sv/lNnrFPKzMTERZdZjqkQY
	SOKsvl0xmajA/bc6rLeaE6buTZa/qyk+kcqMrMryr9ok/l2XSw0ylMFSfdDBns8vI5cPWXUqu4p
	pvYtEzmzYKr/bvLFgB4sWuqfePgR1OehKeL3mebmtkyRWRHthN6SR2SnVltOKeTGe7oH5YnrJbT
	iSBkPdCpNx/En5Bi2pwr6+ifQ8cIBZi419yqZmRp5vhHhro07HWf4mtptPs0hYpkVqvag21l6UU
	6RAVOAfJ3h++RhMqCOA2MTQNNDr6lHdFJpWC9mxccws6KhhbjAc9yRRgLywmRZ/Ac3/WNCmuD5l
	52ay3/v5l
X-Received: by 2002:a05:6000:230e:b0:3ee:1294:4780 with SMTP id ffacd0b85a97d-4266e7e00ccmr2235079f8f.30.1759934665542;
        Wed, 08 Oct 2025 07:44:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDdqP+nWR/r0XOQYHaQ5RL5v2xthoAhXKsv0Fsa8RBq0AE9+JjgtYjdggoihs5m7bBq+ToxA==
X-Received: by 2002:a05:6000:230e:b0:3ee:1294:4780 with SMTP id ffacd0b85a97d-4266e7e00ccmr2235064f8f.30.1759934665153;
        Wed, 08 Oct 2025 07:44:25 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab909sm29664745f8f.19.2025.10.08.07.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 07:44:24 -0700 (PDT)
Message-ID: <f4d0e176-b1d4-47f0-be76-4bff3dd7339a@redhat.com>
Date: Wed, 8 Oct 2025 16:44:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, corbet@lwn.net, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, hannes@cmpxchg.org,
 laoar.shao@gmail.com, brauner@kernel.org, mclapinski@google.com,
 joel.granados@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
 Michal Hocko <mhocko@suse.com>,
 Alexandru Moise <00moses.alexander00@gmail.com>,
 David Rientjes <rientjes@google.com>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZyt-7sf5PFCdpb@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOZyt-7sf5PFCdpb@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.25 16:18, Gregory Price wrote:
> On Wed, Oct 08, 2025 at 10:58:23AM +0200, David Hildenbrand wrote:
>> On 07.10.25 23:44, Gregory Price wrote:
>> I mean, this is as ugly as it gets.
>>
>> Can't we just let that old approach RIP where it belongs? :)
>>
> 
> Definitely - just found this previously existed and wanted to probe for
> how offensive reintroducing it would be. Seems the answer is essentially
> "lets do it a little differently".
> 
>> Something I could sympathize is is treaing gigantic pages that are actually
>> migratable as movable.
>>
> ...
>> -       gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
>> +       gfp |= hugepage_migration_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
>>
>> Assume you want to offline part of the ZONE_MOVABLE there might still be sufficient
>> space to possibly allocate a 1 GiB area elsewhere and actually move the gigantic page.
>>
>> IIRC, we do the same for memory offlining already.
>>
> 
> This is generally true of other page sizes as well, though, isn't it?
> If the system is truly so pressured that it can't successfully move a
> 2MB page - offline may still fail.  So allowing 1GB pages is only a risk
> in the sense that they're harder to allocate new targets.

Right, but memory defragmentation works on pageblock level, so 2 MiB is 
much MUCH more reliable :)

> 
> It matters more if your system has 64GB than it does if it has 4TB.
> 
>> Now, maybe we want to make the configurable. But then, I would much rather tweak the
>> hstate_is_gigantic() check in hugepage_movable_supported(). And the parameter
>> would need a much better name than some "treat as movable".
>>
> 
> Makes sense - I think the change is logically equivalent.
> 
> So it would look like...
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 42f374e828a2..36b1eec58e6f 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -924,7 +924,7 @@ static inline bool hugepage_movable_supported(struct hstate *h)
>          if (!hugepage_migration_supported(h))
>                  return false;
> 
> -       if (hstate_is_gigantic(h))
> +       if (hstate_is_gigantic(h) && !movable_gigantic_pages)
>                  return false;
>          return true;
>   }
> 
> And adjust documentation accordingly.
> 
> I'm running some tests in QEMU atm, but it's taking a bit.  Will report
> back if I see issues with migration when this is turned on.
> 
> If that's acceptable, I'll hack this up.

That looks better to me indeed.

Maybe we can export this toggle only if the arch supports migration? 
Then there is also nothing odd to document.

-- 
Cheers

David / dhildenb


