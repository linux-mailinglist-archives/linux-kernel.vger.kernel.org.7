Return-Path: <linux-kernel+bounces-847363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B4ABCA9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECC01A63F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065023AE93;
	Thu,  9 Oct 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3Q8Hln+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E921FF38
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036250; cv=none; b=NdU0MqHxleQWoQVBhmqCZEghAU0OrvOTi49n56dtLpjB2p5qNSNAotPoJaRaiv6iirtudYnBprGd7lgesUn+ZIfXuePs2rvGhN28dEdYWNa4WR8BCjQ13VRsL9lgSrWqWvLhsN2PDk3RVtjLaTiXOVWn55pOlCnMusUaSTU57CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036250; c=relaxed/simple;
	bh=bIvM2NUYhsoIb0HcYzAEDodqfO9BCIwsvJiH1knKAxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJu+e6onIwwokWc5lE+Terw43mCqpyLf9IizZLxII7AY2FbXgsI34UDL2xHfoy7kFZQ69/Zj8TbmfZaNChK1ms/ROj/qRVpJuu7qp3ndFzqAHEtPGanoMrHPyYWD1FRuMAp/tXWW3lRgA3qp3zhnqp2FSyBjnn1K2XRHtrlP0FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3Q8Hln+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760036246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4iAzp85+07WQisNUePEagQ4q/g20R/GAnT+gB8Cya3Q=;
	b=d3Q8Hln+8cfRzhbBk1f44gDV9fxnc3OQ82VUabbY7IZj1TNgc0V0z48DsK94IQ8jFVSq8c
	LX3rgaVtiUqJMfTSNbN+n3rD/jPodoXJmEckQH/stR79JVo4FaX1vgustu3tAGHVdWrRwV
	NhCEv4atwIMW9R7mUeJ4RdYd9hueaJM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-PV_lsL4OMQ-f3GvUireKBw-1; Thu, 09 Oct 2025 14:57:25 -0400
X-MC-Unique: PV_lsL4OMQ-f3GvUireKBw-1
X-Mimecast-MFC-AGG-ID: PV_lsL4OMQ-f3GvUireKBw_1760036244
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46fb328a60eso3713485e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760036244; x=1760641044;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iAzp85+07WQisNUePEagQ4q/g20R/GAnT+gB8Cya3Q=;
        b=W6qahGkjmAt3S9H5h82GwfGoIdN9SdwABSHklWfYRKs9ZQ/mbR27away4OG2aSjSUf
         /p2/wO1DGgvhiGj63tYlOYsExZoie2ot7NBSxobvxUGQYBFcK5ToNcvkejuUFFVjTc7e
         difJP/K5FLGyVxQ6pWlKnrucQillSRvdmSQL8KdskMBL7+62pI/BV/hGUJBOPGDLrKQ+
         A0LLrMZDRkfsRxvg6INeI7+Y1dal0E2YwWQYrh1NalDVxtJsiRUE3ePLmxrh4nrXAbXZ
         1S5OJxuNH2ZfjGAjU1HKuSbBVOmposhLv6sjr348fGEsi73QVl55QRxSFHDjuOW1XAeo
         mA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqQHxM8myusxjASDmTfshU7XSI9+3a1IQggvel2pOVdzOET+UAv2tNy3J7BO8ozEmZDhRGq8DwTXYZI90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqkDxx5TjNarUdQB56E4cg9lV7p1ByX5SDXdBvu1Dsiwzd7L3A
	dcraJDN9aJq6SxYBV90+Ga2J1ndSTQjKzIcpl+X50WguNz9ItBpJaQCWIBKnHsX2vXqq2vtmckY
	pauQIMhrO2KRpNDtYFsnYZsMDFLqKFcDYoO8frgHVNYlnXAwz9caApeYpb8AnUz0iuw==
X-Gm-Gg: ASbGncus/18n7Hp+sWud+u2CKMvGfeT5nfxc20wwYW9AQUuTFWVo1SqxidhbsyygquD
	06XapYO6ESNsop+HoHua8QJYinfGv5VfcISFbYeUEmsJJ/jcLNwkwEEFk4jwnNi7oKUGfj5zwoX
	Tt5cUgWfwiay68UZ0KmWmnVgGLPR1yBjdwoQC+85nVbc9jOshsMw/in1v9YfVwVGVM6jEB3p9xA
	/XI4DZO+L0lx4INbmgtNKTs7bMZxfK5iIyYXW2v7c+qhwKUzcislHij70S11KrMxZ7SoAG0t3UG
	gr/2Tayxxqk+tai497HuWoM5vxW8zErQZ4KhY93hQgav6orvwWhhb1WM0ZmeZK2Z3nVDy5poYzR
	NiUGCxNTP
X-Received: by 2002:a05:600c:628e:b0:46e:4cd3:7d6e with SMTP id 5b1f17b1804b1-46fa9aa0b49mr56621395e9.9.1760036244341;
        Thu, 09 Oct 2025 11:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7mys4/FDaXY2OCEWr6mej6Wrn1zZXPoZ5aHypkrEDlOnaV1ENckumi+N7FGBDiTJ4jMRNYA==
X-Received: by 2002:a05:600c:628e:b0:46e:4cd3:7d6e with SMTP id 5b1f17b1804b1-46fa9aa0b49mr56621255e9.9.1760036243964;
        Thu, 09 Oct 2025 11:57:23 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4982b30sm8459955e9.6.2025.10.09.11.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 11:57:23 -0700 (PDT)
Message-ID: <8c4d8ebe-885e-40f0-a10e-7290067c7b96@redhat.com>
Date: Thu, 9 Oct 2025 20:57:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/1] mm/ksm: Add recovery mechanism for memory
 failures
To: Longlong Xia <xialonglong2025@163.com>, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com
Cc: akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
 xu.xin16@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>
References: <20251009070045.2011920-1-xialonglong2025@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251009070045.2011920-1-xialonglong2025@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.10.25 09:00, Longlong Xia wrote:
> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> When a hardware memory error occurs on a KSM page, the current
> behavior is to kill all processes mapping that page. This can
> be overly aggressive when KSM has multiple duplicate pages in
> a chain where other duplicates are still healthy.
> 
> This patch introduces a recovery mechanism that attempts to migrate
> mappings from the failing page to another healthy duplicate within
> the same chain before resorting to killing processes.

An alternative could be to allocate a new page and effectively migrate 
from the old (degraded) page to the new page by copying page content 
from one of the healty duplicates.

That would keep the #mappings per page in the chain balanced.

> 
> The recovery process works as follows:
> 1. When a memory failure is detected on a KSM page, identify if the
> failing node is part of a chain (has duplicates) (maybe add dup_haed
> item to save head_node to struct stable_node?, saving searching
> the whole stable tree, or other way to find head_node)
> 2. Search for another healthy duplicate page within the same chain
> 3. For each process mapping the failing page:
> - Update the PTE to point to the healthy duplicate page ( maybe reuse
> replace_page?, or split repalce_page into smaller function and use the
> common part)
> - Migrate the rmap_item to the new stable node
> 4. If all migrations succeed, remove the failing node from the chain
> 5. Only kill processes if recovery is impossible or fails

Does not sound too crazy.

But how realistic do we consider that in practice? We need quite a bunch 
of processes to dedup the same page to end up getting duplicates in the 
chain IIRC.

So isn't this rather an improvement only for less likely scenarios in 
practice?

-- 
Cheers

David / dhildenb


