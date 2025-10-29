Return-Path: <linux-kernel+bounces-875927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3DC1A278
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60AAB350F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3BB3321AA;
	Wed, 29 Oct 2025 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FNjg/KK3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHI1xpu7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F322F6900
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740031; cv=none; b=c1SJXX+H5N1mSDEbOg/g3abxM8CRTIdPCOdtP4VfHXXTM3BQKAlERdddl2Qn02rHGRnfWKd2VdxZ/Xbz7XSK0wtqbaxZv4nWfy3gNpWsvSiWJOqObBPzeZ4LxeSncsX5z2UtKmkETUTHkD4AL53jQNj2d2LA0WoAPtlrQO7MfeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740031; c=relaxed/simple;
	bh=/+GujrSsGiAjLCU1622acqoeslKR4CJn2Yy4gWDqG9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FiV/QOWkYCj0+FPd014nzBWp/zdyvn3Y4P0hiVVAE4lk4M1f2GIDo6RsrvXDgRHE/94VYO0uh5HqKt1uotwTsInPk76sD+LnhEHLpj8jMcDyaoK+rsOFL4eQYv2oDQ66KJ10+I38x24dbTJoY85DoGLBC1ZgGIj9E/4syEE+PpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FNjg/KK3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHI1xpu7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761740027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esT651bRTLMfYO64YXGQAJOBt0V7qx7+gpXmLKe21Vg=;
	b=FNjg/KK3z43CBxdoBj4DiMOs6lEpaVT2c19t+sCcU5AnFVO//ILQqObKmdgVNHei83gaxh
	z9RxPcTXVixWGXfKVv6CO/prEPtQ38fEiG2sZEiHcpNexDuMUHydc8WO/9cVpIn9BMTUOL
	E1PFsRI3MNyAs2jMaXjU5fK1c0LW82/lHXZn3RtxqyT0cxzWpvgypVIYup8sRwglobt4ge
	xe33rDmF8gDrlitIgs7AFwCzwBXaZteHgvLktvsEUkToWNiEx15RjVwQyYIttgB+2sCLP4
	nyV92pk6a+XfkG621JknI8y5xftNJVuiQ+QLKqyqDBbqxWDrP3kqu2ECjGrwxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761740027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esT651bRTLMfYO64YXGQAJOBt0V7qx7+gpXmLKe21Vg=;
	b=GHI1xpu7ATaNuoTDBNyIGte1DBj98hRzidFOeQS/Z6SjdbJBBv14xsj9/Duna/GlphZwf2
	KelyW71TWP5MkEBw==
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Waiman Long
 <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, "Rafael
 J. Wysocki" <rafael.j.wysocki@intel.com>, Joel Granados
 <joel.granados@kernel.org>
Subject: Re: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when
 shutting down nonboot cpus
In-Reply-To: <aQH8KJ8RsnzbLfN2@fedora>
References: <20251022121345.23496-1-piliu@redhat.com>
 <20251022121345.23496-3-piliu@redhat.com> <877bwgw9yf.ffs@tglx>
 <aQAvnjVvJOUx78Nk@fedora> <87qzunuqqo.ffs@tglx> <aQH8KJ8RsnzbLfN2@fedora>
Date: Wed, 29 Oct 2025 13:13:46 +0100
Message-ID: <874irhvrb9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 19:36, Pingfan Liu wrote:
> On Tue, Oct 28, 2025 at 01:59:11PM +0100, Thomas Gleixner wrote:
>> If you freeze stuff there is nothing to do. Hibernation works exactly
>> that way without any magic hacks in a particular scheduling class, no?
>> 
>
> There is a nuance: DL bandwidth represents a commitment, not necessarily
> the actual payload. Even a blocked DL task still occupies DL bandwidth.
> The system's DL bandwidth remains unchanged as long as the CPUs stay
> online, which is the case in hibernation.

No. Hibernation brings the non-boot CPUs down in order to create the
disk image.

Thanks,

        tglx

