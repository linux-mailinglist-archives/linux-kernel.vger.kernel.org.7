Return-Path: <linux-kernel+bounces-749140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A541B14A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B9F16A292
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C37285C82;
	Tue, 29 Jul 2025 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMyMvVTP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5JKJpRuf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F8277CB4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779629; cv=none; b=SWIVGxaipw18TgUTBsp5MsELFZ5CtvytVkypFncMh8dg8Jc0x1zQyZN/htYqw7z2k6lg/JMtRYlBB4jQpkv+7Aka4zRjzDfbOCITfWCiA8RTtfSWD7UYXft7lA1jklmf3CRX7kjNK6lPg6blWkrKSi1WflFwLBzAgdMES6/eSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779629; c=relaxed/simple;
	bh=Fh+8DU/QfwuIYe8LD1HI8Np8hZ74Acyqw5/XYtt1QUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKFPtd10hoLhaSQxAsVotd8J8pDotqQVrKfWFb9cQNF5x93/WL5oEO2ZmMKfgsm8+XEhi17InH8XHWvKpP5te4RAWoLckj9NwtVm005TXIGca//6+nAsrB797lJBZMhfNJPhvdcSp2VaH1b3TOO8DYLPqtvyt1WeU85eSCaSJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMyMvVTP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5JKJpRuf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753779626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CX4W5QkxCdXByqaCr2R/kMgej9ZJj6AktAx0GRoAqsM=;
	b=CMyMvVTPU1N6/hGlT2rUi2BTIAAKQBFqiLBqvJy0unwg3TVRt4l+cqkIdPZ9Qdo5yIA0VM
	wtATMc3ipJAqxN7du/VIb07I3FmeIIcvNTtC/2uXasyCcDxmp7i6sOJoHQBfHmp4P1bxG5
	JltQA9at+YQxU0HKXb7f9FcEXKDgLmn05VJUjtucky/uncgCZtRj0DSYKqig49dENX/57r
	wPX41r9EHTjCTAF2Z3lOjkDgSAyqwj2RlvSULRoLrq2NQB2pdQyWFh0cCvCLf+DBad+kYv
	pVEjL2DSXXgwKQEVxY4VOqpgcpFREn6a2c/d//myX+rn67P6XfVd/uLMu/Y43Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753779626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CX4W5QkxCdXByqaCr2R/kMgej9ZJj6AktAx0GRoAqsM=;
	b=5JKJpRufA/npjsqY2Pe2cIdWKr/e+0oWaGGgTZDuajXTbtyIe6P2OrlsGvPxgg53jQZu0t
	5E2SaqsYOF/Y2sAA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] timers/clocksource for v6.17-rc1
In-Reply-To: <175365568847.581055.10274659151998359690.tglx@xen13>
References: <175365567943.581055.6806236199247802443.tglx@xen13>
 <175365568847.581055.10274659151998359690.tglx@xen13>
Date: Tue, 29 Jul 2025 11:00:26 +0200
Message-ID: <87o6t3nzh1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 28 2025 at 00:38, Thomas Gleixner wrote:
> please pull the latest timers/clocksource branch from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-clocksource-2025-07-27
>
> up to:  85198c87e484: clocksource/drivers/exynos_mct: Fix section mismatch from the module conversion

Can you please ignore this one as there is a late regression report
vs. the module conversion. I'll queue the reverts and send an updated
pull request.

Thanks,

        tglx

