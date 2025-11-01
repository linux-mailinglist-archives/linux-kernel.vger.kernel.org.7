Return-Path: <linux-kernel+bounces-881334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE22AC28083
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70213BF98C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32335238159;
	Sat,  1 Nov 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TBgUo5xI"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E77261B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762005901; cv=none; b=TczYC25ewjA57H/6rdY9QYV6GoNpMPZwP6G5vi76i94g+N5aWZmE1yT/6EoujIcZbUVzdz47JqAT9p0zdMqT5LA1RaDZHDj0/ssM6skbwt/omk7IJKk2AQrjYPpcqvhuXcysIB8Xtab7XZS/mUQRy3ph6tjeGom8jG2AqltAlGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762005901; c=relaxed/simple;
	bh=SQ38qYTNJxk5DYz0GtHJiiInMCX0D2KO2qM0xpn1akg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmZIUqRp7DMK0kVSxmHuf4U30xDSB8fuurd6if6g6nsDNyFD0JXeckUSEX9TuRUyV4PXrHy9tVsamuRhyWnkV7dEJt9sq1IoONx8WgFFi+Py1yGYPvR0TO/ahPCbMzqxKzPK4g8wx3MoFoCHp35qtrz34VSunO4fYP7qyefwaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TBgUo5xI; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762005896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GeA2oPtPm0WGain9EgMxJLDlTytvn/JelbYftagDkAI=;
	b=TBgUo5xIH0RcEGr3LoS4cfOyE5O7PsYWwEd+Yc9phTdUd6TRM+Kh97F2csTOOF/W5htME3
	VDcWvB1DIrbEDGhqEv3jT2HXNLdYKhXBAZs1WatoW6CMxahzL6oipj6cIy2accYemYRwSP
	R5Lx27drlAX7uD32T8R4GNWuT/xvrho=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Sai Krishna <saikrishnag@marvell.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: octeontx2 - Replace deprecated strcpy in cpt_ucode_load_fw
Date: Sat,  1 Nov 2025 15:04:42 +0100
Message-ID: <20251101140445.2226-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use the safer strscpy() instead.

The destination buffer is only zero-initialized for the first iteration
and since strscpy() guarantees its NUL termination anyway, remove
zero-initializing 'eng_type'.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index ebdf4efa09d4..b5cc5401f704 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -3,6 +3,7 @@
 
 #include <linux/ctype.h>
 #include <linux/firmware.h>
+#include <linux/string.h>
 #include <linux/string_choices.h>
 #include "otx2_cptpf_ucode.h"
 #include "otx2_cpt_common.h"
@@ -458,13 +459,13 @@ static int cpt_ucode_load_fw(struct pci_dev *pdev, struct fw_info_t *fw_info,
 			     u16 rid)
 {
 	char filename[OTX2_CPT_NAME_LENGTH];
-	char eng_type[8] = {0};
+	char eng_type[8];
 	int ret, e, i;
 
 	INIT_LIST_HEAD(&fw_info->ucodes);
 
 	for (e = 1; e < OTX2_CPT_MAX_ENG_TYPES; e++) {
-		strcpy(eng_type, get_eng_type_str(e));
+		strscpy(eng_type, get_eng_type_str(e));
 		for (i = 0; i < strlen(eng_type); i++)
 			eng_type[i] = tolower(eng_type[i]);
 
-- 
2.51.1


