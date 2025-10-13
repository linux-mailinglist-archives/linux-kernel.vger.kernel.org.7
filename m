Return-Path: <linux-kernel+bounces-850123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88709BD1EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DD33C1AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E52EC543;
	Mon, 13 Oct 2025 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBVQwdzL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A12EB5A1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342930; cv=none; b=JDmtCkDVh9nK3fWx+FRwadX2zix5cIueyFctoBlyu+eMBPxXn0YVYevcKXAGH7p6FsFhDf8d1xamlWGGHWjKppwnQ2hZaJWb6Mkk2C3+QfzKUmOsTMk/tj/fDtA2LEZNFhYSm9fnhu5uE1gaAt4eI/2IMWOodRXHqHU3q3ETWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342930; c=relaxed/simple;
	bh=jywHHX8NPMGREGR9LE5j9sCrdP5Nufbn/h/k0hLvmAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIDnpHtflbKr89KJmNvwqMGuT8L9YsS5JkWGEiCbOXBBdmb9/plNCzPoYfjeYZI8DInu+899WxywEoAhHXKSpekl6+VNStjb4dbpDN7Olu2/3Mn8Nd+/prHVMWX2ZLA0NQw5LqbETMApoUhyFZDpOBPj+jOkq0+f66FViTswNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBVQwdzL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760342928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4rGWhIH6coFHE3rQ0DRdJqk5g1C+PTj7t73yGUhElbM=;
	b=OBVQwdzLGj7ugZHNFW3RQ/FYDG8hHdQ7S/5ZxRXJe49dBoqh6u/v3DvpDxalfqai52n5NP
	sg6PR/WRBu2g/H6xr6NzLlyxsx8OGQKzIOy0AitRb7xaVe9vcea7luABLcE4nokZpBP78z
	h4ZFmxsvK5WSKEpd5h07IwG8SvsBO2c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-nLEuZ5OqOJmZ1NnvEKLxmw-1; Mon, 13 Oct 2025 04:08:46 -0400
X-MC-Unique: nLEuZ5OqOJmZ1NnvEKLxmw-1
X-Mimecast-MFC-AGG-ID: nLEuZ5OqOJmZ1NnvEKLxmw_1760342926
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so2258213f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342926; x=1760947726;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rGWhIH6coFHE3rQ0DRdJqk5g1C+PTj7t73yGUhElbM=;
        b=ERQpL/74AcurmMu61DTcNfqpqcab+oUS4nXPFT4CCAr4KfjTJCQsgG6igVQ7u+zc3U
         Txcw2LBvmqhGcg1FB7kSdIsZhZJe7UoiNLQ+kDTu9p9eySSPuK2C+pRgPZkUCn1Q+22j
         ONEfSjLXOBdQvPz0+lN472eyf7bnEVlLVvYktq0tq47whHDn4xeAQ9DTbFpyacLXQvEl
         v3Cof4bdFHBwZdQ2xX+myWDIbgFEU3X8QS1UZtPN9TeqgoBjhMZBXUetPAOug96fQTh3
         hPgk0wz+YQarA0L2dJxdIhMcGzwisxzLKvRaMp9Tp31qBOgP7zHGHq6au0UuuJhfDeTn
         Reng==
X-Forwarded-Encrypted: i=1; AJvYcCU3gzMARMXYp2htN6mbw5wXDQz1cbFv7KIBbB6liVrQHtmAnFTPwICOrI1OOosMuZ2MlaIc4mUz8zZXXOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOEvZP/Z5VPl8h8xmYNArcrSygxKvgF+6jqX8UnaAww+JFk99i
	+RgSj3UkCJ7CzBJCsaL18lZKvtk8G2OhlysbjyRIMMVsMHpj1la3e2lsqCSt7t2BfUjHlcAbB+5
	qXKDMzVd/fla5GCcgI9jZRWdpOoQz3uVpkRhB51HOb2ap/7/quuYraey6ROzs9F+vgw==
X-Gm-Gg: ASbGnctRRutI9lGhSlNddCnWmfHY1NOfBByQ87jw5Xbj+Wc329Y46Unxw8A7Auq+biV
	noqNgXMxVygczEXNekQpqrezvnJYWaetydN7eEVfGyVaeHGRSDm6NYa9eH359cU9X6NJOHNWAHJ
	TM8v5KNnLMnGJlwHtMp4KmNzNcQTr77AEHEpdsbsbQ1Sz8FZNADHMeyw6CK6szyDMO64MfRu3BD
	KtwfwE6mPxjy2EpSNztMkUHp6B35dnmnSWGofC5IXoKI9e/VZtMc9k7fEJ5I+rnlrjf8qnDgfaC
	pSIp/Tm4c+fTZMkoHnEROVBK0wKcAu+wX1SED20Sj/SspZ2zLbVSb2CMOnt2OaZ2tA0KYYwfoyd
	TZw0=
X-Received: by 2002:a05:600c:a02:b0:46e:4499:ba30 with SMTP id 5b1f17b1804b1-46fa9b052f2mr149913675e9.30.1760342925668;
        Mon, 13 Oct 2025 01:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKuCmdhxrI4bLVD9WE9l2bFabtqBxMzkFdsNlub69j8Pv4V5ZKLQqIsHuujn6qApLkW7GwzQ==
X-Received: by 2002:a05:600c:a02:b0:46e:4499:ba30 with SMTP id 5b1f17b1804b1-46fa9b052f2mr149913505e9.30.1760342925288;
        Mon, 13 Oct 2025 01:08:45 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3cd658sm126106175e9.1.2025.10.13.01.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:08:44 -0700 (PDT)
Message-ID: <bd88ec46-0588-4915-9737-15ddee4678ae@redhat.com>
Date: Mon, 13 Oct 2025 10:08:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before
 folio_wait_writeback()
To: Byungchul Park <byungchul@sk.com>
Cc: Yunseong Kim <ysk@kzalloc.com>, Hillf Danton <hdanton@sina.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, Yeoreum Yun <yeoreum.yun@arm.com>
References: <20251002081612.53281-1-byungchul@sk.com>
 <20251002220211.8009-1-hdanton@sina.com>
 <20251003004828.GA75385@system.software.com>
 <20251003005230.GB75385@system.software.com>
 <3b66d603-543d-4616-92a5-9e6e32f116be@kzalloc.com>
 <deb6c0a2-e166-4c91-9736-276c9f1741c9@redhat.com>
 <20251013043631.GC6925@system.software.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251013043631.GC6925@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 06:36, Byungchul Park wrote:
> On Tue, Oct 07, 2025 at 09:04:59AM +0200, David Hildenbrand wrote:
>> On 07.10.25 08:32, Yunseong Kim wrote:
>>> Hi Hillf,
>>>
>>> Here are the syzlang and kernel log, and you can also find the gist snippet
>>> in the body of the first RFC mail:
>>>
>>>    https://gist.github.com/kzall0c/a6091bb2fd536865ca9aabfd017a1fc5
>>>
>>> I am reviewing this issue again on the v6.17, The issue is always reproducible,
>>> usually occurring within about 10k attempts with the 8 procs.
>>
>> I can see a DEPT splat and I wonder what happens if DEPT is disabled.
>>
>> Will the machine actually deadlock or is this just DEPT complaining (and
> 
> Of course, it was an actual deadlock, not just DEPT splat.

Okay, so some deadlock was triggered, but not the one described by DEPT, 
thanks.

-- 
Cheers

David / dhildenb


