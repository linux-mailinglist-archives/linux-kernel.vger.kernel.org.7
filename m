Return-Path: <linux-kernel+bounces-762597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 904A2B208D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B56118A2BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906342D3A7B;
	Mon, 11 Aug 2025 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="31zwd9Ks";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="anFxzXQ3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC732BF3CF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915557; cv=none; b=FkVsYWFJQCGAQtQn8kV2QWiDhUy6gcra4lOJKuj+BmLHqNfseBX0K2hZDXp543qCSjAlGBEvhOnZXm0Qprs9EsyTRuN92Q3taW3pA0IkgKWUQETvVWhV77wMIoXBb0tIUZLU5gzQk8Nyskr609E0YpsI32ZybPq1y8qdgFU+DJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915557; c=relaxed/simple;
	bh=BcHZoyUeKc+W11zxVCq+/szDO4ZSZRp9auz0igD3wEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=unCwOwBeK8VOJxQRPqlMpZaQ2qFYA7OTWYNizwsziWMpy0fKI8RoxJgz65qPKjVwNu8FKx99m75m3MSX2wnI5TCfENNs5avIOLpwT4/v2MWfw8xZi2H/N0tiNaw25Ikr2LRycCaC+o6wDIxiBCCuKE4TV3rJ18xH+8HQKYz0yDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=31zwd9Ks; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=anFxzXQ3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754915554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcHZoyUeKc+W11zxVCq+/szDO4ZSZRp9auz0igD3wEM=;
	b=31zwd9KsbZOGJ6tmHT0T1RT2QUu592WSoV9NAsEeN5vARtKc4LCXh8nkP5Mzyl4psgVUgn
	IRHaVw0tvCZhx2b55EKyBlsKz7n/fwpbwYg0FrJM989wjT+SxpZ+ab5651sMby8X0CK401
	EeJHgSGRxsCqGMQUk1/gqFT1+p8oyPtyDWXlOpS045w3eU1w7MQm5kDTMwpyZJZaBQ7u+/
	a3kePMp5+3pJ6MmCb8Zq69N/0dswL1uZBXIkNIGyy6zDlAoAJDGSj0kkodzr+kqTz+AX2L
	+y9Kp8l0rgof3E3iXUgtlvUnar7Z/Kfz4pq9kOCP60+yT0RopnMIcAnz0obT/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754915554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcHZoyUeKc+W11zxVCq+/szDO4ZSZRp9auz0igD3wEM=;
	b=anFxzXQ3t5LXGlhv+9SoAFkkDyLYmOy5AuECn6dk5flhh9MNNa2lIK99pCd3a38vV3AkCy
	NGt/MEj8dSvTqEDw==
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf: Convert mmap() related reference counts
 to refcount_t
In-Reply-To: <bb8e896f-7385-47c5-97a6-bb80ea5ea153@lucifer.local>
References: <20250811065859.660930338@linutronix.de>
 <bb8e896f-7385-47c5-97a6-bb80ea5ea153@lucifer.local>
Date: Mon, 11 Aug 2025 14:32:32 +0200
Message-ID: <87ldnqavj3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 11 2025 at 09:02, Lorenzo Stoakes wrote:
> I think a script went haywire here with 'm@/6', would you mind resending?
> Otherwise it'll be hard for to figure out which is which.

It wasn't the script. I fat fingered the template and the script did not
complain...

