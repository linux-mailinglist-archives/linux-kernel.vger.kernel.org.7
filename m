Return-Path: <linux-kernel+bounces-884733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C51C30F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A270E4E55E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C92E8E09;
	Tue,  4 Nov 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy0FXGS6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F672DEA98
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258600; cv=none; b=Vcq0lwqUlpdMU9uz387gjkGGrLfIwr01RvAoMmKuXAITnuc6c+JIOBl4HKCEcqt/KMUoCnwFyxiAOKS+2wMHkC2J8tFdKDS4Qsrthi5GmKxDKzw6qUbT4XtlpOfsQOhG7Jednl3wL4iAtkARHRZVneg+xoxsegdOlgKhbXdPeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258600; c=relaxed/simple;
	bh=KmF1ild1xRClyDBcecZ5U1luwkLXb/wS/QXdRFfIuPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/JhVtKxm+j8e1M3IXH007kNhEU10YE7NLJOtSuuCWtTnhDx2FJyABPzncujGWBkmEANkyiLJ//lvkSXA/CDgGA1nvrC2KefUuSqKtVmp3v5kIQRI5xguzAg3n5ZdD0NJhiZ1h6rZwFXFh7SVoGJ9DHDJd0iwPc6yRaNXWXVnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy0FXGS6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29555b384acso31641155ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762258599; x=1762863399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qm65bXeCJn5pnj+/OO3CyTJYCu+x03vH4a2TBarzblA=;
        b=Fy0FXGS6ktrvlQLzcPGqcTYCAaYV6Mdyes6xBQtN5mI8x5UKUfAy9twhYHH+zt+ZCR
         mLantyz8udWeEwC7AlnGQtIT3zCWHhOoxZx7CiLV9qD8DdM0rnK5mOa8InBXNbcxuagq
         +DLoGfycDDa7I1SemHjt3c0FiwSAi5gFgy81hb6C9ck6LWb+Lakt7UBjd4ybxz7OAY4U
         s9KL4z03SdZlFErP1ADh3oSMc3E3WnJ2vKrq6lqOJ9cOex6yj0VuTNFSLdAf2RBYXiP1
         KTxlR8FiqhEFW2eyIbkVuW5auCcmpIb/5dzmuaenC/ysWNsuDv5s3oakyB/D0TkLckv9
         /j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258599; x=1762863399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm65bXeCJn5pnj+/OO3CyTJYCu+x03vH4a2TBarzblA=;
        b=iM3uhadKnYl9y6NZT9qq7yzg2RsS4TOexKeZeHSZP1R+JX0iql8p6zCvsU6dV0LCZG
         sai6mQbRYzNvZb1JY0HVS9M/HY343Iy5rLdwEqYwtm2bGncWvn+mWAOzZGsM7JD6SiuW
         VUAwSv5Yw1t23Fkj0Xo2zNGdgvwPAWxBAk+brEJxvOWOd7PWfmxjqS4Yex2eKhdO3erq
         yj9bQoVs19n76wqVqgsUOV9ripbwaVYbFyk3PPjLx7s2OZGDaPQiWtxb3IJPnroR0pFg
         z3AlwjXECWJLiwREP+H7hX2jLGEk2dHggkl2axuvWcONGTseAsyv0dfY79Vko0ASyrl4
         lIFA==
X-Forwarded-Encrypted: i=1; AJvYcCVJXbQtKqkLeKxCUMxgoKb/I0zkcRKWy/HOacPlIODyMxh0pFlwAfDL+G1Qer5UEX4OKS574y01hiKkKPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6/XDu2wnW3I1nn7cyNtkGJ+mOiRn3AsWtLXL8GZCLJJOXLsz
	KRn1eeMlSEVEyKzhHuAT4PcfS8093QSvLV4109xT6zcMiGYDaHtyf0G1
X-Gm-Gg: ASbGncvyOLp7/FBdNl/dllrOh1P3S99eJa94iw4QvKC9YfgXeQuGUtvkn7SIcwRzZ41
	Nm4AKegwXdLxrJvhbGYtBzH5PHLbWC462Yr/x6bLZ4+MXpc9LJbFwtPZErM1UezkmLkXVvZSn4u
	WyojPtdw5w/MKaFsPbTS31KSkw5C5GwXQHhVCTFdI7xlBku0crMyDvC+0ra0kbEnQH3qH0ULx6+
	4dLWewuX3oAYhsmEv4jshLcptL7cYVeqFgioeewT+OMDLbWQBBlwxXPOvGyEN+fYpBzRj7uNA94
	NBqBG/0jofL3OzjO+gf1wCVNxKCia5WWZ353/7sY/EHcp6LJGR8OgCRLgmhHeXAW5lCEiMUq0X1
	Oxlgyd2r4E6d5Q9c6n41PEEgsOLhEiVHxX7vQ9vaLvJoetZEqP9WoBG69yzp3XLA87pPDgOYTLr
	JZpkiDKLLUgO9NAQ==
X-Google-Smtp-Source: AGHT+IHWfL9ukqE2uuV3u9mjGfvafGL1d6Fs8/ftcpn2dBlsfCsDaAEiDNRs1yYtV7lZN1i+KrcEew==
X-Received: by 2002:a17:902:d486:b0:295:c2e9:604e with SMTP id d9443c01a7336-295c2e96112mr68237335ad.51.1762258598598;
        Tue, 04 Nov 2025 04:16:38 -0800 (PST)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415a1c2e69sm4436715a91.6.2025.11.04.04.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:16:38 -0800 (PST)
From: Rahul Kumar <rk0006818@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com
Subject: [PATCH] drivers/hv: Use kmalloc_array() instead of kmalloc()
Date: Tue,  4 Nov 2025 17:46:18 +0530
Message-ID: <20251104121618.1396291-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/process/deprecated.rst recommends against the use of
kmalloc with dynamic size calculations due to the risk of overflow and
smaller allocation being made than the caller was expecting.

Replace kmalloc() with kmalloc_array() in hv_common.c to make the
intended allocation size clearer and avoid potential overflow issues.

The number of pages (pgcount) is bounded, so overflow is not a
practical concern here. However, using kmalloc_array() better reflects
the intent to allocate an array and improves consistency with other
allocations.

No functional change intended.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 drivers/hv/hv_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e109a620c83f..68689beb383c 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -487,7 +487,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	 * online and then taken offline
 	 */
 	if (!*inputarg) {
-		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
+		mem = kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
 		if (!mem)
 			return -ENOMEM;
 
-- 
2.43.0


