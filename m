Return-Path: <linux-kernel+bounces-892139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE23C446C6
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 21:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8870A188ADBF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 20:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7301E521A;
	Sun,  9 Nov 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HDVSujHk"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E7263F28
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762720214; cv=none; b=OvHRGt9j3ZYnTt2eZTgbFeLDQazngdCzcloS8wH+bYA1+w0vcXpuMuTJ3awSC6u91CxbW3uVu37TQM0A/4yMoxsASKo9wsZ0Fzx/BfWkfFt6CLidxv7w6yuGMPdwC9AqwhXqsnhEX3MmDUXFjgUdJGxfaYUYPIYtipZmJFwXMqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762720214; c=relaxed/simple;
	bh=MJpLMxWeS8USQuD6OqKrZmGZQXo6PshJLiTQGaAwAmo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=legFV1oy6Tg57mKaAXbBzfu/LC/HV+6DEaavjp55LBtm2a0njK/mFWkIv+YVv4DctCHOub8a4t/wOwHn3i+DyHZrSAqMZtW/4ClBUu3BSDx6J1KcQbYu29AwTcNqCrM4GTlbhl45IGoZrB41nda80EU+RdqrbYQYjJ/R0+SEHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HDVSujHk; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762720207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9NwVK6B3KP4d2ejE4cLOmSG9L0F7o9tDAZt2GkelDI=;
	b=HDVSujHkiD46Yx+GqFkgORfP0As9ci0X3DeTKtSsielECGxTxxiXhyMyAfe4kbWVIy+RF4
	aQjRiIlCux8o/EtL18PoWdzNGgqvLhiEJOj198QjIGd06PmC46jeAxmRGdv0ym06CVOuVr
	OqczeTYd80voQiqoUOKduJQ7tY4rSFE=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] w1: therm: Use clamp_t to simplify int_to_short helper
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251109162056.0a9cbd52@pumpkin>
Date: Sun, 9 Nov 2025 21:30:00 +0100
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Huisong Li <lihuisong@huawei.com>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <28C4DAF0-91B9-4175-AC2C-D3B5AC283439@linux.dev>
References: <20251109130000.406691-1-thorsten.blum@linux.dev>
 <20251109162056.0a9cbd52@pumpkin>
To: David Laight <david.laight.linux@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 9. Nov 2025, at 17:20, David Laight wrote:
> On Sun,  9 Nov 2025 13:59:55 +0100
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
>> Use clamp_t() instead of manually casting the return value.
>> 
>> Replace sprintf() with sysfs_emit() to improve sysfs show functions
>> while we're at it.
>> 
>> ...
>> +	/* Cast to short by eliminating out of range values */
>                  ^^^^^ no shorts here...

It's even shorter than short. I didn't even notice...

>> +	return clamp_t(s8, i, MIN_TEMP, MAX_TEMP);
> 
> That is just plain broken.
> clamp_t() really shouldn't have been allowed to exist.
> That is a typical example of how it gets misused.
> (min_t() and max_t() get misused the same way.)
> 
> Think what happens when i is 256.
> The code should just be:
> 
> 	return clamp(i, MIN_TEMP, MAX_TEMP);
> 
> No casts anywhere.

Ok, yeah 256 would be 0 when cast to s8 even though it should be clamped
to MAX_TEMP. Never thought about this side effect of clamp_t(). Will
change it to just clamp() in v2, thanks!

> I'm not even sure the return type (s8) makes any sense.
> It is quite likely that the code will be better if it is 'int'.
> The fact that the domain in inside -128..127 doesn't mean that
> the correct type for a variable isn't 'int'.

The low and high temperatures (s8) are only written to the u8 array
'new_config_register' for which s8 seems fine. What made you think int
might be better?

Thanks,
Thorsten


