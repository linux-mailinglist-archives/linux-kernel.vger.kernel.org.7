Return-Path: <linux-kernel+bounces-897708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE90C535EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A7351E15
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223F2350A12;
	Wed, 12 Nov 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMMomRg3"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9BC350280
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963641; cv=none; b=MODOVfULpOtPUrLKxeIMJo8ogwAK2KGKudV+bmn8xHfCSDr8sQYF9gvOOdU0GzQ0UUVMd8Br7i/rV7lvaYev7CpPL5heo+o6ITFLhBIUP93tvs9q18ydtnmoFdyis0UEnFQ4zuOgW5/HKdm/M2LixD7uPKjbOLyqqztuJdCWly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963641; c=relaxed/simple;
	bh=/JOce5MvxYjnhG+9whc6YtktzEE1MUnOCL4g++H5Qvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TP1qEXppQph59FGpEtta5WIjzt4tCFZDvS3SriHy9ZqreVWIQreU4j+3/23v9i8XekRom3gtLTFNWb/J3N8SDzAvNEUC4Edomi8q5VYg5YlZwh2kOuvfJMfINbmdyX3uN+ma5xABNSW1Yb+hqSVjbxO4kSUHHn5DnuwGFHthXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMMomRg3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-342701608e2so1266973a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762963639; x=1763568439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NeRxT3I5fTlFPGzsOfdrv5zO/0SPs+Jxk1vfyCkm7NQ=;
        b=rMMomRg3V7MAGEUJ+gtjOKRCAO/apCDGxAXR3U04svMHL3XtFAC/cv43G1kIjvfTAj
         fQj2HGJUrw5/mwJouqNy3Oqrogas7AvAOyoHbF18sjYeVy/R0vsi6CKeM7cyu1XgmG1Z
         hgsdYIyNwagmXOAd8hCI/MB8xqdFEbjSerzYq+CAvUxXkJaF6JSHVfDdrtX9YsM0bnlq
         cZxZJ1PWZsFw+QK5mpd33DC1jIJcubtWtwIfmf+pspWBXX95rFwhml5femTxjYzA/nDK
         dJb62haGSN2fWxbNxISZ//baDFMU2j9YWefAw3qlnXR1QtP3WBJ7SfgqxRz7Vy695fuw
         pvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963639; x=1763568439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NeRxT3I5fTlFPGzsOfdrv5zO/0SPs+Jxk1vfyCkm7NQ=;
        b=gJPXcTjNB9C2HC/r8hQbdDH4tTyxqH8NgXBjYNrBinXU6F7B8z+oA0A6cSssfOjWuX
         I7wUaKh2FGoVtHClEPVt6qC9QjmZShhqsM6LBqf7b9v0G+4MHGFcpDB/eqbFshwlHUWW
         gbGxvLeT34HGzhII/PLDjVUhsuda5oqqJChyoKE/eTxFjlytGF8QmYl7fJKbAjCwuh9y
         jHV07W0dee4W24ROLxCsPapjLYMYUnMRhFrQ/kKL6dJhR/4sPRat0ggr/NJ4LYvkf0wk
         WKdvfa4gzC37lGdQCiOcDPV/TJQoc4qooTLf0fFYH85R/QyF0zd2Dw47/joQh3xfueA5
         O8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJTiB73JKykJ3Z6vZeYZUmgaQjG5jbuH7zoX2A3sIw7W89K7zvYsYLCGiglTmmparH7McNbJoQVgGdRm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5Wky6LK/iqGsAy6pda5oe+5KO7qgA8rl7nxNiPfE5hgt59xX
	22SOzks3rbug/+Y/6N2WWKFG+JHFoSkFKZeI6wxn1joLNnQ4EQNMz3+6Qb1Ol8UZJee8HEAMWi2
	wRabd2Q==
X-Google-Smtp-Source: AGHT+IHW/VRW2YS3MUxdH2USXZLmkU4KxcWEaSqjoMCmQ+a2fgXYqtxaEYVcXnrl//MQDzhTVtj5DS7SUhw=
X-Received: from pjpy13.prod.google.com ([2002:a17:90a:a40d:b0:33b:51fe:1a73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f43:b0:340:dd2c:a3da
 with SMTP id 98e67ed59e1d1-343ddde89f2mr3893297a91.8.1762963639540; Wed, 12
 Nov 2025 08:07:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Nov 2025 08:07:08 -0800
In-Reply-To: <20251112160708.1343355-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112160708.1343355-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112160708.1343355-6-seanjc@google.com>
Subject: [PATCH 5/5] x86/sgx: Fix a typo in the kernel-doc comment for enum sgx_attribute
From: Sean Christopherson <seanjc@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the exact enum name when documenting "enum sgx_attribute" to fix a
warning if the file is fed into kernel-doc processing:

  WARNING: ./arch/x86/include/asm/sgx.h:139 expecting prototype for enum
           sgx_attributes. Prototype was for enum sgx_attribute instead

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/sgx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 3c90cae04e1d..04958459a7ca 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -112,7 +112,7 @@ enum sgx_miscselect {
 #define SGX_SSA_MISC_EXINFO_SIZE	16
 
 /**
- * enum sgx_attributes - the attributes field in &struct sgx_secs
+ * enum sgx_attribute - the attributes field in &struct sgx_secs
  * @SGX_ATTR_INIT:		Enclave can be entered (is initialized).
  * @SGX_ATTR_DEBUG:		Allow ENCLS(EDBGRD) and ENCLS(EDBGWR).
  * @SGX_ATTR_MODE64BIT:		Tell that this a 64-bit enclave.
-- 
2.51.2.1041.gc1ab5b90ca-goog


