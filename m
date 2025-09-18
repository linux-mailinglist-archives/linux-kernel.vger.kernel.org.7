Return-Path: <linux-kernel+bounces-822114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B042B830CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB681891F35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B92D640D;
	Thu, 18 Sep 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctjFLa1k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EAA2C029B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174916; cv=none; b=PYv0LdpQnPkOvug6qa2FnQjpi/msyCl4FXhWlK4iG8gfWb7O4efliEt9dOeGXX4ssztqxVPkcAp1h3YRMlgJeyjwFK3ouabNoZrBNs71HdkNmQTcFD0Hg5/fuuiv81vBoWqCsTZWCeUQPnfPQAM+PRRS9tGq8syWaY2RHx8cF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174916; c=relaxed/simple;
	bh=Lwt+p8oiZf+r3kOLaCt1e8Or/+ab7t4sirqGsOmSErM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtwGaZYaKAcjw4lXBKAIRpZMcy+KV+reftXtYEM/AnHzJHPAKW6lfH9ol9bVStdRYOzI7HDvUhCjiS54UFIBbt0Krpf/JlBGHxj+HohYljSA5MIwRyIEZb+iDJ6gLQmXaecFfj8gDVYSr/7wcBoqtQNmjQcsVt68f3N20Vj5ruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctjFLa1k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758174913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NKrCYz9xpAzIyzftdIL3V/90piIa1hzvp5f1tzNxkW0=;
	b=ctjFLa1kyCka//kwVI+b2Hx39T3gY/0ccHLd0JfKrEM5uwK9ombpWiOyh3Yj81PlEymST3
	7DGb2eriC5JiGecyVz3Kx0bbUo8hFAJdYPCFXNvdE0zerEKSfJjD7m9uTNBQv13XNuZCec
	NlvSuszw7FBHHafow0NJ1jKc1145Qv4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-wd-aA5isMSqOpP1W1WSHtA-1; Thu, 18 Sep 2025 01:55:11 -0400
X-MC-Unique: wd-aA5isMSqOpP1W1WSHtA-1
X-Mimecast-MFC-AGG-ID: wd-aA5isMSqOpP1W1WSHtA_1758174910
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f2b0eba08so2337655e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174910; x=1758779710;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKrCYz9xpAzIyzftdIL3V/90piIa1hzvp5f1tzNxkW0=;
        b=i7zCns+jfqGIHl4eg10ZpVd3rpkyX3vR2ksD9aXQJ82ndeFixiX0I0UAv5awgN5mcT
         luL2JI23cVfyyDt9NcCOiyihlqWyd22mquwZM3x473RAkzRXF+6mwawONQOUaTA1oE0v
         Z3VmFM6po/5lXLFNzoYkMAeDXH2KpyG85LHN/S+uhYoL4SrGIEpMsw/qU2Cv+OXekJrY
         2v7GUzJS5yTrkrO4PNjwNxC7MnLvaf4IrYz7OgWJuMSJeP6tq98O+yhKJzOg5vvlHvU/
         NoFgwnTPFacEp39WY91t+bKu1T6we+poDlsVO4yQ/kCPYMnY8g9PYyRvMz3XZeb0+GGL
         eduQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR9mlcrKktZFBxHKNdgESlAJn5d+Jjg4ZemhhAKUYiGO/Tsbi6hejuSw2TxtWFKghjuVMFEctlWD4AdEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ibn//+VoSSHy4epGEvBTiuxEqbs58I6q/7Bh3kChGFm3cq2f
	NpOjaHfDC/1n111FDDUFca9hxs+aIsRnvHN7G45lzQ8EkVcII9D8YZNCKsq5gtI6/H7zbZwtX2T
	kxGT++TiGENLtwPXz0TvCxj5hEZ5fMYKp4eqnFYkhUgTY8NS/OBg+lYwBUm9M04Mcb9wFyaAKIQ
	==
X-Gm-Gg: ASbGncs2GcmuqnO/f8OeQoXexmzF/OLxf/z2LdbcdS4lJI+a49kNgUVAf7V+sZkSC/7
	5x3SMMBEJIMDWaHja7XWVr26vX9i8o4rozjdWPePrY19Qa5mrTFcqg/W0aIowukoUE5M9JxA+Hw
	C8Bnd64JCUar6Jfjf4OO6JjoxHSlqetGzsluAtTrZrTQQNI9y24Do/JuUYSJDY00FlCeP1LwoaP
	MuWH6aLJVh89ep2AW4PqubbLvyDQqE1KyBS2fzVsAzUk24q2YSZkID6bp/vq1mOhlitXuaTetxA
	PtXtA2T+BmNr9sfSUUayTNg5RyDyLE/0WOliTI464pBfDW8LWoXQZVylmQt+o8GjdWfXbqIJyEn
	oomy+D8TdIUU8K4i0PSdT7aeQjPOrFDwx3k1bnQTu2gelRbqnSPM9D/d7BtDlvT55Zl/a
X-Received: by 2002:a05:600c:4452:b0:45c:b53f:ad9 with SMTP id 5b1f17b1804b1-462072d6ee3mr42901125e9.33.1758174910336;
        Wed, 17 Sep 2025 22:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+w/U1G077wqX5gf9L/drxt5mqXTgrB2KLVuNXmu3a1/ZafTB85mAnpV2PhRybFjEo929q4A==
X-Received: by 2002:a05:600c:4452:b0:45c:b53f:ad9 with SMTP id 5b1f17b1804b1-462072d6ee3mr42900825e9.33.1758174909797;
        Wed, 17 Sep 2025 22:55:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f321032a1sm57041195e9.2.2025.09.17.22.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 22:55:08 -0700 (PDT)
Message-ID: <5512b1b6-31f8-4322-8a5f-add8d1e9b22f@redhat.com>
Date: Thu, 18 Sep 2025 07:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/base/node: Fix double free in register_one_node()
To: Donet Tom <donettom@linux.ibm.com>, akpm@linux-foundation.org,
 clm@meta.com
Cc: Jonathan.Cameron@huawei.com, alison.schofield@intel.com, dakr@kernel.org,
 dave.jiang@intel.com, gregkh@linuxfoundation.org,
 kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, osalvador@suse.de, rafael@kernel.org,
 ritesh.list@gmail.com, yury.norov@gmail.com, ziy@nvidia.com
References: <20250918054144.58980-1-donettom@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250918054144.58980-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.25 07:41, Donet Tom wrote:
> When device_register() fails in register_node(), it calls
> put_device(&node->dev). This triggers node_device_release(),
> which calls kfree(to_node(dev)), thereby freeing the entire
> node structure.
> 
> As a result, when register_node() returns an error, the node
> memory has already been freed. Calling kfree(node) again in
> register_one_node() leads to a double free.
> 
> This patch removes the redundant kfree(node) from
> register_one_node() to prevent the double free.
> 
> Fixes: 786eb990cfb7 ("drivers/base/node: handle error properly in register_one_node()")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   drivers/base/node.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 1608816de67f..6b6e55a98b79 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -885,7 +885,6 @@ int register_one_node(int nid)
>   	error = register_node(node_devices[nid], nid);
>   	if (error) {
>   		node_devices[nid] = NULL;
> -		kfree(node);
>   		return error;
>   	}
>   

Yes, that matches what other users (staring at mm/memory-tiers.c) do.

I wonder if we should just inline register_node() into register_one_node().

Then it's clearer that we perform a put_device() already in there.

On top of that, we could then just s/register_one_node/register_node/

And then we could do a similar cleanup for unregister_one_node / 
unregister_node where I don't consider the split function really valuable.

-- 
Cheers

David / dhildenb


