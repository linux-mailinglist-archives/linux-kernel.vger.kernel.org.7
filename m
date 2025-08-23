Return-Path: <linux-kernel+bounces-783280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638D8B32B43
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F56A5C5305
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CF2EA47E;
	Sat, 23 Aug 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="XKkXNQ1V"
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A321ABA4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755969748; cv=none; b=W+RIkt9hbnXGrYU/EG/AZlp3jY4GaiuSTMBJoYzmM1zx3KaP7IRCprzYI0iOz+RBQ2vF6C6mFE8OFxW1oRe3kXuSK1hzkP/qAx4vKQ5C+8mKquFTduWyeJGsoZ+3h449nd4Tc2rCOuzoNfVgs1mhMr2iOASdoGTBOBbOMe44YEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755969748; c=relaxed/simple;
	bh=/ThtVqdLaddiWNRtFgh0u7MoHvhX48j+RzKo4JsLSos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmaRjAyrWtjdDmr+bLQqV6Nf+26bKvRV6isHep0eZNCKo+7AuF5zXyeJdFDBBRcLnqC9AfeQmAdMUjIqgStTu4BgdDIv2hr3SUdU4PxdJM2uewZ4ja1g8yYynZpWdpUMv+rxA6TL3WBUek2n5KVY5NfpASt6KBee0QJvYAWRfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=XKkXNQ1V; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202508231722166de164d888bbfde842
        for <linux-kernel@vger.kernel.org>;
        Sat, 23 Aug 2025 19:22:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gtL0mnBMLqcMAT/NwTJI74s2wCyTzV/KL7vW90ojfyU=;
 b=XKkXNQ1Veh9bfRSrOJf/m4VpMErILIMfpvPT3fQNePwW+RuwA1p2iBhr4H2oSdT0mJkgGO
 5MW5Kd4qzx4E8eolubblz9rUOTuY5kjVQxDN12sLRNlCNmrSg2IN8+U93mGFnlYygeCTRUJH
 fuQVyBlvQz7pl3wyqMkuSE/qiJvD2hA2MJCWc7/EbHQ7ev1SXc8sjABTcFL4CRkRfodPxo0T
 bHZKkfhxMQ/GaKxOathxd6mX7QwtgOhigrwYJwAChyXeNTvBTQjlnzfLvR6RsnfVdE5P+Gpm
 Ck3OUCorllz2em6KER4e1kwgGQrXd8JmWfig4KCZ309uTd6aKhaR0U/w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v2 1/4] efi: stmm: Fix incorrect buffer allocation method
Date: Sat, 23 Aug 2025 19:22:11 +0200
Message-ID: <c7ddb74b514c36ed4f612bc2125245c1f68c0a4d.1755969734.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1755969734.git.jan.kiszka@siemens.com>
References: <cover.1755969734.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The communication buffer allocated by setup_mm_hdr is later on passed to
tee_shm_register_kernel_buf. The latter expects those buffers to be
contiguous pages, but setup_mm_hdr just uses kmalloc. That can cause
various corruptions or BUGs, specifically since 9aec2fb0fd5e, though it
was broken before as well.

Fix this by using alloc_pages_exact instead of kmalloc.

Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index f741ca279052..e15d11ed165e 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -143,6 +143,10 @@ static efi_status_t mm_communicate(u8 *comm_buf, size_t payload_size)
 	return var_hdr->ret_status;
 }
 
+#define COMM_BUF_SIZE(__payload_size)	(MM_COMMUNICATE_HEADER_SIZE + \
+					 MM_VARIABLE_COMMUNICATE_SIZE + \
+					 (__payload_size))
+
 /**
  * setup_mm_hdr() -	Allocate a buffer for StandAloneMM and initialize the
  *			header data.
@@ -173,9 +177,8 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
 		return NULL;
 	}
 
-	comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
-				   MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
-			   GFP_KERNEL);
+	comm_buf = alloc_pages_exact(COMM_BUF_SIZE(payload_size),
+				     GFP_KERNEL | __GFP_ZERO);
 	if (!comm_buf) {
 		*ret = EFI_OUT_OF_RESOURCES;
 		return NULL;
@@ -239,7 +242,7 @@ static efi_status_t get_max_payload(size_t *size)
 	 */
 	*size -= 2;
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
@@ -282,7 +285,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
 	memcpy(var_property, &smm_property->property, sizeof(*var_property));
 
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
@@ -347,7 +350,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
 	memcpy(data, (u8 *)var_acc->name + var_acc->name_size,
 	       var_acc->data_size);
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
@@ -404,7 +407,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
 	memcpy(name, var_getnext->name, var_getnext->name_size);
 
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
@@ -467,7 +470,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	ret = mm_communicate(comm_buf, payload_size);
 	dev_dbg(pvt_data.dev, "Set Variable %s %d %lx\n", __FILE__, __LINE__, ret);
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
@@ -507,7 +510,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
 	*max_variable_size = mm_query_info->max_variable_size;
 
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
-- 
2.43.0


