Return-Path: <linux-kernel+bounces-838848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51177BB044E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1F916A074
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77102C08BC;
	Wed,  1 Oct 2025 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhMkN6Y7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA91E5B72
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320186; cv=none; b=jmfOBQBLfqtt4GX0Nop6XFS3fWWhtFg4v6Iib5/4KLBSbgDtGxBitzIxuaEcheOJ2nIPiAWR0jsOvGq+ZVFFozCanyE9yWwta/QkTDHjfa9cGrEsenoLrWbZmtOUIcSYCi9SmW2K51aFhWwyBDwqOjsqdm7LUjXFx79Ox7Os2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320186; c=relaxed/simple;
	bh=gF2Nfb/yPkJAa8Hu98Edwh1r6AB0Clf+AIY1ewIRaoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLIRt19IWbB5qbADav1gB9rM48IlHMlVTjhtN8/UT74/gtOgUUci9zZROHKohmIybGW/SR8XxybgN78+g3ChK0HyAuRngN3tJDsQGhgTmtQ75cEhyOaXxdrjCk1k28fEomwZYFa+bSOm8q3b8LuiB6Ky4HWZ8wMEPem08KY76o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhMkN6Y7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so106719395ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759320184; x=1759924984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0vDG4/fq7DZeKUTWI2OCBq7bMjSZJ2K/EiZOAMPt4k=;
        b=GhMkN6Y7lp46AcK1RAwt4tY6HLFyPpd2xQkRY1+FJdsQv06P70hDjZ5fRauSJ84NAK
         8+dr+ztjj299u2wmdEKR0iJQ7NfNytOBco4Y9uHu1susNPheWXCnro4PeSXyXp3+BuUK
         4C6UYuN5ywc7SX5wUXF+UXmCRtEM/XdD2cUC1jE5Q37erhBE2qf8fSfIng2YMD+h1X+B
         YNSA5p+WZA8v0UZbs2ypbVW/cZiRB4X45+iINblRXykWYrs2ZXepSaHPbM6kXIX6sra7
         PusoOXMCuP8dnwMnCbG0i2egvIojakRCRSskKxXHbR8TnJ3ktCV28ELRp7OrCxj8Iv68
         a+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320184; x=1759924984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0vDG4/fq7DZeKUTWI2OCBq7bMjSZJ2K/EiZOAMPt4k=;
        b=sLF6/HXxCzNZvAUxkYtuWAzxVBj+6G9H6owYD0HHsOGePLsyRyJm1B65rLj0wXmMjs
         yZfP2lZQEIdbypOXFvWfMrkmlKX0otuAgO+9/KUd8HWpgeM9dvfqD8cOf9EZ+tFhoiRh
         PsB9320YPH4kmGmiij8S761hcNhioZUdikCl4KhADqcmENBwtE/ldiq9fkedrczfD8bP
         ygkWtukD4X5XIEd7TbLkQqL0rBeLyH0AiQ/StrbzC0mxy/j72dGi0u9Mvlv8jDP/kxaP
         ezTM6t2hiVrnBkQPpETpyXy3cJyV6yvgBQ1TE1wNsbqIswpMmRPKa9kQgE4sqiQVPrSJ
         r3xw==
X-Gm-Message-State: AOJu0YzWjka5DqMKhEJ0eEhKSoBfDT6CW0sZHNn52kEDEl5kuA4Npl12
	zvIQD86SR3utMAvNvvms66EK07XYUJVpFnU2SEVd+Vegv0jduBv+hq4F
X-Gm-Gg: ASbGnctGGBRXnucE0Cif8m2jVhArV54fQpqDwL27ZIh2gaCkjVkCuMKB/cOGMAU/s2I
	jAN6Q0j7hx+j94M5iTWjbULnelfMfpCbPUVK7WPSEQ+1LX9lMx+SqOoBMLSXe04w+LFhVed9oqc
	4Rz13sB3DnSabc9giYVsnP/7x4OOcyO3hKONaQqIkS1U8BSca/aWem9Hs7RyDAdIGfvGbOy9nP6
	rUh8eQZux92aBgYEzGSJMs24dzBBaTFt5uLRAuTPNsxmVDhq51u5HFbqwccnH02moQS/X3EpSFa
	v3rJ4plsquV2nNhfir3dNSjP7zc5Tz58kpfFK5y1bStUc+V53wouyM/S5DE3/3XPzkmMHsuzWuU
	S6ZEHT6QTbFtd5Uh/vyEHGWzraV5G5OQCyVmU+PgB89DQeTascMfRHSgVOHhg9QB/Z68=
X-Google-Smtp-Source: AGHT+IE7m8OIwMz2w8M8bP9q+AW7a4srs34CjsmnL8oZDn8XkWOKffvht4XkyftXNcv/2DLikcz+rA==
X-Received: by 2002:a17:903:3201:b0:281:613:8449 with SMTP id d9443c01a7336-28e7f44200amr40785835ad.47.1759320183833;
        Wed, 01 Oct 2025 05:03:03 -0700 (PDT)
Received: from archlinux ([205.254.163.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab67a9sm182986765ad.131.2025.10.01.05.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:03:03 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] dm-crypt: remove ineffective comparison
Date: Wed,  1 Oct 2025 17:32:54 +0530
Message-ID: <20251001120254.24980-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In restore_dm_crypt_keys_to_thread_keyring(), key_count is a global
variable declared as unsigned int. The comparison key_count < 0
is therefore always false and has no effect.
Remove the dead comparison to make the code clearer and
silence static analysis warnings.

Found by Coverity: CID#1649028

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 401423ba477d..39cfc13ff350 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -115,7 +115,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	addr = dm_crypt_keys_addr;
 	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
-	if (key_count < 0 || key_count > KEY_NUM_MAX) {
+	if (key_count > KEY_NUM_MAX) {
 		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
 		return -1;
 	}
-- 
2.51.0


