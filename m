Return-Path: <linux-kernel+bounces-897000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56818C51C76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39C224F7B11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D70305077;
	Wed, 12 Nov 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBX0gD6U"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07AC186294
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944286; cv=none; b=dKnBS4egpz6Nll9JCfThweWj7APjIpjJG8lJLSjLmHuGCFuMPv6kgJqSql2dq87esToK8iEJNY8rW5XznUTNgDJPntAPxeYyHz0Xc8LGIvI9FAxMU3U2vk6LPPzm/90QxV/GfVussdVG4Gn8zT+ZquuzO+Dq1/Dk5WHZTKw0JtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944286; c=relaxed/simple;
	bh=fybpzSb46YiF9J26GboN2B+pgJim56okIxMbRhK5hcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfS58b8xjMD0iLEXcbDQJNphfcjri1phidTk+4oyNCsgwOMPKbYnvQoRuCPI7bLIM2tF/zE9jEe9TThU/EV0Krf+ojtwtTM028UMro7hCxmIaPtfIziYy9/OGVVXltsiN88Qdtff9XYGjBwiFySTYGe9hHyUNyBHCqv4BfuOOyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBX0gD6U; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso116522066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762944282; x=1763549082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFUEBsO/Qu/uezzNpLMFcp573WoF1qga0QGU2MJ64f4=;
        b=MBX0gD6UwHChen2bu9z3uDyw9h14E02S93I26e1P7RJUh60njWEKD/GxFZO/DeEedQ
         1tXl4siLMT2AWnuuDwZG3DXytRv0ynUPFI9WlMdktHH/rPwwDPvz2W79MvY+30uNqzPW
         Ej1n1mKXpsSa7HjcgrFecIzjJL+cKoW2Y1gpQxShp1lDle0B8+cefQPih1uRpOeLT2dF
         YTbutq8n05dSSFwXWUhQh0saiouOfLJRRxs1pwh8JRNKUAqyEHkF2BI17pQ/L0Rl1czc
         sNDnsu2djQr8q2lasuJd4MqLMpWJi0eInZZyUcwfHbS3u280Fjhm6oTN66kGq9g7yU9X
         s/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944282; x=1763549082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFUEBsO/Qu/uezzNpLMFcp573WoF1qga0QGU2MJ64f4=;
        b=VPPwZ1KeYe6/OftWOW7nezLn7azKQIN5HQY3WAuDCqNV2AebcASV3kdq+4RP677xpF
         akkBQzveOQeXHFEMKGWIn311b4aNRWKP2DdQ/XMFYBULjNqcT8CnvhCoiQEO8fk7zVWV
         6MtYOglvAORNvx+tUXVKspIPwh1bPgQO93kEg/tpDHkSUI5NuF/paj4oZLUXP553KSv4
         99m0jhffwz3kk1Ye2ktn2b0fsGRnn9TQPpFXJE53EoB/lWdkCwZSqk7RS7ukWefXn5sh
         jJSevs9WWskWX4Bv/NpQk3QcW99QaqDP4wMwFG5jkfGS1ck2/QtkgcBRKg0VsMveu/FM
         eTIg==
X-Forwarded-Encrypted: i=1; AJvYcCXofK6QLOxS1D7YWD0mZTpP19ttU9PQYUUlBtwPs3kMGR3JNZ7lkbeXgUTmacT+yEV3hXgVm2ytw2Y7VJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9gZ/QdzSI6pyTyS786HOswuj8aGDVMRwjs+KM+oYy/GsKLqKg
	lkryUZyw/ivZL123Qn4Dyz3GVqqHnMQhr2ov1T5ONPqAAsL2m6WV5/jG
X-Gm-Gg: ASbGnctWwCCpjXDwBY5nLNf/k9NqitwqnCN8ODvfQjDOyPZu9NAS0SAANFonL9awDP+
	F5AtkGNCWroG201201xCBkeqHGGSue66WXBIYbJsZKkW9COD9XsPGm7+1+fpe8AvOEb5Rfb12QX
	VHHGS7CmSwxzh3W8OTThShI8q/ZpOIw6IlLTAVdPh9q9B81uiFKMlrUegqVux/SHP9EGV1HwIz5
	7CE+GlYTkyUSAoQ2wyObmPtBr0JNvDB5RtFAbKRULVi92rhJF9ogBnWObmHtdEV9qnQsbv+bcLL
	8OQ/3wcH4FEvIbpOaaYtpkU5h5GYTuZ4kgN/8Ukjj7dTiuZbqCKurXUYbdmQa2mTOLONY5btPAu
	ZueQMXoKuOj1khLmCFayOOt0iWQZ+BHc7lA6ppq1k41xvSvM0igpfITjTJ8NBPkiruNtlZcB6+o
	xMkTgK+h8dGEmXhgWnzyau+uM242JI+g0jYlQsGIpRbgK2X67y
X-Google-Smtp-Source: AGHT+IHrZmIs8nk5ArTcfh60GG2k3h+jurwLNlYK2ksnYIGUN7QecVUHw/+hmvKIg0JO4bHSSO/DUg==
X-Received: by 2002:a17:906:ee82:b0:b73:1e09:7377 with SMTP id a640c23a62f3a-b7331aee6b3mr247579066b.58.1762944282086;
        Wed, 12 Nov 2025 02:44:42 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc874sm1606655466b.54.2025.11.12.02.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:44:41 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	jlayton@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/2] filelock: use a consume fence in locks_inode_context()
Date: Wed, 12 Nov 2025 11:44:31 +0100
Message-ID: <20251112104432.1785404-1-mjguzik@gmail.com>
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


