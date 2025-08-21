Return-Path: <linux-kernel+bounces-778769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54036B2EAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047601C2806E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A92441B8;
	Thu, 21 Aug 2025 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TBCnFIAu"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFF24167A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740240; cv=none; b=jZMF/rBe0PnCP+umDZtaH71O1lK6pieyFRCH7u3DInZvnpniJ4oXxerzwos9/u8VUlteHNpgkIo2DdfvaxgANA4bC6s66RYB738UVrsMresSMZAz2DMewkWwkhUpRHUF5nPGfPrkHv8QpBRasyxE3nCq496q1F6MZ0ZmhDmfag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740240; c=relaxed/simple;
	bh=cFg6Ft4wWu0jnW8UIk/usiAkGGyiMduu/honmbJjoTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRgDnwj3HWp97JhS/JW349OymbSyPLIF+hCMnsdHSeOPPaYt1+/O0pVGEN2gdTK7cDzgASCBzGZd7F1NJ+5RzX70gXs80HLk6TpDjwmc4RyC7wkr2ciHE4ynp1dkeKGZkiWHN6PDtKwYx7D3a5A6z4E3x6fvDj1ENQTjxYOwb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TBCnFIAu; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <65263090-79a9-4d18-a016-c8f08dcfff8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755740235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75+8cTaUWk1uklVVN6F+RONMTl3pG47VWO/D9dtV4/M=;
	b=TBCnFIAu1PLgJoeXwQrNHUVpHUlTNud0dY3FaEv5oSA0S1cjvkpMChiG7plAF289VMem4C
	N9dhNnRIE8T0H1rfSDTQ98t/Hs5CgLNF8dJ//tFT2JlFb8FnKndFEPwgJNkI/SJVzgEcEH
	1qwU/IW9XXb3ucGKI3i+KACQZxfDCKE=
Date: Thu, 21 Aug 2025 09:36:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/zswap: reduce the size of the compression buffer to a
 single page
To: Nhat Pham <nphamcs@gmail.com>, SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosry.ahmed@linux.dev,
 herbert@gondor.apana.org.au, linux-mm@kvack.org, kernel-team@meta.com,
 linux-kernel@vger.kernel.org
References: <20250820181547.3794167-1-nphamcs@gmail.com>
 <20250820224659.88528-1-sj@kernel.org>
 <CAKEwX=NLvQyZTqv15kACZP2wErO9hyv9W+0j-BWrgOh5ZX1LJA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAKEwX=NLvQyZTqv15kACZP2wErO9hyv9W+0j-BWrgOh5ZX1LJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/8/21 06:56, Nhat Pham wrote:
> On Wed, Aug 20, 2025 at 3:47 PM SeongJae Park <sj@kernel.org> wrote:
>>
>> On Wed, 20 Aug 2025 11:15:47 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
>>
>>> Reduce the compression buffer size from 2 * PAGE_SIZE to only one page,
>>> as the compression output (in the success case) should not exceed the
>>> length of the input.
>>>
>>> In the past, Chengming tried to reduce the compression buffer size, but
> 
> Yeah, this should include the reference below. My bad. So it should be:
> 
> In the past, Chengming tried to reduce the compression buffer size
> (see [1]), but
> 
> Andrew, would it be OK if you fix it for me when you put this patch in
> your tree :) Or I can also send a new version if that's better. Thank
> you!
> 
>>> ran into issues with the LZO algorithm (see [2]). Herbert Xu reported
>>> that the issue has been fixed (see [3]). Now we should have the
>>> guarantee that compressors' output should not exceed one page in the
>>> success case, and the algorithm will just report failure otherwise.

Great!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thank you!

>>>
>>> With this patch, we save one page per cpu (per compression algorithm).
>>>
>>> [1]: https://lore.kernel.org/linux-mm/20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com/
>>
>> This is not mentioned anywhere.  Probably you added this as a reference for the
>> past work from Chengming?
> 
> Thanks for taking a look, SJ!
> 
>>
>>> [2]: https://lore.kernel.org/lkml/0000000000000b05cd060d6b5511@google.com/
>>> [3]: https://lore.kernel.org/linux-mm/aKUmyl5gUFCdXGn-@gondor.apana.org.au/
>>>
>>> Co-developed-by: Chengming Zhou <chengming.zhou@linux.dev>
>>> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
>>> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>>
>> Acked-by: SeongJae Park <sj@kernel.org>

