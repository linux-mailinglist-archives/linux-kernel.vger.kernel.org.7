Return-Path: <linux-kernel+bounces-834951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D486CBA5E6E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBD3A8D79
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817972DF703;
	Sat, 27 Sep 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyRHngFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07FA27A11A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758972800; cv=none; b=Ls9uoBJjb9r6ZX4POavcSI/hws6PWXYDQXDCnbJh4Gv7KuAjDGagX5/izmSiAjytrVg2zg43ANfGr8eqA0D53rVQhZuwbbQDQLeNJgwK5LqsJzdvejc2ZFLOWSTlf6T8wy/ve19ELe5cXC6d0s7dPqTsZhLhTNkSDz3yZwhd3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758972800; c=relaxed/simple;
	bh=g5K2fc+p1otK8OE0GTAix+46jLdstd86YFQIdSdInAQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dJpe6+KltBqSUL3MRMr7lwCH3X5CpORp6uUXgN1frYgdoGP1wCHJ/I6d4vWifRan7O6HbmbicP/4RXp4Ax27PZDEdA8UPP1FzusxUsnDFCLEzSZqrrzCQ4hXISY9th4BSIq/E5ru7DU8cjjJ90AC7BMq5phEuVvkRmwfyNzr+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyRHngFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69103C113D0;
	Sat, 27 Sep 2025 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758972799;
	bh=g5K2fc+p1otK8OE0GTAix+46jLdstd86YFQIdSdInAQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=jyRHngFoN1TNKjrEP0eCuMcbr1gjPxsLsgMnd12zAj/w27fDjipOXVgFovhDYqKcU
	 o1e3ihe562PI8SWn2ripnQ2og8Z0Ykud/GuYKEal2ccKX5tTap3KIMRyx9rJYjIsbY
	 V1R3N3QUvwCBVla2dNCmk6bK3KC91I4Ropu2KydV7fHzOLTZIV8wHchpIlNvNeMDzV
	 wy7BkmijFkY8qNA+5sTq7IkDOqPTiTmugWA8LQ4+zh1Wzyg5w1ptcYxzZ5Ql2PUEKw
	 uGdofbHOravEzIREfESBypZtZpf2CQ0h69dxuThQjirCB0vylnC75M3ZyYAH+kvU5m
	 56Kt11zjmhc9A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v2TCS-0000000D4NY-0Wbt;
	Sat, 27 Sep 2025 07:34:48 -0400
Message-ID: <20250927113447.981063678@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 27 Sep 2025 07:34:20 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Chang Yin <cyin@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Wander Lairson Costa <wander@redhat.com>
Subject: [for-linus][PATCH 2/2] rtla/actions: Fix condition for buffer reallocation
References: <20250927113418.080268096@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Wander Lairson Costa <wander@redhat.com>

The condition to check if the actions buffer needs to be resized was
incorrect. The check `self->size >= self->len` would evaluate to
true on almost every call to `actions_new()`, causing the buffer to
be reallocated unnecessarily each time an action was added.

Fix the condition to `self->len >= self.size`, ensuring
that the buffer is only resized when it is actually full.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250915181101.52513-1-wander@redhat.com
Fixes: 6ea082b171e00 ("rtla/timerlat: Add action on threshold feature")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/actions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index eab51c0c0ce2..13ff1934d47c 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -49,7 +49,7 @@ actions_destroy(struct actions *self)
 static struct action *
 actions_new(struct actions *self)
 {
-	if (self->size >= self->len) {
+	if (self->len >= self->size) {
 		self->size *= 2;
 		self->list = realloc(self->list, self->size * sizeof(struct action));
 	}
-- 
2.50.1



