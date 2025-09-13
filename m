Return-Path: <linux-kernel+bounces-815011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F7B55E20
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6BDA086F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2D1E493C;
	Sat, 13 Sep 2025 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFYNYJ/t"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C91DE3C7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757734651; cv=none; b=B/wX/qCI7+0fG5JKvlUiZAhj066B/m/0QHwguIVDxKabhwuB45ydqnUsgg1drO93FjRxVi0N8uWEyrxCF/IPJ4lmVkoemYk8gHITT43i9CQIL18yJ16cVi5asmh5vSAjNCeGNfBYSGZ5Z05fpPvkwOi0dPctQ2s63QaOWmwrgCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757734651; c=relaxed/simple;
	bh=nbmHvENF6wiVd4LFNsW3/Myx/TXvx5lSSh9ejpw6OMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNfIkzCm8EELjlwWn0XNBjxehkS8pGv1j+8nV+zagKzXScBETJ+IrqWk8j2fJ+oF1zu91KEFFWSCBKPA+JRLSCN1X98SBq6BhinrZE5Hv/Kvtn7wu6weRML0Fi8Yxgp8qSI8JUuM4GvNgX1kK3xX95eHggjsf+ed9MgoRi70cTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFYNYJ/t; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77616dce48cso914929b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757734650; x=1758339450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP93xN6gwLHr70Ds3prjvKvRcobCNOyB/BNk5HT+4PY=;
        b=RFYNYJ/tuvLylsma9+lf6Nz3v0bne1J3fs6cSSuHfOMuE4Bmjym6fiENFu3AnC5nDI
         qQ7FD97rwLEKV4BsfEbjt3y5kR5cYom8qKFcii2ZHSPiEiIyA2CXnj86TVBmlFhtfA58
         zYzy60+RfPbmNNo4585c6usLQi1YESPXcGFJy4Ow2CRxvJlSa8rhM4CuUB9vrcTv7Zog
         Z+SvPWy+XeKj6lFFlD45eSBPZrQOdWwR9U831mUcW8hrol0JMpUQYH5KVIWMmvo7+HWb
         qnB7Ma12V6sJETFmvWITmKXT83qHetMPxRoKRuugYUu7O0iOJ6gOwKaOFMo2ijOlAfjE
         7l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757734650; x=1758339450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP93xN6gwLHr70Ds3prjvKvRcobCNOyB/BNk5HT+4PY=;
        b=g+c3GxMQTkzvc7Z5xJPoh2kbmecFWfxZrZH/+7hR5TqiyVGJh7Iuw9LrsMm7OvJyaR
         uPKNsUeu4feVVG11VfRigJhvVjqODP16tVB1unx5wjEW08dDvBIRoyTxhFUsoIGHiD+L
         AoApIb+7yVRq73JNj2gyQ4LwXBclvcQSLiyhZfA1hoDZexhTS0Gu3DEqCUEkLRJt8+VJ
         BMxvktvbqS2uONXrZGFiJCFlQpyOGco2Ve1DgkCb91WPbBZ1og6q1SBAPjcGOFuwwrgg
         uLI6jgu0JySwHE532aqe3dBO6LpEsCdVq+S2CX9fgMNYnl65vEAFCH8AR4PcXBxtxHbr
         K22Q==
X-Forwarded-Encrypted: i=1; AJvYcCUD3Fbpa0vi/2ZOlO1YRV7UoJkTXdYo8uVkc18A2u51qzrDCToZzYklLdrlS+xZJ/hKqoaVHmfFamon4S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxK2uJC0nhlEGSWIeyw/3hgQ2g6WbgB3uZ2CGFBP8Uw/rVVo5
	jA4H3k2RuIHTNo34jlVnsHPOnfjXkFwW2mKv/S/XMdEeELEjvYschPM5
X-Gm-Gg: ASbGncvstkzYKUGZfIS216DIxhc2VKz1g3ZnOypwu3Su8r8pQGLjoriKB0t+WQTgsCA
	sRjLektGCQzk+Xx2laAJBTBqYyZFWwiSK72X1/lNzO9WBUogbYp27deQIXg1oKe5ezc1UT7QwBK
	qG0cx4ihMoJprC6umnfZ7ojqea66ancod8mWvP6QtCPgUIRBsdb6i3VBMkwFWElLRiYsgRZZds6
	Pe4YuYKU3ZrouAnO9BDH43nE2CY68xZpeG1j6xZHa1+H/iAwy3NdEAdbC5X/zhjlJ0sXd6sNDA3
	M1/5N8IElVqHC/AZ+UVOxzzgHRihjx+JPqQZkTEsQ9vuGjkREWQ0cop2vYHY6Cd49lg2EqFJZmN
	11bsboPervDhQUIoSYYGXNE0cLLgOtVhZPLohj6CzvuSTgPjMDyedSiQ=
X-Google-Smtp-Source: AGHT+IFUutBth5XkTwW1pC/OkCDAZih9KHUCMdYgxnZ59EYAd9MvBO/hHD+Z59SU25Og0yzU16T+xQ==
X-Received: by 2002:a05:6a21:6da7:b0:24e:e270:2f55 with SMTP id adf61e73a8af0-2602c14caccmr5977282637.35.1757734649906;
        Fri, 12 Sep 2025 20:37:29 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b439asm7150770a91.15.2025.09.12.20.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 20:37:29 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: hch@infradead.org,
	brauner@kernel.org
Cc: djwong@kernel.org,
	yi.zhang@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
Date: Sat, 13 Sep 2025 11:37:15 +0800
Message-ID: <20250913033718.2800561-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250913033718.2800561-1-alexjlzheng@tencent.com>
References: <20250913033718.2800561-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

iomap_folio_state marks the uptodate state in units of block_size, so
it is better to check that pos and length are aligned with block_size.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..0c38333933c6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
+	WARN_ON(*pos & (block_size - 1));
+	WARN_ON(length & (block_size - 1));
+
 	/*
 	 * If the block size is smaller than the page size, we need to check the
 	 * per-block uptodate status and adjust the offset and length if needed
-- 
2.49.0


