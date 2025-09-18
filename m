Return-Path: <linux-kernel+bounces-822286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5CBB83751
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0DC1C82695
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598192F90EA;
	Thu, 18 Sep 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ABqAVqek"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF22F83BC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182827; cv=none; b=Qt85d7Li41Kq1wzKg0onhOtpImI8xKTFvi6D/Dm2dS5rLxB9KzwWt6LRkzE91mYSJOs2w8t2z19ASczF3qTaUIPhIOwKo9rv5Y0WfSmz4SWCmUzlETCXwc9G7ypgiMkPVhvYlqmqFPqdsL0p0Lao7OTzDKGhOekWY0DPbid4Smg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182827; c=relaxed/simple;
	bh=QSNJ+3ImKc9bXFJdImgvqGXc8uHIseP7vI4/WK90R2k=;
	h=Message-ID:Date:From:To:Cc:Subject; b=kHH6JJLUR22BAqKh6mthfeH/p8u3AIuRajQv/0ezFxUaUBSEkSU9BcgA3yhUkhLX6leUAYzdUQ/bcPkUywkZqOjJDAhK444Q+IkADMKqoLUupLm3TY7RdsVdG4ahLG8x4DR9eci5Jaof6q040EglNv8yBy88hoqk+B0vWezWtuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ABqAVqek; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=itnEEd5R+e/p2i5IgI4P9XDj1NQGejk7Uo8rKiES1mY=; b=ABqAVqekY03wp92G6gQbvQnkvG
	M5VeBGgbrvcLC2bmNlNlCb/15Aa9fLXTOu8IVGnNbd9xrA96CBj7qNk47FUbhl6wUGszBYAqJZpJ6
	hL7FZFILdPqfNyph+4CakYXlmqUEPbuN/j34SsjYYT4tSzswYHjPYDenh99kftq2FXCiBmHlT/Ryz
	sHZ4YRdKHjZZgSrhvTm469tceurrjgvOQqfvOtv95Wko1W1Z9Tl/UBEZ2n0Znv9DK16t/VmvUjNmf
	agW/yRsUz+WAtgwv4+HNs5jnEpZmuxrdw9mllV1Z/64UpCWKSdPrNyHxrA1iBeFhvjmltGldX1uIg
	/Zj/qU1Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9fD-00000007Z6K-0USi;
	Thu, 18 Sep 2025 08:06:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 11149300328; Thu, 18 Sep 2025 10:06:46 +0200 (CEST)
Message-ID: <20250918075219.091828500@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 18 Sep 2025 09:52:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: arnd@arndb.de,
 anna-maria@linutronix.de,
 frederic@kernel.org,
 peterz@infradead.org,
 luto@kernel.org,
 mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: [PATCH 0/8] hrtimer/sched: Improve hrtick
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi!

A few patches trying to improve the sched hrtick feature, which is currently
disabled due to overhead.

I wrote these after the last OSPM, but I've been sitting on them because 0-day
is not having a good time with the second to last patch. I've not been able to
reproduce :-(

Anyway, the first few patches should be 'good' and hopefully one of you will
spot my 'obvious' fail in that late patch.

For those of you rocking ARM64 systems, if you pick up the generic entry patches:

  https://lkml.kernel.org/r/20250916082611.2972008-1-ruanjinjie@huawei.com

this late patch should also 'work' (or not as the case might be) for you.

Patches also here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/hrtick


