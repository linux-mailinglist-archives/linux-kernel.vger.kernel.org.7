Return-Path: <linux-kernel+bounces-790647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B29B3AB49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740E21C25962
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B6283FE9;
	Thu, 28 Aug 2025 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhUyfVHV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8811DDA15
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411663; cv=none; b=iQpxoYa9+kBgtuA1vBVffHwuYrV/yepK5rtyD1NISn3k1BQtau8kReH3NhS+NQmVYCjPqzgkXQwUXbRU4qCCR0vQM/1PhtAcW+ydCsXm3LnMOGwx0HhXwYFsvkDOgSCzeF8QvmWhxKe3WAf2hzbt49IqPfrsPjvY+fx4005mX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411663; c=relaxed/simple;
	bh=5E1O+UiyxQ/swOde4rFAB1dAEwfdQZ8cuvjTa+rD2Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TG7ZEj9PSQKBwH1Nhdlp9QpU/fBDz/XXq5awAA3rSZ5KcVTuP7ND49U/KuB8QU9W6jgsD9sVdX93ueSQDEYmuYnllSe2hzrkHwRcMBvXYlNhHRPpu/t2ZJv+3cnJo/KLBffkGMby6y4FlR/a9D4c6Cnu0EFMw3tgZrmykUF1JiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhUyfVHV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756411660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HfkgN5Na07CaAG4rz7Sn0/ahtXb5ykSorD4ldptE3LQ=;
	b=EhUyfVHVQF0QXZbtrqgit9C/Ho+FOq9ZNmI6xlNtLIBDKW4MESquiuGnEk18TurgsJ8HRB
	W0sadOoBCi5Gi8nnDknjLzQDBIIRz6kaXwjy9r31XjxtBvLCmaj3vjHWOXKrjnohcgrMgg
	uolbA0iirHSA0Ri/wyKIda6ZDz7o8m4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-WKWPHeiSM9WRXze7rKk9YA-1; Thu, 28 Aug 2025 16:07:38 -0400
X-MC-Unique: WKWPHeiSM9WRXze7rKk9YA-1
X-Mimecast-MFC-AGG-ID: WKWPHeiSM9WRXze7rKk9YA_1756411657
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3cef6debe96so183689f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411657; x=1757016457;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfkgN5Na07CaAG4rz7Sn0/ahtXb5ykSorD4ldptE3LQ=;
        b=DjgnlIWLVX2d8T0YOUBWMNm23HhlP5WMmnL3YrKJ0irRsJB9Myhgsmf+JiIK6e0Ooh
         uWKnmpFTT+cQG2+98wJsj14C9nSTkfi/Uk8NcbyciHg/zXfuokyPb8Uwb05w05apj9UD
         bZrg9pLeHcSilX26DHwbS60rBR1NggBlVzJzepu1G3fKmPaMBTSXeaZC6YVijOEG4yWH
         dQR+jKpaIsvdRYOZFIFi8JRNKbycTksSL2nTEES0HxHkCQ3L90r9f8ImsyTOLzp2XwNr
         9OFanqzJJpsSY/ZulDq+PfgpQX8CImgdOTUjNWEu4bET8bvsemXKN5HeKTqNc8Yegpwo
         6y0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG51QnbBNqgEOZkIRKG4ZWky1JigXrdkxW9onBpmkdi5MZ5U7+B/vanNVyRxHt5bC1g6D+gz8LlffsWJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBsENi8jfGQ1uSUTkq3Ea7Z5u/8IDAwWk6nktEOTvkwdfdYPJ3
	q8G2iucNaaZGyerKSNaM7Z7HmSgRlgzwf4rhOnumF7EUMqQcGxphxqeYkxV+WsI/wRvxOJ0YsOd
	aASygeRFilH1ph3fSWWTp3tmaX3E6YBRXjZTiK0hfFKhzcXfE/8w0U9yakxHqHkm3kA==
X-Gm-Gg: ASbGncvRg6cUyzCbZJWQtPpkpmf7xsUI6gmTCcahm3P+0LVt5EZF7sByhgXWR2tFn9n
	I5roIQfCjfIcuta+9MQpELXjYft0qFr9+1O2QUCYr5zWWjjFQAoMbY6SAijYNn/ghNfKIhI2q+3
	pAdJ76wYWSz+2OnqRPFv432LsRqO42SkSZkr6RzjYqExjbIhiRgcN15VupXnKJBwF1njgGjPut1
	yg8zL8hY6LGHdmXbeveJ52UW7MjiK5RvURVbx3OTKh/iv4qgsTGLVeqsLszYodh09AUPQjdk1Sg
	uTC+HoC2jQirDmCbefkt9g9OZ+BFBWJGq6D9rj29BUTgAy8hHA7C7hNpBpUTaX5CvzIY0QZcQRo
	Y9u/obq7OFwFxep46ymZZPSxWQzHwdT0IBty+a7DcNBdzUJOZ337sAMT8A1YJ5qzLc+0=
X-Received: by 2002:a5d:5d0a:0:b0:3b8:f358:e80d with SMTP id ffacd0b85a97d-3c5db8ab097mr20900803f8f.5.1756411657454;
        Thu, 28 Aug 2025 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP13xjdaXPmMbhRXQ0NNNX783mn1a/GHXa2M1CskybuLFx4H09CyoqA4ByC/c5FlmnBNweJA==
X-Received: by 2002:a5d:5d0a:0:b0:3b8:f358:e80d with SMTP id ffacd0b85a97d-3c5db8ab097mr20900775f8f.5.1756411656978;
        Thu, 28 Aug 2025 13:07:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc496sm561557f8f.1.2025.08.28.13.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:07:36 -0700 (PDT)
Message-ID: <ffe2f73a-6938-4079-b926-9d869f0642ca@redhat.com>
Date: Thu, 28 Aug 2025 22:07:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] KVM: guest_memfd: use write for population
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "shuah@kernel.org" <shuah@kernel.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "michael.day@amd.com" <michael.day@amd.com>,
 "jthoughton@google.com" <jthoughton@google.com>,
 "Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack"
 <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20250828153049.3922-1-kalyazin@amazon.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250828153049.3922-1-kalyazin@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 17:30, Kalyazin, Nikita wrote:
> [ based on kvm/next ]
> 
> Implement guest_memfd allocation and population via the write syscall.
> This is useful in non-CoCo use cases where the host can access guest
> memory.  Even though the same can also be achieved via userspace mapping
> and memcpying from userspace, write provides a more performant option
> because it does not need to set page tables and it does not cause a page
> fault for every page like memcpy would.  Note that memcpy cannot be
> accelerated via MADV_POPULATE_WRITE as it is not supported by
> guest_memfd and relies on GUP.

I also added this patch to the pile of guestmemfd preview patches located at

https://git.kernel.org/pub/scm/linux/kernel/git/david/linux.git/log/?h=guestmemfd-preview

There was only one minor conflict regarding setting file->f_mode.

-- 
Cheers

David / dhildenb


