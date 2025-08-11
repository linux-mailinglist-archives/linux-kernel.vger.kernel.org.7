Return-Path: <linux-kernel+bounces-762630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB137B2091F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA9D170F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787661B4257;
	Mon, 11 Aug 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQFR2p/8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eGsukIJw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3033D8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916393; cv=none; b=K6F344X8FRHwaE40lvwaqxkmZQ32kd0HwZEMDXI0CoEv9/WQlR+XDXgRzrRut0e/UyYNzxQJz8+5fmfnaLZyWsMOMWpSdeS9zVyqgGzQDoURMNcOArtCWmB84GegO8th7I68JGPzym7e/4V73Cd7QpnKI0vDiwhQQEnUUNyBOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916393; c=relaxed/simple;
	bh=C2FeR7qDoc5xiDahXSrStKnxkrfrPgbFkj2I5jcxo/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQ5ucF6bUl9cKZ/2SDdBwA7I835RLJuZzyOWY810OaAnTwlF44dkXUDEr+BhJ+Cd0gjsNo7WtReoYWg2+mxzXgNMIetQ/LQbK/du/Ht1QT7ZiIjU+3FR3jQCigUtOdEUkGf4ktQwfn44WI9cRWpOItHBEskMc3QZ9H/wGeQ7g14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UQFR2p/8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eGsukIJw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754916390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DqpoEQwFjSV8iAUWEfhRJvFhbNfTgYBVWg0mSo/qLIk=;
	b=UQFR2p/8CLGFWY7CeFIbuRlFC2ynd+CRojHUe+6VfrllRToOM1qR41WUs643s+iAYVQ86H
	IPjr+vJQbeh+Jhq5aNpZlqJ3GVpIq6XfeHuqBuG0p3Q6qGtmUQropr/2QB2MYU5CFtHXU2
	XBzsNhXlrm9MttzvHOWWS0sjyucaGQvWAI+D6OcRvBWj0jX090khdxRm2pqdNcpvZOgNxK
	KJc2p7LbxiDCs68fhdAZnCPoHJZJBGNx0CDTMp4z54wbecEaCzR11A/t1l8pxk/6gFFKaw
	31xncUms/EftoIrFtuncmogPqmQVSMmzBNCjFOplhePLcjwVgMA2lD4jLGZvhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754916390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DqpoEQwFjSV8iAUWEfhRJvFhbNfTgYBVWg0mSo/qLIk=;
	b=eGsukIJw84aq7tAa3RJJECLPe2be645+Eo2yoK+LolxMBRLRyLwlDh9pEhNIHaUpG/ZM2M
	Kfvjd/77uJwFJiAQ==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf/core: Split out AUX buffer allocation
In-Reply-To: <20250811122824.GA3940894@noisy.programming.kicks-ass.net>
References: <20250811065859.660930338@linutronix.de>
 <20250811070620.590421133@linutronix.de>
 <20250811100403.GE1613200@noisy.programming.kicks-ass.net>
 <20250811122824.GA3940894@noisy.programming.kicks-ass.net>
Date: Mon, 11 Aug 2025 14:46:29 +0200
Message-ID: <87h5ye81qy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 11 2025 at 14:28, Peter Zijlstra wrote:
> On Mon, Aug 11, 2025 at 12:04:04PM +0200, Peter Zijlstra wrote:
>
>> These two aux and rb split out patches seem like they're trying to take
>> too big a step. Let me try and do the same with smaller steps.
>
> Find here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core

Cool. Seems your vacation has refreshed your brains :)

