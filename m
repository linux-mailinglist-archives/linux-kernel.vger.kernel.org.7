Return-Path: <linux-kernel+bounces-834265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B7BA44C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C83B45ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF311DE3DC;
	Fri, 26 Sep 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="p6EGGDtp"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456F13957E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898400; cv=none; b=SGDsRrHrbS0D7zGlz+u7XUMdETbp/SOxz98fNodnu0l+UeR9+7Z83f/yM/TVnfP4JN1PWFxJhYGL5/49do32cr4sAt5YGxzWBqkLf4rzcHWk1JMw3ShECbRs04GaVStEh2sai2uoYlpRmsHaPPi25TSF9cfjF1HKUxqZFhFD6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898400; c=relaxed/simple;
	bh=6Thzqw4aHHtMRfeD7HXggDaZ3AGeYZ1dPBiwjJ/io9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHvZE/wW/bGlwZMzN7dESEdusbOEx4WjfFePZ10y3E9yPUt1NOnUnfDHowORszzUSk+4SIJO1gxmjz7qfZUIeJR+aDBLzNJg2MUniYyAH+aQoP6qYphLpolWXCJ6MKrCO5Amm77RVZ3tHGLavmaAZUEHu2/I4jpAh9cVBFegyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=p6EGGDtp; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CD560C023F;
	Fri, 26 Sep 2025 17:53:07 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:120::1:1d] (unknown [2a02:6bf:8080:120::1:1d])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 5rbcZL1Gv8c0-AMhErdYT;
	Fri, 26 Sep 2025 17:53:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1758898387;
	bh=PJeC5bYprf1VEeYhS2NLL+clxp/Oj/lUOl9ledtSbLc=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=p6EGGDtpNAeK0+IyRa+pE/luOI/zo9skpwrsgwLnjVhhK/n+CAMorEWXZoPmMUhcS
	 4v0mRnMYO/CW+rj1ST3kl4qb4bNamwtppXcVsZOASFObYo4SwSd5V2J9hz4QoUBA/2
	 mdmHryQhhhfxHm4Z96ypFm55CsxDjtR1UXRySSm8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <28f39264-280d-4381-ad40-893fbaed5a71@yandex-team.ru>
Date: Fri, 26 Sep 2025 17:53:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <20250905144152.9137-2-d-tatianin@yandex-team.ru>
 <aNamx2ZZEJzSCCfu@pathway.suse.cz>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <aNamx2ZZEJzSCCfu@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/25 5:44 PM, Petr Mladek wrote:

> On Fri 2025-09-05 17:41:51, Daniil Tatianin wrote:
>> Previously, data blocks that perfectly fit the data ring buffer would
>> get wrapped around to the beginning for no reason since the calculated
>> offset of the next data block would belong to the next wrap. Since this
>> offset is not actually part of the data block, but rather the offset of
>> where the next data block is going to start, there is no reason to
>> include it when deciding whether the current block fits the buffer.
>>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> The patch looks good, especially after understanding the problem
> with the maximal record size.
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
>
> I am sorry that I did not wrote this earlier. I am quite confident
> with the patch but it is quite tricky. And I do not feel comfortable
> with pushing this for 6.18 (the merge window will likely
> start in 3 days).
>
> I am going to queue it for 6.19 so that it could get enough
> testing in linux-next.

Yeah that is fair enough, and no worries.

>
> Best Regards,
> Petr
>
> PS: There is no need to resend the patch. I could fix the indentation
>      when committing it.

Thank you!


