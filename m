Return-Path: <linux-kernel+bounces-798998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 974CFB425B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05421890ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9192274B26;
	Wed,  3 Sep 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ttzeCoqN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QlXlw+hs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87AC134CF;
	Wed,  3 Sep 2025 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913837; cv=none; b=YGmzrb00h8PmUeUynq1so1eLvsBxh9t4FD2NAeNfzcYpILy763C/3LxB7/13MwZK57sFXfsRLBUObypK3bNhKUOkuTUJWZBbyeTrCBgQWbRNg0LFI49idgwq9PTjxQPZWsHFjx15V4pq9PR3sGO/bD+Xlyth1OWiVkM4B2OAwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913837; c=relaxed/simple;
	bh=WmVAF180mm7X2RZf84Y37C+NTMzn0I5fFOha4nSNJoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Um2PVfP4kTciL8r/Wibe++56CIYbuMWy0vlQlsUzssZ8dEUkbCLeXu6+hHwFGKfmx/ILJDJOqSn6hrc9+EWHabz1XvomApuIZMUTF1r6hvXjnU3+jjf9JOieGYrLE9cx4ifsvn0Y0a+1Ovc+B/JhNo1oEmjRgyTjxPMzr9xpcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ttzeCoqN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QlXlw+hs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756913834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNzaIg8MZ1mGdQure+WIQHJfx+eJSHw9rM+4Nt2SCmc=;
	b=ttzeCoqNGiU87fdGNWO5W5l7KORVW7W+afsUgZmrIqb/sE7gd4G8FiHKhiFnzDmlmUGiBM
	br06cZizz80h1IzD/OhTZztofh4c4cK4+GtENc1dn2blkSzto/SZCiLBDd2T2sEjEQtzjy
	+OgMwTFNQNu8a9KVNFqzrgXcMBWDALGo2DvEDuMfPesGFFjDNMawFLB9eX2C2t3Jrcxfb7
	W6mJ50wqXMCJKcs7izEjFfwG9BTJaNMQymsJcUtcsHcKdAxBLOxnhdw9GfHWRhaJXgD/F4
	lW1vSXnL+9+1DcBlU++JLmLkq+0gGFf/8XOz6hMbhkclwR6Odw2GobnpxlSkEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756913834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNzaIg8MZ1mGdQure+WIQHJfx+eJSHw9rM+4Nt2SCmc=;
	b=QlXlw+hs3uH3aVp94TuA8cExdv2k+ATDloTTq87o3kGm6LAjFDltnQQwIoTmGukmx9blRq
	/N15bPcaQpUAulAQ==
To: Sehee Jeong <sehee1.jeong@samsung.com>, anna-maria@linutronix.de,
 frederic@kernel.org, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 sehee1.jeong@samsung.com
Subject: Re: timers/migration: add 'notmigr' kernel parameter to disable
 timer migration
In-Reply-To: <20250807064849.3988-1-sehee1.jeong@samsung.com>
References: <CGME20250807064855epcas2p3079c241a4da07d478e713021ca488d13@epcas2p3.samsung.com>
 <20250807064849.3988-1-sehee1.jeong@samsung.com>
Date: Wed, 03 Sep 2025 17:37:12 +0200
Message-ID: <87v7lzy2c7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07 2025 at 15:48, Sehee Jeong wrote:
> On heterogeneous systems with big.LITTLE architectures, timer migration
> may cause timers from little cores to run on big cores, or vice versa,
> because core type differences are not taken into account in the current
> timer migration logic.

And what's the reason why this should be done?

> This can be undesirable in systems that require strict power
> management, predictable latency, or core isolation.

Undesirable is not really a technical argument. Can you please describe
the actual problems instead of handwaving?

> This patch does not attempt to solve the structural limitation,

# git grep "This patch" Documentation/process/

> but provides a workaround by introducing an optional early boot parameter:
>
>     notmigr
>
> When specified, timer migration initialization is skipped entirely.

I agree with Frederic that this naming is suboptimal and should be
tmigr=[on/off].

But aside of that, disabling timer migration causes other power related
issues as it keeps timers always CPU local and therefore fails to let
idle CPUs stay truly idle.

So instead of just having a lazy work around and disabling everything,
this should really be addressed properly. Though without a proper
technical problem description, that's pretty much impossible.

Thanks,

        tglx



