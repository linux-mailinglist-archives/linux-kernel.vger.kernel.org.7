Return-Path: <linux-kernel+bounces-788346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69394B38337
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88FB162444
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D75A35208F;
	Wed, 27 Aug 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1GVufiW/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6spmfgn4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34534A301
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299624; cv=none; b=L+YSSqTUuf3r/PFQOFI6cOC/7cnT6g6qkFmvw0Vp7aZbbhRtZmwKLo1AXrKpP7YmUyjN9ziB7kW8SbK+iI0xC30kV8mWwNdTFz2MlAiDlWpDs0i9kko1PtT2VgsGiTSMNq5bwulGBURxu851v4eRiFF+dMemnCb2kNvK9AHSiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299624; c=relaxed/simple;
	bh=Wj1y8gn/J0QHpIMqAcP/x+ZIF0m6lF8e4xaVbfhkM5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muD4qc2nGCmdWf5VdoVMPcarXVB8Tg8ieNnNEM8IumSXmTKPCkjMSh0ixJgmtF7612iuXO7BlEwx0beRjNzTG64Nx5VCpxiKqtAwcVwO1XvaMwXZesF5PIbs8iTK6PNH3Dxh0cauWrfAOKEyki19/sCAEOGlY28Tt256/owx/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1GVufiW/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6spmfgn4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756299619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OU4TYMbx3gnkGTLvEmo9Pz0rBoJv4uu7FvjyzQJmjk=;
	b=1GVufiW/0uNd5E+xG1zNYW3jNY7QXvBUh0U1uvYxNDzB85O0e3MtW4JOm577iplrnek/Rj
	C+7Im9V75o4/TTyZ/bNe23APVBU0c6vMzN7IQTGTVpAAE8XP3VvWduURZNELf3OW8wNsKS
	8xpxnrN5kfI7HjBkGjNXHsEUZJTK7MMzGsi64TyJekJOBqHeX1mBai5BsidB8/uS5wHP0i
	x+aLFwDgW8wBZXfd8KARtOn6tnDORc7M2yMr4HExQNw8aRW3xlJerRpirl67Uo+3C+w+4N
	413eEFjItNF7rKWpjVKk+Ww6rGtS7mTjcvICymUzKZ9b5FsIozogps6oNrxbHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756299619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OU4TYMbx3gnkGTLvEmo9Pz0rBoJv4uu7FvjyzQJmjk=;
	b=6spmfgn4KO4eAZsZSXgvG95twh2q9edNhNFHuqowKMQUhEHjYOalyxeUC78h4PHXx71fsM
	5OgZwjk8hvPQEnDA==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/5] selftests/futex: Remove the -g parameter from futex_priv_hash
Date: Wed, 27 Aug 2025 15:00:07 +0200
Message-ID: <20250827130011.677600-2-bigeasy@linutronix.de>
In-Reply-To: <20250827130011.677600-1-bigeasy@linutronix.de>
References: <20250827130011.677600-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The -g parameter was meant to the test the immutable global hash instead
the private hash which has been made immutable. The global hash is
tested as part at the end of the regular test. The immutable private
hash been removed.

Remove last traces of the immutable private hash.

Fixes: 16adc7f136dc1 ("selftests/futex: Remove support for IMMUTABLE")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 1 -
 tools/testing/selftests/futex/functional/run.sh            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/t=
ools/testing/selftests/futex/functional/futex_priv_hash.c
index aea001ac49460..ec032faca6a91 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -132,7 +132,6 @@ static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
 	printf("  -c    Use color\n");
-	printf("  -g    Test global hash instead intead local immutable \n");
 	printf("  -h    Display this help message\n");
 	printf("  -v L  Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
 	       VQUIET, VCRITICAL, VINFO);
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testin=
g/selftests/futex/functional/run.sh
index 81739849f2994..5470088dc4dfb 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -85,7 +85,6 @@ echo
=20
 echo
 ./futex_priv_hash $COLOR
-./futex_priv_hash -g $COLOR
=20
 echo
 ./futex_numa_mpol $COLOR
--=20
2.50.1


