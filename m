Return-Path: <linux-kernel+bounces-788471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C7B38510
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107C016B3CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B843D1E51FB;
	Wed, 27 Aug 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfKnhSFN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B281B4F09
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305286; cv=none; b=jwe8lSwDUROc7YGO9swxn42h/OuYCFYHWPYMG8FyBFPk69AHkW5Eqb2C2/3WdSTNwadwv3nZZW0ZjNdMhPISquiUT2jjTE+2UplJ4uuamW9vvkZna3FS/L8x+HPGh9yNL82uZLrGgf+wuKn5P5FG1vn7dDCzhQctNOLY1rAOnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305286; c=relaxed/simple;
	bh=rRPL9XQdfn6y7KsvmRWu1YUtwmydQ4o7aFo4Q5KUw78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQdacC1Zw4+xBsPNGbyu9i03v4rhpQMf0KYkAvnVifI5UXmHW/kHGl3OvLb7JbHNHembinjqNsyEbAQSDMyjlQrd6WjLCr3PJlV+zB6/0ihAsGFm2AzeTM7XrctyVWFATh8+v0tQicUAULlXNDaA1PsVKU9vE5QrUjTT1HZ7e9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfKnhSFN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756305284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O+6J27g3PzVLwPT69v8xrD/Pf9wlMRrglSVCG5aMSNo=;
	b=CfKnhSFNjQLWdqb4gWsJ9hb0XEc5uGT36RkS8vQ2HD+fSFuhqDfREXo+K49bI67xK3lhQ3
	yuZf+G9VVSUi+TaRiWC9iJFhs8kicJFXRrNVoUZLuVIEqEgKUeo6Y6CygyHH1Bv3hPGDbs
	yc4JLim8Iw/qXUZaM64uvRUimJq04FI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-K8PYRtFAOxeZurtpLtpApg-1; Wed, 27 Aug 2025 10:34:41 -0400
X-MC-Unique: K8PYRtFAOxeZurtpLtpApg-1
X-Mimecast-MFC-AGG-ID: K8PYRtFAOxeZurtpLtpApg_1756305281
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c7ad98so239222101cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305281; x=1756910081;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+6J27g3PzVLwPT69v8xrD/Pf9wlMRrglSVCG5aMSNo=;
        b=RtS6pFlyZkwAAyv1AbfduhxN7PRrxVwtwBa9FmnzMEiMLDqI5ME3LlIM/zP9eKkn3b
         n7E0gvD3GphKAkrEUKWX/ns0YvtQ73j5QooAmirM86GXCT1F5b2G9GJEwH5Wn6Oq7MCJ
         NJF1VuBIdJYd6RazLf0pNPdrD5HEsMYBFYd3XYMmeygbiM3ln5PBJOOlfxZIoKv3C2rM
         g3ksxnY7N9bs4wGAqpIMFCG+R+4OcVunS7M1IF7ffGAX4qGF5kA7YtfyhX06tTCwT492
         9oRGNbi4plbTMaaj4DfmfyvpPExFBaWCBT8IsANHbqTvFeBCrxqBxeFH9F/8SslXvc1E
         T7qA==
X-Forwarded-Encrypted: i=1; AJvYcCV//ANWugo1c50pmUJapeDV30CisqNFkIceeQl3yR2krOIjAR/e6vBhFF+gnf/NN3RL94j2LkZKv/cfbiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9JJZ3+Xen907clmtobY4LvO8z85jto5TSlOdqJYa/HWVRIgN
	JptxH5c9OwZ9N2wzpOSD5TEYCbt1O8rUJNTAcNBWzA4+i+Ov0GeWr0xHBZIIfoJc8+/2nVS2V69
	KSS2PNj9mQ7Oay0YCHHFYWvRKfOCIkdJxSd0CPtvhbaQY5Xl+BEZ0GMnsPoH99rY0ew==
