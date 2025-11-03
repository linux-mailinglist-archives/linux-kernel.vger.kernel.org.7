Return-Path: <linux-kernel+bounces-882335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2141C2A34F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4373B2E52
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D4299A9E;
	Mon,  3 Nov 2025 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gavmX8c3"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3E2309B2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151917; cv=none; b=LfMNmdhFsVymYiHOEQNwIcnhIEHFqO3bN8QtAwooCf9c8bB5z0E5C8BhJZe7gWut57uTHqcGtAaUeNERDr6jTh+34gYyd2phh9Mfg1tObA140vKCRnOMh1/H4T86gcPeuNThL509pLSZrGcEyL7oppj80NABTYvVOxEzqXP8xqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151917; c=relaxed/simple;
	bh=zqhMDdQxfNUUFJxdkwAqmdIiGvK7f0u85p1ipRNchH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J82CrJp3MjG5LZWD3ULHBDnCIqoH0AM4l6j4b/ba8e71nyLPbdmXEYWSASb0Z+0d/rR+I53qCkRZ8SNBFSGaIXJStSSgSDqfvjojFnzberiQmf0GBLJJBbEdhAM25oThArrqFtweArz3Rhh0F43g/GF8yG+zOGShCR5PAORGWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gavmX8c3; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762151863;
	bh=bCRxv5EtM0tvDW4JhQ+LpOOVgm4zkB9w1mcNoEZGj5U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gavmX8c3736K0IC+EbaGnB1ajjL7znUfFRFS5p8qM5br3WRxMtW7KsBeO3FOS/xVN
	 iLdHB8xO78wHrLSbbhgDjVM875M56YGPETeiEpq6wNOxdGvA23sWc1hUmwG+p3bf9t
	 eB/sbNrkv39AOHixrJq9RbGJL9UolSetxZhMaNI8=
X-QQ-mid: zesmtpgz4t1762151859td14c1dbe
X-QQ-Originating-IP: RhqAIz/08Wyxiq6Fw68hfnrDcEIHZXXUupI08eRw7Mc=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Nov 2025 14:37:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10891316942982493356
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 4/4] kexec_file: Fix the issue of mismatch between loop variable types
Date: Mon,  3 Nov 2025 14:34:40 +0800
Message-Id: <20251103063440.1681657-5-maqianga@uniontech.com>
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
X-QQ-XMAILINFO: M/NR0wiIuy70E515xT9T6A/bvLkicHDLC/2+af/Gk9QQa4J1wPG/EEQG
	xr1Sodyf5gFjBymm74UzOogkv8TIv521xHSGvART/m2LW3MjQ2dgkckBIDlzu3k3MWjAz54
	0j+MA8Io/1vfL0aPnCpMz6VO2MOQsx8g5mHMIFXTZFLOBxuo8K3TRpnfyIMzMOwKJmKvpom
	yYTyG9jLz+vm0hLYVehK0RjwAaHjtazAgrCUnHn7TNwuGkhRElpib1kWTyOvTEk2iTX0Cmz
	xiAGT97IoBmfVkuH9iiSzYF4NIYHZRPFQJscUhWLMJ8NNX/Pgndav7LVR+Agq9nMbPDzt9X
	N0QNxOv3tabvvxvVReHMvtzrFw/C7Fs7hDGpk7ZYqh8i27rwGWm/ZqflLHYbiuYgJZWpzqK
	dR3oStu7T2xMyBr4sEnu8ZcxGNBc4GF6qiC+5KAMmItZAIqVrdziwyRYQpcOYkywt9YKmw5
	gr7Y17qnNLh1cH+LW7hSs4OnLcrbfasEjggLgBUH+4SvV+GVaZx8YzO5sX1UZ13WZiDtbLW
	341cI878p85PyrMdl2G2NJ3OtfUYvCTBbld/XNXL3e+ewjAhzEORwSspYOH61dUIpYK9W6g
	UWgbnlTeSi1aRd2wSO9L589KWcmUFTzFFRP+x/3Oj2ql5UbDGnmE/yub/YWFpaBMizdnum6
	E3B8R9pRkMWb4FpIfvZ2UHq0iw8goD1lgCpr/lXng9G5jYchihmaIqL4XWbC1bmBwfr0siu
	f6n5/IrXDn+oV2O5IDdi6SFC9cyF38h2Xn2O0CxL0MaWIIDVd8vvdWVGbGqrlptUHmaFjxm
	g6MpEhBk6rHC0TEGKnGFb90FPXMoWEalPRR1z/P2QM2TaussWgm4ZvDA1D64vBMQNvep7jR
	rXKYqHAEfs5teIvlBBvwrD1maTbdyZQ5FxXlMKPP9rKlBZ4gWISMf8l+2bcuxyVrqhJVHlP
	nh3k6kHAov36ayRFIFWzMVi05YrFLgpoFU3Ld3mCFUhJjU12gGnJ4pmffKCLqrigldJthcu
	YOJ4vDsAJEXBMD6PlpvrDK6vQE6lkKC0j8OAZxINVmKddtwToO
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

The type of the struct kimage member variable nr_segments is unsigned long.
Correct the loop variable i and the print format specifier type.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 kernel/kexec_file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 4a24aadbad02..7afdaa0efc50 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
 			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
 	struct kimage **dest_image, *image;
-	int ret = 0, i;
+	int ret = 0;
+	unsigned long i;
 
 	/* We only trust the superuser with rebooting the system. */
 	if (!kexec_load_permitted(image_type))
@@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 		struct kexec_segment *ksegment;
 
 		ksegment = &image->segment[i];
-		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
+		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
 			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
 			      ksegment->memsz);
 
-- 
2.20.1


