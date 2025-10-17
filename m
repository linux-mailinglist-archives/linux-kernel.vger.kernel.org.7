Return-Path: <linux-kernel+bounces-858022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D800FBE8984
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEA7F4E18F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EDB2D738E;
	Fri, 17 Oct 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUnwyVqp"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809D332EDE
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704345; cv=none; b=g2mTSKpVXyfZlpzLxU6Vqc0lNj/JLGUqpxYHbT+u1p6DnVHYztl9/r7IXwvYDCcvlvvkYY/XVQvCGGdAM4Ev84nJa7Iu1SrmdpLOxsUOvBY2DryoOFT755c+GHJrexKTkDjy62cT+mMZsOPu31VY359ACOAz3HRmJAbTZiQn12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704345; c=relaxed/simple;
	bh=MuzctqLB4ussUEoSxRDdq5u4z3jbIFXqqjT7Pzx57TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juq1jEkiGnB+q4ZHoBGUBQMPmWf3HUQY1OrCMJP215D66ZDHi1B7l2289slQ8ogec0RVH8ed2NJH1Zh1gUaHljWOwpWM2PmMRPZTmzGuFbBYVQKWldJ0XYPrHmXW/6/zX0aBhYbTdYR7DSkg5J9GxkaKelzAuRq7/tl1oB3MzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUnwyVqp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1263698f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760704342; x=1761309142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqU9csQsucjcl0I01knrUCDVWcsBEKstqIxuhCVvTsY=;
        b=TUnwyVqpCi9dlqFCYjLUqMYsIeDTWcQf3wZ14IckvRtkGRZK9TLavTL8geBU/9nzGD
         IXdGyqqcGtG2/IyE/Iu2IK70jyOv8nOZo3zYYxv/22WFDnp9Vsacg8Uvrgj9/dHXihBu
         fj9n7eanxQo/6Hfwhm/7tPnVgBujflTTRfbQ8qMq7hDatdkQyQUCwnV+6iYvZAFRYYEz
         wanzKb+oy2oRknkXPkyqRBrS/rAoNQRIIXnOwYmCisbhNktCNdURuheMXxzarR32jE4q
         W6ztoVcoWppq9Sh+VaMVGJ/npBeqnxRo79DbjxI4nf1oic8mCTZECyNTO/DaqDVChZvP
         B61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760704342; x=1761309142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqU9csQsucjcl0I01knrUCDVWcsBEKstqIxuhCVvTsY=;
        b=uDfUfLagIzQh4imSo3QHcWAwn9qQVIndaJmiBTquD9M8AD/KnkUaqDoxROuZkwYMcx
         4rL5oFAXEfs45JCAgbkPOa6tzPMMvQ+8euC24RTVEyA/dyPxCo+5Tidlr+uK2W4LYriE
         pj9x2YEMoD8tcYhqvCAKWBdNxpuWWUNg7p9dk5JIiMyP5pjX/EcfxBnyfCOegpuX0Xyu
         2iesRKm79H7EAUXGXBmhWCvZKJOswTmxvmMAWvxoUYseJQ+mVm4IU9RCEwvg0xIddBlB
         2HveavIO9usr0NOVsi/Zk/csS7HxlZayjwQZsVUe1PZyd3YeyTejMhtOzJiH/rg+XJ93
         JxDw==
X-Forwarded-Encrypted: i=1; AJvYcCU7FM+lOaIFcvHAAJz4fAdFS6lkZI972E4OYV5+sXwuZDxZ6gOKRsFq0ZWvJWaGWbCluQvpp8i6tosj3Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfK/rcM8l7LHH0seW7ikLVGeUpMYHmYJ1W0WShvl07PdXdbZl
	DZaKuv5wGjIVCN1UGAEqHssUbGRWrBSPDQ06GqS5izGVUsOgQX0oLVqi
