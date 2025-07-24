Return-Path: <linux-kernel+bounces-745090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D84DB114BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139DD7B9199
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBF52472B5;
	Thu, 24 Jul 2025 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FnNunbi6"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02873247296
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400243; cv=none; b=hjXX9xSj3z3yhylTATDcVmCWdlr6zF4dhS/GwE4o4y00lwr7nDiYyN47aZG85vlFsAsaL7mXsg8jkgrhsUU3ECQjaiBxXPkSeHLboH3fyF/Kv5pqnkBFim97n+rflpvmkjGVdpRXutVIezqzIaBya9xxAxn1dCDvH0WbR7422ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400243; c=relaxed/simple;
	bh=NgW9QCO8Pafn6dRlZF7K76jleyDt5hjCF27uUi1KY9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZRQoC+adTboSMbHVqd6cgaRpX/YemU/IN7Z+XLadOvvJCH/1d2iYfEE+oTagxBrCMp9DNmCWt+aYnXxxI73KiNUfPVDfBse1QZsM8wkzTnJQqR3ZNop0Pv7RSZS6QraTGPTfi/7XJEN4A2mDRMGqfv84ZkFr+XM8AvE4ne8vuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FnNunbi6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234c5b57557so13632885ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753400241; x=1754005041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yl+fpaUgVvAgmSBmN0Uf0wW/gDpMMKoNCvx2z4Q9Om8=;
        b=FnNunbi61GteEJNcipCLaMfLAkbylfTu4Mwmu2m6HOIMmNv6/qvM28KqM2gPF5GW3u
         vQ5wPCT9o+ayYHg/OU1JrE3PfgpA4wz/hXi7Rla77zQdTZxcTN/0ga0xPWzT2jC1S/oR
         Z6iXv3dsPeFXOYqeQeafSeUaAuivNFYve09+oLWem4wcVDNzrNOXFgRIiwNmOMFBXhXX
         Gle2JynBBETtnP/ybieu2Uzej579EVBTr5mryBiMznWEmK7dxoSBN1TDdXIyfnTwb6G9
         q05BA3eXjC2v0k7bMlaO/BtG57zSKXS6AwoCDLTrDu/ADL38Xn/PuzX0m9KVsGYpn+yj
         0F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753400241; x=1754005041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl+fpaUgVvAgmSBmN0Uf0wW/gDpMMKoNCvx2z4Q9Om8=;
        b=RTOQQPNFiC004j4Lg3rX1BNcmUmUmtIwwcScBsDUqreflKtKr9HZU6nUyHKNPOTFtR
         MwMMrZHuOnOa7qrIFj2iycN5ARn5Hjo3vn2UtYfnZhKPwCFY7xNNjPNU4TVQqvoxw8wU
         BKN7Bv0E3pWGahO8sJYAgcWp+2rwnQcBtxbabYKWu43a/nEv1QrJa58dlX0tK/oqHYlI
         iMaM+hkwUKPl8htHN5qtNbI1/qo2wOOtyqcXsU9bfLCu7zsGRHVrKoFzbZroXdrznix0
         FEQFCjLLIzMzZG3zA7BcFluWKDrCUYHk/CZeuOULCy2YDSTbNwGg/hEFtZe+km1iHqw1
         wOEw==
X-Forwarded-Encrypted: i=1; AJvYcCXXM4gDJnOz/ukrUK57xZinAxtixrW5uZC8isOKnHvF0Q0nm6HcQ2KCF4eEr5e2P2zFGKL+4BjhxrB1aSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMeLUh7Yg5A1tp/KC8vqugNzt0wijLyzar69jGmEgTKca8qtw
	ZtIeEBvxWnld0q/2sTHRWD6rtv+UwCfGrLT+hIzBoAq6EnHwtV1DxMPA1lEobuSM0tg=
X-Gm-Gg: ASbGncv6lOFHLc6FXvNZ06FyvkTVgxFLODzEZQXb1996EiF4zu/6W1aXsaOqUIAiTmr
	opMMn8ujmjMMn7DXBMrZC5prsxk56CS1slvTDdRCVbrwpf0xeRZp3BAFzNtN71miseMSkFT8bC2
	O4ODj5pXdSmMWugolcQsAUgUM+Ix1SucbW5pd6slLbTrPECltQ+7Od57ZLaJxen3nNrvrnVoCoJ
	OlUy/g2Lh68Kj8peSwYaCUvq2rkvMFboZPpQEKaaw+Vmw3vzM0WefhrrKQFdWg8mFupCtTEHK1r
	zpxcgcmTBUvM6PCxXRpjg2fHxPCTBih9qiXDp7gEQkphoNpRv8TQOe9NlJ0032vXefMlBQmymWr
	xJsP++s/RGnhcNycWW1c4itIhN+Q+PhkH
X-Google-Smtp-Source: AGHT+IEFvddaBDkybC2q7ob0zwYNRuGaOi2n4X57ciJYKI00Yd6EYfDqXnoJ8jUoGCKUz8NAesStww==
X-Received: by 2002:a17:902:fc48:b0:23f:8df8:e7b1 with SMTP id d9443c01a7336-23f9820d012mr133037965ad.32.1753400241217;
        Thu, 24 Jul 2025 16:37:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc706sm23598685ad.106.2025.07.24.16.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:37:20 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Jul 2025 16:37:00 -0700
Subject: [PATCH 07/11] scs: place init shadow stack in .shadowstack section
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-riscv_kcfi-v1-7-04b8fa44c98c@rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
In-Reply-To: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>, 
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com, 
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com, 
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com, 
 heinrich.schuchardt@canonical.com, andrew@sifive.com, ved@rivosinc.com, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

If compiled scs and arch kernel shadow stack support, place shadow stack in
`.shadowstack` section.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/init_task.h |  5 +++++
 init/init_task.c          | 12 ++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index bccb3f1f6262..a2569cc5a7ff 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -40,4 +40,9 @@ extern struct cred init_cred;
 /* Attach to the thread_info data structure for proper alignment */
 #define __init_thread_info __section(".data..init_thread_info")
 
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+/* init shadow stack page */
+#define __init_shadow_stack __section(".shadowstack..init")
+#endif
+
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..e21af9db5c09 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -54,10 +54,18 @@ static struct sighand_struct init_sighand = {
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
-unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)] = {
+unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+	/* shadow stack must go in special section */
+	__init_shadow_stack = {
+	[0] = SCS_END_MAGIC
+};
+#else
+	= {
 	[(SCS_SIZE / sizeof(long)) - 1] = SCS_END_MAGIC
 };
-#endif
+#endif /* CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK */
+#endif /* CONFIG_SHADOW_CALL_STACK */
 
 /*
  * Set up the first task table, touch at your own risk!. Base=0,

-- 
2.43.0


