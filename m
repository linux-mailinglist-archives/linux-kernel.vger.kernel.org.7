Return-Path: <linux-kernel+bounces-783279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED19B32B3F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC941BC3278
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231932E9ED9;
	Sat, 23 Aug 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="NQiygpgW"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A772E718A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755969748; cv=none; b=ImlohrEVjGw06zp3roT25yiKcnjkQueJJPb+DXdXhZ7grJR1MwTyP9ayQzAr1c3GbJx4XIFoRHj2FqbZBLe1jTkq3u6swkeBb5bYwkR1LQjncLpzHed/imcYJfxwmc421h6rxpDqtQz56Qqjq3EcEdLuaZ/cqxKo0PRI83ntWeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755969748; c=relaxed/simple;
	bh=2BDfMFH+GjJUu7SQq2EriZ5TFY/wqvJTs4t6yXPB7YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0DMyJMjVhhVUcTWjzGrcF7MO6K9exbzmvkQPy8X2TYDYmtl9I3QzDXlp9kIELfy5YiaaaB89QP7SBFE/Ey/KzhlEQItsjVa/4UJJeFbru9s1fmr68A4XZGcCM3VYWZWJ2c1f2vwjlOpNs4w4hhjTEW4ScFn0q8adR64nn0J1cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=NQiygpgW; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250823172217ffbdbec841ec024a07
        for <linux-kernel@vger.kernel.org>;
        Sat, 23 Aug 2025 19:22:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8TOSs70Y6gA6YolDQ/9R1EGvkwePCg7OrkxR2NJSog0=;
 b=NQiygpgW4bmQGR87xD3cesVhg8HY1KvTW1G19jGe/4quVClP62j6doNLvCeWc0L5bU3kit
 HbIAtTi8Ku/RHQG3C/GWxe2S0/0WhQmELC+GZ3KZUY7n71PIBGCYZAwtpijKhndxEgzeUv/a
 t/ivwzD80hjmdQ8EC4qm9EMpdqIeaz13QeTjjqCLs0lJKZwrCL5GyuvljAcC61rmrODV8Mc8
 PhFS9a9s77ADjD7LBznCQtycXoXn2FteIJ58rtnOyyQqfT+TvIepIRlch2f+EtzJc0I/5OGY
 z8GLFpHZEWRcPJYs6QKQwTGfPTmmJwT33fRWQ+64QN6xsUiOQNMXGRbg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v2 3/4] efi: stmm: Drop unused EFI error from setup_mm_hdr arguments
Date: Sat, 23 Aug 2025 19:22:13 +0200
Message-ID: <445bbda26e505e06b9b830cb9938ac57e847b28e.1755969734.git.jan.kiszka@siemens.com>
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

No caller evaluates it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 25 ++++++++----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index 8501056ade8a..c2bc8467b099 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -154,11 +154,9 @@ static efi_status_t mm_communicate(u8 *comm_buf, size_t payload_size)
  * @dptr:		pointer address to store allocated buffer
  * @payload_size:	payload size
  * @func:		standAloneMM function number
- * @ret:		EFI return code
  * Return:		pointer to corresponding StandAloneMM function buffer or NULL
  */
-static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
-			  efi_status_t *ret)
+static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func)
 {
 	const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
 	struct efi_mm_communicate_header *mm_hdr;
@@ -173,16 +171,13 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
 	if (max_buffer_size &&
 	    max_buffer_size < (MM_COMMUNICATE_HEADER_SIZE +
 			       MM_VARIABLE_COMMUNICATE_SIZE + payload_size)) {
-		*ret = EFI_INVALID_PARAMETER;
 		return NULL;
 	}
 
 	comm_buf = alloc_pages_exact(COMM_BUF_SIZE(payload_size),
 				     GFP_KERNEL | __GFP_ZERO);
-	if (!comm_buf) {
-		*ret = EFI_OUT_OF_RESOURCES;
+	if (!comm_buf)
 		return NULL;
-	}
 
 	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
 	memcpy(&mm_hdr->header_guid, &mm_var_guid, sizeof(mm_hdr->header_guid));
@@ -192,7 +187,6 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
 	var_hdr->function = func;
 	if (dptr)
 		*dptr = comm_buf;
-	*ret = EFI_SUCCESS;
 
 	return var_hdr->data;
 }
@@ -215,8 +209,7 @@ static efi_status_t get_max_payload(size_t *size)
 
 	payload_size = sizeof(*var_payload);
 	var_payload = setup_mm_hdr(&comm_buf, payload_size,
-				   SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
-				   &ret);
+				   SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE);
 	if (!var_payload)
 		return EFI_DEVICE_ERROR;
 
@@ -262,7 +255,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
 
 	smm_property = setup_mm_hdr(
 		&comm_buf, payload_size,
-		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
+		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET);
 	if (!smm_property)
 		return EFI_DEVICE_ERROR;
 
@@ -318,7 +311,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
 
 	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
 	var_acc = setup_mm_hdr(&comm_buf, payload_size,
-			       SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
+			       SMM_VARIABLE_FUNCTION_GET_VARIABLE);
 	if (!var_acc)
 		return EFI_DEVICE_ERROR;
 
@@ -383,8 +376,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
 
 	payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
 	var_getnext = setup_mm_hdr(&comm_buf, payload_size,
-				   SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
-				   &ret);
+				SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME);
 	if (!var_getnext)
 		return EFI_DEVICE_ERROR;
 
@@ -440,7 +432,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	 * the properties, if the allocation fails
 	 */
 	var_acc = setup_mm_hdr(&comm_buf, payload_size,
-			       SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
+			       SMM_VARIABLE_FUNCTION_SET_VARIABLE);
 	if (!var_acc)
 		return EFI_DEVICE_ERROR;
 
@@ -495,8 +487,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
 
 	payload_size = sizeof(*mm_query_info);
 	mm_query_info = setup_mm_hdr(&comm_buf, payload_size,
-				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
-				&ret);
+				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO);
 	if (!mm_query_info)
 		return EFI_DEVICE_ERROR;
 
-- 
2.43.0


