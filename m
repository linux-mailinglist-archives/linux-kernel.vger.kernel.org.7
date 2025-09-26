Return-Path: <linux-kernel+bounces-833577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A0BA2560
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CEC1C00D09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF2928688F;
	Fri, 26 Sep 2025 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7oxnBCY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B2281357;
	Fri, 26 Sep 2025 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857724; cv=none; b=nAu+aYmf5QiJxBGUvRrrXh9WscgST5va/uXLAIbsKsYD4DAzy6q3N28pRqHhDPQnOg6IC5eDU8QajGgAm+09qnrEHsT0TZg5AaGKpmM33hOVhg/vhcqRmPyloojXq+rSZp1ilDYcaoXQWty9/d0hWwjLKv7bMyGAj8EkmOiXYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857724; c=relaxed/simple;
	bh=8zO287VZ8tZ+k+EEFCCO9Fum+HPgmZKBhvlLu2+6EXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q++CbY2RyFlSeLA9xykkW1r0PaNf2RTPjTvCqT/CZxbfIhLUUk/2uvHj/j+JywDz6RKDEnpr8lMW/xNxyPRe/YQNwznrtAW3UG2e1SSKrRFB15OVs8YdK1utcpDuG5wVZ81To2ULiDVXYmoS7D3hcv+swcM67i4O/ZI+16HyyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7oxnBCY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758857721; x=1790393721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8zO287VZ8tZ+k+EEFCCO9Fum+HPgmZKBhvlLu2+6EXc=;
  b=O7oxnBCYWNp6GCxLQNpEm7CI/ZoDA5vHQe7QGzVprrVO0H1F9ppaXvWZ
   zkFeMCNW6kABbBV+daBe1browFJgjXLIKPbszw+AYDZle31Zn49wJ7bBv
   5gCXLyMq9uJNLM5qC83yJ8ngx0ekTjdVjOatof62RZreSbI5pMzmPEYfs
   vVbEFJ4uK5sSFhw0Pg2By+WNhczTNUTgQ4WFIAPFMlxGGIrXUNG1BEqwm
   NVR4GaoNJFyVuTSUahepWaeHL3WdcO7oDVxoln5wdxrOkFjKSO8LasG1p
   csaFPkVeGLlAYOfwpvMTgWt52Z+5xEDcbB+9BcRISPM3GYpnWXTptKbCU
   Q==;
X-CSE-ConnectionGUID: Na72yx2PTYmliI8LITV2Pw==
X-CSE-MsgGUID: bCYXeLhTQ+65aC2cSNTDxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="63819654"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="63819654"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 20:35:07 -0700
X-CSE-ConnectionGUID: L8b29UPGQ+iHnCb3FvLCxg==
X-CSE-MsgGUID: LaW3gcQfRke+KlzqwXJc/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="214636606"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by orviesa001.jf.intel.com with ESMTP; 25 Sep 2025 20:35:06 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	senozhatsky@chromium.org,
	sj@kernel.org,
	kasong@tencent.com,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	vinicius.gomes@intel.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v12 18/23] crypto: iaa - Add deflate-iaa-dynamic compression mode.
Date: Thu, 25 Sep 2025 20:34:57 -0700
Message-Id: <20250926033502.7486-19-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250926033502.7486-1-kanchana.p.sridhar@intel.com>
References: <20250926033502.7486-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some versions of Intel IAA support dynamic compression where the hardware
dynamically computes the Huffman tables and generates a Deflate header
if the input size is no larger than 4KB. This patch will use IAA for
dynamic compression if an appropriate IAA is present and the input size is
not too big. If an IAA is not present, the algorithm will not
be available. Otherwise, if the size of the input is greater than
PAGE_SIZE, zlib is used to do the compression. If the algorithm is
selected, IAA will be used for decompression. If the compressed stream
contains a reference whose distance is greater than 4KB, hardware
decompression will fail, and the decompression will be done with zlib.

Intel IAA dynamic compression results in a compression ratio that is
better than or equal to the currently supported "fixed" compression mode
on the same data set. Compressing a data set of 4300 4KB pages sampled
from SPEC CPU17 workloads produces a compression ratio of 3.14 for IAA
dynamic compression and 2.69 for IAA fixed compression.

