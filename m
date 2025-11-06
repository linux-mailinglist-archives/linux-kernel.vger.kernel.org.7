Return-Path: <linux-kernel+bounces-887872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A324FC3946A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600133B478F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2198287272;
	Thu,  6 Nov 2025 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZGG0IQIW"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132D23B616
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762410917; cv=none; b=VcY5YprtjTjS4vhavx39GkTfehSgoPUIB+vJHjwVFpu3P6eh6biMd7Iz6H0EzfgylJY/XFWWWeESy09+02xQPMnRQbz/fDcC600GmrwsXOQl/sesKd7A8Yz+GT75vjRoAPMVWV6ow/ceU7DQmEzjgf8U2C5vucv848dF+mLfRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762410917; c=relaxed/simple;
	bh=hLXFK6Z9nArxXf7N4eWRhfIf+Xdbo3OPK75FQL8v8Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nk5PXcLQq92HEIXDu0E8ingXRZMbygRLikneYL8dmEcBQlYly1oeFY2wFJsvJL6wmvoQQA4HUQXz2MWMbP0pxDrlRQDcSfWto17Wj2Z86lm/IedrNAJ/Ft7JZwjbQ/e9S+T7zraQLrg9MwfsLuCmynSgZTE4slxjV+ixLjHcA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZGG0IQIW; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762410888;
	bh=QZ7DE2sG/2Rv5kN7Az6y38KWqe7iePtqFCQYa9nFJTk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ZGG0IQIWwBBHqSLxfjmKhEz391LYl5hdCrnS3VT2gfQSyjpW4WRpp9ZLuONLB8pkr
	 p00+miLjy58Vm7Kk2+Dmh5NU1EoocyTAQ5TsBaXKsh5f07kvh/1USVpbW1RYv9QLsY
	 QPWHPKHesPMIyi3PGL/EWyIBtT9asRFjRlD1m0yI=
X-QQ-mid: zesmtpgz8t1762410878t199b0e4f
X-QQ-Originating-IP: wzccWFkcFTATNYtGEZy5o/bzg8KBCjYQIHLUW7O3Yyw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Nov 2025 14:34:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 708193780531917148
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: Liam.Howlett@oracle.com
Cc: vbabka@suse.cz,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] mm: cleanup vma_iter_bulk_alloc
Date: Thu,  6 Nov 2025 14:34:24 +0800
Message-Id: <20251106063424.3381872-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NulC8gp9xT8siRdEOVw9JtpjCGEPviwcjIU01Q1XibSEmAdkUklxOKpZ
	v0ud1usjc/LMRcXAqYubwZubq8tS9iLiG+jpL71E+n7tmDthHlm6PZgUXKzdSm938DDjgzS
	5qNUMYGTkuP4WuY/u4sapoPjDw1AZUQuTyXEsDpFBC56w1WpiGru6pJIFLw6470jk20yfWt
	G724RiOcSS10Ev/L8EHeF0cirW3pxnG6aKFPe/j26J4h30KAzNLmrXY/6doWPXNUH3J5k2X
	beyZ134NY1kdjMTc94348eTWdmMml65YGwx/FgQ67xb9UFRBHqfHe4UoE/ytQbwaz9oqhEp
	bYze3vHQyzxh9n5QIS7g4d2dgp2NEzNvehLQsty1xjUtMW+2YwZ36m7DF7LmEM0MFXxW0MV
	4+JiCEaUmoAlcg8YZh3LH9GMoTRXRowNBrrNmeYlT0CKzVQNexlwcouowHqspdc+/TS5aNh
	cr9wonCWEf2gJoN3VBX4fpEP/nL0we2AlJp0mmtts6ZeA4SxwyVq2Y6nir7Q1poDvQxs1GJ
	9JgX5aGMPJJSto/HtLPPqlV/kpiZnm3CzIdKUkFVRf//Ug/KNZU/Mzm3ZxiZ59kyzq09gAY
	kRPNOxwJki3+1xHs9dbhvuHri5uLyNiRHRi8ltok2sZN4TMEjjbeewT+kzZo9gY4U6ebB+v
	DsQLcth2YTyv4Vub2m2srEXnroyRTdtorsS+KtveA2pMikA7aaH4iohZ1oTyeeHfrxCQIRe
	CTu/x9G4zCLWbzmaK6bhICMNZFJhToPlhCevuNEB0YNlammYzafmCOnfLxODRaqhbKM3zHn
	bajx4qZ87O+5KGadFJwz5xP862htX6wisHMnz1eA0ZgAZOmk1ayHroomYGfccvg8wBN07KW
	wZZ5uX4k7y7jAm4wESETOytKDtmjmqz7lnG/tSSnQxggCO0OY2K5CdiMc0KZYIWQxHyEX00
	bvI0vrqlaIZbCydvWWAC2H41Ht3R8vpMssMQ2uricmAXr4h7Th0j3/7zeZohcUGAShkBRd+
	xsCqhVCXmNRG4boK+DXqjVR7SEPh4lb+I6eOvsATcAWj7Frvaw1sZisFpwYzI=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

commit d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()"),
remove the only user and mas_expected_entries has been removed,
since commit e3852a1213ffc ("maple_tree: Drop bulk insert support").

No functional change.

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 mm/vma.h | 6 ------
 1 file changed, 6 deletions(-)

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


