Return-Path: <linux-kernel+bounces-721013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62941AFC345
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3959F7AC04B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1AB224B04;
	Tue,  8 Jul 2025 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PJRubHV3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IaMNtKzJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235C221FDC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957489; cv=none; b=Qq3qoSwLYOUAvMSsspTWpq3EUchuTRsPgc8rFnUS1ZOo8NIzidp/ZY6nTrZ65N0Jv2Ky99RVALM+WUE3Pki2CRKkK+eEhcfqZOYbYSBN7UgP5CtCJRSGGfnG2JIj8x3jk7p0gx7EAMMsPwhb0c3yhJPB0HPrxYHLoJpAk1z8x7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957489; c=relaxed/simple;
	bh=PLfjNm3poT/pfKPoFgdKwOT2UOWmgK9Z01i+zwU6npI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3ekqlvGcdvOV3aBI/lUq9EIltoAEJJf7FuORu8geHJrIlpUdQtTttfydmyjFaIx7A48GCqsjgvSyDUP5KDb9Q1dxpKWBiq2PKzfhiehvO5TRFpum815VtYP0IplIqdH6MkwMdt7vTkihgSiGqdMZVOuSYtWbNVGwqBJlLxlPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PJRubHV3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IaMNtKzJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 08:51:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751957485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mer2kyNEMt/0U4ldunFN9CzzxmGrd8ltq1fNYekIqfg=;
	b=PJRubHV3zGPPmouIO5pnqMt+usLPL5bBszusoIOz4UrbftfhyxnMsEIXphKmAMBUKaDWg0
	9MNJe+S2U5vY2hDvXJ8/CE3P75NUvOlwc/g0EklN1jyPqnUXg5xE8ObOO3qpLIrSA0jSSY
	sEdPj0S3ke7EJziI0SYX+wXSlDkjNesIIfAHMmodXMArhoW9/6a7puaUmF4+yDO5c2JxKR
	MiolFUcp4YLtsZENCb9QfbBpCER7+A9VJi/DozLp01YdDWM+OYH/UWzY5d0wQXSrajx0xs
	3u42beW1dp8AG/IfjjN8KLkFaEmFGmIU4e7fM90xb+b4bN6ih2TkVkvU2gUkHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751957485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mer2kyNEMt/0U4ldunFN9CzzxmGrd8ltq1fNYekIqfg=;
	b=IaMNtKzJt3PbQB9Sx1UfCay2FfWT19BX9Pre8Pn60/m/+B6a1RAaN5MoCyhBDB4l/+yUZ3
	i202MzwIXi7GdbAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
Message-ID: <20250708065124.DtoAH-O1@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250707143623.70325-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250707143623.70325-3-bigeasy@linutronix.de>

On 2025-07-07 16:36:22 [+0200], To linux-kernel@vger.kernel.org wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> The use of rcuref_t for reference counting introduces a performance bottleneck
> when accessed concurrently by multiple threads during futex operations.

just folded this bit after kernel test robot complained:

diff --git a/include/linux/futex.h b/include/linux/futex.h
index cd773febd497b..9e9750f049805 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -113,7 +113,7 @@ static inline int futex_hash_allocate_default(void)
 	return 0;
 }
 static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
-static inline void futex_mm_init(struct mm_struct *mm) { }
+static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
 
 #endif
 

Sebastian

