Return-Path: <linux-kernel+bounces-848425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99945BCDBB5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA5A44FCBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF192F83A5;
	Fri, 10 Oct 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i238JxE0"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C72F7ABF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109048; cv=none; b=VoYI4yvD5QvTHhGAy2cw4+jOsXh4H4fuioMGEBwiIiWugEJ6IDY+e3xJtx0wZkKoSGgSklT4W0VugmlxCKsBty7Qp0b+6xSaNVMIiNKtWdPZ8zWPLolytLstyId4Yx/ot1QHXSz3LCN2D/7XK+djPL2LNrrshmisraMTiJr8SrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109048; c=relaxed/simple;
	bh=naMfi+DCUrLEAKdq8akwEZ8Y6eX9PrncV5/IdYv3n84=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nGzSW3pXJs47B1xeiTDgSOCx/ReR4igf4ywQIlTmQEQ9BWl2o6tZgVqyJHIMlX3WVMBoOixjU2r9iBfNwr1hEr0anzZlQqPV915W1UEW7g86rfBJlfN8KSRqh3Na+WsieoghfB+Fo+FVRMTUDzsHQ7vb0bqhUNBIb/EeOa+Epbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i238JxE0; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b479e43ad46so193474966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760109045; x=1760713845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MOAwPRSEawDJ1S+X4m+HOnHsSLvZ82/T0h647JsLUHI=;
        b=i238JxE0yxFQ6My9KPlTYjH+f5tVv64aAWMRDWhEporryT4Lnu7/vqHcFyGGhBgIoZ
         3QTBarzy2kjtHiSiU6CPJGObwRpzU9v3+tqU3VtUnKms/lrIq4zX/AhqGPGAtaDIcfMw
         pvbXTV/YlHRLJ6hzD0YL89OS6oeHE6t5aYcMOzbG+xzoMrLTuLdfS6bqaLwYzAjGbGix
         p6cAsAH8N9wzHkh0zORFkqHOpPK9/rR+q1kVi4ROncF8T5s5iZki1XI+zhVfU8b8Bvh2
         q9L1zTtdgbPDM7fgcd7PS2JMuY34FW/qitmLc9E8AGPOq/L1HAEgCaHlB2GMvosVF5dQ
         y/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760109045; x=1760713845;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOAwPRSEawDJ1S+X4m+HOnHsSLvZ82/T0h647JsLUHI=;
        b=Qc+tRSNPgB/wZr/8EgUcSnGL0g+y/ivR8uEje8PCoVuBHRDBz1851sZ6zHsglnrpeK
         iQpGdICXTSymYrfbD0En+vijgDjtkL9kN42QHPFaqSBrEeKR1CFrOR7Wfw7/Vg1Lx6d1
         +6m8ecNpvOu2B9t3tByW+PhqPFxKgQXRXn0dqTz+KDTdxeA2RRa48EaV7yBzcj8fjHzn
         RXvmjirwIXwQ/i5UR55ofsddykp4Mkf8d6mHuWeAY/LU4BdeLONszb73BSGXLKKtOfia
         O7ah5PcTPIGPoiE6p8PPToq+z2MpAhr5MDN3Zg/aANeYU/mAc5nCh2+FKAfjZmBp6D65
         2kDQ==
X-Gm-Message-State: AOJu0Yz9wokA/Q+k7C4YO0uDni63in6nJZWtG8GCVR8IGEPl5t1oCYCO
	b62c8tqpWwLgZDwuVuZBZxt39SpFK4PibhlxaPdRqthGfk+mXzTivwzKj1xWVTt8Ov1uogkcRJi
	aVlHlyMQcbCq6nmbmRaw6d4fItVeNPGkpzauRXAZlRC0pvt5WTj+t5LgYa7yhU0P4pHVxR4YQI4
	FONvCPSl3FP1kyZQocX+N5Oj6q9Q41TOOcGA==
X-Google-Smtp-Source: AGHT+IHpnh6cmcRRp+8a5cLUUgQJ0NT/mcbWn4R3ACls1xC7MrHHkxCfzorgDAgi3x1TFE5hxDz/Ui5T
X-Received: from ejcog12.prod.google.com ([2002:a17:907:1dcc:b0:b46:f3a3:87b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:72d3:b0:b42:9840:eac1
 with SMTP id a640c23a62f3a-b50ac7e7a29mr1252593366b.49.1760109045043; Fri, 10
 Oct 2025 08:10:45 -0700 (PDT)
Date: Fri, 10 Oct 2025 17:10:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=ardb@kernel.org;
 h=from:subject; bh=MqsnsZWUOO/FcMcgwxYiMhe0d3JpPSmiuXSegtGTnGg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeOl4rvLS1qlpslZWM8s/DRt3lzbMmZzgUz5VxnP3HOvH
 8949X9jRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhI0y5Ghu1fvxXMnHyVI/yY
 rWt9HWO4zL8/4nr8and/Ovi25pz/zMjIMDH3RfYJG98g1Z3Jzo9//FZ5kv0xS3HL1X/FZd0bTq2 /wgAA
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010151036.42241-2-ardb+git@google.com>
Subject: [PATCH] x86/sev: Remove bogus virtual address check
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The AES-GCM crypto library operates strictly on virtual addresses, and
never performs any H/W offload, and so calling virt_addr_valid() is not
needed.

Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/coco/sev/core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 9ae3b11754e6..c4e2de3687a9 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2249,15 +2249,6 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 	u64 seqno;
 	int rc;
 
-	/*
-	 * enc_payload() calls aesgcm_encrypt(), which can potentially offload to HW.
-	 * The offload's DMA SG list of data to encrypt has to be in linear mapping.
-	 */
-	if (!virt_addr_valid(req->req_buf) || !virt_addr_valid(req->resp_buf)) {
-		pr_warn("AES-GSM buffers must be in linear mapping");
-		return -EINVAL;
-	}
-
 	guard(mutex)(&snp_cmd_mutex);
 
 	/* Check if the VMPCK is not empty */
-- 
2.51.0.740.g6adb054d12-goog


