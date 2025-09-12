Return-Path: <linux-kernel+bounces-814601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47604B5564A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F971B22C87
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9710532ED4B;
	Fri, 12 Sep 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TeOxtFpt"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB04324B25
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702161; cv=none; b=Wv/MJ4+7clx25sX4ymS3GvrgdjWPVoxAneTeP+30ZVC6CX+V03vChWvkiIeBzhoiWbc+cwgyixYHeAVlAR4bqmMndw3fQWwqaPCxeHgJJUH3vICfFbjLUyy22soML1lxSgIx2Pm6Zuxj0/27MUyFkBG3aXOweyW8LSA4IaKV/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702161; c=relaxed/simple;
	bh=y4gWWqmz84oG206JRwdNKi7A9nqe8+bM/0jPZWiNXtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLk+KzscSyDmR8HY1x4FxRaC7mYbOZ4zEixrYw2MOlrh3w8uMPF+Md3KVXATCPK81r3rxh33KZfIydWSS/e3zefPntJnky1XJf22PiFpx7BXCS82ACnKTz+jl4CNH2s+vkmd4c9AcupS/Vt32hpLQFD/l8kSw1OHPEoOymwdd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TeOxtFpt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e8123c07d7so146228f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757702157; x=1758306957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTwLCqYrxP4A65CpeLdDZfX/1/5VrrEeFcGj8O2B7PY=;
        b=TeOxtFptWOd1RU9pHqHLwx2CyO2LBGwUxnU+jShsmNmONkCQB/x2UZkLqoIKZlziZh
         /oumduplmrNAWzJ85JCY9ON3Y7PVG2dcE+tOcK/wbSo5wqspnWaObSgEvOkcazk25P41
         OH8Po3w0R0ixOXE6nP+fhUDpHYaiHKcihJRB9k5xqGdZpYxnL3Ty1Nslx+KcvABgzd+z
         VZMG6kYSdLmivO6XWXfZDD8VQSwJ5JNLBu+JdnKZFfJ9a501LJFKaEWknwKUS/ygzUOy
         6U82LPqwAZ2zRvO95NRQzOrUUeBj7DVRvPXm+kjR76ZYzfFfMnc2JoP7wPDtcoBA4eQs
         SJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757702157; x=1758306957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTwLCqYrxP4A65CpeLdDZfX/1/5VrrEeFcGj8O2B7PY=;
        b=WmwZ5fqq8kaabkNz9f13gugknPZVQnOo6iOWzMu80FD+Kw3izsxR4WL3TcK56q7hoF
         l+kYKpIjrYICiXmpclFkSbsVn9Lxm+aRVmA5Gnt17kYt8V7b8CTaVTXpJCwPF87Qx+5Z
         148NdigjBoTb0ncrnKXmGUZEsQJ14+qtrS51NfLNw8L0o3l4VEfZIn7xb4mmg1QJPj3n
         SDVcictzsmcnvEASo/7gdFiCprHn7D7UcVdK3FRGtt9YXS9pV5JLTNJv4NezxnnGuefV
         PPCdyXmy7lT0tBBiAZ98OwYVKpPiF201c+CmjSxs4NcSZ0JpW9+9mKMtM9Q+wWSFNJ9z
         KAdw==
X-Forwarded-Encrypted: i=1; AJvYcCXBkxXJdyWKZXSFSyy0UhXa3NmZM5B7qniETtVyQysO6LljscnwhxdZO7CbsjZEPTMytC0CgyJrQZnXOVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSXQ+rbFEVHLqvmXq98gPVEghkNk02AELisBJhhPyPVlznUHU
	KC20KkhSjSANlmFDN8ipR6xmvFjpEe7i5fySS+LEuS1LnnBwo7h0YX3xgNQwU3oAYbE=
X-Gm-Gg: ASbGncuXejOfYKso48ac0x60RjVOACQqx0gpSkNdJ42F3BvLTSKGU8wWD7M6Ptiwwz9
	k35K6xqdndtZOftyoSMiEazspKJyeyS6v5IDmHadgu4UZNUfZMmX9fETUhwrDvFfwRjzITD4bnz
	acPdVtg3yTS9zauZSQ4K4HX341bYI+r0Cgz147WRRrSqgP1ZAE/Gk+2WbRx8Gc8Dpn1qM8efNBf
	TxpshR1IRedtg3gX42lKOPDsp5FOkL+X2XdQiFSU6J4gQo+BLAra8KOXpiqpwFKyTgSouBXi3rZ
	YslNU3SLZyv/WOdCbe/VVNx1B6Jm8mpqpME325qtPirTsYdhzgNFApmWM5EHM4JNa3VwX+gXNGi
	0YgnUdDtczOApBfHcKKSTgvk6x+xjHKltmvM3vrfzWoUYBg==
X-Google-Smtp-Source: AGHT+IEFXfAwL8n5C3J9dCog5MqYjz/0z+tjRYy8VBux8QIcdwHNBxHHgPhwuMllRtUOig1ksCGmnw==
X-Received: by 2002:a05:6000:26c6:b0:3cf:3f1:acd8 with SMTP id ffacd0b85a97d-3e765a2367emr4237912f8f.28.1757702157424;
        Fri, 12 Sep 2025 11:35:57 -0700 (PDT)
Received: from [192.168.68.105] ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd0a7sm7293297f8f.39.2025.09.12.11.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 11:35:57 -0700 (PDT)
Message-ID: <0bc838d3-26ad-4f2f-8bb5-1c34748e1fbb@linaro.org>
Date: Fri, 12 Sep 2025 21:35:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v3 00/16] Introduce kmemdump
To: David Hildenbrand <david@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
 corbet@lwn.net, mhocko@suse.com
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
 <9c2e289c-0258-4e25-aaeb-a97be89ebd84@redhat.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <9c2e289c-0258-4e25-aaeb-a97be89ebd84@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 18:56, David Hildenbrand wrote:
>>
>> Changelog since the v2 of the RFC:
>> - V2 available here : https://lore.kernel.org/all/20250724135512.518487-1-eugen.hristev@linaro.org/
>> - Removed the .section as requested by David Hildenbrand.
>> - Moved all kmemdump registration(when possible) to vmcoreinfo.
>> - Because of this, some of the variables that I was registering had to be non-static
>> so I had to modify this as per David Hildenbrand suggestion.
>> - Fixed minor things in the Kinfo driver: one field was broken, fixed some
>> compiler warnings, fixed the copyright and remove some useless includes.
>> - Moved the whole kmemdump from drivers/debug into mm/ and Kconfigs into mm/Kconfig.debug
>> and it's now available in kernel hacking, as per Randy Dunlap review
>> - Reworked some of the Documentation as per review from Jon Corbet
> 
> IIUC, it's now only printk.c where we do kmemdump-related magic, right?
> 

Yes. The other places just have some changes such that I am able to
gather the data inside vmcoreinfo. (remove static, add some function to
get sizes)


