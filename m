Return-Path: <linux-kernel+bounces-784029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8151B335B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C111B1B218F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B126B747;
	Mon, 25 Aug 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI53tEus"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387E14F70
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756098535; cv=none; b=gqd+nSg+3b7gSs+agFyaw5Qhog2SAVlYDckM0v71U6kh9FZO5llL+3iLGGUBLQnU9LW9wGoYRKU6ye8cdxEEDcAUTFhDYetp8rcS6uzcWpcmhOMxOU1s7i2szfNCXUgZIVGfnuIurVJHLBypPJ2h4oF3krc7FY0ppz/G+e8U4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756098535; c=relaxed/simple;
	bh=TjWukWyg/1Yl+QsAk2myzOzlUeTwPDjoupR7OI9d2z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DGQiZe1CHw+o7zrGRe0JURViG5iMl4lfIf5TnhT0L94bsejaVAez7cVzxmK3CJU5AvYDL3CjboTQZDr3yZmtR2YJIXn7r2+srHZbHuW5GR4cOhOZUodrrnWsw4Xoz23bZUzYtGLOYkab4j32jgjwi9pzJ9LQYaEmxvmtHlOsLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI53tEus; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-770522b34d1so832047b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 22:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756098532; x=1756703332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSX/z7sKvGoE7FpCC2Ikh1rgDq+TwRfOXAyJO6CPWsI=;
        b=RI53tEusZq67eneO4DwRLUcnm6UPr8rz2Rv4NnO6Vtc/S909dkbTZoETmgPBjBm8Xi
         kQC15kdrM89pUTnr6W63+C9X+hCvD/LOyojVoyyMs9xd8B594TWm7dxQglugdBtBsENH
         nb2+nUifhLRYHnMThwoICh/VHnssV0/eIZekq2GP+oGyE3hFF+U5xtPlNt0NEFXjoC+7
         8OdAMpxJ4+Sbt2D/STa09gogFEqBb8WGmT/eXM4tBGMJtasj7abm0rh0KgiGL+WqD7Gn
         dWOD+gWuEtRU9ghUQt+ow53MpslH8KiDt7GrApM+l+8YfPMGMjxMvmIH/qsWB0D9FPfO
         aV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756098532; x=1756703332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSX/z7sKvGoE7FpCC2Ikh1rgDq+TwRfOXAyJO6CPWsI=;
        b=L8cibVrX+pFkIgEtF02o+K+AyEi4C/qnIB6VjjnzAxyt8hj2/z62XV+LyZxpaX1j3Z
         IQvUW6vPAihNyGk1tmfOhKfafL+v5M0jSyWx4cWMmkTYUzxiLz8nG5qGD8kgCe7w0npu
         jdjhDuJc5x3h1PiEYHz+DySPYDE3PVKfODEDx0dg0pnW4ik3Li2PXAC8WD0+QcF4Ibum
         bATpSZ49DH9px3YEV2hS48DSE0uF8VFaMiiW2cAWk9pNIM1Im+Axxir6oigQMlh89+u2
         DkdvXkfy4xPFbJ1V2/UXFIQPqssM3gFhceMoGYk3Ch7zxRW6rE/mswQEgEgh32RDO8cm
         42xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7JEIHlb4gWGuiQ4g0Z7dstnm5sjSX0OtXeMhD6CtUjJ2KY36UotXOwnyv8bB72ayHQ9chm/EGjejYqZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRwB28hvAM5MQs2CGEDfE9mB9G5SUKao6SqLXcRKYpLC1Yu2z5
	u609TOI2C6nstPZvhz40Em+mAxQBdKv0YwjFOwt12A608m0Rhu/CeKuZXDMNVg==
X-Gm-Gg: ASbGnctT07qBZaLjK4oPcaT8cnNHBTeWo6kKQG1aLpbYt0+GSHYu7dohEY9jaXON0Dd
	93e/wFzxG1qYzIE3szBW5V6feLy6P0C1Kejqpkqk0z+reKMyyYLUGJUVEjdUTc80kLR9dW//Hk0
	uOpZJt0ZXkhUQ4Tke9oT5rOIOXHS2Ajruql/1C5Oisy1PXft2AJmAV1HNdkgNQAiJ+3ng4XqNJG
	kIiTbOuMvx/6FhwAA9Qm717BWhsBmV5KOJDFZIgUxmVWEUrKHUBBdpHclersbstyA1SJTExni61
	bHvzsCSRtftsb6uHcZv1FuXu1BPA2GXht7eSmWL5wT9wF0gMGB0WCR1t+Xfk7T7/3da+OaIs98M
	xIly6d9ufA88FLWb703Gs7GXd3Xg9m7btnkKyYIC0mmXLxvDu6nbt/jX/cQ==
X-Google-Smtp-Source: AGHT+IHXwkWTxBTR4OSwy3xyu2bs2rZiZ9lY29qqyPJvSOtaS3ZlAjIaRjuaXd3gQ3FbBPApMZQ7lA==
X-Received: by 2002:a05:6a20:938e:b0:243:78a:82c4 with SMTP id adf61e73a8af0-243302caa1bmr19040399637.25.1756098532506;
        Sun, 24 Aug 2025 22:08:52 -0700 (PDT)
Received: from archlinux (201-13-80-9.dsl.telesp.net.br. [201.13.80.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbbbbf5asm5446800a12.50.2025.08.24.22.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 22:08:52 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
Subject: [PATCH] fs/ntfs3: fix typo in ntfs_info() message
Date: Mon, 25 Aug 2025 04:00:28 +0000
Message-ID: <20250825040038.4524-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct a typo in line 1296 of fs/ntfs3/super.c, it was written
'recommened' instead of 'recommended'.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index dd5004efdabb..fe40d12e3353 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1294,7 +1294,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->volume.ni = ni;
 	if (info->flags & VOLUME_FLAG_DIRTY) {
 		sbi->volume.real_dirty = true;
-		ntfs_info(sb, "It is recommened to use chkdsk.");
+		ntfs_info(sb, "It is recommended to use chkdsk.");
 	}
 
 	/* Load $MFTMirr to estimate recs_mirr. */
-- 
2.50.1


