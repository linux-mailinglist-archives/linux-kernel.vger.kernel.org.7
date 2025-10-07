Return-Path: <linux-kernel+bounces-844043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F4BC0E26
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4773ABB3F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BAF2D3EDF;
	Tue,  7 Oct 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoqwC7Lb"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C163207
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830267; cv=none; b=Wh7dt+4z+SI6D43BH0zy+sC+DatL2Th7pfNZeFOiCNo8S5x+UaBma7RH9/VghSzNFgXSS+weoqQzG5C7Pg+1WERtQCA1rtPg2/zrnPFnFbtdNlEhef/dyyrP1vZ/KHrBqvqsqXWnwFTQI5xdjjQ93TpGShKzAOtNbpfxOh8nDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830267; c=relaxed/simple;
	bh=QkAeU/PO4HC4Lqzo+RxnXHP3xZ8bK0mz1iyKan2hWac=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:Date:References; b=a7Uc8UxJtFbu8Wb+MzuJk73zss9w0+ABLDJ+9pPmzcW2CauESFRIoSClyCz54ywSLFrw3m+y7jXOCiuNXAIt4JyDSfWKF1urbb1RWNTjDp9vgsryCYPdLBJgkbK/qm0b1fZMK6N9LvQpEEyAA832Fl2/8M/WX1fbbbwsIGXDIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoqwC7Lb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-780fc3b181aso3374075b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759830265; x=1760435065; darn=vger.kernel.org;
        h=references:date:in-reply-to:subject:cc:to:from:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3A/VwiK3ST2alzhsK6RwftUDnD/x55X00olSZzcEoRA=;
        b=DoqwC7LbQmSXKg9h3FzDPHteoZymRZ6ridW+4aeYkuLdog4mJbTS79bEjcwWGUi5zh
         iEfs0GXNyBF+ZbsG81e9EoZXsLDBZHPO6TNPeJIomjjVexfl63Kl5Kijn9j6PT6naHqu
         Umjl5aXfIvemzTHUHXh1A4AYvfjblbK1eskM7m1mP5FuypjJ8KEPcHgY9+BQr9LD8aTs
         LT/VRSzJLqfqywaYW9qkJoiL9fABMPoXkRKEFhrF0lc3JfGW+tQDE81wfKy9+UJfxaRu
         mviCI1LEq7AuMgPTJ7zKi5cqn72GftcHVjDz3JlJ4alLG7QvMbCvYe29A/ka2LttAZrI
         P00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830265; x=1760435065;
        h=references:date:in-reply-to:subject:cc:to:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3A/VwiK3ST2alzhsK6RwftUDnD/x55X00olSZzcEoRA=;
        b=MQX2nLneL+S8UChQi4GGaPFP9IsL0wC80YnvH3N7PThFjUmRTrVE+8supwoXmp+0z/
         N4MbDLNHBVSO65FyhLseLA56gzIANMi8o8OKXl81XrC6gmZhXdlN4rTu3ShxaxDUGNKr
         L2UNXqRf21f7x7t5ALthixxCWHKDSBdR9/uRWhHox+zeOQqeBO2MbR7jh8Doe55zBgBJ
         aSGKJ6ZFYHnZZi+yVK1GIZAQ8RR4tEd3eys7Typ3PJ3mDNl+atw1N6bD6n9NLjy+1fw+
         C/OKgOcWeAopBlt9b5Za2RFzGlmeKk2xihC5NDHnyzXS05ejuwidJZvzTgewBGORFGoH
         NJdg==
X-Gm-Message-State: AOJu0YwR4nVGXMY+OwGQEw9sFbEaUWu1zS7ZnyhRVWWASS/LAj70CNdJ
	MyR1cIM/DndRM5BNTGzSG+BUDTXr0crEuITDU1wLVW1e5vxFQg+xk0as
X-Gm-Gg: ASbGnctRf94h5UNl1+rX/rCpLmoaHQcBVGR1FALmYLxXBdYgEvNkxJJHBi2O0Fy9SuO
	NVqH/u57HyMACeooc6bgm31Dj90sM1JFL9jmA2BvAt9+fIZC+kHgMD27Bkl5F+YcS2RGO4gqYub
	CiSYfJFnhGVgaD9+309V2eU9A92RXs7H36NKsowvyr29t2aPYqG5yhDXJC0srF5eZpGQuAxv9G6
	Ud45ro3HoviLuRXTr+UJI5BKdPq+cPhXHewrSxHGSdouhGgrWX5olUNcRf2DZDvcqG5fZOlzpU1
	iZpiQ+sMKkTZF14rrrzej137X98Bx/zhQCEG84BXd8F+gUEk0Q8/tVdqeQMqia5UpSIHkgcXVPG
	CoWMAVBAJK4whmiY6NoGsQIaYWTjJAt5C5z/dTPw=
X-Google-Smtp-Source: AGHT+IHdDZ+BrmiDr3sqlM3LMsfxZrmam6lJT+2X4FkGsIUdH2hXqWPLsvn9F/0fIGhZvm1Em/I4JA==
X-Received: by 2002:a05:6a20:9187:b0:2fd:5bf0:706c with SMTP id adf61e73a8af0-32b62118956mr23209672637.58.1759830265355;
        Tue, 07 Oct 2025 02:44:25 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62e5549737sm10368308a12.7.2025.10.07.02.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:44:24 -0700 (PDT)
Message-ID: <68e4e0f8.050a0220.1e89ea.1c6f@mx.google.com>
X-Google-Original-Message-ID: <874isbgid9.fsf@ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 6/6] powerpc/64s: Do not re-activate batched TLB flush
In-Reply-To: <ef5d851b-0f67-410e-9479-0f6d344fa17b@arm.com>
Date: Tue, 07 Oct 2025 15:10:18 +0530
References: <cover.1749747752.git.agordeev@linux.ibm.com> <8625a1d97dcf4ae499b4bb341e27346f768a7248.1749747752.git.agordeev@linux.ibm.com> <aFGFl9Dvb9zdC3JS@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com> <ef5d851b-0f67-410e-9479-0f6d344fa17b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Kevin Brodsky <kevin.brodsky@arm.com> writes:

> On 17/06/2025 17:11, Alexander Gordeev wrote:
>> On Thu, Jun 12, 2025 at 07:36:13PM +0200, Alexander Gordeev wrote:
>>> Since commit b9ef323ea168 ("powerpc/64s: Disable preemption in hash
>>> lazy mmu mode") a task can not be preempted while in lazy MMU mode.
>>> Therefore, the batch re-activation code is never called, so remove it.
>>>
>>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>>> ---
>>>  arch/powerpc/include/asm/thread_info.h |  2 --
>>>  arch/powerpc/kernel/process.c          | 25 -------------------------
>>>  2 files changed, 27 deletions(-)
>> Hi All,
>>
>> (I trimmed non-ppc mailing lists/people).
>>
>> The whole series does not seem to make it, but this patch alone is still
>> applicable and makes sence, if I am not mistaken.
>
> Yes, I agree. I arrived at the same conclusion working on the next
> version of the nested lazy_mmu series [1].
> [1]
> https://lore.kernel.org/all/20250908073931.4159362-1-kevin.brodsky@arm.com/

Yes, we disable preemption while in lazy mmu mode for Hash, so I agree that
we won't call into __switch_to() in between preempt_disable()/_enable().
So it does look like that we don't need that code. 


> May I include this patch in v3?
>

That should be ok. 

> - Kevin

Thanks!

-ritesh


