Return-Path: <linux-kernel+bounces-802137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD94CB44DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B6E170BC8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B932BE7D6;
	Fri,  5 Sep 2025 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6M7CQmm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856582BE7D0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054067; cv=none; b=DCCo60DitctpGfgGKn3TfiVnmSNElb378D7SDTdxW1NOsq2v4UoaZBjaqNN8azhNvnIyLi19oG2J5j7IC6HEDjsh2fitKd8Pz4V5UqV+Akq9J0zwANPQSviuI9PfYRtd97r9z0ONBsqmKT791Wux1x1W+eic48rjVJyu8r9nsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054067; c=relaxed/simple;
	bh=/pkBJAPA9/t9eOS2SWV0ISEoY01/jcregn/NzzerKPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqgoR4mIPGrhA+7bw2J9zpyJaIzC9EBSD/hWAx6wQR/3j7fDw24cLM3WaWCi4rwrMB6I0KCsiBLn/9XtzhVwipBMUBKd6Jr5aqrxWbPXklzeJ0sETyv23aS59khXrCuSAeuqOXGaLi9JKendg4DLxTSV2MkZcTRx5ltMOPlEmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6M7CQmm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757054064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ja8XMQFu70eLJuzidmavBefKwnvw1yGaVpU8/fLVXhs=;
	b=b6M7CQmmOJD0pp3yW85sG/df/x0iU1MNEnK91PoVNMtxj//QF5kKAiU3cQ2FUmpNmn3wcC
	a8Wx8tvMY60lP6/uaAxv5XxGFW6PD6/oGqzTkdBj1Xvp0FFwEVkDpQ6cr9M/tYddmp5S9c
	ZSYfL+0GehCkWJ/e73ynW9NgYxSEVO8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-WLfu9ElPM7eCUpgxXL_vkg-1; Fri, 05 Sep 2025 02:34:22 -0400
X-MC-Unique: WLfu9ElPM7eCUpgxXL_vkg-1
X-Mimecast-MFC-AGG-ID: WLfu9ElPM7eCUpgxXL_vkg_1757054062
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e2055ce8b7so618808f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757054061; x=1757658861;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ja8XMQFu70eLJuzidmavBefKwnvw1yGaVpU8/fLVXhs=;
        b=F+LOlVDNmnozpZhnKujc0Pne9HWTLUMecUBBTq406oT3oL0Q7ShX893DRoOJEoNqcc
         2MqlW/qWU91k8RaB0YSrRPdgNa3PESAmUBqKRt3NWHwkNSOCaNqOBlfAxl8KV+nL0wBO
         Ag3Y6W+twb0/wHZh8/5Ed48QeZQPMzowQzbn+8EG31FWZ+FO+f12zTmoHnt928PizWSS
         8ZJzDqLtxe91WnYo+bSqT5Vkpko24uGP8YvFWFCHWl0zw6IA9hiGeJwU8Nz020WsUpl4
         uS6s0Whne2w5PxjUVKeTH0kFqg/iqh2vPWIYYBuyCNvH6oZr1AUHT4BJ2DdfFXEtChBi
         Bvig==
X-Forwarded-Encrypted: i=1; AJvYcCXUPmoFTQei18O7hGcP0fTR5hjkhAXN4A3rBxXihjZuN7XVlfT+++l1Motl5PTpW62oDgT1t/F5jp08njA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEDp+gwaI1UFbH19sTOu80atzVrIMvuf2c2wY9rQeSXF9zOYd
	21jYnB03EdxZey+Vu8K+S5N8pzLA9HId+uJsyFgk/nTajve14iBKdUfKDvjozpBebVGJz8kS5O1
	6ml8Pw45HKv2YTBoJgdIk7KSeP+VUxzktgocuWiaqxaZYozy9meCIwOamobPTbd23yA==
