Return-Path: <linux-kernel+bounces-754854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C1AB19D89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614961899E2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69437241114;
	Mon,  4 Aug 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlzWA6Rr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2A2309B9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295833; cv=none; b=Yp+bgjaGLxem5hdNsXYkknKa3IqBNpPrKaJZbpIZijNQ/Ok7yArHLDXyg12sHXXZjO2FZ8/1bRHEUSwhp6tFbyaOe1FY82Bz3SF6+PIIk5nDeBPAEcq4mZoYTfmTbckRGzWYx3ks4MJzJS+vrO+JvyrDLf2J6Z776V7Svs1UyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295833; c=relaxed/simple;
	bh=LkT68GjqzQiYrquEBs3Y3ZQ8L4R3MR47KubEnVp078c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuFa63PXZzVuOorSR0Ohcil/VcFi81HtwgO7BAMBTf9Uf40hXNtDrxG3XhJ/LBwhusgStjgSsfcXhw4LAme87DK42A+1wZyrGHp4pO1j6olOVzP8WfE2xvjNt2m3RPdTcpLv0m47vpVxuMrfTDPkE8FxfqfLxWjNAEurH9OvCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlzWA6Rr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754295831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1n3PPznU+HBFNibwtC1BifY+XoPC3Q31WVffCkLFjxQ=;
	b=DlzWA6RrsCPiDgEJ/diCweMkvn3yW/8LxWCaI7E4NtCjqtJAt+wbbyUMwk4RmG4FLfXvIp
	QM9Xtf25YE58YaVhpIio+7S8BFYIcrw07JEbM3TpWKiA0qT5lVxTYtftUGDUTKM3Y9gKbl
	Gfnu5XIv8h4HTIadnnYqmJkUKryWFak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-qb2uvU8jPeCQDVstEelXqA-1; Mon, 04 Aug 2025 04:23:49 -0400
X-MC-Unique: qb2uvU8jPeCQDVstEelXqA-1
X-Mimecast-MFC-AGG-ID: qb2uvU8jPeCQDVstEelXqA_1754295829
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b8d8935418so1569602f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295828; x=1754900628;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1n3PPznU+HBFNibwtC1BifY+XoPC3Q31WVffCkLFjxQ=;
        b=Dmyn/BhS34r+y28/hnXppweeHt0GBGeICl3r68bZrws/RnPoFdrtN4mCQ+rRvtRUXb
         hz+1eF2cxkgwiK9ZkneGWsWZ+z1rmIbVTYK2OS7Q20AUQHX0D36/js4CkyJe+NVC5r9v
         eEH70pp6Yx0wOKH0YwUkQql5lTITd8oBNePF2xAYmq6rxNGJg6zfg/nZOaKNFKzXPvfK
         5fQmjzGwJr8ra9bRu8j6z/jKl2vzl7M2pF9Qc9tlrAFy2/r6gl9aRygbIicjnX5kOPTk
         07oVRjnKqOHTOWLEA/mfuf0IhJCbZMANNBLBBm7E1xpMbBFJCg4Lj39dRhtCRfGtRtLJ
         2d5g==
X-Gm-Message-State: AOJu0YzarpRGS0BJYnt4H7yqMGqL7Gm9Wgrj7uhMpeUmx6qp1XQ7pIul
	RfzhspfO2hXYcedmXfVcAOEvkib5WrPZ/Qwv6UooSuAL6PfRwXTRAzU0LsMbNRj7TkcFtb2/Wmk
	ngfFSqVyOLc8gyR5pCa87ngamPpZY3mb92pL4hY92HuEu0h9qPl5JJXcBuuEFV2p8fQ==
X-Gm-Gg: ASbGnctJGYmWNe2IYKZIZgAR9sUu3pf0WK3Imii/rpfhHZe1/zj9xA57DM8Us0/MQjW
	1GwqL1K0214ns3cXnAYy21fxne9yNypTGf6xGT35inc+oItuUB2otKPA5klSfr6Uj32yCiNPtab
	5ofxXlyeKSeEltLLTw1ZRtjoOVERtkY7bpsoebeTjZwVok4wmviHVgMfeF3VVY8pW/H/hzqhX4q
	7APndnkqkQSGE/GsOiPibB2KrfrjUUGu3HJFYUPuQN23g0VLxi8cj1BB6Iqj8em+WdAVErv6Prt
	2dZWsSw0sA3r2YUAnepV4QaCSw0U5wB3bQ2uE2/ucfb1TpeI4R3Ok42fv0fDwbERTatMuUxfh88
	hGVT4S/dCrLHq4ccbyJk8X9gjGFjn4xdVixyw8KsCusKoD1JIO0psKcLQcuqJsJeYJYY=
X-Received: by 2002:a05:6000:2dc9:b0:3b8:d16a:a4a5 with SMTP id ffacd0b85a97d-3b8d9409fb3mr5819254f8f.0.1754295828513;
        Mon, 04 Aug 2025 01:23:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsTnQdJreGmbMOcEjZy4FMfjpdQmAFw4wu8ySGDhIwzGaZqjZzoEd4xNbnGtjcjJBwd/THkw==
X-Received: by 2002:a05:6000:2dc9:b0:3b8:d16a:a4a5 with SMTP id ffacd0b85a97d-3b8d9409fb3mr5819236f8f.0.1754295828014;
        Mon, 04 Aug 2025 01:23:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm14883227f8f.42.2025.08.04.01.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:23:47 -0700 (PDT)
Message-ID: <7c704985-81d9-4b17-957f-55dc4fd43942@redhat.com>
Date: Mon, 4 Aug 2025 10:23:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: remove boolean output parameters from
 folio_pte_batch_ext()
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Lance Yang <ioworker0@gmail.com>, Oscar Salvador <osalvador@suse.de>
References: <20250702104926.212243-1-david@redhat.com>
 <20250702104926.212243-5-david@redhat.com>
 <20250804082206.ri5roofvd32kyaya@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250804082206.ri5roofvd32kyaya@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 10:22, Wei Yang wrote:
> Nit in subject.
> 
> We have renamed the function to folio_pte_batch_flags().

Right.

> 
> Not sure it is too late.

Already upsteam.

-- 
Cheers,

David / dhildenb


