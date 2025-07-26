Return-Path: <linux-kernel+bounces-746728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D03C6B12A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205723B80CF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FAE244E8C;
	Sat, 26 Jul 2025 12:38:33 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5089220F2F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753533513; cv=none; b=YXreaTsiM9uuZPdK8wcQft/07rkgLQxlhO75nNs9OU36uxU+sNIvgy9mo69lKDdfrvAJCS6kImFXqvP8Sao7sckAbBJy5iYQFLWzOnS4kUVYtdpkxuHkVeGPpXM6li93e0A4qWhXybFn+K05BmkaWJ78UXJqx6OaJ447y1x47EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753533513; c=relaxed/simple;
	bh=HABmKbPyS6zigDU0AHh7BJAhq/tPRGfeuzvQNTMSHHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvvX8xnVVVX4O8oCCbqhw0UyvV/KnXS3x1AxXixxKGGQfqOUzuVrHEd407F+ruMv/54IPgfcE2lwvrzL9vvAhP7tp86B/AYQ0KJC4igCZSQRNqUJEHzAtPzOWa3r1ciDsn23PT/YArR3I3IH8u/tX4wW0KJ5Vo7T1BZCMgYnfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 33D932B4F63;
	Sat, 26 Jul 2025 14:29:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id eh_HtHKnTg5M; Sat, 26 Jul 2025 14:29:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4F04E2B4F68;
	Sat, 26 Jul 2025 14:29:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RQSioKZZK5P5; Sat, 26 Jul 2025 14:29:36 +0200 (CEST)
Received: from nailgun.corp.sigma-star.at (85-127-105-52.dsl.dynamic.surfer.at [85.127.105.52])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id EB5522B4F63;
	Sat, 26 Jul 2025 14:29:35 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin.berg@intel.com
Subject: [PATCH] um: Don't mark stack executable
Date: Sat, 26 Jul 2025 14:29:30 +0200
Message-ID: <20250726122930.236404-1-richard@nod.at>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On one of my machines UML failed to start after enabling
SELinux.
UML failed to start because SELinux's execmod rule denies
executable pages on a modified file mapping.

Historically UML marks it's stack rwx.
AFAICT, these days this is no longer needed, so let's remove
PROT_EXEC.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/util.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 4193e04d7e4a7..e3ad71a0d13c4 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -20,8 +20,7 @@
=20
 void stack_protections(unsigned long address)
 {
-	if (mprotect((void *) address, UM_THREAD_SIZE,
-		    PROT_READ | PROT_WRITE | PROT_EXEC) < 0)
+	if (mprotect((void *) address, UM_THREAD_SIZE, PROT_READ | PROT_WRITE) =
< 0)
 		panic("protecting stack failed, errno =3D %d", errno);
 }
=20
--=20
2.49.0


