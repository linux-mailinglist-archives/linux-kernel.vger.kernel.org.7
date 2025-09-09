Return-Path: <linux-kernel+bounces-807793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847B3B4A93E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317F8178698
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A91314B8E;
	Tue,  9 Sep 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djM9+JjF"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A5314B89
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412054; cv=none; b=Nz5TZQLTC9gsSdcT6X7RyZfOfA1MpGwRO0jg7gn7/b0Kq1ucHOuSlWD8XiQe9F2tegy6X/stL0jq3mpkO0atToLQHQiSGWWuqQXF/M8VR2syytRcUwWuCDoOcOaYVhfWzLUBwJBlFf5qeghwhDWDj3rcocm6FbZAmqOSQzw92k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412054; c=relaxed/simple;
	bh=Slu5P8r0LHK6Jp3prV/7F1/5MptqhIDFYEYC+2CfMUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QluN3iR41fqnxS5LTfEzmlElq9bGT+Z25cT2nWr21LuFmfwW1E+3PlqjkZds8WtClKLtwU6QkNydpGdGSTrGCt6cF3i7bmLC0A7sWTqxBX8unkWPrzt8iM8XhNwHQe955uu/U7NTq32T2x6jOq+NgcaAjyfsRNJSQDUPZYriu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djM9+JjF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so48157365e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412050; x=1758016850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vWjL6fWQ6ts2PbHk6RH5bPsx2j9pJX+mY/or7KNz6F4=;
        b=djM9+JjF/nbO8J4g688q6HDExvPL2c5Ko9yFHMJLMfQ0XZxcjs2IWUhLSZkyJEBVv4
         nhuF8RxCBUE/wNLUDeF0aA/tW+gIFd/H6Ssc42+2TnF6ZqBhDHFNWozaa6a2vbEU5b4I
         MG2N73q3Pv+lFFNKNJcCXyPCsyXn+8OINadm2j0UMRr3dkNW7YNd2ueL/sifFhFtn2Ef
         FMf96MR8MFnbzyDYv/H+UpfkbFbuFeaAL5cG/LWCE7hFItII135a4UX0kuIxmkKE6Rw8
         EwwvRo5g4rG+4sqe6pV2ELHJuoQopGVXo6kx7lua9G+U/efUIxhO8IC/09TgrEFd//ev
         aUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412050; x=1758016850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWjL6fWQ6ts2PbHk6RH5bPsx2j9pJX+mY/or7KNz6F4=;
        b=Hj3SbIkbXXnD4zgZdzYOCTV+mjyscLIxcazbmI9dvpGrSWF7yCtNOWY/n4hFz5Ll1U
         k7XIYr4Ol7/Rk2+eiSk4AK9O6RgPaGWgDpHkwMIMpB4gjAXESOBwybs3TaT8vvrAA4ix
         gIatCp40X4kytS2fjAoZhTnclpQO1WgfyBGbzOeZS/5Zhy5Xs/NG9FJK+2anA8gT3uij
         akNrFxv0+Fx/iXdKPxQ9lxyvY55n/6MOPKMqketaTrcLwvBE+06PnC41KVGomqdAJcJl
         CeDeFOn5iUrqHHiCX8bZPNvoclUrzcluFWXTOMwNwaxSplN7LF74pbfUiflqf1XDeQoz
         NYxg==
X-Forwarded-Encrypted: i=1; AJvYcCXxDGBNKSrpK7OiwamCUp46ovK6dicOc1/w+xar5w941sp5ahOss53GHJNzHowHrdTPfOqqKCcTM3AmoBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nSJKYOKIQ/PhlmJ0fHabHHL9XSBksx587HmXaQAWL+ad+lp4
	LQEOnTmA0/IAwzDEu5UfVbreqHjcj3nxhDjal70Rcu1S1KAtprnClYfQ
X-Gm-Gg: ASbGnct6gwXSfketv0gdAnp4tx+cgnMVnoy4S3vRMDt1RHwAbeF+gzLunSmoF7LKnWt
	48yg+B5ULN9uDlURqfObA569qt3WbqRwhOMqHBCGpvOV3+EcTr4QG/4ZXb3NtS2Z5m8Z8wglaGM
	1TosHvTcIV5LllEBvE4U0RBHPRvlyIJRQaHsHT9JTSN5ZzTKS9Of7ifuafNnN197t2rlEjbBxyW
	vnwtTAn075H9uPtWfHp+ulQDr24TqAyeeI/VGeBos48j7YzYu9mAFoFFCy3ljixT4MsZ4yCvpxq
	3NxKHkVA8wgonxY/8HLrk4fRjEkPNgL3/CGdILnLHbyV6ir4dGpuWyqk4Nvcpdla9WUGSOWs0/J
	VlSdFLy5bpk/nj/deH6kD8Wf28qf7WIy1qw==
X-Google-Smtp-Source: AGHT+IH5MStqYR3WqijkASLiXsN2hWC7VOPdq/6i6k0WD9JEvGDTxARnSTnfaeHkOwpDxds2O+9mUQ==
X-Received: by 2002:a05:600c:46cf:b0:45b:67e9:121e with SMTP id 5b1f17b1804b1-45de2b4e677mr71029565e9.14.1757412049872;
        Tue, 09 Sep 2025 03:00:49 -0700 (PDT)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df3353ae6sm3641375e9.0.2025.09.09.03.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:00:49 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip] x86/asm: Use UD2 mnemonic in <asm/bug.h>
Date: Tue,  9 Sep 2025 12:00:21 +0200
Message-ID: <20250909100038.1709394-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current minimum required version of binutils is 2.30, which
supports UD2 instruction mnemonic.

Replace the byte-wise specification of UD2 with this proper
mnemonic.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index e427a3f7b751..de6015765015 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -9,7 +9,7 @@
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
  */
-#define ASM_UD2		".byte 0x0f, 0x0b"
+#define ASM_UD2		"ud2"
 #define INSN_UD2	0x0b0f
 #define LEN_UD2		2
 
-- 
2.51.0


