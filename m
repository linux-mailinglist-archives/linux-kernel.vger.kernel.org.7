Return-Path: <linux-kernel+bounces-738142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D49DB0B4F8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2657A837B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C6860B8A;
	Sun, 20 Jul 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w7Wu5ruZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e+TrRVpZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107034A23
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008448; cv=none; b=GxBr5+2K6vGJ7DwxIP90UWl6yTwV4i3L6QIb8vk5IorZUfscKT8jFe4qYFatHgjjuyE7OieQfHSk6MB1PDnk8bqdddEoFt2D0WauNTckpYwsp3Zmf8epnPOBZY3IY5xD6tko92/1SxJS2k9yPLpL7Y/6bLsQYlDMAhUH78Zt6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008448; c=relaxed/simple;
	bh=7T4UmPxWF3hSWenvaR7LWVE1ExSGnC3YDZZYQPXcU8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4XimjRmandeIuBWQoD5GlgVIszIKM7qF25TIuCEc9g0TPhGvxi6lsyWKfHIBrEFa4El1D3kpC8vG5ApIX+nvrUYZ5IFTqrP/UcBvnMkzLecESgQhVV32+F1XrbXUMgbFUi8ja65nNHJDodLDLequEjVWHrVcjuMRZUbd1X0uvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w7Wu5ruZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e+TrRVpZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753008445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANWoogU7kBBZFJXWHTAlyNcWlCwd/ZfUPzBFIAyZehI=;
	b=w7Wu5ruZFGwOqp7it3tXXteBEKIWBOprt2uL9Hcl6oPOWrZxZdil4/iAQxHmWBldpzAU3O
	ZQsMpXlddStAxyQ9coVQUam3X2ep1utRzfk1TdWFDkD0lbFb9o4tVkkmx23/GAkFerPOi4
	PgzQxgP+hRMYB10tKvInolgWAfaoe24FFL0TZBjZIG8xRs9wL6PC26GNJefcXlvFR9IyYr
	6O6apjbemjTcR0uzerDrGmqZOWI5c4vwYgn/NVi5FiMiYAAEKU0YATGGiFNEdgWbxlhGh0
	w4PVLiJdLzzuduICJmOebSe19ZS922t8l8quLfzjfucyHniEJQmddXuicOcYPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753008445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANWoogU7kBBZFJXWHTAlyNcWlCwd/ZfUPzBFIAyZehI=;
	b=e+TrRVpZ4Aw3Y0AoXDbJCmp1H6ianIJdnWhcFJHGcPgqnyFhOZ8JxVuyzQrDF+4/WfGCbW
	0icJxHeyKrA9VsAQ==
To: Phil Auld <pauld@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Henning Schild
 <henning.schild@siemens.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Guenter Roeck
 <linux@roeck-us.net>, xenomai@xenomai.org, guocai.he.cn@windriver.com,
 pauld@redhat.com
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
In-Reply-To: <87frervq1o.ffs@tglx>
References: <20190729101349.GX31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net>
 <20190729205059.GA1127@roeck-us.net>
 <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
 <20190816193208.GA29478@roeck-us.net>
 <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
 <20210727100018.19d61165@md1za8fc.ad001.siemens.net>
 <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com> <8734mg92pt.ffs@tglx>
 <20250709134401.GA675435@lorien.usersys.redhat.com> <87frervq1o.ffs@tglx>
Date: Sun, 20 Jul 2025 12:47:24 +0200
Message-ID: <87a54zuojn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 19 2025 at 23:17, Thomas Gleixner wrote:
> On Wed, Jul 09 2025 at 09:44, Phil Auld wrote:
>> Hi Thomas,
>>
>> On Tue, Sep 03, 2024 at 05:27:58PM +0200 Thomas Gleixner wrote:
>>> On Tue, Jul 27 2021 at 10:46, Jan Kiszka wrote:
>>> 
>>> Picking up this dead thread again.
>>
>> Necro-ing this again...
>>
>> I keep getting occasional reports of this case. Unfortunately
>> though, I've never been able to reproduce it myself.
>>
>> Did the below patch ever go anywhere?
>
> Nope. Guocai said it does not work and I have no reproducer either to
> actually look at it deeper and there was further debug data provided.

Obviously:

        no further debug data was provided, so I can only tap in the
        dark.


