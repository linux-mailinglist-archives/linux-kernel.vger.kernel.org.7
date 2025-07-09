Return-Path: <linux-kernel+bounces-723035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50022AFE205
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D39A1C25231
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F1E23B62E;
	Wed,  9 Jul 2025 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4iTUb07"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E70235BE2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048669; cv=none; b=LxmmS8xhwV/geJBLi9uhWgjT3I1H2snmit3NQEyDOLC3DySeaF868ZFejL6vbborvefH5QmPEcMxdRXWjgEdj83VAGhm0j1hLpAHjqkKLDBGTEkPr/nWiwSn0cJRtdSeA0E2g6tHUBwduufdeZj+Z/apKvQto/epUQoZXP/9SfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048669; c=relaxed/simple;
	bh=cJ3lQy2Swj3+MFWaaDWOoZLadXnitJMf7zR1KaamiyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oEfWLri4Mf/DiTZTy1LLBTkoMeBZwzLAnJD86H0/vdr7XpajRBRq2DgDjk9nVo9M6P1NPTpw5IeGvpMuhSJ3h60EEj1KXeSeZyd+wS7Oy9gSDGp9+NZ8N5nm8zSl62OcYCUIiVWaDIQu57u+uuNJzhEAM5EmSOWXWUrzZQIJ7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4iTUb07; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2215400f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048666; x=1752653466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkFTmqsf5xM0y0olaKrwlu6ac6INtEIMjHx7vjsV9mg=;
        b=u4iTUb07HGmZIpIF509dF8/DOSw0plFaMRqKIj43HPU7lA/FUcJN/0/yEa/8ctm6mu
         hpe3Tw/XVBpi3yJ7MG2AP9nJZyuWRQE1QW+iaqB4xIE2VDfDnresVLmbjYvg43rlaqZs
         eKd8XSdYLFgFQOX0GX4Ye6QXdGQzc95l4vXaLjkMnsi59xs99Kzwzxg2fUYZ9iiGQYXR
         qFNppMp7DOoe6u30R70gAvweqp/macgbv4u5Ux0T4w8+f/a9XMv6evzEB0Nwb6I219K5
         v4Q/l+w6zwPlhZ8roAIgHhGGqDJJK7yqQkyYxwG7QOyLdbJLDqVX5uFAdFLC1oK0awHI
         ZpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048666; x=1752653466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkFTmqsf5xM0y0olaKrwlu6ac6INtEIMjHx7vjsV9mg=;
        b=uDxs+sYtMXrn/2iDdTceswhLcYNtdIFfKW6RZV8bI0Upntq3emnvkSODpGrljk3czi
         GB61pfim9Ra51laP4aGmwd1Dz0jqdFMz5O4OmwLpkXlznsjEUGA+qHckpwpGcGq+6ntO
         TlKHs75DEQ+hkbO5Qm+vPH/q9g9356UPpRvwXw4G2kM5LhlewEGRFPQMW3pNxAXwU9op
         EsLGEBDW7WwfBFOlRwtWqEqQX7E0m919nc/LCw9oS1TDi14UouxesTujE6LsoYGQ9gj0
         ioUU80YXo780K9anFDvg5Oca+o3Qq1cNjzByY1gQvyyoLEreVicvfdNWCj2TV2wqceiv
         Ze8Q==
X-Gm-Message-State: AOJu0Yw4v2Zwc6x51jQ4FOTRMj8JRxepGnZFqdCSlPuoLzU4BBhR+y/P
	+kmGsd4zSgzCL/nsMc7s8gUBEEcgQaLBAWXFZRJ7bJJOz2VLl8n9iVgXzLZfrHOdcD18WMZV54K
	C9/fUI3R/CWC4u29faVZdEuPprYu+iTc6fdSDz4qT9mQyF+j9YMBorsGZhTuHqcDgsYWVHAaUou
	doXR7CcKr93g6e+cmlfOl/Jf9+zVMZXHRm/w==
X-Google-Smtp-Source: AGHT+IGOZr6el78qKmmrKFemNa0V3BiadGjv1vwBoY2O4ledQQmAr1BG3DO6rNUYHdgMOL++JpU1fyoe
X-Received: from wmbbi11.prod.google.com ([2002:a05:600c:3d8b:b0:44a:ebc5:9921])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d87:0:b0:3a5:2182:bd11
 with SMTP id ffacd0b85a97d-3b5e44ea087mr1102193f8f.20.1752048666066; Wed, 09
 Jul 2025 01:11:06 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:43 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=ardb@kernel.org;
 h=from:subject; bh=9C+aDfHhanCnCZaffi+nlLG9t5eZ2KFG7bqL9VA5WFo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPeZpM2RxT/0WvGaW+MMsZtf34N5nNMHa+2+yH/zR5F
 nVMn3upo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExE4gsjw6N3dxLsdpyesqJg
 +wsdyeolyY+aHDbd/nF5nmbgE8+cJjdGhs+MVTU3ewy6s4Xd59cvCF4pfXdh/pzQld3fIlKbVj9 6yQ8A
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-28-ardb+git@google.com>
Subject: [PATCH v4 02/24] x86/sev: Use MSR protocol for remapping SVSM calling area
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

As the preceding code comment already indicates, remapping the SVSM
calling area occurs long before the GHCB page is configured, and so
calling svsm_perform_call_protocol() is guaranteed to result in a call
to svsm_perform_msr_protocol().

So just call the latter directly. This allows most of the GHCB based API
infrastructure to be moved out of the startup code in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/boot/startup/sev-startup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 0b7e3b950183..08b8c24fb469 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -325,7 +325,9 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	call.caa = svsm_get_caa();
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
-	ret = svsm_perform_call_protocol(&call);
+	do {
+		ret = svsm_perform_msr_protocol(&call);
+	} while (ret == -EAGAIN);
 	if (ret)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


