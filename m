Return-Path: <linux-kernel+bounces-873793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8AC14BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2C8E4E5B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD39A330B1C;
	Tue, 28 Oct 2025 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NE7okjrh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O66dcqLc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE52E540C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656358; cv=none; b=H7JNMOZZqUNM0PsUAiimJDnvtMrGlnh0yUWCg8ND/SbhHXD097Zk9d1z4zRPoDle2GIHAlZ6ZiExw4G9NwWl9NEeA7Wd4K0RGsGSGGaIZShve6gYkSZ1OgwcAs0Xlpl6yUQ59x8PNWpBnJD0Kgs1SAnUW9ji4USYS7lOJq41Mrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656358; c=relaxed/simple;
	bh=AwkQtituwoqJVBz3LGUua0hN38Hc5KZuAmLhRrMQIaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hqn3Kzcm1ihrsVFtjF54Iw5gG9KZmiGA9qt/d2QPyAUm5X+HOcPvz+yfJ0B4bdKuahtPsUV//l+faxgjP6ykAQMPVbbJ9iVOpi7/uzWGnl8mVIGaTzYi3s6NQDpRyYe+CahpQTdfozyLV034/Cqp8H1ysUCJryhMwfrrXU+UAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NE7okjrh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O66dcqLc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761656352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qv3GohWqQgrGHwaxj2d2Xaf/EkkHHeIVB+/xSV7yFv4=;
	b=NE7okjrhYT+Phe6z31Nw+rc4ReQOJbVOhEpDE0z7KFgiM3Q/3cN/zek9aIeCo9gGbJyX1y
	M671Iw2qv7qi0MON7KLZwUOZ4cdId0WZ4M+ZFIzoLHPMGkqKg1TCfV5Q73lhXEZ+bFI05v
	ZG6b+y7VoJfXX8OIuowC6DaTFd2R64VkaaTYrzEWfyfVDHKIytM0z+oUWbawWDu5GkVfj8
	+XaFEcHKI0p/bAHWnBVxH6dRoDRvZA3uFm0qZktS9YQl3Vdwmd/5rZOYXSB7c9BDQ4Rg0u
	7XJz0ljMHA71Uz+Zxv6/yctqaAjEuQJtKO2xcvKv50oJZJtbBMbClt8samzpCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761656352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qv3GohWqQgrGHwaxj2d2Xaf/EkkHHeIVB+/xSV7yFv4=;
	b=O66dcqLcRsfw63bXuc/kWIr3HD97R+qJW70ShL4pAweT0heNzZ124tHYRZqer8Z4SUGdP/
	WElduijmtsTraaAQ==
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
In-Reply-To: <aQAvnjVvJOUx78Nk@fedora>
References: <20251022121345.23496-1-piliu@redhat.com>
 <20251022121345.23496-3-piliu@redhat.com> <877bwgw9yf.ffs@tglx>
 <aQAvnjVvJOUx78Nk@fedora>
Date: Tue, 28 Oct 2025 13:59:11 +0100
Message-ID: <87qzunuqqo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 28 2025 at 10:51, Pingfan Liu wrote:
> On Mon, Oct 27, 2025 at 06:06:32PM +0100, Thomas Gleixner wrote:
>> When kexec() is in progress, then running user space tasks at all is a
>> completely pointless exercise.
>> 
>> So the obvious solution to the problem is to freeze all user space tasks
>
> I agree, but what about a less intrusive approach? Simply stopping the 
> DL tasks should suffice, as everything works correctly without them.

What's intrusive about that? Task freezing exists already.

> I have a draft patch ready. Let's discuss it and go from there.
>
>> when kexec() is invoked. No horrible hacks in the deadline scheduler and
>> elsewhere required to make that work. No?
>
> To clarify, skipping the dl_bw_deactivate() validation is necessary 
> because it prevents CPU hot-removal.

If you freeze stuff there is nothing to do. Hibernation works exactly
that way without any magic hacks in a particular scheduling class, no?

Thanks,

        tglx

