Return-Path: <linux-kernel+bounces-842893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99D9BBDE88
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9213AB5C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA22A1BB;
	Mon,  6 Oct 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRADCv4A"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C0934BA3A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751138; cv=none; b=GJ9fTkRkgAw+LhqZGO/uxwd8FRZDsP/D70uV3Qkpxge4YnnjlbtuD/sQRGwqrEb/9h8kN/K/Ft22F8wcMWSSOuErsDim65FXa4GVgDFp/OTWKJ6TmKp+mfBXTesbeZkwMhu3B24w+lpu3+rOiAAba/rAqmp1MeTLtXzalwjChUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751138; c=relaxed/simple;
	bh=BNMTecTK7ht2nSD6ZXYzFBe3xWgFyVgzfWdD51vF2ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiJzK7kVfyaA5+uELf1+0Fb0sWpkDjrskU5x4j1sd3+TU5gHUH9sTGNWSqymP5jJMcfdE7Rafzz6Ybyhj/rqCK4Q3VrSptNGcyK3iwINC9hG3WZvjujiL31XgiIOKFUbok49Dwq3s3QrczOe5mL7zVGouhfVg+4aUEn15gEHHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRADCv4A; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b62e7221351so1971723a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759751136; x=1760355936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6fpNIGval6qAKSpqRMG3diXPAJYgi/qIqxbDjCK0H4=;
        b=BRADCv4AmoGrSNykcmZfCU/NW5/7yNOzfyyXh+TlUefpAiPXbXvjsvL6+Mkywkeaux
         d7RkUdN4FTXhku8uwu8Ynn3ZtHiv6N1kgGjwsZ+etbRxQcY0kvKsZQr0VDnKy0AwVrIS
         B3ei/oTRLl5WFIXu/soM4vbP+Yuie2aQ60yUFwnBCJVbdKQ9iEQkZrSJjaKx9D1sFIS9
         U45p5CwcA1iCaoLLBd3lMQKQMC0WomvwA2PpWgYcCD8QZv+oQEn6pdqBTe6nj8HBV7dK
         Bl+Ap2jftmSXuvc9TvE58gljXCXfJx5jMWUKp1EnAzIPw//8FzM2Zf2OkkJkkUQEHKgV
         gdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759751136; x=1760355936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6fpNIGval6qAKSpqRMG3diXPAJYgi/qIqxbDjCK0H4=;
        b=F7Z9HkzVXXyF4HMu8S8gPYk67STl2QY9eBPaxU5g2Bfj+R/rfB5dbR2CM9/bRO4jQ5
         DYiMeI8qv5t4fKWGbZhSxYN9/8wKbOI0HOvIV/AILsdl+mHs2q1BEuaw93zDJWwXG+8l
         9Yt83mDz08q6QHbQldu46A/DU8ABwb5FNu23daCTLHgT7kEpd6KzJxe0R/KEzIwjhIZx
         l5YMbk3dGKOoUqPtH4WlmLhnPVahd3BgZN6PTi5hC5Kxv6kGzDFuWB7jOrI3W84Vf1+T
         FnBLFKQG449SXxD2GeKOCSqVMXjVaZy00Z+6y5lg/Vy2cN6mBr2Mwd/uggRWABI61Hjd
         opbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9aKOwHgfRe8iICdV+VIM5r4PJbcppqYIC2fbmtG/ilwjVPmsBBZk5C9MAF7myGzCukS2srGw9QlwbH6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxONb7xfkWOw4lg/UM2lsrsnn/bQobgkIKsVsa3GL8ZLIe7SZrG
	SaZPLF0+aMmDQC5ztHOmBTIa/rj08GopDCPw4wJhzIzzfFw5yAFpff0H
X-Gm-Gg: ASbGnctEdPFmNHsJVwL9relYn/hv5+yb/L29qn7AZR8mfjb/cfiDsjFoWkzv8UIrgcp
	hLk2Ps5f2Y62OHe+MZ5Fa/W54HWkQAZguDWDkbrmTdGMUBK764M1YoZJYGxPM5S6wCFm+TPcKgJ
	OWGO2YtspcWEbZEEwAML86UF25vvSJpRGcuPAywUEY6SXnBGneDEIQQk/0pmqYLyTIkCKLixNKr
	JUc51uk2eMqY1dUpOnYaIXNv/Uci70SkHDF+9bi4q1NvuxDrw8DGvF3rciHd8hF/hD81BnDv71V
	P+U26UJdittqa8vLMLwLN14rCwmxmFGExZfKM2nJ8NhOm/RjIruCtGS9cXtqwuk7OTrnDLmro/a
	X4pRxouxwCP/HLNzBDd/7LUdJKmmQYHd+kFrLs48R5spSK09NO6nK2HgjEJL1CHWEy0qb8xY6Kr
	TpCDbotdf3
X-Google-Smtp-Source: AGHT+IFxvKU50K5L0Q+Tb+yTYS0SE7q47+l6oijumnjKnEw2OY+E5WVkaAED+m1lCr0N1DGoF+vVUQ==
X-Received: by 2002:a17:902:db10:b0:264:8a8d:92dd with SMTP id d9443c01a7336-28e9a58b55emr157083105ad.20.1759751136030;
        Mon, 06 Oct 2025 04:45:36 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b845bsm130568745ad.79.2025.10.06.04.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 04:45:35 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: viro@zeniv.linux.org.uk,
	pali@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Date: Mon,  6 Oct 2025 20:45:07 +0900
Message-Id: <20251006114507.371788-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the loop that converts characters to ucs2 ends, the variable i 
may be greater than or equal to len. However, when checking whether the
last byte of p_cstring is NULL, the variable i is used as is, resulting
in an out-of-bounds read if i >= len.

Therefore, to prevent this, we need to modify the function to check
whether i is less than len, and if i is greater than or equal to len,
to check p_cstring[len - 1] byte.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
Fixes: 370e812b3ec1 ("exfat: add nls operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/exfat/nls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..a52f3494eb20 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
+	if (p_cstring[min(i, len - 1)] != '\0')
 		lossy |= NLS_NAME_OVERLEN;
 
 	*uniname = '\0';
--