If an appropriate IAA exists, dynamic mode can be chosen as the IAA
compression mode by selecting the corresponding algorithm.

For example, to use IAA dynamic mode in zswap:

      echo deflate-iaa-dynamic > /sys/module/zswap/parameters/compressor

This patch also adds a deflate_generic_compress() fallback when dynamic
mode is selected and the input size is over 4KB; along with stats
support that will count these software fallback calls as
"total_sw_comp_calls" in the driver's global_stats.

Furthermore, we define IAA_DYN_ALLOC_DESC_COMP_TIMEOUT as 2000 for
dynamic mode compression on Granite Rapids.

Signed-off-by: Andre Glover <andre.glover@linux.intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 .../driver-api/crypto/iaa/iaa-crypto.rst      | 21 ++++
 crypto/testmgr.c                              | 10 ++
 crypto/testmgr.h                              | 74 ++++++++++++++
 drivers/crypto/intel/iaa/Makefile             |  2 +-
 drivers/crypto/intel/iaa/iaa_crypto.h         |  5 +
 .../intel/iaa/iaa_crypto_comp_dynamic.c       | 22 +++++
 drivers/crypto/intel/iaa/iaa_crypto_main.c    | 98 +++++++++++++++++--
 drivers/crypto/intel/iaa/iaa_crypto_stats.c   |  8 ++
 drivers/crypto/intel/iaa/iaa_crypto_stats.h   |  2 +
 include/linux/iaa_comp.h                      |  5 +-
 10 files changed, 236 insertions(+), 11 deletions(-)
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_comp_dynamic.c

diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
index 81a7dbd15f8b..e841a33564db 100644
--- a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -33,6 +33,8 @@ compresses and decompresses.
 Currently, there is only one compression modes available, 'fixed'
 mode.
 
+'dynamic' mode is available on certain generations of IAA hardware.
+
 The 'fixed' compression mode implements the compression scheme
 specified by RFC 1951 and is given the crypto algorithm name
 'deflate-iaa'.  (Because the IAA hardware has a 4k history-window
@@ -43,6 +45,25 @@ the IAA fixed mode deflate algorithm is given its own algorithm name
 rather than simply 'deflate').
 
 
+The 'dynamic' compression mode implements a compression scheme where
+the IAA hardware will internally do one pass through the data, compute the
+Huffman tables and generate a Deflate header, then automatically do a
+second pass through the data, generating the final compressed output. IAA
+dynamic compression can be used if an appropriate IAA is present and the
+input size is not too big.  If an appropriate IAA is not present, the
+algorithm will not be available. Otherwise, if the size of the input is too
+big, zlib is used to do the compression. If the algorithm is selected,
+IAA will be used for decompression. If the compressed stream contains a
+reference whose distance is greater than 4KB, hardware decompression will
+fail, and the decompression will be done with zlib. If an appropriate IAA
+exists, 'dynamic' compression, it is implemented by the
+'deflate-iaa-dynamic' crypto algorithm.
+
+A zswap device can select the IAA 'dynamic' mode represented by
+selecting the 'deflate-iaa-dynamic' crypto compression algorithm::
+
+  # echo deflate-iaa-dynamic> /sys/module/zswap/parameters/compressor
+
 Config options and other setup
 ==============================
 
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index ee33ba21ae2b..d0f271ea1201 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4665,6 +4665,16 @@ static const struct alg_test_desc alg_test_descs[] = {
 				.decomp = __VECS(deflate_decomp_tv_template)
 			}
 		}
+	}, {
+		.alg = "deflate-iaa-dynamic",
+		.test = alg_test_comp,
+		.fips_allowed = 1,
+		.suite = {
+			.comp = {
+				.comp = __VECS(deflate_iaa_dynamic_comp_tv_template),
+				.decomp = __VECS(deflate_iaa_dynamic_decomp_tv_template)
+			}
+		}
 	}, {
 		.alg = "dh",
 		.test = alg_test_kpp,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 32d099ac9e73..42db2399013e 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -34575,6 +34575,80 @@ static const struct comp_testvec deflate_decomp_tv_template[] = {
 	},
 };
 
