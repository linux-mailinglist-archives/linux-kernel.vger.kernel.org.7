Return-Path: <linux-kernel+bounces-831312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD67EB9C544
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886A14A502B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637CE28851C;
	Wed, 24 Sep 2025 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C7ESOV0l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GbWZNqbC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691D263F3C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751857; cv=none; b=rp7RyLwHfrewm1Le4y8eIX5aaMmmV9EX6sZ/hV6YElL6HJ87etvJjptXV+vImHrV+Nehh5UPhjIcyezD3s5LAlQ5YNLlFtW591dBPeVmS0s0iOW7I/MxNZzEYWSDNYg5nzOtL8hrOcdr9D3QCu4vlNxBvrVqNilsdWh0L9X6e1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751857; c=relaxed/simple;
	bh=NLLrhL5n8w8nO/tka+yZq/cDdEQgIgISvLudwwedQhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F0zV00x/sM2d2e/bQ7gbJPIRy7+RYMXMPXiK+WpB6Zkc9G98U0mvDfW+VzE71YfiHt9ltTiaop4RuteDsnGv2CX+3CWQczZv/27a06h2UDI2zmtl0TOTz10UYs496nm+uDDyIws9SE7KGsq05NIloxBCiQs1EdeIAeY7jh0ws2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C7ESOV0l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GbWZNqbC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758751852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLLrhL5n8w8nO/tka+yZq/cDdEQgIgISvLudwwedQhg=;
	b=C7ESOV0lzrO537bRoltLpIUrl4Q8ad+8hb83p5z+7Kw1NKZ5f6VzMiDsEFIa/EZ1mTGhSs
	CGkfkOocTfJRdCSt9sPgkLOH5VN/8sedYf77/YvT2oRkke1N1pYBlu5a9WQ35fL8kaDPYj
	42LkaYezduZJ9Nnuhve6RgfaFSwy4cCOXhNLWxJ9c0jENQdXVMasrZhcET2XpkNcSvKuIs
	PMPYEvbjylWA1LAcRSw5rpqMkCrjh00/z5ETmGj3w/W+tkG/XhqTrICRo0R3WF/jyN+XqY
	C2FvDAojW+S4KS5VYVesmn0h8SzmOjAn73hpcl1UiTbidnegKmD9jHVu0SbTFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758751852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLLrhL5n8w8nO/tka+yZq/cDdEQgIgISvLudwwedQhg=;
	b=GbWZNqbCAoPbDFYepz60OCNZEGtz8aMZMxVnRac9EN/Q8Pd8rAzZrIGeUt2PCdgtgANRdh
	RjNi1xZbMPy7kbBQ==
To: Thorsten Sperber <lists+debian@aero2k.de>, Uwe =?utf-8?Q?Kleine-K?=
 =?utf-8?Q?=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Cc: 1111027@bugs.debian.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0
In-Reply-To: <aac1a607-946e-48c0-a1cf-acc9cff4749e@aero2k.de>
References: <tfwuhg7fxlvb3iix2k4qqh74dcmwgcipprlehy7zlaz3btmtym@2x2vsccw5yzs>
 <2pdp3kq4qebdxizprbnaq6omh4dvxdlktokvr37b7nlkf4po3b@fxzmgmi47wxx>
 <60c824f2-667f-4957-bfe1-145a79e01ac5@aero2k.de> <87bjn14g04.ffs@tglx>
 <aac1a607-946e-48c0-a1cf-acc9cff4749e@aero2k.de>
Date: Thu, 25 Sep 2025 00:10:49 +0200
Message-ID: <875xd74i3a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24 2025 at 19:20, Thorsten Sperber wrote:
> [Mi Sep 24 14:10:21 2025] NMI: IOCK error (debug interrupt?) for reason 7=
1 on CPU 0.
> [Mi Sep 24 14:10:21 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainte=
d 6.12.43+deb13-amd64 #1=C2=A0 Debian 6.12.43-1
> [Mi Sep 24 14:10:21 2025] Hardware name: HP ProLiant MicroServer Gen8, BI=
OS J06 04/04/2019
> [Mi Sep 24 14:10:21 2025] RIP: 0010:intel_idle+0x55/0x90
> [Mi Sep 24 14:10:21 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f=
 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0=
 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 =
a6
> [Mi Sep 24 14:10:21 2025] RSP: 0018:ffffffff9d203e38 EFLAGS: 00000046
> [Mi Sep 24 14:10:21 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX=
: 0000000000000001

That's a MWAIT(C1 Substate 1). Hmmm...

> # cat /proc/cmdline
> BOOT_IMAGE=3D/vmlinuz-6.1.0-40-amd64 root=3D/dev/mapper/thecube--vg-root =
ro quiet intel_iommu=3Doff intel_idle.max_cstate=3D2
>
> # cat /sys/devices/system/cpu/cpuidle/current_driver
> intel_idle
>
> # ls -l /sys/devices/system/cpu/cpu0/cpuidle/
> insgesamt 0
> drwxr-xr-x 2 root root 0 24. Sep 19:14 state0
> drwxr-xr-x 3 root root 0 24. Sep 19:14 state1
> drwxr-xr-x 3 root root 0 24. Sep 19:14 state2
>
> # cat /sys/devices/system/cpu/cpu0/cpuidle/state*/name
> POLL
> C1
> C1E

What's the output for the above on 6.12?

