Return-Path: <linux-kernel+bounces-732177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E1B06317
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD2058039A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764B2264A9;
	Tue, 15 Jul 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="E7qVkR2y"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D01922FB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593727; cv=none; b=cntOAKncH8+RX9QlnlCpSHhKGz9oGpglMdZJ4Tw6oxwBbw3Nzl/5gd2770zy07ZZJ5uQVrLD3PlwDxra3GA4SF8QeKIU9C2eydzpgEvQxpkQ+EEqGCiKQhz7WDmy0CHhK9KxIKWHyMYrtNeVTazEg4z3QQ2AEEi2sUBiVw+XTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593727; c=relaxed/simple;
	bh=1Os82t3UH4xxEkIYAOAU8VzCGx6w1OSDILXxwdCWBQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PR9cyAxiCRKY0eSZ3H2gCnEpqbKtYMXtiJM7eIJxFhLfufCDYvSB0LVUWBfiQiwqwe4sQpzwa4t+jkOY+ut1aNRKRxZv1p/DjZ4aJixHXE3S9JQCZAQmZcJL5QVxlwAHZ0Vv90KRkkwq1FW+4tWjAyvBwqt4dTYOc7Zz4gbdJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=E7qVkR2y; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56FFYqXJ1029553
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 15 Jul 2025 08:34:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56FFYqXJ1029553
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752593693;
	bh=Ip3qBo5YXx2BHORJ0EPgiUIw2in1Xz9KKFl+J8c4qpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E7qVkR2yRzyO9NlR59set1lElucQm0FxobGL7ZKB2qomRXETP6I1XuNyck29IiD4E
	 d6kLC8UShFjSqHi2zwww2DXhef3gVzEMUsUe0RVe6cE0OqsJV4vMMfq4KfmMhBGbXN
	 IEq7AnJYygcE3vJuVCg8l5cRRCV6Bos882QEQAYxJOrE7FL1SrPxxt/hO+NGmsC6dE
	 fq1y6WGWd9+bhCcvRxNj6Tm9+5PIDLsXniy2M8VImkVAkONoVSb8busxtOZ1n25Rsi
	 lXhuwiFopQ+T33zQinE5ZBTjuNIwP2c+4DJkNl5sfb/vSSKbJqxRRWrGMDlA1j8c9f
	 lGQ9lO9tm95dg==
Message-ID: <025501f2-5122-44c2-ae20-0cce86e8c426@zytor.com>
Date: Tue, 15 Jul 2025 08:34:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Remove ENDBR64 from FRED entry points
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, jmill@asu.edu,
        andrew.cooper3@citrix.com
References: <20250715064437.807569-1-xin@zytor.com>
 <bb77f5f9-231a-4640-91b7-bca42e9654f3@zytor.com>
 <20250715084034.GO1613200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250715084034.GO1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/2025 1:40 AM, Peter Zijlstra wrote:
> On Mon, Jul 14, 2025 at 11:50:57PM -0700, Xin Li wrote:
>> On 7/14/2025 11:44 PM, Xin Li (Intel) wrote:
>>> The FRED specification v9.0 states that there is no need for FRED
>>> event handlers to begin with ENDBR64, because in the presence of
>>> supervisor indirect branch tracking, FRED event delivery does not
>>> enter the WAIT_FOR_ENDBRANCH state.
>>>
>>> As a result, remove ENDBR64 from FRED entry points.
>>>
>>> Then add ANNOTATE_NOENDBR to indicate that FRED entry points will
>>> never be used for indirect calls to suppress an objtool warning.
>>>
>>> This change implies that any indirect CALL/JMP to FRED entry points
>>> causes #CP in the presence of supervisor indirect branch tracking.
>>>
>>> Credit goes to Jennifer Miller<jmill@asu.edu> and other contributors
>>> from Arizona State University whose work led to this change.
>>>
>>> Link:https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/
>>> Reviewed-by: H. Peter Anvin (Intel)<hpa@zytor.com>
>>> Signed-off-by: Xin Li (Intel)<xin@zytor.com>
>>> Cc: Jennifer Miller<jmill@asu.edu>
>>> Cc: Peter Zijlstra<peterz@infradead.org>
>>> Cc: Andrew Cooper<andrew.cooper3@citrix.com>
>>> Cc: H. Peter Anvin<hpa@zytor.com>
>> Sorry, forgot to put CC stable.
> Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> 
> Right?

You bet!

Will send v2 to address it soon.

