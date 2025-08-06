Return-Path: <linux-kernel+bounces-758018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC42B1C9CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0AB57A980C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4102028FFDE;
	Wed,  6 Aug 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xGADWnPR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzx+vfoO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86E1A8F84
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497834; cv=none; b=MocM7msuoizAq6BCHchZxF82wHP7+IJYMtgD5j+eUyi6lnfC/aJ4+9ChXY2Ldom53/UWRZMGZrmt/NAC/PXy2gqNq306S0pUwBO6I+1fRszG4OIHZfsodgavyJIgb6USiKZUWa0rue/bTErw7cqI8i42qHrdg7xfJOXptUhAeDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497834; c=relaxed/simple;
	bh=2+liWGgOB/2u4CAwHU0ubyKHYaX+JHbSaLY5dOTYyQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T2ZrxTDo8kCdRY6q/5wNm4OiLWt7LnXy+UdR5OuYXigAdHVaqSYbr19JF0xKMAm/UFejReEhRaBIxFJtPV8ZCQ1WuRPqvf2EE3tnNLQnK1QkEUoyzIk7QALwjrVrS0Od/95IWNBnFmX9XqtkaoDJXIX8tGTBBADI/BSGYjHXOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xGADWnPR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzx+vfoO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754497831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+liWGgOB/2u4CAwHU0ubyKHYaX+JHbSaLY5dOTYyQQ=;
	b=xGADWnPRZt4G4AtmvAjJHCQGDQ3d1Ja1c1W3qibo+TpuO2Yzmtc+D8LE9DkDIUj/Fskrpg
	Eos1+qQxfUCG/WgIbrAtepG90Y/iF74mPGem6zS3A9BbOtCcHbGm2WT76nBsekG4BI5nku
	buWyYENW5ZDujrCh1juxxmuWtlpCj2eGdiPylr5jcwYmrODlcBArh7IZzz1wvHbSH8ClcN
	QYmRi/eKN1d35/2iQFcIazHDmXHFX4cvaavZ9dUEIT8fcyo/SAj0/Cl50tNsv5q/Gllpnb
	+CR5SchWphUFOcE/IXFzD0J0zlWQyVjZZcFlKAEX3njfSZywWEWYJCY8FdJPLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754497831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+liWGgOB/2u4CAwHU0ubyKHYaX+JHbSaLY5dOTYyQQ=;
	b=kzx+vfoOeByDGlbPoN9mowWYtQjzvwAn29w+/b2cNmcuJ/laQvnOjMhxJlgAu8wt7oyQF7
	mL0YLmymilh8VIAg==
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, bigeasy@linutronix.de,
 kprateek.nayak@amd.com, vineethr@linux.ibm.com,
 prakash.sangappa@oracle.com
Subject: Re: [PATCH V7 00/11] Scheduler time slice extension
In-Reply-To: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
Date: Wed, 06 Aug 2025 18:30:30 +0200
Message-ID: <87tt2kct09.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 16:16, Prakash Sangappa wrote:
> Based on v6.16-rc3.

This is useless. At the point of posting, a massive amount of changes
had been queued for the 6.17 merge window. So why can't you submit
against the relevant tree (tip) as asked for in Documentation?

I'm going to look at it from a conceptual level nevertheless to spare
you the extra round.

