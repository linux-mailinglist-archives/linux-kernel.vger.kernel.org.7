Return-Path: <linux-kernel+bounces-767284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72854B25252
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C199E884872
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D8C63CB;
	Wed, 13 Aug 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NyRNzUwC"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D02857CA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107114; cv=none; b=TeRNoA/uFx+PjJbOyDLw9uQmtElL7j1V7W3hzj0ubmy7QGTve+YG/NaSWdz6Z5xpnX8YO8bOI8hjfZqn74gg/gDN2CQ/J3EDbIjHf5lsDofo0N6vRmOzSjf0DoSTU2A19kkWE+aGiGA2GaVNXyPAuaGJnhtjo10FTxBv99NrgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107114; c=relaxed/simple;
	bh=bZGGYS+1+xVHuw85rtew4Vysp+bkddkyAiVB7KSR+D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E43pNPjRKOVVMt5kRImCi0gWixYORqJ/F3J3rsfdq4J2KPEd79Cxcedh43CN1Zyg2RxDFrBreP174Se1DhPjPLp6GoT6J/vxLpPI/ZcI/+x0lKo9/meiLeuP8SGGeM3nwjo7rvf2Uz0ep2efsrvKo3DyTJM9jVYXcqoRS9DKSNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NyRNzUwC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-244581c3b43so125575ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755107111; x=1755711911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHnnLvE38kbDjWGZ3ZhwCuAJ0QrSQ8uli0lPAvpqJY0=;
        b=NyRNzUwCyQykoamsCJr0sdVapVsT7+XhX+uZhHIUMRDbhxCCEmkAL5vnPr1PMSx/Nj
         0dSxeYCnAfl/WuaZbPOwDy8lASMGFwqYDvdWTC4xAjnlC/TlDLdvL0o7hHYgpfGJ+JmQ
         2WzChOhqucrGGU+7bNaKOi594oaKhQjn1wHD9VvUDVbVB5mevdWg3I72+GqD97pDRhGY
         VYwUEhDqJOQE2qs4X4pIFh/fPHcJi8iSYVXDTIJEexQxikU50XxUA8WzkOIhjc+38Edo
         u/4TgoZD9n6nPDrREowx2mf74cOXrOJJSxCjFTwJeq8qG7k0yvDZB0Zn5dr3E8D0VxKr
         giDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107111; x=1755711911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHnnLvE38kbDjWGZ3ZhwCuAJ0QrSQ8uli0lPAvpqJY0=;
        b=oERq64ZpMrL3VXMXemeJ3/exO4OO/uaW6as3cepq0NJFXZqhU06jVX8MM5cwXurozM
         Ah1tkDR6m3mYsw4JeAxq2kBDFUaWKeZxJLgzJ2uUEymxsTdUHFb3vSjns/ElUxG5eON/
         9AbEjEeB++SYaZ0mvOsm954MmFpK2LIqCKhboEhILVfbT0HTPNvCzttRzln7tjG/eV9i
         Bv6q7s/tsyPAl0IESuyY6UDYLEISGAfNTDlNejS8haxQg0e74473m4alOAb763MvheRh
         sqWrWW8/QBVxUttc8JjTv5Y07dLfcHi98mC5vVb3I5GuzfCWLNjM4xvOQhtgE78GiqHa
         37Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWX3JjQEyOU5p8GEjgVA1Q66Zc3s/Tmrwz1jR/gx43h4puAcizguMK/ieV6gETBSWt/BARATe/uEqgCN/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YznooLz2MSntLoXUQYUwnu3MBMQIFRTRv7IU/SS18pMnnIIzzkS
	SIF7WlvNO7lXLCqxfGxU65HDml6xCEuVsNjArDXDZH3HtDGHeq/JKVUQ8uvvjOdTm2TqTBkMWr0
	/jfho
