Return-Path: <linux-kernel+bounces-839899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A8BB2AED
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A1C7B2FED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52A2C08C5;
	Thu,  2 Oct 2025 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPdxIqOP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5033F6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389943; cv=none; b=CqnOEQL6Ka3JwMBcyKO85GLTnU0scysqef/EQOgV5y1hYFiiqhTKQNMhV0/b1y1PDHahe/anv8JkeuTvmguCY1Mvap2tHxy2GRKx5q78vqOYJ5vsicJt+qx7K8e7APegyw3XqtgVayBa00KD/u2/M7YgG5ENPK24A9G9en+6wgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389943; c=relaxed/simple;
	bh=yn4wOe2APZmdqAs9QVHhbchjVlr3C3zxzrFDUAsN4MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TpeDRxnohtFFQxrO6jX39pQNmBoDMAO5UmoqXuYHRPHgAvNOYYfR8lsX4mxAW4DqZQf9fMZn0jcxNJFLiHMRMWShTs3KnBa7bP8zvjavYfL3kaIgET2scW9LRcEz/IEp1cYi8v7SLlzvTY084+MJVt2e7S2VZKv5iCMWiO/8cs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPdxIqOP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759389940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c4xIEgg73HiwWMLp7GOfj//rAKG412fVdAUGiIOFvVo=;
	b=jPdxIqOPs8TmIPN9VnFin9k/CDk+q4rahjGsw6giTkmMpwq5L9/j9APcmNNbTqUlBuj4tO
	XDUehejBLiGwVIGsVzmxtIDQaDTzvVIJGLM57VxJu53WXDoFbb3jmp5PfSrDRezFQ9fc1a
	Ff3QemXZt0iyJoWKJzWKJX3pUq0xoP4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-d4BBTGRYPnS4Td_CP65mUw-1; Thu, 02 Oct 2025 03:25:39 -0400
X-MC-Unique: d4BBTGRYPnS4Td_CP65mUw-1
X-Mimecast-MFC-AGG-ID: d4BBTGRYPnS4Td_CP65mUw_1759389938
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so742779f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759389938; x=1759994738;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4xIEgg73HiwWMLp7GOfj//rAKG412fVdAUGiIOFvVo=;
        b=uj6SPf1wTbR//EU1Rwc2UaSabefdD6ZdozAy0kyrhojX2OHWHnR3MWWLGlWg4kU99q
         Y71Xd4alSCG7hQ10O2FNy3sZ0rCro4/q0Ljd0SlSgiZBD/8gMnAIi364qdMQqCNvqDKd
         xBoyly+RTZurZO183sSedq6GJFwO42z1z3Gku1i1NA3RVWmJf/EDDbjNYzPBfsk/IYNx
         r7tH8Pwqnmy+K2bS5ZLmot0Nn0hp4KFMAjRZqpSmnPRMJvZl1yHuD8N7iTkO1LQNPbMH
         b0B4XlEL7MMoJuKmNN2HlIXJ/8LIID5koVi+/tKTs53tLdpX/mQ9PA3TQZODAsU8py5z
         L9hA==
X-Forwarded-Encrypted: i=1; AJvYcCUloyic8buT8+Edf5d5+Wakli4mEg16GS8eioUbN6Nks0hp/C1z7KwbvwWwxeodnifgOpj77ryQbMuOhEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WkHxsUmt24n+gHJ5Z90SdoC3x8pD5kTBR530286jx8Qbrw6R
	0bJMgbK8HRfTHhGGv6Wl3JHJvSBZ9qzf5Y7SvaOswPF5IZfflBdx4CMQEbg4VOllukecKz0A5J1
	eXQvEbdEOp/m4iL57l1CoCgh2mfzBY6mWrk0XPmue1yHBkQDm+57iamvlWab7v1n5HA==
X-Gm-Gg: ASbGncsjrtRPR06Xi39Or2DdDfYjfrvomViB/fRH3VPDFCBeQoZplh7U608N/yyuUxS
	AnjiKMFjyPRyrC8fUeJ46DmHhVBHXm2SAo6JZPDY3nlo/40RbGFz98EJbdKZZajgQyaLPTp3gUv
	JGrMOK3exzPu2fkuV1SN9WH9Ltc0onA88SWsUqFLmeWQxF+LWirrIC9ckSznBUXWAAWI24Mr8dd
	vxfQh/q97GirKyNCy1m/19urVOgPglu1ak33z2m4OerB4dzKiDMz6GVMBMx6TmOYITmhylE9Bi9
	uc77crGKrRudGmOUIzZ0rqCnXge5rP1mAoDMj0UdOOOmz51UEJrDU5dmzIbLUT7TfFe7J4U+ECC
	bJISyo1YN
X-Received: by 2002:a05:6000:2010:b0:414:c2e8:a739 with SMTP id ffacd0b85a97d-4255d2bca04mr1474099f8f.31.1759389938007;
        Thu, 02 Oct 2025 00:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNuBjmSyWl0STGKz3jAGnCdlEY5ESG4JKemsoi3Wwx/R4rsYUPytBl7gz7zm2+UlaW/QHtHQ==
X-Received: by 2002:a05:6000:2010:b0:414:c2e8:a739 with SMTP id ffacd0b85a97d-4255d2bca04mr1474080f8f.31.1759389937505;
        Thu, 02 Oct 2025 00:25:37 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4ccesm2253063f8f.59.2025.10.02.00.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 00:25:36 -0700 (PDT)
Message-ID: <7eeb2a80-a73f-42b9-9f69-e2fe9fb824e5@redhat.com>
Date: Thu, 2 Oct 2025 09:25:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: jane.chu@oracle.com,
 syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, kernel@pankajraghav.com, linmiaohe@huawei.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, syzkaller-bugs@googlegroups.com, ziy@nvidia.com
References: <68dcb33a.a00a0220.102ee.0053.GAE@google.com>
 <2afee6bb-b2f0-4a86-ba8c-d33b0b477473@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2afee6bb-b2f0-4a86-ba8c-d33b0b477473@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.10.25 01:58, jane.chu@oracle.com wrote:
> Hi, Zi Yan,
> 
> On 9/30/2025 9:51 PM, syzbot wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>> lost connection to test machine
>>
>>
>>
>> Tested on:
>>
>> commit:         d8795075 mm/huge_memory: do not change split_huge_page..
>> git tree:       https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17ce96e2580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e6367ea2fdab6ed46056
>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> userspace arch: arm64
>>
>> Note: no patches were applied.
>>
> 
> My hunch is that
>      https://github.com/x-y-z/linux-dev.git
> fix_split_page_min_order-for-kernelci
> alone is not enough.  Perhaps on ARM64, the page cache pages of
> /dev/nullb0 in the test case are probably with min_order > 0, therefore
> THP split fails, as the console message show:
> [  200.378989][T18221] Memory failure: 0x124d30: recovery action for
> unsplit thp: Failed
> 
> With lots of poisoned THP pages stuck in the page cache, OOM could
> trigger too soon.
> 
> I think it's worth to try add the additional changes I suggested earlier -
> https://lore.kernel.org/lkml/7577871f-06be-492d-b6d7-8404d7a045e0@oracle.com/

I think that makes sense in this case. I earlier said that I don't think 
even splitting makes sense in this case, but as you say we can actually 
at least allow for reclaiming the remainder of the folio.

Even though we cannot proceed in handling the remaining large folio 
later on.

-- 
Cheers

David / dhildenb


