Return-Path: <linux-kernel+bounces-644789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC9AB448A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B1D86109C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD370297A59;
	Mon, 12 May 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vysdTSxg"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CA12989B8
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077102; cv=none; b=tj+4ejyTEl+hZj90HxXGV7v0/QhgLpg2IVAXy5PR602XmrEIFm+2i94X5RQUEXmpQS/qwYA9/QIonGu5jLwq9iKoZ6HrzZDSYkSYaaejIVrrHXQ96DpOJFH86zU7CGhBPAajl0B2yWwzg8AP4mg+B6Odpbn/Cnz8lXyGwrFXJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077102; c=relaxed/simple;
	bh=IViD4YYHBXDwo5g9TTRUGnmwmbfGnTDlYSGdvojExjo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lwdrz7defbBkYvYH0cr/jP+X941lwii4BF2n9Rq7YZ7b8lnEBe2+GlCS7dnFe/dHEVIzMEYs84ElKsP/RzvHeBv2VHp3mrVTQ8HtZEKMI8KIkCO1N9nR+aPmbtl5RPybEBqF/JkUv9pvviUnMPamoUVo0O8jwVyK+n4oZxLhgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vysdTSxg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so33687685e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077099; x=1747681899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtH8lgB/xLdugV2I/4aL/pTw0ePxg4uZHnaRHJhekpA=;
        b=vysdTSxgq925HuW4y1I+vFp5ClrUO0aiw3e0BxnesV5POb/MPwhzKwxjuH4zHiyQGw
         53NrSfOaTVliKsjL68z0Qm41lVDFoY6scFWvaBkaxjmZnmi4CewfIAtn4M4xZYv5CCCB
         DaR6SdgQfwAMUzohMRRJpsx9c508W/72jzwN0+tJxgD5WI4JUu1eXvc1npJLqiYnuVNf
         S+RL5wYGo43m/vw/2SfuAtzzMLntYrmCRwhWgMqBeefSqKfTgbZnIdsAxda7WsQKeNOc
         xYNEq15+OkESZUP9pBqeB8CgBvhRWFYEzRyKsFPHYYkejuYPbFjsNykuGNu2BUicT1O2
         uVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077099; x=1747681899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtH8lgB/xLdugV2I/4aL/pTw0ePxg4uZHnaRHJhekpA=;
        b=SCCKJZKrFUx6826j4DuNEgOfL5i2KsIELX4eJ4ykmUtmyVutZ3G6PXQp7VEDpvCpLE
         DJwm5BgsaCx6SAiiPJl6ZCM/mTi/2uJztBuP4fhd1NiGI46GEFwuAUJgcUm1/nzk3TkA
         k0BcJiQPnv79pweaMENYTlTgQCMlH+WgqLNI42CQyf3uLqrv4Rg3HytzweOStCcP79YC
         moG/F2+r5mYGCR2zaCcBWDmx4IFx5eq/4zIWV9gL45cdHcfXnMtZGKRKcHnZHYHjuDMS
         JxVfxX0K+OP1jX839XCQ0+c4HMfOS9bMcnSvwqXRxt+Lh2BoHj2DXSMc6bsTVI4Jg329
         LAyg==
X-Gm-Message-State: AOJu0YzzwnZiJhq8eSAH+Zy/ydSDG6XmPKtvl9tFwHS/VrnvFxKoAMmy
	v320fWCwdYxXCOkIo0Pr7C5P+WW4MKADzZq3+WKmih6On4UwbeHGcLxSbSi9oGg3MZ21Yc+cnz6
	P+7IUd7G0f9Dk3A0AaUU/5ce7XQdiBHVFOdPHLL0KhWGWezg3gJuijJOHrYuaJiS2YTLaCGwaZx
	rWJRqiR4g/j/VdjneHOu9B4GEpS7ilEQ==
X-Google-Smtp-Source: AGHT+IEgrDQQqKcWDwlMTlU1f6Qdn6QqOQozwGRLNFc69IqJnl2DD/+q9cSOAKZT5gYzuW1GjaLqr9OG
X-Received: from wmbfm20.prod.google.com ([2002:a05:600c:c14:b0:43d:8f:dd29])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3587:b0:441:d437:e3b8
 with SMTP id 5b1f17b1804b1-442d6dd21a5mr106536425e9.23.1747077098869; Mon, 12
 May 2025 12:11:38 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:38 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2349; i=ardb@kernel.org;
 h=from:subject; bh=Gf5X2ytHxR1g5slHaQh9jtJb2moZ8ZWVoSoEdAWq+8g=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3eor11e7C/0z9mus1TzVx/Howsapu/VCpaY0tB2QY
 S+4ZM/eUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyTpiRYc8yU+3ZqROeTj76
 PcvavW694L2X7y+wX5N8OlUvNkXh1TeG/wW3D02ZNLPkmvntX7HsmnL+L85w3/751SMjOF89x0F 6NRMA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-26-ardb+git@google.com>
Subject: [RFT PATCH v3 03/21] x86/sev: Use MSR protocol only for early SVSM
 PVALIDATE call
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The early page state change API performs an SVSM call to PVALIDATE each
page when running under a SVSM, and this involves either a GHCB page
based call or a call based on the MSR protocol.

The GHCB page based variant involves VA to PA translation of the GHCB
address, and this is best avoided in the startup code, where virtual
addresses are ambiguous (1:1 or kernel virtual).

As this is the last remaining occurrence of svsm_perform_call_protocol()
in the startup code, switch to the MSR protocol exclusively in this
particular case, so that the GHCB based plumbing can be moved out of the
startup code entirely in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c     | 20 --------------------
 arch/x86/boot/startup/sev-shared.c |  4 +++-
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 612b443296d3..bc4ec45d9935 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -50,31 +50,11 @@ u64 svsm_get_caa_pa(void)
 	return boot_svsm_caa_pa;
 }
 
-int svsm_perform_call_protocol(struct svsm_call *call);
-
 u8 snp_vmpl;
 
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
 
-int svsm_perform_call_protocol(struct svsm_call *call)
-{
-	struct ghcb *ghcb;
-	int ret;
-
-	if (boot_ghcb)
-		ghcb = boot_ghcb;
-	else
-		ghcb = NULL;
-
-	do {
-		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
-	} while (ret == -EAGAIN);
-
-	return ret;
-}
-
 static bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 408e064a80d9..297d2abe8e3d 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -755,7 +755,9 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
 	call.rcx = pc_pa;
 
-	ret = svsm_perform_call_protocol(&call);
+	do {
+		ret = svsm_perform_msr_protocol(&call);
+	} while (ret == -EAGAIN);
 	if (ret)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
 
-- 
2.49.0.1045.g170613ef41-goog