X-Gm-Gg: ASbGncsmQQcyMSuAkV/ff4Plq0ek8RtJ8ea3+YGgZlAnMGRzUmtCTp/D7/p0uG1QLbg
	o0JnC4bWKs7UrQPnkuqouSldSiDr2zfkEWZNwyVbNe7VlOG/hXRgBWe5SASdbmln81scRIi8Duu
	TGURC/IhLVF16sMXSH5XUo44dqMT8yJ1IQiSN17fbjes2sAVWJbmSGMevvpa1V079WF2h+edYH3
	jA06TBEhVI27Rcx80P1S5bCNoqc3IwvUyHNvdgyoVezhh7/aAqv0cbT30TQWQvHP26R49QgzBc2
	apvwlFO6W7hmhreGRB8+lDQxouMpbhhAYPrTQYhga26Wzv7MvyQWfv5Rh8QNLZR1BKpmQR3fDAj
	5vDpfkEw3zoFRzhnZP0TwS+nebk4WtFZ+GmonLswvnXQXPqP7mQFBLhgB
X-Received: by 2002:a05:6000:144e:b0:3ce:ae6b:51d9 with SMTP id ffacd0b85a97d-3d1dcf57b4fmr18136915f8f.26.1757054061491;
        Thu, 04 Sep 2025 23:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpkofgj9vgsaGYP8fO6aS73WQxbMpWzrz3nR6K2OhlRqJfgP44dDLkPbBbEs50YZ08Q+dhzw==
X-Received: by 2002:a05:6000:144e:b0:3ce:ae6b:51d9 with SMTP id ffacd0b85a97d-3d1dcf57b4fmr18136891f8f.26.1757054061049;
        Thu, 04 Sep 2025 23:34:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d520eada16sm21407566f8f.41.2025.09.04.23.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 23:34:20 -0700 (PDT)
Message-ID: <1ebd15f2-b709-483b-ac52-2aa0e963454f@redhat.com>
Date: Fri, 5 Sep 2025 08:34:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: null-ptr-deref Read in
 io_sqe_buffer_register
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+1ab243d3eebb2aabf4a4@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68b9b200.a00a0220.eb3d.0006.GAE@google.com>
 <54a9fea7-053f-48c9-b14f-b5b80baa767c@kernel.dk>
 <20250904202535.fff5bea806408171d349a7f1@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250904202535.fff5bea806408171d349a7f1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 05:25, Andrew Morton wrote:
> On Thu, 4 Sep 2025 17:20:41 -0600 Jens Axboe <axboe@kernel.dk> wrote:
> 
>>> ==================================================================
>>
>> This is from the mm-unstable changes in linux-next, adding David as I
>> ran a quick bisect and it said:
>>
>> da6b34293ff8dbb78f8b9278c9a492925bbf1f87 is the first bad commit
>> commit da6b34293ff8dbb78f8b9278c9a492925bbf1f87
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Mon Sep 1 17:03:40 2025 +0200
>>
>>      mm/gup: remove record_subpages()
>>      
>>      We can just cleanup the code by calculating the #refs earlier, so we can
>>      just inline what remains of record_subpages().
>>      
>>      Calculate the number of references/pages ahead of times, and record them
>>      only once all our tests passed.
>>      
>>      Link: https://lkml.kernel.org/r/20250901150359.867252-20-david@redhat.com
>>      Signed-off-by: David Hildenbrand <david@redhat.com>
>>      Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>
>> I won't personally have time to look into this until after the weekend,
>> but as it's linux-next specific, not a huge deal right now.
>>
>> Note that there's also a similar report, which is the same thing:
>>
>> https://lore.kernel.org/all/68b9d130.a00a0220.eb3d.0008.GAE@google.com/
>>
>> which I marked as dupe of this one.
> 
> Thanks.  Seems i can remove that patch without causing merge or build
> damage, so I'll do that.

Thanks, I shall go and figure out what I messed up there. I'll then 
reply to the v2 of the patch with a fixup.

-- 
Cheers

David / dhildenb


