Return-Path: <linux-kernel+bounces-804084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E897B469BD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110471CC79D5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3E929E0E5;
	Sat,  6 Sep 2025 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jW9eVsPN"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2CD21767A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757142125; cv=none; b=ocpQ5q7vGkxMUWN3j6tRqGiMnDg1rFaBueTv8RrchI6rmnAXP5RtSHsjTSEtIHTxsvY0cytE8/Tflqq3zfKIaLq8WvSvLqzxI8GUjfaUA1MCIQCfkHeE/HbV2O4YnOmfa3GaqDocDpFGeKG++poL++k96o7W5OP0ZBcuXCxqbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757142125; c=relaxed/simple;
	bh=IkAggZWAELPo1Mrr8DmQnssZVqsyMhjtkwmnYcMLy0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3xP3Jb+0h3YEcFUevXOBB36hlTitTw39U9g4H0uHjW6GC4PU/vPiACBgetw5DsFW/p0EjnT+vVNJ8VfavhnpgSGj72Ec6F7/jd9qWENh32T9ij9SBWgMRfRVT37gCEx86U7Yg7GRteQKWz4gV1xVc7IqB/e0DPi1kZUZshEqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=jW9eVsPN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:4992:1ddf:390d:bc6c] ([IPv6:2601:646:8081:9484:4992:1ddf:390d:bc6c])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 58671L773351979
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 6 Sep 2025 00:01:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 58671L773351979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025082201; t=1757142083;
	bh=zLKZnBm0/I26CNUFM74Ls2QRg9zohGExHih+2KmEdVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jW9eVsPNVwYPS2uMNtA3VSxK4QpSM6MOw2EAyjqnbjgmK4ZqaC5VpdJpK1IZsUrxq
	 b1jKPLmkPQlpVENtzQ0kMHRJfIUnIwlya8yq+08M27Y1hNGSB5GskCQ3FBsYypE/VJ
	 AzHjjQ82R+kb5hAZzQsBgR7v0nzKqwrqr+C4hr7YqVVuxP/0tJg4YeileIluG/K/i7
	 pNHm15/HLxdxmT8XafgTxdxDCSgwU/cnzu38N/CSuIdMrpJ75V8R+yHFJg/l7z69Bo
	 zZ+ganuqPrU4+Cw4HYRFqjb0AtLBVqc5TCPb75aIh+95XmlhfYMALCFfTnNJ+nFwBn
	 cvohUgMpixwSg==
Message-ID: <a2d0ce12-5dda-4cbe-8341-19d4b7a203e6@zytor.com>
Date: Sat, 6 Sep 2025 00:01:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip] x86: Remove code depending on
 __GCC_ASM_FLAG_OUTPUTS__
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20250828072958.3922703-1-ubizjak@gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250828072958.3922703-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-28 00:29, Uros Bizjak wrote:
> The minimum supported GCC version is 8.1, which supports flag
> output operands and always defines __GCC_ASM_FLAG_OUTPUTS__ macro.
> 
> Remove code depending on __GCC_ASM_FLAG_OUTPUTS__
> and use the "=@ccCOND" flag output operand directly.
>

Good riddance :)

	-hpa


