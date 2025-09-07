Return-Path: <linux-kernel+bounces-804607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49533B47A63
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C52164A72
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B9A23B61A;
	Sun,  7 Sep 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPoWLiy6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080710E3
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239675; cv=none; b=OlUglME0HoD4bAJ2XuiwkKwizOQM7+WEl8nTybvq3mdxnfrPRzbhzPdxzzPw8rgBAKqlnZNDVOwvLGYipAkndDmAhQXe2SYbny0ggLGcIZ9nGnLi27jqxEVviC2+Ac9gq0VzLf1IAyv4lLuXvC1jfpdPEiswAGYOuUJBhyWj6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239675; c=relaxed/simple;
	bh=YYA1hHA61Rww//FQgwGiqUrf0stJ8khL61s7dCvBzxc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QRzQZQ1ZHU7PD7tXeJLWAwvPqRSJqy8kag/asnGAD6Rv6JyBMI6Ia4GvOuHR+b7ViJFtvqs1PGma9XanoaQTgq9fJVfr4wp7XqXDndhGbYzVd49JDNDe0Vf9r0D/m2sVDg1Tw17jrjqVjc2i85wlsBhn6Ie9MA44lu7dKNTftpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPoWLiy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DA3C4CEF0;
	Sun,  7 Sep 2025 10:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757239674;
	bh=YYA1hHA61Rww//FQgwGiqUrf0stJ8khL61s7dCvBzxc=;
	h=Date:From:To:Cc:Subject:From;
	b=sPoWLiy6NbkAAUTsnhFHQnESqqf89lcma/bnaz4zIFckPXcKfPMWgFmKu3qHAjSkl
	 Z7yZylwpcsRLdNtf0PUtb7ID8R9CtDddqQ8Ulf+b1KJj7mQckfxOytf6UtwUHS47Li
	 Ghvn4/Q14AkYbysC8MjVBAFTSUA3xucGGKxFCp2/l82ej0xyzRxRDXxJscRZjtlbO7
	 qpXH3DZafnPpIumkM8QEJFxpbzfAQ9C3/TwAYkliG5ecE42ShcF17iU2HIsQXUgt37
	 XckKbwq60a0KpICOOWcT+W74Gd6cE0Byy0AS+KeRSwYyHOTtYyg7cDNm6b04LLTuJD
	 ov55NHcfr8Jiw==
Date: Sun, 7 Sep 2025 12:07:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] perf events fix
Message-ID: <aL1ZdR3wSzsHSngc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-09-07

   # HEAD: 18dbcbfabfffc4a5d3ea10290c5ad27f22b0d240 perf: Fix the POLL_HUP delivery breakage

Fix regression where PERF_EVENT_IOC_REFRESH counters
miss a PMU-stop.

 Thanks,

	Ingo

------------------>
Kan Liang (1):
      perf: Fix the POLL_HUP delivery breakage


 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

