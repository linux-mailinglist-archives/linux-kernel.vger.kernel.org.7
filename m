Return-Path: <linux-kernel+bounces-814447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C529B55437
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464F51CC3084
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF430E839;
	Fri, 12 Sep 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzDlI4U7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904530649A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692590; cv=none; b=J1ksy4/xBDKqynfPYnNTCYfjv2cuKfyC/KE6OmdsCiNjYMV9UqU8eKKgG9gaElHQXnpZgFZeWR2ubqWwP1aZs4ChtKvq7Dibrce2fp9ZV2tzWLXIPwMZhGeUHsoTRf+ew6T9fyJNmcRbjPOX1DQ5XfaJNHQYdy2keY+yEBp9Ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692590; c=relaxed/simple;
	bh=mwW56UXsjqcvDGGsCe5C+HUYMfxKIh5VjjsG46235iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxT55ApwXMhPlk0pWi6MaB5GKp4W4emrQpgomChibgi/05wZ35zHTDp3aYZzrGMmt0wnyfT3fuQPEegzUTWyUpLns3wTpyxARkqU61GVTewW8MmI7NHCYqL4pWIUJjd+1wxv55CJEuxSRV2RJYiK92svxAU2VKS6Kdu+ch48ECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzDlI4U7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757692587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LwtSBiRgh7l8m3eHqvj0Z/4D72nKcmOwOzm2avrIc6A=;
	b=AzDlI4U7adkgkDk1r0w5xCMl5zeLoSrg/d9HgVAwWMrcUgecnVBGt0jwzzOATG7Fo9UNUd
	Cntx76pKX6oJMcPdyM7W0ufyY0zrr2B22tmPqCyajZsDToXwTb7CMVeYdAhe7p//w10V5Z
	O5MJ/ZadF2NpCb9eUZJmKtczaiQnY80=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-kxtQMpcHMqSShDbNkE-A2A-1; Fri, 12 Sep 2025 11:56:26 -0400
X-MC-Unique: kxtQMpcHMqSShDbNkE-A2A-1
X-Mimecast-MFC-AGG-ID: kxtQMpcHMqSShDbNkE-A2A_1757692585
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so11795365e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692585; x=1758297385;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwtSBiRgh7l8m3eHqvj0Z/4D72nKcmOwOzm2avrIc6A=;
        b=mVcQH0tVZfoypS3PCX1QpUTi6pmMWzF6GI92IpB7x8PAW/RSp42Pu/lMyCW/sYYvt5
         MCexPGn2q9uHjr5lwBo4LYj/TWwBynl3ly8KiF2xGHYea4wEck71mDQDjW8e+7mBxlrB
         FzVLED+eJ1C+/CEMPtxRBhHvhthd89A2lcW22gj+AW1tircpT6RPIcPSM0gtC+OmZTOX
         2uQ9UrFWQbjadj1qYQFG2PkleJqsCAIWloOpQRywTUqdlu1jT8cdhH0gM7BixVVSrugp
         5d9uZthA7JzvEHc4mkhD0hC1YjziSNoIdU67aAENoW4iVhh0ElsT/a2EP4HrNBsUjlYk
         aBMg==
X-Forwarded-Encrypted: i=1; AJvYcCVh0ZzLQEWEa8LzTtdFTSy5ZYWbIh2IKJPyVpPCEv8XushE9sPXxDYPwhXAcIjxqMaWbTQ+YzZkXMu2PZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudAchHRMbWzGMQzKbbRtzveuMqyeoxcw/xmq479AoH8ob6a+i
	rg2W/ik6iiNFYDkJ1ZK13CYW02W98bJNYg0TbG+MXyeqgmm+6WGr1im/RD0pPBpiChLEi0JBcKt
	JoF8BzGnMt8rJid617M6bCk2MRVE3J6Bak2GzyZNwDrqXQ4wJ0Amtat0Bc8vkNoFn4Q==
X-Gm-Gg: ASbGncsFvl3k9XnAIiLLe+477Kt/zqX4iSeFHxeXPqGojmLruYxaxs28PB9Zi9Jpce+
	sT7ySrK8XuRVqKrpeggUpSxf46SRwPTsHmJaQIYVs/2MIhuNSjQUt+xU4C8Ccttr6QWnricJX7V
	UorwvuteJgf7iOWLd7xV2ZCLhek6zL3e/1NbQXieP7v9Jdvv1gidox8XkIDbhGkIBbXehLFtjld
	XfbFqieeDu4g1pzQ+JLfJAsu3Ns7Mj6AOfauZg1Qj6uohC7v3z1q+aoMwmtO7dg/IYqncGXdDvo
	il2nGz1PYXluPjcLo6kT01JAaksS96CA8lDbD34TkZ6kHBzFEB0OuwgRKCUwmuNdI4wF3wq5bAH
	RGwAhlV+Ix69u37etZ9M0seDdvvglJgGJazqM0SMOMq6ICaLCOQ8sNoZOPN3Esnp0rf4=
X-Received: by 2002:a05:600c:22d2:b0:45d:ec9d:5fc3 with SMTP id 5b1f17b1804b1-45f211f6790mr33105675e9.18.1757692585250;
        Fri, 12 Sep 2025 08:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFac7W1MrERsCK511VnCTt0k5ir4FTQySao9wgWh9TgtQ8MeIZa8a3y4/zUuscFnBsbmei1sA==
X-Received: by 2002:a05:600c:22d2:b0:45d:ec9d:5fc3 with SMTP id 5b1f17b1804b1-45f211f6790mr33105325e9.18.1757692584728;
        Fri, 12 Sep 2025 08:56:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d62besm65340495e9.21.2025.09.12.08.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:56:24 -0700 (PDT)
Message-ID: <9c2e289c-0258-4e25-aaeb-a97be89ebd84@redhat.com>
Date: Fri, 12 Sep 2025 17:56:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v3 00/16] Introduce kmemdump
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
 corbet@lwn.net, mhocko@suse.com
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> Changelog since the v2 of the RFC:
> - V2 available here : https://lore.kernel.org/all/20250724135512.518487-1-eugen.hristev@linaro.org/
> - Removed the .section as requested by David Hildenbrand.
> - Moved all kmemdump registration(when possible) to vmcoreinfo.
> - Because of this, some of the variables that I was registering had to be non-static
> so I had to modify this as per David Hildenbrand suggestion.
> - Fixed minor things in the Kinfo driver: one field was broken, fixed some
> compiler warnings, fixed the copyright and remove some useless includes.
> - Moved the whole kmemdump from drivers/debug into mm/ and Kconfigs into mm/Kconfig.debug
> and it's now available in kernel hacking, as per Randy Dunlap review
> - Reworked some of the Documentation as per review from Jon Corbet

IIUC, it's now only printk.c where we do kmemdump-related magic, right?

-- 
Cheers

David / dhildenb


