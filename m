Return-Path: <linux-kernel+bounces-836129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F95BA8D18
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016833BEB1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15192FABE0;
	Mon, 29 Sep 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eFxL7fWA"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F952E06E6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140537; cv=none; b=AqrSxbTDGrPTP0QTzm7eeP3C32kZ+hQSeaxlMDpFql3qWtqbbpo8QyHzr8EZ+tPqSX2Tc2/TobRy6VdVEXHK0rx5T6j1fmaGybbN8MnfIOOLt2AdV7aTfXfvZDpz+ikTmTU0YSNG3FGnpP72dp/6G2ZFgqdMe38TdOjog8pMmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140537; c=relaxed/simple;
	bh=z918BhWxJ6cCHE6cp97StxAxb94qPJ2tfC260ekQtCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUMfBjNigyTqx+HkN44gcxg74juccdyoyJytTZkd+1blGDZT2y6vuusS3E1owtW3vJbwz9S6rayEpqNiVmMK8rK93OusxKNaeY6tQVjMY6hCjMTCYj2NjEpKEZg1pDuRyrWqj4dq8tG6xSx/5BP08CWCKnKj1KxsY549C3stfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eFxL7fWA; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8476e9be-3f80-4d7a-9a38-f910661e61c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759140533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYJ7vI/1TYz5Uw1E53H+CnlgjhFFABb3WbBnKQy9Lbw=;
	b=eFxL7fWAcyhj2PgQZOqIzGLta1t80dO6/q5Usg4R53hka8Q4injGQYOvcxpCUZj9rp8blS
	E967y+86idHhTfMXLuWLUnNMZYiXgc4bM+IG+gg6ASsiWAmR1KNNs0laQZN1mpTUbpn97+
	TDVohSELPVVQX25d4FNYJLy2szcZXIo=
Date: Mon, 29 Sep 2025 18:08:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/ksm: fix spurious soft-dirty bit on zero-filled
 page merging
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: xu.xin16@zte.com.cn, chengming.zhou@linux.dev, ran.xiaokai@zte.com.cn,
 yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com, akpm@linux-foundation.org
References: <20250928045207.78546-1-lance.yang@linux.dev>
 <e74ae9da-9dfb-4673-ae9f-c0b27b796cf0@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <e74ae9da-9dfb-4673-ae9f-c0b27b796cf0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/29 16:25, David Hildenbrand wrote:
> On 28.09.25 06:52, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When KSM merges a zero-filled page with the shared zeropage, it uses
>> pte_mkdirty() to mark the new PTE for internal accounting. However,
>> pte_mkdirty() unconditionally sets both the hardware dirty bit and the
>> soft-dirty bit.
>>
> 
> Right, that's one think we should clean up at one point.

Got it. I’ll take a look when I get a chance ;)

> 
>> This behavior causes false positives in userspace tools like CRIU that
>> rely on the soft-dirty mechanism for tracking memory changes.
> 
> IIRC, false positives are not a problem. We get them all of the time 
> when merging VMAs etc.

Right, Indeed.

> So I am not sure if this here is really worth fixing. Soft-dirty is not, 
> and never will be false-positive free.

Makes sense to me. It doesn’t seem worth the trouble to fix. Let’s go 
ahead and drop it.

Thanks,
Lance