+static const struct comp_testvec deflate_iaa_dynamic_comp_tv_template[] = {
+	{
+		.inlen	= 70,
+		.outlen	= 46,
+		.input	= "Join us now and share the software "
+			"Join us now and share the software ",
+		.output = "\x85\xca\xc1\x09\x00\x20\x08\x05"
+			  "\xd0\x55\xfe\x3c\x6e\x21\x64\xd8"
+			  "\x45\x21\x0d\xd7\xb7\x26\xe8\xf8"
+			  "\xe0\x91\x2f\xc3\x09\x98\x17\xd8"
+			  "\x06\x42\x79\x0b\x52\x05\xe1\x33"
+			  "\xeb\x81\x3e\xe5\xa2\x01",
+	}, {
+		.inlen	= 191,
+		.outlen	= 121,
+		.input	= "This document describes a compression method based on the DEFLATE"
+			"compression algorithm.  This document defines the application of "
+			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
+		.output = "\x5d\x8d\xc1\x0d\xc2\x30\x10\x04"
+			  "\x5b\xd9\x0a\xd2\x03\x82\x20\x21"
+			  "\xf1\xf0\x23\x0d\x5c\xec\x0b\xb6"
+			  "\x64\xfb\x2c\xdf\xf1\xa0\x7b\x12"
+			  "\x3e\x58\x79\xae\x76\x67\x76\x89"
+			  "\x49\x11\xc4\xbf\x0b\x57\x43\x60"
+			  "\xf5\x3d\xad\xac\x20\x78\x29\xad"
+			  "\xb3\x6a\x92\x8a\xc2\x16\x25\x60"
+			  "\x25\xe5\x80\x3d\x5b\x64\xdc\xe6"
+			  "\xfb\xf3\xb2\xcc\xe3\x8c\xf2\x4b"
+			  "\x7a\xb2\x58\x26\xe0\x2c\xde\x52"
+			  "\xdd\xb5\x07\x48\xad\xe5\xe4\xc9"
+			  "\x0e\x42\xb6\xd1\xf5\x17\xc0\xe4"
+			  "\x57\x3c\x1c\x1c\x7d\xb2\x50\xc0"
+			  "\x75\x38\x72\x5d\x4c\xbc\xe4\xe9"
+			  "\x0b",
+	},
+};
+
+static const struct comp_testvec deflate_iaa_dynamic_decomp_tv_template[] = {
+	{
+		.inlen	= 121,
+		.outlen	= 191,
+		.input	= "\x5d\x8d\xc1\x0d\xc2\x30\x10\x04"
+			  "\x5b\xd9\x0a\xd2\x03\x82\x20\x21"
+			  "\xf1\xf0\x23\x0d\x5c\xec\x0b\xb6"
+			  "\x64\xfb\x2c\xdf\xf1\xa0\x7b\x12"
+			  "\x3e\x58\x79\xae\x76\x67\x76\x89"
+			  "\x49\x11\xc4\xbf\x0b\x57\x43\x60"
+			  "\xf5\x3d\xad\xac\x20\x78\x29\xad"
+			  "\xb3\x6a\x92\x8a\xc2\x16\x25\x60"
+			  "\x25\xe5\x80\x3d\x5b\x64\xdc\xe6"
+			  "\xfb\xf3\xb2\xcc\xe3\x8c\xf2\x4b"
+			  "\x7a\xb2\x58\x26\xe0\x2c\xde\x52"
+			  "\xdd\xb5\x07\x48\xad\xe5\xe4\xc9"
+			  "\x0e\x42\xb6\xd1\xf5\x17\xc0\xe4"
+			  "\x57\x3c\x1c\x1c\x7d\xb2\x50\xc0"
+			  "\x75\x38\x72\x5d\x4c\xbc\xe4\xe9"
+			  "\x0b",
+		.output	= "This document describes a compression method based on the DEFLATE"
+			"compression algorithm.  This document defines the application of "
+			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
+	}, {
+		.inlen	= 46,
+		.outlen	= 70,
+		.input	= "\x85\xca\xc1\x09\x00\x20\x08\x05"
+			  "\xd0\x55\xfe\x3c\x6e\x21\x64\xd8"
+			  "\x45\x21\x0d\xd7\xb7\x26\xe8\xf8"
+			  "\xe0\x91\x2f\xc3\x09\x98\x17\xd8"
+			  "\x06\x42\x79\x0b\x52\x05\xe1\x33"
+			  "\xeb\x81\x3e\xe5\xa2\x01",
+		.output	= "Join us now and share the software "
+			"Join us now and share the software ",
+	},
+};
+
 /*
  * LZO test vectors (null-terminated strings).
  */
