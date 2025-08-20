Return-Path: <linux-kernel+bounces-777359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC92B2D8A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7B91C808D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EE82D8785;
	Wed, 20 Aug 2025 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezjuEoG2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAED38B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682264; cv=none; b=D9Q/R3nGaRW11gLkZnrzZ7knZjo8ErFgKTU4ACa/0NzdoU36geyls1yKQXiic9XKo6FJ54anb3ac87NOe/NBdXy6STyVtzjNLRwTUhJGG//2PiQ/kWkQybRfnTt83//Cc+u9hml/TQ4jvJsXLhI2aH8PTKUWxXFI0LBBKeCw9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682264; c=relaxed/simple;
	bh=uEONxTWHL8FrISTeULSEsiCuLOr42TzXkdpACNXc3NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4iBgNTXsonXiP0V4+0MvzGGmuoET0ggNwvxIDrdhb8mrC9+IZKeFibXrX+5iOJEfQtVAiT6I1113lsDrN+pJhlQOD0d2DO8rkcu5UPlKD2M0cGmcZJfBDo7Bd8dCDivK1Q9Ho7+uPTyWaI4It4W/Gj2LCoUfxUgfiuPQbhEMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezjuEoG2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755682262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Iss6PFQZzwJgBsaDesf5Jptp2Rl0G9Hey47fwUvN4aA=;
	b=ezjuEoG2eP+JFuZ+yy17XtpCXtUusidkohRmNxscMI1kCLMOMm3SmeJYaBabtuFqev5MwV
	GKx141V5rj+NVOpe6o5enxSSNoeZ18SdrDLaZ4YBxFulGdo3pDQOdqLLonZM6outym4crv
	iO4aHdeUZzIm+PTgQ7OpunOD71160XA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-trLghQl4M_6bjm310yVCKA-1; Wed, 20 Aug 2025 05:31:00 -0400
X-MC-Unique: trLghQl4M_6bjm310yVCKA-1
X-Mimecast-MFC-AGG-ID: trLghQl4M_6bjm310yVCKA_1755682259
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c3b22f45eeso239662f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682259; x=1756287059;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iss6PFQZzwJgBsaDesf5Jptp2Rl0G9Hey47fwUvN4aA=;
        b=qS0gEde3f8KI3veAIVlZroiWL+iwQpJgZs//XqgxyJFTzpXYhcY1shNMCFRQLzFjxD
         mGmRsQpdVd6IbTuKwWN+7mqSMO4iGDNKkYx1/gUv8eavmocpSGoOzPws5Dv/L1BdHa8E
         Hv3uLtAZd61USSS0lrBZ+FoPvKXCopBtvPRtRynE3kirmo0pkqWfoCL+AQ87AZpb2bLT
         JNJ9uCvbARo0UOge/fDmPMNDUsOe2WDp7wwAaBWAgE6JuCyIjgysLqSeJ6jg+iBLPhPk
         MPf2+TXs8XR0xBUqAlh9/c/jO/Jg8cuK65qCdvxWRgcu0ovtApgkq4I4KZ9X6abMQl6+
         gGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUMQwt2aTQyNs1XiIRRIPkXeAujsk1bdWyH1CVKB5OCf+PFDfFOhCCXs2bYmUKchuUxF1LNHUlP5t8uDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDBoCseFB/ryq7TX5U9M4dOz4K+JnmBhTxp11YPU5b5UiSrWc
	tdU3iXpibdxLrJ7RJ9Ggp8o0QjpBt/JZMkMBckb7Xni408tjilT0Mb+4VJse+DLAEHLSoxOb5gl
	yZqLrz4ma14W+fy3Rh2K1izAes6l+xBd0J15790NgZrYeBGGazpBnvR7WLN3y1iOB7A==
X-Gm-Gg: ASbGncuNG3JETcEsyicXhgb81QrODhDaFuYRY9kjfYKgTW73Ks59+6QMazy5F70jgp1
	0CDELSHhDenlX7n1sNoaOWPW9IiqA/QFLL235bIfkCSRS5Xwzo0UhUUqZfmYypH9aVZUmrIfXzi
	6rFFQ2P3aw3fEESYzeVKdcWALHf0qiCydrjxP29eePA/jcMgZ8J0yMe6cBGKCxlETr5lbzAmmis
	zrVe+qsUz+yoEecATal7tjS2pmDitv5UbdAleydf42to+NNwoWzzzqIvfuRzJ6y15+eh87VccKZ
	kxQn2bMhPNayG+vLmvTqbjjHKXd1NfNyKO/y7rDYHKT4HEo+s562Q3+zNeC89XmwbHpKRZ0sSQu
	Cgnbq2zAdFYtW5/z9niCNrbl0t0K+EKQE8cXBUG+mgPKCb1HfX3otSHo0u/k2FgLx
X-Received: by 2002:a5d:5f81:0:b0:3b8:d79a:6a7d with SMTP id ffacd0b85a97d-3c32c2471f2mr1367508f8f.13.1755682258814;
        Wed, 20 Aug 2025 02:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFloYRsbWBWgN5EVMfsNqMt4OjjEvbW66aX8dU78SJDiDZe5AHMWMACsZ9FO4A6ZXMcYgAIZQ==
X-Received: by 2002:a5d:5f81:0:b0:3b8:d79a:6a7d with SMTP id ffacd0b85a97d-3c32c2471f2mr1367482f8f.13.1755682258377;
        Wed, 20 Aug 2025 02:30:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f13:de00:e9f1:62b4:5bb:5d83? (p200300d82f13de00e9f162b405bb5d83.dip0.t-ipconnect.de. [2003:d8:2f13:de00:e9f1:62b4:5bb:5d83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47bb2431sm24742335e9.0.2025.08.20.02.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 02:30:57 -0700 (PDT)
Message-ID: <2c669a58-1741-4b22-8fa5-752501a6e128@redhat.com>
Date: Wed, 20 Aug 2025 11:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSCB2MiAx?=
 =?UTF-8?Q?/1=5D_mm/cma=3A_add_=27available_count=27_and_=27total_count=27_t?=
 =?UTF-8?Q?o_trace=5Fcma=5Falloc=5Fstart?=
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>,
 Xiang Gao <gxxa03070307@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1755654367.git.gaoxiang17@xiaomi.com>
 <d30f91137e3a296152463ea65474e1ca56f4eda3.1755654367.git.gaoxiang17@xiaomi.com>
 <24ed0c41-6ec3-47ba-8f63-94c521df995b@redhat.com>
 <d54bb3a5e5924dbc87cdf63e22ac7d00@xiaomi.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d54bb3a5e5924dbc87cdf63e22ac7d00@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.08.25 11:27, 高翔 wrote:
> Is "request count" also written in the title? The previous "count" was 
> changed to "request_count"

Right, "cma->available_count" gets translated to "request_count". Maybe 
that's the issue here?

PLEASE

Can you (Xiang Gao) test the patch before sending it?

Nobody has the capacity here to go through 20 iterations of such a 
trivial change.

-- 
Cheers

David / dhildenb


