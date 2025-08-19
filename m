Return-Path: <linux-kernel+bounces-775845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B991FB2C5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E897218899AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826962EE5FB;
	Tue, 19 Aug 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKrNFRx7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zCz/KGuM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5952EB85F;
	Tue, 19 Aug 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610113; cv=none; b=om6cSmugHNO13fPqT3ytj7d3aZD6FG86RtWw5JIzKj3BDdmIqlbQGM715epx8uf3OpgMQLvWNIDIS2cd8Etm6JFO2ov2OO2m1wR9CwRDNGP6gThkyICm556DjuS2lBVUhA9g+dWWcRn5jC657QcrXmsCipRKgDZAzmqYl0d4ZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610113; c=relaxed/simple;
	bh=RQATp4q8jFSO/nmbkZjjBdQ3HZnpt8k+/cI/Qypg7A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZYbw47FESF1htn4a5I7McZVu21ijO4F5zEdRIFz7OxvErgEfeu6t0Leyrs7A2oXzQyFGwEhvX+AJAJk/y2ZlJvTwb413LOt01pBKldUCA9mnCKlqiaKL2UFEjdJP5FgBL7WH/IhPQdACUeh2K5Qb6N1iakP7oZbO5WMcHBJSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKrNFRx7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zCz/KGuM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 15:28:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755610110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MeXOzsendUxuQ4IuOIM8nX/knNlVduf4YW9hRvOfMWY=;
	b=PKrNFRx7mebJvQkvNY7IhhNBfL+pizKLl9j0idYE+GaSRQ1OtdQCjGT1F3J4MZxrF2vPhM
	xiS9txEXxhz5uWEfRUiDjcCOhMRnuMXjgJfNAbCTN4I/vLtJzV+I3UPIP7pchQHFvHyNBn
	A36R1KrgCFImwWaL6lIAri1w26vcz4LpHVjitznWbLV3GEib9jePxl5MaY/ggFMa+FYKOw
	ed0RdMkktOq5JMUD/iPjFP+Pa3L/Vca6A0fBkNPiZtzknAkHwMm0Eq6TnGDLkS+P2PcNWs
	qnUxnJ5/TadZzfIu4DQBoQEqXQxKD3XSuhgg6ggU2v9Iv+6z7F40hpxTcJr12A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755610110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MeXOzsendUxuQ4IuOIM8nX/knNlVduf4YW9hRvOfMWY=;
	b=zCz/KGuMJ9apTB+DTRyUBQmNsM4Eeu0ivIDayRVotRLdI200Dss1hvjZ9I2i1J2GbbTITI
	0WnKtWbVf2yHRKDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 3/3] Documentation: Add real-time to core-api
Message-ID: <20250819132828.cs64VMsW@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-4-bigeasy@linutronix.de>
 <87seho8v12.fsf@trenco.lwn.net>
 <20250819080358.H9R_64I7@linutronix.de>
 <87ldnfv46n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldnfv46n.fsf@trenco.lwn.net>

On 2025-08-19 07:20:16 [-0600], Jonathan Corbet wrote:
> > Right now this is it. Do you update the text above as suggested or do
> > you want me to resend it?
> 
> I can apply it and make that tweak if you like, yes, no need to resend
> for that.

That would be lovely. Waiman did find something in 2/3 so there will be
either two tweaks or I resend it once Waiman is fine with it.

> Thanks,
> 
> jon

Sebastian