X-Gm-Gg: ASbGnctilDy925ZKV+aiE393QKhGnHBIVTbbGA1BelqAVkF86nUiPFYuqT6pLUtU/FI
	g6xC1NB1XbjsZxccKhCWvidHHl/kKB8KHrkR+X+74/VEJWtXP75Q0+S2Muq6O0pYlCbmw+Nvpj/
	sihnwxDRIJ+OfegnIK+rGb1pM5kQfLTV5ntPmUNy7OedWeLMlgJzrM3+y+ayHlCNFxOMjOgmtZz
	z8oSnZ7leDhoXKyi1U5iWEs+d3ln2kbchsRaXEWoWgrxnwdeyyVuJmZoNnQ70s20Nr3JPMQBKdX
	wTIrDh0cc/tU/J4qGuGOGo3ikDBxRqf1TFmDYgCZ+5TnscnpHWT1HITb57yPMw==
X-Received: by 2002:a05:622a:207:b0:4b2:d946:f722 with SMTP id d75a77b69052e-4b2d946fe59mr109270071cf.42.1756305280872;
        Wed, 27 Aug 2025 07:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE17UoC6BDTwBhYei22ueJMYZMNMRV/5hNaLrpO80gJoTKIKbD1rlCYod8CxcHQ3MIZfR/MvA==
X-Received: by 2002:a05:622a:207:b0:4b2:d946:f722 with SMTP id d75a77b69052e-4b2d946fe59mr109269461cf.42.1756305280316;
        Wed, 27 Aug 2025 07:34:40 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8c693a3sm94776351cf.1.2025.08.27.07.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 07:34:39 -0700 (PDT)
Message-ID: <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
Date: Wed, 27 Aug 2025 16:34:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] huge_mm.h: is_huge_zero_folio(NULL) should return
 false
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, shikemeng@huaweicloud.com, kasong@tencent.com,
 nphamcs@gmail.com, bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250826231626.218675-1-max.kellermann@ionos.com>
 <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
 <CAKPOu+9wz9g0VuYDPiNDYdaGG-gdK86h1gGSCmVPsC2a5f-GPA@mail.gmail.com>
 <e5783c3d-7eeb-41d9-9fe7-730155f9bf17@redhat.com>
 <CAKPOu+_8_gfko=Sh-YKpbgcMy0aJB=m9yrC5JJKEZm=yeYPOgA@mail.gmail.com>
 <11a5d391-3a13-4376-98f1-34b529d3c583@redhat.com>
 <CAKPOu+9j5+w6ydvygdWnryZM24AFPSVJB_21VH8Odi_xdrNksg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+9j5+w6ydvygdWnryZM24AFPSVJB_21VH8Odi_xdrNksg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.08.25 15:06, Max Kellermann wrote:
> On Wed, Aug 27, 2025 at 1:56 PM David Hildenbrand <david@redhat.com> wrote:
>>> This patch isn't about the function parameter but about the global
>>> variable being NULL.
>>> (Don't mix up with my other patch.)
>>
>> Huh?
> 
> Oh, I see the misunderstanding. You are right here, yes my patch is
> indeed about passing NULL to is_huge_zero_folio(). My previous reply
> was confusing.
> 
> But you were replying to a sub-thread by Andrew who questioned whether
> a call is_huge_zero_folio() is legal at all before the huge zero folio
> has been created.

Sure it is, I mean on some systems it is never initialized.

> The question I asked Andrew, which you replied to, was not about
> passing NULL to is_huge_zero_folio(), but about whether the call to
> is_huge_zero_folio() is legal at all, no matter which parameter value.

Yes, see how get_huge_zero_folio() dynamically allocates it on demand to 
then update huge_zero_folio.

> 
> I agree with you that is_huge_zero_folio(NULL) should not be legal and
> makes no sense. It's a bug somewhere in the caller.
> But I saw that the current implementation effectively (randomly) hides
> a bug in another part of the kernel (= Ceph), one that I'd rather like
> to be visible (and get fixed). And that is the point of my patch, and
> is the reason why I chose to have the additional debug-only code
> inside an #ifdef - I don't want normal users to pay the price for a
> debugging feature, no matter how small the price.
> 
> David, what is your opinion here?
> 
> - leave it as it is; is_huge_zero_folio(NULL) may randomly return true
> or false (= reject this patch)
> - add the huge_zero_folio==NULL check, but guarded with #ifdef DEBUG
> (= this patch)
> - add the huge_zero_folio==NULL check unconditionally (suggested by Zi Yan)

VM_WARN_ON_ONCE(!folio);

Should allow for catching such bugs without causing any runtime overhead 
on non-debug kernels.


-- 
Cheers

David / dhildenb


