Return-Path: <linux-kernel+bounces-893428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0152C475EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2772534A113
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A6E314B75;
	Mon, 10 Nov 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKs4Dt3l"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C622FE06C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786500; cv=none; b=KXJhtgzyzfqp+XKX0n3u7KxvWqzQwj5loXboPhkmzsK6Rxl7zL4K9MWIwdnYUqES52OFNKbUIml4Ky9WQF6KMTOn3S/N8o2+Szzc8UBCRMSkTcChDIg95QFg3dxGEr+4IGgIrYcuPhLROpQhhGrjKc+g+/SU+AL5GbuWGhn1ACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786500; c=relaxed/simple;
	bh=rUU+f9PcX0qzROWhXtT3SwA2QFBOOJW99Rko/d/EA8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXGNIZ2rSU4t/a/w9UoygjouSi+Bx8U9m6RkO7jkvTMJWcCTRlZbfNo/DA3Xz43jYgzX2aS0TRuoRxDOLq1WXoi9gS7WNQTaHNDqHzSi35k8Q4iS/P89iAsi13F6d67nKtG8slEj6veuA0N1NoiUSKCfUdFA9ABDnbfDWhAwUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKs4Dt3l; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so865655f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786497; x=1763391297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtT4O7BewVOdeU11dvM5Ug5fQnG1uIMIXCN1qCElv4g=;
        b=gKs4Dt3lupO4jFXFyhqlH4TmOdSJRTexG4WgQSCYNgQUXYOCp5R+F3aLvLmSSQzeWv
         rG1CIyu9DbkThk6M2/8vHizTrAdi+2kYIDeW7KXIWlALbDzWJqCIe58L1Gx4tc8NnNHy
         Ntee/Zcj3OTeVeUaX1PEzdP6KfO2HSdfRgwtP2sebACk4t7XW/CviSebkZJ6+io5Oadv
         8dnBhi9Fj/jLO99xKv7dFq5HRm2n3fTny8uDUCJ3ivOdCqhpK15PO9PQHZywOy4adQBX
         sAHhuMoHMM6ghE/HWKxOKfs21ZbaqbvzjGr85ACu4RHftRMKeN2k+fyPRM+KdHsoBO0Y
         AGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786497; x=1763391297;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtT4O7BewVOdeU11dvM5Ug5fQnG1uIMIXCN1qCElv4g=;
        b=JWU2yR2RfqGEvfr7HkxjAtPX5D61LcyrGQCBZqOom/PwVLsyS5IFtEgFV1mmu1Bc1S
         LTH+sG1wEo5v+8BvKkcfvrXboWqF6h7flGOduKymvZfgQs1QU0wmo3ggnkSRKuiHFq9K
         SpwZ4spmGMuL1Yg15E9kdm2mqBaO+/nNYnmZ/zHm9gGv1gJKWPL2nVNkB5huvthnEHsv
         3cp0TBTqUSNylVI4xWl3eHW69fQfcOErBeR5dampsGa1NnqYyT+7pQ2GrZOT6Uh4U7+N
         HbpcZbQGE+d/stBEcAMT9MZbvYrnXK7UIiBad9BwHdtkzdtrKeDHBOj48rjYH4osB4O1
         t3pw==
X-Forwarded-Encrypted: i=1; AJvYcCWhaoDoyUk5yKWiu+FHvsazNXoGFlZsYgwixHgnFQmR5d94cyLUZYJxAu80WyCwmeXWnwSdkG5/JhAhrm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRdTW/W0CV4k6zzIrvWJPEJPea93NgVkBnkW5DVionv2RdG/k
	VOfB4pjiZdHqmbRqYXNBWH7fOp0JRfj+NKXp74dtUGQAGg2gBpIneuQ6
X-Gm-Gg: ASbGncveftfho2JCPXyDIWehdSiYdhyxq1uyaPpDyMaewfeycVC2eSFq0GkL0dO73KQ
	lTr0/8XDGUSuwzQ4G3TxsvtKQnA0hMwa30wgq/gUnj0M4UwDrye8iDO8ZvdPzhwRNtF6oFwJ9ct
	Wn5l1JOIdSSbFnfpQeO7oSKfZPJ+x6fFpSiuwOhlCOPkHZFfiyTHwuNHCXjjZRAN33xUZl/FegE
	GscY9Vw+FiITQfCzcIyOc92kBYqnNH7pt1ehT54kW/dPRy/CEfsvsCVTIONfT2kUJgwFMn9Sgd3
	qulc51yXk8Gc6tH+td8k9/OMoUWSD0NJBi7s4FLv+st1BFKiqmy+8BS3FIV52CE1tpNlYWvPHhq
	Y1wb8lfNKvizYP5JyLk+UQjwzFnsHdfzeeWKthjMy90/iyF6r3DC55Igj/luPDintKbT5cCnMXO
	PV5RsdeDRKawR2QdSLL0nSH7gBajab4Tnfu70WlP9FgY1P+odakUTHcotM7my8EIX8U2Eng2YCS
	ecVxrbqYSGEFhxUrJUBLXZq1KdLhsZBmc2JTSLWanT6EWewew==
X-Google-Smtp-Source: AGHT+IFgYtF0Zf+P6CHYXSeBIt6XkOznTNcFaXqJDPZp+x8TaTAwDPOPyk8sB9F+rWpsk9Zy+d+pvA==
X-Received: by 2002:a05:6000:2302:b0:429:c4bb:fbc4 with SMTP id ffacd0b85a97d-42b2dc24800mr7139287f8f.25.1762786497116;
        Mon, 10 Nov 2025 06:54:57 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm12777750f8f.16.2025.11.10.06.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:54:56 -0800 (PST)
Message-ID: <69884a4d-60cb-4a66-a225-38d3a17712c6@gmail.com>
Date: Mon, 10 Nov 2025 15:54:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Shivank Garg <shivankg@amd.com>, Andrew Morton
 <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251110113254.77822-1-shivankg@amd.com>
 <aRHs3pA2kOr_uD3k@casper.infradead.org>
 <9b622374-778a-4459-aca9-4eb406a58516@gmail.com>
 <aRHwv3XzI4XHcLPP@casper.infradead.org>
 <2e6153c9-1729-463a-86b5-0973b3f56ea6@lucifer.local>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <2e6153c9-1729-463a-86b5-0973b3f56ea6@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.11.25 15:05, Lorenzo Stoakes wrote:
> On Mon, Nov 10, 2025 at 02:03:43PM +0000, Matthew Wilcox wrote:
>> On Mon, Nov 10, 2025 at 03:00:32PM +0100, David Hildenbrand (Red Hat) wrote:
>>> On 10.11.25 14:47, Matthew Wilcox wrote:
>>>> On Mon, Nov 10, 2025 at 11:32:53AM +0000, Shivank Garg wrote:
>>>>> When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
>>>>> text sections), the pages may still be dirty from recent writes. The
>>>>
>>>> That explanation derails my brain entirely.  Text isn't writable!  How
>>>> can the pages be dirty and file-backed text?
>>>
>>> Files are writable :)
>>
>> Well, if you're root ...
>>
>> -rwxr-xr-x 1 root root 158632 Jun  4 11:14 /bin/ls
>>
> 
> gcc foo.c -o foo && ./foo
> 
> Is more the issue I think

Yeah, that's my understanding as well. I guess stuff like 
package/container updates might similarly trigger it.

