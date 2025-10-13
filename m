Return-Path: <linux-kernel+bounces-851209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 980FEBD5C73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C6BF4E8EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976912D73BB;
	Mon, 13 Oct 2025 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qR916Pxm"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A95274B3D;
	Mon, 13 Oct 2025 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381417; cv=none; b=RJRluwF/3WYU9jY+CQyzj3OI+5op3VSF0uvbPcowt359qFBXLH76wEV6ahgohSmEjIMKZK8DHPgdIiFb3jg9m+JwEColE6x5Y6iWJANdV+wXgzEsO+x2Uh+Eldkw9S1NYtVK5VV8Tn68isOLsajRrXoQqFA2uZj5CHyXPUmT3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381417; c=relaxed/simple;
	bh=VXmZ5ZfIXOn+RgbPzDAc1stdByMSkxJIiXfm16qdYqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzXdjpLSR3wYQFU8x/lfDS0ojI5dDpQi2ayERTTuC8ipzTMMRxFGzMWl13AflEpQRIpWkjY9x0Rblviq+C1b6o1rrAJHuGIt6QFKbeGU0/1A/W3LR7pTkFgzahcVWkHEHWYIIyYfofxpbd8sRGpiX935PQSFyNhgXYaT7adFdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qR916Pxm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xW8Kh7VoLr5YIHWzuHhFeh5y0zlryAn2HPSOZx3ZInc=; b=qR916PxmFV0fyMlxPmXQ4zRh2u
	M83rn/wQIJtJJBOTcj+hkd/6ZtdnGAUcTQC+eIL9TL2UUzjddAhAVUI5jUn+Cq5gdvvlO76e9b+sD
	kPxpen72ZLCUHQ0Sv35q2rew+o8jMguH9hwIkLRf+4KJabZmULxtk13zE28JEMMBTUf2ihUIE5ws1
	stX4RYqpBnJEzrUkNALB1VTb1w2LrI1zRaY4qcPig+aAUZ+AoZaP5wlK5Xjq2Ohdz3nhGnMAqGiis
	lc0gHQn1TH3FcqOBpLHN7juRkN2lk+wkL5YzjKcDtTYLljp9W1Q2tRDtY1E1kRfGm+2w6pTQIvkpz
	1x7TSM7w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Ncb-00000004Z2i-02O7;
	Mon, 13 Oct 2025 18:50:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E9E7E300212; Mon, 13 Oct 2025 20:50:11 +0200 (CEST)
Date: Mon, 13 Oct 2025 20:50:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [tip:x86/core 1/1] vmlinux.o: warning: objtool:
 rcar_pcie_probe+0x13e: no-cfi indirect call!
Message-ID: <20251013185011.GA2734756@noisy.programming.kicks-ass.net>
References: <202510092124.O2IX0Jek-lkp@intel.com>
 <20251010032001.GA3741500@ax162>
 <20251010071032.GE4067720@noisy.programming.kicks-ass.net>
 <20251010074446.GE4068168@noisy.programming.kicks-ass.net>
 <20251010223012.GA3597090@ax162>
 <20251013082629.GH4067720@noisy.programming.kicks-ass.net>
 <20251013183059.GA690226@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013183059.GA690226@ax162>

On Mon, Oct 13, 2025 at 11:30:59AM -0700, Nathan Chancellor wrote:

> Is there any way for objtool to detect these instances and emit a
> slightly differently worded message? Figured it was worth asking ;)

Objtool doesn't really do value tracking, but I'll see if I can hack
something together.

That is, as long as its always:

  xor %r11, %r11
  cs call __x86_indirect_thunk_r11

without any instructions in between, it should be relatively straight
forward. But the moment there can be anything in between we need to
track the value of r11 back from the call or something.

