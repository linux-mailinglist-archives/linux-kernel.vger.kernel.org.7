Return-Path: <linux-kernel+bounces-835104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64878BA6447
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39731896926
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245F023ABA9;
	Sat, 27 Sep 2025 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP0Zgchg"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C2F625
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759012661; cv=none; b=DYj3Z10vXcmogSNpUk+g16Fnw0BThT0cWGeN+5dqCWvm/KCQ0dniZtBImCyNlSZ0+sTkMmxVxY/Ibxfi+H90DFrnNTAE7DuWnaypQeDVaHcy59/B4EyT2d9NksGOVRomIgHQtwmQx2+zEV8Ek4sj6iZFCJ+hGe02/VjX/j2iT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759012661; c=relaxed/simple;
	bh=R2v/+FoOwqHPp2S8imQWQlIn0KKSYOghLUbOSslKKEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ba5rpPOyF4i/pwepafpH9xKjddIABOQ6zuklGbPcGVC9ud/38DKWnLQDd0ZXT8ry0mtdpEsSIGsvDmwJJTwFvTCx2qIs9eu0r7DZhCzqqPhDMGhDLPd/JCkFjyiZYu1ztRgpCAbRbr4nsFB0ctyId4RdfGNacRT/hCeIAIEz6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP0Zgchg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2680cf68265so29134195ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759012659; x=1759617459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/IwJl41u52gjsjjudStf08gHRJcooAMQzyTl4+cFwc=;
        b=DP0ZgchgNoHFBghiXVWsT64UfiCYIMaIIsr6xGx6TD6VpaUmcpwbTyF3zPb8hezoDv
         bDBHO4Iek1Omhj5nzwflJMV/ITSs7XxRBCtvmNPBIKAb2/C4k+z2tF+Pnm8dFGwCqxDA
         s/g9dPJ9CRC67lZsDFVGmKQqvK11TYfEzzf3FeZeRc1ApnHQfvVN3jIeW4v8j4r3rxbJ
         fDhcoSq4YR1PgrgfrmC+ONIeF3RQKabbzAjos/Q00w7GOEnnXMkMCjEf5lLQWOdy3jsx
         TGZYokYJKhQaFH9lkLqi7R+QbATQQDY4xutKAxwY7M4gWptRcyFi3aXgZt3WmLyO+pUN
         2A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759012659; x=1759617459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/IwJl41u52gjsjjudStf08gHRJcooAMQzyTl4+cFwc=;
        b=HlZJifEWfew9DuDedmTi4EN3LErMawQD5PWa3rd1Ff8i2q9YFn0y50HVtt3N8fQjG0
         Ik2bRPeiY7fHZgCu2hd9TJcl4enZ/BlwlwReJxb2qVKMwLEdAEutN50CYSNBkiR70Alf
         bT8kyP0FoFe1DxyaNY/zx85eD8sH6FUl0vGLdklP0olcmj14A5R5NA7NtNE3gyoen27P
         qOrpgA6B0ZQXDUOLF5NOXpNRo6JoxDeM2WrqBQd2VQrrJHLlUMCh3+Izzo1BBee7fPhU
         B75YQI4bd8ahuQct1AfjeBmOnZ+2dYPzkovTb/joO2Vzp2+2L5iRpsENazGfbVDPxJ8D
         R/HA==
X-Gm-Message-State: AOJu0YzRF8sDtF60mkK0H1ieqZ0Ti5UTBZJadFNvKuEMMkYHrdk4B+Ln
	WRUKL4m7AQTeRLO/20PflmU8ko86eEbutVPdGOkc8O1xoAopziUUtvXd
X-Gm-Gg: ASbGnctMmshHp/HSAzZ1WtBE2qSu3HMDKAHEKklmPvoI/cNIU7rfzMW0AsBbxZ1vKdz
	uGv80qbxGHIyzUH+aO+J8qRSeBh8wE36kRXPoWewxCbXs26Bjupq7dCNdikweGYWXbVDZAvtVmY
	ej1ZQAkKNMe8I/4klwX1B4kZB5IAUKU6+84Dftu8hIY26pTTpOuOFfLsZkg5cU/0+O1Ot3xF2nZ
	BXHFXed6Os/mIsz8Jwyhb4JIKLVfrcx3vnpOp0wF/dj6cfz4t9uJg/pinHwDVkMSlTPw7jCd+FD
	P36VlyhmbLkUt0f2cjLC1m+wU/b5KFo+lKZRG+sgatZyJ4oT20VJp3k3i7hSpPxv45t5XiNqFEp
	sEf3sZM3ghpBVNH4bwBQKaof2irRS3+KcPw==
X-Google-Smtp-Source: AGHT+IHZiUPtqjc7991+5JMiVcTq82jza4Ltd8wEmHiytqpLwPjCF7V2St/ICxq0ESLb0LvZhbQtkw==
X-Received: by 2002:a17:903:228b:b0:267:a942:788c with SMTP id d9443c01a7336-27ed4c4c7f2mr127172905ad.1.1759012659320;
        Sat, 27 Sep 2025 15:37:39 -0700 (PDT)
Received: from fedora ([2401:4900:91d6:58c3:f7e:1ce5:40f8:7201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ae5313sm89687845ad.149.2025.09.27.15.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 15:37:39 -0700 (PDT)
From: neqbal <nooraineqbal@gmail.com>
To: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com,
	neqbal <nooraineqbal@gmail.com>
Subject: [PATCH] x86/mm: Fix off-by-one error in set_memory
Date: Sun, 28 Sep 2025 04:06:52 +0530
Message-ID: <20250927223652.17018-1-nooraineqbal@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct end page calculation by subtracting 1 to prevent
out-of-bounds access.

Reported-by: syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com
Signed-off-by: neqbal <nooraineqbal@gmail.com>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d2d54b8c4dbb..daefc96403f1 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -446,7 +446,7 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 	}
 
 	start = fix_addr(__cpa_addr(cpa, 0));
-	end =   fix_addr(__cpa_addr(cpa, cpa->numpages));
+	end =   fix_addr(__cpa_addr(cpa, cpa->numpages - 1));
 	if (cpa->force_flush_all)
 		end = TLB_FLUSH_ALL;
 
-- 
2.51.0


