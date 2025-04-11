Return-Path: <linux-kernel+bounces-600835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06706A8650A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 19:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9917E1BA74D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFD11F236E;
	Fri, 11 Apr 2025 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIalh53d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F121A453;
	Fri, 11 Apr 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393657; cv=none; b=cmP/9FxqcXSBGM8SMkEJoGEn8ab1uVI0SzIMeu9P8m/LUmO0bi/imGThyLNWaVs8VMzsuLSs3Ono4Yddh0l+i13wH4QHz4a8q2DPC3yL+KIHOg7US0+qhYIpUYRfEyQnf0XHIOy7Q5pBuYrq+0GLBS6aEGMtAvn3HvJt7LzU22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393657; c=relaxed/simple;
	bh=bfuy0UA9p/zb6TIf3DftZKynlUpLVsiEOUkLpbyelpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JyzLhfUnG4bIfeCxgJZSwwap2VHi/XjE6bu6C9gYSoFcrxVoQLWI6lCZkIZceoZKxWlJrPkB1MxBJwjmyj3qajExA28O1f3YEpvggQUlN9+OeELbynrLZSBrUozauwTYFYXYmKfdDmHPG6k1MOmz0SrRbu6ss98+L7vWEArYcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIalh53d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C19CC4CEE2;
	Fri, 11 Apr 2025 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744393656;
	bh=bfuy0UA9p/zb6TIf3DftZKynlUpLVsiEOUkLpbyelpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIalh53dUAg4F6cGXsYJmdS2fCHDdNfaKzUbJNHt+gpu7jsUK+d7iK3LPTCbj2kb2
	 /pkmkNj9SV08jHypugGOjGGTVOcMX5rtrsW7XKoBC/rDpruO9MSnjxZ2vA/1BEAs38
	 IOU5jNeRnZT+iTzKfXxiUbMqM6sPSJIIbOa1f+WSUWtMsTB7PPJUlthu3rrJ9Xn/kN
	 P8NDAZe3XUL/Niuk98YS6XMNlX8jV7HhACm+1RXiJA//oKOlwu7JMzJRT3g+b/8OIp
	 Y+OydXVE2f2+XP7miMvfIvZ2a618qjUHNxJjQI2nlE7D2UWaeYb++s3wsAg+q2p6Q2
	 Q2646NXL/7Puw==
From: SeongJae Park <sj@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] MAINTAINERS: Add mmap trace events to MEMORY MAPPING
Date: Fri, 11 Apr 2025 10:47:34 -0700
Message-Id: <20250411174734.51719-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411173328.8172-1-Liam.Howlett@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 13:33:28 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> MEMORY MAPPING does not list the mmap.h trace point file, but does list
> the mmap.c file.  Couple the trace points with the users and authors of
> the trace points for notifications of updates.
> 
> Cc:Andrew Morton <akpm@linux-foundation.org>
> Cc:Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc:Vlastimil Babka <vbabka@suse.cz>
> Cc:Jann Horn <jannh@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Aced-by: SeongJae Park <sj@kernel.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4c7fdc41a6bfb..d8e9a10adc81d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15571,6 +15571,7 @@ L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	include/trace/events/mmap.h

Should mmap_lock.h also be added here?

>  F:	mm/mlock.c
>  F:	mm/mmap.c
>  F:	mm/mprotect.c
> -- 
> 2.43.0


Thanks,
SJ

