Return-Path: <linux-kernel+bounces-744981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B321FB1133E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07ED16B8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A9D23AB87;
	Thu, 24 Jul 2025 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9oPVGd5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4F238D5A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753393272; cv=none; b=f/gsgWTa72CNyLBnyUu1sfkgFmZ9lZotiLQqyvBeQ1OAOuAh4kWhNwTVG0RD5eUfgRqQUGSpYumW0eYmj4tOmMMap373PejyChKG9CrFxMJxwiBG3kOVxq9EAQuq8IFO7tzSkvbqCkEMWSit768BJhZ9WqnFj02dQ6aS/5W7vI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753393272; c=relaxed/simple;
	bh=im1gJWs0ojnDUOHaAqP8XaDDYWK62JnYZbtWAeXFdDA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LcQsRAtRkdNjmv1ve5r0ae9tg7wHyOJ4VDzoajmkh5X5hy6fAlBoo8CcY78hwDuHZApECfSgAI4r/9x/564gesOmaRsRWbmmjrYHWDXmrzt4431tPrkIIPIjSCtJRmAF11JvR8KScPi9+lDJb6ZuY1GgH+tYM47WZ9KwbpBIDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9oPVGd5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753393269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2oDW3PKI0DWOwdUilD3F+jYY1Y79YAsFgQ9CJbwuCt0=;
	b=B9oPVGd5TN9/8hJrw3yM9q/5qP6jZ02F/ycclJ0R8vA7yEgW0qTrNs+ZEMtTcLNIHeA3DH
	WRf7BvGXUqdqmAlZbfYbktodRjAT31vDNywA7e/3lNXgdJweFtW+5DAXp3u2UrLEXt4HhQ
	8Gtx1wWN/bVGW3bikjm+LbjsSIvs8Tw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-jdoTM9ZBMTiEQ4IIbQ9PJQ-1; Thu, 24 Jul 2025 17:41:07 -0400
X-MC-Unique: jdoTM9ZBMTiEQ4IIbQ9PJQ-1
X-Mimecast-MFC-AGG-ID: jdoTM9ZBMTiEQ4IIbQ9PJQ_1753393267
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so11103615e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753393266; x=1753998066;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2oDW3PKI0DWOwdUilD3F+jYY1Y79YAsFgQ9CJbwuCt0=;
        b=L8TS5NgfuFI4qYRfoezNzeTHCCgAdq3fYuB1Nc/duhktJAX0E61UmqaAuEo9eOJWFU
         g4SqoNqRGIR/QkION1bQee1gTnXPTYYGMRPaanKszbeybpLCV7jmE20SUYQf8voSWyiP
         Z/JU7H4DTmT3d17378bBuowc0jMqjNzAkc6P9K3OWKB7QwCRpQEgw8mhaaTM8blb2e2U
         OKQCyo8iblAljiKc3FRLBD3i0ZBRxgighUBydrjdX2KWK+ixhxqcNEtaWgztF1IE6EB2
         Ir4xl9LCHWWkkVodmRVlptREOr8dqhmb2aJ/n2VZWsSP2NCO3qH6W1hWuBc6wyaGLbwj
         ZMYw==
X-Forwarded-Encrypted: i=1; AJvYcCUWLfL7GK25t3rpX0oKtkl5XbMHmixmCObj15X2qcJAqQsUv6wZvdBC/QjeJzloTQccnBy3SvT43Vhw0dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUHHfdR8ZGXdTFob9Oo3QKEP6wak81hR4Pn3qoMzkArzjU/Ea
	dEexZ+L2tJ7tffbxwljWvIXPSX7AOF0+EprRFotkGU4ChS4a4byvEz3SN/hSKOIqtaBnfVtOVR/
	BwQ5J6c7i2PRhxJQHVIgMakKzh4q9y9y+6Q0X3KR4hbmxbFya4oAtcSOT4aA5dezQdw==
X-Gm-Gg: ASbGncshGQx5R8xmV8ZOTkDGHj9Rmvs3buK9PKHEimtS8jT1/QyJVhZCc/Rglugo8Z4
	vfIsVHY9+mZKX84C59aupCHSL7sp/mFrflKjVCjzL3iM3y++oglZolzb/NKXJxOzkExjpXVuKsX
	onVqRbKJzeonoCFTuexIDNmS7UCk8ZE1BmhFi08a9OT9ipcNgHH2aDjsI7mO2m0uiGr2WocMs9o
	SwIvsZBtZHmc1XH3bpROrrKUBicROtKV9lyYcyJori/8Ab+8dsXwkzGrjs3/0b0cdAarX0P1unq
	QePzNcIAovYWMIZhpO6DQHPddoGnDrTc7oXb8bRBa8+wYv0VLVnov7Mkj6W4dVGHDbhU/eY=
X-Received: by 2002:a05:600c:8717:b0:456:1923:7549 with SMTP id 5b1f17b1804b1-458731e04c8mr4140335e9.26.1753393266590;
        Thu, 24 Jul 2025 14:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjZdRc+W59cRKHplILqNhUcU+p7LiEOAnfsLFXmp1s1nZ/3ZC1XfGFJSMJPRAkSFZe5T/2xA==
X-Received: by 2002:a05:600c:8717:b0:456:1923:7549 with SMTP id 5b1f17b1804b1-458731e04c8mr4140175e9.26.1753393266134;
        Thu, 24 Jul 2025 14:41:06 -0700 (PDT)
Received: from [192.168.3.141] (p57a1acc3.dip0.t-ipconnect.de. [87.161.172.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870554457sm34257195e9.18.2025.07.24.14.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:41:05 -0700 (PDT)
Message-ID: <ef111032-e108-4771-9202-b8cdab278422@redhat.com>
Date: Thu, 24 Jul 2025 23:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
From: David Hildenbrand <david@redhat.com>
To: Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <202507241352.22634450C9@keescook>
 <e0a22433-541c-40b0-92bb-34b0596db642@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <e0a22433-541c-40b0-92bb-34b0596db642@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 23:32, David Hildenbrand wrote:
>> As an aside, why should discard work in this case even without step 4?
>> Wouldn't setting "read-only" imply you don't want the memory to change
>> out from under you? I guess I'm not clear on the semantics: how do memory
>> protection bits map to madvise actions like this?
> 
> They generally don't affect MADV_DONTNEED behavior. The only documented
> (man page) reason for EPERM in the man page is related to MADV_HWPOISON.
> 

(Exception: MADV_POPULATE_READ/MADV_POPULATE_WRITE requires 
corresponding permissions)

-- 
Cheers,

David / dhildenb


