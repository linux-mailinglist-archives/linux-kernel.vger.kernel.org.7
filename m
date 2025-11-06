Return-Path: <linux-kernel+bounces-888319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31248C3A7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851CF3BF269
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374352ED844;
	Thu,  6 Nov 2025 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="X5U+jc+0"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EC22D4E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427428; cv=none; b=jhq9dPqfZEL4QxKht5yaEeUBCI01Tv6NdZBj5n4zIv4izeh4zsc2H+wiUkvq0cbU3ye2+klNSi0opEBNl+JVLhH4cM7MAAiGwoAlvVoLZNXjVZJAJqMpfDrenQljhlZ4dS3q0BjRqnGN07rMwOl4Ft2mA0IFA6sEzR6xchWakLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427428; c=relaxed/simple;
	bh=93gR9UkIkV9s7VESpTfLepvbkMuARYE5ahecxC4pRb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJExqIkJKRRp8HFg5QamyqAdOyimr+kECquMMTmmvnAT4kpfrjmWU/DWs3dMyquAH448kkNuKSjsV2TPSL/Uhd8c/dQjoGjeoUlmrGgqNtDxZp0SKjxHh++UwjmlyPq/oFtZ+FVutDPAMOExwm99VzCGgJ74FIcjt6A6Wt0ypAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=X5U+jc+0; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762427383;
	bh=7a36Jqyydi+rF8x+eo6LeG6yiYsw8MXSkytX2sMwGMc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=X5U+jc+0a33TA/LWTWKJd4jnN5SnHKtVjhPpJlZU4MlytVK21hg7pdnwGCo7fhU77
	 TKlatrv9pAjrWnj67/Da9VYPoBnsiKJ7Hu0N5E9JyWkDqmdz0kID8d7IHQyB8qD/bd
	 g+Q5zUQCrHLMzQVzsHNRiIFQKxWOMe9Dl29stmfA=
X-QQ-mid: zesmtpgz1t1762427374t053580a9
X-QQ-Originating-IP: qJ1mXk2OsLLE8RePmt3JpC7RiJgxZ09hPSHLQHH/Pgo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Nov 2025 19:09:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 199588377174854463
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: Liam.Howlett@oracle.com
Cc: anshuman.khandual@arm.com,
	vbabka@suse.cz,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH v2] mm: cleanup vma_iter_bulk_alloc
Date: Thu,  6 Nov 2025 19:09:29 +0800
Message-Id: <20251106110929.3522073-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MuaVFG6ep5hsGpXMWJYEMyzUan7DwDJTy7uKUKZt03fytPdvxJGRMv9h
	I/d84tt+yauaquBVAqefD7e2zR2DmPbhod821T0wzFWK1iAXzACcxV7Y1HFq+D0PYsCUCSs
	lwo8Ww2G/D3ibVXS1Ba+lMurWB/nubHMBSiCejVpgGtcQZUvCsbC7DuQOllXqFvhA9gOM1g
	rTk9BXDS+FWV8sLXXOZyHZvSpNXvViJ6j/5s01KSbWhVfCLBJScTmZQNO17L2URHC1htIdN
	WIZo0X06baiFThlXAI5xcOl2Zh+sxHPOxcCXhXIfj/t/q6WIqjiKF4EgMjPB17KHtFNrOB8
	QPtsK2vmxlCfOFkgBuGPRXVpaWXSdNPVkUZQr+mksiZ16RC+0bCT1gwVZQ2KAgeMLzpgeVe
	3+d31rjoMGZSdp1411XJxlO7YAoJ9NQkklPfwjGAqYoQ9ZfzEh/59Kii+C8ZLAUNVder7Sh
	EwEWVoRSvA9KUoPKqemH/YzgZySDtMZYVT8JszXDBy97EIKB39k76g9AjLf/phnPcTSjqhH
	2dIXYpP0heousbdy7fcEs1tZiggcAW+Bx7cRgtduMzeFAshoLgjcfCV468gmla4iBzjpvKU
	BXwByqKzfvMdjWF0P3A0lfQfbIvStKq+jU+WiMGU0WRKizGH5xJ9D94GCL+rqCkiYzOlWfb
	DnVPdyKEtJOzQ40ycFRWQR59h62cEFSYNT3amIdV/4Vp+oxt0beWwWE9FqPWgmCZjr5xPo4
	QNaPX0ere1DWZBi46YOQ/BwADWs/pk75U4wQbghN40BMSN7JyFnIphjhOllDIz+1PvqVjtC
	OMP8Zr4a0b2sWTN5q3M2On2OstrPRKNZ9DxYH2pUhzchlD3MShoAIVwizWWv4abVnPBMCA3
	Xn2BEqls9YXTqHRiSRoRKoxRwH2HyjCTxqUsdgcdRK71zHZeUrTdiKtdlelSjrJApC5gtta
	Y3+kmmk4My2TqiLMZQ5STWp3xkynOJ1ly5BiCVQ4lL1v5Le0mAJ8eS2oQNoWpuvQEUaAHFh
	IV5FCmI36Y44+4IvdTeAhJ/jZOkIH4bROaD37zKNvikMJ9PsJMPBEKP6jfdVLLvdq+ukTTJ
	BlhIT3WJS+HfvxJKoRKtNOebDt84lreDBtWaeIfyF/40sOBNqMJsfA=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

commit d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()"),
remove the only user and mas_expected_entries has been removed,
since commit e3852a1213ffc ("maple_tree: Drop bulk insert support").
Also cleanup the mas_expected_entries in maple_tree.h.

No functional change.

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
v2 changelog:
also remove mas_expected_entries from include/maple_tree.h.
---
---
 include/linux/maple_tree.h | 1 -
 mm/vma.h                   | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 66f98a3da8d8b..f7ba53f3f9035 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -536,7 +536,6 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp);
 void mas_pause(struct ma_state *mas);
 void maple_tree_init(void);
 void mas_destroy(struct ma_state *mas);
-int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries);
 
 void *mas_prev(struct ma_state *mas, unsigned long min);
 void *mas_prev_range(struct ma_state *mas, unsigned long max);
diff --git a/mm/vma.h b/mm/vma.h
index 9183fe5490090..4aa72c7e94400 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -498,12 +498,6 @@ static inline unsigned long vma_iter_end(struct vma_iterator *vmi)
 	return vmi->mas.last + 1;
 }
 
-static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
-				      unsigned long count)
-{
-	return mas_expected_entries(&vmi->mas, count);
-}
-
 static inline
 struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
 {

base-commit: dc77806cf3b4788d328fddf245e86c5b529f31a2
-- 
2.20.1



