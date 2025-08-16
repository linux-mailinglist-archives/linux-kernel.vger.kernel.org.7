Return-Path: <linux-kernel+bounces-771759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89ADB28B39
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845C63BC52D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40521CC68;
	Sat, 16 Aug 2025 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebURtJ1g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FFA1F460B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755327415; cv=none; b=XRjCc8AAt4iNB2WxSISadoQR1eJowrb1MdJ/HoiTtv0M6tqjEvVIWOjp9GqczD5Oqg4oGpViw1OAgtguid6x/ZtRW4pNXuBq5QaXhKM4RfeIOX6pRQvg7Kaq8hFYiVzd0pyXymv4LEY6tThrCBmzJWjzP8Zl7sHC3HcxvSiO+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755327415; c=relaxed/simple;
	bh=bI4rs/1ljEWXuiqnYOGV/rAnn1FN0kF8J4+0GBa75Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfFh0BFh5rKFefsP7iNTbpAhEGfwXD3CgLsZzoGu4v6T2n/8hAjmHAKBQWZj9jyasAkAli2vBkgJ96NNp6k0eofe3F7xx5VQgJxhmd71MeIWSsvnLXyDuZMrDxb0fEHmlsHxn7uKvqAZlpBVBfECKEfn7iPd7rHeskR7o5xvN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebURtJ1g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755327411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KN8fg+nbiX9r2kmZVMOFzoFbgLpi1t5HuR+4HKB2nW4=;
	b=ebURtJ1gjobSwfhSkuBf6zIz0ZZAOfjm9tJo4rQtjInCaUwUF40838oU57+OICLf9VyDsW
	01tl+kAv+8cNyvg6oRSdEko8ULH+L61T1n7YDrFXPzfZPAsXsZD0XKtGtpluDnWu6Joug5
	7QDmLwYEQvPZldTVfWF9t4sfoUv7ERQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-b2OsFD22PraVPl-W-qnqlQ-1; Sat, 16 Aug 2025 02:56:50 -0400
X-MC-Unique: b2OsFD22PraVPl-W-qnqlQ-1
X-Mimecast-MFC-AGG-ID: b2OsFD22PraVPl-W-qnqlQ_1755327409
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9dc5c288eso1888823f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755327409; x=1755932209;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KN8fg+nbiX9r2kmZVMOFzoFbgLpi1t5HuR+4HKB2nW4=;
        b=d/iQODPJW6Wxe1zK0CHLgIVnCA3GvhfpQUHlZHCRE3CZ30kJGUPC/bh8BAmzTCsOCy
         qpzNmmugNzW9xXjfI9aA6rMq+4h8HR3EbF97/y+gnrco3BAj6ZTyTKBZMRYju30qb82Z
         H/j0amlyzesVROptkiKB6bB+T56A9EgGxumu5H1hRxrPjeQ8eYv+HkslTuM23vc7am1O
         8l4efwVevSRqs0tKbh/jm+/E2SNsqv00aPwudT8CmU1GVOVbFjII7BeQO33Wpq37ym5Z
         iZ82YiByugmwOwgdwcnht9gT9YhuIFSHNLi80W2uXzs5ilKYF4/F3ywX5kiFgld2Eowm
         Vg/A==
X-Forwarded-Encrypted: i=1; AJvYcCWyw2CvhokcwfTpSI4ug2fAemHn13p1MlK/UfX9AjFF6U1PekXwvlVdSJtwOPToGw3dX7EDdr4wgTr8TqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84Hllp0fnkw1INx9eiWiZ7GwrYtnfFtkSX2nY/fsZcM+POJpX
	OhzQ+/IAyj4/8tgyxIAhEBE0XUAdoC0Dfr0zZirG6HE6j4/y/SDk7hOuZm6Q9PPmydhQ6S7H0xS
	z4KPt3vbEadfvrQ4jmQSqbbJvBo/lLGmvJsY89URwzQt24VO0Kwc5agVIyRWVXXbhKw==
X-Gm-Gg: ASbGncvqTTnfRDDnqOS5HoCTEUTpnVBpAqPdHYC+lul3FO1E9af9aL/G4QqL0czNmhW
	V5HMlcQOA6K72JwGqH/RY/yqP4xKrXVMPnDJfsfNaFaThIDPO79R7f3/IV/hYiX+fsT/LTHONYV
	h/LOakZI/KPE/3yATZRmVzHhdqZX1BM2iQEJQTd2P9XmUPv+Rl5RHyrDuu5jXWci2ydJOhVWfDM
	cdR+O+64IOWko6fg5Gu9m8tk58yUmuPC3Ytq9HevfMGpH1Y1lOH79JVzApFMSbVpjdgWeF9BUpn
	TKChff1GWfx94YkaALGQCk437Rzc1H7wbMf008JZAzryX4y1OqrR5UbpcVKybHXHuGjIojRQml1
	NY9sZmUkgZNt5zSwYILBJXLr1kqZpgHyLMbMbqB1sTABuiuvFaAGTVnidwlgJg2neA6k=
X-Received: by 2002:a5d:5f53:0:b0:3b8:d3ae:26e with SMTP id ffacd0b85a97d-3bb69b7d31emr2962682f8f.53.1755327408871;
        Fri, 15 Aug 2025 23:56:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO6LdVmZCPII/OsVa8BXcCaSLsJhIbHGjOSatlSPMXt4cEzP2EZ9sEjNz9iVGYBsrMs+Y2IA==
X-Received: by 2002:a5d:5f53:0:b0:3b8:d3ae:26e with SMTP id ffacd0b85a97d-3bb69b7d31emr2962666f8f.53.1755327408493;
        Fri, 15 Aug 2025 23:56:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a223206c7sm44705415e9.16.2025.08.15.23.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 23:56:48 -0700 (PDT)
Message-ID: <701bfbb4-6c12-4614-a322-def3ca923c78@redhat.com>
Date: Sat, 16 Aug 2025 08:56:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: print total and used pages in cma_alloc()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Xiang Gao <gxxa03070307@gmail.com>, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 gaoxiang17 <gaoxiang17@xiaomi.com>
References: <20250816042842.3959315-1-gxxa03070307@gmail.com>
 <ee29262a-911b-4a97-b619-0dea3b657252@redhat.com>
 <20250815234528.882ab58247cefc96e4137811@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250815234528.882ab58247cefc96e4137811@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.25 08:45, Andrew Morton wrote:
> On Sat, 16 Aug 2025 08:27:39 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>> @@ -858,8 +869,8 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
>>>    	if (!cma || !cma->count)
>>>    		return page;
>>>    
>>> -	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
>>> -		(void *)cma, cma->name, count, align);
>>> +	pr_debug("%s(cma %p, name: %s, total pages: %lu, used pages: %lu, request pages: %lu, align %d)\n",
>>> +		__func__, (void *)cma, cma->name, cma->count, cma_get_used_pages(cma), count, align);
>>
>> 		^ one space missing for proper indentation.
>>
>> But doing another spinlock cycle just for debugging purposes? That does
>> not feel right, sorry.
> 
> If we're calling pr_debug() frequently enough for this to matter, we
> have other problems!

We call it for each and every actual CMA allocation? I really don't see 
why we want to just randomly make CMA allocation latency worse.

Is the existing pr_debug() a problem? Maybe. But who actually has debug 
messages enabled in any sane setup?

-- 
Cheers

David / dhildenb


