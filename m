Return-Path: <linux-kernel+bounces-821034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E69B80254
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B397171810
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6E2F3C14;
	Wed, 17 Sep 2025 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="jrLBm6Tp"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA12F066A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120098; cv=none; b=uY9eI1W8skRVbnDuIFiU7NozSfxrJJePY+bQOv9+mNLpV71F//oBGgRECfBnUXFLuZ8A1MsnYped5P6F18YWAlH0KTPxYSZnSa6aNiPPsjhZ/hmajKAnnD2yOeB5Rq4HZTWx9SK8i98H2ePeqIF+MNQh/ty2rk6hTPZ+JvCLv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120098; c=relaxed/simple;
	bh=I/z7U304JTwO94u1bnkA/Hks+NzJgOXOigQoumFURbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idrV9Yqg0C669XNCwBkfGdLaTr98aPwh2mGMuNBkGmBufJbHEe+kTDHLzIlGaDZyqZ8HrwDkZIdVOCTEdW8GcVibwU5pmgjJ28Ja4QwTMCNG4L2gbCl7yCgX+RAWfDwkqlkp6wvrmUXGb68fDK9AfqTwE7QwlXoh7Ko+eHQaDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=jrLBm6Tp; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A629EC0183;
	Wed, 17 Sep 2025 17:41:24 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8011:f00:892:da6d:2c11:1af9] (unknown [2a02:6bf:8011:f00:892:da6d:2c11:1af9])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id BfSKmK0GnuQ0-GrDuOf3C;
	Wed, 17 Sep 2025 17:41:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1758120084;
	bh=eBPc/BeuJ7fV43KQ20piI8pdsxTVb0VMtheYuJm63KI=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=jrLBm6Tp8q7toy5QEaR5te8WsegUuPaIlHWVeZInqtyy6MG/jKaohS5huMWw2eEuY
	 FXR0wcjmOsgLNlcAd0VJDso8V+oyLqkgxC3lcFh/Ki5u3U81k/khAxZx0dcyEaSABu
	 BYN26oIUDb4MfuhgXrOxAcG8SOiZjS8o24ytfEuo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <3c7c5bca-5d3f-4878-b6d4-72b036e8b588@yandex-team.ru>
Date: Wed, 17 Sep 2025 17:41:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] x86/split_lock: Warn for bus locks once for each
 task
To: Pedro Falcato <pfalcato@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20250910162126.157894-1-pfalcato@suse.de>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <20250910162126.157894-1-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!
I've tested this patch (VM w/ bus lock detection and w/o split lock 
detection). The warn mode works fine and as expected with only one 
notification per task. However, the ratelimit mode has been changed too: 
only one notification per task will be in dmesg, because this mode 
reuses notification code of warn mode. But in the documentation for 
ratelimit mode there is nothing about the limit of notifications: "Limit 
bus lock rate to N bus locks per second system wide and warn on bus 
locks.". Thus, I think that ratelimit mode should remain old behaviour.

On 9/10/25 19:21, Pedro Falcato wrote:
> Sometimes, it's possible to see long-running services that keep pounding
> the bus_lock logic in a long-standing way that does not trigger
> ratelimiting, but still floods the dmesg nonetheless, over time.
> 
> Fix it by using current->reported_split_lock, which was previously
> used for the split_lock handling. In this way, bus_lock #DB's are only
> warned once in the dmesg, for each task that hits a bus lock.
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
> This is already reflected in the documentation for bus lock, as "Warn
> once per task and and continues to run.".
> 
> Resend since the first mail had accidentally no mailing list in CC.
> 
>   arch/x86/kernel/cpu/bus_lock.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
> index 981f8b1f0792..71342e6244e3 100644
> --- a/arch/x86/kernel/cpu/bus_lock.c
> +++ b/arch/x86/kernel/cpu/bus_lock.c
> @@ -335,8 +335,11 @@ void handle_bus_lock(struct pt_regs *regs)
>   		/* Warn on the bus lock. */
>   		fallthrough;
>   	case sld_warn:
> -		pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
> +		if (!current->reported_split_lock) {
> +			pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
>   				    current->comm, current->pid, regs->ip);
> +			current->reported_split_lock = 1;
> +		}
>   		break;
>   	case sld_fatal:
>   		force_sig_fault(SIGBUS, BUS_ADRALN, NULL);

-- 
Best regards,
Maksim Davydov


