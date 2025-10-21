Return-Path: <linux-kernel+bounces-862138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC44BF482C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A8E18C55AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2D517B43F;
	Tue, 21 Oct 2025 03:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MObwW/DP"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761271448E0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017638; cv=none; b=MhsPaPoTfisANT7Ev+6/PdmOqQebFhswjrxBUst9BK/X9nf172FeRpZfOJV7GsFCzD1769CF5Tv/UTdMVRMiOThy8hk9m29Db4H1rtjXynyR7ff6khoFu5xo555F6LDy0q5yH60gBfE30AjAXvSferLxwtACHZiGMokj9xOF6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017638; c=relaxed/simple;
	bh=nbgGUYDkrS/56jD7cREAxV1EZS2S6GiTBcTdzZHVNdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaQAYxmMJbXhHoHkPg8Auk3D5n6RusxooRvCW/5z94TaW3VhHLgF9+5xtKuvW0CdjyXDjKikhQe2u+aeq+qbJ2b3bums4NWhx37jG+i1iKzXLMfB5X8MlJchijG3LRieEG2/zv8QJH9HT2eXmKzISQHnLdxLlmuq/9m7vL16ybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MObwW/DP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7800ff158d5so4558518b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761017637; x=1761622437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xAA3wXm7UQ3efK1YyKsSdURqRAiMhAkMHEwnZrP82qs=;
        b=MObwW/DPz3Mx2wsaThNbeuO7WC79tQoT78fP+G3LZlQal6QMtzuu74w2OHMIUG3j64
         u+kszHuT6sPYbo/cnHCG8ae8RWy80JogovJ9QdWZazfmOS2HRKXbkYRZclb01uomXwEe
         x9l7XFCfnIBvQMaCao6iCg3QECiiLCSlh8TNzQU0rr4fWLJ6OYR0gnd7p3iYD3bi36wH
         5d4lzxaok7leuD3pDBsPu+TX61tAG6O4Cfmt7MRpM/lFrgPsK71H4LvvcLpzNErafpvk
         AAkNsnSKm1HwzSOwW0maFMGb8ajMuHI/IpXvy1GRJIEiepOzYE5fyRKcZN+UuTyDVes4
         W4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017637; x=1761622437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAA3wXm7UQ3efK1YyKsSdURqRAiMhAkMHEwnZrP82qs=;
        b=w9mxTVUPiAJFy/uooC9MuAQpBEeCCYoepptSY8UJo8nHqAl1Io1flLmingCsoyCHPA
         XDu4KqXLyH3pIZVlrh0dZ1GPfG8gZZ6tpnFWZMHKIWJOeL+ohfiwwCVV5cSREI2Ffd5v
         y+OzPndEpuGQ2sRfUIfbM/a9H3HagpV55e39+NkxA2ZkDQvO0l5F3/9oca+WABPepxH+
         aG8eMJ/awe7c4IeTv+esYvFPuHw6x4veHb6JFdNQZpMh5QdKLAk8Ovu6X7m44Xnr22oi
         JwLpP6kqjiq0nT74adEluKvMn+u7nMfi4X3f5YMTx2KlwlKio/awzfTKvHFftK2a9xNn
         qPig==
X-Forwarded-Encrypted: i=1; AJvYcCUzNJ9M+yauZ1iAIxqRlaIkja6kCHR4c6qPo4CKGwH+gRdQOt3yTH71Rv44q64JmYfEsfLfCtcMtEVsT8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWENByJulIHcFm82Ef3Gqpc0Tk9s32mSLJXZfEYL0pn5FPcyBq
	8q8MVJ9H/iCtHAjXK/qeocx44IOPCq3oyfFuMt1rwFTU4OCEv8y7oECb
X-Gm-Gg: ASbGncvf30GGenizGfyvVl2fX6rXiAa4RJev982EQwnXdNb3OF1fMKJWwDf9OthSXJW
	GKh9ItBuXKJwlxlBGBtHrs8oiNbjpia3MPpMRcweX/9f1l4EqgYnLMEo1m8TRuGHZzkoCcvS8u5
	QHqc0jOgXLz7tAP2GhZOAS3VmN2xzpP4IscZnGVdrPBJfonmM0ZgeQvdFuRDjYSeXolTfAh287C
	CxFV7eILZrBiEn75QROhenEGg3hEbsYNUJHaZBDBuwXIj7ZnhqSnWPDvyZDm7fsGZIDy/N67rrL
	9XJHFHQBXpYaYgyrZ4XThQPy8vg4socMTZwwjZaoYa+8MWf+Yt6ZwA8t+4BYG7jcrCPGbRC3qzw
	oIOHBvIjGtCqDOPo7XvOfgsgoMP2smDh/nigJbMW8w4hRHkeYme6IH4VzDT2HwL1LlIh/0I3Pno
	6eeUcmJUKQOJz8YbGgJw==
