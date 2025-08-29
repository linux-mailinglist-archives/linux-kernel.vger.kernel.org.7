Return-Path: <linux-kernel+bounces-791000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112EBB3B0FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D3768162D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D620E6F3;
	Fri, 29 Aug 2025 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fsF0Yxts"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986C1BC5C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756434160; cv=none; b=N+fxaYsHF/STxpx8rFsqMkCzJO46AJqM6nsX7PRFh/i57Zp3f8yxyi/VE0GguinFSK/O5URCCFllg6pojXieZTQbTGsknJ22XaxC4HX5ebrp3EakPRB14bfidqtTaZY2Z/ZsrnTSGdItSOWNjZ9V9m4xCCuddNku+dL6KDp8J2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756434160; c=relaxed/simple;
	bh=fgPtE+jqQ9ef1hT9QwYbOfHq6TvPrd86LcsnCgLdFpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJdjBc4c2FBAj4FhoMydBZH1Bm3j5kaZKa52uNx1+ReQ4NGODEevk0bZ36IKZvYVWrdIR7TdkR9cuPxnu1OJOITGCiy7IcpBaWI3BOHhksXW6kHLyzJ8Rn10VVMSg9lyFSAj5XZUiiFUAcUB/z9CCrCiob9syr2PqFBzzBtxsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fsF0Yxts; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CPc0x2erwygCRg0z7P4iYqFdizAEWJ5hoHbkhGJxbuU=; b=fsF0Yxts80meJbovwILwNFZJlz
	m4OUTSkwZzXC5A2n1Eml7zssrQacXzDg1jxiFPoA714mrbktA0pbufYQLSBmdp6Ux8M9vrBM9Q8O0
	3JqYZ5HAPr6hiaE93jz/iK6By1JiHkZtzlnk2LBXPeSmyhJdGJRPEuok8eV6RNshSm2ty1CMhsrWB
	ZjGkx7JYQYxeqCMMhbonPyAZ8B00oV4eoCLBmJ0y4djMRFY8SD4t2hcYOZnww2beLkYir5I0WEV02
	OFDBD88LSgoArMpLUI1xr0oW4Dolnwkr/xh+CNsKrZfmXxy0Zr36woQFD6vo2X7B6sTNNBKSeePbo
	zCdPYVWw==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uroki-003SZo-KC; Fri, 29 Aug 2025 04:22:08 +0200
Message-ID: <c61e7737-bfc7-4de8-962e-652aa3dbfd40@igalia.com>
Date: Thu, 28 Aug 2025 23:22:03 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of
 range subtest
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <llong@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20250827154420.1292208-1-andrealmeid@igalia.com>
 <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
 <61725722-f933-447c-a041-71b2d28e7f90@igalia.com>
 <20250828182037.qkdKVaTN@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250828182037.qkdKVaTN@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 28/08/2025 15:20, Sebastian Andrzej Siewior escreveu:
> On 2025-08-28 15:06:26 [-0300], André Almeida wrote:
>> Thanks for the feedback! I will send a v2 addressing this by next week.
> 
> Any objections for getting Waiman's fix in for now and your rework for
> next merge window?
> 

No objections merging Waiman fix first, but we are still in -rc3, so 
maybe there's time for the rework in this cycle?

