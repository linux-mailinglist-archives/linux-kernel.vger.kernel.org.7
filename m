Return-Path: <linux-kernel+bounces-871361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C36C0D08C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DC63B27DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B02F0C6E;
	Mon, 27 Oct 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRpwujLG"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED84E224AEB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562869; cv=none; b=Z0LUEQmPrUQ0asq7lRJMeqPa67fycu+j7PnlqEM8iKCmsSAm1CRdWlVs89dH5RfZLLh9UFGZygf9ZzzYnN0eq8EmshQTLy2QGpQqL9onLqhRzFF9JmDTSyHBo4nIuUi/oUcdjLxOXMGhWnkgBTaH8+hVVcYtqfr3idWrQTjCeQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562869; c=relaxed/simple;
	bh=fNSzNH2cea0S6vu+yLc0ygMmMw+DbuZTdNE+lEpxMBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAWcMi1UwaCjpFnxxTXwyqfFIfqgIj+1Q7vTcE0gZ1N44cMLCkzTBAvwCv9k46IgjqvuQ6RGt3FVO4BKmU9k0VYOKaSVqTBwpUskn780dKuAFSWXFkvKd5a7s7jr0INQu4ARNoMhfh7TsSnYbV3mds4183poV9Y5Ne9htXyOPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRpwujLG; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b550eff972eso3021911a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761562867; x=1762167667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6YCUXrqBln9X0KLH2R8ZL8iELcmm08jEAaIpjSJG/28=;
        b=VRpwujLGcH7ldFlpCvCT49HlIEI/drxSLOoQQsHpzYqHeYgPVT076RQMv1Q2oVqlr3
         DhqLn2Rw3if4AJtfFjCe7tCaB2zy291E94KBKWP6ChtRrphz51JFal+kGkcIAXjwWzXw
         tQ5XRftxSXV7fW5TKF/AiayHIeXep4muEvZNAcHUcTsT7DpzP7yG3XqpJ4fNGsuCbgKj
         oLF7/s1A7NhvhD6Pg3+hhUfdRNeZIANoy5Dg6RBOJUeb7tE7rd9EqWYxU6ukWdKqknTO
         5uiPsUCyW+nkhM7im6xQ1pMV7wmj9wOuj+jCOOXFr+XDgTclai4/5PA8Vpf8xAViptaH
         l8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761562867; x=1762167667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YCUXrqBln9X0KLH2R8ZL8iELcmm08jEAaIpjSJG/28=;
        b=l3tADYTeQV8om40hs60MfCRCwbIw+hcbqAVhAvLlfg4uHM5SPFgU9fdcTTdYAqf2N2
         gU/b+Gpr8+KvyRX1IyuyD9qlA9Q/v1CjSwcqterEg03rr0451qj9wKPptYG7RFj2Um1B
         uxfI6o8KElEA5KrvksCcX/KyDOXJrL6C5TSVLfSEsWpvxU1rDn30OseIrfUTU/yLtwsz
         pRLl5hENIFTAtPhh09S/JPhloNc6KG4b7N65IRJzR9eN4W7P6tXmipYKLvyM1LyiJZoF
         +IMUbvx97mxpy2i08pCFwU2/tZN7rQVg+QYpCzIVfOINyIKkf2cPDcXvGCyhhqp+dsZx
         REkg==
X-Forwarded-Encrypted: i=1; AJvYcCXa4modR5arCFKrRGrmtzdiDSXTgqDhmo7OpJtn0P9Faj3GIuoq3D0j9efd2hCLkaBoBwPz5b9KiBDHP0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbdDjn4MewcBHDRC2rFN8wOSQ3Ueqqlss74ZE8wGbzTm/RNGK
	PEcAt5SCdTcdK6PUZK5+k1Q4X4aZh9LkqsiM/j4yHMitExttPo4V8pZd
X-Gm-Gg: ASbGncsxPafVRI9VX81ux7nwqR9CEiL6Ud1Q+dBuJ/aZi7EwBQkPAh4QGchgSG8JNa1
	xCUr9JBd8WiLTzTXTNafiSnSW9s9oAXOIU+588aa+wvpvMxARH4tqJ1HkwnvK8b31BzMBjMkjpd
	UWh4J3PxjhuSSxIOukmRhEo0z66jVAJKBQYBdhZVzgKNbZFBCUboLsPnK1xLOowMvIWxzQ/R1OK
	8maJKlfgJm9/J5kVz387ipl4amvoa3zbjyl6zDhTcR/154q+UN/lKz0NiSD4ke88Nq1bPD0NKOo
	48fcTaZxMlKgmS0vsd6Pf/nfxlaGcEQs9YnWKSPiFAeOvN8by7Mt53Y7tWBzgjo17BjJ2tBb4nW
	Jf0Z4rDnUI8H3cL7bJ5vLclqKSejK/sMDQzhI1hrgflIyWubue/X7GpK9aonyT1EVt7oqyCjD
X-Google-Smtp-Source: AGHT+IHL+n9BswPUU/oHfhmEaW00Mk2l89+YrF7PxELyUmd2/Z/ecgzlueG9NX53az0bLz4lfUZx8Q==
X-Received: by 2002:a17:903:298c:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-290c9c89eabmr442795985ad.7.1761562866909;
        Mon, 27 Oct 2025 04:01:06 -0700 (PDT)
Received: from hsukr3.. ([2405:201:d019:4872:e28f:8b98:990a:8261])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e540csm8111162a91.13.2025.10.27.04.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:01:06 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>,
	Bob Peterson <rpeterso@redhat.com>,
	gfs2@lists.linux.dev (open list:GFS2 FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: shuah@kernel.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] gfs2: document ip in __gfs2_holder_init kernel-doc comment
Date: Mon, 27 Oct 2025 16:30:41 +0530
Message-ID: <20251027110041.426022-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building with W=1 reports:
Warning: fs/gfs2/glock.c:1248 function parameter 'ip' not described
in '__gfs2_holder_init'

The ip parameter was added when __gfs2_holder_init started saving the
gfs2_glock_nq_init caller's return address to gh_ip. This makes it
easier to backtrack which holder took the lock. Document @ip to silence
this warning.

Fixes: b016d9a84abd ("gfs2: Save ip from gfs2_glock_nq_init")
Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 fs/gfs2/glock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 91d0afec4087..bc6f236b899c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1163,7 +1163,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
  * @state: the state we're requesting
  * @flags: the modifier flags
  * @gh: the holder structure
- *
+ * @ip: caller's return address for debugging
  */
 
 void __gfs2_holder_init(struct gfs2_glock *gl, unsigned int state, u16 flags,
-- 
2.43.0


