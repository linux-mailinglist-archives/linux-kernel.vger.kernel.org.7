Return-Path: <linux-kernel+bounces-769876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC3B274B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159F91890386
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ACA145B3F;
	Fri, 15 Aug 2025 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qSHEoZrX"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23798821
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221298; cv=none; b=dMaR0d2Gcs2xTMf1nAyR8hI0caXmWhjgp0sBXrN7jrza5SgAet3VpaQIKsz5U7wyErp0RhdKy7Ymu3pRNLPfRX1jYgbpHXk7kMfIPGzKwZIZ++Fec/EDaZMrT5hoEYqO7HnFDI6QHdcRSVWd08tbfMZ2ZL3pEMKX8U/TEkrZ/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221298; c=relaxed/simple;
	bh=35DRTD2QmNiEIHrMkJdGrRAX4FpARNkUNcW4+F9dqbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asdl+yIh9D40cPww93f5sVdqiAT/7FeKQO56JCsOe4/b2tB12iaKXaxpf/a/YnwZrMA7tLWHzqnLxkTJlvkOa3glQUt6JAQJrOscIuPMWc/DBOmMhK7J7SEkHup4mmPanN26zfVk9oL4P/+GfUMZEjIBuSyLTVaaYvN+UlEL8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=qSHEoZrX; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:50f9:ca46:26fb:a765] ([IPv6:2601:646:8081:9484:50f9:ca46:26fb:a765])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57F1RnL11665979
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 14 Aug 2025 18:27:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57F1RnL11665979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755221270;
	bh=rDmX+eT/GPUu/NzCSnBOle3sTTqwtyDdpPu80TOMnCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qSHEoZrXgB5KipHsTpEm6y266fxWwEfaHoBF60CR6viCfKTZ65QQ5YJMP7Y/QEvX8
	 0FQN/TfiuCW2FM6qLKTz7+aWMvcPZhg3LCmJ1ChuIAjFA3a8VcDuLzOkYTx8u214wr
	 U5sD2LT7njbn9BmoXEa1P2gkOYg5oEUKLRjcS/2sS48QavdQbQjHIvKNu6wdcWHxCs
	 uApmCLextQmnFb0ADjpEBeYI7bws0OSuPghY8aWKP9wcAeX4iGPnsI2ln8XEipbdXY
	 BZqGrVN7bW45C7t2p06Nyor3jmDHdPVAbS2TBs+e5EyljIsP3DRmV2WlY+JfnpfIcQ
	 Rd8+Jc4153efQ==
Message-ID: <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com>
Date: Thu, 14 Aug 2025 18:27:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc: kees@kernel.org, alyssa.milburn@intel.com, scott.d.constable@intel.com,
        joao@overdrivepizza.com, andrew.cooper3@citrix.com,
        samitolvanen@google.com, nathan@kernel.org,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-14 04:17, Peter Zijlstra wrote:
> Hi!
> 
> A while ago FineIBT started using the instruction 0xEA to generate #UD.
> All existing parts will generate #UD in 64bit mode on that instruction.
> 
> However; Intel/AMD have not blessed using this instruction, it is on
> their 'reserved' list for future use.
> 
> Peter Anvin worked the committees and got use of 0xD6 blessed, and it
> will be called UDB (per the next SDM or so).
> 
> Reworking the FineIBT code to use UDB wasn't entirely trivial, and I've
> had to switch the hash register to EAX in order to free up some bytes.
> 
> Per the x86_64 ABI, EAX is used to pass the number of vector registers
> for varargs -- something that should not happen in the kernel. More so,
> we build with -mskip-rax-setup, which should leave EAX completely unused
> in the calling convention.
> 
> The code boots and passes the LKDTM CFI_FORWARD_PROTO test for various
> combinations (non exhaustive so far).
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good to me (and using %eax will save one byte per call site as
well), but as per our IRC discussion, *my understanding* is that the
best possible performance (least branch predictor impact across
implementations) is to use a forward branch with a 2E prefix (jcc,pn in
GAS syntax) rather than a reverse branch, if space allows.

	-hpa


