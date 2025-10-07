Return-Path: <linux-kernel+bounces-843822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B156CBC0575
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4B73C3539
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EE61E5B7C;
	Tue,  7 Oct 2025 06:32:34 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B23208
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818754; cv=none; b=GsGG5tapBLf03AXwY+Q8QDoMhwJYqJzpSxPzcyl+0C7eJR+p/9uT1KZ0i9MvaIyhFvOcidPMFZB3vTUAEYx6mWdFlC/fB8m4Eu9/S1wQel4l9mu6KOsKJT44MULWwBwlQRUBLuEfMjKHgaj+uIlfGvXBi5l0cxtovoPIq+hLFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818754; c=relaxed/simple;
	bh=hYyfYckrsx8MnB/o9ezaFvNJQCYjBKMqokG3tB5c0LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9y6Ri85TzyhF71UtzBn3885XJhjO1vMjA6+LllKNx5a9lgOXnkiMQjbaCYMLKKMqECz3ACAI1onAyxUQnTqGtDCK0ahdmGcaqFFRbpoqIuD46s7ryn2d4AyN0UH8T30QTxnUgmaYrhLUHV6lCPIEdae+2ratKVtQddHgHRmAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781254d146eso397346b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 23:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759818752; x=1760423552;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJGCKWDOB+HDW2IfjXMw+O6nf5o51khcjA2mbC8osTg=;
        b=jvjEP4GRSnEYo01o+KA5ocBo+iYLmBiLZyD6Q5sRXgOEa0nTntHDr99ZW8zi0iPVT2
         Ql43YwbcLoy/B2v4G7W+jPkMW2GkSPO93xWuGhCJYowtXmZkku5+t3DSfwJIg6efERcI
         lyeqKd2qAoOLaHkcHKNcJcIVCH7IG01Vckzk06RuRS7/5/GX8RETT8O+HJMe+0z3CJ++
         WR+g3+mSmDBHNCO3/RMkf0b839f7OXRQ3z6imaSjlySd/OBzYRT+xLQExs89CPaBfb3I
         03BxBuFEjRpqPQa6FxZOn6K3hfIJ0Q/772mpNuQjKd0sw2ER9cH9wOCRIV0UcJzwMcoH
         20Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXP9m4bfHEU2iSiP5v3Y9a4JlNebjmDwtrqdH4a+EVSCHc20rzo1EFCMt9IoKD/VvvwfrlWEfzsKoYUXlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMpAMGQNSYeEeEHkHNE3wKTmSAeyCxgt6QfHiJf6a6vdj2Qc6z
	+TuAkyDsdDtBxUNoEvJgQHWq9avTzhuEu8o3thZOSSTI2KWsv6MjpOkF
X-Gm-Gg: ASbGncsnjZweGKaQNkoZxflD86Eiv0MoTg51Dg8a6FPcmce9+FDfOFCkEJv/ZX0gZ6Q
	VAsDh6ggBOl+uO1e4uEJjFh67PvK4CjWOsOni7kxYZb3/x8eB+mpSt5AxAUgGi/09YWhX07pk/i
	77C7HfQbBNxpnNmtUbxRm774FrGCiweRxxuOJJfM/7naozd/cTYoyF81BRU8vxck0LuaGpNfT6l
	sHJ9OuQ1nQeHr5nilzHKdbAsoGuQAGSH+R40SBVcgc8PvLRm2LTNyITe3DZpyclJAPqBxswn4ZW
	ozTHUdKRH7Y8IoJ6dwZgj3zP5zuGr8hIwsz+OZDw5vykMHD1NdOEcJU2EpjcMco7+sZHOPEUe43
	uildTQ2djywS7WgCOHkvZRgaUdLRJtsooJeSR3sMl1seX02DIT6bS2RQFwqvc9cb1wJioUnoneX
	1RYJ0iQihH6vevsq9rJRmwmOKqp/VN/pTxlg7wAmTvmDsMw4YmVRSR
X-Google-Smtp-Source: AGHT+IEhca/DKV1gkMLzYSeFHCblQernrwx8MiefUNdEs8Uem/33USeoThMFjQF25dXOu6Ao9GH78Q==
X-Received: by 2002:a17:902:c403:b0:27e:f02a:b280 with SMTP id d9443c01a7336-28e9a65bd1cmr98147365ad.5.1759818751599;
        Mon, 06 Oct 2025 23:32:31 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm153463955ad.13.2025.10.06.23.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 23:32:31 -0700 (PDT)
Message-ID: <3b66d603-543d-4616-92a5-9e6e32f116be@kzalloc.com>
Date: Tue, 7 Oct 2025 15:32:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before
 folio_wait_writeback()
To: Byungchul Park <byungchul@sk.com>, Hillf Danton <hdanton@sina.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 Yeoreum Yun <yeoreum.yun@arm.com>
References: <20251002081612.53281-1-byungchul@sk.com>
 <20251002220211.8009-1-hdanton@sina.com>
 <20251003004828.GA75385@system.software.com>
 <20251003005230.GB75385@system.software.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20251003005230.GB75385@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hillf,

Here are the syzlang and kernel log, and you can also find the gist snippet
in the body of the first RFC mail:

 https://gist.github.com/kzall0c/a6091bb2fd536865ca9aabfd017a1fc5

I am reviewing this issue again on the v6.17, The issue is always reproducible,
usually occurring within about 10k attempts with the 8 procs.

On 10/3/25 9:52 AM, Byungchul Park wrote:
> On Fri, Oct 03, 2025 at 09:48:28AM +0900, Byungchul Park wrote:
>> On Fri, Oct 03, 2025 at 06:02:10AM +0800, Hillf Danton wrote:
>>> On Thu, 2 Oct 2025 13:38:59 +0200 David Hildenbrand wrote:
>>>>
>>>> If it's a real issue, I wonder if a trylock on the writeback path could
>>>> be an option.
>>>>
>>> Given Thanks to Yunseong for reporting the issue, testing, and confirming if
>>> this patch can resolve the issue, could you share your reproducer with
>>> reviewers Byungchul?
>>
>> Sure.  Yunseong told me it's 100% reproducable.  Yunseong, can you help
>> him reproduce the issue, please?
> 
> +to ysk@kzalloc.com
> 
>>
>> 	Byungchul
> 

Thank you!

Yunseong