diff --git a/drivers/crypto/intel/iaa/Makefile b/drivers/crypto/intel/iaa/Makefile
index ebfa1a425f80..96f22cd39924 100644
--- a/drivers/crypto/intel/iaa/Makefile
+++ b/drivers/crypto/intel/iaa/Makefile
@@ -7,6 +7,6 @@ ccflags-y += -I $(srctree)/drivers/dma/idxd -DDEFAULT_SYMBOL_NAMESPACE='"CRYPTO_
 
 obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) := iaa_crypto.o
 
-iaa_crypto-y := iaa_crypto_main.o iaa_crypto_comp_fixed.o
+iaa_crypto-y := iaa_crypto_main.o iaa_crypto_comp_fixed.o iaa_crypto_comp_dynamic.o
 
 iaa_crypto-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS) += iaa_crypto_stats.o
diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index db1e50574662..5a8dec3be9fa 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -19,12 +19,15 @@
 
 #define IAA_COMP_FLUSH_OUTPUT		BIT(1)
 #define IAA_COMP_APPEND_EOB		BIT(2)
+#define IAA_COMP_GEN_HDR_1_PASS		(BIT(12) | BIT(13))
 
 #define IAA_COMPLETION_TIMEOUT		1000000
 
 #define IAA_ALLOC_DESC_COMP_TIMEOUT	   1000
 #define IAA_ALLOC_DESC_DECOMP_TIMEOUT	    500
 
+#define IAA_DYN_ALLOC_DESC_COMP_TIMEOUT	   2000
+
 #define IAA_ANALYTICS_ERROR		0x0a
 #define IAA_ERROR_DECOMP_BUF_OVERFLOW	0x0b
 #define IAA_ERROR_COMP_BUF_OVERFLOW	0x19
@@ -134,6 +137,8 @@ struct aecs_comp_table_record {
 
 int iaa_aecs_init_fixed(void);
 void iaa_aecs_cleanup_fixed(void);
+int iaa_aecs_init_dynamic(void);
+void iaa_aecs_cleanup_dynamic(void);
 
 typedef int (*iaa_dev_comp_init_fn_t) (struct iaa_device_compression_mode *mode);
 typedef int (*iaa_dev_comp_free_fn_t) (struct iaa_device_compression_mode *mode);
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_comp_dynamic.c b/drivers/crypto/intel/iaa/iaa_crypto_comp_dynamic.c
new file mode 100644
index 000000000000..3a93d7913443
--- /dev/null
+++ b/drivers/crypto/intel/iaa/iaa_crypto_comp_dynamic.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2023 Intel Corporation. All rights rsvd. */
+
+#include "idxd.h"
+#include "iaa_crypto.h"
+
+int iaa_aecs_init_dynamic(void)
+{
+	int ret;
+
+	ret = add_iaa_compression_mode("dynamic", NULL, 0, NULL, 0, NULL, NULL);
+
+	if (!ret)
+		pr_debug("IAA dynamic compression mode initialized\n");
+
+	return ret;
+}
+
+void iaa_aecs_cleanup_dynamic(void)
+{
+	remove_iaa_compression_mode("dynamic");
+}
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 0669ae155e90..cbe3a2457253 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -102,10 +102,12 @@ DEFINE_MUTEX(first_wq_found_lock);
 
 const char *iaa_compression_mode_names[IAA_COMP_MODES_MAX] = {
 	"fixed",
+	"dynamic",
 };
 
 const char *iaa_compression_alg_names[IAA_COMP_MODES_MAX] = {
 	"deflate-iaa",
+	"deflate-iaa-dynamic",
 };
 
 static struct iaa_compression_mode *iaa_compression_modes[IAA_COMP_MODES_MAX];
@@ -1482,6 +1484,23 @@ static int deflate_generic_decompress(struct iaa_req *req)
 	return ret;
 }
 
