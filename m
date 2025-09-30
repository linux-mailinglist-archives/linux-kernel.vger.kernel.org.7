Return-Path: <linux-kernel+bounces-837949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A88BAE1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAE74C1FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9775330BBBC;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPJzoIxU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F53093CA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251686; cv=none; b=mj454+OSPawQGF4H69MIeAoJC4j9pvzfdvVGKNiR/xQAFQLVZvDiNABOFiLCKVCaK+4aOMB4p+DuctB/U/FUz4FxQ1KQLUoYjcbbdzilOwK8ufo5Xi04j50QmrXTwRMIpN7OsoJYdy0LnJu9DP4BV+u0wCG/iBrh/9Vm+s766VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251686; c=relaxed/simple;
	bh=9Has2rbY4I/41mqljMsduhjgNFk0/JrXOnwh9b4Jzv4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LglZiov/Aa+LxHuPJdQhyT5+qrYz9Jv8dMxknq1FVBd9BTNV2rc5YvVzFhmWwi4Awj6VWR/O6pH4O+c/gU/YtajZnvYun8rTsTLcF7WLzBEECm3NaSOOPQe/bI+TXrbnMG+PlCf9n6J4HArW+7XKweHx8e8Jjg3pquhLvv5CqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPJzoIxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09F5C116D0;
	Tue, 30 Sep 2025 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251685;
	bh=9Has2rbY4I/41mqljMsduhjgNFk0/JrXOnwh9b4Jzv4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=XPJzoIxUiBrGX6ypsRSOTtdkHEylNcoJbvJcPsgEdAeS1Yt50+ckEU53G7ukBZyrw
	 JZGIB6WpmkvBx9eHzNqcDwiEAZZRwvc/2COH8hJOMTOpccZW9iNKZSkTBeEra1znpw
	 HLHt91Rrn31MbjZd5vf5E27woaDsEt6aW0TD1Wj6v5FHqJJ3tgjJ7Lh/RquFHvgklk
	 P41/oL6PpQz0GpbI7OQUVkIZsEWd9q6+vGG/L9ZC8UsbeAVNWxbwDXUHUB+3ntemmq
	 c5eBmcf6AqU5FJdKq/K7vKZLYFyMlB8kEMVPeB7IYNkdbcJ0ufQK16zEHqYY2e3Rg4
	 TYzTrurDVpU9Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkj-0000000DIGq-3Yo1;
	Tue, 30 Sep 2025 13:03:01 -0400
Message-ID: <20250930170301.699930470@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:38 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [for-next][PATCH 03/11] tracing: Use vmalloc_array() to improve code
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Qianfeng Rong <rongqianfeng@vivo.com>

Remove array_size() calls and replace vmalloc() with vmalloc_array() in
tracing_map_sort_entries().  vmalloc_array() is optimized better, uses
fewer instructions, and handles overflow more concisely[1].

[1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250817084725.59477-1-rongqianfeng@vivo.com
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/tracing_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 1921ade45be3..7f8da4dab69d 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -1076,7 +1076,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
 	struct tracing_map_sort_entry *sort_entry, **entries;
 	int i, n_entries, ret;
 
-	entries = vmalloc(array_size(sizeof(sort_entry), map->max_elts));
+	entries = vmalloc_array(map->max_elts, sizeof(sort_entry));
 	if (!entries)
 		return -ENOMEM;
 
-- 
2.50.1



