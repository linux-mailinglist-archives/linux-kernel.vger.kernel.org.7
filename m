Return-Path: <linux-kernel+bounces-771261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0909B284CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D255F178C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5413E321430;
	Fri, 15 Aug 2025 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PUMPiO8R"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B41304BDE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278121; cv=none; b=V6uCQQaPyKspdc5yjNDsJlyptAqriXj9E1HdYVwfZVV0rZZoNXa5whmbnfAe+bb98mvSWUoD3Nqbg0Lk59x31A4JttWUu9h9V/ftlsuPE6HnLqZYOVzGKDmkCaHP3+psuJvyYmu6lHOe8rTWgR+YYBpyv4sTnhxtx2/c/62I3Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278121; c=relaxed/simple;
	bh=Q9VDTyPsJ1nrsJ9IPGQ/uH24LWZk1d50M/ALSVgVhkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5dblKPwqI8Ff79Nw9yXgKBj6KaGwv6A1WDNuhREkl7xgW5yhRjtQedLHCT2EbhO/hpz/b1tnSAH2nhQ42aNTSZg4qeRJhgq7+XeqkTx7+MIGgyQt/lpqwaAaSGXpQT6sY1H0lp2B1QLFgTgUbXEasOdE8EBJRg885R3MUSnPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PUMPiO8R; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:50f9:ca46:26fb:a765] ([IPv6:2601:646:8081:9484:50f9:ca46:26fb:a765])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57FHF2ON2012703
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 15 Aug 2025 10:15:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57FHF2ON2012703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755278104;
	bh=xMvjS3Kd5v0VRPHOeHrYngN+OKw4RRNU/wrppPGKZ7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PUMPiO8RbYAmd3BO2Gb40KMQ8esEioA/r32CoRljiSql0GrlTlOWkDSmcN6ovbTQ0
	 tutde6nkhOHwTobfcv8Sj3JmiahVAE32ToleR2IGuDLMfjJRPv41Clitk5yTmmgkWV
	 jn6W7JHygJLtyukV9UcuzPML0k0iN7fdLkcx362GnbKToeVNx7hueYavitqNVEljLM
	 mIiNbcFqyz1UsiCDI6yXge1Cq9xYzobj21GRjYHq29wT0zwmOLaodQHsFfL33jbsyi
	 WbT05zyCsHz68/o56kaDqmBUZSYJfANueAwexY3+IpZGb7pjNRKJ1ili9j+gxnGbJL
	 LkXgkBjXrpdUQ==
Message-ID: <78bd985a-a59e-4469-a84d-a0eb7faa20c3@zytor.com>
Date: Fri, 15 Aug 2025 10:14:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kees@kernel.org, alyssa.milburn@intel.com,
        scott.d.constable@intel.com, joao@overdrivepizza.com,
        samitolvanen@google.com, nathan@kernel.org,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
 <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com>
 <20250815074939.GA3419281@noisy.programming.kicks-ass.net>
 <20250815102839.GD4068168@noisy.programming.kicks-ass.net>
 <20250815103055.GE4068168@noisy.programming.kicks-ass.net>
 <fc0715e0-42f2-4b5d-be31-ac44657afc56@citrix.com>
 <20250815105908.GB3245006@noisy.programming.kicks-ass.net>
 <055f4c2b-0e7f-44ae-92ff-a1025a217208@citrix.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <055f4c2b-0e7f-44ae-92ff-a1025a217208@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-08-15 04:19, Andrew Cooper wrote:
>>
>> CS Jcc, decodes to Jcc,pn for non-taken
>> DS Jcc, decodes to Jcc,pt for taken
> 
> Ah, thanks.  I was looking at the hex in one of the comments and still
> couldn't figure it out.
> 
> So with this notation, we also have the dual meaning of ,pt between the
> P4 and LNC.  At least the encoding is the same.
> 

What "dual meaning?"

	-hpa