+static int deflate_generic_compress(struct iaa_req *req)
+{
+	ACOMP_REQUEST_ON_STACK(fbreq, deflate_crypto_acomp);
+	int ret;
+
+	acomp_request_set_callback(fbreq, 0, NULL, NULL);
+	acomp_request_set_params(fbreq, req->src, req->dst, req->slen,
+				 PAGE_SIZE);
+
+	ret = crypto_acomp_compress(fbreq);
+	req->dlen = fbreq->dlen;
+
+	update_total_sw_comp_calls();
+
+	return ret;
+}
+
 static __always_inline void acomp_to_iaa(struct acomp_req *areq,
 					 struct iaa_req *req,
 					 struct iaa_compression_ctx *ctx)
@@ -1808,9 +1827,13 @@ iaa_setup_compress_hw_desc(struct idxd_desc *idxd_desc,
 	desc->src1_size = slen;
 	desc->dst_addr = (u64)dst_addr;
 	desc->max_dst_size = dlen;
-	desc->flags |= IDXD_OP_FLAG_RD_SRC2_AECS;
-	desc->src2_addr = active_compression_mode->aecs_comp_table_dma_addr;
-	desc->src2_size = sizeof(struct aecs_comp_table_record);
+	if (mode == IAA_MODE_DYNAMIC) {
+		desc->compr_flags |= IAA_COMP_GEN_HDR_1_PASS;
+	} else {
+		desc->flags |= IDXD_OP_FLAG_RD_SRC2_AECS;
+		desc->src2_addr = active_compression_mode->aecs_comp_table_dma_addr;
+		desc->src2_size = sizeof(struct aecs_comp_table_record);
+	}
 	desc->completion_addr = idxd_desc->compl_dma;
 
 	return desc;
@@ -2064,6 +2087,9 @@ static int iaa_comp_acompress(struct iaa_compression_ctx *ctx, struct iaa_req *r
 		return -EINVAL;
 	}
 
+	if (ctx->mode == IAA_MODE_DYNAMIC && req->slen > PAGE_SIZE)
+		return deflate_generic_compress(req);
+
 	cpu = get_cpu();
 	wq = comp_wq_table_next_wq(cpu);
 	put_cpu();
@@ -2546,7 +2572,9 @@ static int iaa_comp_adecompress_batch(
 static void compression_ctx_init(struct iaa_compression_ctx *ctx, enum iaa_mode mode)
 {
 	ctx->mode = mode;
-	ctx->alloc_comp_desc_timeout = IAA_ALLOC_DESC_COMP_TIMEOUT;
+	ctx->alloc_comp_desc_timeout = (mode == IAA_MODE_DYNAMIC ?
+					IAA_DYN_ALLOC_DESC_COMP_TIMEOUT :
+					IAA_ALLOC_DESC_COMP_TIMEOUT);
 	ctx->alloc_decomp_desc_timeout = IAA_ALLOC_DESC_DECOMP_TIMEOUT;
 	ctx->verify_compress = iaa_verify_compress;
 	ctx->async_mode = async_mode;
@@ -2760,6 +2788,30 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
 	}
 };
 
+static int iaa_comp_init_dynamic(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	ctx = iaa_ctx[IAA_MODE_DYNAMIC];
+
+	return 0;
+}
+
+static struct acomp_alg iaa_acomp_dynamic_deflate = {
+	.init			= iaa_comp_init_dynamic,
+	.compress		= iaa_comp_acompress_main,
+	.decompress		= iaa_comp_adecompress_main,
+	.base			= {
+		.cra_name		= "deflate",
+		.cra_driver_name	= "deflate-iaa-dynamic",
+		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
+		.cra_module		= THIS_MODULE,
+		.cra_priority		= IAA_ALG_PRIORITY + 1,
+	}
+};
+
 /*******************************************
  * Implement idxd_device_driver interfaces.
  *******************************************/
@@ -2779,7 +2831,7 @@ static void iaa_unregister_compression_device(void)
 	num_iaa_modes_registered = 0;
 }
 
