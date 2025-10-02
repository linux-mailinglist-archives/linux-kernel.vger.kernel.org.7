Return-Path: <linux-kernel+bounces-840189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB49BB3C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A167AAB54
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31E30F950;
	Thu,  2 Oct 2025 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyOBtIWb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D393093BF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405148; cv=none; b=ufoOb1Da6B2ILW56R2z540sLEkN7FFc/VUDZokKFn/Jvd/0KP6KZfw7tsD1fK7SOE65uL+qPAPU6Tshla1xXMoxO+DYL9AKs0jRMEc0CL8oB0ZxSF7QVv6fjrDhWaBwuUUeGEL0fvQXnju/bZULJjLTb1z2/KcnatnS+13PNADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405148; c=relaxed/simple;
	bh=PA4p84o4OwpRRklTmE8Es/Wa2NBpXIWuMp2qJ8492aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rk2xmT4AbH00oiI/zPHvxl7VoFMrkHtHgaoxf9UPh9cPAeVnUjVjHu4cJxP2jHuBCLigXIOGTHnJhzVJwJxdaIbGEI9T9glws4Y0usvt+lY26uE3skNeCQTRYTciU7GlYlKfYMpm9oDqi5V6CAIGDdCVWsm4IXmOcs3r60c3Ops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyOBtIWb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759405145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qa8gIa0V21yaVB+/eCXge80xz63JZQgqa74/kUyfFBg=;
	b=HyOBtIWblvEJEBXvN6GOv0umpXcHxwQEIoGzcslRPqiw46gCXoLZZjyvoBYMbJY8FwFPCs
	mDh511PF+GsG6ezaRTztqcNEttZwNfn1TVSDz1n61i1oDH2zeI0RGTu3LaYGmuCsVUIMIS
	/MnMz7kSRIzYfXjgWMFRfEkLsmPezbo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-maV49fxXNK29POmTBOf_0A-1; Thu, 02 Oct 2025 07:39:04 -0400
X-MC-Unique: maV49fxXNK29POmTBOf_0A-1
X-Mimecast-MFC-AGG-ID: maV49fxXNK29POmTBOf_0A_1759405143
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e509374dcso3973985e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759405143; x=1760009943;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qa8gIa0V21yaVB+/eCXge80xz63JZQgqa74/kUyfFBg=;
        b=KyChG6sKLgWql6XVxXFzFFHe2pPUHmWpyXveZzfzakQ/VemAI3HE9GRrFtoVINzgrF
         N1OyrGt8ES5Pi5kTNRPylJ7Ypnd74R89WF2l4wUIKD3j8PyCyOpM/CmfQvs1p+Oaccpa
         W9vzmToRPZ+OjG+ctdoIrsNKbAxS+2bpNUr1eVDpa0PYx+/tZmcwO2KXhbfP7/IcYlRU
         +YboWkN3pnudQjFV2rxrTDN7pcZ7/p+MCVYNn3wJSDP6kBpYtbSoSn28dsat5iYHdPre
         bYV+8YtGV+MjeFz8zA8xcg7iNOVJ310l/lzb1XWtVh+ixKomy7bPNiHcEIFKDeRR+uL8
         6zVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVOeCoLaM2ccW9Ebp2EwNYR2cO1lseBGY2zgLghI1yVtl0x2LSEh6GQThMYj2QYnE19byWayvSLnXJHk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY320cR/kU1T6+ugkA6Mi/MrwEDUqdQDqEuEEuJconuF02Vlhk
	o0ucBCVYj8wglMvvivpq7AU/yQjNqVazN/BIlRkSuwHWbDV96h/ex4+yQEs30Sn22uDCkcJp8O7
	1RUFTlFG5h3Y1P4nPW0ta5ljcUPxCI3iWvXZzIdIxMlyVQVgMbw7ioSaD3+whka2eQw==
