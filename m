Return-Path: <linux-kernel+bounces-877695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ABCC1ECB7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA86E4E7766
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C3733769D;
	Thu, 30 Oct 2025 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gEbq6GJI"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D462882B2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809770; cv=none; b=reGeW3SBDzvglJ90GBBERY90waJDyGie3gSKVdmW8lqhOvLXR7s0W2aN20/F3QBjrcKURzU6+R2H5a62OdDB6p0HkKaNVLaCM3jx6o3XzjCeHOgNiqjCZk2tMRPmuHPerIDpY9c26PHJZRb6wvFnQ32pKl+AdgRGEoZkRlOmlaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809770; c=relaxed/simple;
	bh=rkoxKetHzYW7aqa0ka6zLEqCjo5ik9tdBXQovzzY2Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HXkMLDDp3bjQ9GbZEUYCYxmwY7qQXySVN8lq+tbUmNw9spMb8ajK6wE+jfVfnuRX9Odu1Senj6lGOaaLh2eST6T+gW2uLpO+smcvobdEyZHpaarOWerfn8io/P80pY4L9F5/mnGraie8DKFYqvTmQ9lHDblb14vEif30hVCKTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gEbq6GJI; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761809623;
	bh=6v0GgTsDPbg5Ft7pBqWr5VriOn8lCrOnSTV90S12ALE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gEbq6GJIIyCRbHytIg/VuSBsozT8JzF5+asdRFsFqtys1EHcMI61fB0jGv5ORm0kX
	 TiiaMmGR6YjaWFu9aH6lW+BM33Wnp+6gblI+Zf5pWeGQ8NkAStZprWTZsxG899DyWE
	 M/Kx/JUi72vaS72zzMr1qzOtX6GGuc55Y3NMYcx0=
X-QQ-mid: zesmtpgz3t1761809619ta354b536
X-QQ-Originating-IP: cFJ8/T5GrKLGulu8zN6eCVBh57gQEM563HyVYtPi2ws=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Oct 2025 15:33:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11120989038432586530
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] kexec: print out debugging message if required for kexec_load
Date: Thu, 30 Oct 2025 15:33:16 +0800
Message-Id: <20251030073316.529106-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OJDnEMHxZvCkKHl8gRBALqstZaSEEHDFbfGEWdtffhbvv/PzWfkHcZLe
	TKRoliBbZAoaEfccPD9qpHvbryBFSL7qENRbRUC0kT23ADrloZfLmw/tDw+H2Y/Ctspoy/F
	LYX13UTGSz+QbCc1+VFlPnAWhLhyZvxOw/axZ5LYulO+rEQwYPEcE9m+YDTq/daf+pfRCDX
	MTFzTyDZF7XMfbUmIKtl+FAJ9JgYP5hkZymwUiLPyfRYt75pGLhZ7FgqJIvf3rvEhyGxshj
	dFdbrtjgxP0r0X0x0GlbxL65CAFbbmJaGc6OrruyR7eM7Tzk1K0tevIuYGElsmB3Wq2VqdW
	2RR3DGC/eGcel3Hqocpsptmxu54Pp4R4kHnLU8jyBSjFfNw1aUluwdkjaS1HfhAZbM4i67v
	1KD36t34zs3hx4LcO+V6EWiaWMeWOnZWAPnBGiYRaErEoTHoCMUxQJCQGwa0DP5SB8hAwSb
	g9tonfPFijhJxQSg507nmfn3KHRdCDao1cPH+ZAaO438q1h3xmn/+rx+6u1WABlmIgf1Saa
	56CoML+PRpMauGrmJWNMxGQLAIW7AMBQOAWR2+2E+y2RZ95S1olMB6Lb+7/xebyJZeK/aog
	GjPA+KrtdOx3vg0M31YTFbx5rQnZ+6WzCXg4oHe+MUfq9X/7vn7OzNPxaxFc90Iaqsj3RHq
	d1bKn939SHr7X92NNLcDZI43V5sNUPDsq6oq3ZEZji77iarXHLj9YzuR7KX3JLldRBKGNom
	2vL9jnH5ohCMeLS5Wb1MWg5DrlGkN9E/CqkwvvdL5P9+yzKhMiJNjfOR/miO6do+SGWKxWs
	XHnLxzQWOvCMUeJWaHDpqZGPoQCnDQn1iID2cVkaPHljPNQb1slz7X4Cpgu3py9w9yfG19V
	UyeK4w78MdrG/669eTAQkF/cNTQwZ3Sipo3tmXP95w72gCf2JKpZaZ0F3rFfHkARY4k5bj/
	ccZw2WOeiXky95orUsvTehccealA1GsBUxvSURffYXNJjQVJBTx8JGuSmLt/iahRPVxwKYV
	bSPXRAH3mK+rc0R0eu
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

The commit a85ee18c7900 ("kexec_file: print out debugging message
if required") has added general code printing in kexec_file_load(),
but not in kexec_load().

Especially in the RISC-V architecture, kexec_image_info() has been
removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
message if required")). As a result, when using '-d' for the kexec_load
interface, print nothing in the kernel space. This might be helpful for
verifying the accuracy of the data passed to the kernel. Therefore, refer to
this commit a85ee18c7900 ("kexec_file: print out debugging message
if required"), debug print information has been added.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 kernel/kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 28008e3d462e..02845a7499e9 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -151,7 +151,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
 	for (i = 0; i < nr_segments; i++) {
+		struct kexec_segment *ksegment;
+
+		ksegment = &image->segment[i];
+		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
+			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
+			      ksegment->memsz);
+
 		ret = kimage_load_segment(image, i);
 		if (ret)
 			goto out;
@@ -163,6 +171,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
+		      image->type, image->start, image->head, flags);
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
-- 
2.20.1


