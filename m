Return-Path: <linux-kernel+bounces-766637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A8AB24959
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03D1189DBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC335979;
	Wed, 13 Aug 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i5PntXEg"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E35B25776
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087379; cv=none; b=OBM+AnJnNcOHXKvm3yr7A+fgp9bAREBHLwMtaQ59O8VfNERrpD6afgkEGfXsVNIJEBb8GiS6wxb2GbWW1PGc5RlVBgxaskWdBLpSBws3H6POhB4Z6slqIjfdOceSQ2NBl0dcDKdpFobZLih2enbStQZ8FKKrMrpnUYFy71+UrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087379; c=relaxed/simple;
	bh=gTmMhKYa+mO/XTN+Asq4ZU3pnRIQloajJRpVyIiaK/Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fBBdY8VIoOaNU07R6XtXCjpMe6f9OkT7qTQNM5Lzg1rcM1aV3VzOYnScx1ol+8VkhBOwvNX60RHMLfPwOByd8OhpTsazynDTPWUU7iRwszvEbiKaPRqpTqq28g4W99Q/TGewOk0m9uqNtn2fZeRkYJUk0MpYKO1OinxGESM/ERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i5PntXEg; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755087365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiaCgZfmOx4/7on6Rer11yrhjcnknWSGMlKK73OA7Fs=;
	b=i5PntXEgFCQwbp3q0D9XDI6luqdZDWqCRnJAjZh5ITSxTjb2xx/D1He/GCtcjD3qcRFXwU
	SXHtTMi+jiYpTPnodLMPI38V8MCGK+98WW9E06PmotdkSAOCwhbBj/NotUhu/LOEkqkg7G
	ZU1odQ2i+tCnQSMMaL8bREakWg5g6WU=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] params: Replace deprecated strcpy() with strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <f0a77c72-8fad-4fc5-9198-2a9c7c97a489@suse.com>
Date: Wed, 13 Aug 2025 14:15:50 +0200
Cc: =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shyam Saini <shyamsaini@linux.microsoft.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Dmitry Antipov <dmantipov@yandex.ru>,
 linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <47F53A47-D331-4DC5-8146-7ED09C65177F@linux.dev>
References: <20250810214456.2236-1-thorsten.blum@linux.dev>
 <5d334a1f-0dbd-4e25-bbc5-b01aca369385@suse.com>
 <F640B308-C8C4-439B-8217-98FFC10BB76B@linux.dev>
 <f0a77c72-8fad-4fc5-9198-2a9c7c97a489@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
X-Migadu-Flow: FLOW_OUT

On 13. Aug 2025, at 13:42, Petr Pavlu wrote:
> On 8/13/25 11:33 AM, Thorsten Blum wrote:
>> On 13. Aug 2025, at 10:59, Petr Pavlu wrote:
>>> Since the code already calculated the length of val and that it fits
>>> into kps->string, is there any advantage (or disadvantage) to using
>>> strscpy() over memcpy()?
>> 
>> strscpy() guarantees that the destination buffer 'kps->string' is always
>> NUL-terminated, even if the source 'val' is not. memcpy() just copies
>> the bytes as they are.
>> 
>> If it were guaranteed that 'val' is always NUL-terminated, memcpy()
>> would be fine too, but since param_set_copystring() is exported, we
>> probably can't make that assumption.
> 
> The function param_set_copystring() checks using
> 'strnlen(val, kps->maxlen) == kps->maxlen' if val contains NUL in the
> first kps->maxlen bytes. It can use memcpy() instead of strscpy() to
> avoid repeating this work.

I see, and yes

	memcpy(kps->string, val, len + 1);

would then be slightly more efficient because strscpy() would just
recompute the length before calling memcpy() internally.

I'll submit a v2.

Thanks,
Thorsten


