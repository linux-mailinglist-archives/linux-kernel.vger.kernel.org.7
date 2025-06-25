Return-Path: <linux-kernel+bounces-703306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13F4AE8E73
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 21:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7BD1C26F14
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6762DAFBC;
	Wed, 25 Jun 2025 19:20:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6C9275B04;
	Wed, 25 Jun 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879210; cv=none; b=Vjd7MXDfi9zSiRiz9p1QJ7Omu0jZ7mRFY7Yaw8o7L1MXbHdOiIZWOxYJceWAmNMmSr9PY5yzSy6AHGbQG8oioIN4ilcKd2lT8Kh4D+6q4k+647EOqFaj7Godi18ZgkGJVVCsCCe77vl/JVCNkOMSW3oWe+/9o0I96mnkKlsK2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879210; c=relaxed/simple;
	bh=SNdgHJE/X20HFoSToPtJnMgu1jFH6EnxA9NRuQ3YCog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvD1wHLnGseIXaEVXrums+WW5B7ZMBF7oHHqq28wVEgvpiG5LbXQBpVQ6rVD89ktx/pwTyAnzhgtfGQmX2Em5tdWgw6FL9X+XcWl7R5ix9AsBQjsp4m/j3HF9usg23l6CzccBog/a/uRwI5H9Nv1hkpvY4qtkB898j84wFF5BFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 168CF106F;
	Wed, 25 Jun 2025 12:19:50 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03AFE3F58B;
	Wed, 25 Jun 2025 12:20:07 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v7 1/2] tpm_crb_ffa: Fix typos in function name
Date: Wed, 25 Jun 2025 14:19:42 -0500
Message-ID: <20250625191943.1009830-2-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625191943.1009830-1-prachotan.bathi@arm.com>
References: <20250625191943.1009830-1-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/recieve/receive in __tpm_crb_ffa_send_receive

Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 4ead61f01299..089d1e54bb46 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -178,7 +178,7 @@ int tpm_crb_ffa_init(void)
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
 
-static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
+static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 				      unsigned long a0,
 				      unsigned long a1,
 				      unsigned long a2)
@@ -251,7 +251,7 @@ int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)
 
 	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
 
-	rc = __tpm_crb_ffa_send_recieve(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
+	rc = __tpm_crb_ffa_send_receive(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
 	if (!rc) {
 		if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
 			*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data2.data[1]);
@@ -289,7 +289,7 @@ int tpm_crb_ffa_start(int request_type, int locality)
 
 	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
 
-	return __tpm_crb_ffa_send_recieve(CRB_FFA_START, request_type, locality, 0x00);
+	return __tpm_crb_ffa_send_receive(CRB_FFA_START, request_type, locality, 0x00);
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_start);
 
-- 
2.43.0


