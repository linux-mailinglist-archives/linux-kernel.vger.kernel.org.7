Return-Path: <linux-kernel+bounces-840258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E0BB3F59
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767DB3AB43D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC2311949;
	Thu,  2 Oct 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YOfahiYp"
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B203054D4
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409897; cv=none; b=BGZsBUNLmAQd8QrHQSWFfRQhTo/1mY6Fsawv9/dnh/NCiqU+A0vSUvMmj9UHznrQmpsjIG2Qf+YVhguCIP5ZMIUukQ1tHwRu0k6dsnV8U9cVpw7lr1ma1j7JL7mM1ZXnzazkQadauOamNewmC3XWUkoUPI0ptfMPiSgQL1xA4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409897; c=relaxed/simple;
	bh=acTdZw7/dc9cyMiJEYxtpVizDI4T6EABkeQB2+PFGzE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WKbAp8XdqOXAPqKuJWnwSfWqGGu6vs6jIcJIqTU50y+n5mJveEcnwRiFV8R3wOwnkT60moVkixgVGrOAOO4oG08gnbnrAEl/yCHVbNuVgLtnH57eSWCjlquCd0saQmwxA3NSWIka7D4WMid2Eel8kWHyXxl0Oyp8TRpWC82BEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=YOfahiYp; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5183B80483;
	Thu, 02 Oct 2025 15:58:03 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8011:f00:5ba8:5b88:db1f:763a] (unknown [2a02:6bf:8011:f00:5ba8:5b88:db1f:763a])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id kvfbnd3Fw0U0-R8D86RF3;
	Thu, 02 Oct 2025 15:58:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1759409882;
	bh=JvmnaLcXhiZz0kKSuginsc13OFRus4Mw3cv7o6Z5s80=;
	h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
	b=YOfahiYpPCgYfKDc2EOgoVwxHUf4xIxKxdNnbxFP4kHBWKK2cR69TuUr2XBwqNaK0
	 v80EkXkr1mCfx8fe/YMNMgLRnTaNuir46ETDJVprcJR6oEGHV1dmOJsjy58EBqcIub
	 8d8xBR/2wY924UPCW6u/c1eUvT7S3K/8FzDeYsIQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <f41505e6-62da-480c-86ed-5eccd309cc2d@yandex-team.ru>
Date: Thu, 2 Oct 2025 15:57:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maksim Davydov <davydov-max@yandex-team.ru>
Subject: Re: [PATCH RESEND] x86/split_lock: Warn for bus locks once for each
 task
To: Pedro Falcato <pfalcato@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20250910162126.157894-1-pfalcato@suse.de>
 <3c7c5bca-5d3f-4878-b6d4-72b036e8b588@yandex-team.ru>
 <hs7b3ghxpr2oq6rmqitw33xkunkqpvjkpnwzhqfq4em5vxvymw@rn4c6mr636es>
Content-Language: en-US
In-Reply-To: <hs7b3ghxpr2oq6rmqitw33xkunkqpvjkpnwzhqfq4em5vxvymw@rn4c6mr636es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/25 18:37, Pedro Falcato wrote:
> On Wed, Sep 17, 2025 at 05:41:11PM +0300, Maksim Davydov wrote:
>> Hi!
> 
> Hi!
> 
>> I've tested this patch (VM w/ bus lock detection and w/o split lock
>> detection). The warn mode works fine and as expected with only one
>> notification per task. However, the ratelimit mode has been changed too:
>> only one notification per task will be in dmesg, because this mode reuses
>> notification code of warn mode. But in the documentation for ratelimit mode
>> there is nothing about the limit of notifications: "Limit bus lock rate to N
>> bus locks per second system wide and warn on bus locks.". Thus, I think that
>> ratelimit mode should remain old behaviour.
>>
> 
> So, you're suggesting different "warn" behaviors depending on =warn vs
> =ratelimit? I don't have a particularly strong opinion here, but I was assuming
> that "warn on bus locks" means "do whatever =warn is supposed to do". I'm not
> sure warning every time gains you much, though.
> 

For me, it's ok to reduce the number of messages to one per task.

By the way, I read the patch again and noticed that split_lock_warn() 
and handle_bus_lock() print messages in the same way. Maybe, it'll be 
better to implement an auxiliary wrapper for printing 
split_lock/bus_lock warning messages (for example, 
print_sl_warn_once()), what do you think?

-- 
Best regards,
Maksim Davydov


