Return-Path: <linux-kernel+bounces-771411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6044FB286B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1626DB04D83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472F29A9E6;
	Fri, 15 Aug 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Bp+lJA6J"
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C062288D5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287585; cv=none; b=C3wH+yyFJpUz+zM6/bqK5yGnv3MYz0Q/OIHk2E4flc04/5QHE0gUW442kQKsqAYVS3+pqKVv7FrqBTlESI5US+AXVP28OeMopQEoz/poDAtWRI+AU378wXUKajzds388fwNR704rQS5JoudKOqfmssji4K0ujrkM7CI3lOnmDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287585; c=relaxed/simple;
	bh=x92zVQNMZzDOH2cvOB+047T4zZpTmVv+/3XQay17u4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8SDdSoAvOCptxLcD22z2CkIGKUi1c6FTcjGqzConDEYQs+WQ8Imxn8aWkGkcRIYoI7w5MXJilod6clKdrGqIgKFzFu8mebs79HM4N4qz5/a3OMZ+PyNW9sVBkvblNFOWNa5iGY/Jy3OQCKd58zySK31xeVTXNM8Kx5fNU0pmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Bp+lJA6J; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202508151912437213f75c34ffdeb15b
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Aug 2025 21:12:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=B5JIt8JUCWyoCLiiDyVPQuDaUtKXoi8UQzuy3UgNRf0=;
 b=Bp+lJA6JCPtntWDmrUIPaNasoO198Xrz3XAG+ebELqAxryy64IHMHOH0cj1g+KsRWRI9Ex
 sekUoNIGTT3skdIhI9oVuqEHn5WGyoq/MCALpM/4a5cND3Spv694IBPPZk6x6WVlilCa1pHW
 k4jtenDY2rhZp0PWSKTc3QfU6log535N/2ma5oal2624C9VJXvkP6Cn2vmQ6rgjgO4pQtKGJ
 N6FoTAFcwd5E8EdCJms7JmyRZs93TFgneB5pEnQONKn5wAZZKUsNgX4LCjQloxLTdsVZxPFr
 mD6TbGS9di3v5XgXyqk23lD2JfU/ZooIh+az9Ruq/4NeWH7bwvOXSdTw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 2/3] efi: stmm: Use EFI return code of setup_mm_hdr
Date: Fri, 15 Aug 2025 21:12:40 +0200
Message-ID: <c53346c183ce0c3d02322726ef5808f468441a42.1755285161.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1755285161.git.jan.kiszka@siemens.com>
References: <cover.1755285161.git.jan.kiszka@siemens.com>
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

If a too large payload_size is passed to setup_mm_hdr, callers will
returned EFI_OUT_OF_RESOURCES rather than EFI_INVALID_PARAMETER that is
passed down via ret. No need to fold errors here.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index 706ba095a4ba..bf992b42be70 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -220,7 +220,7 @@ static efi_status_t get_max_payload(size_t *size)
 				   SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
 				   &ret);
 	if (!var_payload)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	ret = mm_communicate(comm_buf, payload_size);
 	if (ret != EFI_SUCCESS)
@@ -267,7 +267,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
 		&comm_buf, &nr_pages, payload_size,
 		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
 	if (!smm_property)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	memcpy(&smm_property->guid, vendor, sizeof(smm_property->guid));
 	smm_property->name_size = name_size;
@@ -324,7 +324,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
 	var_acc = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
 			       SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
 	if (!var_acc)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	/* Fill in contents */
 	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
@@ -391,7 +391,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
 				   SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
 				   &ret);
 	if (!var_getnext)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	/* Fill in contents */
 	memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
@@ -448,7 +448,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	var_acc = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
 			       SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
 	if (!var_acc)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	/*
 	 * The API has the ability to override RO flags. If no RO check was
@@ -505,7 +505,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
 				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
 				&ret);
 	if (!mm_query_info)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	mm_query_info->attr = attributes;
 	ret = mm_communicate(comm_buf, payload_size);
-- 
2.43.0


