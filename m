Return-Path: <linux-kernel+bounces-742924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D1B0F84B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FF57B537D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2691F9F70;
	Wed, 23 Jul 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzIBhGMb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442281E8324
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288852; cv=none; b=uruY+SxcGD/t6NUaW+eK2qfg8J/E6Pxzc3tGadEgaMiP2M+wQoFU4sMbwv7xkAP1ts+UcyQdwKX0qiDRrK4MhH4LMhQDkFhXQWM9Gh4xMFJJEk1xiioKAdAhycSUD4t0vPCrr5l75GfQZLy8By2Yl8CPgaxylLGuJ08L9S97W+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288852; c=relaxed/simple;
	bh=Auza1QfgDYIIjPng+zcAw/jNQE78QKsRUuMw9J4B8to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRn23axWoitl3UfNuORYU93yVnEeM+re61L5BXK4J6fbkEE1Qt4H1PXee1908OIB8dHoII/B49/oKyI1caghKCjakhLbaj5nVoq3dKU0VQKtHwdP8zYSK4voDtr2tOuBobc8uGhWLZcQTI3NYCfBiqrwvkVVjFewLh8czh4lvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzIBhGMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D8EC4CEE7;
	Wed, 23 Jul 2025 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753288851;
	bh=Auza1QfgDYIIjPng+zcAw/jNQE78QKsRUuMw9J4B8to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzIBhGMbYljKtA7nMaS8S0cxqwmbDHpDOE3ADmJM6rqnN4HTHKkQkdAPDpM3L65tr
	 cEiHMeb+cT+Xhqd4JzpisYcd6DzIkSWVXJaXxkSynCRzcjO5T/9GDYKRGLG5AJSXQB
	 yXUp1SF+4tOBO+aqnWQ9k5IiVw5gsuh34KVe07NZGY9WGl2iPRuZmcGkF3neSK7rc/
	 ggrgyX7jS0tTQiphRlJSAhD+aWozWWovaupscFugTGfzPhVrOtj7PZxr8Gqb36nqo1
	 yDgULRzDrzOvE6jRQ/Of++FXiDsTmD8Xf/4KsVY1rOrY2AZVqiC/Z+yxagRXyMnARq
	 ycBW64+wI3Cqg==
From: SeongJae Park <sj@kernel.org>
To: Xuanye Liu <liuqiye2025@163.com>
Cc: SeongJae Park <sj@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: Add process info to bad rss-counter warning
Date: Wed, 23 Jul 2025 09:40:49 -0700
Message-Id: <20250723164049.6490-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723100901.1909683-1-liuqiye2025@163.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Jul 2025 18:09:00 +0800 Xuanye Liu <liuqiye2025@163.com> wrote:

> Enhance the debugging information in check_mm() by including the
> process name and PID when reporting bad rss-counter states. This
> helps identify which process is associated with the memory accounting
> issue.
> 
> Signed-off-by: Xuanye Liu <liuqiye2025@163.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

