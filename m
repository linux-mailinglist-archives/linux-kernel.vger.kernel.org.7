Return-Path: <linux-kernel+bounces-786562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05467B35D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE262367649
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0549338F2A;
	Tue, 26 Aug 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XA9RB8WY"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B763376A5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208152; cv=none; b=uAu5CU0/Gxxl3ks0rtGwtwcSAqFWni8soHzOJaZ7sLPqnAlcT7Qpm5RvuU/uxEB1uNQ9xhg89CXatYyeYj0EfemZqFU9s85hkQv3yLoOzd932LYzkxo3ZmoLBJgadItkr8MOO5TlVlijBrhAitgkOpCHTnhnDVAPqljvyMLtseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208152; c=relaxed/simple;
	bh=VBo1svRdNginrTEbj9qaCPBWiJIBPwa3ORCjnE8hJR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Om2yAT2PcLU24e2n48BU6WhK2uzZrGzuo7Lq70Nt4GK7+5vcnZYfsdeFOZhgiDIN7uJMLZvoRdJqQr66vlc2zBhbeV9Z2iux4wnjl0nw/KwjuCZ2vu2eCgSLPMYGeneoVe609W6giJKnPhEClCSpvyO38Xk+ogZblqJcxeOirx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XA9RB8WY; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1756208114;
	bh=R3t7Utl+TZovCPDN/hOP+mtqkeQuSJIeGBdP9uvpOi0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=XA9RB8WY5yMKQNstl8UYDXtL7SpIYiYwsJzQDybnTNXJaiI8ZSFwRCq+9Q2VdsZfV
	 G/09psUy4sBRGb5E3jJJkqkJXTyjycg9Gqu0J1e5CuzNJE773S5bDma4c855ivD2Yl
	 nA3TFcXG34GlMkJ9oSfUEJZMBMtGWBaaKvKGraAU=
X-QQ-mid: zesmtpsz4t1756208106tda2cce22
X-QQ-Originating-IP: bKB9BJ/INt9s6T+Uy6F38r01fZSmLhamwRrNQE6i5ZY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 Aug 2025 19:35:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9744646128302791925
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	xry111@xry111.site,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	zhanjun@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] Loongarch: entry: fix syscall_get_arguments() VS no-bultin-memcpy
Date: Tue, 26 Aug 2025 19:32:25 +0800
Message-Id: <20250826113225.406238-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NmdX3UvlO4h/NP0/GDLA7fNsw+Z5U4f2tYDh378TRAfCcBYXAzUGNhbx
	n7BIy5bEcQybtQxVIBzWEmFvlidpS7fWOrKfbIblujeYqM/Ol3kPgDwr53ssUWHG+BbSlG6
	psUwL/hYHCuh3DEjccLOZqfa6KBiGyTGRrbpjHgUru7Pivg7CHMEIsEbOISoEDb6cL7NfpZ
	SxoBa6nuRQ1671XtC45BlI7YCN8u30xRpGrCIkMAQ0TmVPd/x4ydwW0fyVlZChiSChy6UsG
	G9MApD0PCmDSvqhRcuGjhvBI/Yf97l9RYhUSGugfo/G/069jTJk187MTKRikshB+zjGXu7Q
	/uSZh0qbUCrOj8BwxriQ+3tLgsZvFCqgFrcd2DNmjZwYbEa3UBPlubj94FV4P6k6JQqnhkz
	ThIg6L8HJJ/rgf59vx7+ymB6QKHRjGKq19PYw5ROgzEQQdqXnKft2Qtge6LeU4Kvf/HS3rl
	aWlH2MhHe2MtDdRC9YxR2yhBTNiTwq8dvZhl7IznGy9p9NpWfjr1cV6wOovlwyAaB3D65ZQ
	xYTIlCKTGVQIdxMk4zC/1zCq33uO5Qiz+JrKsUcWCBwrDviJDA65smtd2ECV0tc66DEyh3a
	i0c2qwdnt07XJclu4ktajCvueyAibffKHPTivRN3dA4uKkDEC2bSosVNnrVF6LGET/jU2Tz
	vnjLsvXhzkiOEyMjbv3a4f+sTk4KZx5BezS4wt5neQfrY9UWW+zM8yLBRqmeZyalBFSY5BG
	0QgXNUaeKId/zpxzWpViLG2uVTjXAkFh072oGi0STWb+HrV7kbGosL9nboDkvo4lxO9/EWS
	Nr1BqL/ubuvR4+YqQwPQct5eeX80yflfsYkEIR0TaXKpACPf2IK826l/nQqsbRtlg31x2eL
	fDtN2yvL8jLCfxXSt8xXw7pVcdBMf3Qb9d51cjO6Sdw9fpxMgaaNGIIuWkkfBzPibk6wVJ6
	db/x1mHfN3qCkXWvDLWduR6WwQLM7+43G8yvDS4wFeXJ52pFuqDIlyBg7T+VWL5lHdMQi/Z
	ARxM9ezxlD5F4uYmiaArxURvcgrnBvMuRzTz3QhfY48pVmUfsUNNoj8kqmLAo=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Loongarch use -fno-builtin-memcpy in Makefile,
so cause a extra memcpy in syscall hot path:

syscall_enter_audit
->syscall_get_arguments->memcpy(__memcpy_fast)
->audit_syscall_entry

Just avoid memcpy() altogether and write the copying of args from regs
manually, which shows 5% multi core score up in UnixBench syscall.

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 arch/loongarch/include/asm/syscall.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
index 81d2733f7b94..171af2edd569 100644
--- a/arch/loongarch/include/asm/syscall.h
+++ b/arch/loongarch/include/asm/syscall.h
@@ -65,7 +65,11 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 unsigned long *args)
 {
 	args[0] = regs->orig_a0;
-	memcpy(&args[1], &regs->regs[5], 5 * sizeof(long));
+	args[1] = regs->regs[5];
+	args[2] = regs->regs[6];
+	args[3] = regs->regs[7];
+	args[4] = regs->regs[8];
+	args[5] = regs->regs[9];
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
-- 
2.20.1


