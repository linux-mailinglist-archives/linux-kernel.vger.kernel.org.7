Return-Path: <linux-kernel+bounces-788584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E775FB386D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB2A460769
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BDB2D24AB;
	Wed, 27 Aug 2025 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NDFlLtGy"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8BE1EDA1B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309237; cv=none; b=QYnmOxLZX8LQVlp4zB7GxFt4+GO+UGOqri+bfRfwrNdLp6cWxiSvrlnggW1+30OUa/bjzlHOm+9NKWvboibyN/BKmgfRfrkab4wGgZr6X/fZrqX9+zDEYAgVB1jG9SWZbvZuk0bB+oJFbLFX0Wncd4mhMfEZE+pNA61bHpCHe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309237; c=relaxed/simple;
	bh=4ZUOOOa6bSyoN+SDjWtCxC+SZ0tv4Ty7i2VZBuiLuSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYJMg0CcQv9l81xXY+n12ojKiwH4HEGfJKMze2Q2gpWYnVcpPMX3lQ/YQbUXxveQVdqPX0LcSVfsRK/vEktioszC0cWR8BandD7i+bjgZbwxJNpGbv1tosmLq8ls/AyvAwE/AHxwiaSRVVVXAtgf3Xgv3HErYWo5Ivi4e3dics8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NDFlLtGy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CwFUadbNaBzXughypiWyUqmE6ddcl/Ze25DOqcmyK8o=; b=NDFlLtGyixk+sBxBkr9anACTIT
	69I8hvCCxJd1HMPtcV3mZ0FSZOP1EjtFWvKHwMcmRGcPeHABzgKh/8kFk22j3rwaDDu676eYw7aOD
	uaH2rrV3UXjJYK7r6IbgIm4NCxF41mv48gf82dqld4qMCncGm8Q6NltDq42salnEQ89SEQisBdYOO
	099wZ3olQCNplo3yTy1aOMbc+kaEMPV44ZDroa7CsRqL3yhMhCAUFuEqve4eK/NUzocCH45v8eLSf
	KGuqljRhe/YF3kLF7izwjuQn0Wjg6qYlBoOPI9W4lMIC9UOhXWR4mbETvUgx2tCR5XmDUZi+mhXYa
	EsM5xJKA==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1urIGG-002VEV-3F; Wed, 27 Aug 2025 17:40:32 +0200
Message-ID: <1e3d6a6c-7c99-417b-bc5f-3ab509b1a2f6@igalia.com>
Date: Wed, 27 Aug 2025 12:40:26 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] selftests/futex: Fix some futex_numa_mpol subtests
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Waiman Long <longman@redhat.com>, kernel-dev@igalia.com
References: <20250827130011.677600-1-bigeasy@linutronix.de>
 <20250827130011.677600-3-bigeasy@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250827130011.677600-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Em 27/08/2025 10:00, Sebastian Andrzej Siewior escreveu:
> From: Waiman Long <longman@redhat.com>
> 
> The "Memory out of range" subtest of futex_numa_mpol assumes that memory
> access outside of the mmap'ed area is invalid. That may not be the case
> depending on the actual memory layout of the test application. When
> that subtest was run on an x86-64 system with latest upstream kernel,
> the test passed as an error was returned from futex_wake(). On another
> powerpc system, the same subtest failed because futex_wake() returned 0.
> 
>    Bail out! futex2_wake(64, 0x86) should fail, but didn't
> 
> Looking further into the passed subtest on x86-64, it was found that an
> -EINVAL was returned instead of -EFAULT. The -EINVAL error was returned
> because the node value test with FLAGS_NUMA set failed with a node value
> of 0x7f7f. IOW, the futex memory was accessible and futex_wake() failed
> because the supposed node number wasn't valid. If that memory location
> happens to have a very small value (e.g. 0), the test will pass and no
> error will be returned.
> 
> Since this subtest is non-deterministic, it is dropped unless we
> explicitly set a guard page beyond the mmap region.
> 
> The other problematic test is the "Memory too small" test. The
> futex_wake() function returns the -EINVAL error code because the given
> futex address isn't 8-byte aligned, not because only 4 of the 8 bytes
> are valid and the other 4 bytes are not. So proper name of this subtest
> is changed to "Mis-aligned futex" to reflect the reality.
> 

As we discussed  in the original patch thread[1], I have a proposal for 
this test case to be refactored instead of being removed. I will send a 
patch for this in a bit.

[1] 
https://lore.kernel.org/all/336a1a43-54ac-4f53-b3a8-5e46f6d45359@igalia.com/

