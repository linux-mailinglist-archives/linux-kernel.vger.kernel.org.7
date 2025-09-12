Return-Path: <linux-kernel+bounces-813820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C18AB54B12
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 163D54E175F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400313009E7;
	Fri, 12 Sep 2025 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOj2mOFZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34EA2F28EB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676970; cv=none; b=Hd+66tcDPSrLekN5M14J8KEF4xylCpDe4R2+/U+Wu+xL3tnaGyfPbIUiuBh5szxMm9NTi4fu4Yv8UtBDAIjSL8hESIFpSKyxM/KJRs56ZtLHgvv7MBOQ4Kc3wJ5dfm6+yiQa1u7F2heOeWyTITWGs6q+Em5scTnhoqs2I05/9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676970; c=relaxed/simple;
	bh=6HhHl5Q9HyjWqX7Y9YXL8kJIJbLXHU49bGi4e4jAGxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YG5eut58YD16L61awC49WHS+jgZ8L96TYintc7RmfPMTmNlkCQfRu/0RN770uXAhM9DfYgqvrZOe2bEqOUxG+nL7ddjw7ZaeRtQwZqMsdzEiObNwJp12QdBpVOdiUNpvSzMdra/ORAlb05YM/tD1b8O5ybaaHU6mRDa7g/sYXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOj2mOFZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757676967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L4WTNdMCGh54uRDM/L4Uxaq4pm+e6gS6JQHYqsqi25s=;
	b=XOj2mOFZ9fzs7SqurF0FUpLkugTTqOXC6JTSoQFXQKKtK2P3cqUH+hv52Zroggs8OUAMF8
	ztYhs4ieaq5bdY+745oMRqnWwkNZlmEXVIWz2hQzf5OyEjAG8r+/wlgthu/hD6/qLMSqdS
	ZRCF/W7TqAdtY9be0lSkkE+4B2VSHFY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-mkdYAifzPEy5rHIJuh-R8Q-1; Fri, 12 Sep 2025 07:36:06 -0400
X-MC-Unique: mkdYAifzPEy5rHIJuh-R8Q-1
X-Mimecast-MFC-AGG-ID: mkdYAifzPEy5rHIJuh-R8Q_1757676965
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de27bf706so8772295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676965; x=1758281765;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4WTNdMCGh54uRDM/L4Uxaq4pm+e6gS6JQHYqsqi25s=;
        b=NHMYwkXDE4ruN3xF9HvwsQwaSk+jW/q1+LPikbGaY89N9XEShhsF32CuBNX97P/i0b
         455xAC/EH67mAd8vi42TonpZ01RwS0AyjOCY2l3SDZby+M0fGAuRda5w7h7ToOl/2jHC
         FZMnO0Xio2I7y9Yhh80sI2jU50M1da192SXLlqthBa4Gmbu0XcPLflZg5u7Xs5Qe/3CI
         k4v6Cut5sneOkfM8HgsNnfMb9+GaEOVHyi+O5bq1IzmVRG2KkHBCuHDF914QhBhTxTtw
         f8B9r858DsZxjOmgbf2IT92Vuo5Mbofz+JN649CTa/D4kJZ4MVF7y4DjzkpWHijgspBA
         RXjA==
X-Forwarded-Encrypted: i=1; AJvYcCWAvfT7+jL8I8Iq7yCJzsWR6wDel0MA4UPZDfZ/PwF6mJ36y9QAa3hRhRJURP7xFnnHXWr/qKQGPsr8vNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gQgh/8WCObjtKVNCNX1YZmjCa63B8AUfOoJxtsRdsHaNkCSc
	g51CKD7Vi4eQ/aZZufq+vLqo5c5vNRpyvlaNOLRarsviXrqDV2nCbrpTW+vBghne5rX7ltcgNEE
	DJ2FbTOW/KSiysYTTQbEnRyMx6xwsRqycvuZKJKWZ67twS/mtYUQ89L5FewQd/Pc2GA==
X-Gm-Gg: ASbGncu/BkECaW/0dSk1w/mL2Dve0o4+zNqCDxqQ5xboVWISu5BZFIHvfS2CMIe9JDG
	B9qsDtpuULbiK8Fkh3FZTXYlbjEQ5W51c7ag5lIzkw/C9cmaq+I6CfipgvA9RhclRzE3bk2MHXY
	hnHHDqxba8PXVoC/dMD6CxH44kqoXUEHMKuUgt57IZieISeOV6toNvmY95YB5cwTuu7bbpfdnWQ
	qWvdDVoaveEXviY1k82RXHLrrhYUlXY9tXsUnpuk/6TsLLQxHsvCBnPxz0d50EJSlixhKC4gjkI
	W3HKVhICBnlcUZv6/fEuhj+3xn5OOj2lyijKJfZL7Gob3EJWuaGfT1+LU11SB3opdh4hulv4Kn3
	FqHEzlNxWOVlid4OJuNkdxQWdh4n0dQkRD090hXyJcWx2zzudpuCShrM5doSsl0KmUc0=
X-Received: by 2002:a05:600c:4e4b:b0:45d:cff6:733f with SMTP id 5b1f17b1804b1-45f211d517emr27953555e9.11.1757676965164;
        Fri, 12 Sep 2025 04:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEApCot1i+5m775BUiDD6WRxTCaO0+qykFG5pVRf5Sw41hSYWcT5lrn+50Nw2D8nJepyAo5JA==
X-Received: by 2002:a05:600c:4e4b:b0:45d:cff6:733f with SMTP id 5b1f17b1804b1-45f211d517emr27953335e9.11.1757676964784;
        Fri, 12 Sep 2025 04:36:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775842sm6503959f8f.7.2025.09.12.04.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:36:04 -0700 (PDT)
Message-ID: <3f739d3e-f6fc-4a3f-9bbb-151a6dc6c083@redhat.com>
Date: Fri, 12 Sep 2025 13:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: transhuge-stress: fix potential memory leak on
 realloc failure
To: Haofeng Li <920484857@qq.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: 13266079573@163.com, lihaofeng@kylinos.cn, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com
References: <b6f38984-5f89-4a9d-a905-ddcdbd7510a3@redhat.com>
 <tencent_43768D3DB24034B62C249781C1DE7359C807@qq.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <tencent_43768D3DB24034B62C249781C1DE7359C807@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 12:10, Haofeng Li wrote:
> From: David Hildenbrand <david@redhat.com>
>> What do you think happens when a process exits? :)
> 
>> Correct! All memory ever allocated to that process gets freed, avoiding
>> any memory leaks.
> 
> Thanks for pointing this out. You are absolutely correct that the operating system will reclaim all allocated memory when a process exits, so there is no persistent memory leak in this specific scenario.
> 
> I opted to add explicit memory freeing in the error path primarily as a practice for better long-term maintainability:
> 
> It ensures correctness if the code structure changes in the future (e.g., becomes part of a longer-running routine).
> 
> It maintains consistency with other error paths in the codebase.
> 
> It prevents false positives from static analysis tools (like valgrind).
> 
> I'm happy to adjust it if you still think it's preferable to remove the free() in this context.

No code changes are required. This patch adds more complexity without 
any benefit.

-- 
Cheers

David / dhildenb


