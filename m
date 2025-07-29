Return-Path: <linux-kernel+bounces-749129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966FB14A78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10907AD6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA736285C92;
	Tue, 29 Jul 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nCaHUcdK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ahVrBH8+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD527E04F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779204; cv=none; b=Uo9G3K6Bxtht/NMD2ktWMF4ZZKfoirnC4FZ30g9T9zsrwmoHlde4J4e7q0RbgU/tbE9UYPXjTw9O5rh+v/nSk8zpi+oMVgvgBodKaCJU/hwroG1ndYkYcEkDsHlnGvtlyh3L6CnN++cjPzbV7OH+alm93VkZn22qdELlsu1+5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779204; c=relaxed/simple;
	bh=kcunrLwKW3+Cyy+EkXPz0UdOdH9oXcgabm37NXP1zsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQA1uorlm2r3hCIGFB3EVUaDl8yxEtO96Tj6i4MLWc2KyZFVe4i+GUpK9OwGrKBfxAVnQQ678mO4RDUKhfw/yjm5zdTgIIvI6xm2xRogz4OlukJKXUX0PNGQks3Pm7NZP87Ym5QToeiQbb55G8FV1d8Cy71Z40/WbErgInNv6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nCaHUcdK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ahVrBH8+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753779200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lRQOr/YVtMtv09gApfsn4UVzkLLUbuZZhG3yNy8T49c=;
	b=nCaHUcdK6QvrJD0l1CHiZBttddtmqSdFk3OAaJ/BhXmcQmESBDFuFjdd6YTFbZhe2tWTAo
	9HOqloREadqoChYcrCA9Ks1NlUJUSAylFpkVcvOFCKFHul5IicMWZQri60GmtT9OWaz7qy
	3411sqLhFXmeOJXYBaHNiXR/we72MPC9Yt3x8FNYZhDMbYFpqrlLTkJ0JP8oRgls4SzokO
	RpJqPp8E1zqo+GDu0kBuNL6N8TG/cMVGEbYecfh9veFY5ieTz/DY4nc1qaNDPd8CmpYUgN
	ngWkhKIZWpKpow2HUFNmI8LBM+1yQLQEM5LvfK053uy7vfpIcyN11Ig0Mzm/aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753779200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lRQOr/YVtMtv09gApfsn4UVzkLLUbuZZhG3yNy8T49c=;
	b=ahVrBH8+xRG4ng6Njk9WqQnoAl8ukB1Gx2Qj30Yr3dzQrtoyPk5x+t+hQSWjsYpAjGWudp
	UeLYTy9Fs2ZE2vAA==
To: Yipeng Zou <zouyipeng@huawei.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, sohil.mehta@intel.com, rui.zhang@intel.com,
 arnd@arndb.de, yuntao.wang@linux.dev, linux-kernel@vger.kernel.org
Cc: zouyipeng@huawei.com
Subject: Re: [BUG REPORT] x86/apic: CPU Hang in x86 VM During Kdump
In-Reply-To: <87ecu1pfnn.ffs@tglx>
References: <20250604083319.144500-1-zouyipeng@huawei.com>
 <87ecu1pfnn.ffs@tglx>
Date: Tue, 29 Jul 2025 10:53:20 +0200
Message-ID: <87tt2vnzsv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jul 27 2025 at 22:01, Thomas Gleixner wrote:

> On Wed, Jun 04 2025 at 08:33, Yipeng Zou wrote:
>> Recently, A issue has been reported that CPU hang in x86 VM.
>>
>> The CPU halted during Kdump likely due to IPI issues when one CPU was
>> rebooting and another was in Kdump:
>>
>> CPU0			  CPU2
>> ========================  ======================
>> reboot			  Panic
>> machine shutdown	  Kdump
>> 			  machine shutdown
>> stop other cpus
>> 			  stop other cpus
>> ...			  ...
>> local_irq_disable	  local_irq_disable
>> send_IPIs(REBOOT)	  [critical regions]
>> [critical regions]	  1) send_IPIs(REBOOT)
>
> After staring more at it, this makes absolutely no sense at all.
>
> stop_other_cpus() does:
>
> 	/* Only proceed if this is the first CPU to reach this code */
> 	old_cpu = -1;
> 	this_cpu = smp_processor_id();
> 	if (!atomic_try_cmpxchg(&stopping_cpu, &old_cpu, this_cpu))
> 		return;
>
> So CPU2 _cannot_ reach the code, which issues the reboot IPIs, because
> at that point @stopping_cpu == 0 ergo the cmpxchg() fails.
>
> So what actually happens in this case is:
>
> CPU0			  CPU2
> ========================  ======================
> reboot			  Panic
> machine shutdown	  Kdump
> 			  machine_crash_shutdown()
> stop other cpus           local_irq_disable()
> try_cmpxchg() succeeds	  stop other cpus
> ...		          try_cmpxchg() fails	  
> send_IPIs(REBOOT)	  --> REBOOT vector becomes pending in IRR
> wait timeout

But looking even deeper. machine_crash_shutdown() does not end up in
stop_other_cpus() at all. It immediately uses the NMI shutdown. There
are still a few inconsistencies in that code, but they are not really
critical.

So the actual scenario is:

CPU0			  CPU2
========================  ======================
reboot			  Panic
machine shutdown	  Kdump
			  machine_crash_shutdown()
stop other cpus           
send_IPIs(REBOOT)	  --> REBOOT vector becomes pending in IRR
wait timeout
                          send NMI stop
NMI -> CPU stop
                          jump to crash kernel

So the patch I gave you should handle the reboot vector pending in IRR
gracefully. Can you please give it a try?

Thanks,

        tglx

