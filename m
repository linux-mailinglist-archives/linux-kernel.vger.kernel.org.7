Return-Path: <linux-kernel+bounces-865826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB65BFE1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3091A0762E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D292F83D8;
	Wed, 22 Oct 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="k7nkjBZA"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC12F83B2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163521; cv=none; b=W4I8lYg0OxGXRfdWnBErQidjDVk4ZwfOIDYeghXfw4SUSuWuAnPgFaGyqeO2Bwb4T3bKYVkM9CkeOY58+o0F67q8AW7bUXkyicfVODEKckv8gbTSTk5+L4g6MZuiEco2WeTkU5WCzBppayJTq4xyE67h28OXz7LHFi8KZLe5+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163521; c=relaxed/simple;
	bh=PSyVSRB2x6ErYNgBfJFIcrLHw6UCPModtk8hhtXerug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfjRUM0quN4oyPA+afPcsZWLQizEuXsp0IVfxkj1lYZgSMUfsdHW9wDwQoxmw/7aYKnbPLLRLb7CHn9ykTWs6sIFGijhKt8nWaAv76x36YAKYYmRbrRDkVShAIXGbiFxNLYgwZIkkej2OjwCVfPYcLzAW27VWF0DpRruMK9SuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=k7nkjBZA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290ac2ef203so73079325ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761163518; x=1761768318; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vcW5U2Ynn5RMyf7nGtwVHx396ZiSNwgzVMcY5SNt08E=;
        b=k7nkjBZAa3cT0ZJy7W6PNhM93symXskdGmCshbr09K9ZtOJvM3gqPiK6V4NhCjowhg
         1clEfO7eNUxA+9AyZWwuCpqanUhivapkU8i16zsm0uA5MB98cxCv/k222Kmim/4secbv
         uIPV34VZdxtdBfGpKVoe/SC/65nWtLSNsTBD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163518; x=1761768318;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcW5U2Ynn5RMyf7nGtwVHx396ZiSNwgzVMcY5SNt08E=;
        b=ssAMuDHOX3kN6ZK7OWgvApaHsph8a+e8MoYCyJ0eJJy5iNOrmJ608jjZFCzctkNyVp
         igwe9WrZQnZQizT+TS69F0leIs/A4Qou88fN4hoEMvfZQYUafuZ0KVCUPQnhh2SI3hNy
         9WCePXgEGHQkjVBsPXygpFnWFtm/P67nJr2TQKe6H8Aq+ZGAuTmd+lbtpO1DGd7b3tWm
         d0YPb0ctx35sOCx38E7W7MnIpYXdodDp+s0eMIZNJyC7VEfh7EdRpvUE0W0t+wJjMVJx
         zL3Uvlx1AXp/yXbFVfzg7yLKzqHORR0Ialu7FiNNj9ldZF5xuyo4Clq7A+/LXkTlQAM6
         IdHA==
X-Gm-Message-State: AOJu0YxrkBjuPs6wlk96kMIeYSKnOVD2Czl0GXKJvEuxvm3mdIUXQyjg
	KJ8t7VJCBJH2dw6guXwEs8DRIxupNWLBIlJ9JptvhO8j6ZtRor7MWaccWQV1fyRasZ/k8qVv6QC
	5keyM1Zb+pRPOv4KuYXyHQqdBJVwTw3nOeBOfYZKPwEDTSAWlDjhewo8GHnmTQK4rzcbvw84OTR
	U=
X-Gm-Gg: ASbGncsFR4rdN3DIltDPE66SL7Z4seI/WUGQTzo72WWOFw+NjuftWDRESSoeSAdNCpT
	0umtMkofobDIz2jesU1vjm03HiPM4X4axk8VNhzzlnxM6kVgGt5X1ZyFKKVdzwXmphmj+QZAgTt
	Yw5DQgBxkcx4GhQVaUi8aCsXOsmu/w+2vof7kgmijQ44+IuxLvPeQN6wQuiiePtSfImQf/heg/z
	VZlC6JWPPCdgJIoepswvL3pc7dvRn7AEsOj9lUedr9Hid1mLoQSSw5l+1CVjXC4tndtrqvFwAyi
	SGHET7ij9uutipW7p5kHooHX40eOMEVP2tw+Sc6tZiY/sqqbPtMLim4RUdz1OqmVtn+KpHtOKFI
	LB5pFJadSPVlvC6KJ1lFJMdCu7L8LVcFBZyVmd0AeJFcKhhFSAcTa8Q5pTFcFRwBCb/ETG+ZuhW
	w2HmV59EstknV3CfvdfebQNXEa6AemZeuWk142LO0qjqtdQ4HX9EaQ41ZFhTB3POe2tEEbwM3Sh
	zw=
X-Google-Smtp-Source: AGHT+IGQqqLJJ9O5MXDYzSGaT6nYHfwAFG4Mqb6FPE4J7rs3hyNEyhaso+ek1KvkCw8Kj8ag2huKug==
X-Received: by 2002:a17:902:e743:b0:290:ad79:c613 with SMTP id d9443c01a7336-290cb27c76cmr267008565ad.47.1761163517651;
        Wed, 22 Oct 2025 13:05:17 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:818d:712:fe94:5de7:1d8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd8dfasm146371535ad.43.2025.10.22.13.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:05:16 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: peng.fan@nxp.com,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] =?UTF-8?q?[PATCH]=20doc:=20fix=20typo=20"mannual"=20?= =?UTF-8?q?=E2=86=92"manual"imx95.rst?=
Date: Thu, 23 Oct 2025 01:35:08 +0530
Message-ID: <20251022200508.72941-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022194527.71189-1-biancaa2210329@ssn.edu.in>
References: <20251022194527.71189-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"

Spelling fix in the document from mannual to manual in 2 places.
Fixes a spelling typo "mannual" to "manual" in two places
in drivers/firmware/arm_scmi/vendors/imx/imx95.rst.

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
index 741f4eace350..933c21512411 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
@@ -400,7 +400,7 @@ POR, WDOG, JTAG and etc.
 |                     |Bits[22:8] Error ID(Agent ID of the system).            |
 |                     |Bit[7:0] Reason(WDOG, POR, FCCU and etc):               |
 |                     |See the SRESR register description in the System        |
-|                     |Reset Controller (SRC) section in SoC reference mannual |
+|                     |Reset Controller (SRC) section in SoC reference manual |
 |                     |One reason maps to BIT(reason) in SRESR                 |
 +---------------------+--------------------------------------------------------+
 |uint32 shutdownflags |Shutdown reason flags. This parameter has the format:   |
@@ -419,7 +419,7 @@ POR, WDOG, JTAG and etc.
 |                     |Bits[22:8] Error ID(Agent ID of the System).            |
 |                     |Bit[7:0] Reason                                         |
 |                     |See the SRESR register description in the System        |
-|                     |Reset Controller (SRC) section in SoC reference mannual |
+|                     |Reset Controller (SRC) section in SoC reference manual |
 |                     |One reason maps to BIT(reason) in SRESR                 |
 +---------------------+--------------------------------------------------------+
 |uint32 extinfo[3]    |Array of extended info words(e.g. fault pc)             |
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

