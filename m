Return-Path: <linux-kernel+bounces-796188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392FCB3FD09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34023A558E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974F82F3C15;
	Tue,  2 Sep 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0VnCVdC0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XIyDwmlW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF880145355
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810362; cv=none; b=KiNHlfBqrZnX9srGq8dGuVlxAJqCCYHf8yA8jzxtLv4I2ZvDx7utk+jKUsyXD4SyW8xFvME8TRFZEHbslPP59xFaYYYt3r2ASTvZGg7HIXRbfYktP8loEHWnYp5jeUIom3aOZ5L/AQK+QfL2dzTt/wOxgES7oopdg9eI6CIPsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810362; c=relaxed/simple;
	bh=q1vBjZpuXBRx1O5MdCs7fZZzXldF+XnBB1LspypyKKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KMz7Uro/I2NJjOQcngBWL0JapcGUuyiqmUm9J0vo9e6EL3Q3IdVfCfSNEumSb1htYgNVAc6nLudExUEwC9z66MvoE6M1fnbcAsW6QQlX+CcMwMfbuBKgXyKE6IhTpBbpb8GJvGM9K91qQWGJaQ/uahjKWO2G8iAg8VNey9l8EdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0VnCVdC0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XIyDwmlW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756810359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bMJmfqvFyy+iMjlsEXM1T/zdFCArF7GdodLlr0nVrKU=;
	b=0VnCVdC0JyOreFu3txAY0etBQuxWxqRKTml8V+HWZEfTivRGtfFAO8jyd2nk7S39L9FdTw
	eL7/H4lQ3qZ60YSatsK7ZDZuTo8aIdWlu0QD2M/acFEEj2mxc2I7yB0/lcHOKGQkvQW8tC
	jXvXWxSfE9sWzlbUxwpMdZ/4JOAbcqARmnBEFFRcSZsfISFlz0lVLbJBNhp8PUiClaLslb
	SM5DxiOUcKx5+eyAcMol5z1K9Y6x4sPfkDOtYZoxYGQUeyl7VGSj2TO9/mRkEkGEW3mU1l
	DmKISSVy04TQg1UMApxvGZH6EKU4K3bbQslG737hdkgkh6tlrVF0me982/g39Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756810359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bMJmfqvFyy+iMjlsEXM1T/zdFCArF7GdodLlr0nVrKU=;
	b=XIyDwmlWNe7CWetzkBNJuLOoe+yzWUJhvHWqY5hbemAT0PYJda/K2pkJDjL8GWh8CYVXgS
	hb0U7dSgaUriFgDQ==
To: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc: Llillian@star-ark.net, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
 anna-maria@linutronix.de, bigeasy@linutronix.de, catalin.marinas@arm.com,
 chenhuacai@kernel.org, francesco@valla.it, frederic@kernel.org,
 guoweikang.kernel@gmail.com, jstultz@google.com, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, maz@kernel.org, mingo@kernel.org, pmladek@suse.com,
 rrangel@chromium.org, sboyd@kernel.org, urezki@gmail.com, v-singh1@ti.com,
 will@kernel.org, Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Subject: Re: [RFC PATCH] time: introduce BOOT_TIME_TRACKER and minimal boot
 timestamp
In-Reply-To: <20250902070253.936687-1-kaiwan.billimoria@gmail.com>
References: <871pp14pkr.ffs@tglx>
 <20250902070253.936687-1-kaiwan.billimoria@gmail.com>
Date: Tue, 02 Sep 2025 12:52:37 +0200
Message-ID: <87a53d2kju.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 02 2025 at 12:32, Kaiwan N. Billimoria wrote:
> So, just confirming: here 1409443611 divided by 200 MHz gives us 7.047218055s
> since boot, and thus the actual timestamp here is that plus 0.000001s yes?
> (Over 7s here? yes, it's just that I haven't yet setup U-Boot properly for uSD
> card boot, thus am manually loading commands in U-Boot to boot up, that's all).

Looks about right.

> A question (perhaps very stupid): will the hwcnt - the output of the read() -
> be guaranteed to be (close to) the number of increments since processor
> power-up (or reset)? Meaning, it's simply a hardware feature and agnostic to
> what code the core was executing (ROM/BL/kernel), yes?

Under the assumption that nothing on the way resets the counter.

Thanks

        tglx

