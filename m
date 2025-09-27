Return-Path: <linux-kernel+bounces-834949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E54BA5E68
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7CA1B24B25
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51344299ABF;
	Sat, 27 Sep 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8DaUhxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026F2AD25
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758972799; cv=none; b=LE26beByTcyWByn0kQ8N86wo8Q9doPskXULuANXmaHsA9CV9pRWm5FIMT8Lna6k4nd1nyTTLYRLEbcyEdgKDkY/PQLqwE91PvqyS5Lft5RGqJoLh3eAsVKZ5+EIjDTXz2kU2aGi8fIiq8MSsPIRmAfTwH7IqFEJkhxTZCNuyjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758972799; c=relaxed/simple;
	bh=EV6l4ssTVreRKgaeCwma3vj7I/H1BvBiXhlYjPP8VrU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iEqIdoFxR+RXpTfiZdI7aKg8ZGRDOybK2h1gq0/fh2AkH5SRsQ6oQXWYREVNV8W+tjv2Jqmmjy814yFUEoW8WRkvr15hyw0gW3lBoHYGVNT4TMz70NwCZcAAw0CjtB/rOwqtwYOQvHsfbaFLrn3DEwt8S7hq/NVfXNybTY+RpaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8DaUhxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55404C4CEF5;
	Sat, 27 Sep 2025 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758972799;
	bh=EV6l4ssTVreRKgaeCwma3vj7I/H1BvBiXhlYjPP8VrU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=a8DaUhxX04ICAaViM4kNaxJ/PycZRamUHTIwk+gdYgTBn9GKWgWd83AnrlnumSANX
	 FA6AjcyEFeiblNPO/TnViUl/rR7qJoDIdhGaBCsUFnV7HZSnqK21Mh8ZmEfA8RBNvo
	 GtAJmEGnEx+OBF3GW2zpEIck1dFnNdo6YwF3aQAplCjJd6qtSeB3xqeVDfAwdwHzII
	 3nC+KCn4FnQRERmcVblfI/OLCcLkMdzzAwiNb8Rbw9SSP2aih4vJ1kyluJwzCrTVpY
	 xFxGCNGOFdRxJV5yYGj6DNrvOL0C11eCdMsAHiQ0hIbq5u1EG/iOfi+A5GcH2R5xZp
	 0mg+eT57YGBUg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v2TCR-0000000D4N2-41kJ;
	Sat, 27 Sep 2025 07:34:47 -0400
Message-ID: <20250927113447.813602775@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 27 Sep 2025 07:34:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [for-linus][PATCH 1/2] rtla: Fix buffer overflow in actions_parse
References: <20250927113418.080268096@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ivan Pravdin <ipravdin.official@gmail.com>

Currently, tests 3 and 13-22 in tests/timerlat.t fail with error:

    *** buffer overflow detected ***: terminated
    timeout: the monitored command dumped core

The result of running `sudo make check` is

    tests/timerlat.t (Wstat: 0 Tests: 22 Failed: 11)
      Failed tests:  3, 13-22
    Files=3, Tests=34, 140 wallclock secs ( 0.07 usr  0.01 sys + 27.63 cusr
    27.96 csys = 55.67 CPU)
    Result: FAIL

Fix buffer overflow in actions_parse to avoid this error. After this
change, the tests results are

    tests/hwnoise.t ... ok
    tests/osnoise.t ... ok
    tests/timerlat.t .. ok
    All tests successful.
    Files=3, Tests=34, 186 wallclock secs ( 0.06 usr  0.01 sys + 41.10 cusr
    44.38 csys = 85.55 CPU)
    Result: PASS

Link: https://lore.kernel.org/164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com
Fixes: 6ea082b171e0 ("rtla/timerlat: Add action on threshold feature")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/actions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index aaf0808125d7..eab51c0c0ce2 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -131,7 +131,7 @@ actions_parse(struct actions *self, const char *trigger)
 {
 	enum action_type type = ACTION_NONE;
 	char *token;
-	char trigger_c[strlen(trigger)];
+	char trigger_c[strlen(trigger) + 1];
 
 	/* For ACTION_SIGNAL */
 	int signal = 0, pid = 0;
-- 
2.50.1



