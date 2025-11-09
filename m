Return-Path: <linux-kernel+bounces-892070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB26C44455
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF1B3A8F93
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B7B30AACE;
	Sun,  9 Nov 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6sor9YK"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8FE30AABC
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709126; cv=none; b=rpAicxnys/ReIKqqdAO+JGr6gUlFFwDCo2jUNZv17hPSc45iBFYNMImKyxSTXxOoWJTGZINFEs46Ee4f8gYBkJyLUNfY1SN7sV/i7ZihmPqFD/Pm1SZl4IohmHBGM6xfX1P8QgKjBHcA+T9/4VewG5CasNoCUgW9YwDcX6qAA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709126; c=relaxed/simple;
	bh=IhIkuSuF17GlsVUwGV7Fi75Nge9iJGGX57xSFdaaG2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oeeHq0jOGYWp21yxYWUyvabFlAk3vlXobfPXJrRsrtOZEYdvGUCPC9/ooPNOiLtR0se14xCueLpK72XugNI02fVZhjjGW8pfDtBEY/yp4XeZxR/Pk/q9jOLJX/ECu0CiHVF1jFe2il/sXTPaD+KwI1SpJU1ks7de8lZES8R9rRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6sor9YK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640f627d01dso4124415a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 09:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762709123; x=1763313923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5uUj7ITcpZj2TsML5T8Cl6HHMpcKN3nQGf9uTJBYnM=;
        b=m6sor9YK4QBFH07aM2PIDtspRSlSz7wyBNb0DkRk4NToI42oKGufWJGXbS4laM24ac
         BCKZ2OvoQBqMe6DMcy350twzMBt18tQHP96DUXB/4ZyblgTnGLMq+9yfwDbtveuI71r0
         t9Ccf2V70RCeUJnjRRR/Kn4fUtVsWfYSKAQRWiSTFo/7p140qn9hi37bxlE9egZU5k5b
         VpgMP+4cdldBEKE4RKKOcLKtW20XCAMmIoW0sJDb5yn1T9pHESbYA/8XlQwdCycSidy+
         yUqfP1ziGfjSZoU3XxOFGrsePITc3s/WENWWLbR6bPJaEinkOQQFXwkF0wzjIYceO4ga
         7YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762709123; x=1763313923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5uUj7ITcpZj2TsML5T8Cl6HHMpcKN3nQGf9uTJBYnM=;
        b=qCARJ1Hry4o9M2KteR9X1I64HtAyNH4B7P/9YGe0w3xVfKA/j4r71y34NZaa6taZ6K
         N/zI5kSxKyHXT02KfyinpJeHWucNFbxTCeAZb4jq1bPjhBOa8EcssnTN5O0hAVERN1K4
         iKmeTGemlOWXX4FQ7Wvh/l+uaKwwO7mnksSaMHXS2QCYc/OnGHqz3vj3G6J2LOoKB4mG
         wuplLFASyETbPuxirnD7P/5jW0YDQnyfoC3fl5ik71csTCeSRLbuhC7qKDVqPpjEfME1
         MiHenVcnnFuptc7XLaLew7lZDPNjL7ae4CHzYAaNHAJXq6oOwoJvwHXdnP7P0OnQFyqu
         uK/w==
X-Forwarded-Encrypted: i=1; AJvYcCVY92MihswhqhaEIRxRxtM0ClCfZXBncHOv5jsDobr861aLwmqi/98swZCcZ9l+5rLpni3ccXOb+k7SJ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Y64oubErhadLOzbVVh9edcj3DKWGhYASAi1/xvEYh6spVTfN
	XjHER44xaaVUDmP0owQaJ30Lw8WRZuwaF5dbDXfawE8WHDl/HasHaOfM8q/P/A==
X-Gm-Gg: ASbGncuOCN/tqR4RMXriai1ac9hYVrH3ZykgXFQw/fFhfiDHtJjvn6xQizFddrLQR3p
	Nn6HgEQUWAqAlch2RFILDxdXNaLq2s/Kok7m99fOZBYfDVmnlZbzn9gCTagLZ/ztO2CbNuHKk8e
	f0kUv+JPGmpgPzofHwwoIuC5f8Si567wOqkN5PblK4SSrGAJEqH2vHeUraN4fSa6rOjOOw11lYy
	ImXtXuHWksED7xCCT2AfgeYmxgu0qw8tdIsJ5BQ0TOrm8LSpUk8jXqcBul0uk0BIq0kB+FPdW8q
	z3Hyci+8soWQMwVzeIPbIpQY5+S2Mf3m+kIslB6b1GAGEhfvEKkHzZ4XldYxYSIuUdE0vuZCC7Y
	/Ow1a6xmynTUPqO12TV1k/In8rVuMc03axPH3w59iD9Du88YCLZDjajnXF6U5/+m6cSP3jveNJD
	Sht8uUqWBilxMS2oqjPHp4MY08SYRu9mCQG2lpLZqbh3Z873Ecdiq/Dm0bvo4=
X-Google-Smtp-Source: AGHT+IFWNwV3C/IaXRRnwobzv1o9PKYxfESAALRMns5L92IjMXOjd9WqLoAGQ9NI9ORRXtNCpzRCWA==
X-Received: by 2002:a05:6402:354b:b0:640:ea4b:6a87 with SMTP id 4fb4d7f45d1cf-6415e8134a5mr3660037a12.30.1762709123200;
        Sun, 09 Nov 2025 09:25:23 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813bedsm9257748a12.10.2025.11.09.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:25:22 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	jlayton@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] filelock: use a consume fence in locks_inode_context()
Date: Sun,  9 Nov 2025 18:25:15 +0100
Message-ID: <20251109172516.1317329-1-mjguzik@gmail.com>
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

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

this is tiny prep for the actual change later

 include/linux/filelock.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index c2ce8ba05d06..37e1b33bd267 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -232,7 +232,10 @@ bool locks_owner_has_blockers(struct file_lock_context *flctx,
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


