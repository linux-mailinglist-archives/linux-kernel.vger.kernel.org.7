Return-Path: <linux-kernel+bounces-900004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2529BC5968D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60ACA500A21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ABD359FB2;
	Thu, 13 Nov 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtGWwWjq"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC2338F54
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056742; cv=none; b=STO4MhptZBPfrDfODeu1Z/svOrzRwnq/jEtr43paar8Z6TWbMVn+5qzzSXzUverqeZyPOh3llC+Rfhqsq6Ifg7gvVChkIziXe5q9hlJ4tZxphX5AHuomm3SNxeZx0la3XYFAILhrXT5bCowsZM7DUCnCua7qZW+aWefE1b9puX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056742; c=relaxed/simple;
	bh=tzAHs/NW8hzxVyE7YgViwF3ICFGUKDmj3FMEsxS6U1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWR4h+9xrmojvY4mQKURog4o8HllrHac+0c0EjTBAYxQcdDRR+9RLtQivGnPCruwTK5k68C3guLOlCC/OQ5e3PKfXiPyuLcDb6rwz1BGXFX1yBlbUzQerlwehiNrplk1GWeqmwmV5lzOV1NeTYLeSmHpXQP3V9FCWIveS5bTPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtGWwWjq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477549b3082so9991105e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763056737; x=1763661537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONlXezZ8rYOFy9RaN+13wK2rQQVa66Pyx3TL3D7WvBY=;
        b=FtGWwWjqZFjpPt47P6Ju8vQUDh2w77wo3rilojDASBwiLmhr+U4TBZdbK0/XZLsJEL
         XGryyTvMkwp5vDHs7uV3O8qOa5KjDnn1rRAgIsxCFzc5khwhoVDYtzeeiwDWPaP9HQdw
         b50QahjM2tWnlynEOd2xg15yRJ30W/HacQOEV8cpeqG5vcE0Ivt33Nxz8b2GOO9dunN4
         eASNN5elj7l+mKhEu9RnRUsEaQup7Dm9Ejo1lEqZwRPSGRIY9wCZqzb53z5LN4fNzZfk
         OBNUbzA08oIv9Ud3pxIBrFgrUW24KGwEwzhZMvIDSCd7Evq1uMhyswb3sboH6TPkpB0d
         kfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056737; x=1763661537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONlXezZ8rYOFy9RaN+13wK2rQQVa66Pyx3TL3D7WvBY=;
        b=Zh+S99MGSRILoEcl2jJ7wYBZg34+JeN320ihwAsW6U5WmXwAccNZxD4mptMyJmPO0f
         Z96VYUosjTtaS9gi6RKieNwP8wxAxtwqjLWyinZaKncRVv6sa37PsVC49bRnOdw8d+ng
         iCrnVfq/Q/2d+tbA0vY3fZ8f0H2nYNTBIIgNENGqTfw3mFUB0pmQLNmoWYGTgpbLtHJS
         TDfAp1J6D0/cZxTwLenC2KmMgKh/l60Wl2JXrSEvqe3CM4K2eq+2RZjQ3Pp3/jM/ECBb
         gNPOT8h++Ge94DGpPXvcEAQhwWaERElXHiutWXkTsaLVxvmK9V6T+vZLZrVKPkfBW6W0
         WHFw==
X-Forwarded-Encrypted: i=1; AJvYcCU6/PuBJytOnf8xCHAx+ioRYW18O9bqkoMxGv+zf0vfLOcVyE2MOBegSc/H8iIvb6ML02/YHupjsoc7ljQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6sgKglT1nheY6cmd1QEI5qmJjhA6DgeyWWgMb0XuEk0GivzSC
	nNN6+x4XKXiU/72TTYQPXQBpIrDjlhi8MsQJuQijXE4+ObM+8AP5PSXK
X-Gm-Gg: ASbGncv46fQ3i0LSk4Ue0LX3ZzLFJ895GzPo75eAqjC11bpAvt/yF0StGMs4aResTQJ
	t+mA7N2ZtAFwNRZ6FU6KNEqtvu7e/iljQGfk+r4KUVd19Z5iySnwgmwYozSdmVZgt0DNF+y8y/g
	jln+g70QsekXXOx21ZBnIrAc6GJ93BRIsfXefAhAwOZAcqE6Spb/2mt700jq4v99eaIISxhDNgH
	wBkc9NjLxzwuMkj1E8oJeYmGyCexhhIeN4KuGsD8xLFwR1umMzJqskz1TB/mp3i2U6YBcwO0tFp
	PIVJocJYu+bu6UYM8ozoPWvp2uGruHb8++2Zy+BumjaM/rQFTeWrq0hq1YBWVZRYywI9YnOdOAY
	kP4bvWeh5FFKFcJowURUrZiFNrbfZBDf6FYX6RNrTVZLgBexIIfcbhwmJz+Jnlm28g9WcZ5G950
	vY+YslC9m+Pz2Ifnxh1KtOUUXwXAh61643jGdBgc54PQXFpoQv
X-Google-Smtp-Source: AGHT+IHaYkfhslit1+bZ6h2bKwMphvfyMMNqhnEV5TKWd6eJOYYn+BKKgD1tVDFC16Scxd44ybfeUg==
X-Received: by 2002:a05:600c:3104:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4778fea6cf6mr3947605e9.33.1763056736734;
        Thu, 13 Nov 2025 09:58:56 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e95327sm98888575e9.12.2025.11.13.09.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:58:56 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	jlayton@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 1/2] filelock: use a consume fence in locks_inode_context()
Date: Thu, 13 Nov 2025 18:58:50 +0100
Message-ID: <20251113175852.2022230-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matches the idiom of storing a pointer with a release fence and safely
getting the content with a consume fence after.

Eliminates an actual fence on some archs.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/filelock.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 54b824c05299..dc15f5427680 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -241,7 +241,10 @@ bool locks_owner_has_blockers(struct file_lock_context *flctx,
 static inline struct file_lock_context *
 locks_inode_context(const struct inode *inode)
 {
-	return smp_load_acquire(&inode->i_flctx);
+	/*
+	 * Paired with the fence in locks_get_lock_context().
+	 */
+	return READ_ONCE(inode->i_flctx);
 }
 
 #else /* !CONFIG_FILE_LOCKING */
-- 
2.48.1