X-Gm-Gg: ASbGncvIzCTrn5+jxOpUx8ZPSKSRVrFveCuK+Kn72KFQZTQQMne1FmsvOykEQJrgq4u
	rzVu/0fwM24ml6sZjW/pBTd/3Rl1AaiRu7w/pzlvDml9l8YsRho/UI0ljDturql+CLQpSzFuzpq
	lMJ3eiIEqjAE5YYKmfOEuDnSvloj716Y3TJamL7WOu3lRKC1eq92KI5PFSa1j2cNINeVS3I4FYm
	rsCFRb5kZ3sk42JktYm5LNwWW5iasHrhjEs4Fte5aLfS+nBj09zO5aqPlmcpdug68KmutyER9II
	qFpTLREyRpUkl6nT292GgcdTD5lNBqIZYoO3nxZci6iwlxp+ekxt37EpD38efpJkrP6BiMp+Y17
	ji27daTFYH614HplBoCnC
X-Google-Smtp-Source: AGHT+IEugx06OEbiFmM4FR2ifktkysn6f/JEoKaYZX4iJ705OWO3DfKKaVaRuKlZ2WkYiN9BmjVHjg==
X-Received: by 2002:a17:902:dac8:b0:240:3e72:efb3 with SMTP id d9443c01a7336-2430d2339a8mr63354205ad.43.1755107111127;
        Wed, 13 Aug 2025 10:45:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e585sm330352765ad.40.2025.08.13.10.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 10:45:10 -0700 (PDT)
Message-ID: <12342355-b3fb-4e78-ad5b-dcfff1366ccf@kernel.dk>
Date: Wed, 13 Aug 2025 11:45:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/11] rseq: Optimize exit to user space
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
References: <20250813155941.014821755@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250813155941.014821755@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 10:29 AM, Thomas Gleixner wrote:
> With the more wide spread usage of rseq in glibc, rseq is not longer a
> niche use case for special applications.
> 
> While working on a sane implementation of a rseq based time slice extension
> mechanism, I noticed several shortcomings of the current rseq code:
> 
>   1) task::rseq_event_mask is a pointless bitfield despite the fact that
>      the ABI flags it was meant to support have been deprecated and
>      functionally disabled three years ago.
> 
>   2) task::rseq_event_mask is accumulating bits unless there is a critical
>      section discovered in the user space rseq memory. This results in
>      pointless invocations of the rseq user space exit handler even if
>      there had nothing changed. As a matter of correctness these bits have
>      to be clear when exiting to user space and therefore pristine when
>      coming back into the kernel. Aside of correctness, this also avoids
>      pointless evaluation of the user space memory, which is a performance
>      benefit.
> 
>   3) The evaluation of critical sections does not differentiate between
>      syscall and interrupt/exception exits. The current implementation
>      silently fixes up critical sections which invoked a syscall unless
>      CONFIG_DEBUG_RSEQ is enabled.
> 
>      That's just wrong. If user space does that on a production kernel it
>      can keep the pieces. The kernel is not there to proliferate mindless
>      user space programming and letting everyone pay the performance
>      penalty.
> 
> This series addresses these issues and on top converts parts of the user
> space access over to the new masked access model, which lowers the overhead
> of Spectre-V1 mitigations significantly on architectures which support it
> (x86 as of today). This is especially noticable in the access to the
> rseq_cs field in struct rseq, which is the first quick check to figure out
> whether a critical section is installed or not.
> 
> It survives the kernels rseq selftests, but I did not any performance tests
> vs. rseq because I have no idea how to use the gazillion of undocumented
> command line parameters of the benchmark. I leave that to people who are so
> familiar with them, that they assume everyone else is too :)
> 
> The performance gain on regular workloads is clearly measurable and the
> consistent event flag state allows now to build the time slice extension
> mechanism on top. The first POC I implemented:
> 
>    https://lore.kernel.org/lkml/87o6smb3a0.ffs@tglx/
> 
> suffered badly from the stale eventmask bits and the cleaned up version
> brought a whopping 25+% performance gain.

Thanks for doing this work, it's been on my list to take a look at rseq
as it's quite the pig currently and enabled by default (with what I
assume is from a newer libc).

-- 
Jens Axboe