-static int iaa_register_compression_device(void)
+static int iaa_register_compression_device(struct idxd_device *idxd)
 {
 	struct iaa_compression_mode *mode;
 	int i, idx;
@@ -2788,6 +2840,13 @@ static int iaa_register_compression_device(void)
 		iaa_mode_registered[i] = false;
 		mode = find_iaa_compression_mode(iaa_compression_mode_names[i], &idx);
 		if (mode) {
+			/* Header Generation Capability is required for the dynamic algorithm. */
+			if ((!strcmp(mode->name, "dynamic")) && !idxd->hw.iaa_cap.header_gen) {
+				if (num_iaa_modes_registered > 0)
+					--num_iaa_modes_registered;
+				continue;
+			}
+
 			iaa_ctx[i] = kmalloc(sizeof(struct iaa_compression_ctx), GFP_KERNEL);
 			if (!iaa_ctx[i])
 				goto err;
@@ -2805,7 +2864,7 @@ static int iaa_register_compression_device(void)
 	return -ENODEV;
 }
 
-static int iaa_register_acomp_compression_device(void)
+static int iaa_register_acomp_compression_device(struct idxd_device *idxd)
 {
 	int ret = -ENOMEM;
 
@@ -2819,8 +2878,19 @@ static int iaa_register_acomp_compression_device(void)
 		goto err_fixed;
 	}
 
+	if (iaa_mode_registered[IAA_MODE_DYNAMIC]) {
+		ret = crypto_register_acomp(&iaa_acomp_dynamic_deflate);
+		if (ret) {
+			pr_err("deflate algorithm acomp dynamic registration failed (%d)\n", ret);
+			goto err_dynamic;
+		}
+	}
+
 	return 0;
 
+err_dynamic:
+	crypto_unregister_acomp(&iaa_acomp_fixed_deflate);
+
 err_fixed:
 	if (!IS_ERR_OR_NULL(deflate_crypto_acomp)) {
 		crypto_free_acomp(deflate_crypto_acomp);
@@ -2839,6 +2909,9 @@ static void iaa_unregister_acomp_compression_device(void)
 	if (iaa_mode_registered[IAA_MODE_FIXED])
 		crypto_unregister_acomp(&iaa_acomp_fixed_deflate);
 
+	if (iaa_mode_registered[IAA_MODE_DYNAMIC])
+		crypto_unregister_acomp(&iaa_acomp_dynamic_deflate);
+
 	if (!IS_ERR_OR_NULL(deflate_crypto_acomp)) {
 		crypto_free_acomp(deflate_crypto_acomp);
 		deflate_crypto_acomp = NULL;
@@ -2906,13 +2979,13 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 	atomic_set(&iaa_crypto_enabled, 1);
 
 	if (first_wq) {
-		ret = iaa_register_compression_device();
+		ret = iaa_register_compression_device(idxd);
 		if (ret != 0) {
 			dev_dbg(dev, "IAA compression device registration failed\n");
 			goto err_register;
 		}
 
-		ret = iaa_register_acomp_compression_device();
+		ret = iaa_register_acomp_compression_device(idxd);
 		if (ret != 0) {
 			dev_dbg(dev, "IAA compression device acomp registration failed\n");
 			goto err_register;
@@ -3063,6 +3136,12 @@ static int __init iaa_crypto_init_module(void)
 		goto err_aecs_init;
 	}
 
+	ret = iaa_aecs_init_dynamic();
+	if (ret < 0) {
+		pr_debug("IAA dynamic compression mode init failed\n");
+		goto err_dynamic;
+	}
+
 	ret = idxd_driver_register(&iaa_crypto_driver);
 	if (ret) {
 		pr_debug("IAA wq sub-driver registration failed\n");
@@ -3164,6 +3243,8 @@ static int __init iaa_crypto_init_module(void)
 err_g_comp_wqs_per_iaa_attr_create:
 	idxd_driver_unregister(&iaa_crypto_driver);
 err_driver_reg:
+	iaa_aecs_cleanup_dynamic();
+err_dynamic:
 	iaa_aecs_cleanup_fixed();
 err_aecs_init:
 
@@ -3188,6 +3269,7 @@ static void __exit iaa_crypto_cleanup_module(void)
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_g_comp_wqs_per_iaa);
 	idxd_driver_unregister(&iaa_crypto_driver);
+	iaa_aecs_cleanup_dynamic();
 	iaa_aecs_cleanup_fixed();
 
 	pr_debug("cleaned up\n");
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index f5cc3d29ca19..42aae8a738ac 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -19,6 +19,7 @@
 
 static atomic64_t total_comp_calls;
 static atomic64_t total_decomp_calls;
+static atomic64_t total_sw_comp_calls;
 static atomic64_t total_sw_decomp_calls;
 static atomic64_t total_comp_bytes_out;
 static atomic64_t total_decomp_bytes_in;
@@ -43,6 +44,11 @@ void update_total_decomp_calls(void)
 	atomic64_inc(&total_decomp_calls);
 }
 
+void update_total_sw_comp_calls(void)
+{
+	atomic64_inc(&total_sw_comp_calls);
+}
+
 void update_total_sw_decomp_calls(void)
 {
 	atomic64_inc(&total_sw_decomp_calls);
@@ -174,6 +180,8 @@ static int global_stats_show(struct seq_file *m, void *v)
 		   atomic64_read(&total_comp_calls));
 	seq_printf(m, "  total_decomp_calls: %llu\n",
 		   atomic64_read(&total_decomp_calls));
+	seq_printf(m, "  total_sw_comp_calls: %llu\n",
+		   atomic64_read(&total_sw_comp_calls));
 	seq_printf(m, "  total_sw_decomp_calls: %llu\n",
 		   atomic64_read(&total_sw_decomp_calls));
 	seq_printf(m, "  total_comp_bytes_out: %llu\n",
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.h b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
index 3787a5f507eb..6e0c6f9939bf 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
@@ -11,6 +11,7 @@ void	iaa_crypto_debugfs_cleanup(void);
 void	update_total_comp_calls(void);
 void	update_total_comp_bytes_out(int n);
 void	update_total_decomp_calls(void);
+void	update_total_sw_comp_calls(void);
 void	update_total_sw_decomp_calls(void);
 void	update_total_decomp_bytes_in(int n);
 void	update_completion_einval_errs(void);
@@ -29,6 +30,7 @@ static inline void	iaa_crypto_debugfs_cleanup(void) {}
 static inline void	update_total_comp_calls(void) {}
 static inline void	update_total_comp_bytes_out(int n) {}
 static inline void	update_total_decomp_calls(void) {}
+static inline void	update_total_sw_comp_calls(void) {}
 static inline void	update_total_sw_decomp_calls(void) {}
 static inline void	update_total_decomp_bytes_in(int n) {}
 static inline void	update_completion_einval_errs(void) {}
diff --git a/include/linux/iaa_comp.h b/include/linux/iaa_comp.h
index 7b765760485c..ec28a9d9f2b4 100644
--- a/include/linux/iaa_comp.h
+++ b/include/linux/iaa_comp.h
@@ -12,7 +12,8 @@
 
 enum iaa_mode {
 	IAA_MODE_FIXED = 0,
-	IAA_MODE_NONE = 1,
+	IAA_MODE_DYNAMIC = 1,
+	IAA_MODE_NONE = 2,
 };
 
 struct iaa_req {
@@ -56,7 +57,7 @@ extern int iaa_comp_decompress_batch(
 #else /* CONFIG_CRYPTO_DEV_IAA_CRYPTO */
 
 enum iaa_mode {
-	IAA_MODE_NONE = 1,
+	IAA_MODE_NONE = 2,
 };
 
 struct iaa_req {};
-- 
2.27.0