X-Google-Smtp-Source: AGHT+IHaFDC1v0aDUzsL/TKgVez8i+34XppKVnxYdYV5DGHdTcMHliSfGRpy1KWJsrrID/P9T+elOQ==
X-Received: by 2002:aa7:888b:0:b0:792:fa4c:2437 with SMTP id d2e1a72fcca58-7a220d42505mr16077652b3a.26.1761017636657;
        Mon, 20 Oct 2025 20:33:56 -0700 (PDT)
Received: from [192.168.0.22] ([175.119.5.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f24e9sm9881557b3a.44.2025.10.20.20.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 20:33:56 -0700 (PDT)
Message-ID: <e26ec66d-36db-429f-befb-8baad14779d9@gmail.com>
Date: Tue, 21 Oct 2025 12:33:52 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: serialize writeback for inline-crypto inodes
Content-Language: ko
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 jeuk20.kim@samsung.com, d_hyun.kwon@samsung.com, gyusun.lee@samsung.com,
 hyenc.jeong@samsung.com, j-young.choi@samsung.com, jaemyung.lee@samsung.com,
 jieon.seol@samsung.com, keosung.park@samsung.com, wone.jung@samsung.com
References: <20251016051621.7425-1-jeuk20.kim@gmail.com>
 <5257fece-d947-4a33-8f66-4db5e8b73a28@kernel.org>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <5257fece-d947-4a33-8f66-4db5e8b73a28@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/16/2025 7:12 PM, Chao Yu wrote:
> On 10/16/2025 1:16 PM, Jeuk Kim wrote:
>> From: Jeuk Kim <jeuk20.kim@samsung.com>
>>
>> Inline encryption derives DUN from <inode, file offset>,
>> so bios from different inodes can't merge. With multi-threaded
>> buffered O_SYNC writes where each thread writes to its own file,
>> 4KiB-per-page LBA allocation interleaves across inodes and
>> causes bio split. Serialize writeback for fscrypt inline-crypto
>> inodes via __should_serialize_io() to keep foreground writeback
>> focused on one inode and avoid split.
>>
>> Test: fio --name=wb_osync --rw=write --bs=1M \
>>        --time_based=1 --runtime=60s --size=2G \
>>        --ioengine=psync --direct=0 --sync=1 \
>>        --numjobs=8 --thread=1 --nrfiles=1 \
>>        --filename_format='wb_osync.$jobnum'
>>
>> device: UFS
>>
>> Before -
>>    write throughput: 675MiB/s
>>    device I/O size distribution (by count, total 1027414):
>>      4 KiB:  923139 (89.9%)
>>      8 KiB:  84798 (8.3%)
>>      ≥512 KiB: 453 (0.0%)
>>
>> After -
>>    write throughput: 1760MiB/s
>>    device I/O size distribution (by count, total 231750):
>>      4 KiB:  16904 (7.3%)
>>      8 KiB:  72128 (31.1%)
>>      ≥512 KiB: 118900 (51.3%)
>>
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> ---
>>   fs/f2fs/data.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index ef38e62cda8f..ae6fb435d576 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -3217,6 +3217,8 @@ static inline bool __should_serialize_io(struct 
>> inode *inode,
>>         if (f2fs_need_compress_data(inode))
>>           return true;
>> +    if (fscrypt_inode_uses_inline_crypto(inode))
>> +        return true;
>>       if (wbc->sync_mode != WB_SYNC_ALL)
>>           return true;
>>       if (get_dirty_pages(inode) >= 
>> SM_I(F2FS_I_SB(inode))->min_seq_blocks)
>
> Jeuk,
>
> Can you please try tuning /sys/fs/f2fs/<dev>/min_seq_blocks to see 
> whether it
> can achive the goal?
>
> Thanks,
>
Hi Chao,

Thanks a lot for the suggestion.
I tried tuning `/sys/fs/f2fs/<dev>/min_seq_blocks` as you mentioned, and 
it also achieved similar performance improvement on my setup.

Your approach looks cleaner and better than the one I proposed.

 From what I see, even after reducing this value from the default (2MB) 
to 512 KB on my local system, there doesn’t seem to be any noticeable 
performance drop or other side effects.
Do you see any possible downsides with lowering this value that I might 
have missed?

Thanks again for your help.


