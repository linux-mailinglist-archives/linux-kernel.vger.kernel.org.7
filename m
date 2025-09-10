Return-Path: <linux-kernel+bounces-809472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D08B50E10
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901964E00D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43BD2D77E6;
	Wed, 10 Sep 2025 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq3Websf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44D24C669
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486130; cv=none; b=OaoQszz2ku02BI1sBIXGlzZ7SJy9f6w6D/S8R8Qx+z87ts8kn4XUueJ/1pB3Q2On8QJS3nquUtZIIPfOob3ecE0HQM9PdcbbrBTFY1rKQp3OnXP1CtPYGtgsMTLVJbYRmhkDnvucpoPjegzH2pulVxKVB1bKahWt65TbgfGNVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486130; c=relaxed/simple;
	bh=bQ+w15MTl9RN5jFUVU3nhNkvtLfWTqdQsXWM9m/f5g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JOYIWMpwIhdNxzzuNIaNAsC4LvqU/UVH03FOhas984q0gsEs4ST76/a9rKu8TRNMQjSrMZuYosO3d49g3AY8hPc/hNPWS4X5q+wx0CgTbViXqM+uRk9vReawl7qMyuaY9/36cxzPXCtFUGCBXySeM09Hv0msauBilYCMCkd1Xd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gq3Websf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757486127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1/tuWACW+YE3IQwtK7wyAuuhZean9mhQqCKf9VrtU6k=;
	b=gq3WebsfWBcuOA1kHiaGIppdVhz+Dezx6OK5cQFhuWUNeJ2MVZey1lK4th7UWHPfTJNvn1
	+kCNhhwJlG8N3KVunnj2ajbClB3z7lJxByDl2sFKPLEsjhrSrVfNrXBmp5ELqyfOkBNyQB
	8UuvBUGeEgieE1VBs5M/f3agq1aQ/vQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-dfWt8rCtPQ27YAi_DHg_EA-1; Wed, 10 Sep 2025 02:35:23 -0400
X-MC-Unique: dfWt8rCtPQ27YAi_DHg_EA-1
X-Mimecast-MFC-AGG-ID: dfWt8rCtPQ27YAi_DHg_EA_1757486122
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e4a8e6df10so2124186f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 23:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757486122; x=1758090922;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/tuWACW+YE3IQwtK7wyAuuhZean9mhQqCKf9VrtU6k=;
        b=BBkC9741sOYrhppWxKAdidFna7A+k4tArGWAhdoUcoDoSuUxLV2nbIP5YWU7hiFPT1
         RXgVg19FV2+0tq56dQG0B9Ck+z9P0skVvDsZ1i2EQdw7PL7ZYG+suKjziwc6Ic1uaN0b
         LhbtbgoTIB6khj0FSgYq3FUlOoraafUIG0OGUNg5FwWzkas41gv8+js0U8fUmU9ul2Jy
         ivjUxOddJSmfRYIBECV5L8xMR99KiSqfyI2wQjTKuWoTK6G8hMvnQVIYtAjisbDt5OKx
         pE2dXh7U+/fmV8QnfxatCEOUNDrnlHmDfqE6VZDYTMftImC5DUy92RhRfapWAbHvjYcY
         9sPw==
X-Forwarded-Encrypted: i=1; AJvYcCU8yq7MMe6MkMVux/w5NKQjqEPvJMseU+aHX7G58aEA4RmC3i+GfCWhg7oc5FSDsB1QudehWnRollpCV/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6TEtuJt3/PJ403k0RU5KKQtZJV5XZ4IYhQoX+/2QFhjcIE2Mf
	viNlKn3mGmKZ4lpFXYyPpbrQYJwVJbxLI3G+Xg31U62jD6P5HBaR2tuTQgjuQVr/S7ECi2NLI1y
	nxMaYysOIr6dh0Zvf4mxw3/8JR7cLUog2rtctrB0WEtF53ysXqNQG4/QC0pKZKcLU8Q==
X-Gm-Gg: ASbGncsRMEm8q+vlT6vphamlY3sKyP6ACyRnPiOTrVHE7usTfSMuQJqKFgejDjnvT9F
	oPWLHkoFQjy6dwnhSc+EVSsTco8NdJy3G5zrXG2c2e89HtiGbPtCkthSj2EFrV0tkmuOlyZTtK/
	rwrTLeObMVyYBLHBHlUo4/Bs9IuS/Y5F59a8dPRtiBhfHrxxgM2t5y5JJhK9vNSVn4LGG6mRwBL
	fSgaIgjXfQkr/NkX8K230ohxSyzUwY2DGljQgFSlNPwUQy/hVU2Tw8Gq/fHkpAirRXWzcXLr0Ck
	SG9i60pb5mVDcWyZmkgKqliqwfDmmgoo8y8XqXjEmyApX1b6eLB67DUo7OJ7xuU0csVF660uD+R
	bk5xNh7oAuT/K/yZqDVOYIHtEHMD3dY41erZpFt86tTOQYKxoMAbsgMc4tOANR03MQYo=
X-Received: by 2002:a05:6000:420f:b0:3de:8806:ed17 with SMTP id ffacd0b85a97d-3e64211e36bmr15711709f8f.25.1757486121992;
        Tue, 09 Sep 2025 23:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1CLbthnqMg0JojmsnCmMzIo0FEhwz8DHkvvjIQ85wqRnbvrk5Vvm6brGu3SKd0Vt6WZPpqQ==
X-Received: by 2002:a05:6000:420f:b0:3de:8806:ed17 with SMTP id ffacd0b85a97d-3e64211e36bmr15711680f8f.25.1757486121523;
        Tue, 09 Sep 2025 23:35:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfd08sm5429110f8f.4.2025.09.09.23.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 23:35:20 -0700 (PDT)
Message-ID: <26a9495a-cee7-4db8-895c-aeb0f1784989@redhat.com>
Date: Wed, 10 Sep 2025 08:35:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [crypto?] KASAN: wild-memory-access Read in
 crypto_nhpoly1305_update_helper
To: syzbot <syzbot+634e67b3f57206befe3c@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au,
 jgg@ziepe.ca, jhubbard@nvidia.com, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <68c0f496.050a0220.3c6139.0017.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <68c0f496.050a0220.3c6139.0017.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 05:46, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    be5d4872e528 Add linux-next specific files for 20250905

^ old tag

> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f70962580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a726684450a7d788
> dashboard link: https://syzkaller.appspot.com/bug?extid=634e67b3f57206befe3c
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1247a962580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12751134580000
> 

#syz dup: [syzbot] [io-uring?] KASAN: null-ptr-deref Read in io_sqe_buffer_register


-- 
Cheers

David / dhildenb


