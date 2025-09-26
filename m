Return-Path: <linux-kernel+bounces-834199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7245FBA42DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467757B007A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E663019D7;
	Fri, 26 Sep 2025 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nbh4TK9K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pckYf6CL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD2301033
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896437; cv=none; b=Ire1V39fl+p+8EpuhQPgVOYVwWGT4dN7yni7dd+W+owtEHdOVCr9ef+zUMGdZJhzAGcYECZeWv9tIFgWl8cZovbA1VbK7fT1MOD8IvvgqV+VAAUiMlmy1WwFFg6Ot7p+r32Mn5T4IPl3tc0DS9lSr8/Q5Nm564lTgCX3ADEei+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896437; c=relaxed/simple;
	bh=/1Mv1gU6xTTVzCsuxMDNlCGRLsirlhBlVGRI9pKPOcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/aBJ+50Rla24l1dMdzBeztZ+oiby2R+nyZECN3Rj83NyQMBmuReesg0M4AcQv/Tn+1KHgsvFBrVBKNUZVTgjNkfXnifgdM3wsTrQ6YfI4BwcWrZIG94LtRZ55xG8dCZ+x4DB8diPcqo4W9AHBifRYVxk8kL+JscNcgkyGTVdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nbh4TK9K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pckYf6CL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Sep 2025 16:20:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758896433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Mv1gU6xTTVzCsuxMDNlCGRLsirlhBlVGRI9pKPOcw=;
	b=Nbh4TK9KxwPZikt7lo9C/So9qEVLLXFgwvOylbw7edAe1WSKs9yvhCs0wMzR/4BWvdJzGj
	9fVQdtLCxkP6sBwu1v23WIO6XWvJ8FdJnH2yfemVIJQ+8CMxBe1sCV66ik7q1JWyhtlUuO
	fDG1mw3bfTKHyGI47fpXlm0WAtlLRY2puUTn7KSSApMzQRh3jHkPZl0TyqoKyQv69ny7yk
	hCDPoCWWgzv8CKVhVnr/y3eh9h5v2uj9uVixqiiFHe5RUS3zoS9wuzz1jG5O0m/eJ5XuPT
	UiSBHgR4sEPflontfLoc6kHmy6/5rwSjcu/jkDN/Wo0k77N+CaGFhLDe6Q7qpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758896433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Mv1gU6xTTVzCsuxMDNlCGRLsirlhBlVGRI9pKPOcw=;
	b=pckYf6CLbgJ2Ni4L9wFfsiLPA2cAj2x5+bipA6HiPZN/7ZLNiIN5ae9Ysmjm7fFIpX3/Xl
	rPMo4UDmg08aLMCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
Message-ID: <20250926142032.3vMasceT@linutronix.de>
References: <20250925-local_lock_internal_fix_shadow-v2-1-d3b85ee775a4@kernel.org>
 <6c49739d-6f2a-4c49-a04b-9774f10a6925@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c49739d-6f2a-4c49-a04b-9774f10a6925@suse.cz>

On 2025-09-26 16:16:56 [+0200], Vlastimil Babka wrote:
> +CC LOCKING PRIMITIVES maintainers. Looks like local_lock files were never
> added to the section, should we?
Yes, indeed. Would you be so kind or do you prefer me doing it?

Sebastian

