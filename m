Return-Path: <linux-kernel+bounces-747263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA51B131A6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE787AAB64
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D531DF994;
	Sun, 27 Jul 2025 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CTa8ehkx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LsxiZE5C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA7328FD
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753646467; cv=none; b=UVzW77cJsHvywGArLqjTJEiCjuN9LtOfnEYqFyrMooHG01GLnNBAmgK2Wd14Dyxx/Tt3rBDTMtTAX50YGblj/+eU9kqEEX4u3WkDfpCl8XQFTnTxb4KAD3QO1z8KBwwPRTS1MFCjKXJrXLRsIiUasUAq7CFD7pL/TvcSD8QnM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753646467; c=relaxed/simple;
	bh=Qnxxzg3TFev7oYQSrRtV59WVhivLzMLJXc0XjXCxNlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oDpsJ9YIsXELuZzSKw8dV9RhsFuv+fVPv+Vwi19iJtfMJFqoS6gmRLRdMz5vpCCnQG0X4SYZe/2J4jW1XDssHU4Jv6hb+bls7i5jg0qlqanzDC8vKIAEvjG/rQiVrtGXlRo5WVNYZyok9XDU+cmH6lqY72UjMY8Hx7H3+iJY0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CTa8ehkx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LsxiZE5C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753646462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIrgu5wKRNf7iAsgIe656cIacVYchBogqE8UafUxd/A=;
	b=CTa8ehkxKgM+yTJs7GjVyKPeOEXpx6C1/OOqNuCksdKaX7Vv3QRZe+Ak83/jRkf5l5l+RH
	JCj5JmPkgEEuV9JCrz1A4ypjtMmXZdcegbuFyufiQwC8atiPSx2BtYONuB/ya284NCCSma
	z/r9edocDsipCM0TK9Lf2bFr44EdjujG44d6BIDSj/LMMotLQpvLxbh8laKz9Z2G3qtarA
	BQTln5Ez5x7XDfijpcDZLjuor5f7HEB/OLKyTJzJdhG2ouybh6xqQ0xu2v0i6YvnWZgFB2
	6RHwh3sXIFyGL3/JkaadHawWyOJzXuut4usgpwume8wuMaXC/X9z+avtDnOvmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753646462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIrgu5wKRNf7iAsgIe656cIacVYchBogqE8UafUxd/A=;
	b=LsxiZE5CNpMdehpLw0JpbClpZLrE5JSDTOchlD3v9gAVflrKKdoL3dTuym8gE1w/r41iiT
	ICJ5dnQzSNgF5eAg==
To: Yipeng Zou <zouyipeng@huawei.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, sohil.mehta@intel.com, rui.zhang@intel.com,
 arnd@arndb.de, yuntao.wang@linux.dev, linux-kernel@vger.kernel.org
Cc: zouyipeng@huawei.com
Subject: Re: [BUG REPORT] x86/apic: CPU Hang in x86 VM During Kdump
In-Reply-To: <20250604083319.144500-1-zouyipeng@huawei.com>
References: <20250604083319.144500-1-zouyipeng@huawei.com>
Date: Sun, 27 Jul 2025 22:01:00 +0200
Message-ID: <87ecu1pfnn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 04 2025 at 08:33, Yipeng Zou wrote:
> Recently, A issue has been reported that CPU hang in x86 VM.
>
> The CPU halted during Kdump likely due to IPI issues when one CPU was
> rebooting and another was in Kdump:
>
> CPU0			  CPU2
> ========================  ======================
> reboot			  Panic
> machine shutdown	  Kdump
> 			  machine shutdown
> stop other cpus
> 			  stop other cpus
> ...			  ...
> local_irq_disable	  local_irq_disable
> send_IPIs(REBOOT)	  [critical regions]
> [critical regions]	  1) send_IPIs(REBOOT)

After staring more at it, this makes absolutely no sense at all.

stop_other_cpus() does:

	/* Only proceed if this is the first CPU to reach this code */
	old_cpu = -1;
	this_cpu = smp_processor_id();
	if (!atomic_try_cmpxchg(&stopping_cpu, &old_cpu, this_cpu))
		return;

So CPU2 _cannot_ reach the code, which issues the reboot IPIs, because
at that point @stopping_cpu == 0 ergo the cmpxchg() fails.

So what actually happens in this case is:

CPU0			  CPU2
========================  ======================
reboot			  Panic
machine shutdown	  Kdump
			  machine_crash_shutdown()
stop other cpus           local_irq_disable()
try_cmpxchg() succeeds	  stop other cpus
...		          try_cmpxchg() fails	  
send_IPIs(REBOOT)	  --> REBOOT vector becomes pending in IRR
wait timeout

And from there on everything becomes a lottery as CPU0 continues to
execute and CPU2 proceeds and jumps into the crash kernel...

This whole logic is broken...

Nevertheless the patch I sent earlier is definitely making things more
robust, but it won't solve your particular problem.

Thanks,

        tglx





