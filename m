Return-Path: <linux-kernel+bounces-761860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7558B1FF5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1911E169466
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D48285CA2;
	Mon, 11 Aug 2025 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N3W5/7Zr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="250Q1gzI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2572600
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893720; cv=none; b=oCy1L9V3scw/LujAGz1UaLDF1LD0aA1fxR8p8aJ7hBk4BMqYMffBanzwaYarqdM/Bk5YvcdVj/6VgAz+DItSFPocpzKRPI4aXVxDLua5W88+i5m3B4NNlh91wZFmxNh8Fee9pfvT+UgGRQt3upQM/Hnmsu3jMpKjVpFQ20uNEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893720; c=relaxed/simple;
	bh=c0trRieowNUfWgu/WVhL4BVS4I3n5IuT1JzKjLFacFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6VbEzCYi2xwxwypEx5g4gtM7fC4SNUCTrxfU6006TDhE+P8kbM2wuT3wyFnrpQRkKGrJFK9KvRplu2tJUqk1vqCVL7xQqHMVxTpvXWHohcgSB/i6DIKBf5isEn5ClxEdx6QBnI8KuOEQKJSz1rmiwld7Oo3K2Flw21mmtbWxjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N3W5/7Zr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=250Q1gzI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Aug 2025 08:28:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754893713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/1Hh81PDwQL9EusN625fIh62pvooQo9vXVZfTgUHSQ=;
	b=N3W5/7Zr2O7cUtLvLAGvwJKSFnF2DJ38+4o2Tb8KN4YpG9K41Ra5VbtkaxdeG5Jgwzd8eG
	d2l48D/Xi95K5+001b/8yNf2BgomKKtYFzBDfgsuDSp5iH5Ry3GpB0lHbtHONP8VMtCv/g
	6pUC3jU53tvZ3HZMkcqSvqoXhF3D/Tr0gjxiBcRzNSf5fBmnM3u+5jGRcuFhSW+rTn4gb4
	EjUBftrCMokUTHz/q9e8v3k9xy7H4CoQYuzkbvXgSDx8T2Tt33v85fbMXcfCPH+7aRxaOY
	d0XtbheQJHIiDkbws36tf1yBYxzjb7TdTD5R+La0FqrFgudMbVd0xfWhFDts6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754893713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/1Hh81PDwQL9EusN625fIh62pvooQo9vXVZfTgUHSQ=;
	b=250Q1gzIgAMnUrBGryMH7D9V5tEHD4wa/zE1s0TtQfH2299kJEnkF5P54nLpP1O9r1lLj2
	E+KHIH00/MoEfiCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"vineethr@linux.ibm.com" <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 01/11] sched: Scheduler time slice extension
Message-ID: <20250811062832.syBOWlHe@linutronix.de>
References: <20250724161625.2360309-2-prakash.sangappa@oracle.com>
 <87ms8cchqf.ffs@tglx>
 <20250807154929.4Wpr6V4N@linutronix.de>
 <BCFBCCEA-8D24-4835-8C28-74D93F5EF38B@oracle.com>
 <20250808095927.cS9gMdhp@linutronix.de>
 <4380C53B-CFF9-48CB-B209-806D4BBC6F56@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4380C53B-CFF9-48CB-B209-806D4BBC6F56@oracle.com>

On 2025-08-08 17:00:27 [+0000], Prakash Sangappa wrote:
> Should we just consider adding a sysctl to to choose if we want to delay if 
> TIF_NEED_RESCHED Is set?

Please don't. Just focus on the LAZY wake up.

> -Prakash

Sebastian

