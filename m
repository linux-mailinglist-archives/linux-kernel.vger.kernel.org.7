Return-Path: <linux-kernel+bounces-785155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55EB346BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC0C7A2DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B593002A8;
	Mon, 25 Aug 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="c711gE2+"
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D919006B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138044; cv=none; b=cggvYSRvK4dPRL6YA/57fmrVmeo7qrGf1G/hwmv8uUUFIxexr8g5hiQoXZThGkAv/atXHKvWEQNHabLARTjqPMJLiucxZqlXDcBlR4+yX3kagFWKWALJ/P44CEOdX1vrYacR/iPxckE35OhWb+klrxDgDXm03sgWKAR0dL2mw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138044; c=relaxed/simple;
	bh=afEhyXcerRxJ2pUFrVuQ80HLCcLlpdreIpO7q+Efovc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYu7H6qUGYsdlSU5O1vT7f97BPCk92X7gIi1c6CGnbSfykrOuM4IlGj3OMSj1B6eywd3CKfnoKicmIPriklidKTqJw5XeqINH64ZKZkm9OOiWby/36pjywxRg8O74K0OkknsryDWGdYs4d08Ygeo/TfBoU+x9bLm98HVmiggCBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=c711gE2+; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250825160714648d4538d38de45353
        for <linux-kernel@vger.kernel.org>;
        Mon, 25 Aug 2025 18:07:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9B4yx0Y9gMLMy4+y7N4u4X2Mzh1VO2RHXLHiQLJZ9As=;
 b=c711gE2+yk5VvuqNyfW5+c93AyfEngpAFlCfSD+E+ScuDPwn3hmycBW4iCYp0zruY2NDgR
 nv9RDpwfMdm1kAdbkbK/liXhxAdYHMr8YY2GhfiZxU80J2YziGW/qSgYc8tR4/PObW6KOPew
 +RcCq5RfN//bNAZvobQG46cSdVDNMOPcPFxO1uMAasYCIZhokQcW9crie6+VUaculL1NVes9
 Ek+YCHNYBOmxH9l2+FwMK+6vOVdbsgRivrLpeo+HT5+Wu/sypnSjzROevetCKGNNmisiA2oY
 c2F8tvO48r1etP7vs5Y22gtuwGBFkewB6kt+sNeAHZWeDnC7YYMYg+kQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v3 4/4] efi: stmm: Drop unneeded null pointer check
Date: Mon, 25 Aug 2025 18:07:13 +0200
Message-ID: <b273210fea6dfe139ee5457f3769afd535c184e5.1756138033.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1756138033.git.jan.kiszka@siemens.com>
References: <cover.1756138033.git.jan.kiszka@siemens.com>
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

The API documenation of setup_mm_hdr does not mention that dptr can be
NULL, this is a local function, and no caller passes NULL. So drop the
unneeded check.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index c2bc8467b099..65c0fe1ba275 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -185,8 +185,7 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func)
 
 	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
 	var_hdr->function = func;
-	if (dptr)
-		*dptr = comm_buf;
+	*dptr = comm_buf;
 
 	return var_hdr->data;
 }
-- 
2.43.0


