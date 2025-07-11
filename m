Return-Path: <linux-kernel+bounces-727565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F76B01C23
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1AB3AB230
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A87F299923;
	Fri, 11 Jul 2025 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GTGBrRL3"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0E4A24
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237335; cv=none; b=NDFVtXAi1M4HD0mI7QzRegZpG+sgtIqE0loGU+hFRNkiELM+zDUjlL+zkB6Y1j6ZRGRPe2CKK1XS5f8sfq0335HFC99OqtYA75YQ171hPtQg+wNbUKoBnBe1oJPf101YEcwtHl//oJnzF9t+fJ/0FUpXiJt2qQkHjdtXxjHUlxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237335; c=relaxed/simple;
	bh=jmRJ33IE2Qv/GH/hve7cV/8UXJj8qwfKyo/rT5fCKfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4j6clG4FLGP2dIkhLTZxZEBZHVhK1BSubMAoK3dtZ2dHh0FqYLcnnDR3tr1IeeKRz0Lvc0T8bvkzvH93lS80LrgFCqWkOaNyRv7QQIRxquAyMPPwx9aK6VSN4+6GqzCeFHYIf/JMiQ3DoDIsJjIL71yaaOt18neomV9tUXOC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GTGBrRL3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6tBgnPJMJcxvlxrAraEdhRqVQKdzKwAYFq/XnOvTPsU=; b=GTGBrRL3WmUGLlpDI2o0STCtRc
	apLQKxy6CLVMzJNP+M3OtE4zbIWeszGhv1nPG+LRIBhNngMa6UtictVBNe4nIl2CW0PdNoKFuv+QY
	iWiJIZRXK1EIO/mHbzfEPXulDBH73W7LNau6usMHMiUiQIcfLhH9ZbYkqJyS/qxgElmFCSk7zIBAA
	e5Tt2pYQNtLvFHFm657fY9FBN9a0vniWVf4S/vG2VrP5LXHJSlZVRwtYjI3BfQg1aiUYK+ydC68QW
	Jr75LxKieMbNcLLSWfsEpqPvO5vliqciZdja2iCsMzWcFymIkAZNc+XSMjnXOPEt9siAt/FokKp3p
	GoQ8CysA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaCyJ-00000009G9O-3veH;
	Fri, 11 Jul 2025 12:35:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 76A373001AA; Fri, 11 Jul 2025 14:35:23 +0200 (CEST)
Date: Fri, 11 Jul 2025 14:35:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Li Chen <me@linux.beauty>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	linux-kernel@vger.kernel.org, Li Chen <chenl311@chinatelecom.cn>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v5 3/4] x86/smpboot: moves x86_topology to static
 initialize and truncate
Message-ID: <20250711123523.GC905792@noisy.programming.kicks-ass.net>
References: <20250710105715.66594-1-me@linux.beauty>
 <20250710105715.66594-4-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710105715.66594-4-me@linux.beauty>

On Thu, Jul 10, 2025 at 06:57:09PM +0800, Li Chen wrote:

> +		memset(&x86_topology[pkgdom], 0, sizeof(x86_topology[pkgdom]));

$ git grep "memset(&\([^,]*\), 0, sizeof(\1))" | wc -l
6439
$ git grep "memset(\([^,]*\), 0, sizeof(\*\1))" | wc -l
3319

But we don't have anything like:

#define zero_ref(var) memset(&(var), 0, sizeof(var))
#define zero_ptr(ptr) memset((ptr), 0, sizeof(*(ptr)))

Oh well..

