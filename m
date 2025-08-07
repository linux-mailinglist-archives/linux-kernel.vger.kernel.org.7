Return-Path: <linux-kernel+bounces-759147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B665B1D927
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2621C3B47B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889E25C70D;
	Thu,  7 Aug 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1+ledcX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DF24E4C3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573711; cv=none; b=q8wrw2b8b7AZSxhJXyBhn0u7V99uzEQizO25ArJQ+s0tyRapnkH8htqrDRh2dtcW7STa5iVMoBE79Vl7j47MoXtjQ509MwVsrYVyVpkt1uvl4ldUhoLDI0CpxehEm8fYOvOr/zY+Zs3ySHzNCBs/+EObDyFPIA7M9IKVOPDRUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573711; c=relaxed/simple;
	bh=Ofxkttwg0q855Ek5bR3XqsEaUHIuwh6pDb4e/Mc1zDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FQCSLf2Tp5+iIactQLtP8FRiEgXvFVpiQKGIwCBCjcbGyFOBjmjvGi3SXx+0nI9fSZ7Mq9mhdEEHu/a8NyJnahlKYxVsIN4x0H+uIzDusGYX6UlGF4SQ/fxky7PcrPtz6qWeL8FlHzLr+LiD4NwC2ZdsWvoUNH4KkXKvoXV3LZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1+ledcX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754573709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CBQHPeKWhgk2iCIsY4V4ZP6qdCDXKu5p8FwiQ8N6ht0=;
	b=L1+ledcXu+PTH7Lxz/wEWKMGrOXScfkZY7Q0iu+5ZgwBj6CKTvciktS0K6zzTB/8NT7i9k
	RyMKDTObg0M5EigZahwVrd4e85SQh3AyLjbF3/Q19GaTIwexOI9bRYjDa7wUE3L49g8U+r
	/ymsrLAg1ggv3T0I56fKIlEG86e4b9k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-bxxSMfWzMDm1svapZPZY6w-1; Thu, 07 Aug 2025 09:35:07 -0400
X-MC-Unique: bxxSMfWzMDm1svapZPZY6w-1
X-Mimecast-MFC-AGG-ID: bxxSMfWzMDm1svapZPZY6w_1754573706
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b785d52c19so456939f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573706; x=1755178506;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBQHPeKWhgk2iCIsY4V4ZP6qdCDXKu5p8FwiQ8N6ht0=;
        b=hfZnly8xsQUXycgZmzvUtb4mLWaRRY52YshQEAZ+Fi2+q9ROeulRsEu8tjQFpYbdTg
         gJI/uVK6ts+LUKwmZwX4fiEElMKrOoeFs7zJPOJALLQZRvSYr26PnkRbDYIu5fiSnrWY
         LDCey0G+pAGrf+bQmsUkAka7+HuxS3LXZvj4Dwnd4dk+QoRCx0tHeKOQ9lvtRSs4pFIB
         GdFAQ0eK1MP6Vb5pTfW5XdrWtO6j6xx22ty6w1fxDvFAzSQML9Aq9pPEBtV02l53uo9G
         2OQpyXDY6f0JBD5HyBMkPLCFtYlatYqErlert2+tMUvyaJOpSn/d7oOVW8n/2dyPneLB
         BfhA==
X-Forwarded-Encrypted: i=1; AJvYcCV73OlTi5msreiBGnZO4pMQGoTn1FOvlFU1GscLCGAE+VlaDDa8JC100t9N9EF8fabEWnKxTEqeHo8RGjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0VV7dKVuv+N8gmEhS0J5ZfEboobqwIow3miiJICdmXWHYpCA
	vBobgTITGMO9GHIHXE3il9HjAyoO+Q9Zpl9ihsYABApIlRjMB2T9Tk+HY0/6sJ+KKtYrPE7WxV8
	N1LlDSKIdyoVapFkoe4vSJ4Z5gl3+dtJ+EMEo5n0D/7Np9DU3OXiosN8uxZXywt8Xvg==
X-Gm-Gg: ASbGncszIZ/WWgQESCdL5d/A/nBEYXGNXrGL/4/XF4kKx85im+4Rb6FStuB2bh6U+2/
	oELHX/+F0olLBwoG4e1mzd4tNXuZAb0+e08jor4pCjRrtGTKjrSi64e/QYFb1cle7XGDHW0zJ9L
	Bw7vzeKDkoD6u9sryqyXhog+EqDacXAWgO7cQwzBVHY30Iku0BYvYZxuVzDEW7yVgad5LUE+jH1
	J2xWnF5zP2b0ZLUsvgSfav6cnysuP3OGOjkvIo2q9OB3phnQwNZGE8W5ZRsBkz1RmApzGNJhUVc
	RybLWNJzfTrPLvSLe5w8JtKwFsn6mcobz23WnBthCjt9CtgpAqS/3h3ThOdotFAG8IF1ARvxaz9
	1iSnDVKNKxFlsUT5M3fEnszg1iNDuNEDAJJ2Jt9F1myxM8CjpY+35lhph1p+L15H73ZE=
X-Received: by 2002:a05:6000:2510:b0:3b7:9ae0:2e5e with SMTP id ffacd0b85a97d-3b8f48d517fmr5156108f8f.9.1754573705626;
        Thu, 07 Aug 2025 06:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKAWIc38nplrhbPxuf6snMnPctmO09EXGzbkFU/1mEiE/6sqV99tA3cZv7IkrjU5hDDh+S9A==
X-Received: by 2002:a05:6000:2510:b0:3b7:9ae0:2e5e with SMTP id ffacd0b85a97d-3b8f48d517fmr5156077f8f.9.1754573705113;
        Thu, 07 Aug 2025 06:35:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f49:bc00:12fa:1681:c754:1630? (p200300d82f49bc0012fa1681c7541630.dip0.t-ipconnect.de. [2003:d8:2f49:bc00:12fa:1681:c754:1630])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abeb2sm26905675f8f.11.2025.08.07.06.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:35:04 -0700 (PDT)
Message-ID: <bded0995-4930-400a-a3f5-060073e4caa0@redhat.com>
Date: Thu, 7 Aug 2025 15:35:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_balloon: Remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250807132643.546237-1-rongqianfeng@vivo.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250807132643.546237-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 15:26, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
> 
> No functional changes.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


