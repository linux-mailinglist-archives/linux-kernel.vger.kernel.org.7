Return-Path: <linux-kernel+bounces-848423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFD5BCDBEB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811444248FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95932F7ADE;
	Fri, 10 Oct 2025 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvNqNllZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656672F657E
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108876; cv=none; b=CA+o8lzLyFplpfBF7yrCn8QXjbkGB0h5L6rFZ6BzVgxXJ74bRzGlZhpNTMc0jwBJXQocHxUuQy1uoz1Z/2JOkejZzfn3N5dk4vh1jF9s9VGana4OTAuHbIoHsLhGU75oTtqMCOgTT7BV5fUK93IByjOA/TbYmoDI7se8jy6d0bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108876; c=relaxed/simple;
	bh=gQrwr4gwxMvke4mFhglRe1Cg7eWP4zQ10dzsO7O6LTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU0IIn0UnPgbPwXF/pfUGUq/n/1Kydgy7j2kdTEovdO8yqoLeJwWa2lAwLw7Kl2N5LhZemOr1tDPVHUTiVwdHr97Qd4eq/eY/Ro02Eq1UpHFMK6IG5CxDDFCx2tdm66Ngi84NjVzQhUR2XjG+P1feyroqPqlRLJ9Y/uFVnlUstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvNqNllZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760108873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LZmqunuZRQwJHo8CjkO0APHqvfQELPC5kOsrm4zYYHY=;
	b=YvNqNllZIT8EnAcItKCWQ5SfdnyynJF9DcTg0N7bjs528I13rs7XAWEUvNj4KMLNJPODXg
	y/J89RgxdOZ9lk9t1ji7jUBbdrFj2lfH4XGqHf41e6nvUT5cIzTEuvG4Cofh6T1xuLVVdk
	qb4x//LL1VHGtC+yfOEz5w8kuIg6GzM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-Cgx54uA1OVqj-Su8aHRqzA-1; Fri, 10 Oct 2025 11:07:52 -0400
X-MC-Unique: Cgx54uA1OVqj-Su8aHRqzA-1
X-Mimecast-MFC-AGG-ID: Cgx54uA1OVqj-Su8aHRqzA_1760108871
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso17558005e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108870; x=1760713670;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZmqunuZRQwJHo8CjkO0APHqvfQELPC5kOsrm4zYYHY=;
        b=us+9Zp7MnQlc8sNYrue/VNXF1PvDjklVBqzneGXA78EAv9/ZbeBSDdPrwuKTeX+gJ4
         cAvkjMUPGxI9OcHp4ilSY3G57r9HZqXf5b53yf1DbZVVB+2LN6x29Trgfo4G3C7I7rTc
         mHeWUhFEOj8Up1r+MsfsLsvMFbpl/76h0b1xAwDgj9XkTnbM2fxQj+6TDaPdp+lFx4hs
         HIkDyzui70qRQELdyFb3OceeJtRvMq7ptA8hyr9ILwFTg6qVSOal1JgInvQ9LrLZOusd
         iQ31hS0+8uJlCswUTtkhdPmhV51KOXR4uGoqH5Lpa7z8/9zGJvMQOU1o99p3ey9i5Srj
         b6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkwSXG9CSrUKOoI1ndoW4GqqMrwvCqjSJDsBheshi7UfrGV9Y0DzZcSDBXDa2Ki9uWQJ3gM+hLwiNga7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0VD+8APqMZ1ptF+eq9rcpSuwrmob4Wx2q8VuVG7QW6U5Y7Ot
	gBF512GPI6CUTVxzhzE2aYAkO0OAburUP9JHv9IGLxDQ/Nwj8mTeMO00ZcoCov+S5LWdnld7gj0
	SGol1OpxkDTWhaBjcvQ51sjSbviBLAUVIB/V+Exi21lHdQ0+KiRYTPhq/Kir41VK8aQ==
X-Gm-Gg: ASbGncteIHxQEfxi54kfpmq+FxRkOWcBuQk59N1Ck1QeI/U9QiyMArJPsjE6veQxvmH
	4fkA90W6kbaFYSQ243xSNfeds0/yGtYK3D5iXtuYjgZulSOrh4I7u1tU7GWMSvflE1BMUfegBdp
	ZiA2Q8QzpZVLOtZ27TtjEF1EoS9ieIFFyRsZB62DNrx6yuY175yVvGxnQkppswWcyWQufv+Jt7U
	KM4jj8aSW0usE/tmuHxNLBsg/fx1D8haHNqWFV5ZM/AECt3L8zP9SfRXX91s4zK2Heq0WX4lGmy
	rDYm4KMRCO0Tl8RkE0LGfMXCvO3qpJ6byGyA7aqgS2bcVgEQ/F2eVNotpZ6h3xs5L2Z3V8zpNc0
	NAao=
X-Received: by 2002:a05:600c:4750:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46fa9af3095mr88636125e9.18.1760108870683;
        Fri, 10 Oct 2025 08:07:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5JHSDo+98ZcIlXqkfGtP4ZZEWBP769aS/wsbUmwWkDRX+gxG1VW9W555xuFif1HCTIaL95g==
X-Received: by 2002:a05:600c:4750:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46fa9af3095mr88635835e9.18.1760108870194;
        Fri, 10 Oct 2025 08:07:50 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489ad27sm51946505e9.15.2025.10.10.08.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 08:07:49 -0700 (PDT)
Message-ID: <c8f74a07-9003-433a-9b1f-888df335e31b@redhat.com>
Date: Fri, 10 Oct 2025 17:07:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/12] KVM: guest_memfd: Rename "struct kvm_gmem" to
 "struct gmem_file"
To: "Garg, Shivank" <shivankg@amd.com>,
 Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Vlastimil Babka <vbabka@suse.cz>
References: <20251007221420.344669-1-seanjc@google.com>
 <20251007221420.344669-2-seanjc@google.com>
 <dd948073-0839-4f75-8cec-1f3041231ed7@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <dd948073-0839-4f75-8cec-1f3041231ed7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> -	struct file *gmem_file = READ_ONCE(slot->gmem.file);
>> -	struct kvm_gmem *gmem = file->private_data;
>> +	struct file *slot_file = READ_ONCE(slot->gmem.file);
>> +	struct gmem_file *f = file->private_data;
> 			^^^
>>   	struct folio *folio;
>>   
>> -	if (file != gmem_file) {
>> -		WARN_ON_ONCE(gmem_file);
>> +	if (file != slot_file) {
>> +		WARN_ON_ONCE(slot_file);
>>   		return ERR_PTR(-EFAULT);
>>   	}
>>   
>> -	gmem = file->private_data;
>> -	if (xa_load(&gmem->bindings, index) != slot) {
>> -		WARN_ON_ONCE(xa_load(&gmem->bindings, index));
>> +	f = file->private_data;
> 
> This redundant initialization can be dropped.
> 
> I sent a cleanup patch including this change a few weeks ago:
> 
> https://lore.kernel.org/kvm/20250902080307.153171-2-shivankg@amd.com

Yeah, Sean/Oaolo, can you take a look and pick that up as well?

-- 
Cheers

David / dhildenb


