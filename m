Return-Path: <linux-kernel+bounces-889223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E4C3D039
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C224423B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1935505F;
	Thu,  6 Nov 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m++XvFlg"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27293354714
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452083; cv=none; b=VZLh/g0a+rzvre5zY2Ko+p53vuQOkGmo2xw4W8IlPb1XReML7OUB3Y2vpaKOnlYSvj9yP2hFGu8s6QNxAHdxo5Ge14hmO58g2McjjApYRkHZUuvYrhhlRuGPHsCDQS7jLuqgcPG6xlNYaP4bPHVLP8jYHf4daUKICZU/vU/hUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452083; c=relaxed/simple;
	bh=ujXfxZ/rw4BEjhU8Wrycg8rg26Ml1Aaup7GlBWzDyZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJifTJqoAQpxc8GYVIZdbF2H6CkKH5IeUHEUR5ILOrkCBMeULRhyx6lXRod6lJxDHlI60siUaVmmAnfZAeq7pWXrkLiWQ35q1/SiigYbTD+yVOU4x2ts4wK/xNSAVpNf0pdPbULJR1Zx17OONvrasTsEYBSKgfjJUXj43Ff0Ef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m++XvFlg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e9d633b78so215349166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452080; x=1763056880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwJ3AQ0ldZfl9MQ5AJahUB+Dg59aqvc0TsxPubrSBz0=;
        b=m++XvFlggLYGtWURJpzC7p/1C9rYObR0h2Tyt10Ec5uh4olTmPPwiGdkW7aSmtfKTP
         oPY8EmvSv9mgZsadOVci/gGUfPTND/8BNUtseqRtzFCnH48A5/qigLhDr4UN1Yp44LIW
         Stpto9z0foT6A0HGJ+IJHT9m3ow+9Qy7yNZ/FRrHBjvdw483rCfl5jqAX30+eMfr2yXQ
         vYm7y0Caa7Oescun6lrsyNiTp6LDf/gQfVt9dxsIIh1R3c9ORJXccBgnP4q2hyJeMb2m
         EtN6itT2HacccrUuSD7JohWIyskBJNVZBqFCAh7MWE2YEdn2sS3Z1fVoDlPB+HkHDUVD
         zCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452080; x=1763056880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwJ3AQ0ldZfl9MQ5AJahUB+Dg59aqvc0TsxPubrSBz0=;
        b=HkUMmDMFpwaLIGSFr5siSePSflzjHUJ8Dq87zfg3MVm7TRlyY1GzE49f3H38K81b0m
         fGr+8M1kgc4glqMqFZ1gTOmACnYQq4ZtnDwsivu003XIxkczNgrBX2bLwZ2VmqVP4iYd
         9fN0qyLG+JD2MSTJy/VRobilNcDz5L90hOra6paP5lOE5cYOXnkU6MDIbaqgimn1TJfB
         TFRQxpR30cytey1yQUeSGLxEBaOOQaZQxrkKP5/V8oeZRNmMaTKyP0zggA/8qnK0oJZF
         kOaVPu2zXjopW8tWZ+O8l98h4c5asSx16Z7f5VuLW7nYwuZ8asGb75IFe4uRU5dg5Cz7
         hmmg==
X-Forwarded-Encrypted: i=1; AJvYcCVj8mpf2aJzCn6hZO03zeD+Rl8EkDeG+fVH527vRndydYq9SjQhK73fUfQIY5HIa/nzr5KOijP7TZBJgYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhoK04J9xTUQMX1yIZBwotfIlrJDw4yX+0WgDo0JmswJO4JtGi
	bTbQMSHbu9iRDsXeTQzS3NUw+pcMiBEEDKWSg+rwKlRbY0Ik+iK1Zvcr
X-Gm-Gg: ASbGncuujb/w62tqH4o+pLhmsO8ueBbXgBYgULpUy46rokTHE2kyzXMY5hwHk0VBpY6
	p07rIdzAQpQOqIA5BjZNLzsiDWwFfyoE7g2jFoQp1dlzZ5PTEssMsW9WwhvoJwsotl1OTdGeljQ
	+j/hoXjx+/l04ThKeqrj79rEdPOSx0fnuWxJdpPJgj5Q7IfmVE6uStDm9B5WRXV+zc6EupHxZ0g
	CvoETGkBOCm+OXV2tkfOeTiwJfpzop6m8b7XHRvEu/RwQIkpV7zFzo9zJV5l1FXb6grzDs3TNln
	bstj1r3cSqxkzA+UktVG4LIzYhWhgS2rC9R5+mWR9KyyHm1eqb2++FfnHetDJEyr5PPBSI75pOp
	gsjmO3895B+x8lcnN8V2iWOgWAQ/adWWwHPeMiv4nJTLTAkorQktWEK11ygx92fxWWHBy6HvRk4
	YQ9FvSaGYVht3z64t9TNy1u/dGRZM56RasP4aIrfRyNqzbu+v3
X-Google-Smtp-Source: AGHT+IH23Tiy/uzhlQVevCqmAaX2EuxhMCeC/ChKrhzDKky+KjjBLdpLh4g1NTZxdt8W+eURbqVM8g==
X-Received: by 2002:a17:907:86a3:b0:b4a:e7c9:84c1 with SMTP id a640c23a62f3a-b72b9550caamr52972866b.7.1762452080227;
        Thu, 06 Nov 2025 10:01:20 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:19 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 4/4] tmpfs: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:02 +0100
Message-ID: <20251106180103.923856-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 mm/shmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index c819cecf1ed9..265456bc6bf0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3106,6 +3106,15 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	}
 
 	lockdep_annotate_inode_mutex_key(inode);
+
+	if (S_ISDIR(mode)) {
+		WARN_ON_ONCE(inode_state_read_once(inode) & I_NEW);
+		/* satisfy an assert inside */
+		inode_state_set_raw(inode, I_NEW);
+		inode_enable_fast_may_exec(inode);
+		inode_state_clear_raw(inode, I_NEW);
+	}
+
 	return inode;
 }
 
-- 
2.48.1


