Return-Path: <linux-kernel+bounces-802809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC225B4573A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AF47C2C27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D48345743;
	Fri,  5 Sep 2025 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UTgdZ5z/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="77+3apEG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E913469E3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073997; cv=none; b=N0YC2iPm68GL6aZ3Mu9cP6oSGLcoEzWIkR6upOplBql2rbBkoQo+gsEB1jUx6AMoOWGfHQueMcMO77VYcN3OxxSSXwzfM4knLRFUe5N1AD0O5Q4y/7GjYiqmGKU6D/aTVQKIWcsPjej/UlPfQD1hdmL9Y+RRMRuQAslEoaS7lAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073997; c=relaxed/simple;
	bh=w2t7g+LPsiqIp5sahrpvTmRcIghurl8xWpV86JZrAaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HGymFRDh5bg78e9IJnRiTqJEMHeZKU7OECLRJKPsLh63GYQ3DMPerZnsAsY5SelKCc5iaYxID/hdLevHu144cnoYMAJEekWeCyg2JIusgjM9w8f7sSk4FhoYZIOhrbgMhZgfyft5haaQ2NXvzJG2a2EGEca7KiC094BHIPhuMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UTgdZ5z/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=77+3apEG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757073994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/IKg83dcjcLbooK9HLzU/2x7UUh4CHBt46e2RylSUc=;
	b=UTgdZ5z/PFOOqcO/3gFjsDADo8+OEkAEINqzS7ZWwgYz+f7t1jRfp0lw+plWNqT/XNP4OU
	UrhsPYkmH7+5KrQs7LAyWjG3opbic0lhMkNoG4krXLs2SKyiE8qddo9xK8nefKxfOE8Mzi
	Z3dV1seTGvUfuywX0YU+1YS5GC5zoe+3G8HABd0Vs974mTezbgInOfNgQFFSsSaJfZNSeN
	MGbqFWrZkanS+GRxg9pnn2aKbsvjAModxsvoGnvBRe+fxRAme+5W/YzwLWhVCnDELqmbJ8
	NLlh1z8q7aYWZ12oMpS2KGPXuFzq1F/iQm9XKUvNvfIInngd1S9PJJLN3qcgUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757073994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/IKg83dcjcLbooK9HLzU/2x7UUh4CHBt46e2RylSUc=;
	b=77+3apEGgncoQTjuxUAaUd1A1bYoRpnPWSsj8TnsYGuga0LlNs5oSCXyqMsDENh9gm2YDf
	wQUnqX+vICFHN2Cw==
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Petr Mladek <pmladek@suse.com>, oliver.sang@intel.com
Subject: Re: [linus:master] [printk]  c158834b22:
 WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]swapper_is_trying_to_acquire_lock:at:console_lock_spinning_enable_but_task_is_already_holding_lock:at:__report_bad_irq
In-Reply-To: <202509051142.70d9ca69-lkp@intel.com>
References: <202509051142.70d9ca69-lkp@intel.com>
Date: Fri, 05 Sep 2025 14:12:33 +0206
Message-ID: <84cy85f6ie.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-05, kernel test robot <oliver.sang@intel.com> wrote:
> as we understand, the possible_circular_locking_dependency_detected issue is
> not caused by this commit, but has different Call Trace now.
>
> we just make out report FYI what's the WARNING we observed and how it changes
> in our tests.
>
>
> 97ea9bccfcbe4c97 c158834b223fbfab3a14855ac20
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           6:12           0%           6:12    dmesg.WARNING:possible_circular_locking_dependency_detected
>           1:12          -8%            :12    dmesg.WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]perf_is_trying_to_acquire_lock:at:console_flush_all_but_task_is_already_holding_lock:at:__report_bad_irq
>            :12          17%           2:12    dmesg.WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]perf_is_trying_to_acquire_lock:at:console_lock_spinning_enable_but_task_is_already_holding_lock:at:__report_bad_irq
>           5:12         -42%            :12    dmesg.WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]swapper_is_trying_to_acquire_lock:at:console_flush_all_but_task_is_already_holding_lock:at:__report_bad_irq
>            :12          33%           4:12    dmesg.WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]swapper_is_trying_to_acquire_lock:at:console_lock_spinning_enable_but_task_is_already_holding_lock:at:__report_bad_irq
>
>
> below full report FYI.
>
>
> kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]swapper_is_trying_to_acquire_lock:at:console_lock_spinning_enable_but_task_is_already_holding_lock:at:__report_bad_irq" on:
>
> commit: c158834b223fbfab3a14855ac203b8d9cddbbefd ("printk: nbcon: Use nbcon consoles in console_flush_all()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on      linus/master d69eb204c255c35abd9e8cb621484e8074c75eaa]
> [test failed on linux-next/master 4ac65880ebca1b68495bd8704263b26c050ac010]
>
> in testcase: perf-sanity-tests
> version: 
> with following parameters:
>
> 	perf_compiler: gcc
> 	group: group-01
>
>
>
> config: x86_64-rhel-9.4-bpf
> compiler: gcc-12
> test machine: 20 threads 1 sockets (Commet Lake) with 16G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509051142.70d9ca69-lkp@intel.com
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250905/202509051142.70d9ca69-lkp@intel.com
>
>
> kern  :warn  : [  429.466465] ======================================================
> kern  :warn  : [  429.466466] WARNING: possible circular locking dependency detected
> kern  :warn  : [  429.466467] 6.11.0-rc4-00024-gc158834b223f #1 Not tainted
> kern  :warn  : [  429.466469] ------------------------------------------------------
> kern  :warn  : [  429.466470] swapper/17/0 is trying to acquire lock:
> kern  :warn  : [  429.466472] ffffffff843933c0 (console_owner){-...}-{0:0}, at: console_lock_spinning_enable+0x5b/0x80
> kern  :warn  : [  429.466480] 
>                               but task is already holding lock:
> kern  :warn  : [  429.466480] ffff8881014fe8c0 (&irq_desc_lock_class){-.-.}-{2:2}, at: __report_bad_irq+0x4f/0xe0
> kern  :warn  : [  429.466487] 
>                               which lock already depends on the new lock.
>
> kern  :warn  : [  429.466487] 
>                               the existing dependency chain (in reverse order) is:
> kern  :warn  : [  429.466488] 
>                               -> #2 (&irq_desc_lock_class){-.-.}-{2:2}:
> kern  :warn  : [  429.466492]        __lock_acquire+0x760/0xf10
> kern  :warn  : [  429.466495]        lock_acquire+0x148/0x3e0
> kern  :warn  : [  429.466497]        _raw_spin_lock_irqsave+0x38/0x60
> kern  :warn  : [  429.466500]        __irq_get_desc_lock+0x60/0xc0
> kern  :warn  : [  429.466502]        __disable_irq_nosync+0x6a/0xf0
> kern  :warn  : [  429.466505]        disable_hardirq+0xe/0x70
> kern  :warn  : [  429.466507]        e1000_netpoll+0x10e/0x210
> kern  :warn  : [  429.466511]        netpoll_poll_dev+0x162/0x210
> kern  :warn  : [  429.466515]        __netpoll_send_skb+0x2a0/0x3c0
> kern  :warn  : [  429.466518]        write_msg+0x11e/0x160 [netconsole]
> kern  :warn  : [  429.466524]        console_flush_all+0x534/0x640

There is currently work beging done [0] to convert the netconsole to an
NBCON console. That _should_ resolve the lockdep issues with netconsole.

John Ogness

[0] https://lore.kernel.org/lkml/20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org

