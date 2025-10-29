Return-Path: <linux-kernel+bounces-876915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B2C1CBE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D45094E070F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AE91D5CFE;
	Wed, 29 Oct 2025 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaZ/h0QJ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249B19A288
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761982; cv=none; b=q0/I4NYDc/weaxww2IrNt9G+LNZs90R5NOHslqN5bdw8pgxAJFHxjPGFQW7NuIl3sA+GpnfqszmCiXElFmBvCmfk72zHwqCU5LTs1Winw+N7SgTtuAzAd5xjlxa1eZN0tBP/ob2dIQafsXxO1QRnoynQVKulnr0EYw9SQDydVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761982; c=relaxed/simple;
	bh=2UyEUdidhapro2zRf0wcomL0wYEbuN4eLxOA9WxuIc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mk8HH9zO4d8u6o47BaQ3j3uPPXnVL0K39y8M7T6gpRQUSUOKKSwaQLccZe35APguNGCJxSbn065b3IccFKSFL9ttF3NSlEleDnpb05KB+AtlcUf/cfoj/4znnbdaXHM1kSeYjViN82umwRoOgKAjFCFqMe8OMaqDuyAIs6vGB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaZ/h0QJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-592f2c3fd89so13638e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761979; x=1762366779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wthfBbpE09QD/RVLl7/O7vaLWiSY5lI9YfKCDOez+Hk=;
        b=RaZ/h0QJ++4GM0HtdUEQp/ABAG9rH0Tg23npmsuBG5hrqKgQ10h0FwFvsRLsOxC/rS
         Hy5vYWSq5jMjJ95kGUA6FDfHhzywlrb9qRg0wUQAln+x4FQmyuzXeC7eYPr8k+W9yTZA
         b/6N+6gYNBsbul7L/ZEjjarBFBT7TfULwGJ5ZCfPp6mxBNc8+9sXSXQTGjwvpiiLxsOW
         LEC5N4pTG+Z1ZZZfosY7Et6OcxIreT/wkbQM6AQaFPRNEaEuz3S47lYJ/t5vIzL0ySUV
         A3l0ko44L5GcqqlW5GiZxaO52Se0vM7+SZz0iD3tlvLp5SJPn6Y5aIeBmu75+eO4n3g4
         QWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761979; x=1762366779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wthfBbpE09QD/RVLl7/O7vaLWiSY5lI9YfKCDOez+Hk=;
        b=sE5EWEKk1mybcEYRh4I0cyDnCa4GqoO+xGeOqeZrxfCMWgqQJleMcAY8zSJLrpfcXC
         DLenQ57ppDFLVZy8mxjOAOpM+2nVMqHS8dZbBrcr8BOWtW4h8yG9/dAJzxRRMpwM1gBh
         BRKBvCcpYJACuPgnM2ArKokI9Tc5gWa2S1ZJLldSswkM3JqchKRNu1VracfI21PTkdZ6
         bsSdgeATLNGZD1Ssm9qC8bEcB/6Sm0swXlsYcJ9PprqtOLaStgQKpJejYu5MGFt3c4y5
         lcJXZ50Klvh7Z5zmfwZJ7ZN+5MP0rLrJ2/t6L/VjYSrxwsQbdTgaulmq2rwxg06VUtG5
         8wDg==
X-Forwarded-Encrypted: i=1; AJvYcCX/xeIOLtCdbTpFUueYidmtwkkC5XMaYxQ7Wu5SaxEIZB0rxdGoms+DYh2G2CoIxkPzhtPhV3YE9h3zkmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5Vicu4lXNg1BpsUsaOkRzprTMBQPDcnVim8kpCizNaXCqCvz
	r9QQD4KXEzTg3UE3yCzORJHON9N8CnYGdae0g7kkivWQChmKhd529Kb1
X-Gm-Gg: ASbGncsFPpvx/cI7+Obt9y8kG51BCKB1OsBjxNvoqbWYs5rzoCTYUWqikkAvmk851Ai
	Yd8jPkG2QqGSwuHoixOULdCRqQPCMRdTzbo6GzwNxITjN+bUWwtxVKMvJN+31Opx5LYtycaf/R/
	eW3axza5ZIatlxf9NJF1LA1XhUTRVsfw4tmTJq63deGfSDl9Yl8pj7qg0J0zkkijFfa1VF65Bzc
	d06EEt0oQu9dNl4HOpRQQmtZf+G/OR04GCrWtumydR74/vjtGWAW+nQwi1B2S4xEgwzekwrb1kK
	9yN9UyRvQP2OzPDsoQcQFi9KWWEPr+XSCtFoeYc7nCBLMyfyUwZhS0GrY5U3EPOtOrVl/QsxUCG
	Ez3hKrciuiou/E3NeVNF2A3WuTpLW6GsH7ddbbccBiX7hMyTNmuOYkYteYuHba4YHit01q8FO/h
	q7Ni8Oqg==
X-Google-Smtp-Source: AGHT+IGcxS2YrYY8mFvpyEsx2SVVvK+7CqZdpGtyuXWAue61BYvtDz5UP3WnSAs93IWo51I4vfsEFQ==
X-Received: by 2002:a05:6512:2390:b0:581:8db3:d5fe with SMTP id 2adb3069b0e04-594128657dfmr849225e87.2.1761761978381;
        Wed, 29 Oct 2025 11:19:38 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-593ecdb604bsm963255e87.5.2025.10.29.11.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 11:19:37 -0700 (PDT)
Message-ID: <bf8f2ed4-0b3b-4ddc-9ce9-0d0b1a64c914@gmail.com>
Date: Wed, 29 Oct 2025 19:19:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V3 7/7] mm/slab: place slabobj_ext metadata in unused
 space within s->size
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org,
 vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com,
 glider@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-8-harry.yoo@oracle.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20251027122847.320924-8-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/25 1:28 PM, Harry Yoo wrote:

>  			slab->obj_exts |= MEMCG_DATA_OBJEXTS;
>  		slab_set_stride(slab, sizeof(struct slabobj_ext));
> +	} else if (obj_exts_in_object(s)) {
> +		unsigned int offset = obj_exts_offset_in_object(s);
> +
> +		slab->obj_exts = (unsigned long)slab_address(slab);
> +		slab->obj_exts += s->red_left_pad;
> +		slab->obj_exts += obj_exts_offset_in_object(s);
> +		if (IS_ENABLED(CONFIG_MEMCG))
> +			slab->obj_exts |= MEMCG_DATA_OBJEXTS;
> +		slab_set_stride(slab, s->size);
> +
> +		for_each_object(addr, s, slab_address(slab), slab->objects) {
> +			kasan_unpoison_range(addr + offset,
> +					     sizeof(struct slabobj_ext));

Is this leftover from previous version? Otherwise I don't get why we unpoison this.

> +			memset(addr + offset, 0, sizeof(struct slabobj_ext));
> +		}
>  	}
>  	metadata_access_disable();
>  }

