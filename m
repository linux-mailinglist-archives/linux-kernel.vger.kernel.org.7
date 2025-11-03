Return-Path: <linux-kernel+bounces-882336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAAFC2A352
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE503B2FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E092989B5;
	Mon,  3 Nov 2025 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LWRDz6b1"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03434299AB3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151924; cv=none; b=SEljsl4B0MDqI9d3hlb0JSszg21DjmPqegYe9ZYm8bbRLVAogM6pdfufbMxKZzB7dk1TM6qnFWUh9j6gLCJzht4hsPNpQacXdCr1e8tgNHTtkYXeDDQKARDx8F58Flc9aGL8P5UTZXv7Mgj0tO8cKiMOCTYi0KWMY2IIhZneKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151924; c=relaxed/simple;
	bh=6iV21gme15Qohb4EzuDv64c04VQLHXDeRnJRjRtofgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rP57c8IvLaR7DQcbIHL1FX8bgEDxQ4XDO7EX8Y2OZWGwF3QNixZbkVx1b73OdD88SA7SirCG2NOlJw3WLoyvH+KSN6xTxqcW24uy+8wPjt9Nq3sFxXlxd7l36Vz4MS++iASBZgeuAs+dE+5/WPdNTottAV2DKy3swLXq7gTfBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LWRDz6b1; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762151867;
	bh=eIvvjEbQ1sG5r7Z8cl/qUt9KXwEgp0m6a/j87zSOL9s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LWRDz6b1jz+nU4M4m8Ko8LAttQO7uYKVOE3HYUKcnqSP9M2FX8289qZu+DkAfw9j6
	 RkrPYSQ8M9GxUeG7NlvC3hGNjhvxFX68NEQ+VA2JX6JntiEWigkj3Lj5N14JgpETC/
	 FYMMW83sP46ytNzmCxWXjy0EOUC1MFBLzTevYwKg=
X-QQ-mid: zesmtpgz4t1762151852t66baf00e
X-QQ-Originating-IP: HP92wee9TdxOT6l0k09HV0bbxacm4gZA3xqBTdJ58Mo=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Nov 2025 14:37:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 565133868988275124
EX-QQ-RecipientCnt: 6
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 3/4] kexec: print out debugging message if required for kexec_load
Date: Mon,  3 Nov 2025 14:34:39 +0800
Message-Id: <20251103063440.1681657-4-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251103063440.1681657-1-maqianga@uniontech.com>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MZyrYvuwV95ZwJQF6kolioZMMFDFt9KRZz+4V9otQXiSIxe0w6YsrgSb
	aG0Rs7qmazMPy8AjvrnWzkIA/L3BaK6szUTN1OzeuliEoLOEz88R+xorH9zuc+T37WoaaFT
	hjWK4IL1IpLZgwdcvNF1YgjpcljUsBLxUa5yVz5Z+GWDKo896kFmP2NdKCEnh+2x6ZKRf2W
	k+TOApqRhxj3kRJAZsXqfrHO7OuTxW6IJVc09VFQWJoDR62jwp/XQJhATN4xNzlc3sNpFLd
	Gu6TO4Y5RMHRJmWpwkiO4p/nY1B9kM4SeYvUjDbxFAlNIPNnq7evdgJDpTg14zjd4Jvk+zg
	dLrERuYNXTvG/gXIws8BGOj+U3YGDR5sfdzOT+z5WbW4IBhlGhuN/ht+ihsVEJpHEUPYXB8
	JvUuYG4ohzRMbyrtRBOpc3FoxI4jgvUN8rQt+dM5SoupYLytXzzA6hnbNK58TdtFccoZSLT
	Kiq+b9rdlGq1eqmPXgC9FcEDYPLRgMQRX0YSvtNoCJEnsvogwNIYUiLTSZzx42tIZTR0if2
	wZvqycxnQfGdEEF236UcumOSHyHdnWa4x5dYX+u9vt0CkgiFeBTOQ8s0DJ/DtHbJhpT1gf/
	qFfo6MXTIvF8k4KOir8hmNf+z/oEse5i9AU7zn3ul8nc2qJ6m7y9De9FW4oFoL6b7u9pv5c
	yYNa/WHnvdATH9o5LD/Uf2KI4T8RXRQgeMsckGGKb2G9B/FsYEp5nGNXB/nCRzn5vqmew1P
	jAL9Z/H+/iSleqBUT9wsvlBiCpN7wmWgw2mWhaRes0ENVy7zp4vwgpE3zNw+xXnNVA6UWvl
	IVW2y9zseA6TO0x6anCd7CfLing4eaRuqqJPdB6u0dxRs3GhetW6N5lHilI2iZ+ghabLaQX
	L99bEa6iMA9pPFVEnUPDLDdWevtCgWkoV0SThohmQ+P18wpnFkPtDDatlxrs0Gw+O4tblGc
	l1/PmvcCpD9SRk8Hpht1Xf4b6mHbnzfP9GfKsZ4iskZZx/D05oNMROCT4hSyPig46geiekd
	3miP/UFs1eY6J/QdkHOox/UmP3rXZGk51w28hlTmLY7U2uesNJFwlGG42BB90uOgHtBbns5
	PEylMGxp52jYWNNsQi9JJ3+/PtB1fSg8N7y4CQTDHuHs+y8M6IaaJc=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

The commit a85ee18c7900 ("kexec_file: print out debugging message
if required") has added general code printing in kexec_file_load(),
but not in kexec_load().

Especially in the RISC-V architecture, kexec_image_info() has been
removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
message if required")). As a result, when using '-d' for the kexec_load
interface, print nothing in the kernel space. This might be helpful for
verifying the accuracy of the data passed to the kernel. Therefore,
refer to this commit a85ee18c7900 ("kexec_file: print out debugging
message if required"), debug print information has been added.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
---
 kernel/kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index c7a869d32f87..9b433b972cc1 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("nr_segments = %lu\n", nr_segments);
 	for (i = 0; i < nr_segments; i++) {
+		struct kexec_segment *ksegment;
+
+		ksegment = &image->segment[i];
+		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
+			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
+			      ksegment->memsz);
+
 		ret = kimage_load_segment(image, i);
 		if (ret)
 			goto out;
@@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
+		      image->type, image->start, image->head, flags);
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
-- 
2.20.1


