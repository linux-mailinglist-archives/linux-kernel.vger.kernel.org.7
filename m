Return-Path: <linux-kernel+bounces-788596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A99B386F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B39F1B22E36
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FD22D781E;
	Wed, 27 Aug 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PwvR3L8w"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8C21ADA4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309833; cv=none; b=ueyb0PTclM5JCVLdOU+qjbQqW4lmEgTCwfmDWyWZx7voNXATGa+qHJKK8Fe487788rVIBxJs91O5vZXVz+j+NP0UfCknl8ASG0yntksFe828054AflPk4qJDanUmdZ8juHLlvez7GfCzjpUBN/+iNym/jKbR3WLcmumrZa54S6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309833; c=relaxed/simple;
	bh=Vid9vA4I/OLnSXYljtyxni15Vg/hZscfkYNwaTzQ6Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkRA6MCdl1j6ckHIObTDuKlX3DCZUxd/tbKaqL3NCFaTrs+H0HW8HIeQky48GO27BYZdKgEi49iA5a43GC8AA0iGAmZVlRK9KSAtCsBs4HEn0GNfVG0fLPQPMPJ8cKoQ8SLzobF5bHAMitM91oUlQSQcM/lfR4w4nOdSftc6JlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PwvR3L8w; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Hp7Pw5rW2LIImigfGbSSQv3tMGXBY+sCOLEQOf94HzM=; b=PwvR3L8w91KvKgcyR3n+NW5V3T
	x5v2e1V8MpZI7Q83ryeMAzx3ogva9FPcnNcORg277NEMCOn0CpSJWTYD3p7rNztdT5tUcKs8QjXJc
	dHgBbCO2ILd2ZbA+voETZM0BOfhPMhREAX1tnCJ5OBVpFRQYrJE7Z1j1/mViOYmQitijHDokecOP1
	/VF2KQ5hugcSzen97MMHBm58J82wFZRjHZfL1Bc3tObbLm05W+j8vPIgwI8JRgiy7wijqJ+krZBVK
	hFDp1uWfeGWjhVHPfmDoaOkKn7pytSg3XPeEPhQgw4nm2+P5vBXBPD0nXQAb858LvOu0pGWzaHk9J
	Uj7MN5rw==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1urIPs-002Vbl-L6; Wed, 27 Aug 2025 17:50:28 +0200
Message-ID: <90038e09-69fd-4a8c-b925-007dbac986f4@igalia.com>
Date: Wed, 27 Aug 2025 12:50:24 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] selftests/futex: fix futex_wait() for 32bit ARM
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Waiman Long <longman@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <20250827130011.677600-1-bigeasy@linutronix.de>
 <20250827130011.677600-6-bigeasy@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250827130011.677600-6-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 27/08/2025 10:00, Sebastian Andrzej Siewior escreveu:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> 
> On 32bit ARM systems gcc-12 will use 32bit timestamps while gcc-13 and
> later will use 64bit timestamps.  The problem is that SYS_futex will
> continue pointing at the 32bit system call.  This makes the futex_wait
> test fail like this:
> 
> waiter failed errno 110
> not ok 1 futex_wake private returned: 0 Success
> waiter failed errno 110
> not ok 2 futex_wake shared (page anon) returned: 0 Success
> waiter failed errno 110
> not ok 3 futex_wake shared (file backed) returned: 0 Success
> 
> Instead of compiling differently depending on the gcc version, use the
> -D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 options to ensure that we are
> building with 64bit timestamps.  Then use ifdefs to make SYS_futex point
> to the 64bit system call.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Link: https://lore.kernel.org/r/ebd4a415169f9a3153bbd3c1fe6244511c9d1cb3.1756217858.git.dan.carpenter@linaro.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: André Almeida <andrealmeid@igalia.com>


