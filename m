Return-Path: <linux-kernel+bounces-882957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3590BC2C034
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97931189A7D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED882989B4;
	Mon,  3 Nov 2025 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YN63yOAo"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9641FDD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175542; cv=none; b=B7WjiAezxqUwYYub+AiOfQFSLqlJJl4LwfRvqnL7LEJ29ZN4fIA3+nGFwkpqZJCZtmTDFUUypGGDDyMO/GENprepL1kjP5eE5JN8GaLRkp6l77mn3y8xFty71j6Jp9CfWQzrRMdEJJ5S64Kl8BP0y6zKCAOV2yacvqOgUxi/boI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175542; c=relaxed/simple;
	bh=Mmvt7PNKG6SU914myWVJdx0KaLHcNTW1dQjRb3V+seM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LNY9tL7z6g9liUbsW1JlaphysE72pggm/wu4TYtcuV3mBYOJI2bpVlnKQvgfFKFqwuC+WRhO2IEzSGtGWbXTaYqM+NyR8yBZ+0ParuZL7T1tQ5lbkG3A6/70uFQleueqXmg7Y/xlTJ9RJl3rf3KHamBrAmopy+y/4OIQQ5gyww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YN63yOAo; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762175536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B33bdjHhYu9+wHKhO/TygcTBTBUN2QAjRpW4nRjqLZI=;
	b=YN63yOAowvXAlExeNV1G5mA5fRE7JO5WrXcnHM8QWl1hX+YG/266U3tITk+P1Xm/jyVcif
	5Tbino2hjvGNXq/A3WOn/LHMcDuVYtOyjTl5BtjFLQ/cCd5bJgmuWnYDucHOWiE0NvedQi
	cRcNmjVpET9g4t+MrpOBLb9uQvVz8EY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] misc: ad525x_dpot: Replace sprintf with sysfs_emit in
 sysfs_show_reg
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2025110333-marbled-viewable-0259@gregkh>
Date: Mon, 3 Nov 2025 14:11:41 +0100
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EDC58257-4D56-464C-B11D-1AEB0B90EE5C@linux.dev>
References: <20251103123403.62076-2-thorsten.blum@linux.dev>
 <2025110333-marbled-viewable-0259@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 3. Nov 2025, at 13:46, Greg Kroah-Hartman wrote:
> On Mon, Nov 03, 2025 at 01:34:03PM +0100, Thorsten Blum wrote:
>> Replace sprintf() with sysfs_emit() in sysfs_show_reg(). sysfs_emit() is
>> preferred for formatting sysfs output as it provides better bounds
>> checking.  No functional changes.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>> [...]
> 
> I did not suggest doing this for existing code at all, it's only needed
> for new code, I've said so many times.

You suggested it in [1] for this function when I made another change to
it a few weeks ago. I even replied that there's no coccicheck warning,
and that the sysfs_emit change should probably be a separate patch.

No big deal, but still confusing.

Thanks,
Thorsten

[1] https://lore.kernel.org/lkml/2025082052-crawfish-revisable-7965@gregkh/