X-Gm-Gg: ASbGncvr9Npk9fuacZenIyQNmmp1U7hkT7w4Wsvb8NYv3pDKXa6Vx/vU/S0SLzsvGc3
	wDJN+Fz40fE+mZi1PEzW75r8DSSdpTvujs9XzqZGgfbe4oYb4T74KWj6fYPiYeqd6JpzakRELqH
	YGoyxsU0bVQylnzMTUA/XjZiY4gRHgtoZ19Bls/gk22hHhzvsRzhIaDrlV8pxQ9LS1MQxJxaNMP
	BRluzAgZcClrFwbL7Gf68zSEnWkXTmIaRsl5SE9s8gVZVQ1xTJTUIDF4+yaaYi2V5d8sgV14XZ8
	NJPuvhgeW6FiI529JS9YRMcC+l3oxN8UztUN6SNptUmGLNie3YqtA3vAi5ov0gYmXMQYN5OHLOj
	N60/X97zi
X-Received: by 2002:a05:600c:3e10:b0:46e:5aca:3d26 with SMTP id 5b1f17b1804b1-46e653f84camr38704735e9.22.1759405143346;
        Thu, 02 Oct 2025 04:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyThTO2nCYVKvGrKXsprfkdDNwOhJqAGfAyefFwycoBiTM+WyfaA8y0YZWBdbXDJvOp6TQbQ==
X-Received: by 2002:a05:600c:3e10:b0:46e:5aca:3d26 with SMTP id 5b1f17b1804b1-46e653f84camr38704395e9.22.1759405142936;
        Thu, 02 Oct 2025 04:39:02 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b69bc0bsm54311425e9.3.2025.10.02.04.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 04:39:02 -0700 (PDT)
Message-ID: <9a586b5b-c47f-45eb-83c8-1e86431fc83d@redhat.com>
Date: Thu, 2 Oct 2025 13:38:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before
 folio_wait_writeback()
To: Byungchul Park <byungchul@sk.com>, akpm@linux-foundation.org
Cc: ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, clameter@sgi.com, kravetz@us.ibm.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 max.byungchul.park@gmail.com, kernel_team@skhynix.com, harry.yoo@oracle.com,
 gwan-gyeong.mun@intel.com, yeoreum.yun@arm.com, syzkaller@googlegroups.com,
 ysk@kzalloc.com, Matthew Wilcox <willy@infradead.org>
References: <20251002081612.53281-1-byungchul@sk.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251002081612.53281-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> To simplify the scenario:
> 

Just curious, where is the __folio_start_writeback() to complete the 
picture?

>     context X (wq worker)	context Y (process context)
> 
> 				migrate_pages_batch()
>     ext4_end_io_end()		  ...
>       ...			  migrate_folio_unmap()
>       ext4_get_inode_loc()	    ...
>         ...			    folio_lock() // hold the folio lock
>         bdev_getblk()		    ...
>           ...			    folio_wait_writeback() // wait forever
>           __find_get_block_slow()
>             ...			    ...
>             folio_lock() // wait forever
>             folio_unlock()	  migrate_folio_undo_src()
> 				    ...
>       ...			    folio_unlock() // never reachable
>       ext4_finish_bio()
> 	...
> 	folio_end_writeback() // never reachable
> 

But aren't you implying that it should from this point on be disallowed 
to call folio_wait_writeback() with the folio lock held? That sounds ... 
a bit wrong.

Note that it is currently explicitly allowed: folio_wait_writeback() 
documents "If the folio is not locked, writeback may start again after 
writeback has finished.". So there is no way to prevent writeback from 
immediately starting again.

In particular, wouldn't we have to fixup other callsites to make this 
consistent and then VM_WARN_ON_ONCE() assert that in folio_wait_writeback()?

Of course, as we've never seen this deadlock before in practice, I do 
wonder if something else prevents it?

If it's a real issue, I wonder if a trylock on the writeback path could 
be an option.

-- 
Cheers

David / dhildenb


