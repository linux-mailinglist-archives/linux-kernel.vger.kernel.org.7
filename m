Return-Path: <linux-kernel+bounces-890529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFFEC40442
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B645E3BF8E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D9F328613;
	Fri,  7 Nov 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GoVsAifI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aysBlnuh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89932860C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524764; cv=none; b=Jmk8iG1S4kmFykWiaP+Hd5oZBLUrgW8kzitlVhrO+IN2qcX2I0x66idxvLLE6Olwi+Rwxzm69dWrhimMjg8SwsQeUWOEgYmgkYuUhvWClwnRaZoXCynvpouInFAXLowqPE2g7N/RgagJHzBDpFDIzAlmmQGmcBOYcN6vmHPao5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524764; c=relaxed/simple;
	bh=poW/FQRtm5skMre/YQWMsYeJLlPUvJNqjKkGiIbFDQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gFUj+VAAJmui5tZVoRoCDAWGDSqHLZCxRoU0jozssF3QrBJAzOAf5INlB7EO/3hObUe4vY7TOwp67AJkPPzUum4a0kOw+ggatRi+Kw8eZwluMqWGPTtj+tTcsS3OK8p/bQHeTShjU2kjpmXeQQ6h+6XUamSZKMwk1v/Jz9NgYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GoVsAifI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aysBlnuh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762524761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=poW/FQRtm5skMre/YQWMsYeJLlPUvJNqjKkGiIbFDQQ=;
	b=GoVsAifIl1lmF864bwfQsxf/9NdtEH+eSU+kMZOZV4o/jkmyR+QAK647m54AwdSBfkvOvI
	pHqsYUt0BTjtvCgVeYIRhFo8dAJGBUDQsVx2mjK5537kpikK7JGkHjX/DfSsvJ3Da+LzO9
	wvSDCnEqpQ3Ckj43YBSdbOTsW7HSuLC0J7v5I8nyrtlwMVLD7uisl4T3KsSkSvJb1kJZC6
	eap4Pc3kB7xSuDXRTQUUZ9bdF2exXQcA+YBeBANKOOK5mctYN7exWiIixmxq4y2yc0kAJF
	NLFjnu/L1eUYcpL8o+bXm4P+9AD580RoCdq+1dg922kgMxI7f0LtA48IBbC/EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762524761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=poW/FQRtm5skMre/YQWMsYeJLlPUvJNqjKkGiIbFDQQ=;
	b=aysBlnuhrllZ7bawVXjW7TFUi9AEERvf6uVulfDdePFwffID938k44JEy34mVVUUCOsD7Z
	wDYrGO8zONjHmsAQ==
To: Petr Mladek <pmladek@suse.com>, Breno Leitao <leitao@debian.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mike Galbraith <efault@gmx.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/1] printk: nbcon: Allow unsafe
 write_atomic() for panic
In-Reply-To: <aQ36lc7bq2J5X3zd@pathway.suse.cz>
References: <20251027161212.334219-1-john.ogness@linutronix.de>
 <20251027161212.334219-2-john.ogness@linutronix.de>
 <aQN-NeWzlxtWDLXF@pathway.suse.cz> <87346z5u1l.fsf@jogness.linutronix.de>
 <ofk6hbiz4wjux6k4zdlsfglvxeszlxl4at232wcbvlovwjix4i@7e6wfdsf66pj>
 <aQ36lc7bq2J5X3zd@pathway.suse.cz>
Date: Fri, 07 Nov 2025 15:18:40 +0106
Message-ID: <87y0oiylrb.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-07, Petr Mladek <pmladek@suse.com> wrote:
>> I would prefer you do it through the printk tree for 6.19 and I use it
>> in the next releae (6.20).
>
> OK, I have just committed the patch into printk/linux.git,
> branch rework/write_atomic-unsafe. It is intended for 6.19 merge window.

Thanks for fixing it up the patch for the kdb series.

John

