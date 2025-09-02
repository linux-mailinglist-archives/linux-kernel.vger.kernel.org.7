Return-Path: <linux-kernel+bounces-796097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3F1B3FBE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C962C3628
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85362EE272;
	Tue,  2 Sep 2025 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pcw4kjlY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306E2E611B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807816; cv=none; b=Ih4POxp432OdQp/P2g6xvY4gq7h62Xm/8u2fi+zKT9MRepTaL9VBxH68TWvyFd/f+Qe0Cgz+n9Wd72Pg+FPjmRwkCVpqocGunW4LkBLIgSo2DPju9gKt4q9mBoPpd4klLP002V1cJZc1hGYpFO81CXd1ecGJZ8YfZFcMWUlOYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807816; c=relaxed/simple;
	bh=S0RQns1SYkAADFj61NVljo1M9pJx7VE3kJAaGz1531g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYYnC8L8n2SOo8DCrcDec+XvNGfEB0oX4NlYRTF4RPkXPWrlMkdUXUgaNaMeaEY4EevlGljrwMmQYjr2x83KafFP6bbrsgNd7BbtLUp6VMmSFGbLujaFc8eih68qd61YqYT4sOQzzc4wOo54c15lZi30VKgLVaqBA8BA//P92u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pcw4kjlY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756807812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6wdClPbvtGlTGAY4FJdMl3PBrF3is1zKBeqf/3g+Hb8=;
	b=Pcw4kjlYi5s6YNXRZ3vdc6yHbB0xfgxDGFUplL9610Us17tnPlG5e5gaBzDip4nma8BsoR
	ZI9W26PEE10yUudwtM2YvcRL+XxkUjjy+2I01BjtkyJDslPyTFMpbHW9mL0WjNiicrxwyV
	3Ww/r6ItyMWa5EriFGVWaMVTXyWUhcE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-TolDXlYFM8SAsFqlvE-CMw-1; Tue, 02 Sep 2025 06:10:11 -0400
X-MC-Unique: TolDXlYFM8SAsFqlvE-CMw-1
X-Mimecast-MFC-AGG-ID: TolDXlYFM8SAsFqlvE-CMw_1756807810
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3d17731acb6so2764195f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807810; x=1757412610;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wdClPbvtGlTGAY4FJdMl3PBrF3is1zKBeqf/3g+Hb8=;
        b=qfuQ6eZ+r1zLrBHhokWIjJj50eCHw0ZsUETpGlpzUSRifLbl/Otv7l27T5Fxx3oXTV
         S7b0j2cOEhdm85/kErkbCqWbzlutpED5DAlwD1+i3+vFja0k/44kyEolZ0uABCDTlDBr
         kpPUmz5DJHtGVpsISHy21Ra1UbiY+Ozwv6cYQNXBye0J7M3PfjoJusWIfOCzuvPY82KO
         ChU4DFnGcZB5xntyR/tmkYSpciVQd7x1LGehTPctXzOtOcna5+8N0MZ94LqoCATKQYyt
         BJI9BTAnYH1UjElqU1VYzIbAdO00BxtEVRbQX4l9wlho0XTgE4iAgNnthQWQpLkNpEzt
         185w==
X-Forwarded-Encrypted: i=1; AJvYcCWh0P7cazDJKiVyn0OU/eJQ8FlKlO8Enr7HPffou8KsyzFYN823dqqQkRTu7msGDb40g0aVoGrpb6/tfV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3cE2fL+Tcyf7tesyybz8XNXtj8HG7JHKzTGXoYLOSUHIO/6p
	WbQa2WB7XfPNZMOvYHgAoFAiD9RWr3Xi7aqYYTK4wXYrFZqCJMoWK6MztOmNF6JBaHuzLpxujsX
	XqAowZ59uyygEdh84jzKluwUuksH5c9v6hLj4rAvXu8g/GnCtFEQkkciEndSLc2dCug==
X-Gm-Gg: ASbGncsCEF/GJdHwyfyB6XxLRvJY4nbMAYI4L5aecRuJrl6EBtMo4EsbDkFoU2OWJ7f
	BZK5IA+9dDoVpYFLM3RzlP0eagt3UHLATGd+tMHnu729IfZ6Hb1+GvubPEw4WvXi+ERwO97B2Od
	EIV5M3LRjhzoBcNbOD957jZ44uSguvrPl9jeQ9EzWZId5heDN/5X/hKx5dp8cFrNDMC35lF8Liy
	7yn2G2+Ri90EkYLVGoLqcK1xFizqTN9IW9dKM4xAuNYNeiXQDd9xqmrDQfiUR2U9vPTwuJpVux2
	8dtnIpv5OdNbJA47/UOsret6odHw5Ryy5TX095XszJ0B0+ip1HbcCmKRMcexCX04tadT6e5+VCo
	2hCAQWYVBpizrUZ5oCv6cMcVO899DRg4zZocbtOi7IKJuKnP71b3XAowULizjcUU4Riw=
X-Received: by 2002:a05:6000:40dd:b0:3d6:92ed:cae9 with SMTP id ffacd0b85a97d-3d692edce79mr4863334f8f.18.1756807810353;
        Tue, 02 Sep 2025 03:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkoI4ocC8az1pQjkDE/RfScpqsrmQLhs8u/znVft2GCWKtKFWLKJoOcckAT+Xzei+dAhtQLg==
X-Received: by 2002:a05:6000:40dd:b0:3d6:92ed:cae9 with SMTP id ffacd0b85a97d-3d692edce79mr4863301f8f.18.1756807809856;
        Tue, 02 Sep 2025 03:10:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9db4sm19138122f8f.47.2025.09.02.03.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:10:09 -0700 (PDT)
Message-ID: <e22b8472-6d20-49b4-b49b-78f79f126294@redhat.com>
Date: Tue, 2 Sep 2025 12:10:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-2-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250822192023.13477-2-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 21:20, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Always use swap_cache_get_folio for swap cache folio look up. The reason
> we are not using it in all places is that it also updates the readahead
> info, and some callsites want to avoid that.
> 
> So decouple readahead update with swap cache lookup into a standalone
> helper, let the caller call the readahead update helper if that's
> needed. And convert all swap cache lookups to use swap_cache_get_folio.
> 
> After this commit, there are only three special cases for accessing swap
> cache space now: huge memory splitting, migration and shmem replacing,
> because they need to lock the Xarray. Following commits will wrap their
> accesses to the swap cache too with special helpers.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---



> +void swap_update_readahead(struct folio *folio,
> +			   struct vm_area_struct *vma,
> +			   unsigned long addr)
>   {

Oh, one thing. Regarding recent const-correctness discussions, "folio" 
should probably be const here.

-- 
Cheers

David / dhildenb


