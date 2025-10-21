Return-Path: <linux-kernel+bounces-862090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16104BF4687
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AF224E7428
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF292773C6;
	Tue, 21 Oct 2025 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgixvuCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFEC1E868;
	Tue, 21 Oct 2025 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015317; cv=none; b=YARomu/e2Y6WZWMA/rk4eaE52cHl3lrU2GU3nspJUmcDi1yTg5/rOJ/+/xtobg9FYTjq7wT1bwunJUOszQFM3xcyHPw+shYzoQltpyz9F17d+so8gStsXEuhaDpKUPnchWafwqnmj1ijv8hBd80i4jEAoAGm/nsSDEyLG/GXL94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015317; c=relaxed/simple;
	bh=vbYD+kETAiJfEcOI6cCNkdml0J8v/v8cpCFgqCTJ81M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G9xuFMAEZH5J9/vxYnevYoYtMlz/RMznLXlOwSzdjyTKwXIXO4nBd2NCxBRrf7lyLy7b+kAVDGkpd7NM5mZsC7fg/BvnauiMAUlNHwFOsz27j+BrZkbL+x425ZSEqSSdz59z7fQL1NwGcLv4r4BIGOQ2Rfi6vtzlnKsS+DpuGuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgixvuCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2CDC116C6;
	Tue, 21 Oct 2025 02:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761015316;
	bh=vbYD+kETAiJfEcOI6cCNkdml0J8v/v8cpCFgqCTJ81M=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=DgixvuCjn/AJ3eCjTcDw+7UK3P9/3b0ApKAYt4mgxbdTKdWIHQFkt35schxa9TdAT
	 eaQB+DmIAGcq9VoEAI26pAt4IpxuYsWv8g5k306IoiAfJXXir1WdtgFrIeas1xZqp3
	 dMvcuvf4J62uXC166MRC4wFs0hV4jZSw6EFxpqU2dRjOFiy8554lRqx1TODO34Lnlq
	 N4cMBKSgWTBMP+uot/Z7qcB22ejkeUBt6qJKDZp/b5B7ZnAhQtkHY05V8h7x/tZWRO
	 6ortCu9A3ni3GAXNnJPMXFGxILHAtxtJUiVRuAXw6c3S4HmP0Wp88p2Jcpd5TaQl8M
	 0bPq1/Cj7rViA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20251017230357.15663-1-irogers@google.com>
References: <20251017230357.15663-1-irogers@google.com>
Subject: Re: [PATCH v2] perf parse-events: Make X modifier more respectful
 of groups
Message-Id: <176101531311.244304.14298928719214046994.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 11:55:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 17 Oct 2025 16:03:57 -0700, Ian Rogers wrote:

> Events with an X modifier were reordered within a group, for example
> slots was made the leader in:
> ```
> $ perf record -e '{cpu/mem-stores/ppu,cpu/slots/uX}' -- sleep 1
> ```
> 
> Fix by making `dont_regroup` evsels always use their index for
> sorting. Make the cur_leader, when fixing the groups, be that of
> `dont_regroup` evsel so that the `dont_regroup` evsel doesn't become a
> leader.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


