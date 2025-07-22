Return-Path: <linux-kernel+bounces-741443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7625B0E422
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D004AA18D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CE0284B38;
	Tue, 22 Jul 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Aa9xRmED"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35202283FDE
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212433; cv=none; b=nEzw4RvvwxWFA7j5aUzkT/1ePJmrRMUN4Y4gj5H3AvK1/7jPBd0H8P6XQ+2vEinxaUkVcDrcLSxUdmPUVzH3FhxQanwmgse7gVIBD3rd7AH2vYXhHZWR8Ri1xI8HDIdpuQ+jUSN+Wqph8oydZJwTklNR2Z6CgXgG146gz2Wrm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212433; c=relaxed/simple;
	bh=9epL9+Wc1zrAwpTU8IbXlsI54D2Y9lUQ4aWYVcSXrj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvMtdKhLDLlL8XM3egIo4gb6RJRxCUTo3FclTIDMQ+DBRCFFudOfwKlusriywb687+RVF5IIoXT8UmbQTLJEvnMgx/KrQM09fQ+7aqAvxcMnDDphcfnD5w1tHnPRRYCJgnhq4yYGXOR87reWGVj1ApvjSmwIMbFYzE6LsL8AjeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Aa9xRmED; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:425f:161c:76a:170a] ([IPv6:2601:646:8081:9484:425f:161c:76a:170a])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56MJQo1W720928
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 22 Jul 2025 12:26:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56MJQo1W720928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1753212411;
	bh=p8DUMkMzGZLgdPsR7TDsc3CITTx+hnylGhZVDJtBxSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aa9xRmEDivKKGv8RWjolcUlb0xdiygWugU8S9ccZvj7SP0qnyzZopSzakoHuiJxOw
	 HiVhqUQiHPCiCABx+d2tjIGdDWIdqtSzb2on8vTuHhwdSOWKwTbgh8R3FTABixU8Rv
	 wE5kxFhAuzxguVGAKeo9eTe4soHgeeSuYsiWp8H1xdZx7zEip3z5MdHPkl0SIX5ypZ
	 YZgaYWTIwLVABMjFfGOZhxg/aRy/orZj8mBr+pl9gpAuWXGDUQJI1v6MdmwsRWdNgX
	 PQHlsueYqEgsT7wKCJb39fIQZzznLEMJYHm2MdVm+oITnb6CWQAw+sC6jwB/AIviFy
	 PqGND6bKfwKAw==
Message-ID: <4d6275f1-f3a4-4d70-9c25-42bd4563c6d0@zytor.com>
Date: Tue, 22 Jul 2025 12:26:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Li,Rongqing"
 <lirongqing@baidu.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <20250721130422.GA31640@redhat.com>
 <20250721192053.58843751@pumpkin> <20250722105034.GA2845@redhat.com>
 <0818676F-ED90-44B1-AB10-42DDB7F1B139@zytor.com>
 <20250722175807.GC2845@redhat.com>
 <548B24CC-2E58-4CC5-9025-950408BDCAA5@zytor.com>
 <20250722183853.GD2845@redhat.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250722183853.GD2845@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-07-22 11:38, Oleg Nesterov wrote:
>>
>> But that's what you want to optimize for, since that is all the modern compilers, even if you have to have two versions as a result.
> 
> Well, this 'divq' is slow anyway, I don't won't to add 2 versions.
> Can we add the optimized version later if it really makes sense?
> 

Then it will guaranteed get forgotten.

	-hpa


