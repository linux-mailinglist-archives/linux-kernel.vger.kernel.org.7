Return-Path: <linux-kernel+bounces-771170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DADEB283C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F93AC3064
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E3B308F31;
	Fri, 15 Aug 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dKR7/JJa"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9B1EE7DC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274922; cv=none; b=sYeL6Tr+DQxk+qj2tYosIxxiq/momo77ckwa+Z8Cpdum5/SKvCBiwYOd21oEs9IzOM6Pl7NBFA2Zq5wWARY1zioYQyxxt6l8lHjzWcslnHpiEtXcEjrBsONYsULbGQ0559Rj3fCHK0W2KSNwsJFBTMVMrHUBU9djcXdjfDj9IWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274922; c=relaxed/simple;
	bh=ju6gO3rue10ODGUO07MQ/geG/p66S0K5di6Vl4/q9j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdzdXUE4qMpuqLgfOJ0NAok93KphlP3ZrBYVkT7+v82OgwwNqGvOAUWRW1/r1b+/ZPluYLC1vUFqieE2U1Nrej9SnK77fqGEY7k31/jVHn88qA3kf2+zD1j9YxBlURo0g5RQMUizcc0dxuAwV0NwdijJXNkQc6svqQg34s9s4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=dKR7/JJa; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:50f9:ca46:26fb:a765] ([IPv6:2601:646:8081:9484:50f9:ca46:26fb:a765])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57FGLSl91993676
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 15 Aug 2025 09:21:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57FGLSl91993676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755274889;
	bh=qAg9sd44Sk4+s2LmoJ/4KHPXGdrY/miO3OfjoiADiqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dKR7/JJadlxeHWfyod0YaeJNGLIj5mznim6crEpDe+6Xz/08OmrgKwNsSi9/esizz
	 7UlQ3gd6Tk13pyEg3Hc1VbyAlQbZD8/aGV59DY7tKNblrgoPtO7ZcI2zkXMqYuheKb
	 aquJO23IKbMYNeWslW0S7Gx0B4ag7esctUhvwtCjtXFajfVPSHLmNUs/m+foGKo7GQ
	 y0cWVzIhtS89G0TY6WFUy9JMwza74A9U5YGYhtYeuMJOtxaMZv6nFp+Syo0JysGsN/
	 7N+R1BwCJzJCdvYURJikZPND09esKRAvUHBdIc9SUVfCexdTxxJYKByJQPtY5wzbj2
	 Vgz1Yz6jcEnNQ==
Message-ID: <20dd9552-65fd-4887-a6f9-667a8d7eed34@zytor.com>
Date: Fri, 15 Aug 2025 09:21:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Fix 64bit identifier in fred_ss
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20250814190436.2555438-1-andrew.cooper3@citrix.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250814190436.2555438-1-andrew.cooper3@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-14 12:04, Andrew Cooper wrote:
> FRED can only be enabled in Long Mode.  This is the 64bit mode (as opposed to
> compatibility mode) identifier, rather than being something hard-wired at 1.
> 
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>

[...]


> IIRC, this was wrong in an older version of the FRED spec.  I made the same
> mistake in Xen, and I didn't copy Linux's structure.
> 
> I don't thinks this warrants backporting, but the fixes tag is:
> 
> Fixes: 3c77bf02d0c0 ("x86/ptrace: Add FRED additional information to the pt_regs structure")

Please make it explicit that this patch is "no functional change", i.e.
it is naming-only patch.

Other than that:

Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>


