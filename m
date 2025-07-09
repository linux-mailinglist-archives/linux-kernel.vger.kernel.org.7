Return-Path: <linux-kernel+bounces-723806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A52ADAFEB25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E175189417C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC032E2644;
	Wed,  9 Jul 2025 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WoVTKptX"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A2294A0C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069205; cv=none; b=aK2q8xTzIkOzZkJqqBA3FIAycNaEK49syxT3geqM6FHDnmTtjEM/R5lU/XnJqfMtYEGptih9q345TCxIlQxxh9eGffCbnfgvIDdbnaiqczl5PzraIorosNdR+8xotOTPwf1WyG2HjSzoBrEwtJ239fRIY/wKua82v1ZsM1PwtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069205; c=relaxed/simple;
	bh=Fahz2F1dRveFqlM/iTd2DDbDxmoLTXNMYiwIG4bjO1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eor3DCLFSwXbJYdZI6OIoy2QagKyQUZe4d3baOPt879UOG1DK5S6o4Sh+3QZ7E+EIGDNmhM+xe9+x+HSSpvIprEOZkM43AwYekpfkboz7PekXK0h17jMajnBr935tMWx6l5lTskYXPZyedoTsbsQ2BN3vtpTfLVGa5DRwtLkPfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WoVTKptX; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752069194; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/mKQu7tb4IqCL/bEEszvX7wtPRViVpX6KjOqifqgDtI=;
	b=WoVTKptXTz8o4rMCoECpVnWmCxlYx99+QKdC5phWF4GQl2IP7lk16npBKDGzc0jo7LfiBIkdmOWyKR68633lw5d4AWfHiLDbmXRY6MAdbwWcDy8yQT9dPKO3SMUYgUPANahkGSVQabeS6hlpo6ku2F8BRx1AJFpitz/7yaGsDfU=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiYWRYo_1752069192 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 21:53:13 +0800
Message-ID: <da52a0d3-9a3b-4465-bf17-cf2ad8044330@linux.alibaba.com>
Date: Wed, 9 Jul 2025 21:53:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: address D-cache aliasing
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
 <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
 <862beb2e-f8a8-468a-a2ed-c8151eabb342@pengutronix.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <862beb2e-f8a8-468a-a2ed-c8151eabb342@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stefan,

On 2025/7/9 19:25, Stefan Kerkmann wrote:
> Hi Gao, Hi Jan,
> 
> On 7/9/25 5:46 AM, Gao Xiang wrote:
>> Flush the D-cache before unlocking folios for compressed inodes, as
>> they are dirtied during decompression.
>>
>> Avoid calling flush_dcache_folio() on every CPU write, since it's more
>> like playing whack-a-mole without real benefit.
>>
>> It has no impact on x86 and arm64/risc-v: on x86, flush_dcache_folio()
>> is a no-op, and on arm64/risc-v, PG_dcache_clean (PG_arch_1) is clear
>> for new page cache folios.  However, certain ARM boards are affected,
>> as reported.
>>
>> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
>> Closes: https://lore.kernel.org/r/c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de
>> Closes: https://lore.kernel.org/r/38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com
>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>> Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> Hi Jan and Stefan,
>>
>> if possible, please help test this patch on your arm devices,
>> many thanks!  I will submit this later but if it's urgent you
>> could also apply this locally in advance.
>>
> 
> Thank you for the fix and great work, it solved the issue I was seeing locally!

Thanks for your confirmation too!

Thanks,
Gao Xiang

