Return-Path: <linux-kernel+bounces-891556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D9FC42EBE
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 16:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292923AF683
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4A51F790F;
	Sat,  8 Nov 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jbMu2ZBe"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89A72602
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762614460; cv=none; b=jgyqYvm9FK67NkhDzht5k3erCA4dsh23/2FW6I/sTwSUapAO8mhxhcX6BGm1xnGbemYt1qt1DzrzGy1TPkYrx3kXaYa0G78xLy0qN1y6yZdUIB1f/Sc6BKB1vDr2sNnOVQkCR3lFh/XtYBhYem7fSNZ8aEyB6pOImNabTokTjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762614460; c=relaxed/simple;
	bh=hZulVcV8D8i+hjnXpAw/8UlShxU2+MYYpSZZtMoE+CU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s9UQRTQd8kqaodoCShbYR5Hu+nHrSZ4guvsfLAwndyQ0eeqgnzJ8fcvoCJJv03LOor+2+km5EXjQdZnO1HZu3pShWY7oKYD5Nea/CoFsfnZqGJb4yMkrUgL7UEfz89+5NMbz+ufRshxpYs2j8w2z1MFkY/cycTJsmn0sQZsAhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jbMu2ZBe; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762614456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kql7lphGlkHq6UsMsoJucrW7fDkcQOyE5BwJP9Vc8ZQ=;
	b=jbMu2ZBeQ9QrSVT+Epa71jzMlbYmEE/SO0MgFTlIzVVM903p0DajPmLz1QtEXeZ/yi7ggb
	i7XbkAomjq04diizGxdZZJF68hIgOupNKDEiLfHDvgwQSgOJtk0NloWkpXXld7RIAFOk05
	5aO++k3i/3NWertVkUK7TdcpFSc7tsU=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] w1: therm: Use str_yes_no helper in w1_slave_show
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <9502638c-1058-4a82-934b-87d4995ec8b2@kernel.org>
Date: Sat, 8 Nov 2025 16:07:02 +0100
Cc: Huisong Li <lihuisong@huawei.com>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D43F162D-588C-418F-A019-B50BE1D0F92C@linux.dev>
References: <20251105161900.43042-2-thorsten.blum@linux.dev>
 <9502638c-1058-4a82-934b-87d4995ec8b2@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 5. Nov 2025, at 17:23, Krzysztof Kozlowski wrote:
> On 05/11/2025 17:18, Thorsten Blum wrote:
>> Replace hard-coded strings with the str_yes_no() helper function. This
>> unifies the output and helps the linker with deduplication, which can
>> result in a smaller binary.
>> 
>> [...]
> 
> That's sysfs interface, right? So an ABI and you change here caps, which
> might matter or might not, but anyway some sort of analysis of that
> should be in the commit msg. Otherwise better not to touch ABI.

Yeah, I guess it's better not to change it then.

Thanks,
Thorsten


