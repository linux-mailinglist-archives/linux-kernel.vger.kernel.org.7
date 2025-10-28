Return-Path: <linux-kernel+bounces-873521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9773C14210
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 500714E51B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6703043D4;
	Tue, 28 Oct 2025 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB476Vmd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64802F7ADE;
	Tue, 28 Oct 2025 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647887; cv=none; b=A+Mv/3QDARQ7+Z+1P76yg3WA7ASup9f91BoiJGo2IfxECVq3IPKNp6yMwwE5Bo+nUq5FzM4VTYmIVDfbQvBUsW32eeRd5Y3eNq7K7gnA2eawTuCYhku5SNTGFFOqkvg/jC0eZaKGX17aGFUJkrS2Fqo0AmnzdkQBjowOIhu5VrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647887; c=relaxed/simple;
	bh=Lo+GCwsNYGzFkSA8gS04chCTZTtfBz/BwfhxcyEs4Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcPlNNkQxPGEljDX6kgP0xoo4SH9fDjEkbssneuoD9ggwAYE3J3m/Ultl/7ympcEMS9pfCt8/wSqNGTrgxpSDrGnJWuUzr+n+bRCL+Wk+pNpb24gKtwDWQp18froM/BTxMgrIeMsF6p4v05ANWZz7QWXodGWeWFfre4gJREPt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB476Vmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B915C4CEE7;
	Tue, 28 Oct 2025 10:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761647884;
	bh=Lo+GCwsNYGzFkSA8gS04chCTZTtfBz/BwfhxcyEs4Js=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pB476VmdhQLDX+f5NcVUROpD1HIQ20m2BkwiXOXv5d8BGg+DHhKuj7G8o5sIn55dk
	 foD2ArKJv5k8UM0gwow2PPuAq4m39oNbZ73aRThMBJlubkvZgTpgCqjzilYhs6/MrT
	 buQb9zKLAqViHjXZqf1l7ByukUKdeIKq+gnDaVZGI9x8imD3CDB2BGxx0PIS/mnmmg
	 03urBrCpGe5/LdGSZZDNYU/hY1MHLy3A5KJZj2ahOJ+I7kWYb8g67PqMxP9mvCg6eJ
	 zajA4hbncfAs0/ZyhPDImWkc4pBWnYxR1Kwqek0eI/Qsd0kvl9/0Q8y8fR54FTJbAE
	 +uidoPP3s6JKg==
Message-ID: <7898408e-1b33-4f22-84d2-12bcd6254402@kernel.org>
Date: Tue, 28 Oct 2025 11:38:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: int3472: Fix double free of GPIO device
 during unregister
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Dan Scally <dan.scally@ideasonboard.com>
Cc: Qiu Wenbo <qiuwenbo@gnome.org>, Daniel Scally <djrscally@gmail.com>,
 Qiu Wenbo <qiuwenbo@kylinsec.com.cn>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
 <5007d7f0-76ff-41fd-a371-05922c97f8ef@ideasonboard.com>
 <aQCUu5vCPlglC0Kd@smile.fi.intel.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <aQCUu5vCPlglC0Kd@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 28-Oct-25 11:02 AM, Andy Shevchenko wrote:
> On Tue, Oct 28, 2025 at 08:55:07AM +0000, Dan Scally wrote:
>> On 24/10/2025 06:05, Qiu Wenbo wrote:
>>>
>>> regulator_unregister() already frees the associated GPIO device. On
>>> ThinkPad X9 (Lunar Lake), this causes a double free issue that leads to
>>> random failures when other drivers (typically Intel THC) attempt to
>>> allocate interrupts. The root cause is that the reference count of the
>>> pinctrl_intel_platform module unexpectedly drops to zero when this
>>> driver defers its probe.
>>>
>>> This behavior can also be reproduced by unloading the module directly.
>>>
>>> Fix the issue by removing the redundant release of the GPIO device
>>> during regulator unregistration.
>>>
>>> Fixes: 1e5d088a52c2 ("platform/x86: int3472: Stop using devm_gpiod_get()")
> 
>> However the Fixes tag I wonder about; devm_gpiod_get() will also result in a
>> call to gpiod_put() when the module is unloaded; doesn't that mean that the
>> same issue  will occur before that commit?
> 
> Actually a good question! To me sounds like it's a bug(?) in regulator code.
> It must not release resources it didn't acquire. This sounds like a clear
> layering violation.

I think the problem is that when it comes from devicetree it is acquired
by the regulator core. Only when passed as platform-data as we do here does
this layering violation occur.

I do believe that a transfer of ownership ad done here is ok for
the platform-data special case.

Regards,

Hans


