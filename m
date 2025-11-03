Return-Path: <linux-kernel+bounces-882219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A8C29E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDA13B29A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD522F74D;
	Mon,  3 Nov 2025 03:04:38 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D234D3BE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139078; cv=none; b=AwokCu7hkoeb4VM+7lfUt4nwdsz7pLlk3d1v+qMiDHWxtAKddSHPJN77m6XiiKi3gTQaZUf5n3bpEED7/WRMKsokvg20CYO+m/htKYRZ5ZIbXKuv1a5ThKY2J2GSPRwkKXmeH5GHOpUPZaFcR+p645PYUevQ6QrLlrnpZ58goKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139078; c=relaxed/simple;
	bh=2eMwIGG5G7tc7p2ezU8hbP3iP/eu8l4H8O+ZvnJYjtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txkIMGzej0Lq/0YyoaXQnoS+C5IMD38R9tvrKRYPmuvzkC/nAdDcHGLpCszbevplIl+IOqO2a/xFhr/2bj7L+6ZtREZZ6mw3iJjYBNUZwbJA8jlgEGIvgsmWX+qJgJt8ihWafTJ3V1eUi6heyFURLKlntWU1jNmDJORo7pM77b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpip4t1762138939t50954df2
X-QQ-Originating-IP: yf/9pMu/pH6gfdXwOAOQ32Zqxze4ngRaUEZV17TOkx4=
Received: from arch ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Nov 2025 11:02:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1809871534851727734
From: Luo Qiu <luoqiu@kylinsec.com.cn>
To: Jay Fang <f.fangjian@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] logic_pio: change return type of ins() to void
Date: Mon,  3 Nov 2025 11:02:21 +0800
Message-ID: <20651DB6AB935008+20251103030221.18672-1-luoqiu@kylinsec.com.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MTlwlXBsL2CfYnUWgl7f4Y9a+FInZyDK36uejGO72kAsmzkWpyDA7utX
	YUatLqACSq6kbe3sFUvbDFyrrdNEfX4M8wnZJ2zS5WF8Jo6NGIDnCCjKLsHovVF9NlRRrcQ
	i+renwCIW8o51HF63xFpoatSXc5Fx+WciJ0oY0SiMeltkFCeE2OxC5zmw4Eg789qv8ycUyJ
	pJfnhn0SdNwk8UPrWl5tzUCNTGir3NW8+ZZM/OitdoYVOc7hH+KbEUCfcrzRCVUHhG8ewXm
	xr60abTpjwVkJsaHrgXdx+IlhCOMVJc+WdEs6mMUmKFkV57c291akmjsCLDEr67qRmfsMEF
	sMQBXDflZB5cVlA1oFE79o2b5pszuHzhwNPrYJRTa3LzmQQKN5uDVofc442ZG4wDVqeuEjU
	Vv0aoPUVhmq7E1PG0UkV1nRfgd62yhxjSX9C8mtgupmBV+/Ql2X01lw0Nx9eCCUjNcQyNAQ
	ZL/h+eTRL8/tKS3JB7fU9x90j7M8Qs2DCmgExBkoCVZgc6eyOeaflGoP+YvZ4tNi91/lNil
	EhA8feeuQaLJ8++KTav5pO/qV/OzRZujR36PdTqYmVJNkmO+aTlgCII3GWrZliq8T7s4u9y
	cQsGkeADhYLibC2pFartoSAsDe/co4ONuEEch1hAD/K+7sd76kUxaWudzKbCTfydAQVCFy9
	H/zUF9kO6PRBBj4IRKfI923oiFJm9yUkx++wmdh2z+xLIpJdSFdm8HkNU6/eX0QEkCqkLHC
	+usEkdHSu5gZWKGEy2mLSsYUIQCGBWJgg7ag7l/PgkbpPWMJv+M+k5dhlTS/vmt8mypRBo+
	KJ6XTRq7eH1BwGhLLtZDEVdCA+k1o5njh8sPYao0e0Jz+OIK5vQiMdm1Tf6yGDsRbMT3Qwy
	0Tq0By1mAEjsMGOFdIwUjR14rmztSQlATVGmSHKFL/uC5YGm/86ZRYzT4XXPuiwXdVXHjYE
	/aEeT/hFOyPG7qRHAU2oYwbWdukcg+8uYMDg+q4h8GPH+ywnyREthg3E4bpqDaSbelvk=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

The ins operation in logic_pio_host_ops should return void instead of u32,
as it performs bulk input operations to a buffer and doesn't need to
return a value. This matches the semantics of the corresponding outs
operation and fixes a type inconsistency with logic_ins{bwl}.

Signed-off-by: Luo Qiu <luoqiu@kylinsec.com.cn>
---
 drivers/bus/hisi_lpc.c    | 13 +++++--------
 include/linux/logic_pio.h |  4 ++--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 53dd1573e323..a212fd39cf24 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -265,12 +265,9 @@ static void hisi_lpc_comm_out(void *hostdata, unsigned long pio,
  * @buffer: a buffer where read/input data bytes are stored
  * @dwidth: the data width required writing to the target I/O port
  * @count: how many data units whose length is dwidth will be read
- *
- * When success, the data read back is stored in buffer pointed by buffer.
- * Returns 0 on success, -errno otherwise.
  */
-static u32 hisi_lpc_comm_ins(void *hostdata, unsigned long pio, void *buffer,
-			     size_t dwidth, unsigned int count)
+static void hisi_lpc_comm_ins(void *hostdata, unsigned long pio, void *buffer,
+			      size_t dwidth, unsigned int count)
 {
 	struct hisi_lpc_dev *lpcdev = hostdata;
 	unsigned char *buf = buffer;
@@ -278,7 +275,7 @@ static u32 hisi_lpc_comm_ins(void *hostdata, unsigned long pio, void *buffer,
 	unsigned long addr;
 
 	if (!lpcdev || !buf || !count || !dwidth || dwidth > LPC_MAX_DWIDTH)
-		return -EINVAL;
+		return;
 
 	iopara.opflags = 0;
 	if (dwidth > 1)
@@ -292,11 +289,11 @@ static u32 hisi_lpc_comm_ins(void *hostdata, unsigned long pio, void *buffer,
 
 		ret = hisi_lpc_target_in(lpcdev, &iopara, addr, buf, dwidth);
 		if (ret)
-			return ret;
+			return;
 		buf += dwidth;
 	} while (--count);
 
-	return 0;
+	return;
 }
 
 /*
diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index 8f1a9408302f..9f27d9374f71 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -31,8 +31,8 @@ struct logic_pio_host_ops {
 	u32 (*in)(void *hostdata, unsigned long addr, size_t dwidth);
 	void (*out)(void *hostdata, unsigned long addr, u32 val,
 		    size_t dwidth);
-	u32 (*ins)(void *hostdata, unsigned long addr, void *buffer,
-		   size_t dwidth, unsigned int count);
+	void (*ins)(void *hostdata, unsigned long addr, void *buffer,
+		    size_t dwidth, unsigned int count);
 	void (*outs)(void *hostdata, unsigned long addr, const void *buffer,
 		     size_t dwidth, unsigned int count);
 };
-- 
2.51.2


