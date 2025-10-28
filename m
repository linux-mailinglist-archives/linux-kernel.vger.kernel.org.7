Return-Path: <linux-kernel+bounces-874546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA42C168C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBA174E3CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E54734E769;
	Tue, 28 Oct 2025 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="S6PRWO2Y"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFA1FBC8E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677782; cv=none; b=tR2F+N0pNBTYQZPAdRrlgyCnbKctSzfwgGrjN/Xu3ICIT0LjX0Cbb3FTUITeoF8bm690PcNKqqYOIILAjQuNYF1xrbybPDqQ2uu7NlG7nINj4RKdXRzFf5vmc8zpfFiUG4JS2dSat8BQjZ0cx/A4P3hqqUD9AXr1nrTK6+0ukqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677782; c=relaxed/simple;
	bh=atPVB/NslUpTU+PiXPab0qojrF1pMcoycpP3HvJooBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZbjer/3hk5PeCZj45RP/SzbYIYwT8ce1voGdOGCLoP9uVDDvmp4kgNVrUgNmxVXMl3LK7FGF8rDapFaNAjSvuBlAI+j91jIeDKKW5T5JfcXQh7veAYF+OaRQvDXR9h9WUIyijt1hsgY4hLdn1PFSGwPcPuEi5+KTytp39JhO70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=S6PRWO2Y; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:71ce:e7c:a6bf:3efe] ([IPv6:2601:646:8081:9484:71ce:e7c:a6bf:3efe])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59SIu2Iq1613600
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 28 Oct 2025 11:56:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59SIu2Iq1613600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1761677764;
	bh=p+roapVSERhQEWat+bM2z2fsS5MsGKwo/pdV1SiLyPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S6PRWO2YNJzBuxOLTr+ylmX7f0iqHmVW/sLFNDCunvirk+Ab65nriYyiMMwWzqQVb
	 QI7GL8k/Di5jWOFhtBzCnUNrrP192ETX/zI7/2Yw9Jf776RF3c5lVNes/sMztFZMKw
	 rl0PNTIY/wxjN3pNN4uCT4vXyyng78uZICXfecDwK4zgZEV3cW8Q/N0ZiAgIeWri5R
	 vT8PERcLtPxVUAm+Q2hIOcWRJEtla4KKcDXhzUr0E8E87t8kSGg3dQ2bjKBR/wQ963
	 ksnB4JWwRYfblip4MGe1yhcl1eI+GvbCbit84ZbUGoQXQO7wZ2w0fnDK8IFfDgANrl
	 RsBbceTUeWjzg==
Message-ID: <7623dfcf-f6ed-4caf-bb60-7fa953f0778c@zytor.com>
Date: Tue, 28 Oct 2025 11:55:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86,ibt: Use UDB instead of 0xEA
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, Kees Cook <kees@kernel.org>,
        alyssa.milburn@intel.com, scott.d.constable@intel.com,
        Joao Moreira <joao@overdrivepizza.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>, ojeda@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20250901191307.GI4067720@noisy.programming.kicks-ass.net>
 <20250902081915.GK3245006@noisy.programming.kicks-ass.net>
 <CAADnVQJ2zm7BRb3SuwcmCQ5SBULznbUq777vMCHkm9UbPkaAbQ@mail.gmail.com>
 <20250902192609.GL3245006@noisy.programming.kicks-ass.net>
 <CAADnVQKns0xLA+oEdgF-gZ9W=pqjkL2h2OcUQxH+CvJ=vVL-0A@mail.gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAADnVQKns0xLA+oEdgF-gZ9W=pqjkL2h2OcUQxH+CvJ=vVL-0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-02 12:37, Alexei Starovoitov wrote:
> 
> I suspect that 'reserved' opcode will not be used any time soon.
> If 10 years from now the opcode is used in some future CPU that CPU
> is better to be not vulnerable and CFI, FineIBT things will be
> gone from the kernel by then.
> So I would do absolutely nothing and just ignore the lack of blessing.
> 

What makes you say that? *Please* don't make these kinds of assumptions -- it
causes massive headaches for both us chip makers and for users.

	-hpa


