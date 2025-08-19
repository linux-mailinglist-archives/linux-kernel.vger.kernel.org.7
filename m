Return-Path: <linux-kernel+bounces-776056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE83FB2C7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10733A548D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3139283141;
	Tue, 19 Aug 2025 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzapx1AA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RhmkHGfQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906552820CE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615670; cv=none; b=RV7Xr2gxr6DtUTURhrThCyi7Wr3gOKfvbKIzdAU6ZTeBDebROdB4nOs9t+4Hp9WXL3IbeSqNlZtmWrHbbXqXLPZOfKbdV9unjE4lCy/oM332VIufkcNgDbjdCPcfIyKCzMicJ3/hjMt8EQUf7MxackPxcX+xnzmSEycUMqpivsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615670; c=relaxed/simple;
	bh=jGEY3EnOBXun4SQ0ll/o32z1qo0qZY8iGqdHqyf5ANY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrfunUcnwEWcBMkpdOSnJA13WNFuQEMDv+tzAaimWV/9aKkXZcPVjnOVU7tlBbtBKy7EtX5Un8kb3+lHvtBmiGdddhOJAve05//iwfRCsTcQOXMRZuCiXbX5YMx7s1NKL1w+FPSEAgxUJteGBD+eisBj+Z6KOFJnHg3PHeudi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzapx1AA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RhmkHGfQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 17:01:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755615666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hYf3QFb0JiRzAbtPuQzxzkHoV2M9phfTa2ZdhDggos=;
	b=kzapx1AAcR/HPJ39aWX+tVOWN6MnRU0okwgYpB21DR6ZE9pZORJX/aiCWQrvv4VhCzVp0c
	3wbDbXBpUw6Nj/OcMHieNLshKeiaUV2F17tgJVdO4RoC9vce/OU+0bOMo/Z5t6XLx8BUTQ
	J0mnP/7PIeLrOxRjmnnsJv9FcHQ8g7pkFa+8+2hGuX8+D4ZHAuYYomfsKyzxac1RDqX9t9
	bfMarcltQ3kIlkC+miaJdHR+ji2UAG3YX4MBrDB2bA/VVIqgo6kfJk7tF5yI6Pg+mCmuU3
	Hvb+Mmg5XgE4YrI7WfdQaYdSzG5jPa4jlK5IM3jMWbLnW+KaorYsazSYpgG+hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755615666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hYf3QFb0JiRzAbtPuQzxzkHoV2M9phfTa2ZdhDggos=;
	b=RhmkHGfQPxVDamkMwkJHH0HrCo+psPt8q1j0uMKOI1dI9VD8Zd4Q/nIw7QkPv33s6jb1f5
	yoCt6ux+PFvZ6oDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <20250819150105.DYeV89fa@linutronix.de>
References: <20250812143930.22RBn5BW@linutronix.de>
 <20250812145359.QMcaYh9g@linutronix.de>
 <aJuYStGVBjyfVmZM@slm.duckdns.org>
 <20250813063311.33m0TDKl@linutronix.de>
 <aJzT7rqwkRQrLGqo@slm.duckdns.org>
 <20250818125242.vJ4wGk20@linutronix.de>
 <aKNlshZmWsHVXBo0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKNlshZmWsHVXBo0@slm.duckdns.org>

On 2025-08-18 07:41:06 [-1000], Tejun Heo wrote:
> Hello,
Hi Tejun,

> I see. Can I backtrack? If it doesn't require too invasive changes, let's
> just keep the two in sync. I'll get back to conversions so that we can
> actually achieve the goal eventually and it'll probably be more confusing if
> we revert that and try to redo it later.

Okay. Then let me repost the tasklet patch and make one for workqueue to
stay in sync.
I do hope that we end up with a requirement that any kind of teardown
does not happen from an atomic context ;)

> Thanks.
> 

Sebastian

