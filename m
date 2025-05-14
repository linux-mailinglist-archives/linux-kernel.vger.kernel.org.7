Return-Path: <linux-kernel+bounces-647258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD6AB6645
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 10:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A187AB672
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 08:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24882220F5A;
	Wed, 14 May 2025 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ymh9rx9S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94562206BD
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212224; cv=none; b=WcfXHrSf4jdtHQSumdtAwX5s4JrmdojBabDm0C7XAN2JrG+nzRyRLmtHV2FNrLXBRDP9jYlTWICj0k58li96JCucONoRCOdL9Qy3T/bwj8L3b0w0YG/0qMd5zY+s4B/L34Y1o0NWrSIopcZaMZg+GO2GR5Z/AKexULW2P3KDKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212224; c=relaxed/simple;
	bh=aa0yBCj5Uc8ViLkWVXhe6sm0SudMlPvZVxqhayesnFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXfhbk0GxeA4ghIPOqMeBc+WTslsh51UO41yOq6DJqi6FoVct8RTeMZ4pe5hH00V7gbnlafr0L8Tf7wIWSv5RXKGyoLisIP0WZLnCx2ehVHq9rIJ9tpPUxtTbnrUKj+JMxunH1MtOOeir1h+sKXvLvut1+1Oqe+RZaJH7fGVk8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ymh9rx9S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747212220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUYsFBJRChIzXZJ15VUeSQZOoGnGxm1gqR07l2fP+ss=;
	b=Ymh9rx9SIBd03JBqqHnqJDw2g6y5n/4Bbl6pQs2QSnFoH87huHxfVc6pPENf3aHiy2HWZD
	sf82ceC5TNplWivq2ceWw6OB4wtCsKsh9wOfQ7eq0uSoJ/JE+MkE1cHM1IvXcWJmf3/iBG
	1BMfRFuVCrNRp5J/USCOco7JNmRe2FE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-IP33Z__RPF6xpFXiY0taPA-1; Wed,
 14 May 2025 04:43:37 -0400
X-MC-Unique: IP33Z__RPF6xpFXiY0taPA-1
X-Mimecast-MFC-AGG-ID: IP33Z__RPF6xpFXiY0taPA_1747212216
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 463C318004A7;
	Wed, 14 May 2025 08:43:36 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.189])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C705A1945CB4;
	Wed, 14 May 2025 08:43:31 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>
Subject: [RFC PATCH v2 02/12] tools/rv: Stop gracefully also on SIGTERM
Date: Wed, 14 May 2025 10:43:04 +0200
Message-ID: <20250514084314.57976-3-gmonaco@redhat.com>
In-Reply-To: <20250514084314.57976-1-gmonaco@redhat.com>
References: <20250514084314.57976-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Currently the userspace RV tool starts a monitor and waits for the user
to press Ctrl-C (SIGINT) to terminate and stop the monitor.
This doesn't account for a scenario where a user starts RV in background
and simply kills it (SIGTERM unless the user specifies differently).
E.g.:
 # rv mon wip &
 # kill %

Would terminate RV without stopping the monitor and next RV executions
won't start correctly.

Register the signal handler used for SIGINT also to SIGTERM.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/rv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index 239de054d1e0..b8fe24a87d97 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -191,6 +191,7 @@ int main(int argc, char **argv)
 		 * and exit.
 		 */
 		signal(SIGINT, stop_rv);
+		signal(SIGTERM, stop_rv);
 
 		rv_mon(argc - 1, &argv[1]);
 	}
-- 
2.49.0


