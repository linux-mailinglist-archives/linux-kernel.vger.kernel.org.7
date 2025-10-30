Return-Path: <linux-kernel+bounces-878333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBEC204C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52D8188B7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B725255222;
	Thu, 30 Oct 2025 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+Qrmjzy"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8424C676
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831805; cv=none; b=UhpbpRsNxMgghbqmsIQjdsZLiX2GKpPi2U8DXep/idAI+/28Fiw65umAepMIaRyPptSJGTTiXLpczA2kwe96Z9Hki1C8iPQXjzT1IUcdfTBWvOPkNO9weRFA9Voekx60rXqEkz+7QlCG8EUz9DZRW2j6YeCXrBMjhDGuB4J8Vig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831805; c=relaxed/simple;
	bh=Ty0HqaJo0YMrjaKcw3usfBWyxkQ7++NzVDZDVqhZv44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htpSKBCxCnum7IHlJKaoEyFw4Tzo0HO7FUcissKvUQ9U/nwJDvDm9xbBzQIT6mTvra1zPjL8YrRGok9qYr8MFBTzfH3S+vzGVR7mLPVNbV+sx1DGQjS6ZcfqNZ9juzpEXj3+cKO05wE+0TM+jlQyrYAFPAtgcp5A5LfPjFM2Kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+Qrmjzy; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761831798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/27E63V6v0chX/Wnv+95eUk3yCQINY+pVHFTGD5/UGc=;
	b=A+Qrmjzy/0hhYVpdq0V73dppybMicN+cGYbpZstUYWwooJes1gF0DYq328192V5X1lwtra
	84abu2m3V52u2yXEl6FMIOmUaPNZ9ZXSVYCxkzwUYu+6KD7Ko6+mlF1K1dbpIGVs81kszB
	u+TwKXSZlx2yNBCasR4sOuD32glLvKE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] s390/smp: Mark pcpu_delegate as __noreturn
Date: Thu, 30 Oct 2025 14:42:41 +0100
Message-ID: <20251030134247.303400-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

pcpu_delegate() never returns to its caller. If the target CPU is the
current CPU, it calls __pcpu_delegate(), whose delegate function is not
supposed to return. In any case, even if __pcpu_delegate() unexpectedly
returns, pcpu_delegate() sends SIGP_STOP to the current CPU and waits
in an infinite loop. Annotate pcpu_delegate() with the __noreturn
attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index da84c0dc6b7e..93ac451db6f9 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -305,9 +305,9 @@ static void __pcpu_delegate(pcpu_delegate_fn *func, void *data)
 	func(data);	/* should not return */
 }
 
-static void pcpu_delegate(struct pcpu *pcpu, int cpu,
-			  pcpu_delegate_fn *func,
-			  void *data, unsigned long stack)
+static void __noreturn pcpu_delegate(struct pcpu *pcpu, int cpu,
+				     pcpu_delegate_fn *func,
+				     void *data, unsigned long stack)
 {
 	struct lowcore *lc, *abs_lc;
 	unsigned int source_cpu;
-- 
2.51.0


