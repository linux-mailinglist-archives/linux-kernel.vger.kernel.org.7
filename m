Return-Path: <linux-kernel+bounces-787299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB1DB37437
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1F08E0BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA222F8BC5;
	Tue, 26 Aug 2025 21:07:47 +0000 (UTC)
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA702F6594
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756242466; cv=none; b=jOGkEq0JLXJIG9SihSSLkb56W83aPeYSom7lNFIDI5msykghSrb+pMTw9syjXwrVI0N6gERUutt++BH8z4FnI9MuehmsmdkrzVrJn1LmdDtScFrtXC9yBG1VOLiAOzjMBiwGxKQt3VMkFi/IT6dJdijh4QTCjnVr4C/gRsb9QHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756242466; c=relaxed/simple;
	bh=RQTsYZ1AgxLFnb7VlUK+eaCnvDmS7ejPqAXLXKB0OIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxCb+7RExjjuDfIXrHrZ8VyTGfvQUtQIqLCsQkbmNunMhaIR86zPMRtxLzD6bLhBl7VxLe/MzM4gK5KRjqvmZqqFZov6YpEcUQNay00nfri872fTr0rXF2odGG/swrDBSmJ78RDx4q1IuPk5LfqF47kaYgi2gNvl7nStMfh18jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=youngman.org.uk; spf=fail smtp.mailfrom=youngman.org.uk; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=youngman.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=youngman.org.uk
Received: from host86-131-189-159.range86-131.btcentralplus.com ([86.131.189.159] helo=[192.168.1.65])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <antmbox@youngman.org.uk>)
	id 1uqxZl-000000004ck-2zC9;
	Tue, 26 Aug 2025 18:35:17 +0100
Message-ID: <835fe512-4cff-4130-8b67-d30b91d95099@youngman.org.uk>
Date: Tue, 26 Aug 2025 18:35:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
To: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@infradead.org>
Cc: colyli@kernel.org, hare@suse.de, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 akpm@linux-foundation.org, neil@brown.name, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, John Garry <john.g.garry@oracle.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-5-yukuai1@huaweicloud.com>
 <aKxCJT6ul_WC94-x@infradead.org>
 <6c6b183a-bce7-b01c-8749-6e0b5a078384@huaweicloud.com>
 <aK1ocfvjLrIR_Xf2@infradead.org>
 <fe595b6a-8653-d1aa-0ae3-af559107ac5d@huaweicloud.com>
Content-Language: en-GB
From: anthony <antmbox@youngman.org.uk>
In-Reply-To: <fe595b6a-8653-d1aa-0ae3-af559107ac5d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/08/2025 10:14, Yu Kuai wrote:
>> Umm, that's actually a red flag.  If a device guarantees atomic behavior
>> it can't just fail it.  So I think REQ_ATOMIC should be disallowed
>> for md raid with bad block tracking.
>>
> 
> I agree that do not look good, however, John explained while adding this
> that user should retry and fallback without REQ_ATOMIC to make things
> work as usual.

Whether a device promises atomic write is orthogonal to whether that 
write succeeds - it could fail for a whole host of reasons, so why can't 
"this is too big to be atomic" just be another reason for failing?

Yes you want to know *why* the write failed, if you can't pass that 
back, then you have a problem, but if you can pass back the error "too 
big for atomic write" then the caller can sort it out.

That then allows the driver - if it knows the block size of the device - 
to manage atomic writes (in the sense that it can refuse writes that are 
too large), even if the device doesn't claim to support it. It can just 
force the caller to submit small enough blocks.

Cheers,
Wol

