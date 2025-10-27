Return-Path: <linux-kernel+bounces-871140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F82CC0C7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19B864F5C56
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B469B31A7FD;
	Mon, 27 Oct 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZBRXvbRw"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B36302172
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554876; cv=none; b=a8oxw6277AKfd4DHui4nEMaeZlOzj13ToqSVjts1lwjDuLd911EConaztEN3Acz0brgl8vZYaW4l6b+F79PvskZlyD2xAyILysVh0sQ79Wq8W+HdLGjCyx80VDpFcIjm7lym6En9MsbTLiqNVdcH6heXC3yERrsnvl0ZW0IPb/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554876; c=relaxed/simple;
	bh=H71eWvWbWm73Mp7PPsrGR98SqvdbMI0E6aocTIflNDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goEV4z5v0FW3rJDvt9+ye5fUqTxV/saAzxqlUm1Af69D9lkHBpenetlYVah9CnomawjGcFTCbFN2MmeTbPz0ElWdsLHZK4A1N1nGghyroZdTdEOoXSJ5latDWV6h8U6coJHv7bAq9oUoIULgBNk0zMNnxI+BFH05AqN1cCPL94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZBRXvbRw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761554863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u3H/Kw1PmsEzIN1WuPU7v//SQUe1FpBA2ChXgU+9gCk=;
	b=ZBRXvbRww9Ikl4/7pVjDo78+3jifpQvKQw1BjwT9DfyxVwBb+1TVWnmf0UarnP2OUvguKY
	oV6We5H/iuEVlDzlsV2tViRdLKUQmLO+1tl/FcVUpQfKrsL9cS5U9nzsBFlusl/wraPQXY
	P3gj8EoxlDPeuLF/xcbryVbbXUaGUmE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/nmi: Annotate s390_handle_damage with __noreturn
Date: Mon, 27 Oct 2025 09:47:25 +0100
Message-ID: <20251027084728.1362-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s390_handle_damage() ends by calling the non-returning function
disabled_wait() and therefore also never returns. Annotate it with the
__noreturn compiler attribute to improve compiler optimizations.

Remove the unreachable infinite while loop.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/nmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 11f33243a23f..a55abbf65333 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -184,7 +184,7 @@ static notrace void nmi_print_info(void)
 	sclp_emergency_printk(message);
 }
 
-static notrace void s390_handle_damage(void)
+static notrace void __noreturn s390_handle_damage(void)
 {
 	struct lowcore *lc = get_lowcore();
 	union ctlreg0 cr0, cr0_new;
@@ -214,7 +214,6 @@ static notrace void s390_handle_damage(void)
 	lc->mcck_new_psw = psw_save;
 	local_ctl_load(0, &cr0.reg);
 	disabled_wait();
-	while (1);
 }
 NOKPROBE_SYMBOL(s390_handle_damage);
 
-- 
2.51.0