X-Gm-Gg: ASbGncs8df6qsLr5oP/OGkLnLnYocz+lZIOL58SRvBNqpunDPxGHjecQRFHtln6VDec
	U5OcEgojRcXngiMAz4a2gXup+pBEn9uXo+bw3nQhOOyaScVxNKDhJhzxQC0xFJwjJD2b9hSW0Xw
	843SuEwBOElpKUQG0niiNuF3d1OzJJbsZ2CjeDe3oART5PkuIYQhRdwzbVGGvDEZVGUQsQ4Vurd
	LnKzxbvYX0yG+fgiX/cxllqpT/96ISELXzQFET1RxdWG4WQW4Y9XQ/w9ACQ3DBI4U9Hx2deQQnz
	DCCSEGyrVOmFaic9r1jdkInRvRkALV2NtcJr2Obh8waN0lIbrbECe7UN3eqNbi/53pcios8zLbE
	OxPa5w+qsnNGwyINo3Psn+afO1RCT7x/+3ZA9L4uMYenkdPvS/Rj6733ZJxS/la3C0dRTwpJ5PK
	nRue06Iu01nD0Rx65j0onSnjtjM7Dq2Sn81yYW15pIbX0=
X-Google-Smtp-Source: AGHT+IFvBoV+j+/2ZLgfgQrNR3bEA+fM+cjkWWRqcph6qCN2EXtdRDP7AmiiPcjQg94cN2mUkbMh+A==
X-Received: by 2002:a05:6000:4285:b0:426:d57a:da9d with SMTP id ffacd0b85a97d-42704e0ef3emr2238205f8f.59.1760704341764;
        Fri, 17 Oct 2025 05:32:21 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:e18a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm40163955f8f.42.2025.10.17.05.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 05:32:20 -0700 (PDT)
Message-ID: <8d833a3f-ae18-4ea6-9092-ddaa48290a63@gmail.com>
Date: Fri, 17 Oct 2025 13:33:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: check if nmdesc->pp is !NULL to
 confirm its usage as pp for net_iov
To: Byungchul Park <byungchul@sk.com>, axboe@kernel.dk, kuba@kernel.org,
 pabeni@redhat.com, almasrymina@google.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org, sdf@fomichev.me,
 dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com, toke@redhat.com,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kernel_team@skhynix.com, max.byungchul.park@gmail.com
References: <20251016063657.81064-1-byungchul@sk.com>
 <20251016072132.GA19434@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251016072132.GA19434@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 08:21, Byungchul Park wrote:
> On Thu, Oct 16, 2025 at 03:36:57PM +0900, Byungchul Park wrote:
>> ->pp_magic field in struct page is current used to identify if a page
>> belongs to a page pool.  However, ->pp_magic will be removed and page
>> type bit in struct page e.g. PGTY_netpp should be used for that purpose.
>>
>> As a preparation, the check for net_iov, that is not page-backed, should
>> avoid using ->pp_magic since net_iov doens't have to do with page type.
>> Instead, nmdesc->pp can be used if a net_iov or its nmdesc belongs to a
>> page pool, by making sure nmdesc->pp is NULL otherwise.
>>
>> For page-backed netmem, just leave unchanged as is, while for net_iov,
>> make sure nmdesc->pp is initialized to NULL and use nmdesc->pp for the
>> check.
> 
> IIRC,
> 
> Suggested-by: Pavel Begunkov <asml.silence@gmail.com>

Pointing out a problem in a patch with a fix doesn't qualify to
me as "suggested-by", you don't need to worry about that.

Did you get the PGTY bits merged? There is some uneasiness about
this patch as it does nothing good by itself, it'd be much better
to have it in a series finalising the page_pool conversion. And
I don't think it simplify merging anyhow, hmm?

...>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index 723e4266b91f..cf78227c0ca6 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
>> @@ -450,6 +450,10 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
>>   		area->freelist[i] = i;
>>   		atomic_set(&area->user_refs[i], 0);
>>   		niov->type = NET_IOV_IOURING;
>> +
>> +		/* niov->desc.pp is already initialized to NULL by
>> +		 * kvmalloc_array(__GFP_ZERO).
>> +		 */

Please drop this hunk if you'll be resubmitting, it's not
needed.

-- 
Pavel Begunkov


