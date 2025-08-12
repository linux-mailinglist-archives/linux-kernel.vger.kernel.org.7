Return-Path: <linux-kernel+bounces-764586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C913B224DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6BD2A1F52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9272ED160;
	Tue, 12 Aug 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NLjOiDKm"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393BE2EBDDB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995576; cv=none; b=KdCXIBxd3ZSkICXvZ9TiZKjbPKeZQ6KduQkjeZKoDG5WJ84+R6FxpaBGFnDgcj9ipIYBSjWk460HDiOBJvZ/fS9Mg8bNzLJcAQi9KzOtuDtjETQejnXRCrdNh6y+Hfn6RZuU/oWK+HRyoqhAtEqJ/m6pSfugqlMAVTnTjAqw1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995576; c=relaxed/simple;
	bh=PM4jUX+zZ7A7IWFrTvNVOXHJAi9C8swb5W7WUWdagxw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=dr5MKKIBMXgcc4KfDBQ2i/oaGKDeZ9g77gPmFd3OdT5W0gXBx+xX9S48SARY9XzN0Bib4JRm0m0bT0pEKs+z2d18sQiKaPkMRH9FLM9Q70CP1IkNGA1kmMLBITRkks8BwcRTRVqOS4ZLZvaaWzOKNCsxz3X5rH78nDhg37v/UUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NLjOiDKm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wCVT7WhCnMUBoOwmgnFv27TiS/TwEeJYEUWceLjD4w8=; b=NLjOiDKmzbVdMQ2b6UZTKpOnWY
	7w0POMYiW/eFCJWTewaWYxS7BY/kaFE+7/lslNQWfu5BzoWsgsGS0DZLV9ZFqaiJvnDYV5fAjw2Sy
	v/5y8vG9R+4Ir++O5uhuYrrA0WT3aNGoiSpgw/VlHB5KyE8Z7vmVHfzrY/re+AiOoVxTVDm6wVU+8
	HvZasPISQPYY4QLCYdu+maS7op0dA9ejAOHIk+V0viZGwiVfy5XYICjO1vNt1RK0nHSey3oqxnZhE
	QWmOaGJtzTkNLtvewirbrFZo+wjiBaE8DblwidMpRhVixUWG/7vb82P+24M+c9iBrYZF+p831OjpO
	lySrt1Dg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWA-0000000Fmjw-1fz6;
	Tue, 12 Aug 2025 10:46:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8889B30033D; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812103858.234850285@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:38:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 00/15] perf: Convert mmap() related reference counts to refcount_t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Took over the series from Thomas; much thanks to him for cleaning this up.

The recently fixed reference count leaks could have been detected by using
refcount_t and refcount_t would have mitigated the potential overflow at
least.

It turned out that converting the code as is does not work as the
allocation code ends up doing a refcount_inc() for the first allocation,
which causes refcount_t sanity checks to emit a UAF warning.

The reason is that the code is sharing functionality at the wrong level and
ends up being overly complicated for no reason. That's what inevitable led
to the refcount leak problems.

Address this by splitting the ringbuffer and the AUX buffer mapping and
allocation parts out into seperate functions, which handle the reference
counts in a sane way.

That not only simplifies the code and makes it halfways comprehensible, but
also allows to convert the mmap() related reference counts to refcount_t.

It survives lightweight testing with perf and passes the perf/mmap
selftest.

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core

---
v2: https://lkml.kernel.org/r/20250811123458.050061356@linutronix.de

Changes vs v2:
 - replaced patches 4,5 with fine grained steps


